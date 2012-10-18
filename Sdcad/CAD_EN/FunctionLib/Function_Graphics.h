#ifndef __GRAPHICSFUNCTION_H__
#define __GRAPHICSFUNCTION_H__

#include <math.h>

typedef struct
{
	double	x;
	double	y;
//	double	z;
}REALPOINT;

	#define	PI	3.1415926535897932384626433832795
	#define RPI 0.01745239;

	double angleBetween2Pt(double x1,double y1,double x2,double y2);
	double angleBetween3Pt(double x1,double y1,double x2,double y2,double x3,double y3);
	bool circle_3pnts(CPoint *p1, CPoint *p2, CPoint *p3, CPoint *cp,LONG *rad);
	bool  IsCounter(CPoint pt1,CPoint pt2,CPoint pt3);
	bool isSelectedArc(CPoint point,CPoint ptCenter,int radius,double startAngle,double endAngle);
	bool isSelectedEllipse(CPoint point,CPoint ptCenter,int radius1,int radius2);
	void Rotate(CPoint *pCenter, CPoint *pRes, short angle);
	int Round(double a);

//===========================================
	BOOL isSelectedLine(CPoint point,const CPoint point1,const CPoint point2);
	BOOL isSelectedPoint(CPoint point,const CPoint point1);
	BOOL isSelectedCircle(CPoint point,CPoint ptCenter,int radius);
	BOOL isSelectedPolyline(CPoint point,CPoint* points,int pointCount,bool isClosed);
	BOOL isSelectedRectangle(CPoint point,CRect rect);
	BOOL isInCircle(CPoint point,CPoint ptCenter,int radius);
	BOOL isInPolygon(CPoint point,CPoint* points,int pointCount);
///	int Distance(CPoint point1,CPoint point2);
//============================================

#endif