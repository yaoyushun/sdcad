{**********************************************}
{   TBar3DSeries Component                     }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit Bar3D;
{$I TeeDefs.inc}

{ This Series component is derived from TBarSeries.
  It has a new property:  OffsetValues

  This new property allows to specify a different ORIGIN value
  for EACH bar point.
  This can be used with standard TBarSeries components to
  make a "Stacked-3D" chart type.
}
interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs,
     {$ENDIF}
     TeEngine, Series;

type
  TBar3DSeries = class(TBarSeries)
  private
    { Private declarations }
    FOffsetValues : TChartValueList;
  protected
    { Protected declarations }
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure SetOffsetValues(Value:TChartValueList);
    class Function SubGalleryStack:Boolean; override; { 5.01 }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Function AddBar( Const AX,AY,AOffset:Double;
                     Const AXLabel:String='';
                     AColor:TColor=clTeeColor):Integer;
    Function GetOriginValue(ValueIndex:Integer):Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function PointOrigin(ValueIndex:Integer; SumAll:Boolean):Double; override;
  published
    { Published declarations }
    property OffsetValues:TChartValueList read FOffsetValues
                                          write SetOffsetValues;
  end;

implementation

Uses {$IFDEF CLR}
     {$ELSE}
     Math,
     {$ENDIF}
     Chart, TeeProcs, TeCanvas, TeeProCo;

{ TBar3DSeries }
Constructor TBar3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  FOffsetValues:=TChartValueList.Create(Self,TeeMsg_ValuesOffset); { <-- "offset" storage }
end;

Procedure TBar3DSeries.SetOffsetValues(Value:TChartValueList);
begin
  SetChartValueList(FOffsetValues,Value); { standard method }
end;

{ calculate maximum Y value }
Function TBar3DSeries.MaxYValue:Double;
begin
  result:=inherited MaxYValue;
  if (MultiBar=mbNone) or (MultiBar=mbSide) then
     result:=Math.Max(result,FOffsetValues.MaxValue);
end;

{ calculate minimum Y value ( YValues and negative Offsets supported ) }
Function TBar3DSeries.MinYValue:Double;
var t : Integer;
begin
  result:=inherited MinYValue;
  if (MultiBar=mbNone) or (MultiBar=mbSide) then
     for t:=0 to Count-1 do
         if FOffsetValues.Value[t]<0 then
            result:=Math.Min(result,YValues.Value[t]+FOffsetValues.Value[t]);
end;

Function TBar3DSeries.AddBar( Const AX,AY,AOffset:Double;
                              Const AXLabel:String='';
                              AColor:TColor=clTeeColor):Integer;
begin
  FOffsetValues.TempValue:=AOffset;
  result:=AddXY(AX,AY,AXLabel,AColor);
//  AddValue(result);
end;

Procedure TBar3DSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var t : Integer;
    s : TSeriesRandomBounds;
Begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do { some sample values to see something in design mode }
  Begin
    tmpY:=RandomValue(Round(DifY));
    AddBar( tmpX,
            10+Abs(tmpY),
            Abs(DifY/(1+RandomValue(5))));
    tmpX:=tmpX+StepX;
  end;
end;

{ this overrides default bottom origin calculation }
Function TBar3DSeries.PointOrigin(ValueIndex:Integer; SumAll:Boolean):Double;
begin
  result:=FOffsetValues.Value[ValueIndex];
end;

{ this makes this bar heigth to be: "offset" + "height" }
Function TBar3DSeries.GetOriginValue(ValueIndex:Integer):Double;
begin
  result:=inherited GetOriginValue(ValueIndex)+FOffsetValues.Value[ValueIndex];
end;

class function TBar3DSeries.SubGalleryStack: Boolean;
begin
  result:=False; { 5.01 } { Do not show stacked styles at sub-gallery }
end;

// Register the Series at Chart gallery
initialization
  RegisterTeeSeries( TBar3DSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBar3D,
                                   {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([TBar3DSeries]);
end.
