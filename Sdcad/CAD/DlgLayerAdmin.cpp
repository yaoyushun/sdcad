// DlgLayerAdmin.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "DlgLayerAdmin.h"
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
// CDlgLayerAdmin dialog


CDlgLayerAdmin::CDlgLayerAdmin(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgLayerAdmin::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgLayerAdmin)
	m_lstLayerValue = _T("");
	//}}AFX_DATA_INIT
}


void CDlgLayerAdmin::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgLayerAdmin)
	DDX_Control(pDX, IDC_LIST1, m_lstLayer);
	DDX_LBString(pDX, IDC_LIST1, m_lstLayerValue);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgLayerAdmin, CDialog)
	//{{AFX_MSG_MAP(CDlgLayerAdmin)
	ON_LBN_SELCHANGE(IDC_LIST1, OnSelchangeList1)
	ON_EN_CHANGE(IDC_EDIT1, OnChangeEdit1)
	ON_BN_CLICKED(IDC_CHK_LAYERON, OnChkLayeron)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgLayerAdmin message handlers

BOOL CDlgLayerAdmin::OnInitDialog() 
{
	CDialog::OnInitDialog();
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	
	m_LayerOn=new bool[pDoc->m_LayerGroup.GetLayerCount()];
	for(int i=0;i<pDoc->m_LayerGroup.GetLayerCount();i++)
	{
		CADLayer* pLayer;
		pLayer=pDoc->m_LayerGroup.GetLayer(i);
		m_lstLayer.AddString(pLayer->m_Name);
		if(pLayer->m_nColor<0)
			m_LayerOn[i]=false;
		else
			m_LayerOn[i]=true;
	}
	return TRUE;
}

void CDlgLayerAdmin::OnSelchangeList1() 
{
	int selIndex=m_lstLayer.GetCurSel();
	CString str;
	m_lstLayer.GetText(selIndex,str);
	if(m_LayerOn[selIndex])
		this->CheckDlgButton(IDC_CHK_LAYERON,1);
	else
		this->CheckDlgButton(IDC_CHK_LAYERON,0);
	UpdateData(true);
	GetDlgItem(IDC_EDIT1)->SetWindowText(m_lstLayerValue);
	
}

void CDlgLayerAdmin::OnOK() 
{
	CMainFrame*	 m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	for(int i=0;i<m_lstLayer.GetCount();i++)
	{
		CADLayer* pLayer;
		pLayer=pDoc->m_LayerGroup.GetLayer(i);
		CString str;
		m_lstLayer.GetText(i,str);
		if(pLayer)
		{
			strcpy(pLayer->m_Name,str);
			if(!m_LayerOn[i])pLayer->m_nColor=-abs(pLayer->m_nColor);
			else pLayer->m_nColor=abs(pLayer->m_nColor);
		}
	}
	CDialog::OnOK();
}

void CDlgLayerAdmin::OnChangeEdit1() 
{
	if(this->GetFocus()==GetDlgItem(IDC_EDIT1))
	{
		//int i=m_lstLayer.GetCurSel();
		//m_lstLayer.DeleteString(i);
		//m_lstLayer.InsertString(i,"hhh");
		CString str;
		str="fsd";
		GetDlgItem(IDC_EDIT1)->GetWindowText(str);
		str="fsd";
		CWnd* pWnd=GetDlgItem(IDC_LIST1);
		//m_lstLayer.SetSel(1,false);
	//	::SendMessage(pWnd->m_hWnd, LB_SELECTSTRING,(WPARAM)-1,(LPARAM)(LPCTSTR)str);
		//::SendMessage(pWnd->m_hWnd, LB_GETTEXT,1,(LPARAM)(LPVOID)str.GetBufferSetLength(5));
	//	str=(LPTSTR)m_lstLayer.GetItemDataPtr(1);
		m_lstLayer.SelectString(-1,"Í¼²ã1");
	}
	//m_lstLayerValue="dddd";
	//UpdateData(true);
}

void CDlgLayerAdmin::OnChkLayeron() 
{
	int selIndex=m_lstLayer.GetCurSel();
	if(IsDlgButtonChecked(IDC_CHK_LAYERON))m_LayerOn[selIndex]=true;
	else m_LayerOn[selIndex]=false;
}
