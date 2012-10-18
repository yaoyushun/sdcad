// drawtool.h - interface for CDrawTool and derivatives

#ifndef __ZoominTool_H__
#define __ZoominTool_H__

#include "DrawTool.h"

class CZoominTool : public CDrawTool
{
// Constructors
public:
	CZoominTool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
};

#endif
