#ifndef __CROSSBOARD_H__
#define __CROSSBOARD_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "..\Project\ProjectLayer.h"

class CCrossBoardIniFile_EN
{
public:
	short m_nPaperCount;
	CCrossBoardIniFile_EN(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);	
	~CCrossBoardIniFile_EN();
	void FileImport(LPCTSTR lpFilename);
private:
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	double m_FrameLeft;//mm
	double m_FrameTop;
	double m_FrameWidth;
	double m_FrameHeight;

	int m_HoleNum;

	void CreateChartFrame();
	void CreateChartHeader(LPCTSTR lpFilename);
	void CreateChartFooter(LPCTSTR lpFilename);

	void CreateAxis(double x0,double y0,int curLayerIndex);
	void CreateComment(double x0,double y0,int curLayerIndex,short nHoleID,LPCTSTR lpFilename);
};

#endif