{******************************************}
{ TSeriesTextSource Editor                 }
{ Copyright (c) 2000-2004 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeSeriesTextEd;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QGrids, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Grids, Buttons,
     {$ENDIF}
     TeeURL, TeeProcs, TeEngine, TeCanvas, TeeSourceEdit;

Const
  TeeDefaultFieldSeparator=',';

type
  TSeriesTextField=class;

  TSeriesTextGetValue=procedure(Field:TSeriesTextField;
                                Const Text:String; Var Value:Double) of object;

  TSeriesTextField=class(TCollectionItem)
  private
    FFieldIndex : Integer;
    FFieldName  : String;
    FOnGetValue : TSeriesTextGetValue;
    procedure SetFieldIndex(const Value: Integer);
  protected
    { Protected declarations }
    Data : TObject;
  published
    property FieldIndex:Integer read FFieldIndex write SetFieldIndex;
    property FieldName:String read FFieldName write FFieldName;
    property OnGetValue:TSeriesTextGetValue read FOnGetValue write FOnGetValue;
  end;

  TSeriesTextFields=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TSeriesTextField;
    Procedure Put(Index:Integer; Const Value:TSeriesTextField);
  public
    property Items[Index:Integer]:TSeriesTextField read Get write Put; default;
  end;

  TSeriesTextSource=class(TTeeSeriesSourceFile)
  private
    FFields     : TSeriesTextFields;
    FHeader     : Integer;
    FSeparator  : String;
    procedure SetFields(const Value: TSeriesTextFields);
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Function AddField(Const AName:String; AIndex:Integer):TSeriesTextField;

    class Function Description:String; override;
    class Function Editor:TComponentClass; override;

    procedure LoadFromStream(AStream: TStream); override;
    Procedure LoadFromStrings(AStrings:TStrings);
  published
    property Active;
    property HeaderLines:Integer read FHeader write FHeader default 0;
    property Fields:TSeriesTextFields read FFields write SetFields;
    property FieldSeparator:String read FSeparator write FSeparator;
    property FileName;
    property Series;
  end;

  TSeriesTextEditor = class(TBaseSourceEditor)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    StringGrid1: TStringGrid;
    CBSeries: TComboFlat;
    CBSep: TComboFlat;
    TabSheet2: TTabSheet;
    BBrowse: TSpeedButton;
    RBFile: TRadioButton;
    EFile: TEdit;
    RBWeb: TRadioButton;
    EWeb: TEdit;
    ButtonLoad: TButton;
    PanBot: TPanel;
    procedure FormShow(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonLoadClick(Sender: TObject);
    procedure RBFileClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure EFileChange(Sender: TObject);
    procedure EWebChange(Sender: TObject);
    procedure CBSepChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    InternalSource : Boolean;
    procedure HideSeriesCombo;
    Function SelectedSeries:TChartSeries;
    Procedure SetOptions;
  public
    { Public declarations }
    DataSource : TSeriesTextSource;
  end;

Procedure TeeEditSeriesTextSource(ASource:TSeriesTextSource);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  TeeConst, TeePenDlg, TeeProCo;

{ create a Form to edit the Series Text source }
Procedure TeeEditSeriesTextSource(ASource:TSeriesTextSource);
var tmp : TSeriesTextEditor;
begin
  tmp:=TSeriesTextEditor(TeeCreateForm(TSeriesTextEditor,nil));
//  tmp:=TSeriesTextEditor.Create(nil);
  with tmp do
  try
    TeeTranslateControl(tmp);
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(ASource);
    ShowModal;
  finally
    Free;
  end
end;

procedure TSeriesTextEditor.HideSeriesCombo;
begin
  { hide series combobox }
  CBSeries.Visible:=False;
  Label3.Visible:=False;
  PageControl1.Align:=alClient;
end;

procedure TSeriesTextEditor.FormShow(Sender: TObject);
var tmp : TChartSeries;
    t   : Integer;
begin
  inherited;
  InternalSource:=False;
  StringGrid1.ColWidths[1]:=50; { 5.02 }

  { find Text Source object }
  if TObject(Tag) is TSeriesTextSource then
  begin
    DataSource:=TSeriesTextSource(Tag);
    TheSeries:=DataSource.Series;
    Pan.Visible:=False;
  end
  else
  if TObject(Tag) is TChartSeries then
  begin
    if TheSeries.DataSource is TSeriesTextSource then
    begin
      DataSource:=TSeriesTextSource(TheSeries.DataSource);
      HideSeriesCombo;
    end;
  end;

  if not Assigned(DataSource) then
  begin
    if TObject(Tag) is TChartSeries then
    begin
      if Assigned(TheSeries.Owner) then
      begin
        DataSource:=TSeriesTextSource.Create(TheSeries.Owner);
        InternalSource:=True;
        DataSource.Name:=TeeGetUniqueName(DataSource.Owner,'SeriesTextSource'); { <-- do not translate }
      end
      else DataSource:=TSeriesTextSource.Create(TheSeries);


      HideSeriesCombo;
      PageControl1.ActivePage:=TabSheet2;
    end;
  end;

  if Assigned(DataSource) then
  begin
    { set form controls }
    with DataSource do
    begin
      UpDown1.Position:=HeaderLines;

      if FieldSeparator=',' then CBSep.ItemIndex:=0
      else
      if FieldSeparator=' ' then CBSep.ItemIndex:=1
      else
      if FieldSeparator=#9 then CBSep.ItemIndex:=2
      else
      begin
        CBSep.ItemIndex:=-1;
        CBSep.Text:=FieldSeparator;
      end;

      if Assigned(Owner) then
      begin
        if CBSeries.Visible then
        begin
          With Owner do
          for t:=0 to ComponentCount-1 do
          if Components[t] is TChartSeries then
          begin
            tmp:=TChartSeries(Components[t]);
            CBSeries.Items.AddObject(SeriesTitleOrName(tmp),tmp);
          end;
        end
        else
           CBSeries.Items.AddObject(SeriesTitleOrName(TheSeries),TheSeries);

        with CBSeries do
        if Visible then
           ItemIndex:=Items.IndexOfObject(Series)
        else
           ItemIndex:=Items.IndexOfObject(TheSeries);

        if CBSeries.ItemIndex<>-1 then CBSeriesChange(Self)
        else
        begin
          StringGrid1.Enabled:=False;
          ButtonLoad.Enabled:=False;
        end;
      end;

      { set text filename }
      if FileName<>'' then
        if Copy(Uppercase(FileName),1,7)='HTTP://' then
        begin
          EWeb.Text:=FileName;
          RBWeb.Checked:=True;
          RBFileClick(RBWeb);
        end
        else
        begin
          EFile.Text:=FileName;
          RBFile.Checked:=True;
          RBFileClick(RBFile);
        end;
    end;

    BApply.Enabled:=Assigned(TheSeries) and (TheSeries.DataSource<>DataSource);
  end;

  PanBot.Visible:=not Assigned(Parent);
end;

procedure TSeriesTextEditor.CBSeriesChange(Sender: TObject);

  { return the "field index" corresponding to AName value list }
  Function GetFieldIndexSt(Const AName:String):String;
  var t : Integer;
  begin
    result:='';
    With DataSource do
    for t:=0 to Fields.Count-1 do
    if Uppercase(Fields[t].FieldName)=Uppercase(AName) then
    begin
      Str(Fields[t].FieldIndex,result);
      Exit;
    end;
  end;

var t   : Integer;
    tmp : TChartSeries;
begin
  if CBSeries.ItemIndex<>-1 then
  begin
    StringGrid1.Enabled:=True;
    ButtonLoad.Enabled:=True;
    tmp:=SelectedSeries;
    if Assigned(tmp) then
    begin
      StringGrid1.RowCount:=2+tmp.ValuesList.Count;
      StringGrid1.Cells[1,0]:=TeeMsg_Column;
      StringGrid1.Cells[0,1]:=TeeMsg_Text;
      StringGrid1.Cells[1,1]:=GetFieldIndexSt(TeeMsg_Text);
      With tmp do
      for t:=0 to ValuesList.Count-1 do
      begin
        StringGrid1.Cells[0,2+t]:=ValuesList[t].Name;
        StringGrid1.Cells[1,2+t]:=GetFieldIndexSt(ValuesList[t].Name);
      end;
    end;
  end;
end;

Procedure TSeriesTextEditor.SetOptions;
var t: Integer;
begin
  With DataSource do
  begin
    if RBWeb.Checked then FileName:=EWeb.Text
                     else FileName:=EFile.Text;

    HeaderLines:=UpDown1.Position;
    Case CBSep.ItemIndex of
      0: FieldSeparator:=',';
      1: FieldSeparator:=' ';
      2: FieldSeparator:=#9;
    else
         FieldSeparator:=CBSep.Text;
    end;

    Fields.Clear;
    if CBSeries.ItemIndex<>-1 then
    begin
      Series:=SelectedSeries;
      for t:=1 to StringGrid1.RowCount-1 do
      begin
        if StringGrid1.Cells[1,t]<>'' then
           AddField(StringGrid1.Cells[0,t],StrToInt(StringGrid1.Cells[1,t]));
      end;
    end;
  end;
end;

Function TSeriesTextEditor.SelectedSeries:TChartSeries;
begin
  With CBSeries do
  if ItemIndex=-1 then result:=nil
                  else result:=TChartSeries(Items.Objects[ItemIndex])
end;

procedure TSeriesTextEditor.Button1Click(Sender: TObject);
begin
  SetOptions;
end;

procedure TSeriesTextEditor.ButtonLoadClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    SetOptions;
    DataSource.Close; { 5.02 }
    DataSource.Open;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TSeriesTextEditor.RBFileClick(Sender: TObject);
begin
  EFile.Enabled:=RBFile.Checked;
  RBWeb.Checked:=not RBFile.Checked;
  EWeb.Enabled:=not EFile.Enabled;
  BBrowse.Enabled:=EFile.Enabled;
  EFileChange(Sender);
end;

procedure TSeriesTextEditor.SpeedButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then EFile.Text:=OpenDialog1.FileName;
end;

{ TSeriesTextSource }
Constructor TSeriesTextSource.Create(AOwner: TComponent);
begin
  inherited;
  FFields:=TSeriesTextFields.Create(Self,TSeriesTextField);
  FSeparator:=TeeDefaultFieldSeparator;
end;

Destructor TSeriesTextSource.Destroy;
begin
  FFields.Free;
  inherited;
end;

function TSeriesTextSource.AddField(const AName: String;
  AIndex: Integer):TSeriesTextField;
begin
  result:=TSeriesTextField(FFields.Add);
  with result do
  begin
    FieldName:=AName;
    FieldIndex:=AIndex;
  end;
end;

procedure TSeriesTextSource.LoadFromStream(AStream: TStream);
var tmp : TStringList;
begin
  inherited;
  AStream.Position:=0;
  tmp:=TStringList.Create;
  try
    tmp.LoadFromStream(AStream);
    LoadFromStrings(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TSeriesTextSource.SetFields(const Value: TSeriesTextFields);
begin
  FFields.Assign(Value);
end;

type TValueListAccess=class(TChartValueList);

procedure TSeriesTextSource.LoadFromStrings(AStrings: TStrings);
Var St        : String;
    t,
    tt        : Integer;
    tmpLabel,
    tmpText   : String;
    tmpHasNot : Boolean;
    tmpX      : Double;
    tmpValue  : Double;
begin
  if Assigned(Series) then
  begin
    { by default, series has no X values }
    tmpHasNot:=False;

    { prepare list of fields }
    for tt:=0 to FFields.Count-1 do
    With FFields[tt] do
    begin
      if Uppercase(FieldName)=Uppercase(TeeMsg_Text) then { text labels }
         Data:=Series.Labels
      else
      begin
        { values }
        if Uppercase(FieldName)=Uppercase(Series.NotMandatoryValueList.Name) then
        begin
          tmpHasNot:=True;
          Data:=Series.NotMandatoryValueList;
        end
        else Data:=Series.GetYValueList(FieldName);
      end;
    end;

    TeeFieldsSeparator:=FSeparator;

    { empty series }
    Series.Clear;

    { loop all strings }
    for t:=HeaderLines to AStrings.Count-1 do
    begin
      St:=AStrings[t];
      if St<>'' then
      begin
        { clear temporary values }
        for tt:=0 to Series.ValuesList.Count-1 do
            Series.ValuesList[tt].TempValue:=0;

        tmpLabel:='';

        { set temporary values from loaded text string }
        for tt:=0 to FFields.Count-1 do
        With FFields[tt] do
        begin
          tmpText:=TeeExtractField(St,FieldIndex);
          if Data=Series.Labels then tmpLabel:=tmpText
          else
          begin
            if Assigned(FOnGetValue) then
               FOnGetValue(FFields[tt],tmpText,tmpValue)
            else
            if TValueListAccess(Data).DateTime then tmpValue:=StrToDateTime(tmpText)
                                               else tmpValue:=StrToFloat(tmpText);
            TValueListAccess(Data).TempValue:=tmpValue;
          end;
        end;

        { add new point to series }
        With Series do
        begin
          if not tmpHasNot then tmpX:=Count
                           else tmpX:=NotMandatoryValueList.TempValue;
          AddXY(tmpX,MandatoryValueList.TempValue,tmpLabel);
        end;
        
      end;
    end;
    { tell changes to other series }
    Series.RefreshSeries;
  end;
end;

class function TSeriesTextSource.Description: String;
begin
  result:=TeeMsg_TextFile;
end;

class function TSeriesTextSource.Editor: TComponentClass;
begin
  result:=TSeriesTextEditor;
end;

{ TSeriesTextField }
procedure TSeriesTextField.SetFieldIndex(const Value: Integer);
begin
  if Value>0 then FFieldIndex:=Value
             else Raise Exception.Create(TeeMsg_SeriesTextFieldZero);
end;

{ TSeriesTextFields }
function TSeriesTextFields.Get(Index: Integer): TSeriesTextField;
begin
  result:=TSeriesTextField(inherited Items[Index]);
end;

procedure TSeriesTextFields.Put(Index: Integer; const Value: TSeriesTextField);
begin
  Items[Index].Assign(Value);
end;

procedure TSeriesTextEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;
  LLabel.Visible:=False;
  CBSources.Visible:=False;
  BBrowse.Flat:=True;
end;

procedure TSeriesTextEditor.BApplyClick(Sender: TObject);
begin
  inherited;
  CheckReplaceSource(DataSource);
  SetOptions;
  BApply.Enabled:=False;
  DataSource.Open; { 5.02 }
end;

procedure TSeriesTextEditor.EFileChange(Sender: TObject);
begin
  inherited;
  if Pan.Visible then BApply.Enabled:=True;
end;

procedure TSeriesTextEditor.EWebChange(Sender: TObject);
begin
  inherited;
  EFileChange(Sender);
end;

procedure TSeriesTextEditor.CBSepChange(Sender: TObject);
begin
  inherited;
  EFileChange(Sender);
end;

procedure TSeriesTextEditor.Edit1Change(Sender: TObject);
begin
  inherited;
  EFileChange(Sender);
end;

procedure TSeriesTextEditor.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  inherited;
  EFileChange(Sender);
end;

procedure TSeriesTextEditor.FormDestroy(Sender: TObject);
begin { free the temporary datasource }
  if Assigned(DataSource) and InternalSource and
     (not (csDesigning in DataSource.ComponentState)) and
     (not Assigned(DataSource.Series)) then
          DataSource.Free;
  inherited;
end;

initialization
  RegisterClass(TSeriesTextSource);
  {$IFNDEF TEEOCX}
  TeeSources.Add({$IFDEF CLR}TObject{$ENDIF}(TSeriesTextSource));
  {$ENDIF}
finalization
  {$IFNDEF TEEOCX}
  TeeSources.Remove({$IFDEF CLR}TObject{$ENDIF}(TSeriesTextSource));
  {$ENDIF}
  UnRegisterClass(TSeriesTextSource);
end.
