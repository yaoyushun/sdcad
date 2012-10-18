#include "stdafx.h"
#include "SectionLineTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CSectionLineTool::CSectionLineTool()
	: CDrawTool(sectionLineTool)
{

}

void CSectionLineTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	ADPOINT adPoint;
	if(pDoc->m_Graphics.CaptureHole(point,&adPoint))
	{
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		ADPOINT* pPoint=new ADPOINT();
		*pPoint = adPoint;

		if (c_nDown==0)
		{
			pView->m_pTempEntity=new CADPolyline();
			CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
			pPolyline->m_nLineWidth = 3;
			pPolyline->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
			pPolyline->m_Point.Add((CObject*)pPoint);
		}
		else
		{
			CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
			pPolyline->m_Point.Add((CObject*)pPoint);
		}
		c_nDown++;

		CPen* pOldPen = pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);
		if (c_nDown>1)
		{
			pDC->MoveTo(m_PointOrigin);
			pDC->LineTo(point);
		}
		c_PtDown = pDoc->m_Graphics.DocToClient(adPoint);
		if (c_nDown>1)
		{
			pDC->MoveTo(m_PointOrigin);
			pDC->LineTo(c_PtDown);
		}
		c_PtOld = m_PointOrigin = c_PtDown;
		pDC->SetROP2(oldDrawMode);
		pDC->SelectObject(pOldPen);
		Pen.DeleteObject();
	}
	else
	{
		if(c_nDown>0)c_PtDown = m_PointOrigin;
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CSectionLineTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CSectionLineTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if (c_nDown<1)
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

void CSectionLineTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	if (pView->m_pTempEntity==NULL)return;
	CADPolyline* pPolyline = (CADPolyline*)pView->m_pTempEntity;
	if (pPolyline->m_Point.GetSize()<2)return;
	c_nDown = 0;
	pDoc->m_Graphics.CreateSection(pPolyline,pView->m_PaperScale,pView->m_SectionName);
	pView->m_pTempEntity=NULL;
	pView->ReDraw();
}

void CSectionLineTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CSectionLineTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}