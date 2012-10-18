{******************************************}
{     TeeChart Pro Charting Library        }
{           TriSurface Series              }
{ Copyright (c) 1995-2004 by David Berneda }
{         All Rights Reserved              }
{******************************************}
unit TeeTriSurface;
{$I TeeDefs.inc}

// Adapted from Andre Bester's algorithm (anb@iafrica.com)

{ This unit implements the "Tri-Surface" charting series.

  A Tri-Surface is a 3D surface of triangles, automatically
  calculated from all XYZ points.

  All XYZ coordinates can have floating point decimals and
  can be expressed in any range.

  This series inherits all formatting properties like Pen,
  Brush, ColorRange and Palette from its ancestor class.

  Special properties:

    HideTriangles : Boolean ( default True )

      Triangles are ordered by Z position (hidding algorithm).
      When False, display speed might be faster but incorrect.

    CacheTriangles : Boolean ( default False )

      When True, triangles from XYZ data are just recalculated once
      instead of at every redraw.
      Set CacheTriangles to False after clearing or modifying XYZ data
      to force recalculating triangles.
}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, TeCanvas, TeeProcs, TeeSurfa;

Type
  {$IFNDEF CLR}
  PTriangle=^TTriangle;
  {$ELSE}
  TTriangle=class;
  PTriangle=TTriangle;
  {$ENDIF}
  TTriangle={$IFDEF CLR}class{$ELSE}packed record{$ENDIF}
    Index : Integer;
    Color : TColor;
    Next  : PTriangle;
    Prev  : PTriangle;
    P     : TTrianglePoints;
    Z     : Double;
  end;

  ETriSurfaceException=class(ChartException);

  TCustomTriSurfaceSeries=class(TCustom3DPaletteSeries)
  private
    { Private declarations }
    FBorder    : TChartHiddenPen;
    FFastBrush : Boolean;
    FHide      : Boolean;
    FTransp    : TTeeTransparency;

    FNumLines  : Integer;
    ICreated   : Boolean;
    IPT        : Array of Integer;
    IPL        : Array of Integer;
    Triangles  : PTriangle;
    ILastTriangle : PTriangle;

    {$IFNDEF CLX}
    DCBRUSH    : HGDIOBJ;
    CanvasDC   : TTeeCanvasHandle;
    {$ENDIF}

    Function CalcPointResult(Index:Integer):TPoint3D;
    Procedure ClearTriangles; // 7.0
    function IDxchg(I1,I2,I3,I4:Integer):Integer;
    Procedure SetBorder(Value:TChartHiddenPen);
    procedure SetFastBrush(const Value: Boolean);
    procedure SetHide(const Value: Boolean);
    Procedure SetTransp(Value:TTeeTransparency);
    Procedure TrianglePointsTo2D(const P:TTrianglePoints3D; Var Result:TeCanvas.TTrianglePoints);
  protected
    ImprovedTriangles : Boolean;

    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DoBeforeDrawValues; override;
    procedure DrawAllValues; override;
    Procedure DrawMark(ValueIndex:Integer; Const St:String;
                       APosition:TSeriesMarkPosition); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;

  public
    { Public declarations }
    CacheTriangles    : Boolean;
    NumTriangles      : Integer;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy;override;

    Procedure Assign(Source:TPersistent); override;
    Procedure Clear; override;
    Function Clicked(x,y:Integer):Integer; override;  // 7.0
    Function NumSampleValues:Integer; override;
    Function TrianglePoints(TriangleIndex:Integer):TTrianglePoints3D;  // 7.0

    property Border:TChartHiddenPen read FBorder write SetBorder;
    property Brush;
    property FastBrush:Boolean read FFastBrush write SetFastBrush default False;  // 7.0
    property HideTriangles:Boolean read FHide write SetHide default True;
    property Pen;
    property Transparency:TTeeTransparency read FTransp write SetTransp default 0;
  end;

  TTriSurfaceSeries=class(TCustomTriSurfaceSeries)
  published
    property Active;
    property ColorSource;
    property Cursor;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;

    property Border;
    property Brush;
    property EndColor;
    property FastBrush;
    property HideTriangles;
    property LegendEvery;
    property MidColor;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property TimesZOrder;
    property Transparency;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property OnGetColor;
  end;

implementation

Uses Math, TeeConst, TeeProCo;

{ TTriSurfaceSeries }
Constructor TCustomTriSurfaceSeries.Create(AOwner:TComponent);
begin
  inherited;
  FBorder:=TChartHiddenPen.Create(CanvasChanged);
  FBorder.Color:=clWhite;
  FHide:=True; { 5.02 }
  ImprovedTriangles:=True;
end;

Destructor TCustomTriSurfaceSeries.Destroy;
begin
  FBorder.Free;
  IPL:=nil;
  IPT:=nil;
  ClearTriangles;
  inherited;
end;

Procedure TCustomTriSurfaceSeries.ClearTriangles;
var Triangle : PTriangle;
    {$IFNDEF CLR}
    tmpTriangle : PTriangle;
    {$ENDIF}
begin
  Triangle:=Triangles;
  while Assigned(Triangle) do
  begin
    { free triangle memory }
    {$IFNDEF CLR}
    tmpTriangle:=Triangle;
    {$ENDIF}
    Triangle:=Triangle.Next;
    {$IFNDEF CLR}
    Dispose(tmpTriangle);
    {$ENDIF}
  end;
  Triangles:=nil;
end;

Function TCustomTriSurfaceSeries.Clicked(x,y:Integer):Integer; // 7.0
var t : Integer;
    tmp : TPoint;
    Triangle : PTriangle;
    P : TTrianglePoints;
begin
  result:=TeeNoPointClicked;
  tmp:=TeePoint(x,y);

  // If "hide triangles" mode, then use the list of calculated
  // triangles, from Last to First.
  if Assigned(ILastTriangle) then
  begin
    Triangle:=ILastTriangle;
    while Assigned(Triangle) do
    begin
      if PointInPolygon(tmp,Triangle.P) then
      begin
        result:=Triangle.Index;
        break;
      end;

      Triangle:=Triangle.Prev;
    end;
  end
  else
  // Search across 3D non-Z sorted list of triangles...
  begin
    for t:=1 to NumTriangles do
    begin
      TrianglePointsTo2D(TrianglePoints(t),P);

      if PointInPolygon(tmp,P) then
      begin
        result:=t;
        break;
      end;
    end;
  end;
end;

Function TCustomTriSurfaceSeries.NumSampleValues:Integer;
begin
  result:=15;
end;

Procedure TCustomTriSurfaceSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Const tmpRange  =    0.001;
      tmpRandom = 1000;
var t    : Integer;
    tmpX : Double;
    tmpZ : Double;
begin
  NumValues:=Max(NumValues,3);

  for t:=1 to NumValues do
  begin
    tmpX:=RandomValue(tmpRandom)*tmpRange;
    tmpZ:=RandomValue(tmpRandom)*tmpRange;
    AddXYZ(tmpX,Sqr(Exp(tmpZ))*Cos(tmpX*tmpZ),tmpZ);
  end;
end;

class Function TCustomTriSurfaceSeries.GetEditorClass:String;
begin
  result:='TTriSurfaceSeriesEditor'; { <-- dont translate ! }
end;

Procedure TCustomTriSurfaceSeries.SetBorder(Value:TChartHiddenPen);
begin
  FBorder.Assign(Value);
end;

function TCustomTriSurfaceSeries.IDxchg(I1,I2,I3,I4:Integer):Integer;
var x1,x2,x3,x4 : Double;
    y1,y2,y3,y4 : Double;
    u1,u2,u3,u4 : Double;
    A1,A2,B1,B2,
    C1,C2       : Double;
    S1,S2,S3,S4 : Double;
begin
  result:=0;
  x1:=XValues.Value[I1];
  y1:=ZValues.Value[I1];
  x2:=XValues.Value[I2];
  y2:=ZValues.Value[I2];
  x3:=XValues.Value[I3];
  y3:=ZValues.Value[I3];
  x4:=XValues.Value[I4];
  y4:=ZValues.Value[I4];

  u3:=(y2-y3)*(x1-x3)-(x2-x3)*(y1-y3);
  u4:=(y1-y4)*(x2-x4)-(x1-x4)*(y2-y4);
  if (u3*u4)>0 then
  begin
    u1:=(y3-y1)*(x4-x1)-(x3-x1)*(y4-y1);
    u2:=(y4-y2)*(x3-x2)-(x4-x2)*(y3-y2);

    A1:=sqr(x1-x3)+sqr(y1-y3);
    B1:=sqr(x4-x1)+sqr(y4-y1);
    C1:=sqr(x3-x4)+sqr(y3-y4);
    A2:=sqr(x2-x4)+sqr(y2-y4);
    B2:=sqr(x3-x2)+sqr(y3-y2);
    C2:=sqr(x2-x1)+sqr(y2-y1);

    S1:=Sqr(u1)/(C1*Math.Max(A1,B1));
    S2:=Sqr(u2)/(C1*Math.Max(A2,B2));
    S3:=Sqr(u3)/(C2*Math.Max(B2,A1));
    S4:=Sqr(u4)/(C2*Math.Max(B1,A2));

    if Math.Min(S1,S2) < Math.Min(S3,S4) then
          result:=1;
  end;
end;

procedure TCustomTriSurfaceSeries.DoBeforeDrawValues;

  Procedure CreateTriangles;
  Var NLT3 : Integer;
      ITF  : Array[1..2] of Integer;
      ipl1 : Integer;
      ipl2 : Integer;
      IPTI1: Integer;
      IPTI2: Integer;

    Procedure CalcBorder;
    var i    : Integer;
        JLT3 : Integer;
        IPLJ1: Integer;
        IPLJ2: Integer;
    begin
      for i:=1 to NLT3 div 3 do
      begin
        JLT3:=i*3;
        IPLJ1:=IPL[JLT3-2];
        IPLJ2:=IPL[JLT3-1];
        if ((IPLJ1=ipl1) and (IPLJ2=IPTI2)) or
           ((IPLJ2=ipl1) and (IPLJ1=IPTI2)) then
           IPL[JLT3]:=ITF[1];
        if ((IPLJ1=ipl2) and (IPLJ2=IPTI1)) or
           ((IPLJ2=ipl2) and (IPLJ1=IPTI1)) then
           IPL[JLT3]:=ITF[2];
      end;
    end;

    Var DSQMN : TChartValue;
        IPMN1 : Integer;
        IPMN2 : Integer;
        ip1   : Integer;
        ip2   : Integer;
        NDPM1 : Integer;
        xd1   : TChartValue;
        xd2   : TChartValue;
        yd1   : TChartValue;
        yd2   : TChartValue;
        NDP0  : Integer;
        DSQI  : Double;
     tmpCount : Integer;

    { find closest pair and their midpoint }
    Function FindClosestPair:Boolean;
    begin
      result:=False;
      DSQMN:=Sqr(XValues.Value[1]-XValues.Value[0])+Sqr(ZValues.Value[1]-ZValues.Value[0]);

      IPMN1:=1;
      IPMN2:=2;
      ip1:=1;
      while (not result) and (ip1<=NDPM1) do
      begin
        xd1:=XValues.Value[IP1];
        yd1:=ZValues.Value[IP1];

        ip2:=ip1+1;
        while (not result) and (ip2<=NDP0) do
        begin
          xd2:=XValues.Value[IP2];
          yd2:=ZValues.Value[IP2];
          DSQI:=Sqr(xd2-xd1)+Sqr(yd2-yd1);

          if DSQI=0.0 then
          begin
            XValues.Value[ip2]:=XValues.Value[NDP0];
            YValues.Value[ip2]:=YValues.Value[NDP0];
            ZValues.Value[ip2]:=ZValues.Value[NDP0];

            Dec(tmpCount);
            Dec(NDP0);
            Dec(NDPM1);
            Dec(ip2);
//            result:=True;  7.0 removed.
          end
          else
          if DSQI<DSQMN then
          begin
            DSQMN:=DSQI;
            IPMN1:=ip1;
            IPMN2:=ip2;
          end;

          Inc(ip2);
        end;

        Inc(ip1);
      end;
    end;

Var JPMN : Integer;
    IWL  : Array of Integer;
    IWP  : Array of Integer;
    WK   : Array of Double;

    Procedure SortRest;
    Var XDMP : TChartValue;
        YDMP : TChartValue;
        jp1  : Integer;
        jp2  : Integer;
        tmpip1 : Integer;
        tmp  : Integer;
    begin
      XDMP:=(XValues.Value[IPMN1]+XValues.Value[IPMN2])*0.5;
      YDMP:=(ZValues.Value[IPMN1]+ZValues.Value[IPMN2])*0.5;

      // sort other (NDP-2) datapoints in ascending order of
      // distance from midpoint and stores datapoint numbers
      // in IWP array

      jp1:=2;
      for tmpip1:=1 to NDP0 do
      if (tmpip1<>IPMN1) and (tmpip1<>IPMN2) then
      begin
        Inc(jp1);
        IWP[jp1]:=tmpip1;
        WK[jp1]:=Sqr(XValues.Value[tmpIP1]-XDMP)+Sqr(ZValues.Value[tmpIP1]-YDMP);
      end;

      for jp1:=3 to NDPM1 do
      begin
        DSQMN:=WK[jp1];
        JPMN:=jp1;
        for jp2:=jp1 to NDP0 do
        begin
          // optimized...
          if WK[jp2]<DSQMN then
          begin
            DSQMN:=WK[jp2];
            JPMN:=jp2;
          end;
        end;

        tmp:=IWP[jp1];
        IWP[jp1]:=IWP[JPMN];
        IWP[JPMN]:=tmp;
        WK[JPMN]:=WK[jp1];
      end;
    end;

Var DSQ12 : Double;
Const Ratio = 1.0E-6;
      NRep  = 100;

    Procedure CheckColinear;
    Var AR       : Double;
        dx21     : Double;
        dy21     : Double;
        CoLinear : Double;
        jp       : Integer;
        ip       : Integer;
        jpmx     : Integer;
        i        : Integer;
    begin
      // if necessary modifies ordering so that first
      // three datapoints are not colinear
      AR:=DSQ12*ratio;

      xd1:=XValues.Value[IPMN1];
      yd1:=ZValues.Value[IPMN1];

      dx21:=XValues.Value[IPMN2]-xd1;
      dy21:=ZValues.Value[IPMN2]-yd1;

      ip:=0;
      jp:=3;
      CoLinear:=0.0;
      while (jp<=NDP0) and (colinear<=AR) do
      begin
        ip:=IWP[jp];
        CoLinear:=Abs((ZValues.Value[IP]-yd1)*dx21-(XValues.Value[IP]-xd1)*dy21);
        Inc(jp);
      end;
      Dec(jp);

      if jp=NDP0 then
         raise ETriSurfaceException.Create(TeeMsg_TriSurfaceAllColinear);

      if jp<>3 then
      begin
        jpmx:=jp;
        jp:=jpmx+1;
        for i:=4 to jpmx do
        begin
          Dec(jp);
          IWP[jp]:=IWP[jp-1];
        end;
        IWP[3]:=ip;
      end;
    end;

Var NTT3 : Integer;

    // forms first triangle-vertices in IPT array and border
    // line segments and triangle number in IPL array
    Procedure AddFirst;

      function Side(Const u1,v1,u2,v2,u3,v3:Double):Double;
      begin
        result:=(v3-v1)*(u2-u1)-(u3-u1)*(v2-v1);
      end;

    Var ip3 : Integer;
    begin
      ip1:=IPMN1;
      ip2:=IPMN2;
      ip3:=IWP[3];

      if Side( XValues.Value[IP1],ZValues.Value[IP1],
               XValues.Value[IP2],ZValues.Value[IP2],
               XValues.Value[IP3],ZValues.Value[IP3])<0 then
      begin
        ip1:=IPMN2;
        ip2:=IPMN1;
      end;

      NumTriangles:=1;
      NTT3:=3;

      { first triangle }
      IPT[1]:=ip1;
      IPT[2]:=ip2;
      IPT[3]:=ip3;

      FNumLines:=3;
      NLT3:=9;
      IPL[1]:=ip1;
      IPL[2]:=ip2;
      IPL[3]:=1;
      IPL[4]:=ip2;
      IPL[5]:=ip3;
      IPL[6]:=1;
      IPL[7]:=ip3;
      IPL[8]:=ip1;
      IPL[9]:=1;
    end;

    Procedure CalcTriangle(jp1:Integer);
    Var DXMN : Double;
        DYMN : Double;
        ARMN,dxmx,dymx,dsqmx,armx:Double;
        NSH,JWL : Integer;
        NLN,NLNT3,
        ITT3,
        NLF : Integer;
        tmp,
        jpmx : Integer;

      Procedure Part1;
      var jp2 : Integer;
          AR  : Double;
          DX,
          DY  : Double;
      begin
        for jp2:=2 to FNumLines do
        begin
          ip2:=IPL[3*jp2-2];

          xd2:=XValues.Value[IP2];
          yd2:=ZValues.Value[IP2];

          DX:=xd2-xd1;
          DY:=yd2-yd1;

          AR:=DY*DXMN-DX*DYMN;
          if AR<=ARMN then
          begin
            DSQI:=Sqr(DX)+Sqr(DY);
            if (AR<-ARMN) or (DSQI<DSQMN) then
            begin
              JPMN:=jp2;
              DXMN:=DX;
              DYMN:=DY;
              DSQMN:=DSQI;
              ARMN:=DSQMN*ratio;
            end;
          end;

          AR:=DY*DXMX-DX*DYMX;
          if AR>=-ARMX then
          begin
            DSQI:=Sqr(DX)+Sqr(DY);
            if (AR>ARMX) or (DSQI<DSQMX) then
            begin
              JPMX:=jp2;
              DXMX:=DX;
              DYMX:=DY;
              DSQMX:=DSQI;
              ARMX:=DSQMX*ratio;
            end;
          end;
        end;
      end;

      Procedure ShiftIPLArray;
      var i : Integer;
          tmpSource : Integer;
      begin
        // shifts the IPL array to have invisible border
        // line segments contained in 1st part of array
        for i:=1 to NSH do
        begin
          tmp:=i*3;
          tmpSource:=tmp+NLT3;
          IPL[tmpSource-2]:=IPL[tmp-2];
          IPL[tmpSource-1]:=IPL[tmp-1];
          IPL[tmpSource]  :=IPL[tmp];
        end;

        for i:=1 to NLT3 div 3 do
        begin
          tmp:=i*3;
          tmpSource:=tmp+(NSH*3);
          IPL[tmp-2]:=IPL[tmpSource-2];
          IPL[tmp-1]:=IPL[tmpSource-1];
          IPL[tmp]  :=IPL[tmpSource];
        end;

        Dec(JPMX,NSH);
      end;

      Procedure AddTriangles;
      var jp2   : Integer;
          IPTI  : Integer;
          IT    : Integer;
          jp2t3 : Integer;
      begin
        // adds triangles to IPT array, updates border line
        // segments in IPL array and sets flags for the border
        // line segments to be reexamined in the iwl array
        JWL:=0;
        NLNT3:=0;
        for jp2:=JPMX to FNumLines do
        begin
          jp2t3:=jp2*3;
          ipl1:=IPL[jp2t3-2];
          ipl2:=IPL[jp2t3-1];
          IT:=IPL[jp2t3];

          // add triangle to IPT array
          Inc(NumTriangles);
          Inc(NTT3,3);
          IPT[NTT3-2]:=ipl2;
          IPT[NTT3-1]:=ipl1;
          IPT[NTT3]:=ip1;

          // updates borderline segments in ipl array
          if jp2=JPMX then
          begin
            IPL[jp2t3-1]:=ip1;
            IPL[jp2t3]:=NumTriangles;
          end;
          if jp2=FNumLines then
          begin
            NLN:=JPMX+1;
            NLNT3:=NLN*3;
            IPL[NLNT3-2]:=ip1;
            IPL[NLNT3-1]:=IPL[1];
            IPL[NLNT3]:=NumTriangles;
          end;

          // determine vertex that is not on borderline segments
          ITT3:=IT*3;
          IPTI:=IPT[ITT3-2];
          if (IPTI=ipl1) or (IPTI=ipl2) then
          begin
            IPTI:=IPT[ITT3-1];
            if (IPTI=ipl1) or (IPTI=ipl2) then IPTI:=IPT[ITT3];
          end;

          // checks if exchange is necessary
          if IDxchg(ip1,IPTI,ipl1,ipl2)<>0 then
          begin
            // modifies ipt array if necessary
            IPT[ITT3-2]:=IPTI;
            IPT[ITT3-1]:=ipl1;
            IPT[ITT3]:=ip1;
            IPT[NTT3-1]:=IPTI;

            if jp2=JPMX then IPL[jp2t3]:=IT;
            if (jp2=FNumLines) and (IPL[3]=IT) then IPL[3]:=NumTriangles;

            // set flags in IWL array
            JWL:=JWL+4;
            IWL[JWL-3]:=ipl1;
            IWL[JWL-2]:=IPTI;
            IWL[JWL-1]:=IPTI;
            IWL[JWL]:=ipl2;
          end;
        end;
      end;

      Procedure ImproveTriangles;
      Var ILF    : Integer;
          tmpNLF : Integer;
          IPT1   : Integer;
          IPT2   : Integer;
          IPT3   : Integer;
          IREP   : Integer;
          IT1T3  : Integer;
          IT2T3  : Integer;
          LoopFlag : Boolean;
          NTF    : Integer;
          NTT3P3 : Integer;
      begin
        // improve triangulation
        NTT3P3:=NTT3+3;
        IREP:=1;
        while IREP<=NREP do
        begin
          for ILF:=1 to NLF do
          begin
            ipl1:=IWL[ILF*2-1];
            ipl2:=IWL[ILF*2];

            // locates in ipt array two triangles on
            // both sides of flagged line segment
            NTF:=0;
            LoopFlag:=True;
            tmp:=3;
            
            while LoopFlag and (tmp<=NTT3) do
            begin
              ITT3:=NTT3P3-tmp;

              IPT1:=IPT[ITT3-2];
              IPT2:=IPT[ITT3-1];
              IPT3:=IPT[ITT3];

              if (ipl1=IPT1) or (ipl1=IPT2) or (ipl1=IPT3) then // todo: optimize?
              begin
                if (ipl2=IPT1) or (ipl2=IPT2) or (ipl2=IPT3) then
                begin
                  Inc(NTF);
                  ITF[NTF]:=ITT3 div 3;
                  if NTF=2 then LoopFlag:=False;
                end;
              end;

              Inc(tmp,3);
            end;

            if NTF>=2 then
            begin
              IT1T3:=ITF[1]*3;
              IPTI1:=IPT[IT1T3-2];
              if (IPTI1=ipl1) or (IPTI1=ipl2) then
              begin
                IPTI1:=IPT[IT1T3-1];
                if (IPTI1=ipl1) or (IPTI1=ipl2) then IPTI1:=IPT[IT1T3];
              end;

              IT2T3:=ITF[2]*3;
              IPTI2:=IPT[IT2T3-2];
              if (IPTI2=ipl1) or (IPTI2=ipl2) then
              begin
                IPTI2:=IPT[IT2T3-1];
                if (IPTI2=ipl1) or (IPTI2=ipl2) then IPTI2:=IPT[IT2T3];
              end;

               // checks if exchange necessary
              if IDxchg(IPTI1,IPTI2,ipl1,ipl2)<>0 then
              begin
                 IPT[IT1T3-2]:=IPTI1;
                 IPT[IT1T3-1]:=IPTI2;
                 IPT[IT1T3]:=ipl1;

                 IPT[IT2T3-2]:=IPTI2;
                 IPT[IT2T3-1]:=IPTI1;
                 IPT[IT2T3]:=ipl2;

                 JWL:=JWL+8;

                 IWL[JWL-7]:=ipl1;
                 IWL[JWL-6]:=IPTI1;
                 IWL[JWL-5]:=IPTI1;
                 IWL[JWL-4]:=ipl2;
                 IWL[JWL-3]:=ipl2;
                 IWL[JWL-2]:=IPTI2;
                 IWL[JWL-1]:=IPTI2;
                 IWL[JWL]  :=ipl1;

                 CalcBorder;
              end;
            end;
          end;

          tmp:=NLF;
          NLF:=JWL div 2;
          if NLF=tmp then break
          else
          begin // reset IWL array for next round
            JWL:=0;
            tmp:=(tmp+1)*2;
            tmpNLF:=2*NLF;
            while tmp<=tmpNLF do
            begin
              Inc(JWL,2);
              IWL[JWL-1]:=IWL[tmp-1];
              IWL[JWL]  :=IWL[tmp];
              Inc(tmp,2);
            end;
            NLF:=JWL div 2;
          end;

          Inc(IREP);
        end;
      end;

    begin
      ip1:=IWP[jp1];

      xd1:=XValues.Value[IP1];
      yd1:=ZValues.Value[IP1];

      // determine visible borderline segments
      ip2:=IPL[1];
      JPMN:=1;

      xd2:=XValues.Value[IP2];
      yd2:=ZValues.Value[IP2];

      DXMN:=xd2-xd1;
      DYMN:=yd2-yd1;
      DSQMN:=Sqr(DXMN)+Sqr(DYMN);

      ARMN:=DSQMN*Ratio;
      jpmx:=1;
      dxmx:=DXMN;
      dymx:=DYMN;
      dsqmx:=DSQMN;
      armx:=ARMN;

      Part1;

      if jpmx<jpmn then Inc(jpmx,FNumLines);

      NSH:=JPMN-1;
      if NSH>0 then ShiftIPLArray;

      AddTriangles;

      FNumLines:=NLN;
      NLT3:=NLNT3;
      NLF:=JWL div 2;
      if (NLF<>0) and ImprovedTriangles then
         ImproveTriangles;
    end;

  Var jp1 : Integer;
  begin
    Inc(IUpdating);
    AddXYZ(XValues[0],YValues[0],ZValues[0]);  // 7.0 first point

    try
      tmpCount:=Count;
      NDP0:=tmpCount-1;
      NDPM1:=NDP0-1;
      SetLength(IPT,6*tmpCount-15);
      SetLength(IPL,6*tmpCount);
      SetLength(IWL,18*tmpCount);
      SetLength(IWP,tmpCount);
      SetLength(WK,tmpCount);
      try

        if not FindClosestPair then
        begin
          DSQ12:=DSQMN;
          SortRest;
          CheckColinear;
          AddFirst;
          // add the remaining NDP-3 data points one by one
          for jp1:=4 to NDP0 do CalcTriangle(jp1);
          ICreated:=True;
        end
        else
        begin
          Visible:=False;  // 7.0
          raise ETriSurfaceException.Create(TeeMsg_TriSurfaceSimilar);
        end;

      finally
        IWL:=nil;
        IWP:=nil;
        WK:=nil;
      end;
    finally
      Delete(Count-1);
      Dec(IUpdating);
    end;
  end;

begin
  inherited;
  if Count<3 then
  begin
    NumTriangles:=0;
    raise ETriSurfaceException.Create(TeeMsg_TriSurfaceLess);
  end
  else
  if (not CacheTriangles) or (not ICreated) then { 5.02 }
     CreateTriangles;
end;

Function TCustomTriSurfaceSeries.CalcPointResult(Index:Integer):TPoint3D;
begin
  with result do
  begin
    X:=CalcXPos(Index);
    Y:=CalcYPos(Index);
    Z:=CalcZPos(Index);
  end;
end;

Function TCustomTriSurfaceSeries.TrianglePoints(TriangleIndex:Integer):TTrianglePoints3D;

  Procedure CalcPoint(APoint,Index:Integer);
  begin
    With result[APoint] do
    begin
      X:=CalcXPos(Index);
      Y:=CalcYPos(Index);
      Z:=CalcZPos(Index);
    end;
  end;

var tmp : Integer;
begin
  tmp:=3*TriangleIndex;
  CalcPoint(0,IPT[tmp-2]);
  CalcPoint(1,IPT[tmp-1]);
  CalcPoint(2,IPT[tmp]);
end;

Procedure TCustomTriSurfaceSeries.TrianglePointsTo2D(const P:TTrianglePoints3D; Var Result:TeCanvas.TTrianglePoints);
begin
  with ParentChart.Canvas do
  begin
    result[0]:=Calculate3DPosition(P[0]);
    result[1]:=Calculate3DPosition(P[1]);
    result[2]:=Calculate3DPosition(P[2]);
  end;
end;

procedure TCustomTriSurfaceSeries.DrawAllValues;

  procedure AddSortedTriangles;
  var tmpForward : Boolean;

    { sort triangles by Z (draw first triangles with bigger depth) }
    Procedure AddByZ(ATriangle:PTriangle);
    var tmp  : PTriangle;
        Last : PTriangle;
    begin
      Last:=nil;
      tmp:=Triangles;

      while Assigned(tmp) do
      begin
        if (tmpForward and (ATriangle.Z>tmp.Z)) or
           ((not tmpForward) and (tmp.Z>ATriangle.Z)) then
        begin
          if Assigned(tmp.Prev) then
          begin
            ATriangle.Prev:=tmp.Prev;
            tmp.Prev.Next:=ATriangle;
          end
          else Triangles:=ATriangle;

          tmp.Prev:=ATriangle;
          ATriangle.Next:=tmp;
          Exit;
        end;

        Last:=tmp;
        tmp:=tmp.Next;
      end;

      if Assigned(Last) then
      begin
        Last.Next:=ATriangle;
        ATriangle.Prev:=Last;
      end
      else Triangles:=ATriangle;
    end;

  var t : Integer;
      tmpTriangle : PTriangle;
      tmp : Integer;
      tmpPoints : TTrianglePoints3D;
  begin
    { create a list of triangles sorted by Z }
    tmpForward:=not ParentChart.DepthAxis.Inverted;

    if ParentChart.View3D and
       (not ParentChart.View3DOptions.Orthogonal) then
            if (ParentChart.View3DOptions.Rotation>90) and
               (ParentChart.View3DOptions.Rotation<270) then
                  tmpForward:=not tmpForward; // 7.0

    for t:=1 to NumTriangles do
    begin
      tmpPoints:=TrianglePoints(t);

      {$IFDEF CLR}
      tmpTriangle:=TTriangle.Create;
      {$ELSE}
      New(tmpTriangle);
      {$ENDIF}

      with tmpTriangle{$IFNDEF CLR}^{$ENDIF} do
      begin
        Next:=nil;
        Prev:=nil;
        Index:=t;

        // Aproximate Z to the greatest of 3 triangle corners
        tmp:=3*t;
        Z:=Math.Max(ZValues.Value[IPT[tmp]],
           Math.Max(ZValues.Value[IPT[tmp-1]],ZValues.Value[IPT[tmp-2]]));

        // Calculate XY screen positions of corners
        TrianglePointsTo2D(tmpPoints,P);

        //Color
        Color:=ValueColor[IPT[tmp-2]];
      end;

      AddByZ(tmpTriangle);
    end;
  end;

var
  tmpBlend  : TTeeBlend;

  procedure DrawAllUnsorted;
  var t : Integer;
      tmpColors : TTriangleColors3D;
      tmpPoints : TTrianglePoints3D;
      tmpSmooth : Boolean;
      P         : TTrianglePoints;
  begin
    tmpSmooth:=ParentChart.Canvas.SupportsFullRotation;

    // draw all triangles, do not hide
    for t:=1 to NumTriangles do
    begin
      tmpPoints:=TrianglePoints(t);

      if Assigned(tmpBlend) then
      begin
        TrianglePointsTo2D(tmpPoints,P);
        tmpBlend.SetRectangle(RectFromTriangle(P));
      end;

      tmpColors[0]:=ValueColor[IPT[3*t-2]];

      if tmpSmooth then  // 7.0
      begin
        tmpColors[1]:=ValueColor[IPT[3*t-1]];
        tmpColors[2]:=ValueColor[IPT[3*t]];
      end
      else
      begin
        tmpColors[1]:=tmpColors[0];
        tmpColors[2]:=tmpColors[0];
      end;

      ParentChart.Canvas.Triangle3D(tmpPoints,tmpColors);

      if Assigned(tmpBlend) then
         tmpBlend.DoBlend(Transparency);
    end;
  end;

  procedure DrawAllSorted;
  var Triangle : PTriangle;
  begin
    {$IFNDEF CLX}
    if FastBrush then  // 7.0
    begin
      CanvasDC:=ParentChart.Canvas.Handle;
      SelectObject(CanvasDC,DCBRUSH);
    end;
    {$ENDIF}

    { draw all triangles }
    Triangle:=Triangles;

    while Assigned(Triangle) do
    begin
      {$IFNDEF CLX}
      if FastBrush then // 7.0
         TeeSetDCBrushColor(CanvasDC,Triangle.Color)
      else
      {$ENDIF}
        ParentChart.Canvas.Brush.Color:=Triangle.Color;

      if Assigned(tmpBlend) then
         tmpBlend.SetRectangle(RectFromPolygon(Triangle.P,3));

      ParentChart.Canvas.Polygon(Triangle.P);

      if Assigned(tmpBlend) then
         tmpBlend.DoBlend(Transparency);

      ILastTriangle:=Triangle;
      Triangle:=Triangle.Next;
    end;
  end;

var t : Integer;
begin
  ILastTriangle:=nil;  // for Clicked method

  With ParentChart.Canvas do
  begin
    if Self.Pen.Visible or (Self.Brush.Style<>bsClear) then
    begin
      AssignBrush(Self.Brush,Self.Brush.Color);
      AssignVisiblePen(Self.Pen);

      if Transparency>0 then
         tmpBlend:=BeginBlending(TeeRect(0,0,0,0),Transparency)
      else
         tmpBlend:=nil;

      if HideTriangles and (not SupportsFullRotation) and (Brush.Style=bsSolid) then
      begin
        ClearTriangles;
        AddSortedTriangles;
        DrawAllSorted;
      end
      else
        DrawAllUnsorted;

      tmpBlend.Free;  // Do not call EndBlending here...
    end;

    { draw border }
    if Self.FBorder.Visible then
    begin
      AssignVisiblePen(Self.FBorder);

      for t:=1 to FNumLines do
      begin
        MoveTo3D(CalcPointResult(IPL[3*t-2]));
        LineTo3D(CalcPointResult(IPL[3*t-1]));
      end;
    end;
  end;
end;

procedure TCustomTriSurfaceSeries.SetFastBrush(const Value: Boolean);
begin
  {$IFNDEF CLX}
  if Assigned(@TeeSetDCBrushColor) then
  begin
    FFastBrush:=Value;
    DCBRUSH:=GetStockObject(DC_BRUSH);
  end;
  {$ENDIF}
end;

Procedure TCustomTriSurfaceSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                            APosition:TSeriesMarkPosition);
begin
  Marks.ZPosition:=CalcZPos(ValueIndex);
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

procedure TCustomTriSurfaceSeries.Assign(Source: TPersistent);
begin
  if Source is TCustomTriSurfaceSeries then
  with TCustomTriSurfaceSeries(Source) do
  begin
    Self.Border:=Border;
    Self.ImprovedTriangles:=ImprovedTriangles;
    Self.FHide:=HideTriangles;
    Self.FTransp:=Transparency;
  end;

  inherited;
end;

class procedure TCustomTriSurfaceSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_WireFrame);
  AddSubChart(TeeMsg_NoLine);
  AddSubChart(TeeMsg_Border);
end;

Procedure TCustomTriSurfaceSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues;
end;

class procedure TCustomTriSurfaceSeries.SetSubGallery(
  ASeries: TChartSeries; Index: Integer);
begin
  With TCustomTriSurfaceSeries(ASeries) do
  Case Index of
    2: Brush.Style:=bsClear;
    3: Pen.Hide;
    4: Border.Show;
  else inherited;
  end;
end;

procedure TCustomTriSurfaceSeries.Clear;
begin
  inherited;
  ICreated:=False;
end;

procedure TCustomTriSurfaceSeries.SetHide(const Value: Boolean);
begin
  SetBooleanProperty(FHide,Value);
end;

Procedure TCustomTriSurfaceSeries.SetTransp(Value:TTeeTransparency);
begin
  if FTransp<>Value then
  begin
    FTransp:=Value;
    Repaint;
  end;
end;

initialization
  RegisterTeeSeries( TTriSurfaceSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryTriSurface,
                                        {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
finalization
  UnRegisterTeeSeries([TTriSurfaceSeries]);
end.
