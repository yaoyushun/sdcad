#ifndef __ADLAYERGROUP_H__
#define __ADLAYERGROUP_H__

#define MAXNAMELEN    512
typedef char AD_OBJHANDLE[8];
typedef void * AD_DB_HANDLE;

class CADLayer  
{
public:
	CADLayer();
	virtual ~CADLayer();

	char m_Name[MAXNAMELEN];
	AD_OBJHANDLE m_Handle;
	short m_nColor;
	char m_LTypeName[MAXNAMELEN];
	char m_PrintStyle[MAXNAMELEN];
	bool m_isPrint;
	float m_LineWidth;
};

class CADLayerGroup  
{
public:
	CADLayerGroup();
	virtual ~CADLayerGroup();
public:
	int GetLayerCount();
	CADLayer* GetLayer(int index);
	void AddLayer(CADLayer* pLayer);
	int indexOf(LPCSTR LayerName);
private:
	CObArray* m_pLayers;
};

#endif