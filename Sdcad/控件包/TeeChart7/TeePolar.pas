{*********************************************}
{ TeeChart Delphi Component Library           }
{    Polar and Radar Series Components        }
{ Copyright (c) 1995-2004 by David Berneda    }
{ All rights reserved                         }
{*********************************************}
unit TeePolar;
{$I TeeDefs.inc}

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
     QGraphics, QControls, QForms, Types,
     {$ELSE}
     Graphics, Controls, Forms,
     {$ENDIF}
     {$ENDIF}
     TeEngine, Chart, Series, TeCanvas;

var TeePolarDegreeSymbol : String = '°'; // 7.0             

type
  TCustomPolarSeries = class(TCircledSeries)
  private
    FCircleLabels     : Boolean;
    FCircleLabelsFont : TTeeFont;
    FCircleLabelsInside : Boolean;
    FCircleLabelsRot  : Boolean;
    FCirclePen        : TChartPen;
    FClockWiseLabels  : Boolean;
    FCloseCircle      : Boolean;
    FLabelsMargin     : Integer;
    FOnGetPointerStyle: TOnGetPointerStyle;
    FPointer          : TSeriesPointer;
    FTransparency     : TTeeTransparency;

    { Private declarations }
    OldX              : Integer;
    OldY              : Integer;
    IMaxValuesCount   : Integer;

    Procedure CalcXYPos( ValueIndex:Integer;
                         Const ARadius:Double; Var X,Y:Integer);
    Function DrawAxesBehind:Boolean;
    Procedure DrawAxis;
    Procedure FillTriangle(Const A,B:TPoint; Z:Integer);
    Function GetAngleIncrement:Double;
    Function GetAngleValues:TChartValueList;
    Function GetRadiusIncrement:Double;
    Function GetRadiusValues:TChartValueList;
    Function IsRadiusStored:Boolean;
    Procedure SetAngleIncrement(Const Value:Double);
    Procedure SetAngleValues(Value:TChartValueList);
    Procedure SetCircleLabels(Value:Boolean);
    Procedure SetCircleLabelsFont(Value:TTeeFont);
    procedure SetCircleLabelsInside(const Value: Boolean);
    Procedure SetCirclePen(Value:TChartPen);
    procedure SetClockWiseLabels(const Value: Boolean);
    Procedure SetCloseCircle(Value:Boolean);
    procedure SetLabelsMargin(const Value: Integer);
    Procedure SetLabelsRotated(Value:Boolean);
    Procedure SetPointer(Value:TSeriesPointer);
    Procedure SetRadiusIncrement(Const Value:Double);
    Procedure SetRadiusValues(Value:TChartValueList);
    Procedure SetTransparency(Value:TTeeTransparency);
  protected
    { Protected declarations }
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcXYRadius(Const Value:Double; Var X,Y:Integer);
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DoAfterDrawValues; override;
    Procedure DoBeforeDrawValues; override;
    Procedure DrawAllValues; override;
    Procedure DrawCircleGradient; override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure DrawPolarCircle(HalfWidth,HalfHeight,Z:Integer);
    procedure DrawValue(ValueIndex:Integer); override;
    Function  GetCircleLabel(Const Angle:Double; Index:Integer):String; virtual;
    class Function  GetEditorClass:String; override;
    procedure InternalDrawValue(ValueIndex,X,Y:Integer); virtual;
    procedure LinePrepareCanvas(ValueIndex:Integer);
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    Procedure SetSeriesColor(AColor:TColor); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function CalcXPos(ValueIndex:Integer):Integer; override;
    Function CalcYPos(ValueIndex:Integer):Integer; override;
    Function Clicked(x,y:Integer):Integer; override;
    Procedure DrawRing(Const Value:Double; Z:Integer);
    Function DrawValuesForward:Boolean; override;
    Procedure DrawZone(Const Min,Max:Double; Z:Integer);

    { to be Published declarations }
    property AngleIncrement:Double read GetAngleIncrement write SetAngleIncrement;
    property AngleValues:TChartValueList read GetAngleValues write SetAngleValues;
    property Brush;

    {$IFDEF TEEOCX}
    property CircleGradient;
    {$ENDIF}

    property CircleLabels:Boolean read FCircleLabels write SetCircleLabels default False;
    property CircleLabelsFont:TTeeFont read FCircleLabelsFont write SetCircleLabelsFont;
    property CircleLabelsInside:Boolean read FCircleLabelsInside write SetCircleLabelsInside default False;
    property CircleLabelsRotated:Boolean read FCircleLabelsRot
                                         write SetLabelsRotated default False;
    property CirclePen:TChartPen read FCirclePen write SetCirclePen;
    property ClockWiseLabels:Boolean read FClockWiseLabels write SetClockWiseLabels default False;
    property CloseCircle:Boolean read FCloseCircle
                                 write SetCloseCircle default True;
    property LabelsMargin:Integer read FLabelsMargin write SetLabelsMargin default 3; // 3%  // 7.0
    property Pen;
    property Pointer:TSeriesPointer read FPointer write SetPointer;
    property RadiusIncrement:Double read GetRadiusIncrement write SetRadiusIncrement;
    property RadiusValues:TChartValueList read GetRadiusValues write SetRadiusValues
                                          stored IsRadiusStored;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;

    { events }
    property OnGetPointerStyle:TOnGetPointerStyle read FOnGetPointerStyle write FOnGetPointerStyle;
  end;

  TPolarSeries = class(TCustomPolarSeries)
  public
    Function AddPolar( Const Angle,Value:Double;
                       Const ALabel:String='';
                       AColor:TColor=clTeeColor):Integer;
  published
    { Published declarations }
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
    property CircleLabels;
    property CircleLabelsFont;
    property CircleLabelsInside;
    property CircleLabelsRotated;
    property CirclePen;
    property ClockWiseLabels;
    property CloseCircle;
    property LabelsMargin;  // 7.0
    property Pen;
    property Pointer;
    property RadiusIncrement;
    property RadiusValues;
    property RotationAngle;
    property Transparency; { 5.02 }

    { events }
    property OnGetPointerStyle;
  end;

  TRadarSeries=class(TCustomPolarSeries)
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure DoBeforeDrawChart; override;
    Function GetCircleLabel(Const Angle:Double; Index:Integer):String; override;
    Function GetxValue(ValueIndex:Integer):Double; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Function NumSampleValues:Integer; override;
  published
    { Published declarations }
    property Active;
    property ColorEachPoint;
    property HorizAxis;
    property SeriesColor;
    property VertAxis;

    property Brush;
    property CircleBackColor;
    property CircleGradient;
    property CircleLabels;
    property CircleLabelsFont;
    property CircleLabelsRotated;
    property CirclePen;
    property CloseCircle;
    property LabelsMargin;  // 7.0
    property Pen;
    property Pointer;
    property RadiusIncrement;
    property RadiusValues;
    property Transparency; { 5.02 }

    { events }
    property OnGetPointerStyle;
  end;

  TPolarBarSeries=class(TPolarSeries)
  protected
    procedure InternalDrawValue(ValueIndex,X,Y:Integer); override;
  end;

implementation

Uses {$IFDEF CLR}
     SysUtils,
     {$ELSE}
     Math,
     {$IFNDEF CLX}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeeProCo, TeeConst;

Const TeeMsg_RadiusValues='Radius'; { <-- dont translate ! }

{ TCustomPolarSeries }
Constructor TCustomPolarSeries.Create(AOwner: TComponent);
begin
  inherited;
  FCloseCircle:=True;
  FPointer:=TSeriesPointer.Create(Self);
  YValues.Name:=TeeMsg_RadiusValues;
  Brush.Style:=bsClear;
  FCircleLabelsFont:=TTeeFont.Create(CanvasChanged);
  FCirclePen:=CreateChartPen;
  FLabelsMargin:=3; // %
end;

Destructor TCustomPolarSeries.Destroy;
Begin
  FCircleLabelsFont.Free;
  FCirclePen.Free;
  FreeAndNil(FPointer);
  inherited;
end;

type TPointerAccess=class(TSeriesPointer);

Procedure TCustomPolarSeries.SetParentChart(Const Value:TCustomAxisPanel);
Begin
  inherited;
  if Assigned(FPointer) then Pointer.ParentChart:=Value;
//  if Assigned(Value) then TPointerAccess(Pointer).Canvas:=Value.Canvas;
  if Assigned(ParentChart) and (csDesigning in ComponentState) then
     ParentChart.View3D:=False;
end;

Procedure TCustomPolarSeries.SetCloseCircle(Value:Boolean);
begin
  SetBooleanProperty(FCloseCircle,Value);
end;

Procedure TCustomPolarSeries.SetLabelsRotated(Value:Boolean);
begin
  SetBooleanProperty(FCircleLabelsRot,Value);
end;

Procedure TCustomPolarSeries.DrawCircleGradient;
var tmp  : Double;
    P    : Array of TPoint;
    tmpW : Integer;
    tmpH : Integer;

  Procedure CalcPoint(Index:Integer);
  begin
    AngleToPos(Index*tmp,tmpW,tmpH,P[Index].X,P[Index].Y);
    with ParentChart do
    if View3D then
       P[Index]:=Canvas.Calculate3DPosition(P[Index],Width3D);
  end;

var t : Integer;
begin
  if IMaxValuesCount=0 then inherited
  else
  begin
    tmp:=PiDegree*AngleIncrement;
    tmpW:=CircleWidth div 2;
    tmpH:=CircleHeight div 2;

    SetLength(P,IMaxValuesCount);
    try
      for t:=0 to IMaxValuesCount-1 do CalcPoint(t);

      ParentChart.Canvas.ClipPolygon(P,IMaxValuesCount);
      try
        CircleGradient.Draw(ParentChart.Canvas,RectFromPolygon(P,IMaxValuesCount));
      finally
        ParentChart.Canvas.UnClipRectangle;
      end;
    finally
      P:=nil;
    end;
  end;
end;

Procedure TCustomPolarSeries.DrawPolarCircle(HalfWidth,HalfHeight,Z:Integer);
var OldP : TPoint;
    P    : TPoint;
    tmp  : Double;
    t    : Integer;
begin
  With ParentChart.Canvas do
  begin
    if IMaxValuesCount=0 then
       EllipseWithZ( CircleXCenter-HalfWidth,CircleYCenter-HalfHeight,
                     CircleXCenter+HalfWidth,CircleYCenter+HalfHeight, Z)
    else
    begin
      tmp:=PiDegree*AngleIncrement;
      AngleToPos(0,HalfWidth,HalfHeight,OldP.X,OldP.Y);
      MoveTo3D(OldP.X,OldP.Y,Z);

      for t:=0 to IMaxValuesCount do
      begin
        AngleToPos(t*tmp,HalfWidth,HalfHeight,P.X,P.Y);
        if Brush.Style<>bsClear then FillTriangle(OldP,P,Z);
        LineTo3D(P.X,P.Y,Z);
        OldP:=P;
      end;
    end;
  end;
end;

Function TCustomPolarSeries.GetCircleLabel(Const Angle:Double; Index:Integer):String;
var tmp : Double;
begin
  if FClockWiseLabels then tmp:=360-Angle else tmp:=Angle;
  if tmp=360 then tmp:=0;
  result:=FloatToStr(tmp)+TeePolarDegreeSymbol;
end;

type TAxisAccess=class(TChartAxis);
     TAxisPanelAccess=class(TCustomAxisPanel);

Procedure TCustomPolarSeries.DrawAxis;
var tmpValue     : Double;
    tmpIncrement : Double;

  Procedure SetGridCanvas(Axis:TChartAxis);
  Begin
    with ParentChart,Canvas do
    begin
      Brush.Style:=bsClear;
      BackMode:=cbmTransparent;
      AssignVisiblePen(Axis.Grid);
      CheckPenWidth(Pen);
      if Pen.Color=clTeeColor then Pen.Color:=clGray;
    end;
  end;

  Procedure DrawYGrid;

    Procedure InternalDrawGrid;
    begin
      DrawRing(tmpValue,EndZ);
      tmpValue:=tmpValue-tmpIncrement;
    end;

  Begin
    With GetVertAxis do
    if Grid.Visible then
    begin
      tmpIncrement:=CalcIncrement;

      if tmpIncrement>0 then
      begin
        SetGridCanvas(GetVertAxis);

        tmpValue:=Maximum/tmpIncrement;

        if (Abs(tmpValue)<MaxLongint) and
           (Abs((Maximum-Minimum)/tmpIncrement)<10000) then
        Begin
          if RoundFirstLabel then tmpValue:=tmpIncrement*Trunc(tmpValue)
                             else tmpValue:=Maximum;

          if LabelsOnAxis then
          begin
            While tmpValue>Maximum do tmpValue:=tmpValue-tmpIncrement;
            While tmpValue>=Minimum do InternalDrawGrid;
          end
          else
          begin
            While tmpValue>=Maximum do tmpValue:=tmpValue-tmpIncrement;
            While tmpValue>Minimum do InternalDrawGrid;
          end;
        end;
      end;
    end;
  end;

  Procedure DrawXGrid;

    Procedure DrawAngleLabel(Angle:Double; AIndex:Integer); { MS : 5.02 - replaced old code }
    var X         : Integer;
        Y         : Integer;
        tmpHeight : Integer;
        tmpWidth  : Integer;
        AngleRad  : Double;
        tmpSt     : String;
        tmpXRad   : Integer;
        tmpYRad   : Integer;
        tmpMult   : Integer;
        tmpMargin : Double;
    begin
      With ParentChart.Canvas do
      begin
        AssignFont(CircleLabelsFont);
        tmpHeight:=FontHeight;
        if Angle>=360 then Angle:=Angle-360;

        tmpSt:=GetCircleLabel(Angle,AIndex);

        tmpXRad:=XRadius;
        tmpYRad:=YRadius;

        if CircleLabelsInside then
        begin
          Dec(tmpXRad,TextWidth('   '));
          Dec(tmpYRad,FontHeight);  // 7.0 was: TextHeight(tmpSt)
          tmpMargin:= -LabelsMargin/100.0;
        end
        else
          tmpMargin:=LabelsMargin/100.0;

        Inc(tmpXRad,Round(tmpXRad*tmpMargin));
        Inc(tmpYRad,Round(tmpYRad*tmpMargin));

        AngleToPos(Angle*PiDegree,tmpXRad,tmpYRad,X,Y);

        Angle:=Angle+RotationAngle;
        AngleRad:=Angle*PiDegree;

        if CircleLabelsRotated then
        begin
          if (Angle>90) and (Angle<270) then
             tmpMult:= 1  { right aligned }
          else
             tmpMult:=-1; { left aligned }

          Inc(X, tmpMult*Round(0.5*tmpHeight*Sin(AngleRad)));
          Inc(Y, tmpMult*Round(0.5*tmpHeight*Cos(AngleRad)));
        end;

        if Angle>=360 then Angle:=Angle-360;

        if FCircleLabelsRot then
        begin
          if (Angle>90) and (Angle<270) then
          begin
            TextAlign:=TA_RIGHT;
            Angle:=Angle+180;
          end
          else TextAlign:=TA_LEFT;

          RotateLabel3D(X,Y,EndZ,tmpSt,Angle);
        end
        else
        begin
          if (Angle=0) or (Angle=180) then Dec(Y,tmpHeight div 2)
          else
          if (Angle>0) and (Angle<180) then Dec(Y,tmpHeight);
          if (Angle=90) or (Angle=270) then TextAlign:=ta_Center
          else
          begin
            if FCircleLabelsInside then
               if (Angle>90) and (Angle<270) then TextAlign:=ta_Left
                                             else TextAlign:=ta_Right
            else
               if (Angle>90) and (Angle<270) then TextAlign:=ta_Right
                                             else TextAlign:=ta_Left;
          end;

          tmpWidth:=TextWidth('0') div 2;

          if Angle=0 then Inc(x,tmpWidth) else
          if Angle=180 then Dec(x,tmpWidth);

          TextOut3D(X,Y,EndZ,tmpSt);
        end;
      end;
    end;

  var tmpX     : Integer;
      tmpY     : Integer;
      tmpIndex : Integer;
  begin
    with GetHorizAxis do
    if Grid.Visible or Self.CircleLabels then
    begin
      tmpIncrement:=Increment;
      if tmpIncrement<=0 then tmpIncrement:=10.0;

      SetGridCanvas(GetHorizAxis);
      tmpIndex:=0;
      tmpValue:=0;

      while tmpValue<(360-MinAxisIncrement) do  // 7.0 #1108
      begin
        if CircleLabels then DrawAngleLabel(tmpValue,tmpIndex);

        if Grid.Visible then
        begin
          AngleToPos(piDegree*tmpValue,XRadius,YRadius,tmpX,tmpY);
          ParentChart.Canvas.LineWithZ(CircleXCenter,CircleYCenter,tmpX,tmpY,EndZ);
        end;

        tmpValue:=tmpValue+tmpIncrement;
        Inc(tmpIndex);
      end;
    end;
  end;

Var tmp     : Integer;
begin
  TAxisPanelAccess(ParentChart).DoOnBeforeDrawAxes;

  DrawXGrid;
  DrawYGrid;

  With ParentChart do
  if Axes.Visible then
  begin
    With RightAxis do
    if Visible then
    begin
      if IMaxValuesCount>0 then
         TAxisAccess(RightAxis).InternalSetInverted(GetVertAxis.Inverted);

      Logarithmic:=GetVertAxis.Logarithmic;

      tmp:=CircleXCenter+TAxisAccess(RightAxis).SizeTickAxis;
      CustomDrawMinMaxStartEnd( tmp,tmp+TAxisAccess(RightAxis).SizeLabels,CircleXCenter,False,
                                GetVertAxis.Minimum,
                                GetVertAxis.Maximum,
                                GetVertAxis.Increment,
                                CircleYCenter-YRadius,CircleYCenter);
    end;

    if IMaxValuesCount=0 then
    begin
      With LeftAxis do
      if Visible then
      begin
        TAxisAccess(LeftAxis).InternalSetInverted(True);
        Logarithmic:=GetVertAxis.Logarithmic;

        tmp:=CircleXCenter-TAxisAccess(LeftAxis).SizeTickAxis;
        CustomDrawMinMaxStartEnd( tmp,tmp-TAxisAccess(LeftAxis).SizeLabels,CircleXCenter,False,
                                  GetVertAxis.Minimum,
                                  GetVertAxis.Maximum,
                                  GetVertAxis.Increment,
                                  CircleYCenter,CircleYCenter+YRadius);
        TAxisAccess(LeftAxis).InternalSetInverted(False);
      end;

      With TopAxis do
      if Visible then
      begin
        Logarithmic:=GetVertAxis.Logarithmic;

        TAxisAccess(TopAxis).InternalSetInverted(True);
        tmp:=CircleYCenter-TAxisAccess(TopAxis).SizeTickAxis;
        CustomDrawMinMaxStartEnd( tmp,tmp-TAxisAccess(TopAxis).SizeLabels,CircleYCenter,False,
                                  GetVertAxis.Minimum,
                                  GetVertAxis.Maximum,
                                  GetVertAxis.Increment,
                                  CircleXCenter-XRadius,CircleXCenter);
        TAxisAccess(TopAxis).InternalSetInverted(False);
      end;

      With BottomAxis do
      if Visible then
      begin
        Logarithmic:=GetVertAxis.Logarithmic;

        tmp:=CircleYCenter+TAxisAccess(BottomAxis).SizeTickAxis;
        CustomDrawMinMaxStartEnd( tmp,tmp+TAxisAccess(BottomAxis).SizeLabels,CircleYCenter,False,
                                  GetVertAxis.Minimum,
                                  GetVertAxis.Maximum,
                                  GetVertAxis.Increment,
                                  CircleXCenter,CircleXCenter+XRadius);
      end;
    end;
  end;
end;

type TPanelAccess=class(TCustomTeePanelExtended);

Procedure TCustomPolarSeries.DoBeforeDrawValues;

  Procedure DrawCircle;
  var R : TRect;
      tmpR : TRect;
  begin
    With ParentChart,Canvas do
    Begin
      if not Self.HasBackColor then { 5.02 }
         Brush.Style:=bsClear
      else
      begin
        Brush.Style:=bsSolid;
        Brush.Color:=CalcCircleBackColor;
      end;

      if HasBackImage and BackImage.Inside
         and ((not View3D) or (View3DOptions.Orthogonal)) then
      begin
        R:=CircleRect;
        Inc(R.Left);
        Inc(R.Top);
        Inc(R.Right);
        Inc(R.Bottom);
        if View3D then tmpR:=CalcRect3D(R,Width3D)
                  else tmpR:=R;
        ClipEllipse(tmpR);
        TPanelAccess(ParentChart).DrawBitmap(R,Width3D);
        UnClipRectangle;
      end;

      AssignVisiblePen(CirclePen);
      DrawPolarCircle(CircleWidth div 2,CircleHeight div 2,EndZ);

      if CircleGradient.Visible then DrawCircleGradient;
    end;
  end;

var t   : Integer;
    tmp : Integer;
    First : Boolean;
Begin
  inherited;

  First:=False;
  With ParentChart do
  for t:=0 to SeriesCount-1 do
  if (Series[t].Active) and (Series[t] is Self.ClassType) then
  begin
    if Series[t]=Self then
    begin
      if not First then
      begin
         if FCircleLabels and (not FCircleLabelsInside) then
         begin
           Canvas.AssignFont(FCircleLabelsFont);
           With ChartRect do
           begin
             tmp:=Canvas.FontHeight+2;
             Inc(Top,tmp);
             Dec(Bottom,tmp);
             tmp:=Canvas.TextWidth('360');
             Inc(Left,tmp);
             Dec(Right,tmp);
           end;
         end;
      end;
      break;
    end;
    First:=True;
  end;

  inherited;

  First:=False;
  With ParentChart do
  for t:=0 to SeriesCount-1 do
  if (Series[t].Active) and (Series[t] is Self.ClassType) then
  begin
    if Series[t]=Self then
    begin
      if not First then
      begin
        DrawCircle;
        if DrawAxesBehind then DrawAxis;
      end;
      break;
    end;
    First:=True;
  end;
end;

Procedure TCustomPolarSeries.CalcXYPos( ValueIndex:Integer;
                                        Const ARadius:Double;
                                        Var X,Y:Integer);

  Function CalcLogRadius(const tmpDif:Double):Double;
  var IAxisLogSizeRange : Double;
      ILogMin           : Double;
      ILogMax           : Double;
  begin
    ILogMax:=ln(GetVertAxis.Maximum);
    ILogMin:=ln(GetVertAxis.Minimum);
    IAxisLogSizeRange:=ARadius/(ILogMax-ILogMin);

    if GetVertAxis.Inverted then
       result:=Round((ILogMax-ln(tmpDif))*IAxisLogSizeRange)
    else
       result:=Round((ln(tmpDif)-ILogMin)*IAxisLogSizeRange);
  end;

var tmp       : Double;
    tmpDif    : Double;
    tmpAtEnd  : Boolean;
    tmpRadius : Double;
begin
  With GetVertAxis do tmp:=Maximum-Minimum;

  if GetVertAxis.Inverted then
     tmpDif:=GetVertAxis.Maximum-YValues.Value[ValueIndex]
  else
     tmpDif:=YValues.Value[ValueIndex]-GetVertAxis.Minimum;

  if GetVertAxis.Logarithmic then tmpAtEnd:=tmpDif<=0
                             else tmpAtEnd:=tmpDif<0;

  if (tmp=0) or tmpAtEnd then
  begin
    X:=CircleXCenter;
    Y:=CircleYCenter;
  end
  else
  begin
    if GetVertAxis.Logarithmic then
       tmpRadius:=CalcLogRadius(tmpDif)
    else
       tmpRadius:=tmpDif*ARadius/tmp;

    AngleToPos( piDegree* XValue[ValueIndex] { dont use XValues.Value} ,
                tmpRadius,tmpRadius,X,Y );
  end;
end;

Function TCustomPolarSeries.CalcYPos(ValueIndex:Integer):Integer;
var tmpX : Integer;
begin
  CalcXYPos(ValueIndex,YRadius,tmpX,result);
end;

Function TCustomPolarSeries.CalcXPos(ValueIndex:Integer):Integer;
var tmpY : Integer;
begin
  CalcXYPos(ValueIndex,XRadius,result,tmpY);
end;

procedure TCustomPolarSeries.LinePrepareCanvas(ValueIndex:Integer);
var tmpColor : TColor;
begin
  With ParentChart.Canvas do
  begin
    if Self.Pen.Visible then
    begin
      if ValueIndex=-1 then
         tmpColor:=SeriesColor
      else
      if Self.Pen.Color=clTeeColor then
         tmpColor:=ValueColor[ValueIndex]
      else
         tmpColor:=Self.Pen.Color;
      AssignVisiblePenColor(Self.Pen,tmpColor)
    end
    else Pen.Style:=psClear;

    BackMode:=cbmTransparent;
  end;
end;

Procedure TCustomPolarSeries.FillTriangle(Const A,B:TPoint; Z:Integer);
var tmpStyle : TPenStyle;
begin
  With ParentChart.Canvas do
  begin
    tmpStyle:=Pen.Style;
    Pen.Style:=psClear;
    TriangleWithZ(A,B,TeePoint(CircleXCenter,CircleYCenter),Z);
    Pen.Style:=tmpStyle;
  end;
end;

procedure TCustomPolarSeries.InternalDrawValue(ValueIndex,X,Y:Integer);

  Procedure TryFillTriangle;
  var tmpBlend : TTeeBlend;
      R        : TRect;
  begin
    if Brush.Style<>bsClear then
    begin
      {$IFDEF CLX}
      ParentChart.Canvas.ReferenceCanvas.Start;
      {$ENDIF}

      ParentChart.SetBrushCanvas(ValueColor[ValueIndex],Brush,Brush.Color);

      if Transparency>0 then
      begin
        R.Left  :=Math.Min(CircleXCenter,Math.Min(OldX,X));
        R.Top   :=Math.Min(CircleYCenter,Math.Min(OldY,Y));
        R.Right :=Math.Max(CircleXCenter,Math.Max(OldX,X));
        R.Bottom:=Math.Max(CircleYCenter,Math.Max(OldY,Y));

        R:=ParentChart.Canvas.CalcRect3D(R,StartZ);

        tmpBlend:=ParentChart.Canvas.BeginBlending(R,Transparency);
        FillTriangle(TeePoint(OldX,OldY),TeePoint(X,Y),StartZ);
        ParentChart.Canvas.EndBlending(tmpBlend);
      end
      else
        FillTriangle(TeePoint(OldX,OldY),TeePoint(X,Y),StartZ);

      {$IFDEF CLX}
      ParentChart.Canvas.ReferenceCanvas.Stop;
      {$ENDIF}

      LinePrepareCanvas(ValueIndex);
    end;
  end;

begin
  With ParentChart.Canvas do
  if ValueIndex=FirstValueIndex then MoveTo3D(X,Y,StartZ)  { <-- first point }
  else
  begin
    if (X<>OldX) or (Y<>OldY) then
    begin
      TryFillTriangle;
      LineTo3D(X,Y,StartZ);
    end;

    if (ValueIndex=LastValueIndex) and CloseCircle then
    begin
      if ColorEachPoint then
         if Brush.Style<>bsClear then
            AssignVisiblePenColor(Pen,ValueColor[0]); // 5.03

      OldX:=X;
      OldY:=Y;
      X:=CalcXPos(0);
      Y:=CalcYPos(0);
      TryFillTriangle;
      LineTo3D(X,Y,StartZ);
      X:=OldX;
      Y:=OldY;
    end;
  end;
end;

procedure TCustomPolarSeries.DrawValue(ValueIndex:Integer);
var X : Integer;
    Y : Integer;
begin
  X:=CalcXPos(ValueIndex);
  Y:=CalcYPos(ValueIndex);
  LinePrepareCanvas(ValueIndex);
  InternalDrawValue(ValueIndex,X,Y);
  OldX:=X;
  OldY:=Y;
end;

Procedure TCustomPolarSeries.DrawAllValues;
var t        : Integer;
    tmpColor : TColor;
    tmpStyle : TSeriesPointerStyle;
begin
  inherited;

  if Pointer.Visible then
    for t:=FirstValueIndex to LastValueIndex do
    begin
      tmpColor:=ValueColor[t];
      FPointer.PrepareCanvas(ParentChart.Canvas,tmpColor);

      if Assigned(FOnGetPointerStyle) then // 5.03
         tmpStyle:=FOnGetPointerStyle(Self,t)
      else
         tmpStyle:=Pointer.Style;

      Pointer.Draw(CalcXPos(t),CalcYPos(t),tmpColor,tmpStyle);
    end;
end;

Procedure TCustomPolarSeries.SetSeriesColor(AColor:TColor);
begin
  inherited;
  if Brush.Style=bsClear then Pen.Color:=AColor; // 5.03
end;

Procedure TCustomPolarSeries.SetPointer(Value:TSeriesPointer);
Begin
  FPointer.Assign(Value);
end;

Procedure TCustomPolarSeries.SetCircleLabels(Value:Boolean);
Begin
  SetBooleanProperty(FCircleLabels,Value);
end;

Procedure TCustomPolarSeries.SetCircleLabelsFont(Value:TTeeFont);
begin
  FCircleLabelsFont.Assign(Value);
end;

class Function TCustomPolarSeries.GetEditorClass:String;
Begin
  result:='TPolarSeriesEditor'; { <-- dont translate ! }
end;

{ The BottomAxis is used in Angle axis }
Function TCustomPolarSeries.GetAngleIncrement:Double;
Const MinAngle = 10;
begin
  if ParentChart=nil then result:=MinAngle
  else
  begin
    result:=GetHorizAxis.Increment;
    if result=0 then result:=MinAngle;
  end;
end;

{ The BottomAxis is used in Angle axis }
Procedure TCustomPolarSeries.SetAngleIncrement(Const Value:Double);
begin
  if Assigned(ParentChart) then GetHorizAxis.Increment:=Value;
end;

{ The LeftAxis is used in Radius axis }
Function TCustomPolarSeries.GetRadiusIncrement:Double;
begin
  if ParentChart=nil then result:=0
                     else result:=GetVertAxis.Increment;
end;

{ The LeftAxis is used in Radius axis }
Procedure TCustomPolarSeries.SetRadiusIncrement(Const Value:Double);
begin
  if Assigned(ParentChart) then GetVertAxis.Increment:=Value;
end;

Function TCustomPolarSeries.Clicked(x,y:Integer):Integer;
var t : Integer;
begin
  if Assigned(ParentChart) then ParentChart.Canvas.Calculate2DPosition(x,y,StartZ);

  result:=inherited Clicked(x,y);

  if (result=TeeNoPointClicked) and
     (FirstValueIndex>-1) and (LastValueIndex>-1) then

    if FPointer.Visible then
    for t:=FirstValueIndex to LastValueIndex do
        if (Abs(CalcXPos(t)-X)<FPointer.HorizSize) and
           (Abs(CalcYPos(t)-Y)<FPointer.VertSize) then
        begin
          result:=t;
          break;
        end;
end;

Procedure TCustomPolarSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmpColor : TColor;
begin
  if Pen.Visible then
  begin
    LinePrepareCanvas(ValueIndex);
    With Rect do ParentChart.Canvas.DoHorizLine(Left,Right,(Top+Bottom) div 2);
  end;

  if FPointer.Visible then
  begin
    if ValueIndex=-1 then tmpColor:=SeriesColor
                     else tmpColor:=ValueColor[ValueIndex];
    TeePointerDrawLegend(FPointer,tmpColor,Rect,Pen.Visible);
  end
  else
  if not Pen.Visible then inherited
end;

{ Used to draw inside filled circles (grid) (or radar grid lines) }
{ Can be used also to custom draw circle zones at specific values }
Procedure TCustomPolarSeries.DrawZone(Const Min,Max:Double; Z:Integer);
var tmpX   : Integer;
    tmpY   : Integer;
    tmpR   : TRect;
begin
  CalcXYRadius(Min,tmpX,tmpY);
  tmpR:=TeeRect(CircleXCenter-tmpX,CircleYCenter-tmpY,CircleXCenter+tmpX,CircleYCenter+tmpY);

  ParentChart.Canvas.ClipEllipse(tmpR,True);

  CalcXYRadius(Max,tmpX,tmpY);
  tmpR:=TeeRect(CircleXCenter-tmpX,CircleYCenter-tmpY,CircleXCenter+tmpX,CircleYCenter+tmpY);

  ParentChart.Canvas.Ellipse(tmpR);
  ParentChart.Canvas.UnClipRectangle;
end;

Procedure TCustomPolarSeries.CalcXYRadius(Const Value:Double; Var X,Y:Integer);
Var tmp : Double;
begin
  with GetVertAxis do
  begin
    tmp:=Maximum-Minimum;
    if tmp<>0 then
    begin
      tmp:=(Value-Minimum)/tmp;
      X:=Round(tmp*XRadius);
      Y:=Round(tmp*YRadius);
    end
    else
    begin
      X:=0;
      Y:=0;
    end;
  end;
end;

{ Used to draw inside circles (grid) (or radar grid lines) }
{ Can be used also to custom draw circles at specific values }
Procedure TCustomPolarSeries.DrawRing(Const Value:Double; Z:Integer);
var tmpX : Integer;
    tmpY : Integer;
begin
  ParentChart.Canvas.Brush.Style:=bsClear;
  CalcXYRadius(Value,tmpX,tmpY);
  DrawPolarCircle(tmpX,tmpY,Z);
end;

Procedure TCustomPolarSeries.Assign(Source:TPersistent);
begin
  if Source is TCustomPolarSeries then
  With TCustomPolarSeries(Source) do
  begin
    Self.FCircleLabels   := FCircleLabels;
    Self.CircleLabelsFont:= FCircleLabelsFont;
    Self.FCircleLabelsInside:=FCircleLabelsInside;
    Self.FCircleLabelsRot:= FCircleLabelsRot;
    Self.CirclePen       := FCirclePen;
    Self.FLabelsMargin   := FLabelsMargin;
    Self.FClockWiseLabels:= FClockWiseLabels;
    Self.FCloseCircle    := FCloseCircle;
    Self.Pointer         := FPointer;
    Self.FTransparency   := Transparency; { 5.02 }
  end;
  inherited;
end;

Function TCustomPolarSeries.GetRadiusValues:TChartValueList;
begin
  result:=YValues;
end;

Procedure TCustomPolarSeries.SetRadiusValues(Value:TChartValueList);
begin
  SetYValues(Value); { overrides the default YValues }
end;

Function TCustomPolarSeries.IsRadiusStored:Boolean;
begin
  With YValues do
  result:=(Name<>TeeMsg_RadiusValues) or DateTime or
          {$IFDEF TEEMULTIPLIER}(Multiplier<>1) or {$ENDIF}
          (Order<>loNone) or (ValueSource<>'');
end;

Function TCustomPolarSeries.GetAngleValues:TChartValueList;
begin
  result:=XValues;
end;

Procedure TCustomPolarSeries.SetAngleValues(Value:TChartValueList);
begin
  SetXValues(Value); { overrides the default XValues }
end;

Procedure TCustomPolarSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  Circled:=True;
  GetHorizAxis.Increment:=90;
  With ParentChart do
  begin
    Chart3DPercent:=5;
    RightAxis.Labels:=False;
    TopAxis.Labels:=False;
    With View3DOptions do
    begin
      Orthogonal:=False;
      Elevation:=360;
      Zoom:=90;
    end;
  end;
end;

procedure TCustomPolarSeries.SetClockWiseLabels(const Value: Boolean);
begin
  SetBooleanProperty(FClockWiseLabels,Value);
end;

procedure TCustomPolarSeries.SetCirclePen(Value: TChartPen);
begin
  FCirclePen.Assign(Value);
end;

class procedure TCustomPolarSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoPoint);
  AddSubChart(TeeMsg_NoLine);
  AddSubChart(TeeMsg_Filled);
  AddSubChart(TeeMsg_Labels);
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_NoCircle);
end;

class procedure TCustomPolarSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TCustomPolarSeries(ASeries) do
  Case Index of
    1: Pointer.Hide;
    2: Pen.Hide;
    3: Brush.Style:=bsSolid;
    4: CircleLabels:=True;
    5: Pointer.Pen.Hide;
    6: CirclePen.Hide;
  else inherited;
  end;
end;

procedure TCustomPolarSeries.SetCircleLabelsInside(const Value: Boolean);
begin
  SetBooleanProperty(FCircleLabelsInside,Value);
end;

type TChartAccess=class(TCustomAxisPanel);

Function TCustomPolarSeries.DrawAxesBehind:Boolean;
begin
  result:=ParentChart.Axes.Behind;
  if ParentChart.View3D and (not ParentChart.View3DOptions.Orthogonal) and
     TChartAccess(ParentChart).DrawBackWallAfter(ParentChart.Width3D) then
        result:=not result;
end;

procedure TCustomPolarSeries.DoAfterDrawValues;
var tmp : Boolean;
    t   : Integer;
begin
  if not DrawAxesBehind then
  begin
    tmp:=False;
    With ParentChart do
    for t:=SeriesList.IndexOf(Self)+1 to SeriesCount-1 do
        if Series[t] is Self.ClassType then
        begin
          tmp:=True;
          break;
        end;
    if not tmp then DrawAxis;
  end;
  inherited;
end;

Procedure TCustomPolarSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                       APosition:TSeriesMarkPosition);
begin
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

procedure TCustomPolarSeries.SetTransparency(Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

Procedure TCustomPolarSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t   : Integer;
    tmp : Double;
Begin
  tmp:=360.0/NumValues;
  for t:=1 to NumValues do
      AddXY( t*tmp,                      { <-- Angle }
             1+RandomValue(ChartSamplesMax)  { <-- Value (Radius) }
             );
end;

function TCustomPolarSeries.DrawValuesForward: Boolean;
begin
  result:=True;
end;

procedure TCustomPolarSeries.SetLabelsMargin(const Value: Integer);
begin
  SetIntegerProperty(FLabelsMargin,Value);
end;

{ TPolarSeries }
Function TPolarSeries.AddPolar( Const Angle,Value:Double;
                                Const ALabel:String;
                                AColor:TColor):Integer;
begin
  result:=AddXY(Angle,Value,ALabel,AColor);
end;

{ TRadarSeries }
Procedure TRadarSeries.DoBeforeDrawChart;
begin
  inherited;
  SetRotationAngle(90);
  IMaxValuesCount:=ParentChart.GetMaxValuesCount;

  if IMaxValuesCount>0 then
     AngleIncrement:=360.0/IMaxValuesCount;
end;

Procedure TRadarSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var RadarSampleStr : Array[0..4] of String;
    t : Integer;
begin
  RadarSampleStr[0]:=TeeMsg_PieSample1;
  RadarSampleStr[1]:=TeeMsg_PieSample2;
  RadarSampleStr[2]:=TeeMsg_PieSample3;
  RadarSampleStr[3]:=TeeMsg_PieSample4;
  RadarSampleStr[4]:=TeeMsg_PieSample5;
  for t:=0 to NumValues-1 do
      Add(RandomValue(1000),RadarSampleStr[t mod 5]);
end;

Procedure TRadarSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  FillSampleValues(NumSampleValues);
end;

Function TRadarSeries.GetCircleLabel(Const Angle:Double; Index:Integer):String;
begin
  if ClockWiseLabels then Index:=Count-1-Index;
  result:=Labels[Index];
  if result='' then result:=TeeStr(Index);
end;

Function TRadarSeries.NumSampleValues:Integer;
begin
  result:=5;
end;

Function TRadarSeries.GetxValue(ValueIndex:Integer):Double;
begin
  if ClockWiseLabels then ValueIndex:=Count-1-ValueIndex;
  
  { return X value in degrees }
  if IMaxValuesCount>0 then
     result:=ValueIndex*(360.0/IMaxValuesCount)
  else
     result:=0;
end;

{ TPolarBarSeries }
procedure TPolarBarSeries.InternalDrawValue(ValueIndex,X,Y:Integer);
begin
  if not IsNull(ValueIndex) then
  begin
    ParentChart.Canvas.AssignVisiblePenColor(Pen,ValueColor[ValueIndex]);
    ParentChart.Canvas.LineWithZ(CircleXCenter,CircleYCenter,X,Y,StartZ);
  end;
end;

initialization
  RegisterTeeSeries(TPolarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryPolar,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,2);
  RegisterTeeSeries(TRadarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryRadar,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,2);
  RegisterTeeSeries(TPolarBarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryPolarBar,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,2);
finalization
  UnRegisterTeeSeries([TPolarSeries,TRadarSeries,TPolarBarSeries]);
end.
