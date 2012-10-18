{**********************************************}
{   TeeChart Clock Series Editor               }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeClockEditor;
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
     TeePolarEditor, TeCanvas, TeePenDlg;

type
  TClockEditor = class(TPolarSeriesEditor)
    CBRoman: TCheckBox;
    BHour: TButtonPen;
    BMinute: TButtonPen;
    BSecond: TButtonPen;
    BRadius: TButtonPen;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBRomanClick(Sender: TObject);
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

Uses TeeRose;

procedure TClockEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CBColorEach.Hide;
  // inherited class does this:
//  ShowControls(False,
//    [CBClockWise,CBClose,UDRadiusInc,SERadiusInc,Label8,BPen,BColorEach]);
end;

procedure TClockEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
  With TClockSeries(Tag) do
  begin
    CBRoman.Checked:=Style=cssRoman;
    BHour.LinkPen(PenHours);
    BMinute.LinkPen(PenMinutes);
    BSecond.LinkPen(PenSeconds);
    BRadius.LinkPen(GetHorizAxis.Grid);
  end;
end;

procedure TClockEditor.CBRomanClick(Sender: TObject);
begin
  with TClockSeries(Tag) do
  if CBRoman.Checked then Style:=cssRoman else Style:=cssDecimal;
end;

initialization
  RegisterClass(TClockEditor);
end.
