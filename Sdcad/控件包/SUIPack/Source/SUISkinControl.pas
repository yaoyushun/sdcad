////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUISkinControl.pas
//  Creator     :   Shen Min
//  Date        :   2002-09-16
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUISkinControl;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, Graphics;

type
    TsuiSkinControl = class(TComponent)
    private
        m_Control : TWinControl;
        m_Glyph : TBitmap;
        m_Color : TColor;
        m_OnRegionChanged : TNotifyEvent;

        procedure SetColor(const Value: TColor);
        procedure SetControl(const Value: TWinControl);
        procedure SetPicture(const Value: TBitmap);

        procedure ReSetWndRgn();

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;

    published
        property Control : TWinControl read m_Control write SetControl;
        property Glyph : TBitmap read m_Glyph write SetPicture;
        property TransparentColor : TColor read m_Color write SetColor;

        property OnRegionChanged : TNotifyEvent read m_OnRegionChanged write m_OnRegionChanged;

    end;


implementation

uses SUIPublic;


{ TsuiSkinControl }

constructor TsuiSkinControl.Create(AOwner: TComponent);
begin
    inherited;

    m_Glyph := TBitmap.Create();
    m_Color := clFuchsia;
    m_Control := nil;
end;

destructor TsuiSkinControl.Destroy;
begin
    m_Glyph.Free();
    m_Glyph := nil;

    inherited;
end;

procedure TsuiSkinControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if (
        (Operation = opRemove) and
        (AComponent = m_Control)
    )then
        m_Control := nil;
end;

procedure TsuiSkinControl.ReSetWndRgn;
begin
    if (
        (m_Glyph.Empty) or
        (not Assigned(m_Control))
    ) then
        Exit;

    SetBitmapWindow(m_Control.Handle, m_Glyph, m_Color);

    if (
        (m_Glyph.Height <> 0) and
        (m_Glyph.Width <> 0)
    ) then
    begin
        m_Control.Height := m_Glyph.Height;
        m_Control.Width := m_Glyph.Width;
    end;

    if Assigned(m_OnRegionChanged) then
        m_OnRegionChanged(self);
end;

procedure TsuiSkinControl.SetColor(const Value: TColor);
begin
    m_Color := Value;
    ReSetWndRgn();
end;

procedure TsuiSkinControl.SetControl(const Value: TWinControl);
begin
    m_Control := Value;
    ReSetWndRgn();
end;

procedure TsuiSkinControl.SetPicture(const Value: TBitmap);
begin
    m_Glyph.Assign(Value);
    ReSetWndRgn();
end;

end.
