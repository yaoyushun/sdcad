{**********************************************}
{   TeeChart Pro 3D editor options             }
{   Copyright (c) 1999-2004 by David Berneda   }
{**********************************************}
unit TeeEdi3D;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
     TeePenDlg,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeCanvas, TeEngine, Chart, TeeGalleryPanel;

type
  TFormTee3D = class(TForm)
    PageControl1: TPageControl;
    Tab3D: TTabSheet;
    TabViews: TTabSheet;
    L13: TLabel;
    L4: TLabel;
    L35: TLabel;
    L36: TLabel;
    LZoom: TLabel;
    LRotation: TLabel;
    LElevation: TLabel;
    Label1: TLabel;
    LHOffset: TLabel;
    Label3: TLabel;
    LVOffset: TLabel;
    Label2: TLabel;
    LPerspec: TLabel;
    Label4: TLabel;
    LTextSize: TLabel;
    CBView3d: TCheckBox;
    SE3d: TEdit;
    CBOrthogonal: TCheckBox;
    SBZoom: TTrackBar;
    SBRotation: TTrackBar;
    SBElevation: TTrackBar;
    SBHOffset: TTrackBar;
    SBVOffset: TTrackBar;
    UD3D: TUpDown;
    CBZoomText: TCheckBox;
    SBPerspec: TTrackBar;
    EOrthoAngle: TEdit;
    UDOrthoAngle: TUpDown;
    CBClipPoints: TCheckBox;
    ETextSize: TEdit;
    UDTextSize: TUpDown;
    ChartGalleryPanel1: TChartGalleryPanel;
    procedure CBOrthogonalClick(Sender: TObject);
    procedure SBZoomChange(Sender: TObject);
    procedure SBRotationChange(Sender: TObject);
    procedure SBElevationChange(Sender: TObject);
    procedure CBView3dClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBHOffsetChange(Sender: TObject);
    procedure SBVOffsetChange(Sender: TObject);
    procedure SE3dChange(Sender: TObject);
    procedure CBZoomTextClick(Sender: TObject);
    procedure SBPerspecChange(Sender: TObject);
    procedure EOrthoAngleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBClipPointsClick(Sender: TObject);
    procedure ETextSizeChange(Sender: TObject);
    procedure ChartGalleryPanel1ChangeChart(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    AllowRotation : Boolean;
    Changing      : Boolean;
    TheChart      : TCustomChart;

    procedure CreateViewsGallery;
    Function GetRotation:Integer;
    procedure RefreshOptions;
    procedure Select3DChart(AChart:TCustomChart);
    procedure SetGallery3DChart(AChart:TCustomChart);
  public
    { Public declarations }
    ResetTab3D : Boolean;

    Constructor CreateChart(AOwner:TComponent; AChart:TCustomChart);
    Procedure CheckControls;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses Series, TeeConst;

Constructor TFormTee3D.CreateChart(AOwner:TComponent; AChart:TCustomChart);
begin
  inherited Create(AOwner);
  TheChart:=AChart;
end;

Procedure TFormTee3D.CheckControls;
var tmpSeries : TChartSeries;
begin
  tmpSeries:=TheChart.GetASeries;

  AllowRotation:=TheChart.Canvas.SupportsFullRotation or
                 (not Assigned(tmpSeries)) or
                 (not (tmpSeries is TPieSeries));

  if ResetTab3D then
     if PageControl1.ActivePage<>Tab3D then
        PageControl1.ActivePage:=Tab3D;

  With TheChart do
  begin
    CBOrthogonal.Enabled:=View3D and AllowRotation;
    SBElevation.Enabled :=View3D and (Canvas.SupportsFullRotation or (not View3DOptions.Orthogonal));
    SBRotation.Enabled  :=SBElevation.Enabled and CBOrthogonal.Enabled;
    EOrthoAngle.Enabled:=CBOrthogonal.Enabled;
    UDOrthoAngle.Enabled:=EOrthoAngle.Enabled;
  end;
end;

procedure TFormTee3D.CBOrthogonalClick(Sender: TObject);
begin
  if not Changing then
  begin
    TheChart.View3DOptions.Orthogonal:=CBOrthogonal.Checked;
    CheckControls;
  end;
end;

procedure TFormTee3D.SBZoomChange(Sender: TObject);
begin
  TheChart.View3DOptions.Zoom:=SBZoom.Position;
  LZoom.Caption:=IntToStr(SBZoom.Position)+'%';
end;

Function TFormTee3D.GetRotation:Integer;
begin
  result:=SBRotation.Position;
end;

procedure TFormTee3D.SBRotationChange(Sender: TObject);
var tmp : Integer;
begin
  tmp:=GetRotation;

  if not Changing then
     if Assigned(TheChart) and Assigned(TheChart.View3DOptions) then
        TheChart.View3DOptions.Rotation:=tmp;

  LRotation.Caption:=IntToStr(tmp);
end;

procedure TFormTee3D.SBElevationChange(Sender: TObject);
begin
  if not Changing then
     if Assigned(TheChart) and Assigned(TheChart.View3DOptions) then
        TheChart.View3DOptions.Elevation:=SBElevation.Position;

  LElevation.Caption:=IntToStr(SBElevation.Position);
end;

procedure TFormTee3D.CBView3dClick(Sender: TObject);
begin
  if not Changing then
  begin
    TheChart.View3D:=CBView3D.Checked;
    CheckControls;
  end;
end;

procedure TFormTee3D.FormShow(Sender: TObject);
begin
  if Assigned(TheChart) then
     RefreshOptions;
end;

procedure TFormTee3D.RefreshOptions;
begin
  Changing:=True;

  With TheChart do
  begin
    CBView3D.Checked:=View3D;
    UD3D.Position:=Chart3DPercent;
    CBClipPoints.Checked:=ClipPoints;

    if Canvas.SupportsFullRotation then
    begin
      SBRotation.Min:=0;
      SBRotation.Frequency:=20;
      SBElevation.Min:=0;
      SBElevation.Frequency:=20;
    end
    else
    begin
      SBRotation.Min:=0;
      SBRotation.Frequency:=45;
      SBElevation.Min:=TeeMinAngle;
      SBElevation.Frequency:=10;
    end;

    With View3DOptions do
    begin
      SBZoom.Position      :=Zoom;
      CBOrthogonal.Checked :=Orthogonal;
      SBRotation.Position  :=Rotation;
      SBElevation.Position :=Elevation;
      SBHOffset.Position   :=HorizOffset;
      SBVOffset.Position   :=VertOffset;
      CBZoomText.Checked   :=ZoomText;
      SBPerspec.Position   :=Perspective;
      UDOrthoAngle.Position:=OrthoAngle;
      UDTextSize.Position  :=FontZoom;
    end;
  end;

  CheckControls;

  Changing:=False;
end;

procedure TFormTee3D.SBHOffsetChange(Sender: TObject);
begin
  TheChart.View3DOptions.HorizOffset:=SBHOffset.Position;
  LHOffset.Caption:=IntToStr(SBHOffset.Position);
end;

procedure TFormTee3D.SBVOffsetChange(Sender: TObject);
begin
  TheChart.View3DOptions.VertOffset:=SBVOffset.Position;
  LVOffset.Caption:=IntToStr(SBVOffset.Position);
end;

procedure TFormTee3D.SE3dChange(Sender: TObject);
begin
  if Showing and (not Changing) then
     TheChart.Chart3DPercent:=UD3D.Position;
end;

procedure TFormTee3D.CBZoomTextClick(Sender: TObject);
begin
  TheChart.View3DOptions.ZoomText:=CBZoomText.Checked;
end;

procedure TFormTee3D.SBPerspecChange(Sender: TObject);
begin
  TheChart.View3DOptions.Perspective:=SBPerspec.Position;
  LPerspec.Caption:=IntToStr(SBPerspec.Position);
end;

procedure TFormTee3D.EOrthoAngleChange(Sender: TObject);
begin
  if Showing and (not Changing) then
     TheChart.View3DOptions.OrthoAngle:=UDOrthoAngle.Position;
end;

procedure TFormTee3D.SetGallery3DChart(AChart:TCustomChart);
begin
  with ChartGalleryPanel1 do
  if SelectedChart<>nil then
  with SelectedChart do
  begin
    AChart.View3D:=View3D;
    AChart.View3DOptions.Orthogonal:=View3DOptions.Orthogonal;
    AChart.View3DOptions.OrthoAngle:=View3DOptions.OrthoAngle;
    AChart.View3DOptions.Rotation:=View3DOptions.Rotation;
    AChart.View3DOptions.Elevation:=View3DOptions.Elevation;
  end;
end;

procedure TFormTee3D.Select3DChart(AChart:TCustomChart);
var t,tmp : Integer;
    tmpC  : TCustomChart;
begin
  tmp:=-1;

  with ChartGalleryPanel1 do
  begin
    for t:=0 to Charts.Count-1 do
    begin
      tmpC:=Charts[t];
      with tmpC do
      if (View3D=AChart.View3D) and
         (View3DOptions.Orthogonal=AChart.View3DOptions.Orthogonal) and
         (View3DOptions.OrthoAngle=AChart.View3DOptions.OrthoAngle) and
         (View3DOptions.Rotation=AChart.View3DOptions.Rotation) and
         (View3DOptions.Elevation=AChart.View3DOptions.Elevation) then
      begin
        tmp:=t;
        break;
      end;
    end;

    if tmp=-1 then SelectChart(nil)
              else SelectChart(Charts[tmp]);
  end;
end;

procedure TFormTee3D.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  ResetTab3D:=True;
end;

procedure TFormTee3D.CreateViewsGallery;

  Function AddNewChart(const ATitle:String; Is3D:Boolean=False):TCustomChart;
  var t : Integer;
  begin
    result:=ChartGalleryPanel1.CreateChart(TeeSeriesTypes[0]) as TCustomChart;

    with result do
    begin
      Walls.Back.Transparent:=False;
      Walls.Size:=5;
      SeriesList.ClearValues;
      Title.Text[0]:=ATitle;

      if Is3D then
      begin
        View3D:=True;
        View3DOptions.Orthogonal:=False;

        for t:=0 to SeriesCount-1 do
            Series[t].VertAxis:=aBothVertAxis;

        View3DOptions.Elevation:=360;
        Axes.Left.Labels:=True;
      end;
    end;
  end;

var t : Integer;
begin
  with ChartGalleryPanel1 do
  begin
    Smooth:=False;
    DisplaySub:=False;
    FocusRotation:=False;

    NumCols:=3;
    NumRows:=2;

    with AddNewChart(TeeMsg_View2D) do
    begin
      View3D:=False;
      Axes.Left.Labels:=True;
    end;

    with AddNewChart('Ortho Right') do
    begin
      View3DOptions.Orthogonal:=True;
      Axes.Left.Labels:=True;
    end;

    with AddNewChart('Ortho Left') do
    begin
      View3DOptions.Orthogonal:=True;
      Walls.Left.Hide;
      Walls.Right.Visible:=True;

      for t:=0 to SeriesCount-1 do
          Series[t].VertAxis:=aRightAxis;

      Axes.Right.ZPosition:=0;
      View3DOptions.OrthoAngle:=135;
    end;

    with AddNewChart('3D Front',True) do
    begin
      Walls.Left.Visible:=True;
      Walls.Right.Visible:=True;
      Axes.Right.ZPosition:=0;
      View3DOptions.Rotation:=360;
    end;

    with AddNewChart('3D Right',True) do
    begin
      Walls.Left.Visible:=True;
      Walls.Right.Hide;
      Axes.Right.ZPosition:=100;
      View3DOptions.Rotation:=300;
    end;

    with AddNewChart('3D Left',True) do
    begin
      Walls.Left.Hide;
      Walls.Right.Visible:=True;
      Axes.Right.ZPosition:=0;
      Axes.Left.ZPosition:=100;
      View3DOptions.Rotation:=45;
    end;
  end;
end;

procedure TFormTee3D.CBClipPointsClick(Sender: TObject);
begin
  TheChart.ClipPoints:=CBClipPoints.Checked;
end;

procedure TFormTee3D.ETextSizeChange(Sender: TObject);
begin
  if Showing and (not Changing) then
     TheChart.View3DOptions.FontZoom:=UDTextSize.Position;
end;

procedure TFormTee3D.ChartGalleryPanel1ChangeChart(Sender: TObject);
begin
  SetGallery3DChart(TheChart);
end;

procedure TFormTee3D.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabViews then
  begin
    if ChartGalleryPanel1.Charts.Count=0 then
       CreateViewsGallery;
    Select3DChart(TheChart);
  end
  else RefreshOptions;
end;

end.
