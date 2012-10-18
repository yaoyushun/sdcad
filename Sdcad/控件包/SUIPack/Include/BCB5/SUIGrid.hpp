// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIGrid.pas' rev: 5.00

#ifndef SUIGridHPP
#define SUIGridHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suigrid
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiCustomDrawGrid;
class PASCALIMPLEMENTATION TsuiCustomDrawGrid : public Grids::TDrawGrid 
{
	typedef Grids::TDrawGrid inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_FocusedColor;
	Graphics::TColor m_SelectedColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_FixedFontColor;
	bool m_MouseDown;
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
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFocusedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetFixedFontColor(const Graphics::TColor Value);
	bool __fastcall GetCtl3D(void);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetFontColor(void);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall DrawCell(int ACol, int ARow, const Windows::TRect &ARect, Grids::TGridDrawState 
		AState);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiCustomDrawGrid(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Color ;
	__property FixedColor ;
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor FocusedColor = {read=m_FocusedColor, write=SetFocusedColor, nodefault};
		
	__property Graphics::TColor SelectedColor = {read=m_SelectedColor, write=SetSelectedColor, nodefault
		};
	__property Graphics::TColor FixedFontColor = {read=m_FixedFontColor, write=SetFixedFontColor, nodefault
		};
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property Ctl3D  = {read=GetCtl3D};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
public:
		
	#pragma option push -w-inl
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~TsuiCustomDrawGrid(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomDrawGrid(HWND ParentWindow) : Grids::TDrawGrid(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDrawGrid;
class PASCALIMPLEMENTATION TsuiDrawGrid : public TsuiCustomDrawGrid 
{
	typedef TsuiCustomDrawGrid inherited;
	
__published:
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property ColCount ;
	__property Constraints ;
	__property DefaultColWidth ;
	__property DefaultRowHeight ;
	__property DefaultDrawing ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property FixedCols ;
	__property RowCount ;
	__property FixedRows ;
	__property Font ;
	__property GridLineWidth ;
	__property Options ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ScrollBars ;
	__property ShowHint ;
	__property TabOrder ;
	__property Visible ;
	__property VisibleColCount ;
	__property VisibleRowCount ;
	__property OnClick ;
	__property OnColumnMoved ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawCell ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetEditMask ;
	__property OnGetEditText ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnRowMoved ;
	__property OnSelectCell ;
	__property OnSetEditText ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnTopLeftChanged ;
public:
	#pragma option push -w-inl
	/* TsuiCustomDrawGrid.Create */ inline __fastcall virtual TsuiDrawGrid(Classes::TComponent* AOwner)
		 : TsuiCustomDrawGrid(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~TsuiDrawGrid(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDrawGrid(HWND ParentWindow) : TsuiCustomDrawGrid(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiStringGrid;
class PASCALIMPLEMENTATION TsuiStringGrid : public Grids::TStringGrid 
{
	typedef Grids::TStringGrid inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_FocusedColor;
	Graphics::TColor m_SelectedColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Graphics::TColor m_FixedFontColor;
	Suimgr::TsuiFileTheme* m_FileTheme;
	bool m_MouseDown;
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
	HIDESBASE MESSAGE void __fastcall CMBIDIMODECHANGED(Messages::TMessage &Msg);
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
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFocusedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFixedFontColor(const Graphics::TColor Value);
	bool __fastcall GetCtl3D(void);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetFontColor(void);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	Graphics::TColor __fastcall GetBGColor(void);
	void __fastcall SetBGColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetFixedBGColor(void);
	void __fastcall SetFixedBGColor(const Graphics::TColor Value);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall DrawCell(int ACol, int ARow, const Windows::TRect &ARect, Grids::TGridDrawState 
		AState);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiStringGrid(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BGColor = {read=GetBGColor, write=SetBGColor, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor FocusedColor = {read=m_FocusedColor, write=SetFocusedColor, nodefault};
		
	__property Graphics::TColor SelectedColor = {read=m_SelectedColor, write=SetSelectedColor, nodefault
		};
	__property Graphics::TColor FixedFontColor = {read=m_FixedFontColor, write=SetFixedFontColor, nodefault
		};
	__property Graphics::TColor FixedBGColor = {read=GetFixedBGColor, write=SetFixedBGColor, nodefault}
		;
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property Ctl3D  = {read=GetCtl3D};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
public:
		
	#pragma option push -w-inl
	/* TStringGrid.Destroy */ inline __fastcall virtual ~TsuiStringGrid(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiStringGrid(HWND ParentWindow) : Grids::TStringGrid(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suigrid */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suigrid;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIGrid
