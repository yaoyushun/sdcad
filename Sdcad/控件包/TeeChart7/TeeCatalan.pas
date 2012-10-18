unit TeeCatalan;
{$I TeeDefs.inc}

interface

Uses Classes, TeeTranslate;

Var TeeCatalanLanguage:TLanguageStrings=nil;

Procedure TeeSetCatalan;
Procedure TeeCreateCatalan;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5}, TeCanvas{$ENDIF};

Procedure TeeCatalanConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 per David Berneda'; { 5.01 }
  TeeMsg_LegendFirstValue   :='El valor de la primera llegenda ha de ser > 0';
  TeeMsg_LegendColorWidth   :='L''ample del color de la llegenda ha de ser > 0%';
  TeeMsg_SeriesSetDataSource:='No hi ha cap ParentChart per a validar la DataSource';
  TeeMsg_SeriesInvDataSource:='La DataSource no és vàlida: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues ha de ser > 0';
  TeeMsg_AxisLogDateTime    :='L''eix de data/hora no pot ser logarítmic';
  TeeMsg_AxisLogNotPositive :='Els valors min. i màx. de l''eix logarítmic han de ser >= 0';
  TeeMsg_AxisLabelSep       :='El % de separació de les etiquetes ha de ser > 0';
  TeeMsg_AxisIncrementNeg   :='L''increment de l''eix ha de ser >= 0';
  TeeMsg_AxisMinMax         :='El valor mínim d''eix ha de ser <= Mínim';
  TeeMsg_AxisMaxMin         :='El valor màxim d''eix ha de ser >= Mínim';
  TeeMsg_AxisLogBase        :='La base de l''eix logarítmic ha de ser >= 2';
  TeeMsg_MaxPointsPerPage   :='El nombre de punts per pàgina ha de ser >= 0';
  TeeMsg_3dPercent          :='El % d''efecte 3D ha d''estar entre %d i %d';
  TeeMsg_CircularSeries     :='No es permeten referències circulars de sèries';
  TeeMsg_WarningHiColor     :='Per a una millor visualització es requereix una paleta de colors de 16k';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Títol eix';
  TeeMsg_AxisLabels         :='Etiquetes eix';
  TeeMsg_RefreshInterval    :='L''interval de refresc ha d''estar entre 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Sèries. ParentChart no sóc jo!';
  TeeMsg_GalleryLine        :='Línia';
  TeeMsg_GalleryPoint       :='Punt';
  TeeMsg_GalleryArea        :='Àrea';
  TeeMsg_GalleryBar         :='Barra';
  TeeMsg_GalleryHorizBar    :='Barra horit.';
  TeeMsg_Stack              :='Apilat';
  TeeMsg_GalleryPie         :='Pastís';
  TeeMsg_GalleryCircled     :='Circular';
  TeeMsg_GalleryFastLine    :='Línia ràpida';
  TeeMsg_GalleryHorizLine   :='Línia horit.';

  TeeMsg_PieSample1         :='Cotxes';
  TeeMsg_PieSample2         :='Telèfons';
  TeeMsg_PieSample3         :='Taules';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Llums';
  TeeMsg_PieSample6         :='Teclats';
  TeeMsg_PieSample7         :='Bicis';
  TeeMsg_PieSample8         :='Cadires';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editant %s';

  TeeMsg_GalleryStandard    :='Estàndard';
  TeeMsg_GalleryExtended    :='Ampliades';
  TeeMsg_GalleryFunctions   :='Funcions';

  TeeMsg_EditChart          :='E&dita el gràfic...';
  TeeMsg_PrintPreview       :='&Previsualiza...';
  TeeMsg_ExportChart        :='E&xporta el gràfic...';
  TeeMsg_CustomAxes         :='Eixos personalitzats...';

  TeeMsg_InvalidEditorClass :='%s: Classe Editor no és vàlida: %s';
  TeeMsg_MissingEditorClass :='%s: no té un quadre d''edició';

  TeeMsg_GalleryArrow       :='Fletxa';

  TeeMsg_ExpFinish          :='&Finalitza';
  TeeMsg_ExpNext            :='&Següent >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Diseny';
  TeeMsg_GanttSample2       :='Prototip';
  TeeMsg_GanttSample3       :='Desenvolup.';
  TeeMsg_GanttSample4       :='Vendes';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testejar';
  TeeMsg_GanttSample7       :='Manufact.';
  TeeMsg_GanttSample8       :='Comprovant';
  TeeMsg_GanttSample9       :='Nova versió';
  TeeMsg_GanttSample10      :='Finances';

  TeeMsg_ChangeSeriesTitle  :='Canvi del títol de les sèries';
  TeeMsg_NewSeriesTitle     :='Nou títol de sèrie:';
  TeeMsg_DateTime           :='Data/hora';
  TeeMsg_TopAxis            :='Eix superior';
  TeeMsg_BottomAxis         :='Eix inferior';
  TeeMsg_LeftAxis           :='Eix esquerre';
  TeeMsg_RightAxis          :='Eix dret';

  TeeMsg_SureToDelete       :='Voleu eliminar %s?';
  TeeMsg_DateTimeFormat     :='For&mat data/hora:';
  TeeMsg_Default            :='Defecte';
  TeeMsg_ValuesFormat       :='For&mat Valors:';
  TeeMsg_Maximum            :='Màxim';
  TeeMsg_Minimum            :='Mínim';
  TeeMsg_DesiredIncrement   :='Increment desitjat %s';

  TeeMsg_IncorrectMaxMinValue:='El valor és incorrecte. %s';
  TeeMsg_EnterDateTime      :='Introdueixi [nombre de dies] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Voleu aplicar els canvis?';
  TeeMsg_SelectedSeries     :='(Sèries Seleccionades)';
  TeeMsg_RefreshData        :='&Refrescar dades';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='420';
  TeeMsg_FunctionAdd        :='Suma';
  TeeMsg_FunctionSubtract   :='Resta';
  TeeMsg_FunctionMultiply   :='Multiplica';
  TeeMsg_FunctionDivide     :='Divideix';
  TeeMsg_FunctionHigh       :='Alt';
  TeeMsg_FunctionLow        :='Baix';
  TeeMsg_FunctionAverage    :='Mitjana';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Bombolles';
  TeeMsg_FunctionNone       :='Copiar';

  TeeMsg_None               :='(cap)';

  TeeMsg_PrivateDeclarations:='{ Declaracions privades }';
  TeeMsg_PublicDeclarations :='{ Declaracions públiques }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='La grandària del punter ha de ser major que zero';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_About              :='&Referència de TeeChart...';

  TeeMsg_DataSet            :='Taula/consulta';
  TeeMsg_AskDataSet         :='&Taula/consulta:';

  TeeMsg_SingleRecord       :='Registre únic';
  TeeMsg_AskDataSource      :='&Font de dades:';

  TeeMsg_Summary            :='Sumari';

  TeeMsg_FunctionPeriod     :='El període de la funció ha de ser >= 0';

  TeeMsg_TeeChartWizard     :='Assistent de TeeChart';

  TeeMsg_ClearImage         :='Nete&ja';
  TeeMsg_BrowseImage        :='&Obra...';

  TeeMsg_WizardSureToClose  :='Esteu segur de voler tancar l''Assistent de TeeChart?';
  TeeMsg_FieldNotFound      :='El camp %s no existeix';

  TeeMsg_DepthAxis          :='Prof. eix';
  TeeMsg_PieOther           :='Altre';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pastís';
  TeeMsg_ValuesBar          :='Barra';
  TeeMsg_ValuesAngle        :='Angle';
  TeeMsg_ValuesGanttStart   :='Inici';
  TeeMsg_ValuesGanttEnd     :='Fi';
  TeeMsg_ValuesGanttNextTask:='Prop.tasca';
  TeeMsg_ValuesBubbleRadius :='Radi';
  TeeMsg_ValuesArrowEndX    :='FiX';
  TeeMsg_ValuesArrowEndY    :='FiY';
  TeeMsg_Legend             :='Llegenda';
  TeeMsg_Title              :='Títol';
  TeeMsg_Foot               :='Peu';
  TeeMsg_Period		    :='Període';
  TeeMsg_PeriodRange        :='Marge període';
  TeeMsg_CalcPeriod         :='Calcular %s cada:';
  TeeMsg_SmallDotsPen       :='Puntejat';

  TeeMsg_InvalidTeeFile     :='L''arxiu *.'+TeeMsg_TeeExtension+' conté un gràfic no vàlid';
  TeeMsg_WrongTeeFileFormat :='El format de l''arxiu *.'+TeeMsg_TeeExtension+' és incorrecte';
  TeeMsg_EmptyTeeFile       :='L''arxiu *.'+TeeMsg_TeeExtension+' és buit';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Eixos del gràfic';
  TeeMsg_ChartAxesCategoryDesc   :='Propietats i esdeveniments dels eixos';
  TeeMsg_ChartWallsCategoryName  :='Parets del gràfic';
  TeeMsg_ChartWallsCategoryDesc  :='Propietats i esdeveniments de la paret del gràfic';
  TeeMsg_ChartTitlesCategoryName :='Títols del gràfic';
  TeeMsg_ChartTitlesCategoryDesc :='Esdeveniments i propietats del títol del gràfic';
  TeeMsg_Chart3DCategoryName     :='Gràfic 3D';
  TeeMsg_Chart3DCategoryDesc     :='Propietats i esdeveniments del gràfic 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalitzat ';
  TeeMsg_Series                 :='Sèries';
  TeeMsg_SeriesList             :='Sèries...';

  TeeMsg_PageOfPages            :='Pàgina %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primer';
  TeeMsg_Prior  :='Anterior';
  TeeMsg_Next   :='Següent';
  TeeMsg_Last   :='Últim';
  TeeMsg_Insert :='Insereix';
  TeeMsg_Delete :='Elimina';
  TeeMsg_Edit   :='Edita';
  TeeMsg_Post   :='Desa';
  TeeMsg_Cancel :='Cancel·la';

  TeeMsg_All    :='(totes)'; {les sèries}
  TeeMsg_Index  :='Índex';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='com &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='com &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='La propietat del plafó no està assignat en format d''exportació';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Sense vores';
  TeeMsg_Dotted    :='Punts';
  TeeMsg_Colors    :='Colors';
  TeeMsg_Filled    :='Ple';
  TeeMsg_Marks     :='Marques';
  TeeMsg_Stairs    :='Escales';
  TeeMsg_Points    :='Punts';
  TeeMsg_Height    :='Altura';
  TeeMsg_Hollow    :='Buit';
  TeeMsg_Point2D   :='Punt 2D';
  TeeMsg_Triangle  :='Triangle';
  TeeMsg_Star      :='Estrella';
  TeeMsg_Circle    :='Cercle';
  TeeMsg_DownTri   :='Triang. inv.';
  TeeMsg_Cross     :='Creu';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Sense línies';
  TeeMsg_Stack100  :='Apilat 100%';
  TeeMsg_Pyramid   :='Piràmide';
  TeeMsg_Ellipse   :='El·lipse';
  TeeMsg_InvPyramid:='Piràmide inv.';
  TeeMsg_Sides     :='Cares';
  TeeMsg_SideAll   :='Totes les cares';
  TeeMsg_Patterns  :='Patrons';
  TeeMsg_Exploded  :='Expandit';
  TeeMsg_Shadow    :='Ombra';
  TeeMsg_SemiPie   :='Semi-pastís';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Lín.Vert.';
  TeeMsg_HorizLine :='Lín.Horit.';
  TeeMsg_Line      :='Línia';
  TeeMsg_Cube      :='Cub';
  TeeMsg_DiagCross :='Aspa';

  TeeMsg_CanNotFindTempPath    :='No es pot localitzar la carpeta Temp';
  TeeMsg_CanNotCreateTempChart :='No es pot crear l''arxiu Temp';
  TeeMsg_CanNotEmailChart      :='No es pot enviar el gràfic per correu electrònic. S''ha produït un error Mapi: %d';

  TeeMsg_SeriesDelete :='Esborra les sèries: l''índex del valor està fora dels límits %d(0 a %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Llenguatge...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Espelma';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Superfície';
  TeeMsg_GalleryContour     :='Contorn';
  TeeMsg_GalleryBezier      :='Bézier';
  TeeMsg_GalleryPoint3D     :='Punts 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Barres 3D';
  TeeMsg_GalleryBigCandle   :='Espelma gran';
  TeeMsg_GalleryLinePoint   :='Punt Línia';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Caiguda d''Aigua';
  TeeMsg_GalleryWindRose    :='Rosa dels Vents';
  TeeMsg_GalleryClock       :='Rellotge';
  TeeMsg_GalleryColorGrid   :='Graella de Color';
  TeeMsg_GalleryBoxPlot     :='Esquema Vertical';
  TeeMsg_GalleryHorizBoxPlot:='Esquema Horitz.';
  TeeMsg_GalleryBarJoin     :='Unió de Barres';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piràmide';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange      :='El grau polinomial ha d''estar entre 1 i 20';
  TeeMsg_AnswerVectorIndex    :='L''índex de vector de resposta ha d''estar entre 1 i %d';
  TeeMsg_FittingError         :='No es pot calcular l''ajust.';
  TeeMsg_PeriodRange          :='El període ha de ser >= 0';
  TeeMsg_ExpAverageWeight     :='El pes de mitja exp. ha d''estar entre 0 i 1';
  TeeMsg_GalleryErrorBar      :='Barres d''Error';
  TeeMsg_GalleryError         :='Error';
  TeeMsg_GalleryHighLow       :='Alt-baix';
  TeeMsg_FunctionMomentum     :='Moment';
  TeeMsg_FunctionMomentumDiv  :='Mom. Divisió';
  TeeMsg_FunctionExpAverage   :='Mitja Exp.';
  TeeMsg_FunctionMovingAverage:='Mitja Mòbil';
  TeeMsg_FunctionExpMovAve    :='Mitja Mòbil Exp.';
  TeeMsg_FunctionRSI          :='R.S.I.';
  TeeMsg_FunctionCurveFitting :='Ajustament a Corba';
  TeeMsg_FunctionTrend        :='Tendència';
  TeeMsg_FunctionExpTrend     :='Tendència Exp.';
  TeeMsg_FunctionLogTrend     :='Tendència Logarítm.';
  TeeMsg_FunctionCumulative   :='Cumulatiu';
  TeeMsg_FunctionStdDeviation :='Desviació Estànd.';
  TeeMsg_FunctionBollinger    :='Bollinger';
  TeeMsg_FunctionRMS          :='Arrel Mitja Quad.';
  TeeMsg_FunctionMACD         :='MACD';
  TeeMsg_FunctionStochastic   :='Estocàstic';
  TeeMsg_FunctionADX          :='ADX';

  TeeMsg_FunctionCount       :='Compte';
  TeeMsg_LoadChart           :='Obra TeeChart...';
  TeeMsg_SaveChart           :='Desa TeeChart...';
  TeeMsg_TeeFiles            :='Arxius TeeChart Pro';

  TeeMsg_GallerySamples      :='Altres';
  TeeMsg_GalleryStats        :='Estadístiques';

  TeeMsg_CannotFindEditor    :='No es pot localitzar la fitxa d''edició de %s';

  TeeMsg_CannotLoadChartFromURL      :='S''ha produït un error de còdig: %d descarregant el gràfic d''URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL :='S''ha produït un error de còdig: %d descarregant dades de les sèries d''URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Obertura';
  TeeMsg_ValuesHigh          :='Alt';
  TeeMsg_ValuesLow           :='Baix';
  TeeMsg_ValuesClose         :='Tancament';
  TeeMsg_ValuesOffset        :='Desplaçament';
  TeeMsg_ValuesStdError      :='Error est.';

  TeeMsg_Grid3D              :='Graella 3D';

  TeeMsg_LowBezierPoints     :='El nombre de punts Bézier ha de ser > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edita';
  TeeCommanMsg_Print    :='Imprimeix';
  TeeCommanMsg_Copy     :='Copia';
  TeeCommanMsg_Save     :='Desa';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotació: %d° Elevació: %d°';
  TeeCommanMsg_Rotate   :='Rota';

  TeeCommanMsg_Moving   :='Desp.horitz.: %d Desp.vert.: %d';
  TeeCommanMsg_Move     :='Mou';

  TeeCommanMsg_Zooming  :='Ampliació: %d %%';
  TeeCommanMsg_Zoom     :='Amplia';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Profunditat'; { 5.01 }

  TeeCommanMsg_Chart    :='Gràfic';
  TeeCommanMsg_Panel    :='Plafó';

  TeeCommanMsg_RotateLabel:='Arrossegueu %s per a rotar'; { 5.01 }
  TeeCommanMsg_MoveLabel  :='Arrossegueu %s per a moure'; { 5.01 }
  TeeCommanMsg_ZoomLabel  :='Arrossegueu %s per a ampliar'; { 5.01 }
  TeeCommanMsg_DepthLabel :='Arrossegueu %s per a profunditat 3D'; { 5.01 }

  TeeCommanMsg_NormalLabel    :='Arrossegueu botó esq. per a ampliar, dt. per a desplaçar';
  TeeCommanMsg_NormalPieLabel :='Arrossegueu un troç de pastís pastis per separar-lo';

  TeeCommanMsg_PieExploding :='Troç: %d Separat: %d %%';

  TeeMsg_TriSurfaceLess        :='El nombre de punts ha de ser >= 4';
  TeeMsg_TriSurfaceAllColinear :='Tots els punts estan alineats';
  TeeMsg_TriSurfaceSimilar     :='Els puntos són semblants - no es pot executar';
  TeeMsg_GalleryTriSurface     :='Sup. Triangles';

  TeeMsg_AllSeries :='Totes les Sèries';
  TeeMsg_Edit      :='Edita';

  TeeMsg_GalleryFinancial    :='Financeres';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Arrossega Marques'; { 5.01 }
  TeeMsg_AxisArrowTool :='Fletxes en Eixos';
  TeeMsg_DrawLineTool  :='Dibuixa Línia';
  TeeMsg_NearestTool   :='Punt més Pròxim';
  TeeMsg_ColorBandTool :='Bandes de Color';
  TeeMsg_ColorLineTool :='Línies de Color';
  TeeMsg_RotateTool    :='Gira';
  TeeMsg_ImageTool     :='Imatge';
  TeeMsg_MarksTipTool  :='Marques';
  TeeMsg_AnnotationTool:='Anotació';

  TeeMsg_CantDeleteAncestor  :='No es pot eliminar el predecessor';

  TeeMsg_Load	          :='Carrega...';
  TeeMsg_NoSeriesSelected :='No hi ha Sèries seleccionades';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Sèries';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Intercanvia 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Actiu';
  TeeMsg_ActionSeriesActiveHint :='Mostra / amaga Sèries';
  TeeMsg_ActionEditHint         :='Edita gràfic';
  TeeMsg_ActionEdit             :='&Edita...';
  TeeMsg_ActionCopyHint         :='Copia al Portapapers';
  TeeMsg_ActionCopy             :='&Copia';
  TeeMsg_ActionPrintHint        :='Previsualizació del gràfic';
  TeeMsg_ActionPrint            :='&Imprimeix...';
  TeeMsg_ActionAxesHint         :='Mostra / amaga eixos';
  TeeMsg_ActionAxes             :='&Eixos';
  TeeMsg_ActionGridsHint        :='Mostra / amaga graelles';
  TeeMsg_ActionGrids            :='&Graelles';
  TeeMsg_ActionLegendHint       :='Mostra / amaga llegenda';
  TeeMsg_ActionLegend           :='&Llegenda';
  TeeMsg_ActionSeriesEditHint   :='Edita sèries';
  TeeMsg_ActionSeriesMarksHint  :='Mostra / amaga marques de sèries';
  TeeMsg_ActionSeriesMarks      :='&Marques';
  TeeMsg_ActionSaveHint         :='Desa gràfic';
  TeeMsg_ActionSave             :='&Desa...';

  TeeMsg_CandleBar              :='Barra';
  TeeMsg_CandleNoOpen           :='Sense obertura';
  TeeMsg_CandleNoClose          :='Sense tancament';
  TeeMsg_NoLines                :='Sense línies';
  TeeMsg_NoHigh                 :='Sense valor alt';
  TeeMsg_NoLow                  :='Sense valor baix';
  TeeMsg_ColorRange             :='Marge de color';
  TeeMsg_WireFrame              :='Contorn cable';
  TeeMsg_DotFrame               :='Contorn punt';
  TeeMsg_Positions              :='Posicions';
  TeeMsg_NoGrid                 :='Sense reixeta';
  TeeMsg_NoPoint                :='Sense punt';
  TeeMsg_NoLine                 :='Sense línia';
  TeeMsg_Labels                 :='Etiquetes';
  TeeMsg_NoCircle               :='Sense cercle';
  TeeMsg_Lines                  :='Línies';
  TeeMsg_Border                 :='Vora';

  TeeMsg_SmithResistance      :='Resistència';
  TeeMsg_SmithReactance       :='Reactància';

  TeeMsg_Column  :='Columna';

  { 5.01 }
  TeeMsg_Separator            :='Separador';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Embut';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Sobrepassa quota';
  TeeMsg_FunnelWithin         :=' entre quota';
  TeeMsg_FunnelBelow          :=' o per sota de la quota';
  TeeMsg_CalendarSeries       :='Calendari';
  TeeMsg_DeltaPointSeries     :='Tendències';
  TeeMsg_ImagePointSeries     :='Imatge en Punt';
  TeeMsg_ImageBarSeries       :='Imatge en Barra';

  TeeMsg_SeriesTextFieldZero  :='SeriesText: ha de ser mes gran que zero.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='com &JPEG';
  TeeMsg_JPEGFilter    :='Arxius JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='com &GIF';
  TeeMsg_GIFFilter     :='Arxius GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='com &PNG';
  TeeMsg_PNGFilter     :='Arxius PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='com PC&X';
  TeeMsg_PCXFilter     :='Arxius PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='com &VML (HTM)';
  TeeMsg_VMLFilter     :='Arxius VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := 'Origen';
  TeeMsg_Transparency         := 'Transparéncia';
  TeeMsg_Box		      := 'Caixa';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Núm Pàgina';
  TeeMsg_TextFile             := 'Arxius Texte';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='¿Desitja guardar %s?';
  TeeMsg_DragPoint            :='Arrosegar Punts';

  TeeMsg_Property            :='Propietat';
  TeeMsg_Value               :='Valor';
  TeeMsg_Yes                 :='Sí';
  TeeMsg_No                  :='No';
  TeeMsg_Image              :='(imatge)';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'Versió ActiveX ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'No es pot importar TeeChart de %s';
  TeeMsg_ActiveXVerbPrint    := '&Vista prèvia...';
  TeeMsg_ActiveXVerbExport   := 'E&xportar...';
  TeeMsg_ActiveXVerbImport   := '&Importar...';
  TeeMsg_ActiveXVerbHelp     := '&Ajuda...';
  TeeMsg_ActiveXVerbAbout    := '&Sobre TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Codi error: %d baixant: %s';
  TeeMsg_DatasourceError     := 'DataSource TeeChart no és una Sèrie o RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Tipus de Sèrie no valida';
  TeeMsg_AxisTextSrcError    := 'Tipus de Eix no valida';
  TeeMsg_DelSeriesDatasource := 'Segur que vols esborrar %s ?';
  TeeMsg_OCXNoPrinter        := 'No hi ha cap impressora instalada per omissió';
  TeeMsg_ActiveXPictureNotValid:='Imatge no vàlida';

  // 6.0
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='com &PDF';
  TeeMsg_PDFFilter        :='Arxius PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='com PostScript';
  TeeMsg_PSFilter         :='Arxius PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Area'#13'Horizontal';
  TeeMsg_SelfStack        :='Apilat auto';
  TeeMsg_DarkPen          :='Borde fosc';
  TeeMsg_SelectFolder     :='Seleccioni carpeta amb base de dades';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Conexió:';

  TeeMsg_FunctionSmooth       :='Suavitzat';
  TeeMsg_FunctionCross        :='Punts Tall';
  TeeMsg_GridTranspose        :='Rotació matriu 3D';
  TeeMsg_FunctionCompress     :='Compressió';
  TeeMsg_ExtraLegendTool      :='Llegenda Extra';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Oscil.lador'#13'Volum';
  TeeMsg_SeriesAnimTool       :='Animació Series';
  TeeMsg_GalleryPointFigure   :='Punt & Figura';
  TeeMsg_Up                   :='Dalt';
  TeeMsg_Down                 :='Abaix';
  TeeMsg_GanttTool            :='Arrastrar Gantt';
  TeeMsg_XMLFile              :='Arxiu XML';
  TeeMsg_GridBandTool         :='Bandes de color';
  TeeMsg_FunctionPerf         :='Rendiment';
  TeeMsg_GalleryGauge         :='Indicador';
  TeeMsg_GalleryGauges        :='Indicadors';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vector 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torres';
  TeeMsg_SingleColor          :='Un Color';
  TeeMsg_Cover                :='Coberta';
  TeeMsg_Cone                 :='Con';
  TeeMsg_PieTool              :='Porcions Pastís';

  // 6.02
  TeeMsg_Options              :='&Opcions...';
end;

Procedure TeeCreateCatalan;
begin
  if not Assigned(TeeCatalanLanguage) then
  begin
    TeeCatalanLanguage:=TLanguageStrings.Create;
    TeeCatalanLanguage.Text:=

'LABELS=Textes'+#13+
'DATASET=Taula'+#13+
'ALL RIGHTS RESERVED.=Tots els Drets Reservats.'+#13+
'APPLY=Aplicar'+#13+
'CLOSE=Tancar'+#13+
'OK=Aceptar'+#13+
'ABOUT TEECHART PRO V7.0=Referència de TeeChart Pro v7.0'+#13+
'OPTIONS=Opcions'+#13+
'FORMAT=Format'+#13+
'TEXT=Texte'+#13+
'GRADIENT=Gradient'+#13+
'SHADOW=Sombra'+#13+
'POSITION=Posició'+#13+
'LEFT=Esquerra'+#13+
'TOP=A dalt'+#13+
'CUSTOM=Person.'+#13+
'PEN=Llàpis'+#13+
'PATTERN=Trama'+#13+
'SIZE=Tamany'+#13+
'BEVEL=Marc'+#13+
'INVERTED=Invertit'+#13+
'INVERTED SCROLL=Desplaç. Invertit'#13+
'BORDER=Borde'+#13+
'ORIGIN=Origen'+#13+
'USE ORIGIN=Usar Origen'+#13+
'AREA LINES=Líneas Area'+#13+
'AREA=Area'+#13+
'COLOR=Color'+#13+
'SERIES=Series'+#13+
'SUM=Suma'+#13+
'DAY=Dia'+#13+
'QUARTER=Trimestre'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Visible'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Línea Horiz.'+#13+
'LABEL AND PERCENT=Texte i Percent.'+#13+
'LABEL AND VALUE=Texte i Valor'+#13+
'LABEL AND PERCENT TOTAL=Texte i Percent. Total'+#13+
'PERCENT TOTAL=Total Percentatge'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Restar'+#13+
'MULTIPLY=Multiplicar'+#13+
'DIVIDE=Dividir'+#13+
'STAIRS=Escales'+#13+
'MOMENTUM=Moment'+#13+
'AVERAGE=Mitja'+#13+
'XML=XML'+#13+
'HTML TABLE=Taula HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Cap'+#13+
'WIDTH=Ample'+#13+
'HEIGHT=Alt'+#13+
'COLOR EACH=Colorejar'+#13+
'STACK=Apilar'+#13+
'STACKED=Apilat'+#13+
'STACKED 100%=Apilat 100%'+#13+
'AXIS=Eix'+#13+
'LENGTH=Llongitud'+#13+
'CANCEL=Cancelar'+#13+
'SCROLL=Desplaçament'+#13+
'INCREMENT=Increment'+#13+
'VALUE=Valor'+#13+
'STYLE=Estil'+#13+
'JOIN=Unió'+#13+
'AXIS INCREMENT=Increment d''Eix'+#13+
'AXIS MAXIMUM AND MINIMUM=Máxim i Mínim d''Eix'+#13+
'% BAR WIDTH=Ample Barra %'+#13+
'% BAR OFFSET=Desplaç. Barra %'+#13+
'BAR SIDE MARGINS=Márgens Laterals'+#13+
'AUTO MARK POSITION=Posició Marques Auto.'+#13+
'DARK BAR 3D SIDES=Costats Barra Foscos'+#13+
'MONOCHROME=Monocrom'+#13+
'COLORS=Colors'+#13+
'DEFAULT=Defecte'+#13+
'MEDIAN=Mediana'+#13+
'IMAGE=Imatge'+#13+
'DAYS=Dies'+#13+
'WEEKDAYS=Laborables'+#13+
'TODAY=Avui'+#13+
'SUNDAY=Diumenge'+#13+
'MONTHS=Mesos'+#13+
'LINES=Líneas'+#13+
'UPPERCASE=Majúscules'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=Ample Espelma'+#13+
'BAR=Barra'+#13+
'OPEN CLOSE=Aper. Tancam.'+#13+
'DRAW 3D=Dibuixar 3D'+#13+
'DARK 3D=Fosc 3D'+#13+
'SHOW OPEN=Veure Apertura'+#13+
'SHOW CLOSE=Veure Tancam.'+#13+
'UP CLOSE=Tancament Adalt'+#13+
'DOWN CLOSE=Tancament Abaix'+#13+
'CIRCLED=Circular'+#13+
'CIRCLE=Cercle'+#13+
'3 DIMENSIONS=3 Dimensions'+#13+
'ROTATION=Rotació'+#13+
'RADIUS=Radios'+#13+
'HOURS=Hores'+#13+
'HOUR=Hora'+#13+
'MINUTES=Minuts'+#13+
'SECONDS=Segons'+#13+
'FONT=Font'+#13+
'INSIDE=Interior'+#13+
'ROTATED=Rotar'+#13+
'ROMAN=Romans'+#13+
'TRANSPARENCY=Transparencia'+#13+
'DRAW BEHIND=Dibuixar Darrere'+#13+
'RANGE=Rang'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Pasos'+#13+
'GRID=Rejilla'+#13+
'GRID SIZE=Tamany Rejilla'+#13+
'ALLOW DRAG=Permetre arrastrar'+#13+
'AUTOMATIC=Automátic'+#13+
'LEVEL=Nivell'+#13+
'LEVELS POSITION=Posició Nivells'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=Seguir Ratolí'+#13+
'TRANSPARENT=Transparent'+#13+
'ROUND FRAME=Marc Rodó'+#13+
'FRAME=Marc'+#13+
'START=Inici'+#13+
'END=Final'+#13+
'MIDDLE=Mig'+#13+
'NO MIDDLE=Sense Mig'+#13+
'DIRECTION=Direcció'+#13+
'DATASOURCE=Origen de Dades'+#13+
'AVAILABLE=Disponibles'+#13+
'SELECTED=Seleccionats'+#13+
'CALC=Calcular'+#13+
'GROUP BY=Agrupar per'+#13+
'OF=de'+#13+
'HOLE %=Forat %'+#13+
'RESET POSITIONS=Posicions defecte'+#13+
'MOUSE BUTTON=Botó Ratolí'+#13+
'ENABLE DRAWING=Permetre Dibuixar'+#13+
'ENABLE SELECT=Permetre Seleccionar'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Angle'+#13+
'ZOOM TEXT=Ampliar Textes'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=Ampliar'+#13+
'ELEVATION=Elevació'+#13+
'BEHIND=Darrere'+#13+
'AXES=Eixos'+#13+
'SCALES=Escales'+#13+
'TITLE=Títol'+#13+
'TICKS=Marques'+#13+
'MINOR=Menors'+#13+
'CENTERED=Centrat'+#13+
'CENTER=Centre'+#13+
'PATTERN COLOR EDITOR=Editor de Trama'+#13+
'START VALUE=Valor Inicial'+#13+
'END VALUE=Valor Final'+#13+
'COLOR MODE=Modus de Color'+#13+
'LINE MODE=Modus de Línea'+#13+
'HEIGHT 3D=Alt 3D'+#13+
'OUTLINE=Borde'+#13+
'PRINT PREVIEW=Previsualiza'+#13+
'ANIMATED=Animat'+#13+
'ALLOW=Permetre'+#13+
'DASH=Líneas'+#13+
'DOT=Punts'+#13+
'DASH DOT DOT=Línea Punt Punt'+#13+
'PALE=Suau'+#13+
'STRONG=Fort'+#13+
'WIDTH UNITS=Unitats'+#13+
'FOOT=Peu'+#13+
'SUBFOOT=Sub Peu'+#13+
'SUBTITLE=Subtítol'+#13+
'LEGEND=Llegenda'+#13+
'COLON=Dos punts'+#13+
'AXIS ORIGIN=Origen Eix'+#13+
'UNITS=Unitats'+#13+
'PYRAMID=Pirámid'+#13+
'DIAMOND=Diamant'+#13+
'CUBE=Cub'+#13+
'TRIANGLE=Triángle'+#13+
'STAR=Estel'+#13+
'SQUARE=Cuadrat'+#13+
'DOWN TRIANGLE=Triángle Invert.'+#13+
'SMALL DOT=Puntet'+#13+
'LOAD=Carregar'+#13+
'FILE=Arxiu'+#13+
'RECTANGLE=Rectángle'+#13+
'HEADER=Capçalera'+#13+
'CLEAR=Borrar'+#13+
'ONE HOUR=Una Hora'+#13+
'ONE YEAR=Un Any'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=Con'+#13+
'ARROW=Fletxa'+#13+
'CYLINDER=Cilindre'+#13+
'TIME=Hora'+#13+
'BRUSH=Trama'+#13+
'LINE=Línea'+#13+
'VERTICAL LINE=Línea Vertical'+#13+
'AXIS ARROWS=Fletxes en Eixos'+#13+
'MARK TIPS=Sugerencies'+#13+
'DASH DOT=Línea Punt'+#13+
'COLOR BAND=Bandes de Color'+#13+
'COLOR LINE=Linea de Color'+#13+
'INVERT. TRIANGLE=Triángle Invert.'+#13+
'INVERT. PYRAMID=Pirámid Invert.'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor d''Origen de Dades de Texte'+#13+
'SOLID=Sólid'+#13+
'WIREFRAME=Filferros'+#13+
'DOTFRAME=Punts'+#13+
'SIDE BRUSH=Trama Lateral'+#13+
'SIDE=Al costat'+#13+
'SIDE ALL=Lateral'+#13+
'ANNOTATION=Anotació'+#13+
'ROTATE=Rotar'+#13+
'SMOOTH PALETTE=Paleta suavitzada'+#13+
'CHART TOOLS GALLERY=Galería d''Eines'+#13+
'ADD=Afegir'+#13+
'BORDER EDITOR=Editor de Borde'+#13+
'DRAWING MODE=Modus de Dibuix'+#13+
'CLOSE CIRCLE=Tancar Cercle'+#13+
'PICTURE=Imatge'+#13+
'NATIVE=Natiu'+#13+
'DATA=Dades'+#13+
'KEEP ASPECT RATIO=Mantenir proporció'+#13+
'COPY=Copiar'+#13+
'SAVE=Guardar'+#13+
'SEND=Enviar'+#13+
'INCLUDE SERIES DATA=Incluir Dades de Series'+#13+
'FILE SIZE=Tamany de l''Arxiu'+#13+
'INCLUDE=Incloure'+#13+
'POINT INDEX=Index de Punts'+#13+
'POINT LABELS=Etiquetes de Punts'+#13+
'DELIMITER=Delimitador'+#13+
'DEPTH=Profund.'+#13+
'COMPRESSION LEVEL=Nivell Compressió'+#13+
'COMPRESSION=Compressió'+#13+
'PATTERNS=Trames'+#13+
'LABEL=Etiqueta'+#13+
'GROUP SLICES=Agrupar porcions'+#13+
'EXPLODE BIGGEST=Separar Porció'+#13+
'TOTAL ANGLE=Angle Total'+#13+
'HORIZ. SIZE=Tamany Horiz.'+#13+
'VERT. SIZE=Tamany Vert.'+#13+
'SHAPES=Formes'+#13+
'INFLATE MARGINS=Ampliar Márgens'+#13+
'QUALITY=Cualitat'+#13+
'SPEED=Velocitat'+#13+
'% QUALITY=% Cualitat'+#13+
'GRAY SCALE=Escala de Grisos'+#13+
'PERFORMANCE=Millor'+#13+
'BROWSE=Seleccionar'+#13+
'TILED=Mosaic'+#13+
'HIGH=Alt'+#13+
'LOW=Baix'+#13+
'DATABASE CHART=Gráfic amb Base de Dades'+#13+
'NON DATABASE CHART=Gráfic sense Base de Dades'+#13+
'HELP=Ajuda'+#13+
'NEXT >=Seguent >'+#13+
'< BACK=< Anterior'+#13+
'TEECHART WIZARD=Assistent de TeeChart'+#13+
'PERCENT=Percentual'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=Ample Error'+#13+
'ENHANCED=Millorat'+#13+
'VISIBLE WALLS=Veure Parets'+#13+
'ACTIVE=Actiu'+#13+
'DELETE=Borrar'+#13+
'ALIGNMENT=Alineació'+#13+
'ADJUST FRAME=Ajustar Marc'+#13+
'HORIZONTAL=Horizontal'+#13+
'VERTICAL=Vertical'+#13+
'VERTICAL POSITION=Posició Vertical'+#13+
'NUMBER=Nombre'+#13+
'LEVELS=Nivells'+#13+
'OVERLAP=Sobreposar'+#13+
'STACK 100%=Apilar 100%'+#13+
'MOVE=Moure'+#13+
'CLICK=Clic'+#13+
'DELAY=Retràs'+#13+
'DRAW LINE=Dibuixar Línea'+#13+
'FUNCTIONS=Funcions'+#13+
'SOURCE SERIES=Series Origen'+#13+
'ABOVE=Adalt'+#13+
'BELOW=Abaix'+#13+
'Dif. Limit=Límit Dif.'+#13+
'WITHIN=Dins'+#13+
'EXTENDED=Exteses'+#13+
'STANDARD=Estandar'+#13+
'STATS=Estadística'+#13+
'FINANCIAL=Financieres'+#13+
'OTHER=Altres'+#13+
'TEECHART GALLERY=Galería de Gràfics TeeChart'+#13+
'CONNECTING LINES=Líneas de Conexió'+#13+
'REDUCTION=Reducció'+#13+
'LIGHT=Llum'+#13+
'INTENSITY=Intensitat'+#13+
'FONT OUTLINES=Borde Fonts'+#13+
'SMOOTH SHADING=Sombres suaus'+#13+
'AMBIENT LIGHT=Llum d''Ambient'+#13+
'MOUSE ACTION=Acció del Ratolí'+#13+
'CLOCKWISE=Segons horari'+#13+
'ANGLE INCREMENT=Angle d''Increment'+#13+
'RADIUS INCREMENT=Increment de Radi'+#13+
'PRINTER=Impresora'+#13+
'SETUP=Opcions'+#13+
'ORIENTATION=Orientació'+#13+
'PORTRAIT=Vertical'+#13+
'LANDSCAPE=Horizontal'+#13+
'MARGINS (%)=Marges (%)'+#13+
'MARGINS=Marges'+#13+
'DETAIL=Detall'+#13+
'MORE=Més'+#13+
'PROPORTIONAL=Proporcional'+#13+
'VIEW MARGINS=Veure Marges'+#13+
'RESET MARGINS=Marges Defecte'+#13+
'PRINT=Imprimir'+#13+
'TEEPREVIEW EDITOR=Editor Impressió Preliminar'+#13+
'ALLOW MOVE=Permetre Moure'+#13+
'ALLOW RESIZE=Permetre Redimens.'+#13+
'SHOW IMAGE=Veure Imatge'+#13+
'DRAG IMAGE=Arrastrar Imatge'+#13+
'AS BITMAP=Com mapa de bits'+#13+
'SIZE %=Tamany %'+#13+
'FIELDS=Camps'+#13+
'SOURCE=Origen'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=Líneas de capçalera'+#13+
'COMMA=Coma'+#13+
'EDITING=Editant'+#13+
'TAB=Tabulació'+#13+
'SPACE=Espai'+#13+
'ROUND RECTANGLE=Rectángle Arrodonit'+#13+
'BOTTOM=Abaix'+#13+
'RIGHT=Dreta'+#13+
'C PEN=Llápis C'+#13+
'R PEN=Llápis R'+#13+
'C LABELS=Textes C'+#13+
'R LABELS=Textes R'+#13+
'MULTIPLE BAR=Barres Múltiples'+#13+
'MULTIPLE AREAS=Areas Múltiples'+#13+
'STACK GROUP=Grup d''Apilat'+#13+
'BOTH=Tots'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Creu en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Creu'+#13+
'DIAGONAL CROSS=Creu en Diagonal'+#13+
'LEFT RIGHT=Esquerra Dreta'+#13+
'RIGHT LEFT=Dreta Esquerra'+#13+
'FROM CENTER=Desde el mig'+#13+
'FROM TOP LEFT=Desde Esq. Adalt'+#13+
'FROM BOTTOM LEFT=Desde Esq. Abaix'+#13+
'SHOW WEEKDAYS=Veure Laborables'+#13+
'SHOW MONTHS=Veure Mesos'+#13+
'SHOW PREVIOUS BUTTON=Veure Botó Anterior'#13+
'SHOW NEXT BUTTON=Veure Botó Seguent'#13+
'TRAILING DAYS=Veure altres Dies'+#13+
'SHOW TODAY=Veure Avui'+#13+
'TRAILING=Altres Dies'+#13+
'LOWERED=Enfonsat'+#13+
'RAISED=Elevat'+#13+
'HORIZ. OFFSET=Desplaç. Horiz.'+#13+
'VERT. OFFSET=Desplaç. Vert.'+#13+
'INNER=Dins'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=Només en etiquetes'+#13+
'MAXIMUM=Máxim'+#13+
'MINIMUM=Mínim'+#13+
'CHANGE=Canviar'+#13+
'LOGARITHMIC=Logarítmic'+#13+
'LOG BASE=Base Log.'+#13+
'DESIRED INCREMENT=Increment desitjat'+#13+
'(INCREMENT)=(Increment)'+#13+
'MULTI-LINE=Multi-Línea'+#13+
'MULTI LINE=Multilínea'+#13+
'RESIZE CHART=Redim. Gráfic'+#13+
'X AND PERCENT=X i Percentatge'+#13+
'X AND VALUE=X i Valor'+#13+
'RIGHT PERCENT=Percentatge dreta'+#13+
'LEFT PERCENT=Percentatge esquerra'+#13+
'LEFT VALUE=Valor esquerra'+#13+
'RIGHT VALUE=Valor dreta'+#13+
'PLAIN=Texte'+#13+
'LAST VALUES=Ultimo Valors'+#13+
'SERIES VALUES=Valors de Series'+#13+
'SERIES NAMES=Noms de Series'+#13+
'NEW=Nou'+#13+
'EDIT=Editar'+#13+
'PANEL COLOR=Color de fons'+#13+
'TOP BOTTOM=Adalt abaix'+#13+
'BOTTOM TOP=Abaix adalt'+#13+
'DEFAULT ALIGNMENT=Alineació defecte'+#13+
'EXPONENTIAL=Exponencial'+#13+
'LABELS FORMAT=Format Etiquetes'+#13+
'MIN. SEPARATION %=Min. Separació %'+#13+
'YEAR=Any'+#13+
'MONTH=Mes'+#13+
'WEEK=Setmana'+#13+
'WEEKDAY=Dia Laborable'+#13+
'MARK=Marques'+#13+
'ROUND FIRST=Arrodonir primera'+#13+
'LABEL ON AXIS=Etiqueta a l''eix'+#13+
'COUNT=Nombre'+#13+
'POSITION %=Posició %'+#13+
'START %=Comença %'+#13+
'END %=Acaba %'+#13+
'OTHER SIDE=Costat oposat'+#13+
'INTER-CHAR SPACING=Espai entre caracters'+#13+
'VERT. SPACING=Espaciat Vertical'+#13+
'POSITION OFFSET %=Desplaçament %'+#13+
'GENERAL=General'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistent'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Editor d''OpenGL'+#13+
'FONT 3D DEPTH=Profund. Font &3D'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Editor de Font'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Redueix'+#13+
'VERTICAL SMALL=Vertical Petit'+#13+
'HORIZ. SMALL=Horizontal Petit'+#13+
'DIAG. SMALL=Diagonal Petit'+#13+
'BACK DIAG. SMALL=Diagon. Invert. Pet.'+#13+
'DIAG. CROSS SMALL=Creu Diagonal Pet.'+#13+
'MINIMUM PIXELS=Mínims pixels'+#13+
'ALLOW SCROLL=Permetre Desplaç.'+#13+
'SWAP=Canviar'+#13+
'GRADIENT EDITOR=Editor de Gradient'+#13+
'TEXT STYLE=Estil de textes'+#13+
'DIVIDING LINES=Líneas de Divisió'+#13+
'SYMBOLS=Símbols'+#13+
'CHECK BOXES=Palometes'+#13+
'FONT SERIES COLOR=Color de Series'+#13+
'LEGEND STYLE=Estil de Llegenda'+#13+
'POINTS PER PAGE=Punts per pàgina'+#13+
'SCALE LAST PAGE=Escalar última pàgina'+#13+
'CURRENT PAGE LEGEND=Llegenda amb pàgina actual'+#13+
'BACKGROUND=Fons'+#13+
'BACK IMAGE=Imatge de fons'+#13+
'STRETCH=Ajustar'+#13+
'TILE=Mosaic'+#13+
'BORDERS=Bordes'+#13+
'CALCULATE EVERY=Calcular cada'+#13+
'NUMBER OF POINTS=Nombre de punts'+#13+
'RANGE OF VALUES=Rang de valors'+#13+
'FIRST=Primer'+#13+
'LAST=Ultim'+#13+
'ALL POINTS=Tots els punts'+#13+
'DATA SOURCE=Origen de Dades'+#13+
'WALLS=Paret'+#13+
'PAGING=Pàgina'+#13+
'CLONE=Duplicar'+#13+
'TITLES=Títol'+#13+
'TOOLS=Eines'+#13+
'EXPORT=Exportar'+#13+
'CHART=Gráfic'+#13+
'BACK=Fons'+#13+
'LEFT AND RIGHT=Esq. i Dreta'+#13+
'SELECT A CHART STYLE=Seleccioni el tipus de Gráfic'+#13+
'SELECT A DATABASE TABLE=Seleccioni una Taula'+#13+
'TABLE=Taula'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccioni els camps a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Seleccioni el camp d''etiquetes'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccioni el tipus desitjat'+#13+
'CHART PREVIEW=Visió Preliminar'+#13+
'SHOW LEGEND=Veure Llegenda'+#13+
'SHOW MARKS=Veure Marques'+#13+
'FINISH=Acabar'+#13+
'RANDOM=Aleatori'+#13+
'DRAW EVERY=Dibuixar cada'+#13+
'ARROWS=Fletxes'+#13+
'ASCENDING=Ascendent'+#13+
'DESCENDING=Descendent'+#13+
'VERTICAL AXIS=Eix Vertical'+#13+
'DATETIME=Data/Hora'+#13+
'TOP AND BOTTOM=Superior e Inferior'+#13+
'HORIZONTAL AXIS=Eix Horizontal'+#13+
'PERCENTS=Percentatges'+#13+
'VALUES=Valors'+#13+
'FORMATS=Formats'+#13+
'SHOW IN LEGEND=Veure en Llegenda'+#13+
'SORT=Ordre'+#13+
'MARKS=Marques'+#13+
'BEVEL INNER=Marc interior'+#13+
'BEVEL OUTER=Marc exterior'+#13+
'PANEL EDITOR=Editor de Panel'+#13+
'CONTINUOUS=Continuos'+#13+
'HORIZ. ALIGNMENT=Alineació Horiz.'+#13+
'EXPORT CHART=Exportar Gráfic'+#13+
'BELOW %=Inferior a %'+#13+
'BELOW VALUE=Inferior a Valor'+#13+
'NEAREST POINT=Punt proper'+#13+
'DRAG MARKS=Moure Marques'+#13+
'TEECHART PRINT PREVIEW=Impressió Preliminar'+#13+
'X VALUE=Valor X'+#13+
'X AND Y VALUES=Valors X Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Totes les Series Visible'+#13+
'MARGIN=Marge'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Esquerra Adalt'+#13+
'LEFT BOTTOM=Esquerra Abaix'+#13+
'RIGHT TOP=Dreta Adalt'+#13+
'RIGHT BOTTOM=Dreta Abaix'+#13+
'EXACT DATE TIME=Data/Hora Exacta'+#13+
'RECT. GRADIENT=Gradient'+#13+
'CROSS SMALL=Creu petita'+#13+
'AVG=Mitja'+#13+
'FUNCTION=Funció'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Un milisegon'+#13+
'ONE SECOND=Un segon'+#13+
'FIVE SECONDS=Cinc segons'+#13+
'TEN SECONDS=Deu segons'+#13+
'FIFTEEN SECONDS=Quinze segons'+#13+
'THIRTY SECONDS=Trenta segons'+#13+
'ONE MINUTE=Un minut'+#13+
'FIVE MINUTES=Cinc minuts'+#13+
'TEN MINUTES=Due minuts'+#13+
'FIFTEEN MINUTES=Quinze minuts'+#13+
'THIRTY MINUTES=Trenta minuts'+#13+
'TWO HOURS=Dos hores'+#13+
'THREE HOURS=Tres hores'+#13+
'SIX HOURS=Sis hores'+#13+
'TWELVE HOURS=Dotze hores'+#13+
'ONE DAY=Un dia'+#13+
'TWO DAYS=Dos dias'+#13+
'THREE DAYS=Tres dias'+#13+
'ONE WEEK=Una setmana'+#13+
'HALF MONTH=Mig mes'+#13+
'ONE MONTH=Un mes'+#13+
'TWO MONTHS=Dos mesos'+#13+
'THREE MONTHS=Tres mesos'+#13+
'FOUR MONTHS=Cuatre mesos'+#13+
'SIX MONTHS=Sis mesos'+#13+
'IRREGULAR=Irregular'+#13+
'CLICKABLE=Clicable'+#13+
'ROUND=Rodó'+#13+
'FLAT=Plà'+#13+
'PIE=Pastis'+#13+
'HORIZ. BAR=Barra Horiz.'+#13+
'BUBBLE=Bombolla'+#13+
'SHAPE=Forma'+#13+
'POINT=Punts'+#13+
'FAST LINE=Línea Ràpida'+#13+
'CANDLE=Espelma'+#13+
'VOLUME=Volum'+#13+
'HORIZ LINE=Línea Horiz.'+#13+
'SURFACE=Superfície'+#13+
'LEFT AXIS=Eix Esquerra'+#13+
'RIGHT AXIS=Eix Dret'+#13+
'TOP AXIS=Eix Superior'+#13+
'BOTTOM AXIS=Eix Inferior'+#13+
'CHANGE SERIES TITLE=Canviar Títol de Series'+#13+
'DELETE %S ?=Eliminar %s ?'+#13+
'DESIRED %S INCREMENT=Increment %s desitjat'+#13+
'INCORRECT VALUE. REASON: %S=Valor incorrecte. Raó: %s'+#13+
'FillSampleValues NumValues must be > 0=FillSampleValues. El nombre de valors té que ser > 0.'#13+
'VISIT OUR WEB SITE !=Visiti la nostre Web !'#13+
'SHOW PAGE NUMBER=Veure Nombre de Pàgina'#13+
'PAGE NUMBER=Nombre de Pàgina'#13+
'PAGE %D OF %D=Pàg. %d de %d'#13+
'TEECHART LANGUAGES=Llenguatges de TeeChart'#13+
'CHOOSE A LANGUAGE=Escolleixi un idioma'+#13+
'SELECT ALL=Seleccionar Totes'#13+
'MOVE UP=Moure adalt'#13+
'MOVE DOWN=Moure abaix'#13+
'DRAW ALL=Dibuixar tot'#13+
'TEXT FILE=Arxiu de Texte'#13+
'IMAG. SYMBOL=Símbol Imag.'#13+
'DRAG REPAINT=Repinta tot'#13+
'NO LIMIT DRAG=Sense límits'#13+
'AVAILABLE LANGUAGES=Llenguatges disponibles'#13+
'PERIOD=Periode'#13+

// 6.0

'UP=Dalt'#13+
'DOWN=Abaix'#13+
'SHADOW EDITOR=Editor Sombres'#13+
'TEXT ALIGNMENT=Alineació Texte'#13+
'DISTANCE=Distància'#13+
'ARROW HEAD=Cap fletxa'#13+
'CALCULATE USING=Calcular amb'#13+
'EVERY NUMBER OF POINTS=Cada nombre de punts'#13+
'EVERY RANGE=Cada rang'#13+
'INCLUDE NULL VALUES=Incloure valors buits'#13+
'DATE=Data'#13+
'ENTER DATE=Entrar data'#13+
'ENTER TIME=Entrar hora'#13+
'BEVEL SIZE=Tamany marc'#13+
'DEVIATION=Desviació'#13+
'UPPER=Superior'#13+
'LOWER=Inferior'#13+
'FILL 80%=Rellenar 80%'#13+
'FILL 60%=Rellenar 60%'#13+
'FILL 40%=Rellenar 40%'#13+
'FILL 20%=Rellenar 20%'#13+
'FILL 10%=Rellenar 10%'#13+
'ZIG ZAG=Zigazaga'#13+
'CONSTANT=Constant'#13+
'SHOW LABELS=Veure textes'#13+
'SHOW COLORS=Veure colors'#13+
'XYZ SERIES=Series XYZ'#13+
'SHOW X VALUES=Veure valors X'#13+
'DELETE ROW=Borrar fila'#13+
'VOLUME SERIES=Series Volum'#13+
'ACCUMULATE=Acumular'#13+
'SINGLE=Unic'#13+
'REMOVE CUSTOM COLORS=Eliminar colors'#13+
'STEP=Cada'#13+
'USE PALETTE MINIMUM=Usar mínim a paleta'#13+
'AXIS MAXIMUM=Màxim del eix'#13+
'AXIS CENTER=Centre del eix'#13+
'AXIS MINIMUM=Mínim del eix'#13+
'DAILY (NONE)=Diari (cap)'#13+
'WEEKLY=Setmanal'#13+
'MONTHLY=Mensual'#13+
'BI-MONTHLY=Bi-mensual'#13+
'QUARTERLY=Trimestral'#13+
'YEARLY=Anual'#13+
'DATETIME PERIOD=Periode dia/hora'#13+
'SMOOTH=Suau'#13+
'INTERPOLATE=Interpolar'#13+
'START X=Primera X'#13+
'NUM. POINTS=Num. Punts'#13+
'COLOR EACH LINE=Color cada linea'#13+
'CASE SENSITIVE=Majusc./Minusc.'#13+
'SORT BY=Ordenar per'#13+
'(NONE)=(cap)'#13+
'CALCULATION=Càlcul'#13+
'GROUP=Grup'#13+
'WEIGHT=Pes'#13+
'EDIT LEGEND=Editar llegenda'#13+
'IGNORE NULLS=Ignorar buits'#13+
'OFFSET=Desplaçament'#13+
'LIGHT 0=Llum 0'#13+
'LIGHT 1=Llum 1'#13+
'LIGHT 2=Llum 2'#13+
'DRAW STYLE=Estil dibuix'#13+
'POINTS=Punts'#13+
'PROFUND. FONT 3D=Prof. font 3D'#13+
'DEFAULT BORDER=Borde defecte'#13+
'SQUARED=Cuadrat'#13+
'SEPARATION=Separació'#13+
'ROUND BORDER=Borde arrodonit'#13+
'NUMBER OF SAMPLE VALUES=Nombre valors de mostra'#13+
'OUTLINE GRADIENT=Gradient marc'#13+
'DIF. LIMIT=Dif. Limit'#13+
'RESIZE PIXELS TOLERANCE=Pixels redim.'#13+
'FULL REPAINT=Pintar tot'#13+
'END POINT=Punt final'#13+
'BAND 1=Banda 1'#13+
'BAND 2=Banda 2'#13+
'GRID 3D SERIES=Series 3D'#13+
'TRANSPOSE NOW=Rotar ara'#13+
'NOTHING=Res'#13+
'LEFT TRIANGLE=Triangle Esq.'#13+
'RIGHT TRIANGLE=Triangle Dreta'#13+
'PERIOD 1=Periode 1'#13+
'PERIOD 2=Periode 2'#13+
'PERIOD 3=Periode 3'#13+
'HISTOGRAM=Histograma'#13+
'EXP. LINE=Linea Exp.'#13+
'MACD=MACD'#13+
'WEIGHTED=Ponderat'#13+
'WEIGHTED BY INDEX=Ponderat per index'#13+
'DARK BORDER=Borde fosc'#13+
'PIE SERIES=Series Pastís'#13+
'FOCUS=Focus'#13+
'EXPLODE=Expandir'#13+
'BOX SIZE=Tamany capsa'#13+
'REVERSAL AMOUNT=Invertir'#13+
'PERCENTAGE=Percentatge'#13+
'COMPLETE R.M.S.=RMS Complerta'#13+
'BUTTON=Butó'#13+
'ALL=Tot'#13+
'START AT MIN. VALUE=Començar a valor minim.'#13+
'EXECUTE !=Arrencar !'#13+
'WEB URL=Adreça Web'#13+
'FACTOR=Factor'#13+
'SELF STACK=Apilat auto.'#13+
'SIDE LINES=Línies laterals'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=De un arxiu plantilla'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Obrir plantilla desde arxiu'#13+
'EXPORT DIALOG=Diàleg exportació'#13+
'BINARY=Binari'#13+
'POINT COLORS=Colors Punts'#13+
'COVER=Coberta'#13+
'VALUE SOURCE=Origen valors'#13+
'CALLOUT=Enllaç'#13+
'POINTER=Punter'#13+
'DRAG=Arrastrar'#13+
'HANDPOINT=Mà'#13+
'HOURGLASS=Rellotge'#13+
'DRAG STYLE=Estil arrastrar'#13+
'RADIAL=Circular'#13+
'BALANCE=Balanç'#13+
'RADIAL OFFSET=Despl. radial'#13+
'ARROW WIDTH=Ample fletxa'#13+
'ARROW HEIGHT=Alt fletxa'#13+
'DEFAULT COLOR=Color defecte'+#13+
'SLANT CUBE=Cub inclinat'#13+
'TICK LINES=Línies marques'#13+
'% BAR DEPTH=% Prof. Barra'#13+
'METAL=Metall'#13+
'WOOD=Fusta'#13+
'STONE=Pedra'#13+
'CLOUDS=Núbols'#13+
'GRASS=Gespa'#13+
'FIRE=Foc'#13+
'SNOW=Neu'#13+
'HIGH-LOW=Alt-Baix'#13+
'VIEW SERIES NAMES=Noms de Series'#13+
'EDIT COLOR=Editar Color'#13+
'MAKE NULL POINT=Fer punt nul'#13+
'APPEND ROW=Afegir fila'#13+
'TEXT FONT=Font texte'#13+
'CHART THEME SELECTOR=Selecciona Tema gràfic'#13+
'PREVIEW=Visualitza'#13+
'THEMES=Temes'#13+
'COLOR PALETTE=Paleta Colors'#13+
'VIEW 3D=Veure 3D'#13+
'SCALE=Escalar'#13+
'MARGIN %=Marge %'#13+
'DRAW BEHIND AXES=Darrera eixos'#13+
'X GRID EVERY=Graella X cada'#13+
'Z GRID EVERY=Graella Z cada'#13+
'DATE PERIOD=Periode data'#13+
'TIME PERIOD=Periode temps'#13+
'USE SERIES Z=Usar Z'#13+
'NUMERIC FORMAT=Format numéric'#13+
'DATE TIME=Data hora'#13+
'GEOGRAPHIC=Geogràfic'#13+
'DECIMALS=Decimals'#13+
'FIXED=Fixes'#13+
'THOUSANDS=Mil.lers'#13+
'CURRENCY=Moneda'#13+
'VIEWS=Vistes'#13+
'ALTERNATE=Alternativa'#13+
'ZOOM ON UP LEFT DRAG=Arrastra dalt-esquerra'#13+
'FIXED POSITION=Posició fixe'#13+
'NO CHECK BOXES=Sense caselles'#13+
'RADIO BUTTONS=Botons radio'#13+
'Z DATETIME=Z Data-hora'#13+
'SYMBOL=Símbol'#13+
'AUTO HIDE=Auto ocultar'#13+
'GALLERY=Galería'#13+
'INVERTED GRAY=Gris invertits'#13+
'RAINBOW=Arc Sant Martí'#13+
'TEECHART LIGHTING=Il.luminaciò TeeChart'#13+
'LINEAR=Linear'#13+
'SPOTLIGHT=Llum focus'#13+
'SHAPE INDEX=Index forma'#13+
'CLOSED=Tancat'#13+
'DESIGN TIME OPTIONS=Opcions de disseny'#13+
'LANGUAGE=Llenguatge'#13+
'CHART GALLERY=Galería de Gràfics'#13+
'MODE=Modus'#13+
'CHART EDITOR=Editor Gràfics'#13+
'REMEMBER SIZE=Recordar tamany'#13+
'REMEMBER POSITION=Recordar posició'#13+
'TREE MODE=Modus Arbre'#13+
'RESET=Restaurar'#13+
'NEW CHART=Nou Gràfic'#13+
'DEFAULT THEME=Tema defecte'#13+
'TEECHART DEFAULT=Gràfic defecte'#13+
'CLASSIC=Clàsic'#13+
'BUSINESS=Negocis'#13+
'WEB=Xarxa'#13+
'BLUES=Blaus'#13+
'MULTIPLE PIES=Pastissos'#13+
'3D GRADIENT=Gradient 3D'#13+
'DISABLE=Anul.la'#13+
'COLOR EACH SLICE=Color cada porciò'#13+
'BASE LINE=Línia base'#13+
'INITIAL DELAY=Retràs inicial'#13+
'THUMB=Agafador'#13+
'AUTO-REPEAT=Auto-repetir'#13+
'BACK COLOR=Color de fons'#13+
'HANDLES=Agafadors'#13+
'ALLOW RESIZE CHART=Permetre redim. gràfic'#13+
'LOOP=Bucle'#13+
'ONE WAY=Anada'#13+
'DRAW BEHIND SERIES=Dibuixar darrera series'#13+
'CELL=Celda'#13+
'ROW=Fila'#13+
'COLUMN=Columna'#13+
'FAST BRUSH=Trama ràpida'#13+
'SVG OPTIONS=Opcions SVG'#13+
'TEXT ANTI-ALIAS=Texte suavitzat'#13+
'THEME=Tema'#13+
'TEXT QUOTES=Textes acotats'#13+
'PERIMETER=Perimetre'#13+
'CARIBE SUN=Sol Càrib'#13+
'CLEAR DAY=Dia clar'#13+
'DESERT=Desert'#13+
'FARM=Granja'#13+
'FUNKY=Funky'#13+
'GOLF=Golf'#13+
'HOT=Calent'#13+
'NIGHT=Nit'#13+
'PASTEL=Pastis'#13+
'SEA=Mar'#13+
'SEA 2=Mar 2'#13+
'SUNSET=Posta de Sol'#13+
'TROPICAL=Tropical'#13+
'DIAGONAL UP=Diagonal dalt'#13+
'DIAGONAL DOWN=Diagonal baix'#13+
'HIDE TRIANGLES=Ocultar triangles'#13+
'MIRRORED=Mirall'
;
  end;
end;

Procedure TeeSetCatalan;
begin
  TeeCreateCatalan;
  TeeLanguage:=TeeCatalanLanguage;
  TeeCatalanConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeCatalanLanguage);
end.
