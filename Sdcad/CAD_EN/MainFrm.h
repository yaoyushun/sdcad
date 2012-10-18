// MainFrm.h : interface of the CMainFrame class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MAINFRM_H__10E894D1_D90C_487A_8C77_9C8A89B565A0__INCLUDED_)
#define AFX_MAINFRM_H__10E894D1_D90C_487A_8C77_9C8A89B565A0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "AutoCAD\ADGraphics.h"

class CToolBarDisp : public CToolBar
{
public:
	CStatic		m_Label;
	CComboBox	m_cboPaper;
	CComboBox	m_cboScale;
	CFont		m_font;

public:
	CToolBarDisp();
public:

public:

public:
	virtual ~CToolBarDisp();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

protected:
	//{{AFX_MSG(CToolBarDisp)
	afx_msg void OnSelectPaper();
	afx_msg void OnSelectScale();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

class CMainFrame : public CMDIFrameWnd
{
	DECLARE_DYNAMIC(CMainFrame)
public:
	CMainFrame();

// Attributes
public:
	void AddComboPaper(LPCTSTR str,int i);
	void SetComboSel(int index);
// Operations
public:
	void SetMousePosText(ADPOINT DocPoint);
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMainFrame)
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMainFrame();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:  // control bar embedded members
	CStatusBar  m_wndStatusBar;
	CToolBarDisp    m_wndToolBar;
	CToolBar    m_DrawToolBar;
	CToolBar    m_EditToolBar;
	CToolBarDisp    m_PropertyBar;
// Generated message map functions
protected:
	//{{AFX_MSG(CMainFrame)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnClose();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MAINFRM_H__10E894D1_D90C_487A_8C77_9C8A89B565A0__INCLUDED_)
