{******************************************}
{    TeeChart Pro ScrollBar component      }
{ Copyright (c) 1997-2004 by David Berneda }
{         All Rights Reserved              }
{******************************************}
unit TeeScroB;
{$I TeeDefs.inc}

interface

{ This unit implements the TChartScrollBar component.
  This is a specialized TScrollBar component to scroll Series points.

  Note: Do not modify the "Min" and "Max" properties of the ScrollBar,
        because they are overriden and calculated internally.

        Use the Axis Minimum and Maximum properties to change the ScrollBar
        position.
}

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QControls, QStdCtrls, QForms,
     {$ELSE}
     Controls, StdCtrls, Forms,
     {$ENDIF}
     TeEngine, Chart;

Const TeeMaxScrollPos=30000;

type
  { Depending if the ScrollBar is Horizontal or Vertical:

    sbDefault: means Left or Bottom axis
    sbOther  : means Right or Top axis
    sbBoth   : (default) means Left and Bottom , or Right and Top axis

  }
  TScrollBarAxis=(sbDefault,sbOther,sbBoth);

  TChartScrollBar = class(TScrollBar)
  private
    { Private declarations }
    FAxis          : TScrollBarAxis;
    FChart         : TCustomChart;
    FInverted      : Boolean;
    FOldOnPageChange:TNotifyEvent;
    FOldOnScroll   : TNotifyEvent;
    FOldOnZoom     : TNotifyEvent;
    FOldOnUndoZoom : TNotifyEvent;
    FPageSize      : Integer;
    procedure SetPageSize(Value:Integer);
    Procedure SetChart(Value:TCustomChart);
    Procedure SetInverted(Value:Boolean);
    Procedure ChartOnPageChange(Sender:TObject);
    Procedure ChartOnScroll(Sender:TObject);
    Procedure ChartOnZoom(Sender:TObject);
    Procedure ChartOnUndoZoom(Sender:TObject);
    Procedure CalcTotals(Axis:TChartAxis; Var AMin,AMax:Double);
  protected
    { Protected declarations }
    Function AssociatedSeries(Axis:TChartAxis):Integer;
    procedure Change; override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    Procedure RecalcPosition;
  published
    { Published declarations }
    property Align;
    property Axis:TScrollBarAxis read FAxis write FAxis default sbBoth;
    property Chart:TCustomChart read FChart write SetChart;
    property Enabled default False;
    property Inverted:Boolean read FInverted write SetInverted default False;
    property LargeChange default 500;
    property Max default TeeMaxScrollPos;
    property SmallChange default 50;
    property PageSize:integer read FPageSize write SetPageSize;
  end;

implementation

{ TChartScrollBar }
Constructor TChartScrollBar.Create(AOwner : TComponent);
begin
  inherited;
  FAxis:=sbBoth;
  SetParams(0,0,TeeMaxScrollPos);
  LargeChange:=TeeMaxScrollPos div 10;
  SmallChange:=TeeMaxScrollPos div 100;
  Enabled:=False;
  FInverted:=False;
end;

{ How many Series are associated to this Axis? }
Function TChartScrollBar.AssociatedSeries(Axis:TChartAxis):Integer;
var t : Integer;
begin
  result:=0;
  With Axis.ParentChart do
  for t:=0 to SeriesCount-1 do
      if Series[t].AssociatedToAxis(Axis) then Inc(result);
end;

{ When the ScrollBar changes, change the Chart Axis min and max }
procedure TChartScrollBar.Change;
var tmpPos : Integer;

  Procedure ScrollAxis(Axis:TChartAxis);
  var MidRange : Double;
      Middle   : Double;
      TotalMin : Double;
      TotalMax : Double;
  begin
    if AssociatedSeries(Axis)>0 then
    begin
      if FChart.MaxPointsPerPage>0 then FChart.Page:=tmpPos
      else
      if not Axis.Automatic then
      begin
        tmpPos:=tmpPos+(FPageSize div 2);
        CalcTotals(Axis,TotalMin,TotalMax);
        Middle:=(TotalMax-TotalMin)*tmpPos/(Max-Min);
        MidRange:=(Axis.Maximum-Axis.Minimum)*0.5;
        Axis.SetMinMax(Middle-MidRange,Middle+MidRange);
      end;
    end;
  end;

begin
  inherited;
  if Assigned(FChart) then
    if Kind=sbHorizontal then
    begin
      if Inverted then tmpPos:=Max-Position else tmpPos:=Position;
      if (FAxis=sbBoth) or (FAxis=sbDefault) then ScrollAxis(FChart.BottomAxis);
      if (FAxis=sbBoth) or (FAxis=sbOther) then ScrollAxis(FChart.TopAxis);
    end
    else
    begin
      if Inverted then tmpPos:=Position else tmpPos:=Max-Position;
      if (FAxis=sbBoth) or (FAxis=sbDefault) then ScrollAxis(FChart.LeftAxis);
      if (FAxis=sbBoth) or (FAxis=sbOther) then ScrollAxis(FChart.RightAxis);
    end;
end;

{ When the Chart is removed at design-time or run-time }
procedure TChartScrollBar.Notification( AComponent: TComponent;
                                        Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

Procedure TChartScrollBar.ChartOnPageChange(Sender:TObject);
begin
  RecalcPosition;
  if Assigned(FOldOnPageChange) then FOldOnPageChange(FChart);
end;

{ When the user scrolls the chart using the right mouse button }
Procedure TChartScrollBar.ChartOnScroll(Sender:TObject);
begin
  RecalcPosition;
  if Assigned(FOldOnScroll) then FOldOnScroll(FChart);
end;

{ When the user zooms the chart using the left mouse button }
Procedure TChartScrollBar.ChartOnZoom(Sender:TObject);
begin
  RecalcPosition;
  if Assigned(FOldOnZoom) then FOldOnZoom(FChart);
end;

{ When the user undoes any previous zoom using the left mouse button }
Procedure TChartScrollBar.ChartOnUndoZoom(Sender:TObject);
begin
  RecalcPosition;
  if Assigned(FOldOnUndoZoom) then FOldOnUndoZoom(FChart);
end;

{ Calculate the lowest and highest possible values for the Axis }
Procedure TChartScrollBar.CalcTotals(Axis:TChartAxis; Var AMin,AMax:Double);
Var OldAuto : Boolean;
    OldMin  : Double;
    OldMax  : Double;
//    tmp     : Double;
begin
  OldAuto:=Axis.Automatic;
  OldMin:=Axis.Minimum;
  OldMax:=Axis.Maximum;
  Axis.Automatic:=True;
  try
    Axis.CalcMinMax(AMin,AMax);
{    tmp:=(Axis.Maximum-Axis.Minimum)*0.5;
    AMax:=AMax-tmp;
    AMin:=AMin+tmp;}
  finally
    Axis.Automatic:=OldAuto;
    if not Axis.Automatic then Axis.SetMinMax(OldMin,OldMax);
  end;
end;

{ Change the scroll bar position and thumb size }
Procedure TChartScrollBar.RecalcPosition;

  Procedure RecalcAxis(Axis:TChartAxis);
  var Range       : Double;
      TotalMax    : Double;
      TotalMin    : Double;
      Middle      : Double;
      tmpPosition : Integer;
  begin
    if AssociatedSeries(Axis)>0 then
    begin
      if FChart.MaxPointsPerPage>0 then
      begin
        Min:=1;
        Max:=FChart.NumPages;
        SmallChange:=1;
        LargeChange:=1;
        Position:=FChart.Page;
        PageSize:=1;
      end
      else
      if Axis.Automatic then { no scrolling }
      begin
        Position:=(Min+Max) div 2; { center scroll }
        PageSize:=Max-Min+1;
      end
      else
      begin
        CalcTotals(Axis,TotalMin,TotalMax);
        Range:=TotalMax-TotalMin;
        if Range>MinAxisRange then { 5.02 }
        begin
          Middle:=(Axis.Minimum+Axis.Maximum)*0.5;
          tmpPosition:=Round(Max*(Middle-TotalMin)/Range);
          if tmpPosition>Max then tmpPosition:=Max;
          if tmpPosition<Min then tmpPosition:=Min;
          if ((Kind=sbVertical) and (not FInverted)) or
             ((Kind=sbHorizontal) and (FInverted)) then tmpPosition:=Max-tmpPosition;
          PageSize:=Round((Axis.Maximum-Axis.Minimum)*(Max-Min)/Range);
          Position:=tmpPosition-(PageSize div 2);
        end;
      end;
    end;
  end;

  Procedure RecalcAxes(Axis1,Axis2:TChartAxis);
  begin
    if (FAxis=sbBoth) or (FAxis=sbDefault) then RecalcAxis(Axis1);
    if (FAxis=sbBoth) or (FAxis=sbOther) then RecalcAxis(Axis2);
  end;

begin
  if Assigned(FChart) then
  With FChart do
  if Kind=sbHorizontal then RecalcAxes(BottomAxis,TopAxis)
                       else RecalcAxes(LeftAxis,RightAxis);
end;

Procedure TChartScrollBar.SetChart(Value:TCustomChart);
begin
  if FChart<>Value then
  begin
    FChart:=Value;
    if Assigned(FChart) then
    begin
      FOldOnPageChange:=FChart.OnPageChange;
      FChart.OnPageChange:=ChartOnPageChange;

      FOldOnScroll:=FChart.OnScroll;
      FChart.OnScroll:=ChartOnScroll;

      FOldOnZoom:=FChart.OnZoom;
      FChart.OnZoom:=ChartOnZoom;

      FOldOnUndoZoom:=FChart.OnUndoZoom;
      FChart.OnUndoZoom:=ChartOnUndoZoom;

      FChart.FreeNotification(Self);
      Enabled:=FChart.SeriesCount>0;
      RecalcPosition;
    end
    else
    begin
      Enabled:=False;
      FOldOnScroll:=nil;
      FOldOnZoom:=nil;
      FOldOnUndoZoom:=nil;
      FOldOnPageChange:=nil;
    end;
  end;
end;

Procedure TChartScrollBar.SetInverted(Value:Boolean);
begin
  if FInverted<>Value then
  begin
    FInverted:=Value;
    RecalcPosition;
  end;
end;

{ Change the scroll bar thumb size }
procedure TChartScrollbar.SetPageSize(Value:Integer);
{$IFDEF CLX}
begin
end;
{$ELSE}
var tmp : TScrollInfo;
begin
  if FPageSize<>Value then
  begin
    FPageSize:=Value;
    tmp.nPage:=FPageSize;
    tmp.fMask:=SIF_PAGE;
    SetScrollInfo(Handle,SB_CTL,tmp,True);
  end;
end;
{$ENDIF}

end.
