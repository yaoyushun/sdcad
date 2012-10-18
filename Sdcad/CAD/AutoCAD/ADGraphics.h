#ifndef __ADGRAPHICS_H__
#define __ADGRAPHICS_H__

#include "Display.h"
#include "ADLayerGroup.h"
#include "ADEntities.h"
//----------------------------------------
//about AutoCAD
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

#define AD_LABELLENGTH 20//mm
//----------------------------------------
//about printing page
//44*34(inch)------------------------------
#define A0_WIDTH 1117.6//mm
#define A0_HEIGHT 863.6
//34*22
#define A1_WIDTH 863.6
#define A1_HEIGHT 558.8
//22*17
#define A2_WIDTH 558.8
#define A2_HEIGHT 431.8

#define A3_WIDTH 419.51
#define A3_HEIGHT 296.38

#define A4_WIDTH 296.38
#define A4_HEIGHT 210.38
#define PROJECTHOLELAYERNAME  "ËÕÖÝ¹¤³Ì¿±²ì_×ê¿×Í¼Àý_LAYER"
//-----------------------------------------
//#define PROJECTNAME  "¹¤³Ì¿±²ìÍâ¿ò"

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
	PAPER_A0 = DMPAPER_ESHEET,
	PAPER_A1 = DMPAPER_DSHEET,
	PAPER_A2 = DMPAPER_CSHEET,
	PAPER_A3 = DMPAPER_A3,
	PAPER_A4 = DMPAPER_A4,
	PAPER_Auto
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
//------------------------------------------------
//about AutoCAD
	char ACADVER[8];
	AD_OBJHANDLE m_HandSeed;
//sections
//header section
	ADPOINT m_Extmin;
	ADPOINT m_Extmax;
	ADPOINT m_Limmax;
	ADPOINT m_Limmin;
	COLORREF m_BKColor;
	COLORREF m_WhiteColor;
//tables section
	CObArray m_Styles;
	CObArray m_LTypes;
	CObArray m_BlockRecords;
	CADLayerGroup* m_pLayerGroup;
//blocks section
	CObArray m_Blocks;
//entities section
	CObArray m_Entities;
	CObArray m_SelectedEntities;
	CADEntity* m_pSelHandleEntity;

//------------------------------------------------
	//CADInsert* m_pTempInsert;
	//CADEntity* m_pTempEntity;
	double m_mXPixel;//per act unit to pixels
	double m_mYPixel;

	double m_mXPrintPixel;
	double m_mYPrintPixel;

	double m_PrintWidth;// unit(m)
	double m_PrintHeight;

	static AD_OBJHANDLE m_curHandle;
	static bool isCreateHandle;

	PAPERPROPERTY m_PaperSpace;

	WORKSPACE m_curWorkSpace;

	int m_nPrintOrient;

	int m_LineWidthFactor;
	bool m_bBlack;
//-------------------------------------------
	UNIT m_Unit;
	PAPERORIENT m_PaperOrient;
	double m_PaperLeft;
	double m_PaperTop;
	double m_PaperWidth;//unit(mm)
	double m_PaperHeight;
//-------------------------------------------
	//ADPOINT m_LayoutFrameTopLeft;
	//ADPOINT m_LayoutFrameBottomRight;

	int m_LayoutLeftMargin;
	int m_LayoutTopMargin;

//	int m_xScale;//print rate
//	int m_yScale;
	double m_RotateAngle;

	bool m_isDrawMText;

	GraphicsMode m_GraphicsMode;
//-------------------------------------------
	CPen* m_NullPen;
	CBrush* m_NullBrush;
	CPen* m_HandlePen;
	CBrush* m_HandleBrush;
	CPen* m_DashPen;
	bool m_bSnapStatus;
	LOGBRUSH logBrush;
//-------------------------------------------
	int m_selectedHandle;
	ADPOINT m_OrgPoint;
	CSize m_ViewOffset;
	float m_ZoomRate;
	float m_OriginZoomRate;
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

	CADEntity* m_pRSelEntity;
	CADEntity* m_pCopyEntity;
	bool m_bRSelected;
public:
	CRect GetMTextRect(const CADMText* pMText);

	bool SelectGraphics(const CPoint& point);
	bool SelectGraphics(const CPoint& point,CADEntity* pEntity);
	bool SelectGraphics2(const CPoint& point,CADEntity* pEntity);
	CADEntity* SelectEntity(const CPoint& point);
	CADEntity* RightSelectEntity(const CPoint& point);

	bool SelectPoint(const CPoint& point,CADPoint* pPoint);
	bool SelectLine(const CPoint& point,CADLine* pLine);
	bool SelectPolyline(const CPoint& point,CADPolyline* pPolyline);
	bool SelectCircle(const CPoint& point,CADCircle* pCircle);
	bool SelectArc(const CPoint& point,CADArc* pArc);
	bool SelectSpline(const CPoint& point,CADSpline* pSpline);
	bool SelectMText(const CPoint& point,CADMText* pMText);
	bool SelectText(const CPoint& point,CADText* pText);
	bool SelectSolid(const CPoint& point,CADSolid* pSolid);

	bool SelectInsert(const CPoint& point,CADInsert* pInsert);
	bool SelectInsert(CPoint point,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	bool SelectInsert_Point(const CPoint& point,CADPoint* pPoint,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Line(const CPoint& point,CADLine* pLine,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Polyline(const CPoint& point,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation);
	bool SelectInsert_Circle(const CPoint& point,CADCircle* pCircle,ADPOINT BasePoint,double xScale,double yScale,double rotation);

	void SelectHandle(const CPoint& point);
	int SelectHandle(const CPoint& point,CADEntity* pEntity);

	int SelectHandle_Point(const CPoint& point,const CADPoint* pPoint);
	int SelectHandle_Line(const CPoint& point,CADLine* pLine);
	int SelectHandle_Polyline(const CPoint& point,const CADPolyline* pPolyline);
	int SelectHandle_Circle(const CPoint& point,const CADCircle* pCircle);
	int SelectHandle_Insert(const CPoint& point,const CADInsert* pInsert);
	int SelectHandle_Arc(const CPoint& point,const CADArc* pArc);
	int SelectHandle_Spline(const CPoint& point,const CADSpline* pSpline);
	int SelectHandle_MText(const CPoint& point,const CADMText* pMText);
	int SelectHandle_Solid(const CPoint& point,const CADSolid* pSolid);

	void UndoAllSelected();

	void RemoveAll();
//----------------------------------------
//about coordinate translation
	CPoint DocToClient(const ADPOINT& point);
	CSize DocToClient(const ADSIZE& size);
	int DocToClient(double val);
	ADPOINT ClientToDoc(const CPoint& point);
	ADSIZE ClientToDoc(const CSize& size);
	double ClientToDoc(int val);
//----------------------------------------
	//void AddFrame();
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
	void DrawInsert_Spline(CDC* pDC,CADSpline* pSpline,ADPOINT BasePoint,double xScale,double yScale,double rotation);

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

	void MoveEntities(CDC* pDC,const CSize& size);
	void MoveEntities(CDC* pDC,CADEntity* pEntity,const CSize& size);

	void MoveEntity_Arc(CDC* pDC,CADArc* pArc,const CSize& size);
	void MoveEntity_Line(CDC* pDC,CADLine* pLine,const CSize& size);
	void MoveEntity_Point(CDC* pDC,CADPoint* pPoint,const CSize& size);
	void MoveEntity_Polyline(CDC* pDC,CADPolyline* pPolyline,const CSize& size);
	void MoveEntity_MText(CDC* pDC,CADMText* pMText,const CSize& size);
	void MoveEntity_Text(CDC* pDC,CADText* pText,const CSize& size);
	void MoveEntity_Solid(CDC* pDC,CADSolid* pSolid,const CSize& size);
	void MoveEntity_Circle(CDC* pDC,CADCircle* pCircle,const CSize& size);
	void MoveEntity_Insert(CDC* pDC,CADInsert* pInsert,const CSize& size);
	void MoveEntity_Spline(CDC* pDC,CADSpline* pSpline,const CSize& size);

	void MoveEntitiesTo(const CSize& size);
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

	void DrawHandle(CDC* pDC);
	void DrawHandle(CDC* pDC,CADEntity* pEntity);
	void DrawHandle(CDC* pDC,int fromSeletedIndex);

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

	void DrawSnapSign(CDC* pDC,CPoint point);
	bool SnapHandle(CDC* pDC,CPoint point);
	void GetPointCenter(CPoint point1,CPoint point2,CPoint& pointCenter);
	CPoint ConSnapPoint(CPoint point);
	COLORREF GetColor(short nColor);
//------------------------------------------------
//about AutoCAD
	static void CreateHandle(char* handle);
	void CreateDefault();
	void CreateDefaultLayer();
	int IndexOfBlocks(const char* name);
	int IndexOfBlockRecords(const char* name);
	int IndexOfStyles(const char* name);
	int IndexOfLTypes(const char* name);
	int IndexOfEntities(const CADEntity* pEntity);
//------------------------------------------------
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
};

#endif