{*********************************************}
{      TeeChart Pro OpenGL Component          }
{   Copyright (c) 1998-2004 by David Berneda  }
{         All Rights Reserved                 }
{*********************************************}
unit TeeOpenGL;
{$I TeeDefs.inc}

interface

uses Classes,
     {$IFDEF CLX}
     QGraphics, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeeProcs, TeCanvas, TeeGLCanvas;

type
  TTeeOpenGL=class;

  TGLPosition=class(TPersistent)
  private
    FX       : Double;
    FY       : Double;
    FZ       : Double;
    FOwner   : TTeeOpenGL;
  protected
    Procedure SetX(Const Value:Double);
    Procedure SetY(Const Value:Double);
    Procedure SetZ(Const Value:Double);
  public
    Procedure Assign(Source:TPersistent); override;
  published
    property X:Double read FX write SetX;
    property Y:Double read FY write SetY;
    property Z:Double read FZ write SetZ;
  end;

  TGLLight=class(TPersistent)
  private
    FColor   : TColor;
    FVisible : Boolean;

    IOwner   : TTeeOpenGL;
  protected
    Procedure SetColor(Value:TColor);
    procedure SetVisible(Value:Boolean);
  public
    Constructor Create(AOwner:TTeeOpenGL);
    Procedure Assign(Source:TPersistent); override;
    Function GLColor:GLMat;
  published
    property Color:TColor read FColor write SetColor default clSilver;
    property Visible:Boolean read FVisible write SetVisible;
  end;

  TGLLightSource=class(TGLLight)
  private
    FPosition  : TGLPosition;
    FFixed: Boolean;
    procedure SetFixed(const Value: Boolean);
  protected
    Procedure SetPosition(Value:TGLPosition);
  public
    Constructor Create(AOwner:TTeeOpenGL);
    Destructor Destroy; override;
    Procedure Assign(Source:TPersistent); override;
  published
    property FixedPosition:Boolean read FFixed write SetFixed default False;
    property Position:TGLPosition read FPosition write SetPosition;
  end;

  TTeeOpenGL = class(TComponent)
  private
    { Private declarations }
    FActive       : Boolean;
    FAmbientLight : Integer;
    FFontExtrusion: Integer;
    FFontOutlines : Boolean;
    FLight0       : TGLLightSource;
    FLight1       : TGLLightSource;
    FLight2       : TGLLightSource;
    FShadeQuality : Boolean;
    FShininess    : Double;
    FTeePanel     : TCustomTeePanel;
    FDrawStyle    : TTeeCanvasSurfaceStyle;

    FOnInit       : TNotifyEvent;

    Function GetCanvas:TGLCanvas;
    Procedure SetActive(Value:Boolean);
    Procedure SetAmbientLight(Value:Integer);
    Procedure SetFontExtrusion(Value:Integer);
    Procedure SetFontOutlines(Value:Boolean);
    Procedure SetLightSource0(Value:TGLLightSource);
    Procedure SetLightSource1(Value:TGLLightSource);
    Procedure SetLightSource2(Value:TGLLightSource);
    Procedure SetShadeQuality(Value:Boolean);
    Procedure SetShininess(Const Value:Double);
    Procedure SetTeePanel(Value:TCustomTeePanel);
    procedure SetDrawStyle(const Value: TTeeCanvasSurfaceStyle);

    Procedure Activate;
    Procedure OnCanvasInit(Sender:TObject);
    Procedure SetDoubleProperty(Var Variable:Double; Const Value:Double);
  protected
    { Protected declarations }
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    Procedure Repaint;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    property Canvas:TGLCanvas read GetCanvas;
    property Light0:TGLLightSource read FLight0;
  published
    { Published declarations }
    property Active:Boolean read FActive write SetActive default False;
    property AmbientLight:Integer read FAmbientLight write SetAmbientLight;
    property FontExtrusion:Integer read FFontExtrusion write SetFontExtrusion default 0;
    property FontOutlines:Boolean read FFontOutlines write SetFontOutlines default False;
    property Light:TGLLightSource read FLight0 write SetLightSource0;
    property Light1:TGLLightSource read FLight1 write SetLightSource1;
    property Light2:TGLLightSource read FLight2 write SetLightSource2;
    property ShadeQuality:Boolean read FShadeQuality write SetShadeQuality default True;
    property Shininess:Double read FShininess write SetShininess;
    property TeePanel:TCustomTeePanel read FTeePanel write SetTeePanel;
    property DrawStyle:TTeeCanvasSurfaceStyle read FDrawStyle
                                              write SetDrawStyle default tcsSolid;

    property OnInit:TNotifyEvent read FOnInit write FOnInit;
  end;

implementation

{$IFDEF CLR}
{$R 'TTeeOpenGL.bmp'}
{$ELSE}
{$R TeeGLIcon.res}
{$ENDIF}

Uses {$IFDEF CLX}
     QControls,
     {$ELSE}
     Controls,
     {$ENDIF}

     {$IFDEF LINUX}
     OpenGLLinux,
     {$ELSE}
     Windows,
     OpenGL2,
     {$ENDIF}

     TeeConst;

{ TGLPosition }
Procedure TGLPosition.SetX(Const Value:Double);
begin
  FOwner.SetDoubleProperty(FX,Value);
end;

Procedure TGLPosition.SetY(Const Value:Double);
begin
  FOwner.SetDoubleProperty(FY,Value);
end;

Procedure TGLPosition.SetZ(Const Value:Double);
begin
  FOwner.SetDoubleProperty(FZ,Value);
end;

Procedure TGLPosition.Assign(Source:TPersistent);
begin
  if Source is TGLPosition then
  With TGLPosition(Source) do
  begin
    Self.FX:=X;
    Self.FY:=Y;
    Self.FZ:=Z;
  end
  else inherited;
end;

{ TGLLightSource }
Constructor TGLLightSource.Create(AOwner:TTeeOpenGL);
begin
  inherited;
  FPosition:=TGLPosition.Create;
  With FPosition do
  begin
    FOwner:=Self.IOwner;
    FX:=-100;
    FY:=-100;
    FZ:=-100;
  end;
end;

Destructor TGLLightSource.Destroy;
begin
  FPosition.Free;
  inherited;
end;

Procedure TGLLightSource.SetPosition(Value:TGLPosition);
begin
  FPosition.Assign(Value);
end;

Procedure TGLLightSource.Assign(Source:TPersistent);
begin
  if Source is TGLLightSource then
  With TGLLightSource(Source) do
  begin
    Self.Position:=Position;
  end;
  inherited;
end;

procedure TGLLightSource.SetFixed(const Value: Boolean);
begin
  if FFixed<>Value then
  begin
    FFixed:=Value;
    IOwner.Repaint;
  end;
end;

{ TGLLight }
Constructor TGLLight.Create(AOwner:TTeeOpenGL);
begin
  inherited Create;
  IOwner:=AOwner;
  FColor:=clGray;
end;

Procedure TGLLight.SetColor(Value:TColor);
begin
  if FColor<>Value then
  begin
    FColor:=Value;
    IOwner.Repaint;
  end;
end;

procedure TGLLight.SetVisible(Value:Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    IOwner.Repaint;
  end;
end;

Function TGLLight.GLColor:GLMat;
const tmpInv=1/255.0;
var AColor : TColor;
begin
  AColor:=ColorToRGB(FColor);
  result[0]:=GetRValue(AColor)*tmpInv;
  result[1]:=GetGValue(AColor)*tmpInv;
  result[2]:=GetBValue(AColor)*tmpInv;
  result[3]:=1;
end;

Procedure TGLLight.Assign(Source:TPersistent);
begin
  if Source is TGLLight then
  With TGLLight(Source) do
  begin
    Self.FColor:=Color;
    Self.FVisible:=Visible;
  end
  else inherited;
end;

{ TTeeOpenGL }
Constructor TTeeOpenGL.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FLight0:=TGLLightSource.Create(Self);
  FLight0.Visible:=True;
  FLight1:=TGLLightSource.Create(Self);
  FLight2:=TGLLightSource.Create(Self);
  FAmbientLight:=8; {%}
  FShininess:=0.5;
  FShadeQuality:=True;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

Destructor TTeeOpenGL.Destroy;
begin
  FLight2.Free;
  FLight1.Free;
  FLight0.Free;

  if Assigned(FTeePanel) then
  begin
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FTeePanel).GLComponent:=nil;
    if FActive then
       FTeePanel.Canvas:=TTeeCanvas3D.Create;
  end;
  inherited;
end;

Function TTeeOpenGL.GetCanvas:TGLCanvas;
begin
  if Assigned(FTeePanel) and (FTeePanel.Canvas is TGLCanvas) then
     result:=TGLCanvas(FTeePanel.Canvas)
  else
     result:=nil;
end;

type TPrivateGLCanvas=class(TGLCanvas);

Procedure TTeeOpenGL.OnCanvasInit(Sender:TObject);

  Procedure SetLight(ALight:TGLLightSource; Num:Integer);
  begin
    With ALight do
    if Visible then
    begin
      if FixedPosition then Canvas.DisableRotation;
      
      With Position do
           TPrivateGLCanvas(Canvas).InitLight(Num,GLColor,X,Y,Z);

      if FixedPosition then Canvas.EnableRotation;
    end
    else
       glDisable(Num);
  end;

begin
  TPrivateGLCanvas(Canvas).InitAmbientLight(FAmbientLight);

  SetLight(FLight0,GL_LIGHT0);
  SetLight(FLight1,GL_LIGHT1);
  SetLight(FLight2,GL_LIGHT2);

  TPrivateGLCanvas(Canvas).SetShininess(FShininess);
  if Assigned(FOnInit) then FOnInit(Self);
end;

Procedure TTeeOpenGL.SetShininess(Const Value:Double);
begin
  SetDoubleProperty(FShininess,Value);
  if Assigned(FTeePanel) then FTeePanel.Repaint;
end;

Procedure TTeeOpenGL.SetShadeQuality(Value:Boolean);
begin
  if FShadeQuality<>Value then
  begin
    FShadeQuality:=Value;
    if FActive and Assigned(FTeePanel) then
    With Canvas do
    begin
      ShadeQuality:=Value;
      Repaint;
    end;
  end;
end;

procedure TTeeOpenGL.Notification( AComponent: TComponent;
                                   Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FTeePanel) and (AComponent=FTeePanel) then
     TeePanel:=nil;
end;

Procedure TTeeOpenGL.Activate;
var tmpCanvas : TGLCanvas;
begin
  if Assigned(FTeePanel) then
    if FActive then
    begin
      tmpCanvas:=TGLCanvas.Create;

      With tmpCanvas do
      begin
        FontOutlines:=Self.FFontOutlines;
        DrawStyle:=Self.DrawStyle;
        ShadeQuality:=Self.FShadeQuality;
        OnInit:=OnCanvasInit;
        UseBuffer:=FTeePanel.Canvas.UseBuffer;
      end;

      FTeePanel.Canvas:=tmpCanvas;
    end
    else FTeePanel.Canvas:=TTeeCanvas3D.Create;
end;

Procedure TTeeOpenGL.SetAmbientLight(Value:Integer);
begin
  if FAmbientLight<>Value then
  begin
    FAmbientLight:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetFontExtrusion(Value:Integer);
begin
  FFontExtrusion:=Value;
  if FActive and Assigned(FTeePanel) then
  With Canvas do
  begin
    DeleteFont;
    FontExtrusion:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetFontOutlines(Value:Boolean);
begin
  FFontOutlines:=Value;
  if FActive and Assigned(FTeePanel) then
  With Canvas do
  begin
    DeleteFont;
    FontOutlines:=Value;
    Repaint;
  end;
end;

Procedure TTeeOpenGL.SetLightSource0(Value:TGLLightSource);
begin
  FLight0.Assign(Value);
end;

Procedure TTeeOpenGL.SetLightSource1(Value:TGLLightSource);
begin
  FLight1.Assign(Value);
end;

Procedure TTeeOpenGL.SetLightSource2(Value:TGLLightSource);
begin
  FLight2.Assign(Value);
end;

Procedure TTeeOpenGL.SetActive(Value:Boolean);
begin
  if FActive<>Value then
  begin
    FActive:=Value;
    Activate;
  end;
end;

Procedure TTeeOpenGL.Repaint;
begin
  if Assigned(FTeePanel) then FTeePanel.Repaint;
end;

Procedure TTeeOpenGL.SetTeePanel(Value:TCustomTeePanel);
begin
  FTeePanel:=Value;
  if Assigned(FTeePanel) then
  begin
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FTeePanel).GLComponent:=Self;
    FTeePanel.FreeNotification(Self);
    Activate;
  end
  else FActive:=False;
end;

Procedure TTeeOpenGL.SetDoubleProperty(Var Variable:Double; Const Value:Double);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    Repaint;
  end;
end;

procedure TTeeOpenGL.SetDrawStyle(const Value: TTeeCanvasSurfaceStyle);
begin
  FDrawStyle:=Value;
  if FActive and Assigned(FTeePanel) then
  begin
    Canvas.DrawStyle:=FDrawStyle;
    Repaint;
  end;
end;

end.

