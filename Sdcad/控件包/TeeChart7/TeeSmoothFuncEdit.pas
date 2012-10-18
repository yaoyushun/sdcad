{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeSmoothFuncEdit;
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
  TeeSpline, TeeBaseFuncEdit, TeCanvas;

type
  TSmoothFuncEditor = class(TBaseFunctionEditor)
    CBInterp: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure CBInterpClick(Sender: TObject);
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

procedure TSmoothFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TSmoothingFunction(IFunction) do
  begin
    Interpolate:=CBInterp.Checked;
    Factor:=UpDown1.Position;
  end;
end;

procedure TSmoothFuncEditor.SetFunction;
begin
  inherited;
  if Assigned(IFunction) then
  with TSmoothingFunction(IFunction) do
  begin
    CBInterp.Checked:=Interpolate;
    UpDown1.Position:=Factor;
  end;
end;

procedure TSmoothFuncEditor.CBInterpClick(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TSmoothFuncEditor);
end.

