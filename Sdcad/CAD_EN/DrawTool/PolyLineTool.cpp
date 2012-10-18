#include "stdafx.h"
#include "PolyLineTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CPolyLineTool::CPolyLineTool()
	: CDrawTool(polyLineTool)
{

}

void CPolyLineTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		pView->m_pTempEntity=new CADPolyline();
		CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
		pView->SetProjectLineWidth(pPolyline);
		pPolyline->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		ADPOINT* pPoint=new ADPOINT();
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			*pPoint = pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			*pPoint = pDoc->m_Graphics.ClientToDoc(point);
		}
		pPolyline->m_Point.Add((CObject*)pPoint);
	}
	else
	{
		CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
		ADPOINT* pPoint=new ADPOINT();
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			*pPoint = pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			*pPoint = pDoc->m_Graphics.ClientToDoc(point);
		}
		pPolyline->m_Point.Add((CObject*)pPoint);
	}
	c_nDown++;
	if(c_nDown == 2)pDoc->m_Graphics.m_Entities.Add((CObject*)pView->m_pTempEntity);
	CPen Pen;
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
	return;
	CPen* pOldPen = pDC->SelectObject(&Pen);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	pDC->MoveTo(c_PtDown);
	pDC->LineTo(c_PtDown);
//	m_PointOrigin = c_PtDown;
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	c_PtDown = point;
	c_PtOld = point;
//	CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CPolyLineTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CPolyLineTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	if(!c_bJustDraw)
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

void CPolyLineTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	if (pView->m_pTempEntity!=NULL)
	{
		c_nDown=0;
		CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap && pPolyline->m_Point.GetSize()==3)
		{
			ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);
			if(pPoint->x==pDoc->m_Graphics.m_curSnapP.x && pPoint->y==pDoc->m_Graphics.m_curSnapP.y)
			{
				pPolyline->m_Point.RemoveAt(pPolyline->m_Point.GetSize()-1);
			}					
		}
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap && pPolyline->m_Point.GetSize()>3)
		{
			ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);
			if(pPoint->x==pDoc->m_Graphics.m_curSnapP.x && pPoint->y==pDoc->m_Graphics.m_curSnapP.y)
			{
				pPolyline->m_Point.RemoveAt(pPolyline->m_Point.GetSize()-1);
				pPolyline->m_Closed=true;
			}
		}
		if (pView->m_pTempEntity != NULL)
		{
			pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
			pView->m_pTempEntity=NULL;
			pView->ReBitBlt();
		}
		//ReDraw();
	}
}

void CPolyLineTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CPolyLineTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}