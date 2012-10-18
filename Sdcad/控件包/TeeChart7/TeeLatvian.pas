unit TeeLatvian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeLatvianLanguage:TStringList=nil;

Procedure TeeSetLatvian;
Procedure TeeCreateLatvian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeLatvianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='First Legend Value must be > 0';
  TeeMsg_LegendColorWidth   :='Legend Color Width must be > 0%';
  TeeMsg_SeriesSetDataSource:='No ParentChart to validate DataSource';
  TeeMsg_SeriesInvDataSource:='No valid DataSource: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues must be > 0';
  TeeMsg_AxisLogDateTime    :='DateTime Axis cannot be Logarithmic';
  TeeMsg_AxisLogNotPositive :='Logarithmic Axis Min and Max values should be >= 0';
  TeeMsg_AxisLabelSep       :='Labels Separation % must be greater than 0';
  TeeMsg_AxisIncrementNeg   :='Axis increment must be >= 0';
  TeeMsg_AxisMinMax         :='Axis Minimum Value must be <= Maximum';
  TeeMsg_AxisMaxMin         :='Axis Maximum Value must be >= Minimum';
  TeeMsg_AxisLogBase        :='Axis Logarithmic Base should be >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage must be >= 0';
  TeeMsg_3dPercent          :='3D effect percent must be between %d and %d';
  TeeMsg_CircularSeries     :='Circular Series dependences are not allowed';
  TeeMsg_WarningHiColor     :='16k Color or greater required to get better look';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Axis Title';
  TeeMsg_AxisLabels         :='Axis Labels';
  TeeMsg_RefreshInterval    :='Refresh Interval must be between 0 and 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart is not myself!';
  TeeMsg_GalleryLine        :='Line';
  TeeMsg_GalleryPoint       :='Point';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Bar';
  TeeMsg_GalleryHorizBar    :='Horiz. Bar';
  TeeMsg_Stack              :='Stack';
  TeeMsg_GalleryPie         :='Pie';
  TeeMsg_GalleryCircled     :='Circled';
  TeeMsg_GalleryFastLine    :='Fast Line';
  TeeMsg_GalleryHorizLine   :='Horiz Line';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editing %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Extended';
  TeeMsg_GalleryFunctions   :='Functions';

  TeeMsg_EditChart          :='E&dit Chart...';
  TeeMsg_PrintPreview       :='&Print Preview...';
  TeeMsg_ExportChart        :='E&xport Chart...';
  TeeMsg_CustomAxes         :='Custom Axes...';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: has no Editor Dialog';

  TeeMsg_GalleryArrow       :='Arrow';

  TeeMsg_ExpFinish          :='&Finish';
  TeeMsg_ExpNext            :='&Next >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Development';
  TeeMsg_GanttSample4       :='Sales';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='New Version';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Change Series Title';
  TeeMsg_NewSeriesTitle     :='New Series Title:';
  TeeMsg_DateTime           :='DateTime';
  TeeMsg_TopAxis            :='Top Axis';
  TeeMsg_BottomAxis         :='Bottom Axis';
  TeeMsg_LeftAxis           :='Left Axis';
  TeeMsg_RightAxis          :='Right Axis';

  TeeMsg_SureToDelete       :='Delete %s ?';
  TeeMsg_DateTimeFormat     :='DateTime For&mat:';
  TeeMsg_Default            :='Default';
  TeeMsg_ValuesFormat       :='Values For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Desired %s Increment';

  TeeMsg_IncorrectMaxMinValue:='Incorrect value. Reason: %s';
  TeeMsg_EnterDateTime      :='Enter [Number of Days] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Apply Changes ?';
  TeeMsg_SelectedSeries     :='(Selected Series)';
  TeeMsg_RefreshData        :='&Refresh Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Add';
  TeeMsg_FunctionSubtract   :='Subtract';
  TeeMsg_FunctionMultiply   :='Multiply';
  TeeMsg_FunctionDivide     :='Divide';
  TeeMsg_FunctionHigh       :='High';
  TeeMsg_FunctionLow        :='Low';
  TeeMsg_FunctionAverage    :='Average';

  TeeMsg_GalleryShape       :='Shape';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='Copy';

  TeeMsg_None               :='(none)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer size must be greater than zero';
  TeeMsg_About              :='Abo&ut TeeChart...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Single Record';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='Function Period should be >= 0';

  TeeMsg_WizardTab          :='Business';
  TeeMsg_TeeChartWizard     :='TeeChart Wizard';

  TeeMsg_ClearImage         :='Clea&r';
  TeeMsg_BrowseImage        :='B&rowse...';

  TeeMsg_WizardSureToClose  :='Are you sure that you want to close the TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Field %s does not exist';

  TeeMsg_DepthAxis          :='Depth Axis';
  TeeMsg_PieOther           :='Other';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pie';
  TeeMsg_ValuesBar          :='Bar';
  TeeMsg_ValuesAngle        :='Angle';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='End';
  TeeMsg_ValuesGanttNextTask:='NextTask';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='Legend';
  TeeMsg_Title              :='Title';
  TeeMsg_Foot               :='Footer';
  TeeMsg_Period		    :='Period';
  TeeMsg_PeriodRange        :='Period range';
  TeeMsg_CalcPeriod         :='Calculate %s every:';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid Chart in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.'+TeeMsg_TeeExtension+' file format';
  TeeMsg_EmptyTeeFile       :='Empty *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Chart Axes';
  TeeMsg_ChartAxesCategoryDesc   := 'Chart Axes properties and events';
  TeeMsg_ChartWallsCategoryName  := 'Chart Walls';
  TeeMsg_ChartWallsCategoryDesc  := 'Chart Walls properties and events';
  TeeMsg_ChartTitlesCategoryName := 'Chart Titles';
  TeeMsg_ChartTitlesCategoryDesc := 'Chart Titles properties and events';
  TeeMsg_Chart3DCategoryName     := 'Chart 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Chart 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Custom ';
  TeeMsg_Series                 :='Series';
  TeeMsg_SeriesList             :='Series...';

  TeeMsg_PageOfPages            :='Page %d of %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='First';
  TeeMsg_Prior  :='Prior';
  TeeMsg_Next   :='Next';
  TeeMsg_Last   :='Last';
  TeeMsg_Insert :='Insert';
  TeeMsg_Delete :='Delete';
  TeeMsg_Edit   :='Edit';
  TeeMsg_Post   :='Post';
  TeeMsg_Cancel :='Cancel';

  TeeMsg_All    :='(all)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Panel property is not set in Export format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='No Border';
  TeeMsg_Dotted    :='Dotted';
  TeeMsg_Colors    :='Colors';
  TeeMsg_Filled    :='Filled';
  TeeMsg_Marks     :='Marks';
  TeeMsg_Stairs    :='Stairs';
  TeeMsg_Points    :='Points';
  TeeMsg_Height    :='Height';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='Triangle';
  TeeMsg_Star      :='Star';
  TeeMsg_Circle    :='Circle';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='Cross';
  TeeMsg_Diamond   :='Diamond';
  TeeMsg_NoLines   :='No Lines';
  TeeMsg_Stack100  :='Stack 100%';
  TeeMsg_Pyramid   :='Pyramid';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Inv. Pyramid';
  TeeMsg_Sides     :='Sides';
  TeeMsg_SideAll   :='Side All';
  TeeMsg_Patterns  :='Patterns';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='Shadow';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Vert.Line';
  TeeMsg_HorizLine :='Horiz.Line';
  TeeMsg_Line      :='Line';
  TeeMsg_Cube      :='Cube';
  TeeMsg_DiagCross :='Diag.Cross';

  TeeMsg_CanNotFindTempPath    :='Can not find Temp folder';
  TeeMsg_CanNotCreateTempChart :='Can not create Temp file';
  TeeMsg_CanNotEmailChart      :='Can not email TeeChart. Mapi Error: %d';

  TeeMsg_SeriesDelete :='Series Delete: ValueIndex %d out of bounds (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='as &JPEG';
  TeeMsg_JPEGFilter    :='JPEG files (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='as &GIF';
  TeeMsg_GIFFilter     :='GIF files (*.gif)|*.gif';
  TeeMsg_AsPNG         :='as &PNG';
  TeeMsg_PNGFilter     :='PNG files (*.png)|*.png';
  TeeMsg_AsPCX         :='as PC&X';
  TeeMsg_PCXFilter     :='PCX files (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='as &VML (HTM)';
  TeeMsg_VMLFilter     :='VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Language...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Candle';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Surface';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Point 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Bar 3D';
  TeeMsg_GalleryBigCandle   :='Big Candle';
  TeeMsg_GalleryLinePoint   :='Line Point';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Water Fall';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Clock';
  TeeMsg_GalleryColorGrid   :='ColorGrid';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Bar Join';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramid';
  TeeMsg_GalleryMap         :='Map';

  TeeMsg_PolyDegreeRange    :='Polynomial degree must be between 1 and 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='Period must be >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='Error Bar';
  TeeMsg_GalleryError        :='Error';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp. Average';
  TeeMsg_FunctionMovingAverage:='Moving Avrg.';
  TeeMsg_FunctionExpMovAve   :='Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='Std.Deviation';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Count';
  TeeMsg_LoadChart           :='Open TeeChart...';
  TeeMsg_SaveChart           :='Save TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro files';

  TeeMsg_GallerySamples      :='Other';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Cannot find Series editor Form: %s';


  TeeMsg_CannotLoadChartFromURL:='Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Error code: %d downloading Series data from URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Date';
  TeeMsg_ValuesOpen          :='Open';
  TeeMsg_ValuesHigh          :='High';
  TeeMsg_ValuesLow           :='Low';
  TeeMsg_ValuesClose         :='Close';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Number of Bezier points should be > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Print';
  TeeCommanMsg_Copy     :='Copy';
  TeeCommanMsg_Save     :='Save';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d° Elevation: %d°';
  TeeCommanMsg_Rotate   :='Rotate';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Move';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Depth';

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Drag %s to Rotate';
  TeeCommanMsg_MoveLabel  :='Drag %s to Move';
  TeeCommanMsg_ZoomLabel  :='Drag %s to Zoom';
  TeeCommanMsg_DepthLabel :='Drag %s to resize 3D';

  TeeCommanMsg_NormalLabel:='Drag Left button to Zoom, Right button to Scroll';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='Number of points must be >= 4';
  TeeMsg_TriSurfaceAllColinear :='All colinear data points';
  TeeMsg_TriSurfaceSimilar     :='Similar points - cannot execute';
  TeeMsg_GalleryTriSurface     :='Triangle Surf.';

  TeeMsg_AllSeries :='All Series';
  TeeMsg_Edit      :='Edit';

  TeeMsg_GalleryFinancial    :='Financial';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Drag Marks';
  TeeMsg_AxisArrowTool :='Axis Arrows';
  TeeMsg_DrawLineTool  :='Draw Line';
  TeeMsg_NearestTool   :='Nearest Point';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Color Line';
  TeeMsg_RotateTool    :='Rotate';
  TeeMsg_ImageTool     :='Image';
  TeeMsg_MarksTipTool  :='Mark Tips';
  TeeMsg_AnnotationTool:='Annotation';

  TeeMsg_CantDeleteAncestor  :='Can not delete ancestor';

  TeeMsg_Load	          :='Load...';
  TeeMsg_NoSeriesSelected :='No Series selected';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Series';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Switch 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Active';
  TeeMsg_ActionSeriesActiveHint := 'Show / Hide Series';
  TeeMsg_ActionEditHint         := 'Edit Chart';
  TeeMsg_ActionEdit             := '&Edit...';
  TeeMsg_ActionCopyHint         := 'Copy to Clipboard';
  TeeMsg_ActionCopy             := '&Copy';
  TeeMsg_ActionPrintHint        := 'Print preview Chart';
  TeeMsg_ActionPrint            := '&Print...';
  TeeMsg_ActionAxesHint         := 'Show / Hide Axes';
  TeeMsg_ActionAxes             := '&Axes';
  TeeMsg_ActionGridsHint        := 'Show / Hide Grids';
  TeeMsg_ActionGrids            := '&Grids';
  TeeMsg_ActionLegendHint       := 'Show / Hide Legend';
  TeeMsg_ActionLegend           := '&Legend';
  TeeMsg_ActionSeriesEditHint   := 'Edit Series';
  TeeMsg_ActionSeriesMarksHint  := 'Show / Hide Series Marks';
  TeeMsg_ActionSeriesMarks      := '&Marks';
  TeeMsg_ActionSaveHint         := 'Save Chart';
  TeeMsg_ActionSave             := '&Save...';

  TeeMsg_CandleBar              := 'Bar';
  TeeMsg_CandleNoOpen           := 'No Open';
  TeeMsg_CandleNoClose          := 'No Close';
  TeeMsg_NoLines                := 'No Lines';
  TeeMsg_NoHigh                 := 'No High';
  TeeMsg_NoLow                  := 'No Low';
  TeeMsg_ColorRange             := 'Color Range';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := 'Positions';
  TeeMsg_NoGrid                 := 'No Grid';
  TeeMsg_NoPoint                := 'No Point';
  TeeMsg_NoLine                 := 'No Line';
  TeeMsg_Labels                 := 'Labels';
  TeeMsg_NoCircle               := 'No Circle';
  TeeMsg_Lines                  := 'Lines';
  TeeMsg_Border                 := 'Border';

  TeeMsg_SmithResistance      := 'Resistance';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := 'Column';

  { 5.01 }
  TeeMsg_Separator            := 'Separator';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Exceeds quota';
  TeeMsg_FunnelWithin         := ' within quota';
  TeeMsg_FunnelBelow          := ' or more below quota';
  TeeMsg_CalendarSeries       := 'Calendar';
  TeeMsg_DeltaPointSeries     := 'DeltaPoint';
  TeeMsg_ImagePointSeries     := 'ImagePoint';
  TeeMsg_ImageBarSeries       := 'ImageBar';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Transparency';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Page Number';
  TeeMsg_TextFile             := 'Text File';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateLatvian;
begin
  if not Assigned(TeeLatvianLanguage) then
  begin
    TeeLatvianLanguage:=TStringList.Create;
    TeeLatvianLanguage.Text:=

'LABELS=Textos'+#13+
'DATASET=Tabla'+#13+
'ALL RIGHTS RESERVED.=Todos los Derechos Reservados.'+#13+
'APPLY=Aplicar'+#13+
'CLOSE=Cerrar'+#13+
'OK=Aceptar'+#13+
'ABOUT TEECHART PRO V7.0=Acerca de TeeChart Pro v7.0'+#13+
'OPTIONS=Opciones'+#13+
'FORMAT=Formato'+#13+
'TEXT=Texto'+#13+
'GRADIENT=Gradiente'+#13+
'SHADOW=Sombra'+#13+
'POSITION=Posición'+#13+
'LEFT=Izquierda'+#13+
'TOP=Arriba'+#13+
'CUSTOM=Person.'+#13+
'PEN=Lápiz'+#13+
'PATTERN=Trama'+#13+
'SIZE=Tamaño'+#13+
'BEVEL=Marco'+#13+
'INVERTED=Invertido'+#13+
'INVERTED SCROLL=Desplaz. Invertido'+#13+
'BORDER=Borde'+#13+
'ORIGIN=Origen'+#13+
'USE ORIGIN=Usar Origen'+#13+
'AREA LINES=Líneas Area'+#13+
'AREA=Area'+#13+
'COLOR=Color'+#13+
'SERIES=Series'+#13+
'SUM=Suma'+#13+
'DAY=Dia'+#13+
'QUARTER=Trimestre'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Visible'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Línea Horiz.'+#13+
'LABEL AND PERCENT=Etiqueta y Porcentaje'+#13+
'LABEL AND VALUE=Etiqueta y Valor'+#13+
'LABEL AND PERCENT TOTAL=Etiqueta Porc. Total'+#13+
'PERCENT TOTAL=Total Porcentaje'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Restar'+#13+
'MULTIPLY=Multiplicar'+#13+
'DIVIDE=Dividir'+#13+
'STAIRS=Escaleras'+#13+
'MOMENTUM=Momento'+#13+
'AVERAGE=Media'+#13+
'XML=XML'+#13+
'HTML TABLE=Tabla HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Ninguno'+#13+
'(NONE)=Ninguna'#13+
'WIDTH=Ancho'+#13+
'HEIGHT=Alto'+#13+
'COLOR EACH=Colorea Cada'+#13+
'STACK=Apilar'+#13+
'STACKED=Apilado'+#13+
'STACKED 100%=Apilado 100%'+#13+
'AXIS=Eje'+#13+
'LENGTH=Longitud'+#13+
'CANCEL=Cancelar'+#13+
'SCROLL=Desplazamiento'+#13+
'INCREMENT=Incremento'+#13+
'VALUE=Valor'+#13+
'STYLE=Estilo'+#13+
'JOIN=Unión'+#13+
'AXIS INCREMENT=Incremento de Eje'+#13+
'AXIS MAXIMUM AND MINIMUM=Máximo y Mínimo de Eje'+#13+
'% BAR WIDTH=Ancho Barra %'+#13+
'% BAR OFFSET=Desplaz. Barra %'+#13+
'BAR SIDE MARGINS=Márgenes Laterales'+#13+
'AUTO MARK POSITION=Posición Marcas Auto.'+#13+
'DARK BAR 3D SIDES=Lados Barra Oscuros'+#13+
'MONOCHROME=Monocromo'+#13+
'COLORS=Colores'+#13+
'DEFAULT=Defecto'+#13+
'MEDIAN=Mediana'+#13+
'IMAGE=Imagen'+#13+
'DAYS=Dias'+#13+
'WEEKDAYS=Laborables'+#13+
'TODAY=Hoy'+#13+
'SUNDAY=Domingo'+#13+
'MONTHS=Meses'+#13+
'LINES=Líneas'+#13+
'UPPERCASE=Mayúsculas'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=Ancho Candle'+#13+
'BAR=Barra'+#13+
'OPEN CLOSE=Aper. Cierre'+#13+
'DRAW 3D=Dibujar 3D'+#13+
'DARK 3D=Oscuro 3D'+#13+
'SHOW OPEN=Ver Apertura'+#13+
'SHOW CLOSE=Ver Cierre'+#13+
'UP CLOSE=Cierre Arriba'+#13+
'DOWN CLOSE=Cierre Abajo'+#13+
'CIRCLED=Circular'+#13+
'CIRCLE=Círculo'+#13+
'3 DIMENSIONS=3 Dimensiones'+#13+
'ROTATION=Rotación'+#13+
'RADIUS=Radios'+#13+
'HOURS=Horas'+#13+
'HOUR=Hora'+#13+
'MINUTES=Minutos'+#13+
'SECONDS=Segundos'+#13+
'FONT=Fuente'+#13+
'INSIDE=Interior'+#13+
'ROTATED=Rotar'+#13+
'ROMAN=Romanos'+#13+
'TRANSPARENCY=Transparencia'+#13+
'DRAW BEHIND=Dibujar Detrás'+#13+
'RANGE=Rango'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Pasos'+#13+
'GRID=Rejilla'+#13+
'GRID SIZE=Tamaño Rejilla'+#13+
'ALLOW DRAG=Permite arrastrar'+#13+
'AUTOMATIC=Automático'+#13+
'LEVEL=Nivel'+#13+
'LEVELS POSITION=Posición Niveles'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=Seguir Ratón'+#13+
'TRANSPARENT=Transparente'+#13+
'ROUND FRAME=Marco Redondo'+#13+
'FRAME=Marco'+#13+
'START=Inicio'+#13+
'END=Final'+#13+
'MIDDLE=Medio'+#13+
'NO MIDDLE=Sin Medio'+#13+
'DIRECTION=Dirección'+#13+
'DATASOURCE=Origen de Datos'+#13+
'AVAILABLE=Disponibles'+#13+
'SELECTED=Seleccionados'+#13+
'CALC=Calcular'+#13+
'GROUP BY=Agrupar por'+#13+
'OF=de'+#13+
'HOLE %=Agujero %'+#13+
'RESET POSITIONS=Posiciones defecto'+#13+
'MOUSE BUTTON=Botón Ratón'+#13+
'ENABLE DRAWING=Permite Dibujar'+#13+
'ENABLE SELECT=Permite Seleccionar'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Angulo'+#13+
'ZOOM TEXT=Amplia Textos'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=Ampliar'+#13+
'ELEVATION=Elevación'+#13+
'BEHIND=Detrás'+#13+
'AXES=Ejes'+#13+
'SCALES=Escalas'+#13+
'TITLE=Título'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=Centrado'+#13+
'CENTER=Centro'+#13+
'PATTERN COLOR EDITOR=Editor de Trama'+#13+
'START VALUE=Valor Inicial'+#13+
'END VALUE=Valor Final'+#13+
'COLOR MODE=Modo de Color'+#13+
'LINE MODE=Modo de Línea'+#13+
'HEIGHT 3D=Alto 3D'+#13+
'OUTLINE=Borde'+#13+
'PRINT PREVIEW=Imprimir'+#13+
'ANIMATED=Animado'+#13+
'ALLOW=Permitir'+#13+
'DASH=Líneas'+#13+
'DOT=Puntos'+#13+
'DASH DOT DOT=Línea Punto Punto'+#13+
'PALE=Suave'+#13+
'STRONG=Fuerte'+#13+
'WIDTH UNITS=Unidades'+#13+
'FOOT=Pie'+#13+
'SUBFOOT=Sub Pie'+#13+
'SUBTITLE=Subtítulo'+#13+
'LEGEND=Leyenda'+#13+
'COLON=Dos puntos'+#13+
'AXIS ORIGIN=Origen Eje'+#13+
'UNITS=Unidades'+#13+
'PYRAMID=Pirámide'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=Cubo'+#13+
'TRIANGLE=Triángulo'+#13+
'STAR=Estrella'+#13+
'SQUARE=Cuadrado'+#13+
'DOWN TRIANGLE=Triángulo Invert.'+#13+
'SMALL DOT=Puntito'+#13+
'LOAD=Cargar'+#13+
'FILE=Archivo'+#13+
'RECTANGLE=Rectángulo'+#13+
'HEADER=Cabecera'+#13+
'CLEAR=Borrar'+#13+
'ONE HOUR=Una Hora'+#13+
'ONE YEAR=Un Año'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=Cono'+#13+
'ARROW=Flecha'+#13+
'CYLLINDER=Cilindro'+#13+
'TIME=Hora'+#13+
'BRUSH=Trama'+#13+
'LINE=Línea'+#13+
'VERTICAL LINE=Línea Vertical'+#13+
'AXIS ARROWS=Flechas en Ejes'+#13+
'MARK TIPS=Sugerencias'+#13+
'DASH DOT=Línea Punto'+#13+
'COLOR BAND=Bandas de Color'+#13+
'COLOR LINE=Linea de Color'+#13+
'INVERT. TRIANGLE=Triángulo Invert.'+#13+
'INVERT. PYRAMID=Pirámide Invert.'+#13+
'INVERTED PYRAMID=Pirámide Invert.'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Origen de Datos de Texto'+#13+
'SOLID=Sólido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=Puntos'+#13+
'SIDE BRUSH=Trama Lateral'+#13+
'SIDE=Al lado'+#13+
'SIDE ALL=Lateral'+#13+
'ROTATE=Rotar'+#13+
'SMOOTH PALETTE=Paleta suavizada'+#13+
'CHART TOOLS GALLERY=Galería de Herramientas'+#13+
'ADD=Añadir'+#13+
'BORDER EDITOR=Editor de Borde'+#13+
'DRAWING MODE=Modo de Dibujo'+#13+
'CLOSE CIRCLE=Cerrar Círculo'+#13+
'PICTURE=Imagen'+#13+
'NATIVE=Nativo'+#13+
'DATA=Datos'+#13+
'KEEP ASPECT RATIO=Mantener proporción'+#13+
'COPY=Copiar'+#13+
'SAVE=Guardar'+#13+
'SEND=Enviar'+#13+
'INCLUDE SERIES DATA=Incluir Datos de Series'+#13+
'FILE SIZE=Tamaño del Archivo'+#13+
'INCLUDE=Incluir'+#13+
'POINT INDEX=Indice de Puntos'+#13+
'POINT LABELS=Etiquetas de Puntos'+#13+
'DELIMITER=Delimitador'+#13+
'DEPTH=Profund.'+#13+
'COMPRESSION LEVEL=Nivel Compresión'+#13+
'COMPRESSION=Compresión'+#13+
'PATTERNS=Tramas'+#13+
'LABEL=Etiqueta'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=Separar Porción'+#13+
'TOTAL ANGLE=Angulo Total'+#13+
'HORIZ. SIZE=Tamaño Horiz.'+#13+
'VERT. SIZE=Tamaño Vert.'+#13+
'SHAPES=Formas'+#13+
'INFLATE MARGINS=Ampliar Márgenes'+#13+
'QUALITY=Calidad'+#13+
'SPEED=Velocidad'+#13+
'% QUALITY=% Calidad'+#13+
'GRAY SCALE=Escala de Grises'+#13+
'PERFORMANCE=Mejor'+#13+
'BROWSE=Seleccionar'+#13+
'TILED=Mosaico'+#13+
'HIGH=Alto'+#13+
'LOW=Bajo'+#13+
'DATABASE CHART=Gráfico con Base de Datos'+#13+
'NON DATABASE CHART=Gráfico sin Base de Datos'+#13+
'HELP=Ayuda'+#13+
'NEXT >=Siguiente >'+#13+
'< BACK=< Anterior'+#13+
'TEECHART WIZARD=Asistente de TeeChart'+#13+
'PERCENT=Porcentual'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=Ancho Error'+#13+
'ENHANCED=Mejorado'+#13+
'VISIBLE WALLS=Ver Paredes'+#13+
'ACTIVE=Activo'+#13+
'DELETE=Borrar'+#13+
'ALIGNMENT=Alineación'+#13+
'ADJUST FRAME=Ajustar Marco'+#13+
'HORIZONTAL=Horizontal'+#13+
'VERTICAL=Vertical'+#13+
'VERTICAL POSITION=Posición Vertical'+#13+
'NUMBER=Número'+#13+
'LEVELS=Niveles'+#13+
'OVERLAP=Sobreponer'+#13+
'STACK 100%=Apilar 100%'+#13+
'MOVE=Mover'+#13+
'CLICK=Clic'+#13+
'DELAY=Retraso'+#13+
'DRAW LINE=Dibujar Línea'+#13+
'FUNCTIONS=Funciones'+#13+
'SOURCE SERIES=Series Origen'+#13+
'ABOVE=Arriba'+#13+
'BELOW=Abajo'+#13+
'Dif. Limit=Límite Dif.'+#13+
'WITHIN=Dentro'+#13+
'EXTENDED=Extendidas'+#13+
'STANDARD=Estandard'+#13+
'STATS=Estadística'+#13+
'FINANCIAL=Financieras'+#13+
'OTHER=Otras'+#13+
'TEECHART GALLERY=Galería de Gráficos TeeChart'+#13+
'CONNECTING LINES=Líneas de Conexión'+#13+
'REDUCTION=Reducción'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=Intensidad'+#13+
'FONT OUTLINES=Borde Fuentes'+#13+
'SMOOTH SHADING=Sombras suaves'+#13+
'AMBIENT LIGHT=Luz Ambiente'+#13+
'MOUSE ACTION=Acción del Ratón'+#13+
'CLOCKWISE=Segun horario'+#13+
'ANGLE INCREMENT=Angulo Incremento'+#13+
'RADIUS INCREMENT=Incremento Radio'+#13+
'PRINTER=Impresora'+#13+
'SETUP=Opciones'+#13+
'ORIENTATION=Orientación'+#13+
'PORTRAIT=Vertical'+#13+
'LANDSCAPE=Horizontal'+#13+
'MARGINS (%)=Márgenes (%)'+#13+
'MARGINS=Márgenes'+#13+
'DETAIL=Detalle'+#13+
'MORE=Más'+#13+
'PROPORTIONAL=Proporcional'+#13+
'VIEW MARGINS=Ver Márgenes'+#13+
'RESET MARGINS=Márg. Defecto'+#13+
'PRINT=Imprimir'+#13+
'TEEPREVIEW EDITOR=Editor Impresión Preliminar'+#13+
'ALLOW MOVE=Permitir Mover'+#13+
'ALLOW RESIZE=Permitir Redimensionar'+#13+
'SHOW IMAGE=Ver Imagen'+#13+
'DRAG IMAGE=Arrastrar Imagen'+#13+
'AS BITMAP=Como mapa de bits'+#13+
'SIZE %=Tamaño %'+#13+
'FIELDS=Campos'+#13+
'SOURCE=Origen'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=Líneas de cabecera'+#13+
'COMMA=Coma'+#13+
'EDITING=Editando'+#13+
'TAB=Tabulación'+#13+
'SPACE=Espacio'+#13+
'ROUND RECTANGLE=Rectáng. Redondeado'+#13+
'BOTTOM=Abajo'+#13+
'RIGHT=Derecha'+#13+
'C PEN=Lápiz C'+#13+
'R PEN=Lápiz R'+#13+
'C LABELS=Textos C'+#13+
'R LABELS=Textos R'+#13+
'MULTIPLE BAR=Barras Múltiples'+#13+
'MULTIPLE AREAS=Areas Múltiples'+#13+
'STACK GROUP=Grupo de Apilado'+#13+
'BOTH=Ambos'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=Izquierda Derecha'+#13+
'RIGHT LEFT=Derecha Izquierda'+#13+
'FROM CENTER=Desde el centro'+#13+
'FROM TOP LEFT=Desde Izq. Arriba'+#13+
'FROM BOTTOM LEFT=Desde Izq. Abajo'+#13+
'SHOW WEEKDAYS=Ver Laborables'+#13+
'SHOW MONTHS=Ver Meses'+#13+
'SHOW PREVIOUS BUTTON=Ver Botón Anterior'#13+
'SHOW NEXT BUTTON=Ver Botón Siguiente'#13+
'TRAILING DAYS=Ver otros Días'+#13+
'SHOW TODAY=Ver Hoy'+#13+
'TRAILING=Otros Días'+#13+
'LOWERED=Hundido'+#13+
'RAISED=Elevado'+#13+
'HORIZ. OFFSET=Desplaz. Horiz.'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=Dentro'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=Sólo en etiquetas'+#13+
'MAXIMUM=Máximo'+#13+
'MINIMUM=Mínimo'+#13+
'CHANGE=Cambiar'+#13+
'LOGARITHMIC=Logarítmico'+#13+
'LOG BASE=Base Log.'+#13+
'DESIRED INCREMENT=Incremento'+#13+
'(INCREMENT)=(Incremento)'+#13+
'MULTI-LINE=Multi-Línea'+#13+
'MULTI LINE=Multilínea'+#13+
'RESIZE CHART=Redim. Gráfico'+#13+
'X AND PERCENT=X y Porcentaje'+#13+
'X AND VALUE=X y Valor'+#13+
'RIGHT PERCENT=Porcentaje derecha'+#13+
'LEFT PERCENT=Porcentaje izquierda'+#13+
'LEFT VALUE=Valor izquierda'+#13+
'RIGHT VALUE=Valor derecha'+#13+
'PLAIN=Texto'+#13+
'LAST VALUES=Ultimos Valores'+#13+
'SERIES VALUES=Valores de Series'+#13+
'SERIES NAMES=Nombres de Series'+#13+
'NEW=Nuevo'+#13+
'EDIT=Editar'+#13+
'PANEL COLOR=Color de fondo'+#13+
'TOP BOTTOM=Arriba Abajo'+#13+
'BOTTOM TOP=Abajo Arriba'+#13+
'DEFAULT ALIGNMENT=Alineación defecto'+#13+
'EXPONENTIAL=Exponencial'+#13+
'LABELS FORMAT=Formato Etiquetas'+#13+
'MIN. SEPARATION %=Min. Separación %'+#13+
'YEAR=Año'+#13+
'MONTH=Mes'+#13+
'WEEK=Semana'+#13+
'WEEKDAY=Dia Laborable'+#13+
'MARK=Marcas'+#13+
'ROUND FIRST=Redondear primera'+#13+
'LABEL ON AXIS=Etiqueta en eje'+#13+
'COUNT=Número'+#13+
'POSITION %=Posición %'+#13+
'START %=Empieza %'+#13+
'END %=Termina %'+#13+
'OTHER SIDE=Lado opuesto'+#13+
'INTER-CHAR SPACING=Espacio entre caracteres'+#13+
'VERT. SPACING=Espaciado Vertical'+#13+
'POSITION OFFSET %=Desplazamiento %'+#13+
'GENERAL=General'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Editor de OpenGL'+#13+
'FONT 3D DEPTH=Profund. Fuentes'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Editor de Fuente'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Reduce'+#13+
'VERTICAL SMALL=Vertical Pequeño'+#13+
'HORIZ. SMALL=Horizontal Pequeño'+#13+
'DIAG. SMALL=Diagonal Pequeño'+#13+
'BACK DIAG. SMALL=Diagonal Invert. Peq.'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=Mínimos pixels'+#13+
'ALLOW SCROLL=Permitir Desplaz.'+#13+
'SWAP=Cambiar'+#13+
'GRADIENT EDITOR=Editor de Gradiente'+#13+
'TEXT STYLE=Estilo de textos'+#13+
'DIVIDING LINES=Líneas de División'+#13+
'SYMBOLS=Símbolos'+#13+
'CHECK BOXES=Casillas'+#13+
'FONT SERIES COLOR=Color de Series'+#13+
'LEGEND STYLE=Estilo de Leyenda'+#13+
'POINTS PER PAGE=Puntos por página'+#13+
'SCALE LAST PAGE=Escalar última página'+#13+
'CURRENT PAGE LEGEND=Leyenda con página actual'+#13+
'BACKGROUND=Fondo'+#13+
'BACK IMAGE=Imagen fondo'+#13+
'STRETCH=Ajustar'+#13+
'TILE=Mosaico'+#13+
'BORDERS=Bordes'+#13+
'CALCULATE EVERY=Calcular cada'+#13+
'NUMBER OF POINTS=Número de puntos'+#13+
'RANGE OF VALUES=Rango de valores'+#13+
'FIRST=Primero'+#13+
'LAST=Ultimo'+#13+
'ALL POINTS=Todos los puntos'+#13+
'DATA SOURCE=Origen de Datos'+#13+
'WALLS=Pared'+#13+
'PAGING=Página'+#13+
'CLONE=Duplicar'+#13+
'TITLES=Título'+#13+
'TOOLS=Herramientas'+#13+
'EXPORT=Exportar'+#13+
'CHART=Gráfico'+#13+
'BACK=Fondo'+#13+
'LEFT AND RIGHT=Izq. y Derecha'+#13+
'SELECT A CHART STYLE=Seleccione tipo de Gráfico'+#13+
'SELECT A DATABASE TABLE=Seleccione una Tabla'+#13+
'TABLE=Tabla'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccione los campos a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Campo de etiquetas'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccione el tipo deseado'+#13+
'CHART PREVIEW=Visión Preliminar'+#13+
'SHOW LEGEND=Ver Leyenda'+#13+
'SHOW MARKS=Ver Marcas'+#13+
'FINISH=Terminar'+#13+
'RANDOM=Aleatorio'+#13+
'DRAW EVERY=Dibujar cada'+#13+
'ARROWS=Flechas'+#13+
'ASCENDING=Ascendiente'+#13+
'DESCENDING=Descendiente'+#13+
'VERTICAL AXIS=Eje Vertical'+#13+
'DATETIME=Fecha/Hora'+#13+
'TOP AND BOTTOM=Superior e Inferior'+#13+
'HORIZONTAL AXIS=Eje Horizontal'+#13+
'PERCENTS=Porcentajes'+#13+
'VALUES=Valores'+#13+
'FORMATS=Formatos'+#13+
'SHOW IN LEGEND=Ver en Leyenda'+#13+
'SORT=Orden'+#13+
'MARKS=Marcas'+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=Editor de Panel'+#13+
'CONTINUOUS=Continuos'+#13+
'HORIZ. ALIGNMENT=Alineación Horiz.'+#13+
'EXPORT CHART=Exportar Gráfico'+#13+
'BELOW %=Inferior a %'+#13+
'BELOW VALUE=Inferior a Valor'+#13+
'NEAREST POINT=Punto cercano'+#13+
'DRAG MARKS=Mover Marcas'+#13+
'TEECHART PRINT PREVIEW=Impresión Preliminar'+#13+
'X VALUE=Valor X'+#13+
'X AND Y VALUES=Valores X Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Todas las Series Visible'+#13+
'MARGIN=Margen'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Izquierda Arriba'+#13+
'LEFT BOTTOM=Izquierda Abajo'+#13+
'RIGHT TOP=Derecha Arriba'+#13+
'RIGHT BOTTOM=Derecha Abajo'+#13+
'EXACT DATE TIME=Fecha/Hora Exacta'+#13+
'RECT. GRADIENT=Gradiente'+#13+
'CROSS SMALL=Cruz pequeña'+#13+
'AVG=Media'+#13+
'FUNCTION=Función'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Un milisegundo'+#13+
'ONE SECOND=Un segundo'+#13+
'FIVE SECONDS=Cinco segundos'+#13+
'TEN SECONDS=Diez segundos'+#13+
'FIFTEEN SECONDS=Quince segundos'+#13+
'THIRTY SECONDS=Trenta segundos'+#13+
'ONE MINUTE=Un minuto'+#13+
'FIVE MINUTES=Cinco minutos'+#13+
'TEN MINUTES=Diez minutos'+#13+
'FIFTEEN MINUTES=Quince minutos'+#13+
'THIRTY MINUTES=Trenta minutos'+#13+
'TWO HOURS=Dos horas'+#13+
'TWO HOURS=Dos horas'+#13+
'SIX HOURS=Seis horas'+#13+
'TWELVE HOURS=Doce horas'+#13+
'ONE DAY=Un dia'+#13+
'TWO DAYS=Dos dias'+#13+
'THREE DAYS=Tres dias'+#13+
'ONE WEEK=Una semana'+#13+
'HALF MONTH=Medio mes'+#13+
'ONE MONTH=Un mes'+#13+
'TWO MONTHS=Dos meses'+#13+
'THREE MONTHS=Tres meses'+#13+
'FOUR MONTHS=Cuatro meses'+#13+
'SIX MONTHS=Seis meses'+#13+
'IRREGULAR=Irregular'+#13+
'CLICKABLE=Clicable'+#13+
'ROUND=Redondo'+#13+
'FLAT=Plano'+#13+
'PIE=Pastel'+#13+
'HORIZ. BAR=Barra Horiz.'+#13+
'BUBBLE=Burbuja'+#13+
'SHAPE=Forma'+#13+
'POINT=Puntos'+#13+
'FAST LINE=Línea Rápida'+#13+
'CANDLE=Vela'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=Línea Horiz.'+#13+
'SURFACE=Superfície'+#13+
'LEFT AXIS=Eje Izquierdo'+#13+
'RIGHT AXIS=Eje Derecho'+#13+
'TOP AXIS=Eje Superior'+#13+
'BOTTOM AXIS=Eje Inferior'+#13+
'CHANGE SERIES TITLE=Cambiar Título de Series'+#13+
'DELETE %S ?=Eliminar %s ?'+#13+
'DESIRED %S INCREMENT=Incremento %s deseado'+#13+
'INCORRECT VALUE. REASON: %S=Valor incorrecto. Razón: %s'+#13+
'FillSampleValues NumValues must be > 0=FillSampleValues. Número de valores debe ser > 0.'#13+
'VISIT OUR WEB SITE !=Visite nuestra Web !'#13+
'SHOW PAGE NUMBER=Ver Número de Página'#13+
'PAGE NUMBER=Número de Página'#13+
'PAGE %D OF %D=Pág. %d de %d'#13+
'TEECHART LANGUAGES=Lenguajes de TeeChart'#13+
'CHOOSE A LANGUAGE=Escoja un idioma'+#13+
'SELECT ALL=Seleccionar Todas'#13+
'MOVE UP=Mover Arriba'#13+
'MOVE DOWN=Mover Abajo'#13+
'DRAW ALL=Dibujar todo'#13+
'TEXT FILE=Archivo de Texto'#13+
'IMAG. SYMBOL=Símbolo Imag.'#13+
'DRAG REPAINT=Repinta todo'#13+
'NO LIMIT DRAG=Sin límites arrastre'
;
  end;
end;

Procedure TeeSetLatvian;
begin
  TeeCreateLatvian;
  TeeLanguage:=TeeLatvianLanguage;
  TeeLatvianConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeLatvianLanguage);
end.


