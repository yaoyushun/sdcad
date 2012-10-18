unit Main;

interface

uses
  Forms, DB, DBTables, Controls, Dialogs, Menus, Classes,
  ComCtrls, FR_Class, FR_DSet, FR_DBSet;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    frReport1: TfrReport;
    Table1: TTable;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Newpreviewwindow1: TMenuItem;
    Exit1: TMenuItem;
    Window1: TMenuItem;
    Tile1: TMenuItem;
    Cascade1: TMenuItem;
    frDBDataSet1: TfrDBDataSet;
    procedure Exit1Click(Sender: TObject);
    procedure Newpreviewwindow1Click(Sender: TObject);
    procedure Tile1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Newpreviewwindow1Click(Sender: TObject);
begin
  frReport1.ShowReport;
end;

procedure TMainForm.Tile1Click(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

end.

