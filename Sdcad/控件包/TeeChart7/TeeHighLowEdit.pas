{**********************************************}
{   TeeChart HighLow Series Editor             }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeHighLowEdit;
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
     ErrorBar, TeCanvas, TeePenDlg, TeeProcs;

type
  THighLowEditor = class(TForm)
    BPen: TButtonPen;
    BHighPen: TButtonPen;
    BLowPen: TButtonPen;
    BBrush: TButton;
    CBColorEach: TCheckBox;
    BLowBrush: TButton;
    BColor: TButtonColor;
    Label1: TLabel;
    Edit1: TEdit;
    UDTransp: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure BLowBrushClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    HighLow : THighLowSeries;
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

procedure THighLowEditor.FormShow(Sender: TObject);
begin
  HighLow:=THighLowSeries(Tag);
  if Assigned(HighLow) then
  begin
    With HighLow do
    begin
      CBColorEach.Checked:=ColorEachPoint;
      BLowPen.LinkPen(LowPen);
      BHighPen.LinkPen(HighPen);
      BPen.LinkPen(Pen);
      UDTransp.Position:=Transparency;
    end;
    BColor.LinkProperty(HighLow,'SeriesColor');
  end;
end;

procedure THighLowEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,HighLow.HighBrush);
end;

procedure THighLowEditor.BLowBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,HighLow.LowBrush);
end;

procedure THighLowEditor.CBColorEachClick(Sender: TObject);
begin
  HighLow.ColorEachPoint:=CBColorEach.Checked;
end;

procedure THighLowEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure THighLowEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     HighLow.Transparency:=UDTransp.Position;
end;

initialization
  RegisterClass(THighLowEditor);
end.
