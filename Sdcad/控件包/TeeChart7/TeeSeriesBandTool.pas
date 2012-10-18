{********************************************}
{   TSeriesBandTool and Editor Dialog        }
{   Copyright (c) 2003-2004 by David Berneda }
{   and Martin Kaul (mkaul@leuze.de)         }
{********************************************}
unit TeeSeriesBandTool;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$IFDEF LINUX}
     Types,
     {$ENDIF}
     TeeToolSeriesEdit, TeCanvas, TeePenDlg, TeeTools, TeEngine,
     TeeProcs, Chart, TeeConst, TeeProCo;

type
  // Series-Band tool, use it to display a band between two (line) series
  // created 2003-12-14 by mkaul@leuze.de
  TSeriesBandTool=class(TTeeCustomToolSeries)
  private
    FDrawBehind   : Boolean;
    FGradient     : TTeeGradient;
    FSeries2      : TChartSeries;
    FTransparency : TTeeTransparency;

    ISerie1Drawed : Boolean;
    ISerie2Drawed : Boolean;

    procedure AfterSeriesDraw(Sender: TObject);
    procedure BeforeSeriesDraw(Sender: TObject);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetTransparency(const Value: TTeeTransparency);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetSeries(const Value: TChartSeries); override;
    procedure SetSeries2(const Value: TChartSeries); virtual;
    procedure DrawBandTool; virtual;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
  published
    property Active;
    property Brush;
    property DrawBehindSeries:Boolean read FDrawBehind
                                      write SetDrawBehind default True;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property Pen;
    property Series;
    property Series2:TChartSeries read FSeries2 write SetSeries2;
    property Transparency:TTeeTransparency read FTransparency
                                           write SetTransparency default 0;
  end;

  TSeriesBandToolEdit = class(TSeriesToolEditor)
    Button1: TButton;
    CBDrawBehindSeries: TCheckBox;
    BPen: TButtonPen;
    Label2: TLabel;
    CBSeries2: TComboFlat;
    Button2: TButton;
    Label4: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBDrawBehindSeriesClick(Sender: TObject);
    procedure CBSeries2Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
  private
    { Private declarations }
    SeriesBand : TSeriesBandTool;
  protected
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses Math, TeeBrushDlg, TeeEdiGrad;

procedure TSeriesBandToolEdit.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,SeriesBand.Brush);
end;

procedure TSeriesBandToolEdit.FormShow(Sender: TObject);
begin
  inherited;

  SeriesBand:=TSeriesBandTool(Tag);

  if Assigned(SeriesBand) then
  With SeriesBand do
  begin
    FillSeriesCombo(CBSeries2,Series2,ParentChart);
    BPen.LinkPen(Pen);
    CBDrawBehindSeries.Checked:=DrawBehindSeries;
    UDTransp.Position:=Transparency;
  end;
end;

procedure TSeriesBandToolEdit.CBDrawBehindSeriesClick(Sender: TObject);
begin
  SeriesBand.DrawBehindSeries:=CBDrawBehindSeries.Checked;
end;

procedure TSeriesBandToolEdit.CBSeries2Change(Sender: TObject);
begin
  With CBSeries2 do SeriesBand.Series2:=TChartSeries(Items.Objects[CBSeries2.ItemIndex]);
end;

// created 2003-12-14 by mkaul@leuze.de
{ TSeriesBandTool }
Constructor TSeriesBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FDrawBehind:=True;
  Brush.Color:=clWhite;
  Pen.Visible:=False;
  FGradient:=TTeeGradient.Create(CanvasChanged);
end;

procedure TSeriesBandTool.AfterSeriesDraw(Sender: TObject);
begin
  if not FDrawBehind then
  begin
    if Assigned(Series)  and (Sender=Series)  then ISerie1Drawed:=True;
    if Assigned(Series2) and (Sender=Series2) then ISerie2Drawed:=True;

    if ISerie1Drawed and ISerie2Drawed then DrawBandTool;
  end;
end;

procedure TSeriesBandTool.BeforeSeriesDraw(Sender: TObject);
begin
  if FDrawBehind then
  begin
    if Assigned(Series)  and (Sender=Series)  then ISerie1Drawed:=True;
    if Assigned(Series2) and (Sender=Series2) then ISerie2Drawed:=True;

    if ISerie1Drawed or ISerie2Drawed then
       if not (ISerie1Drawed and ISerie2Drawed) then DrawBandTool;
  end;
end;

procedure TSeriesBandTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

procedure TSeriesBandTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if AEvent=cteBeforeDrawSeries then
  begin
    ISerie1Drawed:=False;
    ISerie2Drawed:=False;
  end;
end;

class Function TSeriesBandTool.Description:String;
begin
  result:=TeeMsg_SeriesBandTool;
end;

procedure TSeriesBandTool.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation=opRemove then
  begin
    if Assigned(Series) and (AComponent=Series) then
    begin
      Series.AfterDrawValues:=nil;
      Series.BeforeDrawValues:=nil;
    end;

    if Assigned(Series2) and (AComponent=Series2) then
    begin
      Series2.AfterDrawValues:=nil;
      Series2.BeforeDrawValues:=nil;
    end;
  end;

  inherited;
end;

procedure TSeriesBandTool.SetSeries(const Value: TChartSeries);
begin
  inherited;

  if Assigned(Series) then
  begin
    Series.AfterDrawValues:=AfterSeriesDraw;
    Series.BeforeDrawValues:=BeforeSeriesDraw;
  end;

  Repaint;
end;

procedure TSeriesBandTool.SetSeries2(const Value: TChartSeries);
begin
  if FSeries2<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FSeries2) then FSeries2.RemoveFreeNotification(Self);
    {$ENDIF}
    FSeries2:=Value;
    if Assigned(FSeries2) then FSeries2.FreeNotification(Self);

    if Assigned(Series2) then
    begin
      Series2.AfterDrawValues:=AfterSeriesDraw;
      Series2.BeforeDrawValues:=BeforeSeriesDraw;
    end;

    Repaint;
  end;
end;

type
  TSeriesAccess=class(TChartSeries);

procedure TSeriesBandTool.DrawBandTool;
var t      : Integer;
    i      : Integer;
    l1     : Integer;
    l2     : Integer;
    tmpPoints : TPointArray;
    tmpZ   : Integer;
    tmpR   : TRect;
    tmpBlend : TTeeBlend;
begin
  if Active and Assigned(ParentChart) and
     Assigned(Series) and Assigned(Series2) then
  begin
    TSeriesAccess(Series).CalcFirstLastVisibleIndex;
    TSeriesAccess(Series2).CalcFirstLastVisibleIndex;

    if (Series.FirstValueIndex<>-1) and (Series2.FirstValueIndex<>-1) then
    begin
      l1:=Series.LastValueIndex-Series.FirstValueIndex+1;
      l2:=Series2.LastValueIndex-Series2.FirstValueIndex+1;

      SetLength(tmpPoints,l1+l2);

      if Assigned(tmpPoints) then
      try
        i:=0;
        for t:=Series.FirstValueIndex to Series.LastValueIndex do
        begin
          tmpPoints[i].X:=Series.CalcXPos(t);
          tmpPoints[i].Y:=Series.CalcYPos(t);
          Inc(i);
        end;

        for t:=Series2.LastValueIndex downto Series2.FirstValueIndex do
        begin
          tmpPoints[i].X:=Series2.CalcXPos(t);
          tmpPoints[i].Y:=Series2.CalcYPos(t);
          Inc(i);
        end;

        tmpZ:=Math.Max(Series.StartZ,Series2.StartZ);

        if Transparency>0 then
        begin
          tmpR:=PolygonBounds(tmpPoints);
          tmpBlend:=ParentChart.Canvas.BeginBlending(
              ParentChart.Canvas.RectFromRectZ(tmpR,tmpZ),Transparency)
        end
        else
          tmpBlend:=nil;

        if Gradient.Visible and ParentChart.CanClip then
        begin
          Gradient.Draw(ParentChart.Canvas,tmpPoints,tmpZ,ParentChart.View3D);
          ParentChart.Canvas.Brush.Style:=bsClear;
        end
        else
        with ParentChart.Canvas do
        begin
          ClipRectangle( RectFromRectZ(ParentChart.ChartRect, tmpZ));

          AssignBrushColor(Self.Brush,Self.Brush.Color,clBlack);
          AssignVisiblePen(Self.Pen);

          if ParentChart.View3D then PolygonWithZ(tmpPoints,tmpZ)
                                else Polygon(tmpPoints);

          UnClipRectangle;
        end;

        if Assigned(tmpBlend) then
           ParentChart.Canvas.EndBlending(tmpBlend);

      finally
        tmpPoints:=nil;
      end;
    end;
  end;
end;

class function TSeriesBandTool.GetEditorClass: String;
begin
  result:='TSeriesBandToolEdit';
end;

procedure TSeriesBandTool.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

destructor TSeriesBandTool.Destroy;
begin
  FGradient.Free;
  inherited;
end;

procedure TSeriesBandToolEdit.Button2Click(Sender: TObject);
begin
  EditTeeGradient(Self,SeriesBand.Gradient)
end;

procedure TSeriesBandTool.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TSeriesBandToolEdit.ETranspChange(Sender: TObject);
begin
  if Showing then
     SeriesBand.Transparency:=UDTransp.Position;
end;

initialization
  RegisterTeeTools([TSeriesBandTool]);
  RegisterClass(TSeriesBandToolEdit);
finalization
  UnRegisterTeeTools([TSeriesBandTool]);
end.
