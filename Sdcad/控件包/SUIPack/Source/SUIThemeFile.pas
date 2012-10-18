////////////////////////////////////////////////////////////////////////////////
//
//  FileName    :   SUIThemeFile.pas
//  Creator     :   Shen Min
//  Date        :   2003-05-14
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIThemeFile;

interface

{$I SUIPack.inc}

uses Classes, SysUtils;

type
    TsuiThemeFileWriter = class
    private
        m_ThemeFileName : String;
        m_FileList : Tstrings;
        m_IntegerList : TStrings;
        m_BooleanList : TStrings;
        m_StrList : TStrings;

        procedure Save();

    public
        constructor Create(ThemeFile : String);
        destructor Destroy(); override;

        procedure AddFile(Key, FileName : String);
        procedure AddInteger(Key : String; Value : Integer);
        procedure AddBool(Key : String; Value : Boolean);
        procedure AddStr(Key, Value : String);
    end;

    TsuiThemeFileReader = class
    private
        m_StreamList : TStrings;
        m_IntegerList : TStrings;
        m_BooleanList : TStrings;
        m_StrList : TStrings;

        procedure Load(ThemeFile : String);

    public
        constructor Create(ThemeFile : String);
        destructor Destroy(); override;

        function GetFile(Key : String) : TStream;
        function GetInteger(Key : String) : Integer;
        function GetBool(Key : String) : Boolean;
        function GetStr(Key : String) : String;
    end;

    function IsSUIThemeFile(FileName : String) : Boolean;

implementation

type
    TtbNodeType = (tbntStream, tbntInt, tbntBool, tbntStr);

    TtbThemeBaseFileHeader = packed record
        FileHeader : array [0..11] of Char;
        HeaderSize : Cardinal;
    end;

    TtbThemeFileHeader = packed record
        FileHeader : array [0..11] of Char;
        HeaderSize : Cardinal;
        FormatVer : Integer;
        FirstNode : Cardinal;
    end;

    TtbThemeNodeHeader = packed record
        NodeKey : array [0..63] of Char;
        NodeType : TtbNodeType;
        NodeStart : Cardinal;
        NodeSize : Cardinal;
        NextNode : Cardinal;
    end;

function IsSUIThemeFile(FileName : String) : Boolean;
var
    FileStream : TStream;
    BaseFileHeader : TtbThemeBaseFileHeader;
begin
    Result := false;

    if not FileExists(FileName) then
        Exit;

    // read header
    try
        FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    except
        Exit;
    end;

    try
        FileStream.Read(BaseFileHeader, sizeof(TtbThemeBaseFileHeader));

        Result := (BaseFileHeader.FileHeader = 'SUIPack_TB');
    except
        Result := false;
    end;
    FileStream.Free();
end;

{ TsuiThemeFileWriter }

procedure TsuiThemeFileWriter.AddBool(Key: String; Value: Boolean);
begin
    m_BooleanList.Add(Key + '=' + IntToStr(Ord(Value)));
end;

procedure TsuiThemeFileWriter.AddFile(Key, FileName: String);
begin
    m_FileList.Add(Key + '=' + FileName);
end;

procedure TsuiThemeFileWriter.AddInteger(Key: String; Value: Integer);
begin
    m_IntegerList.Add(Key + '=' + IntToStr(Value));
end;

procedure TsuiThemeFileWriter.AddStr(Key, Value: String);
begin
    m_StrList.Add(Key + '=' + Value);
end;

constructor TsuiThemeFileWriter.Create(ThemeFile: String);
begin
    m_FileList := TStringList.Create();
    m_IntegerList := TStringList.Create();
    m_BooleanList := TStringList.Create();
    m_StrList := TStringList.Create();

    m_ThemeFileName := ThemeFile;
end;

destructor TsuiThemeFileWriter.Destroy;
begin
    Save();

    m_StrList.Free();
    m_BooleanList.Free();
    m_IntegerList.Free();
    m_FileList.Free();
end;

procedure TsuiThemeFileWriter.Save;
var
    FileHeader : TtbThemeFileHeader;
    NodeHeader : TtbThemeNodeHeader;
    FileStream : TFileStream;
    i : Integer;
    nFileSize : Cardinal;
    Stream : TFileStream;
    StrValue : String;
    IntValue : Integer;
    BoolValue : Boolean;
begin
    Stream := TFileStream.Create(m_ThemeFileName, fmCreate or fmShareExclusive);
    // write header
    FileHeader.FileHeader := 'SUIPack_TB';
    FileHeader.FormatVer := 1;
    FileHeader.HeaderSize := sizeof(FileHeader);
    FileHeader.FirstNode := sizeof(FileHeader);
    Stream.Write(FileHeader, FileHeader.HeaderSize);

    // write files
    for i := 0 to m_FileList.Count - 1 do
    begin
        FileStream := TFileStream.Create(m_FileList.Values[m_FileList.Names[i]], fmOpenRead);
        nFileSize := FileStream.Size;

        FillChar(NodeHeader, sizeof(NodeHeader), 0);
        StrLCopy(NodeHeader.NodeKey, PChar(m_FileList.Names[i]), 64);
        NodeHeader.NodeType := tbntStream;
        NodeHeader.NodeStart := Stream.Position + Sizeof(NodeHeader);
        NodeHeader.NodeSize := nFileSize;
        NodeHeader.NextNode := NodeHeader.NodeStart + NodeHeader.NodeSize;

        Stream.Write(NodeHeader, sizeof(NodeHeader));
        Stream.CopyFrom(FileStream, nFileSize);
        FileStream.Free();
    end;

    // write string
    for i := 0 to m_StrList.Count - 1 do
    begin
        StrValue := m_StrList.Values[m_StrList.Names[i]];

        FillChar(NodeHeader, sizeof(NodeHeader), 0);
        StrLCopy(NodeHeader.NodeKey, PChar(m_StrList.Names[i]), 64);
        NodeHeader.NodeType := tbntStr;
        NodeHeader.NodeStart := Stream.Position + Sizeof(NodeHeader);
        NodeHeader.NodeSize := Length(StrValue);
        NodeHeader.NextNode := NodeHeader.NodeStart + NodeHeader.NodeSize;

        Stream.Write(NodeHeader, sizeof(NodeHeader));
        Stream.Write(StrValue[1], Length(StrValue));
    end;

    // write integer
    for i := 0 to m_IntegerList.Count - 1 do
    begin
        IntValue := StrToInt(m_IntegerList.Values[m_IntegerList.Names[i]]);

        FillChar(NodeHeader, sizeof(NodeHeader), 0);
        StrLCopy(NodeHeader.NodeKey, PChar(m_IntegerList.Names[i]), 64);
        NodeHeader.NodeType := tbntInt;
        NodeHeader.NodeStart := Stream.Position + Sizeof(NodeHeader);
        NodeHeader.NodeSize := Sizeof(Integer);
        NodeHeader.NextNode := NodeHeader.NodeStart + NodeHeader.NodeSize;

        Stream.Write(NodeHeader, sizeof(NodeHeader));
        Stream.Write(IntValue, NodeHeader.NodeSize);
    end;

    // write boolean
    for i := 0 to m_BooleanList.Count - 1 do
    begin
        BoolValue := Boolean(StrToInt(m_BooleanList.Values[m_BooleanList.Names[i]]));

        FillChar(NodeHeader, sizeof(NodeHeader), 0);
        StrLCopy(NodeHeader.NodeKey, PChar(m_BooleanList.Names[i]), 64);
        NodeHeader.NodeType := tbntBool;
        NodeHeader.NodeStart := Stream.Position + Sizeof(NodeHeader);
        NodeHeader.NodeSize := Sizeof(Boolean);
        NodeHeader.NextNode := NodeHeader.NodeStart + NodeHeader.NodeSize;

        Stream.Write(NodeHeader, sizeof(NodeHeader));
        Stream.Write(BoolValue, NodeHeader.NodeSize);
    end;

    // write end block
    FillChar(NodeHeader, sizeof(NodeHeader), 0);
    NodeHeader.NodeType := tbntBool;
    NodeHeader.NodeStart := 0;
    NodeHeader.NodeSize := 0;
    NodeHeader.NextNode := 0;
    Stream.Write(NodeHeader, sizeof(NodeHeader));

    Stream.Free();
end;

{ TsuiThemeFileReader }

constructor TsuiThemeFileReader.Create(ThemeFile: String);
begin
    m_StreamList := TStringList.Create();
    m_IntegerList := TStringList.Create();
    m_BooleanList := TStringList.Create();
    m_StrList := TStringList.Create();

    Load(ThemeFile);
end;

destructor TsuiThemeFileReader.Destroy;
var
    i : Integer;
begin
    for i := 0 to m_StreamList.Count - 1 do
        TMemoryStream(m_StreamList.Objects[i]).Free();
    m_StrList.Free();
    m_BooleanList.Free();
    m_IntegerList.Free();
    m_StreamList.Free();
end;

function TsuiThemeFileReader.GetBool(Key: String): Boolean;
var
    StrValue : String;
begin
    Result := false;
    StrValue := m_BooleanList.Values[Key];
    if StrValue = '' then
        Exit;
    try
        Result := Boolean(StrToInt(StrValue));
    except end;
end;

function TsuiThemeFileReader.GetFile(Key: String): TStream;
var
    nIndex : Integer;
    Stream : TStream;
begin
    Result := nil;
    nIndex := m_StreamList.IndexOf(Key);
    if nIndex = -1 then
        Exit;
    Stream := TStream(m_StreamList.Objects[nIndex]);
    Stream.Seek(0, soFromBeginning);
    Result := Stream;
end;

function TsuiThemeFileReader.GetInteger(Key: String): Integer;
var
    StrValue : String;
begin
    Result := -1;
    StrValue := m_IntegerList.Values[Key];
    if StrValue = '' then
        Exit;
    try
        Result := StrToInt(StrValue);
    except
        Result := -1;
    end;
end;

function TsuiThemeFileReader.GetStr(Key: String): String;
begin
    Result := m_StrList.Values[Key];
end;

procedure TsuiThemeFileReader.Load(ThemeFile: String);
var
    FileStream : TStream;
    Stream : TStream;
    FileHeader : TtbThemeFileHeader;
    NodeHeader : TtbThemeNodeHeader;
    BaseFileHeader : TtbThemeBaseFileHeader;
    StrValue : String;
    IntValue : Integer;
    BoolValue : Boolean;
begin
    // read header
    FileStream := TFileStream.Create(ThemeFile, fmOpenRead or fmShareDenyNone);
    FileStream.Read(BaseFileHeader, sizeof(TtbThemeBaseFileHeader));
    FileStream.Seek(0, soFromBeginning);
    FileStream.Read(FileHeader, BaseFileHeader.HeaderSize);

    // read nodes
    FileStream.Seek(FileHeader.FirstNode, soFromBeginning);
    FileStream.Read(NodeHeader, sizeof(NodeHeader));
    while NodeHeader.NextNode <> 0 do
    begin
        FileStream.Seek(NodeHeader.NodeStart, soFromBeginning);

        case NodeHeader.NodeType of

        tbntStream :
        begin
            Stream := TMemoryStream.Create();
            Stream.CopyFrom(FileStream, NodeHeader.NodeSize);
            Stream.Seek(0, soFromBeginning);
            m_StreamList.AddObject(NodeHeader.NodeKey, Stream);
        end;

        tbntStr :
        begin
            SetLength(StrValue, NodeHeader.NodeSize);
            FileStream.Read(StrValue[1], NodeHeader.NodeSize);
            m_StrList.Add(NodeHeader.NodeKey + '=' + StrValue);
        end;

        tbntInt :
        begin
            FileStream.Read(IntValue, NodeHeader.NodeSize);
            m_IntegerList.Add(NodeHeader.NodeKey + '=' + IntToStr(IntValue));
        end;

        tbntBool :
        begin
            FileStream.Read(BoolValue, NodeHeader.NodeSize);
            m_BooleanList.Add(NodeHeader.NodeKey + '=' + IntToStr(Ord(BoolValue)));
        end;

        end; // case

        FileStream.Seek(NodeHeader.NextNode, soFromBeginning);
        FileStream.Read(NodeHeader, sizeof(NodeHeader));
    end;

    FileStream.Free();
end;

end.
