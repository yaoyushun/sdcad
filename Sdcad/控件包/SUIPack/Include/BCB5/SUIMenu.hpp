// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIMenu.pas' rev: 5.00

#ifndef SUIMenuHPP
#define SUIMenuHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suimenu
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Menu_SetItemEvent(Menus::TMenuItem* MenuItem, Menus::TMenuDrawItemEvent 
	DrawItemEvent, Menus::TMenuMeasureItemEvent MeasureItemEvent);
extern PACKAGE void __fastcall Menu_DrawBorder(Graphics::TCanvas* ACanvas, const Windows::TRect &ARect
	, Graphics::TColor Color);
extern PACKAGE void __fastcall Menu_DrawBackGround(Graphics::TCanvas* ACanvas, const Windows::TRect 
	&ARect, Graphics::TColor Color);
extern PACKAGE void __fastcall Menu_DrawLineItem(Graphics::TCanvas* ACanvas, const Windows::TRect &ARect
	, Graphics::TColor LineColor, int BarWidth, bool L2R);
extern PACKAGE void __fastcall Menu_DrawMacOSLineItem(Graphics::TCanvas* ACanvas, const Windows::TRect 
	&ARect);
extern PACKAGE void __fastcall Menu_DrawMacOSSelectedItem(Graphics::TCanvas* ACanvas, const Windows::TRect 
	&ARect);
extern PACKAGE void __fastcall Menu_DrawMacOSNonSelectedItem(Graphics::TCanvas* ACanvas, const Windows::TRect 
	&ARect);
extern PACKAGE void __fastcall Menu_DrawWindowBorder(HWND HandleOfWnd, Graphics::TColor BorderColor, 
	Graphics::TColor FormColor);
extern PACKAGE void __fastcall Menu_GetSystemFont(const Graphics::TFont* Font);

}	/* namespace Suimenu */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suimenu;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIMenu
