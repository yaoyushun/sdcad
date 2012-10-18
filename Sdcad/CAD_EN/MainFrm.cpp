// MainFrm.cpp : implementation of the CMainFrame class
//

#include "stdafx.h"
#include "MiniCAD.h"

#include "MainFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

BEGIN_MESSAGE_MAP(CToolBarDisp, CToolBar)
	//{{AFX_MSG_MAP(CToolBarDisp)
	ON_CBN_SELENDOK(202, OnSelectPaper)
	ON_CBN_SELENDOK(204, OnSelectScale)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CToolBarDisp 
#ifdef _DEBUG
void CToolBarDisp::AssertValid() const
{
	CToolBar::AssertValid();
}

void CToolBarDisp::Dump(CDumpContext& dc) const
{
	CToolBar::Dump(dc);
}

#endif //_DEBUG

CToolBarDisp::CToolBarDisp()
{
}

CToolBarDisp::~CToolBarDisp()
{
}

void CToolBarDisp::OnSelectPaper()
{
	int i;
	i=this->m_cboPaper.GetItemData(m_cboPaper.GetCurSel());

	CMDIChildWnd* pChild=(CMDIChildWnd*)((CMainFrame*)::AfxGetMainWnd())->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	pView->ChangePaper(m_cboPaper.GetItemData(m_cboPaper.GetCurSel())); 
}

void CToolBarDisp::OnSelectScale()
{
	int i;
	i=this->m_cboScale.GetItemData(m_cboScale.GetCurSel());

	CMDIChildWnd* pChild=(CMDIChildWnd*)((CMainFrame*)::AfxGetMainWnd())->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	pView->ChangeScale(m_cboScale.GetItemData(m_cboScale.GetCurSel())); 
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame

IMPLEMENT_DYNAMIC(CMainFrame, CMDIFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CMDIFrameWnd)
	//{{AFX_MSG_MAP(CMainFrame)
	ON_WM_CREATE()
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // status line indicator
	ID_MousePoint,
    ID_SEPARATOR,
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

/////////////////////////////////////////////////////////////////////////////
// CMainFrame construction/destruction

CMainFrame::CMainFrame()
{
	// TODO: add member initialization code here
	
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CMDIFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	if (!m_wndToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_wndToolBar.LoadToolBar(IDR_MAINFRAME))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create
	}

	CRect rect,rcDisp;
	//m_wndToolBar.GetItemRect(0, &rcDisp);
	//m_wndToolBar.SetSizes(rcDisp.Size(), CSize(16,15));
	
	m_wndToolBar.SetButtonInfo(20, 200, TBSTYLE_SEP, 80);
	m_wndToolBar.GetItemRect(20, &rect);
	
	rect.bottom=rect.top+100;
	if (!m_wndToolBar.m_cboPaper.Create(WS_VISIBLE | WS_CHILD | /*CBS_AUTOHSCROLL |*/ CBS_DROPDOWNLIST | CBS_SIMPLE,rect,&m_wndToolBar,202)){
		return FALSE;
	}

	m_wndToolBar.m_font.CreateFont(12, 0, 0, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET, 0, 0, 0, 0, "宋体");
	m_wndToolBar.m_cboPaper.SetFont(&m_wndToolBar.m_font);

	if (!m_wndStatusBar.Create(this) ||
		!m_wndStatusBar.SetIndicators(indicators,
		  sizeof(indicators)/sizeof(UINT)))
	{
		TRACE0("Failed to create status bar\n");
		return -1;      // fail to create
	}
//-----------------------------------------------------------------------------------
	if (!m_PropertyBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_TOP
		| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
		!m_PropertyBar.LoadToolBar(IDR_TOOLBAR3))
	{
		TRACE0("Failed to create toolbar\n");
		return -1;      // fail to create   
	}

	m_PropertyBar.SetButtonInfo(2, 100, TBSTYLE_SEP, 80);
	m_PropertyBar.GetItemRect(2, &rect);
	
	rect.bottom=rect.top+160;
	if (!m_PropertyBar.m_cboScale.Create(WS_VISIBLE | WS_CHILD | /*CBS_AUTOHSCROLL |*/ CBS_DROPDOWNLIST | CBS_SIMPLE | CBS_DISABLENOSCROLL,rect,&m_PropertyBar,204)){
		return FALSE;
	}

	m_PropertyBar.m_font.CreateFont(12, 0, 0, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET, 0, 0, 0, 0, "宋体");
	m_PropertyBar.m_cboScale.SetFont(&m_PropertyBar.m_font);
	m_PropertyBar.m_cboScale.AddString("1000%");
	m_PropertyBar.m_cboScale.AddString("900%");
	m_PropertyBar.m_cboScale.AddString("800%");
	m_PropertyBar.m_cboScale.AddString("700%");
	m_PropertyBar.m_cboScale.AddString("600%");
	m_PropertyBar.m_cboScale.AddString("500%");
	m_PropertyBar.m_cboScale.AddString("400%");
	m_PropertyBar.m_cboScale.AddString("300%");
	m_PropertyBar.m_cboScale.AddString("200%");
	m_PropertyBar.m_cboScale.AddString("100%");
	m_PropertyBar.m_cboScale.AddString("50%");
	m_PropertyBar.m_cboScale.SetItemData(0,1000);
	m_PropertyBar.m_cboScale.SetItemData(1,900);
	m_PropertyBar.m_cboScale.SetItemData(2,800);
	m_PropertyBar.m_cboScale.SetItemData(3,700);
	m_PropertyBar.m_cboScale.SetItemData(4,600);
	m_PropertyBar.m_cboScale.SetItemData(5,500);
	m_PropertyBar.m_cboScale.SetItemData(6,400);
	m_PropertyBar.m_cboScale.SetItemData(7,300);
	m_PropertyBar.m_cboScale.SetItemData(8,200);
	m_PropertyBar.m_cboScale.SetItemData(9,100);
	m_PropertyBar.m_cboScale.SetItemData(10,50);
	m_PropertyBar.m_cboScale.SetCurSel(9);
	// TODO: Delete these three lines if you don't want the toolbar to
	//  be dockable
	m_wndToolBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_wndToolBar);


///CREATE draw toolbar
	CMiniCADApp* pApp=(CMiniCADApp*)AfxGetApp();
///	if(pApp->m_ProjectType==PROJECT_LAYOUT)
///	{
		if (!m_DrawToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_LEFT
			| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
			!m_DrawToolBar.LoadToolBar(IDR_TOOLBAR1))
		{
			TRACE0("Failed to create toolbar\n");
			return -1;      // fail to create   
		}

		if (!m_EditToolBar.CreateEx(this, TBSTYLE_FLAT, WS_CHILD | WS_VISIBLE | CBRS_LEFT
			| CBRS_GRIPPER | CBRS_TOOLTIPS | CBRS_FLYBY | CBRS_SIZE_DYNAMIC) ||
			!m_EditToolBar.LoadToolBar(IDR_TOOLBAR2))
		{
			TRACE0("Failed to create toolbar\n");
			return -1;      // fail to create   
		}

		m_DrawToolBar.EnableDocking(CBRS_ALIGN_ANY);
		EnableDocking(CBRS_ALIGN_ANY);
		DockControlBar(&m_DrawToolBar);

		m_EditToolBar.EnableDocking(CBRS_ALIGN_ANY);
		EnableDocking(CBRS_ALIGN_ANY);
		DockControlBar(&m_EditToolBar);
///	}

	m_PropertyBar.EnableDocking(CBRS_ALIGN_ANY);
	EnableDocking(CBRS_ALIGN_ANY);
	DockControlBar(&m_PropertyBar);
	return 0;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CMDIFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CMainFrame diagnostics

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CMDIFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CMDIFrameWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMainFrame message handlers

void CMainFrame::SetMousePosText(ADPOINT DocPoint)
{
	CString strText;
	strText.Format("当前坐标:%.4lf,  %.4lf",DocPoint.x,DocPoint.y);
	int nIndex=m_wndStatusBar.CommandToIndex(ID_MousePoint);
	m_wndStatusBar.SetPaneText(nIndex,strText);
}

void CMainFrame::AddComboPaper(LPCTSTR str,int i)
{
	m_wndToolBar.m_cboPaper.AddString(str);
	int j=m_wndToolBar.m_cboPaper.GetCount();
	m_wndToolBar.m_cboPaper.SetItemData(j-1,i);
}

void CMainFrame::SetComboSel(int index)
{
	if(index>m_wndToolBar.m_cboPaper.GetCount()-1)return;
	m_wndToolBar.m_cboPaper.SetCurSel(index);
}

void CMainFrame::OnClose() 
{
/*	CMDIChildWnd* pChild=(CMDIChildWnd*)GetActiveFrame();
	if(!pChild)
	{
		CMDIFrameWnd::OnClose();
		return;
	}
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	if(!pView)
	{
		CMDIFrameWnd::OnClose();
		return;
	}
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	if(!pDoc)
	{
		CMDIFrameWnd::OnClose();
		return;
	}
	if(pDoc->m_ProjectType!=PROJECT_SECTION && pDoc->m_ProjectType!=PROJECT_LAYOUT)pDoc->SetModifiedFlag(false);
*/
	CMDIFrameWnd::OnClose();
}
