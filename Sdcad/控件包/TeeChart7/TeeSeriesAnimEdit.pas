{******************************************}
{ TSeriesAnimationTool Editor Dialog       }
{ Copyright (c) 2002-2004 by David Berneda }
{******************************************}
unit TeeSeriesAnimEdit;
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
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  TeeToolSeriesEdit, TeCanvas, TeeProcs, TeeTools;

type
  TSeriesAnimToolEditor = class(TSeriesToolEditor)
    Label2: TLabel;
    SBSteps: TScrollBar;
    Label3: TLabel;
    CBStartMin: TCheckBox;
    Label4: TLabel;
    EStart: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label6: TLabel;
    ComboFlat1: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBStartMinClick(Sender: TObject);
    procedure EStartChange(Sender: TObject);
    procedure SBStepsChange(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboFlat1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    AnimTool : TSeriesAnimationTool;
    procedure StopAnimation;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeProCo;

procedure TSeriesAnimToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  AnimTool:=TSeriesAnimationTool(Tag);
  if Assigned(AnimTool) then
  With AnimTool do
  begin
    SBSteps.Position:=Steps;
    Label3.Caption:=IntToStr(Steps);
    CBStartMin.Checked:=StartAtMin;
    EStart.Text:=FloatToStr(StartValue);
    EStart.Enabled:=not CBStartMin.Checked;
    UpDown1.Position:=DrawEvery;
    Button1.Enabled:=Assigned(Series);

    if Loop=salNo then ComboFlat1.ItemIndex:=0
    else
    if Loop=salOneWay then ComboFlat1.ItemIndex:=1
    else
       ComboFlat1.ItemIndex:=2;

    if AnimTool.Running then
    begin
      Button1.Tag:=1;
      Button1.Caption:=TeeMsg_Stop;
    end;
  end;
end;

procedure TSeriesAnimToolEditor.StopAnimation;
begin
  AnimTool.Stop;
  Button1.Tag:=0;
  Button1.Caption:=TeeMsg_Execute;
end;

procedure TSeriesAnimToolEditor.Button1Click(Sender: TObject);
begin
  if Button1.Tag=1 then StopAnimation
  else
  begin
    Button1.Tag:=1;
    Button1.Caption:=TeeMsg_Stop;
    AnimTool.Execute;
    StopAnimation;
  end;
end;

procedure TSeriesAnimToolEditor.CBStartMinClick(Sender: TObject);
begin
  AnimTool.StartAtMin:=CBStartMin.Checked;
  EStart.Enabled:=not CBStartMin.Checked;
end;

procedure TSeriesAnimToolEditor.EStartChange(Sender: TObject);
begin
  AnimTool.StartValue:=StrToFloatDef(EStart.Text,AnimTool.StartValue);
end;

procedure TSeriesAnimToolEditor.SBStepsChange(Sender: TObject);
begin
  AnimTool.Steps:=SBSteps.Position;
  Label3.Caption:=IntToStr(AnimTool.Steps);
end;

procedure TSeriesAnimToolEditor.CBSeriesChange(Sender: TObject);
begin
  inherited;
  Button1.Enabled:=Assigned(AnimTool.Series);
end;

procedure TSeriesAnimToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     AnimTool.DrawEvery:=UpDown1.Position;
end;

procedure TSeriesAnimToolEditor.ComboFlat1Change(Sender: TObject);
begin
  case ComboFlat1.ItemIndex of
    0: AnimTool.Loop:=salNo;
    1: AnimTool.Loop:=salOneWay;
  else
    AnimTool.Loop:=salCircular;
  end;
end;

procedure TSeriesAnimToolEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose:=(not Assigned(AnimTool)) or (not AnimTool.Running);
end;

initialization
  RegisterClass(TSeriesAnimToolEditor);
end.
