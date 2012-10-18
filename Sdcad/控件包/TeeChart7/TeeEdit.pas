{*****************************************}
{   TeeChart Pro                          }
{   Copyright (c) 1995-2004 David Berneda }
{     TChartEditor                        }
{     TChartPreviewer                     }
{     TChartEditorPanel                   }
{*****************************************}
unit TeeEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     Chart, TeeEditCha, TeeLisB, TeeProcs, TeEngine, TeePrevi, TeePreviewPanel;

type
  TCustomChartEditor=class(TComponent)
  private
    { Private declarations }
    FChart   : TCustomChart;
    FTitle   : String;
    FOnClose : TNotifyEvent;
    FOnShow  : TNotifyEvent;
  protected
    { Protected declarations }
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    procedure SetChart(const Value: TCustomChart); virtual;
  public
    { Public declarations }
    Procedure Execute; virtual; // abstract;

    property Title:String read FTitle write FTitle;
  published
    { Published declarations }
    property Chart:TCustomChart read FChart write SetChart;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

  TChartEditor = class(TCustomChartEditor)
  private
    { Private declarations }
    FAutoRepaint   : Boolean;
    FDefaultTab    : TChartEditorTab;
    FHideTabs      : TChartEditorHiddenTabs;
    FHighLight     : Boolean;
    FOnChangeOrder : TChangeOrderEvent;
    FOptions       : TChartEditorOptions;
    FRememberPosition: Boolean;
    FSeries        : TChartSeries;
    FTree          : Boolean;

    procedure ChangeSeriesOrder(Sender:TChartListBox;
                                Series1,Series2:TCustomChartSeries);
    procedure SetSeries(const Value: TChartSeries);
  protected
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    procedure SetChart(const Value: TCustomChart); override;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;

    Procedure Execute; override;
  published
    { Published declarations }
    property AutoRepaint:Boolean read FAutoRepaint write FAutoRepaint default True;
    property DefaultTab:TChartEditorTab read FDefaultTab write FDefaultTab default cetMain;
    property HideTabs:TChartEditorHiddenTabs read FHideTabs write FHideTabs default [];
    property HighLightTabs:Boolean read FHighLight write FHighLight default False;
    property Options:TChartEditorOptions read FOptions write FOptions
                                         default eoAll;
    property RememberPosition:Boolean read FRememberPosition write
                                      FRememberPosition default False;
    property Series:TChartSeries read FSeries write SetSeries;
    property Title;
    property TreeView:Boolean read FTree write FTree default False;

    { events }
    property OnChangeSeriesOrder:TChangeOrderEvent read FOnChangeOrder
                                                   write FOnChangeOrder;
  end;

  TChartPreviewOption=( cpoChangePrinter,
                        cpoSetupPrinter,
                        cpoResizeChart,
                        cpoMoveChart,
                        cpoChangeDetail,
                        cpoChangePaperOrientation,
                        cpoChangeMargins,
                        cpoProportional,
                        cpoDragChart,
                        cpoPrintPanel,
                        cpoAsBitmap );

  TChartPreviewOptions=set of TChartPreviewOption;

Const DefaultChartPreviewOptions=[ cpoChangePrinter,
                                   cpoSetupPrinter,
                                   cpoResizeChart,
                                   cpoMoveChart,
                                   cpoChangeDetail,
                                   cpoChangePaperOrientation,
                                   cpoChangeMargins,
                                   cpoProportional ];


type
  TChartPreviewer = class(TCustomChartEditor)
  private
    FOnAfterDraw: TNotifyEvent;
    FOptions    : TChartPreviewOptions;
    FPaperColor : TColor;
    FWindowState: TWindowState;

    TheForm     : TChartPreview;
    function GetPreview: TTeePreviewPanel;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Procedure Execute; override;
    property PreviewPanel : TTeePreviewPanel read GetPreview;
  published
    { Published declarations }
    property Options:TChartPreviewOptions read FOptions write FOptions
             default DefaultChartPreviewOptions;
    property PaperColor:TColor read FPaperColor write FPaperColor default clWhite;
    property Title;
    property WindowState:TWindowState read FWindowState write FWindowState default wsNormal;

    property OnAfterDraw:TNotifyEvent read FOnAfterDraw write FOnAfterDraw;
  end;

  TChartEditorPanel=class(TCustomPanelNoCaption)
  private
    FChart  : TCustomChart;
    FEditor : TChartEditForm;

    {$IFNDEF CLX}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}

    Procedure SetChart(Value:TCustomChart);
  protected
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Procedure SelectUnderMouse;
    property Editor:TChartEditForm read FEditor;
  published
    property Align;
    property BevelOuter default bvLowered;
    property Chart:TCustomChart read FChart write SetChart;

    {$IFNDEF CLX}
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragMode;
    {$ENDIF}
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property Locked;
    {$ENDIF}

    { TPanel events }
    property OnClick;
    {$IFNDEF CLX}
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    {$ENDIF}
    property OnDblClick;
    {$IFNDEF CLX}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    {$IFNDEF CLX}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;
    property OnConstrainedResize;
    property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

implementation

Uses TeeProCo, EditChar, TeeEdiAxis, TeeEdiTitl, TeePenDlg;

{ TCustomChartEditor }
procedure TCustomChartEditor.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

Procedure TCustomChartEditor.Execute; // virtual; abstract;
begin
end;

procedure TCustomChartEditor.SetChart(const Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then FChart.RemoveFreeNotification(Self);
    {$ENDIF}
    FChart:=Value;
    if Assigned(FChart) then FChart.FreeNotification(Self);
  end;
end;

{ TChartEditor }
Constructor TChartEditor.Create(AOwner:TComponent);
begin
  inherited;
  FHideTabs:=[];
  FOptions:=eoAll;
  FDefaultTab:=cetMain;
  FAutoRepaint:=True;
end;

procedure TChartEditor.ChangeSeriesOrder(Sender:TChartListBox;
                                         Series1,Series2:TCustomChartSeries);
begin
  if Assigned(FOnChangeOrder) then FOnChangeOrder(Sender,Series1,Series2);
end;

procedure TChartEditor.Execute;
Var TheForm : TChartEditForm;
    OldAuto : Boolean;
begin
  if Assigned(FChart) then
  begin
    TheForm:=TChartEditForm.Create(nil);

    With TheForm do
    try
      Tree.Visible:=FTree;
      
      RememberPosition:=Self.RememberPosition;  // set before setting chart
      Caption:=Self.Title;

      EditorOptions:=Self.Options;  // Before setting Chart !

      Chart:=Self.Chart;

      HighLightTabs:=Self.FHighLight;
      TheEditSeries:=Self.Series;

      CheckHelpFile;
      TheActivePageIndex:=Ord(FDefaultTab);
      TheHiddenTabs:=FHideTabs;
      LBSeries.OnChangeOrder:=ChangeSeriesOrder; // 5.03
      if Assigned(Self.FOnShow) then Self.FOnShow(TheForm);

      OldAuto:=True;
      if not Self.FAutoRepaint then
      begin
        OldAuto:=FChart.AutoRepaint;
        FChart.AutoRepaint:=False;
      end;

      TeeTranslateControl(TheForm);
      ShowModal;

      if not Self.FAutoRepaint then
      begin
        FChart.AutoRepaint:=OldAuto;
        FChart.Repaint;
      end;
    finally
      if Assigned(Self.FOnClose) then Self.FOnClose(TheForm);
      Free;
    end;
    FChart.CancelMouse:=True;
  end;
end;

procedure TChartEditor.SetSeries(const Value: TChartSeries);
begin
  if FSeries<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FSeries) then FSeries.RemoveFreeNotification(Self);
    {$ENDIF}

    FSeries:=Value;

    if Assigned(Series) then
    begin
      FSeries.FreeNotification(Self);
      if Assigned(Chart) and (Series.ParentChart<>Chart) then
         Chart:=TCustomChart(Series.ParentChart);
    end;
  end;
end;

procedure TChartEditor.Notification( AComponent: TComponent;
                                     Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FSeries) and (AComponent=FSeries) then
     Series:=nil;
end;

procedure TChartEditor.SetChart(const Value: TCustomChart);
begin
  inherited;
  if Assigned(Chart) and Assigned(Series) and (Series.ParentChart<>Chart) then
     Series:=nil;
end;

{ TChartPreviewer }
Constructor TChartPreviewer.Create(AOwner:TComponent);
begin
  inherited;
  FOptions:=DefaultChartPreviewOptions;
  FPaperColor:=clWhite;
  FWindowState:=wsNormal;
end;

procedure TChartPreviewer.Execute;
var OldPrintTeePanel : Boolean;
begin
  if Assigned(FChart) then
  begin
    TheForm:=TChartPreview.Create(nil);
    with TheForm do
    try
      if Self.FTitle<>'' then Caption:=Self.FTitle;
      TeePreviewPanel1.Panel:=Self.FChart;
      TeePreviewPanel1.OnAfterDraw:=Self.OnAfterDraw;
      WindowState:=Self.FWindowState;
      if not (cpoChangePrinter in Self.FOptions) then CBPrinters.Enabled:=False;
      if not (cpoSetupPrinter in Self.FOptions) then BSetupPrinter.Enabled:=False;
      TeePreviewPanel1.AllowResize:=(cpoResizeChart in Self.FOptions);
      TeePreviewPanel1.AllowMove:=(cpoMoveChart in Self.FOptions);
      if not (cpoChangeDetail in Self.FOptions) then ChangeDetailGroup.Enabled:=False;
      if not (cpoChangePaperOrientation in Self.FOptions) then Orientation.Enabled:=False;
      if not (cpoChangeMargins in Self.FOptions) then
      begin
        GBMargins.Enabled:=False;
        BReset.Enabled:=False;
      end;
      With TeePreviewPanel1.Panel do
      if PrintProportional then
         PrintProportional:=(cpoProportional in Self.FOptions);
      TeePreviewPanel1.PaperColor:=Self.FPaperColor;
      TeePreviewPanel1.DragImage:=(cpoDragChart in Self.FOptions);
      OldPrintTeePanel:=PrintTeePanel;
      PrintTeePanel:=(cpoPrintPanel in Self.FOptions);
      TeePreviewPanel1.AsBitmap:=(cpoAsBitmap in Self.FOptions);
      if Assigned(Self.FOnShow) then Self.FOnShow(TheForm);
      ShowModal;
      PrintTeePanel:=OldPrintTeePanel;
    finally
      if Assigned(Self.FOnClose) then Self.FOnClose(TheForm);
      Free;
      TheForm:=nil;
      Self.FChart.Repaint;
    end;
    Self.FChart.CancelMouse:=True;
  end;
end;

function TChartPreviewer.GetPreview: TTeePreviewPanel;
begin
  if Assigned(TheForm) then
     result:=TheForm.TeePreviewPanel1
  else
     result:=nil;
end;

{ TChartEditorPanel }
Constructor TChartEditorPanel.Create(AOwner:TComponent);
begin
  inherited;
  BevelOuter:=bvLowered;
  Width :=409;
  Height:=291;

  if not (csDesigning in ComponentState) then
  begin
    FEditor:=TChartEditForm.Create(Self);

    TeeTranslateControl(FEditor);

    With FEditor do
    begin
      RememberPosition:=False;
      RememberSize:=False;

      BorderStyle:=TeeFormBorderStyle;
      PanBottom.Visible:=False;

      {$IFNDEF D5}
      Show;
      {$ENDIF}

      Align:=alClient;
      Parent:=Self;

      {$IFDEF D5}
      Show;
      {$ENDIF}
    end;
  end;
end;

procedure TChartEditorPanel.Notification( AComponent: TComponent;
                                          Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

procedure TChartEditorPanel.SelectUnderMouse;
Var P : TChartClickedPart;

  Procedure Select(ATab:TTabSheet);
  begin
    With Editor do
    begin
      MainPage.ActivePage:=TabChart;
      SubPage.ActivePage:=ATab;
      SubPageChange(Self);
    end;
  end;

  Procedure SelectTitle(ATitle:TChartTitle);
  begin
    Select(Editor.TabTitle);
    With Editor.TabTitle.Controls[0] as TFormTeeTitle do
    begin
      TheTitle:=ATitle;
      FormShow(Self);
    end;
  end;

begin
  if Assigned(Chart) then
  begin
    Chart.CalcClickedPart(Chart.GetCursorPos,P);
    Case P.Part of
      cpLegend: With Editor do
                begin
                  MainPage.ActivePage:=TabChart;
                  SubPage.ActivePage:=TabLegend;
                  SubPageChange(Self);
                end;
      cpSeriesMarks,
      cpSeries: With Editor do
                begin
                  MainPage.ActivePage:=TabSeries;
                  MainPageChange(Self);
                  TheEditSeries:=P.ASeries;
                  TheFormSeries.TheSeries:=TheEditSeries;
                  LBSeries.FillSeries(TheEditSeries);
                  SetTabSeries;
                  if P.Part=cpSeriesMarks then
                  With TheFormSeries do
                     PageSeries.ActivePage:=TabMarks;
                end;
        cpAxis: With Editor do
                begin
                  MainPage.ActivePage:=TabChart;
                  TheAxis:=P.AAxis;
                  SubPage.ActivePage:=TabAxis;
                  SubPageChange(Self);
                  With (TabAxis.Controls[0] as TFormTeeAxis) do
                  begin
                    TheAxis:=P.AAxis;
                    FormShow(Self);
                  end;
                end;
       cpTitle : SelectTitle(Chart.Title);
    cpSubTitle : SelectTitle(Chart.SubTitle);
        cpFoot : SelectTitle(Chart.Foot);
     cpSubFoot : SelectTitle(Chart.SubFoot);
    else
      Select(Editor.TabPanel);
    end;
  end;
end;

{$IFNDEF CLX}
procedure TChartEditorPanel.CMShowingChanged(var Message: TMessage);
begin
  inherited;

  if Assigned(Parent) then
     Parent.UpdateControlState;
end;
{$ENDIF}

Procedure TChartEditorPanel.SetChart(Value:TCustomChart);
begin
  FChart:=Value;
  if Assigned(FEditor) then FEditor.Chart:=FChart;
end;

end.
