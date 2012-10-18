{*********************************************}
{   TeeChart Delphi Component Library         }
{   TSmithSeries Component                    }
{   Copyright (c) 2000-2004 Marjan Slatinek   }
{*********************************************}
unit TeeSmith;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Windows,
     Classes,
     Graphics,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$ENDIF}
     TeEngine, Chart, Series, TeCanvas, TeePolar;

type
  TSmithSeries = class(TCircledSeries)
  private
    FCirclePen  : TChartPen;
    FImagSymbol : String;
    FPointer    : TSeriesPointer;

    OldX,OldY   : Integer;
    function GetResistanceValues: TChartValueList;
    function GetReactance: TChartValueList;
    Function GetCPen:TChartPen;
    Function GetRPen:TChartPen;
    Function GetCLabels:Boolean;
    Function GetRLabels:Boolean;
    procedure SetResistanceValues(Value: TChartValueList);
    procedure SetReactance(Value: TChartValueList);
    procedure SetRPen(const Value: TChartPen);
    procedure SetCPen(const Value: TChartPen);
    procedure SetPointer(const Value: TSeriesPointer);
    procedure SetCLabels(const Value: Boolean);
    procedure SetRLabels(const Value: Boolean);
    Procedure SetCirclePen(Const Value:TChartPen);
    function GetCLabelsFont: TTeeFont;
    function GetRLabelsFont: TTeeFont;
    procedure SetCLabelsFont(const Value: TTeeFont);
    procedure SetRLabelsFont(const Value: TTeeFont);
    procedure SetImagSymbol(Const Value:String);
  protected
    procedure AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False); override;
    procedure DoBeforeDrawValues; override;
    procedure DrawAllValues; override;
    procedure DrawValue(ValueIndex: Integer); override;
    class Function GetEditorClass:String; override;
    function GetXCircleLabel(Const Reactance:Double):String;
    procedure LinePrepareCanvas(ValueIndex:Integer);
    Procedure PrepareForGallery(IsEnabled:Boolean); override; { 5.02 }
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    function AddPoint(Const Resist,React: Double; Const ALabel: String='';
                      AColor: TColor=clTeeColor): Integer;
    function CalcXPos(ValueIndex: Integer): Integer; override;
    function CalcYPos(ValueIndex: Integer): Integer; override;
    function Clicked(X,Y:Integer):Integer;override;
    procedure DrawRCircle(Const Value:Double; Z:Integer; ShowLabel:Boolean=True);
    procedure DrawXCircle(Const Value:Double; Z:Integer; ShowLabel:Boolean=True);
    procedure PosToZ(X,Y: Integer; var Resist,React: Double);
    procedure ZToPos(Const Resist,React: Double; var X,Y: Integer);
  published
    property Active;
    property CCirclePen:TChartPen read GetCPen write SetCPen;
    property CircleBackColor;
    property CircleGradient;
    property CirclePen:TChartPen read FCirclePen write SetCirclePen;
    property CLabels:Boolean read GetCLabels write SetCLabels;
    property CLabelsFont:TTeeFont read GetCLabelsFont write SetCLabelsFont;
    property ColorEachPoint;
    property ImagSymbol:String read FImagSymbol write SetImagSymbol;

    property ResistanceValues:TChartValueList read GetResistanceValues write SetResistanceValues;
    property ReactanceValues:TChartValueList read GetReactance write SetReactance;
    property Pen;
    property Pointer:TSeriesPointer read FPointer write SetPointer;
    property RCirclePen:TChartPen read GetRPen write SetRPen;
    property RLabels:Boolean read GetRLabels write SetRLabels;
    property RLabelsFont:TTeeFont read GetRLabelsFont write SetRLabelsFont;
  end;

implementation

Uses {$IFDEF CLR}
     SysUtils,
     {$ENDIF}
     TeeProCo, TeeConst;

{ TSmithSeries }
Constructor TSmithSeries.Create(AOwner: TComponent);
begin
  inherited;
  XValues.Name := TeeMsg_SmithResistance;
  XValues.Order:= loNone; { 5.02 }
  YValues.Name := TeeMsg_SmithReactance;
  FPointer     := TSeriesPointer.Create(Self);
  FCirclePen   := CreateChartPen;
  FImagSymbol  := 'i'; { 5.02 }
end;

Destructor TSmithSeries.Destroy;
begin
  FCirclePen.Free;
  FreeAndNil(FPointer);
  inherited;
end;

procedure TSmithSeries.SetCLabels(Const Value: Boolean);
begin
  if Assigned(GetVertAxis) then
     GetVertAxis.Labels:=Value;
end;

procedure TSmithSeries.SetRLabels(Const Value: Boolean);
begin
  if Assigned(GetHorizAxis) then
     GetHorizAxis.Labels:=Value;
end;

procedure TSmithSeries.SetRPen(const Value: TChartPen);
begin
  if Assigned(GetVertAxis) then
     GetVertAxis.Grid.Assign(Value);
end;

procedure TSmithSeries.SetCPen(const Value: TChartPen);
begin
  if Assigned(GetHorizAxis) then
     GetHorizAxis.Grid.Assign(Value);
end;

procedure TSmithSeries.SetPointer(const Value: TSeriesPointer);
begin
  FPointer.Assign(Value);
end;

function TSmithSeries.GetResistanceValues: TChartValueList;
begin
  Result:=XValues;
end;

function TSmithSeries.GetReactance: TChartValueList;
begin
  Result:=YValues;
end;

procedure TSmithSeries.SetResistanceValues(Value: TChartValueList);
begin
  SetXValues(Value);
end;

procedure TSmithSeries.SetReactance(Value: TChartValueList);
begin
  SetYValues(Value);
end;

procedure TSmithSeries.LinePrepareCanvas(ValueIndex:Integer);
begin
  With ParentChart.Canvas do
  begin
    if Self.Pen.Visible then
    begin
      if ValueIndex=-1 then AssignVisiblePenColor(Self.Pen,SeriesColor)
                       else AssignVisiblePenColor(Self.Pen,ValueColor[ValueIndex]);
    end
    else Pen.Style:=psClear;
    BackMode:=cbmTransparent;
  end;
end;

{ impendance to Position}
{ (GRe,GIm)=(1-z)/(1+z)                   }
procedure TSmithSeries.ZToPos(Const Resist,React: Double; var X,Y: Integer);
var GRe    : Double;
    GIm    : Double;
    Norm2  : Double;
    InvDen : Double;
begin
  Norm2 := Sqr(Resist)+Sqr(React);
  InvDen := 1/(Norm2+2*Resist+1);
  GRe := (Norm2-1)*InvDen;
  GIm := 2*React*InvDen;
  X := CircleXCenter+Round(GRe*XRadius);
  Y := CircleYCenter-Round(GIm*YRadius);
end;

{ Position to impendance}
{ (ZRe,ZIm)=(1+gamma)/(1-gamma)                }
procedure TSmithSeries.PosToZ(X,Y: Integer; var Resist,React: Double);
var GRe    : Double;
    GIm    : Double;
    Norm2  : Double;
    InvDen : Double;
begin
  X := X-CircleXCenter;
  Y := CircleYCenter-Y;
  GRe := X/XRadius;
  GIm := Y/YRadius;
  Norm2 := Sqr(GRe)+Sqr(GIm);
  InvDen := 1/(Norm2-2*GRe+1);
  Resist := (1-Norm2)*InvDen;
  React := 2*GIm*InvDen;
end;

Procedure TSmithSeries.DrawRCircle(Const Value:Double; Z:Integer;
                                   ShowLabel: Boolean);

  Procedure DrawrCircleLabel(rVal: Double; X,Y: Integer);
  begin
    if GetHorizAxis.Visible and ShowLabel then { 5.02 }
    With ParentChart.Canvas do
    begin
      AssignFont(RLabelsFont);
      TextAlign:=ta_Center;
      BackMode:=cbmTransparent;
      TextOut3D(X,Y,EndZ,FloatToStr(rVal));
    end;
  end;

Var tmp       : Double;
    HalfXSize : Integer;
    HalfYSize : Integer;
begin
  if Value<>-1 then
  begin
    { Transform R }
    tmp := 1/(1+Value);
    HalfXSize := Round(tmp*XRadius);
    HalfYSize := Round(tmp*YRadius);
    { Circles are always right aligned }
    With ParentChart.Canvas do
        EllipseWithZ(CircleRect.Right-2*HalfXSize,CircleYCenter-HalfYSize,
                     CircleRect.Right,CircleYCenter+HalfYSize,Z);
    if ShowLabel then { 5.02 (was if RLabels) }
       DrawRCircleLabel(Value,CircleRect.Right-2*HalfXSize,CircleYCenter);
  end;
end;

procedure TSmithSeries.DrawValue(ValueIndex: Integer);
var X : Integer;
    Y : Integer;
begin
  ZToPos(XValues.Value[ValueIndex],YValues.Value[ValueIndex],X,Y);
  LinePrepareCanvas(ValueIndeX);
  With ParentChart.Canvas do
    if ValueIndex=FirstValueIndex then MoveTo3D(X,Y,StartZ)  { <-- first point }
    else
    if (X<>OldX) or (Y<>OldY) then LineTo3D(X,Y,StartZ);

  OldX:=X;
  OldY:=Y;
end;

type TPointerAccess=class(TSeriesPointer);
     TAxisAccess=class(TChartAxis);

procedure TSmithSeries.DrawAllValues;
var t        : Integer;
    tmpColor : TColor;
begin
  inherited;

  With FPointer do
  if Visible then
    for t:=FirstValueIndex to LastValueIndex do
    begin
      tmpColor:=ValueColor[t];
      FPointer.PrepareCanvas(ParentChart.Canvas,tmpColor);
      Draw(CalcXPos(t),CalcYPos(t),tmpColor,Style);
    end;
end;

Procedure TSmithSeries.SetParentChart(Const Value:TCustomAxisPanel);
Begin
  inherited;
  if Assigned(FPointer) and Assigned(Value) then
     Pointer.ParentChart:=Value;
  if Assigned(ParentChart) and (csDesigning in ParentChart.ComponentState) then
     ParentChart.View3D:=False;
end;

procedure TSmithSeries.DrawXCircle(Const Value:Double; Z: Integer; ShowLabel: boolean);

  Procedure DrawXCircleLabel(XVal: Double; X,Y: Integer);
  var Angle     : Double;
      tmpHeight : Integer;
      tmpWidth  : Integer;
      tmpSt     : String;
  begin
    if GetVertAxis.Visible and ShowLabel then { 5.02 }
    With ParentChart.Canvas do
    begin
      AssignFont(CLabelsFont);
      tmpHeight:=FontHeight;
      tmpSt:=GetxCircleLabel(XVal);
      Angle := PointToAngle(X,Y)*57.29577;
      if Angle>=360 then Angle:=Angle-360;
      begin
        if (Angle=0) or (Angle=180) then Dec(Y,tmpHeight div 2)
        else
        if (Angle>0) and (Angle<180) then Dec(Y,tmpHeight);
        if (Angle=90) or (Angle=270) then TextAlign:=ta_Center
        else
             if (Angle>90) and (Angle<270) then TextAlign:=ta_Right
                                           else TextAlign:=ta_Left;

        tmpWidth:=TextWidth('0') div 2;

        if Angle=0 then Inc(x,tmpWidth) else
        if Angle=180 then Dec(x,tmpWidth);

        BackMode:=cbmTransparent;
        TextOut3D(X,Y,EndZ,tmpSt);
      end;
    end;
  end;

var X1,X2,X3,X4,
    Y1,Y2,Y3,Y4 : Integer;
    HalfXSize,
    HalfYSize  : Integer;
    InvValue   : Double;
begin
  if Value <> 0 then
  With ParentChart.Canvas do
  begin
    InvValue := 1/Value;
    ZToPos(0,Value,X4,Y4); // Endpos
    if ShowLabel then DrawXCircleLabel(Value,X4,Y4);
    ZToPos(100,Value,X3,Y3); // Startpos
    // ellipse bounding points
    HalfXSize := Round(InvValue*XRadius);
    HalfYSize := Round(InvValue*YRadius);
    X1 := CircleRect.Right - HalfXSize;
    X2 := CircleRect.Right + HalfXSize;
    Y1 := CircleYCenter;
    Y2 := Y1-2*HalfYSize;
    if (not ParentChart.View3D) or ParentChart.View3DOptions.Orthogonal then
       Arc(X1,Y1,X2,Y2,X4,Y4,X3,Y3);
    ZToPos(0,-Value,X4,Y4); // Endpos
    if (not ParentChart.View3D) or ParentChart.View3DOptions.Orthogonal then
       Arc(X1,Y1,X2,Y1+2*HalfYSize,X3,Y3,X4,Y4);
    if ShowLabel then DrawXCircleLabel(-Value,X4,Y4);
  end
  else
  begin { special case then reactance is zero }
    X1 := CircleRect.Left;
    X2 := CircleRect.Right;
    Y1 := CircleYCenter;
    ParentChart.Canvas.LineWithZ(X1,Y1,X2,Y1,MiddleZ);
    if ShowLabel then DrawXCircleLabel(0,X1,Y1);
  end;
end;

Procedure TSmithSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t : Integer;
begin
  for t:=0 to NumValues-1 do
      AddPoint( 6.5*t/NumValues,(RandomValue(t)+3.8)/NumValues);
end;

{ NOTE : the assumption is all points are normalized by Z0 }
function TSmithSeries.AddPoint(Const Resist,React: Double; Const ALabel: String; AColor: TColor): Integer;
begin
  result:=AddXY(Resist,React,ALabel,AColor);
end;

function TSmithSeries.CalcXPos(ValueIndex: Integer): Integer;
var DummyY : Integer;
begin
  ZToPos(XValues.Value[ValueIndex],YValues.Value[ValueIndex],Result,DummyY);
end;

function TSmithSeries.CalcYPos(ValueIndex: Integer): Integer;
var DummyX : Integer;
begin
  ZToPos(XValues.Value[ValueIndex],YValues.Value[ValueIndex],DummyX,Result);
end;

Function TSmithSeries.Clicked(X,Y:Integer):Integer;
var t : Integer;
begin
  if Assigned(ParentChart) then ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

  result:=inherited Clicked(X,Y);

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

procedure TSmithSeries.DoBeforeDrawValues;

  procedure DrawXCircleGrid;
  const DefaultX: Array [0..11] of Double =
        (0,0.1,0.3,0.5,0.8,1,1.5,2,3,5,7,10);
  var i : Integer;
  begin
    with ParentChart.Canvas do
    begin
      Brush.Style:=bsClear;
      AssignVisiblePen(CCirclePen);
      BackMode:=cbmTransparent;
    end;
    for i := 0 to High(DefaultX) do DrawXCircle(DefaultX[i],MiddleZ,CLabels);
  end;

  procedure DrawRCircleGrid;
  const DefaultR: Array [0..6] of Double =
        (0,0.2,0.5,1,2,5,10);
  var i : Integer;
  begin
    with ParentChart.Canvas do
    begin
      Brush.Style:=bsClear;
      AssignVisiblePen(RCirclePen);
      BackMode:=cbmTransparent;
    end;
    for i := 0 to High(DefaultR) do DrawRCircle(DefaultR[i],MiddleZ,RLabels);
  end;

  procedure DrawAxis;
  begin
    if GetVertAxis.Visible then DrawXCircleGrid;
    if GetHorizAxis.Visible then DrawRCircleGrid;
  end;

  Procedure DrawCircle;
  var tmpX,
      tmpY : Integer;
  begin
    With ParentChart.Canvas do
    Begin
      if not Self.HasBackColor then Brush.Style:=bsClear
      else
      begin
        Brush.Style:=bsSolid;
        Brush.Color:=CalcCircleBackColor;
      end;

      AssignVisiblePen(CirclePen);
      tmpX:=CircleWidth div 2;
      tmpY:=CircleHeight div 2;
      EllipseWithZ( CircleXCenter-tmpX,CircleYCenter-tmpY,
                    CircleXCenter+tmpX,CircleYCenter+tmpY, EndZ);

      if CircleGradient.Visible then
         DrawCircleGradient;
    end;
  end;

var t   : Integer;
    tmp : Integer;
    First : Boolean;
Begin
  First:=False;

  With ParentChart do
  for t:=0 to SeriesCount-1 do
  if (Series[t].Active) and (Series[t] is Self.ClassType) then
  begin
    if Series[t]=Self then
    begin
      if Not First then
      begin
         if CLabels then
         begin
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
        if Axes.Visible and Axes.Behind then
           DrawAxis;
      end;
      break;
    end;
    First:=True;
  end;
end;

class function TSmithSeries.GetEditorClass: String;
begin
  result:='TSmithSeriesEdit';
end;

procedure TSmithSeries.SetCirclePen(Const Value: TChartPen);
begin
  FCirclePen.Assign(Value);
end;

function TSmithSeries.GetXCircleLabel(Const Reactance: Double): String;
begin
  Result:=FloatToStr(Reactance)+FImagSymbol;
end;

function TSmithSeries.GetCLabels: Boolean;
begin
  if Assigned(GetVertAxis) then
     result:=GetVertAxis.Labels
  else
     result:=True;
end;

function TSmithSeries.GetCPen: TChartPen;
begin
  if Assigned(GetVertAxis) then
     result:=GetVertAxis.Grid
  else
     result:=Pen;  // workaround
end;

function TSmithSeries.GetRLabels: Boolean;
begin
  if Assigned(GetHorizAxis) then
     result:=GetHorizAxis.Labels
  else
     result:=True;
end;

function TSmithSeries.GetRPen: TChartPen;
begin
  if Assigned(GetHorizAxis) then
     result:=GetHorizAxis.Grid
  else
     result:=Pen; // workaround
end;

function TSmithSeries.GetCLabelsFont: TTeeFont;
begin
  if Assigned(GetVertAxis) then
     result:=GetVertAxis.LabelsFont
  else
     result:=Marks.Font; // workaround
end;

function TSmithSeries.GetRLabelsFont: TTeeFont;
begin
  if Assigned(GetHorizAxis) then
     result:=GetHorizAxis.LabelsFont
  else
     result:=Marks.Font; // workaround
end;

procedure TSmithSeries.SetCLabelsFont(const Value: TTeeFont);
begin
  if Assigned(GetVertAxis) then
     GetVertAxis.LabelsFont:=Value
end;

procedure TSmithSeries.SetRLabelsFont(const Value: TTeeFont);
begin
  if Assigned(GetHorizAxis) then
     GetHorizAxis.LabelsFont:=Value;
end;

procedure TSmithSeries.SetImagSymbol(const Value: String);
begin
  SetStringProperty(FImagSymbol,Value);
end;

procedure TSmithSeries.PrepareForGallery(IsEnabled: Boolean); { 5.02 }
begin
  inherited;
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

initialization
  RegisterTeeSeries(TSmithSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySmith,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,2);
finalization
  UnRegisterTeeSeries([TSmithSeries]);
end.
