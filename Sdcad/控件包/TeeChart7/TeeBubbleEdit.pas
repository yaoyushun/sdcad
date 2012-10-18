{**********************************************}
{   Bubble Series editor (derived from Point)  }
{   Copyright (c) 2002-2004 by David Berneda   }
{**********************************************}
unit TeeBubbleEdit;
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
  TeePoEdi, TeCanvas, TeePenDlg;

type
  TBubbleSeriesEditor = class(TSeriesPointerEditor)
    Label4: TLabel;
    Edit1: TEdit;
    UDTransp: TUpDown;
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses BubbleCh;

procedure TBubbleSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     (ThePointer.ParentSeries as TBubbleSeries).Transparency:=UDTransp.Position;
end;

procedure TBubbleSeriesEditor.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(ThePointer) then
     UDTransp.Position:=(ThePointer.ParentSeries as TBubbleSeries).Transparency;
  CBDrawPoint.Visible:=False;
end;

initialization
  RegisterClass(TBubbleSeriesEditor);
end.
