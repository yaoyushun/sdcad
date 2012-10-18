unit TntFileListBox;

interface

uses
  SysUtils, Classes, Windows, Messages, Graphics, RTLConsts,
  Forms,
   Controls, StdCtrls, TntStdCtrls, TntSysUtils, FileCtrl;

type
  TTntFileListBox = class(TTntCustomListBox)
  private
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    function GetDrive: char;
    function GetFileName: WideString;
    function IsMaskStored: Boolean;
    procedure SetDrive(Value: char);
    procedure SetFileEdit(Value: TtntEdit);
    procedure SetDirectory(const NewDirectory: WideString);
    procedure SetFileType(NewFileType: TFileType);
    procedure SetMask(const NewMask: String);
    procedure SetFileName(const NewFile: WideString);
    procedure SetShowGlyphs (Value: Boolean);
    procedure ResetItemHeight;
  protected
    FDirectory: string;
    FMask: string;
    FFileType: TFileType;
    FFileEdit: TtntEdit;
    FDirList: TDirectoryListBox;
    FFilterCombo: TFilterComboBox;
    ExeBMP, DirBMP, UnknownBMP: TBitmap;
    FOnChange: TNotifyEvent;
    FLastSel: Integer;
    FShowGlyphs: Boolean;
    procedure CreateWnd; override;
    procedure ReadBitmaps; virtual;
    procedure Click; override;
    procedure Change; virtual;
    procedure ReadFileNames; virtual;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);  override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetFilePath: String; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; reintroduce;
    procedure ApplyFilePath (const EditText: String); virtual;
    property Drive: char read GetDrive write SetDrive;
    property Directory: String read FDirectory write ApplyFilePath;
    property FileName: String read GetFilePath write ApplyFilePath;
  published
    property Align;
    property Anchors;
    property AutoComplete;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property FileEdit: TtntEdit read FFileEdit write SetFileEdit;
    property FileType: TFileType read FFileType write SetFileType default [ftNormal];
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Mask: string read FMask write SetMask stored IsMaskStored;
    property MultiSelect;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowGlyphs: Boolean read FShowGlyphs write SetShowGlyphs default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation
const
  DefaultMask = '*.*';

procedure Register;
begin
  RegisterComponents('Tnt Standard', [TTntFileListBox]);
end;
constructor TTntFileListBox.Create(AOwner: TComponent);
var
  tmpDir: string;
begin
  inherited Create(AOwner);
  Width := 145;
{  IntegralHeight := True; }
  FFileType := [ftNormal]; { show only normal files by default }
  GetDir(0, tmpDir); { initially use current dir on default drive }
  FDirectory := WideString(tmpDir);
  FMask := DefaultMask;  { default file mask is all }
  MultiSelect := False;    { default is not multi-select }
  FLastSel := -1;
  ReadBitmaps;
  Sorted := True;
  Style := lbOwnerDrawFixed;
  ResetItemHeight;
end;

destructor TTntFileListBox.Destroy;
begin
  ExeBMP.Free;
  DirBMP.Free;
  UnknownBMP.Free;
  inherited Destroy;
end;


procedure TTntFileListBox.ApplyFilePath(const EditText: String);
var
  DirPart: String;
  FilePart: String;
  NewDrive: Char;
begin

  if AnsiCompareFileName(FileName, EditText) = 0 then Exit;
  if Length (EditText) = 0 then Exit;
  //ProcessPath( EditText, NewDrive, String(DirPart), String(FilePart));
  ProcessPath( EditText, NewDrive, DirPart, FilePart);
  if FDirList <> nil then
    FDirList.Directory := EditText
  else
    if NewDrive <> #0 then
      SetDirectory(Format('%s:%s', [NewDrive, DirPart]))
    else
      SetDirectory(DirPart);
  if (Pos('*', FilePart) > 0) or (Pos('?', FilePart) > 0) then
    SetMask (FilePart)
  else if Length(FilePart) > 0 then
  begin
    SetFileName (FilePart);
    if FileExists (FilePart) then
    begin
      if GetFileName = '' then
      begin
        SetMask(FilePart);
        SetFileName (FilePart);
      end;
    end
    else
      raise EInvalidOperation.CreateFmt(SInvalidFileName, [EditText]);
  end;
end;


procedure TTntFileListBox.Change;
begin
  FLastSel := ItemIndex;
  if FFileEdit <> nil then
  begin
    if Length(GetFileName) = 0 then
      FileEdit.Text := Mask
    else
      FileEdit.Text := GetFileName;
    FileEdit.SelectAll;
  end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TTntFileListBox.Click;
begin
  inherited Click;
  if FLastSel <> ItemIndex then
     Change;
end;

procedure TTntFileListBox.CMFontChanged(var Message: TMessage);
begin
  ResetItemHeight;
end;



procedure TTntFileListBox.CreateWnd;
begin
  inherited CreateWnd;
  ReadFileNames;
end;


procedure TTntFileListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  offset: Integer;
begin
  with Canvas do
  begin
    FillRect(Rect);
    offset := 2;
    if ShowGlyphs then
    begin
      Bitmap := TBitmap(Items.Objects[Index]);
      if Assigned(Bitmap) then
      begin
        BrushCopy(Bounds(Rect.Left + 2,
                  (Rect.Top + Rect.Bottom - Bitmap.Height) div 2,
                  Bitmap.Width, Bitmap.Height),
                  Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                  Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
        offset := Bitmap.width + 6;
      end;
    end;
    //TextOut(Rect.Left + offset, Rect.Top, Items[Index])
    Rect.Left := Rect.Left + offset ;
    TntListBox_DrawItem_Text(Self, Items, Index, Rect);
  end;
end;

function TTntFileListBox.GetDrive: char;
begin
  Result := char(FDirectory[1]);
end;

function TTntFileListBox.GetFileName: WideString;
var
  idx: Integer;
begin
      { if multi-select is turned on, then using ItemIndex
        returns a bogus value if nothing is selected   }
  idx  := ItemIndex;
  if (idx < 0)  or  (Items.Count = 0)  or  (Selected[idx] = FALSE)  then
    Result  := ''
  else
    Result  := Items[idx];
end;

function TTntFileListBox.GetFilePath: String;
begin
  Result := '';
  if GetFileName <> '' then
  begin
    if AnsiLastChar(FDirectory)^ <> '\' then
    Result := FDirectory + '\' + GetFileName
  else
    Result := FDirectory + GetFileName;
  end;
    //Result := SlashSep(FDirectory, GetFileName);
end;

function TTntFileListBox.IsMaskStored: Boolean;
begin
  Result := DefaultMask <> FMask;
end;

procedure TTntFileListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FFileEdit) then FFileEdit := nil
    else if (AComponent = FDirList) then FDirList := nil
    else if (AComponent = FFilterCombo) then FFilterCombo := nil;
  end;
end;

procedure TTntFileListBox.ReadBitmaps;
begin
  ExeBMP := TBitmap.Create;
  ExeBMP.Handle := LoadBitmap(HInstance, 'EXECUTABLE');
  DirBMP := TBitmap.Create;
  DirBMP.Handle := LoadBitmap(HInstance, 'CLOSEDFOLDER');
  UnknownBMP := TBitmap.Create;
  UnknownBMP.Handle := LoadBitmap(HInstance, 'UNKNOWNFILE');
end;

procedure TTntFileListBox.ReadFileNames;
var
  AttrIndex: TFileAttr;
  I: Integer;
  FileExt: string;
  MaskPtr: PChar;
  Ptr: PChar;
  AttrWord: Word;
  FileInfo: TSearchRecW;
  SaveCursor: TCursor;
  Glyph: TBitmap;
const
   Attributes: array[TFileAttr] of Word = (faReadOnly, faHidden, faSysFile,
     faVolumeID, faDirectory, faArchive, 0);
begin
      { if no handle allocated yet, this call will force
        one to be allocated incorrectly (i.e. at the wrong time.
        In due time, one will be allocated appropriately.  }
  AttrWord := DDL_READWRITE;
  if HandleAllocated then
  begin
    { Set attribute flags based on values in FileType }
    for AttrIndex := ftReadOnly to ftArchive do
      if AttrIndex in FileType then
        AttrWord := AttrWord or Attributes[AttrIndex];

    ChDir(FDirectory); { go to the directory we want }
    Clear; { clear the list }

    I := 0;
    SaveCursor := Screen.Cursor;
    try
      MaskPtr := PChar(FMask);
      while MaskPtr <> nil do
      begin
        Ptr := StrScan (MaskPtr, ';');
        if Ptr <> nil then
          Ptr^ := #0;
        if WideFindFirst(MaskPtr, AttrWord, FileInfo) = 0 then
        begin
          repeat            { exclude normal files if ftNormal not set }
            if (ftNormal in FileType) or (FileInfo.Attr and AttrWord <> 0) then
              if FileInfo.Attr and faDirectory <> 0 then
              begin
                I := Items.Add(WideString(Format('[%s]',[FileInfo.Name])));
                if ShowGlyphs then
                  Items.Objects[I] := DirBMP;
              end
              else
              begin
                FileExt := AnsiLowerCase(ExtractFileExt(FileInfo.Name));
                Glyph := UnknownBMP;
                if (FileExt = '.exe') or (FileExt = '.com') or
                  (FileExt = '.bat') or (FileExt = '.pif') then
                  Glyph := ExeBMP;
                I := Items.AddObject(WideExtractFileName(FileInfo.Name), Glyph);
              end;
            if I = 100 then
              Screen.Cursor := crHourGlass;
          until WideFindNext(FileInfo) <> 0;
          WideFindClose(FileInfo);
        end;
        if Ptr <> nil then
        begin
          Ptr^ := ';';
          Inc (Ptr);
        end;
        MaskPtr := Ptr;
      end;
    finally
      Screen.Cursor := SaveCursor;
    end;
    Change;
  end;
end;

function GetItemHeight(Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TTntFileListBox.ResetItemHeight;
var
  nuHeight: Integer;
begin
  nuHeight :=  GetItemHeight(Font);
  if (FShowGlyphs = True) and (nuHeight < (ExeBMP.Height + 1)) then
    nuHeight := ExeBmp.Height + 1;
  ItemHeight := nuHeight;
end;

procedure TTntFileListBox.SetDirectory(const NewDirectory: WideString);
begin
  if AnsiCompareFileName(NewDirectory, FDirectory) <> 0 then
  begin
       { go to old directory first, in case not complete pathname
         and curdir changed - probably not necessary }
    if DirectoryExists(FDirectory) then
      ChDir(FDirectory);
    ChDir(NewDirectory);     { exception raised if invalid dir }
    GetDir(0, FDirectory);   { store correct directory name }
    ReadFileNames;
  end;
end;

procedure TTntFileListBox.SetDrive(Value: char);
begin
  if (UpCase(Value) <> UpCase(char(FDirectory[1]))) then
    ApplyFilePath (Format ('%s:', [Value]));
end;

procedure TTntFileListBox.SetFileEdit(Value: TtntEdit);
begin
  FFileEdit := Value;
  if FFileEdit <> nil then
  begin
    FFileEdit.FreeNotification(Self);
    if GetFileName <> '' then
      FFileEdit.Text := GetFileName
    else
      FFileEdit.Text := Mask;
  end;
end;

procedure TTntFileListBox.SetFileName(const NewFile: WideString);
begin
  if AnsiCompareFileName(NewFile, GetFileName) <> 0 then
  begin
    ItemIndex := SendMessage(Handle, LB_FindStringExact, 0,
      Longint(PWideChar(NewFile)));
    Change;
  end;
end;

procedure TTntFileListBox.SetFileType(NewFileType: TFileType);
begin
  if NewFileType <> FFileType then
  begin
    FFileType := NewFileType;
    ReadFileNames;
  end;
end;

procedure TTntFileListBox.SetMask(const NewMask: String);
begin
  if FMask <> NewMask then
  begin
    FMask := NewMask;
    ReadFileNames;
  end;
end;

procedure TTntFileListBox.SetShowGlyphs(Value: Boolean);
begin
  if FShowGlyphs <> Value then
  begin
    FShowGlyphs := Value;
    if (FShowGlyphs = True) and (ItemHeight < (ExeBMP.Height + 1)) then
      ResetItemHeight;
    Invalidate;
  end;
end;

procedure TTntFileListBox.Update;
begin
  ReadFileNames;
end;

end.

