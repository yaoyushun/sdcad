////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUITabControl.pas
//  Creator     :   Shen Min
//  Date        :   2002-09-10 V1-V3
//                  2003-07-10 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUITabControl;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Forms, Graphics,
     ComCtrls, Math,
     SUIThemes, SUIMgr;

const
    SUI_TABCONTROL_MAXTABS      = 64;

type
    TsuiTabPosition = (suiTop, suiBottom);

    TsuiTab = class;

    TTabActiveNotify = procedure (Sender : TObject; TabIndex : Integer) of object;

    TsuiTabControlTopPanel = class(TCustomPanel)
    private
        m_Tabs : TStrings;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_TabIndex : Integer;
        m_LeftMargin : Integer;
        m_TabPos : array [0 .. SUI_TABCONTROL_MAXTABS - 1] of Integer;
        m_TabHeight : Integer;
        m_UserChanging : Boolean;
        m_Passed : Integer;
        m_ShowButton : Boolean;
        m_InButtons : Integer;
        m_BtnSize : TPoint;
        m_AutoFit : Boolean;
        m_ActiveTab, m_InactiveTab, m_Line : TBitmap;
        m_TabPosition : TsuiTabPosition;

        procedure OnTabsChange(Sender : TObject);
        procedure SetTabs(const Value: TStrings);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetLeftMargin(const Value: Integer);
        procedure SetTabIndex(const Value: Integer);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetTabPosition(const Value: TsuiTabPosition);
        
        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

        function PaintTabs(const Buf : TBitmap) : Integer;
        procedure PaintButtons(const Buf : TBitmap);

    protected
        m_TabControl : TsuiTab;

        procedure Paint(); override;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
        procedure RequestAlign; override;
        procedure Resize(); override;

    public
        m_TabVisible : array [0 .. SUI_TABCONTROL_MAXTABS - 1] of Boolean;

        constructor Create(AOwner : TComponent; TabControl : TsuiTab); reintroduce;
        destructor Destroy(); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property Tabs : TStrings read m_Tabs write SetTabs;
        property TabIndex : Integer read m_TabIndex write SetTabIndex;
        property LeftMargin : Integer read m_LeftMargin write SetLeftMargin;
        property TabPosition : TsuiTabPosition read m_TabPosition write SetTabPosition;

    end;

    TsuiTab = class(TCustomPanel)
    private
        m_UIStyle : TsuiUIStyle;
        m_FileTheme: TsuiFileTheme;
        m_BorderColor : TColor;
        m_Font : TFont;
        m_TabPosition : TsuiTabPosition;
        m_OnTabActive : TTabActiveNotify;
        m_OnChange : TNotifyEvent;
        m_OnChanging : TTabChangingEvent;

        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetTabs(const Value: TStrings);
        function GetTabs() : TStrings;
        function GetLeftMargin: Integer;
        function GetTabIndex: Integer;
        procedure SetLeftMargin(const Value: Integer);
        procedure SetBorderColor(const Value: TColor);
        procedure SetFont(const Value: TFont);
        procedure SetTabPosition(const Value: TsuiTabPosition);
        procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
        procedure WMERASEBKGND(var Message : TMessage); message WM_ERASEBKGND;
        procedure TopPanelClick(Sender : TObject);
        procedure TopPanelDblClick(Sender : TObject);

    protected
        m_TopPanel : TsuiTabControlTopPanel;

        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        procedure Paint(); override;
        function CreateTopPanel() : TsuiTabControlTopPanel; virtual; abstract;
        procedure SetTabIndex(const Value: Integer); virtual;
        procedure BorderColorChanged(); virtual;
        procedure AlignControls(AControl: TControl; var Rect: TRect); override;
        procedure Resize(); override;

        property Tabs : TStrings read GetTabs write SetTabs;
        property TabIndex : Integer read GetTabIndex write SetTabIndex;
        procedure TabActive(TabIndex : Integer); virtual;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure UpdateUIStyle(UIStyle : TsuiUIStyle; FileTheme : TsuiFileTheme); virtual;

        property DockManager;

    published
        property Align;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property LeftMargin : Integer read GetLeftMargin write SetLeftMargin;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property Color;
        property Font : TFont read m_Font write SetFont;
        property Visible;
        property TabPosition : TsuiTabPosition read m_TabPosition write SetTabPosition;

        property Anchors;
        property BiDiMode;
        property Constraints;
        property UseDockManager default True;
        property DockSite;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property FullRepaint;
        property Locked;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ShowHint;
        property TabOrder;
        property TabStop;

        property OnCanResize;
        property OnClick;
        property OnConstrainedResize;
        property OnContextPopup;
        property OnDockDrop;
        property OnDockOver;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnGetSiteInfo;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnResize;
        property OnStartDock;
        property OnStartDrag;
        property OnUnDock;
        property OnTabActive : TTabActiveNotify read m_OnTabActive write m_OnTabActive;
        property OnChange : TNotifyEvent read m_OnChange write m_OnChange;
        property OnChanging : TTabChangingEvent read m_OnChanging write m_OnChanging;

    end;


    TsuiTabControl = class(TsuiTab)
    protected
        function CreateTopPanel() : TsuiTabControlTopPanel; override;

    published
        property Tabs;
        property TabIndex;

    end;

implementation

uses SUIPublic;


{ TsuiTabControlTopPanel }

constructor TsuiTabControlTopPanel.Create(AOwner: TComponent; TabControl : TsuiTab);
var
    i : Integer;
begin
    inherited Create(AOwner);

    ControlStyle := ControlStyle - [csAcceptsControls];

    m_ActiveTab := TBitmap.Create();
    m_InactiveTab := TBitmap.Create();
    m_Line := TBitmap.Create();

    m_Tabs := TStringList.Create();
    (m_Tabs as TStringList).OnChange := OnTabsChange;
    m_Tabs.Add('Tab1');

    m_TabControl := TabControl;
    Caption := ' ';
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderWidth := 0;
    Align := alNone;
    
    m_LeftMargin := 10;
    m_TabIndex := 0;
    m_UserChanging := false;
    m_Passed := 0;
    m_AutoFit := false;
    m_ShowButton := false;
    m_InButtons := 0;
    m_BtnSize.X := 0;
    m_BtnSize.Y := 0;
    m_TabPosition := suiTop;

    for i := 0 to SUI_TABCONTROL_MAXTABS - 1 do
    begin
        m_TabPos[i] := -1;
        m_TabVisible[i] := true;
    end;
end;

destructor TsuiTabControlTopPanel.Destroy;
begin
    m_Tabs.Free();
    m_Tabs := nil;

    m_ActiveTab.Free();
    m_InactiveTab.Free();
    m_Line.Free();

    inherited;
end;

procedure TsuiTabControlTopPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    i : Integer;
    nLeft : Integer;
    nRight : Integer;
begin
    inherited;
    if Button <> mbLeft then
        Exit;
    Repaint();

    if m_InButtons = -1 then
        Dec(m_Passed)
    else if (m_InButtons = 1) and m_ShowButton then
        Inc(m_Passed);

    if m_InButtons <> 0 then
    begin
        if m_Passed < 0 then
            m_Passed := 0;
        if m_Passed > m_Tabs.Count then
            m_Passed := m_Tabs.Count;
        Repaint();
        Exit;
    end;

    nRight := m_LeftMargin;
    for i := m_Passed to m_Tabs.Count - 1 do
    begin
        if m_TabPos[i] = -1 then
            break;

        nLeft := nRight;
        Inc(nRight, m_TabPos[i]);

        if (X < nRight) and (X > nLeft) and (Y > 0) and (Y < m_TabHeight) then
        begin
            m_UserChanging := true;
            TabIndex := i;

            m_AutoFit := true;
            Repaint();
            m_AutoFit := false;

            m_UserChanging := false;
            break;
        end;
    end;
end;

procedure TsuiTabControlTopPanel.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
    inherited;

    if m_ShowButton then
        Repaint();
end;

procedure TsuiTabControlTopPanel.OnTabsChange(Sender: TObject);
begin
    Repaint();
end;

procedure TsuiTabControlTopPanel.Paint;
var
    Buf : TBitmap;
begin
    Buf := TBitmap.Create();
    Buf.Width := Width;
    Buf.Height := Height;

    DoTrans(Buf.Canvas, m_TabControl);

    m_InButtons := 0;
    if m_AutoFit then
    begin
        while PaintTabs(Buf) < m_TabIndex do
        begin
            Inc(m_Passed);
            PaintTabs(Buf);
        end;
    end
    else
        PaintTabs(Buf);
    PaintButtons(Buf);

    BitBlt(Canvas.Handle, 0, 0, Buf.Width, Buf.Height, Buf.Canvas.Handle, 0, 0, SRCCOPY);

    Buf.Free();
end;

procedure TsuiTabControlTopPanel.PaintButtons(const Buf: TBitmap);
var
    BtnBuf : TBitmap;
    BtnRect : TRect;
    MousePoint : TPoint;
    OutUIStyle : TsuiUIStyle;
    nLeft : Integer;
    nTop : Integer;
    nIndex : Integer;
begin
    if (not m_ShowButton) and (m_Passed = 0) then
        Exit;

    GetCursorPos(MousePoint);
    MousePoint := ScreenToClient(MousePoint);
    m_InButtons := 0;

    BtnBuf := TBitmap.Create();
    BtnBuf.Transparent := true;

    nLeft := Width - 2 - m_BtnSize.X;
    if m_TabPosition = suiTop then
    begin
        if m_BtnSize.Y + 4 < Buf.Height then
            nTop := (Buf.Height - m_BtnSize.Y) div 2 - 2
        else
            nTop := 0;
    end
    else
    begin
        if m_BtnSize.Y + 4 < Buf.Height then
            nTop := (Buf.Height - m_BtnSize.Y) div 2 + 2
        else
            nTop := Buf.Height - m_BtnSize.Y;
    end;

    // Right Button
    BtnRect := Rect(nLeft, nTop, Width - 2, nTop + m_BtnSize.Y);
    if InRect(MousePoint, BtnRect) then
    begin
        nIndex := 2;
        m_InButtons := 1;
    end
    else
        nIndex := 1;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_FileTheme.GetBitmap(SUI_THEME_SCROLLBUTTON_IMAGE, BtnBuf, 4, nIndex)
    else
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_SCROLLBUTTON_IMAGE, BtnBuf, 4, nIndex);
    Buf.Canvas.Draw(nLeft, nTop, BtnBuf);

    // Left Button
    BtnRect := Rect(nLeft - m_BtnSize.X, nTop, nLeft, nTop + m_BtnSize.Y);
    if InRect(MousePoint, BtnRect) then
    begin
        nIndex := 4;
        m_InButtons := -1;
    end
    else
        nIndex := 3;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_FileTheme.GetBitmap(SUI_THEME_SCROLLBUTTON_IMAGE, BtnBuf, 4, nIndex)
    else
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_SCROLLBUTTON_IMAGE, BtnBuf, 4, nIndex);
    Buf.Canvas.Draw(nLeft - m_BtnSize.X, nTop, BtnBuf);

    BtnBuf.Free();
end;

function TsuiTabControlTopPanel.PaintTabs(const Buf: TBitmap) : Integer;
var
    nLeft : Integer;
    nWidth : Integer;
    i : Integer;
    nShowed : Integer;
    R : TRect;
    RightBorder : Integer;
    RightBorder1, RightBorder2 : Integer;
    OverRightBorder : Boolean;
    ATrans, ITrans : Boolean;
    ASampleTop, ISampleTop : Boolean;
    T1, T2, T3, T4 : Integer;
begin
    RightBorder1 := Width - 2 * m_BtnSize.X - 2;
    RightBorder2 := Width - 10;
    RightBorder := 0;

    ASampleTop := true;
    if m_ActiveTab.Canvas.Pixels[0, 0] = clFuchsia then
    begin
        ATrans := true;
    end
    else if m_ActiveTab.Canvas.Pixels[0, m_ActiveTab.Height - 1] = clFuchsia then
    begin
        ATrans := true;
        ASampleTop := false;
    end
    else
        ATrans := false;
    ISampleTop := true;
    if m_InactiveTab.Canvas.Pixels[0, 0] = clFuchsia then
    begin
        ITrans := true;
    end
    else if m_InactiveTab.Canvas.Pixels[0, m_InactiveTab.Height - 1] = clFuchsia then
    begin
        ITrans := true;
        ISampleTop := false;
    end
    else
        ITrans := false;

    m_TabHeight := m_ActiveTab.Height;

    if m_TabPosition = suiTop then
    begin
        Buf.Canvas.StretchDraw(
            Rect(1, m_InactiveTab.Height, Width - 1, m_InactiveTab.Height + m_Line.Height),
            m_Line
        );

        Buf.Canvas.Pen.Color := m_TabControl.BorderColor;
        Buf.Canvas.MoveTo(0, m_InactiveTab.Height);
        Buf.Canvas.LineTo(0, m_InactiveTab.Height + m_Line.Height);
        Buf.Canvas.MoveTo(Width - 1, m_InactiveTab.Height);
        Buf.Canvas.LineTo(Width - 1, m_InactiveTab.Height + m_Line.Height);
        T1 := 0;
        T2 := m_InactiveTab.Height;
        T3 := T1 + 1;
        T4 := T2 + 1;
    end
    else
    begin
        Buf.Canvas.StretchDraw(
            Rect(1, 0, Width - 1, m_Line.Height),
            m_Line
        );

        Buf.Canvas.Pen.Color := m_TabControl.BorderColor;
        Buf.Canvas.MoveTo(0, 0);
        Buf.Canvas.LineTo(0, m_Line.Height);
        Buf.Canvas.MoveTo(Width - 1, 0);
        Buf.Canvas.LineTo(Width - 1, m_Line.Height);
        T1 := Height - m_InactiveTab.Height;
        T2 := Height;
        T3 := T1 - 1;
        T4 := T2 - 1;
    end;

    nLeft := m_LeftMargin;

    Buf.Canvas.Font := m_TabControl.Font;

    nShowed := 0;

    OverRightBorder := false;
    Result := m_Tabs.Count - 1;
    for i := 0 to m_Tabs.Count - 1 do
    begin
        if i = m_Tabs.Count - 1 then
            RightBorder := RightBorder2
        else
            RightBorder := RightBorder1;

        if not m_TabVisible[i] then
        begin
            m_TabPos[i] := 0;
            continue;
        end;

        if OverRightBorder then
            break;
            
        if m_Tabs[i] <> '' then
            nWidth := Buf.Canvas.TextWidth(m_Tabs[i]) + 20
        else
            nWidth := 80;
        if nWidth < 15 then
            nWidth := 15;
        if i < SUI_TABCONTROL_MAXTABS - 1 then
            m_TabPos[i] := nWidth;

        Inc(nShowed);
        if nShowed <= m_Passed then
            continue;

        if m_TabIndex = i then
        begin
            R := Rect(nLeft, T3, nWidth + nLeft, T4);
            if R.Right > RightBorder then
            begin
                R.Right := RightBorder1;
                OverRightBorder := true;
                Result := i - 1;
            end;
            SpitDrawHorizontal(m_ActiveTab, Buf.Canvas, R, ATrans, ASampleTop);
        end
        else
        begin
            R := Rect(nLeft, T1, nWidth + nLeft, T2);
            if R.Right > RightBorder then
            begin
                R.Right := RightBorder1;
                m_TabPos[i] := R.Right - R.Left;
                OverRightBorder := true;
                Result := i - 1;
            end;
            SpitDrawHorizontal(m_InactiveTab, Buf.Canvas, R, ITrans, ISampleTop);
        end;

        Inc(nLeft, nWidth);
        Buf.Canvas.Brush.Style := bsClear;
        if OverRightBorder then
        begin
            R.Left := R.Left + 10;
            R.Right := R.Right - 4;
            DrawText(Buf.Canvas.Handle, PAnsiChar(m_Tabs[i]), -1, R, DT_SINGLELINE or DT_VCENTER);
        end
        else
            DrawText(Buf.Canvas.Handle, PAnsiChar(m_Tabs[i]), -1, R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
    end;

    if ((nLeft > RightBorder) or OverRightBorder) and (m_Tabs.Count <> 0) then
        m_ShowButton := true
    else
        m_ShowButton := false;
end;

procedure TsuiTabControlTopPanel.RequestAlign;
var
    R : TRect;
begin
    if m_TabControl <> nil then
    begin
        if m_TabPosition = suiTop then
            R := Rect(0, 0, m_TabControl.Width, Height)
        else
            R := Rect(0, m_TabControl.Height - Height, m_TabControl.Width, m_TabControl.Height);
        PlaceControl(self, R);
    end
    else
        inherited;
end;

procedure TsuiTabControlTopPanel.Resize;
begin
    inherited;

    if m_TabControl <> nil then
    begin
        if m_TabPosition = suiTop then
            SetBounds(0, 0, m_TabControl.Width, Height)
        else
        begin
            Top := m_TabControl.Height - Height;
            Left := 0;
            Width := m_TabControl.Width;
        end;
    end;
end;

procedure TsuiTabControlTopPanel.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiTabControlTopPanel.SetLeftMargin(const Value: Integer);
begin
    m_LeftMargin := Value;

    Repaint();
end;

procedure TsuiTabControlTopPanel.SetTabIndex(const Value: Integer);
var
    bAllow : Boolean;
begin
    if m_TabIndex = Value then
        Exit;
    if m_Tabs.Count = 0 then
    begin
        m_TabIndex := -1;
        Repaint();
        Exit;
    end;

    if (
        (Value < -1) or
        (Value > m_Tabs.Count -1)
    ) then
    begin
        Repaint();
        Exit;
    end;

    if m_UserChanging then
    begin
        bAllow := true;
        if Assigned(m_TabControl.m_OnChanging) then
            m_TabControl.m_OnChanging(m_TabControl, bAllow);
        if not bAllow then
            Exit;
    end;
    m_TabIndex := Value;
    m_AutoFit := true;
    Repaint();
    m_AutoFit := false;
    m_TabControl.TabActive(m_TabIndex);
end;

procedure TsuiTabControlTopPanel.SetTabPosition(const Value: TsuiTabPosition);
begin
    if m_TabPosition = Value then
        Exit;
    m_TabPosition := Value;
    RoundPicture2(m_ActiveTab);
    RoundPicture2(m_InactiveTab);
    RoundPicture2(m_Line);
    Repaint();
end;

procedure TsuiTabControlTopPanel.SetTabs(const Value: TStrings);
begin
    m_Tabs.Assign(Value);
end;

procedure TsuiTabControlTopPanel.SetUIStyle(const Value: TsuiUIStyle);
var
    BtnBitmap : TBitmap;
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;

    BtnBitmap := TBitmap.Create();

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_FileTheme.GetBitmap(SUI_THEME_TABCONTROL_TAB_IMAGE, m_ActiveTab, 2, 1);
        m_FileTheme.GetBitmap(SUI_THEME_TABCONTROL_TAB_IMAGE, m_InactiveTab, 2, 2);
        m_FileTheme.GetBitmap(SUI_THEME_TABCONTROL_BAR_IMAGE, m_Line);
        m_FileTheme.GetBitmap(SUI_THEME_SCROLLBUTTON_IMAGE, BtnBitmap, 4, 1);
    end
    else
    begin
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TABCONTROL_TAB_IMAGE, m_ActiveTab, 2, 1);
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TABCONTROL_TAB_IMAGE, m_InactiveTab, 2, 2);
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TABCONTROL_BAR_IMAGE, m_Line);
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_SCROLLBUTTON_IMAGE, BtnBitmap, 4, 1);
    end;

    if m_TabPosition = suiBottom then
    begin
        RoundPicture2(m_ActiveTab);
        RoundPicture2(m_InactiveTab);
        RoundPicture2(m_Line);
    end;

    Height := m_ActiveTab.Height + m_Line.Height;
    m_BtnSize.X := BtnBitmap.Width;
    m_BtnSize.Y := BtnBitmap.Height;

    BtnBitmap.Free();
    Repaint();
end;

procedure TsuiTabControlTopPanel.WMERASEBKGND(var Msg: TMessage);
begin
    // do nothing
end;

function TsuiTab.GetLeftMargin: Integer;
begin
    Result := m_TopPanel.LeftMargin;
end;

function TsuiTab.GetTabIndex: Integer;
begin
    Result := m_TopPanel.TabIndex;
end;

function TsuiTab.GetTabs: TStrings;
begin
    Result := m_TopPanel.Tabs;
end;

procedure TsuiTab.Paint;
var
    R : TRect;
begin
    Canvas.Brush.Color := Color;
    if m_TabPosition = suiTop then
        R := Rect(ClientRect.Left, m_TopPanel.Height, ClientRect.Right, ClientRect.Bottom)
    else
        R := Rect(ClientRect.Left, 0, ClientRect.Right, ClientRect.Bottom - m_TopPanel.Height);
    Canvas.FillRect(R);
    Canvas.Pen.Color := m_BorderColor;
    if m_TabPosition = suiTop then
    begin
        Canvas.MoveTo(0, R.Top - 1);
        Canvas.LineTo(0, R.Bottom - 1);
        Canvas.LineTo(R.Right - 1, R.Bottom - 1);
        Canvas.LineTo(R.Right - 1, R.Top - 1);
    end
    else
    begin
        Canvas.MoveTo(R.Right - 1, R.Bottom - 1);
        Canvas.LineTo(R.Right - 1, R.Top);
        Canvas.LineTo(0, R.Top);
        Canvas.LineTo(0, R.Bottom);
    end;
end;

procedure TsuiTab.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;

    BorderColorChanged();
    Repaint();
    m_TopPanel.Repaint();
end;

procedure TsuiTab.SetFont(const Value: TFont);
begin
    m_Font.Assign(Value);
    m_TopPanel.Repaint();
end;

procedure TsuiTab.SetLeftMargin(const Value: Integer);
begin
    m_TopPanel.LeftMargin := Value;
end;

procedure TsuiTab.SetTabIndex(const Value: Integer);
begin
    m_TopPanel.TabIndex := Value;
end;

procedure TsuiTab.SetTabs(const Value: TStrings);
begin
    m_TopPanel.Tabs := Value;
end;

procedure TsuiTab.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    m_TopPanel.FileTheme := m_FileTheme;
    m_TopPanel.UIStyle := m_UIStyle;
    m_TopPanel.Repaint();

    UpdateUIStyle(m_UIStyle, m_FileTheme);
    
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_TopPanel.Color := m_FileTheme.GetColor(SUI_THEME_CONTROL_BACKGROUND_COLOR);
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        Color := m_FileTheme.GetColor(SUI_THEME_CONTROL_BACKGROUND_COLOR);
    end
    else
    begin
        m_TopPanel.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BACKGROUND_COLOR);
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
        if {$IFDEF RES_WINXP}m_UIStyle <> WinXP{$ELSE} True {$ENDIF} then
            Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BACKGROUND_COLOR)
        else
            Color := clWhite;
    end;

    Repaint();
end;

procedure TsuiTab.UpdateUIStyle(UIStyle: TsuiUIStyle; FileTheme : TsuiFileTheme);
begin
    ContainerApplyUIStyle(self, UIStyle, FileTheme);
end;

constructor TsuiTab.Create(AOwner: TComponent);
begin
    inherited;

    m_TopPanel := CreateTopPanel();
    m_TopPanel.Parent := self;
    m_TopPanel.OnClick := TopPanelClick;
    m_TopPanel.OnDblClick := TopPanelDblClick;
    m_TabPosition := suiTop;

    m_Font := TFont.Create();

    Caption := ' ';
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderWidth := 0;
    Height := 80;

    UIStyle := GetSUIFormStyle(AOwner);
    m_TopPanel.SetBounds(0, 0, Width, m_TopPanel.Height);    
end;

destructor TsuiTab.Destroy;
begin
    m_Font.Free();
    m_Font := nil;

    m_TopPanel.Free();
    m_TopPanel := nil;

    inherited;
end;

{ TsuiTabControl }

function TsuiTabControl.CreateTopPanel: TsuiTabControlTopPanel;
begin
    Result := TsuiTabControlTopPanel.Create(self, self);
end;

procedure TsuiTab.TabActive(TabIndex : Integer);
begin
    if not (csLoading in ComponentState) then
    begin
        if Assigned(m_OnTabActive) then
            m_OnTabActive(self, TabIndex);
        if Assigned(m_OnChange) then
            m_OnChange(self);
    end;
end;

procedure TsuiTab.BorderColorChanged;
begin
    // do nothing
end;

procedure TsuiTab.CMCursorChanged(var Message: TMessage);
begin
    m_TopPanel.Cursor := Cursor;
    inherited;
end;

procedure TsuiTab.Notification(AComponent: TComponent;
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

procedure TsuiTab.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiTab.AlignControls(AControl: TControl; var Rect: TRect);
begin
    if m_TabPosition = suiTop then
    begin
        Rect.Left := Rect.Left + 3;
        Rect.Right := Rect.Right - 3;
        Rect.Bottom := Rect.Bottom - 3;
        Rect.Top := Rect.Top + m_TopPanel.Height + 3;
    end
    else
    begin
        Rect.Left := Rect.Left + 3;
        Rect.Right := Rect.Right - 3;
        Rect.Top := Rect.Top + 3;
        Rect.Bottom := Rect.Bottom - m_TopPanel.Height - 3;
    end;
    inherited AlignControls(AControl, Rect);
end;

procedure TsuiTab.Resize;
begin
    inherited;

    if m_TabPosition = suiTop then
        m_TopPanel.SetBounds(0, 0, Width, m_TopPanel.Height)
    else
    begin
        m_TopPanel.Top := Height - m_TopPanel.Height;
        m_TopPanel.Left := 0;
        m_TopPanel.Width := Width;
    end;
end;

procedure TsuiTab.WMERASEBKGND(var Message: TMessage);
begin
    // do nothing
end;

procedure TsuiTab.TopPanelClick(Sender: TObject);
begin
    if Assigned(OnClick) then
        OnClick(self);
end;

procedure TsuiTab.TopPanelDblClick(Sender: TObject);
begin
    if Assigned(OnDblClick) then
        OnDblClick(self);
end;

procedure TsuiTab.SetTabPosition(const Value: TsuiTabPosition);
begin
    if m_TabPosition = Value then
        Exit;
    m_TabPosition := Value;
    m_TopPanel.TabPosition := Value;
    m_TopPanel.RequestAlign();
    Realign();
end;

end.
