{********************************************}
{ TeeChart Pro Charting Library              }
{ Average Function editor                    }
{ Copyright (c) 2002-2004 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeAvgFuncEditor;
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

type
  TAverageFuncEditor = class(TTeeFunctionEditor)
    CBNulls: TCheckBox;
    procedure CBNullsClick(Sender: TObject);
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

uses TeeFunci;

{ TAverageFuncEditor }
procedure TAverageFuncEditor.ApplyFormChanges;
begin
  inherited;
  TAverageTeeFunction(IFunction).IncludeNulls:=CBNulls.Checked;
end;

procedure TAverageFuncEditor.SetFunction;
begin
  inherited;
  CBNulls.Checked:=TAverageTeeFunction(IFunction).IncludeNulls;
end;

procedure TAverageFuncEditor.CBNullsClick(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TAverageFuncEditor);
end.

