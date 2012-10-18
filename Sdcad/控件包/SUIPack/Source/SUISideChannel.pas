////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUISideChannel.pas
//  Creator     :   Shen Min
//  Date        :   2002-5-13 V1-V3
//                  2003-7-11 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUISideChannel;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Buttons, Graphics,
     Forms, Math,
     SUIThemes, SUIMgr;

type
    TsuiSideChannelAlign = (suiLeft, suiRight);
    TsuiSideChannelPopupMode = (suiMouseOn, suiMouseClick);

    TsuiSideChannel = class(TCustomPanel)
    private
        m_PinBtn : TSpeedButton;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_BorderColor : TColor;
        m_TitleBitmap : TBitmap;
        m_HandleBitmap : TBitmap;
        m_SideColor : TColor;
        m_CaptionFontColor : TColor;
        m_Poped : Boolean;
        m_ShowButton : Boolean;
        m_FromTheme : Boolean;        

        m_Timer : TTimer;

        m_nWidth : Integer;
        m_bMoving : Boolean;
        m_Align : TsuiSideChannelAlign;
        m_StayOn : Boolean;
        m_PopupMode : TsuiSideChannelPopupMode;
        m_QuickMove : Boolean;

        m_OnPop : TNotifyEvent;
        m_OnPush : TNotifyEvent;
        m_OnPin : TNotifyEvent;
        m_OnUnPin : TNotifyEvent;

        procedure OnPinClick(Sender: TObject);
        procedure OnTimerCheck(Sender: TObject);

        procedure SetWidth(NewValue : Integer);
        procedure SetSideColor(NewValue : TColor);
        function GetSideColor() : TColor;
        function GetSideWidth() : Integer;
        procedure SetAlign(const Value : TsuiSideChannelAlign);
        procedure SetStayOn(const Value : Boolean);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetBorderColor(const Value: TColor);
        procedure SetCaptionFontColor(const Value: TColor);
        procedure SetSideWidth(const Value: Integer);
        procedure SetHandleBitmap(const Value: TBitmap);
        procedure SetTitleBitmap(const Value: TBitmap);
        procedure SetShowButton(const Value: Boolean);
        
        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
        procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;

    protected
        procedure Paint(); override;
        procedure Resize(); override;
        function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        procedure AlignControls(AControl: TControl; var Rect: TRect); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure Pop(bQuick : Boolean = true);
        procedure Push(bQuick : Boolean = true);

        property HandleImage : TBitmap read m_HandleBitmap write SetHandleBitmap;
        property TitleImage : TBitmap read m_TitleBitmap write SetTitleBitmap;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property CaptionFontColor : TColor read m_CaptionFontColor write SetCaptionFontColor;
        property ShowButton : Boolean read m_ShowButton write SetShowButton;
        property Popped : Boolean read m_Poped;
                
        property Anchors;
        property BiDiMode;            
        property Width read m_nWidth write SetWidth;
        property SideBarColor : TColor read GetSideColor write SetSideColor;
        property Caption;
        property Font;
        property Alignment;
        property Align : TsuiSideChannelAlign read m_Align write SetAlign;
        property StayOn : Boolean read m_StayOn write SetStayOn;
        property Visible;
        property Color;
        property ParentColor;
        property ParentShowHint;
        property ParentBiDiMode;
        property ParentFont;
        property PopupMenu;

        property PopupMode : TsuiSideChannelPopupMode read m_PopupMode write m_PopupMode;
        property QuickMove : Boolean read m_QuickMove write m_QuickMove;

        property OnResize;
        property OnCanResize;
        property OnPush : TNotifyEvent read m_OnPush write m_OnPush;
        property OnPop : TNotifyEvent read m_OnPop write m_OnPop;
        property OnPin : TNotifyEvent read m_OnPin write m_OnPin;
        property OnUnPin : TNotifyEvent read m_OnUnPin write m_OnUnPin;

        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;

        // no use, only for compatibility
        property SideBarWidth : Integer read GetSideWidth write SetSideWidth;
    end;


implementation

uses SUIResDef, SUIPublic;

{ TsuiSideChannel }

constructor TsuiSideChannel.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);

    m_TitleBitmap := TBitmap.Create();
    m_HandleBitmap := TBitmap.Create();
    m_FromTheme := false;

    m_PinBtn := TSpeedButton.Create(self);
    m_PinBtn.Parent := self;
    m_PinBtn.Flat := true;
    m_PinBtn.Height := 16;
    m_PinBtn.Width := 20;
    m_PinBtn.GroupIndex := 1;
    m_PinBtn.AllowAllUp := true;
    m_PinBtn.Glyph.LoadFromResourceName(hInstance, 'SIDECHANNEL_BTN');
    m_PinBtn.Top := 1;
    m_PinBtn.Left := Width - m_PinBtn.Width - 1;
    m_PinBtn.OnClick := OnPinClick;
    ShowButton := true;
    
    m_Timer := TTimer.Create(self);
    m_Timer.Interval := 1000;
    m_Timer.Enabled := false;
    m_Timer.OnTimer := OnTimerCheck;

    m_bMoving := false;

    BevelOuter := bvNone;
    Align := suiLeft;
    SideBarColor := clBtnFace;
    PopupMode := suiMouseOn;
    QuickMove := false;
    Font.Name := 'Tahoma';
    m_Poped := false;

    UIStyle := GetSUIFormStyle(AOwner);
    
    if (csDesigning in ComponentState) then
        Exit;

    Push(true);
end;

destructor TsuiSideChannel.Destroy;
begin
    m_Timer.Free();
    m_PinBtn.Free();
    m_HandleBitmap.Free();
    m_TitleBitmap.Free();

    inherited;
end;

procedure TsuiSideChannel.OnTimerCheck(Sender: TObject);
var
    CurPos : TPoint;
    LeftTop : TPoint;
    RightBottum : TPoint;
begin
    if m_bMoving then
        Exit;
    LeftTop.x := 0;
    LeftTop.y := 0;
    RightBottum.x := inherited Width;
    RightBottum.y := Height;
    GetCursorPos(CurPos);

    if Parent <> nil then
    begin
        LeftTop := ClientToScreen(LeftTop);
        RightBottum := ClientToScreen(RightBottum);
    end
    else
        Push(m_QuickMove);

    if (
        (CurPos.x > LeftTop.x)      and
        (CurPos.x < RightBottum.x)  and
        (CurPos.y > LeftTop.y)      and
        (CurPos.y < RightBottum.y)
    ) then
        Exit;   // in

    // out
    Push(m_QuickMove);
end;

procedure TsuiSideChannel.Pop(bQuick : Boolean = true);
begin
    m_bMoving := true;

    m_PinBtn.Visible := true;

    if not bQuick then
    begin
        while inherited Width + 15 < m_nWidth do
        begin
            inherited Width := inherited Width + 15;
            Refresh();
            Application.ProcessMessages();
        end;
    end;
    inherited Width := m_nWidth;
    Refresh();

    m_Timer.Enabled := true;
    m_bMoving := false;
    m_Poped := true;
    Repaint();
    if Assigned (m_OnPop) then
        m_OnPop(self);
end;

procedure TsuiSideChannel.Push(bQuick : Boolean = true);
begin
    m_bMoving := true;
    m_Poped := false;    
    m_Timer.Enabled := false;

    if not bQuick then
    begin
        while inherited Width - 15 > 10 do
        begin
            inherited Width := inherited Width - 15;
            Refresh();
            Application.ProcessMessages();
        end;
    end;
    inherited Width := 10;
    Refresh();

    m_PinBtn.Visible := false;
    m_bMoving := false;
    Repaint();
    if Assigned(m_OnPush) then
        m_OnPush(self);
end;

procedure TsuiSideChannel.SetWidth(NewValue: Integer);
begin
    m_nWidth := NewValue;

    if (csDesigning in ComponentState) or m_Poped then
        inherited Width := m_nWidth;
end;

function TsuiSideChannel.GetSideColor: TColor;
begin
    Result := m_SideColor;
end;

procedure TsuiSideChannel.SetSideColor(NewValue: TColor);
begin
    m_SideColor := NewValue;
    Repaint();
end;

procedure TsuiSideChannel.OnPinClick(Sender: TObject);
begin
    m_Timer.Enabled := not m_PinBtn.Down;
    m_PinBtn.Glyph.LoadFromResourceName(hInstance, 'SIDECHANNEL_BTN');
    if m_PinBtn.Down then
        RoundPicture3(m_PinBtn.Glyph);
    m_StayOn := m_PinBtn.Down;
    if m_StayOn then
    begin
        if Assigned(m_OnPin) then
            m_OnPin(self);
    end
    else
    begin
        if Assigned(m_OnUnPin) then
            m_OnUnPin(self);
    end;
end;

function TsuiSideChannel.GetSideWidth: Integer;
begin
    Result := 10;
end;

procedure TsuiSideChannel.SetAlign(const Value: TsuiSideChannelAlign);
begin
    m_Align := Value;

    if m_Align = suiLeft then
        inherited Align := alLeft
    else
        inherited Align := alRight;
end;

procedure TsuiSideChannel.SetStayOn(const Value: Boolean);
begin
    m_StayOn := Value;

    if Value then
    begin
        if not (csDesigning in ComponentState) then
            Pop(m_QuickMove);
        m_PinBtn.Down := true;
    end
    else
    begin
        m_PinBtn.Down := false;
        if not (csDesigning in ComponentState) then
            Push(true);
    end;
    Resize();
    if not (csDesigning in ComponentState) then
        m_PinBtn.Click();
end;

procedure TsuiSideChannel.Paint;
var
    Buf : TBitmap;
    R : TRect;
    Y : Integer;
begin
    Buf := TBitmap.Create();
    Buf.Width := inherited Width;
    Buf.Height := Height;

    Buf.Canvas.Brush.Color := Color;
    Buf.Canvas.Pen.Color := m_BorderColor;
    Buf.Canvas.Rectangle(ClientRect);

    R := Rect(1, 0, inherited Width - 1, m_TitleBitmap.Height);
    Buf.Canvas.StretchDraw(R, m_TitleBitmap);

    if m_Poped or (csDesigning in ComponentState) then
    begin
        R.Left := R.Left + m_PinBtn.Width;
        R.Right := R.Right - m_PinBtn.Width;
        Buf.Canvas.Font.Assign(Font);
        Buf.Canvas.Font.Color := m_CaptionFontColor;
        Buf.Canvas.Brush.Style := bsClear;
        case Alignment of
        taLeftJustify : DrawText(Buf.Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_SINGLELINE or DT_VCENTER);
        taCenter : DrawText(Buf.Canvas.Handle, PChar(Caption), -1, R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
        taRightJustify : DrawText(Buf.Canvas.Handle, PChar(Caption), -1, R, DT_RIGHT or DT_SINGLELINE or DT_VCENTER);
        end;
    end;

    R := Rect(1, m_TitleBitmap.Height, 9, Height - 1);
    Buf.Canvas.Brush.Color := m_SideColor;
    Buf.Canvas.FillRect(R);
    Buf.Canvas.Pen.Color := clGray;
    Buf.Canvas.MoveTo(9, m_TitleBitmap.Height);
    Buf.Canvas.LineTo(9, Height - 1);
    Y := (Height - m_HandleBitmap.Height) div 2;
    if Y < m_TitleBitmap.Height + 1 then
        Y := m_TitleBitmap.Height + 1;
    Buf.Canvas.Draw(1, Y, m_HandleBitmap);
    
    BitBlt(Canvas.Handle, 0, 0, Width, Height, Buf.Canvas.Handle, 0, 0, SRCCOPY);

    Buf.Free();
end;

procedure TsuiSideChannel.Resize;
begin
    inherited;

    if (
        (not m_bMoving) and
        (inherited Width > 10)
    ) then
    begin
        m_nWidth := inherited Width;
    end;

    m_PinBtn.Left := Width - m_PinBtn.Width - 1; 
end;

function TsuiSideChannel.CanResize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
    if (
        (not m_bMoving) and
        (m_PinBtn.Visible) and
        (NewWidth < 50)
    ) then
        Result := false
    else
        Result := true;
end;

procedure TsuiSideChannel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;
    if (
        (Operation = opRemove) and
        (AComponent = m_FileTheme)
    )then
    begin
        m_FileTheme := nil;
        ContainerApplyUIStyle(self, SUI_THEME_DEFAULT, nil);
        SetUIStyle(SUI_THEME_DEFAULT);          
    end;
end;

procedure TsuiSideChannel.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    m_FromTheme := true;
    SetUIStyle(m_UIStyle);
    m_FromTheme := false;
end;

procedure TsuiSideChannel.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;

    if m_FromTheme and (m_UIStyle <> FromThemeFile) then
        Exit;    

    Color := clWhite;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_SideColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
        m_FileTheme.GetBitmap(SUI_THEME_SIDECHENNEL_HANDLE_IMAGE, m_HandleBitmap);
        m_FileTheme.GetBitmap(SUI_THEME_SIDECHENNEL_BAR_IMAGE, m_TitleBitmap);
        m_BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
        m_CaptionFontColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR);
        if (
            (m_CaptionFontColor = 131072) or
            (m_CaptionFontColor = 262144) or
            (m_CaptionFontColor = 196608) or
            (m_CaptionFontColor = 327680) or
            (m_CaptionFontColor = 8016662) or
            (m_CaptionFontColor = 2253583)
        ) then
            m_CaptionFontColor := clBlack
        else
            m_CaptionFontColor := clWhite;            
    end
    else
    begin
        m_SideColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_SIDECHENNEL_HANDLE_IMAGE, m_HandleBitmap);
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_SIDECHENNEL_BAR_IMAGE, m_TitleBitmap);
        m_BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
{$IFDEF RES_MACOS}
        if OutUIStyle = MacOS then
            m_CaptionFontColor := clBlack
        else
{$ENDIF}        
            m_CaptionFontColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);
    end;
    if m_ShowButton then
        m_PinBtn.Top := Min((m_TitleBitmap.Height - m_PinBtn.Height) div 2, 5)
    else
    begin
        m_PinBtn.Top := -50;
        StayOn := True;
    end;

    ContainerApplyUIStyle(self, OutUIStyle, m_FileTheme);

    Repaint();
end;

procedure TsuiSideChannel.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    Repaint();
end;

procedure TsuiSideChannel.SetCaptionFontColor(const Value: TColor);
begin
    m_CaptionFontColor := Value;
    Repaint();
end;

procedure TsuiSideChannel.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
    Rect.Right := Rect.Right - 3;
    Rect.Bottom := Rect.Bottom - 3;
    Rect.Top := Rect.Top + m_TitleBitmap.Height + 3;
    Rect.Left := Rect.Left + 13;
    inherited AlignControls(AControl, Rect);
end;

procedure TsuiSideChannel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
    Form : TCustomForm;
begin
    inherited;

    if m_bMoving then
        Exit;

    if (
        m_Poped or
        (m_PopupMode <> suiMouseOn)
    ) then
        Exit;
    Form := GetParentForm(self);
    if Form = nil then
        Exit;
    if (not Form.Active) and ((Form as TForm).FormStyle <> fsMDIForm) then
        Exit;
    if not FormHasFocus(Form) then
        Exit;
    Pop(m_QuickMove);
end;

procedure TsuiSideChannel.SetSideWidth(const Value: Integer);
begin
    // do nothing
end;

procedure TsuiSideChannel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
    inherited;

    if m_Poped or (m_PopupMode <> suiMouseClick) then
        Exit;

    Pop(m_QuickMove);
end;

procedure TsuiSideChannel.SetHandleBitmap(const Value: TBitmap);
begin
    m_HandleBitmap.Assign(Value);
    Repaint();
end;

procedure TsuiSideChannel.SetTitleBitmap(const Value: TBitmap);
begin
    m_TitleBitmap.Assign(Value);
    Repaint();
end;

procedure TsuiSideChannel.WMERASEBKGND(var Msg: TMessage);
begin
    // do nothing
end;

procedure TsuiSideChannel.CMTextChanged(var Msg: TMessage);
begin
    Repaint();
end;

procedure TsuiSideChannel.SetShowButton(const Value: Boolean);
begin
    m_ShowButton := Value;
    if Value then
    begin
        m_PinBtn.Top := 1;
    end
    else
    begin
        m_PinBtn.Top := -50;
        StayOn := True;
    end;
end;

end.
