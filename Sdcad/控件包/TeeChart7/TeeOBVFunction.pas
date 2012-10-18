{**********************************************}
{   TOBVFunction (On Balance Volume)           }
{   Copyright (c) 2002-2004 by David Berneda   }
{**********************************************}
unit TeeOBVFunction;
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
  TOBVFunction=class(TTeeFunction)
  private
    FVolume : TChartSeries;
    procedure SetVolume(const Value: TChartSeries);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    Constructor Create(AOwner:TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    property Volume:TChartSeries read FVolume write SetVolume;
  end;

  TOBVFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    CBVolume: TComboFlat;
    procedure CBVolumeChange(Sender: TObject);
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

{ TOBVFunction }
constructor TOBVFunction.Create(AOwner: TComponent);
begin
  inherited;
  InternalSetPeriod(1);
  CanUsePeriod:=False;
  SingleSource:=True;
  HideSourceList:=True;
end;

procedure TOBVFunction.AddPoints(Source: TChartSeries);
var t   : Integer;
    tmp : Double;
begin
  ParentSeries.Clear;

  if Assigned(FVolume) then
  with Source as TOHLCSeries do
  for t:=0 to Count-1 do
    if FVolume.Count>t then
    begin
      tmp:=FVolume.MandatoryValueList.Value[t];
      if CloseValues.Value[t]>OpenValues.Value[t] then
      begin
        if t>0 then tmp:=tmp+ParentSeries.MandatoryValueList.Last
      end
      else
        if t>0 then tmp:=ParentSeries.MandatoryValueList.Last-tmp;

      ParentSeries.AddXY(DateValues.Value[t],tmp);
    end
    else break;
end;

class function TOBVFunction.GetEditorClass: String;
begin
  result:='TOBVFuncEditor';
end;

function TOBVFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

procedure TOBVFunction.SetVolume(const Value: TChartSeries);
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

procedure TOBVFunction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (AComponent=FVolume) then
     Volume:=nil;
end;

procedure TOBVFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TOBVFunction(IFunction) do
       Volume:=TChartSeries(CBVolume.Items.Objects[CBVolume.ItemIndex]);
end;

procedure TOBVFuncEditor.SetFunction;
begin
  inherited;
  with TOBVFunction(IFunction) do
       CBVolume.ItemIndex:=CBVolume.Items.IndexOfObject(Volume);

  with CBVolume do
  begin
    FillSeriesItems(Items,IFunction.ParentSeries.ParentChart.SeriesList);
    Items.InsertObject(0,TeeMsg_None,nil);
    Items.Delete(Items.IndexOfObject(IFunction.ParentSeries));
    ItemIndex:=Items.IndexOfObject(TOBVFunction(IFunction).Volume);
  end;
end;

procedure TOBVFuncEditor.CBVolumeChange(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TOBVFuncEditor);
  RegisterTeeFunction( TOBVFunction,
         {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionOBV,
         {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([ TOBVFunction ]);
end.
