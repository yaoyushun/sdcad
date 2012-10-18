unit YanTuMCTiHuan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormYanTuMCTiHuan = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cbo_Old: TComboBox;
    cbo_New: TComboBox;
    btn_cancel: TBitBtn;
    btn_ok: TBitBtn;
    procedure btn_okClick(Sender: TObject);
  private
    { Private declarations }
    m_TableName: string;
    procedure Get_EarthType;
  public
    procedure SetUpdateTableName(aTableName: string);
  end;

var
  FormYanTuMCTiHuan: TFormYanTuMCTiHuan;

implementation

uses MainDM, public_unit;

{$R *.dfm}

{ TFormYanTuMCTiHuan }

procedure TFormYanTuMCTiHuan.Get_EarthType;
begin
  cbo_Old.Clear;
  cbo_New.Clear;
  with MainDataModule.qryEarthType do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT ea_no,ea_name FROM earthtype ');  
      open;

      while not Eof do
      begin 
        cbo_Old.Items.Add(FieldByName('ea_name').AsString);
        cbo_New.Items.Add(FieldByName('ea_name').AsString);
        next;
      end;
      close;
    end;
end;

procedure TFormYanTuMCTiHuan.btn_okClick(Sender: TObject);
var
  strOldName, strNewName, strSQL: string;
begin
  strOldName := trim(cbo_Old.Text);
  strNewName := trim(cbo_New.Text);
  if strOldName ='' then exit;
  if strNewName = '' then exit;
  strSQL := 'UPDATE ' + m_TableName + ' SET '
    +' ea_name=' + '''' + strNewName + ''''
    +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
    +' AND ea_name =' +''''+strOldName + '''';
  Screen.Cursor := crHourGlass;
  if Update_oneRecord(MainDataModule.qryEarthSample,strSQL) then
  begin
      Screen.Cursor := crDefault;
      MessageBox(self.Handle,'更新成功！','系统提示',MB_OK);
  end;
  Screen.Cursor := crDefault;
end;

procedure TFormYanTuMCTiHuan.SetUpdateTableName(aTableName: string);
begin
  m_TableName := aTableName;
end;

end.
