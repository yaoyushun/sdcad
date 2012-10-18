{**********************************************}
{   TErrorSeries                               }
{   TErrorBarSeries (derived from TBarSeries)  }
{                                              }
{   Copyright (c) 1995-2004 by David Berneda   }
{**********************************************}
unit ErrorBar;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$IFDEF CLR}
     Types,
     {$ENDIF}
     TeEngine, Series, TeCanvas;

type
  TErrorSeriesStyle=( essLeft,essRight,essLeftRight,
                      essTop,essBottom,essTopBottom);

  TErrorWidthUnits=(ewuPercent,ewuPixels);

  TCustomErrorSeries=class(TBarSeries)
  private
    { Private declarations }
    FErrorPen        : TChartPen;
    FErrorStyle      : TErrorSeriesStyle;
    FErrorValues     : TChartValueList;
    FErrorWidth      : Integer;
    FErrorWidthUnits : TErrorWidthUnits;
    { internal }
    IDrawBar         : Boolean;
    Function GetErrorValue(Index:Integer):Double;
    Procedure PrepareErrorPen(ValueIndex:Integer);
    Procedure SetErrorStyle(Value:TErrorSeriesStyle);
    Procedure SetErrorValue(Index:Integer; Const Value:Double);
    Procedure SetErrorValues(Value:TChartValueList);
    Procedure SetErrorWidthUnits(Value:TErrorWidthUnits);
    Procedure SetErrorWidth(Value:Integer);
    procedure SetErrorPen(const Value: TChartPen);
  protected
    { Protected declarations }
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    Procedure DrawError(X,Y,AWidth,AHeight:Integer; Draw3D:Boolean);
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle); override;
    Procedure SetSeriesColor(AColor:TColor); override;
    class Function SubGalleryStack:Boolean; override; { 5.01 }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function AddErrorBar(Const AX,AY,AError:Double;
                         Const AXLabel:String='';
                         AColor:TColor=clTeeColor):Integer;
    Procedure Assign(Source:TPersistent); override;
    Procedure DrawBar(BarIndex,StartPos,EndPos:Integer); override;
    Function MinYValue:Double; override;
    Function MaxYValue:Double; override;
    property ErrorValue[Index:Integer]:Double read GetErrorValue
                                              write SetErrorValue;

    { To be published declarations }
    property ErrorPen:TChartPen read FErrorPen write SetErrorPen;
    property ErrorStyle:TErrorSeriesStyle read FErrorStyle write SetErrorStyle
                                          default essTopBottom;
    property ErrorValues:TChartValueList read FErrorValues write SetErrorValues;
    property ErrorWidth:Integer read FErrorWidth write SetErrorWidth default 100;
    property ErrorWidthUnits:TErrorWidthUnits read FErrorWidthUnits
                                              write SetErrorWidthUnits default ewuPercent;
  end;

  TErrorSeries=class(TCustomErrorSeries)
  public
  published
    property ErrorPen;
    property ErrorStyle;
    property ErrorValues;
    property ErrorWidth;
    property ErrorWidthUnits;
  end;

  TErrorBarSeries=class(TCustomErrorSeries)
  protected
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
  published
    property ErrorPen;
    property ErrorValues;
    property ErrorWidth;
    property ErrorWidthUnits;
  end;

  THighLowSeries=class(TChartSeries)
  private
    FHighPen : TChartPen;
    FLow     : TChartValueList;
    FLowPen  : TChartPen;
    OldX     : Integer;
    OldY0    : Integer;
    OldY1    : Integer;
    FLowBrush: TChartBrush;
    FTransparency: TTeeTransparency;

    function GetHigh: TChartValueList;
    procedure SetHigh(const Value: TChartValueList);
    procedure SetHighPen(const Value: TChartPen);
    procedure SetLow(const Value: TChartValueList);
    procedure SetLowPen(const Value: TChartPen);
    function GetHighBrush: TChartBrush;
    procedure SetHighBrush(const Value: TChartBrush);
    procedure SetLowBrush(const Value: TChartBrush);
    procedure SetTransparency(const Value: TTeeTransparency);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    Function AddHighLow(Const AX,AHigh,ALow:Double;
                        Const AXLabel:String='';
                         AColor:TColor=clTeeColor):Integer;
    function Clicked(x, y: Integer): Integer; override; // 6.0
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property HighBrush:TChartBrush read GetHighBrush write SetHighBrush;
    property HighPen:TChartPen read FHighPen write SetHighPen;
    property HighValues:TChartValueList read GetHigh write SetHigh;
    property LowBrush:TChartBrush read FLowBrush write SetLowBrush;
    property LowPen:TChartPen read FLowPen write SetLowPen;
    property LowValues:TChartValueList read FLow write SetLow;
    property Pen;
    property Transparency:TTeeTransparency read FTransparency
              write SetTransparency default 0;

    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property Depth;
    property HorizAxis;
    property Marks;
    property ParentChart;
    { datasource below parentchart }
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;
    property XValues; { 5.01 }

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
  end;

implementation

Uses {$IFDEF CLR}
     {$ELSE}
     Math,
     {$ENDIF}
     Chart, TeeProcs, TeeProCo, TeeConst;

{ TCustomErrorSeries }
Constructor TCustomErrorSeries.Create(AOwner: TComponent);
Begin
  inherited;
  IDrawBar:=False;
  FErrorPen:=CreateChartPen;
  FErrorValues:=TChartValueList.Create(Self,TeeMsg_ValuesStdError); { <-- Std Error storage }
  FErrorStyle:=essTopBottom;
  FErrorWidth:=100;
  FErrorWidthUnits:=ewuPercent;
  Marks.Hide;
end;

Destructor TCustomErrorSeries.Destroy;
begin
  FErrorPen.Free;
  inherited;
end;

Procedure TCustomErrorSeries.CalcHorizMargins(Var LeftMargin,RightMargin:Integer);
begin
  inherited;
  if (FErrorStyle=essLeft) or (FErrorStyle=essLeftRight) then
     LeftMargin  :=Math.Max(LeftMargin, ErrorPen.Width);
  if (FErrorStyle=essRight) or (FErrorStyle=essLeftRight) then
     RightMargin :=Math.Max(RightMargin, ErrorPen.Width);
end;

Procedure TCustomErrorSeries.CalcVerticalMargins(Var TopMargin,BottomMargin:Integer);
begin
  inherited;
  if (FErrorStyle=essTop) or (FErrorStyle=essTopBottom) then
     TopMargin    :=Math.Max(TopMargin, ErrorPen.Width);
  if (FErrorStyle=essBottom) or (FErrorStyle=essTopBottom) then
     BottomMargin :=Math.Max(BottomMargin, ErrorPen.Width);
end;

Procedure TCustomErrorSeries.SetErrorPen(Const Value:TChartPen);
Begin
  FErrorPen.Assign(Value);
  if not IDrawBar then SeriesColor:=FErrorPen.Color;
End;

Procedure TCustomErrorSeries.PrepareErrorPen(ValueIndex:Integer);
begin
  With ParentChart.Canvas do
  begin
    if (ValueIndex<>TeeAllValues) and (not IDrawBar) then
       AssignVisiblePenColor(ErrorPen,ValueColor[ValueIndex])
    else
       AssignVisiblePen(ErrorPen);

    BackMode:=cbmTransparent;
  end;
end;

Procedure TCustomErrorSeries.SetErrorWidth(Value:Integer);
Begin
  SetIntegerProperty(FErrorWidth,Value);
End;

Procedure TCustomErrorSeries.DrawError(X,Y,AWidth,AHeight:Integer; Draw3D:Boolean);

  Procedure DrawHoriz(XPos:Integer);
  begin
    With ParentChart.Canvas do
    begin
      if Draw3D then
      begin
        HorizLine3D(X,XPos,Y,MiddleZ);
        VertLine3D(XPos,(Y-AWidth div 2),Y+(AWidth div 2),MiddleZ); { 5.01 }
      end
      else
      begin
        DoHorizLine(X,XPos,Y);
        DoVertLine(XPos,(Y-AWidth div 2),Y+(AWidth div 2)); { 5.01 }
      end;
    end;
  end;

  Procedure DrawVert(YPos:Integer);
  begin
    With ParentChart.Canvas do
    begin
      if Draw3D then
      begin
        VertLine3D(X,Y,YPos,MiddleZ);
        HorizLine3D(X-(AWidth div 2),X+(AWidth div 2),YPos,MiddleZ);
      end
      else
      begin
        DoVertLine(X,Y,YPos);
        DoHorizLine(X-(AWidth div 2),X+(AWidth div 2),YPos);
      end;
    end;
  end;

begin
  Case FErrorStyle of
    essLeft     : DrawHoriz(X-AHeight);   { 5.01 }
    essRight    : DrawHoriz(X+AHeight);
    essLeftRight: begin
                    DrawHoriz(X-AHeight);
                    DrawHoriz(X+AHeight);
                  end;
    essTop      : DrawVert(Y-AHeight);
    essBottom   : DrawVert(Y+AHeight);
    essTopBottom: begin
                    DrawVert(Y-AHeight);
                    DrawVert(Y+AHeight);
                  end;
  end;
end;

Procedure TCustomErrorSeries.DrawBar(BarIndex,StartPos,EndPos:Integer);
Var tmp         : Integer;
    tmpWidth    : Integer;
    tmpBarWidth : Integer;
    tmpError    : Double;
    tmpHeight   : Integer;
Begin
  if IDrawBar then inherited;
  if ErrorPen.Visible then
  Begin
    tmpError:=FErrorValues.Value[BarIndex];
    if tmpError<>0 then
    Begin
      tmpBarWidth:=BarBounds.Right-BarBounds.Left;

      if FErrorWidth=0 then tmpWidth:=tmpBarWidth
      else
      if FErrorWidthUnits=ewuPercent then
         tmpWidth:=Round(1.0*FErrorWidth*tmpBarWidth*0.01)
      else
         tmpWidth:=FErrorWidth;

      tmp:=CalcYPosValue(YValues.Value[BarIndex]);

      { MS : simplified and allows vertical/horizontal style 5.01 }
      Case FErrorStyle of
        essLeft,
        essRight,
        essLeftRight : tmpHeight:=GetHorizAxis.CalcSizeValue(Abs(tmpError));
      else             tmpHeight:=GetVertAxis.CalcSizeValue(Abs(tmpError));
      end;

      if IDrawBar and (YValues.Value[BarIndex]<YOrigin) then
         tmpHeight:=-tmpHeight;

      PrepareErrorPen(BarIndex);
      DrawError((BarBounds.Right+BarBounds.Left) div 2,tmp,
                 tmpWidth,tmpHeight,ParentChart.View3D);
    end;
  end;
End;

Procedure TCustomErrorSeries.SetErrorWidthUnits(Value:TErrorWidthUnits);
Begin
  if FErrorWidthUnits<>Value then
  Begin
    FErrorWidthUnits:=Value;
    Repaint;
  end;
end;

Procedure TCustomErrorSeries.SetErrorStyle(Value:TErrorSeriesStyle);
begin
  if FErrorStyle<>Value then
  begin
    FErrorStyle:=Value;
    Repaint;
  end;
end;

Procedure TCustomErrorSeries.SetErrorValues(Value:TChartValueList);
Begin
  SetChartValueList(FErrorValues,Value); { standard method }
End;

Function TCustomErrorSeries.AddErrorBar( Const AX,AY,AError:Double;
                                         Const AXLabel:String;
                                         AColor:TColor):Integer;
Begin
  FErrorValues.TempValue:=AError;
  result:=AddXY(AX,AY,AXLabel,AColor);
End;

Procedure TCustomErrorSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var t : Integer;
    s : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do
  Begin
    AddErrorBar( tmpX,
                 RandomValue(Round(DifY)),
                 DifY/(20+RandomValue(4)));
    tmpX:=tmpX+StepX;
  end;
end;

Function TCustomErrorSeries.MaxYValue:Double;
Var t      : Integer;
    tmp    : Double;
    tmpErr : Double;
Begin
  if IDrawBar then result:=inherited MaxYValue else result:=0;
  for t:=0 to Count-1 do
  if IDrawBar then
  Begin
    tmpErr:=FErrorValues.Value[t];
    tmp:=YValues.Value[t];
    if tmp<0 then tmp:=tmp-tmpErr else tmp:=tmp+tmpErr;
    if tmp>result then result:=tmp;
  end
  else
  begin
    tmp:=YValues.Value[t]+FErrorValues.Value[t];
    if t=0 then
       result:=tmp
    else
       result:=Math.Max(result,tmp);
  end;
End;

Function TCustomErrorSeries.MinYValue:Double;
Var t      : Integer;
    tmp    : Double;
    tmpErr : Double;
Begin
  if IDrawBar then result:=inherited MinYValue else result:=0;
  for t:=0 to Count-1 do
  if IDrawBar then
  Begin
    tmpErr:=FErrorValues.Value[t];
    tmp:=YValues.Value[t];
    if tmp<0 then tmp:=tmp-tmpErr else tmp:=tmp+tmpErr;
    if tmp<result then result:=tmp;
  end
  else
  begin
    tmp:=YValues.Value[t]-FErrorValues.Value[t];
    if t=0 then
       result:=tmp
    else
       result:=Math.Min(result,tmp);
  end;
End;

Function TCustomErrorSeries.GetErrorValue(Index:Integer):Double;
Begin
  result:=FErrorValues.Value[Index];
End;

Procedure TCustomErrorSeries.SetErrorValue(Index:Integer; Const Value:Double);
Begin
  FErrorValues.Value[Index]:=Value;
End;

class Function TCustomErrorSeries.GetEditorClass:String;
Begin
  result:='TErrorSeriesEditor';
end;

Procedure TCustomErrorSeries.Assign(Source:TPersistent);
begin
  if Source is TCustomErrorSeries then
  With TCustomErrorSeries(Source) do
  begin
    Self.ErrorPen        :=FErrorPen;  // 7.0 fix
    Self.FErrorStyle     :=FErrorStyle;
    Self.FErrorWidth     :=FErrorWidth;
    Self.FErrorWidthUnits:=FErrorWidthUnits;
  end;
  inherited;
end;

Procedure TCustomErrorSeries.PrepareForGallery(IsEnabled:Boolean);
Const Colors:Array[Boolean] of TColor=(clSilver,clBlue);
      ErrorColors:Array[Boolean] of TColor=(clWhite,clRed);
begin
  inherited;
  ErrorPen.Color:=ErrorColors[IsEnabled];
  SeriesColor:=Colors[IsEnabled];
end;

Procedure TCustomErrorSeries.SetSeriesColor(AColor:TColor);
begin
  inherited;
  if not IDrawBar then ErrorPen.Color:=AColor;
end;

Procedure TCustomErrorSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
begin
  With Rect do
    DrawError( (Left+Right) div 2,(Top+Bottom) div 2,
               Right-Left,((Bottom-Top) div 2)-1,False);
end;

class Function TCustomErrorSeries.SubGalleryStack:Boolean;
begin
  result:=False; { 5.01 } { Do not show stacked styles at sub-gallery }
end;

procedure TCustomErrorSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  PrepareErrorPen(ValueIndex);
end;

{ TErrorBarSeries }
Constructor TErrorBarSeries.Create(AOwner: TComponent);
Begin
  inherited;
  IDrawBar:=True;
  FErrorStyle:=essTop;
end;

Procedure TErrorBarSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  ErrorPen.Width:=2;
  inherited;
end;

{ THighLowSeries }
Constructor THighLowSeries.Create(AOwner: TComponent);
begin
  inherited;
  CalcVisiblePoints:=False;
  Pen.Color:=clTeeColor;
  FLow:=TChartValueList.Create(Self,TeeMsg_ValuesLow);
  FHighPen:=CreateChartPen;
  FLowPen:=CreateChartPen;
  FLowBrush:=TChartBrush.Create(CanvasChanged);
  LowBrush.Style:=bsClear;
  HighBrush.Style:=bsClear;
end;

Destructor THighLowSeries.Destroy;
begin
  FHighPen.Free;
  FLowPen.Free;
  FLowBrush.Free;
  inherited;
end;

function THighLowSeries.AddHighLow(const AX, AHigh, ALow: Double;
                                   Const AXLabel:String='';
                          AColor:TColor=clTeeColor): Integer;
begin
  FLow.TempValue:=ALow;
  result:=AddXY(AX,AHigh);
end;

procedure THighLowSeries.Assign(Source: TPersistent);
begin
  if Source is THighLowSeries then
  With THighLowSeries(Source) do
  begin
    Self.HighPen :=HighPen;
    Self.LowPen  :=LowPen;
    Self.LowBrush:=LowBrush;
    Self.FTransparency:=FTransparency;
  end;
  inherited;
end;

function THighLowSeries.Clicked(x, y: Integer): Integer;
var t  : Integer;
    X0 : Integer;
    P  : TPoint;
    PS : TFourPoints;
begin
  result:=TeeNoPointClicked;

  if (FirstValueIndex<>-1) and (LastValueIndex<>-1) then  // 7.0
  begin
    P:=TeePoint(x,y);

    for t:=FirstValueIndex to LastValueIndex do
    begin
      X0:=CalcXPos(t);

      PS[2]:=ParentChart.Canvas.Calculate3DPosition(X0,CalcYPosValue(FLow.Value[t]),MiddleZ);
      PS[3]:=ParentChart.Canvas.Calculate3DPosition(X0,CalcYPos(t),MiddleZ);

      if (t<>FirstValueIndex) and PointInPolygon(P,PS) then
      begin
        result:=t;
        break;
      end;

      PS[0]:=PS[3];
      PS[1]:=PS[2];
    end;
  end;
end;

procedure THighLowSeries.DrawValue(ValueIndex: Integer);
Var X : Integer;
    View3D : Boolean;

  Procedure DrawLine(APen:TChartPen; BeginY,EndY:Integer);
  begin
    if APen.Visible then
    With ParentChart.Canvas do
    begin
      AssignVisiblePen(APen);
      if View3D then LineWithZ(OldX,BeginY,X,EndY,MiddleZ)
                else Line(OldX,BeginY,X,EndY);
    end;
  end;

  procedure DrawValueLine(AColor:TColor);
  var tmp : TColor;
  begin
    tmp:=Pen.Color;
    if tmp=clTeeColor then tmp:=AColor;

    with ParentChart.Canvas do
    begin
      AssignVisiblePenColor(Self.Pen,tmp);
      if View3D then VertLine3D(OldX,OldY0,OldY1,MiddleZ)
                else DoVertLine(OldX,OldY0,OldY1);
    end;
  end;

var Y0   : Integer;
    Y1   : Integer;
    tmpBrush : TChartBrush;
    tmpColor : TColor;
    IPoints  : TFourPoints;
    P        : TFourPoints;
    tmpBlend : TTeeBlend;
    tmpFirst : Integer;
begin
  // calculate coordinates
  x:=CalcXPos(ValueIndex);
  y0:=CalcYPos(ValueIndex);
  y1:=CalcYPosValue(FLow.Value[ValueIndex]);

  tmpFirst:=FirstDisplayedIndex;
  if ValueIndex<>tmpFirst then
  begin
    tmpColor:=ValueColor[ValueIndex-1];
    View3D:=ParentChart.View3D;

    if (not IsNull(ValueIndex)) and (not IsNull(ValueIndex-1)) then // 7.0
    begin

      // Determine brush to use (high or low)
      if LowValues.Value[ValueIndex]<HighValues.Value[ValueIndex] then
         tmpBrush:=HighBrush
      else
         tmpBrush:=LowBrush;

      // set brush
      if tmpBrush.Style<>bsClear then
      begin
        P[0].X:=OldX;
        P[0].Y:=OldY0;
        P[1].X:=OldX;
        P[1].Y:=OldY1;
        P[2].X:=X;
        P[2].Y:=Y1;
        P[3].X:=X;
        P[3].Y:=Y0;

        with ParentChart.Canvas do
        begin
          if Transparency>0 then
          begin
            IPoints[0]:=Calculate3DPosition(P[0],MiddleZ);
            IPoints[1]:=Calculate3DPosition(P[1],MiddleZ);
            IPoints[2]:=Calculate3DPosition(P[2],MiddleZ);
            IPoints[3]:=Calculate3DPosition(P[3],MiddleZ);

            tmpBlend:=BeginBlending(RectFromPolygon(IPoints,4),Transparency);
          end
          else tmpBlend:=nil;

          AssignBrush(tmpBrush,tmpColor);
          Pen.Style:=psClear;  // no pen to draw polygon

          // draw plane
          if View3D then PlaneWithZ(P,MiddleZ)
                    else Polygon(P);

          if Transparency>0 then EndBlending(tmpBlend);
        end;
      end;

      // draw lines
      DrawLine(HighPen,OldY0,Y0);
      DrawLine(LowPen,OldY1,Y1);
    end;

    // draw vertical lines
    if Pen.Visible and (not IsNull(ValueIndex-1)) then // 7.0
    begin
      DrawValueLine(tmpColor);

      if DrawValuesForward then tmpFirst:=LastValueIndex
                           else tmpFirst:=FirstValueIndex;
      if ValueIndex=tmpFirst then
      begin
        OldX:=X;
        OldY0:=Y0;
        OldY1:=Y1;
        DrawValueLine(ValueColor[ValueIndex]);
      end;
    end;
  end;

  OldX:=X;
  OldY0:=Y0;
  OldY1:=Y1;
end;

function THighLowSeries.GetHigh: TChartValueList;
begin
  result:=YValues;
end;

procedure THighLowSeries.SetHigh(const Value: TChartValueList);
begin
  SetChartValueList(YValues,Value);
end;

procedure THighLowSeries.SetLow(const Value: TChartValueList);
begin
  FLow.Assign(Value);
end;

Function THighLowSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is THighLowSeries;
end;

Function THighLowSeries.MaxYValue:Double;
Begin
  result:=Math.Max(inherited MaxYValue,FLow.MaxValue);
End;

Function THighLowSeries.MinYValue:Double;
Begin
  result:=Math.Min(inherited MinYValue,FLow.MinValue);
End;

procedure THighLowSeries.SetHighPen(const Value: TChartPen);
begin
  FHighPen.Assign(Value);
end;

procedure THighLowSeries.SetLowPen(const Value: TChartPen);
begin
  FLowPen.Assign(Value);
end;

class function THighLowSeries.GetEditorClass: String;
begin
  result:='THighLowEditor';
end;

function THighLowSeries.GetHighBrush: TChartBrush;
begin
  result:=Brush;
end;

procedure THighLowSeries.SetHighBrush(const Value: TChartBrush);
begin
  Brush:=Value;
end;

procedure THighLowSeries.SetLowBrush(const Value: TChartBrush);
begin
  FLowBrush.Assign(Value);
end;

procedure THighLowSeries.AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False);
Var t   : Integer;
    tmp : Double;
    s   : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  begin
    tmp:=RandomValue(Round(DifY));
    for t:=1 to NumValues do
    Begin
      tmp:=tmp+RandomValue(Round(DifY/5.0))-(DifY/10.0);
      AddHighLow(tmpX,{ X }
                 tmp, { High }
                 tmp-RandomValue(Round(DifY/5.0))); { Low }
      tmpX:=tmpX+StepX;
    end;
  end;
end;

class procedure THighLowSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Filled);
  AddSubChart(TeeMsg_NoLines);
  AddSubChart(TeeMsg_NoHigh);
  AddSubChart(TeeMsg_NoLow);
end;

class procedure THighLowSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With THighLowSeries(ASeries) do
  Case Index of
    1: Brush.Style:=bsSolid;
    2: Pen.Hide;
    3: HighPen.Hide;
    4: LowPen.Hide;
  else inherited;
  end;
end;

procedure THighLowSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

initialization
  RegisterTeeSeries(TErrorBarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryErrorBar,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
  RegisterTeeSeries(TErrorSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryError,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
  RegisterTeeSeries(THighLowSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHighLow,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
finalization
  UnRegisterTeeSeries( [TErrorBarSeries,TErrorSeries,THighLowSeries]);
end.
