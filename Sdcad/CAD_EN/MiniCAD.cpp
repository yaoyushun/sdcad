// MiniCAD.cpp : Defines the class behaviors for the application.
/*===============================================================
Author:Hyg
Date:2003-6
Function:draw some charts of project 

===============================================================*/

#include "stdafx.h"
#include "MiniCAD.h"

#include "MainFrm.h"
#include "ChildFrm.h"
#include "MiniCADDoc.h"
#include "MiniCADView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMiniCADApp

BEGIN_MESSAGE_MAP(CMiniCADApp, CWinApp)
	//{{AFX_MSG_MAP(CMiniCADApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
	ON_UPDATE_COMMAND_UI(ID_FILE_NEW, OnUpdateFileNew)
	ON_UPDATE_COMMAND_UI(ID_FILE_OPEN, OnUpdateFileOpen)
	ON_UPDATE_COMMAND_UI(ID_FILE_SAVE, OnUpdateFileSave)
	//}}AFX_MSG_MAP
	// Standard file based document commands
	ON_COMMAND(ID_FILE_NEW, CWinApp::OnFileNew)
	ON_COMMAND(ID_FILE_OPEN, CWinApp::OnFileOpen)
	// Standard print setup command
	ON_COMMAND(ID_FILE_PRINT_SETUP, CWinApp::OnFilePrintSetup)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMiniCADApp construction

CMiniCADApp::CMiniCADApp()
{
	m_bSave=false;
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CMiniCADApp object

CMiniCADApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CMiniCADApp initialization

BOOL CMiniCADApp::InitInstance()
{
//	AfxMessageBox(m_lpCmdLine);
//		return FALSE;

//---------------------------------------------
	if (m_lpCmdLine[0] == '\0')
	{
		return FALSE;
	}

	if(!SetProjectIni())return FALSE;
//---------------------------------------------

	AfxEnableControlContainer();
	::AfxInitRichEdit();
	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	// Change the registry key under which our settings are stored.
	// TODO: You should modify this string to be something appropriate
	// such as the name of your company or organization.
	SetRegistryKey(_T("Local AppWizard-Generated Applications"));

	LoadStdProfileSettings();  // Load standard INI file options (including MRU)

	// Register the application's document templates.  Document templates
	//  serve as the connection between documents, frame windows and views.

	CMultiDocTemplate* pDocTemplate;
	pDocTemplate = new CMultiDocTemplate(
		IDR_MINICATYPE,
		RUNTIME_CLASS(CMiniCADDoc),
		RUNTIME_CLASS(CChildFrame), // custom MDI child frame
		RUNTIME_CLASS(CMiniCADView));
	AddDocTemplate(pDocTemplate);

	// create main MDI Frame window
	CMainFrame* pMainFrame = new CMainFrame;
	if (!pMainFrame->LoadFrame(IDR_MAINFRAME))
		return FALSE;

	m_nCmdShow = SW_SHOWMAXIMIZED;// ADD THIS LINE!
	//pMainFrame->ShowWindow(m_nCmdShow);
	//pMainFrame->UpdateWindow();

	m_pMainWnd = pMainFrame;

	// Parse command line for standard shell commands, DDE, file open
/*	CCommandLineInfo cmdInfo;
	ParseCommandLine(cmdInfo);

	// Dispatch commands specified on the command line
	if (!ProcessShellCommand(cmdInfo))
		return FALSE;*/

	OnFileNew();

	// The main window has been initialized, so show and update it.
	pMainFrame->ShowWindow(m_nCmdShow);
	pMainFrame->UpdateWindow();

//	MenuInit();

	return TRUE;
}

void CMiniCADApp::MenuInit()
{
	CMenu *pFileMenu=m_pMainWnd->GetMenu();
	if(m_ProjectType!=PROJECT_LAYOUT)
	{
		pFileMenu->RemoveMenu(0,MF_BYPOSITION);
		pFileMenu->RemoveMenu(5,MF_BYPOSITION);
	}
	else
	{
		pFileMenu->RemoveMenu(0,MF_BYPOSITION);
	}
	//if(m_ProjectType!=PROJECT_SECTION)
	//	pFileMenu->RemoveMenu(3,MF_BYPOSITION);
}

bool CMiniCADApp::SetProjectIni()
{
	CString str=m_lpCmdLine;
	int i=str.Find(',');
	
	short flag=atoi(str.Left(i));

	CString filename;
	str = str.Right(str.GetLength()-i-1);
	i = str.Find(',');
	if (i>0)
		filename = str.Left(i);
	else
		filename=str.Right(str.GetLength()-i-1);

//保存用文件名
	char str2[255];
	::GetPrivateProfileString("图纸信息","保存用文件名","",str2,255,filename);
	m_SaveAsFilename = str2;

	switch(flag)
	{
		case 1:
			m_ProjectType=PROJECT_SECTION;
			break;
		case 2:
			m_ProjectType=PROJECT_HISTOGRAM;
			break;
		case 3:
			m_ProjectType=PROJECT_STATIC;
			break;
		case 4:
			m_ProjectType=PROJECT_LAYOUT;
			break;
		case 5:
			m_ProjectType=PROJECT_LEGEND;
			break;
		case 6:
			m_ProjectType=PROJECT_CROSSBOARD;
			break;
		//added on 2005/8/23
		case 7:
			m_ProjectType=PROJECT_STATIC;
			break;
		case 8:
			m_ProjectType=PROJECT_CompressionCurve;
			break;
		//added on 2008/11/10
		case 9:
			m_ProjectType=PROJECT_HISTOGRAM2;
			break;
		case 10:
			m_ProjectType=PROJECT_HISTOGRAM3;
			break;
		case 11:
			m_ProjectType=PROJECT_HISTOGRAM3;
			break;
		default:
			return false;
	}
	return true;
}
/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
		// No message handlers
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

// App command to run the dialog
void CMiniCADApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADApp message handlers

void CMiniCADApp::OnUpdateFileNew(CCmdUI* pCmdUI) 
{
	//pCmdUI->Enable(false);
}

void CMiniCADApp::OnUpdateFileOpen(CCmdUI* pCmdUI) 
{
	//pCmdUI->Enable(false);	
}

void CMiniCADApp::OnUpdateFileSave(CCmdUI* pCmdUI) 
{
//	pCmdUI->Enable(m_bSave);
/*	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*)m_pMainWnd;
	CMDIChildWnd* pChild=(CMDIChildWnd*)m_pMain->GetActiveFrame();
	CMiniCADView* pView = (CMiniCADView*) pChild->GetActiveView();
	CMiniCADDoc* pDoc=(CMiniCADDoc*)pView->GetDocument();
	pCmdUI->Enable(pDoc->m_ProjectType==PROJECT_SECTION);*/
}
