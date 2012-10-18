unit TeeDanish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeDanishLanguage:TStringList=nil;

Procedure TeeSetDanish;
Procedure TeeCreateDanish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeDanishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 David Berneda';
  TeeMsg_LegendFirstValue   :='Første Ledetekstværdi skal være > 0';
  TeeMsg_LegendColorWidth   :='Legend farvebredde skal være > 0%';
  TeeMsg_SeriesSetDataSource:='Intet ForældreDiagram til at validere DataKilden';
  TeeMsg_SeriesInvDataSource:='Ingen gyldig DataKilde: %s';
  TeeMsg_FillSample         :='Udfydningsværdiens nummeriske værdier skal være > 0';
  TeeMsg_AxisLogDateTime    :='DatoTid akse kan ikke være logaritmisk';
  TeeMsg_AxisLogNotPositive :='Logaritmisk akse Min og Maks værdi skal være >= 0';
  TeeMsg_AxisLabelSep       :='Markatadskildelse % skal være større end 0';
  TeeMsg_AxisIncrementNeg   :='Akse forøgelse skal være >= 0';
  TeeMsg_AxisMinMax         :='Akse minimum værdi skal være <= maksimum';
  TeeMsg_AxisMaxMin         :='Akse maksimum værdi skal være >= minimum';
  TeeMsg_AxisLogBase        :='Akse Logaritme Base skal være >= 2';
  TeeMsg_MaxPointsPerPage   :='MaksPunkterPerSide skal være >= 0';
  TeeMsg_3dPercent          :='3D effektprocent skal være mellem %d og %d';
  TeeMsg_CircularSeries     :='Sammenhængende serie afhængighed er ikke tilladt';
  TeeMsg_WarningHiColor     :='16k farver eller bedre er påkrævet for at opnå bedre udseende';

  TeeMsg_DefaultPercentOf   :='%s af %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'af %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Akse Titel';
  TeeMsg_AxisLabels         :='Akse Markat';
  TeeMsg_RefreshInterval    :='Genopfrisk intervallet skal være mellem 0 og 60';
  TeeMsg_SeriesParentNoSelf :='Serier.ParentDiagram er ikke migselv!';
  TeeMsg_GalleryLine        :='Linie';
  TeeMsg_GalleryPoint       :='Point';
  TeeMsg_GalleryArea        :='Areal';
  TeeMsg_GalleryBar         :='Bar';
  TeeMsg_GalleryHorizBar    :='Horis. Bar';
  TeeMsg_Stack              :='Stak';
  TeeMsg_GalleryPie         :='Pie';
  TeeMsg_GalleryCircled     :='Cirkulær';
  TeeMsg_GalleryFastLine    :='Fast Linie';
  TeeMsg_GalleryHorizLine   :='Horis Linie';

  TeeMsg_PieSample1         :='Biler';
  TeeMsg_PieSample2         :='Telefoner';
  TeeMsg_PieSample3         :='Borde';
  TeeMsg_PieSample4         :='Monitorer';
  TeeMsg_PieSample5         :='Lamper';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Cykler';
  TeeMsg_PieSample8         :='Stole';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editer %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Udvidet';
  TeeMsg_GalleryFunctions   :='Funktioner';

  TeeMsg_EditChart          :='Re&diger Diagram...';
  TeeMsg_PrintPreview       :='Udskriv Vis&udskrift...';
  TeeMsg_ExportChart        :='E&ksporter Diagram...';
  TeeMsg_CustomAxes         :='Brugervalgte Akser...';

  TeeMsg_InvalidEditorClass :='%s: Ugyldig Editor Klasse: %s';
  TeeMsg_MissingEditorClass :='%s: har ingen Editor Dialog';

  TeeMsg_GalleryArrow       :='Pil';

  TeeMsg_ExpFinish          :='A&fslut';
  TeeMsg_ExpNext            :='&Næste >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Udvikling';
  TeeMsg_GanttSample4       :='Salg';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Produktion';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Ny Version';
  TeeMsg_GanttSample10      :='Bank';

  TeeMsg_ChangeSeriesTitle  :='Skift Serietitel';
  TeeMsg_NewSeriesTitle     :='Ny Serietitle:';
  TeeMsg_DateTime           :='DatoTid';
  TeeMsg_TopAxis            :='Top Akse';
  TeeMsg_BottomAxis         :='Bund Akse';
  TeeMsg_LeftAxis           :='Venstre Akse';
  TeeMsg_RightAxis          :='Højre Akse';

  TeeMsg_SureToDelete       :='Slet %s ?';
  TeeMsg_DateTimeFormat     :='DatoTid For&mat:';
  TeeMsg_Default            :='Standard';
  TeeMsg_ValuesFormat       :='Værdi For&mat:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Fortrukne %s Forøgelse';

  TeeMsg_IncorrectMaxMinValue:='Ugyldig værdi. Begrundelse: %s';
  TeeMsg_EnterDateTime      :='Angiv [Antal Dage] [tt:mm:ss]';

  TeeMsg_SureToApply        :='Tilføj ændringer ?';
  TeeMsg_SelectedSeries     :='(Valgte Serier)';
  TeeMsg_RefreshData        :='Genopf&risk Data';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='440';
  TeeMsg_FunctionAdd        :='Tilføj';
  TeeMsg_FunctionSubtract   :='Subtraktion';
  TeeMsg_FunctionMultiply   :='Multiplicer';
  TeeMsg_FunctionDivide     :='Divider';
  TeeMsg_FunctionHigh       :='Høj';
  TeeMsg_FunctionLow        :='Lav';
  TeeMsg_FunctionAverage    :='Gennemsnit';

  TeeMsg_GalleryShape       :='Former';
  TeeMsg_GalleryBubble      :='Bubbel';
  TeeMsg_FunctionNone       :='Kopi';

  TeeMsg_None               :='(ingen)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer størrelse skal være større end nul';
  TeeMsg_About              :='O&m TeeChart...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Datasæt';
  TeeMsg_AskDataSet         :='&Datasæt:';

  TeeMsg_SingleRecord       :='Enkelt Post';
  TeeMsg_AskDataSource      :='&Datakilde:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='FunktionsPeriode skal være >= 0';

  TeeMsg_WizardTab          :='Business';

  TeeMsg_ClearImage         :='&Rens';
  TeeMsg_BrowseImage        :='Gen&nemse...';

  TeeMsg_WizardSureToClose  :='Er du sikker på, at du vil lukke TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Feltet %s eksistrer ikke';

  TeeMsg_DepthAxis          :='Akse dybde';
  TeeMsg_PieOther           :='Andre';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pie';
  TeeMsg_ValuesBar          :='Bar';
  TeeMsg_ValuesAngle        :='Vinkel';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Slut';
  TeeMsg_ValuesGanttNextTask:='NæsteOpgave';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='SlutX';
  TeeMsg_ValuesArrowEndY    :='SlutY';
  TeeMsg_Legend             :='Ledetekst';
  TeeMsg_Title              :='Titel';
  TeeMsg_Foot               :='Bund';
  TeeMsg_Period		    :='Periode';
  TeeMsg_PeriodRange        :='Periode område';
  TeeMsg_CalcPeriod         :='Beregn %s hver:';
  TeeMsg_SmallDotsPen       :='Små punkter';

  TeeMsg_InvalidTeeFile     :='Ugyldigt Diagram i *.'+TeeMsg_TeeExtension+' filen';
  TeeMsg_WrongTeeFileFormat :='Forkert *.'+TeeMsg_TeeExtension+' fil-format';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Diagram Akse';
  TeeMsg_ChartAxesCategoryDesc   :='Diagram Akse egenskaber og handlinger';
  TeeMsg_ChartWallsCategoryName  :='Diagram vægge';
  TeeMsg_ChartWallsCategoryDesc  :='Diagram vægge egenskaber og handlinger';
  TeeMsg_ChartTitlesCategoryName :='Diagram Titler';
  TeeMsg_ChartTitlesCategoryDesc :='Diagram Titler egenskaber og handlinger';
  TeeMsg_Chart3DCategoryName     :='Diagram 3D';
  TeeMsg_Chart3DCategoryDesc     :='Diagram 3D egenskaber og handlinger';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Brugervalgt ';
  TeeMsg_Series                 :='Serier';
  TeeMsg_SeriesList             :='Serier...';

  TeeMsg_PageOfPages            :='Side %d af %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Første';
  TeeMsg_Prior  :='Forgående';
  TeeMsg_Next   :='Næste';
  TeeMsg_Last   :='Sidste';
  TeeMsg_Insert :='Indsæt';
  TeeMsg_Delete :='Slet';
  TeeMsg_Edit   :='Editer';
  TeeMsg_Post   :='Gem';
  TeeMsg_Cancel :='Afbryd';

  TeeMsg_All    :='(alle)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='som &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='som &Metafil';
  TeeMsg_EMFFilter    :='Udvidet Metafil (*.emf)|*.emf|Metafil (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Panel property er ikke sat i Eksport format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Ingen Kant';
  TeeMsg_Dotted    :='Prikkede';
  TeeMsg_Colors    :='Farver';
  TeeMsg_Filled    :='Udfyldt';
  TeeMsg_Marks     :='Mærker';
  TeeMsg_Stairs    :='Trapper';
  TeeMsg_Points    :='Punkter';
  TeeMsg_Height    :='Højde';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='2D Punkter';
  TeeMsg_Triangle  :='Trekant';
  TeeMsg_Star      :='Stjerner';
  TeeMsg_Circle    :='Cirkel';
  TeeMsg_DownTri   :='Nedadvendt Tri.';
  TeeMsg_Cross     :='Kryds';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Ingen Linier';
  TeeMsg_Stack100  :='Stakkede 100%';
  TeeMsg_Pyramid   :='Pyramide';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Inv. Pyramide';
  TeeMsg_Sides     :='Sider';
  TeeMsg_SideAll   :='Sidestil Alle';
  TeeMsg_Patterns  :='Mønstre';
  TeeMsg_Exploded  :='Udfold';
  TeeMsg_Shadow    :='Skygge';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Rektangel';
  TeeMsg_VertLine  :='Vert.Linie';
  TeeMsg_HorizLine :='Horis.Linie';
  TeeMsg_Line      :='Linie';
  TeeMsg_Cube      :='Kube';
  TeeMsg_DiagCross :='Diag.Kryds';

  TeeMsg_CanNotFindTempPath    :='Kan ikke finde Temp mappen';
  TeeMsg_CanNotCreateTempChart :='Kan ikke lave Temp fil';
  TeeMsg_CanNotEmailChart      :='Kan ikke emaile TeeChart. Mapi Fejl: %d';

  TeeMsg_SeriesDelete :='Slet Serier: VærdiIndeks %d out of bounds (0 til %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Language...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Lys';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Overflade';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D Punkter';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Markør';
  TeeMsg_GalleryBar3D       :='Bar 3D';
  TeeMsg_GalleryBigCandle   :='Stort Lys';
  TeeMsg_GalleryLinePoint   :='Linie Punkter';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Vandfald';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Ur';
  TeeMsg_GalleryColorGrid   :='FarveGitter';
  TeeMsg_GalleryBoxPlot     :='BoksPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horis.BoksPlot';
  TeeMsg_GalleryBarJoin     :='Bar Sammensætning';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramide';
  TeeMsg_GalleryMap         :='Kort';

  TeeMsg_PolyDegreeRange    :='Polynomial grad must be between 1 and 20';
  TeeMsg_AnswerVectorIndex   :='Svar Vektor indeks skal være mellem 1 og %d';
  TeeMsg_FittingError        :='Kan ikke fortsætte med tilpasning';
  TeeMsg_PeriodRange         :='Perioden skal være >= 0';
  TeeMsg_ExpAverageWeight    :='ExpGennemsnit vægt skal være mellem 0 og 1';
  TeeMsg_GalleryErrorBar     :='Fejl Bar';
  TeeMsg_GalleryError        :='Fejl';
  TeeMsg_GalleryHighLow      :='Høj-Lav';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp. Gennemsnit';
  TeeMsg_FunctionMovingAverage:='Flytende Genms.';
  TeeMsg_FunctionExpMovAve   :='Exp.Flyt.Genms.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Kurve Tilpasning';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulativ';
  TeeMsg_FunctionStdDeviation:='Std.Afvigelse';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stokastisk';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Tæller';
  TeeMsg_LoadChart           :='Åbn TeeChart...';
  TeeMsg_SaveChart           :='Gem TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro filer';

  TeeMsg_GallerySamples      :='Andre';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Kan ikke finde Serieeditor Fra: %s';


  TeeMsg_CannotLoadChartFromURL:='Fejlkode: %d downloading Diagram fra URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Fejlkode: %d downloading Seriedata fra URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Dato';
  TeeMsg_ValuesOpen          :='Åbn';
  TeeMsg_ValuesHigh          :='Høj';
  TeeMsg_ValuesLow           :='Lav';
  TeeMsg_ValuesClose         :='Luk';
  TeeMsg_ValuesOffset        :='Udgangspunkt';
  TeeMsg_ValuesStdError      :='StdFejl';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Antallet af Bezier punkter skal være > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Udskriv';
  TeeCommanMsg_Copy     :='Kopier';
  TeeCommanMsg_Save     :='Gem';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d° Elevation: %d°';
  TeeCommanMsg_Rotate   :='Rotèr';

  TeeCommanMsg_Moving   :='Horis.Udgangspkt.: %d Vert.Udgangspkt.: %d';
  TeeCommanMsg_Move     :='Flyt';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Dybde';

  TeeCommanMsg_Chart    :='Diagram';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Træk i %s for at Rotere';
  TeeCommanMsg_MoveLabel  :='Træk i %s for at Flytte';
  TeeCommanMsg_ZoomLabel  :='Træk i %s for at Zoome';
  TeeCommanMsg_DepthLabel :='Træk i %s for at ændre 3D størrelsen';

  TeeCommanMsg_NormalLabel:='Træk i venstre knap for at Zoome, højre for at Scrolle';
  TeeCommanMsg_NormalPieLabel:='Træk i et Pie element for at udviden det';

  TeeCommanMsg_PieExploding :='Element: %d Udvidet: %d %%';

  TeeMsg_TriSurfaceLess:='Antallet af punkter skal være >= 4';
  TeeMsg_TriSurfaceAllColinear:='Alle colineære data punkter';
  TeeMsg_TriSurfaceSimilar:='Identiske punkter - Kan ikke udfører';
  TeeMsg_GalleryTriSurface:='Trekant overf.';

  TeeMsg_AllSeries :='Alle Serier';
  TeeMsg_Edit      :='Editèr';

  TeeMsg_GalleryFinancial    :='Financial';

  TeeMsg_CursorTool    :='Markør';
  TeeMsg_DragMarksTool :='Træk mærker';
  TeeMsg_AxisArrowTool :='Akse Pile';
  TeeMsg_DrawLineTool  :='Tegn Linie';
  TeeMsg_NearestTool   :='Nærmeste Punkt';
  TeeMsg_ColorBandTool :='Båndfarve';
  TeeMsg_ColorLineTool :='Liniefarve';
  TeeMsg_RotateTool    :='Roter';
  TeeMsg_ImageTool     :='Billede';
  TeeMsg_MarksTipTool  :='Mærke Tips';

  TeeMsg_CantDeleteAncestor  :='Kan ikke slette ancestor';

  TeeMsg_Load	         :='Hent...';
  TeeMsg_NoSeriesSelected:='Ingen Serier er valgt';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Diagram';
  TeeMsg_CategorySeriesActions :='Diagram Serier';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Skift 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktive';
  TeeMsg_ActionSeriesActiveHint :='Vis / Gem Serier';
  TeeMsg_ActionEditHint         :='Editèr Diagram';
  TeeMsg_ActionEdit             :='&Editèr...';
  TeeMsg_ActionCopyHint         :='Kopier til Udskriftholder';
  TeeMsg_ActionCopy             :='&Kopier';
  TeeMsg_ActionPrintHint        :='Udskriv Vis Udskrift af Diagram';
  TeeMsg_ActionPrint            :='&Udskriv...';
  TeeMsg_ActionAxesHint         :='Vis / Gem Akser';
  TeeMsg_ActionAxes             :='&Akser';
  TeeMsg_ActionGridsHint        :='Vis / Gem Gitter';
  TeeMsg_ActionGrids            :='&Gitter';
  TeeMsg_ActionLegendHint       :='Vis / Gem Ledetekst';
  TeeMsg_ActionLegend           :='&Ledetekst';
  TeeMsg_ActionSeriesEditHint   :='Editèr Serier';
  TeeMsg_ActionSeriesMarksHint  :='Vis / Gem Series Marks';
  TeeMsg_ActionSeriesMarks      :='&Mærke';
  TeeMsg_ActionSaveHint         :='Gem Diagram';
  TeeMsg_ActionSave             :='&Gem...';

  TeeMsg_CandleBar              :='Bar';
  TeeMsg_CandleNoOpen           :='Ingen Åbn';
  TeeMsg_CandleNoClose          :='Ingen Luk';
  TeeMsg_NoLines                :='Ingen Linier';
  TeeMsg_NoHigh                 :='Ingen Høj';
  TeeMsg_NoLow                  :='Ingen Lav';
  TeeMsg_ColorRange             :='Farveområde';
  TeeMsg_WireFrame              :='Trådramme';
  TeeMsg_DotFrame               :='Prikramme';
  TeeMsg_Positions              :='Positioner';
  TeeMsg_NoGrid                 :='Ingen Gitter';
  TeeMsg_NoPoint                :='Ingen Punkter';
  TeeMsg_NoLine                 :='Ingen Linie';
  TeeMsg_Labels                 :='Markater';
  TeeMsg_NoCircle               :='Ingen Cirkel';
  TeeMsg_Lines                  :='Linier';
  TeeMsg_Border                 :='Kant';

  TeeMsg_SmithResistance      :='Modstand';
  TeeMsg_SmithReactance       :='Reaktans';

  TeeMsg_Column  :='Kolonne';

  { 5.02 }
  TeeMsg_Origin               :='Udgangspunkt';
  TeeMsg_Transparency         :='Gennemsigtighed';
  TeeMsg_Box		      :='Boks';
  TeeMsg_ExtrOut	      :='ExtrOut';
  TeeMsg_MildOut	      :='MildOut';
  TeeMsg_PageNumber	      :='Sidenummer';

  { 5.02 } 

  TeeMsg_AsJPEG        :='som &JPEG';
  TeeMsg_JPEGFilter    :='JPEG Filer (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='som &GIF';
  TeeMsg_GIFFilter     :='GIF Filer (*.gif)|*.gif';
  TeeMsg_AsPNG         :='som &PNG';
  TeeMsg_PNGFilter     :='PNG Filer (*.png)|*.png';
  TeeMsg_AsPCX         :='som PC&X';
  TeeMsg_PCXFilter     :='PCX Filer (*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Gradient             :='Hældningsgrad';
  TeeMsg_WantToSave           :='Gem %s?';

  TeeMsg_Property            :='Egenskab';
  TeeMsg_Value               :='Værdi';
  TeeMsg_Yes                 :='Ja';
  TeeMsg_No                  :='Nej';
  TeeMsg_Image              :='(billede)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Træk Punkt';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Release ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Kan ikke importere TeeChart fra %s';
  TeeMsg_ActiveXVerbPrint    := 'Udskriv &Preview...';
  TeeMsg_ActiveXVerbExport   := 'E&ksport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Hjælp...';
  TeeMsg_ActiveXVerbAbout    := '&Om TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Fejlkode: %d ved download: %s';
  TeeMsg_DatasourceError     := 'TeeChart: Datakilde er ikke en Serie eller RecordSæt';
  TeeMsg_SeriesTextSrcError  := 'Ugyldig Serietype';
  TeeMsg_AxisTextSrcError    := 'Ugyldig Aksetype';
  TeeMsg_DelSeriesDatasource := 'Er du sikker på, du vil slette %s ?';
  TeeMsg_OCXNoPrinter        := 'Ingen standard printer installeret.';
  TeeMsg_ActiveXPictureNotValid:='Billedet er ugyldigt';

  // 6.0
  // TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='som &PDF';
  TeeMsg_PDFFilter        :='PDF filer (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='som PostScript';
  TeeMsg_PSFilter         :='PostScript filer (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horisontal'#13'Areal';
  TeeMsg_SelfStack        :='Selvstablende';
  TeeMsg_DarkPen          :='Mørk Kant';
  TeeMsg_SelectFolder     :='Vælg databasemappe';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Forbindelse:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Udglatning';
  TeeMsg_FunctionCross        :='Kryds Punkter';
  TeeMsg_GridTranspose        :='3D Raster Ombytning';
  TeeMsg_FunctionCompress     :='Komprimering';
  TeeMsg_ExtraLegendTool      :='Ekstra Forklaring';
  TeeMsg_FunctionCLV          :='Luk Lokation'#13'Værdi';
  TeeMsg_FunctionOBV          :='Ved Balance'#13'Volumen';
  TeeMsg_FunctionCCI          :='Produkt'#13'Kanal Indeks';
  TeeMsg_FunctionPVO          :='Volumen'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Serier Animation';
  TeeMsg_GalleryPointFigure   :='Punkter & Figurer';
  TeeMsg_Up                   :='Op';
  TeeMsg_Down                 :='Ned';
  TeeMsg_GanttTool            :='Gantt Træk';
  TeeMsg_XMLFile              :='XML fil';
  TeeMsg_GridBandTool         :='Rasterbånd værktøj';
  TeeMsg_FunctionPerf         :='Udførelse';
  TeeMsg_GalleryGauge         :='Mål';
  TeeMsg_GalleryGauges        :='Mål';
  TeeMsg_ValuesVectorEndZ     :='SlutZ';
  TeeMsg_GalleryVector3D      :='3D Vektor';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Tårn';
  TeeMsg_SingleColor          :='Enkel Farve';
  TeeMsg_Cover                :='Cover';
  TeeMsg_Cone                 :='Kegle';
  TeeMsg_PieTool              :='Cirkel Dele';
end;

Procedure TeeCreateDanish;
begin
  if not Assigned(TeeDanishLanguage) then
  begin
    TeeDanishLanguage:=TStringList.Create;
    TeeDanishLanguage.Text:=

'GRADIENT EDITOR=Hældningseditor'#13+
'GRADIENT=Hældning'#13+
'DIRECTION=Retning'#13+
'VISIBLE=Synlig'#13+
'TOP BOTTOM=Top Bund'#13+
'BOTTOM TOP=Bund Top'#13+
'LEFT RIGHT=Venstre Højre'#13+
'RIGHT LEFT=Højre Venstre'#13+
'FROM CENTER=Fra Center'#13+
'FROM TOP LEFT=Fra Top Venstre'#13+
'FROM BOTTOM LEFT=Fra Bund Venstre'#13+
'OK=Ok'#13+
'CANCEL=Anuller'#13+
'COLORS=Farver'#13+
'START=Start'#13+
'MIDDLE=Midten'#13+
'END=Slut'#13+
'SWAP=Byt'#13+
'NO MIDDLE=Ingen Midte'#13+
'TEEFONT EDITOR=TeeSkrifttype Editor'#13+
'INTER-CHAR SPACING=Mellem-tegn afstand'#13+
'FONT=Skrifttype'#13+
'SHADOW=Skygge'#13+
'HORIZ. SIZE=Horis. Str.'#13+
'VERT. SIZE=Vert. Str.'#13+
'COLOR=Farve'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Options'#13+
'FORMAT=Formatering'#13+
'TEXT=Tekst'#13+
'POSITION=Position'#13+
'LEFT=Venstre'#13+
'TOP=Top'#13+
'AUTO=Auto'#13+
'CUSTOM=Brugervalgt'#13+
'LEFT TOP=Left top'#13+
'LEFT BOTTOM=Left bottom'#13+
'RIGHT TOP=Right top'#13+
'RIGHT BOTTOM=Right bottom'#13+
'MULTIPLE AREAS=Multiple Arealer'#13+
'NONE=Ingen'#13+
'STACKED=Stakkede'#13+
'STACKED 100%=Stakkede 100%'#13+
'AREA=Areal'#13+
'PATTERN=Mønster'#13+
'STAIRS=Trapper'#13+
'SOLID=Udfyldt'#13+
'CLEAR=Clear'#13+
'HORIZONTAL=Horisontal'#13+
'VERTICAL=Vertikal'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Kryds'#13+
'DIAG.CROSS=Diag.Cross'#13+
'AREA LINES=Areallinier'#13+
'BORDER=Rand'#13+
'INVERTED=Inveterede'#13+
'INVERTED SCROLL=Inveterede Scroll'#13+
'COLOR EACH=Farvelæg enk.'#13+
'ORIGIN=Kilde'#13+
'USE ORIGIN=Brug Kilde'#13+
'WIDTH=Brede'#13+
'HEIGHT=Højde'#13+
'AXIS=Akse'#13+
'LENGTH=Længde'#13+
'SCROLL=Scroll'#13+
'BOTH=Begge'#13+
'AXIS INCREMENT=Akse forøgelse'#13+
'INCREMENT=Forøgelse'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Et Millisekund'#13+
'ONE SECOND=Et Sekund'#13+
'FIVE SECONDS=Fem Sekunder'#13+
'TEN SECONDS=Ti Sekunder'#13+
'FIFTEEN SECONDS=Femten Sekunder'#13+
'THIRTY SECONDS=Tredive Sekunder'#13+
'ONE MINUTE=Et Minut'#13+
'FIVE MINUTES=Fem Minuter'#13+
'TEN MINUTES=Ti Minuter'#13+
'FIFTEEN MINUTES=Femten Minuter'#13+
'THIRTY MINUTES=Tredive Minuter'#13+
'ONE HOUR=En Time'#13+
'TWO HOURS=To Timer'#13+
'SIX HOURS=Seks Timer'#13+
'TWELVE HOURS=Tolv Timer'#13+
'ONE DAY=En Dag'#13+
'TWO DAYS=To Dag'#13+
'THREE DAYS=Tre Dage'#13+
'ONE WEEK=En Uge'#13+
'HALF MONTH=Halv Måned'#13+
'ONE MONTH=En Måned'#13+
'TWO MONTHS=To Måneder'#13+
'THREE MONTHS=Tre Måneder'#13+
'FOUR MONTHS=Fire Måneder'#13+
'SIX MONTHS=Seks Måneder'#13+
'ONE YEAR=Et År'#13+
'EXACT DATE TIME=Eksakt Dato Tid'#13+
'AXIS MAXIMUM AND MINIMUM=Akse Maximum og Minimum'#13+
'VALUE=Værdi'#13+
'TIME=Tid'#13+
'LEFT AXIS=Venstre Akse'#13+
'RIGHT AXIS=Højre Akse'#13+
'TOP AXIS=Top Akse'#13+
'BOTTOM AXIS=Bund Akse'#13+
'% BAR WIDTH=% Bar Bredde'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% Bar Forskydning'#13+
'RECTANGLE=Rektangel'#13+
'PYRAMID=Pyramide'#13+
'INVERT. PYRAMID=Invert. Pyramide'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Ellipse'#13+
'ARROW=Arrow'#13+
'RECT. GRADIENT=Rect. Gradient'#13+
'CONE=Cone'#13+
'DARK BAR 3D SIDES=Mørke Bar 3D Sider'#13+
'BAR SIDE MARGINS=Bar Side Marginer'#13+
'AUTO MARK POSITION=Auto Mærke Position'#13+
'JOIN=Join'#13+
'DATASET=Datasæt'#13+
'APPLY=Anvend'#13+
'SOURCE=Kilde'#13+
'MONOCHROME=Monokrom'#13+
'DEFAULT=Standard'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Median'#13+
'WHISKER=Strøg'#13+
'PATTERN COLOR EDITOR=Mønster Farve Editor'#13+
'IMAGE=Billede'#13+
'BACK DIAGONAL=Diagonal tilbage'#13+
'DIAGONAL CROSS=Diagonal Kryds'#13+
'FILL 80%=Udfyld 80%'#13+
'FILL 60%=Udfyld 60%'#13+
'FILL 40%=Udfyld 40%'#13+
'FILL 20%=Udfyld 20%'#13+
'FILL 10%=Udfyld 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Vertikal lille'#13+
'HORIZ. SMALL=Horis. lille'#13+
'DIAG. SMALL=Diag. lille'#13+
'BACK DIAG. SMALL=Diag. lille tilbage'#13+
'CROSS SMALL=Kryds lille'#13+
'DIAG. CROSS SMALL=Diag. Kryds lille'#13+
'DAYS=Dage'#13+
'WEEKDAYS=Ugedage'#13+
'TODAY=I dag'#13+
'SUNDAY=Søndag'#13+
'TRAILING=Spor'#13+
'MONTHS=Måneder'#13+
'LINES=Linier'#13+
'SHOW WEEKDAYS=Vis Ugedage'#13+
'UPPERCASE=STORE TEGN'#13+
'TRAILING DAYS=Spor dage'#13+
'SHOW TODAY=Vis i dag'#13+
'SHOW MONTHS=Vis Måneder'#13+
'CANDLE WIDTH=Lys Bredde'#13+
'STICK=Stav'#13+
'BAR=Bar'#13+
'OPEN CLOSE=Åbn Luk'#13+
'UP CLOSE=Luk opad'#13+
'DOWN CLOSE=Luk nedad'#13+
'SHOW OPEN=Vis Åbn'#13+
'SHOW CLOSE=Vis Luk'#13+
'DRAW 3D=Tegn 3D'#13+
'DARK 3D=Mørk 3D'#13+
'EDITING=Editer'#13+
'CHART=Diagram'#13+
'SERIES=Serier'#13+
'DATA=Data'#13+
'TOOLS=Værktøj'#13+
'EXPORT=Eksport'#13+
'PRINT=Udskrift'#13+
'GENERAL=Generelt'#13+
'TITLES=Titler'#13+
'LEGEND=Ledetekster'#13+
'PANEL=Paneler'#13+
'PAGING=Side'#13+
'WALLS=Vægge'#13+
'3D=3D'#13+
'ADD=Tilføj'#13+
'DELETE=Slet'#13+
'TITLE=Titel'#13+
'CLONE=Klon'#13+
'CHANGE=Skift'#13+
'HELP=Hjælp'#13+
'CLOSE=Luk'#13+
'TEECHART PRINT PREVIEW=TeeChart Vis Udskrift'#13+
'PRINTER=Printer'#13+
'SETUP=Egenskaber'#13+
'ORIENTATION=Papirretning'#13+
'PORTRAIT=Portræt'#13+
'LANDSCAPE=Landskab'#13+
'MARGINS (%)=Marginer (%)'#13+
'DETAIL=Detaljer'#13+
'MORE=Mere'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Reset Marginet'#13+
'VIEW MARGINS=Vis Marginer'#13+
'PROPORTIONAL=Proportional'#13+
'CIRCLE=Cirkel'#13+
'VERTICAL LINE=Vertilal Linie'#13+
'HORIZ. LINE=Horis. Linie'#13+
'TRIANGLE=Trekant'#13+
'INVERT. TRIANGLE=Invert. Trekant'#13+
'LINE=Linie'#13+
'DIAMOND=Diamand'#13+
'CUBE=Kube'#13+
'STAR=Stjerne'#13+
'TRANSPARENT=Transparens'#13+
'HORIZ. ALIGNMENT=Horis. Opstilling'#13+
'CENTER=Center'#13+
'RIGHT=Højre'#13+
'ROUND RECTANGLE=Afrund Rektangel'#13+
'ALIGNMENT=Opstilling'#13+
'BOTTOM=Bund'#13+
'UNITS=Enheder'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Akse udgangspunkt'#13+
'ROTATION=Rotation'#13+
'CIRCLED=Cirkulær'#13+
'3 DIMENSIONS=3 Dimensioner'#13+
'RADIUS=Radius'#13+
'ANGLE INCREMENT=Vinkel Forøgelse'#13+
'RADIUS INCREMENT=Radius Forøgelse'#13+
'CLOSE CIRCLE=Luk Cirkel'#13+
'PEN=Pen'#13+
'LABELS=Markater'#13+
'ROTATED=Rotaterede'#13+
'CLOCKWISE=Med uret'#13+
'INSIDE=Indeni'#13+
'ROMAN=Roman'#13+
'HOURS=Timer'#13+
'MINUTES=Minuter'#13+
'SECONDS=Sekunder'#13+
'START VALUE=Start værdi'#13+
'END VALUE=Slut værdi'#13+
'TRANSPARENCY=Transparens'#13+
'DRAW BEHIND=Tegn Bagved'#13+
'COLOR MODE=Farve Modus'#13+
'STEPS=Skridt'#13+
'RANGE=Rækkevide'#13+
'PALETTE=Palette'#13+
'PALE=Rolig'#13+
'STRONG=Stærk'#13+
'GRID SIZE=Gitterstørrelse'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Dybde'#13+
'IRREGULAR=Irregulær'#13+
'GRID=Gitter'#13+
'ALLOW DRAG=Tillad Træk'#13+
'VERTICAL POSITION=Vertikal Position'#13+
'LEVELS POSITION=Niveau position'#13+
'LEVELS=Niveauer'#13+
'NUMBER=Nummer'#13+
'LEVEL=Niveau'#13+
'AUTOMATIC=Automatisk'#13+
'SNAP=Snappe'#13+
'FOLLOW MOUSE=Følg mus'#13+
'STACK=Stak'#13+
'HEIGHT 3D=Højde 3D'#13+
'LINE MODE=Linie Modus'#13+
'OVERLAP=Overlap'#13+
'STACK 100%=Stak 100%'#13+
'CLICKABLE=Klikbare'#13+
'AVAILABLE=Tilgængelige'#13+
'SELECTED=Valgte'#13+
'DATASOURCE=Datakilde'#13+
'GROUP BY=Grupperet af'#13+
'CALC=Beregn'#13+
'OF=af'#13+
'SUM=Sum'#13+
'COUNT=Antal'#13+
'HIGH=Høj'#13+
'LOW=Lav'#13+
'AVG=Gennemsint'#13+
'HOUR=Time'#13+
'DAY=Dag'#13+
'WEEK=Uge'#13+
'WEEKDAY=Ugedag'#13+
'MONTH=Måned'#13+
'QUARTER=Kvatal'#13+
'YEAR=År'#13+
'HOLE %=Hul %'#13+
'RESET POSITIONS=Reset positioner'#13+
'MOUSE BUTTON=Musseknap'#13+
'ENABLE DRAWING=Slå tegning til'#13+
'ENABLE SELECT=Slå Udvælgelse til'#13+
'ENHANCED=Udvidet'#13+
'ERROR WIDTH=Fejl Bredde'#13+
'WIDTH UNITS=Breddeenhed'#13+
'PERCENT=Procent'#13+
'LEFT AND RIGHT=Venstre og Højre'#13+
'TOP AND BOTTOM=Top og Bund'#13+
'BORDER EDITOR=Kant Editor'#13+
'DASH=Streg'#13+
'DOT=Prik'#13+
'DASH DOT=Streg Prik'#13+
'DASH DOT DOT=Streg Prik Prik'#13+
'CALCULATE EVERY=Beregn hver:'#13+
'ALL POINTS=Alle punkter'#13+
'NUMBER OF POINTS=Antal af punkter'#13+
'RANGE OF VALUES=Række af værdier'#13+
'FIRST=Første'#13+
'LAST=Sidste'#13+
'TEEPREVIEW EDITOR=TeePreview Editor'#13+
'ALLOW MOVE=Tillad flytning'#13+
'ALLOW RESIZE=Tillad ændring i str.'#13+
'DRAG IMAGE=Træk Billede'#13+
'AS BITMAP=Som Bitmap'#13+
'SHOW IMAGE=Vis Billede'#13+
'MARGINS=Marginer'#13+
'SIZE=Str.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Elevation'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horis. Forskydning'#13+
'VERT. OFFSET=Vert. Forskydning'#13+
'PERSPECTIVE=Perspektiv'#13+
'ANGLE=Vinkel'#13+
'ORTHOGONAL=Retvinklet'#13+
'ZOOM TEXT=Zoom Tekst'#13+
'SCALES=Scales'#13+
'TICKS=Mærker'#13+
'MINOR=Mindre'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(maks)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Fortrukne Forøgelse'#13+
'(INCREMENT)=(forøgelse)'#13+
'LOG BASE=Log Base'#13+
'LOGARITHMIC=Logaritmisk'#13+
'MIN. SEPARATION %=Min. Adskildelse %'#13+
'MULTI-LINE=Multi-linie'#13+
'LABEL ON AXIS=Mærkater På Akserne'#13+
'ROUND FIRST=Round First'#13+
'MARK=Mærke'#13+
'LABELS FORMAT=Markat Format'#13+
'EXPONENTIAL=Eksponential'#13+
'DEFAULT ALIGNMENT=Standard opstilling'#13+
'LEN=Længde'#13+
'INNER=Indvendig'#13+
'AT LABELS ONLY=Kun ved markater'#13+
'CENTERED=Centreret'#13+
'POSITION %=Position %'#13+
'START %=Start %'#13+
'END %=Slut %'#13+
'OTHER SIDE=Anden side'#13+
'AXES=Akse'#13+
'BEHIND=Bagved'#13+
'CLIP POINTS=Skæremærker'#13+
'PRINT PREVIEW=Vis Udskrift'#13+
'MINIMUM PIXELS=Minimum pixels'#13+
'ALLOW=Tillad'#13+
'ANIMATED=Animerede'#13+
'ALLOW SCROLL=Tillad Scroll'#13+
'TEEOPENGL EDITOR=TeeOpenGL Editor'#13+
'AMBIENT LIGHT=Omsluttende Lys'#13+
'SHININESS=Skinbarhed'#13+
'FONT 3D DEPTH=Skrifttype 3D Dybde'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Skrifttype Kontur'#13+
'SMOOTH SHADING=Blød skygge'#13+
'LIGHT=Lys'#13+
'Y=Y'#13+
'INTENSITY=Intensitet'#13+
'BEVEL=Skråkant'#13+
'FRAME=Ramme'#13+
'ROUND FRAME=Runde Rammer'#13+
'LOWERED=Sænket'#13+
'RAISED=Opløftet'#13+
'SYMBOLS=Symboler'#13+
'TEXT STYLE=Tekststil'#13+
'LEGEND STYLE=LedetekstStil'#13+
'VERT. SPACING=Vert. Afstand'#13+
'SERIES NAMES=Serie Navne'#13+
'SERIES VALUES=Serie Værdier'#13+
'LAST VALUES=Sidste Værdier'#13+
'PLAIN=Plain'#13+
'LEFT VALUE=Værdi Værdi'#13+
'RIGHT VALUE=Værdi Højre'#13+
'LEFT PERCENT=Procent Venstre'#13+
'RIGHT PERCENT=Procent Højre'#13+
'X VALUE=X Værdi'#13+
'X AND VALUE=X og Værdi'#13+
'X AND PERCENT=X og Procent'#13+
'CHECK BOXES=Krydsbokse'#13+
'DIVIDING LINES=Adskille Linier'#13+
'FONT SERIES COLOR=Skrifttypeserie Farve'#13+
'POSITION OFFSET %=Positionsudløb %'#13+
'MARGIN=Margin'#13+
'RESIZE CHART=Ændre størrelse på Diagram'#13+
'CONTINUOUS=Kontinuerlig'#13+
'POINTS PER PAGE=Punkter pr Side'#13+
'SCALE LAST PAGE=Skallèr Sidste Side'#13+
'CURRENT PAGE LEGEND=Aktuelle Sides Ledetekst'#13+
'PANEL EDITOR=Panel Editor'#13+
'BACKGROUND=Baggrund'#13+
'BORDERS=Ramme'#13+
'BACK IMAGE=Baggrundsbillede'#13+
'STRETCH=Strukket'#13+
'TILE=Kakler'#13+
'BEVEL INNER=Skråkant Indei'#13+
'BEVEL OUTER=Skråk. Udenpå'#13+
'MARKS=Mærker'#13+
'DATA SOURCE=Datakilde'#13+
'SORT=Sortering'#13+
'CURSOR=Markør'#13+
'SHOW IN LEGEND=Vis i ledetekst'#13+
'FORMATS=Formater'#13+
'VALUES=Værdier'#13+
'PERCENTS=Procenter'#13+
'HORIZONTAL AXIS=Horisontal Akse'#13+
'DATETIME=DatoTid'#13+
'VERTICAL AXIS=Vertikal Akse'#13+
'ASCENDING=Stigende'#13+
'DESCENDING=Faldende'#13+
'DRAW EVERY=Tegn hver'#13+
'CLIPPED=Clipped'#13+
'ARROWS=Pile'#13+
'MULTI LINE=Multi linie'#13+
'ALL SERIES VISIBLE=Alle Serier Synlige'#13+
'LABEL=Markat'#13+
'LABEL AND PERCENT=Markat og Procent'#13+
'LABEL AND VALUE=Markat og Værdi'#13+
'PERCENT TOTAL=Procent Total'#13+
'LABEL AND PERCENT TOTAL=Markat Procent Total'#13+
'X AND Y VALUES=X og Y værdier'#13+
'MANUAL=Manuelt'#13+
'RANDOM=Random'#13+
'FUNCTION=Funktion'#13+
'NEW=Ny'#13+
'EDIT=Editèr'#13+
'PERSISTENT=Vedvarende'#13+
'ADJUST FRAME=Juster ramme'#13+
'SUBTITLE=UnderTitel'#13+
'SUBFOOT=Fod'#13+
'FOOT=UnderFod'#13+
'VISIBLE WALLS=Synlige vægge'#13+
'BACK=Baggrund'#13+
'DIF. LIMIT=Dif. begrænsning'#13+
'ABOVE=Ovenfor'#13+
'WITHIN=Mellem'#13+
'BELOW=Nedenfor'#13+
'CONNECTING LINES=Forbindende Linier'#13+
'BROWSE=Gennemse'#13+
'TILED=Kaklede'#13+
'INFLATE MARGINS=Fylde Marginer op'#13+
'SQUARE=Firkant'#13+
'DOWN TRIANGLE=Nedadvendt Trekant'#13+
'SMALL DOT=Smal Prik'#13+
'GLOBAL=Global'#13+
'SHAPES=Former'#13+
'BRUSH=Pensel'#13+
'DELAY=Forsinkelse'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Mussehandling'#13+
'MOVE=Flyt'#13+
'CLICK=Klik'#13+
'DRAW LINE=Tegn Linie'#13+
'EXPLODE BIGGEST=Ekspander største'#13+
'TOTAL ANGLE=Total vinkel'#13+
'GROUP SLICES=Gruppestykker'#13+
'BELOW %=Under %'#13+
'BELOW VALUE=Under Værdi'#13+
'OTHER=Anden'#13+
'PATTERNS=Mønstre'#13+
'SIZE %=Størrelse %'#13+
'SERIES DATASOURCE TEXT EDITOR=Serier DataKilde Tekst Editor'#13+
'FIELDS=Felter'#13+
'NUMBER OF HEADER LINES=Antal af Header linier'#13+
'SEPARATOR=Adskiller'#13+
'COMMA=Komma'#13+
'SPACE=Mellemrum'#13+
'TAB=Tab'#13+
'FILE=Fil'#13+
'WEB URL=Web URL'#13+
'LOAD=Hent'#13+
'C LABELS=C Markater'#13+
'R LABELS=R Markater'#13+
'C PEN=C Pen'#13+
'R PEN=R Pen'#13+
'STACK GROUP=Stak Gruppe'#13+
'MULTIPLE BAR=Multiple Bar'#13+
'SIDE=Side'#13+
'SIDE ALL=Sidestil Alle'#13+
'DRAWING MODE=Tegningsmodus'#13+
'WIREFRAME=Trådramme'#13+
'DOTFRAME=Punktramme'#13+
'SMOOTH PALETTE=Jævn palette'#13+
'SIDE BRUSH=Side Pensel'#13+
'ABOUT TEECHART PRO V7.0=Om TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Alle rettigheder forbeholdes'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Select a Chart style'#13+
'DATABASE CHART=Database Chart'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'ALIAS=Alias'#13+
'TABLE=Table'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Udvælg de ønskede felter for diagrammet'#13+
'SELECT A TEXT LABELS FIELD=Vælg et tekstmarkat felt'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'2D=2D'#13+
'CHART PREVIEW=Chart Preview'#13+
'SHOW LEGEND=Show Legend'#13+
'SHOW MARKS=Show Marks'#13+
'< BACK=< Tilbage'#13+
'EXPORT CHART=Eksporter Diagram'#13+
'PICTURE=Billede'#13+
'NATIVE=Medfødt'#13+
'KEEP ASPECT RATIO=Bevar udseendeforholdet'#13+
'INCLUDE SERIES DATA=Inkluder Serie data'#13+
'FILE SIZE=Filstørrelse'#13+
'DELIMITER=Adskiller'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabel'#13+
'EXCEL=Excel'#13+
'COLON=Kolon'#13+
'INCLUDE=Inkluder'#13+
'POINT LABELS=Punkt Markater'#13+
'POINT INDEX=Punkt Indeks'#13+
'HEADER=Header'#13+
'COPY=Kopier'#13+
'SAVE=Gem'#13+
'SEND=Send'#13+
'FUNCTIONS=Funktioner'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Tilføj'#13+
'MULTIPLY=Multiplicer'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=Std.Afvigelse'#13+
'STOCHASTIC=Stokastisk'#13+
'SUBTRACT=Subtraktion'#13+
'SOURCE SERIES=Kilde Serier'#13+
'TEECHART GALLERY=TeeChart Galleri'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduktion'#13+
'COMPRESSION=Kompressionstype'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nærmeste'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Grå'#13+
'GRAY SCALE=Grå Skala'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Kvalitet'#13+
'PERFORMANCE=Udførsel'#13+
'QUALITY=Kvalitet'#13+
'SPEED=Hastighed'#13+
'COMPRESSION LEVEL=Kompressionsgrad'#13+
'CHART TOOLS GALLERY=Diagram Værktøjer Galleri'#13+
'ANNOTATION=Annotation'#13+
'AXIS ARROWS=Akse Pile'#13+
'COLOR BAND=Båndfarve'#13+
'COLOR LINE=Liniefarve'#13+
'DRAG MARKS=Træk mærker'#13+
'MARK TIPS=Mærke Tips'#13+
'NEAREST POINT=Nærmeste Punkt'#13+
'ROTATE=Roter'#13+

// 6.0

'BEVEL SIZE=Facetkant.'#13+
'DELETE ROW=Slet række'#13+
'VOLUME SERIES=Volumen serier'#13+
'SINGLE=Enkel'#13+
'REMOVE CUSTOM COLORS=Fjern brugervalgte farver'#13+
'USE PALETTE MINIMUM=Brug palette minimum'#13+
'AXIS MAXIMUM=Akse maximum'#13+
'AXIS CENTER=Akse center'#13+
'AXIS MINIMUM=Akse minimum'#13+
'DAILY (NONE)=Dagligt (ingen)'#13+
'WEEKLY=Ugentligt'#13+
'MONTHLY=Månedesvis'#13+
'BI-MONTHLY=Hver anden måned'#13+
'QUARTERLY=Kvatalsvis'#13+
'YEARLY=Årligt'#13+
'DATETIME PERIOD=Datotid periode'#13+
'CASE SENSITIVE=Skeln store/små bogstaver'#13+
'DRAG STYLE=Trækkestil'#13+
'SQUARED=Firkantet'#13+
'GRID 3D SERIES=Raster 3d serier'#13+
'DARK BORDER=Mørk kant'#13+
'PIE SERIES=Cirkel serier'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Eksplodere'#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Diagram fra template (*.tee fil)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Åbn TeeChart templatefil fra'#13+
'BINARY=Binary'#13+
'VOLUME OSCILLATOR=Volume oscillator'#13+
'PIE SLICES=Cirkel dele'#13+
'ARROW WIDTH=Pil bredde'#13+
'ARROW HEIGHT=Pil højde'#13+
'DEFAULT COLOR=Standard farve'#13+
'PERIOD=Periode'#13+
'UP=Op'#13+
'DOWN=Ned'#13+
'SHADOW EDITOR=Skygge editor'#13+
'CALLOUT=Callout'#13+
'TEXT ALIGNMENT=TEKSTOPSTILLING'#13+
'DISTANCE=Afstand'#13+
'ARROW HEAD=Pilehoved'#13+
'POINTER=Pegepind'#13+
'AVAILABLE LANGUAGES=Tilgængelige sprog'#13+
'CHOOSE A LANGUAGE=Vælg et sprog'#13+
'CALCULATE USING=Beregn ved brug'#13+
'EVERY NUMBER OF POINTS=Ethvert antal af punkter'#13+
'EVERY RANGE=Enhver række'#13+
'INCLUDE NULL VALUES=Inkluder nul værdier'#13+
'DATE=Dato'#13+
'ENTER DATE=Angiv dato'#13+
'ENTER TIME=Angiv tid'#13+
'DEVIATION=Afvigelse'#13+
'UPPER=Højere'#13+
'NOTHING=Intet'#13+
'LEFT TRIANGLE=Venstre trekant'#13+
'RIGHT TRIANGLE=Højre trekant'#13+
'SHOW PREVIOUS BUTTON=Vis forgående knap'#13+
'SHOW NEXT BUTTON=Vis næste knap'#13+
'CONSTANT=Konstant'#13+
'SHOW LABELS=Vis labels'#13+
'SHOW COLORS=Vis farver'#13+
'XYZ SERIES=XYZ Serie'#13+
'SHOW X VALUES=Vis X værdier'#13+
'ACCUMULATE=Akumuler'#13+
'STEP=Stigning'#13+
'DRAG REPAINT=Træk gentegning'#13+
'NO LIMIT DRAG=Ingen grænse træk'#13+
'SMOOTH=Glatte ud'#13+
'INTERPOLATE=Interpolere'#13+
'START X=Start X'#13+
'NUM. POINTS=Num. Punkter'#13+
'COLOR EACH LINE=Farvelæg hver linie'#13+
'SORT BY=Sorter efter'#13+
'(NONE)=(ingen)'#13+
'CALCULATION=Beregning'#13+
'GROUP=Gruppe'#13+
'WEIGHT=Vægt'#13+
'EDIT LEGEND=Rediger forklaringer'#13+
'FLAT=Flad'#13+
'DRAW ALL=Tegn alle'#13+
'IGNORE NULLS=Ignorer null-værdier'#13+
'OFFSET=Udgangspunkt'#13+
'LIGHT 0=Lys 0'#13+
'LIGHT 1=Lys 1'#13+
'LIGHT 2=Lys 2'#13+
'DRAW STYLE=Trækstil'#13+
'POINTS=Punkter'#13+
'DEFAULT BORDER=Standard kant'#13+
'SHOW PAGE NUMBER=Vis sidenummer'#13+
'SEPARATION=Adskillelse'#13+
'ROUND BORDER=Rund kant'#13+
'NUMBER OF SAMPLE VALUES=Antal af prøveværdier'#13+
'RESIZE PIXELS TOLERANCE=Omgør pixels tolerance'#13+
'FULL REPAINT=Fuld gentegning'#13+
'END POINT=Slutpunkt'#13+
'BAND 1=Bånd 1'#13+
'BAND 2=Bånd 2'#13+
'TRANSPOSE NOW=Transponere nu'#13+
'PERIOD 1=Periode 1'#13+
'PERIOD 2=Periode 2'#13+
'PERIOD 3=Periode 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Eksp. linie'#13+
'WEIGHTED=Vægtede'#13+
'WEIGHTED BY INDEX=Vægtede efter indeks'#13+
'BOX SIZE=Boks størrelse'#13+
'REVERSAL AMOUNT=Ombytningsandel'#13+
'PERCENTAGE=Procentdel'#13+
'COMPLETE R.M.S.=Fuldstændig r.m.s.'#13+
'BUTTON=Knap'#13+
'START AT MIN. VALUE=Start ved min. værdi'#13+
'EXECUTE !=Udfør !'#13+
'IMAG. SYMBOL=Imag. symbol'#13+
'SELF STACK=Selvstablende'#13+
'SIDE LINES=Sidelinier'#13+
'EXPORT DIALOG=Eksport dialog'#13+
'POINT COLORS=Punkt farver'#13+
'OUTLINE GRADIENT=Konturhældning'#13+
'EXP.TREND=Forv. tendens'#13+
'TREND=Tendens'#13+
'FINANCIAL=Finansiel'#13+
'STATS=Statistik'#13+
'RADIAL=Radiær'#13+
'BALANCE=Balance'#13+
'RADIAL OFFSET=Radiær udgangspunkt'#13+
'DRAG POINT=Træk punkt'#13+
'COVER=Cover'#13+
'VALUE SOURCE=Værdikilde'
;
  end;
end;

Procedure TeeSetDanish;
begin
  TeeCreateDanish;
  TeeLanguage:=TeeDanishLanguage;
  TeeDanishConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeDanishLanguage);
end.
