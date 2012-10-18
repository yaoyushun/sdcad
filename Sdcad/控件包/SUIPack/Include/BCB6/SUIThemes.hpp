// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIThemes.pas' rev: 6.00

#ifndef SUIThemesHPP
#define SUIThemesHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIThemeFile.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suithemes
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TsuiUIStyle { FromThemeFile, MacOS, WinXP, DeepBlue, Protein, BlueGlass };
#pragma option pop

typedef AnsiString SUIThemes__1[48];

#pragma option push -b-
enum TsuiType { Int, Color, Str, Bool };
#pragma option pop

#pragma pack(push, 4)
struct TsuiThemeItem
{
	
	union
	{
		struct 
		{
			bool Bool;
			
		};
		struct 
		{
			char *Str;
			
		};
		struct 
		{
			Graphics::TColor Color;
			
		};
		struct 
		{
			int Int;
			
		};
		
	};
} ;
#pragma pack(pop)

typedef TsuiType TsuiThemeItemType[48];

typedef TsuiThemeItem TsuiThemeDef[48];

typedef TsuiThemeItem *PTsuiThemeDef;

class DELPHICLASS TsuiFileThemeMgr;
class PASCALIMPLEMENTATION TsuiFileThemeMgr : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Suithemefile::TsuiThemeFileReader* m_FileReader;
	
public:
	__fastcall TsuiFileThemeMgr(void);
	__fastcall virtual ~TsuiFileThemeMgr(void);
	bool __fastcall LoadFromFile(AnsiString FileName);
	void __fastcall GetBitmap(const int Index, const Graphics::TBitmap* Buf);
	int __fastcall GetInt(const int Index);
	Graphics::TColor __fastcall GetColor(const int Index);
	bool __fastcall GetBool(const int Index);
};


//-- var, const, procedure ---------------------------------------------------
#define SUI_THEME_DEFAULT (TsuiUIStyle)(3)
static const Shortint SUI_THEME_BUTTON_IMAGE = 0x1;
static const Shortint SUI_THEME_BUTTON_TRANSPARENT_BOOL = 0x2;
static const Shortint SUI_THEME_CHECKBOX_IMAGE = 0x3;
static const Shortint SUI_THEME_RADIOBUTTON_IMAGE = 0x4;
static const Shortint SUI_THEME_TITLEBAR_BUTTON_IMAGE = 0x5;
static const Shortint SUI_THEME_TITLEBAR_BUTTON_TRANSPARENT_BOOL = 0x6;
static const Shortint SUI_THEME_TITLEBAR_BUTTON_LEFTOFFSET_INT = 0x7;
static const Shortint SUI_THEME_TITLEBAR_BUTTON_RIGHTOFFSET_INT = 0x8;
static const Shortint SUI_THEME_TITLEBAR_BUTTON_TOP_INT = 0x9;
static const Shortint SUI_THEME_TITLEBAR_LEFT_IMAGE = 0xa;
static const Shortint SUI_THEME_TITLEBAR_CLIENT_IMAGE = 0xb;
static const Shortint SUI_THEME_TITLEBAR_RIGHT_IMAGE = 0xc;
static const Shortint SUI_THEME_FORM_MINWIDTH_INT = 0xd;
static const Shortint SUI_THEME_FORM_ROUNDCORNER_INT = 0xe;
static const Shortint SUI_THEME_FORM_BACKGROUND_COLOR = 0xf;
static const Shortint SUI_THEME_FORM_BORDER_COLOR = 0x10;
static const Shortint SUI_THEME_FORM_BORDERWIDTH_INT = 0x11;
static const Shortint SUI_THEME_MENU_SELECTED_BORDER_COLOR = 0x12;
static const Shortint SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR = 0x13;
static const Shortint SUI_THEME_MENU_SELECTED_FONT_COLOR = 0x14;
static const Shortint SUI_THEME_MENU_BACKGROUND_COLOR = 0x15;
static const Shortint SUI_THEME_MENU_FONT_COLOR = 0x16;
static const Shortint SUI_THEME_MENU_LEFTBAR_COLOR = 0x17;
static const Shortint SUI_THEME_PROGRESSBAR_IMAGE = 0x18;
static const Shortint SUI_THEME_CONTROL_BORDER_COLOR = 0x19;
static const Shortint SUI_THEME_CONTROL_BACKGROUND_COLOR = 0x1a;
static const Shortint SUI_THEME_CONTROL_FONT_COLOR = 0x1b;
static const Shortint SUI_THEME_TRACKBAR_BAR = 0x1c;
static const Shortint SUI_THEME_TRACKBAR_SLIDER = 0x1d;
static const Shortint SUI_THEME_TRACKBAR_SLIDER_V = 0x1e;
static const Shortint SUI_THEME_SCROLLBAR_BACKGROUND_COLOR = 0x1f;
static const Shortint SUI_THEME_SCROLLBAR_BUTTON_IMAGE = 0x20;
static const Shortint SUI_THEME_SCROLLBAR_SLIDER_IMAGE = 0x21;
static const Shortint SUI_THEME_CHECKLISTBOX_IMAGE = 0x22;
static const Shortint SUI_THEME_TOOLBAR_BUTTON_BORDER_COLOR = 0x23;
static const Shortint SUI_THEME_TOOLBAR_BUTTON_BACKGROUND_COLOR = 0x24;
static const Shortint SUI_THEME_TOOLBAR_BUTTON_DOWN_BACKGROUND_COLOR = 0x25;
static const Shortint SUI_THEME_SCROLLBUTTON_IMAGE = 0x26;
static const Shortint SUI_THEME_TABCONTROL_TAB_IMAGE = 0x27;
static const Shortint SUI_THEME_TABCONTROL_BAR_IMAGE = 0x28;
static const Shortint SUI_THEME_SIDECHENNEL_HANDLE_IMAGE = 0x29;
static const Shortint SUI_THEME_SIDECHENNEL_BAR_IMAGE = 0x2a;
static const Shortint SUI_THEME_TITLEBAR_MINIMIZED_IMAGE = 0x2b;
static const Shortint SUI_THEME_TITLEBAR_FONT_COLOR = 0x2c;
static const Shortint SUI_THEME_FORM_LEFTBORDER_IMAGE = 0x2d;
static const Shortint SUI_THEME_FORM_BOTTOMBORDER_IMAGE = 0x2e;
static const Shortint SUI_THEME_FORM_BOTTOMROUNDCORNOR_INT = 0x2f;
static const Shortint SUI_THEME_MENU_MENUBAR_COLOR = 0x30;
static const Shortint SUI_THEME_ITEM_COUNT = 0x30;
extern PACKAGE AnsiString SUI_FILETHEME_ITEMNAME[48];
extern PACKAGE TsuiType SUI_ITEM_TYPE[48];
extern PACKAGE TsuiUIStyle __fastcall GetSUIFormStyle(Classes::TComponent* Owner);
extern PACKAGE void __fastcall GetInsideThemeBitmap(TsuiUIStyle Theme, const int Index, const Graphics::TBitmap* Buf, int SpitCount = 0x0, int SpitIndex = 0x0);
extern PACKAGE bool __fastcall GetInsideThemeBool(TsuiUIStyle Theme, const int Index);
extern PACKAGE Graphics::TColor __fastcall GetInsideThemeColor(TsuiUIStyle Theme, const int Index);
extern PACKAGE int __fastcall GetInsideThemeInt(TsuiUIStyle Theme, const int Index);

}	/* namespace Suithemes */
using namespace Suithemes;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIThemes
