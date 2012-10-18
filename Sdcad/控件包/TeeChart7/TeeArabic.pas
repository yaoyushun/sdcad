unit TeeArabic;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeArabicLanguage:TStringList=nil;

Procedure TeeSetArabic;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeArabicConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='«·ﬁÌ„… «·«Ê·Ï ·Ê”Ì·… «Ì÷«Õ  ÌÃ» «‰  ﬂÊ‰> 0';
  TeeMsg_LegendColorWidth   :='⁄—÷ «··Ê‰ ·Ê”Ì·… «Ì÷«Õ ÌÃ» «‰ ÌﬂÊ‰ > 0%';
  TeeMsg_SeriesSetDataSource:='·«ÌÊÃœ —”„… ·„—«Ã⁄… „’œ— «·»Ì«‰« ';
  TeeMsg_SeriesInvDataSource:='€Ì— „Õœœ… „’œ— «·»Ì«‰« : %s';
  TeeMsg_FillSample         :='«·ﬁÌ„ «·„œŒ·… ÌÃ» «‰  ﬂÊ‰ > 0';
  TeeMsg_AxisLogDateTime    :='„ÕÊ—«· «—ÌŒ ÌÃ» «·« ÌﬂÊ‰ ·Ê€«—Ì „Ï';
  TeeMsg_AxisLogNotPositive :='«·Õœ «·«⁄·Ï Ê «·«œ‰Ï ··„ÕÊ— «··Ê€«—Ì „Ï ÌÃ» «‰ ÌﬂÊ‰ >= 0';
  TeeMsg_AxisLabelSep       :='›Ê«’· ⁄‰«ÊÌ‰ % ÌÃ» «‰ ÌﬂÊ‰ 0';
  TeeMsg_AxisIncrementNeg   :='«·“Ì«œ… ›Ï «·„ÕÊ— ÌÃ» «‰ ÌﬂÊ‰ >= 0';
  TeeMsg_AxisMinMax         :='«·Õœ «·«œ‰Ï ··„ÕÊ— ÌÃ» «‰ ÌﬂÊ‰ <= «·Õœ «·«⁄·Ï';
  TeeMsg_AxisMaxMin         :='«·Õœ «·«œ‰Ï ··„ÕÊ— ÌÃ» «‰ ÌﬂÊ‰ <= «·Õœ «·«⁄·Ï';
  TeeMsg_AxisLogBase        :='„ÕÊ— «”«” «··Ê€«—Ì „  ÌÃ» «‰ ÌﬂÊ‰ >= 2';
  TeeMsg_MaxPointsPerPage   :='«·Õœ «·«⁄·Ï ··‰ﬁ«ÿ »«·’›Õ…  ÌÃ» «‰ ÌﬂÊ‰ >= 0';
  TeeMsg_3dPercent          :='3D  √ÀÌ—  ÌÃ» «‰ ÌﬂÊ‰ »Ì‰ %d Ê %d';
  TeeMsg_CircularSeries     :='  €Ì— „”„ÊÕ »«·”·«”· «·„— »ÿ… «·„⁄«œ „—Ã⁄Ì Â« ';
  TeeMsg_WarningHiColor     :='16k ·Ê‰ «Ê «ﬂÀ— ··Õ’Ê· ⁄·Ï «›÷· ‘ﬂ·';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='⁄‰Ê«‰ «·„ÕÊ— ';
  TeeMsg_AxisLabels         :='«”„«¡ «·„ÕÊ— ';
  TeeMsg_RefreshInterval    :='Refresh Interval must be between 0 and 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart is not myself!';
  TeeMsg_GalleryLine        :='Œÿ';
  TeeMsg_GalleryPoint       :='‰ﬁÿ…';
  TeeMsg_GalleryArea        :='„”«Õ…';
  TeeMsg_GalleryBar         :='‘—ÌÿÏ';
  TeeMsg_GalleryHorizBar    :='«›ﬁÏ ‘—ÌÿÏ';
  TeeMsg_Stack              :='«·Ê«‰ „ —«’›Â';
  TeeMsg_GalleryPie         :='œ«∆—Ï';
  TeeMsg_GalleryCircled     :='œ«∆—Ï';
  TeeMsg_GalleryFastLine    :='Œÿ ”—Ì⁄';
  TeeMsg_GalleryHorizLine   :='Œÿ «›ﬁÏ';

  TeeMsg_PieSample1         :='”Ì«—« ';
  TeeMsg_PieSample2         :='ÂÊ« ›';
  TeeMsg_PieSample3         :='Ãœ«Ê·';
  TeeMsg_PieSample4         :='‘«‘« ';
  TeeMsg_PieSample5         :='„’«»ÌÕ';
  TeeMsg_PieSample6         :='·ÊÕ«  „›« ÌÕ';
  TeeMsg_PieSample7         :='œ—«Ã« ';
  TeeMsg_PieSample8         :='ﬂ—«”Ï';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :=' Õ—Ì— %s';

  TeeMsg_GalleryStandard    :='ﬁÌ«”Ï';
  TeeMsg_GalleryExtended    :='„Õ”‰';
  TeeMsg_GalleryFunctions   :='œ«·…';

  TeeMsg_EditChart          :=' &Õ—Ì— «·—”„ «·»Ì«‰Ï...';
  TeeMsg_PrintPreview       :='&⁄—÷ «·ÿ»«⁄…...';
  TeeMsg_ExportChart        :=' ’œÌ— «·—”„ «·»Ì«‰Ï...';
  TeeMsg_CustomAxes         :='„Õ«Ê— „Œ’’… ..';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: has no Editor Dialog';

  TeeMsg_GalleryArrow       :='”Â„';

  TeeMsg_ExpFinish          :='&«‰Â«¡';
  TeeMsg_ExpNext            :='&«· «·Ï >';

  TeeMsg_GalleryGantt       :='—”„… Ã«‰ ';

  TeeMsg_GanttSample1       :=' ’„Ì„';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :=' ÿÊÌ—';
  TeeMsg_GanttSample4       :='„»Ì⁄« ';
  TeeMsg_GanttSample5       :=' ”ÊÌﬁ';
  TeeMsg_GanttSample6       :=' Ã—»…';
  TeeMsg_GanttSample7       :='’‰«⁄Ï';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='‰”Œ… ÃœÌœ…';
  TeeMsg_GanttSample10      :='»‰Êﬂ';

  TeeMsg_ChangeSeriesTitle  :=' €ÌÌ—  ⁄‰Ê«‰ „”·”· ';
  TeeMsg_NewSeriesTitle     :='⁄‰Ê«‰ „”·”· ÃœÌœ :';
  TeeMsg_DateTime           :='«· «—ÌŒ';
  TeeMsg_TopAxis            :='„ÕÊ— «⁄·Ï ';
  TeeMsg_BottomAxis         :='„ÕÊ— «”›· ';
  TeeMsg_LeftAxis           :='„ÕÊ— ‘„«· ';
  TeeMsg_RightAxis          :='„ÕÊ— Ì„Ì‰ ';

  TeeMsg_SureToDelete       :='Õ–› %s ?';
  TeeMsg_DateTimeFormat     :='‘ﬂ· «· «—ÌŒ:';
  TeeMsg_Default            :='«› —«÷Ï';
  TeeMsg_ValuesFormat       :=' ‰”Ìﬁ «·«—ﬁ«„:';
  TeeMsg_Maximum            :='«·⁄Ÿ„Ï';
  TeeMsg_Minimum            :='«·’€—Ï';
  TeeMsg_DesiredIncrement   :='«·„ÿ·Ê»… %s «·“Ì«œ… ';

  TeeMsg_IncorrectMaxMinValue:='«·ﬁÌ„… €Ì— ’ÕÌÕ… .»”»»: %s';
  TeeMsg_EnterDateTime      :='«œŒ· [⁄œœ «·«Ì«„] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='‰›– «· ⁄œÌ·«  ?';
  TeeMsg_SelectedSeries     :='(«Œ «— «·”·”·Â)';
  TeeMsg_RefreshData        :='&Refresh Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='«÷«›Â';
  TeeMsg_FunctionSubtract   :='ÿ—Õ';
  TeeMsg_FunctionMultiply   :='÷—»';
  TeeMsg_FunctionDivide     :='ﬁ”„…';
  TeeMsg_FunctionHigh       :='«·«⁄·Ï';
  TeeMsg_FunctionLow        :='«·«œ‰Ï';
  TeeMsg_FunctionAverage    :='«·„ Ê”ÿ';

  TeeMsg_GalleryShape       :='«‘ﬂ«·';
  TeeMsg_GalleryBubble      :='›ﬁ«⁄Ï';
  TeeMsg_FunctionNone       :='‰”Œ';

  TeeMsg_None               :='(›«—€)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='·«»œ «‰ ÌﬂÊ‰ «ﬂ»— „‰Pointer ÕÃ„  zero';
  TeeMsg_About              :='ÕÊ&· TeeChart...';

  tcAdditional              :='«÷«›Ï';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='”Ã· Ê«Õœ';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='œ«·… › —… ·«»œ «‰  ﬂÊ‰  >= 0';

  TeeMsg_WizardTab          :='Business';
  TeeMsg_TeeChartWizard     :='TeeChart „”«⁄œ';

  TeeMsg_ClearImage         :='Õ–›';
  TeeMsg_BrowseImage        :='«” ⁄—«&÷...';

  TeeMsg_WizardSureToClose  :='”Ê› Ì „ «€·«ﬁ TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='«·Õﬁ·  %s €Ì— „ÊÃÊœ ';

  TeeMsg_DepthAxis          :='„ÕÊ— «·⁄„ﬁ ';
  TeeMsg_PieOther           :='«Œ—Ì';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='œ«∆—Ï';
  TeeMsg_ValuesBar          :='‘—ÌÿÏ';
  TeeMsg_ValuesAngle        :='«·“«ÊÌÂ';
  TeeMsg_ValuesGanttStart   :='«·»œ«Ì…';
  TeeMsg_ValuesGanttEnd     :='«·‰Â«Ì…';
  TeeMsg_ValuesGanttNextTask:='«·„Â„… «· «·Ì…';
  TeeMsg_ValuesBubbleRadius :='«·ﬁÿ—';
  TeeMsg_ValuesArrowEndX    :='‰Â«Ì… X';
  TeeMsg_ValuesArrowEndY    :='‰Â«Ì… Y';
  TeeMsg_Legend             :='„› «Õ «·—”„';
  TeeMsg_Title              :='⁄‰Ê«‰';
  TeeMsg_Foot               :=' –ÌÌ· ';
  TeeMsg_Period		    :='› —…';
  TeeMsg_PeriodRange        :='› —… „œÏ';
  TeeMsg_CalcPeriod         :='«Õ”»  %s  ﬂ· :';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid «·—”„ «·»Ì«‰Ï in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.'+TeeMsg_TeeExtension+' file format';
  TeeMsg_EmptyTeeFile       :='Empty *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '„ÕÊ— «·—”„';
  TeeMsg_ChartAxesCategoryDesc   := '«·—”„ «·»Ì«‰Ï Axes properties and events';
  TeeMsg_ChartWallsCategoryName  := '«·—”„ «·»Ì«‰Ï Walls';
  TeeMsg_ChartWallsCategoryDesc  := '«·—”„ «·»Ì«‰Ï Walls properties and events';
  TeeMsg_ChartTitlesCategoryName := '⁄‰«ÊÌ‰ «·—”„';
  TeeMsg_ChartTitlesCategoryDesc := '«·—”„ «·»Ì«‰Ï Titles properties and events';
  TeeMsg_Chart3DCategoryName     := '«·—”„ «·»Ì«‰Ï 3D';
  TeeMsg_Chart3DCategoryDesc     := '«·—”„ «·»Ì«‰Ï 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='„Œ’’… ';
  TeeMsg_Series                 :='”·”·…';
  TeeMsg_SeriesList             :='”·”·…...';

  TeeMsg_PageOfPages            :='«·’›Õ… —ﬁ„ %d „‰ %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='«·«Ê·';
  TeeMsg_Prior  :='«·”«»ﬁ';
  TeeMsg_Next   :='«· «·Ï';
  TeeMsg_Last   :='«·«ŒÌ—';
  TeeMsg_Insert :='«÷«›Â';
  TeeMsg_Delete :='Õ–›';
  TeeMsg_Edit   :=' Õ—Ì—';
  TeeMsg_Post   :='Õ›Ÿ';
  TeeMsg_Cancel :='«·€«¡';

  TeeMsg_All    :='(«·ﬂ·)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '·ÊÕ… property is not set in Export  ’„Ì„';

  TeeMsg_Normal    :='ÿ»Ì⁄Ï';
  TeeMsg_NoBorder  :='·« «ÿ«—';
  TeeMsg_Dotted    :='„‰ﬁÿ';
  TeeMsg_Colors    :='«·Ê«‰';
  TeeMsg_Filled    :='„„·Ê¡';
  TeeMsg_Marks     :='⁄·«„« ';
  TeeMsg_Stairs    :='Stairs';
  TeeMsg_Points    :='‰ﬁ«ÿ';
  TeeMsg_Height    :='«— ›«⁄';
  TeeMsg_Hollow    :='„›—€';
  TeeMsg_Point2D   :='‰ﬁÿ… 2D';
  TeeMsg_Triangle  :='„À·À';
  TeeMsg_Star      :='‰Ã„…';
  TeeMsg_Circle    :='œ«∆—…';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='Cross';
  TeeMsg_Diamond   :='Diamond';
  TeeMsg_NoLines   :='»œÊ‰ ŒÿÊÿ';
  TeeMsg_Stack100  :='„ —«’›Â 100%';
  TeeMsg_Pyramid   :='Â—„Ï';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Â—„ „ﬁ·Ê»';
  TeeMsg_Sides     :='ÃÊ«‰»';
  TeeMsg_SideAll   :='ÃÊ«‰» ··ﬂ·';
  TeeMsg_Patterns  :='‰ﬁÊ‘';
  TeeMsg_Exploded  :='„‰ ‘—';
  TeeMsg_Shadow    :='Ÿ·';
  TeeMsg_SemiPie   :='‘»… œ«∆—Ï';
  TeeMsg_Rectangle :='„” ÿÌ·';
  TeeMsg_VertLine  :='Œÿ —√”Ì';
  TeeMsg_HorizLine :='Œÿ «›ﬁÏ';
  TeeMsg_Line      :='Œÿ';
  TeeMsg_Cube      :='„ﬂ⁄»';
  TeeMsg_DiagCross :='Diag.Cross';

  TeeMsg_CanNotFindTempPath    :='·« «” ÿÌ⁄ find Temp folder';
  TeeMsg_CanNotCreateTempChart :='·« «” ÿÌ⁄ create Temp file';
  TeeMsg_CanNotEmailChart      :='·« «” ÿÌ⁄ email TeeChart. Mapi Œÿ√: %d';

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

  { 5.02 }
  TeeMsg_AskLanguage  :='«··&€…...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='‘„⁄…';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='”ÿÕÏ';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='‰ﬁÿ… 3D';
  TeeMsg_GalleryRadar       :='‰”ÌÃÏ';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='‘—ÌÿÏ 3D';
  TeeMsg_GalleryBigCandle   :='Big Candle';
  TeeMsg_GalleryLinePoint   :='Œÿ ‰ﬁÿ…';
  TeeMsg_GalleryHistogram   :='ŒÿÏ „ Ã«‰”';
  TeeMsg_GalleryWaterFall   :='‘·«·« ';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='”«⁄Â';
  TeeMsg_GalleryColorGrid   :='‘»ﬂ… «·Ê«‰';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='‘—ÌÿÏ „ Õœ';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Â—„';
  TeeMsg_GalleryMap         :='Œ—Ìÿ…';

  TeeMsg_PolyDegreeRange    :='œ—Ã… „ ⁄œœ «·ÕœÊœ ÌÃ» «‰ ÌﬂÊ‰ »Ì‰ 1 Ê 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='› —… ÌÃ» «‰ ÌﬂÊ‰ >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='Œÿ√ ‘—ÌÿÏ';
  TeeMsg_GalleryError        :='Œÿ√';
  TeeMsg_GalleryHighLow      :='⁄«·Ï-„‰Œ›÷';
  TeeMsg_FunctionMomentum    :='ﬂ„Ì… «· Õ—ﬂ';
  TeeMsg_FunctionMomentumDiv :='ﬂ„Ì… «· Õ—ﬂ ﬁ”„';
  TeeMsg_FunctionExpAverage  :='Exp. Average';
  TeeMsg_FunctionMovingAverage:='«·„ Ê”ÿ «·„ Õ—ﬂ';
  TeeMsg_FunctionExpMovAve   :='Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :=' —«ﬂ„Ï';
  TeeMsg_FunctionStdDeviation:='«·«‰Õ—«› «·„⁄Ì«—Ï';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='⁄œœ';
  TeeMsg_LoadChart           :='› Õ TeeChart...';
  TeeMsg_SaveChart           :='Õ›Ÿ TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro „·›« ';

  TeeMsg_GallerySamples      :='«Œ—';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='·« «” ÿÌ⁄ «ÌÃ«œ „Õ—— «·”·«”·: %s';


  TeeMsg_CannotLoadChartFromURL:='Œÿ√ code: %d  Õ„Ì· «·—”„ «·»Ì«‰Ï from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Œÿ√ code: %d  Õ„Ì· »Ì«‰«  «·”·”·… „‰ URL: %s';

  TeeMsg_Test                :=' Ã—»…...';

  TeeMsg_ValuesDate          :=' «—ÌŒ';
  TeeMsg_ValuesOpen          :='› Õ';
  TeeMsg_ValuesHigh          :='⁄«·Ï';
  TeeMsg_ValuesLow           :='„‰Œ›÷';
  TeeMsg_ValuesClose         :='«€·«ﬁ';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='Œÿ√ ﬁÌ«”Ï';

  TeeMsg_Grid3D              :='«·‘»ﬂ… 3D';

  TeeMsg_LowBezierPoints     :='Number of Bezier points should be > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='ÿ»Ì⁄Ï';
  TeeCommanMsg_Edit     :=' Õ—Ì—';
  TeeCommanMsg_Print    :='ÿ»«⁄Â';
  TeeCommanMsg_Copy     :='‰”Œ';
  TeeCommanMsg_Save     :='Õ›Ÿ';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :=' œÊÌ—: %d∞ Elevation: %d∞';
  TeeCommanMsg_Rotate   :='œÊ—';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Õ—ﬂ';

  TeeCommanMsg_Zooming  :='«·ﬁÌ«”: %d %%';
  TeeCommanMsg_Zoom     :='«·ﬁÌ«”';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='⁄„ﬁ';

  TeeCommanMsg_Chart    :='«·—”„ «·»Ì«‰Ï';
  TeeCommanMsg_Panel    :='·ÊÕ…';

  TeeCommanMsg_RotateLabel:='«”Õ» %s · œÊ—';
  TeeCommanMsg_MoveLabel  :='«”Õ» %s ··Õ—ﬂ…';
  TeeCommanMsg_ZoomLabel  :='«”Õ» %s · €ÌÌ— «·„ﬁÌ«”';
  TeeCommanMsg_DepthLabel :='«”Õ» %s · €ÌÌ— «·ÕÃ„  3D';

  TeeCommanMsg_NormalLabel:='«”Õ» Left button to Zoom, Right button to Scroll';
  TeeCommanMsg_NormalPieLabel:='«”Õ» a œ«∆—Ï Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='⁄œœ «·‰ﬁ«ÿ ÌÃ» «‰  ÌﬂÊ‰  >= 4';
  TeeMsg_TriSurfaceAllColinear :='All colinear data points';
  TeeMsg_TriSurfaceSimilar     :='Similar points - cannot execute';
  TeeMsg_GalleryTriSurface     :='„À·À „”ÿÕ';

  TeeMsg_AllSeries :='ﬂ· «·”·«”·';
  TeeMsg_Edit      :=' Õ—Ì—';

  TeeMsg_GalleryFinancial    :='„«·Ï';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='«”Õ» ⁄·«„« ';
  TeeMsg_AxisArrowTool :='„ÕÊ— «·«”Â„';
  TeeMsg_DrawLineTool  :='—”„ Œÿ';
  TeeMsg_NearestTool   :='«ﬁ—»  ‰ﬁÿ…';
  TeeMsg_ColorBandTool :='·Ê‰ «··ÊÕ…';
  TeeMsg_ColorLineTool :='·Ê‰ «·Œÿ';
  TeeMsg_RotateTool    :='ÌœÊ—';
  TeeMsg_ImageTool     :='’Ê—…';
  TeeMsg_MarksTipTool  :='Mark Tips';

  TeeMsg_CantDeleteAncestor  :='·« «” ÿÌ⁄ delete ancestor';

  TeeMsg_Load	          :=' Õ„Ì·...';
  TeeMsg_NoSeriesSelected :='·« ÌÊÃœ ”·«”· „Œ «—…';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='—”„ »Ì«‰Ï';
  TeeMsg_CategorySeriesActions :='”·«”· «·—”„ «·»Ì«‰Ï';

  TeeMsg_Action3D               := '&À·«ÀÏ «·«»⁄«œ';
  TeeMsg_Action3DHint           := '«· ÕÊÌ· »Ì‰ 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&‰‘ÿ';
  TeeMsg_ActionSeriesActiveHint := '«ŸÂ«—\«Œ›«¡ «·”·”·…';
  TeeMsg_ActionEditHint         := ' Õ—Ì— «·—”„ «·»Ì«‰Ï';
  TeeMsg_ActionEdit             := '& Õ—Ì—...';
  TeeMsg_ActionCopyHint         := '‰”Œ';
  TeeMsg_ActionCopy             := '&‰”Œ';
  TeeMsg_ActionPrintHint        := '⁄—÷ «·ÿ»«⁄… «·—”„ «·»Ì«‰Ï';
  TeeMsg_ActionPrint            := '&ÿ»«⁄Â...';
  TeeMsg_ActionAxesHint         := '«ŸÂ«—\«Œ›«¡ «·„ÕÊ—';
  TeeMsg_ActionAxes             := '&„ÕÊ—';
  TeeMsg_ActionGridsHint        := '«ŸÂ«—\«Œ›«¡ «·‘»ﬂ…';
  TeeMsg_ActionGrids            := '&«·‘»ﬂ…';
  TeeMsg_ActionLegendHint       := '«ŸÂ«—\«Œ›«¡  „› «Õ «·—”„';
  TeeMsg_ActionLegend           := '&„› «Õ «·—”„';
  TeeMsg_ActionSeriesEditHint   := ' Õ—Ì— «·”·”·…';
  TeeMsg_ActionSeriesMarksHint  := '«ŸÂ«—\«Œ›«¡  ⁄·«„«  «·”·”·…';
  TeeMsg_ActionSeriesMarks      := '&⁄·«„« ';
  TeeMsg_ActionSaveHint         := 'Õ›Ÿ «·—”„ «·»Ì«‰Ï';
  TeeMsg_ActionSave             := '&Õ›Ÿ...';

  TeeMsg_CandleBar              := '‘—ÌÿÏ';
  TeeMsg_CandleNoOpen           := 'No Open';
  TeeMsg_CandleNoClose          := 'No Close';
  TeeMsg_NoLines                := 'No Lines';
  TeeMsg_NoHigh                 := 'No High';
  TeeMsg_NoLow                  := 'No Low';
  TeeMsg_ColorRange             := '·Ê‰ „œÏ';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := '„Ê«ﬁ⁄';
  TeeMsg_NoGrid                 := '»·« ‘»ﬂ…';
  TeeMsg_NoPoint                := '»·« ‰ﬁÿ…';
  TeeMsg_NoLine                 := '»·« Œÿ';
  TeeMsg_Labels                 := '⁄‰«ÊÌ‰';
  TeeMsg_NoCircle               := '»·« œ«∆—…';
  TeeMsg_Lines                  := 'ŒÿÊÿ';
  TeeMsg_Border                 := '«ÿ«—';

  TeeMsg_SmithResistance      := '„ﬁ«Ê„…';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := '⁄„Êœ';

  { 5.01 }
  TeeMsg_Separator            := '›«’·';
  TeeMsg_FunnelSegment        := 'ﬁÿ«⁄ ';
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
  TeeMsg_Origin               := '«·«’·';
  TeeMsg_Transparency         := '‘›«›';
  //TeeMsg_InvertedScroll       := ' „—Ì— „⁄ﬂÊ”';
  TeeMsg_Box		      := '’‰œÊﬁ';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '—ﬁ„ «·’›Õ…';
end;

Procedure TeeCreateArabic;
begin
  if not Assigned(TeeArabicLanguage) then
  begin
    TeeArabicLanguage:=TStringList.Create;
    TeeArabicLanguage.Text:=

'LABELS=«·⁄‰«ÊÌ‰'+#13+
'DATASET=ﬁ«⁄œ… «·»Ì«‰« '+#13+
'ALL RIGHTS RESERVED.=Ã„Ì⁄ «·ÕﬁÊﬁ „Õ›ÊŸ….'+#13+
'APPLY=‰›–'+#13+
'CLOSE=«€·«ﬁ'+#13+
'OK=„Ê«›ﬁ'+#13+
'ABOUT TEECHART PRO V7.0=ÕÊ· TeeChart Pro v7.0'+#13+
'OPTIONS=«Œ Ì«—« '+#13+
'FORMAT= ‰”Ìﬁ'+#13+
'TEXT=‰Û’'+#13+
'GRADIENT= œ—Ã «·«·Ê«‰'+#13+
'SHADOW=Ÿ·'+#13+
'POSITION=„Êﬁ⁄'+#13+
'LEFT=‘„«·'+#13+
'TOP=«⁄·Ï'+#13+
'CUSTOM=„Œ’’…'+#13+
'PEN=«·ﬁ·„'+#13+
'PATTERN=‰ﬁ‘'+#13+
'SIZE=ÕÃ„'+#13+
'BEVEL=Marco'+#13+
'INVERTED=„⁄ﬂÊ”'+#13+
'BORDER=«ÿ«—'+#13+
'ORIGIN=«·«’·'+#13+
'USE ORIGIN=«” Œœ«„ «·«’·'+#13+
'AREA LINES=Œÿ „”«Õ…'+#13+
'AREA=„”«Õ…'+#13+
'COLOR=«··Ê‰'+#13+
'SERIES=”·”·„'+#13+
'SUM=„Ã„Ê⁄'+#13+
'DAY=«·ÌÊ„'+#13+
'QUARTER=—»⁄ ”‰…'+#13+
'(MAX)=(«·⁄Ÿ„Ï)'+#13+
'(MIN)=(«·’€—Ï)'+#13+
'VISIBLE=Ÿ«Â—'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=⁄«„'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Œÿ «›ﬁÏ'+#13+
'LABEL AND PERCENT=⁄‰Ê«‰ y «·‰”»…'+#13+
'LABEL AND VALUE=⁄‰Ê«‰ y «·ﬁÌ„…'+#13+
'LABEL AND PERCENT TOTAL=⁄‰Ê«‰ y «·‰”»… «·«Ã„«·Ì…'+#13+
'PERCENT TOTAL=«Ã„«·Ï «·‰”»…'+#13+
'MSEC.=«Œ—Ï'+#13+
'SUBTRACT=ÿ—Õ'+#13+
'MULTIPLY=÷—»'+#13+
'DIVIDE=ﬁ”„…'+#13+
'STAIRS=”·„Ï'+#13+
'MOMENTUM=ﬂ„Ì… «· Õ—ﬂ'+#13+
'AVERAGE=«·„ Ê”ÿ'+#13+
'XML=XML'+#13+
'HTML TABLE=ÃœÊ· HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=›«—€'+#13+
'(NONE)= ›«—€'#13+
'WIDTH=«·⁄—÷'+#13+
'HEIGHT=«·ÿÊ·'+#13+
'COLOR EACH=«··Ê‰ ·ﬂ·'+#13+
'STACK=„ —«’'+#13+
'STACKED=„ —«’'+#13+
'STACKED 100%=„ —«’ 100%'+#13+
'AXIS=„ÕÊ—'+#13+
'LENGTH=«·ÿÊ·'+#13+
'CANCEL=«·€«¡'+#13+
'SCROLL= „—Ì—'+#13+
'INCREMENT=“Ì«œ…'+#13+
'VALUE=«·ﬁÌ„…'+#13+
'STYLE=‰„ÿ'+#13+
'JOIN=Ì Õœ'+#13+
'AXIS INCREMENT= “«ÌœÏ „ÕÊ—'+#13+
'AXIS MAXIMUM AND MINIMUM=«·Õœ «·«⁄·Ï Ê «·«œ‰Ï ··„ÕÊ—'+#13+
'% BAR WIDTH=⁄—÷ ‘—ÌÿÏ %'+#13+
'% BAR OFFSET=„ﬂ«‰ ‘—ÌÿÏ %'+#13+
'BAR SIDE MARGINS=ÂÊ«„‘ Ã«‰»Ì…'+#13+
'AUTO MARK POSITION=⁄·„ «·„Êﬁ⁄  ·ﬁ«∆Ì«.'+#13+
'DARK BAR 3D SIDES=‘—ÌÿÏ €«„ﬁ 3D'+#13+
'MONOCHROME=«Õ«œÏ «··Ê‰'+#13+
'COLORS=«·«·Ê«‰'+#13+
'DEFAULT=«› —«÷Ï'+#13+
'MEDIAN=«·Ê”Ìÿ'+#13+
'IMAGE=«·’Ê—…'+#13+
'DAYS=«·«Ì«„'+#13+
'WEEKDAYS=«Ì«„ «·«”»Ê⁄'+#13+
'TODAY=«·ÌÊ„'+#13+
'SUNDAY=«·«Õœ'+#13+
'MONTHS=«·‘ÂÊ—'+#13+
'LINES=«·ŒÿÊÿ'+#13+
'UPPERCASE=Õ—Ê› ﬂ»Ì—…'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=⁄—÷ «·‘„⁄Â'+#13+
'BAR=‘—ÌÿÏ'+#13+
'OPEN CLOSE=› Õ\«€·«ﬁ'+#13+
'DRAW 3D=—”„ 3D'+#13+
'DARK 3D=€«„ﬁ 3D'+#13+
'SHOW OPEN=⁄—÷ „› ÊÕ'+#13+
'SHOW CLOSE=⁄—÷ „€·ﬁ'+#13+
'UP CLOSE=„€·ﬁ «⁄·Ï'+#13+
'DOWN CLOSE=„€·ﬁ «”›·'+#13+
'CIRCLED=œ«∆—Ï'+#13+
'CIRCLE=œ«∆—…'+#13+
'3 DIMENSIONS=3 Dimensiones'+#13+
'ROTATION=ÌœÊ—'+#13+
'RADIUS=ﬁÿ—'+#13+
'HOURS=”«⁄« '+#13+
'HOUR=”«⁄…'+#13+
'MINUTES=œﬁÌﬁ…'+#13+
'SECONDS=À«‰Ì…'+#13+
'FONT=»‰ÿ'+#13+
'INSIDE=œ«Œ·Ï'+#13+
'ROTATED=œ«∆—Ï'+#13+
'ROMAN=—Ê„«‰Ï'+#13+
'TRANSPARENCY=‘›«›'+#13+
'DRAW BEHIND=—”„ ›Ï «·Œ·›'+#13+
'RANGE=„œÏ'+#13+
'PALETTE=‰ﬁ‘'+#13+
'STEPS=ŒÿÊ« '+#13+
'GRID=‘»ﬂ…'+#13+
'GRID SIZE=ÕÃ„ «·‘»ﬂ…'+#13+
'ALLOW DRAG=„”„ÊÕ »«·”Õ»'+#13+
'AUTOMATIC= ·ﬁ«∆Ï'+#13+
'LEVEL=«·„” ÊÏ'+#13+
'LEVELS POSITION=„Êﬁ⁄ «·„” ÊÏ'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=«” Œœ«„ «·›√—…'+#13+
'TRANSPARENT=‘›«›'+#13+
'ROUND FRAME=“Ê«Ì« „” œÌ—…'+#13+
'FRAME=«ÿ«—'+#13+
'START=«»œ√'+#13+
'END=‰Â«Ì…'+#13+
'MIDDLE=‰’›'+#13+
'NO MIDDLE=»œÊ‰ Ê”ÿ'+#13+
'DIRECTION=«·« Ã«Â'+#13+
'DATASOURCE=„’œ— «·»Ì«‰« '+#13+
'AVAILABLE=„ «Õ'+#13+
'SELECTED=„Œ «—'+#13+
'CALC=„Õ”Ê»'+#13+
'GROUP BY= Ã„Ì⁄ ⁄‰ ÿ—Ìﬁ'+#13+
'OF=„‰'+#13+
'HOLE %=«·›—«€ %'+#13+
'RESET POSITIONS=«·⁄Êœ… ··„Êﬁ⁄ «·«’·Ï'+#13+
'MOUSE BUTTON=«·›√—…'+#13+
'ENABLE DRAWING=«·”„«Õ »«·—”„'+#13+
'ENABLE SELECT=«·”„«Õ «·«Œ Ì«—'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=“«ÊÌ…'+#13+
'ZOOM TEXT=„ﬁÌ«” «·‰’'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=„ﬁÌ«”'+#13+
'ELEVATION=ElevaciÛn'+#13+
'BEHIND=Œ·›'+#13+
'AXES=„ÕÊ—'+#13+
'SCALES=„ﬁÌ«”'+#13+
'TITLE=⁄‰Ê«‰'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=„‰ ’›'+#13+
'CENTER=„‰ ’›'+#13+
'PATTERN COLOR EDITOR=„Õ—— «·‰ﬁÊ‘'+#13+
'START VALUE=ﬁÌ„… ·»œ«Ì…'+#13+
'END VALUE=ﬁÌ„… «·‰Â«Ì…'+#13+
'COLOR MODE=Modo de ·Ê‰'+#13+
'LINE MODE=Modo de Œÿ'+#13+
'HEIGHT 3D=«·«— ›«⁄ 3D'+#13+
'OUTLINE=«·«ÿ«— «·Œ«—ÃÏ'+#13+
'PRINT PREVIEW=„⁄«Ì‰… «·ÿ»«⁄…'+#13+
'ANIMATED=„ Õ—ﬂ'+#13+
'ALLOW=„”„ÊÕ'+#13+
'DASH=„ ﬁÿ⁄'+#13+
'DOT=„‰ﬁÿ'+#13+
'DASH DOT DOT=„ ﬁÿ⁄ „Œÿÿ'+#13+
'PALE=»«Â '+#13+
'STRONG=ﬁÊÏ'+#13+
'WIDTH UNITS=ÊÕœ«  «·⁄—÷'+#13+
'FOOT=œ«∆—Ï'+#13+
'SUBFOOT=–Ì· ›—⁄Ï'+#13+
'SUBTITLE=⁄‰Ê«‰ ›—⁄Ï'+#13+
'leghend=„› «Õ «·—”„'+#13+
'COLON=‰ﬁÿ Ì‰ '+#13+
'AXIS ORIGIN=«·«’· „ÕÊ—'+#13+
'UNITS=ÊÕœ« '+#13+
'PYRAMID=Â—„Ï'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=„ﬂ⁄»'+#13+
'TRIANGLE=„À·À'+#13+
'STAR=‰Ã„…'+#13+
'SQUARE=„—»⁄'+#13+
'DOWN TRIANGLE=„À·À „ﬁ·Ê»'+#13+
'SMALL DOT=‰ﬁ«ÿ ’€Ì—…'+#13+
'LOAD= Õ„Ì·'+#13+
'FILE=„·›'+#13+
'RECTANGLE=„” ÿÌ·'+#13+
'HEADER=—«”'+#13+
'CLEAR=›«—€'+#13+
'ONE HOUR=Ê«Õœ… ”«⁄…'+#13+
'ONE YEAR=Ê«Õœ ”‰…'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=„Œ—ÊÿÏ'+#13+
'ARROW=”Â„'+#13+
'CYLLINDER=«”ÿÊ«‰Ï'+#13+
'TIME=Êﬁ '+#13+
'BRUSH=«·›—‘«Â'+#13+
'LINE=Œÿ'+#13+
'VERTICAL LINE=Œÿ —√”Ï'+#13+
'AXIS ARROWS=«”Â„ «·„ÕÊ—'+#13+
'MARK TIPS=Sugerencias'+#13+
'DASH DOT=Œÿ „ ﬁÿ⁄'+#13+
'COLOR BAND=«··ÊÕ…  ·Ê‰'+#13+
'COLOR LINE=«·Œÿ ·Ê‰'+#13+
'INVERT. TRIANGLE=„À·À „ﬁ·Ê»'+#13+
'INVERT. PYRAMID=Â—„ „ﬁ·Ê»'+#13+
'INVERTED PYRAMID=Â—„ „ﬁ·Ê»'+#13+
'SERIES DATASOURCE TEXT EDITOR= „Õ—— ‰’Ê’ «·”·”·…'+#13+
'SOLID=SÛlido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=«ÿ«— „‰ﬁÿ'+#13+
'SIDE BRUSH=«·›—‘«Â «·Ã«‰»Ì…'+#13+
'SIDE=«·Ã«‰»'+#13+
'SIDE ALL=«·ﬂ· ··Ã«‰»'+#13+
'ANNOTATION=«Ì÷«Õ'+#13+
'ROTATE=œÊ—'+#13+
'SMOOTH PALETTE=‰ﬁÊ‘ „ ‰«”ﬁ…'+#13+
'CHART TOOLS GALLERY=GalerÌa de Herramientas'+#13+
'ADD=Ã„⁄'+#13+
'BORDER EDITOR=«ÿ«— «·„Õ——'+#13+
'DRAWING MODE=Modo de Dibujo'+#13+
'CLOSE CIRCLE=œ«∆—… „€·ﬁ…'+#13+
'PICTURE=’Ê—…'+#13+
'NATIVE=Nativo'+#13+
'DATA=»Ì«‰« '+#13+
'KEEP ASPECT RATIO=«·„Õ«›Ÿ… ⁄·Ï ‰”» «·—”„'+#13+
'COPY=‰”Œ'+#13+
'SAVE=Õ›Ÿ'+#13+
'SEND=«—”«·'+#13+
'INCLUDE SERIES DATA= ”·”·… »Ì«‰« '+#13+
'FILE SIZE=ÕÃ„ «·„·›o'+#13+
'INCLUDE=Ì ÷„‰'+#13+
'POINT INDEX=—ﬁ„ «·‰ﬁÿ…'+#13+
'POINT LABELS=⁄‰Ê«‰ «·‰ﬁÿ…'+#13+
'DELIMITER=›«’·'+#13+
'DEPTH=⁄„ﬁ'+#13+
'COMPRESSION LEVEL=„” ÊÏ «·÷€ÿ'+#13+
'COMPRESSION=÷€ÿ'+#13+
'PATTERNS=‰ﬁÊ‘'+#13+
'LABEL=⁄‰Ê«‰'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=„»⁄À— ··«ﬂ»—'+#13+
'TOTAL ANGLE=«·“«ÊÌ… «·ﬂ·Ì…'+#13+
'HORIZ. SIZE=«·ÕÃ„ «·«›ﬁÏ'+#13+
'VERT. SIZE=«·ÕÃ„ «·—√”Ì'+#13+
'SHAPES=«‘ﬂ«·'+#13+
'INFLATE MARGINS=„’€—… ÂÊ«„‘'+#13+
'QUALITY=«·ÃÊœ…'+#13+
'SPEED=«·”—⁄…'+#13+
'% QUALITY=% «·ÃÊœ…'+#13+
'GRAY SCALE=„Ì· «·Ï «·—„«œÏ'+#13+
'PERFORMANCE=«œ«¡'+#13+
'BROWSE=«” ⁄—«÷'+#13+
'TILED= Ã«‰»'+#13+
'HIGH=„— ›⁄'+#13+
'LOW=„‰Œ›÷'+#13+
'DATABASE CHART=ﬁ«⁄œÂ »Ì«‰«  «·—”„ «·»Ì«‰Ï '+#13+
'NON DATABASE CHART=«·—”„ «·»Ì«‰Ï »œÊ‰ ﬁ«⁄œÂ »Ì«‰« '+#13+
'HELP=„”«⁄œÂ'+#13+
'NEXT >=«· «·Ï >'+#13+
'< BACK=< «·”«»ﬁ'+#13+
'TEECHART WIZARD=„”«⁄œ TeeChart'+#13+
'PERCENT=‰”»…'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=⁄—÷ Œÿ√'+#13+
'ENHANCED=„Õ”‰'+#13+
'VISIBLE WALLS=ÕÊ«∆ÿ Ÿ«Â—…'+#13+
'ACTIVE=‰‘ÿ'+#13+
'DELETE=Õ–›'+#13+
'ALIGNMENT=„Õ«–«Â'+#13+
'ADJUST FRAME=„Õ«–«… «·«ÿ«—'+#13+
'HORIZONTAL=«›ﬁÏ'+#13+
'VERTICAL=—√”Ï'+#13+
'VERTICAL POSITION=„Êﬁ⁄ —√”Ï'+#13+
'NUMBER=—ﬁ„'+#13+
'LEVELS=„” ÊÌ« '+#13+
'OVERLAP=„ œ«Œ·'+#13+
'STACK 100%=„ —«’ 100%'+#13+
'MOVE=Õ—ﬂ'+#13+
'CLICK=«÷€ÿ'+#13+
'DELAY= ŒÌ—'+#13+
'DRAW LINE= Œÿ —”„ '+#13+
'FUNCTIONS=œ«·…'+#13+
'SOURCE SERIES=„’œ— «·”·”·…'+#13+
'ABOVE=«⁄·Ï'+#13+
'BELOW=«”›·'+#13+
'Dif. Limit=LÌmite Dif.'+#13+
'WITHIN=Œ·«·'+#13+
'EXTENDED=„Õ”‰'+#13+
'STANDARD=ﬁÌ«”Ï'+#13+
'STATS=EstadÌstica'+#13+
'FINANCIAL=„«·Ï'+#13+
'OTHER=«Œ—'+#13+
'TEECHART GALLERY=GalerÌa de Gr·ficos TeeChart'+#13+
'CONNECTING LINES= Ê’Ì· «·ŒÿÊÿ'+#13+
'REDUCTION=‰ﬁ’'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=«·ﬂÀ«›…'+#13+
'FONT OUTLINES=«ÿ«— «·»‰ÿ'+#13+
'SMOOTH SHADING= Ÿ·Ì· „ ‰«”ﬁ'+#13+
'AMBIENT LIGHT=Luz de Ambiente'+#13+
'MOUSE ACTION=Õ—ﬂ… «·›√—…'+#13+
'CLOCKWISE=« Ã«… ⁄ﬁ«—» «·”«⁄Â'+#13+
'ANGLE INCREMENT=«·“Ì«œ… ›Ï «·“«ÊÌ…'+#13+
'RADIUS INCREMENT=«·“Ì«œ… ﬁÏ «·ﬁÿ—'+#13+
'PRINTER=«·ÿ«»⁄…'+#13+
'SETUP= Õ„Ì·'+#13+
'ORIENTATION=«·« Ã«…'+#13+
'PORTRAIT=—√”Ï'+#13+
'LANDSCAPE=«›ﬁÏ'+#13+
'MARGINS (%)=ÂÊ«„‘ (%)'+#13+
'MARGINS=ÂÊ«„‘'+#13+
'DETAIL= ›«’Ì·'+#13+
'MORE=«ﬂÀ—'+#13+
'PROPORTIONAL=‰”»Ï'+#13+
'VIEW MARGINS=⁄—÷ ÂÊ«„‘'+#13+
'RESET MARGINS=ÂÊ«„‘ «› —«÷Ï'+#13+
'PRINT=«ÿ»⁄'+#13+
'TEEPREVIEW EDITOR=„Õ—— ⁄«—÷ «·‘Ã—…'+#13+
'ALLOW MOVE=«·”„«Õ »«· Õ—ﬂ'+#13+
'ALLOW RESIZE=«·”„«Õ » €ÌÌ— «·ÕÃ„'+#13+
'SHOW IMAGE=«ŸÂ«— «·’Ê—…'+#13+
'DRAG IMAGE=«”Õ» «·’Ê—Â'+#13+
'AS BITMAP=«ŸÂ«— ﬂ BITMAP'+#13+
'SIZE %=ÕÃ„ %'+#13+
'FIELDS=ÕﬁÊ·'+#13+
'SOURCE=„’œ—'+#13+
'SEPARATOR=›«’·'+#13+
'NUMBER OF HEADER LINES=⁄œœ ŒÿÊÿ «·—√”'+#13+
'COMMA=›«’·…'+#13+
'EDITING= Õ—Ì—'+#13+
'TAB=Tab'+#13+
'SPACE=›—«€'+#13+
'ROUND RECTANGLE=„” ÿÌ· „œÊ— «·ÃÊ«‰»'+#13+
'BOTTOM=«”›·'+#13+
'RIGHT=Ì„Ì‰'+#13+
'C PEN=«·ﬁ·„ C'+#13+
'R PEN=«·ﬁ·„ R'+#13+
'C LABELS=⁄‰Ê«‰ C'+#13+
'R LABELS=⁄‰Ê«‰ R'+#13+
'MULTIPLE BAR=‘—«∆ÿ „ ⁄œœ…'+#13+
'MULTIPLE AREAS=„”«Õ«  „ ⁄œœÂ'+#13+
'STACK GROUP=„Ã„Ê⁄… „ —«’…'+#13+
'BOTH=ﬂ·«Â„«'+#13+
'BACK DIAGONAL=ﬁÿ—Ï „⁄ﬂÊ”'+#13+
'B.DIAGONAL=ﬁÿ—Ï „⁄ﬂÊ”'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=‘„«· Ì„Ì‰'+#13+
'RIGHT LEFT=Ì„Ì‰ ‘„«·'+#13+
'FROM CENTER=„‰ «·Ê”ÿ'+#13+
'FROM TOP LEFT=„‰ «⁄·Ï «·‘„«·'+#13+
'FROM BOTTOM LEFT=„‰ «”›· «·‘„«·'+#13+
'SHOW WEEKDAYS=«ŸÂ«— «Ì«„ «·«”»Ê⁄'+#13+
'SHOW MONTHS=«ŸÂ«— «·‘ÂÊ—'+#13+
'TRAILING DAYS=«Ì«„ «·„ƒŒ—…'+#13+
'SHOW TODAY=«ŸÂ«— «·ÌÊ„'+#13+
'TRAILING=„ –Ì·'+#13+
'LOWERED=„‰Œ›÷'+#13+
'RAISED=„—›⁄'+#13+
'HORIZ. OFFSET=Desplaz. «›ﬁÏ'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=œ«Œ·Ï'+#13+
'LEN=ÿÊ·'+#13+
'AT LABELS ONLY=⁄·Ï «·⁄‰«ÊÌ‰ ›ﬁÿ'+#13+
'MAXIMUM=«·Õ «·«⁄·Ï'+#13+
'MINIMUM=«·Õœ «·«œ‰Ï'+#13+
'CHANGE=€ÌÌ—'+#13+
'LOGARITHMIC=·Ê€«—Ì „Ï'+#13+
'LOG BASE=«”«” «··Ê€«—Ì „'+#13+
'DESIRED INCREMENT=„ﬁœ«— «·“Ì«œ…'+#13+
'(INCREMENT)=( “«ÌœÏ)'+#13+
'MULTI-LINE=„ ⁄œœ «·ŒÿÊÿ'+#13+
'MULTI LINE=„ ⁄œœ «·ŒÿÊÿ'+#13+
'RESIZE CHART= €ÌÌ— ÕÃ„. «·—”„ «·»Ì«‰Ï'+#13+
'X AND PERCENT=X y «·‰”»…'+#13+
'X AND VALUE=X y «·ﬁÌ„…'+#13+
'RIGHT PERCENT=«·‰”»… Ì„Ì‰'+#13+
'LEFT PERCENT=«·‰”»… ‘„«·'+#13+
'LEFT VALUE=«·ﬁÌ„… ‘„«·'+#13+
'RIGHT VALUE=«·ﬁÌ„… Ì„Ì‰'+#13+
'PLAIN=‰Û’'+#13+
'LAST VALUES=«Œ— ﬁÌ„…'+#13+
'SERIES VALUES=ﬁÌ„ ”·”·…'+#13+
'SERIES NAMES=«”„ «·”·”·…'+#13+
'NEW=ÃœÌœ'+#13+
'EDIT= Õ—Ì—'+#13+
'PANEL COLOR=·Ê‰ «·ÊÕ…'+#13+
'TOP BOTTOM=«⁄·Ï «”›·'+#13+
'BOTTOM TOP=«”›· «⁄·Ï'+#13+
'DEFAULT ALIGNMENT=„Õ«–«… «› —«÷Ì…'+#13+
'EXPONENTIAL=e «·„—›Ê⁄…'+#13+
'LABELS FORMAT= ‰”Ìﬁ «·⁄‰Ê«‰'+#13+
'MIN. SEPARATION %=«œ‰Ï ›«’· %'+#13+
'YEAR=”‰…'+#13+
'MONTH=‘Â—'+#13+
'WEEK=«”»Ê⁄'+#13+
'WEEKDAY=ÌÊ„ «·«”»Ê⁄'+#13+
'MARK=⁄·«„…'+#13+
'ROUND FIRST= ﬁ—Ì» «·«Ê·'+#13+
'LABEL ON AXIS=⁄‰Ê«‰ ⁄·Ï „ÕÊ—'+#13+
'COUNT=⁄œœ'+#13+
'POSITION %=„Êﬁ⁄ %'+#13+
'START %=»œ«Ì… %'+#13+
'END %=‰Â«Ì… %'+#13+
'OTHER SIDE=«·Ã«‰» «·«Œ—'+#13+
'INTER-CHAR SPACING=«·›—«€«  »Ì‰ «·—”„ «·»Ì«‰Ï'+#13+
'VERT. SPACING= «·›—«€«  «·—√”Ì…'+#13+
'POSITION OFFSET %=Ì·› %'+#13+
'GENERAL=⁄«„'+#13+
'MANUAL=ÌœÊÏ'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=·ÊÕ…'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=„Õ—— OpenGL'+#13+
'FONT 3D DEPTH=⁄„ﬁ  »‰ÿ &3D'+#13+
'NORMAL=ÿ»Ì⁄Ï'+#13+
'TEEFONT EDITOR=„Õ—— «· »‰ÿ'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Œ›÷'+#13+
'VERTICAL SMALL=—√”Ï ’€Ì—'+#13+
'HORIZ. SMALL=«›ﬁÏ ’€Ì—'+#13+
'DIAG. SMALL=ﬁÿ—Ï ’€Ì—'+#13+
'BACK DIAG. SMALL=ﬁÿ—Ï ’€Ì— „⁄ﬂÊ”'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=MÌnimos pixels'+#13+
'ALLOW SCROLL=«·”„«Õ  »‘—Ìÿ «· „—Ì—'+#13+
'SWAP= »œÌ·'+#13+
'GRADIENT EDITOR=„Õ—— «·«·Ê«‰ «·„ œ—Ã…'+#13+
'TEXT STYLE=‰„ÿ «·‰’'+#13+
'DIVIDING LINES=ŒÿÊÿ „ﬁÌ„…'+#13+
'SYMBOLS=«·—„Ê“'+#13+
'CHECK BOXES=Œ«‰… «Œ Ì«—'+#13+
'FONT SERIES COLOR=·Ê‰ »‰ÿ «·”·”·…'+#13+
'legend STYLE=«”·Ê» „› «Õ «·—”„'+#13+
'POINTS PER PAGE=⁄œœ «·‰ﬁ«ÿ ··’›Õ…'+#13+
'SCALE LAST PAGE=‰”»… «Œ— ’›Õ…'+#13+
'CURRENT PAGE Legend=„› «Õ «·—”„ ··’›Õ… «·Õ«·Ì…'+#13+
'BACKGROUND=«·Œ·›Ì…'+#13+
'BACK IMAGE=’Ê—… «·Œ·›ÌÂ'+#13+
'STRETCH=Ì„œ'+#13+
'TILE= Ã«‰»'+#13+
'BORDERS=«ÿ«—« '+#13+
'CALCULATE EVERY=Õ”«» ﬂ·'+#13+
'NUMBER OF POINTS=⁄œœ «·‰ﬁ«ÿ'+#13+
'RANGE OF VALUES=„œÏ «· ﬁÌ„'+#13+
'FIRST=«·«Ê·'+#13+
'LAST=«·«ŒÌ—'+#13+
'ALL POINTS=ﬂ· «·‰ﬁ«ÿ'+#13+
'DATA SOURCE=„’œ— «·»Ì«‰« '+#13+
'WALLS=ÕÊ«∆ÿ'+#13+
'PAGING= — Ì» «·’›Õ« '+#13+
'CLONE=‰”Œ'+#13+
'TITLES=⁄‰Ê«‰'+#13+
'TOOLS=«œÊ« '+#13+
'EXPORT= ’œÌ—'+#13+
'CHART=«·—”„ «·»Ì«‰Ï'+#13+
'BACK=«·Œ·›'+#13+
'LEFT AND RIGHT=‘„«· Ê Ì„Ì‰'+#13+
'SELECT A CHART STYLE=«Œ «— ‰„ÿ  «·—”„ «·»Ì«‰Ï'+#13+
'SELECT A DATABASE TABLE=«Œ «—„·› Ê«Õœ '+#13+
'TABLE=ÃœÊ·'+#13+
'SELECT THE DESIRED FIELDS TO CHART=«Œ «— ÕﬁÊ· «·—”„'+#13+
'SELECT A TEXT LABELS FIELD=«Œ «— ⁄‰«ÊÌ‰ «·ÕﬁÊ·'+#13+
'CHOOSE THE DESIRED CHART TYPE=«Œ «— ‰Ê⁄ «·—”„ «·»Ì«‰Ï'+#13+
'CHART PREVIEW=„⁄Ì‰… «·—”„'+#13+
'SHOW legend=«ŸÂ«— „› «Õ «·—”„'+#13+
'SHOW MARKS=«ŸÂ«— «·⁄·«„« '+#13+
'FINISH=«‰Â«¡'+#13+
'RANDOM=⁄‘Ê«∆Ï'+#13+
'DRAW EVERY=—”„ ·ﬂ·'+#13+
'ARROWS=«”Â„'+#13+
'ASCENDING= ’«⁄œÏ'+#13+
'DESCENDING= ‰«“·Ï'+#13+
'VERTICAL AXIS=„ÕÊ— —√”Ï'+#13+
'DATETIME=ÌÊ„\Êﬁ '+#13+
'TOP AND BOTTOM=«⁄·Ï Ê «œ‰Ï'+#13+
'HORIZONTAL AXIS=„ÕÊ— «›ﬁÏ'+#13+
'PERCENTS=‰”»…'+#13+
'VALUES=«·ﬁÌ„'+#13+
'FORMATS= ‰”Ìﬁ'+#13+
'SHOW IN Legend=«ŸÂ«— ›Ï „› «Õ «·—”„'+#13+
'SORT=— »'+#13+
'MARKS=⁄·«„« '+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=„Õ—— «·ÊÕ…'+#13+
'CONTINUOUS=„ ’·'+#13+
'HORIZ. ALIGNMENT=„Õ«–«Â «›ﬁÌ…'+#13+
'EXPORT CHART=’œÌ— «·—”„ «·»Ì«‰Ï'+#13+
'BELOW %=«œ‰Ï „‰ a %'+#13+
'BELOW VALUE=«œ‰Ï „‰ ﬁÌ„…'+#13+
'NEAREST POINT=«ﬁ—» ‰ﬁÿ…'+#13+
'DRAG MARKS=«”Õ» «·⁄·«„« '+#13+
'TEECHART PRINT PREVIEW=„⁄«Ì‰… ÿ»«⁄Â «·—”„'+#13+
'X VALUE=«·ﬁÌ„… X'+#13+
'X AND Y VALUES=«·ﬁÌ„… X ÊY'+#13+
'SHININESS=«··„⁄«‰'+#13+
'ALL SERIES VISIBLE=ﬂ· «·”·«”·  ŸÂ—'+#13+
'MARGIN=ÂÊ«„‘'+#13+
'DIAGONAL=„ÕÊ—Ï'+#13+
'LEFT TOP=‘„«· «⁄·Ï'+#13+
'LEFT BOTTOM=‘„«· «”›·'+#13+
'RIGHT TOP=Ì„Ì‰ «⁄·Ï'+#13+
'RIGHT BOTTOM=Ì„Ì‰ «”›·'+#13+
'EXACT DATE TIME=«· «—ÌŒ »«·÷»ÿ'+#13+
'RECT. GRADIENT= œ—Ã «·«·Ê«‰'+#13+
'CROSS SMALL=Cruz pequeÒa'+#13+
'AVG=„ Ê”ÿ'+#13+
'FUNCTION=œ«·…'+#13+
'AUTO= ·ﬁ«∆Ì«'+#13+
'ONE MILLISECOND=«Ã“«¡ «·À«‰Ì…'+#13+
'ONE SECOND=À«‰Ì… Ê«Õœ…'+#13+
'FIVE SECONDS=Œ„” ÀÊ«‰Ï'+#13+
'TEN SECONDS=⁄‘— ÀÊ«‰Ï'+#13+
'FIFTEEN SECONDS=Œ„”… ⁄‘— ÀÊ«‰Ï'+#13+
'THIRTY SECONDS=À·«ÀÌ‰ ÀÊ«‰Ï'+#13+
'ONE MINUTE=œﬁÌﬁ… Ê«Õœ…'+#13+
'FIVE MINUTES=Œ„”… œﬁ«∆ﬁ'+#13+
'TEN MINUTES=⁄‘—… œﬁ«∆ﬁ'+#13+
'FIFTEEN MINUTES=Œ„”… ⁄‘— œﬁ«∆ﬁ'+#13+
'THIRTY MINUTES=À·«ÀÌ‰ œﬁ«∆ﬁ'+#13+
'TWO HOURS=”«⁄ Ì‰'+#13+
'TWO HOURS=”«⁄ Ì‰'+#13+
'SIX HOURS=” … ”«⁄« '+#13+
'TWELVE HOURS=«À‰Ï ⁄‘— ”«⁄« '+#13+
'ONE DAY=Ê«Õœ ÌÊ„'+#13+
'TWO DAYS=«À‰Ì‰ «Ì«„'+#13+
'THREE DAYS=À·«À… «Ì«„'+#13+
'ONE WEEK=Ê«Õœ «”»Ê⁄'+#13+
'HALF MONTH=‰’› ‘Â—'+#13+
'ONE MONTH=Ê«Õœ ‘Â—'+#13+
'TWO MONTHS=«À‰Ì‰ ‘ÂÊ—'+#13+
'THREE MONTHS=À·«À… ‘ÂÊ—'+#13+
'FOUR MONTHS=«—»⁄… ‘ÂÊ—'+#13+
'SIX MONTHS=” … ‘ÂÊ—'+#13+
'IRREGULAR=€Ì— „‰ Ÿ„'+#13+
'CLICKABLE=ﬁ«»· ··Ÿ€ÿ'+#13+
'ROUND=Ìﬁ—»'+#13+
'FLAT=„”ÿÕ'+#13+
'PIE=œ«∆—Ï'+#13+
'HORIZ. BAR=‘—ÌÿÏ «›ﬁÏ'+#13+
'BUBBLE=›ﬁ«⁄Ï'+#13+
'SHAPE=‘ﬂ·'+#13+
'POINT=‰ﬁÿ…'+#13+
'FAST LINE=Œÿ ”—Ì⁄'+#13+
'CANDLE=‘„⁄Â'+#13+
'VOLUME=ÕÃ„'+#13+
'HORIZ LINE=Œÿ «›ﬁÏ'+#13+
'SURFACE=”ÿÕ'+#13+
'LEFT AXIS=„ÕÊ— ‘„«·'+#13+
'RIGHT AXIS=„ÕÊ— Ì„Ì‰'+#13+
'TOP AXIS=„ÕÊ— «⁄·Ï'+#13+
'BOTTOM AXIS=„ÕÊ— «œ‰Ï'+#13+
'CHANGE SERIES TITLE= €ÌÌ— ⁄‰Ê«‰ ”·”·…'+#13+
'NEW SERIES TITLE:= ⁄‰Ê«‰ ÃœÌœ:'+#13+
'DELETE %S ?=Õ–› %s ?'+#13+
'DESIRED %S INCREMENT=«·“Ì«œ… %s «·„ÿ·Ê»…'+#13+
'INCORRECT VALUE. REASON: %S=ﬁÌ„… €Ì— ’ÕÌÕ… »”»»: %s'+#13+
'FillSampleValues NumValues must be > 0=«·ﬁÌ„ «·„œŒ·… ÌÃ» «‰  ﬂÊ‰> 0.'#13+
'VISIT OUR WEB SITE !=ﬁ„ »“Ì«—… „Êﬁ⁄‰«  !'#13+
'SHOW PAGE NUMBER=«ŸÂ«— —ﬁ„ «·’›Õ…'#13+
'PAGE NUMBER=—ﬁ„ «·’›Õ…a'#13+
'PAGE %D OF %D=’›Õ… %d „‰ %d'#13+
'TEECHART LANGUAGE SELECTOR=«Œ «— ·€… TeeChart'#13+
'CHOOSE A LANGUAGE=«Œ «— ·€…'+#13+
'SELECT ALL=«Œ «— «·ﬂ·'#13+
'MOVE UP=Õ—ﬂ… «·Ï «⁄·Ï'#13+
'MOVE DOWN=Õ—ﬂ… ··«”›·'#13
;
  end;
end;

Procedure TeeSetArabic;
begin
  TeeCreateArabic;
  TeeLanguage:=TeeArabicLanguage;
  TeeArabicConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeArabicLanguage);
end.
