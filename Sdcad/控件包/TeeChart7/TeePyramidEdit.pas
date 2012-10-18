{**********************************************}
{   TPyramidSeries Editor dialog               }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeePyramidEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeCanvas, TeePenDlg, TeePyramid, TeeProcs;

type
  TPyramidSeriesEditor = class(TForm)
    BPen: TButtonPen;
    CBColorEach: TCheckBox;
    BColor: TButtonColor;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UDSize: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Pyramid : TPyramidSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg;

procedure TPyramidSeriesEditor.FormShow(Sender: TObject);
begin
  Pyramid:=TPyramidSeries(Tag);
  if Assigned(Pyramid) then
  begin
    With Pyramid do
    begin
      BPen.LinkPen(Pen);
      UDSize.Position:=SizePercent;
      CBColorEach.Checked:=ColorEachPoint;
      BColor.Enabled:=not ColorEachPoint;
    end;
    BColor.LinkProperty(Pyramid,'SeriesColor');
  end;
end;

procedure TPyramidSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Pyramid.Brush);
end;

procedure TPyramidSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Pyramid.ColorEachPoint:=CBColorEach.Checked;
  BColor.Enabled:=not Pyramid.ColorEachPoint;
end;

procedure TPyramidSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Pyramid.SizePercent:=UDSize.Position;
end;

procedure TPyramidSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TPyramidSeriesEditor);
end.
