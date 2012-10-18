// drawtool.h - interface for CDrawTool and derivatives

#ifndef __InsertTool_H__
#define __InsertTool_H__

#include "DrawTool.h"

class CInsertTool : public CDrawTool
{
// Constructors
public:
	CInsertTool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);
};

#endif
