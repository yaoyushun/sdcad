{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeDBSumEdit;
{$I TeeDefs.inc}

interface

uses
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  Chart, TeEngine, TeeSourceEdit, TeeDBEdit, TeCanvas;

type
  TDBChartSumEditor = class(TBaseDBChartEditor)
    Label1: TLabel;
    Label2: TLabel;
    CBAgg: TComboFlat;
    CBValue: TComboFlat;
    CBGroup: TComboFlat;
    CBTimeStep: TComboFlat;
    Label3: TLabel;
    Label4: TLabel;
    CBSort: TComboFlat;
    CBSortType: TComboFlat;
    procedure CBAggChange(Sender: TObject);
    procedure CBGroupChange(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);
    procedure CBSortChange(Sender: TObject);
    procedure CBSortTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CheckCount;
    Procedure EnableCombos;
    Procedure EnableTimeStep;
  public
    { Public declarations }
  end;

  TDBSummarySource=class(TTeeSeriesDBSource)
  public
    class Function Description:String; override;
    class Function Editor:TComponentClass; override;
    class Function HasSeries(ASeries:TChartSeries):Boolean; override;
  end;

// Show modal dialog to edit Series Database Summary properties.
Function TeeDBSummaryEditor(AOwner:TComponent; ASeries:TChartSeries):Boolean;

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
  DBChart, TeeProcs, DB, TeeConst;

Function TeeDBSummaryEditor(AOwner:TComponent; ASeries:TChartSeries):Boolean;
begin
  // Show the Summary editor dialog...
  With TDBChartSumEditor.Create(AOwner) do
  try
    Align:=alNone;
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(ASeries);
    BorderStyle:=TeeBorderStyle;
    Caption:='Summary properties';
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function TeeGetDBGroup(St:String; Var Step:TTeeDBGroup):Boolean;
begin
  result:=False;
  St:=TeeGetDBPart(1,St);
  if St<>'' then
  begin
    result:=True;
    Step:=StrToDBGroup(St);
  end;
end;

procedure TDBChartSumEditor.CBAggChange(Sender: TObject);
begin
  inherited;
  With CBValue do
  begin
    Enabled:=(DataSet<>nil) and (CBAgg.ItemIndex<>1);
    if ItemIndex<>-1 then Text:=Items[ItemIndex] { 5.01 }
                     else Text:='';
  end;
  BApply.Enabled:=True
end;

Procedure TDBChartSumEditor.EnableTimeStep;

  Function TheFieldType(Const AName:String):TFieldType;
  begin
    With DataSet do
    if FieldCount>0 then
       result:=FieldByName(AName).DataType
    else
    begin
      FieldDefs.Update;
      result:=FieldDefs[FieldDefs.IndexOf(AName)].DataType;
    end;
  end;

var tmpName : String;
begin
  if CBGroup.ItemIndex=-1 then
  begin
    CBTimeStep.ItemIndex:=-1;
    CBTimeStep.Enabled:=False;
    CBSort.Enabled:=False;
    CBSortType.Enabled:=False;
  end
  else
  begin
    With CBGroup do tmpName:=Items[ItemIndex];
    CBTimeStep.Enabled:=TeeFieldType(TheFieldType(tmpName))=tftDateTime;
    CBSort.Enabled:=not CBTimeStep.Enabled;
    if not CBSort.Enabled then CBSort.ItemIndex:=0;
    CBSortType.Enabled:=CBSort.ItemIndex>0;
  end;
end;

procedure TDBChartSumEditor.CBGroupChange(Sender: TObject);
begin
  inherited;
  EnableTimeStep;
  BApply.Enabled:=True;
end;

procedure TDBChartSumEditor.BApplyClick(Sender: TObject);

  Function TeeDBGroupToStr(Group:TTeeDBGroup):String;
  begin
    Case Group of
      dgHour   : result:='HOUR';
      dgDay    : result:='DAY';
      dgWeek   : result:='WEEK';
      dgWeekDay: result:='WEEKDAY';
      dgMonth  : result:='MONTH';
      dgQuarter: result:='QUARTER';
      dgYear   : result:='YEAR'
    else
      result:='';
    end;
  end;

var tmp   : String;
    tmpSt : String;
begin
  inherited;

  Case CBAgg.ItemIndex of
    0: tmp:='#SUM#';
    1: tmp:='#COUNT#';
    2: tmp:='#HIGH#';
    3: tmp:='#LOW#';
    4: tmp:='#AVG#';
  else tmp:='';
  end;

  TheSeries.DataSource:=nil;

  With CBValue do { 5.01 }
  if ItemIndex=-1 then
     TheSeries.MandatoryValueList.ValueSource:=tmp+Text
  else
     TheSeries.MandatoryValueList.ValueSource:=tmp+Items[ItemIndex];

  tmpSt:='';

  if CBGroup.ItemIndex<>-1 then
  begin
    tmpSt:=CBGroup.Items[CBGroup.ItemIndex];

    if CBTimeStep.Enabled and (CBTimeStep.ItemIndex<>-1) then
       tmpSt:='#'+TeeDBGroupToStr(TTeeDBGroup(CBTimeStep.ItemIndex))+'#'+tmpSt
    else
    case CBSort.ItemIndex of
      2: begin
           TheSeries.MandatoryValueList.Order:=loNone;

           if CBSortType.ItemIndex=0 then tmpSt:='#SORTASC#'+tmpSt
                                     else tmpSt:='#SORTDES#'+tmpSt;
         end;
      1: begin
           TheSeries.NotMandatoryValueList.Order:=loNone;
           TheSeries.MandatoryValueList.Order:=TChartListOrder(CBSortType.ItemIndex);
         end;
      0: begin
           TheSeries.MandatoryValueList.Order:=loNone;
           TheSeries.NotMandatoryValueList.Order:=loNone;
         end;
    end;
  end;

  With TheSeries do
  begin
    XLabelsSource:=tmpSt;
    DataSource:=Self.DataSet;
  end;

  BApply.Enabled:=False;
end;

procedure TDBChartSumEditor.FormShow(Sender: TObject);
var tmp       : TTeeDBGroup;
    tmpSource : String;
    tmpOrder  : TChartListOrder;
begin
  inherited;
  EnableCombos;
  FillFields([CBValue,CBGroup]);

  if Assigned(TheSeries) then
  begin
    tmpSource:=TheSeries.MandatoryValueList.ValueSource;

    With CBAgg do ItemIndex:=Items.IndexOf(TeeGetDBPart(1,tmpSource));

    With CBValue do ItemIndex:=Items.IndexOf(TeeGetDBPart(2,tmpSource));

    tmpSource:=TeeGetDBPart(2,TheSeries.XLabelsSource);

    tmpOrder:=loNone;

    if tmpSource='' then
       tmpSource:=TeeGetDBPart(1,TheSeries.XLabelsSource)
    else
       tmpOrder:=StrToDBOrder(TeeGetDBPart(1,TheSeries.XLabelsSource));

    if tmpSource='' then tmpSource:=TheSeries.XLabelsSource;

    With CBGroup do ItemIndex:=Items.IndexOf(tmpSource);

    EnableTimeStep;

    With CBTimeStep do
    if Enabled then
    begin
      if TeeGetDBGroup(TheSeries.XLabelsSource,tmp) then
         ItemIndex:=Ord(tmp);
    end;

    CBSort.Enabled:=(not CBTimeStep.Enabled) and (CBGroup.ItemIndex<>-1);

    if CBSort.Enabled then
       if tmpOrder=loNone then
       begin
         if TheSeries.MandatoryValueList.Order<>loNone then
         begin
           CBSort.ItemIndex:=1;
           CBSortType.ItemIndex:=Ord(TheSeries.MandatoryValueList.Order);
         end
         else CBSort.ItemIndex:=0;
       end
       else
       begin
         CBSort.ItemIndex:=2;
         CBSortType.ItemIndex:=Ord(tmpOrder);
       end;

    CBSortType.Enabled:=CBSort.Enabled and (CBSort.ItemIndex>0);

    CheckCount;
  end;
end;

procedure TDBChartSumEditor.CheckCount;
begin
  CBValue.Enabled:=(DataSet<>nil) and (CBAgg.ItemIndex<>1);
  if CBValue.Enabled then
     With CBValue do
     begin
       ItemIndex:=Items.IndexOf(TeeGetDBPart(2,
                                TheSeries.MandatoryValueList.ValueSource));
       if ItemIndex<>-1 then Text:=Items[ItemIndex]
                        else Text:='';
     end
  else
    CBValue.Text:='';
end;

Procedure TDBChartSumEditor.EnableCombos;
begin
  EnableControls(DataSet<>nil,[CBAgg,CBValue,CBTimeStep,CBGroup]);
end;

procedure TDBChartSumEditor.CBSourcesChange(Sender: TObject);
begin
  inherited;
  EnableCombos;
  FillFields([CBValue,CBGroup]);
end;

procedure TDBChartSumEditor.CBSortChange(Sender: TObject);
begin
  CBSortType.Enabled:=CBSort.ItemIndex>0;
  BApply.Enabled:=True;
end;

procedure TDBChartSumEditor.CBSortTypeChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TDBChartSumEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CBSortType.ItemIndex:=0;
  CBSort.ItemIndex:=0;
end;

{ TDBSummarySource }

class function TDBSummarySource.Description: String;
begin
  result:=TeeMsg_Summary;
end;

class function TDBSummarySource.Editor: TComponentClass;
begin
  result:=TDBChartSumEditor;
end;

class function TDBSummarySource.HasSeries(
  ASeries: TChartSeries): Boolean;
begin
  result:=(ASeries.DataSource is TDataSet) and
          (Copy(ASeries.MandatoryValueList.ValueSource,1,1)='#');
end;

initialization
  TeeSources.Add({$IFDEF CLR}TObject{$ENDIF}(TDBSummarySource));
finalization
  TeeSources.Remove({$IFDEF CLR}TObject{$ENDIF}(TDBSummarySource));
end.
