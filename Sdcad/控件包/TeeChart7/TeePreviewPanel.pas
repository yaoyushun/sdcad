{*********************************************}
{   TeePreviewPanel Component                 }
{   TChartPageNavigator Components            }
{   Copyright (c) 1999-2004 by David Berneda  }
{*********************************************}
unit TeePreviewPanel;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QExtCtrls, QPrinters, QDialogs, QForms,
     {$ELSE}
     Printers, Graphics, Controls, ExtCtrls, Forms,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeeProcs, TeCanvas;

type
  {$IFDEF CLX}
  TPrinterSetupDialog=class(TCustomDialog)
  protected
    function CreateForm: TDialogForm; override;
    function DoExecute:Boolean; override;
  end;

  TPrintDialog=class(TCustomDialog)
  public
    Copies,
    FromPage,
    MinPage,
    ToPage,
    MaxPage  : Integer;
  protected
    function CreateForm: TDialogForm; override;
    function DoExecute:Boolean; override;
  end;
  {$ENDIF}

  TTeePreviewPanelOrientation=(ppoDefault,ppoPortrait,ppoLandscape);

  TOnChangeMarginsEvent=Procedure( Sender:TObject; DisableProportional:Boolean;
                                   Const NewMargins:TRect) of object;

  TOnGetPaperRect=Procedure(Sender:TObject; var PaperRect:TRect) of object;

  TPreviewChartPen=class(TChartPen)
  published
    property Style default psDot;
    property SmallDots default True;
  end;

  TeePreviewZones=( teePrev_None,
                    teePrev_Left,
                    teePrev_Top,
                    teePrev_Right,
                    teePrev_Bottom,
                    teePrev_Image,
                    teePrev_LeftTop,
                    teePrev_RightTop,
                    teePrev_LeftBottom,
                    teePrev_RightBottom );

  TTeePanelsList=class(TList)
  private
    Function Get(Index:Integer):TCustomTeePanel;
    Procedure Put(Index:Integer; Value:TCustomTeePanel);
  public
    property Items[Index:Integer]:TCustomTeePanel read Get write Put; default;
  end;

  TTeePreviewPanel=class(TCustomTeePanelExtended)
  private
    FAllowResize     : Boolean;
    FAllowMove       : Boolean;
    FAsBitmap        : Boolean;
    FPanels          : TTeePanelsList;
    FDragImage       : Boolean;
    FMargins         : TPreviewChartPen;
    FOrientation     : TTeePreviewPanelOrientation;
    FOnChangeMargins : TOnChangeMarginsEvent;
    FOnGetPaperRect  : TOnGetPaperRect;
    FPaperColor      : TColor;
    FPaperShadow     : TTeeShadow;
    FShowImage       : Boolean;
    FSmoothBitmap    : Boolean;
    FTitle           : String;

    { internal }
    IDragged         : TeePreviewZones;
    OldX             : Integer;
    OldY             : Integer;
    OldRect          : TRect;
    IOldShowImage    : Boolean;

    Procedure CheckPrinterOrientation;
    Function GetPanel:TCustomTeePanel;
    Function GetPrintingBitmap(APanel:TCustomTeePanel):TBitmap;
    Function GetShadowColor:TColor;  // obsolete
    Function GetShadowSize:Integer;  // obsolete
    Procedure SendAsBitmap(APanel:TCustomTeePanel; ACanvas:TCanvas; Const R:TRect); overload;
    Procedure SendAsBitmap(APanel:TCustomTeePanel; Const R:TRect); overload;
    Procedure SetAsBitmap(Value:Boolean);
    Procedure SetMargins(Value:TPreviewChartPen);
    Procedure SetOrientation(Value:TTeePreviewPanelOrientation);
    Procedure SetPanel(Value:TCustomTeePanel);
    Procedure SetPaperColor(Value:TColor);
    Procedure SetPaperShadow(Value:TTeeShadow);
    Procedure SetShadowColor(Value:TColor);  // obsolete
    Procedure SetShadowSize(Value:Integer);  // obsolete
    Procedure SetShowImage(Value:Boolean);
    procedure SetSmoothBitmap(const Value: Boolean);
  protected
    Function CalcImagePrintMargins(APanel:TCustomTeePanel):TRect;
    Procedure DrawPaper;
    Procedure DrawPanelImage(APanel:TCustomTeePanel);
    Procedure DrawMargins(Const R:TRect);
    Procedure InternalDraw(Const UserRectangle:TRect); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    Function WhereIsCursor(x,y:Integer):TeePreviewZones;
  public
    ImageRect : TRect;
    PaperRect : TRect;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Print;
    property Panels:TTeePanelsList read FPanels;

    // compatibility with v5 (obsolete)
    property ShadowColor:TColor read GetShadowColor write SetShadowColor;
    property ShadowSize:Integer read GetShadowSize write SetShadowSize;
  published
    property AllowResize:Boolean read FAllowResize write FAllowResize default True;
    property AllowMove:Boolean read FAllowMove write FAllowMove default True;
    property AsBitmap:Boolean read FAsBitmap write SetAsBitmap default False;
    property DragImage:Boolean read FDragImage write FDragImage default False;
    property Margins:TPreviewChartPen read FMargins write SetMargins;
    property Orientation:TTeePreviewPanelOrientation read FOrientation
                     write SetOrientation default ppoDefault;
    property Panel:TCustomTeePanel read GetPanel write SetPanel;
    property PaperColor:TColor read FPaperColor write SetPaperColor default clWhite;

    property PaperShadow:TTeeShadow read FPaperShadow write SetPaperShadow; // 6.0
    property Shadow; // 6.0

    property ShowImage:Boolean read FShowImage write SetShowImage default True;
    property SmoothBitmap:Boolean read FSmoothBitmap write SetSmoothBitmap default True;  // 7.0
    property Title:String read FTitle write FTitle;

    property OnChangeMargins:TOnChangeMarginsEvent read FOnChangeMargins
                                                   write FOnChangeMargins;
    property OnGetPaperRect:TOnGetPaperRect read FOnGetPaperRect
                                            write FOnGetPaperRect;

    { TeePanelExtended }
    property BackImage;
    property BackImageMode;
    property Border;
    property BorderRound;
    property Gradient;

    { TPanel properties }
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property Color;
    property DragMode;
    {$IFNDEF CLX}
    property DragCursor;
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

    property OnAfterDraw;

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
    property OnStartDrag;
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
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    {$IFNDEF CLX}
    property OnCanResize;
    {$ENDIF}
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

implementation

uses
  Math, SysUtils;

{$IFNDEF CLR}
type
  TShadowAccess=class(TTeeShadow);
{$ENDIF}

Const TeePreviewCursors:Array[0..9] of TCursor=
           ( crDefault, { none }
             crHSplit,
             crVSplit,
             crHSplit,
             crVSplit,
             crTeeHand,
             crSizeNWSE,
             crSizeNESW,
             crSizeNESW,
             crSizeNWSE );

{ TeePreviewPanel }
Constructor TTeePreviewPanel.Create(AOwner:TComponent);
Begin
  inherited;
  FPanels:=TTeePanelsList.Create;
  FDragImage:=False;
  FOrientation:=ppoDefault;
  FMargins:=TPreviewChartPen.Create(CanvasChanged);
  FMargins.SmallDots:=True;
  FMargins.Style:=psDot;

  FShowImage:=True;
  IOldShowImage:=True;
  IDragged:=teePrev_None;
  FAsBitmap:=False;
  FSmoothBitmap:=True;
  FPaperColor:=clWhite;
  FAllowResize:=True;
  FAllowMove:=True;
  FTitle:='';

  FPaperShadow:=TTeeShadow.Create(CanvasChanged);

  with {$IFNDEF CLR}TShadowAccess{$ENDIF}(FPaperShadow) do
  begin
    Color:=clDkGray;
    Size:=4;
    DefaultColor:=Color;
    DefaultSize:=4;
  end;

  Width :=432;
  Height:=312;
end;

Destructor TTeePreviewPanel.Destroy;
begin
  Margins.Free;
  FPaperShadow.Free;
  FPanels.Free;
  inherited;
end;

Function TTeePreviewPanel.GetPrintingBitmap(APanel:TCustomTeePanel):TBitmap;
var tmpR      : TRect;
    WinWidth  : Integer;
    WinHeight : Integer;
    tmpW      : Integer;
    tmpH      : Integer;
    tmpWidth  : Integer;
    tmpHeight : Integer;
begin
  APanel.Printing:=True;
  try
    With APanel.GetRectangle do
    begin
      tmpWidth:=Right-Left;
      tmpHeight:=Bottom-Top;
    end;

    tmpR:=CalcImagePrintMargins(APanel);
    APanel.CalcMetaBounds(tmpR,TeeRect(0,0,tmpWidth,tmpHeight),WinWidth,WinHeight,tmpW,tmpH);
    result:=APanel.TeeCreateBitmap(FPaperColor,TeeRect(0,0,WinWidth,WinHeight),TeePixelFormat);  // 7.0
  finally
    APanel.Printing:=False;
  end;
end;

Procedure TTeePreviewPanel.SendAsBitmap(APanel:TCustomTeePanel; ACanvas:TCanvas; Const R:TRect);
var tmpBitmap : TBitmap;
begin
  tmpBitmap:=GetPrintingBitmap(APanel);
  try
    ACanvas.StretchDraw(R,tmpBitmap);
  finally
    tmpBitmap.Free;
  end;
end;

Procedure TTeePreviewPanel.SendAsBitmap(APanel:TCustomTeePanel; Const R:TRect);
var tmpBitmap : TBitmap;
    tmpSmooth : TBitmap;
begin
  tmpBitmap:=GetPrintingBitmap(APanel);
  try
    if SmoothBitmap then
    begin
      tmpSmooth:=TBitmap.Create;
      try
        tmpSmooth.Width:=R.Right-R.Left;
        tmpSmooth.Height:=R.Bottom-R.Top;
        SmoothStretch(tmpBitmap,tmpSmooth,ssBestQuality);  // 7.0
        Canvas.Draw(R.Left,R.Top,tmpSmooth);
      finally
        tmpSmooth.Free;
      end;
    end
    else
       Canvas.StretchDraw(R,tmpBitmap);
  finally
    tmpBitmap.Free;
  end;
end;

Procedure TTeePreviewPanel.Print;
var t : Integer;
Begin
  if FPanels.Count>0 then
  Begin
    Screen.Cursor:=crHourGlass;
    try
      CheckPrinterOrientation;

      if FTitle='' then
      begin
        if Panel.Name<>'' then
           Printer.Title:=Panel.Name;
      end
      else Printer.Title:=FTitle;

      Printer.BeginDoc;
      try
        for t:=0 to Panels.Count-1 do
            if FAsBitmap then SendAsBitmap(Panels[t],Printer.Canvas,Panels[t].ChartPrintRect)
                         else Panels[t].PrintPartial(Panels[t].ChartPrintRect);

        if Assigned(FOnAfterDraw) then FOnAfterDraw(Self);
        Printer.EndDoc;
      except
        on Exception do
        begin
          Printer.Abort;
          if Printer.Printing then Printer.EndDoc;
          Raise;
        end;
      end;
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
end;

Procedure TTeePreviewPanel.DrawPaper;
Begin
  With Canvas do
  Begin
    Pen.Style:=psSolid;
    Pen.Color:=clBlack;
    Pen.Width:=1;
    Brush.Color:=FPaperColor;
    Rectangle(PaperRect);
  end;

  PaperShadow.Draw(Canvas,PaperRect);
end;

Procedure TTeePreviewPanel.SetAsBitmap(Value:Boolean);
begin
  SetBooleanProperty(FAsBitmap,Value);
end;

Procedure TTeePreviewPanel.SetPaperColor(Value:TColor);
begin
  SetColorProperty(FPaperColor,Value);
end;

Procedure TTeePreviewPanel.SetShadowSize(Value:Integer);
begin
  PaperShadow.Size:=Value;
end;

Procedure TTeePreviewPanel.SetShowImage(Value:Boolean);
begin
  SetBooleanProperty(FShowImage,Value);
end;

Procedure TTeePreviewPanel.SetMargins(Value:TPreviewChartPen);
Begin
  FMargins.Assign(Value);
End;

Procedure TTeePreviewPanel.SetPanel(Value:TCustomTeePanel);
Begin
  if ((FPanels.Count=0) or (Panel<>Value)) and (Value<>Self) then
  begin
    if Assigned(Value) then
    begin
      if FPanels.IndexOf(Value)=-1 then
      begin
        FPanels.Add(Value);
        Value.FreeNotification(Self); { 5.01 }
      end;
    end
    else FPanels.Delete(0);
    if Assigned(Panel) then FAsBitmap:=Panel.Canvas.SupportsFullRotation;
    Invalidate;
  end;
End;

Function TTeePreviewPanel.CalcImagePrintMargins(APanel:TCustomTeePanel):TRect;
var PaperWidth  : Integer;
    PaperHeight : Integer;
begin
  RectSize(PaperRect,PaperWidth,PaperHeight);
  if Assigned(APanel) then
  begin
    With APanel do
       if PrintProportional and (Printer.Printers.Count>0) then
          PrintMargins:=CalcProportionalMargins;
    result:=APanel.PrintMargins
  end
  else result:=TeeRect(15,15,15,15);

  With result do
  begin
    Left  :=PaperRect.Left  +MulDiv(Left  ,PaperWidth,100);
    Right :=PaperRect.Right -MulDiv(Right ,PaperWidth,100);
    Top   :=PaperRect.Top   +MulDiv(Top   ,PaperHeight,100);
    Bottom:=PaperRect.Bottom-MulDiv(Bottom,PaperHeight,100);
  end;
end;

Procedure TTeePreviewPanel.CheckPrinterOrientation;
begin
  if Printer.Printers.Count>0 then
  Case FOrientation of
     ppoDefault: ;
    ppoPortrait: Printer.Orientation:=poPortrait;
  else
    Printer.Orientation:=poLandscape;
  end;
end;

Procedure TTeePreviewPanel.InternalDraw(Const UserRectangle:TRect);

  Procedure CalcPaperRectangles;
  Const Margin=5;
  Var R         : TRect;
      tmpWidth  : Integer;
      tmpHeight : Integer;
      PrinterWidth  : Integer;
      PrinterHeight : Integer;
  begin
    CheckPrinterOrientation;

    if Printer.Printers.Count>0 then
    begin
      try
        PrinterWidth :=Printer.PageWidth;
        PrinterHeight:=Printer.PageHeight;
      except
        on EPrinter do
        begin
          PrinterWidth:=Screen.Width;
          PrinterHeight:=Screen.Height;
        end;
      end;
    end
    else
    begin
      PrinterWidth:=Screen.Width;
      PrinterHeight:=Screen.Height;
    end;

    R:=TeeRect(0,0,PrinterWidth,PrinterHeight);

    if (ClientWidth*PrinterHeight)>(ClientHeight*PrinterWidth) then
    Begin
      tmpHeight:=ClientHeight-Round(ClientHeight/Margin);
      PaperRect.Top:=Round(ClientHeight/(2*Margin));
      PaperRect.Bottom:=PaperRect.Top+tmpHeight;
      if PrinterHeight>0 then
        tmpWidth:=MulDiv(tmpHeight,PrinterWidth,PrinterHeight)
      else
        tmpWidth:=ClientWidth;
      PaperRect.Left:=(ClientWidth-tmpWidth) div 2;
      PaperRect.Right:=PaperRect.Left+tmpWidth;
    end
    else
    Begin
      tmpWidth:=ClientWidth-Round(ClientWidth/Margin);
      PaperRect.Left:=Round(ClientWidth/(2*Margin));
      PaperRect.Right:=PaperRect.Left+tmpWidth;
      if PrinterWidth>0 then
        tmpHeight:=MulDiv(tmpWidth,PrinterHeight,PrinterWidth)
      else
        tmpHeight:=ClientHeight;
      PaperRect.Top:=(ClientHeight-tmpHeight) div 2;
      PaperRect.Bottom:=PaperRect.Top+tmpHeight;
    end;
  end;

var t : Integer;
begin
  PanelPaint(UserRectangle);
  RecalcWidthHeight;
  InternalCanvas.Projection(100,ChartBounds,ChartRect);
  Canvas.ResetState;

  CalcPaperRectangles;

  if Assigned(FOnGetPaperRect) then
     FOnGetPaperRect(Self,PaperRect);

  DrawPaper;
  ImageRect:=CalcImagePrintMargins(Panel);
  for t:=0 to Panels.Count-1 do DrawPanelImage(Panels[t]);
  DrawMargins(ImageRect);
  Canvas.ResetState;
  if Assigned(FOnAfterDraw) then FOnAfterDraw(Self);
end;

Procedure TTeePreviewPanel.DrawMargins(Const R:TRect);
Begin
  if Margins.Visible then
  With Canvas do
  Begin
    AssignVisiblePen(Margins);
    Pen.Mode:=pmNotXor;
    Brush.Style:=bsClear;
    Brush.Color:=FPaperColor;
    BackMode:=cbmTransparent;
    With R do
    Begin
      DoVertLine(Left-1,PaperRect.Top+1,PaperRect.Bottom);
      DoVertLine(Right,PaperRect.Top+1,PaperRect.Bottom);
      DoHorizLine(PaperRect.Left+1,PaperRect.Right,Top-1);
      DoHorizLine(PaperRect.Left+1,PaperRect.Right,Bottom);
    end;
    BackMode:=cbmOpaque;
    Pen.Mode:=pmCopy;
  end;
end;

Procedure TTeePreviewPanel.DrawPanelImage(APanel:TCustomTeePanel);
Var PanelRect : TRect;

  {$IFNDEF CLX}
  Procedure DrawAsMetafile;
  var tmpR      : TRect;
      tmpMeta   : TMetafile;
      WinWidth  : Integer;
      WinHeight : Integer;
      tmpW      : Integer;
      tmpH      : Integer;
  begin
    tmpR:=PanelRect;
    APanel.CalcMetaBounds(tmpR,APanel.GetRectangle,WinWidth,WinHeight,tmpW,tmpH);
    tmpMeta:=APanel.TeeCreateMetafile(True,TeeRect(0,0,WinWidth,WinHeight));
    try
      Canvas.StretchDraw(PanelRect,tmpMeta);
    finally
      tmpMeta.Free;
    end;
  end;
  {$ENDIF}

Begin
  PanelRect:=CalcImagePrintMargins(APanel);
  APanel.Printing:=True;
  if APanel.CanClip then Canvas.ClipRectangle(PanelRect)
                    else Canvas.ClipRectangle(PaperRect);
  if FShowImage then
     {$IFDEF CLX}
        SendAsBitmap(APanel,Canvas.ReferenceCanvas,PanelRect);
     {$ELSE}
     if AsBitmap then
        SendAsBitmap(APanel,PanelRect)
     else
        DrawAsMetafile;
     {$ENDIF}
  Canvas.UnClipRectangle;
  APanel.Printing:=False;
end;

procedure TTeePreviewPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(Panel) and (AComponent=Panel) then
     Panel:=nil;
end;

Function TTeePreviewPanel.WhereIsCursor(x,y:Integer):TeePreviewZones;
Const MinPixels=5;
var xLeft   : Integer;
    xRight  : Integer;
    yTop    : Integer;
    yBottom : Integer;
Begin
  With ImageRect do
  begin
    xLeft  :=Abs(x-Left);
    XRight :=Abs(x-Right);
    yTop   :=Abs(y-Top);
    yBottom:=Abs(y-Bottom);
    if (xLeft<MinPixels)  and (yTop<MinPixels)    then result:=teePrev_LeftTop else
    if (xLeft<MinPixels)  and (yBottom<MinPixels) then result:=teePrev_LeftBottom else
    if (xRight<MinPixels) and (yTop<MinPixels)    then result:=teePrev_RightTop else
    if (xRight<MinPixels) and (yBottom<MinPixels) then result:=teePrev_RightBottom else
    if xLeft<MinPixels   then result:=teePrev_Left else
    if xRight<MinPixels  then result:=teePrev_Right else
    if yTop<MinPixels    then result:=teePrev_Top else
    if yBottom<MinPixels then result:=teePrev_Bottom else
    if PointInRect(ImageRect,x,y) then
    begin
      if FAllowMove then
      begin
        result:=teePrev_Image;
        exit;
      end else result:=teePrev_None;
    end
    else result:=teePrev_None;
    if (result<>teePrev_None) and (not FAllowResize) then result:=teePrev_None;
  end;
End;

Procedure TTeePreviewPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var tmpR        : TRect;
    PaperWidth  : Integer;
    PaperHeight : Integer;
    {$IFDEF CLR}
    R           : TRect;
    {$ENDIF}
begin
  inherited;

  if PointInRect(PaperRect,x,y) then
  Begin
    if IDragged=teePrev_None then
    begin
      Cursor:=TeePreviewCursors[Ord(WhereIsCursor(x,y))];
      Exit;
    end
    else
    begin
      if not FDragImage then DrawMargins(ImageRect);
      Case IDragged of
        { sides }
        teePrev_Left   : if (x>=PaperRect.Left) and (x<ImageRect.Right) then ImageRect.Left:=x;
        teePrev_Top    : if (y>=PaperRect.Top) and (y<ImageRect.Bottom) then ImageRect.Top:=y;
        teePrev_Right  : if (x<=PaperRect.Right) and (x>ImageRect.Left) then ImageRect.Right:=x;
        teePrev_Bottom : if (y<=PaperRect.Bottom) and (y>ImageRect.Top) then ImageRect.Bottom:=y;
        teePrev_Image  : Begin
                           tmpR.Left  :=Math.Max(PaperRect.Left,OldRect.Left+(x-OldX));
                           tmpR.Top   :=Math.Max(PaperRect.Top,OldRect.Top+(y-OldY));
                           tmpR.Right :=Math.Min(PaperRect.Right,tmpR.Left+(OldRect.Right-OldRect.Left));
                           tmpR.Bottom:=Math.Min(PaperRect.Bottom,tmpR.Top+(OldRect.Bottom-OldRect.Top));
                           if PointInRect(PaperRect,tmpR.Left,tmpR.Top) and
                              PointInRect(PaperRect,tmpR.Right,tmpR.Bottom) then
                                ImageRect:=tmpR;
                         End;
        { corners }
       teePrev_LeftTop : if (x>=PaperRect.Left) and (x<ImageRect.Right) and
                            (y>=PaperRect.Top) and (y<ImageRect.Bottom) then
                         Begin
                           ImageRect.Left:=x;
                           ImageRect.Top:=y;
                         end;
    teePrev_LeftBottom : if (x>=PaperRect.Left) and (x<ImageRect.Right) and
                            (y<=PaperRect.Bottom) and (y>ImageRect.Top) then
                         Begin
                           ImageRect.Left:=x;
                           ImageRect.Bottom:=y;
                         end;
      teePrev_RightTop : if (x<=PaperRect.Right) and (x>ImageRect.Left) and
                            (y>=PaperRect.Top) and (y<ImageRect.Bottom) then
                         Begin
                           ImageRect.Right:=x;
                           ImageRect.Top:=y;
                         end;
   teePrev_RightBottom : if (x<=PaperRect.Right) and (x>ImageRect.Left) and
                            (y<=PaperRect.Bottom) and (y>ImageRect.Top) then
                         Begin
                           ImageRect.Right:=x;
                           ImageRect.Bottom:=y;
                         end;
      end;
      RectSize(PaperRect,PaperWidth,PaperHeight);
      if Assigned(Panel) then
      begin
        Panel.PrintProportional:=False;

        {$IFDEF CLR}
        R:=Panel.PrintMargins;
        with R do
        {$ELSE}
        With Panel.PrintMargins do
        {$ENDIF}
        Begin
          Left  :=MulDiv((ImageRect.Left-PaperRect.Left),100,PaperWidth);
          Right :=MulDiv((PaperRect.Right-ImageRect.Right),100,PaperWidth);
          Top   :=MulDiv((ImageRect.Top-PaperRect.Top),100,PaperHeight);
          Bottom:=MulDiv((PaperRect.Bottom-ImageRect.Bottom),100,PaperHeight);
        end;

        {$IFDEF CLR}
        Panel.PrintMargins:=R;
        {$ENDIF}

      end;
      if Assigned(FOnChangeMargins) and Assigned(Panel) then
         FOnChangeMargins(Self,True,Panel.PrintMargins);
      if FDragImage then Invalidate
                    else DrawMargins(ImageRect);
    end;
  end;
end;

procedure TTeePreviewPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CancelMouse:=False; { 5.03 }
  inherited;
  if IDragged<>teePrev_None then
  begin
    IDragged:=teePrev_None;
    if not FDragImage then Invalidate;
  end;
end;

procedure TTeePreviewPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  IDragged:=WhereIsCursor(x,y);
  if IDragged=teePrev_Image then
  Begin
    OldX:=x;
    OldY:=y;
    OldRect:=ImageRect;
  end;
end;

Procedure TTeePreviewPanel.SetOrientation(Value:TTeePreviewPanelOrientation);
begin
  if Value<>FOrientation then
  begin
    FOrientation:=Value;
    Invalidate;
  end;
end;

procedure TTeePreviewPanel.SetShadowColor(Value: TColor);  // obsolete
begin
  PaperShadow.Color:=Value;
end;

function TTeePreviewPanel.GetShadowColor: TColor; // obsolete
begin
  result:=PaperShadow.Color;
end;

function TTeePreviewPanel.GetShadowSize: Integer; // obsolete
begin
  result:=PaperShadow.Size;
end;

procedure TTeePreviewPanel.SetPaperShadow(Value: TTeeShadow);
begin
  PaperShadow.Assign(Value);
end;

function TTeePreviewPanel.GetPanel: TCustomTeePanel;
begin
  if Panels.Count=0 then result:=nil
                    else result:=Panels[0];
end;

{ TTeePanelsList }
function TTeePanelsList.Get(Index: Integer): TCustomTeePanel;
begin
  result:=TCustomTeePanel(inherited Items[Index]);
end;

procedure TTeePanelsList.Put(Index: Integer; Value: TCustomTeePanel);
begin
  inherited Items[Index]:=Value;
end;

{$IFDEF CLX}
function TPrinterSetupDialog.CreateForm: TDialogForm;
begin
  result:=TDialogForm.CreateNew(nil);
end;

function TPrinterSetupDialog.DoExecute:Boolean;
begin
  result:=Printer.ExecuteSetup;
end;

{ TPrintDialog }
function TPrintDialog.CreateForm: TDialogForm;
begin
  result:=TDialogForm.CreateNew(nil);
end;

function TPrintDialog.DoExecute: Boolean;
begin
  result:=Printer.ExecuteSetup;
end;
{$ENDIF}

procedure TTeePreviewPanel.SetSmoothBitmap(const Value: Boolean);
begin
  SetBooleanProperty(FSmoothBitmap,Value);
end;

end.
