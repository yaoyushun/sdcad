// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frmThemeMgr.pas' rev: 6.00

#ifndef frmThemeMgrHPP
#define frmThemeMgrHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CheckLst.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
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

namespace Frmthememgr
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrmMgr;
class PASCALIMPLEMENTATION TfrmMgr : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
__published:
	Checklst::TCheckListBox* List;
	Stdctrls::TButton* btn_sel;
	Stdctrls::TButton* btn_unsel;
	Stdctrls::TButton* btn_ok;
	void __fastcall btn_selClick(System::TObject* Sender);
	void __fastcall btn_unselClick(System::TObject* Sender);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrmMgr(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmMgr(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmMgr(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrmMgr(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Frmthememgr */
using namespace Frmthememgr;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// frmThemeMgr
