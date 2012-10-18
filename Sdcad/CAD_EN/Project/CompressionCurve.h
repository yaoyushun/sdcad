#ifndef __CompressionCurve_H__
#define __CompressionCurve_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "ProjectLayer.h"

class CCompressionCurve
{
public:
	int    m_LayerNum;
	PAPERTYPE m_PaperType;
	short m_nPaperCount;
	CCompressionCurve(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CCompressionCurve();
	void FileImport(LPCTSTR lpFilename);
	void CreateChart(double chartLeft,double chartTop,double chartWidth,double chartHeight,int nLayer,int curLayerIndex,int nScale=1);
	void CreateCurveChart(double chartLeft,double chartTop,double chartWidth,double chartHeight,int nLayer,int curLayerIndex,int nScale=1);
private:
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	double m_FrameLeft;//mm
	double m_FrameTop;
	double m_FrameWidth;
	double m_FrameHeight;


	CString m_fileName;
	CString m_paperTitle;
	CString m_curveTitle;
	CString m_projectName;
	CString m_projectNo;
	CString m_doStandard;
	int     m_CompressCount;	
	int		*m_pCompressValue;
	float	*m_pEValue;
};

#endif