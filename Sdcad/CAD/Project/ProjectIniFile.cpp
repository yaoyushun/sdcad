#include "stdafx.h"
#include "ProjectIniFile.h"
#include "..\FunctionLib\Function_System.h"

#define LegendWidth 0.8//cm
#define FONTSTYLE "黑体"
#define HOLEDEEPFONTHEIGHT 3//mm

CProjectIniFile::CProjectIniFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
	m_bPrintStatic = false;
}

CProjectIniFile::~CProjectIniFile()
{

}

void CProjectIniFile::FileImport(LPCTSTR lpFilename)
{
	m_pFileName=lpFilename;
	const short MaxLength = 2048;
	char str[2048];
	m_HoleNum=::GetPrivateProfileInt("钻孔","个数",0,lpFilename);
	if(m_HoleNum==0)return;
///	m_LayerNum=::GetPrivateProfileInt("钻孔","最大层数",0,lpFilename);
///	if(m_LayerNum==0)return;

	m_hScale=::GetPrivateProfileInt("比例尺","X",0,lpFilename);
	if(m_hScale==0)return;
	m_vScale=::GetPrivateProfileInt("比例尺","Y",0,lpFilename);
	if(m_vScale==0)return;
	
	m_Orient=::GetPrivateProfileInt("比例尺","打印方向",1,lpFilename);
	if (m_Orient==1)
		m_pGraphics->m_PaperOrient=HORIZONTAL;
	else
		m_pGraphics->m_PaperOrient=VERTICAL;

	if (::GetPrivateProfileInt("比例尺","是否打印静探",0,lpFilename) == 1)
		m_bPrintStatic = true;
	else
		m_bPrintStatic = false;

	m_xScale = (float)m_hScale/100;
	m_yScale = (float)m_vScale/100;

	//added on 2006/12/19
	GetPrivateProfileString("比例尺","静探曲线比例","",str,255,lpFilename);
	if (str=="")
		m_StaticCurveScale = 1;
	else
		m_StaticCurveScale = atoi(str);//静探曲线比例
	if (m_StaticCurveScale<0.00000001)
		m_StaticCurveScale = 1;

	//m_xScale2=1000/m_hScale;
	//m_yScale2=1000/m_vScale;

	//double perRuler=10;//unit(mm)

	::GetPrivateProfileString("图纸信息","工程名称","",m_ProjectName,255,lpFilename);
	::GetPrivateProfileString("图纸信息","工程编号","",m_ProjectID,255,lpFilename);

	m_Holelayers = new CHoleLayer[m_HoleNum];
	m_HoleID = new char*[m_HoleNum];//孔口编号
	m_HoleHeight = new double[m_HoleNum];//孔口标高
	m_HoleDeep = new double[m_HoleNum];//孔深
	m_HolePoints = new ADPOINT[m_HoleNum];//孔口坐标
	m_LegendWidth = LegendWidth * m_xScale;

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

	//判断孔口坐标X是坐标还是距离
//	short isCoord = ::GetPrivateProfileInt("钻孔","是否坐标",0,lpFilename);
//	if (isCoord==1)
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
		GetPrivateProfileString(keyName,"标贯信息","",str,MaxLength,lpFilename);
		CreateGradeInfo(str,i);	
		
		GetPrivateProfileString(keyName,"动力触探信息","",str,255,lpFilename);
		CreateGradeInfo2Ex(str,i);
	}
	
	//m_HoleBottom-=1;

	//生成剖面水平线(钻孔层)
	CreateHoleLayer();
	/////////////////////////////////////////////////////////////////////////////
	//生成剖面水平线(1层--n层)

	//setup height
	m_HoleGridHeight = 13 + 7;//2004-06-22
	m_LabelGridHegiht=7;
	m_HoleGridSpace=2*m_yScale;
	m_LabelGridSpace=0.4*m_yScale;

	double width,height,leftMargin,topMargin;
	double rightMargin,bottomMargin;

	width = m_HolePoints[m_HoleNum-1].x-m_HolePoints[0].x;
	height = m_RulerTop - m_HoleBottom;

	leftMargin=2.5*m_xScale+3.5*m_xScale;
	//topMargin=4.5*m_yScale;
	topMargin = 45;
	rightMargin=2.5*m_xScale+2.5*m_xScale;
	//bottomMargin=(2+1.3+0.4+0.7+0.2)*m_yScale;
	bottomMargin = (2+1.3+0.4+0.7+0.2)*10;

	//m_RulerLeft = m_HolePoints[0].x - leftMargin + m_xScale;
//-----------------------------------------------------------
	double MarginLeft=33,MarginTop=20,MarginRight=33,MarginBottom=20;//unit(mm)
	double holeWidth;//mm
	ADPOINT adPoint,adPoint2;
	adPoint.x = m_HolePoints[0].x;
	adPoint.y = m_RulerTop;
	TransPoint(&adPoint);
	adPoint2.x = m_HolePoints[m_HoleNum-1].x;
	adPoint2.y = m_RulerTop;
	TransPoint(&adPoint2);
	holeWidth = fabs(adPoint2.x - adPoint.x) + 25 * 2;

	double paperWidth , paperHeight;
	int paperType=::GetPrivateProfileInt("比例尺","打印尺寸",1,lpFilename);
	switch(paperType)
	{
		case 0:
			m_PaperType = PAPER_A0;
			paperWidth = A0_WIDTH;
			paperHeight = A0_HEIGHT;
			break;
		case 1:
			m_PaperType = PAPER_A1;
			paperWidth = A1_WIDTH;
			paperHeight = A1_HEIGHT;
			break;
		case 2:
			m_PaperType = PAPER_A2;
			paperWidth = A2_WIDTH;
			paperHeight = A2_HEIGHT;
			break;
		case 3:
			m_PaperType = PAPER_A3;
			paperWidth = A3_WIDTH;
			paperHeight = A3_HEIGHT;
			break;
		case 4:
			m_PaperType = PAPER_A4;
			paperWidth = A4_WIDTH;
			paperHeight = A4_HEIGHT;
			break;
		default:
			m_PaperType = PAPER_Auto;
			paperWidth = holeWidth + 35 + 25 + MarginLeft + MarginRight;
			paperHeight = height * 1000 / m_vScale + topMargin + bottomMargin + MarginBottom + MarginTop;
			m_Orient = 1;
			break;
	}

	//CString str2;
	//str2.Format("%lf",height * 1000 / m_hScale);
	//::AfxMessageBox(str2);

	if (m_Orient!=1)
	{
		double temp = paperWidth;
		paperWidth = paperHeight;
		paperHeight = temp;
	}

	if ((paperWidth - holeWidth) < MarginLeft + MarginRight)
	{
		m_pGraphics->m_Extmin.x = adPoint.x - 35 - 25- MarginLeft;
		m_pGraphics->m_Extmax.y = adPoint.y + 45 + MarginTop;
		m_FrameLeft = m_pGraphics->m_Extmin.x + MarginLeft;
		m_FrameTop = adPoint.y + 45;
	}
	else
	{
		m_pGraphics->m_Extmin.x = adPoint.x - (paperWidth - holeWidth)/2 - 25;
		m_pGraphics->m_Extmax.y = adPoint.y + 45 + MarginTop;
		m_FrameLeft = m_pGraphics->m_Extmin.x + MarginLeft;
		m_FrameTop = adPoint.y + 45;
	}

	m_RulerLeft = m_FrameLeft * m_hScale /1000 + m_xScale;

	m_pGraphics->m_Extmax.x = m_pGraphics->m_Extmin.x + paperWidth;
	m_pGraphics->m_Extmin.y = m_pGraphics->m_Extmax.y - paperHeight;

/*	adPoint.x = m_HolePoints[0].x-leftMargin;
	adPoint.y = m_RulerTop+topMargin;
	m_pGraphics->m_Extmin.x = adPoint.x - MarginLeft*m_xScale;
	m_pGraphics->m_Extmax.y = adPoint.y + MarginTop*m_yScale;
	TransPoint(&m_pGraphics->m_Extmin);
	TransPoint(&m_pGraphics->m_Extmax);

	TransPoint(&adPoint);
	m_FrameLeft=adPoint.x;
	m_FrameTop=adPoint.y;

	adPoint.x = m_HolePoints[0].x + width + rightMargin;
	adPoint.y = m_RulerTop-height-bottomMargin;
	TransPoint(&adPoint);
	m_pGraphics->m_Extmax.x=adPoint.x+MarginRight*10;
	m_pGraphics->m_Extmin.y=adPoint.y-MarginBottom*10;

	double paperWidth , paperHeight;
	paperWidth = m_pGraphics->m_Extmax.x - m_pGraphics->m_Extmin.x;
	paperHeight = m_pGraphics->m_Extmax.y - m_pGraphics->m_Extmin.y;

	int paperType=::GetPrivateProfileInt("比例尺","打印尺寸",1,lpFilename);
	switch(paperType)
	{
		case 0:
			m_PaperType = PAPER_A0;
			paperWidth = A0_WIDTH;
			paperHeight = A0_HEIGHT;
			break;
		case 1:
			m_PaperType = PAPER_A1;
			paperWidth = A1_WIDTH;
			paperHeight = A1_HEIGHT;
			break;
		case 2:
			m_PaperType = PAPER_A2;
			paperWidth = A2_WIDTH;
			paperHeight = A2_HEIGHT;
			break;
		case 3:
			m_PaperType = PAPER_A3;
			paperWidth = A3_WIDTH;
			paperHeight = A3_HEIGHT;
			break;
		case 4:
			m_PaperType = PAPER_A4;
			paperWidth = A4_WIDTH;
			paperHeight = A4_HEIGHT;
			break;
		default:
			m_PaperType = PAPER_Auto;
			m_Orient = 1;
			break;
	}
	if (m_Orient==1)
	{
		m_pGraphics->m_Extmax.x = m_pGraphics->m_Extmin.x + paperWidth;
		m_pGraphics->m_Extmin.y = m_pGraphics->m_Extmax.y - paperHeight;
	}
	else
	{
		m_pGraphics->m_Extmax.x = m_pGraphics->m_Extmin.x + paperHeight;
		m_pGraphics->m_Extmin.y = m_pGraphics->m_Extmax.y - paperWidth;	
	}*/

	m_FrameWidth = m_pGraphics->m_Extmax.x - m_pGraphics->m_Extmin.x - MarginLeft - MarginRight;
	m_FrameHeight = m_pGraphics->m_Extmax.y - m_pGraphics->m_Extmin.y - MarginTop - MarginBottom;
//--------------------------------------------------------------	
	CreateChartFrame();	
	CreateChartHeader();
	CreateChartRuler();	
	CreateAllHoleLayer();
	CreateHoleLayerHatch();
	//创建钻孔间距表格
	//create label grid
	CreateHoleGrid(lpFilename);
	CreateChartFooter(lpFilename);//foot
	CreateHoleHeightText();
	CreateHoleLayerText();
	CreateLayerFlag();
	if (m_bPrintStatic)
		CreateStaticCurve();
	CreateWaterLine(lpFilename);

//--------------------------------------------------------------

/*	TransPoint(&m_pGraphics->m_Extmin);
	TransPoint(&m_pGraphics->m_Extmax);

	m_pGraphics->m_Bound.left=(m_pGraphics->m_Extmin.x-MarginLeft)*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.top=-(m_pGraphics->m_Extmax.y+MarginTop)*m_pGraphics->m_mYPixel;
	m_pGraphics->m_Bound.right=(m_pGraphics->m_Extmax.x+MarginRight)*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.bottom=-(m_pGraphics->m_Extmin.y-MarginBottom)*m_pGraphics->m_mYPixel;

	m_pGraphics->m_PaperLeft=m_pGraphics->m_Extmin.x-MarginLeft;
	m_pGraphics->m_PaperTop=m_pGraphics->m_Extmax.y+MarginTop;*/
//--------------------------------------------------------------

	m_pGraphics->m_Bound.left=m_pGraphics->m_Extmin.x*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.top=-m_pGraphics->m_Extmax.y*m_pGraphics->m_mYPixel;
	m_pGraphics->m_Bound.right=m_pGraphics->m_Extmax.x*m_pGraphics->m_mXPixel;
	m_pGraphics->m_Bound.bottom=-m_pGraphics->m_Extmin.y*m_pGraphics->m_mYPixel;

	m_pGraphics->m_PaperLeft=m_pGraphics->m_Extmin.x;
	m_pGraphics->m_PaperTop=m_pGraphics->m_Extmax.y;
	m_pGraphics->m_PaperWidth = m_pGraphics->m_Extmax.x - m_pGraphics->m_Extmin.x;
	m_pGraphics->m_PaperHeight = m_pGraphics->m_Extmax.y - m_pGraphics->m_Extmin.y;
}

//======================================================================================
void CProjectIniFile::CreateVertLine(int i)
{
	CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");
	pLine->m_nLineWidth=3; 
	pLine->pt1.x=m_HolePoints[i].x;
	pLine->pt1.y=m_HoleHeight[i];
	pLine->pt2.x=m_HolePoints[i].x;
	pLine->pt2.y=m_HoleHeight[i]-m_HoleDeep[i];
	TransPoint(&pLine->pt1);
	TransPoint(&pLine->pt2);

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("0");
	pLine->m_nLineWidth=3; 
	pLine->pt1.x=m_HolePoints[i].x-0.1*m_xScale;
	pLine->pt1.y=m_HoleHeight[i]-m_HoleDeep[i];
	pLine->pt2.x=m_HolePoints[i].x+0.1*m_xScale;
	pLine->pt2.y=m_HoleHeight[i]-m_HoleDeep[i];
	TransPoint(&pLine->pt1);
	TransPoint(&pLine->pt2);
}

//创建顶层的线
void CProjectIniFile::CreateHoleLayer()
{
	CADSpline* pSpline;
	ADPOINT* pPoint;

	pSpline=new CADSpline();
	m_pGraphics->m_Entities.Add((CObject*)pSpline);
	pSpline->m_nLayer = m_pLayerGroup->indexOf("0");
	pSpline->m_nLineWidth = 2;

	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[0].x-2.5*m_xScale;
	pPoint->y = m_HoleHeight[0];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = (m_HolePoints[0].x+m_HolePoints[0].x-2.5*m_xScale)/2;
	pPoint->y = m_HoleHeight[0];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[0].x;
	pPoint->y = m_HoleHeight[0];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);

	for(int i=0;i<m_HoleNum-1;i++)
	{
		pSpline=new CADSpline();
		m_pGraphics->m_Entities.Add((CObject*)pSpline);
		pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
		pSpline->m_nLineWidth=2;

		pPoint=new ADPOINT();
		pPoint->x = m_HolePoints[i].x;
		pPoint->y = m_HoleHeight[i];
		TransPoint(pPoint);
		pSpline->m_FitPoint.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = (m_HolePoints[i].x+m_HolePoints[i+1].x)/2;
		pPoint->y = (m_HoleHeight[i]+m_HoleHeight[i+1])/2;
		TransPoint(pPoint);
		pSpline->m_FitPoint.Add((CObject*)pPoint);		
		pPoint=new ADPOINT();
		pPoint->x = m_HolePoints[i+1].x;
		pPoint->y = m_HoleHeight[i+1];
		TransPoint(pPoint);
		pSpline->m_FitPoint.Add((CObject*)pPoint);
	}

	pSpline=new CADSpline();
	m_pGraphics->m_Entities.Add((CObject*)pSpline);
	pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;

	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[m_HoleNum-1].x+2.5*m_xScale;
	pPoint->y = m_HoleHeight[m_HoleNum-1];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = (m_HolePoints[m_HoleNum-1].x+m_HolePoints[m_HoleNum-1].x+2.5*m_xScale)/2;
	pPoint->y = m_HoleHeight[m_HoleNum-1];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[m_HoleNum-1].x;
	pPoint->y = m_HoleHeight[m_HoleNum-1];
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
}
//创建所有孔层线
void CProjectIniFile::CreateAllHoleLayer()
{
	int i,j,k;
	CADSpline* pSpline;
	ADPOINT* pPoint;
	//创建最左边的层线
	for(i=0; i<m_Holelayers[0].m_OneHoleLayers.GetSize(); i++)
	{
		COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[0].m_OneHoleLayers.GetAt(i);
		for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
		{
			CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[0])continue;
			pSpline=new CADSpline();
			m_pGraphics->m_Entities.Add((CObject*)pSpline);
			pSpline->m_nColor = AD_COLOR_RED;
			pSpline->m_nLineWidth=2;
			pSpline->m_nLayer=m_pLayerGroup->indexOf("0");

			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[0].x-2*m_xScale;
			pPoint->y = m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[0].x-m_xScale;
			pPoint->y = m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[0].x;
			pPoint->y = m_HoleHeight[0]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
		}
	}
	//创建最右边的层线
	for(i=0;i<m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetSize();i++)
	{
		COneHoleLayer* pOneHoleLayer=(COneHoleLayer*)m_Holelayers[m_HoleNum-1].m_OneHoleLayers.GetAt(i);
		for(j=0;j<pOneHoleLayer->m_SubHoleLayers.GetSize();j++)
		{
			CSubHoleLayer* pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[m_HoleNum-1])continue;
			pSpline=new CADSpline();
			m_pGraphics->m_Entities.Add((CObject*)pSpline);
			pSpline->m_nColor = AD_COLOR_RED;
			pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
			pSpline->m_nLineWidth=2;

			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[m_HoleNum-1].x+m_LegendWidth;
			pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = (m_HolePoints[m_HoleNum-1].x+m_LegendWidth+m_HolePoints[m_HoleNum-1].x+2*m_xScale)/2;
			pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[m_HoleNum-1].x+2*m_xScale;
			pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
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
				m_pGraphics->m_Entities.Add((CObject*)pSpline);
				pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
				pSpline->m_nLineWidth=2;

				pPoint=new ADPOINT();
				pPoint->x = m_HolePoints[m_HoleNum-1].x-2*m_xScale;
				pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
				pPoint=new ADPOINT();
				pPoint->x = m_HolePoints[m_HoleNum-1].x-m_xScale;
				pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
				pPoint=new ADPOINT();
				pPoint->x = m_HolePoints[m_HoleNum-1].x;
				pPoint->y = m_HoleHeight[m_HoleNum-1]-pSubHoleLayer->m_Deep;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
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
	m_pGraphics->m_Entities.Add((CObject*)pSpline);
	pSpline->m_nColor = AD_COLOR_RED;
	pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;
	
	double length = m_HolePoints[holeIndex].x - m_HolePoints[holeIndex-1].x;
	length -= LegendWidth*m_xScale;
	if(length<0)length = 0.5*m_xScale;
	else length /=4;
	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[holeIndex].x-length;
	pPoint->y = m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[holeIndex].x-length/2;
	pPoint->y = m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[holeIndex].x;
	pPoint->y = m_HoleHeight[holeIndex]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
}

void CProjectIniFile::CreateHoleLayerSpline(COneHoleLayer* pOldOneHoleLayer,CSubHoleLayer* pOldSubHoleLayer,int nHole,int nLayer,int nSubLayer)
{
//var
	CADSpline* pSpline;
	ADPOINT* pPoint;
	int subIndex;
	int curLayerIndex = m_pLayerGroup->indexOf("0");
	//if(m_Holelayers[nHole].m_OneHoleLayers.GetSize()<1)return;
	COneHoleLayer* pOneHoleLayer;
	CSubHoleLayer* pSubHoleLayer;

	for (int i=nHole;i<m_HoleNum;i++)
	{
		for (int j=0;j<m_Holelayers[i].m_OneHoleLayers.GetSize();j++)
		{
			pOneHoleLayer=(COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j);
			if (strcmp(pOneHoleLayer->m_ID,pOldOneHoleLayer->m_ID)!=0)continue;
			for (int k=0;k<pOneHoleLayer->m_SubHoleLayers.GetSize();k++)
			{
				pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(k);
				if (strcmp(pSubHoleLayer->m_SubID,pOldSubHoleLayer->m_SubID)!=0)continue;//2004/06/19
				subIndex = k;
				//int oldID = atoi(pOldSubHoleLayer->m_SubID);
				//int id = atoi(pSubHoleLayer->m_SubID);
				//if (oldID==id)subIndex=k;
				//else if (oldID<id)subIndex=k-1;
				//else continue;
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
					m_pGraphics->m_Entities.Add((CObject*)pSpline);
					pSpline->m_nColor = AD_COLOR_RED;
					pSpline->m_nLayer=curLayerIndex;
					pSpline->m_nLineWidth=2;

					pPoint=new ADPOINT();
					pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth;
					pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
					TransPoint(pPoint);
					pSpline->m_FitPoint.Add((CObject*)pPoint);
					pPoint=new ADPOINT();
					pPoint->x = (m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
					pPoint->y = (m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+tempY)/2;
					TransPoint(pPoint);
					pSpline->m_FitPoint.Add((CObject*)pPoint);
					pPoint=new ADPOINT();
					pPoint->x = m_HolePoints[i].x;
					pPoint->y = tempY;
					TransPoint(pPoint);
					pSpline->m_FitPoint.Add((CObject*)pPoint);					
					return;
				}
				pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(subIndex);
				if(pSubHoleLayer->m_Deep>=m_HoleDeep[i])break;

				pSpline=new CADSpline();
				m_pGraphics->m_Entities.Add((CObject*)pSpline);
				pSpline->m_nColor = AD_COLOR_RED;
				pSpline->m_nLayer=curLayerIndex;
				pSpline->m_nLineWidth=2;

				pPoint=new ADPOINT();
				pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth;
				pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
				pPoint=new ADPOINT();
				pPoint->x = (m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
				pPoint->y = (m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+m_HoleHeight[i]-pSubHoleLayer->m_Deep)/2;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
				pPoint=new ADPOINT();
				pPoint->x = m_HolePoints[i].x;
				pPoint->y = m_HoleHeight[i]-pSubHoleLayer->m_Deep;
				TransPoint(pPoint);
				pSpline->m_FitPoint.Add((CObject*)pPoint);
				return;
			}
			//if not find
			subIndex=pOneHoleLayer->m_SubHoleLayers.GetSize()-1;
			pSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(subIndex);
			if(pSubHoleLayer->m_Deep>=m_HoleDeep[i])break;

			pSpline=new CADSpline();
			m_pGraphics->m_Entities.Add((CObject*)pSpline);
			pSpline->m_nColor = AD_COLOR_RED;
			pSpline->m_nLayer=curLayerIndex;
			pSpline->m_nLineWidth=2;

			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth;
			pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = (m_HolePoints[nHole-1].x+m_LegendWidth+m_HolePoints[i].x)/2;
			pPoint->y = (m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep+m_HoleHeight[i]-pSubHoleLayer->m_Deep)/2;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			pPoint=new ADPOINT();
			pPoint->x = m_HolePoints[i].x;
			pPoint->y = m_HoleHeight[i]-pSubHoleLayer->m_Deep;
			TransPoint(pPoint);
			pSpline->m_FitPoint.Add((CObject*)pPoint);
			return;
		}
	}

	pSpline=new CADSpline();
	m_pGraphics->m_Entities.Add((CObject*)pSpline);
	pSpline->m_nColor = AD_COLOR_RED;
	pSpline->m_nLayer=m_pLayerGroup->indexOf("0");
	pSpline->m_nLineWidth=2;

	double width=m_HolePoints[nHole].x-m_HolePoints[nHole-1].x-m_LegendWidth;

	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth;
	pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth+width*3/4/2;
	pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_HolePoints[nHole-1].x+m_LegendWidth+width*3/4;
	pPoint->y = m_HoleHeight[nHole-1]-pOldSubHoleLayer->m_Deep;
	TransPoint(pPoint);
	pSpline->m_FitPoint.Add((CObject*)pPoint);
}

bool CProjectIniFile::ProcessHatch(CADPolyline* pPolyline)
{
	double layerDeep;
	ADPOINT* pPoint1 = (ADPOINT*)pPolyline->m_Point.GetAt(0);
	ADPOINT* pPoint2 = (ADPOINT*)pPolyline->m_Point.GetAt(3);
	if ((pPoint1->y - pPoint2->y)>(2*HOLEDEEPFONTHEIGHT+0.5))
	{
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(0);
		pPoint->y -= HOLEDEEPFONTHEIGHT;
		pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(1);
		pPoint->y -= HOLEDEEPFONTHEIGHT;
		pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(2);
		pPoint->y += HOLEDEEPFONTHEIGHT;
		pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(3);
		pPoint->y += HOLEDEEPFONTHEIGHT;
		return true;
	}
	return false;
}

//生成钻孔层图例
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
					ADPOINT* pPoint;
					if(i==0)
					{
						if ((pSubHoleLayer->m_Deep*1000/m_vScale)>HOLEDEEPFONTHEIGHT)//modify 2004-06-04
						{
							pPoint=new ADPOINT();
							pPolyline->m_Point.Add((CObject*)pPoint);  
							pPoint->x = m_HolePoints[k].x;
							pPoint->y = m_HoleHeight[k];
							TransPoint(pPoint);
							pPoint=new ADPOINT();
							pPolyline->m_Point.Add((CObject*)pPoint);  
							pPoint->x = m_HolePoints[k].x+m_LegendWidth;
							pPoint->y = m_HoleHeight[k];
							TransPoint(pPoint);							
							pPoint=new ADPOINT();
							pPolyline->m_Point.Add((CObject*)pPoint);  
							pPoint->x = m_HolePoints[k].x+m_LegendWidth;
							pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
							TransPoint(pPoint);
							pPoint->y += HOLEDEEPFONTHEIGHT;//modify 2004-06-04
							pPoint=new ADPOINT();
							pPolyline->m_Point.Add((CObject*)pPoint);  
							pPoint->x = m_HolePoints[k].x;
							pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
							TransPoint(pPoint);
							pPoint->y += HOLEDEEPFONTHEIGHT;//modify 2004-06-04
							CreateHatch(pSubHoleLayer->m_Lengend,pPolyline);
						}
					}
					else
					{
						CSubHoleLayer* pTempSubHoleLayer=(CSubHoleLayer*)pOldOneHoleLayer->m_SubHoleLayers.GetAt(pOldOneHoleLayer->m_SubHoleLayers.GetSize()-1);
						pPoint=new ADPOINT();
						pPolyline->m_Point.Add((CObject*)pPoint);  
						pPoint->x = m_HolePoints[k].x;
						pPoint->y = m_HoleHeight[k]-pTempSubHoleLayer->m_Deep;
						TransPoint(pPoint);
						pPoint=new ADPOINT();
						pPolyline->m_Point.Add((CObject*)pPoint);  
						pPoint->x = m_HolePoints[k].x+m_LegendWidth;
						pPoint->y = m_HoleHeight[k]-pTempSubHoleLayer->m_Deep;
						TransPoint(pPoint);
						pPoint=new ADPOINT();
						pPolyline->m_Point.Add((CObject*)pPoint);  
						pPoint->x = m_HolePoints[k].x+m_LegendWidth;
						pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(pPoint);
						pPoint=new ADPOINT();
						pPolyline->m_Point.Add((CObject*)pPoint);  
						pPoint->x = m_HolePoints[k].x;
						pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
						TransPoint(pPoint);
						if (ProcessHatch(pPolyline))//modify 2004-06-04
						CreateHatch(pSubHoleLayer->m_Lengend,pPolyline);
					}
				}else
				{
					CSubHoleLayer* pOldSubHoleLayer=(CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j-1);
					CADPolyline* pPolyline=new CADPolyline();
					ADPOINT* pPoint;
					pPoint=new ADPOINT();
					pPolyline->m_Point.Add((CObject*)pPoint);  
					pPoint->x = m_HolePoints[k].x;
					pPoint->y = m_HoleHeight[k]-pOldSubHoleLayer->m_Deep;
					TransPoint(pPoint);
					pPoint=new ADPOINT();
					pPolyline->m_Point.Add((CObject*)pPoint);  
					pPoint->x = m_HolePoints[k].x+m_LegendWidth;
					pPoint->y = m_HoleHeight[k]-pOldSubHoleLayer->m_Deep;
					TransPoint(pPoint);
					pPoint=new ADPOINT();
					pPolyline->m_Point.Add((CObject*)pPoint);  
					pPoint->x = m_HolePoints[k].x+m_LegendWidth;
					pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
					TransPoint(pPoint);
					pPoint=new ADPOINT();
					pPolyline->m_Point.Add((CObject*)pPoint);  
					pPoint->x = m_HolePoints[k].x;
					pPoint->y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
					TransPoint(pPoint);
					if (ProcessHatch(pPolyline))//modify 2004-06-04
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
	}*/
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
				m_pGraphics->m_Entities.Add((CObject*)pHatch);
				pHatch->m_Scale = 10;
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

void CProjectIniFile::CreateHatchLine(char* hatchLineStr,CADHatch* pHatch)
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

void CProjectIniFile::CreateHoleGrid(LPCTSTR lpFilename)
{
	ADPOINT* pPoint;
	CADPolyline* pPolyline;
	CADMText* pMText;
	int i;
	short curLayerIndex = m_pLayerGroup->indexOf("0");

	double gridLeft,gridTop,gridHeight,gridRight,gridBottom;
	gridLeft = m_FrameLeft+3.5;
	gridTop = m_FrameTop-m_FrameHeight+2+m_LabelGridHegiht+3+m_HoleGridHeight;
	gridHeight = m_HoleGridHeight;//13
	gridRight = m_HolePoints[m_HoleNum-1].x;
	gridRight = gridRight*1000/m_hScale;

	//2004-06-23
	double tmpLeft = m_HolePoints[0].x * 1000/m_hScale;
	if (gridRight-tmpLeft<10*6)
	{
		gridRight = tmpLeft + 10*6;
	}
	gridBottom = gridTop-gridHeight;

	pPolyline=new CADPolyline();
	pPolyline->m_nLayer = curLayerIndex;
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridRight;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridRight;
	pPoint->y = gridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);

	CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=gridLeft;
	pLine->pt1.y=gridTop-3;
	pLine->pt2.x=gridRight;
	pLine->pt2.y=gridTop-3;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="qc(ps) (MPa)";
	pMText->m_Height=2.5;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3;
	//TransPoint(&pMText->m_Location);

	//CADLine* pLine;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=gridLeft;
	pLine->pt1.y=gridTop-3*2;
	pLine->pt2.x=gridRight;
	pLine->pt2.y=gridTop-3*2;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="fs  (kPa)";
	pMText->m_Height=2.5;
	pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3*2;

//2004-06-22
	//tmpLeft = m_HolePoints[i].x;
	for (i=0;i<=6;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x = m_HolePoints[0].x + i*10;
		pLine->pt1.y = gridTop;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = gridTop - 3*2;
		
		if (i>0)
		{
			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer = curLayerIndex;
			//pMText->m_Text.Format("%d",2*i);
			pMText->m_Text.Format("%d",m_StaticCurveScale*i);
			strcpy(pMText->m_Font,"楷体_GB2312");
			pMText->m_Height = 2.5;
			pMText->m_Align = AD_MTEXT_ATTACH_MIDDLERIGHT;
			pMText->m_Location.x = m_HolePoints[0].x + i*10;
			pMText->m_Location.y = gridTop - 1.5;

			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer = curLayerIndex;
			//pMText->m_Text.Format("%d",20*i);
			pMText->m_Text.Format("%d",m_StaticCurveScale*10*i);
			strcpy(pMText->m_Font,"楷体_GB2312");
			pMText->m_Height = 2.5;
			pMText->m_Align = AD_MTEXT_ATTACH_MIDDLERIGHT;
			pMText->m_Location.x = m_HolePoints[0].x + i*10;
			pMText->m_Location.y = gridTop - 3 - 1.5;
		}
	}

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->pt1.x=gridLeft+20;
	pLine->pt1.y=gridTop;
	pLine->pt2.x=pLine->pt1.x;
	pLine->pt2.y=gridBottom;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="钻孔间距(m)";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop-3*2-3.5;

	double fontTop=gridTop-3*2-3.5;

	for(i=0;i<m_HoleNum;i++)
	{
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=curLayerIndex;
		pLine->pt1.x=m_HolePoints[i].x;
		pLine->pt1.y=0;
		pLine->pt2.x=pLine->pt1.x;
		pLine->pt2.y=0;
		TransPoint(&pLine->pt1);
		TransPoint(&pLine->pt2);
		pLine->pt1.y = gridTop - 3*2;
		pLine->pt2.y = gridBottom + 7;
		if (i<m_HoleNum-1)
		{
			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer=curLayerIndex;
			pMText->m_Text.Format("%.2lf",m_HolePoints[i+1].x-m_HolePoints[i].x);
			pMText->m_Height=3;
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
			pMText->m_Location.x=(m_HolePoints[i].x+m_HolePoints[i+1].x)/2;
			pMText->m_Location.y=0;
			TransPoint(&pMText->m_Location);
			pMText->m_Location.y=gridTop-3*2-3.5;
		}
	}

//里程桩号
	pLine = new CADLine();//2004-06-22
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = gridLeft;
	pLine->pt1.y = gridTop-3*2 - 7;
	pLine->pt2.x = gridRight;
	pLine->pt2.y = pLine->pt1.y;

	pMText=new CADMText();//2004-06-22
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="里程桩号";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x=gridLeft+0.5;
	pMText->m_Location.y=gridTop - 3*2 - 7 - 3.5;

	char str[512];
	char num[4];
	char keyName[10];
	for(i=0;i<m_HoleNum;i++)
	{
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		GetPrivateProfileString(keyName,"里程桩号","",str,255,lpFilename);
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text = str;
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height = 3.5;
		if (i==m_HoleNum-1)
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
		else
			pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Location.x = m_HolePoints[i].x;
		pMText->m_Location.y = 0;
		TransPoint(&pMText->m_Location);
		pMText->m_Location.y = gridTop-3*2-7-3.5;	
	}
}

void CProjectIniFile::CreateChartFooter(LPCTSTR lpFilename)
{
	const ColCount = 11;	
	double GridColWidth[11];//mm

	short j = 0;
	//GridColWidth[j++]=24;
	GridColWidth[j++]=91;
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

	double GridLeft,GridTop,GridHeight,GridRight,GridBottom;
	GridLeft = m_FrameLeft+1;
	GridTop=m_FrameTop-m_FrameHeight+2+7;
	GridHeight=7;//7
	GridRight=m_FrameLeft+m_FrameWidth-1;
	GridBottom=GridTop-GridHeight;

	double fontTop = GridTop-3.5;
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
	for (int i=0;i<ColCount-1;i++)
	{
		if (m_Orient!=1 && i== ColCount-5)break;
		pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;

		curWidth+=GridColWidth[i];

		pLine->pt1.x=GridLeft+curWidth;
		pLine->pt1.y=GridTop;
		pLine->pt2.x=GridLeft+curWidth;
		pLine->pt2.y=GridTop-GridHeight;
	}
	
	short curColIndex = 0;
	double curColX = GridLeft;
	char str[255];

	//工程编号
	float IDWidth = 25;//mm
	float IDHeight = 8;//mm
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("图纸信息","工程编号","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.7;
	pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft + IDWidth/2;
	pMText->m_Location.y = m_FrameTop - IDHeight/2;
	
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->m_nLineWidth = 2;
	pLine->pt1.x = m_FrameLeft + IDWidth;
	pLine->pt1.y = m_FrameTop;
	pLine->pt2.x = pLine->pt1.x;
	pLine->pt2.y = m_FrameTop - IDHeight;

	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->m_nLineWidth=2;
	pLine->pt1.x = m_FrameLeft;
	pLine->pt1.y = m_FrameTop - IDHeight;
	pLine->pt2.x = pLine->pt1.x + IDWidth;
	pLine->pt2.y = pLine->pt1.y;

	/*pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("图纸信息","工程编号","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];*/

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	::GetPrivateProfileString("图纸信息","工程名称","",str,255,lpFilename);
	pMText->m_Text=str;
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Location.x = curColX + 3;
	pMText->m_Location.y = fontTop;

	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="编 制";
	strcpy(pMText->m_Font,"楷体_GB2312");
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
	pMText->m_Text="复 核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text="审 核";
	strcpy(pMText->m_Font,"楷体_GB2312");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
	pMText->m_Location.y=fontTop;

	curColX += GridColWidth[curColIndex++];
	curColX += GridColWidth[curColIndex++];

	if (m_Orient==1)
	{
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text="图 表 号";
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=3.5;
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
		pMText->m_Location.y=fontTop;

		curColX += GridColWidth[curColIndex++];
		curColX += GridColWidth[curColIndex++];

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer=curLayerIndex;
		pMText->m_Text="第   张 共   张";
		strcpy(pMText->m_Font,"楷体_GB2312");
		pMText->m_Height=3.5;
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Location.x=curColX+GridColWidth[curColIndex]/2;
		pMText->m_Location.y=fontTop;
	}

	/*pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Text=Maker;
	strcpy(pMText->m_Font,"黑体");
	pMText->m_Height=3.5;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Location.x = GridLeft+GridColWidth[0]+GridColWidth[1]+GridColWidth[2];
	pMText->m_Location.x += GridColWidth[3]+GridColWidth[4]+GridColWidth[5]+GridColWidth[6];
	pMText->m_Location.x += GridColWidth[7]+GridColWidth[8]+GridColWidth[9]+GridColWidth[10];
	pMText->m_Location.x += GridColWidth[11]/2;
	pMText->m_Location.y=fontTop;*/
}

//******************************************
//孔口编号
//--------
//孔口标高
//******************************************
void CProjectIniFile::CreateHoleHeightText()
{
//	ADPOINT* pPoint;
//	CADPolyline* pPolyline;
	CADMText* pMText;
	CADLine* pLine;
	const float fontHeight = 3;//2.8;
	for (int i=0;i<m_HoleNum;i++)
	{
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		strcpy(pMText->m_Font,"黑体");
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Text = m_HoleID[i];
		pMText->m_Height = fontHeight;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
		pMText->m_Location.x = m_HolePoints[i].x;
		pMText->m_Location.y = m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pMText->m_Location);

		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer=m_pLayerGroup->indexOf("0");
		pLine->pt1.x=m_HolePoints[i].x-0.4*m_xScale;
		pLine->pt1.y=m_HoleHeight[i]+0.6*m_yScale;
		pLine->pt2.x=m_HolePoints[i].x+0.4*m_xScale;
		pLine->pt2.y=m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pLine->pt1);
		TransPoint(&pLine->pt2);

		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		strcpy(pMText->m_Font,"黑体");
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Text.Format("%.2lf",m_HoleHeight[i]);
		pMText->m_Height = fontHeight;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = m_HolePoints[i].x;
		pMText->m_Location.y = m_HoleHeight[i]+0.6*m_yScale;
		TransPoint(&pMText->m_Location);
	}
}

//生成钻孔深度字符
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
				m_pGraphics->m_Entities.Add((CObject*)pMText);
				pMText->m_nLayer=m_pLayerGroup->indexOf("0");
				pMText->m_Text.Format("%.2lf",pSubHoleLayer->m_Deep);
				strcpy(pMText->m_Font,"黑体");
				pMText->m_Height = HOLEDEEPFONTHEIGHT;//2.5
				pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMLEFT;
				pMText->m_Location.x = m_HolePoints[k].x+0.1*m_xScale;
				pMText->m_Location.y = m_HoleHeight[k]-pSubHoleLayer->m_Deep;
				TransPoint(&pMText->m_Location);

				pMText=new CADMText();
				m_pGraphics->m_Entities.Add((CObject*)pMText);
				pMText->m_nLayer=m_pLayerGroup->indexOf("0");
				pMText->m_Text.Format("(%.2lf)",(m_HoleHeight[k]-pSubHoleLayer->m_Deep));
				strcpy(pMText->m_Font,"黑体");
				pMText->m_Height = HOLEDEEPFONTHEIGHT;
				pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
				pMText->m_Location.x=m_HolePoints[k].x;
				pMText->m_Location.y=m_HoleHeight[k]-pSubHoleLayer->m_Deep;
				TransPoint(&pMText->m_Location);
			}
		}
	}			
}

//m->mm
void CProjectIniFile::TransPoint(ADPOINT* pPoint)
{
	pPoint->x = pPoint->x*1000/m_hScale;
	pPoint->y = pPoint->y*1000/m_vScale;
}

void CProjectIniFile::CreateChartFrame()
{
	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	pPolyline->m_nLineWidth = 3;

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

void CProjectIniFile::CreateChartHeader()
{
	//生成图纸名称
	char str[255];
	CADMText* pMText;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
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
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Text="比例尺";
	strcpy(pMText->m_Font,"楷体_GB2312"); 
	pMText->m_Height=3;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2-5;
	pMText->m_Location.y=m_FrameTop-6-7-5;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text.Format("水平 1: %d",m_hScale);
	strcpy(pMText->m_Font,"楷体_GB2312"); 
	pMText->m_Height=3;
	pMText->m_Width=3;
	pMText->m_Location.x=m_FrameLeft+m_FrameWidth/2+5;
	pMText->m_Location.y=m_FrameTop-6-7-3;

	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
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
	double perRuler=(double)m_yScale;//unit(m)
	double curAddRuler=0;
	double rulerX,rulerY,rulerWidth;
	//rulerX=m_pGraphics->m_Extmin.x+m_xScale;
	rulerX=m_RulerLeft;
	rulerY=m_RulerTop;
	rulerWidth=perRuler/5*m_xScale/m_yScale;
	CADSolid* pSolid;
	CString str2;
	while((m_RulerTop-curAddRuler)>m_HoleBottom)
	{
		if((int)(curAddRuler/perRuler)%2==0)
		{
			pSolid=new CADSolid();
			m_pGraphics->m_Entities.Add((CObject*)pSolid);
			pSolid->m_nColor=7;
			pSolid->m_nLayer=m_pLayerGroup->indexOf("0");
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
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer=m_pLayerGroup->indexOf("0");
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
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=m_pLayerGroup->indexOf("0");
	str2.Format("%.1lf",rulerY-curAddRuler); 
	pMText->m_Text=str2;
	pMText->m_Height=3;
	pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
	pMText->m_Location.x=rulerX;
	pMText->m_Location.y=rulerY-curAddRuler;
	TransPoint(&pMText->m_Location);

	double m_HoleBottom2=m_RulerTop-curAddRuler;
	CADPolyline* pPolyline=new CADPolyline();
	pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");
	pPolyline->m_Closed=true;
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);

	ADPOINT* pPoint;
	pPoint=new ADPOINT();
	pPoint->x = rulerX;
	pPoint->y = rulerY;
	TransPoint(pPoint);
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = rulerX+rulerWidth;
	pPoint->y = rulerY;
	TransPoint(pPoint);
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = rulerX+rulerWidth;
	pPoint->y = m_HoleBottom2;
	TransPoint(pPoint);
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = rulerX;
	pPoint->y = m_HoleBottom2;
	TransPoint(pPoint);
	pPolyline->m_Point.Add((CObject*)pPoint);	
}
//小黑点
void CProjectIniFile::CreateLandInfo(char* pLandInfoStr,int i)
{
	char* pszTemp = strtok(pLandInfoStr, ",");
	while(pszTemp)
	{
		CADHatch* pHatch = new CADHatch();
		m_pGraphics->m_Entities.Add((CObject*)pHatch);
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
		pHatch->m_Paths.Add((CObject*)pPolyline);

		ADPOINT* pPoint;
		pPoint=new ADPOINT();
		pPoint->x = m_HolePoints[i].x-0.3*m_xScale+0.06*m_xScale;
		pPoint->y = m_HoleHeight[i]-atof(pszTemp);
		TransPoint(pPoint);
		pPolyline->m_Point.Add((CObject*)pPoint);

		pPoint=new ADPOINT();
		pPoint->x = m_HolePoints[i].x-0.3*m_xScale-0.06*m_xScale;
		pPoint->y = m_HoleHeight[i]-atof(pszTemp);
		TransPoint(pPoint);
		pPolyline->m_Point.Add((CObject*)pPoint);
		
		pszTemp=strtok(NULL, ",");
	}
}

void CProjectIniFile::CreateGradeInfo(char* pGradeInfoStr,int i)
{
	char* pszTemp = strtok(pGradeInfoStr, ",");
	while(pszTemp)
	{
		int curLayerIndex = m_pLayerGroup->indexOf("0");
		CADMText* pMText;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Height = 2.5;
		pMText->m_Width = 3;
		pMText->m_Location.x = m_HolePoints[i].x-0.4*m_xScale;
		pMText->m_Location.y = m_HoleHeight[i]-atof(pszTemp);
		TransPoint(&pMText->m_Location);

		pszTemp=strtok(NULL, ",");
		if(pszTemp == NULL)return;

		//updated on 2007/116
		//pMText->m_Text = "N=";
		//pMText->m_Text += pszTemp;
		pMText->m_Text = pszTemp;
		pszTemp = strtok(NULL, ",");

		float borderLength = 3;

		CADPolyline* pPolyline = new CADPolyline();
		pPolyline->m_nLayer = curLayerIndex;
		//pPolyline->m_Closed = true;
		m_pGraphics->m_Entities.Add((CObject*)pPolyline);

		ADPOINT* pPoint;
		pPoint = new ADPOINT();
		pPoint->x = m_HolePoints[i].x-0.3*m_xScale+0.06*m_xScale;
		pPoint->y = 0;
		TransPoint(pPoint);

		ADPOINT tempPoint = {pPoint->x-0.5,pMText->m_Location.y+1};
		float arrowLen = 1.5;
		//tempPoint.y += borderLength/2;
		//TransPoint(&tempPoint);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x;
		pPoint->y = tempPoint.y + borderLength/2;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x;
		pPoint->y = tempPoint.y - borderLength/2;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x - arrowLen*cos(45*PI/180);
		pPoint->y = tempPoint.y  - borderLength/2 + arrowLen*cos(45*PI/180);
		pPolyline->m_Point.Add((CObject*)pPoint);

		pPolyline = new CADPolyline();
		pPolyline->m_nLayer = curLayerIndex;

		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x;
		pPoint->y = tempPoint.y - borderLength/2;
		pPolyline->m_Point.Add((CObject*)pPoint);

		m_pGraphics->m_Entities.Add((CObject*)pPolyline);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x + arrowLen*cos(45*PI/180);
		pPoint->y = tempPoint.y - borderLength/2 + arrowLen*cos(45*PI/180);
		pPolyline->m_Point.Add((CObject*)pPoint);		
	}
}

void CProjectIniFile::CreateGradeInfo2(char* pGradeInfoStr,int i)
{
	//<--added on 20081205
	double curDeep = 1.5;
	double deepSpace = 1.5;
	//-->
	char* pszTemp = strtok(pGradeInfoStr, ",");
	while (pszTemp != NULL)
	{
		double curX,curY;
		curX = m_HolePoints[i].x-0.4*m_xScale;
		//<--updated on 20081205
		//curY = m_HoleHeight[i]-atof(pszTemp);
		curY = m_HoleHeight[i]-curDeep;
		curDeep += deepSpace;
		//-->
		CADMText* pMText;
		/*pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Height = 2.5;
		pMText->m_Width = 3;
		pMText->m_Location.x = curX;
		pMText->m_Location.y = curY;
		TransPoint(&pMText->m_Location);
		pMText->m_Text = "=";
		
		pszTemp=strtok(NULL, ",");
		if(pszTemp == NULL)return;
		pMText->m_Text += pszTemp;
		curX = curX - (double)pMText->m_Text.GetLength() * 0.1*m_xScale - 0.1*m_xScale;
		
		pszTemp = strtok(NULL, ",");
		if(pszTemp == NULL)return;
		
		if (strcmp(pszTemp," ")!=0)
		{
			pMText=new CADMText();
			m_pGraphics->m_Entities.Add((CObject*)pMText);
			pMText->m_nLayer = m_pLayerGroup->indexOf("0");
			pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
			pMText->m_Height = 1.5;
			pMText->m_Width = 3;
			pMText->m_Location.x = curX;
			pMText->m_Location.y = curY - 0.15;
			TransPoint(&pMText->m_Location);
			pMText->m_Text = pszTemp;
			curX -= (double)pMText->m_Text.GetLength() * 0.08*m_xScale;
		}
		
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Height = 2.5;
		pMText->m_Width = 3;
		pMText->m_Location.x = curX;
		pMText->m_Location.y = curY;
		TransPoint(&pMText->m_Location);
		pMText->m_Text = "N";*/

		pszTemp=strtok(NULL, ",");
		if(pszTemp == NULL)return;

		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = m_pLayerGroup->indexOf("0");
		pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMRIGHT;
		pMText->m_Height = 2.5;
		pMText->m_Width = 3;
		pMText->m_Location.x = curX;
		pMText->m_Location.y = curY;
		TransPoint(&pMText->m_Location);
		pMText->m_Text = "N'=";
		pMText->m_Text += pszTemp;

		pszTemp = strtok(NULL, ",");
		if(pszTemp == NULL)return;

		pszTemp = strtok(NULL, ",");
		if(pszTemp == NULL)return;
	}
}

void CProjectIniFile::CreateGradeInfo2Ex(char* pGradeInfoStr,int i)
{
	//<--added on 20081205
	double curDeep = 1.5;
	double deepSpace = 1.5;
	//-->
	char* pszTemp = strtok(pGradeInfoStr, ",");

	CADMText* pMText;	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = m_pLayerGroup->indexOf("0");
	//pMText->m_Align = AD_MTEXT_ATTACH_TOPRIGHT;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Height = 2.5;
	pMText->m_Width = 3;
	//pMText->m_Location.x = m_HolePoints[i].x-0.4*m_xScale;
	pMText->m_Location.x = m_HolePoints[i].x-2*m_xScale;
	pMText->m_Location.y = m_HoleHeight[i]-curDeep;
	TransPoint(&pMText->m_Location);
	pMText->m_Text = "";

	while (pszTemp != NULL)
	{
		CString str;
		str = pszTemp;

		pszTemp=strtok(NULL, ",");
		if(pszTemp == NULL)return;

		if (pMText->m_Text != "")
		{
			pMText->m_Text += "\r\n";
			pMText->m_Text += "\r\n";
		}
		pMText->m_Text += "N'=";
		pMText->m_Text += pszTemp;
		pMText->m_Text += " (";
		pMText->m_Text += str;
		pMText->m_Text += ")";

		pszTemp = strtok(NULL, ",");
		if(pszTemp == NULL)return;

		pszTemp = strtok(NULL, ",");
		if(pszTemp == NULL)return;
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

	short curHoleIndex;
	short fitHoleIndex;
	int i,j;
	char mainID[10];
	char subID[10];
	for (i=0;i<m_HoleNum;i++)
	{
		curHoleIndex = 0;
		for (int k=0;k<m_Holelayers[i].m_OneHoleLayers.GetSize();k++)
		{
			COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(k);
			strcpy(mainID,pOneHoleLayer->m_ID);
			int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
			for(j=0;j<subSize;j++)
			{
				CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				strcpy(subID,pSubHoleLayer->m_SubID);
				fitHoleIndex = GetFitHoleIndex(i+1,mainID,subID);
				if (fitHoleIndex == -1)continue;
				short mainLayerIndex,subLayerIndex;
				GetSubLayerIndex(fitHoleIndex+1,mainID,subID,mainLayerIndex,subLayerIndex);
				if (mainLayerIndex==-1 || subLayerIndex==-1)continue;
				COneHoleLayer* pFitOneHoleLayer = (COneHoleLayer*)m_Holelayers[fitHoleIndex].m_OneHoleLayers.GetAt(mainLayerIndex);
				CSubHoleLayer* pFitSubHoleLayer = (CSubHoleLayer*)pFitOneHoleLayer->m_SubHoleLayers.GetAt(subLayerIndex);
				//--------------------------------------------------------
				CString str = "Layer";
				str += pFitOneHoleLayer->m_ID;
				//if (pFitSubHoleLayer->m_SubID!="")
				if (strcmp(pFitSubHoleLayer->m_SubID,"")!=0)
				{
					str += "-";
					str += pFitSubHoleLayer->m_SubID;
				}
				int index = m_pGraphics->IndexOfBlocks((LPCTSTR)str);
				if(index==-1)
				{
					CADBlock* pBlock;
					pBlock = new CADBlock();
					CADGraphics::CreateHandle(pBlock->m_Handle2);
					m_pGraphics->m_Blocks.Add((CObject*)pBlock);
					pBlock->m_nLayer = 0; 
					strcpy(pBlock->m_Name,(LPCTSTR)str);
					pBlock->m_BasePoint.x = 0;
					pBlock->m_BasePoint.y = 0;

					CADBlockRecord* pBlockRecord = new CADBlockRecord();
					m_pGraphics->m_BlockRecords.Add((CObject*)pBlockRecord);
					strcpy(pBlockRecord->m_Name,pBlock->m_Name);
					CADGraphics::CreateHandle(pBlockRecord->m_Handle);
					
					CADCircle* pCircle;
					pCircle = new CADCircle();
					pCircle->m_nLayer = 0;
					pBlock->m_Entities.Add((CObject*)pCircle);
					pCircle->m_nColor = 7;
					pCircle->ptCenter.x = 0;
					pCircle->ptCenter.y = 0;
					pCircle->m_Radius = 1.5;

					CADMText* pMText;
					pMText = new CADMText();
					pMText->m_nLayer = 0;
					pBlock->m_Entities.Add((CObject*)pMText);
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

					if(pFitSubHoleLayer->m_SubID!="")
					{
						CADMText* pMText;
						pMText=new CADMText();
						pMText->m_nLayer=0;
						pBlock->m_Entities.Add((CObject*)pMText);
						pMText->m_nColor=7;
						pMText->m_Location.x=2;
						pMText->m_Location.y=0;
						pMText->m_Text=pFitSubHoleLayer->m_SubID;
						pMText->m_Height=2;
						pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
					}
				}
				//create layer flag insert---------------------------------------------------
				double insertX=0,insertY=0;
				double spaceX;
				if (fitHoleIndex == m_HoleNum-1)spaceX=-0.3*m_xScale;
				else spaceX = m_LegendWidth+0.3*m_xScale;

				CADInsert *pInsert=new CADInsert();
				m_pGraphics->m_Entities.Add((CObject*)pInsert);
				pInsert->m_nLayer=0;
				strcpy(pInsert->m_Name,(LPCTSTR)str);
				//pInsert->pt.x=m_HolePoints[fitHoleIndex].x+spaceX;
				//check previous and back hole
				//if (fitHoleIndex == m_HoleNum-1)
				if (fitHoleIndex > 0 && fitHoleIndex < m_HoleNum-1)
				{
					short mainLayerIndex2,subLayerIndex2;
					GetSubLayerIndex(fitHoleIndex,mainID,subID,mainLayerIndex2,subLayerIndex2);
					if (mainLayerIndex2!=-1 && subLayerIndex2!=-1)
					{
						insertX = m_HolePoints[fitHoleIndex-1].x;
						insertY = GetLayerBetweenCordY(fitHoleIndex-1,mainLayerIndex2,subLayerIndex2);									
					}
					else
					{
						GetSubLayerIndex(fitHoleIndex+2,mainID,subID,mainLayerIndex2,subLayerIndex2);
						if (mainLayerIndex2!=-1 && subLayerIndex2!=-1)
						{
							insertX = m_HolePoints[fitHoleIndex+1].x;
							insertY = GetLayerBetweenCordY(fitHoleIndex+1,mainLayerIndex2,subLayerIndex2);
						}
					}
				}
				if (insertX == 0)
					insertX = m_HolePoints[fitHoleIndex].x + spaceX;
				else
				{
					insertX += m_HolePoints[fitHoleIndex].x + m_LegendWidth;
					insertX /= 2;
				}
				pInsert->pt.x=insertX;

				if (insertY == 0)
					insertY = GetLayerBetweenCordY(fitHoleIndex,mainLayerIndex,subLayerIndex);
				else
				{
					insertY += GetLayerBetweenCordY(fitHoleIndex,mainLayerIndex,subLayerIndex);
					insertY /= 2;
				}
				pInsert->pt.y = insertY;
				TransPoint(&pInsert->pt);
				pInsert->m_xScale=1;
				pInsert->m_yScale=1;
				pInsert->m_Rotation=0;
			}
		}
	}
}

void CProjectIniFile::GetSubLayerIndex(short nHole,const char* mainID,const char* subID,short& mainLayerIndex,short& subLayerIndex)
{
	if (nHole<=0) return;
	for (int i=0;i<m_Holelayers[nHole-1].m_OneHoleLayers.GetSize();i++)
	{
		COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[nHole-1].m_OneHoleLayers.GetAt(i);
		short oldID = atoi(mainID);
		short id=atoi(pOneHoleLayer->m_ID);
		if (id > oldID)
		{
			mainLayerIndex = -1;
			subLayerIndex = -1;
			return;
		}
		if (id == oldID)
		{
			mainLayerIndex = i;
			int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
			for(int j=0;j<subSize;j++)
			{
				CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(j);
				if (subID=="" && pSubHoleLayer->m_SubID=="")
				{
					subLayerIndex = 0;
					return;
				}
				if (subID=="" || pSubHoleLayer->m_SubID=="")
				{
					subLayerIndex = -1;
					return;
				}
				short oldSubID = atoi(subID);
				short subID = atoi(pSubHoleLayer->m_SubID);
				if (subID > oldSubID)
				{				
					subLayerIndex = -1;
					return;
				}
				if (subID == oldSubID)
				{
					subLayerIndex = j;
					return;
				}
			}		
		}
	}
	mainLayerIndex = -1;
	subLayerIndex = -1;
	return;	
}

short CProjectIniFile::GetFitHoleIndex(short nOldHole,const char* mainID,const char* subID)
{
	if (nOldHole <= 0)return -1;
	if (nOldHole > 1)
	{
		for (int i=0;i<nOldHole-1;i++)
		{
			for (int j=0;j<m_Holelayers[i].m_OneHoleLayers.GetSize();j++)
			{
				COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j);
				short oldID = atoi(mainID);
				short id = atoi(pOneHoleLayer->m_ID);
				if (id > oldID)
				{
					break;
				}
				if (id == oldID)
				{
					int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
					for(int k=0;k<subSize;k++)
					{
						CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(k);
						if (strcmp(subID,pSubHoleLayer->m_SubID)==0)
						{
							return -1;
						}
					}
				}
			}
		}		
	}
	unsigned short middleHoleIndex = m_HoleNum/2;
	short curFitHoleIndex = nOldHole-1;
	unsigned short apartHole = abs(curFitHoleIndex-middleHoleIndex);
	for (int i=nOldHole;i<m_HoleNum;i++)
	{
		int jj=m_Holelayers[i].m_OneHoleLayers.GetSize();
		for (int j=0;j<m_Holelayers[i].m_OneHoleLayers.GetSize();j++)
		{
			COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[i].m_OneHoleLayers.GetAt(j);
			short oldID = atoi(mainID);
			short id=atoi(pOneHoleLayer->m_ID);
			if (id > oldID)
			{
				break;
			}
			if (id == oldID)
			{
				int subSize = pOneHoleLayer->m_SubHoleLayers.GetSize();
				for(int k=0;k<subSize;k++)
				{
					CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(k);
					if (strcmp(subID,pSubHoleLayer->m_SubID)==0)
					{
						if (apartHole > abs(i-middleHoleIndex))
						{
							curFitHoleIndex = i;
							apartHole = abs(i-middleHoleIndex);
							j = m_Holelayers[i].m_OneHoleLayers.GetSize()-1;//jump j loop
							break;
						}
					}
				}
			}
		}
	}
	return curFitHoleIndex;
}

double CProjectIniFile::GetLayerBetweenCordY(short holeIndex,short mainLayerIndex,short subLayerIndex)
{
	COneHoleLayer* pOneHoleLayer = (COneHoleLayer*)m_Holelayers[holeIndex].m_OneHoleLayers.GetAt(mainLayerIndex);
	CSubHoleLayer* pSubHoleLayer = (CSubHoleLayer*)pOneHoleLayer->m_SubHoleLayers.GetAt(subLayerIndex);
	if (mainLayerIndex==0 && subLayerIndex==0)
		return (2*m_HoleHeight[holeIndex]-pSubHoleLayer->m_Deep)/2;
	else
	{
		if (subLayerIndex == 0)
		{
			COneHoleLayer* pUpOneHoleLayer = (COneHoleLayer*)m_Holelayers[holeIndex].m_OneHoleLayers.GetAt(mainLayerIndex-1);
			CSubHoleLayer* pUpSubHoleLayer = (CSubHoleLayer*)pUpOneHoleLayer->m_SubHoleLayers.GetAt(pUpOneHoleLayer->m_SubHoleLayers.GetSize()-1);
			return (2*m_HoleHeight[holeIndex]-pUpSubHoleLayer->m_Deep-pSubHoleLayer->m_Deep)/2;
		}
		else
		{
			COneHoleLayer* pUpOneHoleLayer = (COneHoleLayer*)m_Holelayers[holeIndex].m_OneHoleLayers.GetAt(mainLayerIndex);
			CSubHoleLayer* pUpSubHoleLayer = (CSubHoleLayer*)pUpOneHoleLayer->m_SubHoleLayers.GetAt(subLayerIndex-1);
			return (2*m_HoleHeight[holeIndex]-pUpSubHoleLayer->m_Deep-pSubHoleLayer->m_Deep)/2;
		}
	}			
}

//绘制静探曲线图
//updated on 2006/12/19
void CProjectIniFile::CreateStaticCurve()
{
	char num[4];
	char keyName[10];
	int i;
	const int strMaxLen=20000;
	char str2[20000];
	for(i=0;i<m_HoleNum;i++)
	{
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		///////////////////////////////////////////////////////////////////
		GetPrivateProfileString(keyName,"静探深度","",str2,strMaxLen,m_pFileName);		
		char* pszTemp = strtok(str2, ",");
		if (pszTemp==NULL)continue;
		
		CADPolyline* pPolyline=new CADPolyline();//创建qc曲线
		m_pGraphics->m_Entities.Add((CObject*)pPolyline);
		pPolyline->m_nLayer=m_pLayerGroup->indexOf("0");

		ADPOINT* pPoint=new ADPOINT();
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint->y = m_HoleHeight[i]-atof(pszTemp);

		CADPolyline* pPolyline2 = new CADPolyline();//创建fs曲线
		m_pGraphics->m_Entities.Add((CObject*)pPolyline2);
		pPolyline2->m_LTypeName = new char[AD_MAX_STRLEN];
		strcpy(pPolyline2->m_LTypeName,"ACAD_ISO02W100");
		pPolyline2->m_LTypeScale = 0.1;
		pPolyline2->m_nLayer = m_pLayerGroup->indexOf("0");

		ADPOINT* pPoint2=new ADPOINT();
		pPolyline2->m_Point.Add((CObject*)pPoint2);
		pPoint2->y = m_HoleHeight[i] - atof(pszTemp);

		while(pszTemp)
		{
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)break;
			pPoint = new ADPOINT();
			pPolyline->m_Point.Add((CObject*)pPoint);
			pPoint->y = m_HoleHeight[i]-atof(pszTemp);

			pPoint2 = new ADPOINT();
			pPolyline2->m_Point.Add((CObject*)pPoint2);
			pPoint2->y = m_HoleHeight[i] - atof(pszTemp);
		}

		double staticWidth,staticLeft;
		if (i<m_HoleNum-1)staticWidth = m_HolePoints[i+1].x - m_HolePoints[i].x;
		else staticWidth = 3.5*m_xScale;
		staticLeft = m_HolePoints[i].x;

		//锥尖阻力qc
		GetPrivateProfileString(keyName,"锥尖阻力qc","",str2,strMaxLen,m_pFileName);
		pszTemp = strtok(str2, ",");

		if(pszTemp==NULL)continue;
		int j=0;
		int pointCount=pPolyline->m_Point.GetSize();

		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		//if(atof(pszTemp)>8.0)
		//	pPoint->x = staticLeft+staticWidth;
		//else
			//pPoint->x = staticLeft+staticWidth*atof(pszTemp)/8;
		pPoint->x = staticLeft;
		TransPoint(pPoint);
		//updated on 2006/12/19
		//pPoint->x += atof(pszTemp)/2*10;//2004/7/13
		pPoint->x += atof(pszTemp)*10/m_StaticCurveScale;

		while(pszTemp)
		{
			j++;
			if((j+1)>pointCount)break;
			pszTemp = strtok(NULL, ",");
			if(pszTemp==NULL)break;
			pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);	
			//if(atof(pszTemp)>8.0)
			//	pPoint->x = staticLeft+staticWidth;
			//else
				//pPoint->x = staticLeft+staticWidth*atof(pszTemp)/8;
			pPoint->x = staticLeft;
			TransPoint(pPoint);
			//updated on 2006/12/19
			//pPoint->x += atof(pszTemp)/2*10;//2004/7/13
			pPoint->x += atof(pszTemp)*10/m_StaticCurveScale;
		}
		
		//侧壁摩阻力fs
		GetPrivateProfileString(keyName,"侧壁摩阻力fs","",str2,strMaxLen,m_pFileName);
		pszTemp = strtok(str2, ",");

		if(pszTemp==NULL)continue;
		j=0;
		pointCount = pPolyline2->m_Point.GetSize();

		pPoint2 = (ADPOINT*)pPolyline2->m_Point.GetAt(j);
		//if(atof(pszTemp)>8.0)
		//	pPoint2->x = staticLeft + staticWidth;
		//else
			//pPoint2->x = staticLeft + staticWidth*atof(pszTemp)/160;
		pPoint2->x = staticLeft;
		TransPoint(pPoint2);
		//updated on 2006/12/19
		//pPoint2->x += atof(pszTemp)/20*10;//2004/7/13
		pPoint2->x += atof(pszTemp)/m_StaticCurveScale;		

		while(pszTemp)
		{
			j++;
			if ((j+1)>pointCount)break;
			pszTemp = strtok(NULL, ",");
			if (pszTemp==NULL)break;
			pPoint2 = (ADPOINT*)pPolyline2->m_Point.GetAt(j);	
			//if (atof(pszTemp)>8.0)
			//	pPoint2->x = staticLeft+staticWidth;
			//else
				//pPoint2->x = staticLeft+staticWidth * atof(pszTemp)/160;
			pPoint2->x = staticLeft;
			TransPoint(pPoint2);
			//updated on 2006/12/19
			//pPoint2->x += atof(pszTemp)/20*10;//2004/7/13
			pPoint2->x += atof(pszTemp)/m_StaticCurveScale;
		}
	}	
}

void CProjectIniFile::CreateWaterLine(LPCTSTR lpFilename)
{
	short curLayerIndex = m_pLayerGroup->indexOf("0");
	char str[255];
	char num[4];
	char keyName[10];
	int i;
	for(i=0;i<m_HoleNum;i++)
	{
		itoa(i+1,num,10);
		strcpy(keyName,"钻孔");
		strcat(keyName,num);
		///////////////////////////////////////////////////////////////////		
		GetPrivateProfileString(keyName,"稳定水位","",str,255,lpFilename);
		if (strcmp(str,"")==0)continue;
		float waterLineY = atof(str);
		/*CADMText* pMText;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text = "▼";
		pMText->m_Height = 2.5;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = m_HolePoints[i].x;
		pMText->m_Location.y = waterLineY;
		TransPoint(&pMText->m_Location);*/

		const float borderLength = 2;

		CADInsert *pInsert=new CADInsert();
		m_pGraphics->m_Entities.Add((CObject*)pInsert);
		pInsert->m_nLayer = curLayerIndex;
		pInsert->m_xScale = 1;
		pInsert->m_yScale = 1;
		strcpy(pInsert->m_Name,"稳定水位线");
		
		ADPOINT tempPoint = {m_HolePoints[i].x,m_HoleHeight[i]-waterLineY};
		// ADPOINT tempPoint = {m_HolePoints[i].x,m_HolePoints[i].y-waterLineY};
		tempPoint.x += borderLength/2 + m_LegendWidth;
		TransPoint(&tempPoint);

		pInsert->pt.x = tempPoint.x;
		pInsert->pt.y = tempPoint.y;
// 		char strtest[255];
// 		sprintf(strtest,"%lf",m_HoleHeight[i]);
//         MessageBox(NULL,strtest,"test",MB_OK);
/*		CADPolyline* pPolyline = new CADPolyline();
		pPolyline->m_nLayer = curLayerIndex;
		pPolyline->m_Closed = true;
		m_pGraphics->m_Entities.Add((CObject*)pPolyline);

		ADPOINT tempPoint = {m_HolePoints[i].x,m_HolePoints[i].y-waterLineY};
		tempPoint.x += borderLength/2 + m_LegendWidth;
		TransPoint(&tempPoint);
		ADPOINT* pPoint=new ADPOINT();
		pPoint->x = tempPoint.x;
		pPoint->y = tempPoint.y;
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x - borderLength/2;
		pPoint->y = tempPoint.y + borderLength*pow(3,1/2);
		pPolyline->m_Point.Add((CObject*)pPoint);
		pPoint=new ADPOINT();
		pPoint->x = tempPoint.x + borderLength/2;
		pPoint->y = tempPoint.y + borderLength*pow(3,1/2);
		pPolyline->m_Point.Add((CObject*)pPoint);

		CADLine* pLine;
		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength/2;
		pLine->pt1.y = tempPoint.y;
		pLine->pt2.x = tempPoint.x + borderLength/2;
		pLine->pt2.y = pLine->pt1.y;

		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength*2/3/2;
		pLine->pt1.y = tempPoint.y - borderLength*1/3*pow(3,1/2);
		pLine->pt2.x = tempPoint.x + borderLength*2/3/2;
		pLine->pt2.y = pLine->pt1.y;

		pLine=new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength*1/3/2;
		pLine->pt1.y = tempPoint.y - borderLength*2/3*pow(3,1/2);
		pLine->pt2.x = tempPoint.x + borderLength*1/3/2;
		pLine->pt2.y = pLine->pt1.y;*/

		/*pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Text = "≈";
		pMText->m_Height = 2.5;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Location.x = m_HolePoints[i].x;
		pMText->m_Location.y = waterLineY;
		TransPoint(&pMText->m_Location);
		pMText->m_Location.y -= 1;*/
	}
}