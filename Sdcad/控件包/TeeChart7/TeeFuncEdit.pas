{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeFuncEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeeSelectList, TeEngine, TeeProcs, TeeEdiPeri, TeeSourceEdit, TeCanvas;

type
  TTeeFuncEditor = class(TBaseSourceEditor, ITeeEventListener)
    PageControl1: TPageControl;
    TabSource: TTabSheet;
    TabOptions: TTabSheet;
    PanSingle: TPanel;
    Label1: TLabel;
    CBSingle: TComboFlat;
    LValues: TLabel;
    CBValues: TComboFlat;
    BNone: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBSourcesChange(Sender: TObject);
    procedure BApplyClick(Sender: TObject);
    procedure CBSingleChange(Sender: TObject);
    procedure BNoneClick(Sender: TObject);
    procedure CBValuesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    IOptions : TForm;
    ISources : TSelectListForm;
    Procedure FillSeries; // Fill selection combos...
    procedure TryCreateNewFunction;

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);  { interface }
  public
    { Public declarations }
    TheSeries : TChartSeries;
    Function FunctionClass:TTeeFunctionClass;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, Chart, TeePenDlg;

{ Helper functions }
procedure FillTeeFunctions(ACombo:TComboBox);
var t : Integer;
begin
  With ACombo.Items do
  begin
    BeginUpdate;
    Clear;
    Add(TeeMsg_FunctionNone);
    With TeeSeriesTypes do
    for t:=0 to Count-1 do
      With Items[t] do
      if Assigned(FunctionClass) and
         (not Assigned(SeriesClass)) and
         (IndexOfObject(TObject(FunctionClass))=-1) then
             AddObject(ReplaceChar(Description {$IFNDEF CLR}^{$ENDIF},TeeLineSeparator,' '),
                       TObject(FunctionClass));
    EndUpdate;
  end;
end;

procedure TTeeFuncEditor.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFNDEF CLX}
  CBSources.Sorted:=True;
  {$ENDIF}
  FillTeeFunctions(CBSources);
end;

Function TTeeFuncEditor.FunctionClass:TTeeFunctionClass;
begin
  With CBSources do
       if ItemIndex=-1 then result:=nil
                       else result:=TTeeFunctionClass(Items.Objects[ItemIndex]);
end;

Procedure TTeeFuncEditor.FillSeries; // Fill selection combos...

  Procedure FillSources(AItems:TStrings; AddCurrent:Boolean);

    Procedure AddSource(ASeries: TChartSeries);
    var tmp : String;
    begin
      if TheSeries.ParentChart.IsValidDataSource(TheSeries,ASeries) then
      begin
        tmp:=SeriesTitleOrName(ASeries);
        CBSingle.Items.AddObject(tmp,ASeries);
        if AddCurrent or (TheSeries.DataSources.IndexOf(ASeries)=-1) then
           AItems.AddObject(tmp,ASeries);
      end;
    end;

  var t : Integer;
  begin
    if Assigned(TheSeries.Owner) then
    With TheSeries.Owner do
      for t:=0 to ComponentCount-1 do
         if Components[t] is TChartSeries then
            AddSource(TChartSeries(Components[t]));
  end;

var t         : Integer;
    tmp       : TChartSeries;
    tmpSource : TObject;
    tmpList   : String;
    tmpIndex  : Integer;
begin
  CBSingle.Items.Clear;

  With ISources do
  begin
    FromList.Items.Clear;
    FillSources(FromList.Items,False);

    With ToList do
    begin
      Items.BeginUpdate;
      Clear;
      With TheSeries do
      if Assigned(DataSource) then
      for t:=0 to DataSources.Count-1 do
        if TComponent(DataSources[t]) is TChartSeries then
        begin
          tmp:=TChartSeries(DataSources[t]);
          Items.AddObject(SeriesTitleOrName(tmp),tmp);
          with FromList.Items do Delete(IndexOfObject(tmp));
        end;
      Items.EndUpdate;
    end;
  end;

  if PanSingle.Visible then
  begin
    // Set current selected single series
    tmpSource:=TheSeries.DataSource;
    if Assigned(tmpSource) and
       (tmpSource is TChartSeries) then
    begin
      with CBSingle do
      begin
        tmpIndex:=Items.IndexOfObject(tmpSource);
        if tmpIndex<>ItemIndex then
        begin
          ItemIndex:=tmpIndex;
          CBSingleChange(Self);
        end;
      end;

      tmpList:=TheSeries.MandatoryValueList.ValueSource;
      if tmpList='' then
         CBValues.ItemIndex:=0
      else
         CBValues.ItemIndex:=CBValues.Items.IndexOf(tmpList);
    end
    else
        CBSingle.ItemIndex:=-1;
  end;
end;

type
  TFunctionAccess=class(TTeeFunction);
  {$IFNDEF CLR}
  TTeePanelAccess=class(TCustomAxisPanel);
  {$ENDIF}

procedure TTeeFuncEditor.FormShow(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSource;
  TheSeries:=TChartSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(TheSeries) and Assigned(TheSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheSeries.ParentChart).Listeners.Add(Self);

  // Create multi-list form
  ISources:=TSelectListForm.Create(Self);
  With ISources do
  begin
    FromList.Height:=FromList.Height-5;
    ToList.Height:=ToList.Height-5;
    Height:=Height-8;
    Align:=alClient;
    OnChange:=CBSourcesChange;
  end;

  AddFormTo(ISources,TabSource,{$IFDEF CLR}TheSeries{$ELSE}Tag{$ENDIF});

  if Assigned(TheSeries) then
  begin
    FillSeries;

    // Select current at list of functions
    With CBSources do
    if Assigned(TheSeries.FunctionType) then
       ItemIndex:=Items.IndexOfObject(TObject(TheSeries.FunctionType.ClassType))
    else
       ItemIndex:=Items.IndexOf(TeeMsg_FunctionNone);

    CBSourcesChange(Self);

    BApply.Enabled:=(not Assigned(TheSeries.FunctionType))
                    and (TheSeries.DataSource=nil);
  end;

  ISources.EnableButtons;
end;

procedure TTeeFuncEditor.TryCreateNewFunction;
var tmpClass : TTeeFunctionClass;
begin
  { Create a new function... }
  tmpClass:=FunctionClass;
  if Assigned(tmpClass) then
  begin
    if (not Assigned(TheSeries.FunctionType)) or
       (TheSeries.FunctionType.ClassType<>tmpClass) then
    begin
      TheSeries.FunctionType:=nil;
      CreateNewTeeFunction(TheSeries,tmpClass);
      BApply.Enabled:=False;
    end;
  end
  else TheSeries.FunctionType:=nil;
end;

procedure TTeeFuncEditor.CBSourcesChange(Sender: TObject);

  Procedure CreateEditorForm(const EditorClass:String);
  var tmpF : TFormClass;
  begin
    FreeAndNil(IOptions);
    tmpF:=TFormClass(GetClass(EditorClass));
    if Assigned(tmpF) then
    begin
      IOptions:=tmpF.Create(Self);
      TeeTranslateControl(IOptions);
      AddFormTo(IOptions,TabOptions,{$IFNDEF CLR}Integer{$ENDIF}(TheSeries.FunctionType));
    end;
  end;

var tmpEdit : String;
    tmp     : TTeeFunction;
    tmpNoSource : Boolean;
begin
  inherited;
  TabOptions.TabVisible:=FunctionClass<>nil;

  if TabOptions.TabVisible then
  begin
    TryCreateNewFunction;

    tmp:=FunctionClass.Create(nil);  // temporary function
    try
      tmpEdit:=TFunctionAccess(tmp).GetEditorClass;
      tmpNoSource:=TFunctionAccess(tmp).NoSourceRequired;

      PanSingle.Visible:=(not tmpNoSource) and TFunctionAccess(tmp).SingleSource;

      if PanSingle.Visible then
      begin
        LValues.Visible:=not TFunctionAccess(tmp).HideSourceList;
        CBValues.Visible:=LValues.Visible;
      end;

      if tmpEdit='' then TabOptions.TabVisible:=False
                    else CreateEditorForm(tmpEdit);

      if tmpNoSource then
      begin
        TabOptions.Visible:=True;
        PageControl1.ActivePage:=TabOptions;
      end;

      TabSource.TabVisible:=not tmpNoSource;

      // Hack due to a VCL bug in TPageControl. See OnTimer
      // Anybody knows a better solution?
      if ((TheSeries.DataSource<>nil) or tmpNoSource)
         and Assigned(IOptions) then
             Timer1.Enabled:=True;
    finally
      tmp.Free;
    end;

  end
  else
  begin
    TabSource.TabVisible:=True;
    PanSingle.Visible:=False;
  end;

  ISources.Visible:=not PanSingle.Visible;
end;

type TSeriesAccess=class(TChartSeries);

procedure TTeeFuncEditor.BApplyClick(Sender: TObject);

  procedure DoApply;
  var t : Integer;
      // tmp : TChartSeries;
  begin
    { Set datasources... }
    if PanSingle.Visible then
    begin
      if CBSingle.ItemIndex=-1 then
      begin
        TheSeries.DataSource:=nil;
        TheSeries.MandatoryValueList.ValueSource:='';
      end
      else
      begin
        TheSeries.DataSource:=TChartSeries(CBSingle.Items.Objects[CBSingle.ItemIndex]);
        if CBValues.ItemIndex=-1 then
           TheSeries.MandatoryValueList.ValueSource:=''
        else
           TheSeries.MandatoryValueList.ValueSource:=CBValues.Items[CBValues.ItemIndex];
      end;
    end
    else
    begin
      if ISources.ToList.Items.Count=0 then TheSeries.DataSource:=nil
      else
      begin
        With ISources.ToList.Items do
           for t:=0 to Count-1 do
               TheSeries.CheckOtherSeries(TChartSeries(Objects[t]));

        With TheSeries.DataSources do
        begin
          // for t:=0 to Count-1 do  // 6.02
          //   TSeriesAccess(Items[t]).RemoveLinkedSeries(TheSeries);

          Clear;

          With ISources.ToList.Items do
          for t:=0 to Count-1 do
            // tmp:=TChartSeries(Objects[t]);

            TheSeries.DataSources.Add(TChartSeries(Objects[t]));

            //TSeriesAccess(tmp).AddLinkedSeries(TheSeries); // 6.02
        end;
      end;
    end;

    TryCreateNewFunction;
  end;

var tmp : Boolean;
begin
  inherited;

  if Assigned(IOptions) and Assigned(IOptions.OnCloseQuery) then
  begin
    tmp:=True;
    IOptions.OnCloseQuery(IOptions,tmp);
  end;

  TheSeries.BeginUpdate;
  DoApply;
  TheSeries.EndUpdate;
  TheSeries.CheckDataSource;

  BApply.Enabled:=False;
end;

procedure TTeeFuncEditor.CBSingleChange(Sender: TObject);
var tmp : TChartSeries;
    t   : Integer;
begin
  BApply.Enabled:=True;

  with CBValues do
  begin
    Items.Clear;
    Enabled:=CBSingle.ItemIndex<>-1;
    BNone.Enabled:=Enabled;

    if Enabled then
    begin
      tmp:=TChartSeries(CBSingle.Items.Objects[CBSingle.ItemIndex]);
      for t:=1 to tmp.ValuesList.Count-1 do
          Items.Add(tmp.ValuesList[t].Name);
      CBValues.ItemIndex:=0;
    end;
  end;
end;

procedure TTeeFuncEditor.BNoneClick(Sender: TObject);
begin
  CBSingle.ItemIndex:=-1;
  CBSingleChange(Self);
end;

procedure TTeeFuncEditor.CBValuesChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TTeeFuncEditor.TeeEvent(Event: TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
  if Event is TTeeSeriesEvent then
  With TTeeSeriesEvent(Event) do
  Case Event of
    seRemove :
      if Series<>TheSeries then FillSeries
                           else BApply.Enabled:=False;
      seAdd,
      seSwap: if Series<>TheSeries then FillSeries
                                   else BApply.Enabled:=False;
  end;
end;

procedure TTeeFuncEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(TheSeries) and Assigned(TheSeries.ParentChart) then
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(TheSeries.ParentChart).RemoveListener(Self);
  inherited;
end;

procedure TTeeFuncEditor.Timer1Timer(Sender: TObject);
begin
  // Force pagecontrol to re-show again our tab with the correct controls on it.
  // This must be done using a timer to delay until parent form is totally
  // visible. Anybody knows a better solution?
  Timer1.Enabled:=False;
  {$IFNDEF CLX}
  PageControl1.ActivePage:=nil;
  PageControl1.ActivePage:=TabOptions;
  {$ENDIF}
end;

end.
