{**********************************************}
{   TOHLCSeries (derived from TCustomSeries)   }
{   Copyright (c) 1995-2004 by David Berneda   }
{**********************************************}
unit OHLChart;
{$I TeeDefs.inc}

interface

Uses {$IFDEF CLR}
     Borland.VCL.Classes,
     {$ELSE}
     Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$ENDIF}
     Chart, Series, TeEngine;

{ WARNING:
  NOTE FOR TeeChart Pro users since version 4.

  The logic in OHLC series has been changed.
  Now the default "Y" values correspond to the Close values,
  before they were referred to Open values.
  This change should be transparent to your code unless you're
  accessing directly the "Y" values.
}

{ Used in financial applications, OHLC stands for Open,High,Low & Close.
  These are the prices a particular financial product has in a given time
  period.

  TOHLCSeries extends the basic TCustomSeries adding new lists for
  High, Low & Open prices, and preserving the default Y values for Close
  prices.

  Overrides the basic list functions (Add, Clear & Delete) plus the
  FillSampleValues method, used in design mode to show some fictional
  values to the user.

  Publishes the High, Low & Open values lists and "overrides" the XValues
  property to be DateValues and the YValues to be CloseValues.
}

type
  TOHLCSeries=class(TCustomSeries)
  private { assumed YValues = CloseValues }
    FHighValues  : TChartValueList;
    FLowValues   : TChartValueList;
    FOpenValues  : TChartValueList;
    Function GetCloseValues:TChartValueList;
    Function GetDateValues:TChartValueList;
    Procedure SetCloseValues(Value:TChartValueList);
    Procedure SetDateValues(Value:TChartValueList);
    Procedure SetHighValues(Value:TChartValueList);
    Procedure SetLowValues(Value:TChartValueList);
    Procedure SetOpenValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function AddOHLC( Const ADate:TDateTime;
                      Const AOpen,AHigh,ALow,AClose:Double):Integer; overload;
    Function AddOHLC(Const AOpen,AHigh,ALow,AClose:Double):Integer; overload;

    // returns random values for Open,Close,High and Low prices. Used for demos
    class Procedure GetRandomOHLC(AOpen:Double; Var AClose,AHigh,ALow:Double; Const YRange:Double);

    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function NumSampleValues:Integer; override;
  published
    property CloseValues:TChartValueList read GetCloseValues write SetCloseValues;
    property DateValues:TChartValueList read GetDateValues write SetDateValues;
    property HighValues:TChartValueList read FHighValues write SetHighValues;
    property LowValues:TChartValueList read FLowValues write SetLowValues;
    property OpenValues:TChartValueList read FOpenValues write SetOpenValues;
  end;

implementation

Uses {$IFDEF CLR}
     {$ELSE}
     Math, SysUtils,
     {$ENDIF}
     TeCanvas, TeeProCo;

type TValueListAccess=class(TChartValueList);

{ TOHLCSeries }
Constructor TOHLCSeries.Create(AOwner: TComponent);
Begin
  inherited;

  TValueListAccess(XValues).InitDateTime(True);
  XValues.Name:=TeeMsg_ValuesDate;
  YValues.Name:=TeeMsg_ValuesClose;

  FHighValues :=TChartValueList.Create(Self,TeeMsg_ValuesHigh);
  FLowValues  :=TChartValueList.Create(Self,TeeMsg_ValuesLow);
  FOpenValues :=TChartValueList.Create(Self,TeeMsg_ValuesOpen);
end;

Function TOHLCSeries.GetDateValues:TChartValueList;
Begin
  result:=XValues; { overrides default XValues }
end;

Procedure TOHLCSeries.SetDateValues(Value:TChartValueList);
begin
  SetXValues(Value); { overrides default XValues }
end;

Function TOHLCSeries.GetCloseValues:TChartValueList;
Begin
  result:=YValues; { overrides default YValues }
end;

Procedure TOHLCSeries.SetCloseValues(Value:TChartValueList);
begin
  SetYValues(Value); { overrides default YValues }
end;

Procedure TOHLCSeries.SetHighValues(Value:TChartValueList);
Begin
  SetChartValueList(FHighValues,Value);
end;

Procedure TOHLCSeries.SetLowValues(Value:TChartValueList);
Begin
  SetChartValueList(FLowValues,Value);
end;

Procedure TOHLCSeries.SetOpenValues(Value:TChartValueList);
Begin
  SetChartValueList(FOpenValues,Value);
end;

Function TOHLCSeries.AddOHLC( Const ADate:TDateTime;
                              Const AOpen,AHigh,ALow,AClose:Double):Integer;
Begin
  HighValues.TempValue:=AHigh;
  LowValues.TempValue:=ALow;
  OpenValues.TempValue:=AOpen;
  result:=AddXY(ADate,AClose);
end;

Function TOHLCSeries.AddOHLC(Const AOpen,AHigh,ALow,AClose:Double):Integer;
begin
  DateValues.DateTime:=False;
  HighValues.TempValue:=AHigh;
  LowValues.TempValue:=ALow;
  OpenValues.TempValue:=AOpen;
  result:=Add(AClose);
end;

Function TOHLCSeries.MaxYValue:Double;
Begin
  result:=Math.Max(CloseValues.MaxValue,HighValues.MaxValue);
  result:=Math.Max(result,LowValues.MaxValue);
  result:=Math.Max(result,OpenValues.MaxValue);
End;

Function TOHLCSeries.MinYValue:Double;
Begin
  result:=Math.Min(CloseValues.MinValue,HighValues.MinValue);
  result:=Math.Min(result,LowValues.MinValue);
  result:=Math.Min(result,OpenValues.MinValue);
End;

// Returns random OHLC values
class Procedure TOHLCSeries.GetRandomOHLC(AOpen:Double; Var AClose,AHigh,ALow:Double; Const YRange:Double);
var tmpY     : Integer;
    tmpFixed : Double;
Begin
  tmpY:=Abs(Round(YRange/400.0));
  AClose:=AOpen+RandomValue(Round(YRange/25.0))-(YRange/50.0); { imagine a close price... }

  { and imagine the high and low session price }
  tmpFixed:=3*Round(Abs(AClose-AOpen)/10.0);
  if AClose>AOpen then
  Begin
    AHigh:=AClose+tmpFixed+RandomValue(tmpY);
    ALow:=AOpen-tmpFixed-RandomValue(tmpY);
  end
  else
  begin
    AHigh:=AOpen+tmpFixed+RandomValue(tmpY);
    ALow:=AClose-tmpFixed-RandomValue(tmpY);
  end;
end;

Procedure TOHLCSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var AOpen  : Double;
    AHigh  : Double;
    ALow   : Double;
    AClose : Double;
    t      : Integer;
    s      : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  begin
    AOpen:=MinY+RandomValue(Round(DifY)); { starting open price }

    for t:=1 to NumValues do
    Begin
      // Generate random figures
      GetRandomOHLC(AOpen,AClose,AHigh,ALow,DifY);

      // call the standard add method
      AddOHLC(tmpX,AOpen,AHigh,ALow,AClose);
      tmpX:=tmpX+StepX;  { <-- next point X value }

      // Tomorrow, the market will open at today's close plus/minus something }
      AOpen:=AClose+RandomValue(10)-5;
    end;
  end;
end;

Function TOHLCSeries.NumSampleValues:Integer;
begin
  result:=40;
end;

Function TOHLCSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TOHLCSeries;
end;

end.
