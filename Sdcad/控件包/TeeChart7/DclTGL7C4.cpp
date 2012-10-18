//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltgl7C4.res");
USEUNIT("TeeOpenGLReg.pas");
USEPACKAGE("teegl7C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vclx40.bpi");
USEPACKAGE("TeeUI7C4.bpi");
USEPACKAGE("Tee7C4.bpi");
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
