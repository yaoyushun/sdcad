{**********************************************}
{  TTeeFont (or derived) Editor Dialog         }
{  Copyright (c) 1999-2004 by David Berneda    }
{**********************************************}
unit TeeEdiFont;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     Borland.VCL.Controls,
     Borland.VCL.Forms,
     Borland.VCL.StdCtrls,
     Borland.VCL.ExtCtrls,
     Borland.VCL.ComCtrls,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeCanvas, TeePenDlg;

type
  TTeeFontEditor = class(TForm)
    Button3: TButton;
    SHText: TShape;
    Label2: TLabel;
    Edit2: TEdit;
    UDInter: TUpDown;
    BOutline: TButtonPen;
    BShadow: TButton;
    BGradient: TButton;
    CBOutGrad: TCheckBox;
    procedure BFontClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SHTextMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit2Change(Sender: TObject);
    procedure BShadowClick(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure CBOutGradClick(Sender: TObject);
  private
    { Private declarations }
    TheFont : TTeeFont;
  public
    { Public declarations }
    procedure RefreshControls(AFont:TTeeFont);
  end;

Function InsertTeeFontEditor(ATab:TTabSheet):TTeeFontEditor;
Procedure EditTeeFontEx(AOwner:TComponent; AFont:TTeeFont);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLR}
     Borland.VCL.Graphics,
     {$ENDIF}
     TeeConst, TeeShadowEditor, TeeBrushDlg, TeeEdiGrad;

Function InsertTeeFontEditor(ATab:TTabSheet):TTeeFontEditor;
begin
  result:=TTeeFontEditor.Create(ATab.Owner);
  AddFormTo(result,ATab);
end;

Procedure EditTeeFontEx(AOwner:TComponent; AFont:TTeeFont);
begin
  with TTeeFontEditor.Create(AOwner) do
  try
    BorderStyle:=TeeBorderStyle;
    TheFont:=AFont;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TTeeFontEditor.BFontClick(Sender: TObject);
begin
  EditTeeFont(Self,TheFont);
  SHText.Brush.Color:=TheFont.Color;
end;

procedure TTeeFontEditor.RefreshControls(AFont:TTeeFont);
begin
  TheFont:=AFont;
  With TheFont do
  begin
    SHText.Brush.Color:=Color;
    UDInter.Position:=InterCharSize;
    BOutline.LinkPen(OutLine);
    CBOutGrad.Checked:=Gradient.Outline;
  end;
end;

procedure TTeeFontEditor.FormShow(Sender: TObject);
begin
  if Assigned(TheFont) then RefreshControls(TheFont);

  {$IFDEF CLX}
  EnableControls(False,[Label2,Edit2,UDInter,BOutline]);
  {$ENDIF}

  TeeTranslateControl(Self);
end;

procedure TTeeFontEditor.SHTextMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp : TColor;
begin
  tmp:=TheFont.Color;
  if EditColorDialog(Self,tmp) then
  begin
    TheFont.Color:=tmp;
    SHText.Brush.Color:=tmp;
  end;
end;

procedure TTeeFontEditor.Edit2Change(Sender: TObject);
begin
  if Showing then TheFont.InterCharSize:=UDInter.Position;
end;

procedure TTeeFontEditor.BShadowClick(Sender: TObject);
begin
  EditTeeShadow(Owner,TheFont.Shadow);
end;

procedure TTeeFontEditor.BGradientClick(Sender: TObject);
begin
  EditTeeGradient(Owner,TheFont.Gradient)
end;

procedure TTeeFontEditor.CBOutGradClick(Sender: TObject);
begin
  TheFont.Gradient.Outline:=CBOutGrad.Checked;
end;

end.
