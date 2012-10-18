// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIDsgn.pas' rev: 6.00

#ifndef SUIDsgnHPP
#define SUIDsgnHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <DesignMenus.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <DBGrids.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <FileCtrl.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <CheckLst.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <TypInfo.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suidsgn
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiPageControlEditor;
class PASCALIMPLEMENTATION TsuiPageControlEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall PrepareItem(int Index, const Designmenus::_di_IMenuItem AItem);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiPageControlEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiPageControlEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiTabSheetEditor;
class PASCALIMPLEMENTATION TsuiTabSheetEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
	virtual void __fastcall PrepareItem(int Index, const Designmenus::_di_IMenuItem AItem);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiTabSheetEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiTabSheetEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiDialogEditor;
class PASCALIMPLEMENTATION TsuiDialogEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiDialogEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiDialogEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiThemeManagerEditor;
class PASCALIMPLEMENTATION TsuiThemeManagerEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiThemeManagerEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiThemeManagerEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiThemeMgrCompListEditor;
class PASCALIMPLEMENTATION TsuiThemeMgrCompListEditor : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TsuiThemeMgrCompListEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TsuiThemeMgrCompListEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiConvertor;
class PASCALIMPLEMENTATION TsuiConvertor : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	__fastcall virtual TsuiConvertor(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TsuiConvertor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiUnConvertor;
class PASCALIMPLEMENTATION TsuiUnConvertor : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	__fastcall virtual TsuiUnConvertor(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TsuiUnConvertor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiThemeFileEditor;
class PASCALIMPLEMENTATION TsuiThemeFileEditor : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TsuiThemeFileEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TsuiThemeFileEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiFileThemeEditor;
class PASCALIMPLEMENTATION TsuiFileThemeEditor : public Designeditors::TComponentEditor 
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual void __fastcall ExecuteVerb(int Index);
	virtual AnsiString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiFileThemeEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiFileThemeEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiBuiltInThemeFileEditor;
class PASCALIMPLEMENTATION TsuiBuiltInThemeFileEditor : public Designeditors::TPropertyEditor 
{
	typedef Designeditors::TPropertyEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual AnsiString __fastcall GetValue();
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TsuiBuiltInThemeFileEditor(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TPropertyEditor(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TsuiBuiltInThemeFileEditor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TsuiBuiltInFileThemeEditor;
class PASCALIMPLEMENTATION TsuiBuiltInFileThemeEditor : public TsuiFileThemeEditor 
{
	typedef TsuiFileThemeEditor inherited;
	
public:
	virtual void __fastcall Edit(void);
public:
	#pragma option push -w-inl
	/* TComponentEditor.Create */ inline __fastcall virtual TsuiBuiltInFileThemeEditor(Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : TsuiFileThemeEditor(AComponent, ADesigner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TsuiBuiltInFileThemeEditor(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Suidsgn */
using namespace Suidsgn;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIDsgn
