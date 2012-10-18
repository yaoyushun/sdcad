{*******************************************}
{ TeeChart Pro visual Themes                }
{ Copyright (c) 2003-2004 by David Berneda  }
{ All Rights Reserved                       }
{*******************************************}
unit TeeThemes;
{$I TeeDefs.inc}

interface

uses Classes,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, TeCanvas;

type
  TDefaultTheme=class(TChartTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis);
    procedure ChangeSeries(Series:TChartSeries);
    procedure ChangeWall(Wall:TChartWall; AColor:TColor);
    procedure ResetGradient(Gradient:TTeeGradient);
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TExcelTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TClassicTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TBusinessTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TWebTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TWindowsXPTheme=class(TBusinessTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TBlueSkyTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart; PaletteIndex:Integer); overload;
procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart); overload;

type
  TThemesList=class(TList)
  private
    function GetTheme(Index:Integer):TChartThemeClass;
  public
    property Theme[Index:Integer]:TChartThemeClass read GetTheme; default;
  end;

var 
  ChartThemes : TThemesList=nil;

procedure RegisterChartThemes(const Themes:Array of TChartThemeClass);

implementation

uses {$IFDEF CLX}
     QControls,
     {$ELSE}
     Controls,
     {$ENDIF}
     TeeConst, TeeProCo, TeeProcs;

{ TDefaultTheme }
function TDefaultTheme.Description: string;
begin
  result:='TeeChart default';
end;

procedure TDefaultTheme.ResetGradient(Gradient:TTeeGradient);
begin
  with Gradient do
  begin
    Visible:=False;
    StartColor:=clWhite;
    Direction:=gdTopBottom;
    EndColor:=clYellow;
    MidColor:=clNone;
    Balance:=50;
  end;
end;

procedure TDefaultTheme.ChangeWall(Wall:TChartWall; AColor:TColor);
begin
  with Wall do
  begin
    Pen.Visible:=True;
    Pen.Color:=clBlack;
    Pen.Width:=1;
    Pen.Style:=psSolid;
    Gradient.Visible:=False;

    Color:=AColor;
    Dark3D:=True;
    Size:=0;
  end;
end;

procedure TDefaultTheme.ChangeAxis(Axis:TChartAxis);
begin
  with Axis do
  begin
    Axis.Width:=2;
    Axis.Color:=clBlack;

    Grid.Visible:=True;
    Grid.Color:=clGray;
    Grid.Style:=psDot;
    Grid.SmallDots:=False;
    Grid.Centered:=False;

    Ticks.Color:=clDkGray;
    TicksInner.Visible:=True;
    MinorTicks.Visible:=True;

    MinorGrid.Hide;
    MinorTickCount:=3;

    MinorTickLength:=2;
    TickLength:=4;
    TickInnerLength:=0;

    with LabelsFont do
    begin
      Name:=GetDefaultFontName;
      Size:=GetDefaultFontSize;
      Style:=[];
      Color:=clBlack;
    end;

    Title.Font.Name:=GetDefaultFontName;
  end;
end;

procedure TDefaultTheme.ChangeSeries(Series:TChartSeries);
begin
  with Series.Marks do
  begin
    Transparent:=False;
    Gradient.Visible:=False;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Arrow.Color:=clWhite;
  end;
end;

procedure TDefaultTheme.Apply;
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvRaised;
  Chart.BevelWidth:=1;
  Chart.Border.Hide;
  Chart.BorderRound:=0;
  Chart.Border.Hide;

  Chart.Shadow.Size:=0;

  Chart.Color:=clBtnFace;

  ResetGradient(Chart.Gradient);

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Shadow.Transparency:=0;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;
    DividingLines.Hide;
    Gradient.Visible:=False;
  end;

  ChangeWall(Chart.Walls.Left,$0080FFFF);
  ChangeWall(Chart.Walls.Right,clSilver);
  ChangeWall(Chart.Walls.Back,clSilver);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=True;

  for t:=0 to Chart.Axes.Count-1 do
    ChangeAxis(Chart.Axes[t]);

  for t:=0 to Chart.SeriesCount-1 do
    ChangeSeries(Chart[t]);

  with Chart.Title do
  begin
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Font.Color:=clBlue;
  end;

  ColorPalettes.ApplyPalette(Chart,0);
end;

{ TClassicTheme }

procedure TClassicTheme.Apply;
const ClassicFont = 'Times New Roman';

  procedure ChangeWall(Wall:TChartWall);
  begin
    with Wall do
    begin
      Pen.Visible:=True;
      Pen.Color:=clBlack;
      Pen.Width:=1;
      Pen.Style:=psSolid;
      Gradient.Visible:=False;

      Color:=clWhite;
      Dark3D:=False;
      Size:=8;
    end;
  end;

  procedure ChangeAxis(Axis:TChartAxis);
  begin
    Axis.Axis.Width:=1;
    Axis.Grid.Color:=clBlack;
    Axis.Grid.Style:=psSolid;
    Axis.Grid.Visible:=True;

    Axis.Ticks.Color:=clBlack;

    Axis.MinorTicks.Hide;
    Axis.TicksInner.Hide;

    with Axis.LabelsFont do
    begin
      Name:=ClassicFont;
      Size:=10;
    end;

    Axis.Title.Font.Name:=ClassicFont;
  end;

  procedure ChangeSeries(Series:TChartSeries);
  begin
    with Series.Marks do
    begin
      Gradient.Visible:=False;
      Transparent:=True;
      Font.Name:=ClassicFont;
      Font.Size:=10;
      Arrow.Color:=clBlack;
    end;
  end;

var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;
  Chart.BorderRound:=0;

  with Chart.Border do
  begin
    Visible:=True;
    Width:=1;
    Style:=psSolid;
    Color:=clBlack;
  end;

  Chart.Color:=clWhite;
  Chart.Gradient.Visible:=False;

  with Chart.Legend do
  begin
    Shadow.VertSize:=0;
    Shadow.HorizSize:=0;
    Font.Name:=ClassicFont;
    Font.Size:=10;
    Transparent:=True;
    Pen.Hide;
    Symbol.DefaultPen:=False;
    Symbol.Pen.Hide;
  end;

  ChangeWall(Chart.Walls.Left);
  ChangeWall(Chart.Walls.Right);
  ChangeWall(Chart.Walls.Back);
  ChangeWall(Chart.Walls.Bottom);

  Chart.Walls.Back.Transparent:=False;

  for t:=0 to Chart.Axes.Count-1 do
    ChangeAxis(Chart.Axes[t]);

  Chart.Axes.Bottom.Grid.Centered:=True;

  for t:=0 to Chart.SeriesCount-1 do
    ChangeSeries(Chart[t]);

  with Chart.Title do
  begin
    Font.Name:=ClassicFont;
    Font.Size:=12;
    Font.Color:=clBlack;
  end;

  ColorPalettes.ApplyPalette(Chart,5);
end;

function TClassicTheme.Description: string;
begin
  result:='Classic';
end;

{ TBusinessTheme }

procedure TBusinessTheme.Apply;
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;

  Chart.Border.Visible:=True;
  Chart.BorderRound:=10;
  Chart.Border.Width:=6;
  Chart.Border.Color:=clNavy;

  ResetGradient(Chart.Gradient);

  Chart.Gradient.Visible:=True;
  Chart.Gradient.EndColor:=clDkGray;

  Chart.Color:=clBtnFace;

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;

    ResetGradient(Gradient);

    Gradient.Visible:=True;
  end;

  ChangeWall(Chart.Walls.Left,$0080FFFF);
  ChangeWall(Chart.Walls.Right,clSilver);
  ChangeWall(Chart.Walls.Back,clSilver);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=True;

  for t:=0 to Chart.Axes.Count-1 do
      ChangeAxis(Chart.Axes[t]);

  for t:=0 to Chart.SeriesCount-1 do
  begin
    ChangeSeries(Chart[t]);
    with Chart[t].Marks.Gradient do
    begin
      Visible:=True;
      StartColor:=clSilver;
    end;
  end;

  with Chart.Title do
  begin
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Font.Color:=clBlue;
  end;

  ColorPalettes.ApplyPalette(Chart,2);
end;

function TBusinessTheme.Description: string;
begin
  result:=TeeMsg_WizardTab;  // Business
end;

{ TExcelTheme }

function TExcelTheme.Description: string;
begin
  result:='Microsoft® Excel';
end;

procedure TExcelTheme.Apply;

  procedure DoChangeWall(Wall:TChartWall; AColor:TColor);
  begin
    with Wall do
    begin
      Pen.Visible:=True;
      Pen.Color:=clDkGray;
      Pen.Width:=1;
      Pen.Style:=psSolid;
      Gradient.Visible:=False;

      Color:=AColor;
      Dark3D:=False;
    end;
  end;

  procedure DoChangeAxis(Axis:TChartAxis);
  begin
    Axis.Axis.Width:=1;
    Axis.Grid.Visible:=True;
    Axis.Grid.Color:=clBlack;
    Axis.Grid.Style:=psSolid;
    Axis.Grid.Centered:=False;

    Axis.Ticks.Color:=clBlack;

    Axis.MinorTicks.Hide;
    Axis.TicksInner.Hide;

    with Axis.LabelsFont do
    begin
      Name:='Arial';
      Size:=10;
    end;
  end;

  procedure DoChangeSeries(Series:TChartSeries);
  begin
    with Series.Marks do
    begin
      Gradient.Visible:=False;
      Transparent:=True;
      Font.Name:='Arial';
      Font.Size:=10;
      Arrow.Color:=clWhite;
    end;
  end;

var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;
  Chart.BorderRound:=0;

  with Chart.Border do
  begin
    Visible:=True;
    Width:=1;
    Style:=psSolid;
    Color:=clBlack;
  end;

  Chart.Color:=clWhite;
  Chart.Gradient.Visible:=False;

  with Chart.Legend do
  begin
    Shadow.VertSize:=0;
    Shadow.HorizSize:=0;
    DividingLines.Hide;
    Font.Name:='Arial';
    Font.Size:=10;
    Pen.Color:=clBlack;
    Pen.Width:=1;
    Pen.Style:=psSolid;
    Pen.Visible:=True;
    Transparent:=False;
    Gradient.Visible:=False;
  end;

  DoChangeWall(Chart.Walls.Left,clSilver);
  DoChangeWall(Chart.Walls.Right,clSilver);
  DoChangeWall(Chart.Walls.Back,clSilver);
  DoChangeWall(Chart.Walls.Bottom,clDkGray);

  Chart.Walls.Back.Transparent:=False;

  for t:=0 to Chart.Axes.Count-1 do
    DoChangeAxis(Chart.Axes[t]);

  Chart.Axes.Top.Grid.Hide;
  Chart.Axes.Bottom.Grid.Hide;

  Chart.Axes.Bottom.Grid.Centered:=True;

  for t:=0 to Chart.SeriesCount-1 do
    DoChangeSeries(Chart[t]);

  Chart.Title.Font.Name:='Arial';
  Chart.Title.Font.Size:=10;
  Chart.Title.Font.Color:=clBlack;

  ColorPalettes.ApplyPalette(Chart,1);
end;

{ TWebTheme }

procedure TWebTheme.Apply;
Const clDarkSilver=$C4C4C4;
      WebFont='Lucida Console';
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;

  Chart.Border.Visible:=True;
  Chart.BorderRound:=0;
  Chart.Border.Width:=1;
  Chart.Border.Color:=clBlack;

  Chart.Gradient.Visible:=False;

  Chart.Color:=clDarkSilver;  // dark clSilver

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Shadow.Color:=clDkGray;
    Font.Name:=WebFont;
    Font.Size:=9;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;
    Gradient.Visible:=False;
  end;

  ChangeWall(Chart.Walls.Left,clWhite);
  ChangeWall(Chart.Walls.Right,clWhite);
  ChangeWall(Chart.Walls.Back,clWhite);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=False;

  for t:=0 to Chart.Axes.Count-1 do
  with Chart.Axes[t] do
  begin
    Grid.Color:=clDarkSilver;
    Grid.Style:=psSolid;
    if Horizontal then Grid.Hide;
    MinorTickCount:=3;
    MinorTickLength:=-3;
    TickLength:=0;
    TickInnerLength:=6;
    TicksInner.Visible:=True;
    TicksInner.Color:=clBlack;
    LabelsFont.Name:=WebFont;
    MinorTicks.Visible:=True;
    MinorTicks.Color:=clBlack;
  end;

  for t:=0 to Chart.SeriesCount-1 do
  begin
    ChangeSeries(Chart[t]);
    Chart[t].Marks.Font.Name:=WebFont;
    with Chart[t].Marks.Gradient do
    begin
      Visible:=True;
      StartColor:=clSilver;
    end;
  end;

  with Chart.Title do
  begin
    Font.Name:=WebFont;
    Font.Size:=10;
    Font.Color:=clBlack;
    Font.Style:=[fsBold];
  end;

  ColorPalettes.ApplyPalette(Chart,6);
end;

function TWebTheme.Description: string;
begin
  result:='Web';
end;

{ TWindowsXPTheme }

procedure TWindowsXPTheme.Apply;
begin
  inherited;

  with Chart do
  begin
    BorderRound:=0;
    Border.Color:=$DF7A29;
    Border.Width:=7;
    Shadow.HorizSize:=10;
    Shadow.VertSize:=10;
    Shadow.Color:=clBlack;

    Gradient.MidColor:=clNone;
    Gradient.Direction:=gdDiagonalDown;
    Gradient.EndColor:=11645361;

    with Walls.Left.Gradient do
    begin
      Visible:=True;
      StartColor:=WindowsXPPalette[2];
      EndColor:=WindowsXPPalette[1];
    end;

    with Walls.Bottom.Gradient do
    begin
      Visible:=True;
      StartColor:=WindowsXPPalette[3];
      EndColor:=WindowsXPPalette[4];
    end;

    Walls.Back.Transparent:=False;

    ResetGradient(Walls.Back.Gradient);
    Walls.Back.Gradient.EndColor:=11118482;
    Walls.Back.Gradient.Visible:=True;

    Legend.Shadow.Transparency:=50;
  end;

  ColorPalettes.ApplyPalette(Chart,9);
end;

function TWindowsXPTheme.Description: string;
begin
  result:='Windows XP';
end;

{ TBlueSkyTheme }

procedure TBlueSkyTheme.Apply;
begin
  inherited;

  with Chart do
  begin
    BackWall.Color := 13626620;
    BackWall.Pen.Visible := False;
    BackWall.Size := 5;
    BackWall.Transparent := False;
    Border.Color := 9423874;
    Border.Width := 7;
    Border.Visible := True;
    BottomWall.Color := 16550915;
    BottomWall.Pen.Visible := False;
    BottomWall.Size := 5;

    ResetGradient(Gradient);
    Gradient.Direction := gdFromCenter;
    Gradient.EndColor := clWhite;
    Gradient.MidColor := 16777088;
    Gradient.StartColor := 10814240;
    Gradient.Visible := True;
    
    LeftWall.Color := 16744576;
    LeftWall.Pen.Visible := False;
    LeftWall.Size := 5;
    
    Legend.DividingLines.Color := clSilver;
    Legend.DividingLines.Visible := True;
    Legend.Font.Color := 6553600;
    Legend.Frame.Visible := False;

    ResetGradient(Legend.Gradient);
    Legend.Gradient.Direction := gdTopBottom;
    Legend.Gradient.EndColor := 13556735;
    Legend.Gradient.MidColor := 14739177;
    Legend.Gradient.StartColor := 16774122;
    Legend.Gradient.Visible := True;

    Legend.Shadow.HorizSize := 4;
    Legend.Shadow.Transparency := 50;
    Legend.Shadow.VertSize := 5;
    Legend.Symbol.Squared := True;
    RightWall.Size := 5;

    Title.Color := clBlack;
    Title.Font.Color := clNavy;
    Title.Font.Height := -16;
    Title.Frame.Color := 10083835;
    Title.Frame.Width := 2;

    ResetGradient(Title.Gradient);
    Title.Gradient.Balance := 40;
    Title.Gradient.Direction := gdRightLeft;
    Title.Gradient.EndColor := clBlack;
    Title.Gradient.MidColor := 8388672;
    Title.Gradient.StartColor := clGray;
    Title.Gradient.Visible := True;

    Title.Shadow.HorizSize := 4;
    Title.Shadow.Transparency := 70;
    Title.Shadow.VertSize := 4;

    BottomAxis.Axis.Width := 1;
    BottomAxis.Grid.Color := 16759225;
    BottomAxis.Grid.SmallDots := True;
    BottomAxis.LabelsFont.Color := clNavy;
    BottomAxis.LabelsFont.Name := 'Tahoma';
    BottomAxis.LabelsFont.Style := [fsBold];
    BottomAxis.MinorGrid.Color := 15066597;
    BottomAxis.MinorGrid.Visible := True;
    BottomAxis.MinorTickCount := 7;
    BottomAxis.TickLength := 5;
    Frame.Visible := False;
    LeftAxis.Axis.Color := clNavy;
    LeftAxis.Axis.Width := 1;
    LeftAxis.Grid.Color := clBlue;
    LeftAxis.Grid.SmallDots := True;
    LeftAxis.LabelsFont.Color := clNavy;
    LeftAxis.LabelsFont.Name := 'Tahoma';
    LeftAxis.LabelsFont.Style := [fsBold];
    Shadow.Color := clBlack;
    Shadow.HorizSize := 7;
    Shadow.VertSize := 7;
    BevelInner := bvLowered;
    BevelOuter := bvNone;
    BevelWidth := 2;
  end;

  ColorPalettes.ApplyPalette(Chart,3);
end;

function TBlueSkyTheme.Description: string;
begin
  result:='Blues';
end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart);
begin
  ApplyChartTheme(Theme,Chart,0);
end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart; PaletteIndex:Integer);
begin
  with Theme.Create(Chart) do
  try
    Apply;
  finally
    Free;
  end;

  if PaletteIndex<>-1 then
     ColorPalettes.ApplyPalette(Chart,PaletteIndex);
end;

procedure RegisterChartThemes(const Themes:Array of TChartThemeClass);
var t : Integer;
begin
  for t:=0 to Length(Themes)-1 do
      ChartThemes.Add(TObject(Themes[t]));
end;

function TThemesList.GetTheme(Index:Integer):TChartThemeClass;
begin
  result:=TChartThemeClass(Items[Index]);
end;

initialization
  ChartThemes:=TThemesList.Create;

  RegisterChartThemes([ TDefaultTheme,
                        TExcelTheme,
                        TClassicTheme,
                        TBusinessTheme,
                        TWebTheme,
                        TWindowsXPTheme,
                        TBlueSkyTheme]);
finalization
  ChartThemes.Free;
end.
