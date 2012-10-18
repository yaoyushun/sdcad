{**********************************************}
{   TCLVFunction (Accumulation/Distribution)   }
{   Copyright (c) 2002-2004 by David Berneda   }
{**********************************************}
unit TeeCLVFunction;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  OHLChart, TeEngine, TeCanvas, Chart, TeeBaseFuncEdit;

type
  TCLVFunction=class(TTeeFunction)
  private
    FVolume: TChartSeries;
    FAccumulate: Boolean; // 6.01, renamed
    procedure SetVolume(const Value: TChartSeries);
    procedure SetAccumulate(const Value: Boolean);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    Constructor Create(AOwner:TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    property Accumulate:Boolean read FAccumulate write SetAccumulate default True;
    property Volume:TChartSeries read FVolume write SetVolume;
  end;

  TCLVFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    CBVolume: TComboFlat;
    CBAccumulate: TCheckBox;
    procedure CBAccumulateClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    Procedure SetFunction; override;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeProCo, TeeConst;

{ TCLVFunction }
constructor TCLVFunction.Create(AOwner: TComponent);
begin
  inherited;
  InternalSetPeriod(1);
  CanUsePeriod:=False;
  SingleSource:=True;
  HideSourceList:=True;
  FAccumulate:=True;
end;

procedure TCLVFunction.AddPoints(Source: TChartSeries);
var t : Integer;
    tmpHigh  : Double;
    tmpClose : Double;
    tmpLow   : Double;
    CLV      : Double;
    tmpVolume : Boolean;
begin
  tmpVolume:=Assigned(FVolume);

  ParentSeries.Clear;
  with Source as TOHLCSeries do
  for t:=0 to Count-1 do
  begin
    tmpHigh:=HighValues.Value[t];
    tmpClose:=CloseValues.Value[t];
    tmpLow:=LowValues.Value[t];

    if (tmpHigh-tmpLow)=0 then  // 7.0 #1201
       CLV:=1
    else
       CLV:=( (tmpClose-tmpLow)-(tmpHigh-tmpClose))/(tmpHigh-tmpLow);

    if tmpVolume and (FVolume.Count>t) then
       CLV:=CLV*FVolume.MandatoryValueList.Value[t];

    if Accumulate then
       if t>0 then CLV:=CLV+ParentSeries.MandatoryValueList.Last;

    ParentSeries.AddXY(DateValues.Value[t],CLV);
  end;
end;

class function TCLVFunction.GetEditorClass: String;
begin
  result:='TCLVFuncEditor';
end;

function TCLVFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

procedure TCLVFunction.SetVolume(const Value: TChartSeries);
begin
  if FVolume<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FVolume) then
       FVolume.RemoveFreeNotification(Self);
    {$ENDIF}

    FVolume:=Value;
    if Assigned(FVolume) then
       FVolume.FreeNotification(Self);

    ReCalculate;
  end;
end;

procedure TCLVFunction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (AComponent=FVolume) then
     Volume:=nil;
end;

procedure TCLVFunction.SetAccumulate(const Value: Boolean);
begin
  if FAccumulate<>Value then
  begin
    FAccumulate:=Value;
    ReCalculate;
  end;
end;

procedure TCLVFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TCLVFunction(IFunction) do
  begin
    Volume:=TChartSeries(CBVolume.Items.Objects[CBVolume.ItemIndex]);
    Accumulate:=CBAccumulate.Checked;
  end;
end;

procedure TCLVFuncEditor.CBAccumulateClick(Sender: TObject);
begin
  EnableApply;
end;

procedure TCLVFuncEditor.SetFunction;
begin
  inherited;
  with TCLVFunction(IFunction) do
  begin
    CBVolume.ItemIndex:=CBVolume.Items.IndexOfObject(Volume);
    CBAccumulate.Checked:=Accumulate;
  end;

  with CBVolume do
  begin
    FillSeriesItems(Items,IFunction.ParentSeries.ParentChart.SeriesList);
    Items.InsertObject(0,TeeMsg_None,nil);
    Items.Delete(Items.IndexOfObject(IFunction.ParentSeries));
    ItemIndex:=Items.IndexOfObject(TCLVFunction(IFunction).Volume);
  end;
end;

initialization
  RegisterClass(TCLVFuncEditor);
  RegisterTeeFunction( TCLVFunction,
        {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCLV,
        {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([ TCLVFunction ]);
end.
