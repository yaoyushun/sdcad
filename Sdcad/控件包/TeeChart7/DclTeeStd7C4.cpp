//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclteestd7C4.res");
USERES("teechart.res");
USEUNIT("TeeChartReg.pas");
USEPACKAGE("tee7C4.bpi");
USEPACKAGE("teeUI7C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("dclstd40.bpi");
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
