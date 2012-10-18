////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIFontComboBox.pas
//  Creator     :   Steve McDonald
//  Merger      :   Shen Min
//  Date        :   2003-04-01 V1-V3
//                  2003-06-24 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIFontComboBox;

{$B-} {- Complete Boolean Evaluation }
{$R-} {- Range-Checking }
{$V-} {- Var-String Checking }
{$T-} {- Typed @ operator }
{$X+} {- Extended syntax }
{$P+} {- Open string params }
{$J+} {- Writeable structured consts }
{$H+} {- Use long strings by default }
{$W-,T-}

interface

{$I SUIPack.inc}

uses
  Windows, Messages, Classes, Controls, Graphics, StdCtrls, Forms, SUIThemes,
  SUIComboBox;

resourcestring
  SResNotFound = 'Resource %s not found';

type
{ TsuiFontDrawComboBox }

  TFontDrawComboStyle = csDropDown..csDropDownList;

  TsuiFontDrawComboBox = class(TsuiCustomComboBox)
  private
    FStyle: TFontDrawComboStyle;
    FItemHeightChanging: Boolean;
    procedure SetComboStyle(Value: TFontDrawComboStyle);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure ResetItemHeight;
    function MinItemHeight: Integer; virtual;
    property Style: TFontDrawComboStyle read FStyle write SetComboStyle default csDropDownList;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TsuiFontComboBox }

  TFontDevice = (fdScreen, fdPrinter, fdBoth);
  TFontListOption = (foAnsiOnly, foTrueTypeOnly, foFixedPitchOnly, foNoOEMFonts, foOEMFontsOnly, foScalableOnly, foNoSymbolFonts);
  TFontListOptions = set of TFontListOption;

  TsuiFontComboBox = class(TsuiFontDrawComboBox)
  private
    FTrueTypeBMP: TBitmap;
    FDeviceBMP: TBitmap;
    FOnChange: TNotifyEvent;
    FDevice: TFontDevice;
    FUpdate: Boolean;
    FUseFonts: Boolean;
    FOptions: TFontListOptions;

    procedure SetFontName(const NewFontName: TFontName);
    function GetFontName: TFontName;
    procedure SetDevice(Value: TFontDevice);
    procedure SetOptions(Value: TFontListOptions);
    procedure SetUseFonts(Value: Boolean);
    procedure Reset;
    procedure WMFontChange(var Message: TMessage); message WM_FONTCHANGE;

  protected
    procedure PopulateList; virtual;
    procedure Change; override;
    procedure Click; override;
    procedure DoChange; dynamic;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    function MinItemHeight: Integer; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;

  published
    property Device: TFontDevice read FDevice write SetDevice default fdScreen;
    property FontName: TFontName read GetFontName write SetFontName;
    property Options: TFontListOptions read FOptions write SetOptions default [];
    property UseFonts: Boolean read FUseFonts write SetUseFonts default False;
    property ItemHeight;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnEndDock;
    property OnStartDock;
  end;

  TsuiFontSizeComboBox = class(TsuiCustomComboBox)
  private
    PixelsPerInch : Integer;
    FFontName : TFontName;

    procedure SetFontName( const Value : TFontName );
    procedure Build;
    function GetFontSize: Integer;
    procedure SetFontSize(const Value: Integer);

  public
    constructor Create(AOwner: TComponent); override;

  published
    property FontName : TFontName read FFontName write SetFontName;
    property FontSize : Integer read GetFontSize write SetFontSize;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnEndDock;
    property OnStartDock;
  end;


implementation

uses
  SysUtils,
  Consts,
  Printers,
  Dialogs,
  SUIPublic,
  SUIResDef;


{ Utility routines }

procedure ResourceNotFound(ResID: PChar);
var
  S: string;
begin
  if LongRec(ResID).Hi = 0 then
    S := IntToStr(LongRec(ResID).Lo)
  else
    S := StrPas(ResID);
  raise EResNotFound.CreateFmt(SResNotFound, [S]);
end;

function MakeModuleBitmap(Module: THandle; ResID: PChar): TBitmap;
begin
  Result := TBitmap.Create;
  try
    if Module <> 0 then begin
      if LongRec(ResID).Hi = 0 then
        Result.LoadFromResourceID(Module, LongRec(ResID).Lo)
      else
        Result.LoadFromResourceName(Module, StrPas(ResID));
    end
    else begin
      Result.Handle := LoadBitmap(Module, ResID);
      if Result.Handle = 0 then
        ResourceNotFound(ResID);
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;

function CreateBitmap(ResName: PChar): TBitmap;
begin
  Result := MakeModuleBitmap(HInstance, ResName);
  if Result = nil then
    ResourceNotFound(ResName);
end;

function GetItemHeight(Font: TFont): Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  Result := Metrics.tmHeight + 1;
  if Result = 14 then
      Result := 15;
end;

{ TsuiFontDrawComboBox }

constructor TsuiFontDrawComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Style := csDropDownList;
  FStyle := csDropDownList;
end;

procedure TsuiFontDrawComboBox.SetComboStyle(Value: TFontDrawComboStyle);
begin
  if FStyle <> Value then begin
    FStyle := Value;
    inherited Style := Value;
  end;
end;

function TsuiFontDrawComboBox.MinItemHeight: Integer;
begin
  Result := GetItemHeight(Font);
  if Result < 9 then
    Result := 9;
end;

procedure TsuiFontDrawComboBox.ResetItemHeight;
var
  H: Integer;
begin
  H := MinItemHeight;
  FItemHeightChanging := True;
  try
    inherited ItemHeight := H;
  finally
    FItemHeightChanging := False;
  end;
  if HandleAllocated then
    SendMessage(Handle, CB_SETITEMHEIGHT, 0, H);
end;

procedure TsuiFontDrawComboBox.CreateParams(var Params: TCreateParams);
const
  ComboBoxStyles: array[TFontDrawComboStyle] of DWORD =
    (CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST);
begin
  inherited CreateParams(Params);
  with Params do
    Style := (Style and not CBS_DROPDOWNLIST) or CBS_OWNERDRAWFIXED or
      ComboBoxStyles[FStyle];
end;

procedure TsuiFontDrawComboBox.CreateWnd;
begin
  inherited CreateWnd;
  ResetItemHeight;
end;

procedure TsuiFontDrawComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

procedure TsuiFontDrawComboBox.CMRecreateWnd(var Message: TMessage);
begin
  if not FItemHeightChanging then
    inherited;
end;

{ TsuiFontComboBox }

const
  WRITABLE_FONTTYPE = 256;

function IsValidFont(Box: TsuiFontComboBox; LogFont: TLogFont; FontType: Integer): Boolean;
begin
  Result := True;
  if (foAnsiOnly in Box.Options) then
    Result := Result and (LogFont.lfCharSet = ANSI_CHARSET);
  if (foTrueTypeOnly in Box.Options) then
    Result := Result and (FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE);
  if (foFixedPitchOnly in Box.Options) then
    Result := Result and (LogFont.lfPitchAndFamily and FIXED_PITCH = FIXED_PITCH);
  if (foOEMFontsOnly in Box.Options) then
    Result := Result and (LogFont.lfCharSet = OEM_CHARSET);
  if (foNoOEMFonts in Box.Options) then
    Result := Result and (LogFont.lfCharSet <> OEM_CHARSET);
  if (foNoSymbolFonts in Box.Options) then
    Result := Result and (LogFont.lfCharSet <> SYMBOL_CHARSET);
  if (foScalableOnly in Box.Options) then
    Result := Result and (FontType and RASTER_FONTTYPE = 0);
end;

function EnumFontsProc(var EnumLogFont: TEnumLogFont;
  var TextMetric: TNewTextMetric; FontType: Integer; Data: LPARAM): Integer;
  export; stdcall;
var
  FaceName: string;
begin
  FaceName := StrPas(EnumLogFont.elfLogFont.lfFaceName);
  with TsuiFontComboBox(Data) do
    if (Items.IndexOf(FaceName) < 0) and
      IsValidFont(TsuiFontComboBox(Data), EnumLogFont.elfLogFont, FontType) then begin
      if EnumLogFont.elfLogFont.lfCharSet <> SYMBOL_CHARSET then
        FontType := FontType or WRITABLE_FONTTYPE;
      Items.AddObject(FaceName, TObject(FontType));
    end;
  Result := 1;
end;

constructor TsuiFontComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ItemHeight := 15;
  FTrueTypeBMP := CreateBitmap('FONTCOMBO_TRUETYPE_FNT');
  FDeviceBMP := CreateBitmap('FONTCOMBO_DEVICE_FNT');
  FDevice := fdScreen;
  Sorted := True;

  inherited ItemHeight := MinItemHeight;
end;

destructor TsuiFontComboBox.Destroy;
begin
  FTrueTypeBMP.Free;
  FDeviceBMP.Free;
  inherited Destroy;
end;

procedure TsuiFontComboBox.CreateWnd;
var
  OldFont: TFontName;
begin
  OldFont := FontName;
  inherited CreateWnd;
  FUpdate := True;
  try
    PopulateList;
    inherited Text := '';
    SetFontName(OldFont);
  finally
    FUpdate := False;
  end;
  if AnsiCompareText(FontName, OldFont) <> 0 then
    DoChange;
end;

procedure TsuiFontComboBox.PopulateList;
var
  DC: HDC;
begin
  if not HandleAllocated then Exit;
  Items.BeginUpdate;
  try
    Clear;
    DC := GetDC(0);
    try
      if (FDevice = fdScreen) or (FDevice = fdBoth) then
        EnumFontFamilies(DC, nil, @EnumFontsProc, Longint(Self));
      if (FDevice = fdPrinter) or (FDevice = fdBoth) then
        try
          EnumFontFamilies(Printer.Handle, nil, @EnumFontsProc, Longint(Self));
        except
          { skip any errors }
        end;
    finally
      ReleaseDC(0, DC);
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TsuiFontComboBox.SetFontName(const NewFontName: TFontName);
var
  Item: Integer;
begin
  if FontName <> NewFontName then begin
    if not (csLoading in ComponentState) then begin
      HandleNeeded;
      { change selected item }
      for Item := 0 to Items.Count - 1 do
        if AnsiCompareText(Items[Item], NewFontName) = 0 then begin
          ItemIndex := Item;
          DoChange;
          Exit;
        end;
      if Style = csDropDownList then
        ItemIndex := -1
      else
        inherited Text := NewFontName;
    end
    else
      inherited Text := NewFontName;
    DoChange;
  end;
end;

function TsuiFontComboBox.GetFontName: TFontName;
begin
  Result := inherited Text;
end;

procedure TsuiFontComboBox.SetOptions(Value: TFontListOptions);
begin
  if Value <> Options then begin
    FOptions := Value;
    Reset;
  end;
end;

procedure TsuiFontComboBox.SetDevice(Value: TFontDevice);
begin
  if Value <> FDevice then begin
    FDevice := Value;
    Reset;
  end;
end;

procedure TsuiFontComboBox.SetUseFonts(Value: Boolean);
begin
  if Value <> FUseFonts then begin
    FUseFonts := Value;
    Invalidate;
  end;
end;

procedure TsuiFontComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  BmpWidth: Integer;
  Text: array[0..255] of Char;
begin
  with Canvas do begin
    FillRect(Rect);
    BmpWidth  := 20;
    if (Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE) <> 0 then
      Bitmap := FTrueTypeBMP
    else
      if (Integer(Items.Objects[Index]) and DEVICE_FONTTYPE) <> 0 then
        Bitmap := FDeviceBMP
      else
        Bitmap := nil;
    if Bitmap <> nil then begin
      BmpWidth := Bitmap.Width;
      BrushCopy(Bounds(Rect.Left + 2, (Rect.Top + Rect.Bottom - Bitmap.Height)
        div 2, Bitmap.Width, Bitmap.Height), Bitmap, Bounds(0, 0, Bitmap.Width,
        Bitmap.Height), Bitmap.TransparentColor);
    end;
    { uses DrawText instead of TextOut in order to get clipping against
      the combo box button }
    {TextOut(Rect.Left + bmpWidth + 6, Rect.Top, Items[Index])}
    StrPCopy(Text, Items[Index]);
    Rect.Left := Rect.Left + BmpWidth + 6;
    if FUseFonts and (Integer(Items.Objects[Index]) and WRITABLE_FONTTYPE <> 0) then
      Font.Name := Items[Index];
    DrawText(Handle, Text, StrLen(Text), Rect,
      DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
  end;
end;

procedure TsuiFontComboBox.WMFontChange(var Message: TMessage);
begin
  inherited;
  Reset;
end;

function TsuiFontComboBox.MinItemHeight: Integer;
begin
  Result := inherited MinItemHeight;
  if Result < FTrueTypeBMP.Height - 1 then
    Result := FTrueTypeBMP.Height - 1;
end;

procedure TsuiFontComboBox.Change;
var
  I: Integer;
begin
  inherited Change;
  if Style <> csDropDownList then begin
    I := Items.IndexOf(inherited Text);
    if (I >= 0) and (I <> ItemIndex) then begin
      ItemIndex := I;
      DoChange;
    end;
  end;
end;

procedure TsuiFontComboBox.Click;
begin
  inherited Click;
  DoChange;
end;

procedure TsuiFontComboBox.DoChange;
begin
  if not (csReading in ComponentState) then
    if not FUpdate and Assigned(FOnChange) then
      FOnChange(Self);
end;

procedure TsuiFontComboBox.Reset;
var
  SaveName: TFontName;
begin
  if HandleAllocated then begin
    FUpdate := True;
    try
      SaveName := FontName;
      PopulateList;
      FontName := SaveName;
    finally
      FUpdate := False;
      if FontName <> SaveName then
        DoChange;
    end;
  end;
end;

function EnumFontSizes( var EnumLogFont : TEnumLogFont; PTextMetric : PNewTextMetric; FontType : Integer; Data : LPARAM ) : Integer; export; stdcall;
var
  s : String;
  i : Integer;
  v : Integer;
  v2 : Integer;
begin
  if (FontType and TRUETYPE_FONTTYPE)<>0 then begin
    TsuiFontSizeComboBox(Data).Items.Add('8');
    TsuiFontSizeComboBox(Data).Items.Add('9');
    TsuiFontSizeComboBox(Data).Items.Add('10');
    TsuiFontSizeComboBox(Data).Items.Add('11');
    TsuiFontSizeComboBox(Data).Items.Add('12');
    TsuiFontSizeComboBox(Data).Items.Add('14');
    TsuiFontSizeComboBox(Data).Items.Add('16');
    TsuiFontSizeComboBox(Data).Items.Add('18');
    TsuiFontSizeComboBox(Data).Items.Add('20');
    TsuiFontSizeComboBox(Data).Items.Add('22');
    TsuiFontSizeComboBox(Data).Items.Add('24');
    TsuiFontSizeComboBox(Data).Items.Add('26');
    TsuiFontSizeComboBox(Data).Items.Add('28');
    TsuiFontSizeComboBox(Data).Items.Add('36');
    TsuiFontSizeComboBox(Data).Items.Add('48');
    TsuiFontSizeComboBox(Data).Items.Add('72');
    Result := 0;
  end
  else begin
    v := Round( ( EnumLogFont.elfLogFont.lfHeight - PTextMetric.tmInternalLeading ) * 72 / TsuiFontSizeComboBox( Data ).PixelsPerInch );
    s := IntToStr( v );
    Result := 1;
    for i := 0 to Pred( TsuiFontSizeComboBox( Data ).Items.Count ) do begin
      v2 := StrToInt( TsuiFontSizeComboBox( Data ).Items[ i ] );
      if v2 = v then
        exit;
      if v2 > v then begin
        TsuiFontSizeComboBox( Data ).Items.Insert( i, s );
        exit;
      end;
    end;
    TsuiFontSizeComboBox( Data ).Items.Add( s );
  end;
end;

procedure TsuiFontSizeComboBox.Build;
var
  DC : HDC;
  OC : TNotifyEvent;
begin
  DC := GetDC( 0 );
  Items.BeginUpdate;
  try
    Items.Clear;
    if FontName <> '' then begin
      PixelsPerInch := GetDeviceCaps( DC, LOGPIXELSY );
      EnumFontFamilies( DC, PChar( FontName ), @EnumFontSizes, Longint( Self ) );
      OC := OnClick;
      OnClick := nil;
      ItemIndex := Items.IndexOf( Text );
      OnClick := OC;
      if Assigned( OnClick ) then
        OnClick( Self );
    end;
  finally
    Items.EndUpdate;
    ReleaseDC( 0, DC );
  end;
end;

procedure TsuiFontSizeComboBox.SetFontName( const Value : TFontName );
begin
  FFontName := Value;
  Build;
end;

constructor TsuiFontSizeComboBox.Create(AOwner: TComponent);
begin
    inherited;

    self.Style := csDropDownList;
end;

function TsuiFontSizeComboBox.GetFontSize: Integer;
begin
    try
        Result := StrToInt(Items[ItemIndex]);
    except
        Result := 0;
    end;
end;

procedure TsuiFontSizeComboBox.SetFontSize(const Value: Integer);
begin
    ItemIndex := Items.IndexOf(IntToStr(Value));
end;

end.
