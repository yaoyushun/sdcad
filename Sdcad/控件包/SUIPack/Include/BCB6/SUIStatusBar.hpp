// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIStatusBar.pas' rev: 6.00

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
class PASCALIMPLEMENTATION TsuiStatusBar : public Comctrls::TCustomStatusBar 
{
	typedef Comctrls::TCustomStatusBar inherited;
	
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
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiStatusBar(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor PanelColor = {read=GetPanelColor, write=SetPanelColor, nodefault};
	__property Action ;
	__property AutoHint  = {default=0};
	__property Align  = {default=2};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property BorderWidth  = {default=0};
	__property Color  = {default=-2147483633};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font  = {stored=IsFontStored};
	__property Constraints ;
	__property Panels ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=0};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property SimplePanel  = {default=0};
	__property SimpleText ;
	__property SizeGrip  = {default=1};
	__property UseSystemFont  = {default=1};
	__property Visible  = {default=1};
	__property OnClick ;
	__property OnContextPopup ;
	__property OnCreatePanelClass ;
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
	/* TCustomStatusBar.Destroy */ inline __fastcall virtual ~TsuiStatusBar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiStatusBar(HWND ParentWindow) : Comctrls::TCustomStatusBar(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suistatusbar */
using namespace Suistatusbar;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIStatusBar
