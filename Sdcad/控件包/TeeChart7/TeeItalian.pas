unit TeeItalian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeItalianLanguage:TStringList=nil;

Procedure TeeSetItalian;
Procedure TeeCreateItalian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeItalianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='Il primo valore della leggenda deve essere > 0';
  TeeMsg_LegendColorWidth   :='L''ampiezza di colore della leggenda deve essere > 0%';
  TeeMsg_SeriesSetDataSource:='Non c''è grafico generatore per convalidare la Fonte Dati';
  TeeMsg_SeriesInvDataSource:='Nessuna Fonte Dati valida: %s';
  TeeMsg_FillSample         :='NumValori di RiempiValoriEsempio  deve essere > 0';
  TeeMsg_AxisLogDateTime    :='L''asse dei tempi non può essere logaritmico';
  TeeMsg_AxisLogNotPositive :='I valori Min. e Max. degli assi logaritmici devono essere >= 0';
  TeeMsg_AxisLabelSep       :='La separazione delle etichette % deve essere > 0';
  TeeMsg_AxisIncrementNeg   :='L''incremento degli assi deve essere  >= 0';
  TeeMsg_AxisMinMax         :='Il valore Minimo degli assi deve essere <= Maximum';
  TeeMsg_AxisMaxMin         :='Il valore Massimo degli assi deve essere >= Minimo';
  TeeMsg_AxisLogBase        :='La base degli assi logaritmici deve essere >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPuntiPerPagina deve essere >= 0';
  TeeMsg_3dPercent          :='La percentuale dell''effetto 3D deve essere fra %d e %d';
  TeeMsg_CircularSeries     :='Non sono permesse dipendenze circolari nelle Serie';
  TeeMsg_WarningHiColor     :='Per ottenere un miglior aspetto serve Colore di 16k o maggiore';

  TeeMsg_DefaultPercentOf   :='%s di %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'di %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Titolo degli Assi';
  TeeMsg_AxisLabels         :='Etichette degli Assi';
  TeeMsg_RefreshInterval    :='L''Intervallo d''Aggiornamento deve essere fra 0 e 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart non è me stesso!';
  TeeMsg_GalleryLine        :='Linea';
  TeeMsg_GalleryPoint       :='Punto';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Barre';
  TeeMsg_GalleryHorizBar    :='Barre Orizz.';
  TeeMsg_Stack              :='Pila';
  TeeMsg_GalleryPie         :='Torta';
  TeeMsg_GalleryCircled     :='Circolare';
  TeeMsg_GalleryFastLine    :='Linea Veloce';
  TeeMsg_GalleryHorizLine   :='Linea Orizz.';

  TeeMsg_PieSample1         :='Auto';
  TeeMsg_PieSample2         :='Telefoni';
  TeeMsg_PieSample3         :='Tavole';
  TeeMsg_PieSample4         :='Monitor';
  TeeMsg_PieSample5         :='Lampade';
  TeeMsg_PieSample6         :='Tastiere';
  TeeMsg_PieSample7         :='Biciclette';
  TeeMsg_PieSample8         :='Sedie';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editando %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Aggiuntive';
  TeeMsg_GalleryFunctions   :='Funzioni';

  TeeMsg_EditChart          :='E&dita Grafico...';
  TeeMsg_PrintPreview       :='&Anteprima Stampa...';
  TeeMsg_ExportChart        :='E&sporta Grafico...';
  TeeMsg_CustomAxes         :='Assi Personalizzati...';

  TeeMsg_InvalidEditorClass :='%s: Classe Editor non valida: %s';
  TeeMsg_MissingEditorClass :='%s: non ha dialogo di editor';

  TeeMsg_GalleryArrow       :='Freccia';

  TeeMsg_ExpFinish          :='&Finire';
  TeeMsg_ExpNext            :='&Prossimo >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Progettazione';
  TeeMsg_GanttSample2       :='Prototipizzazione';
  TeeMsg_GanttSample3       :='Sviluppo';
  TeeMsg_GanttSample4       :='Vendite';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Produzione';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Nuova Versione';
  TeeMsg_GanttSample10      :='Finanza';

  TeeMsg_ChangeSeriesTitle  :='Cambia il titolo delle serie';
  TeeMsg_NewSeriesTitle     :='Nuovo titolo delle serie:';
  TeeMsg_DateTime           :='Data/Ora';
  TeeMsg_TopAxis            :='Asse Superiore';
  TeeMsg_BottomAxis         :='Asse Inferiore';
  TeeMsg_LeftAxis           :='Asse Sinistro';
  TeeMsg_RightAxis          :='Asse Destro';

  TeeMsg_SureToDelete       :='Elimino %s?';
  TeeMsg_DateTimeFormat     :='For&mato Data/Ora:';
  TeeMsg_Default            :='Default';
  TeeMsg_ValuesFormat       :='For&mat Valori:';
  TeeMsg_Maximum            :='Massimo';
  TeeMsg_Minimum            :='Minimo';
  TeeMsg_DesiredIncrement   :='Incremento %s';

  TeeMsg_IncorrectMaxMinValue:='Valore non corretto. Motivo: %s';
  TeeMsg_EnterDateTime      :='Fornire [Numero di giorni] [oo:mm:ss]';

  TeeMsg_SureToApply        :='Applico le modifiche?';
  TeeMsg_SelectedSeries     :='(Serie selezionate)';
  TeeMsg_RefreshData        :='&Aggiorno dati';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='443';
  TeeMsg_FunctionAdd        :='Somma';
  TeeMsg_FunctionSubtract   :='Sottrai';
  TeeMsg_FunctionMultiply   :='Moltiplica';
  TeeMsg_FunctionDivide     :='Dividi';
  TeeMsg_FunctionHigh       :='Passa-Alto';
  TeeMsg_FunctionLow        :='Passa-Basso';
  TeeMsg_FunctionAverage    :='Media';

  TeeMsg_GalleryShape       :='Figura';
  TeeMsg_GalleryBubble      :='Bolla';
  TeeMsg_FunctionNone       :='Copia';

  TeeMsg_None               :='(nessuno)';

  TeeMsg_PrivateDeclarations:='{ Dichiarazioni private }';
  TeeMsg_PublicDeclarations :='{ Dichiarazioni pubbliche }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='La dimensione del puntatore deve essere maggiore di zero';
  TeeMsg_About              :='&Info TeeChart...';

  tcAdditional              :='Aggiuntive';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Singolo Record';
  TeeMsg_AskDataSource      :='&Fonte Dati:';

  TeeMsg_Summary            :='Sommario';

  TeeMsg_FunctionPeriod     :='Il periodo della funzione deve essere >= 0';

  TeeMsg_WizardTab          :='Affari';
  TeeMsg_TeeChartWizard     :='Assistente di TeeChart';

  TeeMsg_ClearImage         :='&Ripulisci';
  TeeMsg_BrowseImage        :='S&eleziona...';

  TeeMsg_WizardSureToClose  :='Sei sicuro che vuoi chiudere l''assistente di TeeChart?';
  TeeMsg_FieldNotFound      :='Il campo %s non esiste';

  TeeMsg_DepthAxis          :='Asse profondità';
  TeeMsg_PieOther           :='Altro';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Torta';
  TeeMsg_ValuesBar          :='Barre';
  TeeMsg_ValuesAngle        :='Angolo';
  TeeMsg_ValuesGanttStart   :='Inizio';
  TeeMsg_ValuesGanttEnd     :='Fine';
  TeeMsg_ValuesGanttNextTask:='ProssimaTask';
  TeeMsg_ValuesBubbleRadius :='Raggio';
  TeeMsg_ValuesArrowEndX    :='X fine';
  TeeMsg_ValuesArrowEndY    :='Y fine';
  TeeMsg_Legend             :='Leggenda';
  TeeMsg_Title              :='Titolo';
  TeeMsg_Foot               :='Piè Pagina';
  TeeMsg_Period		    :='Periodo';
  TeeMsg_PeriodRange        :='Estensione del periodo';
  TeeMsg_CalcPeriod         :='Calcola %s ogni:';
  TeeMsg_SmallDotsPen       :='Piccolo Punto';

  TeeMsg_InvalidTeeFile     :='File *.'+TeeMsg_TeeExtension+' con grafico non valido ';
  TeeMsg_WrongTeeFileFormat :='File *.'+TeeMsg_TeeExtension+' di formato errato';
  TeeMsg_EmptyTeeFile       :='File *.'+TeeMsg_TeeExtension+' vuoto';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Assi del grafico';
  TeeMsg_ChartAxesCategoryDesc   := 'Proprietà ed eventi degli assi del grafico';
  TeeMsg_ChartWallsCategoryName  := 'Pareti del grafico';
  TeeMsg_ChartWallsCategoryDesc  := 'Proprietà ed eventi delle pareti del grafico';
  TeeMsg_ChartTitlesCategoryName := 'Titoli del grafico';
  TeeMsg_ChartTitlesCategoryDesc := 'Proprietà ed eventi dei titoli del grafico';
  TeeMsg_Chart3DCategoryName     := 'Grafico 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Proprietà ed eventi del grafico 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalizzato ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serie...';

  TeeMsg_PageOfPages            :='Pagina %d di %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primo';
  TeeMsg_Prior  :='Precedente';
  TeeMsg_Next   :='Successivo';
  TeeMsg_Last   :='Ultimo';
  TeeMsg_Insert :='Inserire';
  TeeMsg_Delete :='Cancellare';
  TeeMsg_Edit   :='Editare';
  TeeMsg_Post   :='Impostare';
  TeeMsg_Cancel :='Annullare';

  TeeMsg_All    :='(Tutto)';
  TeeMsg_Index  :='Indice';
  TeeMsg_Text   :='Testo';

  TeeMsg_AsBMP        :='come &Bitmap';
  TeeMsg_BMPFilter    :='Bitmap (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='Come &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Nel formato d''esportazione non é impostata la proprietá del pannello';

  TeeMsg_Normal    :='Normale';
  TeeMsg_NoBorder  :='Nessuna cornice';
  TeeMsg_Dotted    :='Punteggiato';
  TeeMsg_Colors    :='Colori';
  TeeMsg_Filled    :='Riempito';
  TeeMsg_Marks     :='Contrassegni';
  TeeMsg_Stairs    :='Gradini';
  TeeMsg_Points    :='Punti';
  TeeMsg_Height    :='Altezza';
  TeeMsg_Hollow    :='Cavità';
  TeeMsg_Point2D   :='Punti 2D';
  TeeMsg_Triangle  :='Triangoli';
  TeeMsg_Star      :='Stella';
  TeeMsg_Circle    :='Cerchio';
  TeeMsg_DownTri   :='Triang. in giù';
  TeeMsg_Cross     :='Croce';
  TeeMsg_Diamond   :='Diamante';
  TeeMsg_NoLines   :='Senza Linee';
  TeeMsg_Stack100  :='Impilato 100%';
  TeeMsg_Pyramid   :='Piramide';
  TeeMsg_Ellipse   :='Ellisse';
  TeeMsg_InvPyramid:='Piramide inv.';
  TeeMsg_Sides     :='Fianchi';
  TeeMsg_SideAll   :='Tutti i fianchi';
  TeeMsg_Patterns  :='Motivo';
  TeeMsg_Exploded  :='Esploso';
  TeeMsg_Shadow    :='Ombra';
  TeeMsg_SemiPie   :='Semi torta';
  TeeMsg_Rectangle :='Rettangolo';
  TeeMsg_VertLine  :='Linea Vert.';
  TeeMsg_HorizLine :='Linea orizz.';
  TeeMsg_Line      :='Linea';
  TeeMsg_Cube      :='Cubo';
  TeeMsg_DiagCross :='Croce Diag.';

  TeeMsg_CanNotFindTempPath    :='Impossibile trovare la cartella Temp';
  TeeMsg_CanNotCreateTempChart :='Impossibile creare il file Temp';
  TeeMsg_CanNotEmailChart      :='Impossibile inviare per email il TeeChart. Errore Mapi: %d';

  TeeMsg_SeriesDelete :='Cancella le serie: l''indice del valore %d è fuori dai limiti (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='come &JPEG';
  TeeMsg_JPEGFilter    :='JPEG file (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='come &GIF';
  TeeMsg_GIFFilter     :='GIF file (*.gif)|*.gif';
  TeeMsg_AsPNG         :='come &PNG';
  TeeMsg_PNGFilter     :='PNG file (*.png)|*.png';
  TeeMsg_AsPCX         :='come PC&X';
  TeeMsg_PCXFilter     :='PCX file (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Lingua...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polare';
  TeeMsg_GalleryCandle      :='Candela';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Superficie';
  TeeMsg_GalleryContour     :='Contorno';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punto 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursore';
  TeeMsg_GalleryBar3D       :='Barre 3D';
  TeeMsg_GalleryBigCandle   :='Candela grande';
  TeeMsg_GalleryLinePoint   :='Punto-linea';
  TeeMsg_GalleryHistogram   :='Istogramma';
  TeeMsg_GalleryWaterFall   :='Cascata';
  TeeMsg_GalleryWindRose    :='Rosa dei venti';
  TeeMsg_GalleryClock       :='Orologio';
  TeeMsg_GalleryColorGrid   :='Griglia di colori';
  TeeMsg_GalleryBoxPlot     :='Riquad.Graf.vert.';
  TeeMsg_GalleryHorizBoxPlot:='Riquadr.Graf.orizz.';
  TeeMsg_GalleryBarJoin     :='Unione di barre';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramide';
  TeeMsg_GalleryMap         :='Mappa';

  TeeMsg_PolyDegreeRange    :='Il grado del polinomio deve essere fra 1 e 20';
  TeeMsg_AnswerVectorIndex   :='L''indice del vettore di risposta deve essere fra 1 and %d';
  TeeMsg_FittingError        :='Impossibile fare l''interpolazione';
  TeeMsg_PeriodRange         :='Il periodo deve essere >= 0';
  TeeMsg_ExpAverageWeight    :='Il peso della Media Esponenziale deve essere fra 0 and 1';
  TeeMsg_GalleryErrorBar     :='Barre d''errore';
  TeeMsg_GalleryError        :='Errore';
  TeeMsg_GalleryHighLow      :='Alto-Basso';
  TeeMsg_FunctionMomentum    :='Momento';
  TeeMsg_FunctionMomentumDiv :='Momento Divisione';
  TeeMsg_FunctionExpAverage  :='Media Esponenziale';
  TeeMsg_FunctionMovingAverage:='Media Mobile';
  TeeMsg_FunctionExpMovAve   :='Media Mobile Esponenz.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Interpolazione';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Trend exp.';
  TeeMsg_FunctionLogTrend    :='Trend log.';
  TeeMsg_FunctionCumulative  :='Cumulativo';
  TeeMsg_FunctionStdDeviation:='Deviazione std.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Radice Media Quadr.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stocastico';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Conto';
  TeeMsg_LoadChart           :='Apri TeeChart...';
  TeeMsg_SaveChart           :='Salva TeeChart...';
  TeeMsg_TeeFiles            :='File di TeeChart Pro';

  TeeMsg_GallerySamples      :='Altro';
  TeeMsg_GalleryStats        :='Statistiche';

  TeeMsg_CannotFindEditor    :='Impossibile trovare il modulo dell''editor delle serie: %s';


  TeeMsg_CannotLoadChartFromURL:='Codice errore: %d nel download del grafico dall''URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Codice errore: %d nel download dei dati delle serie dall''URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Apri';
  TeeMsg_ValuesHigh          :='Alto';
  TeeMsg_ValuesLow           :='Basso';
  TeeMsg_ValuesClose         :='Chiudi';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='Errore Std';

  TeeMsg_Grid3D              :='Griglia 3D';

  TeeMsg_LowBezierPoints     :='Il numero dei punti Bezier deve essere > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normale';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Stampa';
  TeeCommanMsg_Copy     :='Copia';
  TeeCommanMsg_Save     :='Salva';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotazione: %d° Elevazione: %d°';
  TeeCommanMsg_Rotate   :='Ruota';

  TeeCommanMsg_Moving   :='Spostam. orizz.: %d Spostam. Vert.: %d';
  TeeCommanMsg_Move     :='Sposta';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Profondità';

  TeeCommanMsg_Chart    :='Grafico';
  TeeCommanMsg_Panel    :='Panello';

  TeeCommanMsg_RotateLabel:='Trascinare %s per Ruotare';
  TeeCommanMsg_MoveLabel  :='Trascinare %s per Spostare';
  TeeCommanMsg_ZoomLabel  :='Trascinare %s per Fare Zoom';
  TeeCommanMsg_DepthLabel :='Trascinare %s per ridimensionare 3D';

  TeeCommanMsg_NormalLabel:='Trascinare con tasto sinistro per ingrandire, con destro per spostare';
  TeeCommanMsg_NormalPieLabel:='Trascinare una fetta di torta per espanderla';

  TeeCommanMsg_PieExploding :='Fetta: %d Espansa: %d %%';

  TeeMsg_TriSurfaceLess        :='Il numero di punti deve essere >= 4';
  TeeMsg_TriSurfaceAllColinear :='Tutti i punti sono allineati';
  TeeMsg_TriSurfaceSimilar     :='Punti simili - impossibile eseguire';
  TeeMsg_GalleryTriSurface     :='Superf. triangolare';

  TeeMsg_AllSeries :='Tutte le serie';
  TeeMsg_Edit      :='Edit';

  TeeMsg_GalleryFinancial    :='Finanziario';

  TeeMsg_CursorTool    :='Cursore';
  TeeMsg_DragMarksTool :='Trascinare i contrassegni';
  TeeMsg_AxisArrowTool :='Frecce sugli assi';
  TeeMsg_DrawLineTool  :='Disegna linee';
  TeeMsg_NearestTool   :='Punti più vicini';
  TeeMsg_ColorBandTool :='Bande di colore';
  TeeMsg_ColorLineTool :='Linee di colore';
  TeeMsg_RotateTool    :='Ruota';
  TeeMsg_ImageTool     :='Immagine';
  TeeMsg_MarksTipTool  :='Suggerimenti dei contrassegni';

  TeeMsg_CantDeleteAncestor  :='Impossibile cancellare l''antenato';

  TeeMsg_Load	          :='Carica...';
  TeeMsg_NoSeriesSelected :='Nessuna serie selezionata';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafico';
  TeeMsg_CategorySeriesActions :='Serie del grafico';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Commuta 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Attivo';
  TeeMsg_ActionSeriesActiveHint := 'Mostra/Nascondi Serie';
  TeeMsg_ActionEditHint         := 'Edit grafico';
  TeeMsg_ActionEdit             := '&Edit...';
  TeeMsg_ActionCopyHint         := 'Copia in Clipboard';
  TeeMsg_ActionCopy             := '&Copia';
  TeeMsg_ActionPrintHint        := 'Anteprima stampa grafico';
  TeeMsg_ActionPrint            := '&Stampa...';
  TeeMsg_ActionAxesHint         := 'Mostra/Nascondi Assi';
  TeeMsg_ActionAxes             := '&Assi';
  TeeMsg_ActionGridsHint        := 'Mostra/Nascondi Griglie';
  TeeMsg_ActionGrids            := '&Griglie';
  TeeMsg_ActionLegendHint       := 'Mostra/Nascondi Leggenda';
  TeeMsg_ActionLegend           := '&Leggenda';
  TeeMsg_ActionSeriesEditHint   := 'Edit Serie';
  TeeMsg_ActionSeriesMarksHint  := 'Mostra/Nascondi Contrass. Serie';
  TeeMsg_ActionSeriesMarks      := '&Contrass.';
  TeeMsg_ActionSaveHint         := 'Salva grafico';
  TeeMsg_ActionSave             := '&Salva...';

  TeeMsg_CandleBar              := 'Barre';
  TeeMsg_CandleNoOpen           := 'Senza Aprire';
  TeeMsg_CandleNoClose          := 'Senza Chiudere';
  TeeMsg_NoLines                := 'Senza Linee';
  TeeMsg_NoHigh                 := 'Senza valore alto';
  TeeMsg_NoLow                  := 'Senza valore basso';
  TeeMsg_ColorRange             := 'Estensione colore';
  TeeMsg_WireFrame              := 'Cornice a filo';
  TeeMsg_DotFrame               := 'Cornice a punti';
  TeeMsg_Positions              := 'Posizioni';
  TeeMsg_NoGrid                 := 'Senza griglia';
  TeeMsg_NoPoint                := 'Senza punto';
  TeeMsg_NoLine                 := 'Senza linea';
  TeeMsg_Labels                 := 'Etichette';
  TeeMsg_NoCircle               := 'Senza cerchio';
  TeeMsg_Lines                  := 'Linee';
  TeeMsg_Border                 := 'Bordo';

  TeeMsg_SmithResistance      := 'Resistenza';
  TeeMsg_SmithReactance       := 'Reattanza';

  TeeMsg_Column               := 'Colonna';

  { 5.01 }
  TeeMsg_Separator            := 'Separatore';
  TeeMsg_FunnelSegment        := 'Segmento ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Eccede quota';
  TeeMsg_FunnelWithin         := ' nella quota';
  TeeMsg_FunnelBelow          := ' o al di sotto quota';
  TeeMsg_CalendarSeries       := 'Calendario';
  TeeMsg_DeltaPointSeries     := 'Andamento';
  TeeMsg_ImagePointSeries     := 'Punti Immagine';
  TeeMsg_ImageBarSeries       := 'Barre Immagine';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: l''indice del campo deve essere maggiore di zero.';

  { 5.02 }
  TeeMsg_Origin               := 'Origine';
  TeeMsg_Transparency         := 'Trasparenza';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Numero pagina';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Punti';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

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

// 6.0
// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='come &PDF';
  TeeMsg_PDFFilter        :='file PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='come PostScript';
  TeeMsg_PSFilter         :='file PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Area'#13'Orizzontale';
  TeeMsg_SelfStack        :='Auto Accatastato';
  TeeMsg_DarkPen          :='Bordo Scuro';
  TeeMsg_SelectFolder     :='Selezionare la cartella del database';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Connessione:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Smussare';
  TeeMsg_FunctionCross        :='Punti a Croce';
  TeeMsg_GridTranspose        :='Trasposizione Griglia 3D';
  TeeMsg_FunctionCompress     :='Compressione';
  TeeMsg_ExtraLegendTool      :='Leggenda Aggiuntiva';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillatore';
  TeeMsg_SeriesAnimTool       :='Animazione Serie';
  TeeMsg_GalleryPointFigure   :='Punto & Figura';
  TeeMsg_Up                   :='Su';
  TeeMsg_Down                 :='Giú';
  TeeMsg_GanttTool            :='Trascinamento Gantt';
  TeeMsg_XMLFile              :='file XML';
  TeeMsg_GridBandTool         :='Strumento fascia di griglia';
  TeeMsg_FunctionPerf         :='Prestazione';
  TeeMsg_GalleryGauge         :='Calibro';
  TeeMsg_GalleryGauges        :='Calibri';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vettore 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torre';
  TeeMsg_SingleColor          :='Colore Unico';
  TeeMsg_Cover                :='Copertina';
  TeeMsg_Cone                 :='Cono';
  TeeMsg_PieTool              :='Fette di Torta';

end;

Procedure TeeCreateItalian;
begin
  if not Assigned(TeeItalianLanguage) then
  begin
    TeeItalianLanguage:=TStringList.Create;
    TeeItalianLanguage.Text:=

'GRADIENT EDITOR=Editor Gradiente'#13+
'GRADIENT=Gradiente'#13+
'DIRECTION=Direzione'#13+
'VISIBLE=Visibile'#13+
'TOP BOTTOM=Dall''Alto al Basso'#13+
'BOTTOM TOP=Dal Basso al Alto'#13+
'LEFT RIGHT=Da Sinistra a Destra'#13+
'RIGHT LEFT=Da Destra a Sinistra'#13+
'FROM CENTER=Dal Centro'#13+
'FROM TOP LEFT=Dall''Alto a Sinistra'#13+
'FROM BOTTOM LEFT=Dal Basso a Destra'#13+
'OK=Ok'#13+
'CANCEL=Annulla'#13+
'COLORS=Colori'#13+
'START=Inizio'#13+
'MIDDLE=Centro'#13+
'END=Fine'#13+
'SWAP=Scambio'#13+
'NO MIDDLE=Senza centro'#13+
'TEEFONT EDITOR=Editor dei Caratteri'#13+
'INTER-CHAR SPACING=Spaziatura fra i Caratteri'#13+
'FONT=Carattere'#13+
'SHADOW=Ombra'#13+
'HORIZ. SIZE=Dimens. Orizz.'#13+
'VERT. SIZE=Dimens.   Vert.'#13+
'COLOR=Colore'#13+
'OUTLINE=Bordo'#13+
'OPTIONS=Opzioni'#13+
'FORMAT=Formato'#13+
'TEXT=Testo'#13+
'POSITION=Posizione'#13+
'TOP=Alto'#13+
'AUTO=Auto'#13+
'CUSTOM=Personal'#13+
'LEFT TOP=Sinistra alto'#13+
'LEFT BOTTOM=Sinistra basso'#13+
'RIGHT TOP=Destra alto'#13+
'RIGHT BOTTOM=Destra basso'#13+
'MULTIPLE AREAS=Aree Multiple'#13+
'NONE=Nessuno'#13+
'STACKED=Impilato'#13+
'STACKED 100%=Impilato 100%'#13+
'AREA=Area'#13+
'PATTERN=Motivo'#13+
'STAIRS=Gradini'#13+
'SOLID=Solido'#13+
'CLEAR=Chiaro'#13+
'HORIZONTAL=Orizzontale'#13+
'VERTICAL=Verticale'#13+
'DIAGONAL=Diagonale'#13+
'B.DIAGONAL=B.Diagonale'#13+
'CROSS=Croce'#13+
'DIAG.CROSS=Croce Diag.'#13+
'AREA LINES=Linee Area'#13+
'BORDER=Cornice'#13+
'INVERTED=Invertito'#13+
'INVERTED SCROLL=Spostam.&Invertito'#13+
'COLOR EACH=Colorare'#13+
'ORIGIN=Origine'#13+
'USE ORIGIN=Usare Origine'#13+
'WIDTH=Ampiezza'#13+
'HEIGHT=Altezza'#13+
'AXIS=Asse'#13+
'LENGTH=Lunghezza'#13+
'SCROLL=Spostamento'#13+
'BOTH=Entrambi'#13+
'AXIS INCREMENT=Incremento Assi'#13+
'INCREMENT=Incremento'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Un Millisecondo'#13+
'ONE SECOND=Un Secondo'#13+
'FIVE SECONDS=Cinque Secondi'#13+
'TEN SECONDS=Dieci Secondi'#13+
'FIFTEEN SECONDS=Quindici Secondi'#13+
'THIRTY SECONDS=Trenta Secondi'#13+
'ONE MINUTE=Un Minuto'#13+
'FIVE MINUTES=Cinque Minuti'#13+
'TEN MINUTES=Dieci Minuti'#13+
'FIFTEEN MINUTES=Quindici Minuti'#13+
'THIRTY MINUTES=Trenta Minuti'#13+
'ONE HOUR=Una Ora'#13+
'TWO HOURS=Due Ore'#13+
'SIX HOURS=Sei Ore'#13+
'TWELVE HOURS=Dodici Ore'#13+
'ONE DAY=Un Giorno'#13+
'TWO DAYS=Due Giorni'#13+
'THREE DAYS=Tre Giorni'#13+
'ONE WEEK=Una Settimana'#13+
'HALF MONTH=Mezzo Mese'#13+
'ONE MONTH=Un Mese'#13+
'TWO MONTHS=Due Mesi'#13+
'THREE MONTHS=Tre Mesi'#13+
'FOUR MONTHS=Quattro Mesi'#13+
'SIX MONTHS=Sei Mesi'#13+
'ONE YEAR=Un Anno'#13+
'EXACT DATE TIME=Data Esatta'#13+
'AXIS MAXIMUM AND MINIMUM=Asse Massimo e Minimo'#13+
'VALUE=Valore'#13+
'TIME=Ora'#13+
'LEFT AXIS=Asse Sinistro'#13+
'RIGHT AXIS=Asse Destro'#13+
'TOP AXIS=Asse Superiore'#13+
'BOTTOM AXIS=Asse Inferiore'#13+
'% BAR WIDTH=Larghezza % Barre'#13+
'STYLE=Stile'#13+
'% BAR OFFSET=Spostamento % Barre'#13+
'RECTANGLE=Rettangolo'#13+
'PYRAMID=Piramide'#13+
'INVERT. PYRAMID=Piramide Rovesciata'#13+
'CYLINDER=Cilindro'#13+
'ELLIPSE=Ellisse'#13+
'ARROW=Freccia'#13+
'RECT. GRADIENT=Rett. Gradiente'#13+
'CONE=Cono'#13+
'DARK BAR 3D SIDES=Lati Scuri della Barra 3D'#13+
'BAR SIDE MARGINS=Margini Laterali Barra'#13+
'AUTO MARK POSITION=Posizione Contrass. Autom.'#13+
'JOIN=Unione'#13+
'DATASET=DataSet'#13+
'APPLY=Applica'#13+
'SOURCE=Origine'#13+
'MONOCHROME=Monocromatico'#13+
'DEFAULT=Default'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Filo'#13+
'PATTERN COLOR EDITOR=Editor di Motivi'#13+
'IMAGE=Immagine'#13+
'BACK DIAGONAL=Diagonale Rovesciata'#13+
'DIAGONAL CROSS=Croce Diagonale'#13+
'FILL 80%=Riempimento 80%'#13+
'FILL 60%=Riempimento 60%'#13+
'FILL 40%=Riempimento 40%'#13+
'FILL 20%=Riempimento 20%'#13+
'FILL 10%=Riempimento 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Verticale Piccolo'#13+
'HORIZ. SMALL=Orizz. Piccolo'#13+
'DIAG. SMALL=Diag. Piccolo'#13+
'BACK DIAG. SMALL=Diag. Rovesc. Piccola'#13+
'CROSS SMALL=Croce Piccola'#13+
'DIAG. CROSS SMALL=Croce Diag. Piccola'#13+
'DAYS=Giorni'#13+
'WEEKDAYS=Giorni Settimana'#13+
'TODAY=Oggi'#13+
'SUNDAY=Domenica'#13+
'TRAILING=Altri Giorni'#13+
'MONTHS=Mesi'#13+
'LINES=Linee'#13+
'SHOW WEEKDAYS=Giorni Settimana'#13+
'UPPERCASE=Maiuscolo'#13+
'TRAILING DAYS=Vedi Altri Giorni'#13+
'SHOW TODAY=Mostra Giorno Attuale'#13+
'SHOW MONTHS=Mostra i Mesi'#13+
'SHOW PREVIOUS BUTTON=Mostra Tasto Precedente'#13+
'SHOW NEXT BUTTON=Mostra Tasto Prossimo'#13+
'CANDLE WIDTH=Ampiezza Candele'#13+
'STICK=Bastoncino'#13+
'BAR=Barra'#13+
'OPEN CLOSE=Apertura Chiusura'#13+
'UP CLOSE=Chiusura Superiore'#13+
'DOWN CLOSE=Chiusura Inferiore'#13+
'SHOW OPEN=Mostra Apertura'#13+
'SHOW CLOSE=Mostra Chiusura'#13+
'DRAW 3D=Disegnare 3D'#13+
'DARK 3D=Scuro 3D'#13+
'EDITING=Editing'#13+
'CHART=Grafico'#13+
'SERIES=Serie'#13+
'DATA=Dati'#13+
'TOOLS=Stumenti'#13+
'EXPORT=Esporta'#13+
'PRINT=Stampa'#13+
'GENERAL=Generale'#13+
'TITLES=Titoli'#13+
'LEGEND=Leggenda'#13+
'PANEL=Pannello'#13+
'PAGING=Pagina'#13+
'WALLS=Pareti'#13+
'3D=3D'#13+
'ADD=Aggiungi'#13+
'DELETE=Cancella'#13+
'TITLE=Titolo'#13+
'CLONE=Duplicare'#13+
'CHANGE=Cambia'#13+
'HELP=Aiuto'#13+
'CLOSE=Chiudi'#13+
'TEECHART PRINT PREVIEW=Anteprima di Stampa di TeeChart'#13+
'PRINTER=Stampante'#13+
'SETUP=Impostazioni'#13+
'ORIENTATION=Orientamento'#13+
'PORTRAIT=Ritratto'#13+
'LANDSCAPE=Panorama'#13+
'MARGINS (%)=Margini (%)'#13+
'DETAIL=Dettaglio'#13+
'MORE=Alto'#13+
'NORMAL=Normale'#13+
'RESET MARGINS=Ripristino Margini'#13+
'VIEW MARGINS=Vedi Margini'#13+
'PROPORTIONAL=Proporzionale'#13+
'CIRCLE=Cerchio'#13+
'VERTICAL LINE=Linea Verticale'#13+
'HORIZ. LINE=Linea Orizzontale'#13+
'TRIANGLE=Triangolo'#13+
'INVERT. TRIANGLE=Triangolo Rovesciato'#13+
'LINE=Linea'#13+
'DIAMOND=Diamante'#13+
'CUBE=Cubo'#13+
'STAR=Stella'#13+
'TRANSPARENT=Trasparente'#13+
'HORIZ. ALIGNMENT=Allineamento Orizzontale'#13+
'LEFT=Sinistro'#13+
'CENTER=Centro'#13+
'RIGHT=Destro'#13+
'ROUND RECTANGLE=Rettangolo Smussato'#13+
'ALIGNMENT=Allineamento'#13+
'BOTTOM=Basso'#13+
'UNITS=Unitá'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Origine degli Assi'#13+
'ROTATION=Rotazione'#13+
'CIRCLED=Arrotondato'#13+
'3 DIMENSIONS=A 3 Dimensioni'#13+
'RADIUS=Raggio'#13+
'ANGLE INCREMENT=Incremen. Angolare'#13+
'RADIUS INCREMENT=Incremento Radiale'#13+
'CLOSE CIRCLE=Cerchio Chiuso'#13+
'PEN=Penna'#13+
'LABELS=Etichette'#13+
'ROTATED=Ruotato'#13+
'CLOCKWISE=Senso Orario'#13+
'INSIDE=Interno'#13+
'ROMAN=Romano'#13+
'HOURS=Ore'#13+
'MINUTES=Minuti'#13+
'SECONDS=Secondi'#13+
'START VALUE=Valore Iniziale'#13+
'END VALUE=Valore Finale'#13+
'TRANSPARENCY=Trasparenza'#13+
'DRAW BEHIND=Disegna sfondo'#13+
'COLOR MODE=Modo Colore'#13+
'STEPS=Gradino'#13+
'RANGE=Intervallo'#13+
'PALETTE=Tavolozza'#13+
'PALE=Pallido'#13+
'STRONG=Forte'#13+
'GRID SIZE=Dimensione della Griglia'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Profond.'#13+
'IRREGULAR=Irregolare'#13+
'GRID=Griglia'#13+
'ALLOW DRAG=Permetti trascinamento'#13+
'VERTICAL POSITION=Posizione Verticale'#13+
'LEVELS POSITION=Posizione Livelli'#13+
'LEVELS=Livelli'#13+
'NUMBER=Numero'#13+
'LEVEL=Livello'#13+
'AUTOMATIC=Automatico'#13+
'SNAP=Aggiusta'#13+
'FOLLOW MOUSE=Segui il Mouse'#13+
'STACK=Pila'#13+
'HEIGHT 3D=Altezza 3D'#13+
'LINE MODE=Modo Linea'#13+
'OVERLAP=Sovrapponi'#13+
'STACK 100%=Pila 100%'#13+
'CLICKABLE=Cliccabile'#13+
'AVAILABLE=Disponibile'#13+
'SELECTED=Selezionato'#13+
'DATASOURCE=Fonte Dati'#13+
'GROUP BY=Raggruppa'#13+
'CALC=Calc'#13+
'OF=di'#13+
'SUM=Somma'#13+
'COUNT=Conto'#13+
'HIGH=Alto'#13+
'LOW=Basso'#13+
'AVG=Media'#13+
'HOUR=Ora'#13+
'DAY=Giorno'#13+
'WEEK=Settimana'#13+
'WEEKDAY=Giorno della settimana'#13+
'MONTH=Mese'#13+
'QUARTER=Quadrimestre'#13+
'YEAR=Anno'#13+
'HOLE %=Foro %'#13+
'RESET POSITIONS=Ripristina Posizioni'#13+
'MOUSE BUTTON=Tasto Mouse'#13+
'ENABLE DRAWING=Abilita Disegno'#13+
'ENABLE SELECT=Abilita Selezione'#13+
'ENHANCED=Migliorato'#13+
'ERROR WIDTH=Ampiezza Errore'#13+
'WIDTH UNITS=Unità Amp.'#13+
'PERCENT=Percentuale'#13+
'LEFT AND RIGHT=Sinistro e Destro'#13+
'TOP AND BOTTOM=Alto e Basso'#13+
'BORDER EDITOR=Editor dei Tratti'#13+
'DASH=Linea'#13+
'DOT=Punto'#13+
'DASH DOT=Linea Punto'#13+
'DASH DOT DOT=Linea Punto Punto'#13+
'CALCULATE EVERY=Calcola Ciascuno'#13+
'ALL POINTS=Tutti i Punti'#13+
'NUMBER OF POINTS=Numero di Punti'#13+
'RANGE OF VALUES=Intervallo di Valori'#13+
'FIRST=Primo'#13+
'LAST=Ultimo'#13+
'TEEPREVIEW EDITOR=Editor TeeAnteprima'#13+
'ALLOW MOVE=Permetti Spostamen.'#13+
'ALLOW RESIZE=Permetti Ridimens.'#13+
'DRAG IMAGE=Trascina Immag.'#13+
'AS BITMAP=Come Bitmap'#13+
'SHOW IMAGE=Mostra Immagine'#13+
'MARGINS=Margini'#13+
'SIZE=Spess.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Elevazione'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Spostam. Orizz.'#13+
'VERT. OFFSET=Spostam.   Vert.'#13+
'PERSPECTIVE=Prospettiva'#13+
'ANGLE=Angolo'#13+
'ORTHOGONAL=Ortogonale'#13+
'ZOOM TEXT=Zoom del Testo'#13+
'SCALES=Scale'#13+
'TICKS=Tratto'#13+
'MINOR=Minori'#13+
'MAXIMUM=Massimo'#13+
'MINIMUM=Minimo'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Incremento'#13+
'(INCREMENT)=(incremento)'#13+
'LOG BASE=Base Log'#13+
'LOGARITHMIC=Logaritmico'#13+
'MIN. SEPARATION %=Separazione Min. %'#13+
'MULTI-LINE=Multi-linee'#13+
'LABEL ON AXIS=Etichette su Assi'#13+
'ROUND FIRST=Arrotonda Prima'#13+
'MARK=Contrassegno'#13+
'LABELS FORMAT=Formato Etichette'#13+
'EXPONENTIAL=Esponenziale'#13+
'DEFAULT ALIGNMENT=Allineamento di Default'#13+
'LEN=Lung.'#13+
'INNER=Interno'#13+
'AT LABELS ONLY=Solo su Etichette'#13+
'CENTERED=Centrato'#13+
'POSITION %=Posizione %'#13+
'START %=Inizio %'#13+
'END %=Fine %'#13+
'OTHER SIDE=Parte Opposta'#13+
'AXES=Assi'#13+
'BEHIND=Sfondo'#13+
'CLIP POINTS=Nascondi'#13+
'PRINT PREVIEW=Anteprima Stampa'#13+
'MINIMUM PIXELS=Minimo Pixel'#13+
'ALLOW=Permetti'#13+
'ANIMATED=Animato'#13+
'ALLOW SCROLL=Permetti Scorrimento'#13+
'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
'AMBIENT LIGHT=Luce Ambiente'#13+
'SHININESS=Brillantezza'#13+
'FONT 3D DEPTH=Profond.Caratt.3D'#13+
'ACTIVE=Attivo'#13+
'FONT OUTLINES=Contorno dei Caratteri'#13+
'SMOOTH SHADING=Ombreggiatura Leggera'#13+
'LIGHT=Luce'#13+
'Y=Y'#13+
'INTENSITY=Intensità'#13+
'BEVEL=Smusso'#13+
'FRAME=Cornice'#13+
'ROUND FRAME=Cornice Arrotondata'#13+
'LOWERED=Incavo'#13+
'RAISED=Rilievo'#13+
'SYMBOLS=Simbolo'#13+
'TEXT STYLE=Stile Testo'#13+
'LEGEND STYLE=Stile Legenda'#13+
'VERT. SPACING=Spaziatura Vert.'#13+
'SERIES NAMES=Nomi Serie'#13+
'SERIES VALUES=Valori Serie'#13+
'LAST VALUES=Ultimi Valori'#13+
'PLAIN=Testo'#13+
'LEFT VALUE=Valore Sinistro'#13+
'RIGHT VALUE=Valore Destro'#13+
'LEFT PERCENT=Percentuale Sinistra'#13+
'RIGHT PERCENT=Percentuale Destra'#13+
'X VALUE=Valore X'#13+
'X AND VALUE=X e Valore'#13+
'X AND PERCENT=X e Percentuale'#13+
'CHECK BOXES=Casella Controllo'#13+
'DIVIDING LINES=Linee di Divisione'#13+
'FONT SERIES COLOR=Colore Caratteri delle Serie'#13+
'POSITION OFFSET %=Spostamento %'#13+
'MARGIN=Margine'#13+
'RESIZE CHART=Ridimensiona Grafico'#13+
'CONTINUOUS=Continuo'#13+
'POINTS PER PAGE=Punti per Pagina'#13+
'SCALE LAST PAGE=Scalare Ultima Pagina'#13+
'CURRENT PAGE LEGEND=Legenda Pagina Corrente'#13+
'PANEL EDITOR=Editor di Pannello'#13+
'BACKGROUND=Sottofondo'#13+
'BORDERS=Bordi'#13+
'BACK IMAGE=Immagine sfondo'#13+
'STRETCH=Estendi'#13+
'TILE=Affianca'#13+
'BEVEL INNER=Smusso Interno'#13+
'BEVEL OUTER=Smusso esterno'#13+
'MARKS=Contrassegni'#13+
'DATA SOURCE=Fonte Dati'#13+
'SORT=Ordina'#13+
'CURSOR=Cursore'#13+
'SHOW IN LEGEND=Mostra nella Legenda'#13+
'FORMATS=Formati'#13+
'VALUES=Valori'#13+
'PERCENTS=Percentuali'#13+
'HORIZONTAL AXIS=Asse Orizzontale'#13+
'DATETIME=Data/Ora'#13+
'VERTICAL AXIS=Asse Verticale'#13+
'ASCENDING=Ascendente'#13+
'DESCENDING=Discendente'#13+
'DRAW EVERY=Disegna Tutti'#13+
'CLIPPED=Nascosto'#13+
'ARROWS=Frecce'#13+
'MULTI LINE=Multi-linea'#13+
'ALL SERIES VISIBLE=Tutte le Serie Visibili'#13+
'LABEL=Etichetta'#13+
'LABEL AND PERCENT=Etichetta e percentuale'#13+
'LABEL AND VALUE=Etichetta e Valore'#13+
'PERCENT TOTAL=Percentuale Totale'#13+
'LABEL AND PERCENT TOTAL=Etichetta e Percentuale Totale'#13+
'X AND Y VALUES=Valori X e Y'#13+
'MANUAL=Manuale'#13+
'RANDOM=Casuale'#13+
'FUNCTION=Funzione'#13+
'NEW=Nuovo'#13+
'EDIT=Edit'#13+
'PERSISTENT=Persistente'#13+
'ADJUST FRAME=Aggiusta Cornice'#13+
'SUBTITLE=Sottotitolo'#13+
'SUBFOOT=Sub piè pag.'#13+
'FOOT=Pié Pagina'#13+
'VISIBLE WALLS=Pareti Visibili'#13+
'BACK=Dietro'#13+
'DIF. LIMIT=Limite Dif.'#13+
'ABOVE=Sopra'#13+
'WITHIN=Dentro'#13+
'BELOW=Sotto'#13+
'CONNECTING LINES=Linee di Connessione'#13+
'BROWSE=Scegli'#13+
'TILED=Affiancati'#13+
'INFLATE MARGINS=Ampliare i Margini'#13+
'ROUND=Arrotond.'#13+
'SQUARE=Quadrato'#13+
'FLAT=Piano'+#13+
'DOWN TRIANGLE=Triangolo in giù'#13+
'SMALL DOT=Piccoli Punto'#13+
'GLOBAL=Globale'#13+
'SHAPES=Forme'#13+
'BRUSH=Pennello'#13+
'DELAY=Ritardo'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Azione del Mouse'#13+
'MOVE=Sposta'#13+
'CLICK=Clic'#13+
'DRAW LINE=Disegna Linea'#13+
'EXPLODE BIGGEST=Separare le Parti'#13+
'TOTAL ANGLE=Angolo Totale'#13+
'GROUP SLICES=Raggruppare le parti'#13+
'BELOW %=Inferiore a %'#13+
'BELOW VALUE=Inferiore al Valore'#13+
'OTHER=Altri'#13+
'PATTERNS=Motivi'#13+
'SIZE %=Dimen. %'#13+
'SERIES DATASOURCE TEXT EDITOR=Editor Fonte Dati di Testo delle Serie'#13+
'FIELDS=Campi'#13+
'NUMBER OF HEADER LINES=Numero Linee Intestazione'#13+
'SEPARATOR=Separatore'#13+
'COMMA=Virgola'#13+
'SPACE=Spazio'#13+
'TAB=Tabulatore'#13+
'FILE=File'#13+
'WEB URL=URL Web'#13+
'LOAD=Carica'#13+
'C LABELS=Etichette C'#13+
'R LABELS=Etichette R'#13+
'C PEN=Penna C'#13+
'R PEN=Penna R'#13+
'STACK GROUP=Gruppo Pila'#13+
'MULTIPLE BAR=Barre Multiple'#13+
'SIDE=Lato'#13+
'SIDE ALL=Tutto al Lato'#13+
'DRAWING MODE=Modo di Disegnare'#13+
'WIREFRAME=Cornice a filo'#13+
'DOTFRAME=Cornice a Punti'#13+
'SMOOTH PALETTE=Tavolozza Mitigata'#13+
'SIDE BRUSH=Modello Laterale'#13+
'ABOUT TEECHART PRO V7.0=Info TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Tutti i Diritti Riservati'#13+
'VISIT OUR WEB SITE !=Visita il nostro sito Web!'#13+
'TEECHART WIZARD=Autocomposizione di TeeChart'#13+
'SELECT A CHART STYLE=Scegli uno Stile di Grafico'#13+
'DATABASE CHART=Grafico con Base di Dati'#13+
'NON DATABASE CHART=Grafico senza Base di Dati'#13+
'SELECT A DATABASE TABLE=Seleziona una Tavola di Base di Dati'#13+
'ALIAS=Alias'#13+
'TABLE=Tavola'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleziona i campi desiderati per il Grafico'#13+
'SELECT A TEXT LABELS FIELD=Seleziona un Campo testo-etichette'#13+
'CHOOSE THE DESIRED CHART TYPE=Scegli il tipo di grafico desiderato'#13+
'2D=2D'#13+
'CHART PREVIEW=Anteprima Grafico'#13+
'SHOW LEGEND=Visualizza Legenda'#13+
'SHOW MARKS=Visu. Contrassegni'#13+
'< BACK=< Indietro'#13+
'EXPORT CHART=Esporta Grafico'#13+
'PICTURE=Imagine'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Mantieni le Proporzioni'#13+
'INCLUDE SERIES DATA=Includi i dati delle Serie'#13+
'FILE SIZE=Dimensione del File'#13+
'DELIMITER=Delimitatore'#13+
'XML=XML'#13+
'HTML TABLE=Tabella HTML'#13+
'EXCEL=Excel'#13+
'COLON=Due punti'#13+
'INCLUDE=Includi'#13+
'POINT LABELS=Etichette dei Punti'#13+
'POINT INDEX=Indice dei Punti'#13+
'HEADER=Intestazione'#13+
'COPY=Copia'#13+
'SAVE=Salva'#13+
'SEND=Invia'#13+
'FUNCTIONS=Funzioni'#13+
'ADX=ADX'#13+
'AVERAGE=Media'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Dividi'#13+
'EXP. AVERAGE=Media Exp.'#13+
'EXP.MOV.AVRG.=Media Mobile Exp.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momento'#13+
'MOMENTUM DIV=Momento Div'#13+
'MOVING AVRG.=Media Mobile'#13+
'MULTIPLY=Moltiplica'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Radice Media Quadratica'#13+
'STD.DEVIATION=Deviazione Std.'#13+
'STOCHASTIC=Stocastico'#13+
'SUBTRACT=Sottrai'#13+
'SOURCE SERIES=Serie Fonte'#13+
'TEECHART GALLERY=Galleria TeeChart'#13+
'DITHER=Dither'#13+
'REDUCTION=Riduzione'#13+
'COMPRESSION=Compressione'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Piú vicino'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'GRAY SCALE=Scala di Grigi'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Qualitá'#13+
'PERFORMANCE=Prestazioni'#13+
'QUALITY=Qualità'#13+
'SPEED=Velocità'#13+
'COMPRESSION LEVEL=Liv.Compressione'#13+
'CHART TOOLS GALLERY=Galleria di Strumenti Grafici'#13+
'ANNOTATION=Annotazione'#13+
'AXIS ARROWS=Frecce Assi'#13+
'COLOR BAND=Bande di Colore'#13+
'COLOR LINE=Linea di Colore'#13+
'DRAG MARKS=Trascina Contrassegni'#13+
'MARK TIPS=Suggerimenti'#13+
'NEAREST POINT=Punto più vicino'#13+
'ROTATE=Ruota'#13+
'YES=Si'#13+
'SHOW PAGE NUMBER=Mostrare il numero di pagina'#13+
'PAGE NUMBER=Numero di pagina'#13+
'PAGE %D OF %D=Pag. %d di %d'#13+
'TEECHART LANGUAGES=Lingue di TeeChart'#13+
'CHOOSE A LANGUAGE=Scelglire una lingua'+#13+
'SELECT ALL=Selezionare Tutte'#13+
'DRAW ALL=Disegnare tutto'#13+
'TEXT FILE=Archivio di Testo'#13+
'IMAG. SYMBOL=Símbolo Imag.'#13+
'DRAG REPAINT=Ridipingi il trascinato'#13+
'NO LIMIT DRAG=Trascinam. senza limiti'#13+

'BEVEL SIZE=Misura smusso'#13+
'DELETE ROW=Cancella riga'#13+
'VOLUME SERIES=Volume serie'#13+
'SINGLE=Singolo'#13+
'REMOVE CUSTOM COLORS=Togli colori a scelta'#13+
'USE PALETTE MINIMUM=Usare minimo tavolozza'#13+
'AXIS MAXIMUM=Massimo dell''asse'#13+
'AXIS CENTER=Centro dell''asse'#13+
'AXIS MINIMUM=Minimo dell''asse'#13+
'DAILY (NONE)=giornaliero (nessuno)'#13+
'WEEKLY=settimanale'#13+
'MONTHLY=mensile'#13+
'BI-MONTHLY=bimestrale'#13+
'QUARTERLY=quadrimestrale'#13+
'YEARLY=annuale'#13+
'DATETIME PERIOD=Periodo data/ora'#13+
'CASE SENSITIVE=Case sensitive'#13+
'DRAG STYLE=Stile trascinamento'#13+
'SQUARED=squadrato'#13+
'GRID 3D SERIES=Serie a griglia 3D'#13+
'DARK BORDER=Bordo scuro'#13+
'PIE SERIES=serie a torta'#13+
'FOCUS=Fuoco'#13+
'EXPLODE=Explodi'#13+
'FACTOR=Fattore'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafico da modello (*.tee file)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Aprire file modello TeeChart da'#13+
'BINARY=Binario'#13+
'VOLUME OSCILLATOR=Volume Oscillatore'#13+
'PIE SLICES=Fette torta'#13+
'ARROW WIDTH=Larghezza freccia'#13+
'ARROW HEIGHT=Altezza freccia'#13+
'DEFAULT COLOR=Colore di default'

;
  end;
end;

Procedure TeeSetItalian;
begin
  TeeCreateItalian;
  TeeLanguage:=TeeItalianLanguage;
  TeeItalianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeItalianLanguage);
end.
