{******************************************}
{ TeeChart OHLC Compression Function       }
{ Copyright (c) 2000-2004 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeCompressOHLC;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QForms, QControls, QStdCtrls, QComCtrls,
     {$ELSE}
     Forms, Controls, StdCtrls, ComCtrls,
     {$ENDIF}
     TeEngine, OHLChart, TeeBaseFuncEdit, TeCanvas;

{
  This unit contains a "TeeFunction" ( TCompressOHLCFunction class )

  The purpose of this function is to "compress" an OHLC series
  (for example a financial Candle series).

  ( OHLC stands for "Open High Low Close" in financial terms )

  To "compress" means to find out the OHLC of a date-time period from
  the original data.

  This function also works with non-OHLC source series.

}

type
  TCompressFuncEditor = class(TBaseFunctionEditor)
    CBDatePeriod: TComboFlat;
    RadioDate: TRadioButton;
    ENum: TEdit;
    RadioPoints: TRadioButton;
    UpDown1: TUpDown;
    RadioTime: TRadioButton;
    CBTimePeriod: TComboFlat;
    procedure CBDatePeriodChange(Sender: TObject);
    procedure RadioDateClick(Sender: TObject);
    procedure RadioPointsClick(Sender: TObject);
    procedure ENumChange(Sender: TObject);
    procedure ENumClick(Sender: TObject);
    procedure CBDatePeriodClick(Sender: TObject);
    procedure RadioTimeClick(Sender: TObject);
    procedure CBTimePeriodChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    procedure SetFunction; override;
  public
    { Public declarations }
  end;

  TCompressionPeriod=( ocDay, ocWeek, ocMonth, ocBiMonth, ocQuarter, ocYear,
                       ocSecond, ocTenSecond, ocMinute, ocTwoMinutes,
                       ocFiveMinutes, ocTenMinutes, ocFifteenMinutes,
                       ocTwentyMinutes, ocHalfHour, ocHour, ocTwoHours,
                       ocThreeHour, ocSixHour, ocTwelveHour);

  TCompressGetDate=procedure(Sender:TTeeFunction; Source:TChartSeries;
                             ValueIndex:Integer; Var Date:TDateTime) of object;

  TCompressFunction=class(TTeeFunction)
  private
    FCompress: TCompressionPeriod;
    FOnGetDate: TCompressGetDate;
    procedure SetCompress(const Value: TCompressionPeriod);
  protected
    class function GetEditorClass: String; override;
    class procedure PrepareForGallery(Chart:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source: TChartSeries); override;

    Procedure CompressSeries(Source:TChartSeries;
                             DestOHLC:TOHLCSeries;
                             Volume:TChartSeries=nil;
                             DestVolume:TChartSeries=nil);
  published
    property Compress:TCompressionPeriod read FCompress write SetCompress default ocWeek;
    property OnGetDate:TCompressGetDate read FOnGetDate write FOnGetDate;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  {$IFDEF D6}
  DateUtils,
  {$ENDIF}
  SysUtils, Chart, TeeProCo, CandleCh;

{ TCompressFunction }

constructor TCompressFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
  HideSourceList:=True;
  FCompress:=ocWeek;
end;

class function TCompressFunction.GetEditorClass: String;
begin
  result:='TCompressFuncEditor';
end;

procedure TCompressFunction.AddPoints(Source: TChartSeries);
begin
  if ParentSeries is TOHLCSeries then
     CompressSeries(Source,TOHLCSeries(ParentSeries),nil,nil);
end;

Procedure TCompressFunction.CompressSeries(Source:TChartSeries;
                                           DestOHLC:TOHLCSeries;
                                           Volume:TChartSeries=nil;
                                           DestVolume:TChartSeries=nil);
var t        : Integer;
    tmpGroup : Integer;
    OldGroup : Integer;
    tmp      : Integer;
    Year     : Word;
    Month    : Word;
    Day      : Word;
    Hour     : Word;
    Minute   : Word;
    Second   : Word;
    MilliSecond : Word;
    DoIt     : Boolean;
    tmpDate  : TDateTime;
    tmpValue : TChartValue;
    tmpList  : TChartValueList;
    tmpPeriod : Integer;
begin
  DestOHLC.Clear;
  if Assigned(DestVolume) then DestVolume.Clear;

  OldGroup:=0;

  tmpList:=ValueList(Source);
  tmpPeriod:=Round(Period);

  for t:=0 to Source.Count-1 do
  begin
    tmpDate:=Source.NotMandatoryValueList.Value[t];

    if tmpPeriod=0 then
    begin

      // user event
      if Assigned(FOnGetDate) then FOnGetDate(Self,Source,t,tmpDate);

      {$IFDEF D6}
      DecodeDateTime(tmpDate,Year,Month,Day,Hour,Minute,Second,MilliSecond);
      {$ELSE}
      DecodeDate(tmpDate,Year,Month,Day);
      DecodeTime(tmpDate,Hour,Minute,Second,MilliSecond);
      {$ENDIF}

      case Compress of
       // Date
         ocDay: tmpGroup:=Trunc(tmpDate);
        ocWeek: begin
                  tmpGroup:=DayOfWeek(tmpDate)-1;
                  if tmpGroup=0 then tmpGroup:=7;
                end;
       ocMonth: tmpGroup:=Month;
     ocBiMonth: tmpGroup:=(Month-1) div 2;
     ocQuarter: tmpGroup:=(Month-1) div 3;
        ocYear: tmpGroup:=Year;

     // Time

      ocSecond: tmpGroup:=Second;
   ocTenSecond: tmpGroup:=Second div 10;
      ocMinute: tmpGroup:=Minute;
  ocTwoMinutes: tmpGroup:=Minute div 2;
 ocFiveMinutes: tmpGroup:=Minute div 5;
  ocTenMinutes: tmpGroup:=Minute div 10;
ocFifteenMinutes: tmpGroup:=Minute div 15;
ocTwentyMinutes: tmpGroup:=Minute div 20;
    ocHalfHour: tmpGroup:=Minute div 30;
        ocHour: tmpGroup:=Hour;
    ocTwoHours: tmpGroup:=Hour div 2;
   ocThreeHour: tmpGroup:=Hour div 3;
     ocSixHour: tmpGroup:=Hour div 6;
     else
       // ocTwelveHour:
       tmpGroup:=Hour div 12;
      end;

      if Compress=ocWeek then DoIt:=tmpGroup<OldGroup
                         else DoIt:=tmpGroup<>OldGroup;

      OldGroup:=tmpGroup;
    end
    else DoIt:=(t mod tmpPeriod)=0;

    if (t=0) or DoIt then
    begin

      case PeriodAlign of
        paFirst: ;
        paCenter: ;
      else
        // paLast:
        
      end;

      if Source is TOHLCSeries then
      With TOHLCSeries(Source) do
        tmp:=DestOHLC.AddOHLC(
                  tmpDate,
                  OpenValues.Value[t],
                  HighValues.Value[t],
                  LowValues.Value[t],
                  CloseValues.Value[t])
      else
      With Source do
      begin
        tmpValue:=tmpList.Value[t];
        tmp:=DestOHLC.AddOHLC(
                  tmpDate,
                  tmpValue,
                  tmpValue,
                  tmpValue,
                  tmpValue);
      end;

      DestOHLC.Labels[tmp]:=Source.Labels[t];

      if Assigned(DestVolume) then
         DestVolume.AddXY(Source.NotMandatoryValueList.Value[t],
                          Volume.YValues.Value[t]);
    end
    else
    begin
      tmp:=DestOHLC.Count-1;

      if Source is TOHLCSeries then
      with TOHLCSeries(Source) do
      begin
        DestOHLC.CloseValues.Value[tmp]:=CloseValues.Value[t];
        DestOHLC.DateValues.Value[tmp] :=DateValues.Value[t];
        if HighValues[t]>DestOHLC.HighValues.Value[tmp] then
           DestOHLC.HighValues.Value[tmp]:=HighValues.Value[t];
        if LowValues[t]<DestOHLC.LowValues.Value[tmp] then
           DestOHLC.LowValues.Value[tmp]:=LowValues.Value[t];
      end
      else
      with Source do
      begin
        tmpValue:=tmpList.Value[t];
        DestOHLC.CloseValues.Value[tmp]:=tmpValue;
        DestOHLC.DateValues.Value[tmp] :=NotMandatoryValueList.Value[t];
        if tmpValue>DestOHLC.HighValues.Value[tmp] then
           DestOHLC.HighValues.Value[tmp]:=tmpValue;
        if tmpValue<DestOHLC.LowValues.Value[tmp] then
           DestOHLC.LowValues.Value[tmp]:=tmpValue;
      end;

      DestOHLC.Labels[tmp]:=Source.Labels[t];

      if Assigned(DestVolume) then
      begin
        With DestVolume.YValues do
           Value[tmp]:=Value[tmp]+Volume.YValues.Value[t];
        DestVolume.XValues.Value[tmp]:=Volume.XValues.Value[t];
      end;
    end;
  end;

  if Assigned(DestVolume) then  // 5.01
  begin
    DestVolume.XValues.Modified:=True; // 5.01
    DestVolume.YValues.Modified:=True;
  end;
end;

procedure TCompressFunction.SetCompress(const Value: TCompressionPeriod);
begin
  if FCompress<>Value then
  begin
    FCompress:=Value;
    ReCalculate;
  end;
end;

type TSeriesAccess=class(TChartSeries);

class Procedure TCompressFunction.PrepareForGallery(Chart:TCustomAxisPanel);
var tmpSeries : TChartSeries;
begin
  Chart.FreeAllSeries;
  tmpSeries:=CreateNewSeries(Chart.Owner,Chart,TCandleSeries,TCompressFunction);
  TSeriesAccess(tmpSeries).PrepareForGallery(True);
end;

// TCompressFuncEditor

procedure TCompressFuncEditor.CBDatePeriodChange(Sender: TObject);
begin
  RadioDate.Checked:=True;
  EnableApply;
end;

procedure TCompressFuncEditor.SetFunction;
begin
  inherited;

  CBDatePeriod.ItemIndex:=0;
  CBTimePeriod.ItemIndex:=0;

  with TCompressFunction(IFunction) do
  begin
    if Period=0 then
    begin
      if Ord(Compress)<Ord(ocSecond) then
      begin
        CBDatePeriod.ItemIndex:=Ord(Compress);
        RadioDate.Checked:=True;
      end
      else
      begin
        CBTimePeriod.ItemIndex:=Ord(Compress)-Ord(ocSecond);
        RadioTime.Checked:=True;
      end;
    end
    else
    begin
      UpDown1.Position:=Round(Period);
      RadioPoints.Checked:=True;
    end;
  end;
end;

procedure TCompressFuncEditor.ApplyFormChanges;
begin
  inherited;

  with TCompressFunction(IFunction) do
  begin
    if RadioDate.Checked then
       Compress:=TCompressionPeriod(CBDatePeriod.ItemIndex)
    else
       Compress:=TCompressionPeriod(CBTimePeriod.ItemIndex+Ord(ocSecond));

    Period:=UpDown1.Position;
  end;
end;

procedure TCompressFuncEditor.RadioDateClick(Sender: TObject);
begin
  UpDown1.Position:=0;
  CBDatePeriod.SetFocus;
  EnableApply;
end;

procedure TCompressFuncEditor.RadioPointsClick(Sender: TObject);
begin
  ENum.SetFocus;
  EnableApply;
end;

procedure TCompressFuncEditor.ENumChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCompressFuncEditor.ENumClick(Sender: TObject);
begin
  RadioPoints.Checked:=True;
  EnableApply;
end;

procedure TCompressFuncEditor.CBDatePeriodClick(Sender: TObject);
begin
  RadioDate.Checked:=True;
  EnableApply;
end;

procedure TCompressFuncEditor.RadioTimeClick(Sender: TObject);
begin
  UpDown1.Position:=0;
  CBTimePeriod.SetFocus;
  EnableApply;
end;

procedure TCompressFuncEditor.CBTimePeriodChange(Sender: TObject);
begin
  RadioTime.Checked:=True;
  EnableApply;
end;

initialization
  RegisterClass(TCompressFuncEditor);
  RegisterTeeFunction( TCompressFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCompress,
                                          {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([TCompressFunction]);
end.
