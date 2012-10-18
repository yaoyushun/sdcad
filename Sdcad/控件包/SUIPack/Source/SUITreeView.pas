////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUITreeView.pas
//  Creator     :   Shen Min
//  Date        :   2002-10-02 V1-V3
//                  2003-07-04 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUITreeView;

interface

{$I SUIPack.inc}

uses Windows, SysUtils, Classes, Controls, ComCtrls, Graphics, Messages, Forms,
     SUIThemes, SUIMgr, SUIScrollBar;

type
    TsuiTreeView = class(TCustomTreeView)
    private
        m_BorderColor : TColor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        // scroll bar
        m_VScrollBar : TsuiScrollBar;
        m_HScrollBar : TsuiScrollBar;
        m_MouseDown : Boolean;
        m_SelfChanging : Boolean;
        procedure SetVScrollBar(const Value: TsuiScrollBar);
        procedure SetHScrollBar(const Value: TsuiScrollBar);
        procedure OnVScrollBarChange(Sender : TObject);
        procedure OnHScrollBarChange(Sender : TObject);
        procedure UpdateScrollBars();
        procedure UpdateScrollBarsPos();

        procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
        procedure CMVisibleChanged(var Msg : TMEssage); message CM_VISIBLECHANGED;
        procedure WMSIZE(var Msg : TMessage); message WM_SIZE;
        procedure WMMOVE(var Msg : TMessage); message WM_MOVE;
        procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
        procedure WMLBUTTONDOWN(var Message: TMessage); message WM_LBUTTONDOWN;
        procedure WMLButtonUp(var Message: TMessage); message WM_LBUTTONUP;
        procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
        procedure WMDELETEITEM(var Msg : TMessage); message WM_DELETEITEM;
        procedure WMMOUSEMOVE(var Message: TMessage); message WM_MOUSEMOVE;
        procedure WMVSCROLL(var Message: TWMVScroll); message WM_VSCROLL;
        procedure WMHSCROLL(var Message: TWMHScroll); message WM_HSCROLL;

        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;

        // scroll bar
        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;

{$IFDEF SUIPACK_D6UP}
        property MultiSelect;
{$ENDIF}

        property Align;
        property Anchors;
        property AutoExpand;
        property BevelEdges;
        property BevelInner;
        property BevelOuter;
        property BevelKind default bkNone;
        property BevelWidth;
        property BiDiMode;
        property BorderStyle;
        property BorderWidth;
        property ChangeDelay;
        property Color;
        property Ctl3D;
        property Constraints;
        property DragKind;
        property DragCursor;
        property DragMode;
        property Enabled;
        property Font;
        property HideSelection;
        property HotTrack;
        property Images;
        property Indent;
        property ParentBiDiMode;
        property ParentColor default False;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ReadOnly;
        property RightClickSelect;
        property RowSelect;
        property ShowButtons;
        property ShowHint;
        property ShowLines;
        property ShowRoot;
        property SortType;
        property StateImages;
        property TabOrder;
        property TabStop default True;
        property ToolTips;
        property Visible;
        property OnAdvancedCustomDraw;
        property OnAdvancedCustomDrawItem;
        property OnChange;
        property OnChanging;
        property OnClick;
        property OnCollapsed;
        property OnCollapsing;
        property OnCompare;
        property OnContextPopup;
        property OnCustomDraw;
        property OnCustomDrawItem;
        property OnDblClick;
        property OnDeletion;
        property OnDragDrop;
        property OnDragOver;
        property OnEdited;
        property OnEditing;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnExpanding;
        property OnExpanded;
        property OnGetImageIndex;
        property OnGetSelectedIndex;
        property OnKeyDown;
        property OnKeyPress;
        property OnKeyUp;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnStartDock;
        property OnStartDrag;
        { Items must be published after OnGetImageIndex and OnGetSelectedIndex }
        property Items;

    end;

implementation

uses SUIPublic, SUIProgressBar;

{ TsuiTreeView }

procedure TsuiTreeView.CMEnabledChanged(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiTreeView.CMVisibleChanged(var Msg: TMEssage);
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

constructor TsuiTreeView.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 2;
    m_SelfChanging := false;
    m_MouseDown := false;

    UIStyle := GetSUIFormStyle(AOwner);   
end;

procedure TsuiTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if (
        (Operation = opRemove) and
        (AComponent = m_VScrollBar)
    )then
        m_VScrollBar := nil;

    if (
        (Operation = opRemove) and
        (AComponent = m_HScrollBar)
    )then
        m_HScrollBar := nil;
    
    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        SetUIStyle(SUI_THEME_DEFAULT);
    end;
end;

procedure TsuiTreeView.OnHScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
    Invalidate;
end;

procedure TsuiTreeView.OnVScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
    Invalidate;
end;

procedure TsuiTreeView.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiTreeView.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiTreeView.SetHScrollBar(const Value: TsuiScrollBar);
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
        Exit;
    m_HScrollBar.SmallChange := 5;
    m_HScrollBar.Orientation := suiHorizontal;
    m_HScrollBar.OnChange := OnHScrollBArChange;
    m_HScrollBar.BringToFront();

    UpdateScrollBarsPos();
end;

procedure TsuiTreeView.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR)
    else
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
    if m_VScrollBar <> nil then
        m_VScrollBar.UIStyle := OutUIStyle;
    if m_HScrollBar <> nil then
        m_HScrollBar.UIStyle := OutUIStyle;   
    Repaint();
end;

procedure TsuiTreeView.SetVScrollBar(const Value: TsuiScrollBar);
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
        Exit;
    m_VScrollBar.SmallChange := 5;        
    m_VScrollBar.Orientation := suiVertical;
    m_VScrollBar.OnChange := OnVScrollBArChange;
    m_VScrollBar.BringToFront();

    UpdateScrollBarsPos();
end;

procedure TsuiTreeView.UpdateScrollBars;
var
    info : tagScrollInfo;
    barinfo : tagScrollBarInfo;
    R : Boolean;
begin
    m_SelfChanging := true;
    if m_VScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        R := SUIGetScrollBarInfo(Handle, Integer(OBJID_VSCROLL), barinfo);
        if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not R) then
        begin
            m_VScrollBar.LineButton := 0;
            m_VScrollBar.Enabled := false;
            m_VScrollBar.Visible := false;
        end
        else if not Enabled then
            m_VScrollBar.Enabled := false
        else
        begin
            m_VScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_VScrollBar.Enabled := true;
            m_VScrollBar.Visible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_VERT, info);
        m_VScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_VScrollBar.Min := info.nMin;
        m_VScrollBar.Position := info.nPos;
    end;

    if m_HScrollBar <> nil then
    begin
        barinfo.cbSize := SizeOf(barinfo);
        R := SUIGetScrollBarInfo(Handle, Integer(OBJID_HSCROLL), barinfo);
        if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) or
           (not R) then
        begin
            m_HScrollBar.LineButton := 0;
            m_HScrollBar.Enabled := false;
            m_HScrollBar.Visible := false;
        end
        else if not Enabled then
            m_HScrollBar.Enabled := false
        else
        begin
            m_HScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
            m_HScrollBar.Enabled := true;
            m_HScrollBar.Visible := true;
        end;
        info.cbSize := SizeOf(info);
        info.fMask := SIF_ALL;
        GetScrollInfo(Handle, SB_HORZ, info);
        m_HScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
        m_HScrollBar.Min := info.nMin;
        m_HScrollBar.Position := info.nPos;
    end;

    m_SelfChanging := false;
end;

procedure TsuiTreeView.UpdateScrollBarsPos;
var
    L2R : Boolean;
begin
    UpdateScrollBars();
    
    L2R := ((BidiMode = bdLeftToRight) or (BidiMode = bdRightToLeftReadingOnly)) or (not SysLocale.MiddleEast);

    if m_HScrollBar <> nil then
    begin
        if m_HScrollBar.Height > Height then
            m_HScrollBar.Top := Top
        else
        begin
            if L2R then
            begin
                m_HScrollBar.Left := Left + 1;
                m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 2;
                if m_VScrollBar <> nil then
                begin
                    if m_VScrollBar.Visible then
                        m_HScrollBar.Width := Width - 2 - m_VScrollBar.Width
                    else
                        m_HScrollBar.Width := Width - 2
                end
                else
                    m_HScrollBar.Width := Width - 2
            end
            else
            begin
                m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 2;
                if m_VScrollBar <> nil then
                begin
                    m_HScrollBar.Left := Left + m_VScrollBar.Width + 1;                
                    if m_VScrollBar.Visible then
                        m_HScrollBar.Width := Width - 2 - m_VScrollBar.Width
                    else
                        m_HScrollBar.Width := Width - 2
                end
                else
                begin
                    m_HScrollBar.Left := Left + 1;
                    m_HScrollBar.Width := Width - 2;
                end;
            end;
        end;
    end;

    if m_VScrollBar <> nil then
    begin
        if m_VScrollBar.Width > Width then
            m_VScrollBar.Left := Left
        else
        begin
            if L2R then
            begin
                m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 2;
                m_VScrollBar.Top := Top + 1;
                if m_HScrollBar <> nil then
                begin
                    if m_HScrollBar.Visible then
                        m_VScrollBar.Height := Height - 2 - m_HScrollBar.Height
                    else
                        m_VScrollBar.Height := Height - 2;
                end
                else
                    m_VScrollBar.Height := Height - 2;
            end
            else
            begin
                m_VScrollBar.Left := Left + 2;
                m_VScrollBar.Top := Top + 1;
                if m_HScrollBar <> nil then
                begin
                    if m_HScrollBar.Visible then
                        m_VScrollBar.Height := Height - 2 - m_HScrollBar.Height
                    else
                        m_VScrollBar.Height := Height - 2;
                end
                else
                    m_VScrollBar.Height := Height - 2;
            end;
        end;
    end;
end;

procedure TsuiTreeView.WMDELETEITEM(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiTreeView.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiTreeView.WMHSCROLL(var Message: TWMHScroll);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiTreeView.WMKeyDown(var Message: TWMKeyDown);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiTreeView.WMLBUTTONDOWN(var Message: TMessage);
begin
    inherited;
    m_MouseDown := true;
    UpdateScrollBars();
end;

procedure TsuiTreeView.WMLButtonUp(var Message: TMessage);
begin
    inherited;
    m_MouseDown := false;
end;

procedure TsuiTreeView.WMMOUSEMOVE(var Message: TMessage);
begin
    inherited;
    if m_MouseDown then UpdateScrollBars();
end;

procedure TsuiTreeView.WMMOUSEWHEEL(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiTreeView.WMMOVE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiTreeView.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiTreeView.WMSIZE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiTreeView.WMVSCROLL(var Message: TWMVScroll);
begin
    inherited;
    UpdateScrollBars();
end;

end.
