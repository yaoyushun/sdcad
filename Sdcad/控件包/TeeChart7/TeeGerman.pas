unit TeeGerman;
{$I TeeDefs.inc}

interface

Uses Classes, TeeTranslate;

Var TeeGermanLanguage:TLanguageStrings=nil;

Procedure TeeSetGerman;
Procedure TeeCreateGerman;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeGermanConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='Erster Legenden Wert muß > 0 sein';
  TeeMsg_LegendColorWidth   :='Symbolbreite muß zwischen 0 und 100 liegen';
  TeeMsg_SeriesSetDataSource:='Kein ParentChart um Datenquelle zu erlauben';
  TeeMsg_SeriesInvDataSource:='Keine gültige Datenquelle: %s';
  TeeMsg_FillSample         :='FillSampleWerte NumWerte müssen > 0 sein';
  TeeMsg_AxisLogDateTime    :='Datum/Uhrzeit-Achse kann nicht logarithmisch sein ';
  TeeMsg_AxisLogNotPositive :='Logarithmus-Achs Min und Max Werte sollten >= 0 sein';
  TeeMsg_AxisLabelSep       :='Label-Abstand % muß größer als 0 sein';
  TeeMsg_AxisIncrementNeg   :='Achs-Inkrement muß >= 0 sein';
  TeeMsg_AxisMinMax         :='Kleinster Achswert muß <= Maximum sein';
  TeeMsg_AxisMaxMin         :='Größter Achswert muß >= Minimum sein';
  TeeMsg_AxisLogBase        :='Achs-Logarithmusbase sollte >= 2 sein';
  TeeMsg_MaxPointsPerPage   :='Maximale Werteanzahl pro Seite muß >= 0 sein';
  TeeMsg_3dPercent          :='3D-Effekt-Prozent muß zwischen %d und %d liegen';
  TeeMsg_CircularSeries     :='Zirkelbezüge sind nicht erlaubt';
  TeeMsg_WarningHiColor     :='16k-Farbdarstellung oder mehr ergibt besseres Aussehen';

  TeeMsg_DefaultPercentOf   :='%s von %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Achs-Titel';
  TeeMsg_AxisLabels         :='Achs-Labels';
  TeeMsg_RefreshInterval    :='Aktualis.-Interval muß zwischen 0 und 60 liegen';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart bin ich nicht selbst!';
  TeeMsg_GalleryLine        :='Linie';
  TeeMsg_GalleryPoint       :='Punkt';
  TeeMsg_GalleryArea        :='Fläche';
  TeeMsg_GalleryBar         :='Säule';
  TeeMsg_GalleryHorizBar    :='Balken';
  TeeMsg_Stack              :='Stapel';
  TeeMsg_GalleryPie         :='Kreis';
  TeeMsg_GalleryCircled     :='Rund';
  TeeMsg_GalleryFastLine    :='Schnelle Linie';
  TeeMsg_GalleryHorizLine   :='Horiz Linie';

  TeeMsg_PieSample1         :='Autos';
  TeeMsg_PieSample2         :='Telefone';
  TeeMsg_PieSample3         :='Tische';
  TeeMsg_PieSample4         :='Monitore';
  TeeMsg_PieSample5         :='Lampen';
  TeeMsg_PieSample6         :='Tastaturen';
  TeeMsg_PieSample7         :='Fahrräder';
  TeeMsg_PieSample8         :='Stühle';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Bearbeiten %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Erweitert';
  TeeMsg_GalleryFunctions   :='Funktionen';

  TeeMsg_EditChart          :='Chart &bearbeiten...';
  TeeMsg_PrintPreview       :='&Seitenansicht...';
  TeeMsg_ExportChart        :='Chart e&xportieren...';
  TeeMsg_CustomAxes         :='Benuterdefinierte Achsen...';

  TeeMsg_InvalidEditorClass :='%s: Ungültige Editorklasse: %s';
  TeeMsg_MissingEditorClass :='%s: hat keinen Editor Dialog';

  TeeMsg_GalleryArrow       :='Pfeil';

  TeeMsg_ExpFinish          :='&Ende';
  TeeMsg_ExpNext            :='&Nächster >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Entwurf';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Entwicklung';
  TeeMsg_GanttSample4       :='Verkauf';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Test';
  TeeMsg_GanttSample7       :='Fertigung.';
  TeeMsg_GanttSample8       :='Nachbesserung';
  TeeMsg_GanttSample9       :='Neuerscheinung';
  TeeMsg_GanttSample10      :='Bankgeschäft';

  TeeMsg_ChangeSeriesTitle  :='Reihenname ändern';
  TeeMsg_NewSeriesTitle     :='Neuer Reihenname:';
  TeeMsg_DateTime           :='Datum/Uhrzeit';
  TeeMsg_TopAxis            :='Obere Achse';
  TeeMsg_BottomAxis         :='Untere Achse';
  TeeMsg_LeftAxis           :='Linke Achse';
  TeeMsg_RightAxis          :='Rechte Achse';

  TeeMsg_SureToDelete       :='%s entfernen?';
  TeeMsg_DateTimeFormat     :='Datum/Uhrzeit For&mat:';
  TeeMsg_Default            :='Standard';
  TeeMsg_ValuesFormat       :='Werte For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Gewünschtes %s Inkrement';

  TeeMsg_IncorrectMaxMinValue:='Ungenauer Wert. Ursache: %s';
  TeeMsg_EnterDateTime      :='Eingabe [Anzahl der Tage] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Änderung Ausführen?';
  TeeMsg_SelectedSeries     :='(Gewählte Reihen)';
  TeeMsg_RefreshData        :='&Aktualisiere Daten';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='425';
  TeeMsg_FunctionAdd        :='Addieren';
  TeeMsg_FunctionSubtract   :='Subtrahieren';
  TeeMsg_FunctionMultiply   :='Multiplizieren';
  TeeMsg_FunctionDivide     :='Dividieren';
  TeeMsg_FunctionHigh       :='Hoch';
  TeeMsg_FunctionLow        :='Tief';
  TeeMsg_FunctionAverage    :='Durchschnitt';

  TeeMsg_GalleryShape       :='Form';
  TeeMsg_GalleryBubble      :='Blase';
  TeeMsg_FunctionNone       :='Kopie';

  TeeMsg_None               :='(Kein)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Zeigergröße muß größer als Null sein';
  TeeMsg_About              :='&Über TeeChart...';

  tcAdditional              :='Zusätzlich';
  tcDControls               :='Data Datenkontrolle';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Datensatz';
  TeeMsg_AskDataSet         :='&Datensatz:';

  TeeMsg_SingleRecord       :='Einzelner Datensatz';
  TeeMsg_AskDataSource      :='&Datenquelle:';

  TeeMsg_Summary            :='Zusammenfassung';

  TeeMsg_FunctionPeriod     :='Funktionsperiode sollte >= 0 sein';

  TeeMsg_WizardTab          :='Geschäft';

  TeeMsg_ClearImage         :='&Löschen';
  TeeMsg_BrowseImage        :='&Suchen in...';

  TeeMsg_WizardSureToClose  :='Sind Sie sicher, daß Sie TeeChart Wizard verlassen möchten?';
  TeeMsg_FieldNotFound      :='Feld %s existiert nicht';

  TeeMsg_DepthAxis          :='Tiefenachse';
  TeeMsg_PieOther           :='Andere';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pie';
  TeeMsg_ValuesBar          :='Kreis';
  TeeMsg_ValuesAngle        :='Winkel';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Ende';
  TeeMsg_ValuesGanttNextTask:='Nächste Arbeit';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='EndeX';
  TeeMsg_ValuesArrowEndY    :='EndeY';
  TeeMsg_Legend             :='Legende';
  TeeMsg_Title              :='Titel';
  TeeMsg_Foot               :='Fußzeile';
  TeeMsg_Period		          :='Periode';
  TeeMsg_PeriodRange        :='Periodenbereich';
  TeeMsg_CalcPeriod         :='Berechne %s alle:';
  TeeMsg_SmallDotsPen       :='Kleine Punkte';

  TeeMsg_InvalidTeeFile     :='Ungültiger Chart in *.'+TeeMsg_TeeExtension+' File';
  TeeMsg_WrongTeeFileFormat :='Falsches *.'+TeeMsg_TeeExtension+' file Format';
  TeeMsg_EmptyTeeFile       :='Leerer *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Chart Achse';
  TeeMsg_ChartAxesCategoryDesc   :='Chart Axes Eigenschaften und Ereignisse';
  TeeMsg_ChartWallsCategoryName  :='Chart Wände';
  TeeMsg_ChartWallsCategoryDesc  :='Chart Walls Eigenschaften und Ereignisse';
  TeeMsg_ChartTitlesCategoryName :='Chart Titel';
  TeeMsg_ChartTitlesCategoryDesc :='Chart Titles Eigenschaften und Ereignisse';
  TeeMsg_Chart3DCategoryName     :='Chart 3D';
  TeeMsg_Chart3DCategoryDesc     :='Chart 3D Eigenschaften und Ereignisse';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Extra ';
  TeeMsg_Series                 :='Reihe';
  TeeMsg_SeriesList             :='Reihe...';

  TeeMsg_PageOfPages            :='Seite %d von %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Erster';
  TeeMsg_Prior  :='Vorheriger';
  TeeMsg_Next   :='Nächster';
  TeeMsg_Last   :='Letzter';
  TeeMsg_Insert :='Einfügen';
  TeeMsg_Delete :='Löschen';
  TeeMsg_Edit   :='Edit';
  TeeMsg_Post   :='Setzen';
  TeeMsg_Cancel :='Löschen';

  TeeMsg_All    :='(alle)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='als &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='als &Metafile';
  TeeMsg_EMFFilter    :='Erhöhte Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Eigenschaft Untergrund ist nicht in Export-Format gesetzt';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Keine Grenze';
  TeeMsg_Dotted    :='Gepunktet';
  TeeMsg_Colors    :='Farben';
  TeeMsg_Filled    :='Gefüllt';
  TeeMsg_Marks     :='Marks';
  TeeMsg_Stairs    :='Treppen';
  TeeMsg_Points    :='Punkte';
  TeeMsg_Height    :='Höhe';
  TeeMsg_Hollow    :='Hohl';
  TeeMsg_Point2D   :='Punkt 2D';
  TeeMsg_Triangle  :='Dreieck';
  TeeMsg_Star      :='Stern';
  TeeMsg_Circle    :='Kreis';
  TeeMsg_DownTri   :='Kopfst. Dreieck';
  TeeMsg_Cross     :='Kreuz';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Keine Linien';
  TeeMsg_Stack100  :='Stapel 100%';
  TeeMsg_Pyramid   :='Pyramide';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Kopfst. Pyramide';
  TeeMsg_Sides     :='Seiten';
  TeeMsg_SideAll   :='Alle Seiten';
  TeeMsg_Patterns  :='Muster';
  TeeMsg_Exploded  :='Explodiert';
  TeeMsg_Shadow    :='Schatten';
  TeeMsg_SemiPie   :='Halbkreis';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Vert.Linie';
  TeeMsg_HorizLine :='Horiz.Linie';
  TeeMsg_Line      :='Linie';
  TeeMsg_Cube      :='Würfel';
  TeeMsg_DiagCross :='Diag.Kreuz';

  TeeMsg_CanNotFindTempPath    :='Kann Temp-Ordner nicht finden';
  TeeMsg_CanNotCreateTempChart :='Kann kein Temp-File erstellen';
  TeeMsg_CanNotEmailChart      :='Kann TeeChart nicht versenden. Mapi Fehler: %d';

  TeeMsg_SeriesDelete :='Reihen Löschen: WerteIndex %d außerhalb der Grenzen (0 bis %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Language...';
  
  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Kurs';
  TeeMsg_GalleryVolume      :='Band';
  TeeMsg_GallerySurface     :='Oberfläche';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punkt 3D';
  TeeMsg_GalleryRadar       :='Netz';
  TeeMsg_GalleryDonut       :='Ring';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Säule 3D';
  TeeMsg_GalleryBigCandle   :='Großer Kurs';
  TeeMsg_GalleryLinePoint   :='Linie Punkt';
  TeeMsg_GalleryHistogram   :='Histogramm';
  TeeMsg_GalleryWaterFall   :='Wasserfall';
  TeeMsg_GalleryWindRose    :='Windrose';
  TeeMsg_GalleryClock       :='Uhr';
  TeeMsg_GalleryColorGrid   :='Farbgitter';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Säulen Verb.';
  TeeMsg_GallerySmith       :='Schmidt';
  TeeMsg_GalleryPyramid     :='Pyramide';
  TeeMsg_GalleryMap         :='Plan';

  TeeMsg_PolyDegreeRange    :='Polynomial-Grad muß zwischen 1 and 20 liegen';
  TeeMsg_AnswerVectorIndex   :='Antwort Vektor Index muß zwischen 1 und %d liegen';
  TeeMsg_FittingError        :='Verknüpfung kann nicht verarbeitet werden';
  TeeMsg_PeriodRange         :='Periodenbereich muß >= 0 sein';
  TeeMsg_ExpAverageWeight    :='Exp. Durchschnitt muß zwischen 0 und 1 liegen';
  TeeMsg_GalleryErrorBar     :='Fehler Balken';
  TeeMsg_GalleryError        :='Fehler';
  TeeMsg_GalleryHighLow      :='Hoch-Tief';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp.Durchschn.';
  TeeMsg_FunctionMovingAverage:='Gleit.Durchschn.';
  TeeMsg_FunctionExpMovAve   :='Exp.Gleit.Durchschn.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ausgleichskurve';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Anwachsend';
  TeeMsg_FunctionStdDeviation:='Std.-Abweichung';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Quadratwurzel';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastik';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Zählen';
  TeeMsg_LoadChart           :='TeeChart Öffnen...';
  TeeMsg_SaveChart           :='TeeChart Speichern...';
  TeeMsg_TeeFiles            :='TeeChart Pro Dateien';

  TeeMsg_GallerySamples      :='Andere';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Reihen Editor Form nicht gefunden: %s';


  TeeMsg_CannotLoadChartFromURL:='Fehler Code: %d herunterladen Chart von URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Fehler code: %d herunterladen Reihen Daten von URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Öffnen';
  TeeMsg_ValuesHigh          :='Hoch';
  TeeMsg_ValuesLow           :='Tief';
  TeeMsg_ValuesClose         :='Schließen';
  TeeMsg_ValuesOffset        :='Abweichung';
  TeeMsg_ValuesStdError      :='StdFehler';

  TeeMsg_Grid3D              :='Gitter 3D';

  TeeMsg_LowBezierPoints     :='Anzahl Bezier-Punkte sollte > 1 sein';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Optionen';
  TeeCommanMsg_Print    :='Drucken';
  TeeCommanMsg_Copy     :='Kopieren';
  TeeCommanMsg_Save     :='Speichern';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d° Blickwinkel: %d°';
  TeeCommanMsg_Rotate   :='Drehen';

  TeeCommanMsg_Moving   :='Horiz.Grenze: %d Vert.Grenze: %d';
  TeeCommanMsg_Move     :='Verschieben';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Tiefe';

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Hintergrund';

  TeeCommanMsg_RotateLabel:='Zieh %s zum Drehen';
  TeeCommanMsg_MoveLabel  :='Zieh %s zum Verschieben';
  TeeCommanMsg_ZoomLabel  :='Zieh %s zum Zoom';
  TeeCommanMsg_DepthLabel :='Zieh %s für Vorheriges 3D';

  TeeCommanMsg_NormalLabel:='Zieh linke Taste für Zoom, rechte Taste für Scroll';
  TeeCommanMsg_NormalPieLabel:='Zieh Kreisausschnitt zur Vergrößerung';

  TeeCommanMsg_PieExploding :='Scheibe: %d Explodiert: %d %%';

  TeeMsg_TriSurfaceLess:='Anzahl der Punkte muß >= 4 sein';
  TeeMsg_TriSurfaceAllColinear:='Alle kolineare Datenpunkte';
  TeeMsg_TriSurfaceSimilar:='Ähnliche Punkte - kann nicht ausführen';
  TeeMsg_GalleryTriSurface:='Dreieckige Oberfl.';

  TeeMsg_AllSeries :='Alle Reihen';
  TeeMsg_Edit      :='Bearbeiten';

  TeeMsg_GalleryFinancial    :='Finanzen';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Zieh-Marks';
  TeeMsg_AxisArrowTool :='Achspfeile';
  TeeMsg_DrawLineTool  :='Linie zeichnen';
  TeeMsg_NearestTool   :='Nächster Punkt';
  TeeMsg_ColorBandTool :='Farbbreite';
  TeeMsg_ColorLineTool :='Farbige Linie';
  TeeMsg_RotateTool    :='Drehen';
  TeeMsg_ImageTool     :='Bild';
  TeeMsg_MarksTipTool  :='Tip-Marks';

  TeeMsg_CantDeleteAncestor  :='Kann Vorgänger nicht löschen';

  TeeMsg_Load	         :='Laden...';
  TeeMsg_NoSeriesSelected:='Keine Reihe ausgewählt';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Reihe';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Umschalten 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktiv';
  TeeMsg_ActionSeriesActiveHint :='Zeig / Versteck Reihe';
  TeeMsg_ActionEditHint         :='Chart bearbeiten';
  TeeMsg_ActionEdit             :='&Bearbeiten...';
  TeeMsg_ActionCopyHint         :='In Zwischenablage kopieren';
  TeeMsg_ActionCopy             :='&Kopieren';
  TeeMsg_ActionPrintHint        :='Vorschau drucken';
  TeeMsg_ActionPrint            :='&Drucken...';
  TeeMsg_ActionAxesHint         :='Zeig / Versteck Achse';
  TeeMsg_ActionAxes             :='&Achse';
  TeeMsg_ActionGridsHint        :='Zeig / Versteck Gitter';
  TeeMsg_ActionGrids            :='&Gitter';
  TeeMsg_ActionLegendHint       :='Zeig / Versteck Legende';
  TeeMsg_ActionLegend           :='&Legende';
  TeeMsg_ActionSeriesEditHint   :='Reihe Bearbeiten';
  TeeMsg_ActionSeriesMarksHint  :='Zeig / Versteck Reihen-Marks';
  TeeMsg_ActionSeriesMarks      :='&Marks';
  TeeMsg_ActionSaveHint         :='Chart speichern';
  TeeMsg_ActionSave             :='&Speichern...';

  TeeMsg_CandleBar              :='Säule';
  TeeMsg_CandleNoOpen           :='Keine Eröf.';
  TeeMsg_CandleNoClose          :='Kein Schluß';
  TeeMsg_NoLines                :='Keine Linie';
  TeeMsg_NoHigh                 :='Keine Hoch';
  TeeMsg_NoLow                  :='Keine Tief';
  TeeMsg_ColorRange             :='Farbbreite';
  TeeMsg_WireFrame              :='Drahtnetz';
  TeeMsg_DotFrame               :='Punktnetz';
  TeeMsg_Positions              :='Positionen';
  TeeMsg_NoGrid                 :='Kein Gitter';
  TeeMsg_NoPoint                :='Kein Punkt';
  TeeMsg_NoLine                 :='Keine Linie';
  TeeMsg_Labels                 :='Labels';
  TeeMsg_NoCircle               :='Kein Kreis';
  TeeMsg_Lines                  :='Linie';
  TeeMsg_Border                 :='Grenze';

  TeeMsg_SmithResistance      :='Widerstand';
  TeeMsg_SmithReactance       :='Reactance';

  TeeMsg_Column  :='Column';

  { 5.01 }
  TeeMsg_Separator            :='Trenner';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Trichter';
  TeeMsg_FunnelPercent        :='0.00%';
  TeeMsg_FunnelExceed         :='Überschreitet Quote';
  TeeMsg_FunnelWithin         :=' innerhalb Quote';
  TeeMsg_FunnelBelow          :=' oder unter der Quote';
  TeeMsg_CalendarSeries       :='Kalender';
  TeeMsg_DeltaPointSeries     :='DeltaPunkt';
  TeeMsg_ImagePointSeries     :='Bildpunkt';
  TeeMsg_ImageBarSeries       :='Bildersäule';
  TeeMsg_SeriesTextFieldZero  :='Reihentext: Feldindex sollte größer als Null sein.';

  { 5.02 }
  TeeMsg_Origin               :='Ursprung';
  TeeMsg_Transparency         :='Transparenz';
  TeeMsg_Box                  :='Box';
  TeeMsg_PageNumber           :='Seitennummer';
  TeeMsg_ExtrOut	      :='ExtrOut';
  TeeMsg_MildOut	      :='MildOut';

  { 5.02 } { Moved from TeeImageConstants.pas unit }
  TeeMsg_AsJPEG        :='als JPEG';
  TeeMsg_JPEGFilter    :='JPEG Dateien (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='als GIF';
  TeeMsg_GIFFilter     :='GIF Dateien (*.gif)|*.gif';
  TeeMsg_AsPNG         :='als PNG';
  TeeMsg_PNGFilter     :='PNG Dateien (*.png)|*.png';
  TeeMsg_AsPCX         :='als PCX';
  TeeMsg_PCXFilter     :='PCX Dateien (*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Gradient             := 'Übergang';
  TeeMsg_WantToSave           := 'Möchten Sie %s speichern?';
  TeeMsg_DragPoint            := 'Punkte ziehen';

  TeeMsg_Property            :='Eigenschaft';
  TeeMsg_Value               :='Wert';
  TeeMsg_Yes                 :='Ja';
  TeeMsg_No                  :='Nein';
  TeeMsg_Image               :='(Bild)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Punkt ziehen';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Version ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Kann TeeChart nicht importieren aus %s';
  TeeMsg_ActiveXVerbPrint    := '&Druckansicht...';
  TeeMsg_ActiveXVerbExport   := 'E&xportieren...';
  TeeMsg_ActiveXVerbImport   := '&Importieren...';
  TeeMsg_ActiveXVerbHelp     := '&Hilfe...';
  TeeMsg_ActiveXVerbAbout    := '&Über TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Fehlercode: %d Herunterladen: %s';
  TeeMsg_DatasourceError     := 'TeeChart Datenquelle ist keine Reihe oder RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Ungültiger Reihentyp';
  TeeMsg_AxisTextSrcError    := 'Ungültiger Achsentyp';
  TeeMsg_DelSeriesDatasource := 'Sind Sie sicher, daß Sie %s löschen wollen?';
  TeeMsg_OCXNoPrinter        := 'Kein Standarddrucker installiert.';
  TeeMsg_ActiveXPictureNotValid:='Bild ungültig';

  // 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='als &PDF';
  TeeMsg_PDFFilter        :='PDF-Dateien (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='als PostScript';
  TeeMsg_PSFilter         :='PostScript-Dateien (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horizontaler'#13'Bereich';
  TeeMsg_SelfStack        :='Gleiche aufeinander gestapelt';
  TeeMsg_DarkPen          :='Dunkler Rand';
  TeeMsg_SelectFolder     :='Datenbankordner wählen';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Verbindung:';

  // TeeProCo

  TeeMsg_FunctionSmooth       :='Glätten';
  TeeMsg_FunctionCross        :='Kreuzungspunkte';
  TeeMsg_GridTranspose        :='3D Gitter transponieren';
  TeeMsg_FunctionCompress     :='Kompression';
  TeeMsg_ExtraLegendTool      :='Extra Legend';
  TeeMsg_FunctionCLV          :='Standortwert'#13'schliessen';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Kanal Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oszillator';
  TeeMsg_SeriesAnimTool       :='Reihen-Animation';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Auf';
  TeeMsg_Down                 :='Ab';
  TeeMsg_GanttTool            :='Gantt ziehen';
  TeeMsg_XMLFile              :='XML Datei';
  TeeMsg_GridBandTool         :='Gitter Band Werkzeug';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='Maß';
  TeeMsg_GalleryGauges        :='Maße';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Turm';
  TeeMsg_SingleColor          :='Einzelne Farbe';
  TeeMsg_Cover                :='Abdeckung';
  TeeMsg_Cone                 :='Konus';
  TeeMsg_PieTool              :='Tortenschnitte';
end;

Procedure TeeCreateGerman;
begin
  if not Assigned(TeeGermanLanguage) then
  begin
    TeeGermanLanguage:=TLanguageStrings.Create;
    TeeGermanLanguage.Text:=

'GRADIENT EDITOR=Verlaufseditor'#13+
'GRADIENT=Verlauf'#13+
'DIRECTION=Richtung'#13+
'VISIBLE=Anzeigen'#13+
'TOP BOTTOM=Oben Unten'#13+
'BOTTOM TOP=Unten Oben'#13+
'LEFT RIGHT=Links Rechts'#13+
'RIGHT LEFT=Rechts Links'#13+
'FROM CENTER=Von Mitte'#13+
'FROM TOP LEFT=Von Oben Links'#13+
'FROM BOTTOM LEFT=Von Unten Links'#13+
'OK=Ok'#13+
'CANCEL=Abbrechen'#13+
'COLORS=Farben'#13+
'START=Beginn'#13+
'MIDDLE=Mitte'#13+
'END=Ende'#13+
'SWAP=Tausch'#13+
'NO MIDDLE=Keine Mitte'#13+
'TEEFONT EDITOR=Schrift Editor'#13+
'INTER-CHAR SPACING=Zwischenraum'#13+
'FONT=Schrift'#13+
'SHADOW=Schatten'#13+
'HORIZ. SIZE=Horiz. Größe'#13+
'VERT. SIZE=Vert. Größe'#13+
'COLOR=Farbe'#13+
'OUTLINE=Umriß'#13+
'OPTIONS=Optionen'#13+
'FORMAT=Format'#13+
'TEXT=Text'#13+
'LEFT=Links'#13+
'TOP=Oben'#13+
'AUTO=Auto'#13+
'CUSTOM=Benuzerdef.'#13+
'LEFT TOP=Links oben'#13+
'LEFT BOTTOM=Links unten'#13+
'RIGHT TOP=Rechts oben'#13+
'RIGHT BOTTOM=Rechts unten'#13+
'MULTIPLE AREAS=Mehrere Flächen'#13+
'NONE=Kein'#13+
'STACKED=Stapel'#13+
'STACKED 100%=Stapel 100%'#13+
'AREA=Fläche'#13+
'PATTERN=Muster'#13+
'STAIRS=Gestuft'#13+
'SOLID=Ausgefüllt'#13+
'CLEAR=Löschen'#13+
'HORIZONTAL=Horizontal'#13+
'VERTICAL=Vertikal'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Kreuz'#13+
'DIAG.CROSS=Diag.Kreuz'#13+
'AREA LINES=Trennlinie'#13+
'BORDER=Grenzen'#13+
'INVERTED=Invers'#13+
'INVERTED SCROLL=Scroll umkehren'#13+
'COLOR EACH=Jede farbig'#13+
'ORIGIN=Ursprung'#13+
'USE ORIGIN=Urspr. anwenden'#13+
'WIDTH=Breite'#13+
'HEIGHT=Höhe'#13+
'AXIS=Achse'#13+
'LENGTH=Länge'#13+
'SCROLL=Scroll'#13+
'BOTH=Beide'#13+
'AXIS INCREMENT=Skalierung'#13+
'INCREMENT=Schrittweite'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Eine Millisekunde'#13+
'ONE SECOND=Eine Sekunde'#13+
'FIVE SECONDS=Fünf Sekunden'#13+
'TEN SECONDS=Zehn Sekunden'#13+
'FIFTEEN SECONDS=Fünfzehn Sekunden'#13+
'THIRTY SECONDS=Dreißig Sekunden'#13+
'ONE MINUTE=Eine Minute'#13+
'FIVE MINUTES=Fünf Minuten'#13+
'TEN MINUTES=Zehn Minuten'#13+
'FIFTEEN MINUTES=Fünfzehn Minuten'#13+
'THIRTY MINUTES=Dreißig Minuten'#13+
'ONE HOUR=Eine Stunde'#13+
'TWO HOURS=Zwei Stunden'#13+
'SIX HOURS=Sechs Stunden'#13+
'TWELVE HOURS=Zwölf Stunden'#13+
'ONE DAY=Ein Tag'#13+
'TWO DAYS=Zwei Tage'#13+
'THREE DAYS=Drei Tage'#13+
'ONE WEEK=Eine Woche'#13+
'HALF MONTH=Halber Monat'#13+
'ONE MONTH=Ein Monat'#13+
'TWO MONTHS=Zwei Monate'#13+
'THREE MONTHS=Drei Monate'#13+
'FOUR MONTHS=Vier Monate'#13+
'SIX MONTHS=Sechs Monate'#13+
'ONE YEAR=Ein Jahr'#13+
'EXACT DATE TIME=Genaues Datum'#13+
'AXIS MAXIMUM AND MINIMUM=Achsen Maximum und Minimum'#13+
'VALUE=Wert'#13+
'TIME=Zeit'#13+
'LEFT AXIS=Linke Achse'#13+
'RIGHT AXIS=Rechte Achse'#13+
'TOP AXIS=Obere Achse'#13+
'BOTTOM AXIS=Untere Achse'#13+
'% BAR WIDTH=% Säulenbreite'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% Säulenoffset'#13+
'RECTANGLE=Rechteck'#13+
'PYRAMID=Pyramide'#13+
'INVERT. PYRAMID=Kopfst. Pyramid'#13+
'CYLINDER=Zylinder'#13+
'ELLIPSE=Ellipse'#13+
'ARROW=Pfeil'#13+
'RECT. GRADIENT=Recht. Farbfluß'#13+
'CONE=Kegel'#13+
'DARK BAR 3D SIDES=3D Dunkel'#13+
'BAR SIDE MARGINS=Randabstand der Säulen'#13+
'AUTO MARK POSITION=Auto Mark Position'#13+
'JOIN=verbinden'#13+
'DATASET=Datensatz'#13+
'APPLY=Anwenden'#13+
'SOURCE=Quelle'#13+
'MONOCHROME=Monochrom'#13+
'DEFAULT=Voreinst.'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Median'#13+
'WHISKER=Abweichung'#13+
'PATTERN COLOR EDITOR=Farbmuster Editor'#13+
'IMAGE=Bild'#13+
'BACK DIAGONAL=Diagonal Rück'#13+
'DIAGONAL CROSS=Gitter Diagonal'#13+
'FILL 80%=80% gefüllt'#13+
'FILL 60%=60% gefüllt'#13+
'FILL 40%=40% gefüllt'#13+
'FILL 20%=20% gefüllt'#13+
'FILL 10%=10% gefüllt'#13+
'ZIG ZAG=Zick zack'#13+
'VERTICAL SMALL=Vertikal klein'#13+
'HORIZ. SMALL=Horiz. klein'#13+
'DIAG. SMALL=Diag. klein'#13+
'BACK DIAG. SMALL=Diag. Hinten klein'#13+
'CROSS SMALL=Gitter klein'#13+
'DIAG. CROSS SMALL=Gitter Diag. klein'#13+
'DAYS=Tage'#13+
'WEEKDAYS=Wochentage'#13+
'TODAY=Heute'#13+
'SUNDAY=Sonntag'#13+
'TRAILING=Überhang'#13+
'MONTHS=Monate'#13+
'LINES=Linien'#13+
'SHOW WEEKDAYS=Wochentage'#13+
'UPPERCASE=Großgeschrieben'#13+
'TRAILING DAYS=Überhangtage'#13+
'SHOW TODAY=Aktueller Tag'#13+
'SHOW MONTHS=Monate'#13+
'CANDLE WIDTH=Kerzen Breite'#13+
'STICK=Stab'#13+
'BAR=Säule'#13+
'OPEN CLOSE=Offen Zu'#13+
'UP CLOSE=Farbe Steigend'#13+
'DOWN CLOSE=Farbe Fallend'#13+
'SHOW OPEN=Eröffnung'#13+
'SHOW CLOSE=Schluß'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D Dunkel'#13+
'EDITING=Bearbeiten'#13+
'CHART=Chart'#13+
'SERIES=Reihe'#13+
'DATA=Daten'#13+
'TOOLS=Tools'#13+
'EXPORT=Exportieren'#13+
'PRINT=Drucken'#13+
'GENERAL=Allgemein'#13+
'TITLES=Titel'#13+
'LEGEND=Legende'#13+
'PANEL=Rand'#13+
'PAGING=Seite'#13+
'WALLS=Wand'#13+
'3D=3D'#13+
'ADD=Hinzufügen'#13+
'DELETE=Entfernen'#13+
'TITLE=Titel'#13+
'CLONE=Duplizieren'#13+
'CHANGE=Ändern'#13+
'HELP=Hilfe'#13+
'CLOSE=Schließen'#13+
'TEECHART PRINT PREVIEW=TeeChart Druckansicht'#13+
'PRINTER=Drucker'#13+
'SETUP=Eigenscha.'#13+
'ORIENTATION=Ausrichtung'#13+
'PORTRAIT=Hochformat'#13+
'LANDSCAPE=Querformat'#13+
'MARGINS (%)=Rand (%)'#13+
'DETAIL=Detail'#13+
'MORE=Mehr'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Zurücksetzen'#13+
'VIEW MARGINS=Rand anzeigen'#13+
'PROPORTIONAL=Proportional'#13+
'CIRCLE=Kreis'#13+
'VERTICAL LINE=Vert. Linie'#13+
'HORIZ. LINE=Horiz. Linie'#13+
'TRIANGLE=Dreieck'#13+
'INVERT. TRIANGLE=Kopfst. Dreieck'#13+
'LINE=Linie'#13+
'DIAMOND=Diamant'#13+
'CUBE=Würfel'#13+
'STAR=Stern'#13+
'TRANSPARENT=Transparent'#13+
'HORIZ. ALIGNMENT=Horiz. Ausrichtung'#13+
'CENTER=Mitte'#13+
'RIGHT=Rechts'#13+
'ROUND RECTANGLE=Rechteck abgerundet'#13+
'ALIGNMENT=Ausrichtung'#13+
'BOTTOM=Unten'#13+
'UNITS=Einheit'#13+
'PIXELS=Pixel'#13+
'AXIS ORIGIN=Achsenursprung'#13+
'ROTATION=Drehung'#13+
'CIRCLED=gerunded'#13+
'3 DIMENSIONS=3 Dimensionen'#13+
'RADIUS=Radius'#13+
'ANGLE INCREMENT=Schrittweite Winkel'#13+
'RADIUS INCREMENT=Schrittweite Radius'#13+
'CLOSE CIRCLE=Kreisrund'#13+
'PEN=Stift'#13+
'LABELS=Beschriftung'#13+
'ROTATED=Gedreht'#13+
'CLOCKWISE=Uhrzeigersinn'#13+
'INSIDE=Innen'#13+
'ROMAN=Roman'#13+
'HOURS=Stunden'#13+
'MINUTES=Minuten'#13+
'SECONDS=Sekunden'#13+
'START VALUE=Startwert'#13+
'END VALUE=Endwert'#13+
'TRANSPARENCY=Transparenz'#13+
'DRAW BEHIND=Dahinter zeichnen'#13+
'COLOR MODE=Farbmodus'#13+
'STEPS=Schritte'#13+
'RANGE=Bereich'#13+
'PALETTE=Palette'#13+
'PALE=Blaß'#13+
'STRONG=Stark'#13+
'GRID SIZE=Gittergröße'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Tiefe'#13+
'IRREGULAR=Irregulär'#13+
'GRID=Gitter'#13+
'ALLOW DRAG=Ziehen erlauben'#13+
'VERTICAL POSITION=Vertikale Position'#13+
'LEVELS POSITION=Ebenen Position'#13+
'LEVELS=Ebenen'#13+
'NUMBER=Anzahl'#13+
'LEVEL=Ebenen'#13+
'AUTOMATIC=Automatisch'#13+
'SNAP=Snap'#13+
'FOLLOW MOUSE=Maus folgen'#13+
'STACK=Stapel'#13+
'HEIGHT 3D=3D Höhe'#13+
'LINE MODE=Linienmodus'#13+
'OVERLAP=Überlappen'#13+
'STACK 100%=Stapel 100%'#13+
'CLICKABLE=anklickbar'#13+
'AVAILABLE=Vorhanden'#13+
'SELECTED=Ausgewählt'#13+
'DATASOURCE=Datenquelle'#13+
'GROUP BY=Group by'#13+
'CALC=Calc'#13+
'OF=of'#13+
'SUM=Sum'#13+
'COUNT=Anzahl'#13+
'HIGH=Oben'#13+
'LOW=Unten'#13+
'AVG=Avg'#13+
'HOUR=Hour'#13+
'DAY=Tag'#13+
'WEEK=Woche'#13+
'WEEKDAY=Wochentag'#13+
'MONTH=Monat'#13+
'QUARTER=Quartal'#13+
'YEAR=Jahr'#13+
'HOLE %=Loch %'#13+
'RESET POSITIONS=Positionen rücksetzen'#13+
'MOUSE BUTTON=Maustaste'#13+
'ENABLE DRAWING=Zeichnung erlauben'#13+
'ENABLE SELECT=Auswahl erlauben'#13+
'ENHANCED=Erhöht'#13+
'ERROR WIDTH=Fehler T Breite'#13+
'WIDTH UNITS=Einheit'#13+
'PERCENT=Prozent'#13+
'LEFT AND RIGHT=Links und Rechts'#13+
'TOP AND BOTTOM=Oben und Unten'#13+
'BORDER EDITOR=Linieneditor'#13+
'CALCULATE EVERY=Jede berechnen'#13+
'ALL POINTS=Alle Werte'#13+
'NUMBER OF POINTS=Anzahl der Werte'#13+
'RANGE OF VALUES=Wertereihe'#13+
'FIRST=Erster'#13+
'LAST=Letzter'#13+
'TEEPREVIEW EDITOR=TeeVorschau Editor'#13+
'ALLOW MOVE=Bewegung erlauben'#13+
'ALLOW RESIZE=Resize erlauben'#13+
'DRAG IMAGE=Grafik ziehen'#13+
'AS BITMAP=Als Bitmap'#13+
'SHOW IMAGE=Grafik anzeigen'#13+
'MARGINS=Abstände'#13+
'SIZE=Größe'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Blickwinkel'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horiz. Offset'#13+
'VERT. OFFSET=Vert. Offset'#13+
'PERSPECTIVE=Perspektive'#13+
'ANGLE=Winkel'#13+
'ORTHOGONAL=Orthogonal'#13+
'ZOOM TEXT=Zoom Text'#13+
'SCALES=Skalierung'#13+
'TICKS=Teilstriche'#13+
'MINOR=Unterticks'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Schrittweite'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=Log Basis'#13+
'LOGARITHMIC=Logarithmisch'#13+
'MIN. SEPARATION %=Min. Abstand %'#13+
'MULTI-LINE=Multi-linie'#13+
'LABEL ON AXIS=Beschriftung auf Achsen'#13+
'ROUND FIRST=Ersten Runden'#13+
'MARK=Marker'#13+
'LABELS FORMAT=Beschrift.- Format'#13+
'EXPONENTIAL=Exponentiell'#13+
'DEFAULT ALIGNMENT=Voreinstellung Abstand'#13+
'LEN=Länge'#13+
'INNER=Inner'#13+
'AT LABELS ONLY=Nur zu Beschr.'#13+
'CENTERED=Mittig'#13+
'POSITION %=Position %'#13+
'START %=Beginn %'#13+
'END %=Ende %'#13+
'OTHER SIDE=andere Seite'#13+
'AXES=Achsen'#13+
'BEHIND=Hinter'#13+
'CLIP POINTS=Punkte abschn.'#13+
'PRINT PREVIEW=Druckvorschau'#13+
'MINIMUM PIXELS=Minimum Pixel'#13+
'ALLOW=Zoom zulassen'#13+
'ANIMATED=animiert'#13+
'ALLOW SCROLL=Scrollen zulassen'#13+
'TEEOPENGL EDITOR=TeeOpenGL Editor'#13+
'AMBIENT LIGHT=Umgebungslicht'#13+
'SHININESS=Beleuchtung'#13+
'FONT 3D DEPTH=3DSchrifttiefe'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Umriß Schrift'#13+
'SMOOTH SHADING=Fließender Schatten'#13+
'LIGHT=Licht'#13+
'Y=Y'#13+
'INTENSITY=Intensität'#13+
'BEVEL=Rahmen'#13+
'FRAME=Rahmen'#13+
'ROUND FRAME=Runder Rahmen'#13+
'LOWERED=Versenkt'#13+
'RAISED=Erhöht'#13+
'POSITION=Ausrichtung'#13+
'SYMBOLS=Symbole'#13+
'TEXT STYLE=Textstil'#13+
'LEGEND STYLE=Legendenstil'#13+
'VERT. SPACING=Vert. Abstand'#13+
'SERIES NAMES=Namen'#13+
'SERIES VALUES=Werte'#13+
'LAST VALUES=Letzte Werte'#13+
'PLAIN=Plain'#13+
'LEFT VALUE=Linker Wert'#13+
'RIGHT VALUE=Rechter Wert'#13+
'LEFT PERCENT=Prozent Links'#13+
'RIGHT PERCENT=Prozent Rechts'#13+
'X VALUE=X-Wert'#13+
'X AND VALUE=X und Wert'#13+
'X AND PERCENT=X und Prozent'#13+
'CHECK BOXES=Ankreuzfelder'#13+
'DIVIDING LINES=Trennlinie'#13+
'FONT SERIES COLOR=Chart-Farbe'#13+
'POSITION OFFSET %=Abstand Oben %'#13+
'MARGIN=Rand'#13+
'RESIZE CHART=Originalgröße'#13+
'CONTINUOUS=Fortlaufend'#13+
'POINTS PER PAGE=Werte pro Seite'#13+
'SCALE LAST PAGE=Letzte Seite einteilen'#13+
'CURRENT PAGE LEGEND=Aktuelle Legende'#13+
'PANEL EDITOR=Hintergrund Editor'#13+
'BACKGROUND=Hintergrund'#13+
'BORDERS=Ränder'#13+
'BACK IMAGE=Hintergrund'#13+
'STRETCH=Dehnen'#13+
'TILE=Kacheln'#13+
'BEVEL INNER=Innenrand'#13+
'BEVEL OUTER=Außen'#13+
'MARKS=Marker'#13+
'DATA SOURCE=Datenquelle'#13+
'SORT=Sortieren'#13+
'CURSOR=Drehen'#13+
'SHOW IN LEGEND=In Legende Anzeigen'#13+
'FORMATS=Formate'#13+
'VALUES=Werte'#13+
'PERCENTS=Prozente'#13+
'HORIZONTAL AXIS=Horizontale Achse'#13+
'DATETIME=Datum/Uhrzeit'#13+
'VERTICAL AXIS=Vertikale Achse'#13+
'ASCENDING=Aufsteigend'#13+
'DESCENDING=Absteigend'#13+
'DRAW EVERY=Alle zeichnen'#13+
'CLIPPED=Abgeschnitten'#13+
'ARROWS=Pfeile'#13+
'MULTI LINE=Multi-linie'#13+
'ALL SERIES VISIBLE=Alle Reihen anzeigen'#13+
'LABEL=Label'#13+
'LABEL AND PERCENT=Label und Prozent'#13+
'LABEL AND VALUE=Label und Wert'#13+
'PERCENT TOTAL=Prozent Total'#13+
'LABEL AND PERCENT TOTAL=Label and Prozent Total'#13+
'X AND Y VALUES=X und Y Werte'#13+
'MANUAL=Manuell'#13+
'RANDOM=Zufall'#13+
'FUNCTION=Funktion'#13+
'NEW=Neu'#13+
'EDIT=Editiren'#13+
'PERSISTENT=Ständig'#13+
'ADJUST FRAME=Rahmen fest'#13+
'SUBTITLE=Untertitel'#13+
'SUBFOOT=2. Fußzeile'#13+
'FOOT=Fußzeile'#13+
'VISIBLE WALLS=Wände Anzeigen'#13+
'BACK=Hinten'#13+
'DIF. LIMIT=Dif. Limit'#13+
'ABOVE=Über'#13+
'WITHIN=Innerhalb'#13+
'BELOW=Unter'#13+
'CONNECTING LINES=Verknüpfungslinien'#13+
'BROWSE=Suchen in'#13+
'TILED=Ausgefüllt'#13+
'INFLATE MARGINS=Randabstand'#13+
'SQUARE=Quadrat'#13+
'DOWN TRIANGLE=Kopfst. Dreieck'#13+
'SMALL DOT=Kleine Punkte'#13+
'GLOBAL=Global'#13+
'SHAPES=Formen'#13+
'BRUSH=Pinsel'#13+
'DELAY=Verzögerung'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Mausaktion'#13+
'MOVE=Bewegen'#13+
'CLICK=Klick'#13+
'DRAW LINE=Linie zeichnen'#13+
'DASH=Strich'#13+
'DOT=Punkt'#13+
'DASH DOT=Strich Punkt'#13+
'DASH DOT DOT=Strich Punkt Punkt'#13+
'EXPLODE BIGGEST=Größter Extra'#13+
'TOTAL ANGLE=Gesamtwinkel'#13+
'GROUP SLICES=Gruppierung'#13+
'BELOW %=Unter %'#13+
'BELOW VALUE=Unter Wert'#13+
'OTHER=Andere(r)'#13+
'PATTERNS=Muster'#13+
'SIZE %=Größe %'#13+
'SERIES DATASOURCE TEXT EDITOR=DatenquellenText Editor'#13+
'FIELDS=Felder'#13+
'NUMBER OF HEADER LINES=Anzahl der  Titelzeilen'#13+
'SEPARATOR=Teiler'#13+
'COMMA=Komma'#13+
'SPACE=Leerzeichen'#13+
'TAB=Tabulator'#13+
'FILE=Datei'#13+
'WEB URL=Web URL'#13+
'LOAD=Laden'#13+
'C LABELS=C Labels'#13+
'R LABELS=R Labels'#13+
'C PEN=C Stift'#13+
'R PEN=R Stift'#13+
'STACK GROUP=Stapel gruppieren'#13+
'MULTIPLE BAR=Mehrere Säulen'#13+
'SIDE=Nebeneinander'#13+
'SIDE ALL=Alle Nebeneinander'#13+
'DRAWING MODE=Zeichnungsmodus'#13+
'WIREFRAME=Gitternetz'#13+
'DOTFRAME=Punktnetz'#13+
'SMOOTH PALETTE=Weicher Übergang'#13+
'SIDE BRUSH=Seitenmuster'#13+
'ABOUT TEECHART PRO V7.0=Info TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Besuchen Sie uns im Web!'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Chart Stil auswählen'#13+
'DATABASE CHART=Datenbank-Chart'#13+
'NON DATABASE CHART=Kein Datenbank-Chart'#13+
'SELECT A DATABASE TABLE=Datenbanktabelle auswählen'#13+
'ALIAS=Alias'#13+
'TABLE=Tabelle'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Gewünschte Felder für Chart auswählen'#13+
'SELECT A TEXT LABELS FIELD=Text-Beschriftungsfeld auswählen'#13+
'CHOOSE THE DESIRED CHART TYPE=Gewünschten Charttyp auswählen'#13+
'2D=2D'#13+
'CHART PREVIEW=Chart Vorschau'#13+
'SHOW LEGEND=Legende anzeigen'#13+
'SHOW MARKS=Marker anzeigen'#13+
'< BACK=< Vorheriger'#13+
'EXPORT CHART=Chart Exportieren'#13+
'PICTURE=Bild'#13+
'NATIVE=TeeDatei'#13+
'KEEP ASPECT RATIO=Verhältnis beibehalten'#13+
'INCLUDE SERIES DATA=Inklusive Reihendaten'#13+
'FILE SIZE=Dateigröße'#13+
'DELIMITER=Abgrenzung'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabelle'#13+
'EXCEL=Excel'#13+
'COLON=Doppelpunkt'#13+
'INCLUDE=Einschließen'#13+
'POINT LABELS=Labels anzeigen'#13+
'POINT INDEX=Index anzeigen'#13+
'HEADER=Kopfzeile'#13+
'COPY=Kopieren'#13+
'SAVE=Speichern'#13+
'SEND=Senden'#13+
'FUNCTIONS=Funktionen'#13+
'ADX=ADX'#13+
'AVERAGE=Duchschnitt'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Dividieren'#13+
'EXP. AVERAGE=Exp.Durchschn.'#13+
'EXP.MOV.AVRG.=Exp.gleit.Durchschn.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Gleit.Durchschn.'#13+
'MULTIPLY=Multiplizieren'#13+
'R.S.I.= R.S.I.'#13+
'ROOT MEAN SQ.=Quadratwurzel'#13+
'STD.DEVIATION=Std.-Abweichung'#13+
'STOCHASTIC=Stochastik Tief'#13+
'SUBTRACT=Subtrahieren'#13+
'SOURCE SERIES=Quellreihe'#13+
'TEECHART GALLERY=TeeChart Gallerie'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduktion'#13+
'COMPRESSION=Kompression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=nächster'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'GRAY SCALE=Graustufe'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Qualität'#13+
'PERFORMANCE=Erscheinung'#13+
'QUALITY=Qualität'#13+
'SPEED=Schnell'#13+
'COMPRESSION LEVEL=Kompressionsgrad'#13+
'CHART TOOLS GALLERY=Chart Tools Gallerie'#13+
'ANNOTATION=Anmerkung'#13+
'AXIS ARROWS=Achspfeile'#13+
'COLOR BAND=Farbband'#13+
'COLOR LINE=Farbige Linie'#13+
'DRAG MARKS=Ziehmarken'#13+
'MARK TIPS=Tip-Marken'#13+
'NEAREST POINT=Nächster Punkt'#13+
'ROTATE=Drehen'#13+
'YES=Ja'#13+
'POINTS=Punkte'#13+
'MINOR GRID=Gitter fein'#13+
'STAIRS INVERTED=Inverse Treppen'#13+
'AXIS LINE=Achsenlinie'#13+
'ROUND=Rund'#13+
'FLAT=Flach'#13+
'OFF=Aus'#13+
'ON=An'#13+
'PIE SLICES=Kuchenstücke'#13+
'GANTT DRAG=Gantt ziehen'#13+
'SERIES ANIMATION=Reihen-Animation'#13+
'GRID BAND TOOL=Gitterbänder'#13+
'3D GRID TRANSPOSE=3D Transposition'#13+
'GAUGE=Instrument'#13+
'RADIAL OFFSET=Radialer Ursprung'#13+
'END POINT=Endpunkt'#13+
'POINTER=Zeiger'#13+
'DISTANCE=Abstand'#13+
'SHOW LABELS=Beschr. anzeigen'#13+
'SHADOW EDITOR=Schatten Editor'#13+
'OUTLINE GRADIENT=Verlauf Umriss'#13+
'ARROW HEAD=Pfeilspitze'#13+
'NUMBER OF SAMPLE VALUES=Anz. Beispielwerte'#13+
'SQUARED=Viereckig'#13+
'DEFAULT BORDER=Normaler Rand'#13+
'SHOW PAGE NUMBER=Seitanzahl anzeigen'#13+
'BINARY=Binär'#13+
'POINT COLORS=Punktfarbe'#13+
'CALLOUT=Verweis'#13+

{$IFDEF TEEOCX}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- ADO Datenquelle auswählen'#13+
'CONNECTION=Verbindung'#13+
'DATASET=Datensatz'#13+
'TABLE=Table'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=System tables'#13+
'LOGIN PROMPT=Login prompt'#13+
'SELECT=Auswahl'#13+
'TEECHART IMPORT=TeeChart Import'#13+
'IMPORT CHART FROM=Chart importieren aus'#13+
'IMPORT NOW=Importieren'#13+
'EDIT CHART=Chart ändern'#13+
{$ENDIF}

// 6.0

'PERIOD=Zeitraum'#13+
'UP=Auf'#13+
'DOWN=Ab'#13+
'TEXT ALIGNMENT=Textausrichtung'#13+
'AVAILABLE LANGUAGES=Verfügbare Sprachen'#13+
'CHOOSE A LANGUAGE=Sprache wählen'#13+
'CALCULATE USING=Berechnen mit'#13+
'EVERY NUMBER OF POINTS=Alle (Anzahl von) Punkte(n)'#13+
'EVERY RANGE=Jede(r) (Anzahl) Bereich(e)'#13+
'INCLUDE NULL VALUES=Nullwerte einbeziehen'#13+
'ENTER DATE=Datum eingeben'#13+
'ENTER TIME=Zeit eingeben'#13+
'BEVEL SIZE=Abrundungs.'#13+
'DEVIATION=Abweichung'#13+
'UPPER=Obere(r)'#13+
'LOWER=Untere(r)'#13+
'NOTHING=Nichts'#13+
'LEFT TRIANGLE=Linkes Dreieck'#13+
'RIGHT TRIANGLE=Rechtes Dreieck'#13+
'SHOW PREVIOUS BUTTON=Voherige Schaltfläche anzeigen'#13+
'SHOW NEXT BUTTON=Nächste Schaltfläche anzeigen'#13+
'CONSTANT=Konstante'#13+
'SHOW COLORS=Farben anzeigen'#13+
'XYZ SERIES=XYZ-Reihe'#13+
'SHOW X VALUES=X-Werte anzeigen'#13+
'DELETE ROW=Zeile löschen'#13+
'VOLUME SERIES=Band'#13+
'ACCUMULATE=Anhäufen'#13+
'SINGLE=Einzel'#13+
'REMOVE CUSTOM COLORS=Benutzerdefinierte Farben entfernen'#13+
'STEP=Schritt'#13+
'USE PALETTE MINIMUM=Palette-Minimum benutzen'#13+
'AXIS MAXIMUM=Achsen-Maximum'#13+
'AXIS CENTER=Achsen-Zentrum'#13+
'AXIS MINIMUM=Achsen-Minimum'#13+
'DRAG REPAINT=Bemalung ziehen'#13+
'NO LIMIT DRAG=Unbegrenztes Ziehen'#13+
'DAILY (NONE)=Täglich (Kein'#13+
'WEEKLY=Wöchentlich'#13+
'MONTHLY=Monatlich'#13+
'BI-MONTHLY=Zweimonatlich'#13+
'QUARTERLY=Vierteljählich'#13+
'YEARLY=Jährlich'#13+
'DATETIME PERIOD=Datum/Zeit Zeitraum'#13+
'SMOOTH=Glätten'#13+
'INTERPOLATE=Interpolieren'#13+
'START X=Start X'#13+
'NUM. POINTS='#13+
'COLOR EACH LINE=Jede Linie färben'#13+
'CASE SENSITIVE=Gross-/Kleinschreibung beachten'#13+
'SORT BY=Sortieren'#13+
'(NONE)=(Kein)'#13+
'CALCULATION=Berechnung'#13+
'DRAG STYLE='#13+
'WEIGHT=Gewicht'#13+
'EDIT LEGEND=Legende bearbeiten'#13+
'DRAW ALL=Alles zeichnen'#13+
'IGNORE NULLS=Nullwerte ignorieren'#13+
'OFFSET=Ausgleich'#13+
'Z %=Z %'#13+
'LIGHT 0=Licht 0'#13+
'LIGHT 1=Licht 1'#13+
'LIGHT 2=Licht 2'#13+
'DRAW STYLE=Stil zeichnen'#13+
'SEPARATION=Abstand'#13+
'ROUND BORDER=Runde Umrandung'#13+
'RESIZE PIXELS TOLERANCE=Toleranz Pixel'#13+
'FULL REPAINT=Gesamtes Wiederbemalen'#13+
'BAND 1=Band 1'#13+
'BAND 2=Band 2'#13+
'GRID 3D SERIES=Gitter 3D Reihe'#13+
'TRANSPOSE NOW=Jetzt transponieren'#13+
'PERIOD 1=Zeitraum 1'#13+
'PERIOD 2=Zeitraum 2'#13+
'PERIOD 3=Zeitraum 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Exponent. Linie'#13+
'WEIGHTED=Gewichtet'#13+
'WEIGHTED BY INDEX=Nach Index gewichtet'#13+
'DARK BORDER=Dunkler Rand'#13+
'PIE SERIES=Tortendiagramm-Reihe'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Absondern'#13+
'BOX SIZE=Kastengrösse'#13+
'REVERSAL AMOUNT='#13+
'PERCENTAGE=Prozentsatz'#13+
'COMPLETE R.M.S.=Gesamt-R.M.S.'#13+
'BUTTON=Schaltfläche'#13+
'START AT MIN. VALUE=Mit Minimlwert beginnen'#13+
'EXECUTE !=Ausführen !'#13+
'IMAG. SYMBOL=Bild-Symbol'#13+
'FACTOR=Faktor'#13+
'SELF STACK=Gleiche aufeinander stapeln'#13+
'SIDE LINES=Seitenlinien'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Diagramm aus Formatvorlage (*.TEE Datei)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=TeeChart Formatvorlage öffnen aus'#13+
'EXPORT DIALOG=Export-Dialog'#13+
'CLOSE LOCATION VALUE=Standortwert schliessen'#13+
'COMMODITY CHANNEL INDEX=COMMODITY Kanal Index'#13+
'CROSS POINTS=Kreuzungspunkte'#13+
'EXP.TREND=Exponentieller Trend'#13+
'ON BALANCE VOLUME='#13+
'SMOOTHING=Glätten'#13+
'TREND=Trend'#13+
'VOLUME OSCILLATOR='#13+
'STATS=Statistiken'#13+
'RADIAL=Radial'#13+
'BALANCE='#13+
'DRAG POINT=Punktezieher'#13+
'EXTRA LEGEND=Zusätliche Legende'#13+
'COVER=Abdeckung'#13+
'ARROW WIDTH=Pfeilbreite'#13+
'ARROW HEIGHT=Pfeilhöhe'#13+
'DEFAULT COLOR=Standardfarbe'#13+
'VALUE SOURCE=Wertquelle'#13
;
  end;
end;

Procedure TeeSetGerman;
begin
  TeeCreateGerman;
  TeeLanguage:=TeeGermanLanguage;
  TeeGermanConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeGermanLanguage);
end.
