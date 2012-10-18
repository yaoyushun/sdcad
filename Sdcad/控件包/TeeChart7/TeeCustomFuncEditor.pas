{********************************************}
{ TeeChart Pro Charting Library              }
{ Custom TeeFunction Editor                  }
{ Copyright (c) 2002-2004 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeCustomFuncEditor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  SysUtils, Classes, TeEngine, TeeFunci;

type
  TCustomFunctionEditor = class(TForm)
    Label1: TLabel;
    EStart: TEdit;
    Label2: TLabel;
    EStep: TEdit;
    ENum: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EStartChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    TheFunction  : TCustomTeeFunction;
    Function Series:TChartSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeFuncEdit;

procedure TCustomFunctionEditor.FormShow(Sender: TObject);
begin
  TheFunction:=TCustomTeeFunction(Tag);
  if Assigned(TheFunction) then
  begin
    EStart.Text:=FloatToStr(TheFunction.StartX);
    EStep.Text:=FloatToStr(TheFunction.Period);
    ENum.Text:=IntToStr(TheFunction.NumPoints);
  end;
end;

procedure TCustomFunctionEditor.EStartChange(Sender: TObject);
begin
  TTeeFuncEditor(Owner).BApply.Enabled:=True;
end;

Function TCustomFunctionEditor.Series:TChartSeries;
begin
  result:=TTeeFuncEditor(Owner).TheSeries;
end;

procedure TCustomFunctionEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not Assigned(TheFunction) then
    TheFunction:=TCustomTeeFunction.Create(Series.Owner);

  TheFunction.StartX:=StrToFloat(EStart.Text);
  TheFunction.Period:=StrToFloat(EStep.Text);
  TheFunction.NumPoints:=StrToInt(ENum.Text);

  if not Assigned(Series.FunctionType) then
     Series.SetFunction(TheFunction);

  CanClose:=True;
end;

initialization
  RegisterClass(TCustomFunctionEditor);
end.

