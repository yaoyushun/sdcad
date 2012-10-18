{*****************************************}
{   TeeChart Pro                          }
{   Copyright (c) 1995-2004 David Berneda }
{   Constants for Pro components          }
{*****************************************}
unit TeeProCo;
{$I TeeDefs.inc}

interface

var
  TeeMsg_GalleryPolar,
  TeeMsg_GalleryCandle,
  TeeMsg_GalleryVolume,      
  TeeMsg_GallerySurface,     
  TeeMsg_GalleryContour,     
  TeeMsg_GalleryBezier,
  TeeMsg_GalleryPoint3D,     
  TeeMsg_GalleryRadar,       
  TeeMsg_GalleryDonut,       
  TeeMsg_GalleryCursor,      
  TeeMsg_GalleryBar3D,       
  TeeMsg_GalleryBigCandle,
  TeeMsg_GalleryLinePoint,   
  TeeMsg_GalleryHistogram,   
  TeeMsg_GalleryWaterFall,
  TeeMsg_GalleryWindRose,
  TeeMsg_GalleryClock,       
  TeeMsg_GalleryColorGrid,   
  TeeMsg_GalleryBoxPlot,     
  TeeMsg_GalleryHorizBoxPlot,
  TeeMsg_GalleryBarJoin,     
  TeeMsg_GallerySmith,       
  TeeMsg_GalleryPyramid,     
  TeeMsg_GalleryMap,         

  TeeMsg_PolyDegreeRange,    
  TeeMsg_AnswerVectorIndex,  
  TeeMsg_FittingError,       
  TeeMsg_PeriodRange,        
  TeeMsg_ExpAverageWeight,   
  TeeMsg_GalleryErrorBar,    
  TeeMsg_GalleryError,       
  TeeMsg_GalleryHighLow,     
  TeeMsg_FunctionMomentum,
  TeeMsg_FunctionMomentumDiv,
  TeeMsg_FunctionExpAverage, 
  TeeMsg_FunctionMovingAverage,
  TeeMsg_FunctionExpMovAve,   
  TeeMsg_FunctionRSI,         
  TeeMsg_FunctionCurveFitting,
  TeeMsg_FunctionTrend,       
  TeeMsg_FunctionExpTrend,    
  TeeMsg_FunctionLogTrend,    
  TeeMsg_FunctionCumulative,  
  TeeMsg_FunctionStdDeviation,
  TeeMsg_FunctionBollinger,   
  TeeMsg_FunctionRMS,         
  TeeMsg_FunctionMACD,        
  TeeMsg_FunctionStochastic,  
  TeeMsg_FunctionADX,         

  TeeMsg_FunctionCount,
  TeeMsg_LoadChart,
  TeeMsg_SaveChart,
  TeeMsg_TeeFiles,

  TeeMsg_GallerySamples,
  TeeMsg_GalleryStats,

  TeeMsg_CannotFindEditor,

  TeeMsg_ValuesDate,
  TeeMsg_ValuesOpen,          
  TeeMsg_ValuesHigh,          
  TeeMsg_ValuesLow,           
  TeeMsg_ValuesClose,         
  TeeMsg_ValuesOffset,        
  TeeMsg_ValuesStdError,      

  TeeMsg_Grid3D,

  TeeMsg_LowBezierPoints,

  { TeeCommander component... }

  TeeCommanMsg_Normal,
  TeeCommanMsg_Edit,     
  TeeCommanMsg_Print,    
  TeeCommanMsg_Copy,     
  TeeCommanMsg_Save,     
  TeeCommanMsg_3D,       

  TeeCommanMsg_Rotating,
  TeeCommanMsg_Rotate,   

  TeeCommanMsg_Moving,
  TeeCommanMsg_Move,     

  TeeCommanMsg_Zooming,
  TeeCommanMsg_Zoom,     

  TeeCommanMsg_Depthing,
  TeeCommanMsg_Depth,

  TeeCommanMsg_Chart,
  TeeCommanMsg_Panel,   

  TeeCommanMsg_RotateLabel,
  TeeCommanMsg_MoveLabel,
  TeeCommanMsg_ZoomLabel, 
  TeeCommanMsg_DepthLabel, 

  TeeCommanMsg_NormalLabel,
  TeeCommanMsg_NormalPieLabel,

  TeeCommanMsg_PieExploding,

  TeeMsg_TriSurfaceLess,
  TeeMsg_TriSurfaceAllColinear,
  TeeMsg_TriSurfaceSimilar,
  TeeMsg_GalleryTriSurface,

  TeeMsg_AllSeries,
  TeeMsg_Edit,

  TeeMsg_GalleryFinancial,

  TeeMsg_CursorTool,
  TeeMsg_DragMarksTool,
  TeeMsg_AxisArrowTool,
  TeeMsg_DrawLineTool,  
  TeeMsg_NearestTool,   
  TeeMsg_ColorBandTool, 
  TeeMsg_ColorLineTool, 
  TeeMsg_RotateTool,    
  TeeMsg_ImageTool,     
  TeeMsg_MarksTipTool,  
  TeeMsg_AnnotationTool,

  TeeMsg_CantDeleteAncestor,

  TeeMsg_Load,

  { TeeChart Actions }
  TeeMsg_CategoryChartActions,
  TeeMsg_CategorySeriesActions, 

  TeeMsg_Action3D,
  TeeMsg_Action3DHint,           
  TeeMsg_ActionSeriesActive,
  TeeMsg_ActionSeriesActiveHint, 
  TeeMsg_ActionEditHint,
  TeeMsg_ActionEdit,        
  TeeMsg_ActionCopyHint,         
  TeeMsg_ActionCopy,             
  TeeMsg_ActionPrintHint,        
  TeeMsg_ActionPrint,            
  TeeMsg_ActionAxesHint,         
  TeeMsg_ActionAxes,             
  TeeMsg_ActionGridsHint,        
  TeeMsg_ActionGrids,            
  TeeMsg_ActionLegendHint,       
  TeeMsg_ActionLegend,           
  TeeMsg_ActionSeriesEditHint,   
  TeeMsg_ActionSeriesMarksHint,  
  TeeMsg_ActionSeriesMarks,      
  TeeMsg_ActionSaveHint,         
  TeeMsg_ActionSave,

  TeeMsg_CandleBar,
  TeeMsg_CandleNoOpen,           
  TeeMsg_CandleNoClose,          
  TeeMsg_NoHigh,                 
  TeeMsg_NoLow,                  
  TeeMsg_ColorRange,             
  TeeMsg_WireFrame,              
  TeeMsg_DotFrame,               
  TeeMsg_Positions,              
  TeeMsg_NoGrid,                 
  TeeMsg_NoPoint,                
  TeeMsg_NoLine,                 
  TeeMsg_Labels,                 
  TeeMsg_NoCircle,               
  TeeMsg_Lines,                  
  TeeMsg_Border,                 

  TeeMsg_SmithResistance,
  TeeMsg_SmithReactance,       
  
  TeeMsg_Column,

  { 5.01 }
  TeeMsg_Separator,
  TeeMsg_FunnelSegment,        
  TeeMsg_FunnelSeries,         
  TeeMsg_FunnelPercent,        
  TeeMsg_FunnelExceed,         
  TeeMsg_FunnelWithin,         
  TeeMsg_FunnelBelow,          
  TeeMsg_CalendarSeries,       
  TeeMsg_DeltaPointSeries,     
  TeeMsg_ImagePointSeries,     
  TeeMsg_ImageBarSeries,       
  TeeMsg_SeriesTextFieldZero,  

  { 5.02 }
  TeeMsg_Origin,
  TeeMsg_Transparency,
  TeeMsg_Box,		      
  TeeMsg_ExtrOut,
  TeeMsg_MildOut,	      
  TeeMsg_PageNumber,
  TeeMsg_TextFile,

  { 5.03 }
  TeeMsg_DragPoint,
  TeeMsg_OpportunityValues,
  TeeMsg_QuoteValues,

  { 6.0 }
  TeeMsg_FunctionSmooth,
  TeeMsg_FunctionCross,
  TeeMsg_GridTranspose,
  TeeMsg_FunctionCompress,
  TeeMsg_ExtraLegendTool,
  TeeMsg_FunctionCLV,
  TeeMsg_FunctionOBV,
  TeeMsg_FunctionCCI,
  TeeMsg_FunctionPVO,
  TeeMsg_SeriesAnimTool,
  TeeMsg_GalleryPointFigure,
  TeeMsg_Up,
  TeeMsg_Down,
  TeeMsg_GanttTool,
  TeeMsg_XMLFile,
  TeeMsg_GridBandTool,
  TeeMsg_FunctionPerf,
  TeeMsg_GalleryGauge,
  TeeMsg_GalleryGauges,
  TeeMsg_ValuesVectorEndZ,
  TeeMsg_GalleryVector3D,
  TeeMsg_Gallery3D,
  TeeMsg_GalleryTower,
  TeeMsg_SingleColor,
  TeeMsg_Cover,
  TeeMsg_Cone,
  TeeMsg_PieTool,

  // 7.0
  TeeMsg_Stop,
  TeeMsg_Execute,
  TeeMsg_Themes,
  TeeMsg_LightTool,
  TeeMsg_Current,
  TeeMsg_FunctionCorrelation,
  TeeMsg_FunctionVariance,
  TeeMsg_GalleryBubble3D,
  TeeMsg_GalleryHorizHistogram,
  TeeMsg_FunctionPerimeter,
  TeeMsg_SurfaceNearestTool,
  TeeMsg_AxisScrollTool,
  TeeMsg_RectangleTool,
  TeeMsg_GalleryPolarBar,
  TeeMsg_AsWapBitmap,
  TeeMsg_WapBMPFilter,
  TeeMsg_ClipSeries,
  TeeMsg_SeriesBandTool

   : String;

Procedure TeeSetEnglish;

implementation

Uses TeeConst;

Procedure TeeSetProConstants;
begin
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
  TeeMsg_GalleryColorGrid   :='Color Grid';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horizontal'#13'BoxPlot';
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
  TeeMsg_FunctionMomentumDiv :='Momentum'#13'Division';
  TeeMsg_FunctionExpAverage  :='Exponential'#13'Average';
  TeeMsg_FunctionMovingAverage:='Moving'#13'Average';
  TeeMsg_FunctionExpMovAve   :='Exp.Moving'#13'Average';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exponential'#13'Trend';
  TeeMsg_FunctionLogTrend    :='Logarithmic'#13'Trend';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='Standard'#13'Deviation';
  TeeMsg_FunctionBollinger   :='Bollinger'#13'bands';
  TeeMsg_FunctionRMS         :='Root Mean'#13'Square';
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
  TeeMsg_TriSurfaceSimilar     :='Similar XYZ points. Cannot calculate triangles.';
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

  // 7.0
  TeeMsg_Stop                 :='Stop';
  TeeMsg_Execute              :='Execute !';
  TeeMsg_Themes               :='Themes';
  TeeMsg_LightTool            :='2D Lighting';
  TeeMsg_Current              :='Current';
  TeeMsg_FunctionCorrelation  :='Correlation';
  TeeMsg_FunctionVariance     :='Variance';
  TeeMsg_GalleryBubble3D      :='Bubble 3D';
  TeeMsg_GalleryHorizHistogram:='Horizontal'#13'Histogram';
  TeeMsg_FunctionPerimeter    :='Perimeter';
  TeeMsg_SurfaceNearestTool   :='Surface Nearest';
  TeeMsg_AxisScrollTool       :='Axis Scroll';
  TeeMsg_RectangleTool        :='Rectangle';
  TeeMsg_GalleryPolarBar      :='Polar Bar';
  TeeMsg_AsWapBitmap          :='Wap Bitmap';
  TeeMsg_WapBMPFilter         :='Wap Bitmaps (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='Clip Series';
  TeeMsg_SeriesBandTool       :='Series Band';
end;

Procedure TeeSetEnglish;
begin
  TeeLanguage:=TeeEnglishLanguage;
  TeeSetConstants;
  TeeSetProConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
  TeeSetProConstants;
end.

