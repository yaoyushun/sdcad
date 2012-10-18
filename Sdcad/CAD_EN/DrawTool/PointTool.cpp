#include "stdafx.h"
#include "PointTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CPointTool::CPointTool()
	: CDrawTool(pointTool)
{

}

void CPointTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;
	CADPoint* pPoint;
	pPoint=new CADPoint();
	ADPOINT adPoint=pDoc->m_Graphics.ClientToDoc(point);
	pPoint->pt=adPoint;
	pPoint->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
	pDoc->m_Graphics.m_Entities.Add((CObject*)pPoint);
	pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pPoint);
	pView->ReBitBlt();
	CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CPointTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CPointTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	if(pDoc->m_Graphics.m_GraphicsMode==Layout)
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_B));
	else
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_W));
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CPointTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CPointTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CPointTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}