unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, SUIMainMenu, ExtCtrls, SUIForm;

type
  TForm3 = class(TForm)
    suiForm1: TsuiForm;
    suiMainMenu1: TsuiMainMenu;
    FilemenuofForm31: TMenuItem;
    ShowMessage1: TMenuItem;
    procedure ShowMessage1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.ShowMessage1Click(Sender: TObject);
begin
    ShowMessage('This is form3');    
end;

end.
