#ifndef __PROJECTINIFILE_H__
#define __PROJECTINIFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "ProjectLayer.h"

class CProjectIniFile
{
public:
	CProjectIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);	
	~CProjectIniFile();
	void FileImport(LPCTSTR lpFilename);
	PAPERTYPE m_PaperType;
private:
	void CalHorizontalCoord();
	void CreateLayerFlag();
	char LegendFile[255];
	UINT m_HoleNum;
	float m_xScale;//cm-act m
	float m_yScale;//cm-act m
	int m_xScale2;//act m-mm
	int m_yScale2;//act m-mm
	int m_hScale;
	int m_vScale;
	int m_Orient;
	bool m_bPrintStatic;
	int m_StaticCurveScale;//¾²Ì½ÇúÏß±ÈÀý(added on 2006/12/19)
private:
///	int m_LayerNum;
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	double m_FrameLeft;//mm
	double m_FrameTop;
	double m_FrameWidth;
	double m_FrameHeight;

	double* m_HoleDeep;
	double* m_HoleHeight;
	char** m_HoleID;
	char m_ProjectName[255];
	char m_ProjectID[255];
	ADPOINT* m_HolePoints;
	CHoleLayer* m_Holelayers;
	double m_LegendWidth;
	double m_RulerLeft;
	double m_RulerTop;
	double m_RulerBottom;
	double m_HoleBottom;
	double m_HoleGridHeight;//mm
	double m_LabelGridHegiht;
	double m_HoleGridSpace;
	double m_LabelGridSpace;

	void CreateVertLine(int i);
	void CreateHoleLayer();
	void CreateAllHoleLayer();
	void GetHoleLayerInfo(int nHole);

	LPCTSTR m_pFileName;
	void CreateHoleLayerSpline(COneHoleLayer* pOldOneHoleLayer,CSubHoleLayer* pOldSubHoleLayer,int nHole,int nLayer,int nSubLayer);
	void CreateHoleLayerLeftSpline(COneHoleLayer* pOldOneHoleLayer,CSubHoleLayer* pOldSubHoleLayer,int holeIndex,int layerIndex,int subLayerIndex);
	void CreateHatch(char* LegendName,CADPolyline* pPolyline);
	void CreateHatchLine(char* hatchLineStr,CADHatch* pHatch);
	void CreateHoleLayerHatch();

	void CreateHoleHeightText();
	void CreateLandInfo(char* pLandInfoStr,int i);
	void CreateGradeInfo(char* pGradeInfoStr,int i);
	void CreateGradeInfo2(char* pGradeInfoStr,int i);
	void CreateGradeInfo2Ex(char* pGradeInfoStr,int i);

	void CreateHoleLayerText();
	void CreateStaticCurve();
//-------------------------------------------
	void CreateChartFrame();
	void CreateChartHeader();
	void CreateChartFooter(LPCTSTR lpFilename);
	void CreateChartRuler();
	void CreateHoleGrid(LPCTSTR lpFilename);
	void CreateWaterLine(LPCTSTR lpFilename);
//-------------------------------------------
	void TransPoint(ADPOINT* pPoint);
	void GetSubLayerIndex(short nHole,const char* mainID,const char* subID,short& mainLayerIndex,short& subLayerIndex);
	short GetFitHoleIndex(short nOldHole,const char* mainID,const char* subID);
	double GetLayerBetweenCordY(short holeIndex,short mainLayerIndex,short subLayerIndex);
	bool ProcessHatch(CADPolyline* pPolyline);
};

#endif