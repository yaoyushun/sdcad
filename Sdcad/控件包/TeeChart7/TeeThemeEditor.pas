{********************************************}
{  TeeChart Pro Charting Library             }
{  Themes Editor Dialog                      }
{  Copyright (c) 2003-2004 by David Berneda  }
{  All Rights Reserved                       }
{********************************************}
unit TeeThemeEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages, SysUtils,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeEngine, Chart, TeeThemes, TeeTools, TeCanvas, TeeDraw3D;

type
  TChartThemeSelector = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PreviewChart: TChart;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    LBThemes: TListBox;
    Panel2: TPanel;
    Panel3: TPanel;
    BOK: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    ChartTool1: TRotateTool;
    Panel4: TPanel;
    Label1: TLabel;
    CBPalette: TComboFlat;
    CBScale: TCheckBox;
    ScaledChart: TDraw3D;
    procedure LBThemesClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Panel4Resize(Sender: TObject);
    procedure CBPaletteChange(Sender: TObject);
    procedure CBScaleClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ScaledChartAfterDraw(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure CheckScale;
    procedure InitPreviewChart;

    {$IFNDEF CLX}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}
  public
    { Public declarations }
    Chart : TCustomChart;
    Function SelectedTheme:TChartThemeClass;
  end;

// Shows the Chart Theme editor. Returns the selected Theme class or nil.
Function ChartThemeSelector(AChart:TCustomChart):TChartThemeClass;

// Adds all available registered Chart Themes to "Items"
Procedure AddChartThemes(Items:TStrings);

implementation

{$R *.dfm}

uses {$IFNDEF CLR}
     Math,
     {$ENDIF}
     TeePenDlg, TeeEditCha, TeeConst, TeeProCo;

Procedure AddChartThemes(Items:TStrings);
var t : Integer;
    tmp : TChartTheme;
begin
  for t:=0 to ChartThemes.Count-1 do
  begin
    tmp:=ChartThemes[t].Create(nil);
    try
      Items.AddObject(tmp.Description,TObject(ChartThemes[t]));
    finally
      tmp.Free;
    end;
  end;
end;

Function ChartThemeSelector(AChart:TCustomChart):TChartThemeClass;
begin
  with TChartThemeSelector.Create(nil) do
  try
    Chart:=AChart;
    if ShowModal=mrOk then
       result:=SelectedTheme
    else
       result:=nil;
  finally
    Free;
  end;
end;

procedure TChartThemeSelector.LBThemesClick(Sender: TObject);
begin
  if LBThemes.ItemIndex>0 then
  begin
    ApplyChartTheme(SelectedTheme,PreviewChart,CBPalette.ItemIndex-1);
    BOK.Enabled:=True;
  end
  else
  begin
    InitPreviewChart;
    BOK.Enabled:=False;
  end;

  if CBScale.Checked then ScaledChart.Invalidate;
end;

Function TChartThemeSelector.SelectedTheme:TChartThemeClass;
begin
  if LBThemes.ItemIndex<=0 then
     result:=nil
  else
     result:=TChartThemeClass(LBThemes.Items.Objects[LBThemes.ItemIndex]);
end;

type
  TSeriesAccess=class(TChartSeries);

procedure TChartThemeSelector.InitPreviewChart;
var t : Integer;
    Old : Boolean;
begin
  PreviewChart.FreeAllSeries;

  if Assigned(Chart) then
  begin
    PreviewChart.Assign(Chart);

    for t:=0 to Chart.SeriesCount-1 do
    begin
      Old:=TSeriesAccess(Chart[t]).ManualData;
      TSeriesAccess(Chart[t]).ManualData:=True;
      try
        CloneChartSeries(Chart[t],PreviewChart,PreviewChart);
      finally
        TSeriesAccess(Chart[t]).ManualData:=Old;
      end;
    end;
    
    CheckScale;

    CheckBox1.Checked:=Chart.View3D;
  end;
end;

procedure TChartThemeSelector.BOKClick(Sender: TObject);
begin
  Chart.View3D:=CheckBox1.Checked;
  if SelectedTheme<>nil then
     ApplyChartTheme(SelectedTheme,Chart,CBPalette.ItemIndex-1)
  else
     ColorPalettes.ApplyPalette(Chart,CBPalette.ItemIndex-1);

  BOK.Enabled:=False;
end;

procedure TChartThemeSelector.FormShow(Sender: TObject);
var t : Integer;
begin
  // Fill listbox with registered Themes...
  LBThemes.Clear;
  LBThemes.Items.Add(TeeMsg_Current);

  AddChartThemes(LBThemes.Items);
  LBThemes.ItemIndex:=0;

  // Fill Color Palette combo...
  CBPalette.Clear;
  CBPalette.Items.Add(TeeMsg_Default);
  for t:=0 to ColorPalettes.Count-1 do
      CBPalette.Items.Add(ColorPalettes[t]);

  CBPalette.ItemIndex:=0; // select always the "default" palette.

  InitPreviewChart;

  BOk.Enabled:=False;

  TeeTranslateControl(Self);
end;

procedure TChartThemeSelector.CheckBox1Click(Sender: TObject);
begin
  PreviewChart.View3D:=CheckBox1.Checked;
  if CBScale.Checked then ScaledChart.Invalidate;
  BOk.Enabled:=True;
end;

Procedure TeeThemeShowEditor(Editor:TChartEditForm; Tab:TTabSheet);
var tmpForm : TChartThemeSelector;
    tmpActive : TTabSheet;
begin
  tmpActive:=Editor.MainPage.ActivePage;

  if not Assigned(Tab) then
  begin
    Tab:=TTabSheet.Create(Editor);
    Tab.Caption:=TeeMsg_Themes;
    Tab.PageControl:=Editor.MainPage;
  end
  else
  if (Tab.ControlCount=0) and (Tab.Caption=TeeMsg_Themes) then
  begin
    tmpForm:=TChartThemeSelector.Create(Editor);

    with tmpForm do
    begin
      Chart:=Editor.Chart;
      Button2.Visible:=False;
      BOK.Left:=Button2.Left;
      BOK.ModalResult:=mrNone;
      BOK.Caption:=TeeMsg_Apply;
      Align:=alClient;
      PageControl2.Width:=100;
    end;

    AddFormTo(tmpForm,Tab);

    {$IFNDEF CLR}
    tmpForm.RequestAlign;
    {$ENDIF}
  end;

  Editor.MainPage.ActivePage:=tmpActive;
end;

procedure TChartThemeSelector.Panel4Resize(Sender: TObject);
begin
  CBPalette.Width:=Panel4.Width-12;
end;

procedure TChartThemeSelector.CBPaletteChange(Sender: TObject);
begin
  if CBPalette.ItemIndex=0 then
     LBThemesClick(Self)
  else
     ColorPalettes.ApplyPalette(PreviewChart,CBPalette.ItemIndex-1);

  if CBScale.Checked then ScaledChart.Invalidate;
  BOK.Enabled:=True;
end;

procedure TChartThemeSelector.CBScaleClick(Sender: TObject);
begin
  CheckScale;
end;

procedure TChartThemeSelector.CheckScale;
begin
  if CBScale.Checked then
  begin
    PreviewChart.Align:=alNone;
    PreviewChart.Width:=Chart.Width;
    PreviewChart.Height:=Chart.Height;
    PreviewChart.Hide;
    ScaledChart.Show;
  end
  else
  begin
    PreviewChart.Align:=alClient;
    PreviewChart.Show;
    ScaledChart.Hide;
  end;
end;

procedure TChartThemeSelector.FormActivate(Sender: TObject);
begin
//  InitPreviewChart;
end;

procedure TChartThemeSelector.ScaledChartAfterDraw(Sender: TObject);
var tmp : TBitmap;
begin
  if CBScale.Checked then
  begin
    if not PreviewChart.Canvas.ReDrawBitmap then PreviewChart.Draw;

    tmp:=TTeeCanvas3D(PreviewChart.Canvas).Bitmap;
    if Assigned(tmp) then
       SmoothStretch(tmp,TTeeCanvas3D(ScaledChart.Canvas).Bitmap);
  end;
end;

type
  TButtonAccess=class(TButton);

procedure TChartThemeSelector.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if BOk.Enabled then
  Case MessageDlg(TeeMsg_SureToApply,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
    mrYes: begin
             TButtonAccess(BOk).Click;
             CanClose:=not BOk.Enabled;
           end;
    mrNo: begin
            BOk.Enabled:=False;
            CanClose:=True;
          end;
    mrCancel: CanClose:=False;
  end;
end;

{$IFNDEF CLX}
procedure TChartThemeSelector.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(Parent) then Parent.UpdateControlState;
end;
{$ENDIF}

procedure InstallHook;
{$IFDEF CLR}
var p: TTeeOnCreateEditor;
{$ENDIF}
begin
  {$IFDEF CLR}
  p:=TeeThemeShowEditor;
  TeeOnShowEditor.Add(@p);
  {$ELSE}
  TeeOnShowEditor.Add(@TeeThemeShowEditor);
  {$ENDIF}
end;

procedure RemoveHook;
{$IFDEF CLR}
var p: TTeeOnCreateEditor;
{$ENDIF}
begin
  {$IFDEF CLR}
  p:=TeeThemeShowEditor;
  TeeOnShowEditor.Remove(@p);
  {$ELSE}
  TeeOnShowEditor.Remove(@TeeThemeShowEditor);
  {$ENDIF}
end;

initialization
  InstallHook;
  TeeThemeSelectorHook:=ChartThemeSelector;
finalization
  TeeThemeSelectorHook:=nil;
  RemoveHook;
end.
