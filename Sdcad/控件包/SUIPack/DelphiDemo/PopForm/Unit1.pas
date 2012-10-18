unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SUIForm, SUIButton, ExtCtrls;

type
  TForm1 = class(TForm)
    suiForm1: TsuiForm;
    suiButton1: TsuiButton;
    suiMSNPopForm1: TsuiMSNPopForm;
    suiButton2: TsuiButton;
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.suiButton1Click(Sender: TObject);
begin
    suiMSNPopForm1.Popup();
end;

procedure TForm1.suiButton2Click(Sender: TObject);
begin
    suiMSNPopForm1.Close();
end;

end.
