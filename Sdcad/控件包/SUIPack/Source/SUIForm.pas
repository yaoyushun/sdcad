////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIForm.pas
//  Creator     :   Shen Min
//  Date        :   2002-05-21 V1-V3
//                  2003-06-19 V4
//                  2004-07-02 V5
//  Comment     :
//
//  Copyright (c) 2002-2004 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIForm;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, Graphics, Forms,
     ComCtrls, Menus, Dialogs, Buttons, AppEvnts, Math,
     SUITitleBar, SUIThemes, SUIMgr, SUIButton, SUIScrollBar, frmMSNPop;

type
    TsuiForm = class;
    TsuiMDIForm = class;
    TsuiMenuBar = class(TToolBar)
    private
        m_Form : TsuiForm;
        m_MDIForm : TsuiMDIForm;

        procedure OnMenuPopup(Sender : TObject);
        
    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    end;

    TsuiForm = class(TCustomPanel)
    private
        m_TitleBar : TsuiTitleBar;
        m_MenuBar : TsuiMenuBar;
        m_Menu : TMainMenu;
        m_OldWndProc : TWndMethod;
        m_BorderBuf : TBitmap;
        m_BottomBorderWidth : Integer;
        m_OldBorderStyle : TFormBorderStyle;        

        m_Form : TForm;
        m_Color : TColor;
        m_Panel : TCustomPanel;
        m_Width : Integer;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;        
        m_MenuBarColor : TColor;
        m_MenuBarHeight : Integer;
        m_UIStyleAutoUpdateSub : Boolean;
        m_Destroyed : Boolean;
        m_AppEvent : TApplicationEvents; 

        m_FormInitRect : TRect;
        m_FormInitMax : Boolean;
        m_MDIChildFormTitleVisible : Boolean;
        m_SelfChanging : Boolean;

        procedure NewParentWndProc(var Msg: TMessage);
        procedure ProcessKeyPress(var Msg : TMessage);
        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
        procedure SetButtons(const Value : TsuiTitleBarButtons);
        function GetButtons() : TsuiTitleBarButtons;

        function GetOnBtnClick() : TsuiTitleBarButtonClickEvent;
        procedure SetOnBtnClick(const Value : TsuiTitleBarButtonClickEvent);
        function GetOnHelpBtnClick() : TsuiTitleBarButtonClickEvent;
        procedure SetOnHelpBtnClick(const Value : TsuiTitleBarButtonClickEvent);

        function GetFont() : TFont;
        procedure SetFont(const Value : TFont);
        function GetCaption() : TCaption;
        procedure SetCaption(const Value : TCaption);

        procedure SetMenu(const Value : TMainMenu);
        procedure SetMenuBarColor(const Value : TColor);
        function GetSections: TsuiTitleBarSections;
        procedure SetSections(const Value: TsuiTitleBarSections);
        procedure SetColor(const Value: TColor);
        function GetDrawAppIcon: Boolean;
        procedure SetDrawAppIcon(const Value: Boolean);
        procedure SetMenuBarHeight(const Value: Integer);
        procedure SetTitleBarVisible(const Value: Boolean);
        function GetTitleBarVisible: Boolean;
        function GetMDIChild: Boolean;
        function GetRoundCorner: Integer;
        procedure SetRoundCorner(const Value: Integer);
        function GetRoundCornerBottom: Integer;
        procedure SetRoundCornerBottom(const Value: Integer);
        procedure SetFileTheme(const Value: TsuiFileTheme);

        procedure DrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
        procedure DrawMenuBar(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);

        procedure OnApplicationMessage(var Msg: TMsg; var Handled: Boolean);
{$IFDEF SUIPACK_D5}
        procedure OnApplicationHint(Sender : TObject);
{$ENDIF}
        function GetTitleBarHeight: Integer;
        function GetTitleBarCustom: Boolean;
        procedure SetTitleBarCustom(const Value: Boolean);
        function GetVersion: String;
        procedure SetVersion(const Value: String);

        procedure RegionWindow();

    protected
        procedure SetPanel(const Value : TCustomPanel);
        procedure SetBorderWidth(const Value : Integer);
        procedure SetUIStyle(const Value : TsuiUIStyle);
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        procedure PaintFormBorder();
        procedure Paint(); override;
        procedure Resize(); override;

        procedure CreateMenuBar();
        procedure DestroyMenuBar();

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure UpdateMenu();
        procedure UpdateTopMenu();
        procedure RepaintMenuBar();
        
        property MDIChild : Boolean read GetMDIChild;
        property TitleBarHeight : Integer read GetTitleBarHeight;
        procedure ReAssign;        
        
    published
        property TitleBarCustom : Boolean read GetTitleBarCustom write SetTitleBarCustom;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property UIStyleAutoUpdateSub : Boolean read m_UIStyleAutoUpdateSub write m_UIStyleAutoUpdateSub;
        property BorderColor : TColor read m_Color write SetColor;
        property BorderWidth : Integer read m_Width write SetBorderWidth;
        property TitleBarVisible : Boolean read GetTitleBarVisible write SetTitleBarVisible default True;
        property BiDiMode;
        property Color;
        property Caption : TCaption read GetCaption write SetCaption;
        property FormPanel : TCustomPanel read m_Panel write SetPanel;
        property TitleBarButtons : TsuiTitleBarButtons read GetButtons write SetButtons;
        property TitleBarSections : TsuiTitleBarSections read GetSections write SetSections;
        property TitleBarDrawAppIcon : Boolean read GetDrawAppIcon write SetDrawAppIcon;
        property Font : TFont read GetFont write SetFont;
        property Menu : TMainMenu read m_Menu write SetMenu;
        property MenuBarColor : TColor read m_MenuBarColor write SetMenuBarColor;
        property MenuBarHeight : Integer read m_MenuBarHeight write SetMenuBarHeight;
        property RoundCorner : Integer read GetRoundCorner write SetRoundCorner;
        property RoundCornerBottom : Integer read GetRoundCornerBottom write SetRoundCornerBottom;
        property PopupMenu;
        property Version : String read GetVersion write SetVersion;

        property OnTitleBarCustomBtnsClick : TsuiTitleBarButtonClickEvent read GetOnBtnClick write SetOnBtnClick;
        property OnTitleBarHelpBtnClick : TsuiTitleBarButtonClickEvent read GetOnHelpBtnClick write SetOnHelpBtnClick;
        property OnMouseDown;
    	property OnMouseMove;
        property OnClick;
        property OnMouseUp;

    end;

    TsuiMDIForm = class(TComponent)
    private
        m_Form : TForm;
        m_OldWndProc : TWndMethod; 
        m_PrevClientWndProc: Pointer;
        m_TopPanel : TPanel;
        m_TitleBar : TsuiTitleBar;
        m_MenuBar : TsuiMenuBar;
        m_ControlBtns : array [1..3] of TsuiToolBarSpeedButton;
        m_DrawChildCaptions : Boolean;
        m_DrawChildMenus : Boolean;
        m_Destroyed : Boolean;
        m_BorderBuf : TBitmap;
        m_BottomBorderWidth : Integer;        

        m_Menu : TMainMenu;
        m_TopMenu : TMainMenu;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_MenuBarColor : TColor;
        m_BorderColor : TColor;
        m_BorderWidth : Integer;
        m_RoundCorner : Integer;
        m_RoundCornerBottom : Integer;
        m_AppEvent : TApplicationEvents;
        m_WindowMenuList : TList;

        procedure NewParentWndProc(var Msg: TMessage);
        procedure NewClientWndProc(var Msg : TMessage);
        procedure ProcessKeyPress(var Msg : TMessage);
        procedure OnControlButtonClick(Sender : TObject);
        procedure OnApplicationMessage(var Msg: TMsg; var Handled: Boolean);
        procedure OnTopPanelResize(Sender : TObject);
        procedure OnWindowMenuClick(Sender : TObject);
        procedure SetMenu(const Value: TMainMenu);
        procedure SetMenuBarColor(const Value : TColor);
        procedure SetUIStyle(const Value : TsuiUIStyle);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetBorderColor(const Value: TColor);
        function GetCaption: TCaption;
        procedure SetCaption(const Value: TCaption);

        procedure PaintBorder();
        function GetActiveChildSUIForm() : TsuiForm;

        procedure CreateMenuBar();
        procedure DestroyMenuBar();
        procedure ShowMenuBar();
        procedure HideMenuBar();
        procedure ShowControlButtons();
        procedure HideControlButtons();
        function GetMainMenu() : TMainMenu;

        procedure SetDrawAppIcon(const Value: Boolean);
        function GetDrawAppIcon: Boolean;
        function GetTitleBarCustom: Boolean;
        procedure SetTitleBarCustom(const Value: Boolean);
        procedure SetTitleBarVisible(const Value: Boolean);
        function GetTitleBarVisible: Boolean;
        function GetSections: TsuiTitleBarSections;
        procedure SetSections(const Value: TsuiTitleBarSections);
        procedure SetButtons(const Value : TsuiTitleBarButtons);
        function GetButtons() : TsuiTitleBarButtons;

        procedure DrawButton(Sender: TToolBar; Button: TToolButton; State: TCustomDrawState; var DefaultDraw: Boolean);
        procedure DrawMenuBar(Sender: TToolBar; const ARect: TRect; var DefaultDraw: Boolean);
        procedure SetRoundCorner(const Value: Integer);
        procedure SetRoundCornerBottom(const Value: Integer);

        procedure RegionWindow();

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        procedure Loaded(); override;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure UpdateMenu();
        procedure UpdateWindowMenu();
        procedure Cascade();
        procedure Tile();

        function GetTitleBarHeight: integer;

    published
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property Menu : TMainMenu read m_Menu write SetMenu;
        property MenuBarColor : TColor read m_MenuBarColor write SetMenuBarColor;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property Caption : TCaption read GetCaption write SetCaption;
        property TitleBarDrawAppIcon : Boolean read GetDrawAppIcon write SetDrawAppIcon default False;
        property TitleBarCustom : Boolean read GetTitleBarCustom write SetTitleBarCustom default False;
        property TitleBarVisible : Boolean read GetTitleBarVisible write SetTitleBarVisible default True;
        property TitleBarButtons : TsuiTitleBarButtons read GetButtons write SetButtons;
        property TitleBarSections : TsuiTitleBarSections read GetSections write SetSections;
        property TitleBarDrawChildCaptions : Boolean read m_DrawChildCaptions write m_DrawChildCaptions default True;
        property TitleBarDrawChildMenus : Boolean read m_DrawChildMenus write m_DrawChildMenus default True;
        property RoundCorner : Integer read m_RoundCorner write SetRoundCorner;
        property RoundCornerBottom : Integer read m_RoundCornerBottom write SetRoundCornerBottom;
    end;

    TsuiMSNPopForm = class(TComponent)
    private
        m_Form : TfrmMSNPopForm;
        m_AnimateTime : Integer;
        m_StayTime : Integer;
        m_X : Integer;
        m_Y : Integer;
        m_AutoPosition : Boolean;
        m_ClickHide : Boolean;
        m_Title : TCaption;
        m_Text : String;
        m_TextFont : TFont;
        m_TitleFont : TFont;
        m_OnTitleClick : TNotifyEvent;
        m_OnClick : TNotifyEvent;
        m_OnClose : TNotifyEvent;
        m_OnShow : TNotifyEvent;

        procedure InternalOnTitleClick(Sender : TObject);
        procedure InternalOnClick(Sender : TObject);
        procedure InternalOnClose(Sender : TObject);
        procedure SetTextFont(const Value: TFont);
        procedure SetTitleFont(const Value: TFont);

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure Popup();
        procedure Close();

    published
        property AnimateTime : Integer read m_AnimateTime write m_AnimateTime;
        property StayTime : Integer read m_StayTime write m_StayTime;
        property PositionX : Integer read m_X write m_X;
        property PositionY : Integer read m_Y write m_Y;
        property AutoPosition : Boolean read m_AutoPosition write m_AutoPosition;
        property ClickHide : Boolean read m_ClickHide write m_ClickHide;
        property Title : TCaption read m_Title write m_Title;
        property MessageText : String read m_Text write m_Text;

        property TitleFont : TFont read m_TitleFont write SetTitleFont;
        property MessageFont : TFont read m_TextFont write SetTextFont;

        property OnTitleClick : TNotifyEvent read m_OnTitleClick write m_OnTitleClick;
        property OnClick : TNotifyEvent read m_OnClick write m_OnClick;
        property OnClose : TNotifyEvent read m_OnClose write m_OnClose;
        property OnShow : TNotifyEvent read m_OnShow write m_OnShow;
    end;


implementation

uses SUIResDef, SUIPublic, SUIImagePanel, SUIMainMenu, SUIMenu, SUIProgressBar;

{ TsuiForm }

constructor TsuiForm.Create(AOwner: TComponent);
var
    i : Integer;
    c : Integer;
begin
    inherited;

    if not (AOwner is TForm) then
        Exit;

    m_Form := AOwner as TForm;
    c := 0;
    for i := 0 to m_Form.ControlCount - 1 do
    begin
        if m_Form.Controls[i] is TsuiForm then
            Inc(c);
    end;
    if c >= 1 then
        Exit;

    m_Destroyed := false;

    m_Form.Constraints.MinHeight := 50;
    m_Form.Constraints.MinWidth := 125;
    Constraints.MinHeight := 50;
    Constraints.MinWidth := 125;

    m_Form.BorderWidth := 0;
    m_FormInitRect := Classes.Rect(m_Form.Left, m_Form.Top, m_Form.Width + m_Form.Left, m_Form.Height + m_Form.Top);
    m_FormInitMax := (m_Form.WindowState = wsMaximized);

    m_TitleBar := TsuiTitleBar.Create(self);
    m_TitleBar.Parent := self;

    m_MenuBar := nil;
    m_MenuBarColor := Color;
    m_MenuBarHeight := 22;

    UIStyle := SUI_THEME_DEFAULT;
    m_UIStyleAutoUpdateSub := false;

    BevelOuter := bvNone;
    BevelInner := bvNone;
    BorderStyle := bsNone;
    Align := alClient;
    Caption := m_Form.Caption;
    TitleBarVisible := true;
    m_MDIChildFormTitleVisible := true;
    m_SelfChanging := false;
    inherited Caption := ' ';

    for i := 0 to m_Form.ControlCount - 1 do
    begin
        if m_Form.Controls[i] is TsuiForm then
            raise Exception.Create('Sorry, You can create only one TsuiForm component in one form!');
    end;

    m_Form.Scaled := false;

    m_OldBorderStyle := m_Form.BorderStyle;
    case m_Form.BorderStyle of
    bsNone, bsSingle, bsToolWindow: m_Form.BorderStyle := bsDialog;
    end;

    SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));

    m_Form.AutoScroll := false;

    m_OldWndProc := m_Form.WindowProc;
    m_Form.WindowProc := NewParentWndProc;

    m_AppEvent := TApplicationEvents.Create(nil);
{$IFDEF SUIPACK_D5}
    m_AppEvent.OnHint := OnApplicationHint;
{$ENDIF}
    m_AppEvent.OnMessage := OnApplicationMessage;

    SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TsuiForm.CreateMenuBar;
begin
    if m_MenuBar <> nil then
        Exit;
    if m_Form.FormStyle = fsMDIChild then
        Exit;
    m_MenuBar := TsuiMenuBar.Create(self);
    m_MenuBar.m_Form := self;
    m_MenuBar.Parent := self;
    m_MenuBar.Flat := true;
    m_MenuBar.EdgeBorders := [];
    m_MenuBar.ShowCaptions := true;
    m_MenuBar.Height := m_MenuBarHeight;
    m_MenuBar.Color := m_MenuBarColor;
    if not (csDesigning in ComponentState) then
        m_MenuBar.OnCustomDrawButton := DrawButton;
    m_MenuBar.OnCustomDraw := DrawMenuBar;
    m_MenuBar.Wrapable := true;
    m_MenuBar.AutoSize := true;
    m_TitleBar.Top := 0;
end;

destructor TsuiForm.Destroy;
begin
    m_Destroyed := true;
    m_AppEvent.Free();
    m_AppEvent := nil;

    if m_MenuBar <> nil then
    begin
        m_MenuBar.Free();
        m_MenuBar := nil;
    end;

    m_TitleBar.Free();
    m_TitleBar := nil;

    if m_BorderBuf <> nil then
    begin
        m_BorderBuf.Free();
        m_BorderBuf := nil;
    end;

    inherited;
end;

procedure TsuiForm.DestroyMenuBar;
begin
    if m_Form.FormStyle <> fsMDIChild then
    begin
        if m_MenuBar <> nil then
        begin
            m_MenuBar.Free();
            m_MenuBar := nil;
        end;
    end;
    m_Menu := nil;
end;

procedure TsuiForm.DrawButton(Sender: TToolBar; Button: TToolButton;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var
    ACanvas : TCanvas;
    ARect : TRect;
    R : TRect;
    Bmp : TBitmap;
    Buf : TBitmap;
    Style : TsuiUIStyle;
    OutUIStyle : TsuiUIStyle;
    CanSetFont : Boolean;
    AFileTheme : TsuiFileTheme;
    bUseFileTheme : Boolean;
begin
    Style := m_UIStyle;
    AFileTheme := m_FileTheme;
    CanSetFont := false;

    ACanvas := Sender.Canvas;
    ARect := Button.BoundsRect;
    DefaultDraw := false;    

    if Menu <> nil then
    begin
        if Menu is TsuiMainMenu then
        begin
            Style := (Menu as TsuiMainMenu).UIStyle;
            AFileTheme := (Menu as TsuiMainMenu).FileTheme;
            if (m_Menu as TsuiMainMenu).UseSystemFont then
                Menu_GetSystemFont(ACanvas.Font)
            else
            begin
                ACanvas.Font.Name := (m_Menu as TsuiMainMenu).FontName;
                ACanvas.Font.Size := (m_Menu as TsuiMainMenu).FontSize;
                ACanvas.Font.Charset := (m_Menu as TsuiMainMenu).FontCharset;
                ACanvas.Font.Color := (m_Menu as TsuiMainMenu).FontColor;
                CanSetFont := true;
            end;
        end;
    end;

    // MacOS
    if (
        ((cdsHot in State) or (cdsSelected in State)) and
        {$IFDEF RES_MACOS} (Style = MacOS) {$ELSE} false {$ENDIF}
    ) then
    begin
        DefaultDraw := false;

        Buf := TBitmap.Create();
        Bmp := TBitmap.Create();
        Buf.Width := Button.Width;
        Buf.Height := Button.Height;

        R := Rect(0, 0, Buf.Width, Buf.Height);
        Bmp.LoadFromResourceName(hInstance, 'MACOS_MENU_SELECT');
        Buf.Canvas.StretchDraw(R, Bmp);

        Buf.Canvas.Brush.Style := bsClear;
        if CanSetFont then
        begin
            Buf.Canvas.Font.Name := (m_Menu as TsuiMainMenu).FontName;
            Buf.Canvas.Font.Size := (m_Menu as TsuiMainMenu).FontSize;
            Buf.Canvas.Font.Charset := (m_Menu as TsuiMainMenu).FontCharset;
        end
        else
        begin
            Buf.Canvas.Font.Name := ACanvas.Font.Name;
            Buf.Canvas.Font.Size := ACanvas.Font.Size;
            Buf.Canvas.Font.Charset := ACanvas.Font.Charset;
        end;

        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
            Buf.Canvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR)
        else
            Buf.Canvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);
            
        R.Bottom := R.Bottom + 2;
        DrawText(Buf.Canvas.Handle, PChar(Button.Caption), -1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
        ACanvas.Draw(ARect.Left, ARect.Top, Buf);

        Bmp.Free();
        Buf.Free();
    end

    else if (
        (cdsHot in State) or
        (cdsSelected in State)
    ) then
    begin // selected or hot top menu
        // draw client background
        if cdsSelected in State then
            ARect.Right := ARect.Right - 2;
        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
        begin
            ACanvas.Brush.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
            bUseFileTheme := true
        end
        else
        begin
            ACanvas.Brush.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
            bUseFileTheme := false            
        end;
        ACanvas.FillRect(ARect);

        // draw border
        if bUseFileTheme then
            ACanvas.Brush.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_BORDER_COLOR)
        else
            ACanvas.Brush.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BORDER_COLOR);
        ACanvas.FrameRect(ARect);

        // draw text
        if cdsSelected in State then
            ARect.Left := ARect.Left + 2;
        ARect.Top := ARect.Top + 2;

        if bUseFileTheme then
            ACanvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR)
        else
            ACanvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);

        DrawText(ACanvas.Handle, PChar(Button.Caption), -1, ARect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end

    // not select and not hot top menu
    else
    begin
        ACanvas.Brush.Style := bsClear;
        ARect.Top := ARect.Top + 2;
        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
        begin
            if AFileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR) = 196608 then
                ACanvas.Font.Color := clWhite
            else
                ACanvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_FONT_COLOR);
        end
        else
            ACanvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_FONT_COLOR);
        if not Button.Enabled then
            ACanvas.Font.Color := clGray;
        DrawText(ACanvas.Handle, PChar(Button.Caption), -1, ARect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end;
end;

procedure TsuiForm.DrawMenuBar(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
var
    ACanvas : TCanvas;
    Buf : TBitmap;
    Style : TsuiUIStyle;
begin
    Style := m_UIStyle;
    if Menu <> nil then
    begin
        if Menu is TsuiMainMenu then
            Style := (Menu as TsuiMainMenu).UIStyle;
    end;

{$IFDEF RES_MACOS}
    if (Style = MacOS) then
    begin
        ACanvas := Sender.Canvas;
        Buf := TBitmap.Create();
        Buf.LoadFromResourceName(hInstance, 'MACOS_MENU_BAR');
        ACanvas.StretchDraw(ARect, Buf);
        Buf.Free();
    end;
{$ENDIF}
end;

function TsuiForm.GetButtons: TsuiTitleBarButtons;
begin
    if m_TitleBar = nil then
        Result := nil
    else
        Result := m_TitleBar.Buttons;
end;

function TsuiForm.GetCaption: TCaption;
begin
    if m_TitleBar = nil then
        Result := ''
    else
        Result := m_TitleBar.Caption;
end;

function TsuiForm.GetDrawAppIcon: Boolean;
begin
    if m_TitleBar = nil then
        Result := false
    else
        Result := m_TitleBar.DrawAppIcon;
end;

function TsuiForm.GetFont: TFont;
begin
    if m_TitleBar = nil then
        Result := nil
    else
        Result := m_TitleBar.Font;
end;

function TsuiForm.GetMDIChild: Boolean;
begin
    Result := (m_Form.FormStyle = fsMDIChild);
end;

function TsuiForm.GetOnBtnClick: TsuiTitleBarButtonClickEvent;
begin
    if m_TitleBar = nil then
        Result := nil
    else
        Result := m_TitleBar.OnCustomBtnsClick;
end;

function TsuiForm.GetOnHelpBtnClick: TsuiTitleBarButtonClickEvent;
begin
    if m_TitleBar = nil then
        Result := nil
    else
        Result := m_TitleBar.OnHelpBtnClick;
end;

function TsuiForm.GetRoundCorner: Integer;
begin
    if m_TitleBar = nil then
        Result := 0
    else if not m_TitleBar.Visible then
        Result := 0
    else
        Result := m_TitleBar.RoundCorner;
end;

function TsuiForm.GetRoundCornerBottom: Integer;
begin
    if m_TitleBar = nil then
        Result := 0
    else if not m_TitleBar.Visible then
        Result := 0
    else
        Result := m_TitleBar.RoundCornerBottom;
end;

function TsuiForm.GetSections: TsuiTitleBarSections;
begin
    if m_TitleBar = nil then
        Result := nil
    else
        Result := m_TitleBar.Sections;
end;

function TsuiForm.GetTitleBarCustom: Boolean;
begin
    if m_TitleBar = nil then
        Result := false
    else
        Result := m_TitleBar.Custom;
end;

function TsuiForm.GetTitleBarHeight: Integer;
begin
    if (m_TitleBar = nil) or (not TitleBarVisible) then
        Result := 0
    else
        Result := m_TitleBar.Height;
end;

function TsuiForm.GetTitleBarVisible: Boolean;
begin
    if m_TitleBar = nil then
        Result := false
    else
        Result := m_TitleBar.Visible;
end;

function TsuiForm.GetVersion: String;
begin
    Result := '5.83';
end;

var
    l_InFlag : Integer = 0;
    l_MaxFlag : Boolean = false;

procedure TsuiForm.NewParentWndProc(var Msg: TMessage);
var
    Rect : TRect;
    pcsp: PNCCalcSizeParams;
    P : PWindowPos;
begin
    if m_Destroyed then
        Exit;

    if Msg.Msg = WM_NCCALCSIZE then
    begin
        if Boolean(Msg.wParam) then
        begin
            pcsp := PNCCalcSizeParams(Msg.lParam);
            P := pcsp^.lppos;
            with pcsp^.rgrc[0] do
            begin
                Top := P^.y;
                if m_BorderBuf <> nil then
                begin
                    Right := P^.x + P^.cx - m_BorderBuf.Width + 2;
                    Left := P^.x + m_BorderBuf.Width - 2;
                end
                else
                begin
                    Right := P^.x + P^.cx;
                    Left := P^.x;
                end;
                if m_BottomBorderWidth <> 0 then
                    Bottom := P^.y + P^.cy - m_BottomBorderWidth + 2
                else if m_Width = 3 then
                    Bottom := P^.y + P^.cy
                else
                    Bottom := P^.y + P^.cy - m_Width + 2;
            end;
            pcsp^.rgrc[1] := pcsp^.rgrc[0];
            Msg.lParam := LongInt(pcsp);
            Msg.Result := WVR_VALIDRECTS;
        end
        else
            Msg.Result := 0;
    end;

    if Msg.Msg = SUIM_GETBORDERWIDTH then
    begin
        if m_BorderBuf <> nil then
            Msg.Result := m_BorderBuf.Width
        else
            Msg.Result := 0;
        Exit;
    end;

    if Msg.Msg <> WM_NCPAINT then
        m_OldWndProc(Msg);

    if Msg.Msg = WM_MDIACTIVATE then
    begin
        if TWMMDIActivate(Msg).ActiveWnd = m_Form.Handle then
        begin
            SendMessage(Application.MainForm.ClientHandle, WM_MDIREFRESHMENU, m_Form.Handle, 0);
            m_TitleBar.FormActive := true;
        end
        else
            m_TitleBar.FormActive := false
    end;

    if Msg.Msg = WM_KEYDOWN then
        ProcessKeyPress(Msg);

    if Msg.Msg = WM_SHOWWINDOW then
    begin
        m_Form.Menu := nil;
    end;

    if Msg.Msg = WM_DESTROY then
    begin
        if m_Form.FormStyle = fsMDIChild then
        begin
            if Application = nil then
                Exit;
            if Application.MainForm.MDIChildCount = 1 then
                SendMessage(Application.MainForm.ClientHandle, WM_MDIREFRESHMENU, m_Form.Handle, 0);
            if m_Form.WindowState = wsMaximized then
                SendMessage(Application.MainForm.ClientHandle, WM_MDIRESTORE, m_Form.Handle, 0);
        end;
    end;

    if Msg.Msg = WM_ACTIVATE then
    begin
        if Msg.WParamLo = WA_INACTIVE then
            m_TitleBar.FormActive := false
        else
            m_TitleBar.FormActive := true;
    end;

    if Msg.Msg = WM_NCPAINT then
    begin
        if m_Form.WindowState = wsMinimized then
            m_OldWndProc(Msg)
        else
            PaintFormBorder();
    end;

    if (Msg.Msg = CM_RECREATEWND) or (Msg.Msg = CN_PARENTNOTIFY) or (Msg.Msg = CM_FLOAT) then
    begin
        if WS_CAPTION and GetWindowLong(m_Form.Handle, GWL_STYLE) <> 0 then
        begin
            SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));
            SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
        end;
    end;

    if Msg.Msg = WM_SIZE then
    begin
        if (m_Form.WindowState = wsMaximized) and (csDesigning in ComponentState) then
            Exit;
        if m_FormInitMax then
        begin
            if m_Form.WindowState <> wsMaximized then
            begin
                PlaceControl(m_Form, m_FormInitRect);
                m_FormInitMax := false;
            end
            else if l_InFlag = 2 then
            begin
                m_Form.WindowState := wsMaximized;
            end
            else
                Inc(l_InFlag);
            l_MaxFlag := true;
        end;
        if (m_Form.WindowState = wsMaximized) and (m_Form.FormStyle <> fsMDIChild) then
        begin
            Rect := GetWorkAreaRect();
            Dec(Rect.Bottom);
            Dec(Rect.Top, 2);
            Dec(Rect.Left, 2);
            Inc(Rect.Right, 2);
            PlaceControl(m_Form, Rect);
        end;

        PaintFormBorder();
        m_TitleBar.ProcessMaxBtn();
        if m_Form.FormStyle = fsMDIChild then
        begin
            if m_Form.WindowState = wsMaximized then
            begin
                m_SelfChanging := true;
                TitleBarVisible := false;
                m_SelfChanging := false;

                if not l_MaxFlag then
                begin
                    Self.ScrollBy(0, m_TitleBar.Height * -1 + 3);
                    l_MaxFlag := true;
                    SendMessage(Application.MainForm.ClientHandle, WM_MDIMAXIMIZE, m_Form.Handle, 0);
                end;
            end
            else
            begin
                if m_MDIChildFormTitleVisible then
                begin
                    m_SelfChanging := true;
                    TitleBarVisible := true;
                    m_SelfChanging := false;
                end;
 
                if l_MaxFlag then
                begin
                    Self.ScrollBy(0, m_TitleBar.Height - 3);
                    l_MaxFlag := false;
                    m_TitleBar.ProcessMaxBtn();
                    SendMessage(Application.MainForm.ClientHandle, WM_MDIRESTORE, 0, 0);
                end;
            end;
        end;
        RegionWindow();
    end;

    if (Msg.Msg = WM_NCHITTEST) and (m_Form.FormStyle = fsMDIChild) and (m_OldBorderStyle = bsSingle) then
    begin
        if (
            (Msg.Result = HTBOTTOM) or
            (Msg.Result = HTBOTTOMLEFT) or
            (Msg.Result = HTBOTTOMRIGHT) or
            (Msg.Result = HTLEFT) or
            (Msg.Result = HTRIGHT) or
            (Msg.Result = HTTOP) or
            (Msg.Result = HTTOPLEFT) or
            (Msg.Result = HTTOPRIGHT)
        ) then
            Msg.Result := HTBORDER;
    end;
end;

procedure TsuiForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if AComponent = nil then
        Exit;

    if (
        (Operation = opInsert) and
        (csDesigning in ComponentState) and
        (not (csLoading in ComponentState)) and
        (AComponent.ClassName <> 'TsuiMainMenu') and
        (AComponent is TMainMenu) and
        (not g_SUIPackConverting)        
    ) then
    begin
        MessageDlg(
            'Strongly recommend you to use "TsuiMainMenu" instead of "TMainMenu".'
                + SUI_2ENTER +  'If you still want to use TMainForm, '
                + SUI_2ENTER + 'set ' + m_Form.Name + '''s MENU property to NIL please.'
                + SUI_2ENTER + 'And set ' + Name + '''s MENU property to this Menu when you finished designing the menu.',
            mtInformation,
            [mbOK],
            0
        );
    end;

    if (
        (Operation = opInsert) and
        (csDesigning in ComponentState) and
        (not (csLoading in ComponentState)) and
        (AComponent is TsuiMainMenu) and
        (not g_SUIPackConverting) and
        (Menu = nil) and
        (AComponent.Owner = m_Form)
    ) then
    begin
        Menu := TsuiMainMenu(AComponent);
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_Panel)
    )then
        m_Panel := nil;

    if (
        (Operation = opRemove) and
        (AComponent = m_Menu)
    ) then
        DestroyMenuBar();

    if (
        (Operation = opRemove) and
        (AComponent = self)
    )then
    begin
        if m_Menu <> nil then
        begin
            if m_Menu is TsuiMainMenu then
                (m_Menu as TsuiMainMenu).Form := nil;
        end;

        m_Destroyed := true;
        if m_Form.HandleAllocated then
        begin
            SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) or WS_CAPTION);
            m_Form.WindowProc := m_OldWndProc;
            SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
        end;
    end;

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

{$IFDEF SUIPACK_D5}
procedure TsuiForm.OnApplicationHint(Sender: TObject);
begin
    //
end;
{$ENDIF}

procedure TsuiForm.OnApplicationMessage(var Msg: TMsg;
  var Handled: Boolean);
var
    AMsg : TMessage;
begin
    if Msg.message = 262 then
        if LOWORD(Msg.wParam) = 32 then
        begin
            m_TitleBar.DefPopupMenu.Popup(Application.MainForm.Left, Application.MainForm.Top + m_TitleBar.Height);
            Handled := true;
        end;

    if Msg.message = WM_KEYDOWN then
    begin
        AMsg.Msg := Msg.message;
        AMsg.WParam := Msg.wParam;
        AMsg.LParam := Msg.lParam;
        ProcessKeyPress(AMsg);
        Handled := Boolean(AMsg.Result);
    end;
end;

procedure TsuiForm.Paint;
var
    Buf : TBitmap;
    Bmp : TBitmap;
begin
    if m_Destroyed then
        Exit;
    if {$IFDEF RES_MACOS} (m_UIStyle = MacOS) {$ELSE} false {$ENDIF} or
        {$IFDEF RES_PROTEIN} (m_UIStyle = Protein) {$ELSE} false {$ENDIF} then
    begin
        Buf := TBitmap.Create();
        Bmp := TBitmap.Create();
        try
            Buf.Width := Width;
            Buf.Height := Height;
{$IFDEF RES_MACOS}
            if m_UIStyle = MacOS then
                Bmp.LoadFromResourceName(hInstance, 'MACOS_FORM_BACKGROUND')
            else
{$ENDIF}            
                Bmp.LoadFromResourceName(hInstance, 'PROTEIN_FORM_BACKGROUND');
            Buf.Canvas.Brush.Bitmap := Bmp;
            Buf.Canvas.FillRect(ClientRect);
            BitBlt(Canvas.Handle, 0, 0, Width, Height, Buf.Canvas.Handle, 0, 0, SRCCOPY);
        finally
            Bmp.Free();
            Buf.Free();
        end;
    end
    else
    begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(ClientRect);
    end;

    PaintFormBorder();
end;

procedure TsuiForm.PaintFormBorder();
var
    R : TRect;
    ACanvas : TCanvas;
    Bmp : TBitmap;
    nLeft, nRight : Integer;
    Tmp : TBitmap;
    BH : Integer;
    W, H : Integer;   
begin
    if m_Destroyed then
        Exit;

    if (m_Form = nil) or (not m_Form.HandleAllocated) then
    begin
        inherited;
        Exit;
    end;
    if (m_Form.WindowState = wsMinimized) and (not (csDesigning in ComponentState)) then
        Exit;

    ACanvas := TCanvas.Create();
    ACanvas.Handle := GetWindowDC(m_Form.Handle);

    if m_BorderBuf = nil then
    begin
        ACanvas.Brush.Color := m_Color;
        R := Rect(0, 0, m_Width, m_Form.Height);
        ACanvas.FillRect(R);
        R := Rect(0, m_Form.Height - m_Width, m_Form.Width, m_Form.Height);
        ACanvas.FillRect(R);
        R := Rect(m_Form.Width - m_Width, m_Form.Height, m_Form.Width, 0);
        ACanvas.FillRect(R);

        if m_Width < 4 then
        begin
            ACanvas.Brush.Color := Color;
            R := Rect(m_Width, TitleBarHeight, 3, m_Form.Height - m_Width);
            ACanvas.FillRect(R);
            R := Rect(m_Width, m_Form.Height - 3, m_Form.Width - m_Width, m_Form.Height - m_Width);
            ACanvas.FillRect(R);
            R := Rect(m_Form.Width - 3, m_Form.Height - m_Width, m_Form.Width - m_Width, TitleBarHeight);
            ACanvas.FillRect(R);

            if (m_MenuBar <> nil) and (m_MenuBar.Visible) then
            begin
                ACanvas.Brush.Color := m_MenuBar.Color;
                R := Rect(m_Width, 3 + m_TitleBar.Height, 3, 3 + m_TitleBar.Height + m_MenuBar.Height);
                ACanvas.FillRect(R);
                R := Rect(m_Form.Width - 3, 3 + m_TitleBar.Height, m_Form.Width - m_Width, 3 + m_TitleBar.Height + m_MenuBar.Height);
                ACanvas.FillRect(R);
            end;
        end;
        
        if TitleBarVisible and m_TitleBar.CanPaint() and (m_Width < 4) then
        begin
            Tmp := TBitmap.Create();

            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Width := 3 - m_Width;
            Tmp.Height := Bmp.Height;
            Tmp.Canvas.Draw(0, 0, Bmp);
            ACanvas.Draw(m_Width, 0, Tmp);

            m_TitleBar.GetRightImage(Bmp);
            if Bmp.Width < 3 then
                Tmp.Canvas.StretchDraw(Rect(0, 0, Tmp.Width, Tmp.Height), Bmp)
            else
                Tmp.Canvas.Draw(2 - Bmp.Width, 0, Bmp);
            ACanvas.Draw(m_Form.Width - 3, 0, Tmp);

            Tmp.Width := m_Form.Width - 5;
            Tmp.Height := 3;
            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Canvas.Draw(-2, 0, Bmp);
            nLeft := Bmp.Width - 2;
            m_TitleBar.GetRightImage(Bmp);
            nRight := Tmp.Width - Bmp.Width + 3;
            Tmp.Canvas.Draw(nRight, 0, Bmp);
            m_TitleBar.GetCenterImage(Bmp);
            Tmp.Canvas.StretchDraw(Rect(nLeft, 0, nRight, Bmp.Height), Bmp);
            ACanvas.Draw(2, 0, Tmp);

            if (m_Width = 1) and (RoundCorner = 11) and not (csDesigning in ComponentState) then
            begin
                ACanvas.Pen.Color := m_Color;
                ACanvas.Arc(m_Form.Width - RoundCorner * 2 + 1, -1, m_Form.Width + 1, RoundCorner * 2 - 1, m_Form.Width + 1, RoundCorner - 1, m_Form.Width - RoundCorner + 1, -1);
                ACanvas.Arc(-1, -1, RoundCorner * 2 - 1, RoundCorner * 2 - 1, RoundCorner - 1, -1, - 1, RoundCorner - 1);
            end;

            Tmp.Free();
        end
        else if not TitleBarVisible then
        begin
            ACanvas.Brush.Color := m_Color;
            R := Rect(0, 0, m_Form.Width, 1);
            ACanvas.FillRect(R);
            ACanvas.Brush.Color := Color;
            R := Rect(m_Width, 1, m_Form.Width - m_Width, 3);
            ACanvas.FillRect(R);
        end;
    end
    else
    begin
        W := m_BorderBuf.Width;
        if m_TitleBar.Visible then
            H := m_TitleBar.Height
        else
            H := 0;
        
        // bottom border
        Tmp := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_BOTTOMBORDER_IMAGE, Tmp);
        if not Tmp.Empty then
        begin
            R := Rect(0, m_Form.Height - Tmp.Height, m_Form.Width, m_Form.Height);
            SpitDrawHorizontal(Tmp, ACanvas, R, false);
            BH := Tmp.Height;
        end
        else
            BH := 0;
        Tmp.Free();

        // left border
        Tmp := TBitmap.Create();
        R := Rect(0, H, W, m_Form.Height - BH);
        m_FileTheme.GetBitmap(SUI_THEME_FORM_LEFTBORDER_IMAGE, Tmp);
        ACanvas.StretchDraw(R, Tmp);
        Tmp.Free();

        // right border
        R := Rect(m_Form.Width - W, H, m_Form.Width, m_Form.Height - BH);
        ACanvas.StretchDraw(R, m_BorderBuf);

        // non-border
        ACanvas.Brush.Color := Color;
        R := Rect(W, H, W + 1, m_Form.Height - BH);
        ACanvas.FillRect(R);
        R := Rect(W + 1, m_Form.Height - BH - 1, m_Form.Width - W - 1, m_Form.Height - BH);
        ACanvas.FillRect(R);
        R := Rect(m_Form.Width - W - 1, H, m_Form.Width - W, m_Form.Height - BH);
        ACanvas.FillRect(R);

        if (m_MenuBar <> nil) and (m_MenuBar.Visible) then
        begin
            ACanvas.Brush.Color := m_MenuBar.Color;
            R := Rect(W, H, W + 1, H + m_MenuBar.Height + 3);
            ACanvas.FillRect(R);
            R := Rect(m_Form.Width - W - 1, 3 + H, m_Form.Width - W, 3 + H + m_MenuBar.Height);
            ACanvas.FillRect(R);
        end;

        // title
        if TitleBarVisible and m_TitleBar.CanPaint() then
        begin
            Tmp := TBitmap.Create();

            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Width := W + 2;
            Tmp.Height := Bmp.Height;
            Tmp.Canvas.Draw(0, 0, Bmp);
            ACanvas.Draw(0, 0, Tmp);

            m_TitleBar.GetRightImage(Bmp);
            Tmp.Width := W + 2;
            if Bmp.Width < Tmp.Width then
                Tmp.Canvas.StretchDraw(Rect(0, 0, Tmp.Width, Tmp.Height), Bmp)
            else
                Tmp.Canvas.Draw(Tmp.Width - Bmp.Width, 0, Bmp);
            ACanvas.Draw(m_Form.Width - Tmp.Width, 0, Tmp);

            Tmp.Width := m_Form.Width - W * 2;
            Tmp.Height := 3;
            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Canvas.Draw(-W + 1, 0, Bmp);
            nLeft := Bmp.Width - W;
            m_TitleBar.GetRightImage(Bmp);
            nRight := Tmp.Width - Bmp.Width + W;
            Tmp.Canvas.Draw(nRight, 0, Bmp);
            m_TitleBar.GetCenterImage(Bmp);
            Tmp.Canvas.StretchDraw(Rect(nLeft, 0, nRight, Bmp.Height), Bmp);
            ACanvas.Draw(W, 0, Tmp);

            Tmp.Free();
        end
        else
        begin
            R := Rect(W, 0, m_Form.Width - W, 3);
            if m_MenuBar <> nil then
                ACanvas.Brush.Color := m_MenuBar.Color
            else
                ACanvas.Brush.Color := m_Form.Color;
            ACanvas.FillRect(R);
        end;
    end;

    ReleaseDC(m_Form.Handle, ACanvas.Handle);
    ACanvas.Free();
end;

procedure TsuiForm.ProcessKeyPress(var Msg: TMessage);
begin
    if m_Destroyed then
        Exit;
    if (not FormHasFocus(m_Form)) or (not m_Form.Active) then
        Msg.Result := 0
    else if not Assigned(Menu) then
        Msg.Result := 0
    else if m_Menu.IsShortCut(TWMKEY(Msg)) then
        Msg.Result := 1
    else
        Msg.Result := 0;
end;

procedure TsuiForm.ReAssign;
begin
    if WS_CAPTION and GetWindowLong(m_Form.Handle, GWL_STYLE) <> 0 then
    begin
        SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));
        SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
    end;
end;

procedure TsuiForm.RegionWindow;
var
    R1, R2 : TRect;
    Rgn, Rgn1 : HRGN;
    C, C2 : Integer;
    TempRgn : HRGN;
    W, H : Integer;
begin
    if csDesigning in ComponentState then
        Exit;

    H := m_Form.Height;
    W := m_Form.Width;

    R1 := Rect(0, 0, W, H div 2);
    R2 := Rect(0, H div 2, W, H);
    C := RoundCorner;
    C2 := RoundCornerBottom;
    if C2 = -1 then
        C2 := 0;

    Rgn := CreateRoundRectRgn(R1.Left, R1.Top, R1.Right + 1, R1.Bottom + 1, C, C);

    TempRgn := CreateRectRgn(
        R1.Left,
        R1.Bottom,
        R1.Left + C * 2,
        R1.Bottom - C * 2
    );
    CombineRgn(Rgn, Rgn, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    TempRgn := CreateRectRgn(
        R1.Right,
        R1.Bottom,
        R1.Right - C * 2,
        R1.Bottom - C * 2
    );
    CombineRgn(Rgn, Rgn, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    Rgn1 := CreateRoundRectRgn(R2.Left, R2.Top, R2.Right + 1, R2.Bottom + 1, C2, C2);

    TempRgn := CreateRectRgn(
        R2.Left,
        R2.Top,
        R2.Left + C2 * 2,
        R2.Top + C2 * 2
    );
    CombineRgn(Rgn1, Rgn1, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    TempRgn := CreateRectRgn(
        R2.Right,
        R2.Top,
        R2.Right - C2 * 2,
        R2.Top + C2 * 2
    );
    CombineRgn(Rgn1, Rgn1, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    CombineRgn(Rgn, Rgn, Rgn1, RGN_OR);
    DeleteObject(Rgn1);
    
    if not (csDesigning in m_Form.ComponentState) then
        SetWindowRgn(m_Form.Handle, Rgn, true);

    DeleteObject(Rgn);
end;

procedure TsuiForm.RepaintMenuBar;
begin
    if (m_MenuBar = nil) or (m_Menu = nil) then
        Exit;
    if m_Menu is TsuiMainMenu then
        if (m_Menu as TsuiMainMenu).UseSystemFont then
            Menu_GetSystemFont(m_MenuBar.Font)
        else
        begin
            m_MenuBar.Font.Name := (m_Menu as TsuiMainMenu).FontName;
            m_MenuBar.Font.Size := (m_Menu as TsuiMainMenu).FontSize;
            m_MenuBar.Font.Charset := (m_Menu as TsuiMainMenu).FontCharset;
        end;
    m_MenuBar.Repaint();
end;

procedure TsuiForm.Resize;
begin
    inherited;

    m_TitleBar.Align := alTop;

{$IFDEF SUIPACK_D9UP}
    if WS_CAPTION and GetWindowLong(m_Form.Handle, GWL_STYLE) <> 0 then
    begin
        SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));
        SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
    end;
{$ENDIF}
end;

procedure TsuiForm.SetBorderWidth(const Value: Integer);
begin
    m_Width := Value;

    PaintFormBorder();
end;

procedure TsuiForm.SetButtons(const Value: TsuiTitleBarButtons);
begin
    m_TitleBar.Buttons.Assign(Value);
end;

procedure TsuiForm.SetCaption(const Value: TCaption);
begin
    m_TitleBar.Caption := Value;
    m_Form.Caption := Value;
end;

procedure TsuiForm.SetColor(const Value: TColor);
begin
    m_Color := Value;

    PaintFormBorder();
end;

procedure TsuiForm.SetDrawAppIcon(const Value: Boolean);
begin
    m_TitleBar.DrawAppIcon := Value;
end;

procedure TsuiForm.SetFileTheme(const Value: TsuiFileTheme);
begin
    if m_FileTheme = Value then
        Exit;
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiForm.SetFont(const Value: TFont);
begin
    m_TitleBar.Font := Value;
end;

procedure TsuiForm.SetMenu(const Value: TMainMenu);
begin
    if m_Menu <> nil then
    begin
        if m_Menu is TsuiMainMenu then
            (m_Menu as TsuiMainMenu).Form := nil;
    end;

    m_Menu := Value;

    if m_Menu is TsuiMainMenu then
        (m_Menu as TsuiMainMenu).Form := self;

    if m_Menu <> nil then
    begin
        if m_MenuBar = nil then
            CreateMenuBar();
        UpdateMenu();
    end
    else
        DestroyMenuBar();
end;

procedure TsuiForm.SetMenuBarColor(const Value: TColor);
begin
    m_MenuBarColor := Value;

    if m_MenuBar <> nil then
        m_MenuBar.Color := Value;
end;

procedure TsuiForm.SetMenuBarHeight(const Value: Integer);
var
    i : Integer;
begin
    m_MenuBarHeight := Value;

    if m_MenuBar <> nil then
    begin
        m_MenuBar.Height := m_MenuBarHeight;
        for i := 0 to m_MenuBar.ButtonCount - 1 do
            m_MenuBar.Buttons[i].Height := m_MenuBarHeight;
    end;
end;

procedure TsuiForm.SetOnBtnClick(
  const Value: TsuiTitleBarButtonClickEvent);
begin
    m_TitleBar.OnCustomBtnsClick := Value;
end;

procedure TsuiForm.SetOnHelpBtnClick(
  const Value: TsuiTitleBarButtonClickEvent);
begin
    m_TitleBar.OnHelpBtnClick := Value;
end;

procedure TsuiForm.SetPanel(const Value: TCustomPanel);
begin
    if Value = self then
    begin
        MessageDlg('Sorry, you can''t select the Form assign to FormPanel property', mtError, [mbOK], 0);	 
        Exit;
    end;

    m_Panel := Value;

    if m_Panel = nil then
        Exit;

    m_Panel.Align := alClient;

    if m_Panel is TPanel then
    begin
        TPanel(m_Panel).BevelOuter := bvNone;
        TPanel(m_Panel).BevelInner := bvNone;
        TPanel(m_Panel).BorderStyle := bsNone;
        TPanel(m_Panel).Caption := '';
    end
    else if m_Panel is TsuiImagePanel then
        TsuiImagePanel(m_Panel).Caption := '';
end;

procedure TsuiForm.SetRoundCorner(const Value: Integer);
begin
    m_TitleBar.RoundCorner := Value;
    RegionWindow();
end;

procedure TsuiForm.SetRoundCornerBottom(const Value: Integer);
begin
    m_TitleBar.RoundCornerBottom := Value;
    RegionWindow();
end;

procedure TsuiForm.SetSections(const Value: TsuiTitleBarSections);
begin
    m_TitleBar.Sections.Assign(Value);
end;

procedure TsuiForm.SetTitleBarCustom(const Value: Boolean);
begin
    m_TitleBar.Custom := Value;
end;

procedure TsuiForm.SetTitleBarVisible(const Value: Boolean);
begin
    if m_TitleBar.Visible = Value then
        Exit;
    if not m_SelfChanging then
        m_MDIChildFormTitleVisible := Value;
    m_TitleBar.Visible := Value;
    m_TitleBar.Top := 0;
    PaintFormBorder();
end;

procedure TsuiForm.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
    Rect: TRect;
    Col : TColor;
    B : TBitmap;
begin
    Rect := m_Form.BoundsRect;

    m_UIStyle := Value;

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        BorderColor := m_FileTheme.GetColor(SUI_THEME_FORM_BORDER_COLOR);
        BorderWidth := m_FileTheme.GetInt(SUI_THEME_FORM_BORDERWIDTH_INT);
        Color := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
        if m_MenuBar <> nil then
        begin
            Col := m_FileTheme.GetColor(SUI_THEME_MENU_MENUBAR_COLOR);
            if Col = -1 then
            begin
                Col := m_FileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR);
                if Col = 131072 then
                    MenuBarColor := $00AC5B3B
                else if Col = 196608 then
                    MenuBarColor := $00996733
                else
                    MenuBarColor := Color;
            end
            else
                MenuBarColor := Col;
        end;
        RoundCorner := m_FileTheme.GetInt(SUI_THEME_FORM_ROUNDCORNER_INT);
        RoundCornerBottom := m_FileTheme.GetInt(SUI_THEME_FORM_BOTTOMROUNDCORNOR_INT);

        B := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_LEFTBORDER_IMAGE, B);
        if (B.Width <> 0) and (B.Height <> 0) then
        begin
            if m_BorderBuf <> nil then
                m_BorderBuf.Free();

            m_BorderBuf := TBitmap.Create();
            m_BorderBuf.Width := B.Width;
            m_BorderBuf.Height := B.Height;
            m_BorderBuf.Canvas.Draw(0, 0, B);
            RoundPicture2(m_BorderBuf);
        end
        else if m_BorderBuf <> nil then
        begin
            m_BorderBuf.Free();
            m_BorderBuf := nil;
        end;
        B.Free();
        B := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_BOTTOMBORDER_IMAGE, B);
        m_BottomBorderWidth := B.Height;
        B.Free();
    end
    else
    begin
        if m_BorderBuf <> nil then
        begin
            m_BorderBuf.Free();
            m_BorderBuf := nil;
        end;
        RoundCornerBottom := 0;
        m_BottomBorderWidth := 0;
        BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BORDER_COLOR);
        BorderWidth := GetInsideThemeInt(OutUIStyle, SUI_THEME_FORM_BORDERWIDTH_INT);
        Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
        MenuBarColor := Color;
        RoundCorner := GetInsideThemeInt(OutUIStyle, SUI_THEME_FORM_ROUNDCORNER_INT);
    end;

    m_TitleBar.FileTheme := m_FileTheme;
    m_TitleBar.UIStyle := m_UIStyle;

    if m_Menu <> nil then
    begin
        if m_Menu is TsuiMainMenu then
        begin
            (m_Menu as TsuiMainMenu).UIStyle := m_UIStyle;
            (m_Menu as TsuiMainMenu).FileTheme := m_FileTheme;
        end;
    end;

    if m_UIStyleAutoUpdateSub then
        ContainerApplyUIStyle(self, m_UIStyle, FileTheme);

    if m_Form.FormStyle = fsMDIChild then
        m_Form.BoundsRect := Rect;

    SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);        

    Repaint();
    PaintFormBorder();
end;


procedure TsuiForm.SetVersion(const Value: String);
begin
    // do nothing
end;

procedure TsuiForm.UpdateMenu;
var
    i : Integer;
    Button : TToolButton;
begin
    if m_MenuBar = nil then
        Exit;

    if m_Menu = nil then
    begin
        DestroyMenuBar();
        Exit;
    end;

    m_MenuBar.AutoSize := false;
    if m_Menu is TsuiMainMenu then
    begin
        if not TsuiMainMenu(m_Menu).UseSystemFont then
            m_MenuBar.Font.Size := TsuiMainMenu(m_Menu).FontSize
        else
            Menu_GetSystemFont(m_MenuBar.Font);
    end;

    for i := 0 to m_MenuBar.ButtonCount - 1 do
        m_MenuBar.Buttons[0].Free();

    for i := m_Menu.Items.Count - 1 downto 0 do
    begin
        if m_Menu.Items[i].Parent <> m_Menu.Items then
            continue;
        Button := TToolButton.Create(self);
        Button.Parent := m_MenuBar;
        Button.Grouped := true;
        Button.MenuItem := m_Menu.Items[i];
        Button.AutoSize := true;
    end;

    m_MenuBar.AutoSize := true;
end;

procedure TsuiForm.UpdateTopMenu;
var
    i : Integer;
begin
    if m_MenuBar = nil then
        Exit;
    for i := 0 to m_MenuBar.ButtonCount - 1 do
    begin
        if m_MenuBar.Buttons[i].MenuItem <> nil then
        begin
            m_MenuBar.Buttons[i].Caption := m_MenuBar.Buttons[i].MenuItem.Caption;
            m_MenuBar.Buttons[i].Enabled := m_MenuBar.Buttons[i].MenuItem.Enabled;
        end;
    end;
end;

procedure TsuiForm.WMERASEBKGND(var Msg: TMessage);
begin
    //
end;

{ TsuiMDIForm }

procedure TsuiMDIForm.Cascade;
    procedure GetNextTopLeft(var nTop, nLeft: Integer);
    begin
        Inc(nTop, 22);
        Inc(nLeft, 22);
    end;
var
    i : Integer;
    nLeft, nTop : Integer;
    nWidth, nHeight : Integer;
begin
    nLeft := 0;
    nTop := 0;
    nWidth := Trunc(m_Form.ClientWidth * 0.8);
    nHeight := Trunc(m_Form.ClientHeight * 0.6);
    for i := m_Form.MDIChildCount - 1 downto 0 do
    begin
        if m_Form.MDIChildren[i].WindowState = wsMinimized then
            continue;
        m_Form.MDIChildren[i].SetBounds(nLeft, nTop, nWidth, nHeight);
        GetNextTopLeft(nTop, nLeft);
    end;
end;

constructor TsuiMDIForm.Create(AOwner: TComponent);
var
    P : Pointer;
begin
    inherited;
    if not (AOwner is TForm) then
        Raise Exception.Create('Sorry, TsuiMDIForm must be placed on a form');
    m_Form := AOwner as TForm;
    m_TopMenu := nil;
    m_Destroyed := false;

    m_Form.Constraints.MinHeight := 50;
    m_Form.Constraints.MinWidth := 125;
    m_Form.Menu := nil;

    case m_Form.BorderStyle of
    bsNone, bsSingle, bsToolWindow: m_Form.BorderStyle := bsDialog;
    end;
    m_Form.BorderWidth := 0;

    m_TitleBar := TsuiTitleBar.Create(self);
    m_TitleBar.Parent := m_Form;
    m_TitleBar.Top := 0;
    m_TitleBar.Left := 0;
    m_TitleBar.Caption := m_Form.Caption;
    m_TitleBar.OnResize := OnTopPanelResize;

    m_DrawChildCaptions := true;
    m_DrawChildMenus := true;

    CreateMenuBar();
    UpdateMenu();
    UIStyle := SUI_THEME_DEFAULT;

    m_Form.AutoScroll := false;

    SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));

    m_OldWndProc := m_Form.WindowProc;
    m_Form.WindowProc := NewParentWndProc;

    m_PrevClientWndProc := Pointer(GetWindowLong(TForm(Owner).ClientHandle, GWL_WNDPROC));
{$IFDEF SUIPACK_D5}
    P := Forms.MakeObjectInstance(NewClientWndProc);
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    P := Classes.MakeObjectInstance(NewClientWndProc);
{$ENDIF}

    SetWindowLong(TForm(AOwner).ClientHandle, GWL_WNDPROC, LongInt(P));
    m_AppEvent := TApplicationEvents.Create(nil);
    m_AppEvent.OnMessage := OnApplicationMessage;

    m_WindowMenuList := TList.Create();

    SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);    
end;

procedure TsuiMDIForm.CreateMenuBar;
var
    i : Integer;
    TempBmp : TBitmap;
    nLeft : Integer;
begin
    if (m_MenuBar <> nil) then
        Exit;
    m_TopPanel := TPanel.Create(self);
    m_TopPanel.BevelOuter := bvNone;
    m_TopPanel.BevelInner := bvNone;
    m_TopPanel.Align := alTop;
    m_TopPanel.Parent := m_Form;
    m_TopPanel.AutoSize := true;
    m_TopPanel.Visible := false;

    m_MenuBar := TsuiMenuBar.Create(self);
    m_MenuBar.m_MDIForm := self;
    m_MenuBar.Parent := m_TopPanel;
    m_MenuBar.Flat := true;
    m_MenuBar.EdgeBorders := [];
    m_MenuBar.ShowCaptions := true;
    m_MenuBar.AutoSize := true;
    m_MenuBar.OnCustomDrawButton := DrawButton;
    m_MenuBar.OnCustomDraw := DrawMenuBar;    

    m_TitleBar.Top := 0;
    if (csDesigning in ComponentState) then
        exit;

    TempBmp := TBitmap.Create();
    TempBmp.Transparent := true;
    TempBmp.LoadFromResourceName(hInstance, 'MDI_CONTROL_BUTTON');

    nLeft := m_TopPanel.Width - 20;
    for i := 1 to 3 do
    begin
        m_ControlBtns[i] := TsuiToolBarSpeedButton.Create(self);
        m_ControlBtns[i].Parent := m_TopPanel;
        m_ControlBtns[i].Anchors := [akTop, akRight];
        SpitBitmap(TempBmp, m_ControlBtns[i].Glyph, 3, 4 - i);
        m_ControlBtns[i].Left := nLeft;
        m_ControlBtns[i].Top := 1;
        Dec(nLeft, 18);
        m_ControlBtns[i].Tag := -1380 - i;
        m_ControlBtns[i].OnClick := OnControlButtonClick;
        m_ControlBtns[i].Color := m_MenuBar.Color;
        m_ControlBtns[i].BringToFront();
        m_ControlBtns[i].Visible := false;
    end;

    TempBmp.Free();

end;

destructor TsuiMDIForm.Destroy;
var
    i : Integer;
begin
    for i := 0 to m_WindowMenuList.Count - 1 do
        TMenuItem(m_WindowMenuList[i]).Free();
    m_WindowMenuList.Clear();
    m_WindowMenuList.Free();
    m_Destroyed := true;
    DestroyMenuBar();
    m_TitleBar.Free();
    m_TitleBar := nil;
    m_AppEvent.Free();

    if m_BorderBuf <> nil then
    begin
        m_BorderBuf.Free();
        m_BorderBuf := nil;
    end;
        
    inherited;
end;

procedure TsuiMDIForm.DestroyMenuBar;
var
    i : Integer;
begin
    if (m_MenuBar = nil) then
        Exit;

    if not (csDesigning in ComponentState) then
         for i := 1 to 3 do
            begin
                m_ControlBtns[i].Free();
                m_ControlBtns[i] := nil;
            end;

    m_MenuBar.Free();
    m_MenuBar := nil;
    m_TopPanel.Free();
    m_TopPanel := nil;
    m_Menu := nil;
end;

function TsuiMDIForm.GetActiveChildSUIForm: TsuiForm;
var
    i : Integer;
    Form : TForm;
begin
    Result := nil;
    Form := m_Form.ActiveMDIChild;
    if Form = nil then
        Exit;
    for i := 0 to Form.ControlCount - 1 do
    begin
        if Form.Controls[i] is TsuiForm then
        begin
            Result := Form.Controls[i] as TsuiForm;
            Break;
        end;
    end;
end;

function TsuiMDIForm.GetCaption: TCaption;
begin
    Result := m_Form.Caption;
end;

function TsuiMDIForm.GetMainMenu: TMainMenu;
var
    i : Integer;
    Form : TForm;
begin
    Result := m_Menu;

    if not m_DrawChildMenus then
        Exit;
    if m_TitleBar = nil then
        Exit;
    if m_Form.ActiveMDIChild = nil then
        Exit;

    Form := m_Form.ActiveMDIChild;

    if Form.Menu <> nil then
    begin
        Result := Form.Menu;
        Exit;
    end;

    for i := 0 to Form.ControlCount - 1 do
    begin
        if Form.Controls[i] is TsuiForm then
        begin
            if (Form.Controls[i] as TsuiForm).Menu <> nil then
                Result := (Form.Controls[i] as TsuiForm).Menu;
            break;
        end;
    end;
end;

procedure TsuiMDIForm.HideControlButtons;
var
    i : Integer;
begin
    for i := 1 to 3 do
        m_ControlBtns[i].Visible := false;
end;

procedure TsuiMDIForm.HideMenuBar;
begin
    if (m_MenuBar = nil) then
        Exit;
    m_TopPanel.Visible := false;
end;

procedure TsuiMDIForm.NewClientWndProc(var Msg: TMessage);
begin
    if m_Destroyed then
        Exit;
        
    Msg.Result := CallWindowProc(m_PrevClientWndProc, TForm(Owner).ClientHandle, Msg.Msg, Msg.WParam, Msg.LParam);

    if Msg.Msg = WM_MDIREFRESHMENU then
    begin
        UpdateMenu();
        Caption := m_Form.Caption;
    end;

    if Msg.Msg = WM_MDIMAXIMIZE then
    begin
        ShowControlButtons();
        Caption := m_Form.Caption;
    end;

    if Msg.Msg = WM_MDIRESTORE then
    begin
        HideControlButtons();
        Caption := m_Form.Caption;        
    end;

    if Msg.Msg = WM_MDITILE then
    begin
        Tile();
    end;

    if Msg.Msg = WM_MDICASCADE then
    begin
        Cascade();
    end;
end;

procedure TsuiMDIForm.NewParentWndProc(var Msg: TMessage);
var
    Rect : TRect;
    pcsp: PNCCalcSizeParams;
    P : PWindowPos;
begin
    if m_Destroyed then
        Exit;

    if Msg.Msg = WM_NCCALCSIZE then
    begin
        if Boolean(Msg.wParam) then
        begin
            pcsp := PNCCalcSizeParams(Msg.lParam);
            P := pcsp^.lppos;
            with pcsp^.rgrc[0] do
            begin
                Top := P^.y;
                if m_BorderBuf <> nil then
                begin
                    Right := P^.x + P^.cx - m_BorderBuf.Width + 2;
                    Left := P^.x + m_BorderBuf.Width - 2;
                end
                else
                begin
                    Right := P^.x + P^.cx;
                    Left := P^.x;
                end;
                Bottom := P^.y + P^.cy - m_BottomBorderWidth + 2;
            end;
            pcsp^.rgrc[1] := pcsp^.rgrc[0];
            Msg.lParam := LongInt(pcsp);
            Msg.Result := WVR_VALIDRECTS;
        end
        else
            Msg.Result := 0;
    end;

    if Msg.Msg = SUIM_GETBORDERWIDTH then
    begin
        if m_BorderBuf <> nil then
            Msg.Result := m_BorderBuf.Width
        else
            Msg.Result := 0;
        Exit;
    end;
        
    if Msg.Msg <> WM_NCPAINT then
        m_OldWndProc(Msg);

    if Msg.Msg = WM_KEYDOWN then
        ProcessKeyPress(Msg);

    if Msg.Msg = WM_NCPAINT then
    begin
        PaintBorder();
    end;

    if Msg.Msg = CM_RECREATEWND then
    begin
        if WS_CAPTION and GetWindowLong(m_Form.Handle, GWL_STYLE) <> 0 then
        begin
            SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));
            SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
        end;
    end;

    if Msg.Msg = WM_ACTIVATE then
    begin
        if Msg.WParamLo = WA_INACTIVE then
            m_TitleBar.FormActive := false
        else
            m_TitleBar.FormActive := true;
    end;

    if Msg.Msg = WM_SIZE then
    begin
        if (m_Form.WindowState = wsMaximized) and (csDesigning in ComponentState) then
            Exit;

        if (m_Form.WindowState = wsMaximized) and (m_Form.FormStyle <> fsMDIChild) then
        begin
            Rect := GetWorkAreaRect();
            Dec(Rect.Bottom);
            Dec(Rect.Top, 2);
            Dec(Rect.Left, 2);
            Inc(Rect.Right, 2);
            PlaceControl(m_Form, Rect);
        end;
        PaintBorder();
        RegionWindow();
    end;
end;

procedure TsuiMDIForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if AComponent = nil then
        Exit;

    if (
        (Operation = opRemove) and
        (AComponent = m_Menu)
    ) then
    begin
        m_Menu := nil;
        UpdateMenu();
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_MenuBar)
    ) then
    begin
        m_MenuBar := nil;
    end;

    if Operation = opInsert then
    begin
        if m_MenuBar <> nil then
            m_MenuBar.Top := 0;
        if m_TitleBar <> nil then
            m_TitleBar.Top := 0;
    end;

    if (
        (Operation = opRemove) and
        (AComponent = m_TitleBar)
    ) then
    begin
        m_TitleBar := nil;
    end;

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
        (AComponent = self)
    )then
    begin
        if m_Menu <> nil then
        begin
            if m_Menu is TsuiMainMenu then
                (m_Menu as TsuiMainMenu).Form := nil;
        end;

        m_Destroyed := true;
        if m_Form.HandleAllocated then
        begin
            SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) or WS_CAPTION);
            m_Form.WindowProc := m_OldWndProc;
            SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
        end;
    end;
end;

procedure TsuiMDIForm.OnApplicationMessage(var Msg: TMsg;
  var Handled: Boolean);
var
    AMsg : TMessage;
begin
    if Msg.message = WM_KEYDOWN then
    begin
        AMsg.Msg := Msg.message;
        AMsg.WParam := Msg.wParam;
        AMsg.LParam := Msg.lParam;
        ProcessKeyPress(AMsg);
        Handled := Boolean(AMsg.Result);
    end;
end;

procedure TsuiMDIForm.OnControlButtonClick(Sender: TObject);
begin
    if not (Sender is TsuiToolBarSpeedButton) then
        Exit;
    case (Sender as TsuiToolBarSpeedButton).Tag of

    -1383 : // min
    begin
        ShowWindow(m_Form.ActiveMDIChild.Handle, SW_SHOWMINIMIZED);
        Application.ProcessMessages();
    end;

    -1382 : // restore
    begin
        m_Form.ActiveMDIChild.WindowState := wsNormal;
        Application.ProcessMessages();        
    end;

    -1381 : // close
    begin
        m_Form.ActiveMDIChild.Close();
        Application.ProcessMessages();
    end;

    end;
end;

procedure TsuiMDIForm.PaintBorder;
var
    R : TRect;
    ACanvas : TCanvas;
    Bmp : TBitmap;
    nLeft, nRight : Integer;
    Tmp : TBitmap;
    BH : Integer;
    W, H : Integer;
begin
    if m_Destroyed then
        Exit;

    if (m_Form = nil) or (not m_Form.HandleAllocated) then
    begin
        inherited;
        Exit;
    end;
    if m_Form.BorderWidth <> 0 then
        m_Form.BorderWidth := 0;
    if (m_Form.WindowState = wsMinimized) and (not (csDesigning in ComponentState)) then
        Exit;

    ACanvas := TCanvas.Create();
    ACanvas.Handle := GetWindowDC(m_Form.Handle);

    if m_BorderBuf = nil then
    begin
        ACanvas.Brush.Color := m_BorderColor;
        R := Rect(0, 0, m_BorderWidth, m_Form.Height);
        ACanvas.FillRect(R);
        R := Rect(0, m_Form.Height - m_BorderWidth, m_Form.Width, m_Form.Height);
        ACanvas.FillRect(R);
        R := Rect(m_Form.Width - m_BorderWidth, m_Form.Height, m_Form.Width, 0);
        ACanvas.FillRect(R);

        if m_BorderWidth < 4 then
        begin
            ACanvas.Brush.Color := MenuBarColor;
            R := Rect(m_BorderWidth, GetTitleBarHeight, 3, m_Form.Height - m_BorderWidth);
            ACanvas.FillRect(R);
            R := Rect(m_BorderWidth, m_Form.Height - 3, m_Form.Width - m_BorderWidth, m_Form.Height - m_BorderWidth);
            ACanvas.FillRect(R);
            R := Rect(m_Form.Width - 3, m_Form.Height - m_BorderWidth, m_Form.Width - m_BorderWidth, GetTitleBarHeight);
            ACanvas.FillRect(R);

            if (m_MenuBar <> nil) and (m_MenuBar.Visible) then
            begin
                ACanvas.Brush.Color := m_MenuBar.Color;
                R := Rect(m_BorderWidth, 3 + m_TitleBar.Height, 3, 3 + m_TitleBar.Height + m_MenuBar.Height);
                ACanvas.FillRect(R);
                R := Rect(m_Form.Width - 3, 3 + m_TitleBar.Height, m_Form.Width - m_BorderWidth, 3 + m_TitleBar.Height + m_MenuBar.Height);
                ACanvas.FillRect(R);
            end;
        end;

        if TitleBarVisible and m_TitleBar.CanPaint() and (m_BorderWidth < 4) then
        begin
            Tmp := TBitmap.Create();

            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Width := 3 - m_BorderWidth;
            Tmp.Height := Bmp.Height;
            Tmp.Canvas.Draw(0, 0, Bmp);
            ACanvas.Draw(m_BorderWidth, 0, Tmp);

            m_TitleBar.GetRightImage(Bmp);
            if Bmp.Width < 3 then
                Tmp.Canvas.StretchDraw(Rect(0, 0, Tmp.Width, Tmp.Height), Bmp)
            else
                Tmp.Canvas.Draw(2 - Bmp.Width, 0, Bmp);
            ACanvas.Draw(m_Form.Width - 3, 0, Tmp);

            Tmp.Width := m_Form.Width - 5;
            Tmp.Height := 3;
            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Canvas.Draw(-2, 0, Bmp);
            nLeft := Bmp.Width - 2;
            m_TitleBar.GetRightImage(Bmp);
            nRight := Tmp.Width - Bmp.Width + 3;
            Tmp.Canvas.Draw(nRight, 0, Bmp);
            m_TitleBar.GetCenterImage(Bmp);
            Tmp.Canvas.StretchDraw(Rect(nLeft, 0, nRight, Bmp.Height), Bmp);
            ACanvas.Draw(2, 0, Tmp);

            if (m_BorderWidth = 1) and (RoundCorner = 11) and not (csDesigning in ComponentState) then
            begin
                ACanvas.Pen.Color := m_BorderColor;
                ACanvas.Arc(m_Form.Width - RoundCorner * 2 + 1, -1, m_Form.Width + 1, RoundCorner * 2 - 1, m_Form.Width + 1, RoundCorner - 1, m_Form.Width - RoundCorner + 1, -1);
                ACanvas.Arc(-1, -1, RoundCorner * 2 - 1, RoundCorner * 2 - 1, RoundCorner - 1, -1, - 1, RoundCorner - 1);
            end;

            Tmp.Free();
        end
        else if not TitleBarVisible then
        begin
            ACanvas.Brush.Color := m_BorderColor;
            R := Rect(0, 0, m_Form.Width, 1);
            ACanvas.FillRect(R);
            ACanvas.Brush.Color := MenuBarColor;
            R := Rect(m_BorderWidth, 1, m_Form.Width - m_BorderWidth, 3);
            ACanvas.FillRect(R);
        end;
    end
    else
    begin
        W := m_BorderBuf.Width;
        if m_TitleBar.Visible then
            H := m_TitleBar.Height
        else
            H := 0;
        
        // bottom border
        Tmp := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_BOTTOMBORDER_IMAGE, Tmp);
        if not Tmp.Empty then
        begin
            R := Rect(0, m_Form.Height - Tmp.Height, m_Form.Width, m_Form.Height);
            SpitDrawHorizontal(Tmp, ACanvas, R, false);
            BH := Tmp.Height;
        end
        else
            BH := 0;
        Tmp.Free();

        // left border
        Tmp := TBitmap.Create();
        R := Rect(0, H, W, m_Form.Height - BH);
        m_FileTheme.GetBitmap(SUI_THEME_FORM_LEFTBORDER_IMAGE, Tmp);
        ACanvas.StretchDraw(R, Tmp);
        Tmp.Free();

        // right border
        R := Rect(m_Form.Width - W, H, m_Form.Width, m_Form.Height - BH);
        ACanvas.StretchDraw(R, m_BorderBuf);

        // non-border
        if m_MenuBar <> nil then
            ACanvas.Brush.Color := m_MenuBar.Color
        else
            ACanvas.Brush.Color := m_Form.Color;
        R := Rect(W, H, W + 1, m_Form.Height - BH);
        ACanvas.FillRect(R);
        R := Rect(W + 1, m_Form.Height - BH - 1, m_Form.Width - W - 1, m_Form.Height - BH);
        ACanvas.FillRect(R);
        R := Rect(m_Form.Width - W - 1, H, m_Form.Width - W, m_Form.Height - BH);
        ACanvas.FillRect(R);

        if (m_MenuBar <> nil) and (m_MenuBar.Visible) then
        begin
            ACanvas.Brush.Color := m_MenuBar.Color;
            R := Rect(W, H, W + 1, H + m_MenuBar.Height + 3);
            ACanvas.FillRect(R);
            R := Rect(m_Form.Width - W - 1, 3 + H, m_Form.Width - W, 3 + H + m_MenuBar.Height);
            ACanvas.FillRect(R);
        end;

        // title
        if TitleBarVisible and m_TitleBar.CanPaint() then
        begin
            Tmp := TBitmap.Create();

            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Width := W + 2;
            Tmp.Height := Bmp.Height;
            Tmp.Canvas.Draw(0, 0, Bmp);
            ACanvas.Draw(0, 0, Tmp);

            m_TitleBar.GetRightImage(Bmp);
            Tmp.Width := W + 2;
            if Bmp.Width < Tmp.Width then
                Tmp.Canvas.StretchDraw(Rect(0, 0, Tmp.Width, Tmp.Height), Bmp)
            else
                Tmp.Canvas.Draw(Tmp.Width - Bmp.Width, 0, Bmp);
            ACanvas.Draw(m_Form.Width - Tmp.Width, 0, Tmp);

            Tmp.Width := m_Form.Width - W * 2;
            Tmp.Height := 3;
            m_TitleBar.GetLeftImage(Bmp);
            Tmp.Canvas.Draw(-W + 1, 0, Bmp);
            nLeft := Bmp.Width - W;
            m_TitleBar.GetRightImage(Bmp);
            nRight := Tmp.Width - Bmp.Width + W;
            Tmp.Canvas.Draw(nRight, 0, Bmp);
            m_TitleBar.GetCenterImage(Bmp);
            Tmp.Canvas.StretchDraw(Rect(nLeft, 0, nRight, Bmp.Height), Bmp);
            ACanvas.Draw(W, 0, Tmp);

            Tmp.Free();
        end
        else
        begin
            R := Rect(W, 0, m_Form.Width - W, 3);
            if m_MenuBar <> nil then
                ACanvas.Brush.Color := m_MenuBar.Color
            else
                ACanvas.Brush.Color := m_Form.Color;
            ACanvas.FillRect(R);
        end;
    end;
    
    ReleaseDC(m_Form.Handle, ACanvas.Handle);
    ACanvas.Free();
end;

procedure TsuiMDIForm.ProcessKeyPress(var Msg: TMessage);
begin
    if m_Destroyed then
        Exit;

    if not Assigned(m_TopMenu) then
        Msg.Result := 0
    else if m_TopMenu.IsShortCut(TWMKEY(Msg)) then
        Msg.Result := 1
    else
        Msg.Result := 0;
end;

procedure TsuiMDIForm.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;
    if csDesigning in ComponentState then
        Exit;
    PaintBorder();
end;

procedure TsuiMDIForm.SetCaption(const Value: TCaption);
begin
    m_Form.Caption := Value;
    m_TitleBar.Caption := Value;
end;

procedure TsuiMDIForm.SetFileTheme(const Value: TsuiFileTheme);
begin
    if m_FileTheme = Value then
        Exit;
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiMDIForm.SetMenu(const Value: TMainMenu);
begin
    if m_Menu <> nil then
    begin
        if m_Menu is TsuiMainMenu then
            (m_Menu as TsuiMainMenu).Form := nil;
    end;
    m_Menu := Value;
    UpdateMenu();
end;

procedure TsuiMDIForm.SetMenuBarColor(const Value: TColor);
begin
    m_MenuBarColor := Value;
    
    if (m_MenuBar = nil) then
        Exit;

    m_MenuBar.Color := Value;
end;

procedure TsuiMDIForm.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
    i : Integer;
    Col : TColor;
    B : TBitmap;    
begin
    m_UIStyle := Value;

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        BorderColor := m_FileTheme.GetColor(SUI_THEME_FORM_BORDER_COLOR);
        MenuBarColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR);
        m_BorderWidth := m_FileTheme.GetInt(SUI_THEME_FORM_BORDERWIDTH_INT);
        Col := m_FileTheme.GetColor(SUI_THEME_MENU_MENUBAR_COLOR);
        if Col = -1 then
        begin
            Col := m_FileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR);
            if Col = 131072 then
                MenuBarColor := $00AC5B3B
            else if Col = 196608 then
                MenuBarColor := $00996733;
        end
        else
            MenuBarColor := Col;
        RoundCorner := m_FileTheme.GetInt(SUI_THEME_FORM_ROUNDCORNER_INT);
        RoundCornerBottom := m_FileTheme.GetInt(SUI_THEME_FORM_BOTTOMROUNDCORNOR_INT);
        B := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_LEFTBORDER_IMAGE, B);
        if (B.Width <> 0) and (B.Height <> 0) then
        begin
            if m_BorderBuf <> nil then
                m_BorderBuf.Free();

            m_BorderBuf := TBitmap.Create();
            m_BorderBuf.Width := B.Width;
            m_BorderBuf.Height := B.Height;
            m_BorderBuf.Canvas.Draw(0, 0, B);
            RoundPicture2(m_BorderBuf);
        end
        else if m_BorderBuf <> nil then
        begin
            m_BorderBuf.Free();
            m_BorderBuf := nil;
        end;
        B.Free();
        B := TBitmap.Create();
        m_FileTheme.GetBitmap(SUI_THEME_FORM_BOTTOMBORDER_IMAGE, B);
        m_BottomBorderWidth := B.Height;
        B.Free();
    end
    else
    begin
        BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BORDER_COLOR);
        MenuBarColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
        m_BorderWidth := GetInsideThemeInt(OutUIStyle, SUI_THEME_FORM_BORDERWIDTH_INT);
        RoundCorner := GetInsideThemeInt(OutUIStyle, SUI_THEME_FORM_ROUNDCORNER_INT);
        RoundCornerBottom := 0;
        m_BottomBorderWidth := 0;
        if m_BorderBuf <> nil then
        begin
            m_BorderBuf.Free();
            m_BorderBuf := nil;
        end;
    end;

    if m_Menu <> nil then
    begin
        if m_Menu is TsuiMainMenu then
        begin
            (m_Menu as TsuiMainMenu).UIStyle := m_UIStyle;
            (m_Menu as TsuiMainMenu).FileTheme := m_FileTheme;
        end;
    end;

    if (m_TitleBar = nil) then
        Exit;

    m_TitleBar.FileTheme := m_FileTheme;
    m_TitleBar.UIStyle := m_UIStyle;

    if not (csDesigning in ComponentState) then
    for i := 1 to 3 do
        m_ControlBtns[i].Color := MenuBarColor;

    m_TitleBar.RoundCorner := 0;
    m_TitleBar.RoundCornerBottom := 0;
    PaintBorder();
end;

procedure TsuiMDIForm.ShowControlButtons;
var
    i : Integer;
    Form : TsuiForm;
begin
    Form := GetActiveChildSUIForm();
    if Form = nil then
        Exit;

    for i := 0 to Form.TitleBarButtons.Count - 1 do
    begin
        if Form.TitleBarButtons.Items[i].ButtonType = suiMin then
            m_ControlBtns[3].Visible := true;
        if Form.TitleBarButtons.Items[i].ButtonType = suiMax then
            m_ControlBtns[2].Visible := true;
        if Form.TitleBarButtons.Items[i].ButtonType = suiClose then
            m_ControlBtns[1].Visible := true;
    end;
end;

procedure TsuiMDIForm.ShowMenuBar;
begin
    if (m_MenuBar = nil) then
        Exit;
    m_TopPanel.Visible := true;
end;

procedure TsuiMDIForm.Tile;
var
    i : Integer;
    nLeft, nTop, nWidth, nHeight : Integer;
    nCount : Integer;
    H : Integer;
begin
    nCount := 0;
    for i := m_Form.MDIChildCount - 1 downto 0 do
    begin
        if m_Form.MDIChildren[i].WindowState = wsMinimized then
            continue;
        Inc(nCount);
    end;

    H := 0;
    for i := 0 to m_Form.ControlCount - 1 do
    begin
        if (m_Form.Controls[i].Align = alTop) or (m_Form.Controls[i].Align = alBottom) then
            Inc(H, m_Form.Controls[i].Height);
    end;

    if nCount = 0 then
        Exit;

    nHeight := m_Form.ClientHeight - H;
    if nCount < m_Form.MDIChildCount then
        Dec(nHeight, 25);

    if m_Form.TileMode = tbVertical	then
    begin
        nLeft := 0;
        nWidth := m_Form.ClientWidth div nCount;
        for i := m_Form.MDIChildCount - 1 downto 0 do
        begin
            if m_Form.MDIChildren[i].WindowState = wsMinimized then
                continue;
            m_Form.MDIChildren[i].SetBounds(nLeft, 0, nWidth - 2, nHeight - 4);
            Inc(nLeft, nWidth - 2);
        end;
    end
    else
    begin
        nTop := 0;
        nHeight := nHeight div nCount;
        nWidth := m_Form.ClientWidth - 4;
        for i := m_Form.MDIChildCount - 1 downto 0 do
        begin
            if m_Form.MDIChildren[i].WindowState = wsMinimized then
                continue;
            m_Form.MDIChildren[i].SetBounds(0, nTop, nWidth, nHeight - 2);
            Inc(nTop, nHeight - 2);
        end;
    end;
end;

procedure TsuiMDIForm.UpdateMenu();
var
    i : Integer;
    Button : TToolButton;
begin
{$IFDEF SUIPACK_D5}
    if csDesigning in ComponentState then
        Exit;
{$ENDIF}

    m_TopMenu := GetMainMenu();

    if m_TopMenu = nil then
    begin
        HideMenuBar();
        Exit;
    end;

    if m_TitleBar <> nil then
        m_TitleBar.Top := 0;

    if m_Menu is TsuiMainMenu then
    begin
        if not TsuiMainMenu(m_Menu).UseSystemFont then
            m_MenuBar.Font.Size := TsuiMainMenu(m_Menu).FontSize
        else
            Menu_GetSystemFont(m_MenuBar.Font);
    end;

    m_TopPanel.Constraints.MinHeight:=m_MenuBar.Height;

    if m_TopMenu.Items.Count<m_MenuBar.ButtonCount then
    for i := m_TopMenu.Items.Count to m_MenuBar.ButtonCount - 1 do
       m_MenuBar.Buttons[0].Free();

    if m_TopMenu.Items.Count>m_MenuBar.ButtonCount then
    for i := m_MenuBar.ButtonCount to  m_TopMenu.Items.Count - 1 do
    begin
        Button := TToolButton.Create(self);
        Button.Parent := m_MenuBar;
        Button.Grouped := true;
        Button.AutoSize := true;
    end;

    for i := m_TopMenu.Items.Count - 1 downto 0 do
        m_MenuBar.Buttons[i].MenuItem := m_TopMenu.Items[i];
        
    ShowMenuBar();
    m_TopPanel.Constraints.MinHeight:=m_MenuBar.Height;
    m_TopPanel.Height := m_MenuBar.Height;

    UpdateWindowMenu();    
end;


function TsuiMDIForm.GetDrawAppIcon: Boolean;
begin
    Result := m_TitleBar.DrawAppIcon;
end;

procedure TsuiMDIForm.SetDrawAppIcon(const Value: Boolean);
begin
    m_TitleBar.DrawAppIcon := Value;
end;

function TsuiMDIForm.GetTitleBarCustom: Boolean;
begin
    Result := m_TitleBar.Custom;
end;

procedure TsuiMDIForm.SetTitleBarCustom(const Value: Boolean);
begin
    m_TitleBar.Custom := Value;
end;

function TsuiMDIForm.GetTitleBarVisible: Boolean;
begin
    Result := m_TitleBar.Visible;
end;

procedure TsuiMDIForm.SetTitleBarVisible(const Value: Boolean);
begin
    if m_TitleBar.Visible = Value then
        Exit;
    m_TitleBar.Visible := Value;
    m_TitleBar.Top := 0;
end;

function TsuiMDIForm.GetSections: TsuiTitleBarSections;
begin
    Result := m_TitleBar.Sections;
end;

procedure TsuiMDIForm.SetSections(const Value: TsuiTitleBarSections);
begin
    m_TitleBar.Sections.Assign(Value);
end;

function TsuiMDIForm.GetButtons: TsuiTitleBarButtons;
begin
    Result := m_TitleBar.Buttons;
end;

procedure TsuiMDIForm.SetButtons(const Value: TsuiTitleBarButtons);
begin
    m_TitleBar.Buttons.Assign(Value);
end;

function TsuiMDIForm.GetTitleBarHeight: integer;
begin
    result:=0;
    if m_TitleBar.Visible then
        result:= result + m_TitleBar.Height;
    if m_TopPanel.Visible then
        result:= result + m_TopPanel.Height;
end;

procedure TsuiMDIForm.DrawButton(Sender: TToolBar; Button: TToolButton;
  State: TCustomDrawState; var DefaultDraw: Boolean);
var
    ACanvas : TCanvas;
    ARect : TRect;
    R : TRect;
    Bmp : TBitmap;
    Buf : TBitmap;
    Style : TsuiUIStyle;
    OutUIStyle : TsuiUIStyle;
    CanSetFont : Boolean;
    AFileTheme : TsuiFileTheme;
    bUseFileTheme : Boolean;
begin
    Style := m_UIStyle;
    AFileTheme := m_FileTheme;
    CanSetFont := false;

    ACanvas := Sender.Canvas;
    ARect := Button.BoundsRect;
    DefaultDraw := false;    

    if Menu <> nil then
    begin
        if Menu is TsuiMainMenu then
        begin
            if (m_Menu as TsuiMainMenu).UseSystemFont then
                Menu_GetSystemFont(ACanvas.Font)
            else
            begin
                ACanvas.Font.Name := (m_Menu as TsuiMainMenu).FontName;
                ACanvas.Font.Size := (m_Menu as TsuiMainMenu).FontSize;
                ACanvas.Font.Charset := (m_Menu as TsuiMainMenu).FontCharset;
                ACanvas.Font.Color := (m_Menu as TsuiMainMenu).FontColor;
                CanSetFont := true;
            end;
        end;
    end;

    // MacOS
    if (
        ((cdsHot in State) or (cdsSelected in State)) and
        {$IFDEF RES_MACOS} (Style = MacOS) {$ELSE} false {$ENDIF}
    ) then
    begin
        DefaultDraw := false;

        Buf := TBitmap.Create();
        Bmp := TBitmap.Create();
        Buf.Width := Button.Width;
        Buf.Height := Button.Height;

        R := Rect(0, 0, Buf.Width, Buf.Height);
        Bmp.LoadFromResourceName(hInstance, 'MACOS_MENU_SELECT');
        Buf.Canvas.StretchDraw(R, Bmp);

        Buf.Canvas.Brush.Style := bsClear;
        if CanSetFont then
        begin
            Buf.Canvas.Font.Name := (m_Menu as TsuiMainMenu).FontName;
            Buf.Canvas.Font.Size := (m_Menu as TsuiMainMenu).FontSize;
            Buf.Canvas.Font.Charset := (m_Menu as TsuiMainMenu).FontCharset;
        end
        else
        begin
            Buf.Canvas.Font.Name := ACanvas.Font.Name;
            Buf.Canvas.Font.Size := ACanvas.Font.Size;
            Buf.Canvas.Font.Charset := ACanvas.Font.Charset;
        end;

        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
            Buf.Canvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR)
        else
            Buf.Canvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);
            
        R.Bottom := R.Bottom + 2;
        DrawText(Buf.Canvas.Handle, PChar(Button.Caption), -1, R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
        ACanvas.Draw(ARect.Left, ARect.Top, Buf);

        Bmp.Free();
        Buf.Free();
    end

    else if (
        (cdsHot in State) or
        (cdsSelected in State)
    ) then
    begin // selected or hot top menu
        // draw client background
        if cdsSelected in State then
            ARect.Right := ARect.Right - 2;
        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
        begin
            ACanvas.Brush.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
            bUseFileTheme := true
        end
        else
        begin
            ACanvas.Brush.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BACKGROUND_COLOR);
            bUseFileTheme := false            
        end;
        ACanvas.FillRect(ARect);

        // draw border
        if bUseFileTheme then
            ACanvas.Brush.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_BORDER_COLOR)
        else
            ACanvas.Brush.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_BORDER_COLOR);
        ACanvas.FrameRect(ARect);

        // draw text
        if cdsSelected in State then
            ARect.Left := ARect.Left + 2;
        ARect.Top := ARect.Top + 2;

        if bUseFileTheme then
            ACanvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_SELECTED_FONT_COLOR)
        else
            ACanvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_SELECTED_FONT_COLOR);

        DrawText(ACanvas.Handle, PChar(Button.Caption), -1, ARect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end

    // not select and not hot top menu
    else
    begin
        ACanvas.Brush.Style := bsClear;
        ARect.Top := ARect.Top + 2;
        if UsingFileTheme(AFileTheme, Style, OutUIStyle) then
        begin
            if AFileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR) = 196608 then
                ACanvas.Font.Color := clWhite
            else
                ACanvas.Font.Color := AFileTheme.GetColor(SUI_THEME_MENU_FONT_COLOR);
        end
        else
            ACanvas.Font.Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_MENU_FONT_COLOR);

        DrawText(ACanvas.Handle, PChar(Button.Caption), -1, ARect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end;
end;

procedure TsuiMDIForm.DrawMenuBar(Sender: TToolBar; const ARect: TRect;
  var DefaultDraw: Boolean);
var
    ACanvas : TCanvas;
    Buf : TBitmap;
    Style : TsuiUIStyle;
begin
    Style := m_UIStyle;
    if Menu <> nil then
    begin
        if Menu is TsuiMainMenu then
            Style := (Menu as TsuiMainMenu).UIStyle;
    end;

{$IFDEF RES_MACOS}
    if (Style = MacOS) then
    begin
        ACanvas := Sender.Canvas;
        Buf := TBitmap.Create();
        Buf.LoadFromResourceName(hInstance, 'MACOS_MENU_BAR');
        ACanvas.StretchDraw(ARect, Buf);
        Buf.Free();
    end;
{$ENDIF}
end;

procedure TsuiMDIForm.SetRoundCorner(const Value: Integer);
begin
    m_RoundCorner := Value;
    RegionWindow();
end;

procedure TsuiMDIForm.RegionWindow;
var
    R1, R2 : TRect;
    Rgn, Rgn1 : HRGN;
    C, C2 : Integer;
    TempRgn : HRGN;
    W, H : Integer;
begin
    if csDesigning in ComponentState then
        Exit;

    H := m_Form.Height;
    W := m_Form.Width;

    R1 := Rect(0, 0, W, H div 2);
    R2 := Rect(0, H div 2, W, H);
    if m_TitleBar.Visible then
    begin
        C := RoundCorner;
        C2 := RoundCornerBottom;
    end
    else
    begin
        C := 0;
        C2 := 0;
    end;
    if C2 = -1 then
        C2 := 0;

    Rgn := CreateRoundRectRgn(R1.Left, R1.Top, R1.Right + 1, R1.Bottom + 1, C, C);

    TempRgn := CreateRectRgn(
        R1.Left,
        R1.Bottom,
        R1.Left + C * 2,
        R1.Bottom - C * 2
    );
    CombineRgn(Rgn, Rgn, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    TempRgn := CreateRectRgn(
        R1.Right,
        R1.Bottom,
        R1.Right - C * 2,
        R1.Bottom - C * 2
    );
    CombineRgn(Rgn, Rgn, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    Rgn1 := CreateRoundRectRgn(R2.Left, R2.Top, R2.Right + 1, R2.Bottom + 1, C2, C2);

    TempRgn := CreateRectRgn(
        R2.Left,
        R2.Top,
        R2.Left + C2 * 2,
        R2.Top + C2 * 2
    );
    CombineRgn(Rgn1, Rgn1, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    TempRgn := CreateRectRgn(
        R2.Right,
        R2.Top,
        R2.Right - C2 * 2,
        R2.Top + C2 * 2
    );
    CombineRgn(Rgn1, Rgn1, TempRgn, RGN_OR);
    DeleteObject(TempRgn);

    CombineRgn(Rgn, Rgn, Rgn1, RGN_OR);
    DeleteObject(Rgn1);
    
    if not (csDesigning in m_Form.ComponentState) then
        SetWindowRgn(m_Form.Handle, Rgn, true);

    DeleteObject(Rgn);
end;

procedure TsuiMDIForm.OnTopPanelResize(Sender: TObject);
begin
{$IFDEF SUIPACK_D9UP}
    if csDesigning in ComponentState then
    begin
        SetWindowLong(m_Form.Handle, GWL_STYLE, GetWindowLong(m_Form.Handle, GWL_STYLE) and (not WS_CAPTION));
        SetWindowPos(m_Form.Handle, 0, 0, 0, 0, 0, SWP_DRAWFRAME or SWP_NOMOVE or SWP_NOZORDER or SWP_NOSIZE or SWP_NOACTIVATE);
    end;
{$ENDIF}
end;

procedure TsuiMDIForm.SetRoundCornerBottom(const Value: Integer);
begin
    m_RoundCornerBottom := Value;
    RegionWindow();
end;

procedure TsuiMDIForm.Loaded;
begin
    inherited;
    UpdateMenu();
end;

procedure TsuiMDIForm.UpdateWindowMenu;
var
    WindowMenu : TMenuItem;
    MenuItem : TMenuItem;
    i : Integer;
begin
    if m_Form = nil then
        Exit;
    if (m_Menu = nil) or (m_Form.WindowMenu = nil) then
        Exit;
    if m_Menu <> GetMainMenu() then
        Exit;

    WindowMenu := m_Form.WindowMenu;

    for i := 0 to m_WindowMenuList.Count - 1 do
        TMenuItem(m_WindowMenuList[i]).Free();
    m_WindowMenuList.Clear();

    MenuItem := TMenuItem.Create(nil);
    m_WindowMenuList.Add(MenuItem);
    MenuItem.Caption := '-';
    WindowMenu.Add(MenuItem);

    for i := m_Form.MDIChildCount - 1 downto 0 do
    begin
        if csDestroying in m_Form.MDIChildren[i].ComponentState then
            continue;
        MenuItem := TMenuItem.Create(nil);
        m_WindowMenuList.Add(MenuItem);
        MenuItem.Caption := m_Form.MDIChildren[i].Caption;
        MenuItem.OnClick := OnWindowMenuClick;
        MenuItem.Tag := Integer(m_Form.MDIChildren[i]);
        WindowMenu.Add(MenuItem);
    end;
    if m_Menu is TsuiMainMenu then
        (m_Menu as TsuiMainMenu).MenuAdded();
end;

procedure TsuiMDIForm.OnWindowMenuClick(Sender: TObject);
var
    MenuItem : TMenuItem;
    Form : TCustomForm;
begin
    if not (Sender is TMenuItem) then
        Exit;
    MenuItem := Sender as TMenuItem;
    Form := TCustomForm(MenuItem.Tag);
    if wsMinimized = Form.WindowState then
        Form.WindowState := wsNormal;
    Form.BringToFront();
end;

{ TsuiMSNPopForm }

procedure TsuiMSNPopForm.Close;
begin
    m_Form.Timer1.Enabled := false;
    m_Form.Hide();
end;

constructor TsuiMSNPopForm.Create(AOwner: TComponent);
begin
    inherited;

    m_AnimateTime := 400;
    m_StayTime := 2000;
    m_X := 0;
    m_Y := 0;
    m_AutoPosition := true;
    m_ClickHide := false;
    m_Text := '';
    m_Title := '';
    m_TitleFont := TFont.Create();
    m_TitleFont.Color := clNavy;
    m_TextFont := TFont.Create();
    m_TextFont.Color := clNavy;
    m_Form := TfrmMSNPopForm.Create(self);
    m_Form.OnClick := InternalOnClick;
    m_Form.CloseCallback := InternalOnClose;
    if Assigned(m_Form.lbl_title) then
        m_Form.lbl_title.OnClick := InternalOnTitleClick;
    if Assigned(m_Form.lbl_text) then
        m_Form.lbl_text.OnClick := InternalOnClick;
    m_Form.AnimateTime := m_AnimateTime;
    m_Form.Hide();
end;

destructor TsuiMSNPopForm.Destroy;
begin
    m_Form.Free();
    m_Form := nil;
    
    inherited;
end;

procedure TsuiMSNPopForm.InternalOnClick(Sender: TObject);
begin
    if Assigned(m_OnClick) then
        m_OnClick(self);
end;

procedure TsuiMSNPopForm.InternalOnClose(Sender: TObject);
begin
    if Assigned(m_OnClose) then
        m_OnClose(self);
end;

procedure TsuiMSNPopForm.InternalOnTitleClick(Sender: TObject);
begin
    if Assigned(m_OnTitleClick) then
        m_OnTitleClick(self)
end;

procedure TsuiMSNPopForm.Popup;
begin
    m_Form.AnimateTime := m_AnimateTime;
    m_Form.StayTime := m_StayTime;
    m_Form.ClickHide := m_ClickHide;
    m_Form.lbl_title.Caption := m_Title;
    m_Form.lbl_title.Font.Assign(m_TitleFont);
    m_Form.lbl_text.Caption := m_Text;
    m_Form.lbl_text.Font.Assign(m_TextFont);

    if Assigned(m_OnShow) then
        m_OnShow(self);

    if m_AutoPosition then
    begin
        m_Form.Left := GetWorkAreaRect().Right - m_Form.Width - 18;
        m_Form.Top := GetWorkAreaRect().Bottom - m_Form.Height;
    end
    else
    begin
        m_Form.Left := m_X;
        m_Form.Top := m_Y;
    end;

    m_Form.Show();
    m_Form.Timer1.Enabled := true;
end;

procedure TsuiMSNPopForm.SetTextFont(const Value: TFont);
begin
    m_TextFont.Assign(Value);
end;

procedure TsuiMSNPopForm.SetTitleFont(const Value: TFont);
begin
    m_TitleFont.Assign(Value);
end;

{ TsuiMenuBar }

procedure TsuiMenuBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;
    if (Operation = opInsert) and (AComponent is TPopupMenu) then
    begin
        if AComponent.Owner = self then
            (AComponent as TPopupMenu).OnPopup := OnMenuPopup;
    end;
end;

procedure TsuiMenuBar.OnMenuPopup(Sender: TObject);
begin
    if (m_Form <> nil) and (m_Form.Menu <> nil) then
        (Sender as TPopupMenu).AutoHotkeys := m_Form.Menu.AutoHotkeys;
    if (m_MDIForm <> nil) and (m_MDIForm.m_TopMenu <> nil) then
        (Sender as TPopupMenu).AutoHotkeys := m_MDIForm.m_TopMenu.AutoHotkeys;
end;

end.
