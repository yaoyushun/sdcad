#if !defined(AFX_DLGENTITYPROPERTY_H__FEB90124_2168_47DF_9FDD_C77B517C97D3__INCLUDED_)
#define AFX_DLGENTITYPROPERTY_H__FEB90124_2168_47DF_9FDD_C77B517C97D3__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgEntityProperty.h : header file
//
#include "LineCombo.h"
/////////////////////////////////////////////////////////////////////////////
// CDlgEntityProperty dialog

class CDlgEntityProperty : public CDialog
{
// Construction
public:
	CDlgEntityProperty(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlgEntityProperty)
	enum { IDD = IDD_DIG_ENTITYPROPERTY };
	CLineCombo	m_LType;
	double	m_Scale;
	//}}AFX_DATA

	int m_curSelIndex;
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgEntityProperty)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlgEntityProperty)
	virtual BOOL OnInitDialog();
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGENTITYPROPERTY_H__FEB90124_2168_47DF_9FDD_C77B517C97D3__INCLUDED_)
