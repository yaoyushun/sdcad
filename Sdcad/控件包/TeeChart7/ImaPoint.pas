{**********************************************}
{   TImagePointSeries and TDeltaPointSeries    }
{   Copyright (c) 1997-2004 by David Berneda   }
{**********************************************}
unit ImaPoint;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, Series, TeCanvas;

{  This unit contains two Series components:

   TImagePointSeries --  A point Series displaying images
   TDeltaPointSeries --  An ImagePoint Series displaying a different
                         image depending the previous point value.
}

Type TCustomImagePointSeries=class;
     TGetImageEvent=Procedure( Sender:TCustomImagePointSeries;
                               ValueIndex:Integer;
                               Picture:TPicture) of object;

     TCustomImagePointSeries=class(TPointSeries)
     private
       FImagePoint  : TPicture;
       FImageTransp : Boolean;
       FOnGetImage  : TGetImageEvent;
       procedure SetImagePoint(Const Value:TPicture);
       procedure SetImageTransp(Const Value:Boolean);
     protected
       procedure DrawValue(ValueIndex:Integer); override;
       Procedure PrepareForGallery(IsEnabled:Boolean); override;
     public
       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;

       property ImagePoint:TPicture read FImagePoint write SetImagePoint;
       property ImageTransparent:Boolean read FImageTransp write SetImageTransp
                                         default False;
       property OnGetImage:TGetImageEvent read FOnGetImage
                                          write FOnGetImage;
     end;

     TImagePointSeries=class(TCustomImagePointSeries)
     public
       Constructor Create(AOwner:TComponent); override;
     published
       property ImagePoint;
       property ImageTransparent default True;
       property OnGetImage;
     end;

     TDeltaImageStyle=(disSmiles, disHands);

     TDeltaPointSeries=class(TCustomImagePointSeries)
     private
       FEqualImage   : TPicture;
       FGreaterImage : TPicture;
       FImageStyle   : TDeltaImageStyle;
       FLowerImage   : TPicture;
       procedure SetEqualImage(Const Value:TPicture);
       procedure SetGreaterImage(Const Value:TPicture);
       procedure SetImageStyle(Const Value:TDeltaImageStyle);
       procedure SetLowerImage(Const Value:TPicture);
     protected
       procedure DrawValue(ValueIndex:Integer); override;
     public
       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;
     published
       property EqualImage:TPicture read FEqualImage write SetEqualImage;
       property GreaterImage:TPicture read FGreaterImage write SetGreaterImage;
       property ImageStyle:TDeltaImageStyle read FImageStyle write
                                            SetImageStyle default disSmiles;
       property ImageTransparent;
       property LowerImage:TPicture read FLowerImage write SetLowerImage;
       { inherited from TCustomImagePointSeries }
       property OnGetImage;
     end;

implementation

Uses ImageBar, TeeProCo;

{$IFDEF CLR}
{$R 'TeeEqualSmile.bmp'}
{$R 'TeeLowerSmile.bmp'}
{$R 'TeeGreaterSmile.bmp'}
{$R 'TeeDefaultImage.bmp'}
{$R 'TeeEqualHand.bmp'}
{$R 'TeeGreaterHand.bmp'}
{$R 'TeeLowerHand.bmp'}
{$ELSE}
{$R TeeImaPo.res}
{$ENDIF}

{ TCustomImagePointSeries }
Constructor TCustomImagePointSeries.Create(AOwner:TComponent);
begin
  inherited;
  FImagePoint:=TPicture.Create;
  FImagePoint.OnChange:=CanvasChanged;
end;

Destructor TCustomImagePointSeries.Destroy;
begin
  FImagePoint.Free;
  inherited;
end;

{ overrided DrawValue to draw an Image for each point }
procedure TCustomImagePointSeries.DrawValue(ValueIndex:Integer);
var R : TRect;
begin
  if FImagePoint.Graphic=nil then inherited
  else
  With ParentChart,Canvas do
  begin
    { trigger the OnGetImage event if assigned... }
    if Assigned(FOnGetImage) then OnGetImage(Self,ValueIndex,FImagePoint);

    { draw the image... }
    With R do
    begin
      Left:=CalcXPos(ValueIndex)-(Pointer.HorizSize div 2);
      Right:=Left+Pointer.HorizSize;
      Top:=CalcYPos(ValueIndex)-(Pointer.VertSize div 2);
      Bottom:=Top+Pointer.VertSize;
    end;

    FImagePoint.Graphic.Transparent:=FImageTransp;

    With ParentChart.Canvas do
    begin
      R:=CalcRect3D(R,StartZ);
      if ((R.Right-R.Left)=FImagePoint.Graphic.Width) and
         ((R.Bottom-R.Top)=FImagePoint.Graphic.Height) then
         Draw(R.Left,R.Top,FImagePoint.Graphic)
      else
         StretchDraw(R,FImagePoint.Graphic);
    end;
  end;
end;

procedure TCustomImagePointSeries.SetImagePoint(Const Value:TPicture);
begin
  FImagePoint.Assign(Value);   { <-- set new property values }
  if Assigned(Value) then
  begin
    if Value.Width>0 then Pointer.HorizSize:=Value.Width;
    if Value.Height>0 then Pointer.VertSize:=Value.Height;
  end;
end;

procedure TCustomImagePointSeries.SetImageTransp(Const Value:Boolean);
begin
  SetBooleanProperty(FImageTransp,Value);
end;

Procedure TCustomImagePointSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  ParentChart.View3DOptions.Orthogonal:=True;
end;

type TPointerAccess=class(TSeriesPointer);

{ TImagePointSeries }
Constructor TImagePointSeries.Create(AOwner:TComponent);
begin
  inherited;
  LoadBitmapFromResourceName(FImagePoint.Bitmap,'TeeDefaultImage');
  FImageTransp:=True;
  TPointerAccess(Pointer).ChangeHorizSize(FImagePoint.Width);
  TPointerAccess(Pointer).ChangeVertSize(FImagePoint.Height);
end;

{ TDeltaPointSeries }
Constructor TDeltaPointSeries.Create(AOwner:TComponent);
begin
  inherited;
  FEqualImage:=TPicture.Create;
  FEqualImage.OnChange:=CanvasChanged;
  FGreaterImage:=TPicture.Create;
  FGreaterImage.OnChange:=CanvasChanged;
  FLowerImage:=TPicture.Create;
  FLowerImage.OnChange:=CanvasChanged;
  ImageStyle:=disSmiles;
end;

Destructor TDeltaPointSeries.Destroy;
begin
  FEqualImage.Free;
  FLowerImage.Free;
  FGreaterImage.Free;
  inherited;
end;

{ overrided DrawValue to draw an Image for each point }
procedure TDeltaPointSeries.DrawValue(ValueIndex:Integer);
Var tmp         : Double;
    tmpPrevious : Double;
begin
  if ValueIndex=0 then FImagePoint.Assign(FEqualImage)
  else
  begin
    tmpPrevious:=MandatoryValueList.Value[ValueIndex-1];
    tmp:=MandatoryValueList.Value[ValueIndex];
    if tmp>tmpPrevious then FImagePoint.Assign(FGreaterImage) else
    if tmp<tmpPrevious then FImagePoint.Assign(FLowerImage) else
                            FImagePoint.Assign(FEqualImage);
  end;
  if FImagePoint.Width>0 then TPointerAccess(Pointer).ChangeHorizSize(FImagePoint.Width);
  if FImagePoint.Height>0 then TPointerAccess(Pointer).ChangeVertSize(FImagePoint.Height);
  inherited;
end;

procedure TDeltaPointSeries.SetEqualImage(Const Value:TPicture);
begin
  FEqualImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetGreaterImage(Const Value:TPicture);
begin
  FGreaterImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetLowerImage(Const Value:TPicture);
begin
  FLowerImage.Assign(Value);
end;

procedure TDeltaPointSeries.SetImageStyle(Const Value:TDeltaImageStyle);
begin
  FImageStyle:=Value;
  if Value=disHands then
  begin
    LoadBitmapFromResourceName(FEqualImage.Bitmap,'TeeEqualHand');
    LoadBitmapFromResourceName(FGreaterImage.Bitmap,'TeeGreaterHand');
    LoadBitmapFromResourceName(FLowerImage.Bitmap,'TeeLowerHand');
  end
  else
  begin
    LoadBitmapFromResourceName(FEqualImage.Bitmap,'TeeEqualSmile');
    LoadBitmapFromResourceName(FGreaterImage.Bitmap,'TeeGreaterSmile');
    LoadBitmapFromResourceName(FLowerImage.Bitmap,'TeeLowerSmile');
  end;
end;

initialization
  RegisterTeeSeries( TImagePointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_ImagePointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
  RegisterTeeSeries( TDeltaPointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_DeltaPointSeries,
           {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples, 1 );
finalization
  UnRegisterTeeSeries([ TImagePointSeries,TDeltaPointSeries ]);
end.
