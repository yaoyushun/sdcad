// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIColorBox.pas' rev: 6.00

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
enum TColorBoxStyles { cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames };
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
	DYNAMIC void __fastcall CloseUp(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	virtual bool __fastcall PickCustomColor(void);
	void __fastcall PopulateList(void);
	DYNAMIC void __fastcall Select(void);
	HIDESBASE void __fastcall SetStyle(TColorBoxStyle AStyle);
	
public:
	__fastcall virtual TsuiCustomColorBox(Classes::TComponent* AOwner);
	__property TColorBoxStyle Style = {read=FStyle, write=SetStyle, default=7};
	__property Graphics::TColor Colors[int Index] = {read=GetColor};
	__property AnsiString ColorNames[int Index] = {read=GetColorName};
	__property Graphics::TColor Selected = {read=GetSelected, write=SetSelected, default=0};
	__property Graphics::TColor DefaultColorColor = {read=FDefaultColorColor, write=SetDefaultColorColor, default=0};
	__property Graphics::TColor NoneColorColor = {read=FNoneColorColor, write=SetNoneColorColor, default=0};
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiCustomColorBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomColorBox(HWND ParentWindow) : Suicombobox::TsuiCustomComboBox(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiColorBox;
class PASCALIMPLEMENTATION TsuiColorBox : public TsuiCustomColorBox 
{
	typedef TsuiCustomColorBox inherited;
	
__published:
	__property AutoComplete  = {default=1};
	__property AutoDropDown  = {default=0};
	__property DefaultColorColor  = {default=0};
	__property NoneColorColor  = {default=0};
	__property Selected  = {default=0};
	__property Style  = {default=7};
	__property Anchors  = {default=3};
	__property BevelEdges  = {default=15};
	__property BevelInner  = {index=0, default=2};
	__property BevelKind  = {default=0};
	__property BevelOuter  = {index=1, default=1};
	__property BiDiMode ;
	__property Color  = {default=-2147483643};
	__property Constraints ;
	__property DropDownCount  = {default=8};
	__property Enabled  = {default=1};
	__property Font ;
	__property ItemHeight ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=1};
	__property Visible  = {default=1};
	__property OnChange ;
	__property OnCloseUp ;
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
	__property OnSelect ;
	__property OnStartDock ;
	__property OnStartDrag ;
public:
	#pragma option push -w-inl
	/* TsuiCustomColorBox.Create */ inline __fastcall virtual TsuiColorBox(Classes::TComponent* AOwner) : TsuiCustomColorBox(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiColorBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiColorBox(HWND ParentWindow) : TsuiCustomColorBox(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Graphics::TColor NoColorSelected = 0xff000000;

}	/* namespace Suicolorbox */
using namespace Suicolorbox;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIColorBox
