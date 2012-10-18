////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIMemo.pas
//  Creator     :   Shen Min
//  Date        :   2002-08-22 V1-V3
//                  2003-07-02 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIMemo;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics, Forms,
     ComCtrls,
     SUIScrollBar, SUIThemes, SUIMgr;

type
    TsuiMemo = class(TCustomMemo)
    private
        m_BorderColor : TColor;
        m_MouseDown : Boolean;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        
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
        procedure CMVisibleChanged(var Msg : TMessage); message CM_VISIBLECHANGED;
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

        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

        procedure SetBorderColor(const Value: TColor);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        
    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner: TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;                    
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;

        // scroll bar
        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;

        property Align;
        property Alignment;
        property Anchors;
        property BiDiMode;
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
        property Lines;
        property MaxLength;
        property OEMConvert;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ReadOnly;
        property ScrollBars;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Visible;
        property WantReturns;
        property WantTabs;
        property WordWrap;
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


//    Don't use it, some problems.

//    TsuiRichEdit = class(TCustomRichEdit)
//    private
//        m_BorderColor : TColor;
//        m_MouseDown : Boolean;
//        m_UIStyle : TsuiUIStyle;
//        m_FileTheme : TsuiFileTheme;
//
//        // scroll bar
//        m_VScrollBar : TsuiScrollBar;
//        m_HScrollBar : TsuiScrollBar;
//        m_SelfChanging : Boolean;
//        m_UserChanging : Boolean;
//
//        procedure SetHScrollBar(const Value: TsuiScrollBar);
//        procedure SetVScrollBar(const Value: TsuiScrollBar);
//        procedure OnHScrollBarChange(Sender : TObject);
//        procedure OnVScrollBarChange(Sender : TObject);
//        procedure UpdateScrollBars();
//        procedure UpdateScrollBarsPos();
//        procedure UpdateInnerScrollBars();
//
//        procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
//        procedure WMSIZE(var Msg : TMessage); message WM_SIZE;
//        procedure WMMOVE(var Msg : TMessage); message WM_MOVE;
//        procedure WMCut(var Message: TMessage); message WM_Cut;
//        procedure WMPaste(var Message: TMessage); message WM_PASTE;
//        procedure WMClear(var Message: TMessage); message WM_CLEAR;
//        procedure WMUndo(var Message: TMessage); message WM_UNDO;
//        procedure WMLBUTTONDOWN(var Message: TMessage); message WM_LBUTTONDOWN;
//        procedure WMLButtonUp(var Message: TMessage); message WM_LBUTTONUP;
//        procedure WMMOUSEWHEEL(var Message: TMessage); message WM_MOUSEWHEEL;
//        procedure WMSetText(var Message:TWMSetText); message WM_SETTEXT;
//        procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
//        procedure WMMOUSEMOVE(var Message: TMessage); message WM_MOUSEMOVE;
//        procedure WMVSCROLL(var Message: TWMVScroll); message WM_VSCROLL;
//        procedure WMHSCROLL(var Message: TWMHScroll); message WM_HSCROLL;
//
//        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
//        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
//
//        procedure SetBorderColor(const Value: TColor);
//        procedure SetFileTheme(const Value: TsuiFileTheme);
//        procedure SetUIStyle(const Value: TsuiUIStyle);
//        
//    protected
//        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
//
//    public
//        constructor Create(AOwner: TComponent); override;
//
//    published
//        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;                    
//        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
//        property BorderColor : TColor read m_BorderColor write SetBorderColor;
//
//        // scroll bar
//        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
//        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;
//
//        property Align;
//        property Alignment;
//        property Anchors;
//        property BiDiMode;
//        property Color;
//        property Constraints;
//        property Ctl3D;
//        property DragCursor;
//        property DragKind;
//        property DragMode;
//        property Enabled;
//        property Font;
//        property HideSelection;
//        property ImeMode;
//        property ImeName;
//        property Lines;
//        property MaxLength;
//        property OEMConvert;
//        property ParentBiDiMode;
//        property ParentColor;
//        property ParentCtl3D;
//        property ParentFont;
//        property ParentShowHint;
//        property PopupMenu;
//        property ReadOnly;
//        property ScrollBars;
//        property ShowHint;
//        property TabOrder;
//        property TabStop;
//        property Visible;
//        property WantReturns;
//        property WantTabs;
//        property WordWrap;
//        property OnChange;
//        property OnClick;
//        property OnDblClick;
//        property OnDragDrop;
//        property OnDragOver;
//        property OnEndDock;
//        property OnEndDrag;
//        property OnEnter;
//        property OnExit;
//        property OnKeyDown;
//        property OnKeyPress;
//        property OnKeyUp;
//        property OnMouseDown;
//        property OnMouseMove;
//        property OnMouseUp;
//        property OnStartDock;
//        property OnStartDrag;
//    end;

implementation

uses SUIPublic, SUIProgressBar;

{ TsuiMemo }

procedure TsuiMemo.CMEnabledChanged(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.CMVisibleChanged(var Msg: TMessage);
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

constructor TsuiMemo.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle + [csOpaque];
    BorderStyle := bsNone;
    BorderWidth := 2;
    m_SelfChanging := false;
    m_UserChanging := false;
    m_MouseDown := false;
    UIStyle := GetSUIFormStyle(AOwner);
end;

procedure TsuiMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if AComponent = nil then
        Exit;

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

procedure TsuiMemo.OnHScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiMemo.OnVScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    m_UserChanging := true;
    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
    Invalidate;
    m_UserChanging := false;
end;

procedure TsuiMemo.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiMemo.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    if m_VScrollBar <> nil then
        m_VScrollBar.FileTheme := Value;
    if m_HScrollBar <> nil then
        m_HScrollBar.FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiMemo.SetHScrollBar(const Value: TsuiScrollBar);
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

procedure TsuiMemo.SetUIStyle(const Value: TsuiUIStyle);
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

procedure TsuiMemo.SetVScrollBar(const Value: TsuiScrollBar);
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

procedure TsuiMemo.UpdateInnerScrollBars;
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

procedure TsuiMemo.UpdateScrollBars;
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
        m_HScrollBar.Position := info.nPos;
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

procedure TsuiMemo.UpdateScrollBarsPos;
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
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 2;
            if m_VScrollBar <> nil then
                m_HScrollBar.Width := Width - 1 - m_VScrollBar.Width
            else
                m_HScrollBar.Width := Width - 1
        end
        else
        begin
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 2;
            if m_VScrollBar <> nil then
            begin
                m_HScrollBar.Left := Left + m_VScrollBar.Width + 1;
                m_HScrollBar.Width := Width - 2 - m_VScrollBar.Width
            end
            else
            begin
                m_HScrollBar.Left := Left + 1;
                m_HScrollBar.Width := Width - 2;
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
            m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 2;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 2 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 2;
        end
        else
        begin
            m_VScrollBar.Left := Left + 2;
            m_VScrollBar.Top := Top + 1;
            if m_HScrollBar <> nil then
                m_VScrollBar.Height := Height - 2 - m_HScrollBar.Height
            else
                m_VScrollBar.Height := Height - 2;
        end;
    end;

    UpdateScrollBars();    
end;

procedure TsuiMemo.WMClear(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMCut(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiMemo.WMHSCROLL(var Message: TWMHScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMKeyDown(var Message: TWMKeyDown);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMLBUTTONDOWN(var Message: TMessage);
begin
    inherited;
    m_MouseDown := true;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMLButtonUp(var Message: TMessage);
begin
    inherited;
    m_MouseDown := false;
end;

procedure TsuiMemo.WMMOUSEMOVE(var Message: TMessage);
begin
    inherited;
    if m_MouseDown then UpdateScrollBars();
end;

procedure TsuiMemo.WMMOUSEWHEEL(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMMOVE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiMemo.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawControlBorder(self, m_BorderColor, Color);
end;

procedure TsuiMemo.WMPaste(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMSetText(var Message: TWMSetText);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMSIZE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiMemo.WMUndo(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiMemo.WMVSCROLL(var Message: TWMVScroll);
begin
    inherited;
    if m_UserChanging then
        Exit;
    UpdateScrollBars();
end;

//{ TsuiRichEdit }
//
//procedure TsuiRichEdit.CMEnabledChanged(var Msg: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//constructor TsuiRichEdit.Create(AOwner: TComponent);
//begin
//    inherited;
//
//    ControlStyle := ControlStyle + [csOpaque];
//    BorderStyle := bsNone;
//    BorderWidth := 2;
//    m_SelfChanging := false;
//    m_UserChanging := false;
//    m_MouseDown := false;
//    UIStyle := GetSUIFormStyle(AOwner);
//end;
//
//procedure TsuiRichEdit.Notification(AComponent: TComponent;
//  Operation: TOperation);
//begin
//    inherited;
//
//    if AComponent = nil then
//        Exit;
//
//    if (
//        (Operation = opRemove) and
//        (AComponent = m_HScrollBar)
//    )then
//    begin
//        m_HScrollBar := nil;
//        UpdateInnerScrollBars();
//    end;
//
//    if (
//        (Operation = opRemove) and
//        (AComponent = m_VScrollBar)
//    )then
//    begin
//        m_VScrollBar := nil;
//        UpdateInnerScrollBars();
//    end;
//
//    if (
//        (Operation = opRemove) and
//        (AComponent = m_FileTheme)
//    )then
//    begin
//        m_FileTheme := nil;
//        SetUIStyle(SUI_THEME_DEFAULT);          
//    end;
//end;
//
//procedure TsuiRichEdit.OnHScrollBarChange(Sender: TObject);
//begin
//    if m_SelfChanging then
//        Exit;
//    m_UserChanging := true;
//    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
//    Invalidate;
//    m_UserChanging := false;
//end;
//
//procedure TsuiRichEdit.OnVScrollBarChange(Sender: TObject);
//begin
//    if m_SelfChanging then
//        Exit;
//    m_UserChanging := true;
//    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
//    Invalidate;
//    m_UserChanging := false;
//end;
//
//procedure TsuiRichEdit.SetBorderColor(const Value: TColor);
//begin
//    m_BorderColor := Value;
//    Repaint();
//end;
//
//procedure TsuiRichEdit.SetFileTheme(const Value: TsuiFileTheme);
//begin
//    m_FileTheme := Value;
//    if m_VScrollBar <> nil then
//        m_VScrollBar.FileTheme := Value;
//    if m_HScrollBar <> nil then
//        m_HScrollBar.FileTheme := Value;
//    SetUIStyle(m_UIStyle);
//end;
//
//procedure TsuiRichEdit.SetHScrollBar(const Value: TsuiScrollBar);
//begin
//    if m_HScrollBar = Value then
//        Exit;
//    if m_HScrollBar <> nil then
//    begin
//        m_HScrollBar.OnChange := nil;
//        m_HScrollBar.LineButton := 0;
//        m_HScrollBar.Max := 100;
//        m_HScrollBar.Enabled := true;
//    end;
//
//    m_HScrollBar := Value;
//    if m_HScrollBar = nil then
//    begin
//        UpdateInnerScrollBars();
//        Exit;
//    end;
//    m_HScrollBar.Orientation := suiHorizontal;
//    m_HScrollBar.OnChange := OnHScrollBarChange;
//    m_HScrollBar.BringToFront();
//    UpdateInnerScrollBars();
//
//    UpdateScrollBarsPos();
//end;
//
//procedure TsuiRichEdit.SetUIStyle(const Value: TsuiUIStyle);
//var
//    OutUIStyle : TsuiUIStyle;
//begin
//    m_UIStyle := Value;
//
//    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
//        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR)
//    else
//        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
//
//    if m_VScrollBar <> nil then
//        m_VScrollBar.UIStyle := OutUIStyle;
//    if m_HScrollBar <> nil then
//        m_HScrollBar.UIStyle := OutUIStyle;
//    Repaint();
//end;
//
//procedure TsuiRichEdit.SetVScrollBar(const Value: TsuiScrollBar);
//begin
//    if m_VScrollBar = Value then
//        Exit;
//    if m_VScrollBar <> nil then
//    begin
//        m_VScrollBar.OnChange := nil;
//        m_VScrollBar.LineButton := 0;
//        m_VScrollBar.Max := 100;
//        m_VScrollBar.Enabled := true;
//    end;
//
//    m_VScrollBar := Value;
//    if m_VScrollBar = nil then
//    begin
//        UpdateInnerScrollBars();
//        Exit;
//    end;
//    m_VScrollBar.Orientation := suiVertical;
//    m_VScrollBar.OnChange := OnVScrollBArChange;
//    m_VScrollBar.BringToFront();
//    UpdateInnerScrollBars();
//
//    UpdateScrollBarsPos();
//end;
//
//procedure TsuiRichEdit.UpdateInnerScrollBars;
//begin
//    if (m_VScrollBar <> nil) and (m_HScrollBar <> nil) then
//        ScrollBars := ssBoth
//    else if (m_VScrollBar <> nil) and (m_HScrollBar = nil) then
//        ScrollBars := ssVertical
//    else if (m_HScrollBar <> nil) and (m_VScrollBar = nil) then
//        ScrollBars := ssHorizontal
//    else
//        ScrollBars := ssNone;
//end;
//
//procedure TsuiRichEdit.UpdateScrollBars;
//var
//    info : tagScrollInfo;
//    barinfo : tagScrollBarInfo;
//begin
//    if m_UserChanging then
//        Exit;
//    m_SelfChanging := true;
//    if m_HScrollBar <> nil then
//    begin
//        barinfo.cbSize := SizeOf(barinfo);
//        GetScrollBarInfo(Handle, Integer(OBJID_HSCROLL), barinfo);
//        if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
//           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) then
//        begin
//            m_HScrollBar.LineButton := 0;
//            m_HScrollBar.Enabled := false;
//            m_HScrollBar.SliderVisible := false;
//        end
//        else
//        begin
//            m_HScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
//            m_HScrollBar.SmallChange := 3 * m_HScrollBar.PageSize;
//            m_HScrollBar.Enabled := true;
//            m_HScrollBar.SliderVisible := true;
//        end;
//        info.cbSize := SizeOf(info);
//        info.fMask := SIF_ALL;
//        GetScrollInfo(Handle, SB_HORZ, info);
//        m_HScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
//        m_HScrollBar.Min := info.nMin;
//        m_HScrollBar.Position := info.nPos;
//    end;
//
//    if m_VScrollBar <> nil then
//    begin
//        barinfo.cbSize := SizeOf(barinfo);
//        GetScrollBarInfo(Handle, Integer(OBJID_VSCROLL), barinfo);
//        if (barinfo.rgstate[0] = STATE_SYSTEM_INVISIBLE) or
//           (barinfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE) then
//        begin
//            m_VScrollBar.LineButton := 0;
//            m_VScrollBar.Enabled := false;
//            m_VScrollBar.SliderVisible := false;
//        end
//        else
//        begin
//            m_VScrollBar.LineButton := abs(barinfo.xyThumbBottom - barinfo.xyThumbTop);
//            m_VScrollBar.Enabled := true;
//            m_VScrollBar.SliderVisible := true;
//        end;
//        info.cbSize := SizeOf(info);
//        info.fMask := SIF_ALL;
//        GetScrollInfo(Handle, SB_VERT, info);
//        m_VScrollBar.Max := info.nMax - Integer(info.nPage) + 1;
//        m_VScrollBar.Min := info.nMin;
//        m_VScrollBar.Position := info.nPos;
//    end;
//    m_SelfChanging := false;
//end;
//
//procedure TsuiRichEdit.UpdateScrollBarsPos;
//begin
//    if m_HScrollBar <> nil then
//    begin
//        if Height < m_HScrollBar.Height then
//            m_HScrollBar.Visible := false
//        else
//            m_HScrollBar.Visible := true;
//        m_HScrollBar.Left := Left + 1;
//        m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 2;
//        if m_VScrollBar <> nil then
//            m_HScrollBar.Width := Width - 2 - m_VScrollBar.Width
//        else
//            m_HScrollBar.Width := Width - 2
//    end;
//
//    if m_VScrollBar <> nil then
//    begin
//        if Width < m_VScrollBar.Width then
//            m_VScrollBar.Visible := false
//        else
//            m_VScrollBar.Visible := true;
//        m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 2;
//        m_VScrollBar.Top := Top + 1;
//        if m_HScrollBar <> nil then
//            m_VScrollBar.Height := Height - 2 - m_HScrollBar.Height
//        else
//            m_VScrollBar.Height := Height - 2;
//    end;
//
//    UpdateScrollBars();    
//end;
//
//procedure TsuiRichEdit.WMClear(var Message: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMCut(var Message: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMEARSEBKGND(var Msg: TMessage);
//begin
//    inherited;
//
//    DrawControlBorder(self, m_BorderColor, Color);
//end;
//
//procedure TsuiRichEdit.WMHSCROLL(var Message: TWMHScroll);
//begin
//    inherited;
//    if m_UserChanging then
//        Exit;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMKeyDown(var Message: TWMKeyDown);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMLBUTTONDOWN(var Message: TMessage);
//begin
//    inherited;
//    m_MouseDown := true;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMLButtonUp(var Message: TMessage);
//begin
//    inherited;
//    m_MouseDown := false;
//end;
//
//procedure TsuiRichEdit.WMMOUSEMOVE(var Message: TMessage);
//begin
//    inherited;
//    if m_MouseDown then UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMMOUSEWHEEL(var Message: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMMOVE(var Msg: TMessage);
//begin
//    inherited;
//    UpdateScrollBarsPos();
//end;
//
//procedure TsuiRichEdit.WMPAINT(var Msg: TMessage);
//begin
//    inherited;
//
//    DrawControlBorder(self, m_BorderColor, Color);
//end;
//
//procedure TsuiRichEdit.WMPaste(var Message: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMSetText(var Message: TWMSetText);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMSIZE(var Msg: TMessage);
//begin
//    inherited;
//    UpdateScrollBarsPos();
//end;
//
//procedure TsuiRichEdit.WMUndo(var Message: TMessage);
//begin
//    inherited;
//    UpdateScrollBars();
//end;
//
//procedure TsuiRichEdit.WMVSCROLL(var Message: TWMVScroll);
//begin
//    inherited;
//    if m_UserChanging then
//        Exit;
//    UpdateScrollBars();
//end;

end.
