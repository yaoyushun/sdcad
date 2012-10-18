{**********************************************}
{   TeeChart LinePoint Series Editor           }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeLinePointEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeePoEdi, TeCanvas, TeePenDlg;

type
  TLinePointEditor = class(TSeriesPointerEditor)
    BLines: TButtonPen;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses MyPoint;

procedure TLinePointEditor.FormShow(Sender: TObject);
begin
  inherited;
  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     BLines.LinkPen(TMyPointSeries(Tag).LinesPen);
end;

initialization
  RegisterClass(TLinePointEditor);
end.
