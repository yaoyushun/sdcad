// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIEdit.pas' rev: 5.00

#ifndef SUIEditHPP
#define SUIEditHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIButton.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiedit
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiEdit;
class PASCALIMPLEMENTATION TsuiEdit : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall UIStyleChanged(void);
	
public:
	__fastcall virtual TsuiEdit(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Anchors ;
	__property AutoSelect ;
	__property AutoSize ;
	__property BiDiMode ;
	__property CharCase ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HideSelection ;
	__property ImeMode ;
	__property ImeName ;
	__property MaxLength ;
	__property OEMConvert ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PasswordChar ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Text ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiEdit(HWND ParentWindow) : Stdctrls::TCustomEdit(
		ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsuiEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiMaskEdit;
class PASCALIMPLEMENTATION TsuiMaskEdit : public Mask::TCustomMaskEdit 
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE MESSAGE void __fastcall WMPAINT(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEARSEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiMaskEdit(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Anchors ;
	__property AutoSelect ;
	__property AutoSize ;
	__property BiDiMode ;
	__property BorderStyle ;
	__property CharCase ;
	__property Color ;
	__property Constraints ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property EditMask ;
	__property Font ;
	__property ImeMode ;
	__property ImeName ;
	__property MaxLength ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PasswordChar ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Text ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiMaskEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(
		ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsuiMaskEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiNumberEdit;
class PASCALIMPLEMENTATION TsuiNumberEdit : public TsuiEdit 
{
	typedef TsuiEdit inherited;
	
private:
	AnsiString m_Mask;
	double m_Value;
	int m_AutoSelectSigns;
	void __fastcall SetValue(double Value);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall Click(void);
	
public:
	__fastcall virtual TsuiNumberEdit(Classes::TComponent* AOwner);
	
__published:
	__property AnsiString Mask = {read=m_Mask, write=m_Mask};
	__property double Value = {read=m_Value, write=SetValue};
	__property int AutoSelectSigns = {read=m_AutoSelectSigns, write=m_AutoSelectSigns, nodefault};
	__property AutoSelect ;
	__property AutoSize ;
	__property BorderStyle ;
	__property CharCase ;
	__property Color ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragMode ;
	__property Enabled ;
	__property Font ;
	__property HideSelection ;
	__property ImeMode ;
	__property ImeName ;
	__property MaxLength ;
	__property OEMConvert ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PasswordChar ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiNumberEdit(HWND ParentWindow) : TsuiEdit(ParentWindow
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsuiNumberEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiSpinButtons;
class PASCALIMPLEMENTATION TsuiSpinButtons : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
private:
	Suibutton::TsuiArrowButton* m_UpButton;
	Suibutton::TsuiArrowButton* m_DownButton;
	Classes::TNotifyEvent m_OnUpClick;
	Classes::TNotifyEvent m_OnDownClick;
	Suibutton::TsuiArrowButton* __fastcall CreateButton(void);
	void __fastcall BtnClick(System::TObject* Sender);
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	Suimgr::TsuiFileTheme* __fastcall GetFileTheme(void);
	Suithemes::TsuiUIStyle __fastcall GetUIStyle(void);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TsuiSpinButtons(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Classes::TNotifyEvent OnUpClick = {read=m_OnUpClick, write=m_OnUpClick};
	__property Classes::TNotifyEvent OnDownClick = {read=m_OnDownClick, write=m_OnDownClick};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=GetFileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=GetUIStyle, write=SetUIStyle, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiSpinButtons(HWND ParentWindow) : Controls::TWinControl(
		ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TsuiSpinButtons(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiSpinEdit;
class PASCALIMPLEMENTATION TsuiSpinEdit : public TsuiEdit 
{
	typedef TsuiEdit inherited;
	
private:
	int m_MinValue;
	int m_MaxValue;
	int m_Increment;
	TsuiSpinButtons* m_Button;
	bool m_EditorEnabled;
	int __fastcall GetValue(void);
	int __fastcall CheckValue(int NewValue);
	void __fastcall SetValue(int NewValue);
	void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	
protected:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual bool __fastcall IsValidChar(char Key);
	virtual void __fastcall UpClick(System::TObject* Sender);
	virtual void __fastcall DownClick(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall UIStyleChanged(void);
	
public:
	__fastcall virtual TsuiSpinEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiSpinEdit(void);
	__property TsuiSpinButtons* Buttons = {read=m_Button};
	
__published:
	__property Anchors ;
	__property AutoSelect ;
	__property AutoSize ;
	__property Color ;
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor ;
	__property DragMode ;
	__property bool EditorEnabled = {read=m_EditorEnabled, write=m_EditorEnabled, default=1};
	__property Enabled ;
	__property Font ;
	__property int Increment = {read=m_Increment, write=m_Increment, nodefault};
	__property MaxLength ;
	__property int MaxValue = {read=m_MaxValue, write=m_MaxValue, nodefault};
	__property int MinValue = {read=m_MinValue, write=m_MinValue, nodefault};
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ReadOnly ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property int Value = {read=GetValue, write=SetValue, nodefault};
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiSpinEdit(HWND ParentWindow) : TsuiEdit(ParentWindow
		) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiedit */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiedit;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIEdit
