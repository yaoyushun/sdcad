{*****************************************}
{ TeeChart Standard version               }
{                                         }
{ Component Registration Unit             }
{                                         }
{ Comps:   TChart                         }
{          TDBChart (not for Std/Open)    }
{                                         }
{ Series:  TLineSeries                    }
{          TAreaSeries                    }
{          TPointSeries                   }
{          TBarSeries                     }
{          THorizBarSeries                }
{          TPieSeries                     }
{          TBubbleSeries                  }
{          TGanttSeries                   }
{          TChartShape                    }
{          TArrowSeries                   }
{          TFastLineSeries                }
{          THorizLineSeries               }
{          THorizAreaSeries               }
{                                         }
{ Other:                                  }
{          TButtonColor                   }
{          TButtonPen                     }
{          TComboFlat                     }
{                                         }
{          Multi-Language selector        }
{                                         }
{          TTeeDBCrossTab                 }
{                                         }
{ Copyright (c) 1995-2004 David Berneda   }
{ All Rights Reserved                     }
{                                         }
{*****************************************}
unit TeeChartReg;
{$I TeeDefs.inc}

interface

Uses
  {$IFDEF CLR}
  {$IFDEF TEEEDITORS}
  Borland.VCL.Design.DesignEditors, Borland.VCL.Design.DesignIntf,
  {$ENDIF}
  {$ELSE}
   {$IFDEF D6DESIGNER}
   DesignIntf, DesignEditors, PropertyCategories, 
   {$ELSE}
   DsgnIntf,
   {$ENDIF}
  {$ENDIF}

  Classes,
  TeEngine, Chart, TeCanvas;

{$IFDEF CLR}
{$R 'Chart.TChart.bmp'}
{$R 'DBChart.TDBChart.bmp'}
{$R 'TeeDraw3D.TDraw3D.bmp'}
{$R 'TeeData.TSeriesDataSet.bmp'}
{$R 'TeeEdit.TChartPreviewer.bmp'}
{$R 'TChartEditor.bmp'}
{$R 'TTeeCommander.bmp'}
{$R 'TChartScrollBar.bmp'}
{$R 'TChartListBox.bmp'}
{$R 'TChartEditorPanel.bmp'}
{$R 'TChartGrid.bmp'}
{$R 'TChartGridNavigator.bmp'}
{$R 'TChartPageNavigator.bmp'}
{$R 'TChartGalleryPanel.bmp'}
{$R 'TChartWebSource.bmp'}
{$R 'TSeriesTextSource.bmp'}
{$R 'TTeeXMLSource.bmp'}
{$R 'TDBCrossTabSource.bmp'}
{$R 'TButtonColor.bmp'}
{$R 'TButtonPen.bmp'}
{$R 'TComboFlat.bmp'}
{$R 'TTeePreviewPanel.bmp'}

{$DEFINE SPLASH_BDS}

{$ELSE}
{$R TeeChart.res}
{$ENDIF}

{$IFNDEF BCB}
{$IFNDEF CLX}
{$IFNDEF TEENOSERIESDESIGN}
{$IFNDEF TEELITE}
{$DEFINE TEESHOWCUSTOMAXES}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IFNDEF NOUSE_BDE}
{$DEFINE TEEDBREG}
{$ENDIF}

{$IFDEF KYLIXOPEN}
{$UNDEF TEEDBREG}
{$ENDIF}

type

{$IFDEF TEEEDITORS}

  TTeeClassProperty=class(TClassProperty)
  public
    function GetValue: string; override;
  end;

  TChartClassProperty=class(TTeeClassProperty)
  protected
    procedure InternalEditPage(AChart:TCustomChart; APage:Integer);
  public
    function GetAttributes : TPropertyAttributes; override;
  end;

  TChartCompEditor=class(TComponentEditor)
  protected
    Function Chart:TCustomChart; virtual;
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  {$IFDEF TEEDBREG}
  TDBChartCompEditor=class(TChartCompEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;
  {$ENDIF}

  TChartSeriesEditor=class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TChartPenProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartBrushProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  { Property Categories }
  {$IFNDEF D6}
  {$IFNDEF CLX}
  {$IFDEF D5}
  TChartAxesCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChartWallsCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChartTitlesCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;

  TChart3DCategory = class(TPropertyCategory)
  public
    class function Name: string; override;
    class function Description: string; override;
  end;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}

{$ENDIF}

  TTeeDesigner={$IFDEF CLR}
               IDesigner
               {$ELSE}
               {$IFDEF D6DESIGNER}
               IDesigner
               {$ELSE}
               IFormDesigner
               {$ENDIF}
               {$ENDIF}
               ;

  TTeeEditSeriesProc=procedure(ASeries:TChartSeries; ADesigner:TTeeDesigner);
  TTeeChartEditorHook=procedure(ADesigner: TTeeDesigner; AChart: TCustomChart;
                                EditSeriesProc: TTeeEditSeriesProc);

  TTeeDesignOptionsHook=procedure;

Var
  TeeChartEditorHook   : TTeeChartEditorHook=nil;
  TeeDesignOptionsHook : TTeeDesignOptionsHook=nil;

{ for QrTeeReg.pas }
procedure EditChartDesign(AChart:TCustomChart);

procedure EditSeriesProc(ASeries:TChartSeries; ADesigner:TTeeDesigner);

procedure Register;

{$IFDEF SPLASH_BDS}
type
  TeeChartIDE=class
  public
    class procedure IDERegister; static;
  end;
{$ENDIF}

implementation

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}

     TypInfo,
     SysUtils,

     {$IFDEF TEEDBREG}
     DB,
     {$IFNDEF CLX}
     DBTables,
     {$ENDIF}
     {$ENDIF}

     {$IFDEF CLX}
     QClipbrd, QGraphics, QForms, QControls, QDialogs, QMenus,
     {$ELSE}
     Clipbrd, Graphics, Forms, Controls, Dialogs, Menus,
     {$ENDIF}

     TeeGalleryPanel, EditChar, TeeProcs, TeeConst, TeeAbout,
     TeeEditCha, TeeEdiSeri, TeeEdiGene, TeeEdiGrad, TeeShadowEditor,

     {$IFDEF TEEDBREG}
     DBChart, DBEditCh, TeeDBEdit,

     {$IFNDEF CLR}
     TeeData,
     {$ENDIF}

     TeeDBCrossTab,
     {$ENDIF}

     {$IFDEF SPLASH_BDS}
     Borland.Studio.ToolsAPI,
     {$ENDIF}

     TeeCustEdit, Series, TeeSourceEdit,
     TeePieEdit, TeeAreaEdit, TeeBarEdit, TeeFLineEdi, TeePenDlg,
     TeeBrushDlg, GanttCh, TeeShape, BubbleCh, ArrowCha, TeeArrowEdi,
     TeeGanttEdi, TeeShapeEdi, TeeCustomFuncEditor, TeeAvgFuncEditor,
     TeePrevi, TeExport

     {$IFDEF TEELITE}
     , TeeDesignOptions
     {$ENDIF}

     {$IFNDEF CLX}
     , TeeExpForm
     {$ENDIF}
     {$IFNDEF TEENOSERIESDESIGN}
     {$IFDEF CLR}
     , Borland.Vcl.Design.ColnEdit 
     {$ELSE}
     , ColnEdit
     {$ENDIF}
     {$ENDIF}
     ;

{$IFDEF TEEEDITORS}
type
  TChartLegendProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartAxisProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartAxisTitleProperty=class(TTeeClassProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
  end;

  TChartSeriesListProperty=class(TTeeClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

  TSeriesPointerProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartTitleProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartWallProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TChartGradientProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TTeeShadowProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TBarSeriesGradientProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TSeriesMarksProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;

  TView3DOptionsProperty=class(TChartClassProperty)
  public
    procedure Edit; override;
  end;
{$ENDIF}

{$IFDEF TEEDBREG}
type 
  TDesignSources=class
    FAddCurrent   : Boolean;
    FItems        : TStrings;
    FFormDesigner : TTeeDesigner;
    FProc         : TAddComponentDataSource;
    Procedure AddDataSource(Const St:String);
  end;

Procedure TDesignSources.AddDataSource(Const St:String);
var tmpComp : TComponent;
begin
  if St<>'' then
  begin
    tmpComp:=FFormDesigner.GetComponent(St);
    if Assigned(tmpComp) and Assigned(FProc) then
       FProc(tmpComp,FItems,FAddCurrent);
  end;
end;

Procedure DesignTimeOnGetDesignerNames( AProc      : TAddComponentDataSource;
					ASeries    : TChartSeries;
					AItems     : TStrings;
					AddCurrent : Boolean );
Var tmpForm : TCustomForm;
    {$IFDEF CLR}
    tmpDesigner : IDesignerNotify;
    {$ENDIF}
begin
  tmpForm:=GetParentForm(ASeries.ParentChart);

  {$IFDEF CLR}
  if Assigned(tmpForm) then 
  begin
    ShowMessage('yes '+tmpForm.ClassName+' '+tmpForm.Name);
    if Assigned(tmpForm.Designer) then ShowMessage('yes2') else ShowMessage('no2');
    tmpDesigner:=tmpForm.GetRootDesigner;
    if Assigned(tmpDesigner) then ShowMessage('yes3') else ShowMessage('no3');
  end
  else ShowMessage('no');
  {$ENDIF}

  if Assigned(tmpForm) and Assigned(tmpForm.{$IFDEF CLX}DesignerHook{$ELSE}Designer{$ENDIF}) then
  With TDesignSources.Create do
  try
    FProc:=AProc;
    FItems:=AItems;
    FAddCurrent:=AddCurrent;

    {$IFDEF CLR}
    FFormDesigner:=tmpForm.Designer as TTeeDesigner;
    {$ELSE}
    {$IFDEF D6DESIGNER}
    tmpForm.{$IFDEF CLX}DesignerHook{$ELSE}Designer{$ENDIF}.QueryInterface(IDesigner,FFormDesigner);
    {$ELSE}
    FFormDesigner:=tmpForm.Designer as TTeeDesigner;
    {$ENDIF}
    {$ENDIF}

    {$IFDEF TEEDBREG}
    FFormDesigner.GetComponentNames(GetTypeData(TDataSource.ClassInfo),AddDataSource);
    FFormDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo),AddDataSource);
    {$ENDIF}

    FFormDesigner.GetComponentNames(GetTypeData(TChartSeries.ClassInfo),AddDataSource);
    FFormDesigner.GetComponentNames(GetTypeData(TTeeSeriesSource.ClassInfo),AddDataSource);
  finally
    Free;
  end;
end;
{$ENDIF}

{ TTeeClassProperty }
function TTeeClassProperty.GetValue: string;
begin
  {$IFDEF CLR} 
  result:='('+GetPropType.ToString+')';
  {$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
  {$ENDIF}
end;

{ Chart Editor }
procedure EditChartDesign(AChart:TCustomChart);
var Part : TChartClickedPart;
begin
  With AChart do CalcClickedPart(GetCursorPos,Part);
  EditChartPart(nil,AChart,Part);
end;

{ EditSeriesProc }
procedure EditSeriesProc(ASeries:TChartSeries; ADesigner:TTeeDesigner);
begin
  EditSeries(nil,ASeries);
  if Assigned(ADesigner) then ADesigner.Modified; { 5.01 }
end;

{$IFDEF TEEEDITORS}

{ TChartCompEditor }
Function TChartCompEditor.Chart:TCustomChart;
begin
  result:=TCustomChart(Component);
end;

procedure TChartCompEditor.Edit;
begin
  EditChartDesign(Chart);
  Designer.Modified;
end;

procedure TChartCompEditor.ExecuteVerb( Index : Integer );
begin
  Case Index of
    0..3: TeeShowAboutBox;
    4: Edit;
    5: ChartPreview(nil,Chart);
    6: TeeExport(Application,Chart);
  else
  begin
   case Index of 
   {$IFDEF TEESHOWCUSTOMAXES}
    7: ShowCollectionEditor(Designer,Chart,Chart.CustomAxes,'CustomAxes');
    {$IFDEF CLX}
      8: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
    {$ELSE}
      {$IFDEF BCB}
        8: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
      {$ELSE}
        8: if Assigned(TeeChartEditorHook) then 
              TeeChartEditorHook(Designer,Chart,EditSeriesProc)
           else
           if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;

        9: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
      {$ENDIF}
    {$ENDIF}
   {$ELSE}
    {$IFDEF CLX}
      7: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
    {$ELSE}
      {$IFDEF BCB}
        7: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
      {$ELSE}
        7: if Assigned(TeeChartEditorHook) then 
              TeeChartEditorHook(Designer,Chart,EditSeriesProc)
           else
           if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;

        8: if Assigned(TeeDesignOptionsHook) then TeeDesignOptionsHook;
      {$ENDIF}
    {$ENDIF}
   {$ENDIF}
   else inherited;
   end;
  end;
  end;
end;

function TChartCompEditor.GetVerbCount : Integer;
begin
  Result:=inherited GetVerbCount+{$IFDEF TEESHOWCUSTOMAXES}8{$ELSE}7{$ENDIF};
  if Assigned(TeeChartEditorHook) then Inc(result);
  if Assigned(TeeDesignOptionsHook) then Inc(result);
end;

function TChartCompEditor.GetVerb( Index : Integer ) : string;
begin
  result:='';
  Case Index of
    0: begin  
         result:=TeeMsg_Version;
         if TeeIsTrial then result:=result+' TRIAL';
       end;

    1: result:=TeeMsg_Copyright;
    2: result:={$IFDEF D5}cLineCaption{$ELSE}'-'{$ENDIF};
    3: result:=TeeMsg_About;
    4: result:=TeeMsg_EditChart;
    5: result:=TeeMsg_PrintPreview;
    6: result:=TeeMsg_ExportChart;
   else
   begin
     case Index of 
     {$IFDEF TEESHOWCUSTOMAXES}
        7: result:=TeeMsg_CustomAxes;
        {$IFDEF BCB}
        8: result:=TeeMsg_Options;
        {$ELSE}
        8: if Assigned(TeeChartEditorHook) then result:=TeeMsg_SeriesList
                                           else result:=TeeMsg_Options; 
        9: result:=TeeMsg_Options;
        {$ENDIF}

     {$ELSE}
        {$IFDEF CLX}
        7: result:=TeeMsg_Options;
        {$ELSE}
        {$IFDEF BCB}
        7: result:=TeeMsg_Options;
        {$ELSE}
        7: if Assigned(TeeChartEditorHook) then result:=TeeMsg_SeriesList
                                           else result:=TeeMsg_Options; 
        8: result:=TeeMsg_Options;
        {$ENDIF}
        {$ENDIF}
     {$ENDIF}
     end;
   end;
  end;
end;

procedure TChartSeriesEditor.Edit;
begin
  {$IFNDEF CLX}
  EditSeriesProc(TChartSeries(Component),Designer);
  {$ENDIF}
end;

procedure TChartSeriesEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then Edit else inherited;
end;

function TChartSeriesEditor.GetVerbCount : Integer;
begin
  result:=inherited GetVerbCount+1;
end;

function TChartSeriesEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

{ Generic Chart Class Editor (for chart sub-components) }

{ TChartClassProperty }
function TChartClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties,paDialog];
end;

procedure TChartClassProperty.InternalEditPage( AChart:TCustomChart;
						APage:Integer);
begin
  EditChartPage(nil,AChart,APage);
  Designer.Modified;
end;

{ Chart Legend Editor }
procedure TChartLegendProperty.Edit;
begin
  EditChartLegend(nil,TCustomChart(TChartLegend({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}).ParentChart));
  Designer.Modified;
end;

{ Axis Chart Editor }
procedure TChartAxisProperty.Edit;
begin
  EditChartAxis(nil,TChartAxis({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}));
  Designer.Modified;
end;

{ Chart Series Editor }
function TChartSeriesListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

procedure TChartSeriesListProperty.Edit;
Var AChart : TCustomChart;
begin
  AChart:=TCustomChart(TChartSeriesList({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}).Owner);
  if Assigned(TeeChartEditorHook) then
     TeeChartEditorHook(Designer,AChart,EditSeriesProc)
  else
  begin
    EditChart(nil,AChart);
    Designer.Modified;
  end;
end;

{ Chart Axis Title Editor }
function TChartAxisTitleProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paSubProperties];
end;

{ Chart Title Editor }
procedure TChartTitleProperty.Edit;
begin
  EditChartTitle(nil,TChartTitle({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}));
  Designer.Modified;
end;

{ Chart Wall Editor }
procedure TChartWallProperty.Edit;
begin
  EditChartWall(nil,TChartWall({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}));
  Designer.Modified;
end;

{ Series Pointer Editor }
procedure TSeriesPointerProperty.Edit;
begin
  {$IFNDEF CLX}
  EditSeriesProc(TSeriesPointer({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}).ParentSeries,Designer);
  {$ENDIF}
end;

{ ChartPen Editor }
procedure TChartPenProperty.Edit;
begin
  if EditChartPen(nil,TChartPen({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF})) then
     Designer.Modified;
end;

{ ChartBrush Editor }
procedure TChartBrushProperty.Edit;
begin
  if EditChartBrush(nil,TChartBrush({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF})) then
     Designer.Modified;
end;

{ Chart Series Marks Editor }
procedure TSeriesMarksProperty.Edit;
var ASeriesMarks : TSeriesMarks;
begin
  ASeriesMarks:=TSeriesMarks({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF});
  if Assigned(ASeriesMarks) then
  With ASeriesMarks do
  if Assigned(ParentSeries) then
  begin
    EditSeriesMarks(nil,ParentSeries);
    Designer.Modified;
  end;
end;

{ Gradient Editor }
procedure TChartGradientProperty.Edit;
begin
  if EditTeeGradient(nil,TCustomTeeGradient({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF})) then
     Designer.Modified;
end;

{ TTeeShadowProperty }
procedure TTeeShadowProperty.Edit;
begin
  if EditTeeShadow(nil,TTeeShadow({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF})) then Designer.Modified;
end;

{ Bar Series Gradient Editor }
procedure TBarSeriesGradientProperty.Edit;
begin
  EditTeeGradient(nil,TBarSeriesGradient({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}),True,True);
end;

{ TSeriesDataSource Property }
type
  TSeriesDataSourceProperty = class(TComponentProperty)
  private
    FAddDataSetProc:TGetStrProc;
    procedure AddDataSource(Const S:String);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TSeriesDataSourceProperty.AddDataSource(Const S:String);
Var tmpSeries : TChartSeries;
    tmpComp   : TComponent;
begin
  if S<>'' then
  begin
    tmpComp:=Designer.GetComponent(S);
    if Assigned(tmpComp) then
    begin
      tmpSeries:=TChartSeries(GetComponent(0));
      if tmpSeries.ParentChart.IsValidDataSource(tmpSeries,tmpComp) then
	       FAddDataSetProc(S);
    end;
  end;
end;

procedure TSeriesDataSourceProperty.GetValues(Proc: TGetStrProc);
begin
  if Assigned(TChartSeries(GetComponent(0)).ParentChart) then
  Begin
    FAddDataSetProc:=Proc;
    {$IFDEF TEEDBREG}
    Designer.GetComponentNames(GetTypeData(TDataSource.ClassInfo),AddDataSource);
    Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo),AddDataSource);
    {$ENDIF}
    Designer.GetComponentNames(GetTypeData(TChartSeries.ClassInfo),AddDataSource);
    Designer.GetComponentNames(GetTypeData(TTeeSeriesSource.ClassInfo),AddDataSource);
  end;
end;

{$IFDEF TEEDBREG}
{ TCrosstabField Property }
type
  TCrosstabFieldProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TCrosstabFieldProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

procedure TCrosstabFieldProperty.GetValues(Proc: TGetStrProc);
var Crosstab : TDBCrossTabSource;
begin
  Crosstab:=TDBCrossTabSource(GetComponent(0));
  if Assigned(Crosstab.DataSet) then FillDataSetFields(Crosstab.DataSet,Proc);
end;
{$ENDIF}

{ TValueSource Property }
type
  TValueSourceProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TValueSourceProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

procedure TValueSourceProperty.GetValues(Proc: TGetStrProc);
Var AValueList : TChartValueList;
begin
  AValueList:=TChartValueList(GetComponent(0));
  With AValueList.Owner do
  if Assigned(ParentChart) then
      TCustomChart(ParentChart).FillValueSourceItems(AValueList,Proc);
end;

{ TSeriesSource Property }
type
  TSeriesSourceProperty=class(TStringProperty)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TSeriesSourceProperty.GetValues(Proc: TGetStrProc);
Var ASeries : TChartSeries;
begin
  ASeries:=TChartSeries(GetComponent(0));
  With ASeries do
  if Assigned(ParentChart) then
     TCustomChart(ParentChart).FillSeriesSourceItems(ASeries,Proc);
end;

function TSeriesSourceProperty.GetAttributes : TPropertyAttributes;
Begin
  result:=inherited GetAttributes+[paValueList];
end;

{$IFDEF TEEDBREG}

{ DBChart Editor }
procedure TDBChartCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index+1=GetVerbCount then TCustomDBChart(Component).RefreshData
                          else inherited;
end;

function TDBChartCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TDBChartCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index+1=GetVerbCount then result:=TeeMsg_RefreshData
                          else result:=inherited GetVerb(Index);
end;

{$ENDIF}

{ View3DOptions Editor }
procedure TView3DOptionsProperty.Edit;
begin
  InternalEditPage(TCustomChart(TView3DOptions({$IFDEF CLR}GetObjValue{$ELSE}GetOrdValue{$ENDIF}).Parent),teeEdit3DPage);
end;

{$IFDEF D6}
Const TChartAxesCategory   ='Axes';
      TChartWallsCategory  ='Walls';
      TChartTitlesCategory ='Titles';
      TChart3DCategory     ='3D';
{$ELSE}
{$IFDEF CLX}
Const TChartAxesCategory   ='Axes';
      TChartWallsCategory  ='Walls';
      TChartTitlesCategory ='Titles';
      TChart3DCategory     ='3D';
{$ELSE}
{$IFDEF D5}
{ TChartAxesCategory }
class function TChartAxesCategory.Name: string;
begin
  Result:=TeeMsg_ChartAxesCategoryName;
end;

class function TChartAxesCategory.Description: string;
begin
  Result:=TeeMsg_ChartAxesCategoryDesc;
end;

{ TChartWallsCategory }
class function TChartWallsCategory.Name: string;
begin
  Result:=TeeMsg_ChartWallsCategoryName;
end;

class function TChartWallsCategory.Description: string;
begin
  Result:=TeeMsg_ChartWallsCategoryDesc;
end;

{ TChartTitlesCategory }
class function TChartTitlesCategory.Name: string;
begin
  Result:=TeeMsg_ChartTitlesCategoryName;
end;

class function TChartTitlesCategory.Description: string;
begin
  Result:=TeeMsg_ChartTitlesCategoryDesc;
end;

{ TChart3DCategory }
class function TChart3DCategory.Name: string;
begin
  Result:=TeeMsg_Chart3DCategoryName;
end;

class function TChart3DCategory.Description: string;
begin
  Result:=TeeMsg_Chart3DCategoryDesc;
end;
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$ENDIF}

procedure Register;
begin
  RegisterNoIcon([ TCustomChartElement, TTeeFunction ]);

  RegisterComponents( {$IFDEF CLR}TeeMsg_TeeChartPalette{$ELSE}tcAdditional{$ENDIF}, 
                      [TChart] );

  {$IFDEF TEEEDITORS}
  RegisterComponentEditor(TCustomChart,TChartCompEditor);
  {$ENDIF}

  {$IFDEF TEEDBREG}
  RegisterComponents( {$IFDEF CLR}TeeMsg_TeeChartPalette{$ELSE}tcDControls{$ENDIF}, 
                      [TDBChart] );

  {$IFDEF TEEEDITORS}
  RegisterComponentEditor(TCustomDBChart,TDBChartCompEditor);
  {$ENDIF}

  RegisterComponents( TeeMsg_TeeChartPalette,
                      [ {$IFNDEF CLR}TSeriesDataSet,{$ENDIF}
                        TDBCrossTabSource ] );
  {$ENDIF}

  {$IFDEF TEEEDITORS}
  {$IFDEF D6}
  RegisterComponentEditor(TChartSeries,TChartSeriesEditor);
  {$ENDIF}
  {$ENDIF}

  RegisterComponents(TeeMsg_TeeChartPalette,[ TButtonColor,
                                              TButtonPen,
                                              TComboFlat
                                            ]);

  {$IFDEF CLX}
  RegisterComponents(TeeMsg_TeeChartPalette,[TUpDown]);
  {$ENDIF}

  {$IFNDEF CLR}
  {$IFNDEF CLX}
  RegisterNonActiveX( [ TCustomTeePanel,
			TCustomAxisPanel,
			TCustomChart,TChart
                        {$IFDEF TEEDBREG}
			,TCustomDBChart,TDBChart
                        {$ENDIF}
                      ] , axrIncludeDescendants );
  {$ENDIF}
  {$ENDIF}

  {$IFDEF TEEEDITORS}
  RegisterPropertyEditor(TypeInfo(TSeriesMarks),TChartSeries,
				  'Marks', TSeriesMarksProperty);
  RegisterPropertyEditor(TypeInfo(TSeriesPointer), TCustomSeries, 'Pointer',
						   TSeriesPointerProperty);

  RegisterPropertyEditor(TypeInfo(TChartWall),nil,'',TChartWallProperty);

  RegisterPropertyEditor(TypeInfo(TChartTitle),TCustomChart,
				  '', TChartTitleProperty);

  RegisterPropertyEditor(TypeInfo(TCustomChartLegend),TCustomChart,
				  'Legend', TChartLegendProperty);

  RegisterPropertyEditor(TypeInfo(TChartAxis),TCustomChart,
				  '', TChartAxisProperty);

  RegisterPropertyEditor(TypeInfo(TChartSeriesList), TCustomChart, 'SeriesList',
						     TChartSeriesListProperty);

  RegisterPropertyEditor(TypeInfo(TChartAxisTitle), TChartAxis, 'Title',
						    TChartAxisTitleProperty);
  RegisterPropertyEditor(TypeInfo(TCustomTeeGradient),nil,
				  '', TChartGradientProperty);

  RegisterPropertyEditor(TypeInfo(TTeeShadow),nil,'', TTeeShadowProperty);

  RegisterPropertyEditor(TypeInfo(TBarSeriesGradient),TCustomBarSeries,
				  '', TBarSeriesGradientProperty);

  RegisterPropertyEditor( TypeInfo(TComponent),
			  TChartSeries,'DataSource',TSeriesDataSourceProperty);

  RegisterPropertyEditor( TypeInfo(String),
			  TChartValueList,'ValueSource',TValueSourceProperty);

  {$IFDEF TEEDBREG}
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'GroupField',TCrosstabFieldProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'LabelField',TCrosstabFieldProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TDBCrossTabSource,'ValueField',TCrosstabFieldProperty);
  {$ENDIF}

  RegisterPropertyEditor( TypeInfo(String),
			  TChartSeries,'ColorSource',TSeriesSourceProperty);
  RegisterPropertyEditor( TypeInfo(String),
			  TChartSeries,'XLabelsSource',TSeriesSourceProperty);

  RegisterPropertyEditor(TypeInfo(TChartPen), nil, '',TChartPenProperty);
  RegisterPropertyEditor(TypeInfo(TChartBrush), nil, '',TChartBrushProperty);
  RegisterPropertyEditor(TypeInfo(TView3DOptions),TCustomChart,
				  'View3DOptions', TView3DOptionsProperty);

  {$IFDEF D5}
  RegisterPropertyInCategory(TChartAxesCategory, TypeInfo(TChartAxis));
  RegisterPropertyInCategory(TChartAxesCategory, TCustomAxisPanel, 'AxisBehind');
  RegisterPropertyInCategory(TChartAxesCategory, TCustomAxisPanel, 'AxisVisible');
  RegisterPropertyInCategory(TChartAxesCategory, TypeInfo(TChartCustomAxes));
  RegisterPropertyInCategory(TChartWallsCategory, TypeInfo(TCustomChartWall));
  RegisterPropertyInCategory(TChartWallsCategory, TCustomAxisPanel, 'View3DWalls');
  RegisterPropertyInCategory(TChartTitlesCategory, TypeInfo(TChartTitle));
  RegisterPropertyInCategory(TChart3DCategory, TypeInfo(TView3DOptions));
  RegisterPropertyInCategory(TChart3DCategory, TCustomTeePanel, 'View3D');
  RegisterPropertyInCategory(TChart3DCategory, TCustomTeePanel, 'Chart3DPercent');
  {$ENDIF}

  {$ENDIF}
end;

{$IFDEF SPLASH_BDS}
class procedure TeeChartIDE.IDERegister;
var b : TBitmap;

   procedure AddSplash;
   var about  : IOTAAboutBoxService;
       splash : IOTASplashScreenService;
   begin
    about:=BorlandIDE.GetService(System.Type(typeof(IOTAAboutBoxService))) as IOTAAboutBoxService;
    if Assigned(about) then
    begin
      about.AddPluginInfo(TeeMsg_TeeChartPalette, TeeMsg_TeeChartPalette,
                          IntPtr(b.Handle),
                          False,
                          'TeeChart Components'+#13+TeeMsg_Copyright+#13+
                          'www.steema.com',
                          TeeMsg_Version);

    end;

    splash:=BorlandIDE.SplashScreenService;
    if Assigned(splash) then
    begin
       splash.AddProductBitmap(TeeMsg_TeeChartPalette,
                            IntPtr(b.Handle),
                            False,
                            'The TeeChart Components'+#13+TeeMsg_Copyright+#13+
                            'www.steema.com',
                            TeeMsg_Version);
       splash.SetProductIcon(IntPtr(b.Handle));
       splash.ShowProductSplash(IntPtr(b.Handle));
    end;
  end;

begin
  b:=TBitmap.Create;
  try
    with TTeeAboutForm.Create(nil) do
    try
      b.Assign(Image2.Picture);
    finally
      Free;
    end;

    AddSplash;
  finally
    b.Free;
  end;
end;
{$ENDIF}

{$IFDEF TEELITE}
Procedure TeeOptionsFormHook;
begin
  with TOptionsForm.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;
{$ENDIF}

initialization
 {$IFDEF TEEDBREG}
 OnGetDesignerNames:=DesignTimeOnGetDesignerNames;
 {$ENDIF}

 {$IFDEF TEELITE}
 TeeDesignOptionsHook:=TeeOptionsFormHook;
 {$ENDIF}

finalization
 {$IFDEF TEELITE}
 TeeDesignOptionsHook:=nil;  // For TeeChartReg "Options..." menu item
 {$ENDIF}

 {$IFDEF TEEDBREG}
 OnGetDesignerNames:=nil;
 {$ENDIF}
end.
