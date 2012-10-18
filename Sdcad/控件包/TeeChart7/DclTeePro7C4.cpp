//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclteepro7C4.res");
USEPACKAGE("dclstd40.bpi");
USEPACKAGE("teepro7C4.bpi");
USEPACKAGE("dcltee7C4.bpi");
USEUNIT("TeeChartPro.pas");
USEPACKAGE("Tee7C4.bpi");
USEPACKAGE("TeeDB7C4.bpi");
USEPACKAGE("TeeUI7C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("TeeLanguage7C4.bpi");
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
