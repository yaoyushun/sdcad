{**************************************}
{   TeeChart Pro Charting Library      }
{   Custom Series Example: TImageBar   }
{ Copyright (c) 1998-2004 by David Berneda.}
{**************************************}
unit ImageBar;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Series, Chart, TeCanvas;

//  This unit implements a custom TeeChart Series.
//  The TImageBarSeries is a normal BarSeries with an optional Image to
//  be displayed on each Bar point, stretched or tiled.

//  Only rectangular Bar style is allowed.

type
  TImageBarSeries=class(TBarSeries)
  private
    FImage:TPicture;
    FImageTiled:Boolean;
    Procedure SetImage(Value:TPicture);
    Procedure SetImageTiled(Value:Boolean);
    Procedure DrawTiledImage(AImage:TPicture; Const R:TRect; StartFromTop:Boolean);
  protected
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    Procedure DrawBar(BarIndex,StartPos,EndPos:Integer); override;
  published
    property Image:TPicture read FImage write SetImage;
    property ImageTiled:Boolean read FImageTiled write SetImageTiled default False;
  end;

// Used also at ImaPoint.pas unit
Procedure LoadBitmapFromResourceName(ABitmap:TBitmap; const ResName: string);

implementation

Uses 
  SysUtils, TeeProcs, TeeProCo;

// This resource file contains the default bitmap image
{$IFDEF CLR}
{$R 'TeeMoney.bmp'}
{$R 'TImageBarSeries.bmp'}
{$ELSE}
{$R TeeImaBa.res}
{$ENDIF}

{ This function loads a bitmap from a resource linked to the executable }
Procedure LoadBitmapFromResourceName(ABitmap:TBitmap; const ResName: string);
begin
  {$IFDEF CLR}
  TeeLoadBitmap(ABitmap,ResName,'');
  {$ELSE}
  ABitmap.LoadFromResourceName(HInstance,ResName);
  {$ENDIF}
end;

{ overrided constructor to create the Image property }
Constructor TImageBarSeries.Create(AOwner:TComponent);
begin
  inherited;
  FImage:=TPicture.Create;
  FImage.OnChange:=CanvasChanged;
  LoadBitmapFromResourceName(FImage.Bitmap,'TeeMoney');  { <-- load default }
end;

Destructor TImageBarSeries.Destroy;
begin
  FImage.Free;
  inherited;
end;

Procedure TImageBarSeries.SetImage(Value:TPicture);
begin
  FImage.Assign(Value);
end;

Procedure TImageBarSeries.SetImageTiled(Value:Boolean);
begin
  SetBooleanProperty(FImageTiled,Value);
end;

{ Add two bars only to the gallery }
Procedure TImageBarSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues(2);
  ParentChart.View3DOptions.Orthogonal:=True;
end;

{ This method draws an image in tiled mode }
Procedure TImageBarSeries.DrawTiledImage( AImage:TPicture;
                                          Const R:TRect;
                                          StartFromTop:Boolean );
Var tmpX      : Integer;
    tmpY      : Integer;
    tmpWidth  : Integer;
    tmpHeight : Integer;
    RectH     : Integer;
    RectW     : Integer;
    tmpRect   : TRect;
begin
  tmpWidth :=AImage.Width;
  tmpHeight:=AImage.Height;
  if (tmpWidth>0) and (tmpHeight>0) then
  Begin
    ParentChart.Canvas.ClipRectangle(R);

    RectSize(R,RectW,RectH);

    tmpY:=0;
    while tmpY<RectH do
    begin

      tmpX:=0;
      while tmpX<RectW do
      begin
        if StartFromTop then
           tmpRect:=TeeRect(R.Left,R.Top+tmpY,R.Right,R.Top+tmpY+tmpHeight)
        else
           tmpRect:=TeeRect(R.Left,R.Bottom-tmpY-tmpHeight,R.Right,R.Bottom-tmpY);
        ParentChart.Canvas.StretchDraw(tmpRect,AImage.Graphic);
        Inc(tmpX,tmpWidth);
      end;

      Inc(tmpY,tmpHeight);
    end;

    ParentChart.Canvas.UnClipRectangle;
  end;
end;

Procedure TImageBarSeries.DrawBar(BarIndex,StartPos,EndPos:Integer);
Var R     : TRect;
    tmp   : Integer;
    tmp3D : Boolean;
begin
  { first thing to do is to call the inherited DrawBar method of TBarSeries }
  inherited;

  if Assigned(FImage.Graphic) and (FImage.Graphic.Width>0) then { <-- if non empty image... }
  Begin
    { Calculate the exact rectangle, removing borders }
    R:=BarBounds;
    if R.Bottom<R.Top then SwapInteger(R.Top,R.Bottom);
    if BarPen.Visible then
    begin
      tmp:=BarPen.Width;
      if (tmp>1) and ((tmp mod 2)=0) then Dec(tmp);
      Inc(R.Left,tmp);
      Inc(R.Top,tmp);
      if not ParentChart.View3D then
      begin
        Dec(R.Right);
        Dec(R.Bottom);
      end;
    end;

    tmp3D:=ParentChart.View3D and (not ParentChart.View3DOptions.Orthogonal);

    if not tmp3D then
       R:=ParentChart.Canvas.CalcRect3D(R,StartZ)
    else
      if not TeeCull(ParentChart.Canvas.FourPointsFromRect(R,StartZ)) then
         exit;

    { Draw the image }
    if FImageTiled then { tiled }
       DrawTiledImage(FImage,R,BarBounds.Bottom<BarBounds.Top)
    else { stretched }
    if tmp3D then 
       ParentChart.Canvas.StretchDraw(R,FImage.Graphic,StartZ)
    else 
       ParentChart.Canvas.StretchDraw(R,FImage.Graphic);
  end;
end;

class Function TImageBarSeries.GetEditorClass:String;
begin
  result:='TImageBarSeriesEditor';
end;

initialization
  RegisterTeeSeries( TImageBarSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_ImageBarSeries,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([ TImageBarSeries ]);
end.
