{**********************************************}
{   TGrid3DSeries Editor Dialog                }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeGriEd;
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
     TeeProcs, Chart, TeeSurfa, TeCanvas, TeePenDlg;

type
  TGrid3DSeriesEditor = class(TForm,ITeeEventListener)
    GroupBox2: TGroupBox;
    SEXGrid: TEdit;
    UDXGrid: TUpDown;
    SEZGrid: TEdit;
    UDZGrid: TUpDown;
    Label1: TLabel;
    Label5: TLabel;
    LDepth: TLabel;
    EDepth: TEdit;
    UDDepth: TUpDown;
    CBIrreg: TCheckBox;
    PageControl1: TPageControl;
    TabSingle: TTabSheet;
    BColor: TButtonColor;
    TabRange: TTabSheet;
    BFromColor: TButtonColor;
    BMidColor: TButtonColor;
    BToColor: TButtonColor;
    CheckBox1: TCheckBox;
    Button1: TButton;
    TabPalette: TTabSheet;
    Label4: TLabel;
    SEPalette: TEdit;
    UDPalette: TUpDown;
    Label2: TLabel;
    CBPalStyle: TComboFlat;
    CBUseMin: TCheckBox;
    Label3: TLabel;
    EPaletteMin: TEdit;
    Label6: TLabel;
    EPaletteStep: TEdit;
    Edit1: TEdit;
    UDLegendEvery: TUpDown;
    BRemove: TButton;
    Timer1: TTimer;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure SEZGridChange(Sender: TObject);
    procedure SEPaletteChange(Sender: TObject);
    procedure EDepthChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBIrregClick(Sender: TObject);
    procedure CBPalStyleChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure CBUseMinClick(Sender: TObject);
    procedure EPaletteMinChange(Sender: TObject);
    procedure EPaletteStepChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BMidColorClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BRemoveClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Grid3D : TCustom3DPaletteSeries;

    procedure CheckMidColor;

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);  { interface }
  protected
    Creating : Boolean;
  public
    { Public declarations }
    procedure RefreshControls(AGrid:TCustom3DPaletteSeries);
  end;

Function TeeInsertGrid3DForm(AParent:TControl; AGrid3D:TCustom3DPaletteSeries):TCustomForm;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeeProCo, TeeEdiSeri, TeEngine, TeeEdiGrad;

Function TeeInsertGrid3DForm(AParent:TControl; AGrid3D:TCustom3DPaletteSeries):TCustomForm;
begin
  if Assigned(AParent) then
     result:=(AParent.Owner as TFormTeeSeries).InsertSeriesForm( TGrid3DSeriesEditor,
                                                     1,TeeMsg_Grid3D,
                                                     AGrid3D)
  else
     result:=nil;
end;

type
  TCustom3DGridSeriesAccess=class(TCustom3DGridSeries);
  {$IFNDEF CLR}
  TTeePanelAccess=class(TCustomTeePanel);
  {$ENDIF}

procedure TGrid3DSeriesEditor.RefreshControls(AGrid:TCustom3DPaletteSeries);
begin
  Grid3D:=AGrid;

  if Grid3D is TCustom3DGridSeries then
  With TCustom3DGridSeriesAccess(Grid3D) do
  begin
    UDXGrid.Position:=NumXValues;
    UDZGrid.Position:=NumZValues;
    CBIrreg.Checked :=IrregularGrid;
    EnableControls(CanCreateValues,[UDXGrid,UDZGrid,SEXGrid,SEZGrid]);
  end
  else
  begin
    EnableControls(False,[SEXGrid,SEZGrid,UDXGrid,UDZGrid]);
    CBIrreg.Visible:=False;
  end;

  if Assigned(Grid3D) then
  begin
    With Grid3D do
    begin
      UDDepth.Position:=TimesZOrder;
      UDPalette.Position:=PaletteSteps;
      CBPalStyle.ItemIndex:=Ord(PaletteStyle);

      if UseColorRange then
         PageControl1.ActivePage:=TabRange
      else
      if UsePalette then
         PageControl1.ActivePage:=TabPalette
      else
         PageControl1.ActivePage:=TabSingle;

      CBUseMin.Checked:=UsePaletteMin;
      EPaletteMin.Text:=FloatToStr(PaletteMin);
      EPaletteMin.Enabled:=UsePaletteMin;
      EPaletteStep.Text:=FloatToStr(PaletteStep);

      UDLegendEvery.Position:=LegendEvery;

      CheckMidColor;
    end;

    BRemove.Enabled:=HasColors(Grid3D);

    BColor.LinkProperty(Grid3D,'SeriesColor');
    BFromColor.LinkProperty(Grid3D,'StartColor');
    BMidColor.LinkProperty(Grid3D,'MidColor');
    BToColor.LinkProperty(Grid3D,'EndColor');

    if Assigned(Grid3D.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Grid3D.ParentChart).Listeners.Add(Self);
  end;
end;

procedure TGrid3DSeriesEditor.FormShow(Sender: TObject);
begin
  RefreshControls(TCustom3DPaletteSeries(Tag));
  Creating:=False;

  // Hack.
  Timer1.Enabled:=True;
end;

procedure TGrid3DSeriesEditor.SEZGridChange(Sender: TObject);
begin
  if not Creating then
  if Grid3D is TCustom3DGridSeries then
  With TCustom3DGridSeries(Grid3D) do
     if (UDXGrid.Position<>NumXValues) or (UDZGrid.Position<>NumZValues) then
        CreateValues(UDXGrid.Position,UDZGrid.Position);
end;

procedure TGrid3DSeriesEditor.SEPaletteChange(Sender: TObject);
begin
  if not Creating then
     Grid3D.PaletteSteps:=UDPalette.Position;
end;

procedure TGrid3DSeriesEditor.EDepthChange(Sender: TObject);
begin
  if not Creating then Grid3D.TimesZOrder:=UDDepth.Position;
end;

procedure TGrid3DSeriesEditor.FormCreate(Sender: TObject);
begin
  Creating:=True;
  Align:=alClient;
end;

procedure TGrid3DSeriesEditor.CBIrregClick(Sender: TObject);
begin
  TCustom3DGridSeries(Grid3D).IrregularGrid:=CBIrreg.Checked
end;

procedure TGrid3DSeriesEditor.CBPalStyleChange(Sender: TObject);
begin
  Grid3D.PaletteStyle:=TTeePaletteStyle(CBPalStyle.ItemIndex);
end;

procedure TGrid3DSeriesEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(Grid3D) and Assigned(Grid3D.ParentChart) then
     {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Grid3D.ParentChart).RemoveListener(Self);
end;

procedure TGrid3DSeriesEditor.TeeEvent(Event: TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
     if Event is TTeeSeriesEvent then
     With TTeeSeriesEvent(Event) do
          if Event=seChangeColor then BColor.Invalidate;
end;

procedure TGrid3DSeriesEditor.PageControl1Change(Sender: TObject);
begin
  if not Creating then
  begin
    if PageControl1.ActivePage=TabSingle then
    begin
      With Grid3D do
      begin
        ColorEachPoint:=True;
        ColorEachPoint:=False;
        UseColorRange:=False;
        UsePalette:=False;
      end;
    end
    else
    if PageControl1.ActivePage=TabRange then
    begin
      Grid3D.UseColorRange:=True;
      Grid3D.UsePalette:=False;
    end
    else
    begin
      Grid3D.UseColorRange:=False;
      Grid3D.UsePalette:=True;
    end;
  end;
end;

procedure TGrid3DSeriesEditor.CBUseMinClick(Sender: TObject);
begin
  Grid3D.UsePaletteMin:=CBUseMin.Checked;
  EPaletteMin.Enabled:=Grid3D.UsePaletteMin;
end;

procedure TGrid3DSeriesEditor.EPaletteMinChange(Sender: TObject);
begin
  if not Creating then
     with Grid3D do PaletteMin:=StrToFloatDef(EPaletteMin.Text,PaletteMin);
end;

procedure TGrid3DSeriesEditor.EPaletteStepChange(Sender: TObject);
begin
  if not Creating then
     with Grid3D do PaletteStep:=StrToFloatDef(EPaletteStep.Text,PaletteStep);
end;

procedure TGrid3DSeriesEditor.Button1Click(Sender: TObject);
var tmp : TColor;
begin
  with Grid3D do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
  end;

  BFromColor.Invalidate;
  BToColor.Invalidate;
end;

procedure TGrid3DSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Grid3D.MidColor:=clNone;
    BMidColor.Repaint;
  end;

  CheckBox1.Enabled:=not CheckBox1.Checked;
end;

procedure TGrid3DSeriesEditor.CheckMidColor;
begin
  CheckBox1.Checked:=Grid3D.MidColor=clNone;
  CheckBox1.Enabled:=not CheckBox1.Checked;
end;

procedure TGrid3DSeriesEditor.BMidColorClick(Sender: TObject);
begin
  CheckMidColor;
end;

procedure TGrid3DSeriesEditor.Edit1Change(Sender: TObject);
begin
  if not Creating then
     with Grid3D do LegendEvery:=UDLegendEvery.Position;
end;

procedure TGrid3DSeriesEditor.BRemoveClick(Sender: TObject);
var t : Integer;
begin
  with Grid3D do
  for t:=0 to Count-1 do ValueColor[t]:=clTeeColor;
  BRemove.Enabled:=False;
end;

procedure TGrid3DSeriesEditor.Timer1Timer(Sender: TObject);
var Old : TTabSheet;
begin
  Timer1.Enabled:=False;
  Old:=PageControl1.ActivePage;
  PageControl1.ActivePage:=nil;
  PageControl1.ActivePage:=Old;
end;

procedure TGrid3DSeriesEditor.Button2Click(Sender: TObject);
var tmp : TTeeGradient;

  Function EditedGradient:Boolean;
  begin
    with TTeeGradientEditor.Create(Self) do  // 7.0
    try
      Align:=alNone;

      RefreshGradient(tmp);
      Panel2.Hide;
      TabSheet1.TabVisible:=False;
      TabSheet2.TabVisible:=False;
      result:=ShowModal=mrOk;
    finally
      Free;
    end;
  end;

begin
  tmp:=TTeeGradient.Create(nil);
  try
    tmp.Visible:=True;
    tmp.StartColor:=Grid3D.StartColor;
    tmp.MidColor:=Grid3D.MidColor;
    tmp.EndColor:=Grid3D.EndColor;

    if EditedGradient then
    begin
      Grid3D.StartColor:=tmp.StartColor;
      Grid3D.MidColor:=tmp.MidColor;
      Grid3D.EndColor:=tmp.EndColor;

      BFromColor.Invalidate;
      BMidColor.Invalidate;
      BToColor.Invalidate;
      CheckMidColor;
    end;
  finally
    tmp.Free;
  end;
end;

initialization
  RegisterClass(TGrid3DSeriesEditor);
end.
