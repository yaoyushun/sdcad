unit TeeSwedish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeSwedishLanguage:TStringList=nil;

Procedure TeeSetSwedish;
Procedure TeeCreateSwedish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeSwedishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='(c) 1995-2004 David Berneda';
  TeeMsg_LegendFirstValue   :='Första Förklarande Värdet måste vara > 0';
  TeeMsg_LegendColorWidth   :='Förklaringens Färgbredd måste vara > 0%';
  TeeMsg_SeriesSetDataSource:='Inget Överordnat Diagram för att validera Datakälla';
  TeeMsg_SeriesInvDataSource:='Ingen giltig Datakälla: %s';
  TeeMsg_FillSample         :='Det numeriska Utfyllningsvärdet måste vara > 0';
  TeeMsg_AxisLogDateTime    :='DatumTid Axeln kan inte vara Logaritmisk ';
  TeeMsg_AxisLogNotPositive :='Min och Max värde för Logaritmisk Axel måste vara >= 0';
  TeeMsg_AxisLabelSep       :='Etiketternas Separation % måste vara > 0';
  TeeMsg_AxisIncrementNeg   :='Axelns ökning måste vara >= 0';
  TeeMsg_AxisMinMax         :='Axelns Minimum Värde måste vara <= Maximum';
  TeeMsg_AxisMaxMin         :='Axelns Maximum Värde bör vara >= Minimum';
  TeeMsg_AxisLogBase        :='Axelns Logaritmiska Bas bör vara >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPunkterPerSida måste vara >= 0';
  TeeMsg_3dPercent          :='3D effekt i procent måste vara mellan %d och %d';
  TeeMsg_CircularSeries     :='Sammanhängande Cirkel Serier är inte tillåtet';
  TeeMsg_WarningHiColor     :='16k Färger eller bättre för bättre resultat';

  TeeMsg_DefaultPercentOf   :='%s av %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'av %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Axel Titel';
  TeeMsg_AxisLabels         :='Axel Etiketter';
  TeeMsg_RefreshInterval    :='Uppdaterings Intervall måste vara mellan 0 och 60';
  TeeMsg_SeriesParentNoSelf :='Serie Överordnat Diagram är inte jag själv!';
  TeeMsg_GalleryLine        :='Linje';
  TeeMsg_GalleryPoint       :='Punkt';
  TeeMsg_GalleryArea        :='Yta';
  TeeMsg_GalleryBar         :='Stapel';
  TeeMsg_GalleryHorizBar    :='Liggande';
  TeeMsg_Stack              :='Stapel';
  TeeMsg_GalleryPie         :='Paj';
  TeeMsg_GalleryCircled     :='Cirkel';
  TeeMsg_GalleryFastLine    :='Snabb Linje';
  TeeMsg_GalleryHorizLine   :='Horis. Linje';

  TeeMsg_PieSample1         :='Bilar';
  TeeMsg_PieSample2         :='Telefoner';
  TeeMsg_PieSample3         :='Bord';
  TeeMsg_PieSample4         :='Skärmar';
  TeeMsg_PieSample5         :='Lampor';
  TeeMsg_PieSample6         :='Tangentbord';
  TeeMsg_PieSample7         :='Cyklar';
  TeeMsg_PieSample8         :='Stolar';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Ändrar %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Utökad';
  TeeMsg_GalleryFunctions   :='Funktioner';

  TeeMsg_EditChart          :='Än&dra Diagram...';
  TeeMsg_PrintPreview       :='&Förhandsgranska...';
  TeeMsg_ExportChart        :='E&xportera Diagram...';
  TeeMsg_CustomAxes         :='Egen Axel...';

  TeeMsg_InvalidEditorClass :='%s: Ogiltig Redigerings Klass: %s';
  TeeMsg_MissingEditorClass :='%s: har ingen Redigerings Dialog';

  TeeMsg_GalleryArrow       :='Pil';

  TeeMsg_ExpFinish          :='&Avsluta';
  TeeMsg_ExpNext            :='&Nästa >';

  TeeMsg_GalleryGantt       :='Staplad';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyp';
  TeeMsg_GanttSample3       :='Utveckling';
  TeeMsg_GanttSample4       :='Försäljning';
  TeeMsg_GanttSample5       :='Marknadsföring';
  TeeMsg_GanttSample6       :='Prov';
  TeeMsg_GanttSample7       :='Tillv.';
  TeeMsg_GanttSample8       :='Rättning';
  TeeMsg_GanttSample9       :='Ny Version';
  TeeMsg_GanttSample10      :='Bankväsen';

  TeeMsg_ChangeSeriesTitle  :='Ändra Serie Titel';
  TeeMsg_NewSeriesTitle     :='Ny Serie Titel:';
  TeeMsg_DateTime           :='DatumTid';
  TeeMsg_TopAxis            :='Övre Axel';
  TeeMsg_BottomAxis         :='Nedre Axel';
  TeeMsg_LeftAxis           :='Vänster Axel';
  TeeMsg_RightAxis          :='Höger Axel';

  TeeMsg_SureToDelete       :='Radera %s ?';
  TeeMsg_DateTimeFormat     :='DatumTid For&mat:';
  TeeMsg_Default            :='Standard';
  TeeMsg_ValuesFormat       :='Värde For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Önskad %s Ökning';

  TeeMsg_IncorrectMaxMinValue:='Ogiltigt värde. Anledning: %s';
  TeeMsg_EnterDateTime      :='Skriv [Antal Dagar] [tt:mm:ss]';

  TeeMsg_SureToApply        :='Spara Ändringar ?';
  TeeMsg_SelectedSeries     :='(Vald Serie)';
  TeeMsg_RefreshData        :='Uppdate&ra Data';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='431';
  TeeMsg_FunctionAdd        :='Addera';
  TeeMsg_FunctionSubtract   :='Subtrahera';
  TeeMsg_FunctionMultiply   :='Multiplicera';
  TeeMsg_FunctionDivide     :='Dividera';
  TeeMsg_FunctionHigh       :='Hög';
  TeeMsg_FunctionLow        :='Låg';
  TeeMsg_FunctionAverage    :='Medel';

  TeeMsg_GalleryShape       :='Form';
  TeeMsg_GalleryBubble      :='Bubbla';
  TeeMsg_FunctionNone       :='Kopia';

  TeeMsg_None               :='(inget)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Punkt storlek måste vara >0';
  TeeMsg_About              :='&Om TeeChart...';

  tcAdditional              :='Ytterligare';
  tcDControls               :='Data Kontroller';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Datauppsättning';
  TeeMsg_AskDataSet         :='&Datauppsättning:';

  TeeMsg_SingleRecord       :='En Post';
  TeeMsg_AskDataSource      :='&Datakälla:';

  TeeMsg_Summary            :='Sammandrag';

  TeeMsg_FunctionPeriod     :='FunktionsPeriod bör vara >= 0';

  TeeMsg_TeeChartWizard     :='TeeChart Guide';
  TeeMsg_WizardTab          :='Företag';

  TeeMsg_ClearImage         :='&Rensa';
  TeeMsg_BrowseImage        :='Bläddra...';

  TeeMsg_WizardSureToClose  :='Är du säker på att du vill stänga TeeChart Guiden ?';
  TeeMsg_FieldNotFound      :='Fält %s existerar inte';

  TeeMsg_DepthAxis          :='Axel Djup';
  TeeMsg_PieOther           :='Andra';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Paj';
  TeeMsg_ValuesBar          :='Stapel';
  TeeMsg_ValuesAngle        :='Vinkel';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Slut';
  TeeMsg_ValuesGanttNextTask:='NästaUppgift';
  TeeMsg_ValuesBubbleRadius :='Radie';
  TeeMsg_ValuesArrowEndX    :='SlutX';
  TeeMsg_ValuesArrowEndY    :='SlutY';
  TeeMsg_Legend             :='Förklaring';
  TeeMsg_Title              :='Titel';
  TeeMsg_Foot               :='Fot';
  TeeMsg_Period             :='Period';
  TeeMsg_PeriodRange        :='Period skala';
  TeeMsg_CalcPeriod         :='Beräkna %s varje:';
  TeeMsg_SmallDotsPen       :='Små Punkter';

  TeeMsg_InvalidTeeFile     :='Ogiltigt Diagram i *.'+TeeMsg_TeeExtension+' fil';
  TeeMsg_WrongTeeFileFormat :='Fel *.'+TeeMsg_TeeExtension+' fil format';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Diagram Axlar';
  TeeMsg_ChartAxesCategoryDesc   :='Diagram Axlar, egenskaper och händelser ';
  TeeMsg_ChartWallsCategoryName  :='Diagram Väggar';
  TeeMsg_ChartWallsCategoryDesc  :='Diagram Väggar, egenskaper och händelser ';
  TeeMsg_ChartTitlesCategoryName :='Diagram Titlar';
  TeeMsg_ChartTitlesCategoryDesc :='Diagram Titlar, egenskaper och händelser';
  TeeMsg_Chart3DCategoryName     :='Diagram 3D';
  TeeMsg_Chart3DCategoryDesc     :='Diagram 3D, egenskaper och händelser';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Egen ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serier...';

  TeeMsg_PageOfPages            :='Sida %d av %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Första';
  TeeMsg_Prior  :='Föregående';
  TeeMsg_Next   :='Nästa';
  TeeMsg_Last   :='Sista';
  TeeMsg_Insert :='Infoga';
  TeeMsg_Delete :='Radera';
  TeeMsg_Edit   :='Ändra';
  TeeMsg_Post   :='Spara';
  TeeMsg_Cancel :='Avbryt';

  TeeMsg_All    :='(allt)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='som &Bitmapp';
  TeeMsg_BMPFilter    :='Bitmapp (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='som &Metafil';
  TeeMsg_EMFFilter    :='Utökad Metafil (*.emf)|*.emf|Metafil (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Panel egenskap är inte satt till Export format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Ingen Ram';
  TeeMsg_Dotted    :='Prickad';
  TeeMsg_Colors    :='Färger';
  TeeMsg_Filled    :='Fylld';
  TeeMsg_Marks     :='Markeringar';
  TeeMsg_Stairs    :='Trappor';
  TeeMsg_Points    :='Punkter';
  TeeMsg_Height    :='Höjd';
  TeeMsg_Hollow    :='Ihålig';
  TeeMsg_Point2D   :='2D Punkt';
  TeeMsg_Triangle  :='Triangel';
  TeeMsg_Star      :='Stjärna';
  TeeMsg_Circle    :='Cirkel';
  TeeMsg_DownTri   :='Ner Tri.';
  TeeMsg_Cross     :='Kors';
  TeeMsg_Diamond   :='Ruta';
  TeeMsg_NoLines   :='Inga Linjer';
  TeeMsg_Stack100  :='Stapla 100%';
  TeeMsg_Pyramid   :='Pyramid';
  TeeMsg_Ellipse   :='Ellips';
  TeeMsg_InvPyramid:='Omvänd Pyramid';
  TeeMsg_Sides     :='Sidor';
  TeeMsg_SideAll   :='Sida Alla';
  TeeMsg_Patterns  :='Mönster';
  TeeMsg_Exploded  :='Uppdelad';
  TeeMsg_Shadow    :='Skugga';
  TeeMsg_SemiPie   :='Halv Bit';
  TeeMsg_Rectangle :='Rektangel';
  TeeMsg_VertLine  :='Lodrät Linje';
  TeeMsg_HorizLine :='Vågrät Linje';
  TeeMsg_Line      :='Linje';
  TeeMsg_Cube      :='Kub';
  TeeMsg_DiagCross :='Diag.Kors';

  TeeMsg_CanNotFindTempPath    :='Kan inte hitta Temp katalogen';
  TeeMsg_CanNotCreateTempChart :='Kan inte skapa Temp fil';
  TeeMsg_CanNotEmailChart      :='Kan inte e-posta TeeChart. Mapi Fel: %d';

  TeeMsg_SeriesDelete :='Radera Serie: IndexVärde %d är utanför gränsen (0 to %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Språk...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polär';
  TeeMsg_GalleryCandle      :='Ljus';
  TeeMsg_GalleryVolume      :='Volym';
  TeeMsg_GallerySurface     :='Yta';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Beziér';
  TeeMsg_GalleryPoint3D     :='3D Punkt';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Munk';
  TeeMsg_GalleryCursor      :='Markör';
  TeeMsg_GalleryBar3D       :='3D Stapel';
  TeeMsg_GalleryBigCandle   :='Stort Ljus';
  TeeMsg_GalleryLinePoint   :='Punktad Linje';
  TeeMsg_GalleryHistogram   :='Historik';
  TeeMsg_GalleryWaterFall   :='Vattenfall';
  TeeMsg_GalleryWindRose    :='Kompass';
  TeeMsg_GalleryClock       :='Klocka';
  TeeMsg_GalleryColorGrid   :='Färgat Rutnät';
  TeeMsg_GalleryBoxPlot     :='Box';
  TeeMsg_GalleryHorizBoxPlot:='Horis.Box';
  TeeMsg_GalleryBarJoin     :='Förenad Stapel';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramid';
  TeeMsg_GalleryMap         :='Karta';

  TeeMsg_PolyDegreeRange    :='Polynom grader måste vara mellan 1 och 20';
  TeeMsg_AnswerVectorIndex   :='Vektor index måste vara mellan 1 och %d';
  TeeMsg_FittingError        :='Kan inte utföra montering';
  TeeMsg_PeriodRange         :='Period måste vara >= 0';
  TeeMsg_ExpAverageWeight    :='Förväntad Medel Vikt måste vara mellan 0 and 1';
  TeeMsg_GalleryErrorBar     :='Fel Stapel';
  TeeMsg_GalleryError        :='Fel';
  TeeMsg_GalleryHighLow      :='Hög-Låg';
  TeeMsg_FunctionMomentum    :='Rörelsemängd';
  TeeMsg_FunctionMomentumDiv :='Rörelsemängd Div';
  TeeMsg_FunctionExpAverage  :='Förv. Medel';
  TeeMsg_FunctionMovingAverage:='Rör. Genomsnitt';
  TeeMsg_FunctionExpMovAve   :='Förv. RörelseMedel';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Utgämning';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Förv.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Ackumulerad';
  TeeMsg_FunctionStdDeviation:='Std.Avvikelse';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Effektivvärde';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Slumpmässig'; //Stochastic
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Beräkna';
  TeeMsg_LoadChart           :='Öppna TeeChart...';
  TeeMsg_SaveChart           :='Spara TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro filer';

  TeeMsg_GallerySamples      :='Exempel';
  TeeMsg_GalleryStats        :='Statistik';

  TeeMsg_CannotFindEditor    :='Kan inte hitta redigeringen för Serier: %s';


  TeeMsg_CannotLoadChartFromURL:='Fel kod: %d vid laddning av Diagram från URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Fel kod: %d vid laddning av Data Serie från URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Öppen';
  TeeMsg_ValuesHigh          :='Hög';
  TeeMsg_ValuesLow           :='Låg';
  TeeMsg_ValuesClose         :='Stäng';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='Std.Fel';

  TeeMsg_Grid3D              :='Rutnät 3D';

  TeeMsg_LowBezierPoints     :='Antal Beziér punkter bör var > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Ändra';
  TeeCommanMsg_Print    :='Skriv ut';
  TeeCommanMsg_Copy     :='Kopiera';
  TeeCommanMsg_Save     :='Spara';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d° Höjning: %d°';
  TeeCommanMsg_Rotate   :='Rotera';

  TeeCommanMsg_Moving   :='Horis.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Flytta';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zooma';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Djup';

  TeeCommanMsg_Chart    :='Diagram';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Dra %s för att Rotera';
  TeeCommanMsg_MoveLabel  :='Dra %s för att Flytta';
  TeeCommanMsg_ZoomLabel  :='Dra %s för att Zooma';
  TeeCommanMsg_DepthLabel :='Dra %s för att storleksändra 3D';

  TeeCommanMsg_NormalLabel:='Dra Vänstra knappen för att Zooma, Högra knappen för att Bläddra';
  TeeCommanMsg_NormalPieLabel:='Dra en Paj Bit för att dra ut den';

  TeeCommanMsg_PieExploding :='Paj Bit: %d Utdragen: %d %%';

  TeeMsg_TriSurfaceLess:='Antalet punkter måste vara >= 4';
  TeeMsg_TriSurfaceAllColinear:='Alla data punkter för samma linje';
  TeeMsg_TriSurfaceSimilar:='Liknande punkter - kan inte utföra';
  TeeMsg_GalleryTriSurface:='Triangel Yta';

  TeeMsg_AllSeries :='Alla Serier';
  TeeMsg_Edit      :='Ändra';

  TeeMsg_GalleryFinancial    :='Finansiell';

  TeeMsg_CursorTool    :='Markör';
  TeeMsg_DragMarksTool :='Dra Märken';
  TeeMsg_AxisArrowTool :='Axel Pilar';
  TeeMsg_DrawLineTool  :='Rita Linje';
  TeeMsg_NearestTool   :='Närmaste Punkt';
  TeeMsg_ColorBandTool :='Färg Band';
  TeeMsg_ColorLineTool :='Färg Linje';
  TeeMsg_RotateTool    :='Rotera';
  TeeMsg_ImageTool     :='Bild';
  TeeMsg_MarksTipTool  :='Märkes Tips';

  TeeMsg_CantDeleteAncestor  :='Kan inte radera UpphovsInformation'; //ancestor

  TeeMsg_Load	         :='Laddar...';
  TeeMsg_NoSeriesSelected:='Ingen Serie vald';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Diagram';
  TeeMsg_CategorySeriesActions :='Diagram Serie';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Ändra 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktiv';
  TeeMsg_ActionSeriesActiveHint :='Visa / Dölj Serie';
  TeeMsg_ActionEditHint         :='Ändra Diagram';
  TeeMsg_ActionEdit             :='&Ändra...';
  TeeMsg_ActionCopyHint         :='Kopiera till Urklipp';
  TeeMsg_ActionCopy             :='&Kopiera';
  TeeMsg_ActionPrintHint        :='Förhandsgranska Diagram';
  TeeMsg_ActionPrint            :='&Skriv ut...';
  TeeMsg_ActionAxesHint         :='Visa / Dölj Axlar';
  TeeMsg_ActionAxes             :='&Axlar';
  TeeMsg_ActionGridsHint        :='Visa / Dölj Rutnät';
  TeeMsg_ActionGrids            :='&Rutnät';
  TeeMsg_ActionLegendHint       :='Visa / Dölj Förklaring';
  TeeMsg_ActionLegend           :='&Förklaring';
  TeeMsg_ActionSeriesEditHint   :='Ändra Serie';
  TeeMsg_ActionSeriesMarksHint  :='Visa / Dölj Serie Märke';
  TeeMsg_ActionSeriesMarks      :='&Märke';
  TeeMsg_ActionSaveHint         :='Spara Diagram';
  TeeMsg_ActionSave             :='&Spara...';

  TeeMsg_CandleBar              :='Stapel';
  TeeMsg_CandleNoOpen           :='Öppna Ej';
  TeeMsg_CandleNoClose          :='Stäng Ej';
  TeeMsg_NoLines                :='Ej Linjer';
  TeeMsg_NoHigh                 :='Ej Hög';
  TeeMsg_NoLow                  :='Ej Låg';
  TeeMsg_ColorRange             :='Färg Område';
  TeeMsg_WireFrame              :='Tråd Ram';
  TeeMsg_DotFrame               :='Prick Ram';
  TeeMsg_Positions              :='Positioner';
  TeeMsg_NoGrid                 :='Inget Rutnät';
  TeeMsg_NoPoint                :='Ingen Punkt';
  TeeMsg_NoLine                 :='Ingen Linje';
  TeeMsg_Labels                 :='Etiketter';
  TeeMsg_NoCircle               :='Ingen Cirkel';
  TeeMsg_Lines                  :='Linjer';
  TeeMsg_Border                 :='Kant';

  TeeMsg_SmithResistance      :='Motstånd';
  TeeMsg_SmithReactance       :='Reaktans';

  TeeMsg_Column  :='Kolumn';

  { 5.02 }
  TeeMsg_Origin               :='Ursprung';
  TeeMsg_Transparency         :='Genomskinlig';
  TeeMsg_Box		      :='Box';
  TeeMsg_ExtrOut	      :='ExtrUt';
  TeeMsg_MildOut	      :='Mildut';
  TeeMsg_PageNumber	      :='Sidnummer';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='som &JPEG';
  TeeMsg_JPEGFilter    :='JPEG Filer (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='som &GIF';
  TeeMsg_GIFFilter     :='GIF Filer (*.gif)|*.gif';
  TeeMsg_AsPNG         :='som &PNG';
  TeeMsg_PNGFilter     :='PNG Filer (*.png)|*.png';
  TeeMsg_AsPCX         :='som PC&X';
  TeeMsg_PCXFilter     :='PCX Filer(*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Property            :='Egenskap';
  TeeMsg_Value               :='Värde';
  TeeMsg_Yes                 :='Ja';
  TeeMsg_No                  :='Nej';
  TeeMsg_Image              :='(bild)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Punkt';
  TeeMsg_OpportunityValues    := 'MöjlighetsVärden';
  TeeMsg_QuoteValues          := 'OffertVärden';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Version ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Kan in te importera TeeChart från %s';
  TeeMsg_ActiveXVerbPrint    := '&Förhandsgranskning...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Hjälp...';
  TeeMsg_ActiveXVerbAbout    := '&Om TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Felkod: %d nedladdning: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataKälla är ingen Serie eller tabelldata';
  TeeMsg_SeriesTextSrcError  := 'Ogiltig Serie Typ';
  TeeMsg_AxisTextSrcError    := 'Ogiltig Axel typ';
  TeeMsg_DelSeriesDatasource := 'Är du säker på att du vill radera %s ?';
  TeeMsg_OCXNoPrinter        := 'Ingen Standard skrivare är installerad.';
  TeeMsg_ActiveXPictureNotValid:='Bilden är ogiltig';

  // 6.0

  // TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='som &PDF';
  TeeMsg_PDFFilter        :='PDF filer (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='som PostScript';
  TeeMsg_PSFilter         :='PostScript filer (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horisontal'#13'Yta';
  TeeMsg_SelfStack        :='En Stapel';
  TeeMsg_DarkPen          :='Mörk Penna';
  TeeMsg_SelectFolder     :='Välj Databas Katalog';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Anslutning:';

  // TeeProCo

  TeeMsg_FunctionSmooth       :='Utjämnad';
  TeeMsg_FunctionCross        :='Skärpunkter';
  TeeMsg_GridTranspose        :='Förflytta 3D Rutnät';
  TeeMsg_FunctionCompress     :='Kompression';
  TeeMsg_ExtraLegendTool      :='Extra Förklaring';
  TeeMsg_FunctionCLV          :='Stäng Plats'#13'Värde';
  TeeMsg_FunctionOBV          :='I Balans'#13'Volym';
  TeeMsg_FunctionCCI          :='Handelsvara'#13'Kanal Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animerad Serie';
  TeeMsg_GalleryPointFigure   :='Punkt & Siffra';
  TeeMsg_Up                   :='Upp';
  TeeMsg_Down                 :='Ner';
  TeeMsg_GanttTool            :='Dra Gantt';
  TeeMsg_XMLFile              :='XML file';
  TeeMsg_GridBandTool         :='Rutnät band verktyg';

  TeeMsg_FunctionPerf         :='Prestanda';
  TeeMsg_GalleryGauge         :='Mäta';
  TeeMsg_GalleryGauges        :='Mätare';
  TeeMsg_ValuesVectorEndZ     :='SlutZ';
  TeeMsg_GalleryVector3D      :='Vektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torn';
  TeeMsg_SingleColor          :='Enkel Färg';
  TeeMsg_Cover                :='Dölja';
  TeeMsg_Cone                 :='Kon';
  TeeMsg_PieTool              :='Tårtbitar';
end;

Procedure TeeCreateSwedish;
begin
  if not Assigned(TeeSwedishLanguage) then
  begin
    TeeSwedishLanguage:=TStringList.Create;
    TeeSwedishLanguage.Text:=

'GRADIENT EDITOR=Ändra Toning'#13+
'GRADIENT=Toning'#13+
'DIRECTION=Riktning'#13+
'VISIBLE=Synlig'#13+
'TOP BOTTOM=Topp Botten'#13+
'BOTTOM TOP=Botten Topp'#13+
'LEFT RIGHT=Vänster Höger'#13+
'RIGHT LEFT=Höger Vänster'#13+
'FROM CENTER=Från Center'#13+
'FROM TOP LEFT=Från Topp Vänster'#13+
'FROM BOTTOM LEFT=Från Botten Vänster'#13+
'OK=Ok'#13+
'CANCEL=Avbryt'#13+
'COLORS=Färger'#13+
'START=Start'#13+
'MIDDLE=Mitten'#13+
'END=Slut'#13+
'SWAP=Byt'#13+
'NO MIDDLE=Ingen Mitt'#13+
'TEEFONT EDITOR=Ändra TeeTypsnitt'#13+
'INTER-CHAR SPACING=Inre mellanrum'#13+
'FONT=Typsnitt'#13+
'SHADOW=Skugga'#13+
'HORIZ. SIZE=Horis. Storlek'#13+
'VERT. SIZE=Vert. Storlek'#13+
'COLOR=Färg'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Val'#13+
'FORMAT=Format'#13+
'TEXT=Text'#13+
'POSITION=Position'#13+
'LEFT=Vänster'#13+
'TOP=Topp'#13+
'AUTO=Auto'#13+
'CUSTOM=Egen'#13+
'LEFT TOP=Vänster Topp'#13+
'LEFT BOTTOM=Vänster Botten'#13+
'RIGHT TOP=Höger Topp'#13+
'RIGHT BOTTOM=Höger Botten'#13+
'MULTIPLE AREAS=Flera Ytor'#13+
'NONE=Ingen'#13+
'STACKED=Travad'#13+
'STACKED 100%=Travad 100%'#13+
'AREA=Yta'#13+
'PATTERN=Mönster'#13+
'STAIRS=Steg'#13+
'SOLID=Hel'#13+
'CLEAR=Rensa'#13+
'HORIZONTAL=Horisontell'#13+
'VERTICAL=Vertikal'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Kryss'#13+
'DIAG.CROSS=Diag.Kryss'#13+
'AREA LINES=Yt Linjer'#13+
'BORDER=Kant'#13+
'INVERTED=Omvänd'#13+
'INVERTED SCROLL=Omvänd Bläddring'#13+
'COLOR EACH=Färga Varje'#13+
'ORIGIN=Ursprung'#13+
'USE ORIGIN=Använd Ursprung'#13+
'WIDTH=Bredd'#13+
'HEIGHT=Höjd'#13+
'AXIS=Axel'#13+
'LENGTH=Längd'#13+
'SCROLL=Bläddra'#13+
'BOTH=Båda'#13+
'AXIS INCREMENT=Axel Ökning'#13+
'INCREMENT=Ökning'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=En Millisekund'#13+
'ONE SECOND=En Sekund'#13+
'FIVE SECONDS=Fem Sekunder'#13+
'TEN SECONDS=Tio Sekunder'#13+
'FIFTEEN SECONDS=Femton Sekunder'#13+
'THIRTY SECONDS=Tretio Sekunder'#13+
'ONE MINUTE=En Minut'#13+
'FIVE MINUTES=Fem Minuter'#13+
'TEN MINUTES=Tio Minuter'#13+
'FIFTEEN MINUTES=Femton Minuter'#13+
'THIRTY MINUTES=Tretio Minuter'#13+
'ONE HOUR=En Timme'#13+
'TWO HOURS=Två Timmar'#13+
'SIX HOURS=Sex Timmar'#13+
'TWELVE HOURS=Tolv Timmar'#13+
'ONE DAY=En Dag'#13+
'TWO DAYS=Två Dagar'#13+
'THREE DAYS=Tre Dagar'#13+
'ONE WEEK=En Vecka'#13+
'HALF MONTH=Två Veckor'#13+
'ONE MONTH=En Månad'#13+
'TWO MONTHS=Två Månader'#13+
'THREE MONTHS=Tre Månader'#13+
'FOUR MONTHS=Fyra Månader'#13+
'SIX MONTHS=Sex Månader'#13+
'ONE YEAR=Ett År'#13+
'EXACT DATE TIME=Exakt Datum Tid'#13+
'AXIS MAXIMUM AND MINIMUM=Axelns Max och Min'#13+
'VALUE=Värde'#13+
'TIME=Tid'#13+
'LEFT AXIS=Vänster Axel'#13+
'RIGHT AXIS=Höger Axel'#13+
'TOP AXIS=Övre Axel'#13+
'BOTTOM AXIS=Nedre Axel'#13+
'% BAR WIDTH=% Stapel Bredd'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% Stapel Offset'#13+
'RECTANGLE=Rektangel'#13+
'PYRAMID=Pyramid'#13+
'INVERT. PYRAMID=Omvänd Pyramid'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Ellips'#13+
'ARROW=Pil'#13+
'RECT. GRADIENT=Rekt. Lutning'#13+
'CONE=Kon'#13+
'DARK BAR 3D SIDES=Mörka Stapel sidor 3D'#13+
'BAR SIDE MARGINS=Använd tapel Marginal'#13+
'AUTO MARK POSITION=Auto Mark. Position'#13+
'JOIN=Förena'#13+
'DATASET=Datauppsättning'#13+
'APPLY=Genomför'#13+
'SOURCE=Källa'#13+
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
'WHISKER=Tunn'#13+
'PATTERN COLOR EDITOR=Ändra Färgmönster'#13+
'IMAGE=Bild'#13+
'BACK DIAGONAL=Bak Diagonal'#13+
'DIAGONAL CROSS=Diagonal Kryss'#13+
'FILL 80%=Fyll 80%'#13+
'FILL 60%=Fyll 60%'#13+
'FILL 40%=Fyll 40%'#13+
'FILL 20%=Fyll 20%'#13+
'FILL 10%=Fyll 10%'#13+
'ZIG ZAG=Sicksack'#13+
'VERTICAL SMALL=Vertikal liten'#13+
'HORIZ. SMALL=Horis. liten'#13+
'DIAG. SMALL=Diag. lite'#13+
'BACK DIAG. SMALL=Bak Diag. liten'#13+
'CROSS SMALL=Kryss liten'#13+
'DIAG. CROSS SMALL=Diag. kryss liten'#13+
'DAYS=Dagar'#13+
'WEEKDAYS=Veckodagar'#13+
'TODAY=I Dag'#13+
'SUNDAY=Söndag'#13+
'TRAILING=Följande'#13+
'MONTHS=Månader'#13+
'LINES=Linjer'#13+
'SHOW WEEKDAYS=Visa Veckodagar'#13+
'UPPERCASE=Versaler'#13+
'TRAILING DAYS=Följande dagar'#13+
'SHOW TODAY=Visa I Dag'#13+
'SHOW MONTHS=Visa Månader'#13+
'CANDLE WIDTH=Ljus Bredd'#13+
'STICK=Sticka'#13+
'BAR=Stapel'#13+
'OPEN CLOSE=Öppna Stäng'#13+
'UP CLOSE=Upp Stäng'#13+
'DOWN CLOSE=Ner Stäng'#13+
'SHOW OPEN=Visa Öppna'#13+
'SHOW CLOSE=Visa Stäng'#13+
'DRAW 3D=Rita 3D'#13+
'DARK 3D=Mörk 3D'#13+
'EDITING=Ändrar'#13+
'CHART=Diagram'#13+
'SERIES=Serier'#13+
'DATA=Data'#13+
'TOOLS=Verktyg'#13+
'EXPORT=Exportera'#13+
'PRINT=Skriv Ut'#13+
'GENERAL=Allmänt'#13+
'TITLES=Titel'#13+
'LEGEND=Beskrivning'#13+
'PANEL=Panel'#13+
'PAGING=Sidor'#13+
'WALLS=Väggar'#13+
'3D=3D'#13+
'ADD=Addera'#13+
'DELETE=Radera'#13+
'TITLE=Titel'#13+
'CLONE=Kopiera'#13+
'CHANGE=Ändra'#13+
'HELP=Hjälp'#13+
'CLOSE=Stäng'#13+
'TEECHART PRINT PREVIEW=TeeChart Förhandsgranskning'#13+
'PRINTER=Skrivare'#13+
'SETUP=Inställning'#13+
'ORIENTATION=Orientering'#13+
'PORTRAIT=Stående'#13+
'LANDSCAPE=Liggande'#13+
'MARGINS (%)=Marginal (%)'#13+
'DETAIL=Detalj'#13+
'MORE=Mer'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Återställ Marginal'#13+
'VIEW MARGINS=Se Marginal'#13+
'PROPORTIONAL=Proportionell'#13+
'CIRCLE=Cirkel'#13+
'VERTICAL LINE=Vertikal Linje'#13+
'HORIZ. LINE=Horis. Linje'#13+
'TRIANGLE=Triangel'#13+
'INVERT. TRIANGLE=Omvänd Triangel'#13+
'LINE=Linjer'#13+
'DIAMOND=Diamant'#13+
'CUBE=Kub'#13+
'STAR=Star'#13+
'TRANSPARENT=Genomskinlig'#13+
'HORIZ. ALIGNMENT=Horis. Inriktning'#13+
'CENTER=Centrerad'#13+
'RIGHT=Höger'#13+
'ROUND RECTANGLE=Rund Rektangel'#13+
'ALIGNMENT=Inriktning'#13+
'BOTTOM=Botten'#13+
'UNITS=Enheter'#13+
'PIXELS=Punkter'#13+
'AXIS ORIGIN=Axel Ursprung'#13+
'ROTATION=Rotation'#13+
'CIRCLED=Cirkulär'#13+
'3 DIMENSIONS=3 D'#13+
'RADIUS=Radie'#13+
'ANGLE INCREMENT=Vinkel Ökning'#13+
'RADIUS INCREMENT=Radie Ökning'#13+
'CLOSE CIRCLE=Stäng Cirkel'#13+
'PEN=Penna'#13+
'LABELS=Etiketter'#13+
'ROTATED=Roterad'#13+
'CLOCKWISE=Medurs'#13+
'INSIDE=Insida'#13+
'ROMAN=Romersk'#13+
'HOURS=Timmar'#13+
'MINUTES=Minuter'#13+
'SECONDS=Sekunder'#13+
'START VALUE=Start värde'#13+
'END VALUE=End värde'#13+
'TRANSPARENCY=Genomskinlig'#13+
'DRAW BEHIND=Rita Bakom'#13+
'COLOR MODE=Färg val'#13+
'STEPS=Steg'#13+
'RANGE=Område'#13+
'PALETTE=Palett'#13+
'PALE=Svag'#13+
'STRONG=Stark'#13+
'GRID SIZE=Storlek på Rutnät'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Djup'#13+
'IRREGULAR=Oregelbunden'#13+
'GRID=Rutnät'#13+
'ALLOW DRAG=Tillåt Drag'#13+
'VERTICAL POSITION=Vertikal Position'#13+
'LEVELS POSITION=Nivå position'#13+
'LEVELS=Nivåer'#13+
'NUMBER=Nummer'#13+
'LEVEL=Nivå'#13+
'AUTOMATIC=Automatisk'#13+
'SNAP=Håll ihop'#13+
'FOLLOW MOUSE=Följ mus'#13+
'STACK=Stapla'#13+
'HEIGHT 3D=Höjd 3D'#13+
'LINE MODE=Linje Modeller'#13+
'OVERLAP=Överlappning'#13+
'STACK 100%=Stapel 100%'#13+
'CLICKABLE=Klickbar'#13+
'AVAILABLE=Tillgängliga'#13+
'SELECTED=Valda'#13+
'DATASOURCE=Datakälla'#13+
'GROUP BY=Gruppera med'#13+
'CALC=Beräkna'#13+
'OF=med'#13+
'SUM=Sum'#13+
'COUNT=Antal'#13+
'HIGH=Hög'#13+
'LOW=Låg'#13+
'AVG=Med.'#13+
'HOUR=Timme'#13+
'DAY=Dag'#13+
'WEEK=Vecka'#13+
'WEEKDAY=Veckodag'#13+
'MONTH=Månad'#13+
'QUARTER=Kvartal'#13+
'YEAR=Year'#13+
'HOLE %=Hål %'#13+
'RESET POSITIONS=Återställ position'#13+
'MOUSE BUTTON=Mus Knapp'#13+
'ENABLE DRAWING=Tillåt Ritning'#13+
'ENABLE SELECT=Tillåt Val'#13+
'ENHANCED=Utökad'#13+
'ERROR WIDTH=Fel Bredd'#13+
'WIDTH UNITS=Bredd Enhet'#13+
'PERCENT=Procent'#13+
'LEFT AND RIGHT=Vänster och Höger'#13+
'TOP AND BOTTOM=Topp och Botten'#13+
'BORDER EDITOR=Ändra Kant'#13+
'DASH=Streck'#13+
'DOT=Prick'#13+
'DASH DOT=Streck Prick'#13+
'DASH DOT DOT=Streck Prick Prick'#13+
'CALCULATE EVERY=Beräkna varje'#13+
'ALL POINTS=Alla punkter'#13+
'NUMBER OF POINTS=Antal punkter'#13+
'RANGE OF VALUES=Omfång på värden'#13+
'FIRST=Först'#13+
'LAST=Sist'#13+
'TEEPREVIEW EDITOR=Ändra TeeCharts Förhandsgranskning'#13+
'ALLOW MOVE=Tillåta Flytta'#13+
'ALLOW RESIZE=Tillåta Storleksändra'#13+
'DRAG IMAGE=Dra Bild'#13+
'AS BITMAP=Som Bitmap'#13+
'SHOW IMAGE=Visa Bild'#13+
'MARGINS=Marginal'#13+
'SIZE=Storlek'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Tryck Ihop'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horis. Offset'#13+
'VERT. OFFSET=Vert. Offset'#13+
'PERSPECTIVE=Perspektiv'#13+
'ANGLE=Vinkel'#13+
'ORTHOGONAL=Rektangulär'#13+
'ZOOM TEXT=Zoom Text'#13+
'SCALES=Skala'#13+
'TICKS=Markering'#13+
'MINOR=Mindre'#13+
'MAXIMUM=Maximal'#13+
'MINIMUM=Minimal'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Önskad ökning'#13+
'(INCREMENT)=(ökning)'#13+
'LOG BASE=Log. Bas'#13+
'LOGARITHMIC=Logaritmisk'#13+
'MIN. SEPARATION %=Min. Separation %'#13+
'MULTI-LINE=Flera Linjer'#13+
'LABEL ON AXIS=Etiketter på Axeln'#13+
'ROUND FIRST=Avrunda Första'#13+
'MARK=Markering'#13+
'LABELS FORMAT=Etiketts Format'#13+
'EXPONENTIAL=Exponentiell'#13+
'DEFAULT ALIGNMENT=Standard Inställning'#13+
'LEN=Längd'#13+
'INNER=Inre'#13+
'AT LABELS ONLY=Bara vid Etiketter'#13+
'CENTERED=Centrerad'#13+
'POSITION %=Position %'#13+
'START %=Start %'#13+
'END %=Slut %'#13+
'OTHER SIDE=Andra sidan'#13+
'AXES=Axlar'#13+
'BEHIND=Bakom'#13+
'CLIP POINTS=Klipp Punkter'#13+
'PRINT PREVIEW=Förhandsgranska'#13+
'MINIMUM PIXELS=Min. punkter'#13+
'ALLOW=Tillåt'#13+
'ANIMATED=Animerad'#13+
'ALLOW SCROLL=Tillåt Bläddring'#13+
'TEEOPENGL EDITOR=Ändra TeeOpenGL'#13+
'AMBIENT LIGHT=Omgivande Ljus'#13+
'SHININESS=Blankhet'#13+
'FONT 3D DEPTH=Typsnitt 3D Djup'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Typsnitts Kontur'#13+
'SMOOTH SHADING=Mjuk Skuggning'#13+
'LIGHT=Ljus'#13+
'Y=Y'#13+
'INTENSITY=Intensitet'#13+
'BEVEL=Fas'#13+
'FRAME=Ram'#13+
'ROUND FRAME=Rund Ram'#13+
'LOWERED=Nedsänkt'#13+
'RAISED=Upphöjd'#13+
'SYMBOLS=Symboler'#13+
'TEXT STYLE=Text Stil'#13+
'LEGEND STYLE=Beskrivnings Stil'#13+
'VERT. SPACING=Vert. Mellanrum'#13+
'SERIES NAMES=Series Names'#13+
'SERIES VALUES=Series Values'#13+
'LAST VALUES=Last Values'#13+
'PLAIN=Enkel'#13+
'LEFT VALUE=Vänster Värde'#13+
'RIGHT VALUE=Höger Värde'#13+
'LEFT PERCENT=Vänster Procent'#13+
'RIGHT PERCENT=Höger Procent'#13+
'X VALUE=X Värde'#13+
'X AND Y VALUES=X Y Värde'#13+
'X AND VALUE=X och Värde'#13+
'X AND PERCENT=X och Procent'#13+
'CHECK BOXES=Kontroll boxar'#13+
'DIVIDING LINES=Avgränsande Linjer'#13+
'FONT SERIES COLOR=Färg på Typsnitts Serier'#13+
'POSITION OFFSET %=Position Offset %'#13+
'MARGIN=Marginal'#13+
'RESIZE CHART=Storleksändra Diagram'#13+
'CONTINUOUS=Kontinuerlig'#13+
'POINTS PER PAGE=Punkter per Sida'#13+
'SCALE LAST PAGE=Skala Sista sidan'#13+
'CURRENT PAGE LEGEND=Aktuelll sid beskrivning'#13+
'PANEL EDITOR=Panel Redigerare'#13+
'BACKGROUND=Bakgrund'#13+
'BORDERS=Ramar'#13+
'BACK IMAGE=Bakgrundsbild'#13+
'STRETCH=Sträcka'#13+
'TILE=Utjämnad'#13+
'BEVEL INNER=Fasad Innre'#13+
'BEVEL OUTER=Fasad Yttrer'#13+
'MARKS=Märken'#13+
'DATA SOURCE=Data Källa'#13+
'SORT=Sortering'#13+
'CURSOR=Markör'#13+
'SHOW IN LEGEND=Visa i Beskrivning'#13+
'FORMATS=Format'#13+
'VALUES=Värden'#13+
'PERCENTS=Procent'#13+
'HORIZONTAL AXIS=Horisontell Axel'#13+
'DATETIME=DatumTid'#13+
'VERTICAL AXIS=Vertikal Axel'#13+
'ASCENDING=Stigande'#13+
'DESCENDING=Fallande'#13+
'DRAW EVERY=Rita varje'#13+
'CLIPPED=Nedklippt'#13+
'ARROWS=Pilar'#13+
'MULTI LINE=Flera Linjer'#13+
'ALL SERIES VISIBLE=Alla Serier Synliga'#13+
'LABEL=Etikett'#13+
'LABEL AND PERCENT=Etikett Procent'#13+
'LABEL AND VALUE=Etikett Värde'#13+
'PERCENT TOTAL=Total Procent'#13+
'LABEL AND PERCENT TOTAL=Etikett Total Procent'#13+
'MANUAL=Manuell'#13+
'RANDOM=Slumpvis'#13+
'FUNCTION=Funktion'#13+
'NEW=Ny'#13+
'EDIT=Ändra'#13+
'PERSISTENT=Konstant'#13+
'ADJUST FRAME=Justera Ram'#13+
'SUBTITLE=Undertitel'#13+
'SUBFOOT=Undre Sidfot'#13+
'FOOT=Sidfot'#13+
'VISIBLE WALLS=Synliga Väggar'#13+
'BACK=Bak'#13+
'DIF. LIMIT=Begränsa Skillnad'#13+
'ABOVE=Ovanför'#13+
'WITHIN=Innanför'#13+
'BELOW=Under'#13+
'CONNECTING LINES=Sammanhängande Linjer'#13+
'BROWSE=Sök'#13+
'TILED=Utjämnad'#13+
'INFLATE MARGINS=Öka Marginaler'#13+
'SQUARE=Fyrkant'#13+
'DOWN TRIANGLE=Ner Triangel'#13+
'SMALL DOT=Små Prickar'#13+
'GLOBAL=Global'#13+
'SHAPES=Format'#13+
'BRUSH=Pensel'#13+
'DELAY=Fördröj'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Mus händelse'#13+
'MOVE=Flytta'#13+
'CLICK=Klick'#13+
'DRAW LINE=Rita Linje'#13+
'EXPLODE BIGGEST=Exponera Största'#13+
'TOTAL ANGLE=Vinkel Totalt'#13+
'GROUP SLICES=Grupp Bitar'#13+
'BELOW %=Under %'#13+
'BELOW VALUE=under Värde'#13+
'OTHER=Andra'#13+
'PATTERNS=Mönster'#13+
'SIZE %=Storlek %'#13+
'SERIES DATASOURCE TEXT EDITOR=Seriernas Datakälla Text Redigerare'#13+
'FIELDS=Fält'#13+
'NUMBER OF HEADER LINES=Antal Rubriks Linjer'#13+
'SEPARATOR=Avgränsare'#13+
'COMMA=Komma'#13+
'SPACE=Mellanslag'#13+
'TAB=Tabb'#13+
'FILE=Fil'#13+
'WEB URL=Webb URL'#13+
'LOAD=Ladda'#13+
'C LABELS=C Etikett'#13+
'R LABELS=R Etikett'#13+
'C PEN=C Penna'#13+
'R PEN=R Penna'#13+
'STACK GROUP=Stapla Grupp'#13+
'MULTIPLE BAR=Flera Staplar'#13+
'SIDE=Sida'#13+
'SIDE ALL=Sida vid Sida'#13+
'DRAWING MODE=Ritnings Läge'#13+
'WIREFRAME=Transp.Ram'#13+
'DOTFRAME=PrickRam'#13+
'SMOOTH PALETTE=Mjuk Palett'#13+
'SIDE BRUSH=Sid Pensel'#13+
'ABOUT TEECHART PRO V7.0=Om TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Samtliga Rättigheter Förbehålles.'#13+
'VISIT OUR WEB SITE !=Besök vår hemsida !'#13+
'TEECHART WIZARD=TeeChart Guide'#13+
'SELECT A CHART STYLE=Använd Databas?'#13+
'DATABASE CHART=Diagram med Databas'#13+
'NON DATABASE CHART=Diagram utan Databas'#13+
'SELECT A DATABASE TABLE=Välj en Datatabell'#13+
'ALIAS=Alias'#13+
'TABLE=Tabell'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Välj önskade fält för Diagramet'#13+
'SELECT A TEXT LABELS FIELD=Välj ett Etikettsfält'#13+
'CHOOSE THE DESIRED CHART TYPE=Välj önskad Diagramtyp'#13+
'2D=2D'#13+
'CHART PREVIEW=Diagram Förhandsvisning'#13+
'SHOW LEGEND=Visa Beskrivning'#13+
'SHOW MARKS=Visa Märken'#13+
'< BACK=< Bak'#13+
'EXPORT CHART=Exportera Diagram'#13+
'PICTURE=Bild'#13+
'NATIVE=Ursprung'#13+
'KEEP ASPECT RATIO=Behåll proportioner'#13+
'INCLUDE SERIES DATA=Inkludera Data Serie'#13+
'FILE SIZE=Fil Storlek'#13+
'DELIMITER=Separator'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabell'#13+
'EXCEL=Excel'#13+
'COLON=Kolon'#13+
'INCLUDE=Inkludera'#13+
'POINT LABELS=Punkt Etiketter'#13+
'POINT INDEX=Punkt Index'#13+
'HEADER=Rubrik'#13+
'COPY=Kopiera'#13+
'SAVE=Spara'#13+
'SEND=Sänd'#13+
'FUNCTIONS=Funktioner'#13+
'ADX=ADX'#13+
'AVERAGE=Genomsnitt'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Dividera'#13+
'EXP. AVERAGE=Förv. Medel'#13+
'EXP.MOV.AVRG.=Förv. Rör. Medel'#13+
'MACD=MACD'#13+
'MOMENTUM=Rörelsemängd'#13+
'MOMENTUM DIV=Del Rörelsemängd'#13+
'MOVING AVRG.rörligt Medel'#13+
'MULTIPLY=Multiplicera'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Effektivvärde'#13+
'STD.DEVIATION=Standardavvikelse'#13+
'STOCHASTIC=Stokastisk'#13+
'SUBTRACT=Subtrahera'#13+
'SOURCE SERIES=Käll Serie'#13+
'TEECHART GALLERY=TeeChart Galleri'#13+
'DITHER=Tveka'#13+
'REDUCTION=Reducering'#13+
'COMPRESSION=Kompression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Närmast'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Fönster 20'#13+
'WINDOWS 256=Fönster 256'#13+
'WINDOWS GRAY=Fönster Gray'#13+
'GRAY SCALE=Gråskala'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Kvantisera'#13+
'QUANTIZE 256=Kvantisera 256'#13+
'% QUALITY=% Kvalitet'#13+
'PERFORMANCE=Utförande'#13+
'QUALITY=Kvalitet'#13+
'SPEED=Snabbhet'#13+
'COMPRESSION LEVEL=Komressionsnivå'#13+
'CHART TOOLS GALLERY=Galleri för Diagram Verktyg'#13+
'ANNOTATION=Anteckning'#13+
'AXIS ARROWS=Axel Pilar'#13+
'COLOR BAND=Bild'#13+
'COLOR LINE=Färg Linje'#13+
'DRAG MARKS=Dra Märken'#13+
'MARK TIPS=Närmaste Punkt'#13+
'NEAREST POINT=Närmaste Punkt'#13+
'ROTATE=Rotera'#13+

// 6.0

'BEVEL SIZE=Kant storlek'#13+
'DELETE ROW=Radera rad'#13+
'VOLUME SERIES=Volym serier'#13+
'SINGLE=Enstaka'#13+
'REMOVE CUSTOM COLORS=Radera valfria färger'#13+
'USE PALETTE MINIMUM=Använd minimal palett'#13+
'AXIS MAXIMUM=Axel max'#13+
'AXIS CENTER=Axel centrum'#13+
'AXIS MINIMUM=Axel min'#13+
'DAILY (NONE)=Daglig (ingen)'#13+
'WEEKLY=Veckovis'#13+
'MONTHLY=Månatlig'#13+
'BI-MONTHLY=Varannan månad'#13+
'QUARTERLY=Kvartalsvis'#13+
'YEARLY=Årlig'#13+
'DATETIME PERIOD=Datum/tid period'#13+
'CASE SENSITIVE=Skilljer på versaler och gemener'#13+
'DRAG STYLE=Dra stil'#13+
'SQUARED=Fyrkant'#13+
'GRID 3D SERIES=Serie i 3D rutnät'#13+
'DARK BORDER=Mörk kant'#13+
'PIE SERIES=Tårt serie'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Sprängskiss'#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Diagram från mall (*.tee fil)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Öppna TeeChart mall från'#13+
'BINARY=Binär'#13+
'VOLUME OSCILLATOR=Volym oscillator'#13+
'PIE SLICES=Tårtbitar'#13+
'ARROW WIDTH=Pil bredd'#13+
'ARROW HEIGHT=Pil Höjd'#13+
'DEFAULT COLOR=Standard färg'#13+
'PERIOD=Period'#13+
'SHADOW EDITOR=Skugg Redigerare'#13+
'CALLOUT=Värde Info'#13+
'TEXT ALIGNMENT=Text Placering'#13+
'DISTANCE=Distans'#13+
'ARROW HEAD=Pilhuvud'#13+
'POINTER=Visare'#13+
'AVAILABLE LANGUAGES=Tillgängliga Språk'#13+
'CHOOSE A LANGUAGE=Välj Språk'#13+
'CALCULATE USING=Beräkna med'#13+
'EVERY NUMBER OF POINTS=Varje Antal Punkter'#13+
'EVERY RANGE=Varje Grupp'#13+
'INCLUDE NULL VALUES=Inkludera Blanka Värden'#13+
'DATE=Datum'#13+
'ENTER DATE=Skriv Datum'#13+
'ENTER TIME=Skriv Tid'#13+
'DEVIATION=Avvikelser'#13+
'UPPER=Övre'#13+
'LOWER=Nedre'#13+
'NOTHING=Ingenting'#13+
'LEFT TRIANGLE=Vänster Triangel'#13+
'RIGHT TRIANGLE=Höger Triangel'#13+
'SHOW PREVIOUS BUTTON=Visa Föregående Knapp'#13+
'SHOW NEXT BUTTON=Visa Nästa Knapp'#13+
'CONSTANT=Konstant'#13+
'SHOW LABELS=Visa Etikett'#13+
'SHOW COLORS=Visa Färger'#13+
'XYZ SERIES=XYZ Serier'#13+
'SHOW X VALUES=Visa X Värden'#13+
'ACCUMULATE=Ackumulera'#13+
'STEP=Steg'#13+
'DRAG REPAINT=Dra Uppdatering'#13+
'NO LIMIT DRAG=Ingen Begränsning vid Dra'#13+
'SMOOTH=Mjuk'#13+
'INTERPOLATE=Inflika'#13+
'START X=Start X'#13+
'NUM. POINTS=Ant. Punkter'#13+
'COLOR EACH LINE=Färglägg Varje Linje'#13+
'SORT BY=Sortera med'#13+
'(NONE)=(Ingen)'#13+
'CALCULATION=Beräkning'#13+
'WEIGHT=Vikt'#13+
'EDIT LEGEND=Redigera Beskrivning'#13+
'ROUND=Rund'#13+
'FLAT=Platt'#13+
'DRAW ALL=Rita Alla'#13+
'IGNORE NULLS=Ignorera Blanka'#13+
'OFFSET=Offset'#13+
'Z %=Z %'#13+
'LIGHT 0=Ljus 0'#13+
'LIGHT 1=Ljus 1'#13+
'LIGHT 2=Ljus 2'#13+
'DRAW STYLE=Rit Stil'#13+
'POINTS=Punkter'#13+
'DEFAULT BORDER=Standard Kant'#13+
'SHOW PAGE NUMBER=Visa Sidnummer'#13+
'SEPARATION=Delning'#13+
'ROUND BORDER=Rund Kant'#13+
'NUMBER OF SAMPLE VALUES=Antal Test Värden'#13+
'RESIZE PIXELS TOLERANCE=Ändra Pixeltolerans'#13+
'FULL REPAINT=Full Uppdatering'#13+
'END POINT=Slut Punkt'#13+
'BAND 1=Band 1'#13+
'BAND 2=Band 2'#13+
'TRANSPOSE NOW=Förflytta Nu'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Stapeldiagram'#13+
'EXP. LINE=Uppskattad Linje'#13+
'WEIGHTED=Avvägd'#13+
'WEIGHTED BY INDEX=Avvägd genom Index'#13+
'BOX SIZE=Ram storlek'#13+
'REVERSAL AMOUNT=Omvänd Summa'#13+
'PERCENTAGE=Procentuellt'#13+
'COMPLETE R.M.S.=Komplett Effektivvärde'#13+
'BUTTON=Knapp'#13+
'START AT MIN. VALUE=Starta på Minsta Värdet'#13+
'EXECUTE !=Kör !'#13+
'IMAG. SYMBOL=Bild Symbol'#13+
'SELF STACK=En Stapel'#13+
'SIDE LINES=Sido Linjer'#13+
'EXPORT DIALOG=Export Dialog'#13+
'POINT COLORS=Punkt Färger'#13+
'OUTLINE GRADIENT=Kontur Lutning'#13+
'RADIAL=Radial'#13+
'BALANCE=Balans'#13+
'RADIAL OFFSET=Radial Offset'#13+
'COVER=Täcka'#13+
'VALUE SOURCE=Värde Källa'#13+
'DOWN=Ner'#13+
'GROUP=Grupp'#13
;
  end;
end;

Procedure TeeSetSwedish;
begin
  TeeCreateSwedish;
  TeeLanguage:=TeeSwedishLanguage;
  TeeSwedishConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeSwedishLanguage);
end.
