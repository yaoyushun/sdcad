#include "stdafx.h"
#include "MoveTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CMoveTool::CMoveTool()
	: CDrawTool(moveTool)
{

}

void CMoveTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		c_PtDown=point;
		CPen Pen;
		if (!Pen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;
		pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);
		
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		m_PointOrigin = c_PtDown;
		pDC->MoveTo(c_PtDown);
		pDC->LineTo(c_PtDown);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
	}
	if(c_nDown<2)
		c_nDown++;
	if(c_nDown==2)
	{
		c_nDown=0;
		c_PtDown=point;
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		CSize size1;
		size1.cx = c_PtDown.x-m_PointOrigin.x;
		size1.cy = c_PtDown.y-m_PointOrigin.y;
		pDoc->m_Graphics.MoveEntitiesTo(size1);
		pView->ReDraw();
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CMoveTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CMoveTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	CSize size1,size2;
	size1.cx =c_PtOld.x-c_PtDown.x;
	size1.cy =c_PtOld.y-c_PtDown.y;
	size2.cx =point.x-c_PtDown.x;
	size2.cy =point.y-c_PtDown.y;
	if(!c_bJustDraw)
	{
		pDoc->m_Graphics.MoveEntities(pDC,size1);
	}
	c_bJustDraw=false;
	pDoc->m_Graphics.MoveEntities(pDC,size2);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CMoveTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CMoveTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CMoveTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}