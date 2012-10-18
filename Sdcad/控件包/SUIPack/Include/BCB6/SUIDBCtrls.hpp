// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIDBCtrls.pas' rev: 6.00

#ifndef SUIDBCtrlsHPP
#define SUIDBCtrlsHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIImagePanel.hpp>	// Pascal unit
#include <SUIGroupBox.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIScrollBar.hpp>	// Pascal unit
#include <SUIRadioGroup.hpp>	// Pascal unit
#include <SUIButton.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suidbctrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiDBEdit;
class PASCALIMPLEMENTATION TsuiDBEdit : public Dbctrls::TDBEdit 
{
	typedef Dbctrls::TDBEdit inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBEdit(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
public:
	#pragma option push -w-inl
	/* TDBEdit.Destroy */ inline __fastcall virtual ~TsuiDBEdit(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBEdit(HWND ParentWindow) : Dbctrls::TDBEdit(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBMemo;
class PASCALIMPLEMENTATION TsuiDBMemo : public Dbctrls::TDBMemo 
{
	typedef Dbctrls::TDBMemo inherited;
	
private:
	Graphics::TColor m_BorderColor;
	bool m_MouseDown;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
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
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	MESSAGE void __fastcall WMClear(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMUndo(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLBUTTONDOWN(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMOUSEWHEEL(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSetText(Messages::TWMSetText &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBMemo(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
public:
	#pragma option push -w-inl
	/* TDBMemo.Destroy */ inline __fastcall virtual ~TsuiDBMemo(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBMemo(HWND ParentWindow) : Dbctrls::TDBMemo(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBImage;
class PASCALIMPLEMENTATION TsuiDBImage : public Dbctrls::TDBImage 
{
	typedef Dbctrls::TDBImage inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBImage(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
public:
	#pragma option push -w-inl
	/* TDBImage.Destroy */ inline __fastcall virtual ~TsuiDBImage(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBImage(HWND ParentWindow) : Dbctrls::TDBImage(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBListBox;
class PASCALIMPLEMENTATION TsuiDBListBox : public Dbctrls::TDBListBox 
{
	typedef Dbctrls::TDBListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
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
	MESSAGE void __fastcall LBADDSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBDELETESTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBINSERTSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBSETCOUNT(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSELCHANGE(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSETFOCUS(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDELETEITEM(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBListBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
public:
	#pragma option push -w-inl
	/* TDBListBox.Destroy */ inline __fastcall virtual ~TsuiDBListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBListBox(HWND ParentWindow) : Dbctrls::TDBListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBComboBox;
class PASCALIMPLEMENTATION TsuiDBComboBox : public Dbctrls::TDBComboBox 
{
	typedef Dbctrls::TDBComboBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_ButtonColor;
	Graphics::TColor m_ArrowColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall DrawButton(void);
	void __fastcall DrawArrow(const Graphics::TCanvas* ACanvas, int X, int Y);
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetButtonColor(const Graphics::TColor Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBComboBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ArrowColor = {read=m_ArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
public:
	#pragma option push -w-inl
	/* TDBComboBox.Destroy */ inline __fastcall virtual ~TsuiDBComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBComboBox(HWND ParentWindow) : Dbctrls::TDBComboBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBCheckBox;
class PASCALIMPLEMENTATION TsuiDBCheckBox : public Suibutton::TsuiCheckBox 
{
	typedef Suibutton::TsuiCheckBox inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString FValueCheck;
	AnsiString FValueUncheck;
	Dbctrls::TPaintControl* FPaintControl;
	void __fastcall DataChange(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	Stdctrls::TCheckBoxState __fastcall GetFieldState(void);
	bool __fastcall GetReadOnly(void);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValueCheck(const AnsiString Value);
	void __fastcall SetValueUncheck(const AnsiString Value);
	void __fastcall UpdateData(System::TObject* Sender);
	bool __fastcall ValueMatch(const AnsiString ValueList, const AnsiString Value);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Toggle(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TsuiDBCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiDBCheckBox(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Checked ;
	__property Db::TField* Field = {read=GetField};
	__property State ;
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property AnsiString ValueChecked = {read=FValueCheck, write=SetValueCheck};
	__property AnsiString ValueUnchecked = {read=FValueUncheck, write=SetValueUncheck};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBCheckBox(HWND ParentWindow) : Suibutton::TsuiCheckBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBRadioGroup;
class PASCALIMPLEMENTATION TsuiDBRadioGroup : public Suiradiogroup::TsuiRadioGroup 
{
	typedef Suiradiogroup::TsuiRadioGroup inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	AnsiString FValue;
	Classes::TStrings* FValues;
	bool FInSetValue;
	Classes::TNotifyEvent FOnChange;
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	AnsiString __fastcall GetDataField();
	Db::TDataSource* __fastcall GetDataSource(void);
	Db::TField* __fastcall GetField(void);
	bool __fastcall GetReadOnly(void);
	AnsiString __fastcall GetButtonValue(int Index);
	void __fastcall SetDataField(const AnsiString Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetValue(const AnsiString Value);
	HIDESBASE void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall SetValues(Classes::TStrings* Value);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall Change(void);
	virtual void __fastcall NewClick(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property Dbctrls::TFieldDataLink* DataLink = {read=FDataLink};
	
public:
	__fastcall virtual TsuiDBRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiDBRadioGroup(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UseRightToLeftAlignment(void);
	__property Db::TField* Field = {read=GetField};
	__property ItemIndex ;
	__property AnsiString Value = {read=FValue, write=SetValue};
	
__published:
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Items  = {write=SetItems};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property Classes::TStrings* Values = {read=FValues, write=SetValues};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TabStop  = {default=0};
	__property TabOrder  = {default=-1};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBRadioGroup(HWND ParentWindow) : Suiradiogroup::TsuiRadioGroup(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBLookupListBox;
class PASCALIMPLEMENTATION TsuiDBLookupListBox : public Dbctrls::TDBLookupListBox 
{
	typedef Dbctrls::TDBLookupListBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiscrollbar::TsuiScrollBar* m_VScrollBar;
	bool m_MouseDown;
	bool m_SelfChanging;
	void __fastcall SetVScrollBar(const Suiscrollbar::TsuiScrollBar* Value);
	void __fastcall OnVScrollBarChange(System::TObject* Sender);
	void __fastcall UpdateScrollBars(void);
	void __fastcall UpdateScrollBarsPos(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOVE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEWHEEL(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLBUTTONDOWN(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall LBADDSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBDELETESTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBINSERTSTRING(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBSETCOUNT(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSELCHANGE(Messages::TMessage &Msg);
	MESSAGE void __fastcall LBNSETFOCUS(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMDELETEITEM(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMMOUSEMOVE(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMVSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMHSCROLL(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBLookupListBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
public:
	#pragma option push -w-inl
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TsuiDBLookupListBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBLookupListBox(HWND ParentWindow) : Dbctrls::TDBLookupListBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBLookupComboBox;
class PASCALIMPLEMENTATION TsuiDBLookupComboBox : public Dbctrls::TDBLookupComboBox 
{
	typedef Dbctrls::TDBLookupComboBox inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_ButtonColor;
	Graphics::TColor m_ArrowColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall DrawButton(void);
	void __fastcall DrawArrow(const Graphics::TCanvas* ACanvas, int X, int Y);
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetButtonColor(const Graphics::TColor Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TsuiDBLookupComboBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ArrowColor = {read=m_ArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
public:
	#pragma option push -w-inl
	/* TDBLookupControl.Destroy */ inline __fastcall virtual ~TsuiDBLookupComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBLookupComboBox(HWND ParentWindow) : Dbctrls::TDBLookupComboBox(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *ENavClick)(System::TObject* Sender, Dbctrls::TNavigateBtn Button);

class DELPHICLASS TsuiDBNavigator;
class DELPHICLASS TsuiNavDataLink;
class PASCALIMPLEMENTATION TsuiNavDataLink : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TsuiDBNavigator* FNavigator;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TsuiNavDataLink(TsuiDBNavigator* ANav);
	__fastcall virtual ~TsuiNavDataLink(void);
};


class DELPHICLASS TsuiNavButton;
class PASCALIMPLEMENTATION TsuiDBNavigator : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Controls::TCursor m_Cursor;
	TsuiNavDataLink* FDataLink;
	Dbctrls::TButtonSet FVisibleButtons;
	Classes::TStrings* FHints;
	Classes::TStrings* FDefHints;
	int ButtonWidth;
	#pragma pack(push, 1)
	Types::TPoint MinBtnSize;
	#pragma pack(pop)
	
	ENavClick FOnNavClick;
	ENavClick FBeforeAction;
	Dbctrls::TNavigateBtn FocusedButton;
	bool FConfirmDelete;
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ClickHandler(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	Classes::TStrings* __fastcall GetHints(void);
	void __fastcall HintsChanged(System::TObject* Sender);
	void __fastcall InitButtons(void);
	void __fastcall InitHints(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetHints(Classes::TStrings* Value);
	void __fastcall SetSize(int &W, int &H);
	HIDESBASE void __fastcall SetVisible(Dbctrls::TButtonSet Value);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	HIDESBASE void __fastcall SetCursor(const Controls::TCursor Value);
	
protected:
	TsuiNavButton* Buttons[10];
	void __fastcall DataChanged(void);
	void __fastcall EditingChanged(void);
	void __fastcall ActiveChanged(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	void __fastcall CalcMinSize(int &W, int &H);
	
public:
	__fastcall virtual TsuiDBNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiDBNavigator(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall BtnClick(Dbctrls::TNavigateBtn Index);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Dbctrls::TButtonSet VisibleButtons = {read=FVisibleButtons, write=SetVisible, default=1023};
	__property Controls::TCursor Cursor = {read=m_Cursor, write=SetCursor, nodefault};
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property Constraints ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property Classes::TStrings* Hints = {read=GetHints, write=SetHints};
	__property ParentCtl3D  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property bool ConfirmDelete = {read=FConfirmDelete, write=FConfirmDelete, default=1};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property ENavClick BeforeAction = {read=FBeforeAction, write=FBeforeAction};
	__property ENavClick OnClick = {read=FOnNavClick, write=FOnNavClick};
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBNavigator(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TsuiNavButton : public Suibutton::TsuiButton 
{
	typedef Suibutton::TsuiButton inherited;
	
private:
	Dbctrls::TNavigateBtn FIndex;
	Dbctrls::TNavButtonStyle FNavStyle;
	Extctrls::TTimer* FRepeatTimer;
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TsuiNavButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiNavButton(void);
	__property Dbctrls::TNavButtonStyle NavStyle = {read=FNavStyle, write=FNavStyle, nodefault};
	__property Dbctrls::TNavigateBtn Index = {read=FIndex, write=FIndex, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiNavButton(HWND ParentWindow) : Suibutton::TsuiButton(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDBGrid;
class PASCALIMPLEMENTATION TsuiDBGrid : public Dbgrids::TDBGrid 
{
	typedef Dbgrids::TDBGrid inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_FocusedColor;
	Graphics::TColor m_SelectedColor;
	Suithemes::TsuiUIStyle m_UIStyle;
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
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetFocusedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetFontColor(void);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetTitleFontColor(void);
	void __fastcall SetTitleFontColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetFixedBGColor(void);
	void __fastcall SetFixedBGColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetBGColor(void);
	void __fastcall SetBGColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, Grids::TGridDrawState AState);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiDBGrid(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor FocusedColor = {read=m_FocusedColor, write=SetFocusedColor, nodefault};
	__property Graphics::TColor SelectedColor = {read=m_SelectedColor, write=SetSelectedColor, nodefault};
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property Graphics::TColor TitleFontColor = {read=GetTitleFontColor, write=SetTitleFontColor, nodefault};
	__property Graphics::TColor FixedBGColor = {read=GetFixedBGColor, write=SetFixedBGColor, nodefault};
	__property Graphics::TColor BGColor = {read=GetBGColor, write=SetBGColor, nodefault};
	__property Suiscrollbar::TsuiScrollBar* VScrollBar = {read=m_VScrollBar, write=SetVScrollBar};
	__property Suiscrollbar::TsuiScrollBar* HScrollBar = {read=m_HScrollBar, write=SetHScrollBar};
public:
	#pragma option push -w-inl
	/* TCustomDBGrid.Destroy */ inline __fastcall virtual ~TsuiDBGrid(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDBGrid(HWND ParentWindow) : Dbgrids::TDBGrid(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _SFirstRecord;
#define Suidbctrls_SFirstRecord System::LoadResourceString(&Suidbctrls::_SFirstRecord)
extern PACKAGE System::ResourceString _SPriorRecord;
#define Suidbctrls_SPriorRecord System::LoadResourceString(&Suidbctrls::_SPriorRecord)
extern PACKAGE System::ResourceString _SNextRecord;
#define Suidbctrls_SNextRecord System::LoadResourceString(&Suidbctrls::_SNextRecord)
extern PACKAGE System::ResourceString _SLastRecord;
#define Suidbctrls_SLastRecord System::LoadResourceString(&Suidbctrls::_SLastRecord)
extern PACKAGE System::ResourceString _SInsertRecord;
#define Suidbctrls_SInsertRecord System::LoadResourceString(&Suidbctrls::_SInsertRecord)
extern PACKAGE System::ResourceString _SDeleteRecord;
#define Suidbctrls_SDeleteRecord System::LoadResourceString(&Suidbctrls::_SDeleteRecord)
extern PACKAGE System::ResourceString _SEditRecord;
#define Suidbctrls_SEditRecord System::LoadResourceString(&Suidbctrls::_SEditRecord)
extern PACKAGE System::ResourceString _SPostEdit;
#define Suidbctrls_SPostEdit System::LoadResourceString(&Suidbctrls::_SPostEdit)
extern PACKAGE System::ResourceString _SCancelEdit;
#define Suidbctrls_SCancelEdit System::LoadResourceString(&Suidbctrls::_SCancelEdit)
extern PACKAGE System::ResourceString _SConfirmCaption;
#define Suidbctrls_SConfirmCaption System::LoadResourceString(&Suidbctrls::_SConfirmCaption)
extern PACKAGE System::ResourceString _SRefreshRecord;
#define Suidbctrls_SRefreshRecord System::LoadResourceString(&Suidbctrls::_SRefreshRecord)
extern PACKAGE System::ResourceString _SDeleteRecordQuestion;
#define Suidbctrls_SDeleteRecordQuestion System::LoadResourceString(&Suidbctrls::_SDeleteRecordQuestion)
extern PACKAGE System::ResourceString _SDeleteMultipleRecordsQuestion;
#define Suidbctrls_SDeleteMultipleRecordsQuestion System::LoadResourceString(&Suidbctrls::_SDeleteMultipleRecordsQuestion)
extern PACKAGE System::ResourceString _SDataSourceFixed;
#define Suidbctrls_SDataSourceFixed System::LoadResourceString(&Suidbctrls::_SDataSourceFixed)
extern PACKAGE System::ResourceString _SNotReplicatable;
#define Suidbctrls_SNotReplicatable System::LoadResourceString(&Suidbctrls::_SNotReplicatable)
extern PACKAGE System::ResourceString _SPropDefByLookup;
#define Suidbctrls_SPropDefByLookup System::LoadResourceString(&Suidbctrls::_SPropDefByLookup)
extern PACKAGE System::ResourceString _STooManyColumns;
#define Suidbctrls_STooManyColumns System::LoadResourceString(&Suidbctrls::_STooManyColumns)
static const Word InitRepeatPause = 0x190;
static const Shortint RepeatPause = 0x64;
static const Shortint SpaceSize = 0x5;

}	/* namespace Suidbctrls */
using namespace Suidbctrls;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIDBCtrls
