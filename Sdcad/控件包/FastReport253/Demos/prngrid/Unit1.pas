// FastReport 2.4
//
// Demonstrates how to print array-like data (3 different methods)

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, FR_DSet, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    RowDataset: TfrUserDataset;
    ColDataset: TfrUserDataset;
    frReport1: TfrReport;
    frReport2: TfrReport;
    Button3: TButton;
    Dataset: TfrUserDataset;
    frReport3: TfrReport;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: string;
      var ParValue: Variant);
    procedure frReport2GetValue(const ParName: string;
      var ParValue: Variant);
    procedure frReport3GetValue(const ParName: string;
      var ParValue: Variant);
    procedure Button3Click(Sender: TObject);
    procedure DatasetCheckEOF(Sender: TObject; var Eof: Boolean);
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
  ColDataset.RangeEnd := reCount;
  ColDataset.RangeEndCount := StringGrid1.ColCount;
  RowDataset.RangeEnd := reCount;
  RowDataset.RangeEndCount := StringGrid1.RowCount;
  frReport1.ShowReport;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RowDataset.RangeEnd := reCount;
  RowDataset.RangeEndCount := StringGrid1.RowCount;
  frReport2.ShowReport;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  frReport3.ShowReport;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 0 to StringGrid1.ColCount - 1 do
    for j := 0 to StringGrid1.RowCount - 1 do
      StringGrid1.Cells[i, j] := IntToStr(j * StringGrid1.ColCount + i + 1);
end;

procedure TForm1.frReport1GetValue(const ParName: string;
  var ParValue: Variant);
begin
  if AnsiCompareText(ParName, 'Cell') = 0 then
    ParValue := StringGrid1.Cells[ColDataset.RecNo, RowDataset.RecNo];
end;

procedure TForm1.frReport2GetValue(const ParName: string;
  var ParValue: Variant);
begin
  if AnsiCompareText(ParName, 'Cell1') = 0 then
    ParValue := StringGrid1.Cells[0, RowDataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell2') = 0 then
    ParValue := StringGrid1.Cells[1, RowDataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell3') = 0 then
    ParValue := StringGrid1.Cells[2, RowDataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell4') = 0 then
    ParValue := StringGrid1.Cells[3, RowDataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell5') = 0 then
    ParValue := StringGrid1.Cells[4, RowDataset.RecNo]
end;

procedure TForm1.frReport3GetValue(const ParName: string;
  var ParValue: Variant);
begin
  if AnsiCompareText(ParName, 'Cell1') = 0 then
    ParValue := StringGrid1.Cells[0, Dataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell2') = 0 then
    ParValue := StringGrid1.Cells[1, Dataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell3') = 0 then
    ParValue := StringGrid1.Cells[2, Dataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell4') = 0 then
    ParValue := StringGrid1.Cells[3, Dataset.RecNo]
  else if AnsiCompareText(ParName, 'Cell5') = 0 then
    ParValue := StringGrid1.Cells[4, Dataset.RecNo]
end;

procedure TForm1.DatasetCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof := Dataset.RecNo >= StringGrid1.RowCount;
end;

end.
