// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIMainMenu.pas' rev: 6.00

#ifndef SUIMainMenuHPP
#define SUIMainMenuHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIForm.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suimainmenu
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiMainMenu;
class PASCALIMPLEMENTATION TsuiMainMenu : public Menus::TMainMenu 
{
	typedef Menus::TMainMenu inherited;
	
private:
	Imglist::TCustomImageList* m_Images;
	Suithemes::TsuiUIStyle m_UIStyle;
	int m_Height;
	int m_SeparatorHeight;
	Graphics::TColor m_BarColor;
	int m_BarWidth;
	Graphics::TColor m_Color;
	Graphics::TColor m_SeparatorColor;
	Graphics::TColor m_SelectedBorderColor;
	Graphics::TColor m_SelectedColor;
	Graphics::TColor m_SelectedFontColor;
	Graphics::TColor m_FontColor;
	Graphics::TColor m_BorderColor;
	bool m_FlatMenu;
	AnsiString m_FontName;
	int m_FontSize;
	Graphics::TFontCharset m_FontCharset;
	bool m_UseSystemFont;
	Suiform::TsuiForm* m_Form;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Imglist::TCustomImageList* __fastcall GetImages(void);
	HIDESBASE void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	bool __fastcall GetOwnerDraw(void);
	HIDESBASE void __fastcall SetOwnerDraw(const bool Value);
	void __fastcall DrawItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool Selected);
	void __fastcall MeasureItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetSeparatorHeight(const int Value);
	void __fastcall SetUseSystemFont(const bool Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall MenuChanged(System::TObject* Sender, Menus::TMenuItem* Source, bool Rebuild);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiMainMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiMainMenu(void);
	virtual void __fastcall AfterConstruction(void);
	void __fastcall MenuAdded(void);
	__property Suiform::TsuiForm* Form = {read=m_Form, write=m_Form};
	
__published:
	__property Images  = {read=GetImages, write=SetImages};
	__property OwnerDraw  = {read=GetOwnerDraw, write=SetOwnerDraw, default=0};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property int MenuItemHeight = {read=m_Height, write=SetHeight, nodefault};
	__property int SeparatorHeight = {read=m_SeparatorHeight, write=SetSeparatorHeight, nodefault};
	__property int BarWidth = {read=m_BarWidth, write=m_BarWidth, nodefault};
	__property Graphics::TColor BarColor = {read=m_BarColor, write=m_BarColor, nodefault};
	__property Graphics::TColor Color = {read=m_Color, write=m_Color, nodefault};
	__property Graphics::TColor SeparatorColor = {read=m_SeparatorColor, write=m_SeparatorColor, nodefault};
	__property Graphics::TColor SelectedBorderColor = {read=m_SelectedBorderColor, write=m_SelectedBorderColor, nodefault};
	__property Graphics::TColor SelectedColor = {read=m_SelectedColor, write=m_SelectedColor, nodefault};
	__property Graphics::TColor SelectedFontColor = {read=m_SelectedFontColor, write=m_SelectedFontColor, nodefault};
	__property Graphics::TColor FontColor = {read=m_FontColor, write=m_FontColor, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=m_BorderColor, nodefault};
	__property bool FlatMenu = {read=m_FlatMenu, write=m_FlatMenu, nodefault};
	__property AnsiString FontName = {read=m_FontName, write=m_FontName};
	__property int FontSize = {read=m_FontSize, write=m_FontSize, nodefault};
	__property Graphics::TFontCharset FontCharset = {read=m_FontCharset, write=m_FontCharset, nodefault};
	__property bool UseSystemFont = {read=m_UseSystemFont, write=SetUseSystemFont, nodefault};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suimainmenu */
using namespace Suimainmenu;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIMainMenu
