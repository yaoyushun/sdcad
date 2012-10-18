//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltgl7C5.res");
USEUNIT("TeeOpenGLReg.pas");
USEPACKAGE("teegl7C5.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("TeePro7C5.bpi");
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
