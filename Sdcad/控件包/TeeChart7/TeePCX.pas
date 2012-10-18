{**********************************************}
{   TeeChart PCX format related functions      }
{   Copyright (c) 2000-2004 by David Berneda   }
{   Portions Copyright (c) Davie Reed,         }
{   January 1999. E-Mail:  davie@smatters.com  }
{**********************************************}
unit TeePCX;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF CLX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QControls, QForms, QGraphics, QDialogs,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs,
  {$ENDIF}
  TeeProcs, TeeExport;

type
  TPCXOptions = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPCXExportFormat=class(TTeeExportFormat)
  private
    FProperties : TPCXOptions;
    Function Bitmap:TBitmap;
    Procedure CheckProperties;
  protected
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst,
     {$IFDEF CLX}
     QClipbrd
     {$ELSE}
     Clipbrd
     {$ENDIF}
     {$IFNDEF CLX}
     {$IFNDEF CLR}
     , PCX
     {$ENDIF}
     {$ENDIF}
     , TeCanvas;

function TPCXExportFormat.Description:String;
begin
  result:=TeeMsg_AsPCX;
end;

function TPCXExportFormat.FileFilter:String;
begin
  result:=TeeMsg_PCXFilter;
end;

function TPCXExportFormat.FileExtension:String;
begin
  result:='pcx';
end;

Procedure TPCXExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then FProperties:=TPCXOptions.Create(nil)
end;

Function TPCXExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TPCXExportFormat.SaveToStream(Stream:TStream);
var tmpBitmap : TBitmap;
begin
  CheckProperties;
  CheckSize;
  tmpBitmap:=Bitmap;
  try
    tmpBitmap.PixelFormat:=TeePixelFormat;
    {$IFNDEF CLX}
    {$IFNDEF CLR}
    TeePCXToStream(Stream,tmpBitmap,4);
    {$ENDIF}
    {$ENDIF}
  finally
    tmpBitmap.Free;
  end;
end;

procedure TPCXExportFormat.DoCopyToClipboard;
var tmp : TBitmap;
begin
  tmp:=Bitmap;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

function TPCXExportFormat.Bitmap: TBitmap;
begin
  result:=Panel.TeeCreateBitmap(Panel.Color,TeeRect(0,0,Width,Height));
end;

initialization
  RegisterTeeExportFormat(TPCXExportFormat);
finalization
  UnRegisterTeeExportFormat(TPCXExportFormat);
end.
