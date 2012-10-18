////////////////////////////////////////////////////////
// TeeChart Pro Farsi Translation by Mehdi Keramati . //
// Email: delphi@novinmedia.com                       //
// Finished on : 1382/1/24 - 2:22 AM                  //
////////////////////////////////////////////////////////

unit TeeFarsi;
{$I TeeDefs.inc}

interface

uses Classes;

var TeeFarsiLanguage: TStringList = nil;

procedure TeeSetFarsi;
procedure TeeCreateFarsi;

implementation

uses SysUtils, TeeConst, TeeProCo{$IFNDEF D5}, TeCanvas{$ENDIF};

procedure TeeFarsiConstants;
begin
  { TeeConst }
  TeeMsg_Copyright := '© 1995-2004 by David Berneda';

  TeeMsg_Test := ' ” ...';
  TeeMsg_LegendFirstValue := '«Ê·Ì‰ „ﬁœ«— ‰ﬁ‘Â »«Ìœ »“—ê — «“ 0 »«‘œ';
  TeeMsg_LegendColorWidth := '—‰ê ‰ﬁ‘Â »«Ìœ »“—ê — «“ 0% »«‘œ';
  TeeMsg_SeriesSetDataSource := 'ÂÌÃ ç«—  „«œ—Ì »—«Ì ⁄—÷Ì«»Ì DataSource  ⁄ÌÌ‰ ‰‘œÂ «” ';
  TeeMsg_SeriesInvDataSource := '%s Ìﬂ DataSource „⁄ »— ‰Ì” ';
  TeeMsg_FillSample := '»«Ìœ »“—ê — «“ ’›— »«‘œ NumValues FillSampleValues';
  TeeMsg_AxisLogDateTime := '„ÕÊ— DateTime ‰„Ì Ê«‰œ ·ê«—Ì „Ì »«‘œ';
  TeeMsg_AxisLogNotPositive := '„ﬁ«œÌ— „Ì‰Ì„Ê„ Ê „«ﬂ”Ì„Ê„ „ÕÊ— ·ê«—Ì „Ì »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_AxisLabelSep := 'Ãœ«”«“Ì ·Ì»· Â« »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_AxisIncrementNeg := '«›“«Ì‘ „ÕÊ— »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_AxisMinMax := '„ﬁœ«— „Ì‰Ì„Ê„ „ÕÊ— »«Ìœ ﬂÊçﬂ — Ì« „”«ÊÌ „ﬁœ«— „«ﬂ“Ì„„ »«‘œ';
  TeeMsg_AxisMaxMin := '„ﬁœ«— „«ﬂ“Ì„„ „ÕÊ— »«Ìœ »“—ê — Ì« „”«ÊÌ „ﬁœ«— „Ì‰Ì„Ê„ »«‘œ';
  TeeMsg_AxisLogBase := 'Å«ÌÂ „ÕÊ— ·ê«—Ì „Ì »«Ìœ »“—ê — «“ 2 »«‘œ';
  TeeMsg_MaxPointsPerPage := 'MaxPointsPerPage »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_3dPercent := 'œ—’œ 3D Effects »«Ìœ »Ì‰ %d Ê %d »«‘œ';
  TeeMsg_CircularSeries := 'Ê«»” Â Â«Ì ”—ÌÂ«Ì „œÊ— „Ã«“ ‰Ì” ';
  TeeMsg_WarningHiColor := '16k Color Ì« »Ì‘ — »—«Ì ‰„«Ì‘ »« ﬂÌ›Ì  „‰«”» „Ê—œ ‰Ì«“ «” ';

  TeeMsg_DefaultPercentOf := '%s «“ %s';
  TeeMsg_DefaultPercentOf2 := '%s' + #13 + '«“ %s';
  TeeMsg_DefPercentFormat := '##0.## %';
  TeeMsg_DefValueFormat := '#,##0.###';
  TeeMsg_DefLogValueFormat := '#.0 "x10" E+0';
  TeeMsg_AxisTitle := '⁄‰Ê«‰ „ÕÊ—';
  TeeMsg_AxisLabels := '·Ì»·ùÂ«Ì „ÕÊ—';
  TeeMsg_RefreshInterval := 'Refresh Interval Ì«Ìœ »Ì‰ 0 Ê 60 »«‘œ';
  TeeMsg_SeriesParentNoSelf := 'Series.ParentChart ‰„Ì Ê«‰œ »—«»— ŒÊœ »«‘œ';
  TeeMsg_GalleryLine := 'Œÿ';
  TeeMsg_GalleryPoint := '‰ﬁÿÂ';
  TeeMsg_GalleryArea := '‰«ÕÌÂ';
  TeeMsg_GalleryBar := '” Ê‰';
  TeeMsg_GalleryHorizBar := '” Ê‰ «›ﬁÌ';
  TeeMsg_Stack := 'Å‘ Â';
  TeeMsg_GalleryPie := 'Pie';
  TeeMsg_GalleryCircled := '„œÊ—';
  TeeMsg_GalleryFastLine := 'Fast Line';
  TeeMsg_GalleryHorizLine := 'Œÿ «›ﬁÌ';

  TeeMsg_PieSample1 := '„«‘Ì‰Â«';
  TeeMsg_PieSample2 := ' ·›‰Â«';
  TeeMsg_PieSample3 := 'ÃœÊ·Â«';
  TeeMsg_PieSample4 := '„Ê‰Ì Ê—Â«';
  TeeMsg_PieSample5 := '·«„ÅÂ«';
  TeeMsg_PieSample6 := '’›ÕÂ ﬂ·ÌœÂ«';
  TeeMsg_PieSample7 := '„Ê Ê— ”Ìﬂ· Â«';
  TeeMsg_PieSample8 := '’‰œ·ÌÂ«';

  TeeMsg_GalleryLogoFont := 'Courier New';
  TeeMsg_Editing := 'ÊÌ—«Ì‘ %s';

  TeeMsg_GalleryStandard := '«” «‰œ«—œ';
  TeeMsg_GalleryExtended := ' Ê”⁄Â Ì«› Â';
  TeeMsg_GalleryFunctions := ' Ê«»⁄';

  TeeMsg_EditChart := 'ÊÌ—«Ì‘ ç«— ...';
  TeeMsg_PrintPreview := 'ÅÌ‘ ‰„«Ì‘ ç«Å...';
  TeeMsg_ExportChart := 'Export ﬂ—œ‰ ç«— ...';
  TeeMsg_CustomAxes := '„ÕÊ—Â«Ì œ·ŒÊ«Â';

  TeeMsg_InvalidEditorClass := '%s: Ìﬂ ﬂ·«” „⁄ »— Editor ‰Ì” : %s';
  TeeMsg_MissingEditorClass := '%s: œÌ«·Êê Editor ‰œ«—œ';

  TeeMsg_GalleryArrow := 'ÅÌﬂ«‰';

  TeeMsg_ExpFinish := 'Å«Ì«‰';
  TeeMsg_ExpNext := '»⁄œÌ >';

  TeeMsg_GalleryGantt := 'Gantt';

  TeeMsg_GanttSample1 := 'ÿ—«ÕÌ';
  TeeMsg_GanttSample2 := 'ÅÌ‘ ‰ÊÌ” ﬂ—œ‰';
  TeeMsg_GanttSample3 := ' Ê”⁄Â';
  TeeMsg_GanttSample4 := '›—Ê‘Â«';
  TeeMsg_GanttSample5 := '›—Ê‘';
  TeeMsg_GanttSample6 := ' ”  ﬂ—œ‰';
  TeeMsg_GanttSample7 := ' Ê·Ìœ';
  TeeMsg_GanttSample8 := '⁄Ì» Ì«»Ì';
  TeeMsg_GanttSample9 := '‰”ŒÂ ÕœÌœ';
  TeeMsg_GanttSample10 := '⁄„·Ì«  »«‰ﬂÌ';

  TeeMsg_ChangeSeriesTitle := ' €ÌÌ— ÃœÊ· ”—ÌÂ«';
  TeeMsg_NewSeriesTitle := '⁄‰Ê«‰ ”—ÌÂ«Ì ÃœÌœ:';
  TeeMsg_DateTime := ' «—ÌŒ Ê ”«⁄ ';
  TeeMsg_TopAxis := '„ÕÊ— »«·«';
  TeeMsg_BottomAxis := '„ÕÊ— Å«ÌÌ‰';
  TeeMsg_LeftAxis := '„ÕÊ— çÅ';
  TeeMsg_RightAxis := '„ÕÊ— —«” ';

  TeeMsg_SureToDelete := '%s Õ–› ‘Êœø';
  TeeMsg_DateTimeFormat := '›—„   «—ÌŒ Ê ”«⁄ ';
  TeeMsg_Default := 'ÅÌ‘ù ›—÷';
  TeeMsg_ValuesFormat := '›—„  „ﬁ«œÌ—:';
  TeeMsg_Maximum := '„«ﬂ“Ì„„';
  TeeMsg_Minimum := '„Ì‰Ì„Ê„';
  TeeMsg_DesiredIncrement := '«›“«Ì‘ %s „Ê—œ‰Ÿ—';

  TeeMsg_IncorrectMaxMinValue := '„ﬁœ«— ‰«œ—” . œ·Ì·: %s';
  TeeMsg_EnterDateTime := 'Ê«—œ ﬂ‰Ìœ [ ⁄œ«œ —Ê“Â«] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply := ' €ÌÌ—«  «⁄„«· ‘Êœø';
  TeeMsg_SelectedSeries := '(”—ÌÂ«Ì «‰ Œ«» ‘œÂ)';
  TeeMsg_RefreshData := '»—Ê“—”«‰Ì œ«œÂùÂ«';

  TeeMsg_DefaultFontSize := {$IFDEF LINUX} '10'{$ELSE} '8'{$ENDIF};
  TeeMsg_DefaultEditorSize := '414';
  TeeMsg_FunctionAdd := '«›“Êœ‰';
  TeeMsg_FunctionSubtract := 'ﬂ„ ﬂ—œ‰';
  TeeMsg_FunctionMultiply := '÷—»';
  TeeMsg_FunctionDivide := ' ﬁ”Ì„';
  TeeMsg_FunctionHigh := '»“—ê —';
  TeeMsg_FunctionLow := 'ﬂÊçﬂ —';
  TeeMsg_FunctionAverage := '„Ì«‰êÌ‰';

  TeeMsg_GalleryShape := '‘ﬂ·';
  TeeMsg_GalleryBubble := 'Õ»«»';
  TeeMsg_FunctionNone := 'ﬂÅÌ';

  TeeMsg_None := '(ÂÌçﬂœ«„)';

  TeeMsg_PrivateDeclarations := '{ Private declarations }';
  TeeMsg_PublicDeclarations := '{ Public declarations }';
  TeeMsg_DefaultFontName := TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize := 'Pointer size »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_About := 'œ—»«—Â TeeChart...';

  tcAdditional := '«÷«›Â';
  tcDControls := 'Data Controls';
  tcQReport := 'QReport';

  TeeMsg_DataSet := 'Dataset';
  TeeMsg_AskDataSet := '&Dataset:';

  TeeMsg_SingleRecord := 'Single Record';
  TeeMsg_AskDataSource := '&DataSource:';

  TeeMsg_Summary := 'Œ·«’Â';

  TeeMsg_FunctionPeriod := 'Function Period »«Ìœ »“—ê — «“ ’›— »«‘œ';

  TeeMsg_WizardTab := ' Ã«— ';
  TeeMsg_TeeChartWizard := 'TeeChart Wizard';

  TeeMsg_ClearImage := 'Å«ﬂ ﬂ—œ‰';
  TeeMsg_BrowseImage := 'Ì«› ‰...';

  TeeMsg_WizardSureToClose := '¬Ì« „ÿ„∆‰Ìœ ﬂÂ „ÌŒÊ«ÂÌœ TeeChart Wizard —« »»‰œÌœø';
  TeeMsg_FieldNotFound := '›Ì·œ %s ÊÃÊœ ‰œ«—œ';

  TeeMsg_DepthAxis := '„ÕÊ— ⁄„ﬁ';
  TeeMsg_PieOther := '€Ì—Â';
  TeeMsg_ShapeGallery1 := 'abc';
  TeeMsg_ShapeGallery2 := '123';
  TeeMsg_ValuesX := 'X';
  TeeMsg_ValuesY := 'Y';
  TeeMsg_ValuesPie := 'Pie';
  TeeMsg_ValuesBar := '” Ê‰';
  TeeMsg_ValuesAngle := '“«ÊÌÂ';
  TeeMsg_ValuesGanttStart := '‘—Ê⁄';
  TeeMsg_ValuesGanttEnd := 'Å«Ì«‰';
  TeeMsg_ValuesGanttNextTask := '⁄„· »⁄œÌ';
  TeeMsg_ValuesBubbleRadius := '‘⁄«⁄';
  TeeMsg_ValuesArrowEndX := 'EndX';
  TeeMsg_ValuesArrowEndY := 'EndY';
  TeeMsg_Legend := '›Â—”  ⁄·«∆„';
  TeeMsg_Title := '⁄‰Ê«‰';
  TeeMsg_Foot := 'Å«’›ÕÂ';
  TeeMsg_Period := 'œÊ—Â';
  TeeMsg_PeriodRange := '„ÕœÊœÂ œÊ—Â';
  TeeMsg_CalcPeriod := '„Õ«”»Â %s Â—:';
  TeeMsg_SmallDotsPen := '‰ﬁÿÂùÂ«Ì ﬂÊçﬂ';

  TeeMsg_InvalidTeeFile := 'ç«—  „ÊÃÊœ œ— ›«Ì· *.'+TeeMsg_TeeExtension+' „⁄ »— ‰Ì” ';
  TeeMsg_WrongTeeFileFormat := '›—„  ›«Ì· *.'+TeeMsg_TeeExtension+' „‘ﬂ· œ«—œ';
  TeeMsg_EmptyTeeFile := '›«Ì· *.'+TeeMsg_TeeExtension+' Œ«·Ì «” '; { 5.01 }

{$IFDEF D5}
  TeeMsg_ChartAxesCategoryName := '„ÕÊ—Â«Ì ç«— ';
  TeeMsg_ChartAxesCategoryDesc := 'property Â« Ê event Â«Ì „ÕÊ—Â«Ì ç«— ';
  TeeMsg_ChartWallsCategoryName := 'œÌÊ«—ÂùÂ«Ì ç«— ';
  TeeMsg_ChartWallsCategoryDesc := 'property Â« Ê event Â«Ì œÌÊ«—ÂùÂ«Ì ç«— ';
  TeeMsg_ChartTitlesCategoryName := ' Ì —Â«Ì ç«— ';
  TeeMsg_ChartTitlesCategoryDesc := 'property Â« Ê event Â«Ì  Ì —Â«Ì ç«— ';
  TeeMsg_Chart3DCategoryName := 'ç«—  3 »⁄œÌ';
  TeeMsg_Chart3DCategoryDesc := 'property Â« Ê event Â«Ì ç«—  3 »⁄œÌ';
{$ENDIF}

  TeeMsg_CustomAxesEditor := 'œ·ŒÊ«Â ';
  TeeMsg_Series := '”—ÌùÂ«';
  TeeMsg_SeriesList := '”—ÌùÂ«...';

  TeeMsg_PageOfPages := '’›ÕÂ %d «“ %d';
  TeeMsg_FileSize := '%d »«Ì ';

  TeeMsg_First := '«Ê·Ì‰';
  TeeMsg_Prior := 'ﬁ»·Ì';
  TeeMsg_Next := '»⁄œÌ';
  TeeMsg_Last := '¬Œ—Ì‰';
  TeeMsg_Insert := 'œ—Ã';
  TeeMsg_Delete := 'Õ–›';
  TeeMsg_Edit := 'ÊÌ—«Ì‘';
  TeeMsg_Post := 'Å” ';
  TeeMsg_Cancel := '·€Ê';

  TeeMsg_All := '(Â„Â)';
  TeeMsg_Index := '«Ì‰œﬂ”';
  TeeMsg_Text := '„ ‰';

  TeeMsg_AsBMP := 'as &Bitmap';
  TeeMsg_BMPFilter := 'Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF := 'as &Metafile';
  TeeMsg_EMFFilter := 'Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Panel property is not set in Export format';

  TeeMsg_Normal := '„⁄„Ê·Ì';
  TeeMsg_NoBorder := '»œÊ‰ Õ«‘ÌÂ';
  TeeMsg_Dotted := '‰ﬁÿÂ ‰ﬁÿÂ';
  TeeMsg_Colors := '—‰êÌ';
  TeeMsg_Filled := 'Å—‘œÂ';
  TeeMsg_Marks := '⁄·«„ ';
  TeeMsg_Stairs := 'Å·Âù«Ì';
  TeeMsg_Points := '‰ﬁÿÂù«Ì';
  TeeMsg_Height := '»—¬„œÂ';
  TeeMsg_Hollow := '›—Ê—› Â';
  TeeMsg_Point2D := '‰ﬁ«ÿ 2 »⁄œÌ';
  TeeMsg_Triangle := '„À·À';
  TeeMsg_Star := '” «—Â';
  TeeMsg_Circle := 'œ«Ì—Â';
  TeeMsg_DownTri := '„À·À —Ê »Â Å«ÌÌ‰';
  TeeMsg_Cross := '’·Ì»';
  TeeMsg_Diamond := '«·„«”';
  TeeMsg_NoLines := '»œÊ‰ Œÿ';
  TeeMsg_Stack100 := ' ÊœÂ 100%';
  TeeMsg_Pyramid := 'Â—„';
  TeeMsg_Ellipse := '·Ì÷Ì';
  TeeMsg_InvPyramid := 'Â—„ „⁄ﬂÊ”';
  TeeMsg_Sides := '·»Âù«Ì';
  TeeMsg_SideAll := ' „«„ ·»ÂùÂ«';
  TeeMsg_Patterns := '«·êÊ';
  TeeMsg_Exploded := 'ê” —œÂ';
  TeeMsg_Shadow := '”«ÌÂ';
  TeeMsg_SemiPie := '‰Ì„Â Pie';
  TeeMsg_Rectangle := '„” ÿÌ·';
  TeeMsg_VertLine := 'Œÿ ⁄„ÊœÌ';
  TeeMsg_HorizLine := 'Œÿ «›ﬁÌ';
  TeeMsg_Line := 'Œÿ';
  TeeMsg_Cube := '„ﬂ⁄»';
  TeeMsg_DiagCross := '’·Ì» ‘ﬂ” Â';

  TeeMsg_CanNotFindTempPath := '›Ê·œ— temp Ì«›  ‰‘œ';
  TeeMsg_CanNotCreateTempChart := '«„ﬂ«‰ «ÌÃ«œ ›«Ì· temp „ÊÃÊœ ‰Ì” ';
  TeeMsg_CanNotEmailChart := '‰„Ì Ê«‰„ TeeChart —« email ﬂ‰„. «‘ﬂ«· œ— mapi: %d';

  TeeMsg_SeriesDelete := 'Õ–› ”—ÌÂ«: ValueIndex %d Œ«—Ã «“ „ÕœÊœÂ «” .(0  « %d)';

  { 5.02 }{ Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG := 'as &JPEG';
  TeeMsg_JPEGFilter := 'JPEG files (*.jpg)|*.jpg';
  TeeMsg_AsGIF := 'as &GIF';
  TeeMsg_GIFFilter := 'GIF files (*.gif)|*.gif';
  TeeMsg_AsPNG := 'as &PNG';
  TeeMsg_PNGFilter := 'PNG files (*.png)|*.png';
  TeeMsg_AsPCX := 'as PC&X';
  TeeMsg_PCXFilter := 'PCX files (*.pcx)|*.pcx';
  TeeMsg_AsVML := 'as &VML (HTM)';
  TeeMsg_VMLFilter := 'VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage := '“»«‰...';

  { 5.03 }
  TeeMsg_Gradient := 'Gradient';
  TeeMsg_WantToSave := '¬Ì« „ÌŒÊ«ÂÌœ %s —« save ﬂ‰Ìœø';
  TeeMsg_NativeFilter := 'TeeChart files '+TeeDefaultFilterExtension;

  TeeMsg_Property := 'Property';
  TeeMsg_Value := '„ﬁœ«—';
  TeeMsg_Yes := '»·Â';
  TeeMsg_No := '‰Â';
  TeeMsg_Image := '( ’ÊÌ—)';

  { TeeProCo }
  TeeMsg_GalleryPolar := 'ﬁÿ»Ì';
  TeeMsg_GalleryCandle := '‘„⁄';
  TeeMsg_GalleryVolume := ' ÊœÂ';
  TeeMsg_GallerySurface := '”ÿÕ';
  TeeMsg_GalleryContour := '‰ﬁ‘Â »—Ã” Â';
  TeeMsg_GalleryBezier := 'Bezier';
  TeeMsg_GalleryPoint3D := '‰ﬁÿÂ 3 »⁄œÌ';
  TeeMsg_GalleryRadar := '—«œ«—';
  TeeMsg_GalleryDonut := 'Donut';
  TeeMsg_GalleryCursor := 'Cursor';
  TeeMsg_GalleryBar3D := '” Ê‰ 3 »⁄œÌ';
  TeeMsg_GalleryBigCandle := '‘„⁄ »“—ê';
  TeeMsg_GalleryLinePoint := 'Œÿ ‰ﬁÿÂ';
  TeeMsg_GalleryHistogram := 'ÂÌ” Êê—«„';
  TeeMsg_GalleryWaterFall := '¬»‘«—';
  TeeMsg_GalleryWindRose := '‰„Êœ«— Ê÷⁄ ÂÊ«Ê';
  TeeMsg_GalleryClock := '”«⁄ ';
  TeeMsg_GalleryColorGrid := 'ÃœÊ· —‰ê';
  TeeMsg_GalleryBoxPlot := 'Ã⁄»Â —”„';
  TeeMsg_GalleryHorizBoxPlot := 'Ã⁄»Â —”„ «›ﬁÌ';
  TeeMsg_GalleryBarJoin := '” Ê‰ „ ’·';
  TeeMsg_GallerySmith := '¬Â‰ê—';
  TeeMsg_GalleryPyramid := 'Â—„';
  TeeMsg_GalleryMap := '‰ﬁ‘Â';

  TeeMsg_PolyDegreeRange := 'œ—ÃÂ ç‰œÃ„·Âù«Ì »«Ìœ »Ì‰ 1 Ê 20 »«‘œ';
  TeeMsg_AnswerVectorIndex := 'Answer Vector index »«Ìœ »Ì‰ 1 Ê %d »«‘œ';
  TeeMsg_FittingError := '‰„Ì Ê«‰„ „ﬁœ«— „‰«”» —« „Õ«”»Â ﬂ‰„';
  TeeMsg_PeriodRange := 'ê—œ‘ »«Ìœ »“—ê — «“ ’›— »«‘œ';
  TeeMsg_ExpAverageWeight := 'ExpAverage Weight »«Ìœ »Ì‰ 0 Ê 1 »«‘œ';
  TeeMsg_GalleryErrorBar := '” Ê‰ Œÿ«';
  TeeMsg_GalleryError := 'Œÿ«';
  TeeMsg_GalleryHighLow := '»«·«-Å«ÌÌ‰';
  TeeMsg_FunctionMomentum := 'Momentum';
  TeeMsg_FunctionMomentumDiv := 'Momentum Div';
  TeeMsg_FunctionExpAverage := 'Exp. Average';
  TeeMsg_FunctionMovingAverage := 'Moving Avrg.';
  TeeMsg_FunctionExpMovAve := 'Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI := 'R.S.I.';
  TeeMsg_FunctionCurveFitting := 'Curve Fitting';
  TeeMsg_FunctionTrend := 'Trend';
  TeeMsg_FunctionExpTrend := 'Exp.Trend';
  TeeMsg_FunctionLogTrend := 'Log.Trend';
  TeeMsg_FunctionCumulative := 'Cumulative';
  TeeMsg_FunctionStdDeviation := 'Std.Deviation';
  TeeMsg_FunctionBollinger := 'Bollinger';
  TeeMsg_FunctionRMS := 'Root Mean Sq.';
  TeeMsg_FunctionMACD := 'MACD';
  TeeMsg_FunctionStochastic := 'Stochastic';
  TeeMsg_FunctionADX := 'ADX';

  TeeMsg_FunctionCount := ' ⁄œ«œ';
  TeeMsg_LoadChart := '»«“ﬂ—œ‰ TeeChart...';
  TeeMsg_SaveChart := 'save ﬂ—œ‰ TeeChart...';
  TeeMsg_TeeFiles := 'TeeChart Pro ›«Ì·Â«Ì';

  TeeMsg_GallerySamples := '€Ì—Â';
  TeeMsg_GalleryStats := '¬„«—';

  TeeMsg_CannotFindEditor := '‰„Ì Ê«‰„ ›—„ editorù”—ÌÂ« —« ÅÌœ« ﬂ‰„: %s';


  TeeMsg_CannotLoadChartFromURL := 'Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL := 'Error code: %d downloading Series data from URL: %s';

  TeeMsg_ValuesDate := ' «—ÌŒ';
  TeeMsg_ValuesOpen := '»«“';
  TeeMsg_ValuesHigh := '»«·«';
  TeeMsg_ValuesLow := 'Å«ÌÌ‰';
  TeeMsg_ValuesClose := '»” Â';
  TeeMsg_ValuesOffset := '«›” ';
  TeeMsg_ValuesStdError := 'Œÿ«Ì «” «‰œ«—œ';

  TeeMsg_Grid3D := 'Grid 3D';

  TeeMsg_LowBezierPoints := ' ⁄œ«œ ‰ﬁ«ÿ Bezier »«Ìœ »“—ê — «“ 1 »«‘œ';

  { TeeCommander component... }

  TeeCommanMsg_Normal := '‰—„«·';
  TeeCommanMsg_Edit := 'ÊÌ—«Ì‘';
  TeeCommanMsg_Print := 'ç«Å';
  TeeCommanMsg_Copy := 'ﬂÅÌ';
  TeeCommanMsg_Save := '–ŒÌ—Â';
  TeeCommanMsg_3D := '3 »⁄œÌ';

  TeeCommanMsg_Rotating := 'ç—Œ‘: %d∞ »—¬„œêÌ: %d∞';
  TeeCommanMsg_Rotate := 'ç—Œ‘';

  TeeCommanMsg_Moving := '«›”  «›ﬁÌ: %d «›”  ⁄„ÊœÌ: %d';
  TeeCommanMsg_Move := '«‰ ﬁ«·';

  TeeCommanMsg_Zooming := 'Zoom: %d %%';
  TeeCommanMsg_Zoom := 'Zoom';

  TeeCommanMsg_Depthing := '3 Ì⁄œÌ: %d %%';
  TeeCommanMsg_Depth := '⁄„ﬁ';

  TeeCommanMsg_Chart := 'ç«— ';
  TeeCommanMsg_Panel := 'Å«‰·';

  TeeCommanMsg_RotateLabel := '»—«Ì ç—Œ«‰œ‰ %s —« »ﬂ‘Ìœ';
  TeeCommanMsg_MoveLabel := '»—«Ì «‰ ﬁ«· %s —« »ﬂ‘Ìœ';
  TeeCommanMsg_ZoomLabel := '»—«Ì zoom ﬂ—œ‰ %s —« »ﬂ‘Ìœ';
  TeeCommanMsg_DepthLabel := '»—«Ì  €ÌÌ— «‰œ«“Â »’Ê—  3 »⁄œÌ %s —« »ﬂ‘Ìœ';

  TeeCommanMsg_NormalLabel := 'êÊ‘Â Å«ÌÌ‰ çÅ —« »—«Ì zoomùﬂ—œ‰ Ê êÊ‘Â Å«ÌÌ‰ —«”  —« »—«Ì ·€“«‰œ‰ »ﬂ‘Ìœ ';
  TeeCommanMsg_NormalPieLabel := 'Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding := 'Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess := ' ⁄œ«œ ‰ﬁ«ÿ »«Ìœ »Ì‘ — «“ 4 »«‘œ';
  TeeMsg_TriSurfaceAllColinear := ' „«„ ‰ﬁ«ÿ colinear data';
  TeeMsg_TriSurfaceSimilar := '‰ﬁ«ÿ ‘»ÌÂ Â„ Â” ‰œ. «„ﬂ«‰ «Ã—« ÊÃÊœ ‰œ«—œ';
  TeeMsg_GalleryTriSurface := '”ÿÕ „À·ÀÌ';

  TeeMsg_AllSeries := ' „«„ ”—ÌÂ«';
  TeeMsg_Edit := 'ÊÌ—«Ì‘';

  TeeMsg_GalleryFinancial := '„«·Ì';

  TeeMsg_CursorTool := '„ﬂ«‰ ‰„«';
  TeeMsg_DragMarksTool := 'ﬂ‘Ìœ‰ ⁄·«„ Â«';
  TeeMsg_AxisArrowTool := '„ÕÊ— ÅÌﬂ«‰Â«';
  TeeMsg_DrawLineTool := '—”„ Œÿ';
  TeeMsg_NearestTool := '‰“œÌﬂ —Ì‰ ‰ﬁÿÂ';
  TeeMsg_ColorBandTool := '»«‰œ —‰ê';
  TeeMsg_ColorLineTool := 'Œÿ —‰êÌ';
  TeeMsg_RotateTool := 'ç—Œ‘';
  TeeMsg_ImageTool := ' ’ÊÌ—';
  TeeMsg_MarksTipTool := '⁄·«„  ‰ﬂ ÂùÂ«';
  TeeMsg_AnnotationTool := 'Õ«‘ÌÂù‰ÊÌ”Ì';

  TeeMsg_CantDeleteAncestor := '‰„Ì Ê«‰„ Ê«·œ —« Õ–› ﬂ‰„';

  TeeMsg_Load := 'load ﬂ—œ‰...';
  TeeMsg_NoSeriesSelected := 'ÂÌÃ ”—Ìù«Ì «‰ Œ«» ‰‘œÂ «” ';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions := 'ç«— ';
  TeeMsg_CategorySeriesActions := '”—ÌÂ«Ì ç«— ';

  TeeMsg_Action3D := '3 »⁄œÌ';
  TeeMsg_Action3DHint := '”ÊÌç ﬂ—œ‰ »Ì‰ 2 »⁄œÌ Ê 3 »⁄œÌ';
  TeeMsg_ActionSeriesActive := '›⁄«·';
  TeeMsg_ActionSeriesActiveHint := '‰„«Ì‘/Å‰Â«‰ ﬂ—œ‰ ”—ÌÂ«';
  TeeMsg_ActionEditHint := 'ÊÌ—«Ì‘ ç«— ';
  TeeMsg_ActionEdit := 'ÊÌ—«Ì‘...';
  TeeMsg_ActionCopyHint := 'ﬂÅÌ »Â Clipboard';
  TeeMsg_ActionCopy := 'ﬂÅÌ';
  TeeMsg_ActionPrintHint := 'ÅÌ‘ ‰„«Ì‘ ç«Å ç«— ';
  TeeMsg_ActionPrint := 'ç«Å...';
  TeeMsg_ActionAxesHint := '‰„«Ì‘/Å‰Â«‰ ﬂ—œ‰ „ÕÊ—Â«';
  TeeMsg_ActionAxes := '„ÕÊ—Â«';
  TeeMsg_ActionGridsHint := '‰„«Ì‘/Å‰Â«‰ ﬂ—œ‰ grid Â«';
  TeeMsg_ActionGrids := 'gridù Â«';
  TeeMsg_ActionLegendHint := '‰„«Ì‘/Å‰Â«‰ ﬂ—œ‰ ›Â—”  ⁄·«∆„';
  TeeMsg_ActionLegend := '›Â—”  ⁄·«∆„';
  TeeMsg_ActionSeriesEditHint := 'ÊÌ—«Ì‘ ”—ÌÂ«';
  TeeMsg_ActionSeriesMarksHint := '‰„«Ì‘/Å‰Â«‰ ﬂ—œ‰ ⁄·«∆„ ”—ÌÂ«';
  TeeMsg_ActionSeriesMarks := '⁄·«∆„';
  TeeMsg_ActionSaveHint := 'save ﬂ—œ‰ ç«— ';
  TeeMsg_ActionSave := 'save ﬂ—œ‰...';

  TeeMsg_CandleBar := '” Ê‰';
  TeeMsg_CandleNoOpen := 'No Open';
  TeeMsg_CandleNoClose := 'No Close';
  TeeMsg_NoHigh := 'No High';
  TeeMsg_NoLow := 'No Low';
  TeeMsg_ColorRange := '„ÕœÊœÂ —‰ê';
  TeeMsg_WireFrame := 'ﬁ«» „› Ê·Ì';
  TeeMsg_DotFrame := 'ﬁ«» ‰ﬁÿÂù«Ì';
  TeeMsg_Positions := '„Êﬁ⁄Ì Â«';
  TeeMsg_NoGrid := '»œÊ‰ grid';
  TeeMsg_NoPoint := '»œÊ‰ ‰ﬁÿÂ';
  TeeMsg_NoLine := '»œÊ‰ Œÿ';
  TeeMsg_Labels := '·Ì»·ùÂ«';
  TeeMsg_NoCircle := '»œÊ‰ œ«Ì—ÂùÂ«';
  TeeMsg_Lines := 'ŒÿÊÿ';
  TeeMsg_Border := 'Õ«‘ÌÂ';

  TeeMsg_SmithResistance := 'Å«Ìœ«—Ì';
  TeeMsg_SmithReactance := 'Ê«ﬂ‰‘';

  TeeMsg_Column := '” Ê‰';

  { 5.01 }
  TeeMsg_Separator := 'Ãœ«ﬂ‰‰œÂ';
  TeeMsg_FunnelSegment := 'ﬁÿ⁄Â ';
  TeeMsg_FunnelSeries := 'ﬁÌ›';
  TeeMsg_FunnelPercent := '0.00 %';
  TeeMsg_FunnelExceed := '›—« — «“ „ﬁœ«— „Ã«“';
  TeeMsg_FunnelWithin := '  «“ „ﬁœ«— „Ã«“';
  TeeMsg_FunnelBelow := ' Ì« »Ì‘ — «“ „ﬁœ«— Õœ«ﬁ· „Ã«“';
  TeeMsg_CalendarSeries := ' ﬁÊÌ„';
  TeeMsg_DeltaPointSeries := 'DeltaPoint';
  TeeMsg_ImagePointSeries := 'ImagePoint';
  TeeMsg_ImageBarSeries := 'ImageBar';
  TeeMsg_SeriesTextFieldZero := 'SeriesText: Field index »«Ìœ »“—ê — «“ ’›— »«‘œ.';

  { 5.02 }
  TeeMsg_Origin := '„»œ«';
  TeeMsg_Transparency := '‘›«›Ì ';
  TeeMsg_Box := 'Ã⁄»Â';
  TeeMsg_ExtrOut := 'ExtrOut';
  TeeMsg_MildOut := 'MildOut';
  TeeMsg_PageNumber := '‘„«—Â ’›ÕÂ';
  TeeMsg_TextFile := '›«Ì· Text';

  { 5.03 }
  TeeMsg_DragPoint := '‰ﬁÿÂ ò‘‘';
  TeeMsg_OpportunityValues := 'OpportunityValues';
  TeeMsg_QuoteValues := 'QuoteValues';
end;

procedure TeeCreateFarsi;
begin
  if not Assigned(TeeFarsiLanguage) then
  begin
    TeeFarsiLanguage := TStringList.Create;
    TeeFarsiLanguage.Text :=

    'LABELS=·Ì»· Â«' + #13 +
      'DATASET=Dataset' + #13 +
      'ALL RIGHTS RESERVED.= „«„ ÕﬁÊﬁ „Õ›ÊŸ «” ' + #13 +
      'APPLY=«⁄„«·' + #13 +
      'CLOSE=»” ‰' + #13 +
      'OK=À»Ê·' + #13 +
      'ABOUT TEECHART PRO V7.0=œ—»«—Â TeeChart Pro v7.0' + #13 +
      'OPTIONS=ê“Ì‰Â Â«' + #13 +
      'FORMAT=›—„ ' + #13 +
      'TEXT=„ ‰' + #13 +
      'GRADIENT=Gradient' + #13 +
      'SHADOW=”«ÌÂ' + #13 +
      'POSITION=„Êﬁ⁄Ì ' + #13 +
      'LEFT=çÅ' + #13 +
      'TOP=»«·«' + #13 +
      'CUSTOM=œ·ŒÊ«Â' + #13 +
      'PEN=ﬁ·„' + #13 +
      'PATTERN=«·êÊ' + #13 +
      'SIZE=«‰œ«“Â' + #13 +
      'BEVEL=«—Ì»' + #13 +
      'INVERTED=„⁄òÊ”' + #13 +
      'INVERTED SCROLL=·€“‘ „⁄òÊ”' + #13 +
      'BORDER=Õ«‘ÌÂ' + #13 +
      'ORIGIN=„»œ«' + #13 +
      'USE ORIGIN=«” ›«œÂ «“ „»œ«' + #13 +
      'AREA LINES=ŒÿÊÿ ‰«ÕÌÂ' + #13 +
      'AREA=‰«ÕÌÂ' + #13 +
      'COLOR=—‰ê' + #13 +
      'SERIES=”—ÌÂ«' + #13 +
      'SUM=Ã„⁄' + #13 +
      'DAY=—Ê“' + #13 +
      'QUARTER=—»⁄' + #13 +
      '(MAX)=(max)' + #13 +
      '(MIN)=(min)' + #13 +
      'VISIBLE=„—∆Ì' + #13 +
      'CURSOR=„ò«‰ ‰„«' + #13 +
      'GLOBAL=ò—ÊÌ' + #13 +
      'X=X' + #13 +
      'Y=Y' + #13 +
      'Z=Z' + #13 +
      '3D=3 »⁄œÌ' + #13 +
      'HORIZ. LINE=Œÿ «›ﬁÌ.' + #13 +
      'LABEL AND PERCENT=·Ì»· Ê œ—’œ' + #13 +
      'LABEL AND VALUE=·Ì»· Ê „ﬁœ«—' + #13 +
      'LABEL AND PERCENT TOTAL=·Ì»· Ê œ—’œ „Ã„Ê⁄' + #13 +
      'PERCENT TOTAL=œ—’œ „Ã„Ê⁄' + #13 +
      'MSEC.=msec.' + #13 +
      'SUBTRACT=ò«Â‘' + #13 +
      'MULTIPLY=÷—»' + #13 +
      'DIVIDE= ﬁ”Ì„' + #13 +
      'STAIRS=Å·Â Â«' + #13 +
      'MOMENTUM=„ﬁœ«— Õ—ò ' + #13 +
      'AVERAGE=„Ì«‰êÌ‰' + #13 +
      'XML=XML' + #13 +
      'HTML TABLE=ÃœÊ· HTML' + #13 +
      'EXCEL=Excel' + #13 +
      'NONE=ÂÌçòœ«„' + #13 +
      '(NONE)=ÂÌçòœ«„'#13 +
      'WIDTH=⁄—÷' + #13 +
      'HEIGHT=«— ›«⁄' + #13 +
      'COLOR EACH=—‰ê Â—òœ«„' + #13 +
      'STACK= ÊœÂ' + #13 +
      'STACKED= ÊœÂ «Ì' + #13 +
      'STACKED 100%= ÊœÂ  100%' + #13 +
      'AXIS=„ÕÊ—' + #13 +
      'LENGTH=ÿÊ·' + #13 +
      'CANCEL=·€Ê' + #13 +
      'SCROLL=·€“‘' + #13 +
      'INCREMENT=«›“«Ì‘' + #13 +
      'VALUE=„ﬁœ«—' + #13 +
      'STYLE=«” Ì·' + #13 +
      'JOIN=« ’«·' + #13 +
      'AXIS INCREMENT=«›“«Ì‘ „ÕÊ—' + #13 +
      'AXIS MAXIMUM AND MINIMUM=„«ﬂ“Ì„„ Ê „Ì‰Ì„Ê„ „ÕÊ—' + #13 +
      '% BAR WIDTH=% ⁄—÷ ” Ê‰' + #13 +
      '% BAR OFFSET=% «›”  ” Ê‰' + #13 +
      'BAR SIDE MARGINS=Õ«‘ÌÂ ÿ—›Ì‰ ” Ê‰' + #13 +
      'AUTO MARK POSITION=⁄·«„ ê–«—Ì « Ê„« Ìﬂ „Êﬁ⁄Ì ' + #13 +
      'DARK BAR 3D SIDES=ÿ—›Ì‰  «—Ìﬂ ” Ê‰ ”Â »⁄œÌ' + #13 +
      'MONOCHROME= ﬂ —‰ê' + #13 +
      'COLORS=—‰êÂ«' + #13 +
      'DEFAULT=ÅÌ‘ ›—÷' + #13 +
      'MEDIAN=„Ì«‰Â' + #13 +
      'IMAGE= ’ÊÌ—' + #13 +
      'DAYS=—Ê“Â«' + #13 +
      'WEEKDAYS=—Ê“Â«Ì Â› Â' + #13 +
      'TODAY=«„—Ê“' + #13 +
      'SUNDAY=Ìﬂ‘‰»Â' + #13 +
      'MONTHS=„«ÂÂ«' + #13 +
      'LINES=ŒÿÊÿ' + #13 +
      'UPPERCASE=Õ—Ê› »“—ê' + #13 +
      'STICK=‘„⁄' + #13 +
      'CANDLE WIDTH=⁄—÷ ‘„⁄' + #13 +
      'BAR=” Ê‰' + #13 +
      'OPEN CLOSE=»«“ Ê »” Â' + #13 +
      'DRAW 3D=—”„ ”Â »⁄œÌ' + #13 +
      'DARK 3D= Ì—Â 3 »⁄œÌ' + #13 +
      'SHOW OPEN=‰„«Ì »«“' + #13 +
      'SHOW CLOSE=‰„«Ì »” Â' + #13 +
      'UP CLOSE=‰„«Ì »«·«' + #13 +
      'DOWN CLOSE=‰„«Ì Å«ÌÌ‰' + #13 +
      'CIRCLED=„œÊ—' + #13 +
      'CIRCLE=œ«Ì—Â' + #13 +
      '3 DIMENSIONS=3 »⁄œÌ' + #13 +
      'ROTATION=ç—Œ‘' + #13 +
      'RADIUS=‘⁄«⁄' + #13 +
      'HOURS=”«⁄ ' + #13 +
      'HOUR=”«⁄ ' + #13 +
      'MINUTES=œﬁÌﬁÂ' + #13 +
      'SECONDS=À«‰ÌÂ' + #13 +
      'FONT=›Ê‰ ' + #13 +
      'INSIDE=œ«Œ·' + #13 +
      'ROTATED=ç—Œ‘ Ì«› Â' + #13 +
      'ROMAN=—Ê„Ì' + #13 +
      'TRANSPARENCY=‘›«›Ì ' + #13 +
      'DRAW BEHIND=—”„ Å‘ ' + #13 +
      'RANGE=„ÕœÊœÂ' + #13 +
      'PALETTE=Å«· ' + #13 +
      'STEPS=ﬁœ„' + #13 +
      'GRID=Grid' + #13 +
      'GRID SIZE=«‰œ«“Â Grid' + #13 +
      'ALLOW DRAG=«Ã«“Â —”„' + #13 +
      'AUTOMATIC=« Ê„« Ìﬂ' + #13 +
      'LEVEL=”ÿÕ' + #13 +
      'LEVELS POSITION=„Êﬁ⁄Ì  ”ÿÊÕ' + #13 +
      'SNAP=êÌ—' + #13 +
      'FOLLOW MOUSE=ÅÌ—ÊÌ «“ „«Ê”' + #13 +
      'TRANSPARENT=‘›«›' + #13 +
      'ROUND FRAME=ﬁ«» ê—œ' + #13 +
      'FRAME=ﬁ«»' + #13 +
      'START=‘—Ê⁄' + #13 +
      'END=Å«Ì«‰' + #13 +
      'MIDDLE=Ê”ÿ' + #13 +
      'NO MIDDLE=»œÊ‰ Ê”ÿ' + #13 +
      'DIRECTION=ÃÂ ' + #13 +
      'DATASOURCE=DataSource' + #13 +
      'AVAILABLE=„ÊÃÊœ' + #13 +
      'SELECTED=«‰ Œ«» ‘œÂ' + #13 +
      'CALC=„Õ«”»Â' + #13 +
      'GROUP BY=ê—ÊÂ »«' + #13 +
      'OF=«“' + #13 +
      'HOLE %=% Õ›—Â' + #13 +
      'RESET POSITIONS=reset ﬂ—œ‰ „Êﬁ⁄Ì Â«' + #13 +
      'MOUSE BUTTON=œﬂ„Â „«Ê”' + #13 +
      'ENABLE DRAWING=›⁄«· ﬂ—œ‰ —”„' + #13 +
      'ENABLE SELECT=›⁄«· ﬂ—œ‰ «‰ Œ«»' + #13 +
      'ORTHOGONAL=ﬁ«∆„' + #13 +
      'ANGLE=“«ÊÌÂ' + #13 +
      'ZOOM TEXT=zoom „ ‰' + #13 +
      'PERSPECTIVE=ç‘„ù«‰œ«“' + #13 +
      'ZOOM=Zoom' + #13 +
      'ELEVATION=»—¬„œêÌ' + #13 +
      'BEHIND=Å‘ ' + #13 +
      'AXES=„ÕÊ—Â«' + #13 +
      'SCALES=„ﬁÌ«”' + #13 +
      'TITLE= Ì —' + #13 +
      'TICKS= Ìﬂ' + #13 +
      'MINOR=ﬂÊçﬂ —' + #13 +
      'CENTERED=Ê”ÿ' + #13 +
      'CENTER=„—ﬂ“' + #13 +
      'PATTERN COLOR EDITOR=ÊÌ—«Ì‘ê— —‰ê «·êÊ' + #13 +
      'START VALUE=„ﬁœ«— ‘—Ê⁄' + #13 +
      'END VALUE=„ﬁœ«— Å«Ì«‰' + #13 +
      'COLOR MODE=Õ«·  —‰ê' + #13 +
      'LINE MODE=Õ«·  Œÿ' + #13 +
      'HEIGHT 3D=«— ›«⁄ 3 »⁄œÌ' + #13 +
      'OUTLINE=ÿ—Õ' + #13 +
      'PRINT PREVIEW=ÅÌ‘ù‰„«Ì‘ ç«Å' + #13 +
      'ANIMATED=„ Õ—ﬂ' + #13 +
      'ALLOW=«Ã«“Â œ«œ‰' + #13 +
      'DASH=Œÿ ›«’·Â' + #13 +
      'DOT=‰ﬁÿÂ' + #13 +
      'DASH DOT DOT=Œÿ ‰ﬁÿÂ ‰ﬁÿÂ' + #13 +
      'PALE=ﬂ„—‰ê' + #13 +
      'STRONG=Å——‰ê' + #13 +
      'WIDTH UNITS=Ê«Õœ ⁄—÷' + #13 +
      'FOOT=Å«ÌÂ' + #13 +
      'SUBFOOT=“Ì— Å«ÌÂ' + #13 +
      'SUBTITLE= Ì — ›—⁄Ì' + #13 +
      'LEGEND=›Â—” ' + #13 +
      'COLON=⁄·«„  œÊ ‰ﬁÿÂ' + #13 +
      'AXIS ORIGIN=„»œ« „ÕÊ—' + #13 +
      'UNITS=Ê«ÕœÂ«' + #13 +
      'PYRAMID=Â—„' + #13 +
      'DIAMOND=«·„«”' + #13 +
      'CUBE=„ﬂ⁄»' + #13 +
      'TRIANGLE=„À·À' + #13 +
      'STAR=” «—Â' + #13 +
      'SQUARE=œ«»—Â' + #13 +
      'DOWN TRIANGLE=„À·À —Ê»Â Å«ÌÌ‰' + #13 +
      'SMALL DOT=‰ﬁÿÂ ﬂÊçﬂ' + #13 +
      'LOAD=»«—ê–«—Ì' + #13 +
      'FILE=ﬁ«Ì·' + #13 +
      'RECTANGLE=„—»⁄' + #13 +
      'HEADER=⁄‰Ê«‰' + #13 +
      'CLEAR=Å«ﬂ ﬂ—œ‰' + #13 +
      'ONE HOUR=Ìﬂ ”«⁄ ' + #13 +
      'ONE YEAR=Ìﬂ ”«·' + #13 +
      'ELLIPSE=»Ì÷Ì' + #13 +
      'CONE=„Œ—Êÿ' + #13 +
      'ARROW=ÅÌﬂ«‰' + #13 +
      'CYLLINDER=«” Ê«‰Â' + #13 +
      'TIME=“„«‰' + #13 +
      'BRUSH=ﬁ·„ „Ê' + #13 +
      'LINE=Œÿ' + #13 +
      'VERTICAL LINE=Œÿ ⁄„ÊœÌ' + #13 +
      'AXIS ARROWS=ÅÌﬂ«‰Â«Ì „ÕÊ—Â«' + #13 +
      'MARK TIPS=‰ÊﬂÂ«Ì ⁄·«„ ê–«—Ì' + #13 +
      'DASH DOT=Œÿ ‰ﬁÿÂ' + #13 +
      'COLOR BAND=‰Ê«— —‰êÌ' + #13 +
      'COLOR LINE=Œÿ —‰êÌ' + #13 +
      'INVERT. TRIANGLE=„À·À „⁄ﬂÊ”' + #13 +
      'INVERT. PYRAMID=Â—„ „⁄ﬂÊ”' + #13 +
      'INVERTED PYRAMID=Â—„ „⁄ﬂÊ”' + #13 +
      'SERIES DATASOURCE TEXT EDITOR=ÊÌ—«Ì‘ê— „ ‰ DataSource ”—ÌÂ«' + #13 +
      'SOLID=Ã«„œ' + #13 +
      'WIREFRAME=ﬁ«» „› Ê·Ì' + #13 +
      'DOTFRAME=ﬁ«» ‰ﬁÿÂù«Ì' + #13 +
      'SIDE BRUSH=ﬁ·„ù„ÊÌ ÿ—›Ì‰' + #13 +
      'SIDE=ÿ—›' + #13 +
      'SIDE ALL=Â„Â ÿ—›' + #13 +
      'ROTATE=ç—Œ«‰œ‰' + #13 +
      'SMOOTH PALETTE=Å«·  „·«Ì„' + #13 +
      'CHART TOOLS GALLERY=ê«·—Ì «»“«—Â«Ì ç«— ' + #13 +
      'ADD=«›“Êœ‰' + #13 +
      'BORDER EDITOR=ÊÌ—«Ì‘ê— Õ«‘ÌÂ' + #13 +
      'DRAWING MODE=Õ«·  —”„' + #13 +
      'CLOSE CIRCLE=œ«Ì—Â »” Â' + #13 +
      'PICTURE= ’ÊÌ—' + #13 +
      'NATIVE=ÿ»Ì⁄Ì' + #13 +
      'DATA=œ«œÂùÂ«' + #13 +
      'KEEP ASPECT RATIO=Õ›Ÿ ‰”»  Ÿ«Â—Ì' + #13 +
      'COPY=ﬂÅÌ' + #13 +
      'SAVE=–ŒÌ—Â' + #13 +
      'SEND=›—” «œ‰' + #13 +
      'INCLUDE SERIES DATA=‘«„· ”—Ì œ«œÂùÂ«' + #13 +
      'FILE SIZE=”«Ì“ ›«Ì·' + #13 +
      'INCLUDE=‘«„·' + #13 +
      'POINT INDEX=«Ì‰œﬂ” ‰ﬁÿÂ' + #13 +
      'POINT LABELS=·Ì»·Â«Ì ‰ﬁ«ÿ' + #13 +
      'DELIMITER=Ãœ«ﬂ‰‰œÂ' + #13 +
      'DEPTH=⁄„ﬁ' + #13 +
      'COMPRESSION LEVEL=„Ì“«‰ ›‘—œÂ ”«“Ì' + #13 +
      'COMPRESSION=›‘—œÂù”«“Ì' + #13 +
      'PATTERNS=«·êÊÂ«' + #13 +
      'LABEL=·Ì»·ùÂ«' + #13 +
      'GROUP SLICES=ﬁÿ⁄ÂùÂ«Ì ê—ÊÂ' + #13 +
      'EXPLODE BIGGEST=»“—ê —Ì‰  ﬂÂ' + #13 +
      'TOTAL ANGLE=„Ã„Ê⁄ “«ÊÌÂ' + #13 +
      'HORIZ. SIZE=”«Ì“ «›ﬁÌ' + #13 +
      'VERT. SIZE=”«Ì“ ⁄„ÊœÌ' + #13 +
      'SHAPES=«‘ﬂ«·' + #13 +
      'INFLATE MARGINS= Ê—„ Õ«‘ÌÂùÂ«' + #13 +
      'QUALITY=ﬂÌ›Ì ' + #13 +
      'SPEED=”—⁄ ' + #13 +
      '% QUALITY=% ﬂÌ›Ì ' + #13 +
      'GRAY SCALE=ÿÌ› Œ«ﬂ” —Ì' + #13 +
      'PERFORMANCE=»«“œÂ' + #13 +
      'BROWSE=Ì«› ‰' + #13 +
      'TILED=„Ê“«∆ÌﬂÌ' + #13 +
      'HIGH=»«·«' + #13 +
      'LOW=Å«ÌÌ‰' + #13 +
      'DATABASE CHART=ç«—  »«‰ﬂ «ÿ·«⁄« ' + #13 +
      'NON DATABASE CHART=ç«—  €Ì— »«‰ﬂ «ÿ·«⁄« ' + #13 +
      'HELP=ﬂ„ﬂ' + #13 +
      'NEXT >=»⁄œÌ >' + #13 +
      '< BACK=< ﬁ»·Ì' + #13 +
      'TEECHART WIZARD=TeeChart Wizard' + #13 +
      'PERCENT=œ—’œ' + #13 +
      'PIXELS=‰ﬁ«ÿ' + #13 +
      'ERROR WIDTH=«‘ﬂ«· œ— ⁄—÷' + #13 +
      'ENHANCED=ê” —œÂ' + #13 +
      'VISIBLE WALLS=œÌÊ«—ÂùÂ«Ì „—∆Ì' + #13 +
      'ACTIVE=›⁄«·' + #13 +
      'DELETE=Õ–›' + #13 +
      'ALIGNMENT= —«“' + #13 +
      'ADJUST FRAME= €ÌÌ— ﬁ«»' + #13 +
      'HORIZONTAL=«›ﬁÌ' + #13 +
      'VERTICAL=⁄„ÊœÌ' + #13 +
      'VERTICAL POSITION=„Êﬁ⁄Ì  ⁄„ÊœÌ' + #13 +
      'NUMBER=⁄œœ' + #13 +
      'LEVELS=”ÿÊÕ' + #13 +
      'OVERLAP=Â„ÅÊ‘«‰Ì' + #13 +
      'STACK 100%= ÊœÂ 100%' + #13 +
      'MOVE=«‰ ﬁ«·' + #13 +
      'CLICK=ﬂ·Ìﬂ' + #13 +
      'DELAY= «ŒÌ—' + #13 +
      'DRAW LINE=—”„ Œÿ' + #13 +
      'FUNCTIONS= Ê«»⁄' + #13 +
      'SOURCE SERIES=”—ÌÂ«Ì „»œ«' + #13 +
      'ABOVE=»«·«Ì' + #13 +
      'BELOW=Å«ÌÌ‰' + #13 +
      'Dif. Limit=Õœ «Œ ·«›' + #13 +
      'WITHIN=»«' + #13 +
      'EXTENDED= Ê”⁄Â Ì«› Â' + #13 +
      'STANDARD=«” «‰œ«—œ' + #13 +
      'STATS=¬„«—' + #13 +
      'FINANCIAL=„«·Ì' + #13 +
      'OTHER=€Ì—Â' + #13 +
      'TEECHART GALLERY=ê«·—Ì TeeChart' + #13 +
      'CONNECTING LINES=ŒÿÊÿ « ’«·' + #13 +
      'REDUCTION= ﬁ·Ì·' + #13 +
      'LIGHT=”»ﬂ' + #13 +
      'INTENSITY=‘œ ' + #13 +
      'FONT OUTLINES=›Ê‰  ÿ—Õ' + #13 +
      'SMOOTH SHADING=”«ÌÂ „·«Ì„' + #13 +
      'AMBIENT LIGHT=‰Ê— „ÕœÊœ' + #13 +
      'MOUSE ACTION=⁄ﬂ”ù«·⁄„· „«Ê”' + #13 +
      'CLOCKWISE=ÃÂ  ⁄ﬁ—»ÂùÂ«Ì ”«⁄ ' + #13 +
      'ANGLE INCREMENT=«›“«Ì‘ “«ÊÌÂ' + #13 +
      'RADIUS INCREMENT=«›“«Ì‘ ‘⁄«⁄' + #13 +
      'PRINTER=ç«Åê—' + #13 +
      'SETUP=—«Âù «‰œ«“Ì' + #13 +
      'ORIENTATION=ê—«Ì‘' + #13 +
      'PORTRAIT=⁄„ÊœÌ' + #13 +
      'LANDSCAPE=«›ﬁÌ' + #13 +
      'MARGINS (%)=Õ«‘ÌÂùÂ« (%)' + #13 +
      'MARGINS=Õ«‘ÌÂùÂ«' + #13 +
      'DETAIL=Ã“∆Ì« ' + #13 +
      'MORE=»Ì‘ —' + #13 +
      'PROPORTIONAL=„ ‰«”»' + #13 +
      'VIEW MARGINS=„‘«ÂœÂ Õ«‘ÌÂùÂ«' + #13 +
      'RESET MARGINS=reset ﬂ—œ‰ Õ«‘ÌÂùÂ«' + #13 +
      'PRINT=ç«Å' + #13 +
      'TEEPREVIEW EDITOR=ÊÌ—«Ì‘ê— TeePreview' + #13 +
      'ALLOW MOVE=«Ã«“Â «‰ ﬁ«·' + #13 +
      'ALLOW RESIZE=«Ã«“Â  €ÌÌ— «‰œ«“Â' + #13 +
      'SHOW IMAGE=‰„«Ì‘  ’ÊÌ—' + #13 +
      'DRAG IMAGE=ﬂ‘Ìœ‰  ’ÊÌ—' + #13 +
      'AS BITMAP=»⁄‰Ê«‰ Bitmap' + #13 +
      'SIZE %=«‰œ«“Â %' + #13 +
      'FIELDS=›Ì·œÂ«' + #13 +
      'SOURCE=„»œ«' + #13 +
      'SEPARATOR=Ãœ«ﬂ‰‰œÂ' + #13 +
      'NUMBER OF HEADER LINES= ⁄œ«œ ŒÿÊÿ ”—’›ÕÂ' + #13 +
      'COMMA=ÊÌ—êÊ·' + #13 +
      'EDITING=ÊÌ—«Ì‘' + #13 +
      'TAB=Tab' + #13 +
      'SPACE=›«’·Â' + #13 +
      'ROUND RECTANGLE=„” ÿÌ· êÊ‘Â ê—œ' + #13 +
      'BOTTOM=Å«ÌÌ‰' + #13 +
      'RIGHT=—«” ' + #13 +
      'C PEN=ﬁ·„ C' + #13 +
      'R PEN=ﬁ·„ R' + #13 +
      'C LABELS=·Ì»·ùÂ«Ì C' + #13 +
      'R LABELS=·Ì»·ùÂ«Ì R' + #13 +
      'MULTIPLE BAR=ç‰œ ” Ê‰Ì' + #13 +
      'MULTIPLE AREAS=ç‰œ ‰«ÕÌÂù«Ì' + #13 +
      'STACK GROUP=ê—ÊÂ  ÊœÂù«Ì' + #13 +
      'BOTH=Â— œÊ' + #13 +
      'BACK DIAGONAL=Å‘  „Ê—»' + #13 +
      'B.DIAGONAL=„Ê—» „⁄ﬂÊ”' + #13 +
      'DIAG.CROSS=„Ê—» ’·Ì»Ì' + #13 +
      'WHISKER=Whisker' + #13 +
      'CROSS=’·Ì»' + #13 +
      'DIAGONAL CROSS=’·Ì» „Ê—»' + #13 +
      'LEFT RIGHT=çÅ —«” ' + #13 +
      'RIGHT LEFT=—«”  çÅ' + #13 +
      'FROM CENTER=«“ Ê”ÿ' + #13 +
      'FROM TOP LEFT=«“ êÊ‘Â »«·«Ì çÅ' + #13 +
      'FROM BOTTOM LEFT=«“ êÊ‘Â Å«ÌÌ‰ —«” ' + #13 +
      'SHOW WEEKDAYS=‰„«Ì‘ —Ê“Â«Ì Â› Â' + #13 +
      'SHOW MONTHS=‰„«Ì‘ „«ÂÂ«' + #13 +
      'SHOW PREVIOUS BUTTON=‰„«Ì‘ œﬂ„Â ﬁ»·Ì'#13 +
      'SHOW NEXT BUTTON=‰„«Ì‘ œﬂ„Â »⁄œÌ'#13 +
      'TRAILING DAYS=—Ê“Â«Ì œ‰»«·Â' + #13 +
      'SHOW TODAY=‰„«Ì‘ «„—Ê“' + #13 +
      'TRAILING=œ‰»«·Â' + #13 +
      'LOWERED=›—Ê—› Â' + #13 +
      'RAISED=»—¬„œÂ' + #13 +
      'HORIZ. OFFSET=«›”  «›ﬁÌ' + #13 +
      'VERT. OFFSET=«›”  ⁄„ÊœÌ' + #13 +
      'INNER=œ—Ê‰Ì' + #13 +
      'LEN=ÿÊ·' + #13 +
      'AT LABELS ONLY=›ﬁÿ œ— ·Ì»·ùÂ«' + #13 +
      'MAXIMUM=„«ﬂ“Ì„„' + #13 +
      'MINIMUM=„Ì‰Ì„Ê„' + #13 +
      'CHANGE= €ÌÌ—' + #13 +
      'LOGARITHMIC=·ê«—Ì „Ì' + #13 +
      'LOG BASE=Å«ÌÂ Log.' + #13 +
      'DESIRED INCREMENT=«›“«Ì‘ „Ê—œ‰Ÿ—' + #13 +
      '(INCREMENT)=(«›“«Ì‘)' + #13 +
      'MULTI-LINE=ç‰œŒÿÌ' + #13 +
      'MULTI LINE=ç‰œŒÿÌ' + #13 +
      'RESIZE CHART= €ÌÌ— «‰œ«“Â ç«— ' + #13 +
      'X AND PERCENT=X Ê œ—’œ' + #13 +
      'X AND VALUE=X Ê „ﬁœ«—' + #13 +
      'RIGHT PERCENT=œ—’œ —«” ' + #13 +
      'LEFT PERCENT=œ—’œ çÅ' + #13 +
      'LEFT VALUE=„ﬁœ«— çÅ' + #13 +
      'RIGHT VALUE=œ—’œ —«” ' + #13 +
      'PLAIN=„”ÿÕ' + #13 +
      'LAST VALUES=¬Œ—Ì‰ „ﬁ«œÌ—' + #13 +
      'SERIES VALUES=„ﬁœ«— ”—Ì' + #13 +
      'SERIES NAMES=‰«„Â«Ì ”—ÌÂ«' + #13 +
      'NEW=ÃœÌœ' + #13 +
      'EDIT=ÊÌ—«Ì‘' + #13 +
      'PANEL COLOR=—‰ê Å«‰·' + #13 +
      'TOP BOTTOM=»«·« Å«ÌÌ‰' + #13 +
      'BOTTOM TOP=Å«ÌÌ‰ »«·«' + #13 +
      'DEFAULT ALIGNMENT= —«“ ÅÌ‘ù ›—÷' + #13 +
      'EXPONENTIAL=‰„«ÌÌ' + #13 +
      'LABELS FORMAT=›—„  ·Ì»·ùÂ«' + #13 +
      'MIN. SEPARATION %=% Õœ«ﬁ· Ãœ«”«“Ì' + #13 +
      'YEAR=”«·' + #13 +
      'MONTH=„«Â' + #13 +
      'WEEK=Â› Â' + #13 +
      'WEEKDAY=—Ê“Â› Â' + #13 +
      'MARK=⁄·«„ ' + #13 +
      'ROUND FIRST=œÊ— «Ê·' + #13 +
      'LABEL ON AXIS=·Ì»·ùÂ« »— —ÊÌ „ÕÊ—Â«' + #13 +
      'COUNT= ⁄œ«œ' + #13 +
      'POSITION %=„Êﬁ⁄Ì  %' + #13 +
      'START %=‘—Ê⁄ %' + #13 +
      'END %=Å«Ì«‰ %' + #13 +
      'OTHER SIDE=ÿ—› œÌê—' + #13 +
      'INTER-CHAR SPACING=›«’·Â »Ì‰ ç«— Â«' + #13 +
      'VERT. SPACING=›«’·Â ⁄„ÊœÌ' + #13 +
      'POSITION OFFSET %=«›”  „Êﬁ⁄Ì  %' + #13 +
      'GENERAL=⁄„Ê„Ì' + #13 +
      'MANUAL=œ” Ì' + #13 +
      'PERSISTENT=„«‰œê«—' + #13 +
      'PANEL=Å«‰·' + #13 +
      'ALIAS=‰«„ „” ⁄«—' + #13 +
      '2D=2 »⁄œÌ' + #13 +
      'ADX=ADX' + #13 +
      'BOLLINGER=Bollinger' + #13 +
      'TEEOPENGL EDITOR=ÊÌ—«Ì‘ê— OpenGL' + #13 +
      'FONT 3D DEPTH=⁄„ﬁ ›Ê‰  3 »⁄œÌ' + #13 +
      'NORMAL=‰—„«·' + #13 +
      'TEEFONT EDITOR=ÊÌ—«Ì‘ê— ›Ê‰ ' + #13 +
      'CLIP POINTS=‰ﬁ«ÿ »—‘' + #13 +
      'CLIPPED=»—ÌœÂ' + #13 +
      '3D %=3 »⁄œÌ %' + #13 +
      'QUANTIZE=Å·Âù«Ì ﬂ—œ‰' + #13 +
      'QUANTIZE 256=Å·Âù«Ì ﬂ—œ‰ 256' + #13 +
      'DITHER=·—“Ìœ‰' + #13 +
      'VERTICAL SMALL=⁄„ÊœÌ ﬂÊçﬂ' + #13 +
      'HORIZ. SMALL=«›ﬁÌ ﬂÊçﬂ' + #13 +
      'DIAG. SMALL=ﬂ‘‘ ﬂÊçﬂ' + #13 +
      'BACK DIAG. SMALL=Å‘  „Ê—» ﬂÊçﬂ' + #13 +
      'DIAG. CROSS SMALL=’·Ì» „Ê—» ﬂÊçﬂ' + #13 +
      'MINIMUM PIXELS=„Ì‰Ì„Ê„ ‰ﬁ«ÿ' + #13 +
      'ALLOW SCROLL=«Ã«“Â ·€“‘' + #13 +
      'SWAP=„⁄«Ê÷Â' + #13 +
      'GRADIENT EDITOR=«œÌ Ê— Gradient' + #13 +
      'TEXT STYLE=«” Ì· „ ‰' + #13 +
      'DIVIDING LINES=ŒÿÊÿ  ﬁ”Ì„ ﬂ‰‰œÂ' + #13 +
      'SYMBOLS=”„»Ê·ùÂ«' + #13 +
      'CHECK BOXES=çﬂ »«ﬂÂ«' + #13 +
      'FONT SERIES COLOR=›Ê‰  ”—ÌÂ«Ì —‰êÌ' + #13 +
      'LEGEND STYLE=«” Ì· ›Â—” ' + #13 +
      'POINTS PER PAGE= ⁄œ«œ ‰ﬁ«ÿ Â— ’›ÕÂ' + #13 +
      'SCALE LAST PAGE=„ﬁÌ«” ¬Œ—Ì‰ ’›ÕÂ' + #13 +
      'CURRENT PAGE LEGEND=›Â—”  ’›ÕÂ ﬂ‰Ê‰Ì' + #13 +
      'BACKGROUND=Å” “„Ì‰Â' + #13 +
      'BACK IMAGE= ’ÊÌ— Å” ù“„Ì‰Â' + #13 +
      'STRETCH=„‰»”ÿ ‘œ‰' + #13 +
      'TILE=„Ê“«∆ÌﬂÌ' + #13 +
      'BORDERS=Õ«‘ÌÂùÂ«' + #13 +
      'CALCULATE EVERY=„Õ«”»Â Â—' + #13 +
      'NUMBER OF POINTS= ⁄œ«œ ‰ﬁ«ÿ' + #13 +
      'RANGE OF VALUES=„ÕœÊœÂ „ﬁ«œÌ—' + #13 +
      'FIRST=«Ê·' + #13 +
      'LAST=¬Œ—' + #13 +
      'ALL POINTS= „«„ ‰ﬁ«ÿ' + #13 +
      'DATA SOURCE=Data Source' + #13 +
      'WALLS=œÌÊ«—ÂùÂ«' + #13 +
      'PAGING=’›ÕÂù»‰œÌ' + #13 +
      'CLONE= ﬂÀÌ— ﬂ—œ‰' + #13 +
      'TITLES= Ì —Â«' + #13 +
      'TOOLS=«»“«—Â«' + #13 +
      'EXPORT=’œÊ—' + #13 +
      'CHART=ç«— ' + #13 +
      'BACK=⁄ﬁ»' + #13 +
      'LEFT AND RIGHT=çÅ Ê —«” ' + #13 +
      'SELECT A CHART STYLE=«‰ Œ«» Ìﬂ «” Ì· »—«Ì ç«— ' + #13 +
      'SELECT A DATABASE TABLE=«‰ Œ«» Ìﬂ Table «“ Database' + #13 +
      'TABLE=Table' + #13 +
      'SELECT THE DESIRED FIELDS TO CHART=«‰ Œ«» ›Ì·œÂ«Ì „Ê—œ‰Ÿ— »—«Ì «” ›«œÂ œ— ç«— ' + #13 +
      'SELECT A TEXT LABELS FIELD=«‰ Œ«» Ìﬂ ›Ì·œ ·Ì»·Â«' + #13 +
      'CHOOSE THE DESIRED CHART TYPE=‰Ê⁄ ç«—  „Ê—œ‰Ÿ— —« «‰ Œ«» ﬂ‰Ìœ' + #13 +
      'CHART PREVIEW=ÅÌ‘ù‰„«Ì ç«— ' + #13 +
      'SHOW LEGEND=‰„«Ì‘ ›Â—” ' + #13 +
      'SHOW MARKS=‰„«Ì‘ ⁄·«„ Â«' + #13 +
      'FINISH=Å«Ì«‰' + #13 +
      'RANDOM= ’«œ›Ì' + #13 +
      'DRAW EVERY=—”„ Â—' + #13 +
      'ARROWS=ÅÌﬂ«‰ùÂ«' + #13 +
      'ASCENDING=’⁄ÊœÌ' + #13 +
      'DESCENDING=‰“Ê·Ì' + #13 +
      'VERTICAL AXIS=„ÕÊ— ⁄„ÊœÌ' + #13 +
      'DATETIME= «—ÌŒ/“„«‰' + #13 +
      'TOP AND BOTTOM=»«·« Ê Å«ÌÌ‰' + #13 +
      'HORIZONTAL AXIS=„ÕÊ— «›ﬁÌ' + #13 +
      'PERCENTS=œ—’œ' + #13 +
      'VALUES=„ﬁ«œÌ—' + #13 +
      'FORMATS=›—„ Â«' + #13 +
      'SHOW IN LEGEND=‰„«Ì‘ œ— ›Â—” ' + #13 +
      'SORT=„— »' + #13 +
      'MARKS=⁄·«„ Â«' + #13 +
      'BEVEL INNER=·»Â œ—Ê‰Ì' + #13 +
      'BEVEL OUTER=·»Â »Ì—Ê‰Ì' + #13 +
      'PANEL EDITOR=ÊÌ—«Ì‘ê— Å«‰·' + #13 +
      'CONTINUOUS=«œ«„Âùœ«—' + #13 +
      'HORIZ. ALIGNMENT= —«“ «›ﬁÌ' + #13 +
      'EXPORT CHART=’œÊ— ç«— ' + #13 +
      'BELOW %=Å«ÌÌ‰  — «“ %' + #13 +
      'BELOW VALUE=Å«ÌÌ‰  — «“ „ﬁœ«—' + #13 +
      'NEAREST POINT=‰“œÌﬂ —Ì‰ ‰ﬁÿÂ' + #13 +
      'DRAG MARKS=ﬂ‘Ìœ‰ ‰ﬁ«ÿ' + #13 +
      'TEECHART PRINT PREVIEW=ÅÌ‘ ‰„«Ì‘ ç«Å' + #13 +
      'X VALUE=„ﬁœ«— X' + #13 +
      'X AND Y VALUES=„ﬁ«œÌ— X Y' + #13 +
      'SHININESS=œ—Œ‘‰œêÌ' + #13 +
      'ALL SERIES VISIBLE=„—∆Ì »Êœ‰  „«„ ”—ÌÂ«' + #13 +
      'MARGIN=Õ«‘ÌÂ' + #13 +
      'DIAGONAL=„Ê—»' + #13 +
      'LEFT TOP=êÊ‘Â »«·«Ì çÅ' + #13 +
      'LEFT BOTTOM=êÊ‘Â Å«ÌÌ‰ çÅ' + #13 +
      'RIGHT TOP=êÊ‘Â »«·«Ì —«” ' + #13 +
      'RIGHT BOTTOM=êÊ‘Â Å«ÌÌ‰ —«” ' + #13 +
      'EXACT DATE TIME= «—ÌŒ/”«⁄  œﬁÌﬁ' + #13 +
      'RECT. GRADIENT=Gradient' + #13 +
      'CROSS SMALL=’·Ì» ﬂÊçﬂ' + #13 +
      'AVG=„Ì«‰êÌ‰' + #13 +
      'FUNCTION= «»⁄' + #13 +
      'AUTO=Auto' + #13 +
      'ONE MILLISECOND=Ìﬂ „Ì·ÌùÀ«‰ÌÂ' + #13 +
      'ONE SECOND=Ìﬂ À«‰ÌÂ' + #13 +
      'FIVE SECONDS=Å‰Ã À«‰ÌÂ' + #13 +
      'TEN SECONDS=œÂ À«‰ÌÂ' + #13 +
      'FIFTEEN SECONDS=Å«‰“œÂ À«‰ÌÂ' + #13 +
      'THIRTY SECONDS=”Ì À«‰ÌÂ' + #13 +
      'ONE MINUTE=Ìﬂ À«‰ÌÂ' + #13 +
      'FIVE MINUTES=Å‰Ã œﬁÌﬁÂ' + #13 +
      'TEN MINUTES=œÂ œﬁÌﬁÂ' + #13 +
      'FIFTEEN MINUTES=Å«‰“œÂ œﬁÌﬁÂ' + #13 +
      'THIRTY MINUTES=”Ì œﬁÌﬁÂ' + #13 +
      'TWO HOURS=œÊ ”«⁄ ' + #13 +
      'SIX HOURS=‘‘ ”«⁄ ' + #13 +
      'TWELVE HOURS=œÊ«“œÂ ”«⁄ ' + #13 +
      'ONE DAY=Ìﬂ —Ê“' + #13 +
      'TWO DAYS=œÊ —Ê“' + #13 +
      'THREE DAYS=”Â ”«⁄ ' + #13 +
      'ONE WEEK=Ìﬂ Â› Â' + #13 +
      'HALF MONTH=Å«‰“œÂ —Ê“' + #13 +
      'ONE MONTH=Ìﬂ „«Â' + #13 +
      'TWO MONTHS=œÊ „«Â' + #13 +
      'THREE MONTHS=”Â „«Â' + #13 +
      'FOUR MONTHS=çÂ«— „«Â' + #13 +
      'SIX MONTHS=‘‘ „«Â' + #13 +
      'IRREGULAR=€Ì—ÿ»Ì⁄Ì' + #13 +
      'CLICKABLE=ﬁ«»· ﬂ·Ìﬂ' + #13 +
      'ROUND=ê—œ' + #13 +
      'FLAT=„”ÿÕ' + #13 +
      'PIE=ﬂÌﬂ' + #13 +
      'HORIZ. BAR=” Ê‰ «›ﬁÌ' + #13 +
      'BUBBLE=Õ»«»' + #13 +
      'SHAPE=‘ﬂ·' + #13 +
      'POINT=‰ﬁÿÂ' + #13 +
      'FAST LINE=Õÿ ”—Ì⁄' + #13 +
      'CANDLE=‘„⁄' + #13 +
      'VOLUME=ÕÃ„' + #13 +
      'HORIZ LINE=Œÿ «›ﬁÌ' + #13 +
      'SURFACE=”ÿÕ' + #13 +
      'LEFT AXIS=„ÕÊ— çÅ' + #13 +
      'RIGHT AXIS=„ÕÊ— —«” ' + #13 +
      'TOP AXIS=„ÕÊ— »«·«' + #13 +
      'BOTTOM AXIS=„ÕÊ— Å«ÌÌ‰' + #13 +
      'CHANGE SERIES TITLE= €ÌÌ—  Ì — ”—ÌÂ«' + #13 +
      'DELETE %S ?=Õ–› %s ?' + #13 +
      'DESIRED %S INCREMENT=«›“«Ì‘ %s „Ê—œ ‰Ÿ—' + #13 +
      'INCORRECT VALUE. REASON: %S=„ﬁœ«— ‰«œ—” . œ·Ì·: %S' + #13 +
      'FillSampleValues NumValues must be > 0=FillSampleValues »«Ìœ »“—ê — «“ ’›— »«‘œ'#13 +
      'VISIT OUR WEB SITE !=«“ ”«Ì  „« »«“œÌœ ﬂ‰Ìœ!'#13 +
      'SHOW PAGE NUMBER=‰„«Ì‘ ‘„«—Â ’›ÕÂ'#13 +
      'PAGE NUMBER=‘„«—Â ’›ÕÂ'#13 +
      'PAGE %D OF %D=’›ÕÂ %d «“ %d'#13 +
      'TEECHART LANGUAGES=“»«‰ TeeChart'#13 +
      'CHOOSE A LANGUAGE=Ìﬂ “»«‰ —« «‰ Œ«» ﬂ‰Ìœ' + #13 +
      'SELECT ALL=«‰ Œ«» Â„Â'#13 +
      'MOVE UP=«‰ ﬁ«· »Â »«·«'#13 +
      'MOVE DOWN=«‰ ﬁ«· »Â Å«ÌÌ‰'#13 +
      'DRAW ALL=—”„ Â„Â'#13 +
      'TEXT FILE=›«Ì· Text'#13 +
      'IMAG. SYMBOL=”„»Ê·  IMAG.'#13 +
      'DRAG REPAINT=—”„ „Ãœœ œ— ÕÌ‰ ﬂ‘Ìœ‰'#13 +
      'NO LIMIT DRAG=ﬂ‘‘ ‰«„ÕœÊœ'
      ;
  end;
end;

// »«·«Œ—Â  „Ê„ ‘œ. Ê·Ì ﬂ«— ”Œ Ì »Êœ«!!! :)

procedure TeeSetFarsi;
begin
  TeeCreateFarsi;
  TeeLanguage := TeeFarsiLanguage;
  TeeFarsiConstants;
  TeeLanguageHotKeyAtEnd := False;
end;

initialization
finalization
  FreeAndNil(TeeFarsiLanguage);
end.

