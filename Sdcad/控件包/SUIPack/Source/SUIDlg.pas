////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIDlg.pas
//  Creator     :   Shen Min
//  Date        :   2003-03-31 V1-V3
//                  2003-07-14 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIDlg;

interface

{$I SUIPack.inc}

uses Controls, Classes, Math, Forms, Dialogs, Graphics, SysUtils,
     SUIThemes, SUIMgr;

type
    TsuiDialogButtonsCount = 1..3;
    TsuiIconType = (suiNone, suiWarning, suiStop, suiInformation, suiHelp);

type
    TsuiDialog = class(TComponent)
    private
        m_Position : TPosition;
        m_Caption : TCaption;
        m_ButtonCursor : TCursor;
        m_UIStyle : TsuiUIStyle;
        m_FileTheme : TsuiFileTheme;
        m_Font : TFont;
        m_CaptionFont : TFont;

        procedure SetFileTheme(const Value: TsuiFileTheme);
        procedure SetUIStyle(const Value: TsuiUIStyle);
        procedure SetFont(const Value: TFont);
        procedure SetCaptionFont(const Value: TFont);

    protected
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;
        property ButtonCursor : TCursor read m_ButtonCursor write m_ButtonCursor;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;
        
        function ShowModal : TModalResult; virtual; abstract;

    published
        property FileTheme : TsuiFileTheme read m_FileTheme write SetFileTheme;
        property Position : TPosition read m_Position write m_Position;
        property Caption : TCaption read m_Caption write m_Caption;
        property UIStyle : TsuiUIStyle read m_UIStyle write SetUIStyle;
        property Font : TFont read m_Font write SetFont;
        property CaptionFont : TFont read m_CaptionFont write SetCaptionFont;

    end;

    TsuiMessageDialog = class(TsuiDialog)
    private
        m_ButtonCount : TsuiDialogButtonsCount;
        m_Button1Caption : TCaption;
        m_Button2Caption : TCaption;
        m_Button3Caption : TCaption;
        m_Button1ModalResult : TModalResult;
        m_Button2ModalResult : TModalResult;
        m_Button3ModalResult : TModalResult;
        m_IconType : TsuiIconType;
        m_Text : String;

    public
        constructor Create(AOwner : TComponent); override;
        function ShowModal : TModalResult; override;

    published
        property ButtonCursor;
        property ButtonCount : TsuiDialogButtonsCount read m_ButtonCount write m_ButtonCount;
        property Button1Caption : TCaption read m_Button1Caption write m_Button1Caption;
        property Button2Caption : TCaption read m_Button2Caption write m_Button2Caption;
        property Button3Caption : TCaption read m_Button3Caption write m_Button3Caption;
        property Button1ModalResult : TModalResult read m_Button1ModalResult write m_Button1ModalResult;
        property Button2ModalResult : TModalResult read m_Button2ModalResult write m_Button2ModalResult;
        property Button3ModalResult : TModalResult read m_Button3ModalResult write m_Button3ModalResult;
        property IconType : TsuiIconType read m_IconType write m_IconType;
        property Text : String read m_Text write m_Text;

    end;

    TsuiPasswordDialog = class(TsuiDialog)
    private
        m_ButtonCancelCaption: TCaption;
        m_ButtonOKCaption: TCaption;
        m_Item1Caption: TCaption;
        m_Item1PasswordChar: Char;
        m_Item2Caption: TCaption;
        m_Item2PasswordChar: Char;
        m_Item1Text : String;
        m_Item2Text : String;

    public
        constructor Create(AOwner : TComponent); override;
        function ShowModal : TModalResult; override;

    published
        property Item1Caption : TCaption read m_Item1Caption write m_Item1Caption;
        property Item2Caption : TCaption read m_Item2Caption write m_Item2Caption;
        property Item1PasswordChar : Char read m_Item1PasswordChar write m_Item1PasswordChar;
        property Item2PasswordChar : Char read m_Item2PasswordChar write m_Item2PasswordChar;
        property Item1Text : String read m_Item1Text write m_Item1Text;
        property Item2Text : String read m_Item2Text write m_Item2Text;
        property ButtonOKCaption : TCaption read m_ButtonOKCaption write m_ButtonOKCaption;
        property ButtonCancelCaption : TCaption read m_ButtonCancelCaption write m_ButtonCancelCaption;
        property ButtonCursor;
    end;

    TsuiInputDialog = class(TsuiDialog)
    private
        m_ButtonCancelCaption: TCaption;
        m_ButtonOKCaption: TCaption;
        m_PromptText : String;
        m_ValueText : String;
        m_PasswordChar : Char;

    public
        constructor Create(AOwner : TComponent); override;
        function ShowModal : TModalResult; override;

    published
        property PasswordChar : Char read m_PasswordChar write m_PasswordChar;
        property PromptText : String read m_PromptText write m_PromptText;
        property ValueText : String read m_ValueText write m_ValueText;
        property ButtonOKCaption : TCaption read m_ButtonOKCaption write m_ButtonOKCaption;
        property ButtonCancelCaption : TCaption read m_ButtonCancelCaption write m_ButtonCancelCaption;
        property ButtonCursor;
    end;

    function SUIMsgDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; UIStyle : TsuiUIStyle = SUI_THEME_DEFAULT): TModalResult; overload;
    function SUIMsgDlg(const Msg, Caption : String; DlgType : TMsgDlgType; Buttons: TMsgDlgButtons; UIStyle : TsuiUIStyle = SUI_THEME_DEFAULT) : TModalResult; overload;

implementation

uses frmPassword, frmMessage, frmInput, SUIButton, SUIResDef, SUIPublic;

//function SUIMsgDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; UIStyle : TsuiUIStyle = SUI_THEME_DEFAULT): TModalResult;
//var
//    MsgDlg : TsuiMessageDialog;
//begin
//    MsgDlg := TsuiMessageDialog.Create(nil);
//    MsgDlg.UIStyle := UIStyle;
//    MsgDlg.Text := Msg;
//
//    case DlgType of
//    mtWarning : MsgDlg.IconType := suiWarning;
//    mtError : MsgDlg.IconType := suiStop;
//    mtInformation : MsgDlg.IconType := suiInformation;
//    mtConfirmation : MsgDlg.IconType := suiHelp;
//    mtCustom : MsgDlg.IconType := suiNone;
//    end; // case
//
//    //mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp
//
//    Result := MsgDlg.ShowModal();
//    MsgDlg.Free();
//end;

function SUIMsgDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; UIStyle : TsuiUIStyle = SUI_THEME_DEFAULT): TModalResult;
begin
    if Assigned(Application) then
        Result := SUIMsgDlg(Msg, Application.Title, DlgType, Buttons, UIStyle)
    else
        Result := SUIMsgDlg(Msg, 'Default', DlgType, Buttons, UIStyle)
end;

function SUIMsgDlg(const Msg, Caption : String; DlgType : TMsgDlgType; Buttons: TMsgDlgButtons; UIStyle : TsuiUIStyle = SUI_THEME_DEFAULT) : TModalResult;
var
    MsgDlg : TsuiMessageDialog;
    B: TMsgDlgBtn;
    bc: String;
    bmr: TModalResult;
    btnCnt: Integer;
begin
    MsgDlg := TsuiMessageDialog.Create(nil);
    MsgDlg.Text := Msg;

    btnCnt := 0;
    bmr := mrOK;

    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    begin
      if B in Buttons then
      begin
        inc(btnCnt);

        case B of
          //ESTABLISH BUTTON CAPTION
          mbOk:    begin bc := 'Ok'; bmr := mrOK end;
          mbYes:   begin bc := 'Yes'; bmr := mrYes end;
          mbNo:    begin bc := 'No'; bmr := mrNo end;
          mbYesToAll:  begin bc := 'Yes to All'; bmr := mrYesToAll end;
          mbNoToAll:   begin bc := 'No to All'; bmr := mrNoToAll end;
          mbAbort:  begin bc := 'Abort'; bmr := mrAbort end;
          mbCancel: begin bc := 'Cancel'; bmr := mrCancel end;
          mbRetry:  begin bc := 'Retry'; bmr := mrRetry end;
          mbIgnore: begin bc := 'Ignore'; bmr := mrIgnore end;
          mbAll:    begin bc := 'All'; bmr := mrAll; end;
          //mbHelp:   begin bc := 'Help'; bmr := mrHelp end;

        end;

        Case btnCnt of
          //ESTABLISH BUTTON RESULT
          1:  begin MsgDlg.Button1Caption := bc; MsgDlg.Button1ModalResult := bmr; end;
          2:  begin MsgDlg.Button2Caption := bc; MsgDlg.Button2ModalResult := bmr; end;
          3:  begin MsgDlg.Button3Caption := bc; MsgDlg.Button3ModalResult := bmr; end;
        end;

      end;
    end;

    MsgDlg.ButtonCount := btnCnt;

    case DlgType of
    mtWarning : MsgDlg.IconType := suiWarning;
    mtError : MsgDlg.IconType := suiStop;
    mtInformation : MsgDlg.IconType := suiInformation;
    mtConfirmation : MsgDlg.IconType := suiHelp;
    mtCustom : MsgDlg.IconType := suiNone;
    end; // case

    //mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp

    MsgDlg.UIStyle := UIStyle;
    MsgDlg.Caption := Caption;
    Result := MsgDlg.ShowModal();
    MsgDlg.Free();
end;

{ TsuiDialog }

constructor TsuiDialog.Create(AOwner: TComponent);
begin
    inherited;

    m_Caption := 'suiDialog';
    m_Position := poScreenCenter;
    m_ButtonCursor := crHandPoint;
    m_UIStyle := SUI_THEME_DEFAULT;

    m_Font := TFont.Create();
    m_CaptionFont := TFont.Create();
    m_CaptionFont.Color := clWhite;
    m_CaptionFont.Name := 'Tahoma';
    m_CaptionFont.Style := [fsBold];

    UIStyle := GetSUIFormStyle(AOwner);
end;

destructor TsuiDialog.Destroy;
begin
    m_CaptionFont.Free();
    m_CaptionFont := nil;

    m_Font.Free();
    m_Font := nil;

    inherited;
end;

procedure TsuiDialog.Notification(AComponent: TComponent;
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

procedure TsuiDialog.SetCaptionFont(const Value: TFont);
begin
    m_CaptionFont.Assign(Value);
end;

procedure TsuiDialog.SetFileTheme(const Value: TsuiFileTheme);
begin
    m_FileTheme := Value;
    SetUIStyle(m_UIStyle);
end;

procedure TsuiDialog.SetFont(const Value: TFont);
begin
    m_Font.Assign(Value);
end;

procedure TsuiDialog.SetUIStyle(const Value: TsuiUIStyle);
var
    OutUIStyle : TsuiUIStyle;
    Tmp : Integer;
begin
    m_UIStyle := Value;

    if UsingFileTheme(m_FileTheme, m_UIStyle, OutUIStyle) then
    begin
        Tmp := m_FileTheme.GetColor(SUI_THEME_TITLEBAR_FONT_COLOR);
        if Tmp = -1 then
        begin
            Tmp := m_FileTheme.GetColor(SUI_THEME_CONTROL_FONT_COLOR);
            if (Tmp = 65536) or (Tmp = 262144) or (Tmp = 196608) or (Tmp = 327680) then
                m_CaptionFont.Color := clBlack
            else
                m_CaptionFont.Color := clWhite;
        end
        else
            m_CaptionFont.Color := Tmp;
    end
    else
    begin
{$IFDEF RES_MACOS}    
        if m_UIStyle = MacOS then
            m_CaptionFont.Color := clBlack
        else
{$ENDIF}        
            m_CaptionFont.Color := clWhite;
    end;
end;

{ TsuiMessageDialog }

constructor TsuiMessageDialog.Create(AOwner: TComponent);
begin
    inherited;

    ButtonCount := 1;
    Button1Caption := 'OK';
    Button2Caption := 'Cancel';
    Button3Caption := 'Cancel';

    Button1ModalResult := mrOK;
    Button2ModalResult := mrCancel;
    Button3ModalResult := mrCancel;

    m_Text := 'Hello world!';
end;

function TsuiMessageDialog.ShowModal: TModalResult;
var
    Dlg : TfrmMsg;
    i : Integer;
    Btn : TsuiButton;
    lblHeight : Integer;
    btnleft : Integer;
    TmpBmp : TBitmap;
begin
    Dlg := TfrmMsg.Create(Application);

    Dlg.Font.Assign(m_Font);

    Dlg.lbl.Caption := m_Text;
    lblheight := Max(Dlg.Image1.BoundsRect.Bottom, Dlg.lbl.BoundsRect.Bottom);

    if m_IconType <> suiNone then
    begin
        Dlg.lbl.Left := 88;
        TmpBmp := TBitmap.Create();
        TmpBmp.LoadFromResourceName(hInstance, 'MSGDLG');
        SpitBitmap(TmpBmp, Dlg.Image1.Picture.Bitmap, 4, Ord(m_IconType));
        TmpBmp.Free()
    end
    else
    begin
        Dlg.lbl.Left := 24;
        Dlg.Image1.Visible := false;
        if m_ButtonCount < 3 then
            Dlg.Width := Dlg.Width - 64;
    end;

    btnleft := Dlg.Width - 73 - 24;
    for i := m_ButtonCount downto 1 do
    begin
        Btn := TsuiButton.Create(Dlg);
        Btn.Parent := Dlg.suiForm1;
        Btn.Top := lblheight + 20;
        Btn.Height := 25;
        Btn.Width := 73;
        Btn.Cursor := m_ButtonCursor;
        Btn.Left := btnLeft;
        Btn.TabStop := true;
        Btn.TabOrder := 1;
        Dec(btnLeft, 73 + 20);
        case i of
        1 :
        begin
            Btn.Caption := Button1Caption;
            Btn.ModalResult := Button1ModalResult;
            Dlg.ActiveControl := Btn;            
        end;
        2 :
        begin
            Btn.Caption := Button2Caption;
            Btn.ModalResult := Button2ModalResult;
            Dlg.ActiveControl := Btn;
        end;
        3:
        begin
            Btn.Caption := Button3Caption;
            Btn.ModalResult := Button3ModalResult;
            Dlg.ActiveControl := Btn;
        end;
        end;

        if Btn.ModalResult = mrCancel then
        begin
            Btn.Cancel := true;
            Btn.Default := false;
        end
        else if Btn.ModalResult = mrOk then
        begin
            Btn.Cancel := false;
            Btn.Default := true;
        end
        else
        begin
            Btn.Cancel := false;
            Btn.Default := false;
        end;
    end;

    Dlg.Height := lblheight + 20 + 25 + 20;
    Dlg.Position := m_Position;
    Dlg.suiForm1.ReAssign();

    Dlg.suiForm1.Caption := m_Caption;
    Dlg.suiForm1.UIStyle := m_UIStyle;
    Dlg.suiForm1.FileTheme := m_FileTheme;
    Dlg.suiForm1.Font.Assign(m_CaptionFont);

    Result := Dlg.ShowModal();
    Dlg.Free();
end;

{ TsuiPasswordDialog }

constructor TsuiPasswordDialog.Create(AOwner: TComponent);
begin
    inherited;

    Item1Caption := 'User name:';
    Item2Caption := 'Password:';
    Item1PasswordChar := #0;
    Item2PasswordChar := '*';
    Item1Text := '';
    Item2Text := '';
    ButtonOKCaption := 'OK';
    ButtonCancelCaption := 'Cancel';
end;

function TsuiPasswordDialog.ShowModal: TModalResult;
var
    Dlg : TfrmPass;
    lblLength : Integer;
begin
    Dlg := TfrmPass.Create(Application);

    Dlg.Font.Assign(m_Font);
    Dlg.lbl1.Caption := m_Item1Caption;
    Dlg.lbl2.Caption := m_Item2Caption;
    Dlg.edt1.Text := m_Item1Text;
    Dlg.edt2.Text := m_Item2Text;
    lblLength := Max(Dlg.lbl1.Width, Dlg.lbl2.Width);

    Dlg.edt1.Left := Dlg.lbl1.Left + lblLength + 5;
    Dlg.edt2.Left := Dlg.edt1.Left;
    Dlg.edt1.PasswordChar := m_Item1PasswordChar;
    Dlg.edt2.PasswordChar := m_Item2PasswordChar;
    Dlg.btn1.Caption := m_ButtonOKCaption;
    Dlg.btn1.Default := true;
    Dlg.btn2.Caption := m_ButtonCancelCaption;
    Dlg.btn2.Cancel := true;

    Dlg.Width := Dlg.edt1.Left + Dlg.edt1.Width + 24;
    Dlg.Position := m_Position;
    Dlg.suiForm1.ReAssign();

    Dlg.btn1.Left := Dlg.Width div 2 - 8 - Dlg.btn1.Width;
    Dlg.btn2.Left := Dlg.Width div 2 + 8;
    Dlg.btn1.Cursor := ButtonCursor;
    Dlg.btn2.Cursor := ButtonCursor;

    Dlg.suiForm1.Caption := m_Caption;
    Dlg.suiForm1.UIStyle := m_UIStyle;
    Dlg.suiForm1.FileTheme := m_FileTheme;
    Dlg.suiForm1.Font.Assign(m_CaptionFont);

    Result := Dlg.ShowModal();
    if Result = mrOK then
    begin
        m_Item1Text := Dlg.edt1.Text;
        m_Item2Text := Dlg.edt2.Text;
    end;
    Dlg.Free();
end;

{ TsuiInputDialog }

constructor TsuiInputDialog.Create(AOwner: TComponent);
begin
    inherited;

    PromptText := 'Prompt text:';
    ValueText := '';
    ButtonOKCaption := 'OK';
    ButtonCancelCaption := 'Cancel';
end;

function TsuiInputDialog.ShowModal: TModalResult;
var
    Dlg : TfrmInput;
begin
    Dlg := TfrmInput.Create(Application);

    Dlg.Font.Assign(m_Font);
    Dlg.lbl_prompt.Caption := m_PromptText;
    Dlg.edt_value.Text := m_ValueText;
    Dlg.edt_value.PasswordChar := m_PasswordChar;

    Dlg.btn1.Caption := m_ButtonOKCaption;
    Dlg.btn1.Default := true;
    Dlg.btn2.Caption := m_ButtonCancelCaption;
    Dlg.btn2.Cancel := true;

    Dlg.Position := m_Position;
    Dlg.suiForm1.ReAssign();

    Dlg.btn1.Left := Dlg.Width div 2 - 8 - Dlg.btn1.Width;
    Dlg.btn2.Left := Dlg.Width div 2 + 8;
    Dlg.btn1.Cursor := ButtonCursor;
    Dlg.btn2.Cursor := ButtonCursor;

    Dlg.suiForm1.Caption := m_Caption;
    Dlg.suiForm1.UIStyle := m_UIStyle;
    Dlg.suiForm1.FileTheme := m_FileTheme;
    Dlg.suiForm1.Font.Assign(m_CaptionFont);
    
    Result := Dlg.ShowModal();
    if Result = mrOK then
        m_ValueText := Dlg.edt_value.Text;
    Dlg.Free();
end;

end.
