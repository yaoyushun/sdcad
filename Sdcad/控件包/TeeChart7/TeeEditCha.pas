{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2004 by David Berneda    }
{**********************************************}
unit TeeEditCha;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QStdCtrls, QExtCtrls, QComCtrls, QButtons,
     QDialogs, QGrids, QMenus, QTypes, QCheckLst,
     {$ELSE}
     Graphics, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     Dialogs, Grids, Menus, CheckLst,
     {$ENDIF}
     Chart, TeEngine, TeeProcs, TeeEdiSeri, TeeLisB, TeeChartGrid, TeePrevi,
     TeeNavigator;

Const teeEditMainPage    =0;
      teeEditGeneralPage =1;
      teeEditAxisPage    =2;
      teeEditTitlePage   =3;
      teeEditLegendPage  =4;
      teeEditPanelPage   =5;
      teeEditPagingPage  =6;
      teeEditWallsPage   =7;
      teeEdit3DPage      =8;

type
  TChartEditorOption=( ceAdd,
                       ceDelete,
                       ceChange,
                       ceClone,
                       ceDataSource,
                       ceTitle,
                       ceHelp,
                       ceGroups,  // 6.02
                       ceGroupAll );  // 6.02

Const eoAll=[Low(TChartEditorOption)..High(TChartEditorOption)]-[ceGroups];

type
  TChartEditorTab=( cetMain,
                    cetGeneral,
                    cetAxis,
                    cetTitles,
                    cetLegend,
                    cetPanel,
                    cetPaging,
                    cetWalls,
                    cet3D,
                    cetSeriesGeneral,
                    cetSeriesMarks,
                    cetAllSeries,
                    cetSeriesData,
                    cetExport,
                    cetExportNative,  // 7.0
                    cetTools,
                    cetPrintPreview
                    {$IFDEF TEEOCX}
                    ,cetOpenGL
                    {$ENDIF}
                   );

  TChartEditorOptions=set of TChartEditorOption;
  TChartEditorHiddenTabs=set of TChartEditorTab;

  TChartEditForm = class(TForm)
    MainPage: TPageControl;
    TabChart: TTabSheet;
    SubPage: TPageControl;
    TabSeriesList: TTabSheet;
    TabAxis: TTabSheet;
    TabGeneral: TTabSheet;
    TabTitle: TTabSheet;
    TabLegend: TTabSheet;
    TabPanel: TTabSheet;
    TabPaging: TTabSheet;
    TabWalls: TTabSheet;
    TabSeries: TTabSheet;
    Tab3D: TTabSheet;
    TabData: TTabSheet;
    TabExport: TTabSheet;
    PanBottom: TPanel;
    LabelWWW: TLabel;
    ButtonHelp: TButton;
    TabTools: TTabSheet;
    TabPrint: TTabSheet;
    PanRight: TPanel;
    BMoveUP: TSpeedButton;
    BMoveDown: TSpeedButton;
    BAddSeries: TButton;
    BDeleteSeries: TButton;
    BRenameSeries: TButton;
    BCloneSeries: TButton;
    BChangeTypeSeries: TButton;
    PanTop: TPanel;
    PanBot: TPanel;
    PanLeft: TPanel;
    PanClose: TPanel;
    BClose: TButton;
    ChartGrid1: TChartGrid;
    Panel1: TPanel;
    ChartGridNavigator1: TChartGridNavigator;
    Panel2: TPanel;
    SBGridText: TSpeedButton;
    SBGridCol: TSpeedButton;
    SBGrid3D: TSpeedButton;
    SBGridX: TSpeedButton;
    PopupData: TPopupMenu;
    Deleterow1: TMenuItem;
    Groups: TCheckListBox;
    Splitter1: TSplitter;
    PanelGroups: TPanel;
    BAddGroup: TSpeedButton;
    BDeleteGroup: TSpeedButton;
    BRenameGroup: TSpeedButton;
    Tree: TTreeView;
    TreeSplitter: TSplitter;
    Insertrow1: TMenuItem;
    CBNames: TCheckBox;
    LBSeries: TChartListBox;
    N1: TMenuItem;
    EditColor1: TMenuItem;
    DefaultColor1: TMenuItem;
    Makenullpoint1: TMenuItem;
    N2: TMenuItem;
    extfont1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SubPageChange(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure BMoveUPClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    procedure BAddSeriesClick(Sender: TObject);
    procedure BDeleteSeriesClick(Sender: TObject);
    procedure BRenameSeriesClick(Sender: TObject);
    procedure BCloneSeriesClick(Sender: TObject);
    procedure MainPageChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LBSeriesEditSeries(Sender: TChartListBox; Index: Integer);
    procedure LBSeriesOtherItemsChange(Sender: TObject);
    procedure LBSeriesRefreshButtons(Sender: TObject);
    procedure BChangeTypeSeriesClick(Sender: TObject);
    procedure LabelWWWClick(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure MainPageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure SubPageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure SBGridTextClick(Sender: TObject);
    procedure SBGridColClick(Sender: TObject);
    procedure SBGrid3DClick(Sender: TObject);
    procedure SBGridXClick(Sender: TObject);
    procedure Deleterow1Click(Sender: TObject);
    procedure GroupsClick(Sender: TObject);
    procedure GroupsClickCheck(Sender: TObject);
    procedure LBSeriesChangeActive(Sender: TChartListBox;
      Series: TCustomChartSeries);
    procedure GroupsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GroupsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure BAddGroupClick(Sender: TObject);
    procedure BRenameGroupClick(Sender: TObject);
    procedure BDeleteGroupClick(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure TreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Insertrow1Click(Sender: TObject);
    procedure CBNamesClick(Sender: TObject);
    procedure PopupDataPopup(Sender: TObject);
    procedure EditColor1Click(Sender: TObject);
    procedure DefaultColor1Click(Sender: TObject);
    procedure Makenullpoint1Click(Sender: TObject);
    procedure extfont1Click(Sender: TObject);
  private
    { Private declarations }
    OldWidth : Integer;
    TheChart : TCustomChart;
    FPreview : TChartPreview;

    TreePanel : TPanel;
    TreeNodeSeries: TTreeNode;
    TreeNodeTools : TTreeNode;

    {$IFNDEF TEELITE}
    procedure AddedTool(Sender:TObject);
    procedure DeletedTool(Sender:TObject);
    procedure CreateToolsForm;
    {$ENDIF}
   
    procedure AddSeriesNodes;
    procedure AxisNotifyCustom(Sender: TObject);  // 6.01
    procedure BroadCastShowEditor(Tab:TTabSheet);
    

    Function CurrentGroup:TSeriesGroup;
    Function DeltaGroup:Integer;
    procedure EnableGroupButtons;
    procedure FillGroups;
    procedure GridMouseDown(Sender: TObject;
                           Button: TMouseButton; Shift: TShiftState;
                           X, Y: Integer);
    procedure InternalSetupFormSeries;
    procedure PrepareTree;
    procedure ReparentAxis;
    procedure ReparentTitle;
    procedure ReparentTools;
    procedure ResetParentTab(PageControl:TPageControl);
    procedure SelectTreeNodeData(AObject: TObject);
    procedure SetChart(Value:TCustomChart);
    Function TreeNodeCurrentSeries:TTreeNode;
    procedure TreeSelectSeries(Series: TChartSeries);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    {$IFNDEF CLX}
    procedure WMHelp(var Message: TWMHelp); message WM_HELP;
    {$ENDIF}
  public
    { Public declarations }
    TheAxis            : TChartAxis;
    TheTitle           : TChartTitle;
    TheTool            : TTeeCustomTool;
    TheWall            : TChartWall;
    TheSeries          : TChartSeries;
    TheEditSeries      : TChartSeries;
    TheActivePageIndex : Integer;
    TheHiddenTabs      : TChartEditorHiddenTabs;

    EditorOptions      : TChartEditorOptions;
    IsDssGraph         : Boolean;
    TheFormSeries      : TFormTeeSeries;
    HighLightTabs      : Boolean;
    RememberPosition   : Boolean;
    RememberSize       : Boolean;

    Procedure CheckHelpFile;
    procedure SetTabSeries;

    property Chart : TCustomChart read TheChart write SetChart;
  end;

Function GetTeeChartHelpFile:String;

type
  TTeeOnCreateEditor=Procedure(Editor:TChartEditForm; Tab:TTabSheet);

var
  TeeOnShowEditor:TList=nil;
  TeeSeriesNamesRuntime:Boolean=False;

const
  TeeMsg_RememberPosition='RememberPosition';
  TeeMsg_RememberSize='RememberSize';
  TeeMsg_TreeMode='TreeMode';
  TeeMsg_DefaultTheme='DefaultTheme';

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFNDEF LINUX}
     Registry,
     {$ENDIF}
     TeePenDlg, TeeBrushDlg, TeeConst, Series, TeExport, TeeExport, TeeFunci,
     TeeEdiAxis, TeeEdiLege, TeeEdiPane, TeeEdiTitl, TeeEdiWall, TeeEdiGene,
     TeeEdiPage, TeeEdi3D,
     {$IFNDEF TEELITE}
     TeeEditTools,
     {$ENDIF}
     TeeAbout, TeeGalleryPanel, Math, TeCanvas;

Function GetTeeChartHelpFile:String;
begin
  result:=GetRegistryHelpPath(
                   {$IFDEF TEEOCX}
                   'TeeChartX'+TeeChartVersion+'.hlp'
                   {$ELSE}
                   'TeeChart'+TeeChartVersion+'.hlp'
                   {$ENDIF}); // <- do not translate
end;

Function GetTeeChartUserHelpFile:String;
begin
  result:=GetRegistryHelpPath(
                   {$IFDEF TEEOCX}
                   'TeeUserX'+TeeChartVersion+'.hlp'
                   {$ELSE}
                   'TeeUser'+TeeChartVersion+'.hlp'
                   {$ENDIF}); // <- do not translate
end;

{ TChartEditForm }
Procedure TChartEditForm.CheckHelpFile;
begin
  if ceHelp in EditorOptions then
  begin
    if csDesigning in Chart.ComponentState then
       HelpFile:=GetTeeChartHelpFile
    else
       HelpFile:=GetTeeChartUserHelpFile;
    if HelpFile<>'' then BorderIcons:=BorderIcons+[biHelp];
  end
  else HelpFile:='';
  ButtonHelp.Visible:=ceHelp in EditorOptions;
end;

Function TChartEditForm.DeltaGroup:Integer;
begin
  if ceGroupAll in EditorOptions then result:=1
                                 else result:=0;
end;

procedure TChartEditForm.FillGroups;
var Old : Integer;
    t   : Integer;
begin
  Old:=Groups.ItemIndex;
  if Old=-1 then Old:=0;

  Groups.Clear;

  if ceGroupAll in EditorOptions then
  begin
    Groups.Items.Add(TeeMsg_All);
    Groups.Checked[0]:=Chart.SeriesList.AllActive;
  end;

  with Chart.SeriesList.Groups do
  for t:=0 to Count-1 do
  begin
    Groups.Items.Add(Items[t].Name);
    case Items[t].Active of
      gaYes: Groups.State[t+DeltaGroup]:=cbChecked;
      gaSome: Groups.State[t+DeltaGroup]:=cbGrayed;
      gaNo: Groups.State[t+DeltaGroup]:=cbUnChecked;
    end;
  end;

  if Old>Groups.Items.Count-1 then Old:=Groups.Items.Count-1;
  Groups.ItemIndex:=Old;
  GroupsClick(Self);
end;

procedure TChartEditForm.FormShow(Sender: TObject);

  Procedure HideTabs;

    procedure TryHideSubPage;  // 6.02
    var t : Integer;
    begin
      for t:=0 to SubPage.PageCount-1 do
      if SubPage.Pages[t].TabVisible then exit;
      TabChart.TabVisible:=False;
    end;

  Const Margin=26;
        HorizMargin=10;
        HorizButtonMargin=5;
  begin
    if cetMain in TheHiddenTabs then TabSeriesList.TabVisible:=False;
    if cetGeneral in TheHiddenTabs then TabGeneral.TabVisible:=False;
    if cetAxis in TheHiddenTabs then TabAxis.TabVisible:=False;
    if cetTitles in TheHiddenTabs then TabTitle.TabVisible:=False;
    if cetLegend in TheHiddenTabs then TabLegend.TabVisible:=False;
    if cetPanel in TheHiddenTabs then TabPanel.TabVisible:=False;
    if cetPaging in TheHiddenTabs then TabPaging.TabVisible:=False;
    if cetWalls in TheHiddenTabs then TabWalls.TabVisible:=False;
    if cet3D in TheHiddenTabs then Tab3D.TabVisible:=False;
    if cetSeriesData in TheHiddenTabs then TabData.TabVisible:=False;
    if cetExport in TheHiddenTabs then TabExport.TabVisible:=False;
    if cetTools in TheHiddenTabs then TabTools.TabVisible:=False;
    if cetPrintPreview in TheHiddenTabs then TabPrint.TabVisible:=False;
    if cetAllSeries in TheHiddenTabs then TabSeries.TabVisible:=False;

    TryHideSubPage;
  end;

  procedure ActivatePageIndex;
  var t : Integer;
  begin
    Case TChartEditorTab(TheActivePageIndex) of
      cetSeriesData   : begin MainPage.ActivePage:=TabData; MainPageChange(Self); end;
      cetExport       : begin MainPage.ActivePage:=TabExport; MainPageChange(Self); end;
      cetTools        : begin MainPage.ActivePage:=TabTools; MainPageChange(Self); end;
      cetPrintPreview : begin MainPage.ActivePage:=TabPrint; MainPageChange(Self); end;
    else
    begin
      if TheActivePageIndex<=teeEdit3DPage then // 5.01
      begin
        t:=TheActivePageIndex;

        While not SubPage.Pages[t].TabVisible do
        begin
          if t<(SubPage.PageCount-1) then // 5.03
             Inc(t)
          else
          begin
            t:=TheActivePageIndex;

            While not SubPage.Pages[t].TabVisible do
            if t>0 then
               Dec(t)
            else
               Break;

            break;
          end;
        end;

        TheActivePageIndex:=t;

        if SubPage.Pages[TheActivePageIndex].TabVisible then
        begin
          SubPage.ActivePage:=SubPage.Pages[TheActivePageIndex];
          SubPageChange(SubPage);
        end
        else
        if TabData.TabVisible then
        begin
          MainPage.ActivePage:=TabData;
          MainPageChange(Self);
        end
        else
        if TabTools.TabVisible then
        begin
          MainPage.ActivePage:=TabTools;
          MainPageChange(Self);
        end
        else
        if TabExport.TabVisible then
        begin
          MainPage.ActivePage:=TabExport;
          MainPageChange(Self);
        end
        else
        if TabPrint.TabVisible then
        begin
          MainPage.ActivePage:=TabPrint;
          MainPageChange(Self);
        end;
      end;
    end;
    end;
  end;

  Procedure SelectFirstSeries;
  begin
    if LBSeries.Items.Count>0 then
    begin
      if LBSeries.CanFocus then
         LBSeries.SetFocus;  // 5.03 CLX fix (unless fails to set ItemIndex)

      LBSeries.ItemIndex:=0;
      if LBSeries.MultiSelect then LBSeries.Selected[0]:=True; { 5.01 }
      LBSeriesRefreshButtons(LBSeries);
    end;
  end;

var St : String;
    tmp : Boolean;
begin
  CBNames.Visible:=(csDesigning in Chart.ComponentState) or TeeSeriesNamesRuntime;

  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);

  if TeeIsTrial then
     LabelWWW.Cursor:=crHandPoint
  else
     LabelWWW.Visible:=False;

  if TeeToolTypes.Count=0 then TabTools.TabVisible:=False;

  LBSeries.Chart:=Chart;

  if (Caption='') and Assigned(Chart) then
  begin
    FmtStr(St,TeeMsg_Editing,[Chart.Name]);
    Caption:=St;
  end;

  HideTabs;

  BroadcastShowEditor(nil);  // Before PrepareTree !

  if Assigned(Chart) and Tree.Visible then PrepareTree;

  if TheActivePageIndex<>-1 then ActivatePageIndex;

  // Series Groups
  BAddGroup.Visible:=ceGroups in EditorOptions;
  BDeleteGroup.Visible:=BAddGroup.Visible;
  BRenameGroup.Visible:=BAddGroup.Visible;

  if ceGroups in EditorOptions then
  begin
    PanelGroups.Visible:=True;
    Splitter1.Visible:=True;
    FillGroups;
  end;

  if not BAddGroup.Visible then
     CBNames.Left:=LBSeries.Left;
     
  if Assigned(TheEditSeries) then
  begin
    LBSeries.SelectedSeries:=TheEditSeries;
    LBSeriesEditSeries(LBSeries,0);
  end
  else
  if Assigned(TheTool) and TabTools.TabVisible then
  begin
    MainPage.ActivePage:=TabTools;
    MainPageChange(Self);
  end
  else
  if TheActivePageIndex=-1 then
     SelectFirstSeries;

  if TabSeriesList.Showing and (LBSeries.Items.Count>0) then // 7.0
  Case TChartEditorTab(TheActivePageIndex) of
    cetSeriesGeneral,
    cetSeriesMarks : begin
                       LBSeriesEditSeries(LBSeries,LBSeries.ItemIndex);

                       with TheFormSeries do
                       begin
                         tmp:=True;
                         PageSeriesChanging(PageSeries,tmp);

                         if TChartEditorTab(TheActivePageIndex)=cetSeriesGeneral then
                            PageSeries.ActivePage:=TabGeneral
                         else
                            PageSeries.ActivePage:=TabMarks;

                         PageSeriesChange(PageSeries);
                       end;
                     end;
  else
    SelectFirstSeries;
  end
  else
    LBSeriesRefreshButtons(LBSeries);
end;

procedure TChartEditForm.AddSeriesNodes;
var t : Integer;
begin
  TreeNodeSeries.DeleteChildren;
  for t:=0 to LBSeries.Items.Count-1 do
      Tree.Items.AddChildObject(TreeNodeSeries,LBSeries.Items[t],LBSeries.Items.Objects[t]);
end;

procedure TChartEditForm.PrepareTree;
var tmpNode  : TTreeNode;
    tmpNode2 : TTreeNode;
    t        : Integer;
    tt       : Integer;
begin
  TreeSplitter.Visible:=True;

  OldWidth:=Width;
  Width:=Width+Tree.Width+TreeSplitter.Width;

  ButtonHelp.Left:=16;

  MainPage.Visible:=False;

  TreePanel:=TPanel.Create(Self);
  TreePanel.Parent:=Self;
  TreePanel.Align:=alClient;

  with Tree.Items do
  begin
    Clear;

    TreeNodeSeries:=Tree.Items.AddObject(nil,TabSeriesList.Caption,TabSeriesList);
    AddSeriesNodes;

    TreeNodeSeries.Expanded:=Chart.SeriesCount<11;

    tmpNode:=AddObject(nil,TabChart.Caption,SubPage);

    for t:=1 to SubPage.PageCount-1 do
    if SubPage.Pages[t].TabVisible then
    begin
      tmpNode2:=AddChildObject(tmpNode,SubPage.Pages[t].Caption,SubPage.Pages[t]);

      if SubPage.Pages[t]=TabAxis then
      begin
        AddChildObject(tmpNode2,TeeMsg_LeftAxis,Chart.Axes.Left);
        AddChildObject(tmpNode2,TeeMsg_RightAxis,Chart.Axes.Right);
        AddChildObject(tmpNode2,TeeMsg_TopAxis,Chart.Axes.Top);
        AddChildObject(tmpNode2,TeeMsg_BottomAxis,Chart.Axes.Bottom);
        AddChildObject(tmpNode2,TeeMsg_DepthAxis,Chart.Axes.Depth);
        AddChildObject(tmpNode2,TeeMsg_DepthTopAxis,Chart.Axes.DepthTop);

        for tt:=TeeInitialCustomAxis to Chart.Axes.Count-1 do
            AddChildObject(tmpNode2,
                TeeMsg_CustomAxesEditor+IntToStr(tt-TeeInitialCustomAxis),
                Chart.CustomAxes[tt-TeeInitialCustomAxis]);
      end
      else
      if SubPage.Pages[t]=TabTitle then
      begin
        AddChildObject(tmpNode2,TeeMsg_Title,Chart.Title);
        AddChildObject(tmpNode2,'SubTitle',Chart.SubTitle);
        AddChildObject(tmpNode2,TeeMsg_Foot,Chart.Foot);
        AddChildObject(tmpNode2,'SubFoot',Chart.SubFoot);
      end;
    end;

    tmpNode.Expanded:=True;

    for t:=2 to MainPage.PageCount-1 do
    if MainPage.Pages[t].TabVisible then
    begin
      tmpNode:=AddObject(nil,MainPage.Pages[t].Caption,MainPage.Pages[t]);

      if MainPage.Pages[t]=TabTools then
      begin
        TreeNodeTools:=tmpNode;
        for tt:=0 to Chart.Tools.Count-1 do
            AddChildObject(TreeNodeTools,Chart.Tools[tt].Description,Chart.Tools[tt]);
      end;
    end;
  end;

  Tree.Selected:=TreeNodeSeries;
  // TreeChange(Tree,Tree.Selected);

  Tree.SetFocus;
end;

procedure TChartEditForm.BroadCastShowEditor(Tab:TTabSheet);
var t : Integer;
begin
  if Assigned(TeeOnShowEditor) then
     for t:=0 to TeeOnShowEditor.Count-1 do
         TTeeOnCreateEditor(TeeOnShowEditor[t])(Self,Tab);
end;

procedure TChartEditForm.FormCreate(Sender: TObject);

  Function AdjustSize(const Value:String):Integer;
  Const PPI={$IFDEF LINUX}75{$ELSE}{$IFDEF CLX}92{$ELSE}96{$ENDIF}{$ENDIF};
  begin
    result:=StrToInt(Value)*Screen.PixelsPerInch div PPI; { 5.03 }
  end;

var tmpH : Integer;
begin
  Width:=AdjustSize(TeeMsg_DefaultEditorSize);

  tmpH:=AdjustSize(TeeMsg_DefaultEditorHeight);
  {$IFNDEF LINUX}
  Inc(tmpH,GetSystemMetrics(SM_CYSIZE)-18); // add big (XP) form caption size
  {$ENDIF}

  Height:=tmpH;

  Chart:=nil;
  Caption:='';
  TheActivePageIndex:=-1;
  EditorOptions:=eoAll;
  MainPage.ActivePage:=TabChart;
  SubPage.ActivePage:=TabSeriesList;
  TheHiddenTabs:=[{$IFDEF TEEOCX}cetOpenGL{$ENDIF}]; { 5.02 }

  RememberPosition:=TeeReadBoolOption(TeeMsg_RememberPosition,True);
  RememberSize:=TeeReadBoolOption(TeeMsg_RememberSize,True);
  Tree.Visible:=TeeReadBoolOption(TeeMsg_TreeMode,False);
end;

procedure TChartEditForm.AxisNotifyCustom(Sender: TObject);  // 6.01
begin
  if Assigned(TheFormSeries) then
     TheFormSeries.FillAxes;
end;

type TCustomFormAccess=class(TCustomForm);

procedure TChartEditForm.SubPageChange(Sender: TObject);
var tmpForm : TForm;
begin
  {$IFDEF D5}
  if HighLightTabs then SubPage.ActivePage.Highlighted:=True;
  {$ENDIF}

  if Tree.Visible and (Sender=SubPage) then
     SelectTreeNodeData(SubPage.ActivePage);

  if Assigned(Chart) then
  With SubPage.ActivePage do
  if ControlCount=0 then
  begin
    Case {$IFNDEF CLX}PageIndex{$ELSE}TabIndex{$ENDIF} of
      teeEditGeneralPage: tmpForm:=TFormTeeGeneral.CreateChart(Self,Chart);
      teeEditAxisPage   : begin
                            if not Assigned(TheAxis) then TheAxis:=Chart.LeftAxis;
                            tmpForm:=TFormTeeAxis.CreateAxis(Self,TheAxis);
                            TFormTeeAxis(tmpForm).NotifyCustom:=AxisNotifyCustom;  // 6.01
                          end;
      teeEditTitlePage  : begin
                            if not Assigned(TheTitle) then TheTitle:=Chart.Title;
                            tmpForm:=TFormTeeTitle.CreateTitle(Self,Chart,TheTitle);
                          end;
      teeEditLegendPage : tmpForm:=TFormTeeLegend.CreateLegend(Self,Chart.Legend);
      teeEditPanelPage  : tmpForm:=TFormTeePanel.CreatePanel(Self,Chart);
      teeEditPagingPage : tmpForm:=TFormTeePage.CreateChart(Self,Chart);
      teeEditWallsPage  : begin
                            if not Assigned(TheWall) then TheWall:=Chart.LeftWall;
                            tmpForm:=TFormTeeWall.CreateWall(Self,TheWall);
                          end;
    else
       tmpForm:=TFormTee3D.CreateChart(Self,Chart);
    end;

    {$IFNDEF CLR}
    with TCustomFormAccess(tmpForm) do
    begin
      {$IFNDEF CLX}
      {$IFDEF D7}
      ParentBackground:=True;
      {$ENDIF}
      {$ENDIF}

      ParentColor:=True;
    end;
    {$ENDIF}

    { show the form... }
    With tmpForm do
    begin
      BorderIcons:=[];
      BorderStyle:=TeeFormBorderStyle;
      Align:=alClient;

      Parent:=Self.SubPage.ActivePage;

      {$IFDEF CLX}
      TeeFixParentedForm(tmpForm);
      {$ENDIF}

      Show;
      Realign;  // 6.0 (fixes Axis tab align bug in VCL)
    end;

    // Translate the form
    TeeTranslateControl(tmpForm);
  end;

  if SubPage.ActivePage=Tab3D then
     TFormTee3D(Tab3D.Controls[0]).CheckControls;
end;

procedure TChartEditForm.BCloseClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TChartEditForm.BMoveUPClick(Sender: TObject);
begin
  LBSeries.MoveCurrentUp;
end;

procedure TChartEditForm.BMoveDownClick(Sender: TObject);
begin
  LBSeries.MoveCurrentDown;
end;

procedure TChartEditForm.BAddSeriesClick(Sender: TObject);
var tmpSeries : TChartSeries;
begin
  TabSeries.Parent:=MainPage;

  tmpSeries:=LBSeries.AddSeriesGallery;

  if Assigned(tmpSeries) and Assigned(tmpSeries.FunctionType) then
  begin
    TheSeries:=tmpSeries;
    MainPage.ActivePage:=TabSeries;
    SetTabSeries;
    With TheFormSeries do
    begin
      PageSeries.ActivePage:=TabDataSource;
      PageSeriesChange(Self);
      CBDataSourcestyleChange(Self);
    end;
  end;


  if LBSeries.CanFocus then // 7.0
     LBSeries.SetFocus;
end;

procedure TChartEditForm.InternalSetupFormSeries;
begin
  TabSeries.Parent:=MainPage;
  TheFormSeries.DestroySeriesForms;
  TheFormSeries.TheSeries:=LBSeries.SelectedSeries;
end;

procedure TChartEditForm.BDeleteSeriesClick(Sender: TObject);
begin
  LBSeries.DeleteSeries;
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.TheSeries:=nil;
    InternalSetupFormSeries;
  end;
end;

procedure TChartEditForm.BRenameSeriesClick(Sender: TObject);
begin
  if LBSeries.RenameSeries and Tree.Visible then
     TreeNodeCurrentSeries.Text:=LBSeries.Items[LBSeries.ItemIndex];

  if (Parent=nil) and LBSeries.CanFocus then ActiveControl:=LBSeries; { 5.01 }
end;

procedure TChartEditForm.BCloneSeriesClick(Sender: TObject);
begin
  LBSeries.CloneSeries;
end;

procedure TChartEditForm.SetTabSeries;
begin
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.TheSeries:=LBSeries.SelectedSeries;
  end
  else
  begin
    TheFormSeries:=TFormTeeSeries.Create(Self);
    With TheFormSeries do
    begin
      Self.LBSeries.OtherItems:=CBSeries.Items;
      TheListBox:=Self.LBSeries;
      BorderIcons:=[];
      BorderStyle:=TeeFormBorderStyle;
      Parent:=TabSeries;
      Align:=alClient;
      ShowTabDataSource:=ceDataSource in EditorOptions;
      ShowTabGeneral:=not (cetSeriesGeneral in TheHiddenTabs);
      ShowTabMarks:=not (cetSeriesMarks in TheHiddenTabs);
      IsDssGraph:=Self.IsDssGraph;
      TheSeries:=Self.LBSeries.SelectedSeries;
      Self.LBSeries.FillSeries(TheSeries);

      {$IFDEF CLX}
      TeeFixParentedForm(TheFormSeries);
      {$ENDIF}
      Show;
    end;

    TeeTranslateControl(TheFormSeries);
  end;

  TheFormSeries.SetCBSeries;
end;

procedure TChartEditForm.GridMouseDown(Sender: TObject;
                                Button: TMouseButton; Shift: TShiftState;
                                X, Y: Integer);
begin
  if (Button=mbRight) and (ssAlt in Shift) then
     if (Chart.SeriesCount>0) and Chart[0].HasZValues then
     with (Sender as TChartGrid) do
          Grid3DMode:=not Grid3DMode;
end;

procedure TChartEditForm.SelectTreeNodeData(AObject: TObject);
var t: Integer;
begin
  for t:=0 to Tree.Items.Count-1 do
      if Tree.Items[t].Data=AObject then
      begin
        if Tree.Selected<>Tree.Items[t] then
           Tree.Selected:=Tree.Items[t];
        exit;
      end;
end;

{$IFNDEF TEELITE}
type
  TFormTeeToolsAccess=class(TFormTeeTools);

procedure TChartEditForm.CreateToolsForm;
var tmp     : TFormTeeTools;
    tmpTool : Integer;
begin
  tmp:=TFormTeeTools.Create(Self);
  tmp.Align:=alClient;
  AddFormTo(tmp,TabTools,Chart);

  TFormTeeToolsAccess(tmp).OnAdded:=AddedTool;
  TFormTeeToolsAccess(tmp).OnDeleted:=DeletedTool;

  if Assigned(TheTool) then
  begin
    tmpTool:=tmp.LBTools.Items.IndexOfObject(TheTool);
    if tmpTool<>-1 then
    begin
      tmp.LBTools.ItemIndex:=tmpTool;
      tmp.LBToolsClick(Self);
    end;
    TheTool:=nil;
  end;
end;
{$ENDIF}

procedure TChartEditForm.MainPageChange(Sender: TObject);

  Procedure SetTabPrint;
  begin
    if not Assigned(FPreview) then
    begin
      Screen.Cursor:=crHourGlass;
      try
        FPreview:=TChartPreview.Create(Self);

        with FPreview do
        begin
          GBMargins.Visible:=False;
          PanelMargins.Visible:=False;
          BClose.Visible:=False;
          Align:=alClient;
        end;

        AddFormTo(FPreview,TabPrint,Chart);
      finally
        Screen.Cursor:=crDefault;
      end;
    end
    else FPreview.TeePreviewPanel1.Invalidate; // 5.03
  end;

  Procedure SetTabTools;
  begin
    {$IFNDEF TEELITE}
    if TabTools.ControlCount=0 then
       CreateToolsForm
    else  // Refresh the tool form, if any...
       TFormTeeTools(TabTools.Controls[0]).Reload;
    {$ENDIF}
  end;

  Procedure SetTabExport;
  var tmp : TTeeExportForm;
  begin
    if TabExport.ControlCount=0 then
    begin
      tmp:=TTeeExportForm.Create(Self);
      AddFormTo(tmp,TabExport,Chart);

      with tmp do
      begin
        Align:=alClient;
        BClose.Visible:=False;
      end;
    end
    else tmp:=TTeeExportForm(TabExport.Controls[0]);

    with tmp do
    begin
      CBFileSize.Checked:=False;

      if cetExportNative in TheHiddenTabs then
         tmp.TabNative.TabVisible:=False;

      EnableButtons;
    end;
  end;

  Procedure SetTabData;
  begin
    with ChartGrid1 do
    begin
      Chart:=Self.Chart;

      ShowColors:=(Chart.SeriesCount>0) and HasColors(Chart[0]);
      RecalcDimensions;

      SBGridCol.Down:=ShowColors;
      SBGridText.Down:=ShowLabels;
      SBGrid3D.Down:=Grid3DMode;
      SBGrid3D.Enabled:=(Chart.SeriesCount>0) and Chart[0].HasZValues;
      SBGridX.Down:=(Chart.SeriesCount>0) and HasNoMandatoryValues(Chart[0]);

      {$IFNDEF TEEOCX}
      if not Tree.Visible then
         SetFocus;
      {$ENDIF}

      OnMouseDown:=GridMouseDown;
    end;
  end;

begin
  {$IFDEF D5}
  if HighLightTabs then MainPage.ActivePage.HighLighted:=True;
  {$ENDIF}

  if Tree.Visible then
     SelectTreeNodeData(MainPage.ActivePage);

  if MainPage.ActivePage=TabSeries then SetTabSeries
  else
  if MainPage.ActivePage=TabData then SetTabData
  else
  if MainPage.ActivePage=TabTools then SetTabTools
  else
  if MainPage.ActivePage=TabExport then SetTabExport
  else
  if MainPage.ActivePage=TabPrint then SetTabPrint
  {$IFDEF CLX}
  // Workaround for CLX ListBox MultiSelect + ItemIndex=-1 bug
  else
  if MainPage.ActivePage=TabChart then
  begin
    if (not LBSeries.Focused) and (LBSeries.CanFocus) then
    begin
      LBSeries.SetFocus;
      LBSeriesRefreshButtons(LBSeries);
    end;
  end
  {$ENDIF}
  else BroadCastShowEditor(MainPage.ActivePage);
end;

{$IFNDEF CLX}
procedure TChartEditForm.WMHelp(var Message: TWMHelp);
var Control : TWinControl;
begin
  if biHelp in BorderIcons then
  with Message.HelpInfo{$IFNDEF CLR}^{$ENDIF} do
  begin
    if iContextType = HELPINFO_WINDOW then
    begin
      Control := FindControl(hItemHandle);
      while Assigned(Control) and (Control.HelpContext = 0) do
        Control := Control.Parent;
      if Assigned(Control) then
         Application.HelpContext(Control.HelpContext);
    end;
  end
  else inherited;
end;
{$ENDIF}

procedure TChartEditForm.SetChart(Value:TCustomChart);
begin
  TheChart:=Value;
  if Assigned(TheChart) then TheChart.FreeNotification(Self);
  LBSeries.Chart:=TheChart;
  MainPage.Enabled:=Assigned(TheChart);
  SubPage.Enabled:=Assigned(TheChart);

  {$IFNDEF LINUX}
  if Assigned(TheChart) and (RememberPosition or RememberSize) then
      with TRegistry.Create do
      try
        if OpenKeyReadOnly(TeeMsg_EditorKey) then
        begin
          if RememberPosition then
            if ValueExists('Left') then
            begin
              Self.Position:=poDesigned;
              Self.Left:=Math.Max(0,ReadInteger('Left'));
              Self.Top:=Math.Max(0,ReadInteger('Top'));
            end;

          if RememberSize then
          begin
            if ValueExists('Width') then
               Self.Width:=Math.Max(100,ReadInteger('Width'));

            if ValueExists('Height') then
               Self.Height:=Math.Max(100,ReadInteger('Height'));
          end;
        end;
      finally
        Free;
      end;
  {$ENDIF}
end;

procedure TChartEditForm.ReparentAxis;
begin
  if TabAxis.ControlCount>0 then
  with TFormTeeAxis(TabAxis.Controls[0]) do
       PageAxis.Parent:=TFormTeeAxis(TabAxis.Controls[0]);
end;

procedure TChartEditForm.ReparentTitle;
begin
  if TabTitle.ControlCount>0 then
  with TFormTeeTitle(TabTitle.Controls[0]) do
       PageControlTitle.Parent:=TFormTeeTitle(TabTitle.Controls[0]);
end;

procedure TChartEditForm.ReparentTools;
begin
  {$IFNDEF TEELITE}
  if TabTools.ControlCount>0 then
  with TFormTeeTools(TabTools.Controls[0]) do
       PanelToolEditor.Parent:=TFormTeeTools(TabTools.Controls[0]);
  {$ENDIF}
end;

procedure TChartEditForm.ResetParentTab(PageControl:TPageControl);
var t : Integer;
begin
  for t:=0 to PageControl.PageCount-1 do
      PageControl.Pages[t].Parent:=PageControl;

  ReparentAxis;
  ReparentTitle;
  ReparentTools;
  SubPage.Parent:=TabChart;
end;

procedure TChartEditForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Assigned(TheFormSeries) then
  begin
    TheFormSeries.FormCloseQuery(Sender,CanClose);
    if CanClose then Close;
  end;
end;

procedure TChartEditForm.TreeSelectSeries(Series: TChartSeries);
begin
 SubPage.Parent:=TabChart;
 TabSeriesList.Parent:=SubPage;
 TabSeriesList.TabVisible:=True;
 TabSeries.Parent:=TreePanel;
 TabSeries.Align:=alClient;
 LBSeries.SelectedSeries:=Series;
 SetTabSeries;
 TabSeries.Show;
end;

Function TChartEditForm.TreeNodeCurrentSeries:TTreeNode;
var t : Integer;
begin
  result:=nil;
  if Assigned(TreeNodeSeries) then
  for t:=0 to TreeNodeSeries.Count-1 do
  if TreeNodeSeries.Item[t].Data=LBSeries.SelectedSeries then
  begin
    result:=TreeNodeSeries.Item[t];
    break;
  end;
end;

procedure TChartEditForm.LBSeriesEditSeries(Sender: TChartListBox;
  Index: Integer);
begin
  if LBSeries.ItemIndex<>-1 then
     if Tree.Visible and (TreeNodeCurrentSeries<>nil) then
        TreeNodeCurrentSeries.Selected:=True
     else
     begin
       MainPage.ActivePage:=TabSeries;
       {$IFNDEF CLX}
       SetTabSeries;
       {$ENDIF}
     end;
end;

procedure TChartEditForm.LBSeriesOtherItemsChange(Sender: TObject);
begin
  if Assigned(TheFormSeries) then
  begin
    if not Assigned(TabSeries.Parent) then
       TabSeries.Parent:=MainPage;
    TheFormSeries.CBSeries.ItemIndex:=LBSeries.ItemIndex;
  end;
end;

procedure TChartEditForm.LBSeriesRefreshButtons(Sender: TObject);
var tmp          : Boolean;
    tmpInherited : Boolean;
    tmpSeries    : TChartSeries;
begin
  tmp:=(Chart.SeriesCount>0) and LBSeries.CanFocus and (LBSeries.ItemIndex<>-1);
  if tmp then tmpSeries:=Chart.Series[LBSeries.ItemIndex]
         else tmpSeries:=nil;

  tmpInherited:=tmp and (csAncestor in tmpSeries.ComponentState);

  BAddSeries.Enabled:=(ceAdd in EditorOptions);

  BDeleteSeries.Enabled:= tmp and
                          (not tmpInherited) and
                          (ceDelete in EditorOptions)
                          and
                          (not (tssIsTemplate in tmpSeries.Style)) and
                          (not (tssDenyDelete in tmpSeries.Style)) ;

  BRenameSeries.Enabled:=tmp and (LBSeries.SelCount<2) and (ceTitle in EditorOptions);

  BChangeTypeSeries.Enabled:= tmp and
                              (not tmpInherited) and
                              (ceChange in EditorOptions)
                              and
                              (not (tssDenyChangeType in tmpSeries.Style));

  if (not BChangeTypeSeries.Enabled) and LBSeries.ShowSeriesIcon and
     LBSeries.EnableChangeType then
       LBSeries.EnableChangeType:=False;  // 7.0 #1217

  BCloneSeries.Enabled:= tmp and
                         (LBSeries.SelCount<2) and
                         (ceClone in EditorOptions)
                         and
                         (not (tssIsTemplate in tmpSeries.Style)) and
                         (not (tssDenyClone in tmpSeries.Style));

  if tmp and (LBSeries.SelCount<=1) then
  begin
    BMoveDown.Enabled:=LBSeries.ItemIndex<LBSeries.Items.Count-1;
    BMoveUp.Enabled:=LBSeries.ItemIndex>0;
  end
  else
  begin
    BMoveDown.Enabled:=False;
    BMoveUp.Enabled:=False;
  end;

  if Tree.Visible and Assigned(TreeNodeSeries) then
     if LBSeries.CanFocus and (TreeNodeSeries.Count<>LBSeries.Items.Count) then
        AddSeriesNodes;
end;

procedure TChartEditForm.BChangeTypeSeriesClick(Sender: TObject);
begin
  LBSeries.ChangeTypeSeries(Self);
  if Assigned(TheFormSeries) then InternalSetupFormSeries;
end;

procedure TChartEditForm.LabelWWWClick(Sender: TObject);
begin
  GotoURL(Handle,LabelWWW.Caption);
end;

procedure TChartEditForm.ButtonHelpClick(Sender: TObject);
begin
  {$IFNDEF CLX}
  Application.HelpCommand(HELP_CONTEXT, HelpContext);
  {$ENDIF}
end;

procedure TChartEditForm.MainPageChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if Assigned(TheFormSeries) then
     TheFormSeries.PageSeriesChanging(Self,AllowChange)
  else
     AllowChange:=True;

  {$IFDEF D5}
  if AllowChange and HighLightTabs then MainPage.ActivePage.HighLighted:=False;
  {$ENDIF}
end;

procedure TChartEditForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(TheChart) and (AComponent=TheChart) then
     TheChart:=nil;
end;

procedure TChartEditForm.SubPageChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  {$IFDEF D5}
  if HighLightTabs then SubPage.ActivePage.Highlighted:=False;
  {$ENDIF}
end;

procedure TChartEditForm.SBGridTextClick(Sender: TObject);
begin
  ChartGrid1.ShowLabels:=SBGridText.Down;
end;

procedure TChartEditForm.SBGridColClick(Sender: TObject);
begin
  ChartGrid1.ShowColors:=SBGridCol.Down;
end;

procedure TChartEditForm.SBGrid3DClick(Sender: TObject);
begin
  ChartGrid1.Grid3DMode:=SBGrid3D.Down;
end;

procedure TChartEditForm.SBGridXClick(Sender: TObject);
begin
  if SBGridX.Down then
     ChartGrid1.ShowXValues:=cgsYes
  else
     ChartGrid1.ShowXValues:=cgsNo
end;

procedure TChartEditForm.Deleterow1Click(Sender: TObject);
begin
  ChartGrid1.Delete
end;

Function TChartEditForm.CurrentGroup:TSeriesGroup;
begin
  if (DeltaGroup=1) and (Groups.ItemIndex=0) then
     result:=nil
  else
     result:=Chart.SeriesList.Groups[Groups.ItemIndex-DeltaGroup];
end;

procedure TChartEditForm.GroupsClick(Sender: TObject);
begin
  LBSeries.SeriesGroup:=CurrentGroup;
  EnableGroupButtons;
end;

procedure TChartEditForm.EnableGroupButtons;
begin
  BDeleteGroup.Enabled:=Groups.ItemIndex>=DeltaGroup;
  BRenameGroup.Enabled:=BDeleteGroup.Enabled;
end;

procedure TChartEditForm.GroupsClickCheck(Sender: TObject);
begin
  if (DeltaGroup=1) and (Groups.ItemIndex=0) then
  begin
    Chart.SeriesList.AllActive:=Groups.Checked[Groups.ItemIndex];
    FillGroups;
  end
  else
  begin
    case Groups.State[Groups.ItemIndex] of
      cbChecked: CurrentGroup.Active:=gaYes;
      cbUnChecked: CurrentGroup.Active:=gaNo;
      cbGrayed: CurrentGroup.Active:=gaSome;
    end;

    if DeltaGroup=1 then
       Groups.Checked[0]:=Chart.SeriesList.AllActive;
  end;

  EnableGroupButtons;
end;

procedure TChartEditForm.LBSeriesChangeActive(Sender: TChartListBox;
  Series: TCustomChartSeries);
begin
  FillGroups;
end;

procedure TChartEditForm.GroupsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var tmp : Integer;
begin
  tmp:=Groups.ItemAtPos(TeePoint(X,Y),True);
  Accept:=(tmp<>-1) and (Source is TChartListBox);
  if Accept and (tmp>=DeltaGroup) then
     Accept:=Accept and
       (Chart.SeriesList.Groups[tmp-DeltaGroup].Series.IndexOf(TChartListBox(Source).SelectedSeries)=-1);
end;

procedure TChartEditForm.GroupsDragDrop(Sender, Source: TObject; X,
  Y: Integer);

   Procedure RefreshGroups(Index:Integer);
   begin
     FillGroups;
     Groups.ItemIndex:=Index;
     GroupsClick(Groups);
   end;

var tmp : Integer;
    tmpSeries : TChartSeries;
begin
  tmp:=Groups.ItemAtPos(TeePoint(X,Y),True);

  if (tmp<>-1) and (Source is TChartListBox) then
  begin
    tmpSeries:=TChartListBox(Source).SelectedSeries;

    if (tmp=0) and (DeltaGroup=1) then
    begin
      if Groups.ItemIndex>=DeltaGroup then
         CurrentGroup.Series.Remove(tmpSeries);
      RefreshGroups(tmp);
    end
    else
    with Chart.SeriesList.Groups[tmp-DeltaGroup].Series do
    begin
      if IndexOf(tmpSeries)=-1 then
      begin
        Add(tmpSeries);
        if Groups.ItemIndex>=DeltaGroup then
           CurrentGroup.Series.Remove(tmpSeries);
        RefreshGroups(tmp);
      end;
    end;
  end;
end;

procedure TChartEditForm.BAddGroupClick(Sender: TObject);
var tmpSt : String;
begin
  tmpSt:='';
  if InputQuery(TeeMsg_AddNewGroup,TeeMsg_GroupName,tmpSt) then
  begin
    Chart.SeriesList.AddGroup(tmpSt);
    FillGroups;
    Groups.ItemIndex:=Groups.Items.Count-1;
    GroupsClick(Self);
  end;
end;

procedure TChartEditForm.BRenameGroupClick(Sender: TObject);
var tmpSt : String;
begin
  tmpSt:=Groups.Items[Groups.ItemIndex];
  if InputQuery(TeeMsg_ChangeGroupName,TeeMsg_GroupName,tmpSt) then
  begin
    CurrentGroup.Name:=tmpSt;
    FillGroups;
  end;
end;

procedure TChartEditForm.BDeleteGroupClick(Sender: TObject);
begin
  if TeeYesNoDelete(Groups.Items[Groups.ItemIndex],Self) then
  begin
    CurrentGroup.Free;
    FillGroups;
  end;
end;

procedure TChartEditForm.TreeChange(Sender: TObject; Node: TTreeNode);

  procedure SetMainTab(TabSheet: TTabSheet; SynchroNode:Boolean=True);
  begin
    MainPage.ActivePage.Parent:=MainPage;
    MainPage.ActivePage:=TabSheet;

    if TabSheet=TabTools then ReparentTools;

    if SynchroNode then
       MainPageChange(MainPage);
  end;

  procedure SetSubTab(TabSheet: TTabSheet; SynchroNode:Boolean=True);
  begin
    SubPage.Parent:=TabChart;
    SubPage.ActivePage.Parent:=SubPage;
    SubPage.ActivePage:=TabSheet;

    if TabSheet=TabAxis then ReparentAxis
    else
    if TabSheet=TabTitle then ReparentTitle;

    if SynchroNode then SubPageChange(SubPage)
                   else SubPageChange(Self);
  end;

begin
  while TreePanel.ControlCount>0 do TreePanel.Controls[0].Parent:=nil;

  if Assigned(Node.Data) then
     if TObject(Node.Data) is TTabSheet then
     with TTabSheet(Node.Data) do
     begin
       if PageControl=MainPage then SetMainTab(TTabSheet(Node.Data))
       else
       if PageControl=SubPage then SetSubTab(TTabSheet(Node.Data));

       Parent:=TreePanel;
       Align:=alClient;

       if TTabSheet(Node.Data)=TabSeriesList then
          if LBSeries.CanFocus then
          begin
            LBSeries.SetFocus;
            LBSeries.Repaint;
          end;
     end
     else
     if TObject(Node.Data) is TChartSeries then
        TreeSelectSeries(TChartSeries(Node.Data))
     else
     if TObject(Node.Data) is TPageControl then
     begin
       ResetParentTab(SubPage);
       SubPage.Parent:=TreePanel;
       SubPage.Align:=alClient;
       TabSeriesList.TabVisible:=False;
       SubPageChange(Self);
     end
     else

     {$IFNDEF TEELITE}
     if TObject(Node.Data) is TTeeCustomTool then
     begin
       SetMainTab(TabTools,False);

       if TabTools.ControlCount=0 then  // 7.0
          CreateToolsForm;

       with TFormTeeTools(TabTools.Controls[0]) do
       begin
         with LBTools do
         begin
           if Items.Count=0 then FormShow(Self);
           ItemIndex:=Items.IndexOfObject(TTeeCustomTool(Node.Data));
         end;

         LBToolsClick(LBTools);
         PanelToolEditor.Parent:=TreePanel;
       end;
     end
     else
     {$ENDIF}

     if TObject(Node.Data) is TChartAxis then
     begin
       SetSubTab(TabAxis,False);

       with TFormTeeAxis(TabAxis.Controls[0]) do
       begin
         TheAxis:=TChartAxis(Node.Data);
         LBAxes.ItemIndex:=Node.Index;
         PageAxisChange(PageAxis);
         PageAxis.Parent:=TreePanel;
       end;
     end
     else
     if TObject(Node.Data) is TChartTitle then
     begin
       SetSubTab(TabTitle,False);

       with TFormTeeTitle(TabTitle.Controls[0]) do
       begin
         TheTitle:=TChartTitle(Node.Data);
         CBTitles.ItemIndex:=Node.Index;
         PageControlTitle.Parent:=TFormTeeTitle(TabTitle.Controls[0]);
         CBTitlesChange(CBTitles);
         PageControlTitle.Parent:=TreePanel;
       end;
     end;
end;

procedure TChartEditForm.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit:=TObject(Node) is TChartSeries;
end;

{$IFNDEF TEELITE}
procedure TChartEditForm.AddedTool(Sender:TObject);
begin
  if Assigned(TreeNodeTools) then
     Tree.Items.AddChildObject(TreeNodeTools,TTeeCustomTool(Sender).Description,Sender);
end;

procedure TChartEditForm.DeletedTool(Sender:TObject);
var t: Integer;
begin
  if Assigned(TreeNodeTools) then
  with TreeNodeTools do
  for t:=0 to Count-1 do
      if Item[t].Data=Sender then
      begin
        Item[t].Free;
        break;
      end;
end;
{$ENDIF}

procedure TChartEditForm.FormDestroy(Sender: TObject);
begin
  // Tree mode fix at destroy
  if Assigned(Tree) and Tree.Visible then
  begin
    ResetParentTab(MainPage);
    ResetParentTab(SubPage);
    Width:=OldWidth;
  end;

  {$IFNDEF LINUX}
  if Assigned(Chart) and (RememberPosition or RememberSize) then
    with TRegistry.Create do
    try
      if OpenKey(TeeMsg_EditorKey,True) then
      begin
        if RememberPosition then
        begin
          WriteInteger('Left',Self.Left);
          WriteInteger('Top',Self.Top);
        end;

        if RememberSize then
        begin
          if Self.Width<>StrToInt(TeeMsg_DefaultEditorSize) then
             WriteInteger('Width',Self.Width);

          if Self.Height<>StrToInt(TeeMsg_DefaultEditorHeight) then
             WriteInteger('Height',Self.Height);
        end;
      end;
    finally
      Free;
    end;
  {$ENDIF}
end;

procedure TChartEditForm.FormResize(Sender: TObject);
begin
  if Tree.Visible then
     OldWidth:=Width-Tree.Width-TreeSplitter.Width;
end;

procedure TChartEditForm.Insertrow1Click(Sender: TObject);
begin
  ChartGrid1.Insert;
end;

procedure TChartEditForm.CBNamesClick(Sender: TObject);
begin
  LBSeries.ShowSeriesNames:=CBNames.Checked;
  if CBNames.Checked then
     BRenameSeries.Caption:='&Name...'  // do not localize
  else
     BRenameSeries.Caption:='&Title...'; // do not localize

  TeeTranslateControl(BRenameSeries);
end;

type
  TChartGridAccess=class(TCustomChartGrid);

procedure TChartEditForm.PopupDataPopup(Sender: TObject);
var tmpColor : TColor;
begin
  EditColor1.Visible:=Assigned(TChartGridAccess(ChartGrid1).GetSeriesColor(tmpColor));
  DefaultColor1.Visible:=EditColor1.Visible and (tmpColor<>clTeeColor);
  Makenullpoint1.Visible:=EditColor1.Visible and (tmpColor<>clNone);
  N1.Visible:=EditColor1.Visible;
end;

procedure TChartEditForm.EditColor1Click(Sender: TObject);
begin
  ChartGrid1.ChangeColor;
end;

procedure TChartEditForm.DefaultColor1Click(Sender: TObject);
begin
  ChartGrid1.ChangeColor(clTeeColor);
end;

procedure TChartEditForm.Makenullpoint1Click(Sender: TObject);
begin
  ChartGrid1.ChangeColor(clNone);
end;

procedure TChartEditForm.extfont1Click(Sender: TObject);
begin
  EditTeeFont(Self,ChartGrid1.Font);
end;

initialization
  TeeOnShowEditor:=TList.Create;
  RegisterClass(TChartEditForm);
finalization
  TeeOnShowEditor.Free;
end.

