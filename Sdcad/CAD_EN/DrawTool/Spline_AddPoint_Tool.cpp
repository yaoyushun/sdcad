#include "stdafx.h"
#include "Spline_AddPoint_Tool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CSpline_AddPoint_Tool::CSpline_AddPoint_Tool()
	: CDrawTool(spline_AddPoint_Tool)
{

}

void CSpline_AddPoint_Tool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if (pDoc->m_Graphics.m_selectedHandle>0)
	{
		CADSpline* pSpline=(CADSpline*)pDoc->m_Graphics.m_pSelHandleEntity;
		ADPOINT* pPoint=new ADPOINT();
		*pPoint = pDoc->m_Graphics.ClientToDoc(point);
		pSpline->m_FitPoint.InsertAt(pDoc->m_Graphics.m_selectedHandle,(CObject*)pPoint);
		pDoc->m_Graphics.m_selectedHandle+=1;
		pView->ReDraw();
		c_nDown=0;
		DeleteDC(pDC->m_hDC);
		return;
	}
	c_nDown=1;
	pDoc->m_Graphics.SelectGraphics(point);
	pView->ReDraw();
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CSpline_AddPoint_Tool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CSpline_AddPoint_Tool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if (pDoc->m_Graphics.m_GraphicsMode==Layout)
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_B));
	else
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_W));
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CSpline_AddPoint_Tool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CSpline_AddPoint_Tool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	pDoc->m_Graphics.m_selectedHandle=0;
	pDoc->m_Graphics.m_pSelHandleEntity=NULL;
	pView->ReDraw();
}

void CSpline_AddPoint_Tool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}