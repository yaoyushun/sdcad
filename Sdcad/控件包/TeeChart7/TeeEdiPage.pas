{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2004 by David Berneda    }
{**********************************************}
unit TeeEdiPage;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     TeePenDlg, TeCanvas,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeEngine, Chart, TeeEdiGene, TeeNavigator;

type
  TFormTeePage = class(TForm)
    L17: TLabel;
    SEPointsPerPage: TEdit;
    CBScaleLast: TCheckBox;
    LabelPages: TLabel;
    UDPointsPerPage: TUpDown;
    CBPageLegend: TCheckBox;
    ChartPageNavigator1: TChartPageNavigator;
    CBPageNum: TCheckBox;
    procedure SEPointsPerPageChange(Sender: TObject);
    procedure CBScaleLastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBPageLegendClick(Sender: TObject);
    procedure CBPageNumClick(Sender: TObject);
    procedure ChartPageNavigator1ButtonClicked(Index: TTeeNavigateBtn);
  private
    { Private declarations }
    Function Chart:TCustomChart;
    Function PageNumTool(CreateTool:Boolean):TTeeCustomTool;
  public
    { Public declarations }
    Constructor CreateChart(Owner:TComponent; AChart:TCustomChart);
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst;

{ TFormTeePage }
Constructor TFormTeePage.CreateChart(Owner:TComponent; AChart:TCustomChart);
begin
  inherited Create(Owner);
  ChartPageNavigator1.Chart:=AChart;
end;

procedure TFormTeePage.SEPointsPerPageChange(Sender: TObject);
begin
  if Showing then
  begin
    With Chart do
    if SEPointsPerPage.Text='' then MaxPointsPerPage:=0
                               else MaxPointsPerPage:=UDPointsPerPage.Position;
    ChartPageNavigator1ButtonClicked(nbCancel);
  end;
end;

procedure TFormTeePage.CBScaleLastClick(Sender: TObject);
begin
  Chart.ScaleLastPage:=CBScaleLast.Checked;
end;

procedure TFormTeePage.FormShow(Sender: TObject);
var tmp : TTeeCustomTool;
begin
  if Chart<>nil then
  With Chart do
  begin
    UDPointsPerPage.Position :=MaxPointsPerPage;
    CBScaleLast.Checked      :=ScaleLastPage;
    CBPageLegend.Checked     :=Legend.CurrentPage;
    ChartPageNavigator1ButtonClicked(nbCancel);
  end;

  CBPageNum.Visible:=Assigned(TeePageNumToolClass);
  tmp:=PageNumTool(False);
  CBPageNum.Checked:=Assigned(tmp) and tmp.Active;
end;

{ try to find a PageNumber tool in Chart. If not found, create it }
Function TFormTeePage.PageNumTool(CreateTool:Boolean):TTeeCustomTool;
var t   : Integer;
    tmp : TComponent;
begin
  if Chart<>nil then
  with Chart.Tools do
  for t:=0 to Count-1 do
      if Items[t] is TeePageNumToolClass then
      begin
        result:=Items[t];
        exit;
      end;

  { not found }
  if CreateTool then { do create }
  begin
    tmp:=Chart;
    if Assigned(tmp) and Assigned(tmp.Owner) then
       tmp:=tmp.Owner;

    result:=TeePageNumToolClass.Create(tmp);
    result.Name:=TeeGetUniqueName(tmp,TeeMsg_DefaultToolName);

    if Chart<>nil then Chart.Tools.Add(result);
  end
  else
     result:=nil;
end;

procedure TFormTeePage.CBPageLegendClick(Sender: TObject);
begin
  Chart.Legend.CurrentPage:=CBPageLegend.Checked;
end;

procedure TFormTeePage.ChartPageNavigator1ButtonClicked(
  Index: TTeeNavigateBtn);
begin
  With Chart do
      LabelPages.Caption:=Format(TeeMsg_PageOfPages,[Page,NumPages]);
end;

procedure TFormTeePage.CBPageNumClick(Sender: TObject);
begin { show / hide the Page Number tool }
  PageNumTool(True).Active:=(Sender as TCheckBox).Checked; { 5.02 }
end;

function TFormTeePage.Chart: TCustomChart;
begin
  result:=ChartPageNavigator1.Chart;
end;

end.
