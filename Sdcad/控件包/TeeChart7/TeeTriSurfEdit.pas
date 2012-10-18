{**********************************************}
{   TTriSurfaceSeries Editor Dialog            }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeTriSurfEdit;
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
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     Chart, TeeSurfa, TeeTriSurface, TeCanvas, TeePenDlg, TeeProcs;

type
  TTriSurfaceSeriesEditor = class(TForm)
    Button2: TButtonPen;
    Button3: TButton;
    Button1: TButtonPen;
    CBFastBrush: TCheckBox;
    CBHide: TCheckBox;
    ETransp: TEdit;
    UDTransp: TUpDown;
    LHeight: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBFastBrushClick(Sender: TObject);
    procedure CBHideClick(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
  private
    { Private declarations }
    Surface : TTriSurfaceSeries;
    Grid3DForm : TCustomForm;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeGriEd;

procedure TTriSurfaceSeriesEditor.FormShow(Sender: TObject);
begin
  Surface:=TTriSurfaceSeries(Tag);

  if Assigned(Surface) then
  begin
    Button2.LinkPen(Surface.Pen);
    Button1.LinkPen(Surface.Border);

    CBFastBrush.Checked:=Surface.FastBrush;
    CBHide.Checked:=Surface.HideTriangles;
    UDTransp.Position:=Surface.Transparency;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Surface);
  end;
end;

procedure TTriSurfaceSeriesEditor.Button3Click(Sender: TObject);
begin
  EditChartBrush(Self,Surface.Brush);
end;

procedure TTriSurfaceSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TTriSurfaceSeriesEditor.CBFastBrushClick(Sender: TObject);
begin
  Surface.FastBrush:=CBFastBrush.Checked;
end;

procedure TTriSurfaceSeriesEditor.CBHideClick(Sender: TObject);
begin
  Surface.HideTriangles:=CBHide.Checked;
end;

procedure TTriSurfaceSeriesEditor.ETranspChange(Sender: TObject);
begin
  if Showing then
     Surface.Transparency:=UDTransp.Position;
end;

initialization
  RegisterClass(TTriSurfaceSeriesEditor);
end.
