// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIButton.pas' rev: 5.00

#ifndef SUIButtonHPP
#define SUIButtonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suibutton
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiCustomButton;
class PASCALIMPLEMENTATION TsuiCustomButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool m_AutoSize;
	AnsiString m_Caption;
	bool m_Cancel;
	bool m_Default;
	bool m_Transparent;
	Forms::TModalResult m_ModalResult;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	bool m_BoldFont;
	bool m_PicTransparent;
	Extctrls::TTimer* m_Timer;
	int m_MouseContinuouslyDownInterval;
	int m_FocusedRectMargin;
	bool m_Active;
	Classes::TNotifyEvent m_OnMouseEnter;
	Classes::TNotifyEvent m_OnMouseExit;
	Classes::TNotifyEvent m_OnMouseContinuouslyDown;
	MESSAGE void __fastcall MouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall MouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFONTCHANGED(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Msg);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall SetAutoSize2(const bool Value);
	void __fastcall SetCaption2(const AnsiString Value);
	void __fastcall SetDefault(const bool Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetPicTransparent(const bool Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetTransparent(const bool Value);
	bool __fastcall GetTabStop(void);
	HIDESBASE void __fastcall SetTabStop(bool Value);
	void __fastcall SetFocusedRectMargin(const int Value);
	
protected:
	bool m_MouseIn;
	bool m_MouseDown;
	virtual void __fastcall AutoSizeChanged(void);
	virtual void __fastcall CaptionChanged(void);
	HIDESBASE virtual void __fastcall FontChanged(void);
	virtual void __fastcall TransparentChanged(void);
	virtual void __fastcall EnableChanged(void);
	virtual void __fastcall UIStyleChanged(void);
	virtual void __fastcall PaintPic(Graphics::TCanvas* ACanvas, Graphics::TBitmap* Bitmap);
	virtual void __fastcall PaintText(Graphics::TCanvas* ACanvas, AnsiString Text);
	virtual void __fastcall PaintFocus(Graphics::TCanvas* ACanvas);
	virtual void __fastcall PaintButtonNormal(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseOn(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseDown(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonDisabled(Graphics::TBitmap* Buf);
	void __fastcall PaintButton(int ThemeIndex, int Count, int Index, const Graphics::TBitmap* Buf);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall CreateWnd(void);
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property bool Transparent = {read=m_Transparent, write=SetTransparent, nodefault};
	__property Forms::TModalResult ModalResult = {read=m_ModalResult, write=m_ModalResult, nodefault};
	__property bool PicTransparent = {read=m_PicTransparent, write=SetPicTransparent, nodefault};
	__property int FocusedRectMargin = {read=m_FocusedRectMargin, write=SetFocusedRectMargin, nodefault
		};
	
public:
	__fastcall virtual TsuiCustomButton(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	__property int MouseContinuouslyDownInterval = {read=m_MouseContinuouslyDownInterval, write=m_MouseContinuouslyDownInterval
		, nodefault};
	__property bool Cancel = {read=m_Cancel, write=m_Cancel, default=0};
	__property bool Default = {read=m_Default, write=SetDefault, default=0};
	__property Classes::TNotifyEvent OnMouseEnter = {read=m_OnMouseEnter, write=m_OnMouseEnter};
	__property Classes::TNotifyEvent OnMouseExit = {read=m_OnMouseExit, write=m_OnMouseExit};
	__property Classes::TNotifyEvent OnMouseContinuouslyDown = {read=m_OnMouseContinuouslyDown, write=m_OnMouseContinuouslyDown
		};
	
__published:
	__property BiDiMode ;
	__property Anchors ;
	__property ParentColor ;
	__property Font ;
	__property PopupMenu ;
	__property ShowHint ;
	__property AnsiString Caption = {read=m_Caption, write=SetCaption2, stored=true};
	__property bool AutoSize = {read=m_AutoSize, write=SetAutoSize2, nodefault};
	__property Visible ;
	__property ParentShowHint ;
	__property ParentBiDiMode ;
	__property ParentFont ;
	__property TabStop  = {read=GetTabStop, write=SetTabStop, default=1};
	__property OnEnter ;
	__property OnExit ;
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiCustomButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomButton(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiImageButton;
class PASCALIMPLEMENTATION TsuiImageButton : public TsuiCustomButton 
{
	typedef TsuiCustomButton inherited;
	
private:
	Graphics::TPicture* m_PicNormal;
	Graphics::TPicture* m_PicMouseOn;
	Graphics::TPicture* m_PicMouseDown;
	Graphics::TPicture* m_PicDisabled;
	bool m_Stretch;
	bool m_DrawFocused;
	void __fastcall SetPicDisabledF(const Graphics::TPicture* Value);
	void __fastcall SetPicMouseDownF(const Graphics::TPicture* Value);
	void __fastcall SetPicMouseOnF(const Graphics::TPicture* Value);
	void __fastcall SetPicNormalF(const Graphics::TPicture* Value);
	void __fastcall SetStretch(const bool Value);
	void __fastcall SetDrawFocused(const bool Value);
	Suithemes::TsuiUIStyle __fastcall GetUIStyle2(void);
	
protected:
	virtual void __fastcall AutoSizeChanged(void);
	virtual void __fastcall PaintButtonNormal(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseOn(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseDown(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonDisabled(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintFocus(Graphics::TCanvas* ACanvas);
	virtual void __fastcall PaintPic(Graphics::TCanvas* ACanvas, Graphics::TBitmap* Bitmap);
	
public:
	__fastcall virtual TsuiImageButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiImageButton(void);
	
__published:
	__property UIStyle  = {read=GetUIStyle2};
	__property bool DrawFocused = {read=m_DrawFocused, write=SetDrawFocused, nodefault};
	__property FocusedRectMargin ;
	__property Graphics::TPicture* PicNormal = {read=m_PicNormal, write=SetPicNormalF};
	__property Graphics::TPicture* PicMouseOn = {read=m_PicMouseOn, write=SetPicMouseOnF};
	__property Graphics::TPicture* PicMouseDown = {read=m_PicMouseDown, write=SetPicMouseDownF};
	__property Graphics::TPicture* PicDisabled = {read=m_PicDisabled, write=SetPicDisabledF};
	__property bool Stretch = {read=m_Stretch, write=SetStretch, nodefault};
	__property Cancel ;
	__property Default ;
	__property MouseContinuouslyDownInterval ;
	__property Action ;
	__property Caption ;
	__property Font ;
	__property Enabled ;
	__property TabOrder ;
	__property Transparent ;
	__property ModalResult ;
	__property AutoSize ;
	__property OnClick ;
	__property OnMouseMove ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnMouseEnter ;
	__property OnMouseExit ;
	__property OnMouseContinuouslyDown ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiImageButton(HWND ParentWindow) : TsuiCustomButton(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiControlButton;
class PASCALIMPLEMENTATION TsuiControlButton : public TsuiCustomButton 
{
	typedef TsuiCustomButton inherited;
	
private:
	int m_PicIndex;
	int m_PicCount;
	int m_ThemeID;
	Suimgr::TsuiFileTheme* m_FileTheme;
	void __fastcall SetThemeID(const int Value);
	void __fastcall SetPicIndex(const int Value);
	void __fastcall SetPicCount(const int Value);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall PaintButtonNormal(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseOn(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonMouseDown(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintButtonDisabled(Graphics::TBitmap* Buf);
	virtual void __fastcall PaintPic(Graphics::TCanvas* ACanvas, Graphics::TBitmap* Bitmap);
	
public:
	__fastcall virtual TsuiControlButton(Classes::TComponent* AOwner);
	
__published:
	__property UIStyle ;
	__property FileTheme ;
	__property int ThemeID = {read=m_ThemeID, write=SetThemeID, nodefault};
	__property int PicIndex = {read=m_PicIndex, write=SetPicIndex, nodefault};
	__property int PicCount = {read=m_PicCount, write=SetPicCount, nodefault};
	__property PicTransparent ;
	__property MouseContinuouslyDownInterval ;
	__property Action ;
	__property Caption ;
	__property Font ;
	__property Enabled ;
	__property TabOrder ;
	__property Transparent ;
	__property ModalResult ;
	__property AutoSize ;
	__property OnClick ;
	__property OnMouseMove ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnMouseEnter ;
	__property OnMouseExit ;
	__property OnMouseContinuouslyDown ;
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiControlButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiControlButton(HWND ParentWindow) : TsuiCustomButton(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiToolBarSpeedButton;
class PASCALIMPLEMENTATION TsuiToolBarSpeedButton : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	bool m_MouseIn;
	Graphics::TBitmap* m_Glyph;
	MESSAGE void __fastcall MouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall MouseEnter(Messages::TMessage &Msg);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TsuiToolBarSpeedButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiToolBarSpeedButton(void);
	
__published:
	__property Graphics::TBitmap* Glyph = {read=m_Glyph, write=SetGlyph};
	__property Color ;
	__property OnClick ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiToolBarSpeedButton(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiButton;
class PASCALIMPLEMENTATION TsuiButton : public TsuiCustomButton 
{
	typedef TsuiCustomButton inherited;
	
private:
	Graphics::TBitmap* m_Glyph;
	Buttons::TButtonLayout m_Layout;
	Windows::TPoint m_TextPoint;
	int m_Spacing;
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetLayout(const Buttons::TButtonLayout Value);
	void __fastcall SetSpacing(const int Value);
	unsigned __fastcall GetResHandle(void);
	void __fastcall SetResHandle(const unsigned Value);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall PaintPic(Graphics::TCanvas* ACanvas, Graphics::TBitmap* Bitmap);
	virtual void __fastcall PaintText(Graphics::TCanvas* ACanvas, AnsiString Text);
	virtual void __fastcall PaintFocus(Graphics::TCanvas* ACanvas);
	virtual void __fastcall UIStyleChanged(void);
	
public:
	__fastcall virtual TsuiButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiButton(void);
	
__published:
	__property FileTheme ;
	__property UIStyle ;
	__property Cancel ;
	__property Default ;
	__property Action ;
	__property Caption ;
	__property Font ;
	__property Enabled ;
	__property TabOrder ;
	__property Transparent ;
	__property ModalResult ;
	__property AutoSize ;
	__property FocusedRectMargin ;
	__property Graphics::TBitmap* Glyph = {read=m_Glyph, write=SetGlyph};
	__property Buttons::TButtonLayout Layout = {read=m_Layout, write=SetLayout, nodefault};
	__property int Spacing = {read=m_Spacing, write=SetSpacing, nodefault};
	__property MouseContinuouslyDownInterval ;
	__property OnClick ;
	__property OnMouseMove ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnMouseEnter ;
	__property OnMouseExit ;
	__property OnMouseContinuouslyDown ;
	__property unsigned ResHandle = {read=GetResHandle, write=SetResHandle, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiButton(HWND ParentWindow) : TsuiCustomButton(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiCheckBox;
class PASCALIMPLEMENTATION TsuiCheckBox : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool m_Checked;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	bool m_Transparent;
	bool m_AutoSize;
	Classes::TNotifyEvent m_OnClick;
	Stdctrls::TCheckBoxState __fastcall GetState(void);
	void __fastcall SetState(const Stdctrls::TCheckBoxState Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetAutoSize2(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMFONTCHANGED(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Messages::TWMKey &Msg);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	virtual bool __fastcall NeedDrawFocus(void);
	virtual void __fastcall Paint(void);
	virtual bool __fastcall GetPicTransparent(void);
	virtual int __fastcall GetPicThemeIndex(void);
	virtual void __fastcall CheckStateChanged(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall Toggle(void);
	virtual void __fastcall DoClick(void);
	virtual bool __fastcall WantKeyUp(void);
	virtual void __fastcall SetEnabled(bool Value);
	
public:
	__fastcall virtual TsuiCheckBox(Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property BiDiMode ;
	__property Anchors ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible ;
	__property ParentShowHint ;
	__property ParentBiDiMode ;
	__property ParentFont ;
	__property bool AutoSize = {read=m_AutoSize, write=SetAutoSize2, nodefault};
	__property bool Checked = {read=m_Checked, write=SetChecked, nodefault};
	__property Caption ;
	__property Enabled ;
	__property Font ;
	__property Color ;
	__property TabOrder ;
	__property TabStop ;
	__property ParentColor ;
	__property Stdctrls::TCheckBoxState State = {read=GetState, write=SetState, nodefault};
	__property bool Transparent = {read=m_Transparent, write=SetTransparent, nodefault};
	__property OnClick  = {read=m_OnClick, write=m_OnClick};
	__property OnDblClick ;
	__property OnMouseMove ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnContextPopup ;
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
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiCheckBox(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCheckBox(HWND ParentWindow) : Controls::TCustomControl(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiRadioButton;
class PASCALIMPLEMENTATION TsuiRadioButton : public TsuiCheckBox 
{
	typedef TsuiCheckBox inherited;
	
private:
	int m_GroupIndex;
	void __fastcall UnCheckGroup(void);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	
protected:
	virtual bool __fastcall WantKeyUp(void);
	virtual void __fastcall DoClick(void);
	virtual bool __fastcall GetPicTransparent(void);
	virtual int __fastcall GetPicThemeIndex(void);
	virtual void __fastcall CheckStateChanged(void);
	
public:
	__fastcall virtual TsuiRadioButton(Classes::TComponent* AOwner);
	
__published:
	__property int GroupIndex = {read=m_GroupIndex, write=m_GroupIndex, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiRadioButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiRadioButton(HWND ParentWindow) : TsuiCheckBox(
		ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TsuiArrowButtonType { suiUp, suiDown };
#pragma option pop

class DELPHICLASS TsuiArrowButton;
class PASCALIMPLEMENTATION TsuiArrowButton : public TsuiCustomButton 
{
	typedef TsuiCustomButton inherited;
	
private:
	TsuiArrowButtonType m_Arrow;
	void __fastcall SetArrow(const TsuiArrowButtonType Value);
	
protected:
	virtual void __fastcall UIStyleChanged(void);
	virtual void __fastcall PaintPic(Graphics::TCanvas* ACanvas, Graphics::TBitmap* Bitmap);
	virtual void __fastcall PaintText(Graphics::TCanvas* ACanvas, AnsiString Text);
	
__published:
	__property TsuiArrowButtonType Arrow = {read=m_Arrow, write=SetArrow, nodefault};
	__property FileTheme ;
	__property UIStyle ;
	__property MouseContinuouslyDownInterval ;
	__property OnClick ;
	__property OnMouseMove ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnKeyDown ;
	__property OnKeyUp ;
	__property OnKeyPress ;
	__property OnMouseEnter ;
	__property OnMouseExit ;
	__property OnMouseContinuouslyDown ;
public:
	#pragma option push -w-inl
	/* TsuiCustomButton.Create */ inline __fastcall virtual TsuiArrowButton(Classes::TComponent* AOwner
		) : TsuiCustomButton(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TsuiArrowButton(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiArrowButton(HWND ParentWindow) : TsuiCustomButton(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suibutton */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suibutton;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIButton
