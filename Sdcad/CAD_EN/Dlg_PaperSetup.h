#if !defined(AFX_DLG_PAPERSETUP_H__DF6339F5_2013_403A_83AC_21A11EF08CCC__INCLUDED_)
#define AFX_DLG_PAPERSETUP_H__DF6339F5_2013_403A_83AC_21A11EF08CCC__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// Dlg_PaperSetup.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDlg_PaperSetup dialog

class CDlg_PaperSetup : public CDialog
{
// Construction
public:
	CDlg_PaperSetup(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlg_PaperSetup)
	enum { IDD = IDD_DIG_PAPERSETUP };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlg_PaperSetup)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlg_PaperSetup)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLG_PAPERSETUP_H__DF6339F5_2013_403A_83AC_21A11EF08CCC__INCLUDED_)
