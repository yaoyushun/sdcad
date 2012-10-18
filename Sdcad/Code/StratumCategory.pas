unit StratumCategory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Menus, ExtCtrls;

type
  TStratumCategoryForm = class(TForm)
    PopupMenu1: TPopupMenu;
    gb92: TGroupBox;
    sg92: TStringGrid;
    gb02: TGroupBox;
    sg02: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sg92KeyPress(Sender: TObject; var Key: Char);
    procedure sg02KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure GetStratumCategory;
  public
    { Public declarations }
  end;

var
  StratumCategoryForm: TStratumCategoryForm;

implementation

uses MainDM;

{$R *.dfm}

procedure TStratumCategoryForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  sg92.RowCount := 2;
  sg92.ColCount := 3;
  sg92.ColWidths[0]:= 10;
  sg92.ColWidths[1]:= 40;
  sg92.ColWidths[2]:= 10000;
  sg92.Cells[1,0]:= '等级';
  sg92.Cells[2,0]:= '描述';

  sg02.RowCount := 2;
  sg02.ColCount := 3;
  sg02.ColWidths[0]:= 10;
  sg02.ColWidths[1]:= 40;
  sg02.ColWidths[2]:= 10000;
  sg02.Cells[1,0]:= '等级';
  sg02.Cells[2,0]:= '描述';

  GetStratumCategory;    
end;

procedure TStratumCategoryForm.GetStratumCategory;
var 
  i: integer;
begin
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT category,characters FROM stratumcategory92 ');  
      open;
      i:=0;
      while not Eof do
      begin
        i:=i+1;
        sg92.RowCount := i +2;
        sg92.RowCount := i +1;
        sg92.Cells[1,i] := FieldByName('category').AsString;
        sg92.Cells[2,i] := FieldByName('characters').AsString; 
        next;
      end;
      close;
    end;

  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT category,characters FROM stratumcategory02 ');  
      open;
      i:=0;
      while not Eof do
      begin
        i:=i+1;
        sg02.RowCount := i +2;
        sg02.RowCount := i +1;
        sg02.Cells[1,i] := FieldByName('category').AsString;
        sg02.Cells[2,i] := FieldByName('characters').AsString; 
        next;
      end;
      close;
    end;    
end;

procedure TStratumCategoryForm.sg92KeyPress(Sender: TObject;
  var Key: Char);
begin
  key:=#0;
end;

procedure TStratumCategoryForm.sg02KeyPress(Sender: TObject;
  var Key: Char);
begin
    key:=#0;
end;

end.
