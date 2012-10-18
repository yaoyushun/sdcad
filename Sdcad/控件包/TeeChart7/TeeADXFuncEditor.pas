{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeADXFuncEditor;
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
  CandleCh, TeCanvas, TeePenDlg;

type
  TADXFuncEditor = class(TForm)
    Label1: TLabel;
    EPeriod: TEdit;
    UDPeriod: TUpDown;
    BUp: TButtonPen;
    BDown: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure EPeriodChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    ADXFunction : TADXFunction;
    procedure EnableApply;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeEngine, TeeFuncEdit;

procedure TADXFuncEditor.FormShow(Sender: TObject);
begin
  ADXFunction:=TADXFunction(Tag);
  if Assigned(ADXFunction) then
  begin
    UDPeriod.Position:=Round(ADXFunction.Period);
    BUp.LinkPen(ADXFunction.UpLinePen);
    BDown.LinkPen(ADXFunction.DownLinePen);
  end;
end;

procedure TADXFuncEditor.EPeriodChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TADXFuncEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);

  Function Series:TChartSeries;
  begin
    result:=TTeeFuncEditor(Owner).TheSeries;
  end;

begin
  if not Assigned(ADXFunction) then
    ADXFunction:=TADXFunction.Create(Series.Owner);

  ADXFunction.Period:=UDPeriod.Position;

  if not Assigned(Series.FunctionType) then
     Series.SetFunction(ADXFunction);

  CanClose:=True;
end;

procedure TADXFuncEditor.EnableApply;
begin
  if Assigned(Owner) and Assigned(TTeeFuncEditor(Owner).BApply) then
     TTeeFuncEditor(Owner).BApply.Enabled:=True;
end;

initialization
  RegisterClass(TADXFuncEditor);
end.

