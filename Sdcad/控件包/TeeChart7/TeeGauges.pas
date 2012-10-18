{*********************************************}
{  TeeChart Gauge Series Types                }
{  Copyright (c) 2002-2004 by David Berneda   }
{  All Rights Reserved                        }
{*********************************************}
unit TeeGauges;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF CLX}
     Types,
     {$ENDIF}
     Classes,
     {$IFDEF CLR}
     Types,
     {$ENDIF}
     Series, TeEngine;

const TeeHandDistance=30;  // default pixels distance from center to labels

type
  THandStyle=(hsLine,hsTriangle);

  TGaugeSeries=class(TCircledSeries)
  private
    FAngle         : Double;
    FCenter        : TSeriesPointer;
    FDistance      : Integer;
    FEndPoint      : TSeriesPointer;
    FFullRepaint   : Boolean;
    FMax           : Double;
    FMin           : Double;
    FMinorDistance : Integer;
    FStyle         : THandStyle;

    FOnChange: TNotifyEvent;

    ICenter   : TPoint;
    FLabelsInside: Boolean;

    procedure CalcLinePoints(var P0,P1:TPoint);
    Function CalcPoint(const Angle:Double; Center:TPoint;
                       const RadiusX,RadiusY:Double):TPoint;
    procedure DrawValueLine;
    procedure SetAngle(const Value: Double);
    procedure SetCenter(const Value: TSeriesPointer);
    procedure SetDistance(const Value: Integer);
    procedure SetMax(const AValue: Double);
    procedure SetMin(const AValue: Double);
    procedure SetStyle(const Value: THandStyle);
    procedure SetValue(const AValue: Double);
    procedure SetFullRepaint(const Value: Boolean);
    function GetValue: Double;
    procedure SetEndPoint(const Value: TSeriesPointer);
    function SizePointer(APointer:TSeriesPointer):Integer;
    procedure SetMinorDistance(const Value: Integer);
    procedure SetLabelsInside(const Value: Boolean);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    procedure DrawAllValues; override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    Procedure NotifyNewValue(Sender:TChartSeries; ValueIndex:Integer); override; // 7.0
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    function Axis:TChartAxis;
    Function Clicked(x,y:Integer):Integer; override;
    Function NumSampleValues:Integer; override;
    function MaxYValue:Double; override;
    function MinYValue:Double; override;
  published
    property Center:TSeriesPointer read FCenter write SetCenter;
    property Circled default True;
    property CircleGradient;
    property EndPoint:TSeriesPointer read FEndPoint write SetEndPoint;
    property FullRepaint:Boolean read FFullRepaint write SetFullRepaint default False;
    property Maximum:Double read FMax write SetMax;
    property Minimum:Double read FMin write SetMin;
    property MinorTickDistance:Integer read FMinorDistance write SetMinorDistance default 0;
    property HandDistance:Integer read FDistance write SetDistance default TeeHandDistance;
    property HandStyle:THandStyle read FStyle write SetStyle default hsLine;
    property LabelsInside:Boolean read FLabelsInside write SetLabelsInside default True;
    property RotationAngle default 135;
    property ShowInLegend default False;
    property TotalAngle:Double read FAngle write SetAngle;
    property Value:Double read GetValue write SetValue;
    { events }
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses {$IFDEF CLR}
     Graphics,
     Math,
     SysUtils,
     {$ELSE}
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     SysUtils, Math,
     {$ENDIF}
     Chart, TeCanvas, TeeProcs, TeeConst, TeeProCo;

{ TGaugeSeries }

constructor TGaugeSeries.Create(AOwner: TComponent);
begin
  inherited;

  FDistance:=TeeHandDistance;

  Circled:=True;
  ShowInLegend:=False;
  FLabelsInside:=True;

  FCenter:=TSeriesPointer.Create(Self);
  with FCenter do
  begin
    Brush.Style:=bsSolid;
    Color:=clBlack;
    Style:=psCircle;
    HorizSize:=8;
    VertSize:=8;
    Gradient.Visible:=True;
  end;

  FEndPoint:=TSeriesPointer.Create(Self);
  with FEndPoint do
  begin
    Brush.Style:=bsSolid;
    Color:=clWhite;
    Style:=psCircle;
    HorizSize:=3;
    VertSize:=3;
    Visible:=False;
  end;

  Add(0);
  Maximum:=100;
  TotalAngle:=90;
  RotationAngle:=135;
end;

destructor TGaugeSeries.Destroy;
begin
  FEndPoint.Free;
  FCenter.Free;
  inherited;
end;

Function TGaugeSeries.CalcPoint(const Angle:Double; Center:TPoint;
                          const RadiusX,RadiusY:Double):TPoint;
var tmpSin,
    tmpCos : Extended;
begin
  SinCos(Angle,tmpSin,tmpCos);
  result.X:=Center.X-Round(RadiusX*tmpCos);
  result.Y:=Center.Y-Round(RadiusY*tmpSin);
end;

procedure TGaugeSeries.DrawAllValues;

  Procedure DrawAxis;
  var P3,P4 : TPoint;
      tmpR  : TRect;
  begin
    ParentChart.Canvas.AssignVisiblePen(Axis.Axis);

    P3:=CalcPoint(TeePiStep*RotationAngle,ICenter,CircleWidth,CircleHeight);
    P4:=CalcPoint(TeePiStep*(360-TotalAngle+RotationAngle),ICenter,CircleWidth,CircleHeight);

    tmpR:=ParentChart.ChartRect;

    if Circled then
    with ParentChart do
    begin
      if ChartWidth>ChartHeight then
      begin
        tmpR.Left:=ChartXCenter-(ChartHeight div 2);
        tmpR.Right:=ChartXCenter+(ChartHeight div 2);
      end
      else
      begin
        tmpR.Top:=ChartYCenter-(ChartWidth div 2);
        tmpR.Bottom:=ChartYCenter+(ChartWidth div 2);
      end;
    end;

    with tmpR do
         ParentChart.Canvas.Arc(Left+1,Top+1,Right,Bottom,P3.x,P3.y,P4.x,P4.y);
  end;

var
  tmpStep2 : Double;
  IRange   : Double;
  tmpXRad  : Double;
  tmpYRad  : Double;

  procedure DrawMinorTicks(const Value:Double);
  var t : Integer;
      tmp : Double;
      tmpValue : Double;
  begin
    for t:=1 to Axis.MinorTickCount do
    begin
      tmpValue:=(Value+t*tmpStep2);

      if tmpValue>Maximum then break
      else
      begin
        tmp:=TotalAngle-(tmpValue*TotalAngle/IRange);
        tmp:=TeePiStep*(360-tmp+RotationAngle);

        ParentChart.Canvas.Line( CalcPoint(tmp,ICenter,tmpXRad,tmpYRad),
              CalcPoint(tmp,ICenter,XRadius-MinorTickDistance,YRadius-MinorTickDistance));
      end;
    end;
  end;

var tmp : Double;
    tmpAngle : Double;
    tmpSin,
    tmpCos : Extended;
    tmpS  : String;
    tmpValue,
    tmpStep : Double;
    tmpFontH : Integer;
    P3   : TPoint;
    P4   : TPoint;
begin
  ICenter.X:=CircleXCenter;
  ICenter.Y:=CircleYCenter;
  IRange:=Maximum-Minimum;

  tmpStep:=Axis.Increment;
  if tmpStep=0 then tmpStep:=10;

  if CircleGradient.Visible then
     DrawCircleGradient;

  // center
  if FCenter.Visible then
  begin
    FCenter.PrepareCanvas(ParentChart.Canvas,FCenter.Color);
    FCenter.Draw(ICenter);
  end;

  with ParentChart,Canvas do
  begin
    // ticks and labels
    if Axis.Ticks.Visible or Axis.Labels then
    begin
      AssignFont(Axis.Items.Format.Font);

      AssignVisiblePen(Axis.Ticks);
      BackMode:=cbmTransparent;

      tmpXRad:=(XRadius-Axis.TickLength);
      tmpYRad:=(YRadius-Axis.TickLength);

      tmpFontH:=FontHeight;

      if tmpStep<>0 then
      begin
        tmpValue:=Minimum;

        repeat
          tmp:=TotalAngle-(tmpValue*TotalAngle/IRange);
          tmpAngle:=360-tmp+RotationAngle;
          tmp:=TeePiStep*tmpAngle;

          P3:=CalcPoint(tmp,ICenter,tmpXRad,tmpYRad);
          P4:=CalcPoint(tmp,ICenter,XRadius,YRadius);

          if Axis.Ticks.Visible then Line(P3,P4);

          if Axis.Labels then
          begin
            tmpS:=FormatFloat(ValueFormat,tmpValue);

            if not LabelsInside then
               P3:=CalcPoint(tmp,ICenter,XRadius+tmpFontH,YRadius+tmpFontH);

            Dec(P3.x,Round(TextWidth(tmpS)*0.5));

            if LabelsInside then // 7.0
            begin
              if tmpAngle>360 then tmpAngle:=tmpAngle-360;
              if tmpAngle<0 then tmpAngle:=360+tmpAngle;

              SinCos(TeePiStep*tmpAngle,tmpsin,tmpCos);
              Inc(P3.x,Round(TextWidth(tmpS)*0.5*tmpCos));
              if (tmpAngle>180) and (tmpAngle<360) then
                  Inc(P3.y,Round(FontHeight*tmpSin));
            end;

            TextOut(P3.x,P3.y,tmpS);
          end;

          tmpValue:=tmpValue+tmpStep;

        Until ((TotalAngle<360) and (tmpValue>Maximum)) or
              ((TotalAngle>=360) and (tmpValue>=Maximum));
      end;
    end;

    // minor ticks
    if Axis.MinorTicks.Visible and (Axis.MinorTickCount>0) then
    begin
      AssignVisiblePen(Axis.MinorTicks);

      tmpXRad:=XRadius-Axis.MinorTickLength-MinorTickDistance;
      tmpYRad:=YRadius-Axis.MinorTickLength-MinorTickDistance;

      if tmpStep<>0 then
      begin
        tmpStep2:=tmpStep/(Axis.MinorTickCount+1);

        tmpValue:=Minimum;

        repeat
          DrawMinorTicks(tmpValue);
          tmpValue:=tmpValue+tmpStep;
        Until tmpValue>(Maximum-tmpStep);

        if tmpValue<Maximum then
           DrawMinorTicks(tmpValue);
      end;
    end;

    // axis
    if Axis.Axis.Visible then DrawAxis;

    // value line
    if Self.Pen.Visible then DrawValueLine;
  end;
end;

Function TGaugeSeries.Clicked(x,y:Integer):Integer;
var P0,P1 : TPoint;
begin
  CalcLinePoints(P0,P1);
  if Assigned(ParentChart) then
     ParentChart.Canvas.Calculate2DPosition(X,Y,MiddleZ);

  if PointInLine(TeePoint(x,y),P0,P1,2) then
     result:=0
  else
     result:=TeeNoPointClicked;
end;

function TGaugeSeries.SizePointer(APointer:TSeriesPointer):Integer;
begin
  if APointer.Visible then
  begin
    result:=2*APointer.VertSize;
    if APointer.Pen.Visible then Inc(result,APointer.Pen.Width);
  end
  else result:=0;
end;

procedure TGaugeSeries.CalcLinePoints(var P0,P1:TPoint);
var tmp : Double;
    tmpDist : Integer;
begin
  tmp:=TeePiStep*(360-(TotalAngle-((Value-Minimum)*TotalAngle/(Maximum-Minimum)))+RotationAngle);

  P1:=CalcPoint(tmp,ICenter,XRadius,YRadius);

  tmpDist:=HandDistance+SizePointer(FEndPoint);
  if tmpDist>0 then
     P1:=PointAtDistance(ICenter,P1,tmpDist);

  if FCenter.Visible and (FCenter.Style=psCircle) then
     P0:=PointAtDistance(P1,ICenter,SizePointer(FCenter) div 2)
  else
     P0:=ICenter;
end;

procedure TGaugeSeries.DrawValueLine;
var tmp : Double;
    P4  : TPoint;
    tmpCenter : TPoint;
begin
  CalcLinePoints(tmpCenter,P4);

  if not FullRepaint then Pen.Mode:=pmNotXor
                     else Pen.Mode:=pmCopy;

  ParentChart.Canvas.AssignVisiblePen(Pen);

  if HandStyle=hsLine then
     ParentChart.Canvas.Line(tmpCenter,P4)
  else
  begin
    tmp:=ArcTan2(P4.y-tmpCenter.X,P4.x-tmpCenter.Y);
    ParentChart.Canvas.Polygon([CalcPoint(tmp,tmpCenter,4,4),P4,CalcPoint(tmp+Pi,tmpCenter,4,4)]);
  end;

  // end point
  if FEndPoint.Visible then
  begin
    if not FullRepaint then FEndPoint.Pen.Mode:=pmNotXor
                       else FEndPoint.Pen.Mode:=pmCopy;

    FEndPoint.PrepareCanvas(ParentChart.Canvas,FEndPoint.Color);

    if not FullRepaint then ParentChart.Canvas.Brush.Style:=bsClear;

    P4:=PointAtDistance(ICenter,P4,-SizePointer(FEndPoint) div 2);
    FEndPoint.Draw(P4);
  end;
end;

procedure TGaugeSeries.SetAngle(const Value: Double);
begin
  SetDoubleProperty(FAngle,Value);
end;

procedure TGaugeSeries.SetCenter(const Value: TSeriesPointer);
begin
  FCenter.Assign(Value);
end;

procedure TGaugeSeries.SetDistance(const Value: Integer);
begin
  SetIntegerProperty(FDistance,Value);
end;

procedure TGaugeSeries.SetMax(const AValue: Double);
begin
  SetDoubleProperty(FMax,AValue);
  Value:=Math.Min(Maximum,Value);
end;

procedure TGaugeSeries.SetMin(const AValue: Double);
begin
  SetDoubleProperty(FMin,AValue);
  Value:=Math.Max(Minimum,Value);
end;

procedure TGaugeSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    FCenter.ParentChart:=ParentChart;
    FEndPoint.ParentChart:=ParentChart;
  end;

  if Assigned(ParentChart) then
  begin
    with TCustomChart(ParentChart) do
    begin
      Walls.Visible:=False;
      View3D:=False;
      Frame.Hide;
    end;

    Axis.TickLength:=14;
    Axis.MinorTickLength:=6;
  end;
end;

procedure TGaugeSeries.SetStyle(const Value: THandStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

procedure TGaugeSeries.SetValue(const AValue: Double);
begin
  if Value<>AValue then
  begin
    if not FullRepaint then DrawValueLine;
    MandatoryValueList.Value[0]:=AValue;
    if FullRepaint then Repaint
                   else DrawValueLine;

    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TGaugeSeries.SetFullRepaint(const Value: Boolean);
begin
  SetBooleanProperty(FFullRepaint,Value);
end;

function TGaugeSeries.GetValue: Double;
begin
  if Count=0 then Add(0);
  result:=MandatoryValueList.Value[0];
end;

procedure TGaugeSeries.SetEndPoint(const Value: TSeriesPointer);
begin
  FEndPoint.Assign(Value);
end;

procedure TGaugeSeries.AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False);
begin
  Value:=Minimum+(Maximum-Minimum)*Random;
end;

procedure TGaugeSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;

  with Axis do
  begin
    MinorTickCount:=1;
    TickLength:=4;
    MinorTickLength:=2;
    Increment:=25;
  end;

  HandDistance:=3;
  Center.VertSize:=2;
  Center.HorizSize:=2;
  FullRepaint:=True;

  if IsEnabled then Pen.Color:=clBlue
               else Pen.Color:=clDkGray;
end;

function TGaugeSeries.NumSampleValues: Integer;
begin
  result:=1;
end;

procedure TGaugeSeries.SetMinorDistance(const Value: Integer);
begin
  SetIntegerProperty(FMinorDistance,Value);
end;

procedure TGaugeSeries.GalleryChanged3D(Is3D: Boolean);
begin
  inherited;
  ParentChart.View3D:=False;
  Circled:=True;
end;

class function TGaugeSeries.GetEditorClass: String;
begin
  result:='TGaugeSeriesEditor';
end;

function TGaugeSeries.MaxYValue: Double;
begin
  result:=FMax;
end;

function TGaugeSeries.MinYValue: Double;
begin
  result:=FMin;
end;

function TGaugeSeries.Axis: TChartAxis;
begin
  result:=GetVertAxis;
end;

procedure TGaugeSeries.SetLabelsInside(const Value: Boolean);
begin
  SetBooleanProperty(FLabelsInside,Value);
end;

procedure TGaugeSeries.NotifyNewValue(Sender: TChartSeries;
  ValueIndex: Integer);
begin
  Value:=MandatoryValueList[ValueIndex];
  inherited;
end;

initialization
  RegisterTeeSeries(TGaugeSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGauge,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,1);
finalization
  UnRegisterTeeSeries([TGaugeSeries]);
end.
