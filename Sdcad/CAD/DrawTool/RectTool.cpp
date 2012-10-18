#include "stdafx.h"
#include "RectTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CRectTool::CRectTool()
	: CDrawTool(rectTool)
{

}

void CRectTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
///		c_PtDown=point;
		CPen Pen;
		if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&Pen);
		LOGBRUSH logBrush;
		logBrush.lbColor = 0;
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_NULL;
		CBrush NullBrush;
		NullBrush.CreateBrushIndirect(&logBrush);
		CBrush* pOldBrush = pDC->SelectObject(&NullBrush);

		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		pView->m_pTempEntity=new CADPolyline();
		CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
		pView->SetProjectLineWidth(pPolyline);
		pPolyline->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		pPolyline->m_Closed=true; 
		if(c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			ADPOINT* pPoint=new ADPOINT();
			*pPoint = pDoc->m_Graphics.m_curSnapP;
			pPolyline->m_Point.Add((CObject*)pPoint);
			c_PtDown = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
			c_PtOld = point;
		}else
		{
			ADPOINT* pPoint=new ADPOINT();
			*pPoint = pDoc->m_Graphics.ClientToDoc(point);
			pPolyline->m_Point.Add((CObject*)pPoint);
			c_PtDown = point;
			c_PtOld = point;
		}
		pDC->Rectangle(point.x,point.y,point.x,point.y);
		pDC->SetROP2(oldDrawMode);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
		Pen.DeleteObject();
	}
	if (c_nDown<2)
		c_nDown++;
	if (c_nDown==2)
	{
		c_nDown=0;
		ADPOINT adPoint;
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			adPoint=pDoc->m_Graphics.m_curSnapP;
		}else
		{

			adPoint=pDoc->m_Graphics.ClientToDoc(point);
		}
		CADPolyline* pPolyline=(CADPolyline*)pView->m_pTempEntity;
		ADPOINT* pPoint1=(ADPOINT*)pPolyline->m_Point.GetAt(0);
		ADPOINT* pPoint=new ADPOINT();
		pPoint->x = adPoint.x;
		pPoint->y = pPoint1->y;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		*pPoint = adPoint;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = pPoint1->x;
		pPoint->y = adPoint.y;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pDoc->m_Graphics.m_Entities.Add((CObject*)pPolyline);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pView->m_pTempEntity);
		pView->m_pTempEntity=NULL;
		pView->ReBitBlt();
	}
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CRectTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CRectTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	if (c_nDown!=1)
	{
		DeleteDC(pDC->m_hDC);
		return;
	}

	CPen Pen;
	if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
	return;
	CPen* pOldPen = pDC->SelectObject(&Pen);
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	CBrush NullBrush;
	NullBrush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush = pDC->SelectObject(&NullBrush);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	if (!c_bJustDraw)
		pDC->Rectangle(c_PtDown.x,c_PtDown.y,c_PtOld.x,c_PtOld.y);
	c_bJustDraw = false;
	pDC->Rectangle(c_PtDown.x,c_PtDown.y,point.x,point.y);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
	Pen.DeleteObject(); 

	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CRectTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CRectTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CRectTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}