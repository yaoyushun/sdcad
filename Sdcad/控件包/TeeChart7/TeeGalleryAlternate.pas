{**********************************************}
{   TTeeGalleryForm - Alternate Gallery        }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeGalleryAlternate;
{$I TeeDefs.inc}

interface

{ This unit implements a Form to display the TeeChart Gallery
  in an alternate format.

  Series types are located in the left-hand ListBox, while
  sub-types are displayed using the normal Chart Gallery.

  This form can be used for example embedded into another form
  (see below).
}

uses
  Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, Qt,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  {$ENDIF}
  TeeProcs, TeEngine, Chart, TeeGalleryPanel, TeeLisB, Series, TeCanvas;

type
  TTeeGalleryForm = class(TForm)
    ChartGalleryPanel1: TChartGalleryPanel;
    ChartListBox1: TChartListBox;
    Splitter1: TSplitter;
    Panel1: TPanel;
    CBPage: TComboFlat;
    Label1: TLabel;
    CB3D: TCheckBox;
    CBSmooth: TCheckBox;
    PanelBottom: TPanel;
    Panel3: TPanel;
    BOK: TButton;
    BCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChartListBox1Click(Sender: TObject);
    procedure CBPageChange(Sender: TObject);
    procedure CB3DClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure ChartGalleryPanel1SelectedChart(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Chart : TChart;
    OldClass : TChartSeriesClass;
    Procedure CreateChartList(Const APage:String);
    Procedure CreateGallery(AClass:TChartSeriesClass);
    Procedure FillGalleryPages(AItems:TStrings);
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{ Embedding this form inside another form can be done like this:

Uses TeeGalleryAlternate, TeePenDlg;

  TMyForm = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Gallery : TTeeGalleryForm;
  public
  end;

procedure TMyForm.FormShow(Sender: TObject);
begin
  Gallery:=TTeeGalleryForm.Create(Self);
  Gallery.Align:=alClient;
  Gallery.PanelBottom.Visible:=False;
  AddFormTo(Gallery,Self,0);
end;

procedure TMyForm.FormDestroy(Sender: TObject);
begin
  Gallery.Free;
end;

}

uses
  TeeConst;

procedure TTeeGalleryForm.FormCreate(Sender: TObject);
begin
  Chart:=TChart.Create(Self);
  ChartListBox1.Chart:=Chart;

  ChartListBox1.Sorted:=True;

  FillGalleryPages(CBPage.Items);

  CBPage.Items.Insert(0,TeeMsg_All);
  CBPage.ItemIndex:=CBPage.Items.IndexOf(TeeMsg_GalleryStandard);

  // Init checkbox using default "smooth" value from inifile or registry.
  CBSmooth.Checked:=ChartGalleryPanel1.DefaultSmooth;
end;

type
  TGalleryAccess=class(TChartGalleryPanel);

procedure TTeeGalleryForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  TGalleryAccess(ChartGalleryPanel1).KeyDown(Key,Shift);
end;

procedure TTeeGalleryForm.ChartListBox1Click(Sender: TObject);
var AClass : TChartSeriesClass;
begin
  if Assigned(ChartListBox1.SelectedSeries) then
  begin
    AClass:=TChartSeriesClass(ChartListBox1.SelectedSeries.ClassType);
    if OldClass<>AClass then
    begin
      CreateGallery(AClass);
      OldClass:=AClass;
    end;
  end;
end;

procedure TTeeGalleryForm.CBPageChange(Sender: TObject);
begin
  if CBPage.ItemIndex=0 then
     CreateChartList('')
  else
     CreateChartList(CBPage.Items[CBPage.ItemIndex]);
end;

procedure TTeeGalleryForm.CB3DClick(Sender: TObject);
begin
  ChartGalleryPanel1.View3D:=CB3D.Checked;
end;

Procedure TTeeGalleryForm.FillGalleryPages(AItems:TStrings);
var t : Integer;
    s : String;
begin
  With TeeSeriesTypes do
  for t:=0 to Count-1 do
  begin
    s:=Items[t].GalleryPage{$IFNDEF CLR}^{$ENDIF};

    if AItems.IndexOf(s)=-1 then
       if Items[t].FunctionClass=nil then
          AItems.Add(s);
  end;
end;

Procedure TTeeGalleryForm.CreateChartList(Const APage:String);
var t : Integer;
begin
  ChartListBox1.Items.BeginUpdate;
  try
    Chart.FreeAllSeries;

    with TeeSeriesTypes do
    for t:=0 to Count-1 do
        with Items[t] do
        if FunctionClass=nil then
        if (APage='') or (GalleryPage{$IFNDEF CLR}^{$ENDIF}=APage) then
           Chart.AddSeries(SeriesClass).Title:=
              ReplaceChar(TeeSeriesTypes.Find(SeriesClass).Description{$IFNDEF CLR}^{$ENDIF},TeeLineSeparator,' ');

    ChartListBox1Click(Self);
  finally
    ChartListBox1.Items.EndUpdate;
  end;
end;

type
  TSeriesAccess=class(TChartSeries);

Procedure TTeeGalleryForm.CreateGallery(AClass:TChartSeriesClass);
begin
  With {$IFNDEF CLR}TGalleryAccess{$ENDIF}(ChartGalleryPanel1) do
  begin
    NumRows:=3;
    DisplaySub:=False;
    tmpG:=ChartGalleryPanel1;
    tmpType:=TTeeSeriesType.Create;

    try
      tmpType.SeriesClass:=AClass;
      tmpType.NumGallerySeries:=1;
      tmpType.FunctionClass:=nil;
      Charts.Clear;
      SelectedChart:=nil;
      tmpSeries:=tmpType.SeriesClass.Create(nil);

      try
        TSeriesAccess(tmpSeries).CreateSubGallery(TGalleryAccess(ChartGalleryPanel1).CreateSubChart);
        {$IFNDEF CLR}TGalleryAccess{$ENDIF}(ChartGalleryPanel1).ShowSelectedChart;
      finally
        tmpSeries.Free;
      end;
    finally
      tmpType.Free;
    end;
  end;
end;

procedure TTeeGalleryForm.FormDestroy(Sender: TObject);
begin
  Chart.Free;
end;

procedure TTeeGalleryForm.CBSmoothClick(Sender: TObject);
begin
  ChartGalleryPanel1.Smooth:=CBSmooth.Checked;
end;

procedure TTeeGalleryForm.ChartGalleryPanel1SelectedChart(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TTeeGalleryForm.FormShow(Sender: TObject);
begin
  // Do this here, to not re-translate ChartListBox1...
  CBPageChange(Self);
end;

end.
