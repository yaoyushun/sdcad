{**********************************************}
{   TCandleSeries (derived from OHLCSeries)    }
{   TVolumeSeries (derived from TCustomSeries) }
{   TRSIFunction  (Resistance Strength Index)  }
{   TADXFunction                               }
{                                              }
{   Copyright (c) 1995-2004 by David Berneda   }
{**********************************************}
unit CandleCh;
{$I TeeDefs.inc}

interface

{
  Financial TCandleSeries derives from TOHLCSeries (Open, High, Low & Close).
  See OHLChart.pas unit for TOHLCSeries source code.

  TCandleSeries overrides the TChartSeries.DrawValue method to paint its
  points in several financial styles (CandleStick, Bars, OpenClose, etc).

  TVolumeSeries overrides the TChartSeries.DrawValue method to paint
  points as thin vertical bars.

  TADXFunction is a commonly used financial indicator. It requires an
  OHLC (financial) series as the datasource.

  TRSIFunction (Resistence Strength Index) is a commonly used financial
  indicator. It requires an OHLC (financial) series as the datasource.
}
Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Chart, Series, OHLChart, TeEngine, TeCanvas;

Const DefCandleWidth = 4;  { 2 + 1 + 2  Default width for Candle points }

type
  TCandleStyle=(csCandleStick,csCandleBar,csOpenClose,csLine);

  TCandleItem=packed record
    yOpen  : Integer;
    yClose : Integer;
    yHigh  : Integer;
    yLow   : Integer;
    tmpX   : Integer;
    tmpLeftWidth  : Integer;
    tmpRightWidth : Integer;
  end;

  TCandleSeries=class(TOHLCSeries)
  private
    FCandleStyle    : TCandleStyle;
    FCandleWidth    : Integer;
    FDownCloseColor : TColor;
    FHighLowPen     : TChartPen;
    FShowCloseTick  : Boolean;
    FShowOpenTick   : Boolean;
    FUpCloseColor   : TColor;

    OldP            : TPoint;
    procedure CalcItem(ValueIndex:Integer; var AItem:TCandleItem);
    Function GetDark3D:Boolean;
    Function GetDraw3D:Boolean;
    Function GetPen:TChartPen;
    procedure SetCandlePen(Value:TChartPen);
    Procedure SetCandleStyle(Value:TCandleStyle);
    Procedure SetCandleWidth(Value:Integer);
    procedure SetDark3D(Value:Boolean);
    Procedure SetDownColor(Value:TColor);
    procedure SetDraw3D(Value:Boolean);
    Procedure SetShowCloseTick(Value:Boolean);
    Procedure SetShowOpenTick(Value:Boolean);
    Procedure SetUpColor(Value:TColor);
    procedure SetHighLowPen(const Value: TChartPen);
  protected
    Function CalculateColor(ValueIndex:Integer):TColor;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function AddCandle( Const ADate:TDateTime;
                        Const AOpen,AHigh,ALow,AClose:Double):Integer;
    Function Clicked(x,y:Integer):Integer; override;
    function ClickedCandle(ValueIndex:Integer; const P:TPoint):Boolean;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property Depth;
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

    property CandleStyle:TCandleStyle read FCandleStyle write SetCandleStyle
                                      default csCandleStick;
    property CandleWidth:Integer read FCandleWidth write SetCandleWidth
                                 default DefCandleWidth;
    property Draw3D:Boolean read GetDraw3D write SetDraw3D default False;
    property Dark3D:Boolean read GetDark3D write SetDark3D default True;
    property DownCloseColor:TColor read FDownCloseColor write SetDownColor
                                   default clRed;
    property HighLowPen:TChartPen read FHighLowPen write SetHighLowPen;
    property ShowCloseTick:Boolean read FShowCloseTick write SetShowCloseTick
                                   default True;
    property ShowOpenTick:Boolean read FShowOpenTick write SetShowOpenTick
                                  default True;
    property UpCloseColor:TColor read FUpCloseColor write SetUpColor
                                 default clWhite;
    property Pen:TChartPen read GetPen write SetCandlePen;
  end;

  { Used in financial charts for Volume quantities (or OpenInterest) }
  { Overrides FillSampleValues to create random POSITIVE values }
  { Overrides DrawValue to paint a thin vertical bar }
  { Declares VolumeValues (same like YValues) }
  TVolumeSeries=class(TCustomSeries)
  private
    FUseYOrigin: Boolean;

    FOrigin: Double;
    IColor : TColor;
    Function GetVolumeValues:TChartValueList;
    Procedure PrepareCanvas(Forced:Boolean; AColor:TColor);
    procedure SetOrigin(const Value: Double);
    procedure SetUseOrigin(const Value: Boolean);
    Procedure SetVolumeValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle); override;
    Procedure SetSeriesColor(AColor:TColor); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source:TPersistent); override;
    Function NumSampleValues:Integer; override;
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

    property LinePen;
    property UseYOrigin:Boolean read FUseYOrigin write SetUseOrigin default False;
    property VolumeValues:TChartValueList read GetVolumeValues write SetVolumeValues;
    property XValues;
    property YOrigin:Double read FOrigin write SetOrigin;
  end;

  { Financial A.D.X function }
  TADXFunction=class(TTeeFunction)
  private
    IDMDown : TFastLineSeries;
    IDMUp   : TFastLineSeries;
    function GetDownPen: TChartPen;
    function GetUpPen: TChartPen;
    procedure SetDownPen(const Value: TChartPen);
    procedure SetUpPen(const Value: TChartPen);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override; { 5.01 }

    procedure AddPoints(Source:TChartSeries); override;
    property DMDown:TFastLineSeries read IDMDown;
    property DMUp:TFastLineSeries read IDMUp;
  published
    property DownLinePen:TChartPen read GetDownPen write SetDownPen;
    property UpLinePen:TChartPen read GetUpPen write SetUpPen;
  end;

  { RSI, Relative Strentgh Index }
  TRSIStyle=(rsiOpenClose,rsiClose);

  TRSIFunction = class(TTeeMovingFunction)
  private
    FStyle  : TRSIStyle;

    ISeries : TChartSeries;
    Opens   : TChartValueList;
    Closes  : TChartValueList;
    procedure SetStyle(Const Value:TRSIStyle);
  protected
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;

    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  published
    property Style:TRSIStyle read FStyle write SetStyle default rsiOpenClose;
  end;

implementation

Uses {$IFDEF CLR}
     {$ELSE}
     Math, SysUtils,
     {$ENDIF}
     TeeProcs, TeeProCo, TeeConst;

{ TCandleSeries }
Constructor TCandleSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FUpCloseColor  :=clWhite;
  FDownCloseColor:=clRed;
  FCandleWidth   :=DefCandleWidth;
  FCandleStyle   :=csCandleStick;
  FShowOpenTick  :=True;
  FShowCloseTick :=True;
  Pointer.Draw3D :=False;

  FHighLowPen:=TChartPen.Create(CanvasChanged);  // 7.0
  FHighLowPen.Color:=clTeeColor;
end;

Procedure TCandleSeries.SetShowOpenTick(Value:Boolean);
Begin
  SetBooleanProperty(FShowOpenTick,Value);
End;

Procedure TCandleSeries.SetShowCloseTick(Value:Boolean);
Begin
  SetBooleanProperty(FShowCloseTick,Value);
End;

Function TCandleSeries.CalculateColor(ValueIndex:Integer):TColor;
Begin
  result:=ValueColor[ValueIndex];
  if result=SeriesColor then
  begin
    if OpenValues.Value[ValueIndex]>CloseValues.Value[ValueIndex] then { 5.01 }
       result:=FDownCloseColor
    else
    if OpenValues.Value[ValueIndex]<CloseValues.Value[ValueIndex] then
       result:=FUpCloseColor
    else
    Begin
      { color algorithm when open is equal to close }
      if ValueIndex=0 then
         result:=FUpCloseColor  { <-- first point }
      else
      if CloseValues.Value[ValueIndex-1]>CloseValues.Value[ValueIndex] then
         result:=FDownCloseColor
      else
      if CloseValues.Value[ValueIndex-1]<CloseValues.Value[ValueIndex] then
         result:=FUpCloseColor
      else
         result:=ValueColor[ValueIndex-1];
    end;
  end;
end;

procedure TCandleSeries.CalcItem(ValueIndex:Integer; var AItem:TCandleItem);
begin
  with AItem do
  begin
    tmpX:=CalcXPosValue(DateValues.Value[ValueIndex]); { The horizontal position }

    { Vertical positions of Open, High, Low & Close values for this point }
    YOpen :=CalcYPosValue(OpenValues.Value[ValueIndex]);
    YHigh :=CalcYPosValue(HighValues.Value[ValueIndex]);
    YLow  :=CalcYPosValue(LowValues.Value[ValueIndex]);
    YClose:=CalcYPosValue(CloseValues.Value[ValueIndex]);

    tmpLeftWidth:=FCandleWidth div 2; { calc half Candle Width }
    tmpRightWidth:=FCandleWidth-tmpLeftWidth;
  end;
end;

procedure TCandleSeries.DrawValue(ValueIndex:Integer);

  Procedure CheckHighLowPen;
  begin
    with ParentChart.Canvas do
    begin
      if HighLowPen.Color=clTeeColor then
         AssignVisiblePenColor(HighLowPen,Self.Pen.Color)
      else
         AssignVisiblePen(HighLowPen);

      BackMode:=cbmTransparent;
    end;
  end;

var tmpItem   : TCandleItem;
    tmpTop    : Integer;
    tmpBottom : Integer;
    P         : TPoint;
    tmpFirst  : Integer;
begin
  if Assigned(OnGetPointerStyle) then  { 5.02 }
     OnGetPointerStyle(Self,ValueIndex);

  { Prepare Pointer Pen and Brush styles }
  Pointer.PrepareCanvas(ParentChart.Canvas,clTeeColor);

  CalcItem(ValueIndex,tmpItem);

  with tmpItem,ParentChart,Canvas do
  begin
    if (FCandleStyle=csCandleStick) or (FCandleStyle=csOpenClose) then
    begin { draw Candle Stick }

      CheckHighLowPen;

      if View3D and Pointer.Draw3D then
      begin
        tmpTop:=yClose;
        tmpBottom:=yOpen;
        if tmpTop>tmpBottom then SwapInteger(tmpTop,tmpBottom);

        { Draw Candle Vertical Line from bottom to Low }
        if FCandleStyle=csCandleStick then
           VertLine3D(tmpX,tmpBottom,yLow,MiddleZ);

        { Draw 3D Candle }
        Brush.Color:=CalculateColor(ValueIndex);

        if Self.Pen.Visible then
           if yOpen=yClose then AssignVisiblePenColor(Self.Pen,CalculateColor(ValueIndex))
                           else AssignVisiblePen(Self.Pen)
           else
              Pen.Style:=psClear;  // 7.0

        Cube( tmpX-tmpLeftWidth,tmpX+tmpRightWidth,tmpTop,tmpBottom,
              StartZ,EndZ,Pointer.Dark3D);

        CheckHighLowPen;

        { Draw Candle Vertical Line from Top to High }
        if FCandleStyle=csCandleStick then
           VertLine3D(tmpX,tmpTop,yHigh,MiddleZ);
      end
      else
      begin
        { Draw Candle Vertical Line from High to Low }
        if FCandleStyle=csCandleStick then
           if View3D then
              VertLine3D(tmpX,yLow,yHigh,MiddleZ)
           else
              DoVertLine(tmpX,yLow,yHigh);

        { remember that Y coordinates are inverted }

        { prevent zero height rectangles 5.02 }
        { in previous releases, an horizontal line was displayed instead
          of the small candle rectangle }
        if yOpen=yClose then Dec(yClose);

        { draw the candle }
        Brush.Color:=CalculateColor(ValueIndex);

        if Self.Pen.Visible then
           if yOpen=yClose then AssignVisiblePenColor(Self.Pen,CalculateColor(ValueIndex))
                           else AssignVisiblePen(Self.Pen)
           else
              Pen.Style:=psClear;  // 7.0

        if View3D then
           RectangleWithZ(TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth,yClose),
                          MiddleZ)
        else
        begin
          if not Self.Pen.Visible then
             if yOpen<yClose then Dec(yOpen) else Dec(yClose);
          Rectangle(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth+1,yClose);
        end;
      end;
    end
    else
    if FCandleStyle=csLine then  // Line
    begin
      P:=TeePoint(tmpX,YClose);

      tmpFirst:=FirstDisplayedIndex;

      if (ValueIndex<>tmpFirst) and (not IsNull(ValueIndex)) then
      begin
        AssignVisiblePenColor(Self.Pen,CalculateColor(ValueIndex));
        BackMode:=cbmTransparent;
        if View3D then LineWithZ(OldP,P,MiddleZ)
                  else Line(OldP,P);
      end;

      OldP:=P;
    end
    else
    begin // Draw Candle bar
      AssignVisiblePenColor(Self.Pen,CalculateColor(ValueIndex));
      BackMode:=cbmTransparent;

      // Draw Candle Vertical Line from High to Low
      if View3D then
      begin
        VertLine3D(tmpX,yLow,yHigh,MiddleZ);
        if ShowOpenTick then HorizLine3D(tmpX,tmpX-tmpLeftWidth-1,yOpen,MiddleZ);
        if ShowCloseTick then HorizLine3D(tmpX,tmpX+tmpRightWidth+1,yClose,MiddleZ);
      end
      else
      begin // 5.02
        DoVertLine(tmpX,yLow,yHigh);
        if ShowOpenTick then DoHorizLine(tmpX,tmpX-tmpLeftWidth-1,yOpen);
        if ShowCloseTick then DoHorizLine(tmpX,tmpX+tmpRightWidth+1,yClose);
      end;
    end;
  end;
end;

Procedure TCandleSeries.SetUpColor(Value:TColor);
Begin
  SetColorProperty(FUpCloseColor,Value);
end;

Procedure TCandleSeries.SetDownColor(Value:TColor);
Begin
  SetColorProperty(FDownCloseColor,Value);
end;

Procedure TCandleSeries.SetCandleWidth(Value:Integer);
Begin
  SetIntegerProperty(FCandleWidth,Value);
end;

Procedure TCandleSeries.SetCandleStyle(Value:TCandleStyle);
Begin
  if FCandleStyle<>Value then
  begin
    FCandleStyle:=Value;
    Pointer.Visible:=CandleStyle<>csLine;
    Repaint;
  end;
end;

class Function TCandleSeries.GetEditorClass:String;
Begin
  result:='TCandleEditor';  { <-- do not translate }
End;

Procedure TCandleSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  FillSampleValues(4);
  ColorEachPoint:=IsEnabled;

  if IsEnabled then
     UpCloseColor:=clBlue
  else
  begin
    UpCloseColor:=clSilver;
    DownCloseColor:=clDkGray;
    Pointer.Pen.Color:=clGray;
  end;

  Pointer.Pen.Width:=2;
  CandleWidth:=12;
end;

Procedure TCandleSeries.Assign(Source:TPersistent);
begin
  if Source is TCandleSeries then
  With TCandleSeries(Source) do
  begin
    Self.FCandleWidth   :=FCandleWidth;
    Self.FCandleStyle   :=FCandleStyle;
    Self.FUpCloseColor  :=FUpCloseColor;
    Self.FDownCloseColor:=FDownCloseColor;
    Self.HighLowPen     :=FHighLowPen;
    Self.FShowOpenTick  :=FShowOpenTick;
    Self.FShowCloseTick :=FShowCloseTick;
  end;
  inherited;
end;

Function TCandleSeries.GetDraw3D:Boolean;
begin
  result:=Pointer.Draw3D;
end;

procedure TCandleSeries.SetDraw3D(Value:Boolean);
begin
  Pointer.Draw3D:=Value;
end;

Function TCandleSeries.GetDark3D:Boolean;
begin
  result:=Pointer.Dark3D;
end;

procedure TCandleSeries.SetDark3D(Value:Boolean);
begin
  Pointer.Dark3D:=Value;
end;

Function TCandleSeries.GetPen:TChartPen;
begin
  result:=Pointer.Pen;
end;

procedure TCandleSeries.SetCandlePen(Value:TChartPen);
begin
  Pointer.Pen.Assign(Value);
end;

Function TCandleSeries.AddCandle( Const ADate:TDateTime;
                                  Const AOpen,AHigh,ALow,AClose:Double):Integer;
begin
  result:=AddOHLC(ADate,AOpen,AHigh,ALow,AClose);
end;

class procedure TCandleSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_CandleBar);
  AddSubChart(TeeMsg_CandleNoOpen);
  AddSubChart(TeeMsg_CandleNoClose);
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_Line);
end;

class procedure TCandleSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TCandleSeries(ASeries) do
  Case Index of
    1: CandleStyle:=csCandleBar;
    2: begin Pen.Show; CandleStyle:=csCandleBar; ShowOpenTick:=False; end;
    3: begin Pen.Show; CandleStyle:=csCandleBar; ShowCloseTick:=False; end;
    4: begin CandleStyle:=csCandleStick; Pen.Hide; end;
    5: begin CandleStyle:=csLine; end;
  else inherited;
  end;
end;

function TCandleSeries.ClickedCandle(ValueIndex:Integer; const P:TPoint):Boolean;
var tmpItem   : TCandleItem;
    tmpTop    : Integer;
    tmpBottom : Integer;
    tmpFirst  : Integer;
    tmpTo     : TPoint;
begin
  result:=False;

  CalcItem(ValueIndex,tmpItem);

  With tmpItem do
  Begin
    if (FCandleStyle=csCandleStick) or (FCandleStyle=csOpenClose) then
    begin
      if ParentChart.View3D and Pointer.Draw3D then
      begin
        tmpTop:=yClose;
        tmpBottom:=yOpen;
        if tmpTop>tmpBottom then SwapInteger(tmpTop,tmpBottom);

        if (FCandleStyle=csCandleStick) and
           (
             PointInLine(P,tmpX,tmpBottom,tmpX,yLow) or
             PointInLine(P,tmpX,tmpTop,tmpX,yHigh)
           )  then
        begin
          result:=True;
          exit;
        end;

        if PointInRect(TeeRect(tmpX-tmpLeftWidth,tmpTop,tmpX+tmpRightWidth,tmpBottom),P.X,P.Y) then
           result:=True;
      end
      else
      begin
        if (FCandleStyle=csCandleStick) and
           PointInLine(P,tmpX,yLow,tmpX,yHigh) then
        begin
          result:=True;
          exit;
        end;

        if yOpen=yClose then Dec(yClose);

        if ParentChart.View3D then
        begin
          if PointInRect(TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth,yClose),P.X,P.Y) then
             result:=True;
        end
        else
        begin
          if not Self.Pen.Visible then
             if yOpen<yClose then Dec(yOpen) else Dec(yClose);

          if PointInRect(TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth+1,yClose),P.X,P.Y) then
             result:=True;
        end;
      end;
    end
    else
    if CandleStyle=csLine then
    begin
      tmpFirst:=FirstDisplayedIndex;
      tmpTo:=TeePoint(tmpX,YClose);
      if ValueIndex<>tmpFirst then result:=PointInLine(P,OldP,tmpTo);
      OldP:=tmpTo;
    end
    else
    if PointInLine(P,tmpX,yLow,tmpX,yHigh) or
       (ShowOpenTick and PointInLine(P,tmpX,yOpen,tmpX-tmpLeftWidth-1,yOpen)) or
       (ShowCloseTick and PointInLine(P,tmpX,yClose,tmpX+tmpRightWidth+1,yClose)) then
       result:=True;
  end;
end;

function TCandleSeries.Clicked(x, y: Integer): Integer;
var t : Integer;
    P : TPoint;
begin
  result:=TeeNoPointClicked;

  if (FirstValueIndex>-1) and (LastValueIndex>-1) then
  begin
    if Assigned(ParentChart) then
       ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

    P:=TeePoint(x,y);

    for t:=FirstValueIndex to LastValueIndex do
        if ClickedCandle(t,P) then
        begin
          result:=t;
          break;
        end;
  end;
end;

function TCandleSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  result:=CalculateColor(LegendIndex);
end;

function TCandleSeries.MaxYValue: Double;
begin
  if CandleStyle=csLine then result:=CloseValues.MaxValue
                        else result:=inherited MaxYValue;
end;

function TCandleSeries.MinYValue: Double;
begin
  if CandleStyle=csLine then result:=CloseValues.MinValue
                        else result:=inherited MinYValue;
end;

procedure TCandleSeries.SetHighLowPen(const Value: TChartPen);
begin
  FHighLowPen.Assign(Value);
end;

destructor TCandleSeries.Destroy;
begin
  FHighLowPen.Free;
  inherited;
end;

{ TVolumeSeries }
Constructor TVolumeSeries.Create(AOwner: TComponent);
begin
  inherited;
  DrawArea:=False;
  DrawBetweenPoints:=False;
  ClickableLine:=False;
  Pointer.Hide;
  FUseYOrigin:=False;
end;

Function TVolumeSeries.GetVolumeValues:TChartValueList;
Begin
  result:=YValues;
end;

Procedure TVolumeSeries.SetSeriesColor(AColor:TColor);
begin
  inherited;
  LinePen.Color:=AColor;
end;

Procedure TVolumeSeries.SetVolumeValues(Value:TChartValueList);
Begin
  SetYValues(Value);
end;

Procedure TVolumeSeries.PrepareCanvas(Forced:Boolean; AColor:TColor);
begin
  if Forced or (AColor<>IColor) then
  begin
    ParentChart.Canvas.AssignVisiblePenColor(LinePen,AColor);
    ParentChart.Canvas.BackMode:=cbmTransparent;
    IColor:=AColor;
  end;
end;

procedure TVolumeSeries.DrawValue(ValueIndex:Integer);
var tmpY : Integer;
Begin
  PrepareCanvas(ValueIndex=FirstDisplayedIndex, ValueColor[ValueIndex]);

  { moves to x,y coordinates and draws a vertical bar to top or bottom,
    depending on the vertical Axis.Inverted property }
  if UseYOrigin then
     tmpY:=CalcYPosValue(YOrigin) { 5.02 }
  else
  With GetVertAxis do
       if Inverted then tmpY:=IStartPos else tmpY:=IEndPos;

  with ParentChart,Canvas do
  if View3D then
     VertLine3D(CalcXPos(ValueIndex),CalcYPos(ValueIndex),tmpY,MiddleZ)
  else
     DoVertLine(CalcXPos(ValueIndex),tmpY,CalcYPos(ValueIndex)); { 5.02 }
end;

Function TVolumeSeries.NumSampleValues:Integer;
Begin
  result:=40;
end;

Procedure TVolumeSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var t : Integer;
    s : TSeriesRandomBounds;
begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do
  Begin
    AddXY(tmpX,RandomValue(Round(DifY) div 15));
    tmpX:=tmpX+StepX;
  end;
end;

Procedure TVolumeSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues(26);
  Pointer.InflateMargins:=True;
end;

class Function TVolumeSeries.GetEditorClass:String;
Begin
  result:='TVolumeSeriesEditor';
End;

class procedure TVolumeSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Dotted);
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Origin); { 5.02 }
end;

class procedure TVolumeSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TVolumeSeries(ASeries) do
  Case Index of
    1: Pen.SmallDots:=True;
    2: ColorEachPoint:=True;
    3: UseYOrigin:=True;
  else inherited
  end;
end;

procedure TVolumeSeries.DrawLegendShape(ValueIndex: Integer; { 5.01 }
  const Rect: TRect);
begin
  With Rect do ParentChart.Canvas.DoHorizLine(Left,Right,(Top+Bottom) div 2);
end;

procedure TVolumeSeries.Assign(Source: TPersistent);
begin
  if Source is TVolumeSeries then
  with TVolumeSeries(Source) do
  begin
    Self.FUseYOrigin:= UseYOrigin;
    Self.FOrigin    := YOrigin;
  end;
  inherited;
end;

procedure TVolumeSeries.SetOrigin(const Value: Double);
begin
  SetDoubleProperty(FOrigin,Value);
end;

procedure TVolumeSeries.SetUseOrigin(const Value: Boolean);
begin
  SetBooleanProperty(FUseYOrigin,Value);
end;

procedure TVolumeSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  PrepareCanvas(True,SeriesColor);
end;

{ TADXFunction }
type TChartSeriesAccess=class(TChartSeries);

Constructor TADXFunction.Create(AOwner: TComponent);

  Procedure HideSeries(ASeries:TChartSeries);
  begin
    ASeries.ShowInLegend:=False;
    TChartSeriesAccess(ASeries).InternalUse:=True;
  end;

begin
  inherited;
  InternalSetPeriod(14);
  SingleSource:=True;
  HideSourceList:=True;

  IDMDown:=TFastLineSeries.Create(Self);
  HideSeries(IDMDown);
  IDMDown.SeriesColor:=clRed;

  IDMUp:=TFastLineSeries.Create(Self);
  HideSeries(IDMUp);
  IDMUp.SeriesColor:=clGreen;
end;

procedure TADXFunction.AddPoints(Source: TChartSeries);

  Procedure PrepareSeries(ASeries:TChartSeries);
  begin
    With ASeries do
    begin
      ParentChart:=ParentSeries.ParentChart;
      CustomVertAxis:=ParentSeries.CustomVertAxis;
      VertAxis:=ParentSeries.VertAxis;
      XValues.DateTime:=ParentSeries.XValues.DateTime;
      AfterDrawValues:=ParentSeries.AfterDrawValues;
      BeforeDrawValues:=ParentSeries.BeforeDrawValues;
    end;
  end;

  Function CalcADX(Index:Integer):Double;
  begin
    Index:=Index-Round(Period);
    result:=(100*Abs(IDMUp.YValues.Value[Index]-IDMDown.YValues.Value[Index])/
                    (IDMUp.YValues.Value[Index]+IDMDown.YValues.Value[Index]));
  end;

var tmpTR,
    tmpDMUp,
    tmpDMDown : Array of Double;
    t         : Integer;
    tt        : Integer;
    tmpClose  : Double;
    Closes,
    Highs,
    Lows      : TChartValueList;
    tmpTR2,
    tmpUp2,
    tmpDown2  : Double;
    tmpX      : Double;
    tmp       : Integer;
    tmpADX    : Double;
begin
  if Period<2 then Exit; // 5.03

  ParentSeries.Clear;
  IDMUp.Clear;
  IDMDown.Clear;
  PrepareSeries(IDMUp);
  PrepareSeries(IDMDown);
  if Source.Count>=(2*Period) then
  begin
    With TOHLCSeries(Source) do
    begin
      Closes:=CloseValues;
      Highs:=HighValues;
      Lows:=LowValues;
    end;

    SetLength(tmpTR, Source.Count);
    SetLength(tmpDMUp, Source.Count);
    SetLength(tmpDMDown, Source.Count);

    for t:=1 to Source.Count-1 do
    begin
      tmpClose:=Closes.Value[t-1];
      tmpTR[t]:=Highs.Value[t]-Lows.Value[t];
      tmpTR[t]:=Math.Max(tmpTR[t],Abs(Highs.Value[t]-tmpClose));
      tmpTR[t]:=Math.Max(tmpTR[t],Abs(Lows.Value[t]-tmpClose));

      if (Highs.Value[t]-Highs.Value[t-1])>(Lows.Value[t-1]-Lows.Value[t]) then
          tmpDMUp[t]:=Math.Max(0,Highs.Value[t]-Highs.Value[t-1])
      else
          tmpDMUp[t]:=0;

      if (Lows.Value[t-1]-Lows.Value[t])>(Highs.Value[t]-Highs.Value[t-1]) then
          tmpDMDown[t]:=Math.Max(0,Lows.Value[t-1]-Lows.Value[t])
      else
          tmpDMDown[t]:=0;
    end;

    tmpTR2:=0;
    tmpUp2:=0;
    tmpDown2:=0;

    tmp:=Round(Period);
    for t:=tmp to Source.Count-1 do
    begin
      if t=tmp then
      begin
        for tt:=1 to Round(Period) do
        begin
          tmpTR2  :=tmpTR2+tmpTR[tt];
          tmpUp2  :=tmpUp2+tmpDMUp[tt];
          tmpDown2:=tmpDown2+tmpDMDown[tt];
        end;
      end
      else
      begin
        tmpTR2:=tmpTR2-(tmpTR2/Period)+tmpTR[t];
        tmpUp2:=tmpUp2-(tmpUp2/Period)+tmpDMUp[t];
        tmpDown2:=tmpDown2-(tmpDown2/Period)+tmpDMDown[t];
      end;
      tmpX:=Source.XValues[t];
      IDMUp.AddXY( tmpX, 100*(tmpUp2/tmpTR2));
      IDMDown.AddXY( tmpX, 100*(tmpDown2/tmpTR2));
    end;

    tmpTR:=nil;
    tmpDMUp:=nil;
    tmpDMDown:=nil;
    tmpADX:=0;

    tmp:=Round((2*Period)-2);
    for t:=tmp to Source.Count-1 do
    begin
      if t=tmp then
      begin
        tmpADX:=0;
        for tt:=Round(Period) to tmp do tmpADX:=tmpADX+CalcADX(tt);
        tmpADX:=tmpADX/(Period-1);
      end
      else
      begin
        tmpADX:=((tmpADX*(Period-1))+(CalcADX(t)))/Period;
      end;
      ParentSeries.AddXY(Source.XValues[t],tmpADX);
    end;
  end;
end;

Destructor TADXFunction.Destroy; { 5.01 }
begin
  DMDown.Free;
  DMUp.Free;
  inherited;
end;

class function TADXFunction.GetEditorClass: String;
begin
  result:='TADXFuncEditor';
end;

function TADXFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

function TADXFunction.GetDownPen: TChartPen;
begin
  result:=DMDown.Pen;
end;

function TADXFunction.GetUpPen: TChartPen;
begin
  result:=DMUp.Pen;
end;

procedure TADXFunction.SetDownPen(const Value: TChartPen);
begin
  DMDown.Pen:=Value;
end;

procedure TADXFunction.SetUpPen(const Value: TChartPen);
begin
  DMUp.Pen:=Value;
end;

{ R.S.I. }
Constructor TRSIFunction.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=rsiOpenClose;
  SingleSource:=True;
  HideSourceList:=True;
end;

Function TRSIFunction.Calculate( Series:TChartSeries;
                                 FirstIndex,LastIndex:Integer):Double;
var NumPoints : Integer;
    t         : Integer;
    tmpClose  : Double;
    Ups       : Double;
    Downs     : Double;
Begin
  if ISeries<>Series then
  begin // Cache lists during calculation
    Closes:=Series.GetYValueList('CLOSE');
    Opens :=Series.GetYValueList('OPEN');
    ISeries:=Series;
  end;

  Ups:=0;
  Downs:=0;

  With Series do
  Begin
    if Self.Style=rsiOpenClose then
    begin // use today Close and Open prices (do not use "yesterday" close)
      for t:=FirstIndex to LastIndex do
      Begin
        tmpClose:=Closes.Value[t];
        if Opens.Value[t]>tmpClose then Downs:=Downs+tmpClose
                                   else Ups  :=Ups  +tmpClose;
      end;
    end
    else
    begin // Use Close prices (today - yesterday)
      for t:=FirstIndex+1 to LastIndex do
      Begin
        tmpClose:=Closes.Value[t]-Closes.Value[t-1];
        if tmpClose<0 then Downs:=Downs-tmpClose
                      else Ups  :=Ups  +tmpClose;
      end;
    end;
  end;

  { Calculate RSI }
  NumPoints:=(LastIndex-FirstIndex)+1;
  Downs:=Downs/NumPoints;
  Ups  :=Ups  /NumPoints;
  if Downs<>0 then
  Begin
    result:=100.0 - ( 100.0 / ( 1.0+Abs(Ups/Downs) ) );
    if result<0   then result:=0 else
    if result>100 then result:=100;
  end
  else result:=100; // Special case, to avoid divide by zero
end;

// R.S.I. function needs an OHLC series values to calculate.
function TRSIFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

procedure TRSIFunction.SetStyle(const Value: TRSIStyle);
begin
  if Style<>Value then
  begin
    FStyle:=Value;
    ReCalculate;
  end;
end;

initialization
  RegisterTeeSeries( TCandleSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryCandle,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);
  RegisterTeeSeries( TVolumeSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryVolume,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);
  RegisterTeeFunction( TADXFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionADX,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
  RegisterTeeFunction( TRSIFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionRSI,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeSeries([TCandleSeries,TVolumeSeries]);
  UnRegisterTeeFunctions([ TADXFunction,TRSIFunction ]);
end.
