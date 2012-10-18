///////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUITitleBar.pas
//  Creater     :   Shen Min
//  Date        :   2001-10-15 V1-V3
//                  2003-06-15 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////////

unit SUITitleBar;

interface

{$I SUIPack.inc}

uses Windows, Controls, Classes, Forms, Messages, Graphics, Menus, ExtCtrls,
     Dialogs, SysUtils,
     SUIThemes, SUIMgr, SUIPopupMenu;


type
    TsuiTitleBarSections = class;
    TsuiTitleBarButtons = class;
    TsuiTitleBar = class;

    TsuiTitleBarButtonClickEvent = procedure (Sender : TObject; ButtonIndex : Integer) of object;

    TsuiTitleBarPopupMenu = class(TsuiPopupMenu)
    private
        m_TitleBar : TsuiTitleBar;
        
        procedure OnMin(Sender: TObject);
        procedure OnMax(Sender: TObject);
        procedure OnClose(Sender: TObject);

    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy(); override;
        procedure Popup(X, Y: Integer); override;

        property TitleBar : TsuiTitleBar read m_TitleBar write m_TitleBar;
    end;


    TsuiTitleBar = class(TCustomPanel)
    private
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;        
        m_Sections : TsuiTitleBarSections;
        m_Buttons : TsuiTitleBarButtons;
        m_AutoSize : Boolean;
        m_ButtonInterval : Integer;
        m_Caption : TCaption;
        m_Active : Boolean;
        m_LeftBtnXOffset : Integer;
        m_RightBtnXOffset : Integer;
        m_RoundCorner : Integer;
        m_RoundCornerBottom : Integer;
        m_DrawAppIcon : Boolean;
        m_SelfChanging : Boolean;
        m_DefPopupMenu : TsuiTitleBarPopupMenu;
        m_BorderColor : TColor;
        m_Custom : Boolean;

        m_MouseDown : Boolean;
        m_InButtons : Integer;
        m_BtnHeight : Integer;
        m_BtnTop : Integer;

        m_OnBtnClick : TsuiTitleBarButtonClickEvent;
        m_OnHelpBtnClick : TsuiTitleBarButtonClickEvent;

        procedure SetButtons(const Value : TsuiTitleBarButtons);
        procedure SetSections(const Value : TsuiTitleBarSections);
        procedure SetUIStyle(const Value : TsuiUIStyle);
        procedure SetButtonInterval(const Value : Integer);
        procedure SetCaption(const Value : TCaption);
        procedure SetActive(const Value : Boolean);
        procedure SetAutoSize2(Value : Boolean);
        procedure SetLeftBtnXOffset(const Value: Integer);
        procedure SetRightBtnXOffset(const Value: Integer);
        procedure SetDrawAppIcon(const Value: Boolean);
        procedure SetRoundCorner(const Value: Integer);
        procedure SetRoundCornerBottom(const Value: Integer);
        procedure SetFileTheme(const Value: TsuiFileTheme);

        procedure UpdateInsideTheme(UIStyle : TsuiUIStyle);
        procedure UpdateFileTheme();

        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;
        procedure CMFONTCHANGED(var Msg : TMessage); message CM_FONTCHANGED;
        procedure WMNCLBUTTONDOWN(var Msg: TMessage); message WM_NCLBUTTONDOWN;
        procedure WMNCLBUTTONUP(var Msg: TMessage); message WM_NCLBUTTONUP;
        procedure WMNCMOUSEMOVE(var Msg: TMessage); message WM_NCMOUSEMOVE;
        procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;

    protected
        procedure Paint(); override;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
        procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
        procedure DblClick(); override;
        procedure MouseOut(var Msg : TMessage); message CM_MOUSELEAVE;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;        

        procedure DrawSectionsTo(Buf : TBitmap); virtual;
        procedure DrawButtons(Buf : TBitmap); virtual;

        function InForm() : Boolean;
        function InMDIForm() : Boolean;

    public
        constructor Create(AOwner: TComponent); override;
        destructor Destroy(); override;

        procedure ProcessMaxBtn();
        procedure GetLeftImage(out Bmp : TBitmap);
        procedure GetRightImage(out Bmp : TBitmap);
        procedure GetCenterImage(out Bmp : TBitmap);
        function CanPaint() : Boolean;

        property DefPopupMenu : TsuiTitleBarPopupMenu read m_DefPopupMenu;

    published
        property Custom : Boolean read m_Custom write m_Custom;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property AutoSize read m_AutoSize write SetAutoSize2;
        property BiDiMode;
        property Height;
        property Sections : TsuiTitleBarSections read m_Sections write SetSections;
        property Buttons : TsuiTitleBarButtons read m_Buttons write SetButtons;
        property ButtonInterval : Integer read m_ButtonInterval write SetButtonInterval;
        property Caption read m_Caption write SetCaption;
        property Font;
        property FormActive : Boolean read m_Active write SetActive;
        property LeftBtnXOffset : Integer read m_LeftBtnXOffset write SetLeftBtnXOffset;
        property RightBtnXOffset : Integer read m_RightBtnXOffset write SetRightBtnXOffset;
        property DrawAppIcon : Boolean read m_DrawAppIcon write SetDrawAppIcon;
        property RoundCorner : Integer read m_RoundCorner write SetRoundCorner;
        property RoundCornerBottom : Integer read m_RoundCornerBottom write SetRoundCornerBottom;

        property OnCustomBtnsClick : TsuiTitleBarButtonClickEvent read m_OnBtnClick write m_OnBtnClick;
        property OnHelpBtnClick : TsuiTitleBarButtonClickEvent read m_OnHelpBtnClick write m_OnHelpBtnClick;
        property OnResize;
    end;

    // ---------------- Buttons ------------------------------------
    TsuiTitleBarBtnType = (suiMax, suiMin, suiClose, suiHelp, suiControlBox, suiCustom);

    TsuiTitleBarButton = class(TCollectionItem)
    private
        m_Visible : Boolean;
        m_ButtonType : TsuiTitleBarBtnType;
        m_Transparent : Boolean;
        m_Top : Integer;
        m_UIStyle : TsuiUIStyle;
        m_PicNormal : TPicture;
        m_PicMouseOn : TPicture;
        m_PicMouseDown : TPicture;
        m_ControlBoxMenu : TPopupMenu;

        procedure SetButtonType(const Value : TsuiTitleBarBtnType);
        procedure SetTransparent(const Value : Boolean);
        procedure SetTop(const Value : Integer);
        procedure SetUIStyle(const Value : TsuiUIStyle);
        procedure SetPicNormal(const Value : TPicture);
        procedure SetPicMouseOn(const Value : TPicture);
        procedure SetPicMouseDown(const Value : TPicture);

        procedure UpdateUIStyle();
        procedure UpdateInsideTheme(UIStyle : TsuiUIStyle);
        procedure UpdateFileTheme();

        procedure ProcessMaxBtn();
        procedure SetVisible(const Value: Boolean);

    public
        procedure DoClick();

        constructor Create(Collection: TCollection); override;
        destructor Destroy; override;

        procedure Assign(Source: TPersistent); override;        

    published
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property ButtonType : TsuiTitleBarBtnType read m_ButtonType write SetButtonType;
        property Transparent : Boolean read m_Transparent write SetTransparent;
        property Top : Integer read m_Top write SetTop;
        property ControlBoxMenu : TPopupMenu read m_ControlBoxMenu write m_ControlBoxMenu;
        property Visible :Boolean read m_Visible write SetVisible;

        property PicNormal : TPicture read m_PicNormal write SetPicNormal;
        property PicMouseOn : TPicture read m_PicMouseOn write SetPicMouseOn;
        property PicMouseDown : TPicture read m_PicMouseDown write SetPicMouseDown;

    end;

    TsuiTitleBarButtons = class(TCollection)
    private
        m_TitleBar : TsuiTitleBar;

    protected
        function GetItem(Index: Integer): TsuiTitleBarButton;
        procedure SetItem(Index: Integer; Value: TsuiTitleBarButton);
        procedure Update(Item: TCollectionItem); override;
        function GetOwner : TPersistent; override;

    public
        function Add() : TsuiTitleBarButton;
        constructor Create(TitleBar: TsuiTitleBar);
        property Items[Index: Integer]: TsuiTitleBarButton read GetItem write SetItem;

    end;


    // ---------------- Sections ------------------------------------

    TsuiTitleBarAlign = (suiLeft, suiRight, suiClient);

    TsuiTitleBarSection = class(TCollectionItem)
    private
        m_Width : Integer;
        m_Align : TsuiTitleBarAlign;
        m_Picture : TPicture;
        m_Stretch : Boolean;
        m_AutoSize : Boolean;
        procedure SetPicture(const Value : TPicture);
        procedure SetAutoSize(const Value : Boolean);
        procedure SetWidth(const Value : Integer);
        procedure SetAlign(const Value : TsuiTitleBarAlign);
        procedure SetStretch(const Value : Boolean);

    public
        constructor Create(Collection: TCollection); override;
        destructor Destroy; override;

        procedure Assign(Source: TPersistent); override;        

    published
        property AutoSize : Boolean read m_AutoSize write SetAutoSize;
        property Width : Integer read m_Width write SetWidth;
        property Align : TsuiTitleBarAlign read m_Align write SetAlign;
        property Picture : TPicture read m_Picture write SetPicture;
        property Stretch : Boolean read m_Stretch write SetStretch;

    end;

    TsuiTitleBarSections = class(TCollection)
    private
        m_TitleBar : TsuiTitleBar;

    protected
        function GetItem(Index: Integer): TsuiTitleBarSection;
        procedure SetItem(Index: Integer; Value: TsuiTitleBarSection);

        procedure Update(Item: TCollectionItem); override;
        function GetOwner : TPersistent; override;        

    public
        constructor Create(TitleBar: TsuiTitleBar);
        destructor Destroy(); override;

        function Add() : TsuiTitleBarSection;
        property Items[Index: Integer]: TsuiTitleBarSection read GetItem write SetItem;

    end;

const
    SUIM_GETBORDERWIDTH     = WM_USER + 8899;

implementation

uses SUIResDef, SUIPublic, SUIForm;

{ TsuiTitleBarPopupMenu }

constructor TsuiTitleBarPopupMenu.Create(AOwner: TComponent);
var
    MenuItem : TMenuItem;
begin
    inherited;

    Self.AutoHotkeys := maManual;

    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := SUI_TITLE_MENUITEM_MINIMIZE;
    MenuItem.OnClick := OnMin;
    Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := SUI_TITLE_MENUITEM_MAXIMIZE;
    MenuItem.OnClick := OnMax;
    Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := '-';
    Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(nil);
    MenuItem.Caption := SUI_TITLE_MENUITEM_CLOSE;
    MenuItem.OnClick := OnClose;
    Items.Add(MenuItem);

    MenuAdded();
end;

destructor TsuiTitleBarPopupMenu.Destroy;
begin

    inherited;
end;

procedure TsuiTitleBarPopupMenu.OnClose(Sender: TObject);
var
    ParentForm : TCustomForm;
begin
    ParentForm := GetParentForm(m_TitleBar);
    if ParentForm <> nil then
        ParentForm.Close(); 
end;

procedure TsuiTitleBarPopupMenu.OnMax(Sender: TObject);
var
    i : Integer;
begin
    for i := 0 to m_TitleBar.m_Buttons.Count - 1 do
    begin
        if (m_TitleBar.m_Buttons.Items[i].ButtonType = suiMax) and
            m_TitleBar.m_Buttons.Items[i].Visible then
            m_TitleBar.m_Buttons.Items[i].DoClick();
    end;
end;

procedure TsuiTitleBarPopupMenu.OnMin(Sender: TObject);
var
    ParentForm : TCustomForm;
begin
    ParentForm := GetParentForm(m_TitleBar);
    if (ParentForm = nil) or (Application = nil) then
        Exit;
    if ParentForm = Application.MainForm then
        SendMessage(Application.MainForm.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
    else
//        ShowWindow(ParentForm.Handle, SW_SHOWMINIMIZED);
        ParentForm.WindowState := wsMinimized;
end;

procedure TsuiTitleBarPopupMenu.Popup(X, Y: Integer);
var
    i : Integer;
    MinItem, MaxItem, CloseItem : Boolean;
begin
    MinItem := false;
    MaxItem := false;
    CloseItem := false;
    if (m_TitleBar.BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
        Inc(X, 176);

    for i := 0 to m_TitleBar.m_Buttons.Count - 1 do
    begin
        if (m_TitleBar.m_Buttons.Items[i].ButtonType = suiMin) and
            m_TitleBar.m_Buttons.Items[i].Visible then
            MinItem := true;
        if (m_TitleBar.m_Buttons.Items[i].ButtonType = suiMax) and
            m_TitleBar.m_Buttons.Items[i].Visible then
            MaxItem := true;
        if (m_TitleBar.m_Buttons.Items[i].ButtonType = suiClose) and
            m_TitleBar.m_Buttons.Items[i].Visible then
            CloseItem := true;
    end;

    Items[0].Enabled := MinItem;
    Items[1].Enabled := MaxItem;
    Items[3].Enabled := CloseItem;

    inherited;
end;

{ TsuiTitleBar }

constructor TsuiTitleBar.Create(AOwner: TComponent);
var
    Btn : TsuiTitleBarButton;
begin
    inherited Create(AOwner);
    ControlStyle := ControlStyle - [csAcceptsControls];
    ParentBidiMode := true;
    m_Custom := false;

    m_DefPopupMenu := TsuiTitleBarPopupMenu.Create(self);
    m_DefPopupMenu.TitleBar := self;

    m_Sections := TsuiTitleBarSections.Create(self);
    m_Buttons := TsuiTitleBarButtons.Create(self);

    Btn := m_Buttons.Add();
    Btn.ButtonType := suiControlBox;

    Btn := m_Buttons.Add();
    Btn.ButtonType := suiClose;

    Btn := m_Buttons.Add();
    Btn.ButtonType := suiMax;

    Btn := m_Buttons.Add();
    Btn.ButtonType := suiMin;

    Align := alTop;
    ButtonInterval := 0;
    FormActive := true;

    m_MouseDown := false;
    m_InButtons := -1;
    m_LeftBtnXOffset := 0;
    m_RightBtnXOffset := 0;
    m_DrawAppIcon := false;
    m_SelfChanging := false;

    Font.Color := clWhite;
    Font.Name := 'Tahoma';
    Font.Style := [fsBold];

    UIStyle := GetSUIFormStyle(AOwner)
end;

procedure TsuiTitleBar.SetLeftBtnXOffset(const Value: Integer);
begin
    m_LeftBtnXOffset := Value;

    Repaint();
end;

procedure TsuiTitleBar.SetRightBtnXOffset(const Value: Integer);
begin
    m_RightBtnXOffset := Value;

    Repaint();
end;

procedure TsuiTitleBar.DblClick;
var
    i : Integer;
    ParentForm : TCustomForm;
begin
    inherited;

    if csDesigning in ComponentState then
        Exit;
    if m_InButtons <> -1 then
    begin
        if m_Buttons.Items[m_InButtons].ButtonType = suiControlBox then
        begin
            ParentForm := GetParentForm(self);
            if ParentForm <> nil then
                ParentForm.Close();
        end;

        Exit;
    end;

    for i := 0 to m_Buttons.Count - 1 do
    begin
        if (m_Buttons.Items[i].ButtonType = suiMax) and
            m_Buttons.Items[i].Visible then
        begin
            m_Buttons.Items[i].DoClick();
            Exit;
        end;
    end;
end;

destructor TsuiTitleBar.Destroy();
begin
    m_Buttons.Free();
    m_Buttons := nil;

    m_Sections.Free();
    m_Sections := nil;

    m_DefPopupMenu.Free();
    m_DefPopupMenu := nil;

    inherited Destroy();
end;

procedure TsuiTitleBar.DrawButtons(Buf: TBitmap);
var
    i : Integer;
    Btn : TsuiTitleBarButton;
    nControlBox : Integer;
    BtnRect : TRect;
    nLeft : Integer;
    nLeft2 : Integer;
    MousePoint : TPoint;
    BtnBuf : TBitmap;
    Cap : String;
    Icon : TIcon;
    CaptionHeight : Integer;
    FormBorderWidth : Integer;
begin
    nLeft := Buf.Width + 1 + m_RightBtnXOffset;
    FormBorderWidth := SendMessage(GetParentForm(self).Handle, SUIM_GETBORDERWIDTH, 0, 0) - 1;
    Inc(nLeft, FormBorderWidth);
    nControlBox := -1;

    BtnBuf := TBitmap.Create();

    GetCursorPos(MousePoint);
    MousePoint := ScreenToClient(MousePoint);
    m_InButtons := -1;

    for i := 0 to m_Buttons.Count - 1 do
    begin
        Btn := m_Buttons.Items[i];
        if not Btn.Visible then
            continue;

        BtnBuf.Width := Btn.PicNormal.Width;
        BtnBuf.Height := Btn.PicNormal.Height;
        BtnBuf.Transparent := Btn.Transparent;

        if Btn.ButtonType = suiControlBox then
        begin
            nControlBox := i;
            continue;
        end;

        Dec(nLeft, Btn.PicNormal.Width + 1 + m_ButtonInterval);
        if nLeft + Btn.PicNormal.Width + 1 > Buf.Width then
            nLeft := Buf.Width - Btn.PicNormal.Width - 1;

        BtnRect := Rect(nLeft, m_BtnTop, nLeft + Btn.PicNormal.Width, m_BtnTop + Btn.PicNormal.Height);
        if InRect(MousePoint, BtnRect) then
        begin
            m_InButtons := i;

            if m_MouseDown then
            begin
                if Btn.PicMouseDown <> nil then
                    BtnBuf.Canvas.Draw(0, 0, Btn.PicMouseDown.Graphic);
{$IFNDEF SUIPACK_D9UP}
                if (csDesigning in ComponentState) and InForm() then
                begin
                    if Btn.ButtonType = suiClose then
                        ShowWindow(GetParentForm(self).Handle, SW_HIDE);
                end;
{$ENDIF}
            end
            else
            begin
                if Btn.PicMouseOn <> nil then
                    BtnBuf.Canvas.Draw(0, 0, Btn.PicMouseOn.Graphic);
            end;
        end
        else
            BtnBuf.Canvas.Draw(0, 0, Btn.PicNormal.Graphic);

        Buf.Canvas.Draw(nLeft, m_BtnTop, BtnBuf);
    end;

    nLeft2 := m_LeftBtnXOffset;
    Dec(nLeft2, FormBorderWidth);
    if nLeft2 < 0 then
        nLeft2 := 0;

    if nControlBox <> -1 then
    begin
        Btn := m_Buttons.Items[nControlBox];

        BtnRect := Rect(nLeft2, m_BtnTop, nLeft2 + Btn.PicNormal.Width, m_BtnTop + Btn.PicNormal.Height);
        
        if not m_DrawAppIcon then
        begin
            BtnBuf.Width := Btn.PicNormal.Width;
            BtnBuf.Height := Btn.PicNormal.Height;
            BtnBuf.Transparent := Btn.Transparent;

            if InRect(MousePoint, BtnRect) then
            begin
                m_InButtons := nControlBox;

                if m_MouseDown then
                    BtnBuf.Canvas.Draw(0, 0, Btn.PicMouseDown.Graphic)
                else
                    BtnBuf.Canvas.Draw(0, 0, Btn.PicMouseOn.Graphic);
            end
            else
                BtnBuf.Canvas.Draw(0, 0, Btn.PicNormal.Graphic);
            Buf.Canvas.Draw(nLeft2, m_BtnTop - 1, BtnBuf);
            Inc(nLeft2, Btn.PicNormal.Width + 5);
        end
        else
        begin
            if InRect(MousePoint, BtnRect) then
                m_InButtons := nControlBox;

            BtnBuf.Height := 16;
            BtnBuf.Width := 16;
            Icon := TIcon.Create();
            if Application <> nil then
                Icon.Handle := CopyImage(Application.Icon.Handle, IMAGE_ICON, 16, 16, LR_COPYFROMRESOURCE)
            else
                Icon.Handle := LoadImage(hInstance, 'MAINICON', IMAGE_ICON, 16, 16, LR_DEFAULTCOLOR);
            Buf.Canvas.Draw(nLeft2 + 3, m_BtnTop, Icon);
            Icon.Free();
            Inc(nLeft2, 21);
        end;
    end;

    if nLeft2 = 0 then
        Inc(nLeft2, 6);

    if not m_Active then
        Buf.Canvas.Font.Color := clInactiveCaption;

    if Buf.Canvas.TextWidth(Caption) > nLeft - nLeft2 then
    begin
        Cap := Caption;
        while Buf.Canvas.TextWidth(Cap + '...') > nLeft - nLeft2 do
            SetLength(Cap, Length(Cap) - 1);
        Cap := Cap + '...'
    end
    else
        Cap := Caption;

    CaptionHeight := Buf.Canvas.TextHeight(Cap);
    if (BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
        Buf.Canvas.TextOut(nLeft - Buf.Canvas.TextWidth(Cap) - 10,  m_BtnTop + (m_BtnHeight - CaptionHeight) div 2, Cap)
    else
        Buf.Canvas.TextOut(nLeft2, m_BtnTop + (m_BtnHeight - CaptionHeight) div 2, Cap);
    BtnBuf.Free();
end;

function TsuiTitleBar.InForm: Boolean;
begin
    if (
        (Parent <> nil) and
        ((Parent is TsuiForm) or (Owner is TsuiMDIForm))
    ) then
        Result := true
    else
        Result := false;
end;

procedure TsuiTitleBar.SetDrawAppIcon(const Value: Boolean);
begin
    m_DrawAppIcon := Value;

    Repaint();
end;

procedure TsuiTitleBar.DrawSectionsTo(Buf: TBitmap);
var
    nLeft, nRight : Integer;
    TopOffset : Integer;
    Offset : Integer;
    Bmp : TBitmap;
begin
    nRight := 0;
    nLefT := 0;
    if InForm() then
    begin
        Offset := -1 * SendMessage(GetParentForm(self).Handle, SUIM_GETBORDERWIDTH, 0, 0);
        if Offset = 0 then
        begin
            if InMDIForm() then
                Offset := -4
            else
                Offset := -3;
        end;
        TopOffset := -3
    end
    else
    begin
        Offset := 0;
        TopOffset := 0;
    end;

    if (m_Sections.Count > 0) and (m_Sections.Items[0].Picture <> nil) then
    begin
        GetLeftImage(Bmp);
        Buf.Canvas.Draw(Offset, TopOffset, Bmp);
        nLeft := Bmp.Width + Offset;
    end;

    if (m_Sections.Count > 1) and (m_Sections.Items[1].Picture <> nil) then
    begin
        GetRightImage(Bmp);
        nRight := Buf.Width - Bmp.Width - Offset;
        Buf.Canvas.Draw(nRight, TopOffset, Bmp);
    end;

    if (m_Sections.Count > 2) and (m_Sections.Items[2].Picture <> nil) then
    begin
        GetCenterImage(bmp);
        Buf.Canvas.StretchDraw(Rect(nLeft, TopOffset, nRight, Bmp.Height + TopOffset), Bmp);
    end;
end;

procedure TsuiTitleBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    Form : TCustomForm;
begin
    inherited;

    if Button = mbLeft then
    begin
        m_MouseDown := true;
        Repaint();
        Form := GetParentForm(self);
        if Form = nil then
            Exit;


        if (
            ((m_InButtons = -1) and
            (Form.WindowState <> wsMaximized))
    {$IFDEF SUIPACK_D9UP}
            and not (csDesigning in ComponentState)
    {$ELSE}
            or (csDesigning in ComponentState)
    {$ENDIF}
        ) then
        begin
            ReleaseCapture();
            SendMessage(Form.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
            m_MouseDown := false;
        end
    end
end;

procedure TsuiTitleBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
    inherited;

    Repaint();
end;

procedure TsuiTitleBar.MouseOut(var Msg: TMessage);
begin
    inherited;

    Repaint();
end;

procedure TsuiTitleBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
    Point : TPoint;
    InButtons : Integer;
begin
    inherited;

    if Button <> mbLeft then
        Exit;
    InButtons := m_InButtons;
    if InButtons <> -1 then
    begin
        if (
            (m_Buttons.Items[InButtons].ButtonType = suiControlBox) and
            (m_Buttons.Items[InButtons].ControlBoxMenu = nil)
        ) then
        begin
            Point.X := 0;
            Point.Y := Height;
            Point := ClientToScreen(Point);
            m_DefPopupMenu.Popup(Point.X, Point.Y);
        end
        else
        begin
            m_Buttons.Items[InButtons].DoClick();
            if (
                Assigned(m_OnBtnClick) and
                (m_Buttons.Items[InButtons].ButtonType = suiCustom)
            ) then
                m_OnBtnClick(self, InButtons)

            else if(
                Assigned(m_OnHelpBtnClick) and
                (m_Buttons.Items[InButtons].ButtonType = suiHelp)
            ) then
                m_OnHelpBtnClick(self, InButtons);
        end;
    end;
    m_MouseDown := false;
    Repaint();
end;

procedure TsuiTitleBar.WMERASEBKGND(var Msg: TMessage);
begin
    // do nothing
end;

procedure TsuiTitleBar.Paint;
var
    Buf : TBitmap;
begin
    Buf := TBitmap.Create();
    Buf.Canvas.Brush.Style := bsClear;
    Buf.Canvas.Font := Font;

    try
        Buf.Width := Width;
        Buf.Height := Height;

        DrawSectionsTo(Buf);
        DrawButtons(Buf);

        BitBlt(Canvas.Handle, 0, 0, Buf.Width, Buf.Height, Buf.Canvas.Handle, 0, 0, SRCCOPY);

    finally
        Buf.Free();
    end;
end;

procedure TsuiTitleBar.SetActive(const Value: Boolean);
begin
    m_Active := Value;

    Repaint();
end;

procedure TsuiTitleBar.SetAutoSize2(Value: Boolean);
begin
    m_AutoSize := Value;

    if Sections.Count > 0 then
    begin
        if InForm() then
            Height := Sections.Items[0].Picture.Height - 3
        else
            Height := Sections.Items[0].Picture.Height;
    end
    else
        m_AutoSize := false;
end;

procedure TsuiTitleBar.SetButtonInterval(const Value: Integer);
begin
    m_ButtonInterval := Value;

    Repaint();
end;

procedure TsuiTitleBar.SetButtons(const Value: TsuiTitleBarButtons);
begin
    m_Buttons.Assign(Value);
end;

procedure TsuiTitleBar.SetCaption(const Value: TCaption);
begin
    m_Caption := Value;

    Repaint();
end;

procedure TsuiTitleBar.SetSections(const Value: TsuiTitleBarSections);
begin
    m_Sections.Assign(Value);
end;

procedure TsuiTitleBar.SetUIStyle(const Value: TsuiUIStyle);
var
    i : Integer;
    OutUIStyle : TsuiUIStyle;
    bUsingFileTheme : Boolean;
    Tmp : TColor;
begin
    m_UIStyle := Value;
    if m_Custom then
        Exit;

    Sections.Clear();

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        UpdateFileTheme();
        bUsingFileTheme := true;
    end
    else
    begin
        UpdateInsideTheme(OutUIStyle);
        bUsingFileTheme := false;
    end;

    for i := 0 to m_Buttons.Count - 1 do
        m_Buttons.Items[i].UIStyle := OutUIStyle;

    m_DefPopupMenu.UIStyle := OutUIStyle;
    m_DefPopupMenu.FileTheme := m_FileTheme;

    if not m_SelfChanging then
    begin
{$IFDEF RES_MACOS}
        if m_UIStyle = MacOS then
            Font.Color := clBlack
        else
{$ENDIF}        
        begin
            if bUsingFileTheme then
            begin
                Tmp := m_FileTheme.GetColor(SUI_THEME_TITLEBAR_FONT_COLOR);
                if Tmp = -1 then
                begin
                    Tmp := m_FileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR);
                    if (Tmp = 65536) or (Tmp = 262144) or (Tmp = 196608) or (Tmp = 327680) then
                        Font.Color := clBlack
                    else
                        Font.Color := clWhite;
                end
                else
                    Font.Color := Tmp;
            end
            else
                Font.Color := clWhite;
        end;
    end;

    AutoSize := true;
    Repaint();
end;

procedure TsuiTitleBar.ProcessMaxBtn;
var
    i : Integer;
begin
    for i := 0 to m_Buttons.Count - 1 do
        if m_Buttons.Items[i].ButtonType = suiMax then
            m_Buttons.Items[i].ProcessMaxBtn();
end;

procedure TsuiTitleBar.GetCenterImage(out Bmp: TBitmap);
begin
    if Sections.Count > 2 then
        Bmp := Sections.Items[2].Picture.Bitmap;
end;

procedure TsuiTitleBar.GetLeftImage(out Bmp: TBitmap);
begin
    if Sections.Count > 0 then
        Bmp := Sections.Items[0].Picture.Bitmap;
end;

procedure TsuiTitleBar.GetRightImage(out Bmp: TBitmap);
begin
    if Sections.Count > 1 then
        Bmp := Sections.Items[1].Picture.Bitmap;
end;

procedure TsuiTitleBar.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
    HitPos : TPoint;
begin
    if Msg.Keys = MK_LBUTTON then
    begin
        HitPos := SmallPointToPoint(Msg.Pos);
        MouseDown(mbLeft, [], HitPos.X, HitPos.Y);
{$IFDEF SUIPACK_D6UP}
        Msg.Result := 1;
{$ENDIF}
{$IFDEF SUIPACK_D5}
        if not InMDIForm() then
            Msg.Result := 1
{$ENDIF}
    end;
end;

function TsuiTitleBar.CanPaint: Boolean;
begin
    Result := false;
    if Sections = nil then
        Exit;
    if Sections.Count = 3 then
    begin
        Result := (Sections.Items[0].Picture <> nil) and
                  (Sections.Items[1].Picture <> nil) and
                  (Sections.Items[2].Picture <> nil);
    end;
end;

function TsuiTitleBar.InMDIForm: Boolean;
begin
    if (
        (Owner is TsuiMDIForm) and
        (Parent <> nil)
    ) then
        Result := true
    else
        Result := false;
end;

procedure TsuiTitleBar.SetRoundCornerBottom(const Value: Integer);
begin
    m_RoundCornerBottom := Value;
end;

{ TsuiTitleBarSection }

procedure TsuiTitleBarSection.Assign(Source: TPersistent);
begin
    if Source is TsuiTitleBarSection then
    begin
        Width := TsuiTitleBarSection(Source).m_Width;
        Align := TsuiTitleBarSection(Source).m_Align;
        Picture.Assign(TsuiTitleBarSection(Source).m_Picture);
        Stretch := TsuiTitleBarSection(Source).m_Stretch;
        AutoSize := TsuiTitleBarSection(Source).m_AutoSize;
    end
    else
        inherited Assign(Source);
end;

constructor TsuiTitleBarSection.Create(Collection: TCollection);
begin
    inherited;

    m_Picture := TPicture.Create();
    m_Width := 10;
    m_Align := suiLeft;
    m_Stretch := false;
    m_AutoSize := false;
end;

destructor TsuiTitleBarSection.Destroy;
begin
    m_Picture.Free();
    m_Picture := nil;

    inherited;
end;

procedure TsuiTitleBarSection.SetAlign(const Value: TsuiTitleBarAlign);
var
    i : Integer;
begin
    if Value = suiClient then
    begin
        for i := 0 to (Collection as TsuiTitleBarSections).Count - 1 do
        begin
            if (Collection as TsuiTitleBarSections).Items[i].Align = suiClient then
            begin
                MessageDlg('Sorry, only one section''s Align property can be "suiClient"', mtError, [mbOK], 0);
                Exit;
            end;
        end;

        m_Stretch := true;
    end;

    m_Align := Value;

    (Collection as TsuiTitleBarSections).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarSection.SetAutoSize(const Value: Boolean);
begin
    m_AutoSize := Value;

    if m_Picture.Graphic <> nil then
        m_Width := m_Picture.Width;
    (Collection as TsuiTitleBarSections).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarSection.SetPicture(const Value: TPicture);
begin
    m_Picture.Assign(Value);

    if Value <> nil then
        if m_AutoSize then
            m_Width := m_Picture.Width;

    (Collection as TsuiTitleBarSections).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarSection.SetStretch(const Value: Boolean);
begin
    m_Stretch := Value;

    if m_Align = suiClient then
        m_Stretch := true;

    (Collection as TsuiTitleBarSections).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarSection.SetWidth(const Value: Integer);
begin
    m_Width := Value;

    (Collection as TsuiTitleBarSections).m_TitleBar.Repaint();
end;

{ TsuiTitleBarSections }

function TsuiTitleBarSections.Add: TsuiTitleBarSection;
begin
    Result := inherited Add() as TsuiTitleBarSection;
end;

constructor TsuiTitleBarSections.Create(TitleBar: TsuiTitleBar);
begin
    Inherited Create(TsuiTitleBarSection);
    m_TitleBar := TitleBar;
end;

destructor TsuiTitleBarSections.Destroy;
begin
    m_TitleBar := nil;
    inherited;
end;

function TsuiTitleBarSections.GetItem(Index: Integer): TsuiTitleBarSection;
begin
    Result := inherited GetItem(Index) as TsuiTitleBarSection;
end;

function TsuiTitleBarSections.GetOwner: TPersistent;
begin
    Result := m_TitleBar;
end;

procedure TsuiTitleBarSections.SetItem(Index: Integer;
  Value: TsuiTitleBarSection);
begin
    inherited SetItem(Index, Value);
end;

procedure TsuiTitleBarSections.Update(Item: TCollectionItem);
begin
    inherited;

    m_TitleBar.Repaint();
end;

{ TsuiTitleBarButtons }

function TsuiTitleBarButtons.Add: TsuiTitleBarButton;
begin
    Result := inherited Add() as TsuiTitleBarButton;
end;

constructor TsuiTitleBarButtons.Create(TitleBar: TsuiTitleBar);
begin
    Inherited Create(TsuiTitleBarButton);
    m_TitleBar := TitleBar;
end;

function TsuiTitleBarButtons.GetItem(Index: Integer): TsuiTitleBarButton;
begin
    Result := inherited GetItem(Index) as TsuiTitleBarButton;
end;

function TsuiTitleBarButtons.GetOwner: TPersistent;
begin
    Result := m_TitleBar;
end;

procedure TsuiTitleBarButtons.SetItem(Index: Integer;
  Value: TsuiTitleBarButton);
begin
    inherited SetItem(Index, Value);
end;

procedure TsuiTitleBarButtons.Update(Item: TCollectionItem);
begin
    inherited;

    m_TitleBar.Repaint()
end;

{ TsuiTitleBarButton }

procedure TsuiTitleBarButton.Assign(Source: TPersistent);
begin
    if Source is TsuiTitleBarButton then
    begin
        Visible := TsuiTitleBarButton(Source).m_Visible;
        ButtonType := TsuiTitleBarButton(Source).m_ButtonType;
        Transparent := TsuiTitleBarButton(Source).m_Transparent;
        Top := TsuiTitleBarButton(Source).m_Top;
        UIStyle := TsuiTitleBarButton(Source).m_UIStyle;
        PicNormal.Assign(TsuiTitleBarButton(Source).m_PicNormal);
        PicMouseOn.Assign(TsuiTitleBarButton(Source).m_PicMouseOn);
        PicMouseDown.Assign(TsuiTitleBarButton(Source).m_PicMouseDown);
        ControlBoxMenu := TsuiTitleBarButton(Source).m_ControlBoxMenu;
    end
    else
        inherited Assign(Source);
end;

constructor TsuiTitleBarButton.Create(Collection: TCollection);
begin
    inherited;

    m_Visible := true;
    m_ButtonType := suiCustom;
    m_Transparent := false;
    m_Top := 2;

    m_PicNormal := TPicture.Create();
    m_PicMouseOn := TPicture.Create();
    m_PicMouseDown := TPicture.Create();

    UIStyle := SUI_THEME_DEFAULT;

    ControlBoxMenu := nil;
end;

destructor TsuiTitleBarButton.Destroy;
begin
    m_PicMouseDown.Free();
    m_PicMouseDown := nil;

    m_PicMouseOn.Free();
    m_PicMouseOn := nil;

    m_PicNormal.Free();
    m_PicNormal := nil;

    inherited;
end;

procedure TsuiTitleBarButton.DoClick;
var
    ParentForm : TCustomForm;
    Point : TPoint;
    WorkAreaRect : TRect;
begin
    if (Collection as TsuiTitleBarButtons).m_TitleBar = nil then
        Exit;

    ParentForm := GetParentForm((Collection as TsuiTitleBarButtons).m_TitleBar);
    if ParentForm = nil then
        Exit;

    case m_ButtonType of
        suiMax :
        begin
            if ParentForm.WindowState = wsMaximized then
                ParentForm.WindowState := wsNormal
            else
            begin
                ParentForm.WindowState := wsMaximized;
                if not (Collection as TsuiTitleBarButtons).m_TitleBar.InForm() then
                begin
                    WorkAreaRect := GetWorkAreaRect();
                    Dec(WorkAreaRect.Bottom);
                    Dec(WorkAreaRect.Top, 2);
                    Dec(WorkAreaRect.Left, 2);
                    Inc(WorkAreaRect.Right, 2);
                    PlaceControl(ParentForm, WorkAreaRect);
                end;
            end;
            ProcessMaxBtn();
        end;

        suiMin :
        begin
            if (Application <> nil) and (ParentForm = Application.MainForm) then
                SendMessage(Application.MainForm.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
            else
            begin
                //ShowWindow(ParentForm.Handle, SW_SHOWMINIMIZED);
                ParentForm.WindowState := wsMinimized;
            end;
        end;

        suiClose :
        begin
            ParentForm.Close();
        end;

        suiControlBox :
        begin
            if Assigned(m_ControlBoxMenu) then
            begin
                if ((Collection as TsuiTitleBarButtons).m_TitleBar.BidiMode = bdRightToLeft) and SysLocale.MiddleEast then
                    Point.X := 176
                else
                    Point.X := 0;
                Point.Y := (Collection as TsuiTitleBarButtons).m_TitleBar.Height;
                Point := (Collection as TsuiTitleBarButtons).m_TitleBar.ClientToScreen(Point);
                if Point.X < 0 then
                    Point.X := 0;
                m_ControlBoxMenu.Popup(Point.X, Point.Y);
            end;
        end;

        suiCustom :
        begin

        end;
    end; // case
end;

procedure TsuiTitleBarButton.ProcessMaxBtn;

    procedure InMAX(FileTheme : TsuiFileTheme);
    var
        OutUIStyle : TsuiUIStyle;
    begin
        if UsingFileTheme(FileTheme, m_UIStyle, OutUIStyle) then
        begin
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, 10);
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, 11);
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, 12);
        end
        else
        begin
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, 10);
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, 11);
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, 12);
        end;
    end;

    procedure InNormal(FileTheme : TsuiFileTheme);
    var
        OutUIStyle : TsuiUIStyle;
    begin
        if UsingFileTheme(FileTheme, m_UIStyle, OutUIStyle) then
        begin
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, 7);
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, 8);
            FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, 9);
        end
        else
        begin
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, 7);
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, 8);
            GetInsideThemeBitmap(OutUIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, 9);
        end;
    end;

var
    ParentForm : TCustomForm;
begin
    if ButtonType <> suiMax then
        Exit;

    if (Collection as TsuiTitleBarButtons).m_TitleBar.Custom then
        Exit;

    ParentForm := GetParentForm((Collection as TsuiTitleBarButtons).m_TitleBar);
    if ParentForm = nil then
    begin
        InNormal((Collection as TsuiTitleBarButtons).m_TitleBar.FileTheme);
        Exit;
    end;

    if ParentForm.WindowState = wsMaximized then
        InMax((Collection as TsuiTitleBarButtons).m_TitleBar.FileTheme)
    else
        InNormal((Collection as TsuiTitleBarButtons).m_TitleBar.FileTheme);
end;

procedure TsuiTitleBarButton.SetButtonType(const Value: TsuiTitleBarBtnType);
var
    i : Integer;
begin
    if Value = suiControlBox then
    begin
        for i := 0 to (Collection as TsuiTitleBarButtons).Count - 1 do
        begin
            if (Collection as TsuiTitleBarButtons).Items[i].ButtonType = suiControlBox then
            begin
                MessageDlg('Sorry, only one button''s ButtonType property can be "suiControlBox"', mtError, [mbOK], 0);
                Exit;
            end;
        end;
    end;

    m_ButtonType := Value;
    UpdateUIStyle();

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetPicMouseDown(const Value: TPicture);
begin
    m_PicMouseDown.Assign(Value);

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetPicMouseOn(const Value: TPicture);
begin
    m_PicMouseOn.Assign(Value);

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetPicNormal(const Value: TPicture);
begin
    m_PicNormal.Assign(Value);

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetTop(const Value: Integer);
begin
    m_Top := Value;

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetTransparent(const Value: Boolean);
begin
    m_Transparent := Value;

    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.SetUIStyle(const Value: TsuiUIStyle);
begin
    m_UIStyle := Value;

    UpdateUIStyle();
end;

procedure TsuiTitleBarButton.SetVisible(const Value: Boolean);
begin
    m_Visible := Value;
    (Collection as TsuiTitleBarButtons).m_TitleBar.Repaint();
end;

procedure TsuiTitleBarButton.UpdateFileTheme;
var
    nNormal : Integer;
    nMouseOn : Integer;
    nMouseDown : Integer;
    FileTheme : TsuiFileTheme;
begin
    FileTheme := (Collection as TsuiTitleBarButtons).m_TitleBar.FileTheme;

    Transparent := FileTheme.GetBool(SUI_THEME_TITLEBAR_BUTTON_TRANSPARENT_BOOL);

    case m_ButtonType of

    suiMax :
    begin
        nNormal := 7;
        nMouseOn := 8;
        nMouseDown := 9;
    end;

    suiMin :
    begin
        nNormal := 13;
        nMouseOn := 14;
        nMouseDown := 15;
    end;

    suiClose :
    begin
        nNormal := 16;
        nMouseOn := 17;
        nMouseDown := 18;
    end;

    suiHelp :
    begin
        nNormal := 4;
        nMouseOn := 5;
        nMouseDown := 6;
    end;

    suiControlBox :
    begin
        nNormal := 1;
        nMouseOn := 2;
        nMouseDown := 3;
    end;

    else Exit;

    end; // case

    FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, nNormal);
    FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, nMouseOn);
    FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, nMouseDown);

    Top := FileTheme.GetInt(SUI_THEME_TITLEBAR_BUTTON_TOP_INT);
end;

procedure TsuiTitleBarButton.UpdateInsideTheme(UIStyle : TsuiUIStyle);
var
    nNormal : Integer;
    nMouseOn : Integer;
    nMouseDown : Integer;
begin
    Transparent := GetInsideThemeBool(UIStyle, SUI_THEME_TITLEBAR_BUTTON_TRANSPARENT_BOOL);

    case m_ButtonType of

    suiMax :
    begin
        nNormal := 7;
        nMouseOn := 8;
        nMouseDown := 9;
    end;

    suiMin :
    begin
        nNormal := 13;
        nMouseOn := 14;
        nMouseDown := 15;
    end;

    suiClose :
    begin
        nNormal := 16;
        nMouseOn := 17;
        nMouseDown := 18;
    end;

    suiHelp :
    begin
        nNormal := 4;
        nMouseOn := 5;
        nMouseDown := 6;
    end;

    suiControlBox :
    begin
        nNormal := 1;
        nMouseOn := 2;
        nMouseDown := 3;
    end;

    else Exit;

    end; // case

    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicNormal.Bitmap, 18, nNormal);
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseOn.Bitmap, 18, nMouseOn);
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, PicMouseDown.Bitmap, 18, nMouseDown);

    Top := GetInsideThemeInt(UIStyle, SUI_THEME_TITLEBAR_BUTTON_TOP_INT);
end;

procedure TsuiTitleBarButton.UpdateUIStyle;
var
    OutUIStyle : TsuiUIStyle;
begin
    if UsingFileTheme((Collection as TsuiTitleBarButtons).m_TitleBar.FileTheme, m_UIStyle, OutUIStyle) then
        UpdateFileTheme()
    else
        UpdateInsideTheme(OutUIStyle);

    if m_ButtonType = suiMax then
        ProcessMaxBtn();
end;

procedure TsuiTitleBar.CMFONTCHANGED(var Msg: TMessage);
begin
    Repaint();
end;

procedure TsuiTitleBar.SetRoundCorner(const Value: Integer);
begin
    m_RoundCorner := Value;
end;

procedure TsuiTitleBar.WMNCLBUTTONDOWN(var Msg: TMessage);
begin
    Msg.Result := SendMessage(GetParentForm(Self).Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TsuiTitleBar.WMNCLBUTTONUP(var Msg: TMessage);
begin
    Msg.Result := SendMessage(GetParentForm(Self).Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TsuiTitleBar.WMNCMOUSEMOVE(var Msg: TMessage);
begin
    Msg.Result := SendMessage(GetParentForm(Self).Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TsuiTitleBar.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    m_SelfChanging := true;
    SetUIStyle(m_UIStyle);
    m_SelfChanging := false;
end;

procedure TsuiTitleBar.UpdateFileTheme;
var
    Sec : TsuiTitleBarSection;
    Form : TCustomForm;
    TempBmp : TBitmap;
begin
    Sec := Sections.Add();
    m_FileTheme.GetBitmap(SUI_THEME_TITLEBAR_LEFT_IMAGE, Sec.Picture.Bitmap);
    Sec.AutoSize := true;

    Sec := Sections.Add();
    m_FileTheme.GetBitmap(SUI_THEME_TITLEBAR_RIGHT_IMAGE, Sec.Picture.Bitmap);
    Sec.AutoSize := true;
    Sec.Align := suiRight;

    Sec := Sections.Add();
    m_FileTheme.GetBitmap(SUI_THEME_TITLEBAR_CLIENT_IMAGE, Sec.Picture.Bitmap);
    Sec.Align := suiClient;

    LeftBtnXOffset := m_FileTheme.GetInt(SUI_THEME_TITLEBAR_BUTTON_LEFTOFFSET_INT);
    RightBtnXOffset := m_FileTheme.GetInt(SUI_THEME_TITLEBAR_BUTTON_RIGHTOFFSET_INT);
    m_BorderColor := m_FileTheme.GetColor(SUI_THEME_FORM_BORDER_COLOR);
    TempBmp := TBitmap.Create();
    m_FileTheme.GetBitmap(SUI_THEME_TITLEBAR_BUTTON_IMAGE, TempBmp);
    m_BtnHeight := TempBmp.Height;
    TempBmp.Free();
    m_BtnTop := m_FileTheme.GetInt(SUI_THEME_TITLEBAR_BUTTON_TOP_INT);
    if Inform() then
        Dec(m_BtnTop, 3);

    Form := GetParentForm(self);
    if Form <> nil then
        Form.Constraints.MinWidth := m_FileTheme.GetInt(SUI_THEME_FORM_MINWIDTH_INT);

    m_RoundCorner := m_FileTheme.GetInt(SUI_THEME_FORM_ROUNDCORNER_INT);
    m_RoundCornerBottom := m_FileTheme.GetInt(SUI_THEME_FORM_BOTTOMROUNDCORNOR_INT);
end;

procedure TsuiTitleBar.UpdateInsideTheme(UIStyle : TsuiUIStyle);
var
    Sec : TsuiTitleBarSection;
    Form : TCustomForm;
    TempBmp : TBitmap;
begin
    Sec := Sections.Add();
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_LEFT_IMAGE, Sec.Picture.Bitmap);
    Sec.AutoSize := true;

    Sec := Sections.Add();
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_RIGHT_IMAGE, Sec.Picture.Bitmap);
    Sec.AutoSize := true;
    Sec.Align := suiRight;

    Sec := Sections.Add();
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_CLIENT_IMAGE, Sec.Picture.Bitmap);
    Sec.Align := suiClient;

    LeftBtnXOffset := GetInsideThemeInt(UIStyle, SUI_THEME_TITLEBAR_BUTTON_LEFTOFFSET_INT);
    RightBtnXOffset := GetInsideThemeInt(UIStyle, SUI_THEME_TITLEBAR_BUTTON_RIGHTOFFSET_INT);
    m_BorderColor := GetInsideThemeColor(UIStyle, SUI_THEME_FORM_BORDER_COLOR);
    TempBmp := TBitmap.Create();
    GetInsideThemeBitmap(UIStyle, SUI_THEME_TITLEBAR_BUTTON_IMAGE, TempBmp);
    m_BtnHeight := TempBmp.Height;
    TempBmp.Free();
    m_BtnTop := GetInsideThemeInt(UIStyle, SUI_THEME_TITLEBAR_BUTTON_TOP_INT);
    if Inform() then
        Dec(m_BtnTop, 3);

    Form := GetParentForm(self);
    if Form <> nil then
        Form.Constraints.MinWidth := GetInsideThemeInt(UIStyle, SUI_THEME_FORM_MINWIDTH_INT);

    m_RoundCorner := GetInsideThemeInt(UIStyle, SUI_THEME_FORM_ROUNDCORNER_INT);
    m_RoundCornerBottom := 0;
end;

procedure TsuiTitleBar.Notification(AComponent: TComponent;
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

end.
