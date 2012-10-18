{*********************************************}
{   TeeChart Gallery Panel                    }
{   Copyright (c) 1996-2004 by David Berneda  }
{*********************************************}
unit TeeGalleryPanel;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     Messages,
     {$ENDIF}
     {$IFDEF CLX}
     Qt, QControls, QExtCtrls, QForms, QGraphics,
     {$ELSE}
     Controls, ExtCtrls, Forms, Graphics,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF USETHEMES}
     Themes, UxTheme,
     {$ENDIF}
     Classes, Chart, TeeProcs, TeEngine;

Const TeeGalleryNumRows=3;
      TeeGalleryNumCols=4;
      TeeCursorDisabled=crNoDrop;

var   clTeeGallery:TColor=clWhite;
      TeeGalleryCheckMaximize:Boolean=True; { 5.02 }

type
  TGalleryChart=class {$IFDEF CLR}sealed{$ENDIF} (TCustomChart)
  private
    FSmooth         : Boolean;
    ICreatingBitmap : Boolean;

    Procedure AfterDraw(Sender:TObject);
    Function ArrowOrigin:TPoint;

    {$IFNDEF CLX}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    {$ENDIF}

    procedure DrawSmoothChart;
    procedure DrawSubGalleryArrow;
    procedure SetSmooth(Value:Boolean);
  protected
    {$IFDEF CLX}
    procedure MouseEnter(AControl:TControl); override;
    procedure MouseLeave(AControl:TControl); override;
    {$ENDIF}
  public
    Constructor Create(AOwner:TComponent); override;

    Procedure CheckShowLabels;
    Procedure DrawFrame3D(Erase:Boolean);
    Procedure Focus(Is3D:Boolean);
    Procedure SetMargins;
    Procedure UnFocus(Is3D:Boolean);

    property Smooth:Boolean read FSmooth write SetSmooth default False;
  end;

  TChartList=class {$IFDEF CLR}sealed{$ENDIF} (TList)
  private
    Function GetChart(Index:Integer):TGalleryChart;
  public
    Procedure Clear; override;
    property Items[Index:Integer]:TGalleryChart read GetChart; default;
  end;

  TChartGalleryPanel=class(TCustomPanelNoCaption)
  private
    FColWidth        : Integer;
    FDisplaySub      : Boolean;
    FFocusRotation   : Boolean;
    FNumRows         : Integer;
    FNumCols         : Integer;
    FRowHeight       : Integer;
    FSmooth          : Boolean;
    FView3D          : Boolean;
    FOnChangeChart   : TNotifyEvent;
    FOnSelectedChart : TNotifyEvent;
    FOnSubSelected   : TNotifyEvent;

    tmpSub            : TForm;
    ISubGallery       : Boolean;
    ISelectedChart    : TGalleryChart;
    FOldSmooth        : Boolean;
    
    Procedure ChartEvent(Sender: TObject);
    procedure ChartKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure SetNumCols(Value:Integer);
    Procedure SetNumRows(Value:Integer);
    procedure SetSmooth(Value:Boolean);
    Procedure SetView3D(Value:Boolean);
    procedure ShowSubGallery;
    procedure SubKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SubPaintBox(Sender:TObject);
    procedure SubPanelClick(Sender:TObject);
    procedure SubSelected(Sender: TObject);
    Function ValidSeries(Const ASeriesType:TTeeSeriesType; Const APage:String):Boolean;
    {$IFNDEF CLX}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    {$ENDIF}
  protected
  {$IFDEF CLR}
  public
  {$ENDIF}
    tmpG      : TChartGalleryPanel;
    tmpSeries : TChartSeries;
    tmpType   : TTeeSeriesType; { 5.01 }

  {$IFDEF CLR}
  protected
  {$ENDIF}
    Procedure CalcChartWidthHeight;
    procedure ChartOnDblClick(Sender: TObject);
    Function CreateSubChart(Const ATitle:String):TCustomAxisPanel;
    Procedure CreateSubGallery(AGallery:TChartGalleryPanel; AClass:TChartSeriesClass);
    Procedure GetChartXY(AChart:TGalleryChart; Var x,y:Integer);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Resize; override;
    Procedure ResizeChart(AChart:TGalleryChart; TopOffset:Integer=0);

  {$IFDEF CLR}
  public
  {$ENDIF}
    Procedure AddSubCharts(AGallery:TChartGalleryPanel);
    procedure FindSelectedChart;
    Procedure ShowSelectedChart;
  public
    Charts           : TChartList;
    CheckSeries      : Boolean;
    FunctionsVisible : Boolean;
    SelectedSeries   : TChartSeries;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure SelectChart(Chart: TGalleryChart); virtual;
    Function CreateChart(Const AType:TTeeSeriesType):TCustomAxisPanel;
    Procedure CreateChartList(ASeriesList:Array of TChartSeriesClass);  // BCB does not allow "const"
    Procedure CreateGalleryPage(Const PageName:String);
    property ColWidth:Integer read FColWidth;

    class Function DefaultMode:Integer;  // 6.02
    class Function DefaultSmooth:Boolean;  // 6.02

    Function GetSeriesClass( Var tmpClass:TChartSeriesClass;
                             Var tmpFunctionClass:TTeeFunctionClass;
                             Var SubIndex:Integer):Boolean;
    Procedure ResizeCharts;

    class Procedure SaveMode(Value:Integer);  // 6.02
    class Procedure SaveSmooth(Value:Boolean);  // 6.02

    procedure UseTheme(Theme: TChartThemeClass); // 7.0

    property RowHeight:Integer read FRowHeight;
    property SelectedChart:TGalleryChart read ISelectedChart write SelectChart;
  published
    property DisplaySub:Boolean read FDisplaySub write FDisplaySub default True;
    property FocusRotation:Boolean read FFocusRotation write FFocusRotation default True;
    property NumRows:Integer read FNumRows write SetNumRows default TeeGalleryNumRows;
    property NumCols:Integer read FNumCols write SetNumCols default TeeGalleryNumCols;
    property Smooth:Boolean read FSmooth write SetSmooth default False;
    property View3D:Boolean read FView3D write SetView3D default True;

    { events }
    property OnSelectedChart:TNotifyEvent read FOnSelectedChart write FOnSelectedChart;
    property OnChangeChart:TNotifyEvent read FOnChangeChart write FOnChangeChart;
    property OnSubSelected:TNotifyEvent read FOnSubSelected write FOnSubSelected;

    { TPanel properties }
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Color;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property DragMode;
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
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFNDEF CLX}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnCanResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

implementation

Uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     Math, SysUtils,
     TeeConst, TeCanvas, TeePenDlg, Series;

Const clTeeSelected = clSilver; //$0080FFFF;   { <-- color use to select charts }

{ TChartList }
Procedure TChartList.Clear;
var t : Integer;
begin
  for t:=0 to Count-1 do Items[t].Free;
  inherited;
end;

Function TChartList.GetChart(Index:Integer):TGalleryChart;
begin
  result:=TGalleryChart(List{$IFNDEF CLR}^{$ENDIF}[Index]);
end;

{ TGalleryChart }
Constructor TGalleryChart.Create(AOwner:TComponent);
begin
  inherited;

  Legend.Hide;
  LeftAxis.Labels:=False;
  BottomAxis.Labels:=False;
  Title.Font.Color:=clNavy;

  Zoom.Animated:=True;

  With View3DOptions do
  begin
    Orthogonal:=False;
    Zoom       :=90;
    Perspective:=55;

    if TChartGalleryPanel(AOwner).FocusRotation then
    begin
      Rotation   :=335;
      Elevation  :=350;
    end;
  end;

  Chart3DPercent:=100;
  ClipPoints:=False;

  Frame.Hide;
  BevelWidth:=2;
  BevelOuter:=bvNone;

  With LeftWall do
  begin
    Color:=clWhite;
    Size:=4;
    Pen.Color:=clDkGray;
  end;

  With BottomWall do
  begin
    Color:=clWhite;
    Size:=4;
    Pen.Color:=clDkGray;
  end;

  OnAfterDraw:=AfterDraw;
end;

Procedure TGalleryChart.SetMargins;
Var tmp : Integer;
begin
  if View3D then tmp:=4 else tmp:=5;
  MarginTop    :=tmp;
  MarginBottom :=tmp;
  MarginLeft   :=tmp;
  MarginRight  :=tmp;
end;

Procedure TGalleryChart.DrawFrame3D(Erase:Boolean);
var R : TRect;
begin
  if Cursor<>TeeCursorDisabled then
  begin
    R:=ClientRect;
    if Erase then Frame3D(DelphiCanvas,R,Color,Color{clBtnFace,clBtnFace},1)
             else Frame3D(DelphiCanvas,R,clWhite,clDkGray,1);
  end;
end;

type TSeriesAccess=class(TChartSeries);

Procedure TGalleryChart.Focus(Is3D:Boolean);
begin
  With Gradient do
  begin
    Visible:=True;
    Direction:=gdFromTopLeft;
    StartColor:=clTeeSelected;
    EndColor:=clTeeGallery;
  end;

  if TChartGalleryPanel(Parent).FocusRotation then
  begin
    View3DOptions.Rotation:=345;
    if SeriesCount>0 then
       TSeriesAccess(Series[0]).GalleryChanged3D(Is3D);
  end;

  With Title.Font do
  begin
    Style:=[fsBold];
    Color:=clBlack;
    {$IFDEF CLX}
    Size:=GetDefaultFontSize+2;
    {$ELSE}
    Size:=9;
    {$ENDIF}
  end;
  BevelOuter:=bvRaised;

  if Showing then SetFocus;
end;

Procedure TGalleryChart.UnFocus(Is3D:Boolean);
begin
  if Gradient.Visible then
  begin
    Gradient.Visible:=False;
    BevelOuter:=bvNone;

    With Title.Font do
    begin
      Style:=[];
      Color:=clNavy;
      Size:=GetDefaultFontSize;
    end;

    if TChartGalleryPanel(Parent).FocusRotation then
    begin
      View3DOptions.Rotation:=335;
      if SeriesCount>0 then
         TSeriesAccess(Series[0]).GalleryChanged3D(Is3D);
    end;
  end;
end;

Procedure TGalleryChart.CheckShowLabels;

  Function IsMaximized:Boolean;
  var tmp : TCustomForm;
  {$IFNDEF CLX}
  var Placement : TWindowPlacement;
  {$ENDIF}
  begin
    tmp:=GetParentForm(Self);
    if Assigned(tmp) then
    begin
      {$IFDEF CLX}
      result:=tmp.WindowState=wsMaximized;
      {$ELSE}
      Placement.length := SizeOf(TWindowPlacement);
      GetWindowPlacement(tmp.Handle, {$IFNDEF CLR}@{$ENDIF}Placement);
      result:=Placement.ShowCmd=SW_SHOWMAXIMIZED;
      {$ENDIF}
    end
    else result:=False;
  end;

begin
  if TeeGalleryCheckMaximize and AxisVisible then
  begin
    LeftAxis.Labels:=IsMaximized;
    BottomAxis.Labels:=LeftAxis.Labels;
  end;
end;

{$IFDEF CLX}
procedure TGalleryChart.MouseEnter(AControl:TControl);
{$ELSE}
procedure TGalleryChart.CMMouseEnter(var Message: TMessage);
{$ENDIF}
begin
  DrawFrame3D(False);
  inherited;
end;

{$IFDEF CLX}
procedure TGalleryChart.MouseLeave(AControl:TControl);
{$ELSE}
procedure TGalleryChart.CMMouseLeave(var Message: TMessage);
{$ENDIF}
begin
  DrawFrame3D(True);
  inherited;
end;

procedure TGalleryChart.SetSmooth(Value:Boolean);
begin
  SetBooleanProperty(FSmooth,Value);

  if not FSmooth then
  begin
    LeftAxis.Labels:=False;
    BottomAxis.Labels:=False;
  end;
end;

Function TGalleryChart.ArrowOrigin:TPoint;
var tmpHeight : Integer;
    tmpStart  : Integer;
begin
  tmpHeight:=0;
  if Border.Visible then Inc(tmpHeight,Border.Width);
  if Shadow.Size>0 then Inc(tmpHeight,Shadow.Size);
  if Smooth then tmpHeight:=tmpHeight div 2;
  result.Y:=Height-tmpHeight;

  tmpStart:=0;
  if Border.Visible then Inc(tmpStart,Border.Width);
  if Smooth then tmpStart:=tmpStart div 2;
  result.X:=4+tmpStart;
end;

procedure TGalleryChart.DrawSubGalleryArrow;
Const tmpH=6;
      tmpW=7;
var P : TPoint;
begin
  P:=ArrowOrigin;

  with Canvas do
  begin
    Pen.Mode:=pmNotXor;
    Brush.Style:=bsSolid;
    Brush.Color:=clBlack;
    Pen.Style:=psClear;
    Polygon([TeePoint(P.X,P.Y-tmpH-2),TeePoint(P.X+tmpW,P.Y-tmpH-2),
             TeePoint(P.X+(tmpW div 2),P.Y-4)]);
    Pen.Mode:=pmCopy;
    Pen.Style:=psSolid;
  end;
end;

procedure TGalleryChart.DrawSmoothChart;
var tmp  : TBitmap;
    tmpR : TRect;
    Old  : Boolean;
begin
  ICreatingBitmap:=True;

  LeftAxis.Labels:=True;
  BottomAxis.Labels:=True;
  tmpR:=Title.ShapeBounds;
  Old:=Title.Visible;
  Title.Hide;
  MarginTop:=30;

  tmp:=TeeCreateBitmap(Color,TeeRect(0,0,2*Width,2*Height),{$IFDEF CLR}pfDevice{$ELSE}TeePixelFormat{$ENDIF});
  try
    Canvas.InitWindow(Canvas.ReferenceCanvas,View3DOptions,Color,View3D,BoundsRect);
    SmoothStretch(tmp,TTeeCanvas3D(Canvas).Bitmap,ssBestPerformance);
  finally
    tmp.Free;
    Title.Visible:=Old;
    Title.ShapeBounds:=tmpR;
    Title.CustomPosition:=True;
    Title.DrawTitle;
    Title.CustomPosition:=False;
    SetMargins;
    ICreatingBitmap:=False;
  end;
end;

procedure TGalleryChart.AfterDraw(Sender: TObject);
begin
  if FSmooth and (not ICreatingBitmap) then
     DrawSmoothChart;

  if not ICreatingBitmap then
    if Gradient.Visible then
       if TChartGalleryPanel(Parent).DisplaySub then
          DrawSubGalleryArrow;
end;

{ TChartGalleryPanel }
Constructor TChartGalleryPanel.Create(AOwner:TComponent);
begin
  inherited;

  FunctionsVisible:=False;
  ISelectedChart:=nil;
  SelectedSeries:=nil;
  FOnSelectedChart:=nil;
  FOnChangeChart:=nil;
  Charts:=TChartList.Create;
  FView3D:=True;
  FDisplaySub:=True;
  FFocusRotation:=True;
  FNumRows:=3;
  FNumCols:=4;

  {$IFNDEF CLX}
  {$IFDEF D7}
  ParentBackground:=True;
  {$ENDIF}
  {$ENDIF}

  ParentColor:=True;

  FSmooth:=DefaultSmooth;
  FOldSmooth:=FSmooth;
end;

Destructor TChartGalleryPanel.Destroy;
begin
  if FSmooth<>FOldSmooth then SaveSmooth(FSmooth);
  Charts.Free;
  inherited;
end;

class Function TChartGalleryPanel.DefaultSmooth:Boolean;
begin
  result:=TeeReadBoolOption('SmoothGallery',False);
end;

class Function TChartGalleryPanel.DefaultMode:Integer;
begin
  result:=TeeReadIntegerOption('GalleryMode',0);
end;

class Procedure TChartGalleryPanel.SaveSmooth(Value:Boolean);  // 6.02
begin
  TeeSaveBoolOption('SmoothGallery',Value);
end;

class Procedure TChartGalleryPanel.SaveMode(Value:Integer);  // 6.02
begin
  TeeSaveIntegerOption('GalleryMode',Value);
end;

Procedure TChartGalleryPanel.SetNumCols(Value:Integer);
begin
  FNumCols:=Value;
  ResizeCharts;
end;

Procedure TChartGalleryPanel.SetNumRows(Value:Integer);
begin
  FNumRows:=Value;
  ResizeCharts;
end;

Procedure TChartGalleryPanel.GetChartXY(AChart:TGalleryChart; Var x,y:Integer);
var tmp : Integer;
begin
  tmp:=Charts.IndexOf(AChart);
  y:=tmp div NumCols;
  x:=tmp mod NumCols;
end;

procedure TChartGalleryPanel.ChartOnDblClick(Sender: TObject);
begin
  ISelectedChart:=TGalleryChart(Sender);
  if Assigned(FOnSelectedChart) then OnSelectedChart(Self);
end;

Procedure TChartGalleryPanel.CalcChartWidthHeight;
var tmp : Integer;
begin
  if (NumRows>0) and (NumCols>0) then
  begin
    tmp:=BevelWidth+BorderWidth;
    FRowHeight:=(Height-tmp) div NumRows;
    FColWidth:=(Width-tmp) div NumCols;
  end
  else
  begin
    FRowHeight:=0;
    FColWidth:=0;
  end;
end;

type
   TFunctionAccess=class(TTeeFunction);

Function TChartGalleryPanel.CreateChart(Const AType:TTeeSeriesType):TCustomAxisPanel;
Var tmpClass : TChartSeriesClass;

  Procedure CreateSeries;
  Var tmp : Integer;
  begin
    for tmp:=1 to Math.Max(1,AType.NumGallerySeries) do
        CreateNewSeries(nil,result,tmpClass,AType.FunctionClass);
  end;

var t              : Integer;
    tmpNum         : Integer;
    DisabledSeries : Boolean;
    tmpFunc        : TTeeFunction;
    tmpDesc        : String;

    {$IFDEF USETHEMES}
    tmpColor       : Cardinal;
    tmpPColor      : Cardinal;
    {$ENDIF}
begin
  tmpClass:=AType.SeriesClass;
  if not Assigned(tmpClass) then tmpClass:=TLineSeries;

  result:=TGalleryChart.Create(Self);

  result.Color:=Color;

  {$IFNDEF CLX}
  result.AutoRepaint:=False;
  {$ENDIF}

  Charts.Add(result);

  With TGalleryChart(result) do
  begin
    tmpDesc:=AType.Description{$IFNDEF CLR}^{$ENDIF};
    tmpNum:=TeeNumFields(tmpDesc,#13);
    for t:=1 to tmpNum do
        Title.Text.Add(TeeExtractField(tmpDesc,t,#13));

    Parent:=Self;

    {$IFDEF USETHEMES}
    if ThemeServices.ThemesEnabled then
    begin
      tmpColor:=0;
      tmpPColor:=Integer(@tmpColor);
      GetThemeColor(ThemeServices.Theme[teTab],TABP_BODY,TIS_NORMAL,TMT_FILLCOLOR,tmpPColor);
      Color:=tmpPColor;
    end;
    {$ENDIF}

    Name:=TeeGetUniqueName(Owner,TeeMsg_GalleryChartName);
    ResizeChart(TGalleryChart(result));

    CreateSeries;
    DisabledSeries:=CheckSeries and
                    Assigned(SelectedSeries) and
                    ( not Series[0].IsValidSourceOf(SelectedSeries) );

    if DisabledSeries then
    begin
      Cursor:=TeeCursorDisabled;
      OriginalCursor:=Cursor;
      OnClick:=nil;
      OnDblClick:=nil;
      Title.Font.Color:=clGray;
      LeftWall.Pen.Color:=clGray;
      BottomWall.Pen.Color:=clGray;
      LeftAxis.Axis.Width:=1;
      LeftAxis.Axis.Color:=clWhite;
      BottomAxis.Axis.Width:=1;
      BottomAxis.Axis.Color:=clWhite;
    end
    else
    begin
      Cursor:=crHandPoint;
      OriginalCursor:=Cursor;
      OnClick:=ChartEvent;
      OnDblClick:=ChartOnDblClick;
      OnEnter:=ChartEvent;
    end;

    TSeriesAccess(Series[0]).GalleryChanged3D(Self.FView3D);

    if AType.FunctionClass=nil then
       for t:=0 to SeriesCount-1 do
           TSeriesAccess(Series[t]).PrepareForGallery(not DisabledSeries)
    else
    begin
      tmpFunc:=AType.FunctionClass.Create(nil);
      try
        TFunctionAccess(tmpFunc).PrepareForGallery(result);  // 6.0
      finally
        tmpFunc.Free;
      end;
    end;

    SetMargins;
    CheckShowLabels;

    Smooth:=Self.Smooth;
  end;

  if not ISubGallery then TGalleryChart(result).OnKeyDown:=ChartKeyDown;

  result.AutoRepaint:=True;
end;

procedure TChartGalleryPanel.KeyDown(var Key: Word; Shift: TShiftState);

    { returns the gallery Chart in XY position (Column / Row) }
    Function FindChartXY(x,y:Integer):TGalleryChart;
    var tmpX : Integer;
        tmpY : Integer;
        t    : Integer;
    begin
      for t:=0 to Charts.Count-1 do
      begin
        result:=Charts[t];
        GetChartXY(result,tmpX,tmpY);
        if (x=tmpx) and (y=tmpy) then Exit;
      end;
      result:=nil;
    end;

var x,y : Integer;
    tmp : TGalleryChart;
begin
  inherited;
  GetChartXY(SelectedChart,x,y);
  Case Key of
    TeeKey_Left  : if x>0 then Dec(x);
    TeeKey_Right : if x<NumCols then Inc(x);
    TeeKey_Up    : if y>0 then Dec(y);
    TeeKey_Down  : if ssAlt in Shift then
                   begin
                     if DisplaySub then ShowSubGallery
                   end
                   else if y<NumRows then Inc(y);
    TeeKey_Return: ChartOnDblClick(SelectedChart);
  end;
  tmp:=FindChartXY(x,y);
  if Assigned(tmp) and (tmp.Cursor=crHandPoint) then SelectChart(tmp);
end;

Procedure TChartGalleryPanel.ResizeChart(AChart:TGalleryChart; TopOffset:Integer=0);
var tmp    : Integer;
    tmpCol : Integer;
    tmpRow : Integer;
    R      : TRect;
begin
  if (NumCols>0) and (NumRows>0) then
  begin
    GetChartXY(AChart,tmpCol,tmpRow);
    tmp:=BevelWidth+BorderWidth;
    With R do
    begin
      Left:=tmp+(tmpCol*ColWidth);
      Top:=tmp+(tmpRow*RowHeight)-TopOffset;
      Right:=Left+Math.Min(ColWidth,Width-tmp)-1;
      Bottom:=Top+Math.Min(RowHeight,Height-tmp)-1;
    end;
    AChart.BoundsRect:=R;
    AChart.CheckShowLabels;
  end;
end;

Procedure TChartGalleryPanel.ShowSelectedChart;
var t : Integer;
begin
  if not Assigned(SelectedChart) then
     for t:=Charts.Count-1 downto 0 do
         if Charts[t].Cursor<>TeeCursorDisabled then
            ISelectedChart:=Charts[t];

  if Assigned(SelectedChart) then
  begin
    SelectedChart.Focus(FView3D);
    if Assigned(FOnChangeChart) then OnChangeChart(Self);
  end;

  for t:=0 to Charts.Count-1 do
      if Charts[t]<>SelectedChart then Charts[t].UnFocus(FView3D);
end;

procedure TChartGalleryPanel.FindSelectedChart;
var t : Integer;
begin
  ISelectedChart:=nil;
  if Assigned(SelectedSeries) then
    for t:=0 to Charts.Count-1 do
    With Charts[t].Series[0] do
    if (ClassType=SelectedSeries.ClassType) and (FunctionType=nil) then
    begin
      ISelectedChart:=Charts[t];
      break;
    end;
end;

procedure TChartGalleryPanel.ChartKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key,Shift);
end;

procedure TChartGalleryPanel.SubKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=TeeKey_Escape then tmpSub.ModalResult:=mrCancel
                       else tmpG.KeyDown(Key,Shift);
end;

procedure TChartGalleryPanel.SubSelected(Sender: TObject);
var t   : Integer;
    tmpClass : TChartSeriesClass;
    tmpNum   : Integer;
begin
  With SelectedChart do
  begin
    Tag:={$IFDEF CLR}Variant{$ENDIF}(tmpG.Charts.IndexOf(tmpG.SelectedChart));

    if Tag=0 then
    begin
      tmpClass:=TChartSeriesClass(Series[0].ClassType);
      tmpNum:=SeriesCount;
      FreeAllSeries;
      for t:=1 to tmpNum do CreateNewSeries(nil,SelectedChart,tmpClass);
      TSeriesAccess(Series[0]).GalleryChanged3D(tmpG.View3D);
      for t:=0 to SeriesCount-1 do
          TSeriesAccess(Series[t]).PrepareForGallery(True);
    end
    else
    for t:=0 to SeriesCount-1 do
        TSeriesAccess(Series[t]).SetSubGallery(Series[t],Tag);
  end;
  tmpSub.ModalResult:=mrOk;
end;

procedure TChartGalleryPanel.SubPaintBox(Sender:TObject);
begin
  With TPaintBox(Sender).Canvas do
  begin
    Brush.Color:=clBlack;
    Pen.Style:=psClear;
    Polygon([TeePoint(0,8),TeePoint(4,0),TeePoint(9,8)]);
  end;
end;

procedure TChartGalleryPanel.SubPanelClick(Sender:TObject);
begin
  tmpSub.ModalResult:=mrOk;
end;

Procedure TChartGalleryPanel.AddSubCharts(AGallery:TChartGalleryPanel);
begin
  tmpG:=AGallery;
  tmpType:=TTeeSeriesType.Create;
  try
    tmpType.SeriesClass:=TChartSeriesClass(tmpSeries.ClassType);
    tmpType.NumGallerySeries:=1;
    tmpType.FunctionClass:=nil;
    AGallery.Charts.Clear;
    TSeriesAccess(tmpSeries).CreateSubGallery(CreateSubChart);
  finally
    tmpType.Free;
  end;
end;

Procedure TChartGalleryPanel.CreateSubGallery(AGallery:TChartGalleryPanel; AClass:TChartSeriesClass);
var tmpN : Integer;
begin
  tmpSeries:=AClass.Create(nil);
  try
    AddSubCharts(AGallery);

    { calculate charts width and height }
    AGallery.CalcChartWidthHeight;
    tmpN:=AGallery.Charts.Count div AGallery.NumCols;
    if AGallery.Charts.Count mod AGallery.NumCols > 0 then Inc(tmpN);
    AGallery.Parent.Height:=8+AGallery.FRowHeight*tmpN;
    AGallery.NumRows:=tmpN;
  finally
    tmpSeries.Free;
  end;
end;

procedure TChartGalleryPanel.ShowSubGallery;
var tmp      : TPoint;
    tmpPos   : Integer;
    tmpPanel : TPanel;
    tmpPaint : TPaintBox;
begin
  if Assigned(tmpSub) then FreeAndNil(tmpSub);

  SelectedChart.UnFocus(FView3D);
  tmp:=ClientToScreen(TeePoint(SelectedChart.Left,SelectedChart.Top+SelectedChart.Height));

  tmpSub:=TForm.Create(Self);
  try
    With tmpSub do
    begin
      BorderStyle:=TeeFormBorderStyle;
      Left:=tmp.X;
      Top:=tmp.Y;
      KeyPreview:=True;
      OnKeyDown:=SubKeyDown;
    end;

    { top panel }
    tmpPanel:=TPanel.Create(tmpSub);
    tmpPanel.Align:=alTop;
    tmpPanel.Caption:='';
    tmpPanel.Height:=12;
    tmpPanel.Parent:=tmpSub;
    tmpPanel.OnClick:=SubPanelClick;

    { paintbox to paint small arrow at top panel }
    tmpPaint:=TPaintBox.Create(tmpSub);
    tmpPaint.Parent:=tmpPanel;
    tmpPaint.BoundsRect:=TeeRect(4,2,12,10);
    tmpPaint.OnClick:=SubPanelClick;
    tmpPaint.OnPaint:=SubPaintBox;

    { gallery }
    tmpG:=TChartGalleryPanel.Create(tmpSub);
    tmpG.View3D:=View3D;
    tmpG.OnSelectedChart:=SubSelected;
    tmpG.DisplaySub:=False;
    tmpG.Smooth:=Smooth;
    tmpG.Align:=alClient;
    tmpG.Parent:=tmpSub;
    tmpG.ISubGallery:=True;

    { 5.02 Align:=alClient seems to fail if tmpSub.Parent is nil? }
    tmpG.Height:=tmpSub.Height;

    CreateSubGallery(tmpG,TChartSeriesClass(SelectedChart[0].ClassType));

    tmpG.ShowSelectedChart;

    { check if the sub-gallery is far over the right side of screen }
    tmpPos:={$IFDEF CLX}Screen.Width{$ELSE}
            {$IFNDEF D6}Screen.Width{$ELSE}Screen.WorkAreaRect.Right{$ENDIF}
            {$ENDIF};
    if tmpSub.BoundsRect.Right > tmpPos then { 5.02 }
    begin
      tmpSub.Left:=tmpPos-tmpSub.Width-2; { move it to left }
    end;

    { check if the sub-gallery is far over the bottom side of screen }
    tmpPos:={$IFDEF CLX}Screen.Height{$ELSE}
            {$IFNDEF D6}Screen.Height{$ELSE}Screen.WorkAreaRect.Bottom{$ENDIF}
            {$ENDIF};
    if tmpSub.BoundsRect.Bottom > tmpPos then { 5.02 }
    begin
      tmpSub.Top:=tmpPos-tmpSub.Height-2; { move it to top }
    end;

    if tmpSub.ShowModal=mrOk then
       if Assigned(FOnSubSelected) then FOnSubSelected(Self);
  finally
    FreeAndNil(tmpSub);
  end;

  ShowSelectedChart;
end;

procedure TChartGalleryPanel.ChartEvent(Sender: TObject);
begin
  if Sender is TGalleryChart then
     SelectChart(TGalleryChart(Sender));
end;

procedure TChartGalleryPanel.SelectChart(Chart: TGalleryChart);
var P, PArrow : TPoint;
begin
  if Chart<>ISelectedChart then
  begin
    ISelectedChart:=Chart;
    ShowSelectedChart;
  end;

  if DisplaySub then
  begin
    P:=SelectedChart.GetCursorPos;
    PArrow:=SelectedChart.ArrowOrigin;

    if PointInRect(TeeRect(PArrow.X,PArrow.Y-12,PArrow.X+12,PArrow.Y),P.X,P.Y) then
       ShowSubGallery;
  end;
end;

procedure TChartGalleryPanel.SetView3D(Value:Boolean);
var t : Integer;
begin
  if Value<>FView3D then
  begin
    FView3D:=Value;
    for t:=0 to Charts.Count-1 do
    begin
      TSeriesAccess(Charts[t].Series[0]).GalleryChanged3D(FView3D);
      Charts[t].SetMargins;
    end;
  end;
end;

procedure TChartGalleryPanel.SetSmooth(Value:Boolean);
var t : Integer;
begin
  if not (csReading in ComponentState) then
  if Value<>FSmooth then
  begin
    FSmooth:=Value;
    for t:=0 to Charts.Count-1 do Charts[t].Smooth:=FSmooth;
  end;
end;

Procedure TChartGalleryPanel.CreateChartList(ASeriesList:Array of TChartSeriesClass);
var t     : Integer;
    AType : TTeeSeriesType;
begin
  Charts.Clear;

  for t:=Low(ASeriesList) to High(ASeriesList) do
  begin
    AType:=TeeSeriesTypes.Find(ASeriesList[t]);
    if Assigned(AType) then CreateChart(AType);
  end;

  FindSelectedChart;
  ShowSelectedChart;
end;

Procedure TChartGalleryPanel.ResizeCharts;
var t : Integer;
begin
  CalcChartWidthHeight;
  if Assigned(Charts) then
     for t:=0 to Charts.Count-1 do ResizeChart(Charts[t]);
end;

procedure TChartGalleryPanel.Resize;
begin
  inherited;
  ResizeCharts;
end;

Function TChartGalleryPanel.ValidSeries(Const ASeriesType:TTeeSeriesType; Const APage:String):Boolean;
begin
  result:= (ASeriesType.GalleryPage{$IFNDEF CLR}^{$ENDIF}=APage) and
           (
             (FunctionsVisible and Assigned(ASeriesType.FunctionClass)) or
             ((not FunctionsVisible) and (not Assigned(ASeriesType.FunctionClass)))

           );
end;

Function TChartGalleryPanel.CreateSubChart(Const ATitle:String):TCustomAxisPanel;
var tmp : Integer;
begin
  tmpType.Description:={$IFNDEF CLR}@{$ENDIF}ATitle;
  tmp:=tmpG.Charts.Count;
  result:=tmpG.CreateChart(tmpType);
  TSeriesAccess(tmpSeries).SetSubGallery(result[0],tmp);
  result.Tag:=tmp;
end;

Procedure TChartGalleryPanel.CreateGalleryPage(Const PageName:String);

  Function CalcCount:Integer;
  var t : Integer;
  begin
    result:=0;
    With TeeSeriesTypes do
    for t:=0 to Count-1 do
        if ValidSeries(Items[t],PageName) then Inc(result);
  end;

Var tmp      : TTeeSeriesType;
    tmpCount : Integer;
    t        : Integer;
begin
  tmpCount:=CalcCount;

  if tmpCount>(NumRows*NumCols) then
     FNumRows:=1+((tmpCount-1) div NumCols)
  else
     FNumRows:=TeeGalleryNumRows;

  CalcChartWidthHeight;

  Charts.Clear;

  With TeeSeriesTypes do
  for t:=0 to Count-1 do
  begin
    tmp:=Items[t];
    if ValidSeries(tmp,PageName) then
       CreateChart(tmp);
  end;

  FindSelectedChart;
  ShowSelectedChart;
end;

{$IFNDEF CLX}
procedure TChartGalleryPanel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;
{$ENDIF}

Function TChartGalleryPanel.GetSeriesClass( Var tmpClass:TChartSeriesClass;
                                            Var tmpFunctionClass:TTeeFunctionClass;
                                            Var SubIndex:Integer):Boolean;
begin
  result:=Assigned(SelectedChart);

  if result then
  begin
    tmpSeries:=SelectedChart.Series[0];
    tmpClass:=TChartSeriesClass(tmpSeries.ClassType);

    if Assigned(tmpSeries) and Assigned(tmpSeries.FunctionType) then
       tmpFunctionClass:=TTeeFunctionClass(tmpSeries.FunctionType.ClassType)
    else
       tmpFunctionClass:=nil;

    SubIndex:=SelectedChart.Tag;
  end;
end;

procedure TChartGalleryPanel.UseTheme(Theme: TChartThemeClass);
var t  : Integer;
    tt : Integer;
    tmp : TChartTheme;
begin
  if Assigned(Theme) then
  begin
    tmp:=Theme.Create(nil);
    try
      for t:=0 to Charts.Count-1 do
      begin
        tmp.Chart:=Charts[t];
        tmp.Apply;
        for tt:=0 to Charts[t].SeriesCount-1 do
            TSeriesAccess(Charts[t][tt]).PrepareForGallery(True);
      end;
    finally
      tmp.Free;
    end;
  end;
end;

initialization
  RegisterTeeStandardSeries;
end.

