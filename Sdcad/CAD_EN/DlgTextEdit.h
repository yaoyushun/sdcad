#if !defined(AFX_DLGTEXTEDIT_H__38859DCD_C0E2_4EB9_B94D_69C999B59E16__INCLUDED_)
#define AFX_DLGTEXTEDIT_H__38859DCD_C0E2_4EB9_B94D_69C999B59E16__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgTextEdit.h : header file
//
#include "MyRichEdit.h"
/////////////////////////////////////////////////////////////////////////////
// CDlgTextEdit dialog
#include "AutoCAD/ADEntities.h"

class CDlgTextEdit : public CDialog
{
// Construction
public:
	CDlgTextEdit(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlgTextEdit)
	enum { IDD = IDD_DLG_TEXT };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA
	CMyRichEdit	m_MyRichEditCtrl;
	CADMText*	m_pMText;
	CMiniCADView *m_pView;
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgTextEdit)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;
	// Generated message map functions
	//{{AFX_MSG(CDlgTextEdit)
	afx_msg void OnButton1();
	virtual BOOL OnInitDialog();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnPaint();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGTEXTEDIT_H__38859DCD_C0E2_4EB9_B94D_69C999B59E16__INCLUDED_)
