#include "stdafx.h"
#include "SplineTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CSplineTool::CSplineTool()
	: CDrawTool(splineTool)
{

}

void CSplineTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		pView->m_pTempEntity=new CADSpline();
		CADSpline* pSpline=(CADSpline*)pView->m_pTempEntity;
		pView->SetProjectLineWidth(pSpline);
		pSpline->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);

		ADPOINT* pPoint=new ADPOINT();
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			*pPoint = pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			*pPoint = pDoc->m_Graphics.ClientToDoc(point);
			c_PtDown = point;
		}
		pSpline->m_FitPoint.Add((CObject*)pPoint);
	}
	else
	{
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		pDC->MoveTo(c_PtDown);
		
		CADSpline* pSpline = (CADSpline*)pView->m_pTempEntity;
		ADPOINT* pPoint = new ADPOINT();
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			*pPoint = pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			*pPoint = pDoc->m_Graphics.ClientToDoc(point);
			c_PtDown = point;
		}
		if (c_nDown==1)
		{
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint = new ADPOINT();
			*pPoint = pDoc->m_Graphics.ClientToDoc(c_PtDown);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pDoc->m_Graphics.DrawSpline(pDC,pSpline);
		}
		else
		{
			ADPOINT* pPoint2=(ADPOINT*)pSpline->m_FitPoint.GetAt(pSpline->m_FitPoint.GetSize()-1);
			*pPoint2 = pDoc->m_Graphics.ClientToDoc(point);
			pDoc->m_Graphics.DrawSpline(pDC,pSpline);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pDoc->m_Graphics.DrawSpline(pDC,pSpline);
		}
		pDC->LineTo(point);
		pDC->SetROP2(oldDrawMode);
		pDC->SelectObject(pOldPen);
		Pen.DeleteObject();
	}
	c_nDown++;
	//m_PointOrigin=point;
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CSplineTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CSplineTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if (c_bSnap)
	{
		pDoc->m_Graphics.m_bSnapStatus=true; 
		pDoc->m_Graphics.SnapHandle(pDC,point);
	}
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

	if(c_nDown>1)
	{
		CADSpline* pSpline=(CADSpline*)pView->m_pTempEntity;
		int i=pSpline->m_FitPoint.GetSize();
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(pSpline->m_FitPoint.GetSize()-1);
		ADPOINT* pPoint2=(ADPOINT*)pSpline->m_FitPoint.GetAt(pSpline->m_FitPoint.GetSize()-2);
		if (!c_bJustDraw)
		{
			*pPoint = pDoc->m_Graphics.ClientToDoc(c_PtOld);					
			pDoc->m_Graphics.DrawSpline(pDC,pSpline);
		}

		*pPoint = pDoc->m_Graphics.ClientToDoc(point);				
		pDoc->m_Graphics.DrawSpline(pDC,pSpline);
	}

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

void CSplineTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	if (pView->m_pTempEntity!=NULL && c_nDown>1)
	{
		CMiniCADDoc* pDoc = pView->GetDocument();
		if (pDoc==NULL)return;
		CADGraphics	*pGraphics = &pDoc->m_Graphics;
		CDisplay *pDisplay = pGraphics->m_pDisplay;
		if (pDisplay == NULL) return;
		c_nDown=0;
		CADSpline* pSpline=(CADSpline*)pView->m_pTempEntity;
		pDoc->m_Graphics.m_Entities.Add((CObject*)pView->m_pTempEntity);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
		pView->m_pTempEntity=NULL;
		pView->ReBitBlt();
	}
}

void CSplineTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CSplineTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}