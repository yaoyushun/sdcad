#include "stdafx.h"
#include "DxfFile.h"
#include <math.h>
#include "..\FunctionLib\Function_String.h"

void DealStr(char* ch)
{
/*
function:
date:
autor:hyg
*/
	int len=strlen(ch);
	if(len==1)
	{
		ch="";
		return;
	}
	char* tempCh=new char[len];
	memcpy(tempCh,ch,len-1);
	tempCh[len-1]='\0';
	len=len-1;
	for(int i=0;i<len;i++)
	{
		if(tempCh[i]!=' ')
		{
			memcpy(ch,tempCh+i,len-i);
			ch[len-i]='\0';
			return;
		}
	}
}

CDxfFile::CDxfFile(CADLayerGroup* pLayerGroup,CADGraphics* pGraphics)
{
	m_LayerGroup=pLayerGroup;
	m_Graphics=pGraphics;
	m_isReadHatch=true;
//	m_Graphics->m_pLayerGroup=pLayerGroup;
}

CDxfFile::~CDxfFile()
{

}

void CDxfFile::FileImport(LPCTSTR lpFilename)
{
	FILE* fp;

	char str[20];

	fp=fopen(lpFilename,"r");
	if(fp==NULL)return;

	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",str);
	fscanf(fp,"%s\n",ACADVER);
	fclose(fp);	

//	if(strcmp(ACADVER,AutoCADR12)==0)AutoCADR12Import(lpFilename);
//	if(strcmp(ACADVER,AutoCADR13)==0)AutoCADR13Import(lpFilename);
//	if(strcmp(ACADVER,AutoCADR14)==0)AutoCADR14Import(lpFilename);
	if(strcmp(ACADVER,AutoCAD2000)==0)AutoCAD2000Import(lpFilename);
}

void CDxfFile::AutoCAD2000Import(LPCTSTR lpFilename)
{
	FILE* fp;
	fp=fopen(lpFilename,"r");

	int i;

//	int lab;
	const int MaxStrLen=1200;
	char str[1200];

	bool isLayout = false;
	bool isEntity=false;
	bool isBlock=false;
	bool isClass=false;
	while(! feof(fp) && ! ferror(fp))
	{
		//fscanf(fp,"%s\n",str);
		fgets(str, MaxStrLen, fp);
		DealStr(str);
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"$EXTMIN")==0)
		{
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Extmin.x);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Extmin.y);
		}

		if(strcmp(str,"$EXTMAX")==0)
		{
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Extmax.x);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Extmax.y);
		}

		if(strcmp(str,"$LIMMIN")==0)
		{
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Limmin.x);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Limmin.y);
		}

		if(strcmp(str,"$LIMMAX")==0)
		{
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Limmax.x);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&m_Graphics->m_Limmax.y);
		}

		if(strcmp(str,"$HANDSEED")==0)
		{
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%s\n",m_Graphics->m_HandSeed);
		}

//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"BLOCKS") ==0)
		{
			isBlock=true;
			isEntity=false;
			isClass=false;
		}
		/*if(strcmp(str,"AcDbBlockTableRecord") ==0)
		{
			isBlock=true;
			isEntity=false;
		}*/
		if(strcmp(str,"BLOCK") ==0)
		{
			CADBlock* pBlock;
			pBlock=new CADBlock();
			m_Graphics->m_Blocks.Add((CObject*)pBlock);
//			char chr;
			//fscanf(fp,"%s\n",str);
			fgets(str, MaxStrLen, fp);
			DealStr(str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{
					fscanf(fp,"%s\n",str);
					strcpy(pBlock->m_Name,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pBlock->m_Handle);
					fscanf(fp,"%s\n",str);
					strcpy(CADGraphics::m_curHandle,pBlock->m_Handle);
					CADGraphics::CreateHandle(pBlock->m_Handle2);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pBlock->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pBlock->m_BasePoint.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pBlock->m_BasePoint.y);
					fscanf(fp,"%s\n",str);							
				}
				else
				{
					/*fscanf(fp,"%c",&chr);
					fscanf(fp,"%c",&chr);
					if(chr!=10)
					{
						fseek(fp,-1,SEEK_CUR);
						fscanf(fp,"%s\n",str);
					}
					fscanf(fp,"%s",str);*/
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
			/*fgets(str, MaxStrLen, fp);
			fgets(str, MaxStrLen, fp);
			DealStr(str);
			if(strcmp(str,"5")==0)
			{
				fscanf(fp,"%s\n",pBlock->m_Handle2);
				fscanf(fp,"%s\n",str);
			}*/
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"ENTITIES") ==0)
		{
			isEntity=true;
			isBlock=false;
			isClass=false;
		}

		if(strcmp(str,"CLASSES") ==0)
		{
			isEntity=false;
			isBlock=false;
			isClass=true;
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"POINT") ==0)
		{
			CADPoint* pPoint;;
			pPoint=new CADPoint();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pPoint);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pPoint);  
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pPoint->m_Handle);
					strcpy(CADGraphics::m_curHandle,pPoint->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pPoint->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pPoint->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pPoint->pt.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->pt.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pPoint->pt.z);
						fscanf(fp,"%s\n",str);
					}
					else
						pPoint->pt.z=0.0;*/								
				}
				else
				{
					//fscanf(fp,"%s\n",str);
					//fscanf(fp,"%s\n",str);
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"ARC") ==0)
		{
			CADArc* pArc;;
			pArc=new CADArc();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pArc);	
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pArc);  
			}
			//m_Graphics->m_Entities.Add((CObject*)pArc);
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pArc->m_Handle);
					strcpy(CADGraphics::m_curHandle,pArc->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pArc->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pArc->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pArc->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pArc->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pArc->ptCenter.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pArc->ptCenter.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pArc->ptCenter.z);
						fscanf(fp,"%s\n",str);
					}
					else
						pArc->ptCenter.z=0.0;*/			
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pArc->m_Radius);
					fscanf(fp,"%s\n",str);				
				}
				else if(strcmp(str,"50")==0)
				{
					fscanf(fp,"%lf\n",&pArc->m_StartAng);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pArc->m_EndAng);
					fscanf(fp,"%s\n",str);				
				}
				else
				{
					//fscanf(fp,"%s\n",str);
					//fscanf(fp,"%s\n",str);
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);

				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"CIRCLE") ==0)
		{
			CADCircle* pCircle;;
			pCircle=new CADCircle();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pCircle);	
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pCircle);  
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pCircle->m_Handle);
					strcpy(CADGraphics::m_curHandle,pCircle->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pCircle->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pCircle->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pCircle->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pCircle->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pCircle->ptCenter.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pCircle->ptCenter.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pCircle->ptCenter.z);
						fscanf(fp,"%s\n",str);
					}
					else
					pCircle->ptCenter.z=0.0;*/			
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pCircle->m_Radius);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////

		if(strcmp(str,"LINE") ==0)// && !isClass
		{
			CADLine* pLine;
			pLine=new CADLine();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pLine);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pLine);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pLine->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pLine->m_Handle);
					strcpy(CADGraphics::m_curHandle,pLine->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pLine->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pLine->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pLine->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"48")==0)
				{
					fscanf(fp,"%f\n",&pLine->m_LTypeScale);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pLine->pt1.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt1.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt1.z);
						fscanf(fp,"%s\n",str);
					}
					else
						pLine->pt1.z=0.0;*/						
				}
				else if(strcmp(str,"11")==0)
				{
					fscanf(fp,"%lf\n",&pLine->pt2.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt2.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"31")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt2.z);
					}
					else
						pLine->pt2.z=0.0;*/								
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
/*		if(strcmp(str,"533") ==0)// && !isClass
		{
			CADLine* pLine;
			pLine=new CADLine();

			if(isEntity)
				//m_Graphics->m_Line.Add(pLine);
				m_Graphics->m_Entities.Add((CObject*)pLine);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pLine);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pLine->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pLine->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pLine->pt1.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt1.y);
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt1.z);
						fscanf(fp,"%s\n",str);
					}
					else
						pLine->pt1.z=0.0;
					fscanf(fp,"%lf\n",&pLine->pt2.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt2.y);
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt2.z);
					}
					else
						pLine->pt2.z=0.0;								
				}
				else
				{
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%s\n",str);
				}
			}
		}*/
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"LWPOLYLINE") ==0)//&& !isClass
		{
			CADPolyline* pPolyline;
			pPolyline=new CADPolyline();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pPolyline);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pPolyline);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pPolyline->m_Handle);
					strcpy(CADGraphics::m_curHandle,pPolyline->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pPolyline->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pPolyline->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pPolyline->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pPolyline->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"70")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0 || strcmp(str,"129")==0)
						pPolyline->m_Closed =true; 
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					/*CADPoint* pPoint;
					pPoint=new CADPoint();*/
					ADPOINT* pPoint = new ADPOINT();
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
					pPolyline->m_Point.Add((CObject*)pPoint);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"SPLINE") ==0 && !isClass)
		{
			CADSpline* pSpline;
			pSpline=new CADSpline();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pSpline);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pSpline);
			}
			int KnotIndex=0;
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pSpline->m_Handle);
					strcpy(CADGraphics::m_curHandle,pSpline->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pSpline->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pSpline->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pSpline->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"70")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0)
						pSpline->m_Closed =true; 
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"72")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumKnot);
					if(pSpline->m_NumKnot>0)
						pSpline->m_pKnotPoints=new double[pSpline->m_NumKnot];
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"73")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumControl);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"74")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumFit);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"40")==0)
				{
					if(KnotIndex<pSpline->m_NumKnot)
						fscanf(fp,"%lf\n",&pSpline->m_pKnotPoints[KnotIndex]);
					else
						fscanf(fp,"%s\n",str);
					fscanf(fp,"%s\n",str);
					KnotIndex++;
				}
				else if(strcmp(str,"10")==0)
				{
					/*CADPoint* pPoint;
					pPoint=new CADPoint();*/
					ADPOINT* pPoint = new ADPOINT();
					pSpline->m_ControlPoint.Add((CObject*)pPoint);
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"11")==0)
				{
					/*CADPoint* pPoint;
					pPoint=new CADPoint();*/
					ADPOINT* pPoint = new ADPOINT();
					pSpline->m_FitPoint.Add((CObject*)pPoint);
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"INSERT") ==0)
		{
			CADInsert* pInsert;
			pInsert=new CADInsert();
			//m_Graphics->m_Entities.Add((CObject*)pInsert);
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pInsert);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pInsert);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pInsert->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"2")==0)
				{
					fscanf(fp,"%s\n",str);
					strcpy(pInsert->m_Name,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pInsert->m_Handle);
					strcpy(CADGraphics::m_curHandle,pInsert->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"41")==0)
				{
					fscanf(fp,"%lf\n",&pInsert->m_xScale);
					fscanf(fp,"%s\n",str);			
				}
				else if(strcmp(str,"42")==0)
				{
					fscanf(fp,"%lf\n",&pInsert->m_yScale);
					fscanf(fp,"%s\n",str);				
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pInsert->pt.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pInsert->pt.y);
					fscanf(fp,"%s\n",str);
					//fscanf(fp,"%lf\n",&pInsert->pt.z);
					//fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"50")==0)
				{
					fscanf(fp,"%lf\n",&pInsert->m_Rotation);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}		
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"MTEXT") ==0)
		{
			CADMText* pMText;
			pMText=new CADMText();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pMText);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pMText);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pMText->m_Handle);
					strcpy(CADGraphics::m_curHandle,pMText->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"1")==0)
				{
					//fscanf(fp,"%s",str);
					fgets(str, 1000, fp); 
					//char ch;
					//fscanf(fp,"%c",&ch);
					//while(ch==' ')
					//{
					//	fscanf(fp,"%s",str);
						
					//}
					pMText->m_Text=str;
					fscanf(fp,"%s\n",str);					
					m_Graphics->SetMText(pMText,pMText->m_Text);				
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pMText->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Location.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pMText->m_Location.y);
					fscanf(fp,"%s\n",str);		
				}
				else if(strcmp(str,"11")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_ptDir.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pMText->m_ptDir.y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Height);
					pMText->m_Height=pMText->m_Height+1;				
					fscanf(fp,"%s\n",str);	
				}
				else if(strcmp(str,"41")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Width);
					fscanf(fp,"%s\n",str);	
				}
				else if(strcmp(str,"71")==0)
				{
					fscanf(fp,"%c\n",&pMText->m_Align);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"44")==0)
				{
					fscanf(fp,"%f\n",&pMText->m_Interval);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"TEXT") ==0)
		{
			CADText* pText;
			pText=new CADText();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pText);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pText);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pText->m_Handle);
					strcpy(CADGraphics::m_curHandle,pText->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"1")==0)
				{
					//fscanf(fp,"%s\n",str);
					fgets(str, 1000, fp);
					DealStr(str);
					pText->m_Text=str;
					fscanf(fp,"%s\n",str);
					//m_Graphics->SetText(pText,pText->m_Text); 				
				}
				else if(strcmp(str,"7")==0)
				{
					fgets(str, 1000, fp);
					DealStr(str);
					//fscanf(fp,"%s\n",str);
					strcpy(pText->m_StyleName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pText->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pText->m_Location.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pText->m_Location.y);
					fscanf(fp,"%s\n",str);		
				}
				else if(strcmp(str,"11")==0)
				{
					fscanf(fp,"%lf\n",&pText->m_ptDir.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pText->m_ptDir.y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pText->m_Height);
					fscanf(fp,"%s\n",str);		
				}
				else if(strcmp(str,"50")==0)
				{
					fscanf(fp,"%lf\n",&pText->m_Angle);
					fscanf(fp,"%s\n",str);		
				}
				else
				{
					fgets(str, MaxStrLen, fp);	
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//tables===================================================================================
		if(strcmp(str,"STYLE") ==0)
		{
			CADStyle* pStyle=NULL;
			fscanf(fp,"%s\n",str);
			static int j=0;
			j++;
			if(j>1)
			{
				pStyle=new CADStyle();
				m_Graphics->m_Styles.Add((CObject*)pStyle);		
			}
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{
					if(pStyle)
					{
						fgets(str, 1000, fp);
						DealStr(str);
						strcpy(pStyle->m_Name,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}			
				}
				else if(strcmp(str,"3")==0)
				{
					if(pStyle)
					{
						fscanf(fp,"%s\n",pStyle->m_Font);					
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"5")==0)
				{
					if(pStyle)
					{
						fscanf(fp,"%s\n",pStyle->m_Handle);					
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"4")==0)
				{
					fgets(str, MaxStrLen, fp);
					//DealStr(str);
					fgets(str, MaxStrLen, fp);
					DealStr(str);				
				}
				else if(strcmp(str,"1000")==0)
				{
					fscanf(fp,"%s\n",str);
					strcpy(pStyle->m_Font,str);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//-----------------------------------------------------------------------------------------
		if(strcmp(str,"LAYER")==0)
		{
			CADLayer* pLayer=NULL;
			//bool isLayer=false;
			fscanf(fp,"%s\n",str);
			static int j=0;
			j++;
			if(j>1)
			{
				pLayer=new CADLayer();
				m_LayerGroup->AddLayer(pLayer);			
			}
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);			
						strcpy(pLayer->m_Name,str);
						if (strcmp(pLayer->m_Name,PROJECTHOLELAYERNAME)==0)
							isLayout = true;
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"5")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);			
						strcpy(pLayer->m_Handle,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"290")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);			
						if(strcmp(str,"0")==0)pLayer->m_isPrint=false; 
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"390")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);			
						strcpy(pLayer->m_PrintStyle,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"62")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);
						//CADLayer* pLayer;
						//pLayer=m_LayerGroup->GetLayer(m_LayerGroup->GetLayerCount()-1);
						pLayer->m_nColor=atoi(str); 
						fscanf(fp,"%s\n",str);								
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"6")==0)
				{
					if(pLayer)
					{
						fscanf(fp,"%s\n",str);
						//CADLayer* pLayer;
						//pLayer=m_LayerGroup->GetLayer(m_LayerGroup->GetLayerCount()-1);
						strcpy(pLayer->m_LTypeName,str);
						fscanf(fp,"%s\n",str);					
					}
					else
					{
						fscanf(fp,"%s\n",str);
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else
				{
					fscanf(fp,"%s\n",str);
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
//			isLayer=false;
		}
//-----------------------------------------------------------------------------------------
		if(strcmp(str,"LTYPE") ==0)
		{
			CADLType* pLType=NULL;
			fscanf(fp,"%s\n",str);
			int i=0;
			static int j=0;
			j++;
			if(j>1)
			{
				pLType=new CADLType();
				m_Graphics->m_LTypes.Add((CObject*)pLType);			
			}
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{	
					if(pLType)
					{
						fscanf(fp,"%s\n",str);
						strcpy(pLType->m_Name,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"5")==0)
				{	
					if(pLType)
					{
						fscanf(fp,"%s\n",str);
						strcpy(pLType->m_Handle,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"73")==0)
				{
					fscanf(fp,"%d\n",&pLType->m_ItemCount);
					if(pLType->m_ItemCount>0)pLType->m_Items=new float[pLType->m_ItemCount];
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"49")==0)
				{
					if(i<pLType->m_ItemCount)
					{
						fscanf(fp,"%f\n",&pLType->m_Items[i]);
						fscanf(fp,"%s\n",str);
						i++;
					}
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//-----------------------------------------------------------------------------------------
		if(strcmp(str,"BLOCK_RECORD") ==0)
		{
			CADBlockRecord* pBlockRecord=NULL;
			fscanf(fp,"%s\n",str);
			static int i=0;
			i++;
			if(i>1)
			{
				pBlockRecord=new CADBlockRecord();
				m_Graphics->m_BlockRecords.Add((CObject*)pBlockRecord);			
			}
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{	
					if(pBlockRecord)
					{
						fscanf(fp,"%s\n",str);
						strcpy(pBlockRecord->m_Name,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else if(strcmp(str,"5")==0)
				{
					if(pBlockRecord)
					{
						fscanf(fp,"%s\n",pBlockRecord->m_Handle);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//end tables===================================================================================
		if(strcmp(str,"SOLID") ==0)
		{
			fscanf(fp,"%s\n",str);
			if(strcmp(str,"5")==0)
			{
				CADSolid* pSolid;
				pSolid=new CADSolid();
				if(isEntity)
					m_Graphics->m_Entities.Add((CObject*)pSolid);
				if(isBlock)
				{
					CADBlock* pBlock;
					pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
					pBlock->m_Entities.Add((CObject*)pSolid);
				}
				while(strcmp(str,"0")!=0)
				{
					if(strcmp(str,"5")==0)
					{
						fscanf(fp,"%s\n",pSolid->m_Handle);
						strcpy(CADGraphics::m_curHandle,pSolid->m_Handle);
						fscanf(fp,"%s\n",str);
					}
					else if(strcmp(str,"8")==0)
					{
						fscanf(fp,"%s\n",str);
						int i=m_LayerGroup->indexOf(str);
						pSolid->m_nLayer=i;
						fscanf(fp,"%s\n",str);
					}
					else if(strcmp(str,"10")==0)
					{
						fscanf(fp,"%lf\n",&pSolid->m_pt0.x);
						fscanf(fp,"%s\n",str);
						fscanf(fp,"%lf\n",&pSolid->m_pt0.y);
						fscanf(fp,"%s\n",str);		
					}
					else if(strcmp(str,"11")==0)
					{
						fscanf(fp,"%lf\n",&pSolid->m_pt1.x);
						fscanf(fp,"%s\n",str);
						fscanf(fp,"%lf\n",&pSolid->m_pt1.y);
						fscanf(fp,"%s\n",str);		
					}
					else if(strcmp(str,"12")==0)
					{
						fscanf(fp,"%lf\n",&pSolid->m_pt2.x);
						fscanf(fp,"%s\n",str);
						fscanf(fp,"%lf\n",&pSolid->m_pt2.y);
						fscanf(fp,"%s\n",str);		
					}
					else if(strcmp(str,"13")==0)
					{
						fscanf(fp,"%lf\n",&pSolid->m_pt3.x);
						fscanf(fp,"%s\n",str);
						fscanf(fp,"%lf\n",&pSolid->m_pt3.y);
						fscanf(fp,"%s\n",str);		
					}
					else if(strcmp(str,"62")==0)
					{
						fscanf(fp,"%d\n",&pSolid->m_nColor);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////

		if(strcmp(str,"HATCH")==0 && (m_isReadHatch || isLayout))
		{
			CADHatch* pHatch;
			pHatch=new CADHatch();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pHatch);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pHatch);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pHatch->m_Handle);
					strcpy(CADGraphics::m_curHandle,pHatch->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(str);
					pHatch->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"2")==0)
				{
					fscanf(fp,"%s\n",str);
					strcpy(pHatch->m_Name,str);
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
				else if(strcmp(str,"70")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0)
						pHatch->m_bSolidFill=true; 
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"72")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0 || strcmp(str,"0")==0)
					{
						CADPolyline* pPolyline;
						pPolyline=new CADPolyline();
						pHatch->m_pPolyline=pPolyline;
						pHatch->m_Paths.Add((CObject*)pPolyline);
					}
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"98")==0)
				{
					fscanf(fp,"%d\n",&pHatch->m_nSeedCount);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					int size=pHatch->m_Paths.GetSize();
					if(pHatch->m_pPolyline)
					{
						CADEntity* pEntity=(CADEntity*)pHatch->m_Paths.GetAt(size-1);
						//if(pEntity->GetType()==AD_ENT_POLYLINE)
						//{
							CADPolyline* pPolyline=(CADPolyline*)pEntity;
							if(pHatch->m_pPolyline)
							CADPolyline* pPolyline=pHatch->m_pPolyline;
							ADPOINT* pPoint = new ADPOINT();
							fscanf(fp,"%lf\n",&pPoint->x);
							fscanf(fp,"%s\n",str);
							fscanf(fp,"%lf\n",&pPoint->y);
							fscanf(fp,"%s\n",str);
							pPolyline->m_Point.Add((CObject*)pPoint);
							int size2=pPolyline->m_Point.GetSize();

							double* newPoints=new double[size2];
							if(pPolyline->m_pElevation!=NULL)
							{
								memcpy(newPoints, pPolyline->m_pElevation, sizeof(double) * (size2-1));
								delete[] pPolyline->m_pElevation;
							}
							pPolyline->m_pElevation=newPoints;
							if(strcmp(str,"42")==0)
							{
								fscanf(fp,"%lf\n",&pPolyline->m_pElevation[size2-1]);
								fscanf(fp,"%s\n",str);
							}
							else
							{
								pPolyline->m_pElevation[size2-1]=0;
								//fscanf(fp,"%s\n",str);
								//fscanf(fp,"%s\n",str);
							}
						//}
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"53")==0)
				{
					CADHatchLine* pHatchLine=new CADHatchLine();
					pHatch->m_HatchLines.Add((CObject*)pHatchLine);
					fscanf(fp,"%lf\n",&pHatchLine->m_Angle);
					fscanf(fp,"%s\n",str);
					i=0;
				}
				else if(strcmp(str,"43")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_BasePoint.x);
						fscanf(fp,"%s\n",str);
					}
				}
				else if(strcmp(str,"44")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_BasePoint.y);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"45")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_xOffset);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"46")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_yOffset);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"79")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%d\n",&pHatchLine->m_NumDash);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"49")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_Items[i]);
						fscanf(fp,"%s\n",str);
						i++;
					}	
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
	}
//////////////////////////////////////////////////////////////////////////////
	/*m_Graphics->m_Bound.left=xMin;
	m_Graphics->m_Bound.top=yMin;
	m_Graphics->m_Bound.right=xMax;
	m_Graphics->m_Bound.bottom=yMax;*/
	m_Graphics->m_Bound.left=m_Graphics->m_Extmin.x;
	m_Graphics->m_Bound.top=-m_Graphics->m_Extmax.y;
	m_Graphics->m_Bound.right=m_Graphics->m_Extmax.x;
	m_Graphics->m_Bound.bottom=-m_Graphics->m_Extmin.y;
	/*m_Graphics->m_Bound.left=m_Graphics->extmin[0];
	m_Graphics->m_Bound.top=m_Graphics->extmin[1];
	m_Graphics->m_Bound.right=m_Graphics->extmax[0];
	m_Graphics->m_Bound.bottom=m_Graphics->extmax[1];*/
	//m_Graphics->m_OrgPoint.x=m_Graphics->m_Bound.left;
	//m_Graphics->m_OrgPoint.y=-m_Graphics->m_Bound.bottom;
	fclose(fp);	
}

void CDxfFile::ReadHoleLegend(LPCTSTR lpFilename)
{
	FILE* fp;
	fp=fopen(lpFilename,"r");
	if(fp==NULL)return;

	const int MaxStrLen=1200;
	char str[1200];

	bool isEntity=false;
	bool isBlock=false;
	bool isClass=false;
	bool isPolylinePath=false;
	int i;
	while(! feof(fp) && ! ferror(fp))
	{
		//fscanf(fp,"%s\n",str);
		fgets(str, MaxStrLen, fp);
		DealStr(str);
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"BLOCK_RECORD") == 0)
		{
			CADBlockRecord* pBlockRecord=NULL;
			fscanf(fp,"%s\n",str);
			static int i=0;
			i++;
			if(i>1)
			{
				pBlockRecord=new CADBlockRecord();
				m_Graphics->m_BlockRecords.Add((CObject*)pBlockRecord);
				CADGraphics::CreateHandle(pBlockRecord->m_Handle);
			}
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{	
					if(pBlockRecord)
					{
						fscanf(fp,"%s\n",str);
						strcpy(pBlockRecord->m_Name,str);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);
					}
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//-----------------------------------------------------------------------------------------
		if(strcmp(str,"BLOCKS") ==0)
		{
			isBlock=true;
			isEntity=false;
			isClass=false;
		}
		if(strcmp(str,"BLOCK") ==0)
		{
			CADBlock* pBlock;
			pBlock=new CADBlock();
			m_Graphics->m_Blocks.Add((CObject*)pBlock);
//			char chr;
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"2")==0)
				{
					fscanf(fp,"%s\n",str);
					strcpy(pBlock->m_Name,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pBlock->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pBlock->m_BasePoint.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pBlock->m_BasePoint.y);
					fscanf(fp,"%s\n",str);							
				}
				else
				{
					/*fscanf(fp,"%c",&chr);
					fscanf(fp,"%c",&chr);
					if(chr!=10)
					{
						fseek(fp,-1,SEEK_CUR);
						fscanf(fp,"%s\n",str);
					}
					fscanf(fp,"%s",str);*/
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"ENTITIES") ==0)
		{
			isEntity=true;
			isBlock=false;
			isClass=false;
		}

//////////////////////////////////////////////////////////////////////////////
	/*	if(strcmp(str,"HATCH")==0)
		{
			Read_Hatch(FILE* fp,bool isEntity);
			CADHatch* pHatch;
			pHatch=new CADHatch();
			if(isEntity)
				Read_Hatch(FILE* fp,true);
			else
				Read_Hatch(FILE* fp,false);
		}*/
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"LINE") ==0)// && !isClass
		{
			CADLine* pLine;
			pLine=new CADLine();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pLine);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pLine);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pLine->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pLine->m_Handle);
					strcpy(CADGraphics::m_curHandle,pLine->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pLine->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pLine->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pLine->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"48")==0)
				{
					fscanf(fp,"%f\n",&pLine->m_LTypeScale);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pLine->pt1.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt1.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt1.z);
						fscanf(fp,"%s\n",str);
					}
					else
						pLine->pt1.z=0.0;*/						
				}
				else if(strcmp(str,"11")==0)
				{
					fscanf(fp,"%lf\n",&pLine->pt2.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pLine->pt2.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"31")==0)
					{
						fscanf(fp,"%lf\n",&pLine->pt2.z);
					}
					else
						pLine->pt2.z=0.0;*/								
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"LWPOLYLINE") ==0 && !isClass)
		{
			CADPolyline* pPolyline;
			pPolyline=new CADPolyline();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pPolyline);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pPolyline);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pPolyline->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pPolyline->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"6")==0)
				{
					fscanf(fp,"%s\n",str);
					pPolyline->m_LTypeName=new char[AD_MAX_STRLEN];
					strcpy(pPolyline->m_LTypeName,str);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"48")==0)
				{
					fscanf(fp,"%f\n",&pPolyline->m_LTypeScale);
					//::AfxMessageBox(pPolyline->m_LTypeScale);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"70")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0 || strcmp(str,"129")==0)
						pPolyline->m_Closed =true; 
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					ADPOINT* pPoint = new ADPOINT();
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
					pPolyline->m_Point.Add((CObject*)pPoint);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"SPLINE") ==0)
		{
			CADSpline* pSpline;
			pSpline = new CADSpline();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pSpline);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pSpline);
			}
			fscanf(fp,"%s\n",str);
			
			int nNumKnot = 0;
			int curNumKnot = 0;
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pSpline->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					ADPOINT* pPoint = new ADPOINT();
					pSpline->m_ControlPoint.Add((CObject*)pPoint);
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);					
				}
				else if(strcmp(str,"20")==0)
				{
					ADPOINT* pPoint = (ADPOINT*)pSpline->m_ControlPoint.GetAt(pSpline->m_ControlPoint.GetSize()-1);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"11")==0)
				{
					ADPOINT* pPoint = new ADPOINT();
					pSpline->m_FitPoint.Add((CObject*)pPoint);
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"21")==0)
				{
					ADPOINT* pPoint = (ADPOINT*)pSpline->m_FitPoint.GetAt(pSpline->m_FitPoint.GetSize()-1);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);					
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pSpline->m_pKnotPoints[curNumKnot]);
					curNumKnot++;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"72")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumKnot);
					nNumKnot = pSpline->m_NumKnot;
					pSpline->m_pKnotPoints = new double[nNumKnot];
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"73")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumControl);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"74")==0)
				{
					fscanf(fp,"%d\n",&pSpline->m_NumFit);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"CIRCLE") ==0)
		{
			CADCircle* pCircle;
			pCircle=new CADCircle();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pCircle);	
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pCircle);  
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pCircle->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"62")==0)
				{
					fscanf(fp,"%d\n",&pCircle->m_nColor);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pCircle->ptCenter.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pCircle->ptCenter.y);
					fscanf(fp,"%s\n",str);
					/*if(strcmp(str,"30")==0)
					{
						fscanf(fp,"%lf\n",&pCircle->ptCenter.z);
						fscanf(fp,"%s\n",str);
					}
					else
					pCircle->ptCenter.z=0.0;*/			
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pCircle->m_Radius);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////
		if(strcmp(str,"MTEXT") ==0)
		{
			CADMText* pMText;
			pMText=new CADMText();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pMText);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pMText);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"5")==0)
				{
					fscanf(fp,"%s\n",pMText->m_Handle);
					strcpy(CADGraphics::m_curHandle,pMText->m_Handle);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"1")==0)
				{
					//fscanf(fp,"%s",str);
					fgets(str, 1000, fp); 
					//char ch;
					//fscanf(fp,"%c",&ch);
					//while(ch==' ')
					//{
					//	fscanf(fp,"%s",str);
						
					//}
					pMText->m_Text = str;
					//::AfxMessageBox(str);
					fscanf(fp,"%s\n",str);					
					m_Graphics->SetMText(pMText,pMText->m_Text);				
				}
				else if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pMText->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Location.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pMText->m_Location.y);
					fscanf(fp,"%s\n",str);		
				}
				else if(strcmp(str,"11")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_ptDir.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pMText->m_ptDir.y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"40")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Height);
					pMText->m_Height=pMText->m_Height;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"41")==0)
				{
					fscanf(fp,"%lf\n",&pMText->m_Width);
					fscanf(fp,"%s\n",str);	
				}
				else if(strcmp(str,"71")==0)
				{
					fscanf(fp,"%c\n",&pMText->m_Align);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"44")==0)
				{
					fscanf(fp,"%f\n",&pMText->m_Interval);
					fscanf(fp,"%s\n",str);
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////

		if(strcmp(str,"HATCH")==0 && m_isReadHatch)
		{
			CADHatch* pHatch;
			pHatch=new CADHatch();
			if(isEntity)
				m_Graphics->m_Entities.Add((CObject*)pHatch);
			if(isBlock)
			{
				CADBlock* pBlock;
				pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
				pBlock->m_Entities.Add((CObject*)pHatch);
			}
			fscanf(fp,"%s\n",str);
			while(strcmp(str,"0")!=0)
			{
				if(strcmp(str,"8")==0)
				{
					fscanf(fp,"%s\n",str);					
					//int i=m_LayerGroup->indexOf(str);
					int i=m_LayerGroup->indexOf(PROJECTHOLELAYERNAME);
					pHatch->m_nLayer=i;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"2")==0)
				{
					fgets(str, 1000, fp);
					DealStr(str);
					strcpy(pHatch->m_Name,str);
					//fscanf(fp,"%s\n",str);
					//strcpy(pHatch->m_Name,str);
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
				else if(strcmp(str,"70")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0)
						pHatch->m_bSolidFill=true;
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"72")==0)
				{
					fscanf(fp,"%s\n",str);
					if(strcmp(str,"1")==0 || strcmp(str,"0")==0)
					{
						CADPolyline* pPolyline;
						pPolyline=new CADPolyline();
						pHatch->m_pPolyline=pPolyline;
						isPolylinePath=true;
						pHatch->m_Paths.Add((CObject*)pPolyline);
					}
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"98")==0)
				{
					fscanf(fp,"%d\n",&pHatch->m_nSeedCount);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.y);
					fscanf(fp,"%s\n",str);
				}
				else if(strcmp(str,"10")==0)
				{
					int size=pHatch->m_Paths.GetSize();
					if(pHatch->m_pPolyline)
					//if(isPolylinePath)
					{
						CADEntity* pEntity=(CADEntity*)pHatch->m_Paths.GetAt(size-1);
							CADPolyline* pPolyline=(CADPolyline*)pEntity;
							ADPOINT* pPoint = new ADPOINT();
							fscanf(fp,"%lf\n",&pPoint->x);
							fscanf(fp,"%s\n",str);
							fscanf(fp,"%lf\n",&pPoint->y);
							fscanf(fp,"%s\n",str);
							pPolyline->m_Point.Add((CObject*)pPoint);
							int size2=pPolyline->m_Point.GetSize();

							double* newPoints=new double[size2];
							if(pPolyline->m_pElevation!=NULL)
							{
								memcpy(newPoints, pPolyline->m_pElevation, sizeof(double) * (size2-1));
								delete[] pPolyline->m_pElevation;
							}
							pPolyline->m_pElevation=newPoints;
							if(strcmp(str,"42")==0)
							{
								fscanf(fp,"%lf\n",&pPolyline->m_pElevation[size2-1]);
								fscanf(fp,"%s\n",str);
							}
							else
							{
								pPolyline->m_pElevation[size2-1]=0;
							}
					}
					else
					{
						fgets(str, MaxStrLen, fp);		
						fgets(str, MaxStrLen, fp);
						DealStr(str);					
					}
				}
				else if(strcmp(str,"53")==0)
				{
					CADHatchLine* pHatchLine=new CADHatchLine();
					pHatch->m_HatchLines.Add((CObject*)pHatchLine);
					fscanf(fp,"%lf\n",&pHatchLine->m_Angle);
					fscanf(fp,"%s\n",str);
					i=0;
				}
				else if(strcmp(str,"43")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_BasePoint.x);
						fscanf(fp,"%s\n",str);
					}
				}
				else if(strcmp(str,"44")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_BasePoint.y);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"45")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_xOffset);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"46")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_yOffset);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"79")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%d\n",&pHatchLine->m_NumDash);
						fscanf(fp,"%s\n",str);
					}	
				}
				else if(strcmp(str,"49")==0)
				{
					int size=pHatch->m_HatchLines.GetSize();
					if(size>0)
					{
						CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(size-1);
						fscanf(fp,"%lf\n",&pHatchLine->m_Items[i]);
						fscanf(fp,"%s\n",str);
						i++;
					}	
				}
				else
				{
					fgets(str, MaxStrLen, fp);		
					fgets(str, MaxStrLen, fp);
					DealStr(str);
				}
			}
		pHatch->m_pPolyline=NULL;
		}
//////////////////////////////////////////////////////////////////////////////
	}
	fclose(fp);
}

void CDxfFile::Read_Hatch(FILE* fp,bool isEntity)
{
	int MaxStrLen=255;
	char str[255];
	CADHatch* pHatch;
	pHatch=new CADHatch();
	if(isEntity)
		m_Graphics->m_Entities.Add((CObject*)pHatch);
	else
	{
		CADBlock* pBlock;
		pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(m_Graphics->m_Blocks.GetSize()-1);
		pBlock->m_Entities.Add((CObject*)pHatch);
	}
	fscanf(fp,"%s\n",str);
	while(strcmp(str,"0")!=0)
	{
		if(strcmp(str,"8")==0)
		{
			fscanf(fp,"%s\n",str);
			int i=m_LayerGroup->indexOf(str);
			pHatch->m_nLayer=i;
			fscanf(fp,"%s\n",str);
		}
		else if(strcmp(str,"2")==0)
		{
			fscanf(fp,"%s\n",str);
			strcpy(pHatch->m_Name,str);
			fgets(str, MaxStrLen, fp);
			DealStr(str);
		}
		else if(strcmp(str,"70")==0)
		{
			fscanf(fp,"%s\n",str);
			if(strcmp(str,"1")==0)
				pHatch->m_bSolidFill=true; 
			fscanf(fp,"%s\n",str);
		}
		else if(strcmp(str,"72")==0)
		{
			fscanf(fp,"%s\n",str);
			if(strcmp(str,"1")==0 || strcmp(str,"0")==0)
			{
				CADPolyline* pPolyline;
				pPolyline=new CADPolyline();
				pHatch->m_Paths.Add((CObject*)pPolyline);
			}
			fscanf(fp,"%s\n",str);
		}
		else if(strcmp(str,"98")==0)
		{
			fscanf(fp,"%d\n",&pHatch->m_nSeedCount);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.x);
			fscanf(fp,"%s\n",str);
			fscanf(fp,"%lf\n",&pHatch->m_SeedPoint.y);
			fscanf(fp,"%s\n",str);
		}
		else if(strcmp(str,"10")==0)
		{
			int size=pHatch->m_Paths.GetSize();
			if(size>0)
			{
				CADEntity* pEntity=(CADEntity*)pHatch->m_Paths.GetAt(size-1);
				if(pEntity->GetType()==AD_ENT_POLYLINE)
				{
					CADPolyline* pPolyline=(CADPolyline*)pEntity;
					ADPOINT* pPoint = new ADPOINT();
					fscanf(fp,"%lf\n",&pPoint->x);
					fscanf(fp,"%s\n",str);
					fscanf(fp,"%lf\n",&pPoint->y);
					fscanf(fp,"%s\n",str);
					pPolyline->m_Point.Add((CObject*)pPoint);
					int size2=pPolyline->m_Point.GetSize();

					double* newPoints=new double[size2];
					if(pPolyline->m_pElevation!=NULL)
					{
						memcpy(newPoints, pPolyline->m_pElevation, sizeof(double) * (size2-1));
						delete[] pPolyline->m_pElevation;
					}
					pPolyline->m_pElevation=newPoints;
					if(strcmp(str,"42")==0)
					{
						fscanf(fp,"%lf\n",&pPolyline->m_pElevation[size2-1]);
						fscanf(fp,"%s\n",str);
					}
					else
					{
						pPolyline->m_pElevation[size2-1]=0;
						//fscanf(fp,"%s\n",str);
						//fscanf(fp,"%s\n",str);
					}
				}
			}
			else
			{
				fgets(str, MaxStrLen, fp);		
				fgets(str, MaxStrLen, fp);
				DealStr(str);					
			}
		}
		else
		{
			fgets(str, MaxStrLen, fp);		
			fgets(str, MaxStrLen, fp);
			DealStr(str);
		}
	}		
}

void CDxfFile::FileExport(LPCTSTR lpFilename)
{
	FILE* hFile;
	hFile=fopen(lpFilename,"w");
	if(hFile==NULL)return;

	strcpy(m_curHandle,"100");
//BEGINSEC(header)=================================================
	SectionBegin(hFile,SEC_HEADER);
	fprintf(hFile,"%s",DXACADVER);					
	fprintf(hFile,"%s"," 1\n");
	fprintf(hFile,"%s",AutoCAD2000);
	fprintf(hFile,"%s",CRLF);
//Write EXTMAX
	fprintf(hFile,"%s",EXTMAX);
	fprintf(hFile,"%s",DXFX);
	fprintf(hFile,"%f",m_Graphics->m_Extmax.x);
	fprintf(hFile,"%s",CRLF);
	fprintf(hFile,"%s",DXFY);
	fprintf(hFile,"%f",m_Graphics->m_Extmax.y);	
	fprintf(hFile,"%s",CRLF);
//Write EXTMIN
	fprintf(hFile,"%s",EXTMIN);
	fprintf(hFile,"%s",DXFX);
	fprintf(hFile,"%f",m_Graphics->m_Extmin.x);
	fprintf(hFile,"%s",CRLF);
	fprintf(hFile,"%s",DXFY);
	fprintf(hFile,"%f",m_Graphics->m_Extmin.y);	
	fprintf(hFile,"%s",CRLF);

	WriteParamString(hFile, 9, "$LIMMIN");
	WriteParamDouble(hFile, 10, 0.0);
	WriteParamDouble(hFile, 20, 0.0);

	WriteParamString(hFile, 9, "$LIMMAX");
	WriteParamDouble(hFile, 10, m_Graphics->m_Extmax.x);
	WriteParamDouble(hFile, 20, m_Graphics->m_Extmin.y);

	WriteParamString(hFile, 9, "$HANDSEED");
	//WriteParamString(pFile,5, m_Graphics->m_HandSeed);
	WriteParamString(hFile, 5, "9999999");
	SectionEnd(hFile);

//BEGINSEC(tables)=================================================
	SectionBegin(hFile,SEC_TABLES);

	TableBegin(hFile,TAB_LTYPE);
	WriteTable_LType(hFile);
	TableEnd(hFile);

	TableBegin(hFile,TAB_LAYER);
	WriteTable_Layer(hFile);
	TableEnd(hFile);

	TableBegin(hFile,TAB_STYLE);
	WriteTable_STyle(hFile);
	TableEnd(hFile);

	TableBegin(hFile,TAB_VPORT);
	WriteTable_VPort(hFile);
	TableEnd(hFile);

	TableBegin(hFile,TAB_VIEW);

	TableEnd(hFile);

	TableBegin(hFile,TAB_UCS);

	TableEnd(hFile);

	TableBegin(hFile,TAB_APPID);
	WriteTable_AppId(hFile);
	TableEnd(hFile);

	TableBegin(hFile,TAB_DIMSTYLE);

	TableEnd(hFile);

	TableBegin(hFile,TAB_BLOCKRECORD);
	WriteTable_Block_Record(hFile);
	TableEnd(hFile);

	SectionEnd(hFile);
//=======================================================================
//BEGINSEC(blocks)
	SectionBegin(hFile,SEC_BLOCKS);
	WriteBlocks(hFile);
	SectionEnd(hFile);

//BEGINSEC(entities)
	SectionBegin(hFile,SEC_ENTITIES);
	WriteEntities(hFile);
	SectionEnd(hFile);

//BEGINSEC(objects)
	SectionBegin(hFile,SEC_OBJECTS);
	WriteObjects(hFile);
	SectionEnd(hFile);

//Write eof
	WriteParamString(hFile, 0, "EOF");
	fclose(hFile);
}

void CDxfFile::SectionBegin(FILE* pFile,DWORD dwSection)
{
	switch(dwSection)
	{
		case SEC_HEADER:
			WriteParamString(pFile, 0, "SECTION");
			WriteParamString(pFile, 2, "HEADER");			
			break;
		case SEC_TABLES:
			WriteParamString(pFile, 0, "SECTION");
			WriteParamString(pFile, 2, "TABLES");			
			break;
		case SEC_BLOCKS:
			WriteParamString(pFile, 0, "SECTION");
			WriteParamString(pFile, 2, "BLOCKS");			
			break;
		case SEC_ENTITIES:
			WriteParamString(pFile, 0, "SECTION");
			WriteParamString(pFile, 2, "ENTITIES");			
			break;
		case SEC_OBJECTS:
			WriteParamString(pFile, 0, "SECTION");
			WriteParamString(pFile, 2, "OBJECTS");
			break;
		default:
			return;
	}
}

void CDxfFile::SectionEnd(FILE* pFile)
{
	WriteParamString(pFile, 0, "ENDSEC");
}

void CDxfFile::TableBegin(FILE* pFile,DWORD dwTableType)
{
	switch(dwTableType)
	{
		case TAB_LTYPE:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "LTYPE");	
			WriteParamString(pFile, 5, "5");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 1);			
			break;
		case TAB_LAYER:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "LAYER");
			WriteParamString(pFile, 5, "2");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 1);			
			break;
		case TAB_VPORT:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "VPORT");
			WriteParamString(pFile, 5, "8");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 1);			
			break;
		case TAB_APPID:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "APPID");
			WriteParamString(pFile, 5, "9");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 1);
			break;
		case TAB_BLOCKRECORD:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "BLOCK_RECORD");	
			WriteParamString(pFile, 5, "1");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 1);			
			break;
		case TAB_VIEW:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "VIEW");	
			WriteParamString(pFile, 5, "6");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 0);			
			break;
		case TAB_UCS:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "UCS");	
			WriteParamString(pFile, 5, "7");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 0);			
			break;
		case TAB_DIMSTYLE:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "DIMSTYLE");	
			WriteParamString(pFile, 5, "A");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 0);
			WriteParamString(pFile, 100, "AcDbDimStyleTable");
			WriteParamInteger(pFile, 71, 0);			
			break;
		case TAB_STYLE:
			WriteParamString(pFile, 0, "TABLE");
			WriteParamString(pFile, 2, "STYLE");	
			WriteParamString(pFile, 5, "3");
			WriteParamInteger(pFile, 330, 0);
			WriteParamString(pFile, 100, "AcDbSymbolTable");
			WriteParamInteger(pFile, 70, 0);			
			break;
		default:
			return;
	}
}

void CDxfFile::TableEnd(FILE* pFile)
{
	WriteParamString(pFile, 0, "ENDTAB");
}

void CDxfFile::WriteParamDouble( FILE* pFile, int GroupCode, double value )
{
	fprintf(pFile,"  %d\n%f\n", GroupCode, value);
}

void CDxfFile::WriteParamInteger( FILE* pFile, int GroupCode, int value )
{
	fprintf(pFile,"  %d\n%d\n", GroupCode, value);	
}

void CDxfFile::WriteParamString( FILE* pFile, int GroupCode, LPCTSTR value )
{
	fprintf(pFile,"  %d\n%s\n", GroupCode, value);
}

void CDxfFile::WriteTable_Layer(FILE* pFile)
{
	for(int i=0;i<m_LayerGroup->GetLayerCount();i++)
	{
		WriteParamString(pFile,0, "LAYER");
		CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
		//WriteParamString(pFile,5, pLayer->m_Handle);
		if (strcmp(pLayer->m_Name,"0")==0)
			WriteParamString(pFile, 5, "10");
		else
		{
			CreateNewHandle();
			WriteParamString(pFile, 5, m_curHandle);		
		}

		WriteParamString(pFile,100, "AcDbSymbolTableRecord");
		WriteParamString(pFile,100, "AcDbLayerTableRecord");
		WriteParamString(pFile,2, pLayer->m_Name);
		WriteParamInteger(pFile, 70, 0);
		WriteParamInteger(pFile, 62, pLayer->m_nColor);
		WriteParamString(pFile, 6, pLayer->m_LTypeName);
		if(!pLayer->m_isPrint)
			WriteParamInteger(pFile,290, 0);
		//WriteParamString(pFile,390, pLayer->m_PrintStyle);
		WriteParamString(pFile,390, "F");
	}
}

void CDxfFile::WriteTable_VPort(FILE* pFile)
{
	WriteParamString(pFile,0, "VPORT");
	WriteParamString(pFile,5, "2F");
	WriteParamString(pFile,100, "AcDbSymbolTableRecord");
	WriteParamString(pFile,100, "AcDbViewportTableRecord");
	WriteParamString(pFile,2, "*ACTIVE");
	WriteParamInteger(pFile, 70, 0);
	WriteParamDouble(pFile, 10, 0.0);
	WriteParamDouble(pFile, 20, 0.0);
	WriteParamDouble(pFile, 11, 1.0);
	WriteParamDouble(pFile, 21, 1.0);
	double x=(m_Graphics->m_Extmax.x+m_Graphics->m_Extmin.x)/2;
	double y=(m_Graphics->m_Extmax.y+m_Graphics->m_Extmin.y)/2;
	double w=fabs(m_Graphics->m_Extmax.x-m_Graphics->m_Extmin.x);
	double h=fabs(m_Graphics->m_Extmax.y-m_Graphics->m_Extmin.y);
	WriteParamDouble(pFile, 12, x);
	WriteParamDouble(pFile, 22, y);
	WriteParamDouble(pFile, 13, 0.0);
	WriteParamDouble(pFile, 23, 0.0);
	WriteParamDouble(pFile, 14, 10.0);
	WriteParamDouble(pFile, 24, 10.0);
	WriteParamDouble(pFile, 15, 10.0);
	WriteParamDouble(pFile, 25, 10.0);
	WriteParamDouble(pFile, 16, 0.0);
	WriteParamDouble(pFile, 26, 0.0);
	WriteParamDouble(pFile, 36, 1.0);
	WriteParamDouble(pFile, 17, 0.0);
	WriteParamDouble(pFile, 27, 0.0);
	WriteParamDouble(pFile, 37, 0.0);
	WriteParamDouble(pFile, 40, h);
	if(h==0)
		WriteParamDouble(pFile, 41, 1);
	else
		WriteParamDouble(pFile, 41, w/h);
	WriteParamDouble(pFile, 42, 50.0);
	WriteParamDouble(pFile, 43, 0.0);
	WriteParamDouble(pFile, 44, 0.0);
	WriteParamDouble(pFile, 50, 0.0);
	WriteParamDouble(pFile, 51, 0.0);
	WriteParamInteger(pFile, 71, 0);
	WriteParamInteger(pFile, 72, 100);
	WriteParamInteger(pFile, 73, 1);
	WriteParamInteger(pFile, 74, 3);
	WriteParamInteger(pFile, 75, 0);
	WriteParamInteger(pFile, 76, 0);
	WriteParamInteger(pFile, 77, 0);
	WriteParamInteger(pFile, 78, 0);
}

void CDxfFile::WriteTable_AppId(FILE* pFile)
{
	WriteParamString(pFile,0, "APPID");	
	WriteParamInteger(pFile, 5, 12);
	WriteParamString(pFile,100, "AcDbSymbolTableRecord");
	WriteParamString(pFile,100, "AcDbRegAppTableRecord");
	WriteParamString(pFile,2, "ACAD");
	WriteParamInteger(pFile, 70, 0);
}

void CDxfFile::WriteTable_Block_Record(FILE* pFile)
{
	for(int i=0;i<m_Graphics->m_BlockRecords.GetSize();i++)
	{
		CADBlockRecord* pBlockRecord=(CADBlockRecord*)m_Graphics->m_BlockRecords.GetAt(i);
		WriteParamString(pFile,0, "BLOCK_RECORD");
		//WriteParamString(pFile,5, pBlockRecord->m_Handle);
		if (strcmp(pBlockRecord->m_Name,"*Model_Space")==0)
			WriteParamString(pFile, 5, "1F");
		else if (strcmp(pBlockRecord->m_Name,"*Paper_Space")==0)
			WriteParamString(pFile, 5, "1B");
		else if (strcmp(pBlockRecord->m_Name,"*Paper_Space0")==0)
			WriteParamString(pFile, 5, "23");
		else
		{
			CreateNewHandle();
			WriteParamString(pFile, 5, m_curHandle);		
		}

		WriteParamString(pFile,100, "AcDbSymbolTableRecord");
		WriteParamString(pFile,100, "AcDbBlockTableRecord");
		WriteParamString(pFile,2, pBlockRecord->m_Name);				
	}
}

void CDxfFile::WriteTable_LType(FILE* pFile)
{
	for(int i=0;i<m_Graphics->m_LTypes.GetSize();i++)
	{
		CADLType* pLType=(CADLType*)m_Graphics->m_LTypes.GetAt(i);
		WriteParamString(pFile,0, "LTYPE");
		//WriteParamString(pFile,5, pLType->m_Handle);

		if (strcmp(pLType->m_Name,"ByBlock")==0)
			WriteParamString(pFile, 5, "14");
		else if (strcmp(pLType->m_Name,"ByLayer")==0)
			WriteParamString(pFile, 5, "15");
		else if (strcmp(pLType->m_Name,"CONTINUOUS")==0)
			WriteParamString(pFile, 5, "16");
		else
		{
			CreateNewHandle();
			WriteParamString(pFile, 5, m_curHandle);
		}

		WriteParamString(pFile,100, "AcDbSymbolTableRecord");
		WriteParamString(pFile,100, "AcDbLinetypeTableRecord");
		WriteParamString(pFile,2, pLType->m_Name);
		WriteParamInteger(pFile, 70, 0);
		if(pLType->m_ItemCount>0)
		{
			WriteParamInteger(pFile, 73, pLType->m_ItemCount);
			for(int j=0;j<pLType->m_ItemCount;j++)
			{
				WriteParamDouble(pFile, 49, pLType->m_Items[j]);
				WriteParamInteger(pFile, 74, 0);
			}
		}		
	}		
}

void CDxfFile::WriteTable_STyle(FILE* pFile)
{
	for(int i=0;i<m_Graphics->m_Styles.GetSize();i++)
	{
		CADStyle* pStyle=(CADStyle*)m_Graphics->m_Styles.GetAt(i);
		WriteParamString(pFile,0, "STYLE");
		//WriteParamString(pFile,5, pStyle->m_Handle);
		CreateNewHandle();
		WriteParamString(pFile, 5, m_curHandle);
		WriteParamString(pFile,100, "AcDbSymbolTableRecord");
		WriteParamString(pFile,100, "AcDbTextStyleTableRecord");
		WriteParamString(pFile,2, pStyle->m_Name);
		WriteParamInteger(pFile, 70, 0);
		WriteParamString(pFile,3, pStyle->m_Font);		
	}	
}

void CDxfFile::WriteTable_View(FILE* pFile)
{

}
//==========================================================================
void CDxfFile::WriteBlocks(FILE* pFile)
{
//write default
	int j=m_Graphics->m_Blocks.GetSize();
	for(int i=0;i<m_Graphics->m_Blocks.GetSize();i++)
	{
		CADBlock* pBlock=(CADBlock*)m_Graphics->m_Blocks.GetAt(i);
		WriteParamString(pFile,0, "BLOCK");
		CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(pBlock->m_nLayer);
		if(pLayer==NULL)continue;
		//WriteParamString(pFile,5, pBlock->m_Handle);
		if (strcmp(pBlock->m_Name,"*Model_Space")==0)
			WriteParamString(pFile, 5, "20");
		else if (strcmp(pBlock->m_Name,"*Paper_Space")==0)
			WriteParamString(pFile, 5, "1C");
		else if (strcmp(pBlock->m_Name,"*Paper_Space0")==0)
			WriteParamString(pFile, 5, "24");
		else
		{
			CreateNewHandle();
			WriteParamString(pFile, 5, m_curHandle);		
		}

		WriteParamString(pFile,100, "AcDbEntity");
		WriteParamString(pFile,8, pLayer->m_Name);
		WriteParamString(pFile,100, "AcDbBlockBegin");
		WriteParamString(pFile,2, pBlock->m_Name);

		WriteParamInteger(pFile, 70, 0);
		WriteParamDouble(pFile, 10, 0.0);
		WriteParamDouble(pFile, 20, 0.0);
		WriteParamDouble(pFile, 30, 0.0);
		for(int j=0;j<pBlock->m_Entities.GetSize();j++)
		{
			CADEntity* pEntity;
			pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
			WriteEntities(pFile,pEntity);
		}
		WriteParamString(pFile,0, "ENDBLK");

		if (strcmp(pBlock->m_Name,"*Model_Space")==0)
			WriteParamString(pFile, 5, "21");
		else if (strcmp(pBlock->m_Name,"*Paper_Space")==0)
			WriteParamString(pFile, 5, "1D");
		else if (strcmp(pBlock->m_Name,"*Paper_Space0")==0)
			WriteParamString(pFile, 5, "25");
		else
		{
			CreateNewHandle();
			WriteParamString(pFile, 5, m_curHandle);		
		}

		WriteParamString(pFile,100, "AcDbEntity");
		WriteParamString(pFile,8, pLayer->m_Name);
		WriteParamString(pFile,100, "AcDbBlockEnd");		
	}			
}

void CDxfFile::WriteObjects(FILE* pFile)
{
	char handle1[8];
	CreateNewHandle();
	strcpy(handle1,m_curHandle);
	//CADGraphics::CreateHandle(handle1);
	char handle2[8];
	CreateNewHandle();
	strcpy(handle2,m_curHandle);
	//CADGraphics::CreateHandle(handle2);
	char handle3[8];
	CreateNewHandle();
	strcpy(handle3,m_curHandle);
	//CADGraphics::CreateHandle(handle3);

	WriteParamString(pFile,0, "DICTIONARY");
	WriteParamString(pFile,5, "C");
	WriteParamInteger(pFile, 330, 0);
	WriteParamString(pFile,100, "AcDbDictionary");
	WriteParamString(pFile,3, "ACAD_GROUP");
	WriteParamString(pFile,350, "D");
	WriteParamString(pFile,3, "ACAD_LAYOUT");
	//WriteParamString(pFile,350, "1A");
	WriteParamString(pFile,350, handle1);
	WriteParamString(pFile,3, "ACAD_MLINESTYLE");
	//WriteParamString(pFile,350, "18");
	WriteParamString(pFile,350, handle2);

	WriteParamString(pFile,0, "DICTIONARY");
	WriteParamString(pFile,5, "D");
	WriteParamString(pFile,100, "AcDbDictionary");
//------------------------------------------------------------	
	WriteParamString(pFile,0, "DICTIONARY");
	WriteParamString(pFile,5, handle1);
	WriteParamString(pFile,100, "AcDbDictionary");
	WriteParamString(pFile,3, "Model");
	//WriteParamString(pFile,350, "22");
	WriteParamString(pFile,350, handle3);

	WriteParamString(pFile,0, "DICTIONARY");
	WriteParamString(pFile,5, handle2);
	WriteParamString(pFile,100, "AcDbDictionary");
	WriteParamString(pFile,3, "Standard");
	WriteParamString(pFile,350, handle2);

	WriteParamString(pFile,0, "LAYOUT");
	WriteParamString(pFile,5, handle3);
	WriteParamString(pFile,100, "AcDbPlotSettings");
	WriteParamString(pFile,100, "AcDbLayout");
	WriteParamString(pFile,1, "Model");
	int indexBlockRecord;
	indexBlockRecord=m_Graphics->IndexOfBlockRecords("*MODEL_SPACE");
	if(indexBlockRecord==-1) return;
	CADBlockRecord* pBlockRecord;
	pBlockRecord=(CADBlockRecord*)m_Graphics->m_BlockRecords.GetAt(indexBlockRecord);
	//WriteParamString(pFile,330,pBlockRecord->m_Handle);
	WriteParamString(pFile,330,"1F");
}

void CDxfFile::WriteEntities(FILE* pFile)
{
	for(int i=0;i<m_Graphics->m_Entities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_Graphics->m_Entities.GetAt(i);
		WriteEntities(pFile,pEntity);
	}
}

void CDxfFile::WriteEntities(FILE* pFile,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				WriteParamString(pFile, 0, "POINT");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbPoint");
				WriteEntity_Point(pFile,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				WriteParamString(pFile, 0, "LINE");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbLine");
				WriteEntity_Line(pFile,(CADLine*)pEntity);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				WriteParamString(pFile, 0, "CIRCLE");
				WriteEntity_Common(pFile,(CADCircle*)pEntity);
				WriteParamString(pFile, 100, "AcDbCircle");
				WriteEntity_Circle(pFile,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				WriteParamString(pFile, 0, "LWPOLYLINE");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbPolyline");
				WriteEntity_LwPolyline(pFile,(CADPolyline*)pEntity);
				break;
			}
		case AD_ENT_INSERT:
			{
				WriteParamString(pFile, 0, "INSERT");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbBlockReference");
				WriteEntity_Insert(pFile,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				WriteParamString(pFile, 0, "ARC");
				WriteEntity_Common(pFile,(CADMText*)pEntity);
				WriteParamString(pFile, 100, "AcDbCircle");
				WriteEntity_Arc(pFile,(CADArc*)pEntity);
				break;
			}
		case AD_ENT_MTEXT:
			{
				WriteParamString(pFile, 0, "MTEXT");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbMText");
				WriteEntity_MText(pFile,(CADMText*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				WriteParamString(pFile, 0, "SPLINE");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbSpline");
				WriteEntity_Spline(pFile,(CADSpline*)pEntity);
				break;
			}
		case AD_ENT_TEXT:
			{
				WriteParamString(pFile, 0, "TEXT");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbText");
				WriteEntity_Text(pFile,(CADText*)pEntity);
				WriteParamString(pFile, 100, "AcDbText");
				break;
			}
		case AD_ENT_SOLID:
			{
				WriteParamString(pFile, 0, "SOLID");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbTrace");
				WriteEntity_Solid(pFile,(CADSolid*)pEntity);
				break;
			}
		case AD_ENT_HATCH:
			{
				WriteParamString(pFile, 0, "HATCH");
				WriteEntity_Common(pFile,pEntity);
				WriteParamString(pFile, 100, "AcDbHatch");
				WriteEntity_Hatch(pFile,(CADHatch*)pEntity);
				break;
			}
	}		
}

void CDxfFile::WriteEntity_Common(FILE* pFile,CADEntity* pEntity)
{
	int i=pEntity->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);

	//WriteParamString(pFile, 5, pEntity->m_Handle);
	CreateNewHandle();
	WriteParamString(pFile, 5, m_curHandle);
	WriteParamString(pFile, 100, "AcDbEntity");
	if(pLayer==NULL)
		WriteParamString(pFile, 8, "0");
	else
		WriteParamString(pFile, 8, pLayer->m_Name);
	if(pEntity->m_LTypeName)
		WriteParamString(pFile, 6, pEntity->m_LTypeName);
	if(pEntity->m_LTypeScale!=1.0)		
		WriteParamDouble(pFile, 48, pEntity->m_LTypeScale);
	if(pEntity->m_nColor>0 && pEntity->m_nColor<256)
		WriteParamInteger(pFile, 62, pEntity->m_nColor);
}

void CDxfFile::WriteEntity_Point(FILE* pFile,CADPoint* pPoint)
{
	WriteParamDouble(pFile, 10, pPoint->pt.x);
	WriteParamDouble(pFile, 20, pPoint->pt.y);
}

void CDxfFile::WriteEntity_Arc(FILE* pFile,CADArc* pArc)
{
/*	int i=pArc->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
	WriteParamString(pFile, 0, "ARC");
	WriteParamString(pFile, 5, pArc->m_Handle);
	WriteParamString(pFile, 100, "AcDbEntity");
	WriteParamString(pFile, 8, pLayer->m_Name);
	if(pArc->m_nColor>0 && pArc->m_nColor<256)
		WriteParamInteger(pFile, 62, pArc->m_nColor);*/
	
	WriteParamDouble(pFile, 10, pArc->ptCenter.x);
	WriteParamDouble(pFile, 20, pArc->ptCenter.y);
	WriteParamDouble(pFile, 40, pArc->m_Radius);
	WriteParamString(pFile, 100, "AcDbArc");
	WriteParamDouble(pFile, 50, pArc->m_StartAng);
	WriteParamDouble(pFile, 51, pArc->m_EndAng);

}

void CDxfFile::WriteEntity_Line(FILE* pFile,CADLine* pLine)
{
/*	int i=pLine->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
	WriteParamString(pFile, 0, "LINE");
	WriteParamString(pFile, 5, pLine->m_Handle);
	WriteParamString(pFile, 100, "AcDbEntity");
	WriteParamString(pFile, 8, pLayer->m_Name);
	if(pLine->m_nColor>0 && pLine->m_nColor<256)
		WriteParamInteger(pFile, 62, pLine->m_nColor);*/
	
	WriteParamDouble(pFile, 10, pLine->pt1.x);
	WriteParamDouble(pFile, 20, pLine->pt1.y);
	WriteParamDouble(pFile, 11, pLine->pt2.x);
	WriteParamDouble(pFile, 21, pLine->pt2.y);
}

void CDxfFile::WriteEntity_Polyline(FILE* pFile,CADPolyline* pPolyline)
{
/*	int i=pPolyline->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
	WriteParamString(pFile, 0, "POLYLINE");
	WriteParamString(pFile, 8, pLayer->m_Name);
	WriteParamInteger(pFile, 66, 1);
	if(pPolyline->m_nColor>0 && pPolyline->m_nColor<256)
		WriteParamInteger(pFile, 62, pPolyline->m_nColor);*/
	
	if(pPolyline->m_Closed)
		WriteParamInteger(pFile, 70, 1);

	for(int i=0;i<pPolyline->m_Point.GetSize();i++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);
		WriteParamString(pFile, 0, "VERTEX");
//		WriteParamString(pFile, 8, pLayer->m_Name);
		WriteParamDouble(pFile, 10, pPoint->x);
		WriteParamDouble(pFile, 20, pPoint->y);	
	}
	WriteParamString(pFile, 0, "SEQEND");
}

void CDxfFile::WriteEntity_LwPolyline(FILE* pFile,CADPolyline* pPolyline)
{
/*	int i=pPolyline->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
	WriteParamString(pFile, 0, "LWPOLYLINE");
	WriteParamString(pFile, 5, pPolyline->m_Handle);
	WriteParamString(pFile, 100, "AcDbEntity");
	WriteParamString(pFile, 8, pLayer->m_Name);
	WriteParamString(pFile, 100, "AcDbPolyline");
	WriteParamInteger(pFile, 66, 1)
	if(pPolyline->m_nColor>0 && pPolyline->m_nColor<256)
		WriteParamInteger(pFile, 62, pPolyline->m_nColor);;*/

	WriteParamInteger(pFile, 90, pPolyline->m_Point.GetSize());//points count
	
	if(pPolyline->m_Closed)
		WriteParamInteger(pFile, 70, 1);

	for(int i=0;i<pPolyline->m_Point.GetSize();i++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);
		WriteParamDouble(pFile, 10, pPoint->x);
		WriteParamDouble(pFile, 20, pPoint->y);	
	}
}

void CDxfFile::WriteEntity_MText(FILE* pFile,CADMText* pMText)
{
/*	int i=pMText->m_nLayer; 
	CADLayer* pLayer=(CADLayer*)m_LayerGroup->GetLayer(i);
	WriteParamString(pFile, 0, "MTEXT");
	WriteParamString(pFile, 8, pLayer->m_Name);
	if(pMText->m_nColor>0 && pMText->m_nColor<256)
		WriteParamInteger(pFile, 62, pMText->m_nColor);*/

	char ch[2];	
	ch[0]=pMText->m_Align;
	ch[1]='\0';
	CString str;
	if(pMText->m_Font!="")
	{
		str="{\\f";
		str=str+pMText->m_Font;
		str=str+"|b0|i0|c134|p54;";
	}
	str=str+pMText->m_Text;
	str=str+"}";
	str.Replace("\r\n","\\P");
	str.Replace("\n","\\P");
	WriteParamString(pFile, 1, (LPCTSTR)str);
	WriteParamDouble(pFile, 11, pMText->m_ptDir.x);
	WriteParamDouble(pFile, 21, pMText->m_ptDir.y);
	WriteParamString(pFile, 71,ch);
	WriteParamDouble(pFile, 10, pMText->m_Location.x);
	WriteParamDouble(pFile, 20, pMText->m_Location.y);
	WriteParamDouble(pFile, 40, pMText->m_Height-1);
	if (pMText->m_isWarp)
		WriteParamDouble(pFile, 41, pMText->m_Width);
	WriteParamDouble(pFile, 44, pMText->m_Interval);
}

void CDxfFile::WriteEntity_Text(FILE* pFile,CADText* pText)
{
	WriteParamDouble(pFile, 10, pText->m_Location.x);
	WriteParamDouble(pFile, 20, pText->m_Location.y);
	WriteParamDouble(pFile, 40, pText->m_Height-1);
	WriteParamString(pFile, 1, pText->m_Text);
	WriteParamDouble(pFile, 50, pText->m_Angle);
	WriteParamString(pFile, 7, pText->m_StyleName);
}

void CDxfFile::WriteEntity_Solid(FILE* pFile,CADSolid* pSolid)
{

	WriteParamDouble(pFile, 10, pSolid->m_pt0.x);
	WriteParamDouble(pFile, 20, pSolid->m_pt0.y);
	WriteParamDouble(pFile, 11, pSolid->m_pt1.x);
	WriteParamDouble(pFile, 21, pSolid->m_pt1.y);
	WriteParamDouble(pFile, 12, pSolid->m_pt2.x);
	WriteParamDouble(pFile, 22, pSolid->m_pt2.y);
	WriteParamDouble(pFile, 13, pSolid->m_pt3.x);
	WriteParamDouble(pFile, 23, pSolid->m_pt3.y);
}

void CDxfFile::WriteEntity_Circle(FILE* pFile,CADCircle* pCircle)
{
	WriteParamDouble(pFile, 10, pCircle->ptCenter.x);
	WriteParamDouble(pFile, 20, pCircle->ptCenter.y);
	WriteParamDouble(pFile, 40, pCircle->m_Radius);
}

void CDxfFile::WriteEntity_Spline(FILE* pFile,CADSpline* pSpline)
{
	WriteParamInteger(pFile, 71, 3);
	WriteParamInteger(pFile, 72, pSpline->m_NumKnot);
	WriteParamInteger(pFile, 73, pSpline->m_NumControl);
	WriteParamInteger(pFile, 74, pSpline->m_NumFit);
	for(int i=0;i<pSpline->m_NumKnot;i++)
	{
		WriteParamDouble(pFile, 40, pSpline->m_pKnotPoints[i]);
	}
	for(i=0;i<pSpline->m_ControlPoint.GetSize();i++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_ControlPoint.GetAt(i);
		WriteParamDouble(pFile, 10, pPoint->x);
		WriteParamDouble(pFile, 20, pPoint->y);	
	}
	for(i=0;i<pSpline->m_FitPoint.GetSize();i++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(i);
		WriteParamDouble(pFile, 11, pPoint->x);
		WriteParamDouble(pFile, 21, pPoint->y);	
	}
}

void CDxfFile::WriteEntity_Hatch(FILE* pFile,CADHatch* pHatch)
{

	WriteParamDouble(pFile, 10, 0.0);
	WriteParamDouble(pFile, 20, 0.0);
	WriteParamDouble(pFile, 30, 0.0);
	WriteParamDouble(pFile, 210, 0.0);
	WriteParamDouble(pFile, 220, 0.0);
	WriteParamDouble(pFile, 230, 1.0);

	WriteParamString(pFile, 2, pHatch->m_Name);
	if(pHatch->m_bSolidFill)
		WriteParamInteger(pFile, 70, 1);
	else
		WriteParamInteger(pFile, 70, 0);
	WriteParamInteger(pFile, 71, 1);
	WriteParamInteger(pFile, 91, 1);
	WriteParamInteger(pFile, 92, 7);

	double seedX=0.0;
	double seedY=0.0;
	//
	if(pHatch->m_pPolyline)
	{
		WriteParamInteger(pFile, 72, 0);
		WriteParamInteger(pFile, 73, 1);
		WriteParamInteger(pFile, 93, pHatch->m_pPolyline->m_Point.GetSize());
		for(int i=0;i<pHatch->m_pPolyline->m_Point.GetSize();i++)
		{
			ADPOINT* pPoint=(ADPOINT*)pHatch->m_pPolyline->m_Point.GetAt(i);
			WriteParamDouble(pFile, 10, pPoint->x);
			WriteParamDouble(pFile, 20, pPoint->y);	
			if(i==0){pHatch->m_SeedPoint = *pPoint;}
		}

		WriteParamInteger(pFile, 97, 0);//1 have border
		WriteParamInteger(pFile, 75, 0);
		WriteParamInteger(pFile, 76, 1);
		WriteParamDouble(pFile, 52, 0.0);//angle
		WriteParamDouble(pFile, 41, pHatch->m_Scale);//scale
		WriteParamInteger(pFile, 77, 0);
		WriteParamInteger(pFile, 78, pHatch->m_HatchLines.GetSize());
	}
//===============================================================================
	if(pHatch->m_bSolidFill)
	{
		for(int i=0;i<pHatch->m_Paths.GetSize();i++)
		{
			CADPolyline* pPolyline;
			pPolyline=(CADPolyline*)pHatch->m_Paths.GetAt(0);
			WriteParamInteger(pFile, 72, 1);//Í¹¶È
			WriteParamInteger(pFile, 73, 1);
			WriteParamInteger(pFile, 93, pPolyline->m_Point.GetSize());
			for(int j=0;j<pPolyline->m_Point.GetSize();j++)
			{
				ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j); 
				WriteParamDouble(pFile, 10, pPoint->x);
				WriteParamDouble(pFile, 20, pPoint->y);		
				WriteParamDouble(pFile, 42, pPolyline->m_pElevation[j]);
			}
		}

		if(pHatch->m_Paths.GetSize()>0)
		{
			WriteParamInteger(pFile, 97, 0);//1 have border
			WriteParamInteger(pFile, 75, 0);
			WriteParamInteger(pFile, 76, 1);
		}
	}
//===============================================================================
	for(int i=0;i<pHatch->m_HatchLines.GetSize();i++)
	{
		CADHatchLine* pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(i);
		WriteParamDouble(pFile, 53, pHatchLine->m_Angle);
		WriteParamDouble(pFile, 43, pHatchLine->m_BasePoint.x);
		WriteParamDouble(pFile, 44, pHatchLine->m_BasePoint.y);
		WriteParamDouble(pFile, 45, pHatchLine->m_xOffset);
		WriteParamDouble(pFile, 46, pHatchLine->m_yOffset);
		WriteParamInteger(pFile, 79, pHatchLine->m_NumDash);
		for(int j=0;j<pHatchLine->m_NumDash;j++)
		{
			WriteParamDouble(pFile, 49, pHatchLine->m_Items[j]);	
		}
	}
	WriteParamDouble(pFile, 47, 0.6680005703708726);
	WriteParamInteger(pFile, 98, 1);
	WriteParamDouble(pFile, 10, pHatch->m_SeedPoint.x);
	WriteParamDouble(pFile, 20, pHatch->m_SeedPoint.y);
}

void CDxfFile::WriteEntity_Insert(FILE* pFile,CADInsert* pInsert)
{
	WriteParamString(pFile, 2, pInsert->m_Name);
	
	WriteParamDouble(pFile, 10, pInsert->pt.x);
	WriteParamDouble(pFile, 20, pInsert->pt.y);
	WriteParamDouble(pFile, 50, pInsert->m_Rotation);
	WriteParamDouble(pFile, 41, pInsert->m_xScale);
	WriteParamDouble(pFile, 42, pInsert->m_yScale);
}

void CDxfFile::CreateNewHandle()
{
	long i=Change(m_curHandle);
	i+=1;
	CString str;
	str.Format("%X",i);
	strcpy(m_curHandle,(LPCTSTR)str);
}