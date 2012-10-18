{**********************************************}
{   TBarSeries Component Editor Dialog         }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeStackBarEdit;
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
     Chart, Series, TeCanvas, TeePenDlg, TeeProcs;

type
  TStackBarSeriesEditor = class(TForm)
    CBYOrigin: TCheckBox;
    EYOrigin: TEdit;
    RGMultiBar: TRadioGroup;
    Label1: TLabel;
    EGroup: TEdit;
    UDGroup: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure CBYOriginClick(Sender: TObject);
    procedure EYOriginChange(Sender: TObject);
    procedure RGMultiBarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EGroupChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Bar : TCustomBarSeries;
    Procedure EnableGroup;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TStackBarSeriesEditor.FormShow(Sender: TObject);
begin
  Bar:=TCustomBarSeries(Tag);
  if Assigned(Bar) then
  With Bar do
  begin
    CBYOrigin.Checked    :=UseYOrigin;
    EYOrigin.Text        :=FloatToStr(YOrigin);
    EYOrigin.Enabled     :=UseYOrigin;
    RGMultiBar.ItemIndex :=Ord(MultiBar);
    UDGroup.Position     :=StackGroup;
    EnableGroup;
  end;
  CreatingForm:=False;
end;

procedure TStackBarSeriesEditor.CBYOriginClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.UseYOrigin:=CBYOrigin.Checked;
    EYOrigin.Enabled:=Bar.UseYOrigin;
    if EYOrigin.Enabled then EYOrigin.SetFocus;
  end;
end;

procedure TStackBarSeriesEditor.EYOriginChange(Sender: TObject);
begin
  if not CreatingForm then
     with Bar do YOrigin:=StrToFloatDef(EYOrigin.Text,YOrigin);
end;

procedure TStackBarSeriesEditor.RGMultiBarClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Bar.MultiBar:=TMultiBar(RGMultiBar.ItemIndex);
    EnableGroup;
  end;
end;

Procedure TStackBarSeriesEditor.EnableGroup;
begin
  UDGroup.Enabled:=(Bar.MultiBar=mbStacked) or (Bar.MultiBar=mbStacked100);
  EGroup.Enabled:=UDGroup.Enabled;
end;

procedure TStackBarSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  Align:=alClient;
end;

procedure TStackBarSeriesEditor.EGroupChange(Sender: TObject);
begin
  if not CreatingForm then Bar.StackGroup:=UDGroup.Position
end;

initialization
  RegisterClass(TStackBarSeriesEditor);
end.
