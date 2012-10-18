// MiniCAD.h : main header file for the MINICAD application
//

#if !defined(AFX_MINICAD_H__95245B81_41B0_47F5_A5D1_697F1561A8E3__INCLUDED_)
#define AFX_MINICAD_H__95245B81_41B0_47F5_A5D1_697F1561A8E3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CMiniCADApp:
// See MiniCAD.cpp for the implementation of this class
//

enum PROJECTTYPE
{
	PROJECT_SECTION,
	PROJECT_HISTOGRAM,
	PROJECT_STATIC,
	PROJECT_LAYOUT,
	PROJECT_LEGEND,
	PROJECT_CROSSBOARD,
	PROJECT_CompressionCurve,//Added on 2007/01/23
	PROJECT_HISTOGRAM2,
	PROJECT_HISTOGRAM3,
	PROJECT_HISTOGRAM4
};

class CMiniCADApp : public CWinApp
{
public:
	CMiniCADApp();

public:
	//CMiniCADDoc* m_pDoc;
	CString m_SaveAsFilename;
	void MenuInit();
	bool m_bSave;
	PROJECTTYPE m_ProjectType;
	bool SetProjectIni();
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMiniCADApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CMiniCADApp)
	afx_msg void OnAppAbout();
	afx_msg void OnUpdateFileNew(CCmdUI* pCmdUI);
	afx_msg void OnUpdateFileOpen(CCmdUI* pCmdUI);
	afx_msg void OnUpdateFileSave(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MINICAD_H__95245B81_41B0_47F5_A5D1_697F1561A8E3__INCLUDED_)
