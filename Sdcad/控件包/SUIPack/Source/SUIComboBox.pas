////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIComboBox.pas
//  Creator     :   Shen Min
//  Date        :   2002-09-29 V1-V3
//                  2003-06-24 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIComboBox;

interface

{$I SUIPack.inc}

uses SysUtils, Classes, Controls, StdCtrls, Graphics, Messages, Forms, Windows,
     filectrl, ComCtrls,
     SUIThemes, SUIMgr;

type
    TsuiCustomComboBox = class(TCustomComboBox)
    private
        m_BorderColor : TColor;
        m_ButtonColor : TColor;
        m_ArrowColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
{$IFDEF SUIPACK_D5}
        procedure CBNCloseUp(var Msg : TWMCommand); message CN_COMMAND;
{$ENDIF}
        procedure DrawButton();
        procedure DrawArrow(const ACanvas : TCanvas;X, Y : Integer);

        procedure SetArrowColor(const Value: TColor);
        procedure SetButtonColor(const Value: TColor);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);

    protected
        procedure SetEnabled(Value: Boolean); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$IFDEF SUIPACK_D5}
        procedure CloseUp(); virtual;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
        procedure CloseUp(); override;
{$ENDIF}

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property ArrowColor : TColor read m_ArrowColor write SetArrowColor;
        property ButtonColor : TColor read m_ButtonColor write SetButtonColor;

    end;

    TsuiComboBox = class(TsuiCustomComboBox)
    published
{$IFDEF SUIPACK_D6UP}
        property AutoComplete default True;
        property AutoDropDown default False;
{$ENDIF}
        property Style; {Must be published before Items}
        property Anchors;
        property BiDiMode;
        property CharCase;
        property Color;
        property Constraints;
        property Ctl3D;
        property DragCursor;
        property DragKind;
        property DragMode;
        property DropDownCount;
        property Enabled;
        property Font;
        property ImeMode;
        property ImeName;
        property ItemHeight;
        property ItemIndex default -1;
        property MaxLength;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ShowHint;
        property Sorted;
        property TabOrder;
        property TabStop;
        property Text;
        property Visible;

        property OnChange;
        property OnClick;
        property OnContextPopup;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnDrawItem;
        property OnDropDown;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMeasureItem;
        property OnStartDock;
        property OnStartDrag;
{$IFDEF SUIPACK_D6UP}
        property OnSelect;
{$ENDIF}
        property Items; { Must be published after OnMeasureItem }

    end;

    TsuiDriveComboBox = class(TDriveComboBox)
    private
        m_BorderColor : TColor;
        m_ButtonColor : TColor;
        m_ArrowColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
{$IFDEF SUIPACK_D5}
        procedure CBNCloseUp(var Msg : TWMCommand); message CN_COMMAND;
{$ENDIF}
        procedure DrawButton();
        procedure DrawArrow(const ACanvas : TCanvas;X, Y : Integer);

        procedure SetArrowColor(const Value: TColor);
        procedure SetButtonColor(const Value: TColor);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        function GetDroppedDown: Boolean;
        procedure SetDroppedDown(const Value: Boolean);

    protected
        procedure SetEnabled(Value: Boolean); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$IFDEF SUIPACK_D5}
        procedure CloseUp(); virtual;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
        procedure CloseUp(); override;
{$ENDIF}

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property ArrowColor : TColor read m_ArrowColor write SetArrowColor;
        property ButtonColor : TColor read m_ButtonColor write SetButtonColor;
        property DroppedDown: Boolean read GetDroppedDown write SetDroppedDown;
    end;

    TsuiFilterComboBox = class(TFilterComboBox)
    private
        m_BorderColor : TColor;
        m_ButtonColor : TColor;
        m_ArrowColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
{$IFDEF SUIPACK_D5}
        procedure CBNCloseUp(var Msg : TWMCommand); message CN_COMMAND;
{$ENDIF}
        procedure DrawButton();
        procedure DrawArrow(const ACanvas : TCanvas;X, Y : Integer);

        procedure SetArrowColor(const Value: TColor);
        procedure SetButtonColor(const Value: TColor);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        function GetDroppedDown: Boolean;
        procedure SetDroppedDown(const Value: Boolean);

    protected
        procedure SetEnabled(Value: Boolean); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
{$IFDEF SUIPACK_D5}
        procedure CloseUp(); virtual;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
        procedure CloseUp(); override;
{$ENDIF}

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property ArrowColor : TColor read m_ArrowColor write SetArrowColor;
        property ButtonColor : TColor read m_ButtonColor write SetButtonColor;
        property DroppedDown: Boolean read GetDroppedDown write SetDroppedDown;
    end;

implementation

uses SUIPublic, SUIResDef;

{ TsuiCustomComboBox }

{$IFDEF SUIPACK_D5}
procedure TsuiCustomComboBox.CBNCloseUp(var Msg: TWMCommand);
begin
    if Msg.NotifyCode = CBN_CLOSEUP then
        CloseUp()
    else
        inherited;
end;
{$ENDIF}

procedure TsuiCustomComboBox.CloseUp;
begin
    inherited;

    if Parent <> nil then
        Parent.Repaint();
end;

constructor TsuiCustomComboBox.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderWidth := 0;

    UIStyle := GetSUIFormStyle(AOwner);
end;

procedure TsuiCustomComboBox.DrawArrow(const ACanvas : TCanvas; X, Y: Integer);
begin
    if not Enabled then
    begin
        ACanvas.Brush.Color := clWhite;
        ACanvas.Pen.Color := clWhite;
        ACanvas.Polygon([Point(X + 1, Y + 1), Point(X + 7, Y + 1), Point(X + 4, Y + 4)]);
        ACanvas.Brush.Color := clGray;
        ACanvas.Pen.Color := clGray;
    end
    else
    begin
        ACanvas.Brush.Color := m_ArrowColor;
        ACanvas.Pen.Color := m_ArrowColor;
    end;

    ACanvas.Polygon([Point(X, Y), Point(X + 6, Y), Point(X + 3, Y + 3)]);
end;

procedure TsuiCustomComboBox.DrawButton;
var
    R, ListRect : TRect;
    X, Y : Integer;
    Btn : graphics.TBitmap;
    pcbi : tagCOMBOBOXINFO;
    C: TControlCanvas;
    DesktopCanvas : TCanvas;
begin
    pcbi.cbSize := SizeOf(pcbi);
    if not SUIGetComboBoxInfo(Handle, pcbi) then
        Exit;

    // draw border
    if Style <> csSimple then
    begin
        C := TControlCanvas.Create;

        C.Control := Self;
        with C do
        begin
            C.Brush.Color := m_BorderColor;
            R := ClientRect;
            FrameRect(R);
            C.Brush.Color := Color;
            InflateRect(R, -1, -1);
            FrameRect(R);
            GetWindowRect(pcbi.hwndList, ListRect);
            if DroppedDown then
            begin
                DesktopCanvas := TCanvas.Create();
                DesktopCanvas.Handle := GetWindowDC(0);
                DesktopCanvas.Brush.Color := m_BorderColor;
                DesktopCanvas.FrameRect(ListRect);
                ReleaseDC(0, DesktopCanvas.Handle);
                DesktopCanvas.Free();
            end
        end;
        // Draw button
        R := pcbi.rcButton;
        if {$IFDEF RES_MACOS} (m_UIStyle = MacOS) {$ELSE} false {$ENDIF} or
            {$IFDEF RES_WINXP} (m_UIStyle = WinXP) {$ELSE} false {$ENDIF} then
        begin
            Btn := graphics.TBitmap.Create();
    {$IFDEF RES_MACOS}
            if m_UIStyle = MacOS then
                Btn.LoadFromResourceName(hInstance, 'MACOS_COMBOBOX_BUTTON')
            else
    {$ENDIF}
                Btn.LoadFromResourceName(hInstance, 'WINXP_COMBOBOX_BUTTON');
            C.StretchDraw(R, Btn);
            Btn.Free();
        end
        else
        begin
            C.Brush.Color := m_ButtonColor;
            C.FillRect(R);
            C.Pen.Color := m_BorderColor;
            if (BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
            begin
                C.MoveTo(R.Right, R.Top - 1);
                C.LineTo(R.Right, R.Bottom + 1);
            end
            else
            begin
                C.MoveTo(R.Left, R.Top - 1);
                C.LineTo(R.Left, R.Bottom + 1);
            end;
        end;

        X := (R.Right - R.Left) div 2 + R.Left - 3;
        Y := (R.Bottom - R.Top) div 2;
        if {$IFDEF RES_WINXP} m_UIStyle <> WinXP {$ELSE} True {$ENDIF} then
            DrawArrow(C, X, Y);

        C.Free;
    end;
end;

procedure TsuiCustomComboBox.Notification(AComponent: TComponent;
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

procedure TsuiCustomComboBox.SetArrowColor(const Value: TColor);
begin
    m_ArrowColor := Value;
    Repaint();
end;

procedure TsuiCustomComboBox.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiCustomComboBox.SetButtonColor(const Value: TColor);
begin
    m_ButtonColor := Value;
    Repaint();
end;

procedure TsuiCustomComboBox.SetEnabled(Value: Boolean);
begin
    inherited;

    Repaint();
end;

procedure TsuiCustomComboBox.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiCustomComboBox.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;

    m_ArrowColor := clBlack;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
    end
    else
    begin
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
    end;

    Repaint();
end;

procedure TsuiCustomComboBox.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

procedure TsuiCustomComboBox.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

{ TsuiDriveComboBox }

{$IFDEF SUIPACK_D5}
procedure TsuiDriveComboBox.CBNCloseUp(var Msg: TWMCommand);
begin
    if Msg.NotifyCode = CBN_CLOSEUP then
        CloseUp()
    else
        inherited;
end;
{$ENDIF}

procedure TsuiDriveComboBox.CloseUp;
begin
    if Parent <> nil then
        Parent.Repaint();
end;


constructor TsuiDriveComboBox.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderWidth := 0;
    ItemHeight := 15;

    UIStyle := GetSUIFormStyle(AOwner);
end;

procedure TsuiDriveComboBox.DrawArrow(const ACanvas: TCanvas; X,
  Y: Integer);
begin
    if not Enabled then
    begin
        ACanvas.Brush.Color := clWhite;
        ACanvas.Pen.Color := clWhite;
        ACanvas.Polygon([Point(X + 1, Y + 1), Point(X + 7, Y + 1), Point(X + 4, Y + 4)]);
        ACanvas.Brush.Color := clGray;
        ACanvas.Pen.Color := clGray;
    end
    else
    begin
        ACanvas.Brush.Color := m_ArrowColor;
        ACanvas.Pen.Color := m_ArrowColor;
    end;

    ACanvas.Polygon([Point(X, Y), Point(X + 6, Y), Point(X + 3, Y + 3)]);
end;

procedure TsuiDriveComboBox.DrawButton;
var
    R, ListRect : TRect;
    X, Y : Integer;
    Btn : graphics.TBitmap;
    pcbi : tagCOMBOBOXINFO;
    C: TControlCanvas;
    DesktopCanvas : TCanvas;
begin
    pcbi.cbSize := SizeOf(pcbi);
    if not SUIGetComboBoxInfo(Handle, pcbi) then
        Exit;

    // draw border
    C := TControlCanvas.Create;

    C.Control := Self;
    with C do
    begin
        C.Brush.Color := m_BorderColor;
        R := ClientRect;
        FrameRect(R);
        C.Brush.Color := Color;
        InflateRect(R, -1, -1);
        FrameRect(R);
        GetWindowRect(pcbi.hwndList, ListRect);
        if DroppedDown then
        begin
            DesktopCanvas := TCanvas.Create();
            DesktopCanvas.Handle := GetWindowDC(0);
            DesktopCanvas.Brush.Color := m_BorderColor;
            DesktopCanvas.FrameRect(ListRect);
            ReleaseDC(0, DesktopCanvas.Handle);
            DesktopCanvas.Free();
        end
    end;

    // Draw button
    R := pcbi.rcButton;
    if {$IFDEF RES_MACOS} (m_UIStyle = MacOS) {$ELSE} false {$ENDIF} or
        {$IFDEF RES_WINXP} (m_UIStyle = WinXP) {$ELSE} false {$ENDIF} then
    begin
        Btn := graphics.TBitmap.Create();
{$IFDEF RES_MACOS}
        if m_UIStyle = MacOS then
            Btn.LoadFromResourceName(hInstance, 'MACOS_COMBOBOX_BUTTON')
        else
{$ENDIF}        
            Btn.LoadFromResourceName(hInstance, 'WINXP_COMBOBOX_BUTTON');
        C.StretchDraw(R, Btn);
        Btn.Free();
    end
    else
    begin
        C.Brush.Color := m_ButtonColor;
        C.FillRect(R);
        C.Pen.Color := m_BorderColor;
        if (BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
        begin
            C.MoveTo(R.Right, R.Top - 1);
            C.LineTo(R.Right, R.Bottom + 1);
        end
        else
        begin
            C.MoveTo(R.Left, R.Top - 1);
            C.LineTo(R.Left, R.Bottom + 1);
        end;
    end;

    X := (R.Right - R.Left) div 2 + R.Left - 3;
    Y := (R.Bottom - R.Top) div 2;
    if {$IFDEF RES_WINXP} m_UIStyle <> WinXP {$ELSE} True {$ENDIF} then
        DrawArrow(C, X, Y);

    C.Free;
end;

function TsuiDriveComboBox.GetDroppedDown: Boolean;
begin
    Result := LongBool(SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0));
end;

procedure TsuiDriveComboBox.Notification(AComponent: TComponent;
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

procedure TsuiDriveComboBox.SetArrowColor(const Value: TColor);
begin
    m_ArrowColor := Value;
    Repaint();
end;

procedure TsuiDriveComboBox.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiDriveComboBox.SetButtonColor(const Value: TColor);
begin
    m_ButtonColor := Value;
    Repaint();
end;

procedure TsuiDriveComboBox.SetDroppedDown(const Value: Boolean);
var
    R: TRect;
begin
    SendMessage(Handle, CB_SHOWDROPDOWN, Longint(Value), 0);
    R := ClientRect;
    InvalidateRect(Handle, @R, True);
end;

procedure TsuiDriveComboBox.SetEnabled(Value: Boolean);
begin
    inherited;
    Repaint();
end;

procedure TsuiDriveComboBox.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiDriveComboBox.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;

    m_ArrowColor := clBlack;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
    end
    else
    begin
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
    end;

    Repaint();
end;

procedure TsuiDriveComboBox.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

procedure TsuiDriveComboBox.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

{ TsuiFilterComboBox }

{$IFDEF SUIPACK_D5}
procedure TsuiFilterComboBox.CBNCloseUp(var Msg: TWMCommand);
begin
    if Msg.NotifyCode = CBN_CLOSEUP then
        CloseUp()
    else
        inherited;
end;
{$ENDIF}

procedure TsuiFilterComboBox.CloseUp;
begin
    if Parent <> nil then
        Parent.Repaint();
end;


constructor TsuiFilterComboBox.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderWidth := 0;
    ItemHeight := 15;

    UIStyle := GetSUIFormStyle(AOwner);
end;

procedure TsuiFilterComboBox.DrawArrow(const ACanvas: TCanvas; X,
  Y: Integer);
begin
    if not Enabled then
    begin
        ACanvas.Brush.Color := clWhite;
        ACanvas.Pen.Color := clWhite;
        ACanvas.Polygon([Point(X + 1, Y + 1), Point(X + 7, Y + 1), Point(X + 4, Y + 4)]);
        ACanvas.Brush.Color := clGray;
        ACanvas.Pen.Color := clGray;
    end
    else
    begin
        ACanvas.Brush.Color := m_ArrowColor;
        ACanvas.Pen.Color := m_ArrowColor;
    end;

    ACanvas.Polygon([Point(X, Y), Point(X + 6, Y), Point(X + 3, Y + 3)]);
end;

procedure TsuiFilterComboBox.DrawButton;
var
    R, ListRect : TRect;
    X, Y : Integer;
    Btn : graphics.TBitmap;
    pcbi : tagCOMBOBOXINFO;
    C: TControlCanvas;
    DesktopCanvas : TCanvas;
begin
    pcbi.cbSize := SizeOf(pcbi);
    if not SUIGetComboBoxInfo(Handle, pcbi) then
        Exit;

    // draw border
    C := TControlCanvas.Create;

    C.Control := Self;
    with C do
    begin
        C.Brush.Color := m_BorderColor;
        R := ClientRect;
        FrameRect(R);
        C.Brush.Color := Color;
        InflateRect(R, -1, -1);
        FrameRect(R);
        GetWindowRect(pcbi.hwndList, ListRect);
        if DroppedDown then
        begin
            DesktopCanvas := TCanvas.Create();
            DesktopCanvas.Handle := GetWindowDC(0);
            DesktopCanvas.Brush.Color := m_BorderColor;
            DesktopCanvas.FrameRect(ListRect);
            ReleaseDC(0, DesktopCanvas.Handle);
            DesktopCanvas.Free();
        end
    end;

    // Draw button
    R := pcbi.rcButton;
    if {$IFDEF RES_MACOS} (m_UIStyle = MacOS) {$ELSE} false {$ENDIF} or
        {$IFDEF RES_WINXP} (m_UIStyle = WinXP) {$ELSE} false {$ENDIF} then
    begin
        Btn := graphics.TBitmap.Create();
{$IFDEF RES_MACOS}
        if m_UIStyle = MacOS then
            Btn.LoadFromResourceName(hInstance, 'MACOS_COMBOBOX_BUTTON')
        else
{$ENDIF}        
            Btn.LoadFromResourceName(hInstance, 'WINXP_COMBOBOX_BUTTON');
        C.StretchDraw(R, Btn);
        Btn.Free();
    end
    else
    begin
        C.Brush.Color := m_ButtonColor;
        C.FillRect(R);
        C.Pen.Color := m_BorderColor;
        if (BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
        begin
            C.MoveTo(R.Right, R.Top - 1);
            C.LineTo(R.Right, R.Bottom + 1);
        end
        else
        begin
            C.MoveTo(R.Left, R.Top - 1);
            C.LineTo(R.Left, R.Bottom + 1);
        end;
    end;

    X := (R.Right - R.Left) div 2 + R.Left - 3;
    Y := (R.Bottom - R.Top) div 2;
    if {$IFDEF RES_WINXP} m_UIStyle <> WinXP {$ELSE} True {$ENDIF} then
        DrawArrow(C, X, Y);

    C.Free;
end;

function TsuiFilterComboBox.GetDroppedDown: Boolean;
begin
    Result := LongBool(SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0));
end;

procedure TsuiFilterComboBox.Notification(AComponent: TComponent;
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

procedure TsuiFilterComboBox.SetArrowColor(const Value: TColor);
begin
    m_ArrowColor := Value;
    Repaint();
end;

procedure TsuiFilterComboBox.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiFilterComboBox.SetButtonColor(const Value: TColor);
begin
    m_ButtonColor := Value;
    Repaint();
end;

procedure TsuiFilterComboBox.SetDroppedDown(const Value: Boolean);
var
    R: TRect;
begin
    SendMessage(Handle, CB_SHOWDROPDOWN, Longint(Value), 0);
    R := ClientRect;
    InvalidateRect(Handle, @R, True);
end;

procedure TsuiFilterComboBox.SetEnabled(Value: Boolean);
begin
    inherited;
    Repaint();
end;

procedure TsuiFilterComboBox.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiFilterComboBox.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;

    m_ArrowColor := clBlack;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
    end
    else
    begin
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        m_ButtonColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
    end;

    Repaint();
end;

procedure TsuiFilterComboBox.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

procedure TsuiFilterComboBox.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawButton();
end;

end.
