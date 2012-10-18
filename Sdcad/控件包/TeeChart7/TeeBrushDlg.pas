{******************************************}
{    TeeChart. TBrushDialog                }
{ Copyright (c) 1996-2004 by David Berneda }
{******************************************}
unit TeeBrushDlg;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, Types,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeCanvas, TeePenDlg;

type
  TBrushDialog = class(TForm)
    Button2: TButton;
    BColor: TButtonColor;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Image1: TImage;
    LStyle: TListBox;
    ImageMetal: TImage;
    ImageWood: TImage;
    ImageStone: TImage;
    ImageClouds: TImage;
    ImageGrass: TImage;
    ImageFire: TImage;
    ImageSnow: TImage;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure LStyleClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    {$IFDEF CLX}
    procedure LStyleDrawItem(Sender: TObject; Index: Integer;
        Rect: TRect;  State: TOwnerDrawState; var Handled: Boolean);
    {$ELSE}
    procedure LStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ENDIF}
  private
    { Private declarations }
    BackupBrush : TChartBrush;
    Procedure CheckImageButton;
    Function GetInternalBrush(Index:Integer):TBitmap;
    procedure RedrawShape;
  public
    { Public declarations }
    TheBrush : TChartBrush;
  end;

Function EditChartBrush( AOwner:TComponent;
                          ChartBrush:TChartBrush):Boolean;

Function EditTeeFont(AOwner:TComponent; AFont:TFont):Boolean;

Function TeeGetPictureFileName(AOwner:TComponent):String;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
{$R 'TeeBrush1.bmp'}
{$R 'TeeBrush2.bmp'}
{$R 'TeeBrush3.bmp'}
{$R 'TeeBrush4.bmp'}
{$R 'TeeBrush5.bmp'}
{$R 'TeeBrush6.bmp'}
{$R 'TeeBrush7.bmp'}
{$R 'TeeBrush8.bmp'}
{$R 'TeeBrush9.bmp'}
{$R 'TeeBrush10.bmp'}
{$R 'TeeBrush11.bmp'}
{$R 'TeeBrush12.bmp'}

{$ELSE}
{$R TeeBrushes.res}
{$ENDIF}

Uses {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, TeeProcs;

Function EditTeeFont(AOwner:TComponent; AFont:TFont):Boolean;
Begin
  result:=False;
  With TFontDialog.Create(AOwner) do
  try
    Font.Assign(AFont);
    if Execute then
    begin
      AFont.Assign(Font);
      result:=True;
    end;
  finally
    Free;
  end;
end;

Function EditChartBrush( AOwner:TComponent;
                         ChartBrush:TChartBrush):Boolean;
var tmp : TBrushDialog;
Begin
  tmp:=TeeCreateForm(TBrushDialog,AOwner) as TBrushDialog;
  with tmp do
  try
    TheBrush:=ChartBrush;
    TeeTranslateControl(tmp);
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Function TeeGetPictureFileName(AOwner:TComponent):String;
begin
  result:='';
  With {$IFDEF CLX}TOpenDialog{$ELSE}TOpenPictureDialog{$ENDIF}.Create(AOwner) do
  try
    {$IFDEF CLX}
    DefaultExt:='bmp';
    Filter:='All (*.bmp; *.ico; *.png; *.xpm)|Bitmaps (*.bmp)|Icons (*.ico)|'+
            'Portable Network Graphics (*.png)|X Pixmaps (*.xpm)';
    Options:=[ofAllowMultiSelect];
    Title:='Add Images';
    {$ENDIF}
    if Execute then result:=FileName;
  finally
    Free;
  end;
end;

procedure TeeLoadClearImage(AOwner:TComponent; AImage:TPicture);
var tmp : String;
begin
  if Assigned(AImage.Graphic) then AImage.Assign(nil)
  else
  begin
    tmp:=TeeGetPictureFileName(AOwner);
    if tmp<>'' then AImage.LoadFromFile(tmp);
  end;
end;

{ TBrushDialog }
procedure TBrushDialog.RedrawShape;
begin
  BColor.Enabled:=TheBrush.Style<>bsClear;
end;

procedure TBrushDialog.FormShow(Sender: TObject);
begin
  BackupBrush:=TChartBrush.Create(nil);

  if Assigned(TheBrush) then
  begin
    BackupBrush.Assign(TheBrush);

    if Assigned(TheBrush.Image.Graphic) then
       LStyle.ItemIndex:=-1
    else
       LStyle.ItemIndex:=Ord(TheBrush.Style);

    BColor.LinkProperty(TheBrush,'Color');

    CheckImageButton;
    RedrawShape;
  end;
end;

procedure TBrushDialog.Button3Click(Sender: TObject);
begin
  TheBrush.Assign(BackupBrush);
  ModalResult:=mrCancel;
end;

procedure TBrushDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  BackupBrush.Free;
end;

procedure TBrushDialog.Button1Click(Sender: TObject);
var tmp       : String;
    tmpBitmap : TBitmap;
begin
  LStyle.ItemIndex:=Ord(TheBrush.Style);

  if Button1.Tag=1 then
     TheBrush.Image.Assign(nil)
  else
  begin
    tmp:=TeeGetPictureFileName(Self);
    if tmp<>'' then
    begin
      TheBrush.Image.LoadFromFile(tmp);
      if not (TheBrush.Image.Graphic is TBitmap) then
      begin
        tmpBitmap:=TBitmap.Create;
        with tmpBitmap do
        begin
          Width:=TheBrush.Image.Width;
          Height:=TheBrush.Image.Height;
          Canvas.Draw(0,0,TheBrush.Image.Graphic);
        end;

        TheBrush.Image.Bitmap:=tmpBitmap; // 5.03
      end;
    end;
  end;

  CheckImageButton;
end;

Procedure TBrushDialog.CheckImageButton;
begin
  if Assigned(TheBrush.Image.Graphic) then
  begin
    Button1.Tag:=1;
    Button1.Caption:=TeeMsg_ClearImage;
    Image1.Picture.Assign(TheBrush.Image);
  end
  else
  begin
    Button1.Tag:=0;
    Button1.Caption:=TeeMsg_BrowseImage;
    Image1.Picture:=nil;
  end;
end;

procedure TBrushDialog.FormCreate(Sender: TObject);
begin  
  BorderStyle:=TeeBorderStyle;
end;

{$IFDEF CLX}
procedure TBrushDialog.LStyleDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ELSE}
procedure TBrushDialog.LStyleDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
Var Old : TColor;
begin
  With TControlCanvas(LStyle.Canvas) do
  begin
    FillRect(Rect);

    if Index<>1 then
    begin
      if Index<=7 then
      begin
        Brush.Style:=TBrushStyle(Index);
        Brush.Color:=clBlack;
      end;

      {$IFDEF CLX}
      Old:=Font.Color;
      Font.Color:=clBlack;
      {$ELSE}
      SetBkColor(Handle,clWhite);
      SetBkMode(Handle,Transparent);
      Old:=GetTextColor(Handle);
      SetTextColor(Handle,clBlack);
      {$ENDIF}

      with Rect do Rect:=TeeRect(Left+2,Top+2,Left+16,Bottom-2);

      if Index>7 then
         StretchDraw(Rect,GetInternalBrush(Index-8))
      else
         FillRect(Rect);

      {$IFDEF CLX}
      Font.Color:=Old;
      {$ELSE}
      Brush.Bitmap.Free;
      SetTextColor(Handle,Old);
      {$ENDIF}
    end;

    Brush.Style:=bsClear;
    {$IFDEF CLX}
    Font.Color:=clBlack;
    {$ELSE}
    UpdateTextFlags;
    {$ENDIF}
    TextOut(Rect.Left+20,Rect.Top,LStyle.Items[Index]);
  end;
end;

procedure TBrushDialog.LStyleClick(Sender: TObject);
var tmpBitmap : TBitmap;
begin
  if LStyle.ItemIndex>7 then
  begin
    tmpBitmap:=GetInternalBrush(LStyle.ItemIndex-8);
    try
      TheBrush.Image.Graphic:=tmpBitmap;
    finally
      tmpBitmap.Free;
    end;
  end
  else
  begin
    TheBrush.Style:=TBrushStyle(LStyle.ItemIndex);
    TheBrush.Image:=nil;
  end;

  CheckImageButton;
  RedrawShape;
end;

Function TBrushDialog.GetInternalBrush(Index:Integer):TBitmap;
begin
  result:=TBitmap.Create;

  case Index of
    12: result.Assign(ImageMetal.Picture);
    13: result.Assign(ImageWood.Picture);
    14: result.Assign(ImageStone.Picture);
    15: result.Assign(ImageClouds.Picture);
    16: result.Assign(ImageGrass.Picture);
    17: result.Assign(ImageFire.Picture);
    18: result.Assign(ImageSnow.Picture);
  else
    GetTeeBrush(Index,result);
  end;
end;

Procedure GetTeeBrush(Index:Integer; ABitmap:TBitmap);
begin
  {$IFDEF CLR}
  TeeLoadBitmap(ABitmap,'TeeBrush'+TeeStr(1+Index),'');
  {$ELSE}
  with ABitmap do
  begin
    LoadFromResourceName(HInstance,'TeeBrush'+TeeStr(1+Index));
    TransparentMode:=tmFixed;
    TransparentColor:=clWhite;
  end;
  {$ENDIF}
end;

end.
