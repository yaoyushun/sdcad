// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIStatusBar.pas' rev: 5.00

#ifndef SUIStatusBarHPP
#define SUIStatusBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suistatusbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiStatusBar;
class PASCALIMPLEMENTATION TsuiStatusBar : public Comctrls::TStatusBar 
{
	typedef Comctrls::TStatusBar inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	Graphics::TColor __fastcall GetPanelColor(void);
	void __fastcall SetPanelColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHITTEST(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiStatusBar(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor PanelColor = {read=GetPanelColor, write=SetPanelColor, nodefault};
	__property Action ;
	__property AutoHint ;
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderWidth ;
	__property Color ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property Constraints ;
	__property Panels ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property SimplePanel ;
	__property SimpleText ;
	__property SizeGrip ;
	__property UseSystemFont ;
	__property Visible ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnHint ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnDrawPanel ;
public:
	#pragma option push -w-inl
	/* TStatusBar.Destroy */ inline __fastcall virtual ~TsuiStatusBar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiStatusBar(HWND ParentWindow) : Comctrls::TStatusBar(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suistatusbar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suistatusbar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIStatusBar
