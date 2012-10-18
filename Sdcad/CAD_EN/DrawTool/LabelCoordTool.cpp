#include "stdafx.h"
#include "LabelCoordTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CLabelCoordTool::CLabelCoordTool()
	: CDrawTool(labelCoordTool)
{

}

void CLabelCoordTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
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
		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
			m_PointOrigin = pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		c_PtOld = m_PointOrigin;
		pDC->MoveTo(m_PointOrigin);
		pDC->LineTo(m_PointOrigin);
		CSize size(pDoc->m_Graphics.DocToClient((double)(AD_LABELLENGTH*pView->m_PaperScale)/1000),0);
		pDC->LineTo(m_PointOrigin + size);
		pDC->SelectObject(pOldPen);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject(); 
	}
	if (c_nDown<2)
		c_nDown++;
	if (c_nDown==2)
	{
		c_nDown = 0;
		short curLayerIndex = pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		CADLine* pLine = new CADLine();
		pDoc->m_Graphics.m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1 = pDoc->m_Graphics.ClientToDoc(m_PointOrigin);
		pLine->pt2 = pDoc->m_Graphics.ClientToDoc(c_PtOld);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pLine);

		CADMText* pMText=new CADMText();
		pDoc->m_Graphics.m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text.Format("Y = %.4lf",pLine->pt1.x);
		//strcpy(pMText->m_Font,"ºÚÌå");
		pMText->m_Height = 2.5*pView->m_PaperScale/1000;
		if (m_PointOrigin.x <= c_PtOld.x)
		{
			pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMLEFT;
			pMText->m_Location.x = pLine->pt2.x;
			pMText->m_Location.y = pLine->pt2.y;
		}
		else
		{
			pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
			pMText->m_Location.x = pLine->pt2.x;
			pMText->m_Location.y = pLine->pt2.y;
		}
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pMText);

		pMText=new CADMText();
		pDoc->m_Graphics.m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text.Format("X = %.4lf",pLine->pt1.y);
		//strcpy(pMText->m_Font,"ºÚÌå");
		pMText->m_Height = 2.5*pView->m_PaperScale/1000;
		if (m_PointOrigin.x <= c_PtOld.x)
		{
			pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
			pMText->m_Location.x = pLine->pt2.x;
			pMText->m_Location.y = pLine->pt2.y;
		}
		else
		{
			pMText->m_Align = AD_MTEXT_ATTACH_TOPRIGHT;
			pMText->m_Location.x = pLine->pt2.x;
			pMText->m_Location.y = pLine->pt2.y;
		}
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pMText);

		pLine = new CADLine();
		pDoc->m_Graphics.m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1 = pDoc->m_Graphics.ClientToDoc(c_PtOld);
		pLine->pt2 = pLine->pt1;
		if (m_PointOrigin.x <= c_PtOld.x)
			pLine->pt2.x += (double)(AD_LABELLENGTH*pView->m_PaperScale)/1000;
		else
			pLine->pt2.x -= (double)(AD_LABELLENGTH*pView->m_PaperScale)/1000;
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pLine);
		pView->ReBitBlt();
	}

	//c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CLabelCoordTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CLabelCoordTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	int	oldDrawMode = pDC->SetROP2(R2_XORPEN);
	//1.erase old shape(if view was just refresh then don't erase)
	//2.draw new shape
	CSize size(pDoc->m_Graphics.DocToClient((double)(AD_LABELLENGTH*pView->m_PaperScale)/1000),0);
	if (!c_bJustDraw) 
	{
		pDC->MoveTo(m_PointOrigin);
		pDC->LineTo(c_PtOld);
		if (m_PointOrigin.x <= c_PtOld.x)
		{
			pDC->LineTo(c_PtOld + size);
		}
		else
		{
			pDC->LineTo(c_PtOld - size);
		}
	}
	else
		c_bJustDraw=false;
	pDC->MoveTo(m_PointOrigin);
	pDC->LineTo(point);
	
	if (m_PointOrigin.x <= point.x)
		pDC->LineTo(point + size);
	else
		pDC->LineTo(point - size);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	Pen.DeleteObject();

	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CLabelCoordTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CLabelCoordTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CLabelCoordTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}