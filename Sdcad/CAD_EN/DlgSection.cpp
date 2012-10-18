// DlgSection.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "DlgSection.h"

#include "AutoCAD\ADGraphics.h"
#include "MainFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"
#include "DrawTool/DrawTool.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgSection dialog

CDlgSection::CDlgSection(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgSection::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgSection)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void CDlgSection::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgSection)
	DDX_Control(pDX, IDC_EDIT1, m_Edit1);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDlgSection, CDialog)
	//{{AFX_MSG_MAP(CDlgSection)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgSection message handlers

void CDlgSection::OnOK()
{
	CString str;
	GetDlgItem(IDC_EDIT1)->GetWindowText(str);
	if(str.IsEmpty())return;

	CMainFrame*	 m_pMain;
	m_pMain = (CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild = (CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
//	pView->m_curDrawTool = sectionLineTool;
	CDrawTool::SetTool(sectionLineTool);
	pView->m_SectionName = str;
	//CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	CDialog::OnOK();
}

BOOL CDlgSection::OnInitDialog() 
{
	CDialog::OnInitDialog();
	//GetDlgItem(IDC_EDIT1)->SetFocus();
	//m_Edit1.SetFocus();
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
