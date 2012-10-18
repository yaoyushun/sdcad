#if !defined(AFX_INSERTBLOCKDLG_H__E737CE2F_EEB3_4A0F_AF48_114BE3CD4853__INCLUDED_)
#define AFX_INSERTBLOCKDLG_H__E737CE2F_EEB3_4A0F_AF48_114BE3CD4853__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// InsertBlockDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CInsertBlockDlg dialog

class CInsertBlockDlg : public CDialog
{
// Construction
public:
	CInsertBlockDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CInsertBlockDlg)
	enum { IDD = IDD_INSERTBLOCKDLG };
	CComboBox	m_BlockName;
	double	m_X;
	double	m_Y;
	double	m_xScale;
	double	m_yScale;
	double	m_Rotation;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CInsertBlockDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CInsertBlockDlg)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	afx_msg void OnCheck1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_INSERTBLOCKDLG_H__E737CE2F_EEB3_4A0F_AF48_114BE3CD4853__INCLUDED_)
