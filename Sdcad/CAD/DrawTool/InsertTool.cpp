#include "stdafx.h"
#include "InsertTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE

CInsertTool::CInsertTool()
	: CDrawTool(insertTool)
{

}

void CInsertTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	CADGraphics	*pGraphics = &pDoc->m_Graphics;
	CDisplay *pDisplay = pGraphics->m_pDisplay;
	if (pDisplay == NULL) return;

	pDoc->m_Graphics.m_isDrawMText=true;
	CADInsert* pInsert;
	//pInsert=pDoc->m_Graphics.m_pTempInsert;
	pInsert = (CADInsert*)pView->m_pTempEntity;
	if(pInsert)
	{
		ADPOINT BasePoint;
		BasePoint=pDoc->m_Graphics.ClientToDoc(point);
		pInsert->pt=BasePoint;
		pDoc->m_Graphics.m_Entities.Add((CObject*)pInsert);
		pDoc->m_Graphics.DrawGraphics(pDisplay->GetDC(),pInsert);
		//ReBitBlt();
		pDC->BitBlt(0,0,pDisplay->GetWidth(),pDisplay->GetHeight(),pDisplay->GetDC(),0,0,SRCCOPY);
		c_bJustDraw=true;
		CADInsert* pInsert2 = new CADInsert();
		//pDoc->m_Graphics.m_pTempInsert = pInsert2;
		pView->m_pTempEntity = pInsert2;
		pInsert2->m_nLayer = pInsert->m_nLayer;
		strcpy(pInsert2->m_Name , pInsert->m_Name);
		pInsert2->m_xScale = pInsert->m_xScale;
		pInsert2->m_yScale = pInsert->m_yScale;
		pInsert2->m_Rotation = pInsert->m_Rotation;
		//pDoc->m_Graphics.m_pTempInsert=NULL;
		//ReDraw();
		//m_curDrawTool=selectTool;
	}
	c_PtOld = c_PtDown;
	DeleteDC(pDC->m_hDC);
	//CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CInsertTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CInsertTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
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

	if (!c_bDown)return;
	pDoc->m_Graphics.m_isDrawMText=false;
	CADInsert* pInsert;
	//pInsert = pDoc->m_Graphics.m_pTempInsert;
	pInsert = (CADInsert*)pView->m_pTempEntity;
	if(pInsert==NULL)
	{
		//ReleaseDC(pDC);
		DeleteDC(pDC->m_hDC);
		return;
	}
	int oldDrawMode;
	if(pDoc->m_Graphics.m_GraphicsMode==Layout)
		oldDrawMode = pDC->SetROP2(R2_NOTXORPEN);
	else
		oldDrawMode = pDC->SetROP2(R2_XORPEN);
	ADPOINT BasePoint;
	if (!c_bJustDraw)
	{
		if (c_bSnap)
		{
			pDoc->m_Graphics.m_bSnapStatus=false;
		}
		BasePoint = pDoc->m_Graphics.ClientToDoc(c_PtOld);
		pInsert->pt = BasePoint;
		pDoc->m_Graphics.DrawInsert(pDC,pInsert); 
	}
	c_bJustDraw=false;
	BasePoint=pDoc->m_Graphics.ClientToDoc(point);
	pInsert->pt=BasePoint;
	pDoc->m_Graphics.DrawInsert(pDC,pInsert);
	pDC->SetROP2(oldDrawMode);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CInsertTool::OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point)
{

}

void CInsertTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDrawTool::SetTool(selectTool);
	pView->ReBitBlt();
}

void CInsertTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}