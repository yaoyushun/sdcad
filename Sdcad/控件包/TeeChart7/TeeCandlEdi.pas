{**********************************************}
{   TCandleSeries Component Editor Dialog      }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeCandlEdi;
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
     Chart, Series, CandleCh, TeCanvas, TeePenDlg, TeeProcs;

type
  TCandleEditor = class(TForm)
    RGStyle: TRadioGroup;
    Label1: TLabel;
    SEWidth: TEdit;
    CBShowOpen: TCheckBox;
    CBShowClose: TCheckBox;
    Button1: TButtonPen;
    UDWidth: TUpDown;
    CBDraw3D: TCheckBox;
    CBDark3D: TCheckBox;
    BUpColor: TButtonColor;
    BDownColor: TButtonColor;
    BHighLow: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure SEWidthChange(Sender: TObject);
    procedure CBShowOpenClick(Sender: TObject);
    procedure CBShowCloseClick(Sender: TObject);
    procedure CBDraw3DClick(Sender: TObject);
    procedure CBDark3DClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Candle : TCandleSeries;
    Procedure RefreshControls;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Procedure TCandleEditor.RefreshControls;
begin
  CBShowOpen.Enabled :=Candle.CandleStyle=csCandleBar;
  CBShowClose.Enabled:=CBShowOpen.Enabled;
  CBDraw3D.Enabled:=(Candle.CandleStyle<>csLine) and (not CBShowOpen.Enabled);
  CBDark3D.Enabled:=CBDraw3D.Enabled;

  SEWidth.Enabled:=(Candle.CandleStyle<>csLine);
  UDWidth.Enabled:=SEWidth.Enabled;
  Button1.HideColor:=(Candle.CandleStyle=csLine) or (Candle.CandleStyle=csCandleBar);
end;

procedure TCandleEditor.FormShow(Sender: TObject);
begin
  Candle:=TCandleSeries(Tag);
  if Assigned(Candle) then
  begin
    With Candle do
    begin
      Case CandleStyle of
        csCandleStick: RGStyle.ItemIndex:=0;
        csCandleBar:   RGStyle.ItemIndex:=1;
        csLine:        RGStyle.ItemIndex:=3;
      else RGStyle.ItemIndex:=2;
      end;

      UDWidth.Position      :=CandleWidth;
      CBShowOpen.Checked    :=ShowOpenTick;
      CBShowClose.Checked   :=ShowCloseTick;
      CBDraw3D.Checked      :=Draw3D;
      CBDark3D.Checked      :=Dark3D;

      Button1.LinkPen(Pen);
      BHighLow.LinkPen(HighLowPen);

      RefreshControls;
    end;
    BUpColor.LinkProperty(Candle,'UpCloseColor');
    BDownColor.LinkProperty(Candle,'DownCloseColor');
  end;
end;

procedure TCandleEditor.RGStyleClick(Sender: TObject);
begin
  with Candle do
  Case RGStyle.ItemIndex of
    0: CandleStyle:=csCandleStick;
    1: CandleStyle:=csCandleBar;
    2: CandleStyle:=csOpenClose;
    3: CandleStyle:=csLine;
  end;

  RefreshControls;
end;

procedure TCandleEditor.SEWidthChange(Sender: TObject);
begin
  if Showing then Candle.CandleWidth:=UDWidth.Position;
end;

procedure TCandleEditor.CBShowOpenClick(Sender: TObject);
begin
  Candle.ShowOpenTick:=CBShowOpen.Checked;
end;

procedure TCandleEditor.CBShowCloseClick(Sender: TObject);
begin
  Candle.ShowCloseTick:=CBShowClose.Checked;
end;

procedure TCandleEditor.CBDraw3DClick(Sender: TObject);
begin
  Candle.Draw3D:=CBDraw3D.Checked;
end;

procedure TCandleEditor.CBDark3DClick(Sender: TObject);
begin
  Candle.Dark3D:=CBDark3D.Checked;
end;

procedure TCandleEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TCandleEditor);
end.
