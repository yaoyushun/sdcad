//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("teeUI7C4.res");
USEPACKAGE("tee7C4.bpi");
USEUNIT("TeeURL.pas");
USEFORMNS("TeeArrowedi.pas", Teearrowedi, ArrowSeriesEditor);
USEFORMNS("TeeAxisIncr.pas", Teeaxisincr, AxisIncrement);
USEFORMNS("TeeAxMaxMin.pas", Teeaxmaxmin, AxisMaxMin);
USEFORMNS("TeeBaredit.pas", Teebaredit, BarSeriesEditor);
USEFORMNS("TeeCustEdit.pas", Teecustedit, CustomSeriesEditor);
USEFORMNS("TeeFlineedi.pas", Teeflineedi, FastLineSeriesEditor);
USEFORMNS("TeeGanttedi.pas", Teeganttedi, GanttSeriesEditor);
USEFORMNS("TeeEdi3D.pas", Teeedi3d, FormTee3D);
USEFORMNS("TeeEdiAxis.pas", Teeediaxis, FormTeeAxis);
USEFORMNS("TeeEdiGene.pas", Teeedigene, FormTeeGeneral);
USEFORMNS("TeeEdiLege.pas", Teeedilege, FormTeeLegend);
USEFORMNS("TeeEdiPage.pas", Teeedipage, FormTeePage);
USEFORMNS("TeeEdiPane.pas", Teeedipane, FormTeePanel);
USEFORMNS("TeeEdiSeri.pas", Teeediseri, FormTeeSeries);
USEFORMNS("TeeEditCha.pas", Teeeditcha, ChartEditForm);
USEFORMNS("TeeEdiTitl.pas", Teeedititl, FormTeeTitle);
USEFORMNS("TeeEdiWall.pas", Teeediwall, FormTeeWall);
USEFORMNS("TeePieEdit.pas", Teepieedit, PieSeriesEditor);
USEFORMNS("TeeShapeedi.pas", Teeshapeedi, ChartShapeEditor);
USEFORMNS("TeeGally.pas", Teegally, TeeGallery);
USEFORMNS("TeeAreaedit.pas", Teeareaedit, AreaSeriesEditor);
USEFORMNS("TeePoEdi.pas", Teepoedi, SeriesPointerEditor);
USEFORMNS("TeeEdiPeri.pas", Teeediperi, FormPeriod);
USEFORMNS("TeeEdigrad.pas", Teeedigrad, TeeGradientEditor);
USEUNIT("TeeLisB.pas");
USEUNIT("EditChar.pas");
USEPACKAGE("vcl40.bpi");
USEFORMNS("Teebrushdlg.pas", Teebrushdlg, BrushDialog);
USEFORMNS("Teependlg.pas", Teependlg, PenDialog);
USEFORMNS("teeprevi.pas", Teeprevi, ChartPreview);
USEFORMNS("teexport.pas", Teexport, TeeExportForm);
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
