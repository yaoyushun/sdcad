#include "stdafx.h"
#include "TextTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

////////////////////////////////////////////////////////////////////////////////////////
// CTextTool

CTextTool::CTextTool()
	: CDrawTool(textTool)
{

}

void CTextTool::OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point)
{
//	try
//	{
		CDC* pDC = NULL;
		pDC = pView->GetDC();
		if (pDC == NULL) return;
		if (c_nDown==0)
		{
			CPen Pen;
			if (!Pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
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

			pDC->Rectangle(point.x,point.y,point.x,point.y);
			pDC->SetROP2(oldDrawMode);
			Pen.DeleteObject();
		}
		if (c_nDown<2)
			c_nDown++;
		if (c_nDown==2)
		{
			c_nDown = 0;
			/*if (m_bSnap && pView->m_Graphics.m_bHaveSnap)
			{
				m_PointOrigin=pView->m_Graphics.DocToClient(pView->m_Graphics.m_curSnapP);
			}else
			{
				m_PointOrigin=point;
			}*/
			pView->ReDraw();

/*			CADMText* pMText = new CADMText();
			pView->m_pTempEntity = pMText;
			pMText->m_nLayer = 0;
			pMText->m_Location = pView->m_Graphics.ClientToDoc(c_PtDown);
			pMText->m_Height = 2.5;
			pMText->m_Width = 20;*/

/*			CDlgTextEdit textDlg;
			textDlg.m_pChartEditCtrl = pView;
			if (textDlg.DoModal()!=IDOK)
			{
				//delete pView->m_pTempEntity;
				//pView->m_pTempEntity=NULL;
			}
			else
			{
				//pView->m_Graphics.m_Entities.Add((CObject*)pMText);
				//pView->ReDraw(); 
				//pView->Invalidate(false);
			}*/
		}
		c_PtDown = point;
		c_PtOld = point;
		DeleteDC(pDC->m_hDC);
//	}
//	finally
}

void CTextTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	// Don't release capture yet!

	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CTextTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
/*	if(m_bSnap)
	{
		pView->m_Graphics.m_bSnapStatus=true; 
		pView->m_Graphics.SnapHandle(pDC,point);
	}*/
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
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
	{
		pDC->Rectangle(c_PtDown.x,c_PtDown.y,c_PtOld.x,c_PtOld.y);
	}
	c_bJustDraw = false;
	pDC->Rectangle(c_PtDown.x,c_PtDown.y,point.x,point.y);
	pDC->SetROP2(oldDrawMode);
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
	Pen.DeleteObject();
	NullBrush.DeleteObject();
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CTextTool::OnLButtonDblClk(_CVIEW* pView, UINT , CPoint& )
{

}

void CTextTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}
