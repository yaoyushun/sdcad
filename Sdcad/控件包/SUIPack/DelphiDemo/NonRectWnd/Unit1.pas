unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, SUISkinForm, SUIButton, SUISkinControl;

type
  TForm1 = class(TForm)
    suiSkinForm1: TsuiSkinForm;
    suiImageButton1: TsuiImageButton;
    suiSkinControl1: TsuiSkinControl;
    procedure suiImageButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.suiImageButton1Click(Sender: TObject);
begin
    ShowMessage('Hello!');
    Close();
end;

end.
