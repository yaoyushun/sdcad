// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIComboBox.pas' rev: 6.00

#ifndef SUIComboBoxHPP
#define SUIComboBoxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suicombobox
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiCustomComboBox;
class PASCALIMPLEMENTATION TsuiCustomComboBox : public Stdctrls::TCustomComboBox 
{
	typedef Stdctrls::TCustomComboBox inherited;
	
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
	DYNAMIC void __fastcall CloseUp(void);
	
public:
	__fastcall virtual TsuiCustomComboBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ArrowColor = {read=m_ArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiCustomComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomComboBox(HWND ParentWindow) : Stdctrls::TCustomComboBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiComboBox;
class PASCALIMPLEMENTATION TsuiComboBox : public TsuiCustomComboBox 
{
	typedef TsuiCustomComboBox inherited;
	
__published:
	__property AutoComplete  = {default=1};
	__property AutoDropDown  = {default=0};
	__property Style  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property CharCase  = {default=0};
	__property Color  = {default=-2147483643};
	__property Constraints ;
	__property Ctl3D ;
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property DropDownCount  = {default=8};
	__property Enabled  = {default=1};
	__property Font ;
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property ItemHeight ;
	__property ItemIndex  = {default=-1};
	__property MaxLength  = {default=0};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property Sorted  = {default=0};
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Text ;
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawItem ;
	__property OnDropDown ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMeasureItem ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnSelect ;
	__property Items ;
public:
	#pragma option push -w-inl
	/* TsuiCustomComboBox.Create */ inline __fastcall virtual TsuiComboBox(Classes::TComponent* AOwner) : TsuiCustomComboBox(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiComboBox(HWND ParentWindow) : TsuiCustomComboBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDriveComboBox;
class PASCALIMPLEMENTATION TsuiDriveComboBox : public Filectrl::TDriveComboBox 
{
	typedef Filectrl::TDriveComboBox inherited;
	
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
	HIDESBASE bool __fastcall GetDroppedDown(void);
	HIDESBASE void __fastcall SetDroppedDown(const bool Value);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall CloseUp(void);
	
public:
	__fastcall virtual TsuiDriveComboBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ArrowColor = {read=m_ArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
	__property bool DroppedDown = {read=GetDroppedDown, write=SetDroppedDown, nodefault};
public:
	#pragma option push -w-inl
	/* TDriveComboBox.Destroy */ inline __fastcall virtual ~TsuiDriveComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiDriveComboBox(HWND ParentWindow) : Filectrl::TDriveComboBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiFilterComboBox;
class PASCALIMPLEMENTATION TsuiFilterComboBox : public Filectrl::TFilterComboBox 
{
	typedef Filectrl::TFilterComboBox inherited;
	
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
	HIDESBASE bool __fastcall GetDroppedDown(void);
	HIDESBASE void __fastcall SetDroppedDown(const bool Value);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall CloseUp(void);
	
public:
	__fastcall virtual TsuiFilterComboBox(Classes::TComponent* AOwner);
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ArrowColor = {read=m_ArrowColor, write=SetArrowColor, nodefault};
	__property Graphics::TColor ButtonColor = {read=m_ButtonColor, write=SetButtonColor, nodefault};
	__property bool DroppedDown = {read=GetDroppedDown, write=SetDroppedDown, nodefault};
public:
	#pragma option push -w-inl
	/* TFilterComboBox.Destroy */ inline __fastcall virtual ~TsuiFilterComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiFilterComboBox(HWND ParentWindow) : Filectrl::TFilterComboBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suicombobox */
using namespace Suicombobox;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIComboBox
