{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeDBEdit;
{$I TeeDefs.inc}

interface

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
  DB, TeEngine, TeeSourceEdit, TeCanvas;

type
  TBaseDBChartEditor = class(TBaseSourceEditor)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure FillSourceDatasets;
    procedure FillSources;
  protected
    Function DataSet:TDataSet;
    Procedure FillFields(const Combos:Array of TComboBox);
    Function IsValid(AComponent:TComponent):Boolean; override;
  public
    { Public declarations }
  end;

  TTeeSeriesDBSource=class(TTeeSeriesSource)
  public
    class Function Available(AChart:TCustomAxisPanel):Boolean; override;
    class function HasNew: Boolean; override;
  end;

var OnGetDesignerNames : TOnGetDesignerNamesEvent=nil;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses DBChart, Chart, TeeConst;

procedure TBaseDBChartEditor.FillSourceDatasets;
begin
  CBSources.Items.Clear;
  FillSources;
end;

Function TBaseDBChartEditor.IsValid(AComponent:TComponent):Boolean;
begin
  result:=AComponent is TDataSet;
end;

procedure TBaseDBChartEditor.FillSources;

  Procedure FillSourcesForm(ARoot:TComponent);
  var t : Integer;  { 5.01 }
  begin
    if Assigned(ARoot) and
       (ARoot<>Self) and
       (ARoot<>Self.Owner.Owner) then
    With ARoot do
    for t:=0 to ComponentCount-1 do
        AddComponentDataSource(Components[t],CBSources.Items,True);
  end;

var t : Integer;
begin
  if Assigned(TheSeries) then
  begin
    if (csDesigning in TheSeries.ComponentState) and
       Assigned(OnGetDesignerNames) then
          OnGetDesignerNames(AddComponentDataSource,TheSeries,CBSources.Items,
                             True)
    else
    begin
      With Screen do
      begin
        for t:=0 to DataModuleCount-1 do FillSourcesForm(DataModules[t]);
        for t:=0 to FormCount-1 do FillSourcesForm(Forms[t]); { 5.01 }
      end;

      if Assigned(TheSeries.ParentChart) then
      begin
        FillSourcesForm(TheSeries.ParentChart);        { 5.01 }
        FillSourcesForm(TheSeries.ParentChart.Owner);  { 5.01 }
      end;
    end;
  end;
end;

procedure TBaseDBChartEditor.FormShow(Sender: TObject);
begin
  inherited;
  LLabel.Caption:=TeeMsg_AskDataSet;
  FillSourceDatasets;

  if Assigned(TheSeries) and Assigned(TheSeries.DataSource) then
  With CBSources do
       ItemIndex:=Items.IndexOfObject(TheSeries.DataSource);
end;

function TBaseDBChartEditor.DataSet: TDataSet;
begin
  With CBSources do
  if ItemIndex=-1 then result:=nil
                  else result:=TDataSet(Items.Objects[ItemIndex]);
end;

Procedure TBaseDBChartEditor.FillFields(const Combos:Array of TComboBox);

  Procedure AddField(Const tmpSt:String; tmpType:TFieldType);
  var t : Integer;
  begin
    Case TeeFieldType(tmpType) of
       tftNumber,
       tftDateTime,
       tftText     : begin
                       for t:=Low(Combos) to High(Combos) do
                           Combos[t].Items.Add(tmpSt);
                     end;
    end;
  end;

Var t : Integer;
Begin
  for t:=Low(Combos) to High(Combos) do
      Combos[t].Clear;

  if DataSet<>nil then
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

{ TTeeSeriesDBSource }

class function TTeeSeriesDBSource.Available(AChart: TCustomAxisPanel):Boolean;
begin
  result:=AChart is TCustomDBChart;
end;

class function TTeeSeriesDBSource.HasNew: Boolean;
begin
  result:=True;
end;

initialization
finalization
  OnGetDesignerNames:=nil;
end.
