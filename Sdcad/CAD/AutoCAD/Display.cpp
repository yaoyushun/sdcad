#include "stdafx.h"
#include "Display.h"

CDisplay::CDisplay(CDC *pDC,int nWidth, int nHeight)
{
	m_pBitmap=NULL;
	m_pPaperBitmap=NULL;
	m_pDC=NULL;
	m_pComDC=pDC;
	m_pPaperDC=NULL;
	m_Height = nHeight;
	m_Width = nWidth;
	CreateBitmap(m_Width,m_Height);
}

CDisplay::~CDisplay()
{
	if (m_pDC) delete m_pDC;
	if (m_pPaperDC) delete m_pPaperDC;
	if (m_pBitmap) delete m_pBitmap;
	if (m_pPaperBitmap) delete m_pPaperBitmap;
}

CDC* CDisplay::GetDC()
{
	return m_pDC;
}

CDC* CDisplay::GetPaperDC()
{
	return m_pPaperDC;
}

int CDisplay::GetWidth()
{
	return m_Width;
}

int CDisplay::GetHeight()
{
	return m_Height;
}

bool CDisplay::CreateBitmap(int nWidth, int nHeight)
{
	if (m_pBitmap) delete m_pBitmap;
	m_pBitmap = new CBitmap();
	if (!(m_pBitmap->CreateCompatibleBitmap(m_pComDC,nWidth,nHeight)))
	{
		delete m_pBitmap;
		m_Height = 0;
		m_Width = 0;
		return false;
	}
	m_Height = nHeight;
	m_Width = nWidth;

	if (!m_pDC)
	{
		m_pDC = new CDC();
		//m_pDC->DeleteDC();
		//m_pComDC
		//m_pDC->CreateCompatibleDC(NULL);
		m_pDC->CreateCompatibleDC(m_pComDC);
	}
	m_pDC->SelectObject(m_pBitmap);

	CBrush brush;
	brush.CreateSolidBrush(RGB(255,0,0));
	CRect rect(0,0,m_Width,m_Height);
	m_pDC->FillRect(&rect, &brush);
	return true;
}

bool CDisplay::CreatePaperBitmap(int nWidth, int nHeight)
{
	if (m_pPaperBitmap) delete m_pPaperBitmap;
	m_pPaperBitmap = new CBitmap();
	if (!(m_pPaperBitmap->CreateCompatibleBitmap(m_pDC,nWidth,nHeight)))
	{
		delete m_pPaperBitmap;
		m_pPaperBitmap=NULL;
		m_Height = 0;
		m_Width = 0;
		return false;
	}
	m_Height = nHeight;
	m_Width = nWidth;

	if (!m_pPaperDC)
	{
		m_pPaperDC = new CDC();
		m_pPaperDC->CreateCompatibleDC(m_pDC);
	}
	m_pPaperDC->SelectObject(m_pPaperBitmap);
	return true;	
}

void CDisplay::SetWidth(int nWidth)
{
	m_Width = nWidth;
	CreateBitmap(m_Height,m_Width);
}

void CDisplay::SetHeight(int nHeight)
{
	m_Height = nHeight;
	CreateBitmap(m_Height,m_Width);
}

bool CDisplay::CreatePaperDC()
{
	if (CreatePaperBitmap(m_Width,m_Height)) 
		return true;
	else 
		return false;
}