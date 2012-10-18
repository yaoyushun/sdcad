{**********************************************}
{   TBigCandleSeries (TCandleSeries)           }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit BigCandl;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs,
     {$ENDIF}
     {$ENDIF}
     TeEngine, Series, OHLChart, CandleCh;

type
  TBigCandleSeries = class(TCandleSeries)
  private
    { Private declarations }
    FHorizGap : Integer;
    FVertGap  : Integer;
  protected
    { Protected declarations }
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure SetHorizGap(Value:Integer);
    Procedure SetVertGap(Value:Integer);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property HorizGap:Integer read FHorizGap write SetHorizGap;
    property VertGap:Integer read FVertGap write SetVertGap;
  end;

implementation

Uses {$IFDEF CLR}
     SysUtils,
     {$ENDIF}
     Chart, TeCanvas, TeeProCo;

{ TBigCandleSeries }
Constructor TBigCandleSeries.Create(AOwner: TComponent);
begin
  inherited;
  FHorizGap:=20;
  FVertGap:=6;
  Marks.Visible:=True;
  Marks.Callout.Length:=0;
end;

Procedure TBigCandleSeries.SetHorizGap(Value:Integer);
begin
  SetIntegerProperty(FHorizGap,Value);
end;

Procedure TBigCandleSeries.SetVertGap(Value:Integer);
begin
  SetIntegerProperty(FVertGap,Value);
end;

Procedure TBigCandleSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                     APosition:TSeriesMarkPosition);

  Procedure InternalDrawMark(Const AValue:Double);
  begin
    inherited DrawMark(ValueIndex,FormatFloat(ValueFormat,AValue),APosition);
  end;

Var tmpX           : Integer;
    tmpHorizOffset : Integer;
    tmpVertOffset  : Integer;
begin
  With APosition do
  begin
    tmpHorizOffset:=(Width div 2)+ FHorizGap ;  { <-- custom horiz "gap" }
    tmpVertOffset :=Height + FVertGap;       { <-- custom vert "gap" }

    tmpX:=LeftTop.X;

    { Open Price Mark }
    With LeftTop do
    begin
      Y:=CalcYPosValue(OpenValues.Value[ValueIndex])-(Height div 2);
      X:=tmpX-tmpHorizOffset;
    end;
    InternalDrawMark(OpenValues.Value[ValueIndex]);

    { Close Price Mark }
    With LeftTop do
    begin
      Y:=CalcYPosValue(CloseValues.Value[ValueIndex])-(Height div 2);
      X:=tmpX+tmpHorizOffset;
    end;
    InternalDrawMark(CloseValues.Value[ValueIndex]);

    { High Price Mark }
    LeftTop.Y:=CalcYPosValue(HighValues.Value[ValueIndex])-tmpVertOffset;
    InternalDrawMark(HighValues.Value[ValueIndex]);

    { Low Price Mark }
    LeftTop.Y:=CalcYPosValue(LowValues.Value[ValueIndex])+tmpVertOffset-Height;
    InternalDrawMark(LowValues.Value[ValueIndex]);
  end;
end;

initialization
  RegisterTeeSeries( TBigCandleSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBigCandle,
                                       {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([TBigCandleSeries]);
end.
