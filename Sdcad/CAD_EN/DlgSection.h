#if !defined(AFX_DLGSECTION_H__53F1480D_8ED6_46CE_96AD_4E3245E5B903__INCLUDED_)
#define AFX_DLGSECTION_H__53F1480D_8ED6_46CE_96AD_4E3245E5B903__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgSection.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDlgSection dialog

class CDlgSection : public CDialog
{
// Construction
public:
	CDlgSection(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlgSection)
	enum { IDD = IDD_DLG_SECTION };
	CEdit	m_Edit1;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgSection)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlgSection)
	virtual void OnOK();
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGSECTION_H__53F1480D_8ED6_46CE_96AD_4E3245E5B903__INCLUDED_)
