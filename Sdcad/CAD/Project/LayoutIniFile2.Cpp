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
	int i;
	const short strMaxLen=255;
	char str[strMaxLen];
	short curLayerIndex = (short)m_pLayerGroup->indexOf("钻孔图例");//
	if (curLayerIndex == -1)curLayerIndex = 0;
	for(i=0;i<m_HoleNum;i++)
	{
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

		GetPrivateProfileString(keyName,"孔口坐标X","",str,strMaxLen,lpFilename);
		if(pszTemp == NULL)continue;
		pInsert->pt.x = atof(pszTemp);
		GetPrivateProfileString(keyName,"孔口坐标Y","",str,strMaxLen,lpFilename);
		if(pszTemp == NULL)continue;
		pInsert->pt.y = atof(pszTemp);

		ADPOINT adPoint = {pInsert->pt.x,
						   pInsert->pt.y + (double)(10*m_PaperScale)/1000};
		//create -|-
		GetPrivateProfileString(keyName,"编号","",str,strMaxLen,lpFilename);
		CADBlock* pBlock;
		pBlock=new CADBlock();
		m_Blocks.Add((CObject*)pBlock);
		strcpy(pBlock->m_Name,str);
		//strcpy(pBlock->m_Handle,"20");
		pBlock->m_nLayer = curLayerIndex;
		//strcpy(pBlock->m_Handle2,"21");
		CADLine* pLine=new CADLine();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x = - (double)(5*m_PaperScale)/1000;
		pLine->pt1.y = (double)(5*m_PaperScale)/1000;
		pLine->pt2.x = (double)(5*m_PaperScale)/1000;
		pLine->pt2.y = pLine->pt1.y;
		pLine=new CADLine();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x = 0;
		pLine->pt1.y = (double)(5*m_PaperScale)/1000;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = - (double)(5*m_PaperScale)/1000;

		CADMText* pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = 3.5;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Location.x = 0;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"孔深","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = 3.5;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Location.x = 0;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"孔口标高","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = 3.5;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPRIGHT;
		pMText->m_Location.x = 0;
		pMText->m_Location.y = 0;

		GetPrivateProfileString(keyName,"水位标高","",str,strMaxLen,lpFilename);
		pMText=new CADMText();
		pDoc->m_pPaperGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text = str;
		strcpy(pMText->m_Font,"黑体");
		pMText->m_Height = 3.5;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = 0;
		pMText->m_Location.y = 0;
	}
}