//  FastReport 2.4 demo.
//
//  Demonstrates how to create reports with no designer.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, FR_DSet, FR_DBSet, FR_Class, StdCtrls, FR_DCtrl;

type
  TForm1 = class(TForm)
    Button1: TButton;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    Table1: TTable;
    DataSource1: TDataSource;
    frDialogControls1: TfrDialogControls;
    procedure Button1Click(Sender: TObject);
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
var
  v: TfrView;
  b: TfrBandView;
  Page: TfrPage;
begin
  frReport1.Pages.Clear;
  frReport1.Pages.Add;              // create page
  Page := frReport1.Pages[0];

  b := TfrBandView.Create;             // create Title band
  b.SetBounds(0, 20, 0, 20);           // position and size in pixels
  b.BandType := btReportTitle;         // (only Top and Height are significant
  Page.Objects.Add(b);                 //  for the band)

  v := TfrMemoView.Create;             // create memo
  v.SetBounds(20, 20, 200, 16);
  v.BandAlign := baWidth;
  v.Prop['Alignment'] := frtaCenter;   // another way to access properties
  v.Prop['Font.Style'] := 2;
  v.Memo.Add('Your text is: [Edit1.Text]');
  Page.Objects.Add(v);

  b := TfrBandView.Create;             // create MasterData band
  b.SetBounds(0, 60, 0, 20);
  b.BandType := btMasterData;
  b.Dataset := 'frDBDataSet1';         // band's dataset
  Page.Objects.Add(b);

  v := TfrMemoView.Create;             // create data field
  v.SetBounds(20, 60, 200, 16);
  v.Memo.Add('[Table1."Company"]');
  Page.Objects.Add(v);

  frReport1.Pages.Add;              // create second page
  Page := frReport1.Pages[1];
  Page.PageType := ptDialog;
  Page.Width := 200;
  Page.Height := 170;
  Page.Caption := 'Test';

  v := TfrEditControl.Create;          // create editbox
  v.SetBounds(60, 50, 75, 21);
  v.Name := 'Edit1';
  Page.Objects.Add(v);

  v := TfrButtonControl.Create;        // create button
  v.SetBounds(60, 100, 75, 25);
  TfrButtonControl(v).Button.Caption := 'Test!';
  TfrButtonControl(v).Button.ModalResult := mrOk;
  Page.Objects.Add(v);

  frReport1.ShowReport;
end;


end.
