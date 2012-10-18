// drawtool.h - interface for CDrawTool and derivatives

#ifndef __SectionLineTool_H__
#define __SectionLineTool_H__

#include "DrawTool.h"

class CSectionLineTool : public CDrawTool
{
// Constructors
public:
	CSectionLineTool();
	CPoint m_PointOrigin;
// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
