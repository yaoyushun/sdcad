{********************************************}
{ TeeChart Pro PS Canvas and Exporting       }
{ Copyright (c) 2002-2004 by Marjan Slatinek }
{ and David Berneda                          }
{ All Rights Reserved                        }
{********************************************}
unit TeePSCanvas;
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
     TeCanvas, TeeProcs, TeeExport, Math;

type
  TEPSCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
    tmpStr: String;
    FStrings     : TStrings;
    FBackColor : TColor;
    FBackMode : TCanvasBackMode;
    FTextAlign : TCanvasTextAlign;
    IWidth, IHeight: Integer;
    FX, FY: Integer;

    Procedure Add(Const S:String);
    Function BrushProperties(Brush: TBrush): String;
    Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
    Procedure InternalArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; Pie: Boolean);
    Function PenProperties(Pen: TPen): String;
    Function PointToStr(X,Y:Integer):String;
    Function SetPenStyle(PenStyle: TPenStyle): String;
    Function TextToPSText(AText:String): String;
    Function TheBounds:String;
    Procedure TranslateVertCoord(var Y: Integer);
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
  public
    { Public declarations }
    Constructor Create(AStrings:TStrings);

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure FillRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
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
  end;

  TEPSExportFormat=class(TTeeExportFormat)
  private
  protected
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function EPSList:TStringList;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;


procedure TeeSaveToPSFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);




implementation

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, SysUtils;

{ Convert , to . }
procedure FixSeparator(var St: String);
begin
  while Pos(',', St) > 0 do
    St[Pos(',', St)] := '.';
end;

procedure StringToPSString(var St: String);
begin

end;

Function PSColor(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);
  Result:= FormatFloat('0.00',GetRVAlue(AColor)/255) + ' ' +
           FormatFloat('0.00',GetGVAlue(AColor)/255) + ' ' +
           FormatFloat('0.00',GetBVAlue(AColor)/255) + ' rgb';
  FixSeparator(Result);
end;

{ TPSCanvas }
Constructor TEPSCanvas.Create(AStrings:TStrings);
begin
  inherited Create;
  FBackMode := cbmTransparent;
  FStrings:=AStrings;
  UseBuffer:=False;
end;

Procedure TEPSCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  Add('gr');
end;

Procedure TEPSCanvas.Add(Const S:String);
begin
  FStrings.Add(S);
end;


procedure TEPSCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True,False);
end;

procedure TEPSCanvas.MoveTo(X, Y: Integer);
begin
  FX := X;
  FY := Y;
end;

procedure TEPSCanvas.LineTo(X, Y: Integer);
begin
  tmpStr := 'gs ' + PenProperties(Pen) + ' ' +
            PointToStr(FX,FY)+' m '+
            PointToStr(X,Y)+' l st gr ';
  Add(tmpStr);
  FX := X;
  FY := Y;
end;

procedure TEPSCanvas.ClipRectangle(Const Rect:TRect);
var tmpB: Integer;
begin
  tmpB := Rect.Bottom;
  TranslateVertCoord(tmpB);
  tmpStr :='clipsave ' +
            IntToStr(Rect.Left) + ' ' + IntToStr(tmpB) + ' ' +
            IntToStr(Rect.Right - Rect.Left) + ' ' +
            IntToStr(Rect.Bottom - Rect.Top) + ' rectclip';
  Add(tmpStr);
end;

procedure TEPSCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
  { Not implemented }
end;

procedure TEPSCanvas.UnClipRectangle;
begin
  Add('cliprestore');
end;

function TEPSCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TEPSCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TEPSCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TEPSCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Procedure TEPSCanvas.SetMonochrome(Value:Boolean);
begin
  { Not implemented }
end;

procedure TEPSCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  { Not implemented }
end;

procedure TEPSCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  { Not implemented }
end;

Function TEPSCanvas.TheBounds:String;
begin
  IWidth := Bounds.Right - Bounds.Left;
  IHeight := Bounds.Bottom - Bounds.Top;
  Result:='%%BoundingBox: 0 0 ' + IntToStr(IWidth) + ' ' + IntToStr(IHeight);
end;

Function TEPSCanvas.PointToStr(X,Y:Integer):String;
begin
  TranslateVertCoord(Y);
  result:=IntToStr(X)+' '+IntToStr(Y);
end;

Procedure TEPSCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50);
begin
  { Not implemented }
end;

procedure TEPSCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False,False);
end;

Procedure TEPSCanvas.InternalRect(Const Rect:TRect; UsePen, IsRound:Boolean);
var tmpB: Integer;
begin

  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    tmpB := Rect.Bottom;
    TranslateVertCoord(tmpB);

    if Brush.Style<>bsClear then
    begin
      tmpStr := 'gs '+ PsColor(Brush.Color);
      tmpStr := tmpStr + ' ' +IntToStr(Rect.Left) + ' ' + IntToStr(tmpB) + ' ' +
                IntToStr(Rect.Right - Rect.Left) + ' ' + IntToStr(Rect.Bottom - Rect.Top) + ' rectfill gr';
      Add(tmpStr);
    end;

    if UsePen and (Pen.Style<>psClear) then
    begin
      tmpStr := 'gs '+ PenProperties(Pen);
      tmpStr := tmpStr + ' ' + IntToStr(Rect.Left) + ' ' + IntToStr(tmpB) + ' ' +
                IntToStr(Rect.Right - Rect.Left) + ' ' + IntToStr(Rect.Bottom - Rect.Top) + ' rectstroke gr';
      Add(tmpStr);
    end;
  end;
end;

procedure TEPSCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
end;

procedure TEPSCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
var CenterX, CenterY: Integer;
    Ra,Rb: String;

    procedure DrawEllipse;
    begin
      Add(IntToStr(CenterX) + ' '+IntToStr(CenterY) + ' ' +
          Ra + ' ' + Rb + ' 0 360 ellipse') ;
    end;

begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    Calc3DPos(X1,Y1,Z);
    Calc3DPos(X2,Y2,Z);
    CenterX := (X1 + X2) div 2;
    CenterY := (Y1 + Y2) div 2;
    TranslateVertCoord(CenterY);
    { radius }
    Ra := FormatFloat('0.00',(X2-X1)*0.5);
    FixSeparator(Ra);
    Rb := FormatFloat('0.00',(Y2-Y1)*0.5);
    FixSeparator(Rb);
    if (Brush.Style<>bsClear) then
    begin
      Add('gs ' + BrushProperties(Brush));
      DrawEllipse;
      Add('fi gr');
    end;

    if (Pen.Style<>psClear) then
    begin
      Add('gs ' + PenProperties(Pen));
      DrawEllipse;
      Add('st gr');
    end;
  end;
end;

procedure TEPSCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TEPSCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TEPSCanvas.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  InternalArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, False);
end;

procedure TEPSCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  InternalArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, True);
end;

procedure TEPSCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,True);
end;

Procedure TEPSCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);

  Function FontSize:String;
  begin
    result:=IntToStr(Font.Size);
  end;

  Procedure DoText(AX,AY:Integer);
  begin
    Inc(AY,TextHeight(Text) div 2);
    tmpStr := PsColor(Font.Color) +
              ' /' + Font.Name + ' findfont ' + FontSize + ' scalefont setfont';
    Add(tmpStr);
    Add(PointToStR(AX,AY) + ' m');
    if (TextAlign and TA_CENTER)=TA_CENTER then
      Add('(' + TextToPSText(Text) + ') ctext')
    else if (TextAlign and TA_RIGHT)=TA_RIGHT then
      Add('(' + TextToPSText(Text) + ') rtext')
    else Add('(' + TextToPSText(Text) + ') ltext')

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

    DoText(tmpX,tmpY)
  end;

  DoText(X,Y);
end;

Procedure TEPSCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(x,y,0,Text);
end;

procedure TEPSCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  MoveTo(x,y);
end;

procedure TEPSCanvas.LineTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  LineTo(x,y);
end;

Function TEPSCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

Procedure TEPSCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  MoveTo(X0,Y);
  LineTo(X1,Y);
end;

Procedure TEPSCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  MoveTo(X,Y0);
  LineTo(X,Y1);
end;

procedure TEPSCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
  Calc3DPos(x,y,z);
  Add('gs '+PointToStr(x,y) + ' tr ' + IntToStr(Round(RotDegree))+ ' rot');
  TextOut(0,Self.Bounds.Bottom,St);
  Add('gr');
end;

procedure TEPSCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Procedure TEPSCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  MoveTo(X0,Y0);
  LineTo(X1,Y1);
end;

Procedure TEPSCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
begin
  MoveTo3D(Left,Y,Z);
  LineTo3D(Right,Y,Z);
end;

Procedure TEPSCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
begin
  MoveTo3D(X,Top,Z);
  LineTo3D(X,Bottom,Z);
end;

Procedure TEPSCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
begin
  MoveTo3D(X,Y,Z0);
  LineTo3D(X,Y,Z1);
end;

Procedure TEPSCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  MoveTo3D(X0,Y0,Z);
  LineTo3D(X1,Y1,Z);
end;

Function TEPSCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TEPSCanvas.PolygonFour;
begin
  Polygon(IPoints);
end;

Procedure TEPSCanvas.Polygon(const Points: Array of TPoint);

  Procedure AddPoly;
  var t     : Integer;
  begin
    Add('np '+ PointToStr(Points[0].X,Points[0].Y)+' m');
    for t:=1 to High(Points) do
      Add(PointToStr(Points[t].X,Points[t].Y)+' l');
    Add('cp');
  end;

begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    if (Brush.Style<>bsClear) then
    begin
      Add('gs ' +BrushProperties(Brush));
      AddPoly;
      Add('fi gr');
    end;

    if (Pen.Style<>psClear) then
    begin
      tmpStr :='gs '+ PenProperties(Pen);
      Add(tmpStr);
      AddPoly;
      Add('st gr');
    end;
  end;
end;

function TEPSCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);
  Add('%!PS-Adobe-3.0 EPSF-3.0');
  Add(TheBounds); { bounding box }
  Add('%%Creator: '+TeeMsg_Version);
  Add('%%LanguageLevel: 1');
  Add('%%EndComments');
  Add('/bd{bind def} bind def /ld{load def}bd /ed{exch def}bd /xd{cvx def}bd');
  Add('/np/newpath ld /cp/closepath ld /m/moveto ld /l/lineto ld /rm/rmoveto ld'
      + '/rl/rlineto ld');
  Add('/rot/rotate ld /sc/scale ld /tr/translate ld');
  Add('/cpt/currentpoint ld');
  Add('/sw/setlinewidth ld /sd/setdash ld /rgb/setrgbcolor ld');
  Add('/gs/gsave ld /gr/grestore ld');
  Add('/st/stroke ld /fi/fill ld /s/show ld');
  Add('/ltext{cpt st m s}def ');
  Add('/rtext{cpt st m dup stringwidth pop neg 0 rm s} def');
  Add('/ctext{cpt st m dup stringwidth pop -2 div 0 rm s} def');
  Add('/ellipsedict 8 dict def');
  Add('ellipsedict /mtrx matrix put');
  Add('/ellipse');
  Add('{ ellipsedict begin');
  Add('  np');
  Add('   /endangle exch def');
  Add('   /startangle exch def');
  Add('   /yrad exch def');
  Add('   /xrad exch def');
  Add('   /y exch def');
  Add('   /x exch def');
  Add('  /savematrix mtrx currentmatrix def');
  Add('  x y tr xrad yrad sc');
  Add('  0 0 1 startangle endangle arc');
  Add('  savematrix setmatrix');
  Add('  end');
  Add('} def');
  Add('/piedict 8 dict def');
  Add('piedict /mtrx matrix put');
  Add('/pie');
  Add('{ piedict begin');
  Add('  np');
  Add('   /endangle exch def');
  Add('   /startangle exch def');
  Add('   /yrad exch def');
  Add('   /xrad exch def');
  Add('   /y exch def');
  Add('   /x exch def');
  Add('  /savematrix mtrx currentmatrix def');
  Add('  x y tr xrad yrad sc');
  Add('  newpath');
  Add('  0 0 m');
  Add('  0 0 1 startangle endangle arc');
  Add('  closepath');
  Add('  savematrix setmatrix');
  Add('  end');
  Add('} def');
  Add('%%EndProlog');
  Add('gs');
  Add('np');
end;

procedure TEPSCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

{ TVMLExportFormat }
function TEPSExportFormat.Description: String;
begin
  result:=TeeMsg_AsPS;
end;

procedure TEPSExportFormat.DoCopyToClipboard;
begin
  with EPsList do
  try
    Clipboard.AsText:=Text;
  finally
    Free;
  end;
end;

function TEPSExportFormat.FileExtension: String;
begin
  result:='eps';
end;

function TEPSExportFormat.FileFilter: String;
begin
  result:=TeeMsg_PSFilter;
end;

function TEPSExportFormat.Options(Check:Boolean): TForm;
begin
  result:=nil;
end;

procedure TEPSExportFormat.SaveToStream(Stream: TStream);
begin
  with EPSList do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

type TTeePanelAccess=class(TCustomTeePanel);

function TEPSExportFormat.EPSList: TStringList;
var tmp : TCanvas3D;
begin { return a panel or chart in PS format into a StringList }
  CheckSize;
  result:=TStringList.Create;
  Panel.AutoRepaint:=False;
  try

    {$IFNDEF CLR} // Protected across assemblies
    tmp:=TTeePanelAccess(Panel).InternalCanvas;
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    {$ENDIF}

    Panel.Canvas:=TEPSCanvas.Create(Result);
    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      Panel.Canvas:=tmp;
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToPSFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);
begin { save panel or chart to filename in EPS (PostScript) format }
  with TEPSExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TEPSCanvas.TranslateVertCoord(var Y: Integer);
begin
  { vertical coordinate is reversed in PS !! }
  Y := (Self.Bounds.Bottom - Self.Bounds.Top)  - Y;
end;

function TEPSCanvas.SetPenStyle(PenStyle: TPenStyle): String;
begin
  case PenStyle of
    psSolid : Result := '[] 0 sd';
    psDash : Result := '[3] 0 sd';
    psDot : Result := '[2] 1 sd';
    {
    psDashDot : Result :=
    psDashDotDot : Result :=
    }
   else Result := '';
  end;
end;

procedure TEPSCanvas.InternalArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer;
  Pie: Boolean);

var CenterX, CenterY: Integer;
    StartAngle, EndAngle: String;
    Ra,Rb: String;

    procedure DrawPie;
    begin
      Add(IntToStr(CenterX) + ' '+IntToStr(CenterY) + ' ' +
          Ra + ' ' + Rb + ' '+StartAngle+' ' +
          EndAngle+' pie') ;
    end;

    procedure DrawArc;
    begin
      Add(IntToStr(CenterX) + ' '+IntToStr(CenterY) + ' ' +
          Ra + ' ' + Rb + ' '+StartAngle+' ' +
          EndAngle+' ellipse') ;
    end;

var Theta: double;
const HalfDivPi = 57.29577951;

begin
  if ((Brush.Style<>bsClear) or (Pen.Style<>psClear)) then
  begin
    CenterX := (X1 + X2) div 2;
    CenterY := (Y1 + Y2) div 2;
    { StartAngle }
    Theta := Math.ArcTan2(CenterY-Y3, X3 - CenterX);
    if Theta<0 then Theta:=2.0*Pi+Theta;
    Theta := Theta*HalfDivPi;
    StartAngle := FloatToStr(Theta);
    FixSeparator(StartAngle);
    { EndAngle }
    Theta := Math.ArcTan2(CenterY-Y4, X4 - CenterX);
    if Theta<0 then Theta:=2.0*Pi+Theta;
    Theta := Theta*HalfDivPi;
    if Theta=0 then Theta:=361;
    EndAngle := FloatToStr(Theta);
    FixSeparator(EndAngle);
    TranslateVertCoord(CenterY);
    { radius }
    Ra := FormatFloat('0.00',(X2-X1)*0.5);
    FixSeparator(Ra);
    Rb := FormatFloat('0.00',(Y2-Y1)*0.5);
    FixSeparator(Rb);
    If Pie then
    begin
      if (Brush.Style<>bsClear) then
      begin
        Add('gs ' + BrushProperties(Brush));
        DrawPie;
        Add('fi gr');
      end;
      if (Pen.Style<>psClear) then
      begin
        Add('gs ' + PenProperties(Pen));
        DrawPie;
        Add('st gr');
      end;
    end else if (Pen.Style<>psClear) then
    begin
      Add('gs ' + PenProperties(Pen));
      DrawArc;
      Add('st gr');
    end;
  end;
end;

function TEPSCanvas.PenProperties(Pen: TPen): String;
begin
  tmpStr := PSColor(Pen.Color) + ' ' + SetPenStyle(Pen.Style)
            + ' ' + IntToStr(Pen.Width)+' sw';
  Result := tmpStr;
end;

function TEPSCanvas.BrushProperties(Brush: TBrush): String;
begin
  tmpStr := PsColor(Brush.Color);
  Result := tmpStr;
end;

function TEPSCanvas.TextToPSText(AText: String): String;
begin
  AText := StringReplace(AText,'\','\\',[rfReplaceAll,rfIgnoreCase]);
  AText := StringReplace(AText,'(','\(',[rfReplaceAll,rfIgnoreCase]);
  AText := StringReplace(AText,')','\)',[rfReplaceAll,rfIgnoreCase]);
  Result := AText;
end;

initialization
  RegisterTeeExportFormat(TEPSExportFormat);
finalization
  UnRegisterTeeExportFormat(TEPSExportFormat);
end.

