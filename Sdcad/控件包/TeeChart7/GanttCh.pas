{**********************************************}
{   TGanttSeries (derived from TPointSeries)   }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit GanttCh;
{$I TeeDefs.inc}

interface

{ TGanttSeries is a Chart Series derived from TPointSeries.
  Each point in the series is drawn as a Gantt horizontal bar.
  Each point has a Start and End values that are used to draw the Gantt bar
  with its corresponding screen length in the horizontal plane. }

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Chart, Series, TeEngine, TeCanvas;

type
  TGanttSeries=class(TPointSeries)
  private
    { The Gantt Start values are implicit stored in XValues }
    FEndValues : TChartValueList; { <-- Gantt bar's End values storage }
    FNextTask  : TChartValueList;  { <-- Used to connect lines }

    Function GetConnectingPen:TChartPen;
    Function GetStartValues:TChartValueList;
    Procedure SetConnectingPen(Value:TChartPen);
    Procedure SetEndValues(Value:TChartValueList);
    Procedure SetNextTask(Value:TChartValueList);
    Procedure SetStartValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override; { <-- to add random end values }
    Function ClickedPointer( ValueIndex,tmpX,tmpY:Integer;
                             x,y:Integer):Boolean; override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    Procedure DrawMark(ValueIndex:Integer; Const St:String; APosition:TSeriesMarkPosition); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function AddGantt(Const AStart,AEnd,AY:Double;
                      Const AXLabel:String=''):Integer;
    Function AddGanttColor( Const AStart,AEnd,AY:Double;
                            Const AXLabel:String='';
                            AColor:TColor=clTeeColor):Integer;
    Function AddXY(Const AXValue,AYValue:Double; Const ALabel:String='';
                         AColor:TColor=clTeeColor):Integer; override;

    Procedure Assign(Source:TPersistent); override;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxXValue:Double; override;  { <-- adds end values }
  published
    property ColorEachPoint default True;
    property ConnectingPen:TChartPen read GetConnectingPen write SetConnectingPen;
    property StartValues:TChartValueList read GetStartValues write SetStartValues;
    property EndValues:TChartValueList read FEndValues write SetEndValues;
    property NextTask:TChartValueList read FNextTask write SetNextTask;
  end;

implementation

Uses {$IFDEF CLX}
     QDialogs,
     {$ELSE}
     Dialogs,
     {$ENDIF}
     Math, SysUtils, TeeProcs, TeeConst;

type
  TValueListAccess=class(TChartValueList);

{ TGanttSeries }
Constructor TGanttSeries.Create(AOwner: TComponent);
Begin
  inherited;
  SetHorizontal;
  ClickableLine:=False; { only allow click on Pointer (Gantt Bar) }
  CalcVisiblePoints:=False; { draw all points }

  XValues.Name:=TeeMsg_ValuesGanttStart;
  TValueListAccess(XValues).InitDateTime(True);

  ColorEachPoint:=True;

  FEndValues :=TChartValueList.Create(Self,TeeMsg_ValuesGanttEnd);
  TValueListAccess(FEndValues).InitDateTime(True);

  FNextTask  :=TChartValueList.Create(Self,TeeMsg_ValuesGanttNextTask);
  Pointer.Style:=psRectangle; { <-- a Horizontal Gantt Bar (by default) }
end;

Procedure TGanttSeries.SetEndValues(Value:TChartValueList);
Begin
  SetChartValueList(FEndValues,Value); { standard method }
end;

Procedure TGanttSeries.SetNextTask(Value:TChartValueList);
Begin
  SetChartValueList(TChartValueList(FNextTask),Value); { standard method }
end;

Procedure TGanttSeries.SetConnectingPen(Value:TChartPen);
Begin
  LinePen.Assign(Value);
end;

{ Helper method, special to Gantt bar series }
Function TGanttSeries.AddGanttColor( Const AStart,AEnd,AY:Double;
                                     Const AXLabel:String;
                                     AColor:TColor ):Integer;
begin
  FEndValues.TempValue:=AEnd;
  result:=AddXY(AStart,AY,AXLabel,AColor);
end;

{ Helper method, special to Gantt bar series }
Function TGanttSeries.AddGantt( Const AStart,AEnd,AY:Double;
                                Const AXLabel:String):Integer;
Begin
  result:=AddGanttColor(AStart,AEnd,AY,AXLabel);
end;

Procedure TGanttSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);

  Function GanttSampleStr(Index:Integer):String;
  begin
    Case Index of
      0: result:=TeeMsg_GanttSample1;
      1: result:=TeeMsg_GanttSample2;
      2: result:=TeeMsg_GanttSample3;
      3: result:=TeeMsg_GanttSample4;
      4: result:=TeeMsg_GanttSample5;
      5: result:=TeeMsg_GanttSample6;
      6: result:=TeeMsg_GanttSample7;
      7: result:=TeeMsg_GanttSample8;
      8: result:=TeeMsg_GanttSample9;
     else
        result:=TeeMsg_GanttSample10;
     end;
  end;

Const NumGanttSamples=10;
Var Added        : Integer;
    t            : Integer;
    tmpY         : Integer;
    tt           : Integer;
    tmpStartTask : TDateTime;
    tmpEndTask   : TDateTime;
Begin
  { some sample values to see something at design mode }
  for t:=0 to Math.Min( NumValues-1, NumGanttSamples+RandomValue(20) ) do
  begin
    tmpStartTask:=Date+t*3+RandomValue(5);
    tmpEndTask:=tmpStartTask+9+RandomValue(16);
    tmpY:=(t mod 10);

    Added:=AddGantt( tmpStartTask, // Start
                     tmpEndTask,   // End
                     tmpY,         // Y value
                     GanttSampleStr(tmpY) // some sample label text
                     );

    // Connect Gantt points:
    for tt:=0 to Added-1 do
    if (NextTask.Value[tt]=-1) and (tmpStartTask>EndValues.Value[tt]) then
    begin
      NextTask.Value[tt]:=Added;
      break;
    end;
  end;
end;

Function TGanttSeries.ClickedPointer( ValueIndex,tmpX,tmpY:Integer;
                                      x,y:Integer):Boolean;
begin
  result:=(x>=tmpX) and (x<=CalcXPosValue(EndValues.Value[ValueIndex])) and
          (Abs(tmpY-Y)<Pointer.VertSize);
end;

procedure TGanttSeries.DrawValue(ValueIndex:Integer);
var x1              : Integer;
    x2              : Integer;
    Y               : Integer;
    tmpHalfHorizSize: Integer;
    HalfWay         : Integer;
    tmpNextTask     : Integer;
    xNext           : Integer;
    YNext           : Integer;
    tmpStyle        : TSeriesPointerStyle;
Begin
  // This overrided method is the main paint for Gantt bar points.
  if Pointer.Visible then
  with ParentChart.Canvas do
  Begin
    Pointer.PrepareCanvas(ParentChart.Canvas,ValueColor[ValueIndex]);
    X1:=CalcXPos(ValueIndex);
    X2:=CalcXPosValue(EndValues.Value[ValueIndex]);
    tmpHalfHorizSize:=(x2-x1) div 2;
    Y:=CalcYPos(ValueIndex);

    if Assigned(OnGetPointerStyle) then
       tmpStyle:=OnGetPointerStyle(Self,ValueIndex)
    else
       tmpStyle:=Pointer.Style;

    Pointer.DrawPointer( ParentChart.Canvas,
                         ParentChart.View3D,
                         x1+tmpHalfHorizSize,
                         Y,
                         tmpHalfHorizSize,
                         Pointer.VertSize,
                         ValueColor[ValueIndex],tmpStyle);

    if ConnectingPen.Visible then
    Begin
      tmpNextTask:=Round(NextTask.Value[ValueIndex]);

      if (tmpNextTask>=0) and (tmpNextTask<Count) then
      Begin
        AssignVisiblePen(ConnectingPen);
        Brush.Style:=bsClear;
        XNext:=CalcXPos(tmpNextTask);
        HalfWay:=X2+((XNext-X2) div 2);
        YNext:=CalcYPos(tmpNextTask);
        LineWithZ(X2,Y,HalfWay,Y,MiddleZ);
        LineTo3D(HalfWay,YNext,MiddleZ);
        LineTo3D(XNext,YNext,MiddleZ);
      End;
    end;
  end;
end;

Function TGanttSeries.MaxXValue:Double;
Begin
  result:=Math.Max(inherited MaxXValue,FEndValues.MaxValue);
end;

Procedure TGanttSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                 APosition:TSeriesMarkPosition);
Begin
  With APosition do
  begin
    Inc(LeftTop.X,(CalcXPosValue(EndValues.Value[ValueIndex])-ArrowFrom.X) div 2);
    Inc(LeftTop.Y,Height div 2);
  end;
  inherited;
End;

Function TGanttSeries.GetStartValues:TChartValueList;
Begin
  result:=XValues;
end;

Procedure TGanttSeries.SetStartValues(Value:TChartValueList);
Begin
  SetXValues(Value);
end;

Procedure TGanttSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  ColorEachPoint:=IsEnabled;
  Pointer.VertSize:=3;
  Pointer.Gradient.Visible:=True;
end;

class Function TGanttSeries.GetEditorClass:String;
begin
  result:='TGanttSeriesEditor';  { <-- dont translate ! }
end;

Procedure TGanttSeries.Assign(Source:TPersistent);
begin
  if Source is TGanttSeries then
     ConnectingPen:=TGanttSeries(Source).ConnectingPen;
  inherited;
end;

Function TGanttSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TGanttSeries; { Only Gantt can be assigned to Gantt }
end;

function TGanttSeries.GetConnectingPen: TChartPen;
begin
  result:=LinePen;
end;

function TGanttSeries.AddXY(const AXValue, AYValue: Double;
  const ALabel: String; AColor: TColor): Integer;
begin
  NextTask.TempValue:=-1;
  result:=inherited AddXY(AXValue,AYValue,ALabel,AColor);
end;

initialization
  RegisterTeeSeries(TGanttSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGantt,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStandard,1);
end.
