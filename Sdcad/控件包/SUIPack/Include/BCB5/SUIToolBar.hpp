// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIToolBar.pas' rev: 5.00

#ifndef SUIToolBarHPP
#define SUIToolBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suitoolbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiToolBar;
class PASCALIMPLEMENTATION TsuiToolBar : public Comctrls::TToolBar 
{
	typedef Comctrls::TToolBar inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_ButtonColor;
	Graphics::TColor m_ButtonBorderColor;
	Graphics::TColor m_ButtonDownColor;
	void __fastcall DrawBar(Comctrls::TToolBar* Sender, const Windows::TRect &ARect, bool &DefaultDraw)
		;
	void __fastcall DrawButton(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState 
		State, bool &DefaultDraw);
	void __fastcall DrawDownButton(Graphics::TCanvas* ACanvas, const Windows::TRect &ARect, Imglist::TCustomImageList* 
		ImgLst, int ImageIndex, AnsiString Caption, bool DropDown);
	void __fastcall DrawHotButton(Graphics::TCanvas* ACanvas, const Windows::TRect &ARect, Imglist::TCustomImageList* 
		ImgLst, int ImageIndex, AnsiString Caption, bool DropDown);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetButtonBorderColor(const Graphics::TColor Value);
	void __fastcall SetButtonColor(const Graphics::TColor Value);
	void __fastcall SetButtonDownColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiToolBar(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
	__property Graphics::TColor ButtonBorderColor = {read=m_ButtonBorderColor, write=SetButtonBorderColor
		, nodefault};
	__property Graphics::TColor ButtonDownColor = {read=m_ButtonDownColor, write=SetButtonDownColor, nodefault
		};
	__property Color ;
	__property Transparent ;
public:
	#pragma option push -w-inl
	/* TToolBar.Destroy */ inline __fastcall virtual ~TsuiToolBar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiToolBar(HWND ParentWindow) : Comctrls::TToolBar(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suitoolbar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suitoolbar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIToolBar
