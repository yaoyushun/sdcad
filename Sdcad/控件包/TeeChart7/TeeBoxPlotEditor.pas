{**********************************************}
{   TCustomBoxSeries Editor dialog             }
{     TBoxSeries                               }
{     THorizBoxSeries                          }
{                                              }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeeBoxPlotEditor;
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
     TeCanvas, TeePenDlg, TeeBoxPlot, TeeProcs;

type
  TBoxSeriesEditor = class(TForm)
    BMedian: TButtonPen;
    Label1: TLabel;
    EPos: TEdit;
    Label2: TLabel;
    ELength: TEdit;
    BWhisker: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure ELengthChange(Sender: TObject);
    procedure EPosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    BoxPointerForm  : TCustomForm;
    ExtrPointerForm : TCustomForm;
    MildPointerForm : TCustomForm;
    Box             : TCustomBoxSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeePoEdi, TeeProCo;

procedure TBoxSeriesEditor.FormShow(Sender: TObject);
begin
  Box:=TCustomBoxSeries(Tag);
  if Assigned(Box) then
  begin
    with Box do
    begin
      BMedian.LinkPen(MedianPen);
      BWhisker.LinkPen(WhiskerPen);
      ELength.Text:=FloatToStr(WhiskerLength);
      EPos.Text:=FloatToStr(Position);
    end;

    if Assigned(Parent) then
    begin
      if not Assigned(BoxPointerForm) then
         BoxPointerForm:=TeeInsertPointerForm(Parent,Box.Pointer,TeeMsg_Box);

      if not Assigned(ExtrPointerForm) then
         ExtrPointerForm:=TeeInsertPointerForm(Parent,Box.ExtrOut,TeeMsg_ExtrOut);

      if not Assigned(MildPointerForm) then
         MildPointerForm:=TeeInsertPointerForm(Parent,Box.MildOut,TeeMsg_MildOut);
    end;
  end;
end;

procedure TBoxSeriesEditor.ELengthChange(Sender: TObject);
begin
  if Showing and (ELength.Text<>'') then Box.WhiskerLength:=StrToFloat(ELength.Text);
end;

procedure TBoxSeriesEditor.EPosChange(Sender: TObject);
begin
  if Showing and (EPos.Text<>'') then Box.Position:=StrToFloat(EPos.Text);
end;

procedure TBoxSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TBoxSeriesEditor);
end.

