{*********************************************}
{    TeePreviewPanelEditor                    }
{   Copyright (c) 1999-2004 by David Berneda  }
{*********************************************}
unit TeePreviewPanelEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
     {$ENDIF}
     TeePreviewPanel, TeCanvas, TeePenDlg;

type
  TFormPreviewPanelEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CBAllowMove: TCheckBox;
    CBAllowResize: TCheckBox;
    CBDragImage: TCheckBox;
    CBAsBitmap: TCheckBox;
    CBShowImage: TCheckBox;
    BPaperColor: TButtonColor;
    RGOrientation: TRadioGroup;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButtonPen;
    TabShadow: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure CBAllowMoveClick(Sender: TObject);
    procedure CBAllowResizeClick(Sender: TObject);
    procedure CBDragImageClick(Sender: TObject);
    procedure CBAsBitmapClick(Sender: TObject);
    procedure CBShowImageClick(Sender: TObject);
    procedure RGOrientationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    TeePreviewPanel1 : TTeePreviewPanel;
  public
    { Public declarations }
    Constructor CreatePanel(AOwner:TComponent; APanel:TTeePreviewPanel);
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeEdiPane, TeeProcs, TeeProCo, TeeShadowEditor;

Constructor TFormPreviewPanelEditor.CreatePanel(AOwner:TComponent; APanel:TTeePreviewPanel);
var Page : TTabSheet;
    tmp  : TFormTeePanel;
begin
  inherited Create(AOwner);
  TeePreviewPanel1:=APanel;
  Page:=TTabSheet.Create(Self);
  Page.Caption:=TeeCommanMsg_Panel;
  Page.PageControl:=PageControl1;
  TeeTranslateControl(Self);
  tmp:=TFormTeePanel.CreatePanel(Self,TeePreviewPanel1);
  tmp.Align:=alClient;
  AddFormTo(tmp,Page,0);
end;

procedure TFormPreviewPanelEditor.FormShow(Sender: TObject);
begin
  if Assigned(TeePreviewPanel1) then
  begin
    With TeePreviewPanel1 do
    begin
      CBAllowMove.Checked   :=AllowMove;
      CBAllowResize.Checked :=AllowResize;
      CBDragImage.Checked   :=DragImage;
      CBAsBitmap.Checked    :=AsBitmap;
      CBShowImage.Checked   :=ShowImage;
      RGOrientation.ItemIndex:=Ord(Orientation);
      Button2.LinkPen(Margins);
      InsertTeeShadowEditor(TabShadow).RefreshControls(Shadow);
    end;
    BPaperColor.LinkProperty(TeePreviewPanel1,'PaperColor');  { do not translate }
  end;

  PageControl1.ActivePage:=TabSheet1;
end;

procedure TFormPreviewPanelEditor.CBAllowMoveClick(Sender: TObject);
begin
  TeePreviewPanel1.AllowMove:=CBAllowMove.Checked
end;

procedure TFormPreviewPanelEditor.CBAllowResizeClick(Sender: TObject);
begin
  TeePreviewPanel1.AllowResize:=CBAllowResize.Checked
end;

procedure TFormPreviewPanelEditor.CBDragImageClick(Sender: TObject);
begin
  TeePreviewPanel1.DragImage:=CBDragImage.Checked
end;

procedure TFormPreviewPanelEditor.CBAsBitmapClick(Sender: TObject);
begin
  TeePreviewPanel1.AsBitmap:=CBAsBitmap.Checked
end;

procedure TFormPreviewPanelEditor.CBShowImageClick(Sender: TObject);
begin
  TeePreviewPanel1.ShowImage:=CBShowImage.Checked
end;

procedure TFormPreviewPanelEditor.RGOrientationClick(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Case RGOrientation.ItemIndex of
    0: Orientation:=ppoDefault;
    1: Orientation:=ppoPortrait;
  else
    Orientation:=ppoLandscape;
  end;
end;

procedure TFormPreviewPanelEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

end.

