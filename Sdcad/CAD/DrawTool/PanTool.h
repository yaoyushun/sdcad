// drawtool.h - interface for CDrawTool and derivatives

#ifndef __PanTool_H__
#define __PanTool_H__

#include "DrawTool.h"

class CPanTool : public CDrawTool
{
// Constructors
public:
	CPanTool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
