// drawtool.h - interface for CDrawTool and derivatives

#ifndef __DRAWTOOL_H__
#define __DRAWTOOL_H__

//#include "drawobj.h"

class CMiniCADView;
#define _CVIEW CMiniCADView
#define _CAPPFILE "../MiniCAD.h"
#define _CVIEWFILE "../MiniCADView.h"
#define _CDOCFILE "../MiniCADDoc.h"

enum DrawToolType
{
	panTool,
	selectTool,
	zoomTool,
	zoomOutTool,
	zoomInTool,
	zoomRectTool,
	fullTool,
	textTool,
	insertTool,
	moveTool,
	rotateTool,
	scaleTool,
	//---------
	pointTool,
	lineTool,
	polyLineTool,
	rectTool,
	polygonTool,
	circleTool,
	arcTool,
	splineTool,
	//---------
	labelCoordTool,
	//---------
	spline_AddPoint_Tool,
	sectionLineTool,
	cutshortTool
};

class CDrawTool
{
// Constructors
public:
	CDrawTool(DrawToolType drawToolType);
	
// Overridables
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
	//virtual void OnEditProperties(_CVIEW* pView);
	//virtual void OnCancel();
public:
	static DrawToolType GetType();
	HCURSOR GetHandleCursor(int nHandle);
// Attributes
//	DrawShape m_drawShape;
	static CDrawTool *c_pCurDrawTool;
	static void SetTool(DrawToolType drawToolType);
	//static CDrawTool* FindTool(DrawShape drawShape);
public:
	static bool c_bJustDraw;// when window is mini
	static bool c_bShift;
	static UINT c_nDown;
	static CPoint c_PtDown;
	static bool c_bRightAngleCorrection;
	static bool c_bSnap;
	static bool c_bMDown;
protected:
	static CPtrList c_tools;
	/*static CPoint c_down;
	static UINT c_nDownFlags;
	static CPoint c_last;*/
	static bool c_bDown;
	static bool c_bHandleSnap;
	static short c_nHandleSnapPixels;
	static CPoint c_PtOld;
//	static CPoint c_PtOrigin;	

	static DrawToolType c_curDrawToolType;
	DrawToolType m_drawToolType;
};

#endif
