{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit DBEditCh;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  {$ENDIF}
  DB, TeeEdiSeri, TeEngine, Chart, TeeDBEdit, TeeSourceEdit, TeCanvas;

Const MaxValueSources=16;

type
  TDBChartEditor = class(TBaseDBChartEditor)
    GroupFields: TScrollBox;
    LLabels: TLabel;
    CBLabelsField: TComboFlat;
    procedure CBLabelsFieldChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);
  private
    { Private declarations }
    LabelValues : Array[0..MaxValueSources-1] of TLabel;
    CBDateTime  : Array[0..MaxValueSources-1] of TCheckBox;
    procedure CBValuesChange(Sender: TObject);
    Procedure SetFields;
    Procedure SetTextItemIndex(Combo:TComboFlat);
  protected
    Function IsValid(AComponent:TComponent):Boolean; override;
  public
    { Public declarations }
    CBValues : Array[0..MaxValueSources-1] of TComboFlat;
  end;

  TDataSetSeriesSource=class(TTeeSeriesDBSource)
  public
    class Function Description:String; override;
    class Function Editor:TComponentClass; override;
    class Function HasSeries(ASeries:TChartSeries):Boolean; override;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  TeeConst, DBChart, TeeProcs, TeeDBSumEdit, TeeDBSourceEditor;

Function TDBChartEditor.IsValid(AComponent:TComponent):Boolean;
begin
  result:=AComponent is TDataSet;
end;

procedure TDBChartEditor.CBLabelsFieldChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TDBChartEditor.CBValuesChange(Sender: TObject);
var tmpField : TField;
begin
  With TComboFlat(Sender) do
  if ItemIndex<>-1 then
  begin
    tmpField:=DataSet.FindField(Items[ItemIndex]);
    CBDateTime[{$IFDEF CLR}Integer{$ENDIF}(Tag)].Checked:=Assigned(tmpField) and
                             (TeeFieldType(tmpField.DataType)=tftDateTime);
  end;

  BApply.Enabled:=True;
end;

Procedure TDBChartEditor.SetTextItemIndex(Combo:TComboFlat);
var tmp : Integer;
begin
  With Combo do
  begin
    tmp:=Items.IndexOf(Text);
    if tmp<>ItemIndex then ItemIndex:=tmp;
  end;
end;

procedure TDBChartEditor.FormShow(Sender: TObject);
var t       : Integer;
    tmpName : String;
begin
  inherited;
  TheSeries:=TChartSeries(Tag);

  if Assigned(TheSeries) then
  begin
    With TheSeries do
    for t:=0 to ValuesList.Count-1 do
    begin
      tmpName:=ValuesList[t].Name;

      CBValues[t]:=TComboFlat.Create(Self);

      With CBValues[t] do
      begin
        {$IFDEF CLX}
        Name:=TeeGetUniqueName(Self,'ComboFlat');
        {$ENDIF}

        Left:=CBLabelsField.Left;
        Style:=csDropDown;
        HelpContext:=178;
        Width:=CBLabelsField.Width;
        Top:=2+CBLabelsField.Top+CBLabelsField.Height+((CBValues[t].Height+4)*t+1);
        OnChange:=CBValuesChange;
        Tag:=t;
        Parent:=GroupFields;
        Visible:=tmpName<>'';
      end;

      LabelValues[t]:=TLabel.Create(Self);

      With LabelValues[t] do
      begin
        {$IFDEF CLX}
        Name:=TeeGetUniqueName(Self,'Label');
        {$ENDIF}

        Alignment:=taRightJustify;
        Parent:=GroupFields;
        Top:=CBValues[t].Top+4;
        Caption:=tmpName+':';
        Visible:=tmpName<>'';
        //AutoSize:=False;  5.03 , Japanese
        AutoSize:=True; // 6.0 fix ""
        Left:=LLabels.Left+LLabels.Width-Width;

        if ValuesList[t]=MandatoryValueList then
           Font.Style:=[fsBold];
      end;

      CBDateTime[t]:=TCheckBox.Create(Self);

      With CBDateTime[t] do
      begin
        {$IFDEF CLX}
        Name:=TeeGetUniqueName(Self,'CheckBox');
        {$ENDIF}

        Parent:=GroupFields;
        Left:=CBLabelsField.Left+CBLabelsField.Width+6;
        Top:=CBValues[t].Top;
        HelpContext:=178;
        Caption:=TeeMsg_DateTime;
        Width:=Canvas.TextWidth(Caption + 'www');
        Tag:=t;
        Visible:=tmpName<>'';
        OnClick:=CBLabelsFieldChange;
      end;
    end;

    SetFields;
  end;

  BApply.Enabled:=False;
end;

Procedure TDBChartEditor.SetFields;

  Procedure FillFields;

    Procedure AddField(Const tmpSt:String; tmpType:TFieldType);
    Var t : Integer;
    begin
      Case TeeFieldType(tmpType) of
      tftNumber,
     tftDateTime: begin
                    CBLabelsField.Items.Add(tmpSt);
                    for t:=0 to TheSeries.ValuesList.Count-1 do
                        CBValues[t].Items.Add(tmpSt);
                  end;
         tftText: CBLabelsField.Items.Add(tmpSt);
      end;
    end;

  Var t : Integer;
  Begin
    With DataSet do
    if FieldCount>0 then
       for t:=0 to FieldCount-1 do
           AddField(Fields[t].FieldName,Fields[t].DataType)
    else
    begin
      FieldDefs.Update;
      for t:=0 to FieldDefs.Count-1 do
          AddField(FieldDefs[t].Name,FieldDefs[t].DataType);
    end;
  end;

var t : Integer;
begin
  CBLabelsField.Clear;
  CBLabelsField.Enabled:=CBSources.ItemIndex<>-1;

  for t:=0 to TheSeries.ValuesList.Count-1 do
  With CBValues[t] do
  begin
    Clear;
    Enabled:=CBLabelsField.Enabled;
  end;

  if CBSources.ItemIndex<>-1 then FillFields;

  With CBLabelsField do ItemIndex:=Items.IndexOf(TheSeries.XLabelsSource);

  With TheSeries.ValuesList do
  for t:=0 to Count-1 do
  begin
    With CBValues[t] do ItemIndex:=Items.IndexOf(ValueList[t].ValueSource);
    CBDateTime[t].Checked:=ValueList[t].DateTime;
  end;
end;

procedure TDBChartEditor.BApplyClick(Sender: TObject);

  Procedure CheckFieldIsBlank(Const AFieldName:String);
  begin
    if AFieldName<>'' then
       Raise ChartException.CreateFmt(TeeMsg_FieldNotFound,[AFieldName]);
  end;

  Procedure CheckValidFields;
  var t : Integer;
  begin
    for t:=0 to TheSeries.ValuesList.Count-1 do
    With CBValues[t] do
    begin
      SetTextItemIndex(CBValues[t]);
      if ItemIndex=-1 then CheckFieldIsBlank(Text);
    end;
    SetTextItemIndex(CBLabelsField);
    With CBLabelsField do
    if ItemIndex=-1 then CheckFieldIsBlank(Text);
  end;

var t : Integer;
begin
  inherited;
  With TheSeries do
  begin
    DataSource:=nil;
    try
      CheckValidFields;

      for t:=0 to ValuesList.Count-1 do
      With ValuesList[t] do
      begin
        ValueSource:=CBValues[t].Text;
        DateTime:=CBDateTime[t].Checked;
      end;

      XLabelsSource:=CBLabelsField.Text;
    finally
      DataSource:=DataSet;
    end;
  end;
  BApply.Enabled:=False;
end;

procedure TDBChartEditor.CBSourcesChange(Sender: TObject);
begin
  inherited;
  SetFields;
end;

{ TDataSetSeriesSource }
class function TDataSetSeriesSource.Description: String;
begin
  result:=TeeMsg_DataSet;
end;

class function TDataSetSeriesSource.Editor: TComponentClass;
begin
  result:=TDBChartEditor;
end;

class function TDataSetSeriesSource.HasSeries(ASeries: TChartSeries): Boolean;
begin
  result:=(ASeries.DataSource is TDataSet) and
          (Copy(ASeries.MandatoryValueList.ValueSource,1,1)<>'#');
end;

initialization
  TeeSources.Add({$IFDEF CLR}TObject{$ENDIF}(TDataSetSeriesSource));
finalization
  TeeSources.Remove({$IFDEF CLR}TObject{$ENDIF}(TDataSetSeriesSource));
end.

