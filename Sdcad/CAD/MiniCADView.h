// MiniCADView.h : interface of the CMiniCADView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_MINICADVIEW_H__D815FA82_94E8_42C6_B0E1_D11C204FAEA1__INCLUDED_)
#define AFX_MINICADVIEW_H__D815FA82_94E8_42C6_B0E1_D11C204FAEA1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "AutoCAD\Display.h"

/*enum DrawToolType
{
	panTool,
	selectTool,
	zoomTool,
	zoomOutTool,
	zoomInTool,
	zoomRectTool,
	fullTool,
	textTool,
	insertTool,
	moveTool,
	rotateTool,
	scaleTool,
	//---------
	pointTool,
	lineTool,
	polyLineTool,
	rectTool,
	polygonTool,
	circleTool,
	arcTool,
	splineTool,
	//---------
	labelCoordTool,
	//---------
	spline_AddPoint_Tool,
	sectionLineTool,
	cutshortTool
};
*/
#define LayoutLayer1Name "工程勘察布置图纸样式1"
#define LayoutLayer2Name "工程勘察布置图纸样式2"

/*enum ViewMode
{
	Model,
	Layout
};*/

class CMiniCADView : public CView
{
protected: // create from serialization only
	CMiniCADView();
	DECLARE_DYNCREATE(CMiniCADView)

// Attributes
public:
	CMiniCADDoc* GetDocument();
	void ChangePaper(int nPaper);
	void ChangeScale(int nScale);
public:
	void SetProjectLineWidth(CADEntity* pEntity);
	void ReBitBlt();
	int m_PaperScale;
	char m_PaperName[255];
	CString m_SectionName;
	WORKSPACE m_curWorkSpace;
	CADInsert* m_pCompassInsert;
	PAPERORIENT m_PaperOrient;
//	DrawToolType m_curDrawTool;
	void ReDraw();
	CDisplay* m_pDisplay;
	PAPERTYPE m_PaperType;
	CADEntity* m_pTempEntity;
	CRect m_ModelRect;
	ADPOINT m_RotatePt;
private:
//	bool m_bMDown;
//	bool m_bDown;
//	UINT m_nDown;
//	CPoint m_PointDown;
//	CPoint m_PointOld;
	CPoint m_MPointDown;
	CPoint m_MPointOld;
//	CPoint m_PointOrigin;
	CPoint m_PointSecond;
	CDC* m_pDC;
	//bool m_bJustDraw;
	CDialog* m_pEntityPropertyDlg;
	void SetMousePosText(CPoint LogPoint);
	void DrawTrackingLayer();
	LRESULT WindowProc(UINT message, WPARAM wParam, LPARAM lParam);
private:
	bool m_bPaperFirst;
	CADRectangle m_ModelOldBound;
	double m_ModelOldZoom;
	bool CreatePaper();
	bool CreatePaper2();
// Operations
private:
//	GraphicsMode m_GraphicsMode;
	//int m_xPixels;
	//int m_yPixels;
	//int m_xMilimeters;
	//int m_yMilimeters;
//	bool m_bSnap;
//	bool m_bRightAngleCorrection;
	bool m_bInsert;
	void Resume(bool undoAllSelected=true);

	//void SetPageMargin(CDC *pDC, CPrintInfo *pInfo, int l, int t, int r, int b);
// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMiniCADView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnPrint(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CMiniCADView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CMiniCADView)
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnPan();
	afx_msg void OnUpdatePan(CCmdUI* pCmdUI);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnSelect();
	afx_msg void OnUpdateSelect(CCmdUI* pCmdUI);
	afx_msg void OnZoom();
	afx_msg void OnUpdateZoom(CCmdUI* pCmdUI);
	afx_msg BOOL OnEraseBkgnd(CDC* pDC);
	afx_msg void OnSnap();
	afx_msg void OnUpdateSnap(CCmdUI* pCmdUI);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnInsertblock();
	afx_msg void OnPoint();
	afx_msg void OnUpdatePoint(CCmdUI* pCmdUI);
	afx_msg void OnLine();
	afx_msg void OnUpdateLine(CCmdUI* pCmdUI);
	afx_msg void OnRectangle();
	afx_msg void OnUpdateRectangle(CCmdUI* pCmdUI);
	afx_msg void OnEditClear();
	afx_msg void OnUpdateEditClear(CCmdUI* pCmdUI);
	afx_msg void OnPolyline();
	afx_msg void OnUpdatePolyline(CCmdUI* pCmdUI);
	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnText();
	afx_msg void OnUpdateText(CCmdUI* pCmdUI);
	afx_msg void OnEditMove();
	afx_msg void OnUpdateEditMove(CCmdUI* pCmdUI);
	afx_msg void OnEditRotate();
	afx_msg void OnUpdateEditRotate(CCmdUI* pCmdUI);
	afx_msg void OnCircle();
	afx_msg void OnUpdateCircle(CCmdUI* pCmdUI);
	afx_msg void OnArc();
	afx_msg void OnUpdateArc(CCmdUI* pCmdUI);
	afx_msg void OnSpline();
	afx_msg void OnUpdateSpline(CCmdUI* pCmdUI);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnInsertholelayer();
	afx_msg void OnMenuPapersetup();
	afx_msg void OnLayerAdmin();
	afx_msg void OnRightanglecorrect();
	afx_msg void OnUpdateRightanglecorrect(CCmdUI* pCmdUI);
	afx_msg void OnChar(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnZoomin();
	afx_msg void OnZoomout();
	afx_msg void OnInsertsectionline();
	afx_msg void OnCompass();
	afx_msg void OnContextMenu(CWnd* pWnd, CPoint point);
	afx_msg void OnSplineAddpoint();
	afx_msg void OnRButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnPaperspace();
	afx_msg void OnModelspace();
	afx_msg void OnUpdateModelspace(CCmdUI* pCmdUI);
	afx_msg void OnUpdatePaperspace(CCmdUI* pCmdUI);
	afx_msg void OnUpdateCompass(CCmdUI* pCmdUI);
	afx_msg void OnEditmodel();
	afx_msg void OnUpdateEditmodel(CCmdUI* pCmdUI);
	afx_msg void OnUpdateInsertblock(CCmdUI* pCmdUI);
	afx_msg void OnUpdateInsertholelayer(CCmdUI* pCmdUI);
	afx_msg void OnUpdateInsertsectionline(CCmdUI* pCmdUI);
	afx_msg void OnUpdateZoomin(CCmdUI* pCmdUI);
	afx_msg void OnUpdateZoomout(CCmdUI* pCmdUI);
	afx_msg void OnEntityproperty();
	afx_msg void OnUpdateEditCutshort(CCmdUI* pCmdUI);
	afx_msg void OnEditCutshort();
	afx_msg void OnSplineCutshort();
	afx_msg void OnLabelcoord();
	afx_msg void OnUpdateLabelcoord(CCmdUI* pCmdUI);
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnPropertyedit();
	afx_msg void OnCopy();
	afx_msg void OnPaste();
	afx_msg void OnUpdateCopy(CCmdUI* pCmdUI);
	afx_msg void OnUpdatePropertyedit(CCmdUI* pCmdUI);
	afx_msg void OnUpdatePaste(CCmdUI* pCmdUI);
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

#ifndef _DEBUG  // debug version in MiniCADView.cpp
inline CMiniCADDoc* CMiniCADView::GetDocument()
   { return (CMiniCADDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MINICADVIEW_H__D815FA82_94E8_42C6_B0E1_D11C204FAEA1__INCLUDED_)
