#ifndef __LAYOUTINIFILE_H__
#define __LAYOUTINIFILE_H__

#include "..\AutoCAD\ADLayerGroup.h"
#include "..\AutoCAD\ADGraphics.h"
#include "ProjectLayer.h"

class CLayoutIniFile
{
public:
	void FileImport(LPCTSTR lpFilename);
	CLayoutIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics);
	~CLayoutIniFile();
	short m_PaperScale;
private:
	CADLayerGroup* m_pLayerGroup;
	CADGraphics* m_pGraphics;
	int m_HoleNum;
};

#endif