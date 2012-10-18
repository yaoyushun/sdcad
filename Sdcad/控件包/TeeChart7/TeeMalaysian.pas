unit TeeMalaysian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeMalaysianLanguage:TStringList=nil;

Procedure TeeSetMalaysian;
Procedure TeeCreateMalaysian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeMalaysianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 oleh David Berneda';
  TeeMsg_LegendFirstValue   :='Nilai Petunjuk Pertama mestilah > 0';
  TeeMsg_LegendColorWidth   :='Lebar Warna Petunjuk mestilah > 0%';
  TeeMsg_SeriesSetDataSource:='Tiada CartaUtama untuk disahkan Sumber Data';
  TeeMsg_SeriesInvDataSource:='Tiada Sumber Data yang sah: %s';
  TeeMsg_FillSample         :='ContohNilaiPenuh NomborNilai mestilah > 0';
  TeeMsg_AxisLogDateTime    :='Paksi TarikhMasa Tidak Boleh Logaritma';
  TeeMsg_AxisLogNotPositive :='Nilai Minima dan Maksima Paksi Logaritma haruslah >= 0';
  TeeMsg_AxisLabelSep       :='Label Pemisahan % mestilah lebih besar dari 0';
  TeeMsg_AxisIncrementNeg   :='Kenaikan Paksi mestilah >= 0';
  TeeMsg_AxisMinMax         :='Nilai Minima Paksi mestilah <= Maksima';
  TeeMsg_AxisMaxMin         :='Nilai Maksima Paksi mestilah >= Minima';
  TeeMsg_AxisLogBase        :='Asas Paksi Logaritma haruslah >= 2';
  TeeMsg_MaxPointsPerPage   :='MakTitikSeMukasurat mestilah >= 0';
  TeeMsg_3dPercent          :='Peratus kesan 3D mestilah di antara %d dan %d';
  TeeMsg_CircularSeries     :='Turutan Bulat Kebergantungan tidak dibenarkan';
  TeeMsg_WarningHiColor     :='Warna 16k atau lebih diperlukan untuk paparan lebih baik';

  TeeMsg_DefaultPercentOf   :='%s dari %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'dari %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tajuk Paksi';
  TeeMsg_AxisLabels         :='Label Paksi';
  TeeMsg_RefreshInterval    :='Selang Segar Semula mestilah di antara 0 dan 60';
  TeeMsg_SeriesParentNoSelf :='Turutan.CartaUtama bukan saya sendiri!';
  TeeMsg_GalleryLine        :='Garis';
  TeeMsg_GalleryPoint       :='Titik';
  TeeMsg_GalleryArea        :='Luas Terunjur';
  TeeMsg_GalleryBar         :='Palang';
  TeeMsg_GalleryHorizBar    :='Palang Mendatar';
  TeeMsg_Stack              :='Tindanan';
  TeeMsg_GalleryPie         :='Pai';
  TeeMsg_GalleryCircled     :='Bulatan';
  TeeMsg_GalleryFastLine    :='Garis Laju';
  TeeMsg_GalleryHorizLine   :='Garis Mendatar';

  TeeMsg_PieSample1         :='Kereta';
  TeeMsg_PieSample2         :='Talipon';
  TeeMsg_PieSample3         :='Jadual';
  TeeMsg_PieSample4         :='Peranti Paparan CRT';
  TeeMsg_PieSample5         :='Lampu';
  TeeMsg_PieSample6         :='Papan Kekunci';
  TeeMsg_PieSample7         :='Motosikal';
  TeeMsg_PieSample8         :='Kerusi';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Penyuntingan %s';

  TeeMsg_GalleryStandard    :='Piawai';  
  TeeMsg_GalleryExtended    :='Diperluas';  
  TeeMsg_GalleryFunctions   :='Fungsi';

  TeeMsg_EditChart          :='&Sunting Carta...';
  TeeMsg_PrintPreview       :='&Cetak Prapandang...'; 
  TeeMsg_ExportChart        :='E&ksport Carta...';
  TeeMsg_CustomAxes         :='Ubahsuai Paksi...';

  TeeMsg_InvalidEditorClass :='%s: Kelas Editor Tidak Sah: %s';
  TeeMsg_MissingEditorClass :='%s: Tiada Dialog Editor';

  TeeMsg_GalleryArrow       :='Anak Panah';

  TeeMsg_ExpFinish          :='Se&lesai';
  TeeMsg_ExpNext            :='Se&terusnya >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Rekaan';
  TeeMsg_GanttSample2       :='Pemprototaipan';
  TeeMsg_GanttSample3       :='Pembangunan';
  TeeMsg_GanttSample4       :='Jualan';
  TeeMsg_GanttSample5       :='Pasaran';
  TeeMsg_GanttSample6       :='Percubaan';
  TeeMsg_GanttSample7       :='Perkilangan';
  TeeMsg_GanttSample8       :='Penyahpepijatan';
  TeeMsg_GanttSample9       :='Versi Baru';
  TeeMsg_GanttSample10      :='Perbankan';

  TeeMsg_ChangeSeriesTitle  :='Tukar Tajuk Siri';
  TeeMsg_NewSeriesTitle     :='Tajuk Siri Baru:';
  TeeMsg_DateTime           :='TarikhMasa';
  TeeMsg_TopAxis            :='Paksi Atas';
  TeeMsg_BottomAxis         :='Paksi Bawah';
  TeeMsg_LeftAxis           :='Paksi Kiri';
  TeeMsg_RightAxis          :='Paksi Kanan';

  TeeMsg_SureToDelete       :='Padam %s ?';
  TeeMsg_DateTimeFormat     :='For&mat TarikhMasa:';
  TeeMsg_Default            :='Nilai Lalai';
  TeeMsg_ValuesFormat       :='Fo&rmat Nilai:';  
  TeeMsg_Maximum            :='Maksima';
  TeeMsg_Minimum            :='Minima';
  TeeMsg_DesiredIncrement   :='Memerlukan %s Tambahan';

  TeeMsg_IncorrectMaxMinValue:='Nilai Tidak Betul. Sebab: %s';
  TeeMsg_EnterDateTime      :='Masukkan [Jumlah Hari] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Gunapakai Pertukaran ?';
  TeeMsg_SelectedSeries     :='(Turutan Pilihan)';
  TeeMsg_RefreshData        :='Se&gar Semula Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Tambah';
  TeeMsg_FunctionSubtract   :='Tolak';
  TeeMsg_FunctionMultiply   :='Darab';
  TeeMsg_FunctionDivide     :='Bahagi';
  TeeMsg_FunctionHigh       :='Tinggi';
  TeeMsg_FunctionLow        :='Rendah';
  TeeMsg_FunctionAverage    :='Purata';

  TeeMsg_GalleryShape       :='Bentuk';
  TeeMsg_GalleryBubble      :='Gelembung';
  TeeMsg_FunctionNone       :='Salin';

  TeeMsg_None               :='(tiada)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Saiz Penuding mestilah lebih besar dari kosong';
  TeeMsg_About              :='Me&ngenai TeeChart...';

  tcAdditional              :='Tambahan';
  tcDControls               :='Kawalan Data';
  tcQReport                 :='LaporanQ';

  TeeMsg_DataSet            :='Set Data';
  TeeMsg_AskDataSet         :='Set &Data';

  TeeMsg_SingleRecord       :='Satu Rekod';
  TeeMsg_AskDataSource      :='Sum&ber Data';

  TeeMsg_Summary            :='Ringkasan';

  TeeMsg_FunctionPeriod     :='Tempoh Fungsi seharusnya >= 0';

  TeeMsg_WizardTab          :='Perniagaan';
  TeeMsg_TeeChartWizard     :='TeeChart Bestari';

  TeeMsg_ClearImage         :='Leg&a';
  TeeMsg_BrowseImage        :='Semak Se&imbas...';

  TeeMsg_WizardSureToClose  :='Adakah anda pasti untuk menutup TeeChart bestari ?';
  TeeMsg_FieldNotFound      :='Medan %s tidak wujud';

  TeeMsg_DepthAxis          :='Ukur Dalam Paksi';
  TeeMsg_PieOther           :='Lain';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pai';
  TeeMsg_ValuesBar          :='Palang';
  TeeMsg_ValuesAngle        :='Sudut';
  TeeMsg_ValuesGanttStart   :='Mula';
  TeeMsg_ValuesGanttEnd     :='Akhir';
  TeeMsg_ValuesGanttNextTask:='TugasBerikut';
  TeeMsg_ValuesBubbleRadius :='Ukurlilit';
  TeeMsg_ValuesArrowEndX    :='AkhirX';
  TeeMsg_ValuesArrowEndY    :='AkhirY';
  TeeMsg_Legend             :='Petunjuk';
  TeeMsg_Title              :='Tajuk';
  TeeMsg_Foot               :='Catatan Kaki';
  TeeMsg_Period		    :='Tempoh';
  TeeMsg_PeriodRange        :='Julat Tempoh';
  TeeMsg_CalcPeriod         :='Kira %s setiap:';
  TeeMsg_SmallDotsPen       :='Titik Kecil';

  TeeMsg_InvalidTeeFile     :='Carta Tidak Sah dalam fail *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Fail *.'+TeeMsg_TeeExtension+' silap format';
  TeeMsg_EmptyTeeFile       :='Fail *.'+TeeMsg_TeeExtension+' kosong';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Paksi Carta';
  TeeMsg_ChartAxesCategoryDesc   := 'Sifat dan Acara Paksi Carta';
  TeeMsg_ChartWallsCategoryName  := 'Dinding Carta';
  TeeMsg_ChartWallsCategoryDesc  := 'Sifat dan Acara Dinding Carta';
  TeeMsg_ChartTitlesCategoryName := 'Tajuk Carta';
  TeeMsg_ChartTitlesCategoryDesc := 'Sifat dan Acara Tajuk Carta';
  TeeMsg_Chart3DCategoryName     := 'Carta 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Sifat dan Acara Chart 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Ubahsuai';
  TeeMsg_Series                 :='Turutan';
  TeeMsg_SeriesList             :='Turutan...';

  TeeMsg_PageOfPages            :='Mukasurat %d dari %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Pertama';
  TeeMsg_Prior  :='Sebelum';
  TeeMsg_Next   :='Seterusnya';
  TeeMsg_Last   :='Akhir';
  TeeMsg_Insert :='Selit';
  TeeMsg_Delete :='Padam';
  TeeMsg_Edit   :='Sunting';
  TeeMsg_Post   :='Hantar';
  TeeMsg_Cancel :='Batal';

  TeeMsg_All    :='(semua)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Teks';

  TeeMsg_AsBMP        :='sebagai &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='sebagai &Metafile';
  TeeMsg_EMFFilter    :='Kenaikan Kualiti Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Sifat Panel tidak diset dalam format Eksport';

  TeeMsg_Normal    :='Biasa';
  TeeMsg_NoBorder  :='Tiada Sempadan';
  TeeMsg_Dotted    :='Garis terputus-putus';
  TeeMsg_Colors    :='Warna';
  TeeMsg_Filled    :='Penuh';
  TeeMsg_Marks     :='Tanda';
  TeeMsg_Stairs    :='Tangga';
  TeeMsg_Points    :='Titik';
  TeeMsg_Height    :='Tinggi';
  TeeMsg_Hollow    :='Lompang';
  TeeMsg_Point2D   :='Titik 2D';
  TeeMsg_Triangle  :='Tigasegi';
  TeeMsg_Star      :='Bintang';
  TeeMsg_Circle    :='Bulatan';
  TeeMsg_DownTri   :='Tigasegi Ke Bawah';
  TeeMsg_Cross     :='Campur';
  TeeMsg_Diamond   :='Berlian';
  TeeMsg_NoLines   :='Tiada Garisan';
  TeeMsg_Stack100  :='Tindanan 100%';
  TeeMsg_Pyramid   :='Piramid';
  TeeMsg_Ellipse   :='Elips';
  TeeMsg_InvPyramid:='Piramid Terbalik';
  TeeMsg_Sides     :='Sudut';
  TeeMsg_SideAll   :='Semua sudut';
  TeeMsg_Patterns  :='Corak';
  TeeMsg_Exploded  :='Terburai';
  TeeMsg_Shadow    :='Bayang';
  TeeMsg_SemiPie   :='Separuh Pai';
  TeeMsg_Rectangle :='Empatsegi';
  TeeMsg_VertLine  :='Garis Menegak';
  TeeMsg_HorizLine :='Garis Mendatar';
  TeeMsg_Line      :='Garis';
  TeeMsg_Cube      :='Empatsegi Sama';
  TeeMsg_DiagCross :='Pangkah';

  TeeMsg_CanNotFindTempPath    :='Tidak jumpa direktori sementara';
  TeeMsg_CanNotCreateTempChart :='Tidak boleh buat fail sementara';
  TeeMsg_CanNotEmailChart      :='Tidak boleh email TeeChart. Kesilapan MAPI: %d';

  TeeMsg_SeriesDelete :='Turutan Padam: Nilai Indeks %d di luar lingkungan (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='sebagai &JPEG';
  TeeMsg_JPEGFilter    :='Fail JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='sebagai &GIF';
  TeeMsg_GIFFilter     :='Fail GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='sebagai &PNG';
  TeeMsg_PNGFilter     :='Fail PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='sebagai PC&X';
  TeeMsg_PCXFilter     :='Fail PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='sebagai &VML (HTM)';
  TeeMsg_VMLFilter     :='Fail VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='Ba&hasa...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Kutub';    
  TeeMsg_GalleryCandle      :='Lilin';
  TeeMsg_GalleryVolume      :='Muatan';
  TeeMsg_GallerySurface     :='Permukaan';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Titik 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='Palang 3D';
  TeeMsg_GalleryBigCandle   :='Lilin Besar';
  TeeMsg_GalleryLinePoint   :='Garis Titik';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Air Terjun';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Jam';
  TeeMsg_GalleryColorGrid   :='WarnaGrid';
  TeeMsg_GalleryBoxPlot     :='KotakPlot';
  TeeMsg_GalleryHorizBoxPlot:='KotakPlot Mendatar';
  TeeMsg_GalleryBarJoin     :='Palang Bercantum';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramid';
  TeeMsg_GalleryMap         :='Peta';

  TeeMsg_PolyDegreeRange     :='Darjah Polinomial mestilah di antara 1 dan 20';
  TeeMsg_AnswerVectorIndex   :='Jawapan Indeks Vektor mestilah di antara 1 dan %d';
  TeeMsg_FittingError        :='Tidak boleh proses kemasan';
  TeeMsg_PeriodRange         :='Tempoh mestilah >= 0';
  TeeMsg_ExpAverageWeight    :='Purata Eksponen Wajaran mestilah di antara 0 dan 1';
  TeeMsg_GalleryErrorBar     :='Ralat Palang';
  TeeMsg_GalleryError        :='Ralat';
  TeeMsg_GalleryHighLow      :='Tinggi-Rendah';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Pembahagian Momentum';
  TeeMsg_FunctionExpAverage  :='Purata Eksponen';
  TeeMsg_FunctionMovingAverage:='Purata Bergerak';
  TeeMsg_FunctionExpMovAve   :='Purata Bergerak Eksponen';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Keluk Kemasan';
  TeeMsg_FunctionTrend       :='Arah Aliran';
  TeeMsg_FunctionExpTrend    :='Arah Aliran Eksponen';
  TeeMsg_FunctionLogTrend    :='Pengelongan Arah Aliran';
  TeeMsg_FunctionCumulative  :='Kumulatif';
  TeeMsg_FunctionStdDeviation:='Sisihan Piawai';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Punca Min Kuasa Dua';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stastik';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Bilang';
  TeeMsg_LoadChart           :='Buka TeeChart...';
  TeeMsg_SaveChart           :='Simpan TeeChart...';
  TeeMsg_TeeFiles            :='Fail TeeChart Pro';

  TeeMsg_GallerySamples      :='Lain-lain';
  TeeMsg_GalleryStats        :='Statistik';

  TeeMsg_CannotFindEditor    :='Tidak jumpa editor turutan: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod Ralat: %d muat turun Carta dari URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod Ralat: %d muat turun data Turutan dari URL: %s';

  TeeMsg_Test                :='Cubaan...';

  TeeMsg_ValuesDate          :='Tarikh';
  TeeMsg_ValuesOpen          :='Buka';
  TeeMsg_ValuesHigh          :='Tinggi';
  TeeMsg_ValuesLow           :='Rendah';
  TeeMsg_ValuesClose         :='Tutup';
  TeeMsg_ValuesOffset        :='Ofset';
  TeeMsg_ValuesStdError      :='RalatPiawai';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Jumlah Titik Bezier mestilah > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Sunting';
  TeeCommanMsg_Print    :='Cetak';
  TeeCommanMsg_Copy     :='Salin';
  TeeCommanMsg_Save     :='Simpan';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Putaran: %d° Elevasi: %d°';
  TeeCommanMsg_Rotate   :='Putar';

  TeeCommanMsg_Moving   :='Ofset Mendatar: %d Ofset Menegak: %d';
  TeeCommanMsg_Move     :='Gerak';

  TeeCommanMsg_Zooming  :='Zum: %d %%';
  TeeCommanMsg_Zoom     :='Zum';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Ukur Dalam';

  TeeCommanMsg_Chart    :='Carta';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Seret %s untuk putar';
  TeeCommanMsg_MoveLabel  :='Seret %s untuk gerak';
  TeeCommanMsg_ZoomLabel  :='Seret %s untuk zum';
  TeeCommanMsg_DepthLabel :='Seret %s untuk ubah saiz 3D';

  TeeCommanMsg_NormalLabel:='Seret butang kiri untuk Zum, kanan untuk larikan';
  TeeCommanMsg_NormalPieLabel:='Seret Hirisan Pai Untuk Terburaikan';

  TeeCommanMsg_PieExploding :='Hiris: %d Terburai: %d %%';

  TeeMsg_TriSurfaceLess        :='Jumlah titik mestilah >= 4';
  TeeMsg_TriSurfaceAllColinear :='Semua titik data segaris';
  TeeMsg_TriSurfaceSimilar     :='Titik serupa - tidak boleh lakukan';
  TeeMsg_GalleryTriSurface     :='Permukaan Segitiga';

  TeeMsg_AllSeries :='Semua Turutan';
  TeeMsg_Edit      :='Sunting';

  TeeMsg_GalleryFinancial    :='Kewangan';

  TeeMsg_CursorTool    :='Aksara';
  TeeMsg_DragMarksTool :='Seret Tanda';
  TeeMsg_AxisArrowTool :='Anak Panah Paksi';
  TeeMsg_DrawLineTool  :='Lukis Garis';
  TeeMsg_NearestTool   :='Titik Terdekat';
  TeeMsg_ColorBandTool :='Warna Jalur';
  TeeMsg_ColorLineTool :='Warna Garis';
  TeeMsg_RotateTool    :='Putar';
  TeeMsg_ImageTool     :='Imej';
  TeeMsg_MarksTipTool  :='Tip Tanda';
  TeeMsg_AnnotationTool:='Anotasi';

  TeeMsg_CantDeleteAncestor  :='Tidak boleh padam leluhur';

  TeeMsg_Load	          :='Muat...';
  TeeMsg_NoSeriesSelected :='Tiada turutan dipilih';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Carta';
  TeeMsg_CategorySeriesActions :='Carta Turutan';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Tukar 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktif';
  TeeMsg_ActionSeriesActiveHint := 'Tunjuk / Sembunyi Turutan';
  TeeMsg_ActionEditHint         := 'Sunting Carta';
  TeeMsg_ActionEdit             := 'S&unting...';
  TeeMsg_ActionCopyHint         := 'Salin ke papan keratan';
  TeeMsg_ActionCopy             := 'Sa&lin';
  TeeMsg_ActionPrintHint        := 'Cetak Carta Pratonton';
  TeeMsg_ActionPrint            := '&Cetak...';
  TeeMsg_ActionAxesHint         := 'Tunjuk / Sembunyi Paksi';
  TeeMsg_ActionAxes             := 'Pa&ksi';
  TeeMsg_ActionGridsHint        := 'Tunjuk / Sembunyi Grid';
  TeeMsg_ActionGrids            := '&Grid';
  TeeMsg_ActionLegendHint       := 'Tunjuk / Sembunyi Petunjuk';
  TeeMsg_ActionLegend           := '&Petunjuk';
  TeeMsg_ActionSeriesEditHint   := 'Sunting Turutan';
  TeeMsg_ActionSeriesMarksHint  := 'Tunjuk / Sembunyi Tanda Turutan';
  TeeMsg_ActionSeriesMarks      := '&Tanda';
  TeeMsg_ActionSaveHint         := 'Simpan Carta';
  TeeMsg_ActionSave             := '&Simpan...';

  TeeMsg_CandleBar              := 'Palang';
  TeeMsg_CandleNoOpen           := 'Tidak Dibuka';
  TeeMsg_CandleNoClose          := 'Tidak Ditutup';
  TeeMsg_NoLines                := 'Tiada Garisan';
  TeeMsg_NoHigh                 := 'Tiada Tinggi';
  TeeMsg_NoLow                  := 'Tiada Rendah';
  TeeMsg_ColorRange             := 'Julat Warna';
  TeeMsg_WireFrame              := 'Garis Bingkau';
  TeeMsg_DotFrame               := 'Bingkau Titik ';
  TeeMsg_Positions              := 'Posisi';
  TeeMsg_NoGrid                 := 'Tiada Grid';
  TeeMsg_NoPoint                := 'Tiada Titik';
  TeeMsg_NoLine                 := 'Tiada Garis';
  TeeMsg_Labels                 := 'Label';
  TeeMsg_NoCircle               := 'Tiada Bulatan';
  TeeMsg_Lines                  := 'Garisan';
  TeeMsg_Border                 := 'Sempadan';

  TeeMsg_SmithResistance      := 'Rintangan';
  TeeMsg_SmithReactance       := 'Kesan Balas';

  TeeMsg_Column               := 'Lajur';

  { 5.01 }
  TeeMsg_Separator            := 'Pembahagi';
  TeeMsg_FunnelSegment        := 'Tembereng ';
  TeeMsg_FunnelSeries         := 'Corong';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Terlebih Kuota';
  TeeMsg_FunnelWithin         := ' dalam kuota';
  TeeMsg_FunnelBelow          := ' atau lebih dibawah kuota';
  TeeMsg_CalendarSeries       := 'Kalendar';
  TeeMsg_DeltaPointSeries     := 'TitikDelta';
  TeeMsg_ImagePointSeries     := 'TitikImej';
  TeeMsg_ImageBarSeries       := 'PalangImej';
  TeeMsg_SeriesTextFieldZero  := 'TeksTurutan: Medan indeks mestilah lebih besar dari kosong.';

  { 5.02 }
  TeeMsg_Origin               := 'Asal';
  TeeMsg_Transparency         := 'Kelutsinaran';
  TeeMsg_Box		      := 'Kotak';
  TeeMsg_ExtrOut	      := 'KeluarLebih';
  TeeMsg_MildOut	      := 'KeluarSederhana';
  TeeMsg_PageNumber	      := 'Mukasurat';
  TeeMsg_TextFile             := 'Fail Teks';

  { 5.03 }
  TeeMsg_DragPoint            := 'Titik Seretan';
  TeeMsg_OpportunityValues    := 'NilaiKesempatan';
  TeeMsg_QuoteValues          := 'NilaiQuote';
end;

Procedure TeeCreateMalaysian;
begin
  if not Assigned(TeeMalaysianLanguage) then
  begin
    TeeMalaysianLanguage:=TStringList.Create;
    TeeMalaysianLanguage.Text:=

'LABELS=Label-label'+#13+
'DATASET=Set Data'+#13+
'ALL RIGHTS RESERVED.=Hak cipta terpelihara.'+#13+
'APPLY=Gunapakai'+#13+
'CLOSE=Tutup'+#13+
'OK=Baik'+#13+
'ABOUT TEECHART PRO V7.0=Tentang TeeChart Pro v7.0'+#13+
'OPTIONS=Pilihan'+#13+
'FORMAT=Format'+#13+
'TEXT=Teks'+#13+
'GRADIENT=Kecerunan'+#13+
'SHADOW=Bayang-bayang'+#13+
'POSITION=Kedudukan'+#13+
'LEFT=Kiri'+#13+
'TOP=Atas'+#13+
'CUSTOM=Ubahsuai'+#13+
'PEN=Pen'+#13+
'PATTERN=Corak'+#13+
'SIZE=Saiz'+#13+
'BEVEL=Siku'+#13+
'INVERTED=Dibalikkan'+#13+
'INVERTED SCROLL=Gulung dibalikkan'+#13+
'BORDER=Sempadan'+#13+
'ORIGIN=Asal'+#13+
'USE ORIGIN=Guna asal'+#13+
'AREA LINES=Garis-garis kawasan'+#13+
'AREA=Kawasan'+#13+
'COLOR=Warna'+#13+
'SERIES=Turutan'+#13+
'SUM=Jumlah'+#13+
'DAY=Hari'+#13+
'QUARTER=Perempat'+#13+
'(MAX)=(maks)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Dapat dilihat'+#13+
'CURSOR=Kursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Garis melintang'+#13+
'LABEL AND PERCENT=Label dan peratus'+#13+
'LABEL AND VALUE=Label dan nilai'+#13+
'LABEL & PERCENT TOTAL=Label dan jumlah peratus'+#13+
'PERCENT TOTAL=Jumlah peratus'+#13+
'MSEC.=msaat.'+#13+
'SUBTRACT=Tolak'+#13+
'MULTIPLY=Kali'+#13+
'DIVIDE=Bahagi'+#13+
'STAIRS=Tangga'+#13+
'MOMENTUM=Momentum'+#13+
'AVERAGE=Purata'+#13+
'XML=XML'+#13+
'HTML TABLE=Jadual HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Tiada'+#13+
'(NONE)=(Tiada)'#13+
'WIDTH=Lebar'+#13+
'HEIGHT=Tinggi'+#13+
'COLOR EACH=Warna Masing-Masing'+#13+
'STACK=Tindanan'+#13+
'STACKED=Tindan'+#13+
'STACKED 100%=Tindan 100%'+#13+
'AXIS=Paksi'+#13+
'LENGTH=Panjang'+#13+
'CANCEL=Batal'+#13+
'SCROLL=Gulung'+#13+
'INCREMENT=Penambahan'+#13+
'VALUE=Nilai'+#13+
'STYLE=Stail'+#13+
'JOIN=Gabung'+#13+
'AXIS INCREMENT=Penambahan paksi'+#13+
'AXIS MAXIMUM AND MINIMUM=Paksi Maksimum dan Minimum'+#13+
'% BAR WIDTH=% Lebar Bar'+#13+
'% BAR OFFSET=% Ofset Bar'+#13+
'BAR SIDE MARGINS=Garis sisi Bar'+#13+
'AUTO MARK POSITION=Penanda Posisi Automatik'+#13+
'DARK BAR 3D SIDES=Sisi Gelap Bar 3D'+#13+
'MONOCHROME=Ekawarna'+#13+
'COLORS=Warna-warna'+#13+
'DEFAULT=Pilihan standard'+#13+
'MEDIAN=Nilai tengah'+#13+
'IMAGE=Imej'+#13+
'DAYS=Hari-hari'+#13+
'WEEKDAYS=Hari minggu'+#13+
'TODAY=Hari ini'+#13+
'SUNDAY=Ahad'+#13+
'MONTHS=Bulan'+#13+
'LINES=Garis'+#13+
'UPPERCASE=Huruf besar'+#13+
'STICK=Batang'+#13+
'CANDLE WIDTH=Lebar lilin'+#13+
'BAR=Bar'+#13+
'OPEN CLOSE=Buka Tutup '+#13+
'DRAW 3D=Lukis 3D'+#13+
'DARK 3D=Gelap 3D'+#13+
'SHOW OPEN=Tunjuk Buka'+#13+
'SHOW CLOSE=Tunjuk Tutup'+#13+
'UP CLOSE=Atas Tutup'+#13+
'DOWN CLOSE=Bawah Tutup'+#13+
'CIRCLED=Dibulatkan'+#13+
'CIRCLE=Bulat'+#13+
'3 DIMENSIONS=3 Dimensi'+#13+
'ROTATION=Putaran'+#13+
'RADIUS=Radius'+#13+
'HOURS=Jam'+#13+
'HOUR=Jam'+#13+
'MINUTES=Minit'+#13+
'SECONDS=Saat'+#13+
'FONT=Fon'+#13+
'INSIDE=Didalam'+#13+
'ROTATED=Diputar'+#13+
'ROMAN=Roman'+#13+
'TRANSPARENCY=Transparensi'+#13+
'DRAW BEHIND=Lukis dibelakang'+#13+
'RANGE=Linkungan'+#13+
'PALETTE=Palet'+#13+
'STEPS=Langkah'+#13+
'GRID=Grid'+#13+
'GRID SIZE=Saiz grid'+#13+
'ALLOW DRAG=Seret dibenarkan'+#13+
'AUTOMATIC=Automatik'+#13+
'LEVEL=Tingkat'+#13+
'LEVELS POSITION=Posisi tingkat'+#13+
'SNAP=Sesuaikan'+#13+
'FOLLOW MOUSE=Ikut Mouse'+#13+
'TRANSPARENT=Lutsinar'+#13+
'ROUND FRAME=Bingkai bulat'+#13+
'FRAME=Bingkai'+#13+
'START=Mula'+#13+
'END=Akhir'+#13+
'MIDDLE=Tengah'+#13+
'NO MIDDLE=Tiada tengah'+#13+
'DIRECTION=Arah'+#13+
'DATASOURCE=Sumber data'+#13+
'AVAILABLE=Boleh didapati'+#13+
'SELECTED=Terpilih'+#13+
'CALC=Hitung'+#13+
'GROUP BY=Kumpul berdasarkan'+#13+
'OF=dari'+#13+
'HOLE %=Lubang %'+#13+
'RESET POSITIONS=Set kembali posisi'+#13+
'MOUSE BUTTON=Tombol Mouse'+#13+
'ENABLE DRAWING=Izinkan Lukisan'+#13+
'ENABLE SELECT=Izinkan Pilihan'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Sudut'+#13+
'ZOOM TEXT=Perbesarkan teks'+#13+
'PERSPECTIVE=Perspektif'+#13+
'ZOOM=Perbesar'+#13+
'ELEVATION=Peninggian'+#13+
'BEHIND=Belakang'+#13+
'AXES=Paksi-paksi'+#13+
'SCALES=Skala'+#13+
'TITLE=Tajuk'+#13+
'TICKS=Detik'+#13+
'MINOR=Kecil'+#13+
'CENTERED=Ditengahkan'+#13+
'CENTER=Tengah'+#13+
'PATTERN COLOR EDITOR=Penyunting Corak Warna'+#13+
'START VALUE=Nilai permulaan'+#13+
'END VALUE=Nilai akhir'+#13+
'COLOR MODE=Mode warna'+#13+
'LINE MODE=Mode garis'+#13+
'HEIGHT 3D=Tinggi 3D'+#13+
'OUTLINE=Garis luar'+#13+
'PRINT PREVIEW=Cetak Pratayang'+#13+
'ANIMATED=Animasi'+#13+
'ALLOW=Izin'+#13+
'DASH=Sengkang'+#13+
'DOT=Titik'+#13+
'DASH DOT DOT=Sengkang titik titik'+#13+
'PALE=Pucat'+#13+
'STRONG=Kuat'+#13+
'WIDTH UNITS=Unit lebar'+#13+
'FOOT=Kaki'+#13+
'SUBFOOT=Sub Kaki'+#13+
'SUBTITLE=Sari kata'+#13+
'LEGEND=Lagenda'+#13+
'COLON=Noktah bertindih'+#13+
'AXIS ORIGIN=Paksi asal'+#13+
'UNITS=Unit-unit'+#13+
'PYRAMID=Piramid'+#13+
'DIAMOND=Berlian'+#13+
'CUBE=Kiub'+#13+
'TRIANGLE=Segitiga'+#13+
'STAR=Bintang'+#13+
'SQUARE=Empat segi'+#13+
'DOWN TRIANGLE=Segitiga terbalik'+#13+
'SMALL DOT=Titik kecil'+#13+
'LOAD=Muat'+#13+
'FILE=Fail'+#13+
'RECTANGLE=Segi empat sama'+#13+
'HEADER=Bahagian depan'+#13+
'CLEAR=Bersihkan'+#13+
'ONE HOUR=Satu jam'+#13+
'ONE YEAR=Satu tahun'+#13+
'ELLIPSE=Elips'+#13+
'CONE=Kun'+#13+
'ARROW=Panah'+#13+
'CYLLINDER=Silinder'+#13+
'TIME=Waktu'+#13+
'BRUSH=Berus'+#13+
'LINE=Garis'+#13+
'VERTICAL LINE=Garis memanjang'+#13+
'AXIS ARROWS=Panah paksi'+#13+
'MARK TIPS=Tips penanda'+#13+
'DASH DOT=Titik sengkang'+#13+
'COLOR BAND=Pita warna'+#13+
'COLOR LINE=Garis warna'+#13+
'INVERT. TRIANGLE=Segitiga terbalik'+#13+
'INVERT. PYRAMID=Piramid terbalik'+#13+
'INVERTED PYRAMID=Piramid terbalik'+#13+
'SERIES DATASOURCE TEXT EDITOR=Penyunting Teks Turutan Sumberdata'+#13+
'SOLID=Kukuh'+#13+
'WIREFRAME=Bingkai dawai'+#13+
'DOTFRAME=Bingkai titik'+#13+
'SIDE BRUSH=Berus sisi '+#13+
'SIDE=Sisi'+#13+
'SIDE ALL=Semua sisi'+#13+
'ROTATE=Putar'+#13+
'SMOOTH PALETTE=Palet licin'+#13+
'CHART TOOLS GALLERY=Galeri Carta Alat'+#13+
'ADD=Tambah'+#13+
'BORDER EDITOR=Penyunting Batas'+#13+
'DRAWING MODE=Mode lukis'+#13+
'CLOSE CIRCLE=Tutup bulatan'+#13+
'PICTURE=Gambar'+#13+
'NATIVE=Asli'+#13+
'DATA=Data'+#13+
'KEEP ASPECT RATIO=Simpan nisbah aspek '+#13+
'COPY=Salin'+#13+
'SAVE=Simpan'+#13+
'SEND=Hantar'+#13+
'INCLUDE SERIES DATA=Termasuk turutan data'+#13+
'FILE SIZE=Saiz fail'+#13+
'INCLUDE=Termasuk'+#13+
'POINT INDEX=Indeks penunjuk'+#13+
'POINT LABELS=Label penunjuk'+#13+
'DELIMITER=Pembatasan'+#13+
'DEPTH=Kedalaman'+#13+
'COMPRESSION LEVEL=Tingkat mampatan'+#13+
'COMPRESSION=Mampatan'+#13+
'PATTERNS=Corak-corak'+#13+
'LABEL=Label'+#13+
'GROUP SLICES=Bahagian Kumpulan'+#13+
'EXPLODE BIGGEST=Lebarkan terbesar'+#13+
'TOTAL ANGLE=Jumlah sudut'+#13+
'HORIZ. SIZE=Saiz melintang'+#13+
'VERT. SIZE=Saiz memanjang'+#13+
'SHAPES=Bentuk-bentuk'+#13+
'INFLATE MARGINS=Kembungkan garis'+#13+
'QUALITY=Kualiti'+#13+
'SPEED=Kepantasan'+#13+
'% QUALITY=% kualiti'+#13+
'GRAY SCALE=Skala kelabu'+#13+
'PERFORMANCE=Prestasi'+#13+
'BROWSE=Melihat'+#13+
'TILED=Jubin'+#13+
'HIGH=Tinggi'+#13+
'LOW=Rendah'+#13+
'DATABASE CHART=Carta data induk'+#13+
'NON DATABASE CHART=Bukan carta data induk'+#13+
'HELP=Bantuan'+#13+
'NEXT >=Seterusnya >'+#13+
'< BACK=< Kembali'+#13+
'TEECHART WIZARD=TeeChart Bestari'+#13+
'PERCENT=Peratus'+#13+
'PIXELS=Piksel'+#13+
'ERROR WIDTH=Lebar kesilapan'+#13+
'ENHANCED=Tingkatkan'+#13+
'VISIBLE WALLS=Dinding terlihat'+#13+
'ACTIVE=Aktif'+#13+
'DELETE=Padam'+#13+
'ALIGNMENT=Penjajaran'+#13+
'ADJUST FRAME=Betulkan bingkai'+#13+
'HORIZONTAL=Melintang'+#13+
'VERTICAL=Memanjang'+#13+
'VERTICAL POSITION=Posisi memanjang'+#13+
'NUMBER=Nombor'+#13+
'LEVELS=Tingkat'+#13+
'OVERLAP=Bertindih'+#13+
'STACK 100%=Tindanan 100%'+#13+
'MOVE=Pindah'+#13+
'CLICK=Klik'+#13+
'DELAY=Tunda'+#13+
'DRAW LINE=Lukis garis'+#13+
'FUNCTIONS=Fungsi'+#13+
'SOURCE SERIES=Sumber turutan'+#13+
'ABOVE=Atas'+#13+
'BELOW=Bawah'+#13+
'Dif. Limit=Perbezaan had'+#13+
'WITHIN=Dalam'+#13+
'EXTENDED=Lanjutkan'+#13+
'STANDARD=Standard'+#13+
'STATS=Statistik'+#13+
'FINANCIAL=Kewangan'+#13+
'OTHER=Lain'+#13+
'TEECHART GALLERY=Galeri TeeChart'+#13+
'CONNECTING LINES=Menghubung garisan'+#13+
'REDUCTION=Pengurangan'+#13+
'LIGHT=Cahaya'+#13+
'INTENSITY=Intensiti'+#13+
'FONT OUTLINES=Garis fon'+#13+
'SMOOTH SHADING=Bayangan halus'+#13+
'AMBIENT LIGHT=Cahaya Sekeliling'+#13+
'MOUSE ACTION=Fungsi Mouse'+#13+
'CLOCKWISE=Arah jam'+#13+
'ANGLE INCREMENT=Kenaikan sudut'+#13+
'RADIUS INCREMENT=Kenaikan radius'+#13+
'PRINTER=Pencetak'+#13+
'SETUP=Pilihan'+#13+
'ORIENTATION=Orientasi'+#13+
'PORTRAIT=Memanjang'+#13+
'LANDSCAPE=Melintang'+#13+
'MARGINS (%)=Garisan (%)'+#13+
'MARGINS=Garisan'+#13+
'DETAIL=Terperinci'+#13+
'MORE=Lebih'+#13+
'PROPORTIONAL=Perkadaran'+#13+
'VIEW MARGINS=Lihat garisan'+#13+
'RESET MARGINS=Set kembali garisan'+#13+
'PRINT=Cetak'+#13+
'TEEPREVIEW EDITOR=Penyunting Tee pratayang'+#13+
'ALLOW MOVE=Izin bergerak'+#13+
'ALLOW RESIZE=Izin saiz baru'+#13+
'SHOW IMAGE=Tunjuk imej'+#13+
'DRAG IMAGE=Seret imej'+#13+
'AS BITMAP=Sebagai BITMAP'+#13+
'SIZE %=Saiz %'+#13+
'FIELDS=Ruang'+#13+
'SOURCE=Sumber'+#13+
'SEPARATOR=Pengasing'+#13+
'NUMBER OF HEADER LINES=Bilangan garis bahagian depan'+#13+
'COMMA=Koma'+#13+
'EDITING=Menyunting'+#13+
'TAB=Tab'+#13+
'SPACE=Sela'+#13+
'ROUND RECTANGLE=Segi empat sama kubah'+#13+
'BOTTOM=Bawah'+#13+
'RIGHT=Kanan'+#13+
'C PEN=C Pen'+#13+
'R PEN=R Pen'+#13+
'C LABELS=Label C'+#13+
'R LABELS=Label R'+#13+
'MULTIPLE BAR=Bar berganda'+#13+
'MULTIPLE AREAS=Kawasan berganda'+#13+
'STACK GROUP=Tindanan kumpulan'+#13+
'BOTH=Kedua-dua'+#13+
'BACK DIAGONAL=Diagonal dibalikkan'+#13+
'B.DIAGONAL=Diagonal diabilikkan'+#13+
'DIAG.CROSS=Silang diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Silang'+#13+
'DIAGONAL CROSS=Silang Diagonal'+#13+
'LEFT RIGHT=Kiri Kanan'+#13+
'RIGHT LEFT=Kanan Kiri'+#13+
'FROM CENTER=Dari tengah'+#13+
'FROM TOP LEFT=Dari atas kiri'+#13+
'FROM BOTTOM LEFT=Dari bawah kiri'+#13+
'SHOW WEEKDAYS=Tunjuk hari minggu'+#13+
'SHOW MONTHS=Tunjuk bulan'+#13+
'SHOW PREVIOUS BUTTON=Tunjuk tombol sebelumnya'#13+
'SHOW NEXT BUTTON=Tunjuk tombol seterusnya'#13+
'TRAILING DAYS=Hari-hari berikutnya'+#13+
'SHOW TODAY=Tunjuk hari ini'+#13+
'TRAILING=Berikutnya'+#13+
'LOWERED=Direndahkan'+#13+
'RAISED=Ditinggikan'+#13+
'HORIZ. OFFSET=Ofset melintang'+#13+
'VERT. OFFSET=Ofset memanjang'+#13+
'INNER=Dalam'+#13+
'LEN=Panjang'+#13+
'AT LABELS ONLY=Pada label sahaja'+#13+
'MAXIMUM=Maksimum'+#13+
'MINIMUM=Minimum'+#13+
'CHANGE=Tukar'+#13+
'LOGARITHMIC=Logaritma'+#13+
'LOG BASE=Log dasar'+#13+
'DESIRED INCREMENT=Kenaikan diingini'+#13+
'(INCREMENT)=(Kenaikan)'+#13+
'MULTI-LINE=Garis berganda'+#13+
'MULTI LINE=Garis berganda'+#13+
'RESIZE CHART=Saiz carta baru'+#13+
'X AND PERCENT=X dan peratus'+#13+
'X AND VALUE=X dan nilai'+#13+
'RIGHT PERCENT=Peratus kanan'+#13+
'LEFT PERCENT=Peratus kiri'+#13+
'LEFT VALUE=Nilai kiri'+#13+
'RIGHT VALUE=Nilai kanan'+#13+
'PLAIN=Mudah'+#13+
'LAST VALUES=Nilai terakhir'+#13+
'SERIES VALUES=Turutan nilai'+#13+
'SERIES NAMES=Turutan nama-nama'+#13+
'NEW=Baru'+#13+
'EDIT=Sunting'+#13+
'PANEL COLOR=Warna panel'+#13+
'TOP BOTTOM=Atas Bawah'+#13+
'BOTTOM TOP=Bawah Atas'+#13+
'DEFAULT ALIGNMENT=Penjajaran standard '+#13+
'EXPONENTIAL=Eksponen'+#13+
'LABELS FORMAT=Format Label'+#13+
'MIN. SEPARATION %=% Min. Pengasingan'+#13+
'YEAR=Tahun'+#13+
'MONTH=Bulan'+#13+
'WEEK=Minggu'+#13+
'WEEKDAY=Hari minggu'+#13+
'MARK=Tanda'+#13+
'ROUND FIRST=Bulat dahulu'+#13+
'LABEL ON AXIS=Label pada paksi'+#13+
'COUNT=Kira'+#13+
'POSITION %=Posisi %'+#13+
'START %=Mula %'+#13+
'END %=Akhir %'+#13+
'OTHER SIDE=Sisi lain'+#13+
'INTER-CHAR SPACING=Ruang antara huruf'+#13+
'VERT. SPACING=Ruang memanjang'+#13+
'POSITION OFFSET %=Posisi ofset %'+#13+
'GENERAL=Umum'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Gigih'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Penyunting TeeOpenGL'+#13+
'FONT 3D DEPTH=Kedalaman Fon 3D'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Penyunting TeeFon'+#13+
'CLIP POINTS=Titik memotong'+#13+
'CLIPPED=Dipotong'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Kira'+#13+
'QUANTIZE 256=Kira 256'+#13+
'DITHER=Kurangkan'+#13+
'VERTICAL SMALL=Memanjang kecil'+#13+
'HORIZ. SMALL=Melintang kecil'+#13+
'DIAG. SMALL=Diagonal kecil'+#13+
'BACK DIAG. SMALL=Diagonal kecil belakang'+#13+
'DIAG. CROSS SMALL=Silang diagonal kecil'+#13+
'MINIMUM PIXELS=Minimum piksel'+#13+
'ALLOW SCROLL=Izin Gulung'+#13+
'SWAP=Tukar'+#13+
'GRADIENT EDITOR=Penyunting kecerunan'+#13+
'TEXT STYLE=Stail teks'+#13+
'DIVIDING LINES=Garis membahagi'+#13+
'SYMBOLS=Simbol'+#13+
'CHECK BOXES=Kotak kontrol'+#13+
'FONT SERIES COLOR=Fon turutan warna'+#13+
'LEGEND STYLE=Stail lagenda'+#13+
'POINTS PER PAGE=Titik tiap mukasurat'+#13+
'SCALE LAST PAGE=Skala mukasurat akhir'+#13+
'CURRENT PAGE LEGEND=Lagenda mukasurat sekarang'+#13+
'BACKGROUND=Latar belakang'+#13+
'BACK IMAGE=Imej belakang'+#13+
'STRETCH=Lebarkan'+#13+
'TILE=Jubin'+#13+
'BORDERS=Sempadan'+#13+
'CALCULATE EVERY=Hitung tiap-tiap'+#13+
'NUMBER OF POINTS=Bilangan titik'+#13+
'RANGE OF VALUES=Lingkungan nilai'+#13+
'FIRST=Pertama'+#13+
'LAST=Akhir'+#13+
'ALL POINTS=Semua titik'+#13+
'DATA SOURCE=Sumber data'+#13+
'WALLS=Dinding'+#13+
'PAGING=Mukasurat'+#13+
'CLONE=Klon'+#13+
'TITLES=Tajuk'+#13+
'TOOLS=Alat-alat'+#13+
'EXPORT=Eksport'+#13+
'CHART=Carta'+#13+
'BACK=Kembali'+#13+
'LEFT AND RIGHT=Kiri dan kanan'+#13+
'SELECT A CHART STYLE=Pilih stail carta'+#13+
'SELECT A DATABASE TABLE=Pilih jadual data induk'+#13+
'TABLE=Jadual'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Pilih ruang diingini untuk dijadualkan'+#13+
'SELECT A TEXT LABELS FIELD=Pilih ruang label teks'+#13+
'CHOOSE THE DESIRED CHART TYPE=Pilih jenis carta diingini'+#13+
'CHART PREVIEW=Carta pratayang'+#13+
'SHOW LEGEND=Tunjuk lagenda'+#13+
'SHOW MARKS=Tunjuk tanda-tanda'+#13+
'FINISH=Habis'+#13+
'RANDOM=Rawak'+#13+
'DRAW EVERY=Lukis tiap-tiap'+#13+
'ARROWS=Panah'+#13+
'ASCENDING=Menaik'+#13+
'DESCENDING=Menurun'+#13+
'VERTICAL AXIS=Paksi memanjang'+#13+
'DATETIME=TarikhMasa'+#13+
'TOP AND BOTTOM=Atas dan bawah'+#13+
'HORIZONTAL AXIS=Paksi melintang'+#13+
'PERCENTS=Peratus'+#13+
'VALUES=Nilai'+#13+
'FORMATS=Format'+#13+
'SHOW IN LEGEND=Tunjuk dalam lagenda'+#13+
'SORT=Atur'+#13+
'MARKS=Tanda-tanda'+#13+
'BEVEL INNER=Siku dalam'+#13+
'BEVEL OUTER=Siku luar'+#13+
'PANEL EDITOR=Penyunting panel'+#13+
'CONTINUOUS=Bersambungan'+#13+
'HORIZ. ALIGNMENT=Penjajaran melintang'+#13+
'EXPORT CHART=Eksport carta'+#13+
'BELOW %=Bawah %'+#13+
'BELOW VALUE=Nilai bawah'+#13+
'NEAREST POINT=Titik terdekat'+#13+
'DRAG MARKS=Seret tanda-tanda'+#13+
'TEECHART PRINT PREVIEW=Pratayang cetak TeeChart'+#13+
'X VALUE=Nilai X'+#13+
'X AND Y VALUES=Nilai X dan Y'+#13+
'SHININESS=Kecerahan'+#13+
'ALL SERIES VISIBLE=Semua turutan terlihat'+#13+
'MARGIN=Garis'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Kiri Atas'+#13+
'LEFT BOTTOM=Kiri Bawah'+#13+
'RIGHT TOP=Kanan Atas'+#13+
'RIGHT BOTTOM=Kanan Bawah'+#13+
'EXACT DATE TIME=Tarikh Masa tepat'+#13+
'RECT. GRADIENT=Kecerunan segi empat sama'+#13+
'CROSS SMALL=Silang kecil'+#13+
'AVG=Purata'+#13+
'FUNCTION=Fungsi'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Satu milisaat'+#13+
'ONE SECOND=Satu saat'+#13+
'FIVE SECONDS=Lima saat'+#13+
'TEN SECONDS=Sepuluh saat'+#13+
'FIFTEEN SECONDS=Lima belas saat'+#13+
'THIRTY SECONDS=Tiga puluh saat'+#13+
'ONE MINUTE=Satu minit'+#13+
'FIVE MINUTES=Lima minit'+#13+
'TEN MINUTES=Sepuluh minit'+#13+
'FIFTEEN MINUTES=Lima belas minit'+#13+
'THIRTY MINUTES=Tiga puluh minit'+#13+
'TWO HOURS=Dua jam'+#13+
'TWO HOURS=Dua jam'+#13+
'SIX HOURS=Enam jam'+#13+
'TWELVE HOURS=Dua belas jam'+#13+
'ONE DAY=Satu hari'+#13+
'TWO DAYS=Dua hari'+#13+
'THREE DAYS=Diga hari'+#13+
'ONE WEEK=Satu minggu'+#13+
'HALF MONTH=Setengah bulan'+#13+
'ONE MONTH=Satu bulan'+#13+
'TWO MONTHS=Dua bulan'+#13+
'THREE MONTHS=Tiga bulan'+#13+
'FOUR MONTHS=Empat bulan'+#13+
'SIX MONTHS=Enam bulan'+#13+
'IRREGULAR=Tak malar'+#13+
'CLICKABLE=Boleh diklik'+#13+
'ROUND=Bulat'+#13+
'FLAT=Leper'+#13+
'PIE=Pai'+#13+
'HORIZ. BAR=Bar melintang'+#13+
'BUBBLE=Buih'+#13+
'SHAPE=Bentuk'+#13+
'POINT=Titik'+#13+                     
'FAST LINE=Garis Cepat'+#13+
'CANDLE=Lilin'+#13+
'VOLUME=Volum'+#13+
'HORIZ LINE=Garis melintang'+#13+
'SURFACE=Permukaan'+#13+
'LEFT AXIS=Paksi kiri'+#13+
'RIGHT AXIS=Paksi kanan'+#13+
'TOP AXIS=Paksi atas'+#13+
'BOTTOM AXIS=Paksi bawah'+#13+
'CHANGE SERIES TITLE=Tukar siri tajuk'+#13+
'DELETE %S ?=Padam %s ?'+#13+
'DESIRED %S INCREMENT=Kenaikan %s diingini'+#13+
'INCORRECT VALUE. REASON: %S=Nilai tidak betul. Sebab: %s'+#13+
'FillSampleValues NumValues must be > 0=PengisianNilaiContoh NomborNilai mestilah > 0.'+#13+
'VISIT OUR WEB SITE !=Kunjungi Website kami !'+#13+
'SHOW PAGE NUMBER=Tunjuk nombor mukasurat'+#13+
'PAGE NUMBER=Nombor mukasurat'+#13+
'PAGE %D OF %D=Mukasurat %d dari %d'+#13+
'TEECHART LANGUAGES=Bahasa-bahasa TeeChart'+#13+
'CHOOSE A LANGUAGE=Pilih satu bahasa'+#13+
'SELECT ALL=Pilih semua'+#13+
'MOVE UP=Pindah Keatas'+#13+
'MOVE DOWN=Pindah Kebawah'+#13+
'DRAW ALL=Lukis semua'+#13+
'TEXT FILE=Fail teks'+#13+
'IMAG. SYMBOL=Simbol imej'+#13+
'DRAG REPAINT=Seret cat kembali'+#13+
'NO LIMIT DRAG=Seretan tiada had'
;
  end;
end;

Procedure TeeSetMalaysian;
begin
  TeeCreateMalaysian;
  TeeLanguage:=TeeMalaysianLanguage;
  TeeMalaysianConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeMalaysianLanguage);
end.


