unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Ctrls, FR_View, ExtCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    frPreview1: TfrPreview;
    frSpeedButton1: TfrSpeedButton;
    frSpeedButton2: TfrSpeedButton;
    frSpeedButton3: TfrSpeedButton;
    frSpeedButton4: TfrSpeedButton;
    frSpeedButton5: TfrSpeedButton;
    frSpeedButton6: TfrSpeedButton;
    frSpeedButton7: TfrSpeedButton;
    frSpeedButton8: TfrSpeedButton;
    frSpeedButton9: TfrSpeedButton;
    frSpeedButton10: TfrSpeedButton;
    frSpeedButton11: TfrSpeedButton;
    procedure frSpeedButton4Click(Sender: TObject);
    procedure frSpeedButton5Click(Sender: TObject);
    procedure frSpeedButton6Click(Sender: TObject);
    procedure frSpeedButton7Click(Sender: TObject);
    procedure frSpeedButton8Click(Sender: TObject);
    procedure frSpeedButton9Click(Sender: TObject);
    procedure frSpeedButton10Click(Sender: TObject);
    procedure frSpeedButton1Click(Sender: TObject);
    procedure frSpeedButton2Click(Sender: TObject);
    procedure frSpeedButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure frSpeedButton11Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.frSpeedButton4Click(Sender: TObject);
begin
  frPreview1.First;
end;

procedure TForm3.frSpeedButton5Click(Sender: TObject);
begin
  frPreview1.Prev;
end;

procedure TForm3.frSpeedButton6Click(Sender: TObject);
begin
  frPreview1.Next;
end;

procedure TForm3.frSpeedButton7Click(Sender: TObject);
begin
  frPreview1.Last;
end;

procedure TForm3.frSpeedButton8Click(Sender: TObject);
begin
  frPreview1.LoadFromFile;
end;

procedure TForm3.frSpeedButton9Click(Sender: TObject);
begin
  frPreview1.SaveToFile;
end;

procedure TForm3.frSpeedButton10Click(Sender: TObject);
begin
  frPreview1.Print;
end;

procedure TForm3.frSpeedButton1Click(Sender: TObject);
begin
  frPreview1.OnePage;
end;

procedure TForm3.frSpeedButton2Click(Sender: TObject);
begin
  frPreview1.Zoom := 100;
end;

procedure TForm3.frSpeedButton3Click(Sender: TObject);
begin
  frPreview1.PageWidth;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  frSpeedButton2.Down := True;
  frSpeedButton2Click(nil);
end;

procedure TForm3.frSpeedButton11Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frPreview1.Window.FormKeyDown(Sender, Key, Shift);
end;

end.
