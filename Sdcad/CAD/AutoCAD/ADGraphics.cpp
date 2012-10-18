#include "stdafx.h"
#include "ADGraphics.h"
#include <math.h>
#include "spline.h"
#include "..\FunctionLib\Function_String.h"
#include "..\FunctionLib\Function_System.h"
//----------------------------------------------------------

IMPLEMENT_DYNCREATE(CADGraphics,CObject)

AD_OBJHANDLE CADGraphics::m_curHandle="2B";
bool CADGraphics::isCreateHandle=true;
//strcpy(CADGraphics::m_curHandle,"2B");

CADGraphics::CADGraphics()
{
//	m_Patterns[0].Pattern_SmallID=IDB_BITMAP1;
//	strcpy(m_HandSeed,"ËØÌîÍÁ");

	m_bBlack = false;

	strcpy(m_HandSeed,"999999");
	m_curWorkSpace=MODELSPACE;

	m_RotateAngle=0;
	m_Unit=UNIT_METER;
	m_PaperOrient=HORIZONTAL;

	m_bLineWidth = false;
	m_bHaveSnap=false;

	m_LineWidthFactor=1;

	m_ZoomRate = 1.0;
	m_OriginZoomRate = 1.0;
	m_OrgPoint.x = 0;
	m_OrgPoint.y = 0;
	m_ViewOffset.cx = 0;
	m_ViewOffset.cy = 0;
	m_selectedHandle = 0;

	m_HandleWidth=3;
	m_pDisplay=NULL;
	m_BKColor=RGB(0,0,0);
	m_WhiteColor = RGB(255,255,255);
//	m_pTempInsert=NULL;
//	m_pTempEntity=NULL;
	m_pLayerGroup=NULL;
	m_pSelHandleEntity=NULL;
	m_bSnapStatus=false;

	m_GraphicsMode = Layout;

	m_FrameMaginLeft=0;
	m_FrameMaginTop=0;
	m_FrameMaginRight=0;
	m_FrameMaginBottom=0;

	m_LayoutLeftMargin = 50;
	m_LayoutTopMargin = 50;

	m_PaperSpace.scale=1;

//	m_xScale=1;
//	m_yScale=1;

	m_PrintWidth=419.51;
	m_PrintHeight=296.38;

	m_PaperWidth = A3_WIDTH;
	m_PaperHeight = A3_HEIGHT;

	m_NullPen=new CPen();
	if (!m_NullPen->CreatePen(PS_NULL, 1, RGB(0,0,0)))
	return;

	m_HandleBrush=new CBrush(RGB(255,0,0));

	m_HandlePen=new CPen();
	if (!m_HandlePen->CreatePen(PS_SOLID, 1, RGB(0,0,255)))
	return;

//	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;

	m_NullBrush=new CBrush();
	m_NullBrush->CreateBrushIndirect(&logBrush);

	m_pPen=NULL;
	m_pOldPen=NULL;

	m_DashPen=new CPen();
	if (!m_DashPen->CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;

	m_isDrawMText=true;

	m_pRSelEntity = NULL;
	m_pCopyEntity = NULL;
	m_bRSelected = false;
}

CADGraphics::~CADGraphics()
{
	for (int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)(m_Entities.GetAt(i));
		delete pEntity;
		m_Entities.SetAt(i,NULL);
	}
	m_Entities.RemoveAll();

	for (i=0;i<m_Blocks.GetSize();i++)
	{
		CADBlock* pBlock = (CADBlock*)(m_Blocks.GetAt(i));
		delete pBlock;
	}
	m_Blocks.RemoveAll();

//Tables=================================================================
	for (i=0;i<m_Styles.GetSize();i++)
	{
		CADStyle* pStyle = (CADStyle*)(m_Styles.GetAt(i));
		delete pStyle;
	}
	m_Styles.RemoveAll();

	for (i=0;i<m_LTypes.GetSize();i++)
	{
		CADLType* pLType = (CADLType*)(m_LTypes.GetAt(i));
		delete pLType;
	}
	m_LTypes.RemoveAll();

	for (i=0;i<m_BlockRecords.GetSize();i++)
	{
		CADBlockRecord* pBlockRecord = (CADBlockRecord*)(m_BlockRecords.GetAt(i));
		delete pBlockRecord;
	}
	m_BlockRecords.RemoveAll();

//end Tables=================================================================

	if(m_NullPen!=NULL)delete m_NullPen;
	if(m_HandlePen!=NULL)delete m_HandlePen;
	if(m_NullBrush!=NULL)delete m_NullBrush;
	if(m_HandleBrush!=NULL)delete m_HandleBrush;
	if(m_DashPen!=NULL)delete m_DashPen;
}

CADEntity* CADGraphics::SelectEntity(const CPoint& point)
{
	for(int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)m_Entities.GetAt(i);
		if(pEntity->m_nLayer<0)continue;
		CADLayer* pLayer = m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if(pLayer->m_nColor<0)continue;

		if(SelectGraphics(point,pEntity))
		{
			return pEntity;
		}
	}
	return NULL;
}

//added on 200811/1
CADEntity* CADGraphics::RightSelectEntity(const CPoint& point)
{
	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)m_SelectedEntities.GetAt(i);
		if(pEntity->m_nLayer<0)continue;

		CString str;
		str.Format("%d",pEntity->m_nLayer);
		CADLayer* pLayer = m_pLayerGroup->GetLayer(pEntity->m_nLayer,1);
		//::AfxMessageBox("str");
		if(pLayer !=NULL && pLayer->m_nColor<0)continue;
		
		if(SelectGraphics(point,pEntity))
		{
			return pEntity;
		}
	}
	//::AfxMessageBox("ddd");
	return NULL;
}

bool CADGraphics::SelectGraphics(const CPoint& point)
{
	if(m_SelectedEntities.GetSize()>0)
	{
		SelectHandle(point);
		if(m_selectedHandle>0)return true;
	}

	for(int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)m_Entities.GetAt(i);
		if(pEntity->m_nLayer<0)continue;
		CADLayer* pLayer = m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if (pLayer==NULL)continue;
		if (pLayer->m_nColor<0)continue;

		if (SelectGraphics(point,pEntity))
		{
			for (int j=0;j<m_SelectedEntities.GetSize();j++)
			{
				if (m_SelectedEntities[j]==(CObject*)pEntity)return false;
			}
			m_SelectedEntities.Add((CObject*)pEntity);
			return true;
		}
	}
	return false;
}

bool CADGraphics::SelectGraphics(const CPoint& point,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				return SelectPoint(point,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				return SelectLine(point,(CADLine*)pEntity);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				return SelectCircle(point,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				return SelectPolyline(point,(CADPolyline*)pEntity);
				break;
			}
		case AD_ENT_INSERT:
			{
				return SelectInsert(point,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				return SelectArc(point,(CADArc*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				return SelectSpline(point,(CADSpline*)pEntity);
				break;
			}
		case AD_ENT_MTEXT:
			{
				return SelectMText(point,(CADMText*)pEntity);
				break;
			}
		case AD_ENT_TEXT:
			{
				return SelectText(point,(CADText*)pEntity);
				break;
			}
		case AD_ENT_SOLID:
			{
				return SelectSolid(point,(CADSolid*)pEntity);
				break;
			}
	}
	return false;
}

bool CADGraphics::SelectGraphics2(const CPoint& point,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				return SelectPoint(point,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				return SelectLine(point,(CADLine*)pEntity);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				return SelectCircle(point,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				return SelectPolyline(point,(CADPolyline*)pEntity);
				break;
			}
		case AD_ENT_INSERT:
			{
				return SelectInsert(point,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				return SelectArc(point,(CADArc*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				return SelectSpline(point,(CADSpline*)pEntity);
				break;
			}
		case AD_ENT_SOLID:
			{
				return SelectSolid(point,(CADSolid*)pEntity);
				break;
			}
		case AD_ENT_MTEXT:
			{
				return SelectMText(point,(CADMText*)pEntity);
				break;
			}
	}
	return false;
}

bool CADGraphics::SelectPoint(const CPoint& point,CADPoint* pPoint)
{	
	if(isSelectedPoint(point,DocToClient(pPoint->pt)))
		return true;
	return false;
}

bool CADGraphics::SelectLine(const CPoint& point,CADLine* pLine)
{
	if (isSelectedLine(point,DocToClient(pLine->pt1),DocToClient(pLine->pt2)))
		return true;
	return false;
}

bool CADGraphics::SelectPolyline(const CPoint& point,CADPolyline* pPolyline)
{
	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points = new CPoint[pointCount];
	CPoint *points1 = points;
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(j);
		*points = DocToClient(*pPoint);
		points++;
	}
	if(isSelectedPolyline(point,points1,pointCount,pPolyline->m_Closed))
	{
		delete [] points1;
		return true;
	}else
	{
		delete [] points1;
		return false;
	}
}

bool CADGraphics::SelectSpline(const CPoint& point,CADSpline* pSpline)
{
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	if (FitPtCount==0)return false;
	CPoint* points = new CPoint[FitPtCount];
	CPoint* points1 = points;

	for(int j=0;j<FitPtCount;j++)
	{
		//ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		*points=DocToClient(*(ADPOINT*)pSpline->m_FitPoint.GetAt(j));
		points++;
	}
	Spline spline(points1, FitPtCount);
	spline.Generate();
	pSpline->m_CurvePoints.RemoveAll();
	pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
	int PointCount = 0;
	spline.GetCurve(pSpline->m_CurvePoints.GetData(), PointCount);

	if(isSelectedPolyline(point,(CPoint*)pSpline->m_CurvePoints.GetData(),PointCount,false))
	{
		delete [] points1;
		pSpline->m_CurvePoints.RemoveAll();
		return true;
	}else
	{
		delete [] points1;
		pSpline->m_CurvePoints.RemoveAll();
		return false;
	}
}

bool CADGraphics::SelectCircle(const CPoint& point,CADCircle* pCircle)
{
	if(isSelectedCircle(point,DocToClient(pCircle->ptCenter),DocToClient(pCircle->m_Radius)))
		return true;
	return false;
}

bool CADGraphics::SelectMText(const CPoint& point,CADMText* pMText)
{
	//return isSelectedRectangle(point,GetMTextRect(pMText));
	CRect rect=GetMTextRect(pMText);
	CPoint* points=new CPoint[4];
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	CPoint point1;
	points[0].x=rect.left;
	points[0].y=rect.top;
	points[0]=Rotate(pointOrigin,points[0],angle);
	points[1].x=rect.right;
	points[1].y=rect.top;
	points[1]=Rotate(pointOrigin,points[1],angle);
	points[2].x=rect.right;
	points[2].y=rect.bottom;
	points[2]=Rotate(pointOrigin,points[2],angle);
	points[3].x=rect.left;
	points[3].y=rect.bottom;
	points[3]=Rotate(pointOrigin,points[3],angle);
	bool result = isInPolygon(point,points,4);
	delete[] points;
	return result;
}

bool CADGraphics::SelectText(const CPoint& point,CADText* pText)
{
/*	CRect rect=GetMTextRect(pMText);
	CPoint* points=new CPoint[4];
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	CPoint point1;
	points[0].x=rect.left;
	points[0].y=rect.top;
	points[0]=Rotate(pointOrigin,points[0],angle);
	points[1].x=rect.right;
	points[1].y=rect.top;
	points[1]=Rotate(pointOrigin,points[1],angle);
	points[2].x=rect.right;
	points[2].y=rect.bottom;
	points[2]=Rotate(pointOrigin,points[2],angle);
	points[3].x=rect.left;
	points[3].y=rect.bottom;
	points[3]=Rotate(pointOrigin,points[3],angle);
	bool result=isInPolygon(point,points,4);
	delete points;
	return result;*/
	return false;
}

bool CADGraphics::SelectSolid(const CPoint& point,CADSolid* pSolid)
{
	short pointCount = 4;
	CPoint* points = new CPoint[pointCount];

	points[0]=DocToClient(pSolid->m_pt0);
	points[1]=DocToClient(pSolid->m_pt1);
	points[2]=DocToClient(pSolid->m_pt3);
	points[3]=DocToClient(pSolid->m_pt2);

	if(isSelectedPolyline(point,points,pointCount,true))
	{
		delete [] points;
		return true;
	}else
	{
		delete [] points;
		return false;
	}	
}

bool CADGraphics::SelectArc(const CPoint& point,CADArc* pArc)
{
	if(isSelectedArc(point,DocToClient(pArc->ptCenter),
		DocToClient(pArc->m_Radius),pArc->m_StartAng,pArc->m_EndAng))
		return true;
	return false; 
}

bool CADGraphics::SelectInsert(const CPoint& point,CADInsert* pInsert)
{
	int indexBlock=this->IndexOfBlocks(pInsert->m_Name);
	if(indexBlock==-1)return false;
	ADPOINT adPoint;
	adPoint=pInsert->pt;
	double xScale,yScale;
	xScale=pInsert->m_xScale;
	yScale=pInsert->m_yScale;
	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(indexBlock);
	adPoint.x+=pBlock->m_BasePoint.x;
	adPoint.y+=pBlock->m_BasePoint.y;
	double Rotation=pInsert->m_Rotation;

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);			
		if(SelectInsert(point,pEntity,adPoint,xScale,yScale,Rotation))
			return true;
	}		
	return false;
}

bool CADGraphics::SelectInsert(CPoint point,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_LINE:
			{
				if(SelectInsert_Line(point,(CADLine*)pEntity,BasePoint,xScale,yScale,rotation))
					return true;
				break;
			}
		case AD_ENT_POLYLINE:
			{
				if(SelectInsert_Polyline(point,(CADPolyline*)pEntity,BasePoint,xScale,yScale,rotation))
					return true;
				break;
			}
		case AD_ENT_CIRCLE:
			{
				if(SelectInsert_Circle(point,(CADCircle*)pEntity,BasePoint,xScale,yScale,rotation))
					return true;
				break;
			}
	}
	return false;
}

bool CADGraphics::SelectInsert_Point(const CPoint& point,CADPoint* pPoint,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	return false;
}

bool CADGraphics::SelectInsert_Line(const CPoint& point,CADLine* pLine,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CPoint point1,point2;
	ADPOINT adPoint;
	adPoint=pLine->pt1;
	adPoint.x*=xScale;
	adPoint.y*=yScale;
	adPoint=Rotate(BasePoint,adPoint,rotation);
	//adPoint.x+=BasePoint.x; 
	//adPoint.y+=BasePoint.y;
	point1=DocToClient(adPoint);
	adPoint=pLine->pt2;
	adPoint.x*=xScale;
	adPoint.y*=yScale;
	adPoint=Rotate(BasePoint,adPoint,rotation);
	//adPoint.x+=BasePoint.x; 
	//adPoint.y+=BasePoint.y;
	point2=DocToClient(adPoint);
	if(isSelectedLine(point,point1,point2))return true;
	else return false;
}

bool CADGraphics::SelectInsert_Polyline(const CPoint& point,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points = new CPoint[pointCount];
	CPoint *points1=points;
	for (int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		ADPOINT adPoint = *pPoint;
		adPoint.x *= xScale;
		adPoint.y *= yScale;
		adPoint=Rotate(BasePoint,adPoint,rotation);
		*points=DocToClient(adPoint);
		points++;
	}
	if (isSelectedPolyline(point,points1,pointCount,pPolyline->m_Closed))
	{
		delete[] points1;
		return true;
	}
	else
	{
		delete[] points1;
		return false;
	}
	return false;
}

bool CADGraphics::SelectInsert_Circle(const CPoint& point,CADCircle* pCircle,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	ADPOINT adPoint=pCircle->ptCenter;
	//adPoint.x*=xScale;
	//adPoint.y*=yScale;
	adPoint.x+=BasePoint.x; 
	adPoint.y+=BasePoint.y;
	//adPoint=Rotate(BasePoint,adPoint,rotation);
	if(isSelectedCircle(point,DocToClient(adPoint),DocToClient(pCircle->m_Radius*xScale)))
		return true;
	return false;
}

void CADGraphics::UndoAllSelected()
{
	m_selectedHandle=0;
	m_pSelHandleEntity=NULL;
	m_SelectedEntities.RemoveAll();
}

//m_mXPixel ÎªiºÁÃ×»òÃ×=¶àÉÙÏñËØ
CPoint CADGraphics::DocToClient(const ADPOINT& point)
{
	if(m_GraphicsMode==Model)
	{
		return CPoint((long)((point.x-m_Bound.left)*m_ZoomRate),
					 (long)((-point.y-m_Bound.top)*m_ZoomRate));
	}
	else if(m_GraphicsMode==Layout)
	{
		return CPoint((long)((point.x*m_mXPixel/m_PaperSpace.scale-m_Bound.left)*m_ZoomRate+m_LayoutLeftMargin),
					  (long)((-point.y*m_mYPixel/m_PaperSpace.scale-m_Bound.top)*m_ZoomRate+m_LayoutTopMargin));
	}
	else if(m_GraphicsMode==Printing)
	{
		return CPoint((long)(point.x*m_mXPrintPixel-m_PrintBound.left),
					  (long)(-point.y*m_mYPrintPixel-m_PrintBound.top));
	}
}

CSize CADGraphics::DocToClient(const ADSIZE& size)
{
	if(m_GraphicsMode==Model)
	{
		return CSize((int)(size.cx*m_ZoomRate),(int)(size.cy*m_ZoomRate));
	}
	else if(m_GraphicsMode==Layout)
	{
		return CSize((int)(size.cx*m_mXPixel*m_ZoomRate),(int)(size.cy*m_mYPixel*m_ZoomRate));
	}
	else if(m_GraphicsMode==Printing)
	{
		return CSize((int)(size.cx*m_mXPrintPixel),(int)(size.cy*m_mYPrintPixel));
	}
}

int CADGraphics::DocToClient(double val)
{
	if(m_GraphicsMode==Model)
		return (int)(val*m_ZoomRate);		
	else if(m_GraphicsMode==Layout)
		return (int)(val*m_mXPixel*m_ZoomRate);
	else if(m_GraphicsMode==Printing)
		return (int)(val*m_mYPrintPixel);		
}

double CADGraphics::ClientToDoc(int val)
{
	if(m_GraphicsMode==Layout)
		return (double)(val/m_mXPixel/m_ZoomRate);
	else
		return (double)(val/m_ZoomRate);
}

ADPOINT CADGraphics::ClientToDoc(const CPoint& point)
{
	ADPOINT tempPoint;
	if(m_GraphicsMode==Layout)
	{
		tempPoint.x=((point.x-m_LayoutLeftMargin)/m_ZoomRate+m_Bound.left)/m_mXPixel;
		tempPoint.y=-((point.y-m_LayoutTopMargin)/m_ZoomRate+m_Bound.top)/m_mYPixel;	
	}
	else
	{
		tempPoint.x=point.x/m_ZoomRate+m_Bound.left;
		tempPoint.y=-(point.y/m_ZoomRate+m_Bound.top);
	}
	return tempPoint;
}

ADSIZE CADGraphics::ClientToDoc(const CSize& size)
{
	ADSIZE tempSize;
	if(m_GraphicsMode==Layout)
	{
		tempSize.cx=(double)(size.cx/(double)m_mXPixel/m_ZoomRate);
		tempSize.cy=(double)(size.cy/(double)m_mYPixel/m_ZoomRate);
	}
	else
	{
		tempSize.cx=(double)(size.cx/m_ZoomRate);
		tempSize.cy=(double)(size.cy/m_ZoomRate);		
	}
	return tempSize;	
}

void CADGraphics::DrawLayoutFrame(CDC* pDC)
{
	CRect rect,rect2;
	CPoint point1,point2;

	ADPOINT adPoint1,adPoint2;
	adPoint1.x = m_PaperLeft;
	adPoint1.y = m_PaperTop;

	if ((m_PaperOrient == HORIZONTAL && m_PaperWidth < m_PaperHeight) || 
	    (m_PaperOrient != HORIZONTAL && m_PaperWidth > m_PaperHeight))
	{
			double temp = m_PaperWidth;
			m_PaperWidth = m_PaperHeight;
			m_PaperHeight = temp;
	}

	if(m_Unit==UNIT_MILLIMETER)
	{
		adPoint2.x = m_PaperLeft+m_PaperWidth;
		adPoint2.y = m_PaperTop-m_PaperHeight;	
	}
	else if(m_Unit==UNIT_METER)
	{
		adPoint2.x=m_PaperLeft+m_PaperWidth/1000;
		adPoint2.y=m_PaperTop-m_PaperHeight/1000;		
	}

	point1=DocToClient(adPoint1);
	point2=DocToClient(adPoint2);
	rect.left=point1.x;
	rect.top=point1.y;
	rect.right=point2.x;
	rect.bottom=point2.y;

	if(m_Unit==UNIT_MILLIMETER)
	{
		adPoint1.x=m_PaperLeft+5;
		adPoint1.y=m_PaperTop-5;
		adPoint2.x=m_PaperLeft+m_PaperWidth+2;
		adPoint2.y=m_PaperTop-m_PaperHeight-2;	
	}
	else if(m_Unit==UNIT_METER)
	{
		adPoint1.x=m_PaperLeft+5/1000;
		adPoint1.y=m_PaperTop-5/1000;
		adPoint2.x=m_PaperLeft+m_PaperWidth/1000+2/1000;
		adPoint2.y=m_PaperTop-m_PaperHeight/1000-2/1000;		
	}

	point1=DocToClient(adPoint1);
	point2=DocToClient(adPoint2);
	rect2.left=point1.x;
	rect2.top=point1.y;
	rect2.right=point2.x;
	rect2.bottom=point2.y;

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, RGB(0,0,0)))
	return;
	CPen* pOldPen=pDC->SelectObject(&pen);
	CBrush brush;
	brush.CreateSolidBrush(RGB(0,0,0));
	CBrush* pOldBrush=pDC->SelectObject(&brush);
	pDC->Rectangle(rect2);
	pDC->SelectObject(pOldBrush);
	brush.DeleteObject();

	CBrush brush2;
	brush2.CreateSolidBrush(RGB(255,255,255));
	pOldBrush=pDC->SelectObject(&brush2); 
	pDC->Rectangle(rect);
	pDC->SelectObject(pOldBrush);
	brush2.DeleteObject();
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
}

/*void CADGraphics::AddFrame()
{
	m_FrameMaginLeft=ClientToDoc(50);
	m_FrameMaginRight=ClientToDoc(50);
	m_FrameMaginTop=ClientToDoc(50);
	m_FrameMaginBottom=ClientToDoc(100);

	if(!m_pLayerGroup)return;
	if(m_pLayerGroup->GetLayerCount()==0)return;
	int nLayer=m_pLayerGroup->indexOf(PROJECTNAME);
	if(nLayer==-1)return;

	CADPolyline* pPolyline=new CADPolyline();
	ADPOINT* pPoint=new ADPOINT();
	pPoint->x = m_Extmin.x-m_FrameMaginLeft;
	pPoint->y = m_Extmax.y+m_FrameMaginTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_Extmax.x+m_FrameMaginRight;
	pPoint->y = m_Extmax.y+m_FrameMaginTop;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_Extmax.x+m_FrameMaginRight;
	pPoint->y = m_Extmin.y-m_FrameMaginBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPoint=new ADPOINT();
	pPoint->x = m_Extmin.x-m_FrameMaginLeft;
	pPoint->y = m_Extmin.y-m_FrameMaginBottom;
	pPolyline->m_Point.Add((CObject*)pPoint);
	pPolyline->m_Closed=true;
	pPolyline->m_nLayer=nLayer; 
	m_Entities.Add((CObject*)pPolyline);
}
*/
void CADGraphics::DrawGraphics(CDC* pDC)
{
/*	if(m_curWorkSpace==PAPERSPACE)
	{
		m_pDisplay->CreatePaperDC();
		CDC* pPaperDC=m_pDisplay->GetPaperDC();
		CBrush brush;
		brush.CreateSolidBrush(m_BKColor);
		CRect rect(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight());
		pPaperDC->FillRect(&rect, &brush);
		m_PaperLeft=0;
		m_PaperTop=A3_HEIGHT;
		
		DrawLayoutFrame(pPaperDC);

	}*/

	if(m_GraphicsMode!=Printing)
	{
		CBrush brush;
		brush.CreateSolidBrush(m_BKColor);
		CRect rect(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight());
		pDC->FillRect(&rect, &brush);
		brush.DeleteObject(); 
	}
	if (m_GraphicsMode==Layout)
		DrawLayoutFrame(pDC);

	int EntitiesCount = m_Entities.GetSize();
	for(int i=0;i<EntitiesCount;i++)
	{
		CADEntity* pEntity=(CADEntity*)m_Entities.GetAt(i);
		CADLayer* pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if(pLayer==NULL)continue;
		if(pLayer->m_nColor<0)continue;
		DrawGraphics(pDC,pEntity);
	}
}

void CADGraphics::DrawGraphics(CDC* pDC,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				DrawPoint(pDC,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;			
				DrawLine(pDC,(CADLine*)pEntity);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_CIRCLE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;
				DrawCircle(pDC,(CADCircle*)pEntity);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_POLYLINE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;
				DrawPolyline(pDC,(CADPolyline*)pEntity);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_INSERT:
			{
				DrawInsert(pDC,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				if(!CreatePenStyle(pDC,pEntity))return;
				DrawArc(pDC,(CADArc*)pEntity);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_MTEXT:
			{
				DrawMText(pDC,(CADMText*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;
				DrawSpline(pDC,(CADSpline*)pEntity);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_TEXT:
			{
				DrawText(pDC,(CADText*)pEntity);
				break;
			}
		case AD_ENT_SOLID:
			{
				DrawSolid(pDC,(CADSolid*)pEntity);
				break;
			}
		case AD_ENT_HATCH:
			{
				DrawHatch(pDC,(CADHatch*)pEntity);
				break;
			}
	}
}

void CADGraphics::DrawHandle(CDC* pDC)
{
	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		CPen handlePen;
		if (!handlePen.CreatePen(PS_SOLID, 1, RGB(0,0,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&handlePen);

		CPen nullPen;
		if (!nullPen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
		return;

		CBrush nullBrush;
		LOGBRUSH logBrush;
		logBrush.lbColor = 0;
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_NULL;
		nullBrush.CreateBrushIndirect(&logBrush);
		CBrush* pOldBrush = pDC->SelectObject(&nullBrush);
		DrawHandle(pDC,pEntity);
		pDC->SelectObject(&pOldPen);
		pDC->SelectObject(&pOldBrush);
	}
}

void CADGraphics::DrawHandle(CDC* pDC,int fromSeletedIndex)
{
	if (fromSeletedIndex<0)return;

	for(int i=fromSeletedIndex;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		CPen handlePen;
		if (!handlePen.CreatePen(PS_SOLID, 1, RGB(0,0,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&handlePen);

		CPen nullPen;
		if (!nullPen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
		return;
		CBrush nullBrush;
		LOGBRUSH logBrush;
		logBrush.lbColor = 0;
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_NULL;
		nullBrush.CreateBrushIndirect(&logBrush);
		CBrush* pOldBrush = pDC->SelectObject(&nullBrush);
		DrawHandle(pDC,pEntity);
		pDC->SelectObject(&pOldPen);
		pDC->SelectObject(&pOldBrush);
	}
}

void CADGraphics::DrawHandle(CDC* pDC,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				DrawHandle_Point(pDC,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				DrawHandle_Line(pDC,(CADLine*)pEntity);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				DrawHandle_Circle(pDC,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				DrawHandle_Polyline(pDC,(CADPolyline*)pEntity);
				break;
			}
		case AD_ENT_INSERT:
			{
				DrawHandle_Insert(pDC,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				DrawHandle_Arc(pDC,(CADArc*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				DrawHandle_Spline(pDC,(CADSpline*)pEntity);
				break;
			}
		case AD_ENT_MTEXT:
			{
				DrawHandle_MText(pDC,(CADMText*)pEntity);
				break;
			}
		case AD_ENT_SOLID:
			{
				DrawHandle_Solid(pDC,(CADSolid*)pEntity);
				break;
			}
	}
}

void CADGraphics::DrawHandle_Arc(CDC* pDC,CADArc* pArc)
{
	//pDC->SelectObject(m_HandlePen);
	//pDC->SelectObject(m_NullBrush);

	ADPOINT adPoint;
	CPoint ptStart,ptEnd,ptMiddle;
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);
	ptStart=DocToClient(adPoint);
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_EndAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_EndAng*PI/180);
	ptEnd=DocToClient(adPoint);
	double angle=(pArc->m_StartAng+pArc->m_EndAng)/2;
	if(pArc->m_StartAng>pArc->m_EndAng)
	{
		if(angle<180)angle+=180;
		else angle-=180;
	}
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(angle*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(angle*PI/180);	
	ptMiddle=DocToClient(adPoint);

	pDC->Rectangle(ptStart.x-m_HandleWidth,ptStart.y-m_HandleWidth,ptStart.x+m_HandleWidth,ptStart.y+m_HandleWidth);
	pDC->Rectangle(ptEnd.x-m_HandleWidth,ptEnd.y-m_HandleWidth,ptEnd.x+m_HandleWidth,ptEnd.y+m_HandleWidth);
	pDC->Rectangle(ptMiddle.x-m_HandleWidth,ptMiddle.y-m_HandleWidth,ptMiddle.x+m_HandleWidth,ptMiddle.y+m_HandleWidth);

	if(m_pSelHandleEntity==pArc)
	{
		CPen pen;
		if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&pen);		
		CBrush brush1(RGB(255,0,0));
		CBrush* pOldBrush = pDC->SelectObject(&brush1);
		if(m_selectedHandle==1)
			pDC->Rectangle(ptStart.x-m_HandleWidth,ptStart.y-m_HandleWidth,ptStart.x+m_HandleWidth+1,ptStart.y+m_HandleWidth+1);
		if(m_selectedHandle==2)
			pDC->Rectangle(ptEnd.x-m_HandleWidth,ptEnd.y-m_HandleWidth,ptEnd.x+m_HandleWidth+1,ptEnd.y+m_HandleWidth+1);
		if(m_selectedHandle==3)
			pDC->Rectangle(ptMiddle.x-m_HandleWidth,ptMiddle.y-m_HandleWidth,ptMiddle.x+m_HandleWidth+1,ptMiddle.y+m_HandleWidth+1);
		pDC->SelectObject(&pOldPen);
		pDC->SelectObject(&pOldBrush);
	}
}

void CADGraphics::DrawHandle_Line(CDC* pDC,CADLine* pLine)
{
	CPoint point1,point2,pointCenter;
	point1=DocToClient(pLine->pt1);
	point2=DocToClient(pLine->pt2);

	ADPOINT adPoint;
	pLine->GetCenter(&adPoint);
	pointCenter=DocToClient(adPoint);

	//GetPointCenter(point1,point2,pointCenter);
	pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
	pDC->Rectangle(point2.x-m_HandleWidth,point2.y-m_HandleWidth,point2.x+m_HandleWidth,point2.y+m_HandleWidth);
	pDC->Rectangle(pointCenter.x-m_HandleWidth,pointCenter.y-m_HandleWidth,pointCenter.x+m_HandleWidth,pointCenter.y+m_HandleWidth);

	if(m_pSelHandleEntity==pLine)
	{
		CPen pen;
		if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
		return;
		CPen* pOldPen = pDC->SelectObject(&pen);		
		CBrush brush1(RGB(255,0,0));
		CBrush* pOldBrush = pDC->SelectObject(&brush1);
		if(m_selectedHandle==1)
			pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		if(m_selectedHandle==2)
			pDC->Rectangle(point2.x-m_HandleWidth,point2.y-m_HandleWidth,point2.x+m_HandleWidth+1,point2.y+m_HandleWidth+1);
		if(m_selectedHandle==3)
			pDC->Rectangle(pointCenter.x-m_HandleWidth,pointCenter.y-m_HandleWidth,pointCenter.x+m_HandleWidth+1,pointCenter.y+m_HandleWidth+1);
		pDC->SelectObject(&pOldPen);
		pDC->SelectObject(&pOldBrush);
	}
}

void CADGraphics::DrawHandle_Point(CDC* pDC,CADPoint* pPoint)
{
	CPoint point1=DocToClient(pPoint->pt);
	pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
	if(m_pSelHandleEntity==pPoint && m_selectedHandle==1)
	{
		CPen* pOldPen=pDC->GetCurrentPen();
		CBrush* pOldBrush=pDC->GetCurrentBrush(); 
		CPen pen;
		if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
		return;
		pDC->SelectObject(&pen);		
		CBrush* pBrush=new CBrush(RGB(255,0,0));
		pDC->SelectObject(pBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		delete pBrush;
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
}

void CADGraphics::DrawHandle_Polyline(CDC* pDC,CADPolyline* pPolyline)
{	
	int pointCount=pPolyline->m_Point.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		CPoint point1=DocToClient(*pPoint);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth); 
		if(m_pSelHandleEntity==pPolyline && m_selectedHandle==(j+1))
		{
			CPen pen;
			if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
			return;
			CPen* pOldPen = pDC->SelectObject(&pen);		
			CBrush brush1(RGB(255,0,0));
			CBrush* pOldBrush = pDC->SelectObject(&brush1);
			pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
			pDC->SelectObject(pOldPen);
			pDC->SelectObject(pOldBrush);
		}
	}
}

void CADGraphics::DrawHandle_Spline(CDC* pDC,CADSpline* pSpline)
{	
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	CPoint point1;
	for(int j=0;j<FitPtCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		point1=DocToClient(*pPoint);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		if(m_pSelHandleEntity==pSpline && m_selectedHandle==(j+1))
		{
			CPen* pOldPen=pDC->GetCurrentPen();
			CBrush* pOldBrush=pDC->GetCurrentBrush(); 
			CPen pen;
			if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,255)))
			return;
			pDC->SelectObject(&pen);		
			CBrush* brush1=new CBrush(RGB(255,0,0));
			pDC->SelectObject(brush1);
			pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
			pDC->SelectObject(pOldPen);
			pDC->SelectObject(pOldBrush);
		}
	}
}

void CADGraphics::DrawHandle_MText(CDC* pDC,CADMText* pMText)
{
	CRect rect=GetMTextRect(pMText);
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	CPoint point1;
	point1.x=rect.left;
	point1.y=rect.top;
	point1=Rotate(pointOrigin,point1,angle);
	if(m_pSelHandleEntity==pMText && m_selectedHandle==1)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=rect.right;
	point1.y=rect.top;
	point1=Rotate(pointOrigin,point1,angle);
	if(m_pSelHandleEntity==pMText && m_selectedHandle==2)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=rect.right;
	point1.y=rect.bottom;
	point1=Rotate(pointOrigin,point1,angle);
	if(m_pSelHandleEntity==pMText && m_selectedHandle==3)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=rect.left;
	point1.y=rect.bottom;
	point1=Rotate(pointOrigin,point1,angle);
	if(m_pSelHandleEntity==pMText && m_selectedHandle==4)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
}

void CADGraphics::DrawHandle_Text(CDC* pDC,CADText* pText)
{

}

void CADGraphics::DrawHandle_Solid(CDC* pDC,CADSolid* pSolid)
{
	CPoint point1=DocToClient(pSolid->m_pt0);
	if(m_pSelHandleEntity==pSolid && m_selectedHandle==1)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1=DocToClient(pSolid->m_pt1);
	if(m_pSelHandleEntity==pSolid && m_selectedHandle==2)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1=DocToClient(pSolid->m_pt2);
	if(m_pSelHandleEntity==pSolid && m_selectedHandle==3)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1=DocToClient(pSolid->m_pt3);
	if(m_pSelHandleEntity==pSolid && m_selectedHandle==4)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
}

void CADGraphics::DrawHandle_Circle(CDC* pDC,CADCircle* pCircle)
{
	CPoint ptCenter=DocToClient(pCircle->ptCenter);
	int radius=DocToClient(pCircle->m_Radius);

	CPoint point1=ptCenter;
	if(m_pSelHandleEntity==pCircle && m_selectedHandle==1)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=ptCenter.x-radius;
	point1.y=ptCenter.y;
	if(m_pSelHandleEntity==pCircle && m_selectedHandle==2)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=ptCenter.x;
	point1.y=ptCenter.y-radius;
	if(m_pSelHandleEntity==pCircle && m_selectedHandle==3)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=ptCenter.x+radius;
	point1.y=ptCenter.y;
	if(m_pSelHandleEntity==pCircle && m_selectedHandle==4)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	point1.x=ptCenter.x;
	point1.y=ptCenter.y+radius;
	if(m_pSelHandleEntity==pCircle && m_selectedHandle==5)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
}

void CADGraphics::DrawHandle_Insert(CDC* pDC,CADInsert* pInsert)
{
	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;
	ADPOINT BasePoint;
	BasePoint=pInsert->pt;
	double xScale,yScale;
	xScale=pInsert->m_xScale;
	yScale=pInsert->m_yScale;
	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x+=pBlock->m_BasePoint.x;
	BasePoint.y+=pBlock->m_BasePoint.y;
	CPoint point1;
	point1=DocToClient(BasePoint);
	if(m_pSelHandleEntity==pInsert && m_selectedHandle==1)
	{
		CPen* pOldPen = pDC->SelectObject(m_NullPen);
		CBrush* pOldBrush = pDC->SelectObject(m_HandleBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth+1,point1.y+m_HandleWidth+1);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
	else
	{
		CPen* pOldPen = pDC->SelectObject(m_HandlePen);
		CBrush* pOldBrush = pDC->SelectObject(m_NullBrush);
		pDC->Rectangle(point1.x-m_HandleWidth,point1.y-m_HandleWidth,point1.x+m_HandleWidth,point1.y+m_HandleWidth);
		pDC->SelectObject(pOldPen);
		pDC->SelectObject(pOldBrush);
	}
}

void CADGraphics::DrawLine(CDC* pDC,CADLine* pLine)
{
	pDC->MoveTo(DocToClient(pLine->pt1));
	pDC->LineTo(DocToClient(pLine->pt2));
}

void CADGraphics::DrawPoint(CDC* pDC,CADPoint* pPoint)
{
	if(pPoint->m_nLayer<0)return;
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pPoint->m_nLayer);
	if(pLayer->m_nColor<0)return;

	if(pPoint->m_nColor<0)
		pDC->SetPixel(DocToClient(pPoint->pt),GetColor(pLayer->m_nColor));
	else
		pDC->SetPixel(DocToClient(pPoint->pt),GetColor(pPoint->m_nColor));
}

void CADGraphics::DrawText(CDC* pDC,CADText* pText)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	//pDC->SetBkMode(TRANSPARENT);
	if(pText->m_nColor<0)
		pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		pDC->SetTextColor(GetColor(pText->m_nColor));
	CPoint point;
	point=DocToClient(pText->m_Location);

	int index=IndexOfStyles(pText->m_StyleName);
	if(index==-1)return;

	CADStyle* pStyle=(CADStyle*)m_Styles.GetAt(index);
	ADSIZE adSize = {0,pText->m_Height+1};
	//adSize.cx=0;
	//adSize.cy=pText->m_Height+1;
	CSize size=DocToClient(adSize);

	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	//font.CreateFont(pText->m_Size*2*m_ZoomRate, 0, 
	font.CreateFont(fontHeight, 0, 
			(int)(pText->m_Angle*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x04 | FF_DONTCARE, pStyle->m_Font);
		//	VARIABLE_PITCH | 0x04 | FF_DONTCARE, "ËÎÌå");
	pDC->SetTextAlign(TA_BASELINE);
	CFont* pOldFont=pDC->SelectObject(&font);
	pDC->TextOut(point.x,point.y,pText->m_Text);
    pDC->SelectObject(pOldFont);
	font.DeleteObject();	
}

void CADGraphics::DrawMText(CDC* pDC,CADMText* pText)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	int oldMode=pDC->SetBkMode(TRANSPARENT);//modified 2004-05-18
	pDC->SetBkMode(TRANSPARENT);
	COLORREF oldColor;
	if(pText->m_nColor<0)
		oldColor=pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		oldColor=pDC->SetTextColor(GetColor(pText->m_nColor));
	CPoint point;
	point=DocToClient(pText->m_Location);
	double angle;
	angle=atan2(pText->m_ptDir.y,pText->m_ptDir.x)*180/PI;

	ADSIZE adSize;
	adSize.cx=0;
	adSize.cy=pText->m_Height;
	CSize size;
	size=DocToClient(adSize);

	CSize size2;
	adSize.cx=pText->m_Width;
	adSize.cy=0;
	size2=DocToClient(adSize);

	CRect rect;
	rect.left=point.x;
	rect.right=point.y;

	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	font.CreateFont(fontHeight, 0, 
			(int)(angle*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x800 | FF_SWISS, pText->m_Font);
			//VARIABLE_PITCH | 0x800 | FF_SWISS, "ºÚÌå");

	CFont* pOldFont=pDC->SelectObject(&font);

	CSize size3 = pDC->GetTextExtent("a",1);
	//pDC->TextOut(point.x,point.y,pText->m_Text);
	//pText->m_Text="²ã\r\r\rºÅ"; 
	//pDC->DrawText(pText->m_Text,CRect(point,size2),DT_WORDBREAK | DT_NOCLIP);	

	char align=pText->m_Align; 
	switch(align)
	{
		case AD_MTEXT_ATTACH_TOPLEFT:
			pDC->SetTextAlign(TA_TOP | TA_LEFT); 
			break;
		case AD_MTEXT_ATTACH_TOPCENTER:
			pDC->SetTextAlign(TA_TOP | TA_CENTER); 
			break;
		case AD_MTEXT_ATTACH_TOPRIGHT:
			pDC->SetTextAlign(TA_TOP | TA_RIGHT); 
			break;
		case AD_MTEXT_ATTACH_MIDDLELEFT:
			pDC->SetTextAlign(TA_LEFT);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLECENTER:
			pDC->SetTextAlign(TA_CENTER);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLERIGHT:
			pDC->SetTextAlign(TA_RIGHT); 
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_BOTTOMLEFT:
			pDC->SetTextAlign(TA_BOTTOM | TA_LEFT); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMCENTER:
			pDC->SetTextAlign(TA_BOTTOM | TA_CENTER); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMRIGHT:
			pDC->SetTextAlign(TA_BOTTOM | TA_RIGHT); 
			break;
	}

	if(!pText->m_isWarp)
		pDC->DrawText(pText->m_Text,CRect(point,size2),DT_NOCLIP);
	else
		pDC->DrawText(pText->m_Text,CRect(point,size2),DT_WORDBREAK | DT_NOCLIP);

    pDC->SelectObject(pOldFont);
	font.DeleteObject();
    pDC->SetTextColor(oldColor);
	pDC->SetBkMode(oldMode);//modified 2004-05-18	
}

void CADGraphics::DrawPolyline(CDC* pDC,CADPolyline* pPolyline)
{
	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points;
	if(pPolyline->m_Closed)
		points= new CPoint[pointCount+1];
	else
		points= new CPoint[pointCount];
	CPoint *points1=points;
	for(int j=0;j<pointCount;j++)
	{
		//CADPoint* pPoint;
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(j);
		*points = DocToClient(*pPoint);
		points++;
	}
	if(pPolyline->m_Closed)
	{
		points->x = points1->x;
		points->y = points1->y;
		pDC->Polyline(points1,pointCount+1);
	}
	else
		pDC->Polyline(points1,pointCount);
	delete [] points1;
}

void CADGraphics::DrawSpline(CDC* pDC,CADSpline* pSpline)
{
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	if(FitPtCount==0)return;

	CPoint* points = new CPoint[FitPtCount];
	CPoint* points1 = points;
	int nSame=0;
	for(int j=0;j<FitPtCount;j++)
	{
		/*CADPoint* pPoint;
		pPoint=(CADPoint*)pSpline->m_FitPoint.GetAt(j);*/
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		if(j>0 && *(points-1)==DocToClient(*pPoint))
		{
			nSame++;
			continue;
		}
		*points=DocToClient(*pPoint);
		points++;
	}
	FitPtCount-=nSame;
	if (FitPtCount>1)
	{
		Spline spline(points1, FitPtCount);
		spline.Generate();
		pSpline->m_CurvePoints.RemoveAll();
		pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
		int PointCount = 0;
		spline.GetCurve(pSpline->m_CurvePoints.GetData(), PointCount);
		if(pSpline->m_CurvePoints.GetSize()>1)
			pDC->Polyline(pSpline->m_CurvePoints.GetData(), pSpline->m_CurvePoints.GetSize());
		pSpline->m_CurvePoints.RemoveAll();
	}
	//added on 2007/1/25
	//<--
	if (pSpline->m_bNode)
	{
		CBrush brush;
		LOGBRUSH logBrush;
		logBrush.lbColor = RGB(0,0,0);
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_SOLID;
		brush.CreateBrushIndirect(&logBrush);
		CBrush* pOldBrush=pDC->SelectObject(&brush);
		for(int j=0;j<FitPtCount;j++)
		{
			int radius = DocToClient(pSpline->m_NodeRadius);
			pDC->Ellipse(points1[j].x-radius,points1[j].y-radius,points1[j].x+radius,points1[j].y+radius);
		}
		pDC->SelectObject(pOldBrush);
		brush.DeleteObject();
	}
	//-->
	delete[] points1;
}

void CADGraphics::DrawHatch(CDC* pDC,CADHatch* pHatch)
{
	CADEntity* pEntity;
	CADLayer* pLayer;

	if(pHatch->m_bSolidFill)
	{		
		CBrush brush(GetEntityColor(pHatch));
		CBrush* pOldBrush = pDC->SelectObject(&brush);
		pDC->BeginPath();
		{ 
			for(int i=0;i<pHatch->m_Paths.GetSize();i++)
			{
				pEntity=(CADEntity*)pHatch->m_Paths.GetAt(i);
				pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
				if(pLayer==NULL)continue;
				if(pLayer->m_nColor<0)continue;
				DrawHatchPath(pDC,pEntity);
			}
		}
		pDC->EndPath();
		pDC->FillPath();
		brush.DeleteObject();
		pDC->SelectObject(pOldBrush);
	}

	if(pHatch->m_pPolyline==NULL)return;

//======================================================================================
	int pointCount=pHatch->m_pPolyline->m_Point.GetSize();
	CPoint *pPoints;
	pPoints= new CPoint[pointCount];
	CPoint *points1=pPoints;
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pHatch->m_pPolyline->m_Point.GetAt(j);
		*pPoints = DocToClient(*pPoint);
		pPoints++;
	}
	points1[0].x+=1;
	points1[3].x+=1;
//	points1[1].x+=1;
//	points1[2].x+=1;

	points1[0].y+=1;
	points1[1].y+=1;
//	points1[2].y+=1;
//	points1[3].y+=1;

	CRect rect;
	rect.left=0;
	rect.top=0;
	rect.right=rect.left+(points1[1].x-points1[0].x);
	rect.bottom=rect.top+(points1[3].y-points1[0].y);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
	return;
	//CPen* pOldPen=pDC->SelectObject(&pen);

	char PatternFile[255];
	GetAppDir(PatternFile);
	/*if(m_GraphicsMode==Printing)
		strcat(PatternFile,"Bmp\\");
	else
		strcat(PatternFile,"Bmp\\");*/
	if(m_GraphicsMode==Printing)
		strcat(PatternFile,"Pattern_Print\\");
	else
		strcat(PatternFile,"Pattern\\");
	strcat(PatternFile,pHatch->m_Name);
	strcat(PatternFile,".bmp");

	CBitmap bmp;
	//bmp.LoadBitmap(IDB_RS_SMALL);
	//bmp.LoadBitmap("D:\\LS.bmp");
	HBITMAP hbmp;//Î»Í¼¾ä±ú 
    hbmp= (HBITMAP)::LoadImage( AfxGetInstanceHandle(), 
    PatternFile,IMAGE_BITMAP,0,0,
    LR_LOADFROMFILE);//

	if(!hbmp)return;
	bmp.Attach(hbmp);  
	
	CDC memDC;
	memDC.CreateCompatibleDC(pDC);
    CBitmap    myBitmap,*pOldBitmap;
	myBitmap.CreateCompatibleBitmap(pDC,rect.Width(),rect.Height());
	pOldBitmap = memDC.SelectObject(&myBitmap);

	CPen* pOldPen=memDC.SelectObject(&pen);
	CBrush brush1(&bmp);
	CBrush* pOldBrush = memDC.SelectObject(&brush1);
	
	memDC.Rectangle(&rect);
	//memDC.Polygon(points1,4);
/*	if(m_GraphicsMode==Printing)
		pDC->StretchBlt(points1[0].x,points1[0].y,rect.Width()-1,rect.Height()-1, &memDC,0,0,rect.Width()/3,rect.Height()/3,SRCCOPY);
	else
		pDC->BitBlt(points1[0].x,points1[0].y,rect.Width(),rect.Height(), &memDC,0,0,SRCCOPY);
*/
		pDC->BitBlt(points1[0].x,points1[0].y,rect.Width(),rect.Height(), &memDC,0,0,SRCCOPY);

	delete [] points1;

	memDC.SelectObject(pOldPen);
	memDC.SelectObject(pOldBrush);
	memDC.SelectObject(pOldBitmap);
	myBitmap.DeleteObject();
	pen.DeleteObject(); 
	brush1.DeleteObject();
	bmp.DeleteObject();

/*    HBITMAP hBmp;
    hBmp = HBITMAP(bmp);

	CBrush brush;
	LOGBRUSH m_logbrush2;
	m_logbrush2.lbColor=RGB(0,0,0);
	m_logbrush2.lbHatch = (LONG)hBmp;
	m_logbrush2.lbStyle=BS_PATTERN;*/

	//m_logbrush2.lbHatch = HS_CROSS;
	//m_logbrush2.lbStyle=BS_HATCHED;


//	brush.CreateBrushIndirect(&m_logbrush2);
//	CBrush* pOldBrush=pDC->SelectObject(&brush);

//	pDC->Polygon(points1,4);
//	delete [] points1;

//	pDC->SelectObject(pOldPen);
//	pen.DeleteObject();
//	pDC->SelectObject(pOldBrush);
//	brush.DeleteObject();
	return;
//======================================================================================
/*	CPen pen1;
	if (!pen1.CreatePen(PS_SOLID, 1, GetEntityColor(pHatch)))
		return;
	CPen* pOldPen=pDC->SelectObject(&pen1);*/

	if(pHatch->m_pPolyline->m_Point.GetSize()<4)return;
	CPoint point,point2;
	ADPOINT* pPoint;
	POINT points[4];
	ADPOINT BasePoint;
	ADPOINT adPoints[4];
	for(int i=0;i<pHatch->m_pPolyline->m_Point.GetSize();i++)
	{
		pPoint=(ADPOINT*)pHatch->m_pPolyline->m_Point.GetAt(i);
		point = DocToClient(*pPoint);
		points[i].x=point.x;
		points[i].y=point.y;
		adPoints[i] = *pPoint;
	}
	CRect client;
	pDC->GetClipBox(client);

	CRgn pOldRgn;
	pOldRgn.CreateRectRgn(client.left,client.top,client.right,client.bottom);
//	pDC->SelectClipRgn(pOldRgn);

	CRgn rgn;
	rgn.CreatePolygonRgn(points, 4, WINDING);

	pDC->SelectObject(&rgn);
//	pDC->SelectClipRgn(&rgn);

//	CRect client;
//	pDC->GetClipBox(client);

	CADHatchLine* pHatchLine;
//	CADLine* pLine;
	ADPOINT adPoint;
	int m;
	int distance1=Distance(points[0],points[2]);
	int distance2=Distance(points[1],points[3]);
	int distance3=Distance(points[0],points[1]);
	int distance4=Distance(points[0],points[3]);
	double dx=0;
	double dy=0;
	int dl=0;
	int nDs=0;
	int nDl=0;//distance1pHatch->m_HatchLines.GetSize()
	i=pHatch->m_HatchLines.GetSize();
	for(i=0;i<pHatch->m_HatchLines.GetSize();i++)
	{
		pHatchLine=(CADHatchLine*)pHatch->m_HatchLines.GetAt(i);

		//for(j=0;j<pHatchLine->m_Lines.GetSize();j++)
		//{
			//pLine=(CADLine*)pHatchLine->m_Lines.GetAt(j);
			//adPoint=pLine->pt1;

			double length=0;
			CPen pen;
			CPen* pOldPen;
			if(pHatchLine->m_NumDash>0)
			{
				unsigned long* a=new unsigned long[pHatchLine->m_NumDash];
				for(m=0;m<pHatchLine->m_NumDash;m++)
				{
					if(pHatchLine->m_Items[m]==0)
						a[m]=1;
					else
					{
						a[m]=DocToClient(fabs(pHatchLine->m_Items[m]));
						length+=fabs(pHatchLine->m_Items[m]);
					}
				}
				LOGBRUSH logBrush;
				logBrush.lbColor = GetEntityColor(pHatch);
				logBrush.lbHatch = 0;
				logBrush.lbStyle = BS_SOLID;
				pen.CreatePen(PS_GEOMETRIC|PS_USERSTYLE|PS_ENDCAP_SQUARE,1,&logBrush,pHatchLine->m_NumDash,a);
				pOldPen=pDC->SelectObject(&pen);
			}
			else
			{
				//CPen pen;
				///pen.CreatePen(PS_GEOMETRIC|PS_USERSTYLE|PS_ENDCAP_SQUARE,1,&logBrush);
				if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pHatch)))
					return;
				pOldPen=pDC->SelectObject(&pen);				
			}
			CPoint point1,point2;
			double dd=DocToClient(pHatchLine->m_xOffset);

			double d1,d2,d3;
			double xOffset=fabs(pHatchLine->m_xOffset);
			double yOffset=fabs(pHatchLine->m_yOffset);

			int ds=DocToClient(yOffset);
			if(ds==0)
			{
				pDC->SelectClipRgn(&pOldRgn);
				return;
			}
//----------------------------------------------------------------------------
			if(pHatchLine->m_Angle==0)
			{
				int num=distance4/ds;
				ADPOINT curPoint;
				BasePoint.x=adPoints[0].x+pHatchLine->m_BasePoint.x;
				BasePoint.y=adPoints[0].y+pHatchLine->m_BasePoint.y;
				curPoint=BasePoint;
				//yOffset=yOffset*m_yScale/m_xScale;
				for(int i=0;i<num;i++)
				{
					curPoint.x+=xOffset;
					curPoint.y-=yOffset;
					adPoint=curPoint;
					CPoint pt=DocToClient(BasePoint);
					if(length==0)
					{
							//adPoint.x=BasePoint.x;
							//adPoint.y=BasePoint.y-yOffset*(i+1);
							adPoint.x=adPoints[0].x;
							//adPoint.y=curPoint.y;
					}
					else
					{
						while(adPoints[0].x<adPoint.x)
						{
							adPoint.x=adPoint.x-length;
						}
					}
					point1=DocToClient(adPoint);
					adPoint.x=adPoints[1].x;
					//adPoint.y=adPoints[1].y-yOffset*(i+1);
					point2=DocToClient(adPoint);

					pDC->MoveTo(point1);
					pDC->LineTo(point2);				
				}
				continue;
			}
//---------------------------------------------------------------------
			if(pHatchLine->m_Angle==90)
			{
				int num=distance3/ds;
				ADPOINT curPoint;
				BasePoint.x=adPoints[0].x+pHatchLine->m_BasePoint.x;
				BasePoint.y=adPoints[0].y+pHatchLine->m_BasePoint.y;
				curPoint=BasePoint;
				if(length>0)
				{
					while(adPoints[3].y<curPoint.y)
					{
						curPoint.y=curPoint.y-length;
					}
				}
				//curPoint.y=BasePoint.y-(adPoints[0].y-adPoints[3].y);
				//yOffset=yOffset*m_yScale/m_xScale;
				for(int i=0;i<num;i++)
				{
					curPoint.x+=yOffset;
					curPoint.y+=xOffset;
					adPoint=curPoint;
					CPoint pt=DocToClient(BasePoint);
					if(length==0)
					{
							//adPoint.x=BasePoint.x;
							//adPoint.y=BasePoint.y-yOffset*(i+1);
							adPoint.y=adPoints[3].y;
							//adPoint.y=curPoint.y;
					}
					else
					{
						while(adPoints[3].y<adPoint.y)
						{
							adPoint.y=adPoint.y-length;
						}
					}
					point1=DocToClient(adPoint);
					adPoint.y=adPoints[0].y;
					//adPoint.y=adPoints[1].y-yOffset*(i+1);
					point2=DocToClient(adPoint);

					pDC->MoveTo(point1);
					pDC->LineTo(point2);				
				}
				continue;
			}
			d1=fabs(yOffset/sin(pHatchLine->m_Angle*PI/180));//horizontal
			d2=fabs(yOffset/tan(pHatchLine->m_Angle*PI/180));
			d3=fabs(yOffset/cos(pHatchLine->m_Angle*PI/180));//vertical
			//dx=d1+fabs((xOffset-d2)*cos(pHatchLine->m_Angle*PI/180));
			if(pHatchLine->m_xOffset<0)
				dx=fabs(-d1+(xOffset+d2)*fabs(cos(pHatchLine->m_Angle*PI/180)));		
			else
				dx=fabs(d1+(xOffset-d2)*fabs(cos(pHatchLine->m_Angle*PI/180)));
			//if(xOffset!=d2)
			dy=fabs((xOffset-d2)*sin(pHatchLine->m_Angle*PI/180));
//------------------------------------------------------------------------------
			if(pHatchLine->m_Angle<90)
			{
				//if(dy==0)
				//	dy=pHatchLine->m_yOffset*2*sin(pHatchLine->m_Angle*PI/180);
				int num=distance1/ds;
				ADPOINT curPoint;
				BasePoint.x=adPoints[0].x+pHatchLine->m_BasePoint.x;
				BasePoint.y=adPoints[0].y+pHatchLine->m_BasePoint.y;
				curPoint=BasePoint;
				for(int i=0;i<num;i++)
				{
					curPoint.x+=dx;
					curPoint.y-=dy;
					adPoint=curPoint;
					CPoint pt=DocToClient(BasePoint);
					if(length==0)
					{
						adPoint.x=adPoints[0].x;
						adPoint.y=BasePoint.y-d1*(i+1);
					}
					else
					{
						while(adPoints[0].x<adPoint.x)
						{
							adPoint.x=adPoint.x-length*cos(pHatchLine->m_Angle*PI/180);
							adPoint.y=adPoint.y-length*sin(pHatchLine->m_Angle*PI/180);
						}
					}
					point1=DocToClient(adPoint);
					adPoint.x=BasePoint.x+d1*(i+1);
					adPoint.y=BasePoint.y;
					point2=DocToClient(adPoint);

					pDC->MoveTo(point1);
					pDC->LineTo(point2);				
				}
			}
//-----------------------------------------------------------------------------			
			else if(pHatchLine->m_Angle>90 && pHatchLine->m_Angle<180)
			{
				/*BasePoint.x=adPoints[0].x+pHatchLine->m_BasePoint.x;
				BasePoint.y=adPoints[0].y+pHatchLine->m_BasePoint.y;
				adPoint=BasePoint;
				if(length!=0)
				{
					while(adPoints[1].x>adPoint.x)
					{
						adPoint.x=adPoint.x+fabs(length*cos(pHatchLine->m_Angle*PI/180));
						adPoint.y=adPoint.y-length*sin(pHatchLine->m_Angle*PI/180);
					}
					point1=DocToClient(adPoint);
					//adPoint.x=RightBasePoint.x-d1*(i+1);
					//adPoint.y=RightBasePoint.y;
					point2=DocToClient(BasePoint);

					pDC->MoveTo(point1); 
					pDC->LineTo(point2);	

				}*/

				ADPOINT RightBasePoint;
				RightBasePoint.x=adPoints[0].x+pHatchLine->m_BasePoint.x;
				RightBasePoint.y=adPoints[0].y+pHatchLine->m_BasePoint.y;
				while(RightBasePoint.x<adPoints[1].x)
				{
					RightBasePoint.x+=d1;	
				}

				int num=distance2/ds;
				ADPOINT curPoint;
				curPoint=RightBasePoint;
				for(int i=0;i<num;i++)
				{
					curPoint.x-=dx;
					curPoint.y-=dy;
					adPoint=curPoint;
					if(length==0)
					{
							adPoint.x=RightBasePoint.x;
							adPoint.y=RightBasePoint.y-d1*(i+1);
					}
					else
					{
						while(adPoints[1].x>adPoint.x)
						{
							adPoint.x=adPoint.x+fabs(length*cos(pHatchLine->m_Angle*PI/180));
							adPoint.y=adPoint.y-length*sin(pHatchLine->m_Angle*PI/180);
						}
					}
					point1=DocToClient(adPoint);
					adPoint.x=RightBasePoint.x-d1*(i+1);
					adPoint.y=RightBasePoint.y;
					point2=DocToClient(adPoint);

					pDC->MoveTo(point1); 
					pDC->LineTo(point2);				
				}
			}
		pDC->SelectObject(pOldPen);
		pen.DeleteObject();
	}

	pDC->SelectClipRgn(&pOldRgn);
}

void CADGraphics::DrawArc(CDC* pDC,CADArc* pArc)
{
	double sweepAngle;
	ADPOINT adPtStart;
	adPtStart.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPtStart.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);
	CPoint point1=DocToClient(pArc->ptCenter);
	CPoint ptStart=DocToClient(adPtStart);
	int radius = DocToClient(pArc->m_Radius);
	if(pArc->m_StartAng>pArc->m_EndAng)sweepAngle=360.00-(pArc->m_StartAng-pArc->m_EndAng);
	else sweepAngle=pArc->m_EndAng-pArc->m_StartAng;
	pDC->MoveTo(ptStart);
	pDC->AngleArc(point1.x,point1.y,radius,(float)pArc->m_StartAng,(float)sweepAngle);
}

void CADGraphics::DrawHatchPath(CDC* pDC,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_CIRCLE:
			{
				DrawHatchPath_Circle(pDC,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				ADPOINT point = {0,0};
				DrawHatchPath_LwPolyline(pDC,(CADPolyline*)pEntity,point,1,1,0);
				break;
			}
	}
}

void CADGraphics::DrawHatchPath_Circle(CDC* pDC,CADCircle* pCircle)
{
	CPoint point1=DocToClient(pCircle->ptCenter);
	int radius=DocToClient(pCircle->m_Radius);
	pDC->Ellipse(point1.x-radius,point1.y-radius,point1.x+radius,point1.y+radius);
}

void CADGraphics::DrawHatchPath_LwPolyline(CDC* pDC,CADPolyline* pPolyline)
{
	int pointCount=pPolyline->m_Point.GetSize();

	for(int i=0;i<pointCount;i++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i);
		CPoint point1=DocToClient(*pPoint);
		if(i==0)pDC->MoveTo(point1);
		if(pPolyline->m_pElevation[i]==0)
		{
			pDC->LineTo(point1);
		}
		else
		{
			ADPOINT* pPoint2;
			ADPOINT adPtO;
			ADPOINT adPoint;
			CPoint point2,pointMiddle;
			double distance;
			if(i==pointCount-1)
			{
				pPoint2=(ADPOINT*)pPolyline->m_Point.GetAt(0);
				point2=DocToClient(*pPoint2);
				
				if(pPoint->y>pPoint->y)adPoint = *pPoint;
				else if(pPoint->y<pPoint->y)adPoint = *pPoint2;
				adPtO.x=(pPoint->x+pPoint2->x)/2;
				adPtO.y=(pPoint->y+pPoint2->y)/2;

				distance=Distance(*pPoint,adPtO);
				distance*=fabs(pPolyline->m_pElevation[i]);
				double angle=angleBetween3Pt(adPtO.x,adPtO.y,adPtO.x+100,adPtO.y,adPoint.x,adPoint.y);
				if(pPolyline->m_pElevation[i]>0)
				{
					angle+=90;
				}
				else
				{
					angle-=90;
					if(angle<0)angle+=360;
				}
				adPoint.x=adPtO.x+distance*cos(angle);
				adPoint.y=adPtO.y+distance*sin(angle);
				pointMiddle=DocToClient(adPoint);
			}
			else
			{
				pPoint2=(ADPOINT*)pPolyline->m_Point.GetAt(i+1);
				point2=DocToClient(*pPoint2);

				if(pPoint->y>pPoint->y)adPoint = *pPoint;
				else if(pPoint->y<pPoint->y)adPoint = *pPoint2;
				adPtO.x=(pPoint->x+pPoint2->x)/2;
				adPtO.y=(pPoint->y+pPoint2->y)/2;

				distance=Distance(*pPoint,adPtO);
				distance*=fabs(pPolyline->m_pElevation[i]);
				double angle=angleBetween3Pt(adPtO.x,adPtO.y,adPtO.x+100,adPtO.y,adPoint.x,adPoint.y);
				if(pPolyline->m_pElevation[i]>0)
				{
					angle+=90;
				}
				else
				{
					angle-=90;
					if(angle<0)angle+=360;
				}
				adPoint.x=adPtO.x+distance*cos(angle);
				adPoint.y=adPtO.y+distance*sin(angle);
				pointMiddle=DocToClient(adPoint);
			}
			CPoint ptCenter;
			long radius;
			circle_3pnts(&point1,&point2,&pointMiddle,&ptCenter,&radius);
			CRect rect;
			rect.SetRect(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
			if(IsCounter(point1,point2,pointMiddle))
				pDC->ArcTo(rect,pointMiddle,point1);
			else
				pDC->ArcTo(rect,point1,pointMiddle);
			//pDC->MoveTo(point2);
		}
	}
}

void CADGraphics::DrawHatchPath_LwPolyline(CDC* pDC,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	int pointCount=pPolyline->m_Point.GetSize();
	if (pointCount>1)
	{
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(0);
		CPoint point1=DocToClient(*pPoint);
		pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(1);
		CPoint point2=DocToClient(*pPoint);
		if (fabs(point1.x - point2.x) <5 && fabs(point1.y - point2.y) <5)return;
	}
	for(int i=0;i<pointCount;i++)
	{
		ADPOINT adPt1,adPt2;
		CPoint pt1,pt2,pt3;
		//pt1 one line start;pt2 one line end;
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(i);

		adPt1 = *pPoint;
		adPt1.x *= xScale;
		adPt1.y *= yScale;
		adPt1 = Rotate(BasePoint,adPt1,rotation);

		pt1 = DocToClient(adPt1);
		if(i==0)pDC->MoveTo(pt1);

		CString str;
			//str.Format("%f",pPolyline->m_pElevation[i]); 
			//::AfxMessageBox(str);

		if((pPolyline->m_pElevation[i]-0.0)<0.00001)
		{
			//CString str;
			//str.Format("%f",pPolyline->m_pElevation[i]); 
			//::AfxMessageBox(str);
			if (i==pointCount-1)
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);
			else
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i+1);
			adPt2=*pPoint;
			adPt2.x*=xScale;
			adPt2.y*=yScale;
			adPt2=Rotate(BasePoint,adPt2,rotation);
			pt2=DocToClient(adPt2);
			pDC->LineTo(pt2);
		}
		else
		{
			ADPOINT adPtO;
			ADPOINT adPoint;
			CPoint ptMiddle;
			double distance;
			if(i==pointCount-1)
			{
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);

				adPt2=*pPoint;
				adPt2.x*=xScale;
				adPt2.y*=yScale;
				adPt2=Rotate(BasePoint,adPt2,rotation);
				pt2=DocToClient(adPt2);
				
				if(adPt1.y>adPt2.y)adPoint=adPt1;//y up
				else if(adPt1.y<adPt2.y)adPoint = adPt2;
				adPtO.x=(adPt1.x+adPt2.x)/2;
				adPtO.y=(adPt1.y+adPt2.y)/2;

				distance=Distance(adPt1,adPtO);
				distance*=fabs(pPolyline->m_pElevation[i]);

				double angle;
				//angle=angleBetween3Pt(adPtO.x,adPtO.y,adPoint.x,adPoint.y,adPtO.x+100,adPtO.y);
				angle=angleBetween2Pt(adPt1.x,adPt1.y,adPt2.x,adPt2.y);
				if(pPolyline->m_pElevation[i]>0)
				{
					angle-=90;
				}
				else
				{
					angle+=90;
					//if(angle<0)angle+=360;
				}
				///angle=315;
				adPoint.x=adPtO.x+distance*cos(angle*PI/180);
				adPoint.y=adPtO.y+distance*sin(angle*PI/180);
				ptMiddle=DocToClient(adPoint);
			}
			else
			{
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(i+1);

				adPt2=*pPoint;
				adPt2.x*=xScale;
				adPt2.y*=yScale;
				adPt2=Rotate(BasePoint,adPt2,rotation);
				pt2=DocToClient(adPt2);
				
				if(adPt1.y>adPt2.y)adPoint=adPt1;//y up
				else if(adPt1.y<adPt2.y)adPoint=adPt2;
				adPtO.x=(adPt1.x+adPt2.x)/2;
				adPtO.y=(adPt1.y+adPt2.y)/2;

				distance=Distance(adPt1,adPtO);
				distance=distance*fabs(pPolyline->m_pElevation[i]);

				//double radian;
				double angle;
				/*angle=angleBetween3Pt(adPtO.x,adPtO.y,adPoint.x,adPoint.y,adPtO.x+100,adPtO.y);
				if(pPolyline->m_pElevation[i]>0)
				{
					angle+=90;
				}
				else
				{
					angle-=90;
					if(angle<0)angle+=360;
				}*/
				///angle=135-90;
				angle=angleBetween2Pt(adPt1.x,adPt1.y,adPt2.x,adPt2.y);
				if(pPolyline->m_pElevation[i]>0)
				{
					angle-=90;
				}
				else
				{
					angle+=90;
					//if(angle<0)angle+=360;
				}

				adPoint.x=adPtO.x+distance*cos(angle*PI/180);
				adPoint.y=adPtO.y+distance*sin(angle*PI/180);
				ptMiddle=DocToClient(adPoint);
			}
			CPoint ptCenter;
			long radius;
			circle_3pnts(&pt1,&ptMiddle,&pt2,&ptCenter,&radius);
			CRect rect;
			rect.SetRect(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
			if(IsCounter(pt1,ptMiddle,pt2))
				pDC->ArcTo(rect,pt2,pt1);
			else
				pDC->ArcTo(rect,pt1,pt2);
		}
	}
}

void CADGraphics::DrawCircle(CDC* pDC,CADCircle* pCircle)
{
	CBrush brush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	brush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush=pDC->SelectObject(&brush);

	//ADPOINT adPoint;
	//adPoint=pCircle->ptCenter;

	CPoint point1 = DocToClient(pCircle->ptCenter);
	int radius = DocToClient(pCircle->m_Radius);
	pDC->Ellipse(point1.x-radius,point1.y-radius,point1.x+radius,point1.y+radius);
	pDC->SelectObject(pOldBrush);
	brush.DeleteObject();
}

void CADGraphics::DrawSolid(CDC* pDC,CADSolid* pSolid)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pSolid->m_nLayer);
//	if(pLayer->m_nColor<0)return;

	CPen pen;
	if (!pen.CreatePen(PS_NULL, 1, RGB(0,0,0)))
	return;
	CBrush brush;
	if(pSolid->m_nColor<0)
	{
		brush.CreateSolidBrush(GetColor(pLayer->m_nColor)); 
	}
	else
	{
		brush.CreateSolidBrush(GetColor(pSolid->m_nColor));
	}
	CPen* pOldPen=pDC->SelectObject(&pen);
	CBrush* pOldBrush=pDC->SelectObject(&brush);

	CPoint* points= new CPoint[4];
	CPoint* points1=points;

	*points=DocToClient(pSolid->m_pt0);
	points++;
	*points=DocToClient(pSolid->m_pt1);
	points++;
	*points=DocToClient(pSolid->m_pt3);
	points++;
	*points=DocToClient(pSolid->m_pt2);

	pDC->Polygon(points1,4);
	delete [] points1;

	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
	pen.DeleteObject();
	brush.DeleteObject(); 
}

void CADGraphics::DrawInsert_Hatch(CDC* pDC,CADHatch* pHatch,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	if(pHatch->m_bSolidFill)
	{
		//CPen* pOldPen=pDC->GetCurrentPen();
		CBrush brush(GetEntityColor(pHatch));
		CBrush* pOldBrush = pDC->SelectObject(&brush);
		pDC->BeginPath();
		{ 
			for(int i=0;i<pHatch->m_Paths.GetSize();i++)
			{
				CADEntity* pEntity=(CADEntity*)pHatch->m_Paths.GetAt(i);
				//pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
				//if(pLayer->m_nColor<0)continue;
				DrawInsert_HatchPath(pDC,pEntity,BasePoint,xScale,yScale,rotation);
			}
		}
		pDC->EndPath();
		pDC->FillPath();
		pDC->SelectObject(pOldBrush);
		//pDC->SelectObject(pOldPen);
	}
}

void CADGraphics::DrawInsert_HatchPath(CDC* pDC,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POLYLINE:
			{
				DrawHatchPath_LwPolyline(pDC,(CADPolyline*)pEntity,BasePoint,xScale,yScale,rotation);
				break;
			}
	}
}

void CADGraphics::DrawInsert_Insert(CDC* pDC,CADInsert* pInsert,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;

	ADPOINT BasePoint2=BasePoint;
	BasePoint2.x+=pInsert->pt.x;
	BasePoint2.y+=pInsert->pt.y;

	double xScale2=pInsert->m_xScale*xScale;
	double yScale2=pInsert->m_yScale*yScale;
	double Rotation2=pInsert->m_Rotation; 

	CADBlock* pBlock = (CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x += pBlock->m_BasePoint.x;
	BasePoint.y += pBlock->m_BasePoint.y;

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
		if(!m_isDrawMText && pEntity->GetType()==AD_ENT_MTEXT)continue;
		DrawInsert(pDC,pEntity,BasePoint2,xScale2,yScale2,Rotation2);	
	}
}

void CADGraphics::DrawInsert_Circle(CDC* pDC,CADCircle* pCircle,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pCircle->m_nLayer);
	if(pLayer == NULL)return;
	if(pLayer->m_nColor<0)return;

	short penWidth=1;
	penWidth=GetLineWidth(pCircle);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, penWidth, GetColor(pLayer->m_nColor)))
	return;
	CPen* pOldPen=pDC->SelectObject(&pen);

	CBrush brush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	brush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush = pDC->SelectObject(&brush);

	ADPOINT adPoint = pCircle->ptCenter;
	adPoint.x += BasePoint.x; 
	adPoint.y += BasePoint.y;

	CPoint point1=DocToClient(adPoint);
	int radius1=DocToClient(pCircle->m_Radius*xScale);
	int radius2=DocToClient(pCircle->m_Radius*yScale);
	pDC->Ellipse(point1.x-radius1,point1.y-radius2,point1.x+radius1,point1.y+radius2);
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
	pDC->SelectObject(pOldBrush);
}

void CADGraphics::DrawInsert_Line(CDC* pDC,CADLine* pLine,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pLine->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	short penWidth=1;
	penWidth=GetLineWidth(pLine);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, penWidth, GetColor(pLayer->m_nColor)))
	return;
	CPen* pOldPen=pDC->SelectObject(&pen);

	CPoint point1,point2;
	ADPOINT adPoint;
	adPoint=pLine->pt1;
	adPoint.x*=xScale;
	adPoint.y*=yScale;
	adPoint=Rotate(BasePoint,adPoint,rotation);
	point1=DocToClient(adPoint);
	adPoint=pLine->pt2;
	adPoint.x*=xScale;
	adPoint.y*=yScale;
	adPoint=Rotate(BasePoint,adPoint,rotation);
	point2=DocToClient(adPoint);
	pDC->MoveTo(point1);
	pDC->LineTo(point2);

	pDC->SelectObject(pOldPen);
	pen.DeleteObject(); 
}

void CADGraphics::DrawInsert_MText(CDC* pDC,CADMText* pMText,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pMText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	int oldMode=pDC->SetBkMode(TRANSPARENT);
	pDC->SetBkMode(TRANSPARENT);
	COLORREF oldColor;
	if(pMText->m_nColor<0)
		oldColor=pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		oldColor=pDC->SetTextColor(GetColor(pMText->m_nColor));

	CPoint point,point2;
	ADPOINT adPoint;
	adPoint = pMText->m_Location;
	adPoint.x *= xScale;
	adPoint.y *= yScale;
	ADPOINT ox = {0,0};
	adPoint = Rotate2(ox,adPoint,rotation);
	adPoint.x += BasePoint.x; 
	adPoint.y += BasePoint.y;

	point=DocToClient(adPoint);

	double angle;
	angle = -atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	angle = rotation;

	ADSIZE adSize = {0,pMText->m_Height*yScale};
	CSize size=DocToClient(adSize);
	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	font.CreateFont(fontHeight, 0, 
			(int)(angle*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x800 | FF_SWISS, pMText->m_Font);
	CFont* pOldFont=pDC->SelectObject(&font);
	CSize size3 = pDC->GetTextExtent("a",1);
	char align=pMText->m_Align;
	switch(align)
	{
		case AD_MTEXT_ATTACH_TOPLEFT:
			pDC->SetTextAlign(TA_TOP | TA_LEFT);
			break;
		case AD_MTEXT_ATTACH_TOPCENTER:
			pDC->SetTextAlign(TA_TOP | TA_CENTER);
			break;
		case AD_MTEXT_ATTACH_TOPRIGHT:
			pDC->SetTextAlign(TA_TOP | TA_RIGHT); 
			break;
		case AD_MTEXT_ATTACH_MIDDLELEFT:
			pDC->SetTextAlign(TA_LEFT);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLECENTER:
			pDC->SetTextAlign(TA_CENTER);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLERIGHT:
			pDC->SetTextAlign(TA_RIGHT); 
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_BOTTOMLEFT:
			pDC->SetTextAlign(TA_BOTTOM | TA_LEFT); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMCENTER:
			pDC->SetTextAlign(TA_BOTTOM | TA_CENTER); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMRIGHT:
			pDC->SetTextAlign(TA_BOTTOM | TA_RIGHT); 
			break;
	}

	pDC->TextOut(point.x,point.y,pMText->m_Text);
	pDC->SetBkMode(oldMode);
    pDC->SelectObject(pOldFont);
	font.DeleteObject();
}

void CADGraphics::DrawInsert_Text(CDC* pDC,CADText* pText,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	pDC->SetBkMode(TRANSPARENT);
	if(pText->m_nColor<0)
		pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		pDC->SetTextColor(GetColor(pText->m_nColor));

	ADPOINT adPoint;
	adPoint=pText->m_Location;
	//adPoint.y*=yScale;
	//adPoint=Rotate(BasePoint,adPoint,rotation);
	adPoint.x+=BasePoint.x; 
	adPoint.y+=BasePoint.y;

	CPoint point;
	point=DocToClient(adPoint);

	int index=IndexOfStyles(pText->m_StyleName);
	if(index==-1)return;

	CADStyle* pStyle=(CADStyle*)m_Styles.GetAt(index);
	ADSIZE adSize;
	adSize.cx=0;
	adSize.cy=pText->m_Height*yScale+1;
	CSize size;
	size=DocToClient(adSize);

	pDC->SetTextAlign(TA_BASELINE | TA_LEFT); 
	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	font.CreateFont(fontHeight, 0, 
			(int)(pText->m_Angle*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x04 | FF_DONTCARE, pStyle->m_Font);
	pDC->SetTextAlign(TA_BASELINE);
	CFont* pOldFont=pDC->SelectObject(&font);
	pDC->TextOut(point.x,point.y,pText->m_Text);
    pDC->SelectObject(pOldFont);
	font.DeleteObject();
}

void CADGraphics::DrawInsert_Polyline(CDC* pDC,CADPolyline* pPolyline,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pPolyline->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	short penWidth=1;
	penWidth=GetLineWidth(pPolyline);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, penWidth, GetColor(pLayer->m_nColor)))
	return;
	CPen* pOldPen=pDC->SelectObject(&pen);

	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points;
	if(pPolyline->m_Closed)
		points= new CPoint[pointCount+1];
	else
		points= new CPoint[pointCount];
	CPoint *points1=points;
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		ADPOINT adPoint;
		adPoint = *pPoint;
		adPoint.x*=xScale;
		adPoint.y*=yScale;
		adPoint=Rotate(BasePoint,adPoint,rotation);
		*points=DocToClient(adPoint);
		points++;
	}
	if(pPolyline->m_Closed)
	{
		points->x =points1->x;
		points->y =points1->y;
		pDC->Polyline(points1,pointCount+1);
	}
	else
		pDC->Polyline(points1,pointCount);
	delete [] points1;

	pDC->SelectObject(pOldPen);
	pen.DeleteObject(); 
}

void CADGraphics::DrawInsert_Spline(CDC* pDC,CADSpline* pSpline,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	if(FitPtCount==0)return;
	
	CPoint* points = new CPoint[FitPtCount];
	CPoint* points1 = points;
	int nSame=0;
	for(int j=0;j<FitPtCount;j++)
	{//::AfxMessageBox("dddeee");
		/*CADPoint* pPoint;
		pPoint=(CADPoint*)pSpline->m_FitPoint.GetAt(j);*/
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		if(j>0 && *(points-1)==DocToClient(*pPoint))
		{
			nSame++;
			continue;
		}

		ADPOINT adPoint;
		adPoint = *pPoint;
		adPoint.x*=xScale;
		adPoint.y*=yScale;
		adPoint=Rotate(BasePoint,adPoint,rotation);

		//*points=DocToClient(*pPoint);
		*points=DocToClient(adPoint);
		points++;
	}
	FitPtCount-=nSame;
	if(FitPtCount>1)
	{
		Spline spline(points1, FitPtCount);
		spline.Generate();
		pSpline->m_CurvePoints.RemoveAll();
		pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
		int PointCount = 0;
		spline.GetCurve(pSpline->m_CurvePoints.GetData(), PointCount);
		if(pSpline->m_CurvePoints.GetSize()>1)
			pDC->Polyline(pSpline->m_CurvePoints.GetData(), pSpline->m_CurvePoints.GetSize());
		pSpline->m_CurvePoints.RemoveAll();
	}
	delete[] points1;
}

void CADGraphics::DrawInsert(CDC* pDC,CADInsert* pInsert)
{
	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;

	ADPOINT BasePoint=pInsert->pt;
	double xScale=pInsert->m_xScale;
	double yScale=pInsert->m_yScale;
	double Rotation=pInsert->m_Rotation; 

	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x+=pBlock->m_BasePoint.x;
	BasePoint.y+=pBlock->m_BasePoint.y;

/*	short penWidth=1;
	penWidth=GetLineWidth(pInsert);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID,penWidth, GetEntityColor(pInsert)))
		return;
	pDC->SelectObject(&pen);*/

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
		if(!m_isDrawMText && pEntity->GetType()==AD_ENT_MTEXT)continue;
		/*short penWidth=1;
		penWidth=GetLineWidth(pEntity);
		CADLayer* pLayer;
		pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if(pLayer==NULL)return;
		if(pLayer->m_nColor<0)return;
		CPen pen;
		if (!pen.CreatePen(PS_SOLID,penWidth, pLayer->m_nColor))
			return;
		pDC->SelectObject(&pen);*/
		DrawInsert(pDC,pEntity,BasePoint,xScale,yScale,Rotation);	
	}
}

void CADGraphics::DrawInsert(CDC* pDC,CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale,double rotation)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_LINE:
			{			
				DrawInsert_Line(pDC,(CADLine*)pEntity,BasePoint,xScale,yScale,rotation);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				DrawInsert_Circle(pDC,(CADCircle*)pEntity,BasePoint,xScale,yScale,rotation);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				DrawInsert_Polyline(pDC,(CADPolyline*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
		case AD_ENT_SPLINE:
			{
				DrawInsert_Spline(pDC,(CADSpline*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
		case AD_ENT_MTEXT:
			{
				DrawInsert_MText(pDC,(CADMText*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
		case AD_ENT_TEXT:
			{
				//DrawInsert_Text(pDC,(CADText*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
		case AD_ENT_HATCH:
			{
				DrawInsert_Hatch(pDC,(CADHatch*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
		case AD_ENT_INSERT:
			{
				DrawInsert_Insert(pDC,(CADInsert*)pEntity,BasePoint,xScale,yScale,rotation);
				break;				
			}
	}
}

void CADGraphics::DrawSeletedHandle(CDC* pDC)
{
	
}

void CADGraphics::CalZoomRate()
{
	if(m_Bound.GetHeight()==0 || m_Bound.GetWidth()==0)return;
	/*double HRate = (double)size.cy/m_Bound.GetHeight();
	double WRate = (double)size.cy/m_Bound.GetWidth();*/
	if(m_GraphicsMode==Layout)
	{
		/*if(m_PaperOrient==HORIZONTAL)
			m_ZoomRate = 800/m_Bound.GetWidth();
		else
			m_ZoomRate = 500/m_Bound.GetHeight();*/
		if (m_PaperOrient==HORIZONTAL)
		{
			m_ZoomRate = (double)(m_pDisplay->GetWidth()-200)/m_Bound.GetWidth();
		}
		else
			m_ZoomRate = (double)(m_pDisplay->GetHeight()-200)/m_Bound.GetHeight();
	}
	else
	{
		double HRate = (double)m_pDisplay->GetHeight()/m_Bound.GetHeight();
		double WRate = (double)m_pDisplay->GetWidth()/m_Bound.GetWidth();
		if (WRate<HRate)
			m_ZoomRate = WRate;
		else
			m_ZoomRate = HRate;
	}
}

void CADGraphics::Circle(CDC* pDC,const CPoint ptCenter,const CPoint point2)
{
	int radius=Distance(ptCenter,point2);
	pDC->Ellipse(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
}

void CADGraphics::Circle(CDC* pDC,const CPoint ptCenter,int radius)
{
	pDC->Ellipse(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
}

int CADGraphics::Distance(CPoint point1,CPoint point2)
{
	return (int)(sqrt((point1.x-point2.x)*(point1.x-point2.x)+(point1.y-point2.y)*(point1.y-point2.y)));	
}

double CADGraphics::Distance(ADPOINT point1,ADPOINT point2)
{
	return sqrt((point1.x-point2.x)*(point1.x-point2.x)+(point1.y-point2.y)*(point1.y-point2.y));	
}

void CADGraphics::MoveEntities(CDC* pDC,const CSize& size)
{//   R2_XORPEN
	if(size.cx==0 && size.cy==0)return;
	int oldDrawMode;
	if(m_GraphicsMode==Layout)
		oldDrawMode = pDC->SetROP2(R2_NOTXORPEN);
	else
		oldDrawMode = pDC->SetROP2(R2_XORPEN);
	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		MoveEntities(pDC,pEntity,size);
	}
	pDC->SetROP2(oldDrawMode);
}

void CADGraphics::MoveEntities(CDC* pDC,CADEntity* pEntity,const CSize& size)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				MoveEntity_Point(pDC,(CADPoint*)pEntity,size);
				break;
			}
		case AD_ENT_LINE:
			{
				MoveEntity_Line(pDC,(CADLine*)pEntity,size);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				MoveEntity_Circle(pDC,(CADCircle*)pEntity,size);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				MoveEntity_Polyline(pDC,(CADPolyline*)pEntity,size);
				break;
			}
		case AD_ENT_INSERT:
			{
				MoveEntity_Insert(pDC,(CADInsert*)pEntity,size);
				break;
			}
		case AD_ENT_ARC:
			{
				MoveEntity_Arc(pDC,(CADArc*)pEntity,size);
				break;
			}
		case AD_ENT_SPLINE:
			{
				MoveEntity_Spline(pDC,(CADSpline*)pEntity,size);
				break;
			}
		case AD_ENT_MTEXT:
			{
				MoveEntity_MText(pDC,(CADMText*)pEntity,size);
				break;
			}
		case AD_ENT_SOLID:
			{
				MoveEntity_Solid(pDC,(CADSolid*)pEntity,size);
				break;
			}
	}
}

void CADGraphics::MoveEntity_Arc(CDC* pDC,CADArc* pArc,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pArc)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);

	ADPOINT adPtStart;
	adPtStart.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPtStart.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);

	CPoint point1=DocToClient(pArc->ptCenter) + size;
	CPoint ptStart=DocToClient(adPtStart) + size;

	double sweepAngle;
	int radius=DocToClient(pArc->m_Radius);
	if(pArc->m_StartAng>pArc->m_EndAng)sweepAngle=360.00-(pArc->m_StartAng-pArc->m_EndAng);
	else sweepAngle=pArc->m_EndAng-pArc->m_StartAng;
	pDC->MoveTo(ptStart); 
	pDC->AngleArc(point1.x,point1.y,radius,(float)pArc->m_StartAng,(float)sweepAngle);

	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveEntity_Line(CDC* pDC,CADLine* pLine,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pLine)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);

	CPoint point1,point2;
	point1=DocToClient(pLine->pt1);
	point2=DocToClient(pLine->pt2);
	point1.x+=size.cx;
	point1.y+=size.cy;
	point2.x+=size.cx;
	point2.y+=size.cy;

	pDC->MoveTo(point1);
	pDC->LineTo(point2);
	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveEntity_Point(CDC* pDC,CADPoint* pPoint,const CSize& size)
{

}

void CADGraphics::MoveEntity_Polyline(CDC* pDC,CADPolyline* pPolyline,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pPolyline)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);

	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points;
	if(pPolyline->m_Closed)
		points= new CPoint[pointCount+1];
	else
		points= new CPoint[pointCount];
	CPoint *points1=points;
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(j);
		*points=DocToClient(*pPoint);
		points->x+=size.cx;
		points->y+=size.cy;
		points++;
	}
	if(pPolyline->m_Closed)
	{
		points->x =points1->x;
		points->y =points1->y;
		pDC->Polyline(points1,pointCount+1);
	}
	else
		pDC->Polyline(points1,pointCount);
	delete [] points1;
	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveEntity_Spline(CDC* pDC,CADSpline* pSpline,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pSpline)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);

	int FitPtCount=pSpline->m_FitPoint.GetSize();
	if(FitPtCount==0)return;
	CPoint *points;
	points= new CPoint[FitPtCount];
	CPoint *points1=points;

	for(int j=0;j<FitPtCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		*points=DocToClient(*pPoint);
		points++;
	}
	Spline spline(points1, FitPtCount);
	spline.Generate();
	pSpline->m_CurvePoints.RemoveAll();
	pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
	int PointCount = 0;
	spline.GetCurve(pSpline->m_CurvePoints.GetData(), PointCount);
	for(j=0;j<PointCount;j++)
	{		
		pSpline->m_CurvePoints[j].x += size.cx;
		pSpline->m_CurvePoints[j].y += size.cy;
	}
	if(pSpline->m_CurvePoints.GetSize()>1)
		pDC->Polyline(pSpline->m_CurvePoints.GetData(), PointCount);
	delete [] points1;
	pSpline->m_CurvePoints.RemoveAll();
	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveEntity_MText(CDC* pDC,CADMText* pMText,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pMText)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	CRect rect=GetMTextRect(pMText);
	rect+=size;
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	pointOrigin+=size;
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;

	int pointCount=5;
	CPoint *points;
	points= new CPoint[pointCount];
	points[0].x=rect.left;
	points[0].y=rect.top;
	points[0]=Rotate(pointOrigin,points[0],angle);
	points[1].x=rect.right;
	points[1].y=rect.top;
	points[1]=Rotate(pointOrigin,points[1],angle);
	points[2].x=rect.right;
	points[2].y=rect.bottom;
	points[2]=Rotate(pointOrigin,points[2],angle);
	points[3].x=rect.left;
	points[3].y=rect.bottom;
	points[3]=Rotate(pointOrigin,points[3],angle);
	points[4].x=rect.left;
	points[4].y=rect.top;
	points[4]=Rotate(pointOrigin,points[4],angle);
	pDC->Polyline(points,pointCount);
	delete [] points;
	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveEntity_Text(CDC* pDC,CADText* pText,const CSize& size)
{

}

void CADGraphics::MoveEntity_Solid(CDC* pDC,CADSolid* pSolid,const CSize& size)
{
	CPen pen;
	CBrush brush;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pSolid)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	brush.CreateSolidBrush(GetEntityColor(pSolid));
	CBrush* pOldBrush = pDC->SelectObject(&brush);

	CPoint* points= new CPoint[4];
	points[0]=DocToClient(pSolid->m_pt0);
	points[0].x+=size.cx;
	points[0].y+=size.cy;
	points[1]=DocToClient(pSolid->m_pt1);
	points[1].x+=size.cx;
	points[1].y+=size.cy;
	points[2]=DocToClient(pSolid->m_pt3);
	points[2].x+=size.cx;
	points[2].y+=size.cy;
	points[3]=DocToClient(pSolid->m_pt2);
	points[3].x+=size.cx;
	points[3].y+=size.cy;

	pDC->Polygon(points,4);
	delete [] points;
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
}

void CADGraphics::MoveEntity_Circle(CDC* pDC,CADCircle* pCircle,const CSize& size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, RGB(255,255,255)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	CBrush NullBrush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	NullBrush.CreateBrushIndirect(&logBrush);
	CBrush* pOldBrush = pDC->SelectObject(&NullBrush);

	CPoint point1=DocToClient(pCircle->ptCenter);
	point1.x+=size.cx;
	point1.y+=size.cy;
	Circle(pDC,point1,DocToClient(pCircle->m_Radius));
	pDC->SelectObject(pOldPen);
	pDC->SelectObject(pOldBrush);
}

void CADGraphics::MoveEntity_Insert(CDC* pDC,CADInsert* pInsert,const CSize& size)
{
	if(size.cx==0 && size.cy==0)return;
	if(m_ZoomRate == 0)return;

	ADSIZE adsize=ClientToDoc(size);
	if(adsize.cx==0 && adsize.cy==0)return;

	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;

	ADPOINT BasePoint=pInsert->pt;
	double xScale=pInsert->m_xScale;
	double yScale=pInsert->m_yScale;
	double Rotation=pInsert->m_Rotation;

	CADBlock* pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x+=pBlock->m_BasePoint.x;
	BasePoint.y+=pBlock->m_BasePoint.y;
	BasePoint.x+=adsize.cx;
	BasePoint.y-=adsize.cy;

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity = (CADEntity*)pBlock->m_Entities.GetAt(j);
		if (pEntity->GetType() == AD_ENT_MTEXT)continue;
		DrawInsert(pDC,pEntity,BasePoint,xScale,yScale,Rotation);		
	}
}

void CADGraphics::MoveEntitiesTo(const CSize& size)
{
	if(size.cx == 0 && size.cy == 0)return;
	ADSIZE adSize=ClientToDoc(size);
	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		MoveEntitiesTo(pEntity,adSize.cx,adSize.cy);
	}
}

void CADGraphics::MoveEntitiesTo(CADEntity* pEntity,double dx,double dy)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				MoveEntityTo_Point((CADPoint*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_LINE:
			{
				MoveEntityTo_Line((CADLine*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				MoveEntityTo_Circle((CADCircle*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				MoveEntityTo_Polyline((CADPolyline*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_INSERT:
			{
				MoveEntityTo_Insert((CADInsert*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_ARC:
			{
				MoveEntityTo_Arc((CADArc*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_SPLINE:
			{
				MoveEntityTo_Spline((CADSpline*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_MTEXT:
			{
				MoveEntityTo_MText((CADMText*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_SOLID:
			{
				MoveEntityTo_Solid((CADSolid*)pEntity,dx,dy);
				break;
			}
	}
}

void CADGraphics::MoveEntityTo_Arc(CADArc* pArc,double dx,double dy)
{
	pArc->ptCenter.x += dx;
	pArc->ptCenter.y -= dy;
}

void CADGraphics::MoveEntityTo_Line(CADLine* pLine,double dx,double dy)
{
	pLine->pt1.x+=dx;
	pLine->pt1.y-=dy;
	pLine->pt2.x+=dx;
	pLine->pt2.y-=dy;
}

void CADGraphics::MoveEntityTo_Point(CADPoint* pPoint,double dx,double dy)
{
	pPoint->pt.x+=dx;
	pPoint->pt.y-=dy;
}

void CADGraphics::MoveEntityTo_Polyline(CADPolyline* pPolyline,double dx,double dy)
{
	int pointCount=pPolyline->m_Point.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);
		pPoint->x+=dx;
		pPoint->y-=dy;
	}
}

void CADGraphics::MoveEntityTo_Spline(CADSpline* pSpline,double dx,double dy)
{
	int pointCount=pSpline->m_FitPoint.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		pPoint->x += dx;
		pPoint->y -= dy;
	}
}

void CADGraphics::MoveEntityTo_MText(CADMText* pText,double dx,double dy)
{
	if(m_bHaveSnap)
	{
		pText->m_Location = m_curSnapP;		
	}else
	{
		pText->m_Location.x += dx;
		pText->m_Location.y -= dy;		
	}
}

void CADGraphics::MoveEntityTo_Text(CADText* pText,double dx,double dy)
{

}

void CADGraphics::MoveEntityTo_Solid(CADSolid* pSolid,double dx,double dy)
{
	pSolid->m_pt0.x += dx;
	pSolid->m_pt0.y -= dy;
	pSolid->m_pt1.x += dx;
	pSolid->m_pt1.y -= dy;
	pSolid->m_pt2.x += dx;
	pSolid->m_pt2.y -= dy;
	pSolid->m_pt3.x += dx;
	pSolid->m_pt3.y -= dy;
}

void CADGraphics::MoveEntityTo_Circle(CADCircle* pCircle,double dx,double dy)
{
	pCircle->ptCenter.x+=dx;
	pCircle->ptCenter.y-=dy;
}

void CADGraphics::MoveEntityTo_Insert(CADInsert* pInsert,double dx,double dy)
{
	//int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	//if(blockIndex==-1)return;
	pInsert->pt.x+=dx;
	pInsert->pt.y-=dy;
}

void CADGraphics::RotateEntities(CDC* pDC,CPoint BasePoint,CPoint point)
{
	CSize size;
	size.cx=point.x-BasePoint.x;
	size.cy=point.y-BasePoint.y;
	if(size.cx==0 && size.cy==0)return;
	int oldDrawMode;
	if(m_GraphicsMode==Layout)
		oldDrawMode = pDC->SetROP2(R2_NOTXORPEN);
	else
		oldDrawMode = pDC->SetROP2(R2_XORPEN);

	double angle=atan2(size.cy,size.cx)*180/PI;

	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		RotateEntities(pDC,pEntity,BasePoint,angle);
	}
	pDC->SetROP2(oldDrawMode);
}

void CADGraphics::RotateEntities(CDC* pDC,CADEntity* pEntity,CPoint BasePoint,double Rotation)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_LINE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;			
				RotateEntity_Line(pDC,(CADLine*)pEntity,BasePoint,Rotation);
				pDC->SelectObject(m_pOldPen); 
				if(m_pPen!=NULL)m_pPen->DeleteObject();
				break;
			}
		case AD_ENT_POINT:
			{
				RotateEntity_Point(pDC,(CADPoint*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				RotateEntity_Circle(pDC,(CADCircle*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				if(!CreatePenStyle(pDC,pEntity))return;
				RotateEntity_Polyline(pDC,(CADPolyline*)pEntity,BasePoint,Rotation);
				pDC->SelectObject(m_pOldPen);
				if(m_pPen!=NULL)m_pPen->DeleteObject();				
				break;
			}
		case AD_ENT_INSERT:
			{
				RotateEntity_Insert(pDC,(CADInsert*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_ARC:
			{
				RotateEntity_Arc(pDC,(CADArc*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_SPLINE:
			{
				RotateEntity_Spline(pDC,(CADSpline*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_MTEXT:
			{
				RotateEntity_MText(pDC,(CADMText*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_TEXT:
			{
				RotateEntity_Text(pDC,(CADText*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_SOLID:
			{
				RotateEntity_Solid(pDC,(CADSolid*)pEntity,BasePoint,Rotation);
				break;
			}
	}
}

void CADGraphics::RotateEntity_Line(CDC* pDC,CADLine* pLine,CPoint BasePoint,double Rotation)
{
/*	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pLine)))
		return;
	pDC->SelectObject(&pen);*/

	pDC->MoveTo(Rotate(BasePoint,DocToClient(pLine->pt1),Rotation));
	pDC->LineTo(Rotate(BasePoint,DocToClient(pLine->pt2),Rotation));
}

void CADGraphics::RotateEntity_Arc(CDC* pDC,CADArc* pArc,CPoint BasePoint,double Rotation)
{
	ADPOINT adPtStart;
	adPtStart.x = pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPtStart.y = pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);

	CPoint point1 = Rotate(BasePoint,DocToClient(pArc->ptCenter),Rotation);
	CPoint ptStart = Rotate(BasePoint,DocToClient(adPtStart),Rotation);

	double sweepAngle;
	int radius=DocToClient(pArc->m_Radius);
	if(pArc->m_StartAng>pArc->m_EndAng)sweepAngle=360.00-(pArc->m_StartAng-pArc->m_EndAng);
	else sweepAngle=pArc->m_EndAng-pArc->m_StartAng;

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pArc)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	pDC->MoveTo(ptStart); 
	pDC->AngleArc(point1.x,point1.y,radius,(float)(pArc->m_StartAng-Rotation),(float)sweepAngle);
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
}

void CADGraphics::RotateEntity_Point(CDC* pDC,CADPoint* pPoint,CPoint BasePoint,double Rotation)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pPoint)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	CPoint point1 = Rotate(BasePoint,DocToClient(pPoint->pt),Rotation);
	pDC->SetPixel(point1,GetEntityColor(pPoint));
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
}

void CADGraphics::RotateEntity_Polyline(CDC* pDC,CADPolyline* pPolyline,CPoint BasePoint,double Rotation)
{
/*	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pPolyline)))
		return;
	pDC->SelectObject(&pen);*/

	int pointCount=pPolyline->m_Point.GetSize();
	CPoint *points;
	if(pPolyline->m_Closed)
		points= new CPoint[pointCount+1];
	else
		points= new CPoint[pointCount];

	CPoint *points1 = points;
	for(int j=0;j<pointCount;j++)
	{
		*points = DocToClient(*(ADPOINT*)pPolyline->m_Point.GetAt(j));
		*points = Rotate(BasePoint,*points,Rotation);
		points++;
	}
	if(pPolyline->m_Closed)
	{
		points->x = points1->x;
		points->y = points1->y;
		pDC->Polyline(points1,pointCount+1);
	}
	else
		pDC->Polyline(points1,pointCount);
	delete [] points1;
}

void CADGraphics::RotateEntity_Spline(CDC* pDC,CADSpline* pSpline,CPoint BasePoint,double Rotation)
{
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	if (FitPtCount==0)return;
	CPoint* points = new CPoint[FitPtCount];
	CPoint* points1 = points;

	for(int j=0;j<FitPtCount;j++)
	{
		*points=DocToClient(*(ADPOINT*)pSpline->m_FitPoint.GetAt(j));
		points++;
	}
	Spline spline(points1, FitPtCount);
	spline.Generate();
	pSpline->m_CurvePoints.RemoveAll();
	pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
	int pointCount = 0;
	spline.GetCurve(pSpline->m_CurvePoints.GetData(), pointCount);
	delete [] points1;

	points = new CPoint[pointCount];
	points1 = points;
	for(j=0;j<pointCount;j++)
	{
		points->x=pSpline->m_CurvePoints[j].x;
		points->y=pSpline->m_CurvePoints[j].y;
		*points=Rotate(BasePoint,*points,Rotation);
		points++;
	}
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pSpline)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	if(pSpline->m_CurvePoints.GetSize()>1)
		pDC->Polyline(points1, pointCount);
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
	delete [] points1;
}

void CADGraphics::RotateEntity_MText(CDC* pDC,CADMText* pMText,CPoint BasePoint,double Rotation)
{
	CPoint point1,point2,point3,pointMove;
	CRect rect=GetMTextRect(pMText);

	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;

	const short pointCount=5;
	CPoint* points = new CPoint[pointCount];
	points[0].x=rect.left;
	points[0].y=rect.top;
	points[0]=Rotate(pointOrigin,points[0],angle);
	points[0]=Rotate(BasePoint,points[0],Rotation);
	points[1].x=rect.right;
	points[1].y=rect.top;
	points[1]=Rotate(pointOrigin,points[1],angle);
	points[1]=Rotate(BasePoint,points[1],Rotation);
	points[2].x=rect.right;
	points[2].y=rect.bottom;
	points[2]=Rotate(pointOrigin,points[2],angle);
	points[2]=Rotate(BasePoint,points[2],Rotation);
	points[3].x=rect.left;
	points[3].y=rect.bottom;
	points[3]=Rotate(pointOrigin,points[3],angle);
	points[3]=Rotate(BasePoint,points[3],Rotation);
	points[4].x=rect.left;
	points[4].y=rect.top;
	points[4]=Rotate(pointOrigin,points[4],angle);
	points[4]=Rotate(BasePoint,points[4],Rotation);

	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pMText)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	pDC->Polyline(points,pointCount);
	pDC->SelectObject(pOldPen);
	pen.DeleteObject();
	delete [] points;
}

void CADGraphics::RotateEntity_MText2(CDC* pDC,CADMText* pMText,CPoint BasePoint,double Rotation)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pMText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	int oldMode=pDC->SetBkMode(TRANSPARENT);
	pDC->SetBkMode(TRANSPARENT);
	COLORREF oldColor;
	if(pMText->m_nColor<0)
		oldColor=pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		oldColor=pDC->SetTextColor(GetColor(pMText->m_nColor));

	CPoint point;
	point=DocToClient(pMText->m_Location);
	point=Rotate(BasePoint,point,Rotation);

	double angle = atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	angle -= Rotation;

	ADSIZE adSize = {0,pMText->m_Height};
	CSize size = DocToClient(adSize);
	adSize.cx = pMText->m_Width;
	adSize.cy = 0;
	CSize size2 = DocToClient(adSize);

	CRect rect;
	rect.left=point.x;
	rect.right=point.y;

	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	font.CreateFont(fontHeight, 0, 
			(int)(angle*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x800 | FF_SWISS, pMText->m_Font);

	CFont* pOldFont=pDC->SelectObject(&font);

	CSize size3 = pDC->GetTextExtent("a",1);

	char align=pMText->m_Align; 
	switch(align)
	{
		case AD_MTEXT_ATTACH_TOPLEFT:
			pDC->SetTextAlign(TA_TOP | TA_LEFT); 
			break;
		case AD_MTEXT_ATTACH_TOPCENTER:
			pDC->SetTextAlign(TA_TOP | TA_CENTER); 
			break;
		case AD_MTEXT_ATTACH_TOPRIGHT:
			pDC->SetTextAlign(TA_TOP | TA_RIGHT); 
			break;
		case AD_MTEXT_ATTACH_MIDDLELEFT:
			pDC->SetTextAlign(TA_LEFT);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLECENTER:
			pDC->SetTextAlign(TA_CENTER);
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLERIGHT:
			pDC->SetTextAlign(TA_RIGHT); 
			point.y=point.y-size3.cy/2;
			break;
		case AD_MTEXT_ATTACH_BOTTOMLEFT:
			pDC->SetTextAlign(TA_BOTTOM | TA_LEFT); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMCENTER:
			pDC->SetTextAlign(TA_BOTTOM | TA_CENTER); 
			break;
		case AD_MTEXT_ATTACH_BOTTOMRIGHT:
			pDC->SetTextAlign(TA_BOTTOM | TA_RIGHT); 
			break;
	}

	if(!pMText->m_isWarp)
		pDC->DrawText(pMText->m_Text,CRect(point,size2),DT_NOCLIP);
	else
		pDC->DrawText(pMText->m_Text,CRect(point,size2),DT_WORDBREAK | DT_NOCLIP);
    //pDC->SelectObject(pOldFont);
    pDC->SetTextColor(oldColor);
	pDC->SetBkMode(oldMode);
}

void CADGraphics::RotateEntity_Text(CDC* pDC,CADText* pText,CPoint BasePoint,double Rotation)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pText->m_nLayer);
	if(pLayer==NULL)return;
	if(pLayer->m_nColor<0)return;

	pDC->SetBkMode(TRANSPARENT);
	if(pText->m_nColor<0)
		pDC->SetTextColor(GetColor(pLayer->m_nColor));
	else
		pDC->SetTextColor(GetColor(pText->m_nColor));
	//CPoint point;
	//point=DocToClient(pText->m_Location);

	CPoint pointOrigin=DocToClient(pText->m_Location);
	pointOrigin=Rotate(BasePoint,pointOrigin,Rotation);

	int index=IndexOfStyles(pText->m_StyleName);
	if(index==-1)return;

	CADStyle* pStyle = (CADStyle*)m_Styles.GetAt(index);
	ADSIZE adSize = {0,pText->m_Height+1};
	//adSize.cx=0;
	//adSize.cy=pText->m_Height+1;
	CSize size  =DocToClient(adSize);

	//<--added by hu on 2005/8/22
	int fontHeight = size.cy;
	if (fontHeight<1)fontHeight=1;
	//-->
	CFont font;
	//font.CreateFont(pText->m_Size*2*m_ZoomRate, 0, 
	font.CreateFont(fontHeight, 0, 
			(int)((pText->m_Angle-Rotation)*10), 0, FW_DONTCARE,
			0, 0, 0, DEFAULT_CHARSET ,OUT_TT_PRECIS,
			CLIP_CHARACTER_PRECIS, DEFAULT_QUALITY ,
			VARIABLE_PITCH | 0x04 | FF_DONTCARE, pStyle->m_Font);
		//	VARIABLE_PITCH | 0x04 | FF_DONTCARE, "ËÎÌå");
	pDC->SetTextAlign(TA_BASELINE);
	CFont* pOldFont=pDC->SelectObject(&font);
	pDC->TextOut(pointOrigin.x,pointOrigin.y,pText->m_Text);
    pDC->SelectObject(pOldFont);
	font.DeleteObject();
}

void CADGraphics::RotateEntity_Solid(CDC* pDC,CADSolid* pSolid,CPoint BasePoint,double Rotation)
{
	CPen pen;
	CBrush brush;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pSolid)))
		return;
	pDC->SelectObject(&pen);
	brush.CreateSolidBrush(GetEntityColor(pSolid));
	pDC->SelectObject(&brush);

	CPoint* points= new CPoint[4];

	//ADPOINT adPoint;
	//adPoint=pSolid->m_pt0;
	points[0]=DocToClient(pSolid->m_pt0);
	points[0]=Rotate(BasePoint,points[0],Rotation);

	//adPoint=pSolid->m_pt1;
	points[1]=DocToClient(pSolid->m_pt1);
	points[1]=Rotate(BasePoint,points[1],Rotation);

	//adPoint=pSolid->m_pt3;
	points[2]=DocToClient(pSolid->m_pt3);
	points[2]=Rotate(BasePoint,points[2],Rotation);

	//adPoint=pSolid->m_pt2;
	points[3]=DocToClient(pSolid->m_pt2);
	points[3]=Rotate(BasePoint,points[3],Rotation);

	pDC->Polygon(points,4);
	delete [] points;
}

void CADGraphics::RotateEntity_Circle(CDC* pDC,CADCircle* pCircle,CPoint BasePoint,double Rotation)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pCircle)))
		return;
	CPen* pOldPen = pDC->SelectObject(&pen);
	CBrush NullBrush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	NullBrush.CreateBrushIndirect(&logBrush);
	pDC->SelectObject(&NullBrush);

	//point1;
	//ADPOINT adPoint;
	//adPoint=pCircle->ptCenter;
	//point1=DocToClient(pCircle->ptCenter);
	CPoint point1 = Rotate(BasePoint,DocToClient(pCircle->ptCenter),Rotation);

	int radius = DocToClient(pCircle->m_Radius);
	Circle(pDC,point1,radius);
	pDC->SelectObject(pOldPen);
}

void CADGraphics::RotateEntity_Insert(CDC* pDC,CADInsert* pInsert,CPoint BasePoint,double Rotation)
{
	CPen dashPen;
	if(!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))return;

	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;

	ADPOINT BasePoint2=pInsert->pt;
	double xScale = pInsert->m_xScale;
	double yScale = pInsert->m_yScale;
	double Rotation2 = pInsert->m_Rotation-Rotation;

	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint2.x+=pBlock->m_BasePoint.x;
	BasePoint2.y+=pBlock->m_BasePoint.y;

	ADPOINT BasePoint3=ClientToDoc(BasePoint);
	BasePoint3=Rotate2(BasePoint3,BasePoint2,-Rotation);

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
		if (pEntity->GetType() == AD_ENT_MTEXT && !m_bBlack)return;
		DrawInsert(pDC,pEntity,BasePoint3,xScale,yScale,Rotation2);		
	}
}

void CADGraphics::RotateAll(CDC* pDC,CPoint BasePoint,double angle)
{
	//if(angle==0)return;
	CBrush brush;
	brush.CreateSolidBrush(m_BKColor);
	CRect rect(0,0,m_pDisplay->GetWidth(),m_pDisplay->GetHeight());
	pDC->FillRect(&rect, &brush);
	int oldDrawMode = pDC->SetROP2(13); 

	//ADPOINT adPoint=ClientToDoc(BasePoint);
	for(int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_Entities.GetAt(i);
		if(pEntity->GetType()==AD_ENT_MTEXT)
			RotateEntity_MText2(pDC,(CADMText*)pEntity,BasePoint,angle);
		else
			RotateEntities(pDC,pEntity,BasePoint,angle);
	}
	pDC->SetROP2(oldDrawMode);
}

void CADGraphics::RotateEntitiesTo(CPoint BasePoint,CPoint point)
{
	CSize size;
	size.cx=point.x-BasePoint.x;
	size.cy=point.y-BasePoint.y;
	if(size.cx==0 && size.cy==0)return;
	ADPOINT adPoint=ClientToDoc(BasePoint);
	//if(size.cx==0)return;
	double angle=atan2(size.cy,size.cx)*180/PI;

	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		RotateEntitiesTo(pEntity,adPoint,angle);
	}
}

void CADGraphics::RotateEntitiesTo(CADEntity* pEntity,ADPOINT BasePoint,double Rotation)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_LINE:
			{
				RotateEntityTo_Line((CADLine*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_POINT:
			{
				RotateEntityTo_Point((CADPoint*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				RotateEntityTo_Circle((CADCircle*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				RotateEntityTo_Polyline((CADPolyline*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_INSERT:
			{
				RotateEntityTo_Insert((CADInsert*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_ARC:
			{
				RotateEntityTo_Arc((CADArc*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_SPLINE:
			{
				RotateEntityTo_Spline((CADSpline*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_SOLID:
			{
				RotateEntityTo_Solid((CADSolid*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_TEXT:
			{
				RotateEntityTo_Text((CADText*)pEntity,BasePoint,Rotation);
				break;
			}
		case AD_ENT_MTEXT:
			{
				RotateEntityTo_MText((CADMText*)pEntity,BasePoint,Rotation);
				break;
			}
	}
}

void CADGraphics::RotateEntityTo_Line(CADLine* pLine,ADPOINT BasePoint,double Rotation)
{
	pLine->pt1 = Rotate2(BasePoint,pLine->pt1,-Rotation);
	pLine->pt2 = Rotate2(BasePoint,pLine->pt2,-Rotation);
}

void CADGraphics::RotateEntityTo_Arc(CADArc* pArc,ADPOINT BasePoint,double Rotation)
{
	pArc->ptCenter=Rotate2(BasePoint,pArc->ptCenter,-Rotation);
	pArc->m_StartAng-=Rotation;
	pArc->m_EndAng-=Rotation;
}

void CADGraphics::RotateEntityTo_Point(CADPoint* pPoint,ADPOINT BasePoint,double Rotation)
{
	pPoint->pt=Rotate2(BasePoint,pPoint->pt,-Rotation);
}

void CADGraphics::RotateEntityTo_Polyline(CADPolyline* pPolyline,ADPOINT BasePoint,double Rotation)
{
	int pointCount=pPolyline->m_Point.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(j);
		*pPoint = Rotate2(BasePoint,*pPoint,-Rotation);
	}
}

void CADGraphics::RotateEntityTo_Spline(CADSpline* pSpline,ADPOINT BasePoint,double Rotation)
{
	int pointCount=pSpline->m_FitPoint.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		*pPoint = Rotate2(BasePoint,*pPoint,-Rotation);
	}
}

void CADGraphics::RotateEntityTo_MText(CADMText* pText,ADPOINT BasePoint,double Rotation)
{
	CRect rect = GetMTextRect(pText);
	double angle = -atan2(pText->m_ptDir.y,pText->m_ptDir.x)*180/PI;
	ADPOINT adPoints[2];
	CPoint point;
	point.x=rect.left;
	point.y=rect.top;
	adPoints[0]=Rotate2(pText->m_Location,ClientToDoc(point),-angle);
	adPoints[0]=Rotate2(BasePoint,adPoints[0],-Rotation);
	point.x=rect.right;
	point.y=rect.top;
	adPoints[1]=Rotate2(pText->m_Location,ClientToDoc(point),-angle);
	adPoints[1]=Rotate2(BasePoint,adPoints[1],-Rotation);

	pText->m_Location=Rotate2(BasePoint,pText->m_Location,-Rotation);
	pText->m_ptDir.x=adPoints[1].x-adPoints[0].x;
	pText->m_ptDir.y=adPoints[1].y-adPoints[0].y;
}

void CADGraphics::RotateEntityTo_Text(CADText* pText,ADPOINT BasePoint,double Rotation)
{
	pText->m_Location=Rotate2(BasePoint,pText->m_Location,-Rotation);
	pText->m_Angle+=-Rotation; 
}

void CADGraphics::RotateEntityTo_Solid(CADSolid* pSolid,ADPOINT BasePoint,double Rotation)
{
	pSolid->m_pt0=Rotate2(BasePoint,pSolid->m_pt0,-Rotation);
	pSolid->m_pt1=Rotate2(BasePoint,pSolid->m_pt1,-Rotation);
	pSolid->m_pt2=Rotate2(BasePoint,pSolid->m_pt2,-Rotation);
	pSolid->m_pt3=Rotate2(BasePoint,pSolid->m_pt3,-Rotation);
}

void CADGraphics::RotateEntityTo_Circle(CADCircle* pCircle,ADPOINT BasePoint,double Rotation)
{
	pCircle->ptCenter = Rotate2(BasePoint,pCircle->ptCenter,-Rotation);
}

void CADGraphics::RotateEntityTo_Insert(CADInsert* pInsert,ADPOINT BasePoint,double Rotation)
{
	pInsert->pt = Rotate2(BasePoint,pInsert->pt,-Rotation);
	pInsert->m_Rotation+=-Rotation; 
}

void CADGraphics::MoveHandle(CDC* pDC,const CSize size)
{
	if(size.cx==0 && size.cy==0)return;
	int oldDrawMode;
	if(m_pSelHandleEntity && m_selectedHandle>0)
	{
		if(m_GraphicsMode==Layout)
			oldDrawMode = pDC->SetROP2(R2_NOTXORPEN);
		else
			oldDrawMode = pDC->SetROP2(R2_XORPEN);
		MoveHandle(pDC,m_pSelHandleEntity,size);
	}
	pDC->SetROP2(oldDrawMode);
}

void CADGraphics::MoveHandle(CDC* pDC,CADEntity* pEntity,const CSize size)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				MoveHandle_Point(pDC,(CADPoint*)pEntity,size);
				break;
			}
		case AD_ENT_LINE:
			{
				MoveHandle_Line(pDC,(CADLine*)pEntity,size);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				MoveHandle_Circle(pDC,(CADCircle*)pEntity,size);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				MoveHandle_Polyline(pDC,(CADPolyline*)pEntity,size);
				break;
			}
		case AD_ENT_INSERT:
			{
				MoveHandle_Insert(pDC,(CADInsert*)pEntity,size);
				break;
			}
		case AD_ENT_ARC:
			{
				MoveHandle_Arc(pDC,(CADArc*)pEntity,size);
				break;
			}
		case AD_ENT_SPLINE:
			{
				MoveHandle_Spline(pDC,(CADSpline*)pEntity,size);
				break;
			}
		case AD_ENT_MTEXT:
			{
				MoveHandle_MText(pDC,(CADMText*)pEntity,size);
				break;
			}
	}
}

void CADGraphics::MoveHandle_Arc(CDC* pDC,CADArc* pArc,const CSize size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pArc)))
		return;
	CPen dashPen;
	if (!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;
	ADPOINT adPoint;
	CPoint ptStart,ptEnd,ptMiddle,ptOrigin;
	adPoint.x = pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPoint.y = pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);
	ptStart = DocToClient(adPoint);
	adPoint.x = pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_EndAng*PI/180);
	adPoint.y = pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_EndAng*PI/180);
	ptEnd = DocToClient(adPoint);

	double angle = (pArc->m_StartAng+pArc->m_EndAng)/2;
	if(pArc->m_StartAng>pArc->m_EndAng)
	{
		if(angle<180)angle+=180;
		else angle-=180;
	}
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(angle*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(angle*PI/180);	
	ptMiddle=DocToClient(adPoint);
	if(m_selectedHandle==1)
	{
		ptOrigin=ptStart;
		ptStart.x+=size.cx;
		ptStart.y+=size.cy;
		pDC->SelectObject(&dashPen);
		pDC->MoveTo(ptOrigin);
		pDC->LineTo(ptStart);
	}
	if(m_selectedHandle==2)
	{
		ptOrigin=ptEnd;
		ptEnd.x+=size.cx;
		ptEnd.y+=size.cy;
		pDC->SelectObject(&dashPen);
		pDC->MoveTo(ptOrigin);
		pDC->LineTo(ptEnd);
	}
	if(m_selectedHandle==3)
	{
		ptOrigin=ptMiddle;
		ptMiddle.x+=size.cx;
		ptMiddle.y+=size.cy;
		pDC->SelectObject(&dashPen);
		pDC->MoveTo(ptOrigin);
		pDC->LineTo(ptMiddle);
	}
	CPoint ptCenter;
	long radius;
	circle_3pnts(&ptStart,&ptMiddle,&ptEnd,&ptCenter,&radius);
	CRect rect;
	rect.SetRect(ptCenter.x-radius,ptCenter.y-radius,ptCenter.x+radius,ptCenter.y+radius);
	pDC->SelectObject(&pen);
	if(IsCounter(ptStart,ptMiddle,ptEnd))
		pDC->Arc(rect,ptEnd,ptStart);
	else
		pDC->Arc(rect,ptStart,ptEnd);
}

void CADGraphics::MoveHandle_Line(CDC* pDC,CADLine* pLine,const CSize size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pLine)))
		return;
	pDC->SelectObject(&pen);
	CPen dashPen;
	if (!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;

	CPoint point1,point2,pointMove;
	point1=DocToClient(pLine->pt1);
	point2=DocToClient(pLine->pt2);
	if(m_selectedHandle!=3)
	{
		if(m_selectedHandle==1)
		{
			pointMove=point1;
			pointMove.x+=size.cx;
			pointMove.y+=size.cy;
			pDC->SelectObject(&dashPen);
			pDC->MoveTo(point1);
			pDC->LineTo(pointMove);
			pDC->SelectObject(&pen);
			pDC->MoveTo(point2);
			pDC->LineTo(pointMove);
		}
		if(m_selectedHandle==2)
		{
			pointMove=point2;
			pointMove.x+=size.cx;
			pointMove.y+=size.cy;
			pDC->SelectObject(&pen);
			pDC->MoveTo(point1);
			pDC->LineTo(pointMove);
			pDC->SelectObject(&dashPen);
			pDC->MoveTo(point2);
			pDC->LineTo(pointMove);				
		}

	}else
	{
		CPoint point3;
		ADPOINT vertex1;
		pLine->GetCenter(&vertex1);
		point3=DocToClient(vertex1);

		pointMove = point3;
		pointMove.x += size.cx;
		pointMove.y += size.cy;
		point1.x += size.cx;
		point1.y += size.cy;
		point2.x += size.cx;
		point2.y += size.cy;

		pDC->MoveTo(point1);
		pDC->LineTo(point2);
		pDC->SelectObject(&dashPen);
		pDC->MoveTo(point3);
		pDC->LineTo(pointMove);
	}
}

void CADGraphics::MoveHandle_Point(CDC* pDC,CADPoint* pPoint,const CSize size)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pPoint->m_nLayer);
	if(pLayer->m_nColor<0)return;

/*	CPen pen;
	if(pPoint->m_nColor<0)
	{
		if (!pen.CreatePen(PS_SOLID, 1, GetColor(pLayer->m_nColor)))
			return;
	}
	else
	{
		if (!pen.CreatePen(PS_SOLID, 1, GetColor(pPoint->m_nColor)))
			return;
	}*/

	CPoint point1 = DocToClient(pPoint->pt);
	CPoint pointMove = point1 + size;
	CPen* pOldPen = pDC->SelectObject(m_DashPen);
	pDC->MoveTo(point1);
	pDC->LineTo(pointMove);
	pDC->SelectObject(pOldPen);
}

void CADGraphics::MoveHandle_Polyline(CDC* pDC,CADPolyline* pPolyline,const CSize size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pPolyline)))
		return;
	pDC->SelectObject(&pen);
	
	CPoint point1,point2,point3,pointMove;
	ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle-1);
	pointMove=point3=DocToClient(*pPoint);
	pointMove += size;
	if(m_selectedHandle!=1 && m_selectedHandle!=pPolyline->m_Point.GetSize())
	{
		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle-2);
		point1=DocToClient(*pPoint);
		pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle);
		point2=DocToClient(*pPoint);

		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);
		pDC->MoveTo(point2);
		pDC->LineTo(pointMove);
		pDC->SelectObject(m_DashPen);			
		pDC->MoveTo(point3);
		pDC->LineTo(pointMove);
	}
	else
	{
		if(pPolyline->m_Closed)
		{
			if(m_selectedHandle==1)
			{
				ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(pPolyline->m_Point.GetSize()-1);
				point1=DocToClient(*pPoint);
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle);
				point2=DocToClient(*pPoint);
			}
			else
			{
				ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle-2);
				point1=DocToClient(*pPoint);
				pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);
				point2=DocToClient(*pPoint);
			}
			pDC->MoveTo(point1);
			pDC->LineTo(pointMove);
			pDC->MoveTo(point2);
			pDC->LineTo(pointMove);
			pDC->SelectObject(m_DashPen);			
			pDC->MoveTo(point3);
			pDC->LineTo(pointMove);		
		}
		else
		{
			if(m_selectedHandle==1)
			{
				ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle);
				point1 = DocToClient(*pPoint);
			}
			else
			{
				ADPOINT* pPoint = (ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle-2);
				point1 = DocToClient(*pPoint);
			}
			pDC->MoveTo(point1);
			pDC->LineTo(pointMove);	
			pDC->SelectObject(m_DashPen);			
			pDC->MoveTo(point3);
			pDC->LineTo(pointMove);				
		}
	}
}

void CADGraphics::MoveHandle_Spline(CDC* pDC,CADSpline* pSpline,const CSize size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pSpline)))
		return;
	pDC->SelectObject(&pen);

	int FitPtCount=pSpline->m_FitPoint.GetSize();
	CPoint* points= new CPoint[FitPtCount];
	CPoint *points1=points;
	for(int j=0;j<FitPtCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		*points=DocToClient(*pPoint);
		points++;
	}
	
	CPoint ptOrigin=points1[m_selectedHandle-1];
	points1[m_selectedHandle-1].x+=size.cx;
	points1[m_selectedHandle-1].y+=size.cy;
	Spline spline(points1, FitPtCount);
	spline.Generate();
	pSpline->m_CurvePoints.RemoveAll();
	pSpline->m_CurvePoints.SetSize(spline.GetCurveCount());
	int PointCount = 0;
	spline.GetCurve(pSpline->m_CurvePoints.GetData(), PointCount);
	if(pSpline->m_CurvePoints.GetSize()>1)
		pDC->Polyline(pSpline->m_CurvePoints.GetData(), pSpline->m_CurvePoints.GetSize());
	pSpline->m_CurvePoints.RemoveAll();

	CPen dashPen;
	if (!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
	{
		delete[] points1;
		return;
	}
	pDC->SelectObject(&dashPen);
	pDC->MoveTo(ptOrigin);
	pDC->LineTo(points1[m_selectedHandle-1]);
	delete[] points1;
}

void CADGraphics::MoveHandle_MText(CDC* pDC,CADMText* pMText,const CSize size)
{
	CPen pen;
	if (!pen.CreatePen(PS_SOLID, 1, GetEntityColor(pMText)))
		return;
	pDC->SelectObject(&pen);
	CPen dashPen;
	if (!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))
		return;
	CPoint point1,point2,point3,pointMove;
	CRect rect=GetMTextRect(pMText);
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;

	if(m_selectedHandle==1)
	{
		point1=rect.TopLeft();
	}
	if(m_selectedHandle==2)
	{
		point1.x=rect.right;
		point1.y=rect.top;
	}
	if(m_selectedHandle==3)
	{
		point1=rect.BottomRight();
	}
	if(m_selectedHandle==4)
	{
		point1.x=rect.left;
		point1.y=rect.bottom;
	}
	point1=Rotate(pointOrigin,point1,angle);
	pointMove=point1;
	pointMove.x+=size.cx;
	pointMove.y+=size.cy;

	pointOrigin+=size;

	rect+=size;
	const short pointCount=5;
	CPoint* points= new CPoint[pointCount];
	points[0].x=rect.left;
	points[0].y=rect.top;
	points[0]=Rotate(pointOrigin,points[0],angle);
	points[1].x=rect.right;
	points[1].y=rect.top;
	points[1]=Rotate(pointOrigin,points[1],angle);
	points[2].x=rect.right;
	points[2].y=rect.bottom;
	points[2]=Rotate(pointOrigin,points[2],angle);
	points[3].x=rect.left;
	points[3].y=rect.bottom;
	points[3]=Rotate(pointOrigin,points[3],angle);
	points[4].x=rect.left;
	points[4].y=rect.top;
	points[4]=Rotate(pointOrigin,points[4],angle);

	pDC->SelectObject(&dashPen);
	pDC->MoveTo(point1);
	pDC->LineTo(pointMove);
	pDC->SelectObject(&pen);
	pDC->Polyline(points,pointCount);
	delete [] points;
}

void CADGraphics::MoveHandle_Text(CDC* pDC,CADText* pText,const CSize size)
{

}

void CADGraphics::MoveHandle_Solid(CDC* pDC,CADSolid* pSolid,const CSize size)
{

}

void CADGraphics::MoveHandle_Circle(CDC* pDC,CADCircle* pCircle,const CSize size)
{
	CADLayer* pLayer=m_pLayerGroup->GetLayer(pCircle->m_nLayer);
	if(pLayer->m_nColor<0)return;

	CPen pen;
	if(pCircle->m_nColor<0)
	{
		if (!pen.CreatePen(PS_SOLID, 1, GetColor(pLayer->m_nColor)))
			return;
	}
	else
	{
		if (!pen.CreatePen(PS_SOLID, 1, GetColor(pCircle->m_nColor)))
			return;
	}
	pDC->SelectObject(&pen);

	CPoint point1,pointMove,pointCenter;
	pointCenter=DocToClient(pCircle->ptCenter);

	if(m_selectedHandle==1)
	{
		point1=pointCenter;
		pointMove = point1 + size;
		int radius=DocToClient(pCircle->m_Radius);
		pDC->SelectObject(m_NullBrush);
		pDC->Ellipse(pointMove.x-radius,pointMove.y-radius,pointMove.x+radius,pointMove.y+radius);
		pDC->SelectObject(m_DashPen);
		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);	
	}
	if(m_selectedHandle==2)
	{
		ADPOINT adPoint = {pCircle->ptCenter.x-pCircle->m_Radius,pCircle->ptCenter.y};
		point1 = DocToClient(adPoint);
		pointMove = point1 + size;
		int radius=Distance(pointMove,pointCenter);
		pDC->SelectObject(m_NullBrush);
		pDC->Ellipse(pointCenter.x-radius,pointCenter.y-radius,pointCenter.x+radius,pointCenter.y+radius);
		pDC->SelectObject(m_DashPen);
		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);
	}
	if(m_selectedHandle==3)
	{
		ADPOINT adPoint = {pCircle->ptCenter.x,pCircle->ptCenter.y+pCircle->m_Radius};
		point1=DocToClient(adPoint);
		pointMove = point1 + size;
		int radius=Distance(pointMove,pointCenter);
		pDC->SelectObject(m_NullBrush);
		pDC->Ellipse(pointCenter.x-radius,pointCenter.y-radius,pointCenter.x+radius,pointCenter.y+radius);
		pDC->SelectObject(m_DashPen);
		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);
	}
	if(m_selectedHandle==4)
	{
		ADPOINT adPoint = {pCircle->ptCenter.x+pCircle->m_Radius,pCircle->ptCenter.y};
		point1=DocToClient(adPoint);
		pointMove = point1 + size;
		int radius=Distance(pointMove,pointCenter);
		pDC->SelectObject(m_NullBrush);
		pDC->Ellipse(pointCenter.x-radius,pointCenter.y-radius,pointCenter.x+radius,pointCenter.y+radius);
		pDC->SelectObject(m_DashPen);
		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);
	}
	if(m_selectedHandle==5)
	{
		ADPOINT adPoint = {pCircle->ptCenter.x,pCircle->ptCenter.y-pCircle->m_Radius};
		point1 = DocToClient(adPoint);
		pointMove = point1 + size;
		int radius = Distance(pointMove,pointCenter);
		pDC->SelectObject(m_NullBrush);
		pDC->Ellipse(pointCenter.x-radius,pointCenter.y-radius,pointCenter.x+radius,pointCenter.y+radius);
		pDC->SelectObject(m_DashPen);
		pDC->MoveTo(point1);
		pDC->LineTo(pointMove);
	}
}

void CADGraphics::MoveHandle_Insert(CDC* pDC,CADInsert* pInsert,const CSize size)
{
	if(size.cx==0 && size.cy==0)return;
	if(m_ZoomRate==0)return;

	ADSIZE adsize=ClientToDoc(size);
	if(adsize.cx==0 && adsize.cy==0)return;

	CPen dashPen;
	if(!dashPen.CreatePen(PS_DOT, 1, RGB(0,0,0)))return;

	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;

	ADPOINT BasePoint=pInsert->pt;
	double xScale=pInsert->m_xScale;
	double yScale=pInsert->m_yScale;
	double Rotation=pInsert->m_Rotation;

	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x+=pBlock->m_BasePoint.x;
	BasePoint.y+=pBlock->m_BasePoint.y;

	CPoint point1,pointMove;
	point1=DocToClient(BasePoint);
	//BasePoint.x+=dx;
	//BasePoint.y-=dy;		
	BasePoint.x+=adsize.cx;
	BasePoint.y-=adsize.cy;
	pointMove=DocToClient(BasePoint);

	for(int j=0;j<pBlock->m_Entities.GetSize();j++)
	{
		CADEntity* pEntity;
		pEntity=(CADEntity*)pBlock->m_Entities.GetAt(j);
		if(pEntity->GetType()==AD_ENT_MTEXT)continue;
		DrawInsert(pDC,pEntity,BasePoint,xScale,yScale,Rotation);		
	}
	pDC->SelectObject(&dashPen);
	pDC->MoveTo(point1);
	pDC->LineTo(pointMove);
}

void CADGraphics::MoveHandleTo(const CSize size)
{
	if(size.cx==0 && size.cy==0)return;
	if(m_pSelHandleEntity && m_selectedHandle>0)
	{
		ADSIZE adSize;
		adSize=ClientToDoc(size);
		/*double dx,dy;
		dx=(double)size.cx/m_ZoomRate;
		dy=(double)size.cy/m_ZoomRate;	*/	
		MoveHandleTo(m_pSelHandleEntity,adSize.cx,adSize.cy);
		m_selectedHandle=0;
		m_pSelHandleEntity=NULL;
	}
}

void CADGraphics::MoveHandleTo(CADEntity* pEntity,double dx,double dy)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				MoveHandleTo_Point((CADPoint*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_LINE:
			{
				MoveHandleTo_Line((CADLine*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				MoveHandleTo_Circle((CADCircle*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				MoveHandleTo_Polyline((CADPolyline*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_INSERT:
			{
				MoveHandleTo_Insert((CADInsert*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_ARC:
			{
				MoveHandleTo_Arc((CADArc*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_SPLINE:
			{
				MoveHandleTo_Spline((CADSpline*)pEntity,dx,dy);
				break;
			}
		case AD_ENT_MTEXT:
			{
				MoveHandleTo_MText((CADMText*)pEntity,dx,dy);
				break;
			}
	}
}


void CADGraphics::MoveHandleTo_Arc(CADArc* pArc,double dx,double dy)
{
	ADPOINT adPoint;
	CPoint ptStart,ptEnd,ptMiddle,ptOrigin;
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);
	if(m_selectedHandle==1)
	{
		adPoint.x+=dx;
		adPoint.y-=dy;
	}
	ptStart=DocToClient(adPoint);
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_EndAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_EndAng*PI/180);
	if(m_selectedHandle==2)
	{
		adPoint.x+=dx;
		adPoint.y-=dy;
	}
	ptEnd=DocToClient(adPoint);
	double angle;
	angle=(pArc->m_StartAng+pArc->m_EndAng)/2;
	if(pArc->m_StartAng>pArc->m_EndAng)
	{
		if(angle<180)angle+=180;
		else angle-=180;
	}
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(angle*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(angle*PI/180);
	if(m_selectedHandle==3)
	{
		adPoint.x+=dx;
		adPoint.y-=dy;
	}	
	ptMiddle=DocToClient(adPoint);

	CPoint ptCenter;
	long radius;
	circle_3pnts(&ptStart,&ptMiddle,&ptEnd,&ptCenter,&radius);

	pArc->m_Radius=ClientToDoc(radius);
	pArc->ptCenter=ClientToDoc(ptCenter);
	double angle1,angle2;
	angle1=angleBetween3Pt(ptCenter.x,ptCenter.y,ptCenter.x+100,ptCenter.y,ptStart.x,ptStart.y);
	angle2=angleBetween3Pt(ptCenter.x,ptCenter.y,ptCenter.x+100,ptCenter.y,ptEnd.x,ptEnd.y);
	if(IsCounter(ptStart,ptMiddle,ptEnd))
	{
		pArc->m_StartAng=angle2;
		pArc->m_EndAng=angle1;
	}else
	{
		pArc->m_StartAng=angle1;
		pArc->m_EndAng=angle2;				
	}
}

void CADGraphics::MoveHandleTo_Line(CADLine* pLine,double dx,double dy)
{
	if(m_selectedHandle==1)
	{
		if(m_bHaveSnap)
		{
			pLine->pt1=m_curSnapP;
			pLine->pt1=m_curSnapP;			
		}else
		{
			pLine->pt1.x+=dx;
			pLine->pt1.y-=dy;			
		}
	}
	if(m_selectedHandle==2)
	{
		if(m_bHaveSnap)
		{
			pLine->pt2=m_curSnapP;
			pLine->pt2=m_curSnapP;			
		}else
		{
			pLine->pt2.x+=dx;
			pLine->pt2.y-=dy;			
		}
	}
	if(m_selectedHandle==3)
	{
		if(m_bHaveSnap)
		{
			ADPOINT point1;
			point1.x=(pLine->pt1.x+pLine->pt2.x)/2;
			point1.y=(pLine->pt1.y+pLine->pt2.y)/2;
			dx=m_curSnapP.x-point1.x;
			dy=-(m_curSnapP.y-point1.y);		
		}
		pLine->pt1.x+=dx;
		pLine->pt1.y-=dy;
		pLine->pt2.x+=dx;
		pLine->pt2.y-=dy;	
	}
}

void CADGraphics::MoveHandleTo_Point(CADPoint* pPoint,double dx,double dy)
{
	if(m_bHaveSnap)
	{
		pPoint->pt=m_curSnapP;		
	}else
	{
		pPoint->pt.x+=dx;
		pPoint->pt.y-=dy;		
	}
}

void CADGraphics::MoveHandleTo_Polyline(CADPolyline* pPolyline,double dx,double dy)
{
	ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(m_selectedHandle-1);
	if(m_bHaveSnap)
	{
		*pPoint = m_curSnapP;		
	}else
	{
		pPoint->x += dx;
		pPoint->y -= dy;		
	}
}

void CADGraphics::MoveHandleTo_Spline(CADSpline* pSpline,double dx,double dy)
{
	ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(m_selectedHandle-1);
	if(m_bHaveSnap)
	{
		*pPoint=m_curSnapP;		
	}else
	{
		pPoint->x+=dx;
		pPoint->y-=dy;		
	}
}

void CADGraphics::MoveHandleTo_MText(CADMText* pText,double dx,double dy)
{
	if(m_bHaveSnap)
	{
		pText->m_Location=m_curSnapP;		
	}else
	{
		pText->m_Location.x+=dx;
		pText->m_Location.y-=dy;		
	}
}

void CADGraphics::MoveHandleTo_Text(CADText* pText,double dx,double dy)
{

}

void CADGraphics::MoveHandleTo_Solid(CADSolid* pSolid,double dx,double dy)
{

}

void CADGraphics::MoveHandleTo_Circle(CADCircle* pCircle,double dx,double dy)
{
	if(m_selectedHandle==1)
	{
		if(m_bHaveSnap)
		{
			pCircle->ptCenter=m_curSnapP;		
		}else
		{
			pCircle->ptCenter.x+=dx;
			pCircle->ptCenter.y-=dy;		
		}
	}
	if(m_selectedHandle==2)
	{
		if(m_bHaveSnap)
		{
			pCircle->m_Radius=Distance(m_curSnapP,pCircle->ptCenter);			
		}else
		{
			ADPOINT pointMove;
			pointMove.x=pCircle->ptCenter.x-pCircle->m_Radius+dx;
			pointMove.y=pCircle->ptCenter.y-dy;
			pCircle->m_Radius=Distance(pointMove,pCircle->ptCenter);
		}
	}
	if(m_selectedHandle==3)
	{
		if(m_bHaveSnap)
		{
			pCircle->m_Radius=Distance(m_curSnapP,pCircle->ptCenter);			
		}else
		{
			ADPOINT pointMove;
			pointMove.x=pCircle->ptCenter.x+dx;
			pointMove.y=pCircle->ptCenter.y+pCircle->m_Radius-dy;
			pCircle->m_Radius=Distance(pointMove,pCircle->ptCenter);
		}
	}
	if(m_selectedHandle==4)
	{
		if(m_bHaveSnap)
		{
			pCircle->m_Radius=Distance(m_curSnapP,pCircle->ptCenter);			
		}else
		{
			ADPOINT pointMove;
			pointMove.x=pCircle->ptCenter.x+pCircle->m_Radius+dx;
			pointMove.y=pCircle->ptCenter.y-dy;
			pCircle->m_Radius=Distance(pointMove,pCircle->ptCenter);
		}
	}
	if(m_selectedHandle==5)
	{
		if(m_bHaveSnap)
		{
			pCircle->m_Radius=Distance(m_curSnapP,pCircle->ptCenter);			
		}else
		{
			ADPOINT pointMove;
			pointMove.x=pCircle->ptCenter.x+dx;
			pointMove.y=pCircle->ptCenter.y-pCircle->m_Radius-dy;
			pCircle->m_Radius=Distance(pointMove,pCircle->ptCenter);
		}
	}
}

void CADGraphics::MoveHandleTo_Insert(CADInsert* pInsert,double dx,double dy)
{
	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return;
	if(m_selectedHandle==1)
	{
		if(m_bHaveSnap)
		{
			pInsert->pt=m_curSnapP;	
		}else
		{
			pInsert->pt.x+=dx;
			pInsert->pt.y-=dy;		
		}			
	}
}

void CADGraphics::SelectHandle(const CPoint& point)
{
	m_selectedHandle=0;
	for(int i=0;i<m_SelectedEntities.GetSize();i++)
	{
		CADEntity* pEntity;
		pEntity=(CADEntity*)m_SelectedEntities.GetAt(i);
		if(SelectHandle(point,pEntity)>0)
		{
			m_selectedHandle=SelectHandle(point,pEntity);
			m_pSelHandleEntity=pEntity;
			return;
		}
	}
}

int CADGraphics::SelectHandle(const CPoint& point,CADEntity* pEntity)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_POINT:
			{
				return SelectHandle_Point(point,(CADPoint*)pEntity);
				break;
			}
		case AD_ENT_LINE:
			{
				return SelectHandle_Line(point,(CADLine*)pEntity);
				break;
			}
		case AD_ENT_CIRCLE:
			{
				return SelectHandle_Circle(point,(CADCircle*)pEntity);
				break;
			}
		case AD_ENT_POLYLINE:
			{
				return SelectHandle_Polyline(point,(CADPolyline*)pEntity);
				break;
			}
		case AD_ENT_INSERT:
			{
				return SelectHandle_Insert(point,(CADInsert*)pEntity);
				break;
			}
		case AD_ENT_ARC:
			{
				return SelectHandle_Arc(point,(CADArc*)pEntity);
				break;
			}
		case AD_ENT_SPLINE:
			{
				return SelectHandle_Spline(point,(CADSpline*)pEntity);
				break;
			}
		case AD_ENT_MTEXT:
			{
				return SelectHandle_MText(point,(CADMText*)pEntity);
				break;
			}
		case AD_ENT_SOLID:
			{
				return SelectHandle_Solid(point,(CADSolid*)pEntity);
				break;
			}
	}
	return false;
}

int CADGraphics::SelectHandle_Point(const CPoint& point,const CADPoint* pPoint)
{
	CPoint point1;
	point1=DocToClient(pPoint->pt);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=pPoint->pt;
			m_bHaveSnap=true;		
		}
		return 1;
	}
	return 0;
}

int CADGraphics::SelectHandle_Line(const CPoint& point,CADLine* pLine)
{
	CPoint point1,point2,point3;
	point1=DocToClient(pLine->pt1);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=pLine->pt1;
			m_bHaveSnap=true;		
		}
		return 1;
	}
	point2=DocToClient(pLine->pt2);
	if(isSelectedPoint(point,point2))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=pLine->pt2;
			m_bHaveSnap=true;	
		}
		return 2;
	}
	ADPOINT adPoint;
	pLine->GetCenter(&adPoint);
	point3=DocToClient(adPoint);		
	if(isSelectedPoint(point,point3))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=adPoint;
			m_bHaveSnap=true;		
		}
		return 3;
	}
	return 0;
}

int CADGraphics::SelectHandle_Polyline(const CPoint& point,const CADPolyline* pPolyline)
{
	int pointCount=pPolyline->m_Point.GetSize();
	for(int j=0;j<pointCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(j);		
		CPoint point2=DocToClient(*pPoint);
		if(isSelectedPoint(point,point2))
		{
			if(m_bSnapStatus)
			{
				m_curSnapP = *pPoint;
				m_bHaveSnap=true;		
			}
			return j+1;
		}
	}
	return 0;
}

int CADGraphics::SelectHandle_Spline(const CPoint& point,const CADSpline* pSpline)
{
	int FitPtCount=pSpline->m_FitPoint.GetSize();
	CPoint point1;
	for(int j=0;j<FitPtCount;j++)
	{
		ADPOINT* pPoint=(ADPOINT*)pSpline->m_FitPoint.GetAt(j);
		point1=DocToClient(*pPoint);

		if(isSelectedPoint(point,point1))
		{
			if(m_bSnapStatus)
			{
				m_curSnapP=*pPoint;
				m_bHaveSnap=true;		
			}
			return j+1;
		}
	}
	return 0;
}

int CADGraphics::SelectHandle_MText(const CPoint& point,const CADMText* pMText)
{
	CRect rect=GetMTextRect(pMText);
	CPoint pointOrigin=DocToClient(pMText->m_Location);
	double angle=-atan2(pMText->m_ptDir.y,pMText->m_ptDir.x)*180/PI;
	CPoint point1;
	point1.x=rect.left;
	point1.y=rect.top;
	point1=Rotate(pointOrigin,point1,angle);
	if(isSelectedPoint(point,point1))
	{
		return 1;
	}
	point1.x=rect.right;
	point1.y=rect.top;
	point1=Rotate(pointOrigin,point1,angle);
	if(isSelectedPoint(point,point1))
	{
		return 2;
	}
	point1.x=rect.right;
	point1.y=rect.bottom;
	point1=Rotate(pointOrigin,point1,angle);
	if(isSelectedPoint(point,point1))
	{
		return 3;
	}
	point1.x=rect.left;
	point1.y=rect.bottom;
	point1=Rotate(pointOrigin,point1,angle);
	if(isSelectedPoint(point,point1))
	{
		return 4;
	}
	return 0;
}

int CADGraphics::SelectHandle_Solid(const CPoint& point,const CADSolid* pSolid)
{
	if(isSelectedPoint(point,DocToClient(pSolid->m_pt0)))
	{
		return 1;
	}
	if(isSelectedPoint(point,DocToClient(pSolid->m_pt1)))
	{
		return 2;
	}
	if(isSelectedPoint(point,DocToClient(pSolid->m_pt2)))
	{
		return 3;
	}
	if(isSelectedPoint(point,DocToClient(pSolid->m_pt3)))
	{
		return 4;
	}
	return 0;
}

int CADGraphics::SelectHandle_Circle(const CPoint& point,const CADCircle* pCircle)
{
	CPoint ptCenter=DocToClient(pCircle->ptCenter);
	int radius=DocToClient(pCircle->m_Radius);

	CPoint point1=ptCenter;
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=pCircle->ptCenter;
			m_bHaveSnap=true;		
		}
		return 1;
	}	

	point1.x=ptCenter.x-radius;
	point1.y=ptCenter.y;
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=ClientToDoc(point1);
			m_bHaveSnap=true;		
		}
		return 2;
	}
	point1.x=ptCenter.x;
	point1.y=ptCenter.y-radius;
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=ClientToDoc(point1);
			m_bHaveSnap=true;		
		}
		return 3;
	}
	point1.x=ptCenter.x+radius;
	point1.y=ptCenter.y;
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=ClientToDoc(point1);
			m_bHaveSnap=true;		
		}
		return 4;
	}
	point1.x=ptCenter.x;
	point1.y=ptCenter.y+radius;
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=ClientToDoc(point1);
			m_bHaveSnap=true;		
		}
		return 5;
	}
	return 0;
}

int CADGraphics::SelectHandle_Insert(const CPoint& point,const CADInsert* pInsert)
{
	int blockIndex=this->IndexOfBlocks(pInsert->m_Name);
	if(blockIndex==-1)return false;	
	ADPOINT BasePoint;
	BasePoint=pInsert->pt;

	CADBlock* pBlock;
	pBlock=(CADBlock*)m_Blocks.GetAt(blockIndex);
	BasePoint.x+=pBlock->m_BasePoint.x;
	BasePoint.y+=pBlock->m_BasePoint.y;
	CPoint point1;
	point1=DocToClient(BasePoint);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=BasePoint;
			m_bHaveSnap=true;
		}
		return 1;
	}
	return 0;
}

int CADGraphics::SelectHandle_Arc(const CPoint& point,const CADArc* pArc)
{
	ADPOINT adPoint;
	CPoint point1;
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_StartAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_StartAng*PI/180);
	point1=DocToClient(adPoint);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=adPoint;
			m_bHaveSnap=true;		
		}
		return 1;
	}

	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(pArc->m_EndAng*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(pArc->m_EndAng*PI/180);
	point1=DocToClient(adPoint);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=adPoint;
			m_bHaveSnap=true;		
		}
		return 2;
	}
	double angle;
	angle=(pArc->m_StartAng+pArc->m_EndAng)/2;
	if(pArc->m_StartAng>pArc->m_EndAng)
	{
		if(angle<180)angle+=180;
		else angle-=180;
	}
	adPoint.x=pArc->ptCenter.x+pArc->m_Radius*cos(angle*PI/180);
	adPoint.y=pArc->ptCenter.y+pArc->m_Radius*sin(angle*PI/180);	
	point1=DocToClient(adPoint);
	if(isSelectedPoint(point,point1))
	{
		if(m_bSnapStatus)
		{
			m_curSnapP=adPoint;
			m_bHaveSnap=true;		
		}
		return 3;
	}
	return 0;
}

void CADGraphics::DrawSnapSign(CDC* pDC,CPoint point)
{
	const int dx=5;
	CPen pen;
	pen.CreatePen(PS_DASH,2,RGB(0,255,0));
	pDC->SelectObject(&pen);
	CBrush brush;
	LOGBRUSH logBrush;
	logBrush.lbColor = 0;
	logBrush.lbHatch = 0;
	logBrush.lbStyle = BS_NULL;
	brush.CreateBrushIndirect(&logBrush);
	pDC->SelectObject(&brush);
	//pDC->SetROP2(R2_NOT);
	int oldDrawMode = pDC->SetROP2(R2_XORPEN);
	pDC->Rectangle(point.x-dx,point.y-dx,point.x+dx,point.y+dx);
	pDC->SetROP2(oldDrawMode);
}

//judge current point is snaped
bool CADGraphics::SnapHandle(CDC* pDC,CPoint point)
{
	if(m_bHaveSnap)
	{
		DrawSnapSign(pDC,DocToClient(m_curSnapP));
	}

	for(int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity=(CADEntity*)m_Entities.GetAt(i);
		if(SelectHandle(point,pEntity)>0)
		{
			DrawSnapSign(pDC,DocToClient(m_curSnapP));
			return true;
		}
	}
	m_bHaveSnap=false;
	return false;
}

void CADGraphics::GetPointCenter(CPoint point1,CPoint point2,CPoint& pointCenter)
{
	pointCenter.x=point1.x+(int)((point2.x-point1.x)/2);
	pointCenter.y=point1.y+(int)((point2.y-point1.y)/2);
}

CPoint CADGraphics::ConSnapPoint(CPoint point)
{
//	if(m_bHaveSnap)
//		return m_curSnapPoint;
	return point;
}

COLORREF CADGraphics::GetColor(short nColor)
{
	if(m_GraphicsMode==Printing || m_bBlack)
		return RGB(0,0,0);
	switch(nColor)
	{
		case AD_COLOR_RED:
			return RGB(255,0,0);
			break;
		case AD_COLOR_YELLOW:
			return RGB(255,255,0);
			break;
		case AD_COLOR_GREEN:
			return RGB(0,255,0);
			break;
		case AD_COLOR_CYAN:
			return RGB(0,255,255);
			break;
		case AD_COLOR_BLUE:
			return RGB(0,0,255);
			break;
		case AD_COLOR_MAGENTA:
			return RGB(255,0,255);
			break;
		case AD_COLOR_WHITE:
			return m_WhiteColor;
			break;
		case AD_COLOR_GRAY:
			return RGB(132,130,132);
			break;
		default:
			return RGB(255,255,255);
	}
}

int CADGraphics::IndexOfBlocks(const char* name)
{
	for(int i=0;i<m_Blocks.GetSize();i++)
	{
		CADBlock* pBlock=(CADBlock*)m_Blocks.GetAt(i);
		if(_stricmp(name,pBlock->m_Name)==0)
			return i;
	}
	return -1;
}

int CADGraphics::IndexOfBlockRecords(const char* name)
{
	for(int i=0;i<m_BlockRecords.GetSize();i++)
	{
		CADBlockRecord* pBlockRecord=(CADBlockRecord*)m_BlockRecords.GetAt(i);
		if(_stricmp(name,pBlockRecord->m_Name)==0)
			return i;
	}
	return -1;
}

int CADGraphics::IndexOfStyles(const char* name)
{
	for(int i=0;i<m_Styles.GetSize();i++)
	{
		CADStyle* pStyle=(CADStyle*)m_Styles.GetAt(i);
		if(_stricmp(name,pStyle->m_Name)==0)
			return i;
	}
	return -1;
}

int CADGraphics::IndexOfLTypes(const char* name)
{
	for(int i=0;i<m_LTypes.GetSize();i++)
	{
		CADLType* pLType=(CADLType*)m_LTypes.GetAt(i);
		if(_stricmp(name,pLType->m_Name)==0)
			return i;
	}
	return -1;
}

int CADGraphics::IndexOfEntities(const CADEntity* pEntity)
{
	for(int i=0;i<m_Entities.GetSize();i++)
	{
		if((CADEntity*)m_Entities.GetAt(i)==pEntity)return i;
	}
	return -1;	
}

CADEntity* CADGraphics::TransBlockEntity(CADEntity* pEntity,ADPOINT BasePoint,double xScale,double yScale)
{
	switch (pEntity->GetType())
	{
		case AD_ENT_LINE:
			{
				CADLine* pLine;
				pLine=(CADLine*)pEntity;

				CADLine* pTempLine=new CADLine();
				*pTempLine=*pLine;

				pTempLine->pt1.x*=xScale;
				pTempLine->pt1.y*=yScale;
				pTempLine->pt1.x+=BasePoint.x; 
				pTempLine->pt1.y+=BasePoint.y;

				pTempLine->pt2.x*=xScale;
				pTempLine->pt2.y*=yScale;
				pTempLine->pt2.x+=BasePoint.x; 
				pTempLine->pt2.y+=BasePoint.y;
				return pTempLine;
				break;
			}
	}	
}

ADPOINT CADGraphics::Rotate(ADPOINT BasePoint,ADPOINT adPoint,double rotation)
{
	ADPOINT tempPoint;
	tempPoint.x=BasePoint.x+adPoint.x*cos(rotation*PI/180)-adPoint.y*sin(rotation*PI/180);
	tempPoint.y=BasePoint.y+adPoint.x*sin(rotation*PI/180)+adPoint.y*cos(rotation*PI/180);
	return tempPoint;
}

ADPOINT CADGraphics::Rotate2(ADPOINT BasePoint,ADPOINT adPoint,double Rotation)
{
	double dx=adPoint.x-BasePoint.x;
	double dy=adPoint.y-BasePoint.y;
	ADPOINT tempPoint;
	tempPoint.x=BasePoint.x+dx*cos(Rotation*PI/180)-dy*sin(Rotation*PI/180);
	tempPoint.y=BasePoint.y+dx*sin(Rotation*PI/180)+dy*cos(Rotation*PI/180);
	return tempPoint;
}

CPoint CADGraphics::Rotate(CPoint BasePoint,CPoint Point,double Rotation)
{
	int dx,dy;
	dx=Point.x-BasePoint.x;
	dy=Point.y-BasePoint.y;
	CPoint tempPoint;
	tempPoint.x=(long)(BasePoint.x+dx*cos(Rotation*PI/180)-dy*sin(Rotation*PI/180));
	tempPoint.y=(long)(BasePoint.y+dx*sin(Rotation*PI/180)+dy*cos(Rotation*PI/180));
	return tempPoint;
}

void CADGraphics::SetMText(CADMText* pMText,LPCTSTR str)
{
	char* pdest;
	pdest=strstr(str,"{\\f");

	if(pdest == NULL)
	{
		char* pdest2;
		pdest2=strstr(str,";");
		if(pdest2 == NULL)
		  	return;
		int  length=strlen(str)-(pdest2-str-1);
		char* ch=new char[length+1];
		memcpy(ch,pdest2+1,length);
		ch[length]='\0';
		pMText->m_Text=ch;
      	return;
	}

	char* pdest2;
	pdest2=strstr(str,"|");
	if(pdest2 == NULL)
      	return;

	int  length;
	length=pdest2-pdest-3;

	char* ch=new char[length+1];
	memcpy(ch,pdest+3,length);
	ch[length]='\0';
	strcpy(pMText->m_Font,ch);

	pdest=strstr(str,";");
	if(pdest == NULL)
      	return;
	pdest2=strstr(str,"}");
	if(pdest2 == NULL)
      	return;
	length=pdest2-pdest-1;
	char* ch2=new char[length+1];
	memcpy(ch2,pdest+1,length);
	ch2[length]='\0';
	pMText->m_Text=ch2;
	pMText->m_Text.Replace("\\P","\n");
	//strcpy((char*)(LPCTSTR)adText->m_Text,ch2);
}

CRect CADGraphics::GetPolylineBound(CPoint* points,int pointCount)
{	
	CRect bounds(points[0], CSize(0, 0));
	for (int i = 0; i < pointCount; ++i)
	{
		if (points[i].x < bounds.left)
			bounds.left = points[i].x;
		if (points[i].x > bounds.right)
			bounds.right = points[i].x;
		if (points[i].y < bounds.top)
			bounds.top = points[i].y;
		if (points[i].y > bounds.bottom)
			bounds.bottom = points[i].y;
	}
	return bounds;
}

CRect CADGraphics::GetLineBound(CPoint point1,CPoint point2)
{
	CRect bounds(point1, CSize(0, 0));
	if (point2.x < bounds.left)
		bounds.left = point2.x;
	if (point2.x > bounds.right)
		bounds.right = point2.x;
	if (point2.y < bounds.top)
		bounds.top = point2.y;
	if (point2.y > bounds.bottom)
		bounds.bottom = point2.y;
	return bounds;	
}

COLORREF CADGraphics::GetEntityColor(CADEntity* pEntity)
{
	CADLayer* pLayer;
	pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
	if(pLayer==NULL)return RGB(255,255,255);
	if(pLayer->m_nColor<0)return RGB(255,255,255);

	if(pEntity->m_nColor<0)
		return GetColor(pLayer->m_nColor);
	else
		return GetColor(pEntity->m_nColor);
}

CRect CADGraphics::GetMTextRect(const CADMText* pMText)
{
	ADSIZE adSize;
	adSize.cx=0;
	adSize.cy=pMText->m_Height;
	CSize size;
	size=DocToClient(adSize);

	LOGFONT logfont;
	strcpy(logfont.lfFaceName,pMText->m_Font);
	logfont.lfWeight=FW_REGULAR;
	logfont.lfWidth=0;
	logfont.lfHeight=size.cy;
	logfont.lfItalic=FALSE;
	logfont.lfOrientation=0;
	logfont.lfEscapement=0;
	logfont.lfUnderline=FALSE;
	logfont.lfStrikeOut=FALSE;
	logfont.lfOutPrecision=OUT_TT_PRECIS;
	logfont.lfCharSet=DEFAULT_CHARSET;
	logfont.lfOutPrecision=OUT_DEFAULT_PRECIS; 
	logfont.lfPitchAndFamily=FF_MODERN|DEFAULT_PITCH;

	CDC* pDC=m_pDisplay->GetDC();
	CSize textSize;
	textSize.cx=0;
	textSize.cy=0;

	CFont font;
	if (!font.CreateFontIndirect(&logfont))
		return 0;
    CFont *pOldFont=(CFont *)pDC->SelectObject(&font);
	short lineCount=1;
	int strlen=pMText->m_Text.GetLength(); 
	char* str=new char[strlen+1];
	strcpy(str,pMText->m_Text);
	lineCount+=GetCharCount(str,'\n');
	char* pszTemp = strtok(str, "\n");
	while(pszTemp)
	{
		//lineCount++;
		CSize sz=pDC->GetTextExtent(pszTemp);
		if(textSize.cx<sz.cx)
			textSize.cx=sz.cx;
		pszTemp=strtok(NULL, "\n");
	}
	delete str;
	//CSize sz=pDC->GetTextExtent(pMText->m_Text);
	//textSize.cx=sz.cx;

	TEXTMETRIC TM;
	pDC->GetTextMetrics(&TM);
    textSize.cy=TM.tmHeight;
    //textSize.cy=TM.tmHeight+TM.tmExternalLeading;
    textSize.cy*=lineCount;
    pDC->SelectObject(pOldFont);

	//DeleteDC(pDC->m_hDC);

	CPoint point1,pointOrigin;
	pointOrigin=DocToClient(pMText->m_Location);

	char align=pMText->m_Align; 
	switch(align)
	{
		case AD_MTEXT_ATTACH_TOPLEFT:
			point1.x=pointOrigin.x;
			point1.y=pointOrigin.y;
			break;
		case AD_MTEXT_ATTACH_TOPCENTER:
			point1.x=pointOrigin.x-textSize.cx/2;
			point1.y=pointOrigin.y;
			break;
		case AD_MTEXT_ATTACH_TOPRIGHT:
			point1.x=pointOrigin.x-textSize.cx;
			point1.y=pointOrigin.y;
			break;
		case AD_MTEXT_ATTACH_MIDDLELEFT:
			point1.x=pointOrigin.x;
			point1.y=pointOrigin.y-textSize.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLECENTER:
			point1.x=pointOrigin.x-textSize.cx/2;
			point1.y=pointOrigin.y-textSize.cy/2;
			break;
		case AD_MTEXT_ATTACH_MIDDLERIGHT:
			point1.x=pointOrigin.x-textSize.cx;
			point1.y=pointOrigin.y-textSize.cy/2;
			break;
		case AD_MTEXT_ATTACH_BOTTOMLEFT:
			point1.x=pointOrigin.x;
			point1.y=pointOrigin.y-textSize.cy;
			break;
		case AD_MTEXT_ATTACH_BOTTOMCENTER:
			point1.x=pointOrigin.x-textSize.cx/2;
			point1.y=pointOrigin.y-textSize.cy;
			break;
		case AD_MTEXT_ATTACH_BOTTOMRIGHT:
			point1.x=pointOrigin.x-textSize.cx;
			point1.y=pointOrigin.y-textSize.cy;
			break;
		default:
			point1.x=pointOrigin.x;
			point1.y=pointOrigin.y;
	}	
	return CRect(point1,textSize);
}

CPoint	CADGraphics::RightAngleCorrect(CPoint begin, CPoint end)
{
	if(abs(begin.x - end.x) < abs(begin.y - end.y))
	{
		return CPoint(begin.x,end.y);
	}
	else
	{
		return CPoint(end.x,begin.y);
	}
}

ADPOINT	CADGraphics::RightAngleCorrect(ADPOINT begin, ADPOINT end)
{
	ADPOINT pt;
	if ((fabs(begin.x - end.x)) < (fabs(begin.y - end.y)))
	{
		pt.x = begin.x;
		pt.y = end.y;
	}
	else
	{
		pt.x = end.x;
		pt.y = begin.y;
	}
	return pt;
}

short CADGraphics::GetLineWidth(CADEntity* pEntity)
{
	if(m_GraphicsMode==Printing || m_bBlack)
	{
		return pEntity->m_nLineWidth*m_LineWidthFactor;		
	}
	else
	{
		if(m_bLineWidth)
			return pEntity->m_nLineWidth;
	}
	return 1;
}

bool CADGraphics::CaptureHole(CPoint point,ADPOINT* pPoint)
{
	int i=m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME);
	if(i==-1)return false;
	for(i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity;
		pEntity=(CADEntity*)m_Entities.GetAt(i);
		if(pEntity->GetType()!=AD_ENT_INSERT)continue;
		if(pEntity->m_nLayer<0)continue;
		CADLayer* pLayer;
		pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		if(pLayer==NULL)continue;
		if(pLayer->m_nColor<0)continue;
		if(strcmp(pLayer->m_Name,PROJECTHOLELAYERNAME)!=0)continue;

		CADInsert* pInsert=(CADInsert*)pEntity;
		CPoint ptCenter=DocToClient(pInsert->pt);
		//int radius=DocToClient(10*PaperScale/1000);
		int radius = 15;
		if(isInCircle(point,ptCenter,radius))
		{
			*pPoint=pInsert->pt;
			return true;
		}
	}
	return false;
}

void CADGraphics::CreateSection(CADPolyline* pPolyline,int PaperScale,LPCTSTR name)
{
	short curLayerIndex = m_pLayerGroup->indexOf(PROJECTHOLELAYERNAME); 
	pPolyline->m_nLayer = curLayerIndex;
	m_Entities.Add((CObject*)pPolyline);

	ADPOINT adPt1,adPt2,adPt3;
	ADPOINT adPtO;
	ADPOINT* pPoint;
	CADLine* pLine;
	CADMText* pMText;
	double angle;

	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(1);  
	adPt1 = *pPoint;
	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(0);  
	adPt2 = *pPoint;

	angle=angleBetween2Pt(adPt1.x,adPt1.y,adPt2.x,adPt2.y);

	float sectionLineWidth = 3;
	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer = curLayerIndex;
	pLine->m_nLineWidth = sectionLineWidth;
	pLine->pt1.x=adPt2.x;
	pLine->pt1.y=adPt2.y;
	pLine->pt2.x=adPt2.x+6*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPt2.y+6*sin(angle*PI/180)*PaperScale/1000;

/*	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("×ê¿×Í¼Àý");
	pLine->pt1.x=adPt2.x+4*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt1.y=adPt2.y+4*sin(angle*PI/180)*PaperScale/1000;
	pLine->pt2.x=adPt2.x+6*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPt2.y+6*sin(angle*PI/180)*PaperScale/1000;*/

	adPt3.x=adPt2.x+7*cos(angle*PI/180)*PaperScale/1000;
	adPt3.y=adPt2.y+7*sin(angle*PI/180)*PaperScale/1000;

	adPtO=pLine->pt2;
	double angle1,angle2;
	angle1=angle+90;
	angle2=angle-90;

	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->m_nLineWidth = sectionLineWidth;
	pLine->pt1.x=adPtO.x+2*cos(angle2*PI/180)*PaperScale/1000;
	pLine->pt1.y=adPtO.y+2*sin(angle2*PI/180)*PaperScale/1000;
	pLine->pt2.x=adPtO.x+2*cos(angle1*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPtO.y+2*sin(angle1*PI/180)*PaperScale/1000;

	float fontHeight = 3.5*PaperScale/1000;
	pMText=new CADMText();
	m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;
	pMText->m_Location=adPt3;
	pMText->m_Text=name;
	strcpy(pMText->m_Font,"ºÚÌå");
	if ((angle>-360 && angle<-270) || (angle>0 && angle<90))
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;	
	else if ((angle>-270 && angle<-180) || (angle>90 && angle<180))
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMRIGHT;
	else if ((angle>-180 && angle<-90) || (angle>180 && angle<270)) 
		pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	else if ((angle>-90 && angle<0) || (angle>270 && angle<360))
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	
	if (angle == 0 || angle == -360)
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	else if (angle == 90 || angle == -270)
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	else if (angle == 180 || angle == -180)
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
	else if (angle == 270 || angle == -90)
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;
	
	pMText->m_Height = fontHeight;
	//pMText->m_ptDir.x=adPt1.x-adPt2.x;
	//pMText->m_ptDir.y=adPt1.y-adPt2.y;
//================================================
	int size=pPolyline->m_Point.GetSize(); 
	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(size-2);  
	adPt1=*pPoint;
	pPoint=(ADPOINT*)pPolyline->m_Point.GetAt(size-1);  
	adPt2=*pPoint;

	angle=angleBetween2Pt(adPt1.x,adPt1.y,adPt2.x,adPt2.y);

	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->m_nLineWidth = sectionLineWidth;
	pLine->pt1.x=adPt2.x;
	pLine->pt1.y=adPt2.y;
	pLine->pt2.x=adPt2.x+6*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPt2.y+6*sin(angle*PI/180)*PaperScale/1000;
/*	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=m_pLayerGroup->indexOf("×ê¿×Í¼Àý");
	pLine->pt1.x=adPt2.x+4*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt1.y=adPt2.y+4*sin(angle*PI/180)*PaperScale/1000;
	pLine->pt2.x=adPt2.x+6*cos(angle*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPt2.y+6*sin(angle*PI/180)*PaperScale/1000;*/

	adPtO=pLine->pt2;

	angle1=angle+90;
	angle2=angle-90;

	pLine=new CADLine();
	m_Entities.Add((CObject*)pLine);
	pLine->m_nLayer=curLayerIndex;
	pLine->m_nLineWidth = sectionLineWidth;
	pLine->pt1.x=adPtO.x+2*cos(angle2*PI/180)*PaperScale/1000;
	pLine->pt1.y=adPtO.y+2*sin(angle2*PI/180)*PaperScale/1000;
	pLine->pt2.x=adPtO.x+2*cos(angle1*PI/180)*PaperScale/1000;
	pLine->pt2.y=adPtO.y+2*sin(angle1*PI/180)*PaperScale/1000;

	pMText=new CADMText();
	m_Entities.Add((CObject*)pMText);
	pMText->m_nLayer=curLayerIndex;

	if ((angle>-360 && angle<-270) || (angle>0 && angle<90))
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMLEFT;	
	else if ((angle>-270 && angle<-180) || (angle>90 && angle<180))
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMRIGHT;
	else if ((angle>-180 && angle<-90) || (angle>180 && angle<270)) 
		pMText->m_Align=AD_MTEXT_ATTACH_TOPRIGHT;
	else if ((angle>-90 && angle<0) || (angle>270 && angle<360))
		pMText->m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	
	if (angle == 0 || angle == -360)
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLELEFT;
	else if (angle == 90 || angle == -270)
		pMText->m_Align=AD_MTEXT_ATTACH_BOTTOMCENTER;
	else if (angle == 180 || angle == -180)
		pMText->m_Align=AD_MTEXT_ATTACH_MIDDLERIGHT;
	else if (angle == 270 || angle == -90)
		pMText->m_Align=AD_MTEXT_ATTACH_TOPCENTER;

	pMText->m_Location=adPtO;
	pMText->m_Text=name;
	strcpy(pMText->m_Font,"ºÚÌå");
	pMText->m_Text=pMText->m_Text+"'";
	pMText->m_Height = fontHeight;
	//pMText->m_ptDir.x=adPt2.x-adPt1.x;
	//pMText->m_ptDir.y=adPt2.y-adPt1.y;
//================================================
}

bool CADGraphics::CreatePenStyle(CDC* pDC,CADEntity* pEntity)
{
	short penWidth=1;
	penWidth=GetLineWidth(pEntity);
	CADLType* pLType;
	CADLayer* pLayer;
	short index;
	if(pEntity->m_LTypeName)
	{
		index=IndexOfLTypes(pEntity->m_LTypeName);
	}
	else
	{
		pLayer=m_pLayerGroup->GetLayer(pEntity->m_nLayer);
		index=IndexOfLTypes(pLayer->m_LTypeName);
	}

	if(m_pPen)delete m_pPen;
	m_pPen=new CPen();

	if(index==-1)
	{
		if (!m_pPen->CreatePen(PS_SOLID,penWidth, GetEntityColor(pEntity)))
			return false;
		m_pOldPen=pDC->SelectObject(m_pPen);
		return true;
	}

	pLType=(CADLType*)m_LTypes.GetAt(index);

	if(pLType->m_ItemCount==0)
	{
		if (!m_pPen->CreatePen(PS_SOLID,penWidth, GetEntityColor(pEntity)))
			return false;
		m_pOldPen=pDC->SelectObject(m_pPen);
	}
	else
	{
		unsigned long* a=new unsigned long[pLType->m_ItemCount];
		for(int m=0;m<pLType->m_ItemCount;m++)
		{
			if(pLType->m_Items[m]==0)
				a[m]=1;
			else
			{
				a[m]=DocToClient(fabs(pLType->m_Items[m]*pEntity->m_LTypeScale));
			}
		}
		LOGBRUSH logBrush;
		logBrush.lbColor = GetEntityColor(pEntity);
		logBrush.lbHatch = 0;
		logBrush.lbStyle = BS_SOLID;
		if(!m_pPen->CreatePen(PS_GEOMETRIC|PS_USERSTYLE|PS_ENDCAP_SQUARE,1,&logBrush,pLType->m_ItemCount,a))return false;
		m_pOldPen=pDC->SelectObject(m_pPen);
	}
	return true;
}

void CADGraphics::CreateHandle(char* handle)
{
	long i=Change(m_curHandle);
	i+=1;
	CString str;
	str.Format("%X",i);
	strcpy(handle,(LPCTSTR)str);
	strcpy(m_curHandle,handle);
}

void CADGraphics::CreateDefaultLayer()
{
//create defaule tables section===============================
//TAB_LTYPE
	CADLType* pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"ByBlock");
	strcpy(pLType->m_Handle,"14");

	pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"ByLayer");
	strcpy(pLType->m_Handle,"15");

	pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"CONTINUOUS");
	strcpy(pLType->m_Handle,"16");
//------------------------------------------------------
//TAB_LAYER
	CADLayer* pLayer;
	pLayer=new CADLayer();
	m_pLayerGroup->AddLayer(pLayer);
	strcpy(pLayer->m_Name,"0");
	pLayer->m_nColor=AD_COLOR_WHITE;
	strcpy(pLayer->m_LTypeName,"CONTINUOUS"); 
	strcpy(pLayer->m_Handle,"10");
}

void CADGraphics::CreateDefault()
{
//create defaule tables section===============================
//TAB_LTYPE
	CADLType* pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"ByBlock");
	strcpy(pLType->m_Handle,"14");

	pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"ByLayer");
	strcpy(pLType->m_Handle,"15");

	pLType=new CADLType();
	m_LTypes.Add((CObject*)pLType);
	strcpy(pLType->m_Name,"CONTINUOUS");
	strcpy(pLType->m_Handle,"16");
//------------------------------------------------------
//TAB_LAYER
	CADLayer* pLayer;
	pLayer=new CADLayer();
	m_pLayerGroup->AddLayer(pLayer);
	strcpy(pLayer->m_Name,"0");
	pLayer->m_nColor=AD_COLOR_WHITE;
	strcpy(pLayer->m_LTypeName,"CONTINUOUS"); 
	strcpy(pLayer->m_Handle,"10");
//----------------------------------------------------------
//TAB_BLOCKRECORD

	CADBlockRecord* pBlockRecord;
	pBlockRecord=new CADBlockRecord();
	m_BlockRecords.Add((CObject*)pBlockRecord);
	strcpy(pBlockRecord->m_Name,"*Model_Space"); 
	strcpy(pBlockRecord->m_Handle,"1F");

	pBlockRecord=new CADBlockRecord();
	m_BlockRecords.Add((CObject*)pBlockRecord);
	strcpy(pBlockRecord->m_Name,"*Paper_Space"); 
	strcpy(pBlockRecord->m_Handle,"1B");

	pBlockRecord=new CADBlockRecord();
	m_BlockRecords.Add((CObject*)pBlockRecord);
	strcpy(pBlockRecord->m_Name,"*Paper_Space0"); 
	strcpy(pBlockRecord->m_Handle,"23");
//============================================================

//create defaule blocks section===============================
	CADBlock* pBlock;
	pBlock=new CADBlock();
	m_Blocks.Add((CObject*)pBlock);
	strcpy(pBlock->m_Name,"*Model_Space"); 
	strcpy(pBlock->m_Handle,"20"); 
	int i=m_pLayerGroup->indexOf("0");
	pBlock->m_nLayer=i;
	strcpy(pBlock->m_Handle2,"21"); 

	pBlock=new CADBlock();
	m_Blocks.Add((CObject*)pBlock);
	strcpy(pBlock->m_Name,"*Paper_Space");
	strcpy(pBlock->m_Handle,"1C"); 
	i=m_pLayerGroup->indexOf("0");
	pBlock->m_nLayer=i;
	strcpy(pBlock->m_Handle2,"1D"); 

	pBlock=new CADBlock();
	m_Blocks.Add((CObject*)pBlock);
	strcpy(pBlock->m_Name,"*Paper_Space0");
	strcpy(pBlock->m_Handle,"24"); 	
	i=m_pLayerGroup->indexOf("0");
	pBlock->m_nLayer=i;
	strcpy(pBlock->m_Handle2,"25"); 
//============================================================
}

void CADGraphics::RemoveAll()
{
	for (int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)(m_Entities.GetAt(i));
		delete pEntity;
		m_Entities.SetAt(i,NULL);
	}
	m_Entities.RemoveAll();	
}