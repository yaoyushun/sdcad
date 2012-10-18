// LineCombo.cpp : implementation file
//

#include "stdafx.h"
#include "LineCombo.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////

void CLineCombo::DrawItem(LPDRAWITEMSTRUCT lpMIS) 
{
	CDC *pDC = CDC::FromHandle(lpMIS->hDC);
	RECT *pRect = &lpMIS->rcItem;
	int H = pRect->bottom - pRect->top;
	int W = pRect->right - pRect->left;

	CPoint pt1,pt2;
	pt1.x = 4;
	pt1.y = pRect->top + H/2;
	pt2.x = W-4;
	pt2.y = pRect->top + H/2;

/*	CPen pen;
	if (!pen.CreatePen(PS_DASHDOT, 1, RGB(0,0,0)))
		return;
	CPen* pOldPen=pDC->SelectObject(&pen);*/

	int i=lpMIS->itemID;
	CADLType* pLType=(CADLType*)m_pGraphics->m_LTypes.GetAt(i);
//	return;
	CreatePenStyle(pDC,pLType);

	if (lpMIS->itemAction & ODA_DRAWENTIRE)
	{
		pDC->MoveTo(pt1);
		pDC->LineTo(pt2); 
	}
	if ((lpMIS->itemState & ODS_SELECTED) &&
	(lpMIS->itemAction & (ODA_SELECT | ODA_DRAWENTIRE)))
	{
		CBrush br(0x6A240A);
		pDC->FillRect(&lpMIS->rcItem,&br);
		pDC->DrawFocusRect(&lpMIS->rcItem);
		pDC->MoveTo(pt1);
		pDC->LineTo(pt2); 
	}
	if (!(lpMIS->itemState & ODS_SELECTED) &&
		(lpMIS->itemAction & ODA_SELECT))
	{
		CBrush br(RGB(255,255,255));
		pDC->FillRect(&lpMIS->rcItem,&br);
		pDC->MoveTo(pt1);
		pDC->LineTo(pt2); 
	}
}

void CLineCombo::MeasureItem(LPMEASUREITEMSTRUCT lpMIS)
{
	SetItemHeight(-1, COMBOX_ITEM_HEIGHT + 2);
	lpMIS->itemHeight = COMBOX_ITEM_HEIGHT;
}

void CLineCombo::AddAllItem()
{
	for (int i=0;i<m_pGraphics->m_LTypes.GetSize();i++)
	{
		this->AddString((LPCTSTR)i);
		this->SetItemData(i,i);
	}
}

int CLineCombo::GetItemIndex()
{
	return GetCurSel();
}

void CLineCombo::SetItemIndex(int index)
{
	if (index<GetCount() && (index>-1))
		SetCurSel(index);
}

bool CLineCombo::CreatePenStyle(CDC* pDC,CADLType* pLType)
{
//	pLType=(CADLType*)m_pGraphics->m_LTypes.GetAt(index);

	double length=0;
	for(int m=0;m<pLType->m_ItemCount;m++)
	{
		if(pLType->m_Items[m]==0)
			;
		else
			length+=pLType->m_Items[m];
	}
	double zoomRate=1;
	if(length>0)
	{
		zoomRate=20/length;
	}
	if(m_pGraphics->m_pPen)delete m_pGraphics->m_pPen;
	m_pGraphics->m_pPen=new CPen();
	if(pLType->m_ItemCount==0)
	{
		if (!m_pGraphics->m_pPen->CreatePen(PS_SOLID,1, RGB(200,200,200)))
			return false;
		pDC->SelectObject(m_pGraphics->m_pPen);
	}
	else
	{
		unsigned long* a=new unsigned long[pLType->m_ItemCount];
		for(int m=0;m<pLType->m_ItemCount;m++)
		{
			if(pLType->m_Items[m]==0)
				a[m]=1;
			else
			{
				a[m]=fabs(pLType->m_Items[m]*zoomRate);
			}
		}
		LOGBRUSH logBrush;
		logBrush.lbColor = RGB(200,200,200);
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_SOLID;
		if(!m_pGraphics->m_pPen->CreatePen(PS_GEOMETRIC|PS_USERSTYLE|PS_ENDCAP_SQUARE,1,&logBrush,pLType->m_ItemCount,a))return false;
		pDC->SelectObject(m_pGraphics->m_pPen);		
	}
	return true;
}
