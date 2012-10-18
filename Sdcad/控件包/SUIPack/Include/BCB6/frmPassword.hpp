// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmPassword.pas' rev: 6.00

#ifndef frmPasswordHPP
#define frmPasswordHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIButton.hpp>	// Pascal unit
#include <SUIEdit.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <SUIForm.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frmpassword
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmPass;
class PASCALIMPLEMENTATION TfrmPass : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Suiform::TsuiForm* suiForm1;
	Suiedit::TsuiEdit* edt1;
	Stdctrls::TLabel* lbl1;
	Stdctrls::TLabel* lbl2;
	Suiedit::TsuiEdit* edt2;
	Suibutton::TsuiButton* btn1;
	Suibutton::TsuiButton* btn2;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmPass(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmPass(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmPass(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmPass(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TfrmPass* frmPass;

}	/* namespace Frmpassword */
using namespace Frmpassword;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmPassword
