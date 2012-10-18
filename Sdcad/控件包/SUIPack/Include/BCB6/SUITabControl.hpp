// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUITabControl.pas' rev: 6.00

#ifndef SUITabControlHPP
#define SUITabControlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suitabcontrol
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TsuiTabPosition { suiTop, suiBottom };
#pragma option pop

typedef void __fastcall (__closure *TTabActiveNotify)(System::TObject* Sender, int TabIndex);

class DELPHICLASS TsuiTabControlTopPanel;
class DELPHICLASS TsuiTab;
class PASCALIMPLEMENTATION TsuiTab : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_BorderColor;
	Graphics::TFont* m_Font;
	TsuiTabPosition m_TabPosition;
	TTabActiveNotify m_OnTabActive;
	Classes::TNotifyEvent m_OnChange;
	Comctrls::TTabChangingEvent m_OnChanging;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetTabs(const Classes::TStrings* Value);
	Classes::TStrings* __fastcall GetTabs(void);
	int __fastcall GetLeftMargin(void);
	int __fastcall GetTabIndex(void);
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetTabPosition(const TsuiTabPosition Value);
	HIDESBASE MESSAGE void __fastcall CMCursorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Message);
	void __fastcall TopPanelClick(System::TObject* Sender);
	void __fastcall TopPanelDblClick(System::TObject* Sender);
	
protected:
	TsuiTabControlTopPanel* m_TopPanel;
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual TsuiTabControlTopPanel* __fastcall CreateTopPanel(void) = 0 ;
	virtual void __fastcall SetTabIndex(const int Value);
	virtual void __fastcall BorderColorChanged(void);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	DYNAMIC void __fastcall Resize(void);
	__property Classes::TStrings* Tabs = {read=GetTabs, write=SetTabs};
	__property int TabIndex = {read=GetTabIndex, write=SetTabIndex, nodefault};
	virtual void __fastcall TabActive(int TabIndex);
	
public:
	__fastcall virtual TsuiTab(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiTab(void);
	virtual void __fastcall UpdateUIStyle(Suithemes::TsuiUIStyle UIStyle, Suimgr::TsuiFileTheme* FileTheme);
	__property DockManager ;
	
__published:
	__property Align  = {default=0};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property int LeftMargin = {read=GetLeftMargin, write=SetLeftMargin, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Color  = {default=-2147483633};
	__property Graphics::TFont* Font = {read=m_Font, write=SetFont};
	__property Visible  = {default=1};
	__property TsuiTabPosition TabPosition = {read=m_TabPosition, write=SetTabPosition, nodefault};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Constraints ;
	__property UseDockManager  = {default=1};
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FullRepaint  = {default=1};
	__property Locked  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnContextPopup ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
	__property TTabActiveNotify OnTabActive = {read=m_OnTabActive, write=m_OnTabActive};
	__property Classes::TNotifyEvent OnChange = {read=m_OnChange, write=m_OnChange};
	__property Comctrls::TTabChangingEvent OnChanging = {read=m_OnChanging, write=m_OnChanging};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTab(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TsuiTabControlTopPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Classes::TStrings* m_Tabs;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	int m_TabIndex;
	int m_LeftMargin;
	int m_TabPos[64];
	int m_TabHeight;
	bool m_UserChanging;
	int m_Passed;
	bool m_ShowButton;
	int m_InButtons;
	#pragma pack(push, 1)
	Types::TPoint m_BtnSize;
	#pragma pack(pop)
	
	bool m_AutoFit;
	Graphics::TBitmap* m_ActiveTab;
	Graphics::TBitmap* m_InactiveTab;
	Graphics::TBitmap* m_Line;
	TsuiTabPosition m_TabPosition;
	void __fastcall OnTabsChange(System::TObject* Sender);
	void __fastcall SetTabs(const Classes::TStrings* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetTabIndex(const int Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetTabPosition(const TsuiTabPosition Value);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	int __fastcall PaintTabs(const Graphics::TBitmap* Buf);
	void __fastcall PaintButtons(const Graphics::TBitmap* Buf);
	
protected:
	TsuiTab* m_TabControl;
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall RequestAlign(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	bool m_TabVisible[64];
	__fastcall TsuiTabControlTopPanel(Classes::TComponent* AOwner, TsuiTab* TabControl);
	__fastcall virtual ~TsuiTabControlTopPanel(void);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Classes::TStrings* Tabs = {read=m_Tabs, write=SetTabs};
	__property int TabIndex = {read=m_TabIndex, write=SetTabIndex, nodefault};
	__property int LeftMargin = {read=m_LeftMargin, write=SetLeftMargin, nodefault};
	__property TsuiTabPosition TabPosition = {read=m_TabPosition, write=SetTabPosition, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTabControlTopPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiTabControl;
class PASCALIMPLEMENTATION TsuiTabControl : public TsuiTab 
{
	typedef TsuiTab inherited;
	
protected:
	virtual TsuiTabControlTopPanel* __fastcall CreateTopPanel(void);
	
__published:
	__property Tabs ;
	__property TabIndex ;
public:
	#pragma option push -w-inl
	/* TsuiTab.Create */ inline __fastcall virtual TsuiTabControl(Classes::TComponent* AOwner) : TsuiTab(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TsuiTab.Destroy */ inline __fastcall virtual ~TsuiTabControl(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTabControl(HWND ParentWindow) : TsuiTab(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint SUI_TABCONTROL_MAXTABS = 0x40;

}	/* namespace Suitabcontrol */
using namespace Suitabcontrol;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUITabControl
