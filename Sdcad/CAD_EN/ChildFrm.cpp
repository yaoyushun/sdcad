// ChildFrm.cpp : implementation of the CChildFrame class
//

#include "stdafx.h"
#include "MiniCAD.h"

#include "ChildFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CChildFrame

IMPLEMENT_DYNCREATE(CChildFrame, CMDIChildWnd)

BEGIN_MESSAGE_MAP(CChildFrame, CMDIChildWnd)
	//{{AFX_MSG_MAP(CChildFrame)
	ON_WM_CREATE()
	ON_WM_CLOSE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CChildFrame construction/destruction

CChildFrame::CChildFrame()
{
	
}

CChildFrame::~CChildFrame()
{
}

BOOL CChildFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs

	if( !CMDIChildWnd::PreCreateWindow(cs) )
		return FALSE;

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CChildFrame diagnostics

#ifdef _DEBUG
void CChildFrame::AssertValid() const
{
	CMDIChildWnd::AssertValid();
}

void CChildFrame::Dump(CDumpContext& dc) const
{
	CMDIChildWnd::Dump(dc);
}

#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CChildFrame message handlers

int CChildFrame::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CMDIChildWnd::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	::PostMessage(GetParent()->m_hWnd, WM_MDIMAXIMIZE, (WPARAM)m_hWnd, 0L);	
	return 0;
}

void CChildFrame::OnClose() 
{
//	CMiniCADView* pView = (CMiniCADView*) GetActiveView();
//	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
//	if(pDoc->m_ProjectType!=PROJECT_SECTION  && pDoc->m_ProjectType!=PROJECT_LAYOUT)pDoc->SetModifiedFlag(false);
	
	CMDIChildWnd::OnClose();
}
