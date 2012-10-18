// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIImagePanel.pas' rev: 5.00

#ifndef SUIImagePanelHPP
#define SUIImagePanelHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <SUIMgr.hpp>	// Pascal unit
#include <SUIThemes.hpp>	// Pascal unit
#include <SUIPublic.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suiimagepanel
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiPanel;
class PASCALIMPLEMENTATION TsuiPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TColor m_BorderColor;
	Suithemes::TsuiUIStyle m_UIStyle;
	Suimgr::TsuiFileTheme* m_FileTheme;
	Graphics::TBitmap* m_TitleBitmap;
	bool m_ShowButton;
	bool m_InButton;
	bool m_Poped;
	Classes::TNotifyEvent m_OnPush;
	Classes::TNotifyEvent m_OnPop;
	int m_Height;
	bool m_Moving;
	bool m_FromTheme;
	Graphics::TColor m_CaptionFontColor;
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetFileTheme(const Suimgr::TsuiFileTheme* Value);
	void __fastcall SetUIStyle(const Suithemes::TsuiUIStyle Value);
	void __fastcall SetShowButton(const bool Value);
	void __fastcall SetHeight2(const int Value);
	void __fastcall SetCaptionFontColor(const Graphics::TColor Value);
	bool __fastcall GetPushed(void);
	void __fastcall PaintButton(void);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Windows::TRect &Rect);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TsuiPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiPanel(void);
	void __fastcall Pop(void);
	void __fastcall Push(void);
	__property bool Pushed = {read=GetPushed, nodefault};
	
__published:
	__property Suimgr::TsuiFileTheme* FileTheme = {read=m_FileTheme, write=SetFileTheme};
	__property Suithemes::TsuiUIStyle UIStyle = {read=m_UIStyle, write=SetUIStyle, nodefault};
	__property Graphics::TColor BorderColor = {read=m_BorderColor, write=SetBorderColor, nodefault};
	__property Font ;
	__property Caption ;
	__property bool ShowButton = {read=m_ShowButton, write=SetShowButton, nodefault};
	__property int Height = {read=m_Height, write=SetHeight2, nodefault};
	__property Graphics::TColor CaptionFontColor = {read=m_CaptionFontColor, write=SetCaptionFontColor, 
		nodefault};
	__property BiDiMode ;
	__property Anchors ;
	__property Align ;
	__property TabStop ;
	__property TabOrder ;
	__property Color ;
	__property Visible ;
	__property PopupMenu ;
	__property Classes::TNotifyEvent OnPush = {read=m_OnPush, write=m_OnPush};
	__property Classes::TNotifyEvent OnPop = {read=m_OnPop, write=m_OnPop};
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiPanel(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TsuiDrawStyle { suiNormal, suiStretch, suiTile };
#pragma option pop

class DELPHICLASS TsuiCustomPanel;
class PASCALIMPLEMENTATION TsuiCustomPanel : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Graphics::TPicture* m_Picture;
	bool m_Transparent;
	bool m_AutoSize;
	int m_CaptionPosX;
	int m_CaptionPosY;
	TsuiDrawStyle m_DrawStyle;
	Windows::TRect m_LastDrawCaptionRect;
	void __fastcall ApplyAutoSize(void);
	void __fastcall ApplyTransparent(void);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	HIDESBASE void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetCaptionPosX(const int Value);
	void __fastcall SetCaptionPosY(const int Value);
	void __fastcall SetDrawStyle(const TsuiDrawStyle Value);
	HIDESBASE MESSAGE void __fastcall CMTEXTCHANGED(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall ClearPanel(void);
	virtual void __fastcall RepaintText(const Windows::TRect &Rect);
	virtual void __fastcall PictureChanged(System::TObject* Sender);
	virtual void __fastcall SetTransparent(const bool Value);
	DYNAMIC void __fastcall Resize(void);
	__property Graphics::TPicture* Picture = {read=m_Picture, write=SetPicture};
	__property bool Transparent = {read=m_Transparent, write=SetTransparent, default=0};
	__property bool AutoSize = {read=m_AutoSize, write=SetAutoSize, nodefault};
	__property int CaptionPosX = {read=m_CaptionPosX, write=SetCaptionPosX, nodefault};
	__property int CaptionPosY = {read=m_CaptionPosY, write=SetCaptionPosY, nodefault};
	__property TsuiDrawStyle DrawStyle = {read=m_DrawStyle, write=SetDrawStyle, nodefault};
	
public:
	__fastcall virtual TsuiCustomPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TsuiCustomPanel(void);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiCustomPanel(HWND ParentWindow) : Extctrls::TCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiImagePanel;
class PASCALIMPLEMENTATION TsuiImagePanel : public TsuiCustomPanel 
{
	typedef TsuiCustomPanel inherited;
	
__published:
	__property BiDiMode ;
	__property BorderWidth ;
	__property Anchors ;
	__property Picture ;
	__property Transparent ;
	__property AutoSize ;
	__property Alignment ;
	__property Align ;
	__property Font ;
	__property TabStop ;
	__property TabOrder ;
	__property Caption ;
	__property Color ;
	__property DrawStyle ;
	__property Visible ;
	__property PopupMenu ;
	__property OnCanResize ;
	__property OnClick ;
	__property OnConstrainedResize ;
	__property OnDockDrop ;
	__property OnDockOver ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetSiteInfo ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnResize ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnUnDock ;
public:
	#pragma option push -w-inl
	/* TsuiCustomPanel.Create */ inline __fastcall virtual TsuiImagePanel(Classes::TComponent* AOwner) : 
		TsuiCustomPanel(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TsuiCustomPanel.Destroy */ inline __fastcall virtual ~TsuiImagePanel(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TsuiImagePanel(HWND ParentWindow) : TsuiCustomPanel(
		ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suiimagepanel */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Suiimagepanel;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIImagePanel
