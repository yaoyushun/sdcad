unit TeeNorwegian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeNorwegianLanguage:TStringList=nil;

Procedure TeeSetNorwegian;
Procedure TeeCreateNorwegian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeNorwegianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 David Berneda';
  TeeMsg_LegendFirstValue   :='Første Legende verdi må være > 0';
  TeeMsg_LegendColorWidth   :='Legende fargebredde må være > 0%';
  TeeMsg_SeriesSetDataSource:='Ingen ParentDiagram til å godkjenne DataKilden';
  TeeMsg_SeriesInvDataSource:='Ingen gyldig DataKilde: %s';
  TeeMsg_FillSample         :='Utfyllingsverdiens numeriske verdier må være > 0';
  TeeMsg_AxisLogDateTime    :='DatoTid akse kan ikke være logaritmisk';
  TeeMsg_AxisLogNotPositive :='Logaritmisk akse Min og Maks verdi må være >= 0';
  TeeMsg_AxisLabelSep       :='Merke atskillelse % må være større enn 0';
  TeeMsg_AxisIncrementNeg   :='Akse økning må være >= 0';
  TeeMsg_AxisMinMax         :='Akse minimum verdi må være <= maksimum';
  TeeMsg_AxisMaxMin         :='Akse maksimum verdi må være >= minimum';
  TeeMsg_AxisLogBase        :='Akse Logaritme Base må være >= 2';
  TeeMsg_MaxPointsPerPage   :='MaksPunkterPerSide må være >= 0';
  TeeMsg_3dPercent          :='3D effektprosent må være mellom %d og %d';
  TeeMsg_CircularSeries     :='Sammenhengende serie avhengighet er ikke tillat';
  TeeMsg_WarningHiColor     :='16k farger eller mer er påkrevet for å oppnå bedre utseende';

  TeeMsg_DefaultPercentOf   :='%s av %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'av %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Akse Tittel';
  TeeMsg_AxisLabels         :='Akse Merke';
  TeeMsg_RefreshInterval    :='Oppdaterings intervallet må være mellom 0 og 60';
  TeeMsg_SeriesParentNoSelf :='Serier.ParentDiagram er ikke meg selv!';
  TeeMsg_GalleryLine        :='Linje';
  TeeMsg_GalleryPoint       :='Punkt';
  TeeMsg_GalleryArea        :='Areal';
  TeeMsg_GalleryBar         :='Bar';
  TeeMsg_GalleryHorizBar    :='Horis. Bar';
  TeeMsg_Stack              :='Stabel';
  TeeMsg_GalleryPie         :='Pie';
  TeeMsg_GalleryCircled     :='Sirkulær';
  TeeMsg_GalleryFastLine    :='Fast Linje';
  TeeMsg_GalleryHorizLine   :='Horis Linje';

  TeeMsg_PieSample1         :='Biler';
  TeeMsg_PieSample2         :='Telefoner';
  TeeMsg_PieSample3         :='Bord';
  TeeMsg_PieSample4         :='Monitorer';
  TeeMsg_PieSample5         :='Lamper';
  TeeMsg_PieSample6         :='Tastaturer';
  TeeMsg_PieSample7         :='Sykler';
  TeeMsg_PieSample8         :='Stoler';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Rediger %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Utvidet';
  TeeMsg_GalleryFunctions   :='Funksjoner';

  TeeMsg_EditChart          :='Re&diger Diagram...';
  TeeMsg_PrintPreview       :='Utskriv Vis&utskrift...';
  TeeMsg_ExportChart        :='E&ksporter Diagram...';
  TeeMsg_CustomAxes         :='Brukervalgte Akser...';

  TeeMsg_InvalidEditorClass :='%s: Ugyldig Editor Klasse: %s';
  TeeMsg_MissingEditorClass :='%s: har ingen Editor Dialog';

  TeeMsg_GalleryArrow       :='Pil';

  TeeMsg_ExpFinish          :='A&vslutt';
  TeeMsg_ExpNext            :='&Neste >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Utvikling';
  TeeMsg_GanttSample4       :='Salg';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Produksjon';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Ny Version';
  TeeMsg_GanttSample10      :='Bank';

  TeeMsg_ChangeSeriesTitle  :='Skift Serietittel';
  TeeMsg_NewSeriesTitle     :='Ny Serietittel:';
  TeeMsg_DateTime           :='DatoTid';
  TeeMsg_TopAxis            :='Topp Akse';
  TeeMsg_BottomAxis         :='Bunn Akse';
  TeeMsg_LeftAxis           :='Venstre Akse';
  TeeMsg_RightAxis          :='Høyre Akse';

  TeeMsg_SureToDelete       :='Slett %s ?';
  TeeMsg_DateTimeFormat     :='DatoTid For&mat:';
  TeeMsg_Default            :='Standard';
  TeeMsg_ValuesFormat       :='Verdi For&mat:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Ønsket %s Forhøyning';

  TeeMsg_IncorrectMaxMinValue:='Ugyldig verdi. Begrunnelse: %s';
  TeeMsg_EnterDateTime      :='Angi [Antall Dager] [tt:mm:ss]';

  TeeMsg_SureToApply        :='Tilføy endringer ?';
  TeeMsg_SelectedSeries     :='(Valgte Serier)';
  TeeMsg_RefreshData        :='Genoppf&risk Data';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='440';
  TeeMsg_FunctionAdd        :='Tilføy';
  TeeMsg_FunctionSubtract   :='Subtraksjon';
  TeeMsg_FunctionMultiply   :='Multipliser';
  TeeMsg_FunctionDivide     :='Divisjon';
  TeeMsg_FunctionHigh       :='Høy';
  TeeMsg_FunctionLow        :='Lav';
  TeeMsg_FunctionAverage    :='Gjennomsnitt';

  TeeMsg_GalleryShape       :='Former';
  TeeMsg_GalleryBubble      :='Boble';
  TeeMsg_FunctionNone       :='Kopi';

  TeeMsg_None               :='(ingen)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer størrelse må være større enn null';
  TeeMsg_About              :='O&m TeeChart...';

  tcAdditional              :='Ekstra';
  tcDControls               :='Data Kontroller';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='DataSett';
  TeeMsg_AskDataSet         :='&DataSett:';

  TeeMsg_SingleRecord       :='Enkelt Post';
  TeeMsg_AskDataSource      :='&Datakilde:';

  TeeMsg_Summary            :='Sammendrag';

  TeeMsg_FunctionPeriod     :='Funksjons Periode må være >= 0';

  TeeMsg_WizardTab          :='Business';

  TeeMsg_ClearImage         :='&Rens';
  TeeMsg_BrowseImage        :='Gjen&nomse...';

  TeeMsg_WizardSureToClose  :='Er du sikker på at du vil lukke TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Feltet %s eksisterer ikke';

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
  TeeMsg_ValuesGanttEnd     :='Slutt';
  TeeMsg_ValuesGanttNextTask:='NesteOppgave';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='SluttX';
  TeeMsg_ValuesArrowEndY    :='SluttY';
  TeeMsg_Legend             :='Ledetekst';
  TeeMsg_Title              :='Tittel';
  TeeMsg_Foot               :='Bunn';
  TeeMsg_Period		    :='Periode';
  TeeMsg_PeriodRange        :='Periode område';
  TeeMsg_CalcPeriod         :='Beregn %s hver:';
  TeeMsg_SmallDotsPen       :='Små punkter';

  TeeMsg_InvalidTeeFile     :='Ugyldig Diagram i *.'+TeeMsg_TeeExtension+' filen';
  TeeMsg_WrongTeeFileFormat :='Feil *.'+TeeMsg_TeeExtension+' fil-format';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Diagram Akse';
  TeeMsg_ChartAxesCategoryDesc   :='Diagram Akse egenskaper og handlinger';
  TeeMsg_ChartWallsCategoryName  :='Diagram vegg';
  TeeMsg_ChartWallsCategoryDesc  :='Diagram vegg egenskaper og handlinger';
  TeeMsg_ChartTitlesCategoryName :='Diagram Titler';
  TeeMsg_ChartTitlesCategoryDesc :='Diagram Titler egenskaper og handlinger';
  TeeMsg_Chart3DCategoryName     :='Diagram 3D';
  TeeMsg_Chart3DCategoryDesc     :='Diagram 3D egenskaper og handlinger';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Brukervalg ';
  TeeMsg_Series                 :='Serier';
  TeeMsg_SeriesList             :='Serier...';

  TeeMsg_PageOfPages            :='Side %d av %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Første';
  TeeMsg_Prior  :='Foregående';
  TeeMsg_Next   :='Neste';
  TeeMsg_Last   :='Siste';
  TeeMsg_Insert :='Innsett';
  TeeMsg_Delete :='Slett';
  TeeMsg_Edit   :='Rediger';
  TeeMsg_Post   :='Lagre';
  TeeMsg_Cancel :='Avbryt';

  TeeMsg_All    :='(alle)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='som &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='som &Metafil';
  TeeMsg_EMFFilter    :='Udvidet Metafil (*.emf)|*.emf|Metafil (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Panel egenskaper er ikke satt i Eksport format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Ingen Kant';
  TeeMsg_Dotted    :='Prikkete';
  TeeMsg_Colors    :='Farger';
  TeeMsg_Filled    :='Utfylt';
  TeeMsg_Marks     :='Merker';
  TeeMsg_Stairs    :='Trapper';
  TeeMsg_Points    :='Punkter';
  TeeMsg_Height    :='Høyde';
  TeeMsg_Hollow    :='Hul';
  TeeMsg_Point2D   :='2D Punkter';
  TeeMsg_Triangle  :='Trekant';
  TeeMsg_Star      :='Stjerner';
  TeeMsg_Circle    :='Sirkel';
  TeeMsg_DownTri   :='Nedvendt Tri.';
  TeeMsg_Cross     :='Kryss';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Ingen Linjer';
  TeeMsg_Stack100  :='Stablet 100%';
  TeeMsg_Pyramid   :='Pyramide';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Inv. Pyramide';
  TeeMsg_Sides     :='Sider';
  TeeMsg_SideAll   :='Sidestil Alle';
  TeeMsg_Patterns  :='Mønstre';
  TeeMsg_Exploded  :='Utfold';
  TeeMsg_Shadow    :='Skygge';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Rektangel';
  TeeMsg_VertLine  :='Vert.Linje';
  TeeMsg_HorizLine :='Horis.Linje';
  TeeMsg_Line      :='Linje';
  TeeMsg_Cube      :='Kube';
  TeeMsg_DiagCross :='Diag.Kryss';

  TeeMsg_CanNotFindTempPath    :='Kan ikke finne Temp mappen';
  TeeMsg_CanNotCreateTempChart :='Kan ikke lage Temp fil';
  TeeMsg_CanNotEmailChart      :='Kan ikke eposte TeeChart. Mapi Feil: %d';

  TeeMsg_SeriesDelete :='Slett Serier: VerdiIndeks %d utenfor lovlig grense (0 til %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Språk...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Lys';
  TeeMsg_GalleryVolume      :='Volum';
  TeeMsg_GallerySurface     :='Overflate';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D Punkter';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Smultring';
  TeeMsg_GalleryCursor      :='Markør';
  TeeMsg_GalleryBar3D       :='Bar 3D';
  TeeMsg_GalleryBigCandle   :='Stort Lys';
  TeeMsg_GalleryLinePoint   :='Linje Punkter';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Vannfall';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Klokke';
  TeeMsg_GalleryColorGrid   :='FargeGitter';
  TeeMsg_GalleryBoxPlot     :='BoksPlott';
  TeeMsg_GalleryHorizBoxPlot:='Horis.BoksPlott';
  TeeMsg_GalleryBarJoin     :='Bar Sammensetning';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramide';
  TeeMsg_GalleryMap         :='Kart';

  TeeMsg_PolyDegreeRange    :='Polynomial grad må være mellom 1 og 20';
  TeeMsg_AnswerVectorIndex   :='Svar Vektor indeks må være mellom 1 og %d';
  TeeMsg_FittingError        :='Kan ikke fortsette med tilpassning';
  TeeMsg_PeriodRange         :='Perioden må være >= 0';
  TeeMsg_ExpAverageWeight    :='ExpGennomsnitt vekt må være mellom 0 og 1';
  TeeMsg_GalleryErrorBar     :='Feil Bar';
  TeeMsg_GalleryError        :='Feil';
  TeeMsg_GalleryHighLow      :='Høy-Lav';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp. Gjenms.';
  TeeMsg_FunctionMovingAverage:='Flytende Gjenms.';
  TeeMsg_FunctionExpMovAve   :='Exp.Flyt.Gjenms.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Kurv Tilpassning';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulativ';
  TeeMsg_FunctionStdDeviation:='Std.Avvik';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stokastisk';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Teller';
  TeeMsg_LoadChart           :='Åpne TeeChart...';
  TeeMsg_SaveChart           :='Lagre TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro filer';

  TeeMsg_GallerySamples      :='Andre';
  TeeMsg_GalleryStats        :='Statistikk';

  TeeMsg_CannotFindEditor    :='Kan ikke finne Serieeditor Fra: %s';


  TeeMsg_CannotLoadChartFromURL:='Feilkode: %d laster ned Diagram fra URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Feilkode: %d laster ned Seriedata fra URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Dato';
  TeeMsg_ValuesOpen          :='Åpne';
  TeeMsg_ValuesHigh          :='Høy';
  TeeMsg_ValuesLow           :='Lav';
  TeeMsg_ValuesClose         :='Lukk';
  TeeMsg_ValuesOffset        :='Utgangspunkt';
  TeeMsg_ValuesStdError      :='StdFeil';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Antallet av Bezier punkter må være > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Utskriv';
  TeeCommanMsg_Copy     :='Kopier';
  TeeCommanMsg_Save     :='Lagre';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotasjon: %d° Elevasjon: %d°';
  TeeCommanMsg_Rotate   :='Rotèr';

  TeeCommanMsg_Moving   :='Horis.Utgangspkt.: %d Vert.Utgangspkt.: %d';
  TeeCommanMsg_Move     :='Flytt';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Dybde';

  TeeCommanMsg_Chart    :='Diagram';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Trekk i %s for å Rotere';
  TeeCommanMsg_MoveLabel  :='Trekk i %s for å Flytte';
  TeeCommanMsg_ZoomLabel  :='Trekk i %s for å Zoome';
  TeeCommanMsg_DepthLabel :='Trekk i %s for å endre 3D størrelsen';

  TeeCommanMsg_NormalLabel:='Trekk i venstre knapp for å Zoome, høyre for å Scrolle';
  TeeCommanMsg_NormalPieLabel:='Trekk i et Pie element for å utvide det';

  TeeCommanMsg_PieExploding :='Element: %d Utvidet: %d %%';

  TeeMsg_TriSurfaceLess:='Antallet av punkter må være >= 4';
  TeeMsg_TriSurfaceAllColinear:='Alle colinære data punkter';
  TeeMsg_TriSurfaceSimilar:='Identiske punkter - Kan ikke utføre';
  TeeMsg_GalleryTriSurface:='Trekant overf.';

  TeeMsg_AllSeries :='Alle Serier';
  TeeMsg_Edit      :='Rediger';

  TeeMsg_GalleryFinancial    :='Finansiell';

  TeeMsg_CursorTool    :='Markør';
  TeeMsg_DragMarksTool :='Trekk merker';
  TeeMsg_AxisArrowTool :='Akse Pil';
  TeeMsg_DrawLineTool  :='Tegn Linje';
  TeeMsg_NearestTool   :='Nærmeste Punkt';
  TeeMsg_ColorBandTool :='Båndfarge';
  TeeMsg_ColorLineTool :='Linjefarge';
  TeeMsg_RotateTool    :='Roter';
  TeeMsg_ImageTool     :='Bilde';
  TeeMsg_MarksTipTool  :='Merk Tips';

  TeeMsg_CantDeleteAncestor  :='Kan ikke slette ancestor';

  TeeMsg_Load	         :='Hent...';
  TeeMsg_NoSeriesSelected:='Ingen Serier er valgt';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Diagram';
  TeeMsg_CategorySeriesActions :='Diagram Serier';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Skift 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktiv';
  TeeMsg_ActionSeriesActiveHint :='Vis / Gjem Serier';
  TeeMsg_ActionEditHint         :='Rediger Diagram';
  TeeMsg_ActionEdit             :='&Rediger...';
  TeeMsg_ActionCopyHint         :='Kopier til Utskriftholder';
  TeeMsg_ActionCopy             :='&Kopier';
  TeeMsg_ActionPrintHint        :='Utskriv Vis Utskrift av Diagram';
  TeeMsg_ActionPrint            :='&Utskriv...';
  TeeMsg_ActionAxesHint         :='Vis / Gjem Akser';
  TeeMsg_ActionAxes             :='&Akser';
  TeeMsg_ActionGridsHint        :='Vis / Gjem Gitter';
  TeeMsg_ActionGrids            :='&Gitter';
  TeeMsg_ActionLegendHint       :='Vis / Gjem Ledetekst';
  TeeMsg_ActionLegend           :='&Ledetekst';
  TeeMsg_ActionSeriesEditHint   :='Rediger Serier';
  TeeMsg_ActionSeriesMarksHint  :='Vis / Gjem Series Marks';
  TeeMsg_ActionSeriesMarks      :='&Merke';
  TeeMsg_ActionSaveHint         :='Gjem Diagram';
  TeeMsg_ActionSave             :='&Gjem...';

  TeeMsg_CandleBar              :='Bar';
  TeeMsg_CandleNoOpen           :='Ingen Åpne';
  TeeMsg_CandleNoClose          :='Ingen Lukket';
  TeeMsg_NoLines                :='Ingen Linjer';
  TeeMsg_NoHigh                 :='Ingen Høy';
  TeeMsg_NoLow                  :='Ingen Lav';
  TeeMsg_ColorRange             :='Fargeområde';
  TeeMsg_WireFrame              :='Tråd ramme';
  TeeMsg_DotFrame               :='Prikk ramme';
  TeeMsg_Positions              :='Posisjoner';
  TeeMsg_NoGrid                 :='Ingen Gitter';
  TeeMsg_NoPoint                :='Ingen Punkter';
  TeeMsg_NoLine                 :='Ingen Linje';
  TeeMsg_Labels                 :='Merker';
  TeeMsg_NoCircle               :='Ingen Sirkel';
  TeeMsg_Lines                  :='Linjer';
  TeeMsg_Border                 :='Kant';

  TeeMsg_SmithResistance      :='Motstand';
  TeeMsg_SmithReactance       :='Reaktans';

  TeeMsg_Column  :='Kolonne';

  { 5.02 }
  TeeMsg_Origin               :='Origo';
  TeeMsg_Transparency         :='Gjennomsiktig';
  TeeMsg_Box		      :='Boks';
  TeeMsg_ExtrOut	      :='ExtrUt';
  TeeMsg_MildOut	      :='MildUt';
  TeeMsg_PageNumber	      :='Side nummer';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='som &JPEG';
  TeeMsg_JPEGFilter    :='Filer JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='som &GIF';
  TeeMsg_GIFFilter     :='Filer GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='som &PNG';
  TeeMsg_PNGFilter     :='Filer PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='som PC&X';
  TeeMsg_PCXFilter     :='Filer PCX (*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  // 6.0
// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='som &PDF';
  TeeMsg_PDFFilter        :='PDF filer (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='som PostScript';
  TeeMsg_PSFilter         :='PostScript filer (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horisontal'#13'Område';
  TeeMsg_SelfStack        :='Selv Stable';
  TeeMsg_DarkPen          :='Mørk Grense';
  TeeMsg_SelectFolder     :='Velg database mappe';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Kobling:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Glatt';
  TeeMsg_FunctionCross        :='Kryss Punkt';
  TeeMsg_GridTranspose        :='3D Gitter Omforming';
  TeeMsg_FunctionCompress     :='Kompresjon';
  TeeMsg_ExtraLegendTool      :='Ekstra Legende';
  TeeMsg_FunctionCLV          :='Lukk Plass'#13'Verdi';
  TeeMsg_FunctionOBV          :='På Balanse'#13'Volum';
  TeeMsg_FunctionCCI          :='Vare'#13'Kanal Indeks';
  TeeMsg_FunctionPVO          :='Volum'#13'Oscilloskop';
  TeeMsg_SeriesAnimTool       :='Serie Animasjon';
  TeeMsg_GalleryPointFigure   :='Punkt & Figur';
  TeeMsg_Up                   :='Opp';
  TeeMsg_Down                 :='Ned';
  TeeMsg_GanttTool            :='Gantt Slepe';
  TeeMsg_XMLFile              :='XML fil';
  TeeMsg_GridBandTool         :='Gitter bånd verktØy';
  TeeMsg_FunctionPerf         :='Ytelse';
  TeeMsg_GalleryGauge         :='Måler';
  TeeMsg_GalleryGauges        :='Målere';
  TeeMsg_ValuesVectorEndZ     :='EndeZ';
  TeeMsg_GalleryVector3D      :='Vektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Tårn';
  TeeMsg_SingleColor          :='Ensformig Farge';
  TeeMsg_Cover                :='Omslag';
  TeeMsg_Cone                 :='Kjegle';
  TeeMsg_PieTool              :='Pai Stykke';
end;

Procedure TeeCreateNorwegian;
begin
  if not Assigned(TeeNorwegianLanguage) then
  begin
    TeeNorwegianLanguage:=TStringList.Create;
    TeeNorwegianLanguage.Text:=

'GRADIENT EDITOR=Hellingsgrad editor'#13+
'GRADIENT=Hellingsgrad'#13+
'DIRECTION=Retning'#13+
'VISIBLE=Synlig'#13+
'TOP BOTTOM=Topp Bunn'#13+
'BOTTOM TOP=Bunn Top'#13+
'LEFT RIGHT=Venstre Høyre'#13+
'RIGHT LEFT=Høyre Venstre'#13+
'FROM CENTER=Fra Midtpunkt'#13+
'FROM TOP LEFT=Fra Topp Venstre'#13+
'FROM BOTTOM LEFT=Fra Bunn Venstre'#13+
'OK=OK'#13+
'CANCEL=Avbryt'#13+
'COLORS=Farger'#13+
'START=Start'#13+
'MIDDLE=Midtpunkt'#13+
'END=Slutt'#13+
'SWAP=Bytt'#13+
'NO MIDDLE=Ingen Midtpunkt'#13+
'TEEFONT EDITOR=TeeSkrifttype Editor'#13+
'INTER-CHAR SPACING=Mellom-tegn avstand'#13+
'FONT=Skrifttype'#13+
'SHADOW=Skygge'#13+
'HORIZ. SIZE=Horis. Str.'#13+
'VERT. SIZE=Vert. Str.'#13+
'COLOR=Farge'#13+
'OUTLINE=Skisse'#13+
'OPTIONS=Alternativer'#13+
'FORMAT=Formatering'#13+
'TEXT=Tekst'#13+
'POSITION=Posisjon'#13+
'LEFT=Venstre'#13+
'TOP=Topp'#13+
'AUTO=Auto'#13+
'CUSTOM=Brukervalg'#13+
'LEFT TOP=Venstre topp'#13+
'LEFT BOTTOM=Venstre bunn'#13+
'RIGHT TOP=Høyre topp'#13+
'RIGHT BOTTOM=Høyre bunn'#13+
'MULTIPLE AREAS=Flerfoldige Arealer'#13+
'NONE=Ingen'#13+
'STACKED=Stablet'#13+
'STACKED 100%=Stablet 100%'#13+
'AREA=Område'#13+
'PATTERN=Mønster'#13+
'STAIRS=Trapper'#13+
'SOLID=Solid'#13+
'CLEAR=Klar'#13+
'HORIZONTAL=Horisontal'#13+
'VERTICAL=Vertikal'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Kryss'#13+
'DIAG.CROSS=Diag.Kryss'#13+
'AREA LINES=Område Linjer'#13+
'BORDER=Grense'#13+
'INVERTED=Invertert'#13+
'INVERTED SCROLL=Invertert Rull'#13+
'COLOR EACH=Fargelegg Alle'#13+
'ORIGIN=Origo'#13+
'USE ORIGIN=Bruk Origo'#13+
'WIDTH=Bredde'#13+
'HEIGHT=Høyde'#13+
'AXIS=Akse'#13+
'LENGTH=Lengde'#13+
'SCROLL=Rull'#13+
'BOTH=Begge'#13+
'AXIS INCREMENT=Akse økning'#13+
'INCREMENT=Økning'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Et Millisekund'#13+
'ONE SECOND=Et Sekund'#13+
'FIVE SECONDS=Fem Sekunder'#13+
'TEN SECONDS=Ti Sekunder'#13+
'FIFTEEN SECONDS=Femten Sekunder'#13+
'THIRTY SECONDS=Tretten Sekunder'#13+
'ONE MINUTE=Et Minutt'#13+
'FIVE MINUTES=Fem Minutter'#13+
'TEN MINUTES=Ti Minuter'#13+
'FIFTEEN MINUTES=Femten Minutter'#13+
'THIRTY MINUTES=Tretten Minutter'#13+
'ONE HOUR=En Time'#13+
'TWO HOURS=To Timer'#13+
'SIX HOURS=Seks Timer'#13+
'TWELVE HOURS=Tolv Timer'#13+
'ONE DAY=En Dag'#13+
'TWO DAYS=To Dager'#13+
'THREE DAYS=Tre Dager'#13+
'ONE WEEK=En Uke'#13+
'HALF MONTH=Halv Måned'#13+
'ONE MONTH=En Måned'#13+
'TWO MONTHS=To Måneder'#13+
'THREE MONTHS=Tre Måneder'#13+
'FOUR MONTHS=Fire Måneder'#13+
'SIX MONTHS=Seks Måneder'#13+
'ONE YEAR=Et År'#13+
'EXACT DATE TIME=Eksakt Dato Tid'#13+
'AXIS MAXIMUM AND MINIMUM=Akse Maximum og Minimum'#13+
'VALUE=Verdi'#13+
'TIME=Tid'#13+
'LEFT AXIS=Venstre Akse'#13+
'RIGHT AXIS=Høyre Akse'#13+
'TOP AXIS=Topp Akse'#13+
'BOTTOM AXIS=Bunn Akse'#13+
'% BAR WIDTH=% Bar Bredde'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% Bar Forskyvning'#13+
'RECTANGLE=Rektangel'#13+
'PYRAMID=Pyramide'#13+
'INVERT. PYRAMID=Invert. Pyramide'#13+
'CYLINDER=Sylinder'#13+
'ELLIPSE=Ellipse'#13+
'ARROW=Pil'#13+
'RECT. GRADIENT=Rekt. Hellingsgrad'#13+
'CONE=Kjegle'#13+
'DARK BAR 3D SIDES=Mørk Bar 3D Sider'#13+
'BAR SIDE MARGINS=Bar Side Marginer'#13+
'AUTO MARK POSITION=Auto Merk Posisjon'#13+
'JOIN=Forbind'#13+
'DATASET=Datasett'#13+
'APPLY=Bruk'#13+
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
'WHISKER=Strøk'#13+
'PATTERN COLOR EDITOR=Mønster Farge Editor'#13+
'IMAGE=Bilde'#13+
'BACK DIAGONAL=Diagonal tilbake'#13+
'DIAGONAL CROSS=Diagonal Kryss'#13+
'FILL 80%=Udfyll 80%'#13+
'FILL 60%=Udfyll 60%'#13+
'FILL 40%=Udfyll 40%'#13+
'FILL 20%=Udfyll 20%'#13+
'FILL 10%=Udfyll 10%'#13+
'ZIG ZAG=Sikksakk'#13+
'VERTICAL SMALL=Vertikal liten'#13+
'HORIZ. SMALL=Horis. liten'#13+
'DIAG. SMALL=Diag. liten'#13+
'BACK DIAG. SMALL=Diag. liten tilbake'#13+
'CROSS SMALL=Kryss liten'#13+
'DIAG. CROSS SMALL=Diag. Kryss liten'#13+
'DAYS=Dager'#13+
'WEEKDAYS=Ukedager'#13+
'TODAY=I dag'#13+
'SUNDAY=Søndag'#13+
'TRAILING=Forfølgende'#13+
'MONTHS=Måneder'#13+
'LINES=Linjer'#13+
'SHOW WEEKDAYS=Vis Ukedager'#13+
'UPPERCASE=STORE TEGN'#13+
'TRAILING DAYS=Forfølgende dager'#13+
'SHOW TODAY=Vis i dag'#13+
'SHOW MONTHS=Vis Måneder'#13+
'CANDLE WIDTH=Lys Bredde'#13+
'STICK=Stav'#13+
'BAR=Bar'#13+
'OPEN CLOSE=Åpne Lukk'#13+
'UP CLOSE=Lukk oppe'#13+
'DOWN CLOSE=Lukk nede'#13+
'SHOW OPEN=Vis Åpen'#13+
'SHOW CLOSE=Vis Lukket'#13+
'DRAW 3D=Tegn 3D'#13+
'DARK 3D=Mørk 3D'#13+
'EDITING=Rediger'#13+
'CHART=Diagram'#13+
'SERIES=Serier'#13+
'DATA=Data'#13+
'TOOLS=Verktøy'#13+
'EXPORT=Eksport'#13+
'PRINT=Utskrift'#13+
'GENERAL=Generelt'#13+
'TITLES=Titler'#13+
'LEGEND=Ledetekster'#13+
'PANEL=Paneler'#13+
'PAGING=Side'#13+
'WALLS=Vegger'#13+
'3D=3D'#13+
'ADD=Tilføy'#13+
'DELETE=Slett'#13+
'TITLE=Tittel'#13+
'CLONE=Klone'#13+
'CHANGE=Skift'#13+
'HELP=Hjelp'#13+
'CLOSE=Lukk'#13+
'TEECHART PRINT PREVIEW=TeeChart Vis Utskrift'#13+
'PRINTER=Printer'#13+
'SETUP=Egenskaper'#13+
'ORIENTATION=Papirretning'#13+
'PORTRAIT=Portrett'#13+
'LANDSCAPE=Landskap'#13+
'MARGINS (%)=Marginer (%)'#13+
'DETAIL=Detaljer'#13+
'MORE=Mere'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Tilbakestill Marginer'#13+
'VIEW MARGINS=Vis Marginer'#13+
'PROPORTIONAL=Proporsjonal'#13+
'CIRCLE=Sirkel'#13+
'VERTICAL LINE=Vertikal Linje'#13+
'HORIZ. LINE=Horis. Linje'#13+
'TRIANGLE=Trekant'#13+
'INVERT. TRIANGLE=Invert. Trekant'#13+
'LINE=Linje'#13+
'DIAMOND=Diamant'#13+
'CUBE=Kube'#13+
'STAR=Stjerne'#13+
'TRANSPARENT=Gjennomsik.'#13+
'HORIZ. ALIGNMENT=Horis. Oppstilling'#13+
'CENTER=Senter'#13+
'RIGHT=Høyre'#13+
'ROUND RECTANGLE=Avrund Rektangel'#13+
'ALIGNMENT=Oppstilling'#13+
'BOTTOM=Bunn'#13+
'UNITS=Enheter'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Akse utgangspunkt'#13+
'ROTATION=Rotasjon'#13+
'CIRCLED=Sirkulær'#13+
'3 DIMENSIONS=3 Dimensjoner'#13+
'RADIUS=Radius'#13+
'ANGLE INCREMENT=Vinkel Økning'#13+
'RADIUS INCREMENT=Radius Økning'#13+
'CLOSE CIRCLE=Lukk Sirkel'#13+
'PEN=Penn'#13+
'LABELS=Merker'#13+
'ROTATED=Rotert'#13+
'CLOCKWISE=Med urviseren'#13+
'INSIDE=Inni'#13+
'ROMAN=Roman'#13+
'HOURS=Timer'#13+
'MINUTES=Minutter'#13+
'SECONDS=Sekunder'#13+
'START VALUE=Start verdi'#13+
'END VALUE=Slutt verdi'#13+
'TRANSPARENCY=Gjennomsik.'#13+
'DRAW BEHIND=Tegn Bak'#13+
'COLOR MODE=Farge Modus'#13+
'STEPS=Trinn'#13+
'RANGE=Rekkevidde'#13+
'PALETTE=Palette'#13+
'PALE=Blek'#13+
'STRONG=Sterk'#13+
'GRID SIZE=Gitterstørrelse'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Dybde'#13+
'IRREGULAR=Uregelmessig'#13+
'GRID=Gitter'#13+
'ALLOW DRAG=Tillat Trekk'#13+
'VERTICAL POSITION=Vertikal Posisjon'#13+
'LEVELS POSITION=Nivå posisjon'#13+
'LEVELS=Nivåer'#13+
'NUMBER=Nummer'#13+
'LEVEL=Nivå'#13+
'AUTOMATIC=Automatisk'#13+
'SNAP=Snappe'#13+
'FOLLOW MOUSE=Følg mus'#13+
'STACK=Stabel'#13+
'HEIGHT 3D=Høyde 3D'#13+
'LINE MODE=Linje Modus'#13+
'OVERLAP=Overlapp'#13+
'STACK 100%=Stable 100%'#13+
'CLICKABLE=Klikkbar'#13+
'AVAILABLE=Tilgengelig'#13+
'SELECTED=Valgte'#13+
'DATASOURCE=Datakilde'#13+
'GROUP BY=Gruppert av'#13+
'CALC=Beregn'#13+
'OF=av'#13+
'SUM=Sum'#13+
'COUNT=Antall'#13+
'HIGH=Høy'#13+
'LOW=Lav'#13+
'AVG=Gjennomsnitt'#13+
'HOUR=Time'#13+
'DAY=Dag'#13+
'WEEK=Uke'#13+
'WEEKDAY=Ukedag'#13+
'MONTH=Måned'#13+
'QUARTER=Kvartal'#13+
'YEAR=År'#13+
'HOLE %=Hull %'#13+
'RESET POSITIONS=Tilbakestill posisjoner'#13+
'MOUSE BUTTON=Museknapp'#13+
'ENABLE DRAWING=Aktiver tegning'#13+
'ENABLE SELECT=Aktiver seleksjon'#13+
'ENHANCED=Utvidet'#13+
'ERROR WIDTH=Feil Bredde'#13+
'WIDTH UNITS=Breddeenhet'#13+
'PERCENT=Prosent'#13+
'LEFT AND RIGHT=Venstre og Høyre'#13+
'TOP AND BOTTOM=Topp og Bunn'#13+
'BORDER EDITOR=Kant Editor'#13+
'DASH=Strek'#13+
'DOT=Prikk'#13+
'DASH DOT=Strek Prikk'#13+
'DASH DOT DOT=Strek Prikk Prikk'#13+
'CALCULATE EVERY=Beregn hver'#13+
'ALL POINTS=Alle punkter'#13+
'NUMBER OF POINTS=Antall av punkter'#13+
'RANGE OF VALUES=Rekke av verdier'#13+
'FIRST=Først'#13+
'LAST=Sist'#13+
'TEEPREVIEW EDITOR=TeePreview Editor'#13+
'ALLOW MOVE=Tillat flytning'#13+
'ALLOW RESIZE=Tillat endring i str.'#13+
'DRAG IMAGE=Trekk Bilde'#13+
'AS BITMAP=Som Bitmap'#13+
'SHOW IMAGE=Vis Bilde'#13+
'MARGINS=Marginer'#13+
'SIZE=Str.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Elevasjon'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horis. Forskyvning'#13+
'VERT. OFFSET=Vert. Forskyvning'#13+
'PERSPECTIVE=Perspektiv'#13+
'ANGLE=Vinkel'#13+
'ORTHOGONAL=Rettvinklet'#13+
'ZOOM TEXT=Zoom Tekst'#13+
'SCALES=Målestokk'#13+
'TICKS=Tikk'#13+
'MINOR=Mindre'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(maks)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Ønsket Økning'#13+
'(INCREMENT)=(økning)'#13+
'LOG BASE=Log Base'#13+
'LOGARITHMIC=Logaritmisk'#13+
'MIN. SEPARATION %=Min. Separasjon %'#13+
'MULTI-LINE=Multi-linje'#13+
'LABEL ON AXIS=Merker På Aksene'#13+
'ROUND FIRST=Rund Først'#13+
'MARK=Merke'#13+
'LABELS FORMAT=Merke Format'#13+
'EXPONENTIAL=Eksponensielt'#13+
'DEFAULT ALIGNMENT=Standard oppstilling'#13+
'LEN=Lengde'#13+
'INNER=Innvendig'#13+
'AT LABELS ONLY=Kun ved merker'#13+
'CENTERED=Sentrert'#13+
'POSITION %=Posisjon %'#13+
'START %=Start %'#13+
'END %=Slutt %'#13+
'OTHER SIDE=Annen side'#13+
'AXES=Akse'#13+
'BEHIND=Bakvei'#13+
'CLIP POINTS=Skjæremerker'#13+
'PRINT PREVIEW=Vis Utskrift'#13+
'MINIMUM PIXELS=Minimum pixels'#13+
'ALLOW=Tillat'#13+
'ANIMATED=Animerende'#13+
'ALLOW SCROLL=Tillat Rull'#13+
'TEEOPENGL EDITOR=TeeOpenGL Editor'#13+
'AMBIENT LIGHT=Omsluttende Lys'#13+
'SHININESS=Skinnbarhet'#13+
'FONT 3D DEPTH=Skrifttype 3D Dybde'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Skrifttype Kontur'#13+
'SMOOTH SHADING=Glatt skygge'#13+
'LIGHT=Lys'#13+
'Y=Y'#13+
'INTENSITY=Intensitet'#13+
'BEVEL=Skråkant'#13+
'FRAME=Ramme'#13+
'ROUND FRAME=Runde Rammer'#13+
'LOWERED=Senket'#13+
'RAISED=Hevet'#13+
'SYMBOLS=Symboler'#13+
'TEXT STYLE=Tekst stil'#13+
'LEGEND STYLE=Legende stil'#13+
'VERT. SPACING=Vert. Avstand'#13+
'SERIES NAMES=Serie Navn'#13+
'SERIES VALUES=Serie Verdier'#13+
'LAST VALUES=Siste Verdier'#13+
'PLAIN=Plain'#13+
'LEFT VALUE=Verdi Venstre'#13+
'RIGHT VALUE=Verdi Høyre'#13+
'LEFT PERCENT=Prosent Venstre'#13+
'RIGHT PERCENT=Procent Høyre'#13+
'X VALUE=X Verdi'#13+
'X AND VALUE=X og Verdi'#13+
'X AND PERCENT=X og Prosent'#13+
'CHECK BOXES=Kontroll boks'#13+
'DIVIDING LINES=Avskillings Linjer'#13+
'FONT SERIES COLOR=Skrifttypeserie Farge'#13+
'POSITION OFFSET %=Posisjonsutløp %'#13+
'MARGIN=Margin'#13+
'RESIZE CHART=Endre størrelse på Diagram'#13+
'CONTINUOUS=Kontinuerlig'#13+
'POINTS PER PAGE=Punkter pr Side'#13+
'SCALE LAST PAGE=Mål Siste Side'#13+
'CURRENT PAGE LEGEND=Aktuelle Sides Ledetekst'#13+
'PANEL EDITOR=Panel Editor'#13+
'BACKGROUND=Bakgrunn'#13+
'BORDERS=Ramme'#13+
'BACK IMAGE=Bakgrunnsbilde'#13+
'STRETCH=Strukket'#13+
'TILE=Flis'#13+
'BEVEL INNER=Skråkant Inni'#13+
'BEVEL OUTER=Skråkant Utenpå'#13+
'MARKS=Merker'#13+
'DATA SOURCE=Datakilde'#13+
'SORT=Sortering'#13+
'CURSOR=Markør'#13+
'SHOW IN LEGEND=Vis i ledetekst'#13+
'FORMATS=Formater'#13+
'VALUES=Verdier'#13+
'PERCENTS=Prosenter'#13+
'HORIZONTAL AXIS=Horisontal Akse'#13+
'DATETIME=DatoTid'#13+
'VERTICAL AXIS=Vertikal Akse'#13+
'ASCENDING=Stigende'#13+
'DESCENDING=Fallende'#13+
'DRAW EVERY=Tegn hver'#13+
'CLIPPED=Klippet'#13+
'ARROWS=Piler'#13+
'MULTI LINE=Multi linjer'#13+
'ALL SERIES VISIBLE=Alle Serier Synlige'#13+
'LABEL=Merker'#13+
'LABEL AND PERCENT=Merker og Prosent'#13+
'LABEL AND VALUE=Merker og Verdi'#13+
'PERCENT TOTAL=Prosent Total'#13+
'LABEL AND PERCENT TOTAL=Merker og Prosent Total'#13+
'X AND Y VALUES=X og Y verdier'#13+
'MANUAL=Manuelt'#13+
'RANDOM=Tilfeldig'#13+
'FUNCTION=Funksjon'#13+
'NEW=Ny'#13+
'EDIT=Rediger'#13+
'PERSISTENT=Vedvarende'#13+
'ADJUST FRAME=Juster ramme'#13+
'SUBTITLE=UnderTittel'#13+
'SUBFOOT=UnderFot'#13+
'FOOT=Fot'#13+
'VISIBLE WALLS=Synlige vegg'#13+
'BACK=Bakgrunn'#13+
'DIF. LIMIT=Dif. begrensning'#13+
'ABOVE=Ovenfor'#13+
'WITHIN=Mellom'#13+
'BELOW=Nedenfor'#13+
'CONNECTING LINES=Forbindende Linjer'#13+
'BROWSE=Gjennomse'#13+
'TILED=Flisete'#13+
'INFLATE MARGINS=Fyll Marginer opp'#13+
'SQUARE=Firkant'#13+
'DOWN TRIANGLE=Nedadvent Trekant'#13+
'SMALL DOT=Liten Prikk'#13+
'GLOBAL=Global'#13+
'SHAPES=Former'#13+
'BRUSH=Børste'#13+
'DELAY=Forsinkelse'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Mus behandling'#13+
'MOVE=Flytt'#13+
'CLICK=Klikk'#13+
'DRAW LINE=Tegn Linje'#13+
'EXPLODE BIGGEST=Ekspander største'#13+
'TOTAL ANGLE=Total vinkel'#13+
'GROUP SLICES=Gruppestykker'#13+
'BELOW %=Under %'#13+
'BELOW VALUE=Under Verdi'#13+
'OTHER=Annen'#13+
'PATTERNS=Mønster'#13+
'SIZE %=Størrelse %'#13+
'SERIES DATASOURCE TEXT EDITOR=Serier Datakilde Tekst Editor'#13+
'FIELDS=Felter'#13+
'NUMBER OF HEADER LINES=Antall Overskrift Linjer'#13+
'SEPARATOR=Adskiller'#13+
'COMMA=Komma'#13+
'SPACE=Mellomrom'#13+
'TAB=Tab'#13+
'FILE=Fil'#13+
'WEB URL=Web URL'#13+
'LOAD=Hent'#13+
'C LABELS=C Merker'#13+
'R LABELS=R Merker'#13+
'C PEN=C Penn'#13+
'R PEN=R Penn'#13+
'STACK GROUP=Stable Gruppe'#13+
'MULTIPLE BAR=Flerfoldig Bar'#13+
'SIDE=Side'#13+
'SIDE ALL=Sidestil Alle'#13+
'DRAWING MODE=Tegningsmodus'#13+
'WIREFRAME=Trådramme'#13+
'DOTFRAME=Punktramme'#13+
'SMOOTH PALETTE=Jevn palette'#13+
'SIDE BRUSH=Side Børste'#13+
'ABOUT TEECHART PRO V7.0=Om TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Alle rettigheter forbeholdes'#13+
'VISIT OUR WEB SITE !=Besøk vår Web side !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Velg Diagram stil'#13+
'DATABASE CHART=Database Diagram'#13+
'NON DATABASE CHART=Ikke Database Diagram'#13+
'SELECT A DATABASE TABLE=Velg en Database Tabell'#13+
'ALIAS=Alias'#13+
'TABLE=Tabell'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Velg ønskede felter for diagrammet'#13+
'SELECT A TEXT LABELS FIELD=Velg et tekstmerket felt'#13+
'CHOOSE THE DESIRED CHART TYPE=Velg ønsket diagram type'#13+
'2D=2D'#13+
'CHART PREVIEW=Diagram Forhåndsvisning'#13+
'SHOW LEGEND=Vis Legende'#13+
'SHOW MARKS=Vis Markeringer'#13+
'< BACK=< Tilbake'#13+
'EXPORT CHART=Eksporter Diagram'#13+
'PICTURE=Bilde'#13+
'NATIVE=Innfødt'#13+
'KEEP ASPECT RATIO=Bevar utseendeforholdet'#13+
'INCLUDE SERIES DATA=Inkluder Serie data'#13+
'FILE SIZE=Filstørrelse'#13+
'DELIMITER=Adskiller'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabell'#13+
'EXCEL=Excel'#13+
'COLON=Kolon'#13+
'INCLUDE=Inkluder'#13+
'POINT LABELS=Punkt Merker'#13+
'POINT INDEX=Punkt Indeks'#13+
'HEADER=Header'#13+
'COPY=Kopier'#13+
'SAVE=Lagre'#13+
'SEND=Send'#13+
'FUNCTIONS=Funksjoner'#13+
'ADX=ADX'#13+
'AVERAGE=Gjennomsnitt'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Divider'#13+
'EXP. AVERAGE=Exp. Gjennomsnitt'#13+
'EXP.MOV.AVRG.=Exp.Flytt.Gjennomsnitt.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Tilføy'#13+
'MULTIPLY=Multipliser'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=Std.Avvik'#13+
'STOCHASTIC=Stokastisk'#13+
'SUBTRACT=Subtraksjon'#13+
'SOURCE SERIES=Kilde Serier'#13+
'TEECHART GALLERY=TeeChart Galleri'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduksjon'#13+
'COMPRESSION=Kompressjonstype'#13+
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
'PERFORMANCE=Utførsel'#13+
'QUALITY=Kvalitet'#13+
'SPEED=Hastighet'#13+
'COMPRESSION LEVEL=Kompressjonsgrad'#13+
'CHART TOOLS GALLERY=Diagram Verktøy Galleri'#13+
'ANNOTATION=Annotation'#13+
'AXIS ARROWS=Akse Piler'#13+
'COLOR BAND=Båndfarge'#13+
'COLOR LINE=Linjefarge'#13+
'DRAG MARKS=Trekk merker'#13+
'MARK TIPS=Merk Tips'#13+
'NEAREST POINT=Nærmeste Punkt'#13+
'ROTATE=Roter'#13+

// 6.0
'BEVEL SIZE=Skråkant'#13+
'DELETE ROW=Fjern rad'#13+
'VOLUME SERIES=Volum serie'#13+
'SINGLE=Singel'#13+
'REMOVE CUSTOM COLORS=Fjern standard farge'#13+
'USE PALETTE MINIMUM=Bruk palette minimum'#13+
'AXIS MAXIMUM=Akse maksimum'#13+
'AXIS CENTER=Akse senter'#13+
'AXIS MINIMUM=Akse minimum'#13+
'DAILY (NONE)=Daglig (ingen)'#13+
'WEEKLY=Ukentlig'#13+
'MONTHLY=Månedlig'#13+
'BI-MONTHLY=Bi-månedlig'#13+
'QUARTERLY=Kvartalvis'#13+
'YEARLY=Årlig'#13+
'DATETIME PERIOD=Datetime periode'#13+
'CASE SENSITIVE=Case sensitiv'#13+
'DRAG STYLE=Dra stil'#13+
'SQUARED=Kvadrat'#13+
'GRID 3D SERIES=Gitter 3d serie'#13+
'DARK BORDER=Mørk grense'#13+
'PIE SERIES=Pai serie'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Eksplodere'#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Graf fra mal (*.tee fil)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Åpne TeeChart mal fra'#13+
'BINARY=Binær'#13+
'VOLUME OSCILLATOR=Volum oscilloskop'#13+
'PIE SLICES=Pai stykke'#13+
'ARROW WIDTH=Pil vidde'#13+
'ARROW HEIGHT=Pil høyde'#13+
'DEFAULT COLOR=Standard farge'#13+
'PERIOD=Periode'#13+
'UP=Opp'#13+
'DOWN=Ned'#13+
'SHADOW EDITOR=Skygge editor'#13+
'CALLOUT=Utrop'#13+
'TEXT ALIGNMENT=Tekst oppstilling'#13+
'DISTANCE=Distanse'#13+
'ARROW HEAD=Pil hode'#13+
'POINTER=Peker'#13+
'DRAG=Slepe'#13+
'HANDPOINT=Håndpunkt'#13+
'HOURGLASS=Timeglass'#13+
'AVAILABLE LANGUAGES=Tilgjengelige språk'#13+
'CHOOSE A LANGUAGE=Velg språk'#13+
'CALCULATE USING=Regn ved bruk av'#13+
'EVERY NUMBER OF POINTS=Alle nummer av punkter'#13+
'EVERY RANGE=Alle soner'#13+
'INCLUDE NULL VALUES=Inkluder null verdier'#13+
'ENTER DATE=Tast inn dato'#13+
'ENTER TIME=Tast inn tid'#13+
'DEVIATION=Deviasjon'#13+
'UPPER=Over'#13+
'LOWER=Under'#13+
'NOTHING=Ingenting'#13+
'LEFT TRIANGLE=Venstre trekant'#13+
'RIGHT TRIANGLE=Høyre trekant'#13+
'SHOW PREVIOUS BUTTON=Vis tidligere knapp'#13+
'SHOW NEXT BUTTON=Vis neste knapp'#13+
'CONSTANT=Konstant'#13+
'SHOW LABELS=Vis merkelapper'#13+
'SHOW COLORS=Vis farger'#13+
'XYZ SERIES=XYZ serier'#13+
'SHOW X VALUES=Vis X verdier'#13+
'ACCUMULATE=Akkumuler'#13+
'STEP=Steg'#13+
'DRAG REPAINT=Dra repaint'#13+
'NO LIMIT DRAG=Ingen begrensning dra'#13+
'SMOOTH=Glatt'#13+
'INTERPOLATE=Interpolere'#13+
'START X=Start X'#13+
'NUM. POINTS=No. punkter'#13+
'COLOR EACH LINE=Fargelegg alle linjer'#13+
'SORT BY=Sorter på'#13+
'(NONE)=(ingen)'#13+
'CALCULATION=Regne'#13+
'GROUP=Gruppere'#13+
'WEIGHT=Vekt'#13+
'EDIT LEGEND=Editer legende'#13+
'ROUND=Rund'#13+
'FLAT=Flat'#13+
'DRAW ALL=Tegn alle'#13+
'IGNORE NULLS=Ignorer nulls'#13+
'OFFSET=Avstand'#13+
'LIGHT 0=Lys 1'#13+
'LIGHT 1=Lys 2'#13+
'LIGHT 2=Lys 3'#13+
'DRAW STYLE=Tegne stil'#13+
'POINTS=Punkter'#13+
'DEFAULT BORDER=Standard grense'#13+
'SHOW PAGE NUMBER=Vis side nummer'#13+
'SEPARATION=Separasjon'#13+
'ROUND BORDER=Rund grense'#13+
'NUMBER OF SAMPLE VALUES=Antall prøve verdier'#13+
'RESIZE PIXELS TOLERANCE=Endre piksel toleranse'#13+
'FULL REPAINT=Full repaint'#13+
'END POINT=Endepunkt'#13+
'BAND 1=Bånd 1'#13+
'BAND 2=Bånd 2'#13+
'TRANSPOSE NOW=Transposer nå'#13+
'PERIOD 1=Periode 1'#13+
'PERIOD 2=Periode 2'#13+
'PERIOD 3=Periode 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Exp. linje'#13+
'WEIGHTED=Målt'#13+
'WEIGHTED BY INDEX=Målt på indeks'#13+
'BOX SIZE=Boks størrelse'#13+
'REVERSAL AMOUNT=Inversjert beløp'#13+
'PERCENTAGE=Prosent'#13+
'COMPLETE R.M.S.=Komplett r.m.s.'#13+
'BUTTON=Knapp'#13+
'START AT MIN. VALUE=Start på min. verdi'#13+
'EXECUTE !=Start !'#13+
'IMAG. SYMBOL=Imag. symbol'#13+
'SELF STACK=Selv stable'#13+
'SIDE LINES=Side linjer'#13+
'EXPORT DIALOG=Eksporter dialog'#13+
'POINT COLORS=Punkt farger'#13+
'OUTLINE GRADIENT=Omriss stigningsgrad'#13+
'TREND=Tendens'#13+
'RADIAL=Radial'#13+
'BALANCE=Balanse'#13+
'RADIAL OFFSET=Radial avstand'#13+
'HORIZ=Horis'#13+
'DRAG POINT=Dra punkt'#13+
'COVER=Omslag'#13+
'VALUE SOURCE=Verdi kilde'
;
  end;
end;

Procedure TeeSetNorwegian;
begin
  TeeCreateNorwegian;
  TeeLanguage:=TeeNorwegianLanguage;
  TeeNorwegianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeNorwegianLanguage);
end.
