// DlgTextEdit.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"


#include "AutoCAD\ADGraphics.h"
#include "MainFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"
#include "DlgTextEdit.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgTextEdit dialog


CDlgTextEdit::CDlgTextEdit(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgTextEdit::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDlgTextEdit)
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_pMText = NULL;
	m_pView = NULL;
	//}}AFX_DATA_INIT
}


void CDlgTextEdit::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgTextEdit)
	DDX_Control(pDX, IDC_RICHEDIT1, m_MyRichEditCtrl);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CDlgTextEdit, CDialog)
	//{{AFX_MSG_MAP(CDlgTextEdit)
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_WM_PAINT()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgTextEdit message handlers

void CDlgTextEdit::OnButton1() 
{
	m_MyRichEditCtrl.OnSelectfont();		
}

BOOL CDlgTextEdit::OnInitDialog() 
{
	CDialog::OnInitDialog();
	this->GetDlgItem(IDC_RICHEDIT1)->SetFocus();
	//m_MyRichEditCtrl.SetWindowText("ssddff\rsssddff");

	if (m_pView==NULL)return FALSE;
//	CADMText* m_pLabel = (CADMText*)m_pFigureEditCtrl->m_pTempEntity;//pView->m_pTempEntity;
	//m_MyRichEditCtrl.GetWindowText(m_pLabel->m_Text);

	if (m_pMText==NULL)
		m_MyRichEditCtrl.SetWindowText("");
	else
	{
		m_MyRichEditCtrl.SetWindowText(m_pMText->m_Text);
		if (m_pMText->m_Text!="")
		{
			m_MyRichEditCtrl.SetSel(0, -1);
			
			//::AfxMessageBox("str");
/**	SetSel(0, -1);

	CHARFORMAT cf;
	LOGFONT lf;
	memset(&cf, 0, sizeof(CHARFORMAT));
	memset(&lf, 0, sizeof(LOGFONT));
	//判断是否选择了内容
	BOOL m_bSelect = (GetSelectionType() != SEL_EMPTY) ? TRUE : FALSE;
	if (m_bSelect)
	{
		GetSelectionCharFormat(cf);
	}
	else
	{
		GetDefaultCharFormat(cf);
	}
	//得到相关字体属性
	BOOL bIsBold = cf.dwEffects & CFE_BOLD;
	BOOL bIsItalic = cf.dwEffects & CFE_ITALIC;
	BOOL bIsUnderline = cf.dwEffects & CFE_UNDERLINE;
	BOOL bIsStrickout = cf.dwEffects & CFE_STRIKEOUT;
	//设置属性
	lf.lfCharSet = cf.bCharSet;
	lf.lfHeight = cf.yHeight/15;
	lf.lfPitchAndFamily = cf.bPitchAndFamily;
	lf.lfItalic = bIsItalic;
	lf.lfWeight = (bIsBold ? FW_BOLD : FW_NORMAL);
	lf.lfUnderline = bIsUnderline;
	lf.lfStrikeOut = bIsStrickout;
	sprintf(lf.lfFaceName, cf.szFaceName);*/

			CHARFORMAT cf;
			memset(&cf, 0, sizeof(CHARFORMAT));
			m_MyRichEditCtrl.GetSelectionCharFormat(cf);
			
			CMiniCADDoc* pDoc = m_pView->GetDocument();
			if (pDoc==NULL)return FALSE;
			cf.yHeight = pDoc->m_Graphics.DocToClient(m_pMText->m_Height)*15;//40*15;
			//CString str;
			//str.Format("%d",cf.yHeight);
			//::AfxMessageBox(str);
			cf.dwEffects = CFE_AUTOCOLOR;
			//cf.crTextColor = m_pLabel->m_nColor;
			//cf.dwEffects = 0;
			m_MyRichEditCtrl.SetSelectionCharFormat(cf);//SetWordCharFormat(cf);
		}
	}

	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

int CDlgTextEdit::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	//m_MyRichEditCtrl.MoveWindow(CRect(100,100,400,400));
	//m_MyRichEditCtrl.Create(ES_MULTILINE,CRect(100,100,400,400),this,IDC_RICHEDIT1);	
	return 0;
}

void CDlgTextEdit::OnSize(UINT nType, int cx, int cy) 
{
	CDialog::OnSize(nType, cx, cy);	
}

void CDlgTextEdit::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

void CDlgTextEdit::OnOK() 
{
	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();

/*	if (m_pMText==NULL)
	{
		CADMText* pMText=new CADMText();
		pDoc->m_Graphics.m_Entities.Add((CObject *)pMText);
		//pView->m_pTempEntity=pMText;
		pMText->m_nLayer = 0;//pDoc->m_LayerGroup.indexOf(pDoc->m_curLayer);
		pMText->m_Location = pDoc->m_Graphics.ClientToDoc(m_PointOrigin);
		pMText->m_Height=2.5;
		pMText->m_Width=20;
	}
*/
	m_MyRichEditCtrl.SetSel(0, -1);
	CHARFORMAT cf;
	LOGFONT lf;
	memset(&cf, 0, sizeof(CHARFORMAT));
	memset(&lf, 0, sizeof(LOGFONT));
	//判断是否选择了内容
	BOOL m_bSelect = (m_MyRichEditCtrl.GetSelectionType() != SEL_EMPTY) ? TRUE : FALSE;
	if (m_bSelect)
	{
		m_MyRichEditCtrl.GetSelectionCharFormat(cf);
	}
	else
	{
		m_MyRichEditCtrl.GetDefaultCharFormat(cf);
	}

	m_pMText->m_Height = pDoc->m_Graphics.ClientToDoc(cf.yHeight/15);
	CString str;
	str.Format("%d",m_pMText->m_Height);
	//::AfxMessageBox(str);

	//CADMText* pMText=(CADMText*)pDoc->m_Graphics.m_pTempEntity;
	//CADMText* pMText=(CADMText*)pView->m_pTempEntity;
	m_MyRichEditCtrl.GetWindowText(m_pMText->m_Text);
	pView->ReDraw(); 
	pView->Invalidate(false);
	CDialog::OnOK();
}
