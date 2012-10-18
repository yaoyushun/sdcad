// FastReport 2.4 demo
//
// Enduser demo

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, FR_Class;

type
  TForm1 = class(TForm)
    Tree1: TTreeView;
    ImageList1: TImageList;
    Image1: TImage;
    Label4: TLabel;
    DesignBtn: TButton;
    PreviewBtn: TButton;
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure Tree1Change(Sender: TObject; Node: TTreeNode);
    procedure DesignBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
  private
    { Private declarations }
    WPath: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

uses Unit2;

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  WPath := ExtractFilePath(ParamStr(0));
  Tree1.Items[0].Expand(True);
  Tree1.Selected := Tree1.Items[0].Item[0];
  Tree1.TopItem := Tree1.Items[0];
end;

procedure TForm1.Tree1Change(Sender: TObject; Node: TTreeNode);
var
  n: Integer;
begin
  n := Node.StateIndex;
  if n = -1 then
  begin
    Memo1.Text := '';
    DesignBtn.Enabled := False;
    PreviewBtn.Enabled := False;
    Exit;
  end;
  with Form2.frReport1 do
  begin
    LoadFromFile(WPath + IntToStr(n) + '.frf');
    if Dictionary.Variables.IndexOf('Description') <> - 1 then
      Memo1.Text := Dictionary.Variables['Description'] else
      Memo1.Text := '';
    DesignBtn.Enabled := True;
    PreviewBtn.Enabled := True;
  end;
end;

procedure TForm1.DesignBtnClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := Tree1.Selected;
  if (Node = nil) or (Node.StateIndex = -1) then Exit;
  with Form2 do
  begin
    frReport1.LoadFromFile(WPath + IntToStr(Node.StateIndex) + '.frf');
    frReport1.DesignReport;
  end;
end;

procedure TForm1.PreviewBtnClick(Sender: TObject);
var
  n: Integer;
  Node: TTreeNode;
begin
  Node := Tree1.Selected;
  if (Node = nil) or (Node.StateIndex = -1) then Exit;
  n := Node.StateIndex;
  with Form2 do
  begin
    frReport1.LoadFromFile(WPath + IntToStr(n) + '.frf');
    frReport1.ShowReport;
  end;
end;

end.
