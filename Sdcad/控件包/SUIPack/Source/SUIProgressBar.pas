////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIProgressBar.pas
//  Creator     :   Shen Min
//  Date        :   2002-05-27
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIProgressBar;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, ComCtrls,
     Graphics, Forms, Math,
     SUIPublic, SUIThemes, SUIMgr;

type
    TsuiProgressBarOrientation = (suiHorizontal, suiVertical);

    TsuiProgressBar = class(TCustomPanel)
    private
        m_Max : Integer;
        m_Min : Integer;
        m_Position : Integer;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;        
        m_Orientation : TsuiProgressBarOrientation;
        m_BorderColor : TColor;
        m_Color : TColor;
        m_Picture : TPicture;
        m_ShowCaption : Boolean;
        m_CaptionColor : TColor;
        m_SmartShowCaption : Boolean;

        procedure SetMax(const Value: Integer);
        procedure SetMin(const Value: Integer);
        procedure SetPosition(const Value: Integer);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetOrientation(const Value: TsuiProgressBarOrientation);
        procedure SetColor(const Value: TColor);
        procedure SetBorderColor(const Value: TColor);
        procedure SetPicture(const Value: TPicture);
        procedure SetShowCaption(const Value: Boolean);
        procedure SetCaptionColor(const Value: TColor);
        procedure SetSmartShowCaption(const Value: Boolean);
        procedure SetFileTheme(const Value: TsuiFileTheme);
        
        procedure UpdateProgress();
        procedure UpdatePicture();
        function GetWidthFromPosition(nWidth : Integer) : Integer;
        function GetPercentFromPosition() : Integer;
        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

    protected
        procedure Paint(); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;                

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        procedure StepBy(Delta : Integer);
        procedure StepIt();

    published
        property Anchors;
        property BiDiMode;
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;                    
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property CaptionColor : TColor read m_CaptionColor write SetCaptionColor;
        property ShowCaption : Boolean read m_ShowCaption write SetShowCaption;
        property SmartShowCaption : Boolean read m_SmartShowCaption write SetSmartShowCaption;
        property Max : Integer read m_Max write SetMax;
        property Min : Integer read m_Min write SetMin;
        property Position : Integer read m_Position write SetPosition;
        property Orientation : TsuiProgressBarOrientation read m_Orientation write SetOrientation;
        property BorderColor : TColor read m_BorderColor write SetBorderColor;
        property Color : TColor read m_Color write SetColor;
        property Picture : TPicture read m_Picture write SetPicture;
        property Visible;

        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        
        property OnClick;

    end;

implementation

uses SUIForm;

{ TsuiProgressBar }

constructor TsuiProgressBar.Create(AOwner: TComponent);
begin
    inherited;

    ControlStyle := ControlStyle - [csAcceptsControls];
    m_Picture := TPicture.Create();

    m_Min := 0;
    m_Max := 100;
    m_Position := 50;
    m_Orientation := suiHorizontal;
    m_BorderColor := clBlack;
    m_Color := clBtnFace;
    m_CaptionColor := clBlack;

    Height := 12;
    Width := 150;
    Caption := '50%';
    m_ShowCaption := true;
    Color := clBtnFace;

    UIStyle := GetSUIFormStyle(AOwner);

    UpdateProgress();
end;

destructor TsuiProgressBar.Destroy;
begin
    m_Picture.Free();
    m_Picture := nil;

    inherited;
end;

function TsuiProgressBar.GetPercentFromPosition: Integer;
begin
    if m_Max <> m_Min then
        Result := 100 * (m_Position - m_Min) div (m_Max - m_Min)
    else
        Result := 0;
end;

function TsuiProgressBar.GetWidthFromPosition(nWidth : Integer): Integer;
begin
    Result := 0;

    if (
        (m_Max <= m_Min) or
        (m_Position <= m_Min)
    ) then
        Exit;

    Result := nWidth;
    if m_Position > m_Max then
        Exit;

    Result := (m_Position - m_Min) * nWidth div (m_Max - m_Min);
end;

procedure TsuiProgressBar.Notification(AComponent: TComponent;
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

procedure TsuiProgressBar.Paint;
var
    nProgressWidth : Integer;
    Buf : TBitmap;
    R : TRect;
begin
    Buf := TBitmap.Create();
    Buf.Width := ClientWidth;
    Buf.Height := ClientHeight;

    if m_Orientation = suiHorizontal then
    begin
        nProgressWidth := GetWidthFromPosition(Buf.Width - 1);
        if nProgressWidth = 0 then
            Inc(nProgressWidth);

        if m_Picture.Graphic <> nil then
        begin
            R := Rect(1, 1, nProgressWidth, Buf.Height - 1);
            Buf.Canvas.StretchDraw(R, m_Picture.Graphic);
        end;

        Buf.Canvas.Brush.Color := m_Color;
        R := Rect(nProgressWidth, 1, Buf.Width - 1, Buf.Height - 1);
        Buf.Canvas.FillRect(R);
    end
    else
    begin
        nProgressWidth := Buf.Height - 1 - GetWidthFromPosition(Buf.Height - 1);
        if nProgressWidth = 0 then
            Inc(nProgressWidth);

        if m_Picture.Graphic <> nil then
        begin
            R := Rect(1, Buf.Height - 2, Buf.Width - 1, nProgressWidth - 1);
            Buf.Canvas.StretchDraw(R, m_Picture.Graphic);
        end;

        Buf.Canvas.Brush.Color := m_Color;
        R := Rect(1, nProgressWidth, Buf.Width - 1, 1);
        Buf.Canvas.FillRect(R);
        m_ShowCaption := false;
    end;

    if m_ShowCaption then
    begin
        Buf.Canvas.Font.Color := m_CaptionColor;
        Buf.Canvas.Brush.Style := bsClear;
        if m_SmartShowCaption and (m_Position = m_Min) then
        else
            Buf.Canvas.TextOut(((Buf.Width - Buf.Canvas.TextWidth(Caption)) div 2), (Buf.Height - Buf.Canvas.TextHeight(Caption)) div 2, Caption);
    end;
    
    Buf.Canvas.Brush.Color := m_BorderColor;
    Buf.Canvas.FrameRect(ClientRect);

    BitBlt(Canvas.Handle, 0, 0, Buf.Width, Buf.Height, Buf.Canvas.Handle, 0, 0, SRCCOPY);
    Buf.Free();
end;

procedure TsuiProgressBar.SetBorderColor(const Value: TColor);
begin
    m_BorderColor := Value;

    Repaint();
end;

procedure TsuiProgressBar.SetCaptionColor(const Value: TColor);
begin
    m_CaptionColor := Value;

    Repaint();
end;

procedure TsuiProgressBar.SetColor(const Value: TColor);
begin
    m_Color := Value;

    Repaint();
end;

procedure TsuiProgressBar.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiProgressBar.SetMax(const Value: Integer);
begin
    m_Max := Value;

    UpdateProgress();
end;

procedure TsuiProgressBar.SetMin(const Value: Integer);
begin
    m_Min := Value;

    UpdateProgress();
end;

procedure TsuiProgressBar.SetOrientation(
  const Value: TsuiProgressBarOrientation);
begin
    m_Orientation := Value;

    UpdatePicture();
end;

procedure TsuiProgressBar.SetPicture(const Value: TPicture);
begin
    m_Picture.Assign(Value);

    Repaint();
end;

procedure TsuiProgressBar.SetPosition(const Value: Integer);
begin
    m_Position := Value;

    UpdateProgress();
end;

procedure TsuiProgressBar.SetShowCaption(const Value: Boolean);
begin
    m_ShowCaption := Value;

    Repaint();
end;

procedure TsuiProgressBar.SetSmartShowCaption(const Value: Boolean);
begin
    m_SmartShowCaption := Value;

    Repaint();
end;

procedure TsuiProgressBar.SetUIStyle(const Value: TsuiUIStyle);
begin
    m_UIStyle := Value;

    UpdatePicture();
end;

procedure TsuiProgressBar.StepBy(Delta: Integer);
begin
    Position := Position + Delta;
end;

procedure TsuiProgressBar.StepIt;
begin
    Position := Position + 1;
end;

procedure TsuiProgressBar.UpdatePicture;
var
    OutUIStyle : TsuiUIStyle;
    TempBuf : TBitmap;
begin
    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        m_FileTheme.GetBitmap(SUI_THEME_PROGRESSBAR_IMAGE, m_Picture.Bitmap);
        Color := m_FileTheme.GetColor(SUI_THEME_CONTROL_BACKGROUND_COLOR);
        BorderColor := m_FileTheme.GetColor(SUI_THEME_CONTROL_BORDER_COLOR);
    end
    else
    begin
        GetInsideThemeBitmap(OutUIStyle, SUI_THEME_PROGRESSBAR_IMAGE, m_Picture.Bitmap);
        Color := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BACKGROUND_COLOR);
        BorderColor := GetInsideThemeColor(OutUIStyle, SUI_THEME_CONTROL_BORDER_COLOR);
    end;

    if m_Orientation = suiVertical then
    begin
        TempBuf := TBitmap.Create();
        TempBuf.Assign(m_Picture.Bitmap);
        RoundPicture(TempBuf);
        m_Picture.Bitmap.Assign(TempBuf);
        TempBuf.Free();
    end;

    Repaint();
end;

procedure TsuiProgressBar.UpdateProgress;
begin
    Caption := IntToStr(GetPercentFromPosition()) + '%';

    Repaint();
end;

procedure TsuiProgressBar.WMERASEBKGND(var Msg: TMessage);
begin
    // Do nothing
end;

end.
