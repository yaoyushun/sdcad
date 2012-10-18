{******************************************}
{  TeeChart Series DB Virtual DataSet      }
{ Copyright (c) 1996-2004 by David Berneda }
{          All Rights Reserved             }
{******************************************}
unit TeeData;
{$I TeeDefs.inc}

{ This unit contains a VIRTUAL TDATASET component.

  The TSeriesDataSet component is an intermediary between a
  Series component and a TDataSource.

  You can show Series values in a DBGrid, for example:

  SeriesDataSet1.Series := Series1;
  DataSource1.DataSet   := SeriesDataSet1;
  DBGrid1.DataSource    := DataSource1;

  To refresh data:

  SeriesDataSet1.Close;
  Series1.Add(....)
  SeriesDataSet1.Open;

  Additional information under Delphi \Demos\TextData example project.

  NOTE: This component is not available in Delphi and C++ Builder
        STANDARD versions, because they do not include Database components.

}
interface

uses DB, Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, TeeProcs;

Const MaxLabelLen=128;

type
  PFloat=^Double;
  PSeriesPoint=^TSeriesPoint;
  TSeriesPoint=packed record
    Color  : TColor;  { 4 bytes }
    X      : Double;  { 8 bytes }
    Values : Array[0..10] of Double; { 88 bytes }
    ALabel : String[MaxLabelLen];    { 128 bytes }
  end;

  PRecInfo = ^TRecInfo;
  TRecInfo = packed record
    Bookmark     : Integer;
    BookmarkFlag : TBookmarkFlag;
  end;

  TSeriesDataSet = class(TDataSet,ITeeEventListener)
  private
    FSeries       : TChartSeries;
    FBookMarks    : TList;
    FCurRec       : Integer;
    FLastBookmark : Integer;
    Procedure DoCreateField(Const AFieldName:String; AType:TFieldType; ASize:Integer);
    Function RecInfoOfs: Integer;
    Function RecBufSize: Integer;
    procedure TeeEvent(Event: TTeeEvent);
  protected
    { Overriden abstract methods (required) }
    function AllocRecordBuffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}; override;
    procedure FreeRecordBuffer(var Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}); override;
    {$IFDEF CLR}
    procedure GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark); override;
    {$ELSE}
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
    {$ENDIF}

    function GetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}): TBookmarkFlag; override;

    function GetRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function GetRecordSize: Word; override;
    procedure InternalAddRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark({$IFDEF CLR}const Bookmark:TBookmark{$ELSE}Bookmark: Pointer{$ENDIF}); override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInitRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalSetToRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}); override;
    function IsCursorOpen: Boolean; override;

    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;

    procedure SetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}; Value: TBookmarkFlag); override;

    {$IFDEF CLR}
    procedure SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark); override;
    {$ELSE}
    procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
    {$ENDIF}

    procedure SetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}); override;

    { Additional overrides (optional) }
    function GetRecordCount: Integer; override;
    function GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;
    Procedure SetSeries(ASeries:TChartSeries); virtual;
    Procedure AddSeriesPoint(Buffer:{$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF}; ABookMark:Integer); virtual;
  public
    function GetFieldData(Field: TField; Buffer: {$IFDEF CLR}TValueBuffer{$ELSE}Pointer{$ENDIF}): Boolean; override;
  published
    property Series: TChartSeries read FSeries write SetSeries stored True;
    property Active;
  end;

implementation

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils,
     {$IFDEF CLX}
     QForms,
     {$ELSE}
     Forms,
     {$ENDIF}
     TeeConst, TeCanvas;

{ TSeriesDataSet }

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Procedure TSeriesDataSet.SetSeries(ASeries:TChartSeries);
Var WasActive : Boolean;
begin
  WasActive:=Active;
  Active:=False;

  if Assigned(FSeries) then
  begin
    {$IFDEF D5}
    FSeries.RemoveFreeNotification(Self);
    {$ENDIF}

    if Assigned(FSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FSeries.ParentChart).RemoveListener(Self);
  end;

  FSeries:=ASeries;

  if Assigned(FSeries) then
  begin
    FSeries.FreeNotification(Self);
    if Assigned(FSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FSeries.ParentChart).Listeners.Add(Self);
  end;

  if Assigned(FSeries) and WasActive then Active:=True;
end;

procedure TSeriesDataSet.Notification( AComponent: TComponent;
                            Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FSeries) and (AComponent=FSeries) then
     Series:=nil;
end;

Function TSeriesDataSet.RecInfoOfs:Integer;
begin
  result:= SizeOf(TSeriesPoint);
end;

Function TSeriesDataSet.RecBufSize: Integer;
begin
  result:=RecInfoOfs + SizeOf(TRecInfo);
end;

procedure TSeriesDataSet.InternalOpen;
var I: Integer;
begin
  if not Assigned(FSeries) then
     Raise Exception.Create('Cannot open SeriesDataSet. No Series assigned.');
  { Fabricate integral bookmark values }
  FBookMarks:=TList.Create;
  for I:=1 to FSeries.Count do FBookMarks.Add({$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}(I));
  FLastBookmark:=FSeries.Count;

  FCurRec:=-1;

  BookmarkSize := SizeOf(Integer);

  InternalInitFieldDefs;
  if DefaultFields then CreateFields;
  BindFields(True);
end;

procedure TSeriesDataSet.InternalClose;
begin
  {$IFDEF D5}
  FreeAndNil(FBookMarks);
  {$ELSE}
  FBookMarks.Free;
  FBookMarks:=nil;
  {$ENDIF}
  if DefaultFields then DestroyFields;
  FLastBookmark := 0;
  FCurRec := -1;
end;

function TSeriesDataSet.IsCursorOpen: Boolean;
begin
  Result:=Assigned(FSeries) and Assigned(FBookMarks);
end;

Procedure TSeriesDataSet.DoCreateField(Const AFieldName:String; AType:TFieldType; ASize:Integer);
begin
  {$IFDEF C3D4}
  With TFieldDef.Create(FieldDefs) do
  begin
    Name      := AFieldName;
    Size      := ASize;
    Required  := False;
    DataType  := AType;
  end;
  {$ELSE}
  TFieldDef.Create(FieldDefs, AFieldName, AType, ASize, False, FieldDefs.Count+1)
  {$ENDIF}
end;

procedure TSeriesDataSet.InternalInitFieldDefs;

  Function GetFieldName(Const ADefault,AName:String):String;
  begin
    if AName='' then result:=ADefault
                else result:=AName;
  end;

  Procedure AddField(IsDateTime:Boolean; Const FieldName:String);
  begin
    if IsDateTime then DoCreateField(FieldName,ftDateTime,0)
                  else DoCreateField(FieldName,ftFloat,0);
  end;

var tmp:String;
    t:Integer;
begin
  FieldDefs.Clear;
  if Assigned(FSeries) then
  begin
    {$IFDEF C3D4}
    With TFieldDef.Create(FieldDefs) do
    begin
      Name:='Color';
      DataType:=ftInteger;
      Size:=0;
      Required:=False;
      FieldNo:=1;
    end;
    {$ELSE}
    TFieldDef.Create(FieldDefs, 'Color', ftInteger, 0, False, 1);
    {$ENDIF}
    With FSeries.XValues do AddField(DateTime,GetFieldName('X',Name));
    With FSeries.YValues do AddField(DateTime,GetFieldName('Y',Name));
    {$IFDEF C3D4}
    With TFieldDef.Create(FieldDefs) do
    begin
      Name:='Label';
      DataType:=ftString;
      Size:=MaxLabelLen;
      Required:=False;
      FieldNo:=4;
    end;
    {$ELSE}
    TFieldDef.Create(FieldDefs, 'Label', ftString, MaxLabelLen, False, 4);
    {$ENDIF}
    for t:=2 to FSeries.ValuesList.Count-1 do
    With FSeries.ValuesList[t] do
    begin
      tmp:=Name;
      if Name='' then tmp:='Value'+TeeStr(t)
                 else tmp:=Name;
      AddField(DateTime,tmp);
    end;
  end;
end;

procedure TSeriesDataSet.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TSeriesDataSet.InternalGotoBookmark({$IFDEF CLR}const Bookmark:TBookmark{$ELSE}Bookmark: Pointer{$ENDIF});
var Index: Integer;
begin
  Index := FBookMarks.IndexOf({$IFDEF CLR}Bookmark{$ELSE}Pointer(PInteger(Bookmark)^){$ENDIF});
  if Index <> -1 then
     FCurRec := Index
  else
     DatabaseError('Bookmark not found');
end;

procedure TSeriesDataSet.InternalSetToRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF});
begin
  {$IFDEF CLR}
  InternalGotoBookmark(TRecordBuffer(Longint(Buffer) + FBookmarkOfs));
  {$ELSE}
  InternalGotoBookmark(@PRecInfo(Buffer + RecInfoOfs).Bookmark);
  {$ENDIF}
end;

function TSeriesDataSet.GetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}): TBookmarkFlag;
begin
  {$IFDEF CLR}
  with Marshal do
    Result := TBookmarkFlag(ReadByte(Buffer, FRecInfoOfs + 5)); // TRecInfo.BookmarkFlag
  {$ELSE}
  Result := PRecInfo(Buffer + RecInfoOfs).BookmarkFlag;
  {$ENDIF}
end;

procedure TSeriesDataSet.SetBookmarkFlag(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}; Value: TBookmarkFlag);
begin
  {$IFDEF CLR}
  with Marshal do
    WriteByte(Buffer, FRecInfoOfs + 5, Byte(Value)); // TRecInfo.BookmarkFlag
  {$ELSE}
  PRecInfo(Buffer + RecInfoOfs).BookmarkFlag := Value;
  {$ENDIF}
end;

{$IFDEF CLR}
procedure TSeriesDataSet.GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark);
{$ELSE}
procedure TSeriesDataSet.GetBookmarkData(Buffer: PChar; Data: Pointer);
{$ENDIF}
begin
  PInteger(Data)^ := PRecInfo(Buffer + RecInfoOfs).Bookmark;
end;

{$IFDEF CLR}
procedure TSeriesDataSet.SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark);
{$ELSE}
procedure TSeriesDataSet.SetBookmarkData(Buffer: PChar; Data: Pointer);
{$ENDIF}
begin
  PRecInfo(Buffer + RecInfoOfs).Bookmark := PInteger(Data)^;
end;

function TSeriesDataSet.GetRecordSize: Word;
begin
  if Assigned(FSeries) then result:=SizeOf(TSeriesPoint)
                       else result:=0;
end;

function TSeriesDataSet.AllocRecordBuffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF};
begin
  GetMem(Result, RecBufSize);
end;

procedure TSeriesDataSet.FreeRecordBuffer(var Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF});
begin
  FreeMem(Buffer, RecBufSize);
end;

function TSeriesDataSet.GetRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF}; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
var t : Integer;
begin
  result:=grError;
  if Assigned(FSeries) then
  begin
    if FSeries.Count < 1 then Result := grEOF
    else
    begin
      Result := grOK;
      case GetMode of
        gmNext: if FCurRec >= RecordCount - 1  then Result := grEOF
                                                 else Inc(FCurRec);
       gmPrior: if FCurRec <= 0 then Result := grBOF
                                  else Dec(FCurRec);
     gmCurrent: if (FCurRec < 0) or (FCurRec >= RecordCount) then
                   Result := grError;
      end;
      if Result = grOK then
      begin
        With PSeriesPoint(Buffer)^ do
        begin
          Color:=FSeries.ValueColor[FCurRec];
          X:=FSeries.XValues.Value[FCurRec];
          ALabel:=FSeries.Labels[FCurRec];
          for t:=1 to FSeries.ValuesList.Count-1 do
              Values[t-1]:=FSeries.ValuesList[t].Value[FCurRec];
        end;
        with PRecInfo(Buffer + RecInfoOfs)^ do
        begin
          BookmarkFlag := bfCurrent;
          if Assigned(FBookMarks) and (FBookMarks.Count>FCurRec) and
             Assigned(FBookMarks[FCurRec]) then
             Bookmark := Integer(FBookMarks[FCurRec])
          else
             BookMark := -1;
        end;
      end else
        if (Result = grError) and DoCheck then DatabaseError('No Records');
    end;
  end
  else if DoCheck then DatabaseError('No Records');
end;

procedure TSeriesDataSet.InternalInitRecord(Buffer: {$IFDEF CLR}TRecordBuffer{$ELSE}PChar{$ENDIF});
begin
  FillChar(Buffer^, RecordSize, 0);
end;

function TSeriesDataSet.GetFieldData(Field: TField; Buffer: Pointer): Boolean;

   Function GetSeriesValue(AList:TChartValueList):Double;
   var t : Integer;
   begin
     if AList=FSeries.XValues then result:=PSeriesPoint(ActiveBuffer)^.X
     else
     begin
       result:=0;
       for t:=1 to FSeries.ValuesList.Count-1 do
       if AList=FSeries.ValuesList[t] then
       begin
         result:=PSeriesPoint(ActiveBuffer)^.Values[t-1];
         break;
       end;
     end;
     if AList.DateTime then result:=TimeStampToMSecs(DateTimeToTimeStamp(result));
   end;

begin
  result:=(Series.Count>0) and (ActiveBuffer<>nil);  { 5.01 , support for Null fields in DBChart }
  if result and Assigned(Buffer) then
  Case Field.FieldNo of
    1: PInteger(Buffer)^:= PSeriesPoint(ActiveBuffer)^.Color;
    2: PFloat(Buffer)^:=GetSeriesValue(FSeries.XValues);
    3: PFloat(Buffer)^:=GetSeriesValue(FSeries.YValues);
    4: begin
         StrPCopy(Buffer,PSeriesPoint(ActiveBuffer)^.ALabel);
         result := PChar(Buffer)^ <> #0;
       end;
    else
    begin
      PFloat(Buffer)^:=GetSeriesValue(FSeries.ValuesList[Field.FieldNo-3]);
    end;
  end;
end;

procedure TSeriesDataSet.SetFieldData(Field: TField; Buffer: Pointer);

   Function GetAValue(IsDateTime:Boolean):Double;
   begin
     result:=PFloat(Buffer)^;
     if IsDateTime then result:=TimeStampToDateTime(MSecsToTimeStamp(result));
   end;

begin
  if ActiveBuffer<>nil then
  Case Field.FieldNo of
    1: PSeriesPoint(ActiveBuffer)^.Color:=PInteger(Buffer)^;
    2: PSeriesPoint(ActiveBuffer)^.X:=GetAValue(FSeries.XValues.DateTime);
    3: PSeriesPoint(ActiveBuffer)^.Values[0]:=GetAValue(FSeries.YValues.DateTime);
    4: PSeriesPoint(ActiveBuffer)^.ALabel:=PChar(Buffer);
  else
    PSeriesPoint(ActiveBuffer)^.Values[Field.FieldNo-4]:=GetAValue(FSeries.ValuesList[Field.FieldNo-3].DateTime);
  end;
  DataEvent(deFieldChange, Integer(Field));
end;

procedure TSeriesDataSet.InternalFirst;
begin
  FCurRec := -1;
end;

procedure TSeriesDataSet.InternalLast;
begin
  FCurRec := FSeries.Count;
end;

Procedure TSeriesDataSet.AddSeriesPoint(Buffer:Pointer; ABookMark:Integer);
var t : Integer;
begin
  With PSeriesPoint(Buffer)^ do
  begin
    for t:=2 to FSeries.ValuesList.Count-1 do
        FSeries.ValuesList[t].TempValue:=Values[t-1];
    FSeries.AddXY(X,Values[0],ALabel,Color);
  end;
  FBookMarks.Add(Pointer(ABookMark));
end;

procedure TSeriesDataSet.InternalPost;
var t : Integer;
begin
  if State = dsEdit then
  With PSeriesPoint(ActiveBuffer)^ do
  Begin
    FSeries.ValueColor[FCurRec]:=Color;
    FSeries.XValues.Value[FCurRec]:=X;
    FSeries.YValues.Value[FCurRec]:=Values[0];
    FSeries.Labels[FCurRec]:=ALabel;
    for t:=2 to FSeries.ValuesList.Count-1 do
        FSeries.ValuesList[t].Value[FCurRec]:=Values[t-1];
  end
  else
  begin
    Inc(FLastBookmark);
    AddSeriesPoint(ActiveBuffer,FLastBookMark);
  end;
end;

procedure TSeriesDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  Inc(FLastBookmark);
  if Append then InternalLast;
  AddSeriesPoint(Buffer,FLastBookmark);
end;

procedure TSeriesDataSet.InternalDelete;
begin
  FSeries.Delete(FCurRec);
  FBookMarks.Delete(FCurRec);
  if FCurRec >= RecordCount then Dec(FCurRec);
end;

function TSeriesDataSet.GetRecordCount: Integer;
begin
  Result:=FSeries.Count;
end;

function TSeriesDataSet.GetRecNo: Integer;
begin
  UpdateCursorPos;
  if (FCurRec = -1) and (RecordCount > 0) then
     Result := 1
  else
     Result := FCurRec + 1;
end;

procedure TSeriesDataSet.SetRecNo(Value: Integer);
begin
  if (Value >= 0) and (Value <= RecordCount) then
  begin
    FCurRec := Value - 1;
    Resync([]);
  end;
end;

procedure TSeriesDataSet.TeeEvent(Event: TTeeEvent);
begin
  if Active and (Event is TTeeSeriesEvent) and
     (TTeeSeriesEvent(Event).Event=seDataChanged) then
  begin
    Close;
    Open;
  end;
end;

end.
