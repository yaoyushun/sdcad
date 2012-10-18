unit TeeRussian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeRussianLanguage:TStringList=nil;

Procedure TeeSetRussian;
Procedure TeeCreateRussian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeRussianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 Давид Бернеда';
  TeeMsg_LegendFirstValue   :='Первое значение легенды должны быть > 0';
  TeeMsg_LegendColorWidth   :='Толщина цвета легенды должна быть > 0%';
  TeeMsg_SeriesSetDataSource:='Нет родительского графика чтобы проверить источник данных';
  TeeMsg_SeriesInvDataSource:='Неправильный источник данных: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues должны быть > 0';
  TeeMsg_AxisLogDateTime    :='Временная ось не может быть логарифмичной';
  TeeMsg_AxisLogNotPositive :='Мин. и Макс. значения логарифмической осидолжны быть >= 0';
  TeeMsg_AxisLabelSep       :='Разделители подписей % должны быть больше 0';
  TeeMsg_AxisIncrementNeg   :='Шаг оси должен быть >= 0';
  TeeMsg_AxisMinMax         :='Минимальное значение оси должно быть <= Максимального';
  TeeMsg_AxisMaxMin         :='Максимальное значение оси должно быть >= Минимального';
  TeeMsg_AxisLogBase        :='Корень логарифмичной оси должен быть >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage должно быть >= 0';
  TeeMsg_3dPercent          :='Проценты 3D эффекта должны быть между %d и %d';
  TeeMsg_CircularSeries     :='Зависимости от круговых серий недопустимы';
  TeeMsg_WarningHiColor     :='16k Цвет или больший требуется для лучшего вида';

  TeeMsg_DefaultPercentOf   :='%s из %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'из %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Заголовки осей';
  TeeMsg_AxisLabels         :='Подписи осей';
  TeeMsg_RefreshInterval    :='Интервал обновления должен быть между 0 и 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart не может быть самим собой!';
  TeeMsg_GalleryLine        :='Линия';
  TeeMsg_GalleryPoint       :='Точка';
  TeeMsg_GalleryArea        :='Площадь';
  TeeMsg_GalleryBar         :='Брусок';
  TeeMsg_GalleryHorizBar    :='Гориз. брусок';
  TeeMsg_Stack              :='Стэк';
  TeeMsg_GalleryPie         :='Пирог';
  TeeMsg_GalleryCircled     :='Круговая';
  TeeMsg_GalleryFastLine    :='Простая линия';
  TeeMsg_GalleryHorizLine   :='Гориз. линия';

  TeeMsg_PieSample1         :='Машины';
  TeeMsg_PieSample2         :='Телефоны';
  TeeMsg_PieSample3         :='Таблицы';
  TeeMsg_PieSample4         :='Мониторы';
  TeeMsg_PieSample5         :='Лампы';
  TeeMsg_PieSample6         :='Клавиатуры';
  TeeMsg_PieSample7         :='Велосипеды';
  TeeMsg_PieSample8         :='Стулья';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Редактирование %s';

  TeeMsg_GalleryStandard    :='Стандартные';
  TeeMsg_GalleryExtended    :='Расширенные';
  TeeMsg_GalleryFunctions   :='Функции';

  TeeMsg_EditChart          :='Р&едакт. график...';
  TeeMsg_PrintPreview       :='&Предварит. просмотр...';
  TeeMsg_ExportChart        :='Е&кспортировать график...';
  TeeMsg_CustomAxes         :='Настр. оси...';

  TeeMsg_InvalidEditorClass :='%s: Неправильный редактор класса: %s';
  TeeMsg_MissingEditorClass :='%s: нет диалога Редактора';

  TeeMsg_GalleryArrow       :='Стрела';

  TeeMsg_ExpFinish          :='&Финиш';
  TeeMsg_ExpNext            :='&Следующий >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Дизайн';
  TeeMsg_GanttSample2       :='Создание прототипа';
  TeeMsg_GanttSample3       :='Разработка';
  TeeMsg_GanttSample4       :='Продажи';
  TeeMsg_GanttSample5       :='Маркетинг';
  TeeMsg_GanttSample6       :='Тестирование';
  TeeMsg_GanttSample7       :='Производ.';
  TeeMsg_GanttSample8       :='Отладка';
  TeeMsg_GanttSample9       :='Новая Версия';
  TeeMsg_GanttSample10      :='Финансы';

  TeeMsg_ChangeSeriesTitle  :='Измените название серии';
  TeeMsg_NewSeriesTitle     :='Новое название серии:';
  TeeMsg_DateTime           :='ДатаВремя';
  TeeMsg_TopAxis            :='Верхняя ось';
  TeeMsg_BottomAxis         :='Нижняя ось';
  TeeMsg_LeftAxis           :='Левая ось';
  TeeMsg_RightAxis          :='Правая ось';

  TeeMsg_SureToDelete       :='Удалить %s ?';
  TeeMsg_DateTimeFormat     :='Фор&мат ДатыВремени:';
  TeeMsg_Default            :='По умолчанию';
  TeeMsg_ValuesFormat       :='Ф&ормат значений:';
  TeeMsg_Maximum            :='Максимум';
  TeeMsg_Minimum            :='Минимум';
  TeeMsg_DesiredIncrement   :='Желаемое %s приращение';

  TeeMsg_IncorrectMaxMinValue:='Неправильное значение. Из-за: %s';
  TeeMsg_EnterDateTime      :='Введите [Число дней] [чч:мм:сс]';

  TeeMsg_SureToApply        :='Применить изменения ?';
  TeeMsg_SelectedSeries     :='(Выбранные серии)';
  TeeMsg_RefreshData        :='&Обновить данные';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='484';
  TeeMsg_FunctionAdd        :='Сложить';
  TeeMsg_FunctionSubtract   :='Вычесть';
  TeeMsg_FunctionMultiply   :='Умножить';
  TeeMsg_FunctionDivide     :='Разделить';
  TeeMsg_FunctionHigh       :='Высокий';
  TeeMsg_FunctionLow        :='Низкий';
  TeeMsg_FunctionAverage    :='Средний';

  TeeMsg_GalleryShape       :='Фигура';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='Копировать';

  TeeMsg_None               :='(ничего)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Размер точки должен быть больше нуля';
  TeeMsg_About              :='&О TeeChart...';

  tcAdditional              :='Дополнительно';
  tcDControls               :='Управление данными';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Набор данных';
  TeeMsg_AskDataSet         :='&Набор данных:';

  TeeMsg_SingleRecord       :='Единствен. запись';
  TeeMsg_AskDataSource      :='&Источник Данных:';

  TeeMsg_Summary            :='Итого';

  TeeMsg_FunctionPeriod     :='Период функции должен быть >= 0';

  TeeMsg_WizardTab          :='Бизнесс';
  TeeMsg_TeeChartWizard     :='TeeChart Мастер';

  TeeMsg_ClearImage         :='Очис&тить';
  TeeMsg_BrowseImage        :='О&бзор...';

  TeeMsg_WizardSureToClose  :='Вы уверены, что хотите закрыть Мастера TeeChart ?';
  TeeMsg_FieldNotFound      :='Поле %s не существует';

  TeeMsg_DepthAxis          :='Ось глубины';
  TeeMsg_PieOther           :='Другие';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Пирог';
  TeeMsg_ValuesBar          :='Брусок';
  TeeMsg_ValuesAngle        :='Угол';
  TeeMsg_ValuesGanttStart   :='Пуск';
  TeeMsg_ValuesGanttEnd     :='Финиш';
  TeeMsg_ValuesGanttNextTask:='Следующ. задача';
  TeeMsg_ValuesBubbleRadius :='Радиус';
  TeeMsg_ValuesArrowEndX    :='ПоследнийX';
  TeeMsg_ValuesArrowEndY    :='ПоследнийY';
  TeeMsg_Legend             :='Легенда';
  TeeMsg_Title              :='Название';
  TeeMsg_Foot               :='Нижняя подпись';
  TeeMsg_Period		    :='Период';
  TeeMsg_PeriodRange        :='Диапазон периода';
  TeeMsg_CalcPeriod         :='Вычислять %s каждые:';
  TeeMsg_SmallDotsPen       :='Маленькие точки';

  TeeMsg_InvalidTeeFile     :='Неправильный график в *.'+TeeMsg_TeeExtension+' файле';
  TeeMsg_WrongTeeFileFormat :='Неправильный формат *.'+TeeMsg_TeeExtension+' файла';
  TeeMsg_EmptyTeeFile       :='Пустой *.'+TeeMsg_TeeExtension+' файл';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Оси графика';
  TeeMsg_ChartAxesCategoryDesc   := 'Свойства и события графика';
  TeeMsg_ChartWallsCategoryName  := 'Обои графика';
  TeeMsg_ChartWallsCategoryDesc  := 'Свойства и события обоев графика';
  TeeMsg_ChartTitlesCategoryName := 'Подписи графика';
  TeeMsg_ChartTitlesCategoryDesc := 'Свойства и события подписей графика';
  TeeMsg_Chart3DCategoryName     := '3D График';
  TeeMsg_Chart3DCategoryDesc     := 'Свойства и события 3D графика';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Свой ';
  TeeMsg_Series                 :='Серии';
  TeeMsg_SeriesList             :='Серии...';

  TeeMsg_PageOfPages            :='Страница %d из %d';
  TeeMsg_FileSize               :='%d байт';

  TeeMsg_First  :='Первый';
  TeeMsg_Prior  :='Предыдущий';
  TeeMsg_Next   :='Следующий';
  TeeMsg_Last   :='Последний';
  TeeMsg_Insert :='Вставить';
  TeeMsg_Delete :='Удалить';
  TeeMsg_Edit   :='Редактировать';
  TeeMsg_Post   :='Отправить';
  TeeMsg_Cancel :='Отмена';

  TeeMsg_All    :='(все)';
  TeeMsg_Index  :='Индекс';
  TeeMsg_Text   :='Текст';

  TeeMsg_AsBMP        :='как &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='как &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Свойства панели не установлены в формат экспорта';

  TeeMsg_Normal    :='Номарльно';
  TeeMsg_NoBorder  :='Без границы';
  TeeMsg_Dotted    :='Точками';
  TeeMsg_Colors    :='Цвета';
  TeeMsg_Filled    :='Заполненный';
  TeeMsg_Marks     :='Отметки';
  TeeMsg_Stairs    :='Лестницы';
  TeeMsg_Points    :='Точек';
  TeeMsg_Height    :='Высота';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='Точка 2D';
  TeeMsg_Triangle  :='Треугольник';
  TeeMsg_Star      :='Звезда';
  TeeMsg_Circle    :='Круг';
  TeeMsg_DownTri   :='Вниз Три.';
  TeeMsg_Cross     :='Крест';
  TeeMsg_Diamond   :='Алмаз';
  TeeMsg_NoLines   :='Без линий';
  TeeMsg_Stack100  :='Стэк 100%';
  TeeMsg_Pyramid   :='Пирамида';
  TeeMsg_Ellipse   :='Эллипс';
  TeeMsg_InvPyramid:='Непр. пирамида';
  TeeMsg_Sides     :='Стороны';
  TeeMsg_SideAll   :='Все стороны';
  TeeMsg_Patterns  :='Паттерны';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='Тень';
  TeeMsg_SemiPie   :='Полу-труба';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Верт. линия';
  TeeMsg_HorizLine :='Гориз. линия';
  TeeMsg_Line      :='Линия';
  TeeMsg_Cube      :='Куб';
  TeeMsg_DiagCross :='Диаг. крест';

  TeeMsg_CanNotFindTempPath    :='Не могу найти временную папку';
  TeeMsg_CanNotCreateTempChart :='Не могу создать временный файл';
  TeeMsg_CanNotEmailChart      :='Не могу отправить TeeChart. Ошибка Mapi : %d';

  TeeMsg_SeriesDelete :='Удаление серий: ValueIndex %d за границами (0 до %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='как &JPEG';
  TeeMsg_JPEGFilter    :='JPEG файлы (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='как &GIF';
  TeeMsg_GIFFilter     :='GIF файлы (*.gif)|*.gif';
  TeeMsg_AsPNG         :='как &PNG';
  TeeMsg_PNGFilter     :='PNG файлы (*.png)|*.png';
  TeeMsg_AsPCX         :='как PC&X';
  TeeMsg_PCXFilter     :='PCX файлы (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Язык...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Поляр';
  TeeMsg_GalleryCandle      :='Свеча';
  TeeMsg_GalleryVolume      :='Объем';
  TeeMsg_GallerySurface     :='Покрытие';
  TeeMsg_GalleryContour     :='Контур';
  TeeMsg_GalleryBezier      :='Безье';
  TeeMsg_GalleryPoint3D     :='3D точка';
  TeeMsg_GalleryRadar       :='Радар';
  TeeMsg_GalleryDonut       :='Орех';
  TeeMsg_GalleryCursor      :='Курсор';
  TeeMsg_GalleryBar3D       :='3D Брусок';
  TeeMsg_GalleryBigCandle   :='Большая свеча';
  TeeMsg_GalleryLinePoint   :='Точка линия';
  TeeMsg_GalleryHistogram   :='Гистограмма';
  TeeMsg_GalleryWaterFall   :='Водопад';
  TeeMsg_GalleryWindRose    :='Роза ветров';
  TeeMsg_GalleryClock       :='Часы';
  TeeMsg_GalleryColorGrid   :='Цветная Сетка';
  TeeMsg_GalleryBoxPlot     :='Коробка';
  TeeMsg_GalleryHorizBoxPlot:='Гориз. коробка';
  TeeMsg_GalleryBarJoin     :='Присоед. брусок';
  TeeMsg_GallerySmith       :='Смит';
  TeeMsg_GalleryPyramid     :='Пирамида';
  TeeMsg_GalleryMap         :='Карта';

  TeeMsg_PolyDegreeRange    :='Polynomial degree должен быть между 1 и 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index должен быть между 1 и %d';
  TeeMsg_FittingError        :='Не могу сделать fitting';
  TeeMsg_PeriodRange         :='Период должен быть >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage вес должен быть между 0 and 1';
  TeeMsg_GalleryErrorBar     :='Ошибочный брусок';
  TeeMsg_GalleryError        :='Ошибка';
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

  TeeMsg_FunctionCount       :='Считать';
  TeeMsg_LoadChart           :='Открыть TeeChart...';
  TeeMsg_SaveChart           :='Сохранить TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro файлы';

  TeeMsg_GallerySamples      :='Другие';
  TeeMsg_GalleryStats        :='Статистика';

  TeeMsg_CannotFindEditor    :='Не могу найти редактор формы : %s';


  TeeMsg_CannotLoadChartFromURL:='Код ошибки: %d загрузка графика из URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Код ошибки: %d загрузка данных серий из URL: %s';

  TeeMsg_Test                :='Тест...';

  TeeMsg_ValuesDate          :='Дата';
  TeeMsg_ValuesOpen          :='Открытие';
  TeeMsg_ValuesHigh          :='Высшая';
  TeeMsg_ValuesLow           :='Низшая';
  TeeMsg_ValuesClose         :='Закрытие';
  TeeMsg_ValuesOffset        :='Смещение';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='3D сетка';

  TeeMsg_LowBezierPoints     :='Количество точек безье должно быть > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Нормально';
  TeeCommanMsg_Edit     :='Редактирование';
  TeeCommanMsg_Print    :='Печать';
  TeeCommanMsg_Copy     :='Копировать';
  TeeCommanMsg_Save     :='Сохранить';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Вращение: %d° Наклон: %d°';
  TeeCommanMsg_Rotate   :='Вращение';

  TeeCommanMsg_Moving   :='Гориз.смещение: %d Верт.смещение: %d';
  TeeCommanMsg_Move     :='Двигать';

  TeeCommanMsg_Zooming  :='Приближ: %d %%';
  TeeCommanMsg_Zoom     :='Приближение';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Глубина';

  TeeCommanMsg_Chart    :='График';
  TeeCommanMsg_Panel    :='Панель';

  TeeCommanMsg_RotateLabel:='Нажми %s для вращения';
  TeeCommanMsg_MoveLabel  :='Нажми %s для движения';
  TeeCommanMsg_ZoomLabel  :='Нажми %s для приближения';
  TeeCommanMsg_DepthLabel :='Нажми %s для измен. размера 3D';

  TeeCommanMsg_NormalLabel:='Нажмите Левую кнопку для приближения, Правую кнопку для скролла';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='Количество точек должно быть >= 4';
  TeeMsg_TriSurfaceAllColinear :='Все коллинеарные точки данных';
  TeeMsg_TriSurfaceSimilar     :='Похожие точки - не могу запустить';
  TeeMsg_GalleryTriSurface     :='Triangle Surf.';

  TeeMsg_AllSeries :='Все серии';
  TeeMsg_Edit      :='Редактировать';

  TeeMsg_GalleryFinancial    :='Финансы';

  TeeMsg_CursorTool    :='Курсор';
  TeeMsg_DragMarksTool :='Drag отметки';
  TeeMsg_AxisArrowTool :='Стрелки осей';
  TeeMsg_DrawLineTool  :='Нарисовать линию';
  TeeMsg_NearestTool   :='Ближайшая точка';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Цветная линия';
  TeeMsg_RotateTool    :='Вращение';
  TeeMsg_ImageTool     :='Рисунок';
  TeeMsg_MarksTipTool  :='Подсказки отметок';

  TeeMsg_CantDeleteAncestor  :='Не могу удалить ancestor';

  TeeMsg_Load	          :='Загузка...';
  TeeMsg_NoSeriesSelected :='Серии не выбраны';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='График';
  TeeMsg_CategorySeriesActions :='Серии графика';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Переключение 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Активный';
  TeeMsg_ActionSeriesActiveHint := 'Показать / Спрятать серии';
  TeeMsg_ActionEditHint         := 'Редактировать график';
  TeeMsg_ActionEdit             := '&Редактировать...';
  TeeMsg_ActionCopyHint         := 'Копировать в буфер';
  TeeMsg_ActionCopy             := '&Копировать';
  TeeMsg_ActionPrintHint        := 'Предварительный прсмотр графика';
  TeeMsg_ActionPrint            := '&Печать...';
  TeeMsg_ActionAxesHint         := 'Показать / Спрятать оси';
  TeeMsg_ActionAxes             := '&Оси';
  TeeMsg_ActionGridsHint        := 'Показать / Спрятать сетку';
  TeeMsg_ActionGrids            := '&Сетка';
  TeeMsg_ActionLegendHint       := 'Показать / Спрятать легенду';
  TeeMsg_ActionLegend           := '&Легенда';
  TeeMsg_ActionSeriesEditHint   := 'Редактировать серии';
  TeeMsg_ActionSeriesMarksHint  := 'Показать / Спрятать отметки серий';
  TeeMsg_ActionSeriesMarks      := '&Отметки';
  TeeMsg_ActionSaveHint         := 'Сохранить график';
  TeeMsg_ActionSave             := '&Сохранить...';

  TeeMsg_CandleBar              := 'Брусок';
  TeeMsg_CandleNoOpen           := 'Нет открытия';
  TeeMsg_CandleNoClose          := 'Нет закрытия';
  TeeMsg_NoLines                := 'Нет линий';
  TeeMsg_NoHigh                 := 'Нет высшей';
  TeeMsg_NoLow                  := 'Нет низшей';
  TeeMsg_ColorRange             := 'Выбор цвета';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := 'Позиции';
  TeeMsg_NoGrid                 := 'Нет сетки';
  TeeMsg_NoPoint                := 'Нет точек';
  TeeMsg_NoLine                 := 'Нет линии';
  TeeMsg_Labels                 := 'Подписи';
  TeeMsg_NoCircle               := 'Нет кругов';
  TeeMsg_Lines                  := 'Линии';
  TeeMsg_Border                 := 'Обрамление';

  TeeMsg_SmithResistance      := 'Resistance';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := 'Столбец';

  { 5.01 }
  TeeMsg_Separator            := 'Разделитель';
  TeeMsg_FunnelSegment        := 'Сегмент ';
  TeeMsg_FunnelSeries         := 'Туннель';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Превышает пределы';
  TeeMsg_FunnelWithin         := ' в пределах';
  TeeMsg_FunnelBelow          := ' или ниже пределов';
  TeeMsg_CalendarSeries       := 'Календарь';
  TeeMsg_DeltaPointSeries     := 'Точка Дельты';
  TeeMsg_ImagePointSeries     := 'Точка картнки';
  TeeMsg_ImageBarSeries       := 'Рисунок бруска';
  TeeMsg_SeriesTextFieldZero  := 'Текст серий: количество серий должно быть больше нуля.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Прозрачность';
  TeeMsg_Box		      := 'Ящик';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Страница номер';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  TeeMsg_Property             := 'Свойство';
  TeeMsg_Value                := 'Значение';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Release ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Cannot import TeeChart from %s';
  TeeMsg_ActiveXVerbPrint    := '&Print Preview...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Help...';
  TeeMsg_ActiveXVerbAbout    := '&About TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Error code: %d downloading: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataSource is not a Series or RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Invalid Series type';
  TeeMsg_AxisTextSrcError    := 'Invalid Axis type';
  TeeMsg_DelSeriesDatasource := 'Are you sure you want to delete %s ?';
  TeeMsg_OCXNoPrinter        := 'No default printer installed.';
  TeeMsg_ActiveXPictureNotValid:='Picture not valid';
end;

Procedure TeeCreateRussian;
begin
  if not Assigned(TeeRussianLanguage) then
  begin
    TeeRussianLanguage:=TStringList.Create;
    TeeRussianLanguage.Text:=
'GRADIENT EDITOR=Редактор градиента'#13+
'GRADIENT=Градиент'#13+
'DIRECTION=Направление'#13+
'VISIBLE=Видимость'#13+
'TOP BOTTOM=Сверху вниз'#13+
'BOTTOM TOP=Снизу вверх'#13+
'LEFT RIGHT=Слева направо'#13+
'RIGHT LEFT=Справа налево'#13+
'FROM CENTER=Из центра'#13+
'FROM TOP LEFT=Из Верхнего левого угла'#13+
'FROM BOTTOM LEFT=Из Нижнего левого угла '#13+
'OK=Ok'#13+
'CANCEL=Отмена'#13+
'COLORS=Цвета'#13+
'START=Начало'#13+
'MIDDLE=Середина'#13+
'END=Конец'#13+
'SWAP=Обменять'#13+
'NO MIDDLE=Без середины'#13+
'TEEFONT EDITOR=Редактор шрифтов'#13+
'INTER-CHAR SPACING=Межсимвольное расстояние'#13+
'FONT=Шрифт'#13+
'SHADOW=Тень'#13+
'HORIZ. SIZE=Гориз. размер'#13+
'VERT. SIZE=Верт. размер'#13+
'COLOR=Цвет'#13+
'OUTLINE=Контур'#13+
'OPTIONS=Опции'#13+
'FORMAT=Формат'#13+
'TEXT=Текст'#13+
'GRADIENT=Градиент'#13+
'POSITION=Позиция'#13+
'LEFT=Слева'#13+'TOP=Сверху'#13+
'AUTO=Авто'#13+
'CUSTOM=Индивидуально'#13+
'LEFT TOP=Из левого верхнего угла'#13+
'LEFT BOTTOM=Из левого нижнего угла'#13+
'RIGHT TOP=Из правого верхнего угла'#13+
'RIGHT BOTTOM=Из правого нижнего угла'#13+
'MULTIPLE AREAS=Несколько областей'#13+
'NONE=Ничего'#13+
'STACKED=Стопкой'#13+
'STACKED 100%=Стопкой 100%'#13+
'AREA=Область'#13+
'PATTERN=Узор'#13+
'STAIRS=Лестница'#13+
'SOLID=Сплошной'#13+
'CLEAR=Очистить'#13+
'HORIZONTAL=Горизонтально'#13+
'VERTICAL=Вертикально'#13+
'DIAGONAL=Диагонально'#13+
'B.DIAGONAL=Б.Диагонально'#13+
'CROSS=Крест'#13+
'DIAG.CROSS=Диаг. крест'#13+
'AREA LINES=Линии области'#13+
'BORDER=Граница'#13+
'INVERTED=Инвертированный'#13+
'INVERTED SCROLL=Перевернутый скролл'#13+
'COLOR EACH=Цвет каждого'#13+
'ORIGIN=Смещение'#13+
'USE ORIGIN=Использовать смещение'#13+
'WIDTH=Ширина'#13+
'HEIGHT=Высота'#13+
'AXIS=Ось'#13+
'LENGTH=Длина'#13+
'SCROLL=Прокрутка'#13+
'PATTERN=Узор'#13+
'START=Начало'#13+
'END=Конец'#13+
'BOTH=Оба'#13+
'AXIS INCREMENT=Шаг оси'#13+
'INCREMENT=Шаг'#13+
'INCREMENT=Шаг'#13+
'STANDARD=Стандартно'#13+
'CUSTOM=Индивидуально'#13+
'ONE MILLISECOND=Одна милисекунда'#13+
'ONE SECOND=Одна секунда'#13+
'FIVE SECONDS=Пять секунд'#13+
'TEN SECONDS=Десять секунд'#13+
'FIFTEEN SECONDS=Пятнадцать секунд'#13+'THIRTY SECONDS=Тридцать секунд'#13+
'ONE MINUTE=Одна минута'#13+
'FIVE MINUTES=Пять минут'#13+
'TEN MINUTES=Десять минут'#13+
'FIFTEEN MINUTES=Пятнадцать минут'#13+
'THIRTY MINUTES=Тридцать минут'#13+
'ONE HOUR=Один час'#13+
'TWO HOURS=Два часа'#13+
'SIX HOURS=Шесть часов'#13+
'TWELVE HOURS=Двенадцать часов'#13+
'ONE DAY=Один день'#13+
'TWO DAYS=Два дня'#13+
'THREE DAYS=Три дня'#13+
'ONE WEEK=Одна неделя'#13+
'HALF MONTH=Полмесяца'#13+
'ONE MONTH=Один месяц'#13+
'TWO MONTHS=Два месяца'#13+
'THREE MONTHS=Три месяца'#13+
'FOUR MONTHS=Четыре месяца'#13+
'SIX MONTHS=Шесть месяцев'#13+
'ONE YEAR=Один год'#13+
'EXACT DATE TIME=Точная дата и время'#13+
'AXIS MAXIMUM AND MINIMUM=Минимальное и максимальное значение оси'#13+
'VALUE=Значение'#13+
'TIME=Время'#13+
'LEFT AXIS=Левая ось'#13+
'RIGHT AXIS=Правая ось'#13+
'TOP AXIS=Верхняя ось'#13+
'BOTTOM AXIS=Нижняя ось'#13+
'% BAR WIDTH=% Ширина столбца'#13+
'STYLE=Стиль'#13+
'% BAR OFFSET=% Отступ столбца'#13+
'RECTANGLE=Прямоугольник'#13+'PYRAMID=Пирамида'#13+
'INVERT. PYRAMID=Инверт. пирамида'#13+
'CYLINDER=Цилиндр'#13+
'ELLIPSE=Эллипс'#13+
'ARROW=Стрела'#13+
'RECT. GRADIENT=Прямоуг. градиент'#13+'CONE=Kegel'#13+
'DARK BAR 3D SIDES= Трехмерные столбцы'#13+
'BAR SIDE MARGINS=Границы столбца '#13+
'AUTO MARK POSITION=Автоматически отмечать позицию'#13+
'COLOR EACH=Цвет каждого'#13+
'BORDER=Граница'#13+
'JOIN=Объединить'#13+
'BAR SIDE MARGINS=Границы столбца'#13+
'DATASET=Набор данных'#13+
'APPLY=Применить'#13+
'SOURCE=Источник'#13+
'MONOCHROME=Монохромный'#13+
'DEFAULT=По умолчанию'#13+
'2 (1 BIT)=2 (1 бит)'#13+
'16 (4 BIT)=16 (4 бит)'#13+
'256 (8 BIT)=256 (8 бит)'#13+
'32768 (15 BIT)=32768 (15 бит)'#13+
'65536 (16 BIT)=65536 (16 бит)'#13+
'16M (24 BIT)=16M (24 бит)'#13+
'16M (32 BIT)=16M (32 бит)'#13+
'LENGTH=Длина'#13+
'MEDIAN=Медиана'#13+
'WHISKER=Частица'#13+
'PATTERN COLOR EDITOR=Редактор цветов узора'#13+
'IMAGE=Изображение'#13+
'NONE=Ничего'#13+
'BACK DIAGONAL=Задняя диагональ'#13+
'CROSS=Крест'#13+'DIAGONAL CROSS=Диагональный крест'#13+
'FILL 80%=80% Заполнение'#13+
'FILL 60%=60% Заполнение'#13+
'FILL 40%=40% Заполнение'#13+
'FILL 20%=20% Заполнение'#13+
'FILL 10%=10% Заполнение'#13+
'ZIG ZAG=Зигзаг'#13+
'VERTICAL SMALL=Вертикальные маленькие'#13+
'HORIZ. SMALL=Горизонт. маленькие'#13+
'DIAG. SMALL=Диагон. маленькие'#13+
'BACK DIAG. SMALL=Задние диагон. маленькие'#13+
'CROSS SMALL=Маленький крест'#13+
'DIAG. CROSS SMALL=Диагон. маленький крест'#13+
'PATTERN COLOR EDITOR=Редактор цветов узора'#13+
'OPTIONS=Настройки'#13+
'DAYS=Дни'#13+
'WEEKDAYS=Дни недели'#13+
'TODAY=Сегодня'#13+
'SUNDAY=Воскресенье'#13+
'TRAILING=Замыкающий'#13+
'MONTHS=Месяцы'#13+
'LINES=Линии'#13+
'SHOW WEEKDAYS=Показать дни недели'#13+
'UPPERCASE=Верхний регистр'#13+
'TRAILING DAYS=Замыкающие дни'#13+
'SHOW TODAY=Погозать сегодня'#13+
'SHOW MONTHS=Показать месяцы'#13+
'CANDLE WIDTH=Ширина свечи'#13+
'STICK=Палка'#13+
'BAR=Столбец'#13+
'OPEN CLOSE=Открыть закрыть'#13+
'UP CLOSE=Верх закрыть'#13+'DOWN CLOSE=Низ закрыть'#13+
'SHOW OPEN=Показать открытые'#13+
'SHOW CLOSE=Показать закрытые'#13+
'DRAW 3D=Трёхмерные'#13+
'DARK 3D=Тёмные трёхмерные'#13+
'EDITING=Редактирование'#13+
'CHART=Диаграмма'#13+
'SERIES=Серии'#13+
'DATA=Данные'#13+
'TOOLS=Инструменты'#13+'EXPORT=Экспорт'#13+
'PRINT=Печатать'#13+
'GENERAL=Общие'#13+
'TITLES=Заголовки'#13+
'LEGEND=Легенда'#13+
'PANEL=Панель'#13+
'PAGING=По страницам'#13+
'WALLS=Стены'#13+
'3D=Трёхмерный'#13+
'ADD=Добавить'#13+
'DELETE=Удалить'#13+'TITLE=Название'#13+
'CLONE=Скопировать'#13+
'CHANGE=Изменить'#13+
'HELP=Помощь'#13+
'CLOSE=Закрыть'#13+
'IMAGE=Изображение'#13+
'TEECHART PRINT PREVIEW=Просмотр печати TeeChart'#13+
'PRINTER=Принтер'#13+
'SETUP=Установка'#13+
'ORIENTATION=Ориентация'#13+
'PORTRAIT=Портретная'#13+'LANDSCAPE=Ландшафтная'#13+
'MARGINS (%)=Границы (%)'#13+
'DETAIL=Детали'#13+
'MORE=Больше'#13+
'NORMAL=Нормально'#13+
'RESET MARGINS=Сбросить границы'#13+
'VIEW MARGINS=Просмотр границ'#13+
'PROPORTIONAL=Пропорциональный'#13+
'TEECHART PRINT PREVIEW= Просмотр печати TeeChart'#13+
'RECTANGLE=Прямоугольник'#13+
'CIRCLE=Круг'#13+
'VERTICAL LINE=Верт. линия'#13+
'HORIZ. LINE=Гориз. линия'#13+
'TRIANGLE=Триугольник'#13+
'INVERT. TRIANGLE=Инверт. треугольник'#13+
'LINE=Линия'#13+
'DIAMOND=Бриллиант'#13+
'CUBE=Куб'#13+
'DIAGONAL CROSS=Диагонаотный крест'#13+
'STAR=Звезда'#13+
'TRANSPARENT=Прозрачный'#13+
'HORIZ. ALIGNMENT=Гориз. выравнивание'#13+
'LEFT=Слева'#13+
'CENTER=По центру'#13+
'RIGHT=Справа'#13+
'ROUND RECTANGLE=Скруглённый прямоугольник'#13+
'ALIGNMENT=Выравнивание'#13+
'TOP=Верхний'#13+
'BOTTOM=Нижний'#13+
'RIGHT=:Правый'#13+
'BOTTOM=Нижний'#13+'UNITS=единицы'#13+
'PIXELS=Пиксели'#13+
'AXIS=Ось'#13+
'AXIS ORIGIN=Смещение оси'#13+
'ROTATION=Вращение'#13+
'CIRCLED=Круговой'#13+
'3 DIMENSIONS=Трёхмерный'#13+
'RADIUS=Радиус'#13+
'ANGLE INCREMENT=Угловое приращение'#13+
'RADIUS INCREMENT=Приращение радиуса'#13+
'CLOSE CIRCLE=Закрытый круг'#13+
'PEN=Перо'#13+
'CIRCLE=Круг'#13+
'LABELS=Метки'#13+
'VISIBLE=Видимый'#13+
'ROTATED=Повёрнутый'#13+
'CLOCKWISE=По часовой стрелке'#13+
'INSIDE=Внутрь'#13+
'ROMAN=Римские'#13+
'HOURS=Часы'#13+
'MINUTES=Минуты'#13+
'SECONDS=Секунды'#13+
'START VALUE=Начальное значение'#13+
'END VALUE=Конечное значение'#13+
'TRANSPARENCY=Прозрачность'#13+
'DRAW BEHIND=Рисовать сзади'#13+
'COLOR MODE=Цветовой режим'#13+
'STEPS=Шаги'#13+
'RANGE=Диапазон'#13+
'PALETTE=Палитра'#13+
'PALE=Рамка'#13+
'STRONG=Жирный'#13+
'GRID SIZE=Шаг сетки'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Глубина'#13+
'IRREGULAR=Нерегулярный'#13+
'GRID=Сетка'#13+
'VALUE=Значение'#13+
'ALLOW DRAG=Разрешить перетаскивание'#13+
'VERTICAL POSITION=Вертикальная позиция'#13+
'PEN=Перо'#13+
'LEVELS POSITION=Позиции уровней'#13+
'LEVELS=Уровни'#13+
'NUMBER=Номер'#13+
'LEVEL=Уровень'#13+
'AUTOMATIC=Автоматически'#13+
'BOTH=Оба'#13+
'SNAP=Привязка'#13+
'FOLLOW MOUSE=Следовать за мышью'#13+
'STACK=Стопка'#13+
'HEIGHT 3D=Трёхмерная высота'#13+
'LINE MODE=Режим линии'#13+
'STAIRS=Ступеньки'#13+
'NONE=Ничего'#13+
'OVERLAP=Перекрытие'#13+
'STACK=Стопка'#13+
'STACK 100%=Стопка 100%'#13+
'CLICKABLE=Для щелчка'#13+
'LABELS=Метки'#13+
'AVAILABLE=Доступно'#13+
'SELECTED=Выделенный'#13+
'DATASOURCE=Источник данных'#13+
'GROUP BY=Группировать по'#13+
'CALC=Калькулятор'#13+
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
'HOLE %=Дыра %'#13+
'RESET POSITIONS=Сброс позиции'#13+
'MOUSE BUTTON=Кнопка мыши'#13+
'ENABLE DRAWING=Включить рисование'#13+
'ENABLE SELECT=Включить выбор'#13+
'ENHANCED=Усовершенствованный'#13+
'ERROR WIDTH=Ширина ошибки'#13+
'WIDTH UNITS=Единицы ширины'#13+
'PERCENT=Процент'#13+
'PIXELS=Пиксел'#13+
'LEFT AND RIGHT=Слева и справа'#13+
'TOP AND BOTTOM=Сверху и снизу'#13+
'COLOR EACH=Цвет каждого'#13+
'BORDER=Граница'#13+
'BORDER EDITOR=Редактор границы'#13+
'DASH=Штриховая'#13+
'DOT=Пунктирная'#13+
'DASH DOT=Штрих пунктирная'#13+
'DASH DOT DOT=Штрих-дот пунктирная'#13+
'CALCULATE EVERY=Вычислить каждый'#13+
'ALL POINTS=Все точки'#13+
'NUMBER OF POINTS=Количество точек'#13+
'RANGE OF VALUES=Диапазон значений'#13+
'FIRST=Первый'#13+'CENTER=Центральный'#13+
'LAST=Последний'#13+
'TEEPREVIEW EDITOR=TeePreview редактор'#13+
'ALLOW MOVE=Разрешить перемещение'#13+
'ALLOW RESIZE=Разрешить изменение размера'#13+
'DRAG IMAGE=Перетащить изображение'#13+
'AS BITMAP=Как битовый образ'#13+
'SHOW IMAGE=Показать изображение'#13+
'DEFAULT=По умолчанию'#13+
'MARGINS=Границы'#13+
'SIZE=Размер'#13+
'3D %=Трёхмерный %'#13+
'ZOOM=Увеличение'#13+
'ROTATION=Вращение'#13+
'ELEVATION=Подъём'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Гориз. смещение'#13+
'VERT. OFFSET=Верт. смещение'#13+
'PERSPECTIVE=Перспектива'#13+
'ANGLE=Угол'#13+
'ORTHOGONAL=Ортогональная'#13+
'ZOOM TEXT=Увеличить текст'#13+
'SCALES=Чешуя'#13+
'TITLE=Заголовок'#13+
'TICKS=Позиции'#13+
'MINOR=Второстепенный'#13+
'MAXIMUM=Максимальное'#13+
'MINIMUM=Минимальное'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Желаемое приращение'#13+
'(INCREMENT)=(приращение)'#13+
'LOG BASE=Основание логарифма'#13+
'LOGARITHMIC=Логарифмический'#13+
'TITLE=Заголовок'#13+
'MIN. SEPARATION %=Мин. разделение %'#13+
'MULTI-LINE=Множество линий'#13+
'LABEL ON AXIS=Метка на оси'#13+
'ROUND FIRST=Округлить первое'#13+
'MARK=Отметка'#13+
'LABELS FORMAT=Формат меток'#13+
'EXPONENTIAL=Экспоненциальный'#13+
'DEFAULT ALIGNMENT=Выравнивание по умолчанию'#13+
'LEN=Длина'#13+
'AXIS=Ось'#13+
'INNER=Внутренний'#13+
'GRID=Сетка'#13+
'AT LABELS ONLY=Только на метках'#13+
'CENTERED=Центрированный'#13+
'COUNT=Количество'#13+
'TICKS=Позиции'#13+'POSITION %=Позиция %'#13+
'START %=Начало %'#13+
'END %=Конец %'#13+
'OTHER SIDE=Другая сторона'#13+
'AXES=Оси'#13+
'BEHIND=Позади'#13+
'CLIP POINTS=Точки выреза'#13+
'PRINT PREVIEW=Просмотр печати'#13+
'MINIMUM PIXELS=Минимально пикселей'#13+
'MOUSE BUTTON=Кнопка мыши'#13+
'ALLOW=Позволить'#13+
'ANIMATED=Анимированный'#13+
'VERTICAL=Вертикальный'#13+
'RIGHT=Справа'#13+
'MIDDLE=Посредине'#13+
'ALLOW SCROLL=Разрешить скроллинг'#13+
'TEEOPENGL EDITOR=Редактор TeeOpenGL'#13+
'AMBIENT LIGHT=Окружающий свет'#13+
'SHININESS=Сияние'#13+
'FONT 3D DEPTH=Трёхмерная глубина шрифта'#13+
'ACTIVE=Активный'#13+
'FONT OUTLINES=Выделение шрифта'#13+
'SMOOTH SHADING=Плавное затенение'#13+
'LIGHT=Свет'#13+
'Y=Y'#13+
'INTENSITY=Интенсивность'#13+
'BEVEL=Фаска'#13+
'FRAME=Рамка'#13+
'ROUND FRAME=Скруглённая рамка'#13+
'LOWERED=Пониженный'#13+
'RAISED=Приподнятый'#13+
'POSITION=Позиция'#13+
'SYMBOLS=Символы'#13+
'TEXT STYLE=Стиль текста'#13+
'LEGEND STYLE=Легенда стилей'#13+
'VERT. SPACING=Вертикальый отступ'#13+
'AUTOMATIC=Автоматический'#13+
'SERIES NAMES=Наименование серии'#13+
'SERIES VALUES=Значение серии'#13+
'LAST VALUES=Последние значения'#13+
'PLAIN=Плоский'#13+
'LEFT VALUE=Левое значение'#13+
'RIGHT VALUE=Правое значение'#13+
'LEFT PERCENT=Процентов слева'#13+
'RIGHT PERCENT=Процентов справа'#13+
'X VALUE=Значение по X'#13+
'VALUE=Значение'#13+
'PERCENT=Процент'#13+
'X AND VALUE=X and Значение'#13+
'X AND PERCENT=X and Процент'#13+
'CHECK BOXES=Кнопка выбора'#13+
'DIVIDING LINES=Разделительные линии'#13+
'FONT SERIES COLOR=Цвет семейства шрифтов'#13+
'POSITION OFFSET %=Отступ позиции %'#13+
'MARGIN=Граница'#13+
'RESIZE CHART=Изменить размер диаграммы'#13+
'CUSTOM=Индивидуальный'#13+
'WIDTH UNITS=Единицы ширины'#13+'CONTINUOUS=Сплошной'#13+
'POINTS PER PAGE=Точек на страницу'#13+
'SCALE LAST PAGE=Растянуть последнюю страницу'#13+
'CURRENT PAGE LEGEND=Легенда текущей страницы'#13+
'PANEL EDITOR=Редактор панелей'#13+
'BACKGROUND=Фон'#13+
'BORDERS=Границы'#13+
'BACK IMAGE=Фоновое изображение'#13+
'STRETCH=Растянуть'#13+
'TILE=Заголовок'#13+
'CENTER=Центр'#13+
'BEVEL INNER=Внутренний скос'#13+
'LOWERED=Пониженный'#13+
'RAISED=Приподнятый'#13+
'BEVEL OUTER=Внешний скос'#13+
'MARKS=Отметки'#13+
'DATA SOURCE=Источник данных'#13+
'SORT=Сотрировать'#13+
'CURSOR=Курсор'#13+
'SHOW IN LEGEND=Показать в легенде'#13+
'FORMATS=Форматы'#13+
'VALUES=Значения'#13+
'PERCENTS=Проценты'#13+
'HORIZONTAL AXIS=Горизонтальная ось'#13+
'TOP AND BOTTOM=Верх и низ'#13+
'DATETIME=Дата и время'#13+
'VERTICAL AXIS=Вертикальная ось'#13+
'LEFT=Слева'#13+
'RIGHT=Справа'#13+
'LEFT AND RIGHT=Слева и справа'#13+
'ASCENDING=Нарастающий'#13+
'DESCENDING=Убывающий'#13+
'DRAW EVERY=Рисовать каждый'#13+
'CLIPPED=Урезанный'#13+'ARROWS=Стрелки'#13+
'MULTI LINE=Множество линий'#13+
'ALL SERIES VISIBLE=Все серии видимые'#13+
'LABEL=Метка'#13+
'LABEL AND PERCENT=Метка и процент'#13+
'LABEL AND VALUE=Метка и значение'#13+
'PERCENT TOTAL=Всего процентов'#13+
'LABEL AND PERCENT TOTAL=Метка и всего процентов'#13+
'X VALUE=Значение по X'#13+
'X AND Y VALUES=Значения по X и Y'#13+
'MANUAL=Вручную'#13+
'RANDOM=Случайно'#13+
'FUNCTION=Функция'#13+
'NEW=Новый'#13+
'EDIT=Редактировать'#13+
'DELETE=Удалить'#13+
'PERSISTENT=Постоянный'#13+
'ADJUST FRAME=Настроить рамку'#13+
'SUBTITLE=Подзаголовок'#13+
'SUBFOOT=Подитог'#13+
'FOOT= Итог'#13+
'DELETE=Удалить'#13+
'VISIBLE WALLS=Видимые стены'#13+
'BACK=Задний фон'#13+
'DIF. LIMIT=Разница лимита'#13+
'LINES=Линии'#13+
'ABOVE=Выше'#13+
'WITHIN=Внутри'#13+
'BELOW=Ниже'#13+
'CONNECTING LINES=Соединительные линии'#13+
'SERIES=Серии'#13+
'PALE=Бледный'#13+
'STRONG=Жирный'#13+'HIGH=Oben'#13+
'LOW=Низкий'#13+
'BROWSE=Просмотр'#13+
'TILED=Замощёный'#13+
'INFLATE MARGINS=Раздуть границы'#13+
'SQUARE=Квадрат'#13+
'DOWN TRIANGLE=Нижний треугольник'#13+
'SMALL DOT=Маленькая точка'#13+
'DEFAULT=По умолчанию'#13+
'COLOR EACH=Цвет каждого'#13+
'GLOBAL=Глобальный'#13+
'SHAPES=Формы'#13+
'BRUSH=Кисть'#13+
'BRUSH=Кисть'#13+
'BORDER=Граница'#13+
'COLOR=Цвет'#13+
'DELAY=Задержка'#13+
'MSEC.=милисек.'#13+
'MOUSE ACTION=Действие мыши'#13+
'MOVE=Движение'#13+
'CLICK=Щелчок'#13+
'BRUSH=Кисть'#13+
'DRAW LINE=Рисовать линию'#13+
'BORDER EDITOR=Редактор границы'#13+
'DASH=Solid'#13+
'DOT=Dash'#13+
'DASH DOT=Dot'#13+
'DASH DOT DOT=Dash Dot'#13+
'EXPLODE BIGGEST=Просмотреть наибольшее'#13+
'TOTAL ANGLE=Полный угол'#13+
'GROUP SLICES=Срезы групп'#13+
'BELOW %=Менее %'#13+
'BELOW VALUE=Значение ниже'#13+
'OTHER=Другое'#13+
'PATTERNS=Узор'#13+
'CLOSE CIRCLE=Закрытый круг'#13+
'VISIBLE=Видимый'#13+
'CLOCKWISE=По часовой стрелке'#13+
'SIZE %=Размер %'#13+
'PATTERN=Узор'#13+
'DEFAULT=По умолчанию'#13+
'SERIES DATASOURCE TEXT EDITOR=Редактор наборов данных для серий'#13+
'FIELDS=Поля'#13+
'NUMBER OF HEADER LINES=Количество строк заголовка'#13+
'SEPARATOR=Разделитель'#13+
'COMMA=Запятая'#13+
'SPACE=Пробел'#13+
'TAB=Табуляция'#13+
'FILE=Файл'#13+
'WEB URL=Адрес Web'#13+
'LOAD=Загрузить'#13+
'C LABELS=C Метки'#13+
'R LABELS=R Метки'#13+
'C PEN=C Перо'#13+'R PEN=R Перо'#13+
'STACK GROUP=Группа стопки'#13+
'USE ORIGIN=Использовать смещение'#13+
'MULTIPLE BAR=Несколько столбцов'#13+
'SIDE=Сторона'#13+
'STACKED 100%=В стопке 100%'#13+
'SIDE ALL=Вся сторона'#13+
'BRUSH=Кисть'#13+
'DRAWING MODE=Режим рисования'#13+
'SOLID=Сплошной'#13+
'WIREFRAME=Проволочная'#13+
'DOTFRAME=Точечная'#13+
'SMOOTH PALETTE=Плавная палитра'#13+
'SIDE BRUSH=Боковая кисть'#13+
'ABOUT TEECHART PRO V7.0=О TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Все права защищены.'#13+
'VISIT OUR WEB SITE !=Посетите нашу страницу в интернет !'#13+
'TEECHART WIZARD=Мастер TeeChart'#13+
'SELECT A CHART STYLE=Выберите вид диаграммы'#13+
'DATABASE CHART=Диаграмма, связанная с данными'#13+
'NON DATABASE CHART= Диаграмма, не связанная с данными '#13+
'SELECT A DATABASE TABLE=Выберите таблицу базы данных'#13+
'ALIAS=Псевдоним'#13+
'TABLE=Таблица'#13+
'SOURCE=Источник'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Выберите необходимые поля'#13+
'SELECT A TEXT LABELS FIELD=Выберите метки для полей данных'#13+
'CHOOSE THE DESIRED CHART TYPE=Выберите желамый тип диаграммы'#13+
'2D=Двухмерный'#13+
'CHART PREVIEW=Просмотр диаграммы'#13+
'SHOW LEGEND=Показать легенду'#13+
'SHOW MARKS=Показать отметки'#13+
'COLOR EACH=Цвет каждого'#13+
'< BACK=< Назад'#13+
'SELECT A CHART STYLE=Выберите стиль диаграммы'#13+
'NON DATABASE CHART=Диаграмма, не связанная с данными'#13+
'SELECT A DATABASE TABLE= Выберите таблицу базы данных'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Выберите необходимые поля'#13+
'SELECT A TEXT LABELS FIELD=Выберите метки для полей данных'#13+
'CHOOSE THE DESIRED CHART TYPE=Выберите желамый тип диаграммы'#13+
'EXPORT CHART=Экспортировать диаграмму'#13+
'PICTURE=Картинка'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Сохранять коэффициент сжатия'#13+
'INCLUDE SERIES DATA=Включить данные серий'#13+
'FILE SIZE=Размер файла'#13+
'DELIMITER=Разделитель'#13+
'XML=XML'#13+
'HTML TABLE=HTML Таблица'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=Двоеточие'#13+
'INCLUDE=Включить'#13+
'POINT LABELS=Метка точки'#13+
'POINT INDEX=Индекс точки'#13+
'HEADER=Заголовок'#13+
'COPY=Копировать'#13+
'SAVE=Сохранить'#13+
'SEND=Отправить'#13+
'KEEP ASPECT RATIO=Сохранять коэффициент сжатия'#13+
'INCLUDE SERIES DATA=Включить данные серий '#13+
'FUNCTIONS=Функции'#13+
'ADD=Добавить'#13+
'ADX=ADX'#13+
'AVERAGE=Средний'#13+
'BOLLINGER=Dividieren'#13+
'COPY=Копировать'#13+
'DIVIDE=Разделить'#13+
'EXP. AVERAGE=Мат. ожидание'#13+
'EXP.MOV.AVRG.=Gleit.Durchschn.'#13+
'HIGH=Высокий'#13+
'LOW=Низкий'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Multiplizieren'#13+
'MULTIPLY=Перемножить'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Квадратный корень'#13+'STD.DEVIATION=Subtrahieren'#13+
'STOCHASTIC=Стохастический'#13+
'SUBTRACT=Вычитание'#13+
'APPLY=Применить'#13+
'SOURCE SERIES=Серии источников'#13+
'TEECHART GALLERY=Галерея TeeChart'#13+
'FUNCTIONS=Функции'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduction'#13+
'COMPRESSION=Compression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Ближайший'#13+
'FLOYD STEINBERG=Флойд Стейнберг'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Стив Арч'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows серый'#13+
'MONOCHROME=Монохромный'#13+
'GRAY SCALE=Оттенки серого'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Квантизировать'#13+
'QUANTIZE 256=Квантизировать 256'#13+
'% QUALITY=% Качество'#13+
'GRAY SCALE=Оттенки серого'#13+
'PERFORMANCE=Производительность'#13+
'QUALITY=Качество'#13+
'SPEED=Скорость'#13+
'COMPRESSION LEVEL=Степень сжатия'#13+
'CHART TOOLS GALLERY=Галарея Chart Tools'#13+
'ANNOTATION=Аннотация'#13+
'AXIS ARROWS=Стрелки осей'#13+
'COLOR BAND=Цветной край'#13+
'COLOR LINE=Цветная линия'#13+
'CURSOR=Курсор'#13+
'DRAG MARKS=Переместить отметки'#13+
'DRAW LINE=Рисовать линию'#13+
'IMAGE=Изображение'#13+
'MARK TIPS=Отметить подсказки'#13+
'NEAREST POINT=Ближайшая точка'#13+
'ROTATE=Вращать'#13+
'CHART TOOLS GALLERY=Галерея Chart Tools'#13+
'BRUSH=Кисть'#13+
'DRAWING MODE=Режим рисования'#13+
'WIREFRAME=Проволочный'#13+
'SMOOTH PALETTE=Плавная палитра'#13+
'SIDE BRUSH=Боковая кисть'#13+
'YES=Да'#13
;
  end;
end;

Procedure TeeSetRussian;
begin
  TeeCreateRussian;
  TeeLanguage:=TeeRussianLanguage;
  TeeRussianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeRussianLanguage);
end.