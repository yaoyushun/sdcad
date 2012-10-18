{**********************************************}
{   TLightTool Component and Editor Dialog     }
{   Copyright (c) 2003-2004 by David Berneda   }
{**********************************************}
unit TeeLighting;
{$I TeeDefs.inc}

interface

uses Classes, 
     {$IFDEF CLX}
     QControls, QGraphics, QStdCtrls, QComCtrls, QExtCtrls, QForms,
     {$ELSE}
     Controls, Graphics, StdCtrls, ComCtrls, ExtCtrls, Forms,
     {$ENDIF}
     TeeSurfa, Chart, TeCanvas, TeeProcs, TeEngine, TeeComma;

type
  TLightStyle=(lsLinear,lsSpotLight);

  TLightTool=class(TTeeCustomTool)
  private
    FMouse: Boolean;
    FTop: Integer;
    FLeft: Integer;
    FFactor: Integer;
    FStyle: TLightStyle;

    Buffer : TBitmap;
    InsideLighting : Boolean;
    procedure SetFactor(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetStyle(const Value: TLightStyle);
    procedure SetTop(const Value: Integer);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    procedure Iluminate;
  published
    property Active;
    property Factor:Integer read FFactor write SetFactor default 10;
    property FollowMouse:Boolean read FMouse write FMouse default False;
    property Left:Integer read FLeft write SetLeft default -1;
    property Style:TLightStyle read FStyle write SetStyle default lsLinear;
    property Top:Integer read FTop write SetTop default -1;
  end;

  TLightToolEditor=class(TForm)
    CheckBox2: TCheckBox;
    Label1: TLabel;
    TBLeft: TTrackBar;
    TBTop: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    CBStyle: TComboFlat;
    TBFactor: TTrackBar;
    Label4: TLabel;
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TBFactorChange(Sender: TObject);
    procedure TBTopChange(Sender: TObject);
    procedure TBLeftChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Light : TLightTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses SysUtils, Math,
     TeeConst, TeeProCo;

var Buffer:TBitmap=nil;

Function TeeLight(Bitmap:TBitmap; xx,yy:Integer;
                  Style:TLightStyle=lsLinear;
                  Factor:Integer=10):TBitmap;
const BytesPerPixel={$IFDEF CLX}4{$ELSE}3{$ENDIF};

{$IFNDEF CLR}
var bi : TBitmap;
    tmpx2,
    x,y,
    h,w : Integer;
    twopercent : Integer;
    maxDist,dist : Double;
    b1line0,
    b2line0,
    b1line,
    b2line : PByteArray;
    tmpFactor,
    tmpFactorMaxDist : Double;

    {$IFDEF HLS}
    hue,lum,sat:double;
    {$ENDIF}

    b1Dif,b2Dif,
    tmpy:Integer;
{$ENDIF}
begin
  {$IFNDEF CLR}
  h:=Bitmap.Height;
  w:=Bitmap.Width;

  if (not Assigned(Buffer))
     or (Buffer.Width<>w) or (Buffer.Height<>h) then
  begin
    Buffer.Free;
    Buffer:=TBitmap.Create;
    {$IFNDEF CLX}
    Buffer.IgnorePalette:=True;
    {$ENDIF}
    Buffer.PixelFormat:=TeePixelFormat;
    Buffer.Width:=w;
    Buffer.Height:=h;
  end;

  result:=Buffer;

  bi:=Bitmap;

  if Assigned(bi) then
  begin
    maxDist:=100.0/Sqrt((w*w)+(h*h));

    tmpFactor:=Factor*0.01;
    if Style=lsLinear then
       tmpFactor:=20*tmpFactor;

    tmpFactorMaxDist:=tmpFactor*MaxDist;

    b2line0:=result.ScanLine[0];
    b1line0:=bi.ScanLine[0];
    b2Dif:=Integer(result.ScanLine[1])-Integer(b2line0);
    b1Dif:=Integer(bi.ScanLine[1])-Integer(b1line0);

    for y:=0 to h-1 do
    begin
      b2line:=PByteArray(Integer(b2Line0)+b2Dif*y);
      b1line:=PByteArray(Integer(b1Line0)+b1Dif*y);

      tmpy:=Sqr(y-yy);

      for x:=0 to w-1 do
      begin
        dist:=Sqrt(Sqr(x-xx)+tmpy);

        if Style=lsLinear then
           twopercent:=Round(tmpFactorMaxDist*dist)
        else
           twopercent:=Round(tmpFactor*Sqr(maxdist*(dist+1)));

        tmpx2:=BytesPerPixel*x;

        if twopercent>0 then
        begin
          {$IFDEF HLS}
          TeeColorRGBToHLS( b1line[tmpx2],
                            b1line[tmpx2+1],
                            b1line[tmpx2+2],hue,lum,sat);
          lum:=lum-twopercent;
          if lum<0 then lum:=0;

          TeeColorHLSToRGB(hue, lum, Sat,
                                b2line[tmpx2],
                                b2line[1+tmpx2],
                                b2line[2+tmpx2]);
          {$ELSE}
          if b1line[tmpx2]-twopercent<0 then
             b2line[tmpx2]:=0
          else
             b2line[tmpx2]:=b1line[tmpx2]-twopercent;

          Inc(tmpx2);
          if b1line[tmpx2]-twopercent<0 then
             b2line[tmpx2]:=0
          else
             b2line[tmpx2]:=b1line[tmpx2]-twopercent;

          Inc(tmpx2);
          if b1line[tmpx2]-twopercent<0 then
             b2line[tmpx2]:=0
          else
             b2line[tmpx2]:=b1line[tmpx2]-twopercent;
          {$ENDIF}
        end
        else
        begin
          b2line[tmpx2]:=b1line[tmpx2];
          b2line[1+tmpx2]:=b1line[1+tmpx2];
          b2line[2+tmpx2]:=b1line[2+tmpx2];
        end;
      end;
    end;
  end;
{$ELSE}
  result:=nil;
{$ENDIF}
end;

{ TLightTool }
Constructor TLightTool.Create(AOwner: TComponent);
begin
  inherited;
  FFactor:=10;
  FStyle:=lsLinear;
  FLeft:=-1;
  FTop:=-1;
end;

Destructor TLightTool.Destroy;
begin
  FreeAndNil(Buffer);
  inherited;
end;

procedure TLightTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Active and FMouse and (AEvent=cmeMove) then
  begin
    FLeft:=X;
    FTop:=Y;
    Repaint;
  end;
end;

procedure TLightTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if Active and (AEvent=cteAfterDraw) then
  begin
    FreeAndNil(Buffer);
    Iluminate;
  end;
end;

class function TLightTool.Description: String;
begin
  result:=TeeMsg_LightTool;
end;

class function TLightTool.GetEditorClass: String;
begin
  result:='TLightToolEditor';
end;

procedure TLightTool.Iluminate;

  Procedure CheckBuffer;
  begin
    if (not Assigned(Buffer)) or (Buffer.Width<>ParentChart.Width) or
       (Buffer.Height<>ParentChart.Height) then
    begin
      Buffer.Free;

      if TTeeCanvas3D(ParentChart.Canvas).Bitmap<>nil then
      begin
        Buffer:=TBitmap.Create;
        Buffer.Width:=ParentChart.Width;
        Buffer.Height:=ParentChart.Height;
        Buffer.PixelFormat:=TeePixelFormat;
        Buffer.Canvas.Draw(0,0,TTeeCanvas3D(ParentChart.Canvas).Bitmap);
      end
      else
        Buffer:=ParentChart.TeeCreateBitmap(ParentChart.Color,ParentChart.ChartBounds,TeePixelFormat);
    end;
  end;

var b : TBitmap;
    tmpX : Integer;
    tmpY : Integer;
begin
  if (not ParentChart.Canvas.Metafiling) then
  if not InsideLighting then
  begin
    InsideLighting:=True;  // set flag to avoid re-entrancy
    try
      CheckBuffer;

      if FLeft=-1 then tmpX:=ParentChart.Left+(ParentChart.Width div 2)
                  else tmpX:=FLeft;
      if FTop=-1 then tmpY:=ParentChart.Top+(ParentChart.Height div 2)
                 else tmpY:=FTop;

      b:=TeeLight(Buffer,tmpX,tmpY,FStyle,FFactor);  // create iluminated bitmap

      // this Draw call does not work when Canvas.BufferedDisplay=False (ie: Print Preview panel "asBitmap")
      ParentChart.Canvas.Draw(0,0,b);  // draw bitmap onto Chart
    finally
      InsideLighting:=False;  // reset flag
    end;
  end;
end;

procedure TLightTool.SetFactor(const Value: Integer);
begin
  SetIntegerProperty(FFactor,Value);
end;

procedure TLightTool.SetLeft(const Value: Integer);
begin
  SetIntegerProperty(FLeft,Value);
end;

procedure TLightTool.SetStyle(const Value: TLightStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

procedure TLightTool.SetTop(const Value: Integer);
begin
  SetIntegerProperty(FTop,Value);
end;

procedure TLightToolEditor.CheckBox2Click(Sender: TObject);
begin
  Light.FollowMouse:=CheckBox2.Checked;
end;

procedure TLightToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  CreatingForm:=True;
end;

procedure TLightToolEditor.FormShow(Sender: TObject);
begin
  Light:=TLightTool(Tag);

  if Assigned(Light) then
  with Light do
  begin
    CheckBox2.Checked:=FollowMouse;

    TBLeft.Max:=ParentChart.Width;
    TBTop.Max:=ParentChart.Height;

    if Left=-1 then
       TBLeft.Position:=ParentChart.Left+(ParentChart.Width div 2)
    else
       TBLeft.Position:=Left;

    if Top=-1 then
       TBTop.Position:=ParentChart.Top+(ParentChart.Height div 2)
    else
       TBTop.Position:=Top;

    TBFactor.Position:=Factor;

    if Style=lsLinear then CBStyle.ItemIndex:=0
                      else CBStyle.ItemIndex:=1;
  end;
  
  CreatingForm:=False;
end;

procedure TLightToolEditor.TBFactorChange(Sender: TObject);
begin
  Light.Factor:=TBFactor.Position;
end;

procedure TLightToolEditor.TBTopChange(Sender: TObject);
begin
  if not CreatingForm then
     Light.Top:=TBTop.Position;
end;

procedure TLightToolEditor.TBLeftChange(Sender: TObject);
begin
  if not CreatingForm then
     Light.Left:=TBLeft.Position;
end;

procedure TLightToolEditor.CBStyleChange(Sender: TObject);
begin
  if CBStyle.ItemIndex=0 then Light.Style:=lsLinear
                         else Light.Style:=lsSpotLight;
end;

procedure TLightTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if Assigned(ParentChart) then Repaint;
end;

initialization
  RegisterClass(TLightToolEditor);
  RegisterTeeTools([TLightTool]);
finalization
  FreeAndNil(Buffer);
  UnRegisterTeeTools([TLightTool]);
end.
