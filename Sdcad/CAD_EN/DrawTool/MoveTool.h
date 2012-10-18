// drawtool.h - interface for CDrawTool and derivatives

#ifndef __MoveTool_H__
#define __MoveTool_H__

#include "DrawTool.h"

class CMoveTool : public CDrawTool
{
// Constructors
public:
	CMoveTool();

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
