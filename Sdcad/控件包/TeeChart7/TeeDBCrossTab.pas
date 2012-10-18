{**********************************************}
{   TeeChart Database Cross-Tab Source         }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeDBCrossTab;
{$I TeeDefs.inc}

interface

{ The procedure below creates an array of Chart Series
  and fills them using the DataSet parameter.

  The Series are created using the "AGroupField" parameter.

  The "ASeries" parameter will be used to duplicate it many times,
  one for each "group", thus using it as a template.

  Example of use:
  ---------------

  Imagine you have a table with "Product sales".

  In this table you have the following fields:

  Product    ( Cars, Bikes, Trucks... )
  Country    ( USA, UK, Germany, Australia... )
  Amount     ( $1234... )

  Now we want to create a crosstab Chart consisting of one Bar
  Series for each "Product", each one showing the sum of
  "Amount" for each "Country".

  So,
  our "GroupField" is "Product",
  our "LabelField" is "Country" and
  our "ValueField" is "Amount".

  Choose between 1 or 2:

  1) Calling a direct global procedure:

  FillDataSet( Table1, BarSeries1, "Product", "Country", "Amount", gfSum );

  After calling this procedure, the Chart will show several Series,
  one for each "Product".
  Each series will show the "Sum of Amount" by "Country".

  You can access and modify these Series as usually, like for example
  changing the Series Color, Title, etc.

  2) Use a TDBCrossTabSource component, set properties and Active:=True;

}
uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  DB, Chart, DBChart, TeEngine, TeeProcs, TeeSourceEdit, TeeDBEdit, TeCanvas;

type
  TGroupFormula = (gfCount, gfSum); { count records or sum record values }

  TDBCrossTabSource=class(TTeeSeriesDBSource)
  private
    FCase   : Boolean;
    FDataSet: TDataSet;
    FFormula: TGroupFormula;
    FGroup  : String;
    FLabel  : String;
    FValue  : String;

    ISource : TDBChartDataSource;
    procedure DataSourceCheckDataSet(ADataSet: TDataSet);
    procedure DataSourceCloseDataSet(ADataSet: TDataSet);
    Procedure LoadDataSet;
    procedure RemoveSeries;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetFormula(const Value: TGroupFormula);
    procedure SetGroup(const Value: String);
    procedure SetLabel(const Value: String);
    procedure SetValue(const Value: String);
    procedure SetCase(const Value: Boolean);
  protected
    KeepDataOnClose : Boolean;
    procedure SetActive(const Value:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Available(AChart: TCustomAxisPanel):Boolean; override;
    class Function Description:String; override;
    class Function Editor:TComponentClass; override;
    class Function HasSeries(ASeries:TChartSeries):Boolean; override;
    Procedure Load; override;
  published
    property Active;
    property CaseSensitive:Boolean read FCase write SetCase default True;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property Formula : TGroupFormula read FFormula write SetFormula default gfSum;
    property GroupField : String read FGroup write SetGroup;
    property LabelField : String read FLabel write SetLabel;
    property Series;
    property ValueField : String read FValue write SetValue;
  end;

  TDBChartCrossTabEditor = class(TBaseDBChartEditor)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CBAgg: TComboFlat;
    CBValue: TComboFlat;
    CBGroup: TComboFlat;
    Label4: TLabel;
    CBLabels: TComboFlat;
    CBActive: TCheckBox;
    CBCase: TCheckBox;
    procedure CBSourcesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure CBAggChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure CBCaseClick(Sender: TObject);
  private
    { Private declarations }
    DataSource : TDBCrossTabSource;
    Procedure EnableCombos;
  public
    { Public declarations }
  end;

Procedure FillDataSet( ADataSet:TDataSet;
                       ASeries:TChartSeries;
                       Const AGroupField,ALabelField,AValueField:String;
                       GroupFormula:TGroupFormula);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
uses Variants;
{$ENDIF}

Const TeeMsg_CrossTab ='CrossTab';

type TSeriesAccess=class(TChartSeries);

{ Create a cross-tab of Series using DataSet records. }
Procedure FillDataSet( ADataSet:TDataSet;
                       ASeries:TChartSeries;
                       Const AGroupField,ALabelField,AValueField:String;
                       GroupFormula:TGroupFormula);
begin
  with TDBCrossTabSource.Create(nil) do
  try
    Series:=ASeries;
    DataSet:=ADataSet;
    GroupField:=AGroupField;
    LabelField:=ALabelField;
    ValueField:=AValueField;
    Formula:=GroupFormula;
    KeepDataOnClose:=True;
    Open;
  finally
    Free;
  end;
end;

type TChartAccess=class(TCustomAxisPanel);

Procedure TDBCrossTabSource.LoadDataSet;

   Function LocateSeries(Const ATitle:String):TChartSeries;
   var t : Integer;
       tmp : String;
   begin
     With Series.ParentChart do
     if FCase then
     begin
       for t:=0 to SeriesCount-1 do
           if Series[t].Title=ATitle then
           begin
             result:=Series[t];
             exit;
           end;
     end
     else
     begin
       tmp:=UpperCase(ATitle);
       for t:=0 to SeriesCount-1 do
           if UpperCase(Series[t].Title)=tmp then
           begin
             result:=Series[t];
             exit;
           end;
     end;

     result:=nil;
   end;

var tmpGroup   : String;
    tmpSeries  : TChartSeries;
    tmpLabel   : String;
    tmpValue   : Double;
    t,tt       : Integer;
    tmpPoint   : Integer;
    tmpBookMark : TBookMark;
    tmpGroupField,
    tmpValueField,
    tmpLabelField : TField;
begin
  RemoveSeries;

  With DataSet do
  begin
    tmpBookMark:=GetBookMark;
    DisableControls;
    try
      if LabelField='' then tmpLabelField:=nil
                       else tmpLabelField:=FieldByName(LabelField);

      if GroupField='' then
      begin
        tmpSeries:=Series;
        Series.Title:=ValueField;
        tmpGroupField:=nil;
      end
      else
      begin
        tmpSeries:=nil;
        tmpGroupField:=FieldByName(GroupField);
      end;

      tmpValueField:=FieldByName(ValueField);

      tmpValue:=1;

      First;
      While not eof do
      begin
        if GroupField<>'' then
        begin
          tmpGroup:=tmpGroupField.AsString;
          tmpSeries:=LocateSeries(tmpGroup);

          if tmpSeries=nil then
          begin
            if Series.Title='' then
               tmpSeries:=Series
            else
            begin
              with Series do
              begin
                tmpSeries:=CreateNewSeries(Owner,ParentChart,
                                          TChartSeriesClass(ClassType));

                tmpSeries.Clear;
                TSeriesAccess(tmpSeries).ManualData:=True;
                tmpSeries.AssignFormat(Series);
                tmpSeries.ShowInLegend:=ShowInLegend;
                tmpSeries.Active:=Active;
                tmpSeries.Brush:=Brush;
                tmpSeries.Pen:=Pen;
                TSeriesAccess(tmpSeries).InternalUse:=True;
              end;

              tmpSeries.SeriesColor:=Series.ParentChart.GetFreeSeriesColor;
              tmpSeries.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Series);

              for t:=0 to Series.Count-1 do
                  tmpSeries.Add(0,Series.Labels[t]);
            end;

            tmpSeries.Title:=tmpGroup;
          end;
        end;

        if Formula<>gfCount then tmpValue:=tmpValueField.AsFloat;

        if not Assigned(tmpLabelField) then
        begin
          tmpLabel:='';
          if tmpSeries.Count>0 then tmpPoint:=0
                               else tmpPoint:=-1;
        end
        else
        begin
          tmpLabel:=tmpLabelField.AsString;
          tmpPoint:=tmpSeries.Labels.IndexOfLabel(tmpLabel,FCase);
        end;

        if tmpPoint=-1 then
        begin
          tmpSeries.Add(tmpValue,tmpLabel,clTeeColor);

          with Series.ParentChart do
          for t:=0 to SeriesCount-1 do
          if tmpSeries<>Series[t] then
             if tmpSeries.Count>Series[t].Count then
                for tt:=1 to (tmpSeries.Count-Series[t].Count) do
                    Series[t].Add(0,tmpLabel);
        end
        else
        begin
          With tmpSeries.MandatoryValueList do
          case Formula of
            gfCount,
            gfSum: Value[tmpPoint]:=Value[tmpPoint]+tmpValue;
          end;
        end;

        Next;
      end;
    finally
      GotoBookMark(tmpBookMark);
      FreeBookmark(tmpBookMark);
      EnableControls;
      TChartAccess(Series.ParentChart).BroadcastSeriesEvent(Series,seAdd);
    end;
  end;
end;

Procedure TDBChartCrossTabEditor.EnableCombos;
begin
  EnableControls(DataSet<>nil,[CBAgg,CBValue,CBGroup,CBLabels]);
end;

procedure TDBChartCrossTabEditor.CBSourcesChange(Sender: TObject);
begin
  inherited;
  EnableCombos;
  FillFields([CBValue,CBGroup,CBLabels]);
  BApply.Enabled:=True;
end;

procedure TDBChartCrossTabEditor.FormShow(Sender: TObject);
begin
  SkipValidation:=True;

  inherited;

  if not Assigned(TheSeries) then exit;

  if TheSeries.DataSource is TDBCrossTabSource then
     DataSource:=TDBCrossTabSource(TheSeries.DataSource)
  else
  begin
    DataSource:=TDBCrossTabSource.Create(TheSeries.Owner);
    DataSource.Name:=TeeGetUniqueName(DataSource.Owner,'DBCrossTabSource');
  end;

  With CBSources do
       ItemIndex:=Items.IndexOfObject(DataSource.DataSet);

  EnableCombos;
  FillFields([CBValue,CBGroup,CBLabels]);

  if DataSource.Formula=gfSum then CBAgg.ItemIndex:=0
                              else CBAgg.ItemIndex:=1;

  With CBValue do ItemIndex:=Items.IndexOf(DataSource.ValueField);
  With CBGroup do ItemIndex:=Items.IndexOf(DataSource.GroupField);
  With CBLabels do ItemIndex:=Items.IndexOf(DataSource.LabelField);

  CBActive.Checked:=DataSource.Active;
  CBCase.Checked:=DataSource.CaseSensitive;

  BApply.Enabled:=Assigned(TheSeries) and (DataSource<>TheSeries.DataSource);
end;

{ TDBCrossTabSource }

constructor TDBCrossTabSource.Create(AOwner: TComponent);
begin
  inherited;
  FFormula:=gfSum;
  FCase:=True;
end;

class function TDBCrossTabSource.Description: String;
begin
  result:=TeeMsg_CrossTab;
end;

class function TDBCrossTabSource.Editor: TComponentClass;
begin
  result:=TDBChartCrossTabEditor;
end;

class function TDBCrossTabSource.HasSeries(
  ASeries: TChartSeries): Boolean;
begin
  result:=(ASeries.DataSource is TDBCrossTabSource);
end;

procedure TDBChartCrossTabEditor.BApplyClick(Sender: TObject);

  Function GetFieldCombo(Combo:TComboBox):String;
  begin
    With Combo do
    if ItemIndex=-1 then result:=Text
                    else result:=Items[ItemIndex];
  end;

begin
  inherited;

  CheckReplaceSource(DataSource);

  TheSeries.Tag:=0;

  with DataSource do
  begin
    Case CBAgg.ItemIndex of
      0: Formula:=gfSum;
    else
      Formula:=gfCount;
    end;

    ValueField:=GetFieldCombo(CBValue);
    GroupField:=GetFieldCombo(CBGroup);
    LabelField:=GetFieldCombo(CBLabels);
    DataSet:=Self.DataSet;

    CaseSensitive:=CBCase.Checked;
    Active:=CBActive.Checked;
  end;

  BApply.Enabled:=False;
end;

procedure TDBCrossTabSource.Load;
begin
  if Assigned(Series) and Assigned(DataSet) and
     (ValueField<>'') and DataSet.Active then
         LoadDataSet;
end;

procedure TDBChartCrossTabEditor.CBAggChange(Sender: TObject);
begin
  inherited;
  BApply.Enabled:=True;
end;

procedure TDBChartCrossTabEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(DataSource) and
     (not Assigned(DataSource.Series)) then
          DataSource.Free;
  inherited;
end;

type TDBChartDataSourceAccess=class(TDBChartDataSource);

procedure TDBCrossTabSource.SetDataSet(const Value: TDataSet);
begin
  if FDataSet<>Value then
  begin
    Close;
    FDataSet:=Value;

    ISource.Free;
    ISource:=TDBChartDataSource.Create(nil); { 5.02 }

    // No "with" here due to CLR restriction...
    TDBChartDataSourceAccess(ISource).SetDataSet(FDataSet);
    TDBChartDataSourceAccess(ISource).OnCheckDataSet:=DataSourceCheckDataSet;
    TDBChartDataSourceAccess(ISource).OnCloseDataSet:=DataSourceCloseDataSet;
  end;
end;

procedure TDBCrossTabSource.RemoveSeries;
var t : Integer;
begin
  t:=0;
  if Assigned(Series.ParentChart) then
  with Series.ParentChart do
  while t<SeriesCount do
    if (Series[t]<>Self.Series) and (TChartSeries(Series[t].Tag)=Self.Series) then
        Series[t].Free
    else
      Inc(t);

  if not (csDestroying in Series.ComponentState) then
  begin
    Series.Clear;
    Series.Title:='';
  end;
end;

procedure TDBCrossTabSource.DataSourceCloseDataSet(ADataSet: TDataSet);
begin
  if (not KeepDataOnClose) and Assigned(Series) then
     RemoveSeries;
end;

procedure TDBCrossTabSource.SetActive(const Value:Boolean);
begin
  inherited;
  if not Active then DataSourceCloseDataSet(DataSet);
end;

procedure TDBCrossTabSource.DataSourceCheckDataSet(ADataSet: TDataSet);
begin
  Refresh;
end;

class function TDBCrossTabSource.Available(AChart: TCustomAxisPanel):Boolean;
begin
  result:=AChart is TCustomChart;
end;

procedure TDBCrossTabSource.SetFormula(const Value: TGroupFormula);
begin
  if FFormula<>Value then
  begin
    Close;
    FFormula:=Value;
  end;
end;

procedure TDBCrossTabSource.SetGroup(const Value: String);
begin
  if FGroup<>Value then
  begin
    Close;
    FGroup:=Value;
  end;
end;

procedure TDBCrossTabSource.SetLabel(const Value: String);
begin
  if FLabel<>Value then
  begin
    Close;
    FLabel:=Value;
  end;
end;

procedure TDBCrossTabSource.SetValue(const Value: String);
begin
  if FValue<>Value then
  begin
    Close;
    FValue:=Value;
  end;
end;

destructor TDBCrossTabSource.Destroy;
begin
  ISource.Free;
  inherited;
end;

procedure TDBChartCrossTabEditor.CBActiveClick(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TDBCrossTabSource.SetCase(const Value: Boolean);
begin
  if FCase<>Value then
  begin
    Close;
    FCase:=Value;
  end;
end;

procedure TDBChartCrossTabEditor.CBCaseClick(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

initialization
  RegisterClass(TDBCrossTabSource);
  TeeSources.Add({$IFDEF CLR}TObject{$ENDIF}(TDBCrossTabSource));
finalization
  TeeSources.Remove({$IFDEF CLR}TObject{$ENDIF}(TDBCrossTabSource));
end.
