//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("teeUI7C5.res");
USEPACKAGE("tee7C5.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEFORMNS("TeeEdiSeri.pas", Teeediseri, FormTeeSeries);
USEFORMNS("TeeGally.pas", Teegally, TeeGallery);
USEFORMNS("TeePoEdi.pas", Teepoedi, SeriesPointerEditor);
USEUNIT("TeeLisB.pas");
USEUNIT("EditChar.pas");
USEUNIT("TeeURL.pas");
USEFORMNS("teeprevi.pas", Teeprevi, ChartPreview);
USEFORMNS("teexport.pas", Teexport, TeeExportForm);
USEFORMNS("TeeArrowEdi.pas", Teearrowedi, ArrowSeriesEditor);
USEFORMNS("TeeAxisIncr.pas", Teeaxisincr, AxisIncrement);
USEFORMNS("TeeAxMaxMin.pas", Teeaxmaxmin, AxisMaxMin);
USEFORMNS("TeeBarEdit.pas", Teebaredit, BarSeriesEditor);
USEFORMNS("TeeBMPOptions.pas", Teebmpoptions, BMPOptions);
USEFORMNS("TeeBrushDlg.pas", Teebrushdlg, BrushDialog);
USEUNIT("TeeChartGrid.pas");
USEFORMNS("TeeCircledEdit.pas", Teecirclededit, CircledSeriesEditor);
USEFORMNS("TeeCustEdit.pas", Teecustedit, CustomSeriesEditor);
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
USEFORMNS("TeeEditCha.pas", Teeeditcha, ChartEditForm);
USEFORMNS("TeeEdiTitl.pas", Teeedititl, FormTeeTitle);
USEFORMNS("TeeEditTools.pas", Teeedittools, FormTeeTools);
USEFORMNS("TeeEdiWall.pas", Teeediwall, FormTeeWall);
USEFORMNS("TeeEMFOptions.pas", Teeemfoptions, EMFOptions);
USEUNIT("TeeFLineEdi.pas");
USEUNIT("TeeFuncEdit.pas");
USEUNIT("TeeGalleryPanel.pas");
USEFORMNS("TeeGanttEdi.pas", Teeganttedi, GanttSeriesEditor);
USEFORMNS("TeePenDlg.pas", Teependlg, PenDialog);
USEFORMNS("TeePieEdit.pas", Teepieedit, PieSeriesEditor);
USEUNIT("TeePreviewPanel.pas");
USEFORMNS("TeeSelectList.pas", Teeselectlist, SelectListForm);
USEFORMNS("TeeShapeEdi.pas", Teeshapeedi, ChartShapeEditor);
USEFORMNS("TeeSourceEdit.pas", Teesourceedit, BaseSourceEditor);
USEFORMNS("TeeStackBarEdit.pas", Teestackbaredit, StackBarSeriesEditor);
USEFORMNS("TeeToolsGallery.pas", Teetoolsgallery, TeeToolsGallery);
USEFORMNS("TeeAreaEdit.pas", Teeareaedit, AreaSeriesEditor);
USEUNIT("TeeNavigator.pas");
USEFORMNS("TeeExport.pas", Teeexport, TeeExportFormBase);
USEFORMNS("TeeFormatting.pas", TeeFormatting, FormatEditor);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
