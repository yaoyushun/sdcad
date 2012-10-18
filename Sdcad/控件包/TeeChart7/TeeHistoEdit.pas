{**********************************************}
{   THistogramSeries Component Editor Dialog   }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeeHistoEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     Chart, TeCanvas, TeePenDlg, TeeProcs, StatChar;

type
  THistogramSeriesEditor = class(TForm)
    GroupBox1: TGroupBox;
    CBColorEach: TCheckBox;
    BAreaColor: TButtonColor;
    BAreaLinesPen: TButtonPen;
    BAreaLinePen: TButtonPen;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UDTransp: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    TheSeries    : THistogramSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine, TeeBrushDlg, TeePoEdi;

procedure THistogramSeriesEditor.FormShow(Sender: TObject);
begin
  TheSeries:=THistogramSeries(Tag);
  if Assigned(TheSeries) then
  begin
    With TheSeries do
    begin
      CBColorEach.Checked   :=ColorEachPoint;
      BAreaLinesPen.LinkPen(LinesPen);
      BAreaLinePen.LinkPen(Pen);
      UDTransp.Position:=Transparency;
    end;
    With BAreaColor do
    begin
      LinkProperty(TheSeries,'SeriesColor');
      Enabled:=not TheSeries.ColorEachPoint;
    end;
  end;
  CreatingForm:=False;
end;

procedure THistogramSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=CBColorEach.Checked;
  BAreaColor.Enabled:=not TheSeries.ColorEachPoint;
end;

procedure THistogramSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,TheSeries.Brush);
end;

procedure THistogramSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing and (not CreatingForm) then
     TheSeries.Transparency:=UDTransp.Position;
end;

procedure THistogramSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(THistogramSeriesEditor);
end.
