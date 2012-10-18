#include "stdafx.h"
#include "RotateTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CRotateTool::CRotateTool()
	: CDrawTool(rotateTool)
{

}

void CRotateTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if(c_nDown==0)
	{
		m_PointOrigin=point;
		CPen Pen;
		if (!Pen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;
		pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		c_PtDown = point;
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			c_PtDown=pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		pDC->MoveTo(c_PtDown);
		pDC->LineTo(c_PtDown);
		m_PointOrigin = c_PtDown;
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
	}
	if(c_nDown<2)
		c_nDown++;
	if(c_nDown==2)
	{
		c_nDown=0;
		c_PtDown = point;
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			c_PtDown=pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		pDoc->m_Graphics.RotateEntitiesTo(m_PointOrigin,c_PtDown);
		pView->ReDraw();
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CRotateTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CRotateTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if(pDoc->m_Graphics.m_GraphicsMode==Layout)
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_B));
	else
		SetCursor(AfxGetApp()->LoadCursor(IDC_DRAW_W));
	if(c_bSnap)
	{
		pDoc->m_Graphics.m_bSnapStatus=true;
		pDoc->m_Graphics.SnapHandle(pDC,point);
	}
	if(c_nDown!=1)
	{
		DeleteDC(pDC->m_hDC);
		return;
	}

	CPen Pen;
	if (!Pen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
	return;
	CPen* pOldPen = pDC->SelectObject(&Pen);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	if(!c_bJustDraw)
	{
		pDC->MoveTo(c_PtDown);
		pDC->LineTo(c_PtOld);
	}
	pDC->MoveTo(c_PtDown);
	pDC->LineTo(point);
	if(!c_bJustDraw)
		pDoc->m_Graphics.RotateEntities(pDC,c_PtDown,c_PtOld);
	c_bJustDraw=false;
	pDoc->m_Graphics.RotateEntities(pDC,c_PtDown,point);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CRotateTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CRotateTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CRotateTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}