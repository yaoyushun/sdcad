// Dlg_PaperSetup.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "Dlg_PaperSetup.h"
#include "AutoCAD\ADGraphics.h"
#include "MainFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlg_PaperSetup dialog


CDlg_PaperSetup::CDlg_PaperSetup(CWnd* pParent /*=NULL*/)
	: CDialog(CDlg_PaperSetup::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlg_PaperSetup)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CDlg_PaperSetup::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlg_PaperSetup)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlg_PaperSetup, CDialog)
	//{{AFX_MSG_MAP(CDlg_PaperSetup)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlg_PaperSetup message handlers

BOOL CDlg_PaperSetup::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	
	if(pDoc->m_Graphics.m_PaperOrient==HORIZONTAL)
	{
		this->CheckDlgButton(IDC_RADIO2,1);
	}
	else
	{
		this->CheckDlgButton(IDC_RADIO1,1);
	}
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CDlg_PaperSetup::OnOK() 
{
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();

	if(IsDlgButtonChecked(IDC_RADIO2))
		pDoc->m_Graphics.m_PaperOrient=HORIZONTAL;
	if(IsDlgButtonChecked(IDC_RADIO1))
		pDoc->m_Graphics.m_PaperOrient=VERTICAL;	
	CDialog::OnOK();
}
