#include "stdafx.h"
#include "ADEntities.h"
#include "ADGraphics.h"

CADEntity::CADEntity()
{
	m_nColor = -1;
	m_nLayer = -1;
	m_nLineWidth = 1;
	m_LTypeName = NULL;
	m_LTypeScale = 1.0;
	if(CADGraphics::isCreateHandle)
		CADGraphics::CreateHandle(m_Handle);
}

CADEntity::~CADEntity()
{
	if (m_LTypeName != NULL)delete[] m_LTypeName;
}

void CADEntity::operator=(CADEntity& Entity)
{
	//CADEntity temp;
	/*this->m_nType=Entity.m_nType;
	this->m_nLayer=Entity.m_nLayer;
	this->m_nColor=Entity.m_nColor;*/
	//return temp;
}

//----------------------------------------------------------
//IMPLEMENT_DYNCREATE(CADPoint,CObject)

CADPoint::CADPoint()
{
	m_nType=AD_ENT_POINT;
}

CADPoint::~CADPoint()
{
}
//----------------------------------------------------------
//IMPLEMENT_DYNCREATE(CADLine,CObject)

CADLine::CADLine()
{
	m_nType=AD_ENT_LINE;
}

CADLine::~CADLine()
{
}
/*
void CADLine::operator=(CADLine& adLine)
{
	pt1=adLine.pt1;
	pt2=adLine.pt2;
	CADEntity::operator =(adLine); 
}
*/
void CADLine::GetCenter(ADPOINT* ptCenter)
{
	ptCenter->x=pt1.x+(pt2.x-pt1.x)/2;
	ptCenter->y=pt1.y+(pt2.y-pt1.y)/2;
}

//----------------------------------------------------------
//IMPLEMENT_DYNCREATE(CADRectangle,CObject)

CADRectangle::CADRectangle()
{
	left = 0;
	right = 0;
	top = 0;
	bottom = 0;	
}

CADRectangle::~CADRectangle()
{
}

CADRectangle::CADRectangle(double x1, double y1, double x2, double y2)
{
	left=(x1>x2)?x2:x1;
	right=(x1>x2)?x1:x2;
	bottom=(y1>y2)?y2:y1;
	top=(y1>y2)?y1:y2;
}

double CADRectangle::GetWidth()
{
	return fabs(right-left);
}

double CADRectangle::GetHeight()
{
	return fabs(top-bottom);
}

void CADRectangle::SetRect(double x1, double y1, double x2, double y2)
{
	left=(x1>x2)?x2:x1;
	right=(x1>x2)?x1:x2;
	bottom=(y1>y2)?y2:y1;
	top=(y1>y2)?y1:y2;
}

void CADRectangle::SetRect(CADRectangle *pRect)
{
	SetRect(pRect->left,pRect->bottom,pRect->right,pRect->top);
}

bool CADRectangle::IsIntersects(CADRectangle *pRect)
{
	bool Res = true;
	if (this->left>pRect->right) 
				Res = false;
			else
				if (this->right<pRect->left) 
					Res = false;
				else
					if (this->bottom>pRect->top) 
						Res = false;
					else
						if (this->top<pRect->bottom) 
							Res = false;
	return Res;
}

void CADRectangle::Union(CADRectangle *pRect)
{
	if (!pRect) return;
	left = left<pRect->left?left:pRect->left;
	right = right>pRect->right?right:pRect->right;
	top = top>pRect->top?top:pRect->top;
	bottom = bottom<pRect->bottom?bottom:pRect->bottom;
}

bool CADRectangle::IsEmpty()
{
	if(GetHeight()&&GetWidth()) return false;
	return true;
}

void CADRectangle::Offset(double x, double y)
{
	left=left+x;
	right=right+x;
	top=top+y;
	bottom=bottom+y;
}

void CADRectangle::SetCenter(double x, double y)
{
	double cx = x-(right+left)/2.0;
	double cy = y-(top+bottom)/2.0;
	left=left+cx;
	right=right+cx;
	top=top+cy;
	bottom=bottom+cy;
}

void CADRectangle::Scale(double rate)
{
	double cx = GetWidth()*(1.0-rate)/2.0;
	double cy = GetHeight()*(1.0-rate)/2.0;
	left=left+cx;
	right=right-cx;
	top=top-cy;
	bottom=bottom+cy;
}

bool CADRectangle::IsPointInside(double x, double y)
{
	bool res = false;
	if (x>left&&x<right&&y>bottom&&y<top) res=true;
	return res;
}

void CADRectangle::Union(double x1, double y1, double x2, double y2)
{
	left = left<x1?left:x1;
	right = right>x2?right:x2;
	top = top>y2?top:y2;
	bottom = bottom<y1?bottom:y1;
}

ADPOINT* CADRectangle::GetCenter()
{
	ADPOINT* pCenter = new ADPOINT();
	pCenter->x = (left+right)/2.0;
	pCenter->y = (bottom+top)/2.0;
	return pCenter;
}
//----------------------------------------------------------
//IMPLEMENT_DYNCREATE(CADPolyline,CObject)

CADPolyline::CADPolyline()
{
	m_Closed=false;
	m_nType=AD_ENT_POLYLINE;
	m_pElevation=NULL;
}

CADPolyline::~CADPolyline()
{
	if (m_pElevation != NULL)delete m_pElevation;
	for (int i=0;i<m_Point.GetSize();i++)
	{
		//CADPoint* pPoint = (CADPoint*)m_Point.GetAt(i);
		ADPOINT* pPoint = (ADPOINT*)m_Point.GetAt(i);
		m_Point[i] = NULL;
		if (pPoint != NULL)
			delete pPoint;
	}
	m_Point.RemoveAll();
}
/*
void CADPolyline::operator=(CADPolyline& adPolylines)
{
	int i;
	for(i=0;i<adPolylines.m_Point.GetSize();i++)
	{
		
	}
}
*/
void CADPolyline::GetBound(CADRectangle* bound)
{
	for(int i=0;i<m_Point.GetSize();i++)
	{
		ADPOINT* pPoint=(ADPOINT*)m_Point.GetAt(i);
		if(i==0)
		{
			bound->left=pPoint->x;
			bound->top=pPoint->y;
			bound->right=pPoint->x;
			bound->bottom=pPoint->y;
		}
		else
		{
			if(bound->left>pPoint->x)bound->left=pPoint->x;
			if(bound->top>pPoint->y)bound->top=pPoint->y;
			if(bound->right<pPoint->x)bound->right=pPoint->x;
			if(bound->bottom<pPoint->y)bound->bottom=pPoint->y;
		}
	}	
}
//----------------------------------------------------------
CADArc::CADArc()
{
	m_nType=AD_ENT_ARC;
} 

CADArc::~CADArc()
{
}
//----------------------------------------------------------
CADCircle::CADCircle()
{
	m_nType=AD_ENT_CIRCLE;
} 

CADCircle::~CADCircle()
{
}
//----------------------------------------------------------
CADEllipse::CADEllipse()
{
	m_nType=AD_ENT_ELLIPSE;
} 

CADEllipse::~CADEllipse()
{
}
//----------------------------------------------------------
CADSpline::CADSpline()
{
	m_Closed=false;
	m_nType=AD_ENT_SPLINE;
	m_NumKnot = 0;
	m_NumControl = 0;
	m_NumFit = 3;
	m_pKnotPoints = NULL;

	m_bNode = false;
	m_NodeRadius = 1.0;
} 

CADSpline::~CADSpline()
{
	if (m_pKnotPoints != NULL)delete[] m_pKnotPoints;
	for (int i=0;i<m_ControlPoint.GetSize();i++)
	{
		ADPOINT* pPoint = (ADPOINT*)m_ControlPoint.GetAt(i);
		if (pPoint != NULL)
			delete pPoint;
	}
	m_ControlPoint.RemoveAll();
	for (i=0;i<m_FitPoint.GetSize();i++)
	{
		ADPOINT* pPoint = (ADPOINT*)m_FitPoint.GetAt(i);
		if (pPoint != NULL)
			delete pPoint;
	}
	m_FitPoint.RemoveAll();
}
//----------------------------------------------------------
//IMPLEMENT_DYNCREATE(CADMText,CObject)

CADMText::CADMText()
{
	m_ptDir.x=1;
	m_ptDir.y=0;
	strcpy(m_Font,"");
	m_Align=AD_MTEXT_ATTACH_TOPLEFT;
	m_nType=AD_ENT_MTEXT;
	m_isWarp = false;
	m_Interval = 0.84;
}

CADMText::~CADMText()
{
}
//----------------------------------------------------------
CADText::CADText()
{
	m_Angle=0.0;
	strcpy(m_Font,"");
	m_nType=AD_ENT_TEXT;
	strcpy(m_StyleName,"Standard");
}

CADText::~CADText()
{
}
//----------------------------------------------------------
CADStyle::CADStyle()
{
	
}

CADStyle::~CADStyle()
{
}
//----------------------------------------------------------
CADLType::CADLType()
{
	m_ItemCount=0;
	m_Items=NULL;
}

CADLType::~CADLType()
{
}
//----------------------------------------------------------
CADInsert::CADInsert()
{
	m_xScale=1.0;
	m_yScale=1.0;
	m_Rotation=0.0;
	m_nType=AD_ENT_INSERT;
}

CADInsert::~CADInsert()
{

}
//----------------------------------------------------------

CADBlock::CADBlock()
{
	m_nType=AD_ENT_BLOCK;
	m_BasePoint.x = 0.0;
	m_BasePoint.y = 0.0;

//	if(CADGraphics::isCreateHandle)
		CADGraphics::CreateHandle(m_Handle2);
}

CADBlock::~CADBlock()
{
	for (int i=0;i<m_Entities.GetSize();i++)
	{
		CADEntity* pEntity = (CADEntity*)(m_Entities.GetAt(i));
		delete pEntity;
		m_Entities.SetAt(i,NULL);
	}
	m_Entities.RemoveAll();
}
//----------------------------------------------------------

CADSolid::CADSolid()
{
	m_nType=AD_ENT_SOLID;
}

CADSolid::~CADSolid()
{
}
//----------------------------------------------------------

CADHatch::CADHatch()
{
	m_pPolyline=NULL;
	m_bSolidFill=false;
	m_nType=AD_ENT_HATCH;
	m_SeedPoint.x=0.0;
	m_SeedPoint.y=0.0;
	m_HatchLines.SetSize(0);
	m_Paths.SetSize(0);
	m_Scale=1.0;
}

CADHatch::~CADHatch()
{
}
//----------------------------------------------------------