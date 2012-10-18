{**********************************************}
{   TCumulative Function Component             }
{   Copyright (c) 1997-2004 by David Berneda   }
{**********************************************}
unit TeeCumu;
{$I TeeDefs.inc}

interface

{ The TCumulative function sums the Series values
  starting from the first point.

  Example:

  Given these values               :  1 2 3

  The TCumulative function returns :  1 3 6  ( 1=1, 1+2=3 and 1+2+3=6 )
}

uses {$IFDEF CLR}
     Classes,
     {$ELSE}
     Classes,
     {$ENDIF}
     TeEngine, Chart;

type
  TCumulative = class(TTeeFunction)
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Function Calculate(Series:TChartSeries; First,Last:Integer):Double; override;
    Function CalculateMany(SeriesList:TList; ValueIndex:Integer):Double;  override;
  published
    { Published declarations }
    property Period;
  end;

implementation

Uses TeeProCo, TeeConst;

{ TCumulative }
Constructor TCumulative.Create(AOwner: TComponent);
Begin
  inherited;
  InternalSetPeriod(1);
end;

Function TCumulative.Calculate(Series:TChartSeries; First,Last:Integer):Double;
begin
  if First>0 then result:=ParentSeries.MandatoryValueList.Last
             else result:=0;
  if First>=0 then
     result:=result+ValueList(Series).Value[First];
end;

{ Returns the sum( ) of the current ValueIndex point of all Series PLUS the
  accumulated calculation of the previous ValueIndex point.
}
Function TCumulative.CalculateMany(SeriesList:TList; ValueIndex:Integer):Double;
var t       : Integer;
    tmpList : TChartValueList;
begin
  if ValueIndex=0 then result:=0
                  else result:=ParentSeries.MandatoryValueList.Value[ValueIndex-1];
  for t:=0 to SeriesList.Count-1 do
  begin
    tmpList:=ValueList(TChartSeries(SeriesList[t]));
    if tmpList.Count>ValueIndex then result:=result+tmpList.Value[ValueIndex];
  end;
end;

initialization
  RegisterTeeFunction( TCumulative, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCumulative,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended, 2 );
finalization
  UnRegisterTeeFunctions([TCumulative]);
end.
