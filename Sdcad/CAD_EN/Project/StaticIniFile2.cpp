#include "stdafx.h"
#include "StaticIniFile2.h"
#define LegendWidth 0.8//cm
#include "..\FunctionLib\Function_System.h"

#define ENFONTNAME "Arial"

CStaticIniFile2::CStaticIniFile2(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_Deep=0;
	m_FontHeight=3.5;
	m_Row1Height=25;
	m_LeftMargin=10;
	m_TopMargin=64-1-30;
	m_GridTop=-100+30;

	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;

	m_pGraphics->m_Extmin.x=0;
	m_pGraphics->m_Extmax.y=0;
	m_PaperLeft=0;
	m_PaperTop=0;

	m_pGraphics->m_Extmax.x=m_pGraphics->m_Extmin.x+A3_HEIGHT;
	m_pGraphics->m_Extmin.y=m_pGraphics->m_Extmax.y-A3_WIDTH;

	m_pGraphics->m_Bound.left=m_pGraphics->m_Extmin.x*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.top=-m_pGraphics->m_Extmax.y*m_pGraphics->m_mYPixel;
	m_pGraphics->m_Bound.right=m_pGraphics->m_Bound.left+A3_HEIGHT*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.bottom=m_pGraphics->m_Bound.top+A3_WIDTH*m_pGraphics->m_mYPixel;

	m_pGraphics->m_Unit=UNIT_MILLIMETER;
	m_pGraphics->m_PaperLeft=m_pGraphics->m_Extmin.x;
	m_pGraphics->m_PaperTop=m_pGraphics->m_Extmax.y;

	//updated on 2005/8/23
	//m_MaxCol = 12;
	m_MaxCol = 10;

	m_GridColWidth[0]=7;
	m_GridColWidth[1]=23;
	m_GridColWidth[2]=17;
	m_GridColWidth[3]=7;
	m_GridColWidth[4]=14;
	m_GridColWidth[5]=10;
	m_GridColWidth[6]=10;
	m_GridColWidth[7]=10;
	m_GridColWidth[8]=7;
	//m_GridColWidth[9]=81;
	m_psLineCount = 12;
	m_GridColWidth[9]=m_psLineCount*10+1;
}

CStaticIniFile2::~CStaticIniFile2()
{

}

void CStaticIniFile2::FileImport(LPCTSTR lpFilename)
{
	m_FileName=lpFilename;
	char str[100];

	m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);

	m_vScale=::GetPrivateProfileInt("比例尺","Y",0,lpFilename);
	if(m_vScale==0)return;

//	short holeNum=::GetPrivateProfileInt("钻孔","个数",0,lpFilename);
//	if (holeNum<=0 || holeNum >2)return;
	bool bFs = false;
	double titleLeft = m_PaperLeft+110;
	double spaceX = 200;
//	if (holeNum == 1)
//	{
		bFs = true;
		titleLeft = m_PaperLeft + 148;
		m_pGraphics->m_PaperOrient = VERTICAL;
/*	}
	else
	{
		bFs = false;
		titleLeft = m_PaperLeft + 110;
		m_pGraphics->m_PaperOrient = HORIZONTAL;
	}*/

	if (!bFs) m_MaxCol = 11;
	CreateHeader(m_PaperLeft+m_LeftMargin,m_PaperTop-m_TopMargin,titleLeft,"钻孔");
	GetPrivateProfileString("钻孔","孔深","",str,255,lpFilename);
	double HoleDeep=atof(str);
	m_Deep=(int)HoleDeep;
	//<--updated on 2006/04/13
	//因为画面上的最低层的高度超出了设置文件中孔深
	/*if(m_Deep%2==0)
		m_Deep+=2;
	else
		m_Deep+=1;*/
	if(m_Deep%2==0)
	{
		if ((HoleDeep-m_Deep)>0)
			m_Deep+=2;
	}
	else
		m_Deep+=1;
	//m_GridHeight=m_Row1Height+(double)m_Deep/m_vScale*1000+5;
	m_GridHeight=m_Row1Height+(double)m_Deep/m_vScale*1000;
	//-->

	CreateChartFrame(m_PaperLeft+m_LeftMargin-2,m_PaperTop-m_TopMargin+10,277+4,m_GridHeight+59);
	CreateGrid(m_PaperLeft+m_LeftMargin,m_GridTop,m_GridHeight,bFs,"钻孔");
	Create3Curves(m_PaperLeft+m_LeftMargin,m_GridTop,m_GridHeight,bFs,"钻孔");
	CreateFoot(m_PaperLeft+m_LeftMargin,m_GridTop - m_GridHeight - 2);

/*	if (holeNum == 2)
	{
		CreateHeader(m_PaperLeft+m_LeftMargin+spaceX,m_PaperTop-m_TopMargin,titleLeft+spaceX,"钻孔2");
		GetPrivateProfileString("钻孔2","孔深","",str,255,lpFilename);
		double HoleDeep=atof(str);
		m_Deep=(int)HoleDeep;
		if(m_Deep%2==0)
			m_Deep+=2;
		else
			m_Deep+=1;
		m_GridHeight=m_Row1Height+(double)m_Deep/m_vScale*1000+5;
		CreateGrid(m_PaperLeft+m_LeftMargin+spaceX,m_GridTop,m_GridHeight,bFs,"钻孔2");
		CreateFoot(m_PaperLeft+m_LeftMargin+spaceX,m_GridTop-m_GridHeight);	
	}*/
}

void CStaticIniFile2::CreateHeader(double left,double top,double titleLeft,const char* keyName)
{
	double titleFontHeight=8;
	double fontHeight=3.5;
	double fontSpace=3;
	double titleFontSpace=4.5;
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="The Table of CPT Results";//"静力触探成果表";
	pMText->m_Height=titleFontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x = titleLeft;
	pMText->m_Location.y = top;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Project Name:";//"工 程 名 称 :";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +2;
	pMText->m_Location.y = top - titleFontHeight-titleFontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	char str[255];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("图纸信息","工程名称","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +26;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace;

	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = m_pLayerGroup->indexOf("0");
	pMText->m_Text = "Bore         No:";
	pMText->m_Height = fontHeight;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +2;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString(keyName,"编号","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +26;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Started  Date:";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +2;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString(keyName,"开孔日期","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +26;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Broehole Elevation:";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +2;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString(keyName,"孔口标高","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left + 26 + 5;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace-fontHeight-fontSpace;
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Bore Position:";//"Boring Position:";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +60;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Finished   Date:";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +60;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString(keyName,"终孔日期","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +84.5;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace;


	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Groundwater level(Depth/Elevation):";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +60;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString(keyName,"地下水位","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +109;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace-fontHeight-fontSpace-fontHeight-fontSpace;

	/*pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="勘 察 编 号 :";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +116;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	GetPrivateProfileString("图纸信息","工程编号","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=fontHeight;
	//pMText->m_Width=3;
	pMText->m_Location.x = left +141;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace;*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Coordination:";
	pMText->m_Height=fontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = left +116;
	pMText->m_Location.y = top -titleFontHeight-titleFontSpace-fontHeight-fontSpace;
	strcpy(pMText->m_Font,ENFONTNAME);
}

void CStaticIniFile2::CreateFoot(double left,double top)
{
/*	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="编 制 :";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+6;
	pMText->m_Location.y=top-1;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="审 核 :";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+47;
	pMText->m_Location.y=top-1;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="图 号 :";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+105;
	pMText->m_Location.y=top-1;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text=Maker;
	pMText->m_Height=m_FontHeight+0.5;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x=left+140;
	pMText->m_Location.y=top-1;
	strcpy(pMText->m_Font,"黑体");*/

	const ColCount = 11;	
	double GridColWidth[11];//mm

	short j = 0;
	GridColWidth[j++]=30;
	//GridColWidth[j++]=91;
	GridColWidth[j++]=17;
	GridColWidth[j++]=24;
	GridColWidth[j++]=17;
	GridColWidth[j++]=24;
	GridColWidth[j++]=17;
	GridColWidth[j++]=24;
	GridColWidth[j++]=17;
	GridColWidth[j++]=14;
	GridColWidth[j++]=30;
	GridColWidth[j++]=44;

	ADPOINT* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;

	float gridHeight=7;//7
	float gridWidth=277;//7

	double fontTop = top-3.5;
	int curLayerIndex = m_pLayerGroup->indexOf("0");
	//create frame
	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=curLayerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left + gridWidth;
	pPoint->y = top;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left + gridWidth;
	pPoint->y = top - gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top - gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	//create columns
	int curWidth=0;
	for(int i=0;i<ColCount-1;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;

		curWidth+=GridColWidth[i];

		pLine->pt1.x = left+curWidth;
		pLine->pt1.y = top;
		pLine->pt2.x = left+curWidth;
		pLine->pt2.y = top - gridHeight;
	}
	
	short curColIndex = 0;
	double curColX = left;
	char str[255];

	//工程编号
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("图纸信息","工程编号","",str,255,m_FileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.7;
	pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = curColX + GridColWidth[curColIndex]/2;
	pMText->m_Location.y = fontTop;

	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Compiled by";//"Prepared"//"编 制";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2]/2;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Checked by";//"Reviewed"//"复 核";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Approved by";//"Approved"//"审 核";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Chart No";//"图 表 号";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="Page           of           ";//"第   张 共   张";
	strcpy(pMText->m_Font,ENFONTNAME);
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;
}

void CStaticIniFile2::CreateGrid(double GridLeft,double GridTop,double GridHeight,bool bFs,const char* keyName)
{
	double GridWidth = 0.0;
	//if (!bFs) maxCol = 11;
	for (int i=0; i<m_MaxCol; i++)
	{
		GridWidth += m_GridColWidth[i];
	}

	CADPolyline* pPolyline=new CADPolyline();
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	//pPolyline->m_nLineWidth = 3;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = GridLeft;
	pPoint->y = GridTop;

	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridLeft+GridWidth;
	pPoint->y = GridTop;

	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridLeft+GridWidth;
	pPoint->y = GridTop-GridHeight;

	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = GridLeft;
	pPoint->y = GridTop-GridHeight;

	pPolyline->m_Point.Add((CObject*)pPoint);

	CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");
	pLine->pt1.x=GridLeft;
	pLine->pt1.y=GridTop-m_Row1Height;
	pLine->pt2.x=GridLeft+GridWidth;
	pLine->pt2.y=GridTop-m_Row1Height;
	//create columns
	int curWidth=0;
	//for(i=0;i<11;i++)
	for(i=0;i<m_MaxCol-1;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");

		curWidth+=m_GridColWidth[i];

		pLine->pt1.x=GridLeft+curWidth;
		pLine->pt1.y=GridTop;
		pLine->pt2.x=GridLeft+curWidth;
		pLine->pt2.y=GridTop-GridHeight;
		
		if(i==3)
		{
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=m_pLayerGroup->indexOf("0");
			pLine->pt1.x=GridLeft+curWidth+6;
			pLine->pt1.y=GridTop-m_Row1Height;
			pLine->pt2.x=GridLeft+curWidth+6;
			pLine->pt2.y=GridTop-GridHeight;
			
			pLine=new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLayer=m_pLayerGroup->indexOf("0");
			pLine->pt1.x=GridLeft+curWidth+6+2;
			pLine->pt1.y=GridTop-m_Row1Height;
			pLine->pt2.x=GridLeft+curWidth+6+2;
			pLine->pt2.y=GridTop-GridHeight;
		}
	}

//成\n因\n符\n号\n或\n层\n号***********************************************//
	int layerIndex = m_pLayerGroup->indexOf("0");
	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Strata No.";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]/3;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);
//
/*	CADMText* pMText;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="成\n因\n符\n号\n或\n层\n号";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]/2;
	pMText->m_Location.y=GridTop-0.5;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="Name of\n\nStrata";//"岩 土 名 称";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]/2;
	pMText->m_Location.y=GridTop-10;
	strcpy(pMText->m_Font,ENFONTNAME);

/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="层  深\n\n\n\n(标  高)";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]/2;
	pMText->m_Location.y=GridTop-4;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
//层  深\n\n\n\n(标  高)**********************************************//
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Depth of Strata";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]/6;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Bottom";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]/5*2;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="(Elevation)";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]/3*2;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);
//
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="层\n\n\n\n厚";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3]/2;
	pMText->m_Location.y=GridTop-4;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
//层\n\n\n\n厚**********************************************//
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Thickness";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3]/8;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="of Strata";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3]/2;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);
//

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	if(m_vScale>999)
		pMText->m_Text.Format("Columnar\n\n\nScale\n1:%d",m_vScale);
	else
		pMText->m_Text.Format("Columnar\n\n\nScale\n1: %d",m_vScale);
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]/2;
	pMText->m_Location.y=GridTop-4;
	strcpy(pMText->m_Font,ENFONTNAME);
//============================================================================
//============================================================================
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="锥尖\n阻力\n平均\n值";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]/2;
	pMText->m_Location.y=GridTop-2;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
	double centerX = 0;
	centerX=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	centerX+=m_GridColWidth[4]+m_GridColWidth[5]/2;
	
/*	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");

	pLine->pt1.x=centerX-2;
	pLine->pt1.y=GridTop-5.5;//17.5;
	pLine->pt2.x=centerX+2;
	pLine->pt2.y=GridTop-5.5;//17.5;
*/
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="ps";//"qc";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=centerX;
	pMText->m_Location.y=GridTop-7.5;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="MPa";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=centerX;
	pMText->m_Location.y=GridTop-22;
	strcpy(pMText->m_Font,ENFONTNAME);
//============================================================================
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="侧壁\n摩阻\n力平\n均值";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]/2;
	pMText->m_Location.y=GridTop-2;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
	centerX=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	centerX+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]/2;

/*	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");

	pLine->pt1.x=centerX-2;
	pLine->pt1.y=GridTop-5.5;//17.5;
	pLine->pt2.x=centerX+2;
	pLine->pt2.y=GridTop-5.5;//17.5;
*/
	if (m_ProjectType==1)
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text="[σ0]";//"fs";
		pMText->m_Text="[fao]";//αο
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-7.5;
		strcpy(pMText->m_Font,"GungsuhChe");

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="kPa";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-22;
		strcpy(pMText->m_Font,ENFONTNAME);
	}
	else
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text="[σ0]";//"fs";
		pMText->m_Text="fak";//αο
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-7.5;
		strcpy(pMText->m_Font,"GungsuhChe");

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="kPa";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-22;
		strcpy(pMText->m_Font,ENFONTNAME);		
	}
//============================================================================
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="容许\n\n承载\n\n力";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]+m_GridColWidth[7]/2;
	pMText->m_Location.y=GridTop-2;
	strcpy(pMText->m_Font,ENFONTNAME);
*/
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="[σ0]\nkPa";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]+m_GridColWidth[7]/2;
	pMText->m_Location.y=GridTop-19.5;
	strcpy(pMText->m_Font,ENFONTNAME);*/
	centerX=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	centerX+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]+m_GridColWidth[7]/2;

	if (m_ProjectType==1)
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text="[τi]";//"ｆk";
		pMText->m_Text="[q ]";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-7.5;
		strcpy(pMText->m_Font,"GungsuhChe");

		//<--added on 20080417
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="ik";
		pMText->m_Height=m_FontHeight-1.0;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
		pMText->m_Location.x = centerX + 1.8;
		pMText->m_Location.y=GridTop-7.5-1.4;
		strcpy(pMText->m_Font,ENFONTNAME);
		//-->
	}
	else
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text="[τi]";//"ｆk";
		pMText->m_Text="q";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=centerX;
		pMText->m_Location.y=GridTop-7.5;
		strcpy(pMText->m_Font,"GungsuhChe");

		//<--added on 20080417
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="sik";
		pMText->m_Height=m_FontHeight-1.0;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = centerX + 1.2;
		pMText->m_Location.y=GridTop-7.5-1.4;
		strcpy(pMText->m_Font,ENFONTNAME);
		//-->	
	}

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="kPa";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=centerX;
	pMText->m_Location.y=GridTop-22;
	strcpy(pMText->m_Font,ENFONTNAME);
//============================================================================
/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="深\n\n\n\n度";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6];
	pMText->m_Location.x+=m_GridColWidth[7]+m_GridColWidth[8]+m_GridColWidth[9]/2;
	pMText->m_Location.y=GridTop-4;
	strcpy(pMText->m_Font,ENFONTNAME);*/
//深\n\n\n\n度***********************************************//
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=layerIndex;
	pMText->m_Text="Depth";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6]+m_GridColWidth[7];
	pMText->m_Location.x+=m_GridColWidth[8]/4;
	pMText->m_Location.y=GridTop-m_Row1Height/2;
	pMText->m_ptDir.y = 1.0;
	pMText->m_ptDir.x = 0;
	strcpy(pMText->m_Font,ENFONTNAME);
//============================================================================
	double CurveLeft = GridLeft;
	double CurveTop = GridTop - m_Row1Height;
	for(i=0;i<8;i++)
	{
		CurveLeft += m_GridColWidth[i];	
	}

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");
	pLine->pt1.x = CurveLeft+m_GridColWidth[8];
	pLine->pt1.y = GridTop-13.5;
	pLine->pt2.x = CurveLeft + m_GridColWidth[8] + m_GridColWidth[9];
	pLine->pt2.y = GridTop-13.5;

/*	if (bFs)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");
		pLine->pt1.x = CurveLeft + m_GridColWidth[9] + m_GridColWidth[10];
		pLine->pt1.y = GridTop - 13.5;
		pLine->pt2.x = GridLeft + GridWidth;
		pLine->pt2.y = GridTop - 13.5;
	}

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");
	pLine->pt1.x = CurveLeft+m_GridColWidth[9];
	pLine->pt1.y = GridTop - 13.5 - 6.5;
	pLine->pt2.x = CurveLeft + m_GridColWidth[9] + m_GridColWidth[10];
	pLine->pt2.y = pLine->pt1.y;

	if (bFs)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");
		pLine->pt1.x = CurveLeft + m_GridColWidth[9] + m_GridColWidth[10];
		pLine->pt1.y = GridTop - 13.5 - 6.5;
		pLine->pt2.x = GridLeft + GridWidth;
		pLine->pt2.y = pLine->pt1.y;
	}
*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="The Curve of CPT";//"静 探 曲 线";
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	//pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	//pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6];
	//pMText->m_Location.x+=m_GridColWidth[7]+m_GridColWidth[8]+m_GridColWidth[9];
	//pMText->m_Location.x+=m_GridColWidth[10]/2;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+m_GridColWidth[9]/2;
	pMText->m_Location.y=GridTop-5;
	strcpy(pMText->m_Font,ENFONTNAME);

/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="fs(kPa)";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+3;
	pMText->m_Location.y=GridTop-13.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="ps(MPa)";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+3;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);

/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="40";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+20-0.8;
	pMText->m_Location.y=GridTop-13.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);*/
//2,4,6,8
//2,4,6,8,10,12
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="2";//"4";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+20-0.8;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);

/*	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="80";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+40-0.7;
	pMText->m_Location.y=GridTop-13.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="4";//"8";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9)+40-0.7;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="6";//"12";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	/*pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
	pMText->m_Location.x+=m_GridColWidth[4]+m_GridColWidth[5]+m_GridColWidth[6];
	pMText->m_Location.x+=m_GridColWidth[7]+m_GridColWidth[8]+m_GridColWidth[9];*/
	pMText->m_Location.x = GetGridColRight(GridLeft,9);
	pMText->m_Location.x+=60-0.7;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);


	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="8";//"16";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9);
	pMText->m_Location.x+=10*8-0.7;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);

//added on 2005/10
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="10";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9);
	pMText->m_Location.x+=10*10-0.7;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text="12";
	pMText->m_Height=m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Location.x = GetGridColRight(GridLeft,9);
	pMText->m_Location.x+=10*12;
	pMText->m_Location.y=GridTop-13.5-6.5-2;
	strcpy(pMText->m_Font,ENFONTNAME);
//================================================
	/*if (bFs)//create grid header
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="摩 阻 比 曲 线";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=GridLeft+m_GridColWidth[0]+m_GridColWidth[1]+m_GridColWidth[2]+m_GridColWidth[3];
		pMText->m_Location.x = GetGridColRight(GridLeft,11);
		pMText->m_Location.x+=m_GridColWidth[11]/2;
		pMText->m_Location.y=GridTop-5;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="(fs/qc)";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11);
		pMText->m_Location.x += m_GridColWidth[11]/2+12;
		pMText->m_Location.y=GridTop-5.5;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="图   例: ";
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 3;
		pMText->m_Location.y=GridTop-13.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="qc(Rf) ";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 19;
		pMText->m_Location.y=GridTop-13.5-2.3;
		strcpy(pMText->m_Font,ENFONTNAME);

		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");
		pLine->pt1.x=pMText->m_Location.x+10;
		pLine->pt1.y=GridTop-13.5-3.25;
		pLine->pt2.x=pLine->pt1.x+10;
		pLine->pt2.y=GridTop-13.5-3.25;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="fs  -------";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 52;
		pMText->m_Location.y=GridTop-13.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);
//==============================================================================================
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="Rf";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 3;
		pMText->m_Location.y=GridTop-13.5-6.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="2";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 20 - 0.8;
		pMText->m_Location.y=GridTop-13.5-6.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="4";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 40 - 0.8;
		pMText->m_Location.y=GridTop-13.5-6.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="6";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 60 - 0.8;
		pMText->m_Location.y=GridTop-13.5-6.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text="8";
		pMText->m_Height=m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
		pMText->m_Location.x = GetGridColRight(GridLeft,11) + 78;
		pMText->m_Location.y=GridTop-13.5-6.5-2;
		strcpy(pMText->m_Font,ENFONTNAME);
	}*/
//=============================================================================================
	int maxStrLen=5000;
	char str[5000];
	GetPrivateProfileString(keyName,"层号","",str,maxStrLen,m_FileName);
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
	GetPrivateProfileString(keyName,"层厚","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	int LayerCount=m_Holelayers.GetSize(); 
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	pHoleLayer->m_Deep=atof(pszTemp)/m_vScale*1000;

	double curLayerDeep;

	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = m_pLayerGroup->indexOf("0");
	curLayerDeep = pHoleLayer->m_Deep;
	pLine->pt1.x = GridLeft;
	pLine->pt1.y = GridTop-m_Row1Height-curLayerDeep;
	pLine->pt2.x = CurveLeft;
	pLine->pt2.y = GridTop-m_Row1Height-curLayerDeep;

	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = m_pLayerGroup->indexOf("0");
//	pMText->m_Text.Format("%.2f",pHoleLayer->m_Deep);
	pMText->m_Text = pszTemp;
	pMText->m_Height = m_FontHeight-0.5;//m_FontHeight-1;
	pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMLEFT;
	pMText->m_Location.x = GetGridColRight(GridLeft,3) + 0.2;
	//pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2]+0.2;
	pMText->m_Location.y = GridTop-m_Row1Height-curLayerDeep;
	strcpy(pMText->m_Font,ENFONTNAME);

	double circleRadius=1.5+0.2;

	CADBlock* pBlock=CreateLayerBlock(pHoleLayer);
	if(pBlock)
	{
		CADInsert* pInsert=new CADInsert();
		m_pGraphics->m_Entities.Add((CObject*)pInsert);
		pInsert->m_nLayer=0;
		strcpy(pInsert->m_Name,pBlock->m_Name); 
		pInsert->pt.x=GridLeft+m_GridColWidth[0]/2;
		pInsert->pt.y=GridTop-m_Row1Height-curLayerDeep+circleRadius;
	}

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		pHoleLayer->m_Deep=atof(pszTemp)/m_vScale*1000;		

		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");
		curLayerDeep+=pHoleLayer->m_Deep;
		pLine->pt1.x=GridLeft;
		pLine->pt1.y=GridTop-m_Row1Height-curLayerDeep;
		pLine->pt2.x=CurveLeft;
		pLine->pt2.y=GridTop-m_Row1Height-curLayerDeep;

		pBlock=CreateLayerBlock(pHoleLayer);
		if(pBlock)
		{
			CADInsert* pInsert=new CADInsert();
			m_pGraphics->m_Entities.Add((CObject*)pInsert);
			pInsert->m_nLayer=0;
			strcpy(pInsert->m_Name,pBlock->m_Name); 
			pInsert->pt.x = GridLeft + m_GridColWidth[0]/2;
			pInsert->pt.y = GridTop-m_Row1Height-curLayerDeep+circleRadius;
		}

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text.Format("%.2f",pHoleLayer->m_Deep);
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-0.5;//m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2]+0.2;
		pMText->m_Location.x = GetGridColRight(GridLeft,3) + 0.2;
		pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
		strcpy(pMText->m_Font,ENFONTNAME);
	}
//===========================================================================================
	GetPrivateProfileString(keyName,"土类代码","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	//updated on 2007/01/08
	//strcpy(pHoleLayer->m_Lengend,pszTemp);	
	CString strTmp;
	CString strEN;
	strTmp = pszTemp;
	int j = strTmp.Find(m_SplitChar);
	if (j>0)
	{
		strcpy(pHoleLayer->m_Lengend,strTmp.Left(j));
		strEN = strTmp.Right(strTmp.GetLength()-j-1);
	}
	else
	{
		strcpy(pHoleLayer->m_Lengend,strTmp);		
	}
	//
	curLayerDeep=pHoleLayer->m_Deep;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	//pMText->m_Text=pszTemp;
	pMText->m_Text = strEN;
	pMText->m_Height=m_FontHeight;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]/2;
	pMText->m_Location.x = GetGridColRight(GridLeft,1) + m_GridColWidth[1]/2;
	pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
	strcpy(pMText->m_Font,ENFONTNAME);

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		//updated on 2007/01/08
		//strcpy(pHoleLayer->m_Lengend,pszTemp);	
		CString strTmp;
		CString strEN;
		strTmp = pszTemp;
		int j = strTmp.Find(m_SplitChar);
		if (j>0)
		{
			strcpy(pHoleLayer->m_Lengend,strTmp.Left(j));
			strEN = strTmp.Right(strTmp.GetLength()-j-1);
		}
		else
		{
			strcpy(pHoleLayer->m_Lengend,strTmp);		
		}
		//
		curLayerDeep+=pHoleLayer->m_Deep;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		//pMText->m_Text=pszTemp;
		pMText->m_Text = strEN;
		pMText->m_Height=m_FontHeight;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]/2;
		pMText->m_Location.x = GetGridColRight(GridLeft,1) + m_GridColWidth[1]/2;
		pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
		strcpy(pMText->m_Font,ENFONTNAME);
	}
//===========================================================================================
	GetPrivateProfileString(keyName,"层深标高","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	curLayerDeep=pHoleLayer->m_Deep;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text=pszTemp;
	pMText->m_Height=m_FontHeight-0.5;//m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
	//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+0.2;
	pMText->m_Location.x = GetGridColRight(GridLeft,2) + 0.2;
	pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
	strcpy(pMText->m_Font,ENFONTNAME);

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		curLayerDeep+=pHoleLayer->m_Deep;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-0.5;//m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
		//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1]+0.2;
		pMText->m_Location.x = GetGridColRight(GridLeft,2) + 0.2;
		pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
		strcpy(pMText->m_Font,ENFONTNAME);
	}
//===========================================================================================
	double supLayerDeep;
	curLayerDeep=0;
	for(i=0;i<m_Holelayers.GetSize();i++)
	{
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		supLayerDeep=curLayerDeep;
		curLayerDeep+=pHoleLayer->m_Deep;

		pPolyline=new CADPolyline();
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3];
		pPoint->x = GetGridColRight(GridLeft,4);
		pPoint->y = GridTop-m_Row1Height-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+6;
		pPoint->x = GetGridColRight(GridLeft,4) + 6;
		pPoint->y = GridTop-m_Row1Height-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+6;
		pPoint->x = GetGridColRight(GridLeft,4) + 6;
		pPoint->y = GridTop-m_Row1Height-curLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3];
		pPoint->x = GetGridColRight(GridLeft,4);
		pPoint->y = GridTop-m_Row1Height-curLayerDeep;
		CreateHatch(pHoleLayer->m_Lengend,pPolyline);
	//===
		pPolyline=new CADPolyline();
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+6+2;
		pPoint->x = GetGridColRight(GridLeft,4)+6+2;
		pPoint->y = GridTop-m_Row1Height-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
		pPoint->x = GetGridColRight(GridLeft,5);
		pPoint->y = GridTop-m_Row1Height-supLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
		pPoint->x = GetGridColRight(GridLeft,5);
		pPoint->y = GridTop-m_Row1Height-curLayerDeep;

		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);  
		//pPoint->x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pPoint->x = pPoint->x+GridColWidth[2]+GridColWidth[3]+6+2;
		pPoint->x = GetGridColRight(GridLeft,4)+6+2;
		pPoint->y = GridTop-m_Row1Height-curLayerDeep;
		CreateHatch(pHoleLayer->m_Lengend,pPolyline);
	}
//===========================================================================================
	GetPrivateProfileString(keyName,"锥尖阻力平均值","",str,maxStrLen,m_FileName);
	//GetPrivateProfileString(keyName,"比贯入阻力平均值","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp==NULL)return;
	i=0;
	pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
	curLayerDeep=pHoleLayer->m_Deep;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Text=pszTemp;
	pMText->m_Height=m_FontHeight-0.5;//m_FontHeight-1;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1];
	//pMText->m_Location.x+=GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
	pMText->m_Location.x = GetGridColRight(GridLeft,5);
	pMText->m_Location.x+= m_GridColWidth[5]/2;

	pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
	strcpy(pMText->m_Font,ENFONTNAME);

	while(pszTemp)
	{
		i++;
		if((i+1)>LayerCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
		curLayerDeep+=pHoleLayer->m_Deep;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=m_pLayerGroup->indexOf("0");
		pMText->m_Text=pszTemp;
		pMText->m_Height=m_FontHeight-0.5;//m_FontHeight-1;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1];
		//pMText->m_Location.x+=GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
		pMText->m_Location.x = GetGridColRight(GridLeft,5);
		pMText->m_Location.x += m_GridColWidth[5]/2;
		pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
		strcpy(pMText->m_Font,ENFONTNAME);
	}
//===========================================================================================
/*	GetPrivateProfileString(keyName,"侧壁摩阻力平均值","",str,maxStrLen,m_FileName);
	pszTemp = strtok(str, ",");

	if(pszTemp!=NULL)
	{
		i=0;
		pHoleLayer = (CPerHoleLayer*)m_Holelayers.GetAt(i);
		curLayerDeep = pHoleLayer->m_Deep;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Text = pszTemp;
		pMText->m_Height = m_FontHeight-1;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
		//pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1];
		//pMText->m_Location.x += GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
		pMText->m_Location.x = GetGridColRight(GridLeft,6);
		pMText->m_Location.x += m_GridColWidth[6]/2;

		pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
		strcpy(pMText->m_Font,ENFONTNAME);

		while(pszTemp)
		{
			i++;
			if((i+1)>LayerCount)break;
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)break;
			pHoleLayer=(CPerHoleLayer*)m_Holelayers.GetAt(i);
			curLayerDeep+=pHoleLayer->m_Deep;
			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer=m_pLayerGroup->indexOf("0");
			pMText->m_Text=pszTemp;
			pMText->m_Height=m_FontHeight-1;
			pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
			//pMText->m_Location.x=GridLeft+GridColWidth[0]+GridColWidth[1];
			//pMText->m_Location.x+=GridColWidth[2]+GridColWidth[3]+GridColWidth[4];
			pMText->m_Location.x = GetGridColRight(GridLeft,6);
			pMText->m_Location.x += m_GridColWidth[6]/2;
			pMText->m_Location.y=GridTop-m_Row1Height-curLayerDeep;
			strcpy(pMText->m_Font,ENFONTNAME);
		}
	}*/
//===========================================================================================

/*
//create 3 curves-----------------------------------------------------------------------
	const int strMaxLen=20000;
	char str2[strMaxLen];
	GetPrivateProfileString(keyName,"静探深度","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if(pszTemp==NULL)return;
	pPolyline = new CADPolyline();//创建qc曲线
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");

	CADPolyline* pPolyline2 = NULL;
	CADPolyline* pPolyline3 = NULL;
	ADPOINT* pPoint2 = NULL;
	ADPOINT* pPoint3 = NULL;
	if (bFs)
	{
		pPolyline2 = new CADPolyline();//创建fs曲线
		pPolyline2->m_LTypeName = new char[AD_MAX_STRLEN];
		strcpy(pPolyline2->m_LTypeName,"ACAD_ISO02W100");
		pPolyline2->m_LTypeScale = 0.1;
		m_pGraphics->m_Entities.Add((CObject*)pPolyline2);
		pPolyline2->m_nLayer = m_pLayerGroup->indexOf("0");

		pPolyline3 = new CADPolyline();
		m_pGraphics->m_Entities.Add((CObject*)pPolyline3);
		pPolyline3->m_nLayer = m_pLayerGroup->indexOf("0");
	}

	pPoint=new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint->y = CurveTop-atof(pszTemp)/m_vScale*1000;

	if (bFs)
	{
		pPoint2 = new ADPOINT();
		pPolyline2->m_Point.Add((CObject*)pPoint2);
		pPoint2->y=CurveTop-atof(pszTemp)/m_vScale*1000;

		pPoint3 = new ADPOINT();
		pPolyline3->m_Point.Add((CObject*)pPoint3);
		pPoint3->y=CurveTop-atof(pszTemp)/m_vScale*1000;
	}

	while(pszTemp)
	{
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->y = CurveTop-atof(pszTemp)/m_vScale*1000;

		if (bFs)
		{
			pPoint2=new ADPOINT();
			pPolyline2->m_Point.Add((CObject*)pPoint2);
			pPoint2->y=CurveTop-atof(pszTemp)/m_vScale*1000;

			pPoint3=new ADPOINT();
			pPolyline3->m_Point.Add((CObject*)pPoint3);
			pPoint3->y=CurveTop-atof(pszTemp)/m_vScale*1000;
		}
	}

	GetPrivateProfileString(keyName,"锥尖阻力qc","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if(pszTemp==NULL)return;
	i=0;
	int pointCount=pPolyline->m_Point.GetSize(); 
	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);

	if(atof(pszTemp)>8.1)
		pPoint->x = CurveLeft+GridColWidth[9]+8.1*5;
	else
		pPoint->x = CurveLeft+GridColWidth[9]+atof(pszTemp)*5;

	while(pszTemp)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);	
		if(atof(pszTemp)>8.1)
			pPoint->x = CurveLeft+GridColWidth[9]+8.1*5;
		else
			pPoint->x = CurveLeft+GridColWidth[9]+atof(pszTemp)*5;
	}
//////////////////////////////////////////////
	if (!bFs) return;

	GetPrivateProfileString(keyName,"侧壁摩阻力fs","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if(pszTemp==NULL)return;
	i=0;
	pointCount=pPolyline2->m_Point.GetSize(); 
	pPoint=(ADPOINT*)pPolyline2->m_Point.GetAt(i);

	if(atof(pszTemp)>161)
		pPoint->x = CurveLeft+GridColWidth[9]+161*0.5;
	else
		pPoint->x = CurveLeft+GridColWidth[9]+atof(pszTemp)*0.5;

	while(pszTemp)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline2->m_Point.GetAt(i);
		if(atof(pszTemp)>161)
			pPoint->x = CurveLeft+GridColWidth[9]+161*0.5;
		else
			pPoint->x = CurveLeft+GridColWidth[9]+atof(pszTemp)*0.5;
	}
////////////////////////////////////////////////////////////
	GetPrivateProfileString(keyName,"摩阻比Rf","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if(pszTemp==NULL)return;
	i=0;
	pointCount=pPolyline3->m_Point.GetSize(); 
	pPoint=(ADPOINT*)pPolyline3->m_Point.GetAt(i);

	if(atof(pszTemp)>8.1)
		pPoint->x = CurveLeft+GridColWidth[9]+GridColWidth[10]+8.1*10;
	else
		pPoint->x = CurveLeft+GridColWidth[9]+GridColWidth[10]+atof(pszTemp)*10;

	while(pszTemp)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline3->m_Point.GetAt(i);	
		if(atof(pszTemp)>8.1)
			pPoint->x = CurveLeft+GridColWidth[9]+GridColWidth[10]+8.1*10;
		else
			pPoint->x = CurveLeft+GridColWidth[9]+GridColWidth[10]+atof(pszTemp)*10;
	}*/
}

void CStaticIniFile2::Create3Curves(double GridLeft,double GridTop,double GridHeight,bool bFs,const char* keyName)
{
	int i;
	double CurveLeft = GridLeft;
	for (i=0;i<8;i++)
	{
		CurveLeft += m_GridColWidth[i];	
	}
	double CurveTop = GridTop - m_Row1Height;
	double GridWidth = 0.0;
	for (i=0; i<m_MaxCol; i++)
	{
		GridWidth += m_GridColWidth[i];
	}

	//create 深度横线
	if (m_Deep>0)
	{
		for(int i=2;i<=m_Deep;i=i+2)
		{
			CADLine* pLine = new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLineWidth = 0.5;
			pLine->m_nLayer = m_pLayerGroup->indexOf("0");
			pLine->pt1.x = CurveLeft;
			pLine->pt1.y = CurveTop-(double)i/m_vScale*1000;
			pLine->pt2.x = CurveLeft + m_GridColWidth[8] + m_GridColWidth[9];
			pLine->pt2.y = CurveTop-(double)i/m_vScale*1000;

			if (bFs)
			{
				pLine=new CADLine();
				m_pGraphics->m_Entities.Add((CObject*)pLine);
				pLine->m_nLineWidth = 0.5;
				pLine->m_nLayer=m_pLayerGroup->indexOf("0");
				pLine->pt1.x = CurveLeft + m_GridColWidth[8] + m_GridColWidth[9];
				pLine->pt1.y = CurveTop - (double)i/m_vScale*1000;
				pLine->pt2.x = GridLeft + GridWidth;
				pLine->pt2.y = CurveTop-(double)i/m_vScale*1000;
			}

			CADMText* pMText = new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer = m_pLayerGroup->indexOf("0");
			pMText->m_Text.Format("%.1f",(double)i);
			pMText->m_Height = m_FontHeight-1;
			pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
			pMText->m_Location.x = CurveLeft+m_GridColWidth[8]/2;
			pMText->m_Location.y = CurveTop-(double)i/m_vScale*1000;
			strcpy(pMText->m_Font,ENFONTNAME);
		}		
	}

	//draw(2,4,6,8,10,12)vertical line
	//draw vertical line
	//for (i=1;i<8;i++)
	for (i=1;i<12;i++)
	{
		CADLine* pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLineWidth = 0.5;
		pLine->pt1.x = CurveLeft;
		pLine->m_nLayer = m_pLayerGroup->indexOf("0");
		pLine->pt1.x = CurveLeft + m_GridColWidth[8]+i*10;
		pLine->pt1.y = CurveTop;
		pLine->pt2.x = CurveLeft + m_GridColWidth[8]+i*10;
		pLine->pt2.y = GridTop-GridHeight;
	}

/*	if (bFs)
	{
		for(i=1;i<8;i++)
		{
			CADLine* pLine = new CADLine();
			m_pGraphics->m_Entities.Add((CObject*)pLine);
			pLine->m_nLineWidth = 0.5;
			pLine->pt1.x = CurveLeft;
			pLine->m_nLayer = m_pLayerGroup->indexOf("0");
			pLine->pt1.x = CurveLeft+m_GridColWidth[8]+m_GridColWidth[9]+i*10;
			pLine->pt1.y = CurveTop;
			pLine->pt2.x = CurveLeft+m_GridColWidth[8]+m_GridColWidth[9]+i*10;
			pLine->pt2.y = GridTop-GridHeight;
		}
	}*/

//create 3 curves-----------------------------------------------------------------------
	const int strMaxLen=20000;
	char str2[strMaxLen];
	GetPrivateProfileString(keyName,"静探深度","",str2,strMaxLen,m_FileName);
	char* pszTemp;
	pszTemp = strtok(str2, ",");

	if (pszTemp==NULL)return;
	CADPolyline* pPolyline = new CADPolyline();//创建qc曲线
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");

	CADPolyline* pPolyline2 = NULL;
	CADPolyline* pPolyline3 = NULL;
	ADPOINT* pPoint2 = NULL;
	ADPOINT* pPoint3 = NULL;
	/*if (bFs)
	{
		pPolyline2 = new CADPolyline();//创建fs曲线
		pPolyline2->m_LTypeName = new char[AD_MAX_STRLEN];
		strcpy(pPolyline2->m_LTypeName,"ACAD_ISO02W100");
		pPolyline2->m_LTypeScale = 0.1;
		m_pGraphics->m_Entities.Add((CObject*)pPolyline2);
		pPolyline2->m_nLayer = m_pLayerGroup->indexOf("0");

		pPolyline3 = new CADPolyline();
		m_pGraphics->m_Entities.Add((CObject*)pPolyline3);
		pPolyline3->m_nLayer = m_pLayerGroup->indexOf("0");
	}*/

	ADPOINT* pPoint;
	pPoint = new ADPOINT();
	pPolyline->m_Point.Add((CObject*)pPoint);

	pPoint->y = CurveTop-atof(pszTemp)/m_vScale*1000;

/*	if (bFs)
	{
		pPoint2 = new ADPOINT();
		pPolyline2->m_Point.Add((CObject*)pPoint2);
		pPoint2->y=CurveTop-atof(pszTemp)/m_vScale*1000;

		pPoint3 = new ADPOINT();
		pPolyline3->m_Point.Add((CObject*)pPoint3);
		pPoint3->y = CurveTop-atof(pszTemp)/m_vScale*1000;
	}*/

	while(pszTemp)
	{
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint = new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->y = CurveTop-atof(pszTemp)/m_vScale*1000;

		/*if (bFs)
		{
			pPoint2 = new ADPOINT();
			pPolyline2->m_Point.Add((CObject*)pPoint2);
			pPoint2->y = CurveTop - atof(pszTemp)/m_vScale*1000;

			pPoint3 = new ADPOINT();
			pPolyline3->m_Point.Add((CObject*)pPoint3);
			pPoint3->y = CurveTop - atof(pszTemp)/m_vScale*1000;
		}*/
	}
////////////////////////////////////////////////////////////////////////////////
	GetPrivateProfileString(keyName,"锥尖阻力qc","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if (pszTemp==NULL)return;
	i = 0;
	int pointCount = pPolyline->m_Point.GetSize(); 
	pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(i);

	//const float fQcLimit = 16.1;//8.1;
	//const float fQcLimit = 8.1;
	const float fQcLimit = 12.1;
	int scale = 10;//5;//added on 2005/9/7
	if (atof(pszTemp) > fQcLimit)
		pPoint->x = CurveLeft + m_GridColWidth[8]+fQcLimit*scale;
	else
		pPoint->x = CurveLeft + m_GridColWidth[8]+atof(pszTemp)*scale;

	i = 0;
	while (pszTemp != NULL)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);	
		if(atof(pszTemp)>fQcLimit)
			pPoint->x = CurveLeft+m_GridColWidth[8]+fQcLimit*scale;
		else
			pPoint->x = CurveLeft+m_GridColWidth[8]+atof(pszTemp)*scale;
	}
//////////////////////////////////////////////
/*	if (!bFs) return;

	GetPrivateProfileString(keyName,"侧壁摩阻力fs","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if (pszTemp==NULL)return;
	i = 0;
	pointCount = pPolyline2->m_Point.GetSize(); 
	pPoint = (ADPOINT*)pPolyline2->m_Point.GetAt(i);

	if (atof(pszTemp)>161)
		pPoint->x = CurveLeft+m_GridColWidth[9]+161*0.5;
	else
		pPoint->x = CurveLeft+m_GridColWidth[9]+atof(pszTemp)*0.5;

	while(pszTemp)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline2->m_Point.GetAt(i);
		if(atof(pszTemp)>161)
			pPoint->x = CurveLeft + m_GridColWidth[9]+161*0.5;
		else
			pPoint->x = CurveLeft + m_GridColWidth[9]+atof(pszTemp)*0.5;
	}
////////////////////////////////////////////////////////////
	GetPrivateProfileString(keyName,"摩阻比Rf","",str2,strMaxLen,m_FileName);
	pszTemp = strtok(str2, ",");

	if(pszTemp==NULL)return;
	i=0;
	pointCount=pPolyline3->m_Point.GetSize(); 
	pPoint=(ADPOINT*)pPolyline3->m_Point.GetAt(i);

	if(atof(pszTemp)>8.1)
		pPoint->x = CurveLeft+m_GridColWidth[9]+m_GridColWidth[10]+8.1*10;
	else
		pPoint->x = CurveLeft+m_GridColWidth[9]+m_GridColWidth[10]+atof(pszTemp)*10;

	while(pszTemp)
	{
		i++;
		if((i+1)>pointCount)break;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
		pPoint=(ADPOINT*)pPolyline3->m_Point.GetAt(i);	
		if(atof(pszTemp)>8.1)
			pPoint->x = CurveLeft+m_GridColWidth[9]+m_GridColWidth[10]+8.1*10;
		else
			pPoint->x = CurveLeft+m_GridColWidth[9]+m_GridColWidth[10]+atof(pszTemp)*10;
	}*/
}

CADBlock* CStaticIniFile2::CreateLayerBlock(CPerHoleLayer* pHoleLayer)
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
//-----------------------------------------------------------

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

void CStaticIniFile2::CreateHatch(char* LegendName,CADPolyline* pPolyline)
{
//check special legend---------------------
	short SpecialLegendCount = 5;
	//char* SpecialLegend[] = {"粉砂","细砂","中砂","粗砂","砾砂","粉砂岩","细砂岩","中砂岩","粗砂岩","泥质粉砂岩"};
	char  SpecialLegendChar[] = {'f','x','z','c','l'};

	int legendCharIndex = -1;
	/*for(int i=0;i<=SpecialLegendCount-1;i++)
	{
		if(strcmp(LegendName,SpecialLegend[i])==0)
		{
			strcpy(LegendName,"砂");
			legendCharIndex = i;
			break;
		}
	}*/
	if (strcmp(LegendName,"粉砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"粉细砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"粉砂夹细砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 0;	
	}
	//updated on 20070207
	else if (strcmp(LegendName,"粉砂夹粉土")==0)
	{
		strcpy(LegendName,"含粘性土粉砂");
		legendCharIndex = 0;	
	}
	//added on 20070207
	else if (strcmp(LegendName,"粉砂夹亚砂土")==0)
	{
		strcpy(LegendName,"含粘性土粉砂");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"细砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"中砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"中细砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"中粗砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"粗砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"砾砂")==0)
	{
		strcpy(LegendName,"砂");
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"粉砂岩")==0)
	{
		strcpy(LegendName,"砂岩");
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"细砂岩")==0)
	{
		strcpy(LegendName,"砂岩");
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"中砂岩")==0)
	{
		strcpy(LegendName,"砂岩");
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"粗砂岩")==0)
	{
		strcpy(LegendName,"砂岩");
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"含砾粉砂岩")==0)
	{
		legendCharIndex = 0;	
	}
	/*else if (strcmp(LegendName,"粉砂夹粉土")==0)
	{
		strcpy(LegendName,"砂质粉土");
		legendCharIndex = 0;	
	}*///2004-05-19
	else if (strcmp(LegendName,"含砾砂粉质粘土")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"含砾砂粘土")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"含砾砂淤泥质粉质粘土")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(LegendName,"含粘性土粉沙")==0)
	{
		legendCharIndex = 0;	
	}
	else if (strcmp(LegendName,"含粘性土细沙")==0)
	{
		legendCharIndex = 1;	
	}
	else if (strcmp(LegendName,"含粘性土中沙")==0)
	{
		legendCharIndex = 2;	
	}
	else if (strcmp(LegendName,"含粘性土粗沙")==0)
	{
		legendCharIndex = 3;	
	}
	else if (strcmp(LegendName,"含粘性土砾沙")==0)
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
				pHatch->m_nLayer=m_pLayerGroup->indexOf("0");
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
					pMText->m_nLayer=m_pLayerGroup->indexOf("0");
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

void CStaticIniFile2::CreateHatchLine(char* hatchLineStr,CADHatch* pHatch)
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


void CStaticIniFile2::CreateChartFrame(float left,float top,float width,float height)
{
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth = 3;

	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left + width;
	pPoint->y = top;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left + width;
	pPoint->y = top -height;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = left;
	pPoint->y = top - height;
	pPolyline->m_Point.Add((CObject*)pPoint);
}

double CStaticIniFile2::GetGridColRight(double GridLeft,short nCol)
{
	double colLeft;
	colLeft = GridLeft;
	for (int i=0;i<nCol;i++)
	{
		colLeft += m_GridColWidth[i];
	}
	return colLeft;
}