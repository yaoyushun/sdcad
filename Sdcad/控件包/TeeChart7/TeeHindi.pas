// TeeChart Pro Hindi translated by Nirali Shah
unit TeeHindi;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHindiLanguage:TStringList=nil;

Procedure TeeSetHindi;
Procedure TeeCreateHindi;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHindiConstants;
begin
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
  TeeMsg_Default            :='Default: ';
  TeeMsg_ValuesFormat       :='Values For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Desired %s Increment';

  TeeMsg_IncorrectMaxMinValue:='Incorrect value. Reason: %s';
  TeeMsg_EnterDateTime      :='Enter [Number of Days] [hh:mm:ss]';

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
  TeeMsg_DefaultFontName    :={$IFDEF CLX}'Helvetica'{$ELSE}'Arial'{$ENDIF};

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

  TeeMsg_InvalidTeeFile     :='Invalid Chart in *.tee file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.tee file format';
  TeeMsg_EmptyTeeFile       :='Empty *.tee file';  { 5.01 }

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


end;

Procedure TeeCreateHindi;
begin
  if not Assigned(TeeHindiLanguage) then
  begin
    TeeHindiLanguage:=TStringList.Create;
    TeeHindiLanguage.Text:=

'GRADIENT EDITOR=Gradient Sampadak'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Disha'#13+
'VISIBLE=Pratyaksh'#13+
'TOP BOTTOM=Sira Tal'#13+
'BOTTOM TOP=Tal Sira'#13+
'LEFT RIGHT=Baiya Daiya'#13+
'RIGHT LEFT=Daiya Baiya'#13+
'FROM CENTER=Madhya Se'#13+
'FROM TOP LEFT=Sira Baiya Se'#13+
'FROM BOTTOM LEFT=Tal Baiya Se'#13+
'OK=OK'#13+
'CANCEL=Radd Karo'#13+
'COLORS=Rango'#13+
'START=Shuruat'#13+
'MIDDLE=Madhya'#13+
'END=Aant'#13+
'SWAP=Swap'#13+
'NO MIDDLE=Madhya Nahin He'#13+
'TEEFONT EDITOR=TEEFONT Sampadak'#13+
'INTER-CHAR SPACING=Inter-Char Antralan'#13+
'FONT=Font'#13+
'SHADOW=Parchhaiyi'#13+
'HORIZ. SIZE=Sapaat Parimaan'#13+
'VERT. SIZE=Lamb Parimaan'#13+
'COLOR=Rang'#13+
'OUTLINE=Bahirekha'#13+
'OPTIONS=Vikalpo'#13+
'FORMAT=Format'#13+
'TEXT=Vaakya'#13+
'GRADIENT=Gradient'#13+
'POSITION=Sthaan'#13+
'LEFT=Baiya'#13+
'TOP=Sira'#13+
'AUTO=Swataha'#13+
'CUSTOM=Custom'#13+
'LEFT TOP=Baiya Sira'#13+
'LEFT BOTTOM=Baiya Tal'#13+
'RIGHT TOP=Daiya Sira'#13+
'RIGHT BOTTOM=Daiya Tal'#13+
'MULTIPLE AREAS=Bahul Ilaake'#13+
'NONE=Kuch Nahi'#13+
'STACKED=Stacked'#13+
'STACKED 100%=Stacked 100%'#13+
'AREA=Ilaaka'#13+
'PATTERN=Pattern'#13+
'STAIRS=Sidhi'#13+
'SOLID=Ghan'#13+
'CLEAR=Saaf'#13+
'HORIZONTAL=Sapaat'#13+
'VERTICAL=Lamb'#13+
'DIAGONAL=Vikarna'#13+
'B.DIAGONAL=Pichhla Vikarna'#13+
'CROSS=Cross'#13+
'DIAG.CROSS=Vikarna Cross'#13+
'AREA LINES=Ilaaka Lakire'#13+
'BORDER=Seema'#13+
'INVERTED=Ulta'#13+
'INVERTED SCROLL=Ulta Scroll'#13+
'COLOR EACH=Pratyek ko alag rang karo'#13+
'ORIGIN=Mool'#13+
'USE ORIGIN=Mool Istemaal Karo'#13+
'WIDTH=Chaudaayi'#13+
'HEIGHT=Uunchayi'#13+
'AXIS=Aksh'#13+
'LENGTH=Lambayi'#13+
'SCROLL=Scroll'#13+
'PATTERN=Pattern'#13+
'START=Shuruat'#13+
'END=Aant'#13+
'BOTH=Dono'#13+
'AXIS INCREMENT=Aksh Sanvrudhhi'#13+
'INCREMENT=Sanvrudhhi'#13+
'STANDARD=Standard'#13+
'CUSTOM=Custom'#13+
'ONE MILLISECOND=Ek Millisecond'#13+
'ONE SECOND=Ek Second'#13+
'FIVE SECONDS=Paanch Seconde'#13+
'TEN SECONDS=Das Seconde'#13+
'FIFTEEN SECONDS=Pandraaha Seconde'#13+
'THIRTY SECONDS=Tees Seconde'#13+
'ONE MINUTE=Ek Minut'#13+
'FIVE MINUTES=Paanch Minute'#13+
'TEN MINUTES=Das Minute'#13+
'FIFTEEN MINUTES=Pandraaha Minute'#13+
'THIRTY MINUTES=Tees Minute'#13+
'ONE HOUR=Ek Ghanta'#13+
'TWO HOURS=Do Ghante'#13+
'SIX HOURS=Chhe Ghante'#13+
'TWELVE HOURS=Baarah Ghante'#13+
'ONE DAY=Ek Din'#13+
'TWO DAYS=Do Din'#13+
'THREE DAYS=Teen Din'#13+
'ONE WEEK=Ek Hafta'#13+
'HALF MONTH=Aadha Mahina'#13+
'ONE MONTH=Ek Mahina'#13+
'TWO MONTHS=Do Mahine'#13+
'THREE MONTHS=Teen Mahine'#13+
'FOUR MONTHS=Chaar Mahine'#13+
'SIX MONTHS=Chhe Mahine'#13+
'ONE YEAR=Ek Saal'#13+
'EXACT DATE TIME=Sahi Tarikh Aur Samay'#13+
'AXIS MAXIMUM AND MINIMUM=Aksh Adhiktam Aur Nyuntam'#13+
'VALUE=Mulya'#13+
'TIME=Samay'#13+
'LEFT AXIS=Baiya Aksh'#13+
'RIGHT AXIS=Daiya Aksh'#13+
'TOP AXIS=Sira Aksh'#13+
'BOTTOM AXIS=Tal Aksh'#13+
'% BAR WIDTH=% Dand Chaudaayi'#13+
'STYLE=Shaili'#13+
'% BAR OFFSET=% Dand Antarlamb'#13+
'RECTANGLE=Aayat'#13+
'PYRAMID=Pyramid'#13+
'INVERT. PYRAMID=Ulta Pyramid'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Dirghavrut'#13+
'ARROW=Teer'#13+
'RECT. GRADIENT=Aayatakar Gradient'#13+
'CONE=Shanku'#13+
'DARK BAR 3D SIDES=Gahra Dand 3D Phalako'#13+
'BAR SIDE MARGINS=Dand Phalak Hashiyo'#13+
'AUTO MARK POSITION=Swataha Sthaan Ko Ankit Karo'#13+
'BORDER=Seema'#13+
'JOIN=Jodo'#13+
'BAR SIDE MARGINS=Dand Phalak Hashiyo'#13+
'DATASET=Dataset'#13+
'APPLY=Lagu Karo'#13+
'SOURCE=Stroat'#13+
'MONOCHROME=Ek ranga'#13+
'DEFAULT=Default'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'LENGTH=Lambayi'#13+
'MEDIAN=Median'#13+
'WHISKER=Whisker'#13+
'PATTERN COLOR EDITOR=Pattern Rang Sampadak'#13+
'IMAGE=Chitra'#13+
'NONE=Kuch Nahi'#13+
'BACK DIAGONAL=Pichhla Vikarna'#13+
'CROSS=Cross'#13+
'DIAGONAL CROSS=Vikarna Cross'#13+
'FILL 80%=Bharo 80%'#13+
'FILL 60%=Bharo 60%'#13+
'FILL 40%=Bharo 40%'#13+
'FILL 20%=Bharo 20%'#13+
'FILL 10%=Bharo 10%'#13+
'ZIG ZAG=Zig Zag'#13+
'VERTICAL SMALL=Lamb Chhota'#13+
'HORIZ. SMALL=Sapaat Chhota'#13+
'DIAG. SMALL=Vikarna Chhota'#13+
'BACK DIAG. SMALL=Pichhla Vikarna Chhota'#13+
'CROSS SMALL=Cross Chhota'#13+
'DIAG. CROSS SMALL=Vikarna Cross Chhota'#13+
'PATTERN COLOR EDITOR=Pattern Rang Sampadak'#13+
'OPTIONS=Vikalpo'#13+
'DAYS=Dino'#13+
'WEEKDAYS=Kaam Ke Din'#13+
'TODAY=Aaj'#13+
'SUNDAY=Itwaar'#13+
'TRAILING=Trailing'#13+
'MONTHS=Mahine'#13+
'LINES=Lakire'#13+
'SHOW WEEKDAYS=Kaam Ke Din Dikhao'#13+
'UPPERCASE=Uppercase'#13+
'TRAILING DAYS=Trailing Dino'#13+
'SHOW TODAY=Aaj Dikhao'#13+
'SHOW MONTHS=Mahine Dikhao'#13+
'CANDLE WIDTH=Mombatti ki Chaudaayi'#13+
'STICK=Lakdi'#13+
'BAR=Dand'#13+
'OPEN CLOSE=Open Close'#13+
'UP CLOSE=Up Close'#13+
'DOWN CLOSE=Down Close'#13+
'SHOW OPEN=Open Dikhao'#13+
'SHOW CLOSE=Close Dikhao'#13+
'DRAW 3D=3D Ankit Karo'#13+
'DARK 3D=Gahra 3D'#13+
'EDITING=Sampadan'#13+
'CHART=Chart'#13+
'SERIES=Shreni'#13+
'DATA=Data'#13+
'TOOLS=Upkaran'#13+
'EXPORT=Niryaat'#13+
'PRINT=Chhapo'#13+
'GENERAL=Sadharan'#13+
'TITLES=Shirshake'#13+
'LEGEND=Legend'#13+
'PANEL=Panel'#13+
'PAGING=Paging'#13+
'WALLS=Diware'#13+
'3D=3D'#13+
'ADD=Add'#13+
'DELETE=Mita do'#13+
'TITLE=Shirshak'#13+
'CLONE=Kruntak'#13+
'CHANGE=Badalo'#13+
'HELP=Madad'#13+
'CLOSE=Close'#13+
'IMAGE=Chitra'#13+
'TEECHART PRINT PREVIEW=TeeChart Chhap Purvadarshan'#13+
'PRINTER=Mudrak'#13+
'SETUP=Setup'#13+
'ORIENTATION=Orientation'#13+
'PORTRAIT=Portrait'#13+
'LANDSCAPE=Landscape'#13+
'MARGINS (%)=Hashiyo (%)'#13+
'DETAIL=Detail'#13+
'MORE=Jyaada'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Reset Hashiyo'#13+
'VIEW MARGINS=Hashiyo Ko Dekho'#13+
'PROPORTIONAL=Samanupaati'#13+
'TEECHART PRINT PREVIEW=TeeChart Chhap Purvadarshan'#13+
'RECTANGLE=Aayat'#13+
'CIRCLE=Vrut'#13+
'VERTICAL LINE=Lamb Lakir'#13+
'HORIZ. LINE=Sapaat Lakir'#13+
'TRIANGLE=Trikon'#13+
'INVERT. TRIANGLE=Ulta Trikon'#13+
'LINE=Lakir'#13+
'DIAMOND=Hira'#13+
'CUBE=Cube'#13+
'DIAGONAL CROSS=Vikarna Cross'#13+
'STAR=Taara'#13+
'TRANSPARENT=Paardarshi'#13+
'HORIZ. ALIGNMENT=Sapaat Sanrekhan'#13+
'LEFT=Baiya'#13+
'CENTER=Madhya'#13+
'RIGHT=Daiya'#13+
'ROUND RECTANGLE=Round Aayat'#13+
'ALIGNMENT=Sanrekhan'#13+
'TOP=Sira'#13+
'BOTTOM=Tal'#13+
'RIGHT=Daiya'#13+
'BOTTOM=Tal'#13+
'UNITS=Units'#13+
'PIXELS=Pixels'#13+
'AXIS=Aksh'#13+
'AXIS ORIGIN=Aksh Mool'#13+
'ROTATION=Ghurnan'#13+
'CIRCLED=Vrutit'#13+
'3 DIMENSIONS=3 Dimensions'#13+
'RADIUS=Trijya'#13+
'ANGLE INCREMENT=Kon Sanvrudhhi'#13+
'RADIUS INCREMENT=Trijya Sanvrudhhi'#13+
'CLOSE CIRCLE=Bandh Vrut'#13+
'PEN=Kalam'#13+
'CIRCLE=Vrut'#13+
'LABELS=Labels'#13+
'VISIBLE=Pratyaksh'#13+
'ROTATED=Ghurnan Kiya Hua'#13+
'CLOCKWISE=Dakshinavart'#13+
'INSIDE=Andar'#13+
'ROMAN=Roman'#13+
'HOURS=Ghante'#13+
'MINUTES=Minute'#13+
'SECONDS=Seconde'#13+
'START VALUE=Shuruat Mulya'#13+
'END VALUE=Aant Mulya'#13+
'TRANSPARENCY=Pardarshita'#13+
'DRAW BEHIND=Pichhe Ankit Karo'#13+
'COLOR MODE=Rang Mode'#13+
'STEPS=Steps'#13+
'RANGE=Range'#13+
'PALETTE=RangPattika'#13+
'PALE=Halka'#13+
'STRONG=Tagda'#13+
'GRID SIZE=Jaali Parimaan'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Gahrayi'#13+
'IRREGULAR=Asamaakruti'#13+
'GRID=Jaali'#13+
'VALUE=Mulya'#13+
'ALLOW DRAG=Ghasitne Do'#13+
'VERTICAL POSITION=Lamb Sthaan'#13+
'PEN=Kalam'#13+
'LEVELS POSITION=Staro Ka Sthaan'#13+
'LEVELS=Staro'#13+
'NUMBER=Sankhya'#13+
'LEVEL=Star'#13+
'AUTOMATIC=Swachaalit'#13+
'BOTH=Dono'#13+
'SNAP=Snap'#13+
'FOLLOW MOUSE=Mouse ke Pichhe Chalo'#13+
'STACK=Stack'#13+
'HEIGHT 3D=Uunchayi 3D'#13+
'LINE MODE=Lakir Mode'#13+
'STAIRS=Sidhi'#13+
'NONE=Kuch Nahi'#13+
'OVERLAP=Paraspar Vyapt Hona'#13+
'STACK=Stack'#13+
'STACK 100%=Stack 100%'#13+
'CLICKABLE=Clickable'#13+
'LABELS=Labels'#13+
'AVAILABLE=Uplabadh'#13+
'SELECTED=Pasand Kiya Hua'#13+
'DATASOURCE=Datasource'#13+
'GROUP BY=Group By'#13+
'CALC=Calc'#13+
'OF=Ka'#13+
'SUM=Sankalan Phal'#13+
'COUNT=Sankhya'#13+
'HIGH=Uchh'#13+
'LOW=Nimn'#13+
'AVG=Ausat'#13+
'HOUR=Ghanta'#13+
'DAY=Din'#13+
'WEEK=Hafta'#13+
'WEEKDAY=Kaam Ka Din'#13+
'MONTH=Mahina'#13+
'QUARTER=Trimaas'#13+
'YEAR=Saal'#13+
'HOLE %=Chhidra %'#13+
'RESET POSITIONS=Sthaano Ko Reset Karo'#13+
'MOUSE BUTTON=Mouse Button'#13+
'ENABLE DRAWING=Aarekhan Karne Do'#13+
'ENABLE SELECT=Pasand Karne Do'#13+
'ENHANCED=Vrudhhi Kiya hua'#13+
'ERROR WIDTH=Truti Chaudaayi'#13+
'WIDTH UNITS=Chaudaayi Units'#13+
'PERCENT=Pratishat'#13+
'PIXELS=Pixels'#13+
'LEFT AND RIGHT=Baiya Aur Daiya'#13+
'TOP AND BOTTOM=Sira Aur Tal'#13+
'BORDER=Seema'#13+
'BORDER EDITOR=Seema Sampadak'#13+
'DASH=Dash'#13+
'DOT=Bindu'#13+
'DASH DOT=Dash Bindu'#13+
'DASH DOT DOT=Dash Bindu Bindu'#13+
'CALCULATE EVERY=Pratyek Ko Calculate Karo'#13+
'ALL POINTS=Sabhi Bindu'#13+
'NUMBER OF POINTS=Bindu Ki Sankhya'#13+
'RANGE OF VALUES=Mulyo ki Range'#13+
'FIRST=Pehla'#13+
'CENTER=Madhya'#13+
'LAST=Aakhiri'#13+
'TEEPREVIEW EDITOR=TEEPREVIEW Sampadak'#13+
'ALLOW MOVE=Hilane Do'#13+
'ALLOW RESIZE=Parimaan Badalne Do'#13+
'DRAG IMAGE=Chitra Ko Ghasito'#13+
'AS BITMAP=Bitmap Jaisa'#13+
'SHOW IMAGE=Image Dikhao'#13+
'DEFAULT=Default'#13+
'MARGINS=Hashiyo'#13+
'SIZE=Parimaan'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ROTATION=Ghurnan'#13+
'ELEVATION=Elevation'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Sapaat Antarlamb'#13+
'VERT. OFFSET=Lamb Antarlamb'#13+
'PERSPECTIVE=Perspective'#13+
'ANGLE=Kon'#13+
'ORTHOGONAL=Lambkoniya'#13+
'ZOOM TEXT=Zoom Vaakya'#13+
'SCALES=Shrenikram'#13+
'TITLE=Shirshak'#13+
'TICKS=Ticks'#13+
'MINOR=Laghu'#13+
'MAXIMUM=Adhiktam'#13+
'MINIMUM=Nyuntam'#13+
'(MAX)=(Adhiktam)'#13+
'(MIN)=(Nyuntam)'#13+
'DESIRED INCREMENT=Vaanchhit Sanvrudhhi'#13+
'(INCREMENT)=(Sanvrudhhi)'#13+
'LOG BASE=Log Base'#13+
'LOGARITHMIC=Logarithmic'#13+
'TITLE=Shirshak'#13+
'MIN. SEPARATION %=Nyuntam Separation %'#13+
'MULTI-LINE=Bahut Si Lakire'#13+
'LABEL ON AXIS=Aksh Par Labels'#13+
'ROUND FIRST=Round First'#13+
'MARK=Ank'#13+
'LABELS FORMAT=Labels Format'#13+
'EXPONENTIAL=Exponential'#13+
'DEFAULT ALIGNMENT=Default Sanrekhan'#13+
'LEN=Lambayi'#13+
'LENGTH=Lambayi'#13+
'AXIS=Aksh'#13+
'INNER=Bhitari'#13+
'GRID=Jaali'#13+
'AT LABELS ONLY=Labels Par Hi'#13+
'CENTERED=Kendrit'#13+
'COUNT=Sankhya'#13+
'TICKS=Ticks'#13+
'POSITION %=Sthaan %'#13+
'START %=Shuruat %'#13+
'END %=Aant %'#13+
'OTHER SIDE=Dusri Aur'#13+
'AXES=Aksho'#13+
'BEHIND=Pichhe'#13+
'CLIP POINTS=Binduo ko Kaato'#13+
'PRINT PREVIEW=Chhap Purvadarshan'#13+
'MINIMUM PIXELS=Nyuntam Pixels'#13+
'MOUSE BUTTON=Mouse Button'#13+
'ALLOW=Karne Do'#13+
'ANIMATED=Jivit'#13+
'VERTICAL=Lamb'#13+
'RIGHT=Daiya'#13+
'MIDDLE=Madhya'#13+
'ALLOW SCROLL=Scroll Karne Do'#13+
'TEEOPENGL EDITOR=TEEOPENGL Sampadak'#13+
'AMBIENT LIGHT=Pariveshi Prakash'#13+
'SHININESS=Chamkilapan'#13+
'FONT 3D DEPTH=Font 3D Gahrayi'#13+
'ACTIVE=Sakriya'#13+
'FONT OUTLINES=Font Bahirekhae'#13+
'SMOOTH SHADING=Smooth Chhayakaran'#13+
'LIGHT=Prakash'#13+
'Y=Y'#13+
'INTENSITY=Matra'#13+
'BEVEL=Pravanta'#13+
'FRAME=Chokhta'#13+
'ROUND FRAME=Round Chokhta'#13+
'LOWERED=Nimn Kiya Hua'#13+
'RAISED=Uubhara'#13+
'POSITION=Sthaan'#13+
'SYMBOLS=Pratiko'#13+
'TEXT STYLE=Vaakya Shaili'#13+
'LEGEND STYLE=Legend Shaili'#13+
'VERT. SPACING=Lamb Antralan'#13+
'AUTOMATIC=Swachaalit'#13+
'SERIES NAMES=Shreniyo Ke Naam'#13+
'SERIES VALUES=Shreniyo Ke Mulyo'#13+
'LAST VALUES=Aakhiri Mulyo'#13+
'PLAIN=Sada'#13+
'LEFT VALUE=Baiya Mulya'#13+
'RIGHT VALUE=Daiya Mulya'#13+
'LEFT PERCENT=Baiya Pratishat'#13+
'RIGHT PERCENT=Daiya Pratishat'#13+
'X VALUE=X Mulya'#13+
'VALUE=Mulya'#13+
'PERCENT=Pratishat'#13+
'X AND VALUE=X Aur Mulya'#13+
'X AND PERCENT=X Aur Pratishat'#13+
'CHECK BOXES=Check Boxes'#13+
'DIVIDING LINES=Vibhajak Lakire'#13+
'FONT SERIES COLOR=Font Shreni Rang'#13+
'POSITION OFFSET %=Sthaan Antarlamb %'#13+
'MARGIN=Hashiya'#13+
'RESIZE CHART=Chart ka Parimaan Badlo'#13+
'CUSTOM=Custom'#13+
'WIDTH UNITS=Chaudaayi Units'#13+
'CONTINUOUS=Aviram'#13+
'POINTS PER PAGE=Har Pusht Par Bindu Ki Sankhya'#13+
'SCALE LAST PAGE=Scale Aakhiri Pusht'#13+
'CURRENT PAGE LEGEND=Vartaman Pusht Legend'#13+
'PANEL EDITOR=Panel Sampadak'#13+
'BACKGROUND=Pushthabhumi'#13+
'BORDERS=Seemae'#13+
'BACK IMAGE=Pichhla Chitra'#13+
'STRETCH=Pasaro'#13+
'TILE=Tile'#13+
'CENTER=Madhya'#13+
'BEVEL INNER=Pravanta Bhitari'#13+
'LOWERED=Nimn Kiya Hua'#13+
'RAISED=Uubhara'#13+
'BEVEL OUTER=Pravanta Bahri'#13+
'MARKS=Anko'#13+
'DATA SOURCE=Data Source'#13+
'SORT=Chhanto'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=Legend Me Dikhao'#13+
'FORMATS=Formats'#13+
'VALUES=Mulyo'#13+
'PERCENTS=Pratishate'#13+
'HORIZONTAL AXIS=Sapaat Aksh'#13+
'TOP AND BOTTOM=Sira Aur Tal'#13+
'DATETIME=Tarikh Aur Samay'#13+
'VERTICAL AXIS=Lamb Aksh'#13+
'LEFT=Baiya'#13+
'RIGHT=Daiya'#13+
'LEFT AND RIGHT=Baiya Aur Daiya'#13+
'ASCENDING=Aarohi'#13+
'DESCENDING=Avrohi'#13+
'DRAW EVERY=Har Ek Ko Ankit Karo'#13+
'CLIPPED=Katit'#13+
'ARROWS=Teero'#13+
'MULTI LINE=Bahut Si Lakire'#13+
'ALL SERIES VISIBLE=Sabhi Shreni Pratyaksh'#13+
'LABEL=Label'#13+
'LABEL AND PERCENT=Label Aur Pratishat'#13+
'LABEL AND VALUE=Label Aur Mulya'#13+
'PERCENT TOTAL=Kul Pratishat'#13+
'LABEL & PERCENT TOTAL=Label & Pratishat Kul'#13+
'X VALUE=X Mulya'#13+
'X AND Y VALUES=X Aur Y Mulyo'#13+
'MANUAL=Hast Chalit'#13+
'RANDOM=Random'#13+
'FUNCTION=Phalan'#13+
'NEW=Naya'#13+
'EDIT=Sampadan Karo'#13+
'DELETE=Mita Do'#13+
'PERSISTENT=Persistent'#13+
'ADJUST FRAME=Chokhte Ko Vyavasthit Karo'#13+
'SUBTITLE=Subtitle'#13+
'SUBFOOT=Subfoot'#13+
'FOOT=Foot'#13+
'DELETE=Mita Do'#13+
'VISIBLE WALLS=Pratyaksh Diware'#13+
'BACK=Pichhla'#13+
'DIF. LIMIT=Dif. Limit'#13+
'LINES=Lakire'#13+
'ABOVE=Uupar'#13+
'WITHIN=Bthitar'#13+
'BELOW=Niche'#13+
'CONNECTING LINES=Sanyojak Lakire'#13+
'SERIES=Shreni'#13+
'PALE=Halka'#13+
'STRONG=Tagda'#13+
'HIGH=Uchh'#13+
'LOW=Nimn'#13+
'BROWSE=Browse'#13+
'TILED=Tiled'#13+
'INFLATE MARGINS=Hashiyo Ko Phulao'#13+
'SQUARE=Chaaukor'#13+
'DOWN TRIANGLE=Down Trikon'#13+
'SMALL DOT=Chhota Bindu'#13+
'DEFAULT=Default'#13+
'GLOBAL=Sarvatrik'#13+
'SHAPES=Aakrutiya'#13+
'BRUSH=Kunchi'#13+
'BRUSH=Kunchi'#13+
'BORDER=Seema'#13+
'COLOR=Rang'#13+
'DELAY=Vilamb'#13+
'MSEC.=Msec.'#13+
'MOUSE ACTION=Mouse ki Kriya'#13+
'MOVE=Hilana'#13+
'CLICK=Click'#13+
'BRUSH=Kunchi'#13+
'DRAW LINE=Lakir Ankit Karo'#13+
'BORDER EDITOR=Seema Sampadak'#13+
'DASH=Dash'#13+
'DOT=Bindu'#13+
'DASH DOT=Dash Bindu'#13+
'DASH DOT DOT=Dash Bindu Bindu'#13+
'EXPLODE BIGGEST=Sabse Bade ko Visfot Karo'#13+
'TOTAL ANGLE=Kul Kon'#13+
'GROUP SLICES=Group Hissa'#13+
'BELOW %=Niche %'#13+
'BELOW VALUE=Niche Ka Mulya'#13+
'OTHER=Anya'#13+
'PATTERNS=Patterns'#13+
'CLOSE CIRCLE=Bandh Vrut'#13+
'VISIBLE=Pratyaksh'#13+
'CLOCKWISE=Dakshinavart'#13+
'SIZE %=Parimaan %'#13+
'PATTERN=Pattern'#13+
'DEFAULT=Default'#13+
'SERIES DATASOURCE TEXT EDITOR=Shreni Datasource Vaakya Sampadak'#13+
'FIELDS=Fields'#13+
'NUMBER OF HEADER LINES=Shirsh Lakiro Ki Sankhya'#13+
'SEPARATOR=Separator'#13+
'COMMA=Alpa Viraam'#13+
'SPACE=Space'#13+
'TAB=Tab'#13+
'FILE=File'#13+
'WEB URL=Web URL'#13+
'LOAD=Bharo'#13+
'C LABELS=C Labels'#13+
'R LABELS=R Labels'#13+
'C PEN=C Kalam'#13+
'R PEN=R Kalam'#13+
'STACK GROUP=Stack Group'#13+
'USE ORIGIN=Mool Istemaal Karo'#13+
'MULTIPLE BAR=Bahul Dand'#13+
'SIDE=Phalak'#13+
'STACKED 100%=Stacked 100%'#13+
'SIDE ALL=Sabhi Phalak'#13+
'BRUSH=Kunchi'#13+
'DRAWING MODE=Aarekhan Mode'#13+
'SOLID=Ghan'#13+
'WIREFRAME=Taarjaali'#13+
'DOTFRAME=Binduwala Chokhta'#13+
'SMOOTH PALETTE=Smooth Rangpattika'#13+
'SIDE BRUSH=Phalak Kunchi'#13+
'ABOUT TEECHART PRO V5.02=TeeChart Pro v5.0 Ke Bare Me'#13+
'ALL RIGHTS RESERVED.=Sabhi Hakk Aarakshit.'#13+
'VISIT OUR WEB SITE !=Hamari Web site Ki Mulaqat Lijiye !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Ek Chart Shaili Pasand Karo'#13+
'DATABASE CHART=Database Chart'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Ek Database Table Pasand Karo'#13+
'ALIAS=Uupnaam'#13+
'TABLE=Table'#13+
'SOURCE=Stroat'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Chart Karneke Liye Vaanchhit Fields ko Pasand Karo'#13+
'SELECT A TEXT LABELS FIELD=Ek Vaakya Labels Field Ko Pasand Karo'#13+
'CHOOSE THE DESIRED CHART TYPE=Vaanchhit Chart Prakar Ko Chuno'#13+
'2D=2D'#13+
'CHART PREVIEW=Chart Purvadarshan'#13+
'SHOW LEGEND=Legend Dikhao'#13+
'SHOW MARKS=Ank Dikhao'#13+
'< BACK=< Pichhe'#13+
'SELECT A CHART STYLE=Ek Chart Shaili Pasand Karo'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Ek Database Table Pasand Karo'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Chart Karneke Liye Vaanchhit Fields ko Pasand Karo'#13+
'SELECT A TEXT LABELS FIELD=Ek Vaakya Labels Field Ko Pasand Karo'#13+
'CHOOSE THE DESIRED CHART TYPE=Vaanchhit Chart Prakar Ko Chuno'#13+
'EXPORT CHART=Chart Ko Niryaat Karo'#13+
'PICTURE=Tasvir'#13+
'NATIVE=Deshiya'#13+
'KEEP ASPECT RATIO=Aspect Ratio Banaye Rakho'#13+
'INCLUDE SERIES DATA=Shreni Data Ko Sammilit Karo'#13+
'FILE SIZE=File Parimaan'#13+
'DELIMITER=Delimiter'#13+
'XML=XML'#13+
'HTML TABLE=HTML Table'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=Apurna Viraam'#13+
'INCLUDE=Sammlit Karo'#13+
'POINT LABELS=Bindu Labels'#13+
'POINT INDEX=Bindu Suchi'#13+
'HEADER=Shirsh'#13+
'COPY=Nakal'#13+
'SAVE=Bachao'#13+
'SEND=Bhejo'#13+
'KEEP ASPECT RATIO=Aspect Ratio Banaye Rakho'#13+
'INCLUDE SERIES DATA=Shreni Data Ko Sammilit Karo'#13+
'FUNCTIONS=Phalano'#13+
'ADD=Add'#13+
'ADX=ADX'#13+
'AVERAGE=Madhyak'#13+
'BOLLINGER=Bollinger'#13+
'COPY=Nakal'#13+
'DIVIDE=Vibhajan'#13+
'EXP. AVERAGE=Exp. Average'#13+
'EXP.MOV.AVRG.=Exp.Mov.Avrg'#13+
'HIGH=Uchh'#13+
'LOW=Nimn'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Moving Avrg.'#13+
'MULTIPLY=Guna Karo'#13+
'R.S.I.=R.S.I'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=STD. Deviation'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Ghatana'#13+
'APPLY=Lagu Karo'#13+
'SOURCE SERIES=Stroat Shreni'#13+
'TEECHART GALLERY=TeeChart Gallery'#13+
'FUNCTIONS=Phalano'#13+
'DITHER=Dither'#13+
'REDUCTION=Katauti'#13+
'COMPRESSION=Dabav'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nikattam'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=Jajuni'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Ghusar'#13+
'MONOCHROME=Ek ranga'#13+
'GRAY SCALE=Ghusar Scale'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Koti'#13+
'GRAY SCALE=Ghusar Scale'#13+
'PERFORMANCE=Performance'#13+
'QUALITY=Koti'#13+
'SPEED=Raftaar'#13+
'COMPRESSION LEVEL=Dabav Ka Star'#13+
'CHART TOOLS GALLERY=Chart Upkaran Gallery'#13+
'ANNOTATION=Tippan'#13+
'AXIS ARROWS=Aksh Teero'#13+
'COLOR BAND=Rang Patti'#13+
'COLOR LINE=Rang Lakir'#13+
'CURSOR=Cursor'#13+
'DRAG MARKS=Anko Ko Ghasito'#13+
'DRAW LINE=Lakir Ankit Karo'#13+
'IMAGE=Chitra'#13+
'MARK TIPS=Nok Ankit Karo'#13+
'NEAREST POINT=Nikattam Bindu'#13+
'ROTATE=Ghurnan Karo'#13+
'CHART TOOLS GALLERY=Chart Upkaran Gallery'#13+
'BRUSH=Kunchi'#13+
'DRAWING MODE=Aarekhan Mode'#13+
'WIREFRAME=Taarjaali'#13+
'SMOOTH PALETTE=Smooth Rangpattika'#13+
'SIDE BRUSH=Phalak Kunchi'#13+
'YES=Han'#13
;
  end;
end;

Procedure TeeSetHindi;
begin
  TeeCreateHindi;
  TeeLanguage:=TeeHindiLanguage;
  TeeHindiConstants;
end;

initialization
finalization
  FreeAndNil(TeeHindiLanguage);
end.
