// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIFontComboBox.pas' rev: 5.00

#ifndef SUIFontComboBoxHPP
#define SUIFontComboBoxHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIComboBox.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suifontcombobox
{
//-- type declarations -------------------------------------------------------
typedef Stdctrls::TComboBoxStyle TFontDrawComboStyle;

class DELPHICLASS TsuiFontDrawComboBox;
class PASCALIMPLEMENTATION TsuiFontDrawComboBox : public Suicombobox::TsuiCustomComboBox 
{
	typedef Suicombobox::TsuiCustomComboBox inherited;
	
private:
	Stdctrls::TComboBoxStyle FStyle;
	bool FItemHeightChanging;
	void __fastcall SetComboStyle(TFontDrawComboStyle Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMRecreateWnd(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	void __fastcall ResetItemHeight(void);
	virtual int __fastcall MinItemHeight(void);
	__property TFontDrawComboStyle Style = {read=FStyle, write=SetComboStyle, default=2};
	
public:
	__fastcall virtual TsuiFontDrawComboBox(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiFontDrawComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiFontDrawComboBox(HWND ParentWindow) : Suicombobox::TsuiCustomComboBox(
		ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TFontDevice { fdScreen, fdPrinter, fdBoth };
#pragma option pop

#pragma option push -b-
enum TFontListOption { foAnsiOnly, foTrueTypeOnly, foFixedPitchOnly, foNoOEMFonts, foOEMFontsOnly, foScalableOnly, 
	foNoSymbolFonts };
#pragma option pop

typedef Set<TFontListOption, foAnsiOnly, foNoSymbolFonts>  TFontListOptions;

class DELPHICLASS TsuiFontComboBox;
class PASCALIMPLEMENTATION TsuiFontComboBox : public TsuiFontDrawComboBox 
{
	typedef TsuiFontDrawComboBox inherited;
	
private:
	Graphics::TBitmap* FTrueTypeBMP;
	Graphics::TBitmap* FDeviceBMP;
	Classes::TNotifyEvent FOnChange;
	TFontDevice FDevice;
	bool FUpdate;
	bool FUseFonts;
	TFontListOptions FOptions;
	void __fastcall SetFontName(const AnsiString NewFontName);
	AnsiString __fastcall GetFontName();
	void __fastcall SetDevice(TFontDevice Value);
	void __fastcall SetOptions(TFontListOptions Value);
	void __fastcall SetUseFonts(bool Value);
	void __fastcall Reset(void);
	HIDESBASE MESSAGE void __fastcall WMFontChange(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall PopulateList(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall DoChange(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawItem(int Index, const Windows::TRect &Rect, Windows::TOwnerDrawState State
		);
	virtual int __fastcall MinItemHeight(void);
	
public:
	__fastcall virtual TsuiFontComboBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiFontComboBox(void);
	__property Text ;
	
__published:
	__property TFontDevice Device = {read=FDevice, write=SetDevice, default=0};
	__property AnsiString FontName = {read=GetFontName, write=SetFontName};
	__property TFontListOptions Options = {read=FOptions, write=SetOptions, default=0};
	__property bool UseFonts = {read=FUseFonts, write=SetUseFonts, default=0};
	__property ItemHeight ;
	__property Color ;
	__property Ctl3D ;
	__property DragMode ;
	__property DragCursor ;
	__property Enabled ;
	__property Font ;
	__property Anchors ;
	__property BiDiMode ;
	__property Constraints ;
	__property DragKind ;
	__property ParentBiDiMode ;
	__property ImeMode ;
	__property ImeName ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Style ;
	__property TabOrder ;
	__property TabStop ;
	__property Visible ;
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDropDown ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnStartDrag ;
	__property OnContextPopup ;
	__property OnEndDock ;
	__property OnStartDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiFontComboBox(HWND ParentWindow) : TsuiFontDrawComboBox(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiFontSizeComboBox;
class PASCALIMPLEMENTATION TsuiFontSizeComboBox : public Suicombobox::TsuiCustomComboBox 
{
	typedef Suicombobox::TsuiCustomComboBox inherited;
	
private:
	int PixelsPerInch;
	AnsiString FFontName;
	void __fastcall SetFontName(const AnsiString Value);
	void __fastcall Build(void);
	int __fastcall GetFontSize(void);
	void __fastcall SetFontSize(const int Value);
	
public:
	__fastcall virtual TsuiFontSizeComboBox(Classes::TComponent* AOwner);
	
__published:
	__property AnsiString FontName = {read=FFontName, write=SetFontName};
	__property int FontSize = {read=GetFontSize, write=SetFontSize, nodefault};
	__property Color ;
	__property Ctl3D ;
	__property DragMode ;
	__property DragCursor ;
	__property Enabled ;
	__property Font ;
	__property Anchors ;
	__property BiDiMode ;
	__property Constraints ;
	__property DragKind ;
	__property ParentBiDiMode ;
	__property ImeMode ;
	__property ImeName ;
	__property ParentColor ;
	__property ParentCtl3D ;
	__property ParentFont ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Style ;
	__property TabOrder ;
	__property TabStop ;
	__property Text ;
	__property Visible ;
	__property OnChange ;
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDropDown ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnStartDrag ;
	__property OnContextPopup ;
	__property OnEndDock ;
	__property OnStartDock ;
public:
	#pragma option push -w-inl
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TsuiFontSizeComboBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiFontSizeComboBox(HWND ParentWindow) : Suicombobox::TsuiCustomComboBox(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::ResourceString _SResNotFound;
#define Suifontcombobox_SResNotFound System::LoadResourceString(&Suifontcombobox::_SResNotFound)

}	/* namespace Suifontcombobox */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suifontcombobox;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIFontComboBox
