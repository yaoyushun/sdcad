//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltee7C4.res");
USERES("teechart.res");
USEUNIT("TeeChartReg.pas");
USEPACKAGE("dcldb40.bpi");
USEPACKAGE("tee7C4.bpi");
USEPACKAGE("teedb7C4.bpi");
USEPACKAGE("teeUI7C4.bpi");
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
