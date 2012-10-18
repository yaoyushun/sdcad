////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIMgr.pas
//  Creator     :   Shen Min
//  Date        :   2003-02-26
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIMgr;

interface

{$I SUIPack.inc}

uses Windows, Classes, Controls, SysUtils, Forms, TypInfo, Graphics, Dialogs,
     SUIThemes;

type
    // --------- TsuiFileTheme --------------------
    TsuiFileTheme = class(TComponent)
    private
        m_Mgr : TsuiFileThemeMgr;
        m_ThemeFile : String;
        m_CanUse : Boolean;

        procedure SetThemeFile(const Value: String);

    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy(); override;

        function CanUse() : Boolean;
        
        procedure GetBitmap(const Index : Integer; const Buf : TBitmap; SpitCount : Integer = 0; SpitIndex : Integer = 0);
        function GetInt(const Index : Integer) : Integer;
        function GetColor(const Index : Integer) : TColor;
        function GetBool(const Index : Integer) : Boolean;

        function CheckThemeFile(FileName : String) : Boolean;

    published
        property ThemeFile : String read m_ThemeFile write SetThemeFile;

    end;

    TsuiBuiltInFileTheme = class(TsuiFileTheme)
    private
        m_OldThemeFile : String;
        
        procedure SetThemeFile2(const Value: String);
        procedure ReadSkinData(Stream: TStream);
        procedure WriteSkinData(Stream : TStream);

    protected
        procedure DefineProperties(Filer: TFiler); override;

    published
        property ThemeFile : String read m_OldThemeFile write SetThemeFile2;
    end;

    // --------- TsuiThemeManager -----------------
    TsuiThemeMgrCompList = class(TStringList)
    end;

    TsuiThemeManager = class(TComponent)
    private
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_List : TsuiThemeMgrCompList;
        m_OnUIStyleChanged : TNotifyEvent;

        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure UpdateAll();

        procedure SetList(const Value: TsuiThemeMgrCompList);
        procedure SetFileTheme(const Value: TsuiFileTheme);

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy(); override;

        procedure UpdateTheme();
        
    published
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property CompList : TsuiThemeMgrCompList read m_List write SetList;

        property OnUIStyleChanged : TNotifyEvent read m_OnUIStyleChanged write m_OnUIStyleChanged;
    end;

    procedure ThemeManagerEdit(AComp : TsuiThemeManager);
    procedure FileThemeEdit(AComp : TsuiFileTheme);
    procedure BuiltInFileThemeEdit(AComp : TsuiBuiltInFileTheme);

    function UsingFileTheme(
        const FileTheme : TsuiFileTheme;
        const UIStyle : TsuiUIStyle;
        out SuggUIStyle : TsuiUIStyle
    ) : Boolean;


implementation

uses SUIForm, frmThemeMgr, SUIThemeFile, SUIPublic;

procedure ThemeManagerEdit(AComp : TsuiThemeManager);
var
    frmMgr: TfrmMgr;
    Form : TWinControl;
    i : Integer;
    nIndex : Integer;
    Comp : TComponent;
begin
    if not (AComp.Owner is TForm) and not (AComp.Owner is TCustomFrame) then
        Exit;
    Form := (AComp.Owner as TWinControl);
    frmMgr := TfrmMgr.Create(nil);

    for i := 0 to Form.ComponentCount - 1 do
    begin
        Comp := Form.Components[i];
        if (
            (Copy(Comp.ClassName, 1, 4) = 'Tsui') and
            (IsHasProperty(Comp, 'UIStyle')) and
            (IsHasProperty(Comp, 'FileTheme')) and
            not (Comp is TsuiThemeManager)
        ) then
        begin
            nIndex := frmMgr.List.Items.AddObject(Comp.Name, Comp);
            if AComp.m_List.IndexOf(Comp.Name) = -1 then
                frmMgr.List.Checked[nIndex] := false
            else
                frmMgr.List.Checked[nIndex] := true;
        end
    end;

    if frmMgr.ShowModal() = mrOK then
    begin
        AComp.m_List.Clear();
        for i := 0 to frmMgr.List.Items.Count - 1 do
        begin
            if frmMgr.List.Checked[i] then
                AComp.m_List.Add(frmMgr.List.Items[i]);
        end;
    end;
    frmMgr.Free();

    AComp.UpdateAll();
end;

procedure FileThemeEdit(AComp : TsuiFileTheme);
var
    OpenDialog: TOpenDialog;
begin
    OpenDialog := TOpenDialog.Create(Application);
    OpenDialog.Filter := 'SUIPack Theme File(*.sui)|*.sui';
    if OpenDialog.Execute() then
        AComp.ThemeFile := OpenDialog.FileName;
    OpenDialog.Free();
end;

procedure BuiltInFileThemeEdit(AComp : TsuiBuiltInFileTheme);
var
    OpenDialog: TOpenDialog;
begin
    OpenDialog := TOpenDialog.Create(Application);
    OpenDialog.Filter := 'SUIPack Theme File(*.sui)|*.sui';
    if OpenDialog.Execute() then
        AComp.ThemeFile := OpenDialog.FileName;
    OpenDialog.Free();
end;

{ TsuiThemeManager }

constructor TsuiThemeManager.Create(AOwner: TComponent);
begin
    inherited;

    m_List := TsuiThemeMgrCompList.Create();
    UIStyle := SUI_THEME_DEFAULT;
end;

destructor TsuiThemeManager.Destroy;
begin
    m_List.Free();
    m_List := nil;

    inherited;
end;

procedure TsuiThemeManager.Notification(AComponent: TComponent;
  Operation: TOperation);
var
    nIndex : Integer;
begin
    inherited;

    if AComponent = nil then
        Exit;

    if (Operation = opRemove) and (AComponent <> self) then
    begin
        nIndex := m_List.IndexOf(AComponent.Name);
        if nIndex <> -1 then
            m_List.Delete(nIndex);
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        m_UIStyle := SUI_THEME_DEFAULT;
    end;
end;

procedure TsuiThemeManager.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);    
end;

procedure TsuiThemeManager.SetList(const Value: TsuiThemeMgrCompList);
begin
    m_List.Assign(Value);
end;

procedure TsuiThemeManager.SetUIStyle(const Value: TsuiUIStyle);
var
    NeedUpdate : Boolean;
begin
    if m_UIStyle = Value then
        NeedUpdate := false
    else
        NeedUpdate := true;
    m_UIStyle := Value;
    UpdateAll();
    if NeedUpdate then
        if Assigned(m_OnUIStyleChanged) then
            m_OnUIStyleChanged(self);
end;

procedure TsuiThemeManager.UpdateAll;
var
    i : Integer;
    Comp : TComponent;
    Form : TWinControl;
begin
    if not (Owner is TForm) and not (Owner is TCustomFrame) then
        Exit;
    Form := Owner as TWinControl;

    for i := 0 to m_List.Count - 1 do
    begin
        Comp := Form.FindComponent(m_List[i]);
        if Comp = nil then
            continue;
        SetOrdProp(Comp, 'UIStyle', Ord(UIStyle));
        SetObjectProp(Comp, 'FileTheme', m_FileTheme);        
    end;
end;

procedure TsuiThemeManager.UpdateTheme;
begin
    UpdateAll();
end;

{ TsuiFileTheme }

function TsuiFileTheme.CanUse: Boolean;
begin
    Result := m_CanUse;
end;

function TsuiFileTheme.CheckThemeFile(FileName: String): Boolean;
begin
    Result := IsSUIThemeFile(FileName);
end;

constructor TsuiFileTheme.Create(AOwner: TComponent);
begin
    inherited;

    m_Mgr := TsuiFileThemeMgr.Create();
    m_CanUse := false;
end;

destructor TsuiFileTheme.Destroy;
begin
    m_Mgr.Free();
    m_Mgr := nil;

    inherited;
end;

procedure TsuiFileTheme.GetBitmap(const Index: Integer; const Buf: TBitmap;
  SpitCount, SpitIndex: Integer);
var
    TempBmp : TBitmap;
begin
    if (SpitCount = 0) or (SpitIndex = 0) then
    begin
        m_Mgr.GetBitmap(Index, Buf);
    end
    else
    begin
        TempBmp := TBitmap.Create();
        m_Mgr.GetBitmap(Index, TempBmp);
        SpitBitmap(TempBmp, Buf, SpitCount, SpitIndex);
        TempBmp.Free();
    end;
end;

function TsuiFileTheme.GetBool(const Index: Integer): Boolean;
begin
    Result := m_Mgr.GetBool(Index);
end;

function TsuiFileTheme.GetColor(const Index: Integer): TColor;
begin
    Result := m_Mgr.GetColor(Index);
end;

function TsuiFileTheme.GetInt(const Index: Integer): Integer;
begin
    Result := m_Mgr.GetInt(Index);
end;

procedure TsuiFileTheme.SetThemeFile(const Value: String);
    function PCharToStr(pstr : PChar) : String;
    begin
        if StrLen(pstr) = 0 then
            Result := ''
        else
        begin
            Result := pstr;
            SetLength(Result, StrLen(pstr));
        end;
    end;
    function GetWindowsPath() : String;
    var
        WindowsPath : array [0..MAX_PATH - 1] of Char;
    begin
        GetWindowsDirectory(WindowsPath, MAX_PATH);
        Result := PCharToStr(WindowsPath);
        if Result[Length(Result)] <> '\' then
            Result := Result + '\'
    end;
    function GetSystemPath() : String;
    var
        SystemPath : array [0..MAX_PATH - 1] of Char;
    begin
        GetSystemDirectory(SystemPath, MAX_PATH);
        Result := PCharToStr(SystemPath);
        if Result[Length(Result)] <> '\' then
            Result := Result + '\'        
    end;
var
    FileName : String;
    PathName : String;
    i : Integer;
    Form : TForm;
    Comp : TComponent;
    MainUse : Boolean;
    First : Boolean;
begin
    if m_ThemeFile = '' then
        First := true
    else
        First := false;
    if (m_ThemeFile = Value) then
        Exit;
    FileName := Value;
    
    if not FileExists(FileName) then
    begin
        PathName := ExtractFilePath(Application.ExeName);
        if PathName[Length(PathName)] <> '\' then
            PathName := PathName + '\';
        FileName := PathName + ExtractFileName(FileName);
        if not FileExists(FileName) then
        begin
            PathName := GetWindowsPath();
            FileName := PathName + ExtractFileName(FileName);
            if not FileExists(FileName) then
            begin
                PathName := GetSystemPath();
                FileName := PathName + ExtractFileName(FileName);
                if not FileExists(FileName) then
                    Exit;
            end;
        end;
    end;

    if not CheckThemeFile(FileName) then
        raise Exception.Create('Invalid skin file for SUIPack!');
    
    m_ThemeFile := FileName;
    m_CanUse := m_Mgr.LoadFromFile(m_ThemeFile);

    if (not m_CanUse) or (not (Owner is TForm)) then
        Exit;
    Form := Owner as TForm;
    MainUse := false;
    for i := 0 to Form.ComponentCount - 1 do
    begin
        Comp := Form.Components[i];
        if (Comp is TsuiForm) or (Comp is TsuiMDIForm) then
        begin
            if GetObjectProp(Comp, 'FileTheme') = self then
                MainUse := true;
        end;

        if (
            (Copy(Comp.ClassName, 1, 4) = 'Tsui') and
            (IsHasProperty(Comp, 'FileTheme'))
        ) then
        begin
            if GetObjectProp(Comp, 'FileTheme') = self then
                SetObjectProp(Comp, 'FileTheme', self);
        end;
    end;
    if MainUse and (not First) then
        SetWindowPos(Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
end;

function UsingFileTheme(
    const FileTheme : TsuiFileTheme;
    const UIStyle : TsuiUIStyle;
    out SuggUIStyle : TsuiUIStyle
) : Boolean;
begin
    Result := false;
    SuggUIStyle := UIStyle;
    
    if UIStyle = FromThemeFile then
    begin
        if FileTheme = nil then
            SuggUIStyle := SUI_THEME_DEFAULT
        else if FileTheme.CanUse() then
        begin
            Result := true;
            Exit;
        end
        else
            SuggUIStyle := SUI_THEME_DEFAULT;
    end;
end;
    
{ TsuiBuiltInFileTheme }

procedure TsuiBuiltInFileTheme.DefineProperties(Filer: TFiler);
    function DoWrite() : Boolean;
    begin
        if FileExists(m_OldThemeFile) then
            Result := true
        else
            Result := false;
    end;
begin
    inherited;

    Filer.DefineBinaryProperty('SkinData', ReadSkinData, WriteSkinData, DoWrite);
end;

procedure TsuiBuiltInFileTheme.ReadSkinData(Stream: TStream);
    function GetTempPath() : String;
    var
        TempPath : array [0..MAX_PATH - 1] of Char;
    begin
        Windows.GetTempPath(MAX_PATH, TempPath);
        Result := PCharToStr(TempPath);
        if Result[Length(Result)] <> '\' then
            Result := Result + '\'
    end;
    function GetUniqueFileName(const BaseName : String) : String;
    var
        i : Integer;
        BaseFileName : String;
        FileExt : String;
    begin
        Result := BaseName;
        FileExt := ExtractFileExt(BaseName);
        BaseFileName := ChangeFileExt(BaseName, '');
        i := 0;
        while FileExists(Result) do
        begin
            Inc(i);
            Result := BaseFileName + IntToStr(i) + FileExt;
        end;
    end;
var
    S : TMemoryStream;
    F : String;
begin
    S := TMemoryStream.Create();
    S.CopyFrom(Stream, Stream.Size);
    F := GetUniqueFileName(GetTempPath() + 'SUIPAKT.sui');
    S.SaveToFile(F);
    inherited ThemeFile := F;
    S.Free();
    DeleteFile(F);
end;

procedure TsuiBuiltInFileTheme.SetThemeFile2(const Value: String);
begin
    m_OldThemeFile := Value;
end;

procedure TsuiBuiltInFileTheme.WriteSkinData(Stream: TStream);
var
    S : TMemoryStream;
begin
    S := TMemoryStream.Create();
    S.LoadFromFile(m_OldThemeFile);
    Stream.CopyFrom(S, S.Size);
    S.Free();   
end;

end.
