// DlgCompass.cpp : implementation file
//

#include "stdafx.h"
#include "MiniCAD.h"
#include "DlgCompass.h"
#include "FunctionLib\Function_Graphics.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDlgCompass dialog

CDlgCompass::CDlgCompass(CWnd* pParent /*=NULL*/)
	: CDialog(CDlgCompass::IDD, pParent)
{
	m_Angle=0;
	m_isDown = false;
	m_ComCenter.x=75;
	m_ComCenter.y=75;
	m_ComRadius=70;
	m_Rgn.CreateEllipticRgn(m_ComCenter.x-m_ComRadius,m_ComCenter.y-m_ComRadius,m_ComCenter.x+m_ComRadius,m_ComCenter.y+m_ComRadius);
}

void CDlgCompass::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDlgCompass)
	DDX_Control(pDX, IDC_EDIT1, m_EditAngle);
	DDX_Text(pDX, IDC_EDIT1, m_Angle);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDlgCompass, CDialog)
	//{{AFX_MSG_MAP(CDlgCompass)
	ON_WM_PAINT()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_EN_CHANGE(IDC_EDIT1, OnChangeEdit1)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDlgCompass message handlers

void CDlgCompass::OnPaint() 
{
	CPaintDC dc(this); // device context for painting
	DrawCompass(&dc);
}

void CDlgCompass::DrawCompass(CDC* pDC)
{
	int dx=5;
	pDC->Rectangle(m_ComCenter.x-m_ComRadius-dx,m_ComCenter.y-m_ComRadius-dx,m_ComCenter.x+m_ComRadius+dx,m_ComCenter.y+m_ComRadius+dx);
	pDC->Ellipse(m_ComCenter.x-m_ComRadius,m_ComCenter.y-m_ComRadius,m_ComCenter.x+m_ComRadius,m_ComCenter.y+m_ComRadius);

//	int w = m_ComRadius/10*3;
//	int h = m_ComRadius/10*8;
	int w = 30;
	int h = 120;
	CPoint ps[4];
	ps[0].x = m_ComCenter.x;
	ps[0].y = m_ComCenter.y-h/2;
	ps[1].x = m_ComCenter.x+w/2;
	ps[1].y = m_ComCenter.y;
	ps[2].x = m_ComCenter.x-w/2;
	ps[2].y = m_ComCenter.y;
	ps[3].x = m_ComCenter.x;
	ps[3].y = m_ComCenter.y+h/2;

	for (int i=0;i<4;i++) Rotate(&m_ComCenter,&ps[i],-m_Angle);

	CBrush brush;
	brush.CreateSolidBrush(RGB(255,0,0));
	pDC->SelectObject(&brush);
	pDC->Polygon(ps,3);

	ps[0].x = ps[3].x;
	ps[0].y = ps[3].y;
	CBrush brush2;
	brush2.CreateSolidBrush(RGB(255,255,255));
	pDC->SelectObject(&brush2);
	pDC->Polygon(ps,3);
}

void CDlgCompass::OnMouseMove(UINT nFlags, CPoint point) 
{
/*	if (m_Rgn.PtInRegion(point))
		::SetCursor(LoadCursor(NULL,IDC_HAND));
	else
		::SetCursor(LoadCursor(NULL,IDC_ARROW));*/
	if (m_isDown)
	{
		int cx = point.x-m_ComCenter.x;
		int cy = -point.y+m_ComCenter.y;
		double a = atan(double(cx)/double(cy));
		a = a / 3.145926 * 180.0;
		int angle = (int)a;
		if ((cy>0)&&(cx>0)) m_Angle = -angle;
		if ((cy>0)&&(cx<0)) m_Angle = -angle;
		if ((cy<0)&&(cx<0)) m_Angle = 180-angle;
		if ((cy<0)&&(cx>0)) m_Angle = -180-angle;
		if ((m_Angle<4)&&(m_Angle>-4)) m_Angle = 0;
		CString tmpStr;
		tmpStr.Format("%d",m_Angle);
		m_EditAngle.SetWindowText(tmpStr);
		CDC* pDC=GetDC();
		DrawCompass(pDC);
		//this->ReleaseDC(pDC);
		DeleteDC(pDC->m_hDC);
	}
	
	CDialog::OnMouseMove(nFlags, point);
}

void CDlgCompass::OnLButtonDown(UINT nFlags, CPoint point) 
{
	if (m_Rgn.PtInRegion(point)) 
	{
		m_isDown = true;
		int cx = point.x-m_ComCenter.x;
		int cy = -point.y+m_ComCenter.y;
		double a = atan(double(cx)/double(cy));
		a = a / 3.145926 * 180.0;
		int angle = (int)a;
		if ((cy>0)&&(cx>0)) m_Angle = -angle;
		if ((cy>0)&&(cx<0)) m_Angle = -angle;
		if ((cy<0)&&(cx<0)) m_Angle = 180-angle;
		if ((cy<0)&&(cx>0)) m_Angle = -180-angle;
		if ((m_Angle<4)&&(m_Angle>-4)) m_Angle = 0;
		CString tmpStr;
		tmpStr.Format("%d",m_Angle);
		m_EditAngle.SetWindowText(tmpStr);
		CDC* pDC=GetDC();
		DrawCompass(pDC);
		//this->ReleaseDC(pDC);
		DeleteDC(pDC->m_hDC);
	}
	
	CDialog::OnLButtonDown(nFlags, point);
}

void CDlgCompass::OnLButtonUp(UINT nFlags, CPoint point) 
{
	m_isDown = false;
	CDialog::OnLButtonUp(nFlags, point);
}

void CDlgCompass::OnChangeEdit1() 
{
	int len = m_EditAngle.GetWindowTextLength()+1;
	char* tmpStr = new char[len]; 
	m_EditAngle.GetWindowText(tmpStr,len);
	m_Angle = atoi(tmpStr);
	CDC* pDC=GetDC();
	DrawCompass(pDC);
	//this->ReleaseDC(pDC);
	DeleteDC(pDC->m_hDC);
}
