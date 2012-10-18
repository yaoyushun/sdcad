{******************************************}
{ TGridBandTool Editor Dialog              }
{ Copyright (c) 1999-2004 by David Berneda }
{******************************************}
unit TeeGridBandToolEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, Types,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeAxisToolEdit, TeCanvas, TeePenDlg, TeeProcs, TeeDraw3D, TeeTools;

type
  TGridBandToolEdit = class(TAxisToolEditor)
    BBand1: TButton;
    BBand2: TButton;
    Draw3D1: TDraw3D;
    Draw3D2: TDraw3D;
    ButtonColor1: TButtonColor;
    ButtonColor2: TButtonColor;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure BBand1Click(Sender: TObject);
    procedure BBand2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Draw3D1AfterDraw(Sender: TObject);
    procedure Draw3D2AfterDraw(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure ButtonColor2Click(Sender: TObject);
    procedure Draw3D1Click(Sender: TObject);
    procedure Draw3D2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
    GridBand : TGridBandTool;
    procedure DrawBand(ADraw3D:TDraw3D; ABand:TGridBandBrush);
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg;

procedure TGridBandToolEdit.FormCreate(Sender: TObject);
begin
  inherited;
  BPen.Visible:=False;
  BBand1.Top:=Draw3D1.Top;
  BBand2.Top:=Draw3D2.Top;
end;

procedure TGridBandToolEdit.BBand1Click(Sender: TObject);
begin
  EditChartBrush(Self,GridBand.Band1);
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.BBand2Click(Sender: TObject);
begin
  EditChartBrush(Self,GridBand.Band2);
  Draw3D2.Invalidate;
end;

procedure TGridBandToolEdit.FormShow(Sender: TObject);
begin
  inherited;
  GridBand:=TGridBandTool(Tag);
  if Assigned(GridBand) then
  begin
    ButtonColor1.LinkProperty(GridBand.Band1,'BackColor');
    ButtonColor2.LinkProperty(GridBand.Band2,'BackColor');
    UpDown1.Position:=GridBand.Band1.Transparency;
    UpDown2.Position:=GridBand.Band2.Transparency;
  end;
end;

procedure TGridBandToolEdit.Draw3D1AfterDraw(Sender: TObject);
begin
  if Assigned(GridBand) then DrawBand(Draw3D1,GridBand.Band1);
end;

procedure TGridBandToolEdit.Draw3D2AfterDraw(Sender: TObject);
begin
  if Assigned(GridBand) then DrawBand(Draw3D2,GridBand.Band2);
end;

procedure TGridBandToolEdit.DrawBand(ADraw3D:TDraw3D; ABand:TGridBandBrush);
var tmpR : TRect;
begin
  with ADraw3D do
  begin
    Canvas.AssignBrushColor(ABand,ABand.Color,GridBand.BandBackColor(ABand));
    tmpR:=ChartBounds;
    InflateRect(tmpR,-1,-1);
    Canvas.FillRect(tmpR);
  end;
end;

procedure TGridBandToolEdit.ButtonColor1Click(Sender: TObject);
begin
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.ButtonColor2Click(Sender: TObject);
begin
  Draw3D2.Invalidate;
end;

procedure TGridBandToolEdit.Draw3D1Click(Sender: TObject);
begin
  with GridBand.Band1 do Color:=EditColor(Self,Color);
  Draw3D1.Invalidate;
end;

procedure TGridBandToolEdit.Draw3D2Click(Sender: TObject);
begin
  with GridBand.Band2 do Color:=EditColor(Self,Color);
  Draw3D2.Invalidate;
end;

procedure TGridBandToolEdit.Edit1Change(Sender: TObject);
begin
  if Showing then
     GridBand.Band1.Transparency:=UpDown1.Position;
end;

procedure TGridBandToolEdit.Edit2Change(Sender: TObject);
begin
  if Showing then
     GridBand.Band2.Transparency:=UpDown2.Position;
end;

initialization
  RegisterClass(TGridBandToolEdit);
end.
