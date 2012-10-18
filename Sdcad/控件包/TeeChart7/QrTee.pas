{**********************************************}
{  TDBChart for QuickReport                    }
{  Copyright (c) 1996-2004 by David Berneda    }
{  All Rights Reserved                         }
{**********************************************}
unit QrTee;
{$I TeeDefs.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, TeeProcs, TeEngine, Chart, QuickRpt, TeCanvas,
  {$IFNDEF NOUSE_BDE}
  DBChart,
  {$ENDIF}
  StdCtrls, Menus, ExtCtrls;

type
  TTeeQuickMethod=(qtmBitmap, qtmMetafile);

  TQRChart=class;

  TQRDBChart=class({$IFNDEF NOUSE_BDE}TCustomDBChart{$ELSE}TCustomChart{$ENDIF})
  protected
  public
    Constructor Create(AOwner : TComponent); override;
    Function GetRectangle:TRect; override;
    procedure Invalidate; override;
    procedure Paint; override;
  published
    {$IFNDEF NOUSE_BDE}
    { TCustomDBChart properties }
    property ShowGlassCursor;
    { TCustomDBChart events }
    property OnProcessRecord;
    {$ENDIF}

    { TCustomChart Properties }
    property BackImage;
    property BackImageInside;
    property BackImageMode;
    property BackImageTransp;
    property BackWall;
    property Border;
    property BorderRound;
    property BottomWall;
    property Foot;
    property Gradient;
    property LeftWall;
    property MarginBottom;
    property MarginLeft;
    property MarginRight;
    property MarginTop;
    property MarginUnits;
    property RightWall;
    property SubFoot;
    property SubTitle;
    property Title;

    { TCustomChart Events }
    property OnGetLegendPos;
    property OnGetLegendRect;

    { TCustomAxisPanel properties }
    property AxisBehind;
    property AxisVisible;
    property BottomAxis;
    property Chart3DPercent;
    property ClipPoints;
    property CustomAxes;
    property DepthAxis;
    property DepthTopAxis;
    property Frame;
    property LeftAxis;
    property Legend;
    property MaxPointsPerPage;
    property Page;
    property RightAxis;
    property ScaleLastPage;
    property SeriesList;
    property Shadow;
    property TopAxis;
    property View3D;
    property View3DOptions;
    property View3DWalls;

    { TCustomAxisPanel events }
    property OnAfterDraw;
    property OnBeforeDrawAxes;
    property OnBeforeDrawChart;
    property OnBeforeDrawSeries;
    property OnGetAxisLabel;
    property OnGetLegendText;
    property OnGetNextAxisLabel;
    property OnPageChange;

    { TPanel properties }
    property BevelInner;
    property BevelWidth;
    property BevelOuter default bvNone;
    property BorderWidth;
    property Color default clWhite;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;

    { TPanel events }
    property OnEnter;
    property OnExit;
    property OnResize;
  end;

  TPrintChartEvent = procedure( Sender: TQRChart;
				Var PaperRect,ChartRect:TRect ) of object;

  TQRChart = class(TQRPrintable)
  private
    { Private declarations }
    FOnPrint        : TPrintChartEvent;
    FTeePrintMethod : TTeeQuickMethod;

    Function GetChart:TQRDBChart;
    Procedure SetPrintMethod(Value:TTeeQuickMethod);
  protected
    { Protected declarations }
    procedure ReadState(Reader: TReader); override;
  public
    { Public declarations }
    Constructor Create(AOwner : TComponent); override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure Paint; override;
    procedure SetChart(AChart:TCustomChart);
  published
    { Published declarations }
    property Chart:TQRDBChart read GetChart;
    property TeePrintMethod:TTeeQuickMethod read FTeePrintMethod
                                            write SetPrintMethod default qtmMetafile;
    { Published QR events }
    property OnPrint:TPrintChartEvent read FOnPrint write FOnPrint;

  end;

implementation

Uses {$IFNDEF D5}DsgnIntf,{$ENDIF} TeeConst;

Const TeeMsg_DefaultQRChart='QRDBChart'; { <-- dont translate }

{ TQRDBChart }
Constructor TQRDBChart.Create(AOwner : TComponent);
begin
  inherited;
  Color:=clWhite;
  BevelOuter:=bvNone;
  BufferedDisplay:=False;
  SetBounds(-1,-1,1,1);
  Hide;
end;

Function TQRDBChart.GetRectangle:TRect;
Var tmpZoomFactor : Double;
begin
  if Assigned(Parent) then
  With TQRChart(Parent) do
  begin
    if Assigned(ParentReport) then tmpZoomFactor:=100.0/ParentReport.Zoom
                              else tmpZoomFactor:=1;

    {$IFDEF D6}
    try
    {$ENDIF}
      result:=Rect(0,0, Round(ClientWidth*tmpZoomFactor),
                        Round(ClientHeight*tmpZoomFactor) );
    {$IFDEF D6}
    except
      on EOSError do
      begin
        result:=Rect(0,0, Round(Width*tmpZoomFactor),
                          Round(Height*tmpZoomFactor) );
      end;
    end;
    {$ENDIF}
  end
  else result:=GetClientRect;
end;

procedure TQRDBChart.Paint;

  Procedure DrawGraphic(AGraphic:TGraphic);
  var r : TRect;
  begin
    With TQRChart(Parent) do
    begin
      R:=GetClientRect;
      Inc(R.Right,2);  // 7.0
      Inc(R.Bottom,2);
      Canvas.StretchDraw(R,AGraphic);
    end;
    AGraphic.Free;
  end;

begin
  if Assigned(Parent) then
  With TQRChart(Parent) do
  Case FTeePrintMethod of
  qtmMetafile: DrawGraphic(TeeCreateMetafile(True,GetRectangle));
    qtmBitmap: DrawGraphic(TeeCreateBitmap(clWhite,GetRectangle));
  end;
end;

procedure TQRDBChart.Invalidate;
begin
  if Assigned(Parent) then Parent.Invalidate;
end;

{ TQRChart }
Constructor TQRChart.Create(AOwner : TComponent);
begin
  inherited;
  FTeePrintMethod:=qtmMetafile;
  Width :=350;
  Height:=200;
  if (csDesigning in ComponentState) and
     (not (csLoading in Owner.ComponentState)) then
  With TQRDBChart.Create(AOwner) do
  begin
    Parent:=TWinControl(Self);
    Name:=TeeGetUniqueName(AOwner,TeeMsg_DefaultQRChart);
    With Title.Text do
    begin
      Clear;
      Add(Self.ClassName);
    end;
  end;
end;

procedure TQRChart.ReadState(Reader: TReader);
Var tmpChart : TQRDBChart;
begin
  tmpChart:=Chart;
  if Assigned(tmpChart) and
     (not (csLoading in tmpChart.ComponentState))
     and (not (csAncestor in tmpChart.ComponentState)) then
          tmpChart.Free;
  inherited;
end;

Procedure TQRChart.SetPrintMethod(Value:TTeeQuickMethod);
begin
  if Value<>FTeePrintMethod then
  begin
    FTeePrintMethod:=Value;
    Repaint;
  end;
end;

procedure TQRChart.Print(OfsX, OfsY : Integer);
Var QuickRect : TRect;

  Procedure PrintGraphic(AGraphic:TGraphic);
  begin
    QRPrinter.Canvas.StretchDraw(QuickRect,AGraphic);
    AGraphic.Free;
  end;

Var tmpRect  : TRect;
    tmpChart : TQRDBChart;
begin
  tmpChart:=Chart;
  if Assigned(tmpChart) then
  begin
    {$IFNDEF NOUSE_BDE}
    tmpChart.RefreshData;
    {$ENDIF}
    With ParentReport.QRPrinter do
    begin
      QuickRect:=Rect( Xpos(OfsX+Size.Left),
                       Ypos(OfsY+Size.Top),
                       Xpos(OfsX+Size.Left+Size.Width),
                       Ypos(OfsY+Size.Top+Size.Height));

      tmpRect:=tmpChart.GetRectangle;
      if Assigned(FOnPrint) then FOnPrint(Self,QuickRect,tmpRect);
      Case FTeePrintMethod of
      qtmMetafile: PrintGraphic(tmpChart.TeeCreateMetafile(True,tmpRect));
        qtmBitmap: PrintGraphic(tmpChart.TeeCreateBitmap(clWhite,tmpRect));
      end;
    end;
  end;
  inherited;
end;

procedure TQRChart.SetChart(AChart:TCustomChart);  // 7.0

  Function CloneChartTool(ATool:TTeeCustomTool):TTeeCustomTool;
  begin
    result:=TTeeCustomToolClass(ATool.ClassType).Create(Owner);
    result.Assign(ATool);
  end;

var t : Integer;
begin
  Chart.FreeAllSeries;
  Chart.Assign(AChart);
  for t:=0 to AChart.SeriesCount-1 do
        CloneChartSeries(AChart[t]).ParentChart:=Chart;
  for t:=0 to AChart.Tools.Count-1 do
        CloneChartTool(AChart.Tools[t]).ParentChart:=Chart;
end;

procedure TQRChart.Paint;
begin
  if Assigned(Chart) then Chart.Paint;
  inherited;
end;

Function TQRChart.GetChart:TQRDBChart;
begin
  if ControlCount>0 then result:=TQRDBChart(Controls[0])
                    else result:=nil;
end;

initialization
  RegisterClass(TQRDBChart);
end.
