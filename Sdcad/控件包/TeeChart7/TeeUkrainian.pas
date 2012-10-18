unit TeeUkrainian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeUkrainianLanguage:TStringList=nil;

Procedure TeeSetUkrainian;
Procedure TeeCreateUkrainian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeUkrainianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 Давід Бернеда';
  TeeMsg_LegendFirstValue   :='Перше значення легенди повинно бути > 0';
  TeeMsg_LegendColorWidth   :='Товщина кольору легенди повинна бути > 0%';
  TeeMsg_SeriesSetDataSource:='Немає батьківського графіка, щоб перевірити джерело даних';
  TeeMsg_SeriesInvDataSource:='Неправильне джерело даних: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues повинні бути > 0';
  TeeMsg_AxisLogDateTime    :='Тимчасова вісь не може бути логарифмічною';
  TeeMsg_AxisLogNotPositive :='Мін. і Макс. значення логарифмічної осі повинні бути >= 0';
  TeeMsg_AxisLabelSep       :='Роздільники підписів % повинні бути більше 0';
  TeeMsg_AxisIncrementNeg   :='Крок осі повинний бути >= 0';
  TeeMsg_AxisMinMax         :='Мінімальне значення осі повинно бути <= Максимального';
  TeeMsg_AxisMaxMin         :='Максимальне значення осі повинно бути >= Мінімального';
  TeeMsg_AxisLogBase        :='Корінь логарифмічної осі повинний бути >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage повинно бути >= 0';
  TeeMsg_3dPercent          :='Відсотки 3D ефекту повинні бути між %d и %d';
  TeeMsg_CircularSeries     :='Залежності від кругових серій неприпустимі';
  TeeMsg_WarningHiColor     :='16k Колір чи більший потрібен для кращого виду';

  TeeMsg_DefaultPercentOf   :='%s з %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'з %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Заголовки осей';
  TeeMsg_AxisLabels         :='Підписи осей';
  TeeMsg_RefreshInterval    :='Інтервал відновлення повинний бути між 0 и 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart не може бути самим собою!';
  TeeMsg_GalleryLine        :='Лінія';
  TeeMsg_GalleryPoint       :='Точка';
  TeeMsg_GalleryArea        :='Площа';
  TeeMsg_GalleryBar         :='Брусок';
  TeeMsg_GalleryHorizBar    :='Гориз. брусок';
  TeeMsg_Stack              :='Стек';
  TeeMsg_GalleryPie         :='Пиріг';
  TeeMsg_GalleryCircled     :='Кругова';
  TeeMsg_GalleryFastLine    :='Проста лінія';
  TeeMsg_GalleryHorizLine   :='Гориз. лінія';

  TeeMsg_PieSample1         :='Машини';
  TeeMsg_PieSample2         :='Телефони';
  TeeMsg_PieSample3         :='Таблиці';
  TeeMsg_PieSample4         :='Монітори';
  TeeMsg_PieSample5         :='Лампи';
  TeeMsg_PieSample6         :='Клавіатури';
  TeeMsg_PieSample7         :='Велосіпеди';
  TeeMsg_PieSample8         :='Стільці';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Редагування %s';

  TeeMsg_GalleryStandard    :='Стандартні';
  TeeMsg_GalleryExtended    :='Розширені';
  TeeMsg_GalleryFunctions   :='Функції';

  TeeMsg_EditChart          :='Р&едакт. графік...';
  TeeMsg_PrintPreview       :='&Попередній перегляд...';
  TeeMsg_ExportChart        :='Е&кспортувати графік...';
  TeeMsg_CustomAxes         :='Настр. осі...';

  TeeMsg_InvalidEditorClass :='%s: Неправильний редактор класу: %s';
  TeeMsg_MissingEditorClass :='%s: немає діалогу Редактора';

  TeeMsg_GalleryArrow       :='Стріла';

  TeeMsg_ExpFinish          :='&Фініш';
  TeeMsg_ExpNext            :='&Наступний >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Дизайн';
  TeeMsg_GanttSample2       :='Створення прототипу';
  TeeMsg_GanttSample3       :='Розробка';
  TeeMsg_GanttSample4       :='Продаж';
  TeeMsg_GanttSample5       :='Маркетинг';
  TeeMsg_GanttSample6       :='Тестування';
  TeeMsg_GanttSample7       :='Виробництво';
  TeeMsg_GanttSample8       :='Налагодження';
  TeeMsg_GanttSample9       :='Нова Версія';
  TeeMsg_GanttSample10      :='Фінанси';

  TeeMsg_ChangeSeriesTitle  :='Змініть назву серії';
  TeeMsg_NewSeriesTitle     :='Нова назва серії:';
  TeeMsg_DateTime           :='ДатаЧас';
  TeeMsg_TopAxis            :='Верхня вісь';
  TeeMsg_BottomAxis         :='Нижня вісь';
  TeeMsg_LeftAxis           :='Ліва вісь';
  TeeMsg_RightAxis          :='Права вісь';

  TeeMsg_SureToDelete       :='Видалити %s ?';
  TeeMsg_DateTimeFormat     :='Фор&мат ДатыЧасу:';
  TeeMsg_Default            :='За замовчуванням';
  TeeMsg_ValuesFormat       :='Ф&ормат значень:';
  TeeMsg_Maximum            :='Максимум';
  TeeMsg_Minimum            :='Мінімум';
  TeeMsg_DesiredIncrement   :='Бажане %s прирощення';

  TeeMsg_IncorrectMaxMinValue:='Неправильне значення. Через: %s';
  TeeMsg_EnterDateTime      :='Введіть [Число днів] [гг:мм:сс]';

  TeeMsg_SureToApply        :='Застосувати зміни ?';
  TeeMsg_SelectedSeries     :='(Обрані серії)';
  TeeMsg_RefreshData        :='&Оновити дані';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='484';
  TeeMsg_FunctionAdd        :='Скласти';
  TeeMsg_FunctionSubtract   :='Відняти';
  TeeMsg_FunctionMultiply   :='Помножити';
  TeeMsg_FunctionDivide     :='Розділити';
  TeeMsg_FunctionHigh       :='Високий';
  TeeMsg_FunctionLow        :='Низький';
  TeeMsg_FunctionAverage    :='Середній';

  TeeMsg_GalleryShape       :='Фігура';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='Копіювати';

  TeeMsg_None               :='(нічого)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Розмір точки повинний бути більше нуля';
  TeeMsg_About              :='&Про TeeChart...';

  tcAdditional              :='Додатково';
  tcDControls               :='Керування даними';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Набір даних';
  TeeMsg_AskDataSet         :='&Набір даних:';

  TeeMsg_SingleRecord       :='Єдиний запис';
  TeeMsg_AskDataSource      :='&Джерело Даних:';

  TeeMsg_Summary            :='Разом';

  TeeMsg_FunctionPeriod     :='Період функції повинний бути >= 0';

  TeeMsg_WizardTab          :='Бізнес';
  TeeMsg_TeeChartWizard     :='TeeChart Майстер';

  TeeMsg_ClearImage         :='Очис&тити';
  TeeMsg_BrowseImage        :='О&гляд...';

  TeeMsg_WizardSureToClose  :='Ви упевнені, що хочете закрит Майстера TeeChart ?';
  TeeMsg_FieldNotFound      :='Поле %s не існує';

  TeeMsg_DepthAxis          :='Вісь глубини';
  TeeMsg_PieOther           :='Інші';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Пиріг';
  TeeMsg_ValuesBar          :='Брусок';
  TeeMsg_ValuesAngle        :='Кут';
  TeeMsg_ValuesGanttStart   :='Пуск';
  TeeMsg_ValuesGanttEnd     :='Фініш';
  TeeMsg_ValuesGanttNextTask:='Наступна задача';
  TeeMsg_ValuesBubbleRadius :='Радіус';
  TeeMsg_ValuesArrowEndX    :='ОстаннійX';
  TeeMsg_ValuesArrowEndY    :='ОстаннійY';
  TeeMsg_Legend             :='Легенда';
  TeeMsg_Title              :='Назва';
  TeeMsg_Foot               :='Нижній подпис';
  TeeMsg_Period		          :='Період';
  TeeMsg_PeriodRange        :='Діапазон періоду';
  TeeMsg_CalcPeriod         :='Обчислювати %s кожні:';
  TeeMsg_SmallDotsPen       :='Маленькі точки';

  TeeMsg_InvalidTeeFile     :='Неправильний графік у *.'+TeeMsg_TeeExtension+' файлі';
  TeeMsg_WrongTeeFileFormat :='Неправильний формат *.'+TeeMsg_TeeExtension+' файлу';
  TeeMsg_EmptyTeeFile       :='Порожній *.'+TeeMsg_TeeExtension+' файл';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Осі графіка';
  TeeMsg_ChartAxesCategoryDesc   := 'Властивості і події графіка';
  TeeMsg_ChartWallsCategoryName  := 'Стіни графіка';
  TeeMsg_ChartWallsCategoryDesc  := 'Властивості і події стін графіка';
  TeeMsg_ChartTitlesCategoryName := 'Підписи графіка';
  TeeMsg_ChartTitlesCategoryDesc := 'Властивості і події підписів графіка';
  TeeMsg_Chart3DCategoryName     := '3D Графік';
  TeeMsg_Chart3DCategoryDesc     := 'Властивості і події 3D графіка';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Свій ';
  TeeMsg_Series                 :='Серії';
  TeeMsg_SeriesList             :='Серії...';

  TeeMsg_PageOfPages            :='Сторінка %d з %d';
  TeeMsg_FileSize               :='%d байт';

  TeeMsg_First  :='Перший';
  TeeMsg_Prior  :='Попередній';
  TeeMsg_Next   :='Наступний';
  TeeMsg_Last   :='Останній';
  TeeMsg_Insert :='Вставити';
  TeeMsg_Delete :='Видалити';
  TeeMsg_Edit   :='Редагувати';
  TeeMsg_Post   :='Відправити';
  TeeMsg_Cancel :='Відмінити';

  TeeMsg_All    :='(усі)';
  TeeMsg_Index  :='Індекс';
  TeeMsg_Text   :='Текст';

  TeeMsg_AsBMP        :='як &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='як &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Властивості панелі не встановлені у формат експорту';

  TeeMsg_Normal    :='Номарльно';
  TeeMsg_NoBorder  :='Без границі';
  TeeMsg_Dotted    :='Точками';
  TeeMsg_Colors    :='Кольори';
  TeeMsg_Filled    :='Заповнений';
  TeeMsg_Marks     :='Позначки';
  TeeMsg_Stairs    :='Сходи';
  TeeMsg_Points    :='Точок';
  TeeMsg_Height    :='Висота';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='Точка 2D';
  TeeMsg_Triangle  :='Трикутник';
  TeeMsg_Star      :='Зірка';
  TeeMsg_Circle    :='Коло';
  TeeMsg_DownTri   :='Вниз Три.';
  TeeMsg_Cross     :='Хрест';
  TeeMsg_Diamond   :='Алмаз';
  TeeMsg_NoLines   :='Без ліній';
  TeeMsg_Stack100  :='Стек 100%';
  TeeMsg_Pyramid   :='Піраміда';
  TeeMsg_Ellipse   :='Еліпс';
  TeeMsg_InvPyramid:='Непр. піраміда';
  TeeMsg_Sides     :='Сторони';
  TeeMsg_SideAll   :='Усі сторони';
  TeeMsg_Patterns  :='Шаблони';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='Тінь';
  TeeMsg_SemiPie   :='Напів-труба';
  TeeMsg_Rectangle :='Трикутник';
  TeeMsg_VertLine  :='Верт. лінія';
  TeeMsg_HorizLine :='Гориз. лінія';
  TeeMsg_Line      :='Лінія';
  TeeMsg_Cube      :='Куб';
  TeeMsg_DiagCross :='Диаг. хрест';

  TeeMsg_CanNotFindTempPath    :='Не можу знайти тимчасову папку';
  TeeMsg_CanNotCreateTempChart :='Не можу створити тимчасовий файл';
  TeeMsg_CanNotEmailChart      :='Не можу відправити TeeChart. Помилка Mapi : %d';

  TeeMsg_SeriesDelete :='Видалення серій: ValueIndex %d за границями (0 до %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='як &JPEG';
  TeeMsg_JPEGFilter    :='JPEG файли (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='як &GIF';
  TeeMsg_GIFFilter     :='GIF файли (*.gif)|*.gif';
  TeeMsg_AsPNG         :='як &PNG';
  TeeMsg_PNGFilter     :='PNG файли (*.png)|*.png';
  TeeMsg_AsPCX         :='як PC&X';
  TeeMsg_PCXFilter     :='PCX файли (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Мова...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Поляр';
  TeeMsg_GalleryCandle      :='Свіча';
  TeeMsg_GalleryVolume      :='Обєм';
  TeeMsg_GallerySurface     :='Покриття';
  TeeMsg_GalleryContour     :='Контур';
  TeeMsg_GalleryBezier      :='Безье';
  TeeMsg_GalleryPoint3D     :='3D точка';
  TeeMsg_GalleryRadar       :='Радар';
  TeeMsg_GalleryDonut       :='Горіх';
  TeeMsg_GalleryCursor      :='Курсор';
  TeeMsg_GalleryBar3D       :='3D Брусок';
  TeeMsg_GalleryBigCandle   :='Велика свіча';
  TeeMsg_GalleryLinePoint   :='Точка лінія';
  TeeMsg_GalleryHistogram   :='Гістограма';
  TeeMsg_GalleryWaterFall   :='Водоспад';
  TeeMsg_GalleryWindRose    :='Роза вітрів';
  TeeMsg_GalleryClock       :='Годинник';
  TeeMsg_GalleryColorGrid   :='Кольорова Сітка';
  TeeMsg_GalleryBoxPlot     :='Коробка';
  TeeMsg_GalleryHorizBoxPlot:='Гориз. коробка';
  TeeMsg_GalleryBarJoin     :='Присоєд. брусок';
  TeeMsg_GallerySmith       :='Сміт';
  TeeMsg_GalleryPyramid     :='Піраміда';
  TeeMsg_GalleryMap         :='Карта';

  TeeMsg_PolyDegreeRange    :='Polynomial degree повинний бути між 1 и 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index повинний бути між 1 и %d';
  TeeMsg_FittingError        :='Не можу підібрати криву';
  TeeMsg_PeriodRange         :='Період повинний бути >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage вага повинна бути між 0 and 1';
  TeeMsg_GalleryErrorBar     :='Помилковий брусок';
  TeeMsg_GalleryError        :='Помилка';
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

  TeeMsg_FunctionCount       :='Рахувати';
  TeeMsg_LoadChart           :='Відкрити TeeChart...';
  TeeMsg_SaveChart           :='Зберегти TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro файли';

  TeeMsg_GallerySamples      :='Інші';
  TeeMsg_GalleryStats        :='Статистика';

  TeeMsg_CannotFindEditor    :='Не можу знайти редактор форми : %s';


  TeeMsg_CannotLoadChartFromURL:='Код помилки: %d загрузка графіка з URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Код помилки: %d загрузка даних серій з URL: %s';

  TeeMsg_Test                :='Тест...';

  TeeMsg_ValuesDate          :='Дата';
  TeeMsg_ValuesOpen          :='Відкриття';
  TeeMsg_ValuesHigh          :='Вища';
  TeeMsg_ValuesLow           :='Нижча';
  TeeMsg_ValuesClose         :='Закриття';
  TeeMsg_ValuesOffset        :='Зміщення';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='3D сітка';

  TeeMsg_LowBezierPoints     :='Кількість точек безье повинна бути > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Нормально';
  TeeCommanMsg_Edit     :='Редагування';
  TeeCommanMsg_Print    :='Друк';
  TeeCommanMsg_Copy     :='Копіювати';
  TeeCommanMsg_Save     :='Зберегти';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Обертання: %d° Нахил: %d°';
  TeeCommanMsg_Rotate   :='Обертання';

  TeeCommanMsg_Moving   :='Гориз.зсув: %d Верт. зсув: %d';
  TeeCommanMsg_Move     :='Рухати';

  TeeCommanMsg_Zooming  :='Наближ: %d %%';
  TeeCommanMsg_Zoom     :='Наближення';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Глибина';

  TeeCommanMsg_Chart    :='Графік';
  TeeCommanMsg_Panel    :='Панель';

  TeeCommanMsg_RotateLabel:='Натисни %s для обертання';
  TeeCommanMsg_MoveLabel  :='Натисни %s для руху';
  TeeCommanMsg_ZoomLabel  :='Натисни %s для наближення';
  TeeCommanMsg_DepthLabel :='Натисни %s для зміни розміру 3D';

  TeeCommanMsg_NormalLabel:='Натисніть Ліву кнопку для наближення, Праву кнопку для скролла';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='Кількість точек повинна бути >= 4';
  TeeMsg_TriSurfaceAllColinear :='Усі колінеарні точки даних';
  TeeMsg_TriSurfaceSimilar     :='Схожі точки - не можу запустити';
  TeeMsg_GalleryTriSurface     :='Трикутникова поверхн.';

  TeeMsg_AllSeries :='Усі серії';
  TeeMsg_Edit      :='Редагувати';

  TeeMsg_GalleryFinancial    :='Фінанси';

  TeeMsg_CursorTool    :='Курсор';
  TeeMsg_DragMarksTool :='Drag позначки';
  TeeMsg_AxisArrowTool :='Стрілки осей';
  TeeMsg_DrawLineTool  :='Намалювати лінію';
  TeeMsg_NearestTool   :='Найближча точка';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Кольорова лінія';
  TeeMsg_RotateTool    :='Обертання';
  TeeMsg_ImageTool     :='Зображення';
  TeeMsg_MarksTipTool  :='Підказки позначок';

  TeeMsg_CantDeleteAncestor  :='Не можу видалити ancestor';

  TeeMsg_Load	          :='Загузка...';
  TeeMsg_NoSeriesSelected :='Серії не обрані';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Графік';
  TeeMsg_CategorySeriesActions :='Серії графіка';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Переключення 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Активний';
  TeeMsg_ActionSeriesActiveHint := 'Показати / Сховати серії';
  TeeMsg_ActionEditHint         := 'Редагувати графік';
  TeeMsg_ActionEdit             := '&Редагувати...';
  TeeMsg_ActionCopyHint         := 'Копіювати в буфер';
  TeeMsg_ActionCopy             := '&Копіювати';
  TeeMsg_ActionPrintHint        := 'Попередній перегляд графіка';
  TeeMsg_ActionPrint            := '&Друк...';
  TeeMsg_ActionAxesHint         := 'Показати / Сховати осі';
  TeeMsg_ActionAxes             := '&Осі';
  TeeMsg_ActionGridsHint        := 'Показати / Сховати сітку';
  TeeMsg_ActionGrids            := '&Сітка';
  TeeMsg_ActionLegendHint       := 'Показати / Сховати легенду';
  TeeMsg_ActionLegend           := '&Легенда';
  TeeMsg_ActionSeriesEditHint   := 'Редагувати серії';
  TeeMsg_ActionSeriesMarksHint  := 'Показати / Сховати позначки серій';
  TeeMsg_ActionSeriesMarks      := '&Позначки';
  TeeMsg_ActionSaveHint         := 'Зберегти графік';
  TeeMsg_ActionSave             := '&Зберегти...';

  TeeMsg_CandleBar              := 'Брусок';
  TeeMsg_CandleNoOpen           := 'Немає відкриття';
  TeeMsg_CandleNoClose          := 'Немає закриття';
  TeeMsg_NoLines                := 'Немає ліній';
  TeeMsg_NoHigh                 := 'Немає вищої';
  TeeMsg_NoLow                  := 'Немає нижчої';
  TeeMsg_ColorRange             := 'Вибір кольору';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := 'Позиції';
  TeeMsg_NoGrid                 := 'Немає сітки';
  TeeMsg_NoPoint                := 'Немає точек';
  TeeMsg_NoLine                 := 'Немає лінії';
  TeeMsg_Labels                 := 'Підписи';
  TeeMsg_NoCircle               := 'Немає кіл';
  TeeMsg_Lines                  := 'Лінії';
  TeeMsg_Border                 := 'Обрамлення';

  TeeMsg_SmithResistance      := 'Resistance';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := 'Стовпець';

  { 5.01 }
  TeeMsg_Separator            := 'Роздільник';
  TeeMsg_FunnelSegment        := 'Сегмент ';
  TeeMsg_FunnelSeries         := 'Туннель';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Перевищує межі';
  TeeMsg_FunnelWithin         := ' у межах';
  TeeMsg_FunnelBelow          := ' чи нижче меж';
  TeeMsg_CalendarSeries       := 'Календар';
  TeeMsg_DeltaPointSeries     := 'Точка Дельти';
  TeeMsg_ImagePointSeries     := 'Точка зображення';
  TeeMsg_ImageBarSeries       := 'Зображення бруска';
  TeeMsg_SeriesTextFieldZero  := 'Текст серій: кілкість серій повинна бути більше нуля.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Прозорість';
  TeeMsg_Box		      := 'Ящик';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Номер сторінки';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX реліз' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Неможна імпортувати TeeChart з %s';
  TeeMsg_ActiveXVerbPrint    := '&Попередній перегляд...';
  TeeMsg_ActiveXVerbExport   := 'Е&кспорт...';
  TeeMsg_ActiveXVerbImport   := '&Імпорт...';
  TeeMsg_ActiveXVerbHelp     := '&Допомога...';
  TeeMsg_ActiveXVerbAbout    := '&Про TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Error code: %d загрузка: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataSource - не Серія або не RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Неправильний тип Серії';
  TeeMsg_AxisTextSrcError    := 'Неправильний тип осі';
  TeeMsg_DelSeriesDatasource := 'Ви впевнені, що хочете видалити %s ?';
  TeeMsg_OCXNoPrinter        := 'Не встановлено принтер за замовченням';
  TeeMsg_ActiveXPictureNotValid:='Не вірний малюнок';

  // 6.0
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='як &PDF';
  TeeMsg_PDFFilter        :='PDF файли (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='як PostScript';
  TeeMsg_PSFilter         :='PostScript файли (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Горизонтальна'#13'поверхність';
  TeeMsg_SelfStack        :='Само скомпонований';
  TeeMsg_DarkPen          :='Темна границя';
  TeeMsg_SelectFolder     :='Оберіть папку з базою даних';
  TeeMsg_BDEAlias         :='&Псевдонім:';
  TeeMsg_ADOConnection    :='&Зв''язок:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Згладжування';
  TeeMsg_FunctionCross        :='Точки схрещення';
  TeeMsg_GridTranspose        :='Переміщення 3D сітки';
  TeeMsg_FunctionCompress     :='Компресія';
  TeeMsg_ExtraLegendTool      :='Додадкова Легенда';
  TeeMsg_FunctionCLV          :='Закрити значення'#13'положення';
  TeeMsg_FunctionOBV          :='Вкл. баланс'#13'звуку';
  TeeMsg_FunctionCCI          :='Індекс'#13'каналу продукта';
  TeeMsg_FunctionPVO          :='Генератор'#13'звуку';
  TeeMsg_SeriesAnimTool       :='Анімація серії';
  TeeMsg_GalleryPointFigure   :='Точка & Фігура';
  TeeMsg_Up                   :='Вгору';
  TeeMsg_Down                 :='Вниз';
  TeeMsg_GanttTool            :='Графік Грантта';
  TeeMsg_XMLFile              :='XML файл';
  TeeMsg_GridBandTool         :='Інструмент ширини сітки';
  TeeMsg_FunctionPerf         :='Продуктивність';
  TeeMsg_GalleryGauge         :='Масштаб';
  TeeMsg_GalleryGauges        :='Масштаби';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='3D вектор';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Вежа';
  TeeMsg_SingleColor          :='Один колір';
  TeeMsg_Cover                :='Покриття';
  TeeMsg_Cone                 :='Конус';
  TeeMsg_PieTool              :='Частини пирога';

  // 7.0
  TeeMsg_View2D               :='2D';
  TeeMsg_Outline              :='Абріс';

  TeeMsg_Stop                 :='Стоп';
  TeeMsg_Execute              :='Виконати !';
  TeeMsg_Themes               :='Теми';
  TeeMsg_LightTool            :='2D Підсвітка';
  TeeMsg_Current              :='Поточний';
  TeeMsg_FunctionCorrelation  :='Кореляція';
  TeeMsg_FunctionVariance     :='Дисперсія';
  TeeMsg_GalleryBubble3D      :='Пузир 3D';
  TeeMsg_GalleryHorizHistogram:='Горізонтальна'#13'Гістограма';
  TeeMsg_FunctionPerimeter    :='Периметр';
  TeeMsg_SurfaceNearestTool   :='Найближча поверхня';
  TeeMsg_AxisScrollTool       :='Прокручування Осей';
  TeeMsg_RectangleTool        :='Прямокутник';
  TeeMsg_GalleryPolarBar      :='Полярний брусок';
  TeeMsg_AsWapBitmap          :='Wap Bitmap';
  TeeMsg_WapBMPFilter         :='Wap Bitmaps (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='Усічена Серія';
  TeeMsg_SeriesBandTool       :='Бенд Серії';
end;

Procedure TeeCreateUkrainian;
begin
  if not Assigned(TeeUkrainianLanguage) then
  begin
    TeeUkrainianLanguage:=TStringList.Create;
    TeeUkrainianLanguage.Text:=
'GRADIENT EDITOR=Редактор градієнта'#13+
'GRADIENT=Градієнт'#13+
'DIRECTION=Напрямок'#13+
'TOP BOTTOM=Зверху вниз'#13+
'BOTTOM TOP=Знизу вверх'#13+
'LEFT RIGHT=Зліва направо'#13+
'RIGHT LEFT=Справа наліво'#13+
'FROM CENTER=З центру'#13+
'FROM TOP LEFT=З Верхнього лівого кута'#13+
'FROM BOTTOM LEFT=З Нижнього лівого кута '#13+
'OK=Ok'#13+
'CANCEL=Відмінити'#13+
'COLORS=Кольори'#13+
'START=Початок'#13+
'END=Кінець'#13+
'SWAP=Обміняти'#13+
'NO MIDDLE=Без середини'#13+
'TEEFONT EDITOR=Редактор шрифтів'#13+
'INTER-CHAR SPACING=Межсимвольна відстань'#13+
'FONT=Шрифт'#13+
'SHADOW=Тінь'#13+
'HORIZ. SIZE=Гориз. розмір'#13+
'VERT. SIZE=Верт. розмір'#13+
'COLOR=Колір'#13+
'OUTLINE=Контур'#13+
'OPTIONS=Опції'#13+
'FORMAT=Формат'#13+
'TEXT=Текст'#13+
'POSITION=Позиція'#13+
'LEFT=Зліва'#13+'TOP=Зверху'#13+
'AUTO=Авто'#13+
'CUSTOM=Індивідуально'#13+
'LEFT TOP=З лівого верхнього кута'#13+
'LEFT BOTTOM=З лівого нижнього кута'#13+
'RIGHT TOP=З правого верхнього кута'#13+
'RIGHT BOTTOM=З правого нижнього кута'#13+
'MULTIPLE AREAS=Декілька областей'#13+
'NONE=Нічого'#13+
'STACKED=Стопкою'#13+
'STACKED 100%=Стопкою 100%'#13+
'AREA=Область'#13+
'PATTERN=Шаблон'#13+
'STAIRS=Сходи'#13+
'SOLID=Безперервний'#13+
'CLEAR=Очистити'#13+
'HORIZONTAL=Горизонтально'#13+
'VERTICAL=Вертикально'#13+
'DIAGONAL=Діагонально'#13+
'B.DIAGONAL=Б.Діагонально'#13+
'CROSS=Хрест'#13+
'DIAG.CROSS=Діаг. хрест'#13+
'AREA LINES=Лінії області'#13+
'BORDER=Границя'#13+
'INVERTED=Інвертований'#13+
'INVERTED SCROLL=Інвертований скролл'#13+
'COLOR EACH=Колір кожного'#13+
'ORIGIN=Зміщення'#13+
'USE ORIGIN=Використовувати зміщення'#13+
'WIDTH=Ширина'#13+
'HEIGHT=Висота'#13+
'AXIS=Вісь'#13+
'LENGTH=Довжина'#13+
'SCROLL=Прокручування'#13+
'BOTH=Оба'#13+
'AXIS INCREMENT=Крок осі'#13+
'INCREMENT=Крок'#13+
'STANDARD=Стандартно'#13+
'ONE MILLISECOND=Одна мілісекунда'#13+
'ONE SECOND=Одна секунда'#13+
'FIVE SECONDS=Пять секунд'#13+
'TEN SECONDS=Десять секунд'#13+
'FIFTEEN SECONDS=Пятнадцять секунд'#13+'THIRTY SECONDS=Тридцять секунд'#13+
'ONE MINUTE=Одна хвилина'#13+
'FIVE MINUTES=Пять хвилин'#13+
'TEN MINUTES=Десять хвилин'#13+
'FIFTEEN MINUTES=Пятнадцять хвилин'#13+
'THIRTY MINUTES=Тридцять хвилин'#13+
'ONE HOUR=Одна година'#13+
'TWO HOURS=Дві години'#13+
'SIX HOURS=Шість годин'#13+
'TWELVE HOURS=Дванадцять годин'#13+
'ONE DAY=Один день'#13+
'TWO DAYS=Два дні'#13+
'THREE DAYS=Три дні'#13+
'ONE WEEK=Одна неділя'#13+
'HALF MONTH=Півмісяця'#13+
'ONE MONTH=Один місяць'#13+
'TWO MONTHS=Два місяця'#13+
'THREE MONTHS=Три месяца'#13+
'FOUR MONTHS=Чотири місяця'#13+
'SIX MONTHS=Шість місяців'#13+
'ONE YEAR=Один рік'#13+
'EXACT DATE TIME=Точна дата і час'#13+
'AXIS MAXIMUM AND MINIMUM=Мінімальне і максимальне значення осі'#13+
'VALUE=Значення'#13+
'TIME=Час'#13+
'LEFT AXIS=Ліва вісь'#13+
'RIGHT AXIS=Права вісь'#13+
'TOP AXIS=Верхня вісь'#13+
'BOTTOM AXIS=Нижня вісь'#13+
'% BAR WIDTH=% Ширина стовпця'#13+
'STYLE=Стиль'#13+
'% BAR OFFSET=% Відступ стовпца'#13+
'RECTANGLE=Прямокутник'#13+'PYRAMID=Піраміда'#13+
'INVERT. PYRAMID=Інверт. піраміда'#13+
'CYLINDER=Циліндр'#13+
'ELLIPSE=Еліпс'#13+
'ARROW=Стріла'#13+
'RECT. GRADIENT=Прямокут. градієнт'#13+'CONE=Kegel'#13+
'DARK BAR 3D SIDES= Тривимірні стовпці'#13+
'BAR SIDE MARGINS=Границі стовпця '#13+
'AUTO MARK POSITION=Автоматично відмічати позицію'#13+
'JOIN=Обєднати'#13+
'DATASET=Набір даних'#13+
'APPLY=Застосувати'#13+
'SOURCE=Джерело'#13+
'MONOCHROME=Монохромний'#13+
'DEFAULT=За замовчуванням'#13+
'2 (1 BIT)=2 (1 біт)'#13+
'16 (4 BIT)=16 (4 біт)'#13+
'256 (8 BIT)=256 (8 біт)'#13+
'32768 (15 BIT)=32768 (15 біт)'#13+
'65536 (16 BIT)=65536 (16 біт)'#13+
'16M (24 BIT)=16M (24 біт)'#13+
'16M (32 BIT)=16M (32 біт)'#13+
'MEDIAN=Медіана'#13+
'WHISKER=Частка'#13+
'PATTERN COLOR EDITOR=Редактор кольорів шаблону'#13+
'IMAGE=Зображення'#13+
'BACK DIAGONAL=Задня діагональ'#13+
'DIAGONAL CROSS=Діагональний хрест'#13+'FILL 80%=80% Заповнення'#13+
'FILL 60%=60% Заповнення'#13+
'FILL 40%=40% Заповнення'#13+
'FILL 20%=20% Заповнення'#13+
'FILL 10%=10% Заповнення'#13+
'ZIG ZAG=Зигзаг'#13+
'VERTICAL SMALL=Вертикальні маленькі'#13+
'HORIZ. SMALL=Горизонт. маленькі'#13+
'DIAG. SMALL=Діагон. маленькі'#13+
'BACK DIAG. SMALL=Задні діагон. маленькі'#13+
'CROSS SMALL=Маленькій хрест'#13+
'DIAG. CROSS SMALL=Діагон. маленький хрест'#13+
'DAYS=Дні'#13+
'WEEKDAYS=Дні неділі'#13+
'TODAY=Сьогодня'#13+
'SUNDAY=Неділя'#13+
'TRAILING=Замикаючий'#13+
'MONTHS=Місяці'#13+
'LINES=Лінії'#13+
'SHOW WEEKDAYS=Показати дні неділі'#13+
'UPPERCASE=Верхній регістр'#13+
'TRAILING DAYS=Замикаючі дні'#13+
'SHOW TODAY=Показати сьогодні'#13+
'SHOW MONTHS=Показати місяці'#13+
'CANDLE WIDTH=Ширина свічі'#13+
'STICK=Палица'#13+
'BAR=Стовпец'#13+
'OPEN CLOSE=Відкрити закрити'#13+
'UP CLOSE=Вгору закрити'#13+'DOWN CLOSE=Вниз закрити'#13+
'SHOW OPEN=Показати відкрити'#13+
'SHOW CLOSE=Показать закрити'#13+
'DRAW 3D=Тривимірні'#13+
'DARK 3D=Темні тривимірні'#13+
'EDITING=Редагувати'#13+
'CHART=Діаграма'#13+
'SERIES=Серії'#13+
'DATA=Дані'#13+
'TOOLS=Інструменти'#13+'EXPORT=Експорт'#13+
'PRINT=Друкувати'#13+
'GENERAL=Загальні'#13+
'TITLES=Заголовки'#13+
'LEGEND=Легенда'#13+
'PANEL=Панель'#13+
'PAGING=По сторінкам'#13+
'WALLS=Стіни'#13+
'3D=Тривимірний'#13+
'ADD=Додати'#13+
'DELETE=Видалити'#13+'TITLE=Назва'#13+
'CLONE=Скопіювати'#13+
'CHANGE=Змінити'#13+
'HELP=Допомога'#13+
'CLOSE=Закрити'#13+
'TEECHART PRINT PREVIEW=Перегляд друку TeeChart'#13+
'PRINTER=Принтер'#13+
'SETUP=Установка'#13+
'ORIENTATION=Орієнтація'#13+
'PORTRAIT=Портретна'#13+'LANDSCAPE=Ландшафтна'#13+
'MARGINS (%)=Границі (%)'#13+
'DETAIL=Деталі'#13+
'MORE=Більше'#13+
'NORMAL=Нормально'#13+
'RESET MARGINS=Скинути границі'#13+
'VIEW MARGINS=Перегляд границ'#13+
'PROPORTIONAL=Пропорційний'#13+
'CIRCLE=Коло'#13+
'VERTICAL LINE=Верт. лінія'#13+
'HORIZ. LINE=Гориз. лінія'#13+
'TRIANGLE=Трикутник'#13+
'INVERT. TRIANGLE=Інверт. трикутник'#13+
'LINE=Лінія'#13+
'DIAMOND=Діамант'#13+
'CUBE=Куб'#13+
'STAR=Зірка'#13+
'TRANSPARENT=Прозорість'#13+
'HORIZ. ALIGNMENT=Гориз. вирівнювання'#13+
'CENTER=По центру'#13+
'RIGHT=Справа'#13+
'ROUND RECTANGLE=Округлений прямокутник'#13+
'ALIGNMENT=Вирівнювання'#13+
'BOTTOM=Низ'#13+
'UNITS=Одиниці'#13+
'PIXELS=Пікселі'#13+
'AXIS ORIGIN=Зміщення осі'#13+
'ROTATION=Обертання'#13+
'CIRCLED=Круговий'#13+
'3 DIMENSIONS=Тривимірний'#13+
'RADIUS=Радіус'#13+
'ANGLE INCREMENT=Углове прирощування'#13+
'RADIUS INCREMENT=Прирощування радіуса'#13+
'CLOSE CIRCLE=Закрите коло'#13+
'PEN=Перо'#13+
'LABELS=Мітка'#13+
'VISIBLE=Видимий'#13+
'ROTATED=Повернений'#13+
'CLOCKWISE=За годинниковою стрілкою'#13+
'INSIDE=Усередину'#13+
'ROMAN=Римскій'#13+
'HOURS=Години'#13+
'MINUTES=Хвилини'#13+
'SECONDS=Секунди'#13+
'START VALUE=Початкове значення'#13+
'END VALUE=Кінцеве значення'#13+
'TRANSPARENCY=Прозорість'#13+
'DRAW BEHIND=Малювати позаду'#13+
'COLOR MODE=Колірний режим'#13+
'STEPS=Крок'#13+
'RANGE=Діапазон'#13+
'PALETTE=Палітра'#13+
'PALE=Рамка'#13+
'STRONG=Жирний'#13+
'GRID SIZE=Крок сітки'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Глибина'#13+
'IRREGULAR=Нерегулярний'#13+
'GRID=Сітка'#13+
'ALLOW DRAG=Дозвилити перетаскування'#13+
'VERTICAL POSITION=Вертикальна позиція'#13+
'LEVELS POSITION=Позиції рівнів'#13+
'LEVELS=Рівні'#13+
'NUMBER=Номер'#13+
'LEVEL=Рівень'#13+
'AUTOMATIC=Автоматично'#13+
'SNAP=Привязка'#13+
'FOLLOW MOUSE=Іти за мышею'#13+
'STACK=Стопка'#13+
'HEIGHT 3D=Тривимірна висота'#13+
'LINE MODE=Режим лінії'#13+
'OVERLAP=Перекриття'#13+
'STACK 100%=Стопка 100%'#13+
'CLICKABLE=Для клацання'#13+
'AVAILABLE=Доступно'#13+
'SELECTED=Виділиний'#13+
'DATASOURCE=Джерело даних'#13+
'GROUP BY=Групувати по'#13+
'CALC=Калькулятор'#13+
'OF=of'#13+
'SUM=Sum'#13+
'COUNT=Кількість'#13+
'HIGH=Високий'#13+
'LOW=Низький'#13+
'AVG=Avg'#13+
'HOUR=Hour'#13+
'DAY=Day'#13+
'WEEK=Week'#13+
'WEEKDAY=WeekDay'#13+
'MONTH=Month'#13+
'QUARTER=Quarter'#13+
'YEAR=Year'#13+
'HOLE %=Діра %'#13+
'RESET POSITIONS=Скидання позиції'#13+
'MOUSE BUTTON=Кнопка мишки'#13+
'ENABLE DRAWING=Включити малювання'#13+
'ENABLE SELECT=Включити вибір'#13+
'ENHANCED=Удосконалений'#13+
'ERROR WIDTH=Ширина помилки'#13+
'WIDTH UNITS=Одиниці ширини'#13+
'PERCENT=Відсоток'#13+
'LEFT AND RIGHT=Ліворуч і праворуч'#13+
'TOP AND BOTTOM=Зверху і знизу'#13+
'BORDER EDITOR=Редактор границі'#13+
'DASH=Штрихова'#13+
'DOT=Пунктирна'#13+
'DASH DOT=Штрих пунктирна'#13+
'DASH DOT DOT=Штрих-дот пунктирна'#13+
'CALCULATE EVERY=Обчислити кожний'#13+
'ALL POINTS=Усі точки'#13+
'NUMBER OF POINTS=Кількість точек'#13+
'RANGE OF VALUES=Діапазон значень'#13+
'FIRST=Перший'#13+'LAST=Останній'#13+
'TEEPREVIEW EDITOR=TeePreview редактор'#13+
'ALLOW MOVE=Дозволити переміщення'#13+
'ALLOW RESIZE=Дозволити зміну розміру'#13+
'DRAG IMAGE=Перетягнути зображення'#13+
'AS BITMAP=Як бітовий образ'#13+
'SHOW IMAGE=Показати зображення'#13+
'MARGINS=Границі'#13+
'SIZE=Розмір'#13+
'3D %=Тривимірний %'#13+
'ZOOM=Збільшення'#13+
'ELEVATION=Підйом'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Гориз. зміщення'#13+
'VERT. OFFSET=Верт. зміщення'#13+
'PERSPECTIVE=Перспектива'#13+
'ANGLE=Кут'#13+
'ORTHOGONAL=Ортогональна'#13+
'ZOOM TEXT=Збільшити текст'#13+
'SCALES=Луска'#13+
'TICKS=Позиції'#13+
'MINOR=Другорядний'#13+
'MAXIMUM=Максимум'#13+
'MINIMUM=Мінімум'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Бажане прирощення'#13+
'(INCREMENT)=(прирощення)'#13+
'LOG BASE=Основа логарифма'#13+
'LOGARITHMIC=Логарифмічний'#13+
'MIN. SEPARATION %=Мін. поділ %'#13+
'MULTI-LINE=Множина ліній'#13+
'LABEL ON AXIS=Мітка на осі'#13+
'ROUND FIRST=Округлити перше'#13+
'MARK=Потмітка'#13+
'LABELS FORMAT=Формат міток'#13+
'EXPONENTIAL=Експонентний'#13+
'DEFAULT ALIGNMENT=Вирівнювання за замовчуванням'#13+
'LEN=Длина'#13+
'INNER=Внутрішній'#13+
'AT LABELS ONLY=Тільки на мітках'#13+
'CENTERED=Центрований'#13+
'POSITION %=Позиція %'#13+
'START %=Початок %'#13+
'END %=Кінець %'#13+
'OTHER SIDE=Другий бік'#13+
'AXES=Осі'#13+
'BEHIND=Позаду'#13+
'CLIP POINTS=Точки вирізу'#13+
'PRINT PREVIEW=Перегляд друку'#13+
'MINIMUM PIXELS=Мінімально пікселей'#13+
'ALLOW=Дозволити'#13+
'ANIMATED=Анимованнй'#13+
'MIDDLE=Посредині'#13+
'ALLOW SCROLL=Дозволити скролінг'#13+
'TEEOPENGL EDITOR=Редактор TeeOpenGL'#13+
'AMBIENT LIGHT=Навколишне світло'#13+
'SHININESS=Сяво'#13+
'FONT 3D DEPTH=Тривимірна глубина шрифту'#13+
'ACTIVE=Активний'#13+
'FONT OUTLINES=Арбис шрифту'#13+
'SMOOTH SHADING=Плавне затінення'#13+
'LIGHT=Світло'#13+
'Y=Y'#13+
'INTENSITY=Інтенсивність'#13+
'BEVEL=Фаска'#13+
'FRAME=Рамка'#13+
'ROUND FRAME=Округлена рамка'#13+
'LOWERED=Понижений'#13+
'RAISED=Піднятий'#13+
'SYMBOLS=Символи'#13+
'TEXT STYLE=Стиль тексту'#13+
'LEGEND STYLE=Легенда стилей'#13+
'VERT. SPACING=Вертикальний відступ'#13+
'SERIES NAMES=Назви серій'#13+
'SERIES VALUES=Значення серії'#13+
'LAST VALUES=Останне значення'#13+
'PLAIN=Плоский'#13+
'LEFT VALUE=Ліве значення'#13+
'RIGHT VALUE=Праве значеня'#13+
'LEFT PERCENT=Відсотків зліва'#13+
'RIGHT PERCENT=Відсотків праворуч'#13+
'X VALUE=Значення по X'#13+
'X AND VALUE=X та Значення'#13+
'X AND PERCENT=X та Відсоток'#13+
'CHECK BOXES=Кнопки вибору'#13+
'DIVIDING LINES=Розділювальні лінії'#13+
'FONT SERIES COLOR=Колір сімейства шрифтів'#13+
'POSITION OFFSET %=Відступ позиції %'#13+
'MARGIN=Границя'#13+
'RESIZE CHART=Зміниті розмір діаграми'#13+
'CONTINUOUS=Безперервний'#13+
'POINTS PER PAGE=Точек на сторінку'#13+
'SCALE LAST PAGE=Масштабувати останню сторінику'#13+
'CURRENT PAGE LEGEND=Легенда поточної сторінки'#13+
'PANEL EDITOR=Редактор панелей'#13+
'BACKGROUND=Фон'#13+
'BORDERS=Границі'#13+
'BACK IMAGE=Фонове зображення'#13+
'STRETCH=Подовжити'#13+
'TILE=Заголовок'#13+
'BEVEL INNER=Внутрішній скіс'#13+
'BEVEL OUTER=Зовнішній скіс'#13+
'MARKS=Потмітки'#13+
'DATA SOURCE=Джерело даних'#13+
'SORT=Сортирувати'#13+
'CURSOR=Курсор'#13+
'SHOW IN LEGEND=Показати в легенді'#13+
'FORMATS=Формати'#13+
'VALUES=Значення'#13+
'PERCENTS=Відсотки'#13+
'HORIZONTAL AXIS=Горизонтальна вісь'#13+
'DATETIME=Дата и час'#13+
'VERTICAL AXIS=Вертикальна вісь'#13+
'ASCENDING=Наростаючий'#13+
'DESCENDING=Убутний'#13+
'DRAW EVERY=Креслити кожний'#13+
'CLIPPED=Урізаний'#13+'ARROWS=Стрілки'#13+
'MULTI LINE=Множина ліній'#13+
'ALL SERIES VISIBLE=Усі серії видимі'#13+
'LABEL=Мітка'#13+
'LABEL AND PERCENT=Мітка та відсоток'#13+
'LABEL AND VALUE=Мітка та значення'#13+
'PERCENT TOTAL=Усього відсотків'#13+
'LABEL AND PERCENT TOTAL=Мітка та усього відсотків'#13+
'X AND Y VALUES=Значення по X та Y'#13+
'MANUAL=Вручню'#13+
'RANDOM=Випадково'#13+
'FUNCTION=Функція'#13+
'NEW=Новий'#13+
'EDIT=Редагувати'#13+
'PERSISTENT=Постійний'#13+
'ADJUST FRAME=Настроїти рамку'#13+
'SUBTITLE=Підзаголовок'#13+
'SUBFOOT=Підпідсумок'#13+
'FOOT= Підсумок'#13+
'VISIBLE WALLS=Видимі стіни'#13+
'BACK=Задній фон'#13+
'DIF. LIMIT=Різниця ліміту'#13+
'ABOVE=Вище'#13+
'WITHIN=Усередені'#13+
'BELOW=Нижче'#13+
'CONNECTING LINES=Сполучні лінії'#13+
'BROWSE=Перегляд'#13+
'TILED=Замощений'#13+
'INFLATE MARGINS=Роздути границі'#13+
'SQUARE=Квадрат'#13+
'DOWN TRIANGLE=Нижній трикутник'#13+
'SMALL DOT=Маленька точка'#13+
'GLOBAL=Глобальний'#13+
'SHAPES=Форми'#13+
'BRUSH=Кисть'#13+
'DELAY=Затримка'#13+
'MSEC.=мілісек.'#13+
'MOUSE ACTION=Дія мишки'#13+
'MOVE=Рух'#13+
'CLICK=Клацнути'#13+
'DRAW LINE=Малювати лінію'#13+
'EXPLODE BIGGEST=Переглянути найбільше'#13+
'TOTAL ANGLE=Повний кут'#13+
'GROUP SLICES=Зрізи груп'#13+
'BELOW %=Меньш %'#13+
'BELOW VALUE=Значення нижче'#13+
'OTHER=Друге'#13+
'PATTERNS=Шаблони'#13+
'SIZE %=Розмір %'#13+
'SERIES DATASOURCE TEXT EDITOR=Редактор наборів даних для серій'#13+
'FIELDS=Поля'#13+
'NUMBER OF HEADER LINES=Кількість рядків заголовка'#13+
'SEPARATOR=Роздільник'#13+
'COMMA=Кома'#13+
'SPACE=Пробіл'#13+
'TAB=Табуляція'#13+
'FILE=Файл'#13+
'WEB URL=Адрес сторінки в Інтернет'#13+
'LOAD=Загрузити'#13+
'C LABELS=C Мітки'#13+
'R LABELS=R Мітки'#13+
'C PEN=C Перо'#13+'R PEN=R Перо'#13+
'STACK GROUP=Група стопки'#13+
'MULTIPLE BAR=Декілька стовпців'#13+
'SIDE=Сторона'#13+
'SIDE ALL=Уся сторона'#13+
'DRAWING MODE=Режим малювання'#13+
'WIREFRAME=Дротова'#13+
'DOTFRAME=Точечна'#13+
'SMOOTH PALETTE=Плавна палітра'#13+
'SIDE BRUSH=Бокова кисть'#13+
'ABOUT TEECHART PRO V7.0=О TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Усі права захищені.'#13+
'VISIT OUR WEB SITE !=Відвідайте нашу сторінку в інтернет !'#13+
'TEECHART WIZARD=Майстер TeeChart'#13+
'SELECT A CHART STYLE=Оберіть вид діаграми'#13+
'DATABASE CHART=Діаграма, звязана з даними'#13+
'NON DATABASE CHART= Діаграмма, не звязана з даними '#13+
'SELECT A DATABASE TABLE=Оберіть таблицю базы данных'#13+
'ALIAS=Псевдонім'#13+
'TABLE=Таблиця'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Оберіть необхідні поля'#13+
'SELECT A TEXT LABELS FIELD=Оберіть мітки для полей даних'#13+
'CHOOSE THE DESIRED CHART TYPE=Оберіть бажаний тип діаграми'#13+
'2D=Двомірний'#13+
'CHART PREVIEW=Перегляд діаграми'#13+
'SHOW LEGEND=Показати легенду'#13+
'SHOW MARKS=Показати помітки'#13+
'< BACK=< Назад'#13+
'EXPORT CHART=Експортувати діаграму'#13+
'PICTURE=Зображення'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Зберігати коефіцієнт стиску'#13+
'INCLUDE SERIES DATA=Включити дані серій'#13+
'FILE SIZE=Розмір файлу'#13+
'DELIMITER=Роздільник'#13+
'XML=XML'#13+
'HTML TABLE=HTML Таблиця'#13+
'EXCEL=Excel'#13+
'COLON=Двокрапка'#13+
'INCLUDE=Включити'#13+
'POINT LABELS=Мітка точки'#13+
'POINT INDEX=Індекс точки'#13+
'HEADER=Заголовок'#13+
'COPY=Копіювати'#13+
'SAVE=Зберегти'#13+
'SEND=Відправити'#13+
'FUNCTIONS=Функції'#13+
'ADX=ADX'#13+
'AVERAGE=Середній'#13+
'BOLLINGER=Dividieren'#13+
'DIVIDE=Розділити'#13+
'EXP. AVERAGE=Мат. очикування'#13+
'EXP.MOV.AVRG.=Gleit.Durchschn.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Multiplizieren'#13+
'MULTIPLY=Перемножити'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Квадратний корінь'#13+'STD.DEVIATION=Subtrahieren'#13+
'STOCHASTIC=Стохастичний'#13+
'SUBTRACT=Вирахування'#13+
'SOURCE SERIES=Серії джерел'#13+
'TEECHART GALLERY=Галерея TeeChart'#13+
'DITHER=Розмивати'#13+
'REDUCTION=Зменьшення'#13+
'COMPRESSION=Компресія'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Найближчий'#13+
'FLOYD STEINBERG=Флойд Стейнберг'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Стів Арч'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows сірий'#13+
'GRAY SCALE=Відтінки сірого'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Квантовати'#13+
'QUANTIZE 256=Квантовати 256'#13+
'% QUALITY=% Якість'#13+
'PERFORMANCE=Продуктивність'#13+
'QUALITY=Якість'#13+
'SPEED=Швидкість'#13+
'COMPRESSION LEVEL=Ступінь стиску'#13+
'CHART TOOLS GALLERY=Галерея Chart Tools'#13+
'ANNOTATION=Аннотація'#13+
'AXIS ARROWS=Стрілки осей'#13+
'COLOR BAND=Кольоровий край'#13+
'COLOR LINE=Кольорова лінія'#13+
'DRAG MARKS=Перемістити позначки'#13+
'MARK TIPS=Відзначити підказки'#13+
'NEAREST POINT=Найближча точка'#13+
'ROTATE=Обертати'#13+
'YES=Да'#13+

{$IFDEF TEEOCX}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- Виберіть ADO DataSource'#13+
'CONNECTION=Зєднання'#13+
'DATASET=Dataset'#13+
'TABLE=Таблиця'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=Системні таблиці'#13+
'LOGIN PROMPT=Запрошення для вводу реєстраційного імені'#13+
'SELECT=Вибір'#13+
'TEECHART IMPORT=TeeChart Iмпорт'#13+
'IMPORT CHART FROM=Імпортувати Chart з'#13+
'IMPORT NOW=Імпортувати зараз'#13+
'EDIT CHART=Редагувати Chart'#13+
{$ENDIF}

// 6.0

'BEVEL SIZE=Розмір фаски'#13+
'DELETE ROW=Видалити ряд'#13+
'VOLUME SERIES=Серія звуку'#13+
'SINGLE=Один'#13+
'REMOVE CUSTOM COLORS=Видалити додаткові кольори'#13+
'USE PALETTE MINIMUM=Використовувати мінімальну палітру'#13+
'AXIS MAXIMUM=Максимум вісі'#13+
'AXIS CENTER=Центр вісі'#13+
'AXIS MINIMUM=Мінімум вісі'#13+
'DAILY (NONE)=Щодня (Нічого)'#13+
'WEEKLY=Щотижня'#13+
'MONTHLY=Щомісяця'#13+
'BI-MONTHLY=Раз на два місяця'#13+
'QUARTERLY=Чвертю'#13+
'YEARLY=Щорічно'#13+
'DATETIME PERIOD=Денний період'#13+
'CASE SENSITIVE= Чутливий до регістру'#13+
'DRAG STYLE=Перетягнути стиль'#13+
'SQUARED=Квадратний'#13+
'GRID 3D SERIES=Сітка 3D серії'#13+
'DARK BORDER=Темна границя'#13+
'PIE SERIES=Серія пирога'#13+
'FOCUS=Фокус'#13+
'EXPLODE=Вибух'#13+
'FACTOR=Фактор'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Діаграма з шаблону (*.tee файл)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Відкрийте файл шаблону TeeChart з'#13+
'BINARY=Бінарний'#13+
'VOLUME OSCILLATOR=Генератор звуку'#13+
'PIE SLICES=Частини пирога'#13+
'ARROW WIDTH=Ширина стрілки'#13+
'ARROW HEIGHT=Висота стрілки'#13+
'DEFAULT COLOR=Колір за замовченням'#13+
'PERIOD=Період'#13+
'UP=Вгору'#13+
'DOWN=Вниз'#13+
'SHADOW EDITOR=Редактор тіні'#13+
'CALLOUT=Виноска'#13+
'TEXT ALIGNMENT=Розташування тексту'#13+
'DISTANCE=Відстань'#13+
'ARROW HEAD=Вістря стрілки'#13+
'POINTER=Покажчик'#13+
'AVAILABLE LANGUAGES=Доступні мови'#13+
'CHOOSE A LANGUAGE=Виберіть мову'#13+
'CALCULATE USING=Разрахуйте використання'#13+
'EVERY NUMBER OF POINTS=Кожний номер точок'#13+
'EVERY RANGE=Кожний інтевал'#13+
'INCLUDE NULL VALUES=Включати значення Null'#13+
'DATE=Дата'#13+
'ENTER DATE=Введіть дату'#13+
'ENTER TIME= Введіть час'#13+
'DEVIATION=Девіація'#13+
'UPPER=Верхній'#13+
'LOWER=Нижній'#13+
'NOTHING=Нічого'#13+
'LEFT TRIANGLE=Лівий трикутник'#13+
'RIGHT TRIANGLE=Правий трикутник'#13+
'SHOW PREVIOUS BUTTON=Показати попередню кнопку'#13+
'SHOW NEXT BUTTON=Показати наступну кнопку'#13+
'CONSTANT=Константа'#13+
'SHOW LABELS=Показати ярлики'#13+
'SHOW COLORS=Показати кольори'#13+
'XYZ SERIES=XYZ серії'#13+
'SHOW X VALUES=Показати значення Х'#13+
'ACCUMULATE=Накопичувати'#13+
'STEP=Крок'#13+
'DRAG REPAINT=Потягніть для перемальовання'#13+
'NO LIMIT DRAG=Без меж'#13+
'SMOOTH=Згладжування'#13+
'INTERPOLATE=Інтерполювати'#13+
'START X=Старт Х'#13+
'NUM. POINTS=Кількість точок'#13+
'COLOR EACH LINE=Розфарбувати кожну лінію'#13+
'SORT BY=Сортирувати по'#13+
'(NONE)=(Нічого)'#13+
'CALCULATION=Розрахунок'#13+
'GROUP=Група'#13+
'WEIGHT=Вага'#13+
'EDIT LEGEND=Редагувати легенду'#13+
'ROUND=Круглий'#13+
'FLAT=Плоский'#13+
'DRAW ALL=Креслити все'#13+
'IGNORE NULLS=Ігнорувати Null'#13+
'OFFSET=Зміщення'#13+
'Z %= Z %'#13+
'LIGHT 0=Світло 0'#13+
'LIGHT 1= Світло 1'#13+
'LIGHT 2= Світло 2'#13+
'DRAW STYLE=Креслити стиль'#13+
'POINTS=Точки'#13+
'DEFAULT BORDER=Границя за замовченням'#13+
'SHOW PAGE NUMBER=Показати номер сторінки'#13+
'SEPARATION=Розподіл'#13+
'ROUND BORDER=Кругла границя'#13+
'NUMBER OF SAMPLE VALUES=Кількість еталонних значень'#13+
'RESIZE PIXELS TOLERANCE=Змінити розмір'#13+
'FULL REPAINT=Повне перемальовання'#13+
'END POINT=Кінцева точка'#13+
'BAND 1=Полоса 1'#13+
'BAND 2=Полоса 2'#13+
'TRANSPOSE NOW=Перемістити зараз'#13+
'PERIOD 1=Період 1'#13+
'PERIOD 2=Період 2'#13+
'PERIOD 3=Період 3'#13+
'HISTOGRAM=Гістограма'#13+
'EXP. LINE=Розширена лінія'#13+
'WEIGHTED=Зважений'#13+
'WEIGHTED BY INDEX=Зважений по індексу'#13+
'BOX SIZE=Розмір коробки'#13+
'REVERSAL AMOUNT=Реверсивне значення'#13+
'PERCENTAGE=Процент'#13+
'COMPLETE R.M.S.=Закінчений R.M.S.'#13+
'BUTTON=Кнопка'#13+
'ALL=Все'#13+
'START AT MIN. VALUE=Почати з мін. значення'#13+
'EXECUTE !=Виконати !'#13+
'IMAG. SYMBOL=Символ малюнка'#13+
'SELF STACK=Самонакопичування'#13+
'SIDE LINES=Бокові лінії'#13+
'EXPORT DIALOG=Діалог експорту'#13+
'POINT COLORS=Кольорові точки'#13+
'OUTLINE GRADIENT=Градієнт арбіса'#13+
'CUMULATIVE=Накопчувальний'#13+
'CURVE FITTING=Підгін кривих'#13+
'EXP.TREND=Розширений тренд'#13+
'TREND=Тренд'#13+
'Y = F(X)=Y = F(X)'#13+
'RADIAL=Радіальний'#13+
'BALANCE=Баланс'#13+
'RADIAL OFFSET=Радіальне зміщення'#13+
'HORIZ=Гориз'#13+
'VERT=Верт'#13+
'DRAG POINT=Потягніть точку'#13+
'COVER=Покриття'#13+
'VALUE SOURCE=Значення джерела'#13+
'SLANT CUBE=Нахилений куб'#13+
'TICK LINES=Tick лінії'#13+
'% BAR DEPTH=% Глибини бруска'#13+
'METAL=Метал'#13+
'WOOD=Дерево'#13+
'STONE=Камінь'#13+
'CLOUDS=Хмари'#13+
'GRASS=Трава'#13+
'FIRE=Вогонь'#13+
'SNOW=Сніг'#13+
'HIGH-LOW=HIGH-LOW'#13+
'VIEW SERIES NAMES=Дивитись імена серій'#13+
'EDIT COLOR=Редагувати колір'#13+
'MAKE NULL POINT=Зробити нульову точку'#13+
'APPEND ROW=Додати ряд'#13+
'TEXT FONT=Шрифт тексту'#13+
'CHART THEME SELECTOR=Селектор теми графіку'#13+
'PREVIEW=Попередній перегляд'#13+
'THEMES=Теми'#13+
'COLOR PALETTE=Палітра кольорів'#13+
'VIEW 3D=Перегляд 3D'#13+
'SCALE=Масштаб'#13+
'MARGIN %=Поле %'#13+
'DRAW BEHIND AXES=Малювати позаду осей'#13+
'X GRID EVERY=X Сітка кожна'#13+
'Z GRID EVERY=Z Сітка кожна'#13+
'DATE PERIOD=Період дати'#13+
'TIME PERIOD=Період часу'#13+
'USE SERIES Z=Використовуйте серії Z'#13+
'NUMERIC FORMAT=Числовий формат'#13+
'DATE TIME=Формат дати і часу'#13+
'GEOGRAPHIC=Географічний'#13+
'DECIMALS=Десятковий'#13+
'FIXED=Зафіксований'#13+
'THOUSANDS=Тисячі'#13+
'CURRENCY=Валюта'#13+
'VIEWS=Види'#13+
'ALTERNATE=Перемінний'#13+
'ZOOM ON UP LEFT DRAG=Масштаб вкл уверх наліво тягнути'#13+
'FIXED POSITION=Зафіксована позиція'#13+
'NO CHECK BOXES=Без віконцев мітки'#13+
'RADIO BUTTONS=Селективні кнопки'#13+
'Z DATETIME=Z дата'#13+
'SYMBOL=Символ'#13+
'AUTO HIDE=Ховати автоматично'#13+
'GALLERY=Галерея'#13+
'INVERTED GRAY=Інвертований сірий'#13+
'RAINBOW=Райдуга'#13+
'TEECHART LIGHTING=TEECHART підсвітка'#13+
'LINEAR=Лінійний'#13+
'SPOTLIGHT=Прожектор'#13+
'SHAPE INDEX=Індекс форми'#13+
'CLOSED=Закритий'#13+
'DESIGN TIME OPTIONS=Опціі при проектуванні'#13+
'LANGUAGE=Мова'#13+
'CHART GALLERY=Галерея графіків'#13+
'MODE=Режим'#13+
'CHART EDITOR=Редактор графіка'#13+
'REMEMBER SIZE=Запам`ятати розмір'#13+
'REMEMBER POSITION=Запам`ятати позицію'#13+
'TREE MODE=Режим дерево'#13+
'RESET=Скиданя'#13+
'NEW CHART=Новий графік'#13+
'DEFAULT THEME=Тема за замовчуванням'#13+
'TEECHART DEFAULT=Teechart за замовчуванням'#13+
'CLASSIC=Класичний'#13+
'WEB=Web'#13+
'WINDOWS XP=Windows XP'#13+
'BLUES=Блюз'#13+
'MULTIPLE PIES=Складений пиріг'#13+
'3D GRADIENT=3D градієнт'#13+
'DISABLE=Блокувати'#13+
'COLOR EACH SLICE=Розфарбувати кожну частку'#13+
'BASE LINE=Базова лінія'#13+
'INITIAL DELAY=Начальна пауза'#13+
'THUMB=Перст'#13+
'AUTO-REPEAT=Автоповтор'#13+
'BACK COLOR=Чорний колір'#13+
'HANDLES=Ручки'#13+
'ALLOW RESIZE CHART=Дозволити зміну розміру графіка'#13+
'LOOP=Цикл'#13+
'NO=Ні'#13+
'ONE WAY=В одну сторону'#13+
'CIRCULAR=Круглий'#13+
'SERIES 2=Серія 2'#13+
'DRAW BEHIND SERIES=Малювати позаду серій'#13+
'SURFACE=Поверхня'#13+
'CELL=Клітка'#13+
'ROW=Ряд'#13+
'COLUMN=Колонка'#13+
'FAST BRUSH=Швидка кисть'#13+
'SVG OPTIONS=SVG опціі'#13+
'TEXT ANTI-ALIAS=ANTI-ALIAS текст'#13+
'THEME=Тема'#13+
'TEXT QUOTES=Лапки текста'#13+
'PERIMETER=Периметр'#13+
'ACE=Частка'#13+
'BUSINESS=Бізнес'#13+
'CARIBE SUN=Карибське сонце'#13+
'CLEAR DAY=Ясний день'#13+
'DESERT=Пустеля'#13+
'FARM=Ферма'#13+
'FUNKY=Круто'#13+
'GOLF=Гольф'#13+
'HOT=Гарячий'#13+
'NIGHT=Ніч'#13+
'PASTEL=Пастель'#13+
'SEA=Море'#13+
'SEA 2=Море 2'#13+
'SUNSET=Захід сонця'#13+
'TROPICAL=Тропічний'#13+
'DIAGONAL UP=Діагональ вгору'#13+
'DIAGONAL DOWN=Діагональ вниз'#13+
'HIDE TRIANGLES=Сховати трикутники'#13+
'MIRRORED=Дзеркально'
;

  end;
end;

Procedure TeeSetUkrainian;
begin
  TeeCreateUkrainian;
  TeeLanguage:=TeeUkrainianLanguage;
  TeeUkrainianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeUkrainianLanguage);
end.