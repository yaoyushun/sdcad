unit TeeGalician;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeGalicianLanguage:TStringList=nil;

Procedure TeeSetGalician;
Procedure TeeCreateGalician;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeGalicianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 por David Berneda';
  TeeMsg_LegendFirstValue   :='O índice do primeiro valor da lenda debe ser> 0';
  TeeMsg_LegendColorWidth   :='Ancho da cor da lenda > 0%';
  TeeMsg_SeriesSetDataSource:='Non hai Gráfico pai para validar o Orixe de datos';
  TeeMsg_SeriesInvDataSource:='Orixe de datos non válido: %s';
  TeeMsg_FillSample         :='Rechear valores exemplo, número de valores debe ser > 0';
  TeeMsg_AxisLogDateTime    :='Eixo Data/Hora non pode ser Logarítmico';
  TeeMsg_AxisLogNotPositive :='Valores Min. e Max. do Eixo Logarítmico deben ser >= 0';
  TeeMsg_AxisLabelSep       :='% Separación de etiquetas debe ser > 0';
  TeeMsg_AxisIncrementNeg   :='Incremento do eixo debe ser >= 0';
  TeeMsg_AxisMinMax         :='Valor mínimo do eixo debe ser <= Mínimo';
  TeeMsg_AxisMaxMin         :='Valor máximo de eixo debe ser >= Mínimo';
  TeeMsg_AxisLogBase        :='Base do eixo logarítmico debe ser >= 2';
  TeeMsg_MaxPointsPerPage   :='Número de puntos por páxina debe ser >= 0';
  TeeMsg_3dPercent          :='% Efecto 3D debe estar entre %d e %d';
  TeeMsg_CircularSeries     :='Non se permiten referencias circulares de Series';
  TeeMsg_WarningHiColor     :='Para unha mellor visualización requirese cor de 16k';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Título Eixo';
  TeeMsg_AxisLabels         :='Etiquetas Eixo';
  TeeMsg_RefreshInterval    :='O Intervalo de refresco debe estar entre 0 e 60';
  TeeMsg_SeriesParentNoSelf :='¡O Series.ParentChart non son eu!';
  TeeMsg_GalleryLine        :='Línea';
  TeeMsg_GalleryPoint       :='Punto';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Barra';
  TeeMsg_GalleryHorizBar    :='Barra Horiz.';
  TeeMsg_Stack              :='Apilado';
  TeeMsg_GalleryPie         :='Pastel';
  TeeMsg_GalleryCircled     :='Circular';
  TeeMsg_GalleryFastLine    :='Línea rápida';
  TeeMsg_GalleryHorizLine   :='Línea Horiz.';

  TeeMsg_PieSample1         :='Coches';
  TeeMsg_PieSample2         :='Teléfonos';
  TeeMsg_PieSample3         :='Tablas';
  TeeMsg_PieSample4         :='Monitores';
  TeeMsg_PieSample5         :='Lámparas';
  TeeMsg_PieSample6         :='Teclados';
  TeeMsg_PieSample7         :='Bicis';
  TeeMsg_PieSample8         :='Sillas';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editando %s';

  TeeMsg_GalleryStandard    :='Estandard';
  TeeMsg_GalleryExtended    :='Extendidas';
  TeeMsg_GalleryFunctions   :='Funcions';

  TeeMsg_EditChart          :='E&ditar Gráfico...';
  TeeMsg_PrintPreview       :='&Previsualizar...';
  TeeMsg_ExportChart        :='E&xportar Gráfico...';
  TeeMsg_CustomAxes         :='Eixos Personalizados...';

  TeeMsg_InvalidEditorClass :='%s: Clase Editor non válida: %s';
  TeeMsg_MissingEditorClass :='%s: no ten cadro de edición';

  TeeMsg_GalleryArrow       :='Flecha';

  TeeMsg_ExpFinish          :='&Finalizar';
  TeeMsg_ExpNext            :='&Seguinte >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Deseño';
  TeeMsg_GanttSample2       :='Prototipo';
  TeeMsg_GanttSample3       :='Desenvolvemento';
  TeeMsg_GanttSample4       :='Ventas';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testear';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugando';
  TeeMsg_GanttSample9       :='Nova Versión';
  TeeMsg_GanttSample10      :='Finanzas';

  TeeMsg_ChangeSeriesTitle  :='Trocar Título das Series';
  TeeMsg_NewSeriesTitle     :='Novo Título da Serie:';
  TeeMsg_DateTime           :='Data/Hora';
  TeeMsg_TopAxis            :='Eixo superior';
  TeeMsg_BottomAxis         :='Eixo inferior';
  TeeMsg_LeftAxis           :='Eixo esquerdo';
  TeeMsg_RightAxis          :='Eixo dereito';

  TeeMsg_SureToDelete       :='¿Eliminar  %s?';
  TeeMsg_DateTimeFormat     :='For&mato Data/Hora:';
  TeeMsg_Default            :='Defecto';
  TeeMsg_ValuesFormat       :='For&mato Valores:';
  TeeMsg_Maximum            :='Máximo';
  TeeMsg_Minimum            :='Mínimo';
  TeeMsg_DesiredIncrement   :='Incremento Deseado %s';

  TeeMsg_IncorrectMaxMinValue:='Valor incorrecto. %s';
  TeeMsg_EnterDateTime      :='Introduzca [Nº de días] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='¿Aplicar cambios?';
  TeeMsg_SelectedSeries     :='(Series Seleccionadas)';
  TeeMsg_RefreshData        :='&Refrescar datos';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='419';
  TeeMsg_FunctionAdd        :='Sumar';
  TeeMsg_FunctionSubtract   :='Restar';
  TeeMsg_FunctionMultiply   :='Multiplicar';
  TeeMsg_FunctionDivide     :='Dividir';
  TeeMsg_FunctionHigh       :='Alto';
  TeeMsg_FunctionLow        :='Baixo';
  TeeMsg_FunctionAverage    :='Media';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Burbullas';
  TeeMsg_FunctionNone       :='Copiar';

  TeeMsg_None               :='(ningún)';

  TeeMsg_PrivateDeclarations:='{ Declaracions privadas }';
  TeeMsg_PublicDeclarations :='{ Declaracions públicas }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Tamaño do punteiro debe ser maior que cero';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_About              :='&Sobre o TeeChart...';

  TeeMsg_DataSet            :='Tabla/consulta';
  TeeMsg_AskDataSet         :='&Tabla/consulta:';

  TeeMsg_SingleRecord       :='Rexistro único';
  TeeMsg_AskDataSource      :='Orixe de &datos:';

  TeeMsg_Summary            :='Sumario';

  TeeMsg_FunctionPeriod     :='O periodo da función debe ser >= 0';

  TeeMsg_TeeChartWizard     :='Asistente TeeChart';

  TeeMsg_ClearImage         :='Quita&r';
  TeeMsg_BrowseImage        :='&Abrir...';

  TeeMsg_WizardSureToClose  :='¿Está seguro de pechar o Asistente TeeChart?';
  TeeMsg_FieldNotFound      :='O campo %s non existe';

  TeeMsg_DepthAxis          :='Eixo Prof.';
  TeeMsg_PieOther           :='Outro';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pastel';
  TeeMsg_ValuesBar          :='Barra';
  TeeMsg_ValuesAngle        :='Angulo';
  TeeMsg_ValuesGanttStart   :='Comenzo';
  TeeMsg_ValuesGanttEnd     :='Fin';
  TeeMsg_ValuesGanttNextTask:='ProxTarea';
  TeeMsg_ValuesBubbleRadius :='Radio';
  TeeMsg_ValuesArrowEndX    :='Fin X';
  TeeMsg_ValuesArrowEndY    :='Fin Y';
  TeeMsg_Legend             :='Lenda';
  TeeMsg_Title              :='Título';
  TeeMsg_Foot               :='Pie';
  TeeMsg_Period		    :='Periodo';
  TeeMsg_PeriodRange        :='Rango Periodo';
  TeeMsg_CalcPeriod         :='Calcular %s cada:';
  TeeMsg_SmallDotsPen       :='Puntitos';

  TeeMsg_InvalidTeeFile     :='Gráfico non válido en archivo *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Formato do archivo *.'+TeeMsg_TeeExtension+' incorrecto';
  TeeMsg_EmptyTeeFile       :='Archivo *.'+TeeMsg_TeeExtension+' valeiro';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Eixos Gráfico';
  TeeMsg_ChartAxesCategoryDesc   := 'Propiedades e Eventos de Eixos';
  TeeMsg_ChartWallsCategoryName  := 'Paredes do Gráfico';
  TeeMsg_ChartWallsCategoryDesc  := 'Propiedades e Eventos da parede do gráfico';
  TeeMsg_ChartTitlesCategoryName := 'Títulos do Gráfico';
  TeeMsg_ChartTitlesCategoryDesc := 'Eventos e propiedades do título do gráfico';
  TeeMsg_Chart3DCategoryName     := 'Gráfico 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Propiedades e eventos do gráfico 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalizado ';
  TeeMsg_Series                 :='Series';
  TeeMsg_SeriesList             :='Series...';

  TeeMsg_PageOfPages            :='Páxina %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primeiro';
  TeeMsg_Prior  :='Anterior';
  TeeMsg_Next   :='Seguinte';
  TeeMsg_Last   :='Último';
  TeeMsg_Insert :='Insertar';
  TeeMsg_Delete :='Eliminar';
  TeeMsg_Edit   :='Editar';
  TeeMsg_Post   :='Gardar';
  TeeMsg_Cancel :='Cancelar';

  TeeMsg_All    :='(todas)'; {las series}
  TeeMsg_Index  :='Indice';
  TeeMsg_Text   :='Texto';

  TeeMsg_AsBMP        :='como &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='como &Metafile';
  TeeMsg_EMFFilter    :='Metafiles mellorados (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'A propiedade Panel non está asignada.';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Sin Borde';
  TeeMsg_Dotted    :='Puntos';
  TeeMsg_Colors    :='Cores';
  TeeMsg_Filled    :='Recheo';
  TeeMsg_Marks     :='Marcas';
  TeeMsg_Stairs    :='Escaleiras';
  TeeMsg_Points    :='Puntos';
  TeeMsg_Height    :='Altura';
  TeeMsg_Hollow    :='Hueco';
  TeeMsg_Point2D   :='Punto 2D';
  TeeMsg_Triangle  :='Triángulos';
  TeeMsg_Star      :='Estrela';
  TeeMsg_Circle    :='Circulo';
  TeeMsg_DownTri   :='Tri. Baixo';
  TeeMsg_Cross     :='Cruz';
  TeeMsg_Diamond   :='Diamante';
  TeeMsg_NoLines   :='Sin líneas';
  TeeMsg_Stack100  :='Apilado 100%';
  TeeMsg_Pyramid   :='Pirámide';
  TeeMsg_Ellipse   :='Elipse';
  TeeMsg_InvPyramid:='Pirámide Inv.';
  TeeMsg_Sides     :='Caras';
  TeeMsg_SideAll   :='Todas as caras';
  TeeMsg_Patterns  :='Patrones';
  TeeMsg_Exploded  :='Expandido';
  TeeMsg_Shadow    :='Sombra';
  TeeMsg_SemiPie   :='Semi Tarta';
  TeeMsg_Rectangle :='Rectángulo';
  TeeMsg_VertLine  :='Lín.Vert.';
  TeeMsg_HorizLine :='Lín.Horiz.';
  TeeMsg_Line      :='Línea';
  TeeMsg_Cube      :='Cubo';
  TeeMsg_DiagCross :='Aspa';

  TeeMsg_CanNotFindTempPath    :='Non se pode localizar a carpeta Temp';
  TeeMsg_CanNotCreateTempChart :='Non se pode crear archivo Temp';
  TeeMsg_CanNotEmailChart      :='Non se pode enviar Gráfico por correo elec. Error Mapi: %d';

  TeeMsg_SeriesDelete :='Borrar Series: Indice de Series fora dos límites %d (0 a %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Linguaxe...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Vela';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Superfície';
  TeeMsg_GalleryContour     :='Contorno';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Puntos 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Barras 3D';
  TeeMsg_GalleryBigCandle   :='Vela Grande';
  TeeMsg_GalleryLinePoint   :='Punto Línea';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Caida de Auga';
  TeeMsg_GalleryWindRose    :='Rosa dos Ventos';
  TeeMsg_GalleryClock       :='Reloxo';
  TeeMsg_GalleryColorGrid   :='Rella de Cor';
  TeeMsg_GalleryBoxPlot     :='Esquema Vertical';
  TeeMsg_GalleryHorizBoxPlot:='Esquema Horizontal';
  TeeMsg_GalleryBarJoin     :='Union de Barras';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pirámide';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange     :='O grado polinomial debe estar entre 1 e 20';
  TeeMsg_AnswerVectorIndex   :='O índice da matriz de vectores debe estar entre 1 e %d';
  TeeMsg_FittingError        :='Non é posible calcular a axuste';
  TeeMsg_PeriodRange         :='O periodo debe ser >= 0';
  TeeMsg_ExpAverageWeight    :='Peso de Promedio Exp. debe estar entre 0 e 1';
  TeeMsg_GalleryErrorBar     :='Barras de Error';
  TeeMsg_GalleryError        :='Error';
  TeeMsg_GalleryHighLow      :='Alto-Baixo';
  TeeMsg_FunctionMomentum    :='Momento';
  TeeMsg_FunctionMomentumDiv :='Mom. División';
  TeeMsg_FunctionExpAverage  :='Promedio Exp.';
  TeeMsg_FunctionMovingAverage:='Media Móbil';
  TeeMsg_FunctionExpMovAve   :='Media Móbil Exp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Axuste á Curva';
  TeeMsg_FunctionTrend       :='Tendencia';
  TeeMsg_FunctionExpTrend    :='Tendencia Exp.';
  TeeMsg_FunctionLogTrend    :='Tendencia Logarítm.';
  TeeMsg_FunctionCumulative  :='Acumular';
  TeeMsg_FunctionStdDeviation:='Desviación Estand.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Raiz Media Cuad.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Estocástico';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Contar';
  TeeMsg_LoadChart           :='Abrir TeeChart...';
  TeeMsg_SaveChart           :='Gardar TeeChart...';
  TeeMsg_TeeFiles            :='Archivos TeeChart Pro';

  TeeMsg_GallerySamples      :='Outras';
  TeeMsg_GalleryStats        :='Estadísticas';

  TeeMsg_CannotFindEditor    :='Non podo localizar o formulario %s';

  TeeMsg_CannotLoadChartFromURL:='Código de error: %d descargando gráfico da Web: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Código de error: %d descargando datos de series da Web: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Apertura';
  TeeMsg_ValuesHigh          :='Alto';
  TeeMsg_ValuesLow           :='Baixo';
  TeeMsg_ValuesClose         :='Peche';
  TeeMsg_ValuesOffset        :='Desplazar';
  TeeMsg_ValuesStdError      :='Error Est.';

  TeeMsg_Grid3D              :='Rella3D';

  TeeMsg_LowBezierPoints     :='O Número de puntos Bezier debe ser > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Editar';
  TeeCommanMsg_Print    :='Imprimir';
  TeeCommanMsg_Copy     :='Copiar';
  TeeCommanMsg_Save     :='Gardar';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotación: %d° Elevación: %d°';
  TeeCommanMsg_Rotate   :='Rotar';

  TeeCommanMsg_Moving   :='Desp.Horiz.: %d Desp.Vert.: %d';
  TeeCommanMsg_Move     :='Mover';

  TeeCommanMsg_Zooming  :='Ampliar: %d %%';
  TeeCommanMsg_Zoom     :='Ampliar';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Profondidade'; { 5.01 }

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Arrastrar %s para Rotar'; { 5.01 }
  TeeCommanMsg_MoveLabel  :='Arrastrar %s para Mover'; { 5.01 }
  TeeCommanMsg_ZoomLabel  :='Arrastrar %s para Zoom'; { 5.01 }
  TeeCommanMsg_DepthLabel :='Arrastrar %s para Profundidad 3D'; { 5.01 }

  TeeCommanMsg_NormalLabel:='Arrastrar botón esq. para ampliar, der. para desplazar';
  TeeCommanMsg_NormalPieLabel:='Arrastrar Porción do Pastel para expandir.';

  TeeCommanMsg_PieExploding := 'Porción: %d Expandida: %d %%';

  TeeMsg_TriSurfaceLess:='O Número de puntos debe ser >= 4';
  TeeMsg_TriSurfaceAllColinear:='Todos os puntos estan alineados.';
  TeeMsg_TriSurfaceSimilar:='Puntos similares - non se poden calcular triángulos.';
  TeeMsg_GalleryTriSurface:='Sup. Triáng.';

  TeeMsg_AllSeries := 'Todas as Series';
  TeeMsg_Edit      := 'Editar';

  TeeMsg_GalleryFinancial    :='Financieiras';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Arrastrar Marcas'; { 5.01 }
  TeeMsg_AxisArrowTool :='Flechas en Eixos';
  TeeMsg_DrawLineTool  :='Debuxar Líneas';
  TeeMsg_NearestTool   :='Punto máis cercano';
  TeeMsg_ColorBandTool :='Bandas de cor';
  TeeMsg_ColorLineTool :='Líneas de cor';
  TeeMsg_RotateTool    :='Rotar';
  TeeMsg_ImageTool     :='Imaxe';
  TeeMsg_MarksTipTool  :='Marcas';
  TeeMsg_AnnotationTool:='Anotación';

  TeeMsg_CantDeleteAncestor  :='Non podo eliminar o componente heredado. (Ancestor)';

  TeeMsg_Load	         :='Cargar...';
  TeeMsg_NoSeriesSelected:='Non hai Series seleccionadas';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Series';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Intercambiar 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Activo';
  TeeMsg_ActionSeriesActiveHint :='Mostrar / Ocultar Series';
  TeeMsg_ActionEditHint         :='Editar Gráfico';
  TeeMsg_ActionEdit             :='&Editar...';
  TeeMsg_ActionCopyHint         :='Copiar o portapapeles';
  TeeMsg_ActionCopy             :='&Copiar';
  TeeMsg_ActionPrintHint        :='Previsualización do gráfico';
  TeeMsg_ActionPrint            :='&Imprimir...';
  TeeMsg_ActionAxesHint         :='Mostrar / Ocultar Eixos';
  TeeMsg_ActionAxes             :='&Eixos';
  TeeMsg_ActionGridsHint        :='Mostrar / Ocultar rella';
  TeeMsg_ActionGrids            :='&Rejillas';
  TeeMsg_ActionLegendHint       :='Mostrar / Ocultar lenda';
  TeeMsg_ActionLegend           :='&Lenda';
  TeeMsg_ActionSeriesEditHint   :='Editar Series';
  TeeMsg_ActionSeriesMarksHint  :='Mostrar / Ocultar marcas de series';
  TeeMsg_ActionSeriesMarks      :='&Marcas';
  TeeMsg_ActionSaveHint         :='Gardar Gráfico';
  TeeMsg_ActionSave             :='&Gardar...';

  TeeMsg_CandleBar              :='Barras';
  TeeMsg_CandleNoOpen           :='Sen Apertura';
  TeeMsg_CandleNoClose          :='Sen Peche';
  TeeMsg_NoLines                :='Sen Líneas';
  TeeMsg_NoHigh                 :='Sen valor Alto';
  TeeMsg_NoLow                  :='Sen valor Baixo';
  TeeMsg_ColorRange             :='Rango de Cor';
  TeeMsg_WireFrame              :='Alambres';
  TeeMsg_DotFrame               :='Puntos';
  TeeMsg_Positions              :='Posicions';
  TeeMsg_NoGrid                 :='Sen rella';
  TeeMsg_NoPoint                :='Sen punto';
  TeeMsg_NoLine                 :='Sen línea';
  TeeMsg_Labels                 :='Etiquetas';
  TeeMsg_NoCircle               :='Sen circulo';
  TeeMsg_Lines                  :='Líneas';
  TeeMsg_Border                 :='Borde';

  TeeMsg_SmithResistance      :='Resistencia';
  TeeMsg_SmithReactance       :='Reactancia';

  TeeMsg_Column  :='Columna';

  { 5.01 }
  TeeMsg_Separator            :='Separador';
  TeeMsg_FunnelSegment        :='Segmento ';
  TeeMsg_FunnelSeries         :='Funil';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Rebasar cuota';
  TeeMsg_FunnelWithin         :=' entre cuota';
  TeeMsg_FunnelBelow          :=' o debaixo da cuota';
  TeeMsg_CalendarSeries       :='Calendario';
  TeeMsg_DeltaPointSeries     :='Tendencias';
  TeeMsg_ImagePointSeries     :='Imaxe Punto';
  TeeMsg_ImageBarSeries       :='Imaxe Barra';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: O campo debe ser maior que cero.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='como &JPEG';
  TeeMsg_JPEGFilter    :='Archivos JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='como &GIF';
  TeeMsg_GIFFilter     :='Archivos GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='como &PNG';
  TeeMsg_PNGFilter     :='Archivos PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='como PC&X';
  TeeMsg_PCXFilter     :='Archivos PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='como &VML (HTM)';
  TeeMsg_VMLFilter     :='Archivos VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := 'Orixe';
  TeeMsg_Transparency         := 'Transparencia';
  TeeMsg_Box		      := 'Caixa';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Núm Páxina';
  TeeMsg_TextFile             := 'Archivos Texto';

  { 5.03 }
  TeeMsg_Gradient             :='Gradiente';
  TeeMsg_WantToSave           :='¿Desea gardar %s?';

  TeeMsg_Property             :='Propiedad';
  TeeMsg_Value                :='Valor';
  TeeMsg_Yes                  :='Sí';
  TeeMsg_No                   :='No';
  TeeMsg_Image                :='(imagen)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Arrastrar Puntos';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  // 7.0
  TeeMsg_View2D               :='2D';
  TeeMsg_Outline              :='Perfíl';

  TeeMsg_Stop                 :='Parar';
  TeeMsg_Execute              :='Executar !';
  TeeMsg_Themes               :='Temas';
  TeeMsg_LightTool            :='Iluminación 2D';
  TeeMsg_Current              :='Actual';
  TeeMsg_FunctionCorrelation  :='Correlación';
  TeeMsg_FunctionVariance     :='Varianza';
  TeeMsg_GalleryBubble3D      :='Burbuxa 3D';
  TeeMsg_GalleryHorizHistogram:='Horizontal'#13'Histograma';
  TeeMsg_FunctionPerimeter    :='Perímetro';
  TeeMsg_SurfaceNearestTool   :='Superfície mais cercana';
  TeeMsg_AxisScrollTool       :='Scroll do eixo';
  TeeMsg_RectangleTool        :='Rectángulo';
  TeeMsg_GalleryPolarBar      :='Barra Polar';
  TeeMsg_AsWapBitmap          :='Bitmap WAP';
  TeeMsg_WapBMPFilter         :='Bitmaps WAP (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='Clip Series';
  TeeMsg_SeriesBandTool       :='Series de Bandas';
end;

Procedure TeeCreateGalician;
begin
  if not Assigned(TeeGalicianLanguage) then
  begin
    TeeGalicianLanguage:=TStringList.Create;
    TeeGalicianLanguage.Text:=

'LABELS=Textos'+#13+
'DATASET=Tabla'+#13+
'ALL RIGHTS RESERVED.=Todos os Dereitos Reservados.'+#13+
'APPLY=Aplicar'+#13+
'CLOSE=Pechar'+#13+
'OK=Aceptar'+#13+
'ABOUT TEECHART PRO V7.0=Acerca de TeeChart Pro v7.0'+#13+
'OPTIONS=Opcions'+#13+
'FORMAT=Formato'+#13+
'TEXT=Texto'+#13+
'GRADIENT=Gradiente'+#13+
'SHADOW=Sombra'+#13+
'POSITION=Posición'+#13+
'LEFT=Esquerda'+#13+
'TOP=Arriba'+#13+
'CUSTOM=Person.'+#13+
'PEN=Lápiz'+#13+
'PATTERN=Trama'+#13+
'SIZE=Tamaño'+#13+
'BEVEL=Marco'+#13+
'INVERTED=Invertido'+#13+
'INVERTED SCROLL=Desplaz. Invertido'+#13+
'BORDER=Borde'+#13+
'ORIGIN=Orixe'+#13+
'USE ORIGIN=Usar Orixe'+#13+
'AREA LINES=Líneas Area'+#13+
'AREA=Area'+#13+
'COLOR=Cor'+#13+
'SERIES=Series'+#13+
'SUM=Suma'+#13+
'DAY=Dia'+#13+
'QUARTER=Trimestre'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Visible'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Línea Horiz.'+#13+
'LABEL AND PERCENT=Etiqueta e Porcentaxe'+#13+
'LABEL AND VALUE=Etiqueta e Valor'+#13+
'LABEL AND PERCENT TOTAL=Etiqueta Porc. Total'+#13+
'PERCENT TOTAL=Total Porcentaxe'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Restar'+#13+
'MULTIPLY=Multiplicar'+#13+
'DIVIDE=Dividir'+#13+
'STAIRS=Escaleiras'+#13+
'MOMENTUM=Momento'+#13+
'AVERAGE=Media'+#13+
'XML=XML'+#13+
'HTML TABLE=Tabla HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Ningun'+#13+
'(NONE)=Ningunha'#13+
'WIDTH=Ancho'+#13+
'HEIGHT=Alto'+#13+
'COLOR EACH=Corea Cada'+#13+
'STACK=Apilar'+#13+
'STACKED=Apilado'+#13+
'STACKED 100%=Apilado 100%'+#13+
'AXIS=Eixo'+#13+
'LENGTH=Lonxitude'+#13+
'CANCEL=Cancelar'+#13+
'SCROLL=Desplazamento'+#13+
'INCREMENT=Incremento'+#13+
'VALUE=Valor'+#13+
'STYLE=Estilo'+#13+
'JOIN=Unión'+#13+
'AXIS INCREMENT=Incremento do Eixo'+#13+
'AXIS MAXIMUM AND MINIMUM=Máximo e Mínimo do Eixo'+#13+
'% BAR WIDTH=Ancho Barra %'+#13+
'% BAR OFFSET=Desplaz. Barra %'+#13+
'BAR SIDE MARGINS=Marxes Laterais'+#13+
'AUTO MARK POSITION=Posición Marcas Auto.'+#13+
'DARK BAR 3D SIDES=Lados Barra Oscuros'+#13+
'MONOCHROME=Monocromo'+#13+
'COLORS=Cores'+#13+
'DEFAULT=Defecto'+#13+
'MEDIAN=Mediana'+#13+
'IMAGE=Imaxe'+#13+
'DAYS=Dias'+#13+
'WEEKDAYS=Laborables'+#13+
'TODAY=Hoxe'+#13+
'SUNDAY=Domingo'+#13+
'MONTHS=Meses'+#13+
'LINES=Líneas'+#13+
'UPPERCASE=Maiúsculas'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=Ancho Candle'+#13+
'BAR=Barra'+#13+
'OPEN CLOSE=Aper. Cierre'+#13+
'DRAW 3D=Debuxar 3D'+#13+
'DARK 3D=Escuro 3D'+#13+
'SHOW OPEN=Ver Apertura'+#13+
'SHOW CLOSE=Ver Peche'+#13+
'UP CLOSE=Pechar Arriba'+#13+
'DOWN CLOSE=Pechar Abaixo'+#13+
'CIRCLED=Circular'+#13+
'CIRCLE=Círculo'+#13+
'3 DIMENSIONS=3 Dimensions'+#13+
'ROTATION=Rotación'+#13+
'RADIUS=Radios'+#13+
'HOURS=Horas'+#13+
'HOUR=Hora'+#13+
'MINUTES=Minutos'+#13+
'SECONDS=Segundos'+#13+
'FONT=Fuente'+#13+
'INSIDE=Interior'+#13+
'ROTATED=Rotar'+#13+
'ROMAN=Romanos'+#13+
'TRANSPARENCY=Transparencia'+#13+
'DRAW BEHIND=Debuxar Detrás'+#13+
'RANGE=Rango'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Pasos'+#13+
'GRID=Rella'+#13+
'GRID SIZE=Tamaño da Rella'+#13+
'ALLOW DRAG=Permite arrastrar'+#13+
'AUTOMATIC=Automático'+#13+
'LEVEL=Nivel'+#13+
'LEVELS POSITION=Posición Niveles'+#13+
'SNAP=Axustar'+#13+
'FOLLOW MOUSE=Seguir Ratón'+#13+
'TRANSPARENT=Transparente'+#13+
'ROUND FRAME=Marco Redondo'+#13+
'FRAME=Marco'+#13+
'START=Inicio'+#13+
'END=Final'+#13+
'MIDDLE=Medio'+#13+
'NO MIDDLE=Sen Medio'+#13+
'DIRECTION=Dirección'+#13+
'DATASOURCE=Orixe de Datos'+#13+
'AVAILABLE=Disponibles'+#13+
'SELECTED=Seleccionados'+#13+
'CALC=Calcular'+#13+
'GROUP BY=Agrupar por'+#13+
'OF=de'+#13+
'HOLE %=Buraco %'+#13+
'RESET POSITIONS=Posicions defecto'+#13+
'MOUSE BUTTON=Botón Ratón'+#13+
'ENABLE DRAWING=Permite Debuxar'+#13+
'ENABLE SELECT=Permite Seleccionar'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Angulo'+#13+
'ZOOM TEXT=Amplia Textos'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=Ampliar'+#13+
'ELEVATION=Elevación'+#13+
'BEHIND=Detrás'+#13+
'AXES=Eixos'+#13+
'SCALES=Escalas'+#13+
'TITLE=Título'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=Centrado'+#13+
'CENTER=Centro'+#13+
'PATTERN COLOR EDITOR=Editor de Trama'+#13+
'START VALUE=Valor Inicial'+#13+
'END VALUE=Valor Final'+#13+
'COLOR MODE=Modo de Cor'+#13+
'LINE MODE=Modo da Línea'+#13+
'HEIGHT 3D=Alto 3D'+#13+
'OUTLINE=Borde'+#13+
'PRINT PREVIEW=Imprimir'+#13+
'ANIMATED=Animado'+#13+
'ALLOW=Permitir'+#13+
'DASH=Líneas'+#13+
'DOT=Puntos'+#13+
'DASH DOT DOT=Línea Punto Punto'+#13+
'PALE=Suave'+#13+
'STRONG=Forte'+#13+
'WIDTH UNITS=Unidades'+#13+
'FOOT=Pie'+#13+
'SUBFOOT=Sub Pie'+#13+
'SUBTITLE=Subtítulo'+#13+
'LEGEND=Lenda'+#13+
'COLON=Dous puntos'+#13+
'AXIS ORIGIN=Orixe Eixo'+#13+
'UNITS=Unidades'+#13+
'PYRAMID=Pirámide'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=Cubo'+#13+
'TRIANGLE=Triángulo'+#13+
'STAR=Estrela'+#13+
'SQUARE=Cadrado'+#13+
'DOWN TRIANGLE=Triángulo Invert.'+#13+
'SMALL DOT=Puntito'+#13+
'LOAD=Cargar'+#13+
'FILE=Archivo'+#13+
'RECTANGLE=Rectángulo'+#13+
'HEADER=Cabecera'+#13+
'CLEAR=Borrar'+#13+
'ONE HOUR=Unha Hora'+#13+
'ONE YEAR=Un Ano'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=Cono'+#13+
'ARROW=Flecha'+#13+
'CYLLINDER=Cilindro'+#13+
'TIME=Hora'+#13+
'BRUSH=Trama'+#13+
'LINE=Línea'+#13+
'VERTICAL LINE=Línea Vertical'+#13+
'AXIS ARROWS=Flechas en Eixos'+#13+
'MARK TIPS=Suxerencias'+#13+
'DASH DOT=Línea Punto'+#13+
'COLOR BAND=Bandas de Cor'+#13+
'COLOR LINE=Linea de Cor'+#13+
'INVERT. TRIANGLE=Triángulo Invert.'+#13+
'INVERT. PYRAMID=Pirámide Invert.'+#13+
'INVERTED PYRAMID=Pirámide Invert.'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Orixe de Datos de Texto'+#13+
'SOLID=Sólido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=Puntos'+#13+
'SIDE BRUSH=Trama Lateral'+#13+
'SIDE=Al lado'+#13+
'SIDE ALL=Lateral'+#13+
'ROTATE=Rotar'+#13+
'SMOOTH PALETTE=Paleta suavizada'+#13+
'CHART TOOLS GALLERY=Galería de Ferramentas'+#13+
'ADD=Añadir'+#13+
'BORDER EDITOR=Editor de Borde'+#13+
'DRAWING MODE=Modo de Debuxo'+#13+
'CLOSE CIRCLE=Pechar Círculo'+#13+
'PICTURE=Imaxe'+#13+
'NATIVE=Nativo'+#13+
'DATA=Datos'+#13+
'KEEP ASPECT RATIO=Manter proporción'+#13+
'COPY=Copiar'+#13+
'SAVE=Guardar'+#13+
'SEND=Enviar'+#13+
'INCLUDE SERIES DATA=Incluir Datos de Series'+#13+
'FILE SIZE=Tamaño do Archivo'+#13+
'INCLUDE=Incluir'+#13+
'POINT INDEX=Indice de Puntos'+#13+
'POINT LABELS=Etiquetas de Puntos'+#13+
'DELIMITER=Delimitador'+#13+
'DEPTH=Profund.'+#13+
'COMPRESSION LEVEL=Nivel Compresión'+#13+
'COMPRESSION=Compresión'+#13+
'PATTERNS=Tramas'+#13+
'LABEL=Etiqueta'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=Separar Porción'+#13+
'TOTAL ANGLE=Angulo Total'+#13+
'HORIZ. SIZE=Tamaño Horiz.'+#13+
'VERT. SIZE=Tamaño Vert.'+#13+
'SHAPES=Formas'+#13+
'INFLATE MARGINS=Ampliar Marxes'+#13+
'QUALITY=Calidade'+#13+
'SPEED=Velocidade'+#13+
'% QUALITY=% Calidade'+#13+
'GRAY SCALE=Escala de Grises'+#13+
'PERFORMANCE=Mellor'+#13+
'BROWSE=Seleccionar'+#13+
'TILED=Mosaico'+#13+
'HIGH=Alto'+#13+
'LOW=Baixo'+#13+
'DATABASE CHART=Gráfico con Base de Datos'+#13+
'NON DATABASE CHART=Gráfico sen Base de Datos'+#13+
'HELP=Ayuda'+#13+
'NEXT >=Seguinte >'+#13+
'< BACK=< Anterior'+#13+
'TEECHART WIZARD=Asistente de TeeChart'+#13+
'PERCENT=Porcentual'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=Ancho Error'+#13+
'ENHANCED=Mellorado'+#13+
'VISIBLE WALLS=Ver Paredes'+#13+
'ACTIVE=Activo'+#13+
'DELETE=Borrar'+#13+
'ALIGNMENT=Alineación'+#13+
'ADJUST FRAME=Axustar Marco'+#13+
'HORIZONTAL=Horizontal'+#13+
'VERTICAL=Vertical'+#13+
'VERTICAL POSITION=Posición Vertical'+#13+
'NUMBER=Número'+#13+
'LEVELS=Niveles'+#13+
'OVERLAP=Sobreponer'+#13+
'STACK 100%=Apilar 100%'+#13+
'MOVE=Mover'+#13+
'CLICK=Clic'+#13+
'DELAY=Retraso'+#13+
'DRAW LINE=Debuxar Línea'+#13+
'FUNCTIONS=Funcions'+#13+
'SOURCE SERIES=Series Orixe'+#13+
'ABOVE=Arriba'+#13+
'BELOW=Abaixo'+#13+
'Dif. Limit=Límite Dif.'+#13+
'WITHIN=Dentro'+#13+
'EXTENDED=Extendidas'+#13+
'STANDARD=Estandard'+#13+
'STATS=Estadística'+#13+
'FINANCIAL=Financieiras'+#13+
'OTHER=Outras'+#13+
'TEECHART GALLERY=Galería de Gráficos TeeChart'+#13+
'CONNECTING LINES=Líneas de Conexión'+#13+
'REDUCTION=Reducción'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=Intensidade'+#13+
'FONT OUTLINES=Borde Fuentes'+#13+
'SMOOTH SHADING=Sombras suaves'+#13+
'AMBIENT LIGHT=Luz Ambiente'+#13+
'MOUSE ACTION=Acción do Ratón'+#13+
'CLOCKWISE=Segun horario'+#13+
'ANGLE INCREMENT=Incremento Angulo'+#13+
'RADIUS INCREMENT=Incremento Radio'+#13+
'PRINTER=Impresora'+#13+
'SETUP=Opcions'+#13+
'ORIENTATION=Orientación'+#13+
'PORTRAIT=Vertical'+#13+
'LANDSCAPE=Horizontal'+#13+
'MARGINS (%)=Marxes (%)'+#13+
'MARGINS=Marxes'+#13+
'DETAIL=Detalle'+#13+
'MORE=Más'+#13+
'PROPORTIONAL=Proporcional'+#13+
'VIEW MARGINS=Ver Marxes'+#13+
'RESET MARGINS=Márg. Defecto'+#13+
'PRINT=Imprimir'+#13+
'TEEPREVIEW EDITOR=Editor Impresión Preliminar'+#13+
'ALLOW MOVE=Permitir Mover'+#13+
'ALLOW RESIZE=Permitir Redimensionar'+#13+
'SHOW IMAGE=Ver Imaxe'+#13+
'DRAG IMAGE=Arrastrar Imaxe'+#13+
'AS BITMAP=Como mapa de bits'+#13+
'SIZE %=Tamaño %'+#13+
'FIELDS=Campos'+#13+
'SOURCE=Orixe'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=Líneas de cabecera'+#13+
'COMMA=Coma'+#13+
'EDITING=Editando'+#13+
'TAB=Tabulación'+#13+
'SPACE=Espacio'+#13+
'ROUND RECTANGLE=Rectáng. Redondeado'+#13+
'BOTTOM=Abaixo'+#13+
'RIGHT=Dereita'+#13+
'C PEN=Lápiz C'+#13+
'R PEN=Lápiz R'+#13+
'C LABELS=Textos C'+#13+
'R LABELS=Textos R'+#13+
'MULTIPLE BAR=Barras Múltiples'+#13+
'MULTIPLE AREAS=Areas Múltiples'+#13+
'STACK GROUP=Grupo de Apilado'+#13+
'BOTH=Ambos'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=Esquerda Dereita'+#13+
'RIGHT LEFT=Dereita Esquerda'+#13+
'FROM CENTER=Desde o centro'+#13+
'FROM TOP LEFT=Desde Esq. Arriba'+#13+
'FROM BOTTOM LEFT=Desde Esq. Abaixo'+#13+
'SHOW WEEKDAYS=Ver Laborables'+#13+
'SHOW MONTHS=Ver Meses'+#13+
'SHOW PREVIOUS BUTTON=Ver Botón Anterior'#13+
'SHOW NEXT BUTTON=Ver Botón Seguinte'#13+
'TRAILING DAYS=Ver outros Días'+#13+
'SHOW TODAY=Ver Hoxe'+#13+
'TRAILING=Outros Días'+#13+
'LOWERED=Afundido'+#13+
'RAISED=Elevado'+#13+
'HORIZ. OFFSET=Desplaz. Horiz.'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=Dentro'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=Sólo nas etiquetas'+#13+
'MAXIMUM=Máximo'+#13+
'MINIMUM=Mínimo'+#13+
'CHANGE=Cambiar'+#13+
'LOGARITHMIC=Logarítmico'+#13+
'LOG BASE=Base Log.'+#13+
'DESIRED INCREMENT=Incremento'+#13+
'(INCREMENT)=(Incremento)'+#13+
'MULTI-LINE=Multi-Línea'+#13+
'MULTI LINE=Multilínea'+#13+
'RESIZE CHART=Redim. Gráfico'+#13+
'X AND PERCENT=X e Porcentaxe'+#13+
'X AND VALUE=X e Valor'+#13+
'RIGHT PERCENT=Porcentaxe dereita'+#13+
'LEFT PERCENT=Porcentaxe esquerda'+#13+
'LEFT VALUE=Valor esquerda'+#13+
'RIGHT VALUE=Valor dereita'+#13+
'PLAIN=Texto'+#13+
'LAST VALUES=Ultimos Valores'+#13+
'SERIES VALUES=Valores das Series'+#13+
'SERIES NAMES=Nombres das Series'+#13+
'NEW=Novo'+#13+
'EDIT=Editar'+#13+
'PANEL COLOR=Cor do fondo'+#13+
'TOP BOTTOM=Arriba Abaixo'+#13+
'BOTTOM TOP=Abaixo Arriba'+#13+
'DEFAULT ALIGNMENT=Alineación defecto'+#13+
'EXPONENTIAL=Exponencial'+#13+
'LABELS FORMAT=Formato Etiquetas'+#13+
'MIN. SEPARATION %=Min. Separación %'+#13+
'YEAR=Ano'+#13+
'MONTH=Mes'+#13+
'WEEK=Semana'+#13+
'WEEKDAY=Dia Laborable'+#13+
'MARK=Marcas'+#13+
'ROUND FIRST=Redondear primeira'+#13+
'LABEL ON AXIS=Etiqueta en eixo'+#13+
'COUNT=Número'+#13+
'POSITION %=Posición %'+#13+
'START %=Empeza %'+#13+
'END %=Termina %'+#13+
'OTHER SIDE=Lado oposto'+#13+
'INTER-CHAR SPACING=Espacio entre caracteres'+#13+
'VERT. SPACING=Espaciado Vertical'+#13+
'POSITION OFFSET %=Desplazamento %'+#13+
'GENERAL=Xeral'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=Panel'+#13+
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
'DITHER=Reduce'+#13+
'VERTICAL SMALL=Vertical Pequeno'+#13+
'HORIZ. SMALL=Horizontal Pequeno'+#13+
'DIAG. SMALL=Diagonal Pequeno'+#13+
'BACK DIAG. SMALL=Diagonal Invert. Peq.'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=Mínimos pixels'+#13+
'ALLOW SCROLL=Permitir Desplaz.'+#13+
'SWAP=Cambiar'+#13+
'GRADIENT EDITOR=Editor de Gradiente'+#13+
'TEXT STYLE=Estilo do texto'+#13+
'DIVIDING LINES=Líneas de División'+#13+
'SYMBOLS=Símbolos'+#13+
'CHECK BOXES=Casillas'+#13+
'FONT SERIES COLOR=Cor das Series'+#13+
'LEGEND STYLE=Estilo da Lenda'+#13+
'POINTS PER PAGE=Puntos por páxina'+#13+
'SCALE LAST PAGE=Escalar última páxina'+#13+
'CURRENT PAGE LEGEND=Lenda con páxina actual'+#13+
'BACKGROUND=Fondo'+#13+
'BACK IMAGE=Imaxe fondo'+#13+
'STRETCH=Axustar'+#13+
'TILE=Mosaico'+#13+
'BORDERS=Bordes'+#13+
'CALCULATE EVERY=Calcular cada'+#13+
'NUMBER OF POINTS=Número de puntos'+#13+
'RANGE OF VALUES=Rango de valores'+#13+
'FIRST=Primeiro'+#13+
'LAST=Ultimo'+#13+
'ALL POINTS=Todos os puntos'+#13+
'DATA SOURCE=Orixe de Datos'+#13+
'WALLS=Parede'+#13+
'PAGING=Páxina'+#13+
'CLONE=Duplicar'+#13+
'TITLES=Título'+#13+
'TOOLS=Ferramentas'+#13+
'EXPORT=Exportar'+#13+
'CHART=Gráfico'+#13+
'BACK=Fondo'+#13+
'LEFT AND RIGHT=Esq. e Dereita'+#13+
'SELECT A CHART STYLE=Seleccione tipo de Gráfico'+#13+
'SELECT A DATABASE TABLE=Seleccione unha Tabla'+#13+
'TABLE=Tabla'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccione os campos a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Campo de etiquetas'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccione o tipo dexesado'+#13+
'CHART PREVIEW=Visión Preliminar'+#13+
'SHOW LEGEND=Ver Lenda'+#13+
'SHOW MARKS=Ver Marcas'+#13+
'FINISH=Rematar'+#13+
'RANDOM=Aleatorio'+#13+
'DRAW EVERY=Debuxar cada'+#13+
'ARROWS=Flechas'+#13+
'ASCENDING=Ascendente'+#13+
'DESCENDING=Descendente'+#13+
'VERTICAL AXIS=Eixo Vertical'+#13+
'DATETIME=Data/Hora'+#13+
'TOP AND BOTTOM=Superior e Inferior'+#13+
'HORIZONTAL AXIS=Eixo Horizontal'+#13+
'PERCENTS=Porcentaxes'+#13+
'VALUES=Valores'+#13+
'FORMATS=Formatos'+#13+
'SHOW IN LEGEND=Ver en Lenda'+#13+
'SORT=Orden'+#13+
'MARKS=Marcas'+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=Editor de Panel'+#13+
'CONTINUOUS=Continuos'+#13+
'HORIZ. ALIGNMENT=Alineación Horiz.'+#13+
'EXPORT CHART=Exportar Gráfico'+#13+
'BELOW %=Inferior a %'+#13+
'BELOW VALUE=Inferior a Valor'+#13+
'NEAREST POINT=Punto cercano'+#13+
'DRAG MARKS=Mover Marcas'+#13+
'TEECHART PRINT PREVIEW=Impresión Preliminar'+#13+
'X VALUE=Valor X'+#13+
'X AND Y VALUES=Valores X Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Todas as Series Visibles'+#13+
'MARGIN=Marxen'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Esquerda Arriba'+#13+
'LEFT BOTTOM=Esquerda Abaixo'+#13+
'RIGHT TOP=Dereita Arriba'+#13+
'RIGHT BOTTOM=Dereita Abaixo'+#13+
'EXACT DATE TIME=Data/Hora Exacta'+#13+
'RECT. GRADIENT=Gradiente'+#13+
'CROSS SMALL=Cruz pequena'+#13+
'AVG=Media'+#13+
'FUNCTION=Función'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Un milisegundo'+#13+
'ONE SECOND=Un segundo'+#13+
'FIVE SECONDS=Cinco segundos'+#13+
'TEN SECONDS=Dez segundos'+#13+
'FIFTEEN SECONDS=Quince segundos'+#13+
'THIRTY SECONDS=Trinta segundos'+#13+
'ONE MINUTE=Un minuto'+#13+
'FIVE MINUTES=Cinco minutos'+#13+
'TEN MINUTES=Dez minutos'+#13+
'FIFTEEN MINUTES=Quince minutos'+#13+
'THIRTY MINUTES=Trinta minutos'+#13+
'TWO HOURS=Dous horas'+#13+
'SIX HOURS=Seis horas'+#13+
'TWELVE HOURS=Doce horas'+#13+
'ONE DAY=Un dia'+#13+
'TWO DAYS=Dous dias'+#13+
'THREE DAYS=Tres dias'+#13+
'ONE WEEK=Una semana'+#13+
'HALF MONTH=Medio mes'+#13+
'ONE MONTH=Un mes'+#13+
'TWO MONTHS=Dous meses'+#13+
'THREE MONTHS=Tres meses'+#13+
'FOUR MONTHS=Catro meses'+#13+
'SIX MONTHS=Seis meses'+#13+
'IRREGULAR=Irregular'+#13+
'CLICKABLE=Clicable'+#13+
'ROUND=Redondo'+#13+
'FLAT=Plano'+#13+
'PIE=Pastel'+#13+
'HORIZ. BAR=Barra Horiz.'+#13+
'BUBBLE=Burbulla'+#13+
'SHAPE=Forma'+#13+
'POINT=Puntos'+#13+
'FAST LINE=Línea Rápida'+#13+
'CANDLE=Vela'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=Línea Horiz.'+#13+
'SURFACE=Superfície'+#13+
'LEFT AXIS=Eixo Esquerdo'+#13+
'RIGHT AXIS=Eixo Dereito'+#13+
'TOP AXIS=Eixo Superior'+#13+
'BOTTOM AXIS=Eixo Inferior'+#13+
'CHANGE SERIES TITLE=Cambiar Título de Series'+#13+
'DELETE %S ?=Eliminar %s ?'+#13+
'DESIRED %S INCREMENT=Incremento %s deseado'+#13+
'INCORRECT VALUE. REASON: %S=Valor incorrecto. Razón: %s'+#13+
'FILLSAMPLEVALUES NUMVALUES MUST BE > 0=FillSampleValues. Número de valores debe ser > 0.'#13+
'VISIT OUR WEB SITE !=Visite nuestra Web !'#13+
'SHOW PAGE NUMBER=Ver Número de Páxina'#13+
'PAGE NUMBER=Número de Páxina'#13+
'PAGE %D OF %D=Páx. %d de %d'#13+
'TEECHART LANGUAGES=Linguaxes de TeeChart'#13+
'CHOOSE A LANGUAGE=Escolla un idioma'+#13+
'SELECT ALL=Seleccionar Todas'#13+
'MOVE UP=Mover Arriba'#13+
'MOVE DOWN=Mover Abaixo'#13+
'DRAW ALL=Debuxar todo'#13+
'TEXT FILE=Archivo de Texto'#13+
'IMAG. SYMBOL=Símbolo Imax.'#13+
'DRAG REPAINT=Repinta todo'#13+
'NO LIMIT DRAG=Sen límites arrastre'#13+
'PERIOD=Periodo'#13+
'UP=Enriba'#13+
'DOWN=Abaixo'#13+
'SHADOW EDITOR=Editor de sombras'#13+
'CALLOUT=Enlace'#13+
'TEXT ALIGNMENT=Alineación do texto'#13+
'DISTANCE=Distancia'#13+
'ARROW HEAD=Punta da flecha'#13+
'POINTER=Punteiro'#13+
'AVAILABLE LANGUAGES=Lenguaxes disponibles'#13+
'CALCULATE USING=Calcular usando'#13+
'EVERY NUMBER OF POINTS=Cada numero de pontos'#13+
'EVERY RANGE=Cada rango'#13+
'INCLUDE NULL VALUES=Incluir valores nulos'#13+
'DATE=Data'#13+
'ENTER DATE=Introduzca data'#13+
'ENTER TIME=Introduzca fecha'#13+
'BEVEL SIZE=Tamaño do bisel'#13+
'CYLINDER=Cilindro'#13+
'SLANT CUBE=Cubo inclinado'#13+
'TICK LINES=Lineas ticks'#13+
'% BAR DEPTH=% Profundidade da barra'#13+
'DEVIATION=Desviación'#13+
'UPPER=Superior'#13+
'LOWER=Inferior'#13+
'FILL 80%=Recheo 80%'#13+
'FILL 60%=Recheo 60%'#13+
'FILL 40%=Recheo 40%'#13+
'FILL 20%=Recheo 20%'#13+
'FILL 10%=Recheo 10%'#13+
'ZIG ZAG=Zig zag'#13+
'METAL=Metal'#13+
'WOOD=Madeira'#13+
'STONE=Rocha'#13+
'CLOUDS=Nubes'#13+
'GRASS=Grama'#13+
'FIRE=Fogo'#13+
'SNOW=Neve'#13+
'NOTHING=Ningun'#13+
'LEFT TRIANGLE=Triángulo ezquerdo'#13+
'RIGHT TRIANGLE=Triángulo dereito'#13+
'HIGH-LOW=Alto-baixo'#13+
'CONSTANT=Constante'#13+
'VIEW SERIES NAMES=Nomes da serie'#13+
'SHOW LABELS=Mostrar etiquetas'#13+
'SHOW COLORS=Mostrar cores'#13+
'XYZ SERIES=Series XYZ'#13+
'SHOW X VALUES=Mostrar valores X'#13+
'EDIT COLOR=Editar cor'#13+
'DEFAULT COLOR=Cor por defecto'#13+
'MAKE NULL POINT=Facer ponto nulo'#13+
'APPEND ROW=Añadir línea'#13+
'DELETE ROW=Borrar línea'#13+
'TEXT FONT=Tipo do texto'#13+
'SMOOTH=Suavizar'#13+
'CHART THEME SELECTOR=Selector do tipo da gráfica'#13+
'PREVIEW=Vista previa'#13+
'THEMES=Temas'#13+
'COLOR PALETTE=Paleta de cor'#13+
'VIEW 3D=Vista 3D'#13+
'SCALE=Escala'#13+
'MARGIN %=Marxen %'#13+
'VOLUME SERIES=Series de volumen'#13+
'ACCUMULATE=Acumulado'#13+
'DRAW BEHIND AXES=Dibuxar tras eixos'#13+
'X GRID EVERY=Reixa X cada'#13+
'Z GRID EVERY=Reixa Z cada'#13+
'AXIS MAXIMUM=Eixo máximo'#13+
'AXIS CENTER=Eixo centrado'#13+
'AXIS MINIMUM=Eixo mínimo'#13+
'DAILY (NONE)=Diario (ningun)'#13+
'WEEKLY=Semanal'#13+
'MONTHLY=Mensual'#13+
'BI-MONTHLY=Bimensual'#13+
'QUARTERLY=Trimestral'#13+
'YEARLY=Anual'#13+
'DATE PERIOD=Periodo data'#13+
'TIME PERIOD=Periodo tempo'#13+
'INTERPOLATE=Interpolar'#13+
'USE SERIES Z=Usar series Z'#13+
'START X=Inicio X'#13+
'STEP=Paso'#13+
'NUM. POINTS=Num. pontos'#13+
'COLOR EACH LINE=Corar cada línea'#13+
'CASE SENSITIVE=Tipo sensitivo'#13+
'SORT BY=Ordenar por'#13+
'CALCULATION=Cálculo'#13+
'GROUP=Grupo'#13+
'DRAG STYLE=Estilo do arrastre'#13+
'WEIGHT=Peso'#13+
'EDIT LEGEND=Editar lenda'#13+
'IGNORE NULLS=Ignorar nulos'#13+
'NUMERIC FORMAT=Formato numérico'#13+
'DATE TIME=Data e hora'#13+
'GEOGRAPHIC=Xeográfico'#13+
'DECIMALS=Decimais'#13+
'FIXED=Fixo'#13+
'THOUSANDS=Centos'#13+
'CURRENCY=Moneda'#13+
'VIEWS=Vistas'#13+
'OFFSET=Desplazameto'#13+
'ALTERNATE=Alternar'#13+
'ZOOM ON UP LEFT DRAG=Arrastra arriba ezq.'#13+
'LIGHT 0=Lumbre 0'#13+
'LIGHT 1=Lumbre 1'#13+
'LIGHT 2=Lumbre 2'#13+
'FIXED POSITION=Posición fixa'#13+
'DRAW STYLE=Estilo de dibuxo'#13+
'POINTS=Pontos'#13+
'NO CHECK BOXES=Caixa non'#13+
'RADIO BUTTONS=Botón de elección'#13+
'DEFAULT BORDER=Borde por defecto'#13+
'SQUARED=Cuadriculado'#13+
'SEPARATION=Separación'#13+
'ROUND BORDER=Borde curvado'#13+
'Z DATETIME=Data/hora z'#13+
'SYMBOL=Simbolo'#13+
'NUMBER OF SAMPLE VALUES=Número dos valores do exemplo'#13+
'AUTO HIDE=Auto ocultar'#13+
'DIF. LIMIT=Límite dif.'#13+
'RESIZE PIXELS TOLERANCE=Tolerancia no cambio pixels'#13+
'FULL REPAINT=Recheo total'#13+
'END POINT=Ponto final'#13+
'SINGLE=Único'#13+
'REMOVE CUSTOM COLORS=Eliminar cores'#13+
'GALLERY=Galería'#13+
'INVERTED GRAY=Grís invertido'#13+
'RAINBOW=Arcodavella'#13+
'USE PALETTE MINIMUM=Usar paleta mínima'#13+
'BAND 1=Banda 1'#13+
'BAND 2=Banda 2'#13+
'GRID 3D SERIES=Series de reixa 3D'#13+
'TRANSPOSE NOW=Facer transpuesta agora'#13+
'TEECHART LIGHTING=Iluminación TeeChart'#13+
'FACTOR=Factor'#13+
'LINEAR=Lineal'#13+
'SPOTLIGHT=Punto daluz'#13+
'PERIOD 1=Periodo 1'#13+
'PERIOD 2=Periodo 2'#13+
'PERIOD 3=Periodo 3'#13+
'HISTOGRAM=Histograma'#13+
'EXP. LINE=Línea exp.'#13+
'MACD=MACD'#13+
'SHAPE INDEX=Indice da sombra'#13+
'CLOSED=Pechado'#13+
'WEIGHTED=Peso'#13+
'WEIGHTED BY INDEX=Peso por índice'#13+
'DESIGN TIME OPTIONS=Opciones en tempo de diseño'#13+
'LANGUAGE=Lenguaxe'#13+
'CHART GALLERY=Galería de graficas'#13+
'MODE=Modo'#13+
'CHART EDITOR=Editor da grafica'#13+
'REMEMBER SIZE=Lembrar tamaño'#13+
'REMEMBER POSITION=Lembrar posición'#13+
'TREE MODE=Modo árbore'#13+
'RESET=Resetear'#13+
'NEW CHART=Nova gráfica'#13+
'DEFAULT THEME=Tema por defecto'#13+
'TEECHART DEFAULT=TeeChart típico'#13+
'CLASSIC=Clásico'#13+
'WEB=Web'#13+
'WINDOWS XP=Windows XP'#13+
'BLUES=Azuis'#13+
'DARK BORDER=Borde escuro'#13+
'MULTIPLE PIES=Multiples tartas'#13+
'3D GRADIENT=Gradiente 3D'#13+
'DISABLE=Desactivar'#13+
'COLOR EACH SLICE=Corear cada trozo'#13+
'PIE SERIES=Series de tartas'#13+
'FOCUS=Foco'#13+
'EXPLODE=Explotar'#13+
'BASE LINE=Linea base'#13+
'BOX SIZE=Tamaño da caixa'#13+
'REVERSAL AMOUNT=Cantidade de inversión'#13+
'PERCENTAGE=Porcentaxe'#13+
'COMPLETE R.M.S.=R.M.S. Completo'#13+
'BUTTON=Botón'#13+
'ALL=Todo'#13+
'INITIAL DELAY=Pausa inicial'#13+
'THUMB=Pulgar'#13+
'AUTO-REPEAT=Auto repetición'#13+
'BACK COLOR=Cor do fondo'#13+
'HANDLES=Maneixadores'#13+
'ALLOW RESIZE CHART=Permitir cambiar tamano'#13+
'LOOP=Bucle'#13+
'START AT MIN. VALUE=Empezar no valor mínimo'#13+
'EXECUTE !=Executar'#13+
'ONE WAY=Dirección única'#13+
'SERIES 2=Series 2'#13+
'DRAW BEHIND SERIES=Dibuxar tra-las series'#13+
'WEB URL=Dirección Web'#13+
'SELF STACK=Apilado propio'#13+
'CELL=Celda'#13+
'ROW=Fila'#13+
'COLUMN=Columna'#13+
'SIDE LINES=Lineas de límite'#13+
'FAST BRUSH=Brocha rápida'#13+
'SVG OPTIONS=Opciones SVG'#13+
'TEXT ANTI-ALIAS=Suavizado do texto'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Gráfica desde a plantilla (*.tee file)'#13+
'THEME=Tema'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Abrir plantilla da gráfica desde'#13+
'EXPORT DIALOG=Dialogo da exportación'#13+
'BINARY=Binario'#13+
'TEXT QUOTES=Comillas do texto'#13+
'POINT COLORS=Cores do ponto'#13+
'OUTLINE GRADIENT=Perfíl do gradiente'#13+
'PERIMETER=Perímetro'#13+
'BUSINESS=Comercial'#13+
'CARIBE SUN=Sol caribeño'#13+
'CLEAR DAY=Dia claro'#13+
'DESERT=Deserto'#13+
'FARM=Granxa'#13+
'FUNKY=Funky'#13+
'GOLF=Golf'#13+
'HOT=Cálido'#13+
'NIGHT=Noite'#13+
'SEA=Mar'#13+
'SEA 2=Mar 2'#13+
'SUNSET=Posta de sol'#13+
'TROPICAL=Tropical'#13+
'BALANCE=Balance'#13+
'RADIAL OFFSET=Desplazamento radial'#13+
'RADIAL=Radial'#13+
'DIAGONAL UP=Diagonal arriba'#13+
'DIAGONAL DOWN=Diagonal abaixo'#13+
'COVER=Cuberta'#13+
'HIDE TRIANGLES=Ocultar triágulos'#13+
'ARROW WIDTH=Anchura da flecha'#13+
'ARROW HEIGHT=Altura da flecha'#13+
'MIRRORED=Reflexado'#13+
'VALUE SOURCE=Orixen do valor'#13+
'GRID EVERY=Reixa cada'#13+
'CROSS POINTS=Pontos cruze'#13+
'SMOOTHING=Suavizado'#13+
'VOLUME OSCILLATOR=Oscilador volumen'#13
;
  end;
end;

Procedure TeeSetGalician;
begin
  TeeCreateGalician;
  TeeLanguage:=TeeGalicianLanguage;
  TeeGalicianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeGalicianLanguage);
end.
