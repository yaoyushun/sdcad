#include "stdafx.h"
#include "Function_Graphics.h"
#include <math.h>

//cal radian of two points(radian)
double radianBetween2Pt(double x1,double y1,double x2,double y2)
{
	// x1,y1 is origin	
	double dx1 = atan2((y2 - y1),(x2 - x1));
	return dx1;
}

//cal angle of two points(angle)
double angleBetween2Pt(double x1,double y1,double x2,double y2)
{
	// x1,y1 is origin	
	double dx1 = atan2((y2 - y1),(x2 - x1));
	double angle= dx1;
	angle=angle*180/PI;
	return angle;
}

//cal radian of two lines(radian)
//(x1,y1) is vertex
double radianBetween3Pt(double x1,double y1,double x2,double y2,double x3,double y3)
{
	// x1,y1 is origin	
	double dx1 = atan2((y2 - y1),(x2 - x1));
	double dx2 = atan2((y3 - y1),(x3 - x1));
	return dx1 - dx2;
}

//cal angle of two lines(angle)
double angleBetween3Pt(double x1,double y1,double x2,double y2,double x3,double y3)
{
	// x1,y1 is origin
	//x2,y2 is end;x1,y1 is start
	double dx1 = atan2((y2 - y1),(x2 - x1));
	double dx2 = atan2((y3 - y1),(x3 - x1));
	double angle= dx1 - dx2;
	if(angle>=0)
		angle=angle*180/PI;
	else
		angle=angle*180/PI+360;
	return angle;
}

//cal the center of circle and the radius of circle with 3 points
bool circle_3pnts(CPoint *p1, CPoint *p2, CPoint *p3, CPoint *cp,LONG *rad)
{ /* Circle_3pnts */

   double xdiff12, ydiff12; /*difference in x and y between pnts P1 and P2*/
   double xdiff13, ydiff13; /*difference in x and y between pnts P1 and P3*/
   double sdist12, sdist13; /*Distance squared between pnts P1 and P2/P3*/
   double det;              /*Determinate*/

   xdiff12 = p2->x - p1->x;
   ydiff12 = p2->y - p1->y;
   xdiff13 = p3->x - p1->x;
   ydiff13 = p3->y - p1->y;
   det = ydiff13 * xdiff12 - xdiff13 * ydiff12;
   if (det == 0)
     return false;
   else
   {
     det = 1.0 / (2 * det);
     sdist12 = xdiff12 * xdiff12 + ydiff12 * ydiff12;
     sdist13 = xdiff13 * xdiff13 + ydiff13 * ydiff13;
     cp->x = (LONG)(det * (sdist12 * ydiff13 - sdist13 * ydiff12));
     cp->y = (LONG)(det * (sdist13 * xdiff12 - sdist12 * xdiff13));
     *rad = (LONG)sqrt((cp->x * cp->x) + (cp->y * cp->y));
     cp->x = cp->x + p1->x;
     cp->y = cp->y + p1->y;
   }
   return true;
}

//judge the order of 3 points on circle 
bool  IsCounter(CPoint pt1,CPoint pt2,CPoint pt3)
{
	CPoint* ppt = new CPoint[3];
	ppt[0]=pt1;
	ppt[1]=pt2;
	ppt[2]=pt3;

	int n = 3;
#define	 ROUND	0.01
//#define	PI	3.1415926535897932384626433832795
	CPoint	*ptc, *ptb, *pta;
	int		i, j, k, l;
    double	kakudo1= 0.0 , kakudo2;
    double	x1, y1, x2, y2, a, b;
//	k = i == 0 ? n - 1 : i - 1;
	while(*ppt == *(ppt + n - 1))
    	n--;

	for(i = 0, k = n - 1, j = 0; i < n; i++, j++)
	{
    	l = i == n - 1 ? 0 : i + 1;
		ptc = (ppt + i);

		ptb = (ppt + k);
		while(*ptb == *ptc)
		{
		   k--;
		   ptb = (ppt + k);
		}

		if(k > i && k < l)
        	break;

        pta = (ppt + l);
        while(*pta == *ptc)
        {
		   l = l == n - 1 ? 0 : l + 1;
	       pta = (ppt + l);
        }
        if(l >= k && l < i)
	        break;

    	x1 = pta->x - ptc->x;
        y1 = pta->y - ptc->y;
		x2 = ptb->x - ptc->x;
        y2 = ptb->y - ptc->y;

		a = atan2(y1, x1);
        a = (a < 0 ? 2 * PI + a : a);
        b = atan2(y2, x2);
        b = (b < 0 ? 2 * PI + b : b);

        if(b > a)
        	b -= (2 * PI);

        kakudo1 = kakudo1 + (a - b);

        k = i;
	}

    kakudo2 = ((j - 2) * PI);
	delete ppt;
    if(kakudo1 > kakudo2 + ROUND)
    	return true;
    else
		return  false;
}

bool isSelectedArc(CPoint point,CPoint ptCenter,int radius,double startAngle,double endAngle)
{
	if(!isSelectedEllipse(point,ptCenter,radius,radius))return false;
	double angle;
	angle=angleBetween3Pt(ptCenter.x,ptCenter.y,ptCenter.x+100,ptCenter.y,point.x,point.y);
	if(startAngle<endAngle)
	{
		if(angle>startAngle && angle<endAngle)return true;
		else return false;
	}
	else
	{
		if(angle<endAngle || angle>startAngle)return true;
		else return false;
	}
}

bool isSelectedEllipse(CPoint point,CPoint ptCenter,int radius1,int radius2)
{
	CPoint FirstPoint;
	CPoint SecondPoint;
	FirstPoint.x=ptCenter.x-radius1;
	FirstPoint.y=ptCenter.y-radius2;
	SecondPoint.x=ptCenter.x+radius1;
	SecondPoint.y=ptCenter.y+radius2;

	CRgn rgn1;
	if(rgn1.CreateEllipticRgn(FirstPoint.x-4,FirstPoint.y-4,SecondPoint.x+4,SecondPoint.y+4)==0)return false;
    CRgn rgn2;
	if(rgn2.CreateEllipticRgn(FirstPoint.x+4,FirstPoint.y+4,SecondPoint.x-4,SecondPoint.y-4)==0)return false;

	return rgn1.PtInRegion(point)&&!rgn2.PtInRegion(point);
}

void Rotate(CPoint *pCenter, CPoint *pRes, short angle)
{
	if (!pCenter||!pRes) return;
	double a=((double)angle)*RPI;
	double x = pRes->x-pCenter->x;
	double y = pRes->y-pCenter->y;
	pRes->x = Round(x*cos(a)-y*sin(a))+pCenter->x;
	pRes->y = Round(x*sin(a)+y*cos(a))+pCenter->y;
}

int Round(double a)
{
	int res = 0;
	if (a<0)
		if (a-floor(a)<0.5)
			res = (int)a;
		else
			res = (int)a+1;
	else
	{
		a=-a;
		if (a-floor(a)<0.5)
			res = (int)a;
		else
			res = (int)a+1;
		res = -res;
	}
	return res;
}

//===========================================================
BOOL isSelectedLine(CPoint point,const CPoint point1,const CPoint point2)
{
	CRect fixed;
	fixed.left = point1.x;
	fixed.top = point1.y;
	fixed.right = point2.x;
	fixed.bottom = point2.y;
	fixed.NormalizeRect();

	POINT points[4];
	points[0].x=points[1].x=point1.x;
	points[0].y=points[1].y=point1.y;
	points[2].x=points[3].x=point2.x;
	points[2].y=points[3].y=point2.y;

	int change=1;
	if (fixed.bottom!=point2.y) change*=-1;
	if (fixed.left!=point1.x) change*=-1;
	
	const dx=3;
	const dy=3;

	points[0].x-=dx;
	points[1].x+=dx;
	points[2].x+=dx;
	points[3].x-=dx;

	if ((fixed.top - fixed.bottom)*change>=0)
	{
		points[0].y -= dy;
		points[1].y += dy;
		points[2].y += dy;
		points[3].y -= dy;
	}
	else
	{
		points[0].y += dy;
		points[1].y -= dy;
		points[2].y -= dy;
		points[3].y += dy;
	}
	CRgn rgn;
	if(rgn.CreatePolygonRgn(points, 4, WINDING)==0)return false;
	return rgn.PtInRegion(point);
}

BOOL isSelectedPoint(CPoint point,const CPoint point1)
{
	int dx=3;
	CRect rc;
	rc.left =point1.x-dx;
	rc.top =point1.y-dx;
	rc.right =point1.x+dx;
	rc.bottom =point1.y+dx;
	if(point.x > rc.left && point.x < rc.right &&
		point.y > rc.top && point.y < rc.bottom)
		return true;
	else
		return false;
}

BOOL isSelectedCircle(CPoint point,CPoint ptCenter,int radius)
{
	CPoint FirstPoint;
	CPoint SecondPoint;
	FirstPoint.x=ptCenter.x-radius;
	FirstPoint.y=ptCenter.y-radius;
	SecondPoint.x=ptCenter.x+radius;
	SecondPoint.y=ptCenter.y+radius;

	CRgn rgn1;
	if(rgn1.CreateEllipticRgn(FirstPoint.x-4,FirstPoint.y-4,SecondPoint.x+4,SecondPoint.y+4)==0)return 0;
    CRgn rgn2;
	if(rgn2.CreateEllipticRgn(FirstPoint.x+4,FirstPoint.y+4,SecondPoint.x-4,SecondPoint.y-4)==0)return 0;

	return rgn1.PtInRegion(point)&&!rgn2.PtInRegion(point);
}

BOOL isInCircle(CPoint point,CPoint ptCenter,int radius)
{
	CPoint FirstPoint;
	CPoint SecondPoint;
	FirstPoint.x=ptCenter.x-radius;
	FirstPoint.y=ptCenter.y-radius;
	SecondPoint.x=ptCenter.x+radius;
	SecondPoint.y=ptCenter.y+radius;

	CRgn rgn1;
	if(rgn1.CreateEllipticRgn(FirstPoint.x,FirstPoint.y,SecondPoint.x,SecondPoint.y)==0)return 0;
 	return rgn1.PtInRegion(point);
}

BOOL isInPolygon(CPoint point,CPoint* points,int pointCount)
{
	CRgn rgn;
	if(rgn.CreatePolygonRgn(points, pointCount, WINDING)==0)return 0;
 	return rgn.PtInRegion(point);
}

BOOL isSelectedPolyline(CPoint point,CPoint* points,int pointCount,bool isClosed)
{
	int j;		
	for(j=0;j<pointCount-1;j++)
	{
		if(isSelectedLine(point,points[j],points[j+1]))
			return true;
	}
	if(isClosed)
	{
		if(isSelectedLine(point,points[0],points[pointCount-1]))
			return true;
	}
	return false;
}

BOOL isSelectedRectangle(CPoint point,CRect rect)
{
	CRgn rgn;
	if(rgn.CreateRectRgn(rect.left,rect.top,rect.right,rect.bottom)==0)return 0;
	return rgn.PtInRegion(point);
}
/*
int Distance(CPoint point1,CPoint point2)
{
	return (int)(sqrt((point1.x-point2.x)*(point1.x-point2.x)+(point1.y-point2.y)*(point1.y-point2.y)));	
}*/
//==============================================================