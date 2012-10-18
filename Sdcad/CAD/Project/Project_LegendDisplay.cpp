#include "stdafx.h"
#include "Project_LegendDisplay.h"
#define LegendWidth 0.8//cm
#include "..\FunctionLib\Function_System.h"

CLegendDisplay::CLegendDisplay(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
//initialize
	m_FrameLeft = m_pGraphics->m_Extmin.x+20;
	m_FrameTop = m_pGraphics->m_Extmax.y-10;
	m_FrameWidth = A3_WIDTH-20-10;
	m_FrameHeight = A3_HEIGHT-10-10;
//set lengend display---------------------------
	m_LegendWidth = 15;
	m_LegendHeight = 10;

	m_LegendRowNum = 6;
	m_LegendSpaceX = 45;
	m_LegendSpaceY = 15;

	m_LegendRectLeft = m_FrameWidth-(m_LegendWidth*m_LegendRowNum+m_LegendSpaceX*m_LegendRowNum);
	m_LegendRectLeft = m_FrameLeft + m_LegendRectLeft/2;
	m_LegendRectTop = m_FrameTop-35;
	m_LegendRectWidth = m_FrameWidth-40*2;
	m_LegendRectHeight = m_FrameHeight-20-10;
	m_MTextWidth = 33;
//-----------------------------------------------
	CreateFrame();
}

CLegendDisplay::~CLegendDisplay()
{

}

void CLegendDisplay::FileImport(LPCTSTR lpFilename)
{
	//m_FileName=lpFilename;
//------------------------------------------------------
	char str2[255];
	GetPrivateProfileString("Í¼Àý","Í¼Ö½Ãû³Æ","",str2,255,lpFilename);

	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text=str2;
	strcpy(pMText->m_Font,"ºÚÌå");
	pMText->m_Height=6;
	//pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2;
	pMText->m_Location.y=m_FrameTop-10;
//------------------------------------------------------
	int maxLen=10000;
	char str[10000];
	GetPrivateProfileString("Í¼Àý","ÆÊÃæÍ¼Í¼Àý","",str,maxLen,lpFilename);

	char* pszTemp = strtok(str, ",");
	int curRow=0,curCol=0;
	while(pszTemp)
	{
		CreateLegend(pszTemp,m_LegendRectLeft+m_LegendWidth*curCol+m_LegendSpaceX*curCol,m_LegendRectTop-m_LegendHeight*curRow-m_LegendSpaceY*curRow);
		curCol++;
		if(curCol==m_LegendRowNum){curCol=0;curRow++;}
		pszTemp=strtok(NULL, ",");
	}

	for (int i=0; i<m_pGraphics->m_Entities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_pGraphics->m_Entities.GetAt(i);
		if (pEntity->GetType() != AD_ENT_HATCH)continue; 
		CADLayer* pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if(pLayer==NULL)
		{
			m_pGraphics->m_Entities.RemoveAt(i);
			continue;
		}
		if (strcmp(pLayer->m_Name,"0")!=0)continue;
		if (!CreateHatch((CADHatch*)pEntity))
		{
			m_pGraphics->m_Entities.RemoveAt(i);
			continue;		
		}
	}
	GetPrivateProfileString("Í¼Àý","Æ½ÃæÍ¼Í¼Àý","",str,maxLen,lpFilename);
	pszTemp = strtok(str, ",");
	while(pszTemp)
	{
		CreateLegend_Layout(pszTemp,m_LegendRectLeft+m_LegendWidth*curCol+m_LegendSpaceX*curCol,m_LegendRectTop-m_LegendHeight*curRow-m_LegendSpaceY*curRow);
		curCol++;
		if(curCol==m_LegendRowNum){curCol=0;curRow++;}
		pszTemp=strtok(NULL, ",");
	}
	CreateChartFooter(lpFilename);
}

void CLegendDisplay::CreateFrame()
{
//------------------------------------------------------
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=8;

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

void CLegendDisplay::CreateLegend(const char* legendName,double legendLeft,double legendTop)
{
//check special legend---------------------
	short curLayerIndex = m_pLayerGroup->indexOf("0");

	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	pPolyline->m_nLayer = curLayerIndex;
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=1;

	pPoint=new ADPOINT();
	pPoint->x = legendLeft;
	pPoint->y = legendTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = legendLeft+m_LegendWidth;
	pPoint->y = legendTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = legendLeft+m_LegendWidth;
	pPoint->y = legendTop-m_LegendHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = legendLeft;
	pPoint->y = legendTop-m_LegendHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	CADHatch* pHatch=new CADHatch();
	m_pGraphics->m_Entities.Add((CObject*)pHatch);
	pHatch->m_Scale = 10.0;
	pHatch->m_nLayer = curLayerIndex;
	pHatch->m_pPolyline=pPolyline;
	strcpy(pHatch->m_Name,legendName);
//check special legend---------------------
	short SpecialLegendCount = 5;
	char  SpecialLegendChar[] = {'f','x','z','c','l'};
	int legendCharIndex = -1;
	if (strcmp(legendName,"·ÛÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"·ÛÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"·ÛÉ°¼ÐÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	//updated on 20070207
	else if (strcmp(legendName,"·ÛÉ°¼Ð·ÛÍÁ")==0)
	{
		strcpy(pHatch->m_Name,"º¬Õ³ÐÔÍÁ·ÛÉ°");
		legendCharIndex = 0;	
	}
	//added on 20070207
	else if (strcmp(legendName,"·ÛÉ°¼ÐÑÇÉ°ÍÁ")==0)
	{
		strcpy(pHatch->m_Name,"º¬Õ³ÐÔÍÁ·ÛÉ°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"Ï¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"ÖÐÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"ÖÐÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"ÖÐ´ÖÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"´ÖÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"ÀùÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"·ÛÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"Ï¸É°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"ÖÐÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"´ÖÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"º¬Àù·ÛÉ°ÑÒ")==0)
	{
		legendCharIndex = 0;	
	}
	/*else if (strcmp(legendName,"·ÛÉ°¼Ð·ÛÍÁ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÖÊ·ÛÍÁ");
		legendCharIndex = 0;	
	}*/
	else if (strcmp(legendName,"º¬ÀùÉ°·ÛÖÊÕ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬ÀùÉ°Õ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬ÀùÉ°ÓÙÄàÖÊ·ÛÖÊÕ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁ·ÛÉ³")==0)
	{
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÏ¸É³")==0)
	{
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÖÐÉ³")==0)
	{
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁ´ÖÉ³")==0)
	{
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÀùÉ³")==0)
	{
		legendCharIndex = 4;	
	}
//-----------------------------------------

	//CreateHatch(legendName,pPolyline,curLayerIndex);
	//special legend--------------------------------
	if(legendCharIndex>-1)
	{
		CADMText* pMText;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
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
//------------------------------------------------------
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Text=legendName;
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Width=m_MTextWidth;
	pMText->m_Location.x=legendLeft+m_LegendWidth+6;
	pMText->m_Location.y=legendTop-m_LegendHeight/2;
	pMText->m_isWarp = true;
}

void CLegendDisplay::CreateLegend_Layout(const char* legendName,double legendLeft,double legendTop)
{
	short curLayerIndex = (short)m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME);//
	CADLayer* pLayer = m_pLayerGroup->GetLayer(curLayerIndex);
	if (pLayer != NULL) pLayer->m_nColor = 7;
	if (curLayerIndex == -1)curLayerIndex = 0;
	CADInsert* pInsert=new CADInsert();
	m_pGraphics->m_Entities.Add((CObject*)pInsert);
	pInsert->m_nLayer=curLayerIndex;
	pInsert->m_xScale = 3 * 0.5;
	pInsert->m_yScale = 3 * 0.5;
	strcpy(pInsert->m_Name,legendName);
	pInsert->pt.x = legendLeft+m_LegendWidth/2;
	pInsert->pt.y = legendTop-m_LegendHeight/2;
//------------------------------------------------------
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_MIDDLELEFT;
	if (strcmp(legendName,"µØ²ã½çÏßÍÆ²âµØ²ã½çÏß")==0)
		legendName = "µØ²ã½çÏß\r\nÍÆ²âµØ²ã½çÏß";
	
	pMText->m_Text = legendName;
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Width=m_MTextWidth;
	pMText->m_Location.x=legendLeft+m_LegendWidth+5.5;
	pMText->m_Location.y=legendTop-m_LegendHeight/2;
	pMText->m_isWarp = true;	
}

void CLegendDisplay::CreateChartFooter(LPCTSTR lpFilename)
{
	double GridColWidth[12];//mm
	GridColWidth[0]=24;
	GridColWidth[1]=91;
	GridColWidth[2]=17;
	GridColWidth[3]=24;
	GridColWidth[4]=17;
	GridColWidth[5]=24;
	GridColWidth[6]=17;
	GridColWidth[7]=24;
	GridColWidth[8]=17;
	GridColWidth[9]=14;
	GridColWidth[10]=30;
	GridColWidth[11]=44;

	ADPOINT* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;

	double GridLeft,GridTop,GridHeight,GridRight,GridBottom;
	GridLeft=m_FrameLeft+1;
	GridTop=m_FrameTop-m_FrameHeight+2+7;
	GridHeight=7;//7
	GridRight=m_FrameLeft+m_FrameWidth-1;
	GridBottom=GridTop-GridHeight;

	double fontTop=GridTop-3.5;
	int curLayerIndex = m_pLayerGroup->indexOf("0");
	//create frame
	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=curLayerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	pPoint=new ADPOINT();
	pPoint->x = GridLeft;
	pPoint->y = GridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridRight;
	pPoint->y = GridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridRight;
	pPoint->y = GridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridLeft;
	pPoint->y = GridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);

	//create columns
	int curWidth=0;
	for(int i=0;i<11;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;

		curWidth+=GridColWidth[i];

		pLine->pt1.x=GridLeft+curWidth;
		pLine->pt1.y=GridTop;
		pLine->pt2.x=GridLeft+curWidth;
		pLine->pt2.y=GridTop-GridHeight;
	}
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	char str[255];
	::GetPrivateProfileString("Í¼Àý","¹¤³Ì±àºÅ","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GridLeft+GridColWidth[0]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("Í¼Àý","¹¤³ÌÃû³Æ","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=GridLeft+GridColWidth[0]+3;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="±à ÖÆ";
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="¸´ ºË";
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Éó ºË";
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Í¼ ±í ºÅ";
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="µÚ   ÕÅ ¹²   ÕÅ";
	strcpy(pMText->m_Font,"¿¬Ìå_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]+GridColWidth[9]+GridColWidth[10]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=Maker;
	strcpy(pMText->m_Font,"ºÚÌå");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]+GridColWidth[9]+GridColWidth[10];
	pMText->m_Location.x += GridColWidth[11]/2;
	pMText->m_Location.y=fontTop;
}


bool CLegendDisplay::CreateHatch(CADHatch* pHatch)
{
	char LegendFile[255];
	GetAppDir(LegendFile);
	strcat(LegendFile,"ACADISO.PAT");

	FILE* fp;
	fp=fopen(LegendFile,"r");
	if(fp==NULL)return false;

	char str[1000];

	if(strcmp(pHatch->m_Name,"")==0)return false;

	while(! feof(fp) && ! ferror(fp))
	{
		fscanf(fp,"%s\n",str);
		char* pdest;
		pdest=strstr(str,",");
		if(pdest != NULL)
		{
			char* strLegend=pdest+1;
			if(strcmp(strLegend,pHatch->m_Name)==0)
			{
				fscanf(fp,"%s\n",str);
				CreateHatchLine(str,pHatch);
				fscanf(fp,"%s\n",str);
				while(str[0]!='*' && ! feof(fp) && ! ferror(fp))
				{
					CreateHatchLine(str,pHatch);
					fscanf(fp,"%s\n",str);
				}
				return true;
			}
		}
		else
			return false;
	}
}

void CLegendDisplay::CreateHatchLine(char* hatchLineStr,CADHatch* pHatch)
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

void CLegendDisplay::AdjustLegend(LPCTSTR lpFilename)
{
	CString strTmp;
	int index;
	char str2[255];
	GetPrivateProfileString("Í¼Àý","ÍÁ²ã±àºÅ","",str2,255,lpFilename);
	strTmp = str2;

	CString strLayerNo;
	CString strSubLayerNo;

	int j = strTmp.Find("^");
	if (j>0)
	{
		strLayerNo = strTmp.Left(j);
		strSubLayerNo = strTmp.Right(strTmp.GetLength()-j-1);
	}
	else
	{
		strLayerNo = strTmp;
		strSubLayerNo = "";
	}

	if (strLayerNo !="")
	{
		index = -1;
		for(int i=0;i<m_pGraphics->m_Blocks.GetSize();i++)
		{
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(i);
			if(_stricmp("ÍÁ²ã±àºÅ",pBlock->m_Name)==0)
				index = i;
		}
		if (index>-1)
		{
			int k = 1;
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(index);
			for(int j=0;j<pBlock->m_Entities.GetSize();j++)
			{
				CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
				if (pEntity->GetType()==AD_ENT_MTEXT)
				{
					CADMText* pText = (CADMText*)pEntity;
					if (k==1)
						pText->m_Text = strLayerNo;
					else
						pText->m_Text = strSubLayerNo;
					k++;
				}
			}			
		}
	}
///////
	GetPrivateProfileString("Í¼Àý","±ê×¼¹áÈë","",str2,255,lpFilename);
	strTmp = str2;
	
	if (strTmp !="")
	{
		index = -1;
		for(int i=0;i<m_pGraphics->m_Blocks.GetSize();i++)
		{
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(i);
			if(_stricmp("±ê×¼¹áÈë",pBlock->m_Name)==0)
				index = i;
		}
		if (index>-1)
		{
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(index);
			for(int j=0;j<pBlock->m_Entities.GetSize();j++)
			{
				CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
				if (pEntity->GetType()==AD_ENT_MTEXT)
				{//::AfxMessageBox(strTmp);
					CADMText* pText = (CADMText*)pEntity;
					//if (pText->m_Text=="8")
						pText->m_Text = strTmp;
				}
			}			
		}
	}
/////////
	GetPrivateProfileString("Í¼Àý","¿×ºÅ±ê¸ß","",str2,255,lpFilename);
	strTmp = str2;

	CString strUp;
	CString strDown;

	j = strTmp.Find("^");
	if (j>0)
	{
		strUp = strTmp.Left(j);
		strDown = strTmp.Right(strTmp.GetLength()-j-1);
	}
	else
	{
		strUp = strTmp;
		strDown = "";
	}

	if (strUp !="")
	{
		index = -1;
		for(int i=0;i<m_pGraphics->m_Blocks.GetSize();i++)
		{
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(i);
			if(_stricmp("¿×ºÅ±ê¸ß",pBlock->m_Name)==0)
				index = i;
		}
		if (index>-1)
		{
			int k = 1;
			CADBlock* pBlock=(CADBlock*)m_pGraphics->m_Blocks.GetAt(index);
			for(int j=0;j<pBlock->m_Entities.GetSize();j++)
			{
				CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
				if (pEntity->GetType()==AD_ENT_MTEXT)
				{
					CADMText* pText = (CADMText*)pEntity;
					if (k==1)
						pText->m_Text = "";
					else if (k==2)
					{
						pText->m_Text = strUp;
						pText->m_Location.x -= 1.5;
					}
					else if (k==3)
						pText->m_Text = strDown;
					k++;
				}
			}			
		}
	}
}