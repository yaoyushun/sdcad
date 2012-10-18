{**************************************************}
{   TCurveFittingFunction                          }
{   TTrendFunction                                 }
{   Copyright (c) 1995-2004 by David Berneda       }
{**************************************************}
unit CurvFitt;
{$I TeeDefs.inc}

interface

{ TCustomFittingFunction derives from standard TTeeFunction.

  TCurveFittingFunction and TTrendFunction both derive from
  TCustomFittingFunction.

  Based on a Polynomial degree value (# of polynomy items), a curve
  fitting is calculated for each X,Y pair value to determine the new
  Y position for each source X value.
}

Uses Classes, TeePoly, StatChar, TeEngine;

Type
  TTypeFitting=( cfPolynomial );

  TCustomFittingFunction=class(TTeeFunction)
  private
    FFactor         : Integer;
    FFirstPoint     : Integer;
    FFirstCalcPoint : Integer;
    FLastPoint      : Integer;
    FLastCalcPoint  : Integer;
    FPolyDegree     : Integer; { <-- between 1 and 20 }
    FTypeFitting    : TTypeFitting;

    { internal }
    IAnswerVector   : TDegreeVector;
    IMinYValue      : Double;

    Procedure SetFactor(const Value:Integer);
    Procedure SetFirstCalcPoint(Value:Integer);
    Procedure SetFirstPoint(Value:Integer);
    Procedure SetIntegerProperty(Var Variable:Integer; Value:Integer);
    Procedure SetLastCalcPoint(Value:Integer);
    Procedure SetLastPoint(Value:Integer);
    Procedure SetPolyDegree(Value:Integer);
    Procedure SetTypeFitting(Value:TTypeFitting);
  protected
    Function GetAnswerVector(Index:Integer):Double;
    procedure AddFittedPoints(Source:TChartSeries); virtual;
    property Factor:Integer read FFactor write SetFactor;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
    Function GetCurveYValue(Source:TChartSeries; Const X:Double):Double;

    // properties
    property AnswerVector[Index:Integer]:Double read GetAnswerVector;
    property FirstCalcPoint:Integer read FFirstCalcPoint write SetFirstCalcPoint default -1;
    property FirstPoint:Integer read FFirstPoint write SetFirstPoint default -1;
    property LastCalcPoint:Integer read FLastCalcPoint write SetLastCalcPoint default -1;
    property LastPoint:Integer read FLastPoint write SetLastPoint default -1;
    property PolyDegree:Integer read FPolyDegree write SetPolyDegree default 5;
    property TypeFitting:TTypeFitting read FTypeFitting write SetTypeFitting default cfPolynomial;
  end;

  TCurveFittingFunction=class(TCustomFittingFunction)
  published
    property Factor default 1;
    property FirstCalcPoint;
    property FirstPoint;
    property LastCalcPoint;
    property LastPoint;
    property PolyDegree;
    property TypeFitting;
  end;

  TTrendStyle=(tsNormal,tsLogarithmic,tsExponential);

  TCustomTrendFunction=class(TTeeFunction)
  private
    IStyle : TTrendStyle;
    ICount : Integer;
    SumX   : Double;
    SumXY  : Double;
    SumY   : Double;
    SumX2  : Double;
    SumY2  : Double;

    function CalculateValues(Source:TChartSeries; FirstIndex,LastIndex:Integer):Boolean;
  protected
    Procedure CalculatePeriod( Source:TChartSeries;
                               Const tmpX:Double;
                               FirstIndex,LastIndex:Integer); override;
    Procedure CalculateAllPoints( Source:TChartSeries;
                                  NotMandatorySource:TChartValueList); override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function Calculate(SourceSeries:TChartSeries; First,Last:Integer):Double; override;
    Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
    Function CalculateTrend( Var m,b:Double; Source:TChartSeries;
                             FirstIndex,LastIndex:Integer):Boolean; // 6.02
    Function Coefficient(Source:TChartSeries; FirstIndex,LastIndex:Integer):Double;
  end;

  TTrendFunction=class(TCustomTrendFunction);

  TExpTrendFunction=class(TCustomTrendFunction)
  public
    Constructor Create(AOwner: TComponent); override;
  end;

  TCorrelationFunction=class(TCustomTrendFunction)
  protected
    Procedure CalculatePeriod( Source:TChartSeries;
                               Const tmpX:Double;
                               FirstIndex,LastIndex:Integer); override;
  public
    Function Calculate(SourceSeries:TChartSeries; First,Last:Integer):Double; override;
    Function CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;  override;
  end;

implementation

Uses Math, SysUtils, TeeProCo, Chart, TeeProcs, TeeConst, TeCanvas;

{ TCurveFittingFunction }
Constructor TCustomFittingFunction.Create(AOwner: TComponent);
Begin
  inherited;
  CanUsePeriod:=False;
  InternalSetPeriod(1);
  FPolyDegree:=5;
  FTypeFitting:=cfPolynomial;
  FFirstPoint:=-1;
  FLastPoint:=-1;
  FFirstCalcPoint:=-1;
  FLastCalcPoint:=-1;
  FFactor:=1;
end;

Procedure TCustomFittingFunction.SetIntegerProperty(Var Variable:Integer; Value:Integer);
Begin
  if Variable<>Value then
  Begin
    Variable:=Value;
    Recalculate;
  end;
end;

Procedure TCustomFittingFunction.SetFirstPoint(Value:Integer);
Begin
  SetIntegerProperty(FFirstPoint,Value);
End;

Procedure TCustomFittingFunction.SetLastPoint(Value:Integer);
Begin
  SetIntegerProperty(FLastPoint,Value);
End;

Procedure TCustomFittingFunction.SetFactor(const Value:Integer);
begin
  SetIntegerProperty(FFactor,Math.Max(1,Value));
end;

Procedure TCustomFittingFunction.SetFirstCalcPoint(Value:Integer);
Begin
  SetIntegerProperty(FFirstCalcPoint,Value);
End;

Procedure TCustomFittingFunction.SetLastCalcPoint(Value:Integer);
Begin
  SetIntegerProperty(FLastCalcPoint,Value);
End;

Procedure TCustomFittingFunction.SetTypeFitting(Value:TTypeFitting);
Begin
  if FTypeFitting<>Value then
  Begin
    FTypeFitting:=Value;
    Recalculate;
  end;
end;

Procedure TCustomFittingFunction.SetPolyDegree(Value:Integer);
Begin
  if FPolyDegree<>Value then
  begin
    if (Value<1) or (Value>20) then
       Raise Exception.Create(TeeMsg_PolyDegreeRange);
    FPolyDegree:=Value;
    Recalculate;
  end;
end;

Function TCustomFittingFunction.GetAnswerVector(Index:Integer):Double;
Begin
  if (Index<1) or (Index>FPolyDegree) then
     Raise Exception.CreateFmt(TeeMsg_AnswerVectorIndex,[FPolyDegree]);
  result:=IAnswerVector[Index];
End;

procedure TCustomFittingFunction.AddFittedPoints(Source:TChartSeries);
Var tmpX         : Double;
    tmpX2        : Double;
    tmpMinXValue : Double;
    tmpStep      : Double;
    t            : Integer;
    tt           : Integer;
    tmpStart     : Integer;
    tmpEnd       : Integer;
begin
  IMinYValue:=ValueList(Source).MinValue;

  With Source do
  begin
    tmpMinXValue:=XValues.MinValue;
    if FFirstPoint=-1 then tmpStart:=0
                      else tmpStart:=FFirstPoint;
    if FLastPoint=-1 then tmpEnd:=Count-1
                     else tmpEnd:=FLastPoint;

    FFactor:=Math.Max(1,Factor);

    for t:=tmpStart to tmpEnd-1 do  { 1 to 1 relationship between source and self }
    begin
      tmpX:=XValues.Value[t];

      tmpStep:=(XValues.Value[t+1]-tmpX)/Factor;

      for tt:=0 to Factor-1 do
      begin
        tmpX2:=tmpX+tmpStep*tt;
        ParentSeries.AddXY( tmpX2, CalcFitting( FPolyDegree,
                                             IAnswerVector,
                                             tmpX2-tmpMinXValue)+IMinYValue);
      end;
    end;

    tmpX2:=XValues.Value[tmpEnd];
    ParentSeries.AddXY( tmpX2, CalcFitting( FPolyDegree,
                                            IAnswerVector,
                                            tmpX2-tmpMinXValue)+IMinYValue);
  end;
end;

procedure TCustomFittingFunction.AddPoints(Source:TChartSeries);
var t            : Integer;
    tmpStart     : Integer;
    tmpEnd       : Integer;
    tmpCount     : Integer;
    tmpPos       : Integer;
    IXVector     : TVector;
    IYVector     : TVector;
    tmpMinXValue : Double;
    AList        : TChartValueList;
Begin
  ParentSeries.Clear;
  With Source do
  if Count>=FPolyDegree then
  begin
    AList:=ValueList(Source);

    tmpMinXValue:=XValues.MinValue;
    IMinYValue:=AList.MinValue;
    if FFirstCalcPoint=-1 then tmpStart:=0
                          else tmpStart:=Math.Max(0,FFirstCalcPoint);
    if FLastCalcPoint=-1 then tmpEnd:=Count-1
                         else tmpEnd:=Math.Min(Count-1,FLastCalcPoint);

    tmpCount:=(tmpEnd-tmpStart+1);
    if tmpCount>0 then
    begin
      SetLength(IXVector,tmpCount+1);
      SetLength(IYVector,tmpCount+1);
      try
        for t:=1 to tmpCount do
        begin
          tmpPos:=t+tmpStart-1;
          IXVector[t]:=XValues.Value[tmpPos]-tmpMinXValue;
          IYVector[t]:=AList.Value[tmpPos]-IMinYValue;
        end;

        PolyFitting(tmpCount,FPolyDegree,IXVector,IYVector,IAnswerVector);
        AddFittedPoints(Source);
      finally
        IYVector:=nil;
        IXVector:=nil;
      end;
    end;
  end;
end;

{ calculates and returns the Y value corresponding to a X value }
Function TCustomFittingFunction.GetCurveYValue(Source:TChartSeries; Const X:Double):Double;
Begin
  result:=CalcFitting(FPolyDegree,IAnswerVector,X-Source.XValues.MinValue)+IMinYValue;
end;

{ TCustomTrendFunction }
constructor TCustomTrendFunction.Create(AOwner: TComponent);
begin
  inherited;
  IStyle:=tsNormal;
end;

Function TCustomTrendFunction.Calculate(SourceSeries:TChartSeries; First,Last:Integer):Double;
begin
  result:=0;
end;

Function TCustomTrendFunction.CalculateMany(SourceSeriesList:TList; ValueIndex:Integer):Double;
begin
  result:=0;
end;

Procedure TCustomTrendFunction.CalculateAllPoints( Source:TChartSeries;
                                             NotMandatorySource:TChartValueList);
begin
  CalculatePeriod(Source,0,0,Source.Count-1);
end;

Procedure TCustomTrendFunction.CalculatePeriod( Source:TChartSeries;
                                          Const tmpX:Double;
                                          FirstIndex,LastIndex:Integer);
Var m : Double;
    b : Double;

  Procedure AddPoint(Const Value:Double);
  var tmp : Double;
  begin
    Case IStyle of
      tsNormal     : tmp:=m*Value+b;
      tsLogarithmic: tmp:=m*Ln(Value*b);
    else
       tmp:=m*Exp(b*Value);
    end;

    if Source.YMandatory then ParentSeries.AddXY(Value, tmp)
                         else ParentSeries.AddXY(tmp, Value)
  end;

begin
  if CalculateTrend(m,b,Source,FirstIndex,LastIndex) then
  With Source.NotMandatoryValueList do
  begin
    if Order=loNone then
    begin
      AddPoint(MinValue);
      AddPoint(MaxValue);
    end
    else
    begin
      AddPoint(Value[FirstIndex]);
      AddPoint(Value[LastIndex]);
    end;
  end;
end;

Function TCustomTrendFunction.CalculateValues(Source:TChartSeries; FirstIndex,LastIndex:Integer):Boolean;
var tmpAll : Boolean;
    t      : Integer;
    x      : TChartValue;
    y      : TChartValue;
begin
  if FirstIndex=TeeAllValues then
  begin
    FirstIndex:=0;
    LastIndex:=Source.Count-1;
  end;

  ICount:=LastIndex-FirstIndex+1;

  result:=ICount>1;

  if result then
  With Source do
  begin
    tmpAll:=(IStyle=tsNormal) and (ICount=Count);

    if tmpAll then
    begin
      SumX:=NotMandatoryValueList.Total;
      SumY:=ValueList(Source).Total;
    end
    else
    begin
      SumX:=0;
      SumY:=0;
    end;

    SumX2:=0;
    SumY2:=0;
    SumXY:=0;

    With ValueList(Source) do
    for t:=FirstIndex to LastIndex do
    begin
      x:=NotMandatoryValueList.Value[t];
      if IStyle=tsNormal then y:=Value[t]
                         else
                         if Value[t]<>0 then y:=Ln(Value[t])
                                        else y:=0;

      SumXY:=SumXY+x*y;
      SumX2:=SumX2+Sqr(x);
      SumY2:=SumY2+Sqr(y);

      if not tmpAll then
      begin
        SumX:=SumX+x;
        SumY:=SumY+y;
      end;
    end;
  end;
end;

Function TCustomTrendFunction.Coefficient(Source:TChartSeries; FirstIndex,LastIndex:Integer):Double;
var tmpNumerator   : Double;
    tmpDenominator : Double;
begin
  if CalculateValues(Source,FirstIndex,LastIndex) then
  begin
    tmpNumerator:=SumXY - SumX*SumY/ICount;
    tmpDenominator:=Sqrt( (SumX2 - SumX*SumX/ICount) * (SumY2 - SumY*SumY/ICount) );
    if tmpDenominator=0 then
       result:=1
    else
       result:=tmpNumerator/tmpDenominator;
  end
  else result:=1;
end;

Function TCustomTrendFunction.CalculateTrend(Var m,b:Double; Source:TChartSeries; FirstIndex,LastIndex:Integer):Boolean;
var Divisor : Double;
begin
  result:=CalculateValues(Source,FirstIndex,LastIndex);

  if result then
    if IStyle=tsNormal then
    begin
      Divisor:=ICount*SumX2-Sqr(SumX);

      if Divisor<>0 then
      begin
        m:=( (ICount*SumXY) - (SumX*SumY) ) / Divisor;
        b:=( (SumY*SumX2) - (SumX*SumXY) ) / Divisor;
      end
      else
      begin
        m:=1;
        b:=0;
      end;
    end
    else
    begin
      SumX:=SumX/ICount;
      SumY:=SumY/ICount;

      Divisor:= (SumX2-(ICount*SumX*SumX));

      if Divisor=0 then b:=1
                   else b:=(SumXY-(ICount*SumX*SumY))/Divisor;

      if IStyle=tsLogarithmic then m:=SumY-b*SumX
                              else m:=Exp(SumY-b*SumX);
    end;
end;

{ TExpTrendFunction }
constructor TExpTrendFunction.Create(AOwner: TComponent);
begin
  inherited;
  IStyle:=tsExponential;
end;

{ TCorrelationFunction }

function TCorrelationFunction.Calculate(SourceSeries: TChartSeries; First,
  Last: Integer): Double;
begin
  result:=Coefficient(SourceSeries,First,Last);
end;

function TCorrelationFunction.CalculateMany(SourceSeriesList: TList;
  ValueIndex: Integer): Double;
begin
  result:=0;
end;

procedure TCorrelationFunction.CalculatePeriod(Source: TChartSeries;
  const tmpX: Double; FirstIndex, LastIndex: Integer);

  procedure AddPoint(const x,y:Double);
  begin
    with ParentSeries do
    if YMandatory then ParentSeries.AddXY(x,y)
                  else ParentSeries.AddXY(y,x);
  end;

var tmp : Double;
begin
  tmp:=Calculate(Source,FirstIndex,LastIndex);
  if ParentSeries.AllowSinglePoint then
     ParentSeries.Add(tmp)
  else
  begin
    AddPoint(Source.NotMandatoryValueList.MinValue,tmp);
    AddPoint(Source.NotMandatoryValueList.MaxValue,tmp);
  end;
end;

initialization
  RegisterTeeFunction( TCurveFittingFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCurveFitting,
                                              {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TTrendFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionTrend,
                                       {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TExpTrendFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionExpTrend,
                                          {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
  RegisterTeeFunction( TCorrelationFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCorrelation,
                                             {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
finalization
  UnRegisterTeeFunctions([ TCurveFittingFunction, TTrendFunction,
                           TExpTrendFunction, TCorrelationFunction ]);
end.
