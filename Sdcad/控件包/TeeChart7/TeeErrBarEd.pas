{**********************************************}
{   TErrorBarSeries Component Editor Dialog    }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeErrBarEd;
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
     Chart, Series, ErrorBar, TeCanvas, TeePenDlg, TeeProcs;

type
  TErrorSeriesEditor = class(TForm)
    SEBarwidth: TEdit;
    Label1: TLabel;
    BPen: TButtonPen;
    RGWidthUnit: TRadioGroup;
    UDBarWidth: TUpDown;
    RGStyle: TRadioGroup;
    CBColorEach: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SEBarwidthChange(Sender: TObject);
    procedure BPenClick(Sender: TObject);
    procedure RGWidthUnitClick(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ErrorSeries : TCustomErrorSeries;
    FBarForm : TCustomForm;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeBarEdit, TeeConst, TeeEdiSeri;

procedure TErrorSeriesEditor.FormShow(Sender: TObject);
begin
  ErrorSeries:=TCustomErrorSeries(Tag);
  if Assigned(ErrorSeries) then
  With ErrorSeries do
  begin
    UDBarWidth.Position:=ErrorWidth;
    if ErrorWidthUnits=ewuPercent then RGWidthUnit.ItemIndex:=0
                                  else RGWidthUnit.ItemIndex:=1;
    RGStyle.Visible:=ErrorSeries is TErrorSeries;
    if RGStyle.Visible then RGStyle.ItemIndex:=Ord(ErrorStyle);
    CBColorEach.Checked:=ColorEachPoint;
    BPen.LinkPen(ErrorPen);
  end;

  if (ErrorSeries is TErrorBarSeries) and (not Assigned(FBarForm)) then
       FBarForm:=TFormTeeSeries(Parent.Owner).InsertSeriesForm( TBarSeriesEditor,
                                                    1,TeeMsg_GalleryBar,
                                                    ErrorSeries);
end;

procedure TErrorSeriesEditor.SEBarwidthChange(Sender: TObject);
begin
  if Showing then ErrorSeries.ErrorWidth:=UDBarWidth.Position;
end;

procedure TErrorSeriesEditor.BPenClick(Sender: TObject);
begin
  With ErrorSeries do
  if not (ErrorSeries is TErrorBarSeries) then SeriesColor:=ErrorPen.Color;
end;

procedure TErrorSeriesEditor.RGWidthUnitClick(Sender: TObject);
begin
  ErrorSeries.ErrorWidthUnits:=TErrorWidthUnits(RGWidthUnit.ItemIndex);
end;

procedure TErrorSeriesEditor.RGStyleClick(Sender: TObject);
begin
  if Showing then ErrorSeries.ErrorStyle:=TErrorSeriesStyle(RGStyle.ItemIndex);
end;

procedure TErrorSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  ErrorSeries.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TErrorSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

initialization
  RegisterClass(TErrorSeriesEditor);
end.
