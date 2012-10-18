// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIPageControl.pas' rev: 6.00

#ifndef SUIPageControlHPP
#define SUIPageControlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUITabControl.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suipagecontrol
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiPageControlTopPanel;
class PASCALIMPLEMENTATION TsuiPageControlTopPanel : public Suitabcontrol::TsuiTabControlTopPanel 
{
	typedef Suitabcontrol::TsuiTabControlTopPanel inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
public:
	#pragma option push -w-inl
	/* TsuiTabControlTopPanel.Create */ inline __fastcall TsuiPageControlTopPanel(Classes::TComponent* AOwner, Suitabcontrol::TsuiTab* TabControl) : Suitabcontrol::TsuiTabControlTopPanel(AOwner, TabControl) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TsuiTabControlTopPanel.Destroy */ inline __fastcall virtual ~TsuiPageControlTopPanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiPageControlTopPanel(HWND ParentWindow) : Suitabcontrol::TsuiTabControlTopPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiTabSheet;
class DELPHICLASS TsuiPageControl;
class PASCALIMPLEMENTATION TsuiPageControl : public Suitabcontrol::TsuiTab 
{
	typedef Suitabcontrol::TsuiTab inherited;
	
private:
	Classes::TList* m_PageList;
	TsuiTabSheet* m_ActivePage;
	Classes::TStrings* m_TempList;
	TsuiTabSheet* __fastcall NewPage(void);
	void __fastcall ActivatePage(TsuiTabSheet* Page)/* overload */;
	void __fastcall ActivatePage(int nPageIndex)/* overload */;
	void __fastcall RemovePage(TsuiTabSheet* Page);
	void __fastcall InsertPage(TsuiTabSheet* Page);
	TsuiTabSheet* __fastcall GetCurPage(void);
	void __fastcall MovePage(TsuiTabSheet* Page, int &NewIndex);
	void __fastcall ActivateNextVisiblePage(int CurPageIndex);
	void __fastcall UpdateTabVisible(void);
	int __fastcall FindNextVisiblePage(int CurPageIndex);
	int __fastcall FindPrevVisiblePage(int CurPageIndex);
	void __fastcall UpdateCaptions(void);
	void __fastcall UpdatePageIndex(void);
	HIDESBASE MESSAGE void __fastcall CMCONTROLLISTCHANGE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMCOLORCHANGED(Messages::TMessage &Msg);
	void __fastcall SetActivePage(const TsuiTabSheet* Value);
	void __fastcall ReadPages(Classes::TReader* Reader);
	void __fastcall WritePages(Classes::TWriter* Writer);
	void __fastcall ReSortPages(void);
	int __fastcall GetPageCount(void);
	TsuiTabSheet* __fastcall GetPage(int Index);
	int __fastcall GetActivePageIndex(void);
	void __fastcall SetActivePageIndex(const int Value);
	
protected:
	virtual Suitabcontrol::TsuiTabControlTopPanel* __fastcall CreateTopPanel(void);
	virtual void __fastcall TabActive(int TabIndex);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall BorderColorChanged(void);
	virtual void __fastcall ShowControl(Controls::TControl* AControl);
	
public:
	__fastcall virtual TsuiPageControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiPageControl(void);
	virtual void __fastcall UpdateUIStyle(Suithemes::TsuiUIStyle UIStyle, Suimgr::TsuiFileTheme* FileTheme);
	void __fastcall SelectNextPage(bool GoForward);
	TsuiTabSheet* __fastcall FindNextPage(TsuiTabSheet* CurPage, bool GoForward);
	__property TsuiTabSheet* Pages[int Index] = {read=GetPage};
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	
__published:
	__property TsuiTabSheet* ActivePage = {read=m_ActivePage, write=SetActivePage};
	__property int PageCount = {read=GetPageCount, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiPageControl(HWND ParentWindow) : Suitabcontrol::TsuiTab(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TsuiTabSheet : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	TsuiPageControl* m_PageControl;
	int m_PageIndex;
	AnsiString m_Caption;
	Graphics::TColor m_BorderColor;
	bool m_TabVisible;
	Classes::TNotifyEvent m_OnShow;
	Classes::TNotifyEvent m_OnHide;
	void __fastcall SetPageControl(const TsuiPageControl* Value);
	void __fastcall SetPageIndex(const int Value);
	void __fastcall ReadPageControl(Classes::TReader* Reader);
	void __fastcall WritePageControl(Classes::TWriter* Writer);
	void __fastcall SetCaption(const AnsiString Value);
	bool __fastcall GetTabVisible(void);
	void __fastcall SetTabVisible(const bool Value);
	void __fastcall DoShow(void);
	void __fastcall DoHide(void);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiTabSheet(Classes::TComponent* AOwner);
	void __fastcall UpdateUIStyle(Suithemes::TsuiUIStyle UIStyle, Suimgr::TsuiFileTheme* FileTheme);
	__property TsuiPageControl* PageControl = {read=m_PageControl, write=SetPageControl};
	
__published:
	__property int PageIndex = {read=m_PageIndex, write=SetPageIndex, nodefault};
	__property AnsiString Caption = {read=m_Caption, write=SetCaption};
	__property bool TabVisible = {read=GetTabVisible, write=SetTabVisible, nodefault};
	__property BiDiMode ;
	__property Color  = {default=-2147483633};
	__property Constraints ;
	__property UseDockManager  = {default=1};
	__property DockSite  = {default=0};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FullRepaint  = {default=1};
	__property Font ;
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
	__property Visible  = {default=1};
	__property OnCanResize ;
	__property OnClick ;
	__property Classes::TNotifyEvent OnShow = {read=m_OnShow, write=m_OnShow};
	__property Classes::TNotifyEvent OnHide = {read=m_OnHide, write=m_OnHide};
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
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiTabSheet(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTabSheet(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall PageControl_InsertPage(Classes::TComponent* AComponent);
extern PACKAGE void __fastcall PageControl_RemovePage(Classes::TComponent* AComponent);
extern PACKAGE bool __fastcall PageControl_CanRemove(Classes::TComponent* AComponent);
extern PACKAGE void __fastcall TabSheet_InsertPage(Classes::TComponent* AComponent);
extern PACKAGE void __fastcall TabSheet_RemovePage(Classes::TComponent* AComponent);
extern PACKAGE bool __fastcall TabSheet_CanRemove(Classes::TComponent* AComponent);

}	/* namespace Suipagecontrol */
using namespace Suipagecontrol;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIPageControl
