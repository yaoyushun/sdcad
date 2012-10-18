#ifndef __SelectTool_H__
#define __SelectTool_H__

#include "DrawTool.h"

class CSelectTool : public CDrawTool
{
// Constructors
public:
	CSelectTool();

// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void Move(int dx,int dy);

private:
	static int    c_nSelStat;
	short			m_nSlectedLine;
};

#endif