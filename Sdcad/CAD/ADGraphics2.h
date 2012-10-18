#ifndef __ADGRAPHICS_H__
#define __ADGRAPHICS_H__

#include "Display.h"
#include "ADLayerGroup.h"
#include "FunctionLib\Function_Graphics.h"

#define AD_COLOR_RED                   1
#define AD_COLOR_YELLOW                2
#define AD_COLOR_GREEN                 3
#define AD_COLOR_CYAN                  4
#define AD_COLOR_BLUE                  5
#define AD_COLOR_MAGENTA               6
#define AD_COLOR_WHITE                 7
#define AD_COLOR_GRAY                  8

#define AD_ENT_LINE       1
#define AD_ENT_POINT      2
#define AD_ENT_CIRCLE     3
#define AD_ENT_SHAPE      4
#define AD_ENT_ELLIPSE    5
#define AD_ENT_SPLINE     6
#define AD_ENT_TEXT       7
#define AD_ENT_ARC        8
#define AD_ENT_TRACE      9
#define AD_ENT_REGION    10
#define AD_ENT_SOLID     11
#define AD_ENT_BLOCK     12
#define AD_ENT_ENDBLK    13
#define AD_ENT_INSERT    14
#define AD_ENT_ATTDEF    15
#define AD_ENT_ATTRIB    16
#define AD_ENT_SEQEND    17
#define AD_ENT_POLYLINE  19
#define AD_ENT_VERTEX    20
#define AD_ENT_LINE3D    21
#define AD_ENT_FACE3D    22
#define AD_ENT_DIMENSION 23
#define AD_ENT_VIEWPORT  24
#define AD_ENT_SOLID3D   25
#define AD_ENT_RAY       26
#define AD_ENT_XLINE     27
#define AD_ENT_MTEXT     28
#define AD_ENT_LEADER    29
#define AD_ENT_TOLERANCE 30
#define AD_ENT_MLINE     31
#define AD_OBJ_DICTIONARY 32
#define AD_OBJ_MLINESTYLE 33
#define AD_OBJ_CLASS      34
#define AD_ENT_BODY       35
#define AD_OBJ_GROUP      36
#define AD_OBJ_PROXY     100
#define AD_OBJ_XRECORD   101
#define AD_OBJ_IDBUFFER  102
#define AD_ENT_HATCH      40

#define AD_MTEXT_ATTACH_TOPLEFT        '1'
#define AD_MTEXT_ATTACH_TOPCENTER      '2'
#define AD_MTEXT_ATTACH_TOPRIGHT       '3'
#define AD_MTEXT_ATTACH_MIDDLELEFT     '4'
#define AD_MTEXT_ATTACH_MIDDLECENTER   '5'
#define AD_MTEXT_ATTACH_MIDDLERIGHT    '6'
#define AD_MTEXT_ATTACH_BOTTOMLEFT     '7'
#define AD_MTEXT_ATTACH_BOTTOMCENTER   '8'
#define AD_MTEXT_ATTACH_BOTTOMRIGHT    '9'
#define AD_MTEXT_ATTACH_TOLERANCE      'A'

typedef char AD_OBJHANDLE[8];
typedef void * AD_DB_HANDLE;

#define HATCHITEMS 20

#define A3_WIDTH 419.51
#define A3_HEIGHT 296.38

#define PROJECTNAME  "工程勘察外框"

enum GraphicsMode
{
	Model,
	Layout,
	Printing
};

enum UNIT
{
	UNIT_METER,
	UNIT_MILLIMETER
};

enum PAPERTYPE
{
	PAPER_A3,
	PAPER_A4
};

enum PAPERORIENT
{
	HORIZONTAL,
	VERTICAL
};

enum WORKSPACE
{
	MODELSPACE,
	PAPERSPACE
};

#define	AD_MAX_STRLEN 512
//#define	PI 3.1415926535897932384626433832795

typedef struct{
  double x;
  double y;
//  double z;
} ADPOINT;

typedef struct{
  double cx;
  double cy;
} ADSIZE;

typedef struct{
  double scale;
  double width;
  double height;
}PAPERPROPERTY;

typedef struct{
  char Pattern_Name[100];
  long Pattern_SmallID;
  long Pattern_BigID;
}PROJECT_PATTERN;

#define	PROJECT_MAX_PATTERN 50

class CADEntity : public CObject
{
protected:
	short m_nType;
public:
	AD_OBJHANDLE m_Handle;
	int m_nLayer;
	float m_nLineWidth;
	short m_nColor;
	char* m_LTypeName;
	float m_LTypeScale;
	CADEntity();
	virtual ~CADEntity();
	void operator=(CADEntity& Entity);
public:
	short GetType(){return m_nType;}
};

class CADPoint : public CADEntity 
{
protected:
	DECLARE_DYNCREATE(CADPoint)
	virtual ~CADPoint();
public:
	ADPOINT pt;
	CADPoint();
};

class CADLine : public CADEntity 
{
protected:
	//DECLARE_DYNCREATE(CADLine)
	virtual ~CADLine();
public:
	ADPOINT pt1,pt2;
	CADLine();
	void GetCenter(ADPOINT* ptCenter);
	void operator=(CADLine& adLine);
};

class CADRectangle  :public CADEntity
{
protected:
	DECLARE_DYNCREATE(CADRectangle)
	virtual ~CADRectangle();
public:
	CADRectangle(double x1,double y1,double x2,double y2);
	CADRectangle();
	ADPOINT* GetCenter();
	void Union(double x1,double y1,double x2,double y2);
	bool IsPointInside(double x,double y);
	void Scale(double rate);
	void SetCenter(double x, double y);
	void Offset(double x,double y);
	bool IsEmpty();
	void Union(CADRectangle* pRect);
	bool IsIntersects(CADRectangle* pRect);
	void SetRect(CADRectangle* pRect);
	void SetRect(double x1,double y1,double x2,double y2);
	double GetHeight();
	double GetWidth();
	double left;
	double right;
	double top;
	double bottom;
};

class CADPolyline : public CADEntity 
{
protected: 
	DECLARE_DYNCREATE(CADPolyline)
	virtual ~CADPolyline();
public: 
	CObArray m_Point;
	double* m_pElevation;
	bool m_Closed;
	CADPolyline();
	void operator=(CADPolyline& adPolylines);
	void GetBound(CADRectangle* bound);
};

class CADMText :public CADEntity
{
protected:
	DECLARE_DYNCREATE(CADMText)
public:
	CADMText();
	~CADMText();
public:
	ADPOINT m_Location;
	ADPOINT m_ptDir;
	bool	m_isVertical;
	bool    m_isWarp;
	//short	m_Angle;
	char m_Align;
	float	m_Size;
	float	m_Interval;
	CString	m_Text;
	unsigned char m_TextLen;
	char m_Font[100];
	double m_Height;
	double m_Width;
};

class CADText :public CADEntity
{
public:
	CADText();
	~CADText();
public:
	ADPOINT m_Location;
	ADPOINT m_ptDir;
	bool	m_isVertical;
	double	m_Angle;
	float	m_Size;
	float	m_Interval;
	CString	m_Text;
	unsigned char m_TextLen;
	char m_Font[100];
	char m_StyleName[AD_MAX_STRLEN];
	double m_Height;
	double m_WidthFactor;
};

class CADArc :public CADEntity
{
public:
	CADArc();
	~CADArc();
public:
	ADPOINT ptCenter;
	double m_Radius;
	double m_StartAng;
	double m_EndAng;
};

class CADCircle :public CADEntity
{
public:
	CADCircle();
	~CADCircle();
public:
	ADPOINT ptCenter;
	double m_Radius;
};

class CADEllipse :public CADEntity
{
public:
	CADEllipse();
	~CADEllipse();
public:
	ADPOINT ptCenter;
	ADPOINT ptOffset;
	double m_Radio;
	double m_StartParam;
	double m_EndParam;
};

class CADSpline :public CADEntity
{
public:
	CADSpline();
	~CADSpline();
public:
	bool m_Closed;
	short m_Degree;
	short m_NumKnot;
	short m_NumControl;
	short m_NumFit;
	CObArray m_FitPoint;
	CArray<POINT, POINT> m_CurvePoints;
};

class CADInsert :public CADEntity
{
public:
	CADInsert();
	~CADInsert();
public:
	char	m_Name[AD_MAX_STRLEN];	// Block name
	ADPOINT	pt;
	double m_xScale;
	double m_yScale;
	double m_Rotation;
};

class CADBlock :public CADEntity
{
public:
	CADBlock();
	~CADBlock();
public:
	char		m_Name[AD_MAX_STRLEN];	// Block name
	char		Flags;				// Block-type flags
	ADPOINT	m_BasePoint;				// Base point
	CObArray m_Entities;
	AD_OBJHANDLE m_Handle2;
};
//tables==================================================================
class CADLType : public CObject
{
public:
	CADLType();
	~CADLType();
public:
	char m_Name[AD_MAX_STRLEN];
	float *m_Items;
	int m_ItemCount;
	AD_OBJHANDLE m_Handle;
};

class CADStyle : public CObject
{
public:
	CADStyle();
	~CADStyle();
public:
	char m_Font[100];
	char m_Name[AD_MAX_STRLEN];
	double m_WidthFactor;
	AD_OBJHANDLE m_Handle;
};

class CADBlockRecord :public CObject
{
public:
	char m_Name[AD_MAX_STRLEN];
	AD_OBJHANDLE m_Handle;
};
//===========================================================================

class CADSolid :public CADEntity
{
public:
	CADSolid();
	~CADSolid();
public:
	char		m_Name[AD_MAX_STRLEN];	
	char		Flags;				
	ADPOINT	m_pt0;
	ADPOINT	m_pt1;
	ADPOINT	m_pt2;
	ADPOINT	m_pt3;
};

class CADHatchLine :public CADEntity
{
//public:
//	CADHatchLine();
//	~CADHatchLine();
public:
//	CObArray m_Lines;
	double m_Items[HATCHITEMS];
	ADPOINT m_BasePoint;
	double m_Angle;
	short  m_NumDash;
	double m_xOffset;
	double m_yOffset;
	//double m_Length;
};

class CADHatch :public CADEntity
{
public:
	CADHatch();
	~CADHatch();
public:
	char	m_Name[AD_MAX_STRLEN];
	CADPolyline* m_pPolyline;
	CObArray m_HatchLines;
	CObArray m_Paths;
	bool m_bSolidFill;
	int m_nSeedCount;
	ADPOINT m_SeedPoint;
	short m_Flag;//凸度标志
	float m_Scale;
};

class CADGraphics:public CObject
{
protected:
	DECLARE_DYNCREATE(CADGraphics)
public:
	CADGraphics();
	~CADGraphics();
public:
	CPen* m_pPen;
	CPen* m_pOldPen;
public:
	char ACADVER[8];
	AD_OBJHANDLE m_HandSeed;
	/*double extmin[3];
	double extmax[3];
	double limmin[2];
	double limmax[2];*/
	ADPOINT m_Extmin;
	ADPOINT m_Extmax;
	ADPOINT m_Limmax;
	ADPOINT m_Limmin;
	COLORREF m_BKColor;
	COLORREF m_WhiteColor;
	CObArray m_Entities;
	CObArray m_SelectedEntities;
	CADEntity* m_pSelHandleEntity;

//tables--------------------------------
	CObArray m_Blocks;
	CObArray m_Styles;
	CObArray m_LTypes;
	CObArray m_BlockRecords;
	CADLayerGroup* m_pLayerGroup;
//--------------------------------------
///	PROJECT_PATTERN m_Patterns[PROJECT_MAX_PATTERN];
	UNIT m_Unit;
	PAPERORIENT m_PaperOrient;

	double m_mXPixel;//per act unit to pixels
	double m_mYPixel;

	double m_mXPrintPixel;
	double m_mYPrintPixel;

	double m_PrintWidth;// unit(m)
	double m_PrintHeight;

//	double m_PaperWidth;//unit(mm)
//	double m_PaperHeight;

	static AD_OBJHANDLE m_curHandle;
	static bool isCreateHandle;

	PAPERPROPERTY m_PaperSpace;

	WORKSPACE m_curWorkSpace;

	int m_nPrintOrient;

	int m_LineWidthFactor;

	double m_PaperLeft;
	double m_PaperTop;

	ADPOINT m_LayoutFrameTopLeft;
	ADPOINT m_LayoutFrameBottomRight;

	int m_LayoutLeftMargin;
	int m_LayoutTopMargin;

//	int m_xScale;//print rate
//	int m_yScale;
	double m_RotateAngle;

	bool m_isDrawMText;

	GraphicsMode m_GraphicsMode;

	CPen* m_NullPen;
	CBrush* m_NullBrush;
	CPen* m_HandlePen;
	CBrush* m_HandleBrush;
	CPen* m_DashPen;
	bool m_bSnapStatus;
	LOGBRUSH logBrush;
	CADInsert* m_pTempInsert;
	CADEntity* m_pTempEntity;

	int m_selectedHandle;
	ADPOINT m_OrgPoint;
	CSize m_ViewOffset;
	double m_ZoomRate;
	double m_PaperScale;

	CADRectangle m_Bound;
	CADRectangle m_PrintBound;

	bool m_bHaveSnap;
	bool m_bLineWidth;

	int m_HandleWidth;
	ADPOINT m_curSnapP;

	CDisplay* m_pDisplay;
	double m_FrameMaginLeft;
	double m_FrameMaginTop;
	double m_FrameMaginRight;
	double m_FrameMaginBottom;

	CRect GetMTextRect(CADMText* pMText);

	bool SelectGraphics(const CPoint point,CDC* pDC);
	bool SelectGraphics(const CPoint point,CADEntity* pEntity,CDC* pDC);
	bool SelectGraphics2(const CPoint point,CADEntity* pEntity,CDC* pDC);

	bool SelectPoint(const CPoint point,CADPoint* pPoint);
	bool SelectLine(const CPoint point,CADLine* pLine);
	bool SelectPolyline(const CPoint point,CADPolyline* pPolyline);
	bool SelectCircle(const CPoint point,CADCircle* pCircle);
	bool SelectArc(const CPoint point,CADArc* pArc);
	bool SelectSpline(const CPoint point,CADSpline* pSpline);
	bool SelectMText(const CPoint point,CADMText* pMText,CDC* pDC);
	bool SelectText(const CPoint point,CADText* pText,CDC* pDC);
	bool SelectSolid(const CPoint point,CADSolid* pSolid,CDC* pDC);

	bool SelectInsert(const CPoint point,CADInsert* pInsert);
	bool SelectInsert(CPoint point,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	bool SelectInsert_Point(const CPoint point,CADPoint* pPoint,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Line(const CPoint point,CADLine* pLine,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Polyline(const CPoint point,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Circle(const CPoint point,CADCircle* pCircle,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	void SelectHandle(const CPoint point);
	int SelectHandle(const CPoint point,CADEntity* pEntity);

	int SelectHandle_Point(const CPoint point,CADPoint* pPoint);
	int SelectHandle_Line(const CPoint point,CADLine* pLine);
	int SelectHandle_Polyline(const CPoint point,CADPolyline* pPolyline);
	int SelectHandle_Circle(const CPoint point,CADCircle* pCircle);
	int SelectHandle_Insert(const CPoint point,CADInsert* pInsert);
	int SelectHandle_Arc(const CPoint point,CADArc* pArc);
	int SelectHandle_Spline(const CPoint point,CADSpline* pSpline);
	int SelectHandle_MText(const CPoint point,CADMText* pMText);
	int SelectHandle_Solid(const CPoint point,CADSolid* pSolid);

	void UndoAllSelected();
	CPoint DocToClient(ADPOINT point);
	CSize DocToClient(ADSIZE size);
	int DocToClient(double val);
	ADPOINT ClientToDoc(CPoint point);
	ADSIZE ClientToDoc(CSize size); 
	double ClientToDoc(int val);
	void AddFrame();
	void DrawGraphics(CDC* pDC);
	void DrawGraphics(CDC* pDC,CADEntity* pEntity);

	void DrawLayoutFrame(CDC* pDC);

	void DrawArc(CDC* pDC,CADArc* pArc);
	void DrawLine(CDC* pDC,CADLine* pLine);
	void DrawPoint(CDC* pDC,CADPoint* pPoint);
	void DrawPolyline(CDC* pDC,CADPolyline* pPolyline);
	void DrawMText(CDC* pDC,CADMText* pText);
	void DrawText(CDC* pDC,CADText* pText);
	void DrawSolid(CDC* pDC,CADSolid* pSolid);
	void DrawCircle(CDC* pDC,CADCircle* pCircle);
	void DrawSpline(CDC* pDC,CADSpline* pSpline);

	void DrawHatch(CDC* pDC,CADHatch* pHatch);
	void DrawHatchPath(CDC* pDC,CADEntity* pEntity);
	void DrawHatchPath_Circle(CDC* pDC,CADCircle* pCircle);
	void DrawHatchPath_LwPolyline(CDC* pDC,CADPolyline* pPolyline);
	void DrawHatchPath_LwPolyline(CDC* pDC,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	void DrawInsert(CDC* pDC,CADInsert* pInsert);
	void DrawInsert(CDC* pDC,CADEntity* pEntity,ADPOINT BasePoint,double xScale=1.0,double yScale=1.0,double rotation=0.0);

	void DrawInsert_Circle(CDC* pDC,CADCircle* pCircle,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_Line(CDC* pDC,CADLine* pLine,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_Polyline(CDC* pDC,CADPolyline* pPolyine,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_MText(CDC* pDC,CADMText* pMText,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_Hatch(CDC* pDC,CADHatch* pHatch,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_Text(CDC* pDC,CADText* pText,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_HatchPath(CDC* pDC,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	void DrawInsert_Insert(CDC* pDC,CADInsert* pInsert,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	void MoveEntities(CDC* pDC,const CSize size);
	void MoveEntities(CDC* pDC,CADEntity* pEntity,const CSize size);

	void MoveEntity_Arc(CDC* pDC,CADArc* pArc,const CSize size);
	void MoveEntity_Line(CDC* pDC,CADLine* pLine,const CSize size);
	void MoveEntity_Point(CDC* pDC,CADPoint* pPoint,const CSize size);
	void MoveEntity_Polyline(CDC* pDC,CADPolyline* pPolyline,const CSize size);
	void MoveEntity_MText(CDC* pDC,CADMText* pMText,const CSize size);
	void MoveEntity_Text(CDC* pDC,CADText* pText,const CSize size);
	void MoveEntity_Solid(CDC* pDC,CADSolid* pSolid,const CSize size);
	void MoveEntity_Circle(CDC* pDC,CADCircle* pCircle,const CSize size);
	void MoveEntity_Insert(CDC* pDC,CADInsert* pInsert,const CSize size);
	void MoveEntity_Spline(CDC* pDC,CADSpline* pSpline,const CSize size);

	void MoveEntitiesTo(const CSize size);
	void MoveEntitiesTo(CADEntity* pEntity,double dx,double dy);

	void MoveEntityTo_Arc(CADArc* pArc,double dx,double dy);
	void MoveEntityTo_Line(CADLine* pLine,double dx,double dy);
	void MoveEntityTo_Point(CADPoint* pPoint,double dx,double dy);
	void MoveEntityTo_Polyline(CADPolyline* pPolyline,double dx,double dy);
	void MoveEntityTo_MText(CADMText* pText,double dx,double dy);
	void MoveEntityTo_Text(CADText* pText,double dx,double dy);
	void MoveEntityTo_Solid(CADSolid* pSolid,double dx,double dy);
	void MoveEntityTo_Circle(CADCircle* pCircle,double dx,double dy);
	void MoveEntityTo_Insert(CADInsert* pInsert,double dx,double dy);
	void MoveEntityTo_Spline(CADSpline* pSpline,double dx,double dy);

	void RotateEntities(CDC* pDC,CPoint BasePoint,CPoint point);
	void RotateEntities(CDC* pDC,CADEntity* pEntity,CPoint BasePoint,double Rotation);

	void RotateEntity_Line(CDC* pDC,CADLine* pLine,CPoint BasePoint,double Rotation);
	void RotateEntity_Arc(CDC* pDC,CADArc* pArc,CPoint BasePoint,double Rotation);
	void RotateEntity_Point(CDC* pDC,CADPoint* pPoint,CPoint BasePoint,double Rotation);
	void RotateEntity_Polyline(CDC* pDC,CADPolyline* pPolyline,CPoint BasePoint,double Rotation);
	void RotateEntity_MText(CDC* pDC,CADMText* pMText,CPoint BasePoint,double Rotation);
	void RotateEntity_MText2(CDC* pDC,CADMText* pMText,CPoint BasePoint,double Rotation);
	void RotateEntity_Text(CDC* pDC,CADText* pText,CPoint BasePoint,double Rotation);
	void RotateEntity_Solid(CDC* pDC,CADSolid* pSolid,CPoint BasePoint,double Rotation);
	void RotateEntity_Circle(CDC* pDC,CADCircle* pCircle,CPoint BasePoint,double Rotation);
	void RotateEntity_Insert(CDC* pDC,CADInsert* pInsert,CPoint BasePoint,double Rotation);
	void RotateEntity_Spline(CDC* pDC,CADSpline* pSpline,CPoint BasePoint,double Rotation);

	void RotateEntitiesTo(CPoint BasePoint,CPoint point);
	void RotateEntitiesTo(CADEntity* pEntity,ADPOINT BasePoint,double Rotation);

	void RotateEntityTo_Line(CADLine* pLine,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Arc(CADArc* pArc,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Point(CADPoint* pPoint,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Polyline(CADPolyline* pPolyline,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_MText(CADMText* pText,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Text(CADText* pText,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Solid(CADSolid* pSolid,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Circle(CADCircle* pCircle,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Insert(CADInsert* pInsert,ADPOINT BasePoint,double Rotation);
	void RotateEntityTo_Spline(CADSpline* pSpline,ADPOINT BasePoint,double Rotation);

	void MoveHandle(CDC* pDC,const CSize size);
	void MoveHandle(CDC* pDC,CADEntity* pEntity,const CSize size);

	void MoveHandle_Arc(CDC* pDC,CADArc* pArc,const CSize size);
	void MoveHandle_Line(CDC* pDC,CADLine* pLine,const CSize size);
	void MoveHandle_Point(CDC* pDC,CADPoint* pPoint,const CSize size);
	void MoveHandle_Polyline(CDC* pDC,CADPolyline* pPolyline,const CSize size);
	void MoveHandle_MText(CDC* pDC,CADMText* pMText,const CSize size);
	void MoveHandle_Text(CDC* pDC,CADText* pText,const CSize size);
	void MoveHandle_Solid(CDC* pDC,CADSolid* pSolid,const CSize size);
	void MoveHandle_Circle(CDC* pDC,CADCircle* pCircle,const CSize size);
	void MoveHandle_Insert(CDC* pDC,CADInsert* pInsert,const CSize size);
	void MoveHandle_Spline(CDC* pDC,CADSpline* pSpline,const CSize size);

	void MoveHandleTo(const CSize size);
	void MoveHandleTo(CADEntity* pEntity,double dx,double dy);

	void MoveHandleTo_Arc(CADArc* pArc,double dx,double dy);
	void MoveHandleTo_Line(CADLine* pLine,double dx,double dy);
	void MoveHandleTo_Point(CADPoint* pPoint,double dx,double dy);
	void MoveHandleTo_Polyline(CADPolyline* pPolyline,double dx,double dy);
	void MoveHandleTo_MText(CADMText* pText,double dx,double dy);
	void MoveHandleTo_Text(CADText* pText,double dx,double dy);
	void MoveHandleTo_Solid(CADSolid* pSolid,double dx,double dy);
	void MoveHandleTo_Circle(CADCircle* pCircle,double dx,double dy);
	void MoveHandleTo_Insert(CADInsert* pInsert,double dx,double dy);
	void MoveHandleTo_Spline(CADSpline* pSpline,double dx,double dy);

//	void DrawMoveInsert(CDC* pDC,CADInsert* pInsert,const CSize size);

	void DrawHandle(CDC* pDC);
	void DrawHandle(CDC* pDC,CADEntity* pEntity);

	void DrawHandle_Arc(CDC* pDC,CADArc* pArc);
	void DrawHandle_Line(CDC* pDC,CADLine* pLine);
	void DrawHandle_Point(CDC* pDC,CADPoint* pPoint);
	void DrawHandle_Polyline(CDC* pDC,CADPolyline* pPolyline);
	void DrawHandle_MText(CDC* pDC,CADMText* pText);
	void DrawHandle_Text(CDC* pDC,CADText* pText);
	void DrawHandle_Solid(CDC* pDC,CADSolid* pSolid);
	void DrawHandle_Circle(CDC* pDC,CADCircle* pCircle);
	void DrawHandle_Insert(CDC* pDC,CADInsert* pInsert);
	void DrawHandle_Spline(CDC* pDC,CADSpline* pSpline);

	void DrawSeletedHandle(CDC* pDC);
	void CalZoomRate();

	int Distance(CPoint point1,CPoint point2);
	double Distance(ADPOINT point1,ADPOINT point2);
	void Circle(CDC* pDC,const CPoint ptCenter,const CPoint point2);
	void Circle(CDC* pDC,const CPoint ptCenter,int radius);
	ADPOINT Rotate(ADPOINT BasePoint,ADPOINT adPoint,double rotation);
	ADPOINT Rotate2(ADPOINT BasePoint,ADPOINT adPoint,double Rotation);
	CPoint Rotate(CPoint BasePoint,CPoint Point,double Rotation);
//	bool isSelectedEntity(CPoint point,CADEntity* pEntity);
//	void MoveTo(const CSize size);
//	void MoveTo(CDC* pDC,const CSize size);

	void DrawSnapSign(CDC* pDC,CPoint point);
	bool SnapHandle(CDC* pDC,CPoint point);
	void GetPointCenter(CPoint point1,CPoint point2,CPoint& pointCenter);
	CPoint ConSnapPoint(CPoint point);
	COLORREF GetColor(short nColor);
	int IndexOfBlocks(char* name);
	int IndexOfStyles(char* name);
	int IndexOfLTypes(char* name);
	int IndexOfEntities(CADEntity* pEntity);
	CADEntity* TransBlockEntity(CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale);
	void SetMText(CADMText* pMText,LPCTSTR str);
	CRect GetPolylineBound(CPoint* points,int pointCount);
	CRect GetLineBound(CPoint point1,CPoint point2);
	COLORREF GetEntityColor(CADEntity* pEntity);
	CPoint	RightAngleCorrect(CPoint begin, CPoint end);
	ADPOINT	RightAngleCorrect(ADPOINT begin, ADPOINT end);

	short GetLineWidth(CADEntity* pEntity);
//
	bool CaptureHole(CPoint point,ADPOINT* pPoint);
	void CreateSection(CADPolyline* pPolyline,int PaperScale,LPCTSTR name);
	void RotateAll(CDC* pDC,CPoint BasePoint,double angle);

	bool CreatePenStyle(CDC* pDC,CADEntity* pEntity);
	static void CreateHandle(char* handle);
	void CreateDefault();
};


#endif