{******************************************}
{ TGaugeSeries Editor Dialog               }
{ Copyright (c) 2002-2004 by David Berneda }
{******************************************}
unit TeeGaugeEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
     {$ENDIF}
     TeeProcs, TeEngine, Chart, TeCanvas, TeePenDlg, TeePoEdi, TeeEdiFont,
     Series, TeeGauges, TeeCircledEdit;

type
  TGaugeSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    Button2: TButton;
    Edit1: TEdit;
    CBInside: TCheckBox;
    TabSheet3: TTabSheet;
    BTicks: TButtonPen;
    BMinor: TButtonPen;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Edit4: TEdit;
    UpDown3: TUpDown;
    BLine: TButtonPen;
    BAxis: TButtonPen;
    CheckBox4: TCheckBox;
    Button1: TButton;
    Button3: TButton;
    ComboBox1: TComboFlat;
    Label2: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Edit6: TEdit;
    UDAngle: TUpDown;
    Edit7: TEdit;
    UDDist: TUpDown;
    Edit8: TEdit;
    UDValue: TUpDown;
    Label3: TLabel;
    Edit9: TEdit;
    UDMin: TUpDown;
    Label4: TLabel;
    Edit10: TEdit;
    UDMax: TUpDown;
    Edit3: TEdit;
    UpDown2: TUpDown;
    Edit5: TEdit;
    UpDown4: TUpDown;
    Label5: TLabel;
    Edit11: TEdit;
    UDIncrement: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure Edit10Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBInsideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
  private
    { Private declarations }
    Gauge : TGaugeSeries;
    tmpCircled : TCircledSeriesEditor;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeConst, TeeEdiSeri;

procedure TGaugeSeriesEditor.Button1Click(Sender: TObject);
begin
  EditSeriesPointer(Self,Gauge.Center);
end;

procedure TGaugeSeriesEditor.Button2Click(Sender: TObject);
begin
  with TTeeFontEditor.Create(Self) do
  try
    BorderStyle:=TeeBorderStyle;
    RefreshControls(Gauge.Axis.Items.Format.Font);
    ShowModal;
  finally
    Free;
  end;
end;

procedure TGaugeSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  Gauge.Axis.Labels:=CheckBox1.Checked;
end;

procedure TGaugeSeriesEditor.Edit1Change(Sender: TObject);
begin
  Gauge.ValueFormat:=Edit1.Text;
end;

procedure TGaugeSeriesEditor.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex=0 then
     Gauge.HandStyle:=hsLine
  else
     Gauge.HandStyle:=hsTriangle;
end;

procedure TGaugeSeriesEditor.CheckBox4Click(Sender: TObject);
begin
  Gauge.FullRepaint:=CheckBox4.Checked;
end;

procedure TGaugeSeriesEditor.Button3Click(Sender: TObject);
begin
  EditSeriesPointer(Self,Gauge.EndPoint);
end;

procedure TGaugeSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Showing then
     Gauge.Axis.MinorTickCount:=UpDown1.Position;
end;

procedure TGaugeSeriesEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     Gauge.MinorTickDistance:=UpDown2.Position;
end;

procedure TGaugeSeriesEditor.Edit4Change(Sender: TObject);
begin
  if Showing then
     Gauge.Axis.TickLength:=UpDown3.Position;
end;

procedure TGaugeSeriesEditor.Edit5Change(Sender: TObject);
begin
  if Showing then
     Gauge.Axis.MinorTickLength:=UpDown4.Position;
end;

procedure TGaugeSeriesEditor.Edit6Change(Sender: TObject);
begin
  if Showing then
     Gauge.TotalAngle:=UDAngle.Position;
end;

procedure TGaugeSeriesEditor.Edit7Change(Sender: TObject);
begin
  if Showing then
     Gauge.HandDistance:=UDDist.Position;
end;

procedure TGaugeSeriesEditor.Edit8Change(Sender: TObject);
begin
  if Showing then
     Gauge.Value:=UDValue.Position;
end;

procedure TGaugeSeriesEditor.Edit9Change(Sender: TObject);
begin
  if Showing then
  begin
    Gauge.Minimum:=UDMin.Position;
    UDMax.Min:=Round(Gauge.Minimum);
  end;
end;

procedure TGaugeSeriesEditor.Edit10Change(Sender: TObject);
begin
  if Showing then
  begin
    Gauge.Maximum:=UDMax.Position;
    UDMin.Max:=Round(Gauge.Maximum);
  end;
end;

procedure TGaugeSeriesEditor.FormShow(Sender: TObject);
begin
  Gauge:=TGaugeSeries(Tag);

  if Assigned(Gauge) then
  begin
    ComboBox1.ItemIndex:=0;

    with Gauge do
    begin
      UDAngle.Position:=Round(TotalAngle);
      UDMin.Position:=Round(Minimum);
      UDMax.Position:=Round(Maximum);
      UDValue.Position:=Round(Value);
      CBInside.Checked:=LabelsInside;
      BLine.LinkPen(Pen);
      UDDist.Position:=HandDistance;
      Edit1.Text:=ValueFormat;
      UDIncrement.Position:=Round(Axis.Increment);  // 7.0

      with Axis do
      begin
        UpDown1.Position:=MinorTickCount;
        UpDown3.Position:=TickLength;
        UpDown4.Position:=MinorTickLength;
        CheckBox1.Checked:=Labels;
        BAxis.LinkPen(Axis);
        BTicks.LinkPen(Ticks);
        BMinor.LinkPen(MinorTicks);
      end;
    end;

    if not Assigned(tmpCircled) then
       tmpCircled:=TCircledSeriesEditor(
                   TFormTeeSeries(Parent.Owner).InsertSeriesForm(
                        TCircledSeriesEditor,1,TeeMsg_GalleryCircled,Gauge));

    tmpCircled.BBack.Visible:=False;
    tmpCircled.CBTransp.Visible:=False;
  end;
end;

procedure TGaugeSeriesEditor.CBInsideClick(Sender: TObject);
begin
  Gauge.LabelsInside:=CBInside.Checked;
end;

procedure TGaugeSeriesEditor.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:=TabSheet1;
end;

procedure TGaugeSeriesEditor.Edit11Change(Sender: TObject);
begin
  if Showing then
     Gauge.Axis.Increment:=UDIncrement.Position;
end;

initialization
  RegisterClass(TGaugeSeriesEditor);
end.
