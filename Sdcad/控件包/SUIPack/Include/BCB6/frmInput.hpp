// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmInput.pas' rev: 6.00

#ifndef frmInputHPP
#define frmInputHPP

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

namespace Frminput
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmInput;
class PASCALIMPLEMENTATION TfrmInput : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Suiform::TsuiForm* suiForm1;
	Stdctrls::TLabel* lbl_prompt;
	Suiedit::TsuiEdit* edt_value;
	Suibutton::TsuiButton* btn1;
	Suibutton::TsuiButton* btn2;
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmInput(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmInput(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmInput(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmInput(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frminput */
using namespace Frminput;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmInput
