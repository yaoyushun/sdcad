#include "stdafx.h"
#include "CrossBoardIniFile.h"
#define LegendWidth 0.8//cm
#include "..\FunctionLib\Function_System.h"

#define ENFONTNAME "Arial"

CCrossBoardIniFile::CCrossBoardIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
	m_FrameWidth = A3_WIDTH - 50;
	m_FrameHeight = A3_HEIGHT - 40;
	m_FrameLeft = m_pGraphics->m_Extmin.x + (A3_WIDTH - m_FrameWidth)/2;
	m_FrameTop = m_pGraphics->m_Extmax.y - (A3_HEIGHT - m_FrameHeight)/2;
	m_nPaperCount = 0;
}

CCrossBoardIniFile::~CCrossBoardIniFile()
{

}

void CCrossBoardIniFile::FileImport(LPCTSTR lpFilename)
{
	m_HoleNum=::GetPrivateProfileInt("钻孔","个数",0,lpFilename);
	if(m_HoleNum<=0)return;
	CreateChartFrame();
	CreateChartHeader(lpFilename);
	CreateChartFooter(lpFilename);
	double spaceX = 90;
	double spaceY = 110;
	m_nPaperCount = m_HoleNum / 8 + 1;
	//short nPapers = m_HoleNum / 8 + 1;
	short curHoleID = 0;
	for (int i=0;i<m_nPaperCount;i++)
	{
		short nHoles;
		if (m_nPaperCount-i-1 > 0)nHoles = 8;
		else nHoles = m_HoleNum - i * 8;
		//short nRows = m_HoleNum - 
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
		int curLayerIndex = m_pLayerGroup->indexOf(layerNum);;
		for (int j=0;j<nHoles;j++)
		{
			curHoleID++;
			if (j>3)
			{
				CreateComment(m_FrameLeft+30+spaceX*(j-4),m_FrameTop-110-spaceY,curLayerIndex,curHoleID,lpFilename);
				CreateAxis(m_FrameLeft+30+spaceX*(j-4),m_FrameTop-110-spaceY,curLayerIndex);
			}
			else
			{
				CreateComment(m_FrameLeft+30+spaceX*j,m_FrameTop-110,curLayerIndex,curHoleID,lpFilename);
				CreateAxis(m_FrameLeft+30+spaceX*j,m_FrameTop-110,curLayerIndex);
			}
		}
	}
}

void CCrossBoardIniFile::CreateChartFrame()
{
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=10;

	pPoint=new ADPOINT();
	pPoint->x =m_FrameLeft;
	pPoint->y = m_FrameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x =m_FrameLeft+m_FrameWidth;
	pPoint->y = m_FrameTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x =m_FrameLeft+m_FrameWidth;
	pPoint->y = m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x =m_FrameLeft;
	pPoint->y = m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
}

void CCrossBoardIniFile::CreateChartHeader(LPCTSTR lpFilename)
{
	//生成图纸名称
	char str[255];
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	GetPrivateProfileString("图纸信息","图纸名称","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=7;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2;
	pMText->m_Location.y=m_FrameTop-6;	
}

void CCrossBoardIniFile::CreateChartFooter(LPCTSTR lpFilename)
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
	GridHeight=7;//mm
	GridTop=m_FrameTop-m_FrameHeight+2+GridHeight;
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
	::GetPrivateProfileString("图纸信息","工程编号","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GridLeft+GridColWidth[0]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("图纸信息","工程名称","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=GridLeft+GridColWidth[0]+3;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Compiled by";//"Prepared"//"编 制";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Checked by";//"Reviewed"//"复 核";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Approved by";//"Approved"//"审 核";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Chart No";//"图 表 号";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]/2;
	pMText->m_Location.y=fontTop;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Page           of           ";//"第   张 共   张";
	strcpy(pMText->m_Font,ENFONTNAME);
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
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]+GridColWidth[9]+GridColWidth[10];
	pMText->m_Location.x += GridColWidth[11]/2;
	pMText->m_Location.y=fontTop;
}

void CCrossBoardIniFile::CreateAxis(double x0,double y0,int curLayerIndex)
{
	ADPOINT* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;

	double length = 40;//mm
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=x0;
	pLine->pt1.y=y0;
	pLine->pt2.x=x0;
	pLine->pt2.y=y0+length;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=x0;
	pLine->pt1.y=y0;
	pLine->pt2.x=x0+length;
	pLine->pt2.y=y0;

	//create y axis
	int curY=0;
	for(int i=0;i<4;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		curY+=20;
		pLine->pt1.x = x0;
		pLine->pt1.y = y0 + length*curY/80;
		pLine->pt2.x = pLine->pt1.x + 1;
		pLine->pt2.y = pLine->pt1.y;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text.Format("%d",curY);
		strcpy(pMText->m_Font,ENFONTNAME);
		pMText->m_Height=2.5;
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
		pMText->m_Location.x = x0 - 0.5;
		pMText->m_Location.y = y0 + length*curY/80;
	}
	//create x axis
	int curX=0;
	for(i=0;i<4;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		curX+=10;
		pLine->pt1.x=x0 + length*curX/40;
		pLine->pt1.y=y0;
		pLine->pt2.x=pLine->pt1.x;
		pLine->pt2.y=pLine->pt1.y + 1;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text.Format("%d",curX);
		strcpy(pMText->m_Font,ENFONTNAME);
		pMText->m_Height=2.5;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = x0 + length*curX/40;
		pMText->m_Location.y = y0 - 0.5;
	}

	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Cu (kPa)";
	pMText->m_Height=2.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x = x0 - 8;
	pMText->m_Location.y = y0 + length/2;
	pMText->m_ptDir.x = 0;
	pMText->m_ptDir.y = -1;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Roate Degree(°)";//"转动角度(度)";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x = x0 + length/2;
	pMText->m_Location.y = y0 - 6;
}

void CCrossBoardIniFile::CreateComment(double x0,double y0,int curLayerIndex,short nHoleID,LPCTSTR lpFilename)
{
	char num[4];
	char keyName[10];
	itoa(nHoleID,num,10);
	strcpy(keyName,"钻孔");
	strcat(keyName,num);
	///////////////////////////////////////////////////////////////////
	char str[255];

	CADMText* pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Drill No:";//"钻孔编号:";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0;
	pMText->m_Location.y = y0 + 80;

	GetPrivateProfileString(keyName,"编号","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 16;
	pMText->m_Location.y = y0 + 80;
//----------------------------------------
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Test Depth:";//"测试深度:";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 14 + 20;//x0 + 24 + 20;
	pMText->m_Location.y = y0 + 80;

	GetPrivateProfileString(keyName,"测试深度","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 32 +20;// x0 + 42 +20;
	pMText->m_Location.y = y0 + 80;
//----------------------------------------
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Cu= ";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0;
	pMText->m_Location.y = y0 + 75;

	GetPrivateProfileString(keyName,"Cu","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 7;
	pMText->m_Location.y = y0 + 75;

//<--added on 2007/6/25

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Cu'= ";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 14 + 20;
	pMText->m_Location.y = y0 + 75;

	GetPrivateProfileString(keyName,"Cu'","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 14 + 20 + 9;
	pMText->m_Location.y = y0 + 75;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "St= ";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0;
	pMText->m_Location.y = y0 + 70;

	GetPrivateProfileString(keyName,"St","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 7;
	pMText->m_Location.y = y0 + 70;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = "Stratum= ";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0;
	pMText->m_Location.y = y0 + 65;

	GetPrivateProfileString(keyName,"土层编号及名称","",str,255,lpFilename);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text = str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = x0 + 14;
	pMText->m_Location.y = y0 + 65;
//-->

	//create polyline
	double length = 40;//mm

	//updated on 2005/8/23
	//<--
	int LineCount = ::GetPrivateProfileInt(keyName,"LineCount",0,lpFilename);
	for (int i=0;i<LineCount;i++)
	{
		CString section;
		section.Format("所有角度%d",i+1);
		GetPrivateProfileString(keyName,section,"",str,255,lpFilename);
		char* pszTemp = strtok(str, ",");
		if(pszTemp==NULL)return;
		CADPolyline* pPolyline=new CADPolyline();//
		m_pGraphics->m_Entities.Add((CObject*)pPolyline);
		pPolyline->m_nLayer=curLayerIndex;

		ADPOINT* pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->x = x0;
		pPoint->y = y0;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->x = x0 + length*atof(pszTemp)/40;

		while(pszTemp)
		{
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)break;
			pPoint=new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);
			pPoint->x = x0 + length*atof(pszTemp)/40;
		}

		section.Format("所有强度%d",i+1);
		GetPrivateProfileString(keyName,section,"",str,255,lpFilename);
		pszTemp = strtok(str, ",");

		if(pszTemp==NULL)return;
		int j=1;
		int pointCount=pPolyline->m_Point.GetSize();

		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		pPoint->y = y0 + length*atof(pszTemp)/80;

		while(pszTemp)
		{
			j++;
			if((j+1)>pointCount)break;
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)break;
			pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);	
			pPoint->y = y0 + length*atof(pszTemp)/80;
		}
	}
	//-->
/*	GetPrivateProfileString(keyName,"所有角度","",str,255,lpFilename);
	char* pszTemp = strtok(str, ",");
	if(pszTemp==NULL)return;
	CADPolyline* pPolyline=new CADPolyline();//
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=curLayerIndex;

	ADPOINT* pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint->x = x0;
	pPoint->y = y0;

	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint->x = x0 + length*atof(pszTemp)/40;

	while(pszTemp)
	{
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->x = x0 + length*atof(pszTemp)/40;
	}

	GetPrivateProfileString(keyName,"所有强度","",str,255,lpFilename);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	int j=1;
	int pointCount=pPolyline->m_Point.GetSize();

	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
	pPoint->y = y0 + length*atof(pszTemp)/80;

	while(pszTemp)
	{
		j++;
		if((j+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);	
		pPoint->y = y0 + length*atof(pszTemp)/80;
	}*/
}