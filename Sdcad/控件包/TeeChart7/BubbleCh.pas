{**********************************************}
{   TBubbleSeries (derived from TPointSeries)  }
{   Copyright (c) 1995-2004 by David Berneda   }
{**********************************************}
unit BubbleCh;
{$I TeeDefs.inc}

interface

{ TBubbleSeries derives from standard TPointSeries.
  Each point in the series is drawn like a Bubble.
  Each point has a Radius value that's used to draw the Bubble with its
  corresponding screen size.

  Inherits all functionality from TPointSeries and
  its ancestor TCustomSeries.
}
uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Classes,
     Chart, Series, TeEngine, TeCanvas, TeeProcs;

type
  TBubbleSeries=class(TPointSeries)
  private
    FRadiusValues : TChartValueList; { <-- Bubble's radius storage }
    FSquared      : Boolean;
    Function ApplyRadius( Const Value:Double;
                          AList:TChartValueList;
                          Increment:Boolean):Double;
    Procedure SetRadiusValues(Value:TChartValueList);
    Procedure SetSquared(Value:Boolean);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override; { <-- to add random radius values }
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    class function GetEditorClass:String; override;
    Function GetGradient:TChartGradient; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure PreparePointer(ValueIndex:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function AddBubble(Const AX,AY,ARadius:Double; Const AXLabel:String='';
                       AColor:TColor=clTeeColor):Integer;
    Procedure Assign(Source:TPersistent); override;
    Function NumSampleValues:Integer; override;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxYValue:Double; override;  { <-- adds radius }
    Function MinYValue:Double; override;  { <-- substracts radius }
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
  published
    property ColorEachPoint default True;
    property RadiusValues:TChartValueList read FRadiusValues write SetRadiusValues;
    property Squared:Boolean read FSquared write SetSquared default True;
  end;

implementation

Uses Math, SysUtils, TeeConst;

type TPointerAccess=class(TSeriesPointer);

{ TBubbleSeries }
Constructor TBubbleSeries.Create(AOwner: TComponent);
Begin
  inherited;

  FRadiusValues:=TChartValueList.Create(Self,TeeMsg_ValuesBubbleRadius); { <-- radius storage }

  With Pointer do
  begin
    InflateMargins:=False;
    Style:=psCircle; { <-- a Bubble is a circle (by default) }
  end;

  TPointerAccess(Pointer).AllowChangeSize:=False;

  Marks.Frame.Hide;
  Marks.Transparent:=True;
  FSquared:=True;
  ColorEachPoint:=True;
end;

Procedure TBubbleSeries.SetSquared(Value:Boolean);
Begin
  SetBooleanProperty(FSquared,Value);
end;

Procedure TBubbleSeries.SetRadiusValues(Value:TChartValueList);
Begin
  SetChartValueList(FRadiusValues,Value); { standard method }
end;

{ Helper method, special to Bubble series }
Function TBubbleSeries.AddBubble( Const AX,AY,ARadius:Double;
                                  Const AXLabel:String; AColor:TColor):Integer;
Begin
  RadiusValues.TempValue:=ARadius;
  result:=AddXY(AX,AY,AXLabel,AColor);
end;

Function TBubbleSeries.NumSampleValues:Integer;
begin
  result:=8;
end;

Procedure TBubbleSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var t : Integer;
    s : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do { some sample values to see something in design mode }
  Begin
    AddBubble( tmpX,                { X }
               RandomValue(Round(DifY)), { Y }
               (DifY/15.0)+Round(DifY/(10+RandomValue(15)))  { <- Radius }
               );
    tmpX:=tmpX+StepX;
  end;
end;

Procedure TBubbleSeries.PreparePointer(ValueIndex:Integer);
var tmpSize : Integer;
begin
  tmpSize:=GetVertAxis.CalcSizeValue(RadiusValues.Value[ValueIndex]);
  if FSquared then
     TPointerAccess(Pointer).ChangeHorizSize(tmpSize)
  else
     TPointerAccess(Pointer).ChangeHorizSize(GetHorizAxis.CalcSizeValue(RadiusValues.Value[ValueIndex]));
  TPointerAccess(Pointer).ChangeVertSize(tmpSize);
end;

procedure TBubbleSeries.DrawValue(ValueIndex:Integer);
Begin
// This overrided method is the main paint for bubble points.
// The bubble effect is achieved by changing the Pointer.Size based
// on the corresponding Radius value for each point in the series.
// We dont use Pointer.Size:=... because that will force a repaint
// while we are painting !! giving recursive endlessly repaints !!!

  PreparePointer(ValueIndex);
  DrawPointer(CalcXPos(ValueIndex),CalcYPos(ValueIndex),ValueColor[ValueIndex],ValueIndex);
// dont call inherited here to avoid drawing the "pointer"
end;

Function TBubbleSeries.ApplyRadius( Const Value:Double;
                                    AList:TChartValueList;
                                    Increment:Boolean):Double;
var t : Integer;
begin
  result:=Value;
  for t:=0 to Count-1 do
  if Increment then
     result:=Math.Max(result,AList.Value[t]+RadiusValues.Value[t])
  else
     result:=Math.Min(result,AList.Value[t]-RadiusValues.Value[t]);
end;

Function TBubbleSeries.MaxYValue:Double;
Begin
  result:=ApplyRadius(inherited MaxYValue,YValues,True);
end;

Function TBubbleSeries.MinYValue:Double;
Begin
  result:=ApplyRadius(inherited MinYValue,YValues,False);
end;

Procedure TBubbleSeries.Assign(Source:TPersistent);
begin
  if Source is TBubbleSeries then
     FSquared:=TBubbleSeries(Source).FSquared;
  inherited;
end;

Function TBubbleSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TBubbleSeries; // Only Bubbles can be assigned to Bubbles
end;

Function TBubbleSeries.MaxZValue:Double;
begin
  if Pointer.Draw3D then result:=RadiusValues.MaxValue
                    else result:=inherited MaxZValue;
end;

Function TBubbleSeries.MinZValue:Double;
begin
  if Pointer.Draw3D then result:=-RadiusValues.MaxValue
                    else result:=inherited MinZValue;
end;

Procedure TBubbleSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmp : Integer;
begin
  With Rect do tmp:=Math.Min(Right-Left,Bottom-Top);
  TPointerAccess(Pointer).ChangeHorizSize(tmp);
  TPointerAccess(Pointer).ChangeVertSize(tmp);
  inherited;
end;

class function TBubbleSeries.GetEditorClass: String;
begin
  result:='TBubbleSeriesEditor';
end;

procedure TBubbleSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  Gradient.Visible:=True;
end;

function TBubbleSeries.GetGradient: TChartGradient;
begin
  result:=Pointer.Gradient;
end;

initialization
  RegisterTeeSeries( TBubbleSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBubble,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStandard,1);
end.
