#ifndef __ADENTITIES_H__
#define __ADENTITIES_H__

#define	AD_MAX_STRLEN 512
//#define	PI 3.1415926535897932384626433832795
#include "..\FunctionLib\Function_Graphics.h"

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

typedef char AD_OBJHANDLE[8];
typedef void * AD_DB_HANDLE;

#define HATCHITEMS 20

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
/*
typedef struct{
  char Pattern_Name[100];
  long Pattern_SmallID;
  long Pattern_BigID;
}PROJECT_PATTERN;
*/
#define	PROJECT_MAX_PATTERN 50

class CADEntity// : public CObject
{
protected:
	short m_nType;
public:
	AD_OBJHANDLE m_Handle;
	short m_nLayer;
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
public:
	ADPOINT pt;
	CADPoint();
	virtual ~CADPoint();
};

class CADLine : public CADEntity 
{
public:
	ADPOINT pt1,pt2;
	CADLine();
	virtual ~CADLine();
	void GetCenter(ADPOINT* ptCenter);
	//void operator=(CADLine& adLine);
};

class CADRectangle  :public CADEntity
{
protected:
	//DECLARE_DYNCREATE(CADRectangle)
public:
	virtual ~CADRectangle();
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
//protected: 
//	DECLARE_DYNCREATE(CADPolyline)
public: 
	CObArray m_Point;
	double* m_pElevation;
	bool m_Closed;
	CADPolyline();
	virtual ~CADPolyline();
//	void operator=(CADPolyline& adPolylines);
	void GetBound(CADRectangle* bound);
};

class CADMText :public CADEntity
{
//protected:
//	DECLARE_DYNCREATE(CADMText)
public:
	CADMText();
	virtual ~CADMText();
public:
	ADPOINT m_Location;			//坐标
	ADPOINT m_ptDir;			//旋转角度()
	bool	m_isVertical;
	bool    m_isWarp;			//是否自动换行
	//short	m_Angle;
	char m_Align;				//对齐方式
	unsigned char m_TextLen;	//
	float	m_Size;				//
	float	m_Interval;			//行间距因子
	CString	m_Text;				//content
	double m_Height;			//font height
	double m_Width;				//font width
	char m_Font[100];			//font style
};

class CADText :public CADEntity
{
public:
	CADText();
	virtual ~CADText();
public:
	ADPOINT m_Location;
	ADPOINT m_ptDir;
	bool	m_isVertical;
	unsigned char m_TextLen;
	double	m_Angle;
	float	m_Size;
	float	m_Interval;
	CString	m_Text;
	double m_Height;
	double m_WidthFactor;
	char m_Font[100];
	char m_StyleName[AD_MAX_STRLEN];
};

class CADArc :public CADEntity
{
public:
	CADArc();
	virtual ~CADArc();
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
	virtual ~CADCircle();
public:
	ADPOINT ptCenter;
	double m_Radius;
};

class CADEllipse :public CADEntity
{
public:
	CADEllipse();
	virtual ~CADEllipse();
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
	virtual ~CADSpline();
public:
	bool m_Closed;
	short m_Degree;
	short m_NumKnot;
	short m_NumControl;
	short m_NumFit;
	double* m_pKnotPoints;
	CObArray m_ControlPoint;
	CObArray m_FitPoint;				//拟合点(必须有)
	CArray<POINT, POINT> m_CurvePoints;
	//Ext
	bool m_bNode;
	float m_NodeRadius;
};

class CADInsert :public CADEntity
{
public:
	CADInsert();
	virtual ~CADInsert();
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
	virtual ~CADBlock();
public:
	char		m_Name[AD_MAX_STRLEN];	// Block name
	char		Flags;					// Block-type flags
	ADPOINT	m_BasePoint;				// Base point
	CObArray m_Entities;
	AD_OBJHANDLE m_Handle2;
};
//tables==================================================================
class CADLType// : public CObject
{
public:
	CADLType();
	virtual ~CADLType();
public:
	char m_Name[AD_MAX_STRLEN];
	float *m_Items;
	int m_ItemCount;
	AD_OBJHANDLE m_Handle;
};

class CADStyle// : public CObject
{
public:
	CADStyle();
	virtual ~CADStyle();
public:
	char m_Name[AD_MAX_STRLEN];
	char m_Font[100];
	double m_WidthFactor;
	AD_OBJHANDLE m_Handle;
};

class CADBlockRecord// :public CObject
{
public:
	char m_Name[AD_MAX_STRLEN];
	AD_OBJHANDLE m_Handle;
};
//================================================

class CADSolid :public CADEntity
{
public:
	CADSolid();
	virtual ~CADSolid();
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
	short  m_NumDash;
	double m_Angle;
	double m_xOffset;
	double m_yOffset;
	//double m_Length;
};

class CADHatch :public CADEntity
{
public:
	CADHatch();
	virtual ~CADHatch();
public:
	char	m_Name[AD_MAX_STRLEN];
	CADPolyline* m_pPolyline;
	CObArray m_HatchLines;
	CObArray m_Paths;
	int m_nSeedCount;
	bool m_bSolidFill;
	short m_Flag;//凸度标志
	float m_Scale;
	ADPOINT m_SeedPoint;
};

#endif