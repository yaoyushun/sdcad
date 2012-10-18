// drawtool.h - interface for CDrawTool and derivatives

#ifndef __Spline_AddPoint_Tool_H__
#define __Spline_AddPoint_Tool_H__

#include "DrawTool.h"

class CSpline_AddPoint_Tool : public CDrawTool
{
// Constructors
public:
	CSpline_AddPoint_Tool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
