{***********************************************}
{   TPVOFunction (Percentage Volume Oscillator) }
{   Copyright (c) 2002-2004 by David Berneda    }
{***********************************************}
unit TeePVOFunction;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  TeEngine, TeCanvas, Chart, TeeBaseFuncEdit, StatChar;

type
  TPVOFunction=class(TTeeFunction)
  private
    FExpMovAve1 : TExpMovAveFunction;
    FExpMovAve2 : TExpMovAveFunction;
    FExpSeries1 : TChartSeries;
    FExpSeries2 : TChartSeries;
    FPercent    : Boolean;

    function GetPeriod2: Integer;
    procedure SetPercent(const Value: Boolean);
    procedure SetPeriod2(const Value: Integer);
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    property Percentage:Boolean read FPercent write SetPercent default True;
    property Period2:Integer read GetPeriod2 write SetPeriod2 default 26;
  end;

  TPVOFuncEditor = class(TBaseFunctionEditor)
    Label2: TLabel;
    EPeriod: TEdit;
    UDPeriod: TUpDown;
    Label1: TLabel;
    Edit1: TEdit;
    UDPeriod2: TUpDown;
    CBPercent: TCheckBox;
    procedure EPeriodChange(Sender: TObject);
    procedure CBPercentClick(Sender: TObject);
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

{ TPVOFunction }
constructor TPVOFunction.Create(AOwner: TComponent);
begin
  inherited;
  InternalSetPeriod(12);
  CanUsePeriod:=False;
  SingleSource:=True;
  HideSourceList:=True;

  FPercent:=True;

  FExpSeries1:=TChartSeries.Create(nil);
  FExpSeries2:=TChartSeries.Create(nil);

  FExpMovAve1:=TExpMovAveFunction.Create(nil);
  FExpMovAve1.Period:=Period;
  FExpMovAve1.ParentSeries:=FExpSeries1;
  FExpMovAve2:=TExpMovAveFunction.Create(nil);
  FExpMovAve2.Period:=26;
  FExpMovAve2.ParentSeries:=FExpSeries2;
end;

Destructor TPVOFunction.Destroy;
begin
  FExpSeries2.Free;
  FExpSeries1.Free;
  inherited;
end;

procedure TPVOFunction.AddPoints(Source: TChartSeries);
var tmp : Double;
    t   : Integer;
begin
  ParentSeries.Clear;
  if Period>0 then
  begin
    FExpMovAve1.Period:=Period;
    FExpMovAve1.AddPoints(Source);
    FExpMovAve2.AddPoints(Source);

    for t:=0 to Source.Count-1 do
    begin
      tmp:=FExpSeries1.MandatoryValueList.Value[t];

      if FPercent then
      begin
        if tmp<>0 then
           tmp:=(tmp-FExpSeries2.MandatoryValueList.Value[t])/tmp
        else
           tmp:=FExpSeries2.MandatoryValueList.Value[t];
      end
      else tmp:=tmp-FExpSeries2.MandatoryValueList.Value[t];

      ParentSeries.AddXY(Source.NotMandatoryValueList.Value[t],100.0*tmp);
    end;
  end;
end;

class function TPVOFunction.GetEditorClass: String;
begin
  result:='TPVOFuncEditor';
end;

function TPVOFunction.GetPeriod2: Integer;
begin
  result:=Round(FExpMovAve2.Period);
end;

procedure TPVOFunction.SetPeriod2(const Value: Integer);
begin
  FExpMovAve2.Period:=Value;
  Recalculate;
end;

procedure TPVOFunction.SetPercent(const Value: Boolean);
begin
  FPercent:=Value;
  Recalculate;
end;

{ TPVOFuncEditor }
procedure TPVOFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TPVOFunction(IFunction) do
  begin
    Period:=UDPeriod.Position;
    Period2:=UDPeriod2.Position;
    Percentage:=CBPercent.Checked;
  end;
end;

procedure TPVOFuncEditor.SetFunction;
begin
  inherited;
  with TPVOFunction(IFunction) do
  begin
    UDPeriod.Position:=Round(Period);
    UDPeriod2.Position:=Round(Period2);
    CBPercent.Checked:=Percentage;
  end;
end;

procedure TPVOFuncEditor.EPeriodChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TPVOFuncEditor.CBPercentClick(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TPVOFuncEditor);
  RegisterTeeFunction( TPVOFunction,
       {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionPVO,
       {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([ TPVOFunction ]);
end.
