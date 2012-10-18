////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIStatusBar.pas
//  Creator     :   Shen Min
//  Date        :   2003-08-04 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIStatusBar;

interface

{$I SUIPack.inc}

uses Windows, ComCtrls, Graphics, Classes, Forms, Controls, Messages,
     SUIThemes, SUIMgr;

type
{$IFDEF SUIPACK_D6UP}
    TsuiStatusBar = class(TCustomStatusBar)
{$ENDIF}
{$IFDEF SUIPACK_D5}
    TsuiStatusBar = class(TStatusBar)
{$ENDIF}
    private
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;

        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        function GetPanelColor(): TColor;
        procedure SetPanelColor(const Value: TColor);
        procedure WMPaint(var Msg : TMessage); message WM_PAINT;
        procedure WMNCHITTEST(var Msg : TMessage); message WM_NCHITTEST;
    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
                
    public
        constructor Create(AOwner : TComponent); override;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property PanelColor : TColor read GetPanelColor write SetPanelColor;

        property Action;
        property AutoHint default False;
        property Align default alBottom;
        property Anchors;
        property BiDiMode;
        property BorderWidth;
        property Color default clBtnFace;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property Font {$IFDEF SUIPACK_D6UP}stored IsFontStored{$ENDIF};
        property Constraints;
        property Panels;
        property ParentBiDiMode;
        property ParentColor default False;
        property ParentFont default False;
        property ParentShowHint;
        property PopupMenu;
        property ShowHint;
        property SimplePanel default False;
        property SimpleText;
        property SizeGrip default True;
        property UseSystemFont default True;
        property Visible;
        property OnClick;
        property OnContextPopup;
{$IFDEF SUIPACK_D6UP}
        property OnCreatePanelClass;
{$ENDIF}
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnHint;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnResize;
        property OnStartDock;
        property OnStartDrag;
        property OnDrawPanel;

    end;

implementation

uses SUIPublic, SUIForm;

{ TsuiStatusBar }

constructor TsuiStatusBar.Create(AOwner: TComponent);
begin
    inherited;
//    ControlStyle := ControlStyle + [csAcceptsControls];
    UIStyle := GetSUIFormStyle(AOwner);
end;

function TsuiStatusBar.GetPanelColor: TColor;
begin
    Result := Color;
end;

procedure TsuiStatusBar.Notification(AComponent: TComponent;
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

procedure TsuiStatusBar.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiStatusBar.SetPanelColor(const Value: TColor);
begin
    Color := Value;
end;

procedure TsuiStatusBar.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
begin
    m_UIStyle := Value;
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
        PanelColor := m_FileTheme.GetColor(SUI_THEME_FORM_BACKGROUND_COLOR)
    else
        PanelColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_FORM_BACKGROUND_COLOR);
    Repaint();
end;

procedure TsuiStatusBar.WMNCHITTEST(var Msg: TMessage);
var
    Form : TCustomForm;
begin
    Form := GetParentForm(self);
    if (Form = nil) or (Form.WindowState <> wsMaximized) then
        inherited;
end;

procedure TsuiStatusBar.WMPaint(var Msg: TMessage);
var
    ParentForm : TCustomForm;
    R : TRect;    
begin
    inherited;

    ParentForm := GetParentForm(self);
    if ParentForm = nil then
        Exit;
    if ParentForm.BorderStyle <> bsSizeable then
        Exit;

    R := Rect(Width - 16, Height - 16, Width - 1, Height - 1);
    Canvas.Brush.Color := Color;
    Canvas.FillRect(R);
    if SizeGrip and (ParentForm.WindowState <> wsMaximized) then
    begin
        Inc(R.Top);
        Canvas.Pen.Color := clInactiveCaption;
        Canvas.Pen.Width := 1;
        Canvas.MoveTo(R.Left + 1, R.Bottom);
        Canvas.LineTo(R.Right, R.Top);
        Canvas.MoveTo(R.Left + 5, R.Bottom);
        Canvas.LineTo(R.Right, R.Top + 4);
        Canvas.MoveTo(R.Left + 9, R.Bottom);
        Canvas.LineTo(R.Right, R.Top + 8);
        Canvas.MoveTo(R.Left + 13, R.Bottom);
        Canvas.LineTo(R.Right, R.Top + 12);
    end;
    if Height - 16 > 3 then
    begin
        R := Rect(Width - 16, 3, Width - 1, Height - 16);
        Canvas.FillRect(R);
    end;
end;

end.
