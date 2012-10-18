{******************************************}
{    TChartShape Editor Dialog             }
{ Copyright (c) 1996-2004 by David Berneda }
{******************************************}
unit TeeShapeEdi;
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
     Chart, TeEngine, TeeShape, TeeEdiFont, TeCanvas, TeePenDlg, TeeProcs;

type
  TChartShapeEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    LX1: TLabel;
    Label2: TLabel;
    LY1: TLabel;
    SEX0: TEdit;
    SEX1: TEdit;
    SEY0: TEdit;
    SEY1: TEdit;
    Label3: TLabel;
    CBStyle: TComboFlat;
    BShapeColor: TButtonColor;
    BShapePen: TButtonPen;
    CBTrans: TCheckBox;
    BShapeBrush: TButton;
    Label5: TLabel;
    MemoText: TMemo;
    RGAlign: TRadioGroup;
    Label4: TLabel;
    CBUnits: TComboFlat;
    TabFont: TTabSheet;
    CBRound: TCheckBox;
    RGVertAlign: TRadioGroup;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure SEX0Change(Sender: TObject);
    procedure SEY0Change(Sender: TObject);
    procedure SEX1Change(Sender: TObject);
    procedure SEY1Change(Sender: TObject);
    procedure BShapeBrushClick(Sender: TObject);
    procedure MemoTextChange(Sender: TObject);
    procedure RGAlignClick(Sender: TObject);
    procedure CBTransClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure CBUnitsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBRoundClick(Sender: TObject);
    procedure RGVertAlignClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    FEditFont    : TTeeFontEditor;
    TheSeries    : TChartShape;
    procedure EnableRound;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeEdiGrad;

procedure TChartShapeEditor.FormShow(Sender: TObject);
begin
  Align:=alClient;

  TheSeries:=TChartShape(Tag);
  if Assigned(TheSeries) then
  begin
    CBStyle.ItemIndex:=Ord(TheSeries.Style);
    CBTrans.Checked:=TheSeries.Transparent;
    With TheSeries do
    begin
      if TheSeries.Count=2 then
      begin
        SEX0.Text:=FloatToStr(X0);
        SEY0.Text:=FloatToStr(Y0);
        SEX1.Text:=FloatToStr(X1);
        SEY1.Text:=FloatToStr(Y1);
      end;
      MemoText.Font:=Font;
      MemoText.Lines:=Text;
      Case Alignment of
        taLeftJustify:  RGAlign.ItemIndex:=0;
        taCenter:       RGAlign.ItemIndex:=1;
        taRightJustify: RGAlign.ItemIndex:=2;
      end;
      Case VertAlign of
        vaTop:    RGVertAlign.ItemIndex:=0;
        vaCenter: RGVertAlign.ItemIndex:=1;
        vaBottom: RGVertAlign.ItemIndex:=2;
      end;
      CBRound.Checked:=RoundRectangle;
      EnableRound;
      CBUnits.ItemIndex:=Ord(XYStyle);
      BShapePen.LinkPen(Pen);
      FEditFont.RefreshControls(Font);
    end;
    BShapeColor.LinkProperty(TheSeries,'SeriesColor');
  end;
  
  {$IFDEF CLX}
  RGVertAlign.Width:=84;
  {$ENDIF}
  CreatingForm:=False;
end;

procedure TChartShapeEditor.SEX0Change(Sender: TObject);
begin
  if Showing and (SEX0.Text<>'') then
  try
    TheSeries.X0:=StrToFloat(SEX0.Text);
  except
  end;
end;

procedure TChartShapeEditor.SEY0Change(Sender: TObject);
begin
  if Showing and (SEY0.Text<>'') then
  try
    TheSeries.Y0:=StrToFloat(SEY0.Text)
  except
  end;
end;

procedure TChartShapeEditor.SEX1Change(Sender: TObject);
begin
  if Showing and (SEX1.Text<>'') then
  try
    TheSeries.X1:=StrToFloat(SEX1.Text);
  except
  end;
end;

procedure TChartShapeEditor.SEY1Change(Sender: TObject);
begin
  if Showing and (SEY1.Text<>'') then
  try
    TheSeries.Y1:=StrToFloat(SEY1.Text)
  except
  end;
end;

procedure TChartShapeEditor.BShapeBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,TheSeries.Brush);
  BShapeColor.Repaint;
end;

procedure TChartShapeEditor.MemoTextChange(Sender: TObject);
begin
  if not CreatingForm then TheSeries.Text:=MemoText.Lines;
end;

procedure TChartShapeEditor.RGAlignClick(Sender: TObject);
begin
  Case RGAlign.ItemIndex of
    0: TheSeries.Alignment:=taLeftJustify;
    1: TheSeries.Alignment:=taCenter;
    2: TheSeries.Alignment:=taRightJustify;
  end;
end;

procedure TChartShapeEditor.CBTransClick(Sender: TObject);
begin
  TheSeries.Transparent:=CBTrans.Checked;
end;

procedure TChartShapeEditor.CBStyleChange(Sender: TObject);
begin
  TheSeries.Style:=TChartShapeStyle(CBStyle.ItemIndex);
  EnableRound;
  CBRound.Enabled:=TheSeries.Style=chasRectangle;
end;

procedure TChartShapeEditor.EnableRound;
begin
  With TheSeries do
    CBRound.Enabled:=(Style=chasRectangle) and (not ParentChart.View3D);
end;

procedure TChartShapeEditor.CBUnitsChange(Sender: TObject);
begin
  TheSeries.XYStyle:=TChartShapeXYStyle(CBUnits.ItemIndex);
end;

procedure TChartShapeEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  FEditFont:=InsertTeeFontEditor(TabFont);
end;

procedure TChartShapeEditor.CBRoundClick(Sender: TObject);
begin
  TheSeries.RoundRectangle:=CBRound.Checked
end;

procedure TChartShapeEditor.RGVertAlignClick(Sender: TObject);
begin
  Case RGVertAlign.ItemIndex of
    0: TheSeries.VertAlign:=vaTop;
    1: TheSeries.VertAlign:=vaCenter;
    2: TheSeries.VertAlign:=vaBottom;
  end;
end;

procedure TChartShapeEditor.Button1Click(Sender: TObject);
begin
  EditTeeGradient(Self,TheSeries.Gradient);
end;

initialization
  RegisterClass(TChartShapeEditor);
end.
