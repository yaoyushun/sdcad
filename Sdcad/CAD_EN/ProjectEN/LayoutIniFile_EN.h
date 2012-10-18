#ifndef __LAYOUTINIFILE_H__
#define __LAYOUTINIFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "..\Project\ProjectLayer.h"

class CLayoutIniFile_EN
{
public:
	void FileImport(LPCTSTR lpFilename);
	CLayoutIniFile_EN(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CLayoutIniFile_EN();
	short m_PaperScale;
private:
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	int m_HoleNum;
};

#endif