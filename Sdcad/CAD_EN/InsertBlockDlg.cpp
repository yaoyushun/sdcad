// InsertBlockDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "InsertBlockDlg.h"

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
// CInsertBlockDlg dialog


CInsertBlockDlg::CInsertBlockDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CInsertBlockDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CInsertBlockDlg)
	m_X = 0.0;
	m_Y = 0.0;
	m_xScale = 1.0;
	m_yScale = 1.0;
	m_Rotation = 0.0;
	//}}AFX_DATA_INIT
}

void CInsertBlockDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CInsertBlockDlg)
	DDX_Control(pDX, IDC_COMBO1, m_BlockName);
	DDX_Text(pDX, IDC_EDIT1, m_X);
	DDX_Text(pDX, IDC_EDIT2, m_Y);
	DDX_Text(pDX, IDC_EDIT3, m_xScale);
	DDX_Text(pDX, IDC_EDIT4, m_yScale);
	DDX_Text(pDX, IDC_EDIT5, m_Rotation);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CInsertBlockDlg, CDialog)
	//{{AFX_MSG_MAP(CInsertBlockDlg)
	ON_BN_CLICKED(IDC_CHECK1, OnCheck1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CInsertBlockDlg message handlers

BOOL CInsertBlockDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CheckDlgButton(IDC_CHECK1,1);
	GetDlgItem(IDC_EDIT1)->EnableWindow(false);	
	GetDlgItem(IDC_EDIT2)->EnableWindow(false);
	
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	
	for(int i=0;i<pDoc->m_Graphics.m_Blocks.GetSize();i++)
	{
		CADBlock* pBlock=(CADBlock*)pDoc->m_Graphics.m_Blocks.GetAt(i);
		CADLayer* pLayer=(CADLayer*)pDoc->m_Graphics.m_pLayerGroup->GetLayer(pBlock->m_nLayer);
		if(pLayer==NULL)continue;
		if(strcmp(pLayer->m_Name,PROJECTHOLELAYERNAME)!=0)continue;
		if(!strstr(pBlock->m_Name,"*"))
		m_BlockName.AddString(pBlock->m_Name); 
	}
	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

void CInsertBlockDlg::OnOK() 
{
	this->UpdateData(true);
	CString str;
	m_BlockName.GetWindowText(str);

	if(strcmp(str,"")==0)
		return;

	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();

	if(IsDlgButtonChecked(IDC_CHECK1))
	{
		CADInsert* pInsert = new CADInsert();
		//pDoc->m_Graphics.m_pTempInsert = pInsert;
		pView->m_pTempEntity = pInsert;
		pInsert->m_nLayer = pDoc->m_Graphics.m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME);
		strcpy(pInsert->m_Name,(LPCTSTR)str);
		pInsert->m_xScale=m_xScale;
		pInsert->m_yScale=m_yScale;
		pInsert->m_Rotation=m_Rotation;
		//pView->m_curDrawTool=insertTool;
		CDrawTool::SetTool(insertTool);
		CDialog::OnOK();
		return;
	}
	CADInsert* pInsert=new CADInsert();
	pInsert->m_nLayer = pDoc->m_Graphics.m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME);
	pInsert->pt.x=m_X;
	pInsert->pt.y=m_Y;
	pInsert->m_xScale=m_xScale;
	pInsert->m_yScale=m_yScale;
	pInsert->m_Rotation=m_Rotation;
	strcpy(pInsert->m_Name,(LPCTSTR)str);
	pInsert->m_nColor=7;
	pDoc->m_Graphics.m_Entities.Add((CObject*)pInsert);
	pDoc->m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC(),pInsert);
	pView->Invalidate(false);	
	CDialog::OnOK();
}

void CInsertBlockDlg::OnCheck1() 
{
	if(IsDlgButtonChecked(IDC_CHECK1))
	{
		GetDlgItem(IDC_EDIT1)->EnableWindow(false);	
		GetDlgItem(IDC_EDIT2)->EnableWindow(false);
	}
	else
	{
		GetDlgItem(IDC_EDIT1)->EnableWindow(true);	
		GetDlgItem(IDC_EDIT2)->EnableWindow(true);	
	}
}
