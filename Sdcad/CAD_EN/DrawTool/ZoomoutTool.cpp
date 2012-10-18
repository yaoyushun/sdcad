#include "stdafx.h"
#include "../ShapeView.h"
#include "ZoomoutTool.h"
#include "../ShapeViewDoc.h"
#include "../ShapeViewView.h"

////////////////////////////////////////////////////////////////////////////////////////
// CZoomoutTool

CZoomoutTool::CZoomoutTool()
	: CDrawTool(zoomOutTool)
{

}

void CZoomoutTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	::SetCursor(AfxGetApp()->LoadCursor(IDC_ZOOMOUT));
	CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CZoomoutTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->m_pDC;
	if (pDC == NULL) return;

	CRect newRect(c_PtDown,point);
	CPen Pen;
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(0,0,0)))
	return;
	CPen *pOldPen = pDC->SelectObject(&Pen);
	int oldDrawMode = pDC->SetROP2(R2_NOT);
	pDC->SelectStockObject(NULL_BRUSH);
	pDC->Rectangle(newRect);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();

	int cx = abs(point.x - c_PtDown.x);
	int cy = abs(point.y - c_PtDown.y);
	if (cx<5 && cy<5)
	{
		pView->m_Graphics.ZoomAtPoint(&c_PtDown,0.8);			
		pView->Refresh();
	}
	else
	{
		pView->m_Graphics.ZoomOutAtExtent(&c_PtDown,&point);
		pView->Refresh();
	}
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CZoomoutTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	::SetCursor(AfxGetApp()->LoadCursor(IDC_ZOOMOUT));
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	if (!c_bDown)
	{
		DeleteDC(pDC->m_hDC);
		return;
	}

	CRect oldRect(c_PtDown,c_PtOld);
	CRect newRect(c_PtDown,point);
	//CRect TrackRect;
	//	TrackRect.SetRect(m_StartPoint,point);
	CPen Pen;
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(0,0,0)))
	return;
	CPen *pOldPen = pDC->SelectObject(&Pen);
	//int oldDrawMode = m_pDC->SetROP2(R2_XORPEN);
	int oldDrawMode = pDC->SetROP2(R2_NOT);
	pDC->SelectStockObject(NULL_BRUSH);
	pDC->Rectangle(oldRect);
	pDC->Rectangle(newRect);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CZoomoutTool::OnLButtonDblClk(_CVIEW* pView, UINT , CPoint& )
{

}

void CZoomoutTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}
