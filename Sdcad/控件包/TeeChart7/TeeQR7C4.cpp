//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeQR7C4.res");
USEPACKAGE("tee7C4.bpi");
USEPACKAGE("teeDB7C4.bpi");
USEPACKAGE("teeUI7C4.bpi");
USEUNIT("QRTee.pas");
USEPACKAGE("qrpt40.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
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
