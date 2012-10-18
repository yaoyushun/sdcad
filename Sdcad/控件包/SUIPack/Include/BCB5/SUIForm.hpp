// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIForm.pas' rev: 5.00

#ifndef SUIFormHPP
#define SUIFormHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <frmMSNPop.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SUIButton.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUITitleBar.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <AppEvnts.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiMenuBar;
class DELPHICLASS TsuiForm;
class PASCALIMPLEMENTATION TsuiForm : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Suititlebar::TsuiTitleBar* m_TitleBar;
	TsuiMenuBar* m_MenuBar;
	Menus::TMainMenu* m_Menu;
	Controls::TWndMethod m_OldWndProc;
	Graphics::TBitmap* m_BorderBuf;
	int m_BottomBorderWidth;
	Forms::TFormBorderStyle m_OldBorderStyle;
	Forms::TForm* m_Form;
	Graphics::TColor m_Color;
	Extctrls::TCustomPanel* m_Panel;
	int m_Width;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_MenuBarColor;
	int m_MenuBarHeight;
	bool m_UIStyleAutoUpdateSub;
	bool m_Destroyed;
	Appevnts::TApplicationEvents* m_AppEvent;
	Windows::TRect m_FormInitRect;
	bool m_FormInitMax;
	bool m_MDIChildFormTitleVisible;
	bool m_SelfChanging;
	void __fastcall NewParentWndProc(Messages::TMessage &Msg);
	void __fastcall ProcessKeyPress(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	void __fastcall SetButtons(const Suititlebar::TsuiTitleBarButtons* Value);
	Suititlebar::TsuiTitleBarButtons* __fastcall GetButtons(void);
	Suititlebar::TsuiTitleBarButtonClickEvent __fastcall GetOnBtnClick();
	void __fastcall SetOnBtnClick(const Suititlebar::TsuiTitleBarButtonClickEvent Value);
	Suititlebar::TsuiTitleBarButtonClickEvent __fastcall GetOnHelpBtnClick();
	void __fastcall SetOnHelpBtnClick(const Suititlebar::TsuiTitleBarButtonClickEvent Value);
	Graphics::TFont* __fastcall GetFont(void);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	AnsiString __fastcall GetCaption();
	void __fastcall SetCaption(const AnsiString Value);
	void __fastcall SetMenu(const Menus::TMainMenu* Value);
	void __fastcall SetMenuBarColor(const Graphics::TColor Value);
	Suititlebar::TsuiTitleBarSections* __fastcall GetSections(void);
	void __fastcall SetSections(const Suititlebar::TsuiTitleBarSections* Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	bool __fastcall GetDrawAppIcon(void);
	void __fastcall SetDrawAppIcon(const bool Value);
	void __fastcall SetMenuBarHeight(const int Value);
	void __fastcall SetTitleBarVisible(const bool Value);
	bool __fastcall GetTitleBarVisible(void);
	bool __fastcall GetMDIChild(void);
	int __fastcall GetRoundCorner(void);
	void __fastcall SetRoundCorner(const int Value);
	int __fastcall GetRoundCornerBottom(void);
	void __fastcall SetRoundCornerBottom(const int Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall DrawButton(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState 
		State, bool &DefaultDraw);
	void __fastcall DrawMenuBar(Comctrls::TToolBar* Sender, const Windows::TRect &ARect, bool &DefaultDraw
		);
	void __fastcall OnApplicationMessage(tagMSG &Msg, bool &Handled);
	void __fastcall OnApplicationHint(System::TObject* Sender);
	int __fastcall GetTitleBarHeight(void);
	bool __fastcall GetTitleBarCustom(void);
	void __fastcall SetTitleBarCustom(const bool Value);
	AnsiString __fastcall GetVersion();
	void __fastcall SetVersion(const AnsiString Value);
	void __fastcall RegionWindow(void);
	
protected:
	void __fastcall SetPanel(const Extctrls::TCustomPanel* Value);
	HIDESBASE void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	void __fastcall PaintFormBorder(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall CreateMenuBar(void);
	void __fastcall DestroyMenuBar(void);
	
public:
	__fastcall virtual TsuiForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiForm(void);
	void __fastcall UpdateMenu(void);
	void __fastcall UpdateTopMenu(void);
	void __fastcall RepaintMenuBar(void);
	__property bool MDIChild = {read=GetMDIChild, nodefault};
	__property int TitleBarHeight = {read=GetTitleBarHeight, nodefault};
	void __fastcall ReAssign(void);
	
__published:
	__property bool TitleBarCustom = {read=GetTitleBarCustom, write=SetTitleBarCustom, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property bool UIStyleAutoUpdateSub = {read=m_UIStyleAutoUpdateSub, write=m_UIStyleAutoUpdateSub, 
		nodefault};
	__property Graphics::TColor BorderColor = {read=m_Color, write=SetColor, nodefault};
	__property int BorderWidth = {read=m_Width, write=SetBorderWidth, nodefault};
	__property bool TitleBarVisible = {read=GetTitleBarVisible, write=SetTitleBarVisible, default=1};
	__property BiDiMode ;
	__property Color ;
	__property AnsiString Caption = {read=GetCaption, write=SetCaption};
	__property Extctrls::TCustomPanel* FormPanel = {read=m_Panel, write=SetPanel};
	__property Suititlebar::TsuiTitleBarButtons* TitleBarButtons = {read=GetButtons, write=SetButtons};
		
	__property Suititlebar::TsuiTitleBarSections* TitleBarSections = {read=GetSections, write=SetSections
		};
	__property bool TitleBarDrawAppIcon = {read=GetDrawAppIcon, write=SetDrawAppIcon, nodefault};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Menus::TMainMenu* Menu = {read=m_Menu, write=SetMenu};
	__property Graphics::TColor MenuBarColor = {read=m_MenuBarColor, write=SetMenuBarColor, nodefault};
		
	__property int MenuBarHeight = {read=m_MenuBarHeight, write=SetMenuBarHeight, nodefault};
	__property int RoundCorner = {read=GetRoundCorner, write=SetRoundCorner, nodefault};
	__property int RoundCornerBottom = {read=GetRoundCornerBottom, write=SetRoundCornerBottom, nodefault
		};
	__property PopupMenu ;
	__property AnsiString Version = {read=GetVersion, write=SetVersion};
	__property Suititlebar::TsuiTitleBarButtonClickEvent OnTitleBarCustomBtnsClick = {read=GetOnBtnClick
		, write=SetOnBtnClick};
	__property Suititlebar::TsuiTitleBarButtonClickEvent OnTitleBarHelpBtnClick = {read=GetOnHelpBtnClick
		, write=SetOnHelpBtnClick};
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnClick ;
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiForm(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiMDIForm;
class PASCALIMPLEMENTATION TsuiMDIForm : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Forms::TForm* m_Form;
	Controls::TWndMethod m_OldWndProc;
	void *m_PrevClientWndProc;
	Extctrls::TPanel* m_TopPanel;
	Suititlebar::TsuiTitleBar* m_TitleBar;
	TsuiMenuBar* m_MenuBar;
	Suibutton::TsuiToolBarSpeedButton* m_ControlBtns[3];
	bool m_DrawChildCaptions;
	bool m_DrawChildMenus;
	bool m_Destroyed;
	Graphics::TBitmap* m_BorderBuf;
	int m_BottomBorderWidth;
	Menus::TMainMenu* m_Menu;
	Menus::TMainMenu* m_TopMenu;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_MenuBarColor;
	Graphics::TColor m_BorderColor;
	int m_BorderWidth;
	int m_RoundCorner;
	int m_RoundCornerBottom;
	Appevnts::TApplicationEvents* m_AppEvent;
	Classes::TList* m_WindowMenuList;
	void __fastcall NewParentWndProc(Messages::TMessage &Msg);
	void __fastcall NewClientWndProc(Messages::TMessage &Msg);
	void __fastcall ProcessKeyPress(Messages::TMessage &Msg);
	void __fastcall OnControlButtonClick(System::TObject* Sender);
	void __fastcall OnApplicationMessage(tagMSG &Msg, bool &Handled);
	void __fastcall OnTopPanelResize(System::TObject* Sender);
	void __fastcall OnWindowMenuClick(System::TObject* Sender);
	void __fastcall SetMenu(const Menus::TMainMenu* Value);
	void __fastcall SetMenuBarColor(const Graphics::TColor Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	AnsiString __fastcall GetCaption();
	void __fastcall SetCaption(const AnsiString Value);
	void __fastcall PaintBorder(void);
	TsuiForm* __fastcall GetActiveChildSUIForm(void);
	void __fastcall CreateMenuBar(void);
	void __fastcall DestroyMenuBar(void);
	void __fastcall ShowMenuBar(void);
	void __fastcall HideMenuBar(void);
	void __fastcall ShowControlButtons(void);
	void __fastcall HideControlButtons(void);
	Menus::TMainMenu* __fastcall GetMainMenu(void);
	void __fastcall SetDrawAppIcon(const bool Value);
	bool __fastcall GetDrawAppIcon(void);
	bool __fastcall GetTitleBarCustom(void);
	void __fastcall SetTitleBarCustom(const bool Value);
	void __fastcall SetTitleBarVisible(const bool Value);
	bool __fastcall GetTitleBarVisible(void);
	Suititlebar::TsuiTitleBarSections* __fastcall GetSections(void);
	void __fastcall SetSections(const Suititlebar::TsuiTitleBarSections* Value);
	void __fastcall SetButtons(const Suititlebar::TsuiTitleBarButtons* Value);
	Suititlebar::TsuiTitleBarButtons* __fastcall GetButtons(void);
	void __fastcall DrawButton(Comctrls::TToolBar* Sender, Comctrls::TToolButton* Button, Comctrls::TCustomDrawState 
		State, bool &DefaultDraw);
	void __fastcall DrawMenuBar(Comctrls::TToolBar* Sender, const Windows::TRect &ARect, bool &DefaultDraw
		);
	void __fastcall SetRoundCorner(const int Value);
	void __fastcall SetRoundCornerBottom(const int Value);
	void __fastcall RegionWindow(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TsuiMDIForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiMDIForm(void);
	void __fastcall UpdateMenu(void);
	void __fastcall UpdateWindowMenu(void);
	void __fastcall Cascade(void);
	void __fastcall Tile(void);
	int __fastcall GetTitleBarHeight(void);
	
__published:
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Menus::TMainMenu* Menu = {read=m_Menu, write=SetMenu};
	__property Graphics::TColor MenuBarColor = {read=m_MenuBarColor, write=SetMenuBarColor, nodefault};
		
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property AnsiString Caption = {read=GetCaption, write=SetCaption};
	__property bool TitleBarDrawAppIcon = {read=GetDrawAppIcon, write=SetDrawAppIcon, default=0};
	__property bool TitleBarCustom = {read=GetTitleBarCustom, write=SetTitleBarCustom, default=0};
	__property bool TitleBarVisible = {read=GetTitleBarVisible, write=SetTitleBarVisible, default=1};
	__property Suititlebar::TsuiTitleBarButtons* TitleBarButtons = {read=GetButtons, write=SetButtons};
		
	__property Suititlebar::TsuiTitleBarSections* TitleBarSections = {read=GetSections, write=SetSections
		};
	__property bool TitleBarDrawChildCaptions = {read=m_DrawChildCaptions, write=m_DrawChildCaptions, default=1
		};
	__property bool TitleBarDrawChildMenus = {read=m_DrawChildMenus, write=m_DrawChildMenus, default=1}
		;
	__property int RoundCorner = {read=m_RoundCorner, write=SetRoundCorner, nodefault};
	__property int RoundCornerBottom = {read=m_RoundCornerBottom, write=SetRoundCornerBottom, nodefault
		};
};


class PASCALIMPLEMENTATION TsuiMenuBar : public Comctrls::TToolBar 
{
	typedef Comctrls::TToolBar inherited;
	
private:
	TsuiForm* m_Form;
	TsuiMDIForm* m_MDIForm;
	void __fastcall OnMenuPopup(System::TObject* Sender);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
public:
	#pragma option push -w-inl
	/* TToolBar.Create */ inline __fastcall virtual TsuiMenuBar(Classes::TComponent* AOwner) : Comctrls::TToolBar(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TToolBar.Destroy */ inline __fastcall virtual ~TsuiMenuBar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiMenuBar(HWND ParentWindow) : Comctrls::TToolBar(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiMSNPopForm;
class PASCALIMPLEMENTATION TsuiMSNPopForm : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Frmmsnpop::TfrmMSNPopForm* m_Form;
	int m_AnimateTime;
	int m_StayTime;
	int m_X;
	int m_Y;
	bool m_AutoPosition;
	bool m_ClickHide;
	AnsiString m_Title;
	AnsiString m_Text;
	Graphics::TFont* m_TextFont;
	Graphics::TFont* m_TitleFont;
	Classes::TNotifyEvent m_OnTitleClick;
	Classes::TNotifyEvent m_OnClick;
	Classes::TNotifyEvent m_OnClose;
	Classes::TNotifyEvent m_OnShow;
	void __fastcall InternalOnTitleClick(System::TObject* Sender);
	void __fastcall InternalOnClick(System::TObject* Sender);
	void __fastcall InternalOnClose(System::TObject* Sender);
	void __fastcall SetTextFont(const Graphics::TFont* Value);
	void __fastcall SetTitleFont(const Graphics::TFont* Value);
	
public:
	__fastcall virtual TsuiMSNPopForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiMSNPopForm(void);
	void __fastcall Popup(void);
	void __fastcall Close(void);
	
__published:
	__property int AnimateTime = {read=m_AnimateTime, write=m_AnimateTime, nodefault};
	__property int StayTime = {read=m_StayTime, write=m_StayTime, nodefault};
	__property int PositionX = {read=m_X, write=m_X, nodefault};
	__property int PositionY = {read=m_Y, write=m_Y, nodefault};
	__property bool AutoPosition = {read=m_AutoPosition, write=m_AutoPosition, nodefault};
	__property bool ClickHide = {read=m_ClickHide, write=m_ClickHide, nodefault};
	__property AnsiString Title = {read=m_Title, write=m_Title};
	__property AnsiString MessageText = {read=m_Text, write=m_Text};
	__property Graphics::TFont* TitleFont = {read=m_TitleFont, write=SetTitleFont};
	__property Graphics::TFont* MessageFont = {read=m_TextFont, write=SetTextFont};
	__property Classes::TNotifyEvent OnTitleClick = {read=m_OnTitleClick, write=m_OnTitleClick};
	__property Classes::TNotifyEvent OnClick = {read=m_OnClick, write=m_OnClick};
	__property Classes::TNotifyEvent OnClose = {read=m_OnClose, write=m_OnClose};
	__property Classes::TNotifyEvent OnShow = {read=m_OnShow, write=m_OnShow};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiform */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiform;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIForm
