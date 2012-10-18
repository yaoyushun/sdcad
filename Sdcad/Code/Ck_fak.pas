unit Ck_fak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TCk_fakForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtJcmzsd: TEdit;
    edtTzd: TEdit;
    cbJcdmkd: TComboBox;
    edtTjqpjzd: TEdit;
    edtFa: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure cbJcdmkdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtJcmzsdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtJcmzsdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cbJcdmkdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ck, mb,md,mc: double;
  end;

var
  Ck_fakForm: TCk_fakForm;

implementation

uses public_unit;

{$R *.dfm}

procedure TCk_fakForm.cbJcdmkdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TCk_fakForm.edtJcmzsdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TCk_fakForm.edtJcmzsdKeyPress(Sender: TObject; var Key: Char);
begin
  NumberKeyPress(Sender,Key,false);
end;

procedure TCk_fakForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;

procedure TCk_fakForm.cbJcdmkdClick(Sender: TObject);
begin
  if isFloat(trim(edtJcmzsd.Text)) and isFloat(trim(edtTzd.Text)) 
    and isFloat(trim(edtTjqpjzd.Text)) then
  begin
    edtfa.Text := FormatFloat('0',mb * strtofloat(edtTzd.Text) * strtofloat(cbJcdmkd.Text)
      + md * strtofloat(edtTjqpjzd.Text) * strtofloat(edtJcmzsd.Text)
      + mc * ck) ;
  end;
end;

end.
