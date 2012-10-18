#include "stdafx.h"
#include "CompressionCurve.h"
#define LegendWidth 0.8//cm
#include "..\FunctionLib\Function_System.h"

CCompressionCurve::CCompressionCurve(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{	
	m_pLayerGroup=pLayerGroup;
	m_pGraphics=pGraphics;
	m_pGraphics->m_pLayerGroup=pLayerGroup;
	m_FrameWidth = pGraphics->m_PaperWidth;// - 50;
	m_FrameHeight = pGraphics->m_PaperHeight;// - 40;
	m_FrameLeft = m_pGraphics->m_Extmin.x;// + (A4_HEIGHT - m_FrameWidth)/2;
	m_FrameTop = m_pGraphics->m_Extmax.y;// - (A4_WIDTH - m_FrameHeight)/2;
	m_LayerNum = 0;

	m_PaperType = PAPER_A4;
	m_paperTitle = "Consolidation Test";
	m_curveTitle = "Compression Curve";
}

CCompressionCurve::~CCompressionCurve()
{

}

void CCompressionCurve::FileImport(LPCTSTR lpFilename)
{
	m_fileName = lpFilename;
	m_LayerNum = ::GetPrivateProfileInt("土层","个数",0,lpFilename);
	if (m_LayerNum<=0)return;
	char str[255];
	::GetPrivateProfileString("图纸信息","图纸名称","",str,255,lpFilename);
	m_paperTitle = str;
	::GetPrivateProfileString("图纸信息","工程名称","",str,255,lpFilename);
	m_projectName = str;
	::GetPrivateProfileString("图纸信息","工程编号","",str,255,lpFilename);
	m_projectNo = str;
	::GetPrivateProfileString("图纸信息","执行标准","",str,255,lpFilename);
	m_doStandard = str;

	double chartLeft;
	double chartTop;
	double chartWidth;
	double chartHeight;

	chartLeft = m_FrameLeft;
	chartTop = m_FrameTop;
	chartWidth = m_FrameWidth/2;
	chartHeight = m_FrameHeight;

	int paperCount = (int)((float)m_LayerNum/2+0.5);
	/*CString str2;
	str2.Format("%d",paperCount);
	::AfxMessageBox(str2);*/
	for (int i=0;i<paperCount;i++)
	{
		CADLayer* pLayer;
		pLayer = new CADLayer();
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
		int curLayerIndex = m_pLayerGroup->indexOf(layerNum);
		CreateChart(chartLeft,chartTop,chartWidth,chartHeight,i*2+1,curLayerIndex);
		if (i==paperCount-1)
		{
			if (m_LayerNum/2==paperCount)
				CreateChart(chartLeft+chartWidth,chartTop,chartWidth,chartHeight,i*2+2,curLayerIndex);
		}
		else
			CreateChart(chartLeft+chartWidth,chartTop,chartWidth,chartHeight,i*2+2,curLayerIndex);
	}
}

void CCompressionCurve::CreateChart(double chartLeft,double chartTop,double chartWidth,double chartHeight,int nLayer,int curLayerIndex,int nScale)
{
//	int curLayerIndex = m_pLayerGroup->indexOf("0");
	double leftMargin,topMargin,centerX,centerY;
	CString CNFONT = "Arial";
	double spaceX = 0;
	double spaceY = 0;	
	CADMText* pMText;
	float FONTHEIGHT = 3.5*nScale;
	float FONTHEIGHT27 = 2.7*nScale;
	float FONTHEIGHT25 = 2.5*nScale;
	float FONTHEIGHT2 = 2*nScale;
	float tmpLeft = 0;
	float tmpTop = 0;
	CString keyName;
	CString section;
	CString strTmp;
	char str[255];

	keyName.Format("土层%d",nLayer);

	leftMargin = 12*nScale;//mm
	topMargin = 20*nScale;

	centerX = chartLeft + chartWidth/2;
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	
	pMText->m_Text = m_paperTitle;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = 7;
	pMText->m_Width = 3;
	pMText->m_Location.x = centerX;
	pMText->m_Location.y = chartTop - topMargin;

	double lineLen = chartWidth/2;
	CADLine* pLine;
///
/*	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = chartLeft + chartWidth;
	pLine->pt1.y = chartTop;
	pLine->pt2.x = chartLeft + chartWidth;
	pLine->pt2.y = chartTop-chartHeight;*/
///
	spaceY = pMText->m_Height;
	pLine=new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = centerX - lineLen/2;
	pLine->pt1.y = pMText->m_Location.y - spaceY;
	pLine->pt2.x = centerX + lineLen/2;
	pLine->pt2.y = pLine->pt1.y;

	spaceY = 0.5*nScale;//mm
	CADLine* pLine2;
	pLine2 = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine2);
	pLine2->m_nLayer = curLayerIndex;
	pLine2->pt1.x = centerX - lineLen/2;
	pLine2->pt1.y = pLine->pt1.y - spaceY;
	pLine2->pt2.x = centerX + lineLen/2;
	pLine2->pt2.y = pLine2->pt1.y;

	//1
	spaceY = 9*nScale;//mm
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Project Name";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = chartLeft + leftMargin;
	pMText->m_Location.y = pLine2->pt2.y - spaceY;

	tmpLeft = pMText->m_Location.x + 19*nScale;
	lineLen = 76*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = pMText->m_Location.y - pMText->m_Height;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

	tmpLeft = pLine->pt1.x;
	tmpTop = pMText->m_Location.y;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = " " + m_projectName;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = pLine->pt2.y - pLine->pt1.y;
	//pMText->m_isWarp = true;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	tmpLeft = pLine->pt2.x;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Project No.";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = pLine2->pt2.y - spaceY;

	tmpLeft = pMText->m_Location.x + 15*nScale;
	tmpTop = pMText->m_Location.y - pMText->m_Height;
	lineLen = 15*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

	tmpLeft = pLine->pt1.x;
	tmpTop = pMText->m_Location.y;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = m_projectNo;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = pLine->pt2.y - pLine->pt1.y;
	//pMText->m_isWarp = true;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	//2
	spaceY = 4*nScale;//mm
	tmpLeft = chartLeft + leftMargin;
	tmpTop = pLine->pt2.y - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Stratum Name && No.";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 20;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	//char* pszTemp = strtok(str, ",");

	tmpLeft = pMText->m_Location.x + 29*nScale;
	tmpTop = pMText->m_Location.y - pMText->m_Height;
	lineLen = 43*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

	section = "编号";
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);
	strTmp = str;
	//::AfxMessageBox(keyName);

	tmpLeft = pLine->pt1.x;
	tmpTop = pMText->m_Location.y;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = strTmp;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	tmpLeft = pLine->pt2.x;
	tmpTop = pMText->m_Location.y;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Compiled";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	tmpLeft = pMText->m_Location.x + 15*nScale;
	tmpTop = pMText->m_Location.y - pMText->m_Height;
	lineLen = 15*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

	tmpLeft = pLine->pt2.x;
	tmpTop = pMText->m_Location.y;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Date";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	tmpLeft = pMText->m_Location.x + 8*nScale;
	tmpTop = pMText->m_Location.y - pMText->m_Height;
	lineLen = 15*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

//draw grid=======================================================//
	spaceY = 4*nScale;//mm
	float gridLeft = chartLeft + leftMargin;
	float gridTop = pLine->pt2.y - spaceY;
	float gridWidth = 125*nScale;
	float gridHeight = 30*nScale;
	float gridHeaderHeight = 12*nScale;
	float gridFixWidth = 30*nScale;

	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer = curLayerIndex;
	pPolyline->m_Closed = true;
	pPolyline->m_nLineWidth=1;

	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft+gridWidth;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft+gridWidth;
	pPoint->y = gridTop-gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridTop-gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	tmpLeft = gridLeft;
	tmpTop = gridTop - gridHeaderHeight;
	lineLen = gridWidth*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	pLine->pt2.x = pLine->pt1.x + lineLen;
	pLine->pt2.y = pLine->pt1.y;

	float cellHeight = (gridHeight - gridHeaderHeight)/3;
	for (int i=0;i<3-1;i++)
	{
		tmpLeft = gridLeft;
		tmpTop = gridTop - gridHeaderHeight - cellHeight*(i+1);
		lineLen = gridWidth*nScale;
		pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1.x = tmpLeft;
		pLine->pt1.y = tmpTop;
		pLine->pt2.x = pLine->pt1.x + lineLen;
		pLine->pt2.y = pLine->pt1.y;		
	}

	tmpLeft = gridLeft + gridFixWidth;
	tmpTop = gridTop;
	lineLen = gridWidth*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	tmpLeft = gridLeft + gridFixWidth;
	tmpTop = gridTop - gridHeaderHeight - cellHeight;
	pLine->pt2.x = tmpLeft;
	pLine->pt2.y = tmpTop;
	//draw header
	spaceX = 2*nScale;
	spaceY = 1*nScale;
	tmpLeft = gridLeft + gridFixWidth/2 + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "Pressure kPa";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT27;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

/*	spaceX = 7*nScale;
	tmpLeft = gridLeft + gridFixWidth - spaceX;
	tmpTop = gridTop - gridHeaderHeight/2;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "力";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT2;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;
*/
/*	spaceX = 5*nScale;
	spaceY = 3*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "变";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT2;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;


	spaceX = 9*nScale;
	spaceY = 6*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "形";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT2;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	spaceX = 15*nScale;
	spaceY = 9*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "量(mm)";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT2;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;
*/
	spaceX = 5*nScale;
	spaceY = 6*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Item";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

/*	spaceX = 1.5*nScale;
	spaceY = 8*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "别";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT2;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;
*/
	int compressCount = 0;
	m_CompressCount	  = 0;
	section = "压力";
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);

	char *pszTemp = strtok(str, ",");
	while (pszTemp)
	{
		compressCount++;
		pszTemp = strtok(NULL, ",");
		if(pszTemp==NULL)break;
	}

	m_CompressCount = compressCount;

	m_pCompressValue = new int[compressCount];
	m_pEValue = new float[compressCount];

	i = 0;
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);
	pszTemp = strtok(str, ",");
	while (pszTemp)
	{
		m_pCompressValue[i] = atoi(pszTemp);
		pszTemp = strtok(NULL, ",");
		if (pszTemp==NULL)break;
		i++;
	}

	section = "孔隙比";
	i = 0;
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);
	pszTemp = strtok(str, ",");
	while (pszTemp)
	{
		if (i+1>m_CompressCount)break;
		m_pEValue[i] = atof(pszTemp);
		pszTemp = strtok(NULL, ",");
		if (pszTemp==NULL)break;
		i++;
	}

	float cellWidth = (gridWidth - gridFixWidth)/compressCount;
	for (i=0;i<compressCount-1;i++)
	{
		tmpLeft = gridLeft + gridFixWidth + cellWidth*(i+1);
		tmpTop = gridTop;
		pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1.x = tmpLeft;
		pLine->pt1.y = tmpTop;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = pLine->pt1.y - (gridHeight-cellHeight*2);
	}
	for (i=0;i<compressCount-1;i++)
	{
		tmpLeft = gridLeft + gridFixWidth + cellWidth/2 + cellWidth*i;
		tmpTop = gridTop - (gridHeight-cellHeight*2);
		pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1.x = tmpLeft;
		pLine->pt1.y = tmpTop;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = gridTop - gridHeight;
	}

	float COMPRESSFONT = FONTHEIGHT+0.5;
	for (i=0;i<compressCount;i++)
	{
		tmpLeft = gridLeft + gridFixWidth + cellWidth*i+cellWidth/2;
		tmpTop = gridTop - gridHeaderHeight/2;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Text.Format("%d",m_pCompressValue[i]);
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = COMPRESSFONT;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;

		tmpLeft = gridLeft + gridFixWidth + cellWidth*i+cellWidth/2;
		tmpTop = gridTop - gridHeaderHeight - cellHeight/2;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Text.Format("%.3f",m_pEValue[i]);
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = COMPRESSFONT;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;
	}

	spaceY = 0.5*nScale;
	tmpLeft = gridLeft + (gridFixWidth+cellWidth/2)/2;
	tmpTop = gridTop - gridHeaderHeight - cellHeight - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "Coefficient of\ncompressibility  av i-i+1(MPa-1)";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT27;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	spaceY = 0.5*nScale;
	tmpLeft = gridLeft + (gridFixWidth+cellWidth/2)/2;
	tmpTop = gridTop - gridHeaderHeight - cellHeight*2 - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = "Modulus of\ncompressibility Es(MPa)";//"Modulus of\nK=1.000 compressibility Es(MPa)";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT27;
	pMText->m_Width = 15;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	section = "压缩系数";
	i = 1;
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);
	pszTemp = strtok(str, ",");
	while (pszTemp)
	{
		tmpLeft = gridLeft + gridFixWidth + cellWidth*i;
		tmpTop = gridTop - gridHeaderHeight - cellHeight - cellHeight/2;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Text = pszTemp;
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = COMPRESSFONT;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;


		pszTemp = strtok(NULL, ",");
		if (pszTemp==NULL)break;
		i++;
	}

	section = "压缩模量";
	i = 1;
	GetPrivateProfileString(keyName,section,"",str,255,m_fileName);
	pszTemp = strtok(str, ",");
	while (pszTemp)
	{
		tmpLeft = gridLeft + gridFixWidth + cellWidth*i;
		tmpTop = gridTop - gridHeaderHeight - cellHeight*2 - cellHeight/2;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
		pMText->m_Text = pszTemp;
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = COMPRESSFONT;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;


		pszTemp = strtok(NULL, ",");
		if (pszTemp==NULL)break;
		i++;
	}
	//draw fix col
	tmpLeft = gridLeft;
	tmpTop = gridTop;
	lineLen = gridWidth*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	tmpLeft = gridLeft + gridFixWidth;
	tmpTop = gridTop - gridHeaderHeight;
	pLine->pt2.x = tmpLeft;
	pLine->pt2.y = tmpTop;

/*	tmpLeft = gridLeft;
	tmpTop = gridTop;
	lineLen = gridWidth*nScale;
	pLine = new CADLine();
	m_pGraphics->m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->pt1.x = tmpLeft;
	pLine->pt1.y = tmpTop;
	tmpLeft = gridLeft + gridFixWidth/4;
	tmpTop = gridTop - gridHeaderHeight;
	pLine->pt2.x = tmpLeft;
	pLine->pt2.y = tmpTop;*/

	tmpLeft = gridLeft + gridFixWidth/2;
	tmpTop = gridTop - gridHeaderHeight - (gridHeight - gridHeaderHeight)/6;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_MIDDLECENTER;
	pMText->m_Text = "Void ratio  e";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT27;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;

	CreateCurveChart(chartLeft,gridTop-gridHeight,chartWidth,chartHeight,nLayer,curLayerIndex);
}

void CCompressionCurve::CreateCurveChart(double chartLeft,double chartTop,double chartWidth,double chartHeight,int nLayer,int curLayerIndex,int nScale)
{
//压 缩 曲 线 图
//	int curLayerIndex = m_pLayerGroup->indexOf("0");
	double leftMargin,topMargin,centerX,centerY;
	CString CNFONT = "Arial";
	double spaceX = 0;
	double spaceY = 0;	
	CADMText* pMText;
	float FONTHEIGHT = 3.5*nScale;
	float FONTHEIGHT25 = 2.5*nScale;
	float FONTHEIGHT2 = 2*nScale;
	float tmpLeft = 0;
	float tmpTop = 0;
	CString keyName;
	CString section;
	CString strTmp;
	char str[255];

	keyName.Format("土层%d",nLayer);

	leftMargin = 12*nScale;//mm
	topMargin = 5*nScale;

	centerX = chartLeft + chartWidth/2;
	
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
	pMText->m_Text = m_curveTitle;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = 6;
	pMText->m_Width = 3;
	pMText->m_Location.x = centerX;
	pMText->m_Location.y = chartTop - topMargin;

//draw grid=======================================================//

	spaceY = 2*nScale;//mm
	float gridLeft = chartLeft + leftMargin;
	float gridTop = pMText->m_Location.y - pMText->m_Height - spaceY;
	float gridWidth = 125*nScale;
	float gridHeight = 90*nScale;
	float gridHeaderHeight = 12*nScale;
	float gridFixWidth = 30*nScale;

	float gridLeft2 = gridLeft + 12;
	float gridTop2 = gridTop - 7;
	float gridWidth2 = gridWidth - 12 -5;
	float gridHeight2 = gridHeight - 7 - 8;

	CADPolyline* pPolyline;
	ADPOINT* pPoint;
	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer = curLayerIndex;
	pPolyline->m_Closed = true;
	pPolyline->m_nLineWidth=1;

	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft+gridWidth;
	pPoint->y = gridTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft+gridWidth;
	pPoint->y = gridTop-gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft;
	pPoint->y = gridTop-gridHeight;
	pPolyline->m_Point.Add((CObject*)pPoint);

	spaceX = 1*nScale;
	spaceY = 3*nScale;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_MIDDLELEFT;
	pMText->m_Text = "Void\nRatio\n\n\n  e";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT25;
	pMText->m_Width = 3;
	pMText->m_Location.x = gridLeft + spaceX;
	pMText->m_Location.y = gridTop - gridHeight/2 + spaceY;

	spaceX = 1*nScale;
	spaceY = 1*nScale;
	pMText=new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_BOTTOMCENTER;
	pMText->m_Text = "Pressure(P)kPa";
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT25;
	pMText->m_Width = 3;
	pMText->m_Location.x = gridLeft + gridWidth/2;
	pMText->m_Location.y = gridTop - gridHeight + spaceY;

	//grid 2
	spaceX = 20*nScale;
	spaceY = 10*nScale;

	pPolyline=new CADPolyline();
	m_pGraphics->m_Entities.Add((CObject*)pPolyline);
	pPolyline->m_nLayer = curLayerIndex;
	pPolyline->m_Closed = true;
	pPolyline->m_nLineWidth=1;

	pPoint=new ADPOINT();
	pPoint->x = gridLeft2;
	pPoint->y = gridTop2;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft2+gridWidth2;
	pPoint->y = gridTop2;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft2+gridWidth2;
	pPoint->y = gridTop2-gridHeight2;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = gridLeft2;
	pPoint->y = gridTop2-gridHeight2;
	pPolyline->m_Point.Add((CObject*)pPoint);

	float cellXWidth = gridWidth2/8;
	float cellYHeigt = gridHeight2/10;

	for (int i=0;i<8-1;i++)
	{
		tmpLeft = gridLeft2 + cellXWidth*(i+1);
		tmpTop = gridTop2;
		CADLine *pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1.x = tmpLeft;
		pLine->pt1.y = tmpTop;
		pLine->pt2.x = pLine->pt1.x;
		pLine->pt2.y = pLine->pt1.y - gridHeight2;
	}
	for (int j=0;j<10-1;j++)
	{
		tmpLeft = gridLeft2;
		tmpTop = gridTop2 - cellYHeigt*(j+1);
		CADLine *pLine = new CADLine();
		m_pGraphics->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->pt1.x = tmpLeft;
		pLine->pt1.y = tmpTop;
		pLine->pt2.x = pLine->pt1.x + gridWidth2;
		pLine->pt2.y = pLine->pt1.y;
	}

	//m_CompressCount = compressCount;

	//m_pCompressValue = new int[compressCount];
	//m_pEValue = new float[compressCount];
	int maxCompressValue = m_pCompressValue[m_CompressCount-1];
	int cellCompressValue = (int)maxCompressValue/8;

	spaceY = 1*nScale;
	for (i=0;i<8+1;i++)
	{
		CString strTmp;
		if (i==0)
			strTmp = "0";
		else
			strTmp.Format("%d",cellCompressValue*i);
		tmpLeft = gridLeft2 + cellXWidth*i;
		tmpTop = gridTop2 - gridHeight2 - spaceY;
		pMText=new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_TOPCENTER;
		pMText->m_Text = strTmp;
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = FONTHEIGHT2;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;
	}

	float minEValue = m_pEValue[m_CompressCount-1];
	float maxEValue = m_pEValue[0];

	float startEValue = 0.5;
	float cellEValue = 0.05;
	float endEvalue = 0;
	if (minEValue>=1)
		startEValue = 1;
	if (minEValue>=0.5 && minEValue<1)
		startEValue = 0.5;
	else if (minEValue>=0.0 && minEValue<0.5)
	{
		startEValue = 0.0;	
	}
	else
		startEValue = 0.0;

	if (maxEValue>1.0 && maxEValue<5.0)
		cellEValue = 0.1;
	else if (maxEValue>=5.0 && maxEValue<10.0)
		cellEValue = 0.5;
	else if (maxEValue>=10.0)
		cellEValue = 1.0;

	endEvalue = startEValue + cellEValue*10;
	if (maxEValue>endEvalue)
	{
		if (maxEValue<1.0)
			cellEValue = 0.1;
		else if (maxEValue>=1.0 && maxEValue<5.0)
			cellEValue = 0.5;
		else if (maxEValue>=5.0 && maxEValue<10.0)
			cellEValue = 1.0;
		else if (maxEValue>=10.0)
			cellEValue = 2.0;
		endEvalue = startEValue + cellEValue*10;
	}

	spaceX = 1*nScale;
	for (j=0;j<10+1;j++)
	{
		CString strTmp;
		strTmp.Format("%.2f",startEValue + cellEValue*j);
		tmpLeft = gridLeft2 - spaceX;
		tmpTop = gridTop2 - gridHeight2 + cellYHeigt*j;
		pMText = new CADMText();
		m_pGraphics->m_Entities.Add((CObject*)pMText);
		pMText->m_nLayer = curLayerIndex;
		pMText->m_Align = AD_MTEXT_ATTACH_MIDDLERIGHT;
		pMText->m_Text = strTmp;
		strcpy(pMText->m_Font,CNFONT);
		pMText->m_Height = FONTHEIGHT2;
		pMText->m_Width = 3;
		pMText->m_Location.x = tmpLeft;
		pMText->m_Location.y = tmpTop;
	}

	//draw curve
	CADSpline* pSpline;

	pSpline=new CADSpline();
	m_pGraphics->m_Entities.Add((CObject*)pSpline);
	pSpline->m_nLayer = curLayerIndex;
	pSpline->m_nLineWidth = 2;
	pSpline->m_bNode = true;

	for (i=0;i<m_CompressCount;i++)
	{
		pPoint=new ADPOINT();
		pPoint->x = gridLeft2 + 0 + gridWidth2 * m_pCompressValue[i]/maxCompressValue;
		pPoint->y = gridTop2 - gridHeight2 + gridHeight2 * (m_pEValue[i]-startEValue)/(endEvalue-startEValue);
		pSpline->m_FitPoint.Add((CObject*)pPoint);
	}

	spaceX = 2*nScale;
	spaceY = 2*nScale;
	tmpLeft = gridLeft + spaceX;
	tmpTop = gridTop - gridHeight - spaceY;
	pMText = new CADMText();
	m_pGraphics->m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer = curLayerIndex;
	pMText->m_Align = AD_MTEXT_ATTACH_TOPLEFT;
	pMText->m_Text = "Executive Standard："+m_doStandard;
	strcpy(pMText->m_Font,CNFONT);
	pMText->m_Height = FONTHEIGHT25;
	pMText->m_Width = 3;
	pMText->m_Location.x = tmpLeft;
	pMText->m_Location.y = tmpTop;
}