{********************************************}
{   TeeChart Pro TVolumeSeries Editor        }
{   Copyright (c) 1998-2004 by David Berneda }
{********************************************}
unit TeeVolEd;
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
     Chart, TeEngine, CandleCh, TeCanvas, TeePenDlg;

type
  TVolumeSeriesEditor = class(TPenDialog)
    CBColorEach: TCheckBox;
    CBUseOrigin: TCheckBox;
    Label2: TLabel;
    EOrigin: TEdit;
    procedure FormShow(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure BColorClick(Sender: TObject);
    procedure CBUseOriginClick(Sender: TObject);
    procedure EOriginChange(Sender: TObject);
  private
    { Private declarations }
    TheSeries   : TVolumeSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeProcs;

procedure TVolumeSeriesEditor.FormShow(Sender: TObject);
begin
  TheSeries:=TVolumeSeries(Tag);
  if Assigned(TheSeries) then
  begin
    ThePen:=TheSeries.Pen;
    inherited;
    BColor.Enabled:=not TheSeries.ColorEachPoint;
    CBColorEach.Checked:=TheSeries.ColorEachPoint;
    CBColorEach.Top:=102;
    CBUseOrigin.Checked:=TheSeries.UseYOrigin;
    EOrigin.Text:=FloatToStr(TheSeries.YOrigin);
    EOrigin.Enabled:=TheSeries.UseYOrigin;
  end;
end;

procedure TVolumeSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=CBColorEach.Checked;
  BColor.Enabled:=not TheSeries.ColorEachPoint;
end;

procedure TVolumeSeriesEditor.BColorClick(Sender: TObject);
begin
  inherited;
  TheSeries.SeriesColor:=ThePen.Color;
end;

procedure TVolumeSeriesEditor.CBUseOriginClick(Sender: TObject);
begin
  TheSeries.UseYOrigin:=CBUseOrigin.Checked;
  EOrigin.Enabled:=TheSeries.UseYOrigin;
end;

procedure TVolumeSeriesEditor.EOriginChange(Sender: TObject);
begin
  if Showing then
     with TheSeries do YOrigin:=StrToFloatDef(EOrigin.Text,YOrigin);
end;

initialization
  RegisterClass(TVolumeSeriesEditor);
end.
