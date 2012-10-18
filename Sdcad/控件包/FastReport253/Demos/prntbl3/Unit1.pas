// FastReport 2.4 demo
//
// This example demonstrates how to use TfrPrintTable component

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_PTabl, DB, DBTables, ExtCtrls, FR_Desgn;

type
  TForm1 = class(TForm)
    Table1: TTable;
    Button1: TButton;
    frDesigner1: TfrDesigner;
    frPrintTable1: TfrPrintTable;
    procedure Button1Click(Sender: TObject);
    procedure frPrintTable1PrintColumn(ColumnNo: Integer;
      var Width: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  frPrintTable1.ShowReport;
end;

procedure TForm1.frPrintTable1PrintColumn(ColumnNo: Integer;
  var Width: Integer);
begin
  if ColumnNo = 3 then
    Width := 70;
end;

end.
