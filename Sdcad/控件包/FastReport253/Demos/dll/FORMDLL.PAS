unit FormDLL;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DBTables, DB, FR_DSet, FR_DBSet, FR_Class,
  ExtCtrls;

type
  TfrmDLL = class(TForm)
    btnBioLifePrintPreview: TButton;
    frReport1: TfrReport;
    Table1: TTable;
    frDBDataSet1: TfrDBDataSet;
    procedure btnBioLifePrintPreviewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function ShowForm: Bool; StdCall;


implementation

{$R *.DFM}

{------------------------------------------------------------------------}

function ShowForm: Bool;
var
  Form1: TfrmDLL;
begin
  Form1 := TfrmDLL.Create(nil);
  try
    Result := (Form1.ShowModal = mrOK);
  finally
    Form1.Free;
  end;
end;

procedure TfrmDLL.btnBioLifePrintPreviewClick(Sender: TObject);
begin
  frReport1.ShowReport;
end;

procedure TfrmDLL.FormActivate(Sender: TObject);
begin
  Session.Active := True;
end;

procedure TfrmDLL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Session.Active := False;
end;

end.
