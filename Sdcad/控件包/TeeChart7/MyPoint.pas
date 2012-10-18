{**********************************************}
{   TMyPointSeries                             }
{   TBarJoinSeries                             }
{   Copyright (c) 1997-2004 by David Berneda   }
{**********************************************}
unit MyPoint;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, Series, TeCanvas;

{ This sample Series derives from TPointSeries.
  It shows how to override the DrawValue method, which is called
  every time every point in the Series should be displayed.

  In this sample, one horizontal line and one vertical line are
  drawn from the axis to every point.
  A new TPen property is published to control the lines attributes.
}

type TMyPointSeries=class(TPointSeries)
     private
       FLinesPen : TChartPen;
       procedure SetLinesPen(Value:TChartPen);
     protected
       procedure DrawValue(ValueIndex:Integer); override;
       class Function GetEditorClass:String; override;
     public
       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;
       Procedure Assign(Source:TPersistent); override;
     published
       property LinesPen:TChartPen read FLinesPen write SetLinesPen;
     end;

     TBarJoinSeries=class(TBarSeries)
     private
       FJoinPen: TChartPen;

       OldBarBounds : TRect;
       IFirstPoint  : Boolean;
       procedure SetJoinPen(const Value: TChartPen);
     protected
       procedure DoBeforeDrawChart; override;
       class Function GetEditorClass:String; override;
       Procedure PrepareForGallery(IsEnabled:Boolean); override;
     public
       Constructor Create(AOwner: TComponent); override;
       Destructor Destroy; override;

       Procedure Assign(Source:TPersistent); override;
       Procedure DrawBar(BarIndex,StartPos,EndPos:Integer); override;
       Function NumSampleValues:Integer; override;
     published
       property JoinPen:TChartPen read FJoinPen write SetJoinPen;
     end;

implementation

Uses TeeProCo;

{ overrided constructor to change default pointer style and 3D }
Constructor TMyPointSeries.Create(AOwner:TComponent);
begin
  inherited;
  Pointer.Draw3D:=False;
  Pointer.Style:=psDiamond;
  FLinesPen:=CreateChartPen;  { <-- create new pen property }
  FLinesPen.Color:=clRed;     { <-- set default color to Red }
end;

Destructor TMyPointSeries.Destroy;
begin
  FLinesPen.Free;
  inherited;
end;

procedure TMyPointSeries.Assign(Source: TPersistent);
begin
  if Source is TMyPointSeries then LinesPen:=TMyPointSeries(Source).LinesPen;
  inherited;
end;

{ overrided DrawValue to draw additional lines for each point }
procedure TMyPointSeries.DrawValue(ValueIndex:Integer);
var tmpX : Integer;
    tmpY : Integer;
begin
  { calculate the point position }
  tmpX:=CalcXPos(ValueIndex);
  tmpY:=CalcYPos(ValueIndex);

  With ParentChart,Canvas do
  begin
    { change brush and pen attributes }
    Brush.Style:=bsClear;
    BackMode:=cbmTransparent;
    AssignVisiblePen(FLinesPen);

    { draw the horizontal and vertical lines }
    MoveTo3D(GetVertAxis.PosAxis,tmpY,StartZ);
    LineTo3D(tmpX,tmpY,StartZ);
    LineTo3D(tmpX,GetHorizAxis.PosAxis,StartZ);
  end;
  inherited;  { <-- draw the point }
end;

procedure TMyPointSeries.SetLinesPen(Value:TChartPen);
begin
  FLinesPen.Assign(Value);
end;

class function TMyPointSeries.GetEditorClass: String;
begin
  result:='TLinePointEditor';
end;

{ TBarJoinSeries }
Constructor TBarJoinSeries.Create(AOwner: TComponent);
begin
  inherited;
  FJoinPen:=CreateChartPen;
end;

Destructor TBarJoinSeries.Destroy;
begin
  FJoinPen.Free;
  inherited;
end;

procedure TBarJoinSeries.Assign(Source: TPersistent);
begin
  if Source is TBarJoinSeries then
     JoinPen:=TBarJoinSeries(Source).JoinPen;
  inherited;
end;

procedure TBarJoinSeries.DoBeforeDrawChart;
begin
  inherited;
  IFirstPoint:=True;
end;

procedure TBarJoinSeries.DrawBar(BarIndex, StartPos, EndPos: Integer);
var tmpA : Integer;
    tmpB : Integer;
    tmpTopA : Integer;
    tmpTopB : Integer;
begin
  inherited;

  if not IFirstPoint then
  begin
    Case BarStyle of
      bsPyramid,bsEllipse,bsArrow,bsCone:
      begin
        tmpA:=(OldBarBounds.Left+OldBarBounds.Right) div 2;
        tmpB:=(BarBounds.Left+BarBounds.Right) div 2;
      end;
    else
    begin
      tmpA:=OldBarBounds.Right;
      tmpB:=BarBounds.Left;
    end;
    end;

    tmpTopA:=OldBarBounds.Top;
    tmpTopB:=BarBounds.Top;

    if not DrawValuesForward then
    begin
      tmpA:=BarBounds.Right;
      tmpB:=OldBarBounds.Left;
      SwapInteger(tmpTopA,tmpTopB);
    end;

    With ParentChart,Canvas do
    begin
      AssignVisiblePen(FJoinPen);
      if View3D then
      begin
        MoveTo3D(tmpA,tmpTopA,MiddleZ);
        LineTo3D(tmpB,tmpTopB,MiddleZ);
      end
      else
      begin
        MoveTo(tmpA,tmpTopA);
        LineTo(tmpB,tmpTopB);
      end;
    end;
  end;

  IFirstPoint:=False;
  OldBarBounds:=BarBounds;
end;

procedure TBarJoinSeries.SetJoinPen(const Value: TChartPen);
begin
  FJoinPen.Assign(Value);
end;

function TBarJoinSeries.NumSampleValues: Integer;
begin
  result:=3;
end;

procedure TBarJoinSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  FJoinPen.Color:=clBlue;
  FJoinPen.Width:=2;
  FillSampleValues(2);
end;

class function TBarJoinSeries.GetEditorClass: String;
begin
  result:='TBarJoinEditor';
end;

initialization
  RegisterTeeSeries( TMyPointSeries,
    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryLinePoint,
    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1);
  RegisterTeeSeries( TBarJoinSeries,
    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBarJoin,
    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1);
finalization
  UnRegisterTeeSeries([TMyPointSeries,TBarJoinSeries]);
end.
