// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUISkinForm.pas' rev: 6.00

#ifndef SUISkinFormHPP
#define SUISkinFormHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiskinform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiSkinForm;
class PASCALIMPLEMENTATION TsuiSkinForm : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Forms::TForm* m_Form;
	Graphics::TBitmap* m_Picture;
	Graphics::TColor m_Color;
	Classes::TNotifyEvent m_OnRegionChanged;
	Classes::TNotifyEvent m_OnPaint;
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetPicture(const Graphics::TBitmap* Value);
	void __fastcall ReSetWndRgn(void);
	MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TsuiSkinForm(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiSkinForm(void);
	__property Canvas ;
	
__published:
	__property Graphics::TBitmap* Glyph = {read=m_Picture, write=SetPicture};
	__property Graphics::TColor TransparentColor = {read=m_Color, write=SetColor, nodefault};
	__property PopupMenu ;
	__property Cursor  = {default=0};
	__property Classes::TNotifyEvent OnRegionChanged = {read=m_OnRegionChanged, write=m_OnRegionChanged};
	__property Classes::TNotifyEvent OnPaint = {read=m_OnPaint, write=m_OnPaint};
	__property OnClick ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnStartDock ;
	__property OnStartDrag ;
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiskinform */
using namespace Suiskinform;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUISkinForm
