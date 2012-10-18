//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("teedb7C4.res");
USEPACKAGE("tee7C4.bpi");
USEPACKAGE("teeui7C4.bpi");
USEUNIT("DBChart.pas");
USEUNIT("DBEditCh.pas");
USEUNIT("TeeData.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("vclx40.bpi");
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
