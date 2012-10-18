{******************************************}
{    TeeChart Map Series                   }
{ Copyright (c) 2000-2004 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeMapSeries;
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
      {$IFDEF D6}
      Types,
      {$ENDIF}
     {$ENDIF}
     TeEngine, TeCanvas, TeeProcs, TeeSurfa;

type
  TTeePolygon=class;

  TPolygonSeries=class(TChartSeries)
  protected
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure NotifyValue(ValueEvent:TValueEvent; ValueIndex:Integer); override;
    procedure PrepareLegendCanvas(ValueIndex:Integer; Var BackColor:TColor;
                                Var BrushStyle:TBrushStyle); override;
    Procedure SetActive(Value:Boolean); override;
    Procedure SetSeriesColor(AColor:TColor); override;
  public
    Procedure FillSampleValues(NumValues:Integer); override;
    Function Polygon:TTeePolygon;
  end;

  TMapSeries=class;

  TTeePolygon=class(TCollectionItem)
  private
    FClosed      : Boolean;
    FGradient    : TChartGradient;
    FParentBrush : Boolean;
    FParentPen   : Boolean;
    FPoints      : TPolygonSeries;
    FTransparency: TTeeTransparency;

    IPoints      : TPointArray;

    {$IFDEF CLR}
    procedure CanvasChanged(Sender: TObject);
    {$ENDIF}

    function GetBrush: TChartBrush;
    function GetColor: TColor;
    function GetGradient: TChartGradient;
    function GetPen: TChartPen;
    Function GetText:String;
    function GetZ: Double;

    procedure SetBrush(const Value: TChartBrush);
    procedure SetClosed(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetParentBrush(const Value: Boolean);
    procedure SetParentPen(const Value: Boolean);
    procedure SetPen(const Value: TChartPen);
    Procedure SetText(Const Value:String);
    procedure SetTransparency(const Value: TTeeTransparency);
    procedure SetZ(const Value: Double);

    //Function ZPosition:Double;
  public
    ParentSeries : TMapSeries;

    Constructor Create(Collection:TCollection); override;
    Destructor Destroy; override;

    Function AddXY(Const Point:TFloatPoint):Integer; overload;
    Function AddXY(Const X,Y:Double):Integer; overload;
    Procedure Draw(ACanvas:TCanvas3D; ValueIndex:Integer);
    Function GetPoints:TPointArray;
    Function Visible:Boolean;

    Function Bounds:TRect;  // 7.0
    property Points:TPolygonSeries read FPoints;
  published
    property Brush:TChartBrush read GetBrush write SetBrush;
    property Closed:Boolean read FClosed write SetClosed default True;
    property Color:TColor read GetColor write SetColor default clWhite;
    property Gradient:TChartGradient read GetGradient write SetGradient;
    property ParentBrush:Boolean read FParentBrush write SetParentBrush default True;
    property ParentPen:Boolean read FParentPen write SetParentPen default True;
    property Pen:TChartPen read GetPen write SetPen;
    property Text:String read GetText write SetText;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;  // 7.0
    property Z:Double read GetZ write SetZ;
  end;

  TTeePolygonList=class(TOwnedCollection)
  private
    Procedure Delete(Start,Quantity:Integer); overload;
    Function Get(Index:Integer):TTeePolygon;
    Procedure Put(Index:Integer; Const Value:TTeePolygon);
    function GetByName(const AName: String): TTeePolygon;
  public
    Function Add:TTeePolygon;
    Function Owner:TMapSeries;
    property Polygon[Index:Integer]:TTeePolygon read Get write Put; default;
    property ByName[const AName:String]:TTeePolygon read GetByName;  // 7.0
  end;

  TMapSeries=class(TCustom3DPaletteSeries)
  private
    FShapes : TTeePolygonList;
    I3DList : Array of TTeePolygon;

    Function CompareOrder(a,b:Integer):Integer;
    Function GetPolygon(Index:Integer):TTeePolygon; // 7.0
    procedure SetShapes(const Value: TTeePolygonList);
    Procedure SwapPolygon(a,b:Integer);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    class procedure CreateSubGallery(AddSubChart: TChartSubGalleryProc); override;
    Procedure DrawAllValues; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure DrawValue(ValueIndex:Integer); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    procedure PrepareForGallery(IsEnabled:Boolean); override;
    class procedure SetSubGallery(ASeries: TChartSeries; Index: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Clear; override;
    Function Clicked(x,y:Integer):Integer; override;
    Procedure Delete(ValueIndex:Integer); overload; override;
    Procedure Delete(Start,Quantity:Integer; RemoveGap:Boolean=False); overload; override;
    Function MaxXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinXValue:Double; override;
    Function MinYValue:Double; override;
    Function NumSampleValues:Integer; override;
    procedure SwapValueIndex(a,b:Integer); override;

    property Polygon[Index:Integer]:TTeePolygon read GetPolygon; default; // 7.0
  published
    { Published declarations }
    property Active;
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

    property Brush;
    property EndColor;
    property MidColor;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property Shapes:TTeePolygonList read FShapes write SetShapes stored False;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetColor;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

Uses Math,
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, TeeProCo, Chart;

{$IFNDEF CLR}
type
  TSeriesAccess=class(TCustomChartElement);
{$ENDIF}

{ TTeePolygon }
constructor TTeePolygon.Create(Collection: TCollection);
begin
  inherited;
  ParentSeries:=TTeePolygonList(Collection).Owner as TMapSeries;

  FClosed:=True;
  FPoints:=TPolygonSeries.Create(nil);  // 7.0
  FPoints.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Self);
  FPoints.XValues.Order:=loNone;
  FPoints.ShowInLegend:=False;

  FParentPen:=True;
  FParentBrush:=True;
  ParentSeries.AddXY(0,0);
end;

Destructor TTeePolygon.Destroy;
begin
  IPoints:=nil;
  FPoints.Free;
  FGradient.Free;
  inherited;
end;

function TTeePolygon.AddXY(const Point:TFloatPoint): Integer;
begin
  result:=FPoints.AddXY(Point.X,Point.Y);
end;

function TTeePolygon.AddXY(const X,Y: Double): Integer;
begin
  result:=FPoints.AddXY(X,Y);
end;

{ return the array of Points in screen (pixel) coordinates }
Function TTeePolygon.GetPoints:TPointArray;
var t : Integer;
    tmpHoriz : TChartAxis;
    tmpVert  : TChartAxis;
    tmpX     : TChartValues;
    tmpY     : TChartValues;
begin
  SetLength(IPoints,FPoints.Count);
  result:=IPoints;

  tmpHoriz:=ParentSeries.GetHorizAxis;
  tmpVert:=ParentSeries.GetVertAxis;

  tmpX:=FPoints.XValues.Value;
  tmpY:=FPoints.YValues.Value;

  for t:=0 to FPoints.Count-1 do
  begin
    result[t].X:=tmpHoriz.CalcPosValue(tmpX[t]);
    result[t].Y:=tmpVert.CalcPosValue(tmpY[t]);
  end;
end;

// Returns True if the polygon contains points that lie inside
// the chart "ChartRect" (the visible chart area).
Function TTeePolygon.Visible:Boolean;

  // optimized version of InteresectRect
  function ContainsRect(R1:TRect; const R2:TRect): Boolean;
  begin
    if R2.Left > R1.Left then R1.Left := R2.Left;
    if R2.Right < R1.Right then R1.Right := R2.Right;

    if R2.Top > R1.Top then R1.Top := R2.Top;
    if R2.Bottom < R1.Bottom then R1.Bottom := R2.Bottom;
    result := not ((R1.Right < R1.Left) or (R1.Bottom < R1.Top));
  end;

var tmpR : TRect;
    tmpChart : TCustomAxisPanel;
begin
  tmpChart:=ParentSeries.ParentChart;
  result:=not tmpChart.ClipPoints;

  if not result then
  begin
    with ParentSeries.GetHorizAxis do
    begin
      tmpR.Left:=CalcPosValue(FPoints.XValues.MinValue);
      tmpR.Right:=CalcPosValue(FPoints.XValues.MaxValue);
    end;

    with ParentSeries.GetVertAxis do
    begin
      tmpR.Top:=CalcPosValue(FPoints.YValues.MaxValue);
      tmpR.Bottom:=CalcPosValue(FPoints.YValues.MinValue);
    end;

    result:=ContainsRect(tmpChart.ChartRect, tmpR);
  end;
end;

{ draw the polygon... }
procedure TTeePolygon.Draw(ACanvas: TCanvas3D; ValueIndex:Integer);
Var tmpZ  : Integer;
    tmpIs3D : Boolean;
    tmpBlend : TTeeBlend;
    tmpR  : TRect;
begin
  if FPoints.Active and (FPoints.Count>0) and Visible then
  begin
    // set pen and brush...
    if ParentPen then ACanvas.AssignVisiblePen(ParentSeries.Pen)
                 else ACanvas.AssignVisiblePen(Self.Pen);
    if ParentBrush then ACanvas.AssignBrush(ParentSeries.Brush,ParentSeries.ValueColor[ValueIndex])
                   else ACanvas.AssignBrush(Self.Brush,ParentSeries.ValueColor[ValueIndex]);

    GetPoints;

    tmpIs3D:=ParentSeries.ParentChart.View3D;

    // Calculate "Z" depth position
    if tmpIs3D then tmpZ:=ParentSeries.CalcZPos(Index)
               else tmpZ:=0;

    if Transparency>0 then
    begin
      tmpR:=PolygonBounds(IPoints);
      tmpBlend:=ACanvas.BeginBlending(ACanvas.RectFromRectZ(tmpR,tmpZ),Transparency)
    end
    else
       tmpBlend:=nil;

    // Fill background with gradient...
    if Assigned(Self.FGradient) and Self.FGradient.Visible
       and ParentSeries.ParentChart.CanClip then
    begin
      Self.Gradient.Draw(ACanvas,IPoints,tmpZ,tmpIs3D);
      ACanvas.Brush.Style:=bsClear;
    end;

    // Draw the shape...

    with ACanvas do
    if tmpIs3D then
    begin
      if Self.Closed then
         PolygonWithZ(IPoints,tmpZ)
      else
         {$IFDEF D5}
         Polyline(IPoints,tmpZ);
         {$ELSE}
         Polyline(IPoints);  // D4: Pending
         {$ENDIF}
    end
    else
    begin
      if Self.Closed then
         Polygon(IPoints)
      else
         Polyline(IPoints);
    end;

    if Assigned(tmpBlend) then
       ACanvas.EndBlending(tmpBlend);
  end;
end;

function TTeePolygon.GetBrush: TChartBrush;
begin
  result:=FPoints.Brush;
end;

function TTeePolygon.GetColor: TColor;
begin
  result:=ParentSeries.ValueColor[Index];
end;

function TTeePolygon.GetPen: TChartPen;
begin
  result:=FPoints.Pen;
end;

procedure TTeePolygon.SetBrush(const Value: TChartBrush);
begin
  FPoints.Brush:=Value;
end;

procedure TTeePolygon.SetColor(const Value: TColor);
begin
  Points.SeriesColor:=Value;
end;

procedure TTeePolygon.SetClosed(const Value: Boolean);
begin
  ParentSeries.SetBooleanProperty(FClosed,Value);
end;

Function TTeePolygon.GetGradient: TChartGradient;
begin
  if not Assigned(FGradient) then
     FGradient:=TChartGradient.Create({$IFNDEF CLR}TSeriesAccess(ParentSeries).{$ENDIF}CanvasChanged);

  result:=FGradient;
end;

procedure TTeePolygon.SetGradient(const Value: TChartGradient);
begin
  if Assigned(Value) then
     Gradient.Assign(Value)
  else
     FreeAndNil(FGradient);
end;

procedure TTeePolygon.SetPen(const Value: TChartPen);
begin
  FPoints.Pen:=Value;
end;

procedure TTeePolygon.SetZ(const Value: Double);
begin
  ParentSeries.ZValues.Value[Index]:=Value;
  ParentSeries.Repaint;
end;

function TTeePolygon.GetZ: Double;
begin
  result:=ParentSeries.ZValues.Value[Index];
end;

function TTeePolygon.GetText: String;
begin
  result:=ParentSeries.Labels[Index];
end;

procedure TTeePolygon.SetText(const Value: String);
begin
  ParentSeries.Labels[Index]:=Value;
end;

procedure TTeePolygon.SetParentBrush(const Value: Boolean);
begin
  ParentSeries.SetBooleanProperty(FParentBrush,Value);
end;

procedure TTeePolygon.SetParentPen(const Value: Boolean);
begin
  ParentSeries.SetBooleanProperty(FParentPen,Value);
end;

(*
function TTeePolygon.ZPosition:Integer;
var x : Integer;
    y : Integer;
    P : TPoint;
    tmpZ : Integer;
begin
  result:=0;
  With ParentSeries do
  if FPoints.Count>0 then
  begin
    X:=GetHorizAxis.CalcPosValue(FPoints.XValues.Value[0]);
    Y:=GetVertAxis.CalcPosValue(FPoints.YValues.Value[0]);
    tmpZ:=ParentSeries.CalcZPos(0);
    P:=ParentSeries.ParentChart.Canvas.Calculate3DPosition(TeePoint(x,y),tmpZ);
  end;
end;
*)

function TTeePolygon.Bounds: TRect;  // 7.0
begin
  result:=PolygonBounds(GetPoints);
end;

{$IFDEF CLR}
procedure TTeePolygon.CanvasChanged(Sender: TObject);
begin
  ParentSeries.Repaint;
end;
{$ENDIF}

procedure TTeePolygon.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    ParentSeries.Repaint;
  end;
end;

{ TTeePolygonList }
type TComponentAccess=class(TComponent);

function TTeePolygonList.Add: TTeePolygon;
{$IFNDEF CLR}
var p : TPolygonSeries;
{$ENDIF}
begin
  result:=inherited Add as TTeePolygon;
  {$IFNDEF CLR}
  p:=result.Points;
  TComponentAccess(p).SetDesigning(False);
  {$ENDIF}
end;

procedure TTeePolygonList.Delete(Start, Quantity: Integer);
var t: Integer;
begin
  for t:=1 to Quantity do Items[Start].Free;
end;

function TTeePolygonList.Get(Index: Integer): TTeePolygon;
begin
  result:=TTeePolygon(Items[Index]);
end;

function TTeePolygonList.GetByName(const AName: String): TTeePolygon;
var t   : Integer;
    tmp : String;
begin
  result:=nil;
  tmp:=UpperCase(AName);

  for t:=0 to Count-1 do
  if UpperCase(Polygon[t].Text)=tmp then
  begin
    result:=Polygon[t];
    break;
  end;
end;

function TTeePolygonList.Owner: TMapSeries;
begin
  result:=TMapSeries(GetOwner);
end;

procedure TTeePolygonList.Put(Index: Integer; const Value: TTeePolygon);
begin
  Items[Index]:=Value;
end;

{ TMapSeries }
Constructor TMapSeries.Create(AOwner: TComponent);
begin
  inherited;
  FShapes:=TTeePolygonList.Create(Self,TTeePolygon);
  CalcVisiblePoints:=False;
  YMandatory:=False;
  MandatoryValueList:=ZValues;
end;

Destructor TMapSeries.Destroy;
begin
  FreeAndNil(FShapes);
  inherited;
end;

procedure TMapSeries.DrawValue(ValueIndex: Integer);
begin
  if Shapes.Count>ValueIndex then
     Shapes[ValueIndex].Draw(ParentChart.Canvas,ValueIndex);
end;

Procedure TMapSeries.Delete(ValueIndex:Integer);
begin
  inherited;
  if Assigned(FShapes) then Shapes[ValueIndex].Free;
end;

Procedure TMapSeries.Delete(Start,Quantity:Integer; RemoveGap:Boolean=False);
begin
  inherited;
  if Assigned(FShapes) then FShapes.Delete(Start,Quantity);
end;

function TMapSeries.MaxXValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MaxXValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Max(result,Shapes[t].FPoints.MaxXValue);
  end;
end;

function TMapSeries.MaxYValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MaxYValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Max(result,Shapes[t].FPoints.MaxYValue);
  end;
end;

function TMapSeries.MinXValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MinXValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Min(result,Shapes[t].FPoints.MinXValue);
  end;
end;

function TMapSeries.MinYValue: Double;
var t : Integer;
begin
  if Shapes.Count=0 then result:=0
  else
  begin
    result:=Shapes[0].FPoints.MinYValue;
    for t:=1 to Shapes.Count-1 do
      result:=Math.Min(result,Shapes[t].FPoints.MinYValue);
  end;
end;

procedure TMapSeries.PrepareForGallery(IsEnabled:Boolean);
var t : Integer;
begin
  inherited;
  if not IsEnabled then
     for t:=0 to Count-1 do Shapes[t].Color:=clSilver;
end;

procedure TMapSeries.SwapValueIndex(a,b:Integer);
begin
  inherited;
  Shapes[a].Index:=b;
  Repaint;
end;

procedure TMapSeries.SetShapes(const Value: TTeePolygonList);
begin
  FShapes.Assign(Value);
end;

procedure TMapSeries.CalcHorizMargins(var LeftMargin,
  RightMargin: Integer);
begin
  inherited;
  if Pen.Visible then
  begin
    Inc(LeftMargin,Pen.Width);
    Inc(RightMargin,Pen.Width);
  end;
end;

procedure TMapSeries.CalcVerticalMargins(var TopMargin,
  BottomMargin: Integer);
begin
  inherited;
  Inc(BottomMargin);
  if Pen.Visible then
  begin
    Inc(TopMargin,Pen.Width);
    Inc(BottomMargin,Pen.Width);
  end;
end;

Function TMapSeries.NumSampleValues;
begin
  result:=12;
end;

procedure TMapSeries.AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False);

  Procedure AddShape(Const X,Y:Array of Integer; Const AText:String);
  var t : Integer;
      tmpX : Integer;
      tmpY : Integer;
  begin
    if Count>NumSampleValues then
    begin
      tmpX:=RandomValue(NumSampleValues);
      tmpY:=RandomValue(NumSampleValues);
    end
    else
    begin
      tmpX:=0;
      tmpY:=0;
    end;

    With Shapes.Add do
    begin
      for t:=Low(X) to High(X) do
          AddXY(tmpX+X[t],tmpY+Y[t]);
//      Color:=AColor;  7.0 removed
      Text:=AText;
      Z:=RandomValue(1000)/1000.0;
    end;
  end;

Const AX:Array[0..13] of Integer=(1,3,4,4,5,5,6,6,4,3,2,1,2,2);
      AY:Array[0..13] of Integer=(7,5,5,7,8,9,10,11,11,12,12,11,10,8);
      BX:Array[0..8]  of Integer=(5,7,8,8,7,6,5,4,4);
      BY:Array[0..8]  of Integer=(4,4,5,6,7,7,8,7,5);
      CX:Array[0..15] of Integer=(9,10,11,11,12,9,8,7,6,6,5,5,6,7,8,8);
      CY:Array[0..15] of Integer=(5,6,6,7,8,11,11,12,11,10,9,8,7,7,6,5);
      DX:Array[0..7]  of Integer=(12,14,15,14,13,12,11,11);
      DY:Array[0..7]  of Integer=(5,5,6,7,7,8,7,6);
      EX:Array[0..10] of Integer=(4,6,7,7,6,6,5,4,3,3,2);
      EY:Array[0..10] of Integer=(11,11,12,13,14,15,16,16,15,14,13);
      FX:Array[0..11] of Integer=(7,8,9,11,10,8,7,6,5,5,6,6);
      FY:Array[0..11] of Integer=(13,14,14,16,17,17,18,18,17,16,15,14);
      GX:Array[0..11] of Integer=(10,12,12,14,13,11,9,8,7,7,8,9);
      GY:Array[0..11] of Integer=(10,12,13,15,16,16,14,14,13,12,11,11);
      HX:Array[0..9]  of Integer=(17,19,18,18,17,15,14,13,15,16);
      HY:Array[0..9]  of Integer=(11,13,14,16,17,15,15,14,12,12);
      IX:Array[0..14] of Integer=(15,16,17,16,15,14,14,13,12,11,10,11,12,13,14);
      IY:Array[0..14] of Integer=(6,6,7,8,8,9,10,11,12,11,10,9,8,7,7);
      JX:Array[0..11] of Integer=(15,16,16,17,17,16,15,13,12,12,14,14);
      JY:Array[0..11] of Integer=(8,8,9,10,11,12,12,14,13,12,10,9);
      KX:Array[0..9]  of Integer=(17,19,20,20,19,17,16,16,17,16);
      KY:Array[0..9]  of Integer=(5,5,6,8,8,10,9,8,7,6);
      LX:Array[0..6]  of Integer=(19,20,21,21,19,17,17);
      LY:Array[0..6]  of Integer=(8,8,9,11,13,11,10);

var t : Integer;
begin
  for t:=0 to NumValues-1 do
  case t mod NumSampleValues of
    0: AddShape(AX,AY,'A');
    1: AddShape(BX,BY,'B');
    2: AddShape(CX,CY,'C');
    3: AddShape(DX,DY,'D');
    4: AddShape(EX,EY,'E');
    5: AddShape(FX,FY,'F');
    6: AddShape(GX,GY,'G');
    7: AddShape(HX,HY,'H');
    8: AddShape(IX,IY,'I');
    9: AddShape(JX,JY,'J');
   10: AddShape(KX,KY,'K');
   11: AddShape(LX,LY,'L');
  end;
end;

function TMapSeries.Clicked(x, y: Integer): Integer;
var tmpClip : Boolean;
    tmpRect : TRect;

  function IsShapeVisible(Shape:TPolygonSeries):Boolean;
  var tmp  : Integer;
      tmp2 : Integer;
  begin
    if tmpClip then
    begin
      with GetHorizAxis do
      begin
        tmp:=CalcPosValue(Shape.XValues.MinValue);

        if (tmp<tmpRect.Left) or (tmp>tmpRect.Right) then
        begin
          tmp2:=CalcPosValue(Shape.XValues.MaxValue);

          if (tmp2<tmpRect.Left) or
             ((tmp2>tmpRect.Right) and (tmp>tmpRect.Right)) then
          begin
            result:=False;
            Exit;
          end;
        end;
      end;

      with GetVertAxis do
      begin
        tmp:=CalcPosValue(Shape.YValues.MaxValue);

        if (tmp<tmpRect.Top) or (tmp>tmpRect.Bottom) then
        begin
          tmp2:=CalcPosValue(Shape.YValues.MinValue);

          result:=( (tmp2>=tmpRect.Top) and (tmp2<=tmpRect.Bottom) ) or
                  ( (tmp2>tmpRect.Bottom) and (tmp<tmpRect.Top) );
        end
        else result:=True;
      end;
    end
    else result:=True;
  end;

var t    : Integer;
    tmpX : Integer;
    tmpY : Integer;
    tmpChart : TCustomAxisPanel;
    tmpshape : TTeePolygon;
begin
  result:=TeeNoPointClicked;
  tmpChart:=ParentChart;

  if Assigned(tmpChart) then
  begin
    tmpClip:=tmpChart.ClipPoints;
    tmpRect:=tmpChart.ChartRect;

    for t:=0 to Shapes.Count-1 do
    begin
      tmpShape:=Shapes[t];

      if IsShapeVisible(tmpShape.FPoints) then
      begin
        tmpX:=X;
        tmpY:=Y;

        tmpChart.Canvas.Calculate2DPosition(tmpX,tmpY,CalcZPos(t));

        if PointInPolygon(TeePoint(tmpX,tmpY),tmpShape.GetPoints) then
        begin
          result:=t;
          break;
        end;
      end;
    end;
  end;
end;

procedure TMapSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  if Shapes.Count>ValueIndex then
  begin
    with Shapes[ValueIndex].Bounds do
    begin
      APosition.LeftTop.X:=((Right+Left) div 2)-(APosition.Width div 2);
      APosition.LeftTop.Y:=((Top+Bottom) div 2)-(APosition.Height div 2);
    end;

    //    Marks.ZPosition:=CalcZPos(ValueIndex);  7.0 already done in inherited
  end;

  inherited;
end;

class function TMapSeries.GetEditorClass: String;
begin
  result:='TMapSeriesEditor';
end;

procedure TMapSeries.Clear;
begin
  inherited;
  if Assigned(Shapes) then Shapes.Clear;
end;

class procedure TMapSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Colors);
end;

class procedure TMapSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TMapSeries(ASeries) do
  Case Index of
    2: ColorEachPoint:=True;
  else inherited;
  end
end;

procedure TMapSeries.GalleryChanged3D(Is3D: Boolean);
begin { 5.02 }
  if Is3D then inherited
          else ParentChart.View3D:=False;
end;

Function TMapSeries.CompareOrder(a,b:Integer):Integer;
var tmpA : Double;
    tmpB : Double;
begin
  tmpA:=I3DList[a].Z;  //ZPosition;
  tmpB:=I3DList[b].Z;  //ZPosition;
  if tmpA>tmpB then result:=1
  else
  if tmpA<tmpB then result:=-1
  else
     result:=0;
end;

Function TMapSeries.GetPolygon(Index:Integer):TTeePolygon; // 7.0
begin
  result:=FShapes[Index];
end;

Procedure TMapSeries.SwapPolygon(a,b:Integer);
var tmp : TTeePolygon;
begin
  tmp:=I3DList[b];
  I3DList[b]:=I3DList[a];
  I3DList[a]:=tmp;
end;

procedure TMapSeries.DrawAllValues;

  Procedure DrawAllSorted;
  var t : Integer;
      tmpCount : Integer;
  begin
    tmpCount:=Shapes.Count;

    if tmpCount>0 then
    begin
      SetLength(I3DList,tmpCount);
      try
        for t:=0 to tmpCount-1 do I3DList[t]:=Shapes.Get(t);
        TeeSort(0,tmpCount-1,CompareOrder,SwapPolygon);
        for t:=tmpCount-1 downto 0 do
            I3DList[t].Draw(ParentChart.Canvas,I3DList[t].Index);
      finally
        I3DList:=nil;
      end;
    end;
  end;

begin
  if ParentChart.View3D then DrawAllSorted
                        else inherited;
end;

{ TPolygonSeries }
procedure TPolygonSeries.NotifyValue(ValueEvent: TValueEvent;
  ValueIndex: Integer);
begin
  inherited;
  Polygon.ParentSeries.Repaint;
end;

procedure TPolygonSeries.SetActive(Value: Boolean);
begin
  inherited;
  Polygon.ParentSeries.Repaint;
end;

Function TPolygonSeries.Polygon:TTeePolygon;
begin
  {$IFDEF CLR}
  result:=TTeePolygon(TObject(Tag));
  {$ELSE}
  result:=TTeePolygon(Tag);
  {$ENDIF}
end;

procedure TPolygonSeries.SetSeriesColor(AColor: TColor);
begin
  inherited;

  // Prevent changing color when caller is Chart.PaintSeriesLegend
  if not Assigned(ParentChart) then
     Polygon.ParentSeries.ValueColor[Polygon.Index]:=AColor;
end;

procedure TPolygonSeries.PrepareLegendCanvas(ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle);
begin
  inherited;

  with Polygon do { 5.02 }
  begin
    ParentSeries.DoBeforeDrawChart;

    if (not Assigned(FGradient)) or (not Gradient.Visible) then
       ParentChart.Canvas.Brush.Color:=Color;
  end;
end;

procedure TPolygonSeries.DrawLegendShape(ValueIndex: Integer;
  const Rect: TRect);
begin
  if Assigned(Polygon.FGradient) then
     with Polygon.Gradient do { 5.02 }
     if Visible then Draw(ParentChart.Canvas,Rect)
                else inherited
  else
    inherited;
end;

procedure TPolygonSeries.FillSampleValues(NumValues: Integer);
begin { do nothing, sample values are provided by Owner Map Series }
end;

initialization
  RegisterTeeSeries( TMapSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryMap,
                                 {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,1);
finalization
  UnRegisterTeeSeries([TMapSeries]);
end.
