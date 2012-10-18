{*****************************************}
{  TAxisArrowTool Editor                  }
{  Copyright (c) 1996-2004 David Berneda  }
{*****************************************}
unit TeeAxisArrowEdit;
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
     TeeAxisToolEdit, TeCanvas, TeePenDlg, TeeTools;

type
  TAxisArrowToolEditor = class(TAxisToolEditor)
    Button1: TButton;
    UDLength: TUpDown;
    ELength: TEdit;
    LL: TLabel;
    Label2: TLabel;
    CBPos: TComboFlat;
    Label3: TLabel;
    Edit1: TEdit;
    UDScroll: TUpDown;
    Label4: TLabel;
    CBInv: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ELC(Sender: TObject);
    procedure CBPosChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBInvClick(Sender: TObject);
  private
    { Private declarations }
    AxisArrowTool : TAxisArrowTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeProCo;

procedure TAxisArrowToolEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,AxisArrowTool.Brush);
end;

procedure TAxisArrowToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  AxisArrowTool:=TAxisArrowTool(Tag);
  if Assigned(AxisArrowTool) then
  begin
    With AxisArrowTool do
    begin
      UDLength.Position:=Length;
      CBPos.ItemIndex:=Ord(Position);
      UDScroll.Position:=ScrollPercent;
      CBInv.Checked:=ScrollInverted;
    end;
  end;
end;

procedure TAxisArrowToolEditor.ELC(Sender: TObject);
begin
  if Showing then AxisArrowTool.Length:=UDLength.Position;
end;

procedure TAxisArrowToolEditor.CBPosChange(Sender: TObject);
begin
  inherited;
  AxisArrowTool.Position:=TAxisArrowToolPosition(CBPos.ItemIndex);
end;

procedure TAxisArrowToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing then AxisArrowTool.ScrollPercent:=UDScroll.Position
end;

procedure TAxisArrowToolEditor.CBInvClick(Sender: TObject);
begin
  AxisArrowTool.ScrollInverted:=TCheckBox(Sender).Checked;
end;

initialization
  RegisterClass(TAxisArrowToolEditor);
end.
