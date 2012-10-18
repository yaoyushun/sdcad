//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("TeeTranslate.pas", Teetranslate, AskLanguage);
USEFORMNS("TeeAbout.pas", Teeabout, TeeAboutForm);
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
