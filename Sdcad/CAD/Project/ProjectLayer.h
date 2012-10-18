#ifndef __PROJECTLAYER_H__
#define __PROJECTLAYER_H__

//#define Maker "〖勘察者〗CAD系统制作"
#define Maker ""

class CSubHoleLayer:public CObject
{
public:
	char m_Lengend[255];
	char m_SubID[10];
	double m_Deep;
};

class COneHoleLayer:public CObject
{
public:
	CObArray m_SubHoleLayers;
	char m_ID[10];
};

class CHoleLayer
{
public:
	CObArray m_OneHoleLayers;
//	CObArray m_PerHoleLayers;
};

class CPerHoleLayer:public CObject
{
public:
	char m_Lengend[255];
	char m_ID[10];
	char m_SubID[10];
	double m_Deep;
	short m_nPaper;
};

#endif