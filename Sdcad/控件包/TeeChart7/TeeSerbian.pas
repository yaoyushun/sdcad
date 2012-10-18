unit TeeSerbian;   
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeSerbianLanguage:TStringList=nil;

Procedure TeeSetSerbian;
Procedure TeeCreateSerbian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeSerbianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';

  TeeMsg_Test               :='Test...';
  TeeMsg_LegendFirstValue   :='Prva vrednost legende mora biti > 0';
  TeeMsg_LegendColorWidth   :='Obojena širina legende mora biti > 0%';
  TeeMsg_SeriesSetDataSource:='Ne postoji grafik za validaciju izvora podataka';
  TeeMsg_SeriesInvDataSource:='Ne postoji validni izvor podataka: %s';
  TeeMsg_FillSample         :='Vrednosti moraju biti > 0';
  TeeMsg_AxisLogDateTime    :='DatumÈas osa ne može biti logaritamska';
  TeeMsg_AxisLogNotPositive :='Min i Max vrednost logaritamske ose trebaju biti >= 0';
  TeeMsg_AxisLabelSep       :='Procenat odvajanja labela mora biti veæi od 0';
  TeeMsg_AxisIncrementNeg   :='Prirast ose mora biti >= 0';
  TeeMsg_AxisMinMax         :='Minimalna vrednost ose mora biti <= Maksimalne vrednosti';
  TeeMsg_AxisMaxMin         :='Maksimalna vrednost ose mora biti >= Minimalne vrednosti';
  TeeMsg_AxisLogBase        :='Baza logaritamske ose treba biti >= 2';
  TeeMsg_MaxPointsPerPage   :='Maksimalni broj taèaka po strani mora biti >= 0';
  TeeMsg_3dPercent          :='Procenat 3D efekta mora biti izmedju %d i %d';
  TeeMsg_CircularSeries     :='Cirkularne zavisnosti izmedju serija nisu dozvoljene';
  TeeMsg_WarningHiColor     :='16k ili veæa kolor paleta je neophodna za bolji izgled';

  TeeMsg_DefaultPercentOf   :='%s od %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'od %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Naslov ose';
  TeeMsg_AxisLabels         :='Oznake ose';
  TeeMsg_RefreshInterval    :='Interval osvežavanja mora biti izmedju 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart nije myself!';
  TeeMsg_GalleryLine        :='Linija';
  TeeMsg_GalleryPoint       :='Taèka';
  TeeMsg_GalleryArea        :='Podruèje';
  TeeMsg_GalleryBar         :='Stub';
  TeeMsg_GalleryHorizBar    :='Horiz. Stub';
  TeeMsg_Stack              :='Red';
  TeeMsg_GalleryPie         :='Kolaè';
  TeeMsg_GalleryCircled     :='Kružno';
  TeeMsg_GalleryFastLine    :='Brza linija';
  TeeMsg_GalleryHorizLine   :='Horiz. linija';

  TeeMsg_PieSample1         :='Automobili';
  TeeMsg_PieSample2         :='Telefoni';
  TeeMsg_PieSample3         :='Tabele';
  TeeMsg_PieSample4         :='Monitori';
  TeeMsg_PieSample5         :='Lampe';
  TeeMsg_PieSample6         :='Tastature';
  TeeMsg_PieSample7         :='Bicikli';
  TeeMsg_PieSample8         :='Stolice';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editovanje %s';

  TeeMsg_GalleryStandard    :='Klasièno';
  TeeMsg_GalleryExtended    :='Prošireno';
  TeeMsg_GalleryFunctions   :='Funkcije';

  TeeMsg_EditChart          :='E&ditovanje grafika...';
  TeeMsg_PrintPreview       :='&Pregled štampe...';
  TeeMsg_ExportChart        :='E&ksportuj grafik...';
  TeeMsg_CustomAxes         :='Korisnièke ose...';

  TeeMsg_InvalidEditorClass :='%s: Nepostojeæa Editor klasa: %s';
  TeeMsg_MissingEditorClass :='%s: nema Editor dijaloga';

  TeeMsg_GalleryArrow       :='Strelica';

  TeeMsg_ExpFinish          :='&Završi';
  TeeMsg_ExpNext            :='&Napred >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Dizajn';
  TeeMsg_GanttSample2       :='Prototip';
  TeeMsg_GanttSample3       :='Razvoj';
  TeeMsg_GanttSample4       :='Prodaja';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testiranje';
  TeeMsg_GanttSample7       :='Proizvodnja';
  TeeMsg_GanttSample8       :='Debagovanje';
  TeeMsg_GanttSample9       :='Nova verzija';
  TeeMsg_GanttSample10      :='Bankarstvo';

  TeeMsg_ChangeSeriesTitle  :='Promeni naslov serije';
  TeeMsg_NewSeriesTitle     :='Novi naslov serije:';
  TeeMsg_DateTime           :='DatumÈas';
  TeeMsg_TopAxis            :='Gornja osa';
  TeeMsg_BottomAxis         :='Donja osa';
  TeeMsg_LeftAxis           :='Leva osa';
  TeeMsg_RightAxis          :='Desna osa';

  TeeMsg_SureToDelete       :='Briši %s ?';
  TeeMsg_DateTimeFormat     :='DatumÈas for&mat:';
  TeeMsg_Default            :='Podrazumevano';
  TeeMsg_ValuesFormat       :='For&mat vrednosti:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Željeni %s prirast';

  TeeMsg_IncorrectMaxMinValue:='Nekorektna vrednost. Razlog: %s';
  TeeMsg_EnterDateTime      :='Unesi [Broj dana] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Primeni promene ?';
  TeeMsg_SelectedSeries     :='(Selektovane serije)';
  TeeMsg_RefreshData        :='&Osveži podatke';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Dodaj';
  TeeMsg_FunctionSubtract   :='Oduzmi';
  TeeMsg_FunctionMultiply   :='Pomnoži';
  TeeMsg_FunctionDivide     :='Podeli';
  TeeMsg_FunctionHigh       :='Gornje';
  TeeMsg_FunctionLow        :='Donje';
  TeeMsg_FunctionAverage    :='Prosek';

  TeeMsg_GalleryShape       :='Oblik';
  TeeMsg_GalleryBubble      :='Balon';
  TeeMsg_FunctionNone       :='Kopiraj';

  TeeMsg_None               :='(ništa)';

  TeeMsg_PrivateDeclarations:='{ Privatne deklaracije }';
  TeeMsg_PublicDeclarations :='{ Javne deklaracije }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Velièina pokazivaèa mora biti veæa od nule';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatno';
  tcDControls               :='Kontrole podataka';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Skup podataka';
  TeeMsg_AskDataSet         :='Skup po&dataka:';

  TeeMsg_SingleRecord       :='Jedan slog';
  TeeMsg_AskDataSource      :='Izvor po&dataka:';

  TeeMsg_Summary            :='Sumiranje';

  TeeMsg_FunctionPeriod     :='Period funkcije treba biti >= 0';

  TeeMsg_WizardTab          :='Posao';
  TeeMsg_TeeChartWizard     :='TeeChart Èarobljak';

  TeeMsg_ClearImage         :='Isp&razni';
  TeeMsg_BrowseImage        :='P&regled...';

  TeeMsg_WizardSureToClose  :='Da li ste sigurni da želite da zatvorite TeeChart èarobnjaka ?';
  TeeMsg_FieldNotFound      :='Polje %s ne postoji';

  TeeMsg_DepthAxis          :='Dubina ose';
  TeeMsg_PieOther           :='Ostalo';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Kolaè';
  TeeMsg_ValuesBar          :='Traka';
  TeeMsg_ValuesAngle        :='Ugao';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Kraj';
  TeeMsg_ValuesGanttNextTask:='SledeæiZadatak';
  TeeMsg_ValuesBubbleRadius :='Radijus';
  TeeMsg_ValuesArrowEndX    :='KrajnjeX';
  TeeMsg_ValuesArrowEndY    :='KrajnjeY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Naslov';
  TeeMsg_Foot               :='Podnožje';
  TeeMsg_Period		    :='Period';
  TeeMsg_PeriodRange        :='Opseg perioda';
  TeeMsg_CalcPeriod         :='Izraèunaj %s svaki:';
  TeeMsg_SmallDotsPen       :='Male taèke';

  TeeMsg_InvalidTeeFile     :='Nepostojeæi grafik u *.'+TeeMsg_TeeExtension+' datoteci';
  TeeMsg_WrongTeeFileFormat :='Pogrešan *.'+TeeMsg_TeeExtension+' format datoteke';
  TeeMsg_EmptyTeeFile       :='Prazna *.'+TeeMsg_TeeExtension+' datoteka';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Ose grafika';
  TeeMsg_ChartAxesCategoryDesc   := 'Osobine i dogadjaji osa grafika';
  TeeMsg_ChartWallsCategoryName  := 'Zidovi grafika';
  TeeMsg_ChartWallsCategoryDesc  := 'Osobine i dogadjaji zidova grafika';
  TeeMsg_ChartTitlesCategoryName := 'Naslovi grafika';
  TeeMsg_ChartTitlesCategoryDesc := 'Osobine i dogadjaji naslova grafika';
  TeeMsg_Chart3DCategoryName     := '3D grafik';
  TeeMsg_Chart3DCategoryDesc     := 'Osobine i dogadjaji 3D grafika';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Korisnièki ';
  TeeMsg_Series                 :='Serije';
  TeeMsg_SeriesList             :='Serije...';

  TeeMsg_PageOfPages            :='Strana %d od %d';
  TeeMsg_FileSize               :='%d bajtova';

  TeeMsg_First  :='Prvi';
  TeeMsg_Prior  :='Prethodni';
  TeeMsg_Next   :='Sledeæi';
  TeeMsg_Last   :='Poslednji';
  TeeMsg_Insert :='Insertuj';
  TeeMsg_Delete :='Obriši';
  TeeMsg_Edit   :='Edituj';
  TeeMsg_Post   :='Snimi';
  TeeMsg_Cancel :='Prekini';

  TeeMsg_All    :='(sve)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='kao &Bitmapa';
  TeeMsg_BMPFilter    :='Bitmape (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='kao &Metafile';
  TeeMsg_EMFFilter    :='proširene Meta datoteke (*.emf)|*.emf|Meta datoteke (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Osobina panela nije podešena u eksport formatu';

  TeeMsg_Normal    :='Normalno';
  TeeMsg_NoBorder  :='Bez okvira';
  TeeMsg_Dotted    :='Taèkasto';
  TeeMsg_Colors    :='Boje';
  TeeMsg_Filled    :='Popunjeno';
  TeeMsg_Marks     :='Oznake';
  TeeMsg_Stairs    :='Zvezde';
  TeeMsg_Points    :='Taèke';
  TeeMsg_Height    :='Visina';
  TeeMsg_Hollow    :='Prazno';
  TeeMsg_Point2D   :='2D taèka';
  TeeMsg_Triangle  :='Trougao';
  TeeMsg_Star      :='Zvezda';
  TeeMsg_Circle    :='Krug';
  TeeMsg_DownTri   :='Trougao dole';
  TeeMsg_Cross     :='Krst';
  TeeMsg_Diamond   :='Dijamant';
  TeeMsg_NoLines   :='Bez linija';
  TeeMsg_Stack100  :='Red 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Inv. piramida';
  TeeMsg_Sides     :='Strane';
  TeeMsg_SideAll   :='Sve strane';
  TeeMsg_Patterns  :='Uzorci';
  TeeMsg_Exploded  :='Rastureno';
  TeeMsg_Shadow    :='Senka';
  TeeMsg_SemiPie   :='Polu torta';
  TeeMsg_Rectangle :='Pravougaonik';
  TeeMsg_VertLine  :='Vert.linija';
  TeeMsg_HorizLine :='Horiz.linija';
  TeeMsg_Line      :='Linija';
  TeeMsg_Cube      :='Kocka';
  TeeMsg_DiagCross :='Diag.Krst';

  TeeMsg_CanNotFindTempPath    :='Ne mogu da nadjem privremeni direktorijum';
  TeeMsg_CanNotCreateTempChart :='Ne mogu da kreiram privremenu datoteku';
  TeeMsg_CanNotEmailChart      :='Ne mogu da pošaljem TeeChart poruku. Mapi greška: %d';

  TeeMsg_SeriesDelete :='Brisanje serije: Vrednost indeksa %d izvan opsega (0 do %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='kao &JPEG';
  TeeMsg_JPEGFilter    :='JPEG datoteke (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='kao &GIF';
  TeeMsg_GIFFilter     :='GIF datoteke (*.gif)|*.gif';
  TeeMsg_AsPNG         :='kao &PNG';
  TeeMsg_PNGFilter     :='PNG datoteke (*.png)|*.png';
  TeeMsg_AsPCX         :='kao PC&X';
  TeeMsg_PCXFilter     :='PCX datoteke (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='kao &VML (HTM)';
  TeeMsg_VMLFilter     :='VML datoteke (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Jezik...';

  { 5.03 }
  TeeMsg_Gradient     :='Preliv';
  TeeMsg_WantToSave   :='Da li želite da snimite %s?';
  TeeMsg_NativeFilter :='TeeChart datoteke '+TeeDefaultFilterExtension;

  TeeMsg_Property     :='Osobina';	
  TeeMsg_Value        :='Vrednost';
  TeeMsg_Yes          :='Da';
  TeeMsg_No           :='Ne';
  TeeMsg_Image        :='(slika)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polarno';
  TeeMsg_GalleryCandle      :='Sveæa';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Površina';
  TeeMsg_GalleryContour     :='Kontura';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D taèka';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Krofna';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='3D stub';
  TeeMsg_GalleryBigCandle   :='Velika sveæa';
  TeeMsg_GalleryLinePoint   :='Linijska taèka';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Vodopad';
  TeeMsg_GalleryWindRose    :='Ruža vetrova';
  TeeMsg_GalleryClock       :='Sat';
  TeeMsg_GalleryColorGrid   :='KolorMreža';
  TeeMsg_GalleryBoxPlot     :='Boks Crtež';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.Boks Crtež';
  TeeMsg_GalleryBarJoin     :='Udruženi stupci';
  TeeMsg_GallerySmith       :='Potkovica';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='Stepen polinoma mora biti izmedju 1 i 20';
  TeeMsg_AnswerVectorIndex   :='Indeks rezultujuæeg vektora mora biti izmedju 1 i %d';
  TeeMsg_FittingError        :='Ne mogu da uradim podešavanje';
  TeeMsg_PeriodRange         :='Period mora biti >= 0';
  TeeMsg_ExpAverageWeight    :='Eksp.Prosek težine mora biti izmedju 0 i 1';
  TeeMsg_GalleryErrorBar     :='Traka greške';
  TeeMsg_GalleryError        :='Greška';
  TeeMsg_GalleryHighLow      :='Visoko-Nisko';
  TeeMsg_FunctionMomentum    :='Moment';
  TeeMsg_FunctionMomentumDiv :='Podela Momenta';
  TeeMsg_FunctionExpAverage  :='Eksp. prosek';
  TeeMsg_FunctionMovingAverage:='Pomeranje Pros.';
  TeeMsg_FunctionExpMovAve   :='Eksp.Pom.Pros.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ugaono podešavanje';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Eksp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulativno';
  TeeMsg_FunctionStdDeviation:='Std.Devijacija';
  TeeMsg_FunctionBollinger   :='Delitelj';
  TeeMsg_FunctionRMS         :='Root Mean Kv.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stohastik';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Broj';
  TeeMsg_LoadChart           :='Otvori TeeChart...';
  TeeMsg_SaveChart           :='Snimi TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro datoteke';

  TeeMsg_GallerySamples      :='Ostalo';
  TeeMsg_GalleryStats        :='Statistika';

  TeeMsg_CannotFindEditor    :='Ne mogu da nadjem formular editora serije: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod greške: %d prilikom preuzimanja grafika sa URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod greške: %d prilikom preuzimanja podataka serija sa URL: %s';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Otvori';
  TeeMsg_ValuesHigh          :='Visoko';
  TeeMsg_ValuesLow           :='Nisko';
  TeeMsg_ValuesClose         :='Zatvori';
  TeeMsg_ValuesOffset        :='Ofset';
  TeeMsg_ValuesStdError      :='StdGreška';

  TeeMsg_Grid3D              :='3D tabela';

  TeeMsg_LowBezierPoints     :='Broj Bezier taèaka treba biti > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalno';
  TeeCommanMsg_Edit     :='Edituj';
  TeeCommanMsg_Print    :='Štampaj';
  TeeCommanMsg_Copy     :='Kopiraj';
  TeeCommanMsg_Save     :='Snimi';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotacija: %d° Elevacija: %d°';
  TeeCommanMsg_Rotate   :='Rotiraj';

  TeeCommanMsg_Moving   :='Horiz.Ofset: %d Vert.Ofset: %d';
  TeeCommanMsg_Move     :='Pomeri';

  TeeCommanMsg_Zooming  :='Uveæanje: %d %%';
  TeeCommanMsg_Zoom     :='Uveæaj';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Dubina';

  TeeCommanMsg_Chart    :='Grafik';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Pomeri %s za rotiranje';
  TeeCommanMsg_MoveLabel  :='Pomeri %s za pomeranje';
  TeeCommanMsg_ZoomLabel  :='Pomeri %s za uveæanje';
  TeeCommanMsg_DepthLabel :='Pomeri %s za 3D promenu';

  TeeCommanMsg_NormalLabel:='Pomeri levo dugme za uveæanje, desno dugme za listanje';
  TeeCommanMsg_NormalPieLabel:='Pomeri parèe pite da se rasturi';

  TeeCommanMsg_PieExploding :='Komad: %d Rastureno: %d %%';

  TeeMsg_TriSurfaceLess        :='Broj taèaka mora biti >= 4';
  TeeMsg_TriSurfaceAllColinear :='Sve kolinearne taèke podataka';
  TeeMsg_TriSurfaceSimilar     :='Sliène taèke - ne mogu da izvršim';
  TeeMsg_GalleryTriSurface     :='Trougaona povr.';

  TeeMsg_AllSeries :='Sve serije';
  TeeMsg_Edit      :='Edituj';

  TeeMsg_GalleryFinancial    :='Finansijsko';

  TeeMsg_CursorTool    :='Kursor';
  TeeMsg_DragMarksTool :='Pomeri oznake';
  TeeMsg_AxisArrowTool :='Strelice ose';
  TeeMsg_DrawLineTool  :='Crtaj liniju';
  TeeMsg_NearestTool   :='Najbliža taèka';
  TeeMsg_ColorBandTool :='Boja trake';
  TeeMsg_ColorLineTool :='Boja linije';
  TeeMsg_RotateTool    :='Rotiraj';
  TeeMsg_ImageTool     :='Slika';
  TeeMsg_MarksTipTool  :='Oznaèi vrhove';
  TeeMsg_AnnotationTool:='Napomena';

  TeeMsg_CantDeleteAncestor  :='Can not delete ancestor';

  TeeMsg_Load	          :='Uèitaj...';
  TeeMsg_NoSeriesSelected :='Nije selektovana serija';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafik';
  TeeMsg_CategorySeriesActions :='Serije grafika';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Prebaci 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktivno';
  TeeMsg_ActionSeriesActiveHint := 'Prikaži / Sakrij seriju';
  TeeMsg_ActionEditHint         := 'Edituj grafik';
  TeeMsg_ActionEdit             := '&Edituj...';
  TeeMsg_ActionCopyHint         := 'Kopiraj na Clipboard';
  TeeMsg_ActionCopy             := '&Kopiraj';
  TeeMsg_ActionPrintHint        := 'Prikaži pregled grafika';
  TeeMsg_ActionPrint            := 'Štam&paj...';
  TeeMsg_ActionAxesHint         := 'Prikaži / Sakrij ose';
  TeeMsg_ActionAxes             := '&Ose';
  TeeMsg_ActionGridsHint        := 'Prikaži / Sakrij linije';
  TeeMsg_ActionGrids            := '&Linije';
  TeeMsg_ActionLegendHint       := 'Prikaži / Sakrij legendu';
  TeeMsg_ActionLegend           := '&Legenda';
  TeeMsg_ActionSeriesEditHint   := 'Edituj Serije';
  TeeMsg_ActionSeriesMarksHint  := 'Prikaži / Sakrij serijske oznake';
  TeeMsg_ActionSeriesMarks      := 'Oz&nake';
  TeeMsg_ActionSaveHint         := 'Snimi grafik';
  TeeMsg_ActionSave             := '&Snimi...';

  TeeMsg_CandleBar              := 'Traka';
  TeeMsg_CandleNoOpen           := 'Nema otvaranja';
  TeeMsg_CandleNoClose          := 'Nema zatvaranja';
  TeeMsg_NoHigh                 := 'Nema visokog';
  TeeMsg_NoLow                  := 'Nema niskog';
  TeeMsg_ColorRange             := 'Kolor opseg';
  TeeMsg_WireFrame              := 'Žièano';
  TeeMsg_DotFrame               := 'Taèkasti okvir';
  TeeMsg_Positions              := 'Pozicije';
  TeeMsg_NoGrid                 := 'Nema tabele';
  TeeMsg_NoPoint                := 'Nema taèke';
  TeeMsg_NoLine                 := 'Nema linije';
  TeeMsg_Labels                 := 'Oznake';
  TeeMsg_NoCircle               := 'Nema kruga';
  TeeMsg_Lines                  := 'Linije';
  TeeMsg_Border                 := 'Okvir';

  TeeMsg_SmithResistance      := 'Otpor';
  TeeMsg_SmithReactance       := 'Reaktansa';

  TeeMsg_Column               := 'Kolona';

  { 5.01 }
  TeeMsg_Separator            := 'Separator';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Levak';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Prevazilazi kvotu';
  TeeMsg_FunnelWithin         := ' u kvoti';
  TeeMsg_FunnelBelow          := ' ili ispod kvote';
  TeeMsg_CalendarSeries       := 'Kalendar';
  TeeMsg_DeltaPointSeries     := 'DeltaTaèka';
  TeeMsg_ImagePointSeries     := 'SlikaTaèka';
  TeeMsg_ImageBarSeries       := 'SlikaStub';
  TeeMsg_SeriesTextFieldZero  := 'Tekst serije: Indeks polja treba biti veæi od nule.';

  { 5.02 }
  TeeMsg_Origin               := 'Poèetak';
  TeeMsg_Transparency         := 'Providnost';
  TeeMsg_Box		      := 'Kutija';
  TeeMsg_ExtrOut	      := 'EkstraIzlaz';
  TeeMsg_MildOut	      := 'BlagiIzlaz';
  TeeMsg_PageNumber	      := 'Broj strane';
  TeeMsg_TextFile             := 'Tekst datoteka';

  { 5.03 }
  TeeMsg_DragPoint            := 'Pomeri taèku';
  TeeMsg_OpportunityValues    := 'Vrednosti prilike';
  TeeMsg_QuoteValues          := 'Vrednosti kvote';
end;

Procedure TeeCreateSerbian;
begin
  if not Assigned(TeeSerbianLanguage) then
  begin
    TeeSerbianLanguage:=TStringList.Create;
    TeeSerbianLanguage.Text:=

'LABELS=Natpisi'+#13+
'DATASET=Skup podataka'+#13+
'ALL RIGHTS RESERVED.=Sva prava zadržana.'+#13+
'APPLY=Primeni'+#13+
'CLOSE=Zatvori'+#13+
'OK=OK'+#13+
'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0'+#13+
'OPTIONS=Opcije'+#13+
'FORMAT=Format'+#13+
'TEXT=Tekst'+#13+
'GRADIENT=Preliv'+#13+
'SHADOW=Senka'+#13+
'POSITION=Pozicija'+#13+
'LEFT=Levo'+#13+
'TOP=Gore'+#13+
'CUSTOM=Korisnièki'+#13+
'PEN=Olovka'+#13+
'PATTERN=Uzorak'+#13+
'SIZE=Velièina'+#13+
'BEVEL=Nivo'+#13+
'INVERTED=Obrnuto'+#13+
'INVERTED SCROLL=Obrnuto pomeranje'+#13+
'BORDER=Okvir'+#13+
'ORIGIN=Poèetak'+#13+
'USE ORIGIN=Koristi poèetak'+#13+
'AREA LINES=Linije podruèja'+#13+
'AREA=Podruèje'+#13+
'COLOR=Boja'+#13+
'SERIES=Serija'+#13+
'SUM=Suma'+#13+
'DAY=Dan'+#13+
'QUARTER=Tromeseèje'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Vidljivo'+#13+
'CURSOR=Kursor'+#13+
'GLOBAL=Globalno'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Horiz. Linija'+#13+
'LABEL AND PERCENT=Natpis i procenat'+#13+
'LABEL AND VALUE=Natpis i vrednost'+#13+
'LABEL AND PERCENT TOTAL=Natpis i ukupni procenat'+#13+
'PERCENT TOTAL=Ukupni procenat'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Oduzni'+#13+
'MULTIPLY=Pomnoži'+#13+
'DIVIDE=Podeli'+#13+
'STAIRS=Zvezde'+#13+
'MOMENTUM=Moment'+#13+
'AVERAGE=Prosek'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML Tabela'+#13+
'EXCEL=Excel'+#13+
'NONE=Ništa'+#13+
'(NONE)=Ništa'#13+
'WIDTH=Širina'+#13+
'HEIGHT=Visina'+#13+
'COLOR EACH=Oboji svako'+#13+
'STACK=Niz'+#13+
'STACKED=Nanizano'+#13+
'STACKED 100%=Nanizano 100%'+#13+
'AXIS=Ose'+#13+
'LENGTH=Dužina'+#13+
'CANCEL=Prekini'+#13+
'SCROLL=Pomeranje'+#13+
'INCREMENT=Priraštaj'+#13+
'VALUE=Vrednost'+#13+
'STYLE=Stil'+#13+
'JOIN=Unija'+#13+
'AXIS INCREMENT=Priraštaj ose'+#13+
'AXIS MAXIMUM AND MINIMUM=Osni minimum i maksimum'+#13+
'% BAR WIDTH=% širine stuba'+#13+
'% BAR OFFSET=% pomeraja stuba'+#13+
'BAR SIDE MARGINS=Bocne strane stuba'+#13+
'AUTO MARK POSITION=Polozaj auto. oznaka'+#13+
'DARK BAR 3D SIDES=Tamne strane 3D stuba'+#13+
'MONOCHROME=Crno/belo'+#13+
'COLORS=Boje'+#13+
'DEFAULT=Podrazumevano'+#13+
'MEDIAN=Sredina'+#13+
'IMAGE=Slika'+#13+
'DAYS=Dani'+#13+
'WEEKDAYS=Radni dani'+#13+
'TODAY=Danas'+#13+
'SUNDAY=Nedelja'+#13+
'MONTHS=Meseci'+#13+
'LINES=Linije'+#13+
'UPPERCASE=Velika slova'+#13+
'STICK=Palica'+#13+
'CANDLE WIDTH=Širina palice'+#13+
'BAR=Stub'+#13+
'OPEN CLOSE=Otvoreno/zatvoreno'+#13+
'DRAW 3D=Crtaj 3D'+#13+
'DARK 3D=Tamno 3D'+#13+
'SHOW OPEN=Otvoren prikaz'+#13+
'SHOW CLOSE=Zatvoren prikaz'+#13+
'UP CLOSE=Zatvoreno gore'+#13+
'DOWN CLOSE=Zatvoreno dole'+#13+
'CIRCLED=Kružno'+#13+
'CIRCLE=Krug'+#13+
'3 DIMENSIONS=3 dimenzije'+#13+
'ROTATION=Rotacija'+#13+
'RADIUS=Radijus'+#13+
'HOURS=Sati'+#13+
'HOUR=Sat'+#13+
'MINUTES=Minuti'+#13+
'SECONDS=Sekunde'+#13+
'FONT=Pismo'+#13+
'INSIDE=Unutra'+#13+
'ROTATED=Rotirano'+#13+
'ROMAN=Rimski'+#13+
'TRANSPARENCY=Providnost'+#13+
'DRAW BEHIND=Crtaj pozadi'+#13+
'RANGE=Opseg'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Koraci'+#13+
'GRID=Mreža'+#13+
'GRID SIZE=Velièina mreže'+#13+
'ALLOW DRAG=Dozvoli pomeranje'+#13+
'AUTOMATIC=Automatski'+#13+
'LEVEL=Nivo'+#13+
'LEVELS POSITION=Pozicija nivoa'+#13+
'SNAP=Prisloni'+#13+
'FOLLOW MOUSE=Sledi miša'+#13+
'TRANSPARENT=Providno'+#13+
'ROUND FRAME=Zaobljeni okvir'+#13+
'FRAME=Okvir'+#13+
'START=Start'+#13+
'END=Kraj'+#13+
'MIDDLE=Sredina'+#13+
'NO MIDDLE=Nema sredine'+#13+
'DIRECTION=Smer'+#13+
'DATASOURCE=Izvor podataka'+#13+
'AVAILABLE=Dostupno'+#13+
'SELECTED=Selektovano'+#13+
'CALC=Izraèunaj'+#13+
'GROUP BY=Grupiši po'+#13+
'OF=od'+#13+
'HOLE %=Rupa %'+#13+
'RESET POSITIONS=Resetuj poziciju'+#13+
'MOUSE BUTTON=Dugme miša'+#13+
'ENABLE DRAWING=Ukljuèi crtanje'+#13+
'ENABLE SELECT=Ukljuèi selektovanje'+#13+
'ORTHOGONAL=Ortogonalno'+#13+
'ANGLE=Ugao'+#13+
'ZOOM TEXT=Uveæanje teksta'+#13+
'PERSPECTIVE=Perspektiva'+#13+
'ZOOM=Uveæanje'+#13+
'ELEVATION=Elevacija'+#13+
'BEHIND=Iza'+#13+
'AXES=Ose'+#13+
'SCALES=Skale'+#13+
'TITLE=Naslov'+#13+
'TICKS=Otkucaji'+#13+
'MINOR=Najmanji'+#13+
'CENTERED=Centrirano'+#13+
'CENTER=Centar'+#13+
'PATTERN COLOR EDITOR=Editor uzoraka'+#13+
'START VALUE=Startna vrednost'+#13+
'END VALUE=Krajnja vrednost'+#13+
'COLOR MODE=Režim boje'+#13+
'LINE MODE=Režim linije'+#13+
'HEIGHT 3D=Visina 3D'+#13+
'OUTLINE=Ivica'+#13+
'PRINT PREVIEW=Predštampanje'+#13+
'ANIMATED=Animirano'+#13+
'ALLOW=Dozvoli'+#13+
'DASH=Crtica'+#13+
'DOT=Taèka'+#13+
'DASH DOT DOT=Crtica taèka taèka'+#13+
'PALE=Bledo'+#13+
'STRONG=Snažno'+#13+
'WIDTH UNITS=Jedinica širine'+#13+
'FOOT=Nožje'+#13+
'SUBFOOT=Podnožje'+#13+
'SUBTITLE=Podnaslov'+#13+
'LEGEND=Legenda'+#13+
'COLON=Kolona'+#13+
'AXIS ORIGIN=Poèetak ose'+#13+
'UNITS=Jedinice'+#13+
'PYRAMID=Piramida'+#13+
'DIAMOND=Dijamant'+#13+
'CUBE=Kocka'+#13+
'TRIANGLE=Trougao'+#13+
'STAR=Zvezda'+#13+
'SQUARE=Kvadrat'+#13+
'DOWN TRIANGLE=Trougao dole'+#13+
'SMALL DOT=Mala taèka'+#13+
'LOAD=Uèitaj'+#13+
'FILE=Datoteka'+#13+
'RECTANGLE=Pravougaonik'+#13+
'HEADER=Zaglavlje'+#13+
'CLEAR=Isprazni'+#13+
'ONE HOUR=Jedan sat'+#13+
'ONE YEAR=Jedna godina'+#13+
'ELLIPSE=Elipsa'+#13+
'CONE=Konus'+#13+
'ARROW=Strelica'+#13+
'CYLLINDER=Cilindar'+#13+
'TIME=Vreme'+#13+
'BRUSH=Èetka'+#13+
'LINE=Linija'+#13+
'VERTICAL LINE=Vertikalna linija'+#13+
'AXIS ARROWS=Osne strelice'+#13+
'MARK TIPS=Oznake vrhova'+#13+
'DASH DOT=Crtica taèka'+#13+
'COLOR BAND=Obojena traka'+#13+
'COLOR LINE=Obojena linija'+#13+
'INVERT. TRIANGLE=Obrn. trougao'+#13+
'INVERT. PYRAMID=Obrn. piramida'+#13+
'INVERTED PYRAMID=Obrnuta piramida'+#13+
'SERIES DATASOURCE TEXT EDITOR=Tekst editor izvora podataka serije'+#13+
'SOLID=Celo'+#13+
'WIREFRAME=Žièano'+#13+
'DOTFRAME=Taèkasto'+#13+
'SIDE BRUSH=Boèna èetka'+#13+
'SIDE=Strana'+#13+
'SIDE ALL=Sve strane'+#13+
'ROTATE=Rotiraj'+#13+
'SMOOTH PALETTE=Glatka paleta'+#13+
'CHART TOOLS GALLERY=Galerija alata grafika'+#13+
'ADD=Dodaj'+#13+
'BORDER EDITOR=Editor okvira'+#13+
'DRAWING MODE=Režim crtanja'+#13+
'CLOSE CIRCLE=Zatvoreni krug'+#13+
'PICTURE=Slika'+#13+
'NATIVE=Prirodno'+#13+
'DATA=Podaci'+#13+
'KEEP ASPECT RATIO=Saèuvaj proporciju'+#13+
'COPY=Kopiraj'+#13+
'SAVE=Snimi'+#13+
'SEND=Pošalji'+#13+
'INCLUDE SERIES DATA=Ukljuèi podatke serije'+#13+
'FILE SIZE=Velièina datoteke'+#13+
'INCLUDE=Ukljuèi'+#13+
'POINT INDEX=Indeks taèke'+#13+
'POINT LABELS=Natpis taèke'+#13+
'DELIMITER=Graniènik'+#13+
'DEPTH=Dubina'+#13+
'COMPRESSION LEVEL=Nivo kompresije'+#13+
'COMPRESSION=Kompresija'+#13+
'PATTERNS=Uzorak'+#13+
'LABEL=Natpis'+#13+
'GROUP SLICES=Grupa komada'+#13+
'EXPLODE BIGGEST=Rasturi najveæi'+#13+
'TOTAL ANGLE=Ukupan ugao'+#13+
'HORIZ. SIZE=Horiz. velièina'+#13+
'VERT. SIZE=Vert. velièina'+#13+
'SHAPES=Oblici'+#13+
'INFLATE MARGINS=Uveæaj margine'+#13+
'QUALITY=Kvalitet'+#13+
'SPEED=Brzina'+#13+
'% QUALITY=% Kvaliteta'+#13+
'GRAY SCALE=Siva skala'+#13+
'PERFORMANCE=Performansa'+#13+
'BROWSE=Selektuj'+#13+
'TILED=Mozaik'+#13+
'HIGH=Visoko'+#13+
'LOW=Nisko'+#13+
'DATABASE CHART=Grafik baze podataka'+#13+
'NON DATABASE CHART=Grafik bez baze podataka'+#13+
'HELP=Pomoæ'+#13+
'NEXT >=Napred >'+#13+
'< BACK=< Nazad'+#13+
'TEECHART WIZARD=TeeChart èarobnjak'+#13+
'PERCENT=Procenat'+#13+
'PIXELS=Taèke'+#13+
'ERROR WIDTH=Širina greške'+#13+
'ENHANCED=Napredno'+#13+
'VISIBLE WALLS=Vidljivi zidovi'+#13+
'ACTIVE=Aktivno'+#13+
'DELETE=Briši'+#13+
'ALIGNMENT=Poravnanje'+#13+
'ADJUST FRAME=Prilagodi okvir'+#13+
'HORIZONTAL=Horizontalno'+#13+
'VERTICAL=Vertikalno'+#13+
'VERTICAL POSITION=Vertikalna pozicija'+#13+
'NUMBER=Broj'+#13+
'LEVELS=Nivoi'+#13+
'OVERLAP=Prekrivanje'+#13+
'STACK 100%=Niz 100%'+#13+
'MOVE=Pomeri'+#13+
'CLICK=Klik'+#13+
'DELAY=Zakasni'+#13+
'DRAW LINE=Crtaj liniju'+#13+
'FUNCTIONS=Funkcije'+#13+
'SOURCE SERIES=Izvori serija'+#13+
'ABOVE=Iznad'+#13+
'BELOW=Ispod'+#13+
'Dif. Limit=Raz. limita'+#13+
'WITHIN=iz'+#13+
'EXTENDED=Prošireno'+#13+
'STANDARD=Standardno'+#13+
'STATS=Statistika'+#13+
'FINANCIAL=Finansijsko'+#13+
'OTHER=Ostalo'+#13+
'TEECHART GALLERY=TeeChart galerija'+#13+
'CONNECTING LINES=Linije veza'+#13+
'REDUCTION=Redukcija'+#13+
'LIGHT=Svetlo'+#13+
'INTENSITY=Intenzitet'+#13+
'FONT OUTLINES=Okvir pisma'+#13+
'SMOOTH SHADING=Glatko senèenje'+#13+
'AMBIENT LIGHT=Svetlo okoline'+#13+
'MOUSE ACTION=Akcija miša'+#13+
'CLOCKWISE=U smeru kazaljki'+#13+
'ANGLE INCREMENT=Priraštaj ugla'+#13+
'RADIUS INCREMENT=Priraštaj radijusa'+#13+
'PRINTER=Štampaè'+#13+
'SETUP=Podešavanje'+#13+
'ORIENTATION=Orijentacija'+#13+
'PORTRAIT=Vertikalno'+#13+
'LANDSCAPE=Horizontalno'+#13+
'MARGINS (%)=Margine (%)'+#13+
'MARGINS=Margine'+#13+
'DETAIL=Detalji'+#13+
'MORE=Više'+#13+
'PROPORTIONAL=Proporcionalno'+#13+
'VIEW MARGINS=Pogledaj Margine'+#13+
'RESET MARGINS=Resetuj Margine'+#13+
'PRINT=Štampaj'+#13+
'TEEPREVIEW EDITOR=Editor Tee predpregleda'+#13+
'ALLOW MOVE=Dozvoli pomeranje'+#13+
'ALLOW RESIZE=Dozvoli promenu velièine'+#13+
'SHOW IMAGE=Prikaži sliku'+#13+
'DRAG IMAGE=Pomeri sliku'+#13+
'AS BITMAP=kao Bitmap-a'+#13+
'SIZE %=Velièina %'+#13+
'FIELDS=Polja'+#13+
'SOURCE=Izvor'+#13+
'SEPARATOR=Separator'+#13+
'NUMBER OF HEADER LINES=Broj linija zaglavlja'+#13+
'COMMA=Zarez'+#13+
'EDITING=Editovanje'+#13+
'TAB=Tabulator'+#13+
'SPACE=Prazno'+#13+
'ROUND RECTANGLE=Zaobljeni pravougaonik'+#13+
'BOTTOM=Na dnu'+#13+
'RIGHT=Desno'+#13+
'C PEN=C olovka'+#13+
'R PEN=R olovka'+#13+
'C LABELS=C natpisi'+#13+
'R LABELS=R natpisi'+#13+
'MULTIPLE BAR=Višestruki stub'+#13+
'MULTIPLE AREAS=Višestruko podruèje'+#13+
'STACK GROUP=Grupa niza'+#13+
'BOTH=Oba'+#13+
'BACK DIAGONAL=Dijagonalno nazad'+#13+
'B.DIAGONAL=Dijagonalno nazad'+#13+
'DIAG.CROSS=Diagonalno ukršteno'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Krst'+#13+
'DIAGONAL CROSS=Dijagonalni krst'+#13+
'LEFT RIGHT=Levo Desno'+#13+
'RIGHT LEFT=Desno Levo'+#13+
'FROM CENTER=Iz centra'+#13+
'FROM TOP LEFT=Iz godnjeg levog ugla'+#13+
'FROM BOTTOM LEFT=Iz donjeg levog ugla'+#13+
'SHOW WEEKDAYS=Prikaži radne dane'+#13+
'SHOW MONTHS=Prikaži mesece'+#13+
'SHOW PREVIOUS BUTTON=Prikaži prethodno dugme'#13+
'SHOW NEXT BUTTON=Prikaži naredno dugme'#13+
'TRAILING DAYS=Preostali dani'+#13+
'SHOW TODAY=Prikaži danas'+#13+
'TRAILING=Preostali'+#13+
'LOWERED=Sniženo'+#13+
'RAISED=Uveæano'+#13+
'HORIZ. OFFSET=Horiz. ofset'+#13+
'VERT. OFFSET=Vert. ofset'+#13+
'INNER=Unutra'+#13+
'LEN=Dužina'+#13+
'AT LABELS ONLY=Samo na naslovima'+#13+
'MAXIMUM=Maksimum'+#13+
'MINIMUM=Mínimum'+#13+
'CHANGE=Promeni'+#13+
'LOGARITHMIC=Logarítamsko'+#13+
'LOG BASE=Oslova Log.'+#13+
'DESIRED INCREMENT=Željeni priraštaj'+#13+
'(INCREMENT)=(Priraštaj)'+#13+
'MULTI-LINE=Višestruko-linijski'+#13+
'MULTI LINE=Višestruka linija'+#13+
'RESIZE CHART=Promeni velièinu grafika'+#13+
'X AND PERCENT=X i procenat'+#13+
'X AND VALUE=X i vrednost'+#13+
'RIGHT PERCENT=Desni procenat'+#13+
'LEFT PERCENT=Levi procenat'+#13+
'LEFT VALUE=Leva vrednost'+#13+
'RIGHT VALUE=Desna vrednost'+#13+
'PLAIN=Èist'+#13+
'LAST VALUES=Poslednja vrednost'+#13+
'SERIES VALUES=Vrednosti serija'+#13+
'SERIES NAMES=Imena serija'+#13+
'NEW=Novo'+#13+
'EDIT=Edituj'+#13+
'PANEL COLOR=Boja panela'+#13+
'TOP BOTTOM=Gore dole'+#13+
'BOTTOM TOP=Dole gore'+#13+
'DEFAULT ALIGNMENT=Osnovno poravnanje'+#13+
'EXPONENTIAL=Eksponencijal'+#13+
'LABELS FORMAT=Format natpisa'+#13+
'MIN. SEPARATION %=Min. separacija %'+#13+
'YEAR=Godina'+#13+
'MONTH=Mesec'+#13+
'WEEK=Nedelja'+#13+
'WEEKDAY=Radni dan'+#13+
'MARK=Oznaka'+#13+
'ROUND FIRST=Zaokruži prvi'+#13+
'LABEL ON AXIS=Natpisi na osi'+#13+
'COUNT=Broj'+#13+
'POSITION %=Pozicija %'+#13+
'START %=Start %'+#13+
'END %=Kraj %'+#13+
'OTHER SIDE=Druga strana'+#13+
'INTER-CHAR SPACING=Medju-karakterno rastojanje'+#13+
'VERT. SPACING=Vertikalno rastojanje'+#13+
'POSITION OFFSET %=Ofset pozicije %'+#13+
'GENERAL=Generalno'+#13+
'MANUAL=Ruèno'+#13+
'PERSISTENT=Stalno'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Delitelj'+#13+
'TEEOPENGL EDITOR=OpenGL Editor'+#13+
'FONT 3D DEPTH=Dubina 3D pisma'+#13+
'NORMAL=Normalno'+#13+
'TEEFONT EDITOR=Editor pisma'+#13+
'CLIP POINTS=Taèke spoja'+#13+
'CLIPPED=Spojeno'+#13+
'3D %=3D %'+#13+
'QUANTIZE='+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Redukovati'+#13+
'VERTICAL SMALL=Vertikalno malo'+#13+
'HORIZ. SMALL=Horizontalno malo'+#13+
'DIAG. SMALL=Dijagonalno malo'+#13+
'BACK DIAG. SMALL=Dijagonalno obrnuto malo'+#13+
'DIAG. CROSS SMALL=Dijagonalno krstasto malo'+#13+
'MINIMUM PIXELS=Mínimalno taèaka'+#13+
'ALLOW SCROLL=Dozvoli pomeranje'+#13+
'SWAP=Zameni'+#13+
'GRADIENT EDITOR=Editor preliva'+#13+
'TEXT STYLE=Stil teksta'+#13+
'DIVIDING LINES=Deliti linije'+#13+
'SYMBOLS=Simboli'+#13+
'CHECK BOXES=Check boksovi'+#13+
'FONT SERIES COLOR=Boja pisma serije'+#13+
'LEGEND STYLE=Stil legende'+#13+
'POINTS PER PAGE=Taèaka po strani'+#13+
'SCALE LAST PAGE=Skaliraj zadnju stranu'+#13+
'CURRENT PAGE LEGEND=Trenutna strana legende'+#13+
'BACKGROUND=Pozadina'+#13+
'BACK IMAGE=Pozadinska slika'+#13+
'STRETCH=Razvuci'+#13+
'TILE=Mozaik'+#13+
'BORDERS=Okviri'+#13+
'CALCULATE EVERY=Izraèunaj svaki'+#13+
'NUMBER OF POINTS=Broj taèaka'+#13+
'RANGE OF VALUES=Opseg vrednosti'+#13+
'FIRST=Prvi'+#13+
'LAST=Poslednji'+#13+
'ALL POINTS=Sve taèke'+#13+
'DATA SOURCE=Izvor podataka'+#13+
'WALLS=Zidovi'+#13+
'PAGING=Stranièenje'+#13+
'CLONE=Duplikat'+#13+
'TITLES=Naslovi'+#13+
'TOOLS=Alati'+#13+
'EXPORT=Eksport'+#13+
'CHART=Grafik'+#13+
'BACK=Nazad'+#13+
'LEFT AND RIGHT=Levo i desno'+#13+
'SELECT A CHART STYLE=Izaberi stil grafika'+#13+
'SELECT A DATABASE TABLE=Izaberi tabelu baze'+#13+
'TABLE=Tabela'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Izaberi željena polja za grafik'+#13+
'SELECT A TEXT LABELS FIELD=Izaberi polje tekstualnih natpisa'+#13+
'CHOOSE THE DESIRED CHART TYPE=Izaberi željeni tip grafika'+#13+
'CHART PREVIEW=Predpregled grafika'+#13+
'SHOW LEGEND=Prikaži legendu'+#13+
'SHOW MARKS=Prikaži oznake'+#13+
'FINISH=Završi'+#13+
'RANDOM=Sluèajno'+#13+
'DRAW EVERY=Crtaj svaki'+#13+
'ARROWS=Strelice'+#13+
'ASCENDING=Rastuæe'+#13+
'DESCENDING=Opadajuæe'+#13+
'VERTICAL AXIS=Vertikalne Ose'+#13+
'DATETIME=DatumÈas'+#13+
'TOP AND BOTTOM=Gornji i donji'+#13+
'HORIZONTAL AXIS=Horizontalna osa'+#13+
'PERCENTS=Procenti'+#13+
'VALUES=Vrednosti'+#13+
'FORMATS=Formati'+#13+
'SHOW IN LEGEND=Prikaži u legendi'+#13+
'SORT=Redosled'+#13+
'MARKS=Oznake'+#13+
'BEVEL INNER=Unutrašnji nivo'+#13+
'BEVEL OUTER=Spoljašnji nivo'+#13+
'PANEL EDITOR=Editor panela'+#13+
'CONTINUOUS=Nastavljeno'+#13+
'HORIZ. ALIGNMENT=Horiz. poravnanje'+#13+
'EXPORT CHART=Eksportuj Grafik '+#13+
'BELOW %=Ispod %'+#13+
'BELOW VALUE=Ispod vrednosti'+#13+
'NEAREST POINT=Najbliža taèka'+#13+
'DRAG MARKS=Pomeri naslove'+#13+
'TEECHART PRINT PREVIEW=Predpregled'+#13+
'X VALUE=Vrednost X'+#13+
'X AND Y VALUES=Vrednost X i Y'+#13+
'SHININESS=Svetlina'+#13+
'ALL SERIES VISIBLE=Sve serije vidljive'+#13+
'MARGIN=Margina'+#13+
'DIAGONAL=Dijagonala'+#13+
'LEFT TOP=Levo gore'+#13+
'LEFT BOTTOM=Levo dole'+#13+
'RIGHT TOP=Desno gore'+#13+
'RIGHT BOTTOM=Desno dole'+#13+
'EXACT DATE TIME=Taèan DatumÈas'+#13+
'RECT. GRADIENT=Gradijent'+#13+
'CROSS SMALL=Ukršteno malo'+#13+
'AVG=Prosek'+#13+
'FUNCTION=Funkcija'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Jedna milisekunda'+#13+
'ONE SECOND=Jedna sekunda'+#13+
'FIVE SECONDS=Pet sekundi'+#13+
'TEN SECONDS=Deset sekundi'+#13+
'FIFTEEN SECONDS=Petnaest sekundi'+#13+
'THIRTY SECONDS=Trideset sekundi'+#13+
'ONE MINUTE=Jedan minut'+#13+
'FIVE MINUTES=pet minuta'+#13+
'TEN MINUTES=Deset minuta'+#13+
'FIFTEEN MINUTES=Petnaest minuta'+#13+
'THIRTY MINUTES=Trideset minuta'+#13+
'TWO HOURS=Dva èasa'+#13+
'TWO HOURS=Dva èasa'+#13+
'SIX HOURS=Šest èasova'+#13+
'TWELVE HOURS=Tuce èasova'+#13+
'ONE DAY=Jedan dan'+#13+
'TWO DAYS=Dva dana'+#13+
'THREE DAYS=Tri dana'+#13+
'ONE WEEK=Jedna nedelja'+#13+
'HALF MONTH=Pola meseca'+#13+
'ONE MONTH=Jedan mesec'+#13+
'TWO MONTHS=Dva meseca'+#13+
'THREE MONTHS=Tri meseca'+#13+
'FOUR MONTHS=Èetiri meseca'+#13+
'SIX MONTHS=Šest meseci'+#13+
'IRREGULAR=Neregularno'+#13+
'CLICKABLE=Dopustiti klik'+#13+
'ROUND=Zaoružiti'+#13+
'FLAT=Ravno'+#13+
'PIE=Torta'+#13+
'HORIZ. BAR=Horiz. Stub'+#13+
'BUBBLE=Balon'+#13+
'SHAPE=Forma'+#13+
'POINT=Taèka'+#13+
'FAST LINE=Brza línea'+#13+
'CANDLE=Sveæa'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=Horiz. linija'+#13+
'SURFACE=Površina'+#13+
'LEFT AXIS=Leva osa'+#13+
'RIGHT AXIS=Desna osa'+#13+
'TOP AXIS=Gornja osa'+#13+
'BOTTOM AXIS=Donja osa'+#13+
'CHANGE SERIES TITLE=Promeni natpise serija'+#13+
'DELETE %S ?=Briši %s ?'+#13+
'DESIRED %S INCREMENT=Željeni %s priraštaj'+#13+
'INCORRECT VALUE. REASON: %S=Nekorektna vrednost. Razlog: %s'+#13+
'FillSampleValues NumValues must be > 0=Popunjene sluèajne vrednosti treba da budu > 0.'#13+
'VISIT OUR WEB SITE !=Posetite našu Web stranu!'#13+
'SHOW PAGE NUMBER=Prikazi broj strane'#13+
'PAGE NUMBER=Broj strane'#13+
'PAGE %D OF %D=Strana %d od %d'#13+
'TEECHART LANGUAGES=TeeChart jezici'#13+
'CHOOSE A LANGUAGE=Izaberi jezik'+#13+
'SELECT ALL=Selektuj sve'#13+
'MOVE UP=Pomeri gore'#13+
'MOVE DOWN=Pomeri dole'#13+
'DRAW ALL=Iscrtaj sve'#13+
'TEXT FILE=Tekstualna datoteka'#13+
'IMAG. SYMBOL=Imag. simbol'#13+
'DRAG REPAINT=Pomeri osvežavanje'#13+
'NO LIMIT DRAG=Pomeranje bez ogranièenja'#13+
'PERIOD=Period'#13+
'UP=Gore'#13+
'DOWN=Dole'#13+
'SHADOW EDITOR=Editor senke'#13+
'CALLOUT=Kalota'#13+
'TEXT ALIGNMENT=Poravnanje teksta'#13+
'DISTANCE=Udaljenost'#13+
'ARROW HEAD=Glava strelice'#13+
'POINTER=Pokazivaè'#13+
'AVAILABLE LANGUAGES=Dostupni jezici'#13+
'CALCULATE USING=Izraèunaj koristeæi'#13+
'EVERY NUMBER OF POINTS=Svaki broj taèaka'#13+
'EVERY RANGE=Svaki opseg'#13+
'INCLUDE NULL VALUES=Ukljuèujuæi Null vrednosti'#13+
'DATE=Datum'#13+
'ENTER DATE=Unesi datum'#13+
'ENTER TIME=Unesi vreme'#13+
'BEVEL SIZE=Velièina okvira'#13+
'CYLINDER=Cilindar'#13+
'DEVIATION=Odstupanje'#13+
'UPPER=Gornji'#13+
'LOWER=Donji'#13+
'FILL 80%=Popuni 80%'#13+
'FILL 60%=Popuni 60%'#13+
'FILL 40%=Popuni 40%'#13+
'FILL 20%=Popuni 20%'#13+
'FILL 10%=Popuni 10%'#13+
'ZIG ZAG=Cik-Cak'#13+
'NOTHING=Ništa'#13+
'LEFT TRIANGLE=Levi trougao'#13+
'RIGHT TRIANGLE=Desni trougao'#13+
'CONSTANT=Konstanta'#13+
'SHOW LABELS=Prikaži natpise'#13+
'SHOW COLORS=Prikaži boje'#13+
'XYZ SERIES=XYZ serije'#13+
'SHOW X VALUES=Prikaži X vrednosti'#13+
'DELETE ROW=Obrissi red'#13+
'VOLUME SERIES=Zapreminske serije'#13+
'ACCUMULATE=Akumuliraj'#13+
'SINGLE=Jednostruko'#13+
'REMOVE CUSTOM COLORS=Ukloni korisnièke boje'#13+
'STEP=Korak'#13+
'USE PALETTE MINIMUM=Koristi minimum palete'#13+
'AXIS MAXIMUM=Osni maximum'#13+
'AXIS CENTER=Osni centar'#13+
'AXIS MINIMUM=Osni minimum'#13+
'DAILY (NONE)=Dnevno (ništa)'#13+
'WEEKLY=Nedeljno'#13+
'MONTHLY=Meseèno'#13+
'BI-MONTHLY=Dvomeseèno'#13+
'QUARTERLY=Tromeseèno'#13+
'YEARLY=Godišnje'#13+
'DATETIME PERIOD=DatumÈas period'#13+
'SMOOTH=Glatko'#13+
'INTERPOLATE=Interpoliraj'#13+
'START X=Start X'#13+
'NUM. POINTS=Broj taèaka'#13+
'COLOR EACH LINE=Oboji svaku liniju'#13+
'CASE SENSITIVE=Case sensitive'#13+
'SORT BY=Sortiraj po'#13+
'CALCULATION=Obraèun'#13+
'GROUP=Grupiši'#13+
'DRAG STYLE=Stil pomeranja'#13+
'WEIGHT=Težina'#13+
'EDIT LEGEND=Edituj legendu'#13+
'IGNORE NULLS=Ignoriši Nulls'#13+
'OFFSET=Ofset'#13+
'LIGHT 0=Svetlo 0'#13+
'LIGHT 1=Svetlo 1'#13+
'LIGHT 2=Svetlo 2'#13+
'DRAW STYLE=Stil crtanja'#13+
'POINTS=Taèke'#13+
'DEFAULT BORDER=Podrazumevani okvir'#13+
'SQUARED=Kvadratno'#13+
'SEPARATION=Separacija'#13+
'ROUND BORDER=Zakrivljene ivice'#13+
'NUMBER OF SAMPLE VALUES=Broj sluèajnih vrednosti'#13+
'DIF. LIMIT=Dif. limit'#13+
'RESIZE PIXELS TOLERANCE=Promeni toleranciju taèaka'#13+
'FULL REPAINT=Puno iscrtavanje'#13+
'END POINT=Krajnja taèka'#13+
'BAND 1=Traka 1'#13+
'BAND 2=Traka 2'#13+
'GRID 3D SERIES=3D mrežne serije '#13+
'TRANSPOSE NOW=Preuredi odmah'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Eksp. linija'#13+
'MACD=MACD'#13+
'WEIGHTED=Ponderisano'#13+
'WEIGHTED BY INDEX=Ponderisano po indeksu'#13+
'DARK BORDER=Tamna ivica'#13+
'PIE SERIES=Kolaè serije'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Rasturi'#13+
'BOX SIZE=Velièina kutije'#13+
'REVERSAL AMOUNT=Inverzna suma'#13+
'PERCENTAGE=Procenat'#13+
'COMPLETE R.M.S.=Kompletan R.M.S.'#13+
'BUTTON=Dugme'#13+
'ALL=Sve'#13+
'START AT MIN. VALUE=Start od min. vrednosti'#13+
'EXECUTE !=Izvrši !'#13+
'WEB URL=Web URL'#13+
'FACTOR=Faktor'#13+
'SELF STACK=Naslaži se'#13+
'SIDE LINES=Boène linije'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafik po šablonu (*.TEE datoteka)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Otvori TeeChart šablon datoteku iz'#13+
'EXPORT DIALOG=Eksport dijalog'#13+
'BINARY=Binarno'#13+
'POINT COLORS=Taèke boja'#13+
'OUTLINE GRADIENT=Okvirni preliv'#13+
'CLOSE LOCATION VALUE=Vrednost najbliže lokacije'#13+
'COMMODITY CHANNEL INDEX=Indeks robnog kanala'#13+
'CROSS POINTS=Taèke ukrštanja'#13+
'ON BALANCE VOLUME=Na izjednaèenje volumena'#13+
'SMOOTHING=Ravnomernost'#13+
'TREND=Trend'#13+
'VOLUME OSCILLATOR=Oscilator volumena'#13+
'BALANCE=Izjednaèi'#13+
'RADIAL OFFSET=Radijalni ofset'#13+
'RADIAL=Radijalno'#13+
'COVER=Pokrij'#13+
'ARROW WIDTH=Širija strelice'#13+
'ARROW HEIGHT=Dužina strelice'#13+
'DEFAULT COLOR=Podrazum. boja'#13+
'VALUE SOURCE=Izvor vrednosti'
;
  end;
end;

Procedure TeeSetSerbian;
begin
  TeeCreateSerbian;
  TeeLanguage:=TeeSerbianLanguage;
  TeeSerbianConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeSerbianLanguage);
end.


