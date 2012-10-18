#if !defined(AFX_DLGCOMPASS_H__0AAAC08D_F82A_4891_946C_3D6E67FF5F53__INCLUDED_)
#define AFX_DLGCOMPASS_H__0AAAC08D_F82A_4891_946C_3D6E67FF5F53__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// DlgCompass.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CDlgCompass dialog

class CDlgCompass : public CDialog
{
// Construction
public:
	CDlgCompass(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CDlgCompass)
	enum { IDD = IDD_DLG_COMPASS };
	CEdit	m_EditAngle;
	int		m_Angle;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDlgCompass)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL
private:
	bool m_isDown;
	CPoint m_ComCenter;
	int m_ComRadius;
	int m_ComLeft;
	int m_ComTop;
	int m_ComWidth;
	int m_ComHeight;
	CRgn m_Rgn;
	void DrawCompass(CDC* pDC);
// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CDlgCompass)
	afx_msg void OnPaint();
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnChangeEdit1();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DLGCOMPASS_H__0AAAC08D_F82A_4891_946C_3D6E67FF5F53__INCLUDED_)
