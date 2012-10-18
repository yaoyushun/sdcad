#ifndef __HISTOGRAMINIFILE_H__
#define __HISTOGRAMINIFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "..\Project\ProjectLayer.h"

class CHistogramIniFile_EN
{
public:
	short m_ProjectType;
	short m_nPaperCount;
	void FileImport(LPCTSTR lpFilename);
	CHistogramIniFile_EN(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CHistogramIniFile_EN();
private:
	void CreateHatch(char* LegendName,CADPolyline* pPolyline,int nLayer);
	void CreateHatchLine(char* hatchLineStr,CADHatch* pHatch);
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	int m_hScale;
	int m_vScale;

	bool m_bOnePage;//added on 2005/8/24
	//int m_Deep;
	double m_Deep;
	double m_FontHeight;
	double m_NumFontH;
	double m_PaperLeft;
	double m_PaperTop;
	double m_Row1Height;
	double m_Layer0Top;

	//<--added by ll
	double m_HeadMargin;
	double m_FootMargin;
	double m_GridMargin;
	double m_FootGridHeight;
	int m_nFootGridCols;
	double* m_FootGridColWidth;
	double GetFootGridColLeft(int i);
	//-->

	double m_FrameLeft;//mm
	double m_FrameTop;
	double m_FrameWidth;
	double m_FrameHeight;

	double m_PaperDeep;

	int m_nGridCols;
	double* m_GridColWidth;

	double m_GridLeft;
	double m_GridWidth;
	double m_GridHeight;
	double m_LeftMargin;

	double m_TopMargin;
	CObArray m_Holelayers;
	LPCTSTR m_FileName;

	CADBlock* CreateLayerBlock(CPerHoleLayer* pHoleLayer);
	double GetGridColLeft(int i);
	void CreateGrid();
	void CreateChartFrame();
	void CreateChartHeader();
	void CreateChartFooter(LPCTSTR lpFilename);
	void CreateChartGrid(double left,double top,double holeDeep);

	void CreateBeatNum(LPCTSTR lpFilename);
	void ProcessHatch(CADPolyline* pPolyline);
};

#endif