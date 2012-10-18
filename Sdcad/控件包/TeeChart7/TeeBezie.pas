{**********************************************}
{   TBezierSeries Component                    }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeBezie;
{$I TeeDefs.inc}

{ This Series component is derived from PointLine Series.
  It draws PolyBezier curves using every 3 points in the Series.
  The first point in the Series determines the origin.

  The LinePen property controls the Bezier curve color, width and style.
  The inherited Pointer property is used to draw the control points. }
interface

uses {$IFDEF CLR}
     Windows,
     Classes,
     Types,
     Graphics,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeEngine, Chart, Series, TeCanvas;

type
  TBezierStyle=(bsWindows, bsBezier3, bsBezier4);

  TBezierSeries=class(TCustomSeries)
  private
    { Private declarations }
    FBezierStyle     : TBezierStyle;
    FNumBezierPoints : Integer;
    Procedure SetBezierPoints(Value:Integer);
    procedure SetBezierStyle(const Value: TBezierStyle);
  protected
    { Protected declarations }
    procedure DrawAllValues; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetSeriesColor(AColor:TColor); override;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Procedure Assign(Source:TPersistent); override;
  published
    { Published declarations }
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

    property BezierStyle:TBezierStyle read FBezierStyle write SetBezierStyle
                                      default bsWindows;
    property LinePen;
    property NumBezierPoints:Integer read FNumBezierPoints
                                     write SetBezierPoints default 32;
    property Pointer;
    property XValues;
    property YValues;
   { events }
    property OnClickPointer;
  end;

implementation

Uses {$IFNDEF CLR}
     Math,
     {$ENDIF}
     TeeConst, TeeProCo;

Constructor TBezierSeries.Create(AOwner:TComponent);
begin
  inherited;
  FBezierStyle:=bsWindows;
  FNumBezierPoints:=32;
end;

Procedure TBezierSeries.SetBezierPoints(Value:Integer);
begin
  if Value<2 then Raise ChartException.Create(TeeMsg_LowBezierPoints);
  SetIntegerProperty(FNumBezierPoints,Value);
end;

procedure TBezierSeries.DrawAllValues;
type PBezierPoints   = ^TBezierPoints;
     TBezierPoints   = Array[0..0] of TPoint;
     TBezierMaxPoints= Array of TPoint;
var tmpPoints : TBezierMaxPoints;

  Procedure Bezier(NumPoints,First:Integer);
  var mu    : Double;
      mum1  : Double;
      mum12 : Double;
      mum13 : Double;
      mu2   : Double;
      mu3   : Double;
      P     : TPoint;
      P1    : TPoint;
      P2    : TPoint;
      P3    : TPoint;
      P4    : TPoint;
      tt    : Integer;
  begin
    if Count>First then
    begin
      if ColorEachLine then
         ParentChart.Canvas.AssignVisiblePenColor(LinePen,ValueColor[First]);

      if NumPoints=4 then
      begin
        P1:=tmpPoints[First-3];
        P2:=tmpPoints[First-2];
        P3:=tmpPoints[First-1];
        P4:=tmpPoints[First];
      end
      else
      begin
        P1:=tmpPoints[First-2];
        P2:=tmpPoints[First-1];
        P3:=tmpPoints[First];
      end;

      for tt:=1 to FNumBezierPoints do
      begin
        mu:=tt/FNumBezierPoints;
        mu2:=Sqr(mu);
        mum1:=1-mu;

        if NumPoints=3 then
        begin
          mum12:=Sqr(mum1);
          p.x:=Round(p1.x * mum12 + 2*p2.x*mum1*mu + p3.x*mu2);
          p.y:=Round(p1.y * mum12 + 2*p2.y*mum1*mu + p3.y*mu2);
        end
        else
        begin
          mum13:=mum1*mum1*mum1;
          mu3:=mu*mu*mu;
          p.x:=Round(p1.x * mum13 + 3*p2.x*mum1*mum1*mu + 3*mu2*mum1*p3.x + mu3*p4.x);
          p.y:=Round(p1.y * mum13 + 3*p2.y*mum1*mum1*mu + 3*mu2*mum1*p3.y + mu3*p4.y);
        end;
        With ParentChart do
        if View3D then Canvas.LineTo3D(P.X,P.Y,StartZ)
                  else Canvas.LineTo(P.X,P.Y);
        {
        Test: Show rectangles at each point...
        ParentChart.Canvas.RectangleWithZ(Rect(P.X-1,P.Y-1,P.X+1,P.Y+1),0);
        }
      end;
    end;
  end;

var t        : Integer;
    tmpCount : Integer;
Begin
  { Calculate XY coordinates... }
  tmpCount:=Count;

  // Allocate points
  SetLength(tmpPoints,tmpCount);

  for t:=0 to tmpCount-1 do
  begin
    tmpPoints[t].X:=CalcXPos(t);
    tmpPoints[t].Y:=CalcYPos(t);
  end;

  { Draw bezier line... }
  With ParentChart,Canvas do
  begin
    AssignVisiblePen(LinePen);
    Brush.Style:=bsClear;
    BackMode:=cbmTransparent; // 5.03

    if View3D then MoveTo3D(tmpPoints[0].X,tmpPoints[0].Y,StartZ)
              else MoveTo(tmpPoints[0].X,tmpPoints[0].Y);

    Case FBezierStyle of
      bsWindows: if View3D then
                 begin
                   Bezier(3,2);
                   t:=5;
                   Repeat
                     Bezier(4,t);
                     Inc(t,3);
                   Until t>Count-1;
                 end
                 else
                 begin
                   {$IFNDEF CLX}
                   PolyBezierTo(Handle,tmpPoints,(3*(tmpCount div 3)));
                   {$ENDIF}
                 end;
      bsBezier3: begin
                   Bezier(3,2);
                   t:=4;
                   Repeat
                     Bezier(3,t);
                     Inc(t,2);
                   Until t>Count-1;
                 end;
      bsBezier4: begin
                   Bezier(4,3);
                   t:=6;
                   Repeat
                     Bezier(4,t);
                     Inc(t,3);
                   Until t>Count-1;
                 end;
    end;
  end;

  { Draw pointers... }
  if Pointer.Visible then
  for t:=0 to tmpCount-1 do
      DrawPointer(tmpPoints[t].X,tmpPoints[t].Y,ValueColor[t],t);

  // Remove memory
  tmpPoints:=nil;
End;

Procedure TBezierSeries.SetSeriesColor(AColor:TColor);
begin
  inherited;
  LinePen.Color:=AColor;
end;

Procedure TBezierSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  FillSampleValues(3);
  ColorEachPoint:=IsEnabled;
  Pointer.Draw3D:=False;
end;

procedure TBezierSeries.SetBezierStyle(const Value: TBezierStyle);
begin
  if FBezierStyle<>Value then
  begin
    FBezierStyle:=Value;
    Repaint;
  end;
end;

procedure TBezierSeries.Assign(Source: TPersistent);
begin
  if Source is TBezierSeries then
  with TBezierSeries(Source) do
  begin
    Self.FBezierStyle:=FBezierStyle;
    Self.FNumBezierPoints:=FNumBezierPoints;
  end;
  inherited;
end;

initialization
  RegisterTeeSeries( TBezierSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBezier,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended, 1 );
finalization
  UnRegisterTeeSeries([TBezierSeries]);
end.
