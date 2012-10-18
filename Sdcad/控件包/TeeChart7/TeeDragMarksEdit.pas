{**********************************************}
{   TDragMarksTool Editor dialog               }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeeDragMarksEdit;
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
     TeeToolSeriesEdit, TeCanvas;

type
  TDragMarksToolEditor = class(TSeriesToolEditor)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

Uses Chart, TeeConst;

procedure TDragMarksToolEditor.Button1Click(Sender: TObject);
var t : Integer;
begin
  if Assigned(Tool.Series) then
     Tool.Series.Marks.ResetPositions
  else
  With Tool.ParentChart do
     for t:=0 to SeriesCount-1 do
         Series[t].Marks.ResetPositions;
end;

procedure TDragMarksToolEditor.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(Tool) then
  begin
    CBSeries.Items[0]:=TeeMsg_All;
    if CBSeries.ItemIndex=-1 then CBSeries.ItemIndex:=0;
  end;
end;

procedure TDragMarksToolEditor.FormCreate(Sender: TObject);
begin
  inherited;
  Align:=alClient;
end;

initialization
  RegisterClass(TDragMarksToolEditor);
end.
