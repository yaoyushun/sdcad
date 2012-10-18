{**********************************************}
{   TDonutSeries                               }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeDonut;
{$I TeeDefs.inc}

interface

Uses {$IFDEF CLR}
     Classes,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$ENDIF}
     TeEngine, Chart, TeCanvas, Series;

{  TDonutSeries ->  Pie Series with a hole in the center. }

Const TeeDefaultDonutPercent = 50;

Type
  TDonutSeries=class(TPieSeries)
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source: TPersistent); override; { 5.02 }
  published
    property DonutPercent default TeeDefaultDonutPercent;
  end;

implementation

Uses TeeConst, TeeProCo;

{ TDonutSeries }
Constructor TDonutSeries.Create(AOwner: TComponent);
begin
  inherited;
  SetDonutPercent(TeeDefaultDonutPercent);
end;

procedure TDonutSeries.Assign(Source: TPersistent);
begin
  if Source is TDonutSeries then
  With TDonutSeries(Source) do
  begin
    Self.DonutPercent:=DonutPercent; { 5.02 }
  end;

  inherited;

  if Self.DonutPercent<=0 then
     SetDonutPercent(TeeDefaultDonutPercent);
end;

class Function TDonutSeries.GetEditorClass:String;
begin
  result:='TDonutSeriesEditor';
end;

initialization
  RegisterTeeSeries(TDonutSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryDonut,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,1);
finalization
  UnRegisterTeeSeries([TDonutSeries]);
end.
