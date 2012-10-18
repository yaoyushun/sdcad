// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUISkinControl.pas' rev: 6.00

#ifndef SUISkinControlHPP
#define SUISkinControlHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiskincontrol
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiSkinControl;
class PASCALIMPLEMENTATION TsuiSkinControl : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Controls::TWinControl* m_Control;
	Graphics::TBitmap* m_Glyph;
	Graphics::TColor m_Color;
	Classes::TNotifyEvent m_OnRegionChanged;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetControl(const Controls::TWinControl* Value);
	void __fastcall SetPicture(const Graphics::TBitmap* Value);
	void __fastcall ReSetWndRgn(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TsuiSkinControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiSkinControl(void);
	
__published:
	__property Controls::TWinControl* Control = {read=m_Control, write=SetControl};
	__property Graphics::TBitmap* Glyph = {read=m_Glyph, write=SetPicture};
	__property Graphics::TColor TransparentColor = {read=m_Color, write=SetColor, nodefault};
	__property Classes::TNotifyEvent OnRegionChanged = {read=m_OnRegionChanged, write=m_OnRegionChanged};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiskincontrol */
using namespace Suiskincontrol;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUISkinControl
