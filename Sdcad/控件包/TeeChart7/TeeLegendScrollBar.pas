{**********************************************}
{   TeeChart Legend Scrollbar Tool             }
{   Copyright (c) 2003-2004 by David Berneda   }
{**********************************************}
unit TeeLegendScrollBar;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QExtCtrls, QStdCtrls, QComCtrls,
  {$ELSE}
  Forms, Controls, Graphics, ExtCtrls, StdCtrls, ComCtrls,
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF LINUX}
  Types,
  {$ENDIF}
  TeEngine, Chart, TeeTools, Series, TeeProcs, TeCanvas, TeePenDlg,
  TeeEdiGrad;

const DefaultScrollBarSize=18;
      TeeMsg_LegendScrollBar='Legend Scrollbar';

type
  TTeeScrollBarDrawStyle=(dsAlways,dsWhenNeeded);

  TTeeScrollBar=class;

  TSetPositionEvent=procedure(Sender:TTeeScrollBar; Value:Integer) of object;

  TTeeScrollBar=class(TTeeCustomTool)
  private
    P1,P2,P3      : TPoint;
    P4,P5,P6      : TPoint;
    FDrawStyle    : TTeeScrollBarDrawStyle;
    FInitial      : Integer;
    ThumbBegin,
    ThumbSize,
    ThumbEnd      : Integer;
    FTimer        : TTimer;
    FOnScrolled   : TNotifyEvent;

    FInThumb,
    FInDec,
    FInInc,
    FirstTime     : Boolean;
    OldPoint      : TPoint;
    FHorizontal   : Boolean;
    FThumbBrush   : TChartBrush;
    FBevel        : TPanelBevel;
    R             : TRect;
    FAutoRepeat   : Boolean;
    FSize         : Integer;
    FArrowBrush   : TChartBrush;
    FBackColor    : TColor;
    FPosition     : Integer;
    FOnSetPosition: TSetPositionEvent;
    FGradient     : TTeeGradient;
    FOnChangeSize : TNotifyEvent;
    FMinSize: Integer;

    Procedure DoScroll;
    function ClickedThumb(const P:TPoint): Boolean;
    Function ClickedDec(const P:TPoint):Boolean;
    Function ClickedInc(const P:TPoint):Boolean;
    Function IncRectangle:TRect;
    Function DecRectangle:TRect;
    Procedure DoTimer(Sender:TObject);
    Function ThumbRectangle:TRect;
    Procedure ApplyScroll(Delta:Double; ActivateTimer:Boolean);
    procedure SetHorizontal(const Value: Boolean);
    Procedure MouseMove(X,Y:Integer);
    Procedure MouseUp;
    Procedure ProcessClick(const P:TPoint);
    procedure SetThumbBrush(const Value: TChartBrush);
    procedure SetBevel(const Value: TPanelBevel);
    procedure SetSize(const Value: Integer);
    procedure SetArrowBrush(const Value: TChartBrush);
    procedure SetBackColor(const Value: TColor);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetMinSize(const Value: Integer);
  protected
    Max         : Integer;
    ThumbLength : Integer;

    Function CalcDelta(A,B:Integer):Double; virtual;
    procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    function CurrentCount:Integer; virtual;
    function DeltaMain:Integer; virtual;
    function GetPosition:Integer; virtual;
    procedure Draw;
    class Function GetEditorClass:String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetPosition(Value:Integer); virtual;
    function ShouldDraw(var R:TRect):Boolean; virtual;
    function TotalCount:Integer; virtual;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    Function MainRectangle:TRect;
    Function ScrollRectangle:TRect;

    property Horizontal:Boolean read FHorizontal write SetHorizontal default False;
    property Position:Integer read GetPosition write SetPosition;
  published
    property Active;
    property ArrowBrush:TChartBrush read FArrowBrush write SetArrowBrush;
    property AutoRepeat:Boolean read FAutoRepeat write FAutoRepeat default True;
    property BackColor:TColor read FBackColor write SetBackColor default clScrollBar;
    property Bevel:TPanelBevel read FBevel write SetBevel default bvRaised;
    property Brush;
    property DrawStyle:TTeeScrollBarDrawStyle read FDrawStyle
                                              write FDrawStyle;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property InitialDelay:Integer read FInitial write FInitial default 250;
    property MinThumbSize:Integer read FMinSize write SetMinSize default 4;
    property Pen;
    property Size:Integer read FSize write SetSize default DefaultScrollbarSize;
    property ThumbBrush:TChartBrush read FThumbBrush write SetThumbBrush;

    property OnChangeSize:TNotifyEvent read FOnChangeSize write FOnChangeSize;
    property OnScrolled:TNotifyEvent read FOnScrolled write FOnScrolled;
    property OnSetPosition:TSetPositionEvent read FOnSetPosition write FOnSetPosition;
  end;

  TLegendScrollBar=class(TTeeScrollBar)
  private
    L : TCustomChartLegend;
    procedure LegendCalcSize(Sender:TCustomChartLegend; var ASize:Integer);
  protected
    function CurrentCount:Integer; override;
    function DeltaMain: Integer; override;
    function GetPosition:Integer; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetPosition(Value:Integer); override;
    function ShouldDraw(var R:TRect):Boolean; override;
    function TotalCount:Integer; override;
  public
    class Function Description:String; override;
  end;

  TScrollbarEditor = class(TForm)
    ButtonPen1: TButtonPen;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    ComboBox1: TComboFlat;
    CBAuto: TCheckBox;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Button3: TButton;
    ButtonColor1: TButtonColor;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CBAutoClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    TeeScroll : TTeeScrollBar;
  public
    { Public declarations }
  end;

implementation

uses Math, TeeBrushDlg;

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Constructor TTeeScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  FAutoRepeat:=True;
  FirstTime:=True;
  FMinSize:=4;
  FSize:=DefaultScrollBarSize;
  FInitial:=250;

  FBackColor:=clScrollBar;
  Brush.Color:=clWhite;
  Pen.Color:=clWindowFrame;
  FArrowBrush:=TChartBrush.Create(CanvasChanged);

  FThumbBrush:=TChartBrush.Create(CanvasChanged);
  FThumbBrush.Color:=clSilver;
  FBevel:=bvRaised;

  FGradient:=TTeeGradient.Create(CanvasChanged);
end;

destructor TTeeScrollBar.Destroy;
begin
  FGradient.Free;
  FArrowBrush.Free;
  FThumbBrush.Free;
  FTimer.Free;
  inherited;
end;

function TTeeScrollBar.ClickedThumb(const P:TPoint): Boolean;
begin
  result:=PointInRect(ThumbRectangle,P.X,P.Y);
end;

function TTeeScrollBar.ClickedInc(const P:TPoint): Boolean;
begin
  result:=PointInRect(IncRectangle,P.X,P.Y);
end;

function TTeeScrollBar.ClickedDec(const P:TPoint): Boolean;
begin
  result:=PointInRect(DecRectangle,P.X,P.Y);
end;

Function TTeeScrollBar.MainRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Left,R.Bottom-1,R.Right,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Top,R.Right,R.Bottom);
end;

Function TTeeScrollBar.ScrollRectangle:TRect;
begin
  result:=MainRectangle;
  if Horizontal then
  begin
    Inc(result.Left,FSize);
    Dec(result.Right,FSize);
  end
  else
  begin
    Inc(result.Top,FSize);
    Dec(result.Bottom,FSize);
  end;
end;

Function TTeeScrollBar.ThumbRectangle:TRect;
begin
  if Horizontal then
  begin
     result:=TeeRect(ThumbBegin,R.Bottom,ThumbEnd,R.Bottom+FSize);
     if result.Right-result.Left<2 then
        Inc(result.Right);
  end
  else
     result:=TeeRect(R.Right-FSize,ThumbBegin,R.Right,ThumbEnd);
end;

Function TTeeScrollBar.DecRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Left,R.Bottom,R.Left+FSize,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Top,R.Right,R.Top+FSize);
end;

Function TTeeScrollBar.IncRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Right-FSize,R.Bottom,R.Right,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Bottom-FSize,R.Right,R.Bottom);
end;

procedure TTeeScrollBar.Draw;
var  tmpMargin   : Integer;

  procedure DrawArrows;
  begin
    // Arrows
    with ParentChart.Canvas do
    begin
      Pen.Style:=psClear;
      tmpMargin:=FSize div 6;

      // Top Arrow
      if FInDec or (Position=0) then
         AssignBrush(FArrowBrush,clDkGray)
      else
         AssignBrush(FArrowBrush,FArrowBrush.Color);

      with DecRectangle do
      begin
        if Horizontal then
        begin
          P1:=TeePoint(Left+tmpMargin,Top+(FSize div 2));
          P2:=TeePoint(Left+FSize-tmpMargin,Top+tmpMargin);
          P3:=TeePoint(Left+FSize-tmpMargin,Bottom-tmpMargin);
        end
        else
        begin
          P1:=TeePoint(Left+tmpMargin,Top+FSize-2*tmpMargin);
          P2:=TeePoint(Left+(FSize div 2),Top+tmpMargin);
          P3:=TeePoint(Left+FSize-tmpMargin,Top+FSize-2*tmpMargin);
        end;
      end;

      Polygon([P1,P2,P3]);

      // Bottom Arrow
      if FInInc or (Position=TotalCount-CurrentCount) then
      begin
        AssignBrush(FArrowBrush,clDkGray);
        Brush.Bitmap:=nil;
        Brush.Color:=clDkGray;
      end
      else
         AssignBrush(FArrowBrush,FArrowBrush.Color);

      if Horizontal then
      begin
        with IncRectangle do
        begin
          P4:=TeePoint(Right-tmpMargin,Top+(FSize div 2));
          P5:=TeePoint(Right-FSize+tmpMargin,Top+tmpMargin);
          P6:=TeePoint(Right-FSize+tmpMargin,Bottom-tmpMargin);
        end;
      end
      else
      begin
        P4:=P1;
        P5:=P2;
        P6:=P3;

        P4.Y:=R.Bottom-FSize+2*tmpMargin;
        P6.Y:=P4.Y;
        P5.Y:=R.Bottom-tmpMargin;
      end;

      Polygon([P4,P5,P6]);
    end;
  end;

var Num,
    tmpSize     : Integer;
    tmpItemSize : Double;
    tmpR        : TRect;
begin
  if not Assigned(ParentChart) then exit;

  if ShouldDraw(R) then
  begin
    with ParentChart.Canvas do
    begin
      AssignBrushColor(Self.Brush,Self.BackColor,Self.Brush.Color);
      AssignVisiblePen(Self.Pen);

      if Self.Gradient.Visible then
      begin
        Self.Gradient.Draw(ParentChart.Canvas,MainRectangle);
        Brush.Style:=bsClear;
      end;

      Rectangle(MainRectangle);

      if Assigned(Self.Gradient) then
         AssignBrushColor(Self.Brush,Self.BackColor,Self.Brush.Color);

      Rectangle(DecRectangle);
      Rectangle(IncRectangle);

      DrawArrows;

      // Thumb
      AssignBrush(Self.ThumbBrush,Self.ThumbBrush.Color);

      Num:=TotalCount;
      if Num<>0 then
      begin
        if Self.FHorizontal then
           tmpSize:=R.Right-R.Left-2*FSize
        else
           tmpSize:=R.Bottom-R.Top-2*FSize;

        tmpItemSize:=tmpSize/Num;
        ThumbSize:=Math.Max(FMinSize,Round(CurrentCount*tmpItemSize));

        if Self.FHorizontal then
           ThumbBegin:=R.Left
        else
           ThumbBegin:=R.Top;

        Inc(ThumbBegin,FSize+Round(Position*tmpItemSize));
        ThumbEnd:=ThumbBegin+ThumbSize+1;

        tmpR:=ThumbRectangle;
        Rectangle(tmpR);

        if Self.FBevel<>bvNone then
        begin
          Dec(tmpR.Right);
          DrawBevel(ParentChart.Canvas,Self.FBevel,tmpR,1);
        end;
      end;
    end;
  end;
end;

Procedure TTeeScrollBar.ApplyScroll(Delta:Double; ActivateTimer:Boolean);

  Procedure DoChange(const NewValue:Double);
  begin
    Position:=Round(NewValue);
    DoScroll;

    if ActivateTimer and FirstTime and FAutoRepeat then
    begin
      if not Assigned(FTimer) then
      begin
        FTimer:=TTimer.Create(Self);
        FTimer.OnTimer:=DoTimer;
      end;

      FTimer.Interval:=FInitial;
      FTimer.Enabled:=True;
    end;
  end;

begin
  if Delta<0 then
  begin
    Delta:=Math.Max(-Position,Delta);

    if Position>(Delta+1) then
       DoChange(Position+Delta);
  end
  else
  begin
//    Delta:=Math.Min(L.TotalLegendItems-CurrentCount,Delta);

    if (Position+Delta-1)<(TotalCount-CurrentCount) then
       DoChange(Position+Delta);
  end;
end;

Procedure TTeeScrollBar.ProcessClick(const P:TPoint);
var tmp : Integer;
begin
  OldPoint:=P;

  FInThumb:=False;
  FInDec:=False;
  FInInc:=False;

  if ClickedDec(P) then
  begin
    FInDec:=True;
    ApplyScroll(-1,True)
  end
  else
  if ClickedInc(P) then
  begin
    FInInc:=True;
    ApplyScroll(1,True)
  end
  else
  if ClickedThumb(P) then
     FInThumb:=True
  else
  if PointInRect(MainRectangle,P.X,P.Y) then
  begin
    if Horizontal then tmp:=P.X else tmp:=P.Y;
    if tmp<ThumbBegin then
       ApplyScroll(-DeltaMain,True)
    else
    if tmp>ThumbEnd then
       ApplyScroll(DeltaMain,True)
  end;
end;

Function TTeeScrollBar.CalcDelta(A,B:Integer):Double;
var tmpR : TRect;
begin
  if A=B then result:=0
  else
  begin
    tmpR:=ScrollRectangle;
    if Horizontal then
       result:=(TotalCount)/((tmpR.Right-tmpR.Left)/Abs(A-B))
    else
       result:=(TotalCount)/((tmpR.Bottom-tmpR.Top)/Abs(A-B));

    if A<B then result:=-result;
  end;
end;

Procedure TTeeScrollBar.MouseMove(X,Y:Integer);
var tmp : Double;
begin
  if FInThumb then
  begin
    if Horizontal then tmp:=CalcDelta(X,OldPoint.X)
                  else tmp:=CalcDelta(Y,OldPoint.Y);
    if Abs(tmp)>=1 then
    begin
      ApplyScroll(tmp,False);
      OldPoint.X:=X;
      OldPoint.Y:=Y;
    end;
  end;
end;

Procedure TTeeScrollBar.MouseUp;
begin
  FInThumb:=False;
  FInDec:=False;
  FInInc:=False;

  FirstTime:=True;
  if Assigned(FTimer) then FTimer.Enabled:=False;

  Repaint;
end;

Procedure TTeeScrollBar.DoScroll;
begin
  if Assigned(FOnScrolled) then FOnScrolled(Self);
end;

procedure TTeeScrollBar.SetThumbBrush(const Value: TChartBrush);
begin
  FThumbBrush.Assign(Value);
end;

procedure TTeeScrollBar.SetBevel(const Value: TPanelBevel);
begin
  if FBevel<>Value then
  begin
    FBevel:=Value;
    Repaint;
  end;
end;

procedure TTeeScrollBar.ChartEvent(AEvent:TChartToolEvent);
begin
  if AEvent=cteAfterDraw then Draw;
end;

procedure TTeeScrollBar.DoTimer(Sender: TObject);
begin
  ProcessClick(OldPoint);
  if FTimer.Interval>50 then FTimer.Interval:=50;
end;

procedure TTeeScrollBar.SetHorizontal(const Value: Boolean);
begin
  SetBooleanProperty(FHorizontal,Value);
end;

procedure TTeeScrollBar.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case AEvent of
    cmeDown: ProcessClick(TeePoint(X,Y));
    cmeMove: MouseMove(X,Y);
    cmeUp: MouseUp;
  end;
end;

function TTeeScrollBar.CurrentCount: Integer;
begin
  result:=ThumbLength;
end;

function TTeeScrollBar.GetPosition: Integer;
begin
  result:=FPosition;
end;

class function TTeeScrollBar.Description: String;
begin
  result:='Scrollbar';
end;

procedure TTeeScrollBar.SetBackColor(const Value: TColor);
begin
  SetColorProperty(FBackColor,Value);
end;

class function TTeeScrollBar.GetEditorClass: String;
begin
  result:='TScrollBarEditor';
end;

procedure TTeeScrollBar.SetPosition(Value: Integer);
begin
  SetIntegerProperty(FPosition,Value);
  if Assigned(FOnSetPosition) then
     FOnSetPosition(Self,Value);
end;

procedure TTeeScrollBar.SetArrowBrush(const Value: TChartBrush);
begin
  FArrowBrush.Assign(Value);
end;

function TTeeScrollBar.DeltaMain: Integer;
begin
  result:=CurrentCount div 4;
end;

function TTeeScrollBar.ShouldDraw(var R: TRect): Boolean;
begin
  result:=TotalCount>0;
end;

function TTeeScrollBar.TotalCount: Integer;
begin
  result:=Max;
end;

procedure TTeeScrollBar.SetSize(const Value: Integer);
begin
  if FSize<>Value then
  begin
    SetIntegerProperty(FSize,Value);
    if Assigned(FOnChangeSize) then
       FOnChangeSize(Self);
  end;
end;

{ TLegendScrollBar }

function TLegendScrollBar.ShouldDraw(var R:TRect):Boolean;
begin
  L:=TCustomChart(ParentChart).Legend;

  result:= L.Visible and (L.LastValue>-1) and
           ((DrawStyle=dsAlways) or (L.LastValue<L.TotalLegendItems));

  if result then
  begin
    FHorizontal:=not L.Vertical;
    R:=L.ShapeBounds;
  end;
end;

function TLegendScrollBar.TotalCount:Integer;
begin
  if ParentChart.MaxPointsPerPage>0 then
     result:=ParentChart.NumPages
  else
     result:=L.TotalLegendItems+L.FirstValue;
end;

function TLegendScrollBar.CurrentCount:Integer;
begin
  if ParentChart.MaxPointsPerPage>0 then
     result:=1
  else
     result:=L.LastValue-L.FirstValue+1;
end;

function TLegendScrollBar.GetPosition:Integer;
begin
  if ParentChart.MaxPointsPerPage>0 then
     result:=ParentChart.Page-1
  else
     result:=L.FirstValue;
end;

procedure TLegendScrollBar.SetPosition(Value:Integer);
begin
  if ParentChart.MaxPointsPerPage>0 then
     ParentChart.Page:=Value+1
  else
     L.FirstValue:=Value;
end;

procedure TLegendScrollBar.LegendCalcSize(Sender:TCustomChartLegend; var ASize:Integer);
begin
  if Active and ShouldDraw(R) then
     Inc(ASize,Size+1);
end;

type TLegendAccess=class(TCustomChartLegend);

procedure TLegendScrollBar.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if Assigned(ParentChart) then
     TLegendAccess(TCustomChart(ParentChart).Legend).FOnCalcSize:=LegendCalcSize;
end;

class function TLegendScrollBar.Description: String;
begin
  result:=TeeMsg_LegendScrollbar;
end;

function TLegendScrollBar.DeltaMain: Integer;
begin
  if ParentChart.MaxPointsPerPage>0 then
     result:=1
  else
     result:=inherited DeltaMain;
end;

{ TScrollbarEditor }

procedure TScrollbarEditor.FormShow(Sender: TObject);
begin
  TeeScroll:=TTeeScrollBar(Tag);

  if Assigned(TeeScroll) then
  begin
    ButtonPen1.LinkPen(TeeScroll.Pen);
    ComboBox1.ItemIndex:=Ord(TeeScroll.Bevel);
    CBAuto.Checked:=TeeScroll.AutoRepeat;
    UpDown1.Position:=TeeScroll.Size;
    UpDown2.Position:=TeeScroll.InitialDelay;
    ButtonColor1.LinkProperty(TeeScroll,'BackColor');
  end;
end;

procedure TScrollbarEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.ThumbBrush)
end;

procedure TScrollbarEditor.Button2Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.Brush)
end;

procedure TScrollbarEditor.ComboBox1Change(Sender: TObject);
begin
  TeeScroll.Bevel:=TPanelBevel(ComboBox1.ItemIndex);
end;

procedure TScrollbarEditor.CBAutoClick(Sender: TObject);
begin
  TeeScroll.AutoRepeat:=CBAuto.Checked;
end;

procedure TScrollbarEditor.Edit1Change(Sender: TObject);
begin
  if Assigned(TeeScroll) then
     TeeScroll.Size:=UpDown1.Position;
end;

procedure TScrollbarEditor.Button3Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.ArrowBrush)
end;

procedure TScrollbarEditor.Edit2Change(Sender: TObject);
begin
  if Assigned(TeeScroll) then
     TeeScroll.InitialDelay:=UpDown2.Position;
end;

procedure TTeeScrollBar.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  Repaint;
end;

procedure TTeeScrollBar.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TScrollbarEditor.Button4Click(Sender: TObject);
begin
  EditTeeGradient(Self,TeeScroll.Gradient)
end;

procedure TTeeScrollBar.SetMinSize(const Value: Integer);
begin
  SetIntegerProperty(FMinSize,Value);
end;

initialization
  RegisterClass(TScrollbarEditor);
  RegisterTeeTools([TLegendScrollBar]);
finalization
  UnRegisterTeeTools([TLegendScrollBar]);
end.
