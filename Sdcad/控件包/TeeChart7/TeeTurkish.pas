unit TeeTurkish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeTurkishLanguage:TStringList=nil;

Procedure TeeSetTurkish;
Procedure TeeCreateTurkish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeTurkishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 David Berneda';
  TeeMsg_LegendFirstValue   :='Ýlk Açýklayýcý deðeri > 0 olmalý';
  TeeMsg_LegendColorWidth   :='Açýklayýcý Renk Geniþliði %0''dan büyük olmalý';
  TeeMsg_SeriesSetDataSource:='Veri kaynaðýný doðrulamak için gerekli ana grafik mevcut deðil';
  TeeMsg_SeriesInvDataSource:='Geçerli veri kaynaðý mevcut deðil: %s';
  TeeMsg_FillSample         :='FillSampleValues deðer sayýsý >0 olmalý';
  TeeMsg_AxisLogDateTime    :='Tarih/Saat tipi eksen logaritmik olamaz';
  TeeMsg_AxisLogNotPositive :='Logaritmik Eksen Minimum ve Maksimum deðerleri > 0 olmalýdýr';
  TeeMsg_AxisLabelSep       :='Etiket aralýk yüzdesi > %0 olmalý';
  TeeMsg_AxisIncrementNeg   :='Eksen artýþ birimi > 0 olmalý';
  TeeMsg_AxisMinMax         :='Eksen Minimum Deðeri <= Eksen Maksimum Deðeri olmalý';
  TeeMsg_AxisMaxMin         :='Eksen Maksimum Deðeri  >= Eksen Minimum Deðeri olmalý';
  TeeMsg_AxisLogBase        :='Eksen Logaritma Tabaný >= 2 olmalý';
  TeeMsg_MaxPointsPerPage   :='Sayfa baþýna maksimum nokta sayýsý >= 0 olmalý';
  TeeMsg_3dPercent          :='3B efekt yüzdesi %d ile %d arasýnda olmalý';
  TeeMsg_CircularSeries     :='Dairesel Seri Baðýmlýlýðý yasak'; //****/
  TeeMsg_WarningHiColor     :='Daha iyi görüntü için 16k veya daha yüksek renk çözünürlüðü gerekli';

  TeeMsg_DefaultPercentOf   :='%s / %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'/ %s';
  TeeMsg_DefPercentFormat   :='##0,## %';
  TeeMsg_DefValueFormat     :='#.##0,###';
  TeeMsg_DefLogValueFormat  :='#,0 "x10" E+0';
  TeeMsg_AxisTitle          :='Eksen Baþlýðý';
  TeeMsg_AxisLabels         :='Eksen Etiketleri';
  TeeMsg_RefreshInterval    :='Yenileme Aralýðý 0 ile 60 sn arasýnda olmalý';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart kendim deðilim!';
  TeeMsg_GalleryLine        :='Çizgi';
  TeeMsg_GalleryPoint       :='Nokta';
  TeeMsg_GalleryArea        :='Alan';
  TeeMsg_GalleryBar         :='Çubuk';
  TeeMsg_GalleryHorizBar    :='Yatay Çubuk';
  TeeMsg_Stack              :='Yýðýn';
  TeeMsg_GalleryPie         :='Elma';
  TeeMsg_GalleryCircled     :='Dairesel';
  TeeMsg_GalleryFastLine    :='Hýzlý Çizgi';
  TeeMsg_GalleryHorizLine   :='Yatay Çizgi';

  TeeMsg_PieSample1         :='Arbalar';
  TeeMsg_PieSample2         :='Telefonlar';
  TeeMsg_PieSample3         :='Masalar';
  TeeMsg_PieSample4         :='Monitörler';
  TeeMsg_PieSample5         :='Lambalar';
  TeeMsg_PieSample6         :='Klavyeler';
  TeeMsg_PieSample7         :='Bisikletler';
  TeeMsg_PieSample8         :='Sandalyeler';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='%s düzenleniyor';

  TeeMsg_GalleryStandard    :='Standart';
  TeeMsg_GalleryExtended    :='Ýlave';
  TeeMsg_GalleryFunctions   :='Fonksiyonlar';

  TeeMsg_EditChart          :='Grafiði &Düzenle...';
  TeeMsg_PrintPreview       :='&Baský Öngörünüm...';
  TeeMsg_ExportChart        :='Grafiði &Ýhraç Et...';
  TeeMsg_CustomAxes         :='Kiþisel Eksenler...';

  TeeMsg_InvalidEditorClass :='%s: Düzenleyici Sýnýfý geçerli deðil: %s';
  TeeMsg_MissingEditorClass :='%s: Düzenleyici Diyaloðuna sahip deðil';

  TeeMsg_GalleryArrow       :='Ok';

  TeeMsg_ExpFinish          :='&Bitir';
  TeeMsg_ExpNext            :='&Sonraki >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Dizayn';
  TeeMsg_GanttSample2       :='Prototip';
  TeeMsg_GanttSample3       :='Geliþtirme';
  TeeMsg_GanttSample4       :='Satýþ';
  TeeMsg_GanttSample5       :='Pazarlama';
  TeeMsg_GanttSample6       :='Kalite Kontrol';
  TeeMsg_GanttSample7       :='Üretim';
  TeeMsg_GanttSample8       :='Hata Ayýklama';
  TeeMsg_GanttSample9       :='Yeni Versiyon';
  TeeMsg_GanttSample10      :='Maliye';

  TeeMsg_ChangeSeriesTitle  :='Seri Baþlýðýný Deðiþtir';
  TeeMsg_NewSeriesTitle     :='Yeni Seri Baþlýðý:';
  TeeMsg_DateTime           :='Tarih/Saat';
  TeeMsg_TopAxis            :='Üst Eksen';
  TeeMsg_BottomAxis         :='Alt Eksen';
  TeeMsg_LeftAxis           :='Sol Eksen';
  TeeMsg_RightAxis          :='Sað Eksen';

  TeeMsg_SureToDelete       :='%s silinsin mi ?';
  TeeMsg_DateTimeFormat     :='Tarih/Saat Biçimi:';
  TeeMsg_Default            :='Varsayýlan';
  TeeMsg_ValuesFormat       :='Deðer &Biçimi:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Ýstenen %s Artýþý';

  TeeMsg_IncorrectMaxMinValue:='Geçersiz Deðer. Sebep: %s';
  TeeMsg_EnterDateTime      :='Giriniz [Gün Sayýsý] [ss:dd:ss]';

  TeeMsg_SureToApply        :='Deðiþiklikler uygulansýn mý ?';
  TeeMsg_SelectedSeries     :='(Seçilen Seri)';
  TeeMsg_RefreshData        :='Veriyi &Yenile';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='419';
  TeeMsg_FunctionAdd        :='Toplam';
  TeeMsg_FunctionSubtract   :='Çýkart';
  TeeMsg_FunctionMultiply   :='Çarp';
  TeeMsg_FunctionDivide     :='Böl';
  TeeMsg_FunctionHigh       :='Yüksek';
  TeeMsg_FunctionLow        :='Düþük';
  TeeMsg_FunctionAverage    :='Ortalama';

  TeeMsg_GalleryShape       :='Þekil';
  TeeMsg_GalleryBubble      :='Kabarcýk';
  TeeMsg_FunctionNone       :='Kopyala';

  TeeMsg_None               :='(hiçbiri)';

  TeeMsg_PrivateDeclarations:='{ Özel tanýmlar }';
  TeeMsg_PublicDeclarations :='{ Genel tanýmlar }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Gösterici büyüklüðü deðeri sýfýrdan büyük olmalý';

  //if folowing three lines  are palette pages in delphi toolbar no change, there is no turkish version of delphi
  tcAdditional              :='Additional'; //tcAdditional              :='Ekstra';
  tcDControls               :='Data Controls';//tcDControls               :='Veri Kontrolleri';
  tcQReport                 :='QReport';//tcQReport                 :='QReport';

  TeeMsg_About              :='TeeChart &Hakkýnda...';

  //Again, programmers use delphi in english usually so for myself I will prefer to use Data Set instead of turkish synonym
  TeeMsg_DataSet            :='Table/Query';//TeeMsg_DataSet            :='Veri Kümesi';
  TeeMsg_AskDataSet         :='&Table/Query:';//TeeMsg_DataSet            :='&Veri Kümesi:';



  TeeMsg_SingleRecord       :='Tek bir kayýt';
  TeeMsg_AskDataSource      :='&Veri Kümesi:';

  TeeMsg_Summary            :='Özet';

  TeeMsg_FunctionPeriod     :='Fonksyion periyodu >= 0 olmalý';

  TeeMsg_TeeChartWizard     :='TeeChart Sihibazý';

  TeeMsg_ClearImage         :='&Temizle';
  TeeMsg_BrowseImage        :='&Gözat...';

  TeeMsg_WizardSureToClose  :='TeeChart Sihirbazýný kapatmak istediðinize emin misiniz ?';
  TeeMsg_FieldNotFound      :='% alaný mevcut deðil';

  TeeMsg_DepthAxis          :='Derinlik Ekseni';
  TeeMsg_PieOther           :='Diðer';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pasta';
  TeeMsg_ValuesBar          :='Çubuk';
  TeeMsg_ValuesAngle        :='Açý';
  TeeMsg_ValuesGanttStart   :='Baþlangýç';
  TeeMsg_ValuesGanttEnd     :='Bitiþ';
  TeeMsg_ValuesGanttNextTask:='SonrakiGörev';
  TeeMsg_ValuesBubbleRadius :='Yarýçap';
  TeeMsg_ValuesArrowEndX    :='Bitiþ X';
  TeeMsg_ValuesArrowEndY    :='Bitiþ Y';
  TeeMsg_Legend             :='Açýklayýcý';
  TeeMsg_Title              :='Baþlýk';
  TeeMsg_Foot               :='Altlýk';
  TeeMsg_Period		    :='Periyod';
  TeeMsg_PeriodRange        :='Periyod Uzanýmý';
  TeeMsg_CalcPeriod         :='%s hesaplama þekli:';
  TeeMsg_SmallDotsPen       :='Küçük Nokta';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' dosyasýndaki grafik geçersiz ';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' dosya biçimi hatalý';
  TeeMsg_EmptyTeeFile       :='*.'+TeeMsg_TeeExtension+' dosyasý boþ';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Grafik Eksenleri';
  TeeMsg_ChartAxesCategoryDesc   := 'Grafik Ekseni özellik ve olaylarý';
  TeeMsg_ChartWallsCategoryName  := 'Grafik Duvarlarý';
  TeeMsg_ChartWallsCategoryDesc  := 'Grafik Duvar özellik ve olaylarý';
  TeeMsg_ChartTitlesCategoryName := 'Grafik Baþlýklarý';
  TeeMsg_ChartTitlesCategoryDesc := 'Grafik Baþlýðý özellik ve olaylarý';
  TeeMsg_Chart3DCategoryName     := '3B Grafik';
  TeeMsg_Chart3DCategoryDesc     := '3B Grafik özellik ve olaylarý';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Kiþiselleþtir ';
  TeeMsg_Series                 :='Seriler';
  TeeMsg_SeriesList             :='Seriler...';

  TeeMsg_PageOfPages            :='Sayfa %d / %d';
  TeeMsg_FileSize               :='%d byte';

  TeeMsg_First  :='Ýlk';
  TeeMsg_Prior  :='Önceki';
  TeeMsg_Next   :='Sonraki';
  TeeMsg_Last   :='Son';
  TeeMsg_Insert :='Yeni';
  TeeMsg_Delete :='Sil';
  TeeMsg_Edit   :='Düzenle';
  TeeMsg_Post   :='Kaydet';
  TeeMsg_Cancel :='Vazgeç';

  TeeMsg_All    :='(tümü)'; {las series}
  TeeMsg_Index  :='Ýndis';
  TeeMsg_Text   :='Metin';

  TeeMsg_AsBMP        :='&Bitmap olarak';
  TeeMsg_BMPFilter    :='Bitmap (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metafile olarak';
  TeeMsg_EMFFilter    :='Geliþmiþ Metafile  (*.emf)|*.emf|Metafile (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Ýhraç biçiminde panel özelliði atanmamýþ.';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Kenarsýz';
  TeeMsg_Dotted    :='Noktalý';
  TeeMsg_Colors    :='Renkler';
  TeeMsg_Filled    :='Doldurulmuþ';
  TeeMsg_Marks     :='Ýþaretler';
  TeeMsg_Stairs    :='Basamaklar';
  TeeMsg_Points    :='Noktalar';
  TeeMsg_Height    :='Yükseklik';
  TeeMsg_Hollow    :='Oyuk';
  TeeMsg_Point2D   :='2B Nokta';
  TeeMsg_Triangle  :='Üçgen';
  TeeMsg_Star      :='Yýldýz';
  TeeMsg_Circle    :='Çamber';
  TeeMsg_DownTri   :='Aþaðý Üçgen';
  TeeMsg_Cross     :='Haç';
  TeeMsg_Diamond   :='Karo';
  TeeMsg_NoLines   :='Çizgisiz';
  TeeMsg_Stack100  :='%100 Yýðýlmýþ';
  TeeMsg_Pyramid   :='Piramit';
  TeeMsg_Ellipse   :='Elips';
  TeeMsg_InvPyramid:='Ters Piramit';
  TeeMsg_Sides     :='Kenar';
  TeeMsg_SideAll   :='Tüm KenarTodas las caras';
  TeeMsg_Patterns  :='Desenler';
  TeeMsg_Exploded  :='Patlamýþ';
  TeeMsg_Shadow    :='Gölge';
  TeeMsg_SemiPie   :='Yarým Pasta';
  TeeMsg_Rectangle :='DikDörtgen';
  TeeMsg_VertLine  :='Dikey Çizgi';
  TeeMsg_HorizLine :='Yatay Çizgi';
  TeeMsg_Line      :='Çizgi';
  TeeMsg_Cube      :='Küp';
  TeeMsg_DiagCross :='Çarpý';

  TeeMsg_CanNotFindTempPath    :='Temp dizini blunamadý';
  TeeMsg_CanNotCreateTempChart :='Temp dosyasý oluþturulamýyor';
  TeeMsg_CanNotEmailChart      :='Grafik e-postalanamadý. Mapi Hatasý: %d';

  TeeMsg_SeriesDelete :='Seri Silme: Seri indisi %d sýnýrlar dýþýnda (min:0 , max:%d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Dil...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Mum';
  TeeMsg_GalleryVolume      :='Hacim';
  TeeMsg_GallerySurface     :='Yüzey';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3B Nokta';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Simit';
  TeeMsg_GalleryCursor      :='Ýmleç';
  TeeMsg_GalleryBar3D       :='3B Çubuk';
  TeeMsg_GalleryBigCandle   :='Büyük Mum';
  TeeMsg_GalleryLinePoint   :='Nokta Çizgi';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Þellale';
  TeeMsg_GalleryWindRose    :='Rüzgar Gülü';
  TeeMsg_GalleryClock       :='Saat';
  TeeMsg_GalleryColorGrid   :='Renk Izgarasý';
  TeeMsg_GalleryBoxPlot     :='Dikey Kutu';
  TeeMsg_GalleryHorizBoxPlot:='Yatay Kutu';
  TeeMsg_GalleryBarJoin     :='Çubuk Birleþim';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramit';
  TeeMsg_GalleryMap         :='Harita';

  TeeMsg_PolyDegreeRange     :='Polinom derecesi 1 ile 20 arasýnda olmalý';
  TeeMsg_AnswerVectorIndex   :='Cevap vektör indisi 1 ile %d arasýnda olmalý';
  TeeMsg_FittingError        :='Uyarlama hesaplamasý yapýlamýyor';
  TeeMsg_PeriodRange         :='Periyod >= 0 olmalý';
  TeeMsg_ExpAverageWeight    :='Üssel Ort. Aðýrlýðý 0 ile 1 arasýnda olmalý';
  TeeMsg_GalleryErrorBar     :='Hata Çubuðu';
  TeeMsg_GalleryError        :='Hata';
  TeeMsg_GalleryHighLow      :='Yüksek-Düþük';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Mom.Bölümü';
  TeeMsg_FunctionExpAverage  :='Üssel Ort.';
  TeeMsg_FunctionMovingAverage:='Hareketli Ort.';
  TeeMsg_FunctionExpMovAve   :='Üssel Hareketli Ort.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Kavis Uyarlama';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Üssel Trend';
  TeeMsg_FunctionLogTrend    :='Logaritmik Trend';
  TeeMsg_FunctionCumulative  :='Kümülatif';
  TeeMsg_FunctionStdDeviation:='Std. Sapma';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Square';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stokastik';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Sayý';
  TeeMsg_LoadChart           :='TeeChart grafiði yükle...';
  TeeMsg_SaveChart           :='TeeChart grafiði kaydet...';
  TeeMsg_TeeFiles            :='TeeChart Pro dosyalarý';

  TeeMsg_GallerySamples      :='Diðer';
  TeeMsg_GalleryStats        :='Ýstatistik';

  TeeMsg_CannotFindEditor    :='Seri düzenleyici editör formu bulunamadý: %s';

  TeeMsg_CannotLoadChartFromURL:='%s adresinden grafik yükleme iþleminde hata. Hata Mesajý: %d';
  TeeMsg_CannotLoadSeriesDataFromURL:='%s adresinden seri verisi yüklemesinde hata. Hata Mesajý: %d';

  TeeMsg_Test                :='Test Et...';

  TeeMsg_ValuesDate          :='Tarih';
  TeeMsg_ValuesOpen          :='Açýlýþ';
  TeeMsg_ValuesHigh          :='Yüksek';
  TeeMsg_ValuesLow           :='Düþük';
  TeeMsg_ValuesClose         :='Kapanýþ';
  TeeMsg_ValuesOffset        :='Ofset';
  TeeMsg_ValuesStdError      :='Std.Hata';

  TeeMsg_Grid3D              :='3B Izgara';

  TeeMsg_LowBezierPoints     :='Bezier nokta sayýsý > 1 olmalý';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Düzenle';
  TeeCommanMsg_Print    :='Yazdýr';
  TeeCommanMsg_Copy     :='Kopyala';
  TeeCommanMsg_Save     :='Kaydet';
  TeeCommanMsg_3D       :='3B';

  TeeCommanMsg_Rotating :='Rotasyon: %d° Elevasyon: %d°';
  TeeCommanMsg_Rotate   :='Döndür';

  TeeCommanMsg_Moving   :='Yatay Ofset: %d Dikey Ofset: %d';
  TeeCommanMsg_Move     :='Taþý';

  TeeCommanMsg_Zooming  :='Büyüt: %d %%';
  TeeCommanMsg_Zoom     :='Büyüt';

  TeeCommanMsg_Depthing :='3B: %d %%';
  TeeCommanMsg_Depth    :='Derinlik'; { 5.01 }

  TeeCommanMsg_Chart    :='Grafik';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Döndürmek için %s ''yi sürükleyin'; { 5.01 }
  TeeCommanMsg_MoveLabel  :='Taþýmak için %s'' yi sürükleyin'; { 5.01 }
  TeeCommanMsg_ZoomLabel  :='Büyütmek için %s'' yi sürükleyin'; { 5.01 }
  TeeCommanMsg_DepthLabel :='3B''yi ayarlamak için %s''yi sürükleyin';

  TeeCommanMsg_NormalLabel:='Büyütmek için Sol düðmesini, kaydýrmak için Sað düðmesini sürükleyin';
  TeeCommanMsg_NormalPieLabel:='Pasta dilimini patlatmak için o dilimi sürükleyin';

  TeeCommanMsg_PieExploding := 'Dilim: %d Patlama: %d %%';

  TeeMsg_TriSurfaceLess:='Nokta sayýsý >= 4 olmalý';
  TeeMsg_TriSurfaceAllColinear:='Tüm yardýmcý çizgisel veri noktalarý';
  TeeMsg_TriSurfaceSimilar:='Benzer noktalar - iþlemi devam ettiremiyorum';
  TeeMsg_GalleryTriSurface:='Üçgensel Yüzey';

  TeeMsg_AllSeries := 'Tüm Seriler';
  TeeMsg_Edit      := 'Düzenle';

  TeeMsg_GalleryFinancial    :='Finansal';

  TeeMsg_CursorTool    :='Ýmleç';
  TeeMsg_DragMarksTool :='Ýþaret Sürükleyici'; { 5.01 }
  TeeMsg_AxisArrowTool :='Eksen Oklarý';
  TeeMsg_DrawLineTool  :='Çizgi Çizme';
  TeeMsg_NearestTool   :='En Yakýn Nokta';
  TeeMsg_ColorBandTool :='Renk Bandý';
  TeeMsg_ColorLineTool :='Renk Çizgisi';
  TeeMsg_RotateTool    :='Döndür';
  TeeMsg_ImageTool     :='Görüntü';
  TeeMsg_MarksTipTool  :='Ýþaret Tavsiyeleri';

  TeeMsg_CantDeleteAncestor  :='Üst seviyemi (ancestor) silemiyorum';

  TeeMsg_Load	         :='Yükle...';
  TeeMsg_NoSeriesSelected:='Seri seçilmedi';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafik';
  TeeMsg_CategorySeriesActions :='Grafik Serileri';

  TeeMsg_Action3D               :='&3B';
  TeeMsg_Action3DHint           :='2B / 3B anahtarý';
  TeeMsg_ActionSeriesActive     :='&Aktifleþtir';
  TeeMsg_ActionSeriesActiveHint :='Serileri Göster / Sakla';
  TeeMsg_ActionEditHint         :='Grafiði Düzenle';
  TeeMsg_ActionEdit             :='&Düzenle...';
  TeeMsg_ActionCopyHint         :='Hafýzaya Kopyala';
  TeeMsg_ActionCopy             :='&Kopyala';
  TeeMsg_ActionPrintHint        :='Grafik baský önizleme';
  TeeMsg_ActionPrint            :='&Baský Önizleme...';
  TeeMsg_ActionAxesHint         :='Eksenleri Göster / Sakla';
  TeeMsg_ActionAxes             :='&Eksenler';
  TeeMsg_ActionGridsHint        :='Izgarayý Göster / Sakla';
  TeeMsg_ActionGrids            :='&Izgara';
  TeeMsg_ActionLegendHint       :='Açýklayýcýlarý Göster / Sakla';
  TeeMsg_ActionLegend           :='&Açýklayýcýlar';
  TeeMsg_ActionSeriesEditHint   :='Serileri Düzenle';
  TeeMsg_ActionSeriesMarksHint  :='Ýþaretleri Göster / Sakla';
  TeeMsg_ActionSeriesMarks      :='&Ýþaretler';
  TeeMsg_ActionSaveHint         :='Grafiði Kaydet';
  TeeMsg_ActionSave             :='&Kaydet...';

  TeeMsg_CandleBar              :='Çubuk';
  TeeMsg_CandleNoOpen           :='Açlýþý gizle';
  TeeMsg_CandleNoClose          :='Kapanýþý gizle';
  TeeMsg_NoLines                :='Çizgileri gizle';
  TeeMsg_NoHigh                 :='Yükseði gizle';
  TeeMsg_NoLow                  :='Düþüðü gizle';
  TeeMsg_ColorRange             :='Renk Uzanýmý';
  TeeMsg_WireFrame              :='Tel Çerçeve';
  TeeMsg_DotFrame               :='Nokta Çerçeve';
  TeeMsg_Positions              :='Pozisyonlar';
  TeeMsg_NoGrid                 :='Izgarayý gizle';
  TeeMsg_NoPoint                :='Noktalarý gizle';
  TeeMsg_NoLine                 :='Çizgileri gizle';
  TeeMsg_Labels                 :='Etiketler';
  TeeMsg_NoCircle               :='Daireleri gizle';
  TeeMsg_Lines                  :='Çizgiler';
  TeeMsg_Border                 :='Sýnýr';

  TeeMsg_SmithResistance      :='Direnç';
  TeeMsg_SmithReactance       :='Reaktans';

  TeeMsg_Column  :='Sütun';

  { 5.01 }
  TeeMsg_Separator            :='Ayraç';
  TeeMsg_FunnelSegment        :='Kýsým ';
  TeeMsg_FunnelSeries         :='Huni';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Kota aþýldý';
  TeeMsg_FunnelWithin         :=' kota içinde';
  TeeMsg_FunnelBelow          :=' veya kota altýnda';
  TeeMsg_CalendarSeries       :='Takvim';
  TeeMsg_DeltaPointSeries     :='Delta Nokta';
  TeeMsg_ImagePointSeries     :='Görüntü Nokta';
  TeeMsg_ImageBarSeries       :='Görüntü Çubuk';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Alan indisi sýfýrdan büyük olmalýdýr.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='&JPEG olarak';
  TeeMsg_JPEGFilter    :='JPEG dosyalarý (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='&GIF olarak';
  TeeMsg_GIFFilter     :='GIF dosyalarý (*.gif)|*.gif';
  TeeMsg_AsPNG         :='&PNG olarak';
  TeeMsg_PNGFilter     :='PNG dosyalarý (*.png)|*.png';
  TeeMsg_AsPCX         :='PC&X olarak';
  TeeMsg_PCXFilter     :='PCX dosyalarý (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='&VML (HTM) olarak';
  TeeMsg_VMLFilter     :='VML dosyalarý (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := 'Baþlangýç';
  TeeMsg_Transparency         := 'Saydamlýk';
  TeeMsg_Box		      := 'Kutu';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Sayfa No';
  TeeMsg_TextFile             := 'Metin Dosya';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

// 6.0
// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='&PDF olarak';
  TeeMsg_PDFFilter        :='PDF dosyalarý (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='PostScript olarak';
  TeeMsg_PSFilter         :='PostScript dosyalarý (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Yatay'#13'Alan';
  TeeMsg_SelfStack        :='Kendi Üzerine Yýðýlmýþ';
  TeeMsg_DarkPen          :='Koyu Kenar';
  TeeMsg_SelectFolder     :='Veritabaný klasörünü seç';
  TeeMsg_BDEAlias         :='&Alias:';   // Turkish translation is not proper
  TeeMsg_ADOConnection    :='&Baðlantý';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Yumuþatma';
  TeeMsg_FunctionCross        :='Kesiþme Noktalarý';
  TeeMsg_GridTranspose        :='3B Izgara Transpozesi';
  TeeMsg_FunctionCompress     :='Sýkýþtýrma';
  TeeMsg_ExtraLegendTool      :='Extra Açýklayýcý';
  TeeMsg_FunctionCLV          :='Kapanýþ Konum'#13'Deðeri';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Seri Animasyonu';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Yukarý';
  TeeMsg_Down                 :='Aþaðý';
  TeeMsg_GanttTool            :='Gantt Sürükle';
  TeeMsg_XMLFile              :='XML dosya';
  TeeMsg_GridBandTool         :='Izgara ve Bant aracý';
  TeeMsg_FunctionPerf         :='Performans';
  TeeMsg_GalleryGauge         :='Gauge';
  TeeMsg_GalleryGauges        :='Gauges';
  TeeMsg_ValuesVectorEndZ     :='Bitiþ';
  TeeMsg_GalleryVector3D      :='Vektör 3B';
  TeeMsg_Gallery3D            :='3B';
  TeeMsg_GalleryTower         :='Kule';
  TeeMsg_SingleColor          :='Tek Renk';
  TeeMsg_Cover                :='Kapla';
  TeeMsg_Cone                 :='Koni';
  TeeMsg_PieTool              :='Elma Dilimleri';

  // 7.0
  TeeMsg_View2D               :='2D';
  TeeMsg_Outline              :='Sinir';

  TeeMsg_Stop                 :='Durdur';
  TeeMsg_Execute              :='ÇalIÞtir !';
  TeeMsg_Themes               :='Temalar';
  TeeMsg_LightTool            :='2D IÞIKLANDIRMA';
  TeeMsg_Current              :='ÞÝMDÝKÝ';
  TeeMsg_FunctionCorrelation  :='Korrelasyon';
  TeeMsg_FunctionVariance     :='Varyans';
  TeeMsg_GalleryBubble3D      :='Balon 3D';
  TeeMsg_GalleryHorizHistogram:='Yatay'#13'HÝstogram';
  TeeMsg_FunctionPerimeter    :='Çevre';
  TeeMsg_SurfaceNearestTool   :='YÜzey en Yakin';
  TeeMsg_AxisScrollTool       :='Eksen Kaydirma ÇubuÐu';
  TeeMsg_RectangleTool        :='DÝkdÖrtgen';
  TeeMsg_GalleryPolarBar      :='Kutup ÇÝzgÝsÝ';
  TeeMsg_AsWapBitmap          :='Wap Bitmap';
  TeeMsg_WapBMPFilter         :='Wap Bitmap (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='SerÝlerÝ Kes';
  TeeMsg_SeriesBandTool       :='SerÝ Bandi';
end;

Procedure TeeCreateTurkish;
begin
  if not Assigned(TeeTurkishLanguage) then
  begin
    TeeTurkishLanguage:=TStringList.Create;
    TeeTurkishLanguage.Text:=

'LABELS=Etiketler'+#13+
'DATASET=Veri Kümesi'+#13+
'ALL RIGHTS RESERVED.=Tüm haklarý saklýdýr.'+#13+
'APPLY=Uygula'+#13+
'CLOSE=Kapat'+#13+
'OK=Tamam'+#13+
'ABOUT TEECHART PRO V5.03=TeeChart Pro sürüm 5.03 hakkýnda'+#13+
'OPTIONS=Seçimler'+#13+
'FORMAT=Biçim'+#13+
'TEXT=Metin'+#13+
'GRADIENT=Eðim'+#13+
'SHADOW=Gölge'+#13+
'POSITION=Pozisyon'+#13+
'LEFT=Sol'+#13+
'TOP=Üst'+#13+
'CUSTOM=Kiþisel'+#13+
'PEN=Kalem'+#13+
'PATTERN=Desen'+#13+
'SIZE=Boyut'+#13+
'BEVEL=Yükselti'+#13+
'INVERTED=Ters'+#13+
'INVERTED SCROLL=Ters Kaydýrma'+#13+
'BORDER=Sýnýr'+#13+
'ORIGIN=Baþlangýç'+#13+
'USE ORIGIN=Kullanýlacak Baþlangýç'+#13+
'AREA LINES=Alan Çizgileri'+#13+
'AREA=Alan'+#13+
'COLOR=Renk'+#13+
'SERIES=Seriler'+#13+
'SUM=Toplam'+#13+
'DAY=Gün'+#13+
'QUARTER=Çeyrek'+#13+
'(MAX)=(maks)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Görünür'+#13+
'CURSOR=Ýmleç'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3B'+#13+
'HORIZ. LINE=Yatay Çizgi'+#13+
'LABEL AND PERCENT=Etiket ve Yüzde'+#13+
'LABEL AND VALUE=Etiket ve Deðer'+#13+
'LABEL AND PERCENT TOTAL=Etiket ve Yüzde Toplam'+#13+
'PERCENT TOTAL=Yüzde Toplam'+#13+
'MSEC.=msan.'+#13+
'SUBTRACT=Çýkart'+#13+
'MULTIPLY=Çarp'+#13+
'DIVIDE=Böl'+#13+
'STAIRS=Basamaklar'+#13+
'MOMENTUM=Momentum'+#13+
'AVERAGE=Ortalama'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML Tablosu'+#13+
'EXCEL=Excel'+#13+
'NONE=Hiçbiri'+#13+
'(NONE)=Hiçbiri'#13+
'WIDTH=Geniþlik'+#13+
'HEIGHT=Yükseklik'+#13+
'COLOR EACH=Herbirini Renklendir'+#13+
'STACK=Yýðýn'+#13+
'STACKED=Yýðýlmýþ'+#13+
'STACKED 100%=%100 yýðýlmýþ'+#13+
'AXIS=Eksen'+#13+
'LENGTH=Uzunluk'+#13+
'CANCEL=Vazgeç'+#13+
'SCROLL=Kaydýr'+#13+
'INCREMENT=Artýþ'+#13+
'VALUE=Deðer'+#13+
'STYLE=Stil'+#13+
'JOIN=Birleþtir'+#13+
'AXIS INCREMENT=Eksen Artýþý'+#13+
'AXIS MAXIMUM AND MINIMUM=Eksen Maksimum ve minimumu'+#13+
'% BAR WIDTH=% Çubuk Geniþliði %'+#13+
'% BAR OFFSET=% Çubuk Ofseti'+#13+
'BAR SIDE MARGINS=Çubuk Yan Marjinleri'+#13+
'AUTO MARK POSITION=Otomatik Ýþaret Pozisyonlarý.'+#13+
'DARK BAR 3D SIDES=Koyu Çubuk 3B Yanlarý'+#13+
'MONOCHROME=Tek Renkli'+#13+
'COLORS=Renkler'+#13+
'DEFAULT=Varsayýlan'+#13+
'MEDIAN=Medyan'+#13+
'IMAGE=Görüntü'+#13+
'DAYS=Günler'+#13+
'WEEKDAYS=Ýþ Günleri'+#13+
'TODAY=Bugün'+#13+
'SUNDAY=Pazar'+#13+
'MONTHS=Aylar'+#13+
'LINES=Çizgiler'+#13+
'UPPERCASE=Büyük Harf'+#13+
'STICK=Mum'+#13+
'CANDLE WIDTH=Mum Geniþliði'+#13+
'BAR=Çubuk'+#13+
'OPEN CLOSE=Açýlýþ Kapanýþ'+#13+
'DRAW 3D=3B Çiz'+#13+
'DARK 3D=Koyu 3B'+#13+
'SHOW OPEN=Açýlýþý göster'+#13+
'SHOW CLOSE=Kapanýþý Göster'+#13+
'UP CLOSE=Yükselen Kapanýþ'+#13+
'DOWN CLOSE=Düþen Kapanýþ'+#13+
'CIRCLED=Dairesel'+#13+
'CIRCLE=Daire'+#13+
'3 DIMENSIONS=3 Boyutlu'+#13+
'ROTATION=Rotasyon'+#13+
'RADIUS=Yarýçap'+#13+
'HOURS=Saatler'+#13+
'HOUR=Saat'+#13+
'MINUTES=Dakikalar'+#13+
'SECONDS=Saniyeler'+#13+
'FONT=Yazý Tipi'+#13+
'INSIDE=Ýç Kýsým'+#13+
'ROTATED=Döndürülmüþ'+#13+
'ROMAN=Roma'+#13+
'TRANSPARENCY=Saydamlýk'+#13+
'DRAW BEHIND=Arkaya Çiz'+#13+
'RANGE=Uzaným'+#13+
'PALETTE=Palet'+#13+
'STEPS=Adýmlar'+#13+
'GRID=Izgara'+#13+
'GRID SIZE=Izgara Boyu'+#13+
'ALLOW DRAG=Sürüklemeye Ýzin Ver'+#13+
'AUTOMATIC=Otomatik'+#13+
'LEVEL=Seviye'+#13+
'LEVELS POSITION=Seviye Pozisyonu'+#13+
'SNAP=Tuttur'+#13+
'FOLLOW MOUSE=Fareyi Ýzle'+#13+
'TRANSPARENT=Saydam'+#13+
'ROUND FRAME=Oval Çerçeve'+#13+
'FRAME=Çerçeve'+#13+
'START=Baþlangýç'+#13+
'END=Bitiþ'+#13+
'MIDDLE=Orta'+#13+
'NO MIDDLE=Orta Yok'+#13+
'DIRECTION=Yön'+#13+
'DATASOURCE=Veri Kaynaðý'+#13+
'AVAILABLE=Mevcut'+#13+
'SELECTED=Seçilen'+#13+
'CALC=Hesapla'+#13+
'GROUP BY=Grupla'+#13+
'OF=/'+#13+
'HOLE %=Delik %'+#13+
'RESET POSITIONS=Pozisyonlarý Sýfýrla'+#13+
'MOUSE BUTTON=Fare Butonu'+#13+
'ENABLE DRAWING=Çizime Ýzin Ver'+#13+
'ENABLE SELECT=Seçime Ýzin Ver'+#13+
'ORTHOGONAL=Ortagonal'+#13+
'ANGLE=Açý'+#13+
'ZOOM TEXT=Metni Büyüt'+#13+
'PERSPECTIVE=Perspektif'+#13+
'ZOOM=Büyüt'+#13+
'ELEVATION=Yükseklik'+#13+
'BEHIND=Arkada'+#13+
'AXES=Eksenler'+#13+
'SCALES=Ölçekler'+#13+
'TITLE=Baþlýk'+#13+
'TICKS=Tikler'+#13+
'MINOR=Minör'+#13+
'CENTERED=Ortalý'+#13+
'CENTER=Orta'+#13+
'PATTERN COLOR EDITOR=Desen Renk Düzenleyici'+#13+
'START VALUE=Baþlangýç Deðeri'+#13+
'END VALUE=Bitiþ Deðeri'+#13+
'COLOR MODE=Renk Modu'+#13+
'LINE MODE=Öizgi Modu'+#13+
'HEIGHT 3D=3B Yükseklik'+#13+
'OUTLINE=Sýnýr'+#13+
'PRINT PREVIEW=Baský Önizleme'+#13+
'ANIMATED=Hareketli'+#13+
'ALLOW=Ýzin Ver'+#13+
'DASH=Kýsa Çizgi'+#13+
'DOT=Nokta'+#13+
'DASH DOT DOT=Çizgi Nokta Nokta'+#13+
'PALE=Soluk'+#13+
'STRONG=Parlak'+#13+
'WIDTH UNITS=Birim'+#13+
'FOOT=Altlýk'+#13+
'SUBFOOT=Ýkincil Altlýk'+#13+
'SUBTITLE=Alt Baþlýk'+#13+
'LEGEND=Açýklayýcý'+#13+
'COLON=Kolon'+#13+
'AXIS ORIGIN=Eksen Baþlangýcý'+#13+
'UNITS=Birim'+#13+
'PYRAMID=Piramit'+#13+
'DIAMOND=Karo'+#13+
'CUBE=Küp'+#13+
'TRIANGLE=Üçgen'+#13+
'STAR=Yýldýz'+#13+
'SQUARE=Kare'+#13+
'DOWN TRIANGLE=Aþaðý Üçgen'+#13+
'SMALL DOT=Noktacýk'+#13+
'LOAD=Yükle'+#13+
'FILE=Dosya'+#13+
'RECTANGLE=Dikdörtgen'+#13+
'HEADER=Baþlýk'+#13+
'CLEAR=Temizle'+#13+
'ONE HOUR=Bir Saat'+#13+
'ONE YEAR=Bir Yýl'+#13+
'ELLIPSE=Elips'+#13+
'CONE=Koni'+#13+
'ARROW=Ok'+#13+
'CYLLINDER=Silindir'+#13+
'TIME=Zaman'+#13+
'BRUSH=Fýrça'+#13+
'LINE=Çizgi'+#13+
'VERTICAL LINE=Dikey Çizgi'+#13+
'AXIS ARROWS=Eksen Oklarý'+#13+
'MARK TIPS=Ýþaret Tavsiyeleri'+#13+
'DASH DOT=Çizgi Nokta'+#13+
'COLOR BAND=Renk Bandý'+#13+
'COLOR LINE=Renk Çizgisi'+#13+
'INVERT. TRIANGLE=Ters Üçgen'+#13+
'INVERT. PYRAMID=Ters Piramit'+#13+
'INVERTED PYRAMID=Ters Piramit'+#13+
'SERIES DATASOURCE TEXT EDITOR=Seri veri kaynaðý düzenleyicisi'+#13+
'SOLID=Yekpare'+#13+
'WIREFRAME=Tel Çerçeve'+#13+
'DOTFRAME=Noktalar'+#13+
'SIDE BRUSH=Yanal Fýrça'+#13+
'SIDE=Yan'+#13+
'SIDE ALL=Tüm Yanlar'+#13+
'ANNOTATION=Not'+#13+
'ROTATE=Döndür'+#13+
'SMOOTH PALETTE=Yumuþak Palet'+#13+
'CHART TOOLS GALLERY=Grafik Araç Galerisi'+#13+
'ADD=Ekle'+#13+
'BORDER EDITOR=Sýnýr Düzenleyici'+#13+
'DRAWING MODE=Çizim Modu'+#13+
'CLOSE CIRCLE=Kapalý Daire'+#13+
'PICTURE=Resim'+#13+
'NATIVE=Yerel'+#13+
'DATA=Veri'+#13+
'KEEP ASPECT RATIO=Kenar Uzunluk Oranlarýný Koru'+#13+
'COPY=Kopyala'+#13+
'SAVE=Kaydet'+#13+
'SEND=Gönder'+#13+
'INCLUDE SERIES DATA=Seri Verisini Dahil Et'+#13+
'FILE SIZE=Dosya Boyutu'+#13+
'INCLUDE=Dahil Et'+#13+
'POINT INDEX=Nokta Ýndisi'+#13+
'POINT LABELS=Nokta Etiketleri'+#13+
'DELIMITER=Ayraç'+#13+
'DEPTH=Derinlik'+#13+
'COMPRESSION LEVEL=Sýkýþtýrma Seviyesi'+#13+
'COMPRESSION=Sýkýþtýrma'+#13+
'PATTERNS=Desenler'+#13+
'LABEL=Etiket'+#13+
'GROUP SLICES=Grup Bölümleri'+#13+
'EXPLODE BIGGEST=En Büyüðü Patlat'+#13+
'TOTAL ANGLE=Toplam Açý'+#13+
'HORIZ. SIZE=Yatay Boyut'+#13+
'VERT. SIZE=Dikey Boyut'+#13+
'SHAPES=Þekiller'+#13+
'INFLATE MARGINS=Marjinleri Geniþlet'+#13+
'QUALITY=Kalite'+#13+
'SPEED=Hýz'+#13+
'% QUALITY=Kalite Yüzdesi'+#13+
'GRAY SCALE=Gri Ölçek'+#13+
'PERFORMANCE=Performans'+#13+
'BROWSE=Gözat'+#13+
'TILED=Mozayik'+#13+
'HIGH=Yüksek'+#13+
'LOW=Düþük'+#13+
'DATABASE CHART=Veritabaný Grafiði'+#13+
'NON DATABASE CHART=Veritabaný Olmayan Grafik'+#13+
'HELP=Yardým'+#13+
'NEXT >=Ýleri >'+#13+
'< BACK=< Geri'+#13+
'TEECHART WIZARD=TeeChart Sihirbazý'+#13+
'PERCENT=Yüzde'+#13+
'PIXELS=Piksel'+#13+
'ERROR WIDTH=Hata Geniþliði'+#13+
'ENHANCED=Geliþmiþ'+#13+
'VISIBLE WALLS=Görünür Duvarlar'+#13+
'ACTIVE=Aktif'+#13+
'DELETE=Sil'+#13+
'ALIGNMENT=Hiza'+#13+
'ADJUST FRAME=Çerçeveyi Ayarla'+#13+
'HORIZONTAL=Yatay'+#13+
'VERTICAL=Dikey'+#13+
'VERTICAL POSITION=Dikey Pozisyon'+#13+
'NUMBER=Sayý'+#13+
'LEVELS=Seviyeler'+#13+
'OVERLAP=Üstüste Bindir'+#13+
'STACK 100%=%100 Yýðýnla'+#13+
'MOVE=Taþý'+#13+
'CLICK=Týkla'+#13+
'DELAY=Gecikme'+#13+
'DRAW LINE=Çizgi Çiz'+#13+
'FUNCTIONS=Fonksyiyonlar'+#13+
'SOURCE SERIES=Kaynak Seriler'+#13+
'ABOVE=Üst'+#13+
'BELOW=Alt'+#13+
'Dif. Limit=Fark Limiti'+#13+
'WITHIN=Ýçinde'+#13+
'EXTENDED=Uzatýlmýþ'+#13+
'STANDARD=Standart'+#13+
'STATS=Ýstistik'+#13+
'FINANCIAL=FÝnsnsal'+#13+
'OTHER=Diðer'+#13+
'TEECHART GALLERY=TeeChart Galerisi'+#13+
'CONNECTING LINES=Noktalarý Birleþtir'+#13+
'REDUCTION=Azaltma'+#13+
'LIGHT=Iþýk'+#13+
'INTENSITY=Yoðunluk'+#13+
'FONT OUTLINES=Yazý Sýnýrlarý'+#13+
'SMOOTH SHADING=Yumuþak Gölgeleme'+#13+
'AMBIENT LIGHT=Çevre Iþýðý'+#13+
'MOUSE ACTION=Fare Hareketi'+#13+
'CLOCKWISE=Saat Yönü'+#13+
'ANGLE INCREMENT=Açý Artýþý'+#13+
'RADIUS INCREMENT=Yarýçap Artýþý'+#13+
'PRINTER=Yazýcý'+#13+
'SETUP=Ayarlar'+#13+
'ORIENTATION=Oryantasyon'+#13+
'PORTRAIT=Dikey'+#13+
'LANDSCAPE=Yatay'+#13+
'MARGINS (%)=Marjinler (%)'+#13+
'MARGINS=Marjinler'+#13+
'DETAIL=Detay'+#13+
'MORE=Daha'+#13+
'PROPORTIONAL=Orantýlý'+#13+
'VIEW MARGINS=Marjinleri Göster'+#13+
'RESET MARGINS=Marjinleri Sýfýrla'+#13+
'PRINT=Yazdýr'+#13+
'TEEPREVIEW EDITOR=Baský Önizleme Düzenleyicisi'+#13+
'ALLOW MOVE=Taþýmaya Ýzin ver'+#13+
'ALLOW RESIZE=Boyut Deðiþtirmeye Ýzin Ver'+#13+
'SHOW IMAGE=Görüntüyü Göster'+#13+
'DRAG IMAGE=Görüntüyü Çiz'+#13+
'AS BITMAP=Bitmap olarak'+#13+
'SIZE %=Boyut %'+#13+
'FIELDS=Alanlar'+#13+
'SOURCE=Kaynak'+#13+
'SEPARATOR=Ayraç'+#13+
'NUMBER OF HEADER LINES=Baþlýk satýr sayýsý'+#13+
'COMMA=Virgül'+#13+
'EDITING=Düzenliyor'+#13+
'TAB=Çizelgeleme'+#13+
'SPACE=Boþluk'+#13+
'ROUND RECTANGLE=Oval Dikdörtgen'+#13+
'BOTTOM=Alt'+#13+
'RIGHT=Sað'+#13+
'C PEN=C Kalem'+#13+
'R PEN=R Kalem'+#13+
'C LABELS=C Etiketler'+#13+
'R LABELS=R Etiketler'+#13+
'MULTIPLE BAR=Birden Çok Çubuk'+#13+
'MULTIPLE AREAS=Birden Çok Alan'+#13+
'STACK GROUP=Yýðýn Grubu'+#13+
'BOTH=Ýkisi de'+#13+
'BACK DIAGONAL=Ters Diyagonal'+#13+
'B.DIAGONAL=Ters Diyagonal'+#13+
'DIAG.CROSS=Diyagonal Haç'+#13+
'WHISKER=Kedi Býyýðý'+#13+
'CROSS=Haç'+#13+
'DIAGONAL CROSS=Diyagonal Haç'+#13+
'LEFT RIGHT=Sol Sað'+#13+
'RIGHT LEFT=Sað Sol'+#13+
'FROM CENTER=Merkezden'+#13+
'FROM TOP LEFT=Sol Üstten'+#13+
'FROM BOTTOM LEFT=Sað Alttan'+#13+
'SHOW WEEKDAYS=Ýþgünlerini Göster'+#13+
'SHOW MONTHS=Aylarý Göster'+#13+
'SHOW PREVIOUS BUTTON=Önceki Butonunu Göster'#13+
'SHOW NEXT BUTTON=Ver Sonraki Butonunu Göster'#13+
'TRAILING DAYS=Ýzleyen Günler'+#13+
'SHOW TODAY=Bugünü Göster'+#13+
'TRAILING=Ýzleyen'+#13+
'LOWERED=Alçaltýlmýþ'+#13+
'RAISED=Yükseltilmiþ'+#13+
'HORIZ. OFFSET=Yatay Ofset'+#13+
'VERT. OFFSET=Dikey Ofset'+#13+
'INNER=Dahili'+#13+
'LEN=Uzunluk'+#13+
'AT LABELS ONLY=Sadece etiketlerde'+#13+
'MAXIMUM=Maksimum'+#13+
'MINIMUM=Minimum'+#13+
'CHANGE=Deðiþtir'+#13+
'LOGARITHMIC=Logaritmik'+#13+
'LOG BASE=Log. Tabaný'+#13+
'DESIRED INCREMENT=Ýstenen Artýþ'+#13+
'(INCREMENT)=(Artýþ)'+#13+
'MULTI-LINE=Çoklu-Çizgi'+#13+
'MULTI LINE=Çoklu Çizgi'+#13+
'RESIZE CHART=Grafiði Yeniden Boyutlandýr'+#13+
'X AND PERCENT=X ve Yüzde'+#13+
'X AND VALUE=X ve Deðer'+#13+
'RIGHT PERCENT=Dað Yüzde'+#13+
'LEFT PERCENT=Sol Yüzde'+#13+
'LEFT VALUE=Sol Deðer'+#13+
'RIGHT VALUE=Sað Deðer'+#13+
'PLAIN=Sade'+#13+
'LAST VALUES=Son Deðerler'+#13+
'SERIES VALUES=Seri Deðerleri'+#13+
'SERIES NAMES=Seri Adlarý'+#13+
'NEW=Yeni'+#13+
'EDIT=Düzenle'+#13+
'PANEL COLOR=Panel Rengi'+#13+
'TOP BOTTOM=Üst Alt'+#13+
'BOTTOM TOP=Alt Üst'+#13+
'DEFAULT ALIGNMENT=Varsayýlan Hizalama'+#13+
'EXPONENTIAL=Üssel'+#13+
'LABELS FORMAT=Etiket Biçimi'+#13+
'MIN. SEPARATION %=Min. Ayrýklýk %'+#13+
'YEAR=Yýl'+#13+
'MONTH=Ay'+#13+
'WEEK=Hafta'+#13+
'WEEKDAY=Ýþ Günü'+#13+
'MARK=Ýþaret'+#13+
'ROUND FIRST=Ýlkini Yuvarla'+#13+
'LABEL ON AXIS=Eksen Üzerinde Etiket'+#13+
'COUNT=Sayý'+#13+
'POSITION %=Pozisyon %'+#13+
'START %=Baþlangýç %'+#13+
'END %=Bitiþ %'+#13+
'OTHER SIDE=Diðer Taraf'+#13+
'INTER-CHAR SPACING=Harfler arasý boþluk'+#13+
'VERT. SPACING=Dikey Boþluk'+#13+
'POSITION OFFSET %=Pozisyon Ofseti %'+#13+
'GENERAL=Genel'+#13+
'MANUAL=Manuel'+#13+
'PERSISTENT=Kalýcý'+#13+
'PANEL=Panel'+#13+
'ALIAS=Lakab'+#13+
'2D=2B'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=OpenGL Düzenleyici'+#13+
'FONT 3D DEPTH=Yazýtip 3B Derinliði'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Yazý Tipi Düzenleyici'+#13+
'CLIP POINTS=Noktalarý Kes'+#13+
'CLIPPED=Kesilmiþ'+#13+
'3D %=3B %'+#13+
'QUANTIZE=Nicelendir'+#13+
'QUANTIZE 256=Nicelendir 256'+#13+
'DITHER=Dither'+#13+
'VERTICAL SMALL=Küçük Dikey'+#13+
'HORIZ. SMALL=Küçük Yatay'+#13+
'DIAG. SMALL=Küçük Diyagonal'+#13+
'BACK DIAG. SMALL=Ters Küçük Diyagonal'+#13+
'DIAG. CROSS SMALL=Diyagonal Küçük Haç'+#13+
'MINIMUM PIXELS=Minimum Pixel Sayýsý'+#13+
'ALLOW SCROLL=Kaydýrmaya Ýzin Ver'+#13+
'SWAP=Deðiþtir'+#13+
'GRADIENT EDITOR=Eðimli Renk Düzenleyici'+#13+
'TEXT STYLE=Metin Stili'+#13+
'DIVIDING LINES=Bölüm Çizgileri'+#13+
'SYMBOLS=Semboller'+#13+
'CHECK BOXES=Onaylama Kutucuðu'+#13+
'FONT SERIES COLOR=Seri Rengi'+#13+
'LEGEND STYLE=Açýklayýcý Stili'+#13+
'POINTS PER PAGE=Sayfa Baþýna Nokta'+#13+
'SCALE LAST PAGE=Son Sayfayý Ölçeklendir'+#13+
'CURRENT PAGE LEGEND=Þuanki Sayfa Açýklayýcýlarý'+#13+
'BACKGROUND=Arka Plan'+#13+
'BACK IMAGE=Arka Plan Resmi'+#13+
'STRETCH=Ger'+#13+
'TILE=Mozayik'+#13+
'BORDERS=Sýnýrlar'+#13+
'CALCULATE EVERY=Hesaplama Peryodu'+#13+
'NUMBER OF POINTS=Nokta Sayýsý'+#13+
'RANGE OF VALUES=Deðer Uzanýmlarý'+#13+
'FIRST=Ýlk'+#13+
'LAST=Son'+#13+
'ALL POINTS=Tüm Noktalar'+#13+
'DATA SOURCE=Veri Kaynaðý'+#13+
'WALLS=Duvarlar'+#13+
'PAGING=Sayfalama'+#13+
'CLONE=Klonla'+#13+
'TITLES=Baþlýklar'+#13+
'TOOLS=Araçlar'+#13+
'EXPORT=Ýhraç Et'+#13+
'CHART=Grafik'+#13+
'BACK=Arka'+#13+
'LEFT AND RIGHT=Sol ve Sað'+#13+
'SELECT A CHART STYLE=Bir grafik stili seçiniz'+#13+
'SELECT A DATABASE TABLE=Bir veritabaný tablosu seçiniz'+#13+
'TABLE=Tablo'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Grafikten istenen alaný seçiniz'+#13+
'SELECT A TEXT LABELS FIELD=Etiket alaný seçiniz'+#13+
'CHOOSE THE DESIRED CHART TYPE=Ýstenen grafik tipini seçiniz'+#13+
'CHART PREVIEW=Grafik Öngörünüm'+#13+
'SHOW LEGEND=Açýklayýcýlarý Göster'+#13+
'SHOW MARKS=Ýþaretleri Göster'+#13+
'FINISH=Bitir'+#13+
'RANDOM=Rasgele'+#13+
'DRAW EVERY=Çizim Peryodu'+#13+
'ARROWS=Oklar'+#13+
'ASCENDING=Artan'+#13+
'DESCENDING=Azalan'+#13+
'VERTICAL AXIS=Dikey Eksen'+#13+
'DATETIME=Tarih/Saat'+#13+
'TOP AND BOTTOM=Üst ve Alt'+#13+
'HORIZONTAL AXIS=Yatay Eksen'+#13+
'PERCENTS=Yüzdeler'+#13+
'VALUES=Deðerler'+#13+
'FORMATS=Biçimler'+#13+
'SHOW IN LEGEND=Açýklayýcýda Göster'+#13+
'SORT=Sýrala'+#13+
'MARKS=Ýþaretler'+#13+
'BEVEL INNER=Ýç Seviyelendirici'+#13+
'BEVEL OUTER=Dýþ Seviyelndirici'+#13+
'PANEL EDITOR=Panel Düzenleyici'+#13+
'CONTINUOUS=Devamlý'+#13+
'HORIZ. ALIGNMENT=Yatay Hiza'+#13+
'EXPORT CHART=Grafiði Ýhraç Et'+#13+
'BELOW %=% Altta'+#13+
'BELOW VALUE=Deðerin Altýnda'+#13+
'NEAREST POINT=En Yakýn Nokta'+#13+
'DRAG MARKS=Ýþaret Taþýyýcý'+#13+
'TEECHART PRINT PREVIEW=Baský Önizleme'+#13+
'X VALUE=X Deðeri'+#13+
'X AND Y VALUES=X ve Y Deðeri'+#13+
'SHININESS=Parlaklýk'+#13+
'ALL SERIES VISIBLE=Bütün Seriler Görünür'+#13+
'MARGIN=Marjin'+#13+
'DIAGONAL=Diyagonal'+#13+
'LEFT TOP=Sol Üst'+#13+
'LEFT BOTTOM=Sol Alt'+#13+
'RIGHT TOP=Sað Üst'+#13+
'RIGHT BOTTOM=Sað Alt'+#13+
'EXACT DATE TIME=Tam Tarih/Saat'+#13+
'RECT. GRADIENT=Eðimli'+#13+
'CROSS SMALL=Küçük Haç'+#13+
'AVG=Ortalama'+#13+
'FUNCTION=Fonksiyon'+#13+
'AUTO=Otomatik'+#13+
'ONE MILLISECOND=Bir milisaniye'+#13+
'ONE SECOND=Bir saniye'+#13+
'FIVE SECONDS=Beþ saniye'+#13+
'TEN SECONDS=On saniye'+#13+
'FIFTEEN SECONDS=Onbeþ saniye'+#13+
'THIRTY SECONDS=Otuz saniye'+#13+
'ONE MINUTE=Bir dakika'+#13+
'FIVE MINUTES=Beþ Dakika'+#13+
'TEN MINUTES=On Dakika'+#13+
'FIFTEEN MINUTES=Onbeþ Dakika'+#13+
'THIRTY MINUTES=Otuz Dakika'+#13+
'TWO HOURS=Ýki Saat'+#13+
'TWO HOURS=Ýki Saat'+#13+
'SIX HOURS=Altý Saat'+#13+
'TWELVE HOURS=Oniki Saat'+#13+
'ONE DAY=Bir gün'+#13+
'TWO DAYS=Ýki gün'+#13+
'THREE DAYS=Üç gün'+#13+
'ONE WEEK=Bir hafta'+#13+
'HALF MONTH=Yarým ay'+#13+
'ONE MONTH=Bir ay'+#13+
'TWO MONTHS=Ýki ay'+#13+
'THREE MONTHS=Üç ay'+#13+
'FOUR MONTHS=Dört ay'+#13+
'SIX MONTHS=Altý ay'+#13+
'IRREGULAR=Düzensiz'+#13+
'CLICKABLE=Týklanabilir'+#13+
'ROUND=Oval'+#13+
'FLAT=Yassý'+#13+
'PIE=Pasta'+#13+
'HORIZ. BAR=Yatay Çubuk'+#13+
'BUBBLE=Kabarcýk'+#13+
'SHAPE=Þekil'+#13+
'POINT=Nokta'+#13+
'FAST LINE=Hýzlý Çizgi'+#13+
'CANDLE=Mum'+#13+
'VOLUME=Hacim'+#13+
'HORIZ LINE=Yatay Çizgi'+#13+
'SURFACE=Yüzey'+#13+
'LEFT AXIS=Sol Eksen'+#13+
'RIGHT AXIS=Sað Eksen'+#13+
'TOP AXIS=Üst Eksen'+#13+
'BOTTOM AXIS=Alt Eksen'+#13+
'CHANGE SERIES TITLE=Seri Baþlýðýný Deðiþtir'+#13+
'DELETE %S ?=%s silinsin mi ?'+#13+
'DESIRED %S INCREMENT=Ýstenen %s artýþý'+#13+
'INCORRECT VALUE. REASON: %S=Geçersiz Deðer. Neden: %s'+#13+
'FILLSAMPLEVALUES NUMVALUES MUST BE > 0=FillSampleValues. Deðer sayýsý > 0 olmalý.'#13+
'VISIT OUR WEB SITE !=Web sitemizi ziyaret edin !'#13+
'SHOW PAGE NUMBER=Sayfa Numarasýný Göster'#13+
'PAGE NUMBER=Sayfa No'#13+
'PAGE %D OF %D=Sayfa %d / %d'#13+
'TEECHART LANGUAGES=TeeChart Dilleri'#13+
'CHOOSE A LANGUAGE=Bir dil seçiniz'+#13+
'SELECT ALL=Tümünü Seç'#13+
'MOVE UP=Yukarý Taþý'#13+
'MOVE DOWN=Aþaðý Taþý'#13+
'DRAW ALL=Tümünü Çiz'#13+
'TEXT FILE=Metin Dosya'#13+
'IMAG. SYMBOL=Görüntü Sembolü'#13+
'DRAG REPAINT=Sürükle yeniden boya'#13+
'NO LIMIT DRAG=Sürüklemeyi sýnýrlama'#13+

// 6.0

'BEVEL SIZE=Çerçeve genýþlýðý'#13+
'DELETE ROW=Satir sýl'#13+
'VOLUME SERIES=Ýþ.hacmý serýsý'#13+
'SINGLE=Tek'#13+
'REMOVE CUSTOM COLORS=Kýþýsel Renklerý kaldir'#13+
'USE PALETTE MINIMUM=Palet mýnýmumunu kullan'#13+
'AXIS MAXIMUM=Eksen mýnýnmumu'#13+
'AXIS CENTER=Eksen merkezý'#13+
'AXIS MINIMUM=Eksen mýnýmumu'#13+
'DAILY (NONE)=Günlük (yok)'#13+
'WEEKLY=Haftalik'#13+
'MONTHLY=Aylik'#13+
'BI-MONTHLY=2 Aylik'#13+
'QUARTERLY=3 Aylik'#13+
'YEARLY=Yillik'#13+
'DATETIME PERIOD=Tarýh peryodu'#13+
'CASE SENSITIVE=Büyük/küçük harf duyarli'#13+
'DRAG STYLE=Sürükleme stýlý'#13+
'SQUARED=Kare'#13+
'GRID 3D SERIES=Izgara 3d serýsý'#13+
'DARK BORDER=Koyu kenar'#13+
'PIE SERIES=Elma serýsý'#13+
'FOCUS=Odaklan'#13+
'EXPLODE=Ayrik'#13+
'FACTOR=Faktör'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=þablondan grafýk (*.tee dosyasi)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Teechart þablonunu dosyadan aç'#13+
'BINARY=ýkýlý'#13+
'VOLUME OSCILLATOR=Volume Oscillator'#13+
'PIE SLICES=Elma dýlýmlerý'#13+
'ARROW WIDTH=Ok genýþlýðý'#13+
'ARROW HEIGHT=Ok yükseklýðý'#13+
'DEFAULT COLOR=Varsayilan Renk'#13+
'PERIOD=PERÝYOT'#13+
'UP=YUKARI'#13+
'DOWN=AÞAÐI'#13+
'SHADOW EDITOR=GÖLGE EDÝTÖRÜ'#13+
'CALLOUT='#13+
'TEXT ALIGNMENT=METÝN HÝZALAMA'#13+
'DISTANCE=UZAKLIK'#13+
'ARROW HEAD=OK BAÞLIÐI'#13+
'POINTER=ÝÞARETÇÝ'#13+
'AVAILABLE LANGUAGES=MEVCUT DÝLLER'#13+
'CALCULATE USING=HESAPLAMAK ÝÇÝN KULLAN'#13+
'EVERY NUMBER OF POINTS=HER NOKTA'#13+
'EVERY RANGE=HER ARALIK'#13+
'INCLUDE NULL VALUES=BOÞ DEÐERLER DAHÝL'#13+
'DATE=TARÝH'#13+
'ENTER DATE=TARÝH GÝRÝNÝZ'#13+
'ENTER TIME=SAAT GÝRÝNÝZ'#13+
'CYLINDER=SÝLÝNDÝR'#13+
'SLANT CUBE=EÐÝK SÝLÝNDÝR'#13+
'TICK LINES=TÝK ÇÝZGÝLERÝ'#13+
'% BAR DEPTH=% ÇUBUK DERÝNLÝÐÝ'#13+
'DEVIATION=SAPMA'#13+
'UPPER=ÜST'#13+
'LOWER=AÞAÐI'#13+
'FILL 80%=DOLU 80%'#13+
'FILL 60%=DOLU 60%'#13+
'FILL 40%=DOLU 40%'#13+
'FILL 20%=DOLU 20%'#13+
'FILL 10%=DOLU 10%'#13+
'ZIG ZAG=ZÝG ZAG'#13+
'METAL=METAL'#13+
'WOOD=TAHTA'#13+
'STONE=TAÞ'#13+
'CLOUDS=BULUT'#13+
'GRASS=ÇÝM'#13+
'FIRE=ATEÞ'#13+
'SNOW=KAR'#13+
'NOTHING=HÝÇ BÝRÞEY'#13+
'LEFT TRIANGLE=SOL ÜÇGEN'#13+
'RIGHT TRIANGLE=SAÐ ÜÇGEN'#13+
'HIGH-LOW=DÜÞÜK-YÜKSEK'#13+
'CONSTANT=SABÝT'#13+
'VIEW SERIES NAMES=SERÝ ADLARI'#13+
'SHOW LABELS=ETÝKETLERÝ GÖSTER'#13+
'SHOW COLORS=RENKLERÝ GÖSTER'#13+
'XYZ SERIES=XYZ SERÝLERÝ'#13+
'SHOW X VALUES=X DEÐERLERÝNÝ GÖSTER'#13+
'EDIT COLOR=RENK DÜZENLE'#13+
'MAKE NULL POINT=BOÞ NOKTA YAP'#13+
'APPEND ROW=OK EKLE'#13+
'TEXT FONT=METÝN YAZI TÝPÝ'#13+
'SMOOTH=DÜZGÜN'#13+
'CHART THEME SELECTOR=GRAFÝK TEMA SEÇÝCÝSÝ'#13+
'PREVIEW=ÖNÝZLEME'#13+
'THEMES=TEMELAR'#13+
'COLOR PALETTE=RENK PALETÝ'#13+
'VIEW 3D=3D GÖRÜNÜM'#13+
'SCALE=ÖLÇEK'#13+
'MARGIN %=SINIR'#13+
'ACCUMULATE=YIÐMAK'#13+
'DRAW BEHIND AXES=EKSENLERÝN ARKASINDA ÇÝZ '#13+
'X GRID EVERY=HER IZGARADA X'#13+
'Z GRID EVERY=HER IZGARADA Z'#13+
'DATE PERIOD=TARÝH PERÝYODU'#13+
'TIME PERIOD=SAAT PERÝYODU'#13+
'INTERPOLATE=ENTERPOLASYON'#13+
'USE SERIES Z=Z SERÝSÝ KULLAN'#13+
'START X=BAÞLANGIÇ X'#13+
'STEP=ADIM'#13+
'NUM. POINTS=NOKTA SAYISI'#13+
'COLOR EACH LINE=HER ÇÝZGÝ RENKLÝ'#13+
'SORT BY=SIRALI'#13+
'CALCULATION=HESAPLAMA'#13+
'GROUP=GRUP'#13+
'WEIGHT=AÐIRLIK'#13+
'EDIT LEGEND=AÇIKAYICIYI DÜZENLE'#13+
'IGNORE NULLS=BOÞLARI ÝHMAL ET'#13+
'NUMERIC FORMAT=SAYI FORMATI'#13+
'DATE TIME=TARÝH SAAT'#13+
'GEOGRAPHIC=ÇOÐRAFÝ'#13+
'DECIMALS=ONDALIK'#13+
'FIXED=SABÝT'#13+
'THOUSANDS=BÝNLERCE'#13+
'CURRENCY=PARA BÝRÝMÝ'#13+
'VIEWS=GÖRÜNÜMLER'#13+
'OFFSET=OFSET'#13+
'ALTERNATE=DEÐÝÞKEN'#13+
'ZOOM ON UP LEFT DRAG=YUKARI VE SOLA SÜRÜKLERKEN ZUMLA'#13+
'LIGHT 0=IÞIK 0'#13+
'LIGHT 1=IÞIK 1'#13+
'LIGHT 2=IÞIK 2'#13+
'FIXED POSITION=SABÝT POZÝSYON'#13+
'DRAW STYLE=ÇÝZÝM STÝLÝ'#13+
'POINTS=NOKTALAR'#13+
'NO CHECK BOXES=ÝÞARET KUTULARI YOK'#13+
'RADIO BUTTONS=SEÇENEK DÜÐMELERÝ'#13+
'DEFAULT BORDER=VARSAYILAN SINIR'#13+
'SEPARATION=AYRIM'#13+
'ROUND BORDER=SINIRI YUVARLA'#13+
'Z DATETIME=Z TARÝH/SAAT'#13+
'SYMBOL=SEMBOL'#13+
'NUMBER OF SAMPLE VALUES=ÖRNEK DEÐER SAYISI'#13+
'AUTO HIDE=OTOMATÝK SAKLA'#13+
'DIF. LIMIT=FARK SINIRI'#13+
'RESIZE PIXELS TOLERANCE=PÝKSEL TOLARANSINI AYARLA'#13+
'FULL REPAINT=TAMAMEN BOYA'#13+
'END POINT=BÝTÝÞ NOKTASI'#13+
'GALLERY=GALERÝ'#13+
'INVERTED GRAY='#13+
'RAINBOW=GÖKKUÞAÐI'#13+
'BAND 1=ÞERÝT 1'#13+
'BAND 2=ÞERÝT 2'#13+
'TRANSPOSE NOW=ÞÝMDÝ TERS ÇEVÝR'#13+
'TEECHART LIGHTING=GRAFÝK IÞIKLANDIRMASI'#13+
'LINEAR=DOÐRUSAL'#13+
'SPOTLIGHT=SPOTLÝGHT'#13+
'PERIOD 1=PERÝYOT 1'#13+
'PERIOD 2=PERÝYOT 2'#13+
'PERIOD 3=PERÝYOT 3'#13+
'HISTOGRAM=HÝSTOGRAM'#13+
'EXP. LINE=ÜSSEL DOÐRU'#13+
'MACD=MACD'#13+
'SHAPE INDEX=ÞEKÝL ÝNDEKSÝ'#13+
'CLOSED=KAPALI'#13+
'WEIGHTED=AÐIRLIKLI'#13+
'WEIGHTED BY INDEX=ÝNDEKS AÐIRLIKLI'#13+
'DESIGN TIME OPTIONS=TASARIM SEÇENEKLERÝ'#13+
'LANGUAGE=DÝL'#13+
'CHART GALLERY=GRAFÝK GALERÝSÝ'#13+
'MODE=MOD'#13+
'CHART EDITOR=GRAFÝK EDÝTÖRÜ'#13+
'REMEMBER SIZE=BÜYÜKLÜÐÜ ANIMSA'#13+
'REMEMBER POSITION=YERÝ ANIMSA'#13+
'TREE MODE=HÝYERARÞÝK MOD'#13+
'RESET=RESET'#13+
'NEW CHART=YENÝ GRAFÝK'#13+
'DEFAULT THEME=VARSAYILAN TEMA'#13+
'TEECHART DEFAULT=GRAFÝK VARSAYILANI'#13+
'CLASSIC=KLASÝK'#13+
'POSLOVNO=POSLOVNO'#13+
'WINDOWS XP=WINDOWS XP'#13+
'BLUES=MAVÝLER'#13+
'MULTIPLE PIES=ÇOKLU DÝLÝMLER'#13+
'3D GRADIENT=3D EÐÝM'#13+
'DISABLE=PASÝFLEÞTÝR'#13+
'COLOR EACH SLICE=HER DÝLÝM RENKLÝ'#13+
'BASE LINE=TABAN'#13+
'BOX SIZE=KUTU BÜYÜKLÜÐÜ'#13+
'REVERSAL AMOUNT=TERS DÖNME DEÐERÝ'#13+
'PERCENTAGE=YÜZDE'#13+
'COMPLETE R.M.S.=TAMAMLANMIÞ R.M.S.'#13+
'BUTTON=DÜÐME'#13+
'ALL=HEPSÝ'#13+
'INITIAL DELAY=BAÞLANGIÇ GECÝKMESÝ'#13+
'THUMB=Thumb'#13+
'AUTO-REPEAT=OTO-TEKRAR'#13+
'BACK COLOR=ARKA RENK'#13+
'HANDLES=Handles'#13+
'ALLOW RESIZE CHART=GRAFÝK BOYUTLARINI DEÐÝÞTÝRMEYE ÝZÝN VER'#13+
'LOOP=DÖNGÜ'#13+
'START AT MIN. VALUE=MÝNÝMUM DEÐERDEN BAÞLA'#13+
'EXECUTE !=ÇALIÞTIR !'#13+
'ONE WAY=Tek yol'#13+
'CIRCULAR=DAÝRESEL'#13+
'DRAW BEHIND SERIES= SERÝLERÝN ARKASINDA ÇÝZ'#13+
'WEB URL=Web Url'#13+
'SELF STACK=ÖZ YIÐIN'#13+
'CELL=HÜCRE'#13+
'ROW=Satir'#13+
'COLUMN=SÜTUN'#13+
'SIDE LINES=YAN HATLAR'#13+
'FAST BRUSH=HIZLI FIRÇALAMA'#13+
'SVG OPTIONS=SVG SEÇENEKLERÝ'#13+
'TEXT ANTI-ALIAS=METÝN ANTÝ-ALÝAS'#13+
'THEME=Tema'#13+
'EXPORT DIALOG=ÝHRAÇ ET DÝYALOG'#13+
'TEXT QUOTES=METÝN AYRAÇLARI'#13+
'POINT COLORS=NOKTA RENKLERÝ'#13+
'OUTLINE GRADIENT=Sinir EÐÝMLERÝ'#13+
'PERIMETER=Çevre'#13+
'ROOT MEAN SQUARE=Root Mean Sq.'#13+
'STD. SAPMA='#13+
'TREND=Trend'#13+
'ACE=Yildiz'#13+
'BUSINESS=ÝÞ'#13+
'CARIBE SUN=CARÝBE GÜNEÞÝ'#13+
'CLEAR DAY=AÇIK HAVA'#13+
'DESERT=ÇÖL'#13+
'FARM=ÇÝFTLÝK'#13+
'FUNKY=FunkÝ'#13+
'GOLF=Golf'#13+
'HOT=SIÇAK'#13+
'NIGHT=GECE'#13+
'PASTEL=Pastel'#13+
'SEA=DENÝZ'#13+
'SEA 2=DENÝZ 2'#13+
'SUNSET=GÜn Batimi'#13+
'TROPICAL=TropÝk'#13+
'BALANCE=Denge'#13+
'RADIAL OFFSET=Radyal Ofset'#13+
'HORIZ=Yatay'#13+
'VERT=DÝkey'#13+
'RADIAL=Radyal'#13+
'DIAGONAL UP=Çapraz YUKARI'#13+
'DIAGONAL DOWN=Çapraz AÞAÐI'#13+
'COVER=Kapak'#13+
'HIDE TRIANGLES=ÜÇGENLERÝ GÝZLE'#13+
'MIRRORED=YANSIMALI'#13+
'VALUE SOURCE=DEÐER KAYNAÐI'#13;
  end;
end;

Procedure TeeSetTurkish;
begin
  TeeCreateTurkish;
  TeeLanguage:=TeeTurkishLanguage;
  TeeTurkishConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeTurkishLanguage);
end.


