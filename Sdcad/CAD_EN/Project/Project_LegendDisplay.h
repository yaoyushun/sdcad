#ifndef __PROJECTLEGENDDISPLAYFILE_H__
#define __PROJECTLEGENDDISPLAYFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "ProjectLayer.h"

class CLegendDisplay
{
public:
	CLegendDisplay(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CLegendDisplay();
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;

	CString m_SplitChar;//岩土中文名称和英文名称中间的分隔符号//20070108
	int m_nPaperCount;
	LPCTSTR m_FileName;
	void FileImport(LPCTSTR lpFilename);
	void AdjustLegend(LPCTSTR lpFilename);
private:
	void CreateFrame();
	void CreateLegend(const char* legendName,double legendLeft,double legendTop);
	void CreateLegend_Layout(const char* legendName,double legendLeft,double legendTop);
	void CreateChartFooter(LPCTSTR lpFilename);
	bool CreateHatch(CADHatch* pHatch);
	void CreateHatchLine(char* hatchLineStr,CADHatch* pHatch);
	double m_FrameLeft;
	double m_FrameTop;
	double m_FrameWidth;
	double m_FrameHeight;
	double m_LegendWidth;
	double m_LegendHeight;
	double m_LegendRectLeft;
	double m_LegendRectTop;
	double m_LegendRectWidth;
	double m_LegendRectHeight;
	double m_LegendSpaceX;
	double m_LegendSpaceY;
	short m_LegendRowNum;
	float m_MTextWidth;
};

#endif