{**********************************************}
{  TChartGradient Editor Dialog                }
{  Copyright (c) 1999-2004 by David Berneda    }
{**********************************************}
unit TeeEdiGrad;
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
     {$IFDEF LINUX}
     Types,
     {$ENDIF} 
     TeeProcs, TeePenDlg, TeCanvas;

type
  TPreviewGradient=class(TCustomTeePanelExtended)
  protected
    Procedure InternalDraw(Const UserRectangle:TRect); override;
  end;

  TTeeGradientEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    SBBalance: TScrollBar;
    LabelBalance: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    LRadialX: TLabel;
    LRadialY: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    BSwap: TButton;
    BStart: TButtonColor;
    BEnd: TButtonColor;
    BMid: TButtonColor;
    CBMid: TCheckBox;
    Panel1: TPanel;
    BOk: TButton;
    BCancel: TButton;
    Panel2: TPanel;
    CBVisible: TCheckBox;
    Label1: TLabel;
    CBDirection: TComboFlat;
    TabSheet3: TTabSheet;
    Gallery: TListBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    procedure CBVisibleClick(Sender: TObject);
    procedure CBDirectionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSwapClick(Sender: TObject);
    procedure CBMidClick(Sender: TObject);
    procedure BMidClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SBBalanceChange(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure BEndClick(Sender: TObject);
    procedure GalleryClick(Sender: TObject);
  private
    { Private declarations }
    Backup : TCustomTeeGradient;
    IModified  : Boolean;
    IOnlyStart : Boolean;
    SettingProps : Boolean;
    Preview : TPreviewGradient;

    procedure CheckDirection;
    procedure CheckVisible;
    Function IsRectGradient:Boolean;
    procedure RefreshControls;
    procedure SetPreview;
  public
    { Public declarations }
    TheGradient : TCustomTeeGradient;

    Constructor CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
    class procedure DefaultGradient(Gradient:TCustomTeeGradient;
                                    IsRectGradient:Boolean; Index:Integer);
    Procedure RefreshGradient(AGradient:TCustomTeeGradient);
  end;

Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient):Boolean; overload;
Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient;
                         OnlyStart:Boolean; HideVisible:Boolean=False):Boolean; overload;

Const TeeMaxSampleGradient=16;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient):Boolean;
begin
  result:=EditTeeGradient(AOwner,AGradient,False,False);
end;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient;
                          OnlyStart:Boolean;
                          HideVisible:Boolean=False):Boolean;
begin
  With TeeCreateForm(TTeeGradientEditor,AOwner) as TTeeGradientEditor do
  try
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AGradient);
    IOnlyStart:=OnlyStart;

    if IOnlyStart then
    begin
      BEnd.Visible:=False;
      BSwap.Visible:=False;
    end;

    CBVisible.Visible:=not HideVisible;
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Constructor TTeeGradientEditor.CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
Begin
  inherited Create(AOwner);
  TheGradient:=AGradient;
  Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(TheGradient);
  Panel1.Visible:=False;
  BOk.Visible:=False;
  BCancel.Visible:=False;
  Height:=Height-BOk.Height;
end;

procedure TTeeGradientEditor.CheckVisible;
Begin
  EnableControls(IOnlyStart or TheGradient.Visible,
                 [CBDirection,BStart,CBMid,BMid,BEnd,BSwap,Gallery]);
end;

procedure TTeeGradientEditor.CheckDirection;
var tmp : Boolean;
begin
  With TheGradient do
  begin
    tmp:=(Direction=gdFromCenter) or
         (Direction=gdRadial) or
         (Direction=gdFromTopLeft) or
         (Direction=gdFromBottomLeft);
    EnableControls(IOnlyStart or Visible and (not tmp),[CBMid,BMid]);
    EnableControls(Direction=gdRadial,[Label2,Label3,TrackBar1,TrackBar2]);
  end;
end;

procedure TTeeGradientEditor.CBVisibleClick(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Visible:=CBVisible.Checked;
  CheckVisible;
end;

procedure TTeeGradientEditor.CBDirectionChange(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Direction:=TGradientDirection(CBDirection.ItemIndex);
  CheckDirection;

  if not IsRectGradient then Gallery.ItemIndex:=-1;

  SetPreview;
end;

Procedure TTeeGradientEditor.RefreshGradient(AGradient:TCustomTeeGradient);
begin
  SettingProps:=True;
  Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AGradient);

  TheGradient:=AGradient;

  if Assigned(TheGradient) then
  begin
    Backup.Free;
    Backup:=TChartGradient.Create(nil);
    Backup.Assign(TheGradient);

    BStart.LinkProperty(TheGradient,'StartColor');
    BMid.LinkProperty(TheGradient,'MidColor');
    BEnd.LinkProperty(TheGradient,'EndColor');

    RefreshControls;

    CheckVisible;
    CheckDirection;
    SetPreview;
  end;

  SettingProps:=False;
end;

procedure TTeeGradientEditor.RefreshControls;
begin
  With TheGradient do
  begin
    SBBalance.Position:=Balance;
    CBVisible.Checked:=Visible;
    CBDirection.ItemIndex:=Ord(Direction);
    CBMid.Checked:=MidColor=clNone;
    TrackBar1.Position:=RadialX;
    LRadialX.Caption:=IntToStr(RadialX);
    TrackBar2.Position:=RadialY;
    LRadialY.Caption:=IntToStr(RadialY);
  end;

  BStart.Invalidate;
  BMid.Invalidate;
  BEnd.Invalidate;
end;

procedure TTeeGradientEditor.FormShow(Sender: TObject);
begin
  RefreshGradient(TCustomTeeGradient({$IFDEF CLR}TObject{$ENDIF}(Tag)));
  IModified:=False;
  TeeTranslateControl(Self);
end;

procedure TTeeGradientEditor.BCancelClick(Sender: TObject);
begin
  if IModified then
  begin
    TheGradient.Assign(Backup);
    TheGradient.Changed(Self);
  end;
end;

procedure TTeeGradientEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Preview);
  Backup.Free;
end;

procedure TTeeGradientEditor.BSwapClick(Sender: TObject);
var tmp : TColor;
begin
  IModified:=True;

  With TheGradient do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
  end;

  BStart.Repaint;
  BEnd.Repaint;
  SetPreview;
end;

procedure TTeeGradientEditor.CBMidClick(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;

    if CBMid.Checked then
       TheGradient.MidColor:=clNone
    else
    begin
      TheGradient.UseMiddleColor;

      if TheGradient.MidColor=clNone then
         TheGradient.MidColor:=clWhite;
    end;

    BMid.Repaint;
    SetPreview;
  end;
end;

procedure TTeeGradientEditor.BMidClick(Sender: TObject);
begin
  IModified:=True;
  CBMid.Checked:=TheGradient.MidColor=clNone;
  SetPreview;
end;

procedure TTeeGradientEditor.FormCreate(Sender: TObject);

  Procedure AddGallery(const S:Array of String);
  var t : Integer;
  begin
    for t:=Low(S) to High(S) do
        Gallery.Items.AddObject(S[t],TObject(t));
  end;

begin
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;

  Preview:=TPreviewGradient.Create(Self);
  Preview.Parent:=TabSheet3;
  Preview.SetBounds(144,16,81,73);

  AddGallery(['Caribe Sun','Business','Hot','Ace','Farm','Sea',
              'Night','Space','Golf','Funky','Sunset','Rainbow',
              'Pastel','Tropical','Sea 2','Desert','Clear day']);
end;

procedure TTeeGradientEditor.TrackBar1Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialX:=TrackBar1.Position;
  LRadialX.Caption:=IntToStr(TheGradient.RadialX);
end;

procedure TTeeGradientEditor.TrackBar2Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialY:=TrackBar2.Position;
  LRadialY.Caption:=IntToStr(TheGradient.RadialY);
end;

procedure TTeeGradientEditor.SBBalanceChange(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;
    TheGradient.Balance:=SBBalance.Position;
  end;
  LabelBalance.Caption:=FormatFloat(TeeMsg_DefPercentFormat,TheGradient.Balance);
end;

procedure TTeeGradientEditor.BStartClick(Sender: TObject);
begin
  IModified:=True;
  SetPreview;
end;

procedure TTeeGradientEditor.BEndClick(Sender: TObject);
begin
  IModified:=True;
  SetPreview;
end;

procedure TTeeGradientEditor.SetPreview;
begin
  Preview.Gradient.Visible:=TheGradient.Visible;
  Preview.Gradient.Direction:=TheGradient.Direction;

  Preview.Gradient.StartColor:=TheGradient.StartColor;
  Preview.Gradient.MidColor:=TheGradient.MidColor;
  Preview.Gradient.EndColor:=TheGradient.EndColor;
end;

Function TTeeGradientEditor.IsRectGradient:Boolean;
begin
  result:= (TheGradient.Direction=gdTopBottom) or
           (TheGradient.Direction=gdBottomTop) or
           (TheGradient.Direction=gdLeftRight) or
           (TheGradient.Direction=gdRightLeft);
end;

class procedure TTeeGradientEditor.DefaultGradient(Gradient:TCustomTeeGradient;
                                         IsRectGradient:Boolean; Index:Integer);

  Procedure DefaultGradient(AStart,AMid,AEnd:TColor;
                            ADirection:TGradientDirection=gdTopBottom;
                            ABalance:Integer=50);
  begin
    Gradient.StartColor:=AStart;
    Gradient.MidColor:=AMid;
    Gradient.EndColor:=AEnd;

    if (AMid<>clNone) and (not IsRectGradient) then
       Gradient.Direction:=gdTopBottom;

    Gradient.Direction:=ADirection;
    Gradient.Balance:=ABalance;
  end;

begin
  case Index of
    0: DefaultGradient($00DDDFD2,$00F50A97,$000B80F4);
    1: DefaultGradient(clSilver,clWhite,clDkGray);
    2: DefaultGradient(clRed,clNone,clYellow);
    3: DefaultGradient(clBlack,$00FF8080,clBlack,gdBottomTop,74);
    4: DefaultGradient($00006AD5,clWhite,$000062C4,gdBottomTop,4);
    5: DefaultGradient($00FFFF80,$00FF8080,clNavy,gdBottomTop,55);
    6: DefaultGradient(clWhite,$00800040,clBlack,gdTopBottom,40);
    7: DefaultGradient($00A50320,$00800040,clWhite,gdFromTopLeft);
    8: DefaultGradient($00159902,clSilver,$00D9F986,gdTopBottom);
    9: DefaultGradient($00BD3881,$0087607A,$0052EB85,gdTopBottom);
   10: DefaultGradient($00B85A06,$00A7D8AF,$00001042,gdTopBottom);
   11: DefaultGradient($00A11EE8,$000F8355,$00DD011A,gdTopBottom);
   12: DefaultGradient($00247489,$009491F6,$00FD8B9D);
   13: DefaultGradient($009A414B,$00732FF3,$0020D761);
   14: DefaultGradient($004C031C,$00BACBE1,$00291EF9);
   15: DefaultGradient($00265FB7,$00CE7185,$00604457);
   TeeMaxSampleGradient: DefaultGradient($00FFF3EA,$00E0E6E9,$00CEDBFF);
  end;
end;

procedure TTeeGradientEditor.GalleryClick(Sender: TObject);
begin
  DefaultGradient(TheGradient, IsRectGradient, Integer(Gallery.Items.Objects[Gallery.ItemIndex]));
  RefreshControls;
  SetPreview;
end;

{ TPreviewGradient }

procedure TPreviewGradient.InternalDraw(const UserRectangle: TRect);
begin
  PanelPaint(UserRectangle);
end;

end.
