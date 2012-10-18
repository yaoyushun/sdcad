// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUITitleBar.pas' rev: 5.00

#ifndef SUITitleBarHPP
#define SUITitleBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIPopupMenu.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suititlebar
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TsuiTitleBarButtonClickEvent)(System::TObject* Sender, int ButtonIndex
	);

class DELPHICLASS TsuiTitleBarPopupMenu;
class DELPHICLASS TsuiTitleBar;
class DELPHICLASS TsuiTitleBarSections;
class DELPHICLASS TsuiTitleBarSection;
class PASCALIMPLEMENTATION TsuiTitleBarSections : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
private:
	TsuiTitleBar* m_TitleBar;
	
protected:
	HIDESBASE TsuiTitleBarSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TsuiTitleBarSection* Value);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TsuiTitleBarSections(TsuiTitleBar* TitleBar);
	__fastcall virtual ~TsuiTitleBarSections(void);
	HIDESBASE TsuiTitleBarSection* __fastcall Add(void);
	__property TsuiTitleBarSection* Items[int Index] = {read=GetItem, write=SetItem};
};


class DELPHICLASS TsuiTitleBarButtons;
class DELPHICLASS TsuiTitleBarButton;
class PASCALIMPLEMENTATION TsuiTitleBarButtons : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
private:
	TsuiTitleBar* m_TitleBar;
	
protected:
	HIDESBASE TsuiTitleBarButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TsuiTitleBarButton* Value);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TsuiTitleBarButton* __fastcall Add(void);
	__fastcall TsuiTitleBarButtons(TsuiTitleBar* TitleBar);
	__property TsuiTitleBarButton* Items[int Index] = {read=GetItem, write=SetItem};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TsuiTitleBarButtons(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TsuiTitleBar : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	TsuiTitleBarSections* m_Sections;
	TsuiTitleBarButtons* m_Buttons;
	bool m_AutoSize;
	int m_ButtonInterval;
	AnsiString m_Caption;
	bool m_Active;
	int m_LeftBtnXOffset;
	int m_RightBtnXOffset;
	int m_RoundCorner;
	int m_RoundCornerBottom;
	bool m_DrawAppIcon;
	bool m_SelfChanging;
	TsuiTitleBarPopupMenu* m_DefPopupMenu;
	Graphics::TColor m_BorderColor;
	bool m_Custom;
	bool m_MouseDown;
	int m_InButtons;
	int m_BtnHeight;
	int m_BtnTop;
	TsuiTitleBarButtonClickEvent m_OnBtnClick;
	TsuiTitleBarButtonClickEvent m_OnHelpBtnClick;
	void __fastcall SetButtons(const TsuiTitleBarButtons* Value);
	void __fastcall SetSections(const TsuiTitleBarSections* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetButtonInterval(const int Value);
	void __fastcall SetCaption(const AnsiString Value);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetAutoSize2(bool Value);
	void __fastcall SetLeftBtnXOffset(const int Value);
	void __fastcall SetRightBtnXOffset(const int Value);
	void __fastcall SetDrawAppIcon(const bool Value);
	void __fastcall SetRoundCorner(const int Value);
	void __fastcall SetRoundCornerBottom(const int Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall UpdateInsideTheme(Suithemes::TsuiUIStyle UIStyle);
	void __fastcall UpdateFileTheme(void);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFONTCHANGED(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCLBUTTONDOWN(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMNCLBUTTONUP(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMNCMOUSEMOVE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	DYNAMIC void __fastcall DblClick(void);
	MESSAGE void __fastcall MouseOut(Messages::TMessage &Msg);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall DrawSectionsTo(Graphics::TBitmap* Buf);
	virtual void __fastcall DrawButtons(Graphics::TBitmap* Buf);
	bool __fastcall InForm(void);
	bool __fastcall InMDIForm(void);
	
public:
	__fastcall virtual TsuiTitleBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiTitleBar(void);
	void __fastcall ProcessMaxBtn(void);
	void __fastcall GetLeftImage(/* out */ Graphics::TBitmap* &Bmp);
	void __fastcall GetRightImage(/* out */ Graphics::TBitmap* &Bmp);
	void __fastcall GetCenterImage(/* out */ Graphics::TBitmap* &Bmp);
	bool __fastcall CanPaint(void);
	__property TsuiTitleBarPopupMenu* DefPopupMenu = {read=m_DefPopupMenu};
	
__published:
	__property bool Custom = {read=m_Custom, write=m_Custom, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property AutoSize  = {read=m_AutoSize, write=SetAutoSize2, default=0};
	__property BiDiMode ;
	__property Height ;
	__property TsuiTitleBarSections* Sections = {read=m_Sections, write=SetSections};
	__property TsuiTitleBarButtons* Buttons = {read=m_Buttons, write=SetButtons};
	__property int ButtonInterval = {read=m_ButtonInterval, write=SetButtonInterval, nodefault};
	__property Caption  = {read=m_Caption, write=SetCaption};
	__property Font ;
	__property bool FormActive = {read=m_Active, write=SetActive, nodefault};
	__property int LeftBtnXOffset = {read=m_LeftBtnXOffset, write=SetLeftBtnXOffset, nodefault};
	__property int RightBtnXOffset = {read=m_RightBtnXOffset, write=SetRightBtnXOffset, nodefault};
	__property bool DrawAppIcon = {read=m_DrawAppIcon, write=SetDrawAppIcon, nodefault};
	__property int RoundCorner = {read=m_RoundCorner, write=SetRoundCorner, nodefault};
	__property int RoundCornerBottom = {read=m_RoundCornerBottom, write=SetRoundCornerBottom, nodefault
		};
	__property TsuiTitleBarButtonClickEvent OnCustomBtnsClick = {read=m_OnBtnClick, write=m_OnBtnClick}
		;
	__property TsuiTitleBarButtonClickEvent OnHelpBtnClick = {read=m_OnHelpBtnClick, write=m_OnHelpBtnClick
		};
	__property OnResize ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTitleBar(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TsuiTitleBarPopupMenu : public Suipopupmenu::TsuiPopupMenu 
{
	typedef Suipopupmenu::TsuiPopupMenu inherited;
	
private:
	TsuiTitleBar* m_TitleBar;
	void __fastcall OnMin(System::TObject* Sender);
	void __fastcall OnMax(System::TObject* Sender);
	void __fastcall OnClose(System::TObject* Sender);
	
public:
	__fastcall virtual TsuiTitleBarPopupMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiTitleBarPopupMenu(void);
	virtual void __fastcall Popup(int X, int Y);
	__property TsuiTitleBar* TitleBar = {read=m_TitleBar, write=m_TitleBar};
};


#pragma option push -b-
enum TsuiTitleBarBtnType { suiMax, suiMin, suiClose, suiHelp, suiControlBox, suiCustom };
#pragma option pop

class PASCALIMPLEMENTATION TsuiTitleBarButton : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool m_Visible;
	TsuiTitleBarBtnType m_ButtonType;
	bool m_Transparent;
	int m_Top;
	Suithemes::TsuiUIStyle m_UIStyle;
	Graphics::TPicture* m_PicNormal;
	Graphics::TPicture* m_PicMouseOn;
	Graphics::TPicture* m_PicMouseDown;
	Menus::TPopupMenu* m_ControlBoxMenu;
	void __fastcall SetButtonType(const TsuiTitleBarBtnType Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetPicNormal(const Graphics::TPicture* Value);
	void __fastcall SetPicMouseOn(const Graphics::TPicture* Value);
	void __fastcall SetPicMouseDown(const Graphics::TPicture* Value);
	void __fastcall UpdateUIStyle(void);
	void __fastcall UpdateInsideTheme(Suithemes::TsuiUIStyle UIStyle);
	void __fastcall UpdateFileTheme(void);
	void __fastcall ProcessMaxBtn(void);
	void __fastcall SetVisible(const bool Value);
	
public:
	void __fastcall DoClick(void);
	__fastcall virtual TsuiTitleBarButton(Classes::TCollection* Collection);
	__fastcall virtual ~TsuiTitleBarButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property TsuiTitleBarBtnType ButtonType = {read=m_ButtonType, write=SetButtonType, nodefault};
	__property bool Transparent = {read=m_Transparent, write=SetTransparent, nodefault};
	__property int Top = {read=m_Top, write=SetTop, nodefault};
	__property Menus::TPopupMenu* ControlBoxMenu = {read=m_ControlBoxMenu, write=m_ControlBoxMenu};
	__property bool Visible = {read=m_Visible, write=SetVisible, nodefault};
	__property Graphics::TPicture* PicNormal = {read=m_PicNormal, write=SetPicNormal};
	__property Graphics::TPicture* PicMouseOn = {read=m_PicMouseOn, write=SetPicMouseOn};
	__property Graphics::TPicture* PicMouseDown = {read=m_PicMouseDown, write=SetPicMouseDown};
};


#pragma option push -b-
enum TsuiTitleBarAlign { suiLeft, suiRight, suiClient };
#pragma option pop

class PASCALIMPLEMENTATION TsuiTitleBarSection : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int m_Width;
	TsuiTitleBarAlign m_Align;
	Graphics::TPicture* m_Picture;
	bool m_Stretch;
	bool m_AutoSize;
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetAlign(const TsuiTitleBarAlign Value);
	void __fastcall SetStretch(const bool Value);
	
public:
	__fastcall virtual TsuiTitleBarSection(Classes::TCollection* Collection);
	__fastcall virtual ~TsuiTitleBarSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoSize = {read=m_AutoSize, write=SetAutoSize, nodefault};
	__property int Width = {read=m_Width, write=SetWidth, nodefault};
	__property TsuiTitleBarAlign Align = {read=m_Align, write=SetAlign, nodefault};
	__property Graphics::TPicture* Picture = {read=m_Picture, write=SetPicture};
	__property bool Stretch = {read=m_Stretch, write=SetStretch, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
static const Word SUIM_GETBORDERWIDTH = 0x26c3;

}	/* namespace Suititlebar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suititlebar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUITitleBar
