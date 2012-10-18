#include "stdafx.h"
#include "ProjectIniFile.h"
#define LegendWidth 0.8//cm
#include "..\FunctionLib\Function_System.h"

CProjectIniFile::CProjectIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_LayerGroup=pLayerGroup;
	m_Graphics=pGraphics;
	m_Graphics->m_pLayerGroup=pLayerGroup;
}

CProjectIniFile::~CProjectIniFile()
{

}

void CProjectIniFile::FileImport(LPCTSTR lpFilename)
{
	m_pFileName=lpFilename;
	char str[255];
	m_HoleNum=::GetPrivateProfileInt("钻孔","个数",0,lpFilename);
	if(m_HoleNum==0)return;
///	m_LayerNum=::GetPrivateProfileInt("钻孔","最大层数",0,lpFilename);
///	if(m_LayerNum==0)return;

	m_hScale=::GetPrivateProfileInt("比例尺","X",0,lpFilename);
	if(m_hScale==0)return;
	m_vScale=::GetPrivateProfileInt("比例尺","Y",0,lpFilename);
	if(m_vScale==0)return;

	m_Orient=::GetPrivateProfileInt("比例尺","打印方向",1,lpFilename);
	if(m_Orient==1)
		m_Graphics->m_PaperOrient=HORIZONTAL;
	else
		m_Graphics->m_PaperOrient=VERTICAL;

	m_xScale=m_hScale/100;
	m_yScale=m_vScale/100;

	m_xScale2=1000/m_hScale;
	m_yScale2=1000/m_vScale;

	//double perRuler=10;//unit(mm)

	::GetPrivateProfileString("图纸信息","工程名称","",m_ProjectName,255,lpFilename);
	::GetPrivateProfileString("图纸信息","工程编号","",m_ProjectID,255,lpFilename);

	m_Holelayers=new CHoleLayer[m_HoleNum];
	m_HoleID=new char*[m_HoleNum];//孔口编号
	m_HoleHeight=new double[m_HoleNum];//孔口标高
	m_HoleDeep=new double[m_HoleNum];//孔深
	m_HolePoints=new ADPOINT[m_HoleNum];//孔口坐标
	m_LegendWidth=LegendWidth*m_xScale;

//	double maxTop;
	char num[4];
	char keyName[10];
	int i;
	for(i=0;i<m_HoleNum;i++)
	{
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		///////////////////////////////////////////////////////////////////
		m_HoleID[i]=new char[50];
		GetPrivateProfileString(keyName,"编号","",m_HoleID[i],255,lpFilename);
		///////////////////////////////////////////////////////////////////
		GetPrivateProfileString(keyName,"孔口标高","",str,255,lpFilename);
		m_HoleHeight[i]=atof(str);
		///////////////////////////////////////////////////////////////////
		if(i==0)
		{
			if(m_HoleHeight[i]<0)
				m_RulerTop=(int)m_HoleHeight[i];
			else
				m_RulerTop=(int)m_HoleHeight[i]+1;
		}
		else
		{
			if(m_HoleHeight[i]<0)
			{
				if(m_RulerTop<(int)(m_HoleHeight[i]))
					m_RulerTop=(int)(m_HoleHeight[i]);
			}
			else
			{
				if(m_RulerTop<(int)(m_HoleHeight[i])+1)
					m_RulerTop=(int)(m_HoleHeight[i])+1;
			}
		}
		GetPrivateProfileString(keyName,"孔深","",str,255,lpFilename);
		m_HoleDeep[i]=atof(str);
		if(i==0)m_HoleBottom=(int)(m_HoleHeight[i]-m_HoleDeep[i]);
		else
		{
			if(m_HoleBottom>(int)(m_HoleHeight[i]-m_HoleDeep[i]))
			m_HoleBottom=(int)(m_HoleHeight[i]-m_HoleDeep[i]);
		}
		///////////////////////////////////////////////////////////////////
		GetPrivateProfileString(keyName,"孔口坐标X","",str,255,lpFilename);
		m_HolePoints[i].x=atof(str);
		GetPrivateProfileString(keyName,"孔口坐标Y","",str,255,lpFilename);
		m_HolePoints[i].y=atof(str);
	}

	CalHorizontalCoord();//cal horizontal coordinate x first then cal flowing

	for(i=0;i<m_HoleNum;i++)
	{
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		///////////////////////////////////////////////////////////////////

		//生成剖面竖直线
		CreateVertLine(i);
		//得到剖面层的信息
		GetHoleLayerInfo(i);
		//生成土样信息
		GetPrivateProfileString(keyName,"土样信息","",str,255,lpFilename);
		CreateLandInfo(str,i);
		//生成标贯信息
		GetPrivateProfileString(keyName,"标贯信息","",str,255,lpFilename);
		CreateGradeInfo(str,i);		
	}

	//m_HoleBottom-=1;

	//生成剖面水平线(钻孔层)
	CreateHoleLayer();
	/////////////////////////////////////////////////////////////////////////////
	//生成剖面水平线(1层--n层)

	//setup height
	m_HoleGridHeight=13;
	m_LabelGridHegiht=7;
	m_HoleGridSpace=2*m_yScale;
	m_LabelGridSpace=0.4*m_yScale;

	double width,height,leftMargin,topMargin;
	double rightMargin,bottomMargin;

	width=m_HolePoints[m_HoleNum-1].x-m_HolePoints[0].x;
	height=m_RulerTop-m_HoleBottom;

	leftMargin=2.5*m_xScale+3.5*m_xScale;
	topMargin=4.5*m_yScale;
	rightMargin=2.5*m_xScale+2.5*m_xScale;
	bottomMargin=(2+1.3+0.4+0.7+0.2)*m_yScale;

	m_Graphics->m_Extmin.x=m_HolePoints[0].x-leftMargin;
	m_Graphics->m_Extmax.y=m_RulerTop+topMargin;

	ADPOINT adPoint;
	adPoint.x=m_Graphics->m_Extmin.x;
	adPoint.y=m_Graphics->m_Extmax.y;
	TransPoint(&adPoint);
	m_FrameLeft=adPoint.x;
	m_FrameTop=adPoint.y;
	adPoint.x=m_Graphics->m_Extmin.x+leftMargin+width+rightMargin;
	adPoint.y=m_Graphics->m_Extmax.y-topMargin-height-bottomMargin;
	TransPoint(&adPoint);
	m_FrameWidth=adPoint.x-m_FrameLeft;
	m_FrameHeight=m_FrameTop-adPoint.y;


//	m_Graphics->m_Extmax.x=m_Graphics->m_Extmin.x+leftMargin+width+rightMargin;
//	m_Graphics->m_Extmin.y=m_Graphics->m_Extmax.y-topMargin-height-bottomMargin;
/*	if(m_Orient==1)
	{
		m_FrameWidth=345;
		m_FrameHeight=250;
	}
	else
	{
		m_FrameWidth=A3_HEIGHT-10;
		m_FrameHeight=A3_WIDTH-40;
	}*/
//--------------------------------------------------------------
	CreateChartFrame();
	CreateChartHeader();
	CreateChartRuler();

	CreateAllHoleLayer();
	CreateHoleLayerHatch();
	//创建钻孔间距表格
	//create label grid
	CreateHoleGrid();
	CreateLabelGrid();//foot
	CreateHoleHeightText();
	CreateHoleLayerText();
	CreateLayerFlag();
//--------------------------------------------------------------

/*	TransPoint(&m_Graphics->m_Extmin);
	TransPoint(&m_Graphics->m_Extmax);

	m_Graphics->m_Bound.left=(m_Graphics->m_Extmin.x-MarginLeft)*m_Graphics->m_mXPixel;
	m_Graphics->m_Bound.top=-(m_Graphics->m_Extmax.y+MarginTop)*m_Graphics->m_mYPixel;
	m_Graphics->m_Bound.right=(m_Graphics->m_Extmax.x+MarginRight)*m_Graphics->m_mXPixel;
	m_Graphics->m_Bound.bottom=-(m_Graphics->m_Extmin.y-MarginBottom)*m_Graphics->m_mYPixel;

	m_Graphics->m_PaperLeft=m_Graphics->m_Extmin.x-MarginLeft;
	m_Graphics->m_PaperTop=m_Graphics->m_Extmax.y+MarginTop;*/
//--------------------------------------------------------------
	double MarginLeft=3.3,MarginTop=2.0,MarginRight=3.3,MarginBottom=2.0;//unit(cm)
/*	double LeftPrintMargin;
	double TopPrintMargin;

	if(m_Orient==1)
	{
		LeftPrintMargin=3.3*m_xScale;
		TopPrintMargin=2*m_yScale;
	}
	else
	{
		LeftPrintMargin=0.5*m_xScale;
		TopPrintMargin=2*m_yScale;	
	}*/
	m_Graphics->m_Extmin.x-=MarginLeft*m_xScale;
	m_Graphics->m_Extmax.y+=MarginTop*m_yScale;

	TransPoint(&m_Graphics->m_Extmin);
	TransPoint(&m_Graphics->m_Extmax);

	m_Graphics->m_Extmax.x=m_FrameLeft+m_FrameWidth+MarginRight*10;
	m_Graphics->m_Extmin.y=m_FrameTop-m_FrameHeight-MarginBottom*10;

	m_Graphics->m_Bound.left=m_Graphics->m_Extmin.x*m_Graphics->m_mXPixel;
	m_Graphics->m_Bound.top=-m_Graphics->m_Extmax.y*m_Graphics->m_mYPixel;
	m_Graphics->m_Bound.right=m_Graphics->m_Extmax.x*m_Graphics->m_mXPixel;
	m_Graphics->m_Bound.bottom=-m_Graphics->m_Extmin.y*m_Graphics->m_mYPixel;

	m_Graphics->m_PaperLeft=m_Graphics->m_Extmin.x;
	m_Graphics->m_PaperTop=m_Graphics->m_Extmax.y;
	m_Graphics->m_PaperWidth = m_Graphics->m_Extmax.x - m_Graphics->m_Extmin.x;
	m_Graphics->m_PaperHeight = m_Graphics->m_Extmax.y - m_Graphics->m_Extmin.y;
}
//======================================================================================
void CProjectIniFile::CreateVertLine(int i)
{
	CADLine* pLine;
	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->m_nLineWidth=3; 
	pLine->pt1.x=m_HolePoints[i].x;
	pLine->pt1.y=m_HoleHeight[i];
	pLine->pt2.x=m_HolePoints[i].x;
	pLine->pt2.y=m_HoleHeight[i]-m_HoleDeep[i];
	TransPoint(&pLine->pt1);
	TransPoint(&pLine->pt2);

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->m_nLineWidth=3; 
	pLine->pt1.x=m_HolePoints[i].x-0.1*m_xScale;
	pLine->pt1.y=m_HoleHeight[i]-m_HoleDeep[i];
	pLine->pt2.x=m_HolePoints[i].x+0.1*m_xScale;
	pLine->pt2.y=m_HoleHeight[i]-m_HoleDeep[i];
	TransPoint(&pLine->pt1);
	TransPoint(&pLine->pt2);
}

void CProjectIniFile::CreateHoleLayer()
{
	CADSpline* pSpline;
	CADPoint* pPoint;

	pSpline=new CADSpline();
	m_Graphics->m_Entities.Add(pSpline);
	pSpline->m_nLayer=m_LayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;

	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[0].x-2.5*m_xScale;
	pPoint->pt.y=m_HoleHeight[0];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=(m_HolePoints[0].x+m_HolePoints[0].x-2.5*m_xScale)/2;
	pPoint->pt.y=m_HoleHeight[0];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[0].x;
	pPoint->pt.y=m_HoleHeight[0];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);

	for(int i=0;i<m_HoleNum-1;i++)
	{
		pSpline=new CADSpline();
		m_Graphics->m_Entities.Add(pSpline);
		pSpline->m_nLayer=m_LayerGroup->indexOf("0");
		pSpline->m_nLineWidth=2;

		pPoint=new CADPoint();
		pPoint->pt.x=m_HolePoints[i].x;
		pPoint->pt.y=m_HoleHeight[i];
		TransPoint(&pPoint->pt);
		pSpline->m_FitPoint.Add(pPoint);
		pPoint=new CADPoint();
		pPoint->pt.x=(m_HolePoints[i].x+m_HolePoints[i+1].x)/2;
		pPoint->pt.y=(m_HoleHeight[i]+m_HoleHeight[i+1])/2;
		TransPoint(&pPoint->pt);
		pSpline->m_FitPoint.Add(pPoint);		
		pPoint=new CADPoint();
		pPoint->pt.x=m_HolePoints[i+1].x;
		pPoint->pt.y=m_HoleHeight[i+1];
		TransPoint(&pPoint->pt);
		pSpline->m_FitPoint.Add(pPoint);
	}

	pSpline=new CADSpline();
	m_Graphics->m_Entities.Add(pSpline);
	pSpline->m_nLayer=m_LayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;

	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[m_HoleNum-1].x+2.5*m_xScale;
	pPoint->pt.y=m_HoleHeight[m_HoleNum-1];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=(m_HolePoints[m_HoleNum-1].x+m_HolePoints[m_HoleNum-1].x+2.5*m_xScale)/2;
	pPoint->pt.y=m_HoleHeight[m_HoleNum-1];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[m_HoleNum-1].x;
	pPoint->pt.y=m_HoleHeight[m_HoleNum-1];
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
}

void CProjectIniFile::CreateAllHoleLayer()
{
	int i,j,k;
	CADSpline* pSpline;
	CADPoint* pPoint;
	for(i=0; i<m_Holelayers[0].m_OneHoleLayers.GetSize(); i++)
	{
		COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[0].m_OneHoleLayers.GetAt(i);
		for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
		{
			CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[0])continue;
			pSpline=new CADSpline();
			m_Graphics->m_Entities.Add(pSpline);
			pSpline->m_nLineWidth=2;
			pSpline->m_nLayer=m_LayerGroup->indexOf("0");

			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[0].x-2*m_xScale;
			pPoint->pt.y=m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[0].x-m_xScale;
			pPoint->pt.y=m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[0].x;
			pPoint->pt.y=m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
		}
	}

	for(i=0;i<m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetSize();i++)
	{
		COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetAt(i);
		for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
		{
			CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[m_HoleNum-1])continue;
			pSpline=new CADSpline();
			m_Graphics->m_Entities.Add(pSpline);
			pSpline->m_nLayer=m_LayerGroup->indexOf("0");
			pSpline->m_nLineWidth=2;

			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[m_HoleNum-1].x+m_LegendWidth;
			pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=(m_HolePoints[m_HoleNum-1].x+m_LegendWidth+m_HolePoints[m_HoleNum-1].x+2*m_xScale)/2;
			pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[m_HoleNum-1].x+2*m_xScale;
			pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
		}
	}

	for(k=1;k<m_HoleNum;k++)
	{
		for(i=0;i<m_Holelayers[k].m_OneHoleLayers.GetSize();i++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[k].m_OneHoleLayers.GetAt(i);
			for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
			{
				CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				if(pSubHoleLayer->m_Deep>=m_HoleDeep[k])continue; 
				CreateHoleLayerLeftSpline(pOneHoleLayer,pSubHoleLayer,k,i,j);
			}
		}
	}

	for(k=0;k<m_HoleNum-1;k++)
	{
		for(i=0;i<m_Holelayers[k].m_OneHoleLayers.GetSize();i++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[k].m_OneHoleLayers.GetAt(i);
			for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
			{
				CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				if(pSubHoleLayer->m_Deep>=m_HoleDeep[k])continue; 
				CreateHoleLayerSpline(pOneHoleLayer,pSubHoleLayer,k+1,i+1,j+1);
			}
		}
	}
/*	int maxLayer=0;
	for(i=0;i<m_HoleNum-1;i++)
	{
		if(maxLayer<m_Holelayers[i].m_OneHoleLayers.GetSize())
			maxLayer=m_Holelayers[i].m_OneHoleLayers.GetSize();
	}
	if(m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetSize()>maxLayer)
	{
		for(i=maxLayer;i<m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetSize();i++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetAt(i);
			for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
			{
				CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				if(pSubHoleLayer->m_Deep>=m_HoleDeep[m_HoleNum-1])continue;
				pSpline=new CADSpline();
				m_Graphics->m_Entities.Add(pSpline);
				pSpline->m_nLayer=m_LayerGroup->indexOf("0");
				pSpline->m_nLineWidth=2;

				pPoint=new CADPoint();
				pPoint->pt.x=m_HolePoints[m_HoleNum-1].x-2*m_xScale;
				pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
				pPoint=new CADPoint();
				pPoint->pt.x=m_HolePoints[m_HoleNum-1].x-m_xScale;
				pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
				pPoint=new CADPoint();
				pPoint->pt.x=m_HolePoints[m_HoleNum-1].x;
				pPoint->pt.y=m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
			}
		}
	}*/
}

void CProjectIniFile::CreateHoleLayerLeftSpline(COneHoleLayer* pOldOneHoleLayer,CSubHoleLayer* pOldSubHoleLayer,int holeIndex,int layerIndex,int subLayerIndex)
{
	if(holeIndex<1 || m_HoleNum<2)return;
	for(int i=0;i<holeIndex;i++)
	{
		for(int j=0;j<m_Holelayers[i].m_OneHoleLayers.GetSize();j++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j);
			if(strcmp(pOneHoleLayer->m_ID,pOldOneHoleLayer->m_ID)==0)
			{
				for(int k=0;k<pOneHoleLayer->m_SubHoleLayers.GetSize();k++)
				{
					CSubHoleLayer*pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(k);
					if(strcmp(pSubHoleLayer->m_SubID,pOldSubHoleLayer->m_SubID)==0)
						return;
				}
			}
		}
	}

	if(pOldSubHoleLayer->m_Deep>=m_HoleDeep[holeIndex])return;
	CADSpline* pSpline=new CADSpline();
	m_Graphics->m_Entities.Add(pSpline);
	pSpline->m_nLayer=m_LayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;
	
	double length = m_HolePoints[holeIndex].x - m_HolePoints[holeIndex-1].x;
	length -= LegendWidth*m_xScale;
	if(length<0)length = 0.5*m_xScale;
	else length /=4;
	CADPoint* pPoint;
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[holeIndex].x-length;
	pPoint->pt.y=m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[holeIndex].x-length/2;
	pPoint->pt.y=m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[holeIndex].x;
	pPoint->pt.y=m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
}

void CProjectIniFile::CreateHoleLayerSpline(COneHoleLayer* pOldOneHoleLayer,CSubHoleLayer* pOldSubHoleLayer,int nHole,int nLayer,int nSubLayer)
{
//var
	CADSpline* pSpline;
	CADPoint* pPoint;
	int subIndex;
	int curLayerIndex=m_LayerGroup->indexOf("0");
	//if(m_Holelayers[nHole].m_OneHoleLayers.GetSize()<1)return;
	COneHoleLayer* pOneHoleLayer;
	CSubHoleLayer* pSubHoleLayer;

	for(int i=nHole;i<m_HoleNum;i++)
	{
		for(int j=0;j<m_Holelayers[i].m_OneHoleLayers.GetSize();j++)
		{
			pOneHoleLayer=(COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j);
			if(strcmp(pOneHoleLayer->m_ID,pOldOneHoleLayer->m_ID)!=0)continue;
			for(int k=0;k<pOneHoleLayer->m_SubHoleLayers.GetSize();k++)
			{
				pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(k);
				int oldID=atoi(pOldSubHoleLayer->m_SubID);
				int id=atoi(pSubHoleLayer->m_SubID);
				if(oldID==id)subIndex=k;
				else if(oldID<id)subIndex=k-1;
				else continue;
				if(subIndex==-1)
				{
					double tempY;
					if(j==0)
					{
						tempY=m_HoleHeight[i];
					}
					else
					{
						pOneHoleLayer=(COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j-1);
						pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(pOneHoleLayer->m_SubHoleLayers.GetSize()-1);
						tempY=m_HoleHeight[i]-pSubHoleLayer->m_Deep;
					}
					pSpline=new CADSpline();
					m_Graphics->m_Entities.Add(pSpline);
					pSpline->m_nLayer=curLayerIndex;
					pSpline->m_nLineWidth=2;

					pPoint=new CADPoint();
					pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth;
					pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
					TransPoint(&pPoint->pt);
					pSpline->m_FitPoint.Add(pPoint);
					pPoint=new CADPoint();
					pPoint->pt.x=(m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
					pPoint->pt.y=(m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+tempY)/2;
					TransPoint(&pPoint->pt);
					pSpline->m_FitPoint.Add(pPoint);
					pPoint=new CADPoint();
					pPoint->pt.x=m_HolePoints[i].x;
					pPoint->pt.y=tempY;
					TransPoint(&pPoint->pt);
					pSpline->m_FitPoint.Add(pPoint);					
					return;
				}
				pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(subIndex);
				if(pSubHoleLayer->m_Deep>=m_HoleDeep[i])break;

				pSpline=new CADSpline();
				m_Graphics->m_Entities.Add(pSpline);
				pSpline->m_nLayer=curLayerIndex;
				pSpline->m_nLineWidth=2;

				pPoint=new CADPoint();
				pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth;
				pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
				pPoint=new CADPoint();
				pPoint->pt.x=(m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
				pPoint->pt.y=(m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+m_HoleHeight[i]-pSubHoleLayer->m_Deep)/2;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
				pPoint=new CADPoint();
				pPoint->pt.x=m_HolePoints[i].x;
				pPoint->pt.y=m_HoleHeight[i]-pSubHoleLayer->m_Deep;
				TransPoint(&pPoint->pt);
				pSpline->m_FitPoint.Add(pPoint);
				return;
			}
			//if not find
			subIndex=pOneHoleLayer->m_SubHoleLayers.GetSize()-1;
			pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(subIndex);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[i])break;

			pSpline=new CADSpline();
			m_Graphics->m_Entities.Add(pSpline);
			pSpline->m_nLayer=curLayerIndex;
			pSpline->m_nLineWidth=2;

			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth;
			pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=(m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
			pPoint->pt.y=(m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+m_HoleHeight[i]-pSubHoleLayer->m_Deep)/2;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			pPoint=new CADPoint();
			pPoint->pt.x=m_HolePoints[i].x;
			pPoint->pt.y=m_HoleHeight[i]-pSubHoleLayer->m_Deep;
			TransPoint(&pPoint->pt);
			pSpline->m_FitPoint.Add(pPoint);
			return;
		}
	}

	pSpline=new CADSpline();
	m_Graphics->m_Entities.Add(pSpline);
	pSpline->m_nLayer=m_LayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;

	double width=m_HolePoints[nHole].x-m_HolePoints[nHole-1].x-m_LegendWidth;

	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth;
	pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth+width*3/4/2;
	pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_HolePoints[nHole-1].x+m_LegendWidth+width*3/4;
	pPoint->pt.y=m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(&pPoint->pt);
	pSpline->m_FitPoint.Add(pPoint);
}

void CProjectIniFile::CreateHoleLayerHatch()
{
	int i,j,k;
	for(k=0;k<m_HoleNum;k++)
	{
		for(i=0;i<m_Holelayers[k].m_OneHoleLayers.GetSize();i++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[k].m_OneHoleLayers.GetAt(i);
			COneHoleLayer* pOldOneHoleLayer;
			if(i>0)
				pOldOneHoleLayer=(COneHoleLayer*)m_Holelayers[k].m_OneHoleLayers.GetAt(i-1);
			for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
			{
				CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				if(j==0)
				{
					CADPolyline* pPolyline=new CADPolyline();
					CADPoint* pPoint;
					if(i==0)
					{
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x;
						pPoint->pt.y=m_HoleHeight[k];
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
						pPoint->pt.y=m_HoleHeight[k];
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
						pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x;
						pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						CreateHatch(pSubHoleLayer->m_Lengend,pPolyline);
					}
					else
					{
						CSubHoleLayer* pTempSubHoleLayer=(CSubHoleLayer*)pOldOneHoleLayer->m_SubHoleLayers.GetAt(pOldOneHoleLayer->m_SubHoleLayers.GetSize()-1);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x;
						pPoint->pt.y=m_HoleHeight[k]-pTempSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
						pPoint->pt.y=m_HoleHeight[k]-pTempSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
						pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						pPoint=new CADPoint();
						pPolyline->m_Point.Add(pPoint);  
						pPoint->pt.x=m_HolePoints[k].x;
						pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(&pPoint->pt);
						CreateHatch(pSubHoleLayer->m_Lengend,pPolyline);
					}
				}else
				{
					CSubHoleLayer* pOldSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j-1);
					CADPolyline* pPolyline=new CADPolyline();
					CADPoint* pPoint;
					pPoint=new CADPoint();
					pPolyline->m_Point.Add(pPoint);  
					pPoint->pt.x=m_HolePoints[k].x;
					pPoint->pt.y=m_HoleHeight[k]-pOldSubHoleLayer->m_Deep;
					TransPoint(&pPoint->pt);
					pPoint=new CADPoint();
					pPolyline->m_Point.Add(pPoint);  
					pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
					pPoint->pt.y=m_HoleHeight[k]-pOldSubHoleLayer->m_Deep;
					TransPoint(&pPoint->pt);
					pPoint=new CADPoint();
					pPolyline->m_Point.Add(pPoint);  
					pPoint->pt.x=m_HolePoints[k].x+m_LegendWidth;
					pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
					TransPoint(&pPoint->pt);
					pPoint=new CADPoint();
					pPolyline->m_Point.Add(pPoint);  
					pPoint->pt.x=m_HolePoints[k].x;
					pPoint->pt.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
					TransPoint(&pPoint->pt);
					CreateHatch(pSubHoleLayer->m_Lengend,pPolyline);						
				}
			}
		}
	}	
}

void CProjectIniFile::GetHoleLayerInfo(int nHole)
{
//=================================================================================
//function:得到指定钻孔土层信息
//param:nHole,钻孔号([钻孔1])
//土层信息=①-1,0.6,素填土,①-2,3.3,淤泥,③,6.3,粉质粘土,⑥,9.6,粉土,⑦,14
//土层信息=主层号-亚层号,厚度,填充图案
//=================================================================================
	char str[1000];
	char num[4];
	char keyName[10];

	itoa(nHole+1,num,10);
	strcpy(keyName,"钻孔");
	strcat(keyName,num);		
	GetPrivateProfileString(keyName,"土层信息","",str,1000,m_pFileName);

//var
	char* pdest;
	COneHoleLayer* pOneHoleLayer=NULL;
	CSubHoleLayer* pSubHoleLayer=NULL;
	char* pszTemp = strtok(str, ",");
	bool isFirst=true;

//get other layers info
	while(pszTemp)
	{
		if(!isFirst)
		{
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)return;			
		}
		else isFirst=false;

		pdest=strstr(pszTemp,"-");

		if(pdest != NULL)
		{//sample:①-1
			int  length=pdest-pszTemp;
			char* ch=new char[length+1];
			memcpy(ch,pszTemp,length);
			ch[length]='\0';
			if(pOneHoleLayer==NULL)
			{
				pOneHoleLayer = new COneHoleLayer();
				m_Holelayers[nHole].m_OneHoleLayers.Add(pOneHoleLayer);
			}
			else if(strcmp(ch,pOneHoleLayer->m_ID)!=0)//if two mail layer is different(1-1,2-1)
			{
				pOneHoleLayer = new COneHoleLayer();
				m_Holelayers[nHole].m_OneHoleLayers.Add(pOneHoleLayer);
			}
			strcpy(pOneHoleLayer->m_ID,ch);//main layer id

			pSubHoleLayer=new CSubHoleLayer();
			length=strlen(pszTemp)-length-1;
			ch=new char[length+1];
			memcpy(ch,pdest+1,length);
			ch[length]='\0';
			strcpy(pSubHoleLayer->m_SubID,ch);//sub layer id
		}
		else
		{//sample:①
			if(pOneHoleLayer==NULL)
			{
				pOneHoleLayer=new COneHoleLayer();
				m_Holelayers[nHole].m_OneHoleLayers.Add(pOneHoleLayer);
			}
			else if(strcmp(pszTemp,pOneHoleLayer->m_ID)!=0)
			{
				pOneHoleLayer=new COneHoleLayer();
				m_Holelayers[nHole].m_OneHoleLayers.Add(pOneHoleLayer);
			}
			pSubHoleLayer=new CSubHoleLayer();
			strcpy(pOneHoleLayer->m_ID,pszTemp);
			strcpy(pSubHoleLayer->m_SubID,"");// default sub layer id
		}

		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;
		pSubHoleLayer->m_Deep = atof(pszTemp);
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)return;
		strcpy(pSubHoleLayer->m_Lengend,pszTemp);
		pOneHoleLayer->m_SubHoleLayers.Add(pSubHoleLayer);
	}
}

void CProjectIniFile::CreateHatch(char* LegendName,CADPolyline* pPolyline)
{
//check special legend---------------------
	short SpecialLegendCount = 5;
	char* SpecialLegend[] = {"粉砂","细砂","中砂","粗砂","砾砂"};
	char  SpecialLegendChar[] = {'f','x','z','c','l'};

	int legendCharIndex = -1;
	for(int i=0;i<=SpecialLegendCount-1;i++)
	{
		if(strcmp(LegendName,SpecialLegend[i])==0)
		{
			strcpy(LegendName,"砂");
			legendCharIndex = i;
			break;
		}
	}
//-----------------------------------------
	char LegendFile2[255];
	GetAppDir(LegendFile2);
	strcat(LegendFile2,"ACADISO.PAT");

	FILE* fp;
	fp=fopen(LegendFile2,"r");
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
				m_Graphics->m_Entities.Add(pHatch);
				pHatch->m_Scale = 10;
				pHatch->m_nLayer=m_LayerGroup->indexOf("0");
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
					m_Graphics->m_Entities.Add(pMText);
					pMText->m_nLayer=m_LayerGroup->indexOf("0");
					pMText->m_Text=SpecialLegendChar[legendCharIndex];
					pMText->m_Height=2.5;
					pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
					CADPoint* pPoint = (CADPoint*)pPolyline->m_Point.GetAt(0);
					pMText->m_Location.x = pPoint->pt.x;
					pMText->m_Location.y = pPoint->pt.y;
					pPoint = (CADPoint*)pPolyline->m_Point.GetAt(1);
					pMText->m_Location.x += pPoint->pt.x;
					pMText->m_Location.x /= 2;
					pPoint = (CADPoint*)pPolyline->m_Point.GetAt(2);
					pMText->m_Location.y += pPoint->pt.y;
					pMText->m_Location.y /= 2;
				}
				//----------------------------------------------
				return;
			}
		}
	}
}

void CProjectIniFile::CreateHatchLine(char* hatchLineStr,CADHatch* pHatch)
{
	CADHatchLine* pHatchLine=new CADHatchLine();
	pHatch->m_HatchLines.Add(pHatchLine);

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
	//pHatchLine->m_xOffset=atof(pszTemp)*pHatch->m_Scale;
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	tempDy = atof(pszTemp)*pHatch->m_Scale;
	//pHatchLine->m_yOffset=atof(pszTemp)*pHatch->m_Scale;
	pHatchLine->m_xOffset = tempDx*cos(pHatchLine->m_Angle*PI/180) - tempDy*sin(pHatchLine->m_Angle*PI/180);
	pHatchLine->m_yOffset = tempDy*cos(pHatchLine->m_Angle*PI/180) + tempDx*sin(pHatchLine->m_Angle*PI/180);
/*	pHatchLine->m_BasePoint.x=atof(pszTemp);
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_BasePoint.y=atof(pszTemp);
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_xOffset=atof(pszTemp);
	pszTemp = strtok(NULL, ",");
	if(pszTemp==NULL)return;
	pHatchLine->m_yOffset=atof(pszTemp);*/

	pHatchLine->m_NumDash=0;
	pszTemp = strtok(NULL, ",");
	double doubleTemp;
	double curPos=0;
	pHatchLine->m_NumDash=0;
	while(pszTemp)
	{
		doubleTemp=atof(pszTemp)*pHatch->m_Scale;
		//doubleTemp=atof(pszTemp);
		if(pHatchLine->m_NumDash<HATCHITEMS)
			pHatchLine->m_Items[pHatchLine->m_NumDash]=doubleTemp;
		pHatchLine->m_NumDash++;
	/*	if(atof(pszTemp)<0)
		{
			curPos+=-doubleTemp;		
		}else
		{
			CADLine* pLine=new CADLine();
			pLine->pt1.x=curPos;
			pLine->pt1.y=0;
			curPos+=doubleTemp;
			pLine->pt2.x=pLine->pt1.x+doubleTemp;
			pLine->pt2.y=0;
			pHatchLine->m_Lines.Add(pLine);			
		}*/
		pszTemp=strtok(NULL, ",");
	}
/*	if(curPos>0)
	{
		double scale=m_LegendWidth/(curPos*3);
		pHatchLine->m_BasePoint.x*=scale;
		pHatchLine->m_BasePoint.y*=scale;
		pHatchLine->m_xOffset*=scale;
		pHatchLine->m_yOffset*=scale;
		for(int i=0;i<pHatchLine->m_Lines.GetSize();i++)
		{
			CADLine* pLine=(CADLine*)pHatchLine->m_Lines.GetAt(i);			
			pLine->pt1.x*=scale;
			pLine->pt2.x*=scale;
		}
	}*/
	return;
}

void CProjectIniFile::CreateHoleGrid()
{
	CADPoint* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	int i;

	double gridLeft,gridTop,gridHeight,gridRight,gridBottom;
	gridLeft=m_FrameLeft+3.5;
	gridTop=m_FrameTop-m_FrameHeight+2+m_LabelGridHegiht+3+m_HoleGridHeight;
	gridHeight=m_HoleGridHeight;//13
	gridRight=m_HolePoints[m_HoleNum-1].x;
	gridRight=gridRight*1000/m_hScale;
	gridBottom=gridTop-gridHeight;

	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=m_LayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	m_Graphics->m_Entities.Add(pPolyline);

	pPoint=new CADPoint();
	pPoint->pt.x=gridLeft;
	pPoint->pt.y=gridTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridRight;
	pPoint->pt.y=gridTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridRight;
	pPoint->pt.y=gridBottom;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridLeft;
	pPoint->pt.y=gridBottom;
	pPolyline->m_Point.Add(pPoint);

	CADLine* pLine;
	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft;
	pLine->pt1.y=gridTop-3;
	pLine->pt2.x=gridRight;
	pLine->pt2.y=gridTop-3;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="qc(ps) (MPa)";
	pMText->m_Height=2.5;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3;
	//TransPoint(&pMText->m_Location);

	//CADLine* pLine;
	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft;
	pLine->pt1.y=gridTop-3*2;
	pLine->pt2.x=gridRight;
	pLine->pt2.y=gridTop-3*2;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="fs  (kPa)";
	pMText->m_Height=2.5;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3*2;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+20;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="钻孔间距(m)";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3*2-3.5;

	double fontTop=gridTop-3*2-3.5;

	for(i=0;i<m_HoleNum-1;i++)
	{
		pLine=new CADLine();
		m_Graphics->m_Entities.Add(pLine);
		pLine->m_nLayer=m_LayerGroup->indexOf("0");
		pLine->pt1.x=m_HolePoints[i].x;
		pLine->pt1.y=0;
		pLine->pt2.x=pLine->pt1.x;
		pLine->pt2.y=0;
		TransPoint(&pLine->pt1);
		TransPoint(&pLine->pt2);
		pLine->pt1.y=gridTop;
		pLine->pt2.y=gridBottom;
		pMText=new CADMText();
		m_Graphics->m_Entities.Add(pMText);
		pMText->m_nLayer=m_LayerGroup->indexOf("0");
		pMText->m_Text.Format("%.2lf",m_HolePoints[i+1].x-m_HolePoints[i].x);
		pMText->m_Height=3;
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Location.x=(m_HolePoints[i].x+m_HolePoints[i+1].x)/2;
		pMText->m_Location.y=0;
		TransPoint(&pMText->m_Location);
		pMText->m_Location.y=gridTop-3*2-3.5;
	}
}

void CProjectIniFile::CreateLabelGrid()
{
	CADPoint* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;

	double gridLeft,gridTop,gridHeight,gridRight,gridBottom;
	gridLeft=m_FrameLeft+1;
	gridTop=m_FrameTop-m_FrameHeight+2+7;
	gridHeight=m_LabelGridHegiht;//7
	gridRight=m_FrameLeft+m_FrameWidth-1;
	gridBottom=gridTop-gridHeight;

	double fontTop=gridTop-3.5;

	pPolyline=new CADPolyline();
	pPolyline->m_nLayer=m_LayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	m_Graphics->m_Entities.Add(pPolyline);

	pPoint=new CADPoint();
	pPoint->pt.x=gridLeft;
	pPoint->pt.y=gridTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridRight;
	pPoint->pt.y=gridTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridRight;
	pPoint->pt.y=gridBottom;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=gridLeft;
	pPoint->pt.y=gridBottom;
	pPolyline->m_Point.Add(pPoint);
	
	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text=m_ProjectID;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+12;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text=m_ProjectName;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=gridLeft+24+3;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="编 制";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17/2;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();//编制(right)
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="复 核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17+24+17/2;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();//复核(right)
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="审 核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17+24+17+24+17/2;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();//审核(right)
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24+17;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24+17+24;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="图 表 号";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17+24+17+24+17+24+17/2;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();//图表号(right)
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24+17+24+17;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pLine=new CADLine();
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24+17+24+17+14;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text="第   张 共   张";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17+24+17+24+17+24+17+14+30/2;
	pMText->m_Location.y=fontTop;

	pLine=new CADLine();//第 张(right)
	m_Graphics->m_Entities.Add(pLine);
	pLine->m_nLayer=m_LayerGroup->indexOf("0");
	pLine->pt1.x=gridLeft+24+91+17+24+17+24+17+24+17+14+30;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Text=Maker;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=gridLeft+24+91+17+24+17+24+17+24+17+14+30+44/2;
	pMText->m_Location.y=fontTop;
}

void CProjectIniFile::CreateHoleHeightText()
{
//	CADPoint* pPoint;
//	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;

	for(int i=0;i<m_HoleNum;i++)
	{
		pMText=new CADMText();
		m_Graphics->m_Entities.Add(pMText);
		pMText->m_nLayer=m_LayerGroup->indexOf("0");
		pMText->m_Text=m_HoleID[i];
		pMText->m_Height=2.5;
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x=m_HolePoints[i].x;
		pMText->m_Location.y=m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pMText->m_Location);

		pLine=new CADLine();
		m_Graphics->m_Entities.Add(pLine);
		pLine->m_nLayer=m_LayerGroup->indexOf("0");
		pLine->pt1.x=m_HolePoints[i].x-0.4*m_xScale;
		pLine->pt1.y=m_HoleHeight[i]+0.6*m_yScale;
		pLine->pt2.x=m_HolePoints[i].x+0.4*m_xScale;
		pLine->pt2.y=m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pLine->pt1);
		TransPoint(&pLine->pt2);

		pMText=new CADMText();
		m_Graphics->m_Entities.Add(pMText);
		pMText->m_nLayer=m_LayerGroup->indexOf("0");
		pMText->m_Text.Format("%.2lf",m_HoleHeight[i]);
		pMText->m_Height=2.5;
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x=m_HolePoints[i].x;
		pMText->m_Location.y=m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pMText->m_Location);
	}
}

void CProjectIniFile::CreateHoleLayerText()
{
	int i,j,k;
	CADMText* pMText;
	for(k=0;k<m_HoleNum;k++)
	{
		for(i=0;i<m_Holelayers[k].m_OneHoleLayers.GetSize();i++)
		{
			COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[k].m_OneHoleLayers.GetAt(i);
			for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
			{
				CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				pMText=new CADMText();
				m_Graphics->m_Entities.Add(pMText);
				pMText->m_nLayer=m_LayerGroup->indexOf("0");
				pMText->m_Text.Format("%.2lf",pSubHoleLayer->m_Deep);
				pMText->m_Height=2.5;
				pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
				pMText->m_Location.x=m_HolePoints[k].x+0.1*m_xScale;
				pMText->m_Location.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
				TransPoint(&pMText->m_Location);

				pMText=new CADMText();
				m_Graphics->m_Entities.Add(pMText);
				pMText->m_nLayer=m_LayerGroup->indexOf("0");
				pMText->m_Text.Format("(%.2lf)",(m_HoleHeight[k]-pSubHoleLayer->m_Deep));
				pMText->m_Height=2.5;
				pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
				pMText->m_Location.x=m_HolePoints[k].x;
				pMText->m_Location.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
				TransPoint(&pMText->m_Location);

			}
		}
	}			
}

void CProjectIniFile::TransPoint(ADPOINT* pPoint)
{
	pPoint->x=pPoint->x*1000/m_hScale;
	pPoint->y=pPoint->y*1000/m_vScale;
}

void CProjectIniFile::CreateChartFrame()
{
	CADPolyline* pPolyline;
	CADPoint* pPoint;
	pPolyline=new CADPolyline();
	m_Graphics->m_Entities.Add(pPolyline);
	pPolyline->m_nLayer=m_LayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth=10;

	pPoint=new CADPoint();
	pPoint->pt.x=m_FrameLeft;
	pPoint->pt.y=m_FrameTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_FrameLeft+m_FrameWidth;
	pPoint->pt.y=m_FrameTop;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_FrameLeft+m_FrameWidth;
	pPoint->pt.y=m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=m_FrameLeft;
	pPoint->pt.y=m_FrameTop-m_FrameHeight;
	pPolyline->m_Point.Add(pPoint);
}

void CProjectIniFile::CreateChartHeader()
{
	//生成图纸名称
	char str[255];
	CADMText* pMText;
	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	GetPrivateProfileString("图纸信息","图纸名称","",str,255,m_pFileName);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=7;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2;
	pMText->m_Location.y=m_FrameTop-6;

	//CADMText* pMText;
	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Text="比例尺";
	strcpy(pMText->m_Font,"楷体_GB2312"); 
	pMText->m_Height=3;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2-5;
	pMText->m_Location.y=m_FrameTop-6-7-5;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text.Format("水平 1: %d",m_hScale);
	strcpy(pMText->m_Font,"楷体_GB2312"); 
	pMText->m_Height=3;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2+5;
	pMText->m_Location.y=m_FrameTop-6-7-3;

	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text.Format("垂直 1: %d",m_vScale);
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2+5;
	pMText->m_Location.y=m_FrameTop-6-7-3-4;	
}

void CProjectIniFile::CreateChartRuler()
{
	//生成标尺
	double perRuler=m_yScale;//unit(m)
	double curAddRuler=0;
	double rulerX,rulerY,rulerWidth;
	rulerX=m_Graphics->m_Extmin.x+m_xScale;
	rulerY=m_RulerTop;
	rulerWidth=perRuler/5*m_xScale/m_yScale;
	CADSolid* pSolid;
	CString str2;
	while((m_RulerTop-curAddRuler)>m_HoleBottom)
	{
		if((int)(curAddRuler/perRuler)%2==0)
		{
			pSolid=new CADSolid();
			m_Graphics->m_Entities.Add(pSolid);
			pSolid->m_nColor=7;
			pSolid->m_nLayer=m_LayerGroup->indexOf("0");
			pSolid->m_pt0.x=rulerX;
			pSolid->m_pt0.y=rulerY-curAddRuler;
			TransPoint(&pSolid->m_pt0);
			pSolid->m_pt1.x=rulerX+rulerWidth;
			pSolid->m_pt1.y=rulerY-curAddRuler;
			TransPoint(&pSolid->m_pt1);
			pSolid->m_pt2.x=rulerX;
			pSolid->m_pt2.y=rulerY-curAddRuler-perRuler;
			TransPoint(&pSolid->m_pt2);
			pSolid->m_pt3.x=rulerX+rulerWidth;
			pSolid->m_pt3.y=rulerY-curAddRuler-perRuler;
			TransPoint(&pSolid->m_pt3);

			CADMText* pMText;
			pMText=new CADMText();
			m_Graphics->m_Entities.Add(pMText);
			pMText->m_nLayer=m_LayerGroup->indexOf("0");
			str2.Format("%.1lf",rulerY-curAddRuler); 
			pMText->m_Text=str2;
			pMText->m_Height=3;
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
			pMText->m_Location.x=rulerX;
			pMText->m_Location.y=rulerY-curAddRuler;
			TransPoint(&pMText->m_Location);	
		}
		curAddRuler+=perRuler;
	}
	m_RulerBottom=m_RulerTop-curAddRuler;
	CADMText* pMText;
	pMText=new CADMText();
	m_Graphics->m_Entities.Add(pMText);
	pMText->m_nLayer=m_LayerGroup->indexOf("0");
	str2.Format("%.1lf",rulerY-curAddRuler); 
	pMText->m_Text=str2;
	pMText->m_Height=3;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
	pMText->m_Location.x=rulerX;
	pMText->m_Location.y=rulerY-curAddRuler;
	TransPoint(&pMText->m_Location);

	double m_HoleBottom2=m_RulerTop-curAddRuler;
	CADPolyline* pPolyline=new CADPolyline();
	pPolyline->m_nLayer=m_LayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	m_Graphics->m_Entities.Add(pPolyline);

	CADPoint* pPoint;
	pPoint=new CADPoint();
	pPoint->pt.x=rulerX;
	pPoint->pt.y=rulerY;
	TransPoint(&pPoint->pt);
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=rulerX+rulerWidth;
	pPoint->pt.y=rulerY;
	TransPoint(&pPoint->pt);
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=rulerX+rulerWidth;
	pPoint->pt.y=m_HoleBottom2;
	TransPoint(&pPoint->pt);
	pPolyline->m_Point.Add(pPoint);
	pPoint=new CADPoint();
	pPoint->pt.x=rulerX;
	pPoint->pt.y=m_HoleBottom2;
	TransPoint(&pPoint->pt);
	pPolyline->m_Point.Add(pPoint);	
}

void CProjectIniFile::CreateLandInfo(char* pLandInfoStr,int i)
{
	char* pszTemp = strtok(pLandInfoStr, ",");
	while(pszTemp)
	{
		CADHatch* pHatch=new CADHatch();
		m_Graphics->m_Entities.Add(pHatch);
		pHatch->m_bSolidFill=true;
		pHatch->m_nLayer=0;
		strcpy(pHatch->m_Name,"取样点");
		CADPolyline* pPolyline;
		pPolyline=new CADPolyline();
		pPolyline->m_nLayer=0;
		pPolyline->m_Closed=true; 
		pPolyline->m_pElevation=new double[2];
		pPolyline->m_pElevation[0]=1.0;
		pPolyline->m_pElevation[1]=1.0;
		pHatch->m_Paths.Add(pPolyline);

		CADPoint* pPoint;
		pPoint=new CADPoint();
		pPoint->pt.x=m_HolePoints[i].x-0.3*m_xScale+0.06*m_xScale;
		pPoint->pt.y=m_HoleHeight[i]-atof(pszTemp);
		TransPoint(&pPoint->pt);
		pPolyline->m_Point.Add(pPoint);

		pPoint=new CADPoint();
		pPoint->pt.x=m_HolePoints[i].x-0.3*m_xScale-0.06*m_xScale;
		pPoint->pt.y=m_HoleHeight[i]-atof(pszTemp);
		TransPoint(&pPoint->pt);
		pPolyline->m_Point.Add(pPoint);
		
		pszTemp=strtok(NULL, ",");
	}
}

void CProjectIniFile::CreateGradeInfo(char* pGradeInfoStr,int i)
{
	char* pszTemp = strtok(pGradeInfoStr, ",");
	while(pszTemp)
	{
		CADMText* pMText;
		pMText=new CADMText();
		m_Graphics->m_Entities.Add(pMText);
		pMText->m_nLayer = m_LayerGroup->indexOf("0");
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Height = 2.5;
		pMText->m_Width = 3;
		pMText->m_Location.x = m_HolePoints[i].x-0.4*m_xScale;
		pMText->m_Location.y = m_HoleHeight[i]-atof(pszTemp);
		TransPoint(&pMText->m_Location);

		pszTemp=strtok(NULL, ",");
		if(pszTemp == NULL)return;

		pMText->m_Text = pszTemp;
		pszTemp = strtok(NULL, ",");
	}
}

void CProjectIniFile::CalHorizontalCoord()
{
	double* spaceBetween=new double[m_HoleNum-1];
	int i;
	for(i=0;i<m_HoleNum-1;i++)
	{
		spaceBetween[i]=sqrt((m_HolePoints[i+1].x-m_HolePoints[i].x)*(m_HolePoints[i+1].x-m_HolePoints[i].x)+(m_HolePoints[i+1].y-m_HolePoints[i].y)*(m_HolePoints[i+1].y-m_HolePoints[i].y));
	}

	for(i=0;i<m_HoleNum-1;i++)
	{
		m_HolePoints[i+1].x=m_HolePoints[i].x+spaceBetween[i];
	}
}

void CProjectIniFile::CreateLayerFlag()
{
//for example :create ①1
	//unsigned short middleHole = (unsigned short)((float)m_HoleNum/2 + 0.5);
	if (m_HoleNum<=1) return;
	unsigned short middleHoleIndex = m_HoleNum/2;
	short apartHole = 0;
	short curHoleIndex;
	short fitHoleIndex;
	int i,j;
/*	for (i=0;i<m_HoleNum;i++)
	{
		curHoleIndex = 0;
		if(0==i)
		{
			COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(i);
			int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
			for(j=0;j<subSize;j++)
			{
				CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				
			}

		}
	}*/

	int maxLayerHoleIndex=0;
	int maxLayer=0;

	for (i=0;i<m_HoleNum;i++)
	{
		if(maxLayer<m_Holelayers[i].m_OneHoleLayers.GetSize())
		{
			maxLayer=m_Holelayers[i].m_OneHoleLayers.GetSize();
			maxLayerHoleIndex=i;
		}
	}

	double spaceX;
	if (maxLayerHoleIndex == m_HoleNum-1)spaceX=-0.3*m_xScale;
	else spaceX = m_LegendWidth+0.3*m_xScale;

	CSubHoleLayer* pOldSubHoleLayer = NULL;
	for (i=0;i<m_Holelayers[maxLayerHoleIndex].m_OneHoleLayers.GetSize();i++)
	{
		COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[maxLayerHoleIndex].m_OneHoleLayers.GetAt(i);
		int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
		for(j=0;j<subSize;j++)
		{
			CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);

			CString str = "Layer";
			str += pOneHoleLayer->m_ID;
			if(subSize>1)
			{
				str += "-";
				str += pSubHoleLayer->m_SubID;
			}

			int index=m_Graphics->IndexOfBlocks((LPCTSTR)str);
			if(index==-1)
			{
				CADBlock* pBlock;
				pBlock = new CADBlock();
				CADGraphics::CreateHandle(pBlock->m_Handle2);
				m_Graphics->m_Blocks.Add(pBlock);
				pBlock->m_nLayer = 0; 
				strcpy(pBlock->m_Name,(LPCTSTR)str);
				pBlock->m_BasePoint.x = 0;
				pBlock->m_BasePoint.y = 0;

				CADBlockRecord* pBlockRecord = new CADBlockRecord();
				m_Graphics->m_BlockRecords.Add(pBlockRecord);
				strcpy(pBlockRecord->m_Name,pBlock->m_Name);
				CADGraphics::CreateHandle(pBlockRecord->m_Handle);
				
				CADCircle* pCircle;;
				pCircle = new CADCircle();
				pCircle->m_nLayer = 0;
				pBlock->m_Entities.Add(pCircle);
				pCircle->m_nColor = 7;
				pCircle->ptCenter.x = 0;
				pCircle->ptCenter.y = 0;
				pCircle->m_Radius = 1.5;

				CADMText* pMText;
				pMText = new CADMText();
				pMText->m_nLayer = 0;
				pBlock->m_Entities.Add(pMText);
				pMText->m_nColor = 7;
				pMText->m_Location.x = 0;

				pMText->m_Text=pOneHoleLayer->m_ID;
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
				pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;

				if(subSize>1)
				{
					CADMText* pMText;
					pMText=new CADMText();
					pMText->m_nLayer=0;
					pBlock->m_Entities.Add(pMText);
					pMText->m_nColor=7;
					pMText->m_Location.x=2;
					pMText->m_Location.y=0;
					pMText->m_Text=pSubHoleLayer->m_SubID;
					pMText->m_Height=2;
					pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT; 			
				}
			}

			CADInsert *pInsert=new CADInsert();
			m_Graphics->m_Entities.Add(pInsert);
			pInsert->m_nLayer=0;
			strcpy(pInsert->m_Name,(LPCTSTR)str);
			pInsert->pt.x=m_HolePoints[maxLayerHoleIndex].x+spaceX;
			if(i==0 && j==0)
				pInsert->pt.y=(2*m_HoleHeight[maxLayerHoleIndex]-pSubHoleLayer->m_Deep)/2;
			else if(pOldSubHoleLayer)
				pInsert->pt.y=(2*m_HoleHeight[maxLayerHoleIndex]-pOldSubHoleLayer->m_Deep-pSubHoleLayer->m_Deep)/2;
			else
				pInsert->pt.y=m_HoleHeight[maxLayerHoleIndex]-pSubHoleLayer->m_Deep+0.1*m_yScale;
			TransPoint(&pInsert->pt);
			pInsert->m_xScale=1;
			pInsert->m_yScale=1;
			pInsert->m_Rotation=0;
			pOldSubHoleLayer=pSubHoleLayer;
		}
	}
}