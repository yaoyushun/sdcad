////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUICheckListBox.pas
//  Creator     :   Shen Min
//  Date        :   2002-09-07 V1-V3
//                  2003-07-15 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUICheckListBox;

interface

{$I SUIPack.inc}

uses Windows, Messages, CheckLst, Graphics, Forms, Classes, Controls, SysUtils,
     SUIScrollBar, SUIThemes, SUIMgr;

type
    TsuiCheckListBox = class(TCheckListBox)
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
        procedure LBADDSTRING(var Msg : TMessage); message LB_ADDSTRING;
        procedure LBDELETESTRING(var Msg : TMessage); message LB_DELETESTRING;
        procedure LBINSERTSTRING(var Msg : TMessage); message LB_INSERTSTRING;
        procedure LBSETCOUNT(var Msg : TMessage); message LB_SETCOUNT;
        procedure LBNSELCHANGE(var Msg : TMessage); message LBN_SELCHANGE;
        procedure LBNSETFOCUS(var Msg : TMessage); message LBN_SETFOCUS;
        procedure WMDELETEITEM(var Msg : TMessage); message WM_DELETEITEM;
        procedure WMMOUSEMOVE(var Message: TMessage); message WM_MOUSEMOVE;
        procedure WMVSCROLL(var Message: TWMVScroll); message WM_VSCROLL;
        procedure WMHSCROLL(var Message: TWMHScroll); message WM_HSCROLL;

        procedure SetBorderColor(const Value: TColor);
        procedure WMPAINT(var Msg : TMessage); message WM_PAINT;
        procedure WMEARSEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
        function GetBorderStyle() : TBorderStyle;
        procedure SetBorderStyle(const Value : TBorderStyle);
        function GetBorderWidth: TBorderWidth;
        procedure SetBorderWidth(const Value: TBorderWidth);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);

    private
        FSelectedTextColor: TColor;
        FSelectedColor: TColor;
        FDisabledTextColor: TColor;

        procedure SetSelectedColor(const Value: TColor);
        procedure SetSelectedTextColor(const Value: TColor);
        procedure SetDisabledTextColor(const Value: TColor);
        procedure CNDrawItem(var Msg: TWMDrawItem); message CN_DRAWITEM;          
        
    protected
        procedure DrawItem(Index: Integer; Rect: TRect;State: TOwnerDrawState); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner : TComponent); override;

    published
        property SelectedColor: TColor read FSelectedColor write SetSelectedColor;
        property SelectedTextColor: TColor read FSelectedTextColor write SetSelectedTextColor;
        property DisabledTextColor: TColor read FDisabledTextColor  write SetDisabledTextColor;

        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;

        property BorderStyle : TBorderStyle read GetBorderStyle write SetBorderStyle;
        property BorderWidth : TBorderWidth read GetBorderWidth write SetBorderWidth;

        // scroll bar
        property VScrollBar : TsuiScrollBar read m_VScrollBar write SetVScrollBar;
        property HScrollBar : TsuiScrollBar read m_HScrollBar write SetHScrollBar;
    end;


implementation

uses SUIPublic, SUIProgressBar;

procedure DrawBorder(WinControl : TWinControl; BorderColor, Color : TColor);
var
    DC : HDC;
    Brush : HBRUSH;
    R: TRect;
begin
    DC := GetWindowDC(WinControl.Handle);

    GetWindowRect(WinControl.Handle, R);
    OffsetRect(R, -R.Left, -R.Top);

    Brush := CreateSolidBrush(ColorToRGB(BorderColor));
    FrameRect(DC, R, Brush);
    DeleteObject(Brush);

    ReleaseDC(WinControl.Handle, DC);
end;

{ TsuiCheckListBox }

procedure TsuiCheckListBox.CMEnabledChanged(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.CMVisibleChanged(var Msg: TMEssage);
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

procedure TsuiCheckListBox.CNDrawItem(var Msg: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  inherited;
  with Msg.DrawItemStruct^ do
  begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    Canvas.Handle := hDC;
    Canvas.Font := Font;
    Canvas.Brush := Brush;
    if Integer(itemID) >= 0 then
    begin
      if odSelected in State then
      begin
        Canvas.Brush.Color := FSelectedColor;
        Canvas.Font.Color := FSelectedTextColor;
      end;
      if (([odDisabled, odGrayed] * State) <> []) or not Enabled then
        Canvas.Font.Color := FDisabledTextColor;
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
    begin
      Canvas.FillRect(rcItem);
      if odFocused in State then
        DrawFocusRect(hDC, rcItem);
    end;
    Canvas.Handle := 0;
  end;
end;

constructor TsuiCheckListBox.Create(AOwner: TComponent);
begin
    inherited;

    Flat := True;
    inherited BorderStyle := bsNone;
    BorderWidth := 2;
    m_SelfChanging := false;
    m_MouseDown := false;

    UIStyle := GetSUIFormStyle(AOwner);
    FSelectedColor := clHighlight;
    FSelectedTextColor := clHighlightText;
    FDisabledTextColor := clGrayText;
end;

procedure TsuiCheckListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
    Bitmap : TBitmap;
    bChecked : Boolean;
    nIndex : Integer;
    OutUIStyle : TsuiUIStyle;
begin
    bChecked := Checked[Index];
    inherited;
    Bitmap := TBitmap.Create();

    if Enabled then
    begin
        if bChecked  then
            nIndex := 1
        else
            nIndex := 2
    end
    else
    begin
        if bChecked then
            nIndex := 3
        else
            nIndex := 4;
    end;

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        m_FileTheme.GetBitmap(SUI_THEME_CHECKLISTBOX_IMAGE, Bitmap, 4, nIndex)
    else
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_CHECKLISTBOX_IMAGE, Bitmap, 4, nIndex);

    if Canvas.TextHeight('W') < 12 then
        Rect.Bottom := Rect.Bottom + 1;
    Canvas.Draw(Rect.Left - 13, Rect.Top + (Rect.Bottom - Rect.Top - 11) div 2, Bitmap);

    Bitmap.Free();
end;

function TsuiCheckListBox.GetBorderStyle: TBorderStyle;
begin
    Result := bsSingle;
end;

function TsuiCheckListBox.GetBorderWidth: TBorderWidth;
begin
    Result := 1;
end;

procedure TsuiCheckListBox.LBADDSTRING(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.LBDELETESTRING(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.LBINSERTSTRING(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.LBNSELCHANGE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.LBNSETFOCUS(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.LBSETCOUNT(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if AComponent = nil then
        Exit;

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

procedure TsuiCheckListBox.OnHScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    SendMessage(Handle, WM_HSCROLL, MakeWParam(SB_THUMBPOSITION, m_HScrollBar.Position), 0);
    Invalidate;
end;

procedure TsuiCheckListBox.OnVScrollBarChange(Sender: TObject);
begin
    if m_SelfChanging then
        Exit;
    SendMessage(Handle, WM_VSCROLL, MakeWParam(SB_THUMBPOSITION, m_VScrollBar.Position), 0);
    Invalidate;
end;

procedure TsuiCheckListBox.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiCheckListBox.SetBorderStyle(const Value: TBorderStyle);
begin
    inherited BorderStyle := bsNone;
end;

procedure TsuiCheckListBox.SetBorderWidth(const Value: TBorderWidth);
begin
    inherited BorderWidth := 1;
end;

procedure TsuiCheckListBox.SetDisabledTextColor(const Value: TColor);
begin
  if FDisabledTextColor <> Value then
  begin
    FDisabledTextColor := Value;
    Invalidate;
  end;
end;

procedure TsuiCheckListBox.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    if m_VScrollBar <> nil then
        m_VScrollBar.FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiCheckListBox.SetHScrollBar(const Value: TsuiScrollBar);
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
    m_HScrollBar.Orientation := suiHorizontal;
    m_HScrollBar.OnChange := OnHScrollBArChange;
    m_HScrollBar.BringToFront();

    UpdateScrollBarsPos();
end;

procedure TsuiCheckListBox.SetSelectedColor(const Value: TColor);
begin
  if FSelectedColor <> Value then
  begin
    FSelectedColor := Value;
    Invalidate;
  end;
end;

procedure TsuiCheckListBox.SetSelectedTextColor(const Value: TColor);
begin
  if FSelectedTextColor <> Value then
  begin
    FSelectedTextColor := Value;
    Invalidate;
  end;
end;

procedure TsuiCheckListBox.SetUIStyle(const Value: TsuiUIStyle);
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

procedure TsuiCheckListBox.SetVScrollBar(const Value: TsuiScrollBar);
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
    m_VScrollBar.Orientation := suiVertical;
    m_VScrollBar.OnChange := OnVScrollBArChange;
    m_VScrollBar.BringToFront();

    UpdateScrollBarsPos();
end;

procedure TsuiCheckListBox.UpdateScrollBars;
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

procedure TsuiCheckListBox.UpdateScrollBarsPos;
begin
    if m_HScrollBar <> nil then
    begin
        if m_HScrollBar.Height > Height then
            m_HScrollBar.Top := Top
        else
        begin
            m_HScrollBar.Left := Left + 1;
            m_HScrollBar.Top := Top + Height - m_HScrollBar.Height - 1;
            if m_VScrollBar <> nil then
            begin
                if m_VScrollBar.Visible then
                    m_HScrollBar.Width := Width - 2 - m_VScrollBar.Width
                else
                    m_HScrollBar.Width := Width - 2
            end
            else
                m_HScrollBar.Width := Width - 2
        end;
    end;

    if m_VScrollBar <> nil then
    begin
        if m_VScrollBar.Width > Width then
            m_VScrollBar.Left := Left
        else
        begin
            m_VScrollBar.Left := Left + Width - m_VScrollBar.Width - 1;
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

    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMDELETEITEM(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMEARSEBKGND(var Msg: TMessage);
begin
    inherited;

    DrawBorder(self, m_BorderColor, Color);
end;

procedure TsuiCheckListBox.WMHSCROLL(var Message: TWMHScroll);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMKeyDown(var Message: TWMKeyDown);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMLBUTTONDOWN(var Message: TMessage);
begin
    inherited;
    m_MouseDown := true;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMLButtonUp(var Message: TMessage);
begin
    inherited;
    m_MouseDown := false;
end;

procedure TsuiCheckListBox.WMMOUSEMOVE(var Message: TMessage);
begin
    inherited;
    if m_MouseDown then UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMMOUSEWHEEL(var Message: TMessage);
begin
    inherited;
    UpdateScrollBars();
end;

procedure TsuiCheckListBox.WMMOVE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiCheckListBox.WMPAINT(var Msg: TMessage);
begin
    inherited;

    DrawBorder(self, m_BorderColor, Color);
end;

procedure TsuiCheckListBox.WMSIZE(var Msg: TMessage);
begin
    inherited;
    UpdateScrollBarsPos();
end;

procedure TsuiCheckListBox.WMVSCROLL(var Message: TWMVScroll);
begin
    inherited;
    UpdateScrollBars();
end;

end.
