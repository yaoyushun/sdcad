// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIMgr.pas' rev: 5.00

#ifndef SUIMgrHPP
#define SUIMgrHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIThemes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suimgr
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiFileTheme;
class PASCALIMPLEMENTATION TsuiFileTheme : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Suithemes::TsuiFileThemeMgr* m_Mgr;
	AnsiString m_ThemeFile;
	bool m_CanUse;
	void __fastcall SetThemeFile(const AnsiString Value);
	
public:
	__fastcall virtual TsuiFileTheme(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiFileTheme(void);
	bool __fastcall CanUse(void);
	void __fastcall GetBitmap(const int Index, const Graphics::TBitmap* Buf, int SpitCount, int SpitIndex
		);
	int __fastcall GetInt(const int Index);
	Graphics::TColor __fastcall GetColor(const int Index);
	bool __fastcall GetBool(const int Index);
	bool __fastcall CheckThemeFile(AnsiString FileName);
	
__published:
	__property AnsiString ThemeFile = {read=m_ThemeFile, write=SetThemeFile};
};


class DELPHICLASS TsuiBuiltInFileTheme;
class PASCALIMPLEMENTATION TsuiBuiltInFileTheme : public TsuiFileTheme 
{
	typedef TsuiFileTheme inherited;
	
private:
	AnsiString m_OldThemeFile;
	void __fastcall SetThemeFile2(const AnsiString Value);
	void __fastcall ReadSkinData(Classes::TStream* Stream);
	void __fastcall WriteSkinData(Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	
__published:
	__property AnsiString ThemeFile = {read=m_OldThemeFile, write=SetThemeFile2};
public:
	#pragma option push -w-inl
	/* TsuiFileTheme.Create */ inline __fastcall virtual TsuiBuiltInFileTheme(Classes::TComponent* AOwner
		) : TsuiFileTheme(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TsuiFileTheme.Destroy */ inline __fastcall virtual ~TsuiBuiltInFileTheme(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiThemeMgrCompList;
class PASCALIMPLEMENTATION TsuiThemeMgrCompList : public Classes::TStringList 
{
	typedef Classes::TStringList inherited;
	
public:
	#pragma option push -w-inl
	/* TStringList.Destroy */ inline __fastcall virtual ~TsuiThemeMgrCompList(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TsuiThemeMgrCompList(void) : Classes::TStringList() { }
	#pragma option pop
	
};


class DELPHICLASS TsuiThemeManager;
class PASCALIMPLEMENTATION TsuiThemeManager : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	TsuiFileTheme* m_FileTheme;
	TsuiThemeMgrCompList* m_List;
	Classes::TNotifyEvent m_OnUIStyleChanged;
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall UpdateAll(void);
	void __fastcall SetList(const TsuiThemeMgrCompList* Value);
	void __fastcall SetFileTheme(const TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiThemeManager(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiThemeManager(void);
	void __fastcall UpdateTheme(void);
	
__published:
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property TsuiThemeMgrCompList* CompList = {read=m_List, write=SetList};
	__property Classes::TNotifyEvent OnUIStyleChanged = {read=m_OnUIStyleChanged, write=m_OnUIStyleChanged
		};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall ThemeManagerEdit(TsuiThemeManager* AComp);
extern PACKAGE void __fastcall FileThemeEdit(TsuiFileTheme* AComp);
extern PACKAGE void __fastcall BuiltInFileThemeEdit(TsuiBuiltInFileTheme* AComp);
extern PACKAGE bool __fastcall UsingFileTheme(const TsuiFileTheme* FileTheme, const Suithemes::TsuiUIStyle 
	UIStyle, /* out */ Suithemes::TsuiUIStyle &SuggUIStyle);

}	/* namespace Suimgr */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suimgr;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIMgr
