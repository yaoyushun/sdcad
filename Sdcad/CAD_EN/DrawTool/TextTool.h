#ifndef __TEXTTOOL_H__
#define __TEXTTOOL_H__

#include "DrawTool.h"

class CTextTool : public CDrawTool
{
// Constructors
public:
	CTextTool();
	CPoint m_PointOrigin;
// Implementation
	virtual void OnLButtonDown(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonDblClk(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnLButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnMouseMove(_CVIEW* pView, UINT nFlags, CPoint& point);
	virtual void OnRButtonUp(_CVIEW* pView, UINT nFlags, CPoint& point);
};

#endif