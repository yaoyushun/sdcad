//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeGL7C4.res");
USEUNIT("TeeGLCanvas.pas");
USEUNIT("TeeOpenGL.pas");
USEUNIT("opengl2.pas");
USEUNIT("TeeGeometry.pas");
USEPACKAGE("tee7C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("teeui7C4.bpi");
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
