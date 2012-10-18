{********************************************}
{    TeeChart ColorLine Tool Editor          }
{   Copyright (c) 2000-2004 by David Berneda }
{********************************************}
unit TeeColorLineEditor;
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
     TeeAxisToolEdit, TeCanvas, TeeTools, TeePenDlg;

type
  TColorLineToolEditor = class(TAxisToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    EValue: TEdit;
    TabSheet2: TTabSheet;
    CBAllowDrag: TCheckBox;
    CBDragRepaint: TCheckBox;
    CBNoLimitDrag: TCheckBox;
    CBDrawBehind: TCheckBox;
    CBDraw3D: TCheckBox;
    Label3: TLabel;
    CBStyle: TComboFlat;
    procedure EValueChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBAllowDragClick(Sender: TObject);
    procedure CBDragRepaintClick(Sender: TObject);
    procedure CBNoLimitDragClick(Sender: TObject);
    procedure CBDrawBehindClick(Sender: TObject);
    procedure CBDraw3DClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    CreatingForm  : Boolean;
    ColorLineTool : TColorLineTool;
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

procedure TColorLineToolEditor.EValueChange(Sender: TObject);
begin
  if not CreatingForm then
     with ColorLineTool do Value:=StrToFloatDef(EValue.Text,Value);
end;

procedure TColorLineToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  ColorLineTool:=TColorLineTool(Tag);

  if Assigned(ColorLineTool) then
  with ColorLineTool do
  begin
    EValue.Text:=FloatToStr(Value);
    CBAllowDrag.Checked:=AllowDrag;
    CBDragRepaint.Checked:=DragRepaint;
    CBNoLimitDrag.Checked:=NoLimitDrag;
    CBDraw3D.Checked:=Draw3D;
    CBDrawBehind.Checked:=DrawBehind;
    CBStyle.ItemIndex:=Ord(Style);
    EValue.Enabled:=Style=clCustom;
  end;

  CreatingForm:=False;
end;

procedure TColorLineToolEditor.CBAllowDragClick(Sender: TObject);
begin
  ColorLineTool.AllowDrag:=CBAllowDrag.Checked
end;

procedure TColorLineToolEditor.CBDragRepaintClick(Sender: TObject);
begin
  ColorLineTool.DragRepaint:=CBDragRepaint.Checked;
end;

procedure TColorLineToolEditor.CBNoLimitDragClick(Sender: TObject);
begin
  ColorLineTool.NoLimitDrag:=CBNoLimitDrag.Checked;
end;

procedure TColorLineToolEditor.CBDrawBehindClick(Sender: TObject);
begin
  ColorLineTool.DrawBehind:=CBDrawBehind.Checked;
end;

procedure TColorLineToolEditor.CBDraw3DClick(Sender: TObject);
begin
  ColorLineTool.Draw3D:=CBDraw3D.Checked;
end;

procedure TColorLineToolEditor.CBStyleChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    ColorLineTool.Style:=TColorLineStyle(CBStyle.ItemIndex);
    EValue.Enabled:=ColorLineTool.Style=clCustom;
  end;
end;

procedure TColorLineToolEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  inherited;
end;

initialization
  RegisterClass(TColorLineToolEditor);
end.
