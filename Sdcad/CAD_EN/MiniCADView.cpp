// MiniCADView.cpp : implementation of the CMiniCADView class
//

#include "stdafx.h"
#include "MiniCAD.h"

#include "MiniCADDoc.h"
#include "MiniCADView.h"
#include "MainFrm.h"
#include "InsertBlockDlg.h"
#include "DlgTextEdit.h"
#include "InsertHoleLayerDlg.h"
#include "Dlg_PaperSetup.h"
#include "DlgLayerAdmin.h"
#include "DlgSection.h"
#include "DlgCompass.h"
#include "DlgEntityProperty.h"
#include "DrawTool/DrawTool.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView

IMPLEMENT_DYNCREATE(CMiniCADView, CView)

BEGIN_MESSAGE_MAP(CMiniCADView, CView)
	//{{AFX_MSG_MAP(CMiniCADView)
	ON_WM_LBUTTONDOWN()
	ON_COMMAND(ID_PAN, OnPan)
	ON_UPDATE_COMMAND_UI(ID_PAN, OnUpdatePan)
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_COMMAND(ID_SELECT, OnSelect)
	ON_UPDATE_COMMAND_UI(ID_SELECT, OnUpdateSelect)
	ON_COMMAND(ID_ZOOM, OnZoom)
	ON_UPDATE_COMMAND_UI(ID_ZOOM, OnUpdateZoom)
	ON_WM_ERASEBKGND()
	ON_COMMAND(ID_SNAP, OnSnap)
	ON_UPDATE_COMMAND_UI(ID_SNAP, OnUpdateSnap)
	ON_WM_SIZE()
	ON_COMMAND(ID_INSERTBLOCK, OnInsertblock)
	ON_COMMAND(ID_POINT, OnPoint)
	ON_UPDATE_COMMAND_UI(ID_POINT, OnUpdatePoint)
	ON_COMMAND(ID_LINE, OnLine)
	ON_UPDATE_COMMAND_UI(ID_LINE, OnUpdateLine)
	ON_COMMAND(ID_RECTANGLE, OnRectangle)
	ON_UPDATE_COMMAND_UI(ID_RECTANGLE, OnUpdateRectangle)
	ON_COMMAND(ID_EDIT_CLEAR, OnEditClear)
	ON_UPDATE_COMMAND_UI(ID_EDIT_CLEAR, OnUpdateEditClear)
	ON_COMMAND(ID_POLYLINE, OnPolyline)
	ON_UPDATE_COMMAND_UI(ID_POLYLINE, OnUpdatePolyline)
	ON_WM_LBUTTONDBLCLK()
	ON_COMMAND(ID_TEXT, OnText)
	ON_UPDATE_COMMAND_UI(ID_TEXT, OnUpdateText)
	ON_COMMAND(ID_EDIT_MOVE, OnEditMove)
	ON_UPDATE_COMMAND_UI(ID_EDIT_MOVE, OnUpdateEditMove)
	ON_COMMAND(ID_EDIT_ROTATE, OnEditRotate)
	ON_UPDATE_COMMAND_UI(ID_EDIT_ROTATE, OnUpdateEditRotate)
	ON_COMMAND(ID_CIRCLE, OnCircle)
	ON_UPDATE_COMMAND_UI(ID_CIRCLE, OnUpdateCircle)
	ON_COMMAND(ID_ARC, OnArc)
	ON_UPDATE_COMMAND_UI(ID_ARC, OnUpdateArc)
	ON_COMMAND(ID_SPLINE, OnSpline)
	ON_UPDATE_COMMAND_UI(ID_SPLINE, OnUpdateSpline)
	ON_WM_CREATE()
	ON_COMMAND(ID_INSERTHOLELAYER, OnInsertholelayer)
	ON_COMMAND(ID_MENU_PAPERSETUP, OnMenuPapersetup)
	ON_COMMAND(ID_LAYER_ADMIN, OnLayerAdmin)
	ON_COMMAND(ID_RIGHTANGLECORRECT, OnRightanglecorrect)
	ON_UPDATE_COMMAND_UI(ID_RIGHTANGLECORRECT, OnUpdateRightanglecorrect)
	ON_WM_CHAR()
	ON_COMMAND(ID_ZOOMIN, OnZoomin)
	ON_COMMAND(ID_ZOOMOUT, OnZoomout)
	ON_COMMAND(ID_INSERTSECTIONLINE, OnInsertsectionline)
	ON_COMMAND(ID_COMPASS, OnCompass)
	ON_WM_CONTEXTMENU()
	ON_COMMAND(ID_SPLINE_ADDPOINT, OnSplineAddpoint)
	ON_WM_RBUTTONUP()
	ON_COMMAND(ID_PAPERSPACE, OnPaperspace)
	ON_COMMAND(ID_MODELSPACE, OnModelspace)
	ON_UPDATE_COMMAND_UI(ID_MODELSPACE, OnUpdateModelspace)
	ON_UPDATE_COMMAND_UI(ID_PAPERSPACE, OnUpdatePaperspace)
	ON_UPDATE_COMMAND_UI(ID_COMPASS, OnUpdateCompass)
	ON_COMMAND(ID_EDITMODEL, OnEditmodel)
	ON_UPDATE_COMMAND_UI(ID_EDITMODEL, OnUpdateEditmodel)
	ON_UPDATE_COMMAND_UI(ID_INSERTBLOCK, OnUpdateInsertblock)
	ON_UPDATE_COMMAND_UI(ID_INSERTHOLELAYER, OnUpdateInsertholelayer)
	ON_UPDATE_COMMAND_UI(ID_INSERTSECTIONLINE, OnUpdateInsertsectionline)
	ON_UPDATE_COMMAND_UI(ID_ZOOMIN, OnUpdateZoomin)
	ON_UPDATE_COMMAND_UI(ID_ZOOMOUT, OnUpdateZoomout)
	ON_COMMAND(ID_ENTITYPROPERTY, OnEntityproperty)
	ON_UPDATE_COMMAND_UI(ID_EDIT_CUTSHORT, OnUpdateEditCutshort)
	ON_COMMAND(ID_EDIT_CUTSHORT, OnEditCutshort)
	ON_COMMAND(ID_SPLINE_CUTSHORT, OnSplineCutshort)
	ON_COMMAND(ID_LABELCOORD, OnLabelcoord)
	ON_UPDATE_COMMAND_UI(ID_LABELCOORD, OnUpdateLabelcoord)
	ON_WM_KEYDOWN()
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView construction/destruction

CMiniCADView::CMiniCADView()
{
	CDrawTool::SetTool(selectTool);

	m_pDisplay=NULL;
	m_bInsert=false;
	m_pDC = NULL;
	m_pTempEntity=NULL;
	m_curWorkSpace=MODELSPACE;
	//::ShowCursor(false);
//--------------------------------
	m_bPaperFirst=true;
	m_PaperScale=1;
	m_pEntityPropertyDlg=NULL;
	m_pCompassInsert=NULL;
	m_PaperOrient=VERTICAL;
	m_PaperType = PAPER_A3;
//---------------------------------
}

CMiniCADView::~CMiniCADView()
{
	if (m_pDC) delete m_pDC;
	if(m_pDisplay)delete m_pDisplay;
}

BOOL CMiniCADView::PreCreateWindow(CREATESTRUCT& cs)
{
	ASSERT(cs.style & WS_CHILD);
	if (cs.lpszClass == NULL)
		cs.lpszClass = AfxRegisterWndClass(CS_DBLCLKS);
	/*cs.lpszClass = AfxRegisterWndClass
		(CS_HREDRAW | CS_VREDRAW,
		0,
		(HBRUSH)::GetStockObject(WHITE_BRUSH),
		
		0);*/

	//return CView::PreCreateWindow(cs);
	return true;
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView drawing

void CMiniCADView::OnDraw(CDC* pDC)
{
	CMiniCADDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	try
	{
		if (!m_pDC)
		{			
			m_pDC= new CClientDC(this);			
		}

		if (m_pDisplay)
		{
			if(m_curWorkSpace==MODELSPACE)
			{
				m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetDC(),0,0,SRCCOPY);
				DrawTrackingLayer();
			}
			else
			{
				if(m_pDisplay->GetPaperDC())
				m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetPaperDC(),0,0,SRCCOPY);
			}	
			CDrawTool::c_bJustDraw = true;
		}
	}
	catch(...)
	{}
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView printing

BOOL CMiniCADView::OnPreparePrinting(CPrintInfo* pInfo)
{
	pInfo->SetMaxPage(1);

	CWinApp *app=AfxGetApp(); 
    app->GetPrinterDeviceDefaults(&pInfo->m_pPD->m_pd); 
     
    DEVMODE *dm;
    dm=pInfo->m_pPD->GetDevMode();
    ASSERT(dm!=NULL); 
	switch (m_PaperType)
	{
		case PAPER_A0:
			dm->dmPaperSize = DMPAPER_ESHEET;
			break;
		case PAPER_A1:
			dm->dmPaperSize = DMPAPER_DSHEET;
			break;
		case PAPER_A2:
			dm->dmPaperSize = DMPAPER_CSHEET;
			break;
		case PAPER_A3:
			dm->dmPaperSize = DMPAPER_A3;
			break;
		case PAPER_A4:
			dm->dmPaperSize = DMPAPER_A4;
			break;
		case PAPER_Auto:
			dm->dmPaperSize = DMPAPER_A3;
			break;
	}

	CMiniCADDoc* pDoc = GetDocument();
	if(pDoc->m_Graphics.m_PaperOrient==HORIZONTAL)
		dm->dmOrientation=DMORIENT_LANDSCAPE;//2
	else
		dm->dmOrientation=DMORIENT_PORTRAIT;//1

	return DoPreparePrinting(pInfo);
}

void CMiniCADView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CMiniCADView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView diagnostics

#ifdef _DEBUG
void CMiniCADView::AssertValid() const
{
	CView::AssertValid();
}

void CMiniCADView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CMiniCADDoc* CMiniCADView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CMiniCADDoc)));
	return (CMiniCADDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMiniCADView message handlers

void CMiniCADView::OnLButtonDown(UINT nFlags, CPoint point) 
{
	CMiniCADDoc* pDoc = GetDocument();
	if(CDrawTool::c_pCurDrawTool != NULL && CDrawTool::c_nDown>=1
		&& CDrawTool::GetType()!=rectTool && CDrawTool::GetType()!=zoomTool 
		&& CDrawTool::GetType()!=panTool && CDrawTool::GetType()!=arcTool)
	{
		if (CDrawTool::c_bRightAngleCorrection)
			point = pDoc->m_Graphics.RightAngleCorrect(CDrawTool::c_PtDown,point);
	}

	if (CDrawTool::c_pCurDrawTool != NULL)
		CDrawTool::c_pCurDrawTool->OnLButtonDown(this,nFlags,point);
	CView::OnLButtonDown(nFlags, point);
}

void CMiniCADView::OnLButtonDblClk(UINT nFlags, CPoint point)
{
	if (CDrawTool::c_pCurDrawTool != NULL)
		CDrawTool::c_pCurDrawTool->OnLButtonDblClk(this,nFlags,point);
	CView::OnLButtonDblClk(nFlags, point);
}

void CMiniCADView::OnLButtonUp(UINT nFlags, CPoint point) 
{
	if (CDrawTool::c_pCurDrawTool != NULL)
		CDrawTool::c_pCurDrawTool->OnLButtonUp(this,nFlags,point);
	CView::OnLButtonUp(nFlags, point);
}

void CMiniCADView::OnMouseMove(UINT nFlags, CPoint point)
{
	if (nFlags == MK_MBUTTON)
	{
		::SetCursor(AfxGetApp()->LoadCursor(IDC_HANDLE));
		CMiniCADDoc* pDoc = GetDocument();
		double ddx,ddy;
		int dx,dy;
		dx=point.x-m_MPointOld.x;
		dy=point.y-m_MPointOld.y;
		ddx=dx/pDoc->m_Graphics.m_ZoomRate;
		ddy=dy/pDoc->m_Graphics.m_ZoomRate;

		int cx,cy;
		cx=point.x-m_MPointDown.x;
		cy=point.y-m_MPointDown.y;
		CRect rect;
		CRect rect2;
		CBrush brush;
		brush.CreateSolidBrush(pDoc->m_Graphics.m_BKColor);
		this->GetClientRect(rect);
		if(m_curWorkSpace==MODELSPACE)
		{
			if (cx>0)
				rect2.SetRect(0,0,cx,rect.Height());
			else
				rect2.SetRect(rect.Width()+cx,0,rect.Width(),rect.Height());
			m_pDC->FillRect(&rect2, &brush);
			if (cy>0)
				rect2.SetRect(0,0,rect.Width(),cy-1);
			else
				rect2.SetRect(0,rect.Height()+cy,rect.Width(),rect.Height());
			m_pDC->FillRect(&rect2, &brush);
			m_pDC->BitBlt(cx,cy,rect.Width(),rect.Height(),m_pDisplay->GetDC(),0,0,SRCCOPY);
		}
		else
		{
			CRect moveRect=m_ModelRect;
			CDC* pPaperDC=m_pDisplay->GetPaperDC();
			int xOffset=0;
			int yOffset=0;
			if (cx>0)
			{
				if(cx>m_ModelRect.Width())cx=m_ModelRect.Width();
				rect2.SetRect(m_ModelRect.left,m_ModelRect.top,m_ModelRect.left+cx,m_ModelRect.top+m_ModelRect.Height());
				moveRect.left+=cx;
			}
			else
			{
				if(cx<-m_ModelRect.Width())cx=-m_ModelRect.Width();
				rect2.SetRect(m_ModelRect.left+m_ModelRect.Width()+cx,m_ModelRect.top,m_ModelRect.left+m_ModelRect.Width(),m_ModelRect.top+m_ModelRect.Height());
				moveRect.right+=cx;
				xOffset-=cx;
				
			}
			pPaperDC->FillRect(&rect2, &brush);
			if (cy>0)
			{
				if(cy>m_ModelRect.Height())cy=m_ModelRect.Height();
				rect2.SetRect(m_ModelRect.left,m_ModelRect.top,m_ModelRect.left+m_ModelRect.Width(),m_ModelRect.top+cy);
				moveRect.top+=cy;
			}
			else
			{
				if(cy<-m_ModelRect.Height())cy=-m_ModelRect.Height();
				rect2.SetRect(m_ModelRect.left,m_ModelRect.top+m_ModelRect.Height()+cy,m_ModelRect.left+m_ModelRect.Width(),m_ModelRect.top+m_ModelRect.Height());
				moveRect.bottom+=cy;
				yOffset-=cy;						
			}
			pPaperDC->FillRect(&rect2, &brush);

			pPaperDC->BitBlt(moveRect.left,moveRect.top,moveRect.Width(),moveRect.Height(),m_pDisplay->GetDC(),xOffset,yOffset,SRCCOPY);
			Invalidate(false);
		}
		brush.DeleteObject();
		m_MPointOld=point;
		return;
	}
//////////////////////////////////////////////
	SetMousePosText(point);
	CMiniCADDoc* pDoc = GetDocument();
	if(CDrawTool::c_pCurDrawTool != NULL && CDrawTool::c_nDown>=1
		&& CDrawTool::GetType()!=rectTool && CDrawTool::GetType()!=zoomTool 
		&& CDrawTool::GetType()!=panTool && CDrawTool::GetType()!=arcTool)
	{
		if (CDrawTool::c_bRightAngleCorrection)
			point = pDoc->m_Graphics.RightAngleCorrect(CDrawTool::c_PtDown,point);
	}

	if (CDrawTool::c_pCurDrawTool != NULL)
		CDrawTool::c_pCurDrawTool->OnMouseMove(this,nFlags,point);
	CView::OnMouseMove(nFlags, point);
}

void CMiniCADView::OnSelect() 
{
	CDrawTool::SetTool(selectTool);	
	Resume();
}

void CMiniCADView::OnUpdateSelect(CCmdUI* pCmdUI) 
{
	//pCmdUI->SetRadio(CDrawTool::GetType()==selectTool);
	pCmdUI->SetRadio(CDrawTool::GetType()==selectTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnZoom() 
{
	//CDrawTool::SetTool(zoomTool;
	CDrawTool::SetTool(zoomTool);
	Resume();
}

void CMiniCADView::OnUpdateZoom(CCmdUI* pCmdUI) 
{
	//pCmdUI->SetRadio(CDrawTool::GetType()==zoomTool);
	pCmdUI->SetRadio(CDrawTool::GetType()==zoomTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

BOOL CMiniCADView::OnEraseBkgnd(CDC* pDC) 
{
	return true;
}

void CMiniCADView::OnSnap() 
{
//	m_bSnap=!m_bSnap;
	CDrawTool::c_bSnap = !CDrawTool::c_bSnap;
}

void CMiniCADView::OnUpdateSnap(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::c_bSnap);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::SetMousePosText(CPoint LogPoint)
{
	CMiniCADDoc* pDoc = GetDocument();
	ADPOINT adPoint;
	if(pDoc->m_Graphics.m_bHaveSnap)
		adPoint = pDoc->m_Graphics.m_curSnapP;
	else
		adPoint = pDoc->m_Graphics.ClientToDoc(LogPoint); 
	CMainFrame* pMainFrame=(CMainFrame*)::AfxGetMainWnd();
	pMainFrame->SetMousePosText(adPoint);
}

void CMiniCADView::OnSize(UINT nType, int cx, int cy) 
{
	CView::OnSize(nType, cx, cy);
	//::AfxMessageBox("aa"); 
	if(m_pDisplay==NULL)
	{
		CDC* pDC=this->GetDC();
		if (pDC == NULL) return;
		//xMilimeters=pDC->GetDeviceCaps(HORZSIZE);
		//yMilimeters=pDC->GetDeviceCaps(VERTSIZE);
		int xPixels=pDC->GetDeviceCaps(HORZRES);
		int yPixels=pDC->GetDeviceCaps(VERTRES);

		m_pDisplay=new CDisplay(pDC,xPixels, yPixels);
		CMiniCADDoc* pDoc = GetDocument();
		pDoc->m_Graphics.m_pDisplay=m_pDisplay;
		DeleteDC(pDC->m_hDC);		
	}

/*	if ((cx>0))
	{
		if (!m_pDisplay) 
		{
			m_pDisplay = new CDisplay();
		}
		m_pDisplay->CreateBitmap(cx,cy,this->GetDC(),m_BKColor);

		m_pGraphics->m_pDC = m_pDC;
		m_pPartLayerGroup->ComputeClientExtend(m_pDisplay);
		m_pPartLayerGroup->m_pGraphics->m_Extend.SetRect(m_pPartLayerGroup->GetBound());

		m_pPartLayerGroup->DrawLayer(m_pDisplay);
	}	*/
}

void CMiniCADView::ReBitBlt()
{
	CMiniCADDoc* pDoc = GetDocument();
	pDoc->m_Graphics.m_isDrawMText=true;
	m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetDC(),0,0,SRCCOPY);
//	m_nDown = 0;
	pDoc->m_Graphics.m_bHaveSnap=false;
	pDoc->m_Graphics.m_selectedHandle=0;
	CDrawTool::c_bJustDraw = true;
}

void CMiniCADView::ReDraw()
{
	BeginWaitCursor();
	CMiniCADDoc* pDoc = GetDocument();
	pDoc->SetModifiedFlag();
	pDoc->m_Graphics.DrawGraphics(m_pDisplay->GetDC());
	m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetDC(),0,0,SRCCOPY);
	CDrawTool::c_bJustDraw = true;
	DrawTrackingLayer();
	pDoc->m_Graphics.m_bHaveSnap=false;
	pDoc->m_Graphics.m_isDrawMText=true;
	EndWaitCursor();
}

void CMiniCADView::Resume(bool undoAllSelected)
{
	CMiniCADDoc* pDoc = GetDocument();
//	m_nDown=0;
	pDoc->m_Graphics.m_isDrawMText=true;
	pDoc->m_Graphics.m_bHaveSnap=false;
	//if(m_curDrawTool!=selectTool)
	//	CDrawTool::SetTool(selectTool;
	if(CDrawTool::GetType()!=selectTool)
		CDrawTool::SetTool(selectTool);
	if(m_pTempEntity!=NULL)
	{
		if(m_pTempEntity->GetType()!=AD_ENT_POLYLINE)delete m_pTempEntity;
		m_pTempEntity=NULL;	
	}
	if(pDoc->m_Graphics.m_SelectedEntities.GetSize()==0)
	{
		m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetDC(),0,0,SRCCOPY);
		return;
	}
	if(undoAllSelected)
		pDoc->m_Graphics.UndoAllSelected();
	else
	{
		pDoc->m_Graphics.m_selectedHandle=0;
		pDoc->m_Graphics.m_pSelHandleEntity=NULL;	
	}
	//pDoc->m_Graphics.DrawGraphics(m_pDisplay->GetDC());
	m_pDC->BitBlt(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight(),m_pDisplay->GetDC(),0,0,SRCCOPY);
	pDoc->m_Graphics.DrawHandle(m_pDC);
}

void CMiniCADView::OnInsertblock() 
{
	Resume();
	CInsertBlockDlg InsertBlockDlg;
	CMiniCADDoc* pDoc = GetDocument();
	if (pDoc->m_ProjectType==PROJECT_LAYOUT)
	{
		InsertBlockDlg.m_xScale=(double)m_PaperScale/1000;
		InsertBlockDlg.m_yScale=(double)m_PaperScale/1000;
	}
	InsertBlockDlg.DoModal();
}

void CMiniCADView::OnPoint() 
{
	Resume();
	//CDrawTool::SetTool(pointTool;
	CDrawTool::SetTool(pointTool);
}

void CMiniCADView::OnUpdatePoint(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==pointTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnLine() 
{
	Resume();
	CDrawTool::SetTool(lineTool);
}

void CMiniCADView::OnUpdateLine(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==lineTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnRectangle() 
{	
	Resume();
	CDrawTool::SetTool(rectTool);
}

void CMiniCADView::OnUpdateRectangle(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==rectTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnEditClear() 
{
	CMiniCADDoc* pDoc = GetDocument();
	int j;
	for(int i=0;i<pDoc->m_Graphics.m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)pDoc->m_Graphics.m_SelectedEntities.GetAt(i);
		j=pDoc->m_Graphics.IndexOfEntities(pEntity); 
		if(j==-1)continue;
		pDoc->m_Graphics.m_Entities.RemoveAt(j);
		pDoc->SetModifiedFlag();
		delete pEntity;
	}
	pDoc->m_Graphics.m_SelectedEntities.RemoveAll();
	CDrawTool::SetTool(selectTool);
	ReDraw();
}

void CMiniCADView::OnUpdateEditClear(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(GetDocument()->m_Graphics.m_SelectedEntities.GetSize()!=0);
}

void CMiniCADView::OnPolyline() 
{
	Resume();
	CDrawTool::SetTool(polyLineTool);	
}

void CMiniCADView::OnUpdatePolyline(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==polyLineTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnPan() 
{
	if(m_curWorkSpace==MODELSPACE)
		Resume();
	CDrawTool::SetTool(panTool);
}

void CMiniCADView::OnUpdatePan(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==panTool);
}

void CMiniCADView::OnText() 
{
	CDrawTool::SetTool(textTool);	
}

void CMiniCADView::OnUpdateText(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==textTool);	
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnEditMove() 
{
	if(GetDocument()->m_Graphics.m_SelectedEntities.GetSize()>0)
	{
		Resume(false);
		CDrawTool::SetTool(moveTool);
	}
}

void CMiniCADView::OnUpdateEditMove(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==moveTool);	
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnEditRotate() 
{
	if(GetDocument()->m_Graphics.m_SelectedEntities.GetSize()>0)
	{
		Resume(false);
		CDrawTool::SetTool(rotateTool);
	}
}

void CMiniCADView::OnUpdateEditRotate(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==rotateTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

/*void CMiniCADView::OnEditScale() 
{
	if(GetDocument()->m_Graphics.m_SelectedEntities.GetSize()>0)
		CDrawTool::SetTool(scaleTool;	
}

void CMiniCADView::OnUpdateEditScale(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==scaleTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}
*/
void CMiniCADView::OnCircle() 
{	
	Resume();
	CDrawTool::SetTool(circleTool);
}

void CMiniCADView::OnUpdateCircle(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==circleTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnArc() 
{	
	Resume();
	CDrawTool::SetTool(arcTool);
}

void CMiniCADView::OnUpdateArc(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==arcTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnSpline() 
{
	Resume();
	CDrawTool::SetTool(splineTool);
}

void CMiniCADView::OnUpdateSpline(CCmdUI* pCmdUI) 
{	
	pCmdUI->SetRadio(CDrawTool::GetType()==splineTool);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

int CMiniCADView::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CView::OnCreate(lpCreateStruct) == -1)
		return -1;
	
/*	CDC* dc=GetDC();
	if (!dc) return -1;
	m_xMilimeters=dc->GetDeviceCaps(HORZSIZE);
	m_yMilimeters=dc->GetDeviceCaps(VERTSIZE);
	m_xPixels=dc->GetDeviceCaps(HORZRES);
	m_yPixels=dc->GetDeviceCaps(VERTRES);
	//ReleaseDC(dc);
	DeleteDC(dc->m_hDC);*/

/*	CRect client;
	this->GetClientRect(client);
	CMiniCADDoc* pDoc = GetDocument();
	pDoc->m_Graphics.m_LayoutLeftMargin = (client.Width() - (m_xPixels - 200))/2;
	pDoc->m_Graphics.m_LayoutTopMargin = (client.Height() - (m_yPixels - 200))/2;
*/
	return 0;
}

void CMiniCADView::OnPrint(CDC* pDC, CPrintInfo* pInfo) 
{
	CMiniCADDoc* pDoc = GetDocument();
	double xMilimeters=pDC->GetDeviceCaps(HORZSIZE);
	double yMilimeters=pDC->GetDeviceCaps(VERTSIZE);
	double xPixels=pDC->GetDeviceCaps(HORZRES);
	double yPixels=pDC->GetDeviceCaps(VERTRES);

	if(m_curWorkSpace==MODELSPACE)
	{
		//pInfo->m_rectDraw.SetRect(0, 0, xMilimeters, yMilimeters);
		pDoc->m_Graphics.m_GraphicsMode=Printing;
		pDoc->m_Graphics.m_LineWidthFactor=2;
		if(pDoc->m_Graphics.m_Unit==UNIT_MILLIMETER)
		{
			pDoc->m_Graphics.m_mXPrintPixel=(double)xPixels/((double)xMilimeters);
			pDoc->m_Graphics.m_mYPrintPixel=(double)yPixels/((double)yMilimeters);
			pDoc->m_Graphics.m_PrintBound.left=pDoc->m_Graphics.m_Extmin.x*pDoc->m_Graphics.m_mXPrintPixel;
			pDoc->m_Graphics.m_PrintBound.left+=5*pDoc->m_Graphics.m_mXPrintPixel;
			pDoc->m_Graphics.m_PrintBound.top=-pDoc->m_Graphics.m_Extmax.y*pDoc->m_Graphics.m_mYPrintPixel;
			pDoc->m_Graphics.m_PrintBound.top+=5*pDoc->m_Graphics.m_mYPrintPixel;
			pDoc->m_Graphics.m_PrintBound.right=pDoc->m_Graphics.m_PrintBound.left+A3_WIDTH*pDoc->m_Graphics.m_mXPrintPixel;
			pDoc->m_Graphics.m_PrintBound.bottom=pDoc->m_Graphics.m_PrintBound.top+A3_HEIGHT*pDoc->m_Graphics.m_mYPrintPixel;
		}
		else
		{
			pDoc->m_Graphics.m_mXPrintPixel=(double)xPixels/((double)xMilimeters/1000);
			pDoc->m_Graphics.m_mYPrintPixel=(double)yPixels/((double)yMilimeters/1000);

			double LeftPrintMargin=30;
			double TopPrintMargin=20;

			pDoc->m_Graphics.m_PrintBound.left=(pDoc->m_Graphics.m_Extmin.x-LeftPrintMargin)*pDoc->m_Graphics.m_mXPrintPixel;
			pDoc->m_Graphics.m_PrintBound.top=-(pDoc->m_Graphics.m_Extmax.y+TopPrintMargin)*pDoc->m_Graphics.m_mYPrintPixel;
			pDoc->m_Graphics.m_PrintBound.right=pDoc->m_Graphics.m_PrintBound.left+pDoc->m_Graphics.m_PrintWidth*pDoc->m_Graphics.m_mXPrintPixel;
			pDoc->m_Graphics.m_PrintBound.bottom=pDoc->m_Graphics.m_PrintBound.top+pDoc->m_Graphics.m_PrintHeight*pDoc->m_Graphics.m_mYPrintPixel;
		}
		pDoc->m_Graphics.DrawGraphics(pDC);
		pDoc->m_Graphics.m_GraphicsMode=Layout;
	}
	else
	{
		pDoc->m_pPaperGraphics->m_GraphicsMode=Printing;
		if(pDoc->m_pPaperGraphics->m_Unit==UNIT_MILLIMETER)
		{
			pDoc->m_pPaperGraphics->m_LineWidthFactor=2;
			pDoc->m_pPaperGraphics->m_mXPrintPixel=(double)xPixels/((double)xMilimeters);
			pDoc->m_pPaperGraphics->m_mYPrintPixel=(double)yPixels/((double)yMilimeters);
			if(m_PaperOrient==HORIZONTAL)
			{
				pDoc->m_pPaperGraphics->m_PrintBound.left=0;
				pDoc->m_pPaperGraphics->m_PrintBound.left+=5*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.top=-A3_HEIGHT*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.top+=5*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.right=(pDoc->m_pPaperGraphics->m_Bound.left+A3_WIDTH)*pDoc->m_pPaperGraphics->m_mXPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.bottom=0;
			}
			else
			{
				pDoc->m_pPaperGraphics->m_PrintBound.left=0;
				pDoc->m_pPaperGraphics->m_PrintBound.left+=5*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.top=-A3_WIDTH*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.top+=5*pDoc->m_pPaperGraphics->m_mYPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.right=(pDoc->m_pPaperGraphics->m_Bound.left+A3_HEIGHT)*pDoc->m_pPaperGraphics->m_mXPrintPixel;
				pDoc->m_pPaperGraphics->m_PrintBound.bottom=0;			
			}
		}
		else
		{

		}
		pDoc->m_pPaperGraphics->DrawGraphics(pDC);
		double oldZoomRate=pDoc->m_Graphics.m_ZoomRate;
		pDoc->m_Graphics.m_ZoomRate=pDoc->m_pPaperGraphics->m_mXPrintPixel*1000/m_PaperScale;

		if(m_PaperOrient==HORIZONTAL)
		{
			CPoint point;
			CRect modelRect;
			ADPOINT adPoint = {15+1,A3_HEIGHT-10};
			//adPoint.x=15+1;
			//adPoint.y=A3_HEIGHT-10;
			point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
			modelRect.left=point.x;
			modelRect.top=point.y+5;

			adPoint.x=A3_WIDTH-10;
			adPoint.y=10+10;
			point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
			modelRect.right=point.x-1;
			modelRect.bottom=point.y-1;
			//-------------------------------------------------------
			CDC tempDC;
			if(!tempDC.CreateCompatibleDC(pDC))return;
			CBitmap tempBp;
			if(!tempBp.CreateCompatibleBitmap(pDC,modelRect.Width(),modelRect.Height()))return;
			tempDC.SelectObject(&tempBp);

			CBrush brush;
			if (!brush.CreateSolidBrush(RGB(255,255,255)))
				return;
			brush.UnrealizeObject();

			tempDC.FillRect(CRect(0,0,modelRect.Width(),modelRect.Height()), &brush);
			pDoc->m_Graphics.m_bBlack = true;
			point=pDoc->m_Graphics.DocToClient(m_RotatePt);
			pDoc->m_Graphics.RotateAll(&tempDC,point,-(int)pDoc->m_Graphics.m_RotateAngle);
			pDoc->m_Graphics.m_bBlack = false;
			pDC->BitBlt(modelRect.left,modelRect.top,modelRect.Width(),modelRect.Height(),&tempDC,0,0,SRCCOPY);
			tempBp.DeleteObject();			
		}
		else
		{
			CPoint point;
			CRect modelRect;
			ADPOINT adPoint = {10+1,A3_WIDTH-15-30};
			//adPoint.x=10+1;
			//adPoint.y=A3_WIDTH-15-30;
			point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
			modelRect.left=point.x;
			modelRect.top=point.y+5;

			adPoint.x=A3_HEIGHT-10;
			adPoint.y=10+36;
			point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
			modelRect.right=point.x-1;
			modelRect.bottom=point.y-1;
			//-------------------------------------------------------
			CDC tempDC;
			if(!tempDC.CreateCompatibleDC(pDC))return;
			CBitmap tempBp;
			if(!tempBp.CreateCompatibleBitmap(pDC,modelRect.Width(),modelRect.Height()))return;
			tempDC.SelectObject(&tempBp);

			CBrush brush;
			if (!brush.CreateSolidBrush(RGB(255,255,255)))
				return;
			brush.UnrealizeObject();

			tempDC.FillRect(CRect(0,0,modelRect.Width(),modelRect.Height()), &brush);

			point=pDoc->m_Graphics.DocToClient(m_RotatePt);
			pDoc->m_Graphics.m_bBlack = true;
			pDoc->m_Graphics.RotateAll(&tempDC,point,-(int)pDoc->m_Graphics.m_RotateAngle);
			pDoc->m_Graphics.m_bBlack = false;
			pDC->BitBlt(modelRect.left,modelRect.top,modelRect.Width(),modelRect.Height(),&tempDC,0,0,SRCCOPY);
			tempBp.DeleteObject();

		}
		//revert
		pDoc->m_pPaperGraphics->m_GraphicsMode=Layout;	
		pDoc->m_Graphics.m_ZoomRate=oldZoomRate;
	}
	CView::OnPrint(pDC, pInfo);
}

void CMiniCADView::OnInsertholelayer() 
{
	Resume();
	CInsertHoleLayerDlg InsertHoleLayerDlg;
	InsertHoleLayerDlg.DoModal();		
}

void CMiniCADView::OnMenuPapersetup() 
{
	if(m_curWorkSpace==MODELSPACE)
	{
		Resume();
		CDlg_PaperSetup Dlg_PaperSetup;
		if(Dlg_PaperSetup.DoModal()==IDOK)
		{
			ReDraw();
		}
	}
	else
	{
		CDlg_PaperSetup Dlg_PaperSetup;
		if(Dlg_PaperSetup.DoModal()==IDOK)
		{
			CMiniCADDoc* pDoc = GetDocument();
			CDC* pPaperDC=m_pDisplay->GetPaperDC();
			pDoc->m_pPaperGraphics->m_PaperOrient=pDoc->m_Graphics.m_PaperOrient;
			pDoc->m_pPaperGraphics->DrawGraphics(pPaperDC);
			CPoint point;
			point=pDoc->m_Graphics.DocToClient(m_RotatePt);
			pDoc->m_Graphics.RotateAll(m_pDisplay->GetDC(),point,-(int)pDoc->m_Graphics.m_RotateAngle);
			pPaperDC->BitBlt(m_ModelRect.left,m_ModelRect.top,m_ModelRect.Width(),m_ModelRect.Height(),m_pDisplay->GetDC(),0,0,SRCCOPY);	
			Invalidate(false);
		}		
	}
}

void CMiniCADView::OnLayerAdmin() 
{
	CDlgLayerAdmin dlg;
	if(dlg.DoModal()==IDOK)
	{
		ReDraw();
	}
}

void CMiniCADView::OnRightanglecorrect() 
{
	CDrawTool::c_bRightAngleCorrection=!CDrawTool::c_bRightAngleCorrection;	
}

void CMiniCADView::OnUpdateRightanglecorrect(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::c_bRightAngleCorrection);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnChar(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	if(m_curWorkSpace != MODELSPACE)return;
	switch (nChar)
	{
		case VK_ESCAPE:
			{				
				CMiniCADDoc* pDoc = GetDocument();
				if(pDoc->m_Graphics.m_selectedHandle>0)
					Resume(false);
				else
					Resume();
				break;
			}
	}
	CView::OnChar(nChar, nRepCnt, nFlags);
}
/*
void CMiniCADView::SetPageMargin(CDC *pDC, CPrintInfo *pInfo, int l, int t, int r, int b)
// l, t, r, b分别表示左上右下边距, 单位为0.1mm
{
	int nOldMode = pDC->GetMapMode();
	pDC->SetMapMode(MM_LOMETRIC);
	// 计算一个设备单位等于多少0.1mm
	double scaleX = 254.0 / (double)GetDeviceCaps(
	pDC->m_hAttribDC, LOGPIXELSX);
	double scaleY = 254.0 / (double)GetDeviceCaps(
	pDC->m_hAttribDC, LOGPIXELSY);
	int x = GetDeviceCaps(pDC->m_hAttribDC, 
	PHYSICALOFFSETX); 
	int y = GetDeviceCaps(pDC->m_hAttribDC, 
	PHYSICALOFFSETY); 
	int w = GetDeviceCaps(pDC->m_hAttribDC, 
	PHYSICALWIDTH); 
	int h = GetDeviceCaps(pDC->m_hAttribDC, 
	PHYSICALHEIGHT); 
	int nPageWidth = (int)((double)w*scaleX + 0.5); 
	// 纸宽，单位0.1mm 
	int nPageHeight = (int)((double)h*scaleY + 0.5);
	// 纸高，单位0.1mm 
	int m_nPhyLeft = (int)((double)x*scaleX + 0.5); 
	// 物理左边距，单位0.1mm 
	int m_nPhyTop = (int)((double)y*scaleY + 0.5); 
	// 物理上边距，单位0.1mm 
	pDC->DPtoLP(&pInfo->m_rectDraw); 
	CRect rcTemp = pInfo->m_rectDraw;
	rcTemp.NormalizeRect();
	int m_nPhyRight = nPageWidth - rcTemp.Width() - 
	m_nPhyLeft; // 物理右边距，单位0.1mm
	int m_nPhyBottom = nPageHeight - rcTemp.Height() - 
	m_nPhyTop; // 物理下边距，单位0.1mm
	// 若边距小于物理边距，则调整它们
	if (l < m_nPhyLeft) l = m_nPhyLeft;
	if (t < m_nPhyTop) t = m_nPhyTop;
	if (r < m_nPhyRight) r = m_nPhyRight;
	if (b < m_nPhyBottom) b = m_nPhyBottom;
	// 计算并调整pInfo->m_rectDraw的大小
	pInfo->m_rectDraw.left = l - m_nPhyLeft;
	pInfo->m_rectDraw.top = - t + m_nPhyTop;
	pInfo->m_rectDraw.right -= r - m_nPhyRight;
	pInfo->m_rectDraw.bottom += b - m_nPhyBottom;
	pDC->LPtoDP(&pInfo->m_rectDraw);
	pDC->SetMapMode(nOldMode); 
	// 恢复原来的映射模式
}
*/
void CMiniCADView::OnZoomin() 
{
	CMiniCADDoc* pDoc = GetDocument();
	if (pDoc->m_Graphics.m_ZoomRate > 
		pDoc->m_Graphics.m_OriginZoomRate*10)return;
	CRect client;
	this->GetClientRect(client);
	CPoint point;
	point.x=(client.left+client.right)/2;
	point.y=(client.top+client.bottom)/2;
	ADPOINT adPoint;
	adPoint=pDoc->m_Graphics.ClientToDoc(point);
	pDoc->m_Graphics.m_ZoomRate*=1.5;
	point=pDoc->m_Graphics.DocToClient(adPoint);

	int offsetX=client.Width()/2-point.x;
	int offsetY=client.Height()/2-point.y;
	double dx=offsetX/pDoc->m_Graphics.m_ZoomRate;
	double dy=offsetY/pDoc->m_Graphics.m_ZoomRate;
	pDoc->m_Graphics.m_Bound.left-=dx;
	pDoc->m_Graphics.m_Bound.top-=dy;
	ReDraw();
}

void CMiniCADView::OnZoomout() 
{
	CMiniCADDoc* pDoc = GetDocument();
	if (pDoc->m_Graphics.m_ZoomRate <= 
		pDoc->m_Graphics.m_OriginZoomRate*0.7)return;
	CRect client;
	this->GetClientRect(client);
	CPoint point;
	point.x=(client.left+client.right)/2;
	point.y=(client.top+client.bottom)/2;
	ADPOINT adPoint;
	adPoint=pDoc->m_Graphics.ClientToDoc(point);
	pDoc->m_Graphics.m_ZoomRate/=1.5;
	point=pDoc->m_Graphics.DocToClient(adPoint);

	int offsetX=client.Width()/2-point.x;
	int offsetY=client.Height()/2-point.y;
	double dx=offsetX/pDoc->m_Graphics.m_ZoomRate;
	double dy=offsetY/pDoc->m_Graphics.m_ZoomRate;
	pDoc->m_Graphics.m_Bound.left-=dx;
	pDoc->m_Graphics.m_Bound.top-=dy;
	ReDraw();
}

void CMiniCADView::ChangePaper(int nPaper)
{
/*	CString str;
	str.Format("%d",nPaper);
	::AfxMessageBox(str);*/
	if (nPaper==0)return;	
	CMiniCADDoc* pDoc = this->GetDocument();
	CADLayer* pLayer=pDoc->m_Graphics.m_pLayerGroup->GetLayer(nPaper);
	if(pLayer == NULL)return;
	
	if(pLayer->m_nColor>0)return;
	pLayer->m_nColor = abs(pLayer->m_nColor);
	pDoc->m_Graphics.UndoAllSelected(); 
	for (int i=1; i<pDoc->m_Graphics.m_pLayerGroup->GetLayerCount(); i++)
	{
		if (i == nPaper)continue;
		pLayer=pDoc->m_Graphics.m_pLayerGroup->GetLayer(i);
		if(pLayer == NULL)return;
		pLayer->m_nColor = -abs(pLayer->m_nColor);
		
	}
	ReDraw();
}

void CMiniCADView::ChangeScale(int nScale)
{
	CMiniCADDoc* pDoc = GetDocument();
	CRect client;
	this->GetClientRect(client);
	CPoint point;
	point.x=(client.left+client.right)/2;
	point.y=(client.top+client.bottom)/2;
	ADPOINT adPoint;
	adPoint=pDoc->m_Graphics.ClientToDoc(point);
	pDoc->m_Graphics.m_ZoomRate = pDoc->m_Graphics.m_OriginZoomRate * nScale / 100;
	point=pDoc->m_Graphics.DocToClient(adPoint);

	int offsetX=client.Width()/2-point.x;
	int offsetY=client.Height()/2-point.y;
	double dx=offsetX/pDoc->m_Graphics.m_ZoomRate;
	double dy=offsetY/pDoc->m_Graphics.m_ZoomRate;
	pDoc->m_Graphics.m_Bound.left-=dx;
	pDoc->m_Graphics.m_Bound.top-=dy;
	ReDraw();
	this->SetFocus();
}

void CMiniCADView::OnInsertsectionline() 
{
	Resume();
	CDlgSection DlgSection;
	DlgSection.DoModal();		
}

void CMiniCADView::OnCompass() 
{
//	Resume();
	CDlgCompass DlgCompass;
	CMiniCADDoc* pDoc = this->GetDocument();
	DlgCompass.m_Angle=pDoc->m_Graphics.m_RotateAngle;
	if(DlgCompass.DoModal()==IDOK)
	{
		CRect client;
		this->GetClientRect(client);
		CPoint point;
		point=pDoc->m_Graphics.DocToClient(m_RotatePt);
		double angle=pDoc->m_Graphics.m_RotateAngle-DlgCompass.m_Angle;
		pDoc->m_Graphics.m_RotateAngle=DlgCompass.m_Angle;
		if(m_pCompassInsert)
			m_pCompassInsert->m_Rotation = DlgCompass.m_Angle;
		CDC* pDC=m_pDisplay->GetDC();
		//pDoc->m_pPaperGraphics->DrawGraphics(pDC);
		pDoc->m_Graphics.RotateAll(m_pDisplay->GetDC(),point,-(int)pDoc->m_Graphics.m_RotateAngle);
		CDC* pPaperDC=m_pDisplay->GetPaperDC();
		pPaperDC->BitBlt(m_ModelRect.left,m_ModelRect.top,m_ModelRect.Width(),m_ModelRect.Height(),m_pDisplay->GetDC(),0,0,SRCCOPY);	
		Invalidate(false);
	}
}

void CMiniCADView::OnContextMenu(CWnd* pWnd, CPoint point) 
{
	CMiniCADDoc* pDoc = this->GetDocument();
	if(CDrawTool::GetType()==selectTool && pDoc->m_Graphics.m_SelectedEntities.GetSize()==1)
	{
		CADEntity* pEntity=(CADEntity*)pDoc->m_Graphics.m_SelectedEntities.GetAt(0);
		if(pEntity->GetType()==AD_ENT_SPLINE)
		{
			CMenu menu;	
			menu.LoadMenu(IDR_MENU_EDIT);

			CMenu* pPopup = menu.GetSubMenu(0);
			ASSERT(pPopup != NULL);

			pPopup->TrackPopupMenu(TPM_RIGHTBUTTON | TPM_LEFTALIGN,
										   point.x, point.y,
										   AfxGetMainWnd());
		}
	}
}

void CMiniCADView::OnSplineAddpoint() 
{
	CDrawTool::SetTool(spline_AddPoint_Tool);		
}

void CMiniCADView::OnRButtonUp(UINT nFlags, CPoint point) 
{
/*	CMiniCADDoc* pDoc = this->GetDocument();
	switch (m_curDrawTool)
	{
		case spline_AddPoint_Tool:
			CDrawTool::SetTool(spline_AddPoint_Tool);
			pDoc->m_Graphics.m_selectedHandle=0;
			pDoc->m_Graphics.m_pSelHandleEntity=NULL;
			ReDraw();
			break;
		case insertTool:
			CDrawTool::SetTool(selectTool;
			ReBitBlt();
			break;
	}*/
	if (CDrawTool::c_pCurDrawTool != NULL)
		CDrawTool::c_pCurDrawTool->OnRButtonUp(this,nFlags,point);
	CView::OnRButtonUp(nFlags, point);
}

void CMiniCADView::OnPaperspace()
{
	if(m_curWorkSpace==PAPERSPACE)return;
	m_curWorkSpace=PAPERSPACE;
	CDrawTool::SetTool(panTool);

	CMiniCADDoc* pDoc = this->GetDocument();
	CADRectangle tempBound;
	tempBound=pDoc->m_Graphics.m_Bound;
	if(!m_bPaperFirst)
		pDoc->m_Graphics.m_Bound=m_ModelOldBound;
	m_ModelOldBound=tempBound;
	m_ModelOldZoom=pDoc->m_Graphics.m_ZoomRate;

	if(m_bPaperFirst)
	{
		if(m_PaperOrient==HORIZONTAL)
		{
			if(!CreatePaper())return;
			else
			m_bPaperFirst=false;
		}
		else
		{
			if(!CreatePaper2())return;
			else
			m_bPaperFirst=false;		
		}
	}
	CDC* pPaperDC=m_pDisplay->GetPaperDC();

//======================================================
	pDoc->m_Graphics.m_BKColor=RGB(255,255,255);
	pDoc->m_Graphics.m_WhiteColor=RGB(0,0,0);
	//pDoc->m_Graphics.m_PaperScale=800;
	pDoc->m_Graphics.m_ZoomRate=pDoc->m_pPaperGraphics->m_ZoomRate;
	pDoc->m_Graphics.m_ZoomRate=pDoc->m_Graphics.m_ZoomRate*pDoc->m_pPaperGraphics->m_mXPixel*1000;
	pDoc->m_Graphics.m_ZoomRate=pDoc->m_Graphics.m_ZoomRate/m_PaperScale;

	m_RotatePt.x=(pDoc->m_Graphics.m_Extmin.x+pDoc->m_Graphics.m_Extmax.x)/2;
	m_RotatePt.y=(pDoc->m_Graphics.m_Extmin.y+pDoc->m_Graphics.m_Extmax.y)/2;

	CPoint point;
	point=pDoc->m_Graphics.DocToClient(m_RotatePt);
	pDoc->m_pPaperGraphics->DrawGraphics(pPaperDC);
	pDoc->m_Graphics.RotateAll(m_pDisplay->GetDC(),point,-(int)pDoc->m_Graphics.m_RotateAngle);
	pPaperDC->BitBlt(m_ModelRect.left,m_ModelRect.top,m_ModelRect.Width(),m_ModelRect.Height(),m_pDisplay->GetDC(),0,0,SRCCOPY);	
	Invalidate(false);
}

void CMiniCADView::OnModelspace() 
{
	if(m_curWorkSpace==MODELSPACE)return;
	m_curWorkSpace=MODELSPACE;

	CMiniCADDoc* pDoc = this->GetDocument();
	CADRectangle tempBound;
	tempBound=pDoc->m_Graphics.m_Bound;
	pDoc->m_Graphics.m_Bound=m_ModelOldBound;
	pDoc->m_Graphics.m_ZoomRate=m_ModelOldZoom;
	m_ModelOldBound=tempBound;

	pDoc->m_Graphics.m_BKColor=RGB(0,0,0);
	pDoc->m_Graphics.m_WhiteColor=RGB(255,255,255);
	ReDraw();
}

void CMiniCADView::OnUpdateModelspace(CCmdUI* pCmdUI) 
{
	CMiniCADDoc* pDoc = this->GetDocument();	
	pCmdUI->Enable(pDoc->m_isLayout);
	pCmdUI->SetRadio(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnUpdatePaperspace(CCmdUI* pCmdUI) 
{
	CMiniCADDoc* pDoc = this->GetDocument();	
	pCmdUI->Enable(pDoc->m_isLayout);
	pCmdUI->SetRadio(m_curWorkSpace==PAPERSPACE);	
}

void CMiniCADView::OnUpdateCompass(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_curWorkSpace==PAPERSPACE);		
}

void CMiniCADView::OnEditmodel() 
{
	
}

void CMiniCADView::OnUpdateEditmodel(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_curWorkSpace==PAPERSPACE);	
}

void CMiniCADView::OnUpdateInsertblock(CCmdUI* pCmdUI) 
{
//	CMiniCADDoc* pDoc = this->GetDocument();
//	pCmdUI->Enable(m_curWorkSpace==MODELSPACE && pDoc->m_isLayout);
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnUpdateInsertholelayer(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);
}

void CMiniCADView::OnUpdateInsertsectionline(CCmdUI* pCmdUI) 
{
	CMiniCADDoc* pDoc = this->GetDocument();
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE && pDoc->m_isLayout);		
}

bool CMiniCADView::CreatePaper()
{
	if(!m_pDisplay->CreatePaperDC())return false;
	CDC* pPaperDC=m_pDisplay->GetPaperDC();

	CMiniCADDoc* pDoc = this->GetDocument();
	pDoc->m_pPaperGraphics=new CADGraphics();
	pDoc->m_pPaperGraphics->m_pDisplay=m_pDisplay;
	pDoc->m_pPaperGraphics->m_pLayerGroup=&pDoc->m_LayerGroup;
	pDoc->m_pPaperGraphics->m_Unit=UNIT_MILLIMETER;
	pDoc->m_pPaperGraphics->m_GraphicsMode=Layout;
	pDoc->m_pPaperGraphics->m_BKColor=RGB(173,174,173);
	pDoc->m_pPaperGraphics->m_WhiteColor=RGB(0,0,0);
	pDoc->m_pPaperGraphics->m_PaperWidth=A3_WIDTH;
	pDoc->m_pPaperGraphics->m_PaperHeight=A3_HEIGHT;

	CDC* dc=GetDC();
	if (!dc) return false;
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);

	//ReleaseDC(dc);
	DeleteDC(dc->m_hDC);

	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	pDoc->m_pPaperGraphics->m_mXPixel=mXPixel;
	pDoc->m_pPaperGraphics->m_mYPixel=mYPixel;

	pDoc->m_pPaperGraphics->m_Bound.left=0;
	pDoc->m_pPaperGraphics->m_Bound.top=-A3_HEIGHT*mYPixel;
	pDoc->m_pPaperGraphics->m_Bound.right=(pDoc->m_pPaperGraphics->m_Bound.left+A3_WIDTH)*mXPixel;
	pDoc->m_pPaperGraphics->m_Bound.bottom=0;

	pDoc->m_pPaperGraphics->m_PaperLeft=0;
	pDoc->m_pPaperGraphics->m_PaperTop=A3_HEIGHT;
	pDoc->m_pPaperGraphics->m_bLineWidth=true;
//======================================================================
	double footLeft=15;
	double footTop=10+10;
	double footBottom=10;

	CADLayer* pLayer=new CADLayer();
	pDoc->m_LayerGroup.AddLayer(pLayer);  
	strcpy(pLayer->m_Name,LayoutLayer1Name);
	pLayer->m_nColor=7;
	strcpy(pLayer->m_LTypeName,"CONTINUOUS");	
//==============================================================
	int curLayerIndex=pDoc->m_LayerGroup.indexOf(LayoutLayer1Name);
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	CADLine* pLine;
	CADMText* pMText;

//create frame-------------------------------------------------
	int FrameWidth=8;
	pPolyline=new CADPolyline();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=curLayerIndex;
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=FrameWidth;
	pPoint=new ADPOINT();
	pPoint->x = footLeft;
	pPoint->y = footBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = A3_WIDTH-10;
	pPoint->y = footBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = A3_WIDTH-10;
	pPoint->y = A3_HEIGHT-10;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();	
	pPoint->x = footLeft;
	pPoint->y = A3_HEIGHT-10;
	pPolyline->m_Point.Add((CObject*)pPoint);
//--------------------------------------------------------------
	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="江苏苏州地质工程勘察院";
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60/2;
	pMText->m_Location.y=footTop-5;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft;
	pLine->pt1.y=footTop;
	pLine->pt2.x=A3_WIDTH-10;
	pLine->pt2.y=pLine->pt1.y;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=m_PaperName;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148/2;
	pMText->m_Location.y=footTop-5;
	
	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="编制";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10/2;
	pMText->m_Location.y=footTop-5;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10;//编制right line
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10+26;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="校核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10+26+10/2;
	pMText->m_Location.y=footTop-5;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10+26+10;//校核right line
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10+26+10+26;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="审核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10+26+10+26+10/2;
	pMText->m_Location.y=footTop-5;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;//审核right line
	pLine->pt1.x=footLeft+60+148+10+26+10+26+10;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10+26+10+26+10+26;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="图号";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10+26+10+26+10+26+10/2;
	pMText->m_Location.y=footTop-5;


	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;//图号right line
	pLine->pt1.x=footLeft+60+148+10+26+10+26+10+26+10;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=footLeft+60+148+10+26+10+26+10+26+10+26;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="日期";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10+26+10+26+10+26+10+26+10/2;
	pMText->m_Location.y=footTop-5;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;//日期right line
	pLine->pt1.x=footLeft+60+148+10+26+10+26+10+26+10+26+10;
	pLine->pt1.y=footTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=footBottom;

	CTime time;
	time=CTime::GetCurrentTime();
	CString str=time.Format("%Y.%m.%d");

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=footLeft+60+148+10+26+10+26+10+26+10+26+10+30/2;
	pMText->m_Location.y=footTop-5;
//======================================================================

	pDoc->m_pPaperGraphics->CalZoomRate();

	//CRect modelRect;
	ADPOINT adPoint;
	adPoint.x=footLeft;
	adPoint.y=A3_HEIGHT-10;
	CPoint point;
	point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
	m_ModelRect.left = point.x + FrameWidth/2;
	m_ModelRect.top = point.y + FrameWidth/2;

	adPoint.x=A3_WIDTH-10;
	adPoint.y=footBottom+10;
	point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
	m_ModelRect.right = point.x-FrameWidth/2;
	m_ModelRect.bottom = point.y;
	return true;
}

bool CMiniCADView::CreatePaper2()
{
	if(!m_pDisplay->CreatePaperDC())return false;
	CDC* pPaperDC=m_pDisplay->GetPaperDC();

	CMiniCADDoc* pDoc = this->GetDocument();
	pDoc->m_pPaperGraphics=new CADGraphics();
	pDoc->m_pPaperGraphics->m_pDisplay=m_pDisplay;
	pDoc->m_pPaperGraphics->m_pLayerGroup=&pDoc->m_LayerGroup;
	pDoc->m_pPaperGraphics->m_Unit=UNIT_MILLIMETER;
	pDoc->m_pPaperGraphics->m_GraphicsMode=Layout;
	pDoc->m_pPaperGraphics->m_BKColor=RGB(173,174,173);
	pDoc->m_pPaperGraphics->m_WhiteColor=RGB(0,0,0); 
	pDoc->m_pPaperGraphics->m_PaperWidth=A3_HEIGHT;
	pDoc->m_pPaperGraphics->m_PaperHeight=A3_WIDTH;

	CDC* dc=GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);

	//ReleaseDC(dc);
	DeleteDC(dc->m_hDC);

	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	pDoc->m_pPaperGraphics->m_mXPixel=mXPixel;
	pDoc->m_pPaperGraphics->m_mYPixel=mYPixel;

	pDoc->m_pPaperGraphics->m_Bound.left=0;
	pDoc->m_pPaperGraphics->m_Bound.top=-A3_WIDTH*mYPixel;
	pDoc->m_pPaperGraphics->m_Bound.right=(pDoc->m_pPaperGraphics->m_Bound.left+A3_HEIGHT)*mXPixel;
	pDoc->m_pPaperGraphics->m_Bound.bottom=0;

	pDoc->m_pPaperGraphics->m_PaperLeft=0;
	pDoc->m_pPaperGraphics->m_PaperTop=A3_WIDTH;
	pDoc->m_pPaperGraphics->m_bLineWidth=true;
//======================================================================

	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	CADLine* pLine;
	CADMText* pMText;
	int curLayerIndex;
	CADLayer* pLayer;
	pLayer=new CADLayer();
	pDoc->m_LayerGroup.AddLayer(pLayer);  
	strcpy(pLayer->m_Name,LayoutLayer2Name);
	pLayer->m_nColor=7;
	strcpy(pLayer->m_LTypeName,"CONTINUOUS");

	double frameTop=A3_WIDTH-15;
	double frameLeft=10;
	double frameBottom=10;
	double frameRight=A3_HEIGHT-10;
	curLayerIndex=pDoc->m_LayerGroup.indexOf(LayoutLayer2Name);
	pPolyline=new CADPolyline();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=curLayerIndex;
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=2;
	pPoint=new ADPOINT();
	pPoint->x = frameLeft;
	pPoint->y = frameBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = frameRight;
	pPoint->y = frameBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = frameRight;
	pPoint->y = frameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();	
	pPoint->x = frameLeft;
	pPoint->y = frameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameLeft;
	pLine->pt1.y=frameTop-30;
	pLine->pt2.x=frameRight;
	pLine->pt2.y=pLine->pt1.y;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=m_PaperName;
	strcpy(pMText->m_Font,"幼圆");
	pMText->m_Height=10;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=A3_HEIGHT/2;
	pMText->m_Location.y=frameTop-30/2;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameLeft;
	pLine->pt1.y=frameBottom+36;
	pLine->pt2.x=frameRight;
	pLine->pt2.y=pLine->pt1.y;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameLeft+15;
	pLine->pt1.y=frameBottom+36;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=frameBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameLeft+15+45;
	pLine->pt1.y=frameBottom+36;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=frameBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameLeft;
	pLine->pt1.y=frameBottom+18;
	pLine->pt2.x=pLine->pt1.x+15+45;
	pLine->pt2.y=pLine->pt1.y;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="图 名";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=frameLeft+15/2;
	pMText->m_Location.y=frameBottom+18+18/2;

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="图 号";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=frameLeft+15/2;
	pMText->m_Location.y=frameBottom+18/2;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameRight-70;
	pLine->pt1.y=frameBottom+36;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=frameBottom;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameRight-70;
	pLine->pt1.y=frameBottom+6+15;
	pLine->pt2.x=frameRight;
	pLine->pt2.y=pLine->pt1.y;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameRight-70;
	pLine->pt1.y=frameBottom+6;
	pLine->pt2.x=frameRight;
	pLine->pt2.y=pLine->pt1.y;

	pLine=new CADLine();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=frameRight-50;
	pLine->pt1.y=frameBottom+6+15;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=frameBottom;

//create compass==============================
	CADBlock* pBlock;
	pBlock=new CADBlock();
	pDoc->m_pPaperGraphics->m_Blocks.Add((CObject*)pBlock);
	pBlock->m_nLayer=curLayerIndex;
	strcpy(pBlock->m_Name,"Compass");

	CADCircle* pCircle;
	pCircle=new CADCircle();
	pBlock->m_Entities.Add((CObject*)pCircle); 
	pCircle->m_nLayer=curLayerIndex;
	pCircle->ptCenter.x=0;
	pCircle->ptCenter.y=0;
	pCircle->m_Radius=4;

/*	pMText=new CADMText();
	pBlock->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="N";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=2;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	pMText->m_Location.x=0;
	pMText->m_Location.y=pCircle->m_Radius;*/

	pPolyline=new CADPolyline();
	pBlock->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=curLayerIndex;

	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = -pCircle->m_Radius;
	pPoint->y = 0;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = 0;
	pPoint->y = pCircle->m_Radius;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = pCircle->m_Radius;
	pPoint->y = 0;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = 0;
	pPoint->y = 0;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = 0;
	pPoint->y = -pCircle->m_Radius;

//============================================================

	CADInsert* pInsert;
	pInsert=new CADInsert();
	m_pCompassInsert=pInsert;
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pInsert);
	pInsert->m_nLayer=curLayerIndex;
	strcpy(pInsert->m_Name,"Compass");
	pInsert->pt.x=frameRight-60;
	pInsert->pt.y=frameBottom+6+15/2;

//create rule=================================================
	pPolyline=new CADPolyline();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=curLayerIndex;
	pPolyline->m_Closed = true;

	double rulerLeft=frameRight-40;
	double rulerTop=frameBottom+6+15/2+2;
	double rulerWidth=30;
	double rulerHeight=3;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = rulerLeft; 
	pPoint->y = rulerTop;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = rulerLeft+rulerWidth;
	pPoint->y = rulerTop;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = rulerLeft+rulerWidth;
	pPoint->y = rulerTop-rulerHeight;
	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint); 
	pPoint->x = rulerLeft;
	pPoint->y = rulerTop-rulerHeight;

	CADSolid* pSolid;
	pSolid=new CADSolid();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pSolid);
	pSolid->m_nLayer=curLayerIndex;
	pSolid->m_pt0.x = rulerLeft;
	pSolid->m_pt0.y = rulerTop;
	pSolid->m_pt1.x = rulerLeft+2;
	pSolid->m_pt1.y = rulerTop;
	pSolid->m_pt2.x = rulerLeft;
	pSolid->m_pt2.y = rulerTop-rulerHeight/2;
	pSolid->m_pt3.x = rulerLeft+2;
	pSolid->m_pt3.y = rulerTop-rulerHeight/2;

	pSolid=new CADSolid();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pSolid);
	pSolid->m_nLayer=curLayerIndex;
	pSolid->m_pt0.x = rulerLeft+2;
	pSolid->m_pt0.y = rulerTop-rulerHeight/2;
	pSolid->m_pt1.x = rulerLeft+2+8;
	pSolid->m_pt1.y = rulerTop-rulerHeight/2;
	pSolid->m_pt2.x = rulerLeft+2;
	pSolid->m_pt2.y = rulerTop-rulerHeight;
	pSolid->m_pt3.x = rulerLeft+2+8;
	pSolid->m_pt3.y = rulerTop-rulerHeight;

	pSolid=new CADSolid();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pSolid);
	pSolid->m_nLayer=curLayerIndex;
	pSolid->m_pt0.x = rulerLeft+2+8;
	pSolid->m_pt0.y = rulerTop;
	pSolid->m_pt1.x = rulerLeft+2+8+10;
	pSolid->m_pt1.y = rulerTop;
	pSolid->m_pt2.x = rulerLeft+2+8;
	pSolid->m_pt2.y = rulerTop-rulerHeight/2;
	pSolid->m_pt3.x = rulerLeft+2+8+10;
	pSolid->m_pt3.y = rulerTop-rulerHeight/2;

	pSolid=new CADSolid();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pSolid);
	pSolid->m_nLayer=curLayerIndex;
	pSolid->m_pt0.x = rulerLeft+2+8+10;
	pSolid->m_pt0.y = rulerTop-rulerHeight/2;
	pSolid->m_pt1.x = rulerLeft+2+8+10+10;
	pSolid->m_pt1.y = rulerTop-rulerHeight/2;
	pSolid->m_pt2.x = rulerLeft+2+8+10;
	pSolid->m_pt2.y = rulerTop-rulerHeight;
	pSolid->m_pt3.x = rulerLeft+2+8+10+10;
	pSolid->m_pt3.y = rulerTop-rulerHeight;

	if(m_PaperScale>0)
	{
		int cm=m_PaperScale/100;
		int perCm=cm/5;
		CString str;
		str.Format("%d",perCm);

		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text="0";
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=2;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Location.x=rulerLeft;
		pMText->m_Location.y=rulerTop;

		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=str;
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=2;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Location.x=rulerLeft+2;
		pMText->m_Location.y=rulerTop;

		str.Format("%d",cm);
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=str;
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=2;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Location.x=rulerLeft+2+8;
		pMText->m_Location.y=rulerTop;

		str.Format("%d",cm*2);
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=str;
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=2;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Location.x=rulerLeft+2+8+10;
		pMText->m_Location.y=rulerTop;

		str.Format("%d",cm*3);
		str=str+"m";
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=str;
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=2;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Location.x=rulerLeft+2+8+10+10;
		pMText->m_Location.y=rulerTop;
	}

//============================================================
	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="日  期";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=frameRight-70+20/2;
	pMText->m_Location.y=frameBottom+6/2;

	CTime time;
	time=CTime::GetCurrentTime();
	CString str2=time.Format("%Y.%m.%d");

	pMText=new CADMText();
	pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=str2;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=frameRight-50/2;
	pMText->m_Location.y=frameBottom+6/2;
//==============================================================
	pDoc->m_pPaperGraphics->m_PaperOrient=VERTICAL;
	pDoc->m_pPaperGraphics->CalZoomRate();
	ADPOINT adPoint;
	adPoint.x=frameLeft;
	adPoint.y=frameTop-30;
	CPoint point;
	point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
	m_ModelRect.left=point.x+1;
	m_ModelRect.top=point.y+1;

	adPoint.x=frameRight;
	adPoint.y=frameBottom+36;
	point=pDoc->m_pPaperGraphics->DocToClient(adPoint);
	m_ModelRect.right=point.x-1;
	m_ModelRect.bottom=point.y-1;
	return true;
}

void CMiniCADView::OnUpdateZoomin(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);	
}

void CMiniCADView::OnUpdateZoomout(CCmdUI* pCmdUI) 
{
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE);	
}

void CMiniCADView::OnEntityproperty() 
{
//	if(m_pEntityPropertyDlg==NULL)
//		m_pEntityPropertyDlg=new CDialog();
//	m_pEntityPropertyDlg->ShowWindow(SW_SHOW);
	CMiniCADDoc* pDoc = this->GetDocument();
	if(CDrawTool::GetType()==selectTool && pDoc->m_Graphics.m_SelectedEntities.GetSize()==1)
	{
		CADEntity* pEntity=(CADEntity*)pDoc->m_Graphics.m_SelectedEntities.GetAt(0);
		int index;
		if(pEntity->m_LTypeName)
		{
			index=pDoc->m_Graphics.IndexOfLTypes(pEntity->m_LTypeName);
		}
		else
		{
			CADLayer* pLayer=pDoc->m_Graphics.m_pLayerGroup->GetLayer(pEntity->m_nLayer);
			index=pDoc->m_Graphics.IndexOfLTypes(pLayer->m_LTypeName);
		}
		if(index==-1)
			return;
		CDlgEntityProperty dlg;
		dlg.m_curSelIndex=index;
		dlg.m_Scale=pEntity->m_LTypeScale; 
		if(dlg.DoModal()==IDOK)
		{
			if(pEntity->m_LTypeName==NULL)
			pEntity->m_LTypeName=new char[AD_MAX_STRLEN];
			if(dlg.m_curSelIndex<0)return;
			CADLType* pLType=(CADLType*)pDoc->m_Graphics.m_LTypes.GetAt(dlg.m_curSelIndex); 
			strcpy(pEntity->m_LTypeName,pLType->m_Name);
			pEntity->m_LTypeScale=dlg.m_Scale;
			ReDraw();
		}
	}
}

void CMiniCADView::OnUpdateEditCutshort(CCmdUI* pCmdUI) 
{
	pCmdUI->SetRadio(CDrawTool::GetType()==cutshortTool);	
}

void CMiniCADView::OnEditCutshort() 
{
	//m_curDrawTool = cutshortTool;
	CDrawTool::SetTool(cutshortTool);	
	Resume();
}

void CMiniCADView::OnSplineCutshort() 
{
	CMiniCADDoc* pDoc = GetDocument();
	CADSpline* pSpline=(CADSpline*)pDoc->m_Graphics.m_SelectedEntities.GetAt(0);
	short ptSize=pSpline->m_FitPoint.GetSize();
	if (ptSize < 2) return;
	short nCutIndex=ptSize/2;
	if (ptSize == 2)
	{
		CADSpline* pSpline2=new CADSpline();
		pSpline2->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		pDoc->m_Graphics.m_Entities.Add((CObject*)pSpline2);
		
	}
	else
	{
		CADSpline* pSpline2=new CADSpline();
		pSpline2->m_nLayer=pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		pDoc->m_Graphics.m_Entities.Add((CObject*)pSpline2); 
		for(int i=nCutIndex;i<=ptSize-1;i++)
		{
			ADPOINT* pPoint;
			if(i==nCutIndex)
			{
				pPoint=new ADPOINT();
				pSpline2->m_FitPoint.Add((CObject*)pPoint);
				*pPoint = *(ADPOINT*)pSpline->m_FitPoint.GetAt(i);
			}
			else
			{
				pPoint =(ADPOINT*)pSpline->m_FitPoint.GetAt(i);
				pSpline2->m_FitPoint.Add((CObject*)pPoint);
			}
		}
		for(i=nCutIndex+1;i<=ptSize-1;i++)
		{
			pSpline->m_FitPoint.RemoveAt(nCutIndex+1);		
		}
	}
	ReDraw();		
}

void CMiniCADView::DrawTrackingLayer()
{
	CMiniCADDoc* pDoc = GetDocument();
	pDoc->m_Graphics.DrawHandle(m_pDC);
	if (m_pTempEntity != NULL && m_pTempEntity->GetType()==AD_ENT_POLYLINE)
	pDoc->m_Graphics.DrawGraphics(m_pDC,m_pTempEntity);	
}

LRESULT CMiniCADView::WindowProc(UINT message, WPARAM wParam, LPARAM lParam)
{
	#define LOWORD(l)   ((WORD) (l)) 
	#define HIWORD(l)   ((WORD) (((DWORD) (l) >> 16) & 0xFFFF))
	switch(message)
	{
		case WM_MBUTTONDOWN:
		{
			::SetCursor(AfxGetApp()->LoadCursor(IDC_HANDLE));
			CDrawTool::c_bMDown = true;
			m_MPointDown.x = LOWORD(lParam);
			m_MPointDown.y = HIWORD(lParam);
			break;
		}
		case WM_MBUTTONUP:
		{
			CMiniCADDoc* pDoc = GetDocument();
			CDrawTool::c_bMDown = false;
			double ddx,ddy;
			int dx,dy;
			dx=LOWORD(lParam)-m_MPointDown.x;
			dy=HIWORD(lParam)-m_MPointDown.y;
			if (CDrawTool::c_pCurDrawTool != NULL)
				CDrawTool::c_pCurDrawTool->Move(dx,dy);
			/*m_PointDown.x += dx;
			m_PointDown.y += dy;
			m_PointOrigin.x += dx;
			m_PointOrigin.y += dy;
			m_PointOld.x += dx;
			m_PointOld.y += dy;*/
			if(m_curWorkSpace==MODELSPACE)
			{
				ddx=dx/pDoc->m_Graphics.m_ZoomRate;
				ddy=dy/pDoc->m_Graphics.m_ZoomRate;
				pDoc->m_Graphics.m_Bound.Offset(-ddx,-ddy);
				ReDraw();
			}
			else
			{
				CDC* pPaperDC=m_pDisplay->GetPaperDC();
				ddx=dx/pDoc->m_Graphics.m_ZoomRate;
				ddy=dy/pDoc->m_Graphics.m_ZoomRate;
				pDoc->m_Graphics.m_Bound.Offset(-ddx,-ddy);

				CPoint point1;
				point1=pDoc->m_Graphics.DocToClient(m_RotatePt);
				pDoc->m_Graphics.RotateAll(m_pDisplay->GetDC(),point1,-(int)pDoc->m_Graphics.m_RotateAngle);

				//pDoc->m_Graphics.DrawGraphics(m_pDisplay->GetDC());
				pPaperDC->BitBlt(m_ModelRect.left,m_ModelRect.top,m_ModelRect.Width(),m_ModelRect.Height(),m_pDisplay->GetDC(),0,0,SRCCOPY);	
				Invalidate(false);			
			}
			break;
		}
	}
	return CView::WindowProc(message, wParam, lParam);
}

void CMiniCADView::OnLabelcoord() 
{
	Resume();
//	m_curDrawTool = labelCoordTool;
	CDrawTool::SetTool(labelCoordTool);
}

void CMiniCADView::OnUpdateLabelcoord(CCmdUI* pCmdUI) 
{
	CMiniCADDoc* pDoc = this->GetDocument();
	pCmdUI->Enable(m_curWorkSpace==MODELSPACE && pDoc->m_isLayout);		
}

void CMiniCADView::SetProjectLineWidth(CADEntity* pEntity)
{
	CMiniCADDoc* pDoc = this->GetDocument();
	if (pDoc->m_ProjectType == PROJECT_SECTION)
		pEntity->m_nLineWidth = 2;
}

void CMiniCADView::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags) 
{
	// TODO: Add your message handler code here and/or call default
	CSize size1;
	size1.cx = 0;
	size1.cy = 0;
	if (nChar == VK_UP)
	{
		size1.cx = 0;
		size1.cy = -1;
	}
	else if (nChar == VK_DOWN)
	{
		size1.cx = 0;
		size1.cy = 1;
	}
	else if (nChar == VK_LEFT)
	{
		size1.cx = -1;
		size1.cy = 0;
	}
	else if (nChar == VK_RIGHT)
	{
		size1.cx = 1;
		size1.cy = 0;
	}
	CMiniCADDoc* pDoc = this->GetDocument();
	pDoc->m_Graphics.MoveEntitiesTo(size1);
	ReDraw();
	CView::OnKeyDown(nChar, nRepCnt, nFlags);
}

