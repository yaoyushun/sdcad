// InsertHoleLayerDlg.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "InsertHoleLayerDlg.h"

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
// CInsertHoleLayerDlg dialog


CInsertHoleLayerDlg::CInsertHoleLayerDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CInsertHoleLayerDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CInsertHoleLayerDlg)
	m_HoleLayer = 1;
	m_Scale = 1.0f;
	//}}AFX_DATA_INIT
}


void CInsertHoleLayerDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CInsertHoleLayerDlg)
	DDX_Control(pDX, IDC_EDIT1, m_EdtSubHoleLayer);
	DDX_Text(pDX, IDC_EDIT1, m_HoleLayer);
	DDX_Text(pDX, IDC_EDIT3, m_Scale);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CInsertHoleLayerDlg, CDialog)
	//{{AFX_MSG_MAP(CInsertHoleLayerDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CInsertHoleLayerDlg message handlers

void CInsertHoleLayerDlg::OnOK() 
{
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	this->UpdateData(true);
	CString str;
	CString str2;
	//m_BlockName.GetWindowText(str);
	GetDlgItem(IDC_EDIT2)->GetWindowText(str2);
	if(str2.IsEmpty())
	//if(m_SubHoleLayer==0)
	{
		str.Format("Layer%d",m_HoleLayer); 
	}
	else
	{
		//str.Format("²ãºÅ%d-%d",m_HoleLayer,m_SubHoleLayer);
		str.Format("Layer%d-",m_HoleLayer);
		str += str2;
	}
	 
	int i = pDoc->m_Graphics.IndexOfBlocks((char*)(LPCTSTR)str);
	if (i==-1)
	{
		CADBlock* pBlock;
		pBlock=new CADBlock();
		pDoc->m_Graphics.m_Blocks.Add((CObject*)pBlock);
		strcpy(pBlock->m_Name,(LPCTSTR)str);
		pBlock->m_BasePoint.x=0;
		pBlock->m_BasePoint.y=0;		
		pBlock->m_nLayer=0;

		CADBlockRecord* pBlockRecord = new CADBlockRecord();
		pDoc->m_Graphics.m_BlockRecords.Add((CObject*)pBlockRecord);
		strcpy(pBlockRecord->m_Name,pBlock->m_Name);
		CADGraphics::CreateHandle(pBlockRecord->m_Handle);

		CADCircle* pCircle;
		pCircle=new CADCircle();
		pCircle->m_nLayer=0;
		pBlock->m_Entities.Add((CObject*)pCircle);
		pCircle->m_nColor=7;
		pCircle->ptCenter.x=0;
		pCircle->ptCenter.y=0;
		pCircle->m_Radius=1.5;

		CADMText* pMText;
		pMText=new CADMText();
		pMText->m_nLayer=0;
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nColor=7;
		pMText->m_Location.x=0;

		pMText->m_Text.Format("%d",m_HoleLayer);
		if(pMText->m_Text.GetLength()==1)
		{
			pMText->m_Location.y=0;
			pMText->m_Height=2.5;
		}
		else if(pMText->m_Text.GetLength()==2)
		{
			pMText->m_Location.y=0;
			pMText->m_Height=2;
		}
		else
		{
			pMText->m_Location.y=0;
			pMText->m_Height=1.6;		
		}
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;

		if(!str2.IsEmpty())
		//if(m_SubHoleLayer>0)
		{
			CADMText* pMText;
			pMText=new CADMText();
			pMText->m_nLayer=0;
			pBlock->m_Entities.Add((CObject*)pMText);
			pMText->m_nColor=7;
			pMText->m_Location.x=2*m_Scale;
			pMText->m_Location.y=0;
			//pMText->m_Text.Format("%d",m_SubHoleLayer);
			pMText->m_Text = str2;
			pMText->m_Height=2;
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT; 			
		}
	}

	CADInsert* pInsert = new CADInsert();
//	pDoc->m_Graphics.m_pTempInsert = pInsert;
	pView->m_pTempEntity = pInsert;
	pInsert->m_nLayer=0;
	strcpy(pInsert->m_Name,(LPCTSTR)str);
	pInsert->m_xScale=m_Scale;
	pInsert->m_yScale=m_Scale;
	pInsert->m_Rotation=0;
//	pView->m_curDrawTool=insertTool;
	CDrawTool::SetTool(insertTool);
	CDialog::OnOK();
}

BOOL CInsertHoleLayerDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	this->GetDlgItem(IDC_EDIT1)->SetFocus();
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
