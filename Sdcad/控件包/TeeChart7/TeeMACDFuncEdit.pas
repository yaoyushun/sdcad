{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeMACDFuncEdit;
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
  TeCanvas, TeePenDlg, StatChar, TeeBaseFuncEdit;

type
  TMACDFuncEditor = class(TBaseFunctionEditor)
    Label3: TLabel;
    ENum: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown2: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown3: TUpDown;
    BHistogram: TButtonPen;
    BMACDExp: TButtonPen;
    BMACD: TButtonPen;
    procedure ENumChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    procedure SetFunction; override;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TMACDFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TMACDFunction(IFunction) do
  begin
    Period:=UpDown1.Position;
    Period2:=UpDown2.Position;
    Period3:=UpDown3.Position;
  end;
end;

procedure TMACDFuncEditor.ENumChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TMACDFuncEditor.SetFunction;
begin
  inherited;
  with TMACDFunction(IFunction) do
  begin
    UpDown1.Position:=Round(Period);
    UpDown2.Position:=Round(Period2);
    UpDown3.Position:=Round(Period3);
    BHistogram.LinkPen(HistogramPen);
    BMACD.LinkPen(MACDPen);
    BMACDExp.LinkPen(MACDExpPen);
  end;
end;

initialization
  RegisterClass(TMACDFuncEditor);
end.
