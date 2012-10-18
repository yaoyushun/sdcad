{**********************************************}
{   TeeChart Gallery Dialog                    }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeGally;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, QControls, QExtCtrls, QStdCtrls, QComCtrls, QForms,
     {$ELSE}
     Graphics, Controls, StdCtrls, ExtCtrls, ComCtrls, Forms,
     {$ENDIF}
     SysUtils, Classes,
     TeEngine, Chart, TeeGalleryPanel, TeeProcs;

type
  TTeeGallery = class(TForm)
    P1: TPanel;
    BOk: TButton;
    BCancel: TButton;
    CB3D: TCheckBox;
    TabPages: TTabControl;
    TabTypes: TTabControl;
    ChartGalleryPanel1: TChartGalleryPanel;
    CBSmooth: TCheckBox;
    procedure CB3DClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabPagesChange(Sender: TObject);
    procedure TabTypesChange(Sender: TObject);
    procedure ChartGalleryPanel1SelectedChart(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure HideButtons;
    Procedure HideFunctions;
  end;

{ Shows the gallery and asks the user a Series type.
  If user double clicks a chart or presses Ok, a new Series
  is created and returned. The new Series is owned by AOwner
  parameter (usually the Form).
}
Function CreateNewSeriesGallery( AOwner:TComponent;
                                 OldSeries:TChartSeries;
                                 tmpChart:TCustomAxisPanel;
                                 AllowSameType,
                                 CheckSeries:Boolean;
                                 Var SubIndex:Integer ):TChartSeries; overload;

// Same as above but much simpler to use:
Function CreateNewSeriesGallery( AOwner:TComponent;
                                 AChart:TCustomAxisPanel):TChartSeries; overload;

{ Shows the gallery and asks the user a Series type. Then
  changes tmpSeries to the new type. }
procedure ChangeSeriesTypeGallery(AOwner:TComponent; Var tmpSeries:TChartSeries);

{ Shows the Gallery Dialog and lets the user choose a Series type.
  Returns True if user pressed OK.
  The "tmpClass" parameter returns the choosen type.
}
Function GetChartGalleryClass( AOwner:TComponent;
                               OldSeries:TChartSeries;
                               ShowFunctions:Boolean;
                               Var tmpClass:TChartSeriesClass;
                               Var Show3D:Boolean;
                               Var tmpFunctionClass:TTeeFunctionClass;
                               CheckValidSeries:Boolean;
                               Var SubIndex:Integer):Boolean;

{ Shows the gallery and asks the user a Series type. Then
  changes all Series in AChart to the new type. }
procedure ChangeAllSeriesGallery( AOwner:TComponent; AChart:TCustomChart );

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeLisB, TeeConst, Series, TeCanvas, TeePenDlg, TeeGalleryAlternate;

{ TeeGallery }
Procedure TTeeGallery.HideFunctions;
begin
  {$IFDEF CLX}
  if TabTypes.Tabs.Count>1 then
  {$ENDIF}
     TabTypes.Tabs.Delete(1);
  ChartGalleryPanel1.FunctionsVisible:=False;
end;

Procedure TTeeGallery.HideButtons;
begin
  P1.Visible:=False;
end;

procedure TTeeGallery.CB3DClick(Sender: TObject);
begin
  ChartGalleryPanel1.View3D:=CB3D.Checked;
end;

procedure TTeeGallery.FormShow(Sender: TObject);
begin
  CBSmooth.Checked:=ChartGalleryPanel1.Smooth;
  TabTypes.TabIndex:=0;
  TabTypesChange(Self);
  TeeTranslateControl(Self);
end;

procedure TTeeGallery.TabPagesChange(Sender: TObject);
begin
  With ChartGalleryPanel1 do
  begin
    FunctionsVisible:=TabTypes.TabIndex=1;
    View3D:=CB3D.Checked;
    With TabPages do
    if TabIndex<>-1 then CreateGalleryPage(Tabs[TabIndex]{$IFDEF CLX}.Caption{$ENDIF})
                    else Charts.Clear;
  end;
end;

procedure TTeeGallery.TabTypesChange(Sender: TObject);

  Function TabIndexOf(Const GalleryPage:String):Integer;
  {$IFDEF CLX}
  var t : Integer;
  {$ENDIF}
  begin
    {$IFDEF CLX}
    With TabPages do
    for t:=0 to Tabs.Count-1 do
    if Tabs[t].Caption=GalleryPage then
    begin
      result:=t;
      exit;
    end;
    result:=-1;
    {$ELSE}
    result:=TabPages.Tabs.IndexOf(GalleryPage);
    {$ENDIF}
  end;

  Procedure AddTabPages;
  var t       : Integer;
      tmpPage : String;
  begin
    TabPages.Tabs.Clear;
    With TeeSeriesTypes do
    for t:=0 to Count-1 do
    With Items[t] do
      if NumGallerySeries>0 then
      begin
        tmpPage:=GalleryPage{$IFNDEF CLR}^{$ENDIF};
        
        {$IFNDEF CLX}
        if TabPages.Tabs.IndexOf(tmpPage)=-1 then
        {$ELSE}
        if TabIndexOf(tmpPage)=-1 then
        {$ENDIF}
          Case TabTypes.TabIndex of
           0: if not Assigned(FunctionClass) then TabPages.Tabs.Add(tmpPage);
           1: if Assigned(FunctionClass) then TabPages.Tabs.Add(tmpPage);
          end;
      end;
  end;

var i : Integer;
begin
  AddTabPages;

  i:=TabIndexOf(TeeMsg_GalleryStandard);
  if i>0 then
     {$IFDEF CLX}
     TabPages.Tabs[i].Index:=0;
     {$ELSE}
     TabPages.Tabs.Exchange(0,i);
     {$ENDIF}

  TabPages.TabIndex:=0;
  TabPagesChange(Self);
end;

procedure TTeeGallery.ChartGalleryPanel1SelectedChart(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TTeeGallery.FormCreate(Sender: TObject);
begin
  with TabTypes.Tabs do
  begin
    Add(TeeMsg_Series);
    Add(TeeMsg_GalleryFunctions);
  end;
end;

{ Helper functions }
Function GetChartGalleryClass( AOwner:TComponent;
                               OldSeries:TChartSeries;
                               ShowFunctions:Boolean;
                               Var tmpClass:TChartSeriesClass;
                               Var Show3D:Boolean;
                               Var tmpFunctionClass:TTeeFunctionClass;
                               CheckValidSeries:Boolean;
                               Var SubIndex:Integer):Boolean;

  procedure NormalGallery;
  begin
    with TTeeGallery.Create(AOwner) do
    try
      {$IFDEF D5}
      if Assigned(Owner) then Position:=poOwnerFormCenter
      else
      {$ENDIF}
        Position:=poScreenCenter;

      CB3D.Checked:=Show3D;
      ChartGalleryPanel1.SelectedSeries:=OldSeries;

      if not ShowFunctions then HideFunctions;

      ChartGalleryPanel1.CheckSeries:=CheckValidSeries;

      if ShowModal=mrOk then
      begin
        result:=ChartGalleryPanel1.GetSeriesClass(tmpClass,tmpFunctionClass,SubIndex);
        if result then
           Show3D:=CB3D.Checked and ChartGalleryPanel1.SelectedChart.View3D;
      end;

    finally
      Free;
    end;
  end;

  procedure AlternateGallery;
  var g : TTeeGalleryForm;
  begin
    g:=TTeeGalleryForm.Create(AOwner);
    with g do
    try
      {$IFDEF D5}
      if Assigned(Owner) then Position:=poOwnerFormCenter
      else
      {$ENDIF}
        Position:=poScreenCenter;

      CB3D.Checked:=Show3D;

      TeeTranslateControl(g);

      if ShowModal=mrOk then
      begin
        result:=ChartGalleryPanel1.GetSeriesClass(tmpClass,tmpFunctionClass,SubIndex);
        if result then
           Show3D:=CB3D.Checked and ChartGalleryPanel1.SelectedChart.View3D;
      end;

    finally
      Free;
    end;
  end;

begin
  result:=False;

  if TChartGalleryPanel.DefaultMode=0 then
     NormalGallery
  else
     AlternateGallery;
end;

Function CreateNewSeriesGallery( AOwner:TComponent;
                                 AChart:TCustomAxisPanel):TChartSeries;
var tmp : Integer;
begin
  result:=CreateNewSeriesGallery( AOwner, nil, AChart, True, False, tmp);
end;

type TSeriesAccess=class(TChartSeries);

Function CreateNewSeriesGallery( AOwner:TComponent;
                                 OldSeries:TChartSeries;
                                 tmpChart:TCustomAxisPanel;
                                 AllowSameType,
                                 CheckSeries:Boolean;
                                 Var SubIndex:Integer ):TChartSeries;
var Show3D   : Boolean;
    tmpClass : TChartSeriesClass;
    tmpFunctionClass : TTeeFunctionClass;
begin
  result:=nil;
  Show3D:=tmpChart.View3D;

  if GetChartGalleryClass(AOwner,OldSeries,AllowSameType,tmpClass,Show3D,
                          tmpFunctionClass,CheckSeries,SubIndex) then
  begin
    tmpChart.View3D:=Show3D;

    if (not Assigned(OldSeries)) or
       (AllowSameType or ((tmpClass<>OldSeries.ClassType) or (SubIndex<>-1))) then
    begin
      if Assigned(OldSeries) then AOwner:=OldSeries.Owner
                             else AOwner:=tmpChart.Owner;

      result:=CreateNewSeries(AOwner,tmpChart,tmpClass,tmpFunctionClass);

      if SubIndex<>-1 then TSeriesAccess(result).SetSubGallery(result,SubIndex);
    end;
  end;
end;

procedure ChangeSeriesTypeGallery(AOwner:TComponent; Var tmpSeries:TChartSeries);
var NewSeries : TChartSeries;
    SubIndex  : Integer;
begin
  NewSeries:=CreateNewSeriesGallery(AOwner,tmpSeries,tmpSeries.ParentChart,False,True,SubIndex);
  if Assigned(NewSeries) then
  begin
    AssignSeries(tmpSeries,NewSeries);
    tmpSeries:=NewSeries;
    if SubIndex<>-1 then TSeriesAccess(tmpSeries).SetSubGallery(tmpSeries,SubIndex);
  end;
end;

procedure ChangeAllSeriesGallery( AOwner:TComponent; AChart:TCustomChart );
var NewSeries : TChartSeries;
    tmpSeries : TChartSeries;
    SubIndex  : Integer;
begin
  if AChart.SeriesCount>0 then
  begin
    tmpSeries:=AChart.Series[0];
    NewSeries:=CreateNewSeriesGallery(AOwner,tmpSeries,AChart,False,True,SubIndex);
    if Assigned(NewSeries) then
    begin
      AssignSeries(tmpSeries,NewSeries);
      ChangeAllSeriesType(AChart,TChartSeriesClass(NewSeries.ClassType));
    end;
  end;
end;

Function TeeAddGallery(AOwner:TComponent; Chart:TCustomChart; Series:TChartSeries):TChartSeries;
var SubIndex : Integer;
begin
  if Assigned(Chart) then
     result:=CreateNewSeriesGallery(AOwner,Series,Chart,True,False,SubIndex)
  else
     result:=nil;
end;

Function TeeChangeGallery(AOwner:TComponent; var Series: TChartSeries):TChartSeriesClass;
begin
  ChangeSeriesTypeGallery(AOwner,Series);
  result:=TChartSeriesClass(Series.ClassType);
end;

procedure TTeeGallery.CBSmoothClick(Sender: TObject);
begin
  ChartGalleryPanel1.Smooth:=CBSmooth.Checked;
  ChartGalleryPanel1.SaveSmooth(ChartGalleryPanel1.Smooth);
end;

initialization
  TeeAddGalleryProc:=TeeAddGallery;
  TeeChangeGalleryProc:=TeeChangeGallery;
finalization
  TeeChangeGalleryProc:=nil;
  TeeAddGalleryProc:=nil;
end.

