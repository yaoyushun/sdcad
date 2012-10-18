unit TeeJapanese;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeJapaneseLanguage:TStringList=nil;

Procedure TeeSetJapanese;
Procedure TeeCreateJapanese;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeJapaneseConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='(C) 1997-2004 by David Berneda';
  TeeMsg_LegendFirstValue   :='最初の凡例の値は0より大きくなければなりません。';
  TeeMsg_LegendColorWidth   :='凡例の色の幅は0%より大きくなければなりません。';
  TeeMsg_SeriesSetDataSource:='有効なデータソースのParentChartがありません。';
  TeeMsg_SeriesInvDataSource:='無効なデータソース: %s';
  TeeMsg_FillSample         :='FillSampleValuesの値は0より大きくなければなりません。';
  TeeMsg_AxisLogDateTime    :='日付時間軸を対数軸にすることはできません。';
  TeeMsg_AxisLogNotPositive :='対数軸の最小値と最大値は0以上でなければなりません。';
  TeeMsg_AxisLabelSep       :='軸ラベル間の距離の割合(%)は0より大きくなければなりません。';
  TeeMsg_AxisIncrementNeg   :='軸の増加量は0以上でなければなりません。';
  TeeMsg_AxisMinMax         :='軸の最小値は最大値以下でなければなりません。';
  TeeMsg_AxisMaxMin         :='軸の最大値は最小値以上でなければなりません。';
  TeeMsg_AxisLogBase        :='対数軸の基数は2以上にしてください。';
  TeeMsg_MaxPointsPerPage   :='1ページあたりの最大ポイント数は0より大きくしてください。';
  TeeMsg_3dPercent          :='3Dのパーセントは %d から %d の間にしてください。';
  TeeMsg_CircularSeries     :='円系列の依存は許されません。';
  TeeMsg_WarningHiColor     :='表示色数は16k色もしくはそれ以上を推奨いたします。';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';

  TeeMsg_AxisTitle          :='軸のタイトル';
  TeeMsg_AxisLabels         :='軸のラベル';
  TeeMsg_RefreshInterval    :='更新間隔は0から60の間でなければなりません。';
  TeeMsg_SeriesParentNoSelf :='系列のParentChartは「Self」ではありません！';
  TeeMsg_GalleryLine        :='リボン';
  TeeMsg_GalleryPoint       :='散布図';
  TeeMsg_GalleryArea        :='面';
  TeeMsg_GalleryBar         :='縦棒';
  TeeMsg_GalleryHorizBar    :='横棒';
  TeeMsg_GalleryPie         :='円';
  TeeMsg_GalleryCircled     :='円';
  TeeMsg_GalleryFastLine    :='折れ線';
  TeeMsg_GalleryHorizLine   :='横リボン';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='ＭＳ Ｐゴシック';
  TeeMsg_Editing            :='%s の編集';

  TeeMsg_GalleryStandard    :='標準';
  TeeMsg_GalleryExtended    :='拡張';
  TeeMsg_GalleryFunctions   :='関数';

  TeeMsg_EditChart          :='チャートの編集(&D)...';
  TeeMsg_PrintPreview       :='印刷プレビュー(&P)...';
  TeeMsg_ExportChart        :='チャートのエクスポート(&X)...';
  TeeMsg_CustomAxes         :='カスタム軸...';

  TeeMsg_InvalidEditorClass :='%s: 無効なエディタクラス: %s';
  TeeMsg_MissingEditorClass :='%s: エディタダイアログがありません。';

  TeeMsg_GalleryArrow       :='矢印';

  TeeMsg_ExpFinish          :='完了(&F)';
  TeeMsg_ExpNext            :='次へ(&N) >';

  TeeMsg_GalleryGantt       :='ガント';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Development';
  TeeMsg_GanttSample4       :='Sales';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='New Version';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='系列のタイトルを変更する';
  TeeMsg_NewSeriesTitle     :='系列の新しいタイトル:';
  TeeMsg_DateTime           :='日付と時間';
  TeeMsg_TopAxis            :='上軸';
  TeeMsg_BottomAxis         :='下軸';
  TeeMsg_LeftAxis           :='左軸';
  TeeMsg_RightAxis          :='右軸';

  TeeMsg_SureToDelete       :='%s を削除しますか？';
  TeeMsg_DateTimeFormat     :='日付時間書式(&M):';
  TeeMsg_Default            :='デフォルト';
  TeeMsg_ValuesFormat       :='値の書式(&M):';
  TeeMsg_Maximum            :='最大';
  TeeMsg_Minimum            :='最小';
  TeeMsg_DesiredIncrement   :='要望増加量 %s';

  TeeMsg_IncorrectMaxMinValue:='正しくない値の理由: %s';
  TeeMsg_EnterDateTime      :='入力 [日数] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='変更を適用しますか？';
  TeeMsg_SelectedSeries     :='(選択された系列)';
  TeeMsg_RefreshData        :='データの更新(&R)';

  TeeMsg_DefaultFontSize    :='9';
  TeeMsg_DefaultEditorSize  :='439';
  TeeMsg_DefaultEditorHeight:='439';

  TeeMsg_FunctionAdd        :='和';
  TeeMsg_FunctionSubtract   :='差分';
  TeeMsg_FunctionMultiply   :='積';
  TeeMsg_FunctionDivide     :='商';
  TeeMsg_FunctionHigh       :='最大';
  TeeMsg_FunctionLow        :='最小';
  TeeMsg_FunctionAverage    :='平均値';

  TeeMsg_GalleryShape       :='シェープ';
  TeeMsg_GalleryBubble      :='泡';
  TeeMsg_FunctionNone       :='コピー';

  TeeMsg_None               :='(なし)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :='ＭＳ Ｐゴシック';

  TeeMsg_CheckPointerSize   :='ポインターのサイズは0より大きくしてください。';
  TeeMsg_About              :='バージョン情報(&A)...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='データセット';
  TeeMsg_AskDataSet         :='ﾃﾞｰﾀｾｯﾄ(&D):';

  TeeMsg_SingleRecord       :='単一レコード';
  TeeMsg_AskDataSource      :='ﾃﾞｰﾀｿｰｽ(&D):';

  TeeMsg_Summary            :='サマリー';

  TeeMsg_FunctionPeriod     :='関数のピリオドは0以上にしてください。';

  TeeMsg_TeeChartWizard     :='TeeChart ウィザード';
  TeeMsg_WizardTab          :='業務';

  TeeMsg_ClearImage         :='クリア(&R)';
  TeeMsg_BrowseImage        :='参照(&R)...';

  TeeMsg_WizardSureToClose  :='TeeChart ウィザードを終了してもよろしいですか？';
  TeeMsg_FieldNotFound      :='フィールド %s が存在しません。';

  TeeMsg_DepthAxis          :='奥軸';
  TeeMsg_PieOther           :='その他';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='円';
  TeeMsg_ValuesBar          :='棒';
  TeeMsg_ValuesAngle        :='角度';
  TeeMsg_ValuesGanttStart   :='開始';
  TeeMsg_ValuesGanttEnd     :='最後';
  TeeMsg_ValuesGanttNextTask:='次のﾀｽｸ';
  TeeMsg_ValuesBubbleRadius :='半径';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='凡例';
  TeeMsg_Title              :='タイトル';
  TeeMsg_Foot               :='フッター';
  TeeMsg_Period             :='ピリオドの範囲';
  TeeMsg_PeriodRange        :='ピリオドの範囲';
  TeeMsg_CalcPeriod         :='全ての %s を計算:';
  TeeMsg_SmallDotsPen       :='小さな点';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' ファイルのチャートは無効です。';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' ファイルの形式が間違っています。';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'チャートの軸';
  TeeMsg_ChartAxesCategoryDesc   := 'チャートの軸のプロパティとイベント';
  TeeMsg_ChartWallsCategoryName  := 'チャートの壁';
  TeeMsg_ChartWallsCategoryDesc  := 'チャートの壁のプロパティとイベント';
  TeeMsg_ChartTitlesCategoryName := 'チャートのタイトル';
  TeeMsg_ChartTitlesCategoryDesc := 'チャートのタイトルのプロパティとイベント';
  TeeMsg_Chart3DCategoryName     := 'チャートの3D';
  TeeMsg_Chart3DCategoryDesc     := 'チャートの3Dのプロパティとイベント';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       := 'カスタム';
  TeeMsg_Series                 := '系列';
  TeeMsg_SeriesList             := '系列...';

  TeeMsg_PageOfPages            := 'ページ %d / %d';
  TeeMsg_FileSize               := '%d バイト';

  TeeMsg_First  := '先頭';
  TeeMsg_Prior  := '前へ';
  TeeMsg_Next   := '次へ';
  TeeMsg_Last   := '末尾';
  TeeMsg_Insert := '挿入';
  TeeMsg_Delete := '削除';
  TeeMsg_Edit   := '編集';
  TeeMsg_Post   := '登録';
  TeeMsg_Cancel := 'キャンセル';

  TeeMsg_All    := '(全て)';
  TeeMsg_Index  := 'インデックス';
  TeeMsg_Text   := 'テキスト';

  TeeMsg_AsBMP        :='ビットマップ(&B)';
  TeeMsg_BMPFilter    :='ビットマップ (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='メタファイル(&M)';
  TeeMsg_EMFFilter    :='拡張メタファイル (*.emf)|*.emf|メタファイル (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'パネルのプロパティがエクスポート形式に設定されていません。';

  TeeMsg_Normal    := '標準';
  TeeMsg_NoBorder  := '枠なし';
  TeeMsg_Dotted    := '点線';
  TeeMsg_Colors    := '色分け';
  TeeMsg_Filled    := '塗り潰し';
  TeeMsg_Marks     := 'マーカ付';
  TeeMsg_Stairs    := '階段';
  TeeMsg_Points    := 'ポイント';
  TeeMsg_Height    := '3D高さ';
  TeeMsg_Hollow    := '中抜き';
  TeeMsg_Point2D   := '2Dポイント';
  TeeMsg_Triangle  := '三角形';
  TeeMsg_Star      := '星';
  TeeMsg_Circle    := '円';
  TeeMsg_DownTri   := '倒立三角形';
  TeeMsg_Cross     := '交差線';
  TeeMsg_Diamond   := '菱形';
  TeeMsg_NoLines   := '線なし';
  TeeMsg_Stack     := '積み重ね';
  TeeMsg_Stack100  := '百分率';
  TeeMsg_Pyramid   := '四角錐';
  TeeMsg_Ellipse   := '楕円';
  TeeMsg_InvPyramid:= '倒立四角錐';
  TeeMsg_Sides     := '併置';
  TeeMsg_SideAll   := '並列 系列毎';
  TeeMsg_Patterns  := 'パターン';
  TeeMsg_Exploded  := '最大分割';
  TeeMsg_Shadow    := '影';
  TeeMsg_SemiPie   := '半円';
  TeeMsg_Rectangle := '長方形';
  TeeMsg_VertLine  := '垂直線';
  TeeMsg_HorizLine := '水平線';
  TeeMsg_Line      := '直線';
  TeeMsg_Cube      := '立方体';
  TeeMsg_DiagCross := '斜め交差線';

  TeeMsg_CanNotFindTempPath    := 'テンポラリフォルダが見つかりません';
  TeeMsg_CanNotCreateTempChart := 'テンポラリファイルが作成できません';
  TeeMsg_CanNotEmailChart      := 'チャートをメールで送信できません。 Mapi エラー: %d';

  TeeMsg_SeriesDelete := '系列の削除: ValueIndex %d が範囲外 (0 ～ %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='言語(&L)...';

  { 5.03 }
  TeeMsg_Gradient := 'ｸﾞﾗﾃﾞｰｼｮﾝ';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='極';
  TeeMsg_GalleryCandle      :='キャンドル';
  TeeMsg_GalleryVolume      :='ボリューム';
  TeeMsg_GallerySurface     :='サーフェス';
  TeeMsg_GalleryContour     :='等高線';
  TeeMsg_GalleryBezier      :='ベジェ';
  TeeMsg_GalleryPoint3D     :='3D 散布';
  TeeMsg_GalleryRadar       :='レーダー';
  TeeMsg_GalleryDonut       :='ドーナツ';
  TeeMsg_GalleryCursor      :='カーソル';
  TeeMsg_GalleryBar3D       :='3D バー';
  TeeMsg_GalleryBigCandle   :='ﾋﾞｯｸﾞｷｬﾝﾄﾞﾙ';
  TeeMsg_GalleryLinePoint   :='ﾗｲﾝﾎﾟｲﾝﾄ';
  TeeMsg_GalleryHistogram   :='ヒストグラム';
  TeeMsg_GalleryWaterFall   :='ｳｫｰﾀｰﾌｫｰﾙ';
  TeeMsg_GalleryWindRose    :='風向図';
  TeeMsg_GalleryClock       :='時計';
  TeeMsg_GalleryColorGrid   :='ｶﾗｰｸﾞﾘｯﾄﾞ';
  TeeMsg_GalleryBoxPlot     :='縦ﾎﾞｯｸｽﾌﾟﾛｯﾄ';
  TeeMsg_GalleryHorizBoxPlot:='横ﾎﾞｯｸｽﾌﾟﾛｯﾄ';
  TeeMsg_GalleryBarJoin     :='バー ジョイン';
  TeeMsg_GallerySmith       :='スミス';
  TeeMsg_GalleryPyramid     :='ピラミッド';
  TeeMsg_GalleryMap         :='マップ';

  TeeMsg_PolyDegreeRange     :='多項式の次数は 1 から 20 の間にしてください。';
  TeeMsg_AnswerVectorIndex   :='AnswerVectorプロパティのインデックス値は 1 から %d の間にしてください。';
  TeeMsg_FittingError        :='補間を処理できません。';
  TeeMsg_PeriodRange         :='ピリオドは0以上に設定してください。';
  TeeMsg_ExpAverageWeight    :='指数平均値の重みは0か1に設定してください。';
  TeeMsg_GalleryErrorBar     :='エラーバー';
  TeeMsg_GalleryError        :='エラー';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='運動量';
  TeeMsg_FunctionMomentumDiv :='商運動量';
  TeeMsg_FunctionExpAverage  :='指数平均値';
  TeeMsg_FunctionMovingAverage:='移動平均値';
  TeeMsg_FunctionExpMovAve   :='指数移動平均値';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='系列組み合わせ';
  TeeMsg_FunctionTrend       :='トレンド';
  TeeMsg_FunctionExpTrend    :='指数トレンド';
  TeeMsg_FunctionLogTrend    :='対数トレンド';
  TeeMsg_FunctionCumulative  :='累積';
  TeeMsg_FunctionStdDeviation:='標準偏差';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='誤差の2乗';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='確率';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='計算';
  TeeMsg_LoadChart           :='TeeChartを開く...';
  TeeMsg_SaveChart           :='TeeChartを保存...';
  TeeMsg_TeeFiles            :='TeeChart Pro ファイル';

  TeeMsg_GallerySamples      :='その他';
  TeeMsg_GalleryStats        :='統計';

  TeeMsg_CannotFindEditor    :='系列を編集するフォーム %s が見つかりません。';


  TeeMsg_CannotLoadChartFromURL:='エラーコード: %d URL: %s からチャートをダウンロードしています。';
  TeeMsg_CannotLoadSeriesDataFromURL:='エラーコード: %d URL: %s から系列のデータをダウンロードしています。';

  TeeMsg_Test                :='テスト...';

  TeeMsg_ValuesDate          :='日付';
  TeeMsg_ValuesOpen          :='始値';
  TeeMsg_ValuesHigh          :='高値';
  TeeMsg_ValuesLow           :='安値';
  TeeMsg_ValuesClose         :='終値';
  TeeMsg_ValuesOffset        :='ｵﾌｾｯﾄ';
  TeeMsg_ValuesStdError      :='標準ｴﾗｰ';

  TeeMsg_Grid3D              :='3Dグリッド';

  TeeMsg_LowBezierPoints     :='ベジェのポイント数は1より大きな値を設定してください。';

  { TeeCommander component... }

  TeeCommanMsg_Normal   := '標準';
  TeeCommanMsg_Edit     := '編集';
  TeeCommanMsg_Print    := '印刷';
  TeeCommanMsg_Copy     := 'コピー';
  TeeCommanMsg_Save     := '保存';
  TeeCommanMsg_3D       := '3D';

  TeeCommanMsg_Rotating := '回転: %dｰ 仰角: %dｰ';
  TeeCommanMsg_Rotate   := '回転';

  TeeCommanMsg_Moving   := '水平オフセット: %d 垂直オフセット: %d';
  TeeCommanMsg_Move     := '移動';

  TeeCommanMsg_Zooming  := 'ズーム: %d %%';
  TeeCommanMsg_Zoom     := 'ズーム';

  TeeCommanMsg_Depthing := '3D: %d %%';
  TeeCommanMsg_Depth    := '深さ';

  TeeCommanMsg_Chart    :='チャート';
  TeeCommanMsg_Panel    :='パネル';

  TeeCommanMsg_RotateLabel:='%s をドラッグすると回転';
  TeeCommanMsg_MoveLabel  :='%s をドラッグすると移動';
  TeeCommanMsg_ZoomLabel  :='%s をドラッグするとズーム';
  TeeCommanMsg_DepthLabel :='%s をドラッグすると3Dをリサイズ';

  TeeCommanMsg_NormalLabel:='ｽﾞｰﾑ(ﾏｳｽ左ﾎﾞﾀﾝﾄﾞﾗｯｸﾞ) ｽｸﾛｰﾙ(ﾏｳｽ右ﾎﾞﾀﾝﾄﾞﾗｯｸﾞ)';
  TeeCommanMsg_NormalPieLabel:='円の一つの区分をドラッグすると分割';

  TeeCommanMsg_PieExploding := '区分: %d 分割: %d %%';

  TeeMsg_TriSurfaceLess:='ポイントの数は4以上にしてください。';
  TeeMsg_TriSurfaceAllColinear:='同一直線上にあるデータポイントの全て';
  TeeMsg_TriSurfaceSimilar:='類似したポイントは実行できません。';
  TeeMsg_GalleryTriSurface:='ｻｰﾌｪｽ(三角)';

  TeeMsg_AllSeries := '全ての系列';
  TeeMsg_Edit      := '編集';

  TeeMsg_GalleryFinancial    :='金融';

  TeeMsg_CursorTool    := 'カーソル';
  TeeMsg_DragMarksTool := 'ドラッグマーカ';
  TeeMsg_AxisArrowTool := '軸矢印';
  TeeMsg_DrawLineTool  := 'ドローライン';
  TeeMsg_NearestTool   := '近傍点';
  TeeMsg_ColorBandTool := 'カラーバンド';
  TeeMsg_ColorLineTool := 'カラーライン';
  TeeMsg_RotateTool    := '回転';
  TeeMsg_ImageTool     := 'イメージ';
  TeeMsg_MarksTipTool  := 'マーカチップ';
  Teemsg_AnnotationTool:= 'アノテーション';

  TeeMsg_CantDeleteAncestor  := '親クラスは削除できません。';

  TeeMsg_Load	         := '読込...';
  TeeMsg_NoSeriesSelected:= '系列が選択されていません。';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  := 'Chart';
  TeeMsg_CategorySeriesActions := 'Chart Series';

  TeeMsg_Action3D               := '3D(&3)';
  TeeMsg_Action3DHint           := '切り替え 2D / 3D';
  TeeMsg_ActionSeriesActive     := '有効(&A)';
  TeeMsg_ActionSeriesActiveHint := '表示 / 非表示 系列';
  TeeMsg_ActionEditHint         := 'チャートの編集';
  TeeMsg_ActionEdit             := '編集(&E)...';
  TeeMsg_ActionCopyHint         := 'クリップボードへコピー';
  TeeMsg_ActionCopy             := 'コピー(&C)';
  TeeMsg_ActionPrintHint        := 'チャートの印刷プレビュー';
  TeeMsg_ActionPrint            := '印刷(&P)...';
  TeeMsg_ActionAxesHint         := '表示 / 非表示 軸';
  TeeMsg_ActionAxes             := '軸(&A)';
  TeeMsg_ActionGridsHint        := '表示 / 非表示 グリッド';
  TeeMsg_ActionGrids            := 'グリッド(&G)';
  TeeMsg_ActionLegendHint       := '表示 / 非表示 凡例';
  TeeMsg_ActionLegend           := '凡例(&L)';
  TeeMsg_ActionSeriesEditHint   := '系列の編集';
  TeeMsg_ActionSeriesMarksHint  := '表示 / 非表示 系列のマーカ';
  TeeMsg_ActionSeriesMarks      := 'マーカ(&M)';
  TeeMsg_ActionSaveHint         := 'チャートの保存';
  TeeMsg_ActionSave             := '保存(&S)...';

  TeeMsg_CandleBar              := '線状';
  TeeMsg_CandleNoOpen           := '始値なし';
  TeeMsg_CandleNoClose          := '終値なし';
  TeeMsg_NoLines                := '線なし';
  TeeMsg_NoHigh                 := '高値なし';
  TeeMsg_NoLow                  := '安値なし';
  TeeMsg_ColorRange             := '色範囲';
  TeeMsg_WireFrame              := 'ワイヤー';
  TeeMsg_DotFrame               := '点';
  TeeMsg_Positions              := 'レベル位置';
  TeeMsg_NoGrid                 := 'ｸﾞﾘｯﾄﾞなし';
  TeeMsg_NoPoint                := 'ﾎﾟｲﾝﾄなし';
  TeeMsg_NoLine                 := '線なし';
  TeeMsg_Labels                 := 'ラベル付';
  TeeMsg_NoCircle               := '外円なし';
  TeeMsg_Lines                  := '中線付';
  TeeMsg_Border                 := '枠付';

  TeeMsg_SmithResistance      := '抵抗';
  TeeMsg_SmithReactance       := 'ﾘｱｸﾀﾝｽ';

  TeeMsg_Column  := '列';

  { 5.01 }
  TeeMsg_Separator            :='ｾﾊﾟﾚｰﾀ';
  TeeMsg_FunnelSegment        :='ｾｸﾞﾒﾝﾄ ';
  TeeMsg_FunnelSeries         :='ファネル';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='ｸｫｰﾀ以上';
  TeeMsg_FunnelWithin         :=' ｸｫｰﾀ以内';
  TeeMsg_FunnelBelow          :=' ｸｫｰﾀ以下';
  TeeMsg_CalendarSeries       :='カレンダー';
  TeeMsg_DeltaPointSeries     :='ﾃﾞﾙﾀﾎﾟｲﾝﾄ';
  TeeMsg_ImagePointSeries     :='ｲﾒｰｼﾞﾎﾟｲﾝﾄ';
  TeeMsg_ImageBarSeries       :='イメージバー';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field の数は0より大きな値を設定してください。';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='JPEG(&J)';
  TeeMsg_JPEGFilter    :='JPEGファイル (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='GIF(&G)';
  TeeMsg_GIFFilter     :='GIFファイル (*.gif)|*.gif';
  TeeMsg_AsPNG         :='PNG(&P)';
  TeeMsg_PNGFilter     :='PNGファイル (*.png)|*.png';
  TeeMsg_AsPCX         :='PCX(&X)';
  TeeMsg_PCXFilter     :='PCXファイル (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='VML(HTM)(&V)';
  TeeMsg_VMLFilter     :='VMLファイル (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := '原点';
  TeeMsg_Transparency         := '透明';
  TeeMsg_Box		      := '箱';
  TeeMsg_ExtrOut	      := '極値';
  TeeMsg_MildOut	      := '外れ値';
  TeeMsg_PageNumber	      := 'ページ数';
  TeeMsg_TextFile             := 'Textファイル';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'ｵﾌﾟﾁｭﾆﾃｨ値';
  TeeMsg_QuoteValues          := 'ｸｫｰﾄ値';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Release ' + AXVer;
  TeeMsg_ActiveXCannotImport := '%sからTeeChartをインポートできません。';
  TeeMsg_ActiveXVerbPrint    := 'プレビュー';
  TeeMsg_ActiveXVerbExport   := 'エクスポート';
  TeeMsg_ActiveXVerbImport   := 'インポート';
  TeeMsg_ActiveXVerbHelp     := 'ヘルプ';
  TeeMsg_ActiveXVerbAbout    := 'バージョン情報';
  TeeMsg_ActiveXError        := 'TeeChart: エラーコード: %d ダウンロード: %s';
  TeeMsg_DatasourceError     := 'TeeChartのデータソースは系列またはレコードセットではありません。';
  TeeMsg_SeriesTextSrcError  := '無効な系列型';
  TeeMsg_AxisTextSrcError    := '無効な軸型';
  TeeMsg_DelSeriesDatasource := '%sを削除してよろしいですか？';
  TeeMsg_OCXNoPrinter        := 'プリンタがインストールされていません。';
  TeeMsg_ActiveXPictureNotValid:='ピクチャーが無効です。';
end;

Procedure TeeCreateJapanese;
begin
  if not Assigned(TeeJapaneseLanguage) then
  begin
    TeeJapaneseLanguage:=TStringList.Create;
    TeeJapaneseLanguage.Text:=
'GRADIENT EDITOR=グラデーションの設定'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'DIRECTION=方向'#13+
'VISIBLE=表示'#13+
'TOP BOTTOM=下から上へ'#13+
'BOTTOM TOP=上から下へ'#13+
'LEFT RIGHT=右から左へ'#13+
'RIGHT LEFT=左から右へ'#13+
'FROM CENTER=中央から'#13+
'FROM TOP LEFT=右上隅から'#13+
'FROM BOTTOM LEFT=右下隅から'#13+
'OK=OK'#13+
'CANCEL=キャンセル'#13+
'COLORS=色'#13+
'START=開始'#13+
'MIDDLE=中央'#13+
'END=終了'#13+
'SWAP=入替'#13+
'NO MIDDLE=中央不可'#13+
'TEEFONT EDITOR=TeeFont Editor'#13+
'INTER-CHAR SPACING=文字の間隔'#13+
'FONT=フォント'#13+
'SHADOW=影'#13+
'HORIZ. SIZE=水平ｻｲｽﾞ'#13+
'VERT. SIZE=垂直ｻｲｽﾞ'#13+
'COLOR=色'#13+
'OUTLINE=ｱｳﾄﾗｲﾝ'#13+
'FORMAT=形式'#13+
'BEVEL=ベベル'#13+
'SIZE=サイズ'#13+
'FRAME=枠'#13+
'PATTERN=パターン'#13+
'ROUND FRAME=枠の角を丸くする'#13+
'TRANSPARENT=透明'#13+
'NONE=なし'#13+
'LOWERED=凹'#13+
'RAISED=凸'#13+
'COLOR=色'#13+
'LEFT TOP=左上'#13+
'LEFT BOTTOM=左下'#13+
'RIGHT TOP=右上'#13+
'RIGHT BOTTOM=右下'#13+
'MULTIPLE AREAS=複合'#13+
'STACKED=積み重ね'#13+
'STACKED 100%=百分率'#13+
'AREA=面'#13+
'STAIRS=階段'#13+
'SOLID=塗りつぶし'#13+
'CLEAR=なし'#13+
'HORIZONTAL=水平線'#13+
'VERTICAL=垂直線'#13+
'DIAGONAL=右下がり斜線'#13+
'B.DIAGONAL=右上がり斜線'#13+
'CROSS=交差線'#13+
'DIAG.CROSS=斜め交差線'#13+
'AREA LINES=面の縁取り'#13+
'BORDER=枠'#13+
'INVERTED=反転'#13+
'COLOR=色'#13+
'COLOR EACH=色を分ける'#13+
'ORIGIN=原点'#13+
'USE ORIGIN=原点を使用'#13+
'WIDTH=幅'#13+
'HEIGHT=高さ'#13+
'TEECHART LANGUAGES=TeeChart 言語'#13+
'CHOOSE A LANGUAGE=言語の選択'#13+
'CANCEL=キャンセル'#13+
'AXIS=軸'#13+
'LENGTH=長さ'#13+
'POSITION=位置'#13+
'SCROLL=スクロール'#13+
'START=開始'#13+
'END=終了'#13+
'BOTH=両方'#13+
'INVERTED SCROLL=逆スクロール'#13+
'AXIS INCREMENT=Axis Increment'#13+
'INCREMENT=増加量'#13+
'INCREMENT=増加量'#13+
'STANDARD=標準'#13+
'CUSTOM=カスタム'#13+
'ONE MILLISECOND=1ミリ秒'#13+
'ONE SECOND=1秒'#13+
'FIVE SECONDS=5秒'#13+
'TEN SECONDS=10秒'#13+
'FIFTEEN SECONDS=15秒'#13+
'THIRTY SECONDS=30秒'#13+
'ONE MINUTE=1分'#13+
'FIVE MINUTES=5分'#13+
'TEN MINUTES=10分'#13+
'FIFTEEN MINUTES=15分'#13+
'THIRTY MINUTES=30分'#13+
'ONE HOUR=1時間'#13+
'TWO HOURS=2時間'#13+
'SIX HOURS=6時間'#13+
'TWELVE HOURS=12時間'#13+
'ONE DAY=1日'#13+
'TWO DAYS=2日'#13+
'THREE DAYS=3日'#13+
'ONE WEEK=1週間'#13+
'HALF MONTH=半月'#13+
'ONE MONTH=1ヶ月'#13+
'TWO MONTHS=2ヶ月'#13+
'THREE MONTHS=3ヶ月'#13+
'FOUR MONTHS=4ヶ月'#13+
'SIX MONTHS=6ヶ月'#13+
'ONE YEAR=1年'#13+
'EXACT DATE TIME=正確な日付'#13+
'AXIS MAXIMUM AND MINIMUM=軸の最大値と最小値'#13+
'VALUE=値'#13+
'TIME=時間'#13+
'LEFT AXIS=左軸'#13+
'RIGHT AXIS=右軸'#13+
'TOP AXIS=上軸'#13+
'BOTTOM AXIS=下軸'#13+
'% BAR WIDTH=棒の幅'#13+
'STYLE=スタイル'#13+
'% BAR OFFSET=棒の位置'#13+
'RECTANGLE=矩形'#13+
'PYRAMID=四角錐'#13+
'INVERT. PYRAMID=倒立四角錐'#13+
'CYLINDER=円筒'#13+
'ELLIPSE=楕円'#13+
'ARROW=矢印'#13+
'RECT. GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ矩形'#13+
'CONE=円錐'#13+
'DARK BAR 3D SIDES=3D部を暗くする'#13+
'BAR SIDE MARGINS=棒の脇に余白を取る'#13+
'AUTO MARK POSITION=ﾏｰｶ位置の自動調整'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'JOIN=結合'#13+
'AUTO MARK POSITION=ﾏｰｶ位置の自動調整'#13+
'DATASET=ﾃﾞｰﾀｾｯﾄ'#13+
'APPLY=適用'#13+
'SOURCE=ソース'#13+
'COLORS=色'#13+
'MONOCHROME=モノクロ'#13+
'DEFAULT=デフォルト'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=中央値'#13+
'WHISKER=ひげ'#13+
'PATTERN COLOR EDITOR=パターンと色の設定'#13+
'IMAGE=イメージ'#13+
'IMAGE=イメージ'#13+
'BACK DIAGONAL=右上がり斜線'#13+
'DIAGONAL CROSS=斜め交差線'#13+
'FILL 80%=塗りつぶし 80%'#13+
'FILL 60%=塗りつぶし 60%'#13+
'FILL 40%=塗りつぶし 40%'#13+
'FILL 20%=塗りつぶし 20%'#13+
'FILL 10%=塗りつぶし 10%'#13+
'ZIG ZAG=ジグザグ'#13+
'VERTICAL SMALL=垂直線 (密)'#13+
'HORIZ. SMALL=水平線 (密)'#13+
'DIAG. SMALL=右下がり斜線 (密)'#13+
'BACK DIAG. SMALL=右上がり斜線 (密)'#13+
'CROSS SMALL=交差線 (密)'#13+
'DIAG. CROSS SMALL=斜め交差線 (密)'#13+
'PATTERN COLOR EDITOR=パターンと色の設定'#13+
'OPTIONS=オプション'#13+
'DAYS=日'#13+
'WEEKDAYS=曜日'#13+
'TODAY=今日'#13+
'SUNDAY=日曜日'#13+
'TRAILING=前後月'#13+
'MONTHS=年月'#13+
'LINES=線'#13+
'SHOW WEEKDAYS=曜日の表示'#13+
'UPPERCASE=大文字'#13+
'TRAILING DAYS=前後月の表示'#13+
'SHOW TODAY=今日の表示'#13+
'SHOW MONTHS=年月の表示'#13+
'UPPERCASE=大文字'#13+
{'UPPERCASE=NOTVisible'#13+}
'SHOW PREVIOUS BUTTON=前月ボタンの表示'#13+
'SHOW NEXT BUTTON=次月ボタンの表示'#13+
'CANDLE WIDTH=ｷｬﾝﾄﾞﾙの幅'#13+
'STYLE=スタイル'#13+
'STICK=棒状'#13+
'BAR=線状'#13+
'OPEN CLOSE=始値・終値'#13+
'UP CLOSE=高値の色'#13+
'DOWN CLOSE=安値の色'#13+
'SHOW OPEN=始値を表示'#13+
'SHOW CLOSE=終値を表示'#13+
'BORDER=枠'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D部を暗くする'#13+
'EDITING=Editing'#13+
'CHART=チャート'#13+
'SERIES=系列'#13+
'DATA=データ'#13+
'TOOLS=ツール'#13+
'EXPORT=エクスポート'#13+
'PRINT=印刷'#13+
'GENERAL=一般'#13+
'AXIS=軸'#13+
'TITLES=タイトル'#13+
'LEGEND=凡例'#13+
'PANEL=パネル'#13+
'PAGING=ページ'#13+
'WALLS=壁'#13+
'3D=3D'#13+
'ADD=追加'#13+
'DELETE=削除'#13+
'TITLE=タイトル'#13+
'CLONE=複製'#13+
'CHANGE=変更'#13+
'WWW.STEEMA.COM=http://www.newtone.co.jp/'#13+
'HELP=ヘルプ'#13+
'CLOSE=閉じる'#13+
'SERIES=系列'#13+
'IMAGE=イメージ'#13+
'TEECHART PRINT PREVIEW=TeeChart 印刷プレビュー'#13+
'PRINTER=ﾌﾟﾘﾝﾀ'#13+
'SETUP=設定'#13+
'PRINT=印刷'#13+
'ORIENTATION=印刷の向き'#13+
'PORTRAIT=縦'#13+
'LANDSCAPE=横'#13+
'MARGINS (%)=余白 (%)'#13+
'DETAIL=詳細'#13+
'MORE=より詳しく'#13+
'NORMAL=標準'#13+
'RESET MARGINS=余白のﾘｾｯﾄ'#13+
'VIEW MARGINS=余白の表示'#13+
'PROPORTIONAL=初期値に'#13+
'TEECHART PRINT PREVIEW=TeeChart 印刷プレビュー'#13+
'STYLE=スタイル'#13+
'CIRCLE=円'#13+
'VERTICAL LINE=垂直線'#13+
'HORIZ. LINE=水平線'#13+
'TRIANGLE=三角形'#13+
'INVERT. TRIANGLE=倒立三角形'#13+
'LINE=直線'#13+
'DIAMOND=菱形'#13+
'CUBE=立方体'#13+
'STAR=星形'#13+
'BORDER=枠'#13+
'TRANSPARENT=透明'#13+
'HORIZ. ALIGNMENT=水平方向の位置合わせ'#13+
'LEFT=左'#13+
'CENTER=中央'#13+
'RIGHT=右'#13+
'ROUND RECTANGLE=角を丸くする'#13+
'ALIGNMENT=位置合わせ'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'LEFT=左'#13+
'RIGHT=:右'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'UNITS=単位'#13+
'PIXELS=ピクセル'#13+
'AXIS ORIGIN=軸の原点'#13+
'ROTATION=回転'#13+
'CIRCLED=正円'#13+
'3 DIMENSIONS=3D'#13+
'RADIUS=半径'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'AUTO=自動'#13+
'AUTO=自動'#13+
'ANGLE INCREMENT=角度の増加量'#13+
'RADIUS INCREMENT=半径の増加量'#13+
'CLOSE CIRCLE=始点と終点の接続'#13+
'PEN=ペン'#13+
'CIRCLE=円'#13+
'PATTERN=パターン'#13+
'LABELS=ラベル'#13+
'ROTATED=90度回転'#13+
'CLOCKWISE=時計回り'#13+
'INSIDE=内側'#13+
'ROMAN=ローマ数字'#13+
'HOURS=時間'#13+
'MINUTES=分'#13+
'SECONDS=秒'#13+
'RADIUS=半径'#13+
'START VALUE=開始値'#13+
'END VALUE=終了値'#13+
'TRANSPARENCY=透明'#13+
'DRAW BEHIND=背面に描画'#13+
'COLOR MODE=色の種類'#13+
'STEPS=ステップ'#13+
'RANGE=範囲'#13+
'PALETTE=パレット'#13+
'PALE=淡い'#13+
'STRONG=濃い'#13+
'GRID SIZE=ｸﾞﾘｯﾄﾞｻｲｽﾞ'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=深さ'#13+
'IRREGULAR=不規則'#13+
'GRID=グリッド'#13+
'VALUE:=値'#13+
'ALLOW DRAG=ドラッグ可'#13+
'DRAG REPAINT=ドラッグの描画'#13+
'NO LIMIT DRAG=無制限ドラッグ'#13+
'VERTICAL POSITION=垂直位置'#13+
'LEVELS POSITION=レベル位置'#13+
'LEVELS=レベル'#13+
'NUMBER=個数'#13+
'LEVEL=レベル'#13+
'AUTOMATIC=自動'#13+
'COLOR EACH=色を分ける'#13+
'STYLE=スタイル'#13+
'SNAP=移動制限'#13+
'FOLLOW MOUSE=マウスに連動'#13+
'STACK=積み重ね'#13+
'HEIGHT 3D=3Dの高さ'#13+
'LINE MODE=線の種類'#13+
'INVERTED=反転'#13+
'DARK 3D=3D部を暗くする'#13+
'OVERLAP=ｵｰﾊﾞｰﾗｯﾌﾟ'#13+
'STACK=積み重ね'#13+
'STACK 100%=百分率'#13+
'CLICKABLE=クリック可'#13+
'OUTLINE=ｱｳﾄﾗｲﾝ'#13+
'LABELS=ラベル'#13+
'AVAILABLE=選択可能な項目'#13+
'SELECTED=選択された項目'#13+
'>=>'#13+
'>>=>>'#13+
'<=<'#13+
'<<=<<'#13+
'DATASOURCE=ﾃﾞｰﾀｿｰｽ'#13+
'GROUP BY=ｸﾞﾙｰﾌﾟ'#13+
'CALC=計算'#13+
'OF=of'#13+
'SUM=和'#13+
'COUNT=計算'#13+
'HIGH=最大'#13+
'LOW=最小'#13+
'AVG=平均値'#13+
'HOUR=時間'#13+
'DAY=日'#13+
'WEEK=週'#13+
'WEEKDAY=曜日'#13+
'MONTH=月'#13+
'QUARTER=四半期'#13+
'YEAR=年'#13+
'HOLE %=穴 %'#13+
'RESET POSITIONS=位置のリセット'#13+
'MOUSE BUTTON=ﾏｳｽﾎﾞﾀﾝ'#13+
'MIDDLE=中央'#13+
'ENABLE DRAWING=描画可'#13+
'ENABLE SELECT=選択可'#13+
'ENHANCED=拡張'#13+
'ERROR WIDTH=エラーの幅'#13+
'WIDTH UNITS=幅の単位'#13+
'PERCENT=百分率'#13+
'PIXELS=ピクセル'#13+
'RIGHT=右'#13+
'LEFT AND RIGHT=左と右'#13+
'TOP AND BOTTOM=上と下'#13+
'BORDER=ペン'#13+
'BORDER EDITOR=ペンの設定'#13+
'SOLID=実線'#13+
'DASH=破線'#13+
'DOT=点線'#13+
'DASH DOT=一点鎖線'#13+
'DASH DOT DOT=二点鎖線'#13+
'DRAW ALL=全て描画'#13+
'CALCULATE EVERY=計算'#13+
'ALL POINTS=全部の点'#13+
'NUMBER OF POINTS=ポイントの数'#13+
'RANGE OF VALUES=値の範囲'#13+
'ALIGNMENT=整列'#13+
'FIRST=最初'#13+
'CENTER=中央'#13+
'LAST=最後'#13+
'TEEPREVIEW EDITOR=TeePreviewの設定'#13+
'ALLOW MOVE=移動可'#13+
'ALLOW RESIZE=リサイズ可'#13+
'DRAG IMAGE=ｲﾒｰｼﾞのﾄﾞﾗｯｸﾞ'#13+
'AS BITMAP=ﾋﾞｯﾄﾏｯﾌﾟ'#13+
'SHOW IMAGE=イメージの表示'#13+
'PORTRAIT=縦'#13+
'LANDSCAPE=横'#13+
'MARGINS=余白'#13+
'SIZE=サイズ'#13+
'3D %=3D %'#13+
'ZOOM=ズーム'#13+
'ELEVATION=仰角'#13+
'100%=100%'#13+
'HORIZ. OFFSET=水平ｵﾌｾｯﾄ'#13+
'VERT. OFFSET=垂直ｵﾌｾｯﾄ'#13+
'PERSPECTIVE=遠近効果'#13+
'ANGLE=角度'#13+
'ORTHOGONAL=直交'#13+
'ZOOM TEXT=ﾃｷｽﾄをｽﾞｰﾑ'#13+
'SCALES=スケール'#13+
'TITLE=タイトル'#13+
'TICKS=目盛'#13+
'MINOR=副目盛'#13+
'MAXIMUM=最大値'#13+
'MINIMUM=最小値'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=期待する増加量'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=対数の基数'#13+
'LOGARITHMIC=対数軸'#13+
'AUTO=自動'#13+
'CHANGE=変更'#13+
'CHANGE=変更'#13+
'TITLE=タイトル'#13+
'ANGLE=角度'#13+
'MIN. SEPARATION %=最小間隔 %'#13+
'VISIBLE=表示'#13+
'MULTI-LINE=複数行'#13+
'LABEL ON AXIS=軸ラベル'#13+
'ROUND FIRST=始点で揃える'#13+
'AUTO=自動'#13+
'VALUE=値'#13+
'MARK=マーカ'#13+
'LABELS FORMAT=値の書式'#13+
'EXPONENTIAL=指数'#13+
'DEFAULT ALIGNMENT=デフォルトの配置'#13+
'LEN=長さ'#13+
'TICKS=目盛'#13+
'INNER=内側'#13+
'AT LABELS ONLY=ラベルのみ'#13+
'CENTERED=中央に配置'#13+
'LENGTH=長さ'#13+
'COUNT=個数'#13+
'TICKS=目盛'#13+
'GRID=グリッド'#13+
'POSITION %=位置 %'#13+
'START %=開始 %'#13+
'END %=終了 %'#13+
'OTHER SIDE=反対側'#13+
'AXES=軸'#13+
'VISIBLE=表示'#13+
'BEHIND=背面'#13+
'CLIP POINTS=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'PRINT PREVIEW=印刷ﾌﾟﾚﾋﾞｭｰ'#13+
'ZOOM=ズーム'#13+
'SCROLL=スクロール'#13+
'STEPS=ステップ'#13+
'MINIMUM PIXELS=最小ピクセル'#13+
'ALLOW=可'#13+
'ANIMATED=ｱﾆﾒｰｼｮﾝ'#13+
'PEN=ペン'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'ALLOW SCROLL=方法'#13+
'NONE=なし'#13+
'BOTH=両方'#13+
'TEEOPENGL EDITOR=TeeOpenGLの設定'#13+
'AMBIENT LIGHT=ｱﾝﾋﾞｴﾝﾄ光'#13+
'SHININESS=明るさ'#13+
'FONT 3D DEPTH=3Dﾌｫﾝﾄの深さ'#13+
'ACTIVE=有効'#13+
'FONT OUTLINES=ﾌｫﾝﾄのｱｳﾄﾗｲﾝ'#13+
'SMOOTH SHADING=滑らかな影'#13+
'LIGHT=光'#13+
'Y=Y'#13+
'INTENSITY=強さ'#13+
'SYMBOLS=シンボル'#13+
'TEXT STYLE=ﾃｷｽﾄの形式'#13+
'LEGEND STYLE=凡例の形式'#13+
'VERT. SPACING=垂直方向のｽﾍﾟｰｽ'#13+
'AUTOMATIC=自動'#13+
'SERIES NAMES=系列の名称'#13+
'SERIES VALUES=系列の値'#13+
'LAST VALUES=最後の値'#13+
'PLAIN=文字列のみ'#13+
'LEFT VALUE=値を右寄せ'#13+
'RIGHT VALUE=値を左寄せ'#13+
'LEFT PERCENT=百分率を右寄せ'#13+
'RIGHT PERCENT=百分率を左寄せ'#13+
'X VALUE=X値'#13+
'PERCENT=百分率'#13+
'X AND VALUE=X値と値'#13+
'X AND PERCENT=X値と百分率'#13+
'CHECK BOXES=ﾁｪｯｸﾎﾞｯｸｽ'#13+
'DIVIDING LINES=分割線'#13+
'FONT SERIES COLOR=ﾌｫﾝﾄを系列色に'#13+
'POSITION OFFSET %=位置のｵﾌｾｯﾄ %'#13+
'MARGIN=余白'#13+
'RESIZE CHART=位置合わせ'#13+
'LEFT=左'#13+
'TOP=上'#13+
'WIDTH UNITS=幅の単位'#13+
'CONTINUOUS=連続'#13+
'POINTS PER PAGE=1ﾍﾟｰｼﾞのﾎﾟｲﾝﾄ数'#13+
'SCALE LAST PAGE=最終ﾍﾟｰｼﾞをﾌﾙに表示'#13+
'CURRENT PAGE LEGEND=現在のﾍﾟｰｼﾞの凡例'#13+
'SHOW PAGE NUMBER=ﾍﾟｰｼﾞ数の表示'#13+
'PANEL EDITOR=Panel Editor'#13+
'BACKGROUND=背景'#13+
'BORDERS=枠'#13+
'COLOR=色'#13+
'BACK IMAGE=背景イメージ'#13+
'STRETCH=ストレッチ'#13+
'TILE=タイル'#13+
'CENTER=中央'#13+
'BROWSE=参照'#13+
'INSIDE=ｸﾞﾗﾌの内側'#13+
'TRANSPARENT=透明'#13+
'WIDTH=幅'#13+
'BEVEL INNER=内側ベベル'#13+
'BEVEL OUTER=外側ベベル'#13+
'LOWERED=凹'#13+
'RAISED=凸'#13+
'MARKS=マーカ'#13+
'DATA SOURCE=ﾃﾞｰﾀｿｰｽ'#13+
'SORT=並べ替え'#13+
'CURSOR=カーソル'#13+
'SHOW IN LEGEND=凡例を表示する'#13+
'FORMATS=書式'#13+
'VALUES=値'#13+
'PERCENTS=百分率'#13+
'HORIZONTAL AXIS=水平軸'#13+
'TOP AND BOTTOM=上と下'#13+
'DATETIME=日付書式'#13+
'VERTICAL AXIS=垂直軸'#13+
'LEFT AND RIGHT=左と右'#13+
'DATETIME=日付書式'#13+
'ASCENDING=昇順'#13+
'DESCENDING=降順'#13+
'DRAW EVERY=表示間隔'#13+
'STYLE=スタイル'#13+
'CLIPPED=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'ARROWS=引出線'#13+
'MULTI LINE=複数行'#13+
'ALL SERIES VISIBLE=全系列の表示'#13+
'VALUE=値'#13+
'PERCENT=百分率'#13+
'LABEL=ラベル'#13+
'LABEL AND PERCENT=ラベルと百分率'#13+
'LABEL AND VALUE=ラベルと値'#13+
'LEGEND=凡例'#13+
'PERCENT TOTAL=全体に対する割合'#13+
'LABEL AND PERCENT TOTAL=ラベルと割合'#13+
'X VALUE=X値'#13+
'X AND Y VALUES=X値とY値'#13+
'MANUAL=手動'#13+
'RANDOM=乱数'#13+
'FUNCTION=関数'#13+
'NEW=新規'#13+
'EDIT=編集'#13+
'DELETE=削除'#13+
'PERSISTENT=持続する'#13+
'TEXT=テキスト'#13+
'ADJUST FRAME=ﾌﾚｰﾑに合わせる'#13+
'CENTER=中央'#13+
'SUBTITLE=サブタイトル'#13+
'SUBFOOT=フッター'#13+
'FOOT=サブフッター'#13+
'ACTIVE=有効'#13+
'VISIBLE WALLS=壁の表示'#13+
'LEFT=左面'#13+
'RIGHT=右面'#13+
'BOTTOM=下面'#13+
'BACK=背面'#13+
'BORDER=枠'#13+
'DARK 3D=3D部を暗くする'#13+
'DIF. LIMIT=リミット'#13+
'LINES=線'#13+
'ABOVE=以上'#13+
'WITHIN=以内'#13+
'BELOW=以下'#13+
'CONNECTING LINES=接続線'#13+
'HIGH=高い'#13+
'LOW=低い'#13+
'PATTERN=パターン'#13+
'BROWSE=参照'#13+
'TILED=タイル'#13+
'3D=3D'#13+
'INFLATE MARGINS=ﾎﾟｲﾝﾄの完全表示'#13+
'SQUARE=正方形'#13+
'FLAT=平ら'#13+
'ROUND=丸'#13+
'DOWN TRIANGLE=倒立三角形'#13+
'STAR=星'#13+
'SMALL DOT=点'#13+
'DARK 3D=3D部を暗くする'#13+
'DEFAULT=デフォルト'#13+
'GLOBAL=グローバル'#13+
'SHAPES=形状'#13+
'BRUSH=ブラシ'#13+
'GLOBAL=グローバル'#13+
'BRUSH=ブラシ'#13+
'GLOBAL=グローバル'#13+
'DELAY=遅延時間'#13+
'MSEC.=ミリ秒'#13+
'PERCENT=百分率'#13+
'LABEL=ラベル'#13+
'LABEL AND PERCENT=ラベルと百分率'#13+
'LABEL AND VALUE=ラベルと値'#13+
'LEGEND=凡例'#13+
'PERCENT TOTAL=全体に対する割合'#13+
'X VALUE=X値'#13+
'X AND Y VALUES=X値とY値'#13+
'MOUSE ACTION=マウスの動作'#13+
'MOVE=移動'#13+
'CLICK=クリック'#13+
'SIZE=サイズ'#13+
'BRUSH=ブラシ'#13+
'DRAW LINE=線の描画'#13+
'EXPLODE BIGGEST=最大区分の分割'#13+
'TOTAL ANGLE=全体の角度'#13+
'GROUP SLICES=グループ'#13+
'VALUE=値'#13+
'LABEL=ラベル'#13+
'BELOW %=指定%未満'#13+
'BELOW VALUE=指定値未満'#13+
'OTHER=その他'#13+
'PATTERNS=パターン'#13+
'DEPTH=深さ'#13+
'LINE=線'#13+
'SIZE %=サイズ'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Text の設定'#13+
'FIELDS=フィールド'#13+
'SOURCE=ソース'#13+
'NUMBER OF HEADER LINES=ヘッダーの行数'#13+
'SEPARATOR=ｾﾊﾟﾚｰﾀ'#13+
'SERIES=系列'#13+
'COMMA=カンマ'#13+
'SPACE=スペース'#13+
'TAB=タブ'#13+
'FILE=ファイル'#13+
'WEB URL=URL'#13+
'LOAD=読込'#13+
'IMAG. SYMBOL=虚数ｼﾝﾎﾞﾙ'#13+
'C LABELS=C ラベル'#13+
'R LABELS=R ラベル'#13+
'C PEN=C ペン'#13+
'R PEN=R ペン'#13+
'CIRCLE=外円'#13+
'COLOR EACH=色を分ける'#13+
'FONT=フォント'#13+
'STACK GROUP=積み重ねのｸﾞﾙｰﾌﾟ'#13+
'USE ORIGIN=原点を使用'#13+
'MULTIPLE BAR=複合'#13+
'SIDE=併置'#13+
'SIDE ALL=並列（系列毎）'#13+
'DRAWING MODE=描画モード'#13+
'WIREFRAME=ワイヤー'#13+
'DOTFRAME=点'#13+
'SMOOTH PALETTE=ﾊﾟﾚｯﾄを滑らかに'#13+
'SIDE BRUSH=側面ブラシ'#13+
'ABOUT TEECHART PRO V7.0=About TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'STEEMA SOFTWARE=NEWTONE Corp.'#13+
'WWW.STEEMA.COM=http://www.newtone.co.jp/'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=TeeChart ウィザード'#13+
'WWW.STEEMA.COM=www.newtone.co.jp'#13+
'SELECT A CHART STYLE=チャートのスタイルの選択'#13+
'DATABASE CHART=データベースチャート'#13+
'NON DATABASE CHART=非データベースチャート'#13+
'SELECT A DATABASE TABLE=データベーステーブルの選択'#13+
'ALIAS=エリアス'#13+
'TABLE=テーブル名'#13+
'SOURCE=ソース'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=チャートに設定する項目の選択'#13+
'SELECT A TEXT LABELS FIELD=ラベルにしたい項目'#13+
'CHOOSE THE DESIRED CHART TYPE=チャートの選択'#13+
'2D=2D'#13+
'CHART PREVIEW=チャートプレビュー'#13+
'3D=3D'#13+
'SHOW LEGEND=凡例を表示'#13+
'SHOW MARKS=ﾏｰｶを表示'#13+
'COLOR EACH=色を分ける'#13+
'< BACK=< 戻る'#13+
'NEXT >=次へ >'#13+
'EXPORT CHART=チャートのエクスポート'#13+
'PICTURE=ピクチャー'#13+
'NATIVE=ネイティブ'#13+
'FORMAT=形式'#13+
'SIZE=サイズ'#13+
'KEEP ASPECT RATIO=縦横比を保つ'#13+
'INCLUDE SERIES DATA=系列データを含む'#13+
'FILE SIZE=ファイルサイズ'#13+
'SERIES=系列'#13+
'DELIMITER=デリミタ'#13+
'XML=XML'#13+
'HTML TABLE=HTML テーブル'#13+
'EXCEL=Excel'#13+
'COLON=コロン'#13+
'CUSTOM=カスタム'#13+
'INCLUDE=含める項目'#13+
'POINT LABELS=ﾎﾟｲﾝﾄﾗﾍﾞﾙ'#13+
'POINT INDEX=ﾎﾟｲﾝﾄｲﾝﾃﾞｯｸｽ'#13+
'HEADER=ﾍｯﾀﾞｰ'#13+
'COPY=コピー'#13+
'SAVE=保存'#13+
'SEND=送る'#13+
'FUNCTIONS=関数'#13+
'ADD=Add'#13+
'ADX=ADX'#13+
'AVERAGE=Average'#13+
'BOLLINGER=Bollinger'#13+
'COPY=Copy'#13+
'COUNT=Count'#13+
'CUMULATIVE=Cumulative'#13+
'CURVE FITTING=Curve Fitting'#13+
'DIVIDE=Divide'#13+
'EXP. AVERAGE=Exp. Average'#13+
'EXP.MOV.AVRG.=Exp.Mov.Avrg.'#13+
'EXP.TREND=Exp.Trend'#13+
'HIGH=High'#13+
'LOW=Low'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Moving Avrg.'#13+
'MULTIPLY=Multiply'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=Std.Deviation'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Subtract'#13+
'TREND=Trend'#13+
'SOURCE SERIES=系列'#13+
'TEECHART GALLERY=TeeChart ギャラリ'#13+
'FUNCTIONS=関数'#13+
'STANDARD=標準'#13+
'FINANCIAL=金融'#13+
'STATS=統計'#13+
'EXTENDED=拡張'#13+
'OTHER=その他'#13+
'DITHER=ディザ'#13+
'REDUCTION=減色'#13+
'COMPRESSION=圧縮'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nearest'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'NONE=なし'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=モノクロ'#13+
'GRAY SCALE=ｸﾞﾚｰｽｹｰﾙ'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% 品質'#13+
'GRAY SCALE=ｸﾞﾚｰｽｹｰﾙ'#13+
'PERFORMANCE=ﾊﾟﾌｫｰﾏﾝｽ'#13+
'QUALITY=品質'#13+
'SPEED=速度'#13+
'COMPRESSION LEVEL=圧縮レベル'#13+
'CHART TOOLS GALLERY=Chart Tools ギャラリ'#13+
'ANNOTATION=アノテーション'#13+
'AXIS ARROWS=軸矢印'#13+
'COLOR BAND=カラーバンド'#13+
'COLOR LINE=カラーライン'#13+
'CURSOR=カーソル'#13+
'DRAG MARKS=ドラッグマーカ'#13+
'DRAW LINE=ドローライン'#13+
'IMAGE=イメージ'#13+
'MARK TIPS=マーカチップ'#13+
'NEAREST POINT=近傍点'#13+
'PAGE NUMBER=ページ数'#13+
'ROTATE=回転'#13+
'CHART TOOLS GALLERY=Chart Tools ギャラリ'#13+
'OUTLINE=枠'#13+
'USE Y ORIGIN=Y原点を使用'#13+

{AX 5.0.4}
'COLOR EACH LINE=色を分ける線'#13+
'SUBFOOT=サブフッター'#13+
'FOOT=フッター'#13+
'RADIAL=放射状に'#13+
'BUTTON=ボタン'#13+
'ALL=全て'#13

{$IFDEF TEEOCX}
+
{ADO Editor}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- ADOデータソースの選択'#13+
'CONNECTION=接続'#13+
'DATASET=データセット'#13+
'TABLE=テーブル'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=システムテーブル'#13+
'LOGIN PROMPT=ﾛｸﾞｲﾝ ﾌﾟﾛﾝﾌﾟﾄ'#13+
'SELECT=選択'#13+
{Import dialogue}
'TEECHART IMPORT=TeeChart インポート'#13+
'IMPORT CHART FROM=インポートチャート場所'#13+
'IMPORT NOW=インポート'#13+
{Property page}
'EDIT CHART=チャートの編集'#13
{$ENDIF}
;
  end;
end;

Procedure TeeSetJapanese;
begin
  TeeCreateJapanese;
  TeeLanguage:=TeeJapaneseLanguage;
  TeeJapaneseConstants;
  TeeLanguageHotKeyAtEnd:=True;
  TeeLanguageCanUpper:=False;
end;

initialization
finalization
  FreeAndNil(TeeJapaneseLanguage);
end.
