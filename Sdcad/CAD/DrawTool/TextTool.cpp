#include "stdafx.h"
#include "TextTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE
#include "../DlgTextEdit.h"
////////////////////////////////////////////////////////////////////////////////////////
// CTextTool

CTextTool::CTextTool()
	: CDrawTool(textTool)
{

}

void CTextTool::OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point)
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
		pDC->SelectObject(&Pen);
		LOGBRUSH logBrush;
		logBrush.lbColor = 0;
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_NULL;
		CBrush NullBrush;
		NullBrush.CreateBrushIndirect(&logBrush);
		pDC->SelectObject(&NullBrush);
		int oldDrawMode = pDC->SetROP2(R2_XORPEN);

		if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			m_PointOrigin=pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}
		pDC->Rectangle(m_PointOrigin.x,m_PointOrigin.y,m_PointOrigin.x,m_PointOrigin.y);
		pDC->SetROP2(oldDrawMode);
		Pen.DeleteObject();
	}
	if (c_nDown<2)
		c_nDown++;
	if (c_nDown==2)
	{
		c_nDown=0;
		/*if (c_bSnap && pDoc->m_Graphics.m_bHaveSnap)
		{
			m_PointOrigin=pDoc->m_Graphics.DocToClient(pDoc->m_Graphics.m_curSnapP);
		}else
		{
			m_PointOrigin=point;
		}*/
		pView->ReDraw();
		CADMText* pMText=new CADMText();
		pDoc->m_Graphics.m_Entities.Add((CObject *)pMText);
		//pView->m_pTempEntity=pMText;
		pMText->m_nLayer = pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		pMText->m_Location=pDoc->m_Graphics.ClientToDoc(m_PointOrigin);
		pMText->m_Height=2.5;
		pMText->m_Width=20;
		CDlgTextEdit textDlg;
		textDlg.m_pMText = pMText;
		textDlg.m_pView = pView;
		if(textDlg.DoModal()!=IDOK)
		{
			//delete pView->m_pTempEntity;
			//pView->m_pTempEntity=NULL;
		}
	}

	c_PtOld = point;
	DeleteDC(pDC->m_hDC);
}

void CTextTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	// Don't release capture yet!

	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CTextTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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
	CBrush NullBrush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	NullBrush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush = pDC->SelectObject(&NullBrush);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	pDC->Rectangle(m_PointOrigin.x,m_PointOrigin.y,c_PtOld.x,c_PtOld.y);
	pDC->Rectangle(m_PointOrigin.x,m_PointOrigin.y,point.x,point.y);
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
