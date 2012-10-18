{*****************************************}
{  TeeExtraLegend Tool                    }
{  Copyright (c) 2002-2004 David Berneda  }
{*****************************************}
unit TeeExtraLegendTool;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     Borland.VCL.StdCtrls,
     SysUtils,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
     {$ENDIF}
     {$ENDIF}
     Chart, TeEngine, TeeTools, TeeToolSeriesEdit, TeCanvas;

type
  TExtraLegendTool=class(TTeeCustomToolSeries)
  private
    FLegend: TChartLegend;
    function GetLegend:TChartLegend;
    procedure SetLegend(const Value: TChartLegend);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class Function GetEditorClass:String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Destructor Destroy; override;
    class Function Description:String; override;
  published
    property Legend:TChartLegend read GetLegend write SetLegend;
    property Series;
  end;

  TExtraLegendEditor = class(TSeriesToolEditor)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeEdiLege, TeeProCo;

function TExtraLegendTool.GetLegend:TChartLegend;
begin
  if not Assigned(FLegend) then
  begin
    FLegend:=TChartLegend.Create(ParentChart);
    FLegend.CustomPosition:=True;
    FLegend.LegendStyle:=lsValues;
  end;
  result:=FLegend;
end;

Destructor TExtraLegendTool.Destroy;
begin
  FreeAndNil(FLegend);
  inherited;
end;

procedure TExtraLegendTool.SetLegend(const Value: TChartLegend);
begin
  FLegend.Assign(Value);
end;

procedure TExtraLegendTool.SetParentChart(const Value: TCustomAxisPanel);
var tmp : TNotifyEvent;
begin
  inherited;
  if Assigned(FLegend) then
  begin
    if Assigned(Value) then tmp:=Value.CanvasChanged
                       else tmp:=nil;
    FLegend.DividingLines.OnChange:=tmp;
    FLegend.ParentChart:=Value;
  end;
end;

procedure TExtraLegendTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if (AEvent=cteAfterDraw) then
  begin
    if Assigned(ParentChart) and Assigned(Series) then
    begin
      Legend.Series:=Series; // call getter
      if Legend.Visible then Legend.DrawLegend;
    end;
  end;
end;

class function TExtraLegendTool.GetEditorClass: String;
begin
  result:='TExtraLegendEditor';
end;

procedure TExtraLegendEditor.Button1Click(Sender: TObject);
begin
  with TFormTeeLegend.Create(Self) do
  try
    Legend:=TExtraLegendTool({$IFDEF CLR}TObject{$ENDIF}(Self.Tag)).Legend;
    ShowModal;
  finally
    Free;
  end;
end;

class function TExtraLegendTool.Description: String;
begin
  result:=TeeMsg_ExtraLegendTool;
end;

procedure TExtraLegendTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

initialization
  RegisterClass(TExtraLegendEditor);
  RegisterTeeTools([TExtraLegendTool]);
finalization
  UnRegisterTeeTools([TExtraLegendTool]);
end.
