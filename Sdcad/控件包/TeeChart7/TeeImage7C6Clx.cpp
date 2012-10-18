//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEFORMNS("TeePCX.pas", Teepcx, PCXOptions);
USEFORMNS("TeePNG.pas", Teepng, TeePNGOptions);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
