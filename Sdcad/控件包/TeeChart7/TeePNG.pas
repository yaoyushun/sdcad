{*******************************************************}
{  TeeChart PNG Graphic Format                          }
{  Copyright (c) 2000-2004 by David Berneda             }
{  All Rights Reserved                                  }
{                                                       }
{  Windows systems:                                     }
{  The LPng.DLL is required in \Windows\System folder   }
{*******************************************************}
unit TeePNG;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QComCtrls, QStdCtrls, QControls, QGraphics, QForms, Qt,
  {$ELSE}
  Forms, Graphics, ComCtrls, Controls, StdCtrls,
  {$ENDIF}
  SysUtils, Classes, TeeProcs, TeeExport, TeCanvas;

type
  TPNGExportFormat=class;

  TTeePNGOptions = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    IFormat : TPNGExportFormat;
  public
    { Public declarations }
  end;

  {$IFNDEF CLR}
  {$IFNDEF LINUX}
  TPicData = record
    Stream   : TMemoryStream;
    APtr     : Pointer;
    BLineWidth,
    LineWidth,
    Width,
    Height   : Integer;
  end;
  {$ENDIF}
  {$ENDIF}

  TPNGExportFormat=class(TTeeExportFormat)
  private
    FCompression : Integer;
    FPixel       : TPixelFormat;

    {$IFNDEF LINUX}
    {$IFNDEF CLR}
    PicData : TPicData;
    RowPtrs : PByte;
    SaveBuf : Array[0..8192] of Byte;
    {$ENDIF}
    {$ENDIF}

    Procedure CheckProperties;
    Procedure SetCompression(const Value:Integer);
  protected
    FProperties: TTeePNGOptions;
    Procedure DoCopyToClipboard; override;
  public
    Constructor Create; override;

    Function Bitmap:TBitmap;
    property Compression:Integer read FCompression write SetCompression;
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function Options(Check:Boolean=True):TForm; override;
    property PixelFormat:TPixelFormat read FPixel write FPixel;
    procedure SaveToStream(AStream:TStream); override;
    procedure SaveToStreamCompression(AStream:TStream; CompressionLevel:Integer);
  end;

Procedure TeeSaveToPNG( APanel:TCustomTeePanel;
                        Const AFileName: WideString;
                        AWidth:Integer=0;
                        AHeight:Integer=0);

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
     {$IFDEF TEEOCX}
     SyncObjs,
     {$ENDIF}
     TeeConst;


Procedure TeeSaveToPNG( APanel:TCustomTeePanel;
                        Const AFileName: WideString;
                        AWidth:Integer=0;
                        AHeight:Integer=0);
begin
  with TPNGExportFormat.Create do
  try
    Panel:=APanel;
    if AWidth=0 then Width:=Panel.Width
                else Width:=AWidth;
    if AHeight=0 then Height:=Panel.Height
                 else Height:=AHeight;
    SaveToFile(AFileName);
  finally
    Free;
  end;
end;

Const TeePNG_DefaultCompressionLevel=9;

{$IFDEF TEEOCX}
var PNGSection : TCriticalSection;
{$ENDIF}

{$IFNDEF LINUX}
{$IFNDEF CLR}
type
   TPng_Row_Info=record
     width            : Cardinal;
     rowbytes         : Cardinal;
     color_type       : Byte;
     bit_depth        : Byte;
     channels         : Byte;
     pixel_depth      : Byte;
   end;
   PPng_Row_Info=^TPng_Row_Info;

   TPng_Color=record
     red              : Byte;
     green            : Byte;
     blue             : Byte;
   end;
   PPng_Color=^TPng_Color;

   TPng_Color_16=record
     index: Byte;
     red:   Word;
     green: Word;
     blue:  Word;
     gray:  Word;
   end;
   PPng_Color_16=^TPng_Color_16;

   PPWord     = ^PWord;

   TPng_Color_8=record
     red:   Byte;
     green: Byte;
     blue:  Byte;
     gray:  Byte;
     alpha: Byte;
   end;
   PPng_Color_8  = ^TPng_Color_8;

   TPng_Struct=record
     jmpbuf           : Array[0..10] of Integer;
     error_fn         : Pointer;
     warning_fn       : Pointer;
     error_ptr        : Pointer;
     write_data_fn    : Pointer;
     read_data_fn     : Pointer;
     read_user_transform_fn: Pointer;
     write_user_transform_fn: Pointer;
     io_ptr           : Integer;

     mode             : Cardinal;
     flags            : Cardinal;
     transformations  : Cardinal;

     zstream          : Pointer;
     zbuf             : PByte;
     zbuf_size        : Integer;
     zlib_level       : Integer;
     zlib_method      : Integer;
     zlib_window_bits : Integer;
     zlib_mem_level   : Integer;
     zlib_strategy    : Integer;

     width            : Cardinal;
     height           : Cardinal;
     num_rows         : Cardinal;
     usr_width        : Cardinal;
     rowbytes         : Cardinal;
     irowbytes        : Cardinal;
     iwidth           : Cardinal;
     row_number       : Cardinal;
     prev_row         : PByte;
     row_buf          : PByte;
     sub_row          : PByte;
     up_row           : PByte;
     avg_row          : PByte;
     paeth_row        : PByte;
     row_info         : TPng_Row_Info;

     idat_size        : Cardinal;
     crc              : Cardinal;
     palette          : PPng_Color;
     num_palette      : Word;
     num_trans        : Word;
     chunk_name       : Array[0..4] of Byte;
     compression      : Byte;
     filter           : Byte;
     interlaced       : Byte;
     pass             : Byte;
     do_filter        : Byte;
     color_type       : Byte;
     bit_depth        : Byte;
     usr_bit_depth    : Byte;
     pixel_depth      : Byte;
     channels         : Byte;
     usr_channels     : Byte;
     sig_bytes        : Byte;

     filler           : Byte;
     background_gamma_type: Byte;
     background_gamma : Single;
     background       : TPng_Color_16;
     background_1     : TPng_Color_16;
     output_flush_fn  : Pointer;
     flush_dist       : Cardinal;
     flush_rows       : Cardinal;
     gamma_shift      : Integer;
     gamma            : Single;      
     screen_gamma     : Single;   
     gamma_table      : PByte;    
     gamma_from_1     : PByte;
     gamma_to_1       : PByte;    
     gamma_16_table   : PPWord; 
     gamma_16_from_1  : PPWord;
     gamma_16_to_1    : PPWord;
     sig_bit          : TPng_Color_8;  
     shift            : TPng_Color_8;
     trans            : PByte;         
     trans_values     : TPng_Color_16;
     read_row_fn      : Pointer;
     write_row_fn     : Pointer;
     info_fn          : Pointer;
     row_fn           : Pointer;
     end_fn           : Pointer; 
     save_buffer_ptr  : PByte;   
     save_buffer      : PByte;   
     current_buffer_ptr: PByte;
     current_buffer   : PByte;   
     push_length      : Cardinal;
     skip_length      : Cardinal;
     save_buffer_size : Integer; 
     save_buffer_max  : Integer;
     buffer_size      : Integer;
     current_buffer_size: Integer;  
     process_mode     : Integer;
     cur_palette      : Integer;
     current_text_size: Integer;  
     current_text_left: Integer;
     current_text     : PByte;
     current_text_ptr : PByte;    
     palette_lookup   : PByte;    
     dither_index     : PByte;
     hist             : PWord;
     heuristic_method : Byte;
     num_prev_filters : Byte;
     prev_filters     : PByte;    
     filter_weights   : PWord;    
     inv_filter_weights: PWord;
     filter_costs     : PWord;
     inv_filter_costs : PWord;
     time_buffer      : PByte;
  end;
  PPng_Struct = ^TPng_Struct;
  PPPng_Struct = ^PPng_Struct;

  TPng_Text = record
     compression: Integer;
     key:         PChar;    
     text:        PChar;
     text_length: Integer;
  end;
  PPng_Text  = ^TPng_Text;

  TPng_Time = record
     year:   Word; 
     month:  Byte; 
     day:    Byte;
     hour:   Byte;
     minute: Byte;
     second: Byte;
  end;
  PPng_Time  = ^TPng_Time;

  PPChar     = ^PChar;

  TPng_Info = record
     width:            Cardinal;  
     height:           Cardinal;  
     valid:            Cardinal;  
     rowbytes:         Cardinal;
     palette:          PPng_Color;
     num_palette:      Word;
     num_trans:        Word;      
     bit_depth:        Byte;
     color_type:       Byte;
     compression_type: Byte;      
     filter_type:      Byte;      
     interlace_type:   Byte;

     channels:     Byte;
     pixel_depth:  Byte;
     spare_byte:   Byte;
     signature: array[0..7] of Byte;

     gamma: Single;
     srgb_intent: Byte;
     num_text: Integer;
     max_text: Integer;
     text:     PPng_Text;
     mod_time: TPng_Time;
     sig_bit: TPng_Color_8;
     trans: PByte;
     trans_values: TPng_Color_16;
     background: TPng_Color_16;
     x_offset:         Cardinal;
     y_offset:         Cardinal;
     offset_unit_type: Byte;
     x_pixels_per_unit: Cardinal;
     y_pixels_per_unit: Cardinal;
     phys_unit_type:    Byte;
     hist: PWord;
     x_white: Single;
     y_white: Single;
     x_red:   Single;
     y_red:   Single;
     x_green: Single;
     y_green: Single;
     x_blue:  Single;
     y_blue:  Single;

     pcal_purpose: PChar;
     pcal_X0:      Integer;
     pcal_X1:      Integer;
     pcal_units:   PChar;
     pcal_params:  PPChar;
     pcal_type:    Byte;
     pcal_nparams: Byte;
  end;
  PPng_Info = ^TPng_Info;
  PPPng_Info = ^PPng_Info;

  PPByte     = ^PByte;

  png_rw_ptr = procedure(png_ptr: Pointer; var Data: Pointer; Length: Cardinal); stdcall;
  png_flush_ptr = procedure(png_ptr: Pointer); stdcall;


Var png_create_write_struct: function(user_png_ver: PChar;
                             error_ptr, error_fn, warn_fn: Pointer): PPng_Struct; stdcall;
    png_create_info_struct : function(png_ptr: PPng_Struct): PPng_Info; stdcall;
    png_set_compression_level:procedure(png_ptr: Ppng_struct; Level: Integer); stdcall;
    png_set_write_fn       : procedure(png_ptr: PPng_Struct;
                                     io_ptr: Pointer; write_data_fn: png_rw_ptr;
                                     output_flush_fn: png_flush_ptr); stdcall;
    png_set_write_status_fn: procedure(png_ptr: PPng_Struct;
                             write_row_fn: Pointer); stdcall;
    png_set_IHDR           : procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info;
                             width, height: Cardinal; bit_depth, color_type, interlace_type,
                             compression_type, filter_type: Integer); stdcall;
    png_write_info         : procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info); stdcall;
    png_write_image        : procedure(png_ptr: PPng_Struct; image: PPByte); stdcall;
    png_write_end          : procedure(png_ptr: PPng_Struct; info_ptr: PPng_Info); stdcall;
    png_write_flush        : procedure(png_ptr: PPng_Struct); stdcall;
    png_destroy_write_struct : procedure(png_ptr_ptr: PPPng_Struct;
                               info_ptr_ptr: PPPng_Info); stdcall;

    PngLib : HINST=0;

const PNG_LIBPNG_VER_STRING =  '1.0.1';
      PNG_COLOR_TYPE_RGB:        Integer = 2;
      PNG_INTERLACE_NONE:  Integer = 0;
      PNG_COMPRESSION_TYPE_DEFAULT: Integer = 0;
      PNG_FILTER_TYPE_DEFAULT: Integer = 0;

var IStream : TStream;

procedure LoadProcs;
begin
  png_create_write_struct :=GetProcAddress(PngLib,'png_create_write_struct');
  png_create_info_struct  :=GetProcAddress(PngLib,'png_create_info_struct');
  png_set_compression_level:=GetProcAddress(PngLib,'png_set_compression_level');
  png_set_write_fn        :=GetProcAddress(PngLib,'png_set_write_fn');
  png_set_write_status_fn :=GetProcAddress(PngLib,'png_set_write_status_fn');
  png_set_IHDR            :=GetProcAddress(PngLib,'png_set_IHDR');
  png_write_info          :=GetProcAddress(PngLib,'png_write_info');
  png_write_image         :=GetProcAddress(PngLib,'png_write_image');
  png_write_end           :=GetProcAddress(PngLib,'png_write_end');
  png_write_flush         :=GetProcAddress(PngLib,'png_write_flush');
  png_destroy_write_struct:=GetProcAddress(PngLib,'png_destroy_write_struct');
end;
{$ENDIF}
{$ENDIF}

Constructor TPNGExportFormat.Create;
begin
  inherited;
  FCompression:=TeePNG_DefaultCompressionLevel;
  FPixel:={$IFDEF CLX}pf32Bit{$ELSE}pfDevice{$ENDIF};
end;

function TPNGExportFormat.Description:String;
begin
  result:=TeeMsg_AsPNG;
end;

function TPNGExportFormat.FileFilter:String;
begin
  result:=TeeMsg_PNGFilter;
end;

function TPNGExportFormat.FileExtension:String;
begin
  result:='PNG';
end;

Function TPNGExportFormat.Bitmap:TBitmap;
begin
  result:=Panel.TeeCreateBitmap(Panel.Color,TeeRect(0,0,Width,Height),FPixel);
end;

procedure TPNGExportFormat.DoCopyToClipboard;
var tmp : TBitmap;
begin
  tmp:=Bitmap;
  try
    Clipboard.Assign(tmp);
  finally
    tmp.Free;
  end;
end;

Procedure TPNGExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TTeePNGOptions.Create(nil);
    FProperties.IFormat:=Self;
    FProperties.UpDown1.Position:=FCompression;
  end;
end;

Procedure TPNGExportFormat.SetCompression(const Value:Integer);
begin
  FCompression:=Value;
  if Assigned(FProperties) then
     FProperties.UpDown1.Position:=FCompression;
end;

Function TPNGExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

{$IFNDEF LINUX}
{$IFNDEF CLR}
Const PNGDLL='LPng.dll';

Procedure InitPngLib;
begin
  PngLib:=TeeLoadLibrary(PNGDll);
  if PngLib=0 then raise Exception.Create('Library '+PNGDLL+' cannot be loaded.');
end;

procedure WriteImageStream(png_ptr: Pointer; var Data: Pointer; Length: Cardinal); stdcall;
begin
  IStream.WriteBuffer(Data,Length);
end;

procedure FlushImageStream(png_ptr: Pointer); stdcall;
begin
end;

procedure TPNGExportFormat.SaveToStreamCompression(AStream:TStream; CompressionLevel:Integer);
var Data : PByte;
    FBytesPerPixel: Integer;

  Procedure SetBitmapStream(Bitmap:TBitmap; var PicData:TPicData);
  var DC : HDC;
  begin
    PicData.Stream.Clear;
    PicData.Stream.SetSize(SizeOf(TBITMAPINFOHEADER)+ Bitmap.Height*(Bitmap.Width+4)*3);
    With TBITMAPINFOHEADER(PicData.Stream.Memory^) do
    Begin
      biSize := SizeOf(TBITMAPINFOHEADER);
      biWidth := Bitmap.Width;
      biHeight := Bitmap.Height;
      biPlanes := 1;
      biBitCount := 24;
      biCompression := bi_RGB;
      biSizeImage := 0;
      biXPelsPerMeter :=1;
      biYPelsPerMeter :=1;
      biClrUsed :=0;
      biClrImportant :=0;
    end;

    PicData.Aptr:=Pchar(PicData.Stream.Memory)+SizeOf(TBITMAPINFOHEADER);
    DC:=GetDC(0);
    try
      GetDIBits(DC, {$IFDEF CLX}QPixmap_hbm{$ENDIF}(Bitmap.Handle), 0, Bitmap.Height, PicData.Aptr,
                TBITMAPINFO(PicData.Stream.Memory^), dib_RGB_Colors);
    finally
      ReleaseDC(0,DC);
    end;

    With PicData do
    begin
      Width      :=Bitmap.Width;
      Height     :=Bitmap.Height;
      LineWidth  :=Bitmap.Width*3;
      LineWidth  :=((LineWidth+3) div 4)*4;
      BLineWidth :=Bitmap.Height*3;
      BLineWidth :=((BLineWidth+3) div 4)*4;
    end;
  end;

  procedure Init;
  type PCardinal  = ^Cardinal;
  var CValuep : PCardinal;
      y       : Integer;
  begin
    CValuep:=Pointer(RowPtrs);
    for y:=0 to PicData.Height-1 do
    begin
      CValuep^:=Cardinal(Data)+Cardinal(PicData.Width*FBytesPerPixel*y);
      Inc(CValuep);
    end;
  end;

  Procedure CopyImage;
  var x : Integer;
      y : Integer;
      AktPicP,
      AktP     : PChar;
  begin
    for y:=0 to PicData.Height-1 do
      for x:=0 to PicData.Width-1 do
      begin
        AktPicP:=PChar(PicData.Aptr) +  y*PicData.LineWidth + x*3;
        AktP:=PChar(Data) +  (PicData.Height-1-y)*(FBytesPerPixel*PicData.Width) + x*FBytesPerPixel;
        BYTE((AktP+0)^):=BYTE((AktPicP+2)^);
        BYTE((AktP+1)^):=BYTE((AktPicP+1)^);
        BYTE((AktP+2)^):=BYTE((AktPicP+0)^);
      end;
  end;

  Procedure GetMemory;
  begin
    GetMem(Data,PicData.Height*PicData.Width*FBytesPerPixel);
    GetMem(RowPtrs, SizeOf(Pointer)*PicData.Height);
  end;

  Procedure FreeMemory;
  begin
    if Assigned(Data) then FreeMem(Data);
    if Assigned(RowPtrs) then FreeMem(RowPtrs);
  end;

  Procedure DoSaveToStream;
  var png     : PPng_Struct;
      pnginfo : PPng_Info;
      tmp     : Array[0..32] of Char;
  begin
    IStream:=AStream;
    tmp:=PNG_LIBPNG_VER_STRING;
    png:=png_create_write_struct(tmp, nil, nil, nil);
    if Assigned(png) then
    try
      pnginfo:=png_create_info_struct(png);
      png_set_write_fn(png, @SaveBuf, WriteImageStream, FlushImageStream);
      png_set_write_status_fn(png, nil);

      png_set_IHDR(png, pnginfo, PicData.Width, PicData.Height, 8,
                   PNG_COLOR_TYPE_RGB,
                   PNG_INTERLACE_NONE,
                   PNG_COMPRESSION_TYPE_DEFAULT,
                   PNG_FILTER_TYPE_DEFAULT);

      png_write_info(png, pnginfo);

      {$IFNDEF TEEOCX}
      if CompressionLevel=-1 then
         CompressionLevel:=FProperties.UpDown1.Position;
      {$ENDIF}

      png_set_compression_level(png,CompressionLevel);
      png_write_image(png, PPByte(RowPtrs));
      png_write_end(png, pnginfo);
      png_write_flush(png);
    finally
      png_destroy_write_struct(@png, @pnginfo);
    end;
    IStream:=nil;
  end;

var tmpBitmap : TBitmap;
begin
  { delayed load of LPNG.DLL procedure addresses }
  if PngLib=0 then InitPngLib;
  if not Assigned(png_create_write_struct) then LoadProcs;

  CheckSize;
  PicData.Stream:=TMemoryStream.Create;
  try
    tmpBitmap:=Bitmap;
    try
      SetBitmapStream(tmpBitmap,PicData); { 5.01 }

      FBytesPerPixel:=3;
      GetMemory;
      try
        Init;
        CopyImage;

        {$IFDEF TEEOCX}
        PNGSection.Enter;
        {$ENDIF}

        DoSaveToStream;

        {$IFDEF TEEOCX}
        PNGSection.Leave;
        {$ENDIF}
      finally
        FreeMemory;
      end;
    finally
      tmpBitmap.Free;
    end;
  finally
    PicData.Stream.Free;
  end;
end;

procedure ClearProcs;
begin
  png_create_write_struct :=nil;
  png_create_info_struct  :=nil;
  png_set_compression_level:=nil;
  png_set_write_fn        :=nil;
  png_set_write_status_fn :=nil;
  png_set_IHDR            :=nil;
  png_write_info          :=nil;
  png_write_image         :=nil;
  png_write_end           :=nil;
  png_write_flush         :=nil;
  png_destroy_write_struct:=nil;
end;

{$ELSE}

// CLR DOTNET

procedure TPNGExportFormat.SaveToStreamCompression(AStream:TStream; CompressionLevel:Integer);
var tmpBitmap : TBitmap;
begin
  CheckSize;
  tmpBitmap:=Bitmap;
  try
    tmpBitmap.SaveToStream(AStream); { pending: convert to PNG }
  finally
    tmpBitmap.Free;
  end;
end;

{$ENDIF}

{$ELSE}

// LINUX:

procedure TPNGExportFormat.SaveToStreamCompression(AStream:TStream; CompressionLevel:Integer);
var tmpBitmap : TBitmap;
begin
  CheckSize;
  tmpBitmap:=Bitmap;
  try
    tmpBitmap.SaveToStream(AStream); { pending: convert to PNG }
  finally
    tmpBitmap.Free;
  end;
end;
{$ENDIF}

procedure TPNGExportFormat.SaveToStream(AStream:TStream);
begin
  CheckProperties;
  SaveToStreamCompression(AStream,FProperties.UpDown1.Position);
end;

procedure TTeePNGOptions.FormCreate(Sender: TObject);
begin
  UpDown1.Position:=TeePNG_DefaultCompressionLevel;
end;

{$IFNDEF LINUX}
{$IFNDEF CLR}
Function FileInPath(Const FileName:String):Boolean;
var tmp : array[0..4095] of Char;
begin
  result:=(GetEnvironmentVariable('PATH',tmp,SizeOf(tmp))>0) and
          (FileSearch(FileName,tmp)<>'');
end;
{$ENDIF}
{$ENDIF}

procedure TTeePNGOptions.Edit1Change(Sender: TObject);
begin
  if Assigned(IFormat) then
     IFormat.FCompression:=UpDown1.Position;
end;

initialization
  {$IFNDEF LINUX}
  {$IFNDEF CLR}
    {$IFDEF TEEOCX}
    if not Assigned(PNGSection) then
       PNGSection:=TCriticalSection.Create;
    {$ENDIF}
  if FileInPath(PNGDLL) then
  {$ENDIF}
  {$ENDIF}
     RegisterTeeExportFormat(TPNGExportFormat);
finalization
  UnRegisterTeeExportFormat(TPNGExportFormat);
  {$IFNDEF LINUX}
  {$IFNDEF CLR}
    {$IFDEF TEEOCX}
    if Assigned(PNGSection) then PNGSection.Free;
    {$ENDIF}
  if PngLib>0 then
  begin
    TeeFreeLibrary(PngLib);
    PngLib:=0;
    ClearProcs;
  end;
  {$ENDIF}
  {$ENDIF}
end.
