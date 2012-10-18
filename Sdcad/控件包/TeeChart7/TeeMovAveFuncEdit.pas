{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeMovAveFuncEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  {$ENDIF}
  TeCanvas, StatChar, TeeBaseFuncEdit;

type
  TMovAveFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    CBStyle: TComboFlat;
    procedure Edit1Change(Sender: TObject);
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
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TMovAveFuncEditor.SetFunction;
begin
  inherited;
  with TMovingAverageFunction(IFunction) do
  begin
    UpDown1.Position:=Round(Period);
    if Weighted then
       CBStyle.ItemIndex:=1
    else
    if WeightedIndex then
       CBStyle.ItemIndex:=2
    else
       CBStyle.ItemIndex:=0;
  end;
end;

procedure TMovAveFuncEditor.Edit1Change(Sender: TObject);
begin
  EnableApply;
end;

procedure TMovAveFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TMovingAverageFunction(IFunction) do
  begin
    Period:=UpDown1.Position;
    Weighted:=CBStyle.ItemIndex=1;
    WeightedIndex:=CBStyle.ItemIndex=2;
  end;
end;

initialization
  RegisterClass(TMovAveFuncEditor);
end.

