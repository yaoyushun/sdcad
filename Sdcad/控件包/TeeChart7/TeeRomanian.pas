unit TeeRomanian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeRomanianLanguage:TStringList=nil;

Procedure TeeSetRomanian;
Procedure TeeCreateRomanian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeRomanianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='Prima valoare din legenda trebuie sa fie > 0';
  TeeMsg_LegendColorWidth   :='Latimea benzilor colorate din legenda > 0%';
  TeeMsg_SeriesSetDataSource:='Nu exista o diagrama-parinte pentru validarea sursei';
  TeeMsg_SeriesInvDataSource:='Nu exista o sursa de date valida: %s';
  TeeMsg_FillSample         :='Numarul valorilor pentru FillSample trebuie sa fie > 0';
  TeeMsg_AxisLogDateTime    :='Axa DateTime nu poate fi logaritmica';
  TeeMsg_AxisLogNotPositive :='Valorile Min si Max ale trebuie sa fie >= 0';
  TeeMsg_AxisLabelSep       :='Distanta dintre etichete % trebuie sa fie > 0';
  TeeMsg_AxisIncrementNeg   :='Incrementul pe axa trebuie sa fie >= 0';
  TeeMsg_AxisMinMax         :='Valoarea minima de pe axa trebuie sa fie <= Maxim';
  TeeMsg_AxisMaxMin         :='Valoarea maxima de pe axa trebuie sa fie >= Minim';
  TeeMsg_AxisLogBase        :='Baza axei logaritmice trebuie sa fie >= 2';
  TeeMsg_MaxPointsPerPage   :='Maximum de puncte pe pagina trebuie sa fie >= 0';
  TeeMsg_3dPercent          :='Procentul efectului 3D trebuie sa fie intre %d si %d';
  TeeMsg_CircularSeries     :='Nu sunt permise dependinte circulare pentru serie';
  TeeMsg_WarningHiColor     :='Pentru o vizualizare mai buna adincimea de culoare trebuie sa fie cel putin 16k';

  TeeMsg_DefaultPercentOf   :='%s din %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'din %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Titlul de pe axa';
  TeeMsg_AxisLabels         :='Eticheta axei';
  TeeMsg_RefreshInterval    :='Intervalul de reimprospatare trebuie sa fie intre 0 si 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart, autoreferire interzisa!';
  TeeMsg_GalleryLine        :='Linie';
  TeeMsg_GalleryPoint       :='Punct';
  TeeMsg_GalleryArea        :='Arie';
  TeeMsg_GalleryBar         :='Bara';
  TeeMsg_GalleryHorizBar    :='Bara Oriz.';
  TeeMsg_Stack              :='Stiva';
  TeeMsg_GalleryPie         :='Placinta';
  TeeMsg_GalleryCircled     :='Circulara';
  TeeMsg_GalleryFastLine    :='Linie Rapida';
  TeeMsg_GalleryHorizLine   :='Linie Oriz.';

  TeeMsg_PieSample1         :='Masini';
  TeeMsg_PieSample2         :='Telefoane';
  TeeMsg_PieSample3         :='Mese';
  TeeMsg_PieSample4         :='Monitoare';
  TeeMsg_PieSample5         :='Lampi';
  TeeMsg_PieSample6         :='Tastaturi';
  TeeMsg_PieSample7         :='Biciclete';
  TeeMsg_PieSample8         :='Scaune';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editam %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Extinsa';
  TeeMsg_GalleryFunctions   :='Functii';

  TeeMsg_EditChart          :='E&diteaza Graficul...';
  TeeMsg_PrintPreview       :='&Previzualizare...';
  TeeMsg_ExportChart        :='E&xporta Graficul...';
  TeeMsg_CustomAxes         :='Axe Personalizate...';

  TeeMsg_InvalidEditorClass :='%s: Clasa Editor este invalida: %s';
  TeeMsg_MissingEditorClass :='%s: nu are editor';

  TeeMsg_GalleryArrow       :='Sageata';

  TeeMsg_ExpFinish          :='&Sfirsit';
  TeeMsg_ExpNext            :='&Urmatorul >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Proiectare';
  TeeMsg_GanttSample2       :='Prototipizare';
  TeeMsg_GanttSample3       :='Dezvoltare';
  TeeMsg_GanttSample4       :='Vanzari';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testare';
  TeeMsg_GanttSample7       :='Productie';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Versiune Noua';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Schimba titlul seriei';
  TeeMsg_NewSeriesTitle     :='Noul titlu al seriei:';
  TeeMsg_DateTime           :='Data/Ora';
  TeeMsg_TopAxis            :='Axa Superioara';
  TeeMsg_BottomAxis         :='Axa Inferioara';
  TeeMsg_LeftAxis           :='Axa Stinga';
  TeeMsg_RightAxis          :='Axa Dreapta';

  TeeMsg_SureToDelete       :='Sterge %s?';
  TeeMsg_DateTimeFormat     :='For&matul Data/Ora:';
  TeeMsg_Default            :='Implicit';
  TeeMsg_ValuesFormat       :='For&mat Valorilor:';
  TeeMsg_Maximum            :='Maximul';
  TeeMsg_Minimum            :='Minimul';
  TeeMsg_DesiredIncrement   :='Incrementul %s dorit';

  TeeMsg_IncorrectMaxMinValue:='Valoare incorecta. Motivul: %s';
  TeeMsg_EnterDateTime      :='Introdu [Numarul de zile] [oo:mm:ss]';

  TeeMsg_SureToApply        :='Aplici modificarile?';
  TeeMsg_SelectedSeries     :='(Seriile selectate)';
  TeeMsg_RefreshData        :='&Reimprospatarea datelor';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='443';
  TeeMsg_FunctionAdd        :='Suma';
  TeeMsg_FunctionSubtract   :='Scadere';
  TeeMsg_FunctionMultiply   :='Inmultire';
  TeeMsg_FunctionDivide     :='Impartire';
  TeeMsg_FunctionHigh       :='Maximul';
  TeeMsg_FunctionLow        :='Minimul';
  TeeMsg_FunctionAverage    :='Media';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Bule';
  TeeMsg_FunctionNone       :='Copie';

  TeeMsg_None               :='(nici unul)';

  TeeMsg_PrivateDeclarations:='{ Declarari private }';
  TeeMsg_PublicDeclarations :='{ Declarari publice }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Marimea pointerului trebuie sa fie mai mare decit 0';
  TeeMsg_About              :='&Despre TeeChart...';

  tcAdditional              :='Aditional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Inregistrare unica';
  TeeMsg_AskDataSource      :='&Sursa de date:';

  TeeMsg_Summary            :='Sumar';

  TeeMsg_FunctionPeriod     :='Perioada fuctiei trebuie sa fie >= 0';

  TeeMsg_WizardTab          :='Afaceri';
  TeeMsg_TeeChartWizard     :='Asistentul TeeChart';

  TeeMsg_ClearImage         :='&Sterge';
  TeeMsg_BrowseImage        :='S&electeaza...';

  TeeMsg_WizardSureToClose  :='Esti sigur ca vrei sa inchizi Asistentul TeeChart?';
  TeeMsg_FieldNotFound      :='Campul %s nu exista';

  TeeMsg_DepthAxis          :='Axa pentru adincime';
  TeeMsg_PieOther           :='Alta';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Placinta';
  TeeMsg_ValuesBar          :='Bara';
  TeeMsg_ValuesAngle        :='Unghi';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Sfirsit';
  TeeMsg_ValuesGanttNextTask:='UrmatoareaSarcina';
  TeeMsg_ValuesBubbleRadius :='Raza';
  TeeMsg_ValuesArrowEndX    :='X final';
  TeeMsg_ValuesArrowEndY    :='Y final';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Titlul';
  TeeMsg_Foot               :='Subsolul paginii';
  TeeMsg_Period		    :='Perioada';
  TeeMsg_PeriodRange        :='Domeniul periodei';
  TeeMsg_CalcPeriod         :='Calculeaza %s la fiecare:';
  TeeMsg_SmallDotsPen       :='Puncte mici';

  TeeMsg_InvalidTeeFile     :='Grafic invalid in fisierul *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Format invalid al fisierului *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Fisierul *.'+TeeMsg_TeeExtension+' este gol';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Axa graficului';
  TeeMsg_ChartAxesCategoryDesc   := 'Proprietatile si evenimentele axei graficului';
  TeeMsg_ChartWallsCategoryName  := 'Peretii graficului';
  TeeMsg_ChartWallsCategoryDesc  := 'Proprietatile si evenimentele peretilor graficului';
  TeeMsg_ChartTitlesCategoryName := 'Titlurile graficului';
  TeeMsg_ChartTitlesCategoryDesc := 'Proprietatile si evenimentele titlurilor graficului';
  TeeMsg_Chart3DCategoryName     := 'Grafic 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Proprietatile si evenimentele graficului 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalizare ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serie...';

  TeeMsg_PageOfPages            :='Pagina %d din %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primul';
  TeeMsg_Prior  :='Precedentul';
  TeeMsg_Next   :='Urmatorul';
  TeeMsg_Last   :='Ultimul';
  TeeMsg_Insert :='Inserare';
  TeeMsg_Delete :='Stergere';
  TeeMsg_Edit   :='Editare';
  TeeMsg_Post   :='Validare';
  TeeMsg_Cancel :='Anulare';

  TeeMsg_All    :='(Toate)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='ca &Bitmap';
  TeeMsg_BMPFilter    :='Bitmap (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='ca &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Proprietatea panoului nu este setata in formatul de export';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Fara margine';
  TeeMsg_Dotted    :='Punctuat';
  TeeMsg_Colors    :='Culori';
  TeeMsg_Filled    :='Umplut';
  TeeMsg_Marks     :='Marcaje';
  TeeMsg_Stairs    :='Trepte';
  TeeMsg_Points    :='Puncte';
  TeeMsg_Height    :='Inaltime';
  TeeMsg_Hollow    :='Cavitate';
  TeeMsg_Point2D   :='Punct 2D';
  TeeMsg_Triangle  :='Triunghi';
  TeeMsg_Star      :='Stea';
  TeeMsg_Circle    :='Cerc';
  TeeMsg_DownTri   :='Triunghi in jos';
  TeeMsg_Cross     :='Cruce';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Fara Linii';
  TeeMsg_Stack100  :='Stiva 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Piramida inv.';
  TeeMsg_Sides     :='Flancuri';
  TeeMsg_SideAll   :='Toate flancurile';
  TeeMsg_Patterns  :='Tipar';
  TeeMsg_Exploded  :='Explodat';
  TeeMsg_Shadow    :='Umbra';
  TeeMsg_SemiPie   :='Semi placinta';
  TeeMsg_Rectangle :='Dreptunghi';
  TeeMsg_VertLine  :='Linie Verticala';
  TeeMsg_HorizLine :='Linie orizontala';
  TeeMsg_Line      :='Linie';
  TeeMsg_Cube      :='Cub';
  TeeMsg_DiagCross :='Cruce Diag.';

  TeeMsg_CanNotFindTempPath    :='Nu gasesc directorul Temp';
  TeeMsg_CanNotCreateTempChart :='Nu pot crea fisierul Temp';
  TeeMsg_CanNotEmailChart      :='Nu pot expedia TeeChart prin email. Eroare Mapi: %d';

  TeeMsg_SeriesDelete :='Stergerea seriei: valoarea indicelui %d depaseste limita (0 la %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='ca &JPEG';
  TeeMsg_JPEGFilter    :='JPEG file (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='ca &GIF';
  TeeMsg_GIFFilter     :='GIF file (*.gif)|*.gif';
  TeeMsg_AsPNG         :='ca &PNG';
  TeeMsg_PNGFilter     :='PNG file (*.png)|*.png';
  TeeMsg_AsPCX         :='ca PC&X';
  TeeMsg_PCXFilter     :='PCX file (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Limba...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Lumanare';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Suprafata';
  TeeMsg_GalleryContour     :='Contur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punct 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Gogoasa';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Bara 3D';
  TeeMsg_GalleryBigCandle   :='Lumanare mare';
  TeeMsg_GalleryLinePoint   :='Linie-punct';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Cascada';
  TeeMsg_GalleryWindRose    :='Roza vinturilor';
  TeeMsg_GalleryClock       :='Ceas';
  TeeMsg_GalleryColorGrid   :='Grila de culori';
  TeeMsg_GalleryBoxPlot     :='Dispersie';
  TeeMsg_GalleryHorizBoxPlot:='Dispersie orizontala';
  TeeMsg_GalleryBarJoin     :='Bare unite';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Harta';

  TeeMsg_PolyDegreeRange    :='Gradul polinomului trebuie sa fie intre 1 si 20';
  TeeMsg_AnswerVectorIndex   :='Indicele vectorului de raspuns trebuie sa fie intre 1 si %d';
  TeeMsg_FittingError        :='Nu pot face interpolarea';
  TeeMsg_PeriodRange         :='Perioada trebuie sa fie >= 0';
  TeeMsg_ExpAverageWeight    :='Ponderea mediei exponentiale trebuie sa fie intre 0 si 1';
  TeeMsg_GalleryErrorBar     :='Bara eroare';
  TeeMsg_GalleryError        :='Eroare';
  TeeMsg_GalleryHighLow      :='Max-Min';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div.';
  TeeMsg_FunctionExpAverage  :='Media exponentiala';
  TeeMsg_FunctionMovingAverage:='Media Mobila';
  TeeMsg_FunctionExpMovAve   :='Media Mobila Exponentiala';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Interpolare';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Trend exp.';
  TeeMsg_FunctionLogTrend    :='Trend log.';
  TeeMsg_FunctionCumulative  :='Cumulativ';
  TeeMsg_FunctionStdDeviation:='Devierea standard';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Abatererea medie patratica';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stocastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Numara';
  TeeMsg_LoadChart           :='Deschide TeeChart...';
  TeeMsg_SaveChart           :='Salveaza TeeChart...';
  TeeMsg_TeeFiles            :='Fisiere TeeChart Pro';

  TeeMsg_GallerySamples      :='Altele';
  TeeMsg_GalleryStats        :='Statistica';

  TeeMsg_CannotFindEditor    :='Nu gasesc editorul seriei: %s';


  TeeMsg_CannotLoadChartFromURL:='Eroare: %d descarcind graficul de la URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Eroare: %d descarcind datele seriei de la URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Deschide';
  TeeMsg_ValuesHigh          :='Maximul';
  TeeMsg_ValuesLow           :='Minimul';
  TeeMsg_ValuesClose         :='Inchide';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='Eroare Standard';

  TeeMsg_Grid3D              :='Grila 3D';

  TeeMsg_LowBezierPoints     :='Numarul de puncte pentru Bezier trebuie sa fie > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Editare';
  TeeCommanMsg_Print    :='Imprimare';
  TeeCommanMsg_Copy     :='Copie';
  TeeCommanMsg_Save     :='Salvare';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotire: %d° Elevatie: %d°';
  TeeCommanMsg_Rotate   :='Roteste';

  TeeCommanMsg_Moving   :='Offset oriz.: %d Offset Vert.: %d';
  TeeCommanMsg_Move     :='Muta';

  TeeCommanMsg_Zooming  :='Marire: %d %%';
  TeeCommanMsg_Zoom     :='Mareste';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Adancime';

  TeeCommanMsg_Chart    :='Grafic';
  TeeCommanMsg_Panel    :='Tablou';

  TeeCommanMsg_RotateLabel:='Trage %s pentru a roti';
  TeeCommanMsg_MoveLabel  :='Trage %s pentru a muta';
  TeeCommanMsg_ZoomLabel  :='Trage %s pentru a mari';
  TeeCommanMsg_DepthLabel :='Trage %s pentru a redimensiona 3D';

  TeeCommanMsg_NormalLabel:='Foloseste butonul din stinga pentru a mari/micsora, butonul din dreapta pentru derulare';
  TeeCommanMsg_NormalPieLabel:='Trage de o felie din placinta pentru a o exploda';

  TeeCommanMsg_PieExploding :='Felia: %d Explodata: %d %%';

  TeeMsg_TriSurfaceLess        :='Numarul de puncte trebuie sa fie >= 4';
  TeeMsg_TriSurfaceAllColinear :='Toate punctele sunt colineare';
  TeeMsg_TriSurfaceSimilar     :='Puncte identice - comanda anulata';
  TeeMsg_GalleryTriSurface     :='Suprafata triangulara';

  TeeMsg_AllSeries :='Toate seriile';
  TeeMsg_Edit      :='Editare';

  TeeMsg_GalleryFinancial    :='Financiar';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Marcaje';
  TeeMsg_AxisArrowTool :='Sagetile axelor';
  TeeMsg_DrawLineTool  :='Trage linii';
  TeeMsg_NearestTool   :='Puncte vecine';
  TeeMsg_ColorBandTool :='banda de culori';
  TeeMsg_ColorLineTool :='Linii de colori';
  TeeMsg_RotateTool    :='Roteste';
  TeeMsg_ImageTool     :='Imagine';
  TeeMsg_MarksTipTool  :='Informatii pentru marcaje';

  TeeMsg_CantDeleteAncestor  :='Nu pot sterge ancestorul';

  TeeMsg_Load	          :='Incarca';
  TeeMsg_NoSeriesSelected :='Nici o serie nu este selectata';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafic';
  TeeMsg_CategorySeriesActions :='Seria graficului';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Comuta 2D / 3D';
  TeeMsg_ActionSeriesActive     := 'Fa &activ';
  TeeMsg_ActionSeriesActiveHint := 'Arata/ascunde Seria';
  TeeMsg_ActionEditHint         := 'Editeaza graficul';
  TeeMsg_ActionEdit             := '&Editeaza...';
  TeeMsg_ActionCopyHint         := 'Copiaza in Clipboard';
  TeeMsg_ActionCopy             := '&Copiaza';
  TeeMsg_ActionPrintHint        := 'Previzualizeaza';
  TeeMsg_ActionPrint            := '&Imprima...';
  TeeMsg_ActionAxesHint         := 'Arata/ascunde axele';
  TeeMsg_ActionAxes             := '&Axe';
  TeeMsg_ActionGridsHint        := 'Arata/ascunde Grilele';
  TeeMsg_ActionGrids            := '&Grilele';
  TeeMsg_ActionLegendHint       := 'Arata/ascunde Legenda';
  TeeMsg_ActionLegend           := '&Legenda';
  TeeMsg_ActionSeriesEditHint   := 'Editeaza Seriile';
  TeeMsg_ActionSeriesMarksHint  := 'Arata/ascunde Marcajele';
  TeeMsg_ActionSeriesMarks      := '&Marcaje';
  TeeMsg_ActionSaveHint         := 'Salveaza graficul';
  TeeMsg_ActionSave             := '&Salveaza...';

  TeeMsg_CandleBar              := 'Bara';
  TeeMsg_CandleNoOpen           := 'Nu se deschide';
  TeeMsg_CandleNoClose          := 'Nu se inchide';
  TeeMsg_NoLines                := 'Fara linii';
  TeeMsg_NoHigh                 := 'Fara valoarea maxima';
  TeeMsg_NoLow                  := 'Fara valoarea minima';
  TeeMsg_ColorRange             := 'Intervalul de culori';
  TeeMsg_WireFrame              := 'Cadru de sarma';
  TeeMsg_DotFrame               := 'Cadru de puncte';
  TeeMsg_Positions              := 'Pozitii';
  TeeMsg_NoGrid                 := 'Fara grila';
  TeeMsg_NoPoint                := 'Fara puncte';
  TeeMsg_NoLine                 := 'Fara linii';
  TeeMsg_Labels                 := 'Etichete';
  TeeMsg_NoCircle               := 'Fara cercuri';
  TeeMsg_Lines                  := 'Linii';
  TeeMsg_Border                 := 'Margine';

  TeeMsg_SmithResistance      := 'Rezistenta';
  TeeMsg_SmithReactance       := 'Reactanta';

  TeeMsg_Column               := 'Coloana';

  { 5.01 }
  TeeMsg_Separator            := 'Separator';
  TeeMsg_FunnelSegment        := 'Segment';
  TeeMsg_FunnelSeries         := 'Camin/Cos de fum';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Peste cota';
  TeeMsg_FunnelWithin         := ' cuprins in cota';
  TeeMsg_FunnelBelow          := ' sau mai putin decit cota';
  TeeMsg_CalendarSeries       := 'Calendar';
  TeeMsg_DeltaPointSeries     := 'DeltaPoint';
  TeeMsg_ImagePointSeries     := 'Puncte Imagine';
  TeeMsg_ImageBarSeries       := 'Bare Imagine';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: Cimpul index trebuie sa fie mai mare decit 0';

  { 5.02 }
  TeeMsg_Origin               := 'Origine';
  TeeMsg_Transparency         := 'Trasparenta';
  TeeMsg_Box		      := 'Cutie';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Numarul paginii';

  { 5.03 }
  TeeMsg_DragPoint            := 'Punct de tragere';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateRomanian;
begin
  if not Assigned(TeeRomanianLanguage) then
  begin
    TeeRomanianLanguage:=TStringList.Create;
    TeeRomanianLanguage.Text:=

'GRADIENT EDITOR=Editorul Gradientului'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Directie'#13+
'VISIBLE=Visibil'#13+
'TOP BOTTOM=De sus in jos'#13+
'BOTTOM TOP=De jos in sus'#13+
'LEFT RIGHT=De la stinga la drepata'#13+
'RIGHT LEFT=De la dreapta la stinga'#13+
'FROM CENTER=Din Centru'#13+
'FROM TOP LEFT=De sus la stinga'#13+
'FROM BOTTOM LEFT=De jos la stinga'#13+
'OK=Ok'#13+
'CANCEL=Anuleaza'#13+
'COLORS=Culori'#13+
'START=Initializare'#13+
'MIDDLE=Centru'#13+
'END=Iesire'#13+
'SWAP=Schimb'#13+
'NO MIDDLE=Fara centru'#13+
'TEEFONT EDITOR=Editorul tipului Caractere'#13+
'INTER-CHAR SPACING=Spatiul dintre caractere'#13+
'FONT=Caracter'#13+
'SHADOW=Umbra'#13+
'HORIZ. SIZE=Dimensiune Oriz.'#13+
'VERT. SIZE=Dimensiune Vert.'#13+
'COLOR=Culoare'#13+
'OUTLINE=Contur'#13+
'OPTIONS=Optiuni'#13+
'FORMAT=Format'#13+
'TEXT=Text'#13+
'GRADIENT=Gradient'#13+
'POSITION=Pozitie'#13+
'LEFT=Stinga'#13+
'TOP=Sus'#13+
'AUTO=Auto'#13+
'CUSTOM=Personalizat'#13+
'LEFT TOP=Stinga sus'#13+
'LEFT BOTTOM=Stinga jos'#13+
'RIGHT TOP=Dreapta sus'#13+
'RIGHT BOTTOM=Dreapta jos'#13+
'MULTIPLE AREAS=Arii Multiple'#13+
'NONE=Niciunu'#13+
'STACKED=Stocat'#13+
'STACKED 100%=Stocat 100%'#13+
'AREA=Arie'#13+
'PATTERN=Tipar'#13+
'STAIRS=Trepte'#13+
'SOLID=Solid'#13+
'CLEAR=Curat'#13+
'HORIZONTAL=Orizontal'#13+
'VERTICAL=Vertical'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Cruce'#13+
'DIAG.CROSS=Cruce Diag.'#13+
'AREA LINES=Linii Arie'#13+
'BORDER=Margine'#13+
'INVERTED=Inversat'#13+
'INVERTED SCROLL=Derulator invers'#13+
'COLOR EACH=Colorare'#13+
'ORIGIN=Origine'#13+
'USE ORIGIN=Foloseste Originea'#13+
'WIDTH=Latime'#13+
'HEIGHT=Inaltime'#13+
'AXIS=Axa'#13+
'LENGTH=Lungime'#13+
'SCROLL=Derulare'#13+
'START=Start'#13+
'END=Sfirsit'#13+
'BOTH=Ambele'#13+
'AXIS INCREMENT=Incrementul pe Axa'#13+
'INCREMENT=Increment'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=O Miliseconda'#13+
'ONE SECOND=O Secunda'#13+
'FIVE SECONDS=Cinci Seconde'#13+
'TEN SECONDS=Zece Seconde'#13+
'FIFTEEN SECONDS=Cinsprezece Seconde'#13+
'THIRTY SECONDS=Treizeci Seconde'#13+
'ONE MINUTE=Un Minut'#13+
'FIVE MINUTES=Cinci Minute'#13+
'TEN MINUTES=Zece Minute'#13+
'FIFTEEN MINUTES=Cinsprezece Minute'#13+
'THIRTY MINUTES=Treizeci Minute'#13+
'ONE HOUR=O Ora'#13+
'TWO HOURS=Doua Ore'#13+
'SIX HOURS=Sase Ore'#13+
'TWELVE HOURS=Douasprezece Ore'#13+
'ONE DAY=O zi'#13+
'TWO DAYS=Doua zile'#13+
'THREE DAYS=Trei zile'#13+
'ONE WEEK=O saptamina'#13+
'HALF MONTH=Jumatate de luna'#13+
'ONE MONTH=O Luna'#13+
'TWO MONTHS=Doua luni'#13+
'THREE MONTHS=Trei luni'#13+
'FOUR MONTHS=Patru luni'#13+
'SIX MONTHS=Sase Luni'#13+
'ONE YEAR=Un An'#13+
'EXACT DATE TIME=Data Exacta'#13+
'AXIS MAXIMUM AND MINIMUM=Maximul si munimul de pe axa'#13+
'VALUE=Valoarea'#13+
'TIME=Ora'#13+
'LEFT AXIS=Axa Stinga'#13+
'RIGHT AXIS=Axa Dreapta'#13+
'TOP AXIS=Axa Superioara'#13+
'BOTTOM AXIS=Axa Inferioara'#13+
'% BAR WIDTH=Latimea % Barei'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=Deplasare % Barei'#13+
'RECTANGLE=Dreptunghi'#13+
'PYRAMID=Piramida'#13+
'INVERT. PYRAMID=Piramida Roversata'#13+
'CYLINDER=Cilindru'#13+
'ELLIPSE=Elipsa'#13+
'ARROW=Sageata'#13+
'RECT. GRADIENT=Gradient Dreptunghic'#13+
'CONE=Con'#13+
'DARK BAR 3D SIDES=Fete intunecate ale Barei 3D'#13+
'BAR SIDE MARGINS=Marginile Laterale ale Barei'#13+
'AUTO MARK POSITION=Marcare automata a pozitiei'#13+
'BORDER=Margine'#13+
'JOIN=Uniune'#13+
'BAR SIDE MARGINS=Marginile Laterale ale Barei'#13+
'DATASET=Set de Date'#13+
'APPLY=Aplica'#13+
'SOURCE=Sursa'#13+
'MONOCHROME=Monocromatic'#13+
'DEFAULT=Implicit'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'LENGTH=Lungime'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Fir'#13+
'PATTERN COLOR EDITOR=Editor de tipare'#13+
'IMAGE=Imagine'#13+
'NONE=Nicunul'#13+
'BACK DIAGONAL=Diagonala Inversata'#13+
'CROSS=Cruce'#13+
'DIAGONAL CROSS=Cruce Diagonala'#13+
'FILL 80%=Umplere 80%'#13+
'FILL 60%=Umplere 60%'#13+
'FILL 40%=Umplere 40%'#13+
'FILL 20%=Umplere 20%'#13+
'FILL 10%=Umplere 10%'#13+
'ZIG ZAG=Zig-zag'#13+
'VERTICAL SMALL=Verticala Mica'#13+
'HORIZ. SMALL=Oriz. Mica'#13+
'DIAG. SMALL=Diag. Mica'#13+
'BACK DIAG. SMALL=Diag. Inv. Mica'#13+
'CROSS SMALL=Cruce Mica'#13+
'DIAG. CROSS SMALL=Cruce Diag. Mica'#13+
'PATTERN COLOR EDITOR=Editorul Tiparului de Culori'#13+
'OPTIONS=Optiuni'#13+
'DAYS=Zile'#13+
'WEEKDAYS=Zilele Saptamanii'#13+
'TODAY=Astazi'#13+
'SUNDAY=Duminica'#13+
'TRAILING=Urmatoare'#13+
'MONTHS=Luni'#13+
'LINES=Linii'#13+
'SHOW WEEKDAYS=Afiseaza zilele saptam.'#13+
'UPPERCASE=Majuscule'#13+
'TRAILING DAYS=Zilele urmatoare'#13+
'SHOW TODAY=Afiseaza astazi'#13+
'SHOW MONTHS=Afiseaza astazi'#13+
'SHOW PREVIOUS BUTTON=Afiseaza butonul precedent'#13+
'SHOW NEXT BUTTON=Afiseaza butonul urmator'#13+
'CANDLE WIDTH=Latimea lumanarii'#13+
'STICK=Baston'#13+
'BAR=Bara'#13+
'OPEN CLOSE=Inchide sus'#13+
'UP CLOSE=Inchide sus'#13+
'DOWN CLOSE=Inchide jos'#13+
'SHOW OPEN=Arata deschis'#13+
'SHOW CLOSE=Arata inchis'#13+
'DRAW 3D=Disen 3D'#13+
'DARK 3D=3D intunecat'#13+
'EDITING=Editez'#13+
'CHART=Grafic'#13+
'SERIES=Serie'#13+
'DATA=Date'#13+
'TOOLS=Instrumente'#13+
'EXPORT=Exporta'#13+
'PRINT=Imprimat'#13+
'GENERAL=General'#13+
'TITLES=Titluri'#13+
'LEGEND=Legenda'#13+
'PANEL=Panou'#13+
'PAGING=Pagina'#13+
'WALLS=Pareti'#13+
'3D=3D'#13+
'ADD=Adauga'#13+
'DELETE=Sterge'#13+
'TITLE=Titlu'#13+
'CLONE=Duplicat'#13+
'CHANGE=Schimba'#13+
'HELP=Ajutor'#13+
'CLOSE=Inchide'#13+
'IMAGE=Imagine'#13+
'TEECHART PRINT PREVIEW=Previzualizare TeeChart'#13+
'PRINTER=Imprimanta'#13+
'SETUP=Parametriz.'#13+
'ORIENTATION=Orientare'#13+
'PORTRAIT=Portret'#13+
'LANDSCAPE=Peisaj'#13+
'MARGINS (%)=Margini (%)'#13+
'DETAIL=Detaliu'#13+
'MORE=Mai mult'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Resetare Margini'#13+
'VIEW MARGINS=Vezi Marginile'#13+
'PROPORTIONAL=Proportional'#13+
'RECTANGLE=Dreptunghiular'#13+
'CIRCLE=Cerc'#13+
'VERTICAL LINE=Linie Verticala'#13+
'HORIZ. LINE=Linie Orizontala'#13+
'TRIANGLE=Triunghi'#13+
'INVERT. TRIANGLE=Triunghi Inversat'#13+
'LINE=Linie'#13+
'DIAMOND=Diamante'#13+
'CUBE=Cub'#13+
'DIAGONAL CROSS=Cruce Diagonala'#13+
'STAR=Stea'#13+
'TRANSPARENT=Trasparent'#13+
'HORIZ. ALIGNMENT=Alineamnt Orizontal'#13+
'LEFT=Stinga'#13+
'CENTER=Centru'#13+
'RIGHT=Dreapta'#13+
'ROUND RECTANGLE=Dreptunghi Rotunjit'#13+
'ALIGNMENT=Alineament'#13+
'TOP=Virf'#13+
'BOTTOM=Baza'#13+
'RIGHT=Dreapta'#13+
'BOTTOM=Baza'#13+
'UNITS=Unitati'#13+
'PIXELS=Pixeli'#13+
'AXIS=Axa'#13+
'AXIS ORIGIN=Originea Axei'#13+
'ROTATION=Rotatie'#13+
'CIRCLED=Rotunjit'#13+
'3 DIMENSIONS=3 Dimensiuni'#13+
'RADIUS=Raza'#13+
'ANGLE INCREMENT=Increment Unghiular'#13+
'RADIUS INCREMENT=Increment Radial'#13+
'CLOSE CIRCLE=Cerc Inchis'#13+
'PEN=Creion'#13+
'CIRCLE=Cerc'#13+
'LABELS=Etichete'#13+
'VISIBLE=Visibil'#13+
'ROTATED=Rotit'#13+
'CLOCKWISE=Sens Orar'#13+
'INSIDE=Inauntru'#13+
'ROMAN=Roman'#13+
'HOURS=Ore'#13+
'MINUTES=Minute'#13+
'SECONDS=Seconde'#13+
'START VALUE=Valoare Initiala'#13+
'END VALUE=Valorea Finala'#13+
'TRANSPARENCY=Trasparenta'#13+
'DRAW BEHIND=Diseneaza in spate'#13+
'COLOR MODE=Mod Color'#13+
'STEPS=Trepte'#13+
'RANGE=Interval'#13+
'PALETTE=Paleta'#13+
'PALE=Palid'#13+
'STRONG=Tare'#13+
'GRID SIZE=Dimensiunea Grilei'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Adincime'#13+
'IRREGULAR=Neregulat'#13+
'GRID=Grila'#13+
'VALUE=Valoare'#13+
'ALLOW DRAG=Permite tragerea'#13+
'VERTICAL POSITION=Pozitie Verticala'#13+
'PEN=Creion'#13+
'LEVELS POSITION=Pozitia Nivelelor'#13+
'LEVELS=Nivele'#13+
'NUMBER=Numar'#13+
'LEVEL=Nivel'#13+
'AUTOMATIC=Automat'#13+
'BOTH=Ambele'#13+
'SNAP=Ajustare'#13+
'FOLLOW MOUSE=Urmeaza mouseul'#13+
'STACK=Stiva'#13+
'HEIGHT 3D=Inaltimea 3D'#13+
'LINE MODE=Modul Linie'#13+
'STAIRS=Trepte'#13+
'NONE=Niciunul'#13+
'OVERLAP=Suprapunere'#13+
'STACK=Stiva'#13+
'STACK 100%=Stiva 100%'#13+
'CLICKABLE=Clickabil'#13+
'LABELS=Etichete'#13+
'AVAILABLE=Disponibil'#13+
'SELECTED=Selectat'#13+
'DATASOURCE=Sursa de Date'#13+
'GROUP BY=Grupat dupa'#13+
'CALC=Calc'#13+
'OF=de'#13+
'SUM=Suma'#13+
'COUNT=Numara'#13+
'HIGH=Inalt'#13+
'LOW=Baza'#13+
'AVG=Medie'#13+
'HOUR=Ora'#13+
'DAY=Zi'#13+
'WEEK=Saptamina'#13+
'WEEKDAY=Zi din saptamina'#13+
'MONTH=Luna'#13+
'QUARTER=Patrime'#13+
'YEAR=An'#13+
'HOLE %=Gaura %'#13+
'RESET POSITIONS=Reseteaza Pozitiile'#13+
'MOUSE BUTTON=Butonul Mouseului'#13+
'ENABLE DRAWING=Permite Desenarea'#13+
'ENABLE SELECT=Permite Selectarea'#13+
'ENHANCED=Imbunatatit'#13+
'ERROR WIDTH=Latimea Eroare'#13+
'WIDTH UNITS=Unitatile Latimii'#13+
'PERCENT=Procent'#13+
'PIXELS=Pixeli'#13+
'LEFT AND RIGHT=Stinga si Dreapta'#13+
'TOP AND BOTTOM=Virf si baza'#13+
'BORDER=Margine'#13+
'BORDER EDITOR=Editorul de Margini'#13+
'DASH=Linie'#13+
'DOT=Punct'#13+
'DASH DOT=Linie Punct'#13+
'DASH DOT DOT=Linie Punct Punct'#13+
'CALCULATE EVERY=Calculeaza Fiecare'#13+
'ALL POINTS=Toate Punctele'#13+
'NUMBER OF POINTS=Numerul Puncte'#13+
'RANGE OF VALUES=Intervalul de Valori'#13+
'FIRST=Primul'#13+
'CENTER=Centru'#13+
'LAST=Ultimul'#13+
'TEEPREVIEW EDITOR=Editorul TeePreviw'#13+
'ALLOW MOVE=Permite Mutarea.'#13+
'ALLOW RESIZE=Permite Redimensionarea.'#13+
'DRAG IMAGE=Trage Imaginea'#13+
'AS BITMAP=Ca Bitmap'#13+
'SHOW IMAGE=Afiseaza Imaginea'#13+
'MARGINS=Margini'#13+
'SIZE=Marimea'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ROTATION=Rotatie'#13+
'ELEVATION=Inaltime'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Deplas. Orizontala'#13+
'VERT. OFFSET=Deplas. Verticala'#13+
'PERSPECTIVE=Prospectiva'#13+
'ANGLE=Unghi'#13+
'ORTHOGONAL=Ortogonal'#13+
'ZOOM TEXT=Mareste Textul'#13+
'SCALES=Scaleaza'#13+
'TITLE=Titlu'#13+
'TICKS=Marcaje'#13+
'MINOR=Minori'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Incrementul Dorit'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=Baza Logaritmica'#13+
'LOGARITHMIC=Logaritmic'#13+
'TITLE=Titlu'#13+
'MIN. SEPARATION %=Distanta Min. %'#13+
'MULTI-LINE=Multi-linie'#13+
'LABEL ON AXIS=Eticheta pe Axa'#13+
'ROUND FIRST=Rotunjeste Prima'#13+
'MARK=Semn'#13+
'LABELS FORMAT=Formatul Etichetelor'#13+
'EXPONENTIAL=Exponential'#13+
'DEFAULT ALIGNMENT=Aliniere Implicita'#13+
'LEN=Lungime'#13+
'AXIS=Axa'#13+
'INNER=Intern'#13+
'GRID=Grila'#13+
'AT LABELS ONLY=Numai la Etichete'#13+
'CENTERED=Centrat'#13+
'COUNT=Numara'#13+
'POSITION %=Pozitie %'#13+
'START %=Pornire %'#13+
'END %=Sfirsit %'#13+
'OTHER SIDE=Alta Parte'#13+
'AXES=Axa'#13+
'BEHIND=In spate'#13+
'CLIP POINTS=Puncte de taiere'#13+
'PRINT PREVIEW=Previzualizare'#13+
'MINIMUM PIXELS=Minimum de Pixeli'#13+
'MOUSE BUTTON=Butonul Mouseului'#13+
'ALLOW=Permite'#13+
'ANIMATED=Animat'#13+
'VERTICAL=Vertical'#13+
'RIGHT=Dreapta'#13+
'ALLOW SCROLL=Permite Derularea'#13+
'TEEOPENGL EDITOR=Editorul TeeOpenGL'#13+
'AMBIENT LIGHT=Lumina Ambianta'#13+
'SHININESS=Stralucire'#13+
'FONT 3D DEPTH=Adincimea caracterelor 3D'#13+
'ACTIVE=Activ'#13+
'FONT OUTLINES=Conturul Caracterelor'#13+
'SMOOTH SHADING=Umbrire usoara'#13+
'LIGHT=Lumina'#13+
'Y=Y'#13+
'INTENSITY=Intensitate'#13+
'BEVEL=Tesitura'#13+
'FRAME=Cadru'#13+
'ROUND FRAME=Cadru Rotunjit'#13+
'LOWERED=Micsorat'#13+
'RAISED=Inaltat'#13+
'POSITION=Pozitie'#13+
'SYMBOLS=Simboluri'#13+
'TEXT STYLE=Stilul Textului'#13+
'LEGEND STYLE=Stilul Legendei'#13+
'VERT. SPACING=Distantarea Vert.'#13+
'AUTOMATIC=Automat'#13+
'SERIES NAMES=Numele Seriilor'#13+
'SERIES VALUES=Valorile Seriilor'#13+
'LAST VALUES=Ultimele Valori'#13+
'PLAIN=Clar'#13+
'LEFT VALUE=Valorea din Stinga'#13+
'RIGHT VALUE=Valore din Dreapta'#13+
'LEFT PERCENT=Procentul Sting'#13+
'RIGHT PERCENT=Procentul Drept'#13+
'X VALUE=Valoarea X'#13+
'VALUE=Valoare'#13+
'PERCENT=Procent'#13+
'X AND VALUE=X si Valoarea'#13+
'X AND PERCENT=X si Procentul'#13+
'CHECK BOXES=Caseta de control'#13+
'DIVIDING LINES=Linii de Divizare'#13+
'FONT SERIES COLOR=Coloarea Fontului pentru Serie'#13+
'POSITION OFFSET %=Deplasare %'#13+
'MARGIN=Margine'#13+
'RESIZE CHART=Ridimensioneaza Graficul'#13+
'WIDTH UNITS=Unitati de Latime'#13+
'CONTINUOUS=Continuu'#13+
'POINTS PER PAGE=Puncte per Pagina'#13+
'SCALE LAST PAGE=Scaleaza Ultima Pagina'#13+
'CURRENT PAGE LEGEND=Legenda Paginii Curente'#13+
'PANEL EDITOR=Editorul Panoului'#13+
'BACKGROUND=Fundal'#13+
'BORDERS=Margini'#13+
'BACK IMAGE=Imaginea din spate'#13+
'STRETCH=Intindere'#13+
'TILE=Aranjeaza'#13+
'CENTER=Centru'#13+
'BEVEL INNER=Tesitura Inauntru'#13+
'LOWERED=Micsorat'#13+
'RAISED=Ridicat'#13+
'BEVEL OUTER=Tesitura Inafara'#13+
'MARKS=Semne'#13+
'DATA SOURCE=Sursa de Date'#13+
'SORT=Ordoneaza'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=Afiseaza in Legenda'#13+
'FORMATS=Format'#13+
'VALUES=Valori'#13+
'PERCENTS=Procente'#13+
'HORIZONTAL AXIS=Axa Orizontala'#13+
'TOP AND BOTTOM=Virf si baza'#13+
'DATETIME=Data/Ora'#13+
'VERTICAL AXIS=Axa Verticala'#13+
'LEFT=Stinga'#13+
'RIGHT=Dreapta'#13+
'LEFT AND RIGHT=Stinga si Dreapta'#13+
'ASCENDING=Ascendent'#13+
'DESCENDING=Descendent'#13+
'DRAW EVERY=Disen. Fiecare'#13+
'CLIPPED=Ascuns'#13+
'ARROWS=Sageti'#13+
'MULTI LINE=Multi-linie'#13+
'ALL SERIES VISIBLE=Toate Seriile Vizibile'#13+
'LABEL=Eticheta'#13+
'LABEL AND PERCENT=Eticheta si procent'#13+
'LABEL AND VALUE=Eticheta si Valoare'#13+
'PERCENT TOTAL=Procent Total'#13+
'LABEL AND PERCENT TOTAL=Eticheta si Percent Total'#13+
'X VALUE=Valoare X'#13+
'X AND Y VALUES=Valori X si Y'#13+
'MANUAL=Manual'#13+
'RANDOM=Aleator'#13+
'FUNCTION=Functie'#13+
'NEW=Nou'#13+
'EDIT=Edit'#13+
'DELETE=Sterge'#13+
'PERSISTENT=Persistent'#13+
'ADJUST FRAME=Ajusteaza Cadrul'#13+
'SUBTITLE=Subtitlu'#13+
'SUBFOOT=Sub nota de subsol'#13+
'FOOT=Nota de Subsol'#13+
'DELETE=Sterge'#13+
'VISIBLE WALLS=Pereti Visibili'#13+
'BACK=Inapoi'#13+
'DIF. LIMIT=Limita Dif.'#13+
'ABOVE=Deasupra'#13+
'WITHIN=Cuprins in'#13+
'BELOW=Dedesubt'#13+
'CONNECTING LINES=Linii de Conectare'#13+
'SERIES=Serie'#13+
'PALE=Palid'#13+
'STRONG=Tare'#13+
'HIGH=Virf'#13+
'LOW=Baza'#13+
'BROWSE=Rasfoieste'#13+
'TILED=Aliniat'#13+
'INFLATE MARGINS=Umfla Marginile'#13+
'ROUND=Rotunjit'#13+
'SQUARE=Patrat'#13+
'FLAT=Plan'+#13+
'DOWN TRIANGLE=Triunghi in jos'#13+
'SMALL DOT=Punct Mic'#13+
'GLOBAL=Global'#13+
'SHAPES=Forme'#13+
'BRUSH=Pensula'#13+
'BORDER=Margine'#13+
'COLOR=Culoare'#13+
'DELAY=Intirziere'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Actiunea Mouseului'#13+
'MOVE=Misca'#13+
'CLICK=Clic'#13+
'BRUSH=Pensula'#13+
'DRAW LINE=Deseneaza Linie'#13+
'BORDER EDITOR=Editorul de Margine'#13+
'DASH=Linie'#13+
'DOT=Punct'#13+
'DASH DOT=Linie Punct'#13+
'DASH DOT DOT=Linie Punct Punct'#13+
'EXPLODE BIGGEST=Separa Partile'#13+
'TOTAL ANGLE=Anghiul Total'#13+
'GROUP SLICES=Gruparea partilor'#13+
'BELOW %=Mai mic decit %'#13+
'BELOW VALUE=Mai Mic Decit Valoarea'#13+
'OTHER=Altele'#13+
'PATTERNS=Tipare'#13+
'CLOSE CIRCLE=Cerc Inchis'#13+
'VISIBLE=Visibil'#13+
'CLOCKWISE=In Sens Orar'#13+
'SIZE %=Dimen. %'#13+
'SERIES DATASOURCE TEXT EDITOR=Mod Text Editor Pentru Sursa Seriei'#13+
'FIELDS=Cimpuri'#13+
'NUMBER OF HEADER LINES=Numarul Liniilor de Antet'#13+
'SEPARATOR=Separator'#13+
'COMMA=Virgula'#13+
'SPACE=Spatiu'#13+
'TAB=Tabulator'#13+
'FILE=Fisier'#13+
'WEB URL=Web URL'#13+
'LOAD=Incarca'#13+
'C LABELS=Etichete C'#13+
'R LABELS=Etichete R'#13+
'C PEN=Creion C'#13+
'R PEN=Creion R'#13+
'STACK GROUP=Grup Stiva'#13+
'USE ORIGIN=Foloseste Originea'#13+
'MULTIPLE BAR=Bare Multiple'#13+
'SIDE=Parte'#13+
'STACKED 100%=Stiva 100%'#13+
'SIDE ALL=Toate Partile'#13+
'BRUSH=Pensula'#13+
'DRAWING MODE=Modul de Desenare'#13+
'SOLID=Solid'#13+
'WIREFRAME=Cadru de Sirma'#13+
'DOTFRAME=Cadru de Puncte'#13+
'SMOOTH PALETTE=Paleta Lina'#13+
'SIDE BRUSH=Modelor Lateral'#13+
'ABOUT TEECHART PRO V7.0=Despre TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Toate drepturile rezervate'#13+
'VISIT OUR WEB SITE !=Viziteaza siteul nostru!'#13+
'TEECHART WIZARD=Asistentul TeeChart'#13+
'SELECT A CHART STYLE=Selecteaza un tip de grafic'#13+
'DATABASE CHART=Grafic pentru baze de date'#13+
'NON DATABASE CHART=Grafic fara baza de date'#13+
'SELECT A DATABASE TABLE=Selecteaza un tabel din baza de date'#13+
'ALIAS=Alias'#13+
'TABLE=Tabel'#13+
'SOURCE=Sursa'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Selecteaza cimpurile dorite pentru grafic'#13+
'SELECT A TEXT LABELS FIELD=Selecteaza o eticheta de tip text'#13+
'CHOOSE THE DESIRED CHART TYPE=Alege tipul de grafic dorit'#13+
'2D=2D'#13+
'CHART PREVIEW=Previzualizeaza graficul'#13+
'SHOW LEGEND=Vizualizeaza legenda'#13+
'SHOW MARKS=Vizualizeaza Notele'#13+
'< BACK=< Inapoi'#13+
'SELECT A CHART STYLE=Selecteaza un tip de grafic'#13+
'NON DATABASE CHART=Grafic fara baze de date'#13+
'SELECT A DATABASE TABLE=Selecteaza un tabel din baza de date'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Selecteaza cimpurile dorite pentru grafic'#13+
'SELECT A TEXT LABELS FIELD=Selecteaza o eticheta de tip text'#13+
'EXPORT CHART=Exporta Graficul'#13+
'PICTURE=Imagine'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Pastraza proportiile originale'#13+
'INCLUDE SERIES DATA=Include datele din Serie'#13+
'FILE SIZE=Dimensiunea Fisierului'#13+
'DELIMITER=Delimitator'#13+
'XML=XML'#13+
'HTML TABLE=Tabel HTML'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=Coloana'#13+
'INCLUDE=Include'#13+
'POINT LABELS=Etichetele Punctelor'#13+
'POINT INDEX=Indexul Punctelor'#13+
'HEADER=Antet'#13+
'COPY=Copiaza'#13+
'SAVE=Salveaza'#13+
'SEND=Trimite'#13+
'INCLUDE SERIES DATA=Include datele din Serie'#13+
'FUNCTIONS=Functii'#13+
'ADD=Suma'#13+
'ADX=ADX'#13+
'AVERAGE=Media'#13+
'BOLLINGER=Bollinger'#13+
'COPY=Copiaza'#13+
'DIVIDE=Imparte'#13+
'EXP. AVERAGE=Media Exp.'#13+
'EXP.MOV.AVRG.=Media Mobila Exp.'#13+
'HIGH=Virf'#13+
'LOW=Baza'#13+
'MACD=MACD'#13+
'MOMENTUM=Moment'#13+
'MOMENTUM DIV=Moment Div'#13+
'MOVING AVRG.=Media Mobila'#13+
'MULTIPLY=Multiplica'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Radacina medie patratica'#13+
'STD.DEVIATION=Devierea Standard'#13+
'STOCHASTIC=Stocastic'#13+
'SUBTRACT=Scadere'#13+
'APPLY=Aplica'#13+
'SOURCE SERIES=Serie Sursa'#13+
'TEECHART GALLERY=Galeria TeeChart'#13+
'FUNCTIONS=Functii'#13+
'DITHER=Corectie'#13+
'REDUCTION=Reducere'#13+
'COMPRESSION=Compresie'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Apropiat'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=Monocromatic'#13+
'GRAY SCALE=Tonuri de gri'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Calitate'#13+
'GRAY SCALE=Tonuri de gri'#13+
'PERFORMANCE=Performanta'#13+
'QUALITY=Calitate'#13+
'SPEED=Viteza'#13+
'COMPRESSION LEVEL=Nivel de compresie'#13+
'CHART TOOLS GALLERY=Galeria de instrumente pentru grafice'#13+
'ANNOTATION=Adnotare'#13+
'AXIS ARROWS=Sagetile axelor'#13+
'COLOR BAND=Banda de culori'#13+
'COLOR LINE=Linie de culori'#13+
'CURSOR=Cursor'#13+
'DRAG MARKS=Marcaje de tragere'#13+
'DRAW LINE=Deseneaza linia'#13+
'IMAGE=Imagine'#13+
'MARK TIPS=Note ajutatoare'#13+
'NEAREST POINT=Cel mai apropiat punct'#13+
'ROTATE=Roteste'#13+
'CHART TOOLS GALLERY=Galeria de instrumente Grafice'#13+
'BRUSH=Pensula'#13+
'DRAWING MODE=Modul de desenare'#13+
'WIREFRAME=cadru de sirma'#13+
'SMOOTH PALETTE=Paleta lina'#13+
'SIDE BRUSH=Model lateral'#13+
'YES=Da'#13+
'VISIT OUR WEB SITE !=Viziteaza site-ul nostru!'#13+
'SHOW PAGE NUMBER=Afiseaza numarul paginii'#13+
'PAGE NUMBER=Numarul paginii'#13+
'PAGE %D OF %D=Pag. %d din %d'#13+
'TEECHART LANGUAGES=Limbi de afisare a TeeChart'#13+
'CHOOSE A LANGUAGE=Alege o limba'+#13+
'SELECT ALL=Selecteaza-le pe toate'#13+
'DRAW ALL=Deseneaza-le pe toate'#13+
'TEXT FILE=Fisier text'#13+
'IMAG. SYMBOL=Simbol Imag.'#13+
'DRAG REPAINT=Drag repaint'#13+
'NO LIMIT DRAG=Misca fara limite'
;
  end;
end;

Procedure TeeSetRomanian;
begin
  TeeCreateRomanian;
  TeeLanguage:=TeeRomanianLanguage;
  TeeRomanianConstants;
end;


initialization
finalization
  FreeAndNil(TeeRomanianLanguage);
end.
