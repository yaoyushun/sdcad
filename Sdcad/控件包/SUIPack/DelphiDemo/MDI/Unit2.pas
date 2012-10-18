unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, SUIMainMenu, ExtCtrls, SUIForm;

type
  TForm2 = class(TForm)
    suiForm1: TsuiForm;
    suiMainMenu1: TsuiMainMenu;
    MenuofForm21: TMenuItem;
    ShowMessage1: TMenuItem;
    procedure ShowMessage1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ShowMessage1Click(Sender: TObject);
begin
    ShowMessage('This is form2');
end;

end.
