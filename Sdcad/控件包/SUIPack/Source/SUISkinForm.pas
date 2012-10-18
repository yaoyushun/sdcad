////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUISkinForm.pas
//  Creator     :   Shen Min
//  Date        :   2002-08-06
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUISkinForm;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Forms, Graphics, Controls;

type
    TsuiSkinForm = class(TGraphicControl)
    private
        m_Form : TForm;
        m_Picture : TBitmap;
        m_Color: TColor;
        m_OnRegionChanged : TNotifyEvent;
        m_OnPaint : TNotifyEvent;

        procedure SetColor(const Value: TColor);
        procedure SetPicture(const Value: TBitmap);
        procedure ReSetWndRgn();
        procedure WMERASEBKGND(var Msg : TMessage); message WM_ERASEBKGND;

    protected
        procedure Paint(); override;
        procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

        property Canvas;

    published
        property Glyph : TBitmap read m_Picture write SetPicture;
        property TransparentColor : TColor read m_Color write SetColor;
        property PopupMenu;
        property Cursor;

        property OnRegionChanged : TNotifyEvent read m_OnRegionChanged write m_OnRegionChanged;
        property OnPaint : TNotifyEvent read m_OnPaint write m_OnPaint;
        property OnClick;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnStartDock;
        property OnStartDrag;
    end;

implementation

uses SUIPublic;

{ TsuiSkinForm }

constructor TsuiSkinForm.Create(AOwner: TComponent);
begin
    inherited;

    if not (AOwner is TForm) then
        Exit;
    m_Form := AOwner as TForm;

    if not (csDesigning in ComponentState) then
        m_Form.BorderStyle := bsNone;

    m_Picture := TBitmap.Create();
    m_Color := clFuchsia;
    Width := 200;
    Height := 100;
end;

destructor TsuiSkinForm.Destroy;
begin
    m_Picture.Free();
    m_Picture := nil;

    inherited;
end;

procedure TsuiSkinForm.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
    inherited;
    
    ReleaseCapture();
    m_Form.PerForm(WM_NCLBUTTONDOWN, HTCAPTION, 0);
end;

procedure TsuiSkinForm.Paint;
begin
    if (m_Picture.Width <> 0) and (m_Picture.Height <> 0) then
        Canvas.Draw(0, 0, m_Picture)
    else
    begin
        Canvas.Brush.Color := clBlack;
        Canvas.FrameRect(ClientRect);
    end;

    if assigned(m_OnPaint) then
        m_OnPaint(self);
end;

procedure TsuiSkinForm.ReSetWndRgn;
begin
    if m_Picture.Empty then
        Exit;

    if not (csDesigning in ComponentState) then
        SetBitmapWindow(m_Form.Handle, m_Picture, m_Color);

    if (
        (m_Picture.Height <> 0) and
        (m_Picture.Width <> 0)
    ) then
    begin
        Height := m_Picture.Height;
        Width := m_Picture.Width;
    end;

    Top := 0;
    Left := 0;

    m_Form.ClientHeight := Height;
    m_Form.ClientWidth := Width;

    if Assigned(m_OnRegionChanged) then
        m_OnRegionChanged(self);   
end;

procedure TsuiSkinForm.SetColor(const Value: TColor);
begin
    m_Color := Value;

    ReSetWndRgn();
    Repaint();
end;

procedure TsuiSkinForm.SetPicture(const Value: TBitmap);
begin
    m_Picture.Assign(Value);

    ReSetWndRgn();
    RePaint();
end;

procedure TsuiSkinForm.WMERASEBKGND(var Msg: TMessage);
begin
    // do nothing
end;

end.
