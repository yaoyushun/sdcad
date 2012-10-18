{**********************************************}
{   TRotateTool Editor                         }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeRotateToolEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls,
     {$ENDIF}
     TeeTools, TeCanvas, TeePenDlg;

type
  TRotateToolEditor = class(TForm)
    CBInverted: TCheckBox;
    Label1: TLabel;
    CBStyle: TComboFlat;
    CBButton: TComboFlat;
    Label2: TLabel;
    BOutline: TButtonPen;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBButtonChange(Sender: TObject);
  private
    { Private declarations }
    Tool : TRotateTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TRotateToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TRotateToolEditor.FormShow(Sender: TObject);
begin
  Tool:=TRotateTool(Tag);
  if Assigned(Tool) then
  with Tool do
  begin
    CBInverted.Checked:=Inverted;
    CBStyle.ItemIndex:=Ord(Style);

    // 6.01
    case Button of
      mbLeft: CBButton.ItemIndex:=0;
      mbMiddle: CBButton.ItemIndex:=1;
    else
      CBButton.ItemIndex:=2;
    end;

    BOutline.LinkPen(Pen);
  end;
end;

procedure TRotateToolEditor.CBInvertedClick(Sender: TObject);
begin
  Tool.Inverted:=CBInverted.Checked;
end;

procedure TRotateToolEditor.CBStyleChange(Sender: TObject);
begin
  Tool.Style:=TRotateToolStyles(CBStyle.ItemIndex);
end;

procedure TRotateToolEditor.CBButtonChange(Sender: TObject);
begin
  // 6.01
  Case CBButton.ItemIndex of
    0: Tool.Button:=mbLeft;
    1: Tool.Button:=mbMiddle;
  else
    Tool.Button:=mbRight;
  end;
end;

initialization
  RegisterClass(TRotateToolEditor);
end.
