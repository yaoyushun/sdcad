unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, SUIURLLabel, StdCtrls, ExtCtrls, jpeg;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    suiURLLabel1: TsuiURLLabel;
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Image1Click(Sender: TObject);
begin
    ModalResult := mrOK;
end;

end.
