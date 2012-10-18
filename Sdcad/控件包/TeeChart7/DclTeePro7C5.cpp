//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclteepro7C5.res");
USEPACKAGE("teepro7C5.bpi");
USEPACKAGE("dcltee7C5.bpi");
USEPACKAGE("Tee7C5.bpi");
USEPACKAGE("TeeUI7C5.bpi");
USEPACKAGE("vcl50.bpi");
USEUNIT("TeeChartPro.pas");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("TeeDB7C5.bpi");
USEPACKAGE("Vclx50.bpi");
USEPACKAGE("TeeLanguage7C5.bpi");
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
