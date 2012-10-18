{******************************************}
{ TChartShape Series Component             }
{ Copyright (c) 1995-2004 by David Berneda }
{******************************************}
unit TeeShape;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     Chart, Classes, Series, TeeProcs, TeEngine, TeCanvas,
     {$IFDEF CLX}
     QGraphics
     {$ELSE}
     Graphics
     {$ENDIF}
     {$IFDEF D6}, Types{$ENDIF};

type
  TChartShapeXYStyle=( xysPixels, xysAxis, xysAxisOrigin );

  TChartShapeStyle=( chasRectangle,
                     chasCircle,
                     chasVertLine,
                     chasHorizLine,
                     chasTriangle,
                     chasInvertTriangle,
                     chasLine,
                     chasDiamond,
                     chasCube,
                     chasCross,
                     chasDiagCross,
                     chasStar,
                     chasPyramid,
                     chasInvertPyramid );

  TTeeVertAlign=(vaTop,vaCenter,vaBottom);

  TChartShape = class(TChartSeries)
  private
    FAlignment      : TAlignment;
    FFont           : TTeeFont;
    FGradient       : TChartGradient;
    FRoundRectangle : Boolean;
    FStyle          : TChartShapeStyle;
    FText           : TStrings;
    FTransparent    : Boolean;
    FVertAlign      : TTeeVertAlign;
    FXYStyle        : TChartShapeXYStyle;
    Procedure AddDefaultPoints;
    Function GetX0:Double;
    Function GetX1:Double;
    Function GetY0:Double;
    Function GetY1:Double;
    procedure SetAlignment(Value: TAlignment);
    procedure SetFont(Value: TTeeFont);
    procedure SetRoundRectangle(Value: Boolean);
    Procedure SetShapeRectangle(Const ARect:TRect);
    procedure SetStyle(Value : TChartShapeStyle);
    procedure SetTransparent(Value: Boolean);
    procedure SetVertAlign(Value: TTeeVertAlign);
    Procedure SetX0(Const Value:Double);
    Procedure SetX1(Const Value:Double);
    procedure SetXYStyle(Value: TChartShapeXYStyle);
    Procedure SetY0(Const Value:Double);
    Procedure SetY1(Const Value:Double);
    procedure SetGradient(const Value: TChartGradient);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcZOrder; override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    procedure DrawShape(Is3D:Boolean; Const R:TRect);
    procedure DrawText(Const R:TRect);
    procedure DrawValue(ValueIndex:Integer); override;
    Function  GetAdjustedRectangle:TRect;
    class Function GetEditorClass:String; override;
    Function  GetShapeRectangle:TRect; virtual;
    Function  MoreSameZOrder:Boolean; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetSeriesColor(AColor:TColor); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
    procedure SetText(Value : TStrings); virtual;
  public
    Constructor Create(AOwner : TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function Clicked(x,y:Integer):Integer; override;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function UseAxis:Boolean; override;

    property Bounds:TRect read GetShapeRectangle write SetShapeRectangle;
  published
    property Active;
    property Cursor;
    property Depth;
    property HorizAxis;
    property Marks; { 5.01 }
    property ParentChart;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property VertAxis;
    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnClick;
    property OnDblClick;

    property Alignment: TAlignment read FAlignment write SetAlignment
                                   default taCenter;
    property Brush;
    property Font:TTeeFont read FFont write SetFont;
    property Gradient:TChartGradient read FGradient write SetGradient;
    property Text:TStrings read FText write SetText;
    property Pen;
    property RoundRectangle: Boolean read FRoundRectangle
                                     write SetRoundRectangle default False;
    property Style : TChartShapeStyle Read FStyle write SetStyle
                                      default chasCircle;
    property Transparent:Boolean read FTransparent
                                 write SetTransparent default False;
    property VertAlign: TTeeVertAlign read FVertAlign write SetVertAlign
                                      default vaCenter;
    property XYStyle:TChartShapeXYStyle read FXYStyle
                                        write SetXYStyle default xysAxis;
    property X0:Double read GetX0 write SetX0;
    property X1:Double read GetX1 write SetX1;
    property Y0:Double read GetY0 write SetY0;
    property Y1:Double read GetY1 write SetY1;
    property XValues;
    property YValues;
  end;

implementation

Uses SysUtils, TeeConst;

{ TChartShape }
Constructor TChartShape.Create(AOwner : TComponent);
Begin
  inherited;
  FAlignment:=taCenter;
  FVertAlign:=vaCenter;
  CalcVisiblePoints:=False;
  Brush.Color:=clWhite;
  FStyle:=chasCircle;
  FFont:=TTeeFont.Create(CanvasChanged);
  FGradient:=TChartGradient.Create(CanvasChanged);
  FText:=TStringList.Create;
  TStringList(FText).OnChange:=CanvasChanged;
  SeriesColor:=Brush.Color;
  FXYStyle:=xysAxis;
  AddDefaultPoints;
End;

Destructor TChartShape.Destroy;
Begin
  FText.Free;
  FGradient.Free;
  FFont.Free;
  inherited;
End;

Procedure TChartShape.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
begin
  DrawShape(False,Rect);
end;

Function TChartShape.GetX0:Double;
Begin
  result:=XValues.Value[0]
End;

Procedure TChartShape.SetX0(Const Value:Double);
Begin
  XValues.Value[0]:=Value;
  Repaint;
End;

Function TChartShape.GetY0:Double;
Begin
  result:=YValues.Value[0]
End;

Procedure TChartShape.SetY0(Const Value:Double);
Begin
  YValues.Value[0]:=Value;
  Repaint;
End;

Function TChartShape.GetX1:Double;
Begin
  result:=XValues.Value[1]
End;

Procedure TChartShape.SetX1(Const Value:Double);
Begin
  XValues.Value[1]:=Value;
  Repaint;
End;

Function TChartShape.GetY1:Double;
Begin
  result:=YValues.Value[1]
End;

Procedure TChartShape.SetY1(Const Value:Double);
Begin
  YValues.Value[1]:=Value;
  Repaint;
End;

procedure TChartShape.SetStyle(Value : TChartShapeStyle);
Begin
  if Value<>FStyle then
  begin
    FStyle:=Value;
    Repaint;
  end;
End;

Procedure TChartShape.SetSeriesColor(AColor:TColor);
Begin
  inherited;
  Brush.Color:=AColor;
end;

procedure TChartShape.DrawShape(Is3D:Boolean; Const R:TRect);

  Procedure DrawDiagonalCross2D;
  begin
    With ParentChart.Canvas,R do
    Begin
      Line(Left,Top,Right+1,Bottom+1);
      Line(Left,Bottom,Right+1,Top-1);
    end;
  end;

  Procedure DrawDiagonalCross3D;
  begin
    With ParentChart.Canvas,R do
    Begin
      LineWithZ(TopLeft,BottomRight,MiddleZ);
      LineWithZ(Left,Bottom,Right,Top,MiddleZ);
    end;
  end;

var tmpMidX : Integer;
    tmpMidY : Integer;

  Procedure DrawCross3D;
  begin
    With ParentChart.Canvas,R do
    Begin
      VertLine3D(tmpMidX,Top,Bottom,MiddleZ);
      HorizLine3D(Left,Right,tmpMidY,MiddleZ);
    end;
  end;

  Procedure DrawCross2D;
  begin
    With ParentChart.Canvas,R do
    Begin
      DoVertLine(tmpMidX,Top,Bottom+1);
      DoHorizLine(Left,Right+1,tmpMidY);
    end;
  end;

  Procedure DoGradient;
  var tmpR : TRect;
  begin
    if (not Transparent) and Gradient.Visible then
    begin
      if Is3D then tmpR:=ParentChart.Canvas.CalcRect3D(R,MiddleZ)
              else tmpR:=R;
      if FStyle=chasCircle then
         ParentChart.Canvas.ClipEllipse(tmpR);
      Gradient.Draw(ParentChart.Canvas,tmpR);
      if FStyle=chasCircle then
         ParentChart.Canvas.UnClipRectangle;
      ParentChart.Canvas.Brush.Style:=bsClear;
    end;
  end;

begin
  With ParentChart.Canvas do
  Begin
    AssignVisiblePen(Self.Pen);
    if FTransparent then Brush.Style:=bsClear
                    else AssignBrush(Self.Brush,Self.SeriesColor);

    if Self.Brush.Color=clNone then { 5.02 }
       BackMode:=cbmTransparent
    else
       BackMode:=cbmOpaque;

    RectCenter(R,tmpMidX,tmpMidY);

    With R do
    if Is3D then
    Case Self.FStyle of
     chasRectangle      : begin
                            DoGradient;
                            RectangleWithZ(R,MiddleZ);
                          end;
     chasCircle         : begin
                            DoGradient;
                            EllipseWithZ(Left,Top,Right,Bottom,MiddleZ);
                          end;
     chasVertLine       : VertLine3D(tmpMidX,Top,Bottom,MiddleZ);
     chasHorizLine      : HorizLine3D(Left,Right,tmpMidY,MiddleZ);
     chasTriangle       : TriangleWithZ( TeePoint(Left,Bottom),
                                         TeePoint(tmpMidX,Top),
                                         BottomRight, MiddleZ );
     chasInvertTriangle : TriangleWithZ( TopLeft,
                                         TeePoint(tmpMidX,Bottom),
                                         TeePoint(Right,Top), MiddleZ);
     chasLine           : LineWithZ(TopLeft,BottomRight,MiddleZ);
     chasDiamond        : PlaneWithZ( TeePoint(Left,tmpMidY),
                                      TeePoint(tmpMidX,Top),
                                      TeePoint(Right,tmpMidY),
                                      TeePoint(tmpMidX,Bottom), MiddleZ );
     chasCube           : Cube(R,StartZ,EndZ,not FTransparent);
     chasCross          : DrawCross3D;
     chasDiagCross      : DrawDiagonalCross3D;
     chasStar           : begin DrawCross3D; DrawDiagonalCross3D; end;
     chasPyramid        : Pyramid(True,Left,Top,Right,Bottom,StartZ,EndZ,not FTransparent);
     chasInvertPyramid  : Pyramid(True,Left,Bottom,Right,Top,StartZ,EndZ,not FTransparent);
    end
    else
    Case Self.FStyle of
     chasRectangle      : if FRoundRectangle then
                             RoundRect(Left,Top,Right,Bottom,12,12)
                          else
                          begin
                            DoGradient;
                            Rectangle(TeeRect(R.Left,R.Top,R.Right+1,R.Bottom+1));
                          end;
     chasCircle         : begin
                            DoGradient;
                            Ellipse(R);
                          end;
     chasVertLine       : DoVertLine(tmpMidX,Top,Bottom);
     chasHorizLine      : DoHorizLine(Left,Right+1,tmpMidY);
     chasTriangle,
     chasPyramid        : Polygon( [ TeePoint(Left,Bottom),
                                     TeePoint(tmpMidX,Top),
                                     BottomRight] );
     chasInvertTriangle,
     chasInvertPyramid  : Polygon( [ TopLeft,
                                     TeePoint(tmpMidX,Bottom),
                                     TeePoint(Right,Top)]);
     chasLine           : Line(Left,Top,Right,Bottom);
     chasDiamond        : Polygon( [ TeePoint(Left,tmpMidY),
                                     TeePoint(tmpMidX,R.Top),
                                     TeePoint(Right,tmpMidY),
                                     TeePoint(tmpMidX,Bottom)] );
     chasCube           : Rectangle(R);
     chasCross          : DrawCross2D;
     chasDiagCross      : DrawDiagonalCross2D;
     chasStar           : begin DrawCross2D; DrawDiagonalCross2D; end;
    end;
  end;
end;

procedure TChartShape.DrawText(Const R:TRect);
Const ShapeHorizMargin=4;
      BrushColors:Array[Boolean] of TColor=(clBlack,clWhite);
var t        : Integer;
    tmpPosX  : Integer;
    tmpH     : Integer;
    tmpMidX  : Integer;
    tmpMidY  : Integer;
    tmpPosY  : Integer;
    tmpWidth : Integer;
begin
  With ParentChart,Canvas do
  if Self.FText.Count>0 then
  begin
    AssignFont(Self.Font);
    With Font do
         if Brush.Color=Color then Color:=BrushColors[Color=clBlack];
    tmpH:=FontHeight;
    RectCenter(R,tmpMidX,tmpMidY);
    Case FVertAlign of
      vaTop:    tmpPosY:=R.Top;
      vaCenter: tmpPosY:=tmpMidY-Round(tmpH*Self.FText.Count/2.0);
    else
      tmpPosY:=R.Bottom-Round(tmpH*Self.FText.Count);
    end;
    BackMode:=cbmTransparent;
    for t:=0 to Self.FText.Count-1 do
    begin
      tmpWidth:=TextWidth(FText[t]);
      Case FAlignment of
        taCenter       : tmpPosX:=tmpMidX-(tmpWidth div 2);
        taLeftJustify  : tmpPosX:=R.Left+Pen.Width+ShapeHorizMargin;
      else
        tmpPosX:=R.Right-Pen.Width-tmpWidth-ShapeHorizMargin;
      end;
      TextAlign:=TA_LEFT; { 5.01 }
      if FXYStyle=xysPixels then
         TextOut(tmpPosX,tmpPosY,FText[t])
      else
         TextOut3D(tmpPosX,tmpPosY,StartZ,FText[t]);
      Inc(tmpPosY,tmpH);
    end;
  end;
end;

Procedure TChartShape.SetShapeRectangle(Const ARect:TRect);
begin
  FXYStyle:=xysPixels;
  With ARect do
  begin
    X0:=Left;
    Y0:=Top;
    X1:=Right;
    Y1:=Bottom;
  end;
end;

Function TChartShape.GetShapeRectangle:TRect;
begin
  Case FXYStyle of
    xysPixels: result:=TeeRect( Trunc(X0), Trunc(Y0), Trunc(X1), Trunc(Y1) );
    xysAxis  : result:=TeeRect( CalcXPos(0),CalcYPos(0),CalcXPos(1),CalcYPos(1) );
  else
    With Result do
    begin
      Left:=CalcXPos(0);
      Top :=CalcYPos(0);
      Right:=Left+Trunc(X1);
      Bottom:=Top+Trunc(Y1);
    end;
  end;
end;

Function TChartShape.GetAdjustedRectangle:TRect;
begin
  result:=OrientRectangle(GetShapeRectangle);
  with result do
  begin
    if Top=Bottom then Bottom:=Top+1;
    if Left=Right then Right:=Left+1;
  end;
end;

procedure TChartShape.DrawValue(ValueIndex:Integer);
Var R        : TRect;
    DestRect : TRect;
    tmp      : Boolean;
Begin
  if (Count=2) and (ValueIndex=0) then
  begin
    R:=GetAdjustedRectangle;
    if {$IFNDEF CLX}Windows.{$ENDIF}IntersectRect(DestRect,R,ParentChart.ChartRect) then
    begin
      if FXYStyle=xysPixels then tmp:=False
                            else tmp:=ParentChart.View3D;
      if FStyle=chasLine then DrawShape(tmp,GetShapeRectangle)
                         else DrawShape(tmp,R);
      DrawText(R);
    end;
  end;
End;

Procedure TChartShape.AddDefaultPoints;
begin
  AddXY(  0,  0);
  AddXY(100,100);
end;

Procedure TChartShape.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Begin
  With RandomBounds(1) do
  if StepX=0 then AddDefaultPoints
  else
  begin
    AddXY( tmpX+(StepX/8.0), tmpY/2);
    AddXY( tmpX+StepX-(StepX/8.0),tmpY+RandomValue(Round(DifY)));
  end;
end;

Function TChartShape.Clicked(x,y:Integer):Integer;
var R       : TRect;
    tmp     : Boolean;
    tmpMidX : Integer;
    tmpMidY : Integer;
    P       : TPoint;
Begin
  if (ParentChart<>nil) then ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

  P.X:=X;
  P.Y:=Y;
  R:=GetShapeRectangle;
  RectCenter(R,tmpMidX,tmpMidY);

  Case FStyle of
     chasVertLine: tmp:=PointInLine(P,tmpMidX,R.Top,tmpMidX,R.Bottom);
    chasHorizLine: tmp:=PointInLine(P,R.Left,tmpMidY,R.Right,tmpMidY);
         chasLine: tmp:=PointInLine(P,R.TopLeft,R.BottomRight);
      chasDiamond: tmp:=PointInPolygon( P,[ TeePoint(tmpMidX,R.Top),
                                            TeePoint(R.Right,tmpMidY),
                                            TeePoint(tmpMidX,R.Bottom),
                                            TeePoint(R.Left,tmpMidY)] );
     chasTriangle,
     chasPyramid : tmp:=PointInTriangle( P,R.Left,R.Right,R.Bottom,R.Top);
chasInvertTriangle,
chasInvertPyramid: tmp:=PointInTriangle( P,R.Left,R.Right,R.Top,R.Bottom);
       chasCircle: tmp:=PointInEllipse(P,R);
  else
    tmp:=PointInRect(OrientRectangle(R),x,y);  // 7.0 #1227
  end;

  if tmp then result:=0 else result:=TeeNoPointClicked;
end;

Procedure TChartShape.PrepareForGallery(IsEnabled:Boolean);
Const EnabledColor1:Array[Boolean] of TColor=(clSilver,clBlue);
      EnabledColor2:Array[Boolean] of TColor=(clSilver,clRed);
Begin
  inherited;

  if IsEnabled then 
     Font.Color:=clYellow
  else
     Font.Color:=clDkGray;

  Font.Style:=[fsBold];
  Font.Size:=12;
  Text.Clear;

  if ParentChart.SeriesList.IndexOf(Self)=1 then
  begin
    Style:=chasCircle;
    Brush.Color:=EnabledColor1[IsEnabled];
    Text.Add(TeeMsg_ShapeGallery1);
  end
  else
  begin
    Style:=chasTriangle;
    Brush.Color:=EnabledColor2[IsEnabled];
    Text.Add(TeeMsg_ShapeGallery2);
  end
end;

class Function TChartShape.GetEditorClass:String;
Begin
  result:='TChartShapeEditor';  { <-- dont translate }
end;

Procedure TChartShape.Assign(Source:TPersistent);
begin
  if Source is TChartShape then
  With TChartShape(Source) do
  begin
    Self.FAlignment     :=FAlignment;
    Self.Font           :=FFont;
    Self.Gradient       :=Gradient;
    Self.FRoundRectangle:=FRoundRectangle;
    Self.FStyle         :=FStyle;
    Self.Text           :=FText;
    Self.FTransparent   :=FTransparent;
    Self.FVertAlign     :=FVertAlign;
    Self.FXYStyle       :=FXYStyle;
  end;
  inherited;
end;

Function TChartShape.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TChartShape;
end;

procedure TChartShape.SetFont(Value: TTeeFont);
begin
  FFont.Assign(Value);
end;

procedure TChartShape.SetAlignment(Value: TAlignment);
begin
  if FAlignment<>Value then
  begin
    FAlignment:=Value;
    Repaint;
  end;
end;

procedure TChartShape.SetText(Value : TStrings);
begin
  FText.Assign(Value);
  Repaint;
end;

procedure TChartShape.SetTransparent(Value: Boolean);
begin
  SetBooleanProperty(FTransparent,Value);
end;

procedure TChartShape.SetRoundRectangle(Value: Boolean);
begin
  SetBooleanProperty(FRoundRectangle,Value);
end;

procedure TChartShape.SetXYStyle(Value: TChartShapeXYStyle);
begin
  if FXYStyle<>Value then
  begin
    FXYStyle:=Value;
    Repaint;
  end;
end;

Function TChartShape.UseAxis:Boolean;
begin
  result:=XYStyle<>xysPixels;
end;

Procedure TChartShape.CalcZOrder;
begin
  if UseAxis then inherited;
end;

Function TChartShape.MoreSameZOrder:Boolean;
begin
  result:=False;
end;

procedure TChartShape.SetVertAlign(Value: TTeeVertAlign);
begin
  if FVertAlign<>Value then
  begin
    FVertAlign:=Value;
    Repaint;
  end;
end;

class procedure TChartShape.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Rectangle);
  AddSubChart(TeeMsg_VertLine);
  AddSubChart(TeeMsg_HorizLine);
  AddSubChart(TeeMsg_Ellipse);
  AddSubChart(TeeMsg_DownTri);
  AddSubChart(TeeMsg_Line);
  AddSubChart(TeeMsg_Diamond);
  AddSubChart(TeeMsg_Cube);
  AddSubChart(TeeMsg_Cross);
  AddSubChart(TeeMsg_DiagCross);
  AddSubChart(TeeMsg_Star);
  AddSubChart(TeeMsg_Pyramid);
  AddSubChart(TeeMsg_InvPyramid);
  AddSubChart(TeeMsg_Hollow);
end;

class procedure TChartShape.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TChartShape(ASeries) do
  Case Index of
    1: Style:=chasRectangle;
    2: Style:=chasVertLine;
    3: Style:=chasHorizLine;
    4: Style:=chasCircle;
    5: Style:=chasInvertTriangle;
    6: Style:=chasLine;
    7: Style:=chasDiamond;
    8: Style:=chasCube;
    9: Style:=chasCross;
   10: Style:=chasDiagCross;
   11: Style:=chasStar;
   12: Style:=chasPyramid;
   13: Style:=chasInvertPyramid;
   14: Transparent:=not Transparent;
  end;
end;

procedure TChartShape.SetGradient(const Value: TChartGradient);
begin
  FGradient.Assign(Value);
end;

initialization
  RegisterTeeSeries(TChartShape,
     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryShape,
     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStandard, 2);
end.
