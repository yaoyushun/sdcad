////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIURLLabel.pas
//  Creator     :   Shen Min
//  Date        :   2002-07-22
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIURLLabel;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics,
     ShellAPI;

type
    TsuiURLLabel = class(TCustomLabel)
    private
        m_Cursor : TCursor;
        m_URL : TCaption;
        m_HoverColor : TColor;
        m_LinkColor : TColor;

        procedure OnMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
        procedure OnMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
        procedure SetLinkColor(const Value: TColor);
        procedure SetURL(value : TCaption);

    protected
        procedure Click(); override;

    public
        constructor Create(AOwner: TComponent); override;

    published
        property Anchors;
        property BiDiMode;            
        property Caption;
        property AutoSize;
        property Color;
        property Enabled;
        property ShowHint;
        property Transparent;
        property Visible;
        property WordWrap;
        property PopupMenu;

        property Cursor read m_Cursor;
        property URL : TCaption read m_URL write SetURL;
        property FontHoverColor : TColor read m_HoverColor write m_HoverColor;
        property FontLinkColor : TColor read m_LinkColor write SetLinkColor;
        property Font;

        property OnClick;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;

    end;

implementation

uses SUIPublic;


{ TsuiURLLabel }

procedure TsuiURLLabel.Click;
begin
    if Trim(m_URL) <> '' then
        ShellExecute(0, 'open', PChar(m_URL), nil, nil, SW_SHOW);

    inherited;
end;

constructor TsuiURLLabel.Create(AOwner: TComponent);
begin
    inherited;

    Font.Style := [fsUnderline];
    Font.Color := clBlue;
    inherited Cursor := crHandPoint;
    m_Cursor := inherited Cursor;
    AutoSize := true;
    m_HoverColor := clRed;
    m_LinkColor := clBlue;

    Caption := 'Welcome to Sunisoft';
    URL := 'http://www.sunisoft.com';
end;

procedure TsuiURLLabel.OnMouseEnter(var Msg: TMessage);
begin
    if csDesigning in ComponentState then
    begin
        Font.Color := clBlue;
        Exit;
    end;

    Font.Color := m_HoverColor;
end;

procedure TsuiURLLabel.OnMouseLeave(var Msg: TMessage);
begin
    Font.Color := m_LinkColor;
end;

procedure TsuiURLLabel.SetLinkColor(const Value: TColor);
begin
    m_LinkColor := Value;

    Font.Color := m_LinkColor;
end;

procedure TsuiURLLabel.SetURL(value: TCaption);
begin
    if value <> m_URL then
        m_URL := value;
end;

end.
