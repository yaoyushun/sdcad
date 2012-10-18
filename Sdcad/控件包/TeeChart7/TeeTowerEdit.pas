{******************************************}
{ TTowerSeries Editor Dialog               }
{ Copyright (c) 2002-2004 by David Berneda }
{******************************************}
unit TeeTowerEdit;
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
  TTowerSeriesEditor = class(TForm)
    ButtonPen1: TButtonPen;
    Button1: TButton;
    CBDark3D: TCheckBox;
    GroupBox1: TGroupBox;
    CBOrigin: TCheckBox;
    EOrigin: TEdit;
    Label1: TLabel;
    CBStyle: TComboFlat;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    UDDepth: TUpDown;
    Label3: TLabel;
    Edit2: TEdit;
    UDWidth: TUpDown;
    Label4: TLabel;
    Edit3: TEdit;
    UDTransp: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBDark3DClick(Sender: TObject);
    procedure CBOriginClick(Sender: TObject);
    procedure EOriginChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
  private
    { Private declarations }
    Tower : TTowerSeries;
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

procedure TTowerSeriesEditor.FormShow(Sender: TObject);
begin
  Tower:=TTowerSeries(Tag);

  if Assigned(Tower) then
  begin
    With Tower do
    begin
      ButtonPen1.LinkPen(Pen);
      CBDark3D.Checked:=Dark3D;
      CBOrigin.Checked:=UseOrigin;
      EOrigin.Text:=FloatToStr(Origin);
      CBStyle.ItemIndex:=Ord(TowerStyle);
      UDDepth.Position:=PercentDepth;
      UDWidth.Position:=PercentWidth;
      UDTransp.Position:=Transparency;
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Tower);
  end;
end;

procedure TTowerSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TTowerSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Tower.Brush);
end;

procedure TTowerSeriesEditor.CBDark3DClick(Sender: TObject);
begin
  Tower.Dark3D:=CBDark3D.Checked;
end;

procedure TTowerSeriesEditor.CBOriginClick(Sender: TObject);
begin
  Tower.UseOrigin:=CBOrigin.Checked;
end;

procedure TTowerSeriesEditor.EOriginChange(Sender: TObject);
begin
  Tower.Origin:=StrToFloatDef(EOrigin.Text,Tower.Origin)
end;

procedure TTowerSeriesEditor.CBStyleChange(Sender: TObject);
begin
  Tower.TowerStyle:=TTowerStyle(CBStyle.ItemIndex);
end;

procedure TTowerSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     Tower.PercentDepth:=UDDepth.Position;
end;

procedure TTowerSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Showing then
     Tower.PercentWidth:=UDWidth.Position;
end;

procedure TTowerSeriesEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     Tower.Transparency:=UDTransp.Position;
end;

initialization
  RegisterClass(TTowerSeriesEditor);
end.
