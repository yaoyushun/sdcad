// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIScrollBar.pas' rev: 5.00

#ifndef SUIScrollBarHPP
#define SUIScrollBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIButton.hpp>	// Pascal unit
#include <SUITrackBar.hpp>	// Pascal unit
#include <SUIProgressBar.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiscrollbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiScrollBar;
class PASCALIMPLEMENTATION TsuiScrollBar : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Suitrackbar::TsuiScrollTrackBar* m_TrackBar;
	Suibutton::TsuiImageButton* m_Btn1;
	Suibutton::TsuiImageButton* m_Btn2;
	Graphics::TBitmap* m_SliderLeft;
	Graphics::TBitmap* m_SliderCenter;
	Graphics::TBitmap* m_SliderRight;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Suiprogressbar::TsuiProgressBarOrientation m_Orientation;
	Forms::TScrollBarInc m_SmallChange;
	int m_LineButton;
	void __fastcall SetOrientation(const Suiprogressbar::TsuiProgressBarOrientation Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall PlaceTrackBarAndButton(void);
	void __fastcall UpdatePictures(void);
	void __fastcall UpdateSliderPic(void);
	int __fastcall GetMax(void);
	int __fastcall GetMin(void);
	int __fastcall GetPosition(void);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	Forms::TScrollBarInc __fastcall GetLargeChange(void);
	void __fastcall SetLargeChange(const Forms::TScrollBarInc Value);
	int __fastcall GetPageSize(void);
	void __fastcall SetPageSize(const int Value);
	bool __fastcall GetSliderVisible(void);
	void __fastcall SetSliderVisible(const bool Value);
	Classes::TNotifyEvent __fastcall GetOnChange();
	void __fastcall SetOnChange(const Classes::TNotifyEvent Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall MouseContinuouslyDownDec(System::TObject* Sender);
	void __fastcall MouseContinuouslyDownInc(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	void __fastcall SetLineButton(const int Value);
	int __fastcall GetLastChange(void);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiScrollBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiScrollBar(void);
	__property bool SliderVisible = {read=GetSliderVisible, write=SetSliderVisible, nodefault};
	__property int LastChange = {read=GetLastChange, nodefault};
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property int LineButton = {read=m_LineButton, write=SetLineButton, nodefault};
	__property Suiprogressbar::TsuiProgressBarOrientation Orientation = {read=m_Orientation, write=SetOrientation
		, nodefault};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property int Max = {read=GetMax, write=SetMax, nodefault};
	__property int Min = {read=GetMin, write=SetMin, nodefault};
	__property int Position = {read=GetPosition, write=SetPosition, nodefault};
	__property Forms::TScrollBarInc SmallChange = {read=m_SmallChange, write=m_SmallChange, nodefault};
		
	__property Forms::TScrollBarInc LargeChange = {read=GetLargeChange, write=SetLargeChange, nodefault
		};
	__property int PageSize = {read=GetPageSize, write=SetPageSize, nodefault};
	__property Align ;
	__property Anchors ;
	__property BiDiMode ;
	__property Color ;
	__property Constraints ;
	__property DragCursor ;
	__property DragKind ;
	__property DragMode ;
	__property Enabled ;
	__property ParentBiDiMode ;
	__property ParentColor ;
	__property ParentShowHint ;
	__property PopupMenu ;
	__property ShowHint ;
	__property Visible ;
	__property Classes::TNotifyEvent OnChange = {read=GetOnChange, write=SetOnChange};
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
	/* TWinControl.CreateParented */ inline __fastcall TsuiScrollBar(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiscrollbar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiscrollbar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIScrollBar
