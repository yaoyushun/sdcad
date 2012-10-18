{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2004 by David Berneda    }
{**********************************************}
unit TeeEdiGene;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     Chart, TeCanvas, TeePenDlg, TeeProcs, TeeNavigator;

type
  TFormTeeGeneral = class(TForm)
    BPrint: TButton;
    GBMargins: TGroupBox;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDLeftMa: TUpDown;
    UDBotMa: TUpDown;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    LSteps: TLabel;
    Label1: TLabel;
    CBAllowZoom: TCheckBox;
    CBAnimatedZoom: TCheckBox;
    SEAniZoomSteps: TEdit;
    UDAniZoomSteps: TUpDown;
    BZoomPen: TButtonPen;
    BZoomColor: TButton;
    EMinPix: TEdit;
    UDMinPix: TUpDown;
    TabSheet2: TTabSheet;
    RGPanning: TRadioGroup;
    Label2: TLabel;
    CBDir: TComboFlat;
    Label3: TLabel;
    CBZoomMouse: TComboFlat;
    Label4: TLabel;
    CBScrollMouse: TComboFlat;
    Label5: TLabel;
    CBMarUnits: TComboFlat;
    Label6: TLabel;
    CBCursor: TComboFlat;
    CBUpLeft: TCheckBox;
    procedure BPrintClick(Sender: TObject);
    procedure CBAllowZoomClick(Sender: TObject);
    procedure CBAnimatedZoomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RGPanningClick(Sender: TObject);
    procedure SEAniZoomStepsChange(Sender: TObject);
    procedure SERightMaChange(Sender: TObject);
    procedure SETopMaChange(Sender: TObject);
    procedure SEBotMaChange(Sender: TObject);
    procedure SELeftMaChange(Sender: TObject);
    procedure BZoomColorClick(Sender: TObject);
    procedure EMinPixChange(Sender: TObject);
    procedure CBDirChange(Sender: TObject);
    procedure CBZoomMouseChange(Sender: TObject);
    procedure CBScrollMouseChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBMarUnitsChange(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure CBUpLeftClick(Sender: TObject);
  private
    { Private declarations }
    procedure AdjustMarginMinMax;
    Function ChangeMargin(UpDown:TUpDown; APos,OtherSide:Integer):Integer;
    Procedure EnableZoomControls;
  public
    { Public declarations }
    TheChart : TCustomChart;
    Constructor CreateChart(Owner:TComponent; AChart:TCustomChart);
  end;

  // 5.03 Moved here from TeeNavigator.pas unit.
  // Now TeeNavigator is an abstract class.

  TChartPageNavigator=class(TCustomTeeNavigator)
  private
    function GetChart: TCustomChart;
    procedure SetChart(const Value: TCustomChart);
  protected
    procedure BtnClick(Index: TTeeNavigateBtn); override;
    procedure DoTeeEvent(Event: TTeeEvent); override;
    procedure SetPanel(const Value: TCustomTeePanel); override;
  public
    procedure EnableButtons; override;
    Function PageCount:Integer; override;
    procedure Print; override;
  published
    property Chart:TCustomChart read GetChart write SetChart;
    property OnButtonClicked;
  end;

Procedure ChartPreview(AOwner:TComponent; TeePanel:TCustomTeePanel);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     TeePreviewPanel,
     {$ENDIF}
     TeEngine, TeePrevi, TeExport, TeeStore, TeeBrushDlg;

Procedure ChartPreview(AOwner:TComponent; TeePanel:TCustomTeePanel);
Begin
  with TChartPreview.Create(AOwner) do
  try
    PageNavigatorClass:=TChartPageNavigator;
    TeePreviewPanel1.Panel:=TeePanel;
    ShowModal;
  finally
    Free;
    TeePanel.Repaint;
  end;
End;

{ Chart General Editor }
Constructor TFormTeeGeneral.CreateChart(Owner:TComponent; AChart:TCustomChart);
begin
  inherited Create(Owner);
  TheChart:=AChart;
end;

procedure TFormTeeGeneral.BPrintClick(Sender: TObject);
begin
  ChartPreview(nil,TheChart); { 5.01 }
end;

Procedure TFormTeeGeneral.EnableZoomControls;
begin
  EnableControls(TheChart.Zoom.Allow,[ CBAnimatedZoom, UDAniZoomSteps,
                                       SEAniZoomSteps,EMinPix,UDMinPix,
                                       BZoomPen,BZoomColor,CBDir,CBZoomMouse,
                                       CBUpLeft]);
end;

procedure TFormTeeGeneral.CBAllowZoomClick(Sender: TObject);
begin
  TheChart.Zoom.Allow:=CBAllowZoom.Checked;
  EnableZoomControls;
end;

procedure TFormTeeGeneral.CBAnimatedZoomClick(Sender: TObject);
begin
  TheChart.Zoom.Animated:=CBAnimatedZoom.Checked;
end;

procedure TFormTeeGeneral.FormShow(Sender: TObject);
begin
  if Assigned(TheChart) then
  With TheChart do
  begin
    RGPanning.ItemIndex    :=Ord(AllowPanning);

    UDTopMa.Position       :=MarginTop;
    UDLeftMa.Position      :=MarginLeft;
    UDBotMa.Position       :=MarginBottom;
    UDRightMa.Position     :=MarginRight;
    CBMarUnits.ItemIndex   :=Ord(MarginUnits);

    AdjustMarginMinMax;

    With Zoom do
    begin
      CBAllowZoom.Checked    :=Allow;
      CBAnimatedZoom.Checked :=Animated;
      UDAniZoomSteps.Position:=AnimatedSteps;
      EnableZoomControls;
      UDMinPix.Position      :=MinimumPixels;
      CBDir.ItemIndex        :=Ord(Direction);
      CBZoomMouse.ItemIndex  :=Ord(MouseButton);
      CBUpLeft.Checked       :=UpLeftZooms;
      BZoomPen.LinkPen(Pen);
    end;

    CBScrollMouse.ItemIndex  :=Ord(ScrollMouseButton);
    CBScrollMouse.Enabled    :=AllowPanning<>pmNone;

    TeeFillCursors(CBCursor,Cursor);
  end;
end;

procedure TFormTeeGeneral.AdjustMarginMinMax;

  Procedure SetMinMax(Up:TUpDown);
  begin
    if TheChart.MarginUnits=muPixels then
    begin
      Up.Min:=-2000;
      Up.Max:=2000;
    end
    else
    begin
      Up.Min:=0;
      Up.Max:=100;
    end;
  end;

begin
  SetMinMax(UDTopMa);
  SetMinMax(UDLeftMa);
  SetMinMax(UDRightMa);
  SetMinMax(UDBotMa);
end;

procedure TFormTeeGeneral.CBMarUnitsChange(Sender: TObject);
begin
  TheChart.MarginUnits:=TTeeUnits(CBMarUnits.ItemIndex);
  AdjustMarginMinMax;
end;

procedure TFormTeeGeneral.RGPanningClick(Sender: TObject);
begin
  TheChart.AllowPanning:=TPanningMode(RGPanning.ItemIndex);
  CBScrollMouse.Enabled:=TheChart.AllowPanning<>pmNone;
end;

procedure TFormTeeGeneral.SEAniZoomStepsChange(Sender: TObject);
begin
  if Showing then TheChart.Zoom.AnimatedSteps:=UDAniZoomSteps.Position;
end;

Function TFormTeeGeneral.ChangeMargin(UpDown:TUpDown; APos,OtherSide:Integer):Integer;
begin
  result:=APos;
  if Showing then
  With UpDown do
  if (TheChart.MarginUnits=muPixels) or (Position+OtherSide<100) then
     result:=Position
  else
     Position:=APos;
end;

procedure TFormTeeGeneral.SERightMaChange(Sender: TObject);
begin
  if Showing then
  With TheChart do MarginRight:=ChangeMargin(UDRightMa,MarginRight,MarginLeft);
end;

procedure TFormTeeGeneral.SETopMaChange(Sender: TObject);
begin
  if Showing then
  With TheChart do MarginTop:=ChangeMargin(UDTopMa,MarginTop,MarginBottom);
end;

procedure TFormTeeGeneral.SEBotMaChange(Sender: TObject);
begin
  if Showing then
  With TheChart do MarginBottom:=ChangeMargin(UDBotMa,MarginBottom,MarginTop);
end;

procedure TFormTeeGeneral.SELeftMaChange(Sender: TObject);
begin
  if Showing then
  With TheChart do MarginLeft:=ChangeMargin(UDLeftMa,MarginLeft,MarginRight);
end;

procedure TFormTeeGeneral.BZoomColorClick(Sender: TObject);
begin
  EditChartBrush(Self,TheChart.Zoom.Brush);
end;

procedure TFormTeeGeneral.EMinPixChange(Sender: TObject);
begin
  if Showing then TheChart.Zoom.MinimumPixels:=UDMinPix.Position
end;

procedure TFormTeeGeneral.CBDirChange(Sender: TObject);
begin
  TheChart.Zoom.Direction:=TTeeZoomDirection(CBDir.ItemIndex);
end;

procedure TFormTeeGeneral.CBZoomMouseChange(Sender: TObject);
begin
  TheChart.Zoom.MouseButton:=TMouseButton(CBZoomMouse.ItemIndex)
end;

procedure TFormTeeGeneral.CBScrollMouseChange(Sender: TObject);
begin
  TheChart.ScrollMouseButton:=TMouseButton(CBScrollMouse.ItemIndex)
end;

procedure TFormTeeGeneral.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  PageControl1.ActivePage:=TabSheet1;
end;

{ TChartPageNavigator }
procedure TChartPageNavigator.BtnClick(Index: TTeeNavigateBtn);
var tmp : TCustomChart;
begin
  tmp:=Chart;
  if Assigned(tmp) then
  with tmp do
  case Index of
    nbPrior : if Page>1 then Page:=Page-1;
    nbNext  : if Page<NumPages then Page:=Page+1;
    nbFirst : if Page>1 then Page:=1;
    nbLast  : if Page<NumPages then Page:=NumPages;
  end;
  EnableButtons;
  inherited;
end;

procedure TChartPageNavigator.SetPanel(const Value: TCustomTeePanel);
begin
  if Value is TCustomAxisPanel then inherited
                               else inherited SetPanel(nil);
end;

procedure TChartPageNavigator.EnableButtons;
var tmp : TCustomChart;
begin
  inherited;
  tmp:=Chart;
  if Assigned(tmp) then
  begin
    Buttons[nbFirst].Enabled:=tmp.Page>1;
    Buttons[nbPrior].Enabled:=Buttons[nbFirst].Enabled;
    Buttons[nbNext].Enabled:=tmp.Page<tmp.NumPages;
    Buttons[nbLast].Enabled:=Buttons[nbNext].Enabled;
  end;
end;

procedure TChartPageNavigator.DoTeeEvent(Event: TTeeEvent);
begin
  if (Event is TChartChangePage) or
     ( (Event is TTeeSeriesEvent) and
       (TTeeSeriesEvent(Event).Event=seDataChanged)
      ) then
        EnableButtons;
end;

function TChartPageNavigator.GetChart: TCustomChart;
begin
  result:=TCustomChart(Panel);
end;

procedure TChartPageNavigator.SetChart(const Value: TCustomChart);
begin
  Panel:=Value;
end;

Function TChartPageNavigator.PageCount:Integer;
begin
  result:=Chart.NumPages;
end;

procedure TChartPageNavigator.Print;
begin
  if PageCount>1 then
  With TPrintDialog.Create(Self) do
  try
    {$IFNDEF CLX}
    Options:=[poPageNums];
    PrintRange:=prPageNums;
    {$ENDIF}

    FromPage:=1;
    MinPage:=FromPage;
    ToPage:=Chart.NumPages;
    MaxPage:=ToPage;
    if Execute then Chart.PrintPages(FromPage,ToPage);
  finally
    Free;
  end
  else Chart.PrintPages(1,1);
end;

procedure TFormTeeGeneral.CBCursorChange(Sender: TObject);
begin
  with TheChart do
  begin
    Cursor:=TeeSetCursor(Cursor,CBCursor.Items[CBCursor.ItemIndex]);
    OriginalCursor:=Cursor;
  end;
end;

procedure TFormTeeGeneral.CBUpLeftClick(Sender: TObject);
begin
  TheChart.Zoom.UpLeftZooms:=CBUpLeft.Checked;
end;

end.
