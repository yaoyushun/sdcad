////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIEdit.pas
//  Creator     :   Shen Min
//  Date        :   2002-08-22 V1-V3
//                  2003-06-20 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIEdit;

interface

{$I SUIPack.inc}

uses Windows, Classes, Controls, StdCtrls, Forms, Graphics, Messages, Mask,
     SysUtils,
     SUIThemes, SUIMgr, SUIButton;

type
    TsuiEdit = class(TCustomEdit)
    private
        m_BorderColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        procedure UIStyleChanged(); virtual;    

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;

        property Anchors;
        property AutoSelect;
        property AutoSize;
        property BiDiMode;
        property CharCase;
        property Color;
        property Constraints;
        property Ctl3D;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property Font;
        property HideSelection;
        property ImeMode;
        property ImeName;
        property MaxLength;
        property OEMConvert;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PasswordChar;
        property PopupMenu;
        property ReadOnly;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Text;
        property Visible;
        property OnChange;
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnStartDock;
        property OnStartDrag;
    end;

    TsuiMaskEdit = class(TCustomMaskEdit)
    private
        m_BorderColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;    

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;

        property Anchors;
        property AutoSelect;
        property AutoSize;
        property BiDiMode;
        property BorderStyle;
        property CharCase;
        property Color;
        property Constraints;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property EditMask;
        property Font;
        property ImeMode;
        property ImeName;
        property MaxLength;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PasswordChar;
        property PopupMenu;
        property ReadOnly;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Text;
        property Visible;
        property OnChange;
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnStartDock;
        property OnStartDrag;

    end;

    TsuiNumberEdit = class(TsuiEdit)
    private
        m_Mask: string;
        m_Value: Real;
        m_AutoSelectSigns: Integer;
        procedure SetValue(Value: Real);
        procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    protected
        procedure CreateParams(var Params: TCreateParams); override;
        procedure DoExit; override;
        procedure DoEnter; override;
        procedure Change; override;
        procedure KeyPress(var Key: Char); override;
        procedure Click; override;
    public
        constructor Create(AOwner: TComponent); override;

    published
        property Mask: string read m_Mask write m_Mask;
        property Value: Real read m_Value write SetValue;
        property AutoSelectSigns: Integer read m_AutoSelectSigns write m_AutoSelectSigns;
        property AutoSelect;
        property AutoSize;
        property BorderStyle;
        property CharCase;
        property Color;
        property Ctl3D;
        property DragCursor;
        property DragMode;
        property Enabled;
        property Font;
        property HideSelection;
        property ImeMode;
        property ImeName;
        property MaxLength;
        property OEMConvert;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PasswordChar;
        property PopupMenu;
        property ReadOnly;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Visible;
        property OnChange;
        property OnClick;
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

    TsuiSpinButtons = class(TWinControl)
    private
        m_UpButton: TsuiArrowButton;
        m_DownButton: TsuiArrowButton;
        m_OnUpClick: TNotifyEvent;
        m_OnDownClick: TNotifyEvent;

        function CreateButton: TsuiArrowButton;
        procedure BtnClick(Sender: TObject);
        procedure AdjustSize(var W, H: Integer); reintroduce;
        procedure WMSize(var Message: TWMSize); message WM_SIZE;
        function GetFileTheme: TsuiFileTheme;
        function GetUIStyle: TsuiUIStyle;
        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        
    protected
        procedure Loaded; override;
        procedure KeyDown(var Key: Word; Shift: TShiftState); override;
        
    public
        constructor Create(AOwner: TComponent); override;
        procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
        
    published
        property OnUpClick: TNotifyEvent read m_OnUpClick write m_OnUpClick;
        property OnDownClick: TNotifyEvent read m_OnDownClick write m_OnDownClick;

        property FileTheme : TsuiFileTheme read GetFileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read GetUIStyle write SetUIStyle;

    end;

    TsuiSpinEdit = class(TsuiEdit)
    private
        m_MinValue: Integer;
        m_MaxValue: Integer;
        m_Increment: Integer;
        m_Button: TsuiSpinButtons;
        m_EditorEnabled: Boolean;
        
        function GetValue: Integer;
        function CheckValue(NewValue: Integer): Integer;
        procedure SetValue(NewValue: Integer);
        procedure SetEditRect;
        procedure WMSize(var Message: TWMSize); message WM_SIZE;
        procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
        procedure CMExit(var Message: TCMExit); message CM_EXIT;
        procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
        procedure WMCut(var Message: TWMCut); message WM_CUT;
        
    protected
        procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
        function IsValidChar(Key: Char): Boolean; virtual;
        procedure UpClick(Sender: TObject); virtual;
        procedure DownClick(Sender: TObject); virtual;
        procedure KeyDown(var Key: Word; Shift: TShiftState); override;
        procedure KeyPress(var Key: Char); override;
        procedure CreateParams(var Params: TCreateParams); override;
        procedure CreateWnd; override;

        procedure UIStyleChanged(); override;
        
    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        
        property Buttons: TsuiSpinButtons read m_Button;

    published
        property Anchors;
        property AutoSelect;
        property AutoSize;
        property Color;
        property Constraints;
        property Ctl3D;
        property DragCursor;
        property DragMode;
        property EditorEnabled: Boolean read m_EditorEnabled write m_EditorEnabled default True;
        property Enabled;
        property Font;
        property Increment: Integer read m_Increment write m_Increment;
        property MaxLength;
        property MaxValue: Integer read m_MaxValue write m_MaxValue;
        property MinValue: Integer read m_MinValue write m_MinValue;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ReadOnly;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Value: Integer read GetValue write SetValue;
        property Visible;
        property OnChange;
        property OnClick;
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


implementation

uses SUIPublic;

{ TsuiEdit }

constructor TsuiEdit.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 2;

    UIStyle := GetSUIFormStyle(AOwner);
end;


procedure TsuiEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        SetUIStyle(SUI_THEME_DEFAULT);          
    end;
end;

procedure TsuiEdit.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiEdit.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiEdit.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR)
    else
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
    UIStyleChanged();
    Repaint();
end;

procedure TsuiEdit.UIStyleChanged;
begin
    // do nothing
end;

procedure TsuiEdit.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiEdit.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

{ TsuiMaskEdit }

constructor TsuiMaskEdit.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 2;

    UIStyle := GetSUIFormStyle(AOwner);
end;

procedure TsuiMaskEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        SetUIStyle(SUI_THEME_DEFAULT);          
    end;
end;

procedure TsuiMaskEdit.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiMaskEdit.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiMaskEdit.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR)
    else
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
    Repaint();
end;

procedure TsuiMaskEdit.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiMaskEdit.WMPAINT(var Msg: TMessage);
begin
    inherited;
    DrawControlBorder(self, m_BorderColor, Color);
end;

{ TsuiNumberEdit }

procedure TsuiNumberEdit.Change;
var
    S : String;
begin
    if (Text <> '') and (Text <> '-') then
    begin
        try
            S := StringReplace(Text, ThousandSeparator, '', [rfReplaceAll]); 
            m_Value := StrToFloat(S);
        except
        on E: EConvertError do
        begin
            SetValue(Value);
            raise;
        end;
        end;
    end;
    inherited;
end;

procedure TsuiNumberEdit.Click;
begin
    inherited;
    DoEnter;
end;

procedure TsuiNumberEdit.CMTextChanged(var Message: TMessage);
begin
    inherited;
    Change();
end;

constructor TsuiNumberEdit.Create(AOwner: TComponent);
begin
    inherited;
    Mask := '0.00';
    Value := 0;
    AutoSelectSigns := 2;
end;

procedure TsuiNumberEdit.CreateParams(var Params: TCreateParams);
begin
    inherited;
    Params.Style := Params.Style + ES_RIGHT;
end;

procedure TsuiNumberEdit.DoEnter;
begin
    inherited;
    if (AutoSelectSigns > 0) and AutoSelect then
    begin
        SelStart := Length(Text) - AutoSelectSigns;
        SelLength := AutoSelectSigns;
    end;
end;

procedure TsuiNumberEdit.DoExit;
var
    S : String;
begin
    inherited;
    if (Text = '') or (Text = '-') then
        Text := '0';
    S := StringReplace(Text, ThousandSeparator, '', [rfReplaceAll]);
    SetValue(StrToFloat(S));
end;

procedure TsuiNumberEdit.KeyPress(var Key: Char);
    function AnsiContainsText(const AText, ASubText: string): Boolean;
    begin
        Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
    end;
var
    IsValidKey: Boolean;
begin
    inherited;
    IsValidKey := (Key in ['0'..'9'])
        or ((AnsiContainsText(Mask, '.')
        and ((Key = DecimalSeparator)
        and not (AnsiContainsText(Text, DecimalSeparator)))))
        or (Ord(Key) = VK_BACK)
        or (AnsiContainsText(Mask, '-')
        and ((GetSelStart = 0)
        and (Key = '-'))
        and not (AnsiContainsText(Text, '-')));
    if not IsValidKey then
    begin
        Beep();
        Abort();
    end;
end;

procedure TsuiNumberEdit.SetValue(Value: Real);
begin
    m_Value := Value;
    Text := FormatFloat(m_Mask, Value);
end;

{ TsuiSpinButtons }

procedure TsuiSpinButtons.AdjustSize(var W, H: Integer);
begin
    if (m_UpButton = nil) or (csLoading in ComponentState) then
        Exit;
    if W < 15 then
        W := 15;
    m_UpButton.SetBounds(0, 0, W, H div 2 + 1);
    m_DownButton.SetBounds(0, m_UpButton.Height - 1, W, H - m_UpButton.Height + 1);
end;

procedure TsuiSpinButtons.BtnClick(Sender: TObject);
begin
    if Sender = m_UpButton then
    begin
        if Assigned(m_OnUpClick) then m_OnUpClick(Self);
    end
    else
    begin
        if Assigned(m_OnDownClick) then m_OnDownClick(Self);
    end;
end;

constructor TsuiSpinButtons.Create(AOwner: TComponent);
begin
    inherited;
    ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] +
        [csFramed, csOpaque];
    m_UpButton := CreateButton;
    m_UpButton.Arrow := suiUp;
    m_DownButton := CreateButton;
    m_DownButton.Arrow := suiDown;
    Width := 20;
    Height := 25;
end;

function TsuiSpinButtons.CreateButton: TsuiArrowButton;
begin
    Result := TsuiArrowButton.Create(Self);
    Result.TabStop := False;
    Result.OnClick := BtnClick;
    Result.OnMouseContinuouslyDown := BtnClick;
    Result.MouseContinuouslyDownInterval := 400;
    Result.Visible := True;
    Result.Enabled := True;
    Result.Parent := Self;
end;

function TsuiSpinButtons.GetFileTheme: TsuiFileTheme;
begin
    Result := nil;
    if m_UpButton <> nil then
        Result := m_UpButton.FileTheme;
end;

function TsuiSpinButtons.GetUIStyle: TsuiUIStyle;
begin
    Result := SUI_THEME_DEFAULT;
    if m_UpButton <> nil then
        Result := m_UpButton.UIStyle;
end;

procedure TsuiSpinButtons.KeyDown(var Key: Word; Shift: TShiftState);
begin
    case Key of

    VK_UP: m_UpButton.Click;
    VK_DOWN: m_DownButton.Click;

    end;
end;

procedure TsuiSpinButtons.Loaded;
var
    W, H: Integer;
begin
    inherited;
    W := Width;
    H := Height;
    AdjustSize(W, H);
    if (W <> Width) or (H <> Height) then
        inherited SetBounds(Left, Top, W, H);
end;

procedure TsuiSpinButtons.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
    W, H: Integer;
begin
    W := AWidth;
    H := AHeight;
    AdjustSize(W, H);
    inherited;
end;

procedure TsuiSpinButtons.SetFileTheme(const Value: TsuiFileTheme);
begin
    if m_UpButton <> nil then
        m_UpButton.FileTheme := Value;
    if m_DownButton <> nil then
        m_DownButton.FileTheme := Value;
    SetUIStyle(UIStyle);
end;

procedure TsuiSpinButtons.SetUIStyle(const Value: TsuiUIStyle);
begin
    if m_UpButton <> nil then
        m_UpButton.UIStyle := Value;
    if m_DownButton <> nil then
        m_DownButton.UIStyle := Value;
end;

procedure TsuiSpinButtons.WMSize(var Message: TWMSize);
var
    W, H: Integer;
begin
    inherited;
    { check for minimum size }
    W := Width;
    H := Height;
    AdjustSize(W, H);
    if (W <> Width) or (H <> Height) then
        inherited SetBounds(Left, Top, W, H);
    Message.Result := 0;
end;

{ TsuiSpinEdit }

function TsuiSpinEdit.CheckValue(NewValue: Integer): Integer;
begin
    Result := NewValue;
    if (m_MaxValue <> m_MinValue) then
    begin
        if NewValue < m_MinValue then
            Result := m_MinValue
        else if NewValue > m_MaxValue then
            Result := m_MaxValue;
    end;
end;

procedure TsuiSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
    if AutoSelect and not (csLButtonDown in ControlState) then
        SelectAll();
    inherited;
end;

procedure TsuiSpinEdit.CMExit(var Message: TCMExit);
begin
    inherited;
    if CheckValue(Value) <> Value then
        SetValue(Value);
end;

constructor TsuiSpinEdit.Create(AOwner: TComponent);
begin
    inherited;

    m_Button := TsuiSpinButtons.Create(Self);
    m_Button.Width := 15;
    m_Button.Height := 20;
    m_Button.Visible := True;
    m_Button.Parent := Self;
    m_Button.OnUpClick := UpClick;
    m_Button.OnDownClick := DownClick;
    Text := '0';
    m_Increment := 1;
    m_EditorEnabled := True;
end;

procedure TsuiSpinEdit.CreateParams(var Params: TCreateParams);
begin
    inherited;
    Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TsuiSpinEdit.CreateWnd;
begin
    inherited;
    SetEditRect();
end;

destructor TsuiSpinEdit.Destroy;
begin
    m_Button.Free();
    m_Button := nil;
    inherited;
end;

procedure TsuiSpinEdit.DownClick(Sender: TObject);
begin
    if ReadOnly then
        MessageBeep(0)
    else
        Value := Value - m_Increment;
end;

procedure TsuiSpinEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
    // do nothing
end;

function TsuiSpinEdit.GetValue: Integer;
begin
    try
        Result := StrToInt(Text);
    except
        Result := m_MinValue;
    end;
end;

function TsuiSpinEdit.IsValidChar(Key: Char): Boolean;
begin
    Result :=
        (Key in ['-', '0'..'9']) or
        ((Key < #32) and (Key <> Chr(VK_RETURN)));

    if not m_EditorEnabled and Result and ((Key >= #32) or
        (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
            Result := False;
end;

procedure TsuiSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
    if Key = VK_UP then
        UpClick(Self)
    else if Key = VK_DOWN then
        DownClick(Self);
    inherited;
end;

procedure TsuiSpinEdit.KeyPress(var Key: Char);
begin
    if not IsValidChar(Key) then
    begin
        Key := #0;
        MessageBeep(0)
    end;
    if Key <> #0 then
        inherited;
end;

procedure TsuiSpinEdit.SetEditRect;
var
    Loc: TRect;
begin
    SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
    Loc.Bottom := ClientHeight + 1;
    Loc.Right := ClientWidth - m_Button.Width - 2;
    Loc.Top := 0;
    Loc.Left := 0;
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
    SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc)); {debug}
end;

procedure TsuiSpinEdit.SetValue(NewValue: Integer);
begin
    Text := CurrToStr(CheckValue(NewValue));
end;

procedure TsuiSpinEdit.UIStyleChanged;
begin
    if m_Button <> nil then
    begin
        m_Button.UIStyle := UIStyle;
        m_Button.FileTheme := FileTheme;
    end;
end;

procedure TsuiSpinEdit.UpClick(Sender: TObject);
begin
    if ReadOnly then
        MessageBeep(0)
    else
        Value := Value + m_Increment;
end;

procedure TsuiSpinEdit.WMCut(var Message: TWMCut);
begin
    if not m_EditorEnabled or ReadOnly then
        Exit;
    inherited;
end;

procedure TsuiSpinEdit.WMPaste(var Message: TWMPaste);
begin
    if not m_EditorEnabled or ReadOnly then
        Exit;
    inherited;
end;

procedure TsuiSpinEdit.WMSize(var Message: TWMSize);
var
    MinHeight: Integer;
begin
    inherited;
    MinHeight := 0;
    if Height < MinHeight then
        Height := MinHeight
    else if m_Button <> nil then
    begin
        m_Button.SetBounds(Width - m_Button.Width - 4, 0, m_Button.Width, Height - 4);
        SetEditRect();
    end;
end;

end.
