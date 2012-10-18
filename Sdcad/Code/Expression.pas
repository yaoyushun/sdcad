unit Expression;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TExpressForm = class(TForm)
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExpressForm: TExpressForm;

implementation

{$R *.dfm}

procedure TExpressForm.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TExpressForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=cafree;
end;

procedure TExpressForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

end;

end.
