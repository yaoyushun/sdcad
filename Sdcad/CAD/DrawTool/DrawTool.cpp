#include "stdafx.h"
#include "drawtool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

/////////////////////////////////////////////////////////////////////////////
// CDrawTool implementation
#include "PanTool.h"
#include "PointTool.h"
#include "LineTool.h"
#include "PolyLineTool.h"
#include "SelectTool.h"
#include "RectTool.h"
#include "SplineTool.h"
#include "ArcTool.h"
#include "CircleTool.h"
#include "MoveTool.h"
#include "RotateTool.h"
#include "Spline_AddPoint_Tool.h"
#include "InsertTool.h"
#include "SectionLineTool.h"
#include "LabelCoordTool.h"
#include "TextTool.h"
//#include "ZoominTool.h"
//#include "ZoomoutTool.h"

CPtrList CDrawTool::c_tools; //this a global variable

static CSelectTool SelectTool;
static CPanTool PanTool;
static CPointTool PointTool;
static CLineTool LineTool;
static CPolyLineTool PolyLineTool;
static CRectTool RectTool;
static CSplineTool SplineTool;
static CArcTool ArcTool;
static CCircleTool CircleTool;
static CMoveTool MoveTool;
static CRotateTool RotateTool;
static CSpline_AddPoint_Tool Spline_AddPoint_Tool;
static CInsertTool InsertTool;
static CSectionLineTool SectionLineTool;
static CLabelCoordTool LabelCoordTool;
static CTextTool TextTool;
//static CZoominTool ZoominTool;
//static CZoomoutTool ZoomoutTool;


bool CDrawTool::c_bSnap = false;
bool CDrawTool::c_bDown = false;
bool CDrawTool::c_bJustDraw = false;
bool CDrawTool::c_bHandleSnap = true;
short CDrawTool::c_nHandleSnapPixels = 6;
bool CDrawTool::c_bRightAngleCorrection = false;
bool CDrawTool::c_bMDown = false;

UINT CDrawTool::c_nDown = 0;
CPoint CDrawTool::c_PtDown;
CPoint CDrawTool::c_PtOld;
//CPoint CDrawTool::c_PtOrigin;
//int CSelectTool::c_nSelStat = 0;
bool CDrawTool::c_bShift = false;
DrawToolType GetType();
//short CDrawTool::c_nSelEntityType = -1;
//CADEntity *CSelectTool::m_pSelEntity = NULL;

//DrawToolType CDrawTool::c_curDrawToolType = HUSELECT;
DrawToolType CDrawTool::c_curDrawToolType = panTool;
CDrawTool *CDrawTool::c_pCurDrawTool = &PanTool;

CDrawTool::CDrawTool(DrawToolType drawToolType)
{
	m_drawToolType = drawToolType;
	c_tools.AddTail(this);
}
/*
CDrawTool* CDrawTool::FindTool(DrawShape drawShape)
{
	POSITION pos = c_tools.GetHeadPosition();
	while (pos != NULL)
	{
		CDrawTool* pTool = (CDrawTool*)c_tools.GetNext(pos);
		if (pTool->m_drawShape == drawShape)
		{
			m_pCurDrawTool = pTool;
			break;
		}
	}
}*/

void CDrawTool::SetTool(DrawToolType drawToolType)
{
	POSITION pos = c_tools.GetHeadPosition();
	while (pos != NULL)
	{
		CDrawTool* pTool = (CDrawTool*)c_tools.GetNext(pos);
		if (pTool->m_drawToolType == drawToolType)
		{
			c_pCurDrawTool = pTool;
			c_nDown = 0;
			c_bJustDraw = false;
			c_bDown = false;
			break;
		}
	}	
}

DrawToolType CDrawTool::GetType()
{
/*	POSITION pos = c_tools.GetHeadPosition();
	while (pos != NULL)
	{
		CDrawTool* pTool = (CDrawTool*)c_tools.GetNext(pos);
		if (pTool->m_drawToolType == drawToolType)
		{
			c_pCurDrawTool = pTool;
			c_nDown = 0;
			c_bJustDraw = false;
			break;
		}
	}	*/
	if (c_pCurDrawTool==NULL)return c_curDrawToolType;
	return c_pCurDrawTool->m_drawToolType;
}

void CDrawTool::OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	// deactivate any in-place active item on this view!
/*	COleClientItem* pActiveItem = pView->GetDocument()->GetInPlaceActiveItem(pView);
	if (pActiveItem != NULL)
	{
		pActiveItem->Close();
		ASSERT(pView->GetDocument()->GetInPlaceActiveItem(pView) == NULL);
	}

	pView->SetCapture();
	c_nDownFlags = nFlags;*/
	c_PtDown = point;
	c_PtOld = point;
	c_bDown = true;
	c_nDown++;
}

void CDrawTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CDrawTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	ReleaseCapture();
	c_bDown = false;
/*	if (point == c_down)
		c_drawShape = selection;*/
}

void CDrawTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	if (c_nDown>0)
		c_PtOld = point;
//	SetCursor(AfxGetApp()->LoadStandardCursor(IDC_ARROW));
}

void CDrawTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

HCURSOR CDrawTool::GetHandleCursor(int nHandle)
{
//	ASSERT_VALID(this);

	LPCTSTR id;
	switch (nHandle)
	{
	default:
		ASSERT(FALSE);

	case 1:
	case 5:
		id = IDC_SIZENWSE;
		break;

	case 2:
	case 6:
		id = IDC_SIZENS;
		break;

	case 3:
	case 7:
		id = IDC_SIZENESW;
		break;

	case 4:
	case 8:
		id = IDC_SIZEWE;
		break;
	}

	return AfxGetApp()->LoadStandardCursor(id);
}

void CDrawTool::Move(int dx,int dy)
{
	c_PtDown.x += dx;
	c_PtDown.y += dy;
	c_PtOld.x += dx;
	c_PtOld.y += dy;
}