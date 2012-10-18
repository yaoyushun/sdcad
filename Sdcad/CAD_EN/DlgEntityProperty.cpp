// DlgEntityProperty.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "DlgEntityProperty.h"

#include "MainFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgEntityProperty dialog


CDlgEntityProperty::CDlgEntityProperty(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgEntityProperty::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgEntityProperty)
	m_Scale = 0.0;
	//}}AFX_DATA_INIT
	m_curSelIndex=-1;
}


void CDlgEntityProperty::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgEntityProperty)
	DDX_Text(pDX, IDC_EDIT1, m_Scale);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgEntityProperty, CDialog)
	//{{AFX_MSG_MAP(CDlgEntityProperty)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgEntityProperty message handlers

BOOL CDlgEntityProperty::OnInitDialog() 
{
	CDialog::OnInitDialog();
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();

	m_LType.m_pGraphics=&pDoc->m_Graphics;
	m_LType.SubclassDlgItem(IDC_COMBO1,this);	
	m_LType.AddAllItem();
	m_LType.SetItemIndex(m_curSelIndex); 
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CDlgEntityProperty::OnOK() 
{
	this->UpdateData(true);
	m_curSelIndex=m_LType.GetItemIndex();	
	CDialog::OnOK();
}
