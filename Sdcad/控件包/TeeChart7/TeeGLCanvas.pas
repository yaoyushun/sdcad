{******************************************}
{    TeeChart Pro OpenGL Canvas            }
{ Copyright (c) 1998-2004 by David Berneda }
{       All Rights Reserved                }
{******************************************}
unit TeeGLCanvas;
{$I TeeDefs.inc}

{$IFOPT D-}
{$C-}  // Turn off assertions if debug is not on.
{$ENDIF}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils,
     Classes,
     {$IFDEF CLX}
     Qt, QGraphics, QControls, Types,
     {$ELSE}
     Graphics, Controls,
     {$ENDIF}

     {$IFDEF LINUX}
     OpenGLLinux,
     {$ELSE}
     OpenGL2,
     {$ENDIF}

     TeeConst, TeCanvas;

type
  GLMat=Array[0..3] of GLFloat;

  {$IFDEF LINUX}
  PGLUQuadricObj=GLUQuadricObj;
  {$ENDIF}

var
  //  TeeOpenGLFontExtrusion : Integer=0; Removed v7: Use TGLCanvas.FontExtrusion

  TeeOpenGLFontName   : {$IFDEF CLR}String{$ELSE}PChar{$ENDIF}=TeeMsg_DefaultEngFontName;

  TeeMaterialAmbient  : Double=1;
  TeeMaterialDiffuse  : Double=1;
  TeeMaterialSpecular : Double=1;

  TeeFullLightModel : GLENum= GL_FALSE;
  TeeLightLocal     : GLENum= GL_FALSE;
  TeeColorPlanes    : GLENum= GL_FRONT_AND_BACK;

  TeeTextAngleY  : Integer=0;
  TeeTextAngleZ  : Integer=0;

  TeeDefaultLightSpot:Integer=180;

  TeeSphereSlices:Integer = 16;
  TeeSphereStacks:Integer = 16;
  TeeCylinderStacks:Integer = 6;

  TeeSmooth : Boolean = False;
  TeeSmoothQuality : GLEnum = GL_FASTEST;

  TeePerspectiveQuality : GLEnum = GL_NICEST;

  TeeWrapTextures : Boolean=True;

const
  TeeFontListRange  = 256-32+1;
  TeeMaxFonts       = 10;

type
  TGLFontCache=packed record
    Offset : Integer;
    Name   : String;
    Weight : Integer;
    Style  : TFontStyles;
  end;

  TGLCanvas = class({$IFDEF CLR}TTeeCanvas3D{$ELSE}TCanvas3D{$ENDIF})
  private
    { Private declarations }
    FBackColor     : TColor;
    FBackMode      : TCanvasBackMode;

    FDepth         : Integer;
    FTextAlign     : Integer;

    FWidth         : Integer;
    FHeight        : Integer;
    FXCenter       : Integer;
    FYCenter       : Integer;

    FOnInit        : TNotifyEvent;

    { internal }
    FDC            : TTeeCanvasHandle;

    HRC            : HGLRC;
    FX             : Integer;
    FY             : Integer;
    FZ             : Integer;
    FIs3D          : Boolean;

    { fonts }
    FontCache      : Array[0..TeeMaxFonts] of TGLFontCache;
    INumFonts      : Integer;

    FUseBuffer     : Boolean;
    IDestCanvas    : TCanvas;
    IDrawToBitmap  : Boolean;
    FSavedError    : GLEnum;

    FQuadric       : PGLUQuadricObj;
    IQuadricTexture: Boolean;

    Function CalcZoom:Double;
    Procedure DeleteTextures;
    Procedure DestroyGLContext;
    Procedure DoProjection;
    Procedure EndBrushBitmap; overload;
    Procedure EndBrushBitmap(Bitmap:TBitmap); overload;
    Function FindTexture(ABitmap:TBitmap):{$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
    Function FontWeight:Integer;

    {$IFNDEF LINUX}
    Function GetDCHandle:HDC;
    {$ENDIF}

    Procedure InitMatrix;
    procedure InternalRectangle(const Rect: TRect);
    
    Function Quadric:PGLUQuadricObj;
    Procedure SetBrushBitmap; overload;
    Function SetBrushBitmap(Bitmap:TBitmap):Boolean; overload;
    Procedure SetColor(AColor:TColor);
    Procedure SetPen;
    Procedure TeeVertex2D(x,y:Integer);
    Procedure TeeVertex3D(x,y,z:Integer);
    Procedure TeeNormal(x,y,z:Integer);
    procedure InternalCylinder(Vertical:Boolean; Left,Top,Right,Bottom,
                        Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
  protected
    { Protected declarations }
    {$IFNDEF LINUX}
    Procedure CreateFontOutlines(Index:Integer);
    {$ENDIF}

    Procedure InitOpenGLFont;
    Procedure InitAmbientLight(AmbientLight:Integer);
    Procedure InitLight(Num:Integer; Const AColor:GLMat; Const X,Y,Z:Double);
    Procedure SetShininess(Const Value:Double);
    procedure SetDrawStyle(Value:TTeeCanvasSurfaceStyle);

    { 2d }
    Function GetBackMode:TCanvasBackMode; override;
    Function GetBackColor:TColor; override;
    Function GetHandle:TTeeCanvasHandle; override;
    Function GetMonochrome:Boolean; override;
    Function GetPixel(x,y:Integer):TColor; override;
    function GetPixel3D(X,Y,Z:Integer): TColor; override;
    Function GetSupports3DText:Boolean; override;
    Function GetSupportsFullRotation:Boolean; override;
    Function GetTextAlign:TCanvasTextAlign; override;
    Function GetUseBuffer:Boolean; override;

    Procedure SetBackColor(Color:TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Procedure SetMonochrome(Value:Boolean); override;
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Procedure SetTextAlign(Align:TCanvasTextAlign); override;
    Procedure SetUseBuffer(Value:Boolean); override;
  public
    DrawStyle      : TTeeCanvasSurfaceStyle;
    FontExtrusion  : Integer;
    FontOutlines   : Boolean;
    ShadeQuality   : Boolean;

    { Public declarations }
    Constructor Create;
    Destructor Destroy; override;

    Function CheckGLError:Boolean;
    Procedure DeleteFont;
    Procedure Repaint;

    { 3d }
    Procedure DisableRotation; override;
    Procedure EnableRotation; override;
    Procedure SetMaterialColor;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                     Const StartAngle,EndAngle,HolePercent:Double); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure EraseBackground(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure FillRect(const Rect: TRect); override;
    procedure LineTo(X,Y:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Rectangle(X0,Y0,X1,Y1:Integer); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    Procedure TextOut(X,Y:Integer; const Text:String); override;
    Procedure DoHorizLine(X0,X1,Y:Integer); override;
    Procedure DoVertLine(X,Y0,Y1:Integer); override;

    procedure ClipRectangle(Const Rect:TRect); override;
    procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); override;

    Procedure GradientFill( Const Rect:TRect;
                            StartColor,EndColor:TColor;
                            Direction:TGradientDirection;
                            Balance:Integer=50); override;
    Procedure Invalidate; override;
    Procedure Line(X0,Y0,X1,Y1:Integer); override;
    procedure Polyline(const Points:{$IFDEF D5}array of TPoint{$ELSE}TPointArray{$ENDIF}); override; // 6.0
    Procedure Polygon(const Points: array of TPoint); override;
    procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Double); override;
    procedure UnClipRectangle; override;

    { 3d }
    Procedure Calculate2DPosition(Var x,y:Integer; z:Integer); override;
    Function Calculate3DPosition(x,y,z:Integer):TPoint; override;
    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;
    Procedure Projection(MaxDepth:Integer; const Bounds,Rect:TRect); override;
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    Function ReDrawBitmap:Boolean; override;

    Procedure Arrow( Filled:Boolean;
                     Const FromPoint,ToPoint:TPoint;
                     ArrowWidth,ArrowHeight,Z:Integer); override;
    procedure Cone( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                    Dark3D:Boolean; ConePercent:Integer); override;
    Procedure Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean); override;

    procedure Cylinder(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; DarkCover:Boolean); override;
    procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
    Procedure HorizLine3D(Left,Right,Y,Z:Integer); override;
    procedure LineTo3D(X,Y,Z:Integer); override;
    Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer); override;
    procedure MoveTo3D(X,Y,Z:Integer); override;
    procedure Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                     Const StartAngle,EndAngle:Double;
                     DarkSides,DrawSides:Boolean;
                     DonutPercent:Integer=0;
                     Gradient:TCustomTeeGradient=nil); override;
    procedure Plane3D(Const A,B:TPoint; Z0,Z1:Integer); override;
    procedure PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer); override;
    procedure PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer); override;
    procedure Polygon3D(const Points: array of TPoint3D);
    procedure PolygonWithZ(Points: array of TPoint; Z:Integer); override;
    procedure Pyramid(Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer; DarkSides:Boolean); override;
    Procedure PyramidTrunc(Const R:TRect; StartZ,EndZ:Integer;
                           TruncX,TruncZ:Integer); override;
    Procedure RectangleWithZ(Const Rect:TRect; Z:Integer); override;
    Procedure RectangleY(Left,Top,Right,Z0,Z1:Integer); override;
    Procedure RectangleZ(Left,Top,Bottom,Z0,Z1:Integer); override;
    procedure RotateLabel3D(x,y,z:Integer;
                            Const St:String; RotDegree:Double); override;
    procedure Sphere(x,y,z:Integer; Const Radius:Double); override;
    Procedure Surface3D( Style:TTeeCanvasSurfaceStyle;
                         SameBrush:Boolean;
                         NumXValues,NumZValues:Integer;
                         CalcPoints:TTeeCanvasCalcPoints ); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
    procedure Triangle3D(Const Points:TTrianglePoints3D; Const Colors:TTriangleColors3D); override;
    procedure TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer); override;
    Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
    Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;

    { events }
    property OnInit:TNotifyEvent read FOnInit write FOnInit;
  published
  end;

  TGLShape=class(TPersistent)
  private
    FBrush : TChartBrush;
    FPen   : TChartPen;
    procedure SetBrush(const Value:TChartBrush);
    procedure SetPen(const Value:TChartPen);
  protected
    procedure PushMatrix;
    procedure PopMatrix;
  public
    Canvas    : TGLCanvas;
    Rotation  : Double;
    Elevation : Double;
    Tilt      : Double;

    Constructor Create(ACanvas: TGLCanvas); virtual;
    Destructor Destroy; override;
    procedure Draw(X,Y:Integer); virtual;

    property Brush:TChartBrush read FBrush write SetBrush;
    property Pen:TChartPen read FPen write SetPen;
  end;

  TGLTorus=class(TGLShape)
  public
    Inner : Double;
    Outer : Double;
    Rings : Integer;
    Sides : Integer;

    Constructor Create(ACanvas: TGLCanvas); override;
    procedure Draw(X,Y:Integer); override;
  end;

Procedure ColorToGL(AColor:TColor; Var C:GLMat);

implementation

uses Math;

const
  TeeZoomScale     = -80000;
  TeeMinPerspective = 6; // %
  TeeSolidCubeList =   8888;
  TeeWireCubeList  = TeeSolidCubeList+1;

  {$IFDEF CLX}
  BytesPerPixel    = 4;
  {$ELSE}
  BytesPerPixel    = 3;
  {$ENDIF}

var
  ITransp:Single=1;

Function MinInteger(a,b:Integer):Integer;
begin
  if a>b then result:=b else result:=a;
end;

Procedure ColorToGL(AColor:TColor; Var C:GLMat);
begin
  AColor:=ColorToRGB(AColor);
  C[0]:=Byte(AColor)/255;
  C[1]:=Byte(AColor shr 8)/255;
  C[2]:=Byte(AColor shr 16)/255;
  C[3]:=ITransp;
end;

{ TGLCanvas }
Constructor TGLCanvas.Create;
begin
  inherited Create;
  FUseBuffer:=True;
  FSavedError:=GL_NO_ERROR;
  FTextAlign:=TA_LEFT;
end;

Procedure TGLCanvas.DestroyGLContext;
begin
  DeleteFont;

  if HRC<>0 then
  begin

    {$IFNDEF LINUX}
    DeactivateRenderingContext;
    DestroyRenderingContext(HRC);
    {$ENDIF}

    HRC:=0;
//    Assert(CheckGLError,'DestroyGLContext');
  end;
end;

Destructor TGLCanvas.Destroy;
begin
  {$IFNDEF CLR}
  if Assigned(FQuadric) then gluDeleteQuadric(FQuadric);
  {$ENDIF}

  DestroyGLContext;
  DeleteTextures;
  inherited;
end;

Function TGLCanvas.CheckGLError:Boolean;
begin
  FSavedError:=glGetError;
  result:=FSavedError=GL_NO_ERROR;
  if not result then
     FSavedError:=FSavedError+1-1;
end;

Procedure TGLCanvas.Calculate2DPosition(Var x,y:Integer; z:Integer);
begin { nothing yet }
end;

Function TGLCanvas.Calculate3DPosition(x,y,z:Integer):TPoint;
begin
  result:=TeePoint(x,y);
end;

Procedure TGLCanvas.DoProjection;
Var tmp  : Double;
    FarZ : Integer;
    tmpW,
    tmpH : Double;
    tmpFoV : Double;
begin
  glMatrixMode(GL_PROJECTION);
  Assert(CheckGLError,'Projection');

  glLoadIdentity;
  Assert(CheckGLError,'ProjectionInit');

  FarZ:=Round(400.0*(FDepth+1));

  if (not FIs3D) or View3DOptions.Orthogonal then
  begin
    tmpW:=FWidth*0.5;
    tmpH:=FHeight*0.5;
    tmp:=100.0/CalcZoom;

    glOrtho(-tmpW*tmp,tmpW*tmp,-tmpH*tmp,tmpH*tmp,-0.1,tmp*2*FarZ);  // 7.0

    Assert(CheckGLError,'Orthogonal');

    glDisable(GL_DEPTH_TEST);
  end
  else
  begin
    glEnable(GL_DEPTH_TEST);

    {$IFNDEF CLR}

    tmp:=100.0/CalcZoom;
    if tmp<1 then tmp:=1;

    tmpFoV:=0.5*Math.Max(TeeMinPerspective,View3DOptions.Perspective);

    gluPerspective(tmpFoV,          // Field-of-view angle
                   FWidth/FHeight,  // Aspect ratio of viewing volume
                   1.1,             // Distance to near clipping plane
                   0.5*tmp*FarZ);       // Distance to far clipping plane
    {$ENDIF}

    Assert(CheckGLError,'Perspective');
  end;
end;

Procedure TGLCanvas.Projection(MaxDepth:Integer; const Bounds,Rect:TRect);
begin
  RectSize(Bounds,FWidth,FHeight);
  RectCenter(Rect,FXCenter,FYCenter);
  FDepth:=MaxDepth;

  glViewport(0, 0, FWidth, FHeight);
  Assert(CheckGLError,'ViewPort'+IntToStr(FSavedError));

  DoProjection;
  SetDrawStyle(DrawStyle);
  InitMatrix;
end;

Function TGLCanvas.CalcZoom:Double;

  Function CalcPerspective:Double;
  begin
    if FIs3D and (not View3DOptions.Orthogonal) then
       result:=Math.Max(TeeMinPerspective,View3DOptions.Perspective)*0.01
    else
       result:=1;
  end;

begin
  result:=2.0*Math.Max(1,View3DOptions.Zoom)*CalcPerspective;
end;

Procedure TGLCanvas.InitMatrix;
const tmpInv=1/255.0;
var AColor : TColor;
begin
  AColor:=ColorToRGB(FBackColor);
  glClearColor( GetRValue(AColor)*tmpInv,
                GetGValue(AColor)*tmpInv,
                GetBValue(AColor)*tmpInv,
                1);
  Assert(CheckGLError,'ClearColor');

  glDisable(GL_DITHER);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  Assert(CheckGLError,'Clear');

  glEnable(GL_DITHER);

  glMatrixMode(GL_MODELVIEW);
  Assert(CheckGLError,'ModelView');

  glLoadIdentity;
  Assert(CheckGLError,'ModelInit');

  With View3DOptions do
       glTranslatef(HorizOffset,-VertOffset,TeeZoomScale/CalcZoom);

  if ShadeQuality then glShadeModel(GL_SMOOTH)
                  else glShadeModel(GL_FLAT);

  Assert(CheckGLError,'ShadeModel');

  With View3DOptions do
  if FIs3D then
  begin
    glRotatef(Tilt, 0, 0, 1);
    glRotatef(-Elevation, 1, 0, 0);
    glRotatef(Rotation, 0, 1, 0);
  end;

  glTranslatef( -FXCenter+RotationCenter.X,
                 FYCenter+RotationCenter.Y,
                 RotationCenter.Z+(0.5*FDepth));

  Assert(CheckGLError,'Rotations');

  {$IFNDEF CLR}
  if ShadeQuality then gluQuadricNormals(Quadric,GL_SMOOTH)
                  else gluQuadricNormals(Quadric,GL_FLAT);
  {$ENDIF}

  Assert(CheckGLError,'QuadricNormals');

  if Assigned(FOnInit) then FOnInit(Self);
  Assert(CheckGLError,'Init');
end;

Function TGLCanvas.Quadric:PGLUQuadricObj;
begin
  {$IFNDEF CLR}
  if not Assigned(FQuadric) then FQuadric:=gluNewQuadric;
  {$ENDIF}
  result:=FQuadric;
end;

Procedure TGLCanvas.TeeVertex2D(x,y:Integer);
begin
  glVertex2i(x,-y);
end;

Procedure TGLCanvas.TeeVertex3D(x,y,z:Integer);
begin
  glVertex3i(x,-y,-z);
end;

Procedure TGLCanvas.TeeNormal(x,y,z:Integer);
begin
  glNormal3i(x,y,-z);
end;

Procedure TGLCanvas.SetBrushBitmap;
begin
  SetBrushBitmap(Brush.Bitmap);
end;

Function TGLCanvas.SetBrushBitmap(Bitmap:TBitmap):Boolean;
var tmp : Cardinal;
begin
  if Bitmap<>nil then
  begin
    tmp:=FindTexture(Bitmap);

    result:=tmp<>0;

    if result then
    begin
      glEnable(GL_TEXTURE_2D);

      {$IFNDEF LINUX}
      glBindTexture(GL_TEXTURE_2D, tmp);
      Assert(CheckGLError,'BindTexture');
      {$ENDIF}

      {$IFNDEF CLR}
      gluQuadricTexture(Quadric,{$IFDEF LINUX}True{$ELSE}GL_TRUE{$ENDIF});
      Assert(CheckGLError,'gluQuadricTexture');
      IQuadricTexture:=True;
      {$ENDIF}
    end;

  end
  else result:=True;
end;

Procedure TGLCanvas.EndBrushBitmap;
begin
  EndBrushBitmap(Brush.Bitmap);
end;

Procedure TGLCanvas.EndBrushBitmap(Bitmap:TBitmap);
begin
  if Bitmap<>nil then
  begin
    {$IFNDEF CLR}
    if IQuadricTexture then
    begin
      gluQuadricTexture(Quadric,{$IFDEF LINUX}False{$ELSE}GL_FALSE{$ENDIF});
      Assert(CheckGLError,'gluQuadricTexture');
      IQuadricTexture:=False;
    end;
    {$ENDIF}

    glDisable(GL_TEXTURE_2D);
  end;
end;

Procedure TGLCanvas.Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean);
begin
  glEnable(GL_CULL_FACE);

  if Left>Right then SwapInteger(Left,Right);
  if Top>Bottom then SwapInteger(Top,Bottom);
  if z0>z1 then SwapInteger(z0,z1);

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;

    glBegin(GL_QUADS);
    TeeNormal( 0, 0, -1);
     glTexCoord2f(1,0);
     TeeVertex3D( Left,  Bottom, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Top,    z0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left,  Top,    z0);

    TeeNormal(-1,  0,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left, Top,    z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Left, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Left, Bottom, z0);
     glTexCoord2f(1,0);
     TeeVertex3D( Left, Top,    z0);

    TeeNormal( 0, 0, 1);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Top,    z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Left,  Bottom, z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Left,  Top,    z1);

    TeeNormal( 1,  0,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Right, Bottom, z1);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Top,    z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Top,    z0);

    TeeNormal( 0, 1,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Left,  Top, z1);
     glTexCoord2f(0,1);
     TeeVertex3D( Left,  Top, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Right, Top, z0);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Top, z1);

    TeeNormal( 0, -1,  0);
     glTexCoord2f(0,0);
     TeeVertex3D( Right, Bottom, z0);
     glTexCoord2f(0,1);
     TeeVertex3D( Left,  Bottom, z0);
     glTexCoord2f(1,1);
     TeeVertex3D( Left,  Bottom, z1);
     glTexCoord2f(1,0);
     TeeVertex3D( Right, Bottom, z1);

    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left,  Bottom, z0);
      TeeVertex3D( Right, Bottom, z0);
      TeeVertex3D( Right, Top,    z0);
      TeeVertex3D( Left,  Top,    z0);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left,  Top,    z1);
      TeeVertex3D( Left,  Bottom, z1);
      TeeVertex3D( Right, Bottom, z1);
      TeeVertex3D( Right, Top,    z1);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Right, Top,    z0);
      TeeVertex3D( Right, Top,    z1);
      TeeVertex3D( Right, Bottom, z1);
      TeeVertex3D( Right, Bottom, z0);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Left, Top,    z0);
      TeeVertex3D( Left, Bottom, z0);
      TeeVertex3D( Left, Bottom, z1);
      TeeVertex3D( Left, Top,    z1);
    glEnd;

    glBegin(GL_LINE_LOOP);
      TeeVertex3D( Right, Top, z1);
      TeeVertex3D( Right, Top, z0);
      TeeVertex3D( Left,  Top, z0);
      TeeVertex3D( Left,  Top, z1);
    glEnd;
  end;

  glDisable(GL_CULL_FACE);
  Assert(CheckGLError,'Cube');
end;

{$IFDEF CLR}
{$UNSAFECODE ON}
{$ENDIF}

Procedure TGLCanvas.SetMaterialColor; {$IFDEF CLR}unsafe;{$ENDIF}

  Function GLColor(Const Value:Double):GLMat;
  begin
    result[0]:=Value;
    result[1]:=Value;
    result[2]:=Value;
    result[3]:=1;
  end;

var tmp : GLMat;
begin
  tmp:=GLColor(TeeMaterialDiffuse);
  glMaterialfv(TeeColorPlanes,GL_DIFFUSE,PGLFloat(@tmp));
  tmp:=GLColor(TeeMaterialSpecular);
  glMaterialfv(TeeColorPlanes,GL_SPECULAR,PGLFloat(@tmp));
  tmp:=GLColor(TeeMaterialAmbient);
  glMaterialfv(TeeColorPlanes,GL_AMBIENT,PGLFloat(@tmp));
  Assert(CheckGLError,'Material '+IntToStr(FSavedError));
end;

{$IFNDEF LINUX}
Function TGLCanvas.GetDCHandle:HDC;
begin
  {$IFDEF CLX}
  result:=GetDC(GetActiveWindow);
  {$ELSE}
  result:=FDC;
  {$ENDIF}
end;
{$ENDIF}

Function TGLCanvas.InitWindow( DestCanvas:TCanvas;
                               A3DOptions:TView3DOptions;
                               ABackColor:TColor;
                               Is3D:Boolean;
                               Const UserRect:TRect):TRect;

begin
  FBounds:=UserRect;
  RectSize(Bounds,FWidth,FHeight);

  if Assigned(A3DOptions) then
     FontZoom:=A3DOptions.FontZoom;

  if (IDestCanvas<>DestCanvas) or (View3DOptions<>A3DOptions) then
  begin
    IDestCanvas:=DestCanvas;
    View3DOptions:=A3DOptions;

    InitOpenGL;

    DestroyGLContext;

    FDC:=DestCanvas.Handle;

    {$IFNDEF LINUX}

    {$IFDEF CLX}
    IDrawToBitmap:=False;
    {$ELSE}
    IDrawToBitmap:=GetObjectType(FDC) = OBJ_MEMDC;
    {$ENDIF}

    if UseBuffer then
       HRC:=CreateRenderingContext(GetDCHandle,[opDoubleBuffered],24,1)  // 7.0
    else
       HRC:=CreateRenderingContext(GetDCHandle,[],24,1);  // 7.0
//    Assert(CheckGLError,'CreateRenderingContext');

    ActivateRenderingContext(GetDCHandle,HRC);
    Assert(CheckGLError,'ActivateContext');
    {$ENDIF}

    glEnable(GL_NORMALIZE);
    Assert(CheckGLError,'EnableNormalize');

    glEnable(GL_DEPTH_TEST);
    Assert(CheckGLError,'EnableDepth');
    glDepthFunc(GL_LESS);
    Assert(CheckGLError,'DepthFunc');

    glEnable(GL_LINE_STIPPLE);
    Assert(CheckGLError,'EnableLineStipple');

    glEnable(GL_COLOR_MATERIAL);
    Assert(CheckGLError,'EnableColorMaterial');

    glColorMaterial(TeeColorPlanes,GL_AMBIENT_AND_DIFFUSE);
    Assert(CheckGLError,'ColorMaterial');

    SetMaterialColor;

    {$IFNDEF LINUX}
    //glEnable(GL_POLYGON_OFFSET_LINE);
    glEnable(GL_POLYGON_OFFSET_FILL);
    glPolygonOffset(0.5,1);

    Assert(CheckGLError,'PolygonOffset');
    {$ENDIF}

    // Enable / Disable antialias smoothing:
    if TeeSmooth then
    begin
      glEnable(GL_POLYGON_SMOOTH);
      glEnable(GL_POINT_SMOOTH);
      glEnable(GL_LINE_SMOOTH);
    end
    else
    begin
      glDisable(GL_POLYGON_SMOOTH);
      glDisable(GL_POINT_SMOOTH);
      glDisable(GL_LINE_SMOOTH);
    end;

    glDisable(GL_CULL_FACE);

    glEnable(GL_DITHER);
    Assert(CheckGLError,'Dither');

    glHint(GL_PERSPECTIVE_CORRECTION_HINT, TeePerspectiveQuality);
    glHint(GL_LINE_SMOOTH_HINT, TeeSmoothQuality);
    glHint(GL_POINT_SMOOTH_HINT, TeeSmoothQuality);
    glHint(GL_POLYGON_SMOOTH_HINT, TeeSmoothQuality);

    glLightModelf(GL_LIGHT_MODEL_TWO_SIDE,TeeFullLightModel);
    glLightModelf(GL_LIGHT_MODEL_LOCAL_VIEWER,TeeLightLocal);

    Assert(CheckGLError,'LightModel');
  end;

  FX:=0;
  FY:=0;
  FIs3D:=Is3D;

  {$IFNDEF LINUX}
  if GetObjectType(GetDCHandle) <> OBJ_MEMDC then
  begin
    FDC:=DestCanvas.Handle;

    ActivateRenderingContext(GetDCHandle,HRC);
  end;
  {$ENDIF}

  SetCanvas(DestCanvas);
  FBackColor:=ABackColor;
  result:=UserRect;
end;

Procedure TGLCanvas.InitAmbientLight(AmbientLight:Integer); {$IFDEF CLR}unsafe;{$ENDIF}
var tmp:GLMat;
    tmpNum:Double;
begin
  glDisable(GL_LIGHTING);
  glDisable(GL_LIGHT0);
  glDisable(GL_LIGHT1);
  glDisable(GL_LIGHT2);
  Assert(CheckGLError,'DisableLight');

  if AmbientLight>0 then
  begin
    glEnable(GL_LIGHTING);
    Assert(CheckGLError,'EnableLight');
    tmpNum:=AmbientLight*0.01;
    tmp[0]:=tmpNum;
    tmp[1]:=tmpNum;
    tmp[2]:=tmpNum;
    tmp[3]:=1;
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT,  PGLFloat(@tmp));
//    glLightModeli(GL_LIGHT_MODEL_TWO_SIDE,  1);

    Assert(CheckGLError,'LightModel');
  end
  else
  begin
    tmp[0]:=0;
    tmp[1]:=0;
    tmp[2]:=0;
    tmp[3]:=1;

    glEnable(GL_LIGHTING);
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, PGLFloat(@tmp));
    Assert(CheckGLError,'LightModel');
    glDisable(GL_LIGHTING);
    Assert(CheckGLError,'DisableLightModel');
  end;
end;

Procedure TGLCanvas.SetShininess(Const Value:Double);
begin
  glMateriali(TeeColorPlanes, GL_SHININESS, Round(128.0*Value));
  Assert(CheckGLError,'Shininess');
end;

Procedure TGLCanvas.InitLight(Num:Integer; Const AColor:GLMat; Const X,Y,Z:Double); {$IFDEF CLR}unsafe;{$ENDIF}
Const tmpSpec=0.9;
      tmpDif =0.9;
      tmpAmb =0.2;
var tmp : GLMat;
begin
  glEnable(GL_LIGHTING);
  glEnable(Num);
  Assert(CheckGLError,'EnableLight '+IntToStr(Num));

  tmp[0]:=tmpAmb;
  tmp[1]:=tmpAmb;
  tmp[2]:=tmpAmb;
  tmp[3]:=1;
  tmp:=AColor;
  glLightfv(Num,GL_AMBIENT, PGLFloat(@tmp));
  Assert(CheckGLError,'LightAmbient '+IntToStr(Num));

  tmp[0]:=tmpDif;
  tmp[1]:=tmpDif;
  tmp[2]:=tmpDif;
  tmp[3]:=1;
  glLightfv(Num,GL_DIFFUSE, PGLFloat(@tmp));
  Assert(CheckGLError,'LightDiffuse '+IntToStr(Num));

  tmp[0]:=tmpSpec;
  tmp[1]:=tmpSpec;
  tmp[2]:=tmpSpec;
  tmp[3]:=1;
  glLightfv(Num,GL_SPECULAR, PGLFloat(@tmp));
  Assert(CheckGLError,'LightSpecular '+IntToStr(Num));

  tmp[0]:=  X;
  tmp[1]:= -Y;
  tmp[2]:= -Z;
  tmp[3]:=1;
  glLightfv(Num,GL_POSITION, PGLFloat(@tmp));
  Assert(CheckGLError,'LightPosition '+IntToStr(Num));

  glLighti(Num,GL_SPOT_CUTOFF,TeeDefaultLightSpot);
  Assert(CheckGLError,'LightSpot '+IntToStr(Num));

//  glLighti(Num,GL_SPOT_EXPONENT,2);
//  glLightf(Num,GL_CONSTANT_ATTENUATION,1.2);
//  glLightf(Num,GL_QUADRATIC_ATTENUATION,0.00001);
end;

Procedure TGLCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  glFlush;
  Assert(CheckGLError,'Flush');

  {$IFNDEF LINUX}
  SwapBuffers(GetDCHandle);
  {$ENDIF}

  SetCanvas(DefaultCanvas);
  Assert(CheckGLError,'ShowImage');
end;

Function TGLCanvas.ReDrawBitmap:Boolean;
begin
  result:=False;
end;

procedure TGLCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  if Brush.Style<>bsClear then
     FillRect(TeeRect(X0,Y0,X1,Y1));

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex2D(X0,Y0);
    TeeVertex2D(X1,Y0);
    TeeVertex2D(X1,Y1);
    TeeVertex2D(X0,Y1);
    glEnd;
  end;

  Assert(CheckGLError,'Rectangle');
end;

procedure TGLCanvas.SetTextAlign(Align:Integer);
begin
  FTextAlign:=Align;
end;

procedure TGLCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TGLCanvas.Pyramid(Vertical:Boolean; Left,Top,Right,Bottom,z0,z1:Integer; DarkSides:Boolean);
var AWidth,
    AHeight,
    ADepth:Integer;
begin
  glPushMatrix;

  glEnable(GL_CULL_FACE);

  if Vertical then
  begin
    if Left>Right then SwapInteger(Left,Right);
    if Top>Bottom then glDisable(GL_CULL_FACE);
  end
  else
  begin
    if Top>Bottom then SwapInteger(Top,Bottom);
    if Left>Right then glDisable(GL_CULL_FACE);
  end;

  if z0>z1 then SwapInteger(z0,z1);

  glTranslatef(Left,-Bottom,-z0);

  if Vertical then
  begin
    AWidth:=Right-Left;
    AHeight:=Top-Bottom;
  end
  else
  begin
    AWidth:=Bottom-Top;
    AHeight:=Right-Left;
    glRotatef(90,0,0,1);
  end;

  ADepth:=z1-z0;

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;

    glBegin(GL_TRIANGLE_FAN);

    TeeNormal(AWidth div 2,-AHeight,ADepth div 2);

    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeNormal(0,0,-1);
    TeeVertex2D(0,0);
    TeeNormal(1,0,-1);
    TeeVertex2D(AWidth,0);
    TeeNormal(1,0,1);
    TeeVertex3D(AWidth,0,ADepth);
    TeeNormal(0,0,1);
    TeeVertex3D(0,0,ADepth);
    TeeNormal(0,0,-1);
    TeeVertex2D(0,0);

    glEnd;

    RectangleY(0,0,AWidth,0,ADepth);

    EndBrushBitmap;
  end;

  glDisable(GL_CULL_FACE);

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex2D(0,0);
    TeeVertex2D(AWidth,0);
    TeeVertex3D(AWidth,0,ADepth);
    TeeVertex3D(0,0,ADepth);
    glEnd;
    glBegin(GL_LINE_STRIP);
    TeeVertex2D(0,0);
    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeVertex3D(0,0,ADepth);
    glEnd;
    glBegin(GL_LINE_STRIP);
    TeeVertex2D(AWidth,0);
    TeeVertex3D(AWidth div 2,AHeight,ADepth div 2);
    TeeVertex3D(AWidth,0,ADepth);
    glEnd;
  end;

  glPopMatrix;
  Assert(CheckGLError,'Pyramid');
end;

procedure TGLCanvas.InternalCylinder(Vertical:Boolean;
                     Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean;
                     ConePercent:Integer);
Var tmpSize,
    tmp,
    tmp2,
    Radius:Integer;
begin
  glPushMatrix;
  Radius:=Abs(Z1-Z0) div 2;

  if Left>Right then SwapInteger(Left,Right);
  if Top>Bottom then SwapInteger(Top,Bottom);
  if z0>z1 then SwapInteger(z0,z1);

  if Vertical then
  begin
    Radius:=MinInteger((Right-Left) div 2,Radius);
    glTranslatef((Left+Right) div 2,-Top,-(z0+z1) div 2);
    glRotatef(90,1,0,0);
    tmpSize:=Bottom-Top;
  end
  else
  begin
    Radius:=MinInteger((Bottom-Top) div 2,Radius);
    glTranslatef(Left,-(Top+Bottom) div 2,-(z0+z1) div 2);
    glRotatef(90,0,1,0);
    tmpSize:=Right-Left;
  end;

  if ConePercent=100 then tmp:=Radius
                     else tmp:=Round(0.01*ConePercent*Radius);

  tmp2:=Math.Min(TeeNumCylinderSides,6*Radius);

  if Brush.Style<>bsClear then
  begin
    glEnable(GL_CULL_FACE);
    SetColor(Brush.Color);
    SetBrushBitmap;

    {$IFNDEF CLR}
    gluCylinder(Quadric,tmp,Radius,tmpSize,tmp2,TeeCylinderStacks);
    {$ENDIF}
    EndBrushBitmap;

    if ConePercent=100 then
    begin
      {$IFNDEF CLR}
      gluQuadricOrientation(Quadric, GLU_INSIDE);
      gluDisk(Quadric,0,tmp,tmp2,TeeCylinderStacks);
      gluQuadricOrientation(Quadric, GLU_OUTSIDE);
      glPushMatrix;
      glTranslated(0,0,tmpSize);
      gluDisk(Quadric,0,tmp,tmp2,TeeCylinderStacks);
      glPopMatrix;
      {$ENDIF}
    end;

    glDisable(GL_CULL_FACE);
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;

    {$IFNDEF CLR}
    gluQuadricDrawStyle(Quadric, GLU_LINE);
    gluCylinder(Quadric,tmp+0.5,Radius+0.5,tmpSize+0.5,tmp2,6);
    gluQuadricDrawStyle(Quadric, GLU_FILL);
    {$ENDIF}
  end;

  glPopMatrix;
end;

procedure TGLCanvas.Cylinder(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; DarkCover:Boolean);
begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,DarkCover,100);
  Assert(CheckGLError,'Cylinder');
end;

procedure TGLCanvas.Cone(Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer; Dark3D:Boolean; ConePercent:Integer);
begin
  InternalCylinder(Vertical,Left,Top,Right,Bottom,Z0,Z1,Dark3D,ConePercent);
  Assert(CheckGLError,'Cone');
end;

procedure TGLCanvas.Sphere(x,y,z:Integer; Const Radius:Double);
begin
  glPushMatrix;
  glTranslatef(x,-y,-z);

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    glEnable(GL_CULL_FACE);
    SetBrushBitmap;

    {$IFNDEF CLR}
    gluSphere(Quadric,Radius,TeeSphereSlices,TeeSphereStacks);
    {$ENDIF}
    EndBrushBitmap;

    glDisable(GL_CULL_FACE);
  end;

  if Pen.Style<>psClear then // 6.0
  begin
    SetPen;
    {$IFNDEF CLR}
    gluQuadricDrawStyle(Quadric, GLU_LINE);
    gluSphere(Quadric,Radius,TeeSphereSlices,TeeSphereStacks);
    gluQuadricDrawStyle(Quadric, GLU_FILL);
    {$ENDIF}
  end;

  glPopMatrix;
  Assert(CheckGLError,'Sphere');
end;

Procedure TGLCanvas.SetColor(AColor:TColor); {$IFDEF CLR}unsafe;{$ENDIF}
var tmp : GLMat;
begin
  ColorToGL(AColor,tmp);
  glColor4fv(PGLFloat(@tmp));
end;

procedure TGLCanvas.SetPen;
begin
  With Pen do
  begin
    if Style=psSolid then glDisable(GL_LINE_STIPPLE)
    else
    begin
      glEnable(GL_LINE_STIPPLE);
      Case Style of
       psSolid   : glLineStipple(1,$FFFF);
       psDot     : glLineStipple(1,$5555);
       psDash    : glLineStipple(1,$00FF);
       psDashDot : glLineStipple(1,$55FF);
      else
       glLineStipple(1,$1C47);
      end;
    end;

    if not IDrawToBitmap then
       glLineWidth(Width);

    SetColor(Color);
  end;
  Assert(CheckGLError,'SetPen');
end;

procedure TGLCanvas.LineTo(X, Y: Integer);
begin
  SetPen;
  glBegin(GL_LINES);
    TeeVertex2D(FX,FY);
    TeeVertex2D(X,Y);
  glEnd;
  Assert(CheckGLError,'LineTo');

  FX:=X;
  FY:=Y;
end;

procedure TGLCanvas.ClipRectangle(Const Rect:TRect);
begin
end;

procedure TGLCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
//  glEnable(GL_CLIP_PLANE0);
end;

procedure TGLCanvas.UnClipRectangle;
begin
//  glDisable(GL_CLIP_PLANE0);
end;

function TGLCanvas.GetBackColor:TColor;
begin
  result:=clWhite;
end;

procedure TGLCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TGLCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TGLCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Function TGLCanvas.GetPixel(x,y:Integer):TColor;
begin
  result:=clWhite; // 6.0 How to do this in OpenGL ?
end;

Procedure TGLCanvas.SetMonochrome(Value:Boolean);
begin
end;

// Textures

Const MaxTextures=10;
      MaxSizeTexture=800*600;

Type
  TTeeTextureBits=Array[0..MaxSizeTexture, 0..BytesPerPixel] of GLUByte;
  PTeeTextureBits=^TTeeTextureBits;
  TTeeTexture=record
    {$IFNDEF CLR}
    Bits      : PTeeTextureBits;
    Bitmap    : Pointer;
    {$ENDIF}
    GLTexture : {$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
  end;

var
  ITextures   : Array[0..MaxTextures-1] of TTeeTexture;
  NumTextures : Integer=0;

Procedure TGLCanvas.DeleteTextures;
var t:Integer;
begin
  {$IFNDEF CLR}
  for t:=0 to NumTextures-1 do Dispose(ITextures[t].Bits);
  {$ENDIF}
  NumTextures:=0;
end;

Function TGLCanvas.FindTexture(ABitmap:TBitmap):{$IFDEF LINUX}GLBoolean{$ELSE}GLUInt{$ENDIF};
{$IFNDEF CLR}

  Function ValidSize:Boolean;
  var MaxSize : Array[0..0] of Integer;
      tmp : Extended;
  begin
    glGetIntegerv(GL_MAX_TEXTURE_SIZE,@MaxSize);

    result:=(ABitmap.Width<=MaxSize[0]) and (ABitmap.Height<=MaxSize[0]);

    if result then
    begin
      tmp:=Log2(ABitmap.Width);
      result:=Round(tmp)=tmp;

      if result then
      begin
        tmp:=Log2(ABitmap.Height);
        result:=Round(tmp)=tmp;
      end;
    end;
  end;

var t,
    tt,
    tmpPos,
    tmpPos2 : Integer;
    tmp     : TColor;
    tmpLine : PByteArray;
    tmpMode : Integer;
{$ENDIF}
begin
  {$IFNDEF CLR}
  for t:=0 to NumTextures-1 do
  if ITextures[t].Bitmap=ABitmap then
  begin
    result:=ITextures[t].GLTexture;
    exit;
  end;

  if (NumTextures<MaxTextures) and ValidSize then
  begin
    Inc(NumTextures);
    ITextures[NumTextures-1].Bitmap:=ABitmap;

    New(ITextures[NumTextures-1].Bits);

    With ABitmap do
    begin
      PixelFormat:=TeePixelFormat;

      for t:=0 to Height-1 do
      begin
        tmpLine:=PByteArray(ScanLine[t]);

        for tt:=0 to Width-1 do
        begin
          tmpPos:=t*Height+tt;
          tmpPos2:=tt*BytesPerPixel;

          With ITextures[NumTextures-1] do
          begin
            bits^[tmpPos,0]:=tmpLine[tmpPos2+2];
            bits^[tmpPos,1]:=tmpLine[tmpPos2+1];
            bits^[tmpPos,2]:=tmpLine[tmpPos2+0];
            bits^[tmpPos,3]:=255;
          end;
        end;
      end;
    end;

    glPixelStorei(GL_UNPACK_ALIGNMENT, 4);

    {$IFNDEF LINUX}
    glGenTextures(1, @ITextures[NumTextures-1].GLTexture);
    Assert(CheckGLError,'GenTextures');
    glBindTexture(GL_TEXTURE_2D, ITextures[NumTextures-1].GLTexture);
    Assert(CheckGLError,'BinTexture');
    {$ENDIF}

    if TeeWrapTextures then tmpMode:=GL_REPEAT
                       else tmpMode:=GL_CLAMP;

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, tmpMode);
    Assert(CheckGLError,'TexParam1');
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, tmpMode);
    Assert(CheckGLError,'TexParam2');

    tmp:=GL_NEAREST;
    //tmp:=GL_LINEAR;
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, tmp);
    Assert(CheckGLError,'TexParam3');
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, tmp);
    Assert(CheckGLError,'TexParam4');

    glTexEnvi(GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE,GL_DECAL); //GL_MODULATE);
    Assert(CheckGLError,'TexEnvi');

    With ABitmap do
      glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Width, Height, 0,
                   GL_RGBA, GL_UNSIGNED_BYTE, ITextures[NumTextures-1].Bits);

    Assert(CheckGLError,'TextImage2D');

    result:=ITextures[NumTextures-1].GLTexture;
  end
  else result:={$IFDEF LINUX}False{$ELSE}0{$ENDIF};
  {$ENDIF}
end;

procedure TGLCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
var tmp : TBitmap;
    Old : Boolean;
//    tmpTex : Integer;
//    Raster : Array[0..3] of Integer;
begin
  if Assigned(Graphic) then
  begin
    if Graphic is TBitmap then
       tmp:=TBitmap(Graphic)
    else
    begin
      tmp:=TBitmap.Create;
      tmp.Assign(Graphic);
    end;

    Old:=TeeWrapTextures;
    TeeWrapTextures:=False;

    if SetBrushBitmap(tmp) then
    begin
      (*
      tmpTex:=FindTexture(tmp);

      glGetIntegerv(GL_CURRENT_RASTER_POSITION,@Raster);
      glRasterPos2i(Rect.Left,Rect.Top-tmp.Height);
      glGetIntegerv(GL_CURRENT_RASTER_POSITION,@Raster);
      glDrawPixels(tmp.Width,tmp.Height, // Rect.Right-Rect.Left, Rect.Bottom-Rect.Top,
                   GL_RGBA,GL_UNSIGNED_BYTE,ITextures[tmpTex-1].Bits);
      *)

      InternalRectangle(Rect);
      EndBrushBitmap(tmp);
    end;

    TeeWrapTextures:=Old;

    if not (Graphic is TBitmap) then
       tmp.Free;

    Assert(CheckGLError,'StretchDraw');
  end;
end;

procedure TGLCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  if Assigned(Graphic) then
     StretchDraw(TeeRect(X,Y,X+Graphic.Width,Y+Graphic.Height),Graphic);
end;

Procedure TGLCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50);

  Procedure DoVertical(AStartColor,AEndColor:TColor);
  begin
    With Rect do
    begin
      SetColor(AEndColor);
      TeeVertex3D(Right,Bottom,GradientZ);
      SetColor(AStartColor);
      TeeVertex3D(Right,Top,GradientZ);
      TeeVertex3D(Left, Top,GradientZ);
      SetColor(AEndColor);
      TeeVertex3D(Left, Bottom,GradientZ);
    end;
  end;

  Procedure DoHorizontal(AStartColor,AEndColor:TColor);
  begin
    With Rect do
    begin
      SetColor(AEndColor);
      TeeVertex3D(Right,Bottom,GradientZ);
      TeeVertex3D(Right,Top,GradientZ);
      SetColor(AStartColor);
      TeeVertex3D(Left, Top,GradientZ);
      TeeVertex3D(Left, Bottom,GradientZ);
    end;
  end;

  Procedure DoDiagonal(AStartColor,AEndColor:TColor);

    procedure SetMidColor(A,B:TColor);
    var tmpA, tmpB : GLMat;
    begin
      ColorToGL(A,tmpA);
      ColorToGL(B,tmpB);
      tmpA[0]:=(tmpA[0]+tmpB[0])*0.5;
      tmpA[1]:=(tmpA[1]+tmpB[1])*0.5;
      tmpA[2]:=(tmpA[2]+tmpB[2])*0.5;

      {$IFNDEF CLR}
      glColor4fv(PGLFloat(@tmpA));
      {$ENDIF}
    end;

  begin
    With Rect do
    begin
      SetColor(AEndColor);
      TeeVertex3D(Right,Bottom,GradientZ);
      SetMidColor(AEndColor, AStartColor);
      TeeVertex3D(Right,Top,GradientZ);
      SetColor(AStartColor);
      TeeVertex3D(Left, Top,GradientZ);
      SetMidColor(AEndColor, AStartColor);
      TeeVertex3D(Left, Bottom,GradientZ);
    end;
  end;

begin
  Assert(CheckGLError,'Before GradientFill');
  glBegin(GL_QUADS);

  TeeNormal(0,0,-1);
  Case Direction of
     gdTopBottom  : DoVertical(EndColor,StartColor);
     gdBottomTop  : DoVertical(StartColor,EndColor);
     gdLeftRight  : DoHorizontal(EndColor,StartColor);
     gdRightLeft  : DoHorizontal(StartColor,EndColor);
     gdFromBottomLeft,
     gdDiagonalDown: DoDiagonal(StartColor,EndColor);
     gdFromTopLeft,
     gdDiagonalUp:   DoDiagonal(EndColor,StartColor);
  else
     // gdFromCenter : ;
  end;

  glEnd;
  Assert(CheckGLError,'GradientFill');
end;

Procedure TGLCanvas.RectangleY(Left,Top,Right,Z0,Z1:Integer);
begin
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;

    glBegin(GL_QUADS);
    TeeNormal(0,1,0);
    TeeVertex3D(Left, Top,Z1);
    TeeVertex3D(Right,Top,Z1);
    TeeVertex3D(Right,Top,Z0);
    TeeVertex3D(Left, Top,Z0);

    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(Left, Top,Z0);
    TeeVertex3D(Right,Top,Z0);
    TeeVertex3D(Right,Top,Z1);
    TeeVertex3D(Left, Top,Z1);
    glEnd;
  end;

  Assert(CheckGLError,'RectangleY');
end;

Procedure TGLCanvas.RectangleWithZ(Const Rect:TRect; Z:Integer);
begin
  With Rect do
  begin
    if Pen.Style<>psClear then
    begin
      SetPen;
      glBegin(GL_LINE_LOOP);
      TeeVertex3D(Left, Top,   Z);
      TeeVertex3D(Right,Top,   Z);
      TeeVertex3D(Right,Bottom,Z);
      TeeVertex3D(Left, Bottom,Z);
      glEnd;
    end;

    if Brush.Style<>bsClear then
    begin
      SetColor(Brush.Color);
      SetBrushBitmap;
      
      glBegin(GL_QUADS);
      TeeNormal(0,0,-1);
      glTexCoord2f(0,1);
      TeeVertex3D(Left, Top,   Z);
      glTexCoord2f(1,1);
      TeeVertex3D(Left, Bottom,Z);
      glTexCoord2f(1,0);
      TeeVertex3D(Right,Bottom,Z);
      glTexCoord2f(0,0);
      TeeVertex3D(Right,Top,   Z);

      glEnd;
      EndBrushBitmap;
    end;
  end;

  Assert(CheckGLError,'RectangleWithZ');
end;

Procedure TGLCanvas.RectangleZ(Left,Top,Bottom,Z0,Z1:Integer);
begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(Left,Top,   Z0);
    TeeVertex3D(Left,Bottom,Z0);
    TeeVertex3D(Left,Bottom,Z1);
    TeeVertex3D(Left,Top,   Z1);
    glEnd;
  end;

  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;

    glBegin(GL_QUADS);
    TeeNormal(1,0,0);
    glTexCoord2f(0,1);
    TeeVertex3D(Left, Top,   Z0);
    glTexCoord2f(1,1);
    TeeVertex3D(Left, Bottom,Z0);
    glTexCoord2f(1,0);
    TeeVertex3D(Left,Bottom,Z1);
    glTexCoord2f(0,0);
    TeeVertex3D(Left,Top,   Z1);

    glEnd;
    EndBrushBitmap;
  end;

  Assert(CheckGLError,'RectangleZ');
end;

procedure TGLCanvas.InternalRectangle(const Rect: TRect);
begin
  glBegin(GL_QUADS);
  TeeNormal(0,0,-1);

  With Rect do
  begin
    glTexCoord2f(0,0);
    TeeVertex2D(Left, Top);
    glTexCoord2f(0,1);
    TeeVertex2D(Left, Bottom);
    glTexCoord2f(1,1);
    TeeVertex2D(Right,Bottom);
    glTexCoord2f(1,0);
    TeeVertex2D(Right,Top);
  end;

  glEnd;
end;

procedure TGLCanvas.FillRect(const Rect: TRect);
begin
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;
    InternalRectangle(Rect);
    EndBrushBitmap;
  end;

  Assert(CheckGLError,'FillRect '+IntToStr(FSavedError));
end;

procedure TGLCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
  Assert(CheckGLError,'Ellipse');
end;

procedure TGLCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
Const PiStep=Pi/10.0;
var t,XC,YC,XR,YR:Integer;
    tmpSin,tmpCos:Extended;
begin
  XR:=(X2-X1) div 2;
  YR:=(Y2-Y1) div 2;
  XC:=(X1+X2) div 2;
  YC:=(Y1+Y2) div 2;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    for t:=0 to 18 do
    begin
      SinCos(t*piStep,tmpSin,tmpCos);
      TeeVertex3D(XC+Trunc(XR*tmpSin),YC-Trunc(YR*tmpCos),Z);
    end;
    glEnd;
  end;

  if Brush.Style<>bsClear then
  begin
    glBegin(GL_TRIANGLE_FAN);
    SetColor(Brush.Color);
    TeeNormal(0,0,-1);
    TeeVertex3D(XC,YC,Z);
    for t:=0 to 20 do
    begin
      SinCos(t*piStep,tmpSin,tmpCos);
      TeeVertex3D(XC+Trunc(XR*tmpSin),YC-Trunc(YR*tmpCos),Z);
    end;
    glEnd;
  end;
  Assert(CheckGLError,'EllipseWithZ');
end;

Procedure TGLCanvas.EnableRotation;
begin
  glMatrixMode(GL_PROJECTION);
  glPopMatrix;

  glMatrixMode(GL_MODELVIEW);
  glPopMatrix;
  Assert(CheckGLError,'EnableRotation');

  if FIs3D then
  begin
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_LIGHTING);
  end;
end;

Procedure TGLCanvas.DisableRotation;
begin
  glMatrixMode(GL_PROJECTION);
  glPushMatrix;
  glLoadIdentity;

  FDepth:=0;
  glOrtho(0,FWidth+1,0,FHeight+1,0.1,-400);  // 7.0
  Assert(CheckGLError,'Orthogonal');

  glMatrixMode(GL_MODELVIEW);
  glPushMatrix;
  glLoadIdentity;

  RectCenter(Bounds,FXCenter,FYCenter);
  glTranslatef( 0, FHeight, 0);
  Assert(CheckGLError,'DisableRotation');

  if FIs3D then
  begin
    glDisable(GL_DEPTH_TEST);
    glDisable(GL_LIGHTING);
  end;
end;

function TGLCanvas.GetPixel3D(X,Y,Z:Integer): TColor;
begin
  result:=clWhite;  // TODO
end;

procedure TGLCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    glBegin(GL_POINTS);
    SetColor(Value);
    TeeVertex3D(X,Y,Z);
    glEnd;
    Assert(CheckGLError,'Pixel3D');
  end;
end;

procedure TGLCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    glBegin(GL_POINTS);
    SetColor(Value);
    TeeVertex2D(X,Y);
    glEnd;
    Assert(CheckGLError,'Pixel');
  end;
end;

procedure TGLCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  Assert(CheckGLError,'Arc');
//  gluPartialDisk
end;

Function TGLCanvas.BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend;
begin
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
  ITransp:=(100-Transparency)*0.01;
  result:=nil;
end;

procedure TGLCanvas.EndBlending(Blend:TTeeBlend);
begin
  ITransp:=1;
  glDisable(GL_BLEND);
end;

procedure TGLCanvas.Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                           Const StartAngle,EndAngle,HolePercent:Double);
begin
  Pie3D(XCenter,YCenter,XRadius,YRadius,0,0,StartAngle,EndAngle,True,True,Round(HolePercent));
  Assert(CheckGLError,'Donut');
end;

procedure TGLCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var Step, XC,YC : Double;
    Theta,Theta2  : Extended;
    tmpSin,tmpCos : Extended;
    t : Integer;
    tmpX, tmpY    : Double;
    P : Array[0..NumCirclePoints-1] of TPoint;
begin
  CalcPieAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4,Theta,Theta2);

  Step:=(Theta2-Theta)/(NumCirclePoints-1);

  XC:=(X2+X1)*0.5;
  YC:=(Y2+Y1)*0.5;

  P[0].X:=Round(XC);
  P[0].Y:=Round(YC);

  tmpX:=XC-X1;
  tmpY:=YC-Y1;

  for t:=1 to NumCirclePoints-1 do
  begin
    SinCos(((Pi*0.5)+Theta+(t*Step))*TeePiStep,tmpSin,tmpCos);
    P[t].X:=Round(XC+(tmpX*tmpCos+tmpY*tmpSin));
    P[t].Y:=Round(YC+(-tmpX*tmpSin+tmpY*tmpCos));
  end;

  Polygon(P);

  Assert(CheckGLError,'Pie');
end;

procedure TGLCanvas.Pie3D( XCenter,YCenter,XRadius,YRadius,Z0,Z1:Integer;
                           Const StartAngle,EndAngle:Double;
                           DarkSides,DrawSides:Boolean;
                           DonutPercent:Integer=0;
                           Gradient:TCustomTeeGradient=nil);

Const NumSliceParts=16;

Var piStep     : Double;
    tmpSin     : Extended;
    tmpCos     : Extended;
    tmpXRadius : Double;
    tmpYRadius : Double;

  Procedure GetXY(t:Integer; var x,y:Integer);
  begin
    SinCos(((Pi*0.5)+StartAngle)+(t*piStep),tmpSin,tmpCos);
    X:=Trunc(tmpXRadius*tmpSin);
    Y:=Trunc(tmpYRadius*tmpCos);
  end;

  Procedure DrawPieSlice(z,ANormal:Integer);

    Procedure DrawSlice;
    var t : Integer;

      Procedure DrawSliceStep;
      var X,Y : Integer;
      begin
        GetXY(t,X,Y);
        TeeVertex3D(X,z,Y);
      end;

    begin
      TeeVertex3D(0,z,0);
      if z=z1 then for t:=0 to NumSliceParts do DrawSliceStep
              else for t:=NumSliceParts downto 0 do DrawSliceStep;
    end;

  begin
    if Pen.Style<>psClear then
    begin
      SetPen;
      glBegin(GL_LINE_LOOP);
      DrawSlice;
      glEnd;
    end;

    if Brush.Style<>bsClear then
    begin
      glBegin(GL_TRIANGLE_FAN);
      SetColor(Brush.Color);
      SetBrushBitmap;
      TeeNormal(0,ANormal,0);
      DrawSlice;
      glEnd;
      EndBrushBitmap;
    end;
  end;

  Procedure DrawCover;
  var t,x,y : Integer;
  begin
    glBegin(GL_QUAD_STRIP);
    SetColor(Brush.Color);
    SetBrushBitmap;
    TeeNormal(0,1,0);
    for t:=0 to NumSliceParts do
    begin
      GetXY(t,X,Y);
      TeeVertex3D(X,Z1,Y);
      TeeVertex3D(X,Z0,Y);
    end;
    glEnd;
    EndBrushBitmap;

    if Pen.Style<>psClear then
    begin
      GetXY(0,X,Y);
      MoveTo3D(X,Z0,Y);
      LineTo3D(X,Z1,Y);
    end;
  end;

  Procedure DrawSide(Const AAngle:Double);
  begin
    SinCos(AAngle,tmpSin,tmpCos);
    Plane3D(TeePoint(0,0),TeePoint(Round(tmpXRadius*tmpSin),Round(tmpYRadius*tmpCos)),Z0,Z1);
  end;

begin
  glPushMatrix;
  glTranslatef(XCenter,-YCenter,0); //z1-z0);
  glRotatef(180,1,0,0);
  piStep:=(EndAngle-StartAngle)/NumSliceParts;

  if DonutPercent>0 then
  begin
    tmpXRadius:=DonutPercent*XRadius*0.01;
    tmpYRadius:=DonutPercent*YRadius*0.01;
  end
  else
  begin
    tmpXRadius:=XRadius;
    tmpYRadius:=YRadius;
  end;

  if DrawSides then
  begin
    DrawSide(StartAngle);
    DrawSide(EndAngle);
  end;

  glEnable(GL_CULL_FACE);
  DrawCover;
  DrawPieSlice(z1,-1);
  DrawPieSlice(z0,1);
  glDisable(GL_CULL_FACE);
  glPopMatrix;
  Assert(CheckGLError,'Pie3D');
end;

procedure TGLCanvas.Polyline(const Points:{$IFDEF D5}array of TPoint{$ELSE}TPointArray{$ENDIF}); // 6.0
var Count : Integer;
    t     : Integer;
begin
  Count:=Length(Points);
  if Count>0 then
  begin
    SetPen;
    glBegin(GL_LINES);
    for t:=0 to Count-1 do TeeVertex2D(Points[t].X,Points[t].Y);
    glEnd;
    FX:=Points[0].X;
    FY:=Points[0].Y;
    Assert(CheckGLError,'Polyline');
  end;
end;

procedure TGLCanvas.Polygon(const Points: array of TPoint);
begin
  PolygonWithZ(Points,0);
  Assert(CheckGLError,'Polygon');
end;

procedure TGLCanvas.PlaneFour3D(Var Points:TFourPoints; Z0,Z1:Integer); {$IFDEF CLR}unsafe;{$ENDIF}
var tmpNormal:GLMat;

  Procedure CalcNormalPlaneFour;
  var Qx,Qy,Qz,Px,Py,Pz:Double;
  begin
    Qx:= Points[3].x-Points[2].x;
    Qy:= Points[3].y-Points[2].y;
    Qz:= z1-z1;
    Px:= Points[0].x-Points[2].x;
    Py:= Points[0].y-Points[2].y;
    Pz:= z0-z1;
    tmpNormal[0]:= (Py*Qz - Pz*Qy);
    tmpNormal[1]:= (Pz*Qx - Px*Qz);
    tmpNormal[2]:= -(Px*Qy - Py*Qx);
  end;

  Procedure AddPoints;
  begin
    With Points[0] do TeeVertex3D(x,y,z0);
    With Points[1] do TeeVertex3D(x,y,z0);
    With Points[2] do TeeVertex3D(x,y,z1);
    With Points[3] do TeeVertex3D(x,y,z1);
  end;

begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    AddPoints;
    glEnd;
  end;

  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    CalcNormalPlaneFour;
    glNormal3fv(PGLFloat(@tmpNormal));
    SetColor(Brush.Color);
    SetBrushBitmap;
    AddPoints;
    glEnd;
    EndBrushBitmap;
  end;

  Assert(CheckGLError,'PlaneFour3D');
end;

procedure TGLCanvas.Polygon3D(const Points: array of TPoint3D);

  Procedure AddPoints;
  var t : Integer;
  begin
    for t:=Low(Points) to High(Points) do
    begin
      With Points[t] do
      begin
        TeeNormal(x,y,z);
        glTexCoord3i(x,y,z);
        TeeVertex3D(x,y,z);
      end;
    end;
  end;

begin
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;
    glBegin(GL_POLYGON);
    AddPoints;
    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    AddPoints;
    glEnd;
  end;

  Assert(CheckGLError,'Polygon3D');
end;

procedure TGLCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  Rectangle(X1,Y1,X2,Y2);
  Assert(CheckGLError,'RoundRect');
end;

Procedure TGLCanvas.Repaint;
begin
  if Assigned(View3DOptions) then View3DOptions.Repaint;
end;

Procedure TGLCanvas.Invalidate;
begin
end;

{$IFNDEF LINUX}
Procedure TGLCanvas.CreateFontOutlines(Index:Integer);
var FontMode : Integer;
begin
  if FontOutlines then FontMode:=WGL_FONT_LINES
                  else FontMode:=WGL_FONT_POLYGONS;

  {$IFNDEF CLR}
  wglUseFontOutlines(GetDCHandle,32,TeeFontListRange,FontCache[Index].Offset,
                     0.1,
                     FontExtrusion,FontMode,nil);
  {$ENDIF}

  Assert(CheckGLError,'InitFont');
end;
{$ENDIF}

Function TGLCanvas.FontWeight:Integer;
begin
  if fsBold in Font.Style then
     result:=FW_BOLD
  else
     result:=FW_NORMAL;
end;

Procedure TGLCanvas.InitOpenGLFont;

  Function FontPitch:Cardinal;
  begin
    case Font.Pitch of
      fpVariable: result:=VARIABLE_PITCH;
      fpFixed: result:=FIXED_PITCH;
    else
      result:=DEFAULT_PITCH;
    end;
  end;

{$IFNDEF LINUX}
var Old,
    HFont    : THandle;
    tmpItalic,
    tmpUnderline,
    tmpStrike : Boolean;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  tmpItalic:=fsItalic in Font.Style;
  tmpUnderline:=fsUnderline in Font.Style;
  tmpStrike:=fsStrikeOut in Font.Style;

  HFont := CreateFont(-12, 0, 0, 0, FontWeight,
		      Cardinal(tmpItalic), Byte(tmpUnderline),
                      Cardinal(tmpStrike),
                      {$IFDEF CLX}Cardinal{$ENDIF}(Font.Charset),
		      OUT_DEFAULT_PRECIS,
                      CLIP_DEFAULT_PRECIS,
                      TeeFontAntiAlias, // DEFAULT_QUALITY {DRAFT_QUALITY},
		      FontPitch or FF_DONTCARE {FIXED_PITCH or FF_MODERN},
                      {$IFNDEF CLR}PAnsiChar{$ENDIF}(Font.Name));

  Old:=SelectObject(GetDCHandle, HFont);
  FontCache[INumFonts].Offset:=(INumFonts+1)*1000;
  CreateFontOutlines(INumFonts);
  DeleteObject(SelectObject(GetDCHandle,Old));

  FontCache[INumFonts].Name:=Font.Name;
  FontCache[INumFonts].Weight:=FontWeight;
  FontCache[INumFonts].Style:=Font.Style;
  {$ENDIF}
end;

Procedure TGLCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);

  Function FindFont:Integer;
  var t : Integer;
  begin
    for t:=0 to INumFonts-1 do
    with FontCache[t] do
    if (Name=Font.Name) and
       (Weight=FontWeight) and
       (Style=Font.Style) then
    begin
      result:=t;
      exit;
    end;

    if INumFonts<TeeMaxFonts then
    begin
      InitOpenGLFont;
      result:=INumFonts;
      Inc(INumFonts);
    end
    else result:=0;
  end;

var tmp       : TSize;
    tmpLength : Integer;
    tmpSize   : Double;
    tmpAlign  : Integer;
    tmpFont   : Integer;
begin
  tmpFont:=FindFont;

  tmpLength:=Length(Text);

  ReferenceCanvas.Font.Assign(Font);
  tmp:=ReferenceCanvas.TextExtent(Text);

  tmpAlign:=FTextAlign;
  if tmpAlign>=TA_BOTTOM then
     Dec(tmpAlign,TA_BOTTOM)
  else
     Inc(y,Round(0.7*tmp.Cy));

  if tmpAlign=TA_CENTER then
     Dec(x,Round(0.55*tmp.Cx))
  else
  if tmpAlign=TA_RIGHT then
     Dec(x,tmp.Cx+(tmpLength div 2));               {-Round(Sqr(tmp.Cx)/19.0)}

  if FontExtrusion>0 then
     glEnable(GL_CULL_FACE);

  glPushMatrix;

  glTranslatef(x+1,-y-2,-z+2);

(*
//  if FTextToViewer
  With View3DOptions do
  begin
    glRotatef(360-Tilt, 0, 0, 1);
    glRotatef(360-Rotation, 0, 1, 0);
    if not Orthogonal then glRotatef(360+Elevation, 1, 0, 0);
  end;
*)

  if TeeTextAngleY<>0 then glRotatef(TeeTextAngleY,1,0,0);
  if TeeTextAngleZ<>0 then glRotatef(TeeTextAngleZ,0,1,0);

  // Other font rotations: glRotatef(270,1,0,0);
  tmpSize:=Font.Size;
  glScalef(tmpSize*1.41,tmpSize*1.6,1);
  TeeNormal(0,0,1);

  glListBase(FontCache[tmpFont].Offset-32);

  if Assigned(IFont) then
  With IFont.Shadow do
  if (HorizSize<>0) or (VertSize<>0) then
  begin
    //if Transparency>0 then
    //   tmpBlend:=BeginBlending(RectText(tmpX,tmpY),Transparency)
    //else
    //   tmpBlend:=nil;

    glPushMatrix;
    glTranslatef(0.03*HorizSize,-0.03*VertSize,0);

    SetColor(Color);

    {$IFNDEF CLR}
    glCallLists(tmpLength, GL_UNSIGNED_BYTE, PChar(Text));
    {$ENDIF}

    //if Transparency>0 then EndBlending(tmpBlend);

    glPopMatrix;
  end;

  SetColor(Font.Color);

  {$IFNDEF CLR}
  glCallLists(tmpLength, GL_UNSIGNED_BYTE, PChar(Text));
  {$ENDIF}

  glPopMatrix;
  Assert(CheckGLError,'TextOut3D');

  if FontExtrusion>0 then
  begin
    glDisable(GL_CULL_FACE);
    glFrontFace(GL_CCW);
    Assert(CheckGLError,'FrontFace');
  end;
end;

Procedure TGLCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(x,y,0,Text);
end;

procedure TGLCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  FX:=X;
  FY:=Y;
  FZ:=Z;
end;

procedure TGLCanvas.LineTo3D(X,Y,Z:Integer);
begin
  SetPen;
  glBegin(GL_LINES);
  TeeVertex3D(FX,FY,FZ);
  TeeVertex3D(x,y,z);
  glEnd;
  FX:=X;
  FY:=Y;
  FZ:=Z;
  Assert(CheckGLError,'LineTo3D');
end;

procedure TGLCanvas.PlaneWithZ(P1,P2,P3,P4:TPoint; Z:Integer);
begin
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(P1.X,P1.Y,Z);
    TeeVertex3D(P2.X,P2.Y,Z);
    TeeVertex3D(P3.X,P3.Y,Z);
    TeeVertex3D(P4.X,P4.Y,Z);
    glEnd;
  end;
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    SetColor(Brush.Color);
    TeeNormal(0,0,-1);
    TeeVertex3D(P1.X,P1.Y,Z);
    TeeVertex3D(P2.X,P2.Y,Z);
    TeeVertex3D(P3.X,P3.Y,Z);
    TeeVertex3D(P4.X,P4.Y,Z);
    glEnd;
  end;
  Assert(CheckGLError,'PlaneWithZ');
end;

procedure TGLCanvas.Plane3D(Const A,B:TPoint; Z0,Z1:Integer);
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_QUADS);
    TeeNormal(0,1,0);  { <-- CalcNormal }
    SetColor(Brush.Color);
    TeeVertex3D(A.X,A.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z1);
    TeeVertex3D(A.X,A.Y,Z1);
    glEnd;
  end;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    TeeVertex3D(A.X,A.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z0);
    TeeVertex3D(B.X,B.Y,Z1);
    TeeVertex3D(A.X,A.Y,Z1);
    glEnd;
  end;
  Assert(CheckGLError,'Plane3D');
end;

procedure TGLCanvas.SetDrawStyle(Value:TTeeCanvasSurfaceStyle);
begin
  if Value=tcsWire then
     glPolygonMode(GL_FRONT_AND_BACK,GL_LINE)
  else
  if Value=tcsDot then
     glPolygonMode(GL_FRONT_AND_BACK,GL_POINT)
  else
     glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
end;

Function TGLCanvas.GetSupports3DText:Boolean;
begin
  result:=True;
end;

Function TGLCanvas.GetSupportsFullRotation:Boolean;
begin
  result:=True;
end;

Function TGLCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

Function TGLCanvas.GetUseBuffer:Boolean;
begin
  result:=FUseBuffer;
end;

Procedure TGLCanvas.SetUseBuffer(Value:Boolean);
begin
  FUseBuffer:=Value;
  IDestCanvas:=nil;
  DeleteFont;
end;

Procedure TGLCanvas.DeleteFont;
var t : Integer;
begin
  for t:=0 to INumFonts-1 do
  begin
    glDeleteLists(FontCache[t].Offset,TeeFontListRange);
    Assert(CheckGLError,'DeleteFont '+IntToStr(FSavedError));
  end;

  INumFonts:=0;
end;

Function TGLCanvas.GetHandle:TTeeCanvasHandle;
begin
  result:=FDC;
end;

Procedure TGLCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  MoveTo(X0,Y);
  LineTo(X1,Y);
end;

Procedure TGLCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  MoveTo(X,Y0);
  LineTo(X,Y1);
end;

procedure TGLCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
  glPushMatrix;
  glTranslatef(x,-y,0);
  glRotatef(RotDegree,0,0,1);
  glTranslatef(-x,y,z);
  TextOut(X,Y,St);
  glPopMatrix;
  Assert(CheckGLError,'RotateLabel3D');
end;

procedure TGLCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Procedure TGLCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
end;

// Nothing to do here. OpenGL already clears it...
procedure TGLCanvas.EraseBackground(const Rect: TRect);
begin
end;

Procedure TGLCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
begin
  MoveTo3D(Left,Y,Z);
  LineTo3D(Right,Y,Z);
end;

Procedure TGLCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
begin
  MoveTo3D(X,Top,Z);
  LineTo3D(X,Bottom,Z);
end;

Procedure TGLCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
begin
  MoveTo3D(X,Y,Z0);
  LineTo3D(X,Y,Z1);
end;

Procedure TGLCanvas.Arrow( Filled:Boolean;
                           Const FromPoint,ToPoint:TPoint;
                           ArrowWidth,ArrowHeight,Z:Integer);
Var x    : Double;
    y    : Double;
    SinA : Double;
    CosA : Double;

    Function CalcArrowPoint:TPoint;
    Begin
      result.X:=Round( x*CosA + y*SinA);
      result.Y:=Round(-x*SinA + y*CosA);
    end;

Var tmpHoriz  : Integer;
    tmpVert   : Integer;
    dx        : Integer;
    dy        : Integer;
    tmpHoriz4 : Double;
    xb        : Double;
    yb        : Double;
    l         : Double;

   { These are the Arrows points coordinates }
    To3D,pc,pd,pe,pf,pg,ph:TPoint;

    (*           pc
                   |\
    ph           pf| \
      |------------   \ ToPoint
 From |------------   /
    pg           pe| /
                   |/
                 pd
    *)
begin
  Assert(CheckGLError,'BeforeArrow');
  dx := ToPoint.x-FromPoint.x;
  dy := FromPoint.y-ToPoint.y;

  l  := TeeDistance(dx,dy);

  if l>0 then  { if at least one pixel... }
  Begin
    tmpHoriz:=ArrowWidth;
    tmpVert :=Math.Min(Round(l),ArrowHeight);
    SinA:= dy / l;
    CosA:= dx / l;
    xb:= ToPoint.x*CosA - ToPoint.y*SinA;
    yb:= ToPoint.x*SinA + ToPoint.y*CosA;
    x := xb - tmpVert;
    y := yb - tmpHoriz/2;
    pc:=CalcArrowPoint;
    y := yb + tmpHoriz/2;
    pd:=CalcArrowPoint;
    if Filled then
    Begin
      tmpHoriz4:=tmpHoriz/4;
      y := yb - tmpHoriz4;
      pe:=CalcArrowPoint;
      y := yb + tmpHoriz4;
      pf:=CalcArrowPoint;
      x := FromPoint.x*cosa - FromPoint.y*sina;
      y := yb - tmpHoriz4;
      pg:=CalcArrowPoint;
      y := yb + tmpHoriz4;
      ph:=CalcArrowPoint;
      To3D:=ToPoint;
      PolygonWithZ([ph,pg,pe,pf],Z);
      PolygonWithZ([pc,To3D,pd],Z);
    end
    else
    begin
      MoveTo3D(FromPoint.x,FromPoint.y,z);
      LineTo3D(ToPoint.x,ToPoint.y,z);
      LineTo3D(pd.x,pd.y,z);
      MoveTo3D(ToPoint.x,ToPoint.y,z);
      LineTo3D(pc.x,pc.y,z);
    end;
  end;
  Assert(CheckGLError,'Arrow');
end;

Procedure TGLCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  MoveTo3D(X0,Y0,Z);
  LineTo3D(X1,Y1,Z);
end;

procedure TGLCanvas.PolygonWithZ(Points: array of TPoint; Z:Integer);

  Procedure AddPoints;
  var t : Integer;
  begin
    for t:=Low(Points) to High(Points) do
    begin
        With Points[t] do TeeVertex3D(x,y,z);
    end;
  end;

begin
  if Brush.Style<>bsClear then
  begin
    SetColor(Brush.Color);
    SetBrushBitmap;
    glBegin(GL_POLYGON);
    TeeNormal(0,0,-1);
    AddPoints;
    glEnd;
    EndBrushBitmap;
  end;

  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    AddPoints;
    glEnd;
  end;

  Assert(CheckGLError,'PolygonWithZ');
end;

procedure TGLCanvas.Triangle3D( Const Points:TTrianglePoints3D;
                                Const Colors:TTriangleColors3D);
var t:Integer;
begin
  if Brush.Style<>bsClear then
  begin
    glBegin(GL_POLYGON);
    TeeNormal(0,0,-1);  { <-- calc Normal }
    SetColor(Colors[0]);
    With Points[0] do TeeVertex3D(x,y,z);
    SetColor(Colors[1]);
    With Points[1] do TeeVertex3D(x,y,z);
    SetColor(Colors[2]);
    With Points[2] do TeeVertex3D(x,y,z);
    glEnd;
  end;
  if Pen.Style<>psClear then
  begin
    SetPen;
    glBegin(GL_LINE_LOOP);
    for t:=0 to 2 do With Points[t] do TeeVertex3D(x,y,z);
    glEnd;
  end;
  Assert(CheckGLError,'Triangle3D');
end;

procedure TGLCanvas.TriangleWithZ(Const P1,P2,P3:TPoint; Z:Integer);
begin
  PolygonWithZ([P1,P2,P3],Z);
end;

Function TGLCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TGLCanvas.Surface3D( Style:TTeeCanvasSurfaceStyle;
                               SameBrush:Boolean;
                               NumXValues,NumZValues:Integer;
                               CalcPoints:TTeeCanvasCalcPoints);

  Procedure DrawCells;
  var tmpX,
      tmpZ : Integer;

    Procedure AddVertexs;
    Var tmpColor0,
        tmpColor1 : TColor;
        P0        : TPoint3D;
        P1        : TPoint3D;
    begin 
      if CalcPoints(tmpX,tmpZ+1,P0,P1,tmpColor0,tmpColor1) then
      begin
        if SameBrush then
        begin
          With P0 do TeeVertex3D(x,y,z);
          With P1 do TeeVertex3D(x,y,z);
        end
        else
        begin
          if tmpColor0<>clNone then SetColor(tmpColor0);
          With P0 do TeeVertex3D(x,y,z);
          if tmpColor1<>clNone then SetColor(tmpColor1);
          With P1 do TeeVertex3D(x,y,z);
        end;
      end
      else
      begin
        glEnd;
        glBegin(GL_QUAD_STRIP);
        TeeNormal(0,-1,0);
      end;
    end;

  begin
    for tmpX:=2 to NumXValues do
    begin
      glBegin(GL_QUAD_STRIP);
      TeeNormal(0,1,0);
      for tmpZ:=NumZValues-1 downto 0 do AddVertexs;
      glEnd;
    end;
  end;

begin
  SetPen;
  if (Style=tcsSolid) or (not SameBrush) then SetColor(Brush.Color);

  if DrawStyle=tcsSolid then SetDrawStyle(Style);

  DrawCells;

  if (Pen.Style<>psClear) and (Style=tcsSolid) then
  begin
    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    SetColor(Pen.Color);
    SameBrush:=True;
    DrawCells;
  end;

  SetDrawStyle(DrawStyle);
  Assert(CheckGLError,'Surface3D');
end;

procedure TGLCanvas.PyramidTrunc(Const R: TRect; StartZ, EndZ: Integer;
                                 TruncX,TruncZ:Integer);
begin
  Pyramid(True,R.Left,R.Top,R.Right,R.Bottom,StartZ,EndZ,True);
end;


// TGLShape
constructor TGLShape.Create(ACanvas: TGLCanvas);
begin
  inherited Create;
  FBrush:=TChartBrush.Create(nil);
  FBrush.Color:=clWhite;
  FPen:=TChartPen.Create(nil);
  Canvas:=ACanvas;
end;

Destructor TGLShape.Destroy;
begin
  FPen.Free;
  FBrush.Free;
  inherited;
end;

procedure TGLShape.SetBrush(const Value:TChartBrush);
begin
  FBrush.Assign(Value);
end;

procedure TGLShape.SetPen(const Value:TChartPen);
begin
  FPen.Assign(Value);
end;

procedure TGLShape.PushMatrix;
begin
  glPushMatrix;
  glRotated(Rotation,0,0,1);
  glRotated(Elevation,1,0,0);
  glRotated(Tilt,0,1,0);
end;

procedure TGLShape.PopMatrix;
begin
  glPopMatrix;
end;

procedure TGLShape.Draw(X,Y:Integer);
begin
  Canvas.AssignVisiblePen(FPen);
  Canvas.AssignBrush(FBrush,FBrush.Color);
end;

// TGLTorus
constructor TGLTorus.Create(ACanvas: TGLCanvas);
begin
  inherited;
  Inner:=50;
  Outer:=100;
  Rings:=30;
  Sides:=10;
end;

procedure TGLTorus.Draw(X,Y:Integer);
{$IFNDEF CLR}
var vertex, normal : Array of TPoint3DFloat;

  Procedure DrawAll;
  var Index, t, tt:Integer;
  begin
    for t:=0 to Sides-2 do
      for tt:=0 to Rings-2 do
      begin
        Index:= 3 * ( tt*Sides + t ) ;
        glNormal3dv( @normal[ Index + 3 ]);
        glVertex3dv( @vertex[ Index + 3 ]);
        glNormal3dv( @normal[ Index ] );
        glVertex3dv( @vertex[ Index ] );
        glNormal3dv( @normal[ Index + 3 * Sides ]);
        glVertex3dv( @vertex[ Index + 3 * Sides ]);
        glNormal3dv( @normal[ Index + 3 * Sides + 3 ]);
        glVertex3dv( @vertex[ Index + 3 * Sides + 3 ]);
      end;
  end;

Const TwoPi=2*Pi;
var
  dpsi, dphi : Double;
  Index , t, tt : Integer;
  spsi,
  cpsi,
  sphi, cphi : Extended;
begin
  inherited;

  Inc(Sides);
  Inc(Rings);

  SetLength(vertex,3 * Sides * Rings);
  SetLength(normal,3 * Sides * Rings );

  dpsi:= TwoPi / (Rings-1) ;
  dphi:= TwoPi / (Sides-1) ;

  for tt:=0 to Rings-1 do
  begin
    SinCos(tt*dpsi, spsi, cpsi);

    for t:=0 to Sides-1 do
    begin
      SinCos(t*dphi, sphi, cphi);
      Index:= 3 * ( tt*Sides + t );

      vertex[Index].X:= cpsi * ( Outer + cphi * Inner) ;
      vertex[Index].Y:= spsi * ( Outer + cphi * Inner) ;
      vertex[Index].Z:= sphi * Inner;
      normal[Index].X:= cpsi * cphi ;
      normal[Index].Y:= spsi * cphi ;
      normal[Index].Z:= sphi ;
    end;
  end;

  PushMatrix;

  if Canvas.Brush.Style<>bsClear then
  begin
    Canvas.SetColor(Canvas.Brush.Color);
    Canvas.SetBrushBitmap;

    glEnable(GL_CULL_FACE);
    glBegin(GL_QUADS);
    DrawAll;
    glEnd;
    Canvas.EndBrushBitmap;
    glDisable(GL_CULL_FACE);
  end;

  if Canvas.Pen.Style<>psClear then
  begin
    Canvas.SetPen;
    glBegin(GL_LINE_LOOP);
    DrawAll;
    glEnd;
  end;

  vertex:=nil;
  normal:=nil;

  PopMatrix;
{$ELSE}
begin
{$ENDIF}
end;

end.

