// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'SUIThemeFile.pas' rev: 6.00

#ifndef SUIThemeFileHPP
#define SUIThemeFileHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Suithemefile
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsuiThemeFileWriter;
class PASCALIMPLEMENTATION TsuiThemeFileWriter : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	AnsiString m_ThemeFileName;
	Classes::TStrings* m_FileList;
	Classes::TStrings* m_IntegerList;
	Classes::TStrings* m_BooleanList;
	Classes::TStrings* m_StrList;
	void __fastcall Save(void);
	
public:
	__fastcall TsuiThemeFileWriter(AnsiString ThemeFile);
	__fastcall virtual ~TsuiThemeFileWriter(void);
	void __fastcall AddFile(AnsiString Key, AnsiString FileName);
	void __fastcall AddInteger(AnsiString Key, int Value);
	void __fastcall AddBool(AnsiString Key, bool Value);
	void __fastcall AddStr(AnsiString Key, AnsiString Value);
};


class DELPHICLASS TsuiThemeFileReader;
class PASCALIMPLEMENTATION TsuiThemeFileReader : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStrings* m_StreamList;
	Classes::TStrings* m_IntegerList;
	Classes::TStrings* m_BooleanList;
	Classes::TStrings* m_StrList;
	void __fastcall Load(AnsiString ThemeFile);
	
public:
	__fastcall TsuiThemeFileReader(AnsiString ThemeFile);
	__fastcall virtual ~TsuiThemeFileReader(void);
	Classes::TStream* __fastcall GetFile(AnsiString Key);
	int __fastcall GetInteger(AnsiString Key);
	bool __fastcall GetBool(AnsiString Key);
	AnsiString __fastcall GetStr(AnsiString Key);
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool __fastcall IsSUIThemeFile(AnsiString FileName);

}	/* namespace Suithemefile */
using namespace Suithemefile;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SUIThemeFile
