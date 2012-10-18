// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIListBox.pas' rev: 5.00

#ifndef SUIListBoxHPP
#define SUIListBoxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suilistbox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiListBox;
class PASCALIMPLEMENTATION TsuiListBox : public Stdctrls::TCustomListBox 
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
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
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	bool FShowFocusRect;
	Classes::TAlignment FAlignment;
	Graphics::TColor FSelectedTextColor;
	Graphics::TColor FSelectedColor;
	Graphics::TColor FDisabledTextColor;
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Msg);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedTextColor(const Graphics::TColor Value);
	void __fastcall SetShowFocusRect(const bool Value);
	void __fastcall SetDisabledTextColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall DrawItem(int Index, const Windows::TRect &Rect, Windows::TOwnerDrawState State
		);
	virtual void __fastcall MeasureItem(int Index, int &Height);
	
public:
	__fastcall virtual TsuiListBox(Classes::TComponent* AOwner);
	int __fastcall MeasureString(const AnsiString S, int WidthAvail);
	virtual void __fastcall DefaultDrawItem(int Index, const Windows::TRect &Rect, Windows::TOwnerDrawState 
		State);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, default=-2147483635
		};
	__property Graphics::TColor SelectedTextColor = {read=FSelectedTextColor, write=SetSelectedTextColor
		, default=-2147483634};
	__property Graphics::TColor DisabledTextColor = {read=FDisabledTextColor, write=SetDisabledTextColor
		, default=-2147483631};
	__property bool ShowFocusRect = {read=FShowFocusRect, write=SetShowFocusRect, default=1};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Style ;
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Columns ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property ExtendedSelect ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property IntegralHeight ;
	__property ItemHeight ;
	__property Items ;
	__property MultiSelect ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted ;
	__property TabOrder ;
	__property TabStop ;
	__property TabWidth ;
	__property Visible ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMeasureItem ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TsuiListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDirectoryListBox;
class PASCALIMPLEMENTATION TsuiDirectoryListBox : public Filectrl::TDirectoryListBox 
{
	typedef Filectrl::TDirectoryListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
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
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiDirectoryListBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
public:
		
	#pragma option push -w-inl
	/* TDirectoryListBox.Destroy */ inline __fastcall virtual ~TsuiDirectoryListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDirectoryListBox(HWND ParentWindow) : Filectrl::TDirectoryListBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiFileListBox;
class PASCALIMPLEMENTATION TsuiFileListBox : public Filectrl::TFileListBox 
{
	typedef Filectrl::TFileListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
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
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiFileListBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
public:
		
	#pragma option push -w-inl
	/* TFileListBox.Destroy */ inline __fastcall virtual ~TsuiFileListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiFileListBox(HWND ParentWindow) : Filectrl::TFileListBox(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suilistbox */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suilistbox;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIListBox
