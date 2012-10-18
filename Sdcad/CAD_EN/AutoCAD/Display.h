#ifndef __DISPLAY_H__
#define __DISPLAY_H__

class CDisplay  
{
public:
	CDisplay(CDC *pDC,int nWidth, int nHeight);
	virtual ~CDisplay();
public:
	CDC* GetDC();
	CDC* GetPaperDC();
	int GetWidth();
	int GetHeight();
	void SetWidth(int nWidth);
	void SetHeight(int nHeight);
	bool CreatePaperDC();
private:
	CBitmap* m_pBitmap;
	CBitmap* m_pPaperBitmap;
	CDC* m_pDC;
	CDC* m_pComDC;//screen corresponding dc
	CDC* m_pModelDC;
	CDC* m_pPaperDC;
	int m_Height;
	int m_Width;
	bool CreateBitmap(int nWidth, int nHeight);
	bool CreatePaperBitmap(int nWidth, int nHeight);
};

#endif