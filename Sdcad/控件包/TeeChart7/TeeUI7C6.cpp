//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("TeeCircledEdit.pas", Teecirclededit, CircledSeriesEditor);
USEFORMNS("TeeAreaEdit.pas", Teeareaedit, AreaSeriesEditor);
USEFORMNS("TeeArrowEdi.pas", Teearrowedi, ArrowSeriesEditor);
USEFORMNS("TeeAxisIncr.pas", Teeaxisincr, AxisIncrement);
USEFORMNS("TeeAxMaxMin.pas", Teeaxmaxmin, AxisMaxMin);
USEFORMNS("TeeBarEdit.pas", Teebaredit, BarSeriesEditor);
USEFORMNS("TeeBMPOptions.pas", Teebmpoptions, BMPOptions);
USEFORMNS("TeeBrushDlg.pas", Teebrushdlg, BrushDialog);
USEFORMNS("TeExport.pas", Teexport, TeeExportForm);
USEFORMNS("TeeCustomShapeEditor.pas", Teecustomshapeeditor, FormTeeShape);
USEFORMNS("TeeEdi3D.pas", Teeedi3d, FormTee3D);
USEFORMNS("TeeEdiAxis.pas", Teeediaxis, FormTeeAxis);
USEFORMNS("TeeEdiFont.pas", Teeedifont, TeeFontEditor);
USEFORMNS("TeeEdiGene.pas", Teeedigene, FormTeeGeneral);
USEFORMNS("TeeEdiGrad.pas", Teeedigrad, TeeGradientEditor);
USEFORMNS("TeeEdiLege.pas", Teeedilege, FormTeeLegend);
USEFORMNS("TeeEdiPage.pas", Teeedipage, FormTeePage);
USEFORMNS("TeeEdiPane.pas", Teeedipane, FormTeePanel);
USEFORMNS("TeeEdiPeri.pas", Teeediperi, FormPeriod);
USEFORMNS("TeeEdiSeri.pas", Teeediseri, FormTeeSeries);
USEFORMNS("TeeEditCha.pas", Teeeditcha, ChartEditForm);
USEFORMNS("TeeEdiTitl.pas", Teeedititl, FormTeeTitle);
USEFORMNS("TeeEditTools.pas", Teeedittools, FormTeeTools);
USEFORMNS("TeeEdiWall.pas", Teeediwall, FormTeeWall);
USEFORMNS("TeeEmfOptions.pas", Teeemfoptions, EMFOptions);
USEFORMNS("TeeGally.pas", Teegally, TeeGallery);
USEFORMNS("TeeGanttEdi.pas", Teeganttedi, GanttSeriesEditor);
USEFORMNS("TeePenDlg.pas", Teependlg, PenDialog);
USEFORMNS("TeePieEdit.pas", Teepieedit, PieSeriesEditor);
USEFORMNS("TeePoEdi.pas", Teepoedi, SeriesPointerEditor);
USEFORMNS("TeePrevi.pas", Teeprevi, ChartPreview);
USEFORMNS("TeeSelectList.pas", Teeselectlist, SelectListForm);
USEFORMNS("TeeShapeEdi.pas", Teeshapeedi, ChartShapeEditor);
USEFORMNS("TeeSourceEdit.pas", Teesourceedit, BaseSourceEditor);
USEFORMNS("TeeStackBarEdit.pas", Teestackbaredit, StackBarSeriesEditor);
USEFORMNS("TeeToolsGallery.pas", Teetoolsgallery, TeeToolsGallery);
USEFORMNS("TeeCustEdit.pas", Teecustedit, CustomSeriesEditor);
USEFORMNS("TeeFormatting.pas", TeeFormatting, FormatEditor);
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
 