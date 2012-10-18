// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIColorBox.pas' rev: 5.00

#ifndef SUIColorBoxHPP
#define SUIColorBoxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIComboBox.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Consts.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suicolorbox
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TColorBoxStyles { cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, 
	cbCustomColor, cbPrettyNames };
#pragma option pop

typedef Set<TColorBoxStyles, cbStandardColors, cbPrettyNames>  TColorBoxStyle;

class DELPHICLASS TsuiCustomColorBox;
class PASCALIMPLEMENTATION TsuiCustomColorBox : public Suicombobox::TsuiCustomComboBox 
{
	typedef Suicombobox::TsuiCustomComboBox inherited;
	
private:
	TColorBoxStyle FStyle;
	bool FNeedToPopulate;
	bool FListSelected;
	Graphics::TColor FDefaultColorColor;
	Graphics::TColor FNoneColorColor;
	Graphics::TColor FSelectedColor;
	Graphics::TColor __fastcall GetColor(int Index);
	AnsiString __fastcall GetColorName(int Index);
	Graphics::TColor __fastcall GetSelected(void);
	void __fastcall SetSelected(const Graphics::TColor AColor);
	void __fastcall ColorCallBack(const AnsiString AName);
	void __fastcall SetDefaultColorColor(const Graphics::TColor Value);
	void __fastcall SetNoneColorColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall CloseUp(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const Windows::TRect &Rect, Windows::TOwnerDrawState State
		);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual bool __fastcall PickCustomColor(void);
	void __fastcall PopulateList(void);
	DYNAMIC void __fastcall Change(void);
	HIDESBASE void __fastcall SetStyle(TColorBoxStyle AStyle);
	
public:
	__fastcall virtual TsuiCustomColorBox(Classes::TComponent* AOwner);
	__property TColorBoxStyle Style = {read=FStyle, write=SetStyle, default=7};
	__property Graphics::TColor Colors[int Index] = {read=GetColor};
	__property AnsiString ColorNames[int Index] = {read=GetColorName};
	__property Graphics::TColor Selected = {read=GetSelected, write=SetSelected, default=0};
	__property Graphics::TColor DefaultColorColor = {read=FDefaultColorColor, write=SetDefaultColorColor
		, default=0};
	__property Graphics::TColor NoneColorColor = {read=FNoneColorColor, write=SetNoneColorColor, default=0
		};
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiCustomColorBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomColorBox(HWND ParentWindow) : Suicombobox::TsuiCustomComboBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiColorBox;
class PASCALIMPLEMENTATION TsuiColorBox : public TsuiCustomColorBox 
{
	typedef TsuiCustomColorBox inherited;
	
__published:
	__property DefaultColorColor ;
	__property NoneColorColor ;
	__property Selected ;
	__property Style ;
	__property Anchors ;
	__property BevelEdges ;
	__property BevelInner ;
	__property BevelKind ;
	__property BevelOuter ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property DropDownCount ;
	__property Enabled ;
	__property Font ;
	__property ItemHeight ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDropDown ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TsuiCustomColorBox.Create */ inline __fastcall virtual TsuiColorBox(Classes::TComponent* AOwner)
		 : TsuiCustomColorBox(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiColorBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiColorBox(HWND ParentWindow) : TsuiCustomColorBox(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Shortint ExtendedColorsCount = 0x4;
static const Shortint StandardColorsCount = 0x10;
#define SColorBoxCustomCaption "Custom..."
static const Graphics::TColor NoColorSelected = 0xff000000;

}	/* namespace Suicolorbox */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suicolorbox;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIColorBox
