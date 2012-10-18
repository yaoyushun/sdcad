#ifndef __STATICINIFILE_H__
#define __STATICINIFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "ProjectLayer.h"

class CStaticIniFile
{
public:
	CString m_SplitChar;//岩土中文名称和英文名称中间的分隔符号//20070108
	void FileImport(LPCTSTR lpFilename);
	CStaticIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CStaticIniFile();

	short m_ProjectType;
private:
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