{******************************************}
{ TeeChart Statistical Functions           }
{ Copyright (c) 2001-2004 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit StatChar;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF CLX}
     Types,
     {$ENDIF}
     {$IFDEF CLR}
     Types,
     {$ENDIF}
     Classes, TeEngine, Series, TeCanvas, CandleCh;

Type
  { Moving Average, Weigted, WeightedIndex }
  TMovingAverageFunction=class(TTeeMovingFunction)
  private
    FWeighted      : Boolean;
    FWeightedIndex : Boolean;
    Procedure SetWeighted(Value:Boolean);
    procedure SetWeightedIndex(const Value: Boolean);
  protected
    class function GetEditorClass: String; override;
  public
    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  published
    property Weighted:Boolean read FWeighted write SetWeighted default False;
    property WeightedIndex:Boolean read FWeightedIndex write SetWeightedIndex default False;
  end;

  { Exponential Moving Average }
  TExpMovAveFunction=class(TTeeFunction)
  public
    Constructor Create(AOwner:TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  end;

  { Exponential Average }
  TExpAverageFunction = class(TTeeMovingFunction)
  private
    FWeight : Double;
    Procedure SetWeight(Const Value:Double);
  protected
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  published
    property Weight:Double read FWeight write SetWeight;
  end;

  { Momemtum }
  TMomentumFunction=class(TTeeMovingFunction)
  public
    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  end;

  { Momemtum Divisor }
  TMomentumDivFunction=class(TTeeMovingFunction)
  public
    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  end;

  { RMS, Root Mean Square }
  TRMSFunction = class(TTeeFunction)
  private
    FComplete  : Boolean;

    INumPoints : Integer;
    ISum2      : Double;
    Procedure Accumulate(Const Value: Double);
    Function  CalculateRMS: Double;
    Procedure SetComplete(const Value: Boolean);
  protected
    class function GetEditorClass: String; override;
  public
    Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
    Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
  published
    property Complete: Boolean read FComplete write SetComplete default False;
  end;

  // Standard Deviation, Complete
  TStdDeviationFunction=class(TTeeFunction)
  private
    FComplete : Boolean;
    ISum      : Double;
    ISum2     : Double;
    INumPoints: Integer;
    Procedure Accumulate(Const Value:Double);
    Function CalculateDeviation:Double;
    Procedure SetComplete(Value:Boolean);
  protected
    class function GetEditorClass: String; override;
  public
    Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
    Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
  published
    property Complete:Boolean read FComplete write SetComplete default False;
  end;

  { MACD, Moving Average Convergence }
  TMACDFunction=class(TTeeMovingFunction)
  private
    IHisto   : TVolumeSeries;
    IMoving1 : TExpMovAveFunction;
    IMoving2 : TExpMovAveFunction;
    IOther   : TFastLineSeries;
    ISeries1 : TChartSeries;
    ISeries2 : TChartSeries;

    function GetHistoPen: TChartPen;
    function GetMACDExpPen: TChartPen;
    function GetPeriod2: Double;
    function GetPeriod3:Integer;
    procedure SetHistoPen(const Value: TChartPen);
    procedure SetMACDExpPen(const Value: TChartPen);
    procedure SetPeriod2(const Value:Double);
    procedure SetPeriod3(Const Value:Integer);
    function GetMACDPen: TChartPen;
    procedure SetMACDPen(const Value: TChartPen);
  protected
    procedure Clear; override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure AddPoints(Source: TChartSeries); override;

    property MACDExp:TFastLineSeries read IOther; { 5.02 }
    property Histogram:TVolumeSeries read IHisto; { 5.02 }
  published
    property HistogramPen:TChartPen read GetHistoPen write SetHistoPen;
    property MACDPen:TChartPen read GetMACDPen write SetMACDPen;
    property MACDExpPen:TChartPen read GetMACDExpPen write SetMACDExpPen;
    property Period2:Double read GetPeriod2 write SetPeriod2;
    property Period3:Integer read GetPeriod3 write SetPeriod3 default 9;
  end;

  { Stochastic }
  TStochasticFunction=class(TTeeMovingFunction)
  protected
    FNums : Array of Double;
    FDens : Array of Double;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure AddPoints(Source: TChartSeries); override;
    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  end;

  { Histogram Series }
  THistogramSeries=class(TCustomLineSeries)
  private
    FLinesPen     : TChartHiddenPen;
    FTransparency : TTeeTransparency;

    IPrevious : Integer;
    Procedure InternalCalcHoriz(Axis:TChartAxis; Var Min,Max:Integer);
    procedure SetLinesPen(const Value: TChartHiddenPen);
    procedure SetTransparency(Const Value:TTeeTransparency);
    Function VisiblePoints:Integer;
  protected
    function CalcRect(ValueIndex:Integer):TRect; virtual;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure CalcFirstLastVisibleIndex; override;
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function Clicked(x,y:Integer):Integer; override;
  published
    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property HorizAxis;
    property LinePen;
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

    property Brush;
    property LinesPen:TChartHiddenPen read FLinesPen write SetLinesPen;
    property Pen;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property XValues;
    property YValues;
  end;

  THorizHistogramSeries=class(THistogramSeries)  // 7.0
  protected
    function CalcRect(ValueIndex:Integer):TRect; override;
  public
    Constructor Create(AOwner: TComponent); override;
  end;

  { Financial Bollinger Bands }
  TBollingerFunction=class(TTeeFunction)
  private
    FExponential : Boolean;
    FDeviation   : Double;
    IOther       : TChartSeries;
    procedure SetDeviation(const Value: Double);
    procedure SetExponential(const Value: Boolean);
    function GetLowBandPen: TChartPen;
    procedure SetLowBandPen(const Value: TChartPen);
    function GetUpperBandPen: TChartPen;
    procedure SetUpperBandPen(const Value: TChartPen);
  protected
    procedure Clear; override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    procedure AddPoints(Source:TChartSeries); override;
    property LowBand:TChartSeries read IOther;
  published
    property Deviation:Double read FDeviation write SetDeviation;
    property Exponential:Boolean read FExponential write SetExponential default True;
    property LowBandPen:TChartPen read GetLowBandPen write SetLowBandPen;
    property UpperBandPen:TChartPen read GetUpperBandPen write SetUpperBandPen;
  end;

  { Cross Points }
  TCrossPointsFunction=class(TTeeFunction)
  protected
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  end;

  { Performance }
  TPerformanceFunction=class(TTeeMovingFunction)
  public
    Function Calculate(SourceSeries:TChartSeries;
                       FirstIndex,LastIndex:Integer):Double; override;
  end;

  // Variance
  TVarianceFunction=class(TTeeFunction)  // 6.02
  public
    Function Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double; override;
    Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
  end;

  // Perimeter
  TPerimeterFunction=class(TTeeFunction)
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  end;

implementation

Uses SysUtils,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Math, TeeProcs, TeeConst, TeeProCo, Chart;

{ TMovingAverageFunction }
Procedure TMovingAverageFunction.SetWeighted(Value:Boolean);
begin
  if FWeighted<>Value then
  begin
    FWeighted:=Value;
    Recalculate;
  end;
end;

class function TMovingAverageFunction.GetEditorClass: String;
begin
  result:='TMovAveFuncEditor';
end;

Function TMovingAverageFunction.Calculate( Series:TChartSeries;
                                           FirstIndex,LastIndex:Integer):Double;
var t         : Integer;
    tmpSumX   : Double;
    tmpYValue : Double;
    tmpXValue : Double;
    tmpVList  : TChartValueList;
begin
  result:=0;
  tmpSumX:=0;
  tmpVList:=ValueList(Series);

  for t:=FirstIndex to LastIndex do
  begin
    tmpYValue:=tmpVList.Value[t];
    if FWeighted then
    Begin
      tmpXValue:=Series.XValues.Value[t];
      result:=result+tmpYValue*tmpXValue;
      tmpSumX:=tmpSumX+tmpXValue;
    end
    else
    if FWeightedIndex then
    begin
      tmpXValue:=t-FirstIndex+1;
      result:=result+tmpYValue*tmpXValue;
      tmpSumX:=tmpSumX+tmpXValue;
    end
    else
      result:=result+tmpYValue;
  end;

  if FWeighted or FWeightedIndex then
  begin
    if tmpSumX<>0 then result:=result/tmpSumX else result:=0;
  end
  else result:=result/(LastIndex-FirstIndex+1);
end;

procedure TMovingAverageFunction.SetWeightedIndex(const Value: Boolean);
begin
  if FWeightedIndex<>Value then
  begin
    FWeightedIndex:=Value;
    Recalculate;
  end;
end;

{ TExpAverageFunction }
Constructor TExpAverageFunction.Create(AOwner: TComponent);
Begin
  inherited;
  FWeight:=0.2;
End;

class function TExpAverageFunction.GetEditorClass: String;
begin
  result:='TExpAveFuncEditor';
end;

Procedure TExpAverageFunction.SetWeight(Const Value:Double);
Begin
  if (Value<0) or (Value>1) then
     raise Exception.Create(TeeMsg_ExpAverageWeight);

  if FWeight<>Value then
  begin
    FWeight:=Value;
    Recalculate;
  end;
End;

Function TExpAverageFunction.Calculate( Series:TChartSeries;
                                        FirstIndex,LastIndex:Integer):Double;
Begin
  With ValueList(Series) do
  begin
    result:=Value[LastIndex];
    if LastIndex>0 then result:=Value[LastIndex-1]*(1.0-Weight)+result*Weight;
  end;
end;

{ Momentum }
Function TMomentumFunction.Calculate( Series:TChartSeries;
                                      FirstIndex,LastIndex:Integer):Double;
Begin
  if FirstIndex=TeeAllValues then
  begin
    FirstIndex:=0;
    LastIndex:=Series.Count-1;
  end;
  With ValueList(Series) do result:=Value[LastIndex]-Value[FirstIndex];
End;

{ MomentumDivision }
Function TMomentumDivFunction.Calculate( Series:TChartSeries;
                                      FirstIndex,LastIndex:Integer):Double;
Begin
  if FirstIndex=TeeAllValues then
  begin
    FirstIndex:=0;
    LastIndex:=Series.Count-1;
  end;
  With ValueList(Series) do
  if Value[FirstIndex]=0 then result:=0
                         else result:=100.0*Value[LastIndex]/Value[FirstIndex];
End;

{ StdDeviation }
Function TStdDeviationFunction.CalculateDeviation:Double;
var Divisor : Double;
begin
  if Complete then Divisor:=Sqr(INumPoints)
              else Divisor:=INumPoints*(INumPoints-1);

  result:=((INumPoints*ISum2) - Sqr(ISum)) / Divisor;
  if result<0 then result:=0
              else result:=Sqrt(result);
end;

Procedure TStdDeviationFunction.Accumulate(Const Value:Double);
begin
  ISum:=ISum+Value;
  ISum2:=ISum2+Sqr(Value);
end;

class function TStdDeviationFunction.GetEditorClass: String;
begin
  result:='TRMSFuncEditor';
end;

Function TStdDeviationFunction.Calculate(SourceSeries:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var t : Integer;
begin
  if FirstIndex=TeeAllValues then
  begin
    FirstIndex:=0;
    INumPoints:=SourceSeries.Count;
    LastIndex:=INumPoints-1;
  end
  else INumPoints:=LastIndex-FirstIndex+1;

  if INumPoints>1 then
  begin
    ISum2:=0;
    ISum:=0;
    With ValueList(SourceSeries) do
    for t:=FirstIndex to LastIndex do Accumulate(Value[t]);
    result:=CalculateDeviation;
  end
  else result:=0;
end;

Function TStdDeviationFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
var t:Integer;
begin
  if SourceSeriesList.Count>0 then
  begin
    INumPoints:=0;
    ISum2:=0;
    ISum:=0;
    for t:=0 to SourceSeriesList.Count-1 do
    begin
      With ValueList(TChartSeries(SourceSeriesList[t])) do
      if Count>ValueIndex then
      begin
        Accumulate(Value[ValueIndex]);
        Inc(INumPoints);
      end;
    end;

    if INumPoints>1 then result:=CalculateDeviation
                    else result:=0;
  end
  else result:=0;
end;

Procedure TStdDeviationFunction.SetComplete(Value:Boolean);
begin
  if FComplete<>Value then
  begin
    FComplete:=Value;
    Recalculate;
  end;
end;

{ THistogramSeries }
Constructor THistogramSeries.Create(AOwner: TComponent);
begin
  inherited;
  FLinesPen:=TChartHiddenPen.Create(CanvasChanged);
end;

Destructor THistogramSeries.Destroy;
begin
  FLinesPen.Free;
  inherited;
end;

Procedure THistogramSeries.CalcFirstLastVisibleIndex;  // 7.0
begin
  inherited;
  if FirstValueIndex>0 then Dec(FFirstVisibleIndex);
  if LastValueIndex<(Count-1) then Inc(FLastVisibleIndex);
end;

procedure THistogramSeries.SetLinesPen(const Value: TChartHiddenPen);
begin
  FLinesPen.Assign(Value);
end;

class Function THistogramSeries.GetEditorClass:String;
begin
  result:='THistogramSeriesEditor';
end;

Function THistogramSeries.VisiblePoints:Integer;
begin
  result:=ParentChart.MaxPointsPerPage;
  if result=0 then result:=Count;
end;

Procedure THistogramSeries.CalcVerticalMargins(Var TopMargin,BottomMargin:Integer);
begin
  inherited;
  if YMandatory then
  begin
    if Pen.Visible then Inc(TopMargin,Pen.Width);
  end
  else InternalCalcHoriz(GetVertAxis,TopMargin,BottomMargin)
end;

Procedure THistogramSeries.InternalCalcHoriz(Axis:TChartAxis; Var Min,Max:Integer);
var tmp : Integer;
begin
  tmp:=VisiblePoints;
  if tmp>0 then tmp:=(Axis.IAxisSize div VisiblePoints) div 2;
  Inc(Min,tmp);
  Inc(Max,tmp);
  if Pen.Visible then Inc(Max,Pen.Width);
end;

Procedure THistogramSeries.CalcHorizMargins(Var LeftMargin,RightMargin:Integer);
begin
  inherited;
  if YMandatory then InternalCalcHoriz(GetHorizAxis,LeftMargin,RightMargin)
                else if Pen.Visible then Inc(RightMargin,Pen.Width);
end;

Procedure THistogramSeries.Assign(Source:TPersistent);
begin
  if Source is THistogramSeries then
  With THistogramSeries(Source) do
  begin
    Self.Pen:=Pen;
    Self.LinesPen:=LinesPen;
    Self.Brush:=Brush;
    Self.FTransparency:=Transparency;
  end;
  inherited;
end;

function THistogramSeries.CalcRect(ValueIndex:Integer):TRect;
var tmp : Integer;
begin
  tmp:=(GetHorizAxis.IAxisSize div VisiblePoints) div 2;

  With result do
  begin
    if ValueIndex=FirstDisplayedIndex then
    begin
      Left:=CalcXPos(ValueIndex)-tmp+1;
      Right:=Left+2*tmp;

      if not DrawValuesForward then
         SwapInteger(Left,Right);
    end
    else
    begin
      Left:=IPrevious;
      if DrawValuesForward then
         Right:=CalcXPos(ValueIndex)+tmp+1
      else
         Right:=CalcXPos(ValueIndex)-tmp-1
    end;

    IPrevious:=Right-1;

    Top:=CalcYPos(ValueIndex);

    With GetVertAxis do
    if Inverted then Bottom:=IStartPos
                else Bottom:=IEndPos;
  end;
end;

procedure THistogramSeries.DrawValue(ValueIndex:Integer);

  Function LastDisplayedIndex:Integer;
  begin
    if DrawValuesForward then result:=LastValueIndex
                         else result:=FirstValueIndex;
  end;

  Procedure VerticalLine(X,Y0,Y1:Integer);
  begin
    if ParentChart.View3D then
       ParentChart.Canvas.VertLine3D(X,Y0,Y1,MiddleZ)
    else
       ParentChart.Canvas.DoVertLine(X,Y0,Y1);
  end;

  Procedure HorizLine(X0,X1,Y:Integer);
  begin
    if ParentChart.View3D then
       ParentChart.Canvas.HorizLine3D(X0,X1,Y,MiddleZ)
    else
       ParentChart.Canvas.DoHorizLine(X0,X1,Y);
  end;

var R        : TRect;
    tmp      : Integer;
    tmpR     : TRect;
    tmpBlend : TTeeBlend;
begin
  R:=CalcRect(ValueIndex);

  With ParentChart.Canvas do
  begin
    Pen.Style:=psClear;

    // rectangle
    if Self.Brush.Style<>bsClear then
    begin
      AssignBrush(Self.Brush,ValueColor[ValueIndex]);

      if GetVertAxis.Inverted then Inc(R.Top);

      if Transparency>0 then
      begin
        if ParentChart.View3D then tmpR:=CalcRect3D(R,MiddleZ)
                              else tmpR:=R;
        tmpBlend:=BeginBlending(tmpR,Transparency);
      end
      else tmpBlend:=nil;

      if ParentChart.View3D then
         RectangleWithZ(TeeRect(R.Left,R.Top,R.Right-1,R.Bottom),MiddleZ)
      else
         Rectangle(R);

      if Transparency>0 then EndBlending(tmpBlend);

      if GetVertAxis.Inverted then Dec(R.Top);
    end;

    // border
    if Self.Pen.Visible then
    begin
      AssignVisiblePen(Self.Pen);

      With R do
      if YMandatory then
      begin
        if ValueIndex=FirstDisplayedIndex then
           VerticalLine(Left,Bottom,Top)
        else
           VerticalLine(Left,Top,CalcYPos(ValueIndex-1));

        HorizLine(Left,Right,Top);
        if ValueIndex=LastDisplayedIndex then
           VerticalLine(Right-1,Top,Bottom);
      end
      else
      begin
        if ValueIndex=FirstDisplayedIndex then
           HorizLine(Left,Right,Bottom-1)
        else
           HorizLine(CalcXPos(ValueIndex-1),Right,Bottom-1);

        VerticalLine(Right-Self.Pen.Width,Top,Bottom);
        if ValueIndex=LastDisplayedIndex then
           HorizLine(Left,Right,Top);
      end
    end;

    // dividing line
    if (ValueIndex<>FirstDisplayedIndex) and LinesPen.Visible then
    begin
      if YMandatory then
      begin
        tmp:=CalcYPos(ValueIndex-1);

        if GetVertAxis.Inverted then
           tmp:=Math.Min(R.Top,tmp)
        else
           tmp:=Math.Max(R.Top,tmp);

        if not Self.Pen.Visible then Dec(tmp);

        AssignVisiblePen(LinesPen);
        VerticalLine(R.Left,R.Bottom,tmp);
      end
      else
      begin
        tmp:=CalcXPos(ValueIndex-1);

        if GetHorizAxis.Inverted then
           tmp:=Math.Min(R.Right,tmp)
        else
           tmp:=Math.Max(R.Left,tmp);

        if not Self.Pen.Visible then Dec(tmp);

        AssignVisiblePen(LinesPen);
        HorizLine(R.Left,tmp,R.Bottom-1);
      end;
    end;
  end;
end;

procedure THistogramSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if Value<>FTransparency then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

class procedure THistogramSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Hollow);
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_Lines);
  AddSubChart(TeeMsg_Transparency); { 5.02 }
end;

class procedure THistogramSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with THistogramSeries(ASeries) do
  Case Index of
    1: Brush.Style:=bsClear;
    2: Pen.Hide;
    3: LinesPen.Visible:=True;
    4: Transparency:=30;
  else inherited;
  end;
end;

function THistogramSeries.Clicked(x, y: Integer): Integer;
var t : Integer;
    R : TRect;
begin
  result:=TeeNoPointClicked;

  if (FirstValueIndex<>-1) and (LastValueIndex<>-1) then  // 7.0
  begin
    if Assigned(ParentChart) then ParentChart.Canvas.Calculate2DPosition(X,Y,MiddleZ);

    for t:=FirstValueIndex to LastValueIndex do
    begin
      R:=CalcRect(t);
      if PointInRect(R,x,y) then
      begin
        result:=t;
        break;
      end;
    end;
  end;
end;

{ THorizHistogramSeries }
Constructor THorizHistogramSeries.Create(AOwner: TComponent);
begin
  inherited;
  SetHorizontal;
  XValues.Order:=loNone;
  YValues.Order:=loAscending;
end;

function THorizHistogramSeries.CalcRect(ValueIndex: Integer): TRect;
var tmp : Integer;
begin
  tmp:=(GetVertAxis.IAxisSize div VisiblePoints) div 2;

  With result do
  begin
    if ValueIndex=FirstDisplayedIndex then
    begin
      Top:=CalcYPos(ValueIndex)-tmp+1;
      Bottom:=Top+2*tmp;
    end
    else
    begin
      Bottom:=IPrevious;
      Top:=CalcYPos(ValueIndex)-tmp;
    end;

    IPrevious:=Top+1;

    Right:=CalcXPos(ValueIndex)+1;

    With GetHorizAxis do
    if Inverted then Left:=IEndPos
                else Left:=IStartPos;
  end;
end;

{ TStochasticFunction }
constructor TStochasticFunction.Create(AOwner: TComponent);
begin
  inherited;
  SingleSource:=True;
  HideSourceList:=True;
end;

Destructor TStochasticFunction.Destroy;
begin
  FNums:=nil;
  FDens:=nil;
  inherited;
end;

procedure TStochasticFunction.AddPoints(Source: TChartSeries);
begin
  FNums:=nil;
  FDens:=nil;
  SetLength(FNums,Source.Count);
  SetLength(FDens,Source.Count);
  inherited;
end;

function TStochasticFunction.Calculate(Series: TChartSeries; FirstIndex,
  LastIndex: Integer): Double;
var Lows    : TChartValueList;
    Highs   : TChartValueList;
    tmpLow  : Double;
    tmpHigh : Double;
    t       : Integer;
begin
  result:=0;
  With Series do
  Begin
    Lows   :=GetYValueList(TeeMsg_ValuesLow);
    Highs  :=GetYValueList(TeeMsg_ValuesHigh);
    tmpLow :=Lows.Value[FirstIndex];
    tmpHigh:=Highs.Value[FirstIndex];

    for t:=FirstIndex to LastIndex do
    begin
      if Lows.Value[t] <tmpLow  then tmpLow :=Lows.Value[t];
      if Highs.Value[t]>tmpHigh then tmpHigh:=Highs.Value[t];
    end;

    FNums[LastIndex]:=ValueList(Series).Value[LastIndex]-tmpLow;
    FDens[LastIndex]:=tmpHigh-tmpLow;
    if tmpHigh<>tmpLow then result:=100.0*(FNums[LastIndex]/FDens[LastIndex]);
  end;
end;

{ TRMSFunction }
class function TRMSFunction.GetEditorClass: String;
begin
  result:='TRMSFuncEditor';
end;

procedure TRMSFunction.Accumulate(const Value: Double);
begin
  ISum2:=ISum2+Sqr(Value);
end;

function TRMSFunction.Calculate(SourceSeries: TChartSeries; FirstIndex,
  LastIndex: Integer): Double;
var t : Integer;
begin
  if FirstIndex=TeeAllValues then
  begin
    FirstIndex:=0;
    INumPoints:=SourceSeries.Count;
    LastIndex:=INumPoints-1;
  end
  else INumPoints:=LastIndex-FirstIndex+1;

  if INumPoints>1 then
  begin
    ISum2:=0;
    With ValueList(SourceSeries) do
    for t:=FirstIndex to LastIndex do Accumulate(Value[t]);
    result:=CalculateRMS;
  end
  else result:=0;
end;

function TRMSFunction.CalculateMany(SourceSeriesList: TList;
  ValueIndex: Integer): Double;
var t:Integer;
begin
  if SourceSeriesList.Count>0 then
  begin
    INumPoints:=0;
    ISum2:=0;
    for t:=0 to SourceSeriesList.Count-1 do
    begin
      With ValueList(TChartSeries(SourceSeriesList[t])) do
      if Count>ValueIndex then
      begin
        Accumulate(Value[ValueIndex]);
        Inc(INumPoints);
      end;
    end;
    if INumPoints>1 then result:=CalculateRMS
                    else result:=0;
  end
  else result:=0;
end;

function TRMSFunction.CalculateRMS: Double;
Var Divisor : Double;
begin
  if Complete then Divisor:=INumPoints
              else Divisor:=INumPoints-1;
  { safeguard against only one point }
  if Divisor=0 then result:=0
               else result:=Sqrt(ISum2 / Divisor );
end;

procedure TRMSFunction.SetComplete(const Value: Boolean);
begin
  if FComplete<>Value then
  begin
    FComplete:=Value;
    Recalculate;
  end;
end;

{ TMACDFunction }

type TChartSeriesAccess=class(TChartSeries);

Constructor TMACDFunction.Create(AOwner: TComponent);

  Procedure HideSeries(ASeries:TChartSeries);
  begin
    ASeries.ShowInLegend:=False;
    TChartSeriesAccess(ASeries).InternalUse:=True;
  end;

begin
  inherited;
  SingleSource:=True;

  IMoving1:=TExpMovAveFunction.Create(nil);
  IMoving1.Period:=12;
  ISeries1:=TChartSeries.Create(nil);
  ISeries1.SetFunction(IMoving1);
  IMoving2:=TExpMovAveFunction.Create(nil);
  IMoving2.Period:=26;
  ISeries2:=TChartSeries.Create(nil);
  ISeries2.SetFunction(IMoving2);
  Period:=IMoving2.Period;

  IOther:=TFastLineSeries.Create(Self);
  HideSeries(IOther);
  IOther.SetFunction(TExpMovAveFunction.Create(nil));
  IOther.FunctionType.Period:=9;
  IOther.SeriesColor:=clGreen;

  IHisto:=TVolumeSeries.Create(Self);
  HideSeries(IHisto);
  IHisto.SeriesColor:=clRed;
  IHisto.UseYOrigin:=True;
  IHisto.YOrigin:=0;
end;

destructor TMACDFunction.Destroy;
begin
  ISeries1.Free;
  ISeries2.Free;
  inherited;
end;

class function TMACDFunction.GetEditorClass: String;
begin
  result:='TMACDFuncEditor';
end;

procedure TMACDFunction.AddPoints(Source: TChartSeries);

  Procedure PrepareSeries(ASeries:TChartSeries);
  begin { copy properties from "ParentSeries" to ASeries }
    With ASeries do
    begin
      ParentChart     :=ParentSeries.ParentChart;
      CustomVertAxis  :=ParentSeries.CustomVertAxis;
      VertAxis        :=ParentSeries.VertAxis;
      XValues.DateTime:=ParentSeries.XValues.DateTime;
      AfterDrawValues :=ParentSeries.AfterDrawValues;
      BeforeDrawValues:=ParentSeries.BeforeDrawValues;
    end;
  end;

var t : Integer;
begin
  { calculate first line... }
  ParentSeries.Clear;

  With Source do
  if Count>1 then
  begin
    IMoving1.AddPoints(Source);
    IMoving2.Period:=Self.Period;
    IMoving2.AddPoints(Source);
    for t:=0 to Count-1 do
        ParentSeries.AddXY(XValues.Value[t],
                           ISeries1.YValues.Value[t]-ISeries2.YValues.Value[t]);
    ISeries1.Clear;
    ISeries2.Clear;
  end;

  // Calculate "MACDExp" second line, even if not visible.
  PrepareSeries(IOther);
  if ParentSeries.SeriesColor=clWhite then ParentSeries.SeriesColor:=clBlue;
  IOther.DataSource:=nil;
  IOther.DataSource:=ParentSeries;

  { calculate Histogram if Active... }
  if IHisto.Active then
  begin
    PrepareSeries(IHisto);
    IHisto.BeginUpdate;
    IHisto.Clear;
    With IOther do
    for t:=0 to Count-1 do
        IHisto.AddXY(IOther.XValues.Value[t],
                     ParentSeries.YValues.Value[t]-IOther.YValues.Value[t]);
    IHisto.EndUpdate;
  end;
end;

function TMACDFunction.GetPeriod2: Double;
begin
  result:=IMoving1.Period
end;

procedure TMACDFunction.SetPeriod2(const Value: Double);
begin
  if IMoving1.Period<>Value then
  begin
    IMoving1.Period:=Value;
    if IMoving1.Period<1 then IMoving1.Period:=1;
    Recalculate;
  end;
end;

function TMACDFunction.GetPeriod3: Integer;
begin
  result:=Round(IOther.FunctionType.Period);
end;

procedure TMACDFunction.SetPeriod3(const Value: Integer);
begin
  IOther.FunctionType.Period:=Value;
end;

function TMACDFunction.GetHistoPen: TChartPen;
begin
  result:=Histogram.Pen;
end;

function TMACDFunction.GetMACDExpPen: TChartPen;
begin
  result:=MACDExp.Pen;
end;

procedure TMACDFunction.SetHistoPen(const Value: TChartPen);
begin
  Histogram.Pen:=Value;
end;

procedure TMACDFunction.SetMACDExpPen(const Value: TChartPen);
begin
  MACDExp.Pen:=Value;
end;

function TMACDFunction.GetMACDPen: TChartPen;
begin
  result:=ParentSeries.Pen;
end;

procedure TMACDFunction.SetMACDPen(const Value: TChartPen);
begin
  ParentSeries.Pen:=Value;
end;

procedure TMACDFunction.Clear;
begin
  inherited;
  IOther.Clear;
  IHisto.Clear;
end;

{ TExpMovAveFunction }
constructor TExpMovAveFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
  InternalSetPeriod(10);
end;

procedure TExpMovAveFunction.AddPoints(Source: TChartSeries);
var tmpV : TChartValueList;
    Old  : Double;
    t    : Integer;
    tmp  : Double;
begin
  ParentSeries.Clear;

  if Period>0 then
  With Source do
  if Count>1 then
  begin
    tmpV:=ValueList(Source);
    tmp:=2/(Self.Period+1);
    Old:=tmpV.Value[0];
    ParentSeries.AddXY(NotMandatoryValueList.Value[0],Old);

    for t:=1 to Count-1 do
    begin
      Old:=(tmpV.Value[t]*tmp)+(Old*(1-tmp));
      ParentSeries.AddXY(NotMandatoryValueList.Value[t],Old);
    end;
  end;
end;

{ TBollingerFunction }
constructor TBollingerFunction.Create(AOwner: TComponent);
begin
  inherited;
  SingleSource:=True;
  Exponential:=True;
  Deviation:=2;
  IOther:=TFastLineSeries.Create(Self);
  IOther.ShowInLegend:=False;
  TChartSeriesAccess(IOther).InternalUse:=True;
  InternalSetPeriod(10);
end;

class function TBollingerFunction.GetEditorClass: String;
begin
  result:='TBollingerFuncEditor';
end;

procedure TBollingerFunction.AddPoints(Source:TChartSeries);
Var AList : TChartValueList;

  Function StdDev(First,Last:Integer):Double;
  var ISum  : Double;
      ISum2 : Double;
      tmp   : Double;
      t     : Integer;
  begin
    ISum:=0;
    ISum2:=0;
    for t:=First to Last do
    begin
      tmp:=AList.Value[t];
      ISum:=ISum+tmp;
      ISum2:=ISum2+Sqr(tmp);
    end;
    ISum:=((Period*ISum2) - Sqr(ISum)) / Sqr(Period);
    if ISum>0 then result:=Sqrt( ISum )
              else result:=0;  { 5.01  Negative square root not allowed }
  end;

  Procedure InternalAddPoints(ASeries:TChartSeries; const ADeviation:Double);
  var Mov       : TTeeFunction;
      tmp       : TChartSeries;
      tmpValue  : Double;
      tmpPeriod : Integer;
      t         : Integer;
      tmpSource : String;
  begin
    if Exponential then Mov:=TExpMovAveFunction.Create(nil)
                   else Mov:=TMovingAverageFunction.Create(nil);
    Mov.Period:=Period;

    tmp:=TChartSeries.Create(nil);
    try
      tmp.ParentChart:=Source.ParentChart;
      tmp.DataSource:=Source;
      tmpSource:=ParentSeries.MandatoryValueList.ValueSource;
      if tmpSource='' then tmpSource:=Source.MandatoryValueList.Name;
      tmp.MandatoryValueList.ValueSource:=tmpSource;
      tmp.SetFunction(Mov);

      ASeries.Clear;
      AList:=Source.GetYValueList(tmpSource);
      tmpPeriod:=Round(Period);
      for t:=tmpPeriod to Source.Count do
      begin
        tmpValue:=(ADeviation*StdDev(t-tmpPeriod,t-1));
        if Exponential then
           tmpValue:=tmp.YValues.Value[t-1]+tmpValue
        else
           tmpValue:=tmp.YValues.Value[t-tmpPeriod]+tmpValue;
        ASeries.AddXY(Source.XValues.Value[t-1],tmpValue);
      end;
      tmp.DataSource:=nil;
    finally
      tmp.Free;
    end;
  end;

begin
  With IOther do
  begin
    ParentChart:=ParentSeries.ParentChart;
    CustomVertAxis:=ParentSeries.CustomVertAxis;
    VertAxis:=ParentSeries.VertAxis;
    SeriesColor:=ParentSeries.SeriesColor;
    if ClassType=ParentSeries.ClassType then
       Pen.Assign(ParentSeries.Pen);
    XValues.DateTime:=ParentSeries.XValues.DateTime;
    AfterDrawValues:=ParentSeries.AfterDrawValues;
    BeforeDrawValues:=ParentSeries.BeforeDrawValues;
  end;

  if Period>0 then  // 5.03
  begin
    InternalAddPoints(ParentSeries,Deviation);
    InternalAddPoints(IOther,-Deviation);
  end;
end;

procedure TBollingerFunction.Clear; // 6.02
begin
  inherited;
  IOther.Clear;
end;

procedure TBollingerFunction.SetDeviation(const Value: Double);
begin
  if FDeviation<>Value then
  begin
    FDeviation:=Value;
    ReCalculate;
  end;
end;

procedure TBollingerFunction.SetExponential(const Value: Boolean);
begin
  if FExponential<>Value then
  begin
    FExponential:=Value;
    ReCalculate;
  end;
end;

destructor TBollingerFunction.Destroy;
begin
  IOther.Free;
  inherited;
end;

function TBollingerFunction.GetLowBandPen: TChartPen;
begin
  result:=LowBand.Pen;
end;

procedure TBollingerFunction.SetLowBandPen(const Value: TChartPen);
begin
  LowBand.Pen:=Value;
end;

function TBollingerFunction.GetUpperBandPen: TChartPen;
begin
  result:=ParentSeries.Pen;
end;

procedure TBollingerFunction.SetUpperBandPen(const Value: TChartPen);
begin
  ParentSeries.Pen:=Value;
end;

{ TCrossPointsFunction }
constructor TCrossPointsFunction.Create(AOwner: TComponent); // 6.0
begin
  inherited;
  CanUsePeriod:=False;
end;

procedure TCrossPointsFunction.AddPoints(Source: TChartSeries);
var tmp1   : TChartValueList;
    tmp2   : TChartValueList;
    tmpX1  : TChartValueList;
    tmpX2  : TChartValueList;

  Function LinesCross(index1,index2:Integer; var x,y:Double):Boolean;
  begin
    result:=CrossingLines(
                tmpX1.Value[index1],tmp1.Value[index1],
                tmpX1.Value[index1+1],tmp1.Value[index1+1],
                tmpX2.Value[index2],tmp2.Value[index2],
                tmpX2.Value[index2+1],tmp2.Value[index2+1],
                x,y
                );
  end;

var index1,
    index2 : Integer;
    x,
    y : Double;
begin
  if ParentSeries.DataSources.Count>1 then
  begin
    Source:=TChartSeries(ParentSeries.DataSources[0]);
    tmp1:=ValueList(Source);
    tmpX1:=Source.NotMandatoryValueList;
    tmp2:=ValueList(TChartSeries(ParentSeries.DataSources[1]));
    tmpX2:=TChartSeries(ParentSeries.DataSources[1]).NotMandatoryValueList;

    ParentSeries.Clear;

    if (tmpX1.Count>1) and (tmpX2.Count>1) then
    begin
      index1:=0;
      index2:=0;

      repeat
        if LinesCross(index1,index2,x,y) then
           ParentSeries.AddXY(x,y);

        if tmpX2.Value[index2+1]<tmpX1.Value[index1+1] then
           Inc(Index2)
        else
           Inc(Index1);

      until (index1>=tmpX1.Count) or (index2>=tmpX2.Count);
    end;
  end;
end;

class function TCrossPointsFunction.GetEditorClass: String;
begin
  result:=''; // no options for this function
end;

{ TPerformanceFunction }
function TPerformanceFunction.Calculate(SourceSeries: TChartSeries;
  FirstIndex, LastIndex: Integer): Double;
begin
  if FirstIndex=TeeAllValues then LastIndex:=SourceSeries.Count-1;
  With ValueList(SourceSeries) do
  if Value[0]<>0 then
  begin
    result:=(Value[LastIndex]-Value[0])*100.0/Value[0];
  end
  else result:=0;
end;


{ TVarianceFunction }
function TVarianceFunction.Calculate(SourceSeries: TChartSeries;
  FirstIndex, LastIndex: Integer): Double;
var tmpCount : Integer;
    tmpMean  : Double;
    tmpSum   : Double;
    t        : Integer;
begin
  if FirstIndex=-1 then FirstIndex:=0;
  if LastIndex=-1 then LastIndex:=SourceSeries.Count-1;

  tmpCount:=LastIndex-FirstIndex+1;

  if tmpCount>0 then
  begin
    if tmpCount=SourceSeries.Count then
       tmpMean:=SourceSeries.MandatoryValueList.Total/tmpCount
    else
    begin
      tmpMean:=0;
      for t:=FirstIndex to LastIndex do
          tmpMean:=tmpMean+SourceSeries.MandatoryValueList.Value[t];
      tmpMean:=tmpMean/tmpCount;
    end;

    tmpSum:=0;
    for t:=FirstIndex to LastIndex do
        tmpSum:=tmpSum+Sqr(SourceSeries.MandatoryValueList.Value[t]-tmpMean);
    result:=tmpSum/tmpCount;
  end
  else result:=0;
end;

function TVarianceFunction.CalculateMany(SourceSeriesList: TList;
  ValueIndex: Integer): Double;
var tmpCount : Integer;
    tmpMean  : Double;
    tmpSum   : Double;
    t        : Integer;
begin
  tmpCount:=SourceSeriesList.Count;

  if tmpCount>0 then
  begin
    tmpMean:=0;
    for t:=0 to tmpCount-1 do
        tmpMean:=tmpMean+TChartSeries(SourceSeriesList[t]).MandatoryValueList.Value[ValueIndex];
    tmpMean:=tmpMean/tmpCount;

    tmpSum:=0;
    for t:=0 to tmpCount-1 do
        tmpSum:=tmpSum+Sqr(TChartSeries(SourceSeriesList[t]).MandatoryValueList.Value[ValueIndex]-tmpMean);
    result:=tmpSum/tmpCount;
  end
  else result:=0;
end;

{ TPerimeterFunction } 
constructor TPerimeterFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
end;

procedure TPerimeterFunction.AddPoints(Source:TChartSeries);
var t : Integer;
    tmp : Integer;
    P : TPointArray;
begin
  ParentSeries.Clear;

  if Source.Count>0 then
  begin
    SetLength(P,Source.Count);
    try
      with Source,ParentChart.Canvas do
      begin
        if (GetHorizAxis.IAxisSize=0) or (GetVertAxis.IAxisSize=0) then
           ParentChart.Draw;

        for t:=0 to Count-1 do
            P[t]:=Calculate3DPosition(CalcXPos(t),CalcYPos(t),MiddleZ);

        ConvexHull(P);
      end;

      with ParentSeries do
      begin
        XValues.Order:=loNone;

        tmp:=Length(P);
        for t:=0 to tmp-1 do
            AddXY(XScreenToValue(P[t].X),YScreenToValue(P[t].Y));

        if tmp>0 then
            AddXY(XValues[0],YValues[0]);
      end;
    finally
      P:=nil;
    end;
  end;
end;

initialization
  RegisterTeeFunction( TMovingAverageFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionMovingAverage,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
  RegisterTeeFunction( TExpMovAveFunction,     {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionExpMovAve,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
  RegisterTeeFunction( TExpAverageFunction,    {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionExpAverage,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TMomentumFunction,      {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionMomentum,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial  );
  RegisterTeeFunction( TMomentumDivFunction,   {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionMomentumDiv,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial  );
  RegisterTeeFunction( TStdDeviationFunction,  {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionStdDeviation,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended  );
  RegisterTeeFunction( TRMSFunction,           {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionRMS,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TMACDFunction,          {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionMACD,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial  );
  RegisterTeeFunction( TStochasticFunction,    {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionStochastic,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial  );
  RegisterTeeFunction( TBollingerFunction,     {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionBollinger,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
  RegisterTeeFunction( TCrossPointsFunction,   {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCross,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TPerformanceFunction,   {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionPerf,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TVarianceFunction,      {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionVariance,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TPerimeterFunction,     {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionPerimeter,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );

  RegisterTeeSeries( THistogramSeries,         {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHistogram,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1 );
  RegisterTeeSeries( THorizHistogramSeries,    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHorizHistogram,
                                               {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1 );
finalization
  UnRegisterTeeFunctions([ TMovingAverageFunction,
                           TExpMovAveFunction,
                           TExpAverageFunction,
                           TMomentumFunction,
                           TMomentumDivFunction,
                           TStdDeviationFunction,
                           TRMSFunction,
                           TMACDFunction,
                           TStochasticFunction,
                           TBollingerFunction,
                           TCrossPointsFunction,
                           TPerformanceFunction,
                           TVarianceFunction,
                           TPerimeterFunction ]);

  UnRegisterTeeSeries([THistogramSeries, THorizHistogramSeries]);
end.
