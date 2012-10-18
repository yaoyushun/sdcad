#if !defined(AFX_DLGLAYERADMIN_H__DB2981A9_3591_4F0A_8B41_6F9AB5E49AE8__INCLUDED_)
#define AFX_DLGLAYERADMIN_H__DB2981A9_3591_4F0A_8B41_6F9AB5E49AE8__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgLayerAdmin.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDlgLayerAdmin dialog

class CDlgLayerAdmin : public CDialog
{
// Construction
public:
	CDlgLayerAdmin(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlgLayerAdmin)
	enum { IDD = IDD_LAYER_ADMIN };
	CListBox	m_lstLayer;
	CString	m_lstLayerValue;
	//}}AFX_DATA
	bool* m_LayerOn;

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgLayerAdmin)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlgLayerAdmin)
	virtual BOOL OnInitDialog();
	afx_msg void OnSelchangeList1();
	virtual void OnOK();
	afx_msg void OnChangeEdit1();
	afx_msg void OnChkLayeron();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGLAYERADMIN_H__DB2981A9_3591_4F0A_8B41_6F9AB5E49AE8__INCLUDED_)
