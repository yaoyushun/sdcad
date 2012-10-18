{**********************************************}
{   TArrowSeries Editor Dialog                 }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeArrowEdi;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls,  Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  ArrowCha, TeCanvas, TeePenDlg, TeeProcs;

type
  TArrowSeriesEditor = class(TForm)
    BPen: TButtonPen;
    BBrush: TButton;
    Label1: TLabel;
    SEArrowWidth: TEdit;
    Label2: TLabel;
    SEArrowHeight: TEdit;
    GroupBox1: TGroupBox;
    CBColorEach: TCheckBox;
    BArrowColor: TButtonColor;
    UDArrowWidth: TUpDown;
    UDArrowHeight: TUpDown;
    procedure CBColorEachClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure SEArrowWidthChange(Sender: TObject);
    procedure SEArrowHeightChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Arrow : TArrowSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeEngine;

procedure TArrowSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Arrow.ColorEachPoint:=CBColorEach.Checked;
  BArrowColor.Enabled:=not Arrow.ColorEachPoint;
  if Arrow.ColorEachPoint then Arrow.Pointer.Color:=clTeeColor;
end;

procedure TArrowSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Arrow.Pointer.Brush);
end;

procedure TArrowSeriesEditor.SEArrowWidthChange(Sender: TObject);
begin
  if Showing then Arrow.ArrowWidth:=UDArrowWidth.Position;
end;

procedure TArrowSeriesEditor.SEArrowHeightChange(Sender: TObject);
begin
  if Showing then Arrow.ArrowHeight:=UDArrowHeight.Position;
end;

procedure TArrowSeriesEditor.FormShow(Sender: TObject);
begin
  Arrow:=TArrowSeries(Tag);
  if Assigned(Arrow) then
  begin
    With Arrow do
    begin
      CBColorEach.Checked    :=ColorEachPoint;
      UDArrowWidth.Position  :=ArrowWidth;
      UDArrowHeight.Position :=ArrowHeight;
      BPen.LinkPen(Pointer.Pen);
    end;
    BArrowColor.LinkProperty(Arrow,'SeriesColor');
  end;
end;

procedure TArrowSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(TArrowSeriesEditor);
end.
