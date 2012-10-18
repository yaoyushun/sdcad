{**********************************************}
{   TeeChart JPEG related functions            }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeJPEG;
{$I TeeDefs.inc}

{$IFDEF TEEOCX}
{$I TeeAXDefs.inc}
{$ENDIF}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  {$IFNDEF CLX}
  {$IFNDEF CLR}
  JPEG,
  {$ENDIF}
  {$ENDIF}
  TeeProcs, TeeExport, TeCanvas;

type
  {$IFDEF CLX}
  TJPEGPerformance=(jpBestQuality, jpSpeed);

  TJPEGDefaults=packed record
      GrayScale            : Boolean;
      ProgressiveEncoding  : Boolean;
      CompressionQuality   : Integer;
      PixelFormat          : TPixelFormat;
      ProgressiveDisplay   : Boolean;
      Performance          : TJPEGPerformance;
      Scale                : Integer;
      Smoothing            : Boolean;
  end;

  TJPEGImage=class(TBitmap)
  public
      GrayScale            : Boolean;
      ProgressiveEncoding  : Boolean;
      CompressionQuality   : Integer;
      PixelFormat          : TPixelFormat;
      ProgressiveDisplay   : Boolean;
      Performance          : TJPEGPerformance;
      Scale                : Integer;
      Smoothing            : Boolean;
  end;

const
   JPEGDefaults:TJPEGDefaults=(
      GrayScale           : False;
      ProgressiveEncoding : False;
      CompressionQuality  : 95;
      PixelFormat	  : TeePixelFormat;
      ProgressiveDisplay  : False;
      Performance         : jpBestQuality;
      Scale               : 1;
      Smoothing           : True;
                              );

type
  {$ENDIF}

  TTeeJPEGOptions = class(TForm)
    CBGray: TCheckBox;
    RGPerf: TRadioGroup;
    Label1: TLabel;
    EQuality: TEdit;
    UpDown1: TUpDown;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  {$IFDEF CLR}
  TJPEGPerformance=(jpBestQuality, jpSpeed);

  TJPEGDefaults=packed record
      GrayScale            : Boolean;
      ProgressiveEncoding  : Boolean;
      CompressionQuality   : Integer;
      PixelFormat          : TPixelFormat;
      ProgressiveDisplay   : Boolean;
      Performance          : TJPEGPerformance;
      Scale                : Integer;
      Smoothing            : Boolean;
  end;

const
   JPEGDefaults:TJPEGDefaults=(
      GrayScale           : False;
      ProgressiveEncoding : False;
      CompressionQuality  : 95;
      PixelFormat	  : TeePixelFormat;
      ProgressiveDisplay  : False;
      Performance         : jpBestQuality;
      Scale               : 1;
      Smoothing           : True;
                              );

type
  TJPEGImage=class(TBitmap)
  public
      GrayScale            : Boolean;
      ProgressiveEncoding  : Boolean;
      CompressionQuality   : Integer;
      PixelFormat          : TPixelFormat;
      ProgressiveDisplay   : Boolean;
      Performance          : TJPEGPerformance;
      Scale                : Integer;
      Smoothing            : Boolean;
  end;
  {$ENDIF}

  TJPEGExportFormat=class(TTeeExportFormat)
  private
    Procedure CheckProperties;
    function GetQuality: Integer;
    procedure SetQuality(const Value: Integer);
  protected
    FProperties : TTeeJPEGOptions;
    Procedure DoCopyToClipboard; override;
  public
    Destructor Destroy; override; // 6.02

    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function Jpeg:TJPEGImage;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;

    property Quality:Integer read GetQuality write SetQuality default 95;
  end;

{ Returns a JPEG image from "APanel" Chart, DBChart or Draw3D }
Function TeeGetJPEGImageParams( APanel:TCustomTeePanel;
                                Const Params:TJPEGDefaults;
                                Left,Top,
                                Width,Height:Integer):TJPEGImage;

{ saves a Panel (Chart, Tree, etc) into a JPEG file }
procedure TeeSaveToJPEGFile( APanel:TCustomTeePanel;
                             Const FileName: WideString;
                             Gray: WordBool;
                             Performance: TJPEGPerformance;
                             Quality, AWidth, AHeight: Integer);

{ same as above, with 100% quality }
procedure TeeSaveToJPEG( APanel:TCustomTeePanel;
                         Const FileName: WideString;
                         AWidth, AHeight: Integer);

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

Function TeeGetJPEGImageParams( APanel:TCustomTeePanel;
                                Const Params:TJPEGDefaults;
                                Left,Top,
                                Width,Height:Integer):TJPEGImage;
var tmpBitmap : TBitmap;
begin
  { converts a Chart to JPEG }

  { create the resulting JPEG image }
  result:=TJPEGImage.Create;

  { create a temporary bitmap }
  tmpBitmap:=APanel.TeeCreateBitmap(APanel.Color,
                       TeeRect(Left,Top,Left+Width,Top+Height),
                       TeePixelFormat);

  try
    { set the desired JPEG options... }
    With result do
    begin
      GrayScale            :=Params.GrayScale;
      ProgressiveEncoding  :=Params.ProgressiveEncoding;
      CompressionQuality   :=Params.CompressionQuality;
      PixelFormat          :=Params.PixelFormat;
      ProgressiveDisplay   :=Params.ProgressiveDisplay;
      Performance          :=Params.Performance;
      Scale                :=Params.Scale;
      Smoothing            :=Params.Smoothing;

      { Copy the temporary Bitmap onto the JPEG image... }
      Assign(tmpBitmap);
    end;
  finally
    tmpBitmap.Free;  { <-- free the temporary Bitmap }
  end;
end;

{ This function creates a JPEG Image, sets the desired JPEG
  parameters, draws a Chart (or TeeTree) on it, Saves the JPEG on disk and
  Loads the JPEG from disk to show it on this Form. }
procedure TeeSaveToJPEGFile( APanel:TCustomTeePanel;
                             Const FileName: WideString;
                             Gray: WordBool;
                             Performance: TJPEGPerformance;
                             Quality, AWidth, AHeight: Integer);
var tmp       : String;
    tmpWidth,
    tmpHeight : Integer;
    Params    : TJPEGDefaults;
begin
  { verify filename extension }
  tmp:=FileName;
  if ExtractFileExt(tmp)='' then tmp:=tmp+'.jpg';

  { Set the JPEG params }
  Params:=JPEGDefaults;

  Params.GrayScale:=Gray;
  Params.CompressionQuality:=Quality;
  Params.Performance:=Performance;

  if AWidth<=0 then tmpWidth:=APanel.Width
               else tmpWidth:=AWidth;
  if AHeight<=0 then tmpHeight:=APanel.Height
                else tmpHeight:=AHeight;

  { Create the JPEG with the Chart image }
  With TeeGetJPEGImageParams(APanel,Params,0,0,tmpWidth,tmpHeight) do
  try
    SaveToFile(tmp);    { <-- save the JPEG to disk }
  finally
    Free;  { <-- free the temporary JPEG object }
  end;
end;

procedure TeeSaveToJPEG( APanel:TCustomTeePanel;
                         Const FileName: WideString;
                         AWidth, AHeight: Integer);
begin
  TeeSaveToJPEGFile(APanel,FileName,False,jpBestQuality,100,AWidth,AHeight);
end;

function TJPEGExportFormat.Description:String;
begin
  result:=TeeMsg_AsJPEG;
end;

function TJPEGExportFormat.FileExtension: String;
begin
  result:='jpg';
end;

function TJPEGExportFormat.FileFilter:String;
begin
  result:=TeeMsg_JPEGFilter;
end;

Function TJPEGExportFormat.Jpeg:TJPEGImage;
var Params : TJPEGDefaults;
begin
  { returns a JPEG image using the "Panel" (Chart) property }
  if not Assigned(Panel) then
     Raise Exception.Create(TeeMsg_ExportPanelNotSet);

  CheckProperties;

  { set JPEG options }
  Params:=JPEGDefaults;

  Params.GrayScale:=FProperties.CBGray.Checked;
  Params.CompressionQuality:=FProperties.UpDown1.Position;
  Params.Performance:=TJPEGPerformance(FProperties.RGPerf.ItemIndex);

  CheckSize;

  { obtain a JPEG image using parameters }
  result:=TeeGetJPEGImageParams(Panel,Params,0,0,Width,Height);
end;

Procedure TJPEGExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
     FProperties:=TTeeJPEGOptions.Create(nil);
end;

Function TJPEGExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TJPEGExportFormat.DoCopyToClipboard;
var tmp : TJPEGImage;
begin
  tmp:=Jpeg;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TJPEGExportFormat.SaveToStream(Stream:TStream);
begin
  With Jpeg do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

procedure TTeeJPEGOptions.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

function TJPEGExportFormat.GetQuality: Integer;
begin
  Options;
  result:=FProperties.UpDown1.Position;
end;

procedure TJPEGExportFormat.SetQuality(const Value: Integer);
begin
  Options;
  FProperties.UpDown1.Position:=Value;
end;

destructor TJPEGExportFormat.Destroy;
begin
//  FreeAndNil(FProperties);  ?? 6.02
  inherited;
end;

initialization
  RegisterTeeExportFormat(TJPEGExportFormat);
finalization
  UnRegisterTeeExportFormat(TJPEGExportFormat);
end.
