{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeEdiPeri;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Borland.VCL.StdCtrls,
     Borland.VCL.Controls,
     SysUtils,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
     {$ENDIF}
     {$ENDIF}
     TeeProcs, TeEngine, TeCanvas, TeeBaseFuncEdit;

type
  TTeeFunctionEditor = class(TBaseFunctionEditor)
    ENum: TEdit;
    BChange: TButton;
    Label1: TLabel;
    CBAlign: TComboFlat;
    Label2: TLabel;
    CBStyle: TComboFlat;
    Label3: TLabel;
    procedure BChangeClick(Sender: TObject);
    procedure ENumChange(Sender: TObject);
    procedure CBAlignChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
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

Uses {$IFDEF CLR}
     Classes,
     {$ELSE}
     Math,
     {$ENDIF}
     TeeAxisIncr, TeeConst;

Procedure TTeeFunctionEditor.SetFunction;
var CanRange : Boolean;
begin
  inherited;
  CanRange:=not (IFunction is TTeeMovingFunction);

  With IFunction do
  begin
    if (PeriodStyle=psRange) and CanRange then
       CBStyle.ItemIndex:=2
    else
    if Round(Period)=0 then CBStyle.ItemIndex:=0
                       else CBStyle.ItemIndex:=1;

    CBAlign.ItemIndex:=Ord(PeriodAlign);

    ENum.Enabled:=CBStyle.ItemIndex<>0;
    BChange.Enabled:=CBStyle.ItemIndex=2;

    CBStyleChange(Self);
  end;
end;

procedure TTeeFunctionEditor.BChangeClick(Sender: TObject);

  Function CalcIsDateTime:Boolean;
  begin
    With IFunction.ParentSeries do
    if Assigned(DataSource) and (DataSource is TChartSeries) then
       result:=TChartSeries(DataSource).XValues.DateTime
    else
       result:=False;
  end;

var tmp : TAxisIncrement;
begin
  tmp:=TAxisIncrement.Create(Self);
  with tmp do
  try
    IsDateTime :=CalcIsDateTime;
    IsExact    :=True;
    Increment  :=IFunction.Period;
    IStep      :=FindDateTimeStep(IFunction.Period);
    Caption    :=TeeMsg_PeriodRange;
    TeeTranslateControl(tmp);
    if ShowModal=mrOk then
    begin
      ENum.Text:=FloatToStr(Increment);
//      TheIsDateTime:=IsDateTime;
    end;
  finally
    Free;
  end;
end;

procedure TTeeFunctionEditor.ENumChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TTeeFunctionEditor.ApplyFormChanges;
begin
  inherited;
  With IFunction do
  begin
    PeriodAlign:=TFunctionPeriodAlign(CBAlign.ItemIndex);
    if CBStyle.ItemIndex=2 then PeriodStyle:=psRange
                           else PeriodStyle:=psNumPoints;
    Period:=StrToFloatDef(ENum.Text,0);
  end;
end;

procedure TTeeFunctionEditor.CBAlignChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TTeeFunctionEditor.CBStyleChange(Sender: TObject);
var tmpMax : Double;
begin
  ENum.Enabled:=CBStyle.ItemIndex<>0;
  BChange.Enabled:=CBStyle.ItemIndex=2;

  if Assigned(IFunction) then tmpMax:=IFunction.Period
                         else tmpMax:=0;

  case CBStyle.ItemIndex of
    0: ENum.Text:='';
    1: ENum.Text:=FloatToStr(Round(Math.Max(0,tmpMax)))
  else ENum.Text:=FloatToStr(tmpMax);
  end;

  if ENum.Enabled then ENum.SetFocus;

  EnableApply;
end;

initialization
  RegisterClass(TTeeFunctionEditor);
end.
