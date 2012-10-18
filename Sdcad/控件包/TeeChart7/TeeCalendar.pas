{********************************************}
{    TeeChart Pro Charting Library           }
{    Calendar Series                         }
{  Copyright (c) 1995-2004 by David Berneda  }
{         All Rights Reserved                }
{********************************************}
unit TeeCalendar;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QButtons, QMenus, Types,
     {$ELSE}
     Buttons, Menus,
     {$ENDIF}
     Classes, SysUtils,
     TeeProcs, TeEngine, TeCanvas;

type
  TCalendarSeries=class;

  TCalendarCell=class(TTeeShape)
  public
    Parent : TCalendarSeries;
  published
    property Brush;
    property Font;
    property Gradient;
    property Pen;
    property Shadow;
    property Transparency;
    property Transparent stored True nodefault;  // 7.0
    property Visible;
  end;

  TCalendarCellUpper=class(TCalendarCell)
  private
    FUpper : Boolean;
    FFormat: String;
    procedure SetUpperCase(const Value: Boolean);
    procedure SetFormat(const Value: String);
  published
    property Format:String read FFormat write SetFormat;
    property UpperCase:Boolean read FUpper write SetUpperCase default False;
  end;

  TCalendarChangeEvent=Procedure(Sender:TCalendarSeries; Var Value:TDateTime) of object;

  TCalendarSeries=class(TChartSeries,ITeeEventListener)
  private
    FDate          : TDateTime;
    FDays          : TCalendarCell;
    FMonths        : TCalendarCellUpper;
    FNextMonth     : TSpeedButton;
    FOnChange      : TCalendarChangeEvent;
    FPopupMenu     : TPopupMenu;
    FPreviousMonth : TSpeedButton;
    FSunday        : TCalendarCell;
    FToday         : TCalendarCell;
    FTrailing      : TCalendarCell;
    FWeekDays      : TCalendarCellUpper;

    IColumns  : Integer;
    IFirstDay : Integer;
    IRows     : Integer;

    procedure ChangeMonthMenu(Sender: TObject);
    Function GetPopupMenu:TPopupMenu;
    procedure MonthClick(Sender: TObject);
    procedure SetDate(Value: TDateTime);
    procedure SetMonths(const Value: TCalendarCellUpper);
    procedure SetToday(const Value: TCalendarCell);
    procedure SetDays(const Value: TCalendarCell);
    procedure SetSunday(const Value: TCalendarCell);
    procedure SetTrailing(const Value: TCalendarCell);
    procedure SetWeekDays(const Value: TCalendarCellUpper);
    function GetNextVisible: Boolean;
    function GetPreviousVisible: Boolean;
    procedure SetNextVisible(const Value: Boolean);
    procedure SetPreviousVisible(const Value: Boolean);
  protected
    Procedure DrawAllValues; override;
    procedure DrawCell(Column,Row:Integer; Const Text:String);
    class function GetEditorClass: String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetActive(Value:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    procedure TeeEvent(Event:TTeeEvent); // ITeeEventListener interface
    Function XCell(Const Column:Double):Integer;
    Function YCell(Const Row:Double):Integer;
  public
    DayOneRow    : Integer;
    DayOneColumn : Integer;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure CheckClick(x,y:Integer);
    Function Clicked(x,y:Integer):Integer; override;
    Function Month:Word;
    Procedure NextMonth;
    Function NumSampleValues:Integer; override;
    Procedure PreviousMonth;
    Function RectCell(Column,Row:Integer):TRect;
    Function Rows:Integer;
    Function SeriesRect:TRect;
    Function UseAxis:Boolean; override;

    property Columns:Integer read IColumns;
    property NextMonthButton:TSpeedButton read FNextMonth; { 5.02 }
    property PopupMenu:TPopupMenu read GetPopupMenu;
    property PreviousMonthButton:TSpeedButton read FPreviousMonth;

  published
    property Active;
    property Cursor;
    property HorizAxis;
    property ParentChart;
    property Pen;
    property ShowInLegend;
    property Title;
    property VertAxis;

    property Date:TDateTime read FDate write SetDate;
    property Days:TCalendarCell read FDays write SetDays;
    property Months:TCalendarCellUpper read FMonths write SetMonths;
    property NextButtonVisible:Boolean read GetNextVisible write SetNextVisible default True;
    property PreviousButtonVisible:Boolean read GetPreviousVisible write SetPreviousVisible default True;
    property Sunday:TCalendarCell read FSunday write SetSunday;
    property Today:TCalendarCell read FToday write SetToday;
    property Trailing:TCalendarCell read FTrailing write SetTrailing;
    property WeekDays:TCalendarCellUpper read FWeekDays write SetWeekDays;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnChange:TCalendarChangeEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
  end;

implementation

Uses {$IFDEF CLX}
     QGraphics, QControls,
     {$ELSE}
     Graphics, Controls,
     {$ENDIF}
     TeeProCo, Chart;

{ TCalendarCellUpper }
procedure TCalendarCellUpper.SetFormat(const Value: String);
begin
  Parent.SetStringProperty(FFormat,Value);
end;

procedure TCalendarCellUpper.SetUpperCase(const Value: Boolean);
begin
  Parent.SetBooleanProperty(FUpper,Value);
end;

{ TCalendarSeries }
constructor TCalendarSeries.Create(AOwner: TComponent);
begin
  inherited;
  CalcVisiblePoints:=False;
  ShowInLegend:=False;
  AddNull;
  FDate:=SysUtils.Date;
  IColumns:=7;
  IRows:=8;

  {$IFDEF D6}
  {$WARN SYMBOL_PLATFORM OFF}
  {$ENDIF}

  {$IFDEF CLR}
  IFirstDay:=0;
  {$ELSE}
  {$IFDEF LINUX}
  IFirstDay:=0;
  {$ELSE}
  IFirstDay:=StrToIntDef(GetLocaleStr(GetThreadLocale, LOCALE_IFIRSTDAYOFWEEK, '0'), 0);
  {$ENDIF}
  {$ENDIF}

  FWeekDays:=TCalendarCellUpper.Create(nil);
  FWeekDays.Parent:=Self;
  FWeekDays.Pen.Hide;
  FWeekDays.Format:='ddd';

  FMonths:=TCalendarCellUpper.Create(nil);
  FMonths.Parent:=Self;
  FMonths.Transparent:=True;
  FMonths.Format:='mmmm, yyyy';

  FDays:=TCalendarCell.Create(nil);
  FDays.Parent:=Self;
  FDays.Transparent:=True;
  FToday:=TCalendarCell.Create(nil);
  FToday.Parent:=Self;
  FToday.Shadow.Size:=0;
  FToday.Font.Color:=clWhite;
  FToday.Color:=clBlue;
  FSunday:=TCalendarCell.Create(nil);
  FSunday.Parent:=Self;
  FSunday.Shadow.Size:=0;
  FSunday.Color:=clRed;
  FSunday.Font.Color:=clWhite;
  FTrailing:=TCalendarCell.Create(nil);
  FTrailing.Parent:=Self;
  FTrailing.Transparent:=True;
  FTrailing.Font.Color:=clDkGray;

  IUseSeriesColor:=False;
end;

Destructor TCalendarSeries.Destroy;
begin
  FWeekDays.Free;
  FMonths.Free;
  FDays.Free;
  FToday.Free;
  FSunday.Free;
  FTrailing.Free;
  FNextMonth.Free;
  FPreviousMonth.Free;
  FPopupMenu.Free;
  inherited;
end;

Function TCalendarSeries.XCell(Const Column:Double):Integer;
begin
  result:=GetHorizAxis.IStartPos+Round(Column*GetHorizAxis.IAxisSize/IColumns);
end;

Function TCalendarSeries.YCell(Const Row:Double):Integer;
begin
  result:=GetVertAxis.IStartPos+Round(Row*GetVertAxis.IAxisSize/Rows);
end;

Function TCalendarSeries.UseAxis:Boolean;
begin
  result:=False;
end;

Function TCalendarSeries.NumSampleValues:Integer;
begin
  result:=1;
end;

procedure TCalendarSeries.DrawAllValues;

  Procedure DrawGrid;
  var r,c,
      MinRowLines : Integer;
  begin
    if Pen.Visible then
    With ParentChart.Canvas do
    begin
      if WeekDays.Visible then MinRowLines:=1 else MinRowLines:=0;
      if Months.Visible then Inc(MinRowLines);
      AssignVisiblePen(Self.Pen);
      for c:=0 to IColumns do
          VertLine3D(XCell(c),YCell(MinRowLines),GetVertAxis.IEndPos,StartZ);
      for r:=MinRowLines to Rows do
          HorizLine3D(GetHorizAxis.IStartPos,GetHorizAxis.IEndPos,YCell(r),StartZ);
    end;
  end;

  Procedure DrawBack(ACell:TCalendarCell; Rect:TRect);
  begin
    Inc(Rect.Bottom);
    Dec(Rect.Bottom,ACell.Shadow.VertSize);
    Dec(Rect.Right,ACell.Shadow.HorizSize-1);
    ACell.DrawRectRotated(Rect,0,StartZ);
    ACell.ShapeBounds:=Rect; { 5.02 }
  end;

  Procedure DrawDay(ACell:TCalendarCell; c,r,d:Integer);
  begin
    if ACell.Visible then
    begin
      DrawBack(ACell,RectCell(c,r));
      ParentChart.Canvas.AssignFont(ACell.Font);
      With ParentChart.Canvas do
      begin
        TextAlign:=ta_Center;
        BackMode:=cbmTransparent;
      end;
      DrawCell(c,r,TeeStr(d));
    end;
  end;

var r,
    c,
    t,
    tmpPrevDays,
    tmpDays  : Integer;
    tmpToday,
    y,y2,
    m,m2,
    d        : Word;
    tmpSt    : String;

  Procedure NextDay;
  begin
    Inc(d);
    Inc(c);
    if c>IColumns then
    begin
      c:=1;
      Inc(r);
    end;
  end;

var Rect : TRect;
begin
  inherited;

  DecodeDate(Date,y,m,tmpToday);

  if WeekDays.Visible then
  begin
    With ParentChart.Canvas do
    begin
      AssignFont(WeekDays.Font);
      TextAlign:=ta_Center;
    end;
    r:=1;
    if Months.Visible then Inc(r);
    for c:=1 to IColumns do
    begin
      DrawBack(WeekDays,RectCell(c,r));
      ParentChart.Canvas.BackMode:=cbmTransparent;
      tmpSt:=FormatDateTime(WeekDays.Format,EncodeDate(1899,1,1+c+IFirstDay));
      if WeekDays.UpperCase then tmpSt:=UpperCase(tmpSt);
      DrawCell(c,r,tmpSt);
    end;
  end;

  if Months.Visible then
  begin
    With ParentChart.Canvas do
    begin
      AssignFont(Months.Font);
      TextAlign:=ta_Center;
    end;
    Rect:=SeriesRect;
    Rect.Bottom:=RectCell(4,1).Bottom;
    Rect.Top:=RectCell(4,0).Bottom;
    DrawBack(Months,Rect);
    ParentChart.Canvas.BackMode:=cbmTransparent;
    tmpSt:=FormatDateTime(Months.Format,Date);
    if Months.UpperCase then tmpSt:=UpperCase(tmpSt);
    DrawCell(4,1,tmpSt);
  end;

  DecodeDate(Date,y,m,tmpToday);

  d:=1;
  c:=DayOfWeek(EncodeDate(y,m,d))-1;
  if c=0 then c:=7;
  c:=1+((c+(7-IFirstDay)-1) mod IColumns);
  r:=3;
  if not WeekDays.Visible then Dec(r);
  if not Months.Visible then Dec(r);

  DayOneRow:=r;
  DayOneColumn:=c;

  tmpDays:=DaysInMonth(y,m);

  if Trailing.Visible and (c>1) then
  begin
    m2:=m-1;
    y2:=y;
    if m2=0 then
    begin
      m2:=12;
      Dec(y2);
    end;
    tmpPrevDays:=DaysInMonth(y2,m2);
    for t:=1 to c-1 do DrawDay(Trailing,t,r,tmpPrevDays-(c-t)+1);
  end;

  Repeat
    if (d=tmpToday) and Today.Visible then DrawDay(Today,c,r,d)
    else
    if DayOfWeek(EncodeDate(y,m,d))=1 then DrawDay(Sunday,c,r,d)
    else
      DrawDay(Days,c,r,d);

    NextDay;
  Until d>tmpDays;

  if Trailing.Visible and ((c<=IColumns) or (r<Rows)) then
  begin
    Inc(m);
    d:=1;
    While (c<=IColumns) and (r<=Rows) do
    begin
      DrawDay(Trailing,c,r,d);
      NextDay;
    end;
  end;

  if Pen.Visible then DrawGrid;
end;

{$IFNDEF CLR}
type
  TCustomTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Procedure TCalendarSeries.SetParentChart(Const Value:TCustomAxisPanel);

  Function CreateButton(Const ACaption:String; ALeftPos:Integer):TSpeedButton;
  begin
    result:=TSpeedButton.Create(Self);
    with result do
    begin
      Caption:=ACaption;
      Flat:=True;
      Parent:=ParentChart;
      Top:=6;
      Left:=ALeftPos;
      OnClick:=MonthClick;
    end;
  end;

begin
  if Assigned(ParentChart) then
     {$IFNDEF CLR}TCustomTeePanelAccess{$ENDIF}(ParentChart).RemoveListener(Self);

  inherited;

  if not (csDestroying in ComponentState) then
  begin
    FMonths.ParentChart:=ParentChart;
    FDays.ParentChart:=ParentChart;
    FSunday.ParentChart:=ParentChart;
    FToday.ParentChart:=ParentChart;
    FTrailing.ParentChart:=ParentChart;
    FWeekDays.ParentChart:=ParentChart;

    FreeAndNil(FNextMonth);
    FreeAndNil(FPreviousMonth);

    if Assigned(ParentChart) then
    begin
      {$IFNDEF CLR}TCustomTeePanelAccess{$ENDIF}(ParentChart).Listeners.Add(Self);

      FNextMonth:=CreateButton('>',30);
      FPreviousMonth:=CreateButton('<',6);
    end;
  end;
end;

procedure TCalendarSeries.DrawCell(Column,Row:Integer; Const Text:String);
begin
  With ParentChart.Canvas do
       TextOut(XCell(Column-0.5),YCell(Row-0.5)-(FontHeight div 2),Text);
end;

procedure TCalendarSeries.SetDate(Value: TDateTime);
begin
  if Assigned(FOnChange) and (Value<>Date) then FOnChange(Self,Value);

  if Value<>FDate then
  begin
    FDate:=Value;
    Repaint;
  end;
end;

procedure TCalendarSeries.SetDays(const Value: TCalendarCell);
begin
  FDays.Assign(Value);
end;

procedure TCalendarSeries.SetMonths(const Value: TCalendarCellUpper);
begin
  FMonths.Assign(Value);
end;

procedure TCalendarSeries.SetWeekDays(const Value: TCalendarCellUpper);
begin
  FWeekDays.Assign(Value);
end;

Function TCalendarSeries.RectCell(Column,Row:Integer):TRect;
begin
  with result do
  begin
    Left:=XCell(Column-1)+1;
    Right:=XCell(Column)-1;
    Top:=YCell(Row-1)+1;
    Bottom:=YCell(Row)-1;
  end;
end;

procedure TCalendarSeries.SetSunday(const Value: TCalendarCell);
begin
  FSunday.Assign(Value);
end;

procedure TCalendarSeries.SetToday(const Value: TCalendarCell);
begin
  FToday.Assign(Value);
end;

procedure TCalendarSeries.SetTrailing(const Value: TCalendarCell);
begin
  FTrailing.Assign(Value);
end;

procedure TCalendarSeries.NextMonth;
begin
  Date:=IncMonth(Date,1);
end;

procedure TCalendarSeries.PreviousMonth;
begin
  Date:=IncMonth(Date,-1);
end;

Function TCalendarSeries.Month:Word;
var y,d:Word;
begin
  DecodeDate(Date,y,result,d);
end;

procedure TCalendarSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  Pen.Hide;
  Days.Font.Size:=6;
  Months.Hide;
  WeekDays.Font.Size:=5;
  WeekDays.Shadow.Size:=0;
  Sunday.Font.Size:=6;
  Today.Font.Size:=6;
  Trailing.Hide;
  NextMonthButton.Visible:=False;
  PreviousMonthButton.Visible:=False;
end;

class function TCalendarSeries.GetEditorClass: String;
begin
  result:='TCalendarSeriesEditor';
end;

function TCalendarSeries.Rows: Integer;
begin
  result:=IRows;
  if not WeekDays.Visible then Dec(result);
  if not Months.Visible then Dec(result);
end;

function TCalendarSeries.Clicked(x,y: Integer): Integer;
begin
  if Active and { 5.01 }
     PointInRect(SeriesRect,x,y) then result:=0 else result:=-1;
end;

Function TCalendarSeries.SeriesRect:TRect;
var tmpRowSize : Integer;
begin
  With GetHorizAxis do
  begin
    Result.Left:=IStartPos;
    Result.Right:=IEndPos;
  end;
  With GetVertAxis do
  begin
    Result.Top:=IStartPos;
    Result.Bottom:=IEndPos;
  end;
  tmpRowSize:=Round(GetVertAxis.IAxisSize/IRows);
  if WeekDays.Visible then Inc(Result.Top,tmpRowSize);
  if Months.Visible then Inc(Result.Top,tmpRowSize);
end;

Procedure TCalendarSeries.CheckClick(x,y:Integer);

 Function CellDate(ACol,ARow:Integer):TDateTime;
 var y,
     m,
     d,
     tmpD : Word;
 begin
   result:=Date;
   DecodeDate(Date,y,m,d);
   if ARow=DayOneRow then
   begin
     if ACol>=DayOneColumn then
        result:=EncodeDate(y,m,ACol-DayOneColumn+1)
     else
     if Trailing.Visible then
     begin
       { previous month }
       Dec(m);
       if m=0 then
       begin
         m:=12;
         Dec(y);
       end;
       tmpD:=1+DaysInMonth(y,m)-DayOneColumn+ACol;
       result:=EncodeDate(y,m,tmpD);
     end;
   end
   else
   if ARow>DayOneRow then
   begin
     tmpD:=(7*(ARow-DayOneRow))+ACol-DayOneColumn+1;
     if tmpD>DaysInMonth(y,m) then
     begin
       { next month... }
       if Trailing.Visible then
       begin
         Dec(tmpD,DaysInMonth(y,m));
         Inc(m);
         if m>12 then
         begin
           m:=1;
           Inc(y);
         end;
       end
       else exit;
     end;
     result:=EncodeDate(y,m,tmpD);
   end;
 end;

var tmpC : Integer;
    tmpR : Integer;
begin
  if PointInRect(Months.ShapeBounds,X,Y) then
     with ParentChart.ClientToScreen(TeePoint(X,Y)) do
          PopupMenu.Popup(x,y) { 5.02 }
  else
  if Clicked(x,y)=0 then
  begin
    tmpC:=1+Trunc((x-GetHorizAxis.IStartPos)/(GetHorizAxis.IAxisSize/Columns));
    tmpR:=1+Trunc((y-GetVertAxis.IStartPos)/(GetVertAxis.IAxisSize/Rows));
    Date:=CellDate(tmpC,tmpR);
  end;
end;

procedure TCalendarSeries.TeeEvent(Event: TTeeEvent);
begin
  if (Event is TTeeMouseEvent) then
  With TTeeMouseEvent(Event) do
       if (Event=meDown) and (Button=mbLeft) then
          Self.CheckClick(x,y);
end;

procedure TCalendarSeries.MonthClick(Sender: TObject); { 5.02 }
begin
  if Sender=FNextMonth then NextMonth
                       else PreviousMonth;
end;

procedure TCalendarSeries.ChangeMonthMenu(Sender: TObject); { 5.02 }
var tmp     : Integer;
    tmpDays : Integer;
    y,
    m,
    d       : Word;
begin
  tmp:=TMenuItem(Sender).MenuIndex;
  DecodeDate(Date,y,m,d);
  m:=tmp+1;
  tmpDays:=DaysInMonth(y,m);
  if d>tmpDays then d:=tmpDays;
  Date:=EncodeDate(y,m,d);
end;

Function TCalendarSeries.GetPopupMenu:TPopupMenu;
var tmp : TMenuItem;
   t   : Integer;
begin
 if not Assigned(FPopupMenu) then
 begin { first time, do creation }
   result:=TPopupMenu.Create({$IFDEF TEEOCX}ParentChart{$ELSE}nil{$ENDIF});
   { add 12 months }
   for t:=1 to 12 do
   begin
     tmp:=TMenuItem.Create(nil);
     tmp.Caption:=LongMonthNames[t];
     tmp.OnClick:=ChangeMonthMenu;
     result.Items.Add(tmp);
   end;
 end
 else result:=FPopupMenu; { already existing popup }
end;

function TCalendarSeries.GetNextVisible: Boolean;
begin
  result:=NextMonthButton.Visible;
end;

function TCalendarSeries.GetPreviousVisible: Boolean;
begin
  result:=PreviousMonthButton.Visible;
end;

procedure TCalendarSeries.SetNextVisible(const Value: Boolean);
begin
  NextMonthButton.Visible:=Value;
end;

procedure TCalendarSeries.SetPreviousVisible(const Value: Boolean);
begin
  PreviousMonthButton.Visible:=Value;
end;

procedure TCalendarSeries.SetActive(Value: Boolean);
begin
  inherited;
  // 6.01
  if Assigned(FNextMonth) then FNextMonth.Visible:=Visible;
  if Assigned(FPreviousMonth) then FPreviousMonth.Visible:=Visible;
end;

initialization
  RegisterTeeSeries( TCalendarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_CalendarSeries,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([TCalendarSeries]);
end.
