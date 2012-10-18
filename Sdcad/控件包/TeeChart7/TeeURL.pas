{******************************************}
{   TeeChart Pro  - URL files retrieval    }
{ Copyright (c) 1995-2004 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeURL;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, Chart, TeEngine;

type
  TChartWebSource = class(TComponent)
  private
    { Private declarations }
    FChart : TCustomChart;
    FURL   : String;
    procedure SetChart(const Value: TCustomChart);
  protected
    { Protected declarations }
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Procedure Execute;
  published
    { Published declarations }
    property Chart:TCustomChart read FChart write SetChart;
    property URL:String read FURL write FURL;
  end;

  { Series Source with FileName property }
  TTeeSeriesSourceFile=class(TTeeSeriesSource)
  private
    FFileName : String;
    procedure SetFileName(const Value: String);
  public
    Procedure Load; override;
    Procedure LoadFromFile(Const AFileName:String);
    Procedure LoadFromStream(AStream:TStream); virtual;
    Procedure LoadFromURL(Const AURL:String);

    property FileName:String read FFileName write SetFileName;
  end;

{ Read a Chart from a file (ie: Chart1,'http://www.steema.com/demo.tee' ) }
Procedure LoadChartFromURL(Var AChart:TCustomChart; Const URL:String);

Function DownloadURL(AURL:{$IFDEF CLR}string{$ELSE}PChar{$ENDIF}; ToStream:TStream): HResult;

// Returns True when St parameter contains a web address (http or ftp)
Function TeeIsURL(St:String):Boolean;

{ Returns a string with the error message from WinInet.dll.
  The Parameter ErrorCode is the result of the DownloadURL function. }
function TeeURLErrorMessage(ErrorCode: Integer): string;  { 5.01 }

{$IFNDEF CLR}
{$IFNDEF CLX}
{ The Windows Handle to WinInet.dll. 0=not opened yet. }
var TeeWinInetDLL:THandle=0;   // 5.01
{$ENDIF}
{$ENDIF}

implementation

Uses
  {$IFDEF CLX}
  Types,
  {$IFNDEF LINUX}
  IdHTTP,
  {$ENDIF}
  {$ENDIF}
  {$IFDEF CLR}
  System.Text, System.Net, System.IO,
  {$ENDIF}
  TeCanvas, TeeProcs, SysUtils, TeeConst, TeeStore;

Procedure LoadChartFromURL(Var AChart:TCustomChart; Const URL:String);
var tmp    : Integer;
    R      : TRect;
    Stream : TMemoryStream;
    tmpURL : String;
begin
  Stream:=TMemoryStream.Create;
  try
    tmpURL:=URL;
    tmp:=DownloadURL({$IFNDEF CLR}PChar{$ENDIF}(tmpURL),Stream);
    if tmp=0 then
    begin
      R:=AChart.BoundsRect;
      Stream.Position:=0; { 5.01 }
      LoadChartFromStream(TCustomChart(AChart),Stream);

      if csDesigning in AChart.ComponentState then
         AChart.BoundsRect:=R;
    end
    else
      Raise ChartException.CreateFmt(TeeMsg_CannotLoadChartFromURL,
                                   [tmp,#13+URL+#13+TeeURLErrorMessage(tmp)]);
  finally
    Stream.Free;
  end;
end;

{$IFNDEF CLX}
Const INTERNET_OPEN_TYPE_PRECONFIG = 0;
      INTERNET_FLAG_RAW_DATA       = $40000000;  { receive the item as raw data }
      INTERNET_FLAG_NO_CACHE_WRITE = $04000000;  { do not write this item to the cache }
      INTERNET_FLAG_DONT_CACHE     = INTERNET_FLAG_NO_CACHE_WRITE;
      WININET_API_FLAG_SYNC        = $00000004;  { force sync operation }
      INTERNET_FLAG_RELOAD         = $80000000;  { retrieve the original item }
      INTERNET_FLAG_HYPERLINK      = $00000400;  { asking wininet to do hyperlinking semantic which works right for scripts }
      INTERNET_FLAG_PRAGMA_NOCACHE = $00000100;  { asking wininet to add "pragma: no-cache" }

type
  HINTERNET = Pointer;

{$IFNDEF CLR}
var
   _InternetOpenA:function(lpszAgent: PAnsiChar; dwAccessType: DWORD;
                          lpszProxy, lpszProxyBypass: PAnsiChar;
                          dwFlags: DWORD): HINTERNET; stdcall;

   _InternetOpenURLA:function(hInet: HINTERNET; lpszUrl: PAnsiChar;
                         lpszHeaders: PAnsiChar; dwHeadersLength: DWORD; dwFlags: DWORD;
                         dwContext: DWORD): HINTERNET; stdcall;

  _InternetReadFile:function(hFile: HINTERNET; lpBuffer: Pointer;
                         dwNumberOfBytesToRead: DWORD;
                         var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall;

  _InternetCloseHandle:function(hInet: HINTERNET): BOOL; stdcall;
{$ENDIF}

{$IFNDEF CLR}
procedure InitWinInet;
begin
  if TeeWinInetDLL=0 then
  begin
    TeeWinInetDLL:=TeeLoadLibrary('wininet.dll');
    if TeeWinInetDLL<>0 then
    begin
      @_InternetOpenA      :=GetProcAddress(TeeWinInetDLL,'InternetOpenA');
      @_InternetOpenURLA   :=GetProcAddress(TeeWinInetDLL,'InternetOpenUrlA');
      @_InternetReadFile   :=GetProcAddress(TeeWinInetDLL,'InternetReadFile');
      @_InternetCloseHandle:=GetProcAddress(TeeWinInetDLL,'InternetCloseHandle');
    end;
  end;
end;
{$ENDIF}

(*
function InternetSetStatusCallback(hInet: HINTERNET;
  lpfnInternetCallback: PFNInternetStatusCallback): PFNInternetStatusCallback; stdcall;
*)

Function DownloadURL(AURL:{$IFDEF CLR}string{$ELSE}PChar{$ENDIF}; ToStream:TStream): HResult;
Const MaxSize= 128*1024;

var
{$IFNDEF CLR}
    H1  : HINTERNET;
    H2  : HINTERNET;
    Buf : Pointer;
    tmp : Boolean;
    r   : DWord;
{$ELSE}
    tmpClient : WebClient;
    Buf       : Array of Byte;
{$ENDIF}
begin
  {$IFDEF CLR}

  tmpClient:=WebClient.Create;
  Buf:=tmpClient.DownloadData(AURL);
  if Length(Buf)>0 then
  begin
    ToStream.Write(Buf,Length(Buf));
    ToStream.Position:=0;
    result:=0;
  end
  else result:=-1;

  {$ELSE}
  {$IFDEF D5}
  result:=-1;
  {$ELSE}
  result:=$80000000;
  {$ENDIF}
  if TeeWinInetDLL=0 then InitWinInet;
  if TeeWinInetDLL<>0 then
  begin
    h1:=_InternetOpenA('Tee', INTERNET_OPEN_TYPE_PRECONFIG,
                              nil,nil,
                              WININET_API_FLAG_SYNC{ INTERNET_FLAG_DONT_CACHE 5.02 });
    if h1<>nil then
    try
      h2:=_InternetOpenUrlA(h1, AURL, nil,$80000000,
                              { INTERNET_FLAG_DONT_CACHE or 5.02 }
                              INTERNET_FLAG_RELOAD or
                              INTERNET_FLAG_NO_CACHE_WRITE or
                              INTERNET_FLAG_HYPERLINK or
                              INTERNET_FLAG_PRAGMA_NOCACHE

                              ,
                              {INTERNET_FLAG_EXISTING_CONNECT}
                              0);


      if h2<>nil then
      try
        ToStream.Position:=0;
        Buf:=AllocMem(MaxSize);
        try
          Repeat
            r:=0;
            tmp:=_InternetReadFile(h2,Buf,MaxSize,r);
            if tmp then
            begin
              if r>0 then ToStream.WriteBuffer(Buf^,r)
              else
              begin
                ToStream.Position:=0;
                result:=0;
                break;
              end;
            end
            else result:=GetLastError;
          Until r=0;
        finally
          FreeMem(Buf,MaxSize);
        end;
      finally
        if not _InternetCloseHandle(h2) then result:=GetLastError;
      end
      else result:=GetLastError;
    finally
      if not _InternetCloseHandle(h1) then result:=GetLastError;
    end
    else result:=GetLastError;
  end
  else ShowMessageUser('Cannot load WinInet.dll to access TeeChart file: '+AURL);
  {$ENDIF}
end;

{$ELSE}

Function DownloadURL(AURL:PChar; ToStream:TStream): HResult;
begin
  {$IFDEF LINUX}
  result:=-1;
  {$ELSE}
  With TIdHttp.Create(nil) do
  try
    Get(string(AURL),ToStream);
    ToStream.Position:=0;
    result:=0;
  finally
    Free;
  end;
  {$ENDIF}
end;
{$ENDIF}

function TeeURLErrorMessage(ErrorCode: Integer): string;
{$IFNDEF CLX}
var
  Len    : Integer;
  Buffer : {$IFDEF CLR}StringBuilder{$ELSE}TeeString256{$ENDIF};
{$ENDIF}
begin
  {$IFDEF CLX}
  result:=IntToStr(ErrorCode);
  {$ELSE}

  {$IFDEF CLR}
  Buffer:=StringBuilder.Create(256);
  Len:=0;
  {$ENDIF}

  {$IFNDEF CLR}
  Len := FormatMessage(FORMAT_MESSAGE_FROM_HMODULE or
                       FORMAT_MESSAGE_ARGUMENT_ARRAY,
                       {$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF}(TeeWinInetDLL),
                       ErrorCode, 0, Buffer,
                       SizeOf(Buffer), nil);
  while (Len > 0) and ({$IFDEF CLR}AnsiChar{$ENDIF}(Buffer[Len - 1]) in [#0..#32, '.']) do Dec(Len);
  {$ENDIF}

  {$IFDEF CLR}
  result:=Buffer.ToString(0,Len);
  {$ELSE}
  SetString(result, Buffer, Len);
  {$ENDIF}
  {$ENDIF}
end;

// Returns True when "St" is suspicious to contain a web address...
Function TeeIsURL(St:String):Boolean;
begin
  St:=UpperCase(Trim(St));
  result:=(Pos('HTTP://',St)>0) or (Pos('FTP://',St)>0);
end;

{ TTeeSeriesSourceFile }
Procedure TTeeSeriesSourceFile.Load;
begin
  if Assigned(Series) and (FileName<>'') then
     if TeeIsURL(FileName) then LoadFromURL(FileName)
                           else LoadFromFile(FileName);
end;

procedure TTeeSeriesSourceFile.SetFileName(const Value: String);
begin
  if FFileName<>Value then
  begin
    Close;
    FFileName:=Value;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromFile(const AFileName: String);
var tmp : TFileStream;
begin
  tmp:=TFileStream.Create(AFileName,fmOpenRead);
  try
    LoadFromStream(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromURL(const AURL: String);
var Stream : TMemoryStream;
    tmpURL : String;
    tmp    : Integer;
begin
  Stream:=TMemoryStream.Create;
  try
    tmpURL:=AURL;
    tmp:=DownloadURL({$IFNDEF CLR}PChar{$ENDIF}(tmpURL),Stream);
    if tmp=0 then LoadFromStream(Stream)
    else
      Raise ChartException.CreateFmt(TeeMsg_CannotLoadSeriesDataFromURL,
          [tmp,AURL+' '+TeeURLErrorMessage(tmp)]);
  finally
    Stream.Free;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromStream(AStream: TStream);
begin
  if not Assigned(Series) then
     Raise Exception.Create(TeeMsg_NoSeriesSelected);
end;

{ TChartWebSource }
Constructor TChartWebSource.Create(AOwner: TComponent);
begin
  inherited {$IFDEF CLR}Create(AOwner){$ENDIF};
  FURL:=TeeMsg_DefaultDemoTee;
end;

procedure TChartWebSource.Execute;
begin
  if Assigned(FChart) and (FURL<>'') then LoadChartFromURL(FChart,FURL);
end;

procedure TChartWebSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

procedure TChartWebSource.SetChart(const Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then FChart.RemoveFreeNotification(Self);
    {$ENDIF}
    FChart:=Value;
    if Assigned(FChart) then FChart.FreeNotification(Self);
  end;
end;

{$IFNDEF CLR}
{$IFNDEF CLX}
initialization
  {$IFDEF C3}
  TeeWinInetDLL:=0; { <-- BCB3 crashes in Win95 if we do not do this... }
  {$ENDIF}
finalization
  if TeeWinInetDLL<>0 then TeeFreeLibrary(TeeWinInetDLL);
{$ENDIF}
{$ENDIF}
end.

