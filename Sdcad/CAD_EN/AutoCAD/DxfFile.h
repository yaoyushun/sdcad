#ifndef __DXFFILE_H__
#define __DXFFILE_H__

#define AutoCADR12     "AC1009"
#define AutoCADR13     "AC1012"
#define AutoCADR14     "AC1014"
#define AutoCAD2000    "AC1015"

// Section Definitions
#define	SEC_NOTSET		0x0000
#define	SEC_HEADER		0x0001
#define	SEC_CLASSES		0x0002
#define	SEC_TABLES		0x0004
#define	SEC_BLOCKS		0x0008
#define	SEC_ENTITIES	0x0010
#define	SEC_OBJECTS		0x0020

// Table Type Definitions
#define	TAB_NOTSET		0x0000
#define	TAB_APPID		0x0001
#define	TAB_BLOCKRECORD	0x0002
#define	TAB_DIMSTYLE	0x0004
#define	TAB_LAYER		0x0008
#define	TAB_LTYPE		0x0010
#define	TAB_STYLE		0x0020
#define	TAB_UCS			0x0040
#define	TAB_VIEW		0x0080
#define	TAB_VPORT		0x0100

//---------------Hint Define-------------------------------
#define BEGINSEC    "  0\nSECTION\n"
#define ENDSEC      "  0\nENDSEC\n"

#define ENDFILE     "  0\nEOF"
//---------------Header Define------------------------------
#define HEADER      "  2\nHEADER\n"
#define DXACADVER   "  9\n$ACADVER\n"
#define LIMMIN	    "  9\n$LIMMIN\n"
#define LIMMAX	    "  9\n$LIMMAX\n"
#define EXTMIN	    "  9\n$EXTMIN\n"
#define EXTMAX	    "  9\n$EXTMAX\n"
#define CRLF		"\n"
#define DXFX		" 10\n"
#define DXFY		" 20\n"	
#define DXFZ		" 30\n"	
#define TEXTSTYLE  "  9\n$TEXTSTYLE\n  7\nSTANDARD\n"
//---------------End Header----------------------------------

//---------------Entities Define-----------------------------
#define ENTITIES	"  2\nENTITIES\n"
#define ETEXT		"  2\nTEXT\n  8\n0\n  1\n"
#define EPOLYLINE	"  0\nPOLYLINE\n  8\n0\n  66\n1\n"
#define CPOLYLINE	" 70\n     1\n"
#define EPOINT		"  0\nPOINT\n  8\n0\n"
#define EVERTEX		"  0\nVERTEX\n  8\n0\n"
#define ESEQEND		"  0\nSEQEND\n"
//---------------End Entities--------------------------------

//---------------End Hint---------------------------------

#include "ADLayerGroup.h"
#include "ADGraphics.h"

class CDxfFile
{
public:
	CDxfFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CDxfFile();
	bool m_isReadHatch;
	void FileImport(LPCTSTR lpFilename);
	void FileExport(LPCTSTR lpFilename);
	void ReadHoleLegend(LPCTSTR lpFilename);

private:
	float xMin,yMin,xMax,yMax;
	//CGraphics m_Graphics;
	char ACADVER[8];
	CADLayerGroup* m_LayerGroup;
	CADGraphics* m_Graphics;
	AD_OBJHANDLE m_curHandle;

//	void AutoCADR12Import(LPCTSTR lpFilename);
//	void AutoCADR13Import(LPCTSTR lpFilename);
	void AutoCAD2000Import(LPCTSTR lpFilename);

	void SectionBegin(FILE* pFile,DWORD dwSection);
	void SectionEnd(FILE* pFile);

	void TableBegin(FILE* pFile,DWORD dwTableType);
	void TableEnd(FILE* pFile);
//	void AutoCADR12Export(LPCTSTR lpFilename);
	void WriteParamDouble( FILE* pFile, int GroupCode, double value );
	void WriteParamInteger( FILE* pFile, int GroupCode, int value );
	void WriteParamString( FILE* pFile, int GroupCode, LPCTSTR value );

	void WriteTable_Layer(FILE* pFile);
	void WriteTable_VPort(FILE* pFile);
	void WriteTable_LType(FILE* pFile);
	void WriteTable_AppId(FILE* pFile);
	void WriteTable_Block_Record(FILE* pFile);
	void WriteTable_View(FILE* pFile);
	void WriteTable_STyle(FILE* pFile);

	void WriteEntities(FILE* pFile);
	void WriteEntities(FILE* pFile,CADEntity* pEntity);
	void WriteBlocks(FILE* pFile);
	void WriteObjects(FILE* pFile);

	void WriteEntity_Point(FILE* pFile,CADPoint* pPoint);
	void WriteEntity_Arc(FILE* pFile,CADArc* pArc);
	void WriteEntity_Line(FILE* pFile,CADLine* pLine);
	void WriteEntity_Polyline(FILE* pFile,CADPolyline* pPolyline);
	void WriteEntity_LwPolyline(FILE* pFile,CADPolyline* pPolyline);
	void WriteEntity_MText(FILE* pFile,CADMText* pMText);
	void WriteEntity_Text(FILE* pFile,CADText* pText);	
	void WriteEntity_Solid(FILE* pFile,CADSolid* pSolid);
	void WriteEntity_Circle(FILE* pFile,CADCircle* pCircle);
	void WriteEntity_Spline(FILE* pFile,CADSpline* pSpline);
	void WriteEntity_Hatch(FILE* pFile,CADHatch* pHatch);
	void WriteEntity_Insert(FILE* pFile,CADInsert* pInsert);
	void WriteEntity_Common(FILE* pFile,CADEntity* pEntity);

	void Read_Hatch(FILE* fp,bool isEntity);
	void CreateNewHandle();
};

#endif