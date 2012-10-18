unit TeeDutch;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeDutchLanguage:TStringList=nil;

Procedure TeeSetDutch;
Procedure TeeCreateDutch;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeDutchConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='Eerste Legendewaarde moet > 0';
  TeeMsg_LegendColorWidth   :='Laatste Legendekleurbreedte moet > 0%';
  TeeMsg_SeriesSetDataSource:='Geen grafiek om data oorsprong te valideren';
  TeeMsg_SeriesInvDataSource:='Foutieve data oorsprong: %s';
  TeeMsg_FillSample         :='Opvulwaaarden moeten > 0';
  TeeMsg_AxisLogDateTime    :='Datumtijd-As kan niet logaritmisch zijn';
  TeeMsg_AxisLogNotPositive :='Logaritmische-As Min en Max waarden moeten >= 0';
  TeeMsg_AxisLabelSep       :='Labels Scheiding % moet > 0';
  TeeMsg_AxisIncrementNeg   :='As toename moet >= 0';
  TeeMsg_AxisMinMax         :='As Minimum Waarde moet <= Maximum';
  TeeMsg_AxisMaxMin         :='As Maximum Waarde moet >= Minimum';
  TeeMsg_AxisLogBase        :='As Logaritmische Basis moet >= 2';
  TeeMsg_MaxPointsPerPage   :='Maximum Aantal Punten per Pagina moet >= 0';
  TeeMsg_3dPercent          :='3D effect percentage moet tussen %d en %d zijn';
  TeeMsg_CircularSeries     :='Circulaire Reeks afhankelijkheden worden niet geaccepteerd';
  TeeMsg_WarningHiColor     :='16k Kleur of hoger nodig voor beter resultaat';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='As-Titel';
  TeeMsg_AxisLabels         :='As-Labels';
  TeeMsg_RefreshInterval    :='Interval vernieuwen moet tussen 0 en 60 zijn';
  TeeMsg_SeriesParentNoSelf :='Huidige series kan niet zichzelf zijn!';
  TeeMsg_GalleryLine        :='Lijn';
  TeeMsg_GalleryPoint       :='Punt';
  TeeMsg_GalleryArea        :='Gebied';
  TeeMsg_GalleryBar         :='Kolom';
  TeeMsg_GalleryHorizBar    :='Horiz. Kolom';
  TeeMsg_Stack              :='Stapel';
  TeeMsg_GalleryPie         :='Taart';
  TeeMsg_GalleryCircled     :='Cirkel';
  TeeMsg_GalleryFastLine    :='Snelle Lijn';
  TeeMsg_GalleryHorizLine   :='Horiz. Lijn';

  TeeMsg_PieSample1         :='Auto''s';
  TeeMsg_PieSample2         :='Telefoons';
  TeeMsg_PieSample3         :='Tabellen';
  TeeMsg_PieSample4         :='Beeldschermen';
  TeeMsg_PieSample5         :='Lampen';
  TeeMsg_PieSample6         :='Klavieren';
  TeeMsg_PieSample7         :='Fietsen';
  TeeMsg_PieSample8         :='Stoelen';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Bewerken %s';

  TeeMsg_GalleryStandard    :='Standaard';
  TeeMsg_GalleryExtended    :='Uitgebreid';
  TeeMsg_GalleryFunctions   :='Functies';

  TeeMsg_EditChart          :='Grafiek &Bewerken...';
  TeeMsg_PrintPreview       :='&Afdrukvoorbeeld...';
  TeeMsg_ExportChart        :='Grafiek E&xporteren...';
  TeeMsg_CustomAxes         :='Gebruikelijke Assen...';

  TeeMsg_InvalidEditorClass :='%s: Ongeldige Klasse: %s';
  TeeMsg_MissingEditorClass :='%s: heeft geen dialoog';

  TeeMsg_GalleryArrow       :='Pijl';

  TeeMsg_ExpFinish          :='&Einde';
  TeeMsg_ExpNext            :='&Volgende >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Ontwerp';
  TeeMsg_GanttSample2       :='Prototype';
  TeeMsg_GanttSample3       :='Ontwikkeling';
  TeeMsg_GanttSample4       :='Verkoop';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testen';
  TeeMsg_GanttSample7       :='Onderneming';
  TeeMsg_GanttSample8       :='Ontbuggen';
  TeeMsg_GanttSample9       :='Nieuwe versie';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Wijzig Reeks-Titel';
  TeeMsg_NewSeriesTitle     :='Nieuwe Reeks-Titel:';
  TeeMsg_DateTime           :='Datum/Tijd';
  TeeMsg_TopAxis            :='Bovenste-As';
  TeeMsg_BottomAxis         :='Onderste-As';
  TeeMsg_LeftAxis           :='Linker-As';
  TeeMsg_RightAxis          :='Rechter-As';

  TeeMsg_SureToDelete       :='Verwijder %s ?';
  TeeMsg_DateTimeFormat     :='Datum/Tijd For&maat:';
  TeeMsg_Default            :='Standaard';
  TeeMsg_ValuesFormat       :='&Type:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Gewenste %s toename';

  TeeMsg_IncorrectMaxMinValue:='Foutieve waarde. Oorzaak: %s';
  TeeMsg_EnterDateTime      :='Invoeren [Aantal dagen] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Wijzigingen Toepassen ?';
  TeeMsg_SelectedSeries     :='(Geselecteerde Reeksen)';
  TeeMsg_RefreshData        :='&Data Vernieuwen';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='472';
  TeeMsg_FunctionAdd        :='Optellen';
  TeeMsg_FunctionSubtract   :='Aftrekken';
  TeeMsg_FunctionMultiply   :='Vermenigvuldigen';
  TeeMsg_FunctionDivide     :='Delen';
  TeeMsg_FunctionHigh       :='Hoog';
  TeeMsg_FunctionLow        :='Laag';
  TeeMsg_FunctionAverage    :='Gemiddeld';

  TeeMsg_GalleryShape       :='Vorm';
  TeeMsg_GalleryBubble      :='Bel';
  TeeMsg_FunctionNone       :='Kopiëren';

  TeeMsg_None               :='(geen)';

  TeeMsg_PrivateDeclarations:='{ Persoonlijke verklaringen }';
  TeeMsg_PublicDeclarations :='{ Publieke verklaringen }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer grootte moet groter zijn dan zero';
  TeeMsg_About              :='&Over de ChartEditor...';

  tcAdditional              :='Toevoegingen';
  tcDControls               :='Data opdrachten';
  tcQReport                 :='QVerslag';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Enkel Record';
  TeeMsg_AskDataSource      :='&Oorsprong:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='Functieperiode moet >= 0';

  TeeMsg_WizardTab          :='Zaken';

  TeeMsg_ClearImage         :='&Wis';
  TeeMsg_BrowseImage        :='&Bladeren...';

  TeeMsg_WizardSureToClose  :='Weet u zeker dat u de Charteditor Wizard wilt afsluiten?';
  TeeMsg_FieldNotFound      :='Veld %s bestaat niet';

  TeeMsg_DepthAxis          :='Diepte-As';
  TeeMsg_PieOther           :='Ander';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Taart';
  TeeMsg_ValuesBar          :='Kolom';
  TeeMsg_ValuesAngle        :='Hoek';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Einde';
  TeeMsg_ValuesGanttNextTask:='VolgendeTaak';
  TeeMsg_ValuesBubbleRadius :='Straal';
  TeeMsg_ValuesArrowEndX    :='EindeX';
  TeeMsg_ValuesArrowEndY    :='EindeY';
  TeeMsg_Legend             :='Legende';
  TeeMsg_Title              :='Titel';
  TeeMsg_Foot               :='Voet';
  TeeMsg_Period		    :='Periode';
  TeeMsg_PeriodRange        :='Periode bereik';
  TeeMsg_CalcPeriod         :='Bereken %s elk:';
  TeeMsg_SmallDotsPen       :='Kleine Puntjes';

  TeeMsg_InvalidTeeFile     :='Ongeldige Grafiek in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Verkeerde *.'+TeeMsg_TeeExtension+' bestandsformaat';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Grafiek Assen';
  TeeMsg_ChartAxesCategoryDesc   :='Grafiek Assen eigenschappen en gebeurtenissen';
  TeeMsg_ChartWallsCategoryName  :='Grafiek Wanden';
  TeeMsg_ChartWallsCategoryDesc  :='Grafiek Wanden eigenschappen en gebeurtenissen';
  TeeMsg_ChartTitlesCategoryName :='Grafiek Titels';
  TeeMsg_ChartTitlesCategoryDesc :='Grafiek Titels eigenschappen en gebeurtenissen';
  TeeMsg_Chart3DCategoryName     :='Grafiek 3D';
  TeeMsg_Chart3DCategoryDesc     :='Grafiek 3D eigenschappen en gebeurtenissen';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Aanpassen ';
  TeeMsg_Series                 :='Reeksen';
  TeeMsg_SeriesList             :='Reeksen...';

  TeeMsg_PageOfPages            :='Pagina %d van %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Eerst';
  TeeMsg_Prior  :='Vorige';
  TeeMsg_Next   :='Volgende';
  TeeMsg_Last   :='Laatste';
  TeeMsg_Insert :='Invoegen';
  TeeMsg_Delete :='Verwijderen';
  TeeMsg_Edit   :='Bewerken';
  TeeMsg_Post   :='Na';
  TeeMsg_Cancel :='Annuleren';

  TeeMsg_All    :='(alles)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='als &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='als &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Paneeleigenschappen zijn niet in het formaat om te exporteren';

  TeeMsg_Normal    :='Normaal';
  TeeMsg_NoBorder  :='Geen Rand';
  TeeMsg_Dotted    :='Gestipt';
  TeeMsg_Colors    :='Kleuren';
  TeeMsg_Filled    :='Gevuld';
  TeeMsg_Marks     :='Merktekens';
  TeeMsg_Stairs    :='Trappen';
  TeeMsg_Points    :='Punten';
  TeeMsg_Height    :='Hoogte';
  TeeMsg_Hollow    :='Hol';
  TeeMsg_Point2D   :='Punt 2D';
  TeeMsg_Triangle  :='Driehoek';
  TeeMsg_Star      :='Ster';
  TeeMsg_Circle    :='Cirkel';
  TeeMsg_DownTri   :='Omgek.Driehoek';
  TeeMsg_Cross     :='kruis';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Geen Lijnen';
  TeeMsg_Stack100  :='Stapel 100%';
  TeeMsg_Pyramid   :='Piramide';
  TeeMsg_Ellipse   :='Ellips';
  TeeMsg_InvPyramid:='Omgek.Piramide';
  TeeMsg_Sides     :='Zijden';
  TeeMsg_SideAll   :='Alle Zijden';
  TeeMsg_Patterns  :='Patronen';
  TeeMsg_Exploded  :='Exploderen';
  TeeMsg_Shadow    :='Schaduw';
  TeeMsg_SemiPie   :='Halve Taart';
  TeeMsg_Rectangle :='Rechthoek';
  TeeMsg_VertLine  :='Vert.Lijn';
  TeeMsg_HorizLine :='Horiz.Lijn';
  TeeMsg_Line      :='Lijn';
  TeeMsg_Cube      :='Kubus';
  TeeMsg_DiagCross :='Diag.Kruis';

  TeeMsg_CanNotFindTempPath    :='Kan tijdelijke map niet vinden';
  TeeMsg_CanNotCreateTempChart :='Kan tijdelijk bestand niet aanmaken';
  TeeMsg_CanNotEmailChart      :='Kan grafiek niet e-mailen. Mapi Fout: %d';

  TeeMsg_SeriesDelete :='Reeks verwijderd: Indexwaarde %d buiten dimensie (0 to %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Taal...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Pool';
  TeeMsg_GalleryCandle      :='Kaars';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Oppervlak';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punt 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Kolom 3D';
  TeeMsg_GalleryBigCandle   :='Dikke Kaars';
  TeeMsg_GalleryLinePoint   :='Lijn-Punt';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Waterval';
  TeeMsg_GalleryWindRose    :='Windroos';
  TeeMsg_GalleryClock       :='Klok';
  TeeMsg_GalleryColorGrid   :='KleurenRooster';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Verenigd.Kolom';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramide';
  TeeMsg_GalleryMap         :='Kaart';

  TeeMsg_PolyDegreeRange    :='Polynoomgraad moet tussen 1 en 20 zijn';
  TeeMsg_AnswerVectorIndex   :='Vectorindex moet tussen 1 and %d zijn';
  TeeMsg_FittingError        :='Kan opdracht niet uitvoeren';
  TeeMsg_PeriodRange         :='Periode moet >= 0';
  TeeMsg_ExpAverageWeight    :='Gewogen gemiddelde moet tussen 0 en 1 zijn';
  TeeMsg_GalleryErrorBar     :='Kolomfout';
  TeeMsg_GalleryError        :='Fout';
  TeeMsg_GalleryHighLow      :='Hoogste-Laagste';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Diff';
  TeeMsg_FunctionExpAverage  :='Exp. Gemiddelde';
  TeeMsg_FunctionMovingAverage:='Lopend Gemiddelde';
  TeeMsg_FunctionExpMovAve   :='Exp.Lop.Gemidd.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulatief';
  TeeMsg_FunctionStdDeviation:='Std.Deviatie';
  TeeMsg_FunctionBollinger   :='BollingerBnd';
  TeeMsg_FunctionRMS         :='Differentiaal';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastics';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Tel';
  TeeMsg_LoadChart           :='Grafiek openen...';
  TeeMsg_SaveChart           :='Grafiek opslaan...';
  TeeMsg_TeeFiles            :='Grafiek bestanden';

  TeeMsg_GallerySamples      :='Andere';
  TeeMsg_GalleryStats        :='Statistieken';

  TeeMsg_CannotFindEditor    :='Kan volgend bewerkingsvenster niet vinden: %s';


  TeeMsg_CannotLoadChartFromURL:='Foutcode: %d Grafiek downloaden van URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Foutcode: %d Serie downloaden van URL: %s';

  TeeMsg_Test                :='Testen...';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Open';
  TeeMsg_ValuesHigh          :='Hoog';
  TeeMsg_ValuesLow           :='Laag';
  TeeMsg_ValuesClose         :='Sluiten';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='StdFout';

  TeeMsg_Grid3D              :='Raster 3D';

  TeeMsg_LowBezierPoints     :='Aantal Bezier punten moet > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normaal';
  TeeCommanMsg_Edit     :='Bewerken';
  TeeCommanMsg_Print    :='Afdrukken';
  TeeCommanMsg_Copy     :='Kopiëren';
  TeeCommanMsg_Save     :='Opslaan';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotatie: %d° Verhoging: %d°';
  TeeCommanMsg_Rotate   :='Ronddraaien';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Verplaatsen';

  TeeCommanMsg_Zooming  :='Vergroten: %d %%';
  TeeCommanMsg_Zoom     :='Vergroten';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Diepte';

  TeeCommanMsg_Chart    :='Grafiek';
  TeeCommanMsg_Panel    :='Paneel';

  TeeCommanMsg_RotateLabel:='Slepen %s om rond te draaien';
  TeeCommanMsg_MoveLabel  :='Slepen %s om te verplaatsen';
  TeeCommanMsg_ZoomLabel  :='Slepen %s om te vergroten';
  TeeCommanMsg_DepthLabel :='Slepen %s om formaat 3D te wijzigen';

  TeeCommanMsg_NormalLabel:='Sleep Linkerknop om te vergroten, Rechter om door te rollen';
  TeeCommanMsg_NormalPieLabel:='Sleep een taartstuk om het op te heffen';

  TeeCommanMsg_PieExploding :='Taartstuk: %d Opgeheven: %d %%';

  TeeMsg_TriSurfaceLess:='Aantal punten moet >= 4';
  TeeMsg_TriSurfaceAllColinear:='Alle colineaire data punten';
  TeeMsg_TriSurfaceSimilar:='Gelijke punten - kan de opdracht niet uitvoeren';
  TeeMsg_GalleryTriSurface:='Driehoek Opp.';

  TeeMsg_AllSeries :='Alle Reeksen';
  TeeMsg_Edit      :='Bewerken';

  TeeMsg_GalleryFinancial    :='Financiëel';

  TeeMsg_CursorTool    :='Kruisdraden';
  TeeMsg_DragMarksTool :='Merktekens slepen';
  TeeMsg_AxisArrowTool :='Assen Pijlen';
  TeeMsg_DrawLineTool  :='Lijn tekenen';
  TeeMsg_NearestTool   :='Dichtsbijzijnd Punt';
  TeeMsg_ColorBandTool :='Bandkleur';
  TeeMsg_ColorLineTool :='Lijnkleur';
  TeeMsg_RotateTool    :='Ronddraaien';
  TeeMsg_ImageTool     :='Afbeelding';
  TeeMsg_MarksTipTool  :='Tips markeren';

  TeeMsg_CantDeleteAncestor  :='Kan ancestor niet verwijderen';

  TeeMsg_Load	         :='Laden...';
  TeeMsg_NoSeriesSelected:='Geen Reeks Geselecteerd';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafiek';
  TeeMsg_CategorySeriesActions :='Grafiek Reeks';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Kies 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Actief';
  TeeMsg_ActionSeriesActiveHint :='Tonen / Verbergen Reeksen';
  TeeMsg_ActionEditHint         :='Bewerken Grafiek';
  TeeMsg_ActionEdit             :='&Bewerken...';
  TeeMsg_ActionCopyHint         :='Kopiëren naar Klembord';
  TeeMsg_ActionCopy             :='&Kopiëren';
  TeeMsg_ActionPrintHint        :='Afdrukvoorbeeld Grafiek';
  TeeMsg_ActionPrint            :='&Afdrukken...';
  TeeMsg_ActionAxesHint         :='Tonen / Verbergen Assen';
  TeeMsg_ActionAxes             :='&Assen';
  TeeMsg_ActionGridsHint        :='Tonen / Verbergen Roosters';
  TeeMsg_ActionGrids            :='&Roosters';
  TeeMsg_ActionLegendHint       :='Tonen / Verbergen Legende';
  TeeMsg_ActionLegend           :='&Legende';
  TeeMsg_ActionSeriesEditHint   :='Bewerken Reeksen';
  TeeMsg_ActionSeriesMarksHint  :='Tonen / Verbergen Reeksen Marks';
  TeeMsg_ActionSeriesMarks      :='&Markeringen';
  TeeMsg_ActionSaveHint         :='Grafiek Opslaan';
  TeeMsg_ActionSave             :='&Opslaan...';

  TeeMsg_CandleBar              :='Staaf';
  TeeMsg_CandleNoOpen           :='Geen OpenK';
  TeeMsg_CandleNoClose          :='Geen Slot';
  TeeMsg_NoLines                :='geen Lijnen';
  TeeMsg_NoHigh                 :='Geen HoogsteK';
  TeeMsg_NoLow                  :='Geen LaagsteK';
  TeeMsg_ColorRange             :='Kleurbereik';
  TeeMsg_WireFrame              :='Transparant';
  TeeMsg_DotFrame               :='Gestipt';
  TeeMsg_Positions              :='Posities';
  TeeMsg_NoGrid                 :='Geen Raster';
  TeeMsg_NoPoint                :='Geen Punt';
  TeeMsg_NoLine                 :='Geen Lijn';
  TeeMsg_Labels                 :='Labels';
  TeeMsg_NoCircle               :='Geen Cirkel';
  TeeMsg_Lines                  :='Lijnen';
  TeeMsg_Border                 :='Rand';

  TeeMsg_SmithResistance      :='Weerstand';
  TeeMsg_SmithReactance       :='Reactance';

  TeeMsg_Column  :='Kolom';

  { 5.02 }
  TeeMsg_Origin               := 'Oorsprong';
  TeeMsg_Transparency         := 'Transparant';
  TeeMsg_Box		      := 'Doos';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Pagina nummer';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='als &JPEG';
  TeeMsg_JPEGFilter    :='Bestanden JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='als &GIF';
  TeeMsg_GIFFilter     :='Bestanden GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='als &PNG';
  TeeMsg_PNGFilter     :='Bestanden PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='als PC&X';
  TeeMsg_PCXFilter     :='Bestanden PCX (*.pcx)|*.pcx';

  { 5.01 }
  TeeMsg_Separator            :='Scheidingsteken';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Serie';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Overtreft de quota';
  TeeMsg_FunnelWithin         :=' Binnen de quota';
  TeeMsg_FunnelBelow          :=' of onder de quota';
  TeeMsg_CalendarSeries       :='Kalender';
  TeeMsg_DeltaPointSeries     :='DeltaPunt';
  TeeMsg_ImagePointSeries     :='BeeldPunt';
  TeeMsg_ImageBarSeries       :='Beeldstaaf';
  TeeMsg_SeriesTextFieldZero  :='TekstSerie: Het indexveld moet groter zijn dan nul.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Transparency';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Page Number';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='Save %s?';

  TeeMsg_Property             :='Property';
  TeeMsg_Value                :='Value';
  TeeMsg_Yes                  :='Yes';
  TeeMsg_No                   :='No';
  TeeMsg_Image                :='(image)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX versie ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Kan ChartEditor niet importeren van %s';
  TeeMsg_ActiveXVerbPrint    := '&Afdrukvoorbeeld...';
  TeeMsg_ActiveXVerbExport   := 'E&xporteren...';
  TeeMsg_ActiveXVerbImport   := '&Importeren...';
  TeeMsg_ActiveXVerbHelp     := '&Help...';
  TeeMsg_ActiveXVerbAbout    := '&Over TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Foutcode: %d downloading: %s';
  TeeMsg_DatasourceError     := 'De datagegevens zijn geen serie en geen recordset';
  TeeMsg_SeriesTextSrcError  := 'Ongeldige serie';
  TeeMsg_AxisTextSrcError    := 'Ongeldige as';
  TeeMsg_DelSeriesDatasource := 'Bent u zeker dat u %s wenst te verwijderen ?';
  TeeMsg_OCXNoPrinter        := 'Geen printer geïnstalleerd.';
  TeeMsg_ActiveXPictureNotValid:='Geen geldige figuur';

// 6.0
// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='als &PDF';
  TeeMsg_PDFFilter        :='PDF bestanden (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='als PostScript';
  TeeMsg_PSFilter         :='PostScript bestanden (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horizontaal'#13'gebied';
  TeeMsg_SelfStack        :='Zelf-stapelend';
  TeeMsg_DarkPen          :='Donkere rand';
  TeeMsg_SelectFolder     :='Map kiezen';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Verbinding:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Afvlakken';
  TeeMsg_FunctionCross        :='Snijpunten';
  TeeMsg_GridTranspose        :='3D Verplaatsbaar Rooster';
  TeeMsg_FunctionCompress     :='Samendrukken';
  TeeMsg_ExtraLegendTool      :='Extra Legende';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Price Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animo Reeksen';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Boven';
  TeeMsg_Down                 :='Onder';
  TeeMsg_GanttTool            :='Gantt Tool';
  TeeMsg_XMLFile              :='XML bestand';
  TeeMsg_GridBandTool         :='Roosterband Tool';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='Peilglas';
  TeeMsg_GalleryGauges        :='Maten';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vector 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Toren';
  TeeMsg_SingleColor          :='Enkele Kleur';
  TeeMsg_Cover                :='Bedekken';
  TeeMsg_Cone                 :='Kegel';
  TeeMsg_PieTool              :='Taartstuk';

end;

Procedure TeeCreateDutch;
begin
  if not Assigned(TeeDutchLanguage) then
  begin
    TeeDutchLanguage:=TStringList.Create;
    TeeDutchLanguage.Text:=

'GRADIENT EDITOR=Overgang bewerken'#13+
'GRADIENT=Overgang'#13+
'DIRECTION=Richting'#13+
'VISIBLE=Toon'#13+
'TOP BOTTOM=Boven-Beneden'#13+
'BOTTOM TOP=Beneden-Boven'#13+
'LEFT RIGHT=Links-Rechts'#13+
'RIGHT LEFT=Rechts-Links'#13+
'FROM CENTER=Vanuit het midden'#13+
'FROM TOP LEFT=Van Linksboven'#13+
'FROM BOTTOM LEFT=Van Rechtsbeneden'#13+
'OK=Ok'#13+
'CANCEL=Annuleren'#13+
'COLORS=Kleuren'#13+
'START=Begin'#13+
'MIDDLE=Midden'#13+
'END=Einde'#13+
'SWAP=Ruilen'#13+
'NO MIDDLE=Geen Midden'#13+
'TEEFONT EDITOR=Lettertype bewerken'#13+
'INTER-CHAR SPACING=Spaties tussen karakters'#13+
'FONT=Lettertype'#13+
'SHADOW=Schaduw'#13+
'HORIZ. SIZE=Horiz. Grootte'#13+
'VERT. SIZE=Vert. Grootte'#13+
'COLOR=Kleur'#13+
'OUTLINE=Omkadering'#13+
'OPTIONS=Opties'#13+
'FORMAT=Opmaak'#13+
'TEXT=Tekst'#13+
'POSITION=Positie'#13+
'LEFT=Links'#13+
'TOP=Boven'#13+
'AUTO=Auto'#13+
'CUSTOM=Aanpassen'#13+
'LEFT TOP=Linksboven'#13+
'LEFT BOTTOM=Linksonder'#13+
'RIGHT TOP=Rechtsboven'#13+
'RIGHT BOTTOM=Rechtsonder'#13+
'MULTIPLE AREAS=Meerdere Gebieden'#13+
'NONE=Geen'#13+
'STACKED=Stapelen'#13+
'STACKED 100%=100% Stapelen'#13+
'AREA=Gebied'#13+
'PATTERN=Patroon'#13+
'STAIRS=Trappen'#13+
'SOLID=Massief'#13+
'CLEAR=Helder'#13+
'HORIZONTAL=Horizontaal'#13+
'VERTICAL=Vertikaal'#13+
'DIAGONAL=Diagonaal'#13+
'B.DIAGONAL=B.Diagonaal'#13+
'CROSS=Kruis'#13+
'DIAG.CROSS=Diag.Kruis'#13+
'AREA LINES=Lijnen Gebied'#13+
'BORDER=Randen'#13+
'INVERTED=Omgekeerd'#13+
'COLOR EACH=Elk punt kleuren'#13+
'ORIGIN=Bron'#13+
'USE ORIGIN=Bron Gebruiken'#13+
'WIDTH=Breedte'#13+
'HEIGHT=Hoogte'#13+
'AXIS=Assen'#13+
'LENGTH=Lengte'#13+
'SCROLL=Scrollen'#13+
'BOTH=Beide'#13+
'AXIS INCREMENT=Assen verhogen'#13+
'INCREMENT=Verhogen'#13+
'STANDARD=Standaard'#13+
'ONE MILLISECOND=Een Milliseconde'#13+
'ONE SECOND=Een Seconde'#13+
'FIVE SECONDS=Vijf Seconden'#13+
'TEN SECONDS=Tien Seconden'#13+
'FIFTEEN SECONDS=Vijftien Seconden'#13+
'THIRTY SECONDS=Dertig Seconden'#13+
'ONE MINUTE=Een Minuut'#13+
'FIVE MINUTES=Vijf Minuten'#13+
'TEN MINUTES=Tien Minuten'#13+
'FIFTEEN MINUTES=Vijftien Minuten'#13+
'THIRTY MINUTES=Dertig Minuten'#13+
'ONE HOUR=Een Uur'#13+
'TWO HOURS=Twee Uren'#13+
'SIX HOURS=Zes Uren'#13+
'TWELVE HOURS=Twaalf Uren'#13+
'ONE DAY=Een Dag'#13+
'TWO DAYS=Twee Dagen'#13+
'THREE DAYS=Drie Dagen'#13+
'ONE WEEK=Een Week'#13+
'HALF MONTH=Halve Maand'#13+
'ONE MONTH=Een Maand'#13+
'TWO MONTHS=Twee Maanden'#13+
'THREE MONTHS=Drie Maanden'#13+
'FOUR MONTHS=Vier Maanden'#13+
'SIX MONTHS=Zes Maanden'#13+
'ONE YEAR=Een Jaar'#13+
'EXACT DATE TIME=Juiste Datum Tijd'#13+
'AXIS MAXIMUM AND MINIMUM=Assen Maximum en Minimum'#13+
'VALUE=Waarde'#13+
'TIME=Tijd'#13+
'LEFT AXIS=Linker As'#13+
'RIGHT AXIS=Rechter As'#13+
'TOP AXIS=Bovenste As'#13+
'BOTTOM AXIS=Onderste As'#13+
'% BAR WIDTH=% Balk Breedte'#13+
'STYLE=Stijl'#13+
'% BAR OFFSET=% Balk Baland'#13+
'RECTANGLE=Rechthoek'#13+
'PYRAMID=Piramide'#13+
'INVERT. PYRAMID=Omgekeerde Piramide'#13+
'CYLINDER=Cilinder'#13+
'ELLIPSE=Ellips'#13+
'ARROW=Arrow'#13+
'RECT. GRADIENT=Hellende Rechthoek'#13+
'CONE=Kegel'#13+
'DARK BAR 3D SIDES=Donkere Balk 3D Zijden'#13+
'BAR SIDE MARGINS=Balkzijde Marges'#13+
'AUTO MARK POSITION=Autom. Selectie Positie'#13+
'JOIN=Samenvoeg.'#13+
'DATASET=Dataset'#13+
'APPLY=Toepassen'#13+
'SOURCE=Bron'#13+
'MONOCHROME=Monochroom'#13+
'DEFAULT=Standaard'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediaan'#13+
'WHISKER=Wimper'#13+
'PATTERN COLOR EDITOR=Patroon Kleur Editor'#13+
'IMAGE=Afbeelding'#13+
'BACK DIAGONAL=Andere Diagonaal'#13+
'DIAGONAL CROSS=Diagonaal Kruis'#13+
'FILL 80%=Vullen 80%'#13+
'FILL 60%=Vullen 60%'#13+
'FILL 40%=Vullen 40%'#13+
'FILL 20%=Vullen 20%'#13+
'FILL 10%=Vullen 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Kleine Verticale'#13+
'HORIZ. SMALL=Kleine Horiz.'#13+
'DIAG. SMALL=Kleine Diagonaal'#13+
'BACK DIAG. SMALL=Andere kleine Diagonaal'#13+
'CROSS SMALL=Klein Kruis'#13+
'DIAG. CROSS SMALL=Kleine Diag. Kruis'#13+
'DAYS=Dagen'#13+
'WEEKDAYS=Weekdagen'#13+
'TODAY=Vandaag'#13+
'SUNDAY=Zondag'#13+
'TRAILING=Slepen'#13+
'MONTHS=Maanden'#13+
'LINES=Lijnen'#13+
'SHOW WEEKDAYS=Toon Weekdagen'#13+
'UPPERCASE=Hoofdletters'#13+
'TRAILING DAYS=Dagen Slepen'#13+
'SHOW TODAY=Vandaag Tonen'#13+
'SHOW MONTHS=Maanden Tonen'#13+
'CANDLE WIDTH=Candle Breedte'#13+
'STICK=Candlesticks'#13+
'BAR=Bar Charts'#13+
'OPEN CLOSE=Opening Slot'#13+
'UP CLOSE=Kleur stijgen'#13+
'DOWN CLOSE=Kleur dalen'#13+
'SHOW OPEN=Toon Opening'#13+
'SHOW CLOSE=Toon Slot'#13+
'DRAW 3D=3D Tekenen'#13+
'DARK 3D=Donkere 3D'#13+
'EDITING=Bewerken'#13+
'CHART=Grafiek'#13+
'SERIES=Reeksen'#13+
'DATA=Gegevens'#13+
'TOOLS=Gereedschap'#13+
'EXPORT=Exporteren'#13+
'PRINT=Afdrukken'#13+
'GENERAL=Algemeen'#13+
'TITLES=Titels'#13+
'LEGEND=Legende'#13+
'PANEL=Paneel'#13+
'PAGING=Pagineren'#13+
'WALLS=Wanden'#13+
'3D=3D'#13+
'ADD=Toevoegen'#13+
'DELETE=Verwijderen'#13+
'TITLE=Titel'#13+
'CLONE=Klonen'#13+
'CHANGE=Wijzigen'#13+
'HELP=Help'#13+
'CLOSE=Sluiten'#13+
'TEECHART PRINT PREVIEW=Afdrukvoorbeeld'#13+
'PRINTER=Printer'#13+
'SETUP=Instellingen'#13+
'ORIENTATION=Orientatie'#13+
'PORTRAIT=Staand'#13+
'LANDSCAPE=Liggend'#13+
'MARGINS (%)=Marges (%)'#13+
'DETAIL=Detail'#13+
'MORE=Meer'#13+
'NORMAL=Normaal'#13+
'RESET MARGINS=Marges Herstellen'#13+
'VIEW MARGINS=Marges Bekijken'#13+
'PROPORTIONAL=Proportioneel'#13+
'CIRCLE=Cirkel'#13+
'VERTICAL LINE=Verticale Lijn'#13+
'HORIZ. LINE=Horiz. Lijn'#13+
'TRIANGLE=Driehoek'#13+
'INVERT. TRIANGLE=Hangende Driehoek'#13+
'LINE=Lijn'#13+
'DIAMOND=Diamant'#13+
'CUBE=Kubus'#13+
'STAR=Ster'#13+
'TRANSPARENT=Transparant'#13+
'HORIZ. ALIGNMENT=Horiz. Uitlijning'#13+
'CENTER=Centreren'#13+
'RIGHT=Rechts'#13+
'ROUND RECTANGLE=Afronden Rechthoek'#13+
'ALIGNMENT=Uitlijning'#13+
'BOTTOM=Onder'#13+
'UNITS=Eenheden'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Bron Assen'#13+
'ROTATION=Rotatie'#13+
'CIRCLED=Omcirkeld'#13+
'3 DIMENSIONS=3 Dimensies'#13+
'RADIUS=Straal'#13+
'ANGLE INCREMENT=Hoek Vergroting'#13+
'RADIUS INCREMENT=Straal Vergroting'#13+
'CLOSE CIRCLE=Sluit Cirkel'#13+
'PEN=Pen'#13+
'LABELS=Labels'#13+
'ROTATED=Geroteerd'#13+
'CLOCKWISE=Kloksgewijs'#13+
'INSIDE=Binnenin'#13+
'ROMAN=Romeins'#13+
'HOURS=Uren'#13+
'MINUTES=Minuten'#13+
'SECONDS=Seconden'#13+
'START VALUE:=Start waarde:'#13+
'END VALUE=Eind waarde'#13+
'TRANSPARENCY=Transparant'#13+
'DRAW BEHIND=Achteraan Tekenen'#13+
'COLOR MODE=Kleur Wijze'#13+
'STEPS=Stappen'#13+
'RANGE=Bereik'#13+
'PALETTE=Palet'#13+
'PALE=Bleek'#13+
'STRONG=Sterk'#13+
'GRID SIZE=Raster Grootte'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Diepte'#13+
'IRREGULAR=Onregelmatig'#13+
'GRID=Raster'#13+
'VALUE:=Waarde:'#13+
'ALLOW DRAG=Slepen Toestaan'#13+
'VERTICAL POSITION=Verticale Positie'#13+
'LEVELS POSITION=Positie Niveaus'#13+
'LEVELS=Niveaus'#13+
'NUMBER=Aantal'#13+
'LEVEL=Niveau'#13+
'AUTOMATIC=Automatisch'#13+
'SNAP=Klikken'#13+
'FOLLOW MOUSE=Muis Volgen'#13+
'STACK=Stapel'#13+
'HEIGHT 3D=Hoogte 3D'#13+
'LINE MODE=Lijn Wijze'#13+
'OVERLAP=Overlappen'#13+
'STACK 100%=Stapel 100%'#13+
'CLICKABLE=Klikbaar'#13+
'AVAILABLE=Beschikbaar'#13+
'SELECTED=Geselecteerd:'#13+
'DATASOURCE=DataSource'#13+
'GROUP BY=Groeperen'#13+
'CALC=Calc'#13+
'OF=van'#13+
'SUM=Som'#13+
'COUNT=Tel'#13+
'HIGH=Hoog'#13+
'LOW=Laag'#13+
'AVG=Gemiddeld'#13+
'HOUR=Uur'#13+
'DAY=Dag'#13+
'WEEK=Week'#13+
'WEEKDAY=WeekDag'#13+
'MONTH=Maand'#13+
'QUARTER=Kwartaal'#13+
'YEAR=Jaar'#13+
'HOLE %:=Gat %:'#13+
'RESET POSITIONS=Posities Terugzetten'#13+
'MOUSE BUTTON=Muisknop'#13+
'ENABLE DRAWING=Tekenen Mogelijk'#13+
'ENABLE SELECT=Mogelijkheid Selecteren'#13+
'ENHANCED=Verbeterd'#13+
'ERROR WIDTH=Error Breedte'#13+
'WIDTH UNITS=Br.Eenheid'#13+
'PERCENT=Percenten'#13+
'LEFT AND RIGHT=Links en Rechts'#13+
'TOP AND BOTTOM=Boven en Onder'#13+
'BORDER EDITOR=Omkadering'#13+
'DASH=Streep'#13+
'DOT=Punt'#13+
'DASH DOT=Streep Punt'#13+
'DASH DOT DOT=Streep Punt Punt'#13+
'CALCULATE EVERY=Alles Berekenen'#13+
'ALL POINTS=Alle punten'#13+
'NUMBER OF POINTS=Aantal punten'#13+
'RANGE OF VALUES=Bereik van Waarden'#13+
'FIRST=Eerste'#13+
'LAST=Laatste'#13+
'TEEPREVIEW EDITOR=Voorbeeld Editor'#13+
'ALLOW MOVE=Verplaatsen Toestaan'#13+
'ALLOW RESIZE=Afmetingen Toestaan'#13+
'DRAG IMAGE=Figuur Slepen'#13+
'AS BITMAP=Als Bitmap'#13+
'SHOW IMAGE=Toon Figuur'#13+
'MARGINS=Marges'#13+
'SIZE=Grootte'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Verhoging'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horiz. Tegeng.'#13+
'VERT. OFFSET=Vert. Tegeng.'#13+
'PERSPECTIVE=Perspectief'#13+
'ANGLE=Hoek'#13+
'ORTHOGONAL=Orthogonaal'#13+
'ZOOM TEXT=Zoom Tekst'#13+
'SCALES=Schalen'#13+
'TICKS=Tekens'#13+
'MINOR=Ondergeschikt'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Toename'#13+
'(INCREMENT)=(verhoging)'#13+
'LOG BASE=Log.Basis'#13+
'LOGARITHMIC=Logaritmisch'#13+
'MIN. SEPARATION %=Min. Scheiding %'#13+
'MULTI-LINE=Dubbele lijn'#13+
'LABEL ON AXIS=Labels op as'#13+
'ROUND FIRST=Afronden'#13+
'MARK=Teken'#13+
'LABELS FORMAT=Opmaak labels'#13+
'EXPONENTIAL=Exponentiëel'#13+
'DEFAULT ALIGNMENT=Standaard uitlijning'#13+
'LEN=Len'#13+
'INNER=Binnenin'#13+
'AT LABELS ONLY=Enkel Bij Labels'#13+
'CENTERED=Gecentreerd'#13+
'POSITION %=Positie %'#13+
'START %=Start %'#13+
'END %=Einde %'#13+
'OTHER SIDE=Andere zijde'#13+
'AXES=Assen'#13+
'BEHIND=Achteraan'#13+
'CLIP POINTS=Clip Punten'#13+
'PRINT PREVIEW=Afdrukvoorbeeld'#13+
'MINIMUM PIXELS=Minimum pixels'#13+
'ALLOW=Toelaten'#13+
'ANIMATED=Geanimeerd'#13+
'ALLOW SCROLL=Scrollen Toestaan'#13+
'TEEOPENGL EDITOR=TeeOpenGL Editor'#13+
'AMBIENT LIGHT=Omringend Licht'#13+
'SHININESS=Schijning'#13+
'FONT 3D DEPTH=Lettertype 3D Diepte'#13+
'ACTIVE=Actief'#13+
'FONT OUTLINES=Lettertype Uitlijnen'#13+
'SMOOTH SHADING=Zachte Arcering'#13+
'LIGHT=Licht'#13+
'Y=Y'#13+
'INTENSITY=Intensiteit'#13+
'BEVEL=Helling'#13+
'FRAME=Rand'#13+
'ROUND FRAME=Ronde rand'#13+
'LOWERED=Dieper'#13+
'RAISED=Verheven'#13+
'SYMBOLS=Symbolen'#13+
'TEXT STYLE=Tekststijl'#13+
'LEGEND STYLE=Legendestijl'#13+
'VERT. SPACING=Vert.Afstand'#13+
'SERIES NAMES=Series Namen'#13+
'SERIES VALUES=Series Waarden'#13+
'LAST VALUES=Laatste Waarden'#13+
'PLAIN=Gewoon'#13+
'LEFT VALUE=Linker Waarde'#13+
'RIGHT VALUE=Rechter Waarde'#13+
'LEFT PERCENT=Linker Percent'#13+
'RIGHT PERCENT=Rechter Percent'#13+
'X VALUE=X Waarde'#13+
'X AND VALUE=X en Waarde'#13+
'X AND PERCENT=X en Percent'#13+
'CHECK BOXES=Aankruisvakjes'#13+
'DIVIDING LINES=Scheidingslijnen'#13+
'FONT SERIES COLOR=Kleur van de reeks'#13+
'POSITION OFFSET %=Tegengewicht %'#13+
'MARGIN=Marge'#13+
'RESIZE CHART=Grafiekafmetingen wijzigen'#13+
'CONTINUOUS=Continu'#13+
'POINTS PER PAGE=Punten per Pagina'#13+
'SCALE LAST PAGE=Schaal Laatste Pagina'#13+
'CURRENT PAGE LEGEND=Huidige pagina Legende'#13+
'PANEL EDITOR=Paneel Editor'#13+
'BACKGROUND=Achtergrond'#13+
'BORDERS=Randen'#13+
'BACK IMAGE=Achtergrond Figuur'#13+
'STRETCH=Rekken'#13+
'TILE=Betegelen'#13+
'BEVEL INNER=Binnenste Rand'#13+
'BEVEL OUTER=Buitenste Rand'#13+
'MARKS=Etiketten'#13+
'DATA SOURCE=Gegevensbron'#13+
'SORT=Sorteer'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=In Legende Tonen'#13+
'FORMATS=Opmaak'#13+
'VALUES=Waarden'#13+
'PERCENTS=Percenten'#13+
'HORIZONTAL AXIS=Horizontale As'#13+
'DATETIME=Datum/Tijd'#13+
'VERTICAL AXIS=Verticale As'#13+
'ASCENDING=Stijgend'#13+
'DESCENDING=Dalend'#13+
'DRAW EVERY=Tekenen elke'#13+
'CLIPPED=Gekapt'#13+
'ARROWS=Pijlen'#13+
'MULTI LINE=Meerdere Lijnen'#13+
'ALL SERIES VISIBLE=Alle Series Zichtbaar'#13+
'LABEL=Merkte.'#13+
'LABEL AND PERCENT=Merkteken en Percent'#13+
'LABEL AND VALUE=Merkteken en Waarde'#13+
'PERCENT TOTAL=Totaal Percenten'#13+
'LABEL & PERCENT TOTAL=Merkteken en totaal Procenten'#13+
'X AND Y VALUES=X en Y waarden'#13+
'MANUAL=Manueel'#13+
'RANDOM=Willekeurig'#13+
'FUNCTION=Functie'#13+
'NEW=Nieuw'#13+
'EDIT=Bewerk'#13+
'PERSISTENT=Aanhoudend'#13+
'ADJUST FRAME=Kader Auto.'#13+
'SUBTITLE=SubTitel'#13+
'SUBFOOT=SubVoet'#13+
'FOOT=Voet'#13+
'VISIBLE WALLS=Zichtbare Wanden'#13+
'BACK=Achteraan'#13+
'DIF. LIMIT=Verschil Limiet'#13+
'ABOVE=Boven'#13+
'WITHIN=Tussenin'#13+
'BELOW=Onder'#13+
'CONNECTING LINES=Lijnen Verbinden'#13+
'BROWSE=Bladeren'#13+
'TILED=Betegelen'#13+
'INFLATE MARGINS=Marges verbreden'#13+
'SQUARE=Vierkant'#13+
'DOWN TRIANGLE=Hangende Driehoek'#13+
'SMALL DOT=Kleine Stip'#13+
'GLOBAL=Algemeen'#13+
'SHAPES=Vormen'#13+
'BRUSH=Borstel'#13+
'DELAY=Vertragen'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Muis actie'#13+
'MOVE=Beweging'#13+
'CLICK=Klik'#13+
'DRAW LINE=Teken Lijn'#13+
'EXPLODE BIGGEST=Grootste Uitlichten'#13+
'TOTAL ANGLE=Totale hoek'#13+
'GROUP SLICES=Schijven Groeperen'#13+
'BELOW %=Onder %'#13+
'BELOW VALUE=Onder Waarde'#13+
'OTHER=Andere'#13+
'PATTERNS=Patronen'#13+
'SIZE %=Grootte %'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Teksteditor'#13+
'FIELDS=Velden'#13+
'NUMBER OF HEADER LINES=Aantal Hoofdlijnen'#13+
'SEPARATOR=Scheiding'#13+
'COMMA=Komma'#13+
'SPACE=Spatie'#13+
'TAB=Tab'#13+
'FILE=Bestand'#13+
'WEB URL=Web URL'#13+
'LOAD=Laden'#13+
'C LABELS=C Labels'#13+
'R LABELS=R Labels'#13+
'C PEN=C Pen'#13+
'R PEN=R Pen'#13+
'STACK GROUP=Stapel Groep'#13+
'MULTIPLE BAR=Meerdere Kolommen'#13+
'SIDE=Zijkant'#13+
'SIDE ALL=Alle Zijden'#13+
'DRAWING MODE=Tekenen'#13+
'WIREFRAME=Draden'#13+
'DOTFRAME=Punten'#13+
'SMOOTH PALETTE=Zacht palet'#13+
'SIDE BRUSH=Borstel'#13+
'ABOUT TEECHART PRO V7.0=Info TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Alle Rechten Voorbehouden.'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=Export Wizard'#13+
'SELECT A CHART STYLE=Selecteer Grafiek Type'#13+
'DATABASE CHART=Database Grafiek'#13+
'NON DATABASE CHART=Niet Database Grafiek'#13+
'SELECT A DATABASE TABLE=Selecteer een Database Tabel'#13+
'ALIAS=Alias'#13+
'TABLE=Tabel'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Selecteer de gewenste velden voor Grafiek'#13+
'SELECT A TEXT LABELS FIELD=Selecteer een tekst labels veld'#13+
'CHOOSE THE DESIRED CHART TYPE=Kies het gewenste Grafiek type'#13+
'2D=2D'#13+
'CHART PREVIEW=Grafiek Voorbeeld'#13+
'SHOW LEGEND=Toon Legende'#13+
'SHOW MARKS=Toon Punten'#13+
'< BACK=< Terug'#13+
'EXPORT CHART=Export Chart'#13+
'PICTURE=Figuur'#13+
'NATIVE=Oorsprong'#13+
'KEEP ASPECT RATIO=Ratio behouden'#13+
'INCLUDE SERIES DATA=Reeks-Gegevens Invoegen'#13+
'FILE SIZE=Bestandsgrootte'#13+
'DELIMITER=Scheidingsteken:'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabel'#13+
'EXCEL=Excel'#13+
'COLON=Puntkomma'#13+
'INCLUDE=Invoegen'#13+
'POINT LABELS=Etiketten'#13+
'POINT INDEX=Waarden'#13+
'HEADER=Hoofding'#13+
'COPY=Kopiëren'#13+
'SAVE=Opslaan'#13+
'SEND=Versturen'#13+
'FUNCTIONS=Functies'#13+
'ADX=ADX'#13+
'AVERAGE=Gemiddelde'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Delen'#13+
'EXP. AVERAGE=Exp.Gemiddelde'#13+
'EXP.MOV.AVRG.=Exp.Lop.Gemiddelde'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Lopend Gemiddelde'#13+
'MULTIPLY=Vermenigvuldigen'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Vierkantswortel'#13+
'STD.DEVIATION=Std.Deviatie'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Aftrekken'#13+
'SOURCE SERIES=Gegevens'#13+
'TEECHART GALLERY=Galerij'#13+
'DITHER=Afwijking'#13+
'REDUCTION=Verkleining'#13+
'COMPRESSION=Compressie'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Dichtste'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Grijs'#13+
'GRAY SCALE=Grijs Schaal'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Kwaliteit'#13+
'PERFORMANCE=Prestatie'#13+
'QUALITY=Kwaliteit'#13+
'SPEED=Snelheid'#13+
'COMPRESSION LEVEL=Compressie niveau'#13+
'CHART TOOLS GALLERY=Galerij gereedschap'#13+
'ANNOTATION=Aanduiding'#13+
'AXIS ARROWS=Pijlen op as'#13+
'COLOR BAND=Gekleurde band'#13+
'COLOR LINE=Gekleurde lijn'#13+
'DRAG MARKS=Etiketten slepen'#13+
'MARK TIPS=Etiketten'#13+
'NEAREST POINT=Dichtstbijzijnde punt'#13+
'ROTATE=Ronddraaien'#13+

{$IFDEF TEEOCX}
{ADO Editor}
'TEECHART PRO -- SELECT ADO DATASOURCE=Kies de oorsprong met ADO gegevens'#13+
'CONNECTION=Verbinding'#13+
'DATASET=Dataset'#13+
'TABLE=Tabel'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=Systeem tabellen'#13+
'LOGIN PROMPT=Paswoord'#13+
'SELECT=Kies'#13+
{Dialoog importeren}
'TEECHART IMPORT=Grafiek importeren'#13+
'IMPORT CHART FROM=Importeer Grafiek van'#13+
'IMPORT NOW=Importeer nu'#13+
{Property page}
'EDIT CHART=Grafiek bewerken'#13+
{$ENDIF}

// 6.0

'BEVEL SIZE=Zwaaihoek'#13+
'DELETE ROW=Rij verwijderen'#13+
'VOLUME SERIES=Volume reeksen'#13+
'SINGLE=Enkelvoudig'#13+
'REMOVE CUSTOM COLORS=Verwijder standaard kleuren'#13+
'USE PALETTE MINIMUM=Gebruik minimum palet'#13+
'AXIS MAXIMUM=Maximum As'#13+
'AXIS CENTER=Gecentreerde As'#13+
'AXIS MINIMUM=Minimum As'#13+
'DAILY (NONE)=Dagelijks (geen)'#13+
'WEEKLY=Wekelijks'#13+
'MONTHLY=Maandelijks'#13+
'BI-MONTHLY=Twee-Maandelijks'#13+
'QUARTERLY=Trimestrieel'#13+
'YEARLY=Jaarlijks'#13+
'DATETIME PERIOD=Datumtijd periode'#13+
'CASE SENSITIVE=Lettertype gevoelig'#13+
'DRAG STYLE=Spleep stijl'#13+
'SQUARED=Gehoekt'#13+
'GRID 3D SERIES=3D rooster reeksen'#13+
'DARK BORDER=Donkere rand'#13+
'PIE SERIES=Taart reeksen'#13+
'FOCUS=Brandpunt'#13+
'EXPLODE=Ontploffen'#13+
'FACTOR=Factor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafiek vanuit template (*.tee bestand)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Template grafiek openen vanuit'#13+
'BINARY=Binair'#13+
'VOLUME OSCILLATOR=Volume Oscillator'#13+
'PIE SLICES=Taartstukken'#13+
'ARROW WIDTH=Pijlbreedte'#13+
'ARROW HEIGHT=Pijlhoogte'#13+
'DEFAULT COLOR=Standaardkleur'
;
  end;
end;

Procedure TeeSetDutch;
begin
  TeeCreateDutch;
  TeeLanguage:=TeeDutchLanguage;
  TeeDutchConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeDutchLanguage);
end.
