unit TeeHellenic;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHellenicLanguage:TStringList=nil;

Procedure TeeSetHellenic;
Procedure TeeCreateHellenic;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHellenicConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';

  TeeMsg_Test               :='Test...';
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
  TeeMsg_Period		          :='Period';
  TeeMsg_PeriodRange        :='Period range';
  TeeMsg_CalcPeriod         :='Calculate %s every:';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid Chart in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.'+TeeMsg_TeeExtension+' file format';
  TeeMsg_EmptyTeeFile       :='Empty *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Chart Axes';
  TeeMsg_ChartAxesCategoryDesc   :='Chart Axes properties and events';
  TeeMsg_ChartWallsCategoryName  :='Chart Walls';
  TeeMsg_ChartWallsCategoryDesc  :='Chart Walls properties and events';
  TeeMsg_ChartTitlesCategoryName :='Chart Titles';
  TeeMsg_ChartTitlesCategoryDesc :='Chart Titles properties and events';
  TeeMsg_Chart3DCategoryName     :='Chart 3D';
  TeeMsg_Chart3DCategoryDesc     :='Chart 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Custom';
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
  TeeMsg_ExportPanelNotSet :='Panel property is not set in Export format';

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

  { 5.03 }
  TeeMsg_Gradient     :='Gradient';
  TeeMsg_WantToSave   :='Do you want to save %s?';
  TeeMsg_NativeFilter :='TeeChart files '+TeeDefaultFilterExtension;

  TeeMsg_Property     :='Property';
  TeeMsg_Value        :='Value';
  TeeMsg_Yes          :='Yes';
  TeeMsg_No           :='No';
  TeeMsg_Image        :='(image)';

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

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Switch 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Active';
  TeeMsg_ActionSeriesActiveHint :='Show / Hide Series';
  TeeMsg_ActionEditHint         :='Edit Chart';
  TeeMsg_ActionEdit             :='&Edit...';
  TeeMsg_ActionCopyHint         :='Copy to Clipboard';
  TeeMsg_ActionCopy             :='&Copy';
  TeeMsg_ActionPrintHint        :='Print preview Chart';
  TeeMsg_ActionPrint            :='&Print...';
  TeeMsg_ActionAxesHint         :='Show / Hide Axes';
  TeeMsg_ActionAxes             :='&Axes';
  TeeMsg_ActionGridsHint        :='Show / Hide Grids';
  TeeMsg_ActionGrids            :='&Grids';
  TeeMsg_ActionLegendHint       :='Show / Hide Legend';
  TeeMsg_ActionLegend           :='&Legend';
  TeeMsg_ActionSeriesEditHint   :='Edit Series';
  TeeMsg_ActionSeriesMarksHint  :='Show / Hide Series Marks';
  TeeMsg_ActionSeriesMarks      :='&Marks';
  TeeMsg_ActionSaveHint         :='Save Chart';
  TeeMsg_ActionSave             :='&Save...';

  TeeMsg_CandleBar              :='Bar';
  TeeMsg_CandleNoOpen           :='No Open';
  TeeMsg_CandleNoClose          :='No Close';
  TeeMsg_NoHigh                 :='No High';
  TeeMsg_NoLow                  :='No Low';
  TeeMsg_ColorRange             :='Color Range';
  TeeMsg_WireFrame              :='Wireframe';
  TeeMsg_DotFrame               :='Dot Frame';
  TeeMsg_Positions              :='Positions';
  TeeMsg_NoGrid                 :='No Grid';
  TeeMsg_NoPoint                :='No Point';
  TeeMsg_NoLine                 :='No Line';
  TeeMsg_Labels                 :='Labels';
  TeeMsg_NoCircle               :='No Circle';
  TeeMsg_Lines                  :='Lines';
  TeeMsg_Border                 :='Border';

  TeeMsg_SmithResistance        :='Resistance';
  TeeMsg_SmithReactance         :='Reactance';

  TeeMsg_Column                 :='Column';

  { 5.01 }
  TeeMsg_Separator            :='Separator';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Funnel';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Exceeds quota';
  TeeMsg_FunnelWithin         :=' within quota';
  TeeMsg_FunnelBelow          :=' or more below quota';
  TeeMsg_CalendarSeries       :='Calendar';
  TeeMsg_DeltaPointSeries     :='DeltaPoint';
  TeeMsg_ImagePointSeries     :='ImagePoint';
  TeeMsg_ImageBarSeries       :='ImageBar';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               :='Origin';
  TeeMsg_Transparency         :='Transparency';
  TeeMsg_Box		              :='Box';
  TeeMsg_ExtrOut	            :='ExtrOut';
  TeeMsg_MildOut	            :='MildOut';
  TeeMsg_PageNumber	          :='Page Number';
  TeeMsg_TextFile             :='Text File';

  { 5.03 }
  TeeMsg_DragPoint            :='Drag Point';
  TeeMsg_OpportunityValues    :='OpportunityValues';
  TeeMsg_QuoteValues          :='QuoteValues';

  { 6.0 }
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='as &PDF';
  TeeMsg_PDFFilter        :='PDF files (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='as PostScript';
  TeeMsg_PSFilter         :='PostScript files (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horizontal'#13'Area';
  TeeMsg_SelfStack        :='Self Stacked';
  TeeMsg_DarkPen          :='Dark Border';
  TeeMsg_SelectFolder     :='Select database folder';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Connection:';

  { 6.0 }
  TeeMsg_FunctionSmooth       :='Smoothing';
  TeeMsg_FunctionCross        :='Cross Points';
  TeeMsg_GridTranspose        :='3D Grid Transpose';
  TeeMsg_FunctionCompress     :='Compression';
  TeeMsg_ExtraLegendTool      :='Extra Legend';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Series Animation';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Up';
  TeeMsg_Down                 :='Down';
  TeeMsg_GanttTool            :='Gantt Drag';
  TeeMsg_XMLFile              :='XML file';
  TeeMsg_GridBandTool         :='Grid Band';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='Gauge';
  TeeMsg_GalleryGauges        :='Gauges';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vector 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Tower';
  TeeMsg_SingleColor          :='Single Color';
  TeeMsg_Cover                :='Cover';
  TeeMsg_Cone                 :='Cone';
  TeeMsg_PieTool              :='Pie Slices';
end;

Procedure TeeCreateHellenic;
begin
  if not Assigned(TeeHellenicLanguage) then
  begin
    TeeHellenicLanguage:=TStringList.Create;
    TeeHellenicLanguage.Text:=

'GRADIENT EDITOR=Επεξεργασία Βαθμίδων Χρώματος'#13+
'GRADIENT=Διαβάθμιση Χρώματος'#13+
'DIRECTION=Κατεύθηνση'#13+
'VISIBLE=Ορατό'#13+
'TOP BOTTOM=Από πάνω προς τα κάτω'#13+
'BOTTOM TOP=Από κάτω προς τα επάνω'#13+
'LEFT RIGHT=Από αριστερά προς τα δεξιά'#13+
'RIGHT LEFT=Από δεξιά προς τα αριστερά'#13+
'FROM CENTER=Από το κέντρο'#13+
'FROM TOP LEFT=Από πάνω αριστερά'#13+
'FROM BOTTOM LEFT=Από κάτω αριστερά'#13+
'OK=Αποδοχή'#13+
'CANCEL=’κυρο'#13+
'COLORS=Χρώματα'#13+
'START=Έναρξη'#13+
'MIDDLE=Κέντρο'#13+
'END=Τέλος'#13+
'SWAP=Αντιμετάθεση'#13+
'NO MIDDLE=Χωρίς κέντρο'#13+
'TEEFONT EDITOR=Επεξεργαστής γραμματοσειρών'#13+
'INTER-CHAR SPACING=Μεσοδιάστημα χαρακτήρων'#13+
'FONT=Γραματοσειρά'#13+
'SHADOW=Σκιά'#13+
'HORIZ. SIZE=Οριζόντιο Μέγεθος'#13+
'VERT. SIZE=Κάθετο Μέγεθος'#13+
'COLOR=Χρώμα'#13+
'OUTLINE=Περίγραμμα'#13+
'OPTIONS=Επιλογές'#13+
'FORMAT=Διαμόρφοση'#13+
'TEXT=Δοκιμή'#13+
'POSITION=Θέση'#13+
'TOP=Πάνω'#13+
'AUTO=Αυτόματο'#13+
'CUSTOM=Ρύθμιση'#13+ //////////////////////
'LEFT TOP=Πάνω αριστερά'#13+
'LEFT BOTTOM=Κάτω αριστερά'#13+
'RIGHT TOP=Πάνω δεξιά'#13+
'RIGHT BOTTOM=Κάτω δεξιά'#13+
'MULTIPLE AREAS=Πολλαπλές περιοχές'#13+
'NONE=Κανένα'#13+
'STACKED=STACKED'#13+
'AREA=Περιοχή'#13+
'PATTERN=Μοτίβο'#13+
'STAIRS=Σκαλοπάτια'#13+
'SOLID=Στερεό'#13+
'CLEAR=Καθαρισμός'#13+
'HORIZONTAL=Οριζόντια'#13+
'VERTICAL=Κάθετα'#13+
'DIAGONAL=Διαγώνια'#13+
'B.DIAGONAL=B.Διαγώνια'#13+
'CROSS=Σταυρός'#13+
'DIAG.CROSS=Διαγώνιος Σταυρός'#13+
'AREA LINES=Γραμμές Περιοχής'#13+
'BORDER=Περίγραμμα'#13+
'INVERTED=Αντίστροφη'#13+
'INVERTED SCROLL=Αντίστροφη Κύλιση'#13+
'COLOR EACH=Αυτόματος Χρωματσμός'#13+
'ORIGIN=Προέλευση'#13+
'USE ORIGIN=Χρήση Προέλευσης'#13+
'WIDTH=Πλάτος'#13+
'HEIGHT=Ύψος'#13+
'AXIS=’ξονας'#13+
'LENGTH=Μήκος'#13+
'SCROLL=Κύλιση'#13+
'BOTH=Αμφότερα'#13+
'AXIS INCREMENT=Προσαύξηση ’ξονα'#13+
'INCREMENT=Προσαύξηση'#13+
'STANDARD=Τυπικός'#13+
'ONE MILLISECOND=Ένα χιλιοστό του Δευτ.'#13+
'ONE SECOND=Ένα δευτερόλεπτο'#13+
'FIVE SECONDS=Πέντε δευτερόλπτα'#13+
'TEN SECONDS=Δέκα δευτερόλπτα'#13+
'FIFTEEN SECONDS=Δεκαπέντε Δευτερόλπτα'#13+
'THIRTY SECONDS=Τριάντα Δευτερόλπτα'#13+
'ONE MINUTE=Ένα λεπτό'#13+
'FIVE MINUTES=Πέντε λεπτά'#13+
'TEN MINUTES=Δέκα λεπτά'#13+
'FIFTEEN MINUTES=Δεκαπέντε λεπτά'#13+
'THIRTY MINUTES=Τριάντα λεπτά'#13+
'ONE HOUR=Μια ώρα'#13+
'TWO HOURS=Δύο ώρες'#13+
'SIX HOURS=Έξη ώρες'#13+
'TWELVE HOURS=Δώδεκα ώρες'#13+
'ONE DAY=Μια ημέρα'#13+
'TWO DAYS=Δύο ημέρες'#13+
'THREE DAYS=Τρεις ημέρες'#13+
'ONE WEEK=Μια Εβδομάδα'#13+
'HALF MONTH=Μισός μήνας'#13+
'ONE MONTH=Ένας μήνας'#13+
'TWO MONTHS=Δύο μήνες'#13+
'THREE MONTHS=Τρεις μήνες'#13+
'FOUR MONTHS=Τέσσερις Μήνες'#13+
'SIX MONTHS=Έξη Μήνες'#13+
'ONE YEAR=Ένα Χρόνο'#13+
'EXACT DATE TIME=Ακριβής ημερομηνία και ώρα'#13+
'AXIS MAXIMUM AND MINIMUM=Ελάχιστο & μέγιστο άξωνα'#13+
'VALUE=Τιμή'#13+
'TIME=Ώρα'#13+
'LEFT AXIS=Αριστερός άξωνας'#13+
'RIGHT AXIS=Δεξιός ’ξωνας'#13+
'TOP AXIS=Επάνω άξωνας'#13+
'BOTTOM AXIS=Κάτω άξωνας'#13+
'% BAR WIDTH=Πλάτος % Ράβδου'#13+
'STYLE=Μορφή'#13+
'% BAR OFFSET=Μετατόπιση % Ράβδου'#13+
'RECTANGLE=Τετράγωνο'#13+
'PYRAMID=Πυραμίδα'#13+
'INVERT. PYRAMID=Ανάποδη πυραμίδα'#13+
'CYLINDER=Κύλινδρος'#13+
'ELLIPSE=Έλλειψη'#13+
'ARROW=Βέλος'#13+
'RECT. GRADIENT=Διαβαθμιζόμενο χρωματικά τετράγωνο'#13+
'CONE=Κόνος'#13+
'DARK BAR 3D SIDES=Σκιασμένες πλευρές 3Δ ράβδου'#13+
'BAR SIDE MARGINS=Περιθώρια πλευράς ράβδου'#13+
'AUTO MARK POSITION=Αυτόματη σήμανση θέσης'#13+ //////////////////
'JOIN=Ένωση'#13+
'DATASET=DataSet'#13+
'APPLY=Εφαρμογή'#13+
'SOURCE=Προέλευση'#13+
'MONOCHROME=Μονόχρωμο'#13+
'DEFAULT=Προεπιλογή'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Ενδιάμεσα'#13+
'PATTERN COLOR EDITOR=Επεξεργαστής χρώματος μοτίβου'#13+
'IMAGE=Εικόνα'#13+
'BACK DIAGONAL=Διαγώνια πίσω'#13+
'DIAGONAL CROSS=Σταυρωτά διαγώνια'#13+
'FILL 80%=Γέμισμα 80%'#13+
'FILL 60%=Γέμισμα 60%'#13+
'FILL 40%=Γέμισμα 40%'#13+
'FILL 20%=Γέμισμα 20%'#13+
'FILL 10%=Γέμισμα 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Κάθετα μικρό'#13+
'HORIZ. SMALL=Οριζ. Μικρό'#13+
'DIAG. SMALL=Διαγ. μικρό'#13+
'BACK DIAG. SMALL=Διαγ. Πίσω Μικρό'#13+
'CROSS SMALL=Απεν. Μικρό'#13+
'DIAG. CROSS SMALL=Διαγ. Σταυρ. Μικρό'#13+
'DAYS=Ημέρες'#13+
'WEEKDAYS=Ημέρες εβδομάδας'#13+
'TODAY=Σήμερα'#13+
'SUNDAY=Κυριακή'#13+
'TRAILING=Στο τέλος'#13+
'MONTHS=Μήνες'#13+
'LINES=Γραμμές'#13+
'SHOW WEEKDAYS=Εμφάνιση ημερών εβδομ.'#13+
'UPPERCASE=Κεφαλαία'#13+
'TRAILING DAYS=Ακόλουθες ημέρες'#13+ //////////////////////////////////
'SHOW TODAY=Εμφάνιση σημερινής ημέρας'#13+
'SHOW MONTHS=Εμφάνιση μηνών'#13+
'SHOW PREVIOUS BUTTON=Εμφάνιση κουμπιού Προηγ.'#13+
'SHOW NEXT BUTTON=Εμφάνιση κουμπιού Επόμ.'#13+
'CANDLE WIDTH=Μήκος Καιριού'#13+
'STICK=Ραβδί'#13+
'BAR=Ράβδος'#13+
'OPEN CLOSE=Εμφάνιση λεπτομεριών'#13+
'UP CLOSE=Περισσότερη λεπτομέρια'#13+
'DOWN CLOSE=Λιγότερη λεπτομέρια'#13+
'SHOW OPEN=Εμφάνιση Ανοιχτών'#13+
'SHOW CLOSE=Εμφάνιση Κλειστών'#13+
'DRAW 3D=Απεικόνιση 3Δ'#13+
'DARK 3D=Σκίαση 3Δ'#13+
'EDITING=Επεξεργασία'#13+
'CHART=Γράφημα'#13+
'SERIES=Σειρά'#13+
'DATA=Δεδομένα'#13+
'TOOLS=εργαλεία'#13+
'EXPORT=Εξαγωγή'#13+
'PRINT=Εκτύπωση'#13+
'GENERAL=Γενικός'#13+  ////////////////////
'TITLES=Τίτλοι'#13+
'LEGEND=Λεζάντα'#13+
'PANEL=Πλαίσιο'#13+
'PAGING=Σελιδοποίηση'#13+
'WALLS=Τοίχοι'#13+
'3D=3Δ'#13+
'ADD=Προσθήκη'#13+
'DELETE=Διαγραφή'#13+
'TITLE=Τίτλος'#13+
'CLONE=Αντίγραφο'#13+
'CHANGE=Αλλαγή'#13+
'HELP=Βοήθεια'#13+
'CLOSE=Κλείσιμο'#13+
'TEECHART PRINT PREVIEW=Προεπισκόπηση εκτύπωσης TeeChart'#13+
'PRINTER=Εκτυπωτής'#13+
'SETUP=Ρυθμίσεις'#13+
'ORIENTATION=Προσανατολισμός'#13+
'PORTRAIT=Οριζόντια'#13+
'LANDSCAPE=Κάθετη'#13+
'MARGINS (%)=Περιθώρια (%)'#13+
'DETAIL=Λεπτομέρια'#13+
'MORE=Περισσότερο'#13+
'NORMAL=Κανονικό'#13+
'RESET MARGINS=Επαναφορά Περιθορίων'#13+
'VIEW MARGINS=Εμφάνιση Περιθορίων'#13+
'PROPORTIONAL=Αναλογικά'#13+
'CIRCLE=Κύκλος'#13+
'VERTICAL LINE=Κάθετη γραμμή'#13+
'HORIZ. LINE=Οριζόντια γραμμή'#13+
'TRIANGLE=Τρίγωνο'#13+
'INVERT. TRIANGLE=Ανάποδο τρίγωνο'#13+
'LINE=Γραμμή'#13+
'DIAMOND=Διαμάντι'#13+
'CUBE=Κύβος'#13+
'STAR=Αστέρι'#13+
'TRANSPARENT=Διάφανο'#13+
'HORIZ. ALIGNMENT=Οριζόντια Ευθηγράμμηση'#13+ ///////////////////////////////////////////////////////
'LEFT=Αριστερά'#13+
'CENTER=Κέντρο'#13+
'RIGHT=Δεξιά'#13+
'ROUND RECTANGLE=Στρογγυλεμένο Τετράγωνο'#13+
'ALIGNMENT=Ευθηγράμμηση'#13+
'BOTTOM=Κάτω'#13+
'UNITS=Μονάδες'#13+
'PIXELS=Εικονοστοιχεία'#13+
'AXIS ORIGIN=Προέλευση ’ξονα'#13+//////////////////////////////////////////////////////////
'ROTATION=Περιστροφή'#13+
'CIRCLED=Κυκλικό'#13+
'3 DIMENSIONS=Τριών Διαστάσεων'#13+
'RADIUS=Ακτίνα'#13+
'ANGLE INCREMENT=Αύξηση Γωνίας'#13+
'RADIUS INCREMENT=Μύωση Γωνίας'#13+
'CLOSE CIRCLE=Ολοκλήρωση Κύκλου'#13+
'PEN=Στηλό'#13+
'LABELS=Εττικέτα'#13+
'ROTATED=Περιστραμένο'#13+
'CLOCKWISE=Δεξιόστροφα'#13+
'INSIDE=Εσωτερικά'#13+
'ROMAN=ROMAN'#13+
'HOURS=Ώρες'#13+
'MINUTES=Λεπτά'#13+
'SECONDS=Δευτερόλεπτα'#13+
'START VALUE=Τιμή Εκκίνησης'#13+
'END VALUE=Τιμή Τέλους'#13+
'TRANSPARENCY=Διάφανο'#13+
'DRAW BEHIND=Σχεδίαση από πίσω'#13+
'COLOR MODE=Στυλ Χρώματος'#13+
'STEPS=Διαβάθμηση'#13+
'RANGE=Βεληνεκές'#13+
'PALETTE=Παλλέτα'#13+
'PALE=Απαλό'#13+
'STRONG=Έντονο'#13+
'GRID SIZE=Μέγεθος Πλέγματος'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Βάθος'#13+
'IRREGULAR=Ακανόνιστο'#13+
'GRID=Πλέγμα'#13+
'ALLOW DRAG=Συρόμενο'#13+
'VERTICAL POSITION=Κάθετη Θέση'#13+
'LEVELS POSITION=Θέση Επιπέδων'#13+
'LEVELS=Επίπεδα'#13+
'NUMBER=Αριθμό'#13+
'LEVEL=Επίπεδο'#13+
'AUTOMATIC=Αυτόματο'#13+
'SNAP=SNAP'#13+
'FOLLOW MOUSE=Ακολούθησε το ποντίκι'#13+
'STACK=Στοίβα'#13+
'HEIGHT 3D=Ύψος 3Δ'#13+
'LINE MODE=Στυλ γραμμής'#13+
'OVERLAP=Επικάλυψη'#13+
'STACK 100%=Στοίβα 100%'#13+
'AVAILABLE=Διαθέσιμο'#13+
'SELECTED=Επιλεγμένο'#13+
'DATASOURCE=Πηγή Δεδομένων'#13+
'GROUP BY=Ομαδοποίηση με'#13+
'CALC=Υπολογισμός'#13+
'OF=Του'#13+
'SUM=’θροισμα'#13+
'COUNT=Καταμέτρηση'#13+
'HIGH=Υψηλό'#13+
'LOW=Χαμηλό'#13+
'AVG=Μέσος Όρος'#13+
'HOUR=Ώρα'#13+
'DAY=Ημέρα'#13+
'WEEK=Εβδομάδα'#13+
'WEEKDAY=Ημέρα Εβδομάδας'#13+
'MONTH=Μήνας'#13+
'QUARTER=Ένα Τέταρτο'#13+
'YEAR=Χρόνος'#13+
'HOLE %=Οπή %'#13+
'RESET POSITIONS=Επαναφορά Θέσεων'#13+
'MOUSE BUTTON=Κουμπί Ποντικού'#13+
'ENABLE DRAWING=Ενεργοποίηση Σχεδίασης'#13+
'ENABLE SELECT=Ενεργοποίηση Επιλογής'#13+
'ENHANCED=Εμπλουτισμένο'#13+
'ERROR WIDTH=Λάθος Μήκος'#13+
'WIDTH UNITS=Μονάδες Μήκους'#13+
'PERCENT=Ποσοστό %'#13+
'LEFT AND RIGHT=Αριστερά & Δεξιά'#13+
'TOP AND BOTTOM=Πάνω & Κάτω'#13+
'BORDER EDITOR=Επεξ. Περιγράματος'#13+
'DASH=Παύλα'#13+
'DOT=Τελεία'#13+
'DASH DOT=Παύλα Τελεία'#13+
'DASH DOT DOT=Παύλα Τελεία Τελεία'#13+
'CALCULATE EVERY=Υπολογισμός Καθενός'#13+
'ALL POINTS=Όλα τα Σημεία'#13+
'NUMBER OF POINTS=Αριθμός Σημείων'#13+
'RANGE OF VALUES=Βεληνεκές Τιμών'#13+
'FIRST=Πρώτο'#13+
'LAST=Τελευταίο'#13+
'TEEPREVIEW EDITOR=Επεξ. Προεπισκ. TEE'#13+
'ALLOW MOVE=Ελεύθερη Μετακίνηση'#13+
'ALLOW RESIZE=Ελεύθερη Αλλαγή Μεγεθους'#13+
'DRAG IMAGE=Μετακίνηση Εικόνας'#13+
'AS BITMAP=Ως Bitmap'#13+
'SHOW IMAGE=Εμφάνιση Εικόνας'#13+
'MARGINS=Περιθόρια'#13+
'SIZE=Μέγεθος'#13+
'3D %=3Δ %'#13+
'ZOOM=Εστίαση'#13+
'ELEVATION=Ανύψωση'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Οριζ. Μετατόπιση'#13+
'VERT. OFFSET=Καθ. Μετατόπιση'#13+
'PERSPECTIVE=Προοπτική'#13+
'ANGLE=Γωνεία'#13+
'ORTHOGONAL=Ορθογώνιο'#13+
'ZOOM TEXT=Εστίαση Κειμένου'#13+
'SCALES=Κλείμακες'#13+
'TICKS=Σημάδια'#13+
'MINOR=Ασήμαντο'#13+
'MAXIMUM=Μέγιστο'#13+
'MINIMUM=Ελάχιστο'#13+
'DESIRED INCREMENT=Επιθυμητή Αύξηση'#13+ // OR Αύξηση
'(INCREMENT)=(Αύξηση)'#13+
'LOG BASE=Βάση Λογαρ.'#13+
'LOGARITHMIC=Λογαριθμικό'#13+
'MIN. SEPARATION %=Ελάχιστος Διαχωρ. %'#13+
'MULTI-LINE=Πολλαπλών Γραμμών'#13+
'LABEL ON AXIS=Ετικέτα στον ’ξωνα'#13+
'ROUND FIRST=Στρογγυλοποίηση Πρώτα'#13+
'MARK=Χαρακτηρησμός'#13+
'LABELS FORMAT=Μορφή Ετικέτας'#13+
'EXPONENTIAL=Εκθετικός'#13+
'DEFAULT ALIGNMENT=Προκαθορισμένη Ευθυγράμμιση'#13+
'LEN=Μήκος'#13+
'INNER=Έσω'#13+
'AT LABELS ONLY=Μόνο στις Ετικέτες'#13+
'CENTERED=Στο Κέντρο'#13+
'POSITION %=Θέση %'#13+
'START %=Έναρξη %'#13+
'END %=Τέλος %'#13+
'OTHER SIDE=’λλη Πλευρά'#13+
'AXES=’ξωνες'#13+
'BEHIND=Από Πίσω'#13+
'CLIP POINTS=Αποκοπή Σημείων'#13+
'PRINT PREVIEW=Προεπισκόπηση εκτύπωσης'#13+
'MINIMUM PIXELS=Ελάχιστα εικονοστοιχεία'#13+
'ALLOW=Επέτρεψε'#13+
'ANIMATED=Κινούμενο'#13+
'ALLOW SCROLL=Κυλιόμενο'#13+
'TEEOPENGL EDITOR=Επεξεργαστής TeeOpenGL'#13+
'AMBIENT LIGHT=Περιβάλλον Φως'#13+
'SHININESS=Ακτινοβολία'#13+
'FONT 3D DEPTH=Βάθος Γραμ. 3D'#13+
'ACTIVE=Ενεργό'#13+
'FONT OUTLINES=Περίγραμμα Γραμ.'#13+
'SMOOTH SHADING=Ομαλή Σκίαση'#13+
'LIGHT=Φως'#13+
'Y=Y'#13+
'INTENSITY=Ένταση'#13+
'BEVEL=Σκαλιστό'#13+
'FRAME=Πλαίσιο'#13+
'ROUND FRAME=Στρογγυλεμένο Πλαίσιο'#13+
'LOWERED=Χαμηλομένο'#13+
'RAISED=Σηκωμένο'#13+
'SYMBOLS=Σύμβολο'#13+
'TEXT STYLE=Μορφή Κειμένου'#13+
'LEGEND STYLE=Μορφή Λεζάντας.'#13+
'VERT. SPACING=Κάθετο Διάκενο'#13+
'SERIES NAMES=Όνομα Σειράς'#13+
'SERIES VALUES=Τιμές Σειράς'#13+
'LAST VALUES=Τελευταία Τιμή'#13+
'PLAIN=Απλό'#13+
'LEFT VALUE=Αριστερή Τιμή'#13+
'RIGHT VALUE=Δεξιά Τιμή'#13+
'LEFT PERCENT=Αριστερό Ποσοστό'#13+
'RIGHT PERCENT=Δεξί Ποσοστό'#13+
'X VALUE=Τιμή X'#13+
'X AND VALUE=X & Τιμή'#13+
'X AND PERCENT=X & Ποσοστό'#13+
'DIVIDING LINES=Διαίρεση Γραμμών'#13+
'FONT SERIES COLOR=Χρώμα Γραμ. Σειράς'#13+
'POSITION OFFSET %=Μετατόπιση Θέσης %'#13+
'MARGIN=Περιθόριο'#13+
'RESIZE CHART=Αλλαγή Μεγ. Γραφημ.'#13+
'CONTINUOUS=Συνεχής'#13+
'POINTS PER PAGE=Σημεία ανα Σελίδα'#13+
'SCALE LAST PAGE=Κλιμάκωση Τελευτ. Σελίδας'#13+
'CURRENT PAGE LEGEND=Λεζάντα Τρεχ. Σελ.'#13+
'PANEL EDITOR=Επεξεργαστής Ταμπλό'#13+
'BACKGROUND=Υπόβαθρο'#13+
'BORDERS=’κρα'#13+
'BACK IMAGE=Εικόνα Υπόβαθρου'#13+
'STRETCH=Επέκταση'#13+
'TILE=Πλακάκι'#13+
'BEVEL INNER=Εσωτ. Σκαλιστό'#13+
'BEVEL OUTER=Εξωτ. Σκαλιστό'#13+
'MARKS=Σημάδια'#13+
'DATA SOURCE=Πηγή Δεδομένων'#13+
'SORT=Ταξυνόμηση'#13+
'CURSOR=Δρομέας'#13+
'SHOW IN LEGEND=Εμφάνιση Στην Λεζάντα'#13+
'FORMATS=Μορφές'#13+
'VALUES=Τιμές'#13+
'PERCENTS=Ποσοστά'#13+
'HORIZONTAL AXIS=Οριζόντιος ’ξονας'#13+
'DATETIME=Ημε/νία & ώρα'#13+
'VERTICAL AXIS=Κάθετος ’ξονας'#13+
'ASCENDING=Αύξουσα'#13+
'DESCENDING=Φθίνουσα'#13+
'DRAW EVERY=Σχεδίασε Κάθε'#13+
'CLIPPED=Ψαλιδισμένο'#13+
'ARROWS=Βέλη'#13+
'MULTI LINE=Πολλαπλές Γραμμές'#13+
'ALL SERIES VISIBLE=Ορατές όλες οι Σειρές'#13+
'LABEL=Εττικέτα'#13+
'LABEL AND PERCENT=Ετικέτα & ποσοστό'#13+
'LABEL AND VALUE=Ετικέτα & Τιμή'#13+
'PERCENT TOTAL=Πλήρης Ποσοστό'#13+
'LABEL AND PERCENT TOTAL=Ολικά Ετικέτας και Ποσοστού'#13+
'X AND Y VALUES=Τιμή X & Y'#13+
'MANUAL=Χειροκίνητα'#13+
'RANDOM=Τυχαία'#13+
'FUNCTION=Συνάρτηση'#13+
'NEW=Νέο'#13+
'EDIT=Επεξεργασία'#13+
'PERSISTENT=Συνεχής'#13+
'ADJUST FRAME=Προσαρμογή Πλαισίου'#13+
'SUBTITLE=Υπότιτλος'#13+
'SUBFOOT=SUBFOOT'#13+
'FOOT=FOOT'#13+
'VISIBLE WALLS=Ορατά Τοίχοι'#13+
'BACK=Πίσω'#13+
'DIF. LIMIT=Όριο Διαφ.'#13+
'ABOVE=Πάνω από'#13+
'WITHIN=Μέσα σε'#13+
'BELOW=Κάτω από'#13+
'CONNECTING LINES=Ενωμένες γραμμές'#13+
'BROWSE=Αναζήτηση'#13+
'TILED=Κεραμυδοτά'#13+
'INFLATE MARGINS=Διόγκωση Περιθωρίων'#13+
'ROUND=Στρογγυλοποίηση'#13+
'SQUARE=Τετράφωνο'#13+
'FLAT=Επίπεδο'+#13+
'DOWN TRIANGLE=Ανάποδο Τρίγωνο'#13+
'SMALL DOT=Μικρή Τελεία'#13+
'GLOBAL=Γενικά'#13+
'SHAPES=Σχήματα'#13+
'BRUSH=Βούρτσα'#13+
'MOVE=Μετακίνηση'#13+
'DRAW LINE=Σχεδίαση Γραμμής'#13+
'BELOW %=Κάτω Από %'#13+
'BELOW VALUE=Χαμηλότερα Τιμής'#13+
'OTHER=’λλο'#13+
'PATTERNS=Μοτίβα'#13+
'SIZE %=Μέγεθος %'#13+
'FIELDS=Πεδία'#13+
'NUMBER OF HEADER LINES=Αριθμός Γραμμών Επικεφ.'#13+
'SEPARATOR=Διαχωριστικό'#13+
'COMMA=Κόμμα'#13+
'SPACE=Κενό'#13+
'FILE=Αρχείο'#13+
'WEB URL=Διεύθυνση Διαδικτύου(URL)'#13+
'LOAD=’νοιγμα'#13+
'C LABELS=Ετικέτες C'#13+
'R LABELS=Ετικέτες R'#13+
'C PEN=Στυλό C'#13+
'R PEN=Στυλό R'#13+
'STACK GROUP=Ομάδα Στοίβας'#13+
'MULTIPLE BAR=Πολλαπλές ράβδοι'#13+
'SIDE=Πλευρά'#13+
'STACKED 100%=Στοιβαγμένα 100%'#13+
'SIDE ALL=Πλάγια όλα'#13+
'DRAWING MODE=Στυλ Σχεδίασης'#13+
'WIREFRAME=Πλέγμα Γραμμών'#13+
'DOTFRAME=Πλέγμα Κουκίδων'#13+
'SMOOTH PALETTE=Ομαλή Παλέτα'#13+
'SIDE BRUSH=Πλάγια Βούρτσα'#13+
'ABOUT TEECHART PRO V7.0=Πληροφορίες για TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Επισκεφτείτε την ιστοσελίδα μας!'#13+
'SELECT A CHART STYLE=Επιλογή Μορφής Γραφήματος'#13+
'DATABASE CHART=Γράφημα με Βάση δεδομένων'#13+
'NON DATABASE CHART=Γράφημα Χωρίς Βάση Δεδομένων'#13+
'SELECT A DATABASE TABLE=Επιλογή Πίνακα Βάσης.'#13+
'ALIAS=Ψευδόνυμο'#13+
'TABLE=Πίνακας'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Επιλέξτε τα Επιθυμητά Πεδία'#13+
'SELECT A TEXT LABELS FIELD=Επιλέξτε Πεδίο για την Ετικέτα'#13+
'CHOOSE THE DESIRED CHART TYPE=Επιλέξτε τον Επιθυμητό Τύπο Γραφήματος'#13+
'2D=2Δ'#13+
'CHART PREVIEW=Προεπισκόπηση Γραφήματος'#13+
'SHOW LEGEND=Εμφανίσει Λεζάντας'#13+
'SHOW MARKS=Εμφάνιση Σημείων'#13+
'< BACK=< Προηγούμενο'#13+
'PICTURE=Εικόνα'#13+
'NATIVE=Αρχείο Tee'#13+
'KEEP ASPECT RATIO=Διατήρηση Προοπτικής'#13+
'INCLUDE SERIES DATA=Ενσωμάτωση Δεδομένων Σειρών'#13+
'FILE SIZE=Μέγεθος Αρχείου'#13+
'DELIMITER=Διαχωριστηκό'#13+
'XML=XML'#13+
'HTML TABLE=Πίνακας HTML'#13+
'EXCEL=Excel'#13+
'COLON=’νω Κάτω Τελεία'#13+
'INCLUDE=Ενσωμάτωση'#13+
'POINT LABELS=Ετικέτες Σημείων'#13+
'POINT INDEX=Δείκτες Σημείων'#13+
'HEADER=Επικεφαλίδα'#13+
'COPY=Αντιγραφή'#13+
'SAVE=Αποθήκευση'#13+
'SEND=Αποστολή'#13+
'FUNCTIONS=Συναρτήσεις'#13+
'ADX=ADX'#13+
'AVERAGE=Μέσος όρος'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Διαίρεση'#13+
'EXP. AVERAGE=Μέσο Όρο Exp.'#13+
'EXP.MOV.AVRG.=Κινητό Μέσο Όρο Exp.'#13+
'MACD=MACD'#13+
'R.S.I.=R.S.I.'#13+
'SOURCE SERIES=Σειρά Πηγή'#13+
'COMPRESSION=Συμπίεση'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Γκρι'#13+
'GRAY SCALE=Αποχρώσεις του Γκρι'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'PERFORMANCE=Απόδοση'#13+
'QUALITY=Ποιότητα'#13+
'SPEED=Ταχύτητα'#13+
'COMPRESSION LEVEL=Επίπεδο Συμπίεσης'#13+
'AXIS ARROWS=Βέλη Αξόνων'#13+
'ROTATE=Περιστροφή'#13+
'YES=Ναι'#13+
'SHOW PAGE NUMBER=Εμφάνιση Αριθμού Σελίδας'#13+
'PAGE NUMBER=Αριθμός Σελίδας'#13+
'PAGE %D OF %D=Σελίδα %d Από %d'#13+
'TEECHART LANGUAGES=Γλώσσες του TeeChart'#13+
'CHOOSE A LANGUAGE=Επιλογή Γλώσσας'+#13+
'SELECT ALL=Επιλογή Όλων'#13+
'DRAW ALL=Σχεδίαση Όλων'#13+
'TEXT FILE=Αρχείο Κειμένου'#13+
'IMAG. SYMBOL=Σύμβολο Εικον.'#13+
'MSEC.=msec.'#13+

// Pending:

'CHECK BOXES=Check boxes'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'CLICKABLE=Clickable'#13+
'WHISKER=Whisker'#13+
'DELAY=Delay'#13+
'MOUSE ACTION=Mouse Action'#13+
'EXPLODE BIGGEST=Explode Biggest'#13+
'TOTAL ANGLE=Total Angle'#13+
'GROUP SLICES=Group Slices'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Text Editor'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'CLICK=Click'#13+
'EXPORT CHART=Export Chart'#13+
'TAB=Tab'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div.'#13+
'MOVING AVRG.=Moving Avrg.'#13+
'MULTIPLY=Multiply'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=Std. Deviation'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Subtract'#13+
'TEECHART GALLERY=TeeChart Gallery'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduction'#13+
'NEAREST=Nearest'#13+
'% QUALITY=% Quality'#13+
'PERIOD=Period'#13+
'UP=Up'#13+
'DOWN=Down'#13+
'COLOR BAND=Color Band'#13+
'COLOR LINE=Color Line'#13+
'DRAG MARKS=Drag Marks'#13+
'MARK TIPS=Mark Tips'#13+
'NEAREST POINT=Nearest Point'#13+
'CHART TOOLS GALLERY=Chart Tools Gallery'#13+
'ANNOTATION=Annotation'#13+
'DRAG REPAINT=Drag repaint'#13+
'NO LIMIT DRAG=No limit drag'#13+
'PREVIEW=Preview'#13+
'SHADOW EDITOR=Shadow editor'#13+
'CALLOUT=Callout'#13+
'TEXT ALIGNMENT=Text alignment'#13+
'DISTANCE=Distance'#13+
'ARROW HEAD=Arrow head'#13+
'POINTER=Pointer'#13+
'AVAILABLE LANGUAGES=Available languages'#13+
'CALCULATE USING=Calculate using'#13+
'EVERY NUMBER OF POINTS=Every number of points'#13+
'EVERY RANGE=Every range'#13+
'INCLUDE NULL VALUES=Include null values'#13+
'DATE=Date'#13+
'ENTER DATE=Enter Date'#13+
'ENTER TIME=Enter Time'#13+
'BEVEL SIZE=Bevel size'#13+
'DEVIATION=Deviation'#13+
'UPPER=Upper'#13+
'LOWER=Lower'#13+
'NOTHING=Nothing'#13+
'LEFT TRIANGLE=Left triangle'#13+
'RIGHT TRIANGLE=Right triangle'#13+
'CONSTANT=Constant'#13+
'SHOW LABELS=Show labels'#13+
'SHOW COLORS=Show colors'#13+
'XYZ SERIES=XYZ series'#13+
'SHOW X VALUES=Show X values'#13+
'DELETE ROW=Delete row'#13+
'VOLUME SERIES=Volume series'#13+
'ACCUMULATE=Accumulate'#13+
'SINGLE=Single'#13+
'REMOVE CUSTOM COLORS=Remove custom colors'#13+
'STEP=Step'#13+
'USE PALETTE MINIMUM=Use palette minimum'#13+
'AXIS MAXIMUM=Axis maximum'#13+
'AXIS CENTER=Axis center'#13+
'AXIS MINIMUM=Axis minimum'#13+
'DAILY (NONE)=Daily (none)'#13+
'WEEKLY=Weekly'#13+
'MONTHLY=Monthly'#13+
'BI-MONTHLY=Bi-Monthly'#13+
'QUARTERLY=Quarterly'#13+
'YEARLY=Yearly'#13+
'DATETIME PERIOD=Datetime period'#13+
'ARROW FROM=Arrow from'#13+
'ARROW TO=Arrow to'#13+
'POINTS=Points'#13+
'SIDES=Sides'#13+
'INVERTED SIDES=Inverted sides'#13+
'CURVE=Curve'#13+
'POINT=Point'#13+
'COLOR EACH LINE=Color each line'#13+
'CASE SENSITIVE=Case sensitive'#13+
'SORT BY=Sort by'#13+
'CALCULATION=Calculation'#13+
'DRAG STYLE=Drag style'#13+
'WEIGHT=Weight'#13+
'EDIT LEGEND=Edit legend'#13+
'IGNORE NULLS=Ignore nulls'#13+
'OFFSET=Offset'#13+
'LIGHT 0=Light 0'#13+
'LIGHT 1=Light 1'#13+
'LIGHT 2=Light 2'#13+
'DRAW STYLE=Draw style'#13+
'DEFAULT BORDER=Default border'#13+
'SQUARED=Squared'#13+
'SEPARATION=Separation'#13+
'ROUND BORDER=Round border'#13+
'NUMBER OF SAMPLE VALUES=Number of sample values'#13+
'SPACING=Spacing'#13+
'TRANSP=Transp'#13+
'HORIZ.=Horiz.'#13+
'VERT.=Vert.'#13+
'RESIZE PIXELS TOLERANCE=Resize pixels tolerance'#13+
'FULL REPAINT=Full repaint'#13+
'END POINT=End point'#13+
'BAND 1=Band 1'#13+
'BAND 2=Band 2'#13+
'GRID 3D SERIES=Grid 3D Series'#13+
'TRANSPOSE NOW=Transpose now'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Exp. Line'#13+
'DRAG TO RESIZE=Drag to resize'#13+
'MOVE UP=Move Up'#13+
'MOVE DOWN=Move Down'#13+
'SERIES MARKS=Series Marks'#13+
'WALL=Wall'#13+
'TEXT LABELS=Text Labels'#13+
'SMOOTH=Smooth'#13+
'INTERPOLATE=Interpolate'#13+
'START X=Start X'#13+
'NUM. POINTS=Num. Points'#13+
'(NONE)=(none)'#13+
'WEIGHTED=Weighted'#13+
'WEIGHTED BY INDEX=Weighted by index'#13+
'DARK BORDER=Dark border'#13+
'PIE SERIES=Pie series'#13+
'FOCUS=Focus'#13+
'BOX SIZE=Box size'#13+
'REVERSAL AMOUNT=Reversal amount'#13+
'PERCENTAGE=Percentage'#13+
'COMPLETE R.M.S.=Complete R.M.S.'#13+
'BUTTON=Button'#13+
'START AT MIN. VALUE=Start at min. value'#13+
'EXECUTE !=Execute !'#13+
'FACTOR=Factor'#13+
'SELF STACK=Self stack'#13+
'SIDE LINES=Side lines'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Chart from template (*.tee file)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Open TeeChart template file from'#13+
'COVER=Cover'#13+
'ARROW WIDTH=Arrow Width'#13+
'ARROW HEIGHT=Arrow Height'#13+
'DEFAULT COLOR=Default color'#13+
'VALUE SOURCE=Value source'#13+
'BALANCE=Balance'#13+
'RADIAL OFFSET=Radial Offset'#13+
'RADIAL=Radial'#13+
'EXPORT DIALOG=Export dialog'#13+
'BINARY=Binary'#13+
'POINT COLORS=Point colors'#13+
'OUTLINE GRADIENT=Outline gradient'

;
  end;
end;

Procedure TeeSetHellenic;
begin
  TeeCreateHellenic;
  TeeLanguage:=TeeHellenicLanguage;
  TeeHellenicConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;


initialization
finalization
  FreeAndNil(TeeHellenicLanguage);
end.
