#include "stdafx.h"
#include "ArcTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CArcTool::CArcTool()
	: CDrawTool(arcTool)
{

}

void CArcTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		m_PointOrigin=point;
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		pView->m_pTempEntity = new CADArc();
		CADArc* pArc = (CADArc*)pView->m_pTempEntity;
		pView->SetProjectLineWidth(pArc);
		pArc->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		c_PtDown = point;
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			//pArc->pt1=pDoc->m_Graphics.m_curSnapP;
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			ADPOINT adPoint;
			adPoint=pDoc->m_Graphics.ClientToDoc(point);
			//pLine->pt1=adPoint;
		}
		pDC->MoveTo(c_PtDown);
		pDC->LineTo(c_PtDown);
		m_PointOrigin = c_PtDown;
		pDC->SelectObject(pOldPen);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
	}
	if(c_nDown<3)
		c_nDown++;
	if(c_nDown==2)
	{
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&Pen);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);
		pDC->MoveTo(m_PointOrigin);
		pDC->LineTo(point);
		pDC->SelectObject(pOldPen);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
		m_PointSecond=point;
	}
	if(c_nDown==3)
	{
		c_nDown=0;
		CPoint ptCenter;
		long radius;
		circle_3pnts(&m_PointOrigin,&m_PointSecond,&point,&ptCenter,&radius);
		CADArc* pArc = (CADArc*)pView->m_pTempEntity;
		pArc->m_Radius=pDoc->m_Graphics.ClientToDoc(radius);
		pArc->ptCenter=pDoc->m_Graphics.ClientToDoc(ptCenter);
		double angle1 = angleBetween3Pt(ptCenter.x,ptCenter.y,ptCenter.x+100,ptCenter.y,m_PointOrigin.x,m_PointOrigin.y);
		double angle2 = angleBetween3Pt(ptCenter.x,ptCenter.y,ptCenter.x+100,ptCenter.y,point.x,point.y);
		if(IsCounter(m_PointOrigin,m_PointSecond,point))
		{
			pArc->m_StartAng = angle2;
			pArc->m_EndAng = angle1;
		}else
		{
			pArc->m_StartAng = angle1;
			pArc->m_EndAng = angle2;				
		}
		pDoc->m_Graphics.m_Entities.Add((CObject*)pArc);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
		pView->m_pTempEntity = NULL;
		pView->ReBitBlt();
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CArcTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CArcTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if(c_nDown==1)
	{
		pDC->MoveTo(m_PointOrigin);
		pDC->LineTo(c_PtOld);
		pDC->MoveTo(m_PointOrigin);
		pDC->LineTo(point);
	}
	if(c_nDown==2)
	{
		CPoint ptCenter;
		long radius;
		circle_3pnts(&m_PointOrigin,&m_PointSecond,&c_PtOld,&ptCenter,&radius);
		CRect rect;
		rect.SetRect(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
		if(!c_bJustDraw)
		{
			if(IsCounter(m_PointOrigin,m_PointSecond,c_PtOld))
				pDC->Arc(rect,c_PtOld,m_PointOrigin);
			else
				pDC->Arc(rect,m_PointOrigin,c_PtOld);
		}
		c_bJustDraw=false;
		circle_3pnts(&m_PointOrigin,&m_PointSecond,&point,&ptCenter,&radius);
		rect.SetRect(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
		if(IsCounter(m_PointOrigin,m_PointSecond,point))
			pDC->Arc(rect,point,m_PointOrigin);
		else
			pDC->Arc(rect,m_PointOrigin,point);
	}
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CArcTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CArcTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CArcTool::Move(int dx,int dy)
{
	m_PointOrigin.x += dx;
	m_PointOrigin.y += dy;
	m_PointSecond.x += dx;
	m_PointSecond.y += dy;
	CDrawTool::Move(dx,dy);
}