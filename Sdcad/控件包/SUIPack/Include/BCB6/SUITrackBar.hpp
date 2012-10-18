// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUITrackBar.pas' rev: 6.00

#ifndef SUITrackBarHPP
#define SUITrackBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIProgressBar.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIImagePanel.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suitrackbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiTrackBar;
class PASCALIMPLEMENTATION TsuiTrackBar : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TPicture* m_BarImage;
	Extctrls::TTimer* m_Timer;
	Suiimagepanel::TsuiImagePanel* m_Slider;
	int m_Min;
	int m_Max;
	int m_Position;
	int m_LastPos;
	Suiprogressbar::TsuiProgressBarOrientation m_Orientation;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suithemes::TsuiUIStyle m_UIStyle;
	bool m_ShowTick;
	bool m_Transparent;
	Classes::TNotifyEvent m_OnChange;
	bool m_CustomPicture;
	int m_LastChange;
	bool m_bSlidingFlag;
	int m_MouseDownPos;
	int m_Frequency;
	void __fastcall SetBarImage(const Graphics::TPicture* Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetOrientation(const Suiprogressbar::TsuiProgressBarOrientation Value);
	Graphics::TPicture* __fastcall GetSliderImage(void);
	virtual void __fastcall SetSliderImage(const Graphics::TPicture* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall UpdateControl(void);
	void __fastcall UpdateSlider(void);
	Types::TPoint __fastcall GetSliderPosFromPosition();
	int __fastcall GetPositionFromFromSliderPos(int X, int Y);
	void __fastcall UpdatePositionValue(int X, int Y, bool Update);
	void __fastcall SetPageSize(const int Value);
	void __fastcall SetLineSize(const int Value);
	void __fastcall SetShowTick(const bool Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetFrequency(const int Value);
	void __fastcall OnSliderMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnSliderMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall SetSize(void);
	void __fastcall PaintTick(const Graphics::TBitmap* Buf);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Msg);
	
protected:
	int m_PageSize;
	int m_LineSize;
	virtual void __fastcall UpdatePicture(void);
	virtual bool __fastcall CustomPicture(void);
	virtual bool __fastcall SUICanFocus(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual bool __fastcall SliderTransparent(void);
	__property int LastChange = {read=m_LastChange, nodefault};
	
public:
	Graphics::TBitmap* m_BarImageBuf;
	__fastcall virtual TsuiTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiTrackBar(void);
	__property bool UseCustomPicture = {read=m_CustomPicture, write=m_CustomPicture, nodefault};
	
__published:
	__property Suiprogressbar::TsuiProgressBarOrientation Orientation = {read=m_Orientation, write=SetOrientation, nodefault};
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TPicture* BarImage = {read=m_BarImage, write=SetBarImage};
	__property Graphics::TPicture* SliderImage = {read=GetSliderImage, write=SetSliderImage};
	__property int Max = {read=m_Max, write=SetMax, nodefault};
	__property int Min = {read=m_Min, write=SetMin, nodefault};
	__property int Position = {read=m_Position, write=SetPosition, nodefault};
	__property int PageSize = {read=m_PageSize, write=SetPageSize, nodefault};
	__property int LineSize = {read=m_LineSize, write=SetLineSize, nodefault};
	__property bool ShowTick = {read=m_ShowTick, write=SetShowTick, nodefault};
	__property bool Transparent = {read=m_Transparent, write=SetTransparent, nodefault};
	__property int Frequency = {read=m_Frequency, write=SetFrequency, nodefault};
	__property Align  = {default=0};
	__property Alignment  = {default=2};
	__property BiDiMode ;
	__property Anchors  = {default=3};
	__property Color  = {default=-2147483633};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property ParentBiDiMode  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property TabStop  = {default=0};
	__property Visible  = {default=1};
	__property Classes::TNotifyEvent OnChange = {read=m_OnChange, write=m_OnChange};
	__property OnCanResize ;
	__property OnClick ;
	__property OnContextPopup ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiTrackBar(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiScrollTrackBar;
class PASCALIMPLEMENTATION TsuiScrollTrackBar : public TsuiTrackBar 
{
	typedef TsuiTrackBar inherited;
	
private:
	bool __fastcall GetSliderVisible(void);
	void __fastcall SetSliderVisible(const bool Value);
	
protected:
	virtual bool __fastcall SliderTransparent(void);
	virtual bool __fastcall CustomPicture(void);
	virtual bool __fastcall SUICanFocus(void);
	
public:
	__fastcall virtual TsuiScrollTrackBar(Classes::TComponent* AOwner);
	void __fastcall UpdateSliderSize(void);
	__property bool SliderVisible = {read=GetSliderVisible, write=SetSliderVisible, nodefault};
	__property LastChange ;
public:
	#pragma option push -w-inl
	/* TsuiTrackBar.Destroy */ inline __fastcall virtual ~TsuiScrollTrackBar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiScrollTrackBar(HWND ParentWindow) : TsuiTrackBar(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suitrackbar */
using namespace Suitrackbar;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUITrackBar
