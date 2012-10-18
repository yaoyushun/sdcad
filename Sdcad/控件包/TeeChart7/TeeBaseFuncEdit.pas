{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{                                            }
{  Base Function Editor form                 }
{********************************************}
unit TeeBaseFuncEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs,
     {$ENDIF}
     TeEngine;

type
  TBaseFunctionEditor = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    CreatingForm : Boolean;
    IFunction    : TTeeFunction;
    procedure ApplyFormChanges; virtual;  // dont make abstract (D5 bug)
    procedure EnableApply;
    Procedure SetFunction; virtual;   // dont make abstract (D5 bug)
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeFuncEdit, Chart;

Procedure TBaseFunctionEditor.SetFunction;
begin
end;

Procedure TBaseFunctionEditor.ApplyFormChanges;
begin
end;

procedure TBaseFunctionEditor.EnableApply;
begin
  TTeeFuncEditor(Owner).BApply.Enabled:=True;
end;

procedure TBaseFunctionEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);

  Function Series:TChartSeries;
  begin
    result:=TTeeFuncEditor(Owner).TheSeries;
  end;

begin
  if not Assigned(IFunction) then
     IFunction:=CreateNewTeeFunction(Series,TTeeFuncEditor(Owner).FunctionClass);

  With IFunction do
  begin
    BeginUpdate;
    ApplyFormChanges;
    EndUpdate;
  end;

  if not Assigned(Series.FunctionType) then
     Series.SetFunction(IFunction);

  CanClose:=True;
end;

procedure TBaseFunctionEditor.FormShow(Sender: TObject);
begin
  CreatingForm:=True;
  IFunction:=TTeeFunction({$IFDEF CLR}TObject{$ENDIF}(Tag));
  if Assigned(IFunction) then SetFunction;
  CreatingForm:=False;
end;

initialization
  RegisterClass(TBaseFunctionEditor);
end.
