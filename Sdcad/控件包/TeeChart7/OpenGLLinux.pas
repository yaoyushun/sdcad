{**************************************
     opengl interface unit for kylix
     version 0.1
     created by pinxue
     2001.3.12
     pinxue@263.net
     http://pinxue.yeah.net
     
notes:
     this unit is based on free pascal compiler's opengl package 
     and delphi-jedi's opengl 1.2 unit and mesa's .h
     mesa special extensions have been removed.
     I DON'T KNOW IS THERE ANY COPYRIGHT PROBLEM,
     IF YOU KNOW, MAIL ME PLEASE, THANKS.
     IF I HAVE THIS RIGHT, I MAKE THIS UNIT FOLLOW LGPL LICENSE.
**************************************}

unit OpenGLLinux;

interface

uses Xlib;

type
  {$EXTERNALSYM HGLRC}
  HGLRC = THandle;

type
  GLenum = Cardinal;
  {$EXTERNALSYM GLenum}
  GLboolean = BYTEBOOL;
  {$EXTERNALSYM GLboolean}
  GLbitfield = Cardinal;
  {$EXTERNALSYM GLbitfield}
  GLbyte = Shortint;   { signed char }
  {$EXTERNALSYM GLbyte}
  GLshort = SmallInt;
  {$EXTERNALSYM GLshort}
  GLint = Integer;
  {$EXTERNALSYM GLint}
  GLsizei = Integer;
  {$EXTERNALSYM GLsizei}
  GLubyte = Byte;
  {$EXTERNALSYM GLubyte}
  GLushort = Word;
  {$EXTERNALSYM GLushort}
  GLuint = Cardinal;
  {$EXTERNALSYM GLuint}
  GLfloat = Single;
  {$EXTERNALSYM GLfloat}
  GLclampf = Single;
  {$EXTERNALSYM GLclampf}
  GLdouble = Double;
  {$EXTERNALSYM GLdouble}
  GLclampd = Double;
  {$EXTERNALSYM GLclampd}

  PGLBoolean = ^GLBoolean;
  PGLByte = ^GLByte;
  PGLShort = ^GLShort;
  PGLInt = ^GLInt;
  PGLSizei = ^GLSizei;
  PGLubyte = ^GLubyte;
  PGLushort = ^GLushort;
  PGLuint = ^GLuint;
  PGLclampf = ^GLclampf;
  PGLfloat =  ^GLFloat;
  PGLdouble = ^GLDouble;
  PGLclampd = ^GLclampd;

  TGLArrayf4 = array [0..3] of GLFloat;
  TGLArrayf3 = array [0..2] of GLFloat;
  TGLArrayi4 = array [0..3] of GLint;
  {...}

{ OpenGL X glue const (glx.h) ========}
// Tokens for glXChooseVisual and glXGetConfig:
const
  GLX_USE_GL                            = 1;
  GLX_BUFFER_SIZE                       = 2;
  GLX_LEVEL                             = 3;
  GLX_RGBA                              = 4;
  GLX_DOUBLEBUFFER                      = 5;
  GLX_STEREO                            = 6;
  GLX_AUX_BUFFERS                       = 7;
  GLX_RED_SIZE                          = 8;
  GLX_GREEN_SIZE                        = 9;
  GLX_BLUE_SIZE                         = 10;
  GLX_ALPHA_SIZE                        = 11;
  GLX_DEPTH_SIZE                        = 12;
  GLX_STENCIL_SIZE                      = 13;
  GLX_ACCUM_RED_SIZE                    = 14;
  GLX_ACCUM_GREEN_SIZE                  = 15;
  GLX_ACCUM_BLUE_SIZE                   = 16;
  GLX_ACCUM_ALPHA_SIZE                  = 17;

  // GLX_EXT_visual_info extension
  GLX_X_VISUAL_TYPE_EXT                 = $22;
  GLX_TRANSPARENT_TYPE_EXT              = $23;
  GLX_TRANSPARENT_INDEX_VALUE_EXT       = $24;
  GLX_TRANSPARENT_RED_VALUE_EXT         = $25;
  GLX_TRANSPARENT_GREEN_VALUE_EXT       = $26;
  GLX_TRANSPARENT_BLUE_VALUE_EXT        = $27;
  GLX_TRANSPARENT_ALPHA_VALUE_EXT       = $28;


  // Error codes returned by glXGetConfig:
  GLX_BAD_SCREEN                        = 1;
  GLX_BAD_ATTRIBUTE                     = 2;
  GLX_NO_EXTENSION                      = 3;
  GLX_BAD_VISUAL                        = 4;
  GLX_BAD_CONTEXT                       = 5;
  GLX_BAD_VALUE                         = 6;
  GLX_BAD_ENUM                          = 7;

  // GLX 1.1 and later:
  GLX_VENDOR                            = 1;
  GLX_VERSION                           = 2;
  GLX_EXTENSIONS                        = 3;

  // GLX_visual_info extension
  GLX_TRUE_COLOR_EXT                    = $8002;
  GLX_DIRECT_COLOR_EXT                  = $8003;
  GLX_PSEUDO_COLOR_EXT                  = $8004;
  GLX_STATIC_COLOR_EXT                  = $8005;
  GLX_GRAY_SCALE_EXT                    = $8006;
  GLX_STATIC_GRAY_EXT                   = $8007;
  GLX_NONE_EXT                          = $8000;
  GLX_TRANSPARENT_RGB_EXT               = $8008;
  GLX_TRANSPARENT_INDEX_EXT             = $8009;

{ OpenGL X glue type(glx.h) ========}
// Tokens for glXChooseVisual and glXGetConfig:
type
  // From XLib:
  XPixmap = XID;
  XFont = XID;
  XColormap = XID;

  GLXContext = Pointer;
  GLXPixmap = XID;
  GLXDrawable = XID;
  GLXContextID = XID;

function XSetStandardProperties(dpy:PDisplay;win:TWindow;window_name:pchar;icon_name:pchar;icon_pixmap:Pixmap;argv:PChar;arc:Integer;hits:LongInt):integer; //PXSizeHits);

{*************************************************************}


const
{ AttribMask }
  GL_CURRENT_BIT                      = $00000001;
  {$EXTERNALSYM GL_CURRENT_BIT}
  GL_POINT_BIT                        = $00000002;
  {$EXTERNALSYM GL_POINT_BIT}
  GL_LINE_BIT                         = $00000004;
  {$EXTERNALSYM GL_LINE_BIT}
  GL_POLYGON_BIT                      = $00000008;
  {$EXTERNALSYM GL_POLYGON_BIT}
  GL_POLYGON_STIPPLE_BIT              = $00000010;
  {$EXTERNALSYM GL_POLYGON_STIPPLE_BIT}
  GL_PIXEL_MODE_BIT                   = $00000020;
  {$EXTERNALSYM GL_PIXEL_MODE_BIT}
  GL_LIGHTING_BIT                     = $00000040;
  {$EXTERNALSYM GL_LIGHTING_BIT}
  GL_FOG_BIT                          = $00000080;
  {$EXTERNALSYM GL_FOG_BIT}
  GL_DEPTH_BUFFER_BIT                 = $00000100;
  {$EXTERNALSYM GL_DEPTH_BUFFER_BIT}
  GL_ACCUM_BUFFER_BIT                 = $00000200;
  {$EXTERNALSYM GL_ACCUM_BUFFER_BIT}
  GL_STENCIL_BUFFER_BIT               = $00000400;
  {$EXTERNALSYM GL_STENCIL_BUFFER_BIT}
  GL_VIEWPORT_BIT                     = $00000800;
  {$EXTERNALSYM GL_VIEWPORT_BIT}
  GL_TRANSFORM_BIT                    = $00001000;
  {$EXTERNALSYM GL_TRANSFORM_BIT}
  GL_ENABLE_BIT                       = $00002000;
  {$EXTERNALSYM GL_ENABLE_BIT}
  GL_COLOR_BUFFER_BIT                 = $00004000;
  {$EXTERNALSYM GL_COLOR_BUFFER_BIT}
  GL_HINT_BIT                         = $00008000;
  {$EXTERNALSYM GL_HINT_BIT}
  GL_EVAL_BIT                         = $00010000;
  {$EXTERNALSYM GL_EVAL_BIT}
  GL_LIST_BIT                         = $00020000;
  {$EXTERNALSYM GL_LIST_BIT}
  GL_TEXTURE_BIT                      = $00040000;
  {$EXTERNALSYM GL_TEXTURE_BIT}
  GL_SCISSOR_BIT                      = $00080000;
  {$EXTERNALSYM GL_SCISSOR_BIT}
  GL_ALL_ATTRIB_BITS                  = $000fffff;
  {$EXTERNALSYM GL_ALL_ATTRIB_BITS}

{ ClearBufferMask }
{      GL_COLOR_BUFFER_BIT }
{      GL_ACCUM_BUFFER_BIT }
{      GL_STENCIL_BUFFER_BIT }
{      GL_DEPTH_BUFFER_BIT }

{ Boolean }
  GL_FALSE                            = 0;
  {$EXTERNALSYM GL_FALSE}
  GL_TRUE                             = 1;
  {$EXTERNALSYM GL_TRUE}

{ BeginMode }
  GL_POINTS                           = $0000    ;
  {$EXTERNALSYM GL_POINTS}
  GL_LINES                            = $0001    ;
  {$EXTERNALSYM GL_LINES}
  GL_LINE_LOOP                        = $0002    ;
  {$EXTERNALSYM GL_LINE_LOOP}
  GL_LINE_STRIP                       = $0003    ;
  {$EXTERNALSYM GL_LINE_STRIP}
  GL_TRIANGLES                        = $0004    ;
  {$EXTERNALSYM GL_TRIANGLES}
  GL_TRIANGLE_STRIP                   = $0005    ;
  {$EXTERNALSYM GL_TRIANGLE_STRIP}
  GL_TRIANGLE_FAN                     = $0006    ;
  {$EXTERNALSYM GL_TRIANGLE_FAN}
  GL_QUADS                            = $0007    ;
  {$EXTERNALSYM GL_QUADS}
  GL_QUAD_STRIP                       = $0008    ;
  {$EXTERNALSYM GL_QUAD_STRIP}
  GL_POLYGON                          = $0009    ;
  {$EXTERNALSYM GL_POLYGON}

{ AccumOp }
  GL_ACCUM                            = $0100;
  {$EXTERNALSYM GL_ACCUM}
  GL_LOAD                             = $0101;
  {$EXTERNALSYM GL_LOAD}
  GL_RETURN                           = $0102;
  {$EXTERNALSYM GL_RETURN}
  GL_MULT                             = $0103;
  {$EXTERNALSYM GL_MULT}
  GL_ADD                              = $0104;
  {$EXTERNALSYM GL_ADD}

{ AlphaFunction }
  GL_NEVER                            = $0200;
  {$EXTERNALSYM GL_NEVER}
  GL_LESS                             = $0201;
  {$EXTERNALSYM GL_LESS}
  GL_EQUAL                            = $0202;
  {$EXTERNALSYM GL_EQUAL}
  GL_LEQUAL                           = $0203;
  {$EXTERNALSYM GL_LEQUAL}
  GL_GREATER                          = $0204;
  {$EXTERNALSYM GL_GREATER}
  GL_NOTEQUAL                         = $0205;
  {$EXTERNALSYM GL_NOTEQUAL}
  GL_GEQUAL                           = $0206;
  {$EXTERNALSYM GL_GEQUAL}
  GL_ALWAYS                           = $0207;
  {$EXTERNALSYM GL_ALWAYS}

{ BlendingFactorDest }
  GL_ZERO                             = 0;
  {$EXTERNALSYM GL_ZERO}
  GL_ONE                              = 1;
  {$EXTERNALSYM GL_ONE}
  GL_SRC_COLOR                        = $0300;
  {$EXTERNALSYM GL_SRC_COLOR}
  GL_ONE_MINUS_SRC_COLOR              = $0301;
  {$EXTERNALSYM GL_ONE_MINUS_SRC_COLOR}
  GL_SRC_ALPHA                        = $0302;
  {$EXTERNALSYM GL_SRC_ALPHA}
  GL_ONE_MINUS_SRC_ALPHA              = $0303;
  {$EXTERNALSYM GL_ONE_MINUS_SRC_ALPHA}
  GL_DST_ALPHA                        = $0304;
  {$EXTERNALSYM GL_DST_ALPHA}
  GL_ONE_MINUS_DST_ALPHA              = $0305;
  {$EXTERNALSYM GL_ONE_MINUS_DST_ALPHA}

{ BlendingFactorSrc }
{      GL_ZERO }
{      GL_ONE }
  GL_DST_COLOR                        = $0306;
  {$EXTERNALSYM GL_DST_COLOR}
  GL_ONE_MINUS_DST_COLOR              = $0307;
  {$EXTERNALSYM GL_ONE_MINUS_DST_COLOR}
  GL_SRC_ALPHA_SATURATE               = $0308;
  {$EXTERNALSYM GL_SRC_ALPHA_SATURATE}
{      GL_SRC_ALPHA }
{      GL_ONE_MINUS_SRC_ALPHA }
{      GL_DST_ALPHA }
{      GL_ONE_MINUS_DST_ALPHA }

{ BlendingMode }
{      GL_LOGIC_OP }

{ ColorMaterialFace }
{      GL_FRONT }
{      GL_BACK }
{      GL_FRONT_AND_BACK }

{ ColorMaterialParameter }
{      GL_AMBIENT }
{      GL_DIFFUSE }
{      GL_SPECULAR }
{      GL_EMISSION }
{      GL_AMBIENT_AND_DIFFUSE }

{ CullFaceMode }
{      GL_FRONT }
{      GL_BACK }
{      GL_FRONT_AND_BACK }

{ DepthFunction }
{      GL_NEVER }
{      GL_LESS }
{      GL_EQUAL }
{      GL_LEQUAL }
{      GL_GREATER }
{      GL_NOTEQUAL }
{      GL_GEQUAL }
{      GL_ALWAYS }

{ DrawBufferMode }
  GL_NONE                             = 0;
  {$EXTERNALSYM GL_NONE}
  GL_FRONT_LEFT                       = $0400;
  {$EXTERNALSYM GL_FRONT_LEFT}
  GL_FRONT_RIGHT                      = $0401;
  {$EXTERNALSYM GL_FRONT_RIGHT}
  GL_BACK_LEFT                        = $0402;
  {$EXTERNALSYM GL_BACK_LEFT}
  GL_BACK_RIGHT                       = $0403;
  {$EXTERNALSYM GL_BACK_RIGHT}
  GL_FRONT                            = $0404;
  {$EXTERNALSYM GL_FRONT}
  GL_BACK                             = $0405;
  {$EXTERNALSYM GL_BACK}
  GL_LEFT                             = $0406;
  {$EXTERNALSYM GL_LEFT}
  GL_RIGHT                            = $0407;
  {$EXTERNALSYM GL_RIGHT}
  GL_FRONT_AND_BACK                   = $0408;
  {$EXTERNALSYM GL_FRONT_AND_BACK}
  GL_AUX0                             = $0409;
  {$EXTERNALSYM GL_AUX0}
  GL_AUX1                             = $040A;
  {$EXTERNALSYM GL_AUX1}
  GL_AUX2                             = $040B;
  {$EXTERNALSYM GL_AUX2}
  GL_AUX3                             = $040C;
  {$EXTERNALSYM GL_AUX3}

{ ErrorCode }
  GL_NO_ERROR                         = 0;
  {$EXTERNALSYM GL_NO_ERROR}
  GL_INVALID_ENUM                     = $0500;
  {$EXTERNALSYM GL_INVALID_ENUM}
  GL_INVALID_VALUE                    = $0501;
  {$EXTERNALSYM GL_INVALID_VALUE}
  GL_INVALID_OPERATION                = $0502;
  {$EXTERNALSYM GL_INVALID_OPERATION}
  GL_STACK_OVERFLOW                   = $0503;
  {$EXTERNALSYM GL_STACK_OVERFLOW}
  GL_STACK_UNDERFLOW                  = $0504;
  {$EXTERNALSYM GL_STACK_UNDERFLOW}
  GL_OUT_OF_MEMORY                    = $0505;
  {$EXTERNALSYM GL_OUT_OF_MEMORY}

{ FeedBackMode }
  GL_2D                               = $0600;
  {$EXTERNALSYM GL_2D}
  GL_3D                               = $0601;
  {$EXTERNALSYM GL_3D}
  GL_3D_COLOR                         = $0602;
  {$EXTERNALSYM GL_3D_COLOR}
  GL_3D_COLOR_TEXTURE                 = $0603;
  {$EXTERNALSYM GL_3D_COLOR_TEXTURE}
  GL_4D_COLOR_TEXTURE                 = $0604;
  {$EXTERNALSYM GL_4D_COLOR_TEXTURE}

{ FeedBackToken }
  GL_PASS_THROUGH_TOKEN               = $0700;
  {$EXTERNALSYM GL_PASS_THROUGH_TOKEN}
  GL_POINT_TOKEN                      = $0701;
  {$EXTERNALSYM GL_POINT_TOKEN}
  GL_LINE_TOKEN                       = $0702;
  {$EXTERNALSYM GL_LINE_TOKEN}
  GL_POLYGON_TOKEN                    = $0703;
  {$EXTERNALSYM GL_POLYGON_TOKEN}
  GL_BITMAP_TOKEN                     = $0704;
  {$EXTERNALSYM GL_BITMAP_TOKEN}
  GL_DRAW_PIXEL_TOKEN                 = $0705;
  {$EXTERNALSYM GL_DRAW_PIXEL_TOKEN}
  GL_COPY_PIXEL_TOKEN                 = $0706;
  {$EXTERNALSYM GL_COPY_PIXEL_TOKEN}
  GL_LINE_RESET_TOKEN                 = $0707;
  {$EXTERNALSYM GL_LINE_RESET_TOKEN}

{ FogMode }
{      GL_LINEAR }
  GL_EXP                              = $0800;
  {$EXTERNALSYM GL_EXP}
  GL_EXP2                             = $0801;
  {$EXTERNALSYM GL_EXP2}

{ FogParameter }
{      GL_FOG_COLOR }
{      GL_FOG_DENSITY }
{      GL_FOG_END }
{      GL_FOG_INDEX }
{      GL_FOG_MODE }
{      GL_FOG_START }

{ FrontFaceDirection }
  GL_CW                               = $0900;
  {$EXTERNALSYM GL_CW}
  GL_CCW                              = $0901;
  {$EXTERNALSYM GL_CCW}

{ GetMapTarget }
  GL_COEFF                            = $0A00;
  {$EXTERNALSYM GL_COEFF}
  GL_ORDER                            = $0A01;
  {$EXTERNALSYM GL_ORDER}
  GL_DOMAIN                           = $0A02;
  {$EXTERNALSYM GL_DOMAIN}

{ GetPixelMap }
  GL_PIXEL_MAP_I_TO_I                 = $0C70;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_I}
  GL_PIXEL_MAP_S_TO_S                 = $0C71;
  {$EXTERNALSYM GL_PIXEL_MAP_S_TO_S}
  GL_PIXEL_MAP_I_TO_R                 = $0C72;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_R}
  GL_PIXEL_MAP_I_TO_G                 = $0C73;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_G}
  GL_PIXEL_MAP_I_TO_B                 = $0C74;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_B}
  GL_PIXEL_MAP_I_TO_A                 = $0C75;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_A}
  GL_PIXEL_MAP_R_TO_R                 = $0C76;
  {$EXTERNALSYM GL_PIXEL_MAP_R_TO_R}
  GL_PIXEL_MAP_G_TO_G                 = $0C77;
  {$EXTERNALSYM GL_PIXEL_MAP_G_TO_G}
  GL_PIXEL_MAP_B_TO_B                 = $0C78;
  {$EXTERNALSYM GL_PIXEL_MAP_B_TO_B}
  GL_PIXEL_MAP_A_TO_A                 = $0C79;
  {$EXTERNALSYM GL_PIXEL_MAP_A_TO_A}

{ GetTarget }
  GL_CURRENT_COLOR                    = $0B00;
  {$EXTERNALSYM GL_CURRENT_COLOR}
  GL_CURRENT_INDEX                    = $0B01;
  {$EXTERNALSYM GL_CURRENT_INDEX}
  GL_CURRENT_NORMAL                   = $0B02;
  {$EXTERNALSYM GL_CURRENT_NORMAL}
  GL_CURRENT_TEXTURE_COORDS           = $0B03;
  {$EXTERNALSYM GL_CURRENT_TEXTURE_COORDS}
  GL_CURRENT_RASTER_COLOR             = $0B04;
  {$EXTERNALSYM GL_CURRENT_RASTER_COLOR}
  GL_CURRENT_RASTER_INDEX             = $0B05;
  {$EXTERNALSYM GL_CURRENT_RASTER_INDEX}
  GL_CURRENT_RASTER_TEXTURE_COORDS    = $0B06;
  {$EXTERNALSYM GL_CURRENT_RASTER_TEXTURE_COORDS}
  GL_CURRENT_RASTER_POSITION          = $0B07;
  {$EXTERNALSYM GL_CURRENT_RASTER_POSITION}
  GL_CURRENT_RASTER_POSITION_VALID    = $0B08;
  {$EXTERNALSYM GL_CURRENT_RASTER_POSITION_VALID}
  GL_CURRENT_RASTER_DISTANCE          = $0B09;
  {$EXTERNALSYM GL_CURRENT_RASTER_DISTANCE}
  GL_POINT_SMOOTH                     = $0B10;
  {$EXTERNALSYM GL_POINT_SMOOTH}
  GL_POINT_SIZE                       = $0B11;
  {$EXTERNALSYM GL_POINT_SIZE}
  GL_POINT_SIZE_RANGE                 = $0B12;
  {$EXTERNALSYM GL_POINT_SIZE_RANGE}
  GL_POINT_SIZE_GRANULARITY           = $0B13;
  {$EXTERNALSYM GL_POINT_SIZE_GRANULARITY}
  GL_LINE_SMOOTH                      = $0B20;
  {$EXTERNALSYM GL_LINE_SMOOTH}
  GL_LINE_WIDTH                       = $0B21;
  {$EXTERNALSYM GL_LINE_WIDTH}
  GL_LINE_WIDTH_RANGE                 = $0B22;
  {$EXTERNALSYM GL_LINE_WIDTH_RANGE}
  GL_LINE_WIDTH_GRANULARITY           = $0B23;
  {$EXTERNALSYM GL_LINE_WIDTH_GRANULARITY}
  GL_LINE_STIPPLE                     = $0B24;
  {$EXTERNALSYM GL_LINE_STIPPLE}
  GL_LINE_STIPPLE_PATTERN             = $0B25;
  {$EXTERNALSYM GL_LINE_STIPPLE_PATTERN}
  GL_LINE_STIPPLE_REPEAT              = $0B26;
  {$EXTERNALSYM GL_LINE_STIPPLE_REPEAT}
  GL_LIST_MODE                        = $0B30;
  {$EXTERNALSYM GL_LIST_MODE}
  GL_MAX_LIST_NESTING                 = $0B31;
  {$EXTERNALSYM GL_MAX_LIST_NESTING}
  GL_LIST_BASE                        = $0B32;
  {$EXTERNALSYM GL_LIST_BASE}
  GL_LIST_INDEX                       = $0B33;
  {$EXTERNALSYM GL_LIST_INDEX}
  GL_POLYGON_MODE                     = $0B40;
  {$EXTERNALSYM GL_POLYGON_MODE}
  GL_POLYGON_SMOOTH                   = $0B41;
  {$EXTERNALSYM GL_POLYGON_SMOOTH}
  GL_POLYGON_STIPPLE                  = $0B42;
  {$EXTERNALSYM GL_POLYGON_STIPPLE}
  GL_EDGE_FLAG                        = $0B43;
  {$EXTERNALSYM GL_EDGE_FLAG}
  GL_CULL_FACE                        = $0B44;
  {$EXTERNALSYM GL_CULL_FACE}
  GL_CULL_FACE_MODE                   = $0B45;
  {$EXTERNALSYM GL_CULL_FACE_MODE}
  GL_FRONT_FACE                       = $0B46;
  {$EXTERNALSYM GL_FRONT_FACE}
  GL_LIGHTING                         = $0B50;
  {$EXTERNALSYM GL_LIGHTING}
  GL_LIGHT_MODEL_LOCAL_VIEWER         = $0B51;
  {$EXTERNALSYM GL_LIGHT_MODEL_LOCAL_VIEWER}
  GL_LIGHT_MODEL_TWO_SIDE             = $0B52;
  {$EXTERNALSYM GL_LIGHT_MODEL_TWO_SIDE}
  GL_LIGHT_MODEL_AMBIENT              = $0B53;
  {$EXTERNALSYM GL_LIGHT_MODEL_AMBIENT}
  GL_SHADE_MODEL                      = $0B54;
  {$EXTERNALSYM GL_SHADE_MODEL}
  GL_COLOR_MATERIAL_FACE              = $0B55;
  {$EXTERNALSYM GL_COLOR_MATERIAL_FACE}
  GL_COLOR_MATERIAL_PARAMETER         = $0B56;
  {$EXTERNALSYM GL_COLOR_MATERIAL_PARAMETER}
  GL_COLOR_MATERIAL                   = $0B57;
  {$EXTERNALSYM GL_COLOR_MATERIAL}
  GL_FOG                              = $0B60;
  {$EXTERNALSYM GL_FOG}
  GL_FOG_INDEX                        = $0B61;
  {$EXTERNALSYM GL_FOG_INDEX}
  GL_FOG_DENSITY                      = $0B62;
  {$EXTERNALSYM GL_FOG_DENSITY}
  GL_FOG_START                        = $0B63;
  {$EXTERNALSYM GL_FOG_START}
  GL_FOG_END                          = $0B64;
  {$EXTERNALSYM GL_FOG_END}
  GL_FOG_MODE                         = $0B65;
  {$EXTERNALSYM GL_FOG_MODE}
  GL_FOG_COLOR                        = $0B66;
  {$EXTERNALSYM GL_FOG_COLOR}
  GL_DEPTH_RANGE                      = $0B70;
  {$EXTERNALSYM GL_DEPTH_RANGE}
  GL_DEPTH_TEST                       = $0B71;
  {$EXTERNALSYM GL_DEPTH_TEST}
  GL_DEPTH_WRITEMASK                  = $0B72;
  {$EXTERNALSYM GL_DEPTH_WRITEMASK}
  GL_DEPTH_CLEAR_VALUE                = $0B73;
  {$EXTERNALSYM GL_DEPTH_CLEAR_VALUE}
  GL_DEPTH_FUNC                       = $0B74;
  {$EXTERNALSYM GL_DEPTH_FUNC}
  GL_ACCUM_CLEAR_VALUE                = $0B80;
  {$EXTERNALSYM GL_ACCUM_CLEAR_VALUE}
  GL_STENCIL_TEST                     = $0B90;
  {$EXTERNALSYM GL_STENCIL_TEST}
  GL_STENCIL_CLEAR_VALUE              = $0B91;
  {$EXTERNALSYM GL_STENCIL_CLEAR_VALUE}
  GL_STENCIL_FUNC                     = $0B92;
  {$EXTERNALSYM GL_STENCIL_FUNC}
  GL_STENCIL_VALUE_MASK               = $0B93;
  {$EXTERNALSYM GL_STENCIL_VALUE_MASK}
  GL_STENCIL_FAIL                     = $0B94;
  {$EXTERNALSYM GL_STENCIL_FAIL}
  GL_STENCIL_PASS_DEPTH_FAIL          = $0B95;
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_FAIL}
  GL_STENCIL_PASS_DEPTH_PASS          = $0B96;
  {$EXTERNALSYM GL_STENCIL_PASS_DEPTH_PASS}
  GL_STENCIL_REF                      = $0B97;
  {$EXTERNALSYM GL_STENCIL_REF}
  GL_STENCIL_WRITEMASK                = $0B98;
  {$EXTERNALSYM GL_STENCIL_WRITEMASK}
  GL_MATRIX_MODE                      = $0BA0;
  {$EXTERNALSYM GL_MATRIX_MODE}
  GL_NORMALIZE                        = $0BA1;
  {$EXTERNALSYM GL_NORMALIZE}
  GL_VIEWPORT                         = $0BA2;
  {$EXTERNALSYM GL_VIEWPORT}
  GL_MODELVIEW_STACK_DEPTH            = $0BA3;
  {$EXTERNALSYM GL_MODELVIEW_STACK_DEPTH}
  GL_PROJECTION_STACK_DEPTH           = $0BA4;
  {$EXTERNALSYM GL_PROJECTION_STACK_DEPTH}
  GL_TEXTURE_STACK_DEPTH              = $0BA5;
  {$EXTERNALSYM GL_TEXTURE_STACK_DEPTH}
  GL_MODELVIEW_MATRIX                 = $0BA6;
  {$EXTERNALSYM GL_MODELVIEW_MATRIX}
  GL_PROJECTION_MATRIX                = $0BA7;
  {$EXTERNALSYM GL_PROJECTION_MATRIX}
  GL_TEXTURE_MATRIX                   = $0BA8;
  {$EXTERNALSYM GL_TEXTURE_MATRIX}
  GL_ATTRIB_STACK_DEPTH               = $0BB0;
  {$EXTERNALSYM GL_ATTRIB_STACK_DEPTH}
  GL_ALPHA_TEST                       = $0BC0;
  {$EXTERNALSYM GL_ALPHA_TEST}
  GL_ALPHA_TEST_FUNC                  = $0BC1;
  {$EXTERNALSYM GL_ALPHA_TEST_FUNC}
  GL_ALPHA_TEST_REF                   = $0BC2;
  {$EXTERNALSYM GL_ALPHA_TEST_REF}
  GL_DITHER                           = $0BD0;
  {$EXTERNALSYM GL_DITHER}
  GL_BLEND_DST                        = $0BE0;
  {$EXTERNALSYM GL_BLEND_DST}
  GL_BLEND_SRC                        = $0BE1;
  {$EXTERNALSYM GL_BLEND_SRC}
  GL_BLEND                            = $0BE2;
  {$EXTERNALSYM GL_BLEND}
  GL_LOGIC_OP_MODE                    = $0BF0;
  {$EXTERNALSYM GL_LOGIC_OP_MODE}
  GL_LOGIC_OP                         = $0BF1;
  {$EXTERNALSYM GL_LOGIC_OP}
  GL_AUX_BUFFERS                      = $0C00;
  {$EXTERNALSYM GL_AUX_BUFFERS}
  GL_DRAW_BUFFER                      = $0C01;
  {$EXTERNALSYM GL_DRAW_BUFFER}
  GL_READ_BUFFER                      = $0C02;
  {$EXTERNALSYM GL_READ_BUFFER}
  GL_SCISSOR_BOX                      = $0C10;
  {$EXTERNALSYM GL_SCISSOR_BOX}
  GL_SCISSOR_TEST                     = $0C11;
  {$EXTERNALSYM GL_SCISSOR_TEST}
  GL_INDEX_CLEAR_VALUE                = $0C20;
  {$EXTERNALSYM GL_INDEX_CLEAR_VALUE}
  GL_INDEX_WRITEMASK                  = $0C21;
  {$EXTERNALSYM GL_INDEX_WRITEMASK}
  GL_COLOR_CLEAR_VALUE                = $0C22;
  {$EXTERNALSYM GL_COLOR_CLEAR_VALUE}
  GL_COLOR_WRITEMASK                  = $0C23;
  {$EXTERNALSYM GL_COLOR_WRITEMASK}
  GL_INDEX_MODE                       = $0C30;
  {$EXTERNALSYM GL_INDEX_MODE}
  GL_RGBA_MODE                        = $0C31;
  {$EXTERNALSYM GL_RGBA_MODE}
  GL_DOUBLEBUFFER                     = $0C32;
  {$EXTERNALSYM GL_DOUBLEBUFFER}
  GL_STEREO                           = $0C33;
  {$EXTERNALSYM GL_STEREO}
  GL_RENDER_MODE                      = $0C40;
  {$EXTERNALSYM GL_RENDER_MODE}
  GL_PERSPECTIVE_CORRECTION_HINT      = $0C50;
  {$EXTERNALSYM GL_PERSPECTIVE_CORRECTION_HINT}
  GL_POINT_SMOOTH_HINT                = $0C51;
  {$EXTERNALSYM GL_POINT_SMOOTH_HINT}
  GL_LINE_SMOOTH_HINT                 = $0C52;
  {$EXTERNALSYM GL_LINE_SMOOTH_HINT}
  GL_POLYGON_SMOOTH_HINT              = $0C53;
  {$EXTERNALSYM GL_POLYGON_SMOOTH_HINT}
  GL_FOG_HINT                         = $0C54;
  {$EXTERNALSYM GL_FOG_HINT}
  GL_TEXTURE_GEN_S                    = $0C60;
  {$EXTERNALSYM GL_TEXTURE_GEN_S}
  GL_TEXTURE_GEN_T                    = $0C61;
  {$EXTERNALSYM GL_TEXTURE_GEN_T}
  GL_TEXTURE_GEN_R                    = $0C62;
  {$EXTERNALSYM GL_TEXTURE_GEN_R}
  GL_TEXTURE_GEN_Q                    = $0C63;
  {$EXTERNALSYM GL_TEXTURE_GEN_Q}
  GL_PIXEL_MAP_I_TO_I_SIZE            = $0CB0;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_I_SIZE}
  GL_PIXEL_MAP_S_TO_S_SIZE            = $0CB1;
  {$EXTERNALSYM GL_PIXEL_MAP_S_TO_S_SIZE}
  GL_PIXEL_MAP_I_TO_R_SIZE            = $0CB2;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_R_SIZE}
  GL_PIXEL_MAP_I_TO_G_SIZE            = $0CB3;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_G_SIZE}
  GL_PIXEL_MAP_I_TO_B_SIZE            = $0CB4;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_B_SIZE}
  GL_PIXEL_MAP_I_TO_A_SIZE            = $0CB5;
  {$EXTERNALSYM GL_PIXEL_MAP_I_TO_A_SIZE}
  GL_PIXEL_MAP_R_TO_R_SIZE            = $0CB6;
  {$EXTERNALSYM GL_PIXEL_MAP_R_TO_R_SIZE}
  GL_PIXEL_MAP_G_TO_G_SIZE            = $0CB7;
  {$EXTERNALSYM GL_PIXEL_MAP_G_TO_G_SIZE}
  GL_PIXEL_MAP_B_TO_B_SIZE            = $0CB8;
  {$EXTERNALSYM GL_PIXEL_MAP_B_TO_B_SIZE}
  GL_PIXEL_MAP_A_TO_A_SIZE            = $0CB9;
  {$EXTERNALSYM GL_PIXEL_MAP_A_TO_A_SIZE}
  GL_UNPACK_SWAP_BYTES                = $0CF0;
  {$EXTERNALSYM GL_UNPACK_SWAP_BYTES}
  GL_UNPACK_LSB_FIRST                 = $0CF1;
  {$EXTERNALSYM GL_UNPACK_LSB_FIRST}
  GL_UNPACK_ROW_LENGTH                = $0CF2;
  {$EXTERNALSYM GL_UNPACK_ROW_LENGTH}
  GL_UNPACK_SKIP_ROWS                 = $0CF3;
  {$EXTERNALSYM GL_UNPACK_SKIP_ROWS}
  GL_UNPACK_SKIP_PIXELS               = $0CF4;
  {$EXTERNALSYM GL_UNPACK_SKIP_PIXELS}
  GL_UNPACK_ALIGNMENT                 = $0CF5;
  {$EXTERNALSYM GL_UNPACK_ALIGNMENT}
  GL_PACK_SWAP_BYTES                  = $0D00;
  {$EXTERNALSYM GL_PACK_SWAP_BYTES}
  GL_PACK_LSB_FIRST                   = $0D01;
  {$EXTERNALSYM GL_PACK_LSB_FIRST}
  GL_PACK_ROW_LENGTH                  = $0D02;
  {$EXTERNALSYM GL_PACK_ROW_LENGTH}
  GL_PACK_SKIP_ROWS                   = $0D03;
  {$EXTERNALSYM GL_PACK_SKIP_ROWS}
  GL_PACK_SKIP_PIXELS                 = $0D04;
  {$EXTERNALSYM GL_PACK_SKIP_PIXELS}
  GL_PACK_ALIGNMENT                   = $0D05;
  {$EXTERNALSYM GL_PACK_ALIGNMENT}
  GL_MAP_COLOR                        = $0D10;
  {$EXTERNALSYM GL_MAP_COLOR}
  GL_MAP_STENCIL                      = $0D11;
  {$EXTERNALSYM GL_MAP_STENCIL}
  GL_INDEX_SHIFT                      = $0D12;
  {$EXTERNALSYM GL_INDEX_SHIFT}
  GL_INDEX_OFFSET                     = $0D13;
  {$EXTERNALSYM GL_INDEX_OFFSET}
  GL_RED_SCALE                        = $0D14;
  {$EXTERNALSYM GL_RED_SCALE}
  GL_RED_BIAS                         = $0D15;
  {$EXTERNALSYM GL_RED_BIAS}
  GL_ZOOM_X                           = $0D16;
  {$EXTERNALSYM GL_ZOOM_X}
  GL_ZOOM_Y                           = $0D17;
  {$EXTERNALSYM GL_ZOOM_Y}
  GL_GREEN_SCALE                      = $0D18;
  {$EXTERNALSYM GL_GREEN_SCALE}
  GL_GREEN_BIAS                       = $0D19;
  {$EXTERNALSYM GL_GREEN_BIAS}
  GL_BLUE_SCALE                       = $0D1A;
  {$EXTERNALSYM GL_BLUE_SCALE}
  GL_BLUE_BIAS                        = $0D1B;
  {$EXTERNALSYM GL_BLUE_BIAS}
  GL_ALPHA_SCALE                      = $0D1C;
  {$EXTERNALSYM GL_ALPHA_SCALE}
  GL_ALPHA_BIAS                       = $0D1D;
  {$EXTERNALSYM GL_ALPHA_BIAS}
  GL_DEPTH_SCALE                      = $0D1E;
  {$EXTERNALSYM GL_DEPTH_SCALE}
  GL_DEPTH_BIAS                       = $0D1F;
  {$EXTERNALSYM GL_DEPTH_BIAS}
  GL_MAX_EVAL_ORDER                   = $0D30;
  {$EXTERNALSYM GL_MAX_EVAL_ORDER}
  GL_MAX_LIGHTS                       = $0D31;
  {$EXTERNALSYM GL_MAX_EVAL_ORDER}
  GL_MAX_CLIP_PLANES                  = $0D32;
  {$EXTERNALSYM GL_MAX_CLIP_PLANES}
  GL_MAX_TEXTURE_SIZE                 = $0D33;
  {$EXTERNALSYM GL_MAX_TEXTURE_SIZE}
  GL_MAX_PIXEL_MAP_TABLE              = $0D34;
  {$EXTERNALSYM GL_MAX_PIXEL_MAP_TABLE}
  GL_MAX_ATTRIB_STACK_DEPTH           = $0D35;
  {$EXTERNALSYM GL_MAX_ATTRIB_STACK_DEPTH}
  GL_MAX_MODELVIEW_STACK_DEPTH        = $0D36;
  {$EXTERNALSYM GL_MAX_MODELVIEW_STACK_DEPTH}
  GL_MAX_NAME_STACK_DEPTH             = $0D37;
  {$EXTERNALSYM GL_MAX_NAME_STACK_DEPTH}
  GL_MAX_PROJECTION_STACK_DEPTH       = $0D38;
  {$EXTERNALSYM GL_MAX_PROJECTION_STACK_DEPTH}
  GL_MAX_TEXTURE_STACK_DEPTH          = $0D39;
  {$EXTERNALSYM GL_MAX_TEXTURE_STACK_DEPTH}
  GL_MAX_VIEWPORT_DIMS                = $0D3A;
  {$EXTERNALSYM GL_MAX_VIEWPORT_DIMS}
  GL_SUBPIXEL_BITS                    = $0D50;
  {$EXTERNALSYM GL_SUBPIXEL_BITS}
  GL_INDEX_BITS                       = $0D51;
  {$EXTERNALSYM GL_INDEX_BITS}
  GL_RED_BITS                         = $0D52;
  {$EXTERNALSYM GL_RED_BITS}
  GL_GREEN_BITS                       = $0D53;
  {$EXTERNALSYM GL_GREEN_BITS}
  GL_BLUE_BITS                        = $0D54;
  {$EXTERNALSYM GL_BLUE_BITS}
  GL_ALPHA_BITS                       = $0D55;
  {$EXTERNALSYM GL_ALPHA_BITS}
  GL_DEPTH_BITS                       = $0D56;
  {$EXTERNALSYM GL_DEPTH_BITS}
  GL_STENCIL_BITS                     = $0D57;
  {$EXTERNALSYM GL_STENCIL_BITS}
  GL_ACCUM_RED_BITS                   = $0D58;
  {$EXTERNALSYM GL_ACCUM_RED_BITS}
  GL_ACCUM_GREEN_BITS                 = $0D59;
  {$EXTERNALSYM GL_ACCUM_GREEN_BITS}
  GL_ACCUM_BLUE_BITS                  = $0D5A;
  {$EXTERNALSYM GL_ACCUM_BLUE_BITS}
  GL_ACCUM_ALPHA_BITS                 = $0D5B;
  {$EXTERNALSYM GL_ACCUM_ALPHA_BITS}
  GL_NAME_STACK_DEPTH                 = $0D70;
  {$EXTERNALSYM GL_NAME_STACK_DEPTH}
  GL_AUTO_NORMAL                      = $0D80;
  {$EXTERNALSYM GL_AUTO_NORMAL}
  GL_MAP1_COLOR_4                     = $0D90;
  {$EXTERNALSYM GL_MAP1_COLOR_4}
  GL_MAP1_INDEX                       = $0D91;
  {$EXTERNALSYM GL_MAP1_INDEX}
  GL_MAP1_NORMAL                      = $0D92;
  {$EXTERNALSYM GL_MAP1_NORMAL}
  GL_MAP1_TEXTURE_COORD_1             = $0D93;
  {$EXTERNALSYM GL_MAP1_TEXTURE_COORD_1}
  GL_MAP1_TEXTURE_COORD_2             = $0D94;
  {$EXTERNALSYM GL_MAP1_TEXTURE_COORD_2}
  GL_MAP1_TEXTURE_COORD_3             = $0D95;
  {$EXTERNALSYM GL_MAP1_TEXTURE_COORD_3}
  GL_MAP1_TEXTURE_COORD_4             = $0D96;
  {$EXTERNALSYM GL_MAP1_TEXTURE_COORD_4}
  GL_MAP1_VERTEX_3                    = $0D97;
  {$EXTERNALSYM GL_MAP1_VERTEX_3}
  GL_MAP1_VERTEX_4                    = $0D98;
  {$EXTERNALSYM GL_MAP1_VERTEX_4}
  GL_MAP2_COLOR_4                     = $0DB0;
  {$EXTERNALSYM GL_MAP2_COLOR_4}
  GL_MAP2_INDEX                       = $0DB1;
  {$EXTERNALSYM GL_MAP2_INDEX}
  GL_MAP2_NORMAL                      = $0DB2;
  {$EXTERNALSYM GL_MAP2_NORMAL}
  GL_MAP2_TEXTURE_COORD_1             = $0DB3;
  {$EXTERNALSYM GL_MAP2_TEXTURE_COORD_1}
  GL_MAP2_TEXTURE_COORD_2             = $0DB4;
  {$EXTERNALSYM GL_MAP2_TEXTURE_COORD_2}
  GL_MAP2_TEXTURE_COORD_3             = $0DB5;
  {$EXTERNALSYM GL_MAP2_TEXTURE_COORD_3}
  GL_MAP2_TEXTURE_COORD_4             = $0DB6;
  {$EXTERNALSYM GL_MAP2_TEXTURE_COORD_4}
  GL_MAP2_VERTEX_3                    = $0DB7;
  {$EXTERNALSYM GL_MAP2_VERTEX_3}
  GL_MAP2_VERTEX_4                    = $0DB8;
  {$EXTERNALSYM GL_MAP2_VERTEX_4}
  GL_MAP1_GRID_DOMAIN                 = $0DD0;
  {$EXTERNALSYM GL_MAP1_GRID_DOMAIN}
  GL_MAP1_GRID_SEGMENTS               = $0DD1;
  {$EXTERNALSYM GL_MAP1_GRID_SEGMENTS}
  GL_MAP2_GRID_DOMAIN                 = $0DD2;
  {$EXTERNALSYM GL_MAP2_GRID_DOMAIN}
  GL_MAP2_GRID_SEGMENTS               = $0DD3;
  {$EXTERNALSYM GL_MAP2_GRID_SEGMENTS}
  GL_TEXTURE_1D                       = $0DE0;
  {$EXTERNALSYM GL_TEXTURE_1D}
  GL_TEXTURE_2D                       = $0DE1;
  {$EXTERNALSYM GL_TEXTURE_2D}

{ GetTextureParameter }
{      GL_TEXTURE_MAG_FILTER }
{      GL_TEXTURE_MIN_FILTER }
{      GL_TEXTURE_WRAP_S }
{      GL_TEXTURE_WRAP_T }
  GL_TEXTURE_WIDTH                    = $1000;
  {$EXTERNALSYM GL_TEXTURE_WIDTH}
  GL_TEXTURE_HEIGHT                   = $1001;
  {$EXTERNALSYM GL_TEXTURE_HEIGHT}
  GL_TEXTURE_COMPONENTS               = $1003;
  {$EXTERNALSYM GL_TEXTURE_COMPONENTS}
  GL_TEXTURE_BORDER_COLOR             = $1004;
  {$EXTERNALSYM GL_TEXTURE_BORDER_COLOR}
  GL_TEXTURE_BORDER                   = $1005;
  {$EXTERNALSYM GL_TEXTURE_BORDER}

{ HintMode }
  GL_DONT_CARE                        = $1100;
  {$EXTERNALSYM GL_DONT_CARE}
  GL_FASTEST                          = $1101;
  {$EXTERNALSYM GL_FASTEST}
  GL_NICEST                           = $1102;
  {$EXTERNALSYM GL_NICEST}

{ HintTarget }
{      GL_PERSPECTIVE_CORRECTION_HINT }
{      GL_POINT_SMOOTH_HINT }
{      GL_LINE_SMOOTH_HINT }
{      GL_POLYGON_SMOOTH_HINT }
{      GL_FOG_HINT }

{ LightModelParameter }
{      GL_LIGHT_MODEL_AMBIENT }
{      GL_LIGHT_MODEL_LOCAL_VIEWER }
{      GL_LIGHT_MODEL_TWO_SIDE }

{ LightParameter }
  GL_AMBIENT                          = $1200;
  {$EXTERNALSYM GL_AMBIENT}
  GL_DIFFUSE                          = $1201;
  {$EXTERNALSYM GL_DIFFUSE}
  GL_SPECULAR                         = $1202;
  {$EXTERNALSYM GL_SPECULAR}
  GL_POSITION                         = $1203;
  {$EXTERNALSYM GL_POSITION}
  GL_SPOT_DIRECTION                   = $1204;
  {$EXTERNALSYM GL_SPOT_DIRECTION}
  GL_SPOT_EXPONENT                    = $1205;
  {$EXTERNALSYM GL_SPOT_EXPONENT}
  GL_SPOT_CUTOFF                      = $1206;
  {$EXTERNALSYM GL_SPOT_CUTOFF}
  GL_CONSTANT_ATTENUATION             = $1207;
  {$EXTERNALSYM GL_CONSTANT_ATTENUATION}
  GL_LINEAR_ATTENUATION               = $1208;
  {$EXTERNALSYM GL_LINEAR_ATTENUATION}
  GL_QUADRATIC_ATTENUATION            = $1209;
  {$EXTERNALSYM GL_QUADRATIC_ATTENUATION}

{ ListMode }
  GL_COMPILE                          = $1300;
  {$EXTERNALSYM GL_COMPILE}
  GL_COMPILE_AND_EXECUTE              = $1301;
  {$EXTERNALSYM GL_COMPILE_AND_EXECUTE}

{ ListNameType }
  GL_BYTE                             = $1400;
  {$EXTERNALSYM GL_BYTE}
  GL_UNSIGNED_BYTE                    = $1401;
  {$EXTERNALSYM GL_UNSIGNED_BYTE}
  GL_SHORT                            = $1402;
  {$EXTERNALSYM GL_SHORT}
  GL_UNSIGNED_SHORT                   = $1403;
  {$EXTERNALSYM GL_UNSIGNED_SHORT}
  GL_INT                              = $1404;
  {$EXTERNALSYM GL_INT}
  GL_UNSIGNED_INT                     = $1405;
  {$EXTERNALSYM GL_UNSIGNED_INT}
  GL_FLOAT                            = $1406;
  {$EXTERNALSYM GL_FLOAT}
  GL_2_BYTES                          = $1407;
  {$EXTERNALSYM GL_2_BYTES}
  GL_3_BYTES                          = $1408;
  {$EXTERNALSYM GL_3_BYTES}
  GL_4_BYTES                          = $1409;
  {$EXTERNALSYM GL_4_BYTES}

{ LogicOp }
  GL_CLEAR                            = $1500;
  {$EXTERNALSYM GL_CLEAR}
  GL_AND                              = $1501;
  {$EXTERNALSYM GL_AND}
  GL_AND_REVERSE                      = $1502;
  {$EXTERNALSYM GL_AND_REVERSE}
  GL_COPY                             = $1503;
  {$EXTERNALSYM GL_COPY}
  GL_AND_INVERTED                     = $1504;
  {$EXTERNALSYM GL_AND_INVERTED}
  GL_NOOP                             = $1505;
  {$EXTERNALSYM GL_NOOP}
  GL_XOR                              = $1506;
  {$EXTERNALSYM GL_XOR}
  GL_OR                               = $1507;
  {$EXTERNALSYM GL_OR}
  GL_NOR                              = $1508;
  {$EXTERNALSYM GL_NOR}
  GL_EQUIV                            = $1509;
  {$EXTERNALSYM GL_EQUIV}
  GL_INVERT                           = $150A;
  {$EXTERNALSYM GL_INVERT}
  GL_OR_REVERSE                       = $150B;
  {$EXTERNALSYM GL_OR_REVERSE}
  GL_COPY_INVERTED                    = $150C;
  {$EXTERNALSYM GL_COPY_INVERTED}
  GL_OR_INVERTED                      = $150D;
  {$EXTERNALSYM GL_OR_INVERTED}
  GL_NAND                             = $150E;
  {$EXTERNALSYM GL_NAND}
  GL_SET                              = $150F;
  {$EXTERNALSYM GL_SET}

{ MapTarget }
{      GL_MAP1_COLOR_4 }
{      GL_MAP1_INDEX }
{      GL_MAP1_NORMAL }
{      GL_MAP1_TEXTURE_COORD_1 }
{      GL_MAP1_TEXTURE_COORD_2 }
{      GL_MAP1_TEXTURE_COORD_3 }
{      GL_MAP1_TEXTURE_COORD_4 }
{      GL_MAP1_VERTEX_3 }
{      GL_MAP1_VERTEX_4 }
{      GL_MAP2_COLOR_4 }
{      GL_MAP2_INDEX }
{      GL_MAP2_NORMAL }
{      GL_MAP2_TEXTURE_COORD_1 }
{      GL_MAP2_TEXTURE_COORD_2 }
{      GL_MAP2_TEXTURE_COORD_3 }
{      GL_MAP2_TEXTURE_COORD_4 }
{      GL_MAP2_VERTEX_3 }
{      GL_MAP2_VERTEX_4 }

{ MaterialFace }
{      GL_FRONT }
{      GL_BACK }
{      GL_FRONT_AND_BACK }

{ MaterialParameter }
  GL_EMISSION                         = $1600;
  {$EXTERNALSYM GL_EMISSION}
  GL_SHININESS                        = $1601;
  {$EXTERNALSYM GL_SHININESS}
  GL_AMBIENT_AND_DIFFUSE              = $1602;
  {$EXTERNALSYM GL_AMBIENT_AND_DIFFUSE}
  GL_COLOR_INDEXES                    = $1603;
  {$EXTERNALSYM GL_COLOR_INDEXES}
{      GL_AMBIENT }
{      GL_DIFFUSE }
{      GL_SPECULAR }

{ MatrixMode }
  GL_MODELVIEW                        = $1700;
  {$EXTERNALSYM GL_MODELVIEW}
  GL_PROJECTION                       = $1701;
  {$EXTERNALSYM GL_PROJECTION}
  GL_TEXTURE                          = $1702;
  {$EXTERNALSYM GL_TEXTURE}

{ MeshMode1 }
{      GL_POINT }
{      GL_LINE }

{ MeshMode2 }
{      GL_POINT }
{      GL_LINE }
{      GL_FILL }

{ PixelCopyType }
  GL_COLOR                            = $1800;
  {$EXTERNALSYM GL_COLOR}
  GL_DEPTH                            = $1801;
  {$EXTERNALSYM GL_DEPTH}
  GL_STENCIL                          = $1802;
  {$EXTERNALSYM GL_STENCIL}

{ PixelFormat }
  GL_COLOR_INDEX                      = $1900;
  {$EXTERNALSYM GL_COLOR_INDEX}
  GL_STENCIL_INDEX                    = $1901;
  {$EXTERNALSYM GL_STENCIL_INDEX}
  GL_DEPTH_COMPONENT                  = $1902;
  {$EXTERNALSYM GL_DEPTH_COMPONENT}
  GL_RED                              = $1903;
  {$EXTERNALSYM GL_RED}
  GL_GREEN                            = $1904;
  {$EXTERNALSYM GL_GREEN}
  GL_BLUE                             = $1905;
  {$EXTERNALSYM GL_BLUE}
  GL_ALPHA                            = $1906;
  {$EXTERNALSYM GL_ALPHA}
  GL_RGB                              = $1907;
  {$EXTERNALSYM GL_RGB}
  GL_RGBA                             = $1908;
  {$EXTERNALSYM GL_RGBA}
  GL_LUMINANCE                        = $1909;
  {$EXTERNALSYM GL_LUMINANCE}
  GL_LUMINANCE_ALPHA                  = $190A;
  {$EXTERNALSYM GL_LUMINANCE_ALPHA}

{ PixelMap }
{      GL_PIXEL_MAP_I_TO_I }
{      GL_PIXEL_MAP_S_TO_S }
{      GL_PIXEL_MAP_I_TO_R }
{      GL_PIXEL_MAP_I_TO_G }
{      GL_PIXEL_MAP_I_TO_B }
{      GL_PIXEL_MAP_I_TO_A }
{      GL_PIXEL_MAP_R_TO_R }
{      GL_PIXEL_MAP_G_TO_G }
{      GL_PIXEL_MAP_B_TO_B }
{      GL_PIXEL_MAP_A_TO_A }

{ PixelStore }
{      GL_UNPACK_SWAP_BYTES }
{      GL_UNPACK_LSB_FIRST }
{      GL_UNPACK_ROW_LENGTH }
{      GL_UNPACK_SKIP_ROWS }
{      GL_UNPACK_SKIP_PIXELS }
{      GL_UNPACK_ALIGNMENT }
{      GL_PACK_SWAP_BYTES }
{      GL_PACK_LSB_FIRST }
{      GL_PACK_ROW_LENGTH }
{      GL_PACK_SKIP_ROWS }
{      GL_PACK_SKIP_PIXELS }
{      GL_PACK_ALIGNMENT }

{ PixelTransfer }
{      GL_MAP_COLOR }
{      GL_MAP_STENCIL }
{      GL_INDEX_SHIFT }
{      GL_INDEX_OFFSET }
{      GL_RED_SCALE }
{      GL_RED_BIAS }
{      GL_GREEN_SCALE }
{      GL_GREEN_BIAS }
{      GL_BLUE_SCALE }
{      GL_BLUE_BIAS }
{      GL_ALPHA_SCALE }
{      GL_ALPHA_BIAS }
{      GL_DEPTH_SCALE }
{      GL_DEPTH_BIAS }

{ PixelType }
  GL_BITMAP                           = $1A00;
  {$EXTERNALSYM GL_BITMAP}
{      GL_BYTE }
{      GL_UNSIGNED_BYTE }
{      GL_SHORT }
{      GL_UNSIGNED_SHORT }
{      GL_INT }
{      GL_UNSIGNED_INT }
{      GL_FLOAT }

{ PolygonMode }
  GL_POINT                            = $1B00;
  {$EXTERNALSYM GL_POINT}
  GL_LINE                             = $1B01;
  {$EXTERNALSYM GL_LINE}
  GL_FILL                             = $1B02;
  {$EXTERNALSYM GL_FILL}

{ ReadBufferMode }
{      GL_FRONT_LEFT }
{      GL_FRONT_RIGHT }
{      GL_BACK_LEFT }
{      GL_BACK_RIGHT }
{      GL_FRONT }
{      GL_BACK }
{      GL_LEFT }
{      GL_RIGHT }
{      GL_AUX0 }
{      GL_AUX1 }
{      GL_AUX2 }
{      GL_AUX3 }

{ RenderingMode }
  GL_RENDER                           = $1C00;
  {$EXTERNALSYM GL_RENDER}
  GL_FEEDBACK                         = $1C01;
  {$EXTERNALSYM GL_FEEDBACK}
  GL_SELECT                           = $1C02;
  {$EXTERNALSYM GL_SELECT}

{ ShadingModel }
  GL_FLAT                             = $1D00;
  {$EXTERNALSYM GL_FLAT}
  GL_SMOOTH                           = $1D01;
  {$EXTERNALSYM GL_SMOOTH}

{ StencilFunction }
{      GL_NEVER }
{      GL_LESS }
{      GL_EQUAL }
{      GL_LEQUAL }
{      GL_GREATER }
{      GL_NOTEQUAL }
{      GL_GEQUAL }
{      GL_ALWAYS }

{ StencilOp }
{      GL_ZERO }
  GL_KEEP                             = $1E00;
  {$EXTERNALSYM GL_KEEP}
  GL_REPLACE                          = $1E01;
  {$EXTERNALSYM GL_REPLACE}
  GL_INCR                             = $1E02;
  {$EXTERNALSYM GL_INCR}
  GL_DECR                             = $1E03;
  {$EXTERNALSYM GL_DECR}
{      GL_INVERT }

{ StringName }
  GL_VENDOR                           = $1F00;
  {$EXTERNALSYM GL_VENDOR}
  GL_RENDERER                         = $1F01;
  {$EXTERNALSYM GL_RENDERER}
  GL_VERSION                          = $1F02;
  {$EXTERNALSYM GL_VERSION}
  GL_EXTENSIONS                       = $1F03;
  {$EXTERNALSYM GL_EXTENSIONS}

{ TextureCoordName }
  GL_S                                = $2000;
  {$EXTERNALSYM GL_S}
  GL_T                                = $2001;
  {$EXTERNALSYM GL_T}
  GL_R                                = $2002;
  {$EXTERNALSYM GL_R}
  GL_Q                                = $2003;
  {$EXTERNALSYM GL_Q}

{ TextureEnvMode }
  GL_MODULATE                         = $2100;
  {$EXTERNALSYM GL_MODULATE}
  GL_DECAL                            = $2101;
  {$EXTERNALSYM GL_DECAL}
{      GL_BLEND }

{ TextureEnvParameter }
  GL_TEXTURE_ENV_MODE                 = $2200;
  {$EXTERNALSYM GL_TEXTURE_ENV_MODE}
  GL_TEXTURE_ENV_COLOR                = $2201;
  {$EXTERNALSYM GL_TEXTURE_ENV_COLOR}

{ TextureEnvTarget }
  GL_TEXTURE_ENV                      = $2300;
  {$EXTERNALSYM GL_TEXTURE_ENV}

{ TextureGenMode }
  GL_EYE_LINEAR                       = $2400;
  {$EXTERNALSYM GL_EYE_LINEAR}
  GL_OBJECT_LINEAR                    = $2401;
  {$EXTERNALSYM GL_OBJECT_LINEAR}
  GL_SPHERE_MAP                       = $2402;
  {$EXTERNALSYM GL_SPHERE_MAP}

{ TextureGenParameter }
  GL_TEXTURE_GEN_MODE                 = $2500;
  {$EXTERNALSYM GL_TEXTURE_GEN_MODE}
  GL_OBJECT_PLANE                     = $2501;
  {$EXTERNALSYM GL_OBJECT_PLANE}
  GL_EYE_PLANE                        = $2502;
  {$EXTERNALSYM GL_EYE_PLANE}

{ TextureMagFilter }
  GL_NEAREST                          = $2600;
  {$EXTERNALSYM GL_NEAREST}
  GL_LINEAR                           = $2601;
  {$EXTERNALSYM GL_LINEAR}

{ TextureMinFilter }
{      GL_NEAREST }
{      GL_LINEAR }
  GL_NEAREST_MIPMAP_NEAREST           = $2700;
  {$EXTERNALSYM GL_NEAREST_MIPMAP_NEAREST}
  GL_LINEAR_MIPMAP_NEAREST            = $2701;
  {$EXTERNALSYM GL_LINEAR_MIPMAP_NEAREST}
  GL_NEAREST_MIPMAP_LINEAR            = $2702;
  {$EXTERNALSYM GL_NEAREST_MIPMAP_LINEAR}
  GL_LINEAR_MIPMAP_LINEAR             = $2703;
  {$EXTERNALSYM GL_LINEAR_MIPMAP_LINEAR}

{ TextureParameterName }
  GL_TEXTURE_MAG_FILTER               = $2800;
  {$EXTERNALSYM GL_TEXTURE_MAG_FILTER}
  GL_TEXTURE_MIN_FILTER               = $2801;
  {$EXTERNALSYM GL_TEXTURE_MIN_FILTER}
  GL_TEXTURE_WRAP_S                   = $2802;
  {$EXTERNALSYM GL_TEXTURE_WRAP_S}
  GL_TEXTURE_WRAP_T                   = $2803;
  {$EXTERNALSYM GL_TEXTURE_WRAP_T}
{      GL_TEXTURE_BORDER_COLOR }

{ TextureTarget }
{      GL_TEXTURE_1D }
{      GL_TEXTURE_2D }

{ TextureWrapMode }
  GL_CLAMP                            = $2900;
  {$EXTERNALSYM GL_CLAMP}
  GL_REPEAT                           = $2901;
  {$EXTERNALSYM GL_REPEAT}

{ ClipPlaneName }
  GL_CLIP_PLANE0                      = $3000;
  {$EXTERNALSYM GL_CLIP_PLANE0}
  GL_CLIP_PLANE1                      = $3001;
  {$EXTERNALSYM GL_CLIP_PLANE1}
  GL_CLIP_PLANE2                      = $3002;
  {$EXTERNALSYM GL_CLIP_PLANE2}
  GL_CLIP_PLANE3                      = $3003;
  {$EXTERNALSYM GL_CLIP_PLANE3}
  GL_CLIP_PLANE4                      = $3004;
  {$EXTERNALSYM GL_CLIP_PLANE4}
  GL_CLIP_PLANE5                      = $3005;
  {$EXTERNALSYM GL_CLIP_PLANE5}

{ LightName }
  GL_LIGHT0                           = $4000;
  {$EXTERNALSYM GL_LIGHT0}
  GL_LIGHT1                           = $4001;
  {$EXTERNALSYM GL_LIGHT1}
  GL_LIGHT2                           = $4002;
  {$EXTERNALSYM GL_LIGHT2}
  GL_LIGHT3                           = $4003;
  {$EXTERNALSYM GL_LIGHT3}
  GL_LIGHT4                           = $4004;
  {$EXTERNALSYM GL_LIGHT4}
  GL_LIGHT5                           = $4005;
  {$EXTERNALSYM GL_LIGHT5}
  GL_LIGHT6                           = $4006;
  {$EXTERNALSYM GL_LIGHT6}
  GL_LIGHT7                           = $4007;
  {$EXTERNALSYM GL_LIGHT7}

// Extensions
  GL_EXT_vertex_array                 = 1;
  {$EXTERNALSYM GL_EXT_vertex_array}
  GL_WIN_swap_hint                    = 1;
  {$EXTERNALSYM GL_WIN_swap_hint}

// EXT_vertex_array
  GL_VERTEX_ARRAY_EXT               = $8074;
  {$EXTERNALSYM GL_VERTEX_ARRAY_EXT}
  GL_NORMAL_ARRAY_EXT               = $8075;
  {$EXTERNALSYM GL_NORMAL_ARRAY_EXT}
  GL_COLOR_ARRAY_EXT                = $8076;
  {$EXTERNALSYM GL_COLOR_ARRAY_EXT}
  GL_INDEX_ARRAY_EXT                = $8077;
  {$EXTERNALSYM GL_INDEX_ARRAY_EXT}
  GL_TEXTURE_COORD_ARRAY_EXT        = $8078;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_EXT}
  GL_EDGE_FLAG_ARRAY_EXT            = $8079;
  {$EXTERNALSYM GL_EDGE_FLAG_ARRAY_EXT}
  GL_VERTEX_ARRAY_SIZE_EXT          = $807A;
  {$EXTERNALSYM GL_VERTEX_ARRAY_SIZE_EXT}
  GL_VERTEX_ARRAY_TYPE_EXT          = $807B;
  {$EXTERNALSYM GL_VERTEX_ARRAY_TYPE_EXT}
  GL_VERTEX_ARRAY_STRIDE_EXT        = $807C;
  {$EXTERNALSYM GL_VERTEX_ARRAY_STRIDE_EXT}
  GL_VERTEX_ARRAY_COUNT_EXT         = $807D;
  {$EXTERNALSYM GL_VERTEX_ARRAY_COUNT_EXT}
  GL_NORMAL_ARRAY_TYPE_EXT          = $807E;
  {$EXTERNALSYM GL_NORMAL_ARRAY_TYPE_EXT}
  GL_NORMAL_ARRAY_STRIDE_EXT        = $807F;
  {$EXTERNALSYM GL_NORMAL_ARRAY_STRIDE_EXT}
  GL_NORMAL_ARRAY_COUNT_EXT         = $8080;
  {$EXTERNALSYM GL_NORMAL_ARRAY_COUNT_EXT}
  GL_COLOR_ARRAY_SIZE_EXT           = $8081;
  {$EXTERNALSYM GL_COLOR_ARRAY_SIZE_EXT}
  GL_COLOR_ARRAY_TYPE_EXT           = $8082;
  {$EXTERNALSYM GL_COLOR_ARRAY_TYPE_EXT}
  GL_COLOR_ARRAY_STRIDE_EXT         = $8083;
  {$EXTERNALSYM GL_COLOR_ARRAY_STRIDE_EXT}
  GL_COLOR_ARRAY_COUNT_EXT          = $8084;
  {$EXTERNALSYM GL_COLOR_ARRAY_COUNT_EXT}
  GL_INDEX_ARRAY_TYPE_EXT           = $8085;
  {$EXTERNALSYM GL_INDEX_ARRAY_TYPE_EXT}
  GL_INDEX_ARRAY_STRIDE_EXT         = $8086;
  {$EXTERNALSYM GL_INDEX_ARRAY_STRIDE_EXT}
  GL_INDEX_ARRAY_COUNT_EXT          = $8087;
  {$EXTERNALSYM GL_INDEX_ARRAY_COUNT_EXT}
  GL_TEXTURE_COORD_ARRAY_SIZE_EXT   = $8088;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_SIZE_EXT}
  GL_TEXTURE_COORD_ARRAY_TYPE_EXT   = $8089;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_TYPE_EXT}
  GL_TEXTURE_COORD_ARRAY_STRIDE_EXT = $808A;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_STRIDE_EXT}
  GL_TEXTURE_COORD_ARRAY_COUNT_EXT  = $808B;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_COUNT_EXT}
  GL_EDGE_FLAG_ARRAY_STRIDE_EXT     = $808C;
  {$EXTERNALSYM GL_EDGE_FLAG_ARRAY_STRIDE_EXT}
  GL_EDGE_FLAG_ARRAY_COUNT_EXT      = $808D;
  {$EXTERNALSYM GL_EDGE_FLAG_ARRAY_COUNT_EXT}
  GL_VERTEX_ARRAY_POINTER_EXT       = $808E;
  {$EXTERNALSYM GL_VERTEX_ARRAY_POINTER_EXT}
  GL_NORMAL_ARRAY_POINTER_EXT       = $808F;
  {$EXTERNALSYM GL_NORMAL_ARRAY_POINTER_EXT}
  GL_COLOR_ARRAY_POINTER_EXT        = $8090;
  {$EXTERNALSYM GL_COLOR_ARRAY_POINTER_EXT}
  GL_INDEX_ARRAY_POINTER_EXT        = $8091;
  {$EXTERNALSYM GL_INDEX_ARRAY_POINTER_EXT}
  GL_TEXTURE_COORD_ARRAY_POINTER_EXT = $8092;
  {$EXTERNALSYM GL_TEXTURE_COORD_ARRAY_POINTER_EXT}
  GL_EDGE_FLAG_ARRAY_POINTER_EXT    = $8093;
  {$EXTERNALSYM GL_EDGE_FLAG_ARRAY_POINTER_EXT}

type
  PPointFloat = ^TPointFloat;
  {$EXTERNALSYM _POINTFLOAT}
  _POINTFLOAT = record
    X,Y: Single;
  end;
  TPointFloat = _POINTFLOAT;
  {$EXTERNALSYM POINTFLOAT}
  POINTFLOAT = _POINTFLOAT;

  PGlyphMetricsFloat = ^TGlyphMetricsFloat;
  {$EXTERNALSYM _GLYPHMETRICSFLOAT}
  _GLYPHMETRICSFLOAT = record
    gmfBlackBoxX: Single;
    gmfBlackBoxY: Single;
    gmfptGlyphOrigin: TPointFloat;
    gmfCellIncX: Single;
    gmfCellIncY: Single;
  end;
  TGlyphMetricsFloat = _GLYPHMETRICSFLOAT;
  {$EXTERNALSYM GLYPHMETRICSFLOAT}
  GLYPHMETRICSFLOAT = _GLYPHMETRICSFLOAT;

const
  {$EXTERNALSYM WGL_FONT_LINES}
  WGL_FONT_LINES      = 0;
  {$EXTERNALSYM WGL_FONT_POLYGONS}
  WGL_FONT_POLYGONS   = 1;

{***********************************************************}

procedure glAccum (op: GLenum; value: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glAccum}
procedure glAlphaFunc (func: GLenum; ref: GLclampf); cdecl; {stdcall;}
  {$EXTERNALSYM glAlphaFunc}
procedure glBegin (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glBegin}
procedure glBitmap (width, height: GLsizei; xorig, yorig: GLfloat;
                    xmove, ymove: GLfloat; bitmap: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glBitmap}
procedure glBlendFunc (sfactor, dfactor: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glBlendFunc}
procedure glCallList (list: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glCallList}
procedure glCallLists (n: GLsizei; cltype: GLenum; lists: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glCallLists}
procedure glClear (mask: GLbitfield); cdecl; {stdcall;}
  {$EXTERNALSYM glClear}
procedure glClearAccum (red, green, blue, alpha: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glClearAccum}
procedure glClearColor (red, green, blue, alpha: GLclampf); cdecl; {stdcall;}
  {$EXTERNALSYM glClearColor}
procedure glClearDepth (depth: GLclampd); cdecl; {stdcall;}
  {$EXTERNALSYM glClearDepth}
procedure glClearIndex (c: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glClearIndex}
procedure glClearStencil (s: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glClearStencil}
procedure glClipPlane (plane: GLenum; equation: PGLDouble); cdecl; {stdcall;}
  {$EXTERNALSYM glClipPlane}

procedure glColor3b (red, green, blue: GLbyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3b}
procedure glColor3bv (v: PGLByte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3bv}
procedure glColor3d (red, green, blue: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3d}
procedure glColor3dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3dv}
procedure glColor3f (red, green, blue: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3f}
procedure glColor3fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3fv}
procedure glColor3i (red, green, blue: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3i}
procedure glColor3iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3iv}
procedure glColor3s (red, green, blue: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3s}
procedure glColor3sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3sv}
procedure glColor3ub (red, green, blue: GLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3ub}
procedure glColor3ubv (v: PGLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3ubv}
procedure glColor3ui (red, green, blue: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3ui}
procedure glColor3uiv (v: PGLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3uiv}
procedure glColor3us (red, green, blue: GLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3us}
procedure glColor3usv (v: PGLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor3usv}
procedure glColor4b (red, green, blue, alpha: GLbyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4b}
procedure glColor4bv (v: PGLbyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4bv}
procedure glColor4d (red, green, blue, alpha: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4d}
procedure glColor4dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4dv}
procedure glColor4f (red, green, blue, alpha: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4f}
procedure glColor4fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4fv}
procedure glColor4i (red, green, blue, alpha: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4i}
procedure glColor4iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4iv}
procedure glColor4s (red, green, blue, alpha: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4s}
procedure glColor4sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4sv}
procedure glColor4ub (red, green, blue, alpha: GLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4ub}
procedure glColor4ubv (v: PGLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4ubv}
procedure glColor4ui (red, green, blue, alpha: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4ui}
procedure glColor4uiv (v: PGLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4uiv}
procedure glColor4us (red, green, blue, alpha: GLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4us}
procedure glColor4usv (v: PGLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glColor4usv}
procedure glColor(red, green, blue: GLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLubyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLuint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue: GLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLubyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLuint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor(red, green, blue, alpha: GLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor}
procedure glColor3(v: PGLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLubyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLuint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor3(v: PGLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor3}
procedure glColor4(v: PGLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLubyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLuint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}
procedure glColor4(v: PGLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glColor4}

procedure glColorMask (red, green, blue, alpha: GLboolean); cdecl; {stdcall;}
  {$EXTERNALSYM glColorMask}
procedure glColorMaterial (face, mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glColorMaterial}
procedure glCopyPixels (x,y: GLint; width, height: GLsizei; pixeltype: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glCopyPixels}
procedure glCullFace (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glCullFace}
procedure glDeleteLists (list: GLuint; range: GLsizei); cdecl; {stdcall;}
  {$EXTERNALSYM glDeleteLists}
procedure glDepthFunc (func: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glDepthFunc}
procedure glDepthMask (flag: GLboolean); cdecl; {stdcall;}
  {$EXTERNALSYM glDepthMask}
procedure glDepthRange (zNear, zFar: GLclampd); cdecl; {stdcall;}
  {$EXTERNALSYM glDepthRange}
procedure glDisable (cap: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glDisable}
procedure glDrawBuffer (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glDrawBuffer}
procedure glDrawPixels (width, height: GLsizei; format, pixeltype: GLenum;
             pixels: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glDrawPixels}
procedure glEdgeFlag (flag: GLboolean); cdecl; {stdcall;}
  {$EXTERNALSYM glEdgeFlag}
procedure glEdgeFlagv (flag: PGLboolean); cdecl; {stdcall;}
  {$EXTERNALSYM glEdgeFlagv}
procedure glEnable (cap: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glEnable}
procedure glEnd; cdecl; {stdcall;}
  {$EXTERNALSYM glEnd}
procedure glEndList; cdecl; {stdcall;}
  {$EXTERNALSYM glEndList}

procedure glEvalCoord1d (u: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord1d}
procedure glEvalCoord1dv (u: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord1dv}
procedure glEvalCoord1f (u: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord1f}
procedure glEvalCoord1fv (u: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord1fv}
procedure glEvalCoord2d (u,v: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord2d}
procedure glEvalCoord2dv (u: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord2dv}
procedure glEvalCoord2f (u,v: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord2f}
procedure glEvalCoord2fv (u: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalCoord2fv}
procedure glEvalCoord(u: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord}
procedure glEvalCoord(u: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord}
procedure glEvalCoord(u,v: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord}
procedure glEvalCoord(u,v: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord}
procedure glEvalCoord1(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord1}
procedure glEvalCoord1(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord1}
procedure glEvalCoord2(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord2}
procedure glEvalCoord2(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalCoord2}

procedure glEvalMesh1 (mode: GLenum; i1, i2: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalMesh1}
procedure glEvalMesh2 (mode: GLenum; i1, i2, j1, j2: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalMesh2}
procedure glEvalMesh(mode: GLenum; i1, i2: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalMesh}
procedure glEvalMesh(mode: GLenum; i1, i2, j1, j2: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalMesh}

procedure glEvalPoint1 (i: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalPoint1}
procedure glEvalPoint2 (i,j: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glEvalPoint2}
procedure glEvalPoint(i: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalPoint}
procedure glEvalPoint(i,j: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glEvalPoint}

procedure glFeedbackBuffer (size: GLsizei; buftype: GLenum; buffer: PGLFloat); cdecl; {stdcall;}
  {$EXTERNALSYM glFeedbackBuffer}
procedure glFinish; cdecl; {stdcall;}
  {$EXTERNALSYM glFinish}
procedure glFlush; cdecl; {stdcall;}
  {$EXTERNALSYM glFlush}

procedure glFogf (pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glFogf}
procedure glFogfv (pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glFogfv}
procedure glFogi (pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glFogi}
procedure glFogiv (pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glFogiv}
procedure glFog(pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glFog}
procedure glFog(pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glFog}
procedure glFog(pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glFog}
procedure glFog(pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glFog}

procedure glFrontFace (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glFrontFace}
procedure glFrustum (left, right, bottom, top, zNear, zFar: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glFrustum}
function  glGenLists (range: GLsizei): GLuint; cdecl; {stdcall;}
  {$EXTERNALSYM glGenLists}
procedure glGetBooleanv (pname: GLenum; params: PGLboolean); cdecl; {stdcall;}
  {$EXTERNALSYM glGetBooleanv}
procedure glGetClipPlane (plane: GLenum; equation: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glGetClipPlane}
procedure glGetDoublev (pname: GLenum; params: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glGetDoublev}
function  glGetError: GLenum; cdecl; {stdcall;}
  {$EXTERNALSYM glGetError}
procedure glGetFloatv (pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetFloatv}
procedure glGetIntegerv (pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetIntegerv}

procedure glGetLightfv (light: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetLightfv}
procedure glGetLightiv (light: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetLightiv}
procedure glGetLight(light: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetLight}
procedure glGetLight(light: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetLight}

procedure glGetMapdv (target: GLenum; query: GLenum; v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glGetMapdv}
procedure glGetMapfv (target: GLenum; query: GLenum; v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetMapfv}
procedure glGetMapiv (target: GLenum; query: GLenum; v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetMapiv}
procedure glGetMap(target: GLenum; query: GLenum; v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetMap}
procedure glGetMap(target: GLenum; query: GLenum; v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetMap}
procedure glGetMap(target: GLenum; query: GLenum; v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetMap}

procedure glGetMaterialfv (face: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetMaterialfv}
procedure glGetMaterialiv (face: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetMaterialiv}
procedure glGetMaterial(face: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetMaterial}
procedure glGetMaterial(face: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetMaterial}

procedure glGetPixelMapfv (map: GLenum; values: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetPixelMapfv}
procedure glGetPixelMapuiv (map: GLenum; values: PGLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetPixelMapuiv}
procedure glGetPixelMapusv (map: GLenum; values: PGLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glGetPixelMapusv}
procedure glGetPixelMap(map: GLenum; values: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetPixelMap}
procedure glGetPixelMap(map: GLenum; values: PGLuint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetPixelMap}
procedure glGetPixelMap(map: GLenum; values: PGLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetPixelMap}

procedure glGetPolygonStipple (var mask: GLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glGetPolygonStipple}
function  glGetString (name: GLenum): PChar; cdecl; {stdcall;}
  {$EXTERNALSYM glGetString}

procedure glGetTexEnvfv (target: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexEnvfv}
procedure glGetTexEnviv (target: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexEnviv}
procedure glGetTexEnv(target: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexEnv}
procedure glGetTexEnv(target: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexEnv}

procedure glGetTexGendv (coord: GLenum; pname: GLenum; params: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexGendv}
procedure glGetTexGenfv (coord: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexGenfv}
procedure glGetTexGeniv (coord: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexGeniv}
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexGen}
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexGen}
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexGen}

procedure glGetTexImage (target: GLenum; level: GLint; format: GLenum; _type: GLenum; pixels: pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexImage}

procedure glGetTexLevelParameterfv (target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexLevelParameterfv}
procedure glGetTexLevelParameteriv (target: GLenum; level: GLint; pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexLevelParameteriv}
procedure glGetTexLevelParameter(target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexLevelParameter}
procedure glGetTexLevelParameter(target: GLenum; level: GLint; pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexLevelParameter}

procedure glGetTexParameterfv (target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexParameterfv}
procedure glGetTexParameteriv (target, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glGetTexParameteriv}
procedure glGetTexParameter(target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexParameter}
procedure glGetTexParameter(target, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glGetTexParameter}

procedure glHint (target, mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glHint}
procedure glIndexMask (mask: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexMask}

procedure glIndexd (c: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexd}
procedure glIndexdv (c: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexdv}
procedure glIndexf (c: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexf}
procedure glIndexfv (c: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexfv}
procedure glIndexi (c: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexi}
procedure glIndexiv (c: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexiv}
procedure glIndexs (c: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexs}
procedure glIndexsv (c: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glIndexsv}
procedure glIndex(c: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: GLfloat); cdecl; {stdcall;}  overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}
procedure glIndex(c: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glIndex}

procedure glInitNames; cdecl; {stdcall;}
  {$EXTERNALSYM glInitNames}
function  glIsEnabled (cap: GLenum): GLBoolean; cdecl; {stdcall;}
  {$EXTERNALSYM glIsEnabled}
function  glIsList (list: GLuint): GLBoolean;   cdecl; {stdcall;}
  {$EXTERNALSYM glIsList}

procedure glLightModelf (pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLightModelf}
procedure glLightModelfv (pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLightModelfv}
procedure glLightModeli (pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glLightModeli}
procedure glLightModeliv (pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glLightModeliv}
procedure glLightModel(pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLightModel}
procedure glLightModel(pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLightModel}
procedure glLightModel(pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLightModel}
procedure glLightModel(pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLightModel}

procedure glLightf (light, pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLightf}
procedure glLightfv (light, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLightfv}
procedure glLighti (light, pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glLighti}
procedure glLightiv (light, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glLightiv}
procedure glLight(light, pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLight}
procedure glLight(light, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLight}
procedure glLight(light, pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLight}
procedure glLight(light, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLight}

procedure glLineStipple (factor: GLint; pattern: GLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glLineStipple}
procedure glLineWidth (width: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLineWidth}
procedure glListBase (base: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glListBase}
procedure glLoadIdentity; cdecl; {stdcall;}
  {$EXTERNALSYM glLoadIdentity}

procedure glLoadMatrixd (m: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glLoadMatrixd}
procedure glLoadMatrixf (m: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glLoadMatrixf}
procedure glLoadMatrix(m: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLoadMatrix}
procedure glLoadMatrix(m: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glLoadMatrix}

procedure glLoadName (name: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glLoadName}
procedure glLogicOp (opcode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glLogicOp}

procedure glMap1d (target: GLenum; u1,u2: GLdouble; stride, order: GLint;
  Points: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glMap1d}
procedure glMap1f (target: GLenum; u1,u2: GLfloat; stride, order: GLint;
  Points: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMap1f}
procedure glMap2d (target: GLenum;
  u1,u2: GLdouble; ustride, uorder: GLint;
  v1,v2: GLdouble; vstride, vorder: GLint; Points: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glMap2d}
procedure glMap2f (target: GLenum;
  u1,u2: GLfloat; ustride, uorder: GLint;
  v1,v2: GLfloat; vstride, vorder: GLint; Points: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMap2f}
procedure glMap(target: GLenum; u1,u2: GLdouble; stride, order: GLint;
  Points: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMap}
procedure glMap(target: GLenum; u1,u2: GLfloat; stride, order: GLint;
  Points: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMap}
procedure glMap(target: GLenum;
  u1,u2: GLdouble; ustride, uorder: GLint;
  v1,v2: GLdouble; vstride, vorder: GLint; Points: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMap}
procedure glMap(target: GLenum;
  u1,u2: GLfloat; ustride, uorder: GLint;
  v1,v2: GLfloat; vstride, vorder: GLint; Points: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMap}

procedure glMapGrid1d (un: GLint; u1, u2: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glMapGrid1d}
procedure glMapGrid1f (un: GLint; u1, u2: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMapGrid1f}
procedure glMapGrid2d (un: GLint; u1, u2: GLdouble;
                       vn: GLint; v1, v2: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glMapGrid2d}
procedure glMapGrid2f (un: GLint; u1, u2: GLfloat;
                       vn: GLint; v1, v2: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMapGrid2f}
procedure glMapGrid(un: GLint; u1, u2: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMapGrid}
procedure glMapGrid(un: GLint; u1, u2: GLfloat); cdecl; {stdcall;}  overload;
  {$EXTERNALSYM glMapGrid}
procedure glMapGrid(un: GLint; u1, u2: GLdouble;
                    vn: GLint; v1, v2: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMapGrid}
procedure glMapGrid(un: GLint; u1, u2: GLfloat;
                    vn: GLint; v1, v2: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMapGrid}

procedure glMaterialf (face, pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMaterialf}
procedure glMaterialfv (face, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMaterialfv}
procedure glMateriali (face, pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glMateriali}
procedure glMaterialiv (face, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glMaterialiv}
procedure glMaterial(face, pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMaterial}
procedure glMaterial(face, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMaterial}
procedure glMaterial(face, pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMaterial}
procedure glMaterial(face, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMaterial}

procedure glMatrixMode (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glMatrixMode}

procedure glMultMatrixd (m: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glMultMatrixd}
procedure glMultMatrixf (m: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glMultMatrixf}
procedure glMultMatrix(m: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMultMatrix}
procedure glMultMatrix(m: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glMultMatrix}

procedure glNewList (ListIndex: GLuint; mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glNewList}

procedure glNormal3b (nx, ny, nz: GLbyte); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3b}
procedure glNormal3bv (v: PGLbyte); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3bv}
procedure glNormal3d (nx, ny, nz: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3d}
procedure glNormal3dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3dv}
procedure glNormal3f (nx, ny, nz: GLFloat); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3f}
procedure glNormal3fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3fv}
procedure glNormal3i (nx, ny, nz: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3i}
procedure glNormal3iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3iv}
procedure glNormal3s (nx, ny, nz: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3s}
procedure glNormal3sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glNormal3sv}
procedure glNormal(nx, ny, nz: GLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal}
procedure glNormal3(v: PGLbyte); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal3}
procedure glNormal(nx, ny, nz: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal}
procedure glNormal3(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal3}
procedure glNormal(nx, ny, nz: GLFloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal}
procedure glNormal3(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal3}
procedure glNormal(nx, ny, nz: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal}
procedure glNormal3(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal3}
procedure glNormal(nx, ny, nz: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal}
procedure glNormal3(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glNormal3}

procedure glOrtho (left, right, bottom, top, zNear, zFar: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glOrtho}
procedure glPassThrough (token: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPassThrough}

procedure glPixelMapfv (map: GLenum; mapsize: GLint; values: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelMapfv}
procedure glPixelMapuiv (map: GLenum; mapsize: GLint; values: PGLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelMapuiv}
procedure glPixelMapusv (map: GLenum; mapsize: GLint; values: PGLushort); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelMapusv}
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelMap}
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLuint); cdecl; {stdcall;}  overload;
  {$EXTERNALSYM glPixelMap}
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLushort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelMap}

procedure glPixelStoref (pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelStoref}
procedure glPixelStorei (pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelStorei}
procedure glPixelStore(pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelStore}
procedure glPixelStore(pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelStore}

procedure glPixelTransferf (pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelTransferf}
procedure glPixelTransferi (pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelTransferi}
procedure glPixelTransfer(pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelTransfer}
procedure glPixelTransfer(pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glPixelTransfer}

procedure glPixelZoom (xfactor, yfactor: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPixelZoom}
procedure glPointSize (size: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glPointSize}
procedure glPolygonMode (face, mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glPolygonMode}
procedure glPolygonStipple (mask: PGLubyte); cdecl; {stdcall;}
  {$EXTERNALSYM glPolygonStipple}
procedure glPopAttrib; cdecl; {stdcall;}
  {$EXTERNALSYM glPopAttrib}
procedure glPopMatrix; cdecl; {stdcall;}
  {$EXTERNALSYM glPopMatrix}
procedure glPopName; cdecl; {stdcall;}
  {$EXTERNALSYM glPopName}
procedure glPushAttrib(mask: GLbitfield); cdecl; {stdcall;}
  {$EXTERNALSYM glPushAttrib}
procedure glPushMatrix; cdecl; {stdcall;}
  {$EXTERNALSYM glPushMatrix}
procedure glPushName(name: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glPushName}

procedure glRasterPos2d (x,y: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2d}
procedure glRasterPos2dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2dv}
procedure glRasterPos2f (x,y: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2f}
procedure glRasterPos2fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2fv}
procedure glRasterPos2i (x,y: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2i}
procedure glRasterPos2iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2iv}
procedure glRasterPos2s (x,y: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2s}
procedure glRasterPos2sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos2sv}
procedure glRasterPos3d (x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3d}
procedure glRasterPos3dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3dv}
procedure glRasterPos3f (x,y,z: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3f}
procedure glRasterPos3fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3fv}
procedure glRasterPos3i (x,y,z: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3i}
procedure glRasterPos3iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3iv}
procedure glRasterPos3s (x,y,z: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3s}
procedure glRasterPos3sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos3sv}
procedure glRasterPos4d (x,y,z,w: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4d}
procedure glRasterPos4dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4dv}
procedure glRasterPos4f (x,y,z,w: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4f}
procedure glRasterPos4fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4fv}
procedure glRasterPos4i (x,y,z,w: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4i}
procedure glRasterPos4iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4iv}
procedure glRasterPos4s (x,y,z,w: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4s}
procedure glRasterPos4sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRasterPos4sv}
procedure glRasterPos(x,y: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos2(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos2}
procedure glRasterPos(x,y: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos2(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos2}
procedure glRasterPos(x,y: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos2(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos2}
procedure glRasterPos(x,y: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos2(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos2}
procedure glRasterPos(x,y,z: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos3(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos3}
procedure glRasterPos(x,y,z: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos3(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos3}
procedure glRasterPos(x,y,z: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos3(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos3}
procedure glRasterPos(x,y,z: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos3(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos3}
procedure glRasterPos(x,y,z,w: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos4(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos4}
procedure glRasterPos(x,y,z,w: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos4(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos4}
procedure glRasterPos(x,y,z,w: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos4(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos4}
procedure glRasterPos(x,y,z,w: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos}
procedure glRasterPos4(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRasterPos4}

procedure glReadBuffer (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glReadBuffer}
procedure glReadPixels (x,y: GLint; width, height: GLsizei;
  format, _type: GLenum; pixels: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glReadPixels}

procedure glRectd (x1, y1, x2, y2: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRectd}
procedure glRectdv (v1, v2: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRectdv}
procedure glRectf (x1, y1, x2, y2: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRectf}
procedure glRectfv (v1, v2: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRectfv}
procedure glRecti (x1, y1, x2, y2: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRecti}
procedure glRectiv (v1, v2: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glRectiv}
procedure glRects (x1, y1, x2, y2: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRects}
procedure glRectsv (v1, v2: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glRectsv}
procedure glRect(x1, y1, x2, y2: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(v1, v2: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(x1, y1, x2, y2: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(v1, v2: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(x1, y1, x2, y2: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(v1, v2: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(x1, y1, x2, y2: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}
procedure glRect(v1, v2: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRect}

function  glRenderMode (mode: GLenum): GLint; cdecl; {stdcall;}
  {$EXTERNALSYM glRenderMode}

procedure glRotated (angle, x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glRotated}
procedure glRotatef (angle, x,y,z: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glRotatef}
procedure glRotate(angle, x,y,z: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRotate}
procedure glRotate(angle, x,y,z: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glRotate}

procedure glScaled (x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glScaled}
procedure glScalef (x,y,z: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glScalef}
procedure glScale(x,y,z: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glScale}
procedure glScale(x,y,z: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glScale}

procedure glScissor (x,y: GLint; width, height: GLsizei); cdecl; {stdcall;}
  {$EXTERNALSYM glScissor}
procedure glSelectBuffer (size: GLsizei; buffer: PGLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glSelectBuffer}
procedure glShadeModel (mode: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glShadeModel}
procedure glStencilFunc (func: GLenum; ref: GLint; mask: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glStencilFunc}
procedure glStencilMask (mask: GLuint); cdecl; {stdcall;}
  {$EXTERNALSYM glStencilMask}
procedure glStencilOp (fail, zfail, zpass: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM glStencilOp}

procedure glTexCoord1d (s: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1d}
procedure glTexCoord1dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1dv}
procedure glTexCoord1f (s: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1f}
procedure glTexCoord1fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1fv}
procedure glTexCoord1i (s: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1i}
procedure glTexCoord1iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1iv}
procedure glTexCoord1s (s: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1s}
procedure glTexCoord1sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord1sv}
procedure glTexCoord2d (s,t: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2d}
procedure glTexCoord2dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2dv}
procedure glTexCoord2f (s,t: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2f}
procedure glTexCoord2fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2fv}
procedure glTexCoord2i (s,t: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2i}
procedure glTexCoord2iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2iv}
procedure glTexCoord2s (s,t: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2s}
procedure glTexCoord2sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord2sv}
procedure glTexCoord3d (s,t,r: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3d}
procedure glTexCoord3dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3dv}
procedure glTexCoord3f (s,t,r: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3f}
procedure glTexCoord3fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3fv}
procedure glTexCoord3i (s,t,r: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3i}
procedure glTexCoord3iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3iv}
procedure glTexCoord3s (s,t,r: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3s}
procedure glTexCoord3sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord3sv}
procedure glTexCoord4d (s,t,r,q: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4d}
procedure glTexCoord4dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4dv}
procedure glTexCoord4f (s,t,r,q: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4f}
procedure glTexCoord4fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4fv}
procedure glTexCoord4i (s,t,r,q: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4i}
procedure glTexCoord4iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4iv}
procedure glTexCoord4s (s,t,r,q: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4s}
procedure glTexCoord4sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glTexCoord4sv}
procedure glTexCoord(s: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord1(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord1}
procedure glTexCoord(s: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord1(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord1}
procedure glTexCoord(s: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord1(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord1}
procedure glTexCoord(s: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord1(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord1}
procedure glTexCoord(s,t: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord2(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord2}
procedure glTexCoord(s,t: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord2(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord2}
procedure glTexCoord(s,t: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord2(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord2}
procedure glTexCoord(s,t: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord2(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord2}
procedure glTexCoord(s,t,r: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord3(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord3}
procedure glTexCoord(s,t,r: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord3(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord3}
procedure glTexCoord(s,t,r: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord3(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord3}
procedure glTexCoord(s,t,r: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord3(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord3}
procedure glTexCoord(s,t,r,q: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord4(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord4}
procedure glTexCoord(s,t,r,q: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord4(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord4}
procedure glTexCoord(s,t,r,q: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord4(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord4}
procedure glTexCoord(s,t,r,q: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord}
procedure glTexCoord4(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexCoord4}

procedure glTexEnvf (target, pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexEnvf}
procedure glTexEnvfv (target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexEnvfv}
procedure glTexEnvi (target, pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexEnvi}
procedure glTexEnviv (target, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexEnviv}
procedure glTexEnv(target, pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexEnv}
procedure glTexEnv(target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexEnv}
procedure glTexEnv(target, pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexEnv}
procedure glTexEnv(target, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexEnv}

procedure glTexGend (coord, pname: GLenum; param: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGend}
procedure glTexGendv (coord, pname: GLenum; params: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGendv}
procedure glTexGenf (coord, pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGenf}
procedure glTexGenfv (coord, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGenfv}
procedure glTexGeni (coord, pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGeni}
procedure glTexGeniv (coord, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexGeniv}
procedure glTexGen(coord, pname: GLenum; param: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}
procedure glTexGen(coord, pname: GLenum; params: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}
procedure glTexGen(coord, pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}
procedure glTexGen(coord, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}
procedure glTexGen(coord, pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}
procedure glTexGen(coord, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexGen}

procedure glTexImage1D (target: GLenum; level, components: GLint;
  width: GLsizei; border: GLint; format, _type: GLenum; pixels: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glTexImage1D}
procedure glTexImage2D (target: GLenum; level, components: GLint;
  width, height: GLsizei; border: GLint; format, _type: GLenum; pixels: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM glTexImage2D}

procedure glTexParameterf (target, pname: GLenum; param: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexParameterf}
procedure glTexParameterfv (target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTexParameterfv}
procedure glTexParameteri (target, pname: GLenum; param: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexParameteri}
procedure glTexParameteriv (target, pname: GLenum; params: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glTexParameteriv}
procedure glTexParameter(target, pname: GLenum; param: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexParameter}
procedure glTexParameter(target, pname: GLenum; params: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexParameter}
procedure glTexParameter(target, pname: GLenum; param: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexParameter}
procedure glTexParameter(target, pname: GLenum; params: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTexParameter}

procedure glTranslated (x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glTranslated}
procedure glTranslatef (x,y,z: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glTranslatef}
procedure glTranslate(x,y,z: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTranslate}
procedure glTranslate(x,y,z: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glTranslate}

procedure glVertex2d (x,y: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2d}
procedure glVertex2dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2dv}
procedure glVertex2f (x,y: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2f}
procedure glVertex2fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2fv}
procedure glVertex2i (x,y: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2i}
procedure glVertex2iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2iv}
procedure glVertex2s (x,y: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2s}
procedure glVertex2sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex2sv}
procedure glVertex3d (x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3d}
procedure glVertex3dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3dv}
procedure glVertex3f (x,y,z: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3f}
procedure glVertex3fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3fv}
procedure glVertex3i (x,y,z: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3i}
procedure glVertex3iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3iv}
procedure glVertex3s (x,y,z: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3s}
procedure glVertex3sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex3sv}
procedure glVertex4d (x,y,z,w: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4d}
procedure glVertex4dv (v: PGLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4dv}
procedure glVertex4f (x,y,z,w: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4f}
procedure glVertex4fv (v: PGLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4fv}
procedure glVertex4i (x,y,z,w: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4i}
procedure glVertex4iv (v: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4iv}
procedure glVertex4s (x,y,z,w: GLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4s}
procedure glVertex4sv (v: PGLshort); cdecl; {stdcall;}
  {$EXTERNALSYM glVertex4sv}
procedure glVertex(x,y: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex2(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex2}
procedure glVertex(x,y: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex2(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex2}
procedure glVertex(x,y: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex2(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex2}
procedure glVertex(x,y: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex2(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex2}
procedure glVertex(x,y,z: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex3(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex3}
procedure glVertex(x,y,z: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex3(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex3}
procedure glVertex(x,y,z: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex3(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex3}
procedure glVertex(x,y,z: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex3(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex3}
procedure glVertex(x,y,z,w: GLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex4(v: PGLdouble); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex4}
procedure glVertex(x,y,z,w: GLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex4(v: PGLfloat); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex4}
procedure glVertex(x,y,z,w: GLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex4(v: PGLint); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex4}
procedure glVertex(x,y,z,w: GLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex}
procedure glVertex4(v: PGLshort); cdecl; {stdcall;} overload;
  {$EXTERNALSYM glVertex4}

procedure glViewport (x,y: GLint; width, height: GLsizei); cdecl; {stdcall;}
  {$EXTERNALSYM glViewport}

type

// EXT_vertex_array
  PFNGLARRAYELEMENTEXTPROC = procedure (i: GLint) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLARRAYELEMENTEXTPROC}
  TGLARRAYELEMENTEXTPROC = PFNGLARRAYELEMENTEXTPROC;
  PFNGLDRAWARRAYSEXTPROC = procedure (mode: GLenum; first: GLint; count: GLsizei) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLDRAWARRAYSEXTPROC}
  TGLDRAWARRAYSEXTPROC = PFNGLDRAWARRAYSEXTPROC;
  PFNGLVERTEXPOINTEREXTPROC = procedure (size: GLint; type_: GLenum;
    stride, count: GLsizei; P: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLVERTEXPOINTEREXTPROC}
  TGLVERTEXPOINTEREXTPROC = PFNGLVERTEXPOINTEREXTPROC;
  PFNGLNORMALPOINTEREXTPROC = procedure (type_: GLenum; stride, count: GLsizei;
    P: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLNORMALPOINTEREXTPROC}
  TGLNORMALPOINTEREXTPROC = PFNGLNORMALPOINTEREXTPROC;
  PFNGLCOLORPOINTEREXTPROC = procedure (size: GLint; type_: GLenum;
    stride, count: GLsizei; P: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLCOLORPOINTEREXTPROC}
  TGLCOLORPOINTEREXTPROC = PFNGLCOLORPOINTEREXTPROC;
  PFNGLINDEXPOINTEREXTPROC = procedure (type_: GLenum; stride, count: GLsizei;
    P: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLINDEXPOINTEREXTPROC}
  TGLINDEXPOINTEREXTPROC = PFNGLINDEXPOINTEREXTPROC;
  PFNGLTEXCOORDPOINTEREXTPROC = procedure (size: GLint; type_: GLenum;
    stride, count: GLsizei; P: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLTEXCOORDPOINTEREXTPROC}
  TGLTEXCOORDPOINTEREXTPROC = PFNGLTEXCOORDPOINTEREXTPROC;
  PFNGLEDGEFLAGPOINTEREXTPROC = procedure (stride, count: GLsizei;
    P: PGLboolean) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLEDGEFLAGPOINTEREXTPROC}
  TGLEDGEFLAGPOINTEREXTPROC = PFNGLEDGEFLAGPOINTEREXTPROC;
  PFNGLGETPOINTERVEXTPROC = procedure (pname: GLenum; var Params) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLGETPOINTERVEXTPROC}
  TGLGETPOINTERVEXTPROC = PFNGLGETPOINTERVEXTPROC;

// WIN_swap_hint

  PFNGLADDSWAPHINTRECTWINPROC = procedure (x, y: GLint; width, height: GLsizei) cdecl; {stdcall;}
  {$EXTERNALSYM PFNGLADDSWAPHINTRECTWINPROC}
  TGLADDSWAPHINTRECTWINPROC = PFNGLADDSWAPHINTRECTWINPROC;

{ OpenGL Utility routines (glu.h) =======================================}

function gluErrorString (errCode: GLenum): PChar; cdecl; {stdcall;}
  {$EXTERNALSYM gluErrorString}
//function gluErrorUnicodeStringEXT (errCode: GLenum): PWChar; cdecl; {stdcall;}
// { // $EXTERNALSYM gluErrorUnicodeStringEXT}
function gluGetString (name: GLenum): PChar; cdecl; {stdcall;}
  {$EXTERNALSYM gluGetString}

procedure gluLookAt(eyex, eyey, eyez,
                    centerx, centery, centerz,
                    upx, upy, upz: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluLookAt}
procedure gluOrtho2D(left, right, bottom, top: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluOrtho2D}
procedure gluPerspective(fovy, aspect, zNear, zFar: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluPerspective}
procedure gluPickMatrix (x, y, width, height: GLdouble; viewport: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM gluPickMatrix}
function  gluProject (objx, objy, obyz: GLdouble;
                      modelMatrix: PGLdouble;
                      projMatrix: PGLdouble;
                      viewport: PGLint;
                      var winx, winy, winz: GLDouble): Integer; cdecl; {stdcall;}
  {$EXTERNALSYM gluProject}
function  gluUnProject(winx, winy, winz: GLdouble;
                      modelMatrix: PGLdouble;
                      projMatrix: PGLdouble;
                      viewport: PGLint;
                      var objx, objy, objz: GLdouble): Integer; cdecl; {stdcall;}
  {$EXTERNALSYM gluUnProject}
function  gluScaleImage(format: GLenum;
   widthin, heightin: GLint; typein: GLenum; datain: Pointer;
   widthout, heightout: GLint; typeout: GLenum; dataout: Pointer): Integer; cdecl; {stdcall;}
  {$EXTERNALSYM gluScaleImage}

function  gluBuild1DMipmaps (target: GLenum; components, width: GLint;
                             format, atype: GLenum; data: Pointer): Integer; cdecl; {stdcall;}
  {$EXTERNALSYM gluBuild1DMipmaps}
function  gluBuild2DMipmaps (target: GLenum; components, width: GLint;
                             format, atype: GLenum; data: Pointer): Integer; cdecl; {stdcall;}
  {$EXTERNALSYM gluBuild2DMipmaps}

type
  _GLUquadricObj = record end;
  GLUquadricObj = ^_GLUquadricObj;
  {$EXTERNALSYM GLUquadricObj}

  GLUquadricErrorProc = procedure (error: GLenum) cdecl; {stdcall;}
  TGLUquadricErrorProc = GLUquadricErrorProc;
  {$EXTERNALSYM GLUquadricErrorProc}

function  gluNewQuadric: GLUquadricObj; cdecl; {stdcall;}
  {$EXTERNALSYM gluNewQuadric}
procedure gluDeleteQuadric (state: GLUquadricObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluDeleteQuadric}
procedure gluQuadricNormals (quadObject: GLUquadricObj; normals: GLenum);  cdecl; {stdcall;}
  {$EXTERNALSYM gluQuadricNormals}
procedure gluQuadricTexture (quadObject: GLUquadricObj; textureCoords: GLboolean );cdecl; {stdcall;}
  {$EXTERNALSYM gluQuadricTexture}
procedure gluQuadricOrientation (quadObject: GLUquadricObj; orientation: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM gluQuadricOrientation}
procedure gluQuadricDrawStyle (quadObject: GLUquadricObj; drawStyle: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM gluQuadricDrawStyle}
procedure gluCylinder (quadObject: GLUquadricObj;
  baseRadius, topRadius, height: GLdouble; slices, stacks: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM gluCylinder}
procedure gluDisk (quadObject: GLUquadricObj;
  innerRadius, outerRadius: GLdouble; slices, loops: GLint); cdecl; {stdcall;}
  {$EXTERNALSYM gluDisk}
procedure gluPartialDisk (quadObject: GLUquadricObj;
  innerRadius, outerRadius: GLdouble; slices, loops: GLint;
  startAngle, sweepAngle: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluPartialDisk}
procedure gluSphere (quadObject: GLUquadricObj; radius: GLdouble; slices, loops: GLint); cdecl; {stdcall;}
procedure gluQuadricCallback (quadObject: GLUquadricObj; which: GLenum;
  callback: Pointer); cdecl; {stdcall;}
  {$EXTERNALSYM gluSphere}

type
  _GLUtesselator = record end;
  GLUtesselator = ^_GLUtesselator;
  {$EXTERNALSYM GLUtesselator}

  // tesselator callback procedure types
  GLUtessBeginProc = procedure (a: GLenum) cdecl; {stdcall;}
  {$EXTERNALSYM GLUtessBeginProc}
  TGLUtessBeginProc = GLUtessBeginProc;
  GLUtessEdgeFlagProc = procedure (flag: GLboolean) cdecl; {stdcall;}
  {$EXTERNALSYM GLUtessEdgeFlagProc}
  TGLUtessEdgeFlagProc = GLUtessEdgeFlagProc;
  GLUtessVertexProc = procedure (p: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM GLUtessVertexProc}
  TGLUtessVertexProc = GLUtessVertexProc;
  GLUtessEndProc = procedure cdecl; {stdcall;}
  {$EXTERNALSYM GLUtessEndProc}
  TGLUtessEndProc = GLUtessEndProc;
  GLUtessErrorProc = TGLUquadricErrorProc;
  {$EXTERNALSYM GLUtessErrorProc}
  GLUtessCombineProc = procedure (a: PGLdouble; b: Pointer;
                                   c: PGLfloat; var d: Pointer) cdecl; {stdcall;}
  {$EXTERNALSYM GLUtessCombineProc}
  TGLUtessCombineProc = GLUtessCombineProc;

function gluNewTess: GLUtesselator; cdecl; {stdcall;}
  {$EXTERNALSYM gluNewTess}
procedure gluDeleteTess( tess: GLUtesselator ); cdecl; {stdcall;}
  {$EXTERNALSYM gluDeleteTess}
procedure gluTessBeginPolygon( tess: GLUtesselator ); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessBeginPolygon}
procedure gluTessBeginContour( tess: GLUtesselator ); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessBeginContour}
procedure gluTessVertex( tess: GLUtesselator; coords: PGLdouble; data: Pointer ); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessVertex}
procedure gluTessEndContour( tess: GLUtesselator ); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessEndContour}
procedure gluTessEndPolygon( tess: GLUtesselator ); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessEndPolygon}
procedure gluTessProperty( tess: GLUtesselator; which: GLenum; value: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessProperty}
procedure gluTessNormal( tess: GLUtesselator; x,y,z: GLdouble); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessNormal}
procedure gluTessCallback( tess: GLUtesselator; which: GLenum; callback: pointer); cdecl; {stdcall;}
  {$EXTERNALSYM gluTessCallback}

type
  TGLUnurbsObj = record end;
  GLUnurbsObj = ^TGLUnurbsObj;
  {$EXTERNALSYM GLUnurbsObj}

  GLUnurbsErrorProc = GLUquadricErrorProc;
  {$EXTERNALSYM GLUnurbsErrorProc}
  TGLUnurbsErrorProc = GLUnurbsErrorProc;

function gluNewNurbsRenderer: GLUnurbsObj; cdecl; {stdcall;}
  {$EXTERNALSYM gluNewNurbsRenderer}
procedure gluDeleteNurbsRenderer (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluDeleteNurbsRenderer}
procedure gluBeginSurface (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluBeginSurface}
procedure gluBeginCurve (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluBeginCurve}
procedure gluEndCurve (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluEndCurve}
procedure gluEndSurface (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluEndSurface}
procedure gluBeginTrim (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluBeginTrim}
procedure gluEndTrim (nobj: GLUnurbsObj); cdecl; {stdcall;}
  {$EXTERNALSYM gluEndTrim}
procedure gluPwlCurve (nobj: GLUnurbsObj; count: GLint; points: PGLfloat;
  stride: GLint; _type: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM gluPwlCurve}
procedure gluNurbsCurve (nobj: GLUnurbsObj; nknots: GLint; knot: PGLfloat;
  stride: GLint; ctlpts: PGLfloat; order: GLint; _type: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM gluNurbsCurve}
procedure gluNurbsSurface (nobj: GLUnurbsObj;
  sknot_count: GLint; sknot: PGLfloat;
  tknot_count: GLint; tknot: PGLfloat;
  s_stride, t_stride: GLint;
  ctlpts: PGLfloat; sorder, torder: GLint; _type: GLenum); cdecl; {stdcall;}
  {$EXTERNALSYM gluNurbsSurface}
procedure gluLoadSamplingMatrices (nobj: GLUnurbsObj;
  modelMatrix: PGLdouble; projMatrix: PGLdouble; viewport: PGLint); cdecl; {stdcall;}
  {$EXTERNALSYM gluLoadSamplingMatrices}
procedure gluNurbsProperty (nobj: GLUnurbsObj; prop: GLenum; value: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM gluNurbsProperty}
procedure gluGetNurbsProperty (nobj: GLUnurbsObj; prop: GLenum; var value: GLfloat); cdecl; {stdcall;}
  {$EXTERNALSYM gluGetNurbsProperty}
procedure gluNurbsCallback (nobj: GLUnurbsObj; which: GLenum; callback: pointer); cdecl; {stdcall;}
  {$EXTERNALSYM gluNurbsCallback}

{****           Generic constants               ****}
const
  GLU_VERSION_1_1  =               1;
  {$EXTERNALSYM GLU_VERSION_1_1}

{ Errors: (return value 0 = no error) }
  GLU_INVALID_ENUM       = 100900;
  {$EXTERNALSYM GLU_INVALID_ENUM}
  GLU_INVALID_VALUE      = 100901;
  {$EXTERNALSYM GLU_INVALID_VALUE}
  GLU_OUT_OF_MEMORY      = 100902;
  {$EXTERNALSYM GLU_OUT_OF_MEMORY}
  GLU_INCOMPATIBLE_GL_VERSION  =   100903;
  {$EXTERNALSYM GLU_INCOMPATIBLE_GL_VERSION}

{ gets }
  GLU_VERSION            = 100800;
  {$EXTERNALSYM GLU_VERSION}
  GLU_EXTENSIONS         = 100801;
  {$EXTERNALSYM GLU_EXTENSIONS}

{ For laughs: }
  GLU_TRUE               = GL_TRUE;
  {$EXTERNALSYM GLU_TRUE}
  GLU_FALSE              = GL_FALSE;
  {$EXTERNALSYM GLU_FALSE}

{***           Quadric constants               ***}

{ Types of normals: }
  GLU_SMOOTH             = 100000;
  {$EXTERNALSYM GLU_SMOOTH}
  GLU_FLAT               = 100001;
  {$EXTERNALSYM GLU_FLAT}
  GLU_NONE               = 100002;
  {$EXTERNALSYM GLU_NONE}

{ DrawStyle types: }
  GLU_POINT              = 100010;
  {$EXTERNALSYM GLU_POINT}
  GLU_LINE               = 100011;
  {$EXTERNALSYM GLU_LINE}
  GLU_FILL               = 100012;
  {$EXTERNALSYM GLU_FILL}
  GLU_SILHOUETTE         = 100013;
  {$EXTERNALSYM GLU_SILHOUETTE}

{ Orientation types: }
  GLU_OUTSIDE            = 100020;
  {$EXTERNALSYM GLU_OUTSIDE}
  GLU_INSIDE             = 100021;
  {$EXTERNALSYM GLU_INSIDE}

{ Callback types: }
{      GLU_ERROR               100103 }


{***           Tesselation constants           ***}

  GLU_TESS_MAX_COORD     =         1.0e150;
  {$EXTERNALSYM GLU_TESS_MAX_COORD}

{ Property types: }
  GLU_TESS_WINDING_RULE  =         100110;
  {$EXTERNALSYM GLU_TESS_WINDING_RULE}
  GLU_TESS_BOUNDARY_ONLY =         100111;
  {$EXTERNALSYM GLU_TESS_BOUNDARY_ONLY}
  GLU_TESS_TOLERANCE     =         100112;
  {$EXTERNALSYM GLU_TESS_TOLERANCE}

{ Possible winding rules: }
  GLU_TESS_WINDING_ODD          =  100130;
  {$EXTERNALSYM GLU_TESS_WINDING_ODD}
  GLU_TESS_WINDING_NONZERO      =  100131;
  {$EXTERNALSYM GLU_TESS_WINDING_NONZERO}
  GLU_TESS_WINDING_POSITIVE     =  100132;
  {$EXTERNALSYM GLU_TESS_WINDING_POSITIVE}
  GLU_TESS_WINDING_NEGATIVE     =  100133;
  {$EXTERNALSYM GLU_TESS_WINDING_NEGATIVE}
  GLU_TESS_WINDING_ABS_GEQ_TWO  =  100134;
  {$EXTERNALSYM GLU_TESS_WINDING_ABS_GEQ_TWO}

{ Callback types: }
  GLU_TESS_BEGIN     = 100100 ;     { void (*)(GLenum    type)         }
  {$EXTERNALSYM GLU_TESS_BEGIN}
  GLU_TESS_VERTEX    = 100101 ;     { void (*)(void      *data)        }
  {$EXTERNALSYM GLU_TESS_VERTEX}
  GLU_TESS_END       = 100102 ;     { void (*)(void)                   }
  {$EXTERNALSYM GLU_TESS_END}
  GLU_TESS_ERROR     = 100103 ;     { void (*)(GLenum    errno)        }
  {$EXTERNALSYM GLU_TESS_ERROR}
  GLU_TESS_EDGE_FLAG = 100104 ;     { void (*)(GLboolean boundaryEdge) }
  {$EXTERNALSYM GLU_TESS_EDGE_FLAG}
  GLU_TESS_COMBINE   = 100105 ;     { void (*)(GLdouble  coords[3],;
                                                    void      *data[4],;
                                                    GLfloat   weight[4],;
                                                    void      **dataOut)    }
  {$EXTERNALSYM GLU_TESS_COMBINE}

{ Errors: }
  GLU_TESS_ERROR1    = 100151;
  {$EXTERNALSYM GLU_TESS_ERROR1}
  GLU_TESS_ERROR2    = 100152;
  {$EXTERNALSYM GLU_TESS_ERROR2}
  GLU_TESS_ERROR3    = 100153;
  {$EXTERNALSYM GLU_TESS_ERROR3}
  GLU_TESS_ERROR4    = 100154;
  {$EXTERNALSYM GLU_TESS_ERROR4}
  GLU_TESS_ERROR5    = 100155;
  {$EXTERNALSYM GLU_TESS_ERROR5}
  GLU_TESS_ERROR6    = 100156;
  {$EXTERNALSYM GLU_TESS_ERROR6}
  GLU_TESS_ERROR7    = 100157;
  {$EXTERNALSYM GLU_TESS_ERROR7}
  GLU_TESS_ERROR8    = 100158;
  {$EXTERNALSYM GLU_TESS_ERROR8}

  GLU_TESS_MISSING_BEGIN_POLYGON  = GLU_TESS_ERROR1;
  {$EXTERNALSYM GLU_TESS_MISSING_BEGIN_POLYGON}
  GLU_TESS_MISSING_BEGIN_CONTOUR  = GLU_TESS_ERROR2;
  {$EXTERNALSYM GLU_TESS_MISSING_BEGIN_CONTOUR}
  GLU_TESS_MISSING_END_POLYGON    = GLU_TESS_ERROR3;
  {$EXTERNALSYM GLU_TESS_MISSING_END_POLYGON}
  GLU_TESS_MISSING_END_CONTOUR    = GLU_TESS_ERROR4;
  {$EXTERNALSYM GLU_TESS_MISSING_END_CONTOUR}
  GLU_TESS_COORD_TOO_LARGE        = GLU_TESS_ERROR5;
  {$EXTERNALSYM GLU_TESS_COORD_TOO_LARGE}
  GLU_TESS_NEED_COMBINE_CALLBACK  = GLU_TESS_ERROR6;
  {$EXTERNALSYM GLU_TESS_NEED_COMBINE_CALLBACK}

{***           NURBS constants                 ***}

{ Properties: }
  GLU_AUTO_LOAD_MATRIX          =  100200;
  {$EXTERNALSYM GLU_AUTO_LOAD_MATRIX}
  GLU_CULLING                   =  100201;
  {$EXTERNALSYM GLU_CULLING}
  GLU_SAMPLING_TOLERANCE        =  100203;
  {$EXTERNALSYM GLU_SAMPLING_TOLERANCE}
  GLU_DISPLAY_MODE              =  100204;
  {$EXTERNALSYM GLU_DISPLAY_MODE}
  GLU_PARAMETRIC_TOLERANCE      =  100202;
  {$EXTERNALSYM GLU_PARAMETRIC_TOLERANCE}
  GLU_SAMPLING_METHOD           =  100205;
  {$EXTERNALSYM GLU_SAMPLING_METHOD}
  GLU_U_STEP                    =  100206;
  {$EXTERNALSYM GLU_U_STEP}
  GLU_V_STEP                    =  100207;
  {$EXTERNALSYM GLU_V_STEP}

{ Sampling methods: }
  GLU_PATH_LENGTH               =  100215;
  {$EXTERNALSYM GLU_PATH_LENGTH}
  GLU_PARAMETRIC_ERROR          =  100216;
  {$EXTERNALSYM GLU_PARAMETRIC_ERROR}
  GLU_DOMAIN_DISTANCE           =  100217;
  {$EXTERNALSYM GLU_DOMAIN_DISTANCE}

{ Trimming curve types }
  GLU_MAP1_TRIM_2       =  100210;
  {$EXTERNALSYM GLU_MAP1_TRIM_2}
  GLU_MAP1_TRIM_3       =  100211;
  {$EXTERNALSYM GLU_MAP1_TRIM_3}

{ Display modes: }
{      GLU_FILL                100012 }
  GLU_OUTLINE_POLYGON    = 100240;
  {$EXTERNALSYM GLU_OUTLINE_POLYGON}
  GLU_OUTLINE_PATCH      = 100241;
  {$EXTERNALSYM GLU_OUTLINE_PATCH}

{ Callbacks: }
{      GLU_ERROR               100103 }

{ Errors: }
  GLU_NURBS_ERROR1       = 100251;
  {$EXTERNALSYM GLU_NURBS_ERROR1}
  GLU_NURBS_ERROR2       = 100252;
  {$EXTERNALSYM GLU_NURBS_ERROR2}
  GLU_NURBS_ERROR3       = 100253;
  {$EXTERNALSYM GLU_NURBS_ERROR3}
  GLU_NURBS_ERROR4       = 100254;
  {$EXTERNALSYM GLU_NURBS_ERROR4}
  GLU_NURBS_ERROR5       = 100255;
  {$EXTERNALSYM GLU_NURBS_ERROR5}
  GLU_NURBS_ERROR6       = 100256;
  {$EXTERNALSYM GLU_NURBS_ERROR6}
  GLU_NURBS_ERROR7       = 100257;
  {$EXTERNALSYM GLU_NURBS_ERROR7}
  GLU_NURBS_ERROR8       = 100258;
  {$EXTERNALSYM GLU_NURBS_ERROR8}
  GLU_NURBS_ERROR9       = 100259;
  {$EXTERNALSYM GLU_NURBS_ERROR9}
  GLU_NURBS_ERROR10      = 100260;
  {$EXTERNALSYM GLU_NURBS_ERROR10}
  GLU_NURBS_ERROR11      = 100261;
  {$EXTERNALSYM GLU_NURBS_ERROR11}
  GLU_NURBS_ERROR12      = 100262;
  {$EXTERNALSYM GLU_NURBS_ERROR12}
  GLU_NURBS_ERROR13      = 100263;
  {$EXTERNALSYM GLU_NURBS_ERROR13}
  GLU_NURBS_ERROR14      = 100264;
  {$EXTERNALSYM GLU_NURBS_ERROR14}
  GLU_NURBS_ERROR15      = 100265;
  {$EXTERNALSYM GLU_NURBS_ERROR15}
  GLU_NURBS_ERROR16      = 100266;
  {$EXTERNALSYM GLU_NURBS_ERROR16}
  GLU_NURBS_ERROR17      = 100267;
  {$EXTERNALSYM GLU_NURBS_ERROR17}
  GLU_NURBS_ERROR18      = 100268;
  {$EXTERNALSYM GLU_NURBS_ERROR18}
  GLU_NURBS_ERROR19      = 100269;
  {$EXTERNALSYM GLU_NURBS_ERROR19}
  GLU_NURBS_ERROR20      = 100270;
  {$EXTERNALSYM GLU_NURBS_ERROR20}
  GLU_NURBS_ERROR21      = 100271;
  {$EXTERNALSYM GLU_NURBS_ERROR21}
  GLU_NURBS_ERROR22      = 100272;
  {$EXTERNALSYM GLU_NURBS_ERROR22}
  GLU_NURBS_ERROR23      = 100273;
  {$EXTERNALSYM GLU_NURBS_ERROR23}
  GLU_NURBS_ERROR24      = 100274;
  {$EXTERNALSYM GLU_NURBS_ERROR24}
  GLU_NURBS_ERROR25      = 100275;
  {$EXTERNALSYM GLU_NURBS_ERROR25}
  GLU_NURBS_ERROR26      = 100276;
  {$EXTERNALSYM GLU_NURBS_ERROR26}
  GLU_NURBS_ERROR27      = 100277;
  {$EXTERNALSYM GLU_NURBS_ERROR27}
  GLU_NURBS_ERROR28      = 100278;
  {$EXTERNALSYM GLU_NURBS_ERROR28}
  GLU_NURBS_ERROR29      = 100279;
  {$EXTERNALSYM GLU_NURBS_ERROR29}
  GLU_NURBS_ERROR30      = 100280;
  {$EXTERNALSYM GLU_NURBS_ERROR30}
  GLU_NURBS_ERROR31      = 100281;
  {$EXTERNALSYM GLU_NURBS_ERROR31}
  GLU_NURBS_ERROR32      = 100282;
  {$EXTERNALSYM GLU_NURBS_ERROR32}
  GLU_NURBS_ERROR33      = 100283;
  {$EXTERNALSYM GLU_NURBS_ERROR33}
  GLU_NURBS_ERROR34      = 100284;
  {$EXTERNALSYM GLU_NURBS_ERROR34}
  GLU_NURBS_ERROR35      = 100285;
  {$EXTERNALSYM GLU_NURBS_ERROR35}
  GLU_NURBS_ERROR36      = 100286;
  {$EXTERNALSYM GLU_NURBS_ERROR36}
  GLU_NURBS_ERROR37      = 100287;
  {$EXTERNALSYM GLU_NURBS_ERROR37}

{
/****           Backwards compatibility for old tesselator           ****/

typedef GLUtesselator GLUtriangulatorObj;

procedure   gluBeginPolygon( tess: GLUtesselator );

procedure   gluNextContour(  tess: GLUtesselator,
                                 GLenum        type );

procedure   gluEndPolygon(   tess: GLUtesselator );

/* Contours types -- obsolete! */
#define GLU_CW          100120
#define GLU_CCW         100121
#define GLU_INTERIOR    100122
#define GLU_EXTERIOR    100123
#define GLU_UNKNOWN     100124

/* Names without "TESS_" prefix */
#define GLU_BEGIN       GLU_TESS_BEGIN
#define GLU_VERTEX      GLU_TESS_VERTEX
#define GLU_END         GLU_TESS_END
#define GLU_ERROR       GLU_TESS_ERROR
#define GLU_EDGE_FLAG   GLU_TESS_EDGE_FLAG
}

{ glx support routines for OpenGL ==========================================}
  function glXChooseVisual (dpy: PDisplay; screen: Integer; var attribList: Integer) : PXVisualInfo; cdecl;
  function glXCreateContext (dpy: PDisplay; vis: PXVisualInfo; shareList: GLXContext; direct: Boolean) : GLXContext; cdecl;
  procedure glXDestroyContext (dpy: PDisplay; ctx : GLXContext); cdecl;
  function glXMakeCurrent (dpy: PDisplay; drawable: GLXDrawable; ctx: GLXContext) : Boolean; cdecl;
  procedure glXCopyContext (dpy: PDisplay; src, dst: GLXContext; mask : LongWord); cdecl;
  procedure glXSwapBuffers (dpy: PDisplay; drawable : GLXDrawable); cdecl;
  function glXCreateGLXPixmap (dpy: PDisplay; visual: PXVisualInfo; pixmap: XPixmap) : GLXPixmap; cdecl;
  procedure glXDestroyGLXPixmap (dpy: PDisplay; pixmap : GLXPixmap); cdecl;
  function glXQueryExtension (dpy: PDisplay; var errorb, event: Integer) : Boolean; cdecl;
  function glXQueryVersion (dpy: PDisplay; var maj, min: Integer) : Boolean; cdecl;
  function glXIsDirect (dpy: PDisplay; ctx: GLXContext) : Boolean; cdecl;
  function glXGetConfig (dpy: PDisplay; visual: PXVisualInfo; attrib: Integer; var value: Integer) : Integer; cdecl;
  function glXGetCurrentContext  : GLXContext; cdecl;
  function glXGetCurrentDrawable  : GLXDrawable; cdecl;
  procedure glXWaitGL ; cdecl;
  procedure glXWaitX ; cdecl;
  procedure glXUseXFont (font: XFont; first, count, list : Integer); cdecl;

  // GLX 1.1 and later
  function glXQueryExtensionsString (dpy: PDisplay; screen: Integer) : PChar; cdecl;
  function glXQueryServerString (dpy: PDisplay; screen, name: Integer) : PChar; cdecl;
  function glXGetClientString (dpy: PDisplay; name: Integer) : PChar; cdecl;

  // Mesa GLX Extensions
//  function glXCreateGLXPixmapMESA (dpy: PDisplay; visual: PXVisualInfo; pixmap: XPixmap; cmap: XColormap) : GLXPixmap; cdecl;
//  function glXReleaseBufferMESA (dpy: PDisplay; d: GLXDrawable) : Boolean; cdecl;
//  procedure glXCopySubBufferMESA (dpy: PDisplay; drawbale: GLXDrawable; x, y, width, height : Integer); cdecl;
//  function glXGetVideoSyncSGI (var counter: LongWord) : Integer; cdecl;



const
  glu32 = 'libGLU.so'; //'glu32.dll';
  libglx = 'libGL.so';
implementation

procedure glAccum; external 'libGL.so';
procedure glAlphaFunc; external 'libGL.so';
procedure glBegin; external 'libGL.so';
procedure glBitmap; external 'libGL.so';
procedure glBlendFunc; external 'libGL.so';
procedure glCallList; external 'libGL.so';
procedure glCallLists; external 'libGL.so';
procedure glClear; external 'libGL.so';
procedure glClearAccum; external 'libGL.so';
procedure glClearColor; external 'libGL.so';
procedure glClearDepth; external 'libGL.so';
procedure glClearIndex; external 'libGL.so';
procedure glClearStencil; external 'libGL.so';
procedure glClipPlane; external 'libGL.so';
procedure glColor3b; external 'libGL.so';
procedure glColor3bv; external 'libGL.so';
procedure glColor3d; external 'libGL.so';
procedure glColor3dv; external 'libGL.so';
procedure glColor3f; external 'libGL.so';
procedure glColor3fv; external 'libGL.so';
procedure glColor3i; external 'libGL.so';
procedure glColor3iv; external 'libGL.so';
procedure glColor3s; external 'libGL.so';
procedure glColor3sv; external 'libGL.so';
procedure glColor3ub; external 'libGL.so';
procedure glColor3ubv; external 'libGL.so';
procedure glColor3ui; external 'libGL.so';
procedure glColor3uiv; external 'libGL.so';
procedure glColor3us; external 'libGL.so';
procedure glColor3usv; external 'libGL.so';
procedure glColor4b; external 'libGL.so';
procedure glColor4bv; external 'libGL.so';
procedure glColor4d; external 'libGL.so';
procedure glColor4dv; external 'libGL.so';
procedure glColor4f; external 'libGL.so';
procedure glColor4fv; external 'libGL.so';
procedure glColor4i; external 'libGL.so';
procedure glColor4iv; external 'libGL.so';
procedure glColor4s; external 'libGL.so';
procedure glColor4sv; external 'libGL.so';
procedure glColor4ub; external 'libGL.so';
procedure glColor4ubv; external 'libGL.so';
procedure glColor4ui; external 'libGL.so';
procedure glColor4uiv; external 'libGL.so';
procedure glColor4us; external 'libGL.so';
procedure glColor4usv; external 'libGL.so';
procedure glColor(red, green, blue: GLbyte); external 'libGL.so' name 'glColor3b';
procedure glColor(red, green, blue: GLdouble); external 'libGL.so' name 'glColor3d';
procedure glColor(red, green, blue: GLfloat); external 'libGL.so' name 'glColor3f';
procedure glColor(red, green, blue: GLint); external 'libGL.so' name 'glColor3i';
procedure glColor(red, green, blue: GLshort); external 'libGL.so' name 'glColor3s';
procedure glColor(red, green, blue: GLubyte); external 'libGL.so' name 'glColor3ub';
procedure glColor(red, green, blue: GLuint); external 'libGL.so' name 'glColor3ui';
procedure glColor(red, green, blue: GLushort); external 'libGL.so' name 'glColor3us';
procedure glColor(red, green, blue, alpha: GLbyte); external 'libGL.so' name 'glColor4b';
procedure glColor(red, green, blue, alpha: GLdouble); external 'libGL.so' name 'glColor4d';
procedure glColor(red, green, blue, alpha: GLfloat); external 'libGL.so' name 'glColor4f';
procedure glColor(red, green, blue, alpha: GLint); external 'libGL.so' name 'glColor4i';
procedure glColor(red, green, blue, alpha: GLshort); external 'libGL.so' name 'glColor4s';
procedure glColor(red, green, blue, alpha: GLubyte); external 'libGL.so' name 'glColor4ub';
procedure glColor(red, green, blue, alpha: GLuint); external 'libGL.so' name 'glColor4ui';
procedure glColor(red, green, blue, alpha: GLushort); external 'libGL.so' name 'glColor4us';
procedure glColor3(v: PGLbyte); external 'libGL.so' name 'glColor3bv';
procedure glColor3(v: PGLdouble); external 'libGL.so' name 'glColor3dv';
procedure glColor3(v: PGLfloat); external 'libGL.so' name 'glColor3fv';
procedure glColor3(v: PGLint); external 'libGL.so' name 'glColor3iv';
procedure glColor3(v: PGLshort); external 'libGL.so' name 'glColor3sv';
procedure glColor3(v: PGLubyte); external 'libGL.so' name 'glColor3ubv';
procedure glColor3(v: PGLuint); external 'libGL.so' name 'glColor3uiv';
procedure glColor3(v: PGLushort); external 'libGL.so' name 'glColor3usv';
procedure glColor4(v: PGLbyte); external 'libGL.so' name 'glColor4bv';
procedure glColor4(v: PGLdouble); external 'libGL.so' name 'glColor4dv';
procedure glColor4(v: PGLfloat); external 'libGL.so' name 'glColor4fv';
procedure glColor4(v: PGLint); external 'libGL.so' name 'glColor4iv';
procedure glColor4(v: PGLshort); external 'libGL.so' name 'glColor4sv';
procedure glColor4(v: PGLubyte); external 'libGL.so' name 'glColor4ubv';
procedure glColor4(v: PGLuint); external 'libGL.so' name 'glColor4uiv';
procedure glColor4(v: PGLushort); external 'libGL.so' name 'glColor4usv';
procedure glColorMask; external 'libGL.so';
procedure glColorMaterial; external 'libGL.so';
procedure glCopyPixels; external 'libGL.so';
procedure glCullFace; external 'libGL.so';
procedure glDeleteLists; external 'libGL.so';
procedure glDepthFunc; external 'libGL.so';
procedure glDepthMask; external 'libGL.so';
procedure glDepthRange; external 'libGL.so';
procedure glDisable; external 'libGL.so';
procedure glDrawBuffer; external 'libGL.so';
procedure glDrawPixels; external 'libGL.so';
procedure glEdgeFlag; external 'libGL.so';
procedure glEdgeFlagv; external 'libGL.so';
procedure glEnable; external 'libGL.so';
procedure glEnd; external 'libGL.so';
procedure glEndList; external 'libGL.so';
procedure glEvalCoord1d; external 'libGL.so';
procedure glEvalCoord1dv; external 'libGL.so';
procedure glEvalCoord1f; external 'libGL.so';
procedure glEvalCoord1fv; external 'libGL.so';
procedure glEvalCoord2d; external 'libGL.so';
procedure glEvalCoord2dv; external 'libGL.so';
procedure glEvalCoord2f; external 'libGL.so';
procedure glEvalCoord2fv; external 'libGL.so';
procedure glEvalCoord(u: GLdouble); external 'libGL.so' name 'glEvalCoord1d';
procedure glEvalCoord(u: GLfloat); external 'libGL.so' name 'glEvalCoord1f';
procedure glEvalCoord(u,v: GLdouble); external 'libGL.so' name 'glEvalCoord2d';
procedure glEvalCoord(u,v: GLfloat); external 'libGL.so' name 'glEvalCoord2f';
procedure glEvalCoord1(v: PGLdouble); external 'libGL.so' name 'glEvalCoord1dv';
procedure glEvalCoord1(v: PGLfloat); external 'libGL.so' name 'glEvalCoord1fv';
procedure glEvalCoord2(v: PGLdouble); external 'libGL.so' name 'glEvalCoord2dv';
procedure glEvalCoord2(v: PGLfloat); external 'libGL.so' name 'glEvalCoord2fv';
procedure glEvalMesh1; external 'libGL.so';
procedure glEvalMesh2; external 'libGL.so';
procedure glEvalMesh(mode: GLenum; i1, i2: GLint); external 'libGL.so' name 'glEvalMesh1';
procedure glEvalMesh(mode: GLenum; i1, i2, j1, j2: GLint); external 'libGL.so' name 'glEvalMesh2';
procedure glEvalPoint1; external 'libGL.so';
procedure glEvalPoint2; external 'libGL.so';
procedure glEvalPoint(i: GLint); external 'libGL.so' name 'glEvalPoint1';
procedure glEvalPoint(i,j: GLint); external 'libGL.so' name 'glEvalPoint2';
procedure glFeedbackBuffer; external 'libGL.so';
procedure glFinish; external 'libGL.so';
procedure glFlush; external 'libGL.so';
procedure glFogf; external 'libGL.so';
procedure glFogfv; external 'libGL.so';
procedure glFogi; external 'libGL.so';
procedure glFogiv; external 'libGL.so';
procedure glFog(pname: GLenum; param: GLfloat); external 'libGL.so' name 'glFogf';
procedure glFog(pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glFogfv';
procedure glFog(pname: GLenum; param: GLint); external 'libGL.so' name 'glFogi';
procedure glFog(pname: GLenum; params: PGLint); external 'libGL.so' name 'glFogiv';
procedure glFrontFace; external 'libGL.so';
procedure glFrustum; external 'libGL.so';
function  glGenLists; external 'libGL.so';
procedure glGetBooleanv; external 'libGL.so';
procedure glGetClipPlane; external 'libGL.so';
procedure glGetDoublev; external 'libGL.so';
function  glGetError: GLenum; external 'libGL.so';
procedure glGetFloatv; external 'libGL.so';
procedure glGetIntegerv; external 'libGL.so';
procedure glGetLightfv; external 'libGL.so';
procedure glGetLightiv; external 'libGL.so';
procedure glGetLight(light: GLenum; pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetLightfv';
procedure glGetLight(light: GLenum; pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetLightiv';
procedure glGetMapdv; external 'libGL.so';
procedure glGetMapfv; external 'libGL.so';
procedure glGetMapiv; external 'libGL.so';
procedure glGetMap(target: GLenum; query: GLenum; v: PGLdouble); external 'libGL.so' name 'glGetMapdv';
procedure glGetMap(target: GLenum; query: GLenum; v: PGLfloat); external 'libGL.so' name 'glGetMapfv';
procedure glGetMap(target: GLenum; query: GLenum; v: PGLint); external 'libGL.so' name 'glGetMapiv';
procedure glGetMaterialfv; external 'libGL.so';
procedure glGetMaterialiv; external 'libGL.so';
procedure glGetMaterial(face: GLenum; pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetMaterialfv';
procedure glGetMaterial(face: GLenum; pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetMaterialiv';
procedure glGetPixelMapfv; external 'libGL.so';
procedure glGetPixelMapuiv; external 'libGL.so';
procedure glGetPixelMapusv; external 'libGL.so';
procedure glGetPixelMap(map: GLenum; values: PGLfloat); external 'libGL.so' name 'glGetPixelMapfv';
procedure glGetPixelMap(map: GLenum; values: PGLuint); external 'libGL.so' name 'glGetPixelMapuiv';
procedure glGetPixelMap(map: GLenum; values: PGLushort); external 'libGL.so' name 'glGetPixelMapusv';
procedure glGetPolygonStipple; external 'libGL.so';
function  glGetString; external 'libGL.so';
procedure glGetTexEnvfv; external 'libGL.so';
procedure glGetTexEnviv; external 'libGL.so';
procedure glGetTexEnv(target: GLenum; pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetTexEnvfv';
procedure glGetTexEnv(target: GLenum; pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetTexEnviv';
procedure glGetTexGendv; external 'libGL.so';
procedure glGetTexGenfv; external 'libGL.so';
procedure glGetTexGeniv; external 'libGL.so';
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLdouble); external 'libGL.so' name 'glGetTexGendv';
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetTexGenfv';
procedure glGetTexGen(coord: GLenum; pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetTexGeniv';
procedure glGetTexImage; external 'libGL.so';
procedure glGetTexLevelParameterfv; external 'libGL.so';
procedure glGetTexLevelParameteriv; external 'libGL.so';
procedure glGetTexLevelParameter(target: GLenum; level: GLint; pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetTexLevelParameterfv';
procedure glGetTexLevelParameter(target: GLenum; level: GLint; pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetTexLevelParameteriv';
procedure glGetTexParameterfv; external 'libGL.so';
procedure glGetTexParameteriv; external 'libGL.so';
procedure glGetTexParameter(target, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glGetTexParameterfv';
procedure glGetTexParameter(target, pname: GLenum; params: PGLint); external 'libGL.so' name 'glGetTexParameteriv';
procedure glHint; external 'libGL.so';
procedure glIndexMask; external 'libGL.so';
procedure glIndexd; external 'libGL.so';
procedure glIndexdv; external 'libGL.so';
procedure glIndexf; external 'libGL.so';
procedure glIndexfv; external 'libGL.so';
procedure glIndexi; external 'libGL.so';
procedure glIndexiv; external 'libGL.so';
procedure glIndexs; external 'libGL.so';
procedure glIndexsv; external 'libGL.so';
procedure glIndex(c: GLdouble); external 'libGL.so' name 'glIndexd';
procedure glIndex(c: PGLdouble); external 'libGL.so' name 'glIndexdv';
procedure glIndex(c: GLfloat); external 'libGL.so' name 'glIndexf';
procedure glIndex(c: PGLfloat); external 'libGL.so' name 'glIndexfv';
procedure glIndex(c: GLint); external 'libGL.so' name 'glIndexi';
procedure glIndex(c: PGLint); external 'libGL.so' name 'glIndexiv';
procedure glIndex(c: GLshort); external 'libGL.so' name 'glIndexs';
procedure glIndex(c: PGLshort); external 'libGL.so' name 'glIndexsv';
procedure glInitNames; external 'libGL.so';
function  glIsEnabled; external 'libGL.so';
function  glIsList; external 'libGL.so';
procedure glLightModelf; external 'libGL.so';
procedure glLightModelfv; external 'libGL.so';
procedure glLightModeli; external 'libGL.so';
procedure glLightModeliv; external 'libGL.so';
procedure glLightModel(pname: GLenum; param: GLfloat); external 'libGL.so' name 'glLightModelf';
procedure glLightModel(pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glLightModelfv';
procedure glLightModel(pname: GLenum; param: GLint); external 'libGL.so' name 'glLightModeli';
procedure glLightModel(pname: GLenum; params: PGLint); external 'libGL.so' name 'glLightModeliv';
procedure glLightf; external 'libGL.so';
procedure glLightfv; external 'libGL.so';
procedure glLighti; external 'libGL.so';
procedure glLightiv; external 'libGL.so';
procedure glLight(light, pname: GLenum; param: GLfloat); external 'libGL.so' name 'glLightf';
procedure glLight(light, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glLightfv';
procedure glLight(light, pname: GLenum; param: GLint); external 'libGL.so' name 'glLighti';
procedure glLight(light, pname: GLenum; params: PGLint); external 'libGL.so' name 'glLightiv';
procedure glLineStipple; external 'libGL.so';
procedure glLineWidth; external 'libGL.so';
procedure glListBase; external 'libGL.so';
procedure glLoadIdentity; external 'libGL.so';
procedure glLoadMatrixd; external 'libGL.so';
procedure glLoadMatrixf; external 'libGL.so';
procedure glLoadMatrix(m: PGLdouble); external 'libGL.so' name 'glLoadMatrixd';
procedure glLoadMatrix(m: PGLfloat); external 'libGL.so' name 'glLoadMatrixf';
procedure glLoadName; external 'libGL.so';
procedure glLogicOp; external 'libGL.so';
procedure glMap1d; external 'libGL.so';
procedure glMap1f; external 'libGL.so';
procedure glMap2d; external 'libGL.so';
procedure glMap2f; external 'libGL.so';
procedure glMap(target: GLenum; u1,u2: GLdouble; stride, order: GLint;
  Points: PGLdouble); external 'libGL.so' name 'glMap1d';
procedure glMap(target: GLenum; u1,u2: GLfloat; stride, order: GLint;
  Points: PGLfloat); external 'libGL.so' name 'glMap1f';
procedure glMap(target: GLenum;
  u1,u2: GLdouble; ustride, uorder: GLint;
  v1,v2: GLdouble; vstride, vorder: GLint; Points: PGLdouble); external 'libGL.so' name 'glMap2d';
procedure glMap(target: GLenum;
  u1,u2: GLfloat; ustride, uorder: GLint;
  v1,v2: GLfloat; vstride, vorder: GLint; Points: PGLfloat); external 'libGL.so' name 'glMap2f';
procedure glMapGrid1d; external 'libGL.so';
procedure glMapGrid1f; external 'libGL.so';
procedure glMapGrid2d; external 'libGL.so';
procedure glMapGrid2f; external 'libGL.so';
procedure glMapGrid(un: GLint; u1, u2: GLdouble); external 'libGL.so' name 'glMapGrid1d';
procedure glMapGrid(un: GLint; u1, u2: GLfloat); external 'libGL.so' name 'glMapGrid1f';
procedure glMapGrid(un: GLint; u1, u2: GLdouble;
                    vn: GLint; v1, v2: GLdouble); external 'libGL.so' name 'glMapGrid2d';
procedure glMapGrid(un: GLint; u1, u2: GLfloat;
                    vn: GLint; v1, v2: GLfloat); external 'libGL.so' name 'glMapGrid2f';
procedure glMaterialf; external 'libGL.so';
procedure glMaterialfv; external 'libGL.so';
procedure glMateriali; external 'libGL.so';
procedure glMaterialiv; external 'libGL.so';
procedure glMaterial(face, pname: GLenum; param: GLfloat); external 'libGL.so' name 'glMaterialf';
procedure glMaterial(face, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glMaterialfv';
procedure glMaterial(face, pname: GLenum; param: GLint); external 'libGL.so' name 'glMateriali';
procedure glMaterial(face, pname: GLenum; params: PGLint); external 'libGL.so' name 'glMaterialiv';
procedure glMatrixMode; external 'libGL.so';
procedure glMultMatrixd; external 'libGL.so';
procedure glMultMatrixf; external 'libGL.so';
procedure glMultMatrix(m: PGLdouble); external 'libGL.so' name 'glMultMatrixd';
procedure glMultMatrix(m: PGLfloat); external 'libGL.so' name 'glMultMatrixf';
procedure glNewList; external 'libGL.so';
procedure glNormal3b; external 'libGL.so';
procedure glNormal3bv; external 'libGL.so';
procedure glNormal3d; external 'libGL.so';
procedure glNormal3dv; external 'libGL.so';
procedure glNormal3f; external 'libGL.so';
procedure glNormal3fv; external 'libGL.so';
procedure glNormal3i; external 'libGL.so';
procedure glNormal3iv; external 'libGL.so';
procedure glNormal3s; external 'libGL.so';
procedure glNormal3sv; external 'libGL.so';
procedure glNormal(nx, ny, nz: GLbyte); external 'libGL.so' name 'glNormal3b';
procedure glNormal3(v: PGLbyte); external 'libGL.so' name 'glNormal3bv';
procedure glNormal(nx, ny, nz: GLdouble); external 'libGL.so' name 'glNormal3d';
procedure glNormal3(v: PGLdouble); external 'libGL.so' name 'glNormal3dv';
procedure glNormal(nx, ny, nz: GLFloat); external 'libGL.so' name 'glNormal3f';
procedure glNormal3(v: PGLfloat); external 'libGL.so' name 'glNormal3fv';
procedure glNormal(nx, ny, nz: GLint); external 'libGL.so' name 'glNormal3i';
procedure glNormal3(v: PGLint); external 'libGL.so' name 'glNormal3iv';
procedure glNormal(nx, ny, nz: GLshort); external 'libGL.so' name 'glNormal3s';
procedure glNormal3(v: PGLshort); external 'libGL.so' name 'glNormal3sv';
procedure glOrtho; external 'libGL.so';
procedure glPassThrough; external 'libGL.so';
procedure glPixelMapfv; external 'libGL.so';
procedure glPixelMapuiv; external 'libGL.so';
procedure glPixelMapusv; external 'libGL.so';
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLfloat); external 'libGL.so' name 'glPixelMapfv';
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLuint); external 'libGL.so' name 'glPixelMapuiv';
procedure glPixelMap(map: GLenum; mapsize: GLint; values: PGLushort); external 'libGL.so' name 'glPixelMapusv';
procedure glPixelStoref; external 'libGL.so';
procedure glPixelStorei; external 'libGL.so';
procedure glPixelStore(pname: GLenum; param: GLfloat); external 'libGL.so' name 'glPixelStoref';
procedure glPixelStore(pname: GLenum; param: GLint); external 'libGL.so' name 'glPixelStorei';
procedure glPixelTransferf; external 'libGL.so';
procedure glPixelTransferi; external 'libGL.so';
procedure glPixelTransfer(pname: GLenum; param: GLfloat); external 'libGL.so' name 'glPixelTransferf';
procedure glPixelTransfer(pname: GLenum; param: GLint); external 'libGL.so' name 'glPixelTransferi';
procedure glPixelZoom; external 'libGL.so';
procedure glPointSize; external 'libGL.so';
procedure glPolygonMode; external 'libGL.so';
procedure glPolygonStipple; external 'libGL.so';
procedure glPopAttrib; external 'libGL.so';
procedure glPopMatrix; external 'libGL.so';
procedure glPopName; external 'libGL.so';
procedure glPushAttrib; external 'libGL.so';
procedure glPushMatrix; external 'libGL.so';
procedure glPushName; external 'libGL.so';
procedure glRasterPos2d; external 'libGL.so';
procedure glRasterPos2dv; external 'libGL.so';
procedure glRasterPos2f; external 'libGL.so';
procedure glRasterPos2fv; external 'libGL.so';
procedure glRasterPos2i; external 'libGL.so';
procedure glRasterPos2iv; external 'libGL.so';
procedure glRasterPos2s; external 'libGL.so';
procedure glRasterPos2sv; external 'libGL.so';
procedure glRasterPos3d; external 'libGL.so';
procedure glRasterPos3dv; external 'libGL.so';
procedure glRasterPos3f; external 'libGL.so';
procedure glRasterPos3fv; external 'libGL.so';
procedure glRasterPos3i; external 'libGL.so';
procedure glRasterPos3iv; external 'libGL.so';
procedure glRasterPos3s; external 'libGL.so';
procedure glRasterPos3sv; external 'libGL.so';
procedure glRasterPos4d; external 'libGL.so';
procedure glRasterPos4dv; external 'libGL.so';
procedure glRasterPos4f; external 'libGL.so';
procedure glRasterPos4fv; external 'libGL.so';
procedure glRasterPos4i; external 'libGL.so';
procedure glRasterPos4iv; external 'libGL.so';
procedure glRasterPos4s; external 'libGL.so';
procedure glRasterPos4sv; external 'libGL.so';
procedure glRasterPos(x,y: GLdouble); external 'libGL.so' name 'glRasterPos2d';
procedure glRasterPos2(v: PGLdouble); external 'libGL.so' name 'glRasterPos2dv';
procedure glRasterPos(x,y: GLfloat); external 'libGL.so' name 'glRasterPos2f';
procedure glRasterPos2(v: PGLfloat); external 'libGL.so' name 'glRasterPos2fv';
procedure glRasterPos(x,y: GLint); external 'libGL.so' name 'glRasterPos2i';
procedure glRasterPos2(v: PGLint); external 'libGL.so' name 'glRasterPos2iv';
procedure glRasterPos(x,y: GLshort); external 'libGL.so' name 'glRasterPos2s';
procedure glRasterPos2(v: PGLshort); external 'libGL.so' name 'glRasterPos2sv';
procedure glRasterPos(x,y,z: GLdouble); external 'libGL.so' name 'glRasterPos3d';
procedure glRasterPos3(v: PGLdouble); external 'libGL.so' name 'glRasterPos3dv';
procedure glRasterPos(x,y,z: GLfloat); external 'libGL.so' name 'glRasterPos3f';
procedure glRasterPos3(v: PGLfloat); external 'libGL.so' name 'glRasterPos3fv';
procedure glRasterPos(x,y,z: GLint); external 'libGL.so' name 'glRasterPos3i';
procedure glRasterPos3(v: PGLint); external 'libGL.so' name 'glRasterPos3iv';
procedure glRasterPos(x,y,z: GLshort); external 'libGL.so' name 'glRasterPos3s';
procedure glRasterPos3(v: PGLshort); external 'libGL.so' name 'glRasterPos3sv';
procedure glRasterPos(x,y,z,w: GLdouble); external 'libGL.so' name 'glRasterPos4d';
procedure glRasterPos4(v: PGLdouble); external 'libGL.so' name 'glRasterPos4dv';
procedure glRasterPos(x,y,z,w: GLfloat); external 'libGL.so' name 'glRasterPos4f';
procedure glRasterPos4(v: PGLfloat); external 'libGL.so' name 'glRasterPos4fv';
procedure glRasterPos(x,y,z,w: GLint); external 'libGL.so' name 'glRasterPos4i';
procedure glRasterPos4(v: PGLint); external 'libGL.so' name 'glRasterPos4iv';
procedure glRasterPos(x,y,z,w: GLshort); external 'libGL.so' name 'glRasterPos4s';
procedure glRasterPos4(v: PGLshort); external 'libGL.so' name 'glRasterPos4sv';
procedure glReadBuffer; external 'libGL.so';
procedure glReadPixels; external 'libGL.so';
procedure glRectd; external 'libGL.so';
procedure glRectdv; external 'libGL.so';
procedure glRectf; external 'libGL.so';
procedure glRectfv; external 'libGL.so';
procedure glRecti; external 'libGL.so';
procedure glRectiv; external 'libGL.so';
procedure glRects; external 'libGL.so';
procedure glRectsv; external 'libGL.so';
procedure glRect(x1, y1, x2, y2: GLdouble); external 'libGL.so' name 'glRectd';
procedure glRect(v1, v2: PGLdouble); external 'libGL.so' name 'glRectdv';
procedure glRect(x1, y1, x2, y2: GLfloat); external 'libGL.so' name 'glRectf';
procedure glRect(v1, v2: PGLfloat); external 'libGL.so' name 'glRectfv';
procedure glRect(x1, y1, x2, y2: GLint); external 'libGL.so' name 'glRecti';
procedure glRect(v1, v2: PGLint); external 'libGL.so' name 'glRectiv';
procedure glRect(x1, y1, x2, y2: GLshort); external 'libGL.so' name 'glRects';
procedure glRect(v1, v2: PGLshort); external 'libGL.so' name 'glRectsv';
function  glRenderMode; external 'libGL.so';
procedure glRotated; external 'libGL.so';
procedure glRotatef; external 'libGL.so';
procedure glRotate(angle, x,y,z: GLdouble); external 'libGL.so' name 'glRotated';
procedure glRotate(angle, x,y,z: GLfloat); external 'libGL.so' name 'glRotatef';
procedure glScaled; external 'libGL.so';
procedure glScalef; external 'libGL.so';
procedure glScale(x,y,z: GLdouble); external 'libGL.so' name 'glScaled';
procedure glScale(x,y,z: GLfloat); external 'libGL.so' name 'glScalef';
procedure glScissor; external 'libGL.so';
procedure glSelectBuffer; external 'libGL.so';
procedure glShadeModel; external 'libGL.so';
procedure glStencilFunc; external 'libGL.so';
procedure glStencilMask; external 'libGL.so';
procedure glStencilOp; external 'libGL.so';
procedure glTexCoord1d; external 'libGL.so';
procedure glTexCoord1dv; external 'libGL.so';
procedure glTexCoord1f; external 'libGL.so';
procedure glTexCoord1fv; external 'libGL.so';
procedure glTexCoord1i; external 'libGL.so';
procedure glTexCoord1iv; external 'libGL.so';
procedure glTexCoord1s; external 'libGL.so';
procedure glTexCoord1sv; external 'libGL.so';
procedure glTexCoord2d; external 'libGL.so';
procedure glTexCoord2dv; external 'libGL.so';
procedure glTexCoord2f; external 'libGL.so';
procedure glTexCoord2fv; external 'libGL.so';
procedure glTexCoord2i; external 'libGL.so';
procedure glTexCoord2iv; external 'libGL.so';
procedure glTexCoord2s; external 'libGL.so';
procedure glTexCoord2sv; external 'libGL.so';
procedure glTexCoord3d; external 'libGL.so';
procedure glTexCoord3dv; external 'libGL.so';
procedure glTexCoord3f; external 'libGL.so';
procedure glTexCoord3fv; external 'libGL.so';
procedure glTexCoord3i; external 'libGL.so';
procedure glTexCoord3iv; external 'libGL.so';
procedure glTexCoord3s; external 'libGL.so';
procedure glTexCoord3sv; external 'libGL.so';
procedure glTexCoord4d; external 'libGL.so';
procedure glTexCoord4dv; external 'libGL.so';
procedure glTexCoord4f; external 'libGL.so';
procedure glTexCoord4fv; external 'libGL.so';
procedure glTexCoord4i; external 'libGL.so';
procedure glTexCoord4iv; external 'libGL.so';
procedure glTexCoord4s; external 'libGL.so';
procedure glTexCoord4sv; external 'libGL.so';
procedure glTexCoord(s: GLdouble); external 'libGL.so' name 'glTexCoord1d';
procedure glTexCoord1(v: PGLdouble); external 'libGL.so' name 'glTexCoord1dv';
procedure glTexCoord(s: GLfloat); external 'libGL.so' name 'glTexCoord1f';
procedure glTexCoord1(v: PGLfloat); external 'libGL.so' name 'glTexCoord1fv';
procedure glTexCoord(s: GLint); external 'libGL.so' name 'glTexCoord1i';
procedure glTexCoord1(v: PGLint); external 'libGL.so' name 'glTexCoord1iv';
procedure glTexCoord(s: GLshort); external 'libGL.so' name 'glTexCoord1s';
procedure glTexCoord1(v: PGLshort); external 'libGL.so' name 'glTexCoord1sv';
procedure glTexCoord(s,t: GLdouble); external 'libGL.so' name 'glTexCoord2d';
procedure glTexCoord2(v: PGLdouble); external 'libGL.so' name 'glTexCoord2dv';
procedure glTexCoord(s,t: GLfloat); external 'libGL.so' name 'glTexCoord2f';
procedure glTexCoord2(v: PGLfloat); external 'libGL.so' name 'glTexCoord2fv';
procedure glTexCoord(s,t: GLint); external 'libGL.so' name 'glTexCoord2i';
procedure glTexCoord2(v: PGLint); external 'libGL.so' name 'glTexCoord2iv';
procedure glTexCoord(s,t: GLshort); external 'libGL.so' name 'glTexCoord2s';
procedure glTexCoord2(v: PGLshort); external 'libGL.so' name 'glTexCoord2sv';
procedure glTexCoord(s,t,r: GLdouble); external 'libGL.so' name 'glTexCoord3d';
procedure glTexCoord3(v: PGLdouble); external 'libGL.so' name 'glTexCoord3dv';
procedure glTexCoord(s,t,r: GLfloat); external 'libGL.so' name 'glTexCoord3f';
procedure glTexCoord3(v: PGLfloat); external 'libGL.so' name 'glTexCoord3fv';
procedure glTexCoord(s,t,r: GLint); external 'libGL.so' name 'glTexCoord3i';
procedure glTexCoord3(v: PGLint); external 'libGL.so' name 'glTexCoord3iv';
procedure glTexCoord(s,t,r: GLshort); external 'libGL.so' name 'glTexCoord3s';
procedure glTexCoord3(v: PGLshort); external 'libGL.so' name 'glTexCoord3sv';
procedure glTexCoord(s,t,r,q: GLdouble); external 'libGL.so' name 'glTexCoord4d';
procedure glTexCoord4(v: PGLdouble); external 'libGL.so' name 'glTexCoord4dv';
procedure glTexCoord(s,t,r,q: GLfloat); external 'libGL.so' name 'glTexCoord4f';
procedure glTexCoord4(v: PGLfloat); external 'libGL.so' name 'glTexCoord4fv';
procedure glTexCoord(s,t,r,q: GLint); external 'libGL.so' name 'glTexCoord4i';
procedure glTexCoord4(v: PGLint); external 'libGL.so' name 'glTexCoord4iv';
procedure glTexCoord(s,t,r,q: GLshort); external 'libGL.so' name 'glTexCoord4s';
procedure glTexCoord4(v: PGLshort); external 'libGL.so' name 'glTexCoord4sv';
procedure glTexEnvf; external 'libGL.so';
procedure glTexEnvfv; external 'libGL.so';
procedure glTexEnvi; external 'libGL.so';
procedure glTexEnviv; external 'libGL.so';
procedure glTexEnv(target, pname: GLenum; param: GLfloat); external 'libGL.so' name 'glTexEnvf';
procedure glTexEnv(target, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glTexEnvfv';
procedure glTexEnv(target, pname: GLenum; param: GLint); external 'libGL.so' name 'glTexEnvi';
procedure glTexEnv(target, pname: GLenum; params: PGLint); external 'libGL.so' name 'glTexEnviv';
procedure glTexGend; external 'libGL.so';
procedure glTexGendv; external 'libGL.so';
procedure glTexGenf; external 'libGL.so';
procedure glTexGenfv; external 'libGL.so';
procedure glTexGeni; external 'libGL.so';
procedure glTexGeniv; external 'libGL.so';
procedure glTexGen(coord, pname: GLenum; param: GLdouble); external 'libGL.so' name 'glTexGend';
procedure glTexGen(coord, pname: GLenum; params: PGLdouble); external 'libGL.so' name 'glTexGendv';
procedure glTexGen(coord, pname: GLenum; param: GLfloat); external 'libGL.so' name 'glTexGenf';
procedure glTexGen(coord, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glTexGenfv';
procedure glTexGen(coord, pname: GLenum; param: GLint); external 'libGL.so' name 'glTexGeni';
procedure glTexGen(coord, pname: GLenum; params: PGLint); external 'libGL.so' name 'glTexGeniv';
procedure glTexImage1D; external 'libGL.so';
procedure glTexImage2D; external 'libGL.so';
procedure glTexParameterf; external 'libGL.so';
procedure glTexParameterfv; external 'libGL.so';
procedure glTexParameteri; external 'libGL.so';
procedure glTexParameteriv; external 'libGL.so';
procedure glTexParameter(target, pname: GLenum; param: GLfloat); external 'libGL.so' name 'glTexParameterf';
procedure glTexParameter(target, pname: GLenum; params: PGLfloat); external 'libGL.so' name 'glTexParameterfv';
procedure glTexParameter(target, pname: GLenum; param: GLint); external 'libGL.so' name 'glTexParameteri';
procedure glTexParameter(target, pname: GLenum; params: PGLint); external 'libGL.so' name 'glTexParameteriv';
procedure glTranslated; external 'libGL.so';
procedure glTranslatef; external 'libGL.so';
procedure glTranslate(x,y,z: GLdouble); external 'libGL.so' name 'glTranslated';
procedure glTranslate(x,y,z: GLfloat); external 'libGL.so' name 'glTranslatef';
procedure glVertex2d; external 'libGL.so';
procedure glVertex2dv; external 'libGL.so';
procedure glVertex2f; external 'libGL.so';
procedure glVertex2fv; external 'libGL.so';
procedure glVertex2i; external 'libGL.so';
procedure glVertex2iv; external 'libGL.so';
procedure glVertex2s; external 'libGL.so';
procedure glVertex2sv; external 'libGL.so';
procedure glVertex3d; external 'libGL.so';
procedure glVertex3dv; external 'libGL.so';
procedure glVertex3f; external 'libGL.so';
procedure glVertex3fv; external 'libGL.so';
procedure glVertex3i; external 'libGL.so';
procedure glVertex3iv; external 'libGL.so';
procedure glVertex3s; external 'libGL.so';
procedure glVertex3sv; external 'libGL.so';
procedure glVertex4d; external 'libGL.so';
procedure glVertex4dv; external 'libGL.so';
procedure glVertex4f; external 'libGL.so';
procedure glVertex4fv; external 'libGL.so';
procedure glVertex4i; external 'libGL.so';
procedure glVertex4iv; external 'libGL.so';
procedure glVertex4s; external 'libGL.so';
procedure glVertex4sv; external 'libGL.so';
procedure glVertex(x,y: GLdouble); external 'libGL.so' name 'glVertex2d';
procedure glVertex2(v: PGLdouble); external 'libGL.so' name 'glVertex2dv';
procedure glVertex(x,y: GLfloat); external 'libGL.so' name 'glVertex2f';
procedure glVertex2(v: PGLfloat); external 'libGL.so' name 'glVertex2fv';
procedure glVertex(x,y: GLint); external 'libGL.so' name 'glVertex2i';
procedure glVertex2(v: PGLint); external 'libGL.so' name 'glVertex2iv';
procedure glVertex(x,y: GLshort); external 'libGL.so' name 'glVertex2s';
procedure glVertex2(v: PGLshort); external 'libGL.so' name 'glVertex2sv';
procedure glVertex(x,y,z: GLdouble); external 'libGL.so' name 'glVertex3d';
procedure glVertex3(v: PGLdouble); external 'libGL.so' name 'glVertex3dv';
procedure glVertex(x,y,z: GLfloat); external 'libGL.so' name 'glVertex3f';
procedure glVertex3(v: PGLfloat); external 'libGL.so' name 'glVertex3fv';
procedure glVertex(x,y,z: GLint); external 'libGL.so' name 'glVertex3i';
procedure glVertex3(v: PGLint); external 'libGL.so' name 'glVertex3iv';
procedure glVertex(x,y,z: GLshort); external 'libGL.so' name 'glVertex3s';
procedure glVertex3(v: PGLshort); external 'libGL.so' name 'glVertex3sv';
procedure glVertex(x,y,z,w: GLdouble); external 'libGL.so' name 'glVertex4d';
procedure glVertex4(v: PGLdouble); external 'libGL.so' name 'glVertex4dv';
procedure glVertex(x,y,z,w: GLfloat); external 'libGL.so' name 'glVertex4f';
procedure glVertex4(v: PGLfloat); external 'libGL.so' name 'glVertex4fv';
procedure glVertex(x,y,z,w: GLint); external 'libGL.so' name 'glVertex4i';
procedure glVertex4(v: PGLint); external 'libGL.so' name 'glVertex4iv';
procedure glVertex(x,y,z,w: GLshort); external 'libGL.so' name 'glVertex4s';
procedure glVertex4(v: PGLshort); external 'libGL.so' name 'glVertex4sv';
procedure glViewport; external 'libGL.so';


{ OpenGL Utility routines (glu.h) =======================================}

function gluErrorString;                     external glu32;
//function gluErrorUnicodeStringEXT;           external glu32;
function gluGetString;                       external glu32;
procedure gluLookAt;                         external glu32;
procedure gluOrtho2D;                        external glu32;
procedure gluPerspective;                    external glu32;
procedure gluPickMatrix;                     external glu32;
function  gluProject;                        external glu32;
function  gluUnProject;                      external glu32;
function  gluScaleImage;                     external glu32;
function  gluBuild1DMipmaps;                 external glu32;
function  gluBuild2DMipmaps;                 external glu32;
function  gluNewQuadric;                     external glu32;
procedure gluDeleteQuadric;                  external glu32;
procedure gluQuadricNormals;                 external glu32;
procedure gluQuadricTexture;                 external glu32;
procedure gluQuadricOrientation;             external glu32;
procedure gluQuadricDrawStyle;               external glu32;
procedure gluCylinder;                       external glu32;
procedure gluDisk;                           external glu32;
procedure gluPartialDisk;                    external glu32;
procedure gluSphere;                         external glu32;
procedure gluQuadricCallback;                external glu32;

function gluNewTess                         ;external glu32;
procedure gluDeleteTess                     ;external glu32;
procedure gluTessBeginPolygon               ;external glu32;
procedure gluTessBeginContour               ;external glu32;
procedure gluTessVertex                     ;external glu32;
procedure gluTessEndContour                 ;external glu32;
procedure gluTessEndPolygon                 ;external glu32;
procedure gluTessProperty                   ;external glu32;
procedure gluTessNormal                     ;external glu32;
procedure gluTessCallback                   ;external glu32;

function gluNewNurbsRenderer                ;external glu32;
procedure gluDeleteNurbsRenderer            ;external glu32;
procedure gluBeginSurface                   ;external glu32;
procedure gluBeginCurve                     ;external glu32;
procedure gluEndCurve                       ;external glu32;
procedure gluEndSurface                     ;external glu32;
procedure gluBeginTrim                      ;external glu32;
procedure gluEndTrim                        ;external glu32;
procedure gluPwlCurve                       ;external glu32;
procedure gluNurbsCurve                     ;external glu32;
procedure gluNurbsSurface                   ;external glu32;
procedure gluLoadSamplingMatrices           ;external glu32;
procedure gluNurbsProperty                  ;external glu32;
procedure gluGetNurbsProperty               ;external glu32;
procedure gluNurbsCallback                  ;external glu32;

//glx

  function glXChooseVisual; external libglx name  'glXChooseVisual';
  function glXCreateContext; external libglx name  'glXCreateContext';
  procedure glXDestroyContext; external libglx name  'glXDestroyContext';
  function glXMakeCurrent; external libglx name  'glXMakeCurrent';
  procedure glXCopyContext; external libglx name  'glXCopyContext';
  procedure glXSwapBuffers; external libglx name  'glXSwapBuffers';
  function glXCreateGLXPixmap; external libglx name  'glXCreateGLXPixmap';
  procedure glXDestroyGLXPixmap; external libglx name  'glXDestroyGLXPixmap';
  function glXQueryExtension; external libglx name  'glXQueryExtension';
  function glXQueryVersion; external libglx name  'glXQueryVersion';
  function glXIsDirect; external libglx name  'glXIsDirect';
  function glXGetConfig; external libglx name  'glXGetConfig';
  function glXGetCurrentContext; external libglx name  'glXGetCurrentContext';
  function glXGetCurrentDrawable; external libglx name  'glXGetCurrentDrawable';
  procedure glXWaitGL; external libglx name  'glXWaitGL';
  procedure glXWaitX; external libglx name  'glXWaitX';
  procedure glXUseXFont; external libglx name  'glXUseXFont';
  // GLX 1.1 and later
  function glXQueryExtensionsString; external libglx name  'glXQueryExtensionsString';
  function glXQueryServerString; external libglx name  'glXQueryServerString';
  function glXGetClientString; external libglx name  'glXGetClientString';
  // Mesa GLX Extensions
//  function glXCreateGLXPixmapMESA; external libglx name  'glXCreateGLXPixmapMESA';
//  function glXReleaseBufferMESA; external libglx name  'glXReleaseBufferMESA';
//  procedure glXCopySubBufferMESA; external libglx name  'glXCopySubBufferMESA';
//  function glXGetVideoSyncSGI; external libglx name  'glXGetVideoSyncSGI';
//  function glXWaitVideoSyncSGI; external libglx name  'glXWaitVideoSyncSGI';

{ useful util function from xutil.h }
function XSetStandardProperties; external 'libX11.so.6' name 'XSetStandardProperties';

begin
  Set8087CW($133F);
end.
