//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeGL7C5.res");
USEUNIT("TeeGLCanvas.pas");
USEUNIT("TeeOpenGL.pas");
USEUNIT("opengl2.pas");
USEUNIT("TeeGeometry.pas");
USEPACKAGE("tee7C5.bpi");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("teeui7c5.bpi");
USEFORMNS("TeeGLEditor.pas", Teegleditor, FormTeeGLEditor);
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
