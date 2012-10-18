{******************************************}
{    TPolarSeries Editor Dialog            }
{ Copyright (c) 1996-2004 by David Berneda }
{******************************************}
unit TeePolarEditor;
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
     Chart, Series, TeePolar, TeEngine, TeCanvas, TeePenDlg, TeeProcs;

type
  TPolarSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BFont: TButton;
    CBAngleLabels: TCheckBox;
    CBLabelsRot: TCheckBox;
    CBClockWise: TCheckBox;
    CBInside: TCheckBox;
    Label2: TLabel;
    EMargin: TEdit;
    UDMargin: TUpDown;
    LAngleInc: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    CBClose: TCheckBox;
    SEAngleInc: TEdit;
    SERadiusInc: TEdit;
    UDRadiusInc: TUpDown;
    UDAngleInc: TUpDown;
    BPen: TButtonPen;
    BPiePen: TButtonPen;
    BBrush: TButton;
    Edit1: TEdit;
    UDTransp: TUpDown;
    BColor: TButtonColor;
    CBColorEach: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BPenClick(Sender: TObject);
    procedure CBCloseClick(Sender: TObject);
    procedure SEAngleIncChange(Sender: TObject);
    procedure SERadiusIncChange(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure CBAngleLabelsClick(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure CBLabelsRotClick(Sender: TObject);
    procedure CBClockWiseClick(Sender: TObject);
    procedure CBInsideClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure EMarginChange(Sender: TObject);
  private
    { Private declarations }
    PointerForm : TCustomForm;
    FCircledForm : TCustomForm;

    procedure EnableLabels;
  protected
    Polar       : TCustomPolarSeries;
    procedure HideAngleInc; virtual;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeePoEdi, TeeEdiSeri, TeeCircledEdit, TeeConst;

procedure TPolarSeriesEditor.HideAngleInc;
begin
  ShowControls(Polar is TPolarSeries,[LAngleInc,UDAngleInc,SEAngleInc]);
end;

procedure TPolarSeriesEditor.FormShow(Sender: TObject);
begin
  Polar:=TCustomPolarSeries(Tag);

  if Assigned(Polar) then
  begin

    With Polar do
    begin
      CBClose.Checked       :=CloseCircle;
      CBClockWise.Checked   :=ClockWiseLabels;
      UDAngleInc.Position   :=Round(AngleIncrement);
      UDRadiusInc.Position  :=Round(RadiusIncrement);
      CBAngleLabels.Checked :=CircleLabels;
      CBLabelsRot.Checked   :=CircleLabelsRotated;
      CBInside.Checked      :=CircleLabelsInside;
      BPiePen.LinkPen(CirclePen);
      BPen.LinkPen(Pen);
      UDMargin.Position     :=LabelsMargin;
      UDTransp.Position     :=Transparency;
      CBColorEach.Checked   :=ColorEachPoint;
    end;

    BColor.LinkProperty(Polar,'SeriesColor');

    EnableLabels;

    HideAngleInc;

    if not Assigned(FCircledForm) then
       FCircledForm:=TFormTeeSeries(Parent.Owner).InsertSeriesForm( TCircledSeriesEditor,
                                                   1,TeeMsg_GalleryCircled,
                                                   Polar);

    if not Assigned(PointerForm) then
       PointerForm:=TeeInsertPointerForm(Parent,Polar.Pointer,TeeMsg_GalleryPoint);
  end;
end;

procedure TPolarSeriesEditor.BPenClick(Sender: TObject);
begin
  With Polar do SeriesColor:=Pen.Color;
end;

procedure TPolarSeriesEditor.CBCloseClick(Sender: TObject);
begin
  Polar.CloseCircle:=CBClose.Checked;
end;

procedure TPolarSeriesEditor.SEAngleIncChange(Sender: TObject);
begin
  if Showing then Polar.AngleIncrement:=UDAngleInc.Position;
end;

procedure TPolarSeriesEditor.SERadiusIncChange(Sender: TObject);
begin
  if Showing then Polar.RadiusIncrement:=UDRadiusInc.Position;
end;

procedure TPolarSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Polar.Brush);
end;

procedure TPolarSeriesEditor.CBAngleLabelsClick(Sender: TObject);
begin
  Polar.CircleLabels:=CBAngleLabels.Checked;
  EnableLabels;
end;

procedure TPolarSeriesEditor.EnableLabels;
begin
  EnableControls(CBAngleLabels.Checked,[CBLabelsRot,CBClockWise,BFont])
end;

procedure TPolarSeriesEditor.BFontClick(Sender: TObject);
begin
  EditTeeFont(Self,Polar.CircleLabelsFont);
end;

procedure TPolarSeriesEditor.CBLabelsRotClick(Sender: TObject);
begin
  Polar.CircleLabelsRotated:=CBLabelsRot.Checked;
end;

procedure TPolarSeriesEditor.CBClockWiseClick(Sender: TObject);
begin
  Polar.ClockWiseLabels:=CBClockWise.Checked;
end;

procedure TPolarSeriesEditor.CBInsideClick(Sender: TObject);
begin
  Polar.CircleLabelsInside:=CBInside.Checked;
end;

procedure TPolarSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Polar.Transparency:=UDTransp.Position;
end;

procedure TPolarSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TPolarSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Polar.ColorEachPoint:=CBColorEach.Checked;
end;

procedure TPolarSeriesEditor.EMarginChange(Sender: TObject);
begin
  if Showing then Polar.LabelsMargin:=UDMargin.Position;
end;

initialization
  RegisterClass(TPolarSeriesEditor);
end.
