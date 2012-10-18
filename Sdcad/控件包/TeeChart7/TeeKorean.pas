unit TeeKorean;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeKoreanLanguage:TStringList=nil;

Procedure TeeSetKorean;
Procedure TeeCreateKorean;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeKoreanConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2004 by David Berneda';

  TeeMsg_Test               :='테스트...';
  TeeMsg_LegendFirstValue   :='첫번째 범례값은 0 보다 커야합니다.';
  TeeMsg_LegendColorWidth   :='범례 색 너비는 0% 이상입니다.';
  TeeMsg_SeriesSetDataSource:='상위차트의 데이터 원천이 바르지 않습니다.';
  TeeMsg_SeriesInvDataSource:='데이터가 바르지 않습니다.: %s';
  TeeMsg_FillSample         :='샘플값채우기의 값은 0 이상입니다.';
  TeeMsg_AxisLogDateTime    :='시간축을 로그화 할 수 없습니다.';
  TeeMsg_AxisLogNotPositive :='로그축의 최대, 최소는 0 이상입니다.';
  TeeMsg_AxisLabelSep       :='라벨 분리율은 0 보다 큽니다.';
  TeeMsg_AxisIncrementNeg   :='축 증가는 0 이상입니다.';
  TeeMsg_AxisMinMax         :='축 최하값은 최대값 이하입니다.';
  TeeMsg_AxisMaxMin         :='축 최대값은 최소값 이상입니다.';
  TeeMsg_AxisLogBase        :='로그축 밑수는 2 이상입니다.';
  TeeMsg_MaxPointsPerPage   :='페이지당 최대포인트는 0 이상입니다.';
  TeeMsg_3dPercent          :='3D 효과 백분율은 %d 부터 %d 까지 입니다.';
  TeeMsg_CircularSeries     :='원형 계열의 의존은 허용되지 않습니다.';
  TeeMsg_WarningHiColor     :='좋은 화질을 위해서는 16k 컬러이거나 그 이상 되어야 합니다.';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='축 제목';
  TeeMsg_AxisLabels         :='축 라벨';
  TeeMsg_RefreshInterval    :='새로고침 간격은 0 부터 60 까지 입니다.';
  TeeMsg_SeriesParentNoSelf :='계열의 부모 차트는 자기자신일 수 없습니다.';
  TeeMsg_GalleryLine        :='선형';
  TeeMsg_GalleryPoint       :='포인트형';
  TeeMsg_GalleryArea        :='영역형';
  TeeMsg_GalleryBar         :='세로 막대형';
  TeeMsg_GalleryHorizBar    :='가로 막대형';
  TeeMsg_Stack              :='스택';
  TeeMsg_GalleryPie         :='원형';
  TeeMsg_GalleryCircled     :='원';
  TeeMsg_GalleryFastLine    :='얇은 선형';
  TeeMsg_GalleryHorizLine   :='수평 선형';

  TeeMsg_PieSample1         :='자동차';
  TeeMsg_PieSample2         :='전화기';
  TeeMsg_PieSample3         :='테이블';
  TeeMsg_PieSample4         :='모니터';
  TeeMsg_PieSample5         :='전등';
  TeeMsg_PieSample6         :='키보드';
  TeeMsg_PieSample7         :='자전거';
  TeeMsg_PieSample8         :='의자';

  TeeMsg_GalleryLogoFont    :='굴림';
  TeeMsg_Editing            :='편집 %s';

  TeeMsg_GalleryStandard    :='표준';
  TeeMsg_GalleryExtended    :='확장';
  TeeMsg_GalleryFunctions   :='함수';

  TeeMsg_EditChart          :='차트 편집(&d)...';
  TeeMsg_PrintPreview       :='출력 미리보기(&p)...';
  TeeMsg_ExportChart        :='차트 내보내기(&x)...';
  TeeMsg_CustomAxes         :='사용자 축...';

  TeeMsg_InvalidEditorClass :='%s: 유효하지 않은 Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: 은(는) Editor Dialog를 가지고 있지 않습니다.';

  TeeMsg_GalleryArrow       :='화살표형';

  TeeMsg_ExpFinish          :='종료(&f)';
  TeeMsg_ExpNext            :='다음(&n) >';

  TeeMsg_GalleryGantt       :='간트형';

  TeeMsg_GanttSample1       :='디자인';
  TeeMsg_GanttSample2       :='원형';
  TeeMsg_GanttSample3       :='성장';
  TeeMsg_GanttSample4       :='판매';
  TeeMsg_GanttSample5       :='마케팅';
  TeeMsg_GanttSample6       :='시험';
  TeeMsg_GanttSample7       :='제조';
  TeeMsg_GanttSample8       :='수정';
  TeeMsg_GanttSample9       :='새 버전';
  TeeMsg_GanttSample10      :='금융';

  TeeMsg_ChangeSeriesTitle  :='계열 제목 바꾸기';
  TeeMsg_NewSeriesTitle     :='새로운 계열 제목:';
  TeeMsg_DateTime           :='일시';
  TeeMsg_TopAxis            :='위 축';
  TeeMsg_BottomAxis         :='아래 축';
  TeeMsg_LeftAxis           :='왼쪽 축';
  TeeMsg_RightAxis          :='오른쪽 축';

  TeeMsg_SureToDelete       :='%s 을(를) 지우겠습니까?';
  TeeMsg_DateTimeFormat     :='일시 형식(&m)';
  TeeMsg_Default            :='기본값';
  TeeMsg_ValuesFormat       :='값 형식(&m)';
  TeeMsg_Maximum            :='최대값';
  TeeMsg_Minimum            :='최소값';
  TeeMsg_DesiredIncrement   :='원하는 %s 증가치 ';

  TeeMsg_IncorrectMaxMinValue:='잘못된 값입니다. 이유: %s';
  TeeMsg_EnterDateTime      :='입력하십시요 [일수] [시간:분:초]';

  TeeMsg_SureToApply        :='바뀐 내용을 적용하시겠습니까?';
  TeeMsg_SelectedSeries     :='(선택된 계열)';
  TeeMsg_RefreshData        :='데이터 새로고침(&r)';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='더하기';
  TeeMsg_FunctionSubtract   :='빼기';
  TeeMsg_FunctionMultiply   :='곱하기';
  TeeMsg_FunctionDivide     :='나누기';
  TeeMsg_FunctionHigh       :='높은값';
  TeeMsg_FunctionLow        :='낮은값';
  TeeMsg_FunctionAverage    :='평균값';

  TeeMsg_GalleryShape       :='도형형';
  TeeMsg_GalleryBubble      :='거품형';
  TeeMsg_FunctionNone       :='복사';

  TeeMsg_None               :='(없음)';

  TeeMsg_PrivateDeclarations:='{ 지역 선언 }';
  TeeMsg_PublicDeclarations :='{ 공통 선언 }';
  TeeMsg_DefaultFontName    :={$IFDEF CLX}'굴림'{$ELSE}'Arial'{$ENDIF};
  TeeMsg_CheckPointerSize   :='포인터 크기는 0 보다 커야 합니다.';
  TeeMsg_About              :='차트에 대해서(&u)...';

  tcAdditional              :='부가적인';
  tcDControls               :='데이터 제어';
  tcQReport                 :='Q리포트';

  TeeMsg_DataSet            :='데이터셋';
  TeeMsg_AskDataSet         :='데이터셋(&d):';

  TeeMsg_SingleRecord       :='단일 레코드';
  TeeMsg_AskDataSource      :='데이터원천(&d)';

  TeeMsg_Summary            :='요약';

  TeeMsg_FunctionPeriod     :='함수 기간은 0 이상입니다.';

  TeeMsg_WizardTab          :='비즈니스';
  TeeMsg_TeeChartWizard     :='차트 마법사';

  TeeMsg_ClearImage         :='지우기(&r)';
  TeeMsg_BrowseImage        :='검색창(&r)...';

  TeeMsg_WizardSureToClose  :='차트 마법사를 종료하시겠습니까?';
  TeeMsg_FieldNotFound      :='%s 필드가 존재하지 않습니다.';

  TeeMsg_DepthAxis          :='깊이 축';
  TeeMsg_PieOther           :='기타';
  TeeMsg_ShapeGallery1      :='ㄱㄴㄷ';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='원';
  TeeMsg_ValuesBar          :='막대';
  TeeMsg_ValuesAngle        :='각도';
  TeeMsg_ValuesGanttStart   :='시작';
  TeeMsg_ValuesGanttEnd     :='끝';
  TeeMsg_ValuesGanttNextTask:='다음';
  TeeMsg_ValuesBubbleRadius :='반지름';
  TeeMsg_ValuesArrowEndX    :='X끝';
  TeeMsg_ValuesArrowEndY    :='Y끝';
  TeeMsg_Legend             :='범례';
  TeeMsg_Title              :='제목';
  TeeMsg_Foot               :='각주';
  TeeMsg_Period		          :='기간';
  TeeMsg_PeriodRange        :='기간 범위';
  TeeMsg_CalcPeriod         :='매 %s마다 계산';
  TeeMsg_SmallDotsPen       :='작은 점선';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' file 안에 유효하지 않은 차트';
  TeeMsg_WrongTeeFileFormat :='잘못된 *.'+TeeMsg_TeeExtension+' file 형식';
  TeeMsg_EmptyTeeFile       :='비어있는 *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '차트 축';
  TeeMsg_ChartAxesCategoryDesc   := '차트 축 속성과 이벤트';
  TeeMsg_ChartWallsCategoryName  := '차트 벽면';
  TeeMsg_ChartWallsCategoryDesc  := '차트 벽면 속성과 이벤트';
  TeeMsg_ChartTitlesCategoryName := '차트 제목';
  TeeMsg_ChartTitlesCategoryDesc := '차트 제목 속성과 이벤트';
  TeeMsg_Chart3DCategoryName     := '3D 차트';
  TeeMsg_Chart3DCategoryDesc     := '3D 차트 속성과 이벤트';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='사용자 정의 ';
  TeeMsg_Series                 :='계열';
  TeeMsg_SeriesList             :='계열...';

  TeeMsg_PageOfPages            :='%d / %d 페이지';
  TeeMsg_FileSize               :='%d 바이트';

  TeeMsg_First  :='맨 앞';
  TeeMsg_Prior  :='이전';
  TeeMsg_Next   :='다음';
  TeeMsg_Last   :='맨 끝';
  TeeMsg_Insert :='삽입';
  TeeMsg_Delete :='삭제';
  TeeMsg_Edit   :='편집';
  TeeMsg_Post   :='확인';
  TeeMsg_Cancel :='취소';

  TeeMsg_All    :='(전체)';
  TeeMsg_Index  :='인덱스';
  TeeMsg_Text   :='텍스트';

  TeeMsg_AsBMP        :='비트맵으로(&b)';
  TeeMsg_BMPFilter    :='비트맵 (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='메타파일로(&m)';
  TeeMsg_EMFFilter    :='향상된 메타파일 (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '패널 속성은 내보내기 형식에 설정될 수 없습니다.';

  TeeMsg_Normal    :='일반';
  TeeMsg_NoBorder  :='테두리 없음';
  TeeMsg_Dotted    :='점선';
  TeeMsg_Colors    :='색';
  TeeMsg_Filled    :='채움';
  TeeMsg_Marks     :='표식';
  TeeMsg_Stairs    :='계단';
  TeeMsg_Points    :='포인트';
  TeeMsg_Height    :='높이';
  TeeMsg_Hollow    :='투명';
  TeeMsg_Point2D   :='2D 포인트';
  TeeMsg_Triangle  :='삼각';
  TeeMsg_Star      :='별';
  TeeMsg_Circle    :='원';
  TeeMsg_DownTri   :='역삼각';
  TeeMsg_Cross     :='십자가';
  TeeMsg_Diamond   :='다이아몬드';
  TeeMsg_NoLines   :='선 없음';
  TeeMsg_Stack100  :='스택 100%';
  TeeMsg_Pyramid   :='피라미드';
  TeeMsg_Ellipse   :='타원';
  TeeMsg_InvPyramid:='역피라미드';
  TeeMsg_Sides     :='측면';
  TeeMsg_SideAll   :='계열 측면';
  TeeMsg_Patterns  :='무늬';
  TeeMsg_Exploded  :='분리된 원';
  TeeMsg_Shadow    :='그림자';
  TeeMsg_SemiPie   :='반원';
  TeeMsg_Rectangle :='사각형';
  TeeMsg_VertLine  :='세로 선';
  TeeMsg_HorizLine :='가로 선';
  TeeMsg_Line      :='선';
  TeeMsg_Cube      :='정육면체';
  TeeMsg_DiagCross :='대각선 십자형';

  TeeMsg_CanNotFindTempPath    :='임시 폴더를 찾을 수 없습니다.';
  TeeMsg_CanNotCreateTempChart :='임시 파일을 생성할 수 없습니다.';
  TeeMsg_CanNotEmailChart      :='email을 사용할 수 없습니다. Mapi 에러: %d';

  TeeMsg_SeriesDelete :='계열 삭제: 인덱스값 %d 범위 초과 (0 부터 %d)';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='JPEG로(&j)';
  TeeMsg_JPEGFilter    :='JPEG 파일 (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='GIF로(&g)';
  TeeMsg_GIFFilter     :='GIF 파일 (*.gif)|*.gif';
  TeeMsg_AsPNG         :='PNG로(&p)';
  TeeMsg_PNGFilter     :='PNG 파일 (*.png)|*.png';
  TeeMsg_AsPCX         :='PCX로(&x)';
  TeeMsg_PCXFilter     :='PCX 파일 (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='VML로(&v) (HTM)';
  TeeMsg_VMLFilter     :='VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='언어(&l)...';

  { 5.03 }
  TeeMsg_Gradient     :='변화';
  TeeMsg_WantToSave   :='%s 을(를) 저장하시겠습니까?';
  TeeMsg_NativeFilter :='차트 파일 '+TeeDefaultFilterExtension;

  TeeMsg_Property     :='속성';	
  TeeMsg_Value        :='값';
  TeeMsg_Yes          :='예';
  TeeMsg_No           :='아니오';
  TeeMsg_Image        :='(이미지)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='방위형';
  TeeMsg_GalleryCandle      :='주식막대형';
  TeeMsg_GalleryVolume      :='얇은 세로막대형';
  TeeMsg_GallerySurface     :='표면형';
  TeeMsg_GalleryContour     :='등고선형';
  TeeMsg_GalleryBezier      :='베지어형';
  TeeMsg_GalleryPoint3D     :='3D 포인트형';
  TeeMsg_GalleryRadar       :='레이다형';
  TeeMsg_GalleryDonut       :='도넛형';
  TeeMsg_GalleryCursor      :='커서';
  TeeMsg_GalleryBar3D       :='3D 막대형';
  TeeMsg_GalleryBigCandle   :='큰 주식막대형';
  TeeMsg_GalleryLinePoint   :='선 포인트형';
  TeeMsg_GalleryHistogram   :='막대 그래프형';
  TeeMsg_GalleryWaterFall   :='폭포수형';
  TeeMsg_GalleryWindRose    :='나침판형';
  TeeMsg_GalleryClock       :='시계형';
  TeeMsg_GalleryColorGrid   :='색그리드형';
  TeeMsg_GalleryBoxPlot     :='가로 BoxPlot형';
  TeeMsg_GalleryHorizBoxPlot:='세로 BoxPlot형';
  TeeMsg_GalleryBarJoin     :='막대 연결형';
  TeeMsg_GallerySmith       :='스미스형';
  TeeMsg_GalleryPyramid     :='피라미드형';
  TeeMsg_GalleryMap         :='지도형';

  TeeMsg_PolyDegreeRange    :='다항 각도는 1 부터 20 까지입니다.';
  TeeMsg_AnswerVectorIndex   :='벡터 인덱스는 1 부터 %d 까지입니다.';
  TeeMsg_FittingError        :='최적화 할 수 없습니다.';
  TeeMsg_PeriodRange         :='기간은 0 이상입니다.';
  TeeMsg_ExpAverageWeight    :='지수 평균 가중치는 0 부터 1 까지입니다.';
  TeeMsg_GalleryErrorBar     :='에러 막대형';
  TeeMsg_GalleryError        :='에러형';
  TeeMsg_GalleryHighLow      :='고저형';
  TeeMsg_FunctionMomentum    :='모멘트형';
  TeeMsg_FunctionMomentumDiv :='모멘트 분할형';
  TeeMsg_FunctionExpAverage  :='지수 평균';
  TeeMsg_FunctionMovingAverage:='이동 평균';
  TeeMsg_FunctionExpMovAve   :='지수 이동 평균';
  TeeMsg_FunctionRSI         :='상대강도지수';
  TeeMsg_FunctionCurveFitting:='곡선형';
  TeeMsg_FunctionTrend       :='추세';
  TeeMsg_FunctionExpTrend    :='지수 추세';
  TeeMsg_FunctionLogTrend    :='로그 추세';
  TeeMsg_FunctionCumulative  :='누적';
  TeeMsg_FunctionStdDeviation:='표준 편차';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='제곱근 편차';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='확률';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='합계';
  TeeMsg_LoadChart           :='차트 열기...';
  TeeMsg_SaveChart           :='차트 저장...';
  TeeMsg_TeeFiles            :='차트 파일';

  TeeMsg_GallerySamples      :='기타';
  TeeMsg_GalleryStats        :='상태';

  TeeMsg_CannotFindEditor    :='계열 편집창을 찾을 수 없습니다.: %s';


  TeeMsg_CannotLoadChartFromURL:='에러 코드: %d 차트 다운로드 URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='에러 코드: %d 계열 데이터 다운로드 URL: %s';

  TeeMsg_ValuesDate          :='날짜';
  TeeMsg_ValuesOpen          :='열기';
  TeeMsg_ValuesHigh          :='높음';
  TeeMsg_ValuesLow           :='낮음';
  TeeMsg_ValuesClose         :='닫음';
  TeeMsg_ValuesOffset        :='오프셋';
  TeeMsg_ValuesStdError      :='표준에러';

  TeeMsg_Grid3D              :='3D 그리드';

  TeeMsg_LowBezierPoints     :='베지어형 포인터 수는 1보다 커야합니다.';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='표준';
  TeeCommanMsg_Edit     :='편집';
  TeeCommanMsg_Print    :='프린트';
  TeeCommanMsg_Copy     :='복사';
  TeeCommanMsg_Save     :='저장';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='회전: %d? 높이: %d?';
  TeeCommanMsg_Rotate   :='회전';

  TeeCommanMsg_Moving   :='수평 오프셋: %d 수직 오프셋: %d';
  TeeCommanMsg_Move     :='이동';

  TeeCommanMsg_Zooming  :='줌: %d %%';
  TeeCommanMsg_Zoom     :='줌';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='깊이';

  TeeCommanMsg_Chart    :='차트';
  TeeCommanMsg_Panel    :='패널';

  TeeCommanMsg_RotateLabel:='회전을 위한 드래그 %s';
  TeeCommanMsg_MoveLabel  :='이동을 위한 드래그 %s';
  TeeCommanMsg_ZoomLabel  :='줌을 위한 드래그 %s';
  TeeCommanMsg_DepthLabel :='3D 크기 재설정을 위한 드래그 %s';

  TeeCommanMsg_NormalLabel:='왼쪽 버튼을 드래그하면 줌, 오른쪽 버튼은 스크롤 됩니다.';
  TeeCommanMsg_NormalPieLabel:='원형 조각을 드래그하면 분리할 수 있습니다.';

  TeeCommanMsg_PieExploding :='조각: %d 분리: %d %%';

  TeeMsg_TriSurfaceLess        :='포인트 개수는 4 이상이어야 합니다.';
  TeeMsg_TriSurfaceAllColinear :='동일선상의 모든 데이터 포인트';
  TeeMsg_TriSurfaceSimilar     :='유사한 포인트 - 실행할 수 없습니다.';
  TeeMsg_GalleryTriSurface     :='삼각 표면형';

  TeeMsg_AllSeries :='모든 계열';
  TeeMsg_Edit      :='편집';

  TeeMsg_GalleryFinancial    :='경제';

  TeeMsg_CursorTool    :='커서';
  TeeMsg_DragMarksTool :='표식 드래그';
  TeeMsg_AxisArrowTool :='축 화살표';
  TeeMsg_DrawLineTool  :='선 그리기';
  TeeMsg_NearestTool   :='근처 포인트';
  TeeMsg_ColorBandTool :='색상띠';
  TeeMsg_ColorLineTool :='색 선';
  TeeMsg_RotateTool    :='회전';
  TeeMsg_ImageTool     :='이미지';
  TeeMsg_MarksTipTool  :='힌트 표식';
  TeeMsg_AnnotationTool:='주석';

  TeeMsg_CantDeleteAncestor  :='상위는 지울 수 없습니다.';

  TeeMsg_Load	          :='불러오기...';
  TeeMsg_NoSeriesSelected :='선택된 계열이 없습니다.';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='차트';
  TeeMsg_CategorySeriesActions :='차트 계열';

  TeeMsg_Action3D               := '3D(&3)';
  TeeMsg_Action3DHint           := '2D / 3D 변환';
  TeeMsg_ActionSeriesActive     := '활성화(&a)';
  TeeMsg_ActionSeriesActiveHint := '계열 보임 / 숨김';
  TeeMsg_ActionEditHint         := '차트 편집';
  TeeMsg_ActionEdit             := '편집(&e)...';
  TeeMsg_ActionCopyHint         := '클립보드로 복사';
  TeeMsg_ActionCopy             := '복사(&c)';
  TeeMsg_ActionPrintHint        := '차트 미리보기';
  TeeMsg_ActionPrint            := '인쇄(&p)...';
  TeeMsg_ActionAxesHint         := '축 보임 / 숨김';
  TeeMsg_ActionAxes             := '축(&a)';
  TeeMsg_ActionGridsHint        := '그리드 보임 / 숨김';
  TeeMsg_ActionGrids            := '그리드(&g)';
  TeeMsg_ActionLegendHint       := '범례 보임 / 숨김';
  TeeMsg_ActionLegend           := '범례(&l)';
  TeeMsg_ActionSeriesEditHint   := '계열 편집';
  TeeMsg_ActionSeriesMarksHint  := '계열 표식 보임 / 숨김';
  TeeMsg_ActionSeriesMarks      := '표식(&m)';
  TeeMsg_ActionSaveHint         := '차트 저장';
  TeeMsg_ActionSave             := '저장(&s)...';

  TeeMsg_CandleBar              := '막대';
  TeeMsg_CandleNoOpen           := '열리지 않음';
  TeeMsg_CandleNoClose          := '닫히지 않음';
  TeeMsg_NoHigh                 := '높지 않음';
  TeeMsg_NoLow                  := '낮지 않음';
  TeeMsg_ColorRange             := '색 범위';
  TeeMsg_WireFrame              := '뼈대';
  TeeMsg_DotFrame               := '점선 뼈대';
  TeeMsg_Positions              := '위치';
  TeeMsg_NoGrid                 := '그리드 없음';
  TeeMsg_NoPoint                := '포인트 없음';
  TeeMsg_NoLine                 := '선 없음';
  TeeMsg_Labels                 := '라벨';
  TeeMsg_NoCircle               := '원 없음';
  TeeMsg_Lines                  := '선';
  TeeMsg_Border                 := '테두리';

  TeeMsg_SmithResistance      := '저항력';
  TeeMsg_SmithReactance       := '리액턴스';

  TeeMsg_Column               := '컬럼';

  { 5.01 }
  TeeMsg_Separator            := '구분자';
  TeeMsg_FunnelSegment        := '구획 ';
  TeeMsg_FunnelSeries         := '깔때기';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := '할당 초과';
  TeeMsg_FunnelWithin         := ' 포함됨';
  TeeMsg_FunnelBelow          := ' 이거나 할당 미만';
  TeeMsg_CalendarSeries       := '달력형';
  TeeMsg_DeltaPointSeries     := '델타포인트형';
  TeeMsg_ImagePointSeries     := '이지미포인트형';
  TeeMsg_ImageBarSeries       := '이미지막대형';
  TeeMsg_SeriesTextFieldZero  := '계열 텍스트: 필드 인덱스는 0 보다 커야 합니다.';

  { 5.02 }
  TeeMsg_Origin               := '원본';
  TeeMsg_Transparency         := '투명도';
  TeeMsg_Box		      := '상자';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '페이지 번호';
  TeeMsg_TextFile             := '텍스트 파일';

  { 5.03 }
  TeeMsg_DragPoint            := '드래그 포인트';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

end;

Procedure TeeCreateKorean;
begin
  if not Assigned(TeeKoreanLanguage) then
  begin
    TeeKoreanLanguage:=TStringList.Create;
    TeeKoreanLanguage.Text:=

'LABELS=라벨'+#13+
'DATASET=데이터셋'+#13+
'ALL RIGHTS RESERVED.=ALL RIGHTS RESERVED.'+#13+
'APPLY=적용'+#13+
'CLOSE=닫기'+#13+
'OK=확인'+#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0 에 대하여'+#13+
'OPTIONS=옵션'+#13+
'FORMAT=형식'+#13+
'TEXT=텍스트'+#13+
'GRADIENT=변화'+#13+
'SHADOW=그림자'+#13+
'POSITION=위치'+#13+
'LEFT=왼쪽'+#13+
'TOP=위쪽'+#13+
'CUSTOM=사용자 정의'+#13+
'PEN=펜'+#13+
'PATTERN=무늬'+#13+
'SIZE=크기'+#13+
'BEVEL=기울기'+#13+
'INVERTED=역방향'+#13+
'INVERTED SCROLL=역 스크롤'+#13+
'BORDER=테두리'+#13+
'ORIGIN=원천'+#13+
'USE ORIGIN=시작 위치'+#13+
'AREA LINES=영역 선'+#13+
'AREA=영역'+#13+
'COLOR=색'+#13+
'SERIES=계열'+#13+
'SUM=합계'+#13+
'DAY=일'+#13+
'QUARTER=4분의 1'+#13+
'(MAX)=(최대)'+#13+
'(MIN)=(최소)'+#13+
'VISIBLE=보임'+#13+
'CURSOR=커서'+#13+
'GLOBAL=전역'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=수평 선'+#13+
'LABEL AND PERCENT=라벨과 백분율'+#13+
'LABEL AND VALUE=라벨과 값'+#13+
'LABEL AND PERCENT TOTAL=라벨과 백분율 총계'+#13+
'PERCENT TOTAL=백분율 총계'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=빼기'+#13+
'MULTIPLY=곱하기'+#13+
'DIVIDE=나누기'+#13+
'STAIRS=계단'+#13+
'MOMENTUM=추진력'+#13+
'AVERAGE=평균'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML 테이블'+#13+
'EXCEL=Excel'+#13+
'NONE=없음'+#13+
'(NONE)=없음'#13+
'WIDTH=너비'+#13+
'HEIGHT=높이'+#13+
'COLOR EACH=각각 다른 색'+#13+
'STACK=스택'+#13+
'STACKED=스택'+#13+
'STACKED 100%=스택 100%'+#13+
'AXIS=축'+#13+
'LENGTH=길이'+#13+
'CANCEL=취소'+#13+
'SCROLL=스크롤'+#13+
'INCREMENT=증가'+#13+
'VALUE=값'+#13+
'STYLE=스타일'+#13+
'JOIN=연결'+#13+
'AXIS INCREMENT=축 증가'+#13+
'AXIS MAXIMUM AND MINIMUM=축 최대와 최소'+#13+
'% BAR WIDTH=막대 너비 %'+#13+
'% BAR OFFSET=막대 오프셋 %'+#13+
'BAR SIDE MARGINS=막대 옆면 여백 만들기'+#13+
'AUTO MARK POSITION=자동 표식 위치'+#13+
'DARK BAR 3D SIDES=3D 막대 옆면 어둡게 만들기'+#13+
'MONOCHROME=흑백'+#13+
'COLORS=색'+#13+
'DEFAULT=기본값'+#13+
'MEDIAN=중앙'+#13+
'IMAGE=이미지'+#13+
'DAYS=날짜'+#13+
'WEEKDAYS=요일'+#13+
'TODAY=오늘'+#13+
'SUNDAY=일요일'+#13+
'MONTHS=월'+#13+
'LINES=선'+#13+
'UPPERCASE=대문자'+#13+
'STICK=막대모양'+#13+
'CANDLE WIDTH=막대 너비'+#13+
'BAR=막대'+#13+
'OPEN CLOSE=닫기 열기'+#13+
'DRAW 3D=3D 그리기'+#13+
'DARK 3D=어두운 3D'+#13+
'SHOW OPEN=열림 보임'+#13+
'SHOW CLOSE=닫기 보임'+#13+
'UP CLOSE=위쪽 닫힘'+#13+
'DOWN CLOSE=아랫쪽 닫힘'+#13+
'CIRCLED=원형'+#13+
'CIRCLE=원형'+#13+
'3 DIMENSIONS=3D'+#13+
'ROTATION=회전'+#13+
'RADIUS=반지름'+#13+
'HOURS=시간'+#13+
'HOUR=시간'+#13+
'MINUTES=분'+#13+
'SECONDS=초'+#13+
'FONT=글꼴'+#13+
'INSIDE=내부'+#13+
'ROTATED=회전'+#13+
'ROMAN=로마'+#13+
'TRANSPARENCY=투명도'+#13+
'DRAW BEHIND=뒷편에 그리기'+#13+
'RANGE=범위'+#13+
'PALETTE=팔레트'+#13+
'STEPS=단계'+#13+
'GRID=그리드'+#13+
'GRID SIZE=그리드 크기'+#13+
'ALLOW DRAG=드래그 활성화'+#13+
'AUTOMATIC=자동'+#13+
'LEVEL=단계'+#13+
'LEVELS POSITION=단계 위치'+#13+
'SNAP=스냅'+#13+
'FOLLOW MOUSE=마우스 따라다니기'+#13+
'TRANSPARENT=투명하게 하기'+#13+
'ROUND FRAME=둥굴게 하기'+#13+
'FRAME=뼈대'+#13+
'START=시작'+#13+
'END=끝'+#13+
'MIDDLE=중간'+#13+
'NO MIDDLE=중간값 없음'+#13+
'DIRECTION=방향'+#13+
'DATASOURCE=데이터 원천'+#13+
'AVAILABLE=가능한'+#13+
'SELECTED=선택된 것'+#13+
'CALC=계산'+#13+
'GROUP BY=GROUP BY'+#13+
'OF=OF'+#13+
'HOLE %=구멍 %'+#13+
'RESET POSITIONS=위치 초기화'+#13+
'MOUSE BUTTON=마우스 버튼'+#13+
'ENABLE DRAWING=그리기 가능'+#13+
'ENABLE SELECT=선택 가능'+#13+
'ORTHOGONAL=뒷쪽 고정'+#13+
'ANGLE=각도'+#13+
'ZOOM TEXT=줌 텍스트'+#13+
'PERSPECTIVE=원근감'+#13+
'ZOOM=줌'+#13+
'ELEVATION=높이'+#13+
'BEHIND=뒤에 위치'+#13+
'AXES=축'+#13+
'SCALES=단계'+#13+
'TITLE=제목'+#13+
'TICKS=표시'+#13+
'MINOR=작은 표시'+#13+
'CENTERED=중심으로'+#13+
'CENTER=가운데'+#13+
'PATTERN COLOR EDITOR=무늬 색 편집창'+#13+
'START VALUE=시작 값'+#13+
'END VALUE=마지막 값'+#13+
'COLOR MODE=색상 모드'+#13+
'LINE MODE=선 모드'+#13+
'HEIGHT 3D=3D 높이'+#13+
'OUTLINE=외곽선'+#13+
'PRINT PREVIEW=미리보기'+#13+
'ANIMATED=단계설정'+#13+
'ALLOW=활성화'+#13+
'DASH=단속선'+#13+
'DOT=점'+#13+
'DASH DOT DOT=단속선 점 점'+#13+
'PALE=엷은 색'+#13+
'STRONG=강렬한 색'+#13+
'WIDTH UNITS=너비 단위'+#13+
'FOOT=각주'+#13+
'SUBFOOT=부각주'+#13+
'SUBTITLE=부제목'+#13+
'LEGEND=범례'+#13+
'COLON=마침표'+#13+
'AXIS ORIGIN=원본 축'+#13+
'UNITS=단위'+#13+
'PYRAMID=피라미드형'+#13+
'DIAMOND=다이아몬드형'+#13+
'CUBE=정육면체형'+#13+
'TRIANGLE=삼각형'+#13+
'STAR=별형'+#13+
'SQUARE=정사각형'+#13+
'DOWN TRIANGLE=역삼각형'+#13+
'SMALL DOT=작은 점'+#13+
'LOAD=불러오기'+#13+
'FILE=파일'+#13+
'RECTANGLE=사각형'+#13+
'HEADER=헤더'+#13+
'CLEAR=지움'+#13+
'ONE HOUR=한 시간'+#13+
'ONE YEAR=일 년'+#13+
'ELLIPSE=타원형'+#13+
'CONE=콘'+#13+
'ARROW=화살표'+#13+
'CYLLINDER=원기둥'+#13+
'TIME=시간'+#13+
'BRUSH=브러쉬'+#13+
'LINE=선'+#13+
'VERTICAL LINE=수직 선'+#13+
'AXIS ARROWS=축 화살표'+#13+
'MARK TIPS=힌트 표식'+#13+
'DASH DOT=단속선 점'+#13+
'COLOR BAND=색상 띠'+#13+
'COLOR LINE=색선'+#13+
'INVERT. TRIANGLE=역삼각형'+#13+
'INVERT. PYRAMID=역피라미드'+#13+
'INVERTED PYRAMID=역피라미드'+#13+
'SERIES DATASOURCE TEXT EDITOR=계열 데이터 원천 편집창'+#13+
'SOLID=선'+#13+
'WIREFRAME=뼈대'+#13+
'DOTFRAME=점선 뼈대'+#13+
'SIDE BRUSH=옆면 브러쉬'+#13+
'SIDE=측면'+#13+
'SIDE ALL=계열 측면'+#13+
'ROTATE=회전'+#13+
'SMOOTH PALETTE=부드러운 팔레트'+#13+
'CHART TOOLS GALLERY=차트 도구 모음'+#13+
'ADD=더하기'+#13+
'BORDER EDITOR=테두리 편집창'+#13+
'DRAWING MODE=그리기 모드'+#13+
'CLOSE CIRCLE=폐구간'+#13+
'PICTURE=그림'+#13+
'NATIVE=정보'+#13+
'DATA=데이터'+#13+
'KEEP ASPECT RATIO=형태 비율 고정'+#13+
'COPY=복사'+#13+
'SAVE=저장'+#13+
'SEND=보냄'+#13+
'INCLUDE SERIES DATA=계열 데이터 포함'+#13+
'FILE SIZE=파일 크기'+#13+
'INCLUDE=포함'+#13+
'POINT INDEX=포인트 인덱스'+#13+
'POINT LABELS=포인트 라벨'+#13+
'DELIMITER=구분자'+#13+
'DEPTH=깊이'+#13+
'COMPRESSION LEVEL=압축 수준'+#13+
'COMPRESSION=압축'+#13+
'PATTERNS=무늬'+#13+
'LABEL=라벨'+#13+
'GROUP SLICES=그룹 조각'+#13+
'EXPLODE BIGGEST=가장 큰 것 분리'+#13+
'TOTAL ANGLE=전체 각도'+#13+
'HORIZ. SIZE=수평 크기'+#13+
'VERT. SIZE=수직 크기'+#13+
'SHAPES=형태'+#13+
'INFLATE MARGINS=여백 팽창'+#13+
'QUALITY=품질'+#13+
'SPEED=속도'+#13+
'% QUALITY=% 수량'+#13+
'GRAY SCALE=회색톤'+#13+
'PERFORMANCE=성능'+#13+
'BROWSE=찾아보기'+#13+
'TILED=바둑판식'+#13+
'HIGH=높음'+#13+
'LOW=낮음'+#13+
'DATABASE CHART=데이터베이스 차트'+#13+
'NON DATABASE CHART=일반 차트'+#13+
'HELP=도움말'+#13+
'NEXT >=다음 >'+#13+
'< BACK=< 이전'+#13+
'TEECHART WIZARD=차트 마법사'+#13+
'PERCENT=백분율'+#13+
'PIXELS=픽셀'+#13+
'ERROR WIDTH=에러 너비'+#13+
'ENHANCED=향상'+#13+
'VISIBLE WALLS=벽면 보임'+#13+
'ACTIVE=활성화'+#13+
'DELETE=지움'+#13+
'ALIGNMENT=정렬'+#13+
'ADJUST FRAME=뼈대 맞춤'+#13+
'HORIZONTAL=수평'+#13+
'VERTICAL=수직'+#13+
'VERTICAL POSITION=수직 위치'+#13+
'NUMBER=수'+#13+
'LEVELS=수준'+#13+
'OVERLAP=겹치기'+#13+
'STACK 100%=스택 100%'+#13+
'MOVE=이동'+#13+
'CLICK=클릭'+#13+
'DELAY=지연'+#13+
'DRAW LINE=선 그리기'+#13+
'FUNCTIONS=함수'+#13+
'SOURCE SERIES=원천 계열'+#13+
'ABOVE=위에'+#13+
'BELOW=아래'+#13+
'Dif. Limit=한계 차이'+#13+
'WITHIN=안에'+#13+
'EXTENDED=확장'+#13+
'STANDARD=표준'+#13+
'STATS=상태'+#13+
'FINANCIAL=경제'+#13+
'OTHER=기타'+#13+
'TEECHART GALLERY=차트 모음'+#13+
'CONNECTING LINES=선 연결'+#13+
'REDUCTION=축소'+#13+
'LIGHT=조명'+#13+
'INTENSITY=강도'+#13+
'FONT OUTLINES=글꼴 외각선'+#13+
'SMOOTH SHADING=부드러운 음영'+#13+
'AMBIENT LIGHT=주위색'+#13+
'MOUSE ACTION=마우스 동작'+#13+
'CLOCKWISE=시계 방향'+#13+
'ANGLE INCREMENT=각도 증가'+#13+
'RADIUS INCREMENT=반지름 증가'+#13+
'PRINTER=프린터'+#13+
'SETUP=설정'+#13+
'ORIENTATION=방향'+#13+
'PORTRAIT=세로'+#13+
'LANDSCAPE=가로'+#13+
'MARGINS (%)=여백 (%)'+#13+
'MARGINS=여백'+#13+
'DETAIL=세부설정'+#13+
'MORE=섬세함'+#13+
'PROPORTIONAL=비례 맞추기'+#13+
'VIEW MARGINS=여백 보기'+#13+
'RESET MARGINS=여백 초기화'+#13+
'PRINT=출력'+#13+
'TEEPREVIEW EDITOR=미리보기 편집창'+#13+
'ALLOW MOVE=움직이기 활성화'+#13+
'ALLOW RESIZE=크기조정 활성화'+#13+
'SHOW IMAGE=출력이미지 보기'+#13+
'DRAG IMAGE=출력이미지 변경'+#13+
'AS BITMAP=비트맵으로'+#13+
'SIZE %=크기 %'+#13+
'FIELDS=필드'+#13+
'SOURCE=원천'+#13+
'SEPARATOR=구분자'+#13+
'NUMBER OF HEADER LINES=헤더 라인 수'+#13+
'COMMA=쉼표'+#13+
'EDITING=편집'+#13+
'TAB=탭'+#13+
'SPACE=공백'+#13+
'ROUND RECTANGLE=둥근 사각형'+#13+
'BOTTOM=아래쪽'+#13+
'RIGHT=오른쪽'+#13+
'C PEN=C 펜'+#13+
'R PEN=R 펜'+#13+
'C LABELS=C 라벨'+#13+
'R LABELS=R 라벨'+#13+
'MULTIPLE BAR=다중 막대'+#13+
'MULTIPLE AREAS=다중 영역'+#13+
'STACK GROUP=스택 그룹'+#13+
'BOTH=양쪽'+#13+
'BACK DIAGONAL=역대각선'+#13+
'B.DIAGONAL=역대각선'+#13+
'DIAG.CROSS=격자 대각선'+#13+
'WHISKER=세선'+#13+
'CROSS=격자'+#13+
'DIAGONAL CROSS=격자 대각선'+#13+
'LEFT RIGHT=왼쪽 오른쪽'+#13+
'RIGHT LEFT=오른쪽 왼쪽'+#13+
'FROM CENTER=중앙으로부터'+#13+
'FROM TOP LEFT=위에서 왼쪽으로'+#13+
'FROM BOTTOM LEFT=아래에서 왼쪽으로'+#13+
'SHOW WEEKDAYS=요일 보기'+#13+
'SHOW MONTHS=월 보기'+#13+
'SHOW PREVIOUS BUTTON=이전 버튼 보기'#13+
'SHOW NEXT BUTTON=다음 버튼 보기'#13+
'TRAILING DAYS=남은 날 보기'+#13+
'SHOW TODAY=오늘 보기'+#13+
'TRAILING=남은 날'+#13+
'LOWERED=아래쪽'+#13+
'RAISED=윗쪽'+#13+
'HORIZ. OFFSET=수평 오프셋'+#13+
'VERT. OFFSET=수직 오프셋'+#13+
'INNER=내부'+#13+
'LEN=길이'+#13+
'AT LABELS ONLY=라벨만 나옴'+#13+
'MAXIMUM=최대값'+#13+
'MINIMUM=최소값'+#13+
'CHANGE=변경'+#13+
'LOGARITHMIC=로그화'+#13+
'LOG BASE=로그 밑수'+#13+
'DESIRED INCREMENT=원하는 증가치'+#13+
'(INCREMENT)=(증가)'+#13+
'MULTI-LINE=다중 라인'+#13+
'MULTI LINE=다중 라인'+#13+
'RESIZE CHART=겹치지 않음'+#13+
'X AND PERCENT=X와 백분율'+#13+
'X AND VALUE=X와 값'+#13+
'RIGHT PERCENT=오른쪽 백분율'+#13+
'LEFT PERCENT=왼쪽 백분율'+#13+
'LEFT VALUE=왼쪽 값'+#13+
'RIGHT VALUE=오른쪽 값'+#13+
'PLAIN=간단히'+#13+
'LAST VALUES=최종 값'+#13+
'SERIES VALUES=계열 값'+#13+
'SERIES NAMES=계열 이름'+#13+
'NEW=새로 만들기'+#13+
'EDIT=편집'+#13+
'PANEL COLOR=패널 색'+#13+
'TOP BOTTOM=위 아래'+#13+
'BOTTOM TOP=아래 위'+#13+
'DEFAULT ALIGNMENT=기본 정렬'+#13+
'EXPONENTIAL=지수'+#13+
'LABELS FORMAT=라벨 형식'+#13+
'MIN. SEPARATION %=최소 분리선 %'+#13+
'YEAR=년'+#13+
'MONTH=월'+#13+
'WEEK=주'+#13+
'WEEKDAY=요일'+#13+
'MARK=표식'+#13+
'ROUND FIRST=정수형 보기'+#13+
'LABEL ON AXIS=축위 라벨'+#13+
'COUNT=개수'+#13+
'POSITION %=위치 %'+#13+
'START %=시작 %'+#13+
'END %=끝 %'+#13+
'OTHER SIDE=반대편'+#13+
'INTER-CHAR SPACING=문자 사이 공간'+#13+
'VERT. SPACING=문자 수직 공간'+#13+
'POSITION OFFSET %=위치 오프셋 %'+#13+
'GENERAL=일반'+#13+
'MANUAL=수동'+#13+
'PERSISTENT=불변'+#13+
'PANEL=패널'+#13+
'ALIAS=별칭'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=OpenGL 편집창'+#13+
'FONT 3D DEPTH=3D 글꼴'+#13+
'NORMAL=표준'+#13+
'TEEFONT EDITOR=글꼴 편집창'+#13+
'CLIP POINTS=고정 포인트'+#13+
'CLIPPED=고정'+#13+
'3D %=3D %'+#13+
'QUANTIZE=양자화'+#13+
'QUANTIZE 256=양자화 256'+#13+
'DITHER=축소'+#13+
'VERTICAL SMALL=작은 수직'+#13+
'HORIZ. SMALL=작은 수평'+#13+
'DIAG. SMALL=작은 대각선'+#13+
'BACK DIAG. SMALL=작은 역대각선'+#13+
'DIAG. CROSS SMALL=작은 대각선 격자'+#13+
'MINIMUM PIXELS=최소 픽셀'+#13+
'ALLOW SCROLL=스크롤 활성화'+#13+
'SWAP=교환'+#13+
'GRADIENT EDITOR=변화 편집창'+#13+
'TEXT STYLE=텍스트 스타일'+#13+
'DIVIDING LINES=선으로 구별하기'+#13+
'SYMBOLS=기호'+#13+
'CHECK BOXES=체크 상자'+#13+
'FONT SERIES COLOR=계열 색상 적용'+#13+
'LEGEND STYLE=범례 스타일'+#13+
'POINTS PER PAGE=페이지당 포인터 수'+#13+
'SCALE LAST PAGE=마지막 페이지 크기 맞춤'+#13+
'CURRENT PAGE LEGEND=현재 페이지 범례'+#13+
'BACKGROUND=배경'+#13+
'BACK IMAGE=배경 이미지'+#13+
'STRETCH=늘이기'+#13+
'TILE=바둑판식'+#13+
'BORDERS=경계'+#13+
'CALCULATE EVERY=전체 계산'+#13+
'NUMBER OF POINTS=포인트 개수'+#13+
'RANGE OF VALUES=값 범위'+#13+
'FIRST=맨 앞'+#13+
'LAST=맨 끝'+#13+
'ALL POINTS=모든 포인트'+#13+
'DATA SOURCE=데이터 원천'+#13+
'WALLS=벽면'+#13+
'PAGING=페이지'+#13+
'CLONE=복제'+#13+
'TITLES=제목'+#13+
'TOOLS=도구'+#13+
'EXPORT=내보내기'+#13+
'CHART=차트'+#13+
'BACK=뒤로'+#13+
'LEFT AND RIGHT=왼쪽 오른쪽'+#13+
'SELECT A CHART STYLE=차트 스타일을 선택하세요'+#13+
'SELECT A DATABASE TABLE=데이터베이스 테이블을 선택하세요'+#13+
'TABLE=테이블'+#13+
'SELECT THE DESIRED FIELDS TO CHART=차트로 보여주고 싶은 필드를 선택하세요'+#13+
'SELECT A TEXT LABELS FIELD=텍스트 라벨 필드를 선택하세요'+#13+
'CHOOSE THE DESIRED CHART TYPE=원하는 차트 형태를 선택하세요'+#13+
'CHART PREVIEW=차트 미리보기'+#13+
'SHOW LEGEND=범례 보기'+#13+
'SHOW MARKS=표식 보기'+#13+
'FINISH=종료'+#13+
'RANDOM=임의수'+#13+
'DRAW EVERY=그리기 간격'+#13+
'ARROWS=보조선'+#13+
'ASCENDING=오름차순'+#13+
'DESCENDING=내림차순'+#13+
'VERTICAL AXIS=수직 축'+#13+
'DATETIME=일시'+#13+
'TOP AND BOTTOM=위 아래'+#13+
'HORIZONTAL AXIS=수평 축'+#13+
'PERCENTS=백분율'+#13+
'VALUES=값'+#13+
'FORMATS=형식'+#13+
'SHOW IN LEGEND=범례 안에 보이기'+#13+
'SORT=정렬'+#13+
'MARKS=표식'+#13+
'BEVEL INNER=기울기 안'+#13+
'BEVEL OUTER=기울기 밖'+#13+
'PANEL EDITOR=패널 편집창'+#13+
'CONTINUOUS=연속 보기'+#13+
'HORIZ. ALIGNMENT=수평 정렬'+#13+
'EXPORT CHART=차트 내보내기'+#13+
'BELOW %=하위 %'+#13+
'BELOW VALUE=하위 값'+#13+
'NEAREST POINT=근처 포인트'+#13+
'DRAG MARKS=표식 드래그'+#13+
'TEECHART PRINT PREVIEW=차트 출력 미리보기'+#13+
'X VALUE=X 값'+#13+
'X AND Y VALUES=X와 Y 값'+#13+
'SHININESS=밝게'+#13+
'ALL SERIES VISIBLE=모든 계열 보임'+#13+
'MARGIN=여백'+#13+
'DIAGONAL=대각선'+#13+
'LEFT TOP=좌측 위'+#13+
'LEFT BOTTOM=좌측 아래'+#13+
'RIGHT TOP=우측 위'+#13+
'RIGHT BOTTOM=우측 아래'+#13+
'EXACT DATE TIME=정밀 시간'+#13+
'RECT. GRADIENT=사각 변화'+#13+
'CROSS SMALL=작은 십자'+#13+
'AVG=평균치'+#13+
'FUNCTION=함수'+#13+
'AUTO=자동'+#13+
'ONE MILLISECOND=천분의 1초'+#13+
'ONE SECOND=1 초'+#13+
'FIVE SECONDS=5 초'+#13+
'TEN SECONDS=10 초'+#13+
'FIFTEEN SECONDS=15 초'+#13+
'THIRTY SECONDS=30 초'+#13+
'ONE MINUTE=1 분'+#13+
'FIVE MINUTES=5 분'+#13+
'TEN MINUTES=10 분'+#13+
'FIFTEEN MINUTES=15 분'+#13+
'THIRTY MINUTES=30 분'+#13+
'TWO HOURS=2 시간'+#13+
'TWO HOURS=2 시간'+#13+
'SIX HOURS=6 시간'+#13+
'TWELVE HOURS=12 시간'+#13+
'ONE DAY=하루'+#13+
'TWO DAYS=이틀'+#13+
'THREE DAYS=삼일'+#13+
'ONE WEEK=한 주'+#13+
'HALF MONTH=보름'+#13+
'ONE MONTH=1 개월'+#13+
'TWO MONTHS=2 개월'+#13+
'THREE MONTHS=3 개월'+#13+
'FOUR MONTHS=4 개월'+#13+
'SIX MONTHS=6 개월'+#13+
'IRREGULAR=불규칙'+#13+
'CLICKABLE=클릭가능'+#13+
'ROUND=둥글게'+#13+
'FLAT=평평하게'+#13+
'PIE=원형'+#13+
'HORIZ. BAR=수평 막대형'+#13+
'BUBBLE=거품형'+#13+
'SHAPE=도형형'+#13+
'POINT=포인트형'+#13+
'FAST LINE=앏은 선형'+#13+
'CANDLE=주식막대형'+#13+
'VOLUME=얇은 세로막대형'+#13+
'HORIZ LINE=수평 선형'+#13+
'SURFACE=표면형'+#13+
'LEFT AXIS=외쪽 축'+#13+
'RIGHT AXIS=오른쪽 축'+#13+
'TOP AXIS=상위 축'+#13+
'BOTTOM AXIS=하위 축'+#13+
'CHANGE SERIES TITLE=계열 제목 바꾸기'+#13+
'DELETE %S ?=%s 을(를) 지우겠습니까?'+#13+
'DESIRED %S INCREMENT=원하는 %s 증가치'+#13+
'INCORRECT VALUE. REASON: %S=잘못된 값입니다. 이유: %s'+#13+
'FillSampleValues NumValues must be > 0=샘플값채우기의 값은 0 이상입니다.'#13+
'VISIT OUR WEB SITE !=홈페이지에 접속하기 바랍니다!'#13+
'SHOW PAGE NUMBER=페이지 번호 보기'#13+
'PAGE NUMBER=페이지 번호'#13+
'PAGE %D OF %D=페이지 %d / %d'#13+
'TEECHART LANGUAGES=차트 언어'#13+
'CHOOSE A LANGUAGE=언어 선택'+#13+
'SELECT ALL=모두 선택'#13+
'MOVE UP=위로 이동'#13+
'MOVE DOWN=아래로 이동'#13+
'DRAW ALL=전체 그리기'#13+
'TEXT FILE=텍스트 파일'#13+
'IMAG. SYMBOL=이미지 기호'#13+
'DRAG REPAINT=다시 그리기'#13+
'NO LIMIT DRAG=끌기 제한 없음'
;
  end;
end;

Procedure TeeSetKorean;
begin
  TeeCreateKorean;
  TeeLanguage:=TeeKoreanLanguage;
  TeeKoreanConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeKoreanLanguage);
end.


