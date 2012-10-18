unit UCategory02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFrmCategory02 = class(TForm)
    BitBtn1: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Bevel5: TBevel;
    Bevel8: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel9: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Label14: TLabel;
    Memo4: TMemo;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    Memo9: TMemo;
    Memo10: TMemo;
    Memo11: TMemo;
    Memo18: TMemo;
    Memo19: TMemo;
    Memo20: TMemo;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCategory02: TFrmCategory02;

implementation

{$R *.dfm}

procedure TFrmCategory02.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TFrmCategory02.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action:=cafree;
end;

procedure TFrmCategory02.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

end;

end.
