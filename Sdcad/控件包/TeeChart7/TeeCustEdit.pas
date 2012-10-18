{**********************************************}
{   TCustomSeries Component Editor Dialog      }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeCustEdit;
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
     TeeProcs, Chart, Series, TeCanvas, TeePenDlg;

type
  TCustomSeriesEditor = class(TForm)
    BLineBorder: TButtonPen;
    BLineColor: TButtonColor;
    GBStair: TGroupBox;
    CBStairs: TCheckBox;
    CBInvStairs: TCheckBox;
    CBColorEach: TCheckBox;
    CBDark3D: TCheckBox;
    Label1: TLabel;
    CBStack: TComboFlat;
    LHeight: TLabel;
    EHeight: TEdit;
    UDHeight: TUpDown;
    CBClick: TCheckBox;
    BBrush: TButton;
    BOutline: TButtonPen;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure CBStairsClick(Sender: TObject);
    procedure CBInvStairsClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBDark3DClick(Sender: TObject);
    procedure CBStackChange(Sender: TObject);
    procedure EHeightChange(Sender: TObject);
    procedure CBClickClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BLineColorClick(Sender: TObject);
    procedure BLineBorderClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    PointerForm : TCustomForm;
    TheSeries : TCustomSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeEngine, TeePoEdi, TeeConst, TeeBrushDlg, TeeShadowEditor;

type TCustomSeriesAccess=class(TCustomSeries);

procedure TCustomSeriesEditor.FormShow(Sender: TObject);
begin
  TheSeries:=TCustomSeries(Tag);

  if Assigned(TheSeries) then
  begin
    With TheSeries do
    Begin
      CBColorEach.Checked:=ColorEachPoint;
      BLineBorder.LinkPen(LinePen);

      CBStack.ItemIndex:=Ord(TCustomSeriesAccess(TheSeries).Stacked);
      CBClick.Checked:=ClickableLine;
      CheckBox1.Checked:=ColorEachLine;

      if TheSeries is TLineSeries then
      begin
        CBStairs.Checked:=Stairs;
        CBInvStairs.Checked:=InvertedStairs;
        CBInvStairs.Enabled:=CBStairs.Checked;
        CBDark3D.Checked:=Dark3D;
        UDHeight.Position:=LineHeight;
        BOutLine.LinkPen(TheSeries.OutLine);
      end
      else
        ShowControls(False,[ BBrush,BOutLine,
                             GBStair,CBDark3D,LHeight,EHeight,UDHeight]);
    end;

    BLineColor.LinkProperty(TheSeries,'SeriesColor');

    if Assigned(Parent) and (not Assigned(PointerForm)) then
       PointerForm:=TeeInsertPointerForm(Parent,TheSeries.Pointer,TeeMsg_GalleryPoint);
  end;
end;

procedure TCustomSeriesEditor.CBStairsClick(Sender: TObject);
begin
  TheSeries.Stairs:=CBStairs.Checked;
  CBInvStairs.Enabled:=CBStairs.Checked;
end;

procedure TCustomSeriesEditor.CBInvStairsClick(Sender: TObject);
begin
  TheSeries.InvertedStairs:=CBInvStairs.Checked;
end;

procedure TCustomSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  TheSeries.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TCustomSeriesEditor.CBDark3DClick(Sender: TObject);
begin
  TheSeries.Dark3D:=CBDark3D.Checked;
end;

procedure TCustomSeriesEditor.CBStackChange(Sender: TObject);
begin
  TCustomSeriesAccess(TheSeries).Stacked:=TCustomSeriesStack(CBStack.ItemIndex);
end;

procedure TCustomSeriesEditor.EHeightChange(Sender: TObject);
begin
  if Showing then TheSeries.LineHeight:=UDHeight.Position
end;

procedure TCustomSeriesEditor.CBClickClick(Sender: TObject);
begin
  TheSeries.ClickableLine:=CBClick.Checked
end;

procedure TCustomSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,TheSeries.Brush);
end;

procedure TCustomSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TCustomSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  TheSeries.ColorEachLine:=CheckBox1.Checked;
end;

procedure TCustomSeriesEditor.BLineColorClick(Sender: TObject);
begin
  BLineBorder.Invalidate;
end;

procedure TCustomSeriesEditor.BLineBorderClick(Sender: TObject);
begin
  with TheSeries do
  if not ParentChart.View3D then
     SeriesColor:=LinePen.Color;

  BLineColor.Invalidate;
end;

procedure TCustomSeriesEditor.Button1Click(Sender: TObject);
begin
  with TTeeShadowEditor.Create(Self) do
  try
    RefreshControls(TheSeries.Shadow);
    CBSmooth.Hide;
    UDShadowTransp.Hide;
    EShadowTransp.Hide;
    LTransp.Hide;
    ShowModal;
  finally
    Free;
  end;
end;

initialization
  RegisterClass(TCustomSeriesEditor);
end.
