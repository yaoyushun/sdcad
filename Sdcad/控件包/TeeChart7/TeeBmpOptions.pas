{*******************************************}
{ TeeChart Pro Bitmap exporting             }
{ Copyright (c) 1995-2004 by David Berneda  }
{         All Rights Reserved               }
{*******************************************}
unit TeeBmpOptions;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, Types,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  TeeProcs, TeeExport, TeCanvas;

type
  TBMPOptions = class(TForm)
    CBMono: TCheckBox;
    Label1: TLabel;
    CBColors: TComboFlat;
    procedure CBMonoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TBMPExportFormat=class(TTeeExportFormat)
  private
    FProperties: TBMPOptions;
    Procedure CheckProperties;
  protected
    Procedure DoCopyToClipboard; override;
  public
    Function Bitmap:TBitmap;
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

Procedure TeeSaveToBitmap( APanel:TCustomTeePanel;
                           Const FileName: WideString;
                           Const R:TRect);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd, 
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst;

procedure TBMPOptions.CBMonoClick(Sender: TObject);
begin
  CBColors.Enabled:=not CBMono.Checked;
end;

function TBMPExportFormat.Description:String;
begin
  result:=TeeMsg_AsBMP;
end;

function TBMPExportFormat.FileFilter:String;
begin
  result:=TeeMsg_BMPFilter;
end;

function TBMPExportFormat.FileExtension:String;
begin
  result:='bmp';
end;

Function TBMPExportFormat.Bitmap:TBitmap;
var tmp : TBitmap;
    R   : TRect;
    Old : Boolean;
begin
  CheckProperties;
  tmp:=TBitmap.Create;
  CheckSize;
  tmp.Width:=Width;
  tmp.Height:=Height;

  tmp.Monochrome:=FProperties.CBMono.Checked;

  {$IFNDEF CLX}
  if not FProperties.CBMono.Checked then
     tmp.PixelFormat:=TPixelFormat(FProperties.CBColors.ItemIndex);
  {$ENDIF}

  if Panel.Canvas.SupportsFullRotation then
     tmp.PixelFormat:=TeePixelFormat;

  R:=TeeRect(0,0,tmp.Width,tmp.Height);
  With tmp do
  begin
    Canvas.Brush.Color:=Panel.Color;
    Canvas.FillRect(R);
    Old:=Panel.BufferedDisplay;
    Panel.BufferedDisplay:=False;
    Panel.Draw(Canvas,R);
    Panel.BufferedDisplay:=Old;
  end;
  result:=tmp;
end;

Procedure TBMPExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then FProperties:=TBMPOptions.Create(nil)
end;

Function TBMPExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TBMPExportFormat.DoCopyToClipboard;
var tmp : TBitmap;
begin
  tmp:=Bitmap;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TBMPExportFormat.SaveToStream(Stream:TStream);
begin
  with Bitmap do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

Procedure TeeSaveToBitmap( APanel:TCustomTeePanel;
                           Const FileName: WideString;
                           Const R:TRect);
begin
  with TBMPExportFormat.Create do
  try
    Panel:=APanel;
    Width:=R.Right-R.Left;
    Height:=R.Bottom-R.Top;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TBMPOptions.FormCreate(Sender: TObject);
begin
  CBColors.ItemIndex:=0;
end;

procedure TBMPOptions.FormShow(Sender: TObject);
begin
  CBColors.ItemIndex:=0;
end;

initialization
  RegisterTeeExportFormat(TBMPExportFormat);
finalization
  UnRegisterTeeExportFormat(TBMPExportFormat);
end.
