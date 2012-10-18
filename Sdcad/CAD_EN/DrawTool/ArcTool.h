// drawtool.h - interface for CDrawTool and derivatives

#ifndef __ArcTool_H__
#define __ArcTool_H__

#include "DrawTool.h"

class CArcTool : public CDrawTool
{
// Constructors
public:
	CArcTool();

	CPoint m_PointOrigin;
	CPoint m_PointSecond;

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
