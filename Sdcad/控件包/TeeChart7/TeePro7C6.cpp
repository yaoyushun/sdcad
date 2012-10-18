//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("TeeDragPoint.pas", TeeDragPoint, DragPointToolEdit);
USEFORMNS("TeeAnnToolEdit.pas", Teeanntooledit, AnnotationToolEdit);
USEFORMNS("TeeAxisToolEdit.pas", Teeaxistooledit, AxisToolEditor);
USEFORMNS("TeeBarJoinEditor.pas", Teebarjoineditor, BarJoinEditor);
USEFORMNS("TeeBoxPlotEditor.pas", Teeboxploteditor, BoxSeriesEditor);
USEFORMNS("TeeCalendarEditor.pas", Teecalendareditor, CalendarSeriesEditor);
USEFORMNS("TeeCandlEdi.pas", Teecandledi, CandleEditor);
USEFORMNS("TeeColorBandEdit.pas", Teecolorbandedit, ColorBandToolEditor);
USEFORMNS("TeeColorLineEditor.pas", Teecolorlineeditor, ColorLineToolEditor);
USEFORMNS("TeeContourEdit.pas", Teecontouredit, ContourSeriesEditor);
USEFORMNS("TeeErrBarEd.pas", Teeerrbared, ErrorSeriesEditor);
USEFORMNS("TeeFunnelEditor.pas", Teefunneleditor, FunnelSeriesEditor);
USEFORMNS("TeeGriEd.pas", Teegried, Grid3DSeriesEditor);
USEFORMNS("TeeHighLowEdit.pas", Teehighlowedit, HighLowEditor);
USEFORMNS("TeeHistoEdit.pas", Teehistoedit, HistogramSeriesEditor);
USEFORMNS("TeeImaEd.pas", Teeimaed, ImageBarSeriesEditor);
USEFORMNS("TeeLinePointEditor.pas", Teelinepointeditor, LinePointEditor);
USEFORMNS("TeeDonutEdit.pas", Teedonutedit, DonutSeriesEditor);
USEFORMNS("TeeSeriesTextEd.pas", Teeseriestexted, SeriesTextEditor);
USEFORMNS("TeePo3DEdit.pas", Teepo3dedit, Point3DSeriesEditor);
USEFORMNS("TeePolarEditor.pas", Teepolareditor, PolarSeriesEditor);
USEFORMNS("TeePreviewPanelEditor.pas", Teepreviewpaneleditor, FormPreviewPanelEditor);
USEFORMNS("TeePyramidEdit.pas", Teepyramidedit, PyramidSeriesEditor);
USEFORMNS("TeeMapSeriesEdit.pas", Teemapseriesedit, MapSeriesEditor);
USEFORMNS("TeeWindRoseEditor.pas", Teewindroseeditor, WindRoseEditor);
USEFORMNS("TeeSmithEdit.pas", Teesmithedit, SmithSeriesEdit);
USEFORMNS("TeeSurfEdit.pas", Teesurfedit, SurfaceSeriesEditor);
USEFORMNS("TeeToolSeriesEdit.pas", Teetoolseriesedit, SeriesToolEditor);
USEFORMNS("TeeTriSurfEdit.pas", Teetrisurfedit, TriSurfaceSeriesEditor);
USEFORMNS("TeeVolEd.pas", Teevoled, VolumeSeriesEditor);
USEFORMNS("TeeWaterFallEdit.pas", Teewaterfalledit, WaterFallEditor);
USEFORMNS("TeeSurfaceTool.pas", TeeSurfaceTool, SurfaceNearest);
USEFORMNS("TeeSelectorTool.pas", TeeSelectorTool, SelectorToolEditor);
USEFORMNS("TeeSeriesBandTool.pas", TeeSeriesBandTool, SeriesBandToolEditor);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
