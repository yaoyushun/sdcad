unit OtherCharges92;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, Grids, DBGrids, ADODB, ExtCtrls;

type
  TFOtherCharges92 = class(TForm)
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    Label1: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    ST_Others: TStaticText;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery1AfterPost(DataSet: TDataSet);
    procedure ADOQuery1BeforeScroll(DataSet: TDataSet);
    procedure ADOQuery1AfterDelete(DataSet: TDataSet);
    procedure ADOQuery1AfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOtherCharges92: TFOtherCharges92;

implementation
uses MainDM,public_unit;
{$R *.dfm}

procedure TFOtherCharges92.FormCreate(Sender: TObject);
var
   i:integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

StaticText1.caption:=g_ProjectInfo.prj_no ;
StaticText2.caption:=g_ProjectInfo.prj_name  ;
try
   ADOQuery1.Close;
   ADOQuery1.SQL.Text :='select * from othercharge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+'''';
   ADOQuery1.Open ;
except
   application.MessageBox(TABLE_ERROR,HINT_TEXT);
   exit;
end;
   for i:=2 to 5 do
      dbgrid1.Columns[i-2].Field :=ADOQuery1.Fields[i];
   ADOQuery1AfterPost(ADOQuery1);
end;

procedure TFOtherCharges92.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TFOtherCharges92.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=cafree;
end;

procedure TFOtherCharges92.ADOQuery1AfterPost(DataSet: TDataSet);
begin
   try
      ADOQuery2.Close ;
      ADOQuery2.SQL.Text:='select sum(OC_Money) as sMoney from Othercharge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+'''';
      ADOQuery2.Open ;
   except
      application.MessageBox(TABLE_ERROR,HINT_TEXT);
      exit;
   end;
   ST_Others.Caption := formatfloat('0.00',ADOQuery2.fieldbyname('sMoney').AsFloat);
end;

procedure TFOtherCharges92.ADOQuery1BeforeScroll(DataSet: TDataSet);
begin
   if ADOQuery1.RecordCount<1 then exit;
   ADOQuery1.Edit;
   ADOQuery1.FieldByName('OC_money').AsFloat :=ADOQuery1.fieldbyname('OC_Method').AsFloat*ADOQuery1.fieldbyname('OC_UPrice').AsFloat;
   ADOQuery1.Post ;
end;

procedure TFOtherCharges92.ADOQuery1AfterDelete(DataSet: TDataSet);
begin
    ADOQuery1AfterPost(DataSet);
end;

procedure TFOtherCharges92.ADOQuery1AfterInsert(DataSet: TDataSet);
begin
   ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
end;

end.
