{**********************************************}
{   TDrawLineTool Editor                       }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeDrawLineEditor;
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
     TeCanvas, TeePenDlg, TeeTools, TeeToolSeriesEdit;

type
  TDrawLineEdit = class(TSeriesToolEditor)
    Label11: TLabel;
    CBButton: TComboFlat;
    BPen: TButtonPen;
    CBEnable: TCheckBox;
    CBSelect: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBButtonChange(Sender: TObject);
    procedure CBEnableClick(Sender: TObject);
    procedure CBSelectClick(Sender: TObject);
  private
    { Private declarations }
    Draw : TDrawLineTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TDrawLineEdit.FormShow(Sender: TObject);
begin
  inherited;
  Draw:=TDrawLineTool(Tag);
  if Assigned(Draw) then
  begin
    CBButton.ItemIndex:=Ord(Draw.Button);
    CBEnable.Checked:=Draw.EnableDraw;
    CBSelect.Checked:=Draw.EnableSelect;
    BPen.LinkPen(Draw.Pen);
  end;
end;

procedure TDrawLineEdit.CBButtonChange(Sender: TObject);
begin
  Draw.Button:=TMouseButton(CBButton.ItemIndex);
end;

procedure TDrawLineEdit.CBEnableClick(Sender: TObject);
begin
  Draw.EnableDraw:=CBEnable.Checked
end;

procedure TDrawLineEdit.CBSelectClick(Sender: TObject);
begin
  Draw.EnableSelect:=CBSelect.Checked
end;

initialization
  RegisterClass(TDrawLineEdit);
end.
