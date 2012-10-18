unit TeePolish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeePolishLanguage:TStringList=nil;

Procedure TeeCreatePolish;
Procedure TeeSetPolish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeePolishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='Pierwsza wartoúÊ legendy musi byÊ > 0';
  TeeMsg_LegendColorWidth   :='SzerokoúÊ musi byÊ miÍdzy 0 i 100';
  TeeMsg_SeriesSetDataSource:='Brak ParentChart øeby sprawdziÊ ürÛd≥o danych';
  TeeMsg_SeriesInvDataSource:='Brak poprawnego ürÛd≥a danych: %s';
  TeeMsg_FillSample         :='FillSampleValues wartoúci liczbowe muszπ byÊ > 0';
  TeeMsg_AxisLogDateTime    :='Oú daty/czasu nie moøe byÊ logarytmiczna';
  TeeMsg_AxisLogNotPositive :='Min i Max wartoúci osi logarytmicznej powinny byÊ >= 0';
  TeeMsg_AxisLabelSep       :='% odstÍpu etykiet musi byÊ wiÍkszy niø 0';
  TeeMsg_AxisIncrementNeg   :='Inkrement osi musi byÊ >= 0';
  TeeMsg_AxisMinMax         :='WartoúÊ minimum osi musi byÊ <= maksimum';
  TeeMsg_AxisMaxMin         :='WartoúÊ maksimum osi musi byÊ >= minimum';
  TeeMsg_AxisLogBase        :='Podstawa logarytmiczna osi powinna byÊ >= 2';
  TeeMsg_MaxPointsPerPage   :='Max. iloúÊ punktÛw na stronÍ musi byÊ >= 0';
  TeeMsg_3dPercent          :='Procent efektu 3W musi byÊ zawarty miÍdzy %d i %d';
  TeeMsg_CircularSeries     :='Cykliczne zaleønoúci miÍdzy seriami sπ niedozwolone';
  TeeMsg_WarningHiColor     :='16K kolor jest wymagany aby uzyskaÊ lepszy wyglπd';

  TeeMsg_DefaultPercentOf   :='%s z %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'z %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tytu≥ osi';
  TeeMsg_AxisLabels         :='Etykiety osi';
  TeeMsg_RefreshInterval    :='Interwa≥ odswieøania musi byÊ zawarty miÍdzy 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Sam nie jestem Series.ParentChart!';
  TeeMsg_GalleryLine        :='Liniowy';
  TeeMsg_GalleryPoint       :='Punktowy';
  TeeMsg_GalleryArea        :='Powierzchniowy';
  TeeMsg_GalleryBar         :='S≥upkowy';
  TeeMsg_GalleryHorizBar    :='S≥upkowy poziomy';
  TeeMsg_Stack              :='Stos';
  TeeMsg_GalleryPie         :='Ko≥owy';
  TeeMsg_GalleryCircled     :='Zaokrπglony';
  TeeMsg_GalleryFastLine    :='Szybka linia';
  TeeMsg_GalleryHorizLine   :='Liniowy horyz.';

  TeeMsg_PieSample1         :='Auta';
  TeeMsg_PieSample2         :='Telefony';
  TeeMsg_PieSample3         :='Sto≥y';
  TeeMsg_PieSample4         :='Monitory';
  TeeMsg_PieSample5         :='Lampy';
  TeeMsg_PieSample6         :='Klawiatury';
  TeeMsg_PieSample7         :='Rowery';
  TeeMsg_PieSample8         :='Krzes≥a';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Redagowanie %s';

  TeeMsg_GalleryStandard    :='Standardowe';
  TeeMsg_GalleryExtended    :='Rozszerzone';
  TeeMsg_GalleryFunctions   :='Funkcje';

  TeeMsg_EditChart          :='&Edycja wykresu...';
  TeeMsg_PrintPreview       :='&Podglπd wydruku...';
  TeeMsg_ExportChart        :='E&ksport wykresu...';
  TeeMsg_CustomAxes         :='Dostosowane osie...';

  TeeMsg_InvalidEditorClass :='%s: Nieprawid≥owa klasa edytora: %s';
  TeeMsg_MissingEditorClass :='%s: brak okna dialogowego edytora';

  TeeMsg_GalleryArrow       :='Strza≥kowy';

  TeeMsg_ExpFinish          :='&Koniec';
  TeeMsg_ExpNext            :='&Dalej >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Projekt';
  TeeMsg_GanttSample2       :='Prototyp';
  TeeMsg_GanttSample3       :='RozwÛj';
  TeeMsg_GanttSample4       :='Sprzedaø';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testowanie';
  TeeMsg_GanttSample7       :='Produkcja';
  TeeMsg_GanttSample8       :='Ulepszanie';
  TeeMsg_GanttSample9       :='Nowa wersja';
  TeeMsg_GanttSample10      :='BankowoúÊ';

  TeeMsg_ChangeSeriesTitle  :='ZmieÒ tytu≥ serii';
  TeeMsg_NewSeriesTitle     :='Nowy tytu≥ serii:';
  TeeMsg_DateTime           :='Data/Czas';
  TeeMsg_TopAxis            :='GÛrna oú';
  TeeMsg_BottomAxis         :='Dolna oú';
  TeeMsg_LeftAxis           :='Lewa oú';
  TeeMsg_RightAxis          :='Prawa oú';

  TeeMsg_SureToDelete       :='UsunπÊ %s ?';
  TeeMsg_DateTimeFormat     :='For&mat daty/czasu:';
  TeeMsg_Default            :='Domyúlnie';
  TeeMsg_ValuesFormat       :='For&mat wartoúci:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Poøadany %s Inkrement';

  TeeMsg_IncorrectMaxMinValue:='Z≥a wartoúÊ. Przyczyna: %s';
  TeeMsg_EnterDateTime      :='Wprowadü [liczba dni] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='ZastosowaÊ zmiany ?';
  TeeMsg_SelectedSeries     :='(Wybrane serie)';
  TeeMsg_RefreshData        :='&Odúwieø dane';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_FunctionAdd        :='Dodaj';
  TeeMsg_FunctionSubtract   :='Odejmij';
  TeeMsg_FunctionMultiply   :='PomnÛø';
  TeeMsg_FunctionDivide     :='Podziel';
  TeeMsg_FunctionHigh       :='Wysoko';
  TeeMsg_FunctionLow        :='Nisko';
  TeeMsg_FunctionAverage    :='årednio';

  TeeMsg_GalleryShape       :='Kszta≥ty';
  TeeMsg_GalleryBubble      :='Bπbelkowy';
  TeeMsg_FunctionNone       :='Kopiuj';

  TeeMsg_None               :='(Brak)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='WielkoúÊ wskaünika musi byÊ wiÍksza niø zero';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatkowo';
  tcDControls               :='Kontrolki danych';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='ZbiÛr danych';
  TeeMsg_AskDataSet         :='&ZbiÛr danych:';

  TeeMsg_SingleRecord       :='PojedyÒczy wiersz';
  TeeMsg_AskDataSource      :='&èrÛd≥o danych:';

  TeeMsg_Summary            :='Podsumowanie';

  TeeMsg_FunctionPeriod     :='Okres funkcji powinien byÊ >= 0';

  TeeMsg_WizardTab          :='Biznes';

  TeeMsg_ClearImage         :='&WyszyúÊ';
  TeeMsg_BrowseImage        :='&Szukaj w...';

  TeeMsg_WizardSureToClose  :='Jesteú pewien, øe chcesz zamknπÊ kreatora TeeChart ?';
  TeeMsg_FieldNotFound      :='Pole %s nie istnieje';

  TeeMsg_DepthAxis          :='Oú g≥Íbokoúci';
  TeeMsg_PieOther           :='Inny';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Ko≥o';
  TeeMsg_ValuesBar          :='S≥upek';
  TeeMsg_ValuesAngle        :='Kπt';
  TeeMsg_ValuesGanttStart   :='Poczπtek';
  TeeMsg_ValuesGanttEnd     :='Koniec';
  TeeMsg_ValuesGanttNextTask:='Nastepne zadanie';
  TeeMsg_ValuesBubbleRadius :='PromieÒ';
  TeeMsg_ValuesArrowEndX    :='KoniecX';
  TeeMsg_ValuesArrowEndY    :='KoniecY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Tytu≥';
  TeeMsg_Foot               :='Stopka';
  TeeMsg_Period		          :='Okres';
  TeeMsg_PeriodRange        :='Zakres okresÛw';
  TeeMsg_CalcPeriod         :='%s oblicz kaødy:';
  TeeMsg_SmallDotsPen       :='Ma≥e kropki';

  TeeMsg_InvalidTeeFile     :='Nieprawid≥owy wykres w pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Z≥y format pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Pusty plik *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Osie wykresu';
  TeeMsg_ChartAxesCategoryDesc   :='Osie wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_ChartWallsCategoryName  :='åciany wykresu';
  TeeMsg_ChartWallsCategoryDesc  :='åciany wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_ChartTitlesCategoryName :='Tytu≥y wykresu';
  TeeMsg_ChartTitlesCategoryDesc :='Tytu≥y wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_Chart3DCategoryName     :='Wykres 3W';
  TeeMsg_Chart3DCategoryDesc     :='Wykres 3W - w≥aúciwoúci i zdarzenia';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Dostosowany ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serie...';

  TeeMsg_PageOfPages            :='Strona %d z %d';
  TeeMsg_FileSize               :='%d bajtÛw';

  TeeMsg_First  :='Pierwszy';
  TeeMsg_Prior  :='Poprzedni';
  TeeMsg_Next   :='NastÍpny';
  TeeMsg_Last   :='Ostatni';
  TeeMsg_Insert :='Wstaw';
  TeeMsg_Delete :='UsuÒ';
  TeeMsg_Edit   :='Redaguj';
  TeeMsg_Post   :='Zastosuj';
  TeeMsg_Cancel :='Anuluj';

  TeeMsg_All    :='(wszystko)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='jako &Bitmapa';
  TeeMsg_BMPFilter    :='Bitmapy (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='jako &Metafile';
  TeeMsg_EMFFilter    :='Ulepszone Metapliki (*.emf)|*.emf|Metapliki (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='W≥aúciwoúÊ panel nie jest ustawiona w formacie Eksportu';

  TeeMsg_Normal    :='Normalny';
  TeeMsg_NoBorder  :='Bez krawÍdzi';
  TeeMsg_Dotted    :='Kropkowany';
  TeeMsg_Colors    :='Kolory';
  TeeMsg_Filled    :='Wype≥niony';
  TeeMsg_Marks     :='Znaczniki';
  TeeMsg_Stairs    :='Schody';
  TeeMsg_Points    :='Punkty';
  TeeMsg_Height    :='WysokoúÊ';
  TeeMsg_Hollow    :='Pusty';
  TeeMsg_Point2D   :='Punkt 2W';
  TeeMsg_Triangle  :='TrÛjkπt';
  TeeMsg_Star      :='Gwiazda';
  TeeMsg_Circle    :='Ko≥o';
  TeeMsg_DownTri   :='TrÛjkπt odwr.';
  TeeMsg_Cross     :='Krzyø';
  TeeMsg_Diamond   :='Diament';
  TeeMsg_NoLines   :='Bez linii';
  TeeMsg_Stack100  :='Stos 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Piramida odwr.';
  TeeMsg_Sides     :='Boki';
  TeeMsg_SideAll   :='Wszystkie boki';
  TeeMsg_Patterns  :='Wzory';
  TeeMsg_Exploded  :='RozsuniÍty';
  TeeMsg_Shadow    :='CieÒ';
  TeeMsg_SemiPie   :='PÛ≥kole';
  TeeMsg_Rectangle :='Prostokπt';
  TeeMsg_VertLine  :='Linia pion.';
  TeeMsg_HorizLine :='Linia poz.';
  TeeMsg_Line      :='Linia';
  TeeMsg_Cube      :='Szeúcian';
  TeeMsg_DiagCross :='Diag.Krzyø';

  TeeMsg_CanNotFindTempPath    :='Nie mogÍ znaleüÊ folderu Temp';
  TeeMsg_CanNotCreateTempChart :='Nie mogÍ utworzyÊ pliku Temp';
  TeeMsg_CanNotEmailChart      :='Nie mogÍ wys≥aÊ wykresu TeeChart. B≥πd MAPI: %d';

  TeeMsg_SeriesDelete :='Usuwanie serii: Indeks wartoúci %d poza granicami (0 do %d).';

  // 5.02
  TeeMsg_AskLanguage  :='&JÍzyk...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Biegunowy';
  TeeMsg_GalleryCandle      :='Gie≥dowy';
  TeeMsg_GalleryVolume      :='Wolumen';
  TeeMsg_GallerySurface     :='Powierzchniowy';
  TeeMsg_GalleryContour     :='Konturowy';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punktowy 3W';
  TeeMsg_GalleryRadar       :='Radarowy';
  TeeMsg_GalleryDonut       :='Pierúcieniowy';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='S≥upkowy 3W';
  TeeMsg_GalleryBigCandle   :='Gie≥dowy-wielki';
  TeeMsg_GalleryLinePoint   :='Linia Punkt';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Wodospad';
  TeeMsg_GalleryWindRose    :='RÛøa wiatrÛw';
  TeeMsg_GalleryClock       :='Zegarowy';
  TeeMsg_GalleryColorGrid   :='Siatka kolorÛw';
  TeeMsg_GalleryBoxPlot     :='Pude≥kowy';
  TeeMsg_GalleryHorizBoxPlot:='Pude≥k. poziomy';
  TeeMsg_GalleryBarJoin     :='S≥upkowy z≥πcz.';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='StopieÒ wielomianu musi leøeÊ pomiÍdzy 1 i 20';
  TeeMsg_AnswerVectorIndex   :='Indeks wektora odpowiedzi musi leøeÊ pomiÍdzy 1 i %d';
  TeeMsg_FittingError        :='Nie moøna przeprowadziÊ dopasowania';
  TeeMsg_PeriodRange         :='Okres musi byÊ >= 0';
  TeeMsg_ExpAverageWeight    :='Exp. úrednia musi leøeÊ pomiÍdzy 0 i 1';
  TeeMsg_GalleryErrorBar     :='S≥upki b≥Ídu';
  TeeMsg_GalleryError        :='B≥πd';
  TeeMsg_GalleryHighLow      :='Wysoko Nisko';
  TeeMsg_FunctionMomentum    :='PÍd';
  TeeMsg_FunctionMomentumDiv :='PÍd (Div.)';
  TeeMsg_FunctionExpAverage  :='Exp.årednia';
  TeeMsg_FunctionMovingAverage:='årednia ruchoma';
  TeeMsg_FunctionExpMovAve   :='Exp.årednia ruchoma';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Krzywa dostosowana';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulacja';
  TeeMsg_FunctionStdDeviation:='Odchylenie std.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='åredni pierw.kw.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastyczny';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='IloúÊ';
  TeeMsg_LoadChart           :='OtwÛrz TeeChart...';
  TeeMsg_SaveChart           :='Zapisz TeeChart...';
  TeeMsg_TeeFiles            :='Pliki TeeChart Pro';

  TeeMsg_GallerySamples      :='Inne';
  TeeMsg_GalleryStats        :='Stat.';

  TeeMsg_CannotFindEditor    :='Nie moøna znaleüÊ formularza edytora serii: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod b≥Ídu: %d ≥adowanie wykresu z URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod b≥Ídu: %d ≥adowanie danych serii z URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='OtwÛrz';
  TeeMsg_ValuesHigh          :='Wysoka';
  TeeMsg_ValuesLow           :='Niska';
  TeeMsg_ValuesClose         :='Zamknij';
  TeeMsg_ValuesOffset        :='PrzesuniÍcie';
  TeeMsg_ValuesStdError      :='B≥πd Std.';

  TeeMsg_Grid3D              :='Siatka 3W';

  TeeMsg_LowBezierPoints     :='IloúÊ punktÛw Bezier powinna byÊ > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalny';
  TeeCommanMsg_Edit     :='Redaguj';
  TeeCommanMsg_Print    :='Drukuj';
  TeeCommanMsg_Copy     :='Kopiuj';
  TeeCommanMsg_Save     :='Zapisz';
  TeeCommanMsg_3D       :='3W';

  TeeCommanMsg_Rotating :='ObrÛt: %d∞ Podniesienie: %d∞';
  TeeCommanMsg_Rotate   :='ObrÛÊ';

  TeeCommanMsg_Moving   :='Poz.Przesun.: %d Pion.Przesun.: %d';
  TeeCommanMsg_Move     :='PrzesuÒ';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3W: %d %%';
  TeeCommanMsg_Depth    :='G≥ÍbokoúÊ';

  TeeCommanMsg_Chart    :='Wykres';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Ciπgnij %s by obrÛciÊ';
  TeeCommanMsg_MoveLabel  :='Ciπgnij %s by przesunπÊ';
  TeeCommanMsg_ZoomLabel  :='Ciπgnij %s by powiÍkszyÊ';
  TeeCommanMsg_DepthLabel :='Ciπgnij  %s by zmieniÊ g≥ÍbokoúÊ 3W';

  TeeCommanMsg_NormalLabel:='Ciπgnij lewym przyciskiem by wykonaÊ Zoom, prawym by przewinπÊ';
  TeeCommanMsg_NormalPieLabel:='Ciπgnij odp. wycinek by go wysunπÊ';

  TeeCommanMsg_PieExploding :='Wycinek: %d WysuniÍty: %d %%';

  TeeMsg_TriSurfaceLess:='Liczba punktÛw musi byÊ >= 4';
  TeeMsg_TriSurfaceAllColinear:='Wszystkie wspÛ≥liniowe punkty danych';
  TeeMsg_TriSurfaceSimilar:='Podobne punkty - nie moøna wykonaÊ';
  TeeMsg_GalleryTriSurface:='Powierzch. trÛjk.';

  TeeMsg_AllSeries :='Wszystkie serie';
  TeeMsg_Edit      :='Redaguj';

  TeeMsg_GalleryFinancial    :='Finansowe';

  TeeMsg_CursorTool    :='Kursor';
  TeeMsg_DragMarksTool :='Ciπgnij znacznik';
  TeeMsg_AxisArrowTool :='Strza≥ki Osi';
  TeeMsg_DrawLineTool  :='Rysuj Linie';
  TeeMsg_NearestTool   :='Najbliøszy Punkt';
  TeeMsg_ColorBandTool :='Kolorowa Taúma';
  TeeMsg_ColorLineTool :='Kolorowa Linia';
  TeeMsg_RotateTool    :='ObrÛc';
  TeeMsg_ImageTool     :='Obraz';
  TeeMsg_MarksTipTool  :='Uwagi Znacznika';

  TeeMsg_CantDeleteAncestor  :='Nie moøna usunπÊ poprzednika';

  TeeMsg_Load	         :='Wczytywanie...';
  TeeMsg_NoSeriesSelected:='Nie wybrano øadnej serii';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Wykres';
  TeeMsg_CategorySeriesActions :='Serie wykresu';

  TeeMsg_Action3D               :='&3W';
  TeeMsg_Action3DHint           :='Prze≥πcz 2W / 3W';
  TeeMsg_ActionSeriesActive     :='&Aktywne';
  TeeMsg_ActionSeriesActiveHint :='Pokaø/Ukryj serie';
  TeeMsg_ActionEditHint         :='Redaguj wykres';
  TeeMsg_ActionEdit             :='&Redaguj...';
  TeeMsg_ActionCopyHint         :='Kopiuj do schowka';
  TeeMsg_ActionCopy             :='&Kopiuj';
  TeeMsg_ActionPrintHint        :='Podglπd wydruku';
  TeeMsg_ActionPrint            :='&Drukuj...';
  TeeMsg_ActionAxesHint         :='Pokaø/Ukryj osie';
  TeeMsg_ActionAxes             :='&Osie';
  TeeMsg_ActionGridsHint        :='Pokaø/Ukryj siatkÍ';
  TeeMsg_ActionGrids            :='&Siatka';
  TeeMsg_ActionLegendHint       :='Pokaø/Ukryj legendÍ';
  TeeMsg_ActionLegend           :='&Legenda';
  TeeMsg_ActionSeriesEditHint   :='Redaguj serie';
  TeeMsg_ActionSeriesMarksHint  :='Pokaø/Ukryj znaczniki serii';
  TeeMsg_ActionSeriesMarks      :='&Znaczniki';
  TeeMsg_ActionSaveHint         :='Zapisz wykres';
  TeeMsg_ActionSave             :='&Zapisz...';

  TeeMsg_CandleBar              :='S≥upek';
  TeeMsg_CandleNoOpen           :='Bez otw.';
  TeeMsg_CandleNoClose          :='Bez zamkn.';
  TeeMsg_NoLines                :='Bez linii';
  TeeMsg_NoHigh                 :='Bez wysok.';
  TeeMsg_NoLow                  :='Bez nisk.';
  TeeMsg_ColorRange             :='Zakres kolorÛw';
  TeeMsg_WireFrame              :='Szkielet druc.';
  TeeMsg_DotFrame               :='Szkielet punkt.';
  TeeMsg_Positions              :='Pozycje';
  TeeMsg_NoGrid                 :='Bez siatki';
  TeeMsg_NoPoint                :='Bez punktu';
  TeeMsg_NoLine                 :='Bez linii';
  TeeMsg_Labels                 :='Etykiety';
  TeeMsg_NoCircle               :='Bez ko≥a';
  TeeMsg_Lines                  :='Linie';
  TeeMsg_Border                 :='KrawÍdü';

  TeeMsg_SmithResistance      :='OpÛr(Smith)';
  TeeMsg_SmithReactance       :='OpÛr bierny';
  
  TeeMsg_Column  :='Kolumna';

  { 5.01 }
  TeeMsg_Separator            :='Separator';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Lejkowy';
  TeeMsg_FunnelPercent        :='0.00%';
  TeeMsg_FunnelExceed         :='przekroczony limit';
  TeeMsg_FunnelWithin         :=' wewnetrzny limit';
  TeeMsg_FunnelBelow          :=' poniøej limitu';
  TeeMsg_CalendarSeries       :='Kalendarz';
  TeeMsg_DeltaPointSeries     :='Punkt delta';
  TeeMsg_ImagePointSeries     :='Punkt z obrazem';
  TeeMsg_ImageBarSeries       :='S≥upek z obrazem';
  TeeMsg_SeriesTextFieldZero  :='Tekst serii: Indeks pola powinien byÊ wiÍkszy niø zero.';

  { 5.02 }
  TeeMsg_Origin               :='Poczπtek';
  TeeMsg_Transparency         :='PrzezroczystoúÊ';
  TeeMsg_Box		      :='Pude≥ko';
  TeeMsg_ExtrOut	      :='ExtrOut';
  TeeMsg_MildOut	      :='MildOut';
  TeeMsg_PageNumber	      :='Numer strony';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='jako &JPEG';
  TeeMsg_JPEGFilter    :='Pliki JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='jako &GIF';
  TeeMsg_GIFFilter     :='Pliki GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='jako &PNG';
  TeeMsg_PNGFilter     :='Pliki PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='jako PC&X';
  TeeMsg_PCXFilter     :='Pliki PCX (*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Property            :='W≥aúciwoúci';
  TeeMsg_Value               :='WartoúÊ';
  TeeMsg_Yes                 :='Tak';
  TeeMsg_No                  :='Nie';
  TeeMsg_Image              :='(obrazek)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX wersja ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Nie moøna zaimportowaÊ TeeChart z %s';
  TeeMsg_ActiveXVerbPrint    := '&Podglπd wydruku...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Pomoc...';
  TeeMsg_ActiveXVerbAbout    := '&O TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Kod b≥Ídu: %d úciπganie: %s';
  TeeMsg_DatasourceError     := 'èrÛd≥o danych TeeChart nie jest Seriπ lub RecordSetem';
  TeeMsg_SeriesTextSrcError  := 'Nieprawid≥owy typ Serii';
  TeeMsg_AxisTextSrcError    := 'Nieprawid≥owy typ Osi';
  TeeMsg_DelSeriesDatasource := 'Czy jesteú pewny øe chcesz usunπÊ %s ?';
  TeeMsg_OCXNoPrinter        := 'Nie zainstalowano domyúlnej drukarki.';
  TeeMsg_ActiveXPictureNotValid:='Obraz jest nieprawid≥owy';

  // 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='jako &PDF';
  TeeMsg_PDFFilter        :='pliki PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='jako PostScript';
  TeeMsg_PSFilter         :='pliki PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horyzontalny'#13'Powierzchnia';
  TeeMsg_SelfStack        :='Auto stos';
  TeeMsg_DarkPen          :='Ciemna granica';
  TeeMsg_SelectFolder     :='Wybierz folder bazy danych';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Po≥πczenie:';

  // 6.0

  TeeMsg_FunctionSmooth       :='Wyg≥adzanie';
  TeeMsg_FunctionCross        :='Punkty krzyøa';
  TeeMsg_GridTranspose        :='Transpozycja Siatki 3W';
  TeeMsg_FunctionCompress     :='Kompresja';
  TeeMsg_ExtraLegendTool      :='Extra Legenda';
  TeeMsg_FunctionCLV          :='ZamkniÍcie Miejsce'#13'WartoúÊ';
  TeeMsg_FunctionOBV          :='Balans'#13'Wolumen';
  TeeMsg_FunctionCCI          :='Towar'#13'Indeks kana≥u';
  TeeMsg_FunctionPVO          :='Wolumen'#13'Oscylator';
  TeeMsg_SeriesAnimTool       :='Animacja serii';
  TeeMsg_GalleryPointFigure   :='Punkt i Rysunek';
  TeeMsg_Up                   :='GÛra';
  TeeMsg_Down                 :='DÛ≥';
  TeeMsg_GanttTool            :='Ciπgnij Gantt';
  TeeMsg_XMLFile              :='Plik XML';
  TeeMsg_GridBandTool         :='Pasmo siatki';
  TeeMsg_FunctionPerf         :='Wykonanie';
  TeeMsg_GalleryGauge         :='Wskaünik';
  TeeMsg_GalleryGauges        :='Wskaüniki';
  TeeMsg_ValuesVectorEndZ     :='KoniecZ';
  TeeMsg_GalleryVector3D      :='Wektor 3W';
  TeeMsg_Gallery3D            :='3W';
  TeeMsg_GalleryTower         :='Wieøa';
  TeeMsg_SingleColor          :='Jeden kolor';
  TeeMsg_Cover                :='Pokrywa';
  TeeMsg_Cone                 :='Stoøek';
  TeeMsg_PieTool              :='Wycinki ko≥a';
end;

Procedure TeeCreatePolish;
begin
  if not Assigned(TeePolishLanguage) then
  begin
    TeePolishLanguage:=TStringList.Create;
    TeePolishLanguage.Text:=

'GRADIENT EDITOR=Edytor gradientu'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Kierunek'#13+
'VISIBLE=Pokaø'#13+
'TOP BOTTOM=GÛra DÛ≥'#13+
'BOTTOM TOP=DÛ≥ GÛra'#13+
'LEFT RIGHT=Lewo Prawo'#13+
'RIGHT LEFT=Prawo Lewo'#13+
'FROM CENTER=Od úrodka'#13+
'FROM TOP LEFT=Od GÛry Lewo'#13+
'FROM BOTTOM LEFT=Od Do≥u Lewo'#13+
'OK=OK'#13+
'CANCEL=Anuluj'#13+
'COLORS=Kolory'#13+
'START=Poczπtek'#13+
'MIDDLE=årodek'#13+
'END=Koniec'#13+
'SWAP=ZamieÒ'#13+
'NO MIDDLE=Bez úrodka'#13+
'TEEFONT EDITOR=Edytor czcionki'#13+
'INTER-CHAR SPACING=Odst.miÍdzyznak.'#13+
'FONT=Czcionka'#13+
'SHADOW=CieÒ'#13+
'HORIZ. SIZE=Rozm. poziom.'#13+
'VERT. SIZE=Rozmiar pion.'#13+
'COLOR=Kolor'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Opcje'#13+
'FORMAT=Format'#13+
'TEXT=Tekst'#13+
'POSITION=Pozycja'#13+
'LEFT=Lewo'#13+
'TOP=GÛra'#13+
'AUTO=Auto'#13+
'CUSTOM=Dostosowana'#13+
'LEFT TOP=Lewo gÛra'#13+
'LEFT BOTTOM=Lewo dÛ≥'#13+
'RIGHT TOP=Prawo gÛra'#13+
'RIGHT BOTTOM=Prawo dÛ≥'#13+
'MULTIPLE AREAS=Wiele powierzchni'#13+
'NONE=Brak'#13+
'STACKED=Stos'#13+
'STACKED 100%=Stos 100%'#13+
'AREA=Powierzchnia'#13+
'PATTERN=WzÛr'#13+
'STAIRS=Schody'#13+
'SOLID=Pe≥ny'#13+
'CLEAR=Pusty'#13+
'HORIZONTAL=Poziomy'#13+
'VERTICAL=Pionowy'#13+
'DIAGONAL=Diagonaly'#13+
'B.DIAGONAL=B.Diagonal.'#13+
'CROSS=Krzyø'#13+
'DIAG.CROSS=Diag.Krzyø'#13+
'AREA LINES=Linie powierz.'#13+
'BORDER=KrawÍdü'#13+
'INVERTED=OdwrÛcony'#13+
'COLOR EACH=Koloruj kaødy'#13+
'ORIGIN=Poczπtek'#13+
'USE ORIGIN=Uøyj poczπtek'#13+
'WIDTH=Szerok.'#13+
'HEIGHT=WysokoúÊ'#13+
'AXIS=Oú'#13+
'LENGTH=D≥ugoúÊ'#13+
'SCROLL=Przewijaj'#13+
'BOTH=Oba'#13+
'AXIS INCREMENT=Inkrement osi'#13+
'INCREMENT=Inkrement'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Jedna milisekunda'#13+
'ONE SECOND=Jedna sekunda'#13+
'FIVE SECONDS=PiÍÊ sekund'#13+
'TEN SECONDS=DziesiÍÊ sekund'#13+
'FIFTEEN SECONDS=PiÍtnaúcie sekund'#13+
'THIRTY SECONDS=Trzydzieúci sekund'#13+
'ONE MINUTE=Jedna minuta'#13+
'FIVE MINUTES=PiÍÊ minut'#13+
'TEN MINUTES=DziesÍÊ minut'#13+
'FIFTEEN MINUTES=PiÍtnaúcie minut'#13+
'THIRTY MINUTES=Trzydzieúci minut'#13+
'ONE HOUR=Jedna godzina'#13+
'TWO HOURS=Dwie godziny'#13+
'SIX HOURS=SzeúÊ godzina'#13+
'TWELVE HOURS=Dwanaúcie godzin'#13+
'ONE DAY=Jeden dzieÒ'#13+
'TWO DAYS=Dwa dni'#13+
'THREE DAYS=Trzy dni'#13+
'ONE WEEK=Jeden tydzieÒ'#13+
'HALF MONTH=PÛ≥ miesiπca'#13+
'ONE MONTH=Jeden miesiπc'#13+
'TWO MONTHS=Dwa miesiπce'#13+
'THREE MONTHS=Trzy miesiπce'#13+
'FOUR MONTHS=Cztery miesiπce'#13+
'SIX MONTHS=SzeúÊ miesiÍcy'#13+
'ONE YEAR=Jeden rok'#13+
'EXACT DATE TIME=Dok≥adna data/czas'#13+
'AXIS MAXIMUM AND MINIMUM=Maksimum i minimum osi'#13+
'VALUE=WartoúÊ'#13+
'TIME=Czas'#13+
'LEFT AXIS=Oú lewa'#13+
'RIGHT AXIS=Oú prawa'#13+
'TOP AXIS=Oú gÛrna'#13+
'BOTTOM AXIS=Oú dolna'#13+
'% BAR WIDTH=% SzerokoúÊ s≥upka'#13+
'STYLE=Styl'#13+
'% BAR OFFSET=% PrzesuniÍcie s≥upka'#13+
'RECTANGLE=Prostokπt'#13+
'PYRAMID=Piramida'#13+
'INVERT. PYRAMID=OdwrÛcona piramida'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Elipsa'#13+
'ARROW=Strza≥ka'#13+
'RECT. GRADIENT=Prost. Gradient'#13+
'CONE=Stoøek'#13+
'DARK BAR 3D SIDES=Ciemne boki s≥upka 3W'#13+
'BAR SIDE MARGINS=Boczne marginesy s≥upka'#13+
'AUTO MARK POSITION=Autom. pozycja znacznika'#13+
'JOIN=Z≥πcz'#13+
'DATASET=ZbiÛr danych'#13+
'APPLY=Zastosuj'#13+
'SOURCE=èrÛd≥o'#13+
'MONOCHROME=Monochromatyczny'#13+
'DEFAULT=Domyúlnie'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=årednia'#13+
'WHISKER=Wisker'#13+
'PATTERN COLOR EDITOR=Edytor koloru desenia'#13+
'IMAGE=Obraz'#13+
'BACK DIAGONAL=Ukoúny odwrotny'#13+
'DIAGONAL CROSS=Siatka ukoúna'#13+
'FILL 80%=Wype≥nienie 80%'#13+
'FILL 60%=Wype≥nienie 60%'#13+
'FILL 40%=Wype≥nienie 40%'#13+
'FILL 20%=Wype≥nienie 20%'#13+
'FILL 10%=Wype≥nienie 10%'#13+
'ZIG ZAG=Zygzak'#13+
'VERTICAL SMALL=Pionowy drobny'#13+
'HORIZ. SMALL=Poziomy drobny'#13+
'DIAG. SMALL=Ukoúny drobny'#13+
'BACK DIAG. SMALL=Ukoúny odwr. drobny'#13+
'CROSS SMALL=Drobna siatka'#13+
'DIAG. CROSS SMALL=Drobna siatka ukoúna'#13+
'DAYS=Dni'#13+
'WEEKDAYS=Dni tygodnia'#13+
'TODAY=Dziú'#13+
'SUNDAY=Niedziela'#13+
'TRAILING=Dni poúrednie'#13+
'MONTHS=Miesiπce'#13+
'LINES=Linie'#13+
'SHOW WEEKDAYS=Dni tygodnia'#13+
'UPPERCASE=Duøe litery'#13+
'TRAILING DAYS=Dni poúrednie'#13+
'SHOW TODAY=Pokaø Dzisiaj'#13+
'SHOW MONTHS=Pokaø Miesiπce'#13+
'CANDLE WIDTH=Szerok. úwiecy'#13+
'STICK=Sztyft'#13+
'BAR=S≥upek'#13+
'OPEN CLOSE=Otwar. Zamkn.'#13+
'UP CLOSE=GÛra zamkniÍte'#13+
'DOWN CLOSE=DÛ≥ zamkniÍte'#13+
'SHOW OPEN=Pokaø Otwar.'#13+
'SHOW CLOSE=Pokaø Zamkn.'#13+
'DRAW 3D=3W'#13+
'DARK 3D=3w ciemny'#13+
'EDITING=Redagowanie'#13+
'CHART=Wykres'#13+
'SERIES=Serie'#13+
'DATA=Dane'#13+
'TOOLS=NarzÍdzia'#13+
'EXPORT=Eksport'#13+
'PRINT=Drukowanie'#13+
'GENERAL=OgÛlne'#13+
'TITLES=Tytu≥'#13+
'LEGEND=Legenda'#13+
'PANEL=Panel'#13+
'PAGING=Strona'#13+
'WALLS=åciana'#13+
'3D=3W'#13+
'ADD=Dodaj'#13+
'DELETE=UsuÒ'#13+
'TITLE=Nazwa'#13+
'CLONE=Powiel'#13+
'CHANGE=ZmieÒ'#13+
'HELP=Pomoc'#13+
'CLOSE=Zamknij'#13+
'TEECHART PRINT PREVIEW=TeeChart Podglπd Wydruku'#13+
'PRINTER=Drukarka'#13+
'SETUP=Ustawienia'#13+
'ORIENTATION=Orientacja'#13+
'PORTRAIT=Pionowo'#13+
'LANDSCAPE=Poziomo'#13+
'MARGINS (%)=Marginesy (%)'#13+
'DETAIL=SzcegÛ≥y'#13+
'MORE=WiÍcej'#13+
'NORMAL=Normalnie'#13+
'RESET MARGINS=PrzywrÛÊ margin'#13+
'VIEW MARGINS=Pokaø marginesy'#13+
'PROPORTIONAL=Proporcjonalny'#13+
'CIRCLE=Ko≥o'#13+
'VERTICAL LINE=Linia pionowa'#13+
'HORIZ. LINE=Linia pozioma'#13+
'TRIANGLE=TrÛkat'#13+
'INVERT. TRIANGLE=OdwrÛcony trÛkπt'#13+
'LINE=Linia'#13+
'DIAMOND=Diament'#13+
'CUBE=Szeúcian'#13+
'STAR=Gwiazda'#13+
'TRANSPARENT=Przezroczysty'#13+
'HORIZ. ALIGNMENT=U≥oøenie poziome'#13+
'CENTER=årodek'#13+
'RIGHT=Prawo'#13+
'ROUND RECTANGLE=Zaokrπg. prostokπt'#13+
'ALIGNMENT=U≥oøenie'#13+
'BOTTOM=DÛ≥'#13+
'UNITS=Jednostki'#13+
'PIXELS=Piksele'#13+
'AXIS ORIGIN=Poczπtek osi'#13+
'ROTATION=ObrÛt'#13+
'CIRCLED=Okrπg≥y'#13+
'3 DIMENSIONS=3 Wymiary'#13+
'RADIUS=PromieÒ'#13+
'ANGLE INCREMENT=Inkrement kπta'#13+
'RADIUS INCREMENT=Inkrement promienia'#13+
'CLOSE CIRCLE=ZamkniÍte ko≥o'#13+
'PEN=PiÛrko'#13+
'LABELS=Etykiety'#13+
'ROTATED=ObrÛcone'#13+
'CLOCKWISE=Zegarowo'#13+
'INSIDE=wewnπtrz'#13+
'ROMAN=Rzym.'#13+
'HOURS=Godziny'#13+
'MINUTES=Minuty'#13+
'SECONDS=Sekundy'#13+
'START VALUE=Wart. pocz.'#13+
'END VALUE=Wart. koÒc.'#13+
'TRANSPARENCY=PrzezroczystoúÊ'#13+
'DRAW BEHIND=Rysuj w tle'#13+
'COLOR MODE=Tryb koloru'#13+
'STEPS=Kroki'#13+
'RANGE=Zakres'#13+
'PALETTE=Paleta'#13+
'PALE=Blado'#13+
'STRONG=Mocno'#13+
'GRID SIZE=Rozmiar siatki'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=G≥Íbok.'#13+
'IRREGULAR=Nieregularny'#13+
'GRID=Siatka'#13+
'ALLOW DRAG=PozwÛl ciπgnπÊ'#13+
'VERTICAL POSITION=Pozycja pionowa'#13+
'LEVELS POSITION=Pozycja poziomu'#13+
'LEVELS=Poziomy'#13+
'NUMBER=Liczba'#13+
'LEVEL=Poziom'#13+
'AUTOMATIC=Automat.'#13+
'SNAP=Zatrzask'#13+
'FOLLOW MOUSE=åladem myszy'#13+
'STACK=Stos'#13+
'HEIGHT 3D=WysokoúÊ 3W'#13+
'LINE MODE=Tryb linii'#13+
'OVERLAP=Na≥Ûø'#13+
'STACK 100%=Stos 100%'#13+
'CLICKABLE=Moøna klikaÊ'#13+
'AVAILABLE=DostÍpne'#13+
'SELECTED=Wybrane'#13+
'DATASOURCE=èrÛd≥o danych'#13+
'GROUP BY=Grupuj wg'#13+
'CALC=Licz.'#13+
'OF=z'#13+
'SUM=Sum'#13+
'COUNT=IloúÊ'#13+
'HIGH=Wysoko'#13+
'LOW=Nisko'#13+
'AVG=åred.'#13+
'HOUR=Godz.'#13+
'DAY=DzieÒ'#13+
'WEEK=TydzieÒ'#13+
'WEEKDAY=DzieÒ tygodnia'#13+
'MONTH=Miesiπc'#13+
'QUARTER=Kwarta≥'#13+
'YEAR=Rok'#13+
'HOLE %=OtwÛr %'#13+
'RESET POSITIONS=Reset pozycji'#13+
'MOUSE BUTTON=Przycisk myszy'#13+
'ENABLE DRAWING=PozwÛl rysowaÊ'#13+
'ENABLE SELECT=PozwÛl wybieraÊ'#13+
'ENHANCED=Ulepszony'#13+
'ERROR WIDTH=Szerok. b≥Ídu'#13+
'WIDTH UNITS=Jedn. szerok.'#13+
'PERCENT=Procent'#13+
'LEFT AND RIGHT=Lewo i Prawo'#13+
'TOP AND BOTTOM=GÛra i DÛ≥'#13+
'BORDER EDITOR=Edytor krawÍdzi'#13+
'DASH=Kreska'#13+
'DOT=Kropka'#13+
'DASH DOT=Kreska Kropka'#13+
'DASH DOT DOT=Kreska Kropka Kropka'#13+
'CALCULATE EVERY=Oblicz kaødy'#13+
'ALL POINTS=Wszystkie punkt.'#13+
'NUMBER OF POINTS=Liczba punktÛw'#13+
'RANGE OF VALUES=Zakres wartoúci'#13+
'FIRST=Pierwszy'#13+
'LAST=Ostatni'#13+
'TEEPREVIEW EDITOR=Edytor Tee-podglπdu'#13+
'ALLOW MOVE=PozwÛl przesuwaÊ'#13+
'ALLOW RESIZE=PozwÛl zm. rozmiar'#13+
'DRAG IMAGE=Ciπgnij obraz'#13+
'AS BITMAP=Jako bitmapa'#13+
'SHOW IMAGE=Pokaø obraz'#13+
'MARGINS=Marginesy'#13+
'SIZE=Rozm.'#13+
'3D %=3W %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Wzniesienie'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Przes.poziome'#13+
'VERT. OFFSET=Przes.pionowe'#13+
'PERSPECTIVE=Perspektywa'#13+
'ANGLE=Kπt'#13+
'ORTHOGONAL=Ortogonalny'#13+
'ZOOM TEXT=Zoom Tekst'#13+
'SCALES=Skale'#13+
'TICKS=Podzia≥ka'#13+
'MINOR=Drobna'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Poøπdany przyrost'#13+
'(INCREMENT)=(przyrost)'#13+
'LOG BASE=Podstawa log'#13+
'LOGARITHMIC=Logarytmiczny'#13+
'MIN. SEPARATION %=Min. odstÍp %'#13+
'MULTI-LINE=Multi-linia'#13+
'LABEL ON AXIS=Etykieta na osi'#13+
'ROUND FIRST=Zaokrπglij pierwszπ'#13+
'MARK=Znak.'#13+
'LABELS FORMAT=Format etykiet'#13+
'EXPONENTIAL=Wyk≥adniczy'#13+
'DEFAULT ALIGNMENT=Domyúlne po≥oøenie'#13+
'LEN=D≥ug.'#13+
'INNER=Wewnπtrz'#13+
'AT LABELS ONLY=Tylko przy etykiet.'#13+
'CENTERED=Centrowany'#13+
'POSITION %=Pozycja %'#13+
'START %=Poczπtek %'#13+
'END %=Koniec %'#13+
'OTHER SIDE=Inna strona'#13+
'AXES=Osie'#13+
'BEHIND=Z ty≥u'#13+
'CLIP POINTS=all'#13+
'PRINT PREVIEW=Podglπd wydruku'#13+
'MINIMUM PIXELS=Minimum pikseli'#13+
'ALLOW=PozwÛl'#13+
'ANIMATED=Animowany'#13+
'ALLOW SCROLL=PozwÛl przewijaÊ'#13+
'TEEOPENGL EDITOR=TeeOpenGL Edytor'#13+
'AMBIENT LIGHT=Oúwietlenie'#13+
'SHININESS=Po≥ysk'#13+
'FONT 3D DEPTH=G≥Íb. czcionki 3W'#13+
'ACTIVE=Aktywny'#13+
'FONT OUTLINES=Kontur czcionki'#13+
'SMOOTH SHADING=P≥ynne cieniowanie'#13+
'LIGHT=åwiat≥o'#13+
'Y=Y'#13+
'INTENSITY=Intensywn.'#13+
'BEVEL=Skos'#13+
'FRAME=Ramka'#13+
'ROUND FRAME=Zaokr. ramka'#13+
'LOWERED=Obniøony'#13+
'RAISED=Podniesiony'#13+
'SYMBOLS=Symbole'#13+
'TEXT STYLE=Styl tekstu'#13+
'LEGEND STYLE=Styl legendy'#13+
'VERT. SPACING=OdstÍp pion.'#13+
'SERIES NAMES=Nazwy serii'#13+
'SERIES VALUES=Wartoúci serii'#13+
'LAST VALUES=Ostatnie wartoúci'#13+
'PLAIN=Plain'#13+
'LEFT VALUE=Lewo WartoúÊ'#13+
'RIGHT VALUE=Prawo WartoúÊ'#13+
'LEFT PERCENT=Lewo Procent'#13+
'RIGHT PERCENT=Prawo Procent'#13+
'X VALUE=X WartoúÊ'#13+
'X AND VALUE=X i WartoúÊ'#13+
'X AND PERCENT=X i Procent'#13+
'CHECK BOXES=Pola wyboru'#13+
'DIVIDING LINES=Linie podzia≥u'#13+
'FONT SERIES COLOR=Kolor czcionki serii'#13+
'POSITION OFFSET %=Przes. pozycji %'#13+
'MARGIN=Margines'#13+
'RESIZE CHART=Oryginalny rozmiar'#13+
'CONTINUOUS=Ciπg≥y'#13+
'POINTS PER PAGE=Punkty na stronÍ'#13+
'SCALE LAST PAGE=Skaluj ostatniπ stronÍ'#13+
'CURRENT PAGE LEGEND=Legenda bieøacej strony'#13+
'PANEL EDITOR=Edytor panelu'#13+
'BACKGROUND=T≥o'#13+
'BORDERS=KrawÍdzie'#13+
'BACK IMAGE=Obraz w tle'#13+
'STRETCH=Rozciπgnij'#13+
'TILE=Wype≥nij'#13+
'BEVEL INNER=Skos wewn.'#13+
'BEVEL OUTER=Skos zewn.'#13+
'MARKS=Znaczniki'#13+
'DATA SOURCE=èrÛd≥o danych'#13+
'SORT=Sortuj'#13+
'CURSOR=Kursor'#13+
'SHOW IN LEGEND=Pokaø w legendzie'#13+
'FORMATS=Formaty'#13+
'VALUES=Wartoúci'#13+
'PERCENTS=Procenty'#13+
'HORIZONTAL AXIS=Oú pozioma'#13+
'DATETIME=Data/Czas'#13+
'VERTICAL AXIS=Oú pionowa'#13+
'ASCENDING=Rosnπco'#13+
'DESCENDING=Malejπco'#13+
'DRAW EVERY=Rysuj wszystko'#13+
'CLIPPED=ObciÍte'#13+
'ARROWS=Strza≥ki'#13+
'MULTI LINE=Multi-linia'#13+
'ALL SERIES VISIBLE=Wszystkie serie widoczne'#13+
'LABEL=Etykieta'#13+
'LABEL AND PERCENT=Etykieta i procent'#13+
'LABEL AND VALUE=Etykieta i wartoúÊ'#13+
'PERCENT TOTAL=Procent ca≥oúci'#13+
'LABEL AND PERCENT TOTAL=Etykieta i procent ca≥oúci'#13+
'X AND Y VALUES=X i Y WartoúÊ'#13+
'MANUAL=RÍcznie'#13+
'RANDOM=Losowo'#13+
'FUNCTION=Funkcja'#13+
'NEW=Nowy'#13+
'EDIT=Redaguj'#13+
'PERSISTENT=Trwa≥y'#13+
'ADJUST FRAME=Ustal ramkÍ'#13+
'SUBTITLE=Podtytu≥'#13+
'SUBFOOT=Stopka 2'#13+
'FOOT=Stopka'#13+
'VISIBLE WALLS=åciany widoczne'#13+
'BACK=Z ty≥u'#13+
'DIF. LIMIT=Dif. Limit'#13+
'ABOVE=Ponad'#13+
'WITHIN=Wewnπtrz'#13+
'BELOW=Poniøej'#13+
'CONNECTING LINES=Linie ≥πczπce'#13+
'BROWSE=Szukaj w'#13+
'TILED=Wype≥niony'#13+
'INFLATE MARGINS=ZwiÍksz marginesy'#13+
'SQUARE=Kwadrat'#13+
'DOWN TRIANGLE=OdwrÛcony trÛjkπt'#13+
'SMALL DOT=Ma≥e kropki'#13+
'GLOBAL=Globalny'#13+
'SHAPES=Kszta≥ty'#13+
'BRUSH=PÍdzel'#13+
'DELAY=Zw≥oka'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Akcja myszy'#13+
'MOVE=Poruszaj'#13+
'CLICK=Klik'#13+
'DRAW LINE=Rysuj linie'#13+
'EXPLODE BIGGEST=WysuÒ najwiÍkszy'#13+
'TOTAL ANGLE=Kπt sumaryczny'#13+
'GROUP SLICES=Grupuj kawa≥ki'#13+
'BELOW %=Poniøej %'#13+
'BELOW VALUE=Poniøej wartoúci'#13+
'OTHER=Inne'#13+
'PATTERNS=Desenie'#13+
'SIZE %=Rozmiar %'#13+
'SERIES DATASOURCE TEXT EDITOR=Edytor tekstu zrÛde≥ danych serii'#13+
'FIELDS=Pola'#13+
'NUMBER OF HEADER LINES=IloúÊ linii nag≥Ûwka'#13+
'SEPARATOR=Separator'#13+
'COMMA=Przecinek'#13+
'SPACE=Spacja'#13+
'TAB=Tabulator'#13+
'FILE=Plik'#13+
'WEB URL=Web URL'#13+
'LOAD=Za≥aduj'#13+
'C LABELS=C Etykiety'#13+
'R LABELS=R Etykiety'#13+
'C PEN=C PiÛrko'#13+
'R PEN=R PiÛrko'#13+
'STACK GROUP=Grupowanie'#13+
'MULTIPLE BAR=Wiele s≥upkÛw'#13+
'SIDE=Sπsiadujπco'#13+
'SIDE ALL=Sπsiad. wszystkie'#13+
'DRAWING MODE=Tryb rysowania'#13+
'WIREFRAME=Siatka druc.'#13+
'DOTFRAME=Siatka punkt.'#13+
'SMOOTH PALETTE=P≥ynna paleta'#13+
'SIDE BRUSH=PÍdzel boczny'#13+
'ABOUT TEECHART PRO V7.0=Info TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Wczystkie Prawa Zastrzeøone.'#13+
'VISIT OUR WEB SITE !=Odwiedü naszπ witrynÍ !'#13+
'TEECHART WIZARD=TeeChart Kreator'#13+
'SELECT A CHART STYLE=Wybierz styl wykresu'#13+
'DATABASE CHART=Wykres bazodanowy'#13+
'NON DATABASE CHART=Wykres nie bazodanowy'#13+
'SELECT A DATABASE TABLE=Wybierz tabelÍ bazy danych'#13+
'ALIAS=Alias'#13+
'TABLE=Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Wybierz pola do wykresu'#13+
'SELECT A TEXT LABELS FIELD=Wybierz pole z tekstem etykiet'#13+
'CHOOSE THE DESIRED CHART TYPE=Wybierz typ wykresu'#13+
'2D=2W'#13+
'CHART PREVIEW=Podglπd wykresu'#13+
'SHOW LEGEND=Pokaø legendÍ'#13+
'SHOW MARKS=Pokaø znaczniki'#13+
'< BACK=< Wstecz'#13+
'EXPORT CHART=Eksportuj wykres'#13+
'PICTURE=Obraz'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Trzymaj proporcje'#13+
'INCLUDE SERIES DATA=Do≥πcz dane serii'#13+
'FILE SIZE=Rozmiar pliku'#13+
'DELIMITER=Ogranicznik'#13+
'XML=XML'#13+
'HTML TABLE=Tabela HTML'#13+
'EXCEL=Excel'#13+
'COLON=Dwukropek'#13+
'INCLUDE=W≥πcz'#13+
'POINT LABELS=Etykiety punktu'#13+
'POINT INDEX=Indeks punktu'#13+
'HEADER=Nag≥Ûwek'#13+
'COPY=Kopiuj'#13+
'SAVE=Zapisz'#13+
'SEND=Wyúlij'#13+
'FUNCTIONS=Funkcje'#13+
'ADX=ADX'#13+
'AVERAGE=årednia'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Podziel'#13+
'EXP. AVERAGE=årednia.Exp.'#13+
'EXP.MOV.AVRG.=årednia.Exp.Ruch.'#13+
'MACD=MACD'#13+
'MOMENTUM=PÍd'#13+
'MOMENTUM DIV=PÍd Div'#13+
'MOVING AVRG.=åredn.ruchoma'#13+
'MULTIPLY=PomnÛø'#13+
'R.S.I.=R.S.I'#13+
'ROOT MEAN SQ.=åred.pierw.kw.'#13+
'STD.DEVIATION=Odch.Stand.'#13+
'STOCHASTIC=Stochastyczny'#13+
'SUBTRACT=Odejmij'#13+
'SOURCE SERIES=èrÛd≥o serii'#13+
'TEECHART GALLERY=Galleria TeeChart'#13+
'DITHER=Rozedrgaj'#13+
'REDUCTION=Redukcja'#13+
'COMPRESSION=Kompresja'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Najbliøszy'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Szary'#13+
'GRAY SCALE=Skala szaroúci'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Kwantyzuj'#13+
'QUANTIZE 256=Kwantyzuj 256'#13+
'% QUALITY=% JakoúÊ'#13+
'PERFORMANCE=Prezentacja'#13+
'QUALITY=JakoúÊ'#13+
'SPEED=PrÍdkoúÊ'#13+
'COMPRESSION LEVEL=Poziom kompresji'#13+
'CHART TOOLS GALLERY=Galeria narzÍdzi wykresu'#13+
'ANNOTATION=Adnotacja'#13+
'AXIS ARROWS=Strza≥ki osi'#13+
'COLOR BAND=Koloruj pasmo'#13+
'COLOR LINE=koloruj linie'#13+
'DRAG MARKS=Ciπgnij znaczniki'#13+
'MARK TIPS=Tipsy znacznika'#13+
'NEAREST POINT=Najbliøszy punkt'#13+
'ROTATE=ObrÛÊ'#13+
'YES=Tak'#13+

{$IFDEF TEEOCX}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- Wybierz ørod≥o danych ADO'#13+
'CONNECTION=Po≥πczenie'#13+
'DATASET=ZbiÛr danych'#13+
'TABLE=Tabela'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=Tabele systemowe'#13+
'LOGIN PROMPT=Login'#13+
'SELECT=Wybierz'#13+
'TEECHART IMPORT=TeeChart import'#13+
'IMPORT CHART FROM=Importuj wykres z'#13+
'IMPORT NOW=Importuj teraz'#13+
'EDIT CHART=Redaguj wykres'#13+
{$ENDIF}

// 6.0
'BEVEL SIZE=Rozmiar skosu'#13+
'DELETE ROW=UsuÒ wiersz'#13+
'VOLUME SERIES=Pasmowy'#13+
'SINGLE=PojedyÒczy'#13+
'REMOVE CUSTOM COLORS=UsuÒ dostosowane kolory'#13+
'USE PALETTE MINIMUM=Uøyj palety minimum'#13+
'AXIS MAXIMUM=Maksimum osi'#13+
'AXIS CENTER=årodek Osi'#13+
'AXIS MINIMUM=Minimum osi'#13+
'DAILY (NONE)=Dziennie (brak)'#13+
'WEEKLY=Tygodniowo'#13+
'MONTHLY=MiesiÍcznie'#13+
'BI-MONTHLY=DwumiesiÍcznie'#13+
'QUARTERLY=Kwartalnie'#13+
'YEARLY=Rocznie'#13+
'DATETIME PERIOD=Okres daty-czasu'#13+
'CASE SENSITIVE=Czu≥y na wielkoúÊ liter'#13+
'DRAG STYLE=Styl ciπgniÍcia'#13+
'SQUARED=Kwadratowy'#13+
'GRID 3D SERIES=Siatka 3W'#13+
'DARK BORDER=Ciemny brzeg'#13+
'PIE SERIES=Wycinek ko≥a'#13+
'FOCUS=Ognisko'#13+
'EXPLODE=RozsuÒ'#13+
'FACTOR=Czynnik'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Wykres z szablonu'#13+
'OPEN TEECHART TEMPLATE FILE FROM=OtwÛrz plik szablonu z'#13+
'BINARY=Binarny'#13+
'VOLUME OSCILLATOR=Oscylator wolumenu'#13+
'PIE SLICES=Wycinki ko≥a'#13+
'ARROW WIDTH=SzerokoúÊ strza≥ki'#13+
'ARROW HEIGHT=WysokoúÊ strza≥ki'#13+
'DEFAULT COLOR=Domyúlny kolor'
;

  end;
end;

Procedure TeeSetPolish;
begin
  TeeCreatePolish;
  TeeLanguage:=TeePolishLanguage;
  TeePolishConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeePolishLanguage);
end.
