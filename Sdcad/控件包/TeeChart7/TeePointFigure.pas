{**************************************************}
{   TPointFigureSeries (derived from TOHLCSeries)  }
{   Copyright (c) 2002-2004 by David Berneda       }
{**************************************************}
unit TeePointFigure;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF CLX}
     QForms, QControls, QStdCtrls, QGraphics,
     {$ELSE}
     Forms, Controls, StdCtrls, Graphics,
     {$ENDIF}
     Classes, SysUtils,
     TeeProcs, OHLChart, TeEngine, Series;

type
  TPointFigureSeries=class(TOHLCSeries)
  private
    FBoxSize  : Double;
    FDown     : TSeriesPointer;
    FReversal : Double;
    FUp       : TSeriesPointer;

    Procedure DrawColumn( Pointer:TSeriesPointer; FromValue:Double;
                          const ToValue:Double; tmpX:Integer);
    procedure SetBoxSize(const Value: Double);
    procedure SetDown(const Value: TSeriesPointer);
    procedure SetReversal(const Value: Double);
    procedure SetUp(const Value: TSeriesPointer);
  protected
    Function CalcMaxColumns(Draw:Boolean=False):Integer;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function CountLegendItems:Integer; override;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
  published
    property BoxSize:Double read FBoxSize write SetBoxSize;
    property DownSymbol:TSeriesPointer read FDown write SetDown;
    property ReversalAmount:Double read FReversal write SetReversal;
    property UpSymbol:TSeriesPointer read FUp write SetUp;

    property Active;
    property Brush;
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

  TPointFigureEditor = class(TForm)
    Label1: TLabel;
    EBoxSize: TEdit;
    Label2: TLabel;
    EReversal: TEdit;
    procedure FormShow(Sender: TObject);
    procedure EBoxSizeChange(Sender: TObject);
    procedure EReversalChange(Sender: TObject);
  private
    { Private declarations }
    UpForm      : TCustomForm;
    DownForm    : TCustomForm;
    PointFigure : TPointFigureSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses Chart, TeeProCo, TeePoEdi, TeCanvas;

type TValueListAccess=class(TChartValueList);

{ TPointFigureSeries }
Constructor TPointFigureSeries.Create(AOwner: TComponent);
begin
  inherited;
  FUp:=TSeriesPointer.Create(Self);
  FUp.Style:=psDiagCross;
  FUp.Brush.Color:=clGreen;

  FDown:=TSeriesPointer.Create(Self);
  FDown.Style:=psCircle;
  FDown.Brush.Color:=clRed;

  FBoxSize:=1;
  FReversal:=3;
  TValueListAccess(XValues).InitDateTime(False);
end;

Destructor TPointFigureSeries.Destroy;
begin
  FreeAndNil(FDown);
  FreeAndNil(FUp);
  inherited;
end;

Procedure TPointFigureSeries.DrawColumn( Pointer:TSeriesPointer; FromValue:Double;
                                         const ToValue:Double; tmpX:Integer);
var tmpY : Integer;
begin
  repeat
    tmpY:=CalcYPosValue(FromValue);
    Pointer.PrepareCanvas(ParentChart.Canvas,Pointer.Color);
    Pointer.Draw(tmpX,tmpY);
    FromValue:=FromValue+BoxSize;
  until FromValue>ToValue;
end;

Function TPointFigureSeries.CalcMaxColumns(Draw:Boolean=False):Integer;
var tmpX : Integer;
    tmpLow      : Double;
    tmpHigh     : Double;
    tmp         : Double;
    t           : Integer;
    tmpCol      : Integer;
    tmpDistance : Double;
    tmpIsDown   : Boolean;
begin
  if Count>0 then
  begin
    tmpDistance:=ReversalAmount*BoxSize;

    tmpLow:=LowValues.Value[0];
    tmpHigh:=HighValues.Value[0];
    tmpCol:=0;

    if Draw then
    begin
      tmpX:=CalcXPosValue(tmpCol);
      DrawColumn(FDown,tmpLow,tmpHigh,tmpX);
    end
    else tmpX:=0;

    tmpIsDown:=True;

    for t:=1 to Count-1 do
    begin
      if tmpIsDown then
      begin
        tmp:=LowValues.Value[t];
        if tmp<=(tmpLow-BoxSize) then
        begin
          if Draw then
             DrawColumn(FDown,tmp,tmpLow-BoxSize,tmpX);
          tmpLow:=tmp;
        end
        else
        begin
          tmp:=HighValues.Value[t];
          if tmp>=(tmpLow+tmpDistance) then
          begin
            Inc(tmpCol);
            tmpHigh:=tmp;
            if Draw then
            begin
              tmpX:=CalcXPosValue(tmpCol);
              DrawColumn(FUp,tmpLow+BoxSize,tmpHigh,tmpX);
            end;
            tmpIsDown:=False;
          end;
        end;
      end
      else
      begin
        tmp:=HighValues.Value[t];
        if tmp>=(tmpHigh+BoxSize) then
        begin
          if Draw then
             DrawColumn(FUp,tmpHigh+BoxSize,tmp,tmpX);
          tmpHigh:=tmp;
        end
        else
        begin
          tmp:=LowValues.Value[t];
          if tmp<=(tmpHigh-tmpDistance) then
          begin
            Inc(tmpCol);
            tmpLow:=tmp;
            if Draw then
            begin
              tmpX:=CalcXPosValue(tmpCol);
              DrawColumn(FDown,tmpLow,tmpHigh-BoxSize,tmpX);
            end;
            tmpIsDown:=True;
          end;
        end;
      end;
    end;
    result:=tmpCol+1;
  end
  else result:=0;
end;

procedure TPointFigureSeries.DrawAllValues;
begin
  CalcMaxColumns(True);
end;

function TPointFigureSeries.MaxXValue: Double;
begin
  result:=CalcMaxColumns-1;
end;

function TPointFigureSeries.MinXValue: Double;
begin
  result:=0;
end;

procedure TPointFigureSeries.SetBoxSize(const Value: Double);
begin
  SetDoubleProperty(FBoxSize,Value);
end;

procedure TPointFigureSeries.SetDown(const Value: TSeriesPointer);
begin
  FDown.Assign(Value);
end;

procedure TPointFigureSeries.SetReversal(const Value: Double);
begin
  SetDoubleProperty(FReversal,Value);
end;

procedure TPointFigureSeries.SetUp(const Value: TSeriesPointer);
begin
  FUp.Assign(Value);
end;

class function TPointFigureSeries.GetEditorClass: String;
begin
  result:='TPointFigureEditor';
end;

procedure TPointFigureEditor.FormShow(Sender: TObject);
begin
  PointFigure:=TPointFigureSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));
  if Assigned(PointFigure) then
  begin
    with PointFigure do
    begin
      EReversal.Text:=FloatToStr(ReversalAmount);
      EBoxSize.Text:=FloatToStr(BoxSize);
    end;

    if Assigned(Parent) then
    begin
      if not Assigned(UpForm) then
         UpForm:=TeeInsertPointerForm(Parent,PointFigure.UpSymbol,TeeMsg_Up);

      if not Assigned(DownForm) then
         DownForm:=TeeInsertPointerForm(Parent,PointFigure.DownSymbol,TeeMsg_Down);
    end;
  end;
end;

procedure TPointFigureEditor.EBoxSizeChange(Sender: TObject);
begin
  if Showing then
     PointFigure.BoxSize:=StrToFloatDef(EBoxSize.Text,PointFigure.BoxSize);
end;

procedure TPointFigureEditor.EReversalChange(Sender: TObject);
begin
  if Showing then
     PointFigure.ReversalAmount:=StrToFloatDef(EReversal.Text,PointFigure.ReversalAmount);
end;

function TPointFigureSeries.CountLegendItems: Integer;
begin
  result:=2;
end;

function TPointFigureSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  if LegendIndex=0 then result:=FUp.Brush.Color
                   else result:=FDown.Brush.Color
end;

function TPointFigureSeries.LegendString(LegendIndex: Integer;
  LegendTextStyle: TLegendTextStyle): String;
begin
  if LegendIndex=0 then result:=TeeMsg_Up
                   else result:=TeeMsg_Down;
end;

procedure TPointFigureSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    if Assigned(FUp) then FUp.ParentChart:=ParentChart;
    if Assigned(FDown) then FDown.ParentChart:=ParentChart;
  end;
end;

procedure TPointFigureSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  if not IsEnabled then
  begin
    DownSymbol.Color:=clSilver;
    DownSymbol.Pen.Color:=clGray;
    UpSymbol.Color:=clSilver;
    UpSymbol.Pen.Color:=clGray;
  end;
end;

initialization
  RegisterClass(TPointFigureEditor);
  RegisterTeeSeries( TPointFigureSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryPointFigure,
                                         {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);
finalization
  UnRegisterTeeSeries([TPointFigureSeries]);
end.
