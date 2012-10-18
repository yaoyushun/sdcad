////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   frmMessage.pas
//  Creator     :   Shen Min
//  Date        :   2003-03-31
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit frmMessage;

interface

{$I SUIPack.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SUIForm, clipbrd;

type
  TfrmMsg = class(TForm)
    suiForm1: TsuiForm;
    lbl: TLabel;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsg: TfrmMsg;

implementation

uses SUIButton;

{$R *.dfm}

procedure TfrmMsg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    TempStr : String;
    i : Integer;
    b : Boolean;
begin
    if (ssCtrl in Shift) and (Key = 67) then
    begin
        b := false;
        TempStr := '---------------------------' + #13#10;
        TempStr := TempStr + suiForm1.Caption + #13#10;
        TempStr := TempStr + '---------------------------' + #13#10;
        TempStr := TempStr + lbl.Caption + #13#10;
        TempStr := TempStr + '---------------------------' + #13#10;
        for i := 0 to ComponentCount - 1 do
        begin
            if Components[i] is TsuiButton then
            begin
                if b then
                    TempStr := TempStr + '   ';
                TempStr := TempStr + (Components[i] as TsuiButton).Caption;
                b := true;
            end;
        end;
        TempStr := TempStr + #13#10 + '---------------------------';

        Clipboard.Open();
        try
            Clipboard.SetTextBuf(Pchar(TempStr));
        finally
            Clipboard.Close();
        end;
    end;
end;

end.
