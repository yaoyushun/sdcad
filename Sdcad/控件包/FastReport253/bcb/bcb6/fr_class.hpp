// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FR_Class.pas' rev: 5.00

#ifndef FR_ClassHPP
#define FR_ClassHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Db.hpp>	// Pascal unit
#include <FR_DBRel.hpp>	// Pascal unit
#include <FR_DBSet.hpp>	// Pascal unit
#include <FR_DSet.hpp>	// Pascal unit
#include <FR_Intrp.hpp>	// Pascal unit
#include <FR_Pars.hpp>	// Pascal unit
#include <FR_View.hpp>	// Pascal unit
#include <FR_progr.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Printers.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fr_class
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TfrDocMode { dmDesigning, dmPrinting };
#pragma option pop

#pragma option push -b-
enum TfrDrawMode { drAll, drAfterCalcHeight, drPart };
#pragma option pop

#pragma option push -b-
enum TfrBandType { btReportTitle, btReportSummary, btPageHeader, btPageFooter, btMasterHeader, btMasterData, 
	btMasterFooter, btDetailHeader, btDetailData, btDetailFooter, btSubDetailHeader, btSubDetailData, btSubDetailFooter, 
	btOverlay, btColumnHeader, btColumnFooter, btGroupHeader, btGroupFooter, btCrossHeader, btCrossData, 
	btCrossFooter, btChild, btNone };
#pragma option pop

#pragma option push -b-
enum TfrPageType { ptReport, ptDialog };
#pragma option pop

#pragma option push -b-
enum TfrDataSetPosition { psLocal, psGlobal };
#pragma option pop

#pragma option push -b-
enum TfrPageMode { pmNormal, pmBuildList };
#pragma option pop

#pragma option push -b-
enum TfrBandRecType { rtShowBand, rtFirst, rtNext };
#pragma option pop

#pragma option push -b-
enum TfrRgnType { rtNormal, rtExtended };
#pragma option pop

#pragma option push -b-
enum TfrReportType { rtSimple, rtMultiple };
#pragma option pop

#pragma option push -b-
enum TfrDataType { frdtString, frdtInteger, frdtFloat, frdtBoolean, frdtColor, frdtEnum, frdtHasEditor, 
	frdtSize, frdtOneObject };
#pragma option pop

typedef Set<TfrDataType, frdtString, frdtOneObject>  TfrDataTypes;

#pragma option push -b-
enum TfrPrintPages { frAll, frOdd, frEven };
#pragma option pop

typedef void __fastcall (__closure *TDetailEvent)(const AnsiString ParName, Variant &ParValue);

class DELPHICLASS TfrView;
typedef void __fastcall (__closure *TEnterRectEvent)(Classes::TStringList* Memo, TfrView* View);

typedef void __fastcall (__closure *TBeginDocEvent)(void);

typedef void __fastcall (__closure *TEndDocEvent)(void);

typedef void __fastcall (__closure *TBeginPageEvent)(int pgNo);

typedef void __fastcall (__closure *TEndPageEvent)(int pgNo);

class DELPHICLASS TfrBand;
typedef void __fastcall (__closure *TBeginBandEvent)(TfrBand* Band);

typedef void __fastcall (__closure *TEndBandEvent)(TfrBand* Band);

typedef void __fastcall (__closure *TProgressEvent)(int n);

typedef void __fastcall (__closure *TBeginColumnEvent)(TfrBand* Band);

typedef void __fastcall (__closure *TPrintColumnEvent)(int ColNo, int &Width);

class DELPHICLASS TfrPage;
typedef void __fastcall (__closure *TManualBuildEvent)(TfrPage* Page);

typedef void __fastcall (__closure *TObjectClickEvent)(TfrView* View);

typedef void __fastcall (__closure *TMouseOverObjectEvent)(TfrView* View, Controls::TCursor &Cursor)
	;

typedef void __fastcall (__closure *TBeforeExportEvent)(AnsiString &FileName, bool &bContinue);

typedef void __fastcall (__closure *TAfterExportEvent)(const AnsiString FileName);

typedef void __fastcall (__closure *TPrintReportEvent)(void);

typedef void __fastcall (__closure *TLocalizeEvent)(int StringID, AnsiString &ResultString);

#pragma pack(push, 1)
struct TfrHighlightAttr
{
	Word FontStyle;
	Graphics::TColor FontColor;
	Graphics::TColor FillColor;
} ;
#pragma pack(pop)

struct TfrPrnInfo
{
	int PPgw;
	int PPgh;
	int Pgw;
	int Pgh;
	int POfx;
	int POfy;
	int Ofx;
	int Ofy;
	int PPw;
	int PPh;
	int Pw;
	int Ph;
} ;

struct TfrPageInfo;
typedef TfrPageInfo *PfrPageInfo;

#pragma pack(push, 1)
struct TfrPageInfo
{
	Windows::TRect R;
	Word pgSize;
	int pgWidth;
	int pgHeight;
	Printers::TPrinterOrientation pgOr;
	int pgBin;
	bool UseMargins;
	Windows::TRect pgMargins;
	TfrPrnInfo PrnInfo;
	bool Visible;
	Classes::TMemoryStream* Stream;
	TfrPage* Page;
} ;
#pragma pack(pop)

struct TfrBandRec;
typedef TfrBandRec *PfrBandRec;

#pragma pack(push, 1)
struct TfrBandRec
{
	TfrBand* Band;
	TfrBandRecType Action;
} ;
#pragma pack(pop)

struct TfrPropRec;
typedef TfrPropRec *PfrPropRec;

struct TfrPropRec
{
	System::SmallString<32>  PropName;
	TfrDataTypes PropType;
	Classes::TStringList* Enum;
	Variant EnumValues;
	Classes::TNotifyEvent PropEditor;
} ;

class DELPHICLASS TfrObject;
class PASCALIMPLEMENTATION TfrObject : public System::TObject 
{
	typedef System::TObject inherited;
	
protected:
	Classes::TList* PropList;
	void __fastcall ClearPropList(void);
	void __fastcall AddProperty(AnsiString PropName, TfrDataTypes PropType, Classes::TNotifyEvent PropEditor
		);
	void __fastcall AddEnumProperty(AnsiString PropName, AnsiString Enum, const Variant * EnumValues, const 
		int EnumValues_Size);
	void __fastcall DelProperty(AnsiString PropName);
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	PfrPropRec __fastcall GetPropRec(AnsiString Index);
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	void __fastcall SetFontProp(Graphics::TFont* Font, AnsiString Prop, const Variant &Value);
	Variant __fastcall GetFontProp(Graphics::TFont* Font, AnsiString Prop);
	Variant __fastcall LinesMethod(Classes::TStrings* Lines, AnsiString MethodName, AnsiString LinesName
		, const Variant &Par1, const Variant &Par2, const Variant &Par3);
	
public:
	__fastcall TfrObject(void);
	__fastcall virtual ~TfrObject(void);
	virtual void __fastcall DefineProperties(void);
	__property Variant Prop[AnsiString Index] = {read=GetPropValue, write=SetPropValue};
	__property PfrPropRec PropRec[AnsiString Index] = {read=GetPropRec};
};


#pragma option push -b-
enum FR_Class__3 { smFRF, smFRP };
#pragma option pop

class PASCALIMPLEMENTATION TfrView : public TfrObject 
{
	typedef TfrObject inherited;
	
private:
	bool Flag1;
	int olddy;
	void __fastcall P1Click(System::TObject* Sender);
	
protected:
	int SaveX;
	int SaveY;
	int SaveDX;
	int SaveDY;
	int SaveGX;
	int SaveGY;
	float SaveFW;
	AnsiString BaseName;
	Graphics::TCanvas* Canvas;
	Windows::TRect DRect;
	Classes::TStringList* Memo1;
	Fr_dbrel::TfrTDataSet* FDataSet;
	AnsiString FField;
	FR_Class__3 StreamMode;
	virtual void __fastcall ShowBackground(void);
	virtual void __fastcall ShowFrame(void);
	void __fastcall BeginDraw(Graphics::TCanvas* ACanvas);
	virtual void __fastcall GetBlob(Fr_dbrel::TfrTField* b);
	virtual void __fastcall OnHook(TfrView* View);
	void __fastcall ExpandVariables(AnsiString &s);
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	virtual void __fastcall Loaded(void);
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	TfrView* __fastcall ParentBand(void);
	
public:
	AnsiString Name;
	Byte Typ;
	Byte HVersion;
	Byte LVersion;
	int ID;
	bool Selected;
	Windows::TRect OriginalRect;
	double ScaleX;
	double ScaleY;
	int OffsX;
	int OffsY;
	bool IsPrinting;
	int x;
	int y;
	int dx;
	int dy;
	Word Flags;
	Word FrameTyp;
	float FrameWidth;
	Graphics::TColor FrameColor;
	Word FrameStyle;
	Graphics::TColor FillColor;
	int Format;
	AnsiString FormatStr;
	Word Visible;
	int gapx;
	int gapy;
	Word Restrictions;
	AnsiString Tag;
	Classes::TStringList* Memo;
	Classes::TStringList* Script;
	Byte BandAlign;
	TfrBand* Parent;
	TfrPage* ParentPage;
	__fastcall virtual TfrView(void);
	__fastcall virtual ~TfrView(void);
	void __fastcall Assign(TfrView* From);
	virtual void __fastcall CalcGaps(void);
	virtual void __fastcall RestoreCoord(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas) = 0 ;
	virtual void __fastcall StreamOut(Classes::TStream* Stream);
	virtual void __fastcall ExportData(void);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
	virtual void __fastcall Resized(void);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
	virtual HRGN __fastcall GetClipRgn(TfrRgnType rt);
	void __fastcall CreateUniqueName(void);
	void __fastcall SetBounds(int Left, int Top, int Width, int Height);
	virtual void __fastcall DefineProperties(void);
	virtual void __fastcall ShowEditor(void);
};


class DELPHICLASS TfrControl;
class PASCALIMPLEMENTATION TfrControl : public TfrView 
{
	typedef TfrView inherited;
	
protected:
	Controls::TControl* FControl;
	virtual void __fastcall PaintDesignControl(void);
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	
public:
	__fastcall virtual TfrControl(void);
	__fastcall virtual ~TfrControl(void);
	virtual void __fastcall DefineProperties(void);
	void __fastcall PlaceControl(Forms::TForm* Form);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
	__property Controls::TControl* Control = {read=FControl};
};


class DELPHICLASS TfrNonVisualControl;
class PASCALIMPLEMENTATION TfrNonVisualControl : public TfrControl 
{
	typedef TfrControl inherited;
	
protected:
	Graphics::TBitmap* Bmp;
	Classes::TComponent* Component;
	Fr_pars::TfrVariables* FFixupList;
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual void __fastcall PaintDesignControl(void);
	
public:
	__fastcall virtual TfrNonVisualControl(void);
	__fastcall virtual ~TfrNonVisualControl(void);
	virtual void __fastcall DefineProperties(void);
	HIDESBASE void __fastcall PlaceControl(Forms::TForm* Form);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
};


class DELPHICLASS TfrStretcheable;
class PASCALIMPLEMENTATION TfrStretcheable : public TfrView 
{
	typedef TfrView inherited;
	
protected:
	TfrDrawMode DrawMode;
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	virtual int __fastcall CalcHeight(void) = 0 ;
	virtual int __fastcall MinHeight(void) = 0 ;
	virtual int __fastcall LostSpace(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TfrView.Create */ inline __fastcall virtual TfrStretcheable(void) : TfrView() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TfrView.Destroy */ inline __fastcall virtual ~TfrStretcheable(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrMemoView;
class PASCALIMPLEMENTATION TfrMemoView : public TfrStretcheable 
{
	typedef TfrStretcheable inherited;
	
private:
	Graphics::TFont* FFont;
	AnsiString LastValue;
	bool FWrapped;
	int VHeight;
	HIDESBASE void __fastcall P1Click(System::TObject* Sender);
	void __fastcall P2Click(System::TObject* Sender);
	void __fastcall P3Click(System::TObject* Sender);
	void __fastcall P5Click(System::TObject* Sender);
	void __fastcall P6Click(System::TObject* Sender);
	void __fastcall P8Click(System::TObject* Sender);
	void __fastcall P9Click(System::TObject* Sender);
	void __fastcall P10Click(System::TObject* Sender);
	void __fastcall P11Click(System::TObject* Sender);
	void __fastcall SetFont(Graphics::TFont* Value);
	
protected:
	bool Streaming;
	int TextHeight;
	int CurStrNo;
	bool Exporting;
	void __fastcall ExpandMemoVariables(void);
	void __fastcall AssignFont(Graphics::TCanvas* Canvas);
	void __fastcall WrapMemo(void);
	void __fastcall ShowMemo(void);
	void __fastcall ShowUnderLines(void);
	int __fastcall CalcWidth(Classes::TStringList* Memo);
	virtual int __fastcall CalcHeight(void);
	virtual int __fastcall MinHeight(void);
	virtual int __fastcall LostSpace(void);
	virtual void __fastcall GetBlob(Fr_dbrel::TfrTField* b);
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	
public:
	int Alignment;
	#pragma pack(push, 1)
	TfrHighlightAttr Highlight;
	#pragma pack(pop)
	
	AnsiString HighlightStr;
	int LineSpacing;
	int CharacterSpacing;
	__fastcall virtual TfrMemoView(void);
	__fastcall virtual ~TfrMemoView(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall StreamOut(Classes::TStream* Stream);
	virtual void __fastcall ExportData(void);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
	virtual void __fastcall DefineProperties(void);
	virtual void __fastcall ShowEditor(void);
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TfrBandView;
class PASCALIMPLEMENTATION TfrBandView : public TfrView 
{
	typedef TfrView inherited;
	
private:
	HIDESBASE void __fastcall P1Click(System::TObject* Sender);
	void __fastcall P2Click(System::TObject* Sender);
	void __fastcall P3Click(System::TObject* Sender);
	void __fastcall P4Click(System::TObject* Sender);
	void __fastcall P5Click(System::TObject* Sender);
	void __fastcall P6Click(System::TObject* Sender);
	void __fastcall P7Click(System::TObject* Sender);
	TfrBandType __fastcall GetBandType(void);
	void __fastcall SetBandType(const TfrBandType Value);
	int __fastcall GetRectangleWidth(void);
	
protected:
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	
public:
	AnsiString ChildBand;
	AnsiString Master;
	int Columns;
	int ColumnWidth;
	int ColumnGap;
	int NewColumnAfter;
	__fastcall virtual TfrBandView(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
	virtual void __fastcall DefineProperties(void);
	virtual HRGN __fastcall GetClipRgn(TfrRgnType rt);
	__property TfrBandType BandType = {read=GetBandType, write=SetBandType, nodefault};
	__property AnsiString DataSet = {read=FormatStr, write=FormatStr};
	__property AnsiString GroupCondition = {read=FormatStr, write=FormatStr};
public:
	#pragma option push -w-inl
	/* TfrView.Destroy */ inline __fastcall virtual ~TfrBandView(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrSubReportView;
class PASCALIMPLEMENTATION TfrSubReportView : public TfrView 
{
	typedef TfrView inherited;
	
public:
	int SubPage;
	__fastcall virtual TfrSubReportView(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
public:
	#pragma option push -w-inl
	/* TfrView.Destroy */ inline __fastcall virtual ~TfrSubReportView(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrPictureView;
class PASCALIMPLEMENTATION TfrPictureView : public TfrView 
{
	typedef TfrView inherited;
	
private:
	HIDESBASE void __fastcall P1Click(System::TObject* Sender);
	void __fastcall P2Click(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	virtual Variant __fastcall DoMethod(AnsiString MethodName, const Variant &Par1, const Variant &Par2
		, const Variant &Par3);
	virtual void __fastcall GetBlob(Fr_dbrel::TfrTField* b);
	
public:
	Graphics::TPicture* Picture;
	Byte BlobType;
	__fastcall virtual TfrPictureView(void);
	__fastcall virtual ~TfrPictureView(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToStream(Classes::TStream* Stream);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
	virtual void __fastcall DefinePopupMenu(Menus::TPopupMenu* Popup);
	virtual void __fastcall DefineProperties(void);
	virtual void __fastcall ShowEditor(void);
};


class DELPHICLASS TfrLineView;
class PASCALIMPLEMENTATION TfrLineView : public TfrStretcheable 
{
	typedef TfrStretcheable inherited;
	
public:
	__fastcall virtual TfrLineView(void);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas);
	virtual int __fastcall CalcHeight(void);
	virtual int __fastcall MinHeight(void);
	virtual int __fastcall LostSpace(void);
	virtual HRGN __fastcall GetClipRgn(TfrRgnType rt);
	virtual void __fastcall DefineProperties(void);
	virtual void __fastcall SaveToFR3Stream(Classes::TStream* Stream);
public:
	#pragma option push -w-inl
	/* TfrView.Destroy */ inline __fastcall virtual ~TfrLineView(void) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TfrBand : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TfrPage* Parent;
	TfrBandView* View;
	Word Flags;
	TfrBand* Next;
	TfrBand* Prev;
	TfrBand* NextGroup;
	TfrBand* PrevGroup;
	TfrBand* FirstGroup;
	TfrBand* LastGroup;
	TfrBand* Child;
	TfrBand* AggrBand;
	int SubIndex;
	int MaxY;
	bool EOFReached;
	bool EOFArr[63];
	int Positions[2];
	Variant LastGroupValue;
	TfrBand* HeaderBand;
	TfrBand* FooterBand;
	TfrBand* DataBand;
	TfrBand* LastBand;
	Fr_pars::TfrVariables* Values;
	int Count;
	bool DisableInit;
	int CalculatedHeight;
	int CurColumn;
	int SaveXAdjust;
	bool SaveCurY;
	int MaxColumns;
	bool DisableBandScript;
	void __fastcall InitDataSet(AnsiString Desc);
	void __fastcall FreeDataSet(void);
	int __fastcall CalcHeight(void);
	void __fastcall StretchObjects(int MaxHeight);
	void __fastcall UnStretchObjects(void);
	void __fastcall DrawObject(TfrView* t);
	void __fastcall PrepareSubReports(void);
	void __fastcall DoSubReports(void);
	bool __fastcall DrawObjects(void);
	void __fastcall DrawCrossCell(TfrBand* Parnt, int CurX);
	void __fastcall DrawCross(void);
	bool __fastcall CheckPageBreak(int y, int dy, bool PBreak);
	void __fastcall DrawPageBreak(void);
	bool __fastcall HasCross(void);
	int __fastcall DoCalcHeight(void);
	void __fastcall DoDraw(void);
	bool __fastcall Draw(void);
	void __fastcall InitValues(void);
	void __fastcall DoAggregate(void);
	AnsiString __fastcall ExtractField(const AnsiString s, int FieldNo);
	void __fastcall AddAggregateValue(AnsiString s, const Variant &v);
	Variant __fastcall GetAggregateValue(AnsiString s);
	
public:
	int x;
	int y;
	int dx;
	int dy;
	int maxdy;
	TfrBandType Typ;
	AnsiString Name;
	bool PrintIfSubsetEmpty;
	bool NewPageAfter;
	bool Stretched;
	bool PageBreak;
	bool PrintChildIfInvisible;
	bool Visible;
	Classes::TList* Objects;
	Classes::TStringList* Memo;
	Classes::TStringList* Script;
	Fr_dset::TfrDataset* DataSet;
	bool IsVirtualDS;
	Fr_dset::TfrDataset* VCDataSet;
	bool IsVirtualVCDS;
	AnsiString GroupCondition;
	int CallNewPage;
	int CallNewColumn;
	__fastcall TfrBand(TfrBandType ATyp, TfrPage* AParent);
	__fastcall virtual ~TfrBand(void);
};


class PASCALIMPLEMENTATION TfrPage : public TfrObject 
{
	typedef TfrObject inherited;
	
private:
	TfrBand* Bands[23];
	bool Skip;
	bool InitFlag;
	int CurColumn;
	int LastStaticColumnY;
	int XAdjust;
	Classes::TList* List;
	TfrPageMode Mode;
	int PlayFrom;
	TfrBand* LastBand;
	int ColPos;
	int CurPos;
	TfrBand* WasBand;
	bool DisableRepeatHeader;
	void __fastcall InitPage(void);
	void __fastcall DonePage(void);
	void __fastcall TossObjects(void);
	void __fastcall PrepareObjects(void);
	void __fastcall FormPage(void);
	void __fastcall AddRecord(TfrBand* b, TfrBandRecType rt);
	void __fastcall ClearRecList(void);
	bool __fastcall PlayRecList(void);
	void __fastcall DrawPageFooters(void);
	bool __fastcall BandExists(TfrBand* b);
	void __fastcall AfterPrint(void);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall ShowBand(TfrBand* b);
	int __fastcall LeftOffset(void);
	void __fastcall DoScript(Classes::TStrings* Script);
	void __fastcall DialogFormActivate(System::TObject* Sender);
	void __fastcall ResetPosition(TfrBand* b, int ResetTo);
	
protected:
	virtual void __fastcall SetPropValue(AnsiString Index, const Variant &Value);
	virtual Variant __fastcall GetPropValue(AnsiString Index);
	
public:
	int pgSize;
	int pgWidth;
	int pgHeight;
	Windows::TRect pgMargins;
	Printers::TPrinterOrientation pgOr;
	int pgBin;
	Word PrintToPrevPage;
	Word UseMargins;
	TfrPrnInfo PrnInfo;
	int ColCount;
	int ColWidth;
	int ColGap;
	TfrPageType PageType;
	Classes::TList* Objects;
	int CurY;
	int CurBottomY;
	AnsiString Name;
	Byte BorderStyle;
	AnsiString Caption;
	Graphics::TColor Color;
	int Left;
	int Top;
	int Width;
	int Height;
	Byte Position;
	Forms::TForm* Form;
	Classes::TStringList* Script;
	bool Visible;
	int PageNumber;
	__fastcall virtual TfrPage(int ASize, int AWidth, int AHeight, int ABin, Printers::TPrinterOrientation 
		AOr);
	__fastcall virtual ~TfrPage(void);
	virtual void __fastcall DefineProperties(void);
	void __fastcall CreateUniqueName(void);
	int __fastcall TopMargin(void);
	int __fastcall BottomMargin(void);
	int __fastcall LeftMargin(void);
	int __fastcall RightMargin(void);
	void __fastcall Clear(void);
	void __fastcall Delete(int Index);
	int __fastcall FindObjectByID(int ID);
	TfrView* __fastcall FindObject(AnsiString Name);
	void __fastcall ChangePaper(int ASize, int AWidth, int AHeight, int ABin, Printers::TPrinterOrientation 
		AOr);
	void __fastcall ShowBandByName(AnsiString s);
	void __fastcall ShowBandByType(TfrBandType bt);
	void __fastcall NewPage(void);
	void __fastcall NewColumn(TfrBand* Band);
	void __fastcall ScriptEditor(System::TObject* Sender);
};


class DELPHICLASS TfrPages;
class DELPHICLASS TfrReport;
class DELPHICLASS TfrEMFPages;
class PASCALIMPLEMENTATION TfrEMFPages : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FPages;
	TfrReport* Parent;
	int __fastcall GetCount(void);
	PfrPageInfo __fastcall GetPages(int Index);
	void __fastcall ExportData(int Index);
	
public:
	__fastcall TfrEMFPages(TfrReport* AParent);
	__fastcall virtual ~TfrEMFPages(void);
	void __fastcall Clear(void);
	void __fastcall Draw(int Index, Graphics::TCanvas* Canvas, const Windows::TRect &DrawRect);
	void __fastcall Add(TfrPage* APage);
	void __fastcall AddFrom(TfrReport* Report);
	void __fastcall Insert(int Index, TfrPage* APage);
	void __fastcall Delete(int Index);
	void __fastcall LoadFromStream(Classes::TStream* AStream);
	void __fastcall SaveToStream(Classes::TStream* AStream);
	bool __fastcall DoClick(int Index, const Windows::TPoint &pt, bool Click, Controls::TCursor &Cursor
		, AnsiString &mess);
	__property PfrPageInfo Pages[int Index] = {read=GetPages/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	__property Classes::TList* List = {read=FPages, write=FPages};
	void __fastcall PageToObjects(int Index);
	void __fastcall ObjectsToPage(int Index);
};


class DELPHICLASS TfrDataDictionary;
class PASCALIMPLEMENTATION TfrDataDictionary : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStringList* Cache;
	Variant __fastcall GetValue(AnsiString VarName);
	AnsiString __fastcall GetRealFieldName(AnsiString ItemName);
	AnsiString __fastcall GetRealDataSetName(AnsiString ItemName);
	AnsiString __fastcall GetRealDataSourceName(AnsiString ItemName);
	AnsiString __fastcall GetAliasName(AnsiString ItemName);
	void __fastcall AddCacheItem(AnsiString VarName, Fr_dbrel::TfrTDataSet* DataSet, AnsiString DataField
		);
	void __fastcall ClearCache(void);
	
public:
	Fr_pars::TfrVariables* Variables;
	Fr_pars::TfrVariables* FieldAliases;
	Fr_pars::TfrVariables* BandDatasources;
	Classes::TStringList* DisabledDatasets;
	__fastcall TfrDataDictionary(void);
	__fastcall virtual ~TfrDataDictionary(void);
	void __fastcall Clear(void);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	void __fastcall LoadFromFile(AnsiString FName);
	void __fastcall SaveToFile(AnsiString FName);
	void __fastcall ExtractFieldName(AnsiString ComplexName, AnsiString &DSName, AnsiString &FieldName)
		;
	bool __fastcall IsVariable(AnsiString VarName);
	bool __fastcall DatasetEnabled(AnsiString DatasetName);
	void __fastcall GetDatasetList(Classes::TStrings* List);
	void __fastcall GetFieldList(AnsiString DSName, Classes::TStrings* List);
	void __fastcall GetBandDatasourceList(Classes::TStrings* List);
	void __fastcall GetCategoryList(Classes::TStrings* List);
	void __fastcall GetVariablesList(AnsiString Category, Classes::TStrings* List);
	__property Variant Value[AnsiString Index] = {read=GetValue};
	__property AnsiString RealDataSetName[AnsiString Index] = {read=GetRealDataSetName};
	__property AnsiString RealDataSourceName[AnsiString Index] = {read=GetRealDataSourceName};
	__property AnsiString RealFieldName[AnsiString Index] = {read=GetRealFieldName};
	__property AnsiString AliasName[AnsiString Index] = {read=GetAliasName};
};


class DELPHICLASS TfrExportFilter;
class PASCALIMPLEMENTATION TfrExportFilter : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	AnsiString FileName;
	Classes::TStream* Stream;
	Classes::TList* Lines;
	bool FShowDialog;
	bool FDefault;
	TBeforeExportEvent FOnBeforeExport;
	TAfterExportEvent FOnAfterExport;
	virtual void __fastcall ClearLines(void);
	
public:
	__fastcall virtual TfrExportFilter(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrExportFilter(void);
	virtual Word __fastcall ShowModal(void);
	virtual void __fastcall OnBeginDoc(void);
	virtual void __fastcall OnEndDoc(void);
	virtual void __fastcall OnBeginPage(void);
	virtual void __fastcall OnEndPage(void);
	virtual void __fastcall OnData(int x, int y, TfrView* View);
	virtual void __fastcall OnText(const Windows::TRect &DrawRect, int x, int y, const AnsiString text, 
		int FrameTyp, TfrView* View);
	
__published:
	__property bool Default = {read=FDefault, write=FDefault, default=0};
	__property bool ShowDialog = {read=FShowDialog, write=FShowDialog, default=1};
	__property TBeforeExportEvent OnBeforeExport = {read=FOnBeforeExport, write=FOnBeforeExport};
	__property TAfterExportEvent OnAfterExport = {read=FOnAfterExport, write=FOnAfterExport};
};


class PASCALIMPLEMENTATION TfrReport : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TfrPages* FPages;
	TfrEMFPages* FEMFPages;
	TfrDataDictionary* FDictionary;
	Fr_dset::TfrDataset* FDataset;
	bool FGrayedButtons;
	TfrReportType FReportType;
	AnsiString FTitle;
	bool FShowProgress;
	bool FModalPreview;
	bool FModifyPrepared;
	bool FStoreInDFM;
	Fr_view::TfrPreview* FPreview;
	Fr_view::TfrPreviewButtons FPreviewButtons;
	Fr_view::TfrPreviewZoom FInitialZoom;
	TBeginDocEvent FOnBeginDoc;
	TEndDocEvent FOnEndDoc;
	TBeginPageEvent FOnBeginPage;
	TEndPageEvent FOnEndPage;
	TBeginBandEvent FOnBeginBand;
	TEndBandEvent FOnEndBand;
	TDetailEvent FOnGetValue;
	TEnterRectEvent FOnEnterRect;
	TProgressEvent FOnProgress;
	Fr_pars::TFunctionEvent FOnFunction;
	TBeginColumnEvent FOnBeginColumn;
	TPrintColumnEvent FOnPrintColumn;
	TManualBuildEvent FOnManualBuild;
	TObjectClickEvent FObjectClick;
	TMouseOverObjectEvent FMouseOverObject;
	TPrintReportEvent FOnPrintReportEvent;
	TfrExportFilter* FCurrentFilter;
	AnsiString FPageNumbers;
	int FCopies;
	bool FCollate;
	TfrPrintPages FPrintPages;
	TfrPage* FCurPage;
	bool _DoublePass;
	bool FMDIPreview;
	int FDefaultCopies;
	bool FDefaultCollate;
	AnsiString FPrnName;
	Classes::TStream* FDFMStream;
	bool FPrintIfEmpty;
	bool FShowPrintDialog;
	TBeginDocEvent FOnCrossBeginDoc;
	Classes::TNotifyEvent FOnCustomizeObject;
	bool FRebuildPrinter;
	bool FUseDefaultDataSetName;
	AnsiString __fastcall FormatValue(const Variant &V, int Format, const AnsiString FormatStr);
	void __fastcall BuildBeforeModal(System::TObject* Sender);
	void __fastcall ExportBeforeModal(System::TObject* Sender);
	void __fastcall PrintBeforeModal(System::TObject* Sender);
	bool __fastcall DoPrepareReport(void);
	virtual void __fastcall DoBuildReport(void);
	void __fastcall SetPrinterTo(AnsiString PrnName);
	void __fastcall GetIntrpValue(const AnsiString Name, Variant &Value);
	void __fastcall GetIntrpFunction(const AnsiString Name, const Variant &p1, const Variant &p2, const 
		Variant &p3, Variant &Val);
	void __fastcall ClearAttribs(void);
	
protected:
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall ReadBinaryData(Classes::TStream* Stream);
	void __fastcall WriteBinaryData(Classes::TStream* Stream);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation
		);
	virtual void __fastcall DoPrintReport(AnsiString PageNumbers, int Copies, bool Collate, TfrPrintPages 
		PrintPages);
	virtual void __fastcall Loaded(void);
	
public:
	bool CanRebuild;
	bool Terminated;
	Word PrintToDefault;
	Word DoublePass;
	bool FinalPass;
	AnsiString FileName;
	bool Modified;
	bool ComponentModified;
	bool MixVariablesAndDBFields;
	bool FR3Stream;
	AnsiString ReportComment;
	AnsiString ReportName;
	AnsiString ReportAutor;
	System::TDateTime ReportCreateDate;
	System::TDateTime ReportLastChange;
	AnsiString ReportVersionMajor;
	AnsiString ReportVersionMinor;
	AnsiString ReportVersionRelease;
	AnsiString ReportVersionBuild;
	bool ReportPasswordProtected;
	AnsiString ReportPassword;
	Byte ReportGeneratorVersion;
	__fastcall virtual TfrReport(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrReport(void);
	void __fastcall Clear(void);
	__property TBeginDocEvent OnCrossBeginDoc = {read=FOnCrossBeginDoc, write=FOnCrossBeginDoc};
	void __fastcall InternalOnEnterRect(Classes::TStringList* Memo, TfrView* View);
	void __fastcall InternalOnExportData(TfrView* View);
	void __fastcall InternalOnExportText(const Windows::TRect &DrawRect, int x, int y, const AnsiString 
		text, int FrameTyp, TfrView* View);
	void __fastcall InternalOnGetValue(AnsiString ParName, AnsiString &ParValue);
	void __fastcall InternalOnProgress(int Percent);
	void __fastcall InternalOnBeginColumn(TfrBand* Band);
	void __fastcall InternalOnPrintColumn(int ColNo, int &ColWidth);
	void __fastcall FillQueryParams(void);
	void __fastcall GetVariableValue(const AnsiString s, Variant &v);
	void __fastcall OnGetParsFunction(const AnsiString name, const Variant &p1, const Variant &p2, const 
		Variant &p3, Variant &val);
	TfrView* __fastcall FindObject(AnsiString Name);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	bool __fastcall LoadFromFile(AnsiString FName);
	void __fastcall SaveToFile(AnsiString FName);
	void __fastcall SaveToFR3File(AnsiString FName);
	void __fastcall LoadFromDB(Db::TDataSet* Table, int DocN);
	void __fastcall SaveToDB(Db::TDataSet* Table, int DocN);
	void __fastcall SaveToBlobField(Db::TField* Blob);
	void __fastcall LoadFromBlobField(Db::TField* Blob);
	void __fastcall LoadFromResourceName(unsigned Instance, const AnsiString ResName);
	void __fastcall LoadFromResourceID(unsigned Instance, int ResID);
	void __fastcall LoadTemplate(AnsiString fname, Classes::TStrings* comm, Graphics::TBitmap* Bmp, bool 
		Load);
	void __fastcall SaveTemplate(AnsiString fname, Classes::TStrings* comm, Graphics::TBitmap* Bmp);
	void __fastcall LoadPreparedReport(AnsiString FName);
	void __fastcall SavePreparedReport(AnsiString FName);
	Forms::TModalResult __fastcall DesignReport(void);
	bool __fastcall PrepareReport(void);
	void __fastcall ExportTo(TfrExportFilter* Filter, AnsiString FileName);
	void __fastcall ShowReport(void);
	void __fastcall ShowPreparedReport(void);
	void __fastcall PrintPreparedReportDlg(void);
	void __fastcall PrintPreparedReport(AnsiString PageNumbers, int Copies, bool Collate, TfrPrintPages 
		PrintPages);
	bool __fastcall ChangePrinter(int OldIndex, int NewIndex);
	void __fastcall EditPreparedReport(int PageIndex);
	__property TfrPages* Pages = {read=FPages};
	__property TfrEMFPages* EMFPages = {read=FEMFPages, write=FEMFPages};
	__property TfrDataDictionary* Dictionary = {read=FDictionary, write=FDictionary};
	void __fastcall BuildPage(int Index);
	
__published:
	__property Fr_dset::TfrDataset* Dataset = {read=FDataset, write=FDataset};
	__property int DefaultCopies = {read=FDefaultCopies, write=FDefaultCopies, default=1};
	__property bool DefaultCollate = {read=FDefaultCollate, write=FDefaultCollate, default=1};
	__property bool GrayedButtons = {read=FGrayedButtons, write=FGrayedButtons, default=0};
	__property Fr_view::TfrPreviewZoom InitialZoom = {read=FInitialZoom, write=FInitialZoom, nodefault}
		;
	__property bool MDIPreview = {read=FMDIPreview, write=FMDIPreview, default=0};
	__property bool ModalPreview = {read=FModalPreview, write=FModalPreview, default=1};
	__property bool ModifyPrepared = {read=FModifyPrepared, write=FModifyPrepared, default=1};
	__property Fr_view::TfrPreview* Preview = {read=FPreview, write=FPreview};
	__property Fr_view::TfrPreviewButtons PreviewButtons = {read=FPreviewButtons, write=FPreviewButtons
		, nodefault};
	__property bool PrintIfEmpty = {read=FPrintIfEmpty, write=FPrintIfEmpty, default=1};
	__property TfrReportType ReportType = {read=FReportType, write=FReportType, default=0};
	__property bool ShowPrintDialog = {read=FShowPrintDialog, write=FShowPrintDialog, default=1};
	__property bool ShowProgress = {read=FShowProgress, write=FShowProgress, default=1};
	__property bool StoreInDFM = {read=FStoreInDFM, write=FStoreInDFM, default=0};
	__property AnsiString Title = {read=FTitle, write=FTitle};
	__property bool RebuildPrinter = {read=FRebuildPrinter, write=FRebuildPrinter, nodefault};
	__property bool UseDefaultDataSetName = {read=FUseDefaultDataSetName, write=FUseDefaultDataSetName, 
		default=0};
	__property TBeginDocEvent OnBeginDoc = {read=FOnBeginDoc, write=FOnBeginDoc};
	__property TEndDocEvent OnEndDoc = {read=FOnEndDoc, write=FOnEndDoc};
	__property TBeginPageEvent OnBeginPage = {read=FOnBeginPage, write=FOnBeginPage};
	__property TEndPageEvent OnEndPage = {read=FOnEndPage, write=FOnEndPage};
	__property TBeginBandEvent OnBeginBand = {read=FOnBeginBand, write=FOnBeginBand};
	__property TEndBandEvent OnEndBand = {read=FOnEndBand, write=FOnEndBand};
	__property TDetailEvent OnGetValue = {read=FOnGetValue, write=FOnGetValue};
	__property TEnterRectEvent OnBeforePrint = {read=FOnEnterRect, write=FOnEnterRect};
	__property Fr_pars::TFunctionEvent OnUserFunction = {read=FOnFunction, write=FOnFunction};
	__property TProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TBeginColumnEvent OnBeginColumn = {read=FOnBeginColumn, write=FOnBeginColumn};
	__property TPrintColumnEvent OnPrintColumn = {read=FOnPrintColumn, write=FOnPrintColumn};
	__property TManualBuildEvent OnManualBuild = {read=FOnManualBuild, write=FOnManualBuild};
	__property TObjectClickEvent OnObjectClick = {read=FObjectClick, write=FObjectClick};
	__property TMouseOverObjectEvent OnMouseOverObject = {read=FMouseOverObject, write=FMouseOverObject
		};
	__property TPrintReportEvent OnPrintReport = {read=FOnPrintReportEvent, write=FOnPrintReportEvent};
		
	__property Classes::TNotifyEvent OnCustomizeObject = {read=FOnCustomizeObject, write=FOnCustomizeObject
		};
};


class PASCALIMPLEMENTATION TfrPages : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FPages;
	TfrReport* Parent;
	int __fastcall GetCount(void);
	TfrPage* __fastcall GetPages(int Index);
	void __fastcall RefreshObjects(void);
	
public:
	__fastcall TfrPages(TfrReport* AParent);
	__fastcall virtual ~TfrPages(void);
	void __fastcall Clear(void);
	void __fastcall Add(void);
	void __fastcall Delete(int Index);
	void __fastcall Move(int OldIndex, int NewIndex);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall SaveToStream(Classes::TStream* Stream);
	__property TfrPage* Pages[int Index] = {read=GetPages/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};


struct TfrCacheItem;
typedef TfrCacheItem *PfrCacheItem;

struct TfrCacheItem
{
	Fr_dbrel::TfrTDataSet* DataSet;
	AnsiString DataField;
} ;

class DELPHICLASS TfrCompositeReport;
class PASCALIMPLEMENTATION TfrCompositeReport : public TfrReport 
{
	typedef TfrReport inherited;
	
private:
	virtual void __fastcall DoBuildReport(void);
	
public:
	Classes::TList* Reports;
	HIDESBASE void __fastcall Clear(void);
	__fastcall virtual TfrCompositeReport(Classes::TComponent* AOwner);
	__fastcall virtual ~TfrCompositeReport(void);
	
__published:
	__property Word DoublePassReport = {read=DoublePass, write=DoublePass, nodefault};
};


class DELPHICLASS TfrReportDesigner;
class PASCALIMPLEMENTATION TfrReportDesigner : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
protected:
	virtual bool __fastcall GetModified(void) = 0 ;
	virtual void __fastcall SetModified(bool Value) = 0 ;
	
public:
	TfrPage* Page;
	bool FirstInstance;
	__fastcall virtual TfrReportDesigner(bool AFirstInstance);
	virtual void __fastcall BeforeChange(void) = 0 ;
	virtual void __fastcall AfterChange(void) = 0 ;
	virtual void __fastcall RedrawPage(void) = 0 ;
	virtual void __fastcall SelectObject(AnsiString ObjName) = 0 ;
	virtual AnsiString __fastcall InsertDBField(void) = 0 ;
	virtual AnsiString __fastcall InsertExpression(void) = 0 ;
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrReportDesigner(Classes::TComponent* AOwner) : 
		Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrReportDesigner(Classes::TComponent* AOwner
		, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrReportDesigner(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrReportDesigner(HWND ParentWindow) : Forms::TForm(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TfrDataManager;
class PASCALIMPLEMENTATION TfrDataManager : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Clear(void) = 0 ;
	virtual void __fastcall LoadFromStream(Classes::TStream* Stream) = 0 ;
	virtual void __fastcall SaveToStream(Classes::TStream* Stream) = 0 ;
	virtual void __fastcall BeforePreparing(void) = 0 ;
	virtual void __fastcall AfterPreparing(void) = 0 ;
	virtual void __fastcall PrepareDataSet(Fr_dbrel::TfrTDataSet* ds) = 0 ;
	virtual bool __fastcall ShowParamsDialog(void) = 0 ;
	virtual void __fastcall AfterParamsDialog(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TfrDataManager(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TfrDataManager(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrObjEditorForm;
class PASCALIMPLEMENTATION TfrObjEditorForm : public Forms::TForm 
{
	typedef Forms::TForm inherited;
	
public:
	virtual Forms::TModalResult __fastcall ShowEditor(TfrView* View);
public:
	#pragma option push -w-inl
	/* TCustomForm.Create */ inline __fastcall virtual TfrObjEditorForm(Classes::TComponent* AOwner) : 
		Forms::TForm(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrObjEditorForm(Classes::TComponent* AOwner, 
		int Dummy) : Forms::TForm(AOwner, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrObjEditorForm(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TfrObjEditorForm(HWND ParentWindow) : Forms::TForm(
		ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TfrFunctionLibrary;
class PASCALIMPLEMENTATION TfrFunctionLibrary : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Classes::TStringList* List;
	__fastcall virtual TfrFunctionLibrary(void);
	__fastcall virtual ~TfrFunctionLibrary(void);
	virtual bool __fastcall OnFunction(const AnsiString FName, const Variant &p1, const Variant &p2, const 
		Variant &p3, Variant &val);
	virtual void __fastcall DoFunction(int FNo, const Variant &p1, const Variant &p2, const Variant &p3
		, Variant &val) = 0 ;
	void __fastcall AddFunctionDesc(AnsiString FuncName, AnsiString Category, AnsiString Description);
};


class DELPHICLASS TfrCompressor;
class PASCALIMPLEMENTATION TfrCompressor : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	bool Enabled;
	__fastcall virtual TfrCompressor(void);
	virtual void __fastcall Compress(Classes::TStream* StreamIn, Classes::TStream* StreamOut);
	virtual void __fastcall DeCompress(Classes::TStream* StreamIn, Classes::TStream* StreamOut);
public:
		
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TfrCompressor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrInstalledFunctions;
class PASCALIMPLEMENTATION TfrInstalledFunctions : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* FList;
	void __fastcall UnRegisterFunctionLibrary(TfrFunctionLibrary* FunctionLibrary);
	
public:
	__fastcall TfrInstalledFunctions(void);
	__fastcall virtual ~TfrInstalledFunctions(void);
	void __fastcall Add(TfrFunctionLibrary* FunctionLibrary, AnsiString FuncName, AnsiString Category, 
		AnsiString Description);
	AnsiString __fastcall GetFunctionDesc(AnsiString FuncName);
	void __fastcall GetCategoryList(Classes::TStrings* List);
	void __fastcall GetFunctionList(AnsiString Category, Classes::TStrings* List);
};


class DELPHICLASS TDatabaseFunctionLibrary;
class PASCALIMPLEMENTATION TDatabaseFunctionLibrary : public TfrFunctionLibrary 
{
	typedef TfrFunctionLibrary inherited;
	
public:
	__fastcall virtual TDatabaseFunctionLibrary(void);
	virtual void __fastcall DoFunction(int FNo, const Variant &p1, const Variant &p2, const Variant &p3
		, Variant &val);
public:
	#pragma option push -w-inl
	/* TfrFunctionLibrary.Destroy */ inline __fastcall virtual ~TDatabaseFunctionLibrary(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrLocale;
class PASCALIMPLEMENTATION TfrLocale : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	unsigned FDllHandle;
	bool FLoaded;
	bool FLocalizedPropertyNames;
	TLocalizeEvent FOnLocalize;
	bool FIDEMode;
	
public:
	__fastcall TfrLocale(void);
	HBITMAP __fastcall LoadBmp(AnsiString ID);
	AnsiString __fastcall LoadStr(int ID);
	void __fastcall LoadDll(AnsiString Name);
	void __fastcall UnloadDll(void);
	__property bool LocalizedPropertyNames = {read=FLocalizedPropertyNames, write=FLocalizedPropertyNames
		, nodefault};
	__property TLocalizeEvent OnLocalize = {read=FOnLocalize, write=FOnLocalize};
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TfrLocale(void) { }
	#pragma option pop
	
};


class DELPHICLASS TfrGlobals;
class PASCALIMPLEMENTATION TfrGlobals : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	__fastcall TfrGlobals(void);
	__fastcall virtual ~TfrGlobals(void);
	void __fastcall Localize(void);
};


typedef AnsiString FR_Class__92[9];

typedef AnsiString FR_Class__03[9];

typedef AnsiString FR_Class__13[42];

struct TfrTextRec;
typedef TfrTextRec *PfrTextRec;

struct TfrTextRec
{
	TfrTextRec *Next;
	int X;
	int Y;
	AnsiString Text;
	System::SmallString<32>  FontName;
	int FontSize;
	int FontStyle;
	int FontColor;
	int FontCharset;
	int FillColor;
	Windows::TRect DrawRect;
	int FrameTyp;
	int FrameWidth;
	int FrameColor;
	int Alignment;
} ;

struct TfrAddInObjectInfo
{
	TMetaClass*ClassRef;
	Graphics::TBitmap* ButtonBmp;
	AnsiString ButtonHint;
	bool IsControl;
} ;

struct TfrExportFilterInfo
{
	TfrExportFilter* Filter;
	AnsiString FilterDesc;
	AnsiString FilterExt;
} ;

struct TfrFunctionInfo
{
	TfrFunctionLibrary* FunctionLibrary;
} ;

struct TfrToolsInfo
{
	AnsiString Caption;
	Graphics::TBitmap* ButtonBmp;
	Classes::TNotifyEvent OnClick;
} ;

typedef TfrAddInObjectInfo FR_Class__23[64];

typedef TfrExportFilterInfo FR_Class__33[64];

typedef TfrToolsInfo FR_Class__43[64];

typedef AnsiString FR_Class__53[51];

typedef AnsiString FR_Class__63[4];

//-- var, const, procedure ---------------------------------------------------
static const Shortint flStretched = 0x1;
static const Shortint flWordWrap = 0x2;
static const Shortint flWordBreak = 0x4;
static const Shortint flAutoSize = 0x8;
static const Shortint flTextOnly = 0x10;
static const Shortint flSuppressRepeated = 0x20;
static const Shortint flHideZeros = 0x40;
static const Byte flUnderlines = 0x80;
static const Word flRTLReading = 0x100;
static const Shortint flBandNewPageAfter = 0x2;
static const Shortint flBandPrintifSubsetEmpty = 0x4;
static const Shortint flBandBreaked = 0x8;
static const Shortint flBandOnFirstPage = 0x10;
static const Shortint flBandOnLastPage = 0x20;
static const Shortint flBandRepeatHeader = 0x40;
static const Byte flBandPrintChildIfInvisible = 0x80;
static const Shortint flPictCenter = 0x2;
static const Shortint flPictRatio = 0x4;
static const Word flWantHook = 0x8000;
static const Word flDontUndo = 0x4000;
static const Word flOnePerPage = 0x2000;
static const Shortint gtMemo = 0x0;
static const Shortint gtPicture = 0x1;
static const Shortint gtBand = 0x2;
static const Shortint gtSubReport = 0x3;
static const Shortint gtLine = 0x4;
static const Shortint gtCross = 0x5;
static const Shortint gtAddIn = 0xa;
static const Shortint frftNone = 0x0;
static const Shortint frftRight = 0x1;
static const Shortint frftBottom = 0x2;
static const Shortint frftLeft = 0x4;
static const Shortint frftTop = 0x8;
static const Shortint frtaLeft = 0x0;
static const Shortint frtaRight = 0x1;
static const Shortint frtaCenter = 0x2;
static const Shortint frtaVertical = 0x4;
static const Shortint frtaMiddle = 0x8;
static const Shortint frtaDown = 0x10;
static const Shortint baNone = 0x0;
static const Shortint baLeft = 0x1;
static const Shortint baRight = 0x2;
static const Shortint baCenter = 0x3;
static const Shortint baWidth = 0x4;
static const Shortint baBottom = 0x5;
static const Shortint baTop = 0x6;
static const Shortint baRest = 0x7;
static const Shortint frrfDontEditMemo = 0x1;
static const Shortint frrfDontEditScript = 0x2;
static const Shortint frrfDontEditContents = 0x4;
static const Shortint frrfDontModify = 0x8;
static const Shortint frrfDontSize = 0x10;
static const Shortint frrfDontMove = 0x20;
static const Shortint frrfDontDelete = 0x40;
static const Shortint psDouble = 0x5;
static const Shortint frtName = 0x4d;
static const Shortint frCurrentVersion = 0x19;
static const Shortint frSpecCount = 0x9;
extern PACKAGE AnsiString frSpecFuncs[9];
static const Shortint frRepInfoCount = 0x9;
extern PACKAGE AnsiString frRepInfo[9];
extern PACKAGE Graphics::TColor frColors[42];
extern PACKAGE AnsiString frColorNames[42];
extern PACKAGE TfrReportDesigner* frDesigner;
extern PACKAGE TMetaClass*frDesignerClass;
extern PACKAGE TfrDataManager* frDataManager;
extern PACKAGE Fr_pars::TfrParser* frParser;
extern PACKAGE Fr_intrp::TfrInterpretator* frInterpretator;
extern PACKAGE Fr_pars::TfrVariables* frVariables;
extern PACKAGE Fr_pars::TfrVariables* frConsts;
extern PACKAGE TfrCompressor* frCompressor;
extern PACKAGE Forms::TForm* frDialogForm;
extern PACKAGE TfrReport* CurReport;
extern PACKAGE TfrReport* MasterReport;
extern PACKAGE TfrView* CurView;
extern PACKAGE TfrBand* CurBand;
extern PACKAGE TfrPage* CurPage;
extern PACKAGE TfrDocMode DocMode;
extern PACKAGE bool DisableDrawing;
extern PACKAGE TfrAddInObjectInfo frAddIns[64];
extern PACKAGE int frAddInsCount;
extern PACKAGE TfrExportFilterInfo frFilters[64];
extern PACKAGE int frFiltersCount;
extern PACKAGE TfrFunctionInfo frFunctions[64];
extern PACKAGE int frFunctionsCount;
extern PACKAGE TfrToolsInfo frTools[64];
extern PACKAGE int frToolsCount;
extern PACKAGE TfrInstalledFunctions* frInstalledFunctions;
extern PACKAGE int PageNo;
extern PACKAGE Byte frCharset;
extern PACKAGE AnsiString frBandNames[51];
extern PACKAGE AnsiString frDateFormats[4];
extern PACKAGE AnsiString frTimeFormats[4];
extern PACKAGE Byte frVersion;
extern PACKAGE bool ErrorFlag;
extern PACKAGE AnsiString ErrorStr;
extern PACKAGE Classes::TStringList* SMemo;
extern PACKAGE bool ShowBandTitles;
extern PACKAGE bool frThreadDone;
extern PACKAGE Fr_progr::TfrProgressForm* frProgressForm;
extern PACKAGE Classes::TNotifyEvent frMemoEditor;
extern PACKAGE Classes::TNotifyEvent frTagEditor;
extern PACKAGE Classes::TNotifyEvent frRestrEditor;
extern PACKAGE Classes::TNotifyEvent frHighlightEditor;
extern PACKAGE Classes::TNotifyEvent frFieldEditor;
extern PACKAGE Classes::TNotifyEvent frDataSourceEditor;
extern PACKAGE Classes::TNotifyEvent frCrossDataSourceEditor;
extern PACKAGE Classes::TNotifyEvent frGroupEditor;
extern PACKAGE Classes::TNotifyEvent frPictureEditor;
extern PACKAGE Classes::TNotifyEvent frFontEditor;
extern PACKAGE TfrGlobals* frGlobals;
extern PACKAGE TfrView* __fastcall frCreateObject(Byte Typ, const AnsiString ClassName);
extern PACKAGE void __fastcall frRegisterObject(TMetaClass* ClassRef, Graphics::TBitmap* ButtonBmp, 
	const AnsiString ButtonHint);
extern PACKAGE void __fastcall frRegisterControl(TMetaClass* ClassRef, Graphics::TBitmap* ButtonBmp, 
	const AnsiString ButtonHint);
extern PACKAGE void __fastcall frUnRegisterObject(TMetaClass* ClassRef);
extern PACKAGE bool __fastcall frRegisterExportFilter(TfrExportFilter* Filter, const AnsiString FilterDesc
	, const AnsiString FilterExt);
extern PACKAGE void __fastcall frUnRegisterExportFilter(TfrExportFilter* Filter);
extern PACKAGE void __fastcall frRegisterFunctionLibrary(TMetaClass* ClassRef);
extern PACKAGE void __fastcall frUnRegisterFunctionLibrary(TMetaClass* ClassRef);
extern PACKAGE void __fastcall frRegisterTool(AnsiString MenuCaption, Graphics::TBitmap* ButtonBmp, 
	Classes::TNotifyEvent OnClick);
extern PACKAGE void __fastcall frAddFunctionDesc(TfrFunctionLibrary* FuncLibrary, AnsiString FuncName
	, AnsiString Category, AnsiString Description);
extern PACKAGE Fr_dbrel::TfrTDataSet* __fastcall GetDefaultDataSet(void);
extern PACKAGE TfrLocale* __fastcall frLocale(void);

}	/* namespace Fr_class */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Fr_class;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FR_Class
