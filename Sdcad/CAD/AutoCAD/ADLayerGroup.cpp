#include "stdafx.h"
#include "ADLayerGroup.h"

CADLayer::CADLayer()
{
	strcpy(m_Name,"");
	strcpy(m_LTypeName,"");
	m_nColor=0;
	m_LineWidth=1;
	m_isPrint=true;
	strcpy(m_PrintStyle,"F");
}

CADLayer::~CADLayer()
{

}

//------------------------------------------------

CADLayerGroup::CADLayerGroup()
{
	m_pLayers = new CObArray();
}

CADLayerGroup::~CADLayerGroup()
{
	for (int i=0; i<m_pLayers->GetSize(); i++)
	{
		CADLayer* pLayer = (CADLayer*)m_pLayers->GetAt(i);
		delete pLayer;
	}
	m_pLayers->RemoveAll(); 
	delete m_pLayers;
}

CADLayer* CADLayerGroup::GetLayer(int index,int ii)
{
	//::AfxMessageBox("str");
	if(index<0 || index>m_pLayers->GetSize()-1)return NULL;
	/*if (ii>0)
	{
		CString str;
		str.Format("%d",m_pLayers->GetSize());
		::AfxMessageBox(str);
	}*/
	return (CADLayer*)m_pLayers->GetAt(index);
}

void CADLayerGroup::AddLayer(CADLayer* pLayer)
{
	if (pLayer != NULL) m_pLayers->Add((CObject*)pLayer);
}

int CADLayerGroup::GetLayerCount()
{
	return m_pLayers->GetSize();
}

int CADLayerGroup::indexOf(LPCSTR LayerName)
{
	for(int i=0;i<m_pLayers->GetSize();i++)
	{
		CADLayer* pLayer=(CADLayer*)m_pLayers->GetAt(i);
		if(lstrcmp(LayerName,pLayer->m_Name)==0)return i;
	}
	return -1;
}