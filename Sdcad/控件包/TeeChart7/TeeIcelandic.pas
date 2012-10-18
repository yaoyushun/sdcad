{$I TeeDefs.inc}
unit TeeIcelandic;

interface

Uses Classes;

Var TeeIcelandicLanguage:TStringList=nil;

Procedure TeeSetIcelandic;
Procedure TeeCreateIcelandic;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeIcelandicConstants;
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
  TeeMsg_AxisDlgValue       :='Value:';

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

  TeeMsg_CantDeleteAncestor  :='Can not delete ancestor';

  TeeMsg_Load	          :='Load...';
  TeeMsg_WinInet          :='(WinInet.dll to access TeeChart)';
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

Procedure TeeCreateIcelandic;
begin
  if not Assigned(TeeIcelandicLanguage) then
  begin
    TeeIcelandicLanguage:=TStringList.Create;
    TeeIcelandicLanguage.Text:=

'GRADIENT EDITOR=Gradient editor'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Direction'#13+
'VISIBLE=Visible'#13+
'TOP BOTTOM=Top Bottom'#13+
'BOTTOM TOP=Bottom Top'#13+
'LEFT RIGHT=Left Right'#13+
'RIGHT LEFT=Right Left'#13+
'FROM CENTER=From Center'#13+
'FROM TOP LEFT=From Top Left'#13+
'FROM BOTTOM LEFT=From Bottom Left'#13+
'OK=Ok'#13+
'CANCEL=Cancel'#13+
'COLORS=Colors'#13+
'START=Start'#13+
'MIDDLE=Middle'#13+
'END=End'#13+
'SWAP=Swap'#13+
'NO MIDDLE=No middle'#13+
'TEEFONT EDITOR=Font Editor'#13+
'INTER-CHAR SPACING=Inter-Chart spacing'#13+
'FONT=Font'#13+
'SHADOW=Shadow'#13+
'HORIZ. SIZE=Horiz. size'#13+
'VERT. SIZE=Vert. size'#13+
'COLOR=Color'#13+
'OUTLINE=Outline'#13+
'OPTIONS=Options'#13+
'FORMAT=Format'#13+
'TEXT=Text'#13+
'GRADIENT=Gradient'#13+
'POSITION=Position'#13+
'LEFT=Left'#13+
'TOP=Top'#13+
'AUTO=Auto'#13+
'CUSTOM=Custom'#13+
'LEFT TOP=Left top'#13+
'LEFT BOTTOM=Left bottom'#13+
'RIGHT TOP=Right top'#13+
'RIGHT BOTTOM=Right bottom'#13+
'MULTIPLE AREAS=Mehrere Flächen'#13+
'NONE=None'#13+
'STACKED=Stacked'#13+
'STACKED 100%=Stacked 100%'#13+
'AREA=Area'#13+
'PATTERN=Pattern'#13+
'STAIRS=Stairs'#13+
'SOLID=Solid'#13+
'CLEAR=Clear'#13+
'HORIZONTAL=Horizontal'#13+
'VERTICAL=Vertical'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Cross'#13+
'DIAG.CROSS=Diag.Cross'#13+
'AREA LINES=Area lines'#13+
'BORDER=Border'#13+
'INVERTED=Inverted'#13+
'INVERTED SCROLL=Inverted Scroll'#13+
'COLOR EACH=Color each'#13+
'ORIGIN=Origin'#13+
'USE ORIGIN=Use origin'#13+
'WIDTH=Width'#13+
'HEIGHT=Height'#13+
'AXIS=Axis'#13+
'LENGTH=Length'#13+
'SCROLL=Scroll'#13+
'PATTERN=Pattern'#13+
'START=Start'#13+
'END=End'#13+
'BOTH=Both'#13+
'AXIS INCREMENT=Axis increnent'#13+
'INCREMENT=Increment'#13+
'STANDARD=Standard'#13+
'CUSTOM=Custom'#13+
'ONE MILLISECOND=One Millisecond'#13+
'ONE SECOND=One Second'#13+
'FIVE SECONDS=Five Seconds'#13+
'TEN SECONDS=Ten Seconds'#13+
'FIFTEEN SECONDS=Fifteen Seconds'#13+
'THIRTY SECONDS=Thirty Seconds'#13+
'ONE MINUTE=One Minute'#13+
'FIVE MINUTES=Five Minutes'#13+
'TEN MINUTES=Ten Minutes'#13+
'FIFTEEN MINUTES=Fifteen Minutes'#13+
'THIRTY MINUTES=Thirty Minutes'#13+
'ONE HOUR=One Hour'#13+
'TWO HOURS=Two Hours'#13+
'SIX HOURS=Six Hours'#13+
'TWELVE HOURS=Twelve Hours'#13+
'ONE DAY=One Day'#13+
'TWO DAYS=Two Days'#13+
'THREE DAYS=Three Days'#13+
'ONE WEEK=One Week'#13+
'HALF MONTH=Half Month'#13+
'ONE MONTH=One Month'#13+
'TWO MONTHS=Two Months'#13+
'THREE MONTHS=Three Months'#13+
'FOUR MONTHS=Four Months'#13+
'SIX MONTHS=Six Months'#13+
'ONE YEAR=One Year'#13+
'EXACT DATE TIME=Exact date time'#13+
'AXIS MAXIMUM AND MINIMUM=Axis maximum and minimum'#13+
'VALUE=Value'#13+
'TIME=Time'#13+
'LEFT AXIS=Left axis'#13+
'RIGHT AXIS=Right axis'#13+
'TOP AXIS=Top axis'#13+
'BOTTOM AXIS=Bottom axis'#13+
'% BAR WIDTH=% Bar Width'#13+
'STYLE=Style'#13+
'% BAR OFFSET=% Bar offset'#13+
'RECTANGLE=Rectangle'#13+
'PYRAMID=Pyramid'#13+
'INVERT. PYRAMID=Invert. Pyramid'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Ellipse'#13+
'ARROW=Arrow'#13+
'RECT. GRADIENT=Rect. Gradient'#13+
'CONE=Cone'#13+
'DARK BAR 3D SIDES=Dark bar 3D Sides'#13+
'BAR SIDE MARGINS=Bar Side Margins'#13+
'AUTO MARK POSITION=Auto Mark Position'#13+
'BORDER=Border'#13+
'JOIN=Join'#13+
'BAR SIDE MARGINS=Bar Side Margins'#13+
'DATASET=Dataset'#13+
'APPLY=Apply'#13+
'SOURCE=Source'#13+
'MONOCHROME=Monochrome'#13+
'DEFAULT=Default'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'LENGTH=Length'#13+
'MEDIAN=Median'#13+
'WHISKER=Whisker'#13+
'PATTERN COLOR EDITOR=Pattern Color Editor'#13+
'IMAGE=Image'#13+
'NONE=None'#13+
'BACK DIAGONAL=Back Diagonal'#13+
'CROSS=Cross'#13+
'DIAGONAL CROSS=Diagonal Cross'#13+
'FILL 80%=Fill 80%'#13+
'FILL 60%=Fill 60%'#13+
'FILL 40%=Fill 40%'#13+
'FILL 20%=Fill 20%'#13+
'FILL 10%=Fill 10%'#13+
'ZIG ZAG=Zig Zag'#13+
'VERTICAL SMALL=Vertical small'#13+
'HORIZ. SMALL=Horiz. small'#13+
'DIAG. SMALL=Diag. small'#13+
'BACK DIAG. SMALL=Back Diag.'#13+
'CROSS SMALL=Cross small'#13+
'DIAG. CROSS SMALL=Diag. Cross'#13+
'PATTERN COLOR EDITOR=Pattern Color Editor'#13+
'OPTIONS=Options'#13+
'DAYS=Days'#13+
'WEEKDAYS=Weekdays'#13+
'TODAY=Today'#13+
'SUNDAY=Sunday'#13+
'TRAILING=Trailing'#13+
'MONTHS=Months'#13+
'LINES=Lines'#13+
'SHOW WEEKDAYS=Show Weekdays'#13+
'UPPERCASE=Uppercase'#13+
'TRAILING DAYS=Trailing days'#13+
'SHOW TODAY=Show today'#13+
'SHOW MONTHS=Show Months'#13+
'CANDLE WIDTH=Candle Width'#13+
'STICK=Stick'#13+
'BAR=Bar'#13+
'OPEN CLOSE=Open Close'#13+
'UP CLOSE=Farbe Steigend'#13+
'DOWN CLOSE=Farbe Fallend'#13+
'SHOW OPEN=Eröffnung'#13+
'SHOW CLOSE=Schluß'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D Dunkel'#13+
'EDITING=Bearbeiten'#13+
'CHART=Chart'#13+
'SERIES=Reihe'#13+
'DATA=Daten'#13+
'TOOLS=Tools'#13+
'EXPORT=Exportieren'#13+
'PRINT=Drucken'#13+
'GENERAL=Allgemein'#13+
'TITLES=Titel'#13+
'LEGEND=Legende'#13+
'PANEL=Rand'#13+
'PAGING=Seite'#13+
'WALLS=Wand'#13+
'3D=3D'#13+
'ADD=Hinzufügen'#13+
'DELETE=Entfernen'#13+
'TITLE=Name'#13+
'CLONE=Dublizieren'#13+
'CHANGE=Ändern'#13+
'HELP=Hilfe'#13+
'CLOSE=Schließen'#13+
'IMAGE=Bild'#13+
'TEECHART PRINT PREVIEW=TeeChart Druckansicht'#13+
'PRINTER=Drucker'#13+
'SETUP=Eigenscha.'#13+
'ORIENTATION=Ausrichtung'#13+
'PORTRAIT=Hochformat'#13+
'LANDSCAPE=Querformat'#13+
'MARGINS (%)=Rand (%)'#13+
'DETAIL=Detail'#13+
'MORE=Mehr'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Zurücksetzen'#13+
'VIEW MARGINS=Rand anzeigen'#13+
'PROPORTIONAL=Proportional'#13+
'TEECHART PRINT PREVIEW=TeeChart Druckansicht'#13+
'RECTANGLE=Rectangle'#13+
'CIRCLE=Circle'#13+
'VERTICAL LINE=Vert. Linie'#13+
'HORIZ. LINE=Horiz. Linie'#13+
'TRIANGLE=Dreieck'#13+
'INVERT. TRIANGLE=Kopfst. Dreieck'#13+
'LINE=Linie'#13+
'DIAMOND=Diamant'#13+
'CUBE=Würfel'#13+
'DIAGONAL CROSS=Diagonal Kreuz'#13+
'STAR=Stern'#13+
'TRANSPARENT=Transparent'#13+
'HORIZ. ALIGNMENT=Horiz. Ausrichtung'#13+
'LEFT=Links'#13+
'CENTER=Mitte'#13+
'RIGHT=Rechts'#13+
'ROUND RECTANGLE=Rechteck abrunden'#13+
'ALIGNMENT=Ausrichtung'#13+
'TOP=Oben'#13+
'BOTTOM=Unten'#13+
'RIGHT=:Right'#13+
'BOTTOM=Bottom'#13+
'UNITS=Units'#13+
'PIXELS=Pixels'#13+
'AXIS=Axis'#13+
'AXIS ORIGIN=Axis Origin'#13+
'ROTATION=Drehung'#13+
'CIRCLED=Rund'#13+
'3 DIMENSIONS=3 Dimensional'#13+
'RADIUS=Radius'#13+
'ANGLE INCREMENT=Schrittweite Winkel'#13+
'RADIUS INCREMENT=Schrittweite Radius'#13+
'CLOSE CIRCLE=Kreisrund'#13+
'PEN=Stift'#13+
'CIRCLE=Kreis'#13+
'LABELS=Beschriftung'#13+
'VISIBLE=Anzeig.'#13+
'ROTATED=Gedreht'#13+
'CLOCKWISE=Uhrzeigersinn'#13+
'INSIDE=Innen'#13+
'ROMAN=Roman'#13+
'HOURS=Stunden'#13+
'MINUTES=Minuten'#13+
'SECONDS=Sekunden'#13+
'START VALUE=Startwert'#13+
'END VALUE=Endwert'#13+
'TRANSPARENCY=Transparenz'#13+
'DRAW BEHIND=Dahinter zeichnen'#13+
'COLOR MODE=Farbmodus'#13+
'STEPS=Schritte'#13+
'RANGE=Bereich'#13+
'PALETTE=Palette'#13+
'PALE=Blaß'#13+
'STRONG=Stark'#13+
'GRID SIZE=Gittergröße'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Tiefe'#13+
'IRREGULAR=Irregulär'#13+
'GRID=Gitter'#13+
'VALUE=Wert'#13+
'ALLOW DRAG=Ziehen erlauben'#13+
'VERTICAL POSITION=Vertikale Position'#13+
'PEN=Linien'#13+
'LEVELS POSITION=Ebenen Position'#13+
'LEVELS=Ebenen'#13+
'NUMBER=Anzahl'#13+
'LEVEL=Ebenen'#13+
'AUTOMATIC=Automatisch'#13+
'BOTH=Beide'#13+
'SNAP=Snap'#13+
'FOLLOW MOUSE=Maus folgen'#13+
'STACK=Stapel'#13+
'HEIGHT 3D=3D Höhe'#13+
'LINE MODE=Linien Modus'#13+
'STAIRS=Stufen'#13+
'NONE=None'#13+
'OVERLAP=Overlap'#13+
'STACK=Stack'#13+
'STACK 100%=Stack 100%'#13+
'CLICKABLE=Mausclick'#13+
'LABELS=Labels'#13+
'AVAILABLE=Vorhanden'#13+
'SELECTED=Ausgewählt'#13+
'DATASOURCE=Datenquelle'#13+
'GROUP BY=Group by'#13+
'CALC=Calc'#13+
'OF=of'#13+
'SUM=Sum'#13+
'COUNT=Count'#13+
'HIGH=High'#13+
'LOW=Low'#13+
'AVG=Avg'#13+
'HOUR=Hour'#13+
'DAY=Day'#13+
'WEEK=Week'#13+
'WEEKDAY=WeekDay'#13+
'MONTH=Month'#13+
'QUARTER=Quarter'#13+
'YEAR=Year'#13+
'HOLE %=Loch %'#13+
'RESET POSITIONS=Positionen rücksetzen'#13+
'MOUSE BUTTON=Maustaste'#13+
'ENABLE DRAWING=Zeichnung erlauben'#13+
'ENABLE SELECT=Auswahl erlauben'#13+
'ENHANCED=Erhöht'#13+
'ERROR WIDTH=Fehler T Breite'#13+
'WIDTH UNITS=T Breite'#13+
'PERCENT=Prozent'#13+
'PIXELS=Pixel'#13+
'LEFT AND RIGHT=Links und Rechts'#13+
'TOP AND BOTTOM=Oben und Unten'#13+
'BORDER=Fehler Linie'#13+
'BORDER EDITOR=Grenz Editor'#13+
'DASH=Durchgezogen'#13+
'DOT=Gestrichelt'#13+
'DASH DOT=Punkt'#13+
'DASH DOT DOT=Strich Punkt'#13+
'CALCULATE EVERY=Jede berechnen'#13+
'ALL POINTS=Alle Werte'#13+
'NUMBER OF POINTS=Anzahl der Werte'#13+
'RANGE OF VALUES=Wertereihe'#13+
'FIRST=Erster'#13+
'CENTER=Mittlerer'#13+
'LAST=Letzter'#13+
'TEEPREVIEW EDITOR=TeeVorschau Editor'#13+
'ALLOW MOVE=Bewegung erlauben'#13+
'ALLOW RESIZE=Resize erlauben'#13+
'DRAG IMAGE=Grafik ziehen'#13+
'AS BITMAP=Als Bitmap'#13+
'SHOW IMAGE=Grafik anzeigen'#13+
'DEFAULT=Voreinstellung'#13+
'MARGINS=Abstände'#13+
'SIZE=Größe'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ROTATION=Rotation'#13+
'ELEVATION=Blickwinkel'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horiz. Offset'#13+
'VERT. OFFSET=Vert. Offset'#13+
'PERSPECTIVE=Perspektive'#13+
'ANGLE=Winkel'#13+
'ORTHOGONAL=Orthogonal'#13+
'ZOOM TEXT=Zoom Text'#13+
'SCALES=Skalierung'#13+
'TITLE=Title'#13+
'TICKS=Ticks'#13+
'MINOR=Unterticks'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Schrittweite'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=Log Basis'#13+
'LOGARITHMIC=Logarithmisch'#13+
'TITLE=Titel'#13+
'MIN. SEPARATION %=Min. Abstand %'#13+
'MULTI-LINE=Multi-linie'#13+
'LABEL ON AXIS=Beschriftung auf Achsen'#13+
'ROUND FIRST=Ersten Runden'#13+
'MARK=Mark.'#13+
'LABELS FORMAT=Beschrift.- Format'#13+
'EXPONENTIAL=Exponential'#13+
'DEFAULT ALIGNMENT=Voreinstellung Abstand'#13+
'LEN=Länge'#13+
'LENGTH=Länge'#13+
'AXIS=Achsgrenzen'#13+
'INNER=Inner'#13+
'GRID=Gitternetz'#13+
'AT LABELS ONLY=Nur Beschriftung'#13+
'CENTERED=Mittig'#13+
'COUNT=Anzahl'#13+
'TICKS=Unterticks'#13+
'POSITION %=Position %'#13+
'START %=Beginn %'#13+
'END %=Ende %'#13+
'OTHER SIDE=Andere Seite'#13+
'AXES=Achsen'#13+
'BEHIND=Hinten'#13+
'CLIP POINTS=Clip Points'#13+
'PRINT PREVIEW=Seitenansicht'#13+
'MINIMUM PIXELS=Minimum Pixel'#13+
'MOUSE BUTTON=Maus-Click'#13+
'ALLOW=Zoom Ein/Aus'#13+
'ANIMATED=Gleitend'#13+
'VERTICAL=Vertical'#13+
'RIGHT=Right'#13+
'MIDDLE=Middle'#13+
'ALLOW SCROLL=Scroll'#13+
'TEEOPENGL EDITOR=TeeOpenGL Editor'#13+
'AMBIENT LIGHT=Umgebung'#13+
'SHININESS=Beleuchtung'#13+
'FONT 3D DEPTH=3D Schrift-Tiefe'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Umriß Schrift'#13+
'SMOOTH SHADING=Fließender Schatten'#13+
'LIGHT=Licht'#13+
'Y=Y'#13+
'INTENSITY=Intensität'#13+
'BEVEL=Schräge'#13+
'FRAME=Rahmen'#13+
'ROUND FRAME=Runder Rahmen'#13+
'LOWERED=Hinter'#13+
'RAISED=Hervor'#13+
'POSITION=Ausrichtung'#13+
'SYMBOLS=Symbole'#13+
'TEXT STYLE=Textstil'#13+
'LEGEND STYLE=Legendenstil'#13+
'VERT. SPACING=Vert. Abstand'#13+
'AUTOMATIC=Automatic'#13+
'SERIES NAMES=Series Names'#13+
'SERIES VALUES=Series Values'#13+
'LAST VALUES=Last Values'#13+
'PLAIN=Plain'#13+
'LEFT VALUE=Left Value'#13+
'RIGHT VALUE=Right Value'#13+
'LEFT PERCENT=Left Percent'#13+
'RIGHT PERCENT=Right Percent'#13+
'X VALUE=X Value'#13+
'VALUE=Value'#13+
'PERCENT=Percent'#13+
'X AND VALUE=X and Value'#13+
'X AND PERCENT=X and Percent'#13+
'CHECK BOXES=Check-Boxen'#13+
'DIVIDING LINES=Trennlinie'#13+
'FONT SERIES COLOR=Chart-Farbe'#13+
'POSITION OFFSET %=Abstand Oben %'#13+
'MARGIN=Rand'#13+
'RESIZE CHART=Originalgröße'#13+
'CUSTOM=Benutzerdef.'#13+
'WIDTH UNITS=Einheit'#13+
'CONTINUOUS=Fortlaufend'#13+
'POINTS PER PAGE=Werte pro Seite'#13+
'SCALE LAST PAGE=Letzte Seite Einteilen'#13+
'CURRENT PAGE LEGEND=Aktuelle Legende'#13+
'PANEL EDITOR=Hintergrund Editor'#13+
'BACKGROUND=Hintergrund'#13+
'BORDERS=Rand'#13+
'BACK IMAGE=Hintergrund'#13+
'STRETCH=Dehnen'#13+
'TILE=Ausfüllen'#13+
'CENTER=Mittig'#13+
'BEVEL INNER=Innen'#13+
'LOWERED=Hinten'#13+
'RAISED=Vorn'#13+
'BEVEL OUTER=Außen'#13+
'MARKS=Marks'#13+
'DATA SOURCE=Datei'#13+
'SORT=Sortieren'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=In Legende Anzeigen'#13+
'FORMATS=Formate'#13+
'VALUES=Werte'#13+
'PERCENTS=Prozente'#13+
'HORIZONTAL AXIS=Horizontale Achse'#13+
'TOP AND BOTTOM=Beide'#13+
'DATETIME=Datum/Uhrzeit'#13+
'VERTICAL AXIS=Vertikale Achse'#13+
'LEFT=Oben'#13+
'RIGHT=Unten'#13+
'LEFT AND RIGHT=Beide'#13+
'ASCENDING=Aufsteigend'#13+
'DESCENDING=Absteigend'#13+
'DRAW EVERY=Alle zeichnen'#13+
'CLIPPED=Schneiden'#13+
'ARROWS=Pfeile'#13+
'MULTI LINE=Multi-linie'#13+
'ALL SERIES VISIBLE=Alle Reihen anzeigen'#13+
'LABEL=Label'#13+
'LABEL AND PERCENT=Label und Prozent'#13+
'LABEL AND VALUE=Label und Wert'#13+
'PERCENT TOTAL=Prozent Total'#13+
'LABEL & PERCENT TOTAL=Label & Prozent Total'#13+
'X VALUE=X Wert'#13+
'X AND Y VALUES=X und Y Werte'#13+
'MANUAL=Manuell'#13+
'RANDOM=Zufall'#13+
'FUNCTION=Funktion'#13+
'NEW=Neu'#13+
'EDIT=Bearbeiten'#13+
'DELETE=Löschung'#13+
'PERSISTENT=Ständig'#13+
'ADJUST FRAME=Rahmen fest'#13+
'SUBTITLE=Untertitel'#13+
'SUBFOOT=Fußzeile'#13+
'FOOT=2. Fußzeile'#13+
'DELETE=Löschen'#13+
'VISIBLE WALLS=Wände Anzeigen'#13+
'BACK=Hinten'#13+
'DIF. LIMIT=Dif. Limit'#13+
'LINES=Trennlinien'#13+
'ABOVE=Über'#13+
'WITHIN=Innerhalb'#13+
'BELOW=Unter'#13+
'CONNECTING LINES=Verknüpfungslinien'#13+
'SERIES=Konstant'#13+
'PALE=Pale'#13+
'STRONG=Strong'#13+
'HIGH=Oben'#13+
'LOW=Unten'#13+
'BROWSE=Suchen in'#13+
'TILED=Ausgefüllt'#13+
'INFLATE MARGINS=Randabstand'#13+
'SQUARE=Quadrat'#13+
'DOWN TRIANGLE=Kopfst. Dreieck'#13+
'SMALL DOT=Kleine Punkte'#13+
'DEFAULT=Voreinst.'#13+
'GLOBAL=Global'#13+
'SHAPES=Formen'#13+
'BRUSH=Pinsel'#13+
'BRUSH=Brush'#13+
'BORDER=Border'#13+
'COLOR=Color'#13+
'DELAY=Verzögerung'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Mausaktion'#13+
'MOVE=Bewegen'#13+
'CLICK=Click'#13+
'BRUSH=Hintergrund'#13+
'DRAW LINE=Linie zeichnen'#13+
'BORDER EDITOR=Grenz Farben Editor'#13+
'DASH=Solid'#13+
'DOT=Dash'#13+
'DASH DOT=Dot'#13+
'DASH DOT DOT=Dash Dot'#13+
'EXPLODE BIGGEST=Größter Extra'#13+
'TOTAL ANGLE=Gesamtwinkel'#13+
'GROUP SLICES=Gruppierung'#13+
'BELOW %=Below %'#13+
'BELOW VALUE=Below Value'#13+
'OTHER=Other'#13+
'PATTERNS=Muster'#13+
'CLOSE CIRCLE=Schließen'#13+
'VISIBLE=Zeigen'#13+
'CLOCKWISE=Uhrwärts'#13+
'SIZE %=Größe %'#13+
'PATTERN=Hintergrund'#13+
'DEFAULT=Vorher'#13+
'SERIES DATASOURCE TEXT EDITOR=DatenquellenText Editor'#13+
'FIELDS=Felder'#13+
'NUMBER OF HEADER LINES=Anzahl der  Titelzeilen'#13+
'SEPARATOR=Teilung'#13+
'COMMA=Komma'#13+
'SPACE=Space'#13+
'TAB=Tabulator'#13+
'FILE=File'#13+
'WEB URL=Web URL'#13+
'LOAD=Laden'#13+
'C LABELS=C Labels'#13+
'R LABELS=R Labels'#13+
'C PEN=C Stift'#13+
'R PEN=R Stift'#13+
'STACK GROUP=Stapel gruppieren'#13+
'USE ORIGIN=Ursprung'#13+
'MULTIPLE BAR=Mehrere Säulen'#13+
'SIDE=Nebeneinander'#13+
'STACKED 100%=Stacked 100%'#13+
'SIDE ALL=Alle Nebeneinander'#13+
'BRUSH=Muster..'#13+
'DRAWING MODE=Zeichnungsmodus'#13+
'SOLID=Voll'#13+
'WIREFRAME=Gitternetz'#13+
'DOTFRAME=Punktnetz'#13+
'SMOOTH PALETTE=Weicher Übergang'#13+
'SIDE BRUSH=Seitenmuster'#13+
'ABOUT TEECHART PRO V5.02=Info TeeChart Pro v5.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Chart Stil auswählen'#13+
'DATABASE CHART=Datenbank-Chart'#13+
'NON DATABASE CHART=Kein Datenbank-Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'ALIAS=Alias'#13+
'TABLE=Table'#13+
'SOURCE=Source'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Select the desired Fields to Chart'#13+
'SELECT A TEXT LABELS FIELD=Select a text labels Field'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'2D=2D'#13+
'CHART PREVIEW=Chart Preview'#13+
'SHOW LEGEND=Show Legend'#13+
'SHOW MARKS=Show Marks'#13+
'< BACK=< Vorheriger'#13+
'SELECT A CHART STYLE=Chart Stil auswählen'#13+
'NON DATABASE CHART=Kein Datenbank-Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Select the desired Fields to Chart'#13+
'SELECT A TEXT LABELS FIELD=Select a text labels Field'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'EXPORT CHART=Chart Exportieren'#13+
'PICTURE=Bild'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Verhältnis beibehalten'#13+
'INCLUDE SERIES DATA=Inklusive Reihendaten'#13+
'FILE SIZE=File-Größe'#13+
'DELIMITER=Abgrenzung'#13+
'XML=XML'#13+
'HTML TABLE=HTML Table'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=Doppelpunkt'#13+
'INCLUDE=Inklusive'#13+
'POINT LABELS=Labels anzeigen'#13+
'POINT INDEX=Index anzeigen'#13+
'HEADER=Kopfzeile'#13+
'COPY=Kopieren'#13+
'SAVE=Speichern'#13+
'SEND=Senden'#13+
'KEEP ASPECT RATIO=Verhältnis beibehalten'#13+
'INCLUDE SERIES DATA=Inklusive Reihendaten'#13+
'FUNCTIONS=Funktionen'#13+
'ADD=Addieren'#13+
'ADX=ADX'#13+
'AVERAGE=Bollinger'#13+
'BOLLINGER=Dividieren'#13+
'COPY=Durchschnitt'#13+
'DIVIDE=Exp.Durchschn.'#13+
'EXP. AVERAGE=Exp.Gleit.Durchschn.'#13+
'EXP.MOV.AVRG.=Gleit.Durchschn.'#13+
'HIGH=Hoch'#13+
'LOW=Kopie'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Multiplizieren'#13+
'MULTIPLY=R.S.I.'#13+
'R.S.I.=Std.-Abweichung'#13+
'ROOT MEAN SQ.=Stochastik'#13+
'STD.DEVIATION=Subtrahieren'#13+
'STOCHASTIC=Tief'#13+
'SUBTRACT=Wurzel Mean Sq.'#13+
'APPLY=Hinzufügen'#13+
'SOURCE SERIES=Quellreihe'#13+
'TEECHART GALLERY=TeeChart Gallerie'#13+
'FUNCTIONS=Funktion'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduction'#13+
'COMPRESSION=Compression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nearest'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=Monochrome'#13+
'GRAY SCALE=Gray Scale'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Qualität'#13+
'GRAY SCALE=Graustufe'#13+
'PERFORMANCE=Erscheinung'#13+
'QUALITY=Qualität'#13+
'SPEED=Schnell'#13+
'COMPRESSION LEVEL=Kompressionsgrad'#13+
'CHART TOOLS GALLERY=Chart Tools Gallerie'#13+
'ANNOTATION=Achspfeile'#13+
'AXIS ARROWS=Annotation'#13+
'COLOR BAND=Bild'#13+
'COLOR LINE=Cursor'#13+
'CURSOR=Drehen'#13+
'DRAG MARKS=Farbbreite'#13+
'DRAW LINE=Farbige Linie'#13+
'IMAGE=Linie zeichnen'#13+
'MARK TIPS=Markiere Tips'#13+
'NEAREST POINT=Nächster Punkt'#13+
'ROTATE=Zieh Marks'#13+
'CHART TOOLS GALLERY=Chart Tools Gallerie'#13+
'BRUSH=Schraffur'#13+
'DRAWING MODE=Zeichenmodus'#13+
'WIREFRAME=Drahtnetz'#13+
'SMOOTH PALETTE=Farbfluß'#13+
'SIDE BRUSH=Schraffur Seiten'#13+
'YES=Ja'#13
;
  end;
end;

Procedure TeeSetIcelandic;
begin
  TeeCreateIcelandic;
  TeeLanguage:=TeeIcelandicLanguage;
  TeeIcelandicConstants;
end;

initialization
finalization
  FreeAndNil(TeeIcelandicLanguage);
end.
