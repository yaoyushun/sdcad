// drawtool.h - interface for CDrawTool and derivatives

#ifndef __PointTool_H__
#define __PointTool_H__

#include "DrawTool.h"

class CPointTool : public CDrawTool
{
// Constructors
public:
	CPointTool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
