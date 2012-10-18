unit TeeHungarian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHungarianLanguage:TStringList=nil;

Procedure TeeSetHungarian;
Procedure TeeCreateHungarian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHungarianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='A jelmagyarázat elsõ értéke legyen > 0';
  TeeMsg_LegendColorWidth   :='A jelmagyarázat színmélysége legyen > 0%';
  TeeMsg_SeriesSetDataSource:='Nincs szülõ diagram az adatforrás érvényesítéséhez';
  TeeMsg_SeriesInvDataSource:='Érvénytelen adatforrás: %s';
  TeeMsg_FillSample         :='A kitöltési példa értékei legyenek > 0';
  TeeMsg_AxisLogDateTime    :='A dátum/idõ tengely nem lehet logaritmikus';
  TeeMsg_AxisLogNotPositive :='A logaritmikus tengely min és max értéke legyen >= 0';
  TeeMsg_AxisLabelSep       :='A felirat elválasztás % legyen nagyobb mint 0';
  TeeMsg_AxisIncrementNeg   :='A tengely növekedés legyen  >= 0';
  TeeMsg_AxisMinMax         :='A tengely legkissebb értéke legyen <= Maximum';
  TeeMsg_AxisMaxMin         :='A tengely legnagyobb értéke legyen >= Minimum';
  TeeMsg_AxisLogBase        :='A tengely logaritmikus alapja legyen >= 2';
  TeeMsg_MaxPointsPerPage   :='A maximum pont / oldal legyen >= 0';
  TeeMsg_3dPercent          :='A 3D hatás százaléka legyen %d és %d között';
  TeeMsg_CircularSeries     :='A visszatérõ sorok függõsége nincs megengedve';
  TeeMsg_WarningHiColor     :='A jobb látványhoz 16k szín vagy több szükséges';

  TeeMsg_DefaultPercentOf   :='%s %s-a';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'%s-a';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tengely neve';
  TeeMsg_AxisLabels         :='Tengelyfeliratok';
  TeeMsg_RefreshInterval    :='A frissítési intervallumnak 0 és 60 között kell lennie';
  TeeMsg_SeriesParentNoSelf :='A sor szülõ diagramja nem saját maga!';
  TeeMsg_GalleryLine        :='Vonal';
  TeeMsg_GalleryPoint       :='Pont';
  TeeMsg_GalleryArea        :='Felszín';
  TeeMsg_GalleryBar         :='Sáv';
  TeeMsg_GalleryHorizBar    :='Vízsz. sáv';
  TeeMsg_Stack              :='Halom';
  TeeMsg_GalleryPie         :='Kördiagram';
  TeeMsg_GalleryCircled     :='Kör';
  TeeMsg_GalleryFastLine    :='Erõs vonal';
  TeeMsg_GalleryHorizLine   :='Vízsz. vonal';

  TeeMsg_PieSample1         :='Autók';
  TeeMsg_PieSample2         :='Telefonok';
  TeeMsg_PieSample3         :='Asztalok';
  TeeMsg_PieSample4         :='Monitorok';
  TeeMsg_PieSample5         :='Lámpák';
  TeeMsg_PieSample6         :='Billentyûzetek';
  TeeMsg_PieSample7         :='Kerékpárok';
  TeeMsg_PieSample8         :='Székek';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='%s-os szerkesztés';

  TeeMsg_GalleryStandard    :='Átlag';
  TeeMsg_GalleryExtended    :='Kiterjesztett';
  TeeMsg_GalleryFunctions   :='Függvények';

  TeeMsg_EditChart          :='Grafikon &szerkesztés...';
  TeeMsg_PrintPreview       :='&Nyomtatási kép...';
  TeeMsg_ExportChart        :='Grafikon &export...';
  TeeMsg_CustomAxes         :='Közös tengelyek...';

  TeeMsg_InvalidEditorClass :='%s: Érvénytelen szerkesztési osztály: %s';
  TeeMsg_MissingEditorClass :='%s: nincs szerkesztési dialógus';

  TeeMsg_GalleryArrow       :='Nyíl';

  TeeMsg_ExpFinish          :='&Vége';
  TeeMsg_ExpNext            :='&Következõ >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Tervezés';
  TeeMsg_GanttSample2       :='Prototípuskészítés';
  TeeMsg_GanttSample3       :='Fejlesztés';
  TeeMsg_GanttSample4       :='Értékesítés';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Tesztelés';
  TeeMsg_GanttSample7       :='Gyártás';
  TeeMsg_GanttSample8       :='Hibakeresés';
  TeeMsg_GanttSample9       :='Új verzió';
  TeeMsg_GanttSample10      :='Bankügylet';

  TeeMsg_ChangeSeriesTitle  :='Sor-cím változtatás';
  TeeMsg_NewSeriesTitle     :='Új sor-cím:';
  TeeMsg_DateTime           :='Dátum/idõ';
  TeeMsg_TopAxis            :='Felsõ tengely';
  TeeMsg_BottomAxis         :='Alsó tengely';
  TeeMsg_LeftAxis           :='Bal tengely';
  TeeMsg_RightAxis          :='Jobb tengely';

  TeeMsg_SureToDelete       :='Törlés %s ?';
  TeeMsg_DateTimeFormat     :='Dátum/idõ &formátum:';
  TeeMsg_Default            :='Alapértelmezett';
  TeeMsg_ValuesFormat       :='Érték For&mátum:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Kívánt %s-os Növekedés';

  TeeMsg_IncorrectMaxMinValue:='Hibás érték. Ok: %s';
  TeeMsg_EnterDateTime      :='Felvétel [Napok száma] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Változás elfogadva ?';
  TeeMsg_SelectedSeries     :='(Kiválasztott sor)';
  TeeMsg_RefreshData        :='&Adat frissítés';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='Hozzáadás';
  TeeMsg_FunctionSubtract   :='Kivonás';
  TeeMsg_FunctionMultiply   :='Szorzás';
  TeeMsg_FunctionDivide     :='Osztás';
  TeeMsg_FunctionHigh       :='Nagy';
  TeeMsg_FunctionLow        :='Alacsony';
  TeeMsg_FunctionAverage    :='Átlagos';

  TeeMsg_GalleryShape       :='Minta';
  TeeMsg_GalleryBubble      :='Buborék';
  TeeMsg_FunctionNone       :='Másol';

  TeeMsg_None               :='(none)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :=' A Pointer mérete legyen nagyobb, mint 0';
  TeeMsg_About              :='Abo&ut TeeChart...';

  tcAdditional              :='További';
  tcDControls               :='Adatvezérlés';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Adatállomány';
  TeeMsg_AskDataSet         :='&Adatállomány:';

  TeeMsg_SingleRecord       :='Egyes rekord';
  TeeMsg_AskDataSource      :='&Adatforrás:';

  TeeMsg_Summary            :='Összegzés';

  TeeMsg_FunctionPeriod     :='A függvény periódus legyen >= 0';

  TeeMsg_WizardTab          :='Üzlet';
  TeeMsg_TeeChartWizard     :='TeeChart Varázsló';

  TeeMsg_ClearImage         :='&Töröl';
  TeeMsg_BrowseImage        :='&Böngészés...';

  TeeMsg_WizardSureToClose  :='Biztos, hogy bezárja a TeeChart varázslót ?';
  TeeMsg_FieldNotFound      :='A %s mezõ nem létezik';

  TeeMsg_DepthAxis          :='Tengely mélysége';
  TeeMsg_PieOther           :='Egyéb';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Kördiagram';
  TeeMsg_ValuesBar          :='Sáv';
  TeeMsg_ValuesAngle        :='Szög';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Vége';
  TeeMsg_ValuesGanttNextTask:='Következõ feladat';
  TeeMsg_ValuesBubbleRadius :='Radián';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='Jelmagyarázat';
  TeeMsg_Title              :='Cím';
  TeeMsg_Foot               :='Lábléc';
  TeeMsg_Period		    :='Szakasz';
  TeeMsg_PeriodRange        :='Szakaszhatár';
  TeeMsg_CalcPeriod         :='Minden %s-ot számol:';
  TeeMsg_SmallDotsPen       :='Kis pontok';

  TeeMsg_InvalidTeeFile     :='Érvényítelen karakter a *.'+TeeMsg_TeeExtension+' fájlban';
  TeeMsg_WrongTeeFileFormat :='Rossz *.'+TeeMsg_TeeExtension+' fájl formátum';
  TeeMsg_EmptyTeeFile       :='Üres *.'+TeeMsg_TeeExtension+' fájl';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Grafikon tengelyek';
  TeeMsg_ChartAxesCategoryDesc   := 'Grafikon tengelyek jellemzõi és eseményei';
  TeeMsg_ChartWallsCategoryName  := 'Grafikon hátterek';
  TeeMsg_ChartWallsCategoryDesc  := 'Grafikon hátterek jellemzõi és eseményei';
  TeeMsg_ChartTitlesCategoryName := 'Grafikon címek';
  TeeMsg_ChartTitlesCategoryDesc := 'Grafikoncímek jellemzõi és eseményei';
  TeeMsg_Chart3DCategoryName     := '3D Grafikon';
  TeeMsg_Chart3DCategoryDesc     := '3D Grafikon jellemzõi és eseményei';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Közös ';
  TeeMsg_Series                 :='Sorok';
  TeeMsg_SeriesList             :='Sorok...';

  TeeMsg_PageOfPages            :='A %d %d oldala';
  TeeMsg_FileSize               :='%d bájt';

  TeeMsg_First  :='Elsõ';
  TeeMsg_Prior  :='Elõzõ';
  TeeMsg_Next   :='Következõ';
  TeeMsg_Last   :='Utolsó';
  TeeMsg_Insert :='Beszúrás';
  TeeMsg_Delete :='Törlés';
  TeeMsg_Edit   :='Szerkesztés';
  TeeMsg_Post   :='Mentés';
  TeeMsg_Cancel :='Mégsem';

  TeeMsg_All    :='(all)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Szöveg';

  TeeMsg_AsBMP        :='&Bitmapként';
  TeeMsg_BMPFilter    :='Bitmap-ek (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metafile-ként';
  TeeMsg_EMFFilter    :='Fejlesztett Metafile-ok (*.emf)|*.emf|Metafile-ok (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'A Panel jellemzõ nincs beállítva az Export formátumban';

  TeeMsg_Normal    :='Szabályos';
  TeeMsg_NoBorder  :='Nincs határ';
  TeeMsg_Dotted    :='Pontozott';
  TeeMsg_Colors    :='Színek';
  TeeMsg_Filled    :='Kitöltve';
  TeeMsg_Marks     :='Jelölések';
  TeeMsg_Stairs    :='Csillagok';
  TeeMsg_Points    :='Pontok';
  TeeMsg_Height    :='Magasság';
  TeeMsg_Hollow    :='Üreges';
  TeeMsg_Point2D   :='2D-s pont';
  TeeMsg_Triangle  :='Háromszög';
  TeeMsg_Star      :='Csillag';
  TeeMsg_Circle    :='Kör';
  TeeMsg_DownTri   :='Háromszög lefelé';
  TeeMsg_Cross     :='Kereszt';
  TeeMsg_Diamond   :='Gyémánt';
  TeeMsg_NoLines   :='Nincs vonal';
  TeeMsg_Stack100  :='100%-os halom';
  TeeMsg_Pyramid   :='Piramis';
  TeeMsg_Ellipse   :='Ellipszis';
  TeeMsg_InvPyramid:='Inverz Piramis';
  TeeMsg_Sides     :='Oldalak';
  TeeMsg_SideAll   :='Minden oldal';
  TeeMsg_Patterns  :='Mintázás';
  TeeMsg_Exploded  :='Robbantott';
  TeeMsg_Shadow    :='Árnyék';
  TeeMsg_SemiPie   :='Fél kördiagram';
  TeeMsg_Rectangle :='Téglalap';
  TeeMsg_VertLine  :='Függ. vonal';
  TeeMsg_HorizLine :='Vízsz. vonal';
  TeeMsg_Line      :='Vonal';
  TeeMsg_Cube      :='Kocka';
  TeeMsg_DiagCross :='Átlós kereszt';

  TeeMsg_CanNotFindTempPath    :='Nem található Temp mappa';
  TeeMsg_CanNotCreateTempChart :='Nem hozható létre Temp fájl';
  TeeMsg_CanNotEmailChart      :='Nem küldhetõ email a TeeChart-hoz. Mapi Error: %d';

  TeeMsg_SeriesDelete :='Sor törlés: %d értékindexe tiltott területen (0-tól %d-ig).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='&JPEG-ként';
  TeeMsg_JPEGFilter    :='JPEG fájlok (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='&GIF-ként';
  TeeMsg_GIFFilter     :='GIF fájlok (*.gif)|*.gif';
  TeeMsg_AsPNG         :='&PNG-ként';
  TeeMsg_PNGFilter     :='PNG fájlok (*.png)|*.png';
  TeeMsg_AsPCX         :='PC&X-ként';
  TeeMsg_PCXFilter     :='PCX fájlok (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Nyelvek...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Poláris';
  TeeMsg_GalleryCandle      :='Gyertya';
  TeeMsg_GalleryVolume      :='Erõsség';
  TeeMsg_GallerySurface     :='Felület';
  TeeMsg_GalleryContour     :='Kontúr';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D-s pont';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Kurzor';
  TeeMsg_GalleryBar3D       :='3D-s sáv';
  TeeMsg_GalleryBigCandle   :='Nagy gyertya';
  TeeMsg_GalleryLinePoint   :='Vonal pont';
  TeeMsg_GalleryHistogram   :='Hisztogram';
  TeeMsg_GalleryWaterFall   :='Vízszintes';
  TeeMsg_GalleryWindRose    :='Szélrózsa';
  TeeMsg_GalleryClock       :='Óra';
  TeeMsg_GalleryColorGrid   :='Színrács';
  TeeMsg_GalleryBoxPlot     :='Cellafelosztás ';
  TeeMsg_GalleryHorizBoxPlot:='Vízsz. cellafelosztás';
  TeeMsg_GalleryBarJoin     :='Sáv illesztési hely';
  TeeMsg_GallerySmith       :='Kovács';
  TeeMsg_GalleryPyramid     :='Piramis';
  TeeMsg_GalleryMap         :='Térkép';

  TeeMsg_PolyDegreeRange    :='Polinom foknak 1 és 20 között kell lennie';
  TeeMsg_AnswerVectorIndex   :='A válasz vektor indexének 1 és %d között kell lennie';
  TeeMsg_FittingError        :='Nem lehet megfelelõen feldolgozni';
  TeeMsg_PeriodRange         :='A szakasz legyen >= 0';
  TeeMsg_ExpAverageWeight    :='Az ExpAverage súlya legyen 0 és 1 között';
  TeeMsg_GalleryErrorBar     :='Sávhiba';
  TeeMsg_GalleryError        :='Hiba';
  TeeMsg_GalleryHighLow      :='Magas-alacsony';
  TeeMsg_FunctionMomentum    :='Lendület';
  TeeMsg_FunctionMomentumDiv :='Lendület Eltérés';
  TeeMsg_FunctionExpAverage  :='Exponenciális átlag';
  TeeMsg_FunctionMovingAverage:='Mozgási átlag';
  TeeMsg_FunctionExpMovAve   :='Exp.Mozg.Átlag';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Görbe illesztés';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Halmozott';
  TeeMsg_FunctionStdDeviation:='Szabványos elhajlás';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Négyzetes középérték';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Véletlenszerû';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Mennyiség';
  TeeMsg_LoadChart           :='TeeChart megnyitás...';
  TeeMsg_SaveChart           :='TeeChart mentés...';
  TeeMsg_TeeFiles            :='TeeChart Pro fájlok';

  TeeMsg_GallerySamples      :='Egyéb ';
  TeeMsg_GalleryStats        :='Statisztikák';

  TeeMsg_CannotFindEditor    :='Nem található a sorozat szerkesztõ ûrlap: %s';


  TeeMsg_CannotLoadChartFromURL:='Hibakód: %d grafikon letöltése a %s URL-rõl';
  TeeMsg_CannotLoadSeriesDataFromURL:='Hibakód: %d soradatok letöltése a %s URL-rõl';

  TeeMsg_Test                :='Teszt...';

  TeeMsg_ValuesDate          :='Dátum';
  TeeMsg_ValuesOpen          :='Megnyitás';
  TeeMsg_ValuesHigh          :='Magas';
  TeeMsg_ValuesLow           :='Alacsony';
  TeeMsg_ValuesClose         :='Bezárás';
  TeeMsg_ValuesOffset        :='Eltolás';
  TeeMsg_ValuesStdError      :='Szabvány hiba';

  TeeMsg_Grid3D              :='3D-s rács';

  TeeMsg_LowBezierPoints     :='A Bezier-pontok száma legyen > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Szabályos';
  TeeCommanMsg_Edit     :='Szerkesztés';
  TeeCommanMsg_Print    :='Nyomtatás';
  TeeCommanMsg_Copy     :='MásolásCopy';
  TeeCommanMsg_Save     :='Mentés';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Elforgatás: %d° Emelkedés: %d°';
  TeeCommanMsg_Rotate   :='Elforgatás';

  TeeCommanMsg_Moving   :='Vízszintes eltolás: %d Függõleges eltolás: %d';
  TeeCommanMsg_Move     :='Mozgatás';

  TeeCommanMsg_Zooming  :='Közelítés: %d %%';
  TeeCommanMsg_Zoom     :='Közelítés';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Mélység';

  TeeCommanMsg_Chart    :='Grafikon';
  TeeCommanMsg_Panel    :='Tábla';

  TeeCommanMsg_RotateLabel:='Elforgatás %s-al';
  TeeCommanMsg_MoveLabel  :='Mozgatás %s-al';
  TeeCommanMsg_ZoomLabel  :='Közelítés %s-al';
  TeeCommanMsg_DepthLabel :='3D-s újraméretezés %s-al';

  TeeCommanMsg_NormalLabel:='Közelítéshez a bal gombbal, görgetés a jobb gombbal';
  TeeCommanMsg_NormalPieLabel:='Körszeletek húzása robbantáshoz';

  TeeCommanMsg_PieExploding :='Körszelet: %d Robbantás: %d %%';

  TeeMsg_TriSurfaceLess        :='A pontok száma legyen >= 4';
  TeeMsg_TriSurfaceAllColinear :='Minen kolineáris adatpont';
  TeeMsg_TriSurfaceSimilar     :='Hasonló pontok - Nem végrehajtható';
  TeeMsg_GalleryTriSurface     :='Háromszög felszín';

  TeeMsg_AllSeries :='Minden sor';
  TeeMsg_Edit      :='Szerkesztés';

  TeeMsg_GalleryFinancial    :='Pénzügy';

  TeeMsg_CursorTool    :='Kurzor';
  TeeMsg_DragMarksTool :='Jelölések húzása';
  TeeMsg_AxisArrowTool :='Tengely nyíl';
  TeeMsg_DrawLineTool  :='Vonal rajzolás';
  TeeMsg_NearestTool   :='Legközelebbi pont';
  TeeMsg_ColorBandTool :='Oszlopszín';
  TeeMsg_ColorLineTool :='Vonalszín';
  TeeMsg_RotateTool    :='Elforgatás';
  TeeMsg_ImageTool     :='Kép';
  TeeMsg_MarksTipTool  :='Jelölési tippek';

  TeeMsg_CantDeleteAncestor  :='Az elõd nem törölhetõ';

  TeeMsg_Load	          :='Betöltés...';
  TeeMsg_NoSeriesSelected :='Nincs sor kiválasztva';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafikon';
  TeeMsg_CategorySeriesActions :='Grafikon sorok';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Váltás 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktív';
  TeeMsg_ActionSeriesActiveHint := 'Sorokat mutat / elrejt';
  TeeMsg_ActionEditHint         := 'Grafikon szerkesztés';
  TeeMsg_ActionEdit             := '&Szerkesztés...';
  TeeMsg_ActionCopyHint         := 'Másolás vágólapra';
  TeeMsg_ActionCopy             := '&Másolás';
  TeeMsg_ActionPrintHint        := 'Grafikon nyomtatási kép';
  TeeMsg_ActionPrint            := '&Nyomtatás...';
  TeeMsg_ActionAxesHint         := 'Tengelyeket mutat / elrejt';
  TeeMsg_ActionAxes             := '&Tengelyek';
  TeeMsg_ActionGridsHint        := 'Rácsot mutat / elrejt';
  TeeMsg_ActionGrids            := '&Rácsvonalak';
  TeeMsg_ActionLegendHint       := 'Jelmagyarzáatot mutat / elrejt';
  TeeMsg_ActionLegend           := '&Jelmagyarázat';
  TeeMsg_ActionSeriesEditHint   := 'Sorok szerkesztése';
  TeeMsg_ActionSeriesMarksHint  := 'Sor-jelölést mutat / elrejt';
  TeeMsg_ActionSeriesMarks      := '&Jelölések';
  TeeMsg_ActionSaveHint         := 'Grafikon mentés';
  TeeMsg_ActionSave             := '&Mentés...';

  TeeMsg_CandleBar              := 'Sáv';
  TeeMsg_CandleNoOpen           := 'Nincs megnyitás';
  TeeMsg_CandleNoClose          := 'Nincs bezárás';
  TeeMsg_NoLines                := 'Nincsenek vonalak';
  TeeMsg_NoHigh                 := 'Nincs magasság';
  TeeMsg_NoLow                  := 'Nincs mélység';
  TeeMsg_ColorRange             := 'Színskála';
  TeeMsg_WireFrame              := 'Fémkeret';
  TeeMsg_DotFrame               := 'Pontozott keret';
  TeeMsg_Positions              := 'Elhelyezés';
  TeeMsg_NoGrid                 := 'Nincs rácsvonal';
  TeeMsg_NoPoint                := 'Nincs pont';
  TeeMsg_NoLine                 := 'Nincs vonal';
  TeeMsg_Labels                 := 'Feliratok';
  TeeMsg_NoCircle               := 'Nincs kör';
  TeeMsg_Lines                  := 'Vonalak';
  TeeMsg_Border                 := 'Szegély';

  TeeMsg_SmithResistance      := 'Ellenállás';
  TeeMsg_SmithReactance       := 'Reaktív ellenállás';

  TeeMsg_Column               := 'Oszlop';

  { 5.01 }
  TeeMsg_Separator            := 'Elválasztójel';
  TeeMsg_FunnelSegment        := 'Szegmens ';
  TeeMsg_FunnelSeries         := 'Tölcsér';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Kvótán kívül';
  TeeMsg_FunnelWithin         := ' kvótán belül';
  TeeMsg_FunnelBelow          := ' vagy inkább kvótán belül';
  TeeMsg_CalendarSeries       := 'Naptár';
  TeeMsg_DeltaPointSeries     := 'Delta Pont';
  TeeMsg_ImagePointSeries     := 'Képpont';
  TeeMsg_ImageBarSeries       := 'Sáv képe';
  TeeMsg_SeriesTextFieldZero  := 'Sor szövege: A mezõindex legyen nagyobb, mint 0.';

  { 5.02 }
  TeeMsg_Origin               := 'Origó';
  TeeMsg_Transparency         := 'Átlátszóság';
  TeeMsg_Box		      := 'Doboz';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Oldalszám';

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

//6.0

// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='&PDF fájlként';
  TeeMsg_PDFFilter        :='PDF fájlok (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='PostScript fájlként';
  TeeMsg_PSFilter         :='PostScript fájlok (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Vízszintes'#13'terület';
  TeeMsg_SelfStack        :='Pakolt';
  TeeMsg_DarkPen          :='Sötét szegély';
  TeeMsg_SelectFolder     :='Adatbázis könyvtár';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Kapcsolat:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Simítás';
  TeeMsg_FunctionCross        :='metszéspontok';
  TeeMsg_GridTranspose        :='3D rács transzponálás';
  TeeMsg_FunctionCompress     :='Tömörítés';
  TeeMsg_ExtraLegendTool      :='Extra jelmagyarázat';
  TeeMsg_FunctionCLV          :='Szoros helyi'#13'érték';
  TeeMsg_FunctionOBV          :='kiegyenlített'#13'mennyiség';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Mennyiség'#13'oszcillátor';
  TeeMsg_SeriesAnimTool       :='Széria animálás';
  TeeMsg_GalleryPointFigure   :='Pont és alakzat';
  TeeMsg_Up                   :='Fel';
  TeeMsg_Down                 :='Le';
  TeeMsg_GanttTool            :='Gantt eszköz';
  TeeMsg_XMLFile              :='XML fájl';
  TeeMsg_GridBandTool         :='Rács sáv eszköz';
  TeeMsg_FunctionPerf         :='Hatékonyság';
  TeeMsg_GalleryGauge         :='Mérõeszköz';
  TeeMsg_GalleryGauges        :='Mérõeszközök';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='3D Vektor';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torony';
  TeeMsg_SingleColor          :='Egyszínû';
  TeeMsg_Cover                :='Borítás';
  TeeMsg_Cone                 :='Kúp';
  TeeMsg_PieTool              :='Tortaszelet';
end;

Procedure TeeCreateHungarian;
begin
  if not Assigned(TeeHungarianLanguage) then
  begin
    TeeHungarianLanguage:=TStringList.Create;
    TeeHungarianLanguage.Text:=

'GRADIENT EDITOR=Színátmenet Szerkesztõ'#13+
'GRADIENT=Színátmenet'#13+
'DIRECTION=Irány'#13+
'VISIBLE=Látható'#13+
'TOP BOTTOM=Fentrõl Le'#13+
'BOTTOM TOP=Lentrõl Fel'#13+
'LEFT RIGHT=Balról Jobbra'#13+
'RIGHT LEFT=Jobbról Balra'#13+
'FROM CENTER=Középrõl'#13+
'FROM TOP LEFT=Bal felsõ sarokból'#13+
'FROM BOTTOM LEFT=Bal alsó sarokból'#13+
'OK=Rendben'#13+
'CANCEL=Mégsem'#13+
'COLORS=Színek'#13+
'START=Kezdõszín'#13+
'MIDDLE=Középszín'#13+
'END=Befej. szín'#13+
'SWAP=Felcserél'#13+
'NO MIDDLE=Nincs középszín'#13+
'TEEFONT EDITOR=TEECHART betûszerkesztõ'#13+
'INTER-CHAR SPACING=Betûtávolság'#13+
'FONT=Betûtípus'#13+
'SHADOW=Árnyék'#13+
'HORIZ. SIZE=Vízsz. méret'#13+
'VERT. SIZE=Függ. méret'#13+
'COLOR=Szín'#13+
'OUTLINE=Körvonal'#13+
'OPTIONS=Beállítások'#13+
'FORMAT=Formátum'#13+
'TEXT=Szöveg'#13+
'POSITION=Elhelyezés'#13+
'LEFT=Baloldalt'#13+
'TOP=Felül'#13+
'AUTO=Automata'#13+
'CUSTOM=Egyedi'#13+
'LEFT TOP=Balra fent'#13+
'LEFT BOTTOM=Balra lent'#13+
'RIGHT TOP=Jobbra fent'#13+
'RIGHT BOTTOM=Jobbra lent'#13+
'MULTIPLE AREAS=Többszörös felszín'#13+
'NONE=Üres'#13+
'STACKED=Halom'#13+
'STACKED 100%=100%-os halom'#13+
'AREA=Terület'#13+
'PATTERN=Mintázat'#13+
'STAIRS=Lépcsõk'#13+
'SOLID=Egyszínû'#13+
'CLEAR=Üres'#13+
'HORIZONTAL=Vízszintes'#13+
'VERTICAL=Függõleges'#13+
'DIAGONAL=Átló'#13+
'B.DIAGONAL=Fordított átló'#13+
'CROSS=Kereszt'#13+
'DIAG.CROSS=Átlós kereszt'#13+
'AREA LINES=Felszín-von.'#13+
'BORDER=Szegély'#13+
'INVERTED=Inverz'#13+
'COLOR EACH=Minden szín'#13+
'ORIGIN=Forrás'#13+
'USE ORIGIN=Forrás használva'#13+
'WIDTH=Szélesség'#13+
'HEIGHT=Magasság'#13+
'AXIS=Tengely'#13+
'LENGTH=Hosszúság'#13+
'SCROLL=Görgetés'#13+
'BOTH=Mindkettõ'#13+
'AXIS INCREMENT=Osztásjelek'#13+
'INCREMENT=Lépés-egység'#13+
'STANDARD=Átlag'#13+
'ONE MILLISECOND=Egy Milimásodperc'#13+
'ONE SECOND=Egy másodperc'#13+
'FIVE SECONDS=Öt másodperc'#13+
'TEN SECONDS=Tíz másodperc'#13+
'FIFTEEN SECONDS=Tizenöt másodperc'#13+
'THIRTY SECONDS=Harminc másodperc'#13+
'ONE MINUTE=Egy perc'#13+
'FIVE MINUTES=Öt perc'#13+
'TEN MINUTES=Tíz perc'#13+
'FIFTEEN MINUTES=Tizenöt perc'#13+
'THIRTY MINUTES=Harminc perc'#13+
'ONE HOUR=Egy óra'#13+
'TWO HOURS=Két óra'#13+
'SIX HOURS=Hat óra'#13+
'TWELVE HOURS=Tizenkét óra'#13+
'ONE DAY=Egy nap'#13+
'TWO DAYS=Két nap'#13+
'THREE DAYS=Három nap'#13+
'ONE WEEK=Egy hét'#13+
'HALF MONTH=Fél hónap'#13+
'ONE MONTH=Egy hónap'#13+
'TWO MONTHS=Két hónap'#13+
'THREE MONTHS=Három hónap'#13+
'FOUR MONTHS=Négy hónap'#13+
'SIX MONTHS=Hat hónap'#13+
'ONE YEAR=Egy év'#13+
'EXACT DATE TIME=Pontos dátum'#13+
'AXIS MAXIMUM AND MINIMUM=Tengely maximum és minimum'#13+
'VALUE=Érték'#13+
'TIME=Idõ'#13+
'LEFT AXIS=Bal tengely'#13+
'RIGHT AXIS=Jobb tengely'#13+
'TOP AXIS=Felsõ tengely'#13+
'BOTTOM AXIS=Alsó tengely'#13+
'% BAR WIDTH=% Sávszélesség'#13+
'STYLE=Stílus'#13+
'% BAR OFFSET=Sáv eltolás %-a'#13+
'RECTANGLE=Téglalap'#13+
'PYRAMID=Piramis'#13+
'INVERT. PYRAMID=Inverz piramis'#13+
'CYLINDER=Henger'#13+
'ELLIPSE=Ellipszis'#13+
'ARROW=Nyíl'#13+
'RECT. GRADIENT=Négyszögû színátmenet'#13+
'CONE=Kúp'#13+
'DARK BAR 3D SIDES=Sötét  3D sáv'#13+
'BAR SIDE MARGINS=Sávszélesség'#13+
'AUTO MARK POSITION=Automatikusan jelölt pozíció'#13+
'JOIN=Illesztés'#13+
'DATASET=Adatállomány'#13+
'APPLY=Alkalmaz'#13+
'SOURCE=Forrás'#13+
'MONOCHROME=Egyszínû'#13+
'DEFAULT=Alapértelmezett'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Középérték'#13+
'WHISKER=Hajlítás'#13+
'PATTERN COLOR EDITOR=Színpaletta szerkesztés'#13+
'IMAGE=Kép'#13+
'BACK DIAGONAL=Fordított átló'#13+
'DIAGONAL CROSS=Átlós kereszt'#13+
'FILL 80%=80% kitöltve'#13+
'FILL 60%=60% kitöltve'#13+
'FILL 40%=40% kitöltve'#13+
'FILL 20%=20% kitöltve'#13+
'FILL 10%=10% kitöltve'#13+
'ZIG ZAG=Cikk-cakkos'#13+
'VERTICAL SMALL=Függõleges, kicsi'#13+
'HORIZ. SMALL=Vízszintes, kicsi'#13+
'DIAG. SMALL=Átlós, kicsi'#13+
'BACK DIAG. SMALL=Hátsó átló, kicsi'#13+
'CROSS SMALL=Kereszt, kicsi'#13+
'DIAG. CROSS SMALL=Átlós kereszt, kicsi'#13+
'DAYS=Napok'#13+
'WEEKDAYS=Hét napjai'#13+
'TODAY=Ma'#13+
'SUNDAY=Vasárnap'#13+
'TRAILING=Átnyúlás'#13+
'MONTHS=Hónapok'#13+
'LINES=Vonalak'#13+
'SHOW WEEKDAYS=Hét napjai'#13+
'UPPERCASE=Nagybetûs'#13+
'TRAILING DAYS=Átnyúló napok'#13+
'SHOW TODAY=Mai nap'#13+
'SHOW MONTHS=Hónap'#13+
'CANDLE WIDTH=Gyertya-szélesség'#13+
'STICK=Pálca'#13+
'BAR=Sáv'#13+
'OPEN CLOSE=Nyit zár'#13+
'UP CLOSE=Emelkedve zár'#13+
'DOWN CLOSE=Süllyedve zár'#13+
'SHOW OPEN=Nyitást mutat'#13+
'SHOW CLOSE=Zárást mutat'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D Sötét'#13+
'EDITING=Szerkesztés'#13+
'CHART=Grafikon'#13+
'SERIES=Sorok'#13+
'DATA=Adatok'#13+
'TOOLS=Eszközök'#13+
'EXPORT=Export'#13+
'PRINT=Nyomtatás'#13+
'GENERAL=Általános'#13+
'TITLES=Címek'#13+
'LEGEND=Jelmagyar.'#13+
'PANEL=Panel'#13+
'PAGING=Oldalak'#13+
'WALLS=Falak'#13+
'3D=3D'#13+
'ADD=Hozzáad'#13+
'DELETE=Törlés'#13+
'TITLE=Cím'#13+
'CLONE=Klónozás'#13+
'CHANGE=Módosítás'#13+
'HELP=Segítség'#13+
'CLOSE=Bezár'#13+
'TEECHART PRINT PREVIEW=TeeChart Nyomtatási kép'#13+
'PRINTER=Nyomtató'#13+
'SETUP=Telepítés'#13+
'ORIENTATION=Igazítás'#13+
'PORTRAIT=Állókép'#13+
'LANDSCAPE=Fekvõkép'#13+
'MARGINS (%)=Margók (%)'#13+
'DETAIL=Részletek'#13+
'MORE=Egyebek'#13+
'NORMAL=Szokásos'#13+
'RESET MARGINS=Margók visszaál.'#13+
'VIEW MARGINS=Margók megtek.'#13+
'PROPORTIONAL=Arányok'#13+
'CIRCLE=Kör'#13+
'VERTICAL LINE=Függõleges vonal'#13+
'HORIZ. LINE=Vízszintes vonal'#13+
'TRIANGLE=Háromszög'#13+
'INVERT. TRIANGLE=Inverz háromszög'#13+
'LINE=Vonal'#13+
'DIAMOND=Rombusz'#13+
'CUBE=Kocka'#13+
'STAR=Csillag'#13+
'TRANSPARENT=Átlátszó'#13+
'HORIZ. ALIGNMENT=Vízszintes igazítás'#13+
'CENTER=Közép'#13+
'RIGHT=Jobb'#13+
'ROUND RECTANGLE=Kerekített négyszög'#13+
'ALIGNMENT=Igazítás'#13+
'BOTTOM=Lent'#13+
'UNITS=Elemek'#13+
'PIXELS=Képpontok'#13+
'AXIS ORIGIN=Origó'#13+
'ROTATION=Elforgatás'#13+
'CIRCLED=Körvonal'#13+
'3 DIMENSIONS=3 dimenziós'#13+
'RADIUS=Sugár'#13+
'ANGLE INCREMENT=Szög nagyítás'#13+
'RADIUS INCREMENT=Sugár nagyítás'#13+
'CLOSE CIRCLE=Zárt kör'#13+
'PEN=Toll'#13+
'LABELS=Feliratok'#13+
'ROTATED=Elforgatott'#13+
'CLOCKWISE=Órajárás irányában'#13+
'INSIDE=Belül'#13+
'ROMAN=Roman'#13+
'HOURS=Órák'#13+
'MINUTES=Percek'#13+
'SECONDS=Másodpercek'#13+
'START VALUE:=Kezdõérték:'#13+
'END VALUE=Befejezõ érték'#13+
'TRANSPARENCY=Átlátszóság'#13+
'DRAW BEHIND=Mögé rajzol'#13+
'COLOR MODE=Szinezési mód'#13+
'STEPS=Lépések'#13+
'RANGE=Terület'#13+
'PALETTE=Paletta'#13+
'PALE=Halvány'#13+
'STRONG=Erõs'#13+
'GRID SIZE=Rács mérete'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Mélység'#13+
'IRREGULAR=Szabálytalan'#13+
'GRID=Rács'#13+
'VALUE:=Érték:'#13+
'ALLOW DRAG=Vonszolás engedélyezve'#13+
'VERTICAL POSITION=Függõleges helyzet'#13+
'LEVELS POSITION=Szintek helyzete'#13+
'LEVELS=Szintek'#13+
'NUMBER=Mennyiség'#13+
'LEVEL=Szint'#13+
'AUTOMATIC=Autom.'#13+
'SNAP=Lekap'#13+
'FOLLOW MOUSE=Egér követése'#13+
'STACK=Halom'#13+
'HEIGHT 3D=3D magasság'#13+
'LINE MODE=Vonal mód'#13+
'OVERLAP=Átfedés'#13+
'STACK 100%=100%-os halom'#13+
'CLICKABLE=Kattintható'#13+
'AVAILABLE=Rendelkezésre álló'#13+
'SELECTED:=Kiválasztva:'#13+
'DATASOURCE=Adatforrás'#13+
'GROUP BY=Csoportosítás'#13+
'CALC=Számítás'#13+
'OF=Közül'#13+
'SUM=Összeg'#13+
'COUNT=Számol'#13+
'HIGH=Magasg'#13+
'LOW=Alacsony'#13+
'AVG=Átlag'#13+
'HOUR=Óra'#13+
'DAY=Nap'#13+
'WEEK=Hét'#13+
'WEEKDAY=Hét napja'#13+
'MONTH=Hónap'#13+
'QUARTER=Négyzet'#13+
'YEAR=Év'#13+
'HOLE %:=Lyuk %:'#13+
'RESET POSITIONS=Helyzet visszaállítása'#13+
'MOUSE BUTTON=Egérgomb'#13+
'ENABLE DRAWING=Rajzolás engedélyezve'#13+
'ENABLE SELECT=Kiválasztás engedélyezve'#13+
'ENHANCED=Növelés'#13+
'ERROR WIDTH=Hibás szélesség'#13+
'WIDTH UNITS=Szélesség egység'#13+
'PERCENT=Százalék'#13+
'LEFT AND RIGHT=Bal és jobb'#13+
'TOP AND BOTTOM=Fent és lent'#13+
'BORDER EDITOR=Szegély szerkesztõ'#13+
'DASH=Kötõjelek'#13+
'DOT=Pontok'#13+
'DASH DOT=Kötõjel-pont'#13+
'DASH DOT DOT=Kötõjel-két pont'#13+
'CALCULATE EVERY=Mindent számol'#13+
'ALL POINTS=Minden pont'#13+
'NUMBER OF POINTS=Pontok száma'#13+
'RANGE OF VALUES=Értékhatár'#13+
'FIRST=Elsõ'#13+
'LAST=Utolsó'#13+
'TEEPREVIEW EDITOR=TeeLátvány szerkesztõ'#13+
'ALLOW MOVE=Mozgatás engedélyezve'#13+
'ALLOW RESIZE=Átméretezés engedélyezve'#13+
'DRAG IMAGE=Ábra vonszolás'#13+
'AS BITMAP=Bitmap-ként'#13+
'SHOW IMAGE=Ábrát mutat'#13+
'MARGINS=Margók'#13+
'SIZE=Méret'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Emelkedés'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Vízszintes eltolás'#13+
'VERT. OFFSET=Függõleges eltolás'#13+
'PERSPECTIVE=Távlati kép'#13+
'ANGLE=Szög'#13+
'ORTHOGONAL=Derékszögû'#13+
'ZOOM TEXT=Szöveg-közelítés'#13+
'SCALES=Skálázás'#13+
'TICKS=Jelölés'#13+
'MINOR=Kisebb'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Lépésköz'#13+
'(INCREMENT)=(növekedés)'#13+
'LOG BASE=Logaritmus alapja'#13+
'LOGARITHMIC=Logaritmikus'#13+
'MIN. SEPARATION %=Min. elválasztás %'#13+
'MULTI-LINE=Több sor'#13+
'LABEL ON AXIS=Tengely-felirat'#13+
'ROUND FIRST=Elsõ kör'#13+
'MARK=Jelölés'#13+
'LABELS FORMAT=Felirat formátum'#13+
'EXPONENTIAL=Exponenciális'#13+
'DEFAULT ALIGNMENT=Alapértelmezett igazítás'#13+
'LEN=Hossz'#13+
'INNER=Belsõ'#13+
'AT LABELS ONLY=Csak Feliraton'#13+
'CENTERED=Középen'#13+
'POSITION %=Pozíció %'#13+
'START %=Kezdõ %'#13+
'END %=Befejezõ %'#13+
'OTHER SIDE=Másik oldal'#13+
'AXES=Tengelyek'#13+
'BEHIND=Hátul'#13+
'CLIP POINTS=Illesztõpontok'#13+
'PRINT PREVIEW=Nyomtatási kép'#13+
'MINIMUM PIXELS=Képpontok minimum'#13+
'ALLOW=Engedély'#13+
'ANIMATED=Animált'#13+
'ALLOW SCROLL=Görgetés'#13+
'TEEOPENGL EDITOR=TeeOpenGL Szerkesztõ'#13+
'AMBIENT LIGHT=Környezet'#13+
'SHININESS=Fényesség'#13+
'FONT 3D DEPTH=3D Betûmélység'#13+
'ACTIVE=Aktív'#13+
'FONT OUTLINES=Betû körvonal'#13+
'SMOOTH SHADING=Egyenletes árnyékolás'#13+
'LIGHT=Fényerõ'#13+
'Y=Y'#13+
'INTENSITY=Intenzitás'#13+
'BEVEL=Süllyesztett keret'#13+
'FRAME=Keret'#13+
'ROUND FRAME=Kerekített keret'#13+
'LOWERED=Hátra'#13+
'RAISED=Elõre'#13+
'SYMBOLS=Szimbólum'#13+
'TEXT STYLE=Szövegstílus'#13+
'LEGEND STYLE=Jelmagyarázat stílus'#13+
'VERT. SPACING=Függ. térköz'#13+
'SERIES NAMES=Sor-nevek'#13+
'SERIES VALUES=Sor-értékek'#13+
'LAST VALUES=Utolsó érték'#13+
'PLAIN=Sima'#13+
'LEFT VALUE=Bal, érték'#13+
'RIGHT VALUE=Jobb, érték'#13+
'LEFT PERCENT=Bal, százalék'#13+
'RIGHT PERCENT=Jobb, százalék'#13+
'X VALUE=X érték'#13+
'X AND VALUE=X és érték'#13+
'X AND PERCENT=X és százalék'#13+
'CHECK BOXES=Ellenõrzõ gomb'#13+
'DIVIDING LINES=Választóvonalak'#13+
'FONT SERIES COLOR=Betûsor színe'#13+
'POSITION OFFSET %=Helyzet eltolás %-a'#13+
'MARGIN=Szegély'#13+
'RESIZE CHART=Grafikont újraméretez'#13+
'CONTINUOUS=Folyamatos'#13+
'POINTS PER PAGE=Pontok oldalanként'#13+
'SCALE LAST PAGE=Utolsó oldalt feloszt'#13+
'CURRENT PAGE LEGEND=Aktuális jelmagyarázat'#13+
'PANEL EDITOR=Háttér szerkesztõ'#13+
'BACKGROUND=Háttér'#13+
'BORDERS=Keretek'#13+
'BACK IMAGE=Háttérkép'#13+
'STRETCH=Nyújtás'#13+
'TILE=Kitöltés'#13+
'BEVEL INNER=Belsõ süllyesz.'#13+
'BEVEL OUTER=Külsõ süllyesz.'#13+
'MARKS=Jelölések'#13+
'DATA SOURCE=Adatforrás'#13+
'SORT=Válogatás'#13+
'CURSOR=Kurzor'#13+
'SHOW IN LEGEND=Látható a jelmagyar.'#13+
'FORMATS=Formátumok'#13+
'VALUES=Érték'#13+
'PERCENTS=Százalékok'#13+
'HORIZONTAL AXIS=Vízszintes tengely'#13+
'DATETIME=Dátum-Idõ'#13+
'VERTICAL AXIS=Függõleges tengely'#13+
'ASCENDING=Emelkedõ'#13+
'DESCENDING=Csökkenõ'#13+
'DRAW EVERY=Húz mindent'#13+
'CLIPPED=Levág'#13+
'ARROWS=Nyilak'#13+
'MULTI LINE=Többszörös sor'#13+
'ALL SERIES VISIBLE=Minden sor látható'#13+
'LABEL=Felirat'#13+
'LABEL AND PERCENT=Felirat és százalék'#13+
'LABEL AND VALUE=Felirat és érték'#13+
'PERCENT TOTAL=Százalék összesen'#13+
'LABEL AND PERCENT TOTAL=Felirat és százalékérték'#13+
'X AND Y VALUES=X és Y érték'#13+
'MANUAL=Manuális'#13+
'RANDOM=Véletlenszerû'#13+
'FUNCTION=Függvény'#13+
'NEW=Új'#13+
'EDIT=Szerkesztés'#13+
'PERSISTENT=Folytonos'#13+
'ADJUST FRAME=Keretek igazítása'#13+
'SUBTITLE=Alcím'#13+
'SUBFOOT=Lábjegyzet 2'#13+
'FOOT=2. Lábjegyzet'#13+
'VISIBLE WALLS=Falak láthatók'#13+
'BACK=Hátra'#13+
'DIF. LIMIT=Különbség határa'#13+
'ABOVE=Fent'#13+
'WITHIN=Belül'#13+
'BELOW=Alul'#13+
'CONNECTING LINES=Kapcsolódó vonalak'#13+
'BROWSE=Böngészés'#13+
'TILED=Kitöltve'#13+
'INFLATE MARGINS=Növelt szegélyek'#13+
'SQUARE=Kocka'#13+
'DOWN TRIANGLE=Alsó háromszög'#13+
'SMALL DOT=Kis pont'#13+
'GLOBAL=Globális'#13+
'SHAPES=Alakzatok'#13+
'BRUSH=Ecset'#13+
'DELAY=Késés'#13+
'MSEC.=ms'#13+
'MOUSE ACTION=Egérmûvelet'#13+
'MOVE=Mozgatás'#13+
'CLICK=Kattintás'#13+
'DRAW LINE=Vonal húzás'#13+
'EXPLODE BIGGEST=Legnagyobb méretû'#13+
'TOTAL ANGLE=Szögek össz.'#13+
'GROUP SLICES=Szelet-csoportok'#13+
'BELOW %=Alatta, %'#13+
'BELOW VALUE=Alatta, érték'#13+
'OTHER=Egyéb'#13+
'PATTERNS=Minták'#13+
'SIZE %=Méret %'#13+
'SERIES DATASOURCE TEXT EDITOR=Adatforrás szövegszerkesztõ'#13+
'FIELDS=Mezõk'#13+
'NUMBER OF HEADER LINES=Fejléc száma'#13+
'SEPARATOR=Elválasztás'#13+
'COMMA=Vesszõ'#13+
'SPACE=Szóköz'#13+
'TAB=Tabulátor'#13+
'FILE=Fájl'#13+
'WEB URL=Web URL'#13+
'LOAD=Betöltés'#13+
'C LABELS=C Feliratok'#13+
'R LABELS=R Feliratok'#13+
'C PEN=C toll'#13+
'R PEN=R toll'#13+
'STACK GROUP=Halomcsoport'#13+
'MULTIPLE BAR=Többszörös sáv'#13+
'SIDE=Egymás mellett'#13+
'SIDE ALL=Mind egymás mellett'#13+
'DRAWING MODE=Rajzolás mód'#13+
'WIREFRAME=Rácsháló'#13+
'DOTFRAME=Pont-háló'#13+
'SMOOTH PALETTE=Sima paletta'#13+
'SIDE BRUSH=Oldalecset'#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Látogasd meg honlapunkat !'#13+
'TEECHART WIZARD=TeeChart Varázsló'#13+
'SELECT A CHART STYLE=Grafikon-stílus választás'#13+
'DATABASE CHART=Adatbázis grafikon'#13+
'NON DATABASE CHART=Nem adatbázis grafikon'#13+
'SELECT A DATABASE TABLE=Adatbázis tábla kiválasztás'#13+
'ALIAS=Alias'#13+
'TABLE=Tábla'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Kívánt mezõ választása a grafikonhoz'#13+
'SELECT A TEXT LABELS FIELD=Felirat-mezõ választása'#13+
'CHOOSE THE DESIRED CHART TYPE=Kívánt grafikontípus választása'#13+
'2D=2D'#13+
'CHART PREVIEW=Grafikon nyomtatási kép'#13+
'SHOW LEGEND=Jelmagyar. mutat'#13+
'SHOW MARKS=Jegyzetek megtek.'#13+
'< BACK=< Elõzõ'#13+
'EXPORT CHART=Grafikon exportálás'#13+
'PICTURE=Kép'#13+
'NATIVE=Eredeti'#13+
'KEEP ASPECT RATIO=Elhelyezési arányokat megtart'#13+
'INCLUDE SERIES DATA=Adatsorral együtt'#13+
'FILE SIZE=Fájl méret'#13+
'DELIMITER=Határolójel'#13+
'XML=XML'#13+
'HTML TABLE=HTML Táblázat'#13+
'EXCEL=Excel'#13+
'COLON=Kettõspont'#13+
'INCLUDE=Tartalmaz'#13+
'POINT LABELS=Pont feliratok'#13+
'POINT INDEX=Pontok indexe'#13+
'HEADER=Fejléc'#13+
'COPY=Másolás'#13+
'SAVE=Mentés'#13+
'SEND=Küldés'#13+
'FUNCTIONS=Függvények'#13+
'ADX=ADX'#13+
'AVERAGE=Átlag'#13+
'BOLLINGER=Osztás'#13+
'DIVIDE=Oszt'#13+
'EXP. AVERAGE=Kifejtett átlag'#13+
'EXP.MOV.AVRG.=Kifejtett mozgó átlag'#13+
'MACD=MACD'#13+
'MOMENTUM=Növekedés'#13+
'MOMENTUM DIV=Növekedéssel oszt'#13+
'MOVING AVRG.=Mozgó átlag'#13+
'MULTIPLY=Szorzás'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Négyzetes középérték'#13+
'STD.DEVIATION=Kivont eltérés'#13+
'STOCHASTIC=Véletlenszerû'#13+
'SUBTRACT=Kivonás'#13+
'SOURCE SERIES=Sor forrás'#13+
'TEECHART GALLERY=TeeChart Galéria'#13+
'DITHER=Remeg'#13+
'REDUCTION=Csökkentés'#13+
'COMPRESSION=Tömörítés'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Legközelebbi'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'GRAY SCALE=Gray Scale'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Minõség'#13+
'PERFORMANCE=Végrehajtás'#13+
'QUALITY=Minõség'#13+
'SPEED=Gyorsaság'#13+
'COMPRESSION LEVEL=Tömörítési fok'#13+
'CHART TOOLS GALLERY=Grafikon eszköz-képtár'#13+
'ANNOTATION=Magyarázat'#13+
'AXIS ARROWS=Tengely-nyíl'#13+
'COLOR BAND=Színsáv'#13+
'COLOR LINE=Színes vonal'#13+
'DRAG MARKS=Jelölést elhúz'#13+
'MARK TIPS=Jelölési tippek'#13+
'NEAREST POINT=Legközelebbi pont'#13+
'ROTATE=Elforgatás'#13+
'YES=Ja'#13+

// 6.0

'PERIOD=Periódus'#13+
'UP=Fel'#13+
'DOWN=Le'#13+
'SHADOW EDITOR=Árnyék editor'#13+
'CALLOUT=Kimenõ'#13+
'TEXT ALIGNMENT=Szöveg igazítás'#13+
'DISTANCE=Távolság'#13+
'ARROW HEAD=Nyílhegy'#13+
'POINTER=Mutató'#13+
'DRAG=Vonszol/húz'#13+
'HOURGLASS=Homokóra'#13+
'AVAILABLE LANGUAGES=Nyelv választék'#13+
'CHOOSE A LANGUAGE=Válasszon nyelvet'#13+
'CALCULATE USING=Mi alapján számol'#13+
'EVERY NUMBER OF POINTS=Pontok mindegyikét'#13+
'EVERY RANGE=Minden inervallumot'#13+
'INCLUDE NULL VALUES=Null értékeket is'#13+
'INVERTED SCROLL=Fordított görgetés'#13+
'DATE=Dátum'#13+
'ENTER DATE=Dátum'#13+
'ENTER TIME=Idõpont'#13+
'BEVEL SIZE=Bevel méret'#13+
'DEVIATION=Eltérés/deviáció'#13+
'UPPER=Felsõ'#13+
'LOWER=Alsó'#13+
'NOTHING=Semmi'#13+
'LEFT TRIANGLE=Bal háromszög'#13+
'RIGHT TRIANGLE=Jobb háromszög'#13+
'SHOW PREVIOUS BUTTON=Elõzõ gomb mutatása'#13+
'SHOW NEXT BUTTON=Köv. gomb mutatása'#13+
'CONSTANT=Konstans'#13+
'SHOW LABELS=Látható cimkék'#13+
'SHOW COLORS=Látható színek'#13+
'XYZ SERIES=XYZ szériák'#13+
'SHOW X VALUES=X értékek láthatóak'#13+
'DELETE ROW=Sor törlése'#13+
'VOLUME SERIES=Mennyiség szériák'#13+
'ACCUMULATE=Kumulál'#13+
'START VALUE=Kezdõ érték'#13+
'SINGLE=Egyedi'#13+
'REMOVE CUSTOM COLORS=Saját színeket elvesz'#13+
'STEP=Lépés'#13+
'USE PALETTE MINIMUM=Paletta minimumát használja'#13+
'AXIS MAXIMUM=Tengely maximum'#13+
'AXIS CENTER=Tengely középpont'#13+
'AXIS MINIMUM=Tengely minimum'#13+
'DRAG REPAINT=Húzás közben frissít'#13+
'NO LIMIT DRAG=Bárhova húzható'#13+
'DAILY (NONE)=Napi (semmi)'#13+
'WEEKLY=Heti'#13+
'MONTHLY=Havi'#13+
'BI-MONTHLY=Kéthavi'#13+
'QUARTERLY=Negyedéves'#13+
'YEARLY=Éves'#13+
'DATETIME PERIOD=Idõtartam'#13+
'SMOOTH=Simítás'#13+
'INTERPOLATE=Interpolál'#13+
'START X=Kezdõ X'#13+
'NUM. POINTS=Pontok száma'#13+
'COLOR EACH LINE=Minden sor színes'#13+
'CASE SENSITIVE=a/A különbözõ'#13+
'SORT BY=Rendezés'#13+
'(NONE)=(semmi)'#13+
'CALCULATION=Számolás'#13+
'GROUP=Csoportosítás'#13+
'HOLE %=Lyuk %'#13+
'DRAG STYLE=Drag-elés típusa'#13+
'WEIGHT=Súly'#13+
'EDIT LEGEND=Jelmagy. szerk.'#13+
'ROUND=Kerekített'#13+
'FLAT=Tompított/flat'#13+
'DRAW ALL=Mindet rajzolja'#13+
'IGNORE NULLS=NULLokat kihagyja'#13+
'OFFSET=Ofszet'#13+
'LIGHT 0=Világos 0'#13+
'LIGHT 1=Világos 1'#13+
'LIGHT 2=Világos 2'#13+
'DRAW STYLE=Rajzolás stílusa'#13+
'POINTS=Pontok'#13+
'DEFAULT BORDER=Alap szegély'#13+
'SQUARED=Négyszögletes'#13+
'SHOW PAGE NUMBER=Oldalszámot mutat'#13+
'SEPARATION=Szétválasztás'#13+
'ROUND BORDER=Kerek szegély'#13+
'NUMBER OF SAMPLE VALUES=Minta értékek száma'#13+
'RESIZE PIXELS TOLERANCE=Méretezéskori pixel tolerálás'#13+
'FULL REPAINT=Teljes újrarajzolás'#13+
'END POINT=Végpont'#13+
'BAND 1=Sáv 1'#13+
'BAND 2=Sáv 2'#13+
'GRID 3D SERIES=3D rács széria'#13+
'TRANSPOSE NOW=Transzponálás most'#13+
'PERIOD 1=1.Periódus'#13+
'PERIOD 2=2.Periódus'#13+
'PERIOD 3=3.Periódus'#13+
'HISTOGRAM=Gyakoriság.'#13+
'EXP. LINE=Exp. vonal'#13+
'WEIGHTED=Súlyozott'#13+
'WEIGHTED BY INDEX=Súlyozási index'#13+
'DARK BORDER=Sötét szegély'#13+
'PIE SERIES=Torta széria'#13+
'FOCUS=Fókusz'#13+
'EXPLODE=Szeletel'#13+
'BOX SIZE=Doboz méret'#13+
'REVERSAL AMOUNT=Visszavont mennyiség'#13+
'PERCENTAGE=Százalék'#13+
'COMPLETE R.M.S.=Teljes RMS'#13+
'BUTTON=Gomb'#13+
'SELECTED=Kijelölt'#13+
'START AT MIN. VALUE=Min. értéken kezdi'#13+
'EXECUTE !=Végrehajtás!'#13+
'IMAG. SYMBOL=Képz. szimbólum'#13+
'FACTOR=Faktor'#13+
'SELF STACK=Pakolt'#13+
'SIDE LINES=Oldalvonalak'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafikon sablonból (*.tee fájl)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=TeeChart sablon megnyitása innen'#13+
'EXPORT DIALOG=Export ablak'#13+
'BINARY=Bináris'#13+
'POINT COLORS=Pontok színezése'#13+
'OUTLINE GRADIENT=Körvonal gradiens'#13+
'RADIAL=Sugárirányú'#13+
'BALANCE=Egyensúly'#13+
'RADIAL OFFSET=Sugárirányú ofszet'#13+
'HORIZ=Vízsz.'#13+
'VERT=Függ.'#13+
'DRAG POINT=Pont húzása'#13+
'COVER=Borítás'#13+
'ARROW WIDTH=Nyíl szélesség'#13+
'ARROW HEIGHT=Nyíl magasság'#13+
'DEFAULT COLOR=Alap szín'#13+
'VALUE SOURCE=Érték forrás'

;
  end;
end;

Procedure TeeSetHungarian;
begin
  TeeCreateHungarian;
  TeeLanguage:=TeeHungarianLanguage;
  TeeHungarianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeHungarianLanguage);
end.
