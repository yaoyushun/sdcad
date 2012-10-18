// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUITreeView.pas' rev: 5.00

#ifndef SUITreeViewHPP
#define SUITreeViewHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suitreeview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiTreeView;
class PASCALIMPLEMENTATION TsuiTreeView : public Comctrls::TCustomTreeView 
{
	typedef Comctrls::TCustomTreeView inherited;
	
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
	HIDESBASE MESSAGE void __fastcall WMDELETEITEM(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiTreeView(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
	__property Align ;
	__property Anchors ;
	__property AutoExpand ;
	__property BevelEdges ;
	__property BevelInner ;
	__property BevelOuter ;
	__property BevelKind ;
	__property BevelWidth ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property BorderWidth ;
	__property ChangeDelay ;
	__property Color ;
	__property Ctl3D ;
	__property Constraints ;
	__property DragKind ;
	__property DragCursor ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HideSelection ;
	__property HotTrack ;
	__property Images ;
	__property Indent ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property RightClickSelect ;
	__property RowSelect ;
	__property ShowButtons ;
	__property ShowHint ;
	__property ShowLines ;
	__property ShowRoot ;
	__property SortType ;
	__property StateImages ;
	__property TabOrder ;
	__property TabStop ;
	__property ToolTips ;
	__property Visible ;
	__property OnAdvancedCustomDraw ;
	__property OnAdvancedCustomDrawItem ;
	__property OnChange ;
	__property OnChanging ;
	__property OnClick ;
	__property OnCollapsed ;
	__property OnCollapsing ;
	__property OnCompare ;
	__property OnContextPopup ;
	__property OnCustomDraw ;
	__property OnCustomDrawItem ;
	__property OnDblClick ;
	__property OnDeletion ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEdited ;
	__property OnEditing ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnExpanding ;
	__property OnExpanded ;
	__property OnGetImageIndex ;
	__property OnGetSelectedIndex ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property Items ;
public:
	#pragma option push -w-inl
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TsuiTreeView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTreeView(HWND ParentWindow) : Comctrls::TCustomTreeView(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suitreeview */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suitreeview;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUITreeView
