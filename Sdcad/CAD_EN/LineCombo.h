#if !defined(AFX_LINECOMBO_H__3F1BCD45_6FB0_4AD5_89CB_C29FFE84A8F1__INCLUDED_)
#define AFX_LINECOMBO_H__3F1BCD45_6FB0_4AD5_89CB_C29FFE84A8F1__INCLUDED_

#define COMBOX_ITEM_HEIGHT   19

#include "AutoCAD\ADGraphics.h"

class CLineCombo : public CComboBox
{
public:
	CADGraphics* m_pGraphics;
public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpMIS);
	virtual void MeasureItem(LPMEASUREITEMSTRUCT lpMIS);
	int GetItemIndex();
	void AddAllItem();
	void SetItemIndex(int index);
	bool CreatePenStyle(CDC* pDC,CADLType* pLType);
};

#endif // !defined(AFX_LINECOMBO_H__3F1BCD45_6FB0_4AD5_89CB_C29FFE84A8F1__INCLUDED_)
