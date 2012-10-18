unit TeePortuguese;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeePortugueseLanguage:TStringList=nil;

Procedure TeeCreatePortuguese;
Procedure TeeSetPortuguese;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeePortugueseConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2004 por David Berneda';
  TeeMsg_LegendFirstValue   :='Valor da primeira legenda deve ser > 0';
  TeeMsg_LegendColorWidth   :='Largura da cor da legenda deve ser > 0%';
  TeeMsg_SeriesSetDataSource:='Sem ParentChart para validar DataSource';
  TeeMsg_SeriesInvDataSource:='Sem DataSource válido: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues deve ser > 0';
  TeeMsg_AxisLogDateTime    :='Eixo DataHora não pode ser Logarítmico';
  TeeMsg_AxisLogNotPositive :='Valores Máx e Mín de Eixo Logarítmico devem ser  >= 0';
  TeeMsg_AxisLabelSep       :='% separação de Labels deve ser maior que  0';
  TeeMsg_AxisIncrementNeg   :='Incremento de eixo deve ser >= 0';
  TeeMsg_AxisMinMax         :='Valor Mínimo do eixo deve ser <= Máximo';
  TeeMsg_AxisMaxMin         :='Valor Máximo do eixo deve ser >= Mínimo';
  TeeMsg_AxisLogBase        :='Base de eixo Logarítmico deve ser >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage deve ser >= 0';
  TeeMsg_3dPercent          :='Percentual de efeito 3D deve estar entre %d e %d';
  TeeMsg_CircularSeries     :='Dependências Circulares entre Séries não permitidas';
  TeeMsg_WarningHiColor     :='16k Cores ou superior requerido para melhor apresentação';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Título do Eixo';
  TeeMsg_AxisLabels         :='Rótulos do Eixo';
  TeeMsg_RefreshInterval    :='Intervalo de refrescamento deve estar entre 0 e  60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart não pode ser eu mesmo!';
  TeeMsg_GalleryLine        :='Linha';
  TeeMsg_GalleryPoint       :='Ponto';
  TeeMsg_GalleryArea        :='Área';
  TeeMsg_GalleryBar         :='Barra';
  TeeMsg_GalleryHorizBar    :='Barra Horiz.';
  TeeMsg_Stack              :='Pilha';
  TeeMsg_GalleryPie         :='Pizza';
  TeeMsg_GalleryCircled     :='Círculo';
  TeeMsg_GalleryFastLine    :='Linha Rápida';
  TeeMsg_GalleryHorizLine   :='Linha Horiz';

  TeeMsg_PieSample1         :='Carros';
  TeeMsg_PieSample2         :='Fones';
  TeeMsg_PieSample3         :='Tabelas';
  TeeMsg_PieSample4         :='Monitores';
  TeeMsg_PieSample5         :='Lâmpadas';
  TeeMsg_PieSample6         :='Teclados';
  TeeMsg_PieSample7         :='Bicicletas';
  TeeMsg_PieSample8         :='Cadeiras';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editando %s';

  TeeMsg_GalleryStandard    :='Padrão';
  TeeMsg_GalleryExtended    :='Extendido';
  TeeMsg_GalleryFunctions   :='Funções';

  TeeMsg_EditChart          :='E&dita Gráfico...';
  TeeMsg_PrintPreview       :='&Visualiza Impressão...';
  TeeMsg_ExportChart        :='E&xporta Gráfico...';
  TeeMsg_CustomAxes         :='Eixos Personalizados...';

  TeeMsg_InvalidEditorClass :='%s: Classe de Edição Inválida: %s';
  TeeMsg_MissingEditorClass :='%s: não tem Diálogo de Edição';

  TeeMsg_GalleryArrow       :='Seta';

  TeeMsg_ExpFinish          :='&Termina';
  TeeMsg_ExpNext            :='&Próximo >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Projeto';
  TeeMsg_GanttSample2       :='Protótipo';
  TeeMsg_GanttSample3       :='Desenvolvimento';
  TeeMsg_GanttSample4       :='Vendas';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Teste';
  TeeMsg_GanttSample7       :='Manufat.';
  TeeMsg_GanttSample8       :='Depuração';
  TeeMsg_GanttSample9       :='Nova Versão';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Muda Título da Série';
  TeeMsg_NewSeriesTitle     :='Novo Título da Série:';
  TeeMsg_DateTime           :='DataHora';
  TeeMsg_TopAxis            :='Eixo Superior';
  TeeMsg_BottomAxis         :='Eixo Inferior';
  TeeMsg_LeftAxis           :='Eixo Esquerdo';
  TeeMsg_RightAxis          :='Eixo Direito';

  TeeMsg_SureToDelete       :='Exclui %s ?';
  TeeMsg_DateTimeFormat     :='For&mato DataHora:';
  TeeMsg_Default            :='Padrão';
  TeeMsg_ValuesFormat       :='For&mato Valores:';
  TeeMsg_Maximum            :='Máximo';
  TeeMsg_Minimum            :='Mínimo';
  TeeMsg_DesiredIncrement   :='% Incremento Desejado';

  TeeMsg_IncorrectMaxMinValue:='Valor Incorreto. Razão: %s';
  TeeMsg_EnterDateTime      :='Entre [Número de Dias] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Aplica Mudanças ?';
  TeeMsg_SelectedSeries     :='(Série Selecionada)';
  TeeMsg_RefreshData        :='&Refresca Dados';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='443';
  
  TeeMsg_FunctionAdd        :='Adiciona';
  TeeMsg_FunctionSubtract   :='Subtrai';
  TeeMsg_FunctionMultiply   :='Multiplica';
  TeeMsg_FunctionDivide     :='Divide';
  TeeMsg_FunctionHigh       :='Maior';
  TeeMsg_FunctionLow        :='Menor';
  TeeMsg_FunctionAverage    :='Média';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Bolha';
  TeeMsg_FunctionNone       :='Copia';

  TeeMsg_None               :='(nenhum)';

  TeeMsg_PrivateDeclarations:='{ Declarações privadas }';
  TeeMsg_PublicDeclarations :='{ Declarações públicas }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Tamanho do ponteiro deve ser maior que zero';
  TeeMsg_About              :='So&bre TeeChart...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Registro único';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Sumário';

  TeeMsg_FunctionPeriod     :='Período da Função deve ser >= 0';

  TeeMsg_TeeChartWizard     :='TeeChart Wizard';
  TeeMsg_WizardTab          :='Business';

  TeeMsg_ClearImage         :='Lim&pa';
  TeeMsg_BrowseImage        :='V&isualiza...';

  TeeMsg_WizardSureToClose  :='Tem certeza que deseja fechar o TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Campo %s não existe';

  TeeMsg_DepthAxis          :='Prof.Eixo';
  TeeMsg_PieOther           :='Outro';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pizza';
  TeeMsg_ValuesBar          :='Barra';
  TeeMsg_ValuesAngle        :='Ângulo';
  TeeMsg_ValuesGanttStart   :='Início';
  TeeMsg_ValuesGanttEnd     :='Final';
  TeeMsg_ValuesGanttNextTask:='PróxTarefa';
  TeeMsg_ValuesBubbleRadius :='Raio';
  TeeMsg_ValuesArrowEndX    :='FimX';
  TeeMsg_ValuesArrowEndY    :='FimY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Título';
  TeeMsg_Foot               :='Rodapé';
  TeeMsg_Period		    :='Período';
  TeeMsg_PeriodRange        :='Faixa Período';
  TeeMsg_CalcPeriod         :='Calcula %s cada:';
  TeeMsg_SmallDotsPen       :='Pontos Pequenos';

  TeeMsg_InvalidTeeFile     :='Gráfico Inválido em arquivo *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Formato de arquivo *.'+TeeMsg_TeeExtension+' incorreto';
  TeeMsg_EmptyTeeFile       :='Arquivo *.'+TeeMsg_TeeExtension+' vazio';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Eixos Gráfico';
  TeeMsg_ChartAxesCategoryDesc   :='Propriedades e eventos dos Eixos do Gráfico';
  TeeMsg_ChartWallsCategoryName  :='Paredes Gráfico';
  TeeMsg_ChartWallsCategoryDesc  :='Propriedades e eventos das Paredes do Gráfico';
  TeeMsg_ChartTitlesCategoryName :='Títulos Gráfico';
  TeeMsg_ChartTitlesCategoryDesc :='Propriedades e eventos dos Títulos do Gráfico';
  TeeMsg_Chart3DCategoryName     :='Gráfico 3D';
  TeeMsg_Chart3DCategoryDesc     :='Propriedades e eventos do Gráfico 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personal. ';
  TeeMsg_Series                 :='Série';
  TeeMsg_SeriesList             :='Série...';

  TeeMsg_PageOfPages            :='Pág. %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primeiro';
  TeeMsg_Prior  :='Anterior';
  TeeMsg_Next   :='Próximo';
  TeeMsg_Last   :='Último';
  TeeMsg_Insert :='Insere';
  TeeMsg_Delete :='Exclui';
  TeeMsg_Edit   :='Edita';
  TeeMsg_Post   :='Grava';
  TeeMsg_Cancel :='Cancela';

  TeeMsg_All    :='(todos)';
  TeeMsg_Index  :='Índice';
  TeeMsg_Text   :='Texto';

  TeeMsg_AsBMP        :='como &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='como &Metafile';
  TeeMsg_EMFFilter    :='Metafiles Avaçadas (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Propriedade de painel não configurada no formato de Exportação';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Sem Moldura';
  TeeMsg_Dotted    :='Pontilhado';
  TeeMsg_Colors    :='Cores';
  TeeMsg_Filled    :='Preenchido';
  TeeMsg_Marks     :='Marcas';
  TeeMsg_Stairs    :='Degraus';
  TeeMsg_Points    :='Pontos';
  TeeMsg_Height    :='Altura';
  TeeMsg_Hollow    :='Vazado';
  TeeMsg_Point2D   :='Ponto 2D';
  TeeMsg_Triangle  :='Triângulo';
  TeeMsg_Star      :='Estrela';
  TeeMsg_Circle    :='Círculo';
  TeeMsg_DownTri   :='Tri.Baixo';
  TeeMsg_Cross     :='Cruz';
  TeeMsg_Diamond   :='Diamante';
  TeeMsg_NoLines   :='Sem Linhas';
  TeeMsg_Stack100  :='Pilha 100%';
  TeeMsg_Pyramid   :='Pirâmide';
  TeeMsg_Ellipse   :='Elipse';
  TeeMsg_InvPyramid:='Pirâmide Inv.';
  TeeMsg_Sides     :='Lados';
  TeeMsg_SideAll   :='Todos Lados';
  TeeMsg_Patterns  :='Padrões';
  TeeMsg_Exploded  :='Explodido';
  TeeMsg_Shadow    :='Sombra';
  TeeMsg_SemiPie   :='Semi Pizza';
  TeeMsg_Rectangle :='Retângulo';
  TeeMsg_VertLine  :='Linha Vert.';
  TeeMsg_HorizLine :='Linha Horiz.';
  TeeMsg_Line      :='Linha';
  TeeMsg_Cube      :='Cubo';
  TeeMsg_DiagCross :='Cruz Diag.';

  TeeMsg_CanNotFindTempPath    :='Impossível encontrar pasta Temp';
  TeeMsg_CanNotCreateTempChart :='Impossível criar pasta Temp';
  TeeMsg_CanNotEmailChart      :='Impossível email TeeChart. Erro Mapi: %d';

  TeeMsg_SeriesDelete :='Exclui Série: ValueIndex %d fora de limites (0 a %d).';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Vela';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Superfície';
  TeeMsg_GalleryContour     :='Contorno';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Ponto 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Rosca';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Barra 3D';
  TeeMsg_GalleryBigCandle   :='Vela Grande';
  TeeMsg_GalleryLinePoint   :='Linha Pontos';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Cascata';
  TeeMsg_GalleryWindRose    :='Rosa dos Ventos';
  TeeMsg_GalleryClock       :='Relógio';
  TeeMsg_GalleryColorGrid   :='GradeCores';
  TeeMsg_GalleryBoxPlot     :='CaixaPlot';
  TeeMsg_GalleryHorizBoxPlot:='CaixaPlot Horiz.';
  TeeMsg_GalleryBarJoin     :='Junção Barras';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pirâmide';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='Grau de polinômio deve estar entre 1 e 20';
  TeeMsg_AnswerVectorIndex   :='Vetor resposta deve estar entre 1 e %d';
  TeeMsg_FittingError        :='Impossível processar ajuste';
  TeeMsg_PeriodRange         :='Período deve ser >= 0';
  TeeMsg_ExpAverageWeight    :='Peso MédiaExp deve estar entre 0 e 1';
  TeeMsg_GalleryErrorBar     :='Barra Erro';
  TeeMsg_GalleryError        :='Erro';
  TeeMsg_GalleryHighLow      :='Cima-Baixo';
  TeeMsg_FunctionMomentum    :='Momento';
  TeeMsg_FunctionMomentumDiv :='Div.Momento';
  TeeMsg_FunctionExpAverage  :='Média Exp.';
  TeeMsg_FunctionMovingAverage:='Média Móvel';
  TeeMsg_FunctionExpMovAve   :='Média Móvel Exp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ajuste Curvas';
  TeeMsg_FunctionTrend       :='Tendência';
  TeeMsg_FunctionExpTrend    :='Tendência Exp.';
  TeeMsg_FunctionLogTrend    :='Tend.Log.';
  TeeMsg_FunctionCumulative  :='Cumulativo';
  TeeMsg_FunctionStdDeviation:='Desvio Pad.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Raiz Quad.Média';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Estocástico';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Cont.';
  TeeMsg_LoadChart           :='Abrir TeeChart...';
  TeeMsg_SaveChart           :='Salvar TeeChart...';
  TeeMsg_TeeFiles            :='Arquivos TeeChart Pro';

  TeeMsg_GallerySamples      :='Outro';
  TeeMsg_GalleryStats        :='Estats.';

  TeeMsg_CannotFindEditor    :='Impossível encontrar Form de edição de Séries: %s';


  TeeMsg_CannotLoadChartFromURL:='Cód.Erro: %d baixando Gráfico da URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Cód.Erro: %d baixando dados da Série da URL: %s';

  TeeMsg_Test                :='Teste...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Abre';
  TeeMsg_ValuesHigh          :='Cima';
  TeeMsg_ValuesLow           :='Baixo';
  TeeMsg_ValuesClose         :='Fecha';
  TeeMsg_ValuesOffset        :='Desloc.t';
  TeeMsg_ValuesStdError      :='Erro Pad.';

  TeeMsg_Grid3D              :='Grade 3D';

  TeeMsg_LowBezierPoints     :='Número de pontos Bezier deve ser > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edita';
  TeeCommanMsg_Print    :='Imprime';
  TeeCommanMsg_Copy     :='Copia';
  TeeCommanMsg_Save     :='Salva';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotação: %d° Elevação: %d°';
  TeeCommanMsg_Rotate   :='Gira';

  TeeCommanMsg_Moving   :='Desloc.Horiz.: %d Desloc.Vert.: %d';
  TeeCommanMsg_Move     :='Move';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Prof.';

  TeeCommanMsg_Chart    :='Gráfico';
  TeeCommanMsg_Panel    :='Painel';

  TeeCommanMsg_RotateLabel:='Arraste %s para Girar';
  TeeCommanMsg_MoveLabel  :='Arraste %s para Mover';
  TeeCommanMsg_ZoomLabel  :='Arraste %s para Zoom';
  TeeCommanMsg_DepthLabel :='Arraste %s para dimensionar 3D';

  TeeCommanMsg_NormalLabel:='Arraste botão esquerdo para Zoom, botão direito para Scroll';
  TeeCommanMsg_NormalPieLabel:='Arraste fatia da Pizza para Explodi-la';

  TeeCommanMsg_PieExploding :='Fatia: %d Explodida: %d %%';

  TeeMsg_TriSurfaceLess:='Número de pontos deve ser >= 4';
  TeeMsg_TriSurfaceAllColinear:='Todos pontos colineares';
  TeeMsg_TriSurfaceSimilar:='Pontos semelhantes - impossível executar';
  TeeMsg_GalleryTriSurface:='Sup.Triangular';

  TeeMsg_AllSeries :='Todas Séries';
  TeeMsg_Edit      :='Edita';

  TeeMsg_GalleryFinancial    :='Financeiro';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Marcas Arraste';
  TeeMsg_AxisArrowTool :='Setas Eixo';
  TeeMsg_DrawLineTool  :='Desenha Linha';
  TeeMsg_NearestTool   :='Ponto Próximo';
  TeeMsg_ColorBandTool :='Faixa Cores';
  TeeMsg_ColorLineTool :='Linha Colorida';
  TeeMsg_RotateTool    :='Gira';
  TeeMsg_ImageTool     :='Imagem';
  TeeMsg_MarksTipTool  :='Marcas Dicas';

  TeeMsg_CantDeleteAncestor  :='Impossível apagar ancestral';

  TeeMsg_Load	         :='Carrega...';
  TeeMsg_NoSeriesSelected:='Não há Série selecionada';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Gráfico';
  TeeMsg_CategorySeriesActions :='Série Gráfico';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Muda 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Ativo';
  TeeMsg_ActionSeriesActiveHint :='Mostra / Esconde Série';
  TeeMsg_ActionEditHint         :='Edita Gráfico';
  TeeMsg_ActionEdit             :='&Edita...';
  TeeMsg_ActionCopyHint         :='Copia para Área de Transferência';
  TeeMsg_ActionCopy             :='&Copia';
  TeeMsg_ActionPrintHint        :='Visualiza impressão Gráfico';
  TeeMsg_ActionPrint            :='&Imprime...';
  TeeMsg_ActionAxesHint         :='Mostra / Esconde Eixos';
  TeeMsg_ActionAxes             :='&Eixos';
  TeeMsg_ActionGridsHint        :='Mostra / Esconde Grades';
  TeeMsg_ActionGrids            :='&Grades';
  TeeMsg_ActionLegendHint       :='Mostra / Esconde Legenda';
  TeeMsg_ActionLegend           :='&Legenda';
  TeeMsg_ActionSeriesEditHint   :='Edita Séries';
  TeeMsg_ActionSeriesMarksHint  :='Mostra / Esconde Marcas Séries';
  TeeMsg_ActionSeriesMarks      :='&Marcas';
  TeeMsg_ActionSaveHint         :='Salva Gráfico';
  TeeMsg_ActionSave             :='&Salva...';

  TeeMsg_CandleBar              :='Barra';
  TeeMsg_CandleNoOpen           :='Sem Abertura';
  TeeMsg_CandleNoClose          :='Sem Fechamento';
  TeeMsg_NoLines                :='Sem Linhas';
  TeeMsg_NoHigh                 :='Sem Cima';
  TeeMsg_NoLow                  :='Sem Baixo';
  TeeMsg_ColorRange             :='Faixa de Cores';
  TeeMsg_WireFrame              :='Wireframe';
  TeeMsg_DotFrame               :='Moldura Pontos';
  TeeMsg_Positions              :='Posições';
  TeeMsg_NoGrid                 :='Sem Grade';
  TeeMsg_NoPoint                :='Sem Pontos';
  TeeMsg_NoLine                 :='Sem Linha';
  TeeMsg_Labels                 :='Rótulos';
  TeeMsg_NoCircle               :='Sem Círculo';
  TeeMsg_Lines                  :='Linhas';
  TeeMsg_Border                 :='Moldura';

  TeeMsg_SmithResistance      :='Resistência';
  TeeMsg_SmithReactance       :='Reactância';
  
  TeeMsg_Column               :='Coluna';

  { 5.01 }
  TeeMsg_Separator            :='Separador';
  TeeMsg_FunnelSegment        :='Segmento ';
  TeeMsg_FunnelSeries         :='Funil';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Excede cota';
  TeeMsg_FunnelWithin         :=' dentro da cota';
  TeeMsg_FunnelBelow          :=' ou mais abaixo da cota';
  TeeMsg_CalendarSeries       :='Calendário';
  TeeMsg_DeltaPointSeries     :='DeltaPonto';
  TeeMsg_ImagePointSeries     :='ImagePonto';
  TeeMsg_ImageBarSeries       :='ImageBarra';
  TeeMsg_SeriesTextFieldZero  :='TextoSérie: Índice de campo deve ser maior que zero.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='como &JPEG';
  TeeMsg_JPEGFilter    :='Arquivo JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='como &GIF';
  TeeMsg_GIFFilter     :='Arquivo GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='como &PNG';
  TeeMsg_PNGFilter     :='Arquivo PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='como PC&X';
  TeeMsg_PCXFilter     :='Arquivo PCX (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Idioma...';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Trasparency';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Numero pagina';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  TeeMsg_ActiveXVersion      := 'ActiveX Release ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Cannot import TeeChart from %s';
  TeeMsg_ActiveXVerbPrint    := '&Print Preview...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Help...';
  TeeMsg_ActiveXVerbAbout    := '&About TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Error code: %d downloading: %s';
//To do-->
  TeeMsg_DatasourceError     := 'TeeChart DataSource is not a Series or RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Invalid Series type';
  TeeMsg_AxisTextSrcError    := 'Invalid Axis type';
  TeeMsg_DelSeriesDatasource := 'Are you sure you want to delete %s ?';
  TeeMsg_OCXNoPrinter        := 'No default printer installed.';
  TeeMsg_ActiveXPictureNotValid:='Picture not valid';

  // 6.0
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='como &PDF';
  TeeMsg_PDFFilter        :='Ficheiros PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='como PostScript';
  TeeMsg_PSFilter         :='Ficheiros PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Área'#13'Horizontal';
  TeeMsg_SelfStack        :='Self Stacked';
  TeeMsg_DarkPen          :='Dark Border';
  TeeMsg_SelectFolder     :='Seleccione a pasta da base de dados';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Conexão:';
end;

Procedure TeeCreatePortuguese;
begin
  if not Assigned(TeePortugueseLanguage) then
  begin
    TeePortugueseLanguage:=TStringList.Create;
    TeePortugueseLanguage.Text:=

'GRADIENT EDITOR=Editor Gradiente'#13+
'GRADIENT=Gradiente'#13+
'DIRECTION=Direção'#13+
'VISIBLE=Visível'#13+
'TOP BOTTOM=Cima Baixo'#13+
'BOTTOM TOP=Baixo Cima'#13+
'LEFT RIGHT=Esquerda Direita'#13+
'RIGHT LEFT=Direita Esquerda'#13+
'FROM CENTER=Do Centro'#13+
'FROM TOP LEFT=De Cima Esquerda'#13+
'FROM BOTTOM LEFT=De Baixo Esquerda'#13+
'OK=Ok'#13+
'CANCEL=Cancela'#13+
'COLORS=Cores'#13+
'START=Início'#13+
'MIDDLE=Meio'#13+
'END=Final'#13+
'SWAP=Troca'#13+
'NO MIDDLE=Sem Meio'#13+
'TEEFONT EDITOR=Editor TeeFont'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'FONT=Fonte'#13+
'SHADOW=Sombra'#13+
'HORIZ. SIZE=Tam Horiz.'#13+
'VERT. SIZE=Tam Vert.'#13+
'COLOR=Cor'#13+
'OUTLINE=Contorno'#13+
'OPTIONS=Opções'#13+
'FORMAT=Formato'#13+
'TEXT=Texto'#13+
'POSITION=Posição'#13+
'LEFT=Esquerda'#13+
'TOP=Cima'#13+
'AUTO=Auto'#13+
'CUSTOM=Person.'#13+
'LEFT TOP=Sup.Esq.'#13+
'LEFT BOTTOM=Inf.Esq.'#13+
'RIGHT TOP=Dup.Dir.'#13+
'RIGHT BOTTOM=Inf.Dir.'#13+
'MULTIPLE AREAS=Múltiplas Áreas'#13+
'NONE=Nenhum'#13+
'STACKED=Empilhado'#13+
'STACKED 100%=Empilhado 100%'#13+
'AREA=Área'#13+
'PATTERN=Padrão'#13+
'STAIRS=Degraus'#13+
'SOLID=Sólido'#13+
'CLEAR=Vazio'#13+
'HORIZONTAL=Horizontal'#13+
'VERTICAL=Vertical'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Cruz'#13+
'DIAG.CROSS=Cruz Diag.'#13+
'AREA LINES=Linhas de Área'#13+
'BORDER=Moldura'#13+
'INVERTED=Invertido'#13+
'COLOR EACH=Cores Todas'#13+
'ORIGIN=Origem'#13+
'USE ORIGIN=Usa Origem'#13+
'WIDTH=Largura'#13+
'HEIGHT=Altura'#13+
'AXIS=Eixo'#13+
'LENGTH=Comprimento'#13+
'SCROLL=Rolar'#13+
'BOTH=Ambos'#13+
'AXIS INCREMENT=Incremento do Eixo'#13+
'INCREMENT=Incremento'#13+
'STANDARD=Padrão'#13+
'CUSTOM=Personaliz.'#13+
'ONE MILLISECOND=Um Milisegundo'#13+
'ONE SECOND=Um Segundo'#13+
'FIVE SECONDS=Cinco Segundos'#13+
'TEN SECONDS=Dez Segundos'#13+
'FIFTEEN SECONDS=Quinze Segundos'#13+
'THIRTY SECONDS=Trinta Segundos'#13+
'ONE MINUTE=Um Minuto'#13+
'FIVE MINUTES=Cinco Minutos'#13+
'TEN MINUTES=Dez Minutos'#13+
'FIFTEEN MINUTES=Quinze Minutos'#13+
'THIRTY MINUTES=Trinta Minutos'#13+
'ONE HOUR=Uma Hora'#13+
'TWO HOURS=Duas Horas'#13+
'SIX HOURS=Seis Horas'#13+
'TWELVE HOURS=Doze Horas'#13+
'ONE DAY=Um Dia'#13+
'TWO DAYS=Dois Dias'#13+
'THREE DAYS=Tres Dias'#13+
'ONE WEEK=Uma Semana'#13+
'HALF MONTH=Meio Mês'#13+
'ONE MONTH=Um Mês'#13+
'TWO MONTHS=Dois Meses'#13+
'THREE MONTHS=Tres Meses'#13+
'FOUR MONTHS=Quatro Meses'#13+
'SIX MONTHS=Seis Meses'#13+
'ONE YEAR=Um Ano'#13+
'EXACT DATE TIME=Data Hora Exata'#13+
'AXIS MAXIMUM AND MINIMUM=Máximo e Mínimo do Eixo'#13+
'VALUE=Valor'#13+
'TIME=Hora'#13+
'LEFT AXIS=Eixo Esquerdo'#13+
'RIGHT AXIS=Eixo Direito'#13+
'TOP AXIS=Eixo Superior'#13+
'BOTTOM AXIS=Eixo Inferior'#13+
'% BAR WIDTH=% Larg.Barra'#13+
'STYLE=Estilo'#13+
'% BAR OFFSET=% Desl.Barra'#13+
'RECTANGLE=Retângulo'#13+
'PYRAMID=Pirâmide'#13+
'INVERT. PYRAMID=Pirâmide Invert.'#13+
'CYLINDER=Cilindro'#13+
'ELLIPSE=Elipse'#13+
'ARROW=Seta'#13+
'RECT. GRADIENT=Gradiente Ret.'#13+
'CONE=Cone'#13+
'DARK BAR 3D SIDES=Lados 3D Barra Escuros'#13+
'BAR SIDE MARGINS=Margens Laterais Barra'#13+
'AUTO MARK POSITION=Marca Posição Auto'#13+
'JOIN=Join'#13+
'DARK BAR 3D SIDES=Lados 3D Barra Escuros'#13+
'BAR SIDE MARGINS=Margens Laterais Barra'#13+
'AUTO MARK POSITION=Marca Posição Auto'#13+
'DATASET=Dataset'#13+
'APPLY=Aplica'#13+
'SOURCE=Fonte'#13+
'MONOCHROME=Monocromatico'#13+
'DEFAULT=Padrão'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Fio'#13+
'PATTERN COLOR EDITOR=Editor de Padrão de Cores'#13+
'IMAGE=Imagem'#13+
'BACK DIAGONAL=Diagonal Inv.'#13+
'DIAGONAL CROSS=Cruz Diagonal'#13+
'FILL 80%=Preenche 80%'#13+
'FILL 60%=Preenche 60%'#13+
'FILL 40%=Preenche 40%'#13+
'FILL 20%=Preenche 20%'#13+
'FILL 10%=Preenche 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Vertical pequeno'#13+
'HORIZ. SMALL=Horiz. pequeno'#13+
'DIAG. SMALL=Diag. pequeno'#13+
'BACK DIAG. SMALL=Diag. Inv. pequeno'#13+
'CROSS SMALL=Cruz pequena'#13+
'DIAG. CROSS SMALL=Cruz Diag. pequena'#13+
'PATTERN COLOR EDITOR=Editor de Padrão de Cores'#13+
'DAYS=Dias'#13+
'WEEKDAYS=Dias da Semana'#13+
'TODAY=Hoje'#13+
'SUNDAY=Domingo'#13+
'TRAILING=Faltando'#13+
'MONTHS=Meses'#13+
'LINES=Linha'#13+
'SHOW WEEKDAYS=Mostra Dias Semana'#13+
'UPPERCASE=Caixa Alta'#13+
'TRAILING DAYS=Dias Faltando'#13+
'SHOW TODAY=Mostra Hoje'#13+
'SHOW MONTHS=Mostra Meses'#13+
'CANDLE WIDTH=Largura Vela'#13+
'STICK=Bastão'#13+
'BAR=Barra'#13+
'OPEN CLOSE=Abre Fecha'#13+
'UP CLOSE=Fecha Cima'#13+
'DOWN CLOSE=Fecha Baixo'#13+
'SHOW OPEN=Mostra Aberto'#13+
'SHOW CLOSE=Mostra Fech.'#13+
'DRAW 3D=Des. 3D'#13+
'DARK 3D=3D Escuro'#13+
'EDITING=Editando'#13+
'CHART=Gráfico'#13+
'SERIES=Séries'#13+
'DATA=Dados'#13+
'TOOLS=Ferramentas'#13+
'EXPORT=Exporta'#13+
'PRINT=Imprime'#13+
'SERIES=Série'#13+
'GENERAL=Geral'#13+
'TITLES=Títulos'#13+
'LEGEND=Legenda'#13+
'PANEL=Painel'#13+
'PAGING=Paginação'#13+
'WALLS=Paredes'#13+
'3D=3D'#13+
'ADD=Adiciona'#13+
'DELETE=Apaga'#13+
'TITLE=Título'#13+
'CLONE=Clone'#13+
'CHANGE=Altera'#13+
'HELP=Ajuda'#13+
'CLOSE=Fecha'#13+
'TEECHART PRINT PREVIEW=Visualização de Impressão do TeeChart'#13+
'PRINTER=Impress.'#13+
'SETUP=Config'#13+
'ORIENTATION=Orientação'#13+
'PORTRAIT=Retrato'#13+
'LANDSCAPE=Paisagem'#13+
'MARGINS (%)=Margens (%)'#13+
'DETAIL=Detalhe'#13+
'MORE=Mais'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=Reinic.Margens'#13+
'VIEW MARGINS=Vis.Margins'#13+
'PROPORTIONAL=Proporcional'#13+
'TEECHART PRINT PREVIEW=Visualização de Impressão do TeeChart'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'CIRCLE=Círculo'#13+
'VERTICAL LINE=Linha Vertical'#13+
'HORIZ. LINE=Linha Horiz.'#13+
'TRIANGLE=Triângulo'#13+
'INVERT. TRIANGLE=Triângulo Invert.'#13+
'LINE=Linha'#13+
'DIAMOND=Diamante'#13+
'CUBE=Cubo'#13+
'STAR=Estrela'#13+
'TRANSPARENT=Transparente'#13+
'HORIZ. ALIGNMENT=Alinhamento Horiz.'#13+
'CENTER=Centraliza'#13+
'RIGHT=Direita'#13+
'ROUND RECTANGLE=Retângulo Arredondado'#13+
'ALIGNMENT=Alinhamento'#13+
'TOP=Topo'#13+
'BOTTOM=Baixo'#13+
'RIGHT=:Direita'#13+
'UNITS=Unidades'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Origem Eixo'#13+
'ROTATION=Rotação'#13+
'CIRCLED=Circular'#13+
'3 DIMENSIONS=3 Dimensões'#13+
'RADIUS=Raio'#13+
'ANGLE INCREMENT=Incremento Ângulo'#13+
'RADIUS INCREMENT=Incremento Raio'#13+
'CLOSE CIRCLE=Fecha Círulo'#13+
'PEN=Caneta'#13+
'LABELS=Rótulos'#13+
'ROTATED=Girado'#13+
'CLOCKWISE=Horário'#13+
'INSIDE=Dentro'#13+
'ROMAN=Romanos'#13+
'HOURS=Horas'#13+
'MINUTES=Minutos'#13+
'SECONDS=Segundos'#13+
'START VALUE:=Valor Inicial:'#13+
'END VALUE=Valor Final'#13+
'TRANSPARENCY=Transparência'#13+
'DRAW BEHIND=Desenha Atrás'#13+
'COLOR MODE=Modo Cores'#13+
'STEPS=Degraus'#13+
'RANGE=Faixa'#13+
'PALETTE=Paleta'#13+
'PALE=Pálido'#13+
'STRONG=Forte'#13+
'GRID SIZE=Tam. Grade'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Prof.'#13+
'IRREGULAR=Irregular'#13+
'GRID=Grade'#13+
'VALUE=Valor'#13+
'ALLOW DRAG=Permite Arrastar'#13+
'VERTICAL POSITION=Posição Vertical'#13+
'LEVELS POSITION=Posição Níveis'#13+
'LEVELS=Níveis'#13+
'NUMBER=Número'#13+
'LEVEL=Nível'#13+
'AUTOMATIC=Automático'#13+
'SNAP=Encaixa'#13+
'FOLLOW MOUSE=Segue mouse'#13+
'STACK=Empilha'#13+
'HEIGHT 3D=Altura 3D'#13+
'LINE MODE=Modo Linha'#13+
'OVERLAP=Sobrepõe'#13+
'STACK 100%=Empilha 100%'#13+
'CLICKABLE=Clicavel'#13+
'AVAILABLE=Disponível'#13+
'SELECTED:=Selecinado:'#13+
'DATASOURCE=DataSource'#13+
'GROUP BY=Agrupa por'#13+
'CALC=Calc'#13+
'OF=de'#13+
'SUM=Soma'#13+
'COUNT=Contagem'#13+
'HIGH=Maior'#13+
'LOW=Menor'#13+
'AVG=Média'#13+
'HOUR=Hora'#13+
'DAY=Dia'#13+
'WEEK=Semana'#13+
'WEEKDAY=Dia Semana'#13+
'MONTH=Mês'#13+
'QUARTER=Trimestre'#13+
'YEAR=Ano'#13+
'HOLE %:=Buraco %:'#13+
'RESET POSITIONS=Reinicializa posições'#13+
'MOUSE BUTTON=Botão Mouse'#13+
'LEFT=Esquerdo'#13+
'RIGHT=Direito'#13+
'ENABLE DRAWING=Habilita desenho'#13+
'ENABLE SELECT=Habilita Seleção'#13+
'ENHANCED=Avançado'#13+
'ERROR WIDTH=Larg. Erro'#13+
'WIDTH UNITS=Unids Larg.'#13+
'PERCENT=Percent.'#13+
'LEFT AND RIGHT=Esquerda e Direita'#13+
'TOP AND BOTTOM=Cima e Baixo'#13+
'BORDER EDITOR=Editor Molduras'#13+
'DASH=Sólido'#13+
'DOT=Traço'#13+
'DASH DOT=Ponto'#13+
'DASH DOT DOT=Traço Ponto'#13+
'CALCULATE EVERY=Calcula todo'#13+
'ALL POINTS=Todos ptos'#13+
'NUMBER OF POINTS=Número de pontos'#13+
'RANGE OF VALUES=Faixa de valores'#13+
'FIRST=Primeiro'#13+
'LAST=Último'#13+
'TEEPREVIEW EDITOR=Editor TeePreview'#13+
'ALLOW MOVE=Permite Mover'#13+
'ALLOW RESIZE=Permite Redimensionar'#13+
'DRAG IMAGE=Arrasta Imagem'#13+
'AS BITMAP=Como Bitmap'#13+
'SHOW IMAGE=Mostra Imagem'#13+
'MARGINS=Margens'#13+
'SIZE=Tam.'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Elevação'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Desl. Horiz.'#13+
'VERT. OFFSET=Desl. Vert.'#13+
'PERSPECTIVE=Perspectiva'#13+
'ANGLE=Ângulo'#13+
'ORTHOGONAL=Ortogonal'#13+
'ZOOM TEXT=Zoom Texto'#13+
'SCALES=Escalas'#13+
'TICKS=Marcas'#13+
'MINOR=Menor'#13+
'MAXIMUM=Máximo'#13+
'MINIMUM=Mínimo'#13+
'(MAX)=(máx)'#13+
'(MIN)=(mín)'#13+
'DESIRED INCREMENT=Incr.Desejado'#13+
'(INCREMENT)=(incremento)'#13+
'LOG BASE=Base Log'#13+
'LOGARITHMIC=Logarítmico'#13+
'SIZE=Tamanho'#13+
'STYLE=Estílo'#13+
'MIN. SEPARATION %=% Separação Mín'#13+
'MULTI-LINE=Multi-linhas'#13+
'LABEL ON AXIS=Rótulo no Eixo'#13+
'ROUND FIRST=Redondo Primeiro'#13+
'MARK=Marca'#13+
'LABELS FORMAT=Formato Rótulos'#13+
'EXPONENTIAL=Exponencial'#13+
'DEFAULT ALIGNMENT=Alinhamento Padrão'#13+
'LEN=Tam'#13+
'INNER=Dentro'#13+
'AT LABELS ONLY=Só nos Rótulos'#13+
'CENTERED=Centrado'#13+
'COUNT=Conta'#13+
'POSITION %=% Posição'#13+
'START %=% Início'#13+
'END %=% Final'#13+
'OTHER SIDE=Outro lado'#13+
'AXES=Eixos'#13+
'BEHIND=Atrás'#13+
'CLIP POINTS=Corta Pontos'#13+
'PRINT PREVIEW=Vis. Impressão'#13+
'SCROLL=Rolagem'#13+
'STEPS=Passos'#13+
'MINIMUM PIXELS=Pixels Mínimo'#13+
'ALLOW=Permite'#13+
'ANIMATED=Animado'#13+
'ALLOW SCROLL=Permite Rolar'#13+
'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
'AMBIENT LIGHT=Luz Ambiente'#13+
'SHININESS=Brilho'#13+
'FONT 3D DEPTH=Prof. Fonte 3D'#13+
'ACTIVE=Ativo'#13+
'FONT OUTLINES=Contorno Fontes'#13+
'SMOOTH SHADING=Sombra Suave'#13+
'LIGHT=Luz'#13+
'Y=Y'#13+
'INTENSITY=Intensidade'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'BEVEL=Moldura'#13+
'FRAME=Moldura'#13+
'ROUND FRAME=Moldura Redonda'#13+
'LOWERED=Rebaixado'#13+
'RAISED=Elevado'#13+
'SYMBOLS=Símbolos'#13+
'TEXT STYLE=Estilo Texto'#13+
'LEGEND STYLE=Estilo Legenda'#13+
'VERT. SPACING=Espaço Vert.'#13+
'SERIES NAMES=Nomes Séries'#13+
'SERIES VALUES=Valores Séries'#13+
'LAST VALUES=Últimos Valores'#13+
'PLAIN=Simples'#13+
'LEFT VALUE=Valor Esquerdo'#13+
'RIGHT VALUE=Valor Direito'#13+
'LEFT PERCENT=Percentual Esquerdo'#13+
'RIGHT PERCENT=Percentual Direito'#13+
'X VALUE=Valor X'#13+
'PERCENT=Percentual'#13+
'X AND VALUE=X e Valor'#13+
'X AND PERCENT=X e Percentual'#13+
'CHECK BOXES=Caixas checagem'#13+
'DIVIDING LINES=Linhas Divisoras'#13+
'FONT SERIES COLOR=Cor Fonte Séries'#13+
'POSITION OFFSET %=Desl % Posição'#13+
'MARGIN=Margem'#13+
'RESIZE CHART=Redim.Gráfico'#13+
'CUSTOM=Pers.'#13+
'WIDTH UNITS=Unid.Larg.'#13+
'CONTINUOUS=Contínuo'#13+
'POINTS PER PAGE=Pontos por Página'#13+
'SCALE LAST PAGE=Escala Últ Página'#13+
'CURRENT PAGE LEGEND=Legenda pág Atual'#13+
'PANEL EDITOR=Editor de Painel'#13+
'BACKGROUND=Fundo'#13+
'BORDERS=Molduras'#13+
'COLOR=Cor Painel'#13+
'BACK IMAGE=Imagem Fundo'#13+
'STRETCH=Ajusta'#13+
'TILE=Lado a Lado'#13+
'BEVEL INNER=Moldura Interna'#13+
'NONE=Nenhuma'#13+
'LOWERED=Rebaixada'#13+
'RAISED=Elevada'#13+
'BEVEL OUTER=Moldura Externa'#13+
'MARKS=Marcas'#13+
'DATA SOURCE=Data Source'#13+
'SORT=Class'#13+
'CURSOR=Cursor'#13+
'SHOW IN LEGEND=Mostra na Legenda'#13+
'FORMATS=Formatos'#13+
'VALUES=Valores'#13+
'PERCENTS=Percents.'#13+
'HORIZONTAL AXIS=Eixo Horizontal'#13+
'DATETIME=DataHora'#13+
'VERTICAL AXIS=Eixo Vertical'#13+
'LEFT AND RIGHT=Direita e Esquerda'#13+
'ASCENDING=Ascendente'#13+
'DESCENDING=Descendente'#13+
'DRAW EVERY=Desenha cada'#13+
'CLIPPED=Cortado'#13+
'ARROWS=Setas'#13+
'LENGTH=Compr.'#13+
'MULTI LINE=Multi linhas'#13+
'ALL SERIES VISIBLE=Todas Séries Visíveis'#13+
'PERCENT=Porcent.'#13+
'LABEL=Rótulo'#13+
'LABEL AND PERCENT=Rótulo e Porcent.'#13+
'LABEL AND VALUE=Rótulo e Valor'#13+
'PERCENT TOTAL=Porcent.Total'#13+
'LABEL AND PERCENT TOTAL=Rótulo e Porcent.Total'#13+
'X AND Y VALUES=Valores X e Y'#13+
'MANUAL=Manual'#13+
'RANDOM=Aleatório'#13+
'FUNCTION=Função'#13+
'NEW=Novo'#13+
'EDIT=Edita'#13+
'DELETE=Exclui'#13+
'PERSISTENT=Persistente'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'ADJUST FRAME=Ajusta Moldura'#13+
'LEFT=Esq.'#13+
'CENTER=Centr.'#13+
'RIGHT=Dir.'#13+
'CUSTOM=Personalizado'#13+
'SUBTITLE=SubTítulo'#13+
'SUBFOOT=Rodapé'#13+
'FOOT=SubRodapé'#13+
'VISIBLE WALLS=Paredes Visíveis'#13+
'BACK=Atrás'#13+
'DIF. LIMIT=Limite Dif.'#13+
'LINES=Linhas.'#13+
'ABOVE=Acima'#13+
'WITHIN=Dentro'#13+
'BELOW=Abaixo'#13+
'CONNECTING LINES=Conectando Linhas'#13+
'LINES=Linhas'#13+
'BROWSE=Visualiza'#13+
'TILED=Lado a Lado'#13+
'INFLATE MARGINS=Infla Margens'#13+
'SQUARE=Quadrado'#13+
'DOWN TRIANGLE=Triângulo Inv.'#13+
'SMALL DOT=Ponto Pequeno'#13+
'DEFAULT=Default'#13+
'GLOBAL=Global'#13+
'SHAPES=Formas'#13+
'BRUSH=Broxa'#13+
'DELAY=Atraso'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Ação Mouse'#13+
'MOVE=Move'#13+
'CLICK=Clica'#13+
'SIZE=Tam'#13+
'DRAW LINE=Desenha Linha'#13+
'EXPLODE BIGGEST=Explode maior'#13+
'TOTAL ANGLE=Ângulo Total'#13+
'GROUP SLICES=Agrupa fatias'#13+
'BELOW %=Abaixo %'#13+
'BELOW VALUE=Abaixo Valor'#13+
'OTHER=Outro'#13+
'PATTERNS=Padrões'#13+
'HORIZ. SIZE=Tam. Horiz.'#13+
'VERT. SIZE=Tam. Vert.'#13+
'SIZE %=% Tam'#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Texto DataSource Série'#13+
'FIELDS=Campos'#13+
'NUMBER OF HEADER LINES=Núm.linhas Cabeçalho'#13+
'SEPARATOR=Separador'#13+
'COMMA=Vírgula'#13+
'SPACE=Espaço'#13+
'TAB=Tab'#13+
'FILE=Arquivo'#13+
'WEB URL=URL Web'#13+
'LOAD=Carrega'#13+
'C LABELS=Rótulos C'#13+
'R LABELS=Rótulos R'#13+
'C PEN=Caneta C'#13+
'R PEN=Caneta R'#13+
'STACK GROUP=Empilha Grupo'#13+
'MULTIPLE BAR=Múltiplas Barras'#13+
'SIDE=Lados'#13+
'SIDE ALL=Todos Lados'#13+
'DRAWING MODE=Modo Desenho'#13+
'WIREFRAME=Arame'#13+
'DOTFRAME=Pontos'#13+
'SMOOTH PALETTE=Paleta Suave'#13+
'SIDE BRUSH=Broxa Lateral'#13+
'ABOUT TEECHART PRO V7.0=Sobre TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Todos Direitos Reservados.'#13+
'VISIT OUR WEB SITE !=Visite nossa página !'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'SELECT A CHART STYLE=Escolha um estilo de Gráfico'#13+
'DATABASE CHART=Gráfico Banco de Dados'#13+
'NON DATABASE CHART=Gráfico Sem Banco de Dadps'#13+
'SELECT A DATABASE TABLE=Selecione uma Tabela'#13+
'ALIAS=Alias'#13+
'TABLE=Tabela'#13+
'SOURCE=Source'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Escolha os campos para Gráfico'#13+
'SELECT A TEXT LABELS FIELD=Texto para rótulos de Campo'#13+
'CHOOSE THE DESIRED CHART TYPE=Tipo de gráfico desejado'#13+
'2D=2D'#13+
'CHART PREVIEW=Visualização Gráfico'#13+
'SHOW LEGEND=Mostra Legenda'#13+
'SHOW MARKS=Mostra Marcas'#13+
'COLOR EACH=Color each'#13+
'< BACK=< Anterior'#13+
'SELECT A CHART STYLE=Escolha um estilo de Gráfico'#13+
'DATABASE CHART=Gráfico Banco de Dados'#13+
'NON DATABASE CHART=Gráfico Sem Banco de Dadps'#13+
'SELECT A DATABASE TABLE=Selecione uma Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Escolha os campos para Gráfico'#13+
'SELECT A TEXT LABELS FIELD=Texto para rótulos de Campo'#13+
'CHOOSE THE DESIRED CHART TYPE=Tipo de gráfico desejado'#13+
'EXPORT CHART=Exporta Gráfico'#13+
'PICTURE=Figura'#13+
'NATIVE=Nativo'#13+
'KEEP ASPECT RATIO=Mantém aspecto'#13+
'INCLUDE SERIES DATA=Inclui dados de Séries'#13+
'FILE SIZE=Tamanho arquivo'#13+
'DELIMITER=Delimitador'#13+
'XML=XML'#13+
'HTML TABLE=Tabela HTML'#13+
'EXCEL=Excel'#13+
'COLON=Ponto e Vírgula'#13+
'INCLUDE=Inclui'#13+
'POINT LABELS=Pontos Rótulos'#13+
'POINT INDEX=Pontos Indice'#13+
'HEADER=Cabeçalho'#13+
'COPY=Copia'#13+
'SAVE=Salva'#13+
'SEND=Envia'#13+
'INCLUDE SERIES DATA=Inclui dados de Séries'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'INTER-CHAR SPACING=Espaço Inter-caracter'#13+
'FUNCTIONS=Funções'#13+
'ADX=ADX'#13+
'AVERAGE=Bollinger'#13+
'BOLLINGER=Copia'#13+
'COPY=Desvio Pad.'#13+
'DIVIDE=Div.Momento'#13+
'EXP. AVERAGE=Divide'#13+
'EXP.MOV.AVRG.=Estocástico'#13+
'HIGH=MACD'#13+
'LOW=Maior'#13+
'MACD=Média'#13+
'MOMENTUM=Média Exp.'#13+
'MOMENTUM DIV=Média Móvel'#13+
'MOVING AVRG.=Média Móvel Exp.'#13+
'MULTIPLY=Menor'#13+
'R.S.I.=Momento'#13+
'ROOT MEAN SQ.=Multiplica'#13+
'STD.DEVIATION=R.S.I.'#13+
'STOCHASTIC=Raiz Quad.Média'#13+
'SUBTRACT=Subtrai'#13+
'SOURCE SERIES=Série Fonte'#13+
'TEECHART GALLERY=TeeChart Galeria'#13+
'DITHER=Dither'#13+
'REDUCTION=Redução'#13+
'COMPRESSION=Compressão'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Próximo'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=Monocromo'#13+
'GRAY SCALE=Escala Cinza'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantiza'#13+
'QUANTIZE 256=Quantiza 256'#13+
'% QUALITY=% Qualid'#13+
'PERFORMANCE=Performance'#13+
'QUALITY=Qualid'#13+
'SPEED=Velocid'#13+
'COMPRESSION LEVEL=Nível Compressão'#13+
'CHART TOOLS GALLERY=Galeria Ferramentas Gráfico'#13+
'ANNOTATION=Annotation'#13+
'AXIS ARROWS=Cursor'#13+
'COLOR BAND=Desenha Linha'#13+
'COLOR LINE=Faixa Cores'#13+
'CURSOR=Gira'#13+
'DRAG MARKS=Imagem'#13+
'DRAW LINE=Linha Colorida'#13+
'IMAGE=Marcas Arraste'#13+
'MARK TIPS=Marcas Dicas'#13+
'NEAREST POINT=Ponto Próximo'#13+
'ROTATE=Setas Eixo'#13+
'CHART TOOLS GALLERY=Galeria Ferramentas Gráfico'#13+
'COLOR EACH=Col.Tudo'#13
;
  end;
end;

Procedure TeeSetPortuguese;
begin
  TeeCreatePortuguese;
  TeeLanguage:=TeePortugueseLanguage;
  TeePortugueseConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeePortugueseLanguage);
end.
