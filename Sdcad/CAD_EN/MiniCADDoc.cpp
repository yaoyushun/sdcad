// MiniCADDoc.cpp : implementation of the CMiniCADDoc class
//

#include "stdafx.h"
#include "MiniCAD.h"

#include "MiniCADDoc.h"
#include "MiniCADView.h"
#include "DlgLayerAdmin.h"
#include "Project\HistogramIniFile.h"
#include "Project\HistogramIniFile2.h"
#include "Project\HistogramIniFile3.h"
#include "Project\HistogramIniFile4.h"
#include "MainFrm.h"
#include "FunctionLib\Function_System.h"
#include "Project\Project_LegendDisplay.h"
#include "Project\CrossBoardIniFile.h"
#include "Project\LayoutIniFile.h"
#include "Project\StaticIniFile.h"
#include "Project\StaticIniFile2.h"

#include "Project\CompressionCurve.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CMiniCADDoc

IMPLEMENT_DYNCREATE(CMiniCADDoc, CDocument)

BEGIN_MESSAGE_MAP(CMiniCADDoc, CDocument)
	//{{AFX_MSG_MAP(CMiniCADDoc)
	ON_COMMAND(ID_MENU_Import, OnMENUImport)
	ON_COMMAND(ID_FILE_OPEN2, OnFileOpen2)
	ON_COMMAND(ID_FILE_OPEN3, OnFileOpen3)
	ON_COMMAND(ID_FILE_OPEN4, OnFileOpen4)
	ON_COMMAND(ID_FILE_OPEN5, OnFileOpen5)
	ON_COMMAND(ID_IMPORTHOLE, OnImporthole)
	ON_UPDATE_COMMAND_UI(ID_IMPORTHOLE, OnUpdateImporthole)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMiniCADDoc construction/destruction

CMiniCADDoc::CMiniCADDoc()
{
	strcpy(m_curLayer,"0");
	m_pPaperGraphics=NULL;
	m_Graphics.m_pLayerGroup=&m_LayerGroup;
	m_isLayout=false;
	m_bImport = false;
}

CMiniCADDoc::~CMiniCADDoc()
{

}

BOOL CMiniCADDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	OpenProjectIni();
/*	CADLayer* pLayer = new CADLayer();
	m_LayerGroup.AddLayer(pLayer);
	strcpy(pLayer->m_Name,"0");
*/
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADDoc serialization

void CMiniCADDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}

/////////////////////////////////////////////////////////////////////////////
// CMiniCADDoc diagnostics

#ifdef _DEBUG
void CMiniCADDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CMiniCADDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CMiniCADDoc commands

void CMiniCADDoc::OnMENUImport() 
{
 	TCHAR szFilters[]=_T("INI 文件(*.ini)|*.ini|所有文件(*.*)|*.*||");
	CFileDialog dlg(true,_T("ini"),_T("*.ini"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters);
 	//TCHAR szFilters[]=_T("DXF 文件(*.dwg)|*.dwg|所有文件(*.*)|*.*||");
	//CFileDialog dlg(true,_T("dwg"),_T("*.dwg"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters); 
 	if(dlg.DoModal()==IDOK)
	{
		OpenSectionIni(dlg.GetPathName());
	}		
}

BOOL CMiniCADDoc::OnOpenDocument(LPCTSTR lpszPathName) 
{
	if (!CDocument::OnOpenDocument(lpszPathName))
		return FALSE;

	//add hole legend layer

	CADGraphics::isCreateHandle=false;
	CDxfFile DxfFile(&m_LayerGroup,&m_Graphics);
	DxfFile.m_isReadHatch=false;
	DxfFile.FileImport(lpszPathName);
	CADGraphics::isCreateHandle=true;

	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC());
	pView->Invalidate(false);

	return TRUE;
}

void CMiniCADDoc::OnFileOpen2() 
{
 	TCHAR szFilters[]=_T("INI 文件(*.ini)|*.ini|所有文件(*.*)|*.*||");
	CFileDialog dlg(true,_T("ini"),_T("*.ini"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters);
 	if(dlg.DoModal()==IDOK)
	{
		OpenHistogramIni(dlg.GetPathName());
	}
}

BOOL CMiniCADDoc::OnSaveDocument(LPCTSTR lpszPathName) 
{
//	if(m_ProjectType!=PROJECT_SECTION)return false;
//		CDocument::OnSaveDocument(lpszPathName);
	CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);
	pDxfFile->FileExport(lpszPathName);
	delete pDxfFile;
	return true;
}

void CMiniCADDoc::OnFileOpen3() 
{
 	TCHAR szFilters[]=_T("INI 文件(*.ini)|*.ini|所有文件(*.*)|*.*||");
	CFileDialog dlg(true,_T("ini"),_T("*.ini"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters);
 	//TCHAR szFilters[]=_T("DXF 文件(*.dwg)|*.dwg|所有文件(*.*)|*.*||");
	//CFileDialog dlg(true,_T("dwg"),_T("*.dwg"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters); 
 	if(dlg.DoModal()==IDOK)
	{
		OpenStaticIni(dlg.GetPathName());
	}
}

void CMiniCADDoc::OpenProjectIni()
{
	BeginWaitCursor();

	CString str=AfxGetApp()->m_lpCmdLine;
	int i=str.Find(',');

	short flag=atoi(str.Left(i));
//updated on 2006/12/30
	m_SplitChar = "^";
	CString filename;
	//filename=str.Right(str.GetLength()-i-1);
	str = str.Right(str.GetLength()-i-1);
	i = str.Find(',');
	if (i>0)
	{
		filename = str.Left(i);
		m_SplitChar=str.Right(str.GetLength()-i-1);
	}
	else
		//filename=str.Right(str.GetLength()-i-1);
		filename=str;
	
	switch(flag)
	{
		case 1:
			m_ProjectType=PROJECT_SECTION;
			CMiniCADApp* pApp;
			pApp=(CMiniCADApp*)AfxGetApp();
			//pApp->m_bSave = true;
			OpenSectionIni(filename);
			break;
		case 2:
			m_ProjectType=PROJECT_HISTOGRAM;
			OpenHistogramIni(filename);
			break;
		case 3:
			m_ProjectType=PROJECT_STATIC;
			OpenStaticIni(filename);
			break;
		case 4:
			m_ProjectType=PROJECT_LAYOUT;
			pApp=(CMiniCADApp*)AfxGetApp();
			OpenLayoutIni(filename);
			m_isLayout=true;
			break;
		case 5:
			m_ProjectType=PROJECT_LEGEND;
			OpenLegendIni(filename);
			break;
		case 6:
			m_ProjectType=PROJECT_CROSSBOARD;
			OpenCrossBoardIni(filename);
			break;
		//<--added on 2005/8/23
		case 7:
			m_ProjectType=PROJECT_STATIC;
			OpenStaticIni2(filename);
			break;
		//-->
		//<--added on 2007/1/23
		case 8:
			m_ProjectType = PROJECT_CompressionCurve;
			OpenCompressionCurve(filename);
			break;
		//-->
		//<--added on 2008/11/10
		case 9:
			m_ProjectType = PROJECT_HISTOGRAM2;
			OpenHistogramIni2(filename);
			break;
		//-->
		//<--added on 2008/11/10
		case 10:
			m_ProjectType = PROJECT_HISTOGRAM3;
			OpenHistogramIni3(filename);
			break;
		//-->
		//<--added on 2009/04/02
		case 11:
			m_ProjectType = PROJECT_HISTOGRAM4;
			OpenHistogramIni4(filename);
			break;
		//-->
	}
	EndWaitCursor();
}

void CMiniCADDoc::OpenSectionIni(LPCTSTR lpFilename)
{
	CString extStr=lpFilename;
	extStr=extStr.Right(3);
	if(strcmp(extStr,"ini")!=0 && strcmp(extStr,"dxf")!=0)return;
//----------------------------------------------------------
	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
	//pView->m_GraphicsMode=Layout; 
//----------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//----------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_bLineWidth=false; 
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=HORIZONTAL;
//----------------------------------------------------------
	if(strcmp(extStr,"ini")==0)
	{
		CADLayer* pLayer;
		pLayer=new CADLayer();
		m_Graphics.m_pLayerGroup->AddLayer(pLayer);
		strcpy(pLayer->m_Name,PROJECTHOLELAYERNAME);
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
			pLayer->m_nColor=7;
		////////////////////////////////////////////////////
		int curLayerIndex = m_LayerGroup.indexOf(PROJECTHOLELAYERNAME);

/*		CADBlock* pBlock;
		pBlock=new CADBlock();
		strcpy(pBlock->m_Name,"稳定水位线");
		m_Graphics.m_Blocks.Add((CObject*)pBlock);
		//strcpy(pBlock->m_Handle,"20");
		pBlock->m_nLayer = curLayerIndex;*/

		CADBlock* pBlock;
		pBlock = new CADBlock();
		CADGraphics::CreateHandle(pBlock->m_Handle2);
		m_Graphics.m_Blocks.Add((CObject*)pBlock);
		pBlock->m_nLayer = curLayerIndex; 
		strcpy(pBlock->m_Name,"稳定水位线");
		pBlock->m_BasePoint.x = 0;
		pBlock->m_BasePoint.y = 0;

		CADBlockRecord* pBlockRecord = new CADBlockRecord();
		m_Graphics.m_BlockRecords.Add((CObject*)pBlockRecord);
		strcpy(pBlockRecord->m_Name,pBlock->m_Name);
		CADGraphics::CreateHandle(pBlockRecord->m_Handle);


		const float borderLength = 2;
		CADPolyline* pPolyline = new CADPolyline();
		pPolyline->m_nLayer = curLayerIndex;
		pPolyline->m_Closed = true;
		pBlock->m_Entities.Add((CObject*)pPolyline);

		ADPOINT tempPoint = {0.0,0.0};
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
		pBlock->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength/2;
		pLine->pt1.y = tempPoint.y;
		pLine->pt2.x = tempPoint.x + borderLength/2;
		pLine->pt2.y = pLine->pt1.y;

		pLine=new CADLine();
		pBlock->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength*2/3/2;
		pLine->pt1.y = tempPoint.y - borderLength*1/3*pow(3,1/2);
		pLine->pt2.x = tempPoint.x + borderLength*2/3/2;
		pLine->pt2.y = pLine->pt1.y;

		pLine=new CADLine();
		pBlock->m_Entities.Add((CObject*)pLine);
		pLine->m_nLayer = curLayerIndex;
		pLine->m_nLineWidth = 2;
		pLine->pt1.x = tempPoint.x - borderLength*1/3/2;
		pLine->pt1.y = tempPoint.y - borderLength*2/3*pow(3,1/2);
		pLine->pt2.x = tempPoint.x + borderLength*1/3/2;
		pLine->pt2.y = pLine->pt1.y;
		//////////////////////////////////////////////////////////////

		CProjectIniFile ProjectIniFile(&m_LayerGroup,&m_Graphics);
		m_Graphics.CreateDefault();
		ReadLinFile();
		ProjectIniFile.FileImport(lpFilename);
		pView->m_PaperType = ProjectIniFile.m_PaperType;
	}

	if(strcmp(extStr,"dxf")==0)
	{
		CDxfFile DxfFile(&m_LayerGroup,&m_Graphics);
		DxfFile.FileImport(lpFilename);
		m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+A3_WIDTH*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+A3_HEIGHT*m_Graphics.m_mYPixel;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;
	}
//----------------------------------------------------------
	//OpenLegendFile();
	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
	SetModifiedFlag();
}

void CMiniCADDoc::OpenHistogramIni(LPCTSTR lpFilename)
{
		CString extStr=lpFilename;
		extStr=extStr.Right(3);
		if(strcmp(extStr,"ini")!=0)return;
		m_Graphics.CreateDefault();
		ReadLinFile();

		CMiniCADView* pView;
		POSITION pos=GetFirstViewPosition();
		pView=(CMiniCADView*)GetNextView(pos);
//--------------------------------------------------------
		CDC* dc=pView->GetDC();
		int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
		int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
		int Xpixels=dc->GetDeviceCaps(HORZRES);
		int Ypixels=dc->GetDeviceCaps(VERTRES);
		DeleteDC(dc->m_hDC);
//---------------------------------------------------------
		double mXPixel=(double)Xpixels/((double)Xmilimeters);
		double mYPixel=(double)Ypixels/((double)Ymilimeters);

		m_Graphics.m_BKColor=RGB(173,174,173);
		m_Graphics.m_WhiteColor=RGB(0,0,0); 
		m_Graphics.m_GraphicsMode=Layout;
		m_Graphics.m_mXPixel=mXPixel;
		m_Graphics.m_mYPixel=mYPixel;
		m_Graphics.m_Unit=UNIT_MILLIMETER;

		//CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);

		char HistogramFile[255];
		GetAppDir(HistogramFile);
		//updated on 2005/8/23
		//strcat(HistogramFile,"Project3.dxf");
		//<--
		//int projectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		//if (projectType==0)strcat(HistogramFile,"Project31.dxf");
		//else strcat(HistogramFile,"Project32.dxf");
		//-->
		//pDxfFile->FileImport(HistogramFile);
		//delete pDxfFile;

		//<--added on 2005/8/29
		/*CADLayer* pLayer = new CADLayer();
		m_LayerGroup.AddLayer(pLayer);
		strcpy(pLayer->m_Name,"0");
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
		pLayer->m_nColor=7;*/
		//-->

		m_Graphics.m_PrintWidth=419.51;
		m_Graphics.m_PrintHeight=296.38;

		m_Graphics.m_Bound.left = 0.0;//
		m_Graphics.m_Bound.top = -280;

		m_Graphics.m_Bound.left -= 40;
		m_Graphics.m_Bound.top -= 10;//23;

		m_Graphics.m_Bound.right = m_Graphics.m_Bound.left+m_Graphics.m_PrintWidth;
		m_Graphics.m_Bound.bottom = m_Graphics.m_Bound.top+m_Graphics.m_PrintHeight;

		m_Graphics.m_Bound.left*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top*=m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom*=m_Graphics.m_mYPixel;

		m_Graphics.m_Extmin.x = 0;//
		m_Graphics.m_Extmin.y = 2;
		m_Graphics.m_Extmax.x = 355;
		m_Graphics.m_Extmax.y = 280;

		//<--******************************************
		double paperDeep = 178 + 30-2;//178;
		int vScale=::GetPrivateProfileInt("比例尺","Y",0,lpFilename);
		if (vScale==0)return;
		char str[100];
		bool bOnePage = true;
		if (::GetPrivateProfileInt("比例尺","一页打印",0,lpFilename)==0)
			bOnePage = true;
		else
			bOnePage = false;

		GetPrivateProfileString("钻孔","孔深","",str,255,lpFilename);
		int nProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);

		//m_Deep=(int)atof(str);
		float deep = atof(str);

		int nPaperCount;
		double mmDeep = (double)deep/vScale*1000;
		if (bOnePage)
		{
			nPaperCount = 1;
		}
		else
			nPaperCount = (short)(mmDeep / paperDeep) + 1;
/*
		if (nPaperCount==1 || (nPaperCount>1 && nProjectType==0))//nProjectType==0工民建
		{
		//-->******************************************
*/
		m_Graphics.m_Extmin.x -= 40;
		m_Graphics.m_Extmax.y += 10;//23;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;

		CHistogramIniFile HistogramIniFile(&m_LayerGroup,&m_Graphics);
		//added on 2005/830
		HistogramIniFile.m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		HistogramIniFile.m_SplitChar = m_SplitChar;
		HistogramIniFile.FileImport(lpFilename);
		CMainFrame*		m_pMain;
		m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
		if(HistogramIniFile.m_nPaperCount == 1)
		{
			m_pMain->AddComboPaper("共 1 页",0);
		}
		else
		{
			CString str;
			for (int i=0; i<HistogramIniFile.m_nPaperCount; i++)
			{
				str.Format("第 %d 页",i+1);
				m_pMain->AddComboPaper(str,i+1);
			}
		}
		if (HistogramIniFile.m_nPaperCount > 0)
			m_pMain->SetComboSel(0);

/*		//<--******************************************
		}
		else if (nPaperCount>1 && nProjectType==1)
		{//::AfxMessageBox("aaa");
			//updated on 20081105
			m_Graphics.m_Extmin.x -= 15;///40;
			m_Graphics.m_Extmax.y += 10;//23;

			m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
			m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;

			CHistogramIniFile4 HistogramIniFile(&m_LayerGroup,&m_Graphics);
			//added on 2005/830
			HistogramIniFile.m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
			 
			HistogramIniFile.FileImport(lpFilename);
			CMainFrame*		m_pMain;
			m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
			if(HistogramIniFile.m_nPaperCount == 1)
			{
				m_pMain->AddComboPaper("共 1 页",0);
			}
			else
			{
				CString str;
				for (int i=0; i<HistogramIniFile.m_nPaperCount; i++)
				{
					str.Format("第 %d 页",i+1);
					m_pMain->AddComboPaper(str,i+1);
				}
			}
			if (HistogramIniFile.m_nPaperCount > 0)
				m_pMain->SetComboSel(0);
		}
		//-->******************************************
*/
		m_Graphics.CalZoomRate();
		m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
		m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
		pView->Invalidate(false);
}

void CMiniCADDoc::OpenHistogramIni2(LPCTSTR lpFilename)
{
		CString extStr=lpFilename;
		extStr=extStr.Right(3);
		if(strcmp(extStr,"ini")!=0)return;
		m_Graphics.CreateDefault();
		ReadLinFile();

		CMiniCADView* pView;
		POSITION pos=GetFirstViewPosition();
		pView=(CMiniCADView*)GetNextView(pos);
//--------------------------------------------------------
		CDC* dc=pView->GetDC();
		int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
		int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
		int Xpixels=dc->GetDeviceCaps(HORZRES);
		int Ypixels=dc->GetDeviceCaps(VERTRES);
		DeleteDC(dc->m_hDC);
//---------------------------------------------------------
		double mXPixel=(double)Xpixels/((double)Xmilimeters);
		double mYPixel=(double)Ypixels/((double)Ymilimeters);

		m_Graphics.m_BKColor=RGB(173,174,173);
		m_Graphics.m_WhiteColor=RGB(0,0,0); 
		m_Graphics.m_GraphicsMode=Layout;
		m_Graphics.m_mXPixel=mXPixel;
		m_Graphics.m_mYPixel=mYPixel;
		m_Graphics.m_Unit=UNIT_MILLIMETER;

		//CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);

		char HistogramFile[255];
		GetAppDir(HistogramFile);
		//updated on 2005/8/23
		//strcat(HistogramFile,"Project3.dxf");
		//<--
		//int projectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		//if (projectType==0)strcat(HistogramFile,"Project31.dxf");
		//else strcat(HistogramFile,"Project32.dxf");
		//-->
		//pDxfFile->FileImport(HistogramFile);
		//delete pDxfFile;

		//<--added on 2005/8/29
		/*CADLayer* pLayer = new CADLayer();
		m_LayerGroup.AddLayer(pLayer);
		strcpy(pLayer->m_Name,"0");
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
		pLayer->m_nColor=7;*/
		//-->

		m_Graphics.m_PaperOrient=VERTICAL;
		//m_Graphics.m_PrintWidth=419.51;
		//m_Graphics.m_PrintHeight=296.38;
		m_Graphics.m_PrintWidth=419.51;
		m_Graphics.m_PrintHeight=296.38;

		m_Graphics.m_Bound.left = 0.0;//
		m_Graphics.m_Bound.top = -280;

		m_Graphics.m_Bound.left -= 40;
		m_Graphics.m_Bound.top -= 10;//23;

		m_Graphics.m_Bound.right = m_Graphics.m_Bound.left+m_Graphics.m_PrintWidth;
		m_Graphics.m_Bound.bottom = m_Graphics.m_Bound.top+m_Graphics.m_PrintHeight;

		m_Graphics.m_Bound.left*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top*=m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom*=m_Graphics.m_mYPixel;

		m_Graphics.m_Extmin.x = 0;//
		m_Graphics.m_Extmin.y = 2;
		m_Graphics.m_Extmax.x = 355;
		m_Graphics.m_Extmax.y = 280;

		//updated on 20081105
		m_Graphics.m_Extmin.x -= 25;//10
		m_Graphics.m_Extmax.y += 20;//23;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;

		CHistogramIniFile2 HistogramIniFile(&m_LayerGroup,&m_Graphics);
		//added on 2005/830
		HistogramIniFile.m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		 
		HistogramIniFile.FileImport(lpFilename);
		CMainFrame*		m_pMain;
		m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
		if(HistogramIniFile.m_nPaperCount == 1)
		{
			m_pMain->AddComboPaper("共 1 页",0);
		}
		else
		{
			CString str;
			for (int i=0; i<HistogramIniFile.m_nPaperCount; i++)
			{
				str.Format("第 %d 页",i+1);
				m_pMain->AddComboPaper(str,i+1);
			}
		}
		if (HistogramIniFile.m_nPaperCount > 0)
			m_pMain->SetComboSel(0);

		m_Graphics.CalZoomRate();
		m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
		m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
		pView->Invalidate(false);
}

void CMiniCADDoc::OpenHistogramIni3(LPCTSTR lpFilename)
{
		CString extStr=lpFilename;
		extStr=extStr.Right(3);
		if(strcmp(extStr,"ini")!=0)return;
		m_Graphics.CreateDefault();
		ReadLinFile();

		CMiniCADView* pView;
		POSITION pos=GetFirstViewPosition();
		pView=(CMiniCADView*)GetNextView(pos);
//--------------------------------------------------------
		CDC* dc=pView->GetDC();
		int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
		int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
		int Xpixels=dc->GetDeviceCaps(HORZRES);
		int Ypixels=dc->GetDeviceCaps(VERTRES);
		DeleteDC(dc->m_hDC);
//---------------------------------------------------------
		double mXPixel=(double)Xpixels/((double)Xmilimeters);
		double mYPixel=(double)Ypixels/((double)Ymilimeters);

		m_Graphics.m_BKColor=RGB(173,174,173);
		m_Graphics.m_WhiteColor=RGB(0,0,0); 
		m_Graphics.m_GraphicsMode=Layout;
		m_Graphics.m_mXPixel=mXPixel;
		m_Graphics.m_mYPixel=mYPixel;
		m_Graphics.m_Unit=UNIT_MILLIMETER;

		//CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);

		char HistogramFile[255];
		GetAppDir(HistogramFile);
		//updated on 2005/8/23
		//strcat(HistogramFile,"Project3.dxf");
		//<--
		//int projectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		//if (projectType==0)strcat(HistogramFile,"Project31.dxf");
		//else strcat(HistogramFile,"Project32.dxf");
		//-->
		//pDxfFile->FileImport(HistogramFile);
		//delete pDxfFile;

		//<--added on 2005/8/29
		/*CADLayer* pLayer = new CADLayer();
		m_LayerGroup.AddLayer(pLayer);
		strcpy(pLayer->m_Name,"0");
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
		pLayer->m_nColor=7;*/
		//-->

		m_Graphics.m_PrintWidth=419.51;
		m_Graphics.m_PrintHeight=296.38;

		m_Graphics.m_Bound.left = 0.0;//
		m_Graphics.m_Bound.top = -280;

		m_Graphics.m_Bound.left -= 40;
		m_Graphics.m_Bound.top -= 10;//23;

		m_Graphics.m_Bound.right = m_Graphics.m_Bound.left+m_Graphics.m_PrintWidth;
		m_Graphics.m_Bound.bottom = m_Graphics.m_Bound.top+m_Graphics.m_PrintHeight;

		m_Graphics.m_Bound.left*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top*=m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom*=m_Graphics.m_mYPixel;

		m_Graphics.m_Extmin.x = 0;//
		m_Graphics.m_Extmin.y = 2;
		m_Graphics.m_Extmax.x = 355;
		m_Graphics.m_Extmax.y = 280;

		//updated on 20081105
		m_Graphics.m_Extmin.x -= 15;///40;
		m_Graphics.m_Extmax.y += 10;//23;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;

		CHistogramIniFile3 HistogramIniFile(&m_LayerGroup,&m_Graphics);
		//added on 2005/830
		HistogramIniFile.m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		 
		HistogramIniFile.FileImport(lpFilename);
		CMainFrame*		m_pMain;
		m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
		if(HistogramIniFile.m_nPaperCount == 1)
		{
			m_pMain->AddComboPaper("共 1 页",0);
		}
		else
		{
			CString str;
			for (int i=0; i<HistogramIniFile.m_nPaperCount; i++)
			{
				str.Format("第 %d 页",i+1);
				m_pMain->AddComboPaper(str,i+1);
			}
		}
		if (HistogramIniFile.m_nPaperCount > 0)
			m_pMain->SetComboSel(0);

		m_Graphics.CalZoomRate();
		m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
		m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
		pView->Invalidate(false);
}

void CMiniCADDoc::OpenHistogramIni4(LPCTSTR lpFilename)
{
		CString extStr=lpFilename;
		extStr=extStr.Right(3);
		if(strcmp(extStr,"ini")!=0)return;
		m_Graphics.CreateDefault();
		ReadLinFile();

		CMiniCADView* pView;
		POSITION pos=GetFirstViewPosition();
		pView=(CMiniCADView*)GetNextView(pos);
//--------------------------------------------------------
		CDC* dc=pView->GetDC();
		int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
		int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
		int Xpixels=dc->GetDeviceCaps(HORZRES);
		int Ypixels=dc->GetDeviceCaps(VERTRES);
		DeleteDC(dc->m_hDC);
//---------------------------------------------------------
		double mXPixel=(double)Xpixels/((double)Xmilimeters);
		double mYPixel=(double)Ypixels/((double)Ymilimeters);

		m_Graphics.m_BKColor=RGB(173,174,173);
		m_Graphics.m_WhiteColor=RGB(0,0,0); 
		m_Graphics.m_GraphicsMode=Layout;
		m_Graphics.m_mXPixel=mXPixel;
		m_Graphics.m_mYPixel=mYPixel;
		m_Graphics.m_Unit=UNIT_MILLIMETER;

		//CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);

		char HistogramFile[255];
		GetAppDir(HistogramFile);
		//updated on 2005/8/23
		//strcat(HistogramFile,"Project3.dxf");
		//<--
		//int projectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
		//if (projectType==0)strcat(HistogramFile,"Project31.dxf");
		//else strcat(HistogramFile,"Project32.dxf");
		//-->
		//pDxfFile->FileImport(HistogramFile);
		//delete pDxfFile;

		//<--added on 2005/8/29
		/*CADLayer* pLayer = new CADLayer();
		m_LayerGroup.AddLayer(pLayer);
		strcpy(pLayer->m_Name,"0");
		strcpy(pLayer->m_LTypeName,"CONTINUOUS");
		pLayer->m_nColor=7;*/
		//-->

		m_Graphics.m_PrintWidth=419.51;
		m_Graphics.m_PrintHeight=296.38;

		m_Graphics.m_Bound.left = 0.0;//
		m_Graphics.m_Bound.top = -280;

		m_Graphics.m_Bound.left -= 40;
		m_Graphics.m_Bound.top -= 10;//23;

		m_Graphics.m_Bound.right = m_Graphics.m_Bound.left+m_Graphics.m_PrintWidth;
		m_Graphics.m_Bound.bottom = m_Graphics.m_Bound.top+m_Graphics.m_PrintHeight;

		m_Graphics.m_Bound.left*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top*=m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right*=m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom*=m_Graphics.m_mYPixel;

		m_Graphics.m_Extmin.x = 0;//
		m_Graphics.m_Extmin.y = 2;
		m_Graphics.m_Extmax.x = 355;
		m_Graphics.m_Extmax.y = 280;
		
		//<--******************************************
		double paperDeep = 178 + 30-2;//178;
		int vScale=::GetPrivateProfileInt("比例尺","Y",0,lpFilename);
		if (vScale==0)return;
		char str[100];
		bool bOnePage = true;
		if (::GetPrivateProfileInt("比例尺","一页打印",0,lpFilename)==0)
			bOnePage = true;
		else
			bOnePage = false;

		GetPrivateProfileString("钻孔","孔深","",str,255,lpFilename);
		int nProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);

		//m_Deep=(int)atof(str);
		float deep = atof(str);

		int nPaperCount;
		double mmDeep = (double)deep/vScale*1000;
		if (bOnePage)
		{
			nPaperCount = 1;
		}
		else
			nPaperCount = (short)(mmDeep / paperDeep) + 1;

		//updated on 20081105
		m_Graphics.m_Extmin.x -= 15;///40;
		m_Graphics.m_Extmax.y += 10;//23;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;

		CHistogramIniFile4 HistogramIniFile(&m_LayerGroup,&m_Graphics);
		//added on 2005/830
		HistogramIniFile.m_ProjectType = ::GetPrivateProfileInt("图纸信息","工程类型",0,lpFilename);
			 
		HistogramIniFile.FileImport(lpFilename);
		CMainFrame*		m_pMain;
		m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
		if(HistogramIniFile.m_nPaperCount == 1)
		{
			m_pMain->AddComboPaper("共 1 页",0);
		}
		else
		{
			CString str;
			for (int i=0; i<HistogramIniFile.m_nPaperCount; i++)
			{
				str.Format("第 %d 页",i+1);
				m_pMain->AddComboPaper(str,i+1);
			}
		}
		if (HistogramIniFile.m_nPaperCount > 0)
			m_pMain->SetComboSel(0);

		m_Graphics.CalZoomRate();
		m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
		m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
		pView->Invalidate(false);
}

void CMiniCADDoc::OpenStaticIni(LPCTSTR lpFilename)
{
	CString extStr=lpFilename;
	extStr=extStr.Right(3);
	if(strcmp(extStr,"ini")!=0)return;
	m_Graphics.CreateDefault(); 
	ReadLinFile();

	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
//---------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//---------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=VERTICAL;
	m_Graphics.m_PaperWidth=A3_HEIGHT;
	m_Graphics.m_PaperHeight=A3_WIDTH;

//	if(strcmp(extStr,"ini")!=0)
//	{
		CStaticIniFile* pStaticIniFile=new CStaticIniFile(&m_LayerGroup,&m_Graphics);
		pStaticIniFile->m_SplitChar = m_SplitChar;
		pStaticIniFile->FileImport(lpFilename);
		delete pStaticIniFile;
//	}

/*	if(strcmp(extStr,"dxf")==0)
	{
		CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);
		pDxfFile->FileImport(lpFilename);
		delete pDxfFile;
		m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+A3_WIDTH*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+A3_HEIGHT*m_Graphics.m_mYPixel;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;
	}*/

	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	m_pMain->AddComboPaper("共 1 页",0);
	m_pMain->SetComboSel(0);

	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
}

//added on 2005/8/23
void CMiniCADDoc::OpenStaticIni2(LPCTSTR lpFilename)
{
	CString extStr=lpFilename;
	extStr=extStr.Right(3);
	if(strcmp(extStr,"ini")!=0)return;
	m_Graphics.CreateDefault(); 
	ReadLinFile();

	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
//---------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//---------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=VERTICAL;
	m_Graphics.m_PaperWidth=A3_HEIGHT;
	m_Graphics.m_PaperHeight=A3_WIDTH;

//	if(strcmp(extStr,"ini")!=0)
//	{
		CStaticIniFile2* pStaticIniFile=new CStaticIniFile2(&m_LayerGroup,&m_Graphics);
		pStaticIniFile->m_SplitChar = m_SplitChar;
		pStaticIniFile->FileImport(lpFilename);
		delete pStaticIniFile;
//	}

/*	if(strcmp(extStr,"dxf")==0)
	{
		CDxfFile* pDxfFile=new CDxfFile(&m_LayerGroup,&m_Graphics);
		pDxfFile->FileImport(lpFilename);
		delete pDxfFile;
		m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
		m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+A3_WIDTH*m_Graphics.m_mXPixel;
		m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+A3_HEIGHT*m_Graphics.m_mYPixel;

		m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
		m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;
	}*/

	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	m_pMain->AddComboPaper("共 1 页",0);
	m_pMain->SetComboSel(0);

	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
}

void CMiniCADDoc::OpenLayoutIni(LPCTSTR lpFilename)
{
	char str[255];
	char filePath[500];
	::GetPrivateProfileString("图纸信息","文件路径","",filePath,500,lpFilename);

	CDxfFile DxfFile(&m_LayerGroup,&m_Graphics);
	DxfFile.m_isReadHatch=false;
	DxfFile.FileImport(filePath);



	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);

	::GetPrivateProfileString("图纸信息","图纸名称","",str,255,lpFilename);
	strcpy(pView->m_PaperName,str);

	pView->m_PaperScale = ::GetPrivateProfileInt("图纸信息","比例尺",1,lpFilename);

	OpenLegendFile();

	/*CLayoutIniFile LayoutIniFile(&m_LayerGroup,&m_Graphics);
	LayoutIniFile.m_PaperScale = pView->m_PaperScale;
	LayoutIniFile.FileImport(lpFilename);*/
	m_LayoutIniFilename = lpFilename;

	int Orient=::GetPrivateProfileInt("图纸信息","打印方向",1,lpFilename);
	if(Orient==1)
	{
		m_Graphics.m_PaperOrient=HORIZONTAL;
		pView->m_PaperOrient = HORIZONTAL;
		m_Graphics.m_PaperWidth=A3_WIDTH;
		m_Graphics.m_PaperHeight=A3_HEIGHT;
	}
	else
	{
		m_Graphics.m_PaperOrient=VERTICAL;
		pView->m_PaperOrient = VERTICAL;
		m_Graphics.m_PaperWidth=A3_HEIGHT;
		m_Graphics.m_PaperHeight=A3_WIDTH;
	}

	m_Graphics.m_GraphicsMode = Model;
	//m_Graphics.m_PaperOrient=HORIZONTAL;
	m_Graphics.CalZoomRate();
/*	CString str2;
	str2.Format("%lf",m_Graphics.m_ZoomRate);
	::AfxMessageBox(str2);*/
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC());
	pView->Invalidate(false);
}

void CMiniCADDoc::OpenLegendIni(LPCTSTR lpFilename)
{
	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
	//pView->m_GraphicsMode=Layout; 
//----------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//----------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_bLineWidth=false; 
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=HORIZONTAL;
//----------------------------------------------------------
	m_Graphics.m_Extmin.x = 0;
	m_Graphics.m_Extmin.y = 0;
	m_Graphics.m_Extmax.x = A3_WIDTH;
	m_Graphics.m_Extmax.y = A3_HEIGHT;

	m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
	m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+A3_WIDTH*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+A3_HEIGHT*m_Graphics.m_mYPixel;
	m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
	m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;	
	m_Graphics.CreateDefaultLayer();

	OpenLegendFile();

	CLegendDisplay LegendDisplay(&m_LayerGroup,&m_Graphics);
	LegendDisplay.m_SplitChar = m_SplitChar;
	LegendDisplay.FileImport(lpFilename);
	LegendDisplay.AdjustLegend(lpFilename);

//----------------------------------------------------------
	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
	//SetModifiedFlag();	
}

void CMiniCADDoc::OpenCrossBoardIni(LPCTSTR lpFilename)
{
	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
	//pView->m_GraphicsMode=Layout; 
//----------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//----------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	/*CADStyle* pStyle = new CADStyle();
	m_Graphics.m_Styles.Add(pStyle);
	strcpy(pStyle->m_Name,"样式1");
	strcpy(pStyle->m_Font,"SIMKAI.TTF");*/

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_bLineWidth=false; 
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=HORIZONTAL;
//----------------------------------------------------------
	m_Graphics.m_Extmin.x = 0;
	m_Graphics.m_Extmin.y = 0;
	m_Graphics.m_Extmax.x = A3_WIDTH;
	m_Graphics.m_Extmax.y = A3_HEIGHT;

	m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
	m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+A3_WIDTH*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+A3_HEIGHT*m_Graphics.m_mYPixel;
	m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
	m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;	
	m_Graphics.CreateDefault();

	CCrossBoardIniFile CrossBoardIniFile(&m_LayerGroup,&m_Graphics);
	CrossBoardIniFile.FileImport(lpFilename);

	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	if(CrossBoardIniFile.m_nPaperCount == 1)
	{
		m_pMain->AddComboPaper("共 1 页",0);
	}
	else
	{
		CString str;
		for (int i=0; i<CrossBoardIniFile.m_nPaperCount; i++)
		{
			str.Format("第 %d 页",i+1);
			m_pMain->AddComboPaper(str,i+1);
		}
	}
	if (CrossBoardIniFile.m_nPaperCount > 0)
		m_pMain->SetComboSel(0);
//----------------------------------------------------------
	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
}

void CMiniCADDoc::OpenCompressionCurve(LPCTSTR lpFilename)
{
	CMiniCADView* pView;
	POSITION pos=GetFirstViewPosition();
	pView=(CMiniCADView*)GetNextView(pos);
	//pView->m_GraphicsMode=Layout; 
//----------------------------------------------------------
	CDC* dc=pView->GetDC();
	int Xmilimeters=dc->GetDeviceCaps(HORZSIZE);
	int Ymilimeters=dc->GetDeviceCaps(VERTSIZE);
	int Xpixels=dc->GetDeviceCaps(HORZRES);
	int Ypixels=dc->GetDeviceCaps(VERTRES);
	//pView->ReleaseDC(dc);
	DeleteDC(dc->m_hDC);
//----------------------------------------------------------
	double mXPixel=(double)Xpixels/((double)Xmilimeters);
	double mYPixel=(double)Ypixels/((double)Ymilimeters);

	/*CADStyle* pStyle = new CADStyle();
	m_Graphics.m_Styles.Add(pStyle);
	strcpy(pStyle->m_Name,"样式1");
	strcpy(pStyle->m_Font,"SIMKAI.TTF");*/

	m_Graphics.m_BKColor=RGB(173,174,173);
	m_Graphics.m_WhiteColor=RGB(0,0,0); 
	m_Graphics.m_GraphicsMode=Layout;
	m_Graphics.m_bLineWidth=false; 
	m_Graphics.m_mXPixel=mXPixel;
	m_Graphics.m_mYPixel=mYPixel;
	m_Graphics.m_Unit=UNIT_MILLIMETER;
	m_Graphics.m_PaperOrient=HORIZONTAL;
	m_Graphics.m_PaperWidth=A4_WIDTH;
	m_Graphics.m_PaperHeight=A4_HEIGHT;
//----------------------------------------------------------
	//m_Graphics.CreateDefault();
/*	lpFilename = "D:\\Documents and Settings\\hu.MY-TOMATO\\桌面\\SDCAD\\图形1.dxf";
	CDxfFile DxfFile(&m_LayerGroup,&m_Graphics);
	DxfFile.FileImport(lpFilename);
*/
	m_Graphics.m_Extmin.x = 0;
	m_Graphics.m_Extmin.y = 0;
	m_Graphics.m_Extmax.x = m_Graphics.m_PaperWidth;
	m_Graphics.m_Extmax.y = m_Graphics.m_PaperHeight;

	m_Graphics.m_Bound.left=m_Graphics.m_Extmin.x*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.top=-m_Graphics.m_Extmax.y*m_Graphics.m_mYPixel;
	m_Graphics.m_Bound.right=m_Graphics.m_Bound.left+m_Graphics.m_PaperWidth*m_Graphics.m_mXPixel;
	m_Graphics.m_Bound.bottom=m_Graphics.m_Bound.top+m_Graphics.m_PaperHeight*m_Graphics.m_mYPixel;
	m_Graphics.m_PaperLeft=m_Graphics.m_Extmin.x;
	m_Graphics.m_PaperTop=m_Graphics.m_Extmax.y;	
	m_Graphics.CreateDefault();


	CCompressionCurve CompressionCurve(&m_LayerGroup,&m_Graphics);
	CompressionCurve.FileImport(lpFilename);
	pView->m_PaperType = CompressionCurve.m_PaperType;

	CMainFrame*		m_pMain;
	m_pMain=(CMainFrame*) AfxGetApp()->m_pMainWnd;
	int paperCount = (int)((float)CompressionCurve.m_LayerNum/2+0.5);
	if(paperCount == 1)
	{
		m_pMain->AddComboPaper("共 1 页",0);
	}
	else
	{
		CString str;
		for (int i=0; i<paperCount; i++)
		{
			str.Format("第 %d 页",i+1);
			m_pMain->AddComboPaper(str,i+1);
		}
	}
	if (paperCount > 0)
		m_pMain->SetComboSel(0);
//----------------------------------------------------------
	m_Graphics.CalZoomRate();
	m_Graphics.m_OriginZoomRate = m_Graphics.m_ZoomRate;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
}

void CMiniCADDoc::OpenLegendFile()
{
	int i=m_LayerGroup.indexOf(PROJECTHOLELAYERNAME);
	if (i>-1)return;
	CADLayer* pLayer = new CADLayer();
	m_LayerGroup.AddLayer(pLayer);
	strcpy(pLayer->m_Name,PROJECTHOLELAYERNAME);
	pLayer->m_nColor = AD_COLOR_GRAY;
	strcpy(pLayer->m_LTypeName,"CONTINUOUS");
	CADGraphics::CreateHandle(pLayer->m_Handle);

	char LegendFile[255];
	GetAppDir(LegendFile);
	strcat(LegendFile,"钻孔图例.dxf");
	
	CDxfFile LegendDxf(&m_LayerGroup,&m_Graphics);
	LegendDxf.ReadHoleLegend(LegendFile);
}

void CMiniCADDoc::OnFileOpen4()
{
 	TCHAR szFilters[]=_T("INI 文件(*.ini)|*.ini|所有文件(*.*)|*.*||");
	CFileDialog dlg(true,_T("ini"),_T("*.ini"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters);
 	if(dlg.DoModal()==IDOK)
	{
		BeginWaitCursor();
		m_isLayout=true;
		OpenLayoutIni(dlg.GetPathName());
		OpenLegendFile();
		EndWaitCursor();
	}		
}

void CMiniCADDoc::ReadLinFile()
{
	char LineFile[255];
	GetAppDir(LineFile);
	strcat(LineFile,"Project.lin");

	FILE* fp;
	fp=fopen(LineFile,"r");
	if(fp==NULL)return;
	short MaxStrLen=512;
	char str[512];
	//fscanf(fp,"%s\n",str);
	fgets(str,MaxStrLen,fp);
	while(str[0]=='*' && ! feof(fp) && ! ferror(fp))
	{
		char* pdest;
		pdest=strstr(str,",");
		int  length;
		length=pdest-str-1;
		char* ch=new char[length+1];
		memcpy(ch,str+1,length);
		ch[length]='\0';
		CADLType* pLType=new CADLType();
		m_Graphics.m_LTypes.Add((CObject*)pLType);
		strcpy(pLType->m_Name,ch);
		CADGraphics::CreateHandle(pLType->m_Handle);
		//fscanf(fp,"%s\n",str);
		fgets(str,MaxStrLen,fp);
		CreateLType(str,pLType);
		//fscanf(fp,"%s\n",str);
		fgets(str,MaxStrLen,fp);
	}
	fclose(fp);
}

void CMiniCADDoc::CreateLType(char* LTypeStr,CADLType* pLType)
{
	char* pszTemp = strtok(LTypeStr, ",");
	if(pszTemp==NULL)return;
	pszTemp=strtok(NULL, ",");
	while(pszTemp)
	{
		pLType->m_ItemCount++;
		float* tempArray=new float[pLType->m_ItemCount];
		tempArray[pLType->m_ItemCount-1]=atof(pszTemp);
		if(pLType->m_Items)
		{
			memcpy(tempArray,pLType->m_Items,sizeof(float)*(pLType->m_ItemCount-1));
			delete pLType->m_Items;
		}
		pLType->m_Items=tempArray;
		pszTemp=strtok(NULL, ",");
	}
	return;
}

void CMiniCADDoc::SetTitle(LPCTSTR lpszTitle) 
{
	CMiniCADApp* pApp=(CMiniCADApp*)AfxGetApp();
	switch(pApp->m_ProjectType)
	{
		case PROJECT_SECTION:
			lpszTitle="剖面图";
			break;
		case PROJECT_HISTOGRAM:
		case PROJECT_HISTOGRAM2:
		case PROJECT_HISTOGRAM3:
			lpszTitle="柱状图";
			break;
		case PROJECT_STATIC:
			lpszTitle="静力触探成果图";
			break;
		case PROJECT_LAYOUT:
			lpszTitle="平面布置图";
			break;
		case PROJECT_LEGEND:
			lpszTitle="图例";
			break;
		case PROJECT_CROSSBOARD:
			lpszTitle="十字板剪切试验曲线图";
			break;
	}
	lpszTitle = ((CMiniCADApp*)AfxGetApp())->m_SaveAsFilename;
	CDocument::SetTitle(lpszTitle);
}

void CMiniCADDoc::OnCloseDocument() 
{
		
	CDocument::OnCloseDocument();
}

void CMiniCADDoc::OnFileOpen5() 
{
 	TCHAR szFilters[]=_T("INI 文件(*.ini)|*.ini|所有文件(*.*)|*.*||");
	CFileDialog dlg(true,_T("ini"),_T("*.ini"),OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilters);
 	if(dlg.DoModal()==IDOK)
	{
		OpenLegendIni(dlg.GetPathName());
		//	OpenCrossBoardIni(dlg.GetPathName());
	}
}

void CMiniCADDoc::OnImporthole() 
{
	POSITION pos=GetFirstViewPosition();
	CMiniCADView* pView = (CMiniCADView*)GetNextView(pos);

	CLayoutIniFile LayoutIniFile(&m_LayerGroup,&m_Graphics);
	LayoutIniFile.m_PaperScale = pView->m_PaperScale;
	LayoutIniFile.FileImport((LPCTSTR)m_LayoutIniFilename);	
	m_bImport = true;
	m_Graphics.DrawGraphics(pView->m_pDisplay->GetDC()); 
	pView->Invalidate(false);
}

void CMiniCADDoc::OnUpdateImporthole(CCmdUI* pCmdUI) 
{
	POSITION pos=GetFirstViewPosition();
	CMiniCADView* pView=(CMiniCADView*)GetNextView(pos);
	pCmdUI->Enable(pView->m_curWorkSpace==MODELSPACE && m_isLayout && !m_bImport);	
}
