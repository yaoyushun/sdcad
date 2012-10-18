unit TeeCzech;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeCzechLanguage:TStringList=nil;

Procedure TeeSetCzech;
Procedure TeeCreateCzech;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeCzechConstants;
begin
    TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
    TeeMsg_LegendFirstValue   :='První hodnota legendy musí být > 0';
    TeeMsg_LegendColorWidth   :='Šíøka barvy legendy musí být > 0%';
    TeeMsg_SeriesSetDataSource:='Není ParentChart pro ovìøení DataSource';
    TeeMsg_SeriesInvDataSource:='Není platný DataSource: %s';
    TeeMsg_FillSample         :='FillSampleValues NumValues musí být > 0';
    TeeMsg_AxisLogDateTime    :='Osa datum/èas nemùže být logaritmická';
    TeeMsg_AxisLogNotPositive :='Hodnoty minimum a maximum logaritmické osy by mìly být >= 0';
    TeeMsg_AxisLabelSep       :='Procentní odstup popisù musí být vìtší než 0';
    TeeMsg_AxisIncrementNeg   :='Pøírùstek osy musí být >= 0';
    TeeMsg_AxisMinMax         :='Minimální hodnota osy musí být <= maximální';
    TeeMsg_AxisMaxMin         :='Maximální hodnota osy musí být >= minimální';
    TeeMsg_AxisLogBase        :='Základ logaritmické osy by mìl být >= 2';
    TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage musí být >= 0';
    TeeMsg_3dPercent          :='Procenta efektu 3D musí být mezi %d a %d';
    TeeMsg_CircularSeries     :='Závislost kruhové série není možná';
    TeeMsg_WarningHiColor     :='Pro lepší vzhled je požadováno 16 tisíc nebo více barev';

    TeeMsg_DefaultPercentOf   :='%s z %s';
    TeeMsg_DefaultPercentOf2  :='%s'+#13+'z %s';
    TeeMsg_DefPercentFormat   :='##0.## %';
    TeeMsg_DefValueFormat     :='#,##0.###';
    TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
    TeeMsg_AxisTitle          :='Název osy';
    TeeMsg_AxisLabels         :='Popisy osy';
    TeeMsg_RefreshInterval    :='Interval obnovení musí být mezi 0 a 60';
    TeeMsg_SeriesParentNoSelf :='Series.ParentChart není sám!';
    TeeMsg_GalleryLine        :='Èára';
    TeeMsg_GalleryPoint       :='Bod';
    TeeMsg_GalleryArea        :='Prostor';
    TeeMsg_GalleryBar         :='Sloupec';
    TeeMsg_GalleryHorizBar    :='Horiz. sloupec';
    TeeMsg_Stack              :='Vrstva';
    TeeMsg_GalleryPie         :='Koláè';
    TeeMsg_GalleryCircled     :='Kruhový';
    TeeMsg_GalleryFastLine    :='Rychlá èára';
    TeeMsg_GalleryHorizLine   :='Horiz. èára';

    TeeMsg_PieSample1         :='Auta';
    TeeMsg_PieSample2         :='Telefony';
    TeeMsg_PieSample3         :='Tabulky';
    TeeMsg_PieSample4         :='Monitory';
    TeeMsg_PieSample5         :='Lampy';
    TeeMsg_PieSample6         :='Klávesnice';
    TeeMsg_PieSample7         :='Kola';
    TeeMsg_PieSample8         :='Židle';

    TeeMsg_GalleryLogoFont    :='Courier New';
    TeeMsg_Editing            :='Editace %s';

    TeeMsg_GalleryStandard    :='Standardní';
    TeeMsg_GalleryExtended    :='Rozšíøené';
    TeeMsg_GalleryFunctions   :='Funkce';

    TeeMsg_EditChart          :='&Zmìnit graf...';
    TeeMsg_PrintPreview       :='&Náhled tisku...';
    TeeMsg_ExportChart        :='E&xportovat grafu...';
    TeeMsg_CustomAxes         :='Upravit osy...';

    TeeMsg_InvalidEditorClass :='%s: Neplatná tøída editoru: %s';
    TeeMsg_MissingEditorClass :='%s: nemá dialogové okno editoru';

    TeeMsg_GalleryArrow       :='Šipka';

    TeeMsg_ExpFinish          :='&Dokonèit';
    TeeMsg_ExpNext            :='&Další >';

    TeeMsg_GalleryGantt       :='Schody';

    TeeMsg_GanttSample1       :='Návrh';
    TeeMsg_GanttSample2       :='Modelování';
    TeeMsg_GanttSample3       :='Vývoj';
    TeeMsg_GanttSample4       :='Prodej';
    TeeMsg_GanttSample5       :='Marketing';
    TeeMsg_GanttSample6       :='Testování';
    TeeMsg_GanttSample7       :='Výroba';
    TeeMsg_GanttSample8       :='Ladìní';
    TeeMsg_GanttSample9       :='Nová verze';
    TeeMsg_GanttSample10      :='Bankovnictví';

    TeeMsg_ChangeSeriesTitle  :='Zmìnit nadpis série';
    TeeMsg_NewSeriesTitle     :='Nadpis nové série:';
    TeeMsg_DateTime           :='Datum a èas';
    TeeMsg_TopAxis            :='Horní osa';
    TeeMsg_BottomAxis         :='Spodní osa';
    TeeMsg_LeftAxis           :='Levá osa';
    TeeMsg_RightAxis          :='Pravá osa';

    TeeMsg_SureToDelete       :='Vymazat %s ?';
    TeeMsg_DateTimeFormat     :='For&mát data a èasu:';
    TeeMsg_Default            :='Výchozí';
    TeeMsg_ValuesFormat       :='For&mát hodnot:';
    TeeMsg_Maximum            :='Maximum';
    TeeMsg_Minimum            :='Minimum';
    TeeMsg_DesiredIncrement   :='Požadovaný pøírùstek %s';

    TeeMsg_IncorrectMaxMinValue:='Neplatná hodnota. Dùvod: %s';
    TeeMsg_EnterDateTime      :='Vložte [poèet dní] '+TeeMsg_HHNNSS;

    TeeMsg_SureToApply        :='Provést zmìny?';
    TeeMsg_SelectedSeries     :='(vybraná série)';
    TeeMsg_RefreshData        :='&Obnovit data';

    TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
    TeeMsg_DefaultEditorSize  :='414';
    TeeMsg_FunctionAdd        :='Souèet';
    TeeMsg_FunctionSubtract   :='Rozdíl';
    TeeMsg_FunctionMultiply   :='Násobení';
    TeeMsg_FunctionDivide     :='Dìlení';
    TeeMsg_FunctionHigh       :='Nejvyšší';
    TeeMsg_FunctionLow        :='Nejnižší';
    TeeMsg_FunctionAverage    :='Prùmìr';

    TeeMsg_GalleryShape       :='Tvar';
    TeeMsg_GalleryBubble      :='Bublina';
    TeeMsg_FunctionNone       :='Kopie';

    TeeMsg_None               :='(žádný)';

    TeeMsg_PrivateDeclarations:='{ Privátní deklarace }';
    TeeMsg_PublicDeclarations :='{ Veøejné deklarace }';
    TeeMsg_DefaultFontName    :={$IFDEF CLX}'Helvetica'{$ELSE}'Arial'{$ENDIF};

    TeeMsg_CheckPointerSize   :='Velikost ukazatele musí být vìtší než nula';
    TeeMsg_About              :='&O TeeChart...';

    tcAdditional              :='Další';
    tcDControls               :='Datové prvky';
    tcQReport                 :='QReport';

    TeeMsg_DataSet            :='Dataset';
    TeeMsg_AskDataSet         :='&Dataset:';

    TeeMsg_SingleRecord       :='Jeden záznam';
    TeeMsg_AskDataSource      :='&Datový zdroj:';

    TeeMsg_Summary            :='Souhrn';

    TeeMsg_FunctionPeriod     :='Perioda funkce by mìla být >= 0';

    TeeMsg_WizardTab          :='Obchodní';
    TeeMsg_TeeChartWizard     :='Prùvodce TeeChart';

    TeeMsg_ClearImage         :='V&ymazat';
    TeeMsg_BrowseImage        :='P&rocházet...';

    TeeMsg_WizardSureToClose  :='Jste si jistý, že chcete zavøít prùvodce TeeChart?';
    TeeMsg_FieldNotFound      :='Pole %s neexistuje';

    TeeMsg_DepthAxis          :='Hloubka osy';
    TeeMsg_PieOther           :='Ostatní';
    TeeMsg_ShapeGallery1      :='abc';
    TeeMsg_ShapeGallery2      :='123';
    TeeMsg_ValuesX            :='X';
    TeeMsg_ValuesY            :='Y';
    TeeMsg_ValuesPie          :='Koláè';
    TeeMsg_ValuesBar          :='Sloupec';
    TeeMsg_ValuesAngle        :='Úhel';
    TeeMsg_ValuesGanttStart   :='Poèátek';
    TeeMsg_ValuesGanttEnd     :='Konec';
    TeeMsg_ValuesGanttNextTask:='Další úloha';
    TeeMsg_ValuesBubbleRadius :='Polomìr';
    TeeMsg_ValuesArrowEndX    :='KonecX';
    TeeMsg_ValuesArrowEndY    :='KonecY';
    TeeMsg_Legend             :='Legenda';
    TeeMsg_Title              :='Nadpis';
    TeeMsg_Foot               :='Pata';
    TeeMsg_Period		          :='Perioda';
    TeeMsg_PeriodRange        :='Rozsah periody';
    TeeMsg_CalcPeriod         :='Poèítat %s každých:';
    TeeMsg_SmallDotsPen       :='Malé teèky';

    TeeMsg_InvalidTeeFile     :='Neplatný graf v souboru *.'+TeeMsg_TeeExtension;
    TeeMsg_WrongTeeFileFormat :='Špatný formát souboru *.'+TeeMsg_TeeExtension;
    TeeMsg_EmptyTeeFile       :='Prázdný soubor *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
    TeeMsg_ChartAxesCategoryName   := 'Osy grafu';
    TeeMsg_ChartAxesCategoryDesc   := 'Vlastnosti a události os grafu';
    TeeMsg_ChartWallsCategoryName  := 'Stìny grafu';
    TeeMsg_ChartWallsCategoryDesc  := 'Vlastnosti a události stìn grafu';
    TeeMsg_ChartTitlesCategoryName := 'Nadpisy grafu';
    TeeMsg_ChartTitlesCategoryDesc := 'Vlastnosti a události nadpisù grafu';
    TeeMsg_Chart3DCategoryName     := 'Graf 3D';
    TeeMsg_Chart3DCategoryDesc     := 'Vlastnosti a události grafu 3D';
  {$ENDIF}

    TeeMsg_CustomAxesEditor       :='Uživatelský ';
    TeeMsg_Series                 :='Skupiny';
    TeeMsg_SeriesList             :='Skupiny...';

    TeeMsg_PageOfPages            :='Strana %d z %d';
    TeeMsg_FileSize               :='%d bajtù';

    TeeMsg_First  :='První';
    TeeMsg_Prior  :='Pøedchozí';
    TeeMsg_Next   :='Následující';
    TeeMsg_Last   :='Poslední';
    TeeMsg_Insert :='Vložit';
    TeeMsg_Delete :='Vymazat';
    TeeMsg_Edit   :='Zmìnit';
    TeeMsg_Post   :='Uložit';
    TeeMsg_Cancel :='Storno';

    TeeMsg_All    :='(vše)';
    TeeMsg_Index  :='Index';
    TeeMsg_Text   :='Text';

    TeeMsg_AsBMP        :='jako &bitmapa';
    TeeMsg_BMPFilter    :='Bitmapy (*.bmp)|*.bmp';
    TeeMsg_AsEMF        :='jako &metasoubor';
    TeeMsg_EMFFilter    :='Rozšíøené metasoubory (*.emf)|*.emf|Metasoubory (*.wmf)|*.wmf';
    TeeMsg_ExportPanelNotSet := 'Vlastnost panelu nemá nastaven formát exportu';

    TeeMsg_Normal    :='Normální';
    TeeMsg_NoBorder  :='Bez okrajù';
    TeeMsg_Dotted    :='Teèkovaný';
    TeeMsg_Colors    :='Barvy';
    TeeMsg_Filled    :='Vyplnìný';
    TeeMsg_Marks     :='Znaèky';
    TeeMsg_Stairs    :='Schody';
    TeeMsg_Points    :='Body';
    TeeMsg_Height    :='Výška';
    TeeMsg_Hollow    :='Dutina';
    TeeMsg_Point2D   :='Bod 2D';
    TeeMsg_Triangle  :='Trojúhelník';
    TeeMsg_Star      :='Hvìzda';
    TeeMsg_Circle    :='Kruh';
    TeeMsg_DownTri   :='Spodní trojúhelník';
    TeeMsg_Cross     :='Køíž';
    TeeMsg_Diamond   :='Diamant';
    TeeMsg_NoLines   :='Bez èar';
  TeeMsg_Stack100  :='Stack 100%';
    TeeMsg_Pyramid   :='Pyramida';
    TeeMsg_Ellipse   :='Elipsa';
    TeeMsg_InvPyramid:='Inv. pyramida';
    TeeMsg_Sides     :='Strany';
    TeeMsg_SideAll   :='Všechny strany';
    TeeMsg_Patterns  :='Výplnì';
    TeeMsg_Exploded  :='Vysunutý';
    TeeMsg_Shadow    :='Stín';
    TeeMsg_SemiPie   :='Polovièní koláè';
    TeeMsg_Rectangle :='Obdélník';
    TeeMsg_VertLine  :='Vert. èára';
    TeeMsg_HorizLine :='Horiz. 48ra';
    TeeMsg_Line      :='Èára';
    TeeMsg_Cube      :='Krychle';
    TeeMsg_DiagCross :='Diag. køíž';

    TeeMsg_CanNotFindTempPath    :='Nemohu najít adresáø doèasných souborù';
    TeeMsg_CanNotCreateTempChart :='Nemohu vytvoøit doèasný soubor';
    TeeMsg_CanNotEmailChart      :='Nemohu odeslat e-mailem TeeChart. Chyba MAPI: %d';

    TeeMsg_SeriesDelete :='Vymazání série: ValueIndex %d mimo rozsah (0 až %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

    TeeMsg_AsJPEG        :='jako &JPEG';
    TeeMsg_JPEGFilter    :='Soubory JPEG (*.jpg)|*.jpg';
    TeeMsg_AsGIF         :='jako &GIF';
    TeeMsg_GIFFilter     :='Soubory GIF (*.gif)|*.gif';
    TeeMsg_AsPNG         :='jako &PNG';
    TeeMsg_PNGFilter     :='Soubory PNG (*.png)|*.png';
    TeeMsg_AsPCX         :='jako PC&X';
    TeeMsg_PCXFilter     :='Soubory PCX (*.pcx)|*.pcx';
    TeeMsg_AsVML         :='jako &VML (HTM)';
    TeeMsg_VMLFilter     :='Soubory VML (*.htm)|*.htm';

  { 5.02 }
    TeeMsg_AskLanguage  :='&Jazyk...';

  { TeeProCo }
    TeeMsg_GalleryPolar       :='Polární';
    TeeMsg_GalleryCandle      :='Svíce';
    TeeMsg_GalleryVolume      :='Intenzita';
    TeeMsg_GallerySurface     :='Povrch';
    TeeMsg_GalleryContour     :='Obrys';
    TeeMsg_GalleryBezier      :='Bézier';
    TeeMsg_GalleryPoint3D     :='Bod 3D';
    TeeMsg_GalleryRadar       :='Radar';
    TeeMsg_GalleryDonut       :='Kobliha';
    TeeMsg_GalleryCursor      :='Kurzor';
    TeeMsg_GalleryBar3D       :='Sloupec 3D';
    TeeMsg_GalleryBigCandle   :='Velká svíce';
    TeeMsg_GalleryLinePoint   :='Èára a bod';
    TeeMsg_GalleryHistogram   :='Histogram';
    TeeMsg_GalleryWaterFall   :='Pokles vody';
    TeeMsg_GalleryWindRose    :='Vìtrná rùžice';
    TeeMsg_GalleryClock       :='Hodiny';
    TeeMsg_GalleryColorGrid   :='Barevná møíž';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
    TeeMsg_GalleryBarJoin     :='Spojený sloupec';
    TeeMsg_GallerySmith       :='Smithùv diagram';
    TeeMsg_GalleryPyramid     :='Pyramida';
    TeeMsg_GalleryMap         :='Mapa';

    TeeMsg_PolyDegreeRange    :='Stupeò polynomie musí být mezi 1 a 20';
    TeeMsg_AnswerVectorIndex   :='Index odpovídajícího vektoru musí být mezi 1 a %d';
    TeeMsg_FittingError        :='Nelze provést úpravu';
    TeeMsg_PeriodRange         :='Perioda musí být >= 0';
    TeeMsg_ExpAverageWeight    :='Hmotnost ExpAverage musí být mezi 0 a 1';
    TeeMsg_GalleryErrorBar     :='Sloupec Chyba';
    TeeMsg_GalleryError        :='Chyba';
    TeeMsg_GalleryHighLow      :='Horní-spodní';
    TeeMsg_FunctionMomentum    :='Moment';
    TeeMsg_FunctionMomentumDiv :='Moment dìlení';
    TeeMsg_FunctionExpAverage  :='Exp. prùmìr';
    TeeMsg_FunctionMovingAverage:='Pohyblivý prùmìr.';
    TeeMsg_FunctionExpMovAve   :='Exp. pohyblivý prùmìr.';
    TeeMsg_FunctionRSI         :='R.S.I.';
    TeeMsg_FunctionCurveFitting:='Úprava køivky';
    TeeMsg_FunctionTrend       :='Smìr';
    TeeMsg_FunctionExpTrend    :='Exp. smìr';
    TeeMsg_FunctionLogTrend    :='Log. smìr';
    TeeMsg_FunctionCumulative  :='Kumulativní';
    TeeMsg_FunctionStdDeviation:='Standardní odchylka';
    TeeMsg_FunctionBollinger   :='Bollinger';
    TeeMsg_FunctionRMS         :='Koøen ètverec';
    TeeMsg_FunctionMACD        :='MACD';
    TeeMsg_FunctionStochastic  :='Náhodný';
    TeeMsg_FunctionADX         :='ADX';

    TeeMsg_FunctionCount       :='Poèet';
    TeeMsg_LoadChart           :='Otevøít TeeChart...';
    TeeMsg_SaveChart           :='Uložit TeeChart...';
    TeeMsg_TeeFiles            :='Soubory TeeChart Pro';

    TeeMsg_GallerySamples      :='Jiné';
    TeeMsg_GalleryStats        :='Statistické';

    TeeMsg_CannotFindEditor    :='Nemohu najít formuláø edotoru série: %s';


    TeeMsg_CannotLoadChartFromURL:='Kód chyby: %d stahování grafu z URL: %s';
    TeeMsg_CannotLoadSeriesDataFromURL:='Kód chyby: %d stahování dat série z URL: %s';

    TeeMsg_Test                :='Test...';

    TeeMsg_ValuesDate          :='Datum';
    TeeMsg_ValuesOpen          :='Otevøít';
    TeeMsg_ValuesHigh          :='Vysoký';
    TeeMsg_ValuesLow           :='Nízký';
    TeeMsg_ValuesClose         :='Zavøít';
    TeeMsg_ValuesOffset        :='Posun';
  TeeMsg_ValuesStdError      :='StdError';

    TeeMsg_Grid3D              :='Møíž 3D';

    TeeMsg_LowBezierPoints     :='Poèet Béziérových bodù by mìl být > 1';

  { TeeCommander component... }

    TeeCommanMsg_Normal   :='Normální';
    TeeCommanMsg_Edit     :='Zmìnit';
    TeeCommanMsg_Print    :='Tisknout';
    TeeCommanMsg_Copy     :='Kopírovat';
    TeeCommanMsg_Save     :='Uložit';
    TeeCommanMsg_3D       :='3D';

    TeeCommanMsg_Rotating :='Rotace: %d° Elevace: %d°';
    TeeCommanMsg_Rotate   :='Rotace';

    TeeCommanMsg_Moving   :='Horiz. posun: %d Vert. posun: %d';
    TeeCommanMsg_Move     :='Pøesunout';

    TeeCommanMsg_Zooming  :='Zvìtšení: %d %%';
    TeeCommanMsg_Zoom     :='Zvìtšení';

    TeeCommanMsg_Depthing :='3D: %d %%';
    TeeCommanMsg_Depth    :='Hloubka';

    TeeCommanMsg_Chart    :='Graf';
    TeeCommanMsg_Panel    :='Panel';

    TeeCommanMsg_RotateLabel:='Táhnìte %s pro otoèení';
    TeeCommanMsg_MoveLabel  :='Táhnìte %s pro pøesun';
    TeeCommanMsg_ZoomLabel  :='Táhnìte %s pro zvìtšení';
    TeeCommanMsg_DepthLabel :='Táhnìte %s pro zmìnu velikosti 3D';

    TeeCommanMsg_NormalLabel:='Táhnìte levým tlaèítkem pro zvìtšwní, pravým tlaèítkem pro posun';
    TeeCommanMsg_NormalPieLabel:='Díl koláèe mùžete táhnutím vysunout';

    TeeCommanMsg_PieExploding :='Díl: %d Vysunuto: %d %%';

    TeeMsg_TriSurfaceLess        :='Poèet bodù musí být >= 4';
    TeeMsg_TriSurfaceAllColinear :='Všechny body kolineárních dat';
    TeeMsg_TriSurfaceSimilar     :='Podovné body - nelze vykonat';
    TeeMsg_GalleryTriSurface     :='Trojúhelník povrch';

    TeeMsg_AllSeries :='Všechny série';
    TeeMsg_Edit      :='Zmìnit';

    TeeMsg_GalleryFinancial    :='Finanèní';

    TeeMsg_CursorTool    :='Kurzor';
    TeeMsg_DragMarksTool :='Pøesunout znaèky';
    TeeMsg_AxisArrowTool :='Šipky osy';
    TeeMsg_DrawLineTool  :='Kreslit èáru';
    TeeMsg_NearestTool   :='Nejbližší bod';
    TeeMsg_ColorBandTool :='Barva skupiny';
    TeeMsg_ColorLineTool :='Barva èáry';
    TeeMsg_RotateTool    :='Rotace';
    TeeMsg_ImageTool     :='Obrázek';
    TeeMsg_MarksTipTool  :='Tipy znaèek';

    TeeMsg_CantDeleteAncestor  :='Nemohu vymazat pøedka';

    TeeMsg_Load	          :='Naèíst...';
    TeeMsg_NoSeriesSelected :='Není vybrána série';

  { TeeChart Actions }
    TeeMsg_CategoryChartActions  :='Graf';
    TeeMsg_CategorySeriesActions :='Série grafu';

    TeeMsg_Action3D               := '&3D';
    TeeMsg_Action3DHint           := 'Pøepnout 2D / 3D';
    TeeMsg_ActionSeriesActive     := '&Aktivní';
    TeeMsg_ActionSeriesActiveHint := 'Ukázat / skrýt série';
    TeeMsg_ActionEditHint         := 'Zmìnit graf';
    TeeMsg_ActionEdit             := 'Zmì&nit...';
    TeeMsg_ActionCopyHint         := 'Kopírovat do schránky';
    TeeMsg_ActionCopy             := '&Kopírovat';
    TeeMsg_ActionPrintHint        := 'Náhled tisku grafu';
    TeeMsg_ActionPrint            := '&Tisk...';
    TeeMsg_ActionAxesHint         := 'Ukázat / skrýt osy';
    TeeMsg_ActionAxes             := '&Osy';
    TeeMsg_ActionGridsHint        := 'Ukázat / skrýt møížky';
    TeeMsg_ActionGrids            := '&Møížky';
    TeeMsg_ActionLegendHint       := 'Ukázat / skrýt legendu';
    TeeMsg_ActionLegend           := '&Legenda';
    TeeMsg_ActionSeriesEditHint   := 'Zmìnit série';
    TeeMsg_ActionSeriesMarksHint  := 'Ukázat / skrýt znaèky série';
    TeeMsg_ActionSeriesMarks      := '&Znaèky';
    TeeMsg_ActionSaveHint         := 'Uložit graf';
    TeeMsg_ActionSave             := '&Uložit...';

    TeeMsg_CandleBar              := 'Sloupec';
    TeeMsg_CandleNoOpen           := 'Není otevøení';
    TeeMsg_CandleNoClose          := 'Není zavøení';
    TeeMsg_NoLines                := 'Nejsou èáry';
    TeeMsg_NoHigh                 := 'Není vysoký';
    TeeMsg_NoLow                  := 'Není nízký';
    TeeMsg_ColorRange             := 'Rozsah barev';
    TeeMsg_WireFrame              := 'Tenký rámeèek';
    TeeMsg_DotFrame               := 'Bodový rámeèek';
    TeeMsg_Positions              := 'Pozice';
    TeeMsg_NoGrid                 := 'Není møížka';
    TeeMsg_NoPoint                := 'Není bod';
    TeeMsg_NoLine                 := 'Není èára';
    TeeMsg_Labels                 := 'Popisy';
    TeeMsg_NoCircle               := 'Není kruh';
    TeeMsg_Lines                  := 'Èáry';
    TeeMsg_Border                 := 'Okraj';

    TeeMsg_SmithResistance      := 'Odpor';
    TeeMsg_SmithReactance       := 'Jalový odpor';

    TeeMsg_Column               := 'Sloupec';

  { 5.01 }
    TeeMsg_Separator            := 'Oddìlovaè';
    TeeMsg_FunnelSegment        := 'Segment ';
    TeeMsg_FunnelSeries         := 'Trychtýø';
    TeeMsg_FunnelPercent        := '0.00 %';
    TeeMsg_FunnelExceed         := 'Pøekraèuje meze';
    TeeMsg_FunnelWithin         := ' v mezích';
    TeeMsg_FunnelBelow          := ' nebo nedosáhlo mezí';
    TeeMsg_CalendarSeries       := 'Kalendáø';
    TeeMsg_DeltaPointSeries     := 'Bod delta';
    TeeMsg_ImagePointSeries     := 'Bod obrázkù';
    TeeMsg_ImageBarSeries       := 'Sloupec obrázkù';
    TeeMsg_SeriesTextFieldZero  := 'SeriesText: Index položky by mìl být vìtší než nula.';

  { 5.02 }
    TeeMsg_Origin               := 'Poèátek';
    TeeMsg_Transparency         := 'Transparentní';
    TeeMsg_Box		              := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
    TeeMsg_PageNumber	      := 'Strana èíslo';
    TeeMsg_TextFile             := 'Textový soubor';

  { 5.03 }
    TeeMsg_Gradient     :='Pøechod';
    TeeMsg_WantToSave   :='Chcete uložit %s?';
    TeeMsg_NativeFilter :='Soubory TeeChart '+TeeDefaultFilterExtension;

    TeeMsg_Property     :='Vlastnost';
    TeeMsg_Value        :='Hodnota';
    TeeMsg_Yes          :='Ano';
    TeeMsg_No           :='Ne';
    TeeMsg_Image        :='(obrázek)';

    TeeMsg_DragPoint            := 'Pøesunout bod';
    TeeMsg_OpportunityValues    := 'OpportunityValues';
    TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateCzech;
begin
  if not Assigned(TeeCzechLanguage) then
  begin
    TeeCzechLanguage:=TStringList.Create;
    TeeCzechLanguage.Text:=

  'GRADIENT EDITOR=Editor pøechodu'#13+
  'GRADIENT=Pøechod'#13+
  'DIRECTION=Smìr'#13+
  'VISIBLE=Viditelné'#13+
  'TOP BOTTOM=Nahoru dolù'#13+
  'BOTTOM TOP=Dolù nahoru'#13+
  'LEFT RIGHT=Vlevo vpraco'#13+
  'RIGHT LEFT=Vpravo vlevo'#13+
  'FROM CENTER=Od støedu'#13+
  'FROM TOP LEFT=Zlevanahoøe'#13+
  'FROM BOTTOM LEFT=Zespodu zleva'#13+
  'OK=OK'#13+
  'CANCEL=Storno'#13+
  'COLORS=Barvy'#13+
  'START=Zaèátek'#13+
  'MIDDLE=Støed'#13+
  'END=Konec'#13+
  'SWAP=Prohodit'#13+
  'NO MIDDLE=Není støed'#13+
  'TEEFONT EDITOR=Editor písma'#13+
  'INTER-CHAR SPACING=Mezera mezi znaky'#13+
  'FONT=Písmo'#13+
  'SHADOW=Stín'#13+
  'HORIZ. SIZE=Horiz. velikost'#13+
  'VERT. SIZE=Vert. velikost'#13+
  'COLOR=Barva'#13+
  'OUTLINE=Obrys'#13+
  'OPTIONS=Volby'#13+
  'FORMAT=Formát'#13+
  'TEXT=Text'#13+
  'GRADIENT=Pøechod'#13+
  'POSITION=Pozice'#13+
  'LEFT=Vlevo'#13+
  'TOP=Nahoøe'#13+
  'AUTO=Automaticky'#13+
  'CUSTOM=Volitelnì'#13+
  'LEFT TOP=Vlevo nahoøe'#13+
  'LEFT BOTTOM=Vlevo dole'#13+
  'RIGHT TOP=Vpravo nahoøe'#13+
  'RIGHT BOTTOM=Vpravo dole'#13+
  'MULTIPLE AREAS=Více oblastí'#13+
  'NONE=Žádný'#13+
'STACKED=Stacked'#13+
'STACKED 100%=Stacked 100%'#13+
  'AREA=Oblast'#13+
  'PATTERN=Výplò'#13+
  'STAIRS=Schody'#13+
  'SOLID=Plný'#13+
  'CLEAR=Smazat'#13+
  'HORIZONTAL=Horizontální'#13+
  'VERTICAL=Vertikální'#13+
  'DIAGONAL=Diagonální'#13+
  'B.DIAGONAL=oboudiagonální'#13+
  'CROSS=Køíž'#13+
  'DIAG.CROSS=Diag. køíž'#13+
  'AREA LINES=Èáry oblasti'#13+
  'BORDER=Okraj'#13+
  'INVERTED=Inverzní'#13+
  'INVERTED SCROLL=Obrácený posun'#13+
  'COLOR EACH=Každá barva'#13+
  'ORIGIN=Poèátek'#13+
  'USE ORIGIN=Použít poèátek'#13+
  'WIDTH=Šíøka'#13+
  'HEIGHT=Výška'#13+
  'AXIS=Osy'#13+
  'LENGTH=Délka'#13+
  'SCROLL=Posun'#13+
  'PATTERN=Výplò'#13+
  'START=Zaèátek'#13+
  'END=Konec'#13+
  'BOTH=Oba'#13+
  'AXIS INCREMENT=Pøírùstek osy'#13+
  'INCREMENT=Pøírùstek'#13+
  'STANDARD=Standardní'#13+
  'CUSTOM=Uživatelský'#13+
  'ONE MILLISECOND=Jedna milisekunda'#13+
  'ONE SECOND=Jedna sekunda'#13+
  'FIVE SECONDS=Pìt sekund'#13+
  'TEN SECONDS=Deset sekund'#13+
  'FIFTEEN SECONDS=Patnáct sekund'#13+
  'THIRTY SECONDS=Tøicet sekund'#13+
  'ONE MINUTE=Jedna minuta'#13+
  'FIVE MINUTES=Pìt minut'#13+
  'TEN MINUTES=Deset minut'#13+
  'FIFTEEN MINUTES=Patnáct minut'#13+
  'THIRTY MINUTES=Tøicet minut'#13+
  'ONE HOUR=Jedna hodina'#13+
  'TWO HOURS=Dvì hodiny'#13+
  'SIX HOURS=Šest hodin'#13+
  'TWELVE HOURS=Dvanáct hodin'#13+
  'ONE DAY=Jeden den'#13+
  'TWO DAYS=Dva dny'#13+
  'THREE DAYS=Tøi dny'#13+
  'ONE WEEK=Jeden týden'#13+
  'HALF MONTH=Pùl mìsíce'#13+
  'ONE MONTH=Jeden mìsíc'#13+
  'TWO MONTHS=Dva mìsíce'#13+
  'THREE MONTHS=Tøi mìsíce'#13+
  'FOUR MONTHS=Ètyøi mìsíce'#13+
  'SIX MONTHS=Šest mìsícù'#13+
  'ONE YEAR=Jeden rok'#13+
  'EXACT DATE TIME=Exaktní datum a èas'#13+
  'AXIS MAXIMUM AND MINIMUM=Minimum a maximum osy'#13+
  'VALUE=Hodnota'#13+
  'TIME=Èas'#13+
  'LEFT AXIS=Levá osa'#13+
  'RIGHT AXIS=Pravá osa'#13+
  'TOP AXIS=Horní osa'#13+
  'BOTTOM AXIS=Spodní osa'#13+
  '% BAR WIDTH=% šíøka sloupce'#13+
  'STYLE=Styl'#13+
  '% BAR OFFSET=% Posun sloupce'#13+
  'RECTANGLE=Obdélník'#13+
  'PYRAMID=Pyramida'#13+
  'INVERT. PYRAMID=Obrácenná pyramida'#13+
  'CYLINDER=Válec'#13+
  'ELLIPSE=Elipsa'#13+
  'ARROW=Šipka'#13+
  'RECT. GRADIENT=Obdélníkový pøechod'#13+
  'CONE=Kužel'#13+
  'DARK BAR 3D SIDES=Strany tmavé 3D sloupce'#13+
  'BAR SIDE MARGINS=Okraje strany sloupce'#13+
  'AUTO MARK POSITION=Automaticky oznaèit pozici'#13+
  'BORDER=Okraj'#13+
  'JOIN=Spojení'#13+
  'BAR SIDE MARGINS=Okraje strany sloupce'#13+
  'DATASET=Dataset'#13+
  'APPLY=Použít'#13+
  'SOURCE=Zdroj'#13+
  'MONOCHROME=Èernobíle'#13+
  'DEFAULT=Výchozí'#13+
  '2 (1 BIT)=2 (1 bit)'#13+
  '16 (4 BIT)=16 (4 bit)'#13+
  '256 (8 BIT)=256 (8 bit)'#13+
  '32768 (15 BIT)=32768 (15 bit)'#13+
  '65536 (16 BIT)=65536 (16 bit)'#13+
  '16M (24 BIT)=16M (24 bit)'#13+
  '16M (32 BIT)=16M (32 bit)'#13+
  'LENGTH=Délka'#13+
  'MEDIAN=Støední'#13+
'WHISKER=Whisker'#13+
  'PATTERN COLOR EDITOR=Editor barevné výplnì'#13+
  'IMAGE=Obrázek'#13+
  'NONE=Žádný'#13+
  'BACK DIAGONAL=Zadní diagonála'#13+
  'CROSS=Køíž'#13+
  'DIAGONAL CROSS=Diagonální køíž'#13+
  'FILL 80%=Výplò 80%'#13+
  'FILL 60%=Výplò 60%'#13+
  'FILL 40%=Výplò 40%'#13+
  'FILL 20%=Výplò 20%'#13+
  'FILL 10%=Výplò 10%'#13+
  'ZIG ZAG=Cik cak'#13+
  'VERTICAL SMALL=Vertikální malé'#13+
  'HORIZ. SMALL=Horizontální malé'#13+
  'DIAG. SMALL=Diagonální malé'#13+
  'BACK DIAG. SMALL=Obrácené diagonální'#13+
  'CROSS SMALL=Malý køíž'#13+
  'DIAG. CROSS SMALL=Malý diagonální køíž'#13+
  'PATTERN COLOR EDITOR=Editor barevné výplnì'#13+
  'OPTIONS=Volby'#13+
  'DAYS=Dny'#13+
  'WEEKDAYS=Pracovní dny'#13+
  'TODAY=Dnes'#13+
  'SUNDAY=Nedìle'#13+
  'TRAILING=Vleèení'#13+
  'MONTHS=Mìsíce'#13+
  'LINES=Èáry'#13+
  'SHOW WEEKDAYS=Ukázat pracovní dny'#13+
  'UPPERCASE=Velká písmena'#13+
'TRAILING DAYS=Trailing days'#13+
  'SHOW TODAY=Ukázat dnešek'#13+
  'SHOW MONTHS=Ukázat mìsíce'#13+
  'CANDLE WIDTH=Šíøka svíèky'#13+
'STICK=Stick'#13+
  'BAR=Sloupec'#13+
  'OPEN CLOSE=Otevøít zavøít'#13+
  'UP CLOSE=Nahoøe zavøít'#13+
  'DOWN CLOSE=Dole zavøít'#13+
  'SHOW OPEN=Ukázat otevøení'#13+
  'SHOW CLOSE=Ukázat zavøení'#13+
  'DRAW 3D=Kreslit 3D'#13+
  'DARK 3D=3D stín'#13+
  'EDITING=Úprava'#13+
  'CHART=Graf'#13+
  'SERIES=Série'#13+
  'DATA=Data'#13+
  'TOOLS=Nástroje'#13+
  'EXPORT=Exportovat'#13+
  'PRINT=Tisknout'#13+
  'GENERAL=Hlavní'#13+
  'TITLES=Nadpisy'#13+
  'LEGEND=Legenda'#13+
  'PANEL=Panel'#13+
  'PAGING=Stránkování'#13+
  'WALLS=Stìny'#13+
  '3D=3D'#13+
  'ADD=Pøidat'#13+
  'DELETE=Vymazat'#13+
  'TITLE=Nadpis'#13+
  'CLONE=Duplikovat'#13+
  'CHANGE=Zmìnit'#13+
  'HELP=Pomoc'#13+
  'CLOSE=Zavøít'#13+
  'IMAGE=Obrázek'#13+
  'TEECHART PRINT PREVIEW=Náhled tisku TeeChart'#13+
  'PRINTER=Tiskárna'#13+
  'SETUP=Nastavení'#13+
  'ORIENTATION=Orientace'#13+
  'PORTRAIT=Na výšku'#13+
  'LANDSCAPE=Na šíøku'#13+
  'MARGINS (%)=Okraje (%)'#13+
  'DETAIL=Detail'#13+
  'MORE=Vìtší'#13+
  'NORMAL=Normální'#13+
  'RESET MARGINS=Obnovit okraje'#13+
  'VIEW MARGINS=Viditelné okraje'#13+
  'PROPORTIONAL=Proporcionální'#13+
  'TEECHART PRINT PREVIEW=Náhled tisku TeeChart'#13+
  'RECTANGLE=Obdélník'#13+
  'CIRCLE=Kruh'#13+
  'VERTICAL LINE=Vert. èára'#13+
  'HORIZ. LINE=Horiz. èára'#13+
  'TRIANGLE=Trojúhelník'#13+
  'INVERT. TRIANGLE=Obrácený trojúhelník'#13+
  'LINE=Èára'#13+
  'DIAMOND=Diamant'#13+
  'CUBE=Krychle'#13+
  'DIAGONAL CROSS=Diagonální køíž'#13+
  'STAR=Hvìzda'#13+
  'TRANSPARENT=Prùhledný'#13+
  'HORIZ. ALIGNMENT=Horizontální zarovnání'#13+
  'LEFT=Levé'#13+
  'CENTER=Støed'#13+
  'RIGHT=Pravé'#13+
  'ROUND RECTANGLE=Zaoblené rohy'#13+
  'ALIGNMENT=Zarovnání'#13+
  'TOP=Nahoru'#13+
  'BOTTOM=Dolù'#13+
  'RIGHT=Vpravo'#13+
  'BOTTOM=Dolù'#13+
  'UNITS=Jednotky'#13+
  'PIXELS=Pixely'#13+
  'AXIS=Osy'#13+
  'AXIS ORIGIN=Poèátek osy'#13+
  'ROTATION=Otoèení'#13+
  'CIRCLED=Zaoblený'#13+
  '3 DIMENSIONS=3 dimenzionální'#13+
  'RADIUS=Polomìr'#13+
  'ANGLE INCREMENT=Pøírùstek úhlu'#13+
  'RADIUS INCREMENT=Pøírùstek polomìru'#13+
  'CLOSE CIRCLE=Uzavøený kruh'#13+
  'PEN=Tužka'#13+
  'CIRCLE=Kruh'#13+
  'LABELS=Popisy'#13+
  'VISIBLE=Viditelné'#13+
  'ROTATED=Otoèený'#13+
  'CLOCKWISE=Vpravo'#13+
  'INSIDE=Uvnitø'#13+
  'ROMAN=Roman'#13+
  'HOURS=Hodiny'#13+
  'MINUTES=Minuty'#13+
  'SECONDS=Sekundy'#13+
  'START VALUE=Poèíteèní hodnota'#13+
  'END VALUE=Koneèná hodnota'#13+
  'TRANSPARENCY=Prùhlednost'#13+
  'DRAW BEHIND=Kreslit pozadí'#13+
  'COLOR MODE=Barevný režim'#13+
  'STEPS=Kroky'#13+
  'RANGE=Rozsah'#13+
  'PALETTE=Paleta'#13+
'PALE=Pale'#13+
  'STRONG=Silný'#13+
  'GRID SIZE=Velikost møížky'#13+
  'X=X'#13+
  'Z=Z'#13+
  'DEPTH=Hloubka'#13+
  'IRREGULAR=Nepravidelný'#13+
  'GRID=Møížka'#13+
  'VALUE=Hodnota'#13+
  'ALLOW DRAG=Umožnit pøesun'#13+
  'VERTICAL POSITION=Vertikální pozice'#13+
  'PEN=Pero'#13+
  'LEVELS POSITION=Pozice úrovní'#13+
  'LEVELS=Úrovnì'#13+
  'NUMBER=èíslo'#13+
  'LEVEL=Úroveò'#13+
  'AUTOMATIC=Automaticky'#13+
  'BOTH=Oba'#13+
  'SNAP=Uchytit'#13+
  'FOLLOW MOUSE=Následovat myš'#13+
'STACK=Stapel'#13+
  'HEIGHT 3D=Výška 3D'#13+
  'LINE MODE=Èárový režim'#13+
  'STAIRS=Schody'#13+
  'NONE=Žádný'#13+
'OVERLAP=Overlap'#13+
'STACK=Stack'#13+
'STACK 100%=Stack 100%'#13+
  'CLICKABLE=Umožnit kliknutí'#13+
  'LABELS=Popisy'#13+
  'AVAILABLE=Dostupný'#13+
  'SELECTED=Vybraný'#13+
  'DATASOURCE=Datový zdroj'#13+
  'GROUP BY=Seskupit'#13+
  'CALC=Vypoèítat'#13+
  'OF=z'#13+
  'SUM=Suma'#13+
  'COUNT=Poèet'#13+
  'HIGH=Vysoký'#13+
  'LOW=Nízký'#13+
  'AVG=Prùmìr'#13+
  'HOUR=Hodina'#13+
  'DAY=Den'#13+
  'WEEK=Týden'#13+
  'WEEKDAY=Pracovní den'#13+
  'MONTH=Mìsíc'#13+
  'QUARTER=Ètvrtletí'#13+
  'YEAR=Rok'#13+
  'HOLE %=Díra %'#13+
  'RESET POSITIONS=Obnovit pozice'#13+
  'MOUSE BUTTON=Tlaèítko myši'#13+
  'ENABLE DRAWING=Umožnit kreslení'#13+
  'ENABLE SELECT=Umožnit výbìr'#13+
  'ENHANCED=Rozšíøený'#13+
  'ERROR WIDTH=Chyba šíøky'#13+
  'WIDTH UNITS=Jednotka šíøky'#13+
  'PERCENT=Procenta'#13+
  'PIXELS=Pixely'#13+
  'LEFT AND RIGHT=Vlevo a vpravo'#13+
  'TOP AND BOTTOM=Nahoru a dolù'#13+
  'BORDER=Okraj'#13+
  'BORDER EDITOR=Editor okrajù'#13+
  'DASH=Èárka'#13+
  'DOT=Teèka'#13+
  'DASH DOT=Èárka teèka'#13+
  'DASH DOT DOT=Èárka teèka teèka'#13+
  'CALCULATE EVERY=Poèítat každý'#13+
  'ALL POINTS=Všechny body'#13+
  'NUMBER OF POINTS=Poèet bodù'#13+
  'RANGE OF VALUES=Rozsah hodnot'#13+
  'FIRST=První'#13+
  'CENTER=Støední'#13+
  'LAST=Poslední'#13+
  'TEEPREVIEW EDITOR=Editor náhledu'#13+
  'ALLOW MOVE=Umožnit pøesun'#13+
  'ALLOW RESIZE=Umožnit zmìnu velikosti'#13+
  'DRAG IMAGE=Pøesunout obrázek'#13+
  'AS BITMAP=Jako bitmapu'#13+
  'SHOW IMAGE=Ukázat obrázek'#13+
  'DEFAULT=Výchozí'#13+
  'MARGINS=Okraje'#13+
  'SIZE=Velikost'#13+
  '3D %=3D %'#13+
  'ZOOM=Zvìtšení'#13+
  'ROTATION=Otoèení'#13+
  'ELEVATION=Elevace'#13+
  '100%=100%'#13+
  'HORIZ. OFFSET=Horiz. posun'#13+
  'VERT. OFFSET=Vert. posun'#13+
  'PERSPECTIVE=Perspektiva'#13+
  'ANGLE=Úhel'#13+
  'ORTHOGONAL=Orthogonální'#13+
  'ZOOM TEXT=Zvìtšit text'#13+
  'SCALES=Velikost'#13+
  'TITLE=Nadpis'#13+
'TICKS=Ticks'#13+
  'MINOR=Minoritní'#13+
  'MAXIMUM=Maximum'#13+
  'MINIMUM=Minimum'#13+
  '(MAX)=(max)'#13+
  '(MIN)=(min)'#13+
  'DESIRED INCREMENT=Pøírùstek'#13+
  '(INCREMENT)=(pøírùstek)'#13+
  'LOG BASE=Log. základ'#13+
  'LOGARITHMIC=Logaritmická'#13+
  'TITLE=Nadpis'#13+
  'MIN. SEPARATION %=Min. rozestup %'#13+
  'MULTI-LINE=Víceøádkové'#13+
  'LABEL ON AXIS=Popis na ose'#13+
  'ROUND FIRST=Zaoblit'#13+
  'MARK=Znaèka'#13+
  'LABELS FORMAT=Formát popisu'#13+
  'EXPONENTIAL=Exponenciální'#13+
  'DEFAULT ALIGNMENT=Výchozí zarovnání'#13+
  'LEN=Délka'#13+
  'LENGTH=Délka'#13+
  'AXIS=Osa'#13+
  'INNER=Vnitøní'#13+
  'GRID=Møížka'#13+
  'AT LABELS ONLY=Pouze na popisech'#13+
  'CENTERED=Na støed'#13+
  'COUNT=Poèet'#13+
'TICKS=Unterticks'#13+
  'POSITION %=Pozice %'#13+
  'START %=Zaèátek %'#13+
  'END %=Konec %'#13+
  'OTHER SIDE=Jiná strana'#13+
  'AXES=Osy'#13+
  'BEHIND=Pozadí'#13+
'CLIP POINTS=Clip Points'#13+
  'PRINT PREVIEW=Náhled tisku'#13+
  'MINIMUM PIXELS=Minimum pixelù'#13+
  'MOUSE BUTTON=Tlaèítko myši'#13+
  'ALLOW=Umožnit zvìtšení'#13+
  'ANIMATED=Animovat'#13+
  'VERTICAL=Vertikální'#13+
  'RIGHT=Pravé'#13+
  'MIDDLE=Støední'#13+
  'ALLOW SCROLL=Umožnit posun'#13+
  'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
  'AMBIENT LIGHT=Okolní svìtlo'#13+
'SHININESS=Beleuchtung'#13+
  'FONT 3D DEPTH=Hloubka 3D písma'#13+
  'ACTIVE=Aktivní'#13+
  'FONT OUTLINES=Obrysové písmo'#13+
  'SMOOTH SHADING=Rozmazaný stín'#13+
  'LIGHT=Svìtlo'#13+
  'Y=Y'#13+
  'INTENSITY=Intenzita'#13+
  'BEVEL=Zešikmení'#13+
  'FRAME=Rámeèek'#13+
  'ROUND FRAME=Zaoblený rámeèek'#13+
  'LOWERED=Snížení'#13+
  'RAISED=Zvýšení'#13+
  'POSITION=Pozice'#13+
  'SYMBOLS=Symboly'#13+
  'TEXT STYLE=Styl textu'#13+
  'LEGEND STYLE=Styl legendy'#13+
  'VERT. SPACING=Vertikální rozestup'#13+
  'AUTOMATIC=Automatický'#13+
  'SERIES NAMES=Názvy sérií'#13+
  'SERIES VALUES=Hodnoty sérií'#13+
  'LAST VALUES=Poslední hodnoty'#13+
  'PLAIN=Prostý'#13+
  'LEFT VALUE=Levá hodnota'#13+
  'RIGHT VALUE=Pravá hodnota'#13+
  'LEFT PERCENT=Levá procenta'#13+
  'RIGHT PERCENT=Pravá procenta'#13+
  'X VALUE=Hodnota X'#13+
  'VALUE=Hodnota'#13+
  'PERCENT=Procenta'#13+
  'X AND VALUE=X a hodnota'#13+
  'X AND PERCENT=X a procenta'#13+
  'CHECK BOXES=Zaškrtávací pole'#13+
  'DIVIDING LINES=Dìlící èáry'#13+
  'FONT SERIES COLOR=Barva písma série'#13+
  'POSITION OFFSET %=Posun pozice %'#13+
  'MARGIN=Okraj'#13+
  'RESIZE CHART=Mìnit velikost'#13+
  'CUSTOM=Volitelnì'#13+
  'WIDTH UNITS=Jednotky šíøky'#13+
  'CONTINUOUS=Souvislý'#13+
  'POINTS PER PAGE=Bodù na stránku'#13+
  'SCALE LAST PAGE=Pomìrnì k poslední stranì'#13+
  'CURRENT PAGE LEGEND=Legenda na této stranì'#13+
  'PANEL EDITOR=Editor panelu'#13+
  'BACKGROUND=Pozadí'#13+
  'BORDERS=Okraje'#13+
  'BACK IMAGE=Obrázek na pozadí'#13+
  'STRETCH=Natáhnout'#13+
  'TILE=Nadpis'#13+
  'CENTER=Na støed'#13+
  'BEVEL INNER=Vnitøní zešekmení'#13+
  'LOWERED=Snížené'#13+
  'RAISED=Zvýšené'#13+
  'BEVEL OUTER=Vnìjší zešikmení'#13+
  'MARKS=Znaèky'#13+
  'DATA SOURCE=Datový zdroj'#13+
  'SORT=Tøídìní'#13+
  'CURSOR=Kurzor'#13+
  'SHOW IN LEGEND=Zobrazit v legendì'#13+
  'FORMATS=Formáty'#13+
  'VALUES=Hodnoty'#13+
  'PERCENTS=Procenta'#13+
  'HORIZONTAL AXIS=Horizontální osa'#13+
  'TOP AND BOTTOM=Nahoøe a dole'#13+
  'DATETIME=Datum/èas'#13+
  'VERTICAL AXIS=Vertikální osa'#13+
  'LEFT=Levý'#13+
  'RIGHT=Pravý'#13+
  'LEFT AND RIGHT=Levý a pravý'#13+
  'ASCENDING=Vzestupné'#13+
  'DESCENDING=Sestupné'#13+
  'DRAW EVERY=Kreslit každý'#13+
  'CLIPPED=Zkrátit'#13+
  'ARROWS=Šipky'#13+
  'MULTI LINE=Víceøádkové'#13+
  'ALL SERIES VISIBLE=Všechny série viditelné'#13+
  'LABEL=Popis'#13+
  'LABEL AND PERCENT=Popis a procenta'#13+
  'LABEL AND VALUE=Popis a hodnota'#13+
  'PERCENT TOTAL=Celková procenta'#13+
  'LABEL & PERCENT TOTAL=Popis a celková procenta'#13+
  'X VALUE=Hodnota X'#13+
  'X AND Y VALUES=Hodnoty X a Y'#13+
  'MANUAL=Ruènì'#13+
  'RANDOM=Náhodnì'#13+
  'FUNCTION=Funkce'#13+
  'NEW=Nový'#13+
  'EDIT=Zmìnit'#13+
  'DELETE=Vymazat'#13+
  'PERSISTENT=Trvalý'#13+
  'ADJUST FRAME=Pøizpùsobit rámeèek'#13+
  'SUBTITLE=Podnadpis'#13+
  'SUBFOOT=Podzápatí'#13+
  'FOOT=Zápatí'#13+
  'DELETE=Vymazat'#13+
  'VISIBLE WALLS=Viditelné stìny'#13+
  'BACK=Zpìt'#13+
'DIF. LIMIT=Dif. Limit'#13+
  'LINES=Èáry'#13+
  'ABOVE=Nad'#13+
  'WITHIN=Uvnitø'#13+
  'BELOW=Dole'#13+
  'CONNECTING LINES=Spojovací èáry'#13+
  'SERIES=Série'#13+
'PALE=Pale'#13+
  'STRONG=Silný'#13+
  'HIGH=Vysoký'#13+
  'LOW=Nízký'#13+
  'BROWSE=Procházet'#13+
  'TILED=Dlaždice'#13+
  'INFLATE MARGINS=Vyplnit okraje'#13+
  'SQUARE=Ètverec'#13+
  'DOWN TRIANGLE=Spodní trojúhelník'#13+
  'SMALL DOT=Malý bod'#13+
  'DEFAULT=Výchozí'#13+
  'GLOBAL=Globální'#13+
  'SHAPES=Tvary'#13+
  'BRUSH=Štìtec'#13+
  'BRUSH=Štìtec'#13+
  'BORDER=Okraj'#13+
  'COLOR=Barva'#13+
  'DELAY=Prodleva'#13+
  'MSEC.=ms'#13+
  'MOUSE ACTION=Akce myši'#13+
  'MOVE=Pøesunout'#13+
  'CLICK=Klik'#13+
  'BRUSH=Štìtec'#13+
  'DRAW LINE=Kreslit èáru'#13+
  'BORDER EDITOR=Editor okraje'#13+
  'DASH=Èárka'#13+
  'DOT=Teèka'#13+
  'DASH DOT=Èárka teèka'#13+
  'DASH DOT DOT=Èárka teèka teèka'#13+
  'EXPLODE BIGGEST=Nejvìtší zvìtšení'#13+
  'TOTAL ANGLE=Celkový úhel'#13+
  'GROUP SLICES=Seskupování'#13+
  'BELOW %=Spodní %'#13+
  'BELOW VALUE=Spodní hodnota'#13+
  'OTHER=Ostatní'#13+
  'PATTERNS=Výplnì'#13+
  'CLOSE CIRCLE=Zavøít kruh'#13+
  'VISIBLE=Viditelné'#13+
  'CLOCKWISE=Pravotoèivé'#13+
  'SIZE %=Velikost %'#13+
  'PATTERN=Výplò'#13+
  'DEFAULT=Výchozí'#13+
  'SERIES DATASOURCE TEXT EDITOR=Editor textových zdrojù série'#13+
  'FIELDS=Pole'#13+
  'NUMBER OF HEADER LINES=Poèet èar záhlaví'#13+
  'SEPARATOR=Oddìlovaè'#13+
  'COMMA=Èárka'#13+
  'SPACE=Mezera'#13+
  'TAB=Tabulátor'#13+
  'FILE=Soubor'#13+
  'WEB URL=Web URL'#13+
  'LOAD=Naèíst'#13+
  'C LABELS=Popisy C'#13+
  'R LABELS=Popisy R'#13+
  'C PEN=Tužka C'#13+
  'R PEN=Tužka R'#13+
'STACK GROUP=Stapel gruppieren'#13+
  'USE ORIGIN=Použít poèátek'#13+
  'MULTIPLE BAR=Vícesloupcový'#13+
  'SIDE=Strana'#13+
'STACKED 100%=Stacked 100%'#13+
  'SIDE ALL=Všechny stìny'#13+
  'BRUSH=Štìtec..'#13+
  'DRAWING MODE=Kreslící režim'#13+
  'SOLID=Plný'#13+
  'WIREFRAME=Tenký rámeèek'#13+
  'DOTFRAME=Bodový rámeèek'#13+
  'SMOOTH PALETTE=Paleta rozmazání'#13+
  'SIDE BRUSH=Stranový štìtec'#13+
  'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0'#13+
  'ALL RIGHTS RESERVED.=Všechna práva vyhrazena.'#13+
  'VISIT OUR WEB SITE !=Navštivté náš web!'#13+
  'TEECHART WIZARD=Prùvodce TeeChart'#13+
  'SELECT A CHART STYLE=Vyberte styl grafu'#13+
  'DATABASE CHART=Databázový graf'#13+
  'NON DATABASE CHART=Nedatabázový graf'#13+
  'SELECT A DATABASE TABLE=Vyberte tabulku databáze'#13+
  'ALIAS=Alias'#13+
  'TABLE=Tabulka'#13+
  'SOURCE=Zdroj'#13+
  'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
  'MICROSOFT ADO=Microsoft ADO'#13+
  'SELECT THE DESIRED FIELDS TO CHART=Vyberte požadovaná pole pro graf'#13+
  'SELECT A TEXT LABELS FIELD=Vyberte položku textového popisu'#13+
  'CHOOSE THE DESIRED CHART TYPE=Vyberte požadovaný typ grafu'#13+
  '2D=2D'#13+
  'CHART PREVIEW=Náhled grafu'#13+
  'SHOW LEGEND=Ukázat legendu'#13+
  'SHOW MARKS=Ukázat znaèky'#13+
  '< BACK=< Zpìt'#13+
  'SELECT A CHART STYLE=Vyberte styl grafu'#13+
  'NON DATABASE CHART=Nedatabázový graf'#13+
  'SELECT A DATABASE TABLE=Vyberte tabulku databáze'#13+
  'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
  'SELECT THE DESIRED FIELDS TO CHART=Vyberte požadovaná pole pro graf'#13+
  'SELECT A TEXT LABELS FIELD=Vyberte pole textového popisu'#13+
  'CHOOSE THE DESIRED CHART TYPE=Vyberte požadovaný typ grafu'#13+
  'EXPORT CHART=Export grafu'#13+
  'PICTURE=Obrázek'#13+
  'NATIVE=Soubor TeeChart'#13+
  'KEEP ASPECT RATIO=Zachovat pomìry'#13+
  'INCLUDE SERIES DATA=Vèetnì dat sérií'#13+
  'FILE SIZE=Velikost souboru'#13+
  'DELIMITER=Oddìlovaè'#13+
  'XML=XML'#13+
  'HTML TABLE=Tabulka HTML'#13+
  'EXCEL=Excel'#13+
  'TAB=Tab'#13+
  'COLON=Dvojteèka'#13+
  'INCLUDE=Vložit'#13+
  'POINT LABELS=Popisy bodù'#13+
  'POINT INDEX=Seznam bodù'#13+
  'HEADER=Hlavièka'#13+
  'COPY=Kopírovat'#13+
  'SAVE=Uložit'#13+
  'SEND=Odeslat'#13+
  'KEEP ASPECT RATIO=Zachovat pomìr'#13+
  'INCLUDE SERIES DATA=Vèetnì dat sérií'#13+
  'FUNCTIONS=Funkce'#13+
  'ADD=Pøidání'#13+
  'ADX=ADX'#13+
  'AVERAGE=Prùmìr'#13+
'BOLLINGER=Bollinger'#13+
  'COPY=Kopie'#13+
  'DIVIDE=Dìlení'#13+
  'EXP. AVERAGE=Exp. prùmìr'#13+
  'EXP.MOV.AVRG.=Exp. posunutý prùmìr'#13+
  'HIGH=Vysoký'#13+
  'LOW=Nízký'#13+
  'MACD=MACD'#13+
  'MOMENTUM=Hybnost'#13+
  'MOMENTUM DIV=Podíl hybnosti'#13+
  'MOVING AVRG.=Posunutý prùmìr'#13+
  'MULTIPLY=Násobení'#13+
  'R.S.I.=R.S.I.'#13+
  'ROOT MEAN SQ.=Koøen znamená ètverec'#13+
  'STD.DEVIATION=Standardní odchylka'#13+
  'STOCHASTIC=Náhodný'#13+
  'SUBTRACT=Rozdíl'#13+
  'APPLY=Použít'#13+
  'SOURCE SERIES=Zdrojová série'#13+
  'TEECHART GALLERY=galerie TeeChart'#13+
  'FUNCTIONS=Funkce'#13+
  'DITHER=Pøepoèet'#13+
  'REDUCTION=Redukce'#13+
  'COMPRESSION=Komprese'#13+
  'LZW=LZW'#13+
  'RLE=RLE'#13+
  'NEAREST=Nejbližší'#13+
  'FLOYD STEINBERG=Floyd Steinberg'#13+
  'STUCKI=Stucki'#13+
  'SIERRA=Sierra'#13+
  'JAJUNI=JaJuNI'#13+
  'STEVE ARCHE=Steve Arche'#13+
  'BURKES=Burkes'#13+
  'WINDOWS 20=Windows 20'#13+
  'WINDOWS 256=Windows 256'#13+
  'WINDOWS GRAY=Windows šedi'#13+
  'MONOCHROME=Èernobíle'#13+
  'GRAY SCALE=Odstíny šedi'#13+
  'NETSCAPE=Netscape'#13+
  'QUANTIZE=Kvantovaný'#13+
  'QUANTIZE 256=Kvantovaný 256'#13+
  '% QUALITY=% kvality'#13+
  'GRAY SCALE=Odstíny šedi'#13+
  'PERFORMANCE=Výkon'#13+
  'QUALITY=Kvalita'#13+
  'SPEED=Rychlost'#13+
  'COMPRESSION LEVEL=Úroveò komprese'#13+
  'CHART TOOLS GALLERY=Galerie nástrojù grafu'#13+
  'ANNOTATION=Anotace'#13+
  'AXIS ARROWS=Šipky osy'#13+
  'COLOR BAND=Skupina barev'#13+
  'COLOR LINE=Kurzor'#13+
  'CURSOR=Kurzor'#13+
  'DRAG MARKS=Pøesunout znaèky'#13+
  'DRAW LINE=Kreslit èáru'#13+
  'IMAGE=Obrázek'#13+
  'MARK TIPS=Tipy znaèek'#13+
  'NEAREST POINT=Nejbližší bod'#13+
  'ROTATE=Otoèit'#13+
  'CHART TOOLS GALLERY=Galerie nástrojù grafu'#13+
  'BRUSH=Štìtec'#13+
  'DRAWING MODE=Kreslící režim'#13+
  'WIREFRAME=Tenký okraj'#13+
  'SMOOTH PALETTE=Paleta rozmazání'#13+
  'SIDE BRUSH=Stranový štìtec'#13+
  'YES=Ano'#13
;
  end;
end;

Procedure TeeSetCzech;
begin
  TeeCreateCzech;
  TeeLanguage:=TeeCzechLanguage;
  TeeCzechConstants;
end;

initialization
finalization
  FreeAndNil(TeeCzechLanguage);
end.

