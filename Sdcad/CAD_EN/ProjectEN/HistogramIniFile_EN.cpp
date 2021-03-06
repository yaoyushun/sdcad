#include "stdafx.h"
#include "HistogramIniFile_EN.h"
#define LegendWidth 0.8//unit cm
#include "..\FunctionLib\Function_System.h"

CHistogramIniFile_EN::CHistogramIniFile_EN(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
//initialize===============================================
	m_bOnePage = true;
	m_Deep=0;
	m_FontHeight=3.5;
	m_NumFontH=2.5;
	m_Layer0Top = 188.5 + 30;//188.5;
	//m_Row1Height=25;
	m_Row1Height = 32;
	m_LeftMargin=10;
	m_TopMargin=64;
	m_GridLeft=1;
	m_PaperDeep = 178 + 30-2;//178;
	m_nPaperCount=1;

	m_FrameLeft = 0;//mm
	m_FrameTop = 280;//250;
	m_FrameWidth = 355;//342;
	m_FrameHeight = 280-2;//250;

	m_nGridCols = 31;//30;
	m_GridColWidth = new double[m_nGridCols];

	short curColIndex = 0;
	const int COLWIDTH = 8;

	m_GridColWidth[curColIndex++]=COLWIDTH;

	//updated on 2005/10/8
	//for(int i=0;i<=3;i++)
	for(int i=0;i<=2;i++)
	{
		m_GridColWidth[curColIndex++]=10;
	}

	m_GridColWidth[curColIndex++]=20;
	//updated on 2005/10/8
	//m_GridColWidth[curColIndex++]=44;
	m_GridColWidth[curColIndex++]=44+(10-COLWIDTH)*15;
	m_GridColWidth[curColIndex++]=17;
	
	for(i=0;i<=2;i++)
	{
		//updated on 2005/10/8
		//m_GridColWidth[curColIndex++]=10;
		m_GridColWidth[curColIndex++]=COLWIDTH;
	}

	for(i=0;i<=3;i++)
	{
		m_GridColWidth[curColIndex++]=7;
	}
	//updated on 2005/10/8
	//m_GridColWidth[curColIndex++]=10;
	//m_GridColWidth[curColIndex++]=10;
	m_GridColWidth[curColIndex++]=COLWIDTH;
	m_GridColWidth[curColIndex++]=COLWIDTH;
	m_GridColWidth[curColIndex++]=7;//10;
	
	//updated on 2005/10/8
	/*for(i=0;i<=12;i++)
	{
		m_GridColWidth[curColIndex++]=10;
	}*/

	for(i=0;i<=1;i++)
	{
		m_GridColWidth[curColIndex++]=10;
	}
	for(i=0;i<=2;i++)
	{
		m_GridColWidth[curColIndex++]=COLWIDTH;
	}
	for(i=0;i<=1;i++)
	{
		m_GridColWidth[curColIndex++]=10;
	}
	for(i=0;i<=5;i++)
	{
		m_GridColWidth[curColIndex++]=COLWIDTH;
	}

	m_GridColWidth[curColIndex]=17;
//==========================================================
	m_HeadMargin=29.5;
	m_FootMargin=1.5;
	m_GridMargin=2;
	m_FootGridHeight=7;

	m_nFootGridCols = 12;
	m_FootGridColWidth = new double[m_nFootGridCols];
	
	short curFootColIndex = 0;
	m_FootGridColWidth[curFootColIndex++]=40;	
	m_FootGridColWidth[curFootColIndex++]=95;
	m_FootGridColWidth[curFootColIndex++]=13;
	m_FootGridColWidth[curFootColIndex++]=20;
	m_FootGridColWidth[curFootColIndex++]=13;
	m_FootGridColWidth[curFootColIndex++]=20;
	m_FootGridColWidth[curFootColIndex++]=13;
	m_FootGridColWidth[curFootColIndex++]=19;
	m_FootGridColWidth[curFootColIndex++]=13;
	m_FootGridColWidth[curFootColIndex++]=20;
	m_FootGridColWidth[curFootColIndex++]=32;
	m_FootGridColWidth[curFootColIndex++]=55;

	m_ProjectType = 0;
}

CHistogramIniFile_EN::~CHistogramIniFile_EN()
{
	delete m_GridColWidth;
}

void CHistogramIniFile_EN::FileImport(LPCTSTR lpFilename)
{
	m_FileName=lpFilename;

	char str[100];

	m_vScale=::GetPrivateProfileInt("������","Y",0,lpFilename);
	if(m_vScale==0)return;

	if (::GetPrivateProfileInt("������","һҳ��ӡ",0,lpFilename)==0)
		m_bOnePage = true;
	else
		m_bOnePage = false;

	GetPrivateProfileString("���","����","",str,255,lpFilename);
	//m_Deep=(int)atof(str);
	m_Deep = atof(str);
//create layers-----------------------------------------------------
	//m_PaperDeep = 9999999999.9;
	double mmDeep = (double)m_Deep/m_vScale*1000;
	if (m_bOnePage)
	{
		m_PaperDeep = mmDeep;
		m_nPaperCount = 1;
	}
	else
		m_nPaperCount = (short)(mmDeep / m_PaperDeep) + 1;

	for (int i=0;i<m_nPaperCount;i++)
	{
		CADLayer* pLayer;
		pLayer=new CADLayer();
		m_pGraphics->m_pLayerGroup->AddLayer(pLayer);
		char layerNum[4];
		itoa(i+1,layerNum,10);
		strcpy(pLayer->m_Name,layerNum);
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
		if (i == 0)
			pLayer->m_nColor=7;
		else
			pLayer->m_nColor=-7;
		CADGraphics::CreateHandle(pLayer->m_Handle);
	}
//===========================================================
	CreateChartGrid(0,280,m_PaperDeep);
	CreateChartHeader();
//	CreateChartFrame();
	CreateGrid();
	CreateBeatNum(lpFilename);
	CreateChartFooter(lpFilename);
}

double CHistogramIniFile_EN::GetGridColLeft(int i)
{
	double left;
	left=m_GridLeft;
	for(int j=0;j<i-1;j++)
	{
		left+=m_GridColWidth[j];
	}
	return left;
}

CADBlock* CHistogramIniFile_EN::CreateLayerBlock(CPerHoleLayer* pHoleLayer)
{
	if(pHoleLayer->m_ID=="")return NULL; 
	CString str;
	str=pHoleLayer->m_ID; 
	if(pHoleLayer->m_SubID!="")
	{
		str=str+"-";
		str=str+pHoleLayer->m_SubID;
	}

	CADBlock* pBlock;
	pBlock=new CADBlock();
	m_pGraphics->m_Blocks.Add((CObject*)pBlock);
	strcpy(pBlock->m_Name,(LPCTSTR)str);
	pBlock->m_BasePoint.x=0;
	pBlock->m_BasePoint.y=0;	
	pBlock->m_nLayer=0;

	CADBlockRecord* pBlockRecord=new CADBlockRecord();
	m_pGraphics->m_BlockRecords.Add((CObject*)pBlockRecord);
	strcpy(pBlockRecord->m_Name,pBlock->m_Name); 
	CADGraphics::CreateHandle(pBlockRecord->m_Handle);
//-----------------------------------------------------
	CADCircle* pCircle;;
	pCircle=new CADCircle();

	pCircle->m_nLayer=0;
	pBlock->m_Entities.Add((CObject*)pCircle);
	pCircle->m_nColor=7;
	pCircle->ptCenter.x=0;
	pCircle->ptCenter.y=0;
	pCircle->m_Radius=1.5;

	CADMText* pMText;
	pMText=new CADMText(); 
	pMText->m_nLayer=0;
	pBlock->m_Entities.Add((CObject*)pMText);
	pMText->m_nColor=7;
	pMText->m_Location.x=0;

	pMText->m_Text=pHoleLayer->m_ID;
	if(pMText->m_Text.GetLength()==1)
	{
		pMText->m_Location.y=0; 
		pMText->m_Height=2.5;
	}
	else if(pMText->m_Text.GetLength()==2)
	{
		pMText->m_Location.y=0;
		pMText->m_Height=2;
	}
	else
	{
		pMText->m_Location.y=0;
		pMText->m_Height=1.6;		
	}
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;

	if(pHoleLayer->m_SubID!="")
	{
		CADMText* pMText;
		pMText=new CADMText(); 
		pMText->m_nLayer=0;
		pBlock->m_Entities.Add((CObject*)pMText);
		pMText->m_nColor=7;
		pMText->m_Location.x=1.8;
		pMText->m_Location.y=-1.5; 
		pMText->m_Text=pHoleLayer->m_SubID;
		pMText->m_Height=1.5;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT; 			
	}	

	return pBlock;
}

void CHistogramIniFile_EN::CreateGrid()
{
	int i;
	CADLine* pLine;
	CADMText* pMText;
//=============================================================================================
	char str[1000];
	int maxStrLen=1000;
	GetPrivateProfileString("���","���","",str,maxStrLen,m_FileName);
	char* pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	char* pdest;
	pdest=strstr(pszTemp,"-");
	CPerHoleLayer* pHoleLayer;
	pHoleLayer=new CPerHoleLayer();
	m_Holelayers.Add(pHoleLayer);

	if(pdest != NULL)
	{
		int  length;
		length=pdest-pszTemp;
		char* ch=new char[length+1];
		memcpy(ch,pszTemp,length);
		ch[length]='\0';

		strcpy(pHoleLayer->m_ID,ch);
		length=strlen(pszTemp)-length-1;
		ch=new char[length+1];
		memcpy(ch,pdest+1,length);
		ch[length]='\0';
		strcpy(pHoleLayer->m_SubID,ch);
	}
	else
	{
		strcpy(pHoleLayer->m_ID,pszTemp);
		strcpy(pHoleLayer->m_SubID,"");
	}

	while(pszTemp)
	{
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=new CPerHoleLayer();
		m_Holelayers.Add(pHoleLayer);

		pdest=strstr(pszTemp,"-");
		if(pdest != NULL)
		{
			int  length;
			length=pdest-pszTemp;
			char* ch=new char[length+1];
			memcpy(ch,pszTemp,length);
			ch[length]='\0';

			strcpy(pHoleLayer->m_ID,ch);
			length=strlen(pszTemp)-length-1;
			ch=new char[length+1];
			memcpy(ch,pdest+1,length);
			ch[length]='\0';
			strcpy(pHoleLayer->m_SubID,ch);
		}
		else
		{
			strcpy(pHoleLayer->m_ID,pszTemp);
			strcpy(pHoleLayer->m_SubID,"");
		}
	}
//====================================================================================
/*	int nLayer1=m_pLayerGroup->indexOf("1");
	int nLayer2=1;
	int nLayer3=1;
	if(m_nPaperCount>1)
		nLayer2=m_pLayerGroup->indexOf("2");
	if(m_nPaperCount>2)
		nLayer3=m_pLayerGroup->indexOf("3");*/
	//int curLayer=nLayer1;

	GetPrivateProfileString("���","���","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	int curLayerIndex = 1;
	i=0;
	int LayerCount = m_Holelayers.GetSize(); 
	pHoleLayer = (CPerHoleLayer*)m_Holelayers.GetAt(i);
	pHoleLayer->m_Deep = atof(pszTemp)/m_vScale*1000;

	double curLayerDeep;
	double line1Left=m_GridLeft;
	double line1Right=GetGridColLeft(5)+8;
	double line2Left=line1Right+4;
	double line2Right=GetGridColLeft(6);
	double line3Left=GetGridColLeft(6);
	double line3Right=GetGridColLeft(7);

	curLayerDeep = pHoleLayer->m_Deep;
	
	if(curLayerDeep>m_PaperDeep)
	{
		curLayerIndex ++;
		curLayerDeep=curLayerDeep-m_PaperDeep;
	}

	pLine=new CADLine();	
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=line1Left;
	pLine->pt1.y=m_Layer0Top-curLayerDeep;
	pLine->pt2.x=line1Right;
	pLine->pt2.y=m_Layer0Top-curLayerDeep;

	pLine=new CADLine();	
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=line2Left;
	pLine->pt1.y=m_Layer0Top-curLayerDeep;
	pLine->pt2.x=line2Right;
	pLine->pt2.y=m_Layer0Top-curLayerDeep;

/*	pLine=new CADLine();	
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=line3Left;
	pLine->pt1.y=m_Layer0Top-curLayerDeep;
	pLine->pt2.x=line3Right;
	pLine->pt2.y=m_Layer0Top-curLayerDeep;*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	//pMText->m_Text.Format("%.2f",pHoleLayer->m_Deep);
	pMText->m_Text=pszTemp;
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	pMText->m_Location.x=GetGridColLeft(3)+m_GridColWidth[2]/2;
	pMText->m_Location.y=m_Layer0Top-curLayerDeep;
	strcpy(pMText->m_Font,"����_GB2312");

	double circleRadius=1.5+0.2;

	CADBlock* pBlock=CreateLayerBlock(pHoleLayer);
	if(pBlock)
	{
		CADInsert* pInsert=new CADInsert();
		m_pGraphics->m_Entities.Add((CObject*)pInsert);
		pInsert->m_nLayer=curLayerIndex;
		strcpy(pInsert->m_Name,pBlock->m_Name); 
		pInsert->pt.x=m_GridLeft+m_GridColWidth[0]/2;
		pInsert->pt.y=m_Layer0Top-curLayerDeep+circleRadius;
	}

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		pHoleLayer->m_Deep = atof(pszTemp)/m_vScale*1000;

		curLayerDeep += pHoleLayer->m_Deep;

		if(curLayerDeep>m_PaperDeep)
		{
			curLayerIndex ++;
			curLayerDeep = curLayerDeep-m_PaperDeep;
			/*if(curLayer==nLayer1)
				curLayer=nLayer2;
			else if(curLayer==nLayer2)
				curLayer=nLayer3;

			if((m_PaperDeep-(curLayerDeep-pHoleLayer->m_Deep))<5)
				curLayerDeep=pHoleLayer->m_Deep;
			else
				curLayerDeep=curLayerDeep-m_PaperDeep;*/
		}

		pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=line1Left;
		pLine->pt1.y=m_Layer0Top-curLayerDeep;
		pLine->pt2.x=line1Right;
		pLine->pt2.y=m_Layer0Top-curLayerDeep;

		pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=line2Left;
		pLine->pt1.y=m_Layer0Top-curLayerDeep;
		pLine->pt2.x=line2Right;
		pLine->pt2.y=m_Layer0Top-curLayerDeep;

		/*pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=line3Left;
		pLine->pt1.y=m_Layer0Top-curLayerDeep;
		pLine->pt2.x=line3Right;
		pLine->pt2.y=m_Layer0Top-curLayerDeep;*/

		pBlock=CreateLayerBlock(pHoleLayer);
		if(pBlock)
		{
			CADInsert* pInsert=new CADInsert();
			m_pGraphics->m_Entities.Add((CObject*)pInsert);
			pInsert->m_nLayer = curLayerIndex;
			strcpy(pInsert->m_Name,pBlock->m_Name); 
			pInsert->pt.x = m_GridLeft+m_GridColWidth[0]/2;
			pInsert->pt.y = m_Layer0Top-curLayerDeep+circleRadius;

			if (curLayerIndex>1 && curLayerDeep<circleRadius*2)
			{
				pInsert->m_nLayer = curLayerIndex-1;
				pInsert->pt.y = m_Layer0Top - m_PaperDeep + circleRadius;
			}
		}

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		//pMText->m_Text.Format("%.2f",pHoleLayer->m_Deep);
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x=GetGridColLeft(3)+m_GridColWidth[2]/2;
		pMText->m_Location.y=m_Layer0Top-curLayerDeep;
		strcpy(pMText->m_Font,"����_GB2312");

		if (curLayerIndex>1 && curLayerDeep<circleRadius*2)
		{
			pMText->m_nLayer = curLayerIndex-1;
			pMText->m_Location.y = m_Layer0Top - m_PaperDeep;
		}
	}
//===========================================================================================
	curLayerIndex = 1;
	//curLayer=nLayer1;
	GetPrivateProfileString("���","������","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	curLayerDeep=pHoleLayer->m_Deep;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=pszTemp;
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	pMText->m_Location.x=GetGridColLeft(2)+m_GridColWidth[1]/2;
	pMText->m_Location.y=m_Layer0Top-curLayerDeep;
	strcpy(pMText->m_Font,"����_GB2312");

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		curLayerDeep+=pHoleLayer->m_Deep;
		if(curLayerDeep>m_PaperDeep)
		{
			curLayerIndex ++;
			curLayerDeep = curLayerDeep-m_PaperDeep;
			/*if(curLayer==nLayer1)
				curLayer=nLayer2;
			else if(curLayer==nLayer2)
				curLayer=nLayer3;

			if((m_PaperDeep-(curLayerDeep-pHoleLayer->m_Deep))<5)
				curLayerDeep=pHoleLayer->m_Deep;
			else
				curLayerDeep=curLayerDeep-m_PaperDeep;*/
		}
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x=GetGridColLeft(2)+m_GridColWidth[1]/2;
		pMText->m_Location.y=m_Layer0Top-curLayerDeep;
		strcpy(pMText->m_Font,"����_GB2312");

		if (curLayerIndex>1 && curLayerDeep<circleRadius*2)
		{
			pMText->m_nLayer = curLayerIndex-1;
			pMText->m_Location.y = m_Layer0Top - m_PaperDeep;
		}
	}
//===========================================================================================
	curLayerIndex = 1;
	GetPrivateProfileString("���","��ױ��","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	curLayerDeep=pHoleLayer->m_Deep;
	pMText=new CADMText();

	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=pszTemp;
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	pMText->m_Location.x=GetGridColLeft(4)+m_GridColWidth[3]/2;
	pMText->m_Location.y=m_Layer0Top-curLayerDeep;
	strcpy(pMText->m_Font,"����_GB2312");

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		curLayerDeep+=pHoleLayer->m_Deep;
		if(curLayerDeep>m_PaperDeep)
		{
			curLayerIndex ++;
			curLayerDeep = curLayerDeep-m_PaperDeep;
			/*if(curLayer==nLayer1)
				curLayer=nLayer2;
			else if(curLayer==nLayer2)
				curLayer=nLayer3;

			if((m_PaperDeep-(curLayerDeep-pHoleLayer->m_Deep))<5)
				curLayerDeep=pHoleLayer->m_Deep;
			else
				curLayerDeep=curLayerDeep-m_PaperDeep;*/
		}
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x=GetGridColLeft(4)+m_GridColWidth[3]/2;
		pMText->m_Location.y=m_Layer0Top-curLayerDeep;
		strcpy(pMText->m_Font,"����_GB2312");

		if (curLayerIndex>1 && curLayerDeep<circleRadius*2)
		{
			pMText->m_nLayer = curLayerIndex-1;
			pMText->m_Location.y = m_Layer0Top - m_PaperDeep;
		}
	}
//===========================================================================================
	GetPrivateProfileString("���","�������","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	strcpy(pHoleLayer->m_Lengend,pszTemp);
	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		strcpy(pHoleLayer->m_Lengend,pszTemp); 
	}
//create hatch===========================================================================================
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	double supLayerDeep;
	curLayerDeep=0;
	curLayerIndex = 1;
	for(i=0;i<m_Holelayers.GetSize();i++)
	{
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		supLayerDeep=curLayerDeep;
		curLayerDeep+=pHoleLayer->m_Deep;
		if(curLayerDeep>m_PaperDeep)
		{
			//create first
			pPolyline=new CADPolyline();
			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(5);
			pPoint->y = m_Layer0Top-supLayerDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);
			pPoint->x = GetGridColLeft(5)+8;
			pPoint->y = m_Layer0Top-supLayerDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(5)+8;
			pPoint->y = m_Layer0Top-m_PaperDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(5);
			pPoint->y = m_Layer0Top-m_PaperDeep;
			ProcessHatch(pPolyline);
			CreateHatch(pHoleLayer->m_Lengend,pPolyline,curLayerIndex);
		//===
			pPolyline=new CADPolyline();
			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(5)+8+4;
			pPoint->y = m_Layer0Top-supLayerDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(6);
			pPoint->y = m_Layer0Top-supLayerDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(6);
			pPoint->y = m_Layer0Top-m_PaperDeep;

			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = GetGridColLeft(5)+8+4;
			pPoint->y = m_Layer0Top-m_PaperDeep;
			ProcessHatch(pPolyline);
			CreateHatch(pHoleLayer->m_Lengend,pPolyline,curLayerIndex);
			//------------------
			curLayerIndex ++;
			curLayerDeep=curLayerDeep-m_PaperDeep;
			supLayerDeep=0;
		}
		pPolyline=new CADPolyline();
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(5);
		pPoint->y = m_Layer0Top-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->x = GetGridColLeft(5)+8;
		pPoint->y = m_Layer0Top-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(5)+8;
		pPoint->y = m_Layer0Top-curLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(5);
		pPoint->y = m_Layer0Top-curLayerDeep;
		ProcessHatch(pPolyline);
		CreateHatch(pHoleLayer->m_Lengend,pPolyline,curLayerIndex);
	//===
		pPolyline=new CADPolyline();
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(5)+8+4;
		pPoint->y = m_Layer0Top-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(6);
		pPoint->y = m_Layer0Top-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(6);
		pPoint->y = m_Layer0Top-curLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		pPoint->x = GetGridColLeft(5)+8+4;
		pPoint->y = m_Layer0Top-curLayerDeep;
		ProcessHatch(pPolyline);
		CreateHatch(pHoleLayer->m_Lengend,pPolyline,curLayerIndex);
	}
//===========================================================================================
//1.��������
	CString tempStr;
	curLayerIndex = 1;
	curLayerDeep = 0;
	double curMTextLineDeep = 0;
	double curY = m_Layer0Top;

	for(i=0;i<m_Holelayers.GetSize();i++)
	{
		tempStr.Format("%d",(i+1)); 
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		GetPrivateProfileString("��������",tempStr,"",str,maxStrLen,m_FileName);

		//draw ������������
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text = str;
		pMText->m_Text.Replace("@","\n");//2004/08/05 hyg
		pMText->m_Width = m_GridColWidth[5] + 1.5;
		pMText->m_Height = m_FontHeight;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColLeft(6);
		pMText->m_Location.y = curY;

		pMText->m_isWarp = true; 
		strcpy(pMText->m_Font,"����_GB2312"); 
		//�����������ֵĳ���
		int l = pMText->m_Text.GetLength();
		//�����������ֵ�����(22 english chars per line)
		//int mTextRows = (int)((double)l/22 + 0.9);
		int mTextRows = (int)((double)l/40 + 0.9);
		const float fontHeight = 3.5;//mm

		float mTextHeight = mTextRows * fontHeight;
		curMTextLineDeep += mTextHeight;
		curLayerDeep += pHoleLayer->m_Deep;

		//�����������ֳ����ײ����
		bool bBeyond = false;
		double tmpMTextLineDeep = curMTextLineDeep;
		if (curMTextLineDeep < curLayerDeep)
			curMTextLineDeep = curLayerDeep;
		else
			bBeyond = true;

	//	if (mTextHeight > pHoleLayer->m_Deep)
	//	curLayerDeep += pHoleLayer->m_Deep;

		//if cur layer's deep beyond cur page frame bottom
		if (curLayerDeep>m_PaperDeep)
		{
			curLayerIndex ++;
			curLayerDeep = curLayerDeep - m_PaperDeep;
			
			//if (curMTextLineDeep>m_PaperDeep)
			if (tmpMTextLineDeep>m_PaperDeep || bBeyond)
			{
				pMText->m_nLayer = curLayerIndex;
				pMText->m_Location.y = m_Layer0Top;
				if (mTextHeight>curLayerDeep)
					curMTextLineDeep = mTextHeight;
				else
					curMTextLineDeep = curLayerDeep;
			}
			//added on 2005/8/24
			if (curMTextLineDeep>m_PaperDeep)
			{
				curMTextLineDeep = curLayerDeep;	
			}
		}
		
		if (bBeyond)
		{
			pPolyline = new CADPolyline();
			m_pGraphics->m_Entities.Add((CObject*)pPolyline);
			pPolyline->m_nLayer = curLayerIndex;
			pPoint = new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = line3Left;
			pPoint->y = m_Layer0Top - curLayerDeep;

			pPoint = new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);
			pPoint->x = line3Left+1;
			pPoint->y = m_Layer0Top-curMTextLineDeep;

			pPoint = new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = line3Right-1;
			pPoint->y = m_Layer0Top-curMTextLineDeep;

			pPoint = new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);  
			pPoint->x = line3Right;
			pPoint->y = m_Layer0Top-curLayerDeep;		
		}
		else
		{
			pLine = new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=curLayerIndex;
			pLine->pt1.x=line3Left;
			pLine->pt1.y=m_Layer0Top-curMTextLineDeep;
			pLine->pt2.x=line3Right;
			pLine->pt2.y=m_Layer0Top-curMTextLineDeep;
		}
		curY = m_Layer0Top - curMTextLineDeep;
	}
//===========================================================================================
	int m_nsampling;
	m_nsampling=::GetPrivateProfileInt("����","����",0,m_FileName);
	if(m_nsampling==0)return;

	curLayerIndex = 1;
	curLayerDeep=0;	
	
	for(i=0;i<m_nsampling;i++)
	{
		tempStr.Format("%d",(i+1));
		GetPrivateProfileString("����",tempStr,"",str,maxStrLen,m_FileName);

//		double curTop;
		pszTemp = strtok(str, ",");
		if(pszTemp==NULL)continue;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Text=pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(7)+m_GridColWidth[6]/2;
		pMText->m_Location.y=0;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)continue;

		//curLayerDeep=atof(pszTemp)/m_vScale*1000;
		curLayerDeep=atof(pszTemp)/m_vScale*1000 - (curLayerIndex-1)*m_PaperDeep;//modify 2004-05-31
		if(curLayerDeep>m_PaperDeep)
		{
			curLayerIndex ++;
			if (curLayerIndex>m_nPaperCount)return;
			curLayerDeep = curLayerDeep-m_PaperDeep;
		}
		double sampleTop;
		sampleTop = m_Layer0Top - curLayerDeep;
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Location.y=sampleTop;

		pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=GetGridColLeft(7);
		pLine->pt1.y=sampleTop;
		pLine->pt2.x=GetGridColLeft(8);
		pLine->pt2.y=sampleTop;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Text=pszTemp;		

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)continue;
		pMText->m_Text=pMText->m_Text+"��";
		pMText->m_Text=pMText->m_Text+pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(7)+m_GridColWidth[6]/2;
		pMText->m_Location.y=sampleTop;

		int j=8;
		while(pszTemp)
		{
			if(j>m_nGridCols)break;
			pszTemp = strtok(NULL,",");
			if(pszTemp==NULL)break;

			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer=curLayerIndex;
			pMText->m_Text=pszTemp;
			pMText->m_Height=m_NumFontH;
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
			pMText->m_Location.x=GetGridColLeft(j)+m_GridColWidth[j-1]/2;
			pMText->m_Location.y=sampleTop;
			strcpy(pMText->m_Font,"����_GB2312");
			j++;
		}
	}
}

void CHistogramIniFile_EN::CreateChartHeader()
{
	short curY = 242 + 30;//242;
	char str[255];
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("ͼֽ��Ϣ","��������","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = 29+2;
	pMText->m_Location.y = curY;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","���","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x=29+2;
	pMText->m_Location.y = curY - 10;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","�׿�����X","",str,255,m_FileName);
	pMText->m_Text="X=";
	pMText->m_Text+=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=130+2;
	pMText->m_Location.y=curY;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","�׿�����Y","",str,255,m_FileName);
	pMText->m_Text="Y=";
	pMText->m_Text+=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=130+2+25;
	pMText->m_Location.y=curY;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","�׿ڱ��","",str,255,m_FileName);
	pMText->m_Text=str;
//	pMText->m_Text=pMText->m_Text+"(m)";
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x=130+2;
	pMText->m_Location.y = curY - 10;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","����ˮλ","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=227+2;
	pMText->m_Location.y=curY;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","�ȶ�ˮλ","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=227+2;
	pMText->m_Location.y= curY - 10;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","��������","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=301+2;
	pMText->m_Location.y=curY;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("���","�깤����","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	pMText->m_Location.x=301+2;
	pMText->m_Location.y=curY - 10;
//----------------------------------------------------------------------
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	if(m_vScale>999)
		pMText->m_Text.Format("1:  %d",m_vScale);
	else
		pMText->m_Text.Format("1:   %d",m_vScale);
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=m_FontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = 51;
	pMText->m_Location.y = 201.5 + 30;

}

void CHistogramIniFile_EN::CreateChartFrame()
{
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=3;

	pPoint=new ADPOINT();
	pPoint->x = m_FrameLeft;
	pPoint->y = m_FrameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_FrameLeft+m_FrameWidth;
	pPoint->y = m_FrameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_FrameLeft+m_FrameWidth;
	pPoint->y = m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_FrameLeft;
	pPoint->y = m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
}

void CHistogramIniFile_EN::CreateChartGrid(double left,double top,double holeDeep)
{
//	return;
	int layerIndex = 0;

	double headRow1Height = 7;
	double headRow2Height = 7;
	double headRow3Height = 13;

	double GridWidth = 0.0;
	for (int i=0; i<m_nGridCols; i++)
	{
		GridWidth += m_GridColWidth[i];
	}

	double frameWidth;
	double frameHeight;
	frameWidth = GridWidth + m_GridLeft*2;
	frameHeight = m_HeadMargin + m_Row1Height + holeDeep + m_GridMargin + m_FootGridHeight + m_FootMargin;
	
	//Frame outline
	CADPolyline* pPolyline=new CADPolyline();
	pPolyline->m_nLayer=layerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top;	
	pPolyline->m_Point.Add((CObject*)pPoint);

	pPoint=new ADPOINT();
	pPoint->x = left+frameWidth;
	pPoint->y = top;	
	pPolyline->m_Point.Add((CObject*)pPoint);

	pPoint=new ADPOINT();
	pPoint->x = left+frameWidth;
	pPoint->y = top-frameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top-frameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	//Grid outline
	double gridTop;
	gridTop = top-m_HeadMargin;
	double gridBottom;
	gridBottom = top-m_HeadMargin-m_Row1Height-holeDeep;
	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=layerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	
//	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft;
	pPoint->y = gridTop;	
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft + GridWidth;
	pPoint->y = gridTop;	
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft + GridWidth;
	pPoint->y = gridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft;
	pPoint->y = gridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);

	//Foot grid outline
	double footGridTop = gridBottom - m_GridMargin;
	double footGridBottom = footGridTop - m_FootGridHeight;
	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=layerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	
//	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft;
	pPoint->y = footGridTop;	
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft + GridWidth;
	pPoint->y = footGridTop;	
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft + GridWidth;
	pPoint->y = footGridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	pPoint=new ADPOINT();
	pPoint->x = left + m_GridLeft;
	pPoint->y = footGridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	
	//Grid lines
	CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = layerIndex;
	pLine->pt1.x = left + m_GridLeft;
	pLine->pt1.y = top - m_HeadMargin - m_Row1Height;
	pLine->pt2.x = left + m_GridLeft + GridWidth;
	pLine->pt2.y = top - m_HeadMargin - m_Row1Height;

	double headline2Margin;
	headline2Margin = m_HeadMargin + headRow1Height + headRow2Height + headRow3Height;
//	CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = layerIndex;
	pLine->pt1.x = left + m_GridLeft + m_GridColWidth[0];
	pLine->pt1.y = top - headline2Margin;
	pLine->pt2.x = left + m_GridLeft + GridWidth;
	pLine->pt2.y = top - headline2Margin;

	double curWidth = m_GridLeft;
	for(i=0;i<m_nGridCols-1;i++)
	{
		if ( i==1 || i==2 )
		{
			curWidth+=m_GridColWidth[i];

			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=gridTop;
			pLine->pt2.x=left+curWidth;
			pLine->pt2.y=top-headline2Margin;

			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;			
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=top-m_HeadMargin-m_Row1Height;
			pLine->pt2.x=left+curWidth;
			pLine->pt2.y=gridBottom;
		}
		else
		{
			if ( i==7 || (i>=9 && i<=12) || i==20 || i==22 || i==24 || i==25 || i==27 )
			{
				curWidth+=m_GridColWidth[i];

				pLine=new CADLine();
				m_pGraphics->m_Entities.Add((CObject*)pLine);
				pLine->m_nLayer=layerIndex;
				pLine->pt1.x=left+curWidth;
				pLine->pt1.y=gridTop-headRow1Height;
				pLine->pt2.x=left+curWidth;
				pLine->pt2.y=gridBottom;
			}
			else
			{
				if ( i==8 )
				{
					curWidth+=m_GridColWidth[i];

					pLine=new CADLine();
					m_pGraphics->m_Entities.Add((CObject*)pLine);
					pLine->m_nLayer=layerIndex;
					pLine->pt1.x=left+curWidth;
					pLine->pt1.y=gridTop-headRow1Height-headRow2Height;
					pLine->pt2.x=left+curWidth;
					pLine->pt2.y=gridTop-headRow1Height-headRow2Height-headRow3Height;
					
					pLine=new CADLine();
					m_pGraphics->m_Entities.Add((CObject*)pLine);
					pLine->m_nLayer=layerIndex;			
					pLine->pt1.x=left+curWidth;
					pLine->pt1.y=gridTop-m_Row1Height;
					pLine->pt2.x=left+curWidth;
					pLine->pt2.y=gridBottom;
				}
				else
				{
					curWidth+=m_GridColWidth[i];

					pLine=new CADLine();
					m_pGraphics->m_Entities.Add((CObject*)pLine);
					pLine->m_nLayer=layerIndex;
					pLine->pt1.x=left+curWidth;
					pLine->pt1.y=gridTop;
					pLine->pt2.x=left+curWidth;
					pLine->pt2.y=gridBottom;
				}
				
			}
		}
		
		if ( i==3 )
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth+8;
			pLine->pt1.y=gridTop-m_Row1Height;
			pLine->pt2.x=left+curWidth+8;
			pLine->pt2.y=gridBottom;

			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth+12;
			pLine->pt1.y=gridTop-m_Row1Height;
			pLine->pt2.x=left+curWidth+12;
			pLine->pt2.y=gridBottom;
		}

		if ( i==6 )
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=gridTop-headRow1Height;
			pLine->pt2.x=left+GetGridColLeft(15);
			pLine->pt2.y=gridTop-headRow1Height;
		}

		if ( i==7 )
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=gridTop-headRow1Height-headRow2Height;
			pLine->pt2.x=left+GetGridColLeft(11);
			pLine->pt2.y=gridTop-headRow1Height-headRow2Height;
		}

		if ( i==19 )
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=gridTop-headRow1Height;
			pLine->pt2.x=left+GetGridColLeft(30);
			pLine->pt2.y=gridTop-headRow1Height;
		}

		if ( i==23 )
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=layerIndex;
			pLine->pt1.x=left+curWidth;
			pLine->pt1.y=gridTop-headRow1Height-headRow2Height;
			pLine->pt2.x=left+GetGridColLeft(31);
			pLine->pt2.y=gridTop-headRow1Height-headRow2Height;
		}
	}
	
	//Foot grid lines
	curWidth = m_GridLeft;
	for(i=0;i<m_nFootGridCols-1;i++)
	{
		curWidth+=m_FootGridColWidth[i];
		
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=layerIndex;
		pLine->pt1.x=left+curWidth;
		pLine->pt1.y=footGridTop;
		pLine->pt2.x=left+curWidth;
		pLine->pt2.y=footGridBottom;
	}	

	//Frame head text
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�������ƣ�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+29;
	pMText->m_Location.y=top-8;
	strcpy(pMText->m_Font,"����_GB2312");

//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��ױ�ţ�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+29;
	pMText->m_Location.y=top-18;
	strcpy(pMText->m_Font,"����_GB2312");

//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="���λ�ã�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+130;
	pMText->m_Location.y=top-8;
	strcpy(pMText->m_Font,"����_GB2312");
	
//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�׿ڱ�ߣ�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+130;
	pMText->m_Location.y=top-18;
	strcpy(pMText->m_Font,"����_GB2312");

//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="����ˮλ������/��ߣ���";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+227;
	pMText->m_Location.y=top-8;
	strcpy(pMText->m_Font,"����_GB2312");
	
//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�ȶ�ˮλ������/��ߣ���";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+227;
	pMText->m_Location.y=top-18;
	strcpy(pMText->m_Font,"����_GB2312");

//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�������ڣ�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+301;
	pMText->m_Location.y=top-8;
	strcpy(pMText->m_Font,"����_GB2312");
	
//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�깤���ڣ�";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x=left+301;
	pMText->m_Location.y=top-18;
	strcpy(pMText->m_Font,"����_GB2312");

	//Grid text
//	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n\n\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+m_GridLeft+m_GridColWidth[0]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(2)+m_GridColWidth[1]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(3)+m_GridColWidth[2]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(4)+m_GridColWidth[3]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��״����\n\n�� �� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(5)+m_GridColWidth[4]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�ң���������";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(6)+m_GridColWidth[5]/2;
	pMText->m_Location.y=gridTop-12.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ȡ��\n\n���";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(7)+m_GridColWidth[6]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="����";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(7)+m_GridColWidth[6]/2;
	pMText->m_Location.y=gridTop-19;
	strcpy(pMText->m_Font,"����_GB2312");

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=layerIndex;
	pLine->pt1.x=left+GetGridColLeft(7)+2;
	pLine->pt1.y=gridTop-17;
	pLine->pt2.x=left+GetGridColLeft(8)-2;
	pLine->pt2.y=gridTop-17;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��Ȼ״̬�Ļ�����������ָ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	double tmpColWidth = 0.0;
	for ( i=7; i<=13; i++ )
	{
		tmpColWidth += m_GridColWidth[i];
	}
	pMText->m_Location.x=left+GetGridColLeft(8)+tmpColWidth/2;
	pMText->m_Location.y=gridTop-3;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\nˮ\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(8)+m_GridColWidth[7]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="w";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(8)+m_GridColWidth[7]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(9)+(m_GridColWidth[8]+m_GridColWidth[9])/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ʪ\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(9)+m_GridColWidth[8]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="w";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(9)+m_GridColWidth[8]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(10)+m_GridColWidth[9]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="d";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(10)+m_GridColWidth[9]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n��\nGs";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(11)+m_GridColWidth[10]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n϶\n��\n\ne";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(12)+m_GridColWidth[11]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n϶\n��\n\nn";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(13)+m_GridColWidth[12]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n\nSr";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(14)+m_GridColWidth[13]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Һ\n\n\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(15)+m_GridColWidth[14]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="L";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(15)+m_GridColWidth[14]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n\n\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(16)+m_GridColWidth[15]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="P";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(16)+m_GridColWidth[15]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\nָ\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(17)+m_GridColWidth[16]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="P";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(17)+m_GridColWidth[16]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Һ\n��\nָ\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(18)+m_GridColWidth[17]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="L";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(18)+m_GridColWidth[17]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ѹ\n��\nϵ\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(19)+m_GridColWidth[18]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="1~2";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(19)+m_GridColWidth[18]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ѹ\n��\nģ\n��\n\nE";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(20)+m_GridColWidth[19]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="s";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(20)+m_GridColWidth[19]/2+1;
	pMText->m_Location.y=gridTop-23.7;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ֱ ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(21)+(m_GridColWidth[20]+m_GridColWidth[21])/2;
	pMText->m_Location.y=gridTop-3.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(23)+(m_GridColWidth[22]+m_GridColWidth[23])/2;
	pMText->m_Location.y=gridTop-3.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n\nc";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(21)+m_GridColWidth[20]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Ħ\n��\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(22)+m_GridColWidth[21]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��\n��\n��\n\nc";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(23)+m_GridColWidth[22]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Ħ\n��\n��\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(24)+m_GridColWidth[23]/2;
	pMText->m_Location.y=gridTop-8.5;
	strcpy(pMText->m_Font,"����_GB2312");
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ɰ ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(25)+(m_GridColWidth[24]+m_GridColWidth[25]+m_GridColWidth[26])/2;
	pMText->m_Location.y=gridTop-3.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(28)+(m_GridColWidth[27]+m_GridColWidth[28])/2;
	pMText->m_Location.y=gridTop-3.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(25)+m_GridColWidth[24]/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(26)+m_GridColWidth[25]/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ϸ";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(27)+m_GridColWidth[26]/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(28)+m_GridColWidth[27]/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ϸ";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetGridColLeft(29)+m_GridColWidth[28]/2;
	pMText->m_Location.y=gridTop-10.5;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="2.0\n��\n0.5";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(25)+m_GridColWidth[24]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="0.5\n��\n0.25";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(26)+m_GridColWidth[25]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	if (m_ProjectType==0)
		pMText->m_Text="0.25\n��\n.075";
	else
		pMText->m_Text="0.25\n��\n0.10";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(27)+m_GridColWidth[26]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	if (m_ProjectType==0)
		pMText->m_Text=".075\n��\n0.05";
	else
		pMText->m_Text="0.10\n��\n0.05";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(28)+m_GridColWidth[27]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="0.05\n��\n.005";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(29)+m_GridColWidth[28]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="\n<\n.005";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(30)+m_GridColWidth[29]/2;
	pMText->m_Location.y=gridTop-16;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ճ\n\n��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(30)+m_GridColWidth[29]/2;
	pMText->m_Location.y=gridTop-1;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ԭ λ\n�� ��\n�� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(31)+m_GridColWidth[30]/2;
	pMText->m_Location.y=gridTop-5;
	strcpy(pMText->m_Font,"����_GB2312");

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=layerIndex;
	pLine->pt1.x=left+GetGridColLeft(31)+2;
	pLine->pt1.y=gridTop-17;
	pLine->pt2.x=left+GetGridColLeft(31)+m_GridColWidth[30]-2;
	pLine->pt2.y=gridTop-17;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="�� ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(31)+m_GridColWidth[30]/2;
	pMText->m_Location.y=gridTop-19;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="m";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(3);
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="m��m";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(7)+m_GridColWidth[6]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="%";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(8)+m_GridColWidth[7]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="g/cm";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(9)+(m_GridColWidth[8]+m_GridColWidth[9])/2;
	pMText->m_Location.y=gridTop-28.5;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="3";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(9)+(m_GridColWidth[8]+m_GridColWidth[9])/2+3.0;
	pMText->m_Location.y=gridTop-28.3;
	strcpy(pMText->m_Font,"����");

	for ( i=12; i<=15; i++ )
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=layerIndex;
		pMText->m_Text="%";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=left+GetGridColLeft(i+1)+m_GridColWidth[i]/2;
		pMText->m_Location.y=gridTop-29;
		strcpy(pMText->m_Font,"����");
	}
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="MP��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(19)+m_GridColWidth[18]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="-1";
	pMText->m_Height=m_NumFontH;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+GetGridColLeft(19)+m_GridColWidth[18]/2+2;
	pMText->m_Location.y=gridTop-28.3;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="MP��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(20)+m_GridColWidth[19]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="kP��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(21)+m_GridColWidth[20]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(22)+m_GridColWidth[21]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="kP��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(23)+m_GridColWidth[22]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����");
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(24)+m_GridColWidth[23]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����_GB2312");

	for ( i=24; i<=29; i++ )
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=layerIndex;
		pMText->m_Text="%";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=left+GetGridColLeft(i+1)+m_GridColWidth[i]/2;
		pMText->m_Location.y=gridTop-29;
		strcpy(pMText->m_Font,"����");
	}

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��/m";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=left+GetGridColLeft(31)+m_GridColWidth[30]/2;
	pMText->m_Location.y=gridTop-29;
	strcpy(pMText->m_Font,"����_GB2312");
	
	//Foot grid text
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="����״ͼ";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
	pMText->m_Location.x=left+GetFootGridColLeft(3)-2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="����";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetFootGridColLeft(3)+m_FootGridColWidth[2]/2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="����";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetFootGridColLeft(5)+m_FootGridColWidth[4]/2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="���";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetFootGridColLeft(7)+m_FootGridColWidth[6]/2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="ͼ����";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetFootGridColLeft(9)+m_FootGridColWidth[8]/2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="��   �Ź�   ��";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=left+GetFootGridColLeft(11)+m_FootGridColWidth[10]/2;
	pMText->m_Location.y=footGridTop-m_FootGridHeight/2;
	strcpy(pMText->m_Font,"����_GB2312");
}

void CHistogramIniFile_EN::CreateChartFooter(LPCTSTR lpFilename)
{
	CADMText* pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=0;
	char str[255];
	::GetPrivateProfileString("ͼֽ��Ϣ","���̱��","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GetGridColLeft(1) + (GetGridColLeft(5)-GetGridColLeft(1))/2;
	pMText->m_Location.y=m_Layer0Top-m_PaperDeep-5.5;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=0;
	::GetPrivateProfileString("���","���","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"����_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GetGridColLeft(5) + 40;
	pMText->m_Location.y=m_Layer0Top-m_PaperDeep-5.5;
}

void CHistogramIniFile_EN::CreateHatch(char* LegendName,CADPolyline* pPolyline,int nLayer)
{
//check special legend---------------------
	short SpecialLegendCount = 5;
	//char* SpecialLegend[] = {"��ɰ","ϸɰ","��ɰ","��ɰ","��ɰ","��ɰ��","ϸɰ��","��ɰ��","��ɰ��","���ʷ�ɰ��"};
	char  SpecialLegendChar[] = {'f','x','z','c','l'};

	int legendCharIndex = -1;
	/*for(int i=0;i<=SpecialLegendCount-1;i++)
	{
		if(strcmp(LegendName,SpecialLegend[i])==0)
		{
			strcpy(LegendName,"ɰ");
			legendCharIndex = i;
			break;
		}
	}*/
	if (strcmp(LegendName,"��ɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"��ϸɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"��ɰ��ϸɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"��ɰ�з���")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"ϸɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"��ɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"��ϸɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"�д�ɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"��ɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"��ɰ")==0)
	{
		strcpy(LegendName,"ɰ");
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"��ɰ��")==0)
	{
		strcpy(LegendName,"ɰ��");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"ϸɰ��")==0)
	{
		strcpy(LegendName,"ɰ��");
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"��ɰ��")==0)
	{
		strcpy(LegendName,"ɰ��");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"��ɰ��")==0)
	{
		strcpy(LegendName,"ɰ��");
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"������ɰ��")==0)
	{
		legendCharIndex = 0;	
	}
	/*else if (strcmp(LegendName,"��ɰ�з���")==0)
	{
		strcpy(LegendName,"ɰ�ʷ���");
		legendCharIndex = 0;	
	}*/
	else if (strcmp(LegendName,"����ɰ����ճ��")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"����ɰճ��")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"����ɰ�����ʷ���ճ��")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"��ճ������ɳ")==0)
	{
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"��ճ����ϸɳ")==0)
	{
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"��ճ������ɳ")==0)
	{
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"��ճ������ɳ")==0)
	{
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"��ճ������ɳ")==0)
	{
		legendCharIndex = 4;	
	}
//-----------------------------------------
	char LegendFile[255];
	GetAppDir(LegendFile);
	strcat(LegendFile,"ACADISO.PAT");

	FILE* fp;
	fp=fopen(LegendFile,"r");
	if(fp==NULL)return;

	char str[1000];

	if(LegendName=="")return;

	while(! feof(fp) && ! ferror(fp))
	{
		fscanf(fp,"%s\n",str);
		char* pdest;
		pdest=strstr(str,",");
		if(pdest != NULL)
		{
			/*length=pdest-str;
			char* strLegend=new char[length+1];
			memcpy(strLegend,str,length);
			strLegend[length]='\0';*/
			char* strLegend=pdest+1;
			if(strcmp(strLegend,LegendName)==0)
			{
				fscanf(fp,"%s\n",str);
				CADHatch* pHatch=new CADHatch();
				m_pGraphics->m_Entities.Add((CObject*)pHatch);
				pHatch->m_Scale = 10.0;
				pHatch->m_nLayer=nLayer;
				strcpy(pHatch->m_Name,LegendName);
				pHatch->m_pPolyline=pPolyline;
				CreateHatchLine(str,pHatch);
				fscanf(fp,"%s\n",str);
				while(str[0]!='*' && ! feof(fp) && ! ferror(fp))
				{
					CreateHatchLine(str,pHatch);
					fscanf(fp,"%s\n",str);
				}
				//special legend--------------------------------
				if(legendCharIndex>-1)
				{
					CADMText* pMText;
					pMText=new CADMText();
					m_pGraphics->m_Entities.Add((CObject*)pMText);
					pMText->m_nLayer=nLayer;
					pMText->m_Text=SpecialLegendChar[legendCharIndex];
					pMText->m_Height=2.5;
					pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
					ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(0);
					pMText->m_Location.x = pPoint->x;
					pMText->m_Location.y = pPoint->y;
					pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(1);
					pMText->m_Location.x += pPoint->x;
					pMText->m_Location.x /= 2;
					pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(2);
					pMText->m_Location.y += pPoint->y;
					pMText->m_Location.y /= 2;
				}
				//----------------------------------------------
				return;
			}
		}
	}
}

void CHistogramIniFile_EN::CreateHatchLine(char* hatchLineStr,CADHatch* pHatch)
{
	CADHatchLine* pHatchLine=new CADHatchLine();
	pHatch->m_HatchLines.Add((CObject*)pHatchLine);

	char* pszTemp = strtok(hatchLineStr, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_Angle=atof(pszTemp);
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_BasePoint.x=atof(pszTemp)*pHatch->m_Scale;
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_BasePoint.y=atof(pszTemp)*pHatch->m_Scale;
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	double tempDx,tempDy;
	tempDx = atof(pszTemp)*pHatch->m_Scale;
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	tempDy = atof(pszTemp)*pHatch->m_Scale;
	pHatchLine->m_xOffset = tempDx*cos(pHatchLine->m_Angle*PI/180) - tempDy*sin(pHatchLine->m_Angle*PI/180);
	pHatchLine->m_yOffset = tempDy*cos(pHatchLine->m_Angle*PI/180) + tempDx*sin(pHatchLine->m_Angle*PI/180);

	pHatchLine->m_NumDash=0;
	pszTemp = strtok(NULL, ",");
	double doubleTemp;
	double curPos=0;
	pHatchLine->m_NumDash=0;
	while(pszTemp)
	{
		doubleTemp=atof(pszTemp)*pHatch->m_Scale;
		if(pHatchLine->m_NumDash<HATCHITEMS)
			pHatchLine->m_Items[pHatchLine->m_NumDash]=doubleTemp;
		pHatchLine->m_NumDash++;
		pszTemp=strtok(NULL, ",");
	}
	return;
}

void CHistogramIniFile_EN::CreateBeatNum(LPCTSTR lpFilename)
{
//ԭλ���Ի���-----------------------------------------------
	CADLine* pLine;
	CADMText* pMText;
	char str[2000];
	int maxStrLen=2000;
	short curLayerIndex = 1;
	double curLayerDeep = 0;
	GetPrivateProfileString("ԭλ���Ի���","1","",str,maxStrLen,lpFilename);
	
	char* pszTemp = strtok(str, ",");
	if(pszTemp==NULL)return;

	const short curCol = 31;

	while(pszTemp)
	{
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Text = "N= ";
		pMText->m_Text += pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol-1]/2;
		pMText->m_Location.y=0;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;

		curLayerDeep=atof(pszTemp)/m_vScale*1000;
		if(curLayerDeep>m_PaperDeep)
		{
			if (curLayerDeep/m_PaperDeep > curLayerIndex)
				curLayerIndex ++;
			if (curLayerIndex>m_nPaperCount)return;
			curLayerDeep = curLayerDeep-m_PaperDeep;
		}
		double sampleTop;
		sampleTop=m_Layer0Top-curLayerDeep;
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Location.y=sampleTop;

		pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=GetGridColLeft(curCol);
		pLine->pt1.y=sampleTop;
		pLine->pt2.x=GetGridColLeft(curCol + 1);
		pLine->pt2.y=sampleTop;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Text=pszTemp;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;
		pMText->m_Text=pMText->m_Text+"��";
		pMText->m_Text=pMText->m_Text+pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol - 1]/2;
		pMText->m_Location.y=sampleTop;
		pszTemp = strtok(NULL, ",");
	}

//added on 20050909
	GetPrivateProfileString("ԭλ���Ի���","0","",str,maxStrLen,lpFilename);
	
	pszTemp = strtok(str, ",");
	if(pszTemp==NULL)return;

	while(pszTemp)
	{
		CADMText *pMText_N = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText_N);
		pMText_N->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText_N->m_Text = "N";
		strcpy(pMText_N->m_Font,"����_GB2312");
		pMText_N->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText_N->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol-1]/2;
		pMText_N->m_Location.y=0;

		//63.5
		CADMText *pMText_63 = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText_63);
		pMText_63->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText_63->m_Text = pszTemp;
		strcpy(pMText_63->m_Font,"����_GB2312");
		pMText_63->m_Height = m_NumFontH/2;
		//pMText->m_Width=3;
		pMText_63->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol-1]/2;
		pMText_63->m_Location.y=0;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;

		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMLEFT;
		pMText->m_Text = "= ";
		pMText->m_Text += pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol-1]/2;
		pMText->m_Location.y=0;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;

		curLayerDeep=atof(pszTemp)/m_vScale*1000;
		if(curLayerDeep>m_PaperDeep)
		{
			if (curLayerDeep/m_PaperDeep > curLayerIndex)
				curLayerIndex ++;
			if (curLayerIndex>m_nPaperCount)return;
			curLayerDeep = curLayerDeep-m_PaperDeep;
		}
		double sampleTop;
		sampleTop=m_Layer0Top-curLayerDeep;
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Location.y = sampleTop;

		pMText_N->m_nLayer=curLayerIndex;
		pMText_N->m_Location.y = sampleTop;
		pMText_63->m_nLayer=curLayerIndex;
		pMText_63->m_Location.y = sampleTop;

		/*double textLength = (double)pMText->m_Text.GetLength() * (m_NumFontH/1.5);
		textLength += (double)pMText_N->m_Text.GetLength() * (m_NumFontH/1.5);
		textLength += (double)pMText_63->m_Text.GetLength() * (m_NumFontH/1.5);*/
		double curX;
		curX = GetGridColLeft(curCol)+m_GridColWidth[curCol-1]/2;
		curX -= pMText_63->m_Text.GetLength() * (m_NumFontH/4);
		pMText_N->m_Location.x = curX;

		pLine=new CADLine();	
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=GetGridColLeft(curCol);
		pLine->pt1.y=sampleTop;
		pLine->pt2.x=GetGridColLeft(curCol + 1);
		pLine->pt2.y=sampleTop;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Text=pszTemp;

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;
		pMText->m_Text=pMText->m_Text+"��";
		pMText->m_Text=pMText->m_Text+pszTemp;
		strcpy(pMText->m_Font,"����_GB2312");
		pMText->m_Height=m_NumFontH;
		//pMText->m_Width=3;
		pMText->m_Location.x=GetGridColLeft(curCol)+m_GridColWidth[curCol - 1]/2;
		pMText->m_Location.y=sampleTop;
		pszTemp = strtok(NULL, ",");
	}
}

void CHistogramIniFile_EN::ProcessHatch(CADPolyline* pPolyline)
{
	ADPOINT* pPoint2 = (ADPOINT*)pPolyline->m_Point.GetAt(1);
	ADPOINT* pPoint3 = (ADPOINT*)pPolyline->m_Point.GetAt(2);
	ADPOINT* pPoint4 = (ADPOINT*)pPolyline->m_Point.GetAt(3);
	pPoint2->x -= 0.3;
	pPoint3->x = pPoint2->x;
	pPoint3->y += 0.3;
	pPoint4->y = pPoint3->y;
}

double CHistogramIniFile_EN::GetFootGridColLeft(int i)
{
	double left;
	left=m_GridLeft;
	for(int j=0;j<i-1;j++)
	{
		left+=m_FootGridColWidth[j];
	}
	return left;
}