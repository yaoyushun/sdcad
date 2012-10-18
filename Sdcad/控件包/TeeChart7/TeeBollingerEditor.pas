{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeBollingerEditor;
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
  TBollingerFuncEditor = class(TBaseFunctionEditor)
    Label3: TLabel;
    ENum: TEdit;
    UpDown1: TUpDown;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    ButtonPen1: TButtonPen;
    ButtonPen2: TButtonPen;
    procedure ENumChange(Sender: TObject);
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

procedure TBollingerFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TBollingerFunction(IFunction) do
  begin
    Period:=UpDown1.Position;
    Exponential:=CheckBox1.Checked;
    Deviation:=StrToFloat(Edit1.Text);
  end;
end;

procedure TBollingerFuncEditor.ENumChange(Sender: TObject);
begin
  EnableApply;
end;

Procedure TBollingerFuncEditor.SetFunction;
begin
  inherited;
  with TBollingerFunction(IFunction) do
  begin
    UpDown1.Position:=Round(Period);
    CheckBox1.Checked:=Exponential;
    Edit1.Text:=FloatToStr(Deviation);
    ButtonPen1.LinkPen(UpperBandPen);
    ButtonPen2.LinkPen(LowBandPen);
  end;
end;

initialization
  RegisterClass(TBollingerFuncEditor);
end.
