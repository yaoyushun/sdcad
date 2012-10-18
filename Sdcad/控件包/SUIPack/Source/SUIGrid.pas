////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIGrid.pas
//  Creator     :   Shen Min
//  Date        :   2003-04-03 V1-V3
//                  3003-07-04 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIGrid;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, Grids, Graphics, Forms,
     SUIThemes, SUIScrollBar, SUIMgr, StdCtrls;

type
{$IFDEF SUIPACK_D5}
    TsuiCustomDrawGrid = class(TDrawGrid)
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    TsuiCustomDrawGrid = class(TCustomDrawGrid)
{$ENDIF}
    private
        m_BorderColor : TColor;
        m_FocusedColor : TColor;
        m_SelectedColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_FixedFontColor: TColor;
        m_MouseDown : Boolean;        

        // scroll bar
        m_VScrollBar : TsuiScrollBar;
        m_HScrollBar : TsuiScrollBar;
        m_SelfChanging : Boolean;
        m_UserChanging : Boolean;

        procedure SetHScrollBar(const Value: TsuiScrollBar);
        procedure SetVScrollBar(const Value: TsuiScrollBar);
        procedure OnHScrollBarChange(Sender : TObject);
        procedure OnVScrollBarChange(Sender : TObject);
        procedure UpdateScrollBars();
        procedure UpdateScrollBarsPos();
        procedure UpdateInnerScrollBars();

        procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
        procedure CMVisibleChanged(var Msg : TMEssage); message CM_VISIBLECHANGED;
        procedure WMSIZE(var Msg : TMessage); message WM_SIZE;
        procedure WMMOVE(var Msg : TMessage); message WM_MOVE;
        procedure WMCut(var Message: TMessage); message WM_Cut;
        procedure WMPaste(var Message: TMessage); message WM_PASTE;
        procedure WMClear(var Message: TMessage); message WM_CLEAR;
        procedure WMUndo(var Message: TMessage); message WM_UNDO;
        procedure WMLBUTTONDOWN(var Message: TMessage); message WM_LBUTTONDOWN;
        procedure WMLButtonUp(var Message: TMessage); message WM_LBUTTONUP;
        procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
        procedure WMSetText(var Message:TWMSetText); message WM_SETTEXT;
        procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
        procedure WMMOUSEMOVE(var Message: TMessage); message WM_MOUSEMOVE;
        procedure WMVSCROLL(var Message: TWMVScroll); message WM_VSCROLL;
        procedure WMHSCROLL(var Message: TWMHScroll); message WM_HSCROLL;

        procedure SetBorderColor(const Value: TColor);
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFocusedColor(const Value: TColor);
        procedure SetSelectedColor(const Value: TColor);
        procedure SetFixedFontColor(const Value: TColor);
        function GetCtl3D: Boolean;
        procedure SetFontColor(const Value: TColor);
        function GetFontColor: TColor;
        procedure SetFileTheme(const Value: TsuiFileTheme);

    protected
        procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
        procedure Paint(); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create (AOwner: TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property Color;
        property FixedColor;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property FocusedColor : TColor read m_FocusedColor write SetFocusedColor;
        property SelectedColor : TColor read m_SelectedColor write SetSelectedColor;
        property FixedFontColor : TColor read m_FixedFontColor write SetFixedFontColor;
        property FontColor : TColor read GetFontColor write SetFontColor;
        property Ctl3D read GetCtl3D;
        // scroll bar
        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;

    end;

    TsuiDrawGrid = class(TsuiCustomDrawGrid)
    published
        property Align;
        property Anchors;
        property BiDiMode;
        property BorderStyle;
        property ColCount;
        property Constraints;
        property DefaultColWidth;
        property DefaultRowHeight;
        property DefaultDrawing;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property FixedCols;
        property RowCount;
        property FixedRows;
        property Font;
        property GridLineWidth;
        property Options;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ScrollBars;
        property ShowHint;
        property TabOrder;
        property Visible;
        property VisibleColCount;
        property VisibleRowCount;
        property OnClick;
        property OnColumnMoved;
        property OnContextPopup;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnDrawCell;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnGetEditMask;
        property OnGetEditText;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnMouseWheelDown;
        property OnMouseWheelUp;
        property OnRowMoved;
        property OnSelectCell;
        property OnSetEditText;
        property OnStartDock;
        property OnStartDrag;
        property OnTopLeftChanged;

    end;

    TsuiStringGrid = class(TStringGrid)
    private
        m_BorderColor : TColor;
        m_FocusedColor : TColor;
        m_SelectedColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FixedFontColor: TColor;
        m_FileTheme : TsuiFileTheme;
        m_MouseDown : Boolean;

        // scroll bar
        m_VScrollBar : TsuiScrollBar;
        m_HScrollBar : TsuiScrollBar;
        m_SelfChanging : Boolean;
        m_UserChanging : Boolean;

        procedure SetHScrollBar(const Value: TsuiScrollBar);
        procedure SetVScrollBar(const Value: TsuiScrollBar);
        procedure OnHScrollBarChange(Sender : TObject);
        procedure OnVScrollBarChange(Sender : TObject);
        procedure UpdateScrollBars();
        procedure UpdateScrollBarsPos();
        procedure UpdateInnerScrollBars();

        procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
        procedure CMVisibleChanged(var Msg : TMEssage); message CM_VISIBLECHANGED;
        procedure CMBIDIMODECHANGED(var Msg : TMessage); message CM_BIDIMODECHANGED;        
        procedure WMSIZE(var Msg : TMessage); message WM_SIZE;
        procedure WMMOVE(var Msg : TMessage); message WM_MOVE;
        procedure WMCut(var Message: TMessage); message WM_Cut;
        procedure WMPaste(var Message: TMessage); message WM_PASTE;
        procedure WMClear(var Message: TMessage); message WM_CLEAR;
        procedure WMUndo(var Message: TMessage); message WM_UNDO;
        procedure WMLBUTTONDOWN(var Message: TMessage); message WM_LBUTTONDOWN;
        procedure WMLButtonUp(var Message: TMessage); message WM_LBUTTONUP;
        procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
        procedure WMSetText(var Message:TWMSetText); message WM_SETTEXT;
        procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
        procedure WMMOUSEMOVE(var Message: TMessage); message WM_MOUSEMOVE;
        procedure WMVSCROLL(var Message: TWMVScroll); message WM_VSCROLL;
        procedure WMHSCROLL(var Message: TWMHScroll); message WM_HSCROLL;

        procedure SetBorderColor(const Value: TColor);
        procedure SetFocusedColor(const Value: TColor);
        procedure SetSelectedColor(const Value: TColor);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFixedFontColor(const Value: TColor);
        function GetCtl3D: Boolean;
        procedure SetFontColor(const Value: TColor);
        function GetFontColor: TColor;
        procedure SetFileTheme(const Value: TsuiFileTheme);
        function GetBGColor: TColor;
        procedure SetBGColor(const Value: TColor);
        function GetFixedBGColor: TColor;
        procedure SetFixedBGColor(const Value: TColor);

        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

    protected
        procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
        procedure Paint(); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create (AOwner: TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;

        property BGColor : TColor read GetBGColor write SetBGColor;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property FocusedColor : TColor read m_FocusedColor write SetFocusedColor;
        property SelectedColor : TColor read m_SelectedColor write SetSelectedColor;
        property FixedFontColor : TColor read m_FixedFontColor write SetFixedFontColor;
        property FixedBGColor : TColor read GetFixedBGColor write SetFixedBGColor;
        property FontColor : TColor read GetFontColor write SetFontColor;
        property Ctl3D read GetCtl3D;
        // scroll bar
        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;

    end;


implementation

uses SUIPublic, SUIProgressBar;

{ TsuiCustomDrawGrid }

procedure TsuiCustomDrawGrid.CMEnabledChanged(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.CMVisibleChanged(var Msg: TMEssage);
begin
    inherited;

    if not Visible then
    begin
        if m_VScrollBar <> nil then
            m_VScrollBar.Visible := Visible;
        if m_HScrollBar <> nil then
            m_HScrollBar.Visible := Visible;
    end
    else
        UpdateScrollBarsPos();
end;

constructor TsuiCustomDrawGrid.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 1;
    UIStyle := GetSUIFormStyle(AOwner);
    m_MouseDown := false;
    FocusedColor := clGreen;
    SelectedColor := clYellow;
    ParentCtl3D := false;
    inherited Ctl3D := false;
end;

procedure TsuiCustomDrawGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
    R : TRect;
begin
    if not DefaultDrawing then
    begin
        inherited;
        exit;
    end;

    R := ARect;

    try
        if gdFixed in AState then
            Exit;

        if gdSelected in AState then
        begin
            Canvas.Brush.Color := m_SelectedColor;
        end;

        if gdFocused in AState then
        begin
            Canvas.Brush.Color := m_FocusedColor;
        end;

        if AState = [] then
            Canvas.Brush.Color := Color;

        Canvas.FillRect(R);
    finally
        inherited;
    end;
end;

function TsuiCustomDrawGrid.GetCtl3D: Boolean;
begin
    Result := false;
end;

function TsuiCustomDrawGrid.GetFontColor: TColor;
begin
    Result := Font.Color;
end;

procedure TsuiCustomDrawGrid.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if (
        (Operation = opRemove) and
        (AComponent = m_HScrollBar)
    )then
    begin
        m_HScrollBar := nil;
        UpdateInnerScrollBars();
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_VScrollBar)
    )then
    begin
        m_VScrollBar := nil;
        UpdateInnerScrollBars();
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        SetUIStyle(SUI_THEME_DEFAULT);
    end;
end;

procedure TsuiCustomDrawGrid.OnHScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiCustomDrawGrid.OnVScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiCustomDrawGrid.Paint;
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiCustomDrawGrid.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiCustomDrawGrid.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiCustomDrawGrid.SetFixedFontColor(const Value: TColor);
begin
    m_FixedFontColor := Value;
    Repaint();
end;

procedure TsuiCustomDrawGrid.SetFocusedColor(const Value: TColor);
begin
    m_FocusedColor := Value;
    Repaint();
end;

procedure TsuiCustomDrawGrid.SetFontColor(const Value: TColor);
begin
    Font.Color := Value;
    Repaint();
end;

procedure TsuiCustomDrawGrid.SetHScrollBar(const Value: TsuiScrollBar);
begin
    if m_HScrollBar = Value then
        Exit;
    if m_HScrollBar <> nil then
    begin
        m_HScrollBar.OnChange := nil;
        m_HScrollBar.LineButton := 0;
        m_HScrollBar.Max := 100;
        m_HScrollBar.Enabled := true;
    end;

    m_HScrollBar := Value;
    if m_HScrollBar = nil then
    begin
        UpdateInnerScrollBars();
        Exit;
    end;
    m_HScrollBar.Orientation := suiHorizontal;
    m_HScrollBar.OnChange := OnHScrollBarChange;
    m_HScrollBar.BringToFront();
    UpdateInnerScrollBars();

    UpdateScrollBarsPos();
end;

procedure TsuiCustomDrawGrid.SetSelectedColor(const Value: TColor);
begin
    m_SelectedColor := Value;
    Repaint();
end;

procedure TsuiCustomDrawGrid.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        FixedColor := m_FileTheme.GetColor(SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
        Color := m_FileTheme.GetColor(SUI_THEME_CONTROL_BACKGROUND_COLOR);
        FixedFontColor := m_FileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR);
        Font.Color := m_FileTheme.GetColor(SUI_THEME_MENU_FONT_COLOR);
	if (Font.Color = clWhite) then
	    Font.Color := clBlack;
    end
    else
    begin
        BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        FixedColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
        Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BACKGROUND_COLOR);
        FixedFontColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);
        Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_FONT_COLOR);
	if (Font.Color = clWhite) then
	    Font.Color := clBlack;
    end;

    if m_VScrollBar <> nil then
        m_VScrollBar.UIStyle := OutUIStyle;
    if m_HScrollBar <> nil then
        m_HScrollBar.UIStyle := OutUIStyle;
end;

procedure TsuiCustomDrawGrid.SetVScrollBar(const Value: TsuiScrollBar);
begin
    if m_VScrollBar = Value then
        Exit;
    if m_VScrollBar <> nil then
    begin
        m_VScrollBar.OnChange := nil;
        m_VScrollBar.LineButton := 0;
        m_VScrollBar.Max := 100;
        m_VScrollBar.Enabled := true;
    end;

    m_VScrollBar := Value;
    if m_VScrollBar = nil then
    begin
        UpdateInnerScrollBars();
        Exit;
    end;
    m_VScrollBar.Orientation := suiVertical;
    m_VScrollBar.OnChange := OnVScrollBArChange;
    m_VScrollBar.BringToFront();
    UpdateInnerScrollBars();

    UpdateScrollBarsPos();
end;

procedure TsuiCustomDrawGrid.UpdateInnerScrollBars;
begin
    if (m_VScrollBar <> nil) and (m_HScrollBar <> nil) then
        ScrollBars := ssBoth
    else if (m_VScrollBar <> nil) and (m_HScrollBar = nil) then
        ScrollBars := ssVertical
    else if (m_HScrollBar <> nil) and (m_VScrollBar = nil) then
        ScrollBars := ssHorizontal
    else
        ScrollBars := ssNone;
end;

procedure TsuiCustomDrawGrid.UpdateScrollBars;
var
    info : tagScrollInfo;
    barinfo : tagScrollBarInfo;
    L2R : Boolean;
begin
    if m_UserChanging then
        Exit;
    L2R := ((BidiMode = bdLeftToRight) or (BidiMode = bdRightToLeftReadingOnly)) or (not SysLocale.MiddleEast);
    m_SelfChanging := true;
    if m_HScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        if not SUIGetScrollBarInfo(Handle, Integer(OBJID_HSCROLL), barinfo) then
        begin
            m_HScrollBar.Visible := false;
        end
        else if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not Enabled) then
        begin
            m_HScrollBar.LineButton := 0;
            m_HScrollBar.Enabled := false;
            m_HScrollBar.SliderVisible := false;
        end
        else
        begin
            m_HScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_HScrollBar.SmallChange := 3 * m_HScrollBar.PageSize;
            m_HScrollBar.Enabled := true;
            m_HScrollBar.SliderVisible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_HORZ, info);
        m_HScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_HScrollBar.Min := info.nMin;
        if L2R then
            m_HScrollBar.Position := info.nPos
        else
            m_HScrollBar.Position := m_HScrollBar.Max - info.nPos;
    end;

    if m_VScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        if not SUIGetScrollBarInfo(Handle, Integer(OBJID_VSCROLL), barinfo) then
        begin
            m_VScrollBar.Visible := false;
        end
        else if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not Enabled) then
        begin
            m_VScrollBar.LineButton := 0;
            m_VScrollBar.Enabled := false;
            m_VScrollBar.SliderVisible := false;
        end
        else
        begin
            m_VScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_VScrollBar.Enabled := true;
            m_VScrollBar.SliderVisible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_VERT, info);
        m_VScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_VScrollBar.Min := info.nMin;
        m_VScrollBar.Position := info.nPos;
    end;
    m_SelfChanging := false;
end;

procedure TsuiCustomDrawGrid.UpdateScrollBarsPos;
var
    L2R : Boolean;
begin
    L2R := ((BidiMode = bdLeftToRight) or (BidiMode = bdRightToLeftReadingOnly)) or (not SysLocale.MiddleEast);
    if m_HScrollBar <> nil then
    begin
        if Height < m_HScrollBar.Height then
            m_HScrollBar.Visible := false
        else
            m_HScrollBar.Visible := true;
        if L2R then
        begin
            m_HScrollBar.Left := Left + 1;
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 1;
            if m_VScrollBar <> nil then
                m_HScrollBar.Width := Width - 1 - m_VScrollBar.Width
            else
                m_HScrollBar.Width := Width - 1
        end
        else
        begin
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 1;
            if m_VScrollBar <> nil then
            begin
                m_HScrollBar.Left := Left + m_VScrollBar.Width + 1;
                m_HScrollBar.Width := Width - 1 - m_VScrollBar.Width
            end
            else
            begin
                m_HScrollBar.Left := Left + 1;
                m_HScrollBar.Width := Width - 1;
            end;
        end;
    end;

    if m_VScrollBar <> nil then
    begin
        if Width < m_VScrollBar.Width then
            m_VScrollBar.Visible := false
        else
            m_VScrollBar.Visible := true;
        if L2R then
        begin
            m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 1;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 1 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 1;
        end
        else
        begin
            m_VScrollBar.Left := Left + 1;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 1 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 1;
        end;
    end;

    UpdateScrollBars();    
end;

procedure TsuiCustomDrawGrid.WMClear(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMCut(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMEARSEBKGND(var Msg: TMessage);
begin
    Paint();
end;

procedure TsuiCustomDrawGrid.WMHSCROLL(var Message: TWMHScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMKeyDown(var Message: TWMKeyDown);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMLBUTTONDOWN(var Message: TMessage);
begin
    inherited;
    m_MouseDown := true;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMLButtonUp(var Message: TMessage);
begin
    inherited;
    m_MouseDown := false;
end;

procedure TsuiCustomDrawGrid.WMMOUSEMOVE(var Message: TMessage);
begin
    inherited;
    if m_MouseDown then UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMMOUSEWHEEL(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMMOVE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiCustomDrawGrid.WMPaste(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMSetText(var Message: TWMSetText);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMSIZE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiCustomDrawGrid.WMUndo(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCustomDrawGrid.WMVSCROLL(var Message: TWMVScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

{ TsuiStringGrid }

procedure TsuiStringGrid.CMBIDIMODECHANGED(var Msg: TMessage);
var
    L2R : Boolean;
    info : tagScrollInfo;    
begin
    inherited;
    
    L2R := ((BidiMode = bdLeftToRight) or (BidiMode = bdRightToLeftReadingOnly)) or (not SysLocale.MiddleEast);
    if (not L2R) and (m_HScrollBar <> nil) then
    begin
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_HORZ, info);
        m_HScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_HScrollBar.Min := info.nMin;
        m_HScrollBar.Position := m_HScrollBar.Max - info.nPos
    end;
end;

procedure TsuiStringGrid.CMEnabledChanged(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.CMVisibleChanged(var Msg: TMEssage);
begin
    inherited;

    if not Visible then
    begin
        if m_VScrollBar <> nil then
            m_VScrollBar.Visible := Visible;
        if m_HScrollBar <> nil then
            m_HScrollBar.Visible := Visible;
    end
    else
        UpdateScrollBarsPos();
end;

constructor TsuiStringGrid.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 1;
    UIStyle := GetSUIFormStyle(AOwner);
    FocusedColor := clLime;
    SelectedColor := clYellow;
    ParentCtl3D := false;
    m_MouseDown := false;
    inherited Ctl3D := false;
end;

procedure TsuiStringGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
    R : TRect;
begin
    if not DefaultDrawing then
    begin
        inherited;
        exit;
    end;

    R := ARect;

    try
        if gdFixed in AState then
            Exit;

        if gdSelected in AState then
        begin
            Canvas.Brush.Color := m_SelectedColor;
        end;

        if gdFocused in AState then
        begin
            Canvas.Brush.Color := m_FocusedColor;
        end;

        if AState = [] then
            Canvas.Brush.Color := Color;

        Canvas.FillRect(R);

    finally

        if gdFixed in AState then
        begin
            Canvas.Font.Color := m_FixedFontColor;
            Canvas.TextRect(ARect, ARect.Left + 2, ARect.Top + 2, Cells[ACol, ARow]);
        end;

        inherited;
    end;
end;

function TsuiStringGrid.GetBGColor: TColor;
begin
    Result := Color;
end;

function TsuiStringGrid.GetCtl3D: Boolean;
begin
    Result := false;
end;

function TsuiStringGrid.GetFixedBGColor: TColor;
begin
    Result := FixedColor;
end;

function TsuiStringGrid.GetFontColor: TColor;
begin
    Result := Font.Color;
end;

procedure TsuiStringGrid.Notification(AComponent: TComponent;
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

    if (
        (Operation = opRemove) and
        (AComponent = m_HScrollBar)
    )then
    begin
        m_HScrollBar := nil;
        UpdateInnerScrollBars();
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_VScrollBar)
    )then
    begin
        m_VScrollBar := nil;
        UpdateInnerScrollBars();
    end;
end;

procedure TsuiStringGrid.OnHScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiStringGrid.OnVScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiStringGrid.Paint;
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color, false);
end;

procedure TsuiStringGrid.SetBGColor(const Value: TColor);
begin
    Color := Value;
end;

procedure TsuiStringGrid.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiStringGrid.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiStringGrid.SetFixedBGColor(const Value: TColor);
begin
    FixedColor := Value;
end;

procedure TsuiStringGrid.SetFixedFontColor(const Value: TColor);
begin
    m_FixedFontColor := Value;
    Repaint();
end;

procedure TsuiStringGrid.SetFocusedColor(const Value: TColor);
begin
    m_FocusedColor := Value;
    Repaint();
end;

procedure TsuiStringGrid.SetFontColor(const Value: TColor);
begin
    Font.Color := Value;
    Repaint();
end;

procedure TsuiStringGrid.SetHScrollBar(const Value: TsuiScrollBar);
begin
    if m_HScrollBar = Value then
        Exit;
    if m_HScrollBar <> nil then
    begin
        m_HScrollBar.OnChange := nil;
        m_HScrollBar.LineButton := 0;
        m_HScrollBar.Max := 100;
        m_HScrollBar.Enabled := true;
    end;

    m_HScrollBar := Value;
    if m_HScrollBar = nil then
    begin
        UpdateInnerScrollBars();
        Exit;
    end;
    m_HScrollBar.Orientation := suiHorizontal;
    m_HScrollBar.OnChange := OnHScrollBarChange;
    m_HScrollBar.BringToFront();
    UpdateInnerScrollBars();

    UpdateScrollBarsPos();
end;

procedure TsuiStringGrid.SetSelectedColor(const Value: TColor);
begin
    m_SelectedColor := Value;
    Repaint();
end;

procedure TsuiStringGrid.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        FixedColor := m_FileTheme.GetColor(SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
        Color := m_FileTheme.GetColor(SUI_THEME_CONTROL_BACKGROUND_COLOR);
        FixedFontColor := m_FileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR);
        Font.Color := m_FileTheme.GetColor(SUI_THEME_MENU_FONT_COLOR);
	if (Font.Color = clWhite) then
	    Font.Color := clBlack;
    end
    else
    begin
        BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        FixedColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
        Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BACKGROUND_COLOR);
        FixedFontColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);
        Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_FONT_COLOR);
	if (Font.Color = clWhite) then
	    Font.Color := clBlack;
    end;

    if m_VScrollBar <> nil then
        m_VScrollBar.UIStyle := OutUIStyle;
    if m_HScrollBar <> nil then
        m_HScrollBar.UIStyle := OutUIStyle;
end;

procedure TsuiStringGrid.SetVScrollBar(const Value: TsuiScrollBar);
begin
    if m_VScrollBar = Value then
        Exit;
    if m_VScrollBar <> nil then
    begin
        m_VScrollBar.OnChange := nil;
        m_VScrollBar.LineButton := 0;
        m_VScrollBar.Max := 100;
        m_VScrollBar.Enabled := true;
    end;

    m_VScrollBar := Value;
    if m_VScrollBar = nil then
    begin
        UpdateInnerScrollBars();
        Exit;
    end;
    m_VScrollBar.Orientation := suiVertical;
    m_VScrollBar.OnChange := OnVScrollBArChange;
    m_VScrollBar.BringToFront();
    UpdateInnerScrollBars();

    UpdateScrollBarsPos();
end;

procedure TsuiStringGrid.UpdateInnerScrollBars;
begin
    if (m_VScrollBar <> nil) and (m_HScrollBar <> nil) then
        ScrollBars := ssBoth
    else if (m_VScrollBar <> nil) and (m_HScrollBar = nil) then
        ScrollBars := ssVertical
    else if (m_HScrollBar <> nil) and (m_VScrollBar = nil) then
        ScrollBars := ssHorizontal
    else
        ScrollBars := ssNone;
end;

procedure TsuiStringGrid.UpdateScrollBars;
var
    info : tagScrollInfo;
    barinfo : tagScrollBarInfo;
begin
    if m_UserChanging then
        Exit;       
    m_SelfChanging := true;
    if m_HScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        if not SUIGetScrollBarInfo(Handle, Integer(OBJID_HSCROLL), barinfo) then
        begin
            m_HScrollBar.Visible := false;
        end
        else if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not Enabled) then
        begin
            m_HScrollBar.LineButton := 0;
            m_HScrollBar.Enabled := false;
            m_HScrollBar.SliderVisible := false;
        end
        else
        begin
            m_HScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_HScrollBar.SmallChange := 3 * m_HScrollBar.PageSize;
            m_HScrollBar.Enabled := true;
            m_HScrollBar.SliderVisible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_HORZ, info);
        m_HScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_HScrollBar.Min := info.nMin;
        m_HScrollBar.Position := info.nPos
    end;

    if m_VScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        if not SUIGetScrollBarInfo(Handle, Integer(OBJID_VSCROLL), barinfo) then
        begin
            m_VScrollBar.Visible := false;
        end
        else if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not Enabled) then
        begin
            m_VScrollBar.LineButton := 0;
            m_VScrollBar.Enabled := false;
            m_VScrollBar.SliderVisible := false;
        end
        else
        begin
            m_VScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_VScrollBar.Enabled := true;
            m_VScrollBar.SliderVisible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_VERT, info);
        m_VScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_VScrollBar.Min := info.nMin;
        m_VScrollBar.Position := info.nPos;
    end;
    m_SelfChanging := false;
end;

procedure TsuiStringGrid.UpdateScrollBarsPos;
var
    L2R : Boolean;
begin
    L2R := ((BidiMode = bdLeftToRight) or (BidiMode = bdRightToLeftReadingOnly)) or (not SysLocale.MiddleEast);
    if m_HScrollBar <> nil then
    begin
        if Height < m_HScrollBar.Height then
            m_HScrollBar.Visible := false
        else
            m_HScrollBar.Visible := true;
        if L2R then
        begin
            m_HScrollBar.Left := Left + 1;
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 1;
            if m_VScrollBar <> nil then
                m_HScrollBar.Width := Width - 1 - m_VScrollBar.Width
            else
                m_HScrollBar.Width := Width - 1
        end
        else
        begin
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 1;
            if m_VScrollBar <> nil then
            begin
                m_HScrollBar.Left := Left + m_VScrollBar.Width + 1;
                m_HScrollBar.Width := Width - 1 - m_VScrollBar.Width
            end
            else
            begin
                m_HScrollBar.Left := Left + 1;
                m_HScrollBar.Width := Width - 1;
            end;
        end;
    end;

    if m_VScrollBar <> nil then
    begin
        if Width < m_VScrollBar.Width then
            m_VScrollBar.Visible := false
        else
            m_VScrollBar.Visible := true;

        if L2R then
        begin
            m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 1;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 1 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 1;
        end
        else
        begin
            m_VScrollBar.Left := Left + 1;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 1 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 1;
        end;
    end;

    UpdateScrollBars();    
end;

procedure TsuiStringGrid.WMClear(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMCut(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMEARSEBKGND(var Msg: TMessage);
begin
    Paint();
end;

procedure TsuiStringGrid.WMHSCROLL(var Message: TWMHScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMKeyDown(var Message: TWMKeyDown);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMLBUTTONDOWN(var Message: TMessage);
begin
    inherited;
    m_MouseDown := true;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMLButtonUp(var Message: TMessage);
begin
    inherited;
    m_MouseDown := false;
end;

procedure TsuiStringGrid.WMMOUSEMOVE(var Message: TMessage);
begin
    inherited;
    if m_MouseDown then UpdateScrollBars();
end;

procedure TsuiStringGrid.WMMOUSEWHEEL(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMMOVE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiStringGrid.WMPaste(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMSetText(var Message: TWMSetText);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMSIZE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiStringGrid.WMUndo(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiStringGrid.WMVSCROLL(var Message: TWMVScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

end.
