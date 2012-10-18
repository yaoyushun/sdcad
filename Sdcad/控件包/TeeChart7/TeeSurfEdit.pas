{**********************************************}
{   TSurfaceSeries Editor Dialog               }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeSurfEdit;
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
     Chart, TeeSurfa, TeCanvas, TeePenDlg, TeeProcs;

type
  TSurfaceSeriesEditor = class(TForm)
    Button2: TButtonPen;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    CBSmooth: TCheckBox;
    Button1: TButton;
    BSideLines: TButtonPen;
    Label1: TLabel;
    Edit1: TEdit;
    UDTransp: TUpDown;
    CBFastBrush: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBFastBrushClick(Sender: TObject);
  private
    { Private declarations }
    Grid3DForm : TCustomForm;
    Surface    : TSurfaceSeries;
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

procedure TSurfaceSeriesEditor.FormShow(Sender: TObject);
begin
  Surface:=TSurfaceSeries(Tag);
  if Assigned(Surface) then
  begin
    With Surface do
    begin
      if WireFrame then RadioGroup1.ItemIndex:=1 else
      if DotFrame then RadioGroup1.ItemIndex:=2 else
                       RadioGroup1.ItemIndex:=0;
      CBSmooth.Checked:=SmoothPalette;
      Button2.LinkPen(Pen);
      BSideLines.LinkPen(SideLines);
      UDTransp.Position:=Transparency;
      CBFastBrush.Checked:=FastBrush;
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Surface)
    else
       TGrid3DSeriesEditor(Grid3DForm).RefreshControls(Surface);
  end;
end;

procedure TSurfaceSeriesEditor.Button3Click(Sender: TObject);
begin
  EditChartBrush(Self,Surface.Brush);
end;

procedure TSurfaceSeriesEditor.RadioGroup1Click(Sender: TObject);
begin
  if Showing then
  Case RadioGroup1.ItemIndex of
    0: { solid }
       begin
         Surface.DotFrame:=False;
         Surface.WireFrame:=False;
       end;
    1: Surface.WireFrame:=True;
    2: Surface.DotFrame:=True;
  end;
end;

procedure TSurfaceSeriesEditor.CBSmoothClick(Sender: TObject);
begin
  Surface.SmoothPalette:=CBSmooth.Checked
end;

procedure TSurfaceSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Surface.SideBrush);
end;

procedure TSurfaceSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TSurfaceSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Surface.Transparency:=UDTransp.Position
end;

procedure TSurfaceSeriesEditor.CBFastBrushClick(Sender: TObject);
begin
  Surface.FastBrush:=CBFastBrush.Checked;
end;

initialization
  RegisterClass(TSurfaceSeriesEditor);
end.
