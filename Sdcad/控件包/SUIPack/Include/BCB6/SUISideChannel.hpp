// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUISideChannel.pas' rev: 6.00

#ifndef SUISideChannelHPP
#define SUISideChannelHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suisidechannel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TsuiSideChannelAlign { suiLeft, suiRight };
#pragma option pop

#pragma option push -b-
enum TsuiSideChannelPopupMode { suiMouseOn, suiMouseClick };
#pragma option pop

class DELPHICLASS TsuiSideChannel;
class PASCALIMPLEMENTATION TsuiSideChannel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Buttons::TSpeedButton* m_PinBtn;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TColor m_BorderColor;
	Graphics::TBitmap* m_TitleBitmap;
	Graphics::TBitmap* m_HandleBitmap;
	Graphics::TColor m_SideColor;
	Graphics::TColor m_CaptionFontColor;
	bool m_Poped;
	bool m_ShowButton;
	bool m_FromTheme;
	Extctrls::TTimer* m_Timer;
	int m_nWidth;
	bool m_bMoving;
	TsuiSideChannelAlign m_Align;
	bool m_StayOn;
	TsuiSideChannelPopupMode m_PopupMode;
	bool m_QuickMove;
	Classes::TNotifyEvent m_OnPop;
	Classes::TNotifyEvent m_OnPush;
	Classes::TNotifyEvent m_OnPin;
	Classes::TNotifyEvent m_OnUnPin;
	void __fastcall OnPinClick(System::TObject* Sender);
	void __fastcall OnTimerCheck(System::TObject* Sender);
	HIDESBASE void __fastcall SetWidth(int NewValue);
	void __fastcall SetSideColor(Graphics::TColor NewValue);
	Graphics::TColor __fastcall GetSideColor(void);
	int __fastcall GetSideWidth(void);
	HIDESBASE void __fastcall SetAlign(const TsuiSideChannelAlign Value);
	void __fastcall SetStayOn(const bool Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaptionFontColor(const Graphics::TColor Value);
	void __fastcall SetSideWidth(const int Value);
	void __fastcall SetHandleBitmap(const Graphics::TBitmap* Value);
	void __fastcall SetTitleBitmap(const Graphics::TBitmap* Value);
	void __fastcall SetShowButton(const bool Value);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual bool __fastcall CanResize(int &NewWidth, int &NewHeight);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TsuiSideChannel(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiSideChannel(void);
	void __fastcall Pop(bool bQuick = true);
	void __fastcall Push(bool bQuick = true);
	__property Graphics::TBitmap* HandleImage = {read=m_HandleBitmap, write=SetHandleBitmap};
	__property Graphics::TBitmap* TitleImage = {read=m_TitleBitmap, write=SetTitleBitmap};
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor CaptionFontColor = {read=m_CaptionFontColor, write=SetCaptionFontColor, nodefault};
	__property bool ShowButton = {read=m_ShowButton, write=SetShowButton, nodefault};
	__property bool Popped = {read=m_Poped, nodefault};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property Width  = {read=m_nWidth, write=SetWidth};
	__property Graphics::TColor SideBarColor = {read=GetSideColor, write=SetSideColor, nodefault};
	__property Caption ;
	__property Font ;
	__property Alignment  = {default=2};
	__property TsuiSideChannelAlign Align = {read=m_Align, write=SetAlign, nodefault};
	__property bool StayOn = {read=m_StayOn, write=SetStayOn, nodefault};
	__property Visible  = {default=1};
	__property Color  = {default=-2147483633};
	__property ParentColor  = {default=0};
	__property ParentShowHint  = {default=1};
	__property ParentBiDiMode  = {default=1};
	__property ParentFont  = {default=1};
	__property PopupMenu ;
	__property TsuiSideChannelPopupMode PopupMode = {read=m_PopupMode, write=m_PopupMode, nodefault};
	__property bool QuickMove = {read=m_QuickMove, write=m_QuickMove, nodefault};
	__property OnResize ;
	__property OnCanResize ;
	__property Classes::TNotifyEvent OnPush = {read=m_OnPush, write=m_OnPush};
	__property Classes::TNotifyEvent OnPop = {read=m_OnPop, write=m_OnPop};
	__property Classes::TNotifyEvent OnPin = {read=m_OnPin, write=m_OnPin};
	__property Classes::TNotifyEvent OnUnPin = {read=m_OnUnPin, write=m_OnUnPin};
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property int SideBarWidth = {read=GetSideWidth, write=SetSideWidth, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiSideChannel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suisidechannel */
using namespace Suisidechannel;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUISideChannel
