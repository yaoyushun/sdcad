{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeDBSourceEditor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, DB,
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  {$IFDEF CLX}
  Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$IFNDEF TEELITE}
  QDBCtrls,
  {$ENDIF}
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, 
  {$IFNDEF TEELITE}
  DBCtrls,
  {$ENDIF}
  {$ENDIF}
  Chart, TeEngine, TeeDBEdit, TeeSelectList, TeCanvas;

type
  TDBChartSourceEditor = class(TBaseDBChartEditor)
    procedure BApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  
    {$IFNDEF TEELITE}
    INavig   : TDBNavigator;
    {$ENDIF}

    ISources : TSelectListForm;
    Procedure FillFields;
    Function DataSource:TDataSource;
    procedure OnChangeSources(Sender: TObject);
  protected
    Function IsValid(AComponent:TComponent):Boolean; override;
  public
    { Public declarations }
  end;

  TSingleRecordSeriesSource=class(TTeeSeriesDBSource)
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

Uses
  DBChart, TeeProcs, TeeConst, TeePenDlg;

Function TDBChartSourceEditor.IsValid(AComponent:TComponent):Boolean;
begin
  result:=AComponent is TDataSource;
end;

procedure TDBChartSourceEditor.BApplyClick(Sender: TObject);
var tmpSt : String;
    t     : Integer;
begin
  inherited;
  TheSeries.DataSource:=nil;
  With ISources.ToList do
  if Items.Count>0 then
  begin
    tmpSt:=Items[0];
    for t:=1 to Items.Count-1 do
        tmpSt:=tmpSt+';'+Items[t];
  end
  else tmpSt:='';
  TheSeries.MandatoryValueList.ValueSource:=tmpSt;
  TheSeries.DataSource:=DataSource;

  {$IFNDEF TEELITE}
  INavig.DataSource:=DataSource;
  {$ENDIF}

  BApply.Enabled:=False;
end;

Function TDBChartSourceEditor.DataSource:TDataSource;
begin
  With CBSources do
  if ItemIndex=-1 then result:=nil
                  else result:=TDataSource(Items.Objects[CBSources.ItemIndex]);
end;

procedure TDBChartSourceEditor.OnChangeSources(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TDBChartSourceEditor.FormShow(Sender: TObject);
begin
  inherited;

  LLabel.Caption:=TeeMsg_AskDataSource;
  ISources:=TSelectListForm.Create(Self);
  ISources.Align:=alClient;
  ISources.OnChange:=OnChangeSources;
  AddFormTo(ISources,Self,Tag);

  {$IFNDEF TEELITE}
  INavig:=TDBNavigator.Create(Self);
  With INavig do
  begin
    VisibleButtons:=[nbFirst, nbPrior, nbNext, nbLast, nbRefresh];
    Flat:=True;
    Parent:=ISources;
    Align:=alBottom;
  end;
  {$ENDIF}

  FillFields;
end;

procedure TDBChartSourceEditor.CBSourcesChange(Sender: TObject);
begin
  inherited;
  FillFields;
  TheSeries.XLabelsSource:='';
end;

Procedure TDBChartSourceEditor.FillFields;

    Procedure AddField(Const tmpSt:String; tmpType:TFieldType);
    begin
      Case TeeFieldType(tmpType) of
      tftNumber,
     tftDateTime: ISources.FromList.Items.Add(tmpSt);
      end;
    end;

    Procedure AddAggregateFields;
    var t : Integer;
    begin
       With DataSource.DataSet do
       for t:=0 to AggFields.Count-1 do
           AddField(AggFields[t].FieldName,ftFloat);
    end;

var tmpSt : String;
    tmpField : String;
    t     : Integer;
begin
  ISources.FromList.Clear;
  ISources.ToList.Clear;

  {$IFNDEF TEELITE}
  INavig.DataSource:=DataSource;
  {$ENDIF}

  if (DataSource<>nil) and (DataSource.DataSet<>nil) then
  begin
    With DataSource.DataSet do
    if FieldCount>0 then
    begin
       for t:=0 to FieldCount-1 do
           AddField(Fields[t].FieldName,Fields[t].DataType);
       AddAggregateFields;
    end
    else
    begin
      FieldDefs.Update;
      for t:=0 to FieldDefs.Count-1 do
          AddField(FieldDefs[t].Name,FieldDefs[t].DataType);
      AddAggregateFields;
    end;

    tmpSt:=TheSeries.MandatoryValueList.ValueSource;
    for t:=1 to TeeNumFields(tmpSt) do
    begin
      tmpField:=TeeExtractField(tmpSt,t);
      With ISources.FromList.Items do
      if IndexOf(tmpField)<>-1 then
      begin
        ISources.ToList.Items.Add(tmpField);
        Delete(IndexOf(tmpField));
      end;
    end;
  end;

  ISources.EnableButtons;
end;

procedure TDBChartSourceEditor.FormDestroy(Sender: TObject);
begin
  {$IFNDEF TEELITE}
  INavig.Free;
  {$ENDIF}

  inherited;
end;

{ TSingleRecordSeriesSource }

class function TSingleRecordSeriesSource.Description: String;
begin
  result:=TeeMsg_SingleRecord;
end;

class function TSingleRecordSeriesSource.Editor: TComponentClass;
begin
  result:=TDBChartSourceEditor;
end;

class function TSingleRecordSeriesSource.HasSeries(
  ASeries: TChartSeries): Boolean;
begin
  result:=ASeries.DataSource is TDataSource;
end;

initialization
  TeeSources.Add({$IFDEF CLR}TObject{$ENDIF}(TSingleRecordSeriesSource));
finalization
  TeeSources.Remove({$IFDEF CLR}TObject{$ENDIF}(TSingleRecordSeriesSource));
end.
