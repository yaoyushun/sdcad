// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIProgressBar.pas' rev: 5.00

#ifndef SUIProgressBarHPP
#define SUIProgressBarHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIPublic.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiprogressbar
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TsuiProgressBarOrientation { suiHorizontal, suiVertical };
#pragma option pop

class DELPHICLASS TsuiProgressBar;
class PASCALIMPLEMENTATION TsuiProgressBar : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	int m_Max;
	int m_Min;
	int m_Position;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	TsuiProgressBarOrientation m_Orientation;
	Graphics::TColor m_BorderColor;
	Graphics::TColor m_Color;
	Graphics::TPicture* m_Picture;
	bool m_ShowCaption;
	Graphics::TColor m_CaptionColor;
	bool m_SmartShowCaption;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetOrientation(const TsuiProgressBarOrientation Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetSmartShowCaption(const bool Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall UpdateProgress(void);
	void __fastcall UpdatePicture(void);
	int __fastcall GetWidthFromPosition(int nWidth);
	int __fastcall GetPercentFromPosition(void);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	
public:
	__fastcall virtual TsuiProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiProgressBar(void);
	void __fastcall StepBy(int Delta);
	void __fastcall StepIt(void);
	
__published:
	__property Anchors ;
	__property BiDiMode ;
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor CaptionColor = {read=m_CaptionColor, write=SetCaptionColor, nodefault};
		
	__property bool ShowCaption = {read=m_ShowCaption, write=SetShowCaption, nodefault};
	__property bool SmartShowCaption = {read=m_SmartShowCaption, write=SetSmartShowCaption, nodefault};
		
	__property int Max = {read=m_Max, write=SetMax, nodefault};
	__property int Min = {read=m_Min, write=SetMin, nodefault};
	__property int Position = {read=m_Position, write=SetPosition, nodefault};
	__property TsuiProgressBarOrientation Orientation = {read=m_Orientation, write=SetOrientation, nodefault
		};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor Color = {read=m_Color, write=SetColor, nodefault};
	__property Graphics::TPicture* Picture = {read=m_Picture, write=SetPicture};
	__property Visible ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnClick ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiProgressBar(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiprogressbar */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiprogressbar;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIProgressBar
