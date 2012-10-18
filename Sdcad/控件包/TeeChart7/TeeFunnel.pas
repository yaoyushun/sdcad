{****************************************************************}
{*                                                              *}
{* Unit Name: TeeFunnel                                         *}
{* Purpose  : The Funnel or Pipeline Series                     *}
{* Author   : Marjan Slatinek, marjan@steema.com                *}
{* History  : v1.0 (Requires TeeChart v5 or later)              *}
{*          : v1.5 (Ported to 7.0 and .NET by David Berneda)    *}
{*                                                              *}
{****************************************************************}
unit TeeFunnel;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Classes, SysUtils, TeEngine, Chart, TeCanvas;

type
  TFunnelSeries = class(TChartSeries)
  private
    FAboveColor   : TColor;
    FAutoUpdate   : Boolean;
    FBelowColor   : TColor;
    FDifferenceLimit: Double;
    FLinesPen     : TChartPen;
    FOpportunityValues: TChartValueList;
    FQuotesSorted : Boolean;
    FWithinColor  : TColor;

    { internal }
    IPolyPoints   : Array of TPoint;
    ISorted : Boolean;
    IMin    : Double;
    IMax    : Double;
    ISlope  : Double;
    IDiff   : Double;
    BoundingPoints: Array[0..3] of TPoint;

    function DefineFunnelRegion(ValueIndex: Integer): TColor;
    function GetQuoteValues: TChartValueList; virtual;
    procedure SetAboveColor(const Value: TColor);
    procedure SetAutoUpdate(const Value: boolean);
    procedure SetBelowColor(const Value: TColor);
    procedure SetDifferenceLimit(const Value: double);
    procedure SetLinesPen(const Value: TChartPen);
    procedure SetOpportunityValues(const Value: TChartValueList);
    procedure SetQuotesSorted(const Value: boolean);
    procedure SetQuoteValues(const Value: TChartValueList); virtual;
    procedure SetWithinColor(const Value: TColor);
  protected
    procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);override;
    procedure DoBeforeDrawChart; override;
    procedure DrawAllValues; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                                       APosition:TSeriesMarkPosition); override;
    procedure DrawValue(ValueIndex: Integer);override;
    class Function GetEditorClass:String; override;
    procedure GetMarkText(Sender: TChartSeries; ValueIndex: Integer;
                          var MarkText: String);
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    function AddSegment(Const AQuote, AOpportunity: Double;
                        Const ALabel: String; AColor: TColor): Integer;
    function Clicked(X,Y:Integer):Integer; override;
    Function CountLegendItems:Integer; override;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MinYValue:Double; override;
    procedure Recalc;
  published
    property Brush;
    property Pen;
    property AboveColor: TColor read FAboveColor write SetAboveColor default clGreen;
    property AutoUpdate: boolean read FAutoUpdate write SetAutoUpdate default true;
    property BelowColor : TColor read FBelowColor write SetBelowColor default clRed;
    property DifferenceLimit : double read FDifferenceLimit write SetDifferenceLimit;
    property LinesPen:TChartPen read FLinesPen write SetLinesPen;
    property OpportunityValues: TChartValueList read FOpportunityValues write SetOpportunityValues;
    property QuotesSorted : boolean read FQuotesSorted write SetQuotesSorted default false;
    property QuoteValues: TChartValueList read GetQuoteValues write SetQuoteValues;
    property WithinColor : TColor read FWithinColor write SetWithinColor default clYellow;
  end;

implementation

{$IFDEF CLR}
{$R 'TFunnelSeries.bmp'}
{$ELSE}
{$R TeeFunne.res}
{$ENDIF}

Uses {$IFDEF D6}
     {$IFNDEF CLX}
     Types,
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeeProCo, TeeConst;

{ TFunnelSeries }
Constructor TFunnelSeries.Create(AOwner: TComponent);
begin
  inherited;
  FOpportunityValues := TChartValueList.Create(Self,TeeMsg_OpportunityValues);
  Self.XValues.Name := '';
  Self.XValues.Order := loNone;

  PercentFormat:=TeeMsg_FunnelPercent;

  FOpportunityValues.Order := loNone;
  Self.QuoteValues.Order := loDescending;
  Self.YValues.Name := TeeMsg_QuoteValues;
  FAutoUpdate := true;
  FQuotesSorted := false;
  ISorted := false;
  FDifferenceLimit := 30.0;
  FAboveColor := clGreen;
  FWithinColor := clYellow;
  FBelowColor := clRed;
  OnGetMarkText := GetMarkText;
  FLinesPen:=CreateChartPen;
  IUseSeriesColor:=False;
end;

Destructor TFunnelSeries.Destroy;
begin
  FLinesPen.Free;
  IPolyPoints:=nil;
  inherited;
end;

function TFunnelSeries.AddSegment(const AQuote, AOpportunity: Double;
  const ALabel: String; AColor: TColor): Integer;
begin
  FOpportunityValues.TempValue := AOpportunity;
  Result := Add(AQuote,ALabel,AColor);
  if Not FQuotesSorted then
  begin
    YValues.Sort;
    XVAlues.FillSequence;
    ISorted := true;
  end;
end;

function TFunnelSeries.GetQuoteValues: TChartValueList;
begin
  Result := MandatoryValueList;
end;

procedure TFunnelSeries.Recalc;
begin
  if not ISorted then
  begin
    QuoteValues.Sort;
    XValues.FillSequence;
    ISorted := true;
  end;

  if Count>0 then
  begin
    IMax := QuoteValues.First;
    IMin := QuoteValues.Last;
    ISlope := 0.5*(IMax-IMin) / Count;
  end;
end;

procedure TFunnelSeries.SetAutoUpdate(const Value: boolean);
begin
  FAutoUpdate := Value;
  if FAutoUpdate then Recalc;
end;

procedure TFunnelSeries.SetQuoteValues(const Value: TChartValueList);
begin
  SetYValues(Value); { overrides the default YValues }
end;

procedure TFunnelSeries.SetQuotesSorted(const Value: boolean);
begin
  FQuotesSorted := Value;
  ISorted := FQuotesSorted;
end;

procedure TFunnelSeries.SetOpportunityValues(const Value: TChartValueList);
begin
  SetChartValueList(FOpportunityValues,Value); { standard method }
end;

procedure TFunnelSeries.DrawValue(ValueIndex: Integer);
begin
  With ParentChart.Canvas do
  begin
    AssignBrush(Self.Brush,DefineFunnelRegion(ValueIndex));
    if ParentChart.View3D then PolygonWithZ(IPolyPoints,StartZ)
                          else Polygon(IPolyPoints);
  end
end;

procedure TFunnelSeries.DrawAllValues;

  procedure DrawVertLine(ValueIndex: Integer);
  var tmpX : Integer;
  begin
    tmpX:=CalcXPosValue(ValueIndex + 0.5);
    With ParentChart.Canvas do
      if ParentChart.View3D then
         VertLine3D(tmpX,CalcYPosValue(IMax - ISlope*(ValueIndex+1)),
                         CalcYPosValue(ISlope*(ValueIndex+1)),StartZ)
      else
         DoVertLine(tmpX,CalcYPosValue(IMax - ISlope*(ValueIndex+1)),
                         CalcYPosValue(ISlope*(ValueIndex+1)));
  end;

var t : Integer;
begin
  inherited;
  With ParentChart.Canvas do
  begin
    AssignVisiblePen(Self.Pen);

    Brush.Style := bsClear;
    BoundingPoints[0] := TeePoint(CalcXPosValue(-0.5),CalcYPosValue(IMax));
    BoundingPoints[1] := TeePoint(CalcXPosValue(Count-0.5), CalcYPosValue((IMax+IMin)*0.5));
    BoundingPoints[2] := TeePoint(BoundingPoints[1].x, CalcYPosValue((IMax-IMin)*0.5));
    BoundingPoints[3] := TeePoint(BoundingPoints[0].x, CalcYPosValue(0.0));

    if ParentChart.View3D then PolygonWithZ(BoundingPoints,StartZ)
                          else Polygon(BoundingPoints);

    if Self.LinesPen.Visible then
    begin
      AssignVisiblePen(Self.LinesPen);
      for t:=FirstValueIndex to LastValueIndex-1 do DrawVertLine(t);
    end;
  end;
end;

function TFunnelSeries.MinYValue: Double;
begin
  Result := 0;
end;

function TFunnelSeries.MaxXValue: Double;
begin
  Result := Count -0.5;
end;

function TFunnelSeries.MinXValue: Double;
begin
  Result := -0.5;
end;

procedure TFunnelSeries.SetDifferenceLimit(const Value: double);
begin
  if FDifferenceLimit<>Value then
  begin
    FDifferenceLimit := Value;
    if FAutoUpdate then Recalc;
    Repaint;
  end;
end;

procedure TFunnelSeries.SetAboveColor(const Value: TColor);
begin
  SetColorProperty(FAboveColor,Value);
end;

procedure TFunnelSeries.SetBelowColor(const Value: TColor);
begin
  SetColorProperty(FBelowColor,Value);
end;

procedure TFunnelSeries.SetWithinColor(const Value: TColor);
begin
  SetColorProperty(FWithinColor,Value);
end;

procedure TFunnelSeries.GetMarkText(Sender: TChartSeries;
  ValueIndex: Integer; var MarkText: String);
begin
  MarkText := FormatFloat(PercentFormat,
       100*FOpportunityValues.Value[ValueIndex]/QuoteValues.Value[ValueIndex]);
end;

procedure TFunnelSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  APosition.LeftTop := TeePoint(CalcXPosValue(ValueIndex)-APosition.Width div 2,
                             CalcYPosValue(IMax*0.5)-APosition.Height div 2);
  inherited;
end;

function TFunnelSeries.DefineFunnelRegion(ValueIndex: Integer): TColor;
var tmpX, tmpY : Integer;
begin
   { Calculate multiplying factor }

   if QuoteValues.Value[ValueIndex]=0 then
      IDiff:=0
   else
      IDiff := FOpportunityValues.Value[ValueIndex]/QuoteValues.Value[ValueIndex];


   { calculate bouding rectangle }
   BoundingPoints[0] := TeePoint(CalcXPosValue(ValueIndex-0.5),CalcYPosValue(IMax - ISlope*ValueIndex));
   BoundingPoints[1] := TeePoint(CalcXPosValue(ValueIndex+0.5),CalcYPosValue(IMax - ISlope*(ValueIndex+1)));
   BoundingPoints[2] := TeePoint(BoundingPoints[1].x,CalcYPosValue(ISlope*(ValueIndex+1)));
   BoundingPoints[3] := TeePoint(BoundingPoints[0].x,CalcYPosValue(ISlope*ValueIndex));

   tmpY := CalcYPosValue((IMax - 2*ISlope*ValueIndex)*IDiff+ISlope*ValueIndex); { Actual value, expressed in axis scale }

   if tmpY <= BoundingPoints[0].Y then { IDiff >= 1 }
   begin
        SetLength(IPolyPoints,4);
        IPolyPoints[0] := BoundingPoints[0];
        IPolyPoints[1] := BoundingPoints[1];
        IPolyPoints[2] := BoundingPoints[2];
        IPolyPoints[3] := BoundingPoints[3];
   end
   else if (tmpY > BoundingPoints[0].Y) and (tmpY <= BoundingPoints[1].Y) then
   begin
     SetLength(IPolyPoints,5);
     IPolyPoints[0] := TeePoint(BoundingPoints[0].x,tmpY);
     tmpX := CalcXPosValue((IMax - 2*ISlope*ValueIndex)*(1-IDiff)/ISlope + ValueIndex - 0.5);
     IPolyPoints[1] := TeePoint(tmpX,tmpY);
     IPolyPoints[2] := BoundingPoints[1];
     IPolyPoints[3] := BoundingPoints[2];
     IPolyPoints[4] := BoundingPoints[3];
   end
   else if tmpY > BoundingPoints[2].y then
   begin
     SetLength(IPolyPoints,3);
     IPolyPoints[0] := TeePoint(BoundingPoints[0].x,tmpY);
     tmpX := CalcXPosValue((IMax - 2*ISlope*ValueIndex)*IDiff /ISlope + ValueIndex-0.5);
     IPolyPoints[1] := TeePoint(tmpX,tmpY);
     IPolyPoints[2] := BoundingPoints[3];
   end
   else
   begin
     SetLength(IPolyPoints,4);
     IPolyPoints[0] := TeePoint(BoundingPoints[0].x, tmpY);
     IPolyPoints[1] := TeePoint(BoundingPoints[1].x, tmpY);
     IPolyPoints[2] := BoundingPoints[2];
     IPolyPoints[3] := BoundingPoints[3];
   end;

   if IDiff >= 1 then Result := FAboveColor
   else
   if (1-IDiff)*100 > FDifferenceLimit then
       Result := FBelowColor
   else
       Result := FWithinColor;
end;

function TFunnelSeries.Clicked(X, Y: Integer): Integer;
var t : Integer;
begin
  Result := inherited Clicked(X,Y);
  if (result=-1) and (FirstValueIndex>-1) and (LastValueIndex>-1) then
  for t := FirstValueIndex to LastValueIndex do
  begin
    DefineFunnelRegion(t);
    if PointInPolygon(TeePoint(X,Y),IPolyPoints) then
    begin
      Result := t;
      break;
    end
  end;
end;

procedure TFunnelSeries.AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False);
var t: Integer;
begin
  for t := 0 to NumValues - 1 do
      AddSegment(2.3*NumValues*(t+1),(2.3-RandomValue(2))*NumValues*(t+2),
                 TeeMsg_FunnelSegment+TeeStr(t+1),clTeeColor);
  Recalc;
end;

procedure TFunnelSeries.DoBeforeDrawChart;
begin
  inherited;
  if Visible and Assigned(GetVertAxis) then
     GetVertAxis.Visible:=False;
end;

function TFunnelSeries.CountLegendItems: Integer;
begin
  result:=3;
end;

function TFunnelSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  Case LegendIndex of
    0: result:=AboveColor;
    1: result:=WithinColor;
  else
    result:=BelowColor;
  end;
end;

function TFunnelSeries.LegendString(LegendIndex: Integer;
  LegendTextStyle: TLegendTextStyle): String;
begin
  Case LegendIndex of
    0: result:=TeeMsg_FunnelExceed;
    1: result:=FormatFloat(PercentFormat,DifferenceLimit)+ TeeMsg_FunnelWithin;
  else
    result:=FormatFloat(PercentFormat,DifferenceLimit)+ TeeMsg_FunnelBelow;
  end;
end;

class function TFunnelSeries.GetEditorClass: String;
begin
  result:='TFunnelSeriesEditor';
end;

procedure TFunnelSeries.SetLinesPen(const Value: TChartPen);
begin
  FLinesPen.Assign(Value);
end;

initialization
  RegisterTeeSeries(TFunnelSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunnelSeries,
                                   {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
finalization
  UnRegisterTeeSeries([TFunnelSeries]);
end.
