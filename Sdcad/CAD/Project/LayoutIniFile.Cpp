#include "stdafx.h"
#include "LayoutIniFile.h"
#define LegendWidth 0.8//unit cm
#include "..\FunctionLib\Function_System.h"

CLayoutIniFile::CLayoutIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
//initialize===============================================
	m_HoleNum = 0;
	m_PaperScale = 1;
}

CLayoutIniFile::~CLayoutIniFile()
{
	
}

void CLayoutIniFile::FileImport(LPCTSTR lpFilename)
{
	m_HoleNum=::GetPrivateProfileInt("钻孔","个数",0,lpFilename);
	if(m_HoleNum<=0)return;

	char num[4];
	char keyName[10];
	const short strMaxLen=255;
	char str[strMaxLen];
	for(int i=0;i<m_HoleNum;i++)
	{
		short curLayerIndex = (short)m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME);//
		if (curLayerIndex == -1)curLayerIndex = 0;
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		///////////////////////////////////////////////////////////////////
		GetPrivateProfileString(keyName,"类型","",str,strMaxLen,lpFilename);
		char* pszTemp = strtok(str, ",");
		if(pszTemp==NULL)continue;
		CADInsert* pInsert=new CADInsert();
		m_pGraphics->m_Entities.Add((CObject*)pInsert);
		pInsert->m_nLayer=curLayerIndex;
		pInsert->m_xScale = (double)m_PaperScale/1000;
		pInsert->m_yScale = (double)m_PaperScale/1000;
		strcpy(pInsert->m_Name,str);

		GetPrivateProfileString(keyName,"孔口坐标Y","",str,strMaxLen,lpFilename);
		if(pszTemp == NULL)continue;
		pInsert->pt.x = atof(pszTemp);
		GetPrivateProfileString(keyName,"孔口坐标X","",str,strMaxLen,lpFilename);
		if(pszTemp == NULL)continue;
		pInsert->pt.y = atof(pszTemp);

		if (strcmp(pInsert->m_Name,"小螺纹钻孔")==0)continue;
		curLayerIndex = (short)m_pLayerGroup->indexOf("0");//
		if (curLayerIndex == -1)curLayerIndex = 0;
		//create -|-
		const float crossWidth = 7;//mm
		const float crossHeight = 2.5;//mm
		ADPOINT adPoint = {pInsert->pt.x,
						   pInsert->pt.y + (double)(6*m_PaperScale)/1000};
		GetPrivateProfileString(keyName,"编号","",str,strMaxLen,lpFilename);

		//check is existing

		CADBlock* pBlock;
		pBlock=new CADBlock();
		strcpy(pBlock->m_Name,"工程勘察_");
		strcat(pBlock->m_Name,str);
		int index=m_pGraphics->IndexOfBlocks(pBlock->m_Name);
		if (index > -1)
		{
			delete pBlock;
			continue;
		}
		m_pGraphics->m_Blocks.Add((CObject*)pBlock);
		//strcpy(pBlock->m_Handle,"20");
		pBlock->m_nLayer = curLayerIndex;

		pInsert=new CADInsert();
		m_pGraphics->m_Entities.Add((CObject*)pInsert);
		pInsert->m_nLayer = curLayerIndex;
		pInsert->m_xScale = 1;
		pInsert->m_yScale = 1;
		strcpy(pInsert->m_Name,"工程勘察_");
		strcat(pInsert->m_Name,str);
		pInsert->pt.x = adPoint.x;
		pInsert->pt.y = adPoint.y;

		//strcpy(pBlock->m_Handle2,"21");
		CADLine* pLine=new CADLine();
		pBlock->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x = - (double)(crossWidth*m_PaperScale)/1000;
		pLine->pt1.y = 0;
		pLine->pt2.x = (double)(crossWidth*m_PaperScale)/1000;
		pLine->pt2.y = pLine->pt1.y;

		pLine=new CADLine();
		pBlock->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x = 0;
		pLine->pt1.y = (double)(crossHeight*m_PaperScale)/1000;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = - (double)(crossHeight*m_PaperScale)/1000;

		float fontheight = 2*m_PaperScale/1000;
		CADMText* pMText=new CADMText();
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		//strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = fontheight;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x = 0 - (double)crossWidth/2*m_PaperScale/1000;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"孔深","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		//strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = fontheight;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = 0 - (double)crossWidth/2*m_PaperScale/1000;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"孔口标高","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		//strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = fontheight;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x = 0 + (double)crossWidth/2*m_PaperScale/1000;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"水位标高","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		//strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = fontheight;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = 0 + (double)crossWidth/2*m_PaperScale/1000;
		pMText->m_Location.y = 0;
	}
}