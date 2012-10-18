{******************************************}
{ TeeChart Pro VML Canvas and Exporting    }
{ VML : Vector Markup Language             }
{ Copyright (c) 2001-2004 by David Berneda }
{       All Rights Reserved                }
{******************************************}
unit TeeVMLCanvas;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, Types,
     {$ELSE}
     Graphics, Forms,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeExport;

type
  TVMLCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
    FBackColor   : TColor;
    FBackMode    : TCanvasBackMode;
    FTextAlign   : TCanvasTextAlign;
    FX           : Integer;
    FY           : Integer;
    FStrings     : TStrings;

    // IPenEndStyle : TPenEndStyle;
    IPenStyle    : TPenStyle;
    IPenWidth    : Integer;
    ITransp      : TTeeTransparency;

    Procedure Add(Const S:String);
    procedure ChangedPen(Sender: TObject);
    Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
    Function PointToStr(X,Y:Integer):String;
    Function PrepareShape:String;
    Function TheBounds:String;
  protected
    { Protected declarations }
    Procedure PolygonFour; override;

    { 2d }
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    Function GetTextAlign:TCanvasTextAlign; override;

    { 3d }
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Function GetMonochrome:Boolean; override;
    Procedure SetMonochrome(Value:Boolean); override;
    Procedure SetBackColor(Color:TColor); override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetBackColor:TColor; override;
    procedure SetTextAlign(Align:TCanvasTextAlign); override;

    Function VmlPen(const Element:String):String;
  public
    { Public declarations }
    Constructor Create(AStrings:TStrings);

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;  // 7.0

    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure FillRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure LineTo(X,Y:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Rectangle(X0,Y0,X1,Y1:Integer); reintroduce; override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    Procedure TextOut(X,Y:Integer; const Text:String); override;
    Procedure DoHorizLine(X0,X1,Y:Integer); override;
    Procedure DoVertLine(X,Y0,Y1:Integer); override;

    procedure ClipRectangle(Const Rect:TRect); override;
    procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); override;
    procedure UnClipRectangle; override;

    Procedure GradientFill( Const Rect:TRect;
                            StartColor,EndColor:TColor;
                            Direction:TGradientDirection;
                            Balance:Integer=50); override;
    procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Double); override;
    procedure RotateLabel3D(x,y,z:Integer;
                            Const St:String; RotDegree:Double); override;
    Procedure Line(X0,Y0,X1,Y1:Integer); override;
    Procedure Polygon(const Points: array of TPoint); override;
    Procedure Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF}); override;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
    Procedure HorizLine3D(Left,Right,Y,Z:Integer); override;
    procedure LineTo3D(X,Y,Z:Integer); override;
    Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer); override;
    procedure MoveTo3D(X,Y,Z:Integer); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
    Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
    Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;
  published
  end;

  TVMLExportFormat=class(TTeeExportFormat)
  private
  protected
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function VML:TStringList;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

procedure TeeSaveToVMLFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);

implementation

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, SysUtils;

{ TVMLCanvas }
Constructor TVMLCanvas.Create(AStrings:TStrings);
begin
  inherited Create;
  FStrings:=AStrings;
  UseBuffer:=False;

  { start }
  Add('<xml:namespace prefix="v"/>');
  Add('<style>v\:* {behavior=url(#default#VML)}</style>');
end;

Procedure TVMLCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin { finish }
  Add('</v:group>');
  Pen.OnChange:=nil;
end;

Procedure TVMLCanvas.Add(Const S:String);
begin
  FStrings.Add(S);
end;

Function VMLColorInternal(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);

  case AColor of
    clBlack: result:='black';
    clWhite: result:='white';
    clRed:   result:='red';
    clGreen: result:='green';
    clBlue:  result:='blue';
    clYellow: result:='yellow';
    clGray:  result:='gray';
    clNavy:  result:='navy';
    clOlive: result:='olive';
    clLime:  result:='lime';
    clTeal:  result:='teal';
    clSilver:  result:='silver';
    clPurple:  result:='purple';
    clFuchsia:  result:='fuchsia';
    clMaroon:  result:='maroon';
  else
  begin
    result:='#'+IntToHex(GetRValue(AColor),2)+
                IntToHex(GetGValue(AColor),2)+
                IntToHex(GetBValue(AColor),2);
    if result='#000000' then result:='#0';
  end;
  end;
end;

Function VMLColor(AColor:TColor):String;
begin
  result:='"'+VMLColorInternal(AColor)+'"';
end;

procedure TVMLCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True,False);
end;

procedure TVMLCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TVMLCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  IPenStyle:=APen.Style;
  IPenWidth:=APen.Width;
  Pen.OnChange:=nil;
  inherited;
  Pen.OnChange:=ChangedPen;
end;

Function TVMLCanvas.VmlPen(const Element:String):String;

  Function IsSmallDots:Boolean;
  begin
    result:=(Pen is TChartPen) and TChartPen(Pen).SmallDots;
  end;

  Function PenStyle:String;
  begin
    if IsSmallDots then
       result:='dot'
    else
    Case IPenStyle of
      psSolid: ;
      psDash: result:='dash';
      psDot: result:='dot';
      psDashDot: result:='dashdot';
      psDashDotDot: result:='longdashdotdot';
    end;
  end;

  function PenWidth(const Element:String):String;
  begin
    if IPenWidth>1 then
       result:=' '+Element+'="'+TeeStr(IPenWidth)+'" '
    else
       result:='';
  end;

begin
  result:='" strokecolor='+VMLColor(Pen.Color);

  if (IPenStyle<>psSolid) or IsSmallDots then
     result:=result+'><v:stroke dashstyle="'+PenStyle+'"'+PenWidth('weight')+'/></v:'+Element+'>'
  else
     result:=result+PenWidth('strokeweight')+'/>';
end;

procedure TVMLCanvas.LineTo(X, Y: Integer);
begin
  Add('<v:line from="'+PointToStr(FX,FY)+'" to="'+PointToStr(X,Y)+VmlPen('line'));
  FX:=X;
  FY:=Y;
end;

procedure TVMLCanvas.ClipRectangle(Const Rect:TRect);
begin
end;

procedure TVMLCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
end;

procedure TVMLCanvas.UnClipRectangle;
begin
end;

function TVMLCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TVMLCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TVMLCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TVMLCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Procedure TVMLCanvas.SetMonochrome(Value:Boolean);
begin
end;

procedure TVMLCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
end;

procedure TVMLCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
end;

Function TVMLCanvas.TheBounds:String;
begin
  result:='width:'+IntToStr(Bounds.Right-Bounds.Left)+
          ';height:'+IntToStr(Bounds.Bottom-Bounds.Top);
end;

Function TVMLCanvas.PointToStr(X,Y:Integer):String;
begin
  result:=IntToStr(X)+','+IntToStr(Y);
end;

Procedure TVMLCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50);
var TheAngle : Integer;
begin
  Case Direction of
     gdTopBottom  : TheAngle:=180;
     gdBottomTop  : TheAngle:=0;
     gdLeftRight  : TheAngle:=270;
     gdRightLeft  : TheAngle:=90;
     gdFromCenter : TheAngle:=0; { to-do }
     gdFromTopLeft: TheAngle:=315;
  else
     TheAngle:=225; { gdFromBottomLeft }
  end;

  Add('<v:shape style="position:absolute;'+TheBounds+';" stroked="f">');

  Add(' <v:path v="M '+PointToStr(Rect.Left,Rect.Top)+' L '+
        PointToStr(Rect.Right,Rect.Top)+' '+
        PointToStr(Rect.Right,Rect.Bottom)+' '+
        PointToStr(Rect.Left,Rect.Bottom)+' X E"/>');

  Add(' <v:fill type="gradient" color='+VMLColor(StartColor)+' color2='+VMLColor(EndColor));

  if ITransp<>0 then Add(' opacity="'+FloatToStr((100-ITransp)*0.01)+'"');

  Add(' method="sigma" angle="'+IntToStr(TheAngle)+'" focus="100%"/>');
  Add('</v:shape>');
end;

procedure TVMLCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False,False);
end;

Procedure TVMLCanvas.InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
var tmp  : String;
    tmpElement : String;
    tmpR : TRect;
begin
  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    tmp:='<v:';

    if IsRound then tmpElement:='roundrect'
               else tmpElement:='rect';

    tmp:=tmp+tmpElement;

    tmpR:=OrientRectangle(Rect);

    tmp:=tmp+' style="position:absolute;left:'+
         TeeStr(tmpR.Left)+';top:'+TeeStr(tmpR.Top)+';width:'+
         TeeStr(tmpR.Right-tmpR.Left-1)+';height:'+
         TeeStr(tmpR.Bottom-tmpR.Top-1)+'"';

    if Brush.Style<>bsClear then
       tmp:=tmp+' fillcolor='+VMLColor(Brush.Color)
    else
       tmp:=tmp+' filled="false"';

    if UsePen and (Pen.Style<>psClear) then
       tmp:=tmp+' strokecolor='+VMLColor(Pen.Color)
    else
       tmp:=tmp+' stroked="f"';

    if ITransp<>0 then
       tmp:=tmp+' opacity="'+FloatToStr((100-ITransp)*0.01)+'"';

    Add(tmp+VmlPen(tmpElement));
  end;
end;

procedure TVMLCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
end;

procedure TVMLCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
begin
  Calc3DPos(X1,Y1,Z);
  Calc3DPos(X2,Y2,Z);

  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
     Add('<v:oval style="position:absolute;left:'+IntToStr(X1)+';top:'+IntToStr(Y1)+
         ';height:'+IntToStr(Y2-Y1)+';width:'+IntToStr(X2-X1)+'" fillcolor='+
         VMLColor(Brush.Color)+VmlPen('oval'));
end;

procedure TVMLCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TVMLCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TVMLCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var tmpSt : String;
begin
  if Pen.Style<>psClear then
  begin
    PrepareShape;
    tmpSt:=' <v:path v="ar ';
    tmpSt:=tmpSt+PointToStr(X1,Y1)+' '+PointToStr(X2,Y2)+' '+
      PointToStr(X3,Y3)+' '+PointToStr(X4,Y4);

    Add(tmpSt+' e"/>');
    Add('</v:shape>');
  end;
end;

procedure TVMLCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var tmpSt : String;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape;
    tmpSt:=' <v:path v="m '+PointToStr((X2+X1) div 2,(Y2+Y1) div 2)+' at ';
    tmpSt:=tmpSt+PointToStr(X1,Y1)+' '+PointToStr(X2,Y2)+' '+
      PointToStr(X3,Y3)+' '+PointToStr(X4,Y4);

    Add(tmpSt+' x e"/>');
    Add('</v:shape>');
  end;
end;

procedure TVMLCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,True);
end;

Procedure TVMLCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);

  Function FontStyle:String;
  begin
    if Font.Style=[] then result:=''
    else
    begin
      result:='';

      if fsBold in Font.Style then
         result:=' font-weight=bold;';

      if fsItalic in Font.Style then
         result:=result+' font-style=italic;';

      if fsUnderline in Font.Style then
         result:=result+' text-decoration=underline;';

      if fsStrikeOut in Font.Style then
         result:=result+' text-decoration=line-through;';
    end;
  end;

  Procedure DoText(AX,AY:Integer; AColor:TColor);
  begin
    if (TextAlign and TA_CENTER)=TA_CENTER then
       Dec(AX,TextWidth(Text) div 2)
    else
    if (TextAlign and TA_RIGHT)=TA_RIGHT then
       Dec(AX,TextWidth(Text));

    Inc(AX);
    Inc(AY);

    Add('<v:textbox style="position:absolute; left:'+IntToStr(AX)+'; top:'+IntToStr(AY)+
        '; color:'+VMLColorInternal(AColor)+'; text-align:left; '+
        ' font-family:'+Font.Name+'; font-size:'+TeeStr(Round(Font.Size*1.4))+'; '+FontStyle+'">');

    Add(Text);

    Add('</v:textbox>');
  end;

Var tmpX : Integer;
    tmpY : Integer;
begin
  Calc3DPos(x,y,z);

  if Assigned(IFont) then
  With IFont.Shadow do
  if (HorizSize<>0) or (VertSize<>0) then
  begin
    if HorizSize<0 then
    begin
      tmpX:=X;
      X:=X-HorizSize;
    end
    else tmpX:=X+HorizSize;

    if VertSize<0 then
    begin
      tmpY:=Y;
      Y:=Y-VertSize;
    end
    else tmpY:=Y+VertSize;

    DoText(tmpX,tmpY,IFont.Shadow.Color)
  end;

  DoText(X,Y,IFont.Color);
end;

Procedure TVMLCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(x,y,0,Text);
end;

procedure TVMLCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  MoveTo(x,y);
end;

procedure TVMLCanvas.LineTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  LineTo(x,y);
end;

Function TVMLCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

Procedure TVMLCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  MoveTo(X0,Y);
  LineTo(X1,Y);
end;

Procedure TVMLCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  MoveTo(X,Y0);
  LineTo(X,Y1);
end;

procedure TVMLCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
//TODO: RotDegree rotation
  Calc3DPos(x,y,z);
  TextOut(X,Y,St);
end;

procedure TVMLCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Procedure TVMLCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
end;

Procedure TVMLCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
begin
  MoveTo3D(Left,Y,Z);
  LineTo3D(Right,Y,Z);
end;

Procedure TVMLCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
begin
  MoveTo3D(X,Top,Z);
  LineTo3D(X,Bottom,Z);
end;

Procedure TVMLCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
begin
  MoveTo3D(X,Y,Z0);
  LineTo3D(X,Y,Z1);
end;

Procedure TVMLCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  MoveTo3D(X0,Y0,Z);
  LineTo3D(X1,Y1,Z);
end;

Function TVMLCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TVMLCanvas.PolygonFour;
begin
  Polygon(IPoints);
end;

Function TVMLCanvas.PrepareShape:String;
begin
  result:='<v:shape style="position:absolute;'+TheBounds+'"';
  if Brush.Style<>bsClear then
     result:=result+' fillcolor='+VMLColor(Brush.Color)
  else
     result:=result+' filled="f"';

  if Pen.Style=psClear then
     result:=result+' stroked="f"'
  else
     result:=result+' strokecolor='+VMLColor(Pen.Color);

  Add(result+'>');
end;

Procedure TVMLCanvas.Polygon(const Points: Array of TPoint);
var tmpSt : String;
    t     : Integer;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape;
    tmpSt:=' <v:path v="m '+PointToStr(Points[0].X,Points[0].Y)+' l ';
    for t:=1 to High(Points) do
       tmpSt:=tmpSt+PointToStr(Points[t].X,Points[t].Y)+' ';

    Add(tmpSt+' x e"/>');
    Add('</v:shape>');
  end;
end;

Procedure TVMLCanvas.Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
var tmpSt : String;
    t     : Integer;
begin
  if Pen.Style<>psClear then
  begin
    PrepareShape;
    tmpSt:=' <v:path v="m '+PointToStr(Points[0].X,Points[0].Y)+' l ';
    for t:=1 to High(Points) do
       tmpSt:=tmpSt+PointToStr(Points[t].X,Points[t].Y)+' ';

    Add(tmpSt+' e"/>');
    Add('</v:shape>');
  end;
end;

function TVMLCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);
  Add('<v:group style="'+TheBounds+
       '" coordsize="'+
       PointToStr(Bounds.Right-Bounds.Left,Bounds.Bottom-Bounds.Top)+'"'+
       ' coordorigin="'+PointToStr(Bounds.Top,Bounds.Left)+
       '">');

  Pen.OnChange:=ChangedPen;
end;

procedure TVMLCanvas.ChangedPen(Sender: TObject);
begin
  IPenStyle:=Pen.Style;
  IPenWidth:=Pen.Width;
end;

procedure TVMLCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

function TVMLCanvas.BeginBlending(const R: TRect;
  Transparency: TTeeTransparency): TTeeBlend;
begin
  ITransp:=Transparency;
  result:=nil;
end;

procedure TVMLCanvas.EndBlending(Blend: TTeeBlend);
begin  // reset to zero
  ITransp:=0;
end;

{ TVMLExportFormat }
function TVMLExportFormat.Description: String;
begin
  result:=TeeMsg_AsVML;
end;

procedure TVMLExportFormat.DoCopyToClipboard;
begin
  with VML do
  try
    Clipboard.AsText:=Text;
  finally
    Free;
  end;
end;

function TVMLExportFormat.FileExtension: String;
begin
  result:='HTM';
end;

function TVMLExportFormat.FileFilter: String;
begin
  result:=TeeMsg_VMLFilter;
end;

function TVMLExportFormat.Options(Check:Boolean=True): TForm;
begin
  result:=nil;
end;

procedure TVMLExportFormat.SaveToStream(Stream: TStream);
begin
  with VML do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

type TTeePanelAccess=class(TCustomTeePanel);

// Returns a panel or chart in VML format into a StringList
function TVMLExportFormat.VML: TStringList;
var tmp : TCanvas3D;
begin 
  CheckSize;
  result:=TStringList.Create;
  Panel.AutoRepaint:=False;

  try
    {$IFNDEF CLR} // Protected across assemblies
    tmp:=TTeePanelAccess(Panel).InternalCanvas;
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    {$ENDIF}

    Panel.Canvas:=TVMLCanvas.Create(result);
    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
      { insert html headings at top }
      result.Insert(0,'<!-- Generated by TeeChart Pro Version '+TeeChartVersion+' -->');
      result.Insert(0,'<body>');
      result.Insert(0,'<html>');

      { add html headings at bottom }
      result.Add('</body>');
      result.Add('</html>');
    finally
      {$IFNDEF CLR} // Protected across assemblies
      Panel.Canvas:=tmp;
      {$ENDIF}
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToVMLFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);
begin { save panel or chart to filename in VML (html) format }
  with TVMLExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

initialization
  RegisterTeeExportFormat(TVMLExportFormat);
finalization
  UnRegisterTeeExportFormat(TVMLExportFormat);
end.

