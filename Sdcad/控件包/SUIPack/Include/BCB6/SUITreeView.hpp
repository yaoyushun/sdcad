// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUITreeView.pas' rev: 6.00

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
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiTreeView(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
	__property MultiSelect  = {default=0};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property AutoExpand  = {default=0};
	__property BevelEdges  = {default=15};
	__property BevelInner  = {index=0, default=2};
	__property BevelOuter  = {index=1, default=1};
	__property BevelKind  = {default=0};
	__property BevelWidth  = {default=1};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property BorderWidth  = {default=0};
	__property ChangeDelay  = {default=0};
	__property Color  = {default=-2147483643};
	__property Ctl3D ;
	__property Constraints ;
	__property DragKind  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Font ;
	__property HideSelection  = {default=1};
	__property HotTrack  = {default=0};
	__property Images ;
	__property Indent ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property RightClickSelect  = {default=0};
	__property RowSelect  = {default=0};
	__property ShowButtons  = {default=1};
	__property ShowHint ;
	__property ShowLines  = {default=1};
	__property ShowRoot  = {default=1};
	__property SortType  = {default=0};
	__property StateImages ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property ToolTips  = {default=1};
	__property Visible  = {default=1};
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
	/* TWinControl.CreateParented */ inline __fastcall TsuiTreeView(HWND ParentWindow) : Comctrls::TCustomTreeView(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suitreeview */
using namespace Suitreeview;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUITreeView
