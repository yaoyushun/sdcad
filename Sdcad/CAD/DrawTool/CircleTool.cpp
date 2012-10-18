#include "stdafx.h"
#include "CircleTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CCircleTool::CCircleTool()
	: CDrawTool(circleTool)
{

}

void CCircleTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		CPen Pen;
		if (!Pen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;
		pDC->SelectObject(&Pen);
		LOGBRUSH logBrush;
		logBrush.lbColor = 0;
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_NULL;
		CBrush NullBrush;
		NullBrush.CreateBrushIndirect(&logBrush);
		pDC->SelectObject(&NullBrush);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		pView->m_pTempEntity=new CADCircle();
		CADCircle* pCircle=(CADCircle*)pView->m_pTempEntity;
		pCircle->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			pCircle->ptCenter=pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			ADPOINT adPoint;
			adPoint=pDoc->m_Graphics.ClientToDoc(point);
			pCircle->ptCenter=adPoint;
			c_PtDown = point;
		}
		pDoc->m_Graphics.Circle(pDC,c_PtDown,c_PtDown);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
	}
	if(c_nDown<2)
		c_nDown++;
	if(c_nDown==2)
	{
		c_nDown=0;
		CADCircle* pCircle=(CADCircle*)pView->m_pTempEntity;
		ADPOINT adPoint;
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
			adPoint=pDoc->m_Graphics.m_curSnapP;
		else
			adPoint=pDoc->m_Graphics.ClientToDoc(c_PtOld);
		pCircle->m_Radius=pDoc->m_Graphics.Distance(pCircle->ptCenter,adPoint);
		pDoc->m_Graphics.m_Entities.Add((CObject*)pCircle);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
		pView->m_pTempEntity=NULL;
		pView->ReBitBlt();
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CCircleTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CCircleTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if(c_nDown<1)
	{
		DeleteDC(pDC->m_hDC);
		return;
	}
	
	CPen Pen;
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
	return;
	CPen* pOldPen = pDC->SelectObject(&Pen);
	CBrush NullBrush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	//CBrush NullBrush;
	NullBrush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush = pDC->SelectObject(&NullBrush);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	if(!c_bJustDraw)
		pDoc->m_Graphics.Circle(pDC,c_PtDown,c_PtOld);
	c_bJustDraw = false;
	pDoc->m_Graphics.Circle(pDC,c_PtDown,point);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CCircleTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CCircleTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CCircleTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}