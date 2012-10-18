// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUICheckListBox.pas' rev: 6.00

#ifndef SUICheckListBoxHPP
#define SUICheckListBoxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <StdCtrls.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <CheckLst.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suichecklistbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiCheckListBox;
class PASCALIMPLEMENTATION TsuiCheckListBox : public Checklst::TCheckListBox 
{
	typedef Checklst::TCheckListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	Suiscrollbar::TsuiScrollBar* m_HScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall SetHScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
	void __fastcall OnHScrollBarChange(System::TObject* Sender);
	void __fastcall UpdateScrollBars(void);
	void __fastcall UpdateScrollBarsPos(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOVE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEWHEEL(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLBUTTONDOWN(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall LBADDSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBDELETESTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBINSERTSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBSETCOUNT(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSELCHANGE(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSETFOCUS(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDELETEITEM(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	Forms::TBorderStyle __fastcall GetBorderStyle(void);
	HIDESBASE void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	Controls::TBorderWidth __fastcall GetBorderWidth(void);
	HIDESBASE void __fastcall SetBorderWidth(const Controls::TBorderWidth Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	Graphics::TColor FSelectedTextColor;
	Graphics::TColor FSelectedColor;
	Graphics::TColor FDisabledTextColor;
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedTextColor(const Graphics::TColor Value);
	void __fastcall SetDisabledTextColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Msg);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiCheckListBox(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, nodefault};
	__property Graphics::TColor SelectedTextColor = {read=FSelectedTextColor, write=SetSelectedTextColor, nodefault};
	__property Graphics::TColor DisabledTextColor = {read=FDisabledTextColor, write=SetDisabledTextColor, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Forms::TBorderStyle BorderStyle = {read=GetBorderStyle, write=SetBorderStyle, nodefault};
	__property Controls::TBorderWidth BorderWidth = {read=GetBorderWidth, write=SetBorderWidth, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
public:
	#pragma option push -w-inl
	/* TCheckListBox.Destroy */ inline __fastcall virtual ~TsuiCheckListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCheckListBox(HWND ParentWindow) : Checklst::TCheckListBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suichecklistbox */
using namespace Suichecklistbox;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUICheckListBox
