{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeRMSFuncEdit;
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
  TeeEdiPeri, TeCanvas;

{
  Warning: This form is used for both TRMSFunction and TStdDeviationFunction.

  The reason is to share the same form for both functions to save resources,
  as both functions have only a "Complete" boolean property.
}

type
  TRMSFuncEditor = class(TTeeFunctionEditor)
    CBComplete: TCheckBox;
    procedure CBCompleteClick(Sender: TObject);
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

uses StatChar;

procedure TRMSFuncEditor.ApplyFormChanges;
begin
  inherited;
  if IFunction is TRMSFunction then
     TRMSFunction(IFunction).Complete:=CBComplete.Checked
  else
  if IFunction is TStdDeviationFunction then
     TStdDeviationFunction(IFunction).Complete:=CBComplete.Checked;
end;

procedure TRMSFuncEditor.CBCompleteClick(Sender: TObject);
begin
  EnableApply;
end;

procedure TRMSFuncEditor.SetFunction;
begin
  inherited;
  if IFunction is TRMSFunction then
     CBComplete.Checked:=TRMSFunction(IFunction).Complete
  else
     CBComplete.Checked:=TStdDeviationFunction(IFunction).Complete;
end;

initialization
  RegisterClass(TRMSFuncEditor);
end.
