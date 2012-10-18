unit TeeIndonesian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeIndonesianLanguage:TStringList=nil;

Procedure TeeSetIndonesian;
Procedure TeeCreateIndonesian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeIndonesianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 by David Berneda';

  TeeMsg_Test               :='Test...';
  TeeMsg_LegendFirstValue   :='Nilai Legenda Pertama harus lebih besar dari 0';
  TeeMsg_LegendColorWidth   :='Lebar Warna Legenda harus lebih besar dari 0%';
  TeeMsg_SeriesSetDataSource:='Tidak ada ParentChart untuk memvalidasi Sumber Data';
  TeeMsg_SeriesInvDataSource:='Bukan Sumber Data yang valid: %s';
  TeeMsg_FillSample         :='PengisianNilaiSample Jumlah Nilai harus > 0';
  TeeMsg_AxisLogDateTime    :='Sumbu TanggalWaktu tidak boleh Logarithmic';
  TeeMsg_AxisLogNotPositive :='Nilai Sumbu Logarithmic Min and Mak harus >= 0';
  TeeMsg_AxisLabelSep       :='Pemisahan Label % harus lebih besar dari 0';
  TeeMsg_AxisIncrementNeg   :='Penambahan Sumbu harus >= 0';
  TeeMsg_AxisMinMax         :='Nilai Minimum Sumbu harus <= Maksimum';
  TeeMsg_AxisMaxMin         :='Nilai Maximum Sumbu harus >= Minimum';
  TeeMsg_AxisLogBase        :='Basis Sumbu Logaritmic harus >= 2';
  TeeMsg_MaxPointsPerPage   :='MaksTitikPerHalaman harus >= 0';
  TeeMsg_3dPercent          :='Persentase effect 3D harus ada diantara %d dan %d';
  TeeMsg_CircularSeries     :='Ketergantungan pada Seri Sirkular tidak diperbolehkan';
  TeeMsg_WarningHiColor     :='Warna 16k atau lebih besar diperlukan untuk mendapatkan tampilan lebih baik';

  TeeMsg_DefaultPercentOf   :='%s dari %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'dari %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Judul Sumbu';
  TeeMsg_AxisLabels         :='Judul Label';
  TeeMsg_RefreshInterval    :='Jeda Penyegaran harus ada diantara 0 dan 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart bukan saya sendiri!';
  TeeMsg_GalleryLine        :='Garis';
  TeeMsg_GalleryPoint       :='Titik';
  TeeMsg_GalleryArea        :='Wilayah';
  TeeMsg_GalleryBar         :='Batang';
  TeeMsg_GalleryHorizBar    :='Batang Mendatar';
  TeeMsg_Stack              :='Tumpukan';
  TeeMsg_GalleryPie         :='Kue Pie';
  TeeMsg_GalleryCircled     :='Lingkaran';
  TeeMsg_GalleryFastLine    :='Garis Cepat';
  TeeMsg_GalleryHorizLine   :='Garis Mendatar';

  TeeMsg_PieSample1         :='Mobil';
  TeeMsg_PieSample2         :='Telepon';
  TeeMsg_PieSample3         :='Meja';
  TeeMsg_PieSample4         :='Monitor';
  TeeMsg_PieSample5         :='Lampu';
  TeeMsg_PieSample6         :='Keyboard';
  TeeMsg_PieSample7         :='Sepeda';
  TeeMsg_PieSample8         :='Kursi';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Mengedit %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Lebih lanjut';
  TeeMsg_GalleryFunctions   :='Fungsi';

  TeeMsg_EditChart          :='E&dit Grafik...';
  TeeMsg_PrintPreview       :='Tampilan Sebelum &Pencetakan ...';
  TeeMsg_ExportChart        :='E&xport Grafik...';
  TeeMsg_CustomAxes         :='Sumbu Custom...';

  TeeMsg_InvalidEditorClass :='%s: Class Pengedit tidak valid: %s';
  TeeMsg_MissingEditorClass :='%s: tidak memiliki dialog pengedit';

  TeeMsg_GalleryArrow       :='Panah';

  TeeMsg_ExpFinish          :='&Beres';
  TeeMsg_ExpNext            :='&Berikut >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Desain';
  TeeMsg_GanttSample2       :='Perencanaan';
  TeeMsg_GanttSample3       :='Pengembangan';
  TeeMsg_GanttSample4       :='Penjualan';
  TeeMsg_GanttSample5       :='Pemasaran';
  TeeMsg_GanttSample6       :='Pengetesan';
  TeeMsg_GanttSample7       :='Pembuatan';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Versi Baru';
  TeeMsg_GanttSample10      :='Perbankan';

  TeeMsg_ChangeSeriesTitle  :='Merubah Judul Seri';
  TeeMsg_NewSeriesTitle     :='Judul Seri Baru:';
  TeeMsg_DateTime           :='TanggalWaktu';
  TeeMsg_TopAxis            :='Sumbu Atas';
  TeeMsg_BottomAxis         :='Sumbu Bawah';
  TeeMsg_LeftAxis           :='Sumbu Kiri';
  TeeMsg_RightAxis          :='Sumbu Kanan';

  TeeMsg_SureToDelete       :='Hapus %s ?';
  TeeMsg_DateTimeFormat     :='For&mat TanggalWaktu:';
  TeeMsg_Default            :='Default';
  TeeMsg_ValuesFormat       :='For&mat Nilai:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Penambahan %s Diharapkan';

  TeeMsg_IncorrectMaxMinValue:='Nilai tidak benar. Disebabkan: %s';
  TeeMsg_EnterDateTime      :='Masukkan [Jumlah Hari] [jj:mm:ss]';

  TeeMsg_SureToApply        :='Terapkan Perubahan ?';
  TeeMsg_SelectedSeries     :='(Seri-Seri Terpilih)';
  TeeMsg_RefreshData        :='&Penyegaran Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Tambah';
  TeeMsg_FunctionSubtract   :='Kurang';
  TeeMsg_FunctionMultiply   :='Kali';
  TeeMsg_FunctionDivide     :='Bagi';
  TeeMsg_FunctionHigh       :='Tinggi';
  TeeMsg_FunctionLow        :='Rendah';
  TeeMsg_FunctionAverage    :='Rata-Rata';

  TeeMsg_GalleryShape       :='Bentuk';
  TeeMsg_GalleryBubble      :='Gelembung';
  TeeMsg_FunctionNone       :='Gandakan';

  TeeMsg_None               :='(Tidak Ada)';

  TeeMsg_PrivateDeclarations:='{ Deklarasi Private }';
  TeeMsg_PublicDeclarations :='{ Declarasi Public }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Ukuran penunjuk harus lebih besar dari nol';
  TeeMsg_About              :='&Tentang...';

  tcAdditional              :='Penambahan';
  tcDControls               :='Pengendalian Data ';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Satu Rekord';
  TeeMsg_AskDataSource      :='&Sumber Data:';

  TeeMsg_Summary            :='Ikhtisar';

  TeeMsg_FunctionPeriod     :='Periode Fungsi harus >= 0';

  TeeMsg_WizardTab          :='Bisnis';
  TeeMsg_TeeChartWizard     :='TeeChart Wizard';

  TeeMsg_ClearImage         :='&Bersihkan';
  TeeMsg_BrowseImage        :='B&rowse...';

  TeeMsg_WizardSureToClose  :='Apakah anda yakin mau menutup TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Field %s tidak ada';

  TeeMsg_DepthAxis          :='Kedalaman Sumbu';
  TeeMsg_PieOther           :='Lainnya';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Kue Pie';
  TeeMsg_ValuesBar          :='Batang';
  TeeMsg_ValuesAngle        :='Sudut';
  TeeMsg_ValuesGanttStart   :='Awal';
  TeeMsg_ValuesGanttEnd     :='Akhir';
  TeeMsg_ValuesGanttNextTask:='TugasBerikut';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='AkhirX';
  TeeMsg_ValuesArrowEndY    :='AkhirY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Judul';
  TeeMsg_Foot               :='Footer';
  TeeMsg_Period		    :='Periode';
  TeeMsg_PeriodRange        :='Jangkauan Periode';
  TeeMsg_CalcPeriod         :='Hitung %s setiap:';
  TeeMsg_SmallDotsPen       :='Titik-Titik Kecil';

  TeeMsg_InvalidTeeFile     :='Chart Tidak Valid dalam file *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Kesalahan format file *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Kekosongan file *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Sumbu Chart';
  TeeMsg_ChartAxesCategoryDesc   := 'Property dan kejadian Sumbu Chart';
  TeeMsg_ChartWallsCategoryName  := 'Dinding Chart';
  TeeMsg_ChartWallsCategoryDesc  := 'Property dan kejadian Dinding-Dinding Chart';
  TeeMsg_ChartTitlesCategoryName := 'Judul Chart';
  TeeMsg_ChartTitlesCategoryDesc := 'Property dan kejadian Judul Chart';
  TeeMsg_Chart3DCategoryName     := 'Chart 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Property dan kejadian Chart 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Custom ';
  TeeMsg_Series                 :='Rangkaian';
  TeeMsg_SeriesList             :='Rangkaian...';

  TeeMsg_PageOfPages            :='Halaman %d dari %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Pertama';
  TeeMsg_Prior  :='Sebelumnya';
  TeeMsg_Next   :='Berikutnya';
  TeeMsg_Last   :='Terakhir';
  TeeMsg_Insert :='Sisip';
  TeeMsg_Delete :='Hapus';
  TeeMsg_Edit   :='Edit';
  TeeMsg_Post   :='Post';
  TeeMsg_Cancel :='Batal';

  TeeMsg_All    :='(semua)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Teks';

  TeeMsg_AsBMP        :='sebagai &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='sebagai &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Property panel tidak disat dalam format export';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Tanpa Garis Pembatas';
  TeeMsg_Dotted    :='Titik';
  TeeMsg_Colors    :='Warna';
  TeeMsg_Filled    :='Terisi';
  TeeMsg_Marks     :='Tanda';
  TeeMsg_Stairs    :='Tangga';
  TeeMsg_Points    :='Point';
  TeeMsg_Height    :='Tinggi';
  TeeMsg_Hollow    :='Lembah';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='Segitiga';
  TeeMsg_Star      :='Bintang';
  TeeMsg_Circle    :='Linkaran';
  TeeMsg_DownTri   :='Tri. Bawah';
  TeeMsg_Cross     :='Silang';
  TeeMsg_Diamond   :='Permata';
  TeeMsg_NoLines   :='Tanpa Garis';
  TeeMsg_Stack100  :='Tumpukan 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elips';
  TeeMsg_InvPyramid:='Pidamida dibalik';
  TeeMsg_Sides     :='Sisi-Sisi';
  TeeMsg_SideAll   :='Sisi Seluruhnya';
  TeeMsg_Patterns  :='Pola';
  TeeMsg_Exploded  :='Ledakan';
  TeeMsg_Shadow    :='Bayangan';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Persegi Panjang';
  TeeMsg_VertLine  :='Garis Vertikal';
  TeeMsg_HorizLine :='Garis Horisontal';
  TeeMsg_Line      :='Garis';
  TeeMsg_Cube      :='Kubus';
  TeeMsg_DiagCross :='Silang Diagonal';

  TeeMsg_CanNotFindTempPath    :='Tidak dapat menemukan folder temp';
  TeeMsg_CanNotCreateTempChart :='Tidak dapat membuat file Temp';
  TeeMsg_CanNotEmailChart      :='Tidak dapat mengemail TeeChart. Mapi Error: %d';

  TeeMsg_SeriesDelete :='Penghapusan Seri: IndekNilai %d diluar batas (0 s/d %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='sebagai &JPEG';
  TeeMsg_JPEGFilter    :='File JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='sebagai &GIF';
  TeeMsg_GIFFilter     :='File GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='sebagai &PNG';
  TeeMsg_PNGFilter     :='File PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='sebagai PC&X';
  TeeMsg_PCXFilter     :='File PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='sebagai &VML (HTM)';
  TeeMsg_VMLFilter     :='File VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Bahasa...';

  { 5.03 }
  TeeMsg_Gradient     :='Degradasi';
  TeeMsg_WantToSave   :='Apakah anda ingin menyimpan %s?';
  TeeMsg_NativeFilter :='File TeeChart '+TeeDefaultFilterExtension;

  TeeMsg_Property     :='Property';
  TeeMsg_Value        :='Nilai';
  TeeMsg_Yes          :='Ya';
  TeeMsg_No           :='Tidak';
  TeeMsg_Image        :='(gambar)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Kutub';
  TeeMsg_GalleryCandle      :='Lilin';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Permukaan';
  TeeMsg_GalleryContour     :='Garis Bentuk';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Point 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donat';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Batang 3D';
  TeeMsg_GalleryBigCandle   :='Lilin Besar';
  TeeMsg_GalleryLinePoint   :='Point Garis';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Air Terjun';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Jam';
  TeeMsg_GalleryColorGrid   :='GridWarna';
  TeeMsg_GalleryBoxPlot     :='KotakAlur';
  TeeMsg_GalleryHorizBoxPlot:='KotakAlurHoriz.';
  TeeMsg_GalleryBarJoin     :='Batang Gabungan';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Peta';

  TeeMsg_PolyDegreeRange    :='Derajat polinom harus diantara 1 dan 20';
  TeeMsg_AnswerVectorIndex   :='Indek jawaban Vector harus diantara 1 dan %d';
  TeeMsg_FittingError        :='Tidak dapat memproses fitting';
  TeeMsg_PeriodRange         :='Periode harus >= 0';
  TeeMsg_ExpAverageWeight    :='Lebar ExpRataRata harus diantara 0 dan 1';
  TeeMsg_GalleryErrorBar     :='Batang Error';
  TeeMsg_GalleryError        :='Error';
  TeeMsg_GalleryHighLow      :='Tinggi-Rendah';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Pembagian Momentum';
  TeeMsg_FunctionExpAverage  :='Exp. Rata-Rata';
  TeeMsg_FunctionMovingAverage:='Perpindahan Rata-Rata.';
  TeeMsg_FunctionExpMovAve   :='Exp.Perpindahan.Rata-Rata.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Fitting Kurva';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Cumulasi';
  TeeMsg_FunctionStdDeviation:='Penyimpangan Baku';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Akar Pangkat Dua';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Jumlah';
  TeeMsg_LoadChart           :='Buka TeeChart...';
  TeeMsg_SaveChart           :='Simpan TeeChart...';
  TeeMsg_TeeFiles            :='File TeeChart Pro';

  TeeMsg_GallerySamples      :='Lainnya';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Tidak dapat menemukan form pengedit rangkaian: %s';


  TeeMsg_CannotLoadChartFromURL:='Error code: %d pendownlodan Chart dari URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Error code: %d pendownloadan data rangkaian dari URL: %s';

  TeeMsg_ValuesDate          :='Tanggal';
  TeeMsg_ValuesOpen          :='Buka';
  TeeMsg_ValuesHigh          :='Tinggi';
  TeeMsg_ValuesLow           :='Rendah';
  TeeMsg_ValuesClose         :='Tutup';
  TeeMsg_ValuesOffset        :='Pergeseran';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Jumlah point Bezier harus > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Cetak';
  TeeCommanMsg_Copy     :='Copy';
  TeeCommanMsg_Save     :='Simpan';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotasi: %d° Derajat Ketinggian: %d°';
  TeeCommanMsg_Rotate   :='Putar';

  TeeCommanMsg_Moving   :='PergeseranHoriz.: %d PergeseranVert.: %d';
  TeeCommanMsg_Move     :='Pindah';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Kedalaman';

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Geser %s untuk memutar';
  TeeCommanMsg_MoveLabel  :='Geser %s untuk memindahkan';
  TeeCommanMsg_ZoomLabel  :='Geser %s untuk menzoom';
  TeeCommanMsg_DepthLabel :='Geser %s untuk merubah ukuran 3D';

  TeeCommanMsg_NormalLabel:='Geser tombol kiri untuk menzoom, Tombol kanan untuk menggulung';
  TeeCommanMsg_NormalPieLabel:='Geser sebuah Potongan Pie untuk meledakkannya';

  TeeCommanMsg_PieExploding :='Potongan: %d Terledakkan: %d %%';

  TeeMsg_TriSurfaceLess        :='Jumlah dari point harus >= 4';
  TeeMsg_TriSurfaceAllColinear :='Seluruh data point colinear';
  TeeMsg_TriSurfaceSimilar     :='Point serupa - tidak dapat dieksekusi';
  TeeMsg_GalleryTriSurface     :='Permukaan Segi Tiga';

  TeeMsg_AllSeries :='Seluruh Sumbu';
  TeeMsg_Edit      :='Edit';

  TeeMsg_GalleryFinancial    :='Keuangan';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Tanda Penggeser';
  TeeMsg_AxisArrowTool :='Panah Sumbu';
  TeeMsg_DrawLineTool  :='Garis Penggambar';
  TeeMsg_NearestTool   :='Point Terdekat';
  TeeMsg_ColorBandTool :='Pita Warna';
  TeeMsg_ColorLineTool :='Garis Warna';
  TeeMsg_RotateTool    :='Putar';
  TeeMsg_ImageTool     :='Gambar';
  TeeMsg_MarksTipTool  :='Tips Penandaan';
  TeeMsg_AnnotationTool:='Annotasi';

  TeeMsg_CantDeleteAncestor  :='Tidak dapat menghapus ancestor';

  TeeMsg_Load	          :='Muat...';
  TeeMsg_NoSeriesSelected :='Tidak ada rangkaian terpilih';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Rangkaian Chart';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Modus 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktiv';
  TeeMsg_ActionSeriesActiveHint := 'Tampilkan / Sembunyikan Rangkaian';
  TeeMsg_ActionEditHint         := 'Edit Chart';
  TeeMsg_ActionEdit             := '&Edit...';
  TeeMsg_ActionCopyHint         := 'Copy ke Clipboard';
  TeeMsg_ActionCopy             := '&Copy';
  TeeMsg_ActionPrintHint        := 'Preview Pencetakan Chart';
  TeeMsg_ActionPrint            := '&Cetak...';
  TeeMsg_ActionAxesHint         := 'Tampilkan / Sembunyikan Sumbu';
  TeeMsg_ActionAxes             := '&Sumbu';
  TeeMsg_ActionGridsHint        := 'Tampilkan / Sembunyikan Grids';
  TeeMsg_ActionGrids            := '&Grids';
  TeeMsg_ActionLegendHint       := 'Tampilkan / Sembunyikan Legenda';
  TeeMsg_ActionLegend           := '&Legenda';
  TeeMsg_ActionSeriesEditHint   := 'Edit Rangkaian';
  TeeMsg_ActionSeriesMarksHint  := 'Tampilkan / Sembunyikan Tanda Rangkaian';
  TeeMsg_ActionSeriesMarks      := '&Penandaan';
  TeeMsg_ActionSaveHint         := 'Simpan Chart';
  TeeMsg_ActionSave             := '&Simpan...';

  TeeMsg_CandleBar              := 'Batang';
  TeeMsg_CandleNoOpen           := 'Tanpa Terbuka';
  TeeMsg_CandleNoClose          := 'Tanpa Tertutup';
  TeeMsg_NoHigh                 := 'Tanpa Tinggi';
  TeeMsg_NoLow                  := 'Tanpa Rendah';
  TeeMsg_ColorRange             := 'Jangkauan Warna';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Bingkai Titik';
  TeeMsg_Positions              := 'Posisi';
  TeeMsg_NoGrid                 := 'Tanpa Grid';
  TeeMsg_NoPoint                := 'Tanpa Point';
  TeeMsg_NoLine                 := 'Tanpa Garis';
  TeeMsg_Labels                 := 'Label';
  TeeMsg_NoCircle               := 'Tanpa Lingkaran';
  TeeMsg_Lines                  := 'Garis-Garis';
  TeeMsg_Border                 := 'Pembatas';

  TeeMsg_SmithResistance      := 'Ketahanan';
  TeeMsg_SmithReactance       := 'Reactansi';

  TeeMsg_Column               := 'Kolom';

  { 5.01 }
  TeeMsg_Separator            := 'Pemisah';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Melebihi quota';
  TeeMsg_FunnelWithin         := ' didalam quota';
  TeeMsg_FunnelBelow          := ' atau lebih dibawah quota';
  TeeMsg_CalendarSeries       := 'Kalender';
  TeeMsg_DeltaPointSeries     := 'PerbedaanPoint';
  TeeMsg_ImagePointSeries     := 'PointGambar';
  TeeMsg_ImageBarSeries       := 'BatangBergambar';
  TeeMsg_SeriesTextFieldZero  := 'TeksRangkaian: Indeks Field harus lebih besar dari nol.';

  { 5.02 }
  TeeMsg_Origin               := 'Asal';
  TeeMsg_Transparency         := 'Ketransparanan';
  TeeMsg_Box		      := 'Kotak';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Nomor Halaman';
  TeeMsg_TextFile             := 'File Teks';

  { 5.03 }
  TeeMsg_DragPoint            := 'Point Pergeseran';
  TeeMsg_OpportunityValues    := 'NilaiKemungkinan';
  TeeMsg_QuoteValues          := 'NilaiQuote';

// TeeConst 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='ke &PDF'; 					//'as &PDF';
  TeeMsg_PDFFilter        :='File PDF (*.pdf)|*.pdf';			//'PDF files (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='ke PostScript';				//'as PostScript';
  TeeMsg_PSFilter         :='File PostScript (*.eps)|*.eps';		//'PostScript files (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Area'#13'Horisontal';			//'Horizontal'#13'Area';
  TeeMsg_SelfStack        :='Bertumpuk Tersendiri';			//'Self Stacked';
  TeeMsg_DarkPen          :='Bingkai Gelap';				//'Dark Border';
  TeeMsg_SelectFolder     :='Pilih folder database';			//'Select database folder';
  TeeMsg_BDEAlias         :='&Alias:';					//'&Alias:';
  TeeMsg_ADOConnection    :='&Koneksi';					//'&Connection:';

// TeeProCo 6.0

  TeeMsg_FunctionSmooth       :='Penghalusan';				//'Smoothing';
  TeeMsg_FunctionCross        :='Titik Silang';				//'Cross Points';
  TeeMsg_GridTranspose        :='Transposisi Grid 3D';			//'3D Grid Transpose';
  TeeMsg_FunctionCompress     :='Kompresi';				//'Compression';
  TeeMsg_ExtraLegendTool      :='Legenda Ekstra';			//'Extra Legend';
  TeeMsg_FunctionCLV          :='Lokasi Penutupan'#13'Nilai';		//'Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='Dalam Kesetimbangan'#13'Volume';	//'On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Komoditas'#13'Index Saluran';		//'Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';		//'Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animasi Rangkaian';			//'Series Animation';
  TeeMsg_GalleryPointFigure   :='Titik & Figur';			//'Point & Figure';
  TeeMsg_Up                   :='Atas';					//'Up';
  TeeMsg_Down                 :='Bawah';				//'Down';
  TeeMsg_GanttTool            :='Pergeseran Grantt';			//'Gantt Drag';
  TeeMsg_XMLFile              :='File XML';				//'XML file';
  TeeMsg_GridBandTool         :='Alat grid band';			//'Grid band tool';
  TeeMsg_FunctionPerf         :='Performansi';				//'Performance';
  TeeMsg_GalleryGauge         :='Katup';				//'Gauge';
  TeeMsg_GalleryGauges        :='Katup-katup';				//'Gauges';
  TeeMsg_ValuesVectorEndZ     :='AkhirZ';				//'EndZ';
  TeeMsg_GalleryVector3D      :='Vektor 3D';				//'Vector 3D';
  TeeMsg_Gallery3D            :='3D';					//'3D';
  TeeMsg_GalleryTower         :='Menara';				//'Tower';
  TeeMsg_SingleColor          :='satu Warna';				//'Single Color';
  TeeMsg_Cover                :='Penutup';				//'Cover';
  TeeMsg_Cone                 :='Corong';				//'Cone';
  TeeMsg_PieTool              :='Irisian Pie';				//'Pie Slices';
end;

Procedure TeeCreateIndonesian;
begin
  if not Assigned(TeeIndonesianLanguage) then
  begin
    TeeIndonesianLanguage:=TStringList.Create;
    TeeIndonesianLanguage.Text:=

'LABELS=Label'+#13+
'DATASET=Tabel'+#13+
'ALL RIGHTS RESERVED.=Semua telah terdaftar.'+#13+
'APPLY=Terapkan'+#13+
'CLOSE=Tutup'+#13+
'OK=Terima'+#13+
'ABOUT TEECHART PRO V7.0=Tentang TeeChart Pro v7.0'+#13+
'OPTIONS=Pilihan'+#13+
'FORMAT=Format'+#13+
'TEXT=Teks'+#13+
'GRADIENT=Degradasi'+#13+
'SHADOW=Bayangan'+#13+
'POSITION=Posisi'+#13+
'LEFT=Kiri'+#13+
'TOP=Atas'+#13+
'CUSTOM=Kebiasaan'+#13+
'PEN=Pena'+#13+
'PATTERN=Pola'+#13+
'SIZE=Ukuran'+#13+
'BEVEL=Siku'+#13+
'INVERTED=Dibalikkan'+#13+
'INVERTED SCROLL=Pembalikan Gulung'+#13+
'BORDER=Batas'+#13+
'ORIGIN=Asal'+#13+
'USE ORIGIN=Asal Penggunaan'+#13+
'AREA LINES=Garis Daerah'+#13+
'AREA=Daerah'+#13+
'COLOR=Warna'+#13+
'SERIES=Rentetan'+#13+
'SUM=Jumlah'+#13+
'DAY=Hari'+#13+
'QUARTER=Seperempat'+#13+
'(MAX)=(maks)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Terlihat'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Garis Horiz.'+#13+
'LABEL AND PERCENT=Label dan Persentase'+#13+
'LABEL AND VALUE=Label dan nilai y'+#13+
'LABEL AND PERCENT TOTAL=Label dan Total Persentase'+#13+
'PERCENT TOTAL=Total Persentase'+#13+
'MSEC.=mdet.'+#13+
'SUBTRACT=Kurang'+#13+
'MULTIPLY=Kali'+#13+
'DIVIDE=Bagi'+#13+
'STAIRS=Tangga'+#13+
'MOMENTUM=Momentum'+#13+
'AVERAGE=Rata-Rata'+#13+
'XML=XML'+#13+
'HTML TABLE=Tabel HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Tidak Ada'+#13+
'(NONE)=(Tidak Ada)'#13+
'WIDTH=Lebar'+#13+
'HEIGHT=Tinggi'+#13+
'COLOR EACH=Warna Masing'+#13+
'STACK=Tumpukan'+#13+
'STACKED=Tertumpuk'+#13+
'STACKED 100%=Tertumpuk 100%'+#13+
'AXIS=Sumbu'+#13+
'LENGTH=Panjang'+#13+
'CANCEL=Batal'+#13+
'SCROLL=Gulung'+#13+
'INCREMENT=Penambahan'+#13+
'VALUE=Nilai'+#13+
'STYLE=Gaya'+#13+
'JOIN=Gabungan'+#13+
'AXIS INCREMENT=Penambahan Sumbu'+#13+
'AXIS MAXIMUM AND MINIMUM=Maksimum dan Minimum Sumbu'+#13+
'% BAR WIDTH=% Lebar Batang'+#13+
'% BAR OFFSET=% Pergeseran Batang'+#13+
'BAR SIDE MARGINS=Garis tepi Sisi Batang'+#13+
'AUTO MARK POSITION=Penandaan Posisi Otomatis'+#13+
'DARK BAR 3D SIDES=Sisi Gelap Batang 3D'+#13+
'MONOCHROME=Hitam Putih'+#13+
'COLORS=warna-warna'+#13+
'DEFAULT=Default'+#13+
'MEDIAN=Nilai tengah'+#13+
'IMAGE=Gambar'+#13+
'DAYS=hari'+#13+
'WEEKDAYS=Hari kerja'+#13+
'TODAY=Hari ini'+#13+
'SUNDAY=Minggu'+#13+
'MONTHS=Bulan'+#13+
'LINES=Garis'+#13+
'UPPERCASE=Huruf besar'+#13+
'STICK=tongkat'+#13+
'CANDLE WIDTH=Lebar Lilin'+#13+
'BAR=Batang'+#13+
'OPEN CLOSE=Buka. Tutup'+#13+
'DRAW 3D=Digambar 3D'+#13+
'DARK 3D=Kegel. 3D'+#13+
'SHOW OPEN=Tampilkan Buka'+#13+
'SHOW CLOSE=Tampilkan Tutup'+#13+
'UP CLOSE=Tutup Atas'+#13+
'DOWN CLOSE=Tutup Bawah'+#13+
'CIRCLED=Dibulatkan'+#13+
'CIRCLE=Lingkaran'+#13+
'3 DIMENSIONS=3 Dimensi'+#13+
'ROTATION=Perputaran'+#13+
'RADIUS=Radius'+#13+
'HOURS=Jam'+#13+
'HOUR=Jam'+#13+
'MINUTES=Menit'+#13+
'SECONDS=Detik'+#13+
'FONT=Huruf'+#13+
'INSIDE=Didalam'+#13+
'ROTATED=Perputaran'+#13+
'ROMAN=Roman'+#13+
'TRANSPARENCY=Ketransparanan'+#13+
'DRAW BEHIND=Digambar Dibelakang'+#13+
'RANGE=Batasan'+#13+
'PALETTE=Palet'+#13+
'STEPS=Langkah'+#13+
'GRID=Grid'+#13+
'GRID SIZE=Ukuran Grid'+#13+
'ALLOW DRAG=Perges. Diperbolehkan'+#13+
'AUTOMATIC=Otomatis'+#13+
'LEVEL=Tingkatan'+#13+
'LEVELS POSITION=Posisi Tingkatan'+#13+
'SNAP=Dipaskan'+#13+
'FOLLOW MOUSE=Ikuti Mouse'+#13+
'TRANSPARENT=Transparant'+#13+
'ROUND FRAME=Bingkai Bundar'+#13+
'FRAME=Bingkai'+#13+
'START=Awal'+#13+
'END=Akhir'+#13+
'MIDDLE=Tengah'+#13+
'NO MIDDLE=Tidak Tengah'+#13+
'DIRECTION=Arah'+#13+
'DATASOURCE=Sumber Data'+#13+
'AVAILABLE=Tersedia'+#13+
'SELECTED=Terpilih'+#13+
'CALC=Hitung'+#13+
'GROUP BY=Grup Berdasarkan'+#13+
'OF=dari'+#13+
'HOLE %=Lubang %'+#13+
'RESET POSITIONS=Pengesetan kembali'+#13+
'MOUSE BUTTON=Tombol Mouse'+#13+
'ENABLE DRAWING=Ijinkan Penggambaran'+#13+
'ENABLE SELECT=Ijinkan Pemilihan'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Sudut'+#13+
'ZOOM TEXT=Perbesar Tulisan'+#13+
'PERSPECTIVE=Perspectiv'+#13+
'ZOOM=Perbesaran'+#13+
'ELEVATION=Peninggian'+#13+
'BEHIND=Belakang'+#13+
'AXES=Sumbu'+#13+
'SCALES=Skala'+#13+
'TITLE=Títel'+#13+
'TICKS=Detik'+#13+
'MINOR=Minor'+#13+
'CENTERED=Diketengahkan'+#13+
'CENTER=Tengah'+#13+
'PATTERN COLOR EDITOR=Pengedit Pola Warna'+#13+
'START VALUE=Nilai Awal'+#13+
'END VALUE=Nilai Akhir'+#13+
'COLOR MODE=Mode Warna'+#13+
'LINE MODE=Mode Garis'+#13+
'HEIGHT 3D=Tinggi 3D'+#13+
'OUTLINE=Garis luar'+#13+
'PRINT PREVIEW=Tampilan sebelum pencetakan'+#13+
'ANIMATED=Animasi'+#13+
'ALLOW=ijin'+#13+
'DASH=Strip'+#13+
'DOT=Titik'+#13+
'DASH DOT DOT=Strip titik titik'+#13+
'PALE=Pucat'+#13+
'STRONG=Kuat'+#13+
'WIDTH UNITS=Satuan Lebar'+#13+
'FOOT=Kaki'+#13+
'SUBFOOT=Sub Kaki'+#13+
'SUBTITLE=Sub Judul'+#13+
'LEGEND=Legenda'+#13+
'COLON=Titik dua'+#13+
'AXIS ORIGIN=Sumbu Asal'+#13+
'UNITS=Satuan'+#13+
'PYRAMID=Pirámida'+#13+
'DIAMOND=Berlian'+#13+
'CUBE=Kubus'+#13+
'TRIANGLE=Segitiga'+#13+
'STAR=Bintang'+#13+
'SQUARE=Bujur Sangkar'+#13+
'DOWN TRIANGLE=Segitiga bawah'+#13+
'SMALL DOT=Titil Kecil'+#13+
'LOAD=Muat'+#13+
'FILE=File'+#13+
'RECTANGLE=Persegi panjang'+#13+
'HEADER=Cabecera'+#13+
'CLEAR=Bersih'+#13+
'ONE HOUR=Satu Jam'+#13+
'ONE YEAR=Satu Tahun'+#13+
'ELLIPSE=Elips'+#13+
'CONE=Kerucut'+#13+
'ARROW=Panah'+#13+
'CYLLINDER=Silinder'+#13+
'TIME=Waktu'+#13+
'BRUSH=Kuas'+#13+
'LINE=Garis'+#13+
'VERTICAL LINE=Garis vertikal'+#13+
'AXIS ARROWS=Panah Sumbu'+#13+
'MARK TIPS=Tips Penandaan'+#13+
'DASH DOT=Titik Strip'+#13+
'COLOR BAND=Pita Warna'+#13+
'COLOR LINE=Garis Warna'+#13+
'INVERT. TRIANGLE=Pembalikan Segitiga'+#13+
'INVERT. PYRAMID=Pembalikan Piramida'+#13+
'INVERTED PYRAMID=Pembalikan Piramida'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Origen de Datos de Texto'+#13+
'SOLID=Solid'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=Puntos'+#13+
'SIDE BRUSH=Sisi Kuas'+#13+
'SIDE=Sisi'+#13+
'SIDE ALL=Semua Sisi'+#13+
'ROTATE=Putar'+#13+
'SMOOTH PALETTE=Palet Halus'+#13+
'CHART TOOLS GALLERY=Galería de Herramientas'+#13+
'ADD=Buat'+#13+
'BORDER EDITOR=Batas Pengeditan'+#13+
'DRAWING MODE=Mode Penggambaran'+#13+
'CLOSE CIRCLE=Tutup Lingkaran'+#13+
'PICTURE=Gambar'+#13+
'NATIVE=Nativo'+#13+
'DATA=Data'+#13+
'KEEP ASPECT RATIO=Mantener proporción'+#13+
'COPY=Salin'+#13+
'SAVE=Simpan'+#13+
'SEND=Kirim'+#13+
'INCLUDE SERIES DATA=Termasuk Rentetan Data '+#13+
'FILE SIZE=Ukuran File'+#13+
'INCLUDE=Termasuk'+#13+
'POINT INDEX=Indice de Puntos'+#13+
'POINT LABELS=Etiquetas de Puntos'+#13+
'DELIMITER=Pembatasan'+#13+
'DEPTH=Kedala.'+#13+
'COMPRESSION LEVEL=Tingkatan Kompresi'+#13+
'COMPRESSION=Kompresi'+#13+
'PATTERNS=Pola'+#13+
'LABEL=Label'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=Separar Porción'+#13+
'TOTAL ANGLE=Total Sudut'+#13+
'HORIZ. SIZE=Ukuran Horizontal'+#13+
'VERT. SIZE=Ukuran Vertikal'+#13+
'SHAPES=Bentuk'+#13+
'INFLATE MARGINS=Ampliar Márgenes'+#13+
'QUALITY=Kualitas'+#13+
'SPEED=Kecepatan'+#13+
'% QUALITY=% Kualitas'+#13+
'GRAY SCALE=Escala de Grises'+#13+
'PERFORMANCE=Penampilan'+#13+
'BROWSE=Melihat'+#13+
'TILED=Ubin'+#13+
'HIGH=Tinggi'+#13+
'LOW=Rendah'+#13+
'DATABASE CHART=Grafik Basis Data'+#13+
'NON DATABASE CHART=Tidak ada Grafik Basis data'+#13+
'HELP=Bantuan'+#13+
'NEXT >=Selanjutnya >'+#13+
'< BACK=< Kembali'+#13+
'TEECHART WIZARD=Asistente de TeeChart'+#13+
'PERCENT=Persen'+#13+
'PIXELS=Pixel'+#13+
'ERROR WIDTH=Lebar Error'+#13+
'ENHANCED=Meninggikan'+#13+
'VISIBLE WALLS=Dinding Terlihat'+#13+
'ACTIVE=Aktiv'+#13+
'DELETE=Hapus'+#13+
'ALIGNMENT=Penjajaran'+#13+
'ADJUST FRAME=Ajustar Marco'+#13+
'HORIZONTAL=Horisontal'+#13+
'VERTICAL=Vertikal'+#13+
'VERTICAL POSITION=Posisi Vertikal'+#13+
'NUMBER=Nomor'+#13+
'LEVELS=Tingkatan'+#13+
'OVERLAP=Sobreponer'+#13+
'STACK 100%=Tumpukan 100%'+#13+
'MOVE=Pindah'+#13+
'CLICK=Klik'+#13+
'DELAY=Tunda'+#13+
'DRAW LINE=Gambar Garis'+#13+
'FUNCTIONS=Fungsi'+#13+
'SOURCE SERIES=Rentetan Sumber'+#13+
'ABOVE=Atas'+#13+
'BELOW=Bawah'+#13+
'Dif. Limit=Límite Dif.'+#13+
'WITHIN=Dalam'+#13+
'EXTENDED=Perpanjangan'+#13+
'STANDARD=Standar'+#13+
'STATS=Estadística'+#13+
'FINANCIAL=Keuangan'+#13+
'OTHER=Lain-Lain'+#13+
'TEECHART GALLERY=Galería de Gráficos TeeChart'+#13+
'CONNECTING LINES=Líneas de Conexión'+#13+
'REDUCTION=Penurunan'+#13+
'LIGHT=Cahaya'+#13+
'INTENSITY=Intensitas'+#13+
'FONT OUTLINES=Borde Fuentes'+#13+
'SMOOTH SHADING=Bayangan Halus'+#13+
'AMBIENT LIGHT=Luz Ambiente'+#13+
'MOUSE ACTION=Acción del Ratón'+#13+
'CLOCKWISE=Segun horario'+#13+
'ANGLE INCREMENT=penambahan Sudut'+#13+
'RADIUS INCREMENT=Penambahan Radius'+#13+
'PRINTER=Pencetakan'+#13+
'SETUP=Susunan'+#13+
'ORIENTATION=Orientasi'+#13+
'PORTRAIT=Vertikal'+#13+
'LANDSCAPE=Horisontal'+#13+
'MARGINS (%)=Garis tepi (%)'+#13+
'MARGINS=Garis tepi'+#13+
'DETAIL=Detil'+#13+
'MORE=Lagi'+#13+
'PROPORTIONAL=Sebanding'+#13+
'VIEW MARGINS=Ver Márgenes'+#13+
'RESET MARGINS=Márg. Defecto'+#13+
'PRINT=Cetak'+#13+
'TEEPREVIEW EDITOR=Editor Impresión Preliminar'+#13+
'ALLOW MOVE=Perpindahan Diijinkan'+#13+
'ALLOW RESIZE=Permitir Redimensionar'+#13+
'SHOW IMAGE=Tampilkan Gambar'+#13+
'DRAG IMAGE=Pergeseran Gambar'+#13+
'AS BITMAP=Como mapa de bits'+#13+
'SIZE %=Ukuran %'+#13+
'FIELDS=Campos'+#13+
'SOURCE=Sumber'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=Líneas de cabecera'+#13+
'COMMA=Koma'+#13+
'EDITING=Pengeditan'+#13+
'TAB=Tabulación'+#13+
'SPACE=Espacio'+#13+
'ROUND RECTANGLE=Rectáng. Redondeado'+#13+
'BOTTOM=Bawah'+#13+
'RIGHT=Kanan'+#13+
'C PEN=Lápiz C'+#13+
'R PEN=Lápiz R'+#13+
'C LABELS=Label C'+#13+
'R LABELS=Label R'+#13+
'MULTIPLE BAR=Barras Múltiples'+#13+
'MULTIPLE AREAS=Areas Múltiples'+#13+
'STACK GROUP=Grupo de Apilado'+#13+
'BOTH=Keduanya'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Silang'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=Kiri Kanan'+#13+
'RIGHT LEFT=Kanan Kiri'+#13+
'FROM CENTER=Dari tengah-tengah'+#13+
'FROM TOP LEFT=Dari Kiri Atas'+#13+
'FROM BOTTOM LEFT=Dari Kiri Bawah'+#13+
'SHOW WEEKDAYS=Tampilkan Hari kerja'+#13+
'SHOW MONTHS=Tampilkan Bulan'+#13+
'SHOW PREVIOUS BUTTON=Tampilkan Tombol Sebelumnya'#13+
'SHOW NEXT BUTTON=Tampilkan Tombol Selanjutnya'#13+
'TRAILING DAYS=Ver otros Días'+#13+
'SHOW TODAY=Tampilkan Hari ini'+#13+
'TRAILING=Otros Días'+#13+
'LOWERED=Penurunan'+#13+
'RAISED=Kenaikan'+#13+
'HORIZ. OFFSET=Pergeseran Horisontal'+#13+
'VERT. OFFSET=Pergeseran Vertikal'+#13+
'INNER=Seb. dalam'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=Sólo en etiquetas'+#13+
'MAXIMUM=Maksimum'+#13+
'MINIMUM=Mínimum'+#13+
'CHANGE=Perubahan'+#13+
'LOGARITHMIC=Logarítma'+#13+
'LOG BASE=Basis Log.'+#13+
'DESIRED INCREMENT=Incremento'+#13+
'(INCREMENT)=(Incremento)'+#13+
'MULTI-LINE=Multi-Línea'+#13+
'MULTI LINE=Multilínea'+#13+
'RESIZE CHART=Grafik Kenaikan'+#13+
'X AND PERCENT=X Dan Persentase'+#13+
'X AND VALUE=X Dan Nilai'+#13+
'RIGHT PERCENT=Persentase kanan'+#13+
'LEFT PERCENT=Persentase kiri'+#13+
'LEFT VALUE=Nilai kiri'+#13+
'RIGHT VALUE=Nilai kanan'+#13+
'PLAIN=Texto'+#13+
'LAST VALUES=Ultimos Valores'+#13+
'SERIES VALUES=Rentetan Nilai'+#13+
'SERIES NAMES=Rentetan Nama'+#13+
'NEW=Baru'+#13+
'EDIT=Edit'+#13+
'PANEL COLOR=Papan warna'+#13+
'TOP BOTTOM=Atas Bawah'+#13+
'BOTTOM TOP=Bawah Atas'+#13+
'DEFAULT ALIGNMENT=Penjajaran default'+#13+
'EXPONENTIAL=Exponen'+#13+
'LABELS FORMAT=Format Label'+#13+
'MIN. SEPARATION %=Min. Separación %'+#13+
'YEAR=Tahun'+#13+
'MONTH=Bulan'+#13+
'WEEK=Mingguan'+#13+
'WEEKDAY=Hari Kerja'+#13+
'MARK=Tanda'+#13+
'ROUND FIRST=Redondear primera'+#13+
'LABEL ON AXIS=Etiqueta en eje'+#13+
'COUNT=Hitung'+#13+
'POSITION %=Posisi %'+#13+
'START %=Awal %'+#13+
'END %=Akhir %'+#13+
'OTHER SIDE=Sisi lain'+#13+
'INTER-CHAR SPACING=Espacio entre caracteres'+#13+
'VERT. SPACING=Espaciado Vertical'+#13+
'POSITION OFFSET %=Pergeseran posisi %'+#13+
'GENERAL=Umum'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=Papan'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Editor de OpenGL'+#13+
'FONT 3D DEPTH=Profund. Fuentes'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Editor de Fuente'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Sibuk'+#13+
'VERTICAL SMALL=Vertical Pequeño'+#13+
'HORIZ. SMALL=Horizontal Pequeño'+#13+
'DIAG. SMALL=Diagonal Pequeño'+#13+
'BACK DIAG. SMALL=Diagonal Invert. Peq.'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=Mínimos pixels'+#13+
'ALLOW SCROLL=Permitir Desplaz.'+#13+
'SWAP=Menukar'+#13+
'GRADIENT EDITOR=Editor de Gradiente'+#13+
'TEXT STYLE=Mode tulisan'+#13+
'DIVIDING LINES=Líneas de División'+#13+
'SYMBOLS=Símbol'+#13+
'CHECK BOXES=Cek box'+#13+
'FONT SERIES COLOR=Color de Series'+#13+
'LEGEND STYLE=Mode Legenda'+#13+
'POINTS PER PAGE=Puntos por página'+#13+
'SCALE LAST PAGE=Skala halaman terakhir'+#13+
'CURRENT PAGE LEGEND=Leyenda con página actual'+#13+
'BACKGROUND=Bakground'+#13+
'BACK IMAGE=Imagen fondo'+#13+
'STRETCH=Melebarkan'+#13+
'TILE=Mosaico'+#13+
'BORDERS=Batas'+#13+
'CALCULATE EVERY=Setiap perhitungan'+#13+
'NUMBER OF POINTS=Número de puntos'+#13+
'RANGE OF VALUES=Batasan dari nilai'+#13+
'FIRST=Pertama'+#13+
'LAST=Terakhir'+#13+
'ALL POINTS=Todos los puntos'+#13+
'DATA SOURCE=Origen de Datos'+#13+
'WALLS=Pared'+#13+
'PAGING=Página'+#13+
'CLONE=Duplicar'+#13+
'TITLES=Judul'+#13+
'TOOLS=Alat bantu'+#13+
'EXPORT=Ekspor'+#13+
'CHART=Grafik'+#13+
'BACK=Kembali'+#13+
'LEFT AND RIGHT=Kiri dan Kanan'+#13+
'SELECT A CHART STYLE=Pilih mode Grafik'+#13+
'SELECT A DATABASE TABLE=Pilih Tabel Database'+#13+
'TABLE=Tabel'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccione los campos a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Campo de etiquetas'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccione el tipo deseado'+#13+
'CHART PREVIEW=Visión Preliminar'+#13+
'SHOW LEGEND=Tamp. Legenda'+#13+
'SHOW MARKS=Tamp. Penandaan'+#13+
'FINISH=Selesai'+#13+
'RANDOM=Acak'+#13+
'DRAW EVERY=Setiap digambar'+#13+
'ARROWS=Panah'+#13+
'ASCENDING=Kenaikan'+#13+
'DESCENDING=Penurunan'+#13+
'VERTICAL AXIS=Sumbu Vertikal'+#13+
'DATETIME=Tanggal/Waktu'+#13+
'TOP AND BOTTOM=Atas dan Bawah'+#13+
'HORIZONTAL AXIS=Sumbu Horisontal'+#13+
'PERCENTS=Persentase'+#13+
'VALUES=Nilai'+#13+
'FORMATS=Format'+#13+
'SHOW IN LEGEND=Ver en Leyenda'+#13+
'SORT=Orden'+#13+
'MARKS=Tanda'+#13+
'BEVEL INNER=Siku dalam'+#13+
'BEVEL OUTER=Siku luar'+#13+
'PANEL EDITOR=Papan Pengeditan'+#13+
'CONTINUOUS=Bersambung'+#13+
'HORIZ. ALIGNMENT=Penjajaran Horisontal'+#13+
'EXPORT CHART=Grafik Ekspor'+#13+
'BELOW %=Bawah %'+#13+
'BELOW VALUE=Nilai Akhir'+#13+
'NEAREST POINT=Punto cercano'+#13+
'DRAG MARKS=Mover Marcas'+#13+
'TEECHART PRINT PREVIEW=Impresión Preliminar'+#13+
'X VALUE=Nilai X'+#13+
'X AND Y VALUES=Milai X dan Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Todas las Series Visible'+#13+
'MARGIN=Garis tepi'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Kiri Atas'+#13+
'LEFT BOTTOM=Kiri Bawah'+#13+
'RIGHT TOP=Kanan Atas'+#13+
'RIGHT BOTTOM=Kanan Bawah'+#13+
'EXACT DATE TIME=Tanggal/Waktu Sebenarnya'+#13+
'RECT. GRADIENT=Gradiente'+#13+
'CROSS SMALL=Cruz pequeña'+#13+
'AVG=Media'+#13+
'FUNCTION=Fungsi'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Satu milidetik'+#13+
'ONE SECOND=Satu detik'+#13+
'FIVE SECONDS=Satu detik'+#13+
'TEN SECONDS=Sepuluh detik'+#13+
'FIFTEEN SECONDS=Lima belas detik'+#13+
'THIRTY SECONDS=Tiga puluh detik'+#13+
'ONE MINUTE=Satu menit'+#13+
'FIVE MINUTES=Lima menit'+#13+
'TEN MINUTES=Sepuluh menit'+#13+
'FIFTEEN MINUTES=Lima belas menit'+#13+
'THIRTY MINUTES=Tiga puluh menit'+#13+
'TWO HOURS=Dua jam'+#13+
'TWO HOURS=Dua jam'+#13+
'SIX HOURS=Enam jam'+#13+
'TWELVE HOURS=Dua belas jam'+#13+
'ONE DAY=Satu hari'+#13+
'TWO DAYS=Dua hari'+#13+
'THREE DAYS=Tiga hari'+#13+
'ONE WEEK=Satu minggu'+#13+
'HALF MONTH=Setengah bulan'+#13+
'ONE MONTH=Satu bulan'+#13+
'TWO MONTHS=Dua bulan'+#13+
'THREE MONTHS=Tiga bulan'+#13+
'FOUR MONTHS=Empat bulan'+#13+
'SIX MONTHS=Enam bulan'+#13+
'IRREGULAR=Tidak biasanya'+#13+
'CLICKABLE=Dapat diclick'+#13+
'ROUND=Bulat'+#13+
'FLAT=Datar'+#13+
'PIE=Lingkaran'+#13+
'HORIZ. BAR=Batang Horisontal'+#13+
'BUBBLE=Gelembung'+#13+
'SHAPE=Bentuk'+#13+
'POINT=Titik'+#13+
'FAST LINE=Garis Cepat'+#13+
'CANDLE=Lilin'+#13+
'VOLUME=Volume'+#13+
'HORIZ LINE=Garis Horisontal'+#13+
'SURFACE=Permukaan'+#13+
'LEFT AXIS=Sumbu Kiri'+#13+
'RIGHT AXIS=Sumbu Kanan'+#13+
'TOP AXIS=Sumbu Atas'+#13+
'BOTTOM AXIS=Sumbu Bawah'+#13+
'CHANGE SERIES TITLE=Ganti Judul Rangkaian'+#13+
'DELETE %S ?=Hapus %s ?'+#13+
'DESIRED %S INCREMENT=Penambahan %s diinginkan'+#13+
'INCORRECT VALUE. REASON: %S=Nilai tidak benar. Dikarenakan: %s'+#13+
'FillSampleValues NumValues must be > 0=PenggisianNilaiSample Jumlah Nilai harus > 0.'#13+
'VISIT OUR WEB SITE !=Kunjungi Website kami !'#13+
'SHOW PAGE NUMBER=Tampilkan Nomor Halaman'#13+
'PAGE NUMBER=Nomor Halaman'#13+
'PAGE %D OF %D=Halaman %d dari %d'#13+
'TEECHART LANGUAGES=Bahasa-Bahasa TeeChart'#13+
'CHOOSE A LANGUAGE=Memili bahasa'+#13+
'SELECT ALL=Pilih Semua'#13+
'MOVE UP=Pindah Keatas'#13+
'MOVE DOWN=Pindah Kebawah'#13+
'DRAW ALL=Semua digambar'#13+
'TEXT FILE=File Tulisan'#13+
'IMAG. SYMBOL=Símbol Gambar'#13+
'DRAG REPAINT=Mencat kembali pergeseran'#13+
'NO LIMIT DRAG=Pergeseran tanpa batas'#13+

// 6.0

'BEVEL SIZE=Ukuran Bevel'#13+
'DELETE ROW=Hapus baris'#13+
'VOLUME SERIES=Rangkaian Volume'#13+
'SINGLE=Satuan'#13+
'REMOVE CUSTOM COLORS=Hapus kustomisasi warna'#13+
'USE PALETTE MINIMUM=Gunakan minimum palette'#13+
'AXIS MAXIMUM=Sumbu maksimum'#13+
'AXIS CENTER=Sumbu tengah'#13+
'AXIS MINIMUM=Sumbu minimum'#13+
'DAILY (NONE)=Harian (Tidak ada)'#13+
'WEEKLY=Mingguan'#13+
'MONTHLY=Bulanan'#13+
'BI-MONTHLY=Dua-bulanan'#13+
'QUARTERLY=Caturwulanan'#13+
'YEARLY=Tahunan'#13+
'DATETIME PERIOD=Periode waktu'#13+
'CASE SENSITIVE=Huruf sensitif'#13+
'DRAG STYLE=Gaya pergeseran'#13+
'SQUARED=Akar'#13+
'GRID 3D SERIES=Rangkaian grid 3D'#13+
'DARK BORDER=Bingkai gelap'#13+
'PIE SERIES=Rangkaian pie'#13+
'FOCUS=Pemusatan'#13+
'EXPLODE=Ledakan'#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Chart dari pola (*.tee file)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Buka file pola TeeChart dari'#13+
'BINARY=Biner'#13+
'VOLUME OSCILLATOR=Volume Oscillator'#13+
'PIE SLICES=Irisan Pie'#13+
'ARROW WIDTH=Lebar panah'#13+
'ARROW HEIGHT=Tinggi panah'#13+
'DEFAULT COLOR=Warna default'
;
  end;
end;

Procedure TeeSetIndonesian;
begin
  TeeCreateIndonesian;
  TeeLanguage:=TeeIndonesianLanguage;
  TeeIndonesianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeIndonesianLanguage);
end.
