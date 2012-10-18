// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIMemo.pas' rev: 6.00

#ifndef SUIMemoHPP
#define SUIMemoHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suimemo
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiMemo;
class PASCALIMPLEMENTATION TsuiMemo : public Stdctrls::TCustomMemo 
{
	typedef Stdctrls::TCustomMemo inherited;
	
private:
	Graphics::TColor m_BorderColor;
	bool m_MouseDown;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	Suiscrollbar::TsuiScrollBar* m_HScrollBar;
	bool m_SelfChanging;
	bool m_UserChanging;
	void __fastcall SetHScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnHScrollBarChange(System::TObject* Sender);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
	void __fastcall UpdateScrollBars(void);
	void __fastcall UpdateScrollBarsPos(void);
	void __fastcall UpdateInnerScrollBars(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOVE(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	MESSAGE void __fastcall WMClear(Messages::TMessage &Message);
	MESSAGE void __fastcall WMUndo(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLBUTTONDOWN(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMOUSEWHEEL(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetText(Messages::TWMSetText &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiMemo(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
	__property Align  = {default=0};
	__property Alignment  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Color  = {default=-2147483643};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property HideSelection  = {default=1};
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property Lines ;
	__property MaxLength  = {default=0};
	__property OEMConvert  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ScrollBars  = {default=0};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property WantReturns  = {default=1};
	__property WantTabs  = {default=0};
	__property WordWrap  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TsuiMemo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiMemo(HWND ParentWindow) : Stdctrls::TCustomMemo(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suimemo */
using namespace Suimemo;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIMemo
