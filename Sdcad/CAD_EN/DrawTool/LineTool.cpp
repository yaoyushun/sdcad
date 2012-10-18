#include "stdafx.h"
#include "LineTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CLineTool::CLineTool()
	: CDrawTool(lineTool)
{

}

void CLineTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if (c_nDown==0)
	{
//		m_PointOrigin=point;
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		pView->m_pTempEntity = new CADLine();
		CADLine* pLine = (CADLine*)pView->m_pTempEntity;
		pView->SetProjectLineWidth(pLine);
		pLine->m_nLayer = pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			pLine->pt1 = pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		else
			pLine->pt1 = pDoc->m_Graphics.ClientToDoc(point);
		pDC->MoveTo(point);
		pDC->LineTo(point);
		pDC->SelectObject(pOldPen);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject(); 
	}
	if(c_nDown<2)
		c_nDown++;
	if(c_nDown==2)
	{
		c_nDown = 0;
		CADLine *pLine = (CADLine*)pView->m_pTempEntity;
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
			pLine->pt2 = pDoc->m_Graphics.m_curSnapP;
		else
			pLine->pt2 = pDoc->m_Graphics.ClientToDoc(c_PtOld);
		pDoc->m_Graphics.m_Entities.Add((CObject*)pLine);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
		pView->m_pTempEntity = NULL;
		pView->ReBitBlt();
	}
	DeleteDC(pDC->m_hDC);
	c_PtDown = point;
	c_PtOld = point; 
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CLineTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CLineTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
	return;
	CPen* pOldPen = pDC->SelectObject(&Pen);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	if (!c_bJustDraw)
	{
		pDC->MoveTo(c_PtDown);
		pDC->LineTo(c_PtOld);
	}
	c_bJustDraw=false;
	pDC->MoveTo(c_PtDown);
	pDC->LineTo(point);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CLineTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CLineTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CLineTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}