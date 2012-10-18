#include "stdafx.h"
#include "SelectTool.h"

#include _CAPPFILE
#include _CDOCFILE
#include _CVIEWFILE
#include "../DlgTextEdit.h"
//static CSelectTool selectTool;
////////////////////////////////////////////////////////////////////////////////////////
// CSelectTool
int CSelectTool::c_nSelStat = 0;

enum SelectMode
{
	none,
	netSelect,
	move,
	size
};

SelectMode selectMode = none;
int nDragHandle;
////////////////////////////////////////////////////////////////////////////
// CSelectTool

CSelectTool::CSelectTool()
	: CDrawTool(selectTool)
{
	m_nSlectedLine = 0;
}

void CSelectTool::OnLButtonDown(_CVIEW * pView, UINT nFlags, CPoint& point)
{
	//SetCursor(AfxGetApp()->LoadCursor(IDC_SELECT_B));
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	if (pDoc->m_Graphics.m_selectedHandle>0)
	{ 
		CSize size;
		//size.cx = point.x-m_PointOrigin.x;
		//size.cy = point.y-m_PointOrigin.y;			
		size.cx = point.x-c_PtDown.x;
		size.cy = point.y-c_PtDown.y;
		pDoc->m_Graphics.MoveHandleTo(size);
		pView->ReDraw();
		c_nDown=0;
		DeleteDC(pDC->m_hDC);
		return;
	}
	//m_PointOrigin=point;
	//m_nDown=1;
	if (pDoc->m_Graphics.SelectGraphics(point))
		pDoc->m_Graphics.DrawHandle(pDC);

	DeleteDC(pDC->m_hDC);
	CDrawTool::OnLButtonDown(pView, nFlags, point);
}

void CSelectTool::OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	// Don't release capture yet!
/*	if (c_bDown && pView->m_Graphics.m_nSelHandle>0)
	{
		CSize size;
		size.cx = point.x-c_PtDown.x;
		size.cy = point.y-c_PtDown.y;
		pView->m_Graphics.MoveHandleTo(size);
		pView->ReDraw();
	}
	if (c_bDown && pView->m_Graphics.m_nSelHandle==0)
	{
		CSize size;
		size.cx = point.x-c_PtDown.x;
		size.cy = point.y-c_PtDown.y;
		pView->m_Graphics.MoveTo(size);
		pView->ReDraw();
	}*/
	CDrawTool::OnLButtonUp(pView, nFlags, point);
}

void CSelectTool::OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	if(pDoc->m_Graphics.m_GraphicsMode==Layout)
		SetCursor(AfxGetApp()->LoadCursor(IDC_SELECT_B));
	else
		SetCursor(AfxGetApp()->LoadCursor(IDC_SELECT_W));
	if(pDoc->m_Graphics.m_selectedHandle>0)
	{
		if(c_bSnap)
		{
			pDoc->m_Graphics.m_bSnapStatus=true; 
			pDoc->m_Graphics.SnapHandle(pDC,point);
		}
		///SetCursor(AfxGetApp()->LoadCursor(IDC_POINTER));
		CSize size1,size2;
		size1.cx =c_PtOld.x-c_PtDown.x;
		size1.cy =c_PtOld.y-c_PtDown.y;
		size2.cx =point.x-c_PtDown.x;
		size2.cy =point.y-c_PtDown.y;
		if (!c_bJustDraw)
		{
			pDoc->m_Graphics.MoveHandle(pDC,size1);
		}
		c_bJustDraw=false;
		pDoc->m_Graphics.MoveHandle(pDC,size2);
	}	
	DeleteDC(pDC->m_hDC);
	CDrawTool::OnMouseMove(pView, nFlags, point);
}

void CSelectTool::OnLButtonDblClk(_CVIEW* pView, UINT , CPoint& point)
{

}

void CSelectTool::OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point)
{
	CDC* pDC = NULL;
	pDC = pView->GetDC();
	if (pDC == NULL) return;
	CMiniCADDoc* pDoc = pView->GetDocument();
	if (pDoc==NULL)return;
	
	CADEntity *pEntity = NULL;
	pEntity = pDoc->m_Graphics.SelectEntity(point);
	if (pEntity==NULL)return;
	if (pEntity->GetType()==AD_ENT_MTEXT)
	{
		CDlgTextEdit textDlg;
		textDlg.m_pMText = (CADMText *)pEntity;
		textDlg.m_pView = pView;
		textDlg.DoModal();
	}
}

void CSelectTool::Move(int dx,int dy)
{
	CDrawTool::Move(dx,dy);
}