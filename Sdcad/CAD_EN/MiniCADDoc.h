// MiniCADDoc.h : interface of the CMiniCADDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MINICADDOC_H__7F330FC7_BFCF_46E6_9706_D81F7508D8F6__INCLUDED_)
#define AFX_MINICADDOC_H__7F330FC7_BFCF_46E6_9706_D81F7508D8F6__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "AutoCAD\ADLayerGroup.h"
#include "AutoCAD\ADGraphics.h"
#include "AutoCAD\DxfFile.h"
#include "Project\ProjectIniFile.h"

class CMiniCADDoc : public CDocument
{
protected: // create from serialization only
	CMiniCADDoc();
	DECLARE_DYNCREATE(CMiniCADDoc)

// Attributes
public:
	CADGraphics m_Graphics;
	CADGraphics* m_pPaperGraphics;
	CADLayerGroup m_LayerGroup;
	char m_curLayer[MAXNAMELEN];
	bool m_isLayout;
	PROJECTTYPE m_ProjectType;
	CString m_SplitChar;//岩土中文名称和英文名称中间的分隔符号//20070108
private:
	CString m_LayoutIniFilename;
	bool m_bImport;
	void OpenProjectIni();
	void OpenSectionIni(LPCTSTR lpFilename);
	void OpenHistogramIni(LPCTSTR lpFilename);
	void OpenHistogramIni2(LPCTSTR lpFilename);
	void OpenHistogramIni3(LPCTSTR lpFilename);
	void OpenHistogramIni4(LPCTSTR lpFilename);
	void OpenStaticIni(LPCTSTR lpFilename);
	void OpenLayoutIni(LPCTSTR lpFilename);
	void OpenLegendIni(LPCTSTR lpFilename);
	void OpenCrossBoardIni(LPCTSTR lpFilename);
	void OpenStaticIni2(LPCTSTR lpFilename);
	void OpenCompressionCurve(LPCTSTR lpFilename);
	void OpenLegendFile();
	void ReadLinFile();
	void CreateLType(char* LTypeStr,CADLType* pLType);
// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMiniCADDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	virtual BOOL OnOpenDocument(LPCTSTR lpszPathName);
	virtual BOOL OnSaveDocument(LPCTSTR lpszPathName);
	virtual void SetTitle(LPCTSTR lpszTitle);
	virtual void OnCloseDocument();
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMiniCADDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CMiniCADDoc)
	afx_msg void OnMENUImport();
	afx_msg void OnFileOpen2();
	afx_msg void OnFileOpen3();
	afx_msg void OnFileOpen4();
	afx_msg void OnFileOpen5();
	afx_msg void OnImporthole();
	afx_msg void OnUpdateImporthole(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MINICADDOC_H__7F330FC7_BFCF_46E6_9706_D81F7508D8F6__INCLUDED_)
