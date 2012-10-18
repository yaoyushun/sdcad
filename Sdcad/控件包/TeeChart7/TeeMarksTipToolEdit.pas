{******************************************}
{ TMarksTipTool Editor Dialog              }
{ Copyright (c) 1999-2004 by David Berneda }
{******************************************}
unit TeeMarksTipToolEdit;
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
     TeeToolSeriesEdit, TeeTools, TeeEdiSeri, TeCanvas
     {$IFDEF CLX}
     , TeeProcs
     {$ENDIF}
     ;

type
  TMarksTipToolEdit = class(TSeriesToolEditor)
    Label2: TLabel;
    CBMarkStyle: TComboFlat;
    RGMouseAction: TRadioGroup;
    Label3: TLabel;
    EDelay: TEdit;
    UDDelay: TUpDown;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CBMarkStyleChange(Sender: TObject);
    procedure RGMouseActionClick(Sender: TObject);
    procedure EDelayChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    tmp       : TFormTeeSeries;
    MarksTool : TMarksTipTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeEngine;

procedure TMarksTipToolEdit.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Tool) then
  begin
    MarksTool:=TMarksTipTool(Tool);

    { change "none" with "all" }
    with CBSeries do { 5.02 }
    begin
      Items[0]:=TeeMsg_All;
      ItemIndex:=Items.IndexOfObject(Tool.Series);
    end;

    { setup dialog }
    with MarksTool do
    begin
      RGMouseAction.ItemIndex:=Ord(MouseAction);
      CBMarkStyle.ItemIndex:=Ord(Style);
      UDDelay.Position:=MouseDelay;
    end;
  end;
end;

procedure TMarksTipToolEdit.CBMarkStyleChange(Sender: TObject);
begin
  MarksTool.Style:=TSeriesMarksStyle(CBMarkStyle.ItemIndex);
end;

procedure TMarksTipToolEdit.RGMouseActionClick(Sender: TObject);
begin
  MarksTool.MouseAction:=TMarkToolMouseAction(RGMouseAction.ItemIndex);
end;

procedure TMarksTipToolEdit.EDelayChange(Sender: TObject);
begin
  if Showing then MarksTool.MouseDelay:=UDDelay.Position;
end;

procedure TMarksTipToolEdit.FormCreate(Sender: TObject);
begin
  inherited;
  { temporary form to obtain the Mark Styles }
  tmp:=TFormTeeSeries.Create(nil);
  CBMarkStyle.Items.Assign(tmp.RGMarkStyle.Items);
end;

procedure TMarksTipToolEdit.FormDestroy(Sender: TObject);
begin
  tmp.Free;
  inherited;
end;

initialization
  RegisterClass(TMarksTipToolEdit);
end.
