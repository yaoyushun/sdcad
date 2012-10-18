{**********************************************}
{   TPoint3DSeries Component Editor Dialog     }
{   Copyright (c) 1998-2004 by David Berneda   }
{**********************************************}
unit TeePo3DEdit;
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
     Chart, Series, TeePoin3, TeCanvas, TeePenDlg, TeeProcs;

type
  TPoint3DSeriesEditor = class(TForm)
    GPLine: TGroupBox;
    BColor: TButtonColor;
    CBColorEach: TCheckBox;
    Button1: TButtonPen;
    Label4: TLabel;
    SEPointDepth: TEdit;
    UDPointDepth: TUpDown;
    BBasePen: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure SEPointDepthChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    PointerForm : TCustomForm;
    TheSeries   : TPoint3DSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeEngine, TeePoEdi, TeeConst;

procedure TPoint3DSeriesEditor.FormShow(Sender: TObject);
begin
  TheSeries:=TPoint3DSeries(Tag);
  if Assigned(TheSeries) then
  begin
    With TheSeries do
    Begin
      UDPointDepth.Position :=Round(DepthSize);
      CBColorEach.Checked:=ColorEachPoint;
      Button1.LinkPen(LinePen);
      BBasePen.LinkPen(BaseLine);
    end;

    BColor.LinkProperty(TheSeries,'SeriesColor');
    BColor.Enabled:=not TheSeries.ColorEachPoint;

    if not Assigned(PointerForm) then
       PointerForm:=TeeInsertPointerForm(Parent,TheSeries.Pointer,TeeMsg_GalleryPoint);
  end;
end;

procedure TPoint3DSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=CBColorEach.Checked;
  BColor.Enabled:=not TheSeries.ColorEachPoint;
end;

procedure TPoint3DSeriesEditor.SEPointDepthChange(Sender: TObject);
begin
  if Showing then TheSeries.DepthSize:=UDPointDepth.Position;
end;

procedure TPoint3DSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TPoint3DSeriesEditor);
end.
