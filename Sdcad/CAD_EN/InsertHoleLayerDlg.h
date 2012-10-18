#if !defined(AFX_INSERTHOLELAYERDLG_H__D7BB7BF0_007B_45FA_876D_6372AF2BB0FE__INCLUDED_)
#define AFX_INSERTHOLELAYERDLG_H__D7BB7BF0_007B_45FA_876D_6372AF2BB0FE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// InsertHoleLayerDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CInsertHoleLayerDlg dialog

class CInsertHoleLayerDlg : public CDialog
{
// Construction
public:
	CInsertHoleLayerDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CInsertHoleLayerDlg)
	enum { IDD = IDD_INSERTHOLELAYERDLG };
	CEdit	m_EdtSubHoleLayer;
	int		m_HoleLayer;
	float	m_Scale;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInsertHoleLayerDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CInsertHoleLayerDlg)
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INSERTHOLELAYERDLG_H__D7BB7BF0_007B_45FA_876D_6372AF2BB0FE__INCLUDED_)
