{*********************************************}
{  TeeChart Storage functions                 }
{  Copyright (c) 1997-2004 by David Berneda   }
{  All rights reserved                        }
{*********************************************}
unit TeeStore;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     TeeProcs, TeEngine, Chart;

{ Read a Chart from a file (example: Chart1,'c:\demo.tee' ) }
Procedure LoadChartFromFile(Var AChart:TCustomChart; Const AFileName:String);

{ Write a Chart to a file (example: Chart1,'c:\demo.tee' ) }
Procedure SaveChartToFile(AChart:TCustomChart; Const AFileName:String;
                          IncludeData:Boolean=True;
                          TextFormat:Boolean=False);

{ The same using TStream components (good for BLOB fields, etc)  }
Procedure LoadChartFromStream(Var AChart:TCustomChart; AStream:TStream);

Procedure SaveChartToStream(AChart:TCustomChart; AStream:TStream;
                            IncludeData:Boolean=True;
                            TextFormat:Boolean=False);

{ (Advanced) Read charts and check for errors  }
{ return True if ok, False to stop loading }
type TProcTeeCheckError=function(const Message: string): Boolean of object;

Procedure LoadChartFromStreamCheck( Var AChart:TCustomChart;
                                    AStream:TStream;
                                    ACheckError:TProcTeeCheckError=nil;

                                    // For compatibility with version 5 saved
                                    // charts.
                                    // Pass FALSE to skip past-reading
                                    TryReadData:Boolean=True  // 6.01
                               );

Procedure LoadChartFromFileCheck( Var AChart:TCustomChart;
                                  Const AName:String;
                                  ACheckError:TProcTeeCheckError
                                  );

// Convert a binary *.tee file to text format
Procedure ConvertTeeFileToText(Const InputFile,OutputFile:String);

// Convert a text *.tee file to binary format
Procedure ConvertTeeFileToBinary(Const InputFile,OutputFile:String);

type
  TSeriesData=class(TTeeExportData)
  private
    FIncludeColors : Boolean;
    FIncludeIndex  : Boolean;
    FIncludeHeader : Boolean;
    FIncludeLabels : Boolean;
    FChart         : TCustomChart;
    FSeries        : TChartSeries;

    IFormat        : TeeFormatFlag;
    Procedure Prepare;
  protected
    Procedure GuessSeriesFormat; virtual;
    Function MaxSeriesCount:Integer;
    Function PointToString(Index:Integer):String; virtual;
  public
    Constructor Create(AChart:TCustomChart; ASeries:TChartSeries=nil); virtual;

    Function AsString:String; override;

    property Chart:TCustomChart read FChart write FChart;
    property IncludeColors:Boolean read FIncludeColors write FIncludeColors default False;
    property IncludeHeader:Boolean read FIncludeHeader write FIncludeHeader default False;
    property IncludeIndex:Boolean read FIncludeIndex write FIncludeIndex default False;
    property IncludeLabels:Boolean read FIncludeLabels write FIncludeLabels default True;
    property Series:TChartSeries read FSeries write FSeries;
  end;

  TSeriesDataText=class(TSeriesData)
  private
    FTextDelimiter : {$IFDEF CLX}WideChar{$ELSE}Char{$ENDIF};
    FTextQuotes    : String;
    FValueFormat   : String;
  protected
    procedure GuessSeriesFormat; override;  // 7.0
    Function PointToString(Index:Integer):String; override;
  public
    Constructor Create(AChart:TCustomChart;
                       ASeries:TChartSeries=nil); override;
    Function AsString:String; override;

    property TextDelimiter:{$IFDEF CLX}WideChar{$ELSE}Char{$ENDIF}
           read FTextDelimiter write FTextDelimiter default TeeTabDelimiter;
    property TextQuotes:String read FTextQuotes write FTextQuotes;  // 7.0
    property ValueFormat:String read FValueFormat write FValueFormat; // 7.0 #1249
  end;

  TSeriesDataXML=class(TSeriesData)
  private
    FEncoding : String;
    function DefaultEncoding:String;
    function IsEncodingStored:Boolean;
  public
    Constructor Create(AChart:TCustomChart; ASeries:TChartSeries=nil); override;
    Function AsString:String; override;
  published
    property Encoding:String read FEncoding write FEncoding stored IsEncodingStored;  // 7.0
    property IncludeHeader default True;
  end;

  TSeriesDataHTML=class(TSeriesData)
  protected
    Function PointToString(Index:Integer):String; override;
  public
    Function AsString:String; override;
  end;

  TSeriesDataXLS=class(TSeriesData)
  public
    Procedure SaveToStream(AStream:TStream); override;
  end;

Const TeeTextLineSeparator= #13#10;

// Makes sure AFileName contains the ".tee" extension
Function TeeCheckExtension(Const AFileName:String):String;

implementation

Uses {$IFDEF CLX}
     QGraphics, QClipbrd,
     {$ELSE}
     Graphics, Clipbrd,
     {$ENDIF}
     SysUtils,
     TeCanvas, TeeConst;

Const MagicTeeFile  =$3060;
      {$IFDEF D7}
      VersionTeeFile=$0157; { Delphi 7 }
      {$ELSE}
      {$IFDEF CLX}
      VersionTeeFile=$0145; { Delphi 6 CLX / Kylix }
      {$ELSE}
      {$IFDEF D6}
      VersionTeeFile=$0150; { Delphi 6 }
      {$ELSE}
      {$IFDEF C5}
      VersionTeeFile=$0140; { C++ Builder 5 }
      {$ELSE}
      {$IFDEF D5}
      VersionTeeFile=$0130; { Delphi 5 }
      {$ELSE}
      {$IFDEF C4}
      VersionTeeFile=$0125; { C++ Builder 4 }
      {$ELSE}
      {$IFDEF D4}
      VersionTeeFile=$0120; { Delphi 4 }
      {$ELSE}
      {$IFDEF C3}
      VersionTeeFile=$0110; { C++ Builder 3 }
      {$ELSE}
      VersionTeeFile=$0100; { Delphi 3 }
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}


type
  TTeeFileHeader=Packed Record
    Magic   : Word; { secure checking }
    Version : Word; { Chart file version }
  end;

  TSeriesAccess=class(TChartSeries);

// compatibility with previous versions saved *.tee files
Procedure ReadChartData(AStream:TStream; AChart:TCustomChart);
Var t : Integer;
begin { read each Series data }
  for t:=0 to AChart.SeriesCount-1 do TSeriesAccess(AChart[t]).ReadData(AStream);
end;

{ Special reader to skip Delphi 3 or 4 new properties when
  reading Charts in Delphi 1.0 or 2.0 }
type 
  TChartReader=class(TReader)
  protected
    procedure FindMethodEvent(Reader: TReader; const MethodName: string;
                              var Address: {$IFDEF CLR}TMethodCode{$ELSE}Pointer{$ENDIF};
                              var Error: Boolean);
    function Error(const Message: string): Boolean; override;
  public
    CheckError:TProcTeeCheckError;
  end;

function TChartReader.Error(const Message: string): Boolean;
begin
  if Assigned(CheckError) then result:=CheckError(Message)
                          else result:=True;
end;

procedure TChartReader.FindMethodEvent(Reader: TReader; const MethodName: string;
                                       var Address: {$IFDEF CLR}TMethodCode{$ELSE}Pointer{$ENDIF}; 
                                       var Error: Boolean);
begin
  Error:=False;
end;

Procedure ReadHeader(Stream:TStream; var Header: TTeeFileHeader);
begin
  {$IFDEF CLR}
  Stream.Read(Header.Magic,SizeOf(Header.Magic));
  Stream.Read(Header.Version,SizeOf(Header.Version));
  {$ELSE}
  Stream.Read(Header,SizeOf(Header));
  {$ENDIF}
end;

function TeeFileIsValid(Stream:TStream):Boolean;
var Pos    : Integer;
    Header : TTeeFileHeader;
begin
  Pos := Stream.Position;
  ReadHeader(Stream,Header);
  { check is a valid Tee file }
  result:=Header.Magic=MagicTeeFile;
  if not result then
     result:={$IFDEF CLR}AnsiChar{$ELSE}Char{$ENDIF}(Header.Magic) in ['o','O'];
  Stream.Position := Pos;
end;

function TeeFileIsBinary(Stream:TStream):Boolean;
var Pos : Integer;
    Header  : TTeeFileHeader;
begin
  Pos := Stream.Position;
  ReadHeader(Stream,Header);
  { check is a valid Tee file }
  result:=Header.Magic=MagicTeeFile;
  Stream.Position := Pos;
end;

Procedure TeeWriteHeader(AStream:TStream);
var Header  : TTeeFileHeader;
begin
  { write file header, with "magic" number and version }
  Header.Magic:=MagicTeeFile;
  Header.Version:=VersionTeeFile;
  {$IFDEF CLR}
  AStream.Write(Header.Magic,SizeOf(Header.Magic));
  AStream.Write(Header.Version,SizeOf(Header.Version));
  {$ELSE}
  AStream.Write(Header,SizeOf(Header));
  {$ENDIF}
end;

Procedure ConvertTeeToBinary(SInput,SOutput:TStream);
begin
  if TeeFileIsValid(SInput) then
  begin
    if not TeeFileIsBinary(SInput) then
    begin
      TeeWriteHeader(SOutput);
      ObjectTextToBinary(SInput,SOutput);
    end
    else
       SOutput.CopyFrom(SInput,SInput.Size);
  end
  else Raise ChartException.Create(TeeMsg_WrongTeeFileFormat); { 5.01 }
end;

Procedure ConvertTeeToText(SInput,SOutput:TStream);
var Header  : TTeeFileHeader;
begin
  if TeeFileIsValid(SInput) then
  begin
    if TeeFileIsBinary(SInput) then
    begin
      ReadHeader(SInput,Header);
      ObjectBinaryToText(SInput,SOutput);
    end
    else SOutput.CopyFrom(SInput,SInput.Size);
  end
  else Raise ChartException.Create(TeeMsg_WrongTeeFileFormat); { 5.01 }
end;

{ Reads Series and Points from a Stream into a Chart }
Procedure LoadChartFromStreamCheck( Var AChart:TCustomChart;
                                    AStream:TStream;
                                    ACheckError:TProcTeeCheckError=nil;
                                    TryReadData:Boolean=True);
var Reader  : TChartReader;
    tmp     : TCustomChart;
    tmpName : TComponentName;
    DestStream : TStream;
    Header  : TTeeFileHeader;
begin

  { 5.01 commented: This allows saving more things to the AStream
                    before calling here.
  AStream.Position:=0; <--- commented out
  }

  if AStream.Size=0 then
     raise ChartException.Create(TeeMsg_EmptyTeeFile);

  if TeeFileIsValid(AStream) then
  begin
    { disable auto-repaint }
    AChart.AutoRepaint:=False;

    { remove all child Series and Tools }
    AChart.FreeAllSeries;
    AChart.Tools.Clear;

    DestStream:=AStream;

    if not TeeFileIsBinary(AStream) then
    begin
      AStream:=TMemoryStream.Create;
      ConvertTeeToBinary(DestStream,AStream);
      AStream.Position:=0;
    end;

    ReadHeader(AStream,Header);

    { read the Chart, Series and Tools properties }
    Reader:=TChartReader.Create(AStream, 4096);
    try
      Reader.OnFindMethod:=Reader.FindMethodEvent;

      Reader.CheckError:=ACheckError;
      tmp:=AChart;
      try
        tmpName:=tmp.Name; { 5.01 preserve the Chart Name }
        Reader.ReadRootComponent(AChart);
      finally
        AChart:=tmp;
      end;

      if tmpName<>'' then
         AChart.Name:=tmpName; { 5.01 set back the same Chart Name }
    finally
      Reader.Free;
    end;

    if Assigned(AChart) then
    begin
      // compatibility with previous versions saved *.tee files
      // read the Series points
      if TryReadData and (AStream.Size>AStream.Position) then
         ReadChartData(AStream,AChart);

      (*
      { change each Series ownership }
      { 5.01 Doing this breaks TeeFunction objects as DataSource !! }
      if AChart.Owner<>nil then
      for t:=0 to AChart.SeriesCount-1 do
      begin
        AChart[t].Owner.RemoveComponent(AChart[t]);
        AChart.Owner.InsertComponent(AChart[t]);
      end;
      *)

      { restore AutoRepaint }
      AChart.AutoRepaint:=True;
      AChart.Invalidate;
    end
    else raise ChartException.Create(TeeMsg_InvalidTeeFile);

    if DestStream<>AStream then AStream.Free;
  end
  else { is the Stream.Position maybe not zero ? }
    raise ChartException.Create(TeeMsg_WrongTeeFileFormat);
end;

Procedure LoadChartFromStream(Var AChart:TCustomChart; AStream:TStream);
begin
  LoadChartFromStreamCheck(AChart,AStream);
end;

Function TeeCheckExtension(Const AFileName:String):String;
begin  // Append ".tee" to filename if the extension is missing
  if ExtractFileExt(AFileName)='' then
     result:=AFileName+'.'+TeeMsg_TeeExtension
  else
     result:=AFileName;
end;

Procedure LoadChartFromFileCheck( Var AChart:TCustomChart;
                                  Const AName:String;
                                  ACheckError:TProcTeeCheckError );
Var tmp : TFileStream;
begin
  tmp:=TFileStream.Create(TeeCheckExtension(AName),fmOpenRead or fmShareDenyWrite);
  try
    LoadChartFromStreamCheck(AChart,tmp,ACheckError);
  finally
    tmp.Free;
  end;
end;

Procedure LoadChartFromFile(Var AChart:TCustomChart; Const AFileName:String);
begin
  LoadChartFromFileCheck(AChart,AFileName,nil);
end;

Procedure ConvertTeeFile(Const InputFile,OutputFile:String; ToText:Boolean);
var SInput  : TFileStream;
    SOutput : TFileStream;
begin
  SInput:=TFileStream.Create(InputFile,fmOpenRead);
  try
    SOutput:=TFileStream.Create(OutputFile,fmCreate);
    try
      if ToText then ConvertTeeToText(SInput,SOutput)
                else ConvertTeeToBinary(SInput,SOutput);
    finally
      SOutput.Free;
    end;
  finally
    SInput.Free;
  end;
end;

{ Create a text file from a binary *.tee file }
Procedure ConvertTeeFileToText(Const InputFile,OutputFile:String);
begin
  ConvertTeeFile(InputFile,OutputFile,True);
end;

{ Create a binary file from a text *.tee file }
Procedure ConvertTeeFileToBinary(Const InputFile,OutputFile:String);
begin
  ConvertTeeFile(InputFile,OutputFile,False);
end;

{
Procedure WriteChartData(AStream:TStream; AChart:TCustomChart);
Var t : Integer;
begin
  for t:=0 to AChart.SeriesCount-1 do TSeriesAccess(AChart[t]).WriteData(AStream);
end;
}

{$IFDEF D5}
type
  {$IFDEF CLR}
  TWriterAccess=class(TWriter)
  protected
    procedure DoSetRoot(Value: TComponent);
  end;

procedure TWriterAccess.DoSetRoot(Value: TComponent);
begin
  SetRoot(Value);
end;

  {$ELSE}
  TWriterAccess=class(TWriter);
  {$ENDIF}

{$ENDIF}

Procedure SaveChartToStream(AChart:TCustomChart; AStream:TStream;
                            IncludeData:Boolean=True;
                            TextFormat:Boolean=False);
var tmp      : TCustomChart;
    OldName  : TComponentName;
    {$IFDEF D5}
    Writer   : {$IFDEF CLR}TWriterAccess{$ELSE}TWriter{$ENDIF};
    tmpOwner : TComponent;
    {$ENDIF}
    DestStream : TStream;
    t          : Integer;
    tmpSeries  : TChartSeries;
begin
  DestStream:=AStream;

  if TextFormat then AStream:=TMemoryStream.Create;

  TeeWriteHeader(AStream);

  { write the Chart, Series and Tools properties }
  tmp:=AChart;
  if not (csDesigning in AChart.ComponentState) then
  begin
    OldName:=AChart.Name;
    AChart.Name:='';
  end;

  for t:=0 to AChart.SeriesCount-1 do
  begin
    tmpSeries:=AChart[t];
    if IncludeData then
        TSeriesAccess(tmpSeries).ForceSaveData:=True
    else
        TSeriesAccess(tmpSeries).DontSaveData:=True;
  end;

  try
    {$IFDEF D5}
    Writer := {$IFDEF CLR}TWriterAccess{$ELSE}TWriter{$ENDIF}.Create(AStream, 4096);
    try
      tmpOwner:=AChart.Owner;
      if not Assigned(tmpOwner) then tmpOwner:=AChart;

      {$IFDEF CLR}
      Writer.DoSetRoot(tmpOwner);  { 5.01 }
      {$ELSE}
      TWriterAccess(Writer).SetRoot(tmpOwner);  { 5.01 }
      {$ENDIF}

      Writer.WriteSignature;
      Writer.WriteComponent(AChart);
    finally
      Writer.Free;
    end;
    {$ELSE}
    AStream.WriteComponent(AChart);
    {$ENDIF}

  finally
    for t:=0 to AChart.SeriesCount-1 do
    begin
      tmpSeries:=AChart[t];
      TSeriesAccess(tmpSeries).ForceSaveData:=False;
      TSeriesAccess(tmpSeries).DontSaveData:=False;
    end;
  end;

  AChart:=tmp;
  if not (csDesigning in AChart.ComponentState) then
     AChart.Name:=OldName;

  { write the Series data points }
  //if IncludeData then WriteChartData(AStream,AChart);

  if TextFormat then
  begin
    AStream.Position:=0;
    ConvertTeeToText(AStream,DestStream);
    AStream.Free;
  end;
end;

Procedure SaveChartToFile(AChart:TCustomChart; Const AFileName:String;
                          IncludeData:Boolean=True;
                          TextFormat:Boolean=False);
Var tmp : TFileStream;
begin
  tmp:=TFileStream.Create(TeeCheckExtension(AFileName),fmCreate);
  try
    SaveChartToStream(AChart,tmp,IncludeData,TextFormat);
  finally
    tmp.Free;
  end;
end;

Function ColorToHex(Color:TColor):String;
begin
  with RGBValue(ColorToRGB(Color)) do
    result:=Format('#%.2x%.2x%.2x',[rgbtRed,rgbtGreen,rgbtBlue]);
end;

{ TSeriesData }
Constructor TSeriesData.Create(AChart:TCustomChart; ASeries:TChartSeries=nil);
begin
  inherited Create;
  FChart:=AChart;
  FSeries:=ASeries;
  FIncludeLabels:=True;
end;

Procedure TSeriesData.GuessSeriesFormat;
var tmp : TChartSeries;
begin
  if Assigned(FSeries) then tmp:=FSeries
                       else if FChart.SeriesCount>0 then tmp:=Chart[0]
                                                    else tmp:=nil;
  if Assigned(tmp) then IFormat:=SeriesGuessContents(tmp);
end;

Procedure TSeriesData.Prepare;
begin
  GuessSeriesFormat;
  if not IncludeLabels then Exclude(IFormat,tfLabel);
  if not IncludeColors then Exclude(IFormat,tfColor);
end;

Function TSeriesData.AsString:String;
Var tmp : Integer;
    t   : Integer;
begin
  Prepare;
  result:='';
  tmp:=MaxSeriesCount;
  for t:=0 to tmp-1 do result:=result+PointToString(t)+TeeTextLineSeparator;
end;

Function TSeriesData.MaxSeriesCount:Integer;
var t : Integer;
begin
  if Assigned(FSeries) then result:=FSeries.Count
  else
  begin
    result:=-1;
    for t:=0 to FChart.SeriesCount-1 do
    if (result=-1) or (FChart[t].Count>result) then
       result:=FChart[t].Count;
  end;
end;

function TSeriesData.PointToString(Index: Integer): String;
begin
  result:='';
end;

{ TSeriesDataText }
Constructor TSeriesDataText.Create(AChart:TCustomChart;
                         ASeries: TChartSeries=nil); { 5.01 }
begin
  inherited;
  FTextDelimiter:=TeeTabDelimiter;
  FTextQuotes:='';
end;

function TSeriesDataText.AsString: String;

  Function Header:String;

    Function HeaderSeries(ASeries:TChartSeries):String;

      Procedure AddToResult(const S:String);
      begin
        if result='' then result:=TextQuotes+S+TextQuotes
                     else result:=result+TextDelimiter+TextQuotes+S+TextQuotes;
      end;

    var t : Integer;
    begin
      result:='';
      With ASeries do
      begin
        if tfNoMandatory in IFormat then
           result:=TextQuotes+NotMandatoryValueList.Name+TextQuotes;

        if ValuesList.Count=2 then
           AddToResult(SeriesTitleOrName(ASeries))
        else
        begin
          AddToResult(MandatoryValueList.Name);
          for t:=2 to ValuesList.Count-1 do
              AddToResult(ValuesList[t].Name);
        end;
      end;
    end;

  var t : Integer;
  begin
    if IncludeIndex then result:=TextQuotes+TeeMsg_Index+TextQuotes
                    else result:='';

    if tfLabel in IFormat then
    begin
      if result<>'' then result:=result+TextDelimiter;
      result:=result+TextQuotes+TeeMsg_Text+TextQuotes;
    end;

    if tfColor in IFormat then
    begin
      if result<>'' then result:=result+TextDelimiter;
      result:=result+TextQuotes+TeeMsg_Colors+TextQuotes;
    end;

    if result<>'' then result:=result+TextDelimiter;

    if Assigned(Series) then result:=result+HeaderSeries(Series)
    else
    if Chart.SeriesCount>0 then
    begin
      result:=result+HeaderSeries(Chart[0]);
      for t:=1 to Chart.SeriesCount-1 do
          result:=result+TextDelimiter+HeaderSeries(Chart[t]);
    end;
  end;

Begin
  Prepare;

  if IncludeHeader then result:=Header+TeeTextLineSeparator
                   else result:='';
  result:=result+inherited AsString+TeeTextLineSeparator;
end;

procedure TSeriesDataText.GuessSeriesFormat;
var t : Integer;
    tmp : TeeFormatFlag;
begin
  inherited;

  if (not Assigned(Series)) and IncludeLabels and (not (tfLabel in IFormat)) then
  for t:=0 to Chart.SeriesCount-1 do
  begin
    tmp:=SeriesGuessContents(Chart[t]);
    if tfLabel in tmp then
    begin
      Include(IFormat, tfLabel);
      break;
    end;
  end;
end;

function TSeriesDataText.PointToString(Index: Integer): String;

  Procedure Add(Const St:String);
  begin
    if result='' then result:=St
                 else result:=result+TextDelimiter+St;
  end;

var tmpNum : Integer;

  Procedure DoSeries(ASeries:TChartSeries);

    Function ValueToStr(ValueList:TChartValueList; Index:Integer):String;  // 6.02
    begin
      if ASeries.Count>Index then
         if ValueList.DateTime then
            result:=TextQuotes+DateTimeToStr(ValueList.Value[Index])+TextQuotes
         else
         if FValueFormat='' then
            result:=FloatToStr(ValueList.Value[Index])
         else
            result:=FormatFloat(FValueFormat,ValueList.Value[Index])
      else
         result:='';
    end;

    Function FirstSeriesLabel(Index:Integer):String;  // 7.0
    var t : Integer;
    begin
      result:='';

      if Assigned(Series) then
      begin
        if Series.Count>Index then result:=Series.Labels[Index];
      end
      else
      for t:=0 to Chart.SeriesCount-1 do
        if Chart[t].Count>Index then
        begin
          result:=Chart[t].Labels[Index];
          if result<>'' then break;
        end;

      if result<>'' then result:=TextQuotes+result+TextQuotes;
    end;

  Var tt : Integer;
  begin
    { current number of exported Series }
    Inc(tmpNum);

    { the point Label text, if exists, and only for first Series }
    if (tmpNum=1) and (tfLabel in IFormat) then
       Add(FirstSeriesLabel(Index));

    { the point Color,  if exists, and only for first Series }
    if (tmpNum=1) and (tfColor in IFormat) then
       if ASeries.Count>Index then Add(ColorToHex(ASeries.ValueColor[Index]))
                              else Add(ColorToHex(clTeeColor));

    { the "X" point value, if exists }
    if tfNoMandatory in IFormat then
       Add(ValueToStr(ASeries.NotMandatoryValueList,Index));

    { the "Y" point value }
    Add(ValueToStr(ASeries.MandatoryValueList,Index));

    { write the rest of values (always) }
    for tt:=2 to ASeries.ValuesList.Count-1 do
        result:=result+TextDelimiter+ValueToStr(ASeries.ValuesList[tt],Index);
  end;

var t : Integer;
begin
  { Point number? }
  if IncludeIndex then Str(Index,result) else result:='';

  { Export Series data }
  tmpNum:=0;
  if Assigned(Series) then DoSeries(Series)
  else
  for t:=0 to Chart.SeriesCount-1 do DoSeries(Chart[t]);
end;

{ TSeriesDataXML }
constructor TSeriesDataXML.Create(AChart: TCustomChart;
  ASeries: TChartSeries);
begin
  inherited;
  FIncludeHeader:=True;
  FEncoding:=DefaultEncoding;
end;

function TSeriesDataXML.DefaultEncoding:String;
begin
  {$IFNDEF LINUX}
  if SysLocale.PriLangID=LANG_JAPANESE then
     result:='shift_jis'
  else
  {$ENDIF}
     result:='ISO-8859-1';
end;

function TSeriesDataXML.IsEncodingStored:Boolean;
begin
  result:=(Encoding<>'') and (Encoding<>DefaultEncoding);
end;

Function TSeriesDataXML.AsString:String;

  Function SeriesPoints(ASeries:TChartSeries):String;

    Function GetPointString(Index:Integer):String;

      Procedure AddResult(Const St:String);
      begin
        if result='' then result:=St else result:=result+St;
      end;

      Function Get(AList:TChartValueList):String;
      begin
        with AList do
             result:=' '+Name+'="'+FloatToStr(Value[Index])+'"';
      end;

    var tt : Integer;
    begin
      if IncludeIndex then result:='index="'+TeeStr(Index)+'"'
                      else result:='';

      With ASeries do
      begin
        { the point Label text, if exists }
        if tfLabel in IFormat then result:=result+' text="'+Labels[Index]+'"';

        { the point Color, if exists }
        if tfColor in IFormat then
           result:=result+' color="'+ColorToHex(ValueColor[Index])+'"';

        { the "X" point value, if exists }
        if tfNoMandatory in IFormat then AddResult(Get(NotMandatoryValueList));

        { the "Y" point value }
        AddResult(Get(MandatoryValueList));

        { write the rest of values (always) }
        for tt:=2 to ValuesList.Count-1 do result:=result+Get(ValuesList[tt]);
      end;
    end;

  var t : Integer;
  begin
    result:='';
    if ASeries.Count>0 then
       for t:=0 to ASeries.Count-1 do
           result:=result+'<point '+GetPointString(t)+'/>'+TeeTextLineSeparator;
  end;

  Function XMLSeries(ASeries:TChartSeries):String;
  begin
    result:=
          '<series title="'+SeriesTitleOrName(ASeries)+'" type="'+
          GetGallerySeriesName(ASeries)+'" color="'+
          ColorToHex(ASeries.Color)+'">'+TeeTextLineSeparator+
          '<points count="'+TeeStr(ASeries.Count)+'">'+TeeTextLineSeparator+
          SeriesPoints(ASeries)+
          '</points>'+TeeTextLineSeparator+
          '</series>'+TeeTextLineSeparator+TeeTextLineSeparator;
  end;

var t : Integer;
begin
  Prepare; { 5.02 }
  if IncludeHeader then
  begin
    result:='<?xml version="1.0"';
    if Encoding<>'' then
       result:=result+' encoding="'+Encoding+'"';

    result:=result+'?>'+TeeTextLineSeparator;
  end
  else
     result:='';

  if Assigned(FSeries) then result:=result+XMLSeries(FSeries)
  else
  begin
    result:=result+'<chart>'+TeeTextLineSeparator;
    for t:=0 to FChart.SeriesCount-1 do result:=result+XMLSeries(FChart[t]);
    result:=result+'</chart>';
  end;
end;

{ TSeriesDataHTML }
function TSeriesDataHTML.AsString: String;

  Function Header:String;

    Function HeaderSeries(ASeries:TChartSeries):String;

      Procedure AddCol(Const ColTitle:String);
      begin
        result:=result+'<td>'+ColTitle+'</td>'
      end;

    var t : Integer;
    begin
      result:='';
      if tfLabel in IFormat then AddCol(TeeMsg_Text);
      if tfColor in IFormat then AddCol(TeeMsg_Colors);

      With ASeries do
      begin
        if tfNoMandatory in IFormat then AddCol(NotMandatoryValueList.Name);

        if ValuesList.Count=2 then AddCol(SeriesTitleOrName(ASeries))
        else
        begin
          AddCol(MandatoryValueList.Name);
          for t:=2 to ValuesList.Count-1 do AddCol(ValuesList[t].Name);
        end;
      end;
    end;

  var t : Integer;
  begin
    result:='<tr>';
    if IncludeIndex then result:=result+'<td>'+TeeMsg_Index+'</td>';

    if Assigned(FSeries) then result:=result+HeaderSeries(FSeries)
    else
    for t:=0 to FChart.SeriesCount-1 do result:=result+HeaderSeries(FChart[t]);

    result:=result+'</tr>';
  end;

begin
  Prepare;
  result:='<table border="1">'+TeeTextLineSeparator;
  if IncludeHeader then result:=result+Header+TeeTextLineSeparator;
  result:=result+inherited AsString+TeeTextLineSeparator+'</table>';
end;

Function TSeriesDataHTML.PointToString(Index:Integer):String;

  Function GetPointString:String;

    Function GetPointStringSeries(ASeries:TChartSeries):String;

      Function CellDouble(Const Value:Double):String;
      begin
        result:='<td>'+FloatToStr(Value)+'</td>';
      end;

    Const EmptyCell='<td></td>';
    Var tt : Integer;
    begin
      result:='';
      With ASeries do
      if (Count-1)<Index then
      begin
        if tfLabel in IFormat then result:=result+EmptyCell;
        if tfColor in IFormat then result:=result+EmptyCell;
        if tfNoMandatory in IFormat then result:=result+EmptyCell;

        result:=result+EmptyCell;
        for tt:=2 to ValuesList.Count-1 do result:=result+EmptyCell;
      end
      else
      begin
        { the point Label text, if exists }
        if tfLabel in IFormat then result:=result+'<td>'+Labels[Index]+'</td>';

        { the point Label text, if exists }
        if tfColor in IFormat then
           result:=result+'<td>'+ColorToHex(ValueColor[Index])+'</td>';

        { the "X" point value, if exists }
        if tfNoMandatory in IFormat then
           result:=result+CellDouble(NotMandatoryValueList.Value[Index]);

        { the "Y" point value }
        result:=result+CellDouble(MandatoryValueList.Value[Index]);

        { write the rest of values (always) }
        for tt:=2 to ValuesList.Count-1 do
            result:=result+CellDouble(ValuesList[tt].Value[Index]);
      end;
    end;

  var t : Integer;
  begin
    if IncludeIndex then result:='<td>'+TeeStr(Index)+'</td>'
                    else result:='';

    if Assigned(FSeries) then result:=result+GetPointStringSeries(FSeries)
    else
    for t:=0 to FChart.SeriesCount-1 do
        result:=result+GetPointStringSeries(FChart[t])
  end;

begin
  result:='<tr>'+GetPointString+'</tr>';
end;

{ TSeriesDataXLS }
Procedure TSeriesDataXLS.SaveToStream(AStream:TStream);
var Buf : Array[0..4] of Word;
    Row : Integer;
    Col : Integer;

  Procedure WriteBuf(Value,Size:Word);
  begin
    {$IFDEF CLR}
    AStream.Write(Value);
    AStream.Write(Size);
    {$ELSE}
    Buf[0]:=Value;
    Buf[1]:=Size;
    AStream.Write(Buf,2*SizeOf(Word));
    {$ENDIF}
  end;

  Procedure WriteParams(Value,Size:Word);
  Const Attr:Array[0..2] of Byte=(0,0,0);
  begin
    WriteBuf(Value,Size+2*SizeOf(Word)+SizeOf(Attr));
    if IncludeHeader then WriteBuf(Row+1,Col)
                     else WriteBuf(Row,Col);
    {$IFDEF CLR}
    AStream.Write(Attr[0]);
    AStream.Write(Attr[1]);
    AStream.Write(Attr[2]);
    {$ELSE}
    AStream.Write(Attr,SizeOf(Attr));
    {$ENDIF}
  end;

  procedure WriteDouble(Const Value:Double);
  begin
    WriteParams(3,SizeOf(Double));
    {$IFDEF CLR}
    AStream.Write(Value);
    {$ELSE}
    AStream.WriteBuffer(Value,SizeOf(Double));
    {$ENDIF}
  end;

  procedure WriteText(Const Value:ShortString);
  {$IFDEF CLR}
  var l : Byte;
  {$ENDIF}
  begin
    WriteParams(4,Length(Value)+1);
    {$IFDEF CLR}
    l:=Length(Value);
    AStream.Write(l);
    AStream.Write(BytesOf(Value),l);
    {$ELSE}
    AStream.Write(Value,Length(Value)+1)
    {$ENDIF}
  end;

  procedure WriteNull;
  begin
    WriteParams(1,0);
  end;

  Procedure WriteHeaderSeries(ASeries:TChartSeries);
  var tt : Integer;
  begin
    if tfLabel in IFormat then
    begin
      WriteText(TeeMsg_Text);
      Inc(Col);
    end;

    if tfColor in IFormat then
    begin
      WriteText(TeeMsg_Colors);
      Inc(Col);
    end;

    if tfNoMandatory in IFormat then
    begin
      WriteText(ASeries.NotMandatoryValueList.Name);
      Inc(Col);
    end;

    for tt:=1 to ASeries.ValuesList.Count-1 do
    begin
      WriteText(ASeries.ValuesList[tt].Name);
      Inc(Col);
    end;
  end;

  Procedure WriteSeries(ASeries:TChartSeries);
  var tt : Integer;
  begin
    if (ASeries.Count-1)<Row then
    begin
      if tfLabel in IFormat then
      begin
        WriteText('');
        Inc(Col);
      end;

      if tfColor in IFormat then
      begin
        WriteText('');
        Inc(Col);
      end;

      if tfNoMandatory in IFormat then
      begin
        WriteNull;
        Inc(Col);
      end;

      for tt:=1 to ASeries.ValuesList.Count-1 do
      begin
        WriteNull;
        Inc(Col);
      end;
    end
    else
    begin
      if tfLabel in IFormat then
      begin
        WriteText(ASeries.Labels[Row]);
        Inc(Col);
      end;

      if tfColor in IFormat then
      begin
        WriteText(ColorToHex(ASeries.ValueColor[Row]));
        Inc(Col);
      end;

      if tfNoMandatory in IFormat then
      begin
        WriteDouble(ASeries.NotMandatoryValueList.Value[Row]);
        Inc(Col);
      end;

      if ASeries.IsNull(Row) then
      for tt:=1 to ASeries.ValuesList.Count-1 do
      begin
        WriteNull;
        Inc(Col);
      end
      else
      begin
        WriteDouble(ASeries.MandatoryValueList.Value[Row]);
        Inc(Col);
        for tt:=2 to ASeries.ValuesList.Count-1 do
        begin
          WriteDouble(ASeries.ValuesList[tt].Value[Row]);
          Inc(Col);
        end;
      end;
    end;
  end;

Const BeginExcel : Array[0..5] of Word=($809,8,0,$10,0,0);
      EndExcel   : Array[0..1] of Word=($A,0);
Var tt  : Integer;
    tmp : Integer;
begin
  Prepare;
  {$IFDEF CLR}
  AStream.Write(BeginExcel[0]); { begin and BIF v5 }
  AStream.Write(BeginExcel[1]);
  AStream.Write(BeginExcel[2]);
  AStream.Write(BeginExcel[3]);
  AStream.Write(BeginExcel[4]);
  AStream.Write(BeginExcel[5]);
  {$ELSE}
  AStream.WriteBuffer(BeginExcel,SizeOf(BeginExcel)); { begin and BIF v5 }
  {$ENDIF}

  WriteBuf($0200,5*SizeOf(Word));  { row x col }

  Buf[0]:=0;
  Buf[2]:=0;
  Buf[3]:=0; { columns }
  Buf[4]:=0;

  Buf[1]:=MaxSeriesCount; { rows }
  if IncludeHeader then Inc(Buf[1]);

  if IncludeIndex then Inc(Buf[3]);
  if Assigned(FSeries) then tmp:=1
                       else tmp:=FChart.SeriesCount;
  if tfLabel in IFormat then Inc(Buf[3],tmp);
  if tfColor in IFormat then Inc(Buf[3],tmp);
  if tfNoMandatory in IFormat then Inc(Buf[3],tmp);

  if Assigned(FSeries) then
     Inc(Buf[3],FSeries.ValuesList.Count-1)
  else
  for Row:=0 to FChart.SeriesCount-1 do
     Inc(Buf[3],FChart[Row].ValuesList.Count-1);

  {$IFDEF CLR}
  AStream.Write(Buf[0]);
  AStream.Write(Buf[1]);
  AStream.Write(Buf[2]);
  AStream.Write(Buf[3]);
  AStream.Write(Buf[4]);
  {$ELSE}
  AStream.Write(Buf,5*SizeOf(Word));
  {$ENDIF}

  if IncludeHeader then
  begin
    Row:=-1;
    Col:=0;
    if IncludeIndex then
    begin
      WriteText(TeeMsg_Index);
      Inc(Col);
    end;
    if Assigned(FSeries) then WriteHeaderSeries(FSeries)
    else
    for tt:=0 to FChart.SeriesCount-1 do WriteHeaderSeries(FChart[tt]);
  end;

  for Row:=0 to MaxSeriesCount-1 do
  begin
    Col:=0;
    if IncludeIndex then
    begin
      WriteDouble(Row);
      Inc(Col);
    end;

    if Assigned(FSeries) then WriteSeries(FSeries)
    else
    for tt:=0 to FChart.SeriesCount-1 do WriteSeries(FChart[tt]);
  end;

  {$IFDEF CLR}
  AStream.Write(EndExcel[0]); { end }
  AStream.Write(EndExcel[1]); { end }
  {$ELSE}
  AStream.WriteBuffer(EndExcel,SizeOf(EndExcel)); { end }
  {$ENDIF}
end;

{$IFNDEF TEEOCX}
type TChartChart=class(TChart) end;
     TODBCChart=class(TChartChart) end;
initialization
  RegisterClasses([TChartChart,TODBCChart]);
finalization
  UnRegisterClasses([TChartChart,TODBCChart]);  // 6.01
{$ENDIF}
end.

