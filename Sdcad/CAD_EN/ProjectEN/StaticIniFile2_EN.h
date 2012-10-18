#ifndef __StaticIniFile2_H__
#define __StaticIniFile2_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "..\Project\ProjectLayer.h"

class CStaticIniFile2_EN
{
public:
	void FileImport(LPCTSTR lpFilename);
	CStaticIniFile2_EN(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CStaticIniFile2_EN();
private:
	int m_psLineCount;
	void CreateHatch(char* LegendName,CADPolyline* pPolyline);
	void CreateHatchLine(char* hatchLineStr,CADHatch* pHatch);
	CObArray m_Holelayers;
	LPCTSTR m_FileName;
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	int m_hScale;
	int m_vScale;
	int m_Deep;
	double m_FontHeight;
	double m_PaperLeft;
	double m_PaperTop;
	double m_Row1Height;
	double m_Layer0Top;

	short m_MaxCol;
	double m_GridColWidth[12];

	double m_GridTop;
	//double m_GridWidth;
	double m_GridHeight;
	double m_LeftMargin;
	double m_TopMargin;
	void CreateHeader(double left,double top,double titleLeft,const char* keyName);
	void CreateFoot(double left,double top);
	void CreateGrid(double GridLeft,double GridTop,double GridHeight,bool bFs,const char* keyName);
	CADBlock* CreateLayerBlock(CPerHoleLayer* pHoleLayer);
	void CreateChartFrame(float left,float top,float width,float height);
	void Create3Curves(double GridLeft,double GridTop,double GridHeight,bool bFs,const char* keyName);
	double GetGridColRight(double GridLeft,short nCol);
};

#endif