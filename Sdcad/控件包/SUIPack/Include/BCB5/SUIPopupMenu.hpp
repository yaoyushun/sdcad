// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIPopupMenu.pas' rev: 5.00

#ifndef SUIPopupMenuHPP
#define SUIPopupMenuHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suipopupmenu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiPopupMenu;
class PASCALIMPLEMENTATION TsuiPopupMenu : public Menus::TPopupMenu 
{
	typedef Menus::TPopupMenu inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	int m_Height;
	int m_SeparatorHeight;
	Graphics::TColor m_BarColor;
	int m_BarWidth;
	Graphics::TColor m_Color;
	Graphics::TColor m_SeparatorColor;
	Graphics::TColor m_SelectedBorderColor;
	Graphics::TColor m_SelectedColor;
	Graphics::TColor m_SelectedFontColor;
	Graphics::TColor m_FontColor;
	Graphics::TColor m_BorderColor;
	bool m_FlatMenu;
	AnsiString m_FontName;
	int m_FontSize;
	Graphics::TFontCharset m_FontCharset;
	bool m_UseSystemFont;
	Suimgr::TsuiFileTheme* m_FileTheme;
	bool __fastcall GetOwnerDraw(void);
	HIDESBASE void __fastcall SetOwnerDraw(const bool Value);
	void __fastcall DrawItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Windows::TRect 
		&ARect, bool Selected);
	void __fastcall MeasureItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height
		);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetSeparatorHeight(const int Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiPopupMenu(Classes::TComponent* AOwner);
	void __fastcall MenuAdded(void);
	
__published:
	__property OwnerDraw  = {read=GetOwnerDraw, write=SetOwnerDraw, default=0};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property int MenuItemHeight = {read=m_Height, write=SetHeight, nodefault};
	__property int SeparatorHeight = {read=m_SeparatorHeight, write=SetSeparatorHeight, nodefault};
	__property int BarWidth = {read=m_BarWidth, write=m_BarWidth, nodefault};
	__property Graphics::TColor BarColor = {read=m_BarColor, write=m_BarColor, nodefault};
	__property Graphics::TColor Color = {read=m_Color, write=m_Color, nodefault};
	__property Graphics::TColor SeparatorColor = {read=m_SeparatorColor, write=m_SeparatorColor, nodefault
		};
	__property Graphics::TColor SelectedBorderColor = {read=m_SelectedBorderColor, write=m_SelectedBorderColor
		, nodefault};
	__property Graphics::TColor SelectedColor = {read=m_SelectedColor, write=m_SelectedColor, nodefault
		};
	__property Graphics::TColor SelectedFontColor = {read=m_SelectedFontColor, write=m_SelectedFontColor
		, nodefault};
	__property Graphics::TColor FontColor = {read=m_FontColor, write=m_FontColor, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=m_BorderColor, nodefault};
	__property bool FlatMenu = {read=m_FlatMenu, write=m_FlatMenu, nodefault};
	__property AnsiString FontName = {read=m_FontName, write=m_FontName};
	__property int FontSize = {read=m_FontSize, write=m_FontSize, nodefault};
	__property Graphics::TFontCharset FontCharset = {read=m_FontCharset, write=m_FontCharset, nodefault
		};
	__property bool UseSystemFont = {read=m_UseSystemFont, write=m_UseSystemFont, nodefault};
public:
	#pragma option push -w-inl
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TsuiPopupMenu(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suipopupmenu */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suipopupmenu;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIPopupMenu
