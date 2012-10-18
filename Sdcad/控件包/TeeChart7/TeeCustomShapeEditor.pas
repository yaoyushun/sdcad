{**********************************************}
{  TChartObject (or derived) Editor Dialog     }
{  Copyright (c) 1999-2004 by David Berneda    }
{**********************************************}
unit TeeCustomShapeEditor;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     Borland.VCL.Controls,
     Borland.VCL.Forms,
     Borland.VCL.ComCtrls,
     Borland.VCL.StdCtrls,
     Borland.VCL.ExtCtrls,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeeEdiGrad, TeeEdiFont, TeCanvas, TeePenDlg, TeeShadowEditor;

type
  TFormTeeShape = class(TForm)
    PC1: TPageControl;
    TabFormat: TTabSheet;
    BBackColor: TButtonColor;
    Button4: TButtonPen;
    Button6: TButton;
    CBRound: TCheckBox;
    CBTransparent: TCheckBox;
    TabGradient: TTabSheet;
    TabText: TTabSheet;
    CBBevel: TComboFlat;
    TabShadow: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    EBevWidth: TEdit;
    UDBevW: TUpDown;
    Label4: TLabel;
    EShadowTransp: TEdit;
    UDShadowTransp: TUpDown;
    procedure BColorClick(Sender: TObject);
    procedure CBRoundClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBTransparentClick(Sender: TObject);
    procedure CBBevelChange(Sender: TObject);
    procedure EBevWidthChange(Sender: TObject);
    procedure EShadowTranspChange(Sender: TObject);
    procedure CBVisibleChecked(Sender: TObject);
  private
    { Private declarations }
    CreatingForm    : Boolean;
    FFontEditor     : TTeeFontEditor;
    FGradientEditor : TTeeGradientEditor;
    FShadowEditor   : TTeeShadowEditor;

    Procedure EnableBevel;
  public
    { Public declarations }
    TheShape : TTeeCustomShape;

    Constructor Create(AOwner:TComponent); override;
    class Function CreateForm(AOwner:TComponent;
                              AShape:TTeeCustomShape;
                              AParent:TWinControl=nil):TFormTeeShape;
    procedure RefreshControls(AShape:TTeeCustomShape);
  end;

Function InsertTeeObjectForm(APageControl:TPageControl; AShape:TTeeCustomShape):TFormTeeShape;

Procedure EditTeeCustomShape(AOwner:TComponent; AShape:TTeeCustomShape);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeeBrushDlg;

class Function TFormTeeShape.CreateForm( AOwner:TComponent;
                                         AShape:TTeeCustomShape;
                                         AParent:TWinControl=nil):TFormTeeShape;
begin
  result:=TFormTeeShape.Create(AOwner);
  result.TheShape:=AShape;

  if Assigned(AParent) then
  with result do
  begin
    BorderStyle:=TeeFormBorderStyle;
    Parent:=AParent;
    TeeTranslateControl(result);

    Align:=alClient;

    {$IFDEF CLX}
    TeeFixParentedForm(result);
    {$ENDIF}

    Show;
  end;
end;

Function InsertTeeObjectForm(APageControl:TPageControl; AShape:TTeeCustomShape):TFormTeeShape;
var tmp : TTabSheet;
begin
  result:=TFormTeeShape.CreateForm(APageControl.Owner,AShape);

  with result do
  begin
    BorderStyle:=TeeFormBorderStyle;
    Parent:=APageControl;
    Align:=alClient;

    While PC1.PageCount>0 do
    begin
      tmp:=PC1.Pages[0];
      tmp.PageControl:=APageControl;
      {$IFDEF CLX}
      tmp.Show;
      {$ENDIF}
    end;

    APageControl.ActivePage:=APageControl.Pages[0];

    TeeTranslateControl(result);
  end;
end;

Procedure EditTeeCustomShape(AOwner:TComponent; AShape:TTeeCustomShape);
var tmp : TFormTeeShape;
    tmpPanel : TPanel;
begin
  tmp:=TFormTeeShape.CreateForm(AOwner,AShape);
  with tmp do
  try
    BorderStyle:=TeeBorderStyle;
    Height:=Height+30;

    tmpPanel:=TPanel.Create(tmp);
    with tmpPanel do
    begin
      Height:=34;
      BevelOuter:=bvNone;
      Align:=alBottom;
      Parent:=tmp;
    end;

    with TButton.Create(tmp) do
    begin
      Left:=tmp.Width-98;
      Top:=4;
      Caption:='OK';
      ModalResult:=mrOk;
      Parent:=tmpPanel;
    end;

    ShowModal;
  finally
    Free;
  end;
end;

// Constructor, for CLX compatib.
Constructor TFormTeeShape.Create(AOwner:TComponent);
begin
  CreatingForm:=True;
  inherited;
end;

procedure TFormTeeShape.BColorClick(Sender: TObject);
begin
  CBTransparent.Checked:=False;
end;

procedure TFormTeeShape.CBRoundClick(Sender: TObject);
begin
  if CBRound.Checked then TheShape.ShapeStyle:=fosRoundRectangle
                     else TheShape.ShapeStyle:=fosRectangle
end;

procedure TFormTeeShape.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,TheShape.Brush);
end;

type
  TShapeAccess=class(TTeeCustomShape);

procedure TFormTeeShape.RefreshControls(AShape:TTeeCustomShape);
begin
  CreatingForm:=True;
  TheShape:=AShape;

  With {$IFNDEF CLR}TShapeAccess{$ENDIF}(TheShape) do
  begin
    CBRound.Checked        :=ShapeStyle=fosRoundRectangle;
    CBTransparent.Checked  :=Transparent;
    CBBevel.ItemIndex      :=Ord(Bevel);
    UDBevW.Position        :=BevelWidth;
    UDShadowTransp.Position:={$IFDEF CLR}TShapeAccess(TheShape).{$ENDIF}Transparency;
    FGradientEditor.RefreshGradient(Gradient);
    FFontEditor.RefreshControls(Font);
    FShadowEditor.RefreshControls(Shadow);
    Button4.LinkPen(Frame);
  end;

  BBackColor.LinkProperty(TheShape,'Color');
  EnableBevel;
  CreatingForm:=False;
end;

Procedure TFormTeeShape.EnableBevel;
begin
  EnableControls(TheShape.Bevel<>bvNone,[EBevWidth,UDBevW]);
end;

procedure TFormTeeShape.FormShow(Sender: TObject);
begin
  PC1.ActivePage:=TabFormat;
  if Assigned(TheShape) then RefreshControls(TheShape);

  TeeTranslateControl(Self);
end;

procedure TFormTeeShape.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  FGradientEditor:=TTeeGradientEditor.CreateCustom(Self,nil);
  AddFormTo(FGradientEditor,TabGradient);
  FFontEditor:=InsertTeeFontEditor(TabText);
  FShadowEditor:=InsertTeeShadowEditor(TabShadow);
end;

procedure TFormTeeShape.CBTransparentClick(Sender: TObject);
begin
  TheShape.Transparent:=CBTransparent.Checked;
end;

procedure TFormTeeShape.CBBevelChange(Sender: TObject);
begin
  TheShape.Bevel:=TPanelBevel(CBBevel.ItemIndex);
  EnableBevel;
end;

procedure TFormTeeShape.EBevWidthChange(Sender: TObject);
begin
  if not CreatingForm then TheShape.BevelWidth:=UDBevW.Position
end;

procedure TFormTeeShape.EShadowTranspChange(Sender: TObject);
begin
  if not CreatingForm then
     TShapeAccess(TheShape).Transparency:=UDShadowTransp.Position;
end;

procedure TFormTeeShape.CBVisibleChecked(Sender: TObject);
begin
  TheShape.Visible:=(Sender as TCheckBox).Checked;
end;

end.
