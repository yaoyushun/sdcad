// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIDlg.pas' rev: 6.00

#ifndef SUIDlgHPP
#define SUIDlgHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suidlg
{
//-- type declarations -------------------------------------------------------
typedef Shortint TsuiDialogButtonsCount;

#pragma option push -b-
enum TsuiIconType { suiNone, suiWarning, suiStop, suiInformation, suiHelp };
#pragma option pop

class DELPHICLASS TsuiDialog;
class PASCALIMPLEMENTATION TsuiDialog : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Forms::TPosition m_Position;
	AnsiString m_Caption;
	Controls::TCursor m_ButtonCursor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TFont* m_Font;
	Graphics::TFont* m_CaptionFont;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property Controls::TCursor ButtonCursor = {read=m_ButtonCursor, write=m_ButtonCursor, nodefault};
	
public:
	__fastcall virtual TsuiDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiDialog(void);
	virtual Controls::TModalResult __fastcall ShowModal(void) = 0 ;
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Forms::TPosition Position = {read=m_Position, write=m_Position, nodefault};
	__property AnsiString Caption = {read=m_Caption, write=m_Caption};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TFont* Font = {read=m_Font, write=SetFont};
	__property Graphics::TFont* CaptionFont = {read=m_CaptionFont, write=SetCaptionFont};
};


class DELPHICLASS TsuiMessageDialog;
class PASCALIMPLEMENTATION TsuiMessageDialog : public TsuiDialog 
{
	typedef TsuiDialog inherited;
	
private:
	TsuiDialogButtonsCount m_ButtonCount;
	AnsiString m_Button1Caption;
	AnsiString m_Button2Caption;
	AnsiString m_Button3Caption;
	Controls::TModalResult m_Button1ModalResult;
	Controls::TModalResult m_Button2ModalResult;
	Controls::TModalResult m_Button3ModalResult;
	TsuiIconType m_IconType;
	AnsiString m_Text;
	
public:
	__fastcall virtual TsuiMessageDialog(Classes::TComponent* AOwner);
	virtual Controls::TModalResult __fastcall ShowModal(void);
	
__published:
	__property ButtonCursor ;
	__property TsuiDialogButtonsCount ButtonCount = {read=m_ButtonCount, write=m_ButtonCount, nodefault};
	__property AnsiString Button1Caption = {read=m_Button1Caption, write=m_Button1Caption};
	__property AnsiString Button2Caption = {read=m_Button2Caption, write=m_Button2Caption};
	__property AnsiString Button3Caption = {read=m_Button3Caption, write=m_Button3Caption};
	__property Controls::TModalResult Button1ModalResult = {read=m_Button1ModalResult, write=m_Button1ModalResult, nodefault};
	__property Controls::TModalResult Button2ModalResult = {read=m_Button2ModalResult, write=m_Button2ModalResult, nodefault};
	__property Controls::TModalResult Button3ModalResult = {read=m_Button3ModalResult, write=m_Button3ModalResult, nodefault};
	__property TsuiIconType IconType = {read=m_IconType, write=m_IconType, nodefault};
	__property AnsiString Text = {read=m_Text, write=m_Text};
public:
	#pragma option push -w-inl
	/* TsuiDialog.Destroy */ inline __fastcall virtual ~TsuiMessageDialog(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiPasswordDialog;
class PASCALIMPLEMENTATION TsuiPasswordDialog : public TsuiDialog 
{
	typedef TsuiDialog inherited;
	
private:
	AnsiString m_ButtonCancelCaption;
	AnsiString m_ButtonOKCaption;
	AnsiString m_Item1Caption;
	char m_Item1PasswordChar;
	AnsiString m_Item2Caption;
	char m_Item2PasswordChar;
	AnsiString m_Item1Text;
	AnsiString m_Item2Text;
	
public:
	__fastcall virtual TsuiPasswordDialog(Classes::TComponent* AOwner);
	virtual Controls::TModalResult __fastcall ShowModal(void);
	
__published:
	__property AnsiString Item1Caption = {read=m_Item1Caption, write=m_Item1Caption};
	__property AnsiString Item2Caption = {read=m_Item2Caption, write=m_Item2Caption};
	__property char Item1PasswordChar = {read=m_Item1PasswordChar, write=m_Item1PasswordChar, nodefault};
	__property char Item2PasswordChar = {read=m_Item2PasswordChar, write=m_Item2PasswordChar, nodefault};
	__property AnsiString Item1Text = {read=m_Item1Text, write=m_Item1Text};
	__property AnsiString Item2Text = {read=m_Item2Text, write=m_Item2Text};
	__property AnsiString ButtonOKCaption = {read=m_ButtonOKCaption, write=m_ButtonOKCaption};
	__property AnsiString ButtonCancelCaption = {read=m_ButtonCancelCaption, write=m_ButtonCancelCaption};
	__property ButtonCursor ;
public:
	#pragma option push -w-inl
	/* TsuiDialog.Destroy */ inline __fastcall virtual ~TsuiPasswordDialog(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiInputDialog;
class PASCALIMPLEMENTATION TsuiInputDialog : public TsuiDialog 
{
	typedef TsuiDialog inherited;
	
private:
	AnsiString m_ButtonCancelCaption;
	AnsiString m_ButtonOKCaption;
	AnsiString m_PromptText;
	AnsiString m_ValueText;
	char m_PasswordChar;
	
public:
	__fastcall virtual TsuiInputDialog(Classes::TComponent* AOwner);
	virtual Controls::TModalResult __fastcall ShowModal(void);
	
__published:
	__property char PasswordChar = {read=m_PasswordChar, write=m_PasswordChar, nodefault};
	__property AnsiString PromptText = {read=m_PromptText, write=m_PromptText};
	__property AnsiString ValueText = {read=m_ValueText, write=m_ValueText};
	__property AnsiString ButtonOKCaption = {read=m_ButtonOKCaption, write=m_ButtonOKCaption};
	__property AnsiString ButtonCancelCaption = {read=m_ButtonCancelCaption, write=m_ButtonCancelCaption};
	__property ButtonCursor ;
public:
	#pragma option push -w-inl
	/* TsuiDialog.Destroy */ inline __fastcall virtual ~TsuiInputDialog(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE Controls::TModalResult __fastcall SUIMsgDlg(const AnsiString Msg, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, Suithemes::TsuiUIStyle UIStyle = (Suithemes::TsuiUIStyle)(0x3))/* overload */;
extern PACKAGE Controls::TModalResult __fastcall SUIMsgDlg(const AnsiString Msg, const AnsiString Caption, Dialogs::TMsgDlgType DlgType, Dialogs::TMsgDlgButtons Buttons, Suithemes::TsuiUIStyle UIStyle = (Suithemes::TsuiUIStyle)(0x3))/* overload */;

}	/* namespace Suidlg */
using namespace Suidlg;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIDlg
