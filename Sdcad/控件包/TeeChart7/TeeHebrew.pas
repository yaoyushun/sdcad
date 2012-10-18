unit TeeHebrew;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHebrewLanguage:TStringList=nil;

Procedure TeeSetHebrew;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHebrewConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='דוד ברנדה 1995-2004 ©';
  TeeMsg_LegendFirstValue   :='ראשון ערך של מקרא חייב ליהות > 0';
  TeeMsg_LegendColorWidth   :='רוחב צבע של מקרא חייב ליהות > 0%';
  TeeMsg_SeriesSetDataSource:='אין תרשים-אבא לבדוק מקור נתונים';
  TeeMsg_SeriesInvDataSource:='אין מקור נתונים נכון: %s';
  TeeMsg_FillSample         :='חייבים ליהות > 0 FillSampleValues ערכים מיספריים של';
  TeeMsg_AxisLogDateTime    :='ציר של תאריך/זמן לא יכול ליהות לוגריטמי';
  TeeMsg_AxisLogNotPositive :='ציר לוגריטמי של ערכיםןמיו ומקס חייב ליהות >= 0';
  TeeMsg_AxisLabelSep       :='הפרדה של תוויות % חייב ליהות גדול מ-0';
  TeeMsg_AxisIncrementNeg   :='הגדלת ציר חייבת ליהות >= 0';
  TeeMsg_AxisMinMax         :='ערך מינמלי של ציר חייבת ליהות <= מקסימום';
  TeeMsg_AxisMaxMin         :='ערך מקסימלי של ציר חייבת ליהות >= מינימום';
  TeeMsg_AxisLogBase        :='בסיס לוגריטמי של ציר חייב ליהות >= 2';
  TeeMsg_MaxPointsPerPage   :='חייב ליהות >= 0 MaxPointsPerPage';
  TeeMsg_3dPercent          :='3D effect percent must be between %d and %d';
  TeeMsg_CircularSeries     :='תלויות חוזרות של סידרות אסורות';
  TeeMsg_WarningHiColor     :=' 16k Color צריך להופעה טובה';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='כותרת של צור';
  TeeMsg_AxisLabels         :='תוויות של ציר';
  TeeMsg_RefreshInterval    :='מרווח של רענון חייב ליהות בין 0 ל 60';
  TeeMsg_SeriesParentNoSelf :=' לא שייך Series.ParentChart';
  TeeMsg_GalleryLine        :='קו';
  TeeMsg_GalleryPoint       :='נקודה';
  TeeMsg_GalleryArea        :='שטח';
  TeeMsg_GalleryBar         :='עמודות';
  TeeMsg_GalleryHorizBar    :='עמודות אופקיות';
  TeeMsg_Stack              :='ערימה';
  TeeMsg_GalleryPie         :='עוגה';
  TeeMsg_GalleryCircled     :='מעגל';
  TeeMsg_GalleryFastLine    :='קו מהיר';
  TeeMsg_GalleryHorizLine   :='קו אופקי';

  TeeMsg_PieSample1         :='מכוניות';
  TeeMsg_PieSample2         :='טלפונים';
  TeeMsg_PieSample3         :='שולחנות';
  TeeMsg_PieSample4         :='מסכים';
  TeeMsg_PieSample5         :='מנורות';
  TeeMsg_PieSample6         :='מיקלדות';
  TeeMsg_PieSample7         :='אופניים';
  TeeMsg_PieSample8         :='כיסאות';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='%s עריכה';

  TeeMsg_GalleryStandard    :='סטנדרד';
  TeeMsg_GalleryExtended    :='מורחב';
  TeeMsg_GalleryFunctions   :='פונקציות';

  TeeMsg_EditChart          :='ל&ערוך תרשים';
  TeeMsg_PrintPreview       :='הצג לפנ&י הדפסה...';
  TeeMsg_ExportChart        :='...יצ&וא תרשים';
  TeeMsg_CustomAxes         :='...צירים אישיים';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: ללא עורך דו-שיח';

  TeeMsg_GalleryArrow       :='חץ';

  TeeMsg_ExpFinish          :='סיום&';
  TeeMsg_ExpNext            :='הבא&>';

  TeeMsg_GalleryGantt       :='גנט';

  TeeMsg_GanttSample1       :='תוכנית';
  TeeMsg_GanttSample2       :='אב-טיפוס';
  TeeMsg_GanttSample3       :='פיטוח';
  TeeMsg_GanttSample4       :='מחירות';
  TeeMsg_GanttSample5       :='שיווק';
  TeeMsg_GanttSample6       :='בדיקה';
  TeeMsg_GanttSample7       :='ייצור';
  TeeMsg_GanttSample8       :='ניפוי';
  TeeMsg_GanttSample9       :='גירסה חדשה';
  TeeMsg_GanttSample10      :='בנקאות';

  TeeMsg_ChangeSeriesTitle  :='תשנה כותרת של סידרה';
  TeeMsg_NewSeriesTitle     :='כתרת של סידרה חדשה';
  TeeMsg_DateTime           :='תאריך זמן';
  TeeMsg_TopAxis            :='ציר עליון';
  TeeMsg_BottomAxis         :='ציר תחתון';
  TeeMsg_LeftAxis           :='ציר שמאל';
  TeeMsg_RightAxis          :='ציר ימין';

  TeeMsg_SureToDelete       :=' ? %s למחוק';
  TeeMsg_DateTimeFormat     :='ע&צוב תאריך וזמן:';
  TeeMsg_Default            :='ברירת מחדל';
  TeeMsg_ValuesFormat       :='ע&צוב ערכים';
  TeeMsg_Maximum            :='מקסימום';
  TeeMsg_Minimum            :='מינימום';
  TeeMsg_DesiredIncrement   :='רצויה %s הגדלה';

  TeeMsg_IncorrectMaxMinValue:=' %sערך לא נכון. סיבה ';
  TeeMsg_EnterDateTime      :='Enter [Number of Days] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='?ליישם שינויים';
  TeeMsg_SelectedSeries     :='(סידרות נבחרות)';
  TeeMsg_RefreshData        :='ר&ענון נתונים';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='להוסיף';
  TeeMsg_FunctionSubtract   :='להחסיר';
  TeeMsg_FunctionMultiply   :='להכפיל';
  TeeMsg_FunctionDivide     :='לחלק';
  TeeMsg_FunctionHigh       :='גבוה';
  TeeMsg_FunctionLow        :='נמוך';
  TeeMsg_FunctionAverage    :='ממוצע';

  TeeMsg_GalleryShape       :='צורה';
  TeeMsg_GalleryBubble      :='בועה';
  TeeMsg_FunctionNone       :='עוטק';

  TeeMsg_None               :='(כלום)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='גודל של פוינטר חייב ליהות > 0';
  TeeMsg_About              :='...TeeChart אוד&ות';

  tcAdditional              :='נוסף';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='רשומה בודדה';
  TeeMsg_AskDataSource      :=':מקור נ&תונים';

  TeeMsg_Summary            :='סיכום';

  TeeMsg_FunctionPeriod     :='משך פונקציה חייב ליהות >= 0';

  TeeMsg_WizardTab          :='עסקים';
  TeeMsg_TeeChartWizard     :='TeeChartאשף';

  TeeMsg_ClearImage         :='לנ&קות';
  TeeMsg_BrowseImage        :='...ע&יון';

  TeeMsg_WizardSureToClose  :='?TeeChart Wizard-בטוח שרוצה לסגור את ה';
  TeeMsg_FieldNotFound      :='לא קיים %s שדה';

  TeeMsg_DepthAxis          :='ציר עומק';
  TeeMsg_PieOther           :='אחר';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='עוגה';
  TeeMsg_ValuesBar          :='עמודות';
  TeeMsg_ValuesAngle        :='זווית';
  TeeMsg_ValuesGanttStart   :='התחלה';
  TeeMsg_ValuesGanttEnd     :='סוף';
  TeeMsg_ValuesGanttNextTask:='משימה הבא';
  TeeMsg_ValuesBubbleRadius :='רדיוס';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='מקרא';
  TeeMsg_Title              :='כותרת';
  TeeMsg_Foot               :='כותרת תחתונה';
  TeeMsg_Period		    :='משך';
  TeeMsg_PeriodRange        :='טווח המשך';
  TeeMsg_CalcPeriod         :=' %sלחשב כל ';
  TeeMsg_SmallDotsPen       :='נקודות קטנות';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' תרשים לא נכון בקובץ';
  TeeMsg_WrongTeeFileFormat :=' *.'+TeeMsg_TeeExtension+' מבנה לא נכון של קובץ';
  TeeMsg_EmptyTeeFile       :='ריק *.'+TeeMsg_TeeExtension+' קובץ';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'צירים של תרשים';
  TeeMsg_ChartAxesCategoryDesc   := 'תכונות ואירוים צירים של תרשים';
  TeeMsg_ChartWallsCategoryName  := 'דפנות של תרשים';
  TeeMsg_ChartWallsCategoryDesc  := 'תכונות ואירויים של דפנות תרשים';
  TeeMsg_ChartTitlesCategoryName := 'כותרות תרשים';
  TeeMsg_ChartTitlesCategoryDesc := 'תכונות ואירויים של כותרות תרשים';
  TeeMsg_Chart3DCategoryName     := 'תרשים תלת-מימדי';
  TeeMsg_Chart3DCategoryDesc     := 'תכונות ואירויים של תרשים תלת-מימדי';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='אישי ';
  TeeMsg_Series                 :='סידרות';
  TeeMsg_SeriesList             :='סידרות...';

  TeeMsg_PageOfPages            :=' %d of %d דף';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='ראשון';
  TeeMsg_Prior  :='קודם';
  TeeMsg_Next   :='הבא';
  TeeMsg_Last   :='אחרון';
  TeeMsg_Insert :='הוספה';
  TeeMsg_Delete :='למחוק';
  TeeMsg_Edit   :='עריכה';
  TeeMsg_Post   :='לשלוח';
  TeeMsg_Cancel :='לבטל';

  TeeMsg_All    :='(הכול)';
  TeeMsg_Index  :='אינדקס';
  TeeMsg_Text   :='טקסט';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Panel property is not set in Export format';

  TeeMsg_Normal    :='נורמלי';
  TeeMsg_NoBorder  :='אין גבולות';
  TeeMsg_Dotted    :='מקובקב';
  TeeMsg_Colors    :='צבעים';
  TeeMsg_Filled    :='ממולא';
  TeeMsg_Marks     :='סימנים';
  TeeMsg_Stairs    :='מדרגות';
  TeeMsg_Points    :='נקודות';
  TeeMsg_Height    :='גובה';
  TeeMsg_Hollow    :='חלל';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='משולש';
  TeeMsg_Star      :='כוכב';
  TeeMsg_Circle    :='עגול';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='צלב';
  TeeMsg_Diamond   :='יהלום';
  TeeMsg_NoLines   :='אין קווים';
  TeeMsg_Stack100  :='ערימה 100%';
  TeeMsg_Pyramid   :='פירמידה';
  TeeMsg_Ellipse   :='אליפסה';
  TeeMsg_InvPyramid:='פירמידה לא נכונה';
  TeeMsg_Sides     :='צדדים';
  TeeMsg_SideAll   :='כל הצדדים';
  TeeMsg_Patterns  :='תבניות';
  TeeMsg_Exploded  :='מפוצצת';
  TeeMsg_Shadow    :='צל';
  TeeMsg_SemiPie   :='חצי-עוגה';
  TeeMsg_Rectangle :='מלבן';
  TeeMsg_VertLine  :='קו אנכי';
  TeeMsg_HorizLine :='קו אופקי';
  TeeMsg_Line      :='קו';
  TeeMsg_Cube      :='קובייה';
  TeeMsg_DiagCross :='צלב אלכסוני';

  TeeMsg_CanNotFindTempPath    :='Temp לא נימצא סיפרייה ';
  TeeMsg_CanNotCreateTempChart :='Temp לא יכול ליצור קובץ ';
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

  { 5.02 }
  TeeMsg_AskLanguage  :='...ש&פה';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='פולאר';
  TeeMsg_GalleryCandle      :='נר';
  TeeMsg_GalleryVolume      :='נפח';
  TeeMsg_GallerySurface     :='משטח';
  TeeMsg_GalleryContour     :='מתאר';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='נקודה 3די';
  TeeMsg_GalleryRadar       :='ראדר';
  TeeMsg_GalleryDonut       :='טבעת';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='עמודות 3די';
  TeeMsg_GalleryBigCandle   :='נר גדול';
  TeeMsg_GalleryLinePoint   :='Line Point';
  TeeMsg_GalleryHistogram   :='היסטוגרמה';
  TeeMsg_GalleryWaterFall   :='מפל מים';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='שעון';
  TeeMsg_GalleryColorGrid   :='צבע של קוי רשת';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='עמודות חיבור';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='פירמידה';
  TeeMsg_GalleryMap         :='מפה';

  TeeMsg_PolyDegreeRange    :='Polynomial degree must be between 1 and 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='משך זמן חייב ליהות > 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='עמודה טעויות';
  TeeMsg_GalleryError        :='טעות';
  TeeMsg_GalleryHighLow      :='גבוה-נמוך';
  TeeMsg_FunctionMomentum    :='מומנטום';
  TeeMsg_FunctionMomentumDiv :='מומנטום דיו';
  TeeMsg_FunctionExpAverage  :='ממוצע אקספ';
  TeeMsg_FunctionMovingAverage:='ממוצע נע';
  TeeMsg_FunctionExpMovAve   :='ממוצע נע אקספ';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='מגמה';
  TeeMsg_FunctionExpTrend    :='מגמה אקספ';
  TeeMsg_FunctionLogTrend    :='מגמה לוגריטמי';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='Std.Deviation';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='סטוקסטיק';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='ספירה';
  TeeMsg_LoadChart           :='...TeeChart פתח ';
  TeeMsg_SaveChart           :='...TeeChart שמור';
  TeeMsg_TeeFiles            :='TeeChart Pro קבצים';

  TeeMsg_GallerySamples      :='אחרים';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :=' %s לא נימצא טופס של עורך סידרות';


  TeeMsg_CannotLoadChartFromURL:='Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Error code: %d downloading Series data from URL: %s';

  TeeMsg_Test                :='...בדיקה';

  TeeMsg_ValuesDate          :='תאריך';
  TeeMsg_ValuesOpen          :='פתיחה';
  TeeMsg_ValuesHigh          :='גבוה';
  TeeMsg_ValuesLow           :='נמוך';
  TeeMsg_ValuesClose         :='סגור';
  TeeMsg_ValuesOffset        :='אופסט';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='3D קוי רשת';

  TeeMsg_LowBezierPoints     :='חייב ליהות > 1 Bezier מספר של נקודות';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='נורמלי';
  TeeCommanMsg_Edit     :='עריכה';
  TeeCommanMsg_Print    :='הדפסה';
  TeeCommanMsg_Copy     :='עותק';
  TeeCommanMsg_Save     :='שמור';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :=' %d°: הסתובבות %d°: העלאה';
  TeeCommanMsg_Rotate   :='לסבב';

  TeeCommanMsg_Moving   :=' %d :קיזוז אופקי  %d:קיזוז אנכי';
  TeeCommanMsg_Move     :='לנוע';

  TeeCommanMsg_Zooming  :='%d %%: הגדלה/הקטנה';
  TeeCommanMsg_Zoom     :='הגדלה/הקטנה';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='עומק';

  TeeCommanMsg_Chart    :='תרשים';
  TeeCommanMsg_Panel    :='לוח';

  TeeCommanMsg_RotateLabel:='כדי לסובב %s גרר';
  TeeCommanMsg_MoveLabel  :='כדי לנוע %s גרר';
  TeeCommanMsg_ZoomLabel  :='להגדלה/הקטנה %s גרר';
  TeeCommanMsg_DepthLabel :='3D  כדי לשנות גודל %s גרר';

  TeeCommanMsg_NormalLabel:='גרר כפתור שמאל כדי  להגדיל וכפתור ימין כדי לגלגל';
  TeeCommanMsg_NormalPieLabel:='גרר פלח של עוגה כדי לפתוח';

  TeeCommanMsg_PieExploding :='נפתח: %d פלח: %d %%';

  TeeMsg_TriSurfaceLess        :='מספר נקודות חייב ליהות >= 4';
  TeeMsg_TriSurfaceAllColinear :='כל הנקודות קולינאריות';
  TeeMsg_TriSurfaceSimilar     :='נקודות דומות - לא יכול לבצע';
  TeeMsg_GalleryTriSurface     :='שטח משולש';

  TeeMsg_AllSeries :='כל הסידרות';
  TeeMsg_Edit      :='עריכה';

  TeeMsg_GalleryFinancial    :='פיננסי';

  TeeMsg_CursorTool    :='סמן';
  TeeMsg_DragMarksTool :='Drag Marks';
  TeeMsg_AxisArrowTool :='Axis Arrows';
  TeeMsg_DrawLineTool  :='Draw Line';
  TeeMsg_NearestTool   :='Nearest Point';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Color Line';
  TeeMsg_RotateTool    :='Rotate';
  TeeMsg_ImageTool     :='Image';
  TeeMsg_MarksTipTool  :='Mark Tips';

  TeeMsg_CantDeleteAncestor  :='לא יכול למחוק את האב';

  TeeMsg_Load	          :='...טעינה';
  TeeMsg_NoSeriesSelected :='לא נבחר סידרה';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='תרשים';
  TeeMsg_CategorySeriesActions :='סידרות של תרשים';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Switch 2D / 3D';
  TeeMsg_ActionSeriesActive     := 'פעי&ל';
  TeeMsg_ActionSeriesActiveHint := 'הצג/הסתר סידרות';
  TeeMsg_ActionEditHint         := 'עריכת תרשים';
  TeeMsg_ActionEdit             := '...ער&יכה';
  TeeMsg_ActionCopyHint         := 'העתק ללוח';
  TeeMsg_ActionCopy             := 'ע&ותק';
  TeeMsg_ActionPrintHint        := 'הצג תרשים לפני הדפסה';
  TeeMsg_ActionPrint            := '...הד&פסה';
  TeeMsg_ActionAxesHint         := 'הצג/הסתר צירים';
  TeeMsg_ActionAxes             := 'צ&ירים';
  TeeMsg_ActionGridsHint        := 'הצג/הסתר קוי רשת';
  TeeMsg_ActionGrids            := 'ק&וי רשת';
  TeeMsg_ActionLegendHint       := 'הצג/הסתר מקרא';
  TeeMsg_ActionLegend           := 'מ&קרא';
  TeeMsg_ActionSeriesEditHint   := 'עריכה סידרות';
  TeeMsg_ActionSeriesMarksHint  := 'הצג/הסתר סמנים סידרות';
  TeeMsg_ActionSeriesMarks      := 'סימ&נים';
  TeeMsg_ActionSaveHint         := 'שמור תרשים';
  TeeMsg_ActionSave             := '...ש&מור';

  TeeMsg_CandleBar              := 'עמודות';
  TeeMsg_CandleNoOpen           := 'אין מחיר פתיחה';
  TeeMsg_CandleNoClose          := 'אין מחיר סגרה';
  TeeMsg_NoLines                := 'ללא קוים';
  TeeMsg_NoHigh                 := 'אין מחיר גבוה';
  TeeMsg_NoLow                  := 'אין מחיר נמוך';
  TeeMsg_ColorRange             := 'תחום צבעים';
  TeeMsg_WireFrame              := 'מסגרת חוט';
  TeeMsg_DotFrame               := 'מסגרת נקודות';
  TeeMsg_Positions              := 'פוזיציות';
  TeeMsg_NoGrid                 := 'ללא קוי רשת';
  TeeMsg_NoPoint                := 'ללא נקודה';
  TeeMsg_NoLine                 := 'ללא קו';
  TeeMsg_Labels                 := 'תוויות';
  TeeMsg_NoCircle               := 'ללא עגול';
  TeeMsg_Lines                  := 'קווים';
  TeeMsg_Border                 := 'גבול';

  TeeMsg_SmithResistance      := 'התנגדות';
  TeeMsg_SmithReactance       := 'התנגדות ראקטיבי';

  TeeMsg_Column               := 'טור';

  { 5.01 }
  TeeMsg_Separator            := 'מפריד';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Exceeds quota';
  TeeMsg_FunnelWithin         := ' within quota';
  TeeMsg_FunnelBelow          := ' or more below quota';
  TeeMsg_CalendarSeries       := 'לוח שנה';
  TeeMsg_DeltaPointSeries     := 'DeltaPoint';
  TeeMsg_ImagePointSeries     := 'ImagePoint';
  TeeMsg_ImageBarSeries       := 'עמודת דמות';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               := 'מקור';
  TeeMsg_Transparency         := 'שקיפות';
  TeeMsg_Box		      := 'תיבה';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'מיספר דף';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='Save %s?';

  TeeMsg_Property            :='Property';
  TeeMsg_Value               :='Value';
  TeeMsg_Yes                 :='Yes';
  TeeMsg_No                  :='No';
  TeeMsg_Image              :='(image)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateHebrew;
begin
  if not Assigned(TeeHebrewLanguage) then
  begin
    TeeHebrewLanguage:=TStringList.Create;
    TeeHebrewLanguage.Text:=

'LABELS=תוויות'+#13+
'DATASET=טבלא'+#13+
'ALL RIGHTS RESERVED.=כל הזכויות שמורות.'+#13+
'APPLY=ליישם'+#13+
'CLOSE=סגור'+#13+
'OK=אישור'+#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0 אודות '+#13+
'OPTIONS=אפשרויות'+#13+
'FORMAT=עיצוב'+#13+
'TEXT=טקסט'+#13+
'GRADIENT=שיפוע'+#13+
'SHADOW=צל'+#13+
'POSITION=מיקום'+#13+
'LEFT=שמאל'+#13+
'TOP=עליון'+#13+
'CUSTOM=אישית'+#13+
'PEN=עט'+#13+
'PATTERN=תוונית'+#13+
'SIZE=גודל'+#13+
'BEVEL=שיפוע'+#13+
'INVERTED=הפוך'+#13+
'BORDER=גבול'+#13+
'ORIGIN=מוצא'+#13+
'USE ORIGIN=מוצא שימוש'+#13+
'AREA LINES=קווים שטח'+#13+
'AREA=שטח'+#13+
'COLOR=צבע'+#13+
'SERIES=סידרה'+#13+
'SUM=סכום'+#13+
'DAY=יום'+#13+
'QUARTER=ריבעון'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=גלוי'+#13+
'CURSOR=קורסור'+#13+
'GLOBAL=גלבלי'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=קו אופקי'+#13+
'LABEL AND PERCENT=תווית ואחוז'+#13+
'LABEL AND VALUE=תווית וערך'+#13+
'LABEL AND PERCENT TOTAL=תווית ואחוז כולל'+#13+
'PERCENT TOTAL=אחוז כולל'+#13+
'MSEC.=משניה'+#13+
'SUBTRACT=להחסיר'+#13+
'MULTIPLY=להכפיל'+#13+
'DIVIDE=לחלק'+#13+
'STAIRS=מדרגות'+#13+
'MOMENTUM=מומנטום'+#13+
'AVERAGE=ממוצע'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML טבלה '+#13+
'EXCEL=Excel'+#13+
'NONE=כלום'+#13+
'(NONE)=כלום'#13+
'WIDTH=רוחב'+#13+
'HEIGHT=גובה'+#13+
'COLOR EACH=כל צבע'+#13+
'STACK=ערימה'+#13+
'STACKED=מערם'+#13+
'STACKED 100%=100% מערם'+#13+
'AXIS=ציר'+#13+
'LENGTH=אורך'+#13+
'CANCEL=לבטל'+#13+
'SCROLL=פס גלילה'+#13+
'INCREMENT=הגדלה'+#13+
'VALUE=ערך'+#13+
'STYLE=סגנון'+#13+
'JOIN=חיבור'+#13+
'AXIS INCREMENT=הגדלת ציר'+#13+
'AXIS MAXIMUM AND MINIMUM=מקסימום ומינימום של ציר'+#13+
'% BAR WIDTH=רוחב של עמודה %'+#13+
'% BAR OFFSET=העברהשל עמודה %'+#13+
'BAR SIDE MARGINS=שוליים של עמודה'+#13+
'AUTO MARK POSITION=אוטו סימן מיקום'+#13+
'DARK BAR 3D SIDES=צד כהה של עמדות 3די'+#13+
'MONOCHROME=מונוכרום'+#13+
'COLORS=צבעים'+#13+
'DEFAULT=ברירת מחדל'+#13+
'MEDIAN=חציון'+#13+
'IMAGE=דמות'+#13+
'DAYS=ימים'+#13+
'WEEKDAYS=יום חול'+#13+
'TODAY=היום'+#13+
'SUNDAY=יום ראשון'+#13+
'MONTHS=חדשים'+#13+
'LINES=קווים'+#13+
'UPPERCASE=עילי'+#13+
'STICK=נר'+#13+
'CANDLE WIDTH=רוחב של נר'+#13+
'BAR=עמודים'+#13+
'OPEN CLOSE=לפתוח לסגור'+#13+
'DRAW 3D=3D לצייר'+#13+
'DARK 3D=3D כהה'+#13+
'SHOW OPEN=להציג פתוח'+#13+
'SHOW CLOSE=להציג סגור'+#13+
'UP CLOSE=סגור למעלה'+#13+
'DOWN CLOSE=סגור למטה'+#13+
'CIRCLED=עגול'+#13+
'CIRCLE=עיגול'+#13+
'3 DIMENSIONS=תלת-מימדי'+#13+
'ROTATION=רוטציה'+#13+
'RADIUS=רדיוס'+#13+
'HOURS=שעות'+#13+
'HOUR=שעה'+#13+
'MINUTES=דקות'+#13+
'SECONDS=שניות'+#13+
'FONT=פונט'+#13+
'INSIDE=בפנים'+#13+
'ROTATED=מסובב'+#13+
'ROMAN=רומי'+#13+
'TRANSPARENCY=שקיפות'+#13+
'DRAW BEHIND=לצייר מאחרי'+#13+
'RANGE=טווח'+#13+
'PALETTE=פלטת צבעים'+#13+
'STEPS=צעדים'+#13+
'GRID=קוי רשת'+#13+
'GRID SIZE=גודל קוי רשת'+#13+
'ALLOW DRAG=להרשות גרירה'+#13+
'AUTOMATIC=אוטומטי'+#13+
'LEVEL=רמה'+#13+
'LEVELS POSITION=מיקום ברמה'+#13+
'SNAP=לתפוס'+#13+
'FOLLOW MOUSE=עקב עכבר'+#13+
'TRANSPARENT=שקוף'+#13+
'ROUND FRAME=מסגרת עגולה'+#13+
'FRAME=מסגרת'+#13+
'START=התחלה'+#13+
'END=סוף'+#13+
'MIDDLE=אמצע'+#13+
'NO MIDDLE=לא אמצע'+#13+
'DIRECTION=כיוון'+#13+
'DATASOURCE=מקור נתונים'+#13+
'AVAILABLE=זמין'+#13+
'SELECTED=נבחר'+#13+
'CALC=לחשב'+#13+
'GROUP BY=לסווג לפי'+#13+
'OF=של'+#13+
'HOLE %=חור %'+#13+
'RESET POSITIONS=פוזיציות מאפסות'+#13+
'MOUSE BUTTON=כפתור עכבר'+#13+
'ENABLE DRAWING=להרשות ציור'+#13+
'ENABLE SELECT=להרשות בחירה'+#13+
'ORTHOGONAL=ישר-זווית'+#13+
'ANGLE=זווית'+#13+
'ZOOM TEXT=הגדלה/הקטנה טקסט'+#13+
'PERSPECTIVE=פרספקטיבה'+#13+
'ZOOM=הגדלה/הקטנה'+#13+
'ELEVATION=הרמה'+#13+
'BEHIND=מאחור'+#13+
'AXES=צירים'+#13+
'SCALES=סקלאות'+#13+
'TITLE=כותרת'+#13+
'TICKS=סימנים'+#13+
'MINOR=משני'+#13+
'CENTERED=ממורכז'+#13+
'CENTER=מרכז'+#13+
'PATTERN COLOR EDITOR=עורך תבנית צבע'+#13+
'START VALUE=ערך התחלתי'+#13+
'END VALUE=ערך סופי'+#13+
'COLOR MODE=מצב צבע'+#13+
'LINE MODE=מצב קו'+#13+
'HEIGHT 3D=3D גובה'+#13+
'OUTLINE=מיתאר'+#13+
'PRINT PREVIEW=הצג לפני הדפסה'+#13+
'ANIMATED=אנימציה'+#13+
'ALLOW=להרשות'+#13+
'DASH=קו דק'+#13+
'DOT=נקודה'+#13+
'DASH DOT DOT=קו מקווקו'+#13+
'PALE=חיוור'+#13+
'STRONG=חזק'+#13+
'WIDTH UNITS=יחידות רוחב'+#13+
'FOOT=רגל'+#13+
'SUBFOOT=תת-רגל'+#13+
'SUBTITLE=כותרת משני'+#13+
'LEGEND=מקרא'+#13+
'COLON=נקודותיים'+#13+
'AXIS ORIGIN=ציר מוצא'+#13+
'UNITS=יחידות'+#13+
'PYRAMID=פירמידה'+#13+
'DIAMOND=יהלום'+#13+
'CUBE=קובייה'+#13+
'TRIANGLE=משולש'+#13+
'STAR=כוכב'+#13+
'SQUARE=ריבוע'+#13+
'DOWN TRIANGLE=משולש הפוך'+#13+
'SMALL DOT=נקודה קטנה'+#13+
'LOAD=טעינה'+#13+
'FILE=קובץ'+#13+
'RECTANGLE=מלבן'+#13+
'HEADER=כותרת עליונה'+#13+
'CLEAR=לנקות'+#13+
'ONE HOUR=שעה אחת'+#13+
'ONE YEAR=שנה אחת'+#13+
'ELLIPSE=אליפסה'+#13+
'CONE=חרוט'+#13+
'ARROW=חץ'+#13+
'CYLLINDER=גליל'+#13+
'TIME=זמן'+#13+
'BRUSH=מברשת'+#13+
'LINE=קו'+#13+
'VERTICAL LINE=קו אנכי'+#13+
'AXIS ARROWS=ציר חצים'+#13+
'MARK TIPS=סימנים מכונים'+#13+
'DASH DOT=קו מקווקו'+#13+
'COLOR BAND=פס צבע'+#13+
'COLOR LINE=קו צבע'+#13+
'INVERT. TRIANGLE=משולש הפוך'+#13+
'INVERT. PYRAMID=פירמידה הפוכה'+#13+
'INVERTED PYRAMID=פירמידה הפוכה'+#13+
'SERIES DATASOURCE TEXT EDITOR=עורך טקסט שלמקור נתונים סידרות'+#13+
'SOLID=מוצק'+#13+
'WIREFRAME=מסגרת חוט'+#13+
'DOTFRAME=מסגרת נקודות'+#13+
'SIDE BRUSH=מברשת צדדית'+#13+
'SIDE=צד'+#13+
'SIDE ALL=כל הצדדים'+#13+
'ANNOTATION=פירוש'+#13+
'ROTATE=לסובב'+#13+
'SMOOTH PALETTE=לוח צבעים חלק'+#13+
'CHART TOOLS GALLERY=גלריה של כלים'+#13+
'ADD=להסיף'+#13+
'BORDER EDITOR=עורך גבול'+#13+
'DRAWING MODE=מצב ציור'+#13+
'CLOSE CIRCLE=עיגול סגירה'+#13+
'PICTURE=תמונה'+#13+
'NATIVE=מקומי'+#13+
'DATA=נתונים'+#13+
'KEEP ASPECT RATIO=שמור פרופורציה'+#13+
'COPY=העתק'+#13+
'SAVE=שמור'+#13+
'SEND=שלח'+#13+
'INCLUDE SERIES DATA=לכלול נתונים סידרות'+#13+
'FILE SIZE=גודל של קובץ'+#13+
'INCLUDE=לכלול'+#13+
'POINT INDEX=מדד נקודות'+#13+
'POINT LABELS=תוויות נקודות'+#13+
'DELIMITER=תוחם'+#13+
'DEPTH=עומק'+#13+
'COMPRESSION LEVEL=רמה של דחיסה'+#13+
'COMPRESSION=דחיסה'+#13+
'PATTERNS=תבניות'+#13+
'LABEL=תווית'+#13+
'GROUP SLICES=לקבץ מנות'+#13+
'EXPLODE BIGGEST=לנפץ המנה הגדולה'+#13+
'TOTAL ANGLE=זווית כולל'+#13+
'HORIZ. SIZE=גודל אופקי'+#13+
'VERT. SIZE=גודל אנכי'+#13+
'SHAPES=צורות'+#13+
'INFLATE MARGINS=שוליים מנופחים'+#13+
'QUALITY=איכות'+#13+
'SPEED=מהירות'+#13+
'% QUALITY=איכות%'+#13+
'GRAY SCALE=סולם שחור-לבן'+#13+
'PERFORMANCE=ביצוע'+#13+
'BROWSE=עיון'+#13+
'TILED=פרוש'+#13+
'HIGH=גבוה'+#13+
'LOW=נמוך'+#13+
'DATABASE CHART=תרשים בסיס נתונים'+#13+
'NON DATABASE CHART=תרשים לא בסיס נתונים'+#13+
'HELP=עזרה'+#13+
'NEXT >=הבא >'+#13+
'< BACK=< בחזרה'+#13+
'TEECHART WIZARD=TeeChart אשף'+#13+
'PERCENT=אחוז'+#13+
'PIXELS=פיקסלים'+#13+
'ERROR WIDTH=טעות רוחב'+#13+
'ENHANCED=משופר'+#13+
'VISIBLE WALLS=מחיצות גלויות'+#13+
'ACTIVE=פעיל'+#13+
'DELETE=למחוק'+#13+
'ALIGNMENT=יישור'+#13+
'ADJUST FRAME=להתאים מסגרת'+#13+
'HORIZONTAL=אופקי'+#13+
'VERTICAL=אנכי'+#13+
'VERTICAL POSITION=מיקום אנכי'+#13+
'NUMBER=מספר'+#13+
'LEVELS=רמות'+#13+
'OVERLAP=חפיפה'+#13+
'STACK 100%=ערימה 100%'+#13+
'MOVE=לנוע'+#13+
'CLICK=קליק'+#13+
'DELAY=דחייה'+#13+
'DRAW LINE=לצייר קו'+#13+
'FUNCTIONS=פונקציות'+#13+
'SOURCE SERIES=סידרות מקור'+#13+
'ABOVE=למעלה'+#13+
'BELOW=מתחת ל'+#13+
'Dif. Limit=הגבלה משתנה'+#13+
'WITHIN=בפנים'+#13+
'EXTENDED=מורחב'+#13+
'STANDARD=תקני'+#13+
'STATS=סטטיסטיקה'+#13+
'FINANCIAL=פיננסי'+#13+
'OTHER=אחרים'+#13+
'TEECHART GALLERY=TeeChart גלריה של תרשימים '+#13+
'CONNECTING LINES=קווים מחוברים'+#13+
'REDUCTION=צמצום'+#13+
'LIGHT=אור'+#13+
'INTENSITY=עוצמה'+#13+
'FONT OUTLINES=פונט מיתאר'+#13+
'SMOOTH SHADING=הצללה חלקה'+#13+
'AMBIENT LIGHT=אור מסביב'+#13+
'MOUSE ACTION=פועלת עכבר'+#13+
'CLOCKWISE=בכיוון השעון'+#13+
'ANGLE INCREMENT=הגדלת זווית'+#13+
'RADIUS INCREMENT=הגדלת רדיוס'+#13+
'PRINTER=מדפסת'+#13+
'SETUP=הגדרות'+#13+
'ORIENTATION=אוריאנטציה'+#13+
'PORTRAIT=לאורך'+#13+
'LANDSCAPE=לרוחב'+#13+
'MARGINS (%)= (%) שוליים'+#13+
'MARGINS=שוליים'+#13+
'DETAIL=פרט'+#13+
'MORE=יותר'+#13+
'PROPORTIONAL=פרופורציונלי'+#13+
'VIEW MARGINS=מראה שוליים'+#13+
'RESET MARGINS=לאפס שוליים'+#13+
'PRINT=הדפסה'+#13+
'TEEPREVIEW EDITOR=עורך הצגה מוקדמת'+#13+
'ALLOW MOVE=להרשות לנוע'+#13+
'ALLOW RESIZE=להרשות שינוי גודל'+#13+
'SHOW IMAGE=הצג דמות'+#13+
'DRAG IMAGE=משך דמות'+#13+
'AS BITMAP=כמו ביטמאפ'+#13+
'SIZE %= % גודל'+#13+
'FIELDS=שדות'+#13+
'SOURCE=מקור'+#13+
'SEPARATOR=מפריד'+#13+
'NUMBER OF HEADER LINES=קווים כותרת'+#13+
'COMMA=פסיק'+#13+
'EDITING=עריכה'+#13+
'TAB=טבולציה'+#13+
'SPACE=רווח'+#13+
'ROUND RECTANGLE=ריבוע מעגל'+#13+
'BOTTOM=תחתית'+#13+
'RIGHT=ימין'+#13+
'C PEN= C עט'+#13+
'R PEN=R עט'+#13+
'C LABELS=C תווית'+#13+
'R LABELS=R תווית'+#13+
'MULTIPLE BAR=עמודות רבות'+#13+
'MULTIPLE AREAS=שטחים רבים'+#13+
'STACK GROUP=קבוצה ערימןת'+#13+
'BOTH=שניהם'+#13+
'BACK DIAGONAL=אלכסון אחרי'+#13+
'B.DIAGONAL=אלכסון אחורי'+#13+
'DIAG.CROSS=צלב אלכסוני'+#13+
'WHISKER=שפם'+#13+
'CROSS=צלב'+#13+
'DIAGONAL CROSS=צלב אלכסוני'+#13+
'LEFT RIGHT=משמאל לימין'+#13+
'RIGHT LEFT=מימין לשמאל'+#13+
'FROM CENTER=ממרכז'+#13+
'FROM TOP LEFT=מלמעלה שמאלה'+#13+
'FROM BOTTOM LEFT=מלמטה שמאלה'+#13+
'SHOW WEEKDAYS=הצג ימי חול'+#13+
'SHOW MONTHS=הצג חדשים'+#13+
'TRAILING DAYS=הצג שערית ימים'+#13+
'SHOW TODAY=הצג היום'+#13+
'TRAILING=שערית'+#13+
'LOWERED=מופחת'+#13+
'RAISED=בולט'+#13+
'HORIZ. OFFSET=קיזוז אופקי'+#13+
'VERT. OFFSET=קיזוז אנכי'+#13+
'INNER=פנימי'+#13+
'LEN=אורך'+#13+
'AT LABELS ONLY=רק בתוויות'+#13+
'MAXIMUM=מקסימום'+#13+
'MINIMUM=מינימום'+#13+
'CHANGE=שינוי'+#13+
'LOGARITHMIC=לוגריטמי'+#13+
'LOG BASE=בסיס לוגריטמי'+#13+
'DESIRED INCREMENT=הגדלה רצויה'+#13+
'(INCREMENT)=(הגדלה)'+#13+
'MULTI-LINE=מולטי-קו'+#13+
'MULTI LINE=מולטי-קו'+#13+
'RESIZE CHART=לשנות גודל תרשים'+#13+
'X AND PERCENT=ואחוז X'+#13+
'X AND VALUE=וערך X'+#13+
'RIGHT PERCENT=אחוז ימין'+#13+
'LEFT PERCENT=אחוז שמאל'+#13+
'LEFT VALUE=ערך שמאל'+#13+
'RIGHT VALUE=ערך שמאל'+#13+
'PLAIN=טקסט'+#13+
'LAST VALUES=ערכים אחרונים'+#13+
'SERIES VALUES=ערכים סידרה'+#13+
'SERIES NAMES=שמות סידרה'+#13+
'NEW=חדש'+#13+
'EDIT=עריכה'+#13+
'PANEL COLOR=צבע לוח'+#13+
'TOP BOTTOM=מלמעלה למטה'+#13+
'BOTTOM TOP=מלמטה למעלה'+#13+
'DEFAULT ALIGNMENT=ברירת מחדל של יישור'+#13+
'EXPONENTIAL=מעריכי'+#13+
'LABELS FORMAT=עיצוב תוויות'+#13+
'MIN. SEPARATION %=% הפרדה מינימלית'+#13+
'YEAR=שנה'+#13+
'MONTH=חודש'+#13+
'WEEK=שבוע'+#13+
'WEEKDAY=יום חול'+#13+
'MARK=סימן'+#13+
'ROUND FIRST=עיגול ראשון'+#13+
'LABEL ON AXIS=תווית על הציר'+#13+
'COUNT=ספירה'+#13+
'POSITION %=% מיקום'+#13+
'START %=% התחלה'+#13+
'END %=% סוף'+#13+
'OTHER SIDE=צד שני'+#13+
'INTER-CHAR SPACING=ריווח בין תוים'+#13+
'VERT. SPACING=ריווח אנכי'+#13+
'POSITION OFFSET %=% מיקום הקיזוז'+#13+
'GENERAL=כללי'+#13+
'MANUAL=ידני'+#13+
'PERSISTENT=מתמיד'+#13+
'PANEL=לוח'+#13+
'ALIAS=כינוי'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR= OpenGL עורך'+#13+
'FONT 3D DEPTH=&3D עומק של פונט'+#13+
'NORMAL=נורמלי'+#13+
'TEEFONT EDITOR=עורך פונטים'+#13+
'CLIP POINTS=נקודות הדק'+#13+
'CLIPPED=הודק'+#13+
'3D %=3D %'+#13+
'QUANTIZE=לחלק'+#13+
'QUANTIZE 256=256 לחלק'+#13+
'DITHER=רטט'+#13+
'VERTICAL SMALL=אנכי קטן'+#13+
'HORIZ. SMALL=אופקי קטן'+#13+
'DIAG. SMALL=אלכסוני קטן'+#13+
'BACK DIAG. SMALL=אלכסוני קטן הפוך'+#13+
'DIAG. CROSS SMALL=צלב קטן אלכסוני'+#13+
'MINIMUM PIXELS=מינימום פיקסלים'+#13+
'ALLOW SCROLL=להרשות פס גלילה'+#13+
'SWAP=החלפה'+#13+
'GRADIENT EDITOR=עורך הדרגה'+#13+
'TEXT STYLE=סיגנון של טקסט'+#13+
'DIVIDING LINES=קוי הפרדה'+#13+
'SYMBOLS=סמלים'+#13+
'CHECK BOXES=תיבות סימון'+#13+
'FONT SERIES COLOR=צבע סידרה'+#13+
'LEGEND STYLE=סיגנון של מקרא'+#13+
'POINTS PER PAGE=נקודות בדף'+#13+
'SCALE LAST PAGE=להעפיל דף אחרון'+#13+
'CURRENT PAGE LEGEND=מקרא של הדף הנוכחי'+#13+
'BACKGROUND=רקע'+#13+
'BACK IMAGE=תמונת רקע'+#13+
'STRETCH=מתח'+#13+
'TILE=פרוש'+#13+
'BORDERS=גבולות'+#13+
'CALCULATE EVERY=לחשב הכל'+#13+
'NUMBER OF POINTS=מספר נקודות'+#13+
'RANGE OF VALUES=תחום ערכים'+#13+
'FIRST=ראשון'+#13+
'LAST=אחרון'+#13+
'ALL POINTS=כל הנקודות'+#13+
'DATA SOURCE=מקור נתונים'+#13+
'WALLS=דפנות'+#13+
'PAGING=דיפדוף'+#13+
'CLONE=עותק'+#13+
'TITLES=כותרות'+#13+
'TOOLS=כלים'+#13+
'EXPORT=יצוא'+#13+
'CHART=תרשים'+#13+
'BACK=רקע'+#13+
'LEFT AND RIGHT=שמאל וימין'+#13+
'SELECT A CHART STYLE=בחר סיגנון של תרשים'+#13+
'SELECT A DATABASE TABLE=בחר טבלה בבסיס נתונים'+#13+
'TABLE=טבלה'+#13+
'SELECT THE DESIRED FIELDS TO CHART=בחר שדות לתרשים'+#13+
'SELECT A TEXT LABELS FIELD=בחר שדה לתווית'+#13+
'CHOOSE THE DESIRED CHART TYPE=בחר סוג של תרשים'+#13+
'CHART PREVIEW=הצג תרשים לפני הדפסה'+#13+
'SHOW LEGEND=הצג מקרא'+#13+
'SHOW MARKS=הצג סימנים'+#13+
'FINISH=לסיים'+#13+
'RANDOM=אקראי'+#13+
'DRAW EVERY=צייר הכל'+#13+
'ARROWS=חצים'+#13+
'ASCENDING=סדר עולנ'+#13+
'DESCENDING=סדר יורד'+#13+
'VERTICAL AXIS=ציר אנכי'+#13+
'DATETIME=תאריך/זמן'+#13+
'TOP AND BOTTOM=עליון ותחתון'+#13+
'HORIZONTAL AXIS=ציר אופקי'+#13+
'PERCENTS=אחוזים'+#13+
'VALUES=ערכים'+#13+
'FORMATS=פורמטים'+#13+
'SHOW IN LEGEND=הצג במקרא'+#13+
'SORT=מיון'+#13+
'MARKS=סימנים'+#13+
'BEVEL INNER=שיפוע פנימי'+#13+
'BEVEL OUTER=שיפוע חיצוני'+#13+
'PANEL EDITOR=עורך פנלים'+#13+
'CONTINUOUS=רצוף'+#13+
'HORIZ. ALIGNMENT=יישור אופקי'+#13+
'EXPORT CHART=יצוא תרשים'+#13+
'BELOW %= %מתחת ל-'+#13+
'BELOW VALUE=מתחת לערך'+#13+
'NEAREST POINT=הנקודה הקרובה'+#13+
'DRAG MARKS=גרר סימנים'+#13+
'TEECHART PRINT PREVIEW=הצג לפני הדפסה'+#13+
'X VALUE=ערך X'+#13+
'X AND Y VALUES=ערכים X וY'+#13+
'SHININESS=ברק'+#13+
'ALL SERIES VISIBLE=כל הסידרות גלויות'+#13+
'MARGIN=שוליים'+#13+
'DIAGONAL=אלכסון'+#13+
'LEFT TOP=עליון שמאלי'+#13+
'LEFT BOTTOM=תחתון שמאלי'+#13+
'RIGHT TOP=עליון ימין'+#13+
'RIGHT BOTTOM=תחתון ימין'+#13+
'EXACT DATE TIME=תאריך/זמן מדוייק'+#13+
'RECT. GRADIENT=הדרגה'+#13+
'CROSS SMALL=צלב קטן'+#13+
'AVG=ממוצע'+#13+
'FUNCTION=פונקציה'+#13+
'AUTO=אוטו'+#13+
'ONE MILLISECOND=מילישנייה אחת'+#13+
'ONE SECOND=שניה אחת'+#13+
'FIVE SECONDS=חמש שניות'+#13+
'TEN SECONDS=עשר שניות'+#13+
'FIFTEEN SECONDS=חמש-עשרה שניות'+#13+
'THIRTY SECONDS=שלושים שניות'+#13+
'ONE MINUTE=דקה אחת'+#13+
'FIVE MINUTES=חמש דקות'+#13+
'TEN MINUTESעשר דקות'+#13+
'FIFTEEN MINUTES=חמש-עשרה דקות'+#13+
'THIRTY MINUTES=שלושים דקות'+#13+
'TWO HOURS=שתיים שעות'+#13+
'TWO HOURS=שתיים שעות'+#13+
'SIX HOURS=שש שעות'+#13+
'TWELVE HOURS=שתיים-עשר שעות'+#13+
'ONE DAY=יום אחד'+#13+
'TWO DAYS=שני ימים'+#13+
'THREE DAYS=שלושה ימים'+#13+
'ONE WEEK=שבוע אחד'+#13+
'HALF MONTH=חצי-חודש'+#13+
'ONE MONTH=חודש אחד'+#13+
'TWO MONTHS=שני חדשים'+#13+
'THREE MONTHS=שלושה חדשים'+#13+
'FOUR MONTHS=ארבעה חודשים'+#13+
'SIX MONTHS=ששה חדשים'+#13+
'IRREGULAR=חריג'+#13+
'CLICKABLE=קליק אפשרי'+#13+
'ROUND=עגול'+#13+
'FLAT=שתוח'+#13+
'PIE=עוגה'+#13+
'HORIZ. BAR=עמודה אופקית'+#13+
'BUBBLE=בועה'+#13+
'SHAPE=צורה'+#13+
'POINT=נקודה'+#13+
'FAST LINE=קו מהיר'+#13+
'CANDLE=נר'+#13+
'VOLUME=נפח'+#13+
'HORIZ LINE=קו אופקי'+#13+
'SURFACE=משטח'+#13+
'LEFT AXIS=ציר שמאלי'+#13+
'RIGHT AXIS=ציר ימין'+#13+
'TOP AXIS=ציר עליון'+#13+
'BOTTOM AXIS=ציר תחתון'+#13+
'CHANGE SERIES TITLE=תשנה את הכותרת של סידרה'+#13+
'NEW SERIES TITLE:=כותרת סידרה חדשה'+#13+
'DELETE %S ?=לימחוק %s ?'+#13+
'DESIRED %S INCREMENT= %s הגדלה רצוייה'+#13+
'INCORRECT VALUE. REASON: %S= %s: ערך לא נכון - סיבה'+#13+
'FillSampleValues NumValues must be > 0=הייבים ליהות > 0 FillSample ערכים'#13+
'VISIT OUR WEB SITE != !שלנו Web נא לבקר את האתר'#13+
'SHOW PAGE NUMBER=הצג מספר דף'#13+
'PAGE NUMBER=מספר דף'#13+
'PAGE %D OF %D= %d מ %d דף'#13+
'TEECHART LANGUAGE SELECTOR=TeeChart שפות של'#13+
'CHOOSE A LANGUAGE=בחר שפה'+#13+
'SELECT ALL=בחר הכל'#13+
'MOVE UP=נע למעלה'#13+
'MOVE DOWN=נע למטה'#13
;
  end;
end;

Procedure TeeSetHebrew;
begin
  TeeCreateHebrew;
  TeeLanguage:=TeeHebrewLanguage;
  TeeHebrewConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeHebrewLanguage);
end.
