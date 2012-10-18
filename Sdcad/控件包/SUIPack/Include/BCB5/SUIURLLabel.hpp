// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIURLLabel.pas' rev: 5.00

#ifndef SUIURLLabelHPP
#define SUIURLLabelHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <ShellAPI.hpp>	// Pascal unit
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

namespace Suiurllabel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiURLLabel;
class PASCALIMPLEMENTATION TsuiURLLabel : public Stdctrls::TCustomLabel 
{
	typedef Stdctrls::TCustomLabel inherited;
	
private:
	Controls::TCursor m_Cursor;
	AnsiString m_URL;
	Graphics::TColor m_HoverColor;
	Graphics::TColor m_LinkColor;
	MESSAGE void __fastcall OnMouseLeave(Messages::TMessage &Msg);
	MESSAGE void __fastcall OnMouseEnter(Messages::TMessage &Msg);
	void __fastcall SetLinkColor(const Graphics::TColor Value);
	void __fastcall SetURL(AnsiString value);
	
protected:
	DYNAMIC void __fastcall Click(void);
	
public:
	__fastcall virtual TsuiURLLabel(Classes::TComponent* AOwner);
	
__published:
	__property Anchors ;
	__property BiDiMode ;
	__property Caption ;
	__property AutoSize ;
	__property Color ;
	__property Enabled ;
	__property ShowHint ;
	__property Transparent ;
	__property Visible ;
	__property WordWrap ;
	__property PopupMenu ;
	__property Cursor  = {read=m_Cursor, default=0};
	__property AnsiString URL = {read=m_URL, write=SetURL};
	__property Graphics::TColor FontHoverColor = {read=m_HoverColor, write=m_HoverColor, nodefault};
	__property Graphics::TColor FontLinkColor = {read=m_LinkColor, write=SetLinkColor, nodefault};
	__property Font ;
	__property OnClick ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TsuiURLLabel(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiurllabel */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiurllabel;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIURLLabel
