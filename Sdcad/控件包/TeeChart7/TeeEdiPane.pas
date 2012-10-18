{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2004 by David Berneda    }
{**********************************************}
unit TeeEdiPane;
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
     TeeProcs, TeeEdiGrad, TeCanvas, TeePenDlg;

type
  TFormTeePanel = class(TForm)
    PageControl1: TPageControl;
    TabBack: TTabSheet;
    TabBorders: TTabSheet;
    TabGradient: TTabSheet;
    L19: TLabel;
    L2: TLabel;
    SEPanelBor: TEdit;
    SEPanelWi: TEdit;
    UDPanelWi: TUpDown;
    UDPanelBor: TUpDown;
    BPanelColor: TButtonColor;
    GB6: TGroupBox;
    RGBitmap: TRadioGroup;
    BBrowseImage: TButton;
    CBImageInside: TCheckBox;
    CBTransp: TCheckBox;
    TabShadow: TTabSheet;
    CBColorDef: TCheckBox;
    Label1: TLabel;
    ERound: TEdit;
    UDRound: TUpDown;
    CBInner: TComboFlat;
    Label2: TLabel;
    Label3: TLabel;
    CBOuter: TComboFlat;
    BBorder: TButtonPen;
    Label4: TLabel;
    ELeft: TEdit;
    UDLeft: TUpDown;
    Label5: TLabel;
    ETop: TEdit;
    UDTop: TUpDown;
    procedure SEPanelWiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGBitmapClick(Sender: TObject);
    procedure BBrowseImageClick(Sender: TObject);
    procedure CBImageInsideClick(Sender: TObject);
    procedure SEPanelBorChange(Sender: TObject);
    procedure BPanelColorClick(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBColorDefClick(Sender: TObject);
    procedure ERoundChange(Sender: TObject);
    procedure CBInnerChange(Sender: TObject);
    procedure CBOuterChange(Sender: TObject);
    procedure ETopChange(Sender: TObject);
    procedure ELeftChange(Sender: TObject);
  private
    { Private declarations }
    Changing : Boolean;
    FGradientEditor : TTeeGradientEditor;
    Procedure CheckColorDef;
    procedure EnableImageControls;
  public
    { Public declarations }
    ThePanel:TCustomTeePanelExtended;
    Constructor CreatePanel(Owner:TComponent; APanel:TCustomTeePanelExtended);
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeShadowEditor, TeeConst;

{ TFormTeePanel }
Constructor TFormTeePanel.CreatePanel(Owner:TComponent; APanel:TCustomTeePanelExtended);
begin
  inherited Create(Owner);
  ThePanel:=APanel;
  Changing:=False;
  FGradientEditor:=TTeeGradientEditor.CreateCustom(Self,ThePanel.Gradient);
  AddFormTo(FGradientEditor,TabGradient,ThePanel.Gradient);
  InsertTeeShadowEditor(TabShadow).RefreshControls(ThePanel.Shadow);
  PageControl1.ActivePage:=TabBack;
end;

procedure TFormTeePanel.SEPanelWiChange(Sender: TObject);
begin
  if Showing then
  With ThePanel do
  if BevelWidth<>UDPanelWi.Position then BevelWidth:=UDPanelWi.Position;
end;

procedure TFormTeePanel.FormShow(Sender: TObject);
begin
  if Assigned(ThePanel) then
  begin
    With ThePanel do
    begin
      CBInner.ItemIndex      :=Ord(BevelInner);
      CBOuter.ItemIndex      :=Ord(BevelOuter);
      BBorder.LinkPen(Border);
      UDRound.Position       :=BorderRound;
      UDPanelWi.Position     :=BevelWidth;
      UDPanelBor.Position    :=BorderWidth;
      RGBitmap.ItemIndex     :=Ord(BackImage.Mode);
      CBImageInside.Checked  :=BackImage.Inside;
      UDLeft.Position        :=BackImage.Left;
      UDTop.Position         :=BackImage.Top;
      EnableImageControls;

      CBTransp.Enabled:=Assigned(BackImage.Graphic);
      CBTransp.Checked:=CBTransp.Enabled and BackImageTransp;

      CheckColorDef;
    end;
    
    BPanelColor.LinkProperty(ThePanel,'Color');

    FGradientEditor.Visible:=True;
    PageControl1.ActivePage:=TabBack;
  end;
end;

procedure TFormTeePanel.RGBitmapClick(Sender: TObject);
begin
  ThePanel.BackImage.Mode:=TTeeBackImageMode(RGBitmap.ItemIndex);
  EnableImageControls;
end;

procedure TFormTeePanel.EnableImageControls;
begin
  RGBitmap.Enabled:=Assigned(ThePanel.BackImage.Graphic);
  CBImageInside.Enabled:=RGBitmap.Enabled;

  if RGBitmap.Enabled then
     BBrowseImage.Caption:=TeeMsg_ClearImage
  else
     BBrowseImage.Caption:=TeeMsg_BrowseImage;

  if CBTransp.Visible then
  begin
    CBTransp.Enabled:=RGBitmap.Enabled;
    CBTransp.Checked:=CBTransp.Enabled and
                      ThePanel.BackImage.Graphic.Transparent;
  end;

  EnableControls(ThePanel.BackImage.Mode=pbmCustom, [ELeft,ETop,UDLeft,UDTop]);
end;

procedure TFormTeePanel.BBrowseImageClick(Sender: TObject);
begin
  TeeLoadClearImage(Self,ThePanel.BackImage);
  EnableImageControls;
end;

procedure TFormTeePanel.CBImageInsideClick(Sender: TObject);
begin
  ThePanel.BackImage.Inside:=CBImageInside.Checked;
end;

procedure TFormTeePanel.SEPanelBorChange(Sender: TObject);
begin
  if Showing then
  With ThePanel do
  if BorderWidth<>UDPanelBor.Position then BorderWidth:=UDPanelBor.Position;
end;

procedure TFormTeePanel.BPanelColorClick(Sender: TObject);
begin
  ThePanel.Repaint;
  CheckColorDef;
end;

procedure TFormTeePanel.CBTranspClick(Sender: TObject);
begin
  if CBTransp.Enabled then
     ThePanel.BackImageTransp:=CBTransp.Checked;
end;

procedure TFormTeePanel.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

Procedure TFormTeePanel.CheckColorDef;
begin
  Changing:=True;
  CBColorDef.Checked:=ThePanel.Color=clBtnFace;
  Changing:=False;
  CBColorDef.Enabled:=not CBColorDef.Checked;
end;

procedure TFormTeePanel.CBColorDefClick(Sender: TObject);
begin
  if not Changing then
  begin
    ThePanel.Color:=clBtnFace;
    CheckColorDef;
    BPanelColor.Invalidate;
  end;
end;

procedure TFormTeePanel.ERoundChange(Sender: TObject);
begin
  if Showing then
     ThePanel.BorderRound:=UDRound.Position;
end;

procedure TFormTeePanel.CBInnerChange(Sender: TObject);
begin
  if ThePanel.BevelInner<>TPanelBevel(CBInner.ItemIndex) then
     ThePanel.BevelInner:=TPanelBevel(CBInner.ItemIndex);
end;

procedure TFormTeePanel.CBOuterChange(Sender: TObject);
begin
  if ThePanel.BevelOuter<>TPanelBevel(CBOuter.ItemIndex) then
     ThePanel.BevelOuter:=TPanelBevel(CBOuter.ItemIndex);
end;

procedure TFormTeePanel.ETopChange(Sender: TObject);
begin
  if Showing then
     ThePanel.BackImage.Top:=UDTop.Position;
end;

procedure TFormTeePanel.ELeftChange(Sender: TObject);
begin
  if Showing then
     ThePanel.BackImage.Left:=UDLeft.Position;
end;

end.

