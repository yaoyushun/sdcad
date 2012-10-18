{*****************************************}
{   TeeChart Pro                          }
{   TPoint3DSeries                        }
{   Copyright (c) 1995-2004 David Berneda }
{*****************************************}
unit TeePoin3;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, TeeSurfa, Series, TeCanvas;

type
  TPoint3DSeries=class;

  TSeriesClickPointer3DEvent=Procedure( Sender:TPoint3DSeries;
                                        ValueIndex:Integer;
                                        X, Y: Integer) of object;

  TPoint3DSeries = class(TCustom3DSeries)
  private
    FBaseLine  : TChartHiddenPen;
    FDepthSize : Double;
    FPointer   : TSeriesPointer;

    { events }
    FOnClickPointer    : TSeriesClickPointer3DEvent;
    FOnGetPointerStyle : TOnGetPointerStyle;

    { internal }
    IOldX     : Integer;
    IOldY     : Integer;
    IOldZ     : Integer;

    Function GetLinePen:TChartPen;
    procedure SetBaseLine(const Value: TChartHiddenPen);
    Procedure SetDepthSize(Const Value:Double);
    Procedure SetPointer(Value:TSeriesPointer);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    Procedure CalcZPositions(ValueIndex:Integer); virtual;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure DrawValue(ValueIndex:Integer); override;  // 7.0 moved from public
    Function GetDepthSize(ValueIndex:Integer):Integer; virtual;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
    class Function SubGalleryStyles:Boolean; virtual;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function Clicked(x,y:Integer):Integer; override;
    Function MaxZValue:Double; override;
  published
    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;

    property BaseLine:TChartHiddenPen read FBaseLine write SetBaseLine; // 6.02
    property DepthSize:Double read FDepthSize write SetDepthSize;
    property LinePen:TChartPen read GetLinePen write SetPen;
    property Pointer:TSeriesPointer read FPointer write SetPointer;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property OnClickPointer:TSeriesClickPointer3DEvent read FOnClickPointer
                                                       write FOnClickPointer;
    property OnGetPointerStyle:TOnGetPointerStyle read FOnGetPointerStyle
                                                  write FOnGetPointerStyle;
  end;

  TBubble3DSeries = class(TPoint3DSeries)
  private
    FRadiusValues : TChartValueList; { <-- Bubble's radius storage }
    Function ApplyRadius( Const Value:Double;
                          AList:TChartValueList;
                          Increment:Boolean):Double;
    Procedure SetRadiusValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override; { <-- to add random radius values }
    Procedure CalcZPositions(ValueIndex:Integer); override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    Function GetDepthSize(ValueIndex:Integer):Integer; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Function SubGalleryStyles:Boolean; override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function AddBubble(Const AX,AY,AZ,ARadius:Double; Const AXLabel:String='';
                       AColor:TColor=clTeeColor):Integer;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;

    Function MaxYValue:Double; override;  // adds radius
    Function MinYValue:Double; override;  // substracts radius
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
  published
    property ColorEachPoint default True;
    property RadiusValues:TChartValueList read FRadiusValues write SetRadiusValues;
  end;

implementation

Uses Math, Chart, TeeConst, TeeProCo;

{ TPoint3DSeries }
Constructor TPoint3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  FPointer:=TSeriesPointer.Create(Self);
  FBaseLine:=TChartHiddenPen.Create(CanvasChanged);
end;

Destructor TPoint3DSeries.Destroy;
begin
  FBaseLine.Free;
  FPointer.Free;
  inherited;
end;

class Function TPoint3DSeries.SubGalleryStyles:Boolean;
begin
  result:=True;
end;

Procedure TPoint3DSeries.SetPointer(Value:TSeriesPointer);
Begin
  FPointer.Assign(Value);
end;

Procedure TPoint3DSeries.CalcZPositions(ValueIndex:Integer);
var tmp : Integer;
begin
  // do not call inherited here
  MiddleZ:=CalcZPos(ValueIndex);
  tmp:=Math.Max(1,GetDepthSize(ValueIndex));
  StartZ:=MiddleZ-tmp;
  EndZ:=MiddleZ+tmp;
end;

Function TPoint3DSeries.GetLinePen:TChartPen;
begin
  result:=Pen;
end;

type TPointerAccess=class(TSeriesPointer);

Procedure TPoint3DSeries.CalcHorizMargins(Var LeftMargin,RightMargin:Integer);
begin
  inherited;
  TPointerAccess(FPointer).CalcHorizMargins(LeftMargin,RightMargin);
end;

Procedure TPoint3DSeries.CalcVerticalMargins(Var TopMargin,BottomMargin:Integer);
begin
  inherited;
  TPointerAccess(FPointer).CalcVerticalMargins(TopMargin,BottomMargin);
end;

Procedure TPoint3DSeries.DrawValue(ValueIndex:Integer);
var tmpColor : TColor;
    tmpStyle : TSeriesPointerStyle;
    tmpX     : Integer;
    tmpY     : Integer;
    tmpZ     : Integer;
    tmpFirst : Integer;
begin
  tmpColor:=ValueColor[ValueIndex];

  if tmpColor<clNone then // 7.0
  begin
    CalcZPositions(ValueIndex);

    With Pointer do
    begin
      tmpX:=CalcXPos(ValueIndex);
      tmpY:=CalcYPos(ValueIndex);

      if Visible then
      begin { emulate TCustomSeries.DrawPointer method }

        PrepareCanvas(ParentChart.Canvas,tmpColor);
        if Assigned(FOnGetPointerStyle) then
           tmpStyle:=FOnGetPointerStyle(Self,ValueIndex)
        else
           tmpStyle:=FPointer.Style;

        DrawPointer( ParentChart.Canvas,ParentChart.View3D,
                     tmpX,tmpY,HorizSize,VertSize,tmpColor,tmpStyle);
      end;

      if BaseLine.Visible then
      begin
        tmpZ:=CalcZPos(ValueIndex);
        ParentChart.Canvas.AssignVisiblePen(BaseLine);
        ParentChart.Canvas.MoveTo3D(tmpX,tmpY+VertSize,tmpZ);
        ParentChart.Canvas.LineTo3D(tmpX,GetVertAxis.IEndPos,tmpZ);
      end;

      tmpFirst:=FirstDisplayedIndex; // Problem when ValueColor[First] is clNone (null point)

      if (ValueIndex<>tmpFirst) and LinePen.Visible then
      With ParentChart.Canvas do
      begin
        AssignVisiblePen(LinePen);
        BackMode:=cbmTransparent;
        MoveTo3D(IOldX,IOldY,IOldZ);
        LineTo3D(tmpX,tmpY,MiddleZ);
      end;

      IOldX:=tmpX;
      IOldY:=tmpY;
      IOldZ:=MiddleZ;
    end;
  end;
end;

Procedure TPoint3DSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmpColor : TColor;
begin
  if FPointer.Visible then
  begin
    if ValueIndex=TeeAllValues then tmpColor:=SeriesColor
                               else tmpColor:=ValueColor[ValueIndex];
    TeePointerDrawLegend(Pointer,tmpColor,Rect,LinePen.Visible);
  end
  else inherited;
end;

Procedure TPoint3DSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t : Integer;
Begin
  for t:=1 to NumValues do
    AddXYZ( RandomValue(100), RandomValue(100), RandomValue(100));
end;

Procedure TPoint3DSeries.SetDepthSize(Const Value:Double);
begin
  SetDoubleProperty(FDepthSize,Value);
end;

Function TPoint3DSeries.MaxZValue:Double;
begin
  result:=ZValues.MaxValue+FDepthSize;
end;

Procedure TPoint3DSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                   APosition:TSeriesMarkPosition);
begin
  CalcZPositions(ValueIndex);
  if FPointer.Visible then Marks.ZPosition:=MiddleZ
                      else Marks.ZPosition:=StartZ;
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

Procedure TPoint3DSeries.Assign(Source:TPersistent);
begin
  if Source is TPoint3DSeries then
  With TPoint3DSeries(Source) do
  begin
    Self.Pointer   :=FPointer;
    Self.FDepthSize:=FDepthSize;
    Self.BaseLine  :=BaseLine;
  end;
  inherited;
end;

class Function TPoint3DSeries.GetEditorClass:String;
Begin
  result:='TPoint3DSeriesEditor'; { <-- dont translate ! }
end;

Procedure TPoint3DSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  LinePen.Color:=clNavy;
  ParentChart.View3DOptions.Zoom:=60;
end;

Function TPoint3DSeries.Clicked(x,y:Integer):Integer;
var t    : Integer;
    tmpX : Integer;
    tmpY : Integer;
    OldX : Integer;
    OldY : Integer;
begin
  OldX:=X;
  OldY:=Y;
  result:=inherited Clicked(x,y);

  if result=TeeNoPointClicked then
  if FPointer.Visible then
  for t:=0 to Count-1  do
  begin
    tmpX:=CalcXPos(t);
    tmpY:=CalcYPos(t);
    X:=OldX;
    Y:=OldY;

    if Assigned(ParentChart) then
       ParentChart.Canvas.Calculate2DPosition(X,Y,CalcZPos(t));

    if (Abs(tmpX-X)<FPointer.HorizSize) and { <-- Canvas.Zoom? }
       (Abs(tmpY-Y)<FPointer.VertSize) then
    begin
      if Assigned(FOnClickPointer) then FOnClickPointer(Self,t,OldX,OldY);
      result:=t;
      break;
    end;
  end;
end;

procedure TPoint3DSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if Assigned(Value) then { 5.01 }
     FPointer.ParentChart:=Value;
end;

class procedure TPoint3DSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoPoint);
  AddSubChart(TeeMsg_Lines);
  AddSubChart(TeeMsg_NoLine);
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Marks);
  AddSubChart(TeeMsg_Hollow);
  AddSubChart(TeeMsg_NoBorder);

  if SubGalleryStyles then
  begin
    AddSubChart(TeeMsg_Point2D);
    AddSubChart(TeeMsg_Triangle);
    AddSubChart(TeeMsg_Star);
    AddSubChart(TeeMsg_Circle);
    AddSubChart(TeeMsg_DownTri);
    AddSubChart(TeeMsg_Cross);
    AddSubChart(TeeMsg_Diamond);
  end;
end;

class procedure TPoint3DSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TPoint3DSeries(ASeries) do
  Case Index of
    1: Pointer.Hide;
    2: BaseLine.Visible:=True;
    3: Pen.Hide;
    4: ColorEachPoint:=True;
    5: Marks.Visible:=True;
    6: Pointer.Brush.Style:=bsClear;
    7: Pointer.Pen.Hide;
    8: Pointer.Draw3D:=False;
    9: Pointer.Style:=psTriangle;
   10: Pointer.Style:=psStar;
   11: Pointer.Style:=psCircle;
   12: Pointer.Style:=psDownTriangle;
   13: Pointer.Style:=psCross;
   14: Pointer.Style:=psDiamond;
  else inherited;
  end;
end;

procedure TPoint3DSeries.SetBaseLine(const Value: TChartHiddenPen);
begin
  FBaseLine.Assign(Value);
end;

function TPoint3DSeries.GetDepthSize(ValueIndex: Integer): Integer;
begin
  result:=ParentChart.DepthAxis.CalcSizeValue(FDepthSize) div 2;
end;

{ TBubble3DSeries }
Constructor TBubble3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  FRadiusValues:=TChartValueList.Create(Self,TeeMsg_ValuesBubbleRadius); { <-- radius storage }
  TPointerAccess(Pointer).AllowChangeSize:=False;
  Pointer.Style:=psCircle;
  ColorEachPoint:=True;
  LinePen.Visible:=False;
end;

function TBubble3DSeries.AddBubble(const AX, AY, AZ, ARadius: Double;
  const AXLabel: String; AColor: TColor): Integer;
begin
  RadiusValues.TempValue:=ARadius;
  result:=AddXYZ(AX,AY,AZ,AXLabel,AColor);
end;

procedure TBubble3DSeries.AddSampleValues(NumValues: Integer;
  OnlyMandatory: Boolean);
Var t : Integer;
    s : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do { some sample values to see something in design mode }
  Begin
    AddBubble( tmpX,                { X }
               RandomValue(Round(DifY)), { Y }
               RandomValue(200), { Z }
               (DifY/15.0)+Round(DifY/(10+RandomValue(15)))  { <- Radius }
               );
    tmpX:=tmpX+StepX;
  end;
end;

Function TBubble3DSeries.GetDepthSize(ValueIndex:Integer):Integer;
begin
  result:=ParentChart.DepthAxis.CalcSizeValue(RadiusValues.Value[ValueIndex]);
end;

procedure TBubble3DSeries.DrawValue(ValueIndex: Integer);
var tmpSize : Integer;
begin
  tmpSize:=GetVertAxis.CalcSizeValue(RadiusValues.Value[ValueIndex]);
  TPointerAccess(Pointer).ChangeHorizSize(tmpSize);
  TPointerAccess(Pointer).ChangeVertSize(tmpSize);
  inherited;
end;

function TBubble3DSeries.IsValidSourceOf(Value: TChartSeries): Boolean;
begin // Only 3D Bubbles can be assigned to 3D Bubbles
  result:=Value is TBubble3DSeries;
end;

procedure TBubble3DSeries.SetRadiusValues(Value: TChartValueList);
begin
  SetChartValueList(FRadiusValues,Value);
end;

function TBubble3DSeries.ApplyRadius(const Value: Double;
  AList: TChartValueList; Increment: Boolean): Double;
var t : Integer;
begin
  result:=Value;
  for t:=0 to Count-1 do
  if Increment then
     result:=Math.Max(result,AList.Value[t]+RadiusValues.Value[t])
  else
     result:=Math.Min(result,AList.Value[t]-RadiusValues.Value[t]);
end;

function TBubble3DSeries.MaxYValue: Double;
begin
  result:=ApplyRadius(inherited MaxYValue,YValues,True);
end;

function TBubble3DSeries.MaxZValue: Double;
begin
  result:=ApplyRadius(inherited MaxZValue,ZValues,True);
end;

function TBubble3DSeries.MinYValue: Double;
begin
  result:=ApplyRadius(inherited MinYValue,YValues,False);
end;

function TBubble3DSeries.MinZValue: Double;
begin
  result:=ApplyRadius(inherited MinZValue,ZValues,False);
end;

class Function TBubble3DSeries.SubGalleryStyles:Boolean;
begin
  result:=False;
end;

procedure TBubble3DSeries.CalcZPositions(ValueIndex: Integer);
var tmp : Integer;
begin
  if Pointer.Draw3D and ParentChart.Canvas.SupportsFullRotation then
     inherited
  else
  begin
    StartZ:=CalcZPos(ValueIndex);
    tmp:=Math.Max(1,GetDepthSize(ValueIndex));
    MiddleZ:=StartZ+tmp;
    EndZ:=MiddleZ+tmp;
  end;
end;

procedure TBubble3DSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  Pointer.Gradient.Visible:=True;
end;

initialization
  RegisterTeeSeries(TPoint3DSeries,  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryPoint3D,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries(TBubble3DSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBubble3D,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
finalization
  UnRegisterTeeSeries([TPoint3DSeries,TBubble3DSeries]);
end.
