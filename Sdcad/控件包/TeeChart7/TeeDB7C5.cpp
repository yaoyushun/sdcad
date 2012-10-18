//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("teedb7C5.res");
USEPACKAGE("tee7C5.bpi");
USEUNIT("DBChart.pas");
USEUNIT("DBEditCh.pas");
USEUNIT("TeeData.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclx50.bpi");
USEUNIT("TeeDBSumEdit.pas");
USEUNIT("TeeDBSourceEditor.pas");
USEFORMNS("TeeDBEdit.pas", TeeDBEdit, BaseDBChartEditor);
USEPACKAGE("TeeUI7C5.bpi");
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
