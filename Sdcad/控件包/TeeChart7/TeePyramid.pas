{*****************************************}
{  TeeChart Pro                           }
{  Copyright (c) 1996-2004 David Berneda  }
{                                         }
{  TPyramid Series                        }
{*****************************************}
unit TeePyramid;
{$I TeeDefs.inc}

interface

Uses Classes, TeEngine;

type
  TPyramidSeries=class(TChartSeries)
  private
    FSize : Integer;
    Function AcumUpTo(UpToIndex:Integer):Double;
    procedure SetSize(const Value: Integer);
  protected
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    class Function GetEditorClass:String; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure DrawValue(ValueIndex:Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Function DrawValuesForward:Boolean; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property Brush;
    property ColorEachPoint default True;
    property ColorSource;
    property Cursor;
    property Depth;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property Pen;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property SizePercent:Integer read FSize write SetSize default 50;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;
    property XValues;
    property YValues;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Chart, TeeConst, TeeProCo, TeCanvas
     {$IFDEF CLX}
     , QGraphics, Types
     {$ELSE}
     , Graphics
     {$ENDIF};

{ TPyramidSeries }
constructor TPyramidSeries.Create(AOwner: TComponent);
begin
  inherited;
  CalcVisiblePoints:=False;
  ColorEachPoint:=True;
  FSize:=50;
end;

procedure TPyramidSeries.CalcHorizMargins(var LeftMargin,
  RightMargin: Integer);
begin
  LeftMargin:=20;
  RightMargin:=20;
end;

Function TPyramidSeries.AcumUpTo(UpToIndex:Integer):Double;
var t : Integer;
begin
  result:=0;
  for t:=0 to UpToIndex do result:=result+MandatoryValueList.Value[t];
end;

procedure TPyramidSeries.DrawValue(ValueIndex: Integer);
var tmp       : Double;
    tmpTrunc  : Double;
    tmpTruncZ : Double;
    tmpZ2     : Integer;
    tmpZ      : Integer;
    tmpX      : Integer;
    R         : TRect;
    tmpSize   : Integer;
begin
  if not IsNull(ValueIndex) then
  begin
    ParentChart.SetBrushCanvas(ValueColor[ValueIndex],Brush,Brush.Color);

    ParentChart.Canvas.AssignVisiblePen(Pen);

    tmp:=AcumUpTo(ValueIndex-1);
    tmpTrunc:=100.0-(tmp*100.0/MandatoryValueList.Total);

    tmpSize:=Round(SizePercent*GetHorizAxis.IAxisSize*0.005);

    tmpX:=Round(tmpTrunc*tmpSize*0.01);
    R.Left:=GetHorizAxis.CalcPosValue(MinXValue)-tmpX;
    R.Right:=R.Left+2*tmpX;

    tmpTruncZ:=100.0-tmpTrunc;
    if tmpTruncZ>0 then tmpZ:=Round(tmpTruncZ*(EndZ-StartZ)*0.005)
                   else tmpZ:=0;

    R.Bottom:=GetVertAxis.CalcPosValue(tmp);

    tmp:=tmp+MandatoryValueList.Value[ValueIndex];
    R.Top:=GetVertAxis.CalcPosValue(tmp);
    tmpTrunc:=100.0-(tmp*100.0/MandatoryValueList.Total);

    if tmpTrunc<100 then tmpZ2:=Round(tmpTrunc*(EndZ-StartZ)*0.005)
                    else tmpZ2:=0;
    ParentChart.Canvas.PyramidTrunc(R,StartZ+tmpZ,EndZ-tmpZ,
                                    Round(tmpTrunc*tmpSize*0.01),
                                    tmpZ2);
  end;
end;

function TPyramidSeries.MaxXValue: Double;
begin
  result:=MinXValue;
end;

function TPyramidSeries.MaxYValue: Double;
begin
  result:=MandatoryValueList.TotalABS
end;

function TPyramidSeries.MinXValue: Double;
begin
  result:=ParentChart.SeriesList.IndexOf(Self);
end;

function TPyramidSeries.MinYValue: Double;
begin
  result:=0;
end;

procedure TPyramidSeries.SetSize(const Value: Integer);
begin
  SetIntegerProperty(FSize,Value);
end;

class function TPyramidSeries.GetEditorClass: String;
begin
  result:='TPyramidSeriesEditor';
end;

procedure TPyramidSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  APosition.LeftTop.Y:=GetVertAxis.CalcPosValue(AcumUpTo(ValueIndex));
  inherited;
end;

function TPyramidSeries.DrawValuesForward: Boolean;
begin
  result:=not GetVertAxis.Inverted;
end;

initialization
  RegisterTeeSeries(TPyramidSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryPyramid,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended,2);
finalization
  UnRegisterTeeSeries([TPyramidSeries]);
end.
