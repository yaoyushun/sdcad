//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeQR7C5.res");
USEPACKAGE("tee7C5.bpi");
USEPACKAGE("teeDB7C5.bpi");
USEPACKAGE("teeUI7C5.bpi");
USEUNIT("QRTee.pas");
USEPACKAGE("qrpt50.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
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
