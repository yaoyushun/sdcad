{**********************************************}
{   TCustomBoxSeries                           }
{     TBoxSeries                               }
{     THorizBoxSeries                          }
{                                              }
{   Copyright (c) 2000-2004 by                 }
{   Marjan Slatinek and David Berneda          }
{**********************************************}
unit TeeBoxPlot;
{$I TeeDefs.inc}

interface

Uses {$IFDEF CLR}
     Classes,
     Graphics,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, SysUtils,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$ENDIF}
     Chart, Series, TeEngine, TeCanvas;

type
   TCustomBoxSeries=class(TPointSeries)
   private
     FExtrOut       : TSeriesPointer;
     FMedianPen     : TChartPen;
     FMildOut       : TSeriesPointer;
     FPosition      : Double;
     FWhiskerLength : Double;
     FWhiskerPen    : TChartPen;
     IVertical      : Boolean;

     FUseCustomValues: boolean;
     FMedian: double;
     FQuartile1: double;
     FQuartile3: double;
     FInnerFence1: double;
     FInnerFence3: double;
     FOuterFence1: double;
     FOuterFence3: double;
     FAdjacentPoint1: integer;
     FAdjacentPoint3: integer;
     Function GetBox:TSeriesPointer;
     procedure SetExtrOut(Value: TSeriesPointer);
     procedure SetMedianPen(Value: TChartPen);
     procedure SetMildOut(Value: TSeriesPointer);
     procedure SetPosition(Const Value: Double);
     procedure SetWhiskerLength(Const Value: Double);
     procedure SetWhiskerPen(Value: TChartPen);
     procedure SetUseCustomValues(const Value: boolean);
     procedure SetMedian(const Value: double);
     procedure SetQuartile1(const Value: double);
     procedure SetQuartile3(const Value: double);
     procedure SetInnerFence1(const Value: double);
     procedure SetInnerFence3(const Value: double);
     procedure SetOuterFence1(const Value: double);
     procedure SetOuterFence3(const Value: double);
     procedure SetAdjacentPoint1(const Value: integer);
     procedure SetAdjacentPoint3(const Value: integer);
   protected
     procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
     procedure DoBeforeDrawValues; override;
     procedure DrawAllValues; override;
     procedure DrawMark( ValueIndex:Integer; Const St:String;
                                    APosition:TSeriesMarkPosition); override;
     procedure DrawValue(ValueIndex: Integer); override;
     class Function GetEditorClass:String; override;
     function  GetSampleValues: TChartValueList; virtual;
     procedure PrepareForGallery(IsEnabled:Boolean); override;
     procedure SetParentChart(Const Value: TCustomAxisPanel); override;
     procedure SetSampleValues(Value: TChartValueList); virtual;
   public
     Constructor Create(AOwner: TComponent); override;
     Destructor Destroy; override;
     Procedure Assign(Source:TPersistent); override;

     property Box:TSeriesPointer read GetBox;
     { MS : Added to support custom values }
     property Median: double read FMedian write SetMedian;
     property Quartile1: double read FQuartile1 write SetQuartile1;
     property Quartile3: double read FQuartile3 write SetQuartile3;
     property InnerFence1: double read FInnerFence1 write SetInnerFence1;
     property InnerFence3: double read FInnerFence3 write SetInnerFence3;
     property OuterFence1: double read FOuterFence1 write SetOuterFence1;
     property OuterFence3: double read FOuterFence3 write SetOuterFence3;
     property AdjacentPoint1 : integer read FAdjacentPoint1 write SetAdjacentPoint1;
     property AdjacentPoint3 : integer read FAdjacentPoint3 write SetAdjacentPoint3;
   published
     property ExtrOut       : TSeriesPointer read FExtrOut write SetExtrOut;
     property MedianPen     : TChartPen read FMedianPen write SetMedianPen;
     property MildOut       : TSeriesPointer read FMildOut write SetMildOut;
     property Position      : Double read FPosition write SetPosition;
     property SampleValues  : TChartValueList read GetSampleValues write SetSampleValues;
     property WhiskerLength : Double read FWhiskerLength write SetWhiskerLength;
     property WhiskerPen    : TChartPen read FWhiskerPen write SetWhiskerPen;
     property UseCustomValues : boolean read FUseCustomValues write SetUseCustomValues default false;
   end;

   { Vertical Box Series }
   TBoxSeries=class(TCustomBoxSeries)
   public
     Function MaxXValue:Double; override;
     Function MinXValue:Double; override;
   end;

   { Horizontal Box Series }
   THorizBoxSeries=class(TCustomBoxSeries)
   public
     Constructor Create(AOwner:TComponent); override;
     Function MaxYValue:Double; override;
     Function MinYValue:Double; override;
   end;

implementation

Uses {$IFDEF CLR}
     SysUtils,
     {$ENDIF}
     TeeProCo;

{ TCustomBoxSeries }
Constructor TCustomBoxSeries.Create(AOwner: TComponent);
begin
  inherited;
  AllowSinglePoint:=False;
  CalcVisiblePoints:=False;
  XValues.Name:='';
  YValues.Name:='Samples';   { <- do not translate }
  Marks.Visible:=False;
  Marks.Callout.Length:=0;
  FUseCustomValues := false; { MS : added to support custom values }

  FWhiskerLength:=1.5;
  FMildOut:=TSeriesPointer.Create(Self);
  FMildOut.Style:=psCircle;
  FExtrOut:=TSeriesPointer.Create(Self);
  FExtrOut.Style:=psStar;

  With Pointer do
  begin
    Draw3D:=False;
    Pen.Width:=1;
    VertSize:=15;
    HorizSize:=15;
    Brush.Color:=clWhite;
  end;

  FWhiskerPen:=CreateChartPen;

  FMedianPen:=CreateChartPen;
  FMedianPen.Width:=1;
  FMedianPen.Style:=psDot;

  IVertical:=True;
end;

Destructor TCustomBoxSeries.Destroy;
begin
  FMedianPen.Free;
  FWhiskerPen.Free;
  FreeAndNil(FExtrOut);
  FreeAndNil(FMildOut);
  inherited;
end;

procedure TCustomBoxSeries.SetWhiskerLength(Const Value: Double);
begin
  SetDoubleProperty(FWhiskerLength,Value);
end;

function TCustomBoxSeries.GetSampleValues;
begin
  result:=MandatoryValueList;
end;

procedure TCustomBoxSeries.SetSampleValues(Value: TChartValueList);
begin
  if IVertical then YValues:=Value else XValues:=Value;
end;

procedure TCustomBoxSeries.SetPosition(Const Value: Double);
begin
  SetDoubleProperty(FPosition,Value);
end;

procedure TCustomBoxSeries.SetWhiskerPen(Value: TChartPen);
begin
  FWhiskerPen.Assign(Value);
end;

procedure TCustomBoxSeries.SetMedianPen(Value: TChartPen);
begin
  FMedianPen.Assign(Value);
end;

procedure TCustomBoxSeries.SetMildOut(Value: TSeriesPointer);
begin
  FMildOut.Assign(Value);
end;

procedure TCustomBoxSeries.SetExtrOut(Value: TSeriesPointer);
begin
  FExtrOut.Assign(Value);
end;

procedure TCustomBoxSeries.DoBeforeDrawValues; { 5.02 - new calculation algorithm }
var N       : Integer;
    i       : Integer;
    FIqr    : Double;
    FMed    : Integer;
    InvN    : Double;

    { Calculate 1st and 3rd quartile }
    function Percentile(Const P: double): double;
    var QQ,
        OldQQ,
        U      : Double;
    begin
     i := 0;
     QQ := 0.0;
     OldQQ := 0.0;
     while QQ < P do
     begin
      OldQQ := QQ;
      QQ := (0.5+i)*InvN;
      Inc(i);
     end;
     U := (P-OldQQ)/(QQ-OldQQ);
     Result := SampleValues[i-2] + (SampleValues[i-1]-SampleValues[i-2])*U;
  end;

begin
  inherited;
  { if custom values are used, or there are no points, skip the recalculation }
  if (Not FUseCustomValues) and (SampleValues.Count>0) then
  begin
     N:=SampleValues.Count;
     InvN := 1.0/N;
     { calculate median }
     FMed := N div 2;
     if Odd(N) then FMedian := SampleValues[FMed]
     else FMedian := 0.5* (SampleValues[FMed-1] + SampleValues[FMed]);

     { calculate Q1 and Q3 }
     FQuartile1 := Percentile(0.25);
     FQuartile3 := Percentile(0.75);

     { calculate IQR }
     FIqr:=FQuartile3-FQuartile1;
     FInnerFence1:=FQuartile1-FWhiskerLength*FIqr;
     FInnerFence3:=FQuartile3+FWhiskerLength*FIqr;

     { find adjacent points }
     for i := 0 to N-1 do if FInnerFence1<=SampleValues.Value[i] then Break;
     FAdjacentPoint1:=i;

     for i := FMed to N-1 do if FInnerFence3<=SampleValues.Value[i] then Break;
     FAdjacentPoint3 := i-1;

     { calculate outer fences }
     FOuterFence1:=FQuartile1-2*FWhiskerLength*FIqr;
     FOuterFence3:=FQuartile3+2*FWhiskerLength*FIqr;
  end;
end;

procedure TCustomBoxSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  with APosition do
  if IVertical then
  begin
    ArrowTo.X:=CalcXPosValue(FPosition);
    ArrowFrom.X:=ArrowTo.X;
    LeftTop.X:=ArrowTo.X - (Width div 2);
  end
  else
  begin
    ArrowTo.Y:=CalcYPosValue(FPosition);
    ArrowFrom.Y:=ArrowTo.Y;
    LeftTop.Y:=ArrowTo.Y - (Height div 2);
  end;

  inherited;
end;

procedure TCustomBoxSeries.DrawValue(ValueIndex:Integer);
var tmpColor : TColor;
    tmpVal   : Double;
    tmp      : TSeriesPointer;
begin
  tmpVal:=SampleValues.Value[ValueIndex];

  { inside inner fences - no point }
  if (tmpVal>=FInnerFence1) and (tmpVal<=FInnerFence3) then tmp:=nil
  { mild outlined points }
  else
  if ((tmpVal>=FInnerFence3) and (tmpVal<=FOuterFence3)) or ((tmpVal<=FInnerFence1) and (tmpVal>=FOuterFence1)) then
     tmp:=FMildOut
  else
    { extreme outlined points }
    tmp:=FExtrOut;

  if Assigned(tmp) then
    with tmp do
    if Visible then
    begin
      tmpColor:=ValueColor[ValueIndex];
      PrepareCanvas(ParentChart.Canvas,tmpColor);
      if IVertical then Draw(CalcXPosValue(FPosition),CalcYPos(ValueIndex),tmpColor,Style)
                   else Draw(CalcXPos(ValueIndex),CalcYPosValue(FPosition),tmpColor,Style)
    end;
end;

procedure TCustomBoxSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t : Integer;
    n : Integer;
begin
  t:=ParentChart.SeriesCount+1;
  n:=t*(3+RandomValue(10));
  Add(-n);
  for t:=2 to NumValues-2 do Add(n*t/NumValues);
  Add(2*n);
end;

procedure TCustomBoxSeries.PrepareForGallery(IsEnabled:Boolean);
var t : Integer;
begin
  inherited;
  { by default display 2 series}
  for t:=0 to ParentChart.SeriesCount-1 do
  if ParentChart.Series[t] is TCustomBoxSeries then
  with TCustomBoxSeries(ParentChart.Series[t]) do
  begin
    FPosition:=t+1;
    Pointer.HorizSize:=12;
    MildOut.HorizSize:=3;
    ExtrOut.VertSize:=3;
    FillSampleValues(10*(t+1));
  end;
end;

procedure TCustomBoxSeries.DrawAllValues;
Var tmp  : Integer;
    tmp1 : Integer;
    tmpZ : Integer;

  Function CalcPos(Const Value:Double):Integer;
  begin
    if IVertical then result:=CalcYPosValue(Value)
                 else result:=CalcXPosValue(Value);
  end;

  Procedure DrawWhisker(AIndex,Pos:Integer);
  var tmp2 : Integer;
  begin
    tmp2:=CalcPos(SampleValues.Value[AIndex]);
    With ParentChart,Canvas do
    if View3D then
    begin
      if IVertical then
      begin
        VertLine3D(tmp1,Pos,tmp2,tmpZ);
        HorizLine3D(tmp1-tmp,tmp1+tmp,tmp2,tmpZ);
      end
      else
      begin
        HorizLine3D(Pos,tmp2,tmp1,tmpZ);
        VertLine3D(tmp2,tmp1-tmp,tmp1+tmp,tmpZ);
      end;
    end
    else
    if IVertical then
    begin
      DoVertLine(tmp1,Pos,tmp2);
      DoHorizLine(tmp1-tmp,tmp1+tmp,tmp2);
    end
    else
    begin
      DoHorizLine(Pos,tmp2,tmp1);
      DoVertLine(tmp2,tmp1-tmp,tmp1+tmp);
    end;
  end;

var AL,AT,AR,AB,
    tmpH,tmpV,
    tmpA1,tmpA2 : Integer;
begin
  inherited;

  if IVertical then
  begin
    tmp:=Pointer.HorizSize; // 6.0
    AL:=CalcXPosValue(FPosition)-tmp;
    AR:=CalcXPosValue(FPosition)+tmp;
    AT:=CalcYPosValue(FQuartile3);
    AB:=CalcYPosValue(FQuartile1);
    tmpA1:=AB;
    tmpA2:=AT;
  end
  else
  begin
    tmp:=Pointer.HorizSize; // 6.0
    AT:=CalcYPosValue(FPosition)-tmp;
    AB:=CalcYPosValue(FPosition)+tmp;
    AR:=CalcXPosValue(FQuartile3);
    AL:=CalcXPosValue(FQuartile1);
    tmpA1:=AL;
    tmpA2:=AR;
  end;

  if GetHorizAxis.Inverted then SwapInteger(AL,AR);
  if GetVertAxis.Inverted then SwapInteger(AT,AB);

  With ParentChart,Canvas do
  begin
    with Pointer do (* box *)
    if Visible then
    begin
      PrepareCanvas(ParentChart.Canvas,Color);;
      if IVertical then
      begin
        tmpV:=(AB-AT) div 2;
        DrawPointer(Canvas,View3D,AL+tmp-1,AT+tmpV,HorizSize-1,tmpV-1,Brush.Color,Style);
      end
      else
      begin
        tmpH:=(AR-AL) div 2;
        DrawPointer(Canvas,View3D,AL+tmpH,AT+tmp-1,tmpH-1,VertSize-1,Brush.Color,Style);
      end;
    end;

    (* median *)
    if FMedianPen.Visible then
    begin
      AssignVisiblePen(FMedianPen);
      Brush.Style:=bsClear;
      tmpV:=CalcPos(FMedian);
      if IVertical then
         if View3D then HorizLine3D(AL,AR,tmpV,StartZ)
                   else DoHorizLine(AL,AR,tmpV)
      else
         if View3D then VertLine3D(tmpV,AT,AB,StartZ)
                   else DoVertLine(tmpV,AT,AB);
    end;

    (* whiskers *)
    if FWhiskerPen.Visible then
    begin
      if Pointer.Visible and Pointer.Draw3D then tmpZ:=MiddleZ else tmpZ:=StartZ;
      AssignVisiblePen(FWhiskerPen);
      if IVertical then tmp1:=(AL+AR) div 2
                   else tmp1:=(AT+AB) div 2;
      DrawWhisker(FAdjacentPoint1,tmpA1);
      DrawWhisker(FAdjacentPoint3,tmpA2);
    end;
  end;
end;

procedure TCustomBoxSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    if Assigned(FExtrOut) then FExtrOut.ParentChart:=Value;
    if Assigned(FMildOut) then FMildOut.ParentChart:=Value;
  end;
end;

class function TCustomBoxSeries.GetEditorClass: String;
begin
  result:='TBoxSeriesEditor';
end;

function TCustomBoxSeries.GetBox: TSeriesPointer;
begin
  result:=Pointer;
end;

procedure TCustomBoxSeries.Assign(Source: TPersistent);
begin
  if Source is TCustomBoxSeries then
  With TCustomBoxSeries(Source) do
  begin
     Self.ExtrOut        :=ExtrOut;
     Self.MedianPen      :=MedianPen;
     Self.MildOut        :=MildOut;
     Self.FPosition      :=Position;
     Self.FWhiskerLength :=FWhiskerLength;
     Self.WhiskerPen     :=WhiskerPen;
     Self.FUseCustomValues := FUseCustomValues;
  end;
  inherited;
end;

procedure TCustomBoxSeries.SetUseCustomValues(const Value: boolean);
begin
  FUseCustomValues := Value;
end;

procedure TCustomBoxSeries.SetMedian(const Value: double);
begin
  FMedian := Value;
end;

procedure TCustomBoxSeries.SetQuartile1(const Value: double);
begin
  FQuartile1 := Value;
end;

procedure TCustomBoxSeries.SetQuartile3(const Value: double);
begin
  FQuartile3 := Value;
end;

procedure TCustomBoxSeries.SetInnerFence1(const Value: double);
begin
  FInnerFence1 := Value;
end;

procedure TCustomBoxSeries.SetInnerFence3(const Value: double);
begin
  FInnerFence3 := Value;
end;

procedure TCustomBoxSeries.SetOuterFence1(const Value: double);
begin
  FOuterFence1 := Value;
end;

procedure TCustomBoxSeries.SetOuterFence3(const Value: double);
begin
  FOuterFence3 := Value;
end;

procedure TCustomBoxSeries.SetAdjacentPoint1(const Value: integer);
begin
  FAdjacentPoint1 := Value;
end;

procedure TCustomBoxSeries.SetAdjacentPoint3(const Value: integer);
begin
  FAdjacentPoint3 := Value;
end;

{ TBoxSeries }
function TBoxSeries.MaxXValue: Double;
begin
  result:=FPosition;
end;

function TBoxSeries.MinXValue: Double;
begin
  result:=FPosition;
end;

{ THorizBoxSeries}
Constructor THorizBoxSeries.Create(AOwner:TComponent);
begin
  inherited;
  SetHorizontal;
  IVertical:=False;
end;

function THorizBoxSeries.MaxYValue: Double;
begin
  result:=FPosition;
end;

function THorizBoxSeries.MinYValue: Double;
begin
  result:=FPosition;
end;

initialization
  RegisterTeeSeries(TBoxSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBoxPlot,
                                {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,2);
  RegisterTeeSeries(THorizBoxSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHorizBoxPlot,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,2);
finalization
  UnRegisterTeeSeries([TBoxSeries,THorizBoxSeries]);
end.
