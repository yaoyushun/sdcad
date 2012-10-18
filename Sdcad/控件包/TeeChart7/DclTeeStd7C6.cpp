//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USERES("DclTeeStd7C6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("Tee7C6.bpi");
USEPACKAGE("TeeUI7C6.bpi");
USEUNIT("TeeChartExp.pas");
USEFORMNS("TeeExpForm.pas", Teeexpform, TeeDlgWizard);
USEUNIT("TeeChartReg.pas");
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
