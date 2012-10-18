{**********************************************}
{  TTeeShadow Editor Dialog                    }
{  Copyright (c) 2002-2004 by David Berneda    }
{**********************************************}
unit TeeShadowEditor;
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
     TeCanvas;

type
  TTeeShadowEditor = class(TForm)
    Label1: TLabel;
    LTransp: TLabel;
    Label5: TLabel;
    BShadowColor: TButtonColor;
    Edit1: TEdit;
    UDShadowSize: TUpDown;
    EShadowTransp: TEdit;
    UDShadowTransp: TUpDown;
    EVertSize: TEdit;
    UDShaVert: TUpDown;
    BOK: TButton;
    CBSmooth: TCheckBox;
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EShadowTranspChange(Sender: TObject);
    procedure EVertSizeChange(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Shadow       : TTeeShadow;
    Function CanChange:Boolean;
  public
    { Public declarations }
    Procedure RefreshControls(AShadow:TTeeShadow);
  end;

Function EditTeeShadow(AOwner:TComponent;
                       AShadow:TTeeShadow):Boolean;

Function InsertTeeShadowEditor(ATab:TTabSheet):TTeeShadowEditor;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeProcs, TeePenDlg;

Function EditTeeShadow(AOwner:TComponent;
                       AShadow:TTeeShadow):Boolean;
begin
  with TeeCreateForm(TTeeShadowEditor,AOwner) as TTeeShadowEditor do
  try
    Shadow:=AShadow;
    BOK.Visible:=True;
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function InsertTeeShadowEditor(ATab:TTabSheet):TTeeShadowEditor;
begin
  result:=TTeeShadowEditor.Create(ATab.Owner);
  result.BOK.Visible:=False;
  AddFormTo(result,ATab);
end;

Procedure TTeeShadowEditor.RefreshControls(AShadow:TTeeShadow);
begin
  Shadow:=AShadow;
  UDShadowSize.Position  :=Shadow.HorizSize;
  UDShaVert.Position     :=Shadow.VertSize;
  UDShadowTransp.Position:=Shadow.Transparency;
  CBSmooth.Checked       :=Shadow.Smooth;
  BShadowColor.LinkProperty(Shadow,'Color');
end;

Function TTeeShadowEditor.CanChange:Boolean;
begin
  result:=(not CreatingForm) and Assigned(Shadow);
end;

procedure TTeeShadowEditor.Edit1Change(Sender: TObject);
begin
  if CanChange then
     Shadow.HorizSize:=UDShadowSize.Position;
end;

procedure TTeeShadowEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
end;

procedure TTeeShadowEditor.FormShow(Sender: TObject);
begin
  if Assigned(Shadow) then RefreshControls(Shadow);

  TeeTranslateControl(Self);
  CreatingForm:=False;
end;

procedure TTeeShadowEditor.EShadowTranspChange(Sender: TObject);
begin
  if CanChange then
     Shadow.Transparency:=UDShadowTransp.Position;
end;

procedure TTeeShadowEditor.EVertSizeChange(Sender: TObject);
begin
  if CanChange then
     Shadow.VertSize:=UDShaVert.Position;
end;

procedure TTeeShadowEditor.BOKClick(Sender: TObject);
begin
  Close;
end;

procedure TTeeShadowEditor.CBSmoothClick(Sender: TObject);
begin
  Shadow.Smooth:=CBSmooth.Checked;
end;

end.
