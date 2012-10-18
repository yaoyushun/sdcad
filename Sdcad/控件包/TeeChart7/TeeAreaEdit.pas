{**********************************************}
{   TAreaSeries Component Editor Dialog        }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeAreaEdit;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     Borland.VCL.Controls,
     Borland.VCL.Forms,
     Borland.VCL.ExtCtrls,
     Borland.VCL.StdCtrls,
     Borland.VCL.ComCtrls,
     Borland.VCL.Graphics,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$ENDIF}
     Chart, Series, TeCanvas, TeePenDlg, TeeProcs;

type
  TAreaSeriesEditor = class(TForm)
    RGMultiArea: TRadioGroup;
    GroupBox2: TGroupBox;
    CBStairs: TCheckBox;
    BAreaLinesPen: TButtonPen;
    BAreaLinePen: TButtonPen;
    GroupBox1: TGroupBox;
    CBColorEach: TCheckBox;
    BAreaColor: TButtonColor;
    CBInvStairs: TCheckBox;
    GroupBox3: TGroupBox;
    CBUseOrigin: TCheckBox;
    Label1: TLabel;
    EOrigin: TEdit;
    UDOrigin: TUpDown;
    BPattern: TButton;
    Button1: TButton;
    LHeight: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure RGMultiAreaClick(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBStairsClick(Sender: TObject);
    procedure CBInvStairsClick(Sender: TObject);
    procedure CBUseOriginClick(Sender: TObject);
    procedure EOriginChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BPatternClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
  private
    { Private declarations }
    Area : TAreaSeries;
    PointerForm : TCustomForm;
    FGradientForm : TCustomForm;
    
    Procedure EnableOrigin;
    Function GetAreaColor:TColor;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine, TeeEdiSeri, TeeEdiGrad, TeeBrushDlg, TeePoEdi, TeeConst;

type TFormTeeSeriesAccess=class(TFormTeeSeries);

procedure TAreaSeriesEditor.FormShow(Sender: TObject);
begin
  Area:=TAreaSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));
  if Assigned(Area) then
  begin
    With Area do
    begin
      RGMultiArea.ItemIndex :=Ord(MultiArea);
      CBColorEach.Checked   :=ColorEachPoint;
      CBStairs.Checked      :=Stairs;
      CBInvStairs.Checked   :=InvertedStairs;
      CBInvStairs.Enabled   :=Stairs;
      CBUseOrigin.Checked   :=UseYOrigin;
      UDOrigin.Position     :=Round(YOrigin);
      BAreaLinesPen.LinkPen(AreaLinesPen);
      BAreaLinePen.LinkPen(LinePen);
      UDTransp.Position     :=Transparency;
    end;

    With BAreaColor do
    begin
      GetColorProc:=GetAreaColor;
      LinkProperty(Area,'SeriesColor');
      Enabled:=not Area.ColorEachPoint;
    end;

    EnableOrigin;

    if not Assigned(PointerForm) then
       PointerForm:=TeeInsertPointerForm(Parent,Area.Pointer,TeeMsg_GalleryPoint);

    { 5.03, gradient editor at area editor }
    if (not Assigned(FGradientForm)) and Assigned(Parent) then
    begin
      FGradientForm:=TFormTeeSeriesAccess(Parent.Owner).InsertSeriesForm(
                        TTeeGradientEditor,2,TeeMsg_Gradient,Area.Gradient);

      with FGradientForm as TTeeGradientEditor do
      begin
        BOk.Visible:=False;
        BCancel.Visible:=False;
      end;
    end;
  end;
end;

procedure TAreaSeriesEditor.RGMultiAreaClick(Sender: TObject);
begin
  Area.MultiArea:=TMultiArea(RGMultiArea.ItemIndex);
end;

procedure TAreaSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Area.ColorEachPoint:=CBColorEach.Checked;
  BAreaColor.Enabled:=not Area.ColorEachPoint;
end;

Function TAreaSeriesEditor.GetAreaColor:TColor;
begin
  With Area do
  if AreaColor=clTeeColor then result:=SeriesColor
                          else result:=AreaColor;
end;

procedure TAreaSeriesEditor.CBStairsClick(Sender: TObject);
begin
  Area.Stairs:=CBStairs.Checked;
  CBInvStairs.Enabled:=Area.Stairs;
end;

procedure TAreaSeriesEditor.CBInvStairsClick(Sender: TObject);
begin
  Area.InvertedStairs:=CBInvStairs.Checked;
end;

procedure TAreaSeriesEditor.CBUseOriginClick(Sender: TObject);
begin
  Area.UseYOrigin:=CBUseOrigin.Checked;
  EnableOrigin;
end;

procedure TAreaSeriesEditor.EOriginChange(Sender: TObject);
begin
  if Showing then Area.YOrigin:=UDOrigin.Position
end;

Procedure TAreaSeriesEditor.EnableOrigin;
begin
  EOrigin.Enabled:=CBUseOrigin.Checked;
  UDOrigin.Enabled:=EOrigin.Enabled;
end;

procedure TAreaSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;
end;

procedure TAreaSeriesEditor.BPatternClick(Sender: TObject);
begin
  EditChartBrush(Self,Area.AreaChartBrush);
end;

procedure TAreaSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Area.Brush);
end;

procedure TAreaSeriesEditor.ETranspChange(Sender: TObject);
begin
  if Showing then Area.Transparency:=UDTransp.Position;
end;

initialization
  RegisterClass(TAreaSeriesEditor);
end.
