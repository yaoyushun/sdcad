// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIPublic.pas' rev: 6.00

#ifndef SUIPublicHPP
#define SUIPublicHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suipublic
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#define SUI_ENTER "\r\n"
#define SUI_2ENTER "\r\n\r\n"
extern PACKAGE bool g_SUIPackConverting;
extern PACKAGE void __fastcall DoTrans(Graphics::TCanvas* Canvas, Controls::TWinControl* Control);
extern PACKAGE void __fastcall TileDraw(const Graphics::TCanvas* Canvas, const Graphics::TPicture* Picture, const Types::TRect &Rect);
extern PACKAGE void __fastcall SetWinControlTransparent(Controls::TWinControl* Control);
extern PACKAGE bool __fastcall InRect(const Types::TPoint &Point, const Types::TRect &Rect)/* overload */;
extern PACKAGE bool __fastcall InRect(int X, int Y, const Types::TRect &Rect)/* overload */;
extern PACKAGE Types::TRect __fastcall GetWorkAreaRect();
extern PACKAGE void __fastcall PlaceControl(const Controls::TControl* Control, const Types::TPoint &Position)/* overload */;
extern PACKAGE void __fastcall PlaceControl(const Controls::TControl* Control, const Types::TRect &Rect)/* overload */;
extern PACKAGE void __fastcall SpitDraw(Graphics::TBitmap* Source, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool ATransparent);
extern PACKAGE void __fastcall DrawControlBorder(Controls::TWinControl* WinControl, Graphics::TColor BorderColor, Graphics::TColor Color, bool DrawColor = true);
extern PACKAGE AnsiString __fastcall PCharToStr(char * pstr);
extern PACKAGE void __fastcall SetBitmapWindow(HWND HandleOfWnd, const Graphics::TBitmap* Bitmap, Graphics::TColor TransColor);
extern PACKAGE void __fastcall SpitDrawHorizontal(Graphics::TBitmap* Source, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool ATransparent, bool SampleTopPt = true);
extern PACKAGE void __fastcall RoundPicture(Graphics::TBitmap* SrcBuf);
extern PACKAGE void __fastcall RoundPicture2(Graphics::TBitmap* SrcBuf);
extern PACKAGE void __fastcall RoundPicture3(Graphics::TBitmap* SrcBuf);
extern PACKAGE bool __fastcall IsHasProperty(Classes::TComponent* AComponent, AnsiString ApropertyName);
extern PACKAGE void __fastcall SpitBitmap(Graphics::TBitmap* Source, Graphics::TBitmap* Dest, int Count, int Index);
extern PACKAGE bool __fastcall FormHasFocus(Forms::TCustomForm* Form);
extern PACKAGE void __fastcall ContainerApplyUIStyle(Controls::TWinControl* Container, Suithemes::TsuiUIStyle UIStyle, Suimgr::TsuiFileTheme* FileTheme);
extern PACKAGE bool __stdcall SUIGetScrollBarInfo(unsigned Handle, int idObject, tagSCROLLBARINFO &ScrollInfo);
extern PACKAGE bool __stdcall SUIGetComboBoxInfo(HWND hwndCombo, tagCOMBOBOXINFO &pcbi);
extern PACKAGE bool __stdcall SUIAnimateWindow(HWND hWnd, unsigned dwTime, unsigned dwFlags);
extern PACKAGE bool __fastcall IsWinXP(void);

}	/* namespace Suipublic */
using namespace Suipublic;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIPublic
