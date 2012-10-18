// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIRadioGroup.pas' rev: 5.00

#ifndef SUIRadioGroupHPP
#define SUIRadioGroupHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIButton.hpp>	// Pascal unit
#include <SUIGroupBox.hpp>	// Pascal unit
#include <SUIImagePanel.hpp>	// Pascal unit
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

namespace Suiradiogroup
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiCheckGroup;
class PASCALIMPLEMENTATION TsuiCheckGroup : public Suigroupbox::TsuiCustomGroupBox 
{
	typedef Suigroupbox::TsuiCustomGroupBox inherited;
	
private:
	Classes::TStrings* m_Items;
	Classes::TList* m_Buttons;
	int m_Columns;
	int m_TopMargin;
	Controls::TCursor m_Cursor;
	Classes::TNotifyEvent m_OnClick;
	void __fastcall ItemChanged(System::TObject* Sender);
	void __fastcall SetItems(const Classes::TStrings* Value);
	bool __fastcall UpdateButtons(void);
	void __fastcall ArrangeButtons(void);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetTopMargin(const int Value);
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, const bool Value);
	bool __fastcall GetItemEnabled(int Index);
	void __fastcall SetItemEnabled(int Index, const bool Value);
	Graphics::TColor __fastcall GetFontColor(void);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	void __fastcall SetCursor2(const Controls::TCursor Value);
	HIDESBASE MESSAGE void __fastcall CMFONTCHANGED(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	void __fastcall DoClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall NewClick(void);
	virtual Suibutton::TsuiCheckBox* __fastcall CreateAButton(void);
	DYNAMIC void __fastcall ReSize(void);
	virtual void __fastcall SetTransparent(const bool Value);
	virtual void __fastcall FocusUpdate(void);
	
public:
	__fastcall virtual TsuiCheckGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiCheckGroup(void);
	virtual void __fastcall UpdateUIStyle(Suithemes::TsuiUIStyle UIStyle, Suimgr::TsuiFileTheme* FileTheme
		);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ItemEnabled[int Index] = {read=GetItemEnabled, write=SetItemEnabled};
	
__published:
	__property Classes::TStrings* Items = {read=m_Items, write=SetItems};
	__property int Columns = {read=m_Columns, write=SetColumns, nodefault};
	__property int TopMargin = {read=m_TopMargin, write=SetTopMargin, nodefault};
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property BorderColor ;
	__property Cursor  = {read=m_Cursor, write=SetCursor2, default=0};
	__property Classes::TNotifyEvent OnClick = {read=m_OnClick, write=m_OnClick};
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCheckGroup(HWND ParentWindow) : Suigroupbox::TsuiCustomGroupBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiRadioGroup;
class PASCALIMPLEMENTATION TsuiRadioGroup : public TsuiCheckGroup 
{
	typedef TsuiCheckGroup inherited;
	
private:
	void __fastcall SetItemIndex(const int Value);
	int __fastcall GetItemIndex(void);
	
protected:
	virtual Suibutton::TsuiCheckBox* __fastcall CreateAButton(void);
	virtual void __fastcall FocusUpdate(void);
	virtual bool __fastcall CanModify(void);
	
__published:
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
public:
	#pragma option push -w-inl
	/* TsuiCheckGroup.Create */ inline __fastcall virtual TsuiRadioGroup(Classes::TComponent* AOwner) : 
		TsuiCheckGroup(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TsuiCheckGroup.Destroy */ inline __fastcall virtual ~TsuiRadioGroup(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiRadioGroup(HWND ParentWindow) : TsuiCheckGroup(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiCheckGroupButton;
class PASCALIMPLEMENTATION TsuiCheckGroupButton : public Suibutton::TsuiCheckBox 
{
	typedef Suibutton::TsuiCheckBox inherited;
	
private:
	TsuiCheckGroup* m_CheckGroup;
	
protected:
	virtual bool __fastcall NeedDrawFocus(void);
	
public:
	__fastcall TsuiCheckGroupButton(Classes::TComponent* AOwner, TsuiCheckGroup* CheckGroup);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiCheckGroupButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCheckGroupButton(HWND ParentWindow) : Suibutton::TsuiCheckBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiRadioGroupButton;
class PASCALIMPLEMENTATION TsuiRadioGroupButton : public Suibutton::TsuiRadioButton 
{
	typedef Suibutton::TsuiRadioButton inherited;
	
private:
	TsuiRadioGroup* m_RadioGroup;
	
protected:
	virtual bool __fastcall NeedDrawFocus(void);
	virtual void __fastcall DoClick(void);
	
public:
	__fastcall TsuiRadioGroupButton(Classes::TComponent* AOwner, TsuiRadioGroup* RadioGroup);
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiRadioGroupButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiRadioGroupButton(HWND ParentWindow) : Suibutton::TsuiRadioButton(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiradiogroup */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiradiogroup;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIRadioGroup
