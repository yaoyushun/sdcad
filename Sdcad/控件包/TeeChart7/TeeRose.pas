{**********************************************}
{   TWindRoseSeries                            }
{   TClockSeries                               }
{   Copyright (c) 1998-2004 by David Berneda   }
{**********************************************}
unit TeeRose;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QExtCtrls,
     {$ELSE}
     Graphics, ExtCtrls,
     {$ENDIF}
     TeEngine, Chart, TeCanvas, Series, TeePolar;

{  This unit contains two Series components:

   TWindRoseSeries --  A Polar Series displaying Wind directions.
   TClockSeries    --  A Polar Series showing a watch.
}

Type TCustom2DPolarSeries=class(TCustomPolarSeries)
     protected
       Procedure GalleryChanged3D(Is3D:Boolean); override;
       Procedure PrepareForGallery(IsEnabled:Boolean); override;
     end;

     TWindRoseSeries=class(TCustom2DPolarSeries)
     private
       FMirrorLabels : Boolean;
       procedure SetMirrorLabels(const Value: Boolean);
     protected
       Function GetCircleLabel(Const Angle:Double; Index:Integer):String; override;
       class Function GetEditorClass:String; override;
       Procedure PrepareForGallery(IsEnabled:Boolean); override;
     public
       Constructor Create(AOwner: TComponent); override;
     published
       property Active;
       property ColorEachPoint;
       property HorizAxis;
       property SeriesColor;
       property VertAxis;

       property AngleIncrement;
       property AngleValues;
       property Brush;
       property CircleBackColor;
       property CircleGradient;
       property CircleLabels default True;
       property CircleLabelsFont;
       property CircleLabelsInside;
       property CircleLabelsRotated;
       property CirclePen;
       property CloseCircle;
       property MirrorLabels:Boolean read FMirrorLabels write SetMirrorLabels default False;  // 7.0
       property Pen;
       property Pointer;
       property RadiusIncrement;
       property RadiusValues;
       property RotationAngle default 90;
     end;

     TClockSeriesStyle=(cssDecimal,cssRoman);

     TClockSeries=class;

     TClockSeriesGetTimeEvent=procedure(Sender:TClockSeries; Var ATime:TDateTime) of object;

     TClockSeries=class(TCustom2DPolarSeries)
     private
       FOnGetTime  : TClockSeriesGetTimeEvent;
       FPenHours   : TChartPen;
       FPenMinutes : TChartPen;
       FPenSeconds : TChartPen;
       FStyle      : TClockSeriesStyle;

       OldAxesVisible : Boolean;
       ITimer      : TTimer;
       Procedure SetPenHours(Value:TChartPen);
       Procedure SetPenMinutes(Value:TChartPen);
       Procedure SetPenSeconds(Value:TChartPen);
       Procedure SetStyle(Value:TClockSeriesStyle);
       Procedure OnTimerExpired(Sender:TObject);
     protected
       Procedure DoBeforeDrawValues; override;
       Procedure DrawAllValues; override;
       Function GetCircleLabel(Const Angle:Double; Index:Integer):String; override;
       class Function GetEditorClass:String; override;
       Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
     public
       Constructor Create(AOwner: TComponent); override;
       Destructor Destroy; override;

       Procedure Assign(Source:TPersistent); override;
       Function ClockTime:TDateTime;  // 7.0
       Function CountLegendItems:Integer; override;
       Function LegendItemColor(LegendIndex:Integer):TColor; override;
       Function LegendString( LegendIndex:Integer;
                              LegendTextStyle:TLegendTextStyle ):String; override; // 7.0
       Function NumSampleValues:Integer; override;
       property Timer:TTimer read ITimer;
     published
       property Active;
       property Brush;
       property CircleBackColor;
       property CircleGradient;
       property Circled default True;
       property CircleLabels default True;
       property CircleLabelsFont;
       property CircleLabelsInside;
       property CircleLabelsRotated;
       property CirclePen;
       property PenHours:TChartPen read FPenHours write SetPenHours;
       property PenMinutes:TChartPen read FPenMinutes write SetPenMinutes;
       property PenSeconds:TChartPen read FPenSeconds write SetPenSeconds;
       property RotationAngle default 90;
       property ShowInLegend default False; { 5.02 }
       property Style:TClockSeriesStyle read FStyle write SetStyle
                                        default cssRoman;
       property Transparency; { 5.02 }
       { events }
       property OnGetTime  : TClockSeriesGetTimeEvent read FOnGetTime
                                                      write FOnGetTime;
     end;

implementation

uses
  TeeProCo;

{ TCustom2DPolarSeries }
Procedure TCustom2DPolarSeries.GalleryChanged3D(Is3D:Boolean);
begin
  inherited;
  ParentChart.View3D:=False;
end;

Procedure TCustom2DPolarSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  CircleLabelsFont.Size:=6;
  Pointer.HorizSize:=2;
  Pointer.VertSize:=2;
end;

{ TWindRoseSeries }
Constructor TWindRoseSeries.Create(AOwner: TComponent);
begin
  inherited;
  CircleLabels:=True;
  RotationAngle:=90;
end;

// Alternate method
(*
 function DegreesToWindDir(const Angle: Double): String;
 const WindDirs: Array[0..15] of String =
  ('N','NNW','NW','WNW','W','WSW','SW','SSW','S','SSE','SE','ESE','E','ENE','NE','NNE' );
 var i : Integer;
 begin
   i:=Trunc((Angle + 11.25) / (360/16));
   result := WindDirs[i];
 end;
*)

// Return the string corresponding to the "Angle" degree parameter
Function TWindRoseSeries.GetCircleLabel(Const Angle:Double; Index:Integer):String;
var tmp : Double;
begin
  if FMirrorLabels then tmp:=360-Angle
                   else tmp:=Angle;

  Case Round(tmp) of
      0: result:='N';
     15: result:='NNNW';
     30: result:='NNW';
     45: result:='NW';
     60: result:='NWW';
     75: result:='NWWW';
     90: result:='W';
    105: result:='SWWW';
    120: result:='SWW';
    135: result:='SW';
    150: result:='SSW';
    165: result:='SSSW';
    180: result:='S';
    195: result:='SSSE';
    210: result:='SSE';
    225: result:='SE';
    240: result:='SEE';
    255: result:='SEEE';
    270: result:='E';
    285: result:='NEEE';
    300: result:='NEE';
    315: result:='NE';
    330: result:='NNE';
    345: result:='NNNE';
    360: result:='N';
  else result:='';
  end;
end;

class function TWindRoseSeries.GetEditorClass: String;
begin
  result:='TWindRoseEditor';
end;

procedure TWindRoseSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  AngleIncrement:=45;
end;

procedure TWindRoseSeries.SetMirrorLabels(const Value: Boolean);
begin
  SetBooleanProperty(FMirrorLabels,Value);
end;

{ TClockSeries }
Constructor TClockSeries.Create(AOwner: TComponent);
begin
  inherited;
  OldAxesVisible:=True;
  Pointer.Hide;
  FStyle:=cssRoman;
  Brush.Style:=bsSolid;
  CircleLabels:=True;
  RotationAngle:=90;
  Circled:=True;

  Add(0);

  FPenHours:=CreateChartPen;
  FPenMinutes:=CreateChartPen;
  FPenSeconds:=CreateChartPen;

  ITimer:=TTimer.Create(Self);
  With ITimer do
  begin
    Interval:=1000;
    Enabled:=True;
    OnTimer:=OnTimerExpired;
  end;
end;

Destructor TClockSeries.Destroy;
begin
  FPenHours.Free;
  FPenMinutes.Free;
  FPenSeconds.Free;
  ITimer.Free;
  inherited;
end;

Procedure TClockSeries.OnTimerExpired(Sender:TObject);
begin
  ITimer.Enabled:=False;
  Repaint;
  ITimer.Enabled:=True;
end;

Procedure TClockSeries.Assign(Source:TPersistent);
begin
  if Source is TClockSeries then
  With TClockSeries(Source) do
  begin
    Self.PenHours   :=FPenHours;
    Self.PenMinutes :=FPenMinutes;
    Self.PenSeconds :=FPenSeconds;
    Self.FStyle     :=FStyle;
  end;
  inherited;
end;

Procedure TClockSeries.DoBeforeDrawValues;
var tmpBlend : TTeeBlend; { 5.02 }
begin
  if Transparency>0 then
     tmpBlend:=ParentChart.Canvas.BeginBlending(ParentChart.ChartRect,Transparency)
  else
     tmpBlend:=nil;

  inherited;

  if Transparency>0 then
     ParentChart.Canvas.EndBlending(tmpBlend);
end;

Function TClockSeries.ClockTime:TDateTime;
begin
  result:=Now;
  if Assigned(FOnGetTime) then FOnGetTime(Self,result);
end;

Procedure TClockSeries.DrawAllValues;
Var X : Integer;
    Y : Integer;

  Procedure CalcPos(Const AAngle,ASize:Double);
  begin
    AngleToPos(AAngle*PiDegree,ASize*XRadius/2.0,ASize*YRadius/2.0,X,Y);
  end;

Var H  : Word;
    M  : Word;
    S  : Word;
    Ms : Word;
    tmp : TDateTime;
begin
  With ParentChart.Canvas do
  begin
    tmp:=ClockTime;
    DecodeTime(tmp,H,M,S,Ms);

    AssignBrush(Self.Brush,SeriesColor);

    if FPenHours.Visible then
    begin
      AssignVisiblePen(FPenHours);
      CalcPos(360.0-(360.0*(60.0*H+M)/(12.0*60.0)),1.3);
      Arrow(True,TeePoint(CircleXCenter,CircleYCenter),TeePoint(X,Y),14,20,EndZ);
    end;

    if FPenMinutes.Visible then
    begin
      AssignVisiblePen(FPenMinutes);
      CalcPos(360.0-(360.0*M/60.0),1.7);
      Arrow(True,TeePoint(CircleXCenter,CircleYCenter),TeePoint(X,Y),10,16,EndZ);
    end;

    CalcPos(360.0-(360.0*(S+(Ms/1000.0))/60.0),1.8); // 5.02
    if FPenSeconds.Visible then
    begin
      AssignVisiblePen(FPenSeconds);
      MoveTo3D(CircleXCenter,CircleYCenter,EndZ);
      LineTo3D(X,Y,EndZ);
    end;

    With Pointer do
    if Visible then
    begin
      PrepareCanvas(ParentChart.Canvas,Color);
      Draw(X,Y);
    end;
  end;
end;

Procedure TClockSeries.SetParentChart(Const Value:TCustomAxisPanel);
begin
  if not Assigned(Value) then
     if Assigned(ParentChart) then
        ParentChart.Axes.Visible:=OldAxesVisible;

  inherited;
  AngleIncrement:=30;
  if Assigned(ParentChart) then
  begin
    OldAxesVisible:=ParentChart.Axes.Visible;
    ParentChart.Axes.Visible:=False;
  end;
end;

{ Return the string corresponding to the "Angle" degree parameter }
Function TClockSeries.GetCircleLabel(Const Angle:Double; Index:Integer):String;
Const RomanNumber:Array[1..12] of String=
  ('I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII');
var tmpAngle : Integer;
begin
  tmpAngle:=Round((360.0-Angle)/30.0);
  if FStyle=cssDecimal then Str(tmpAngle,result)
                       else result:=RomanNumber[tmpAngle];
end;

Procedure TClockSeries.SetPenHours(Value:TChartPen);
begin
  FPenHours.Assign(Value);
end;

Procedure TClockSeries.SetPenMinutes(Value:TChartPen);
begin
  FPenMinutes.Assign(Value);
end;

Procedure TClockSeries.SetPenSeconds(Value:TChartPen);
begin
  FPenSeconds.Assign(Value);
end;

Procedure TClockSeries.SetStyle(Value:TClockSeriesStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

Function TClockSeries.NumSampleValues:Integer;
begin
  result:=1;
end;

class function TClockSeries.GetEditorClass: String;
begin
  result:='TClockEditor';
end;

function TClockSeries.CountLegendItems: Integer;
begin
  result:=1;
end;

function TClockSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  result:=clNone;
end;

function TClockSeries.LegendString(LegendIndex: Integer;
  LegendTextStyle: TLegendTextStyle): String;
begin
  result:=TimeToStr(ClockTime);
end;

initialization
  RegisterTeeSeries( TWindRoseSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryWindRose,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
  RegisterTeeSeries( TClockSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryClock,
                                   {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([ TWindRoseSeries, TClockSeries ]);
end.
