unit YanTuMiaoShu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls,
  DB;

type
  TYanTuMiaoShuForm = class(TForm)
    Gbox: TGroupBox;
    sgEarth: TStringGrid;
    gbox2: TGroupBox;
    lblD_t_name: TLabel;
    Label1: TLabel;
    edtMiaoShu: TEdit;
    cboLeiXing: TComboBox;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure sgEarthSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_editClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow:integer);
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function GetExistedSQL(aLeiXing: string; aMiaoShu: string): string;
    function Check_Data:boolean;
  public
    { Public declarations }
  end;

var
  YanTuMiaoShuForm: TYanTuMiaoShuForm;
  m_DataSetState: TDataSetState;
implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TYanTuMiaoShuForm.button_status(int_status: integer;
  bHaveRecord: boolean);
begin
  case int_status of
    1: //浏览状态
      begin
        btn_edit.Enabled :=bHaveRecord;
        btn_delete.Enabled :=bHaveRecord;
        btn_edit.Caption :='修改';
        btn_ok.Enabled :=false;
        btn_add.Enabled :=true;
        Enable_Components(self,false);
        m_DataSetState := dsBrowse;
      end;
    2: //修改状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        m_DataSetState := dsEdit;
      end;
    3: //增加状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        m_DataSetState := dsInsert;
      end;
  end;
end;

function TYanTuMiaoShuForm.Check_Data: boolean;
begin
  if trim(edtMiaoShu.Text) = '' then
  begin
    messagebox(self.Handle,'请输入岩土描述！','数据校对',mb_ok);
    edtMiaoShu.SetFocus;
    result := false;
    exit;
  end;
  result := true;
end;

procedure TYanTuMiaoShuForm.FormCreate(Sender: TObject);
var
  i: integer;
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgEarth.RowHeights[0] := 16;
  sgEarth.Cells[1,0] := '岩土描述';  
  sgEarth.ColWidths[0]:=10;
  sgEarth.ColWidths[1]:=125;

  Clear_Data(self);
  SetCBWidth(cboLeiXing);
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT LeiXing,MiaoShu FROM earth_desc');
      open;
      i:=0;
      sgEarth.Tag :=1;
      while not Eof do
        begin
          i:=i+1;
          sgEarth.RowCount := i +1;
          sgEarth.Cells[1,i] := FieldByName('MiaoShu').AsString;  
          sgEarth.Cells[2,i] := FieldByName('LeiXing').AsString;
          Next ;
        end;
      close;
      sgEarth.Tag :=0;
    end;
  if i>0 then
  begin
    sgEarth.Row :=1;
    Get_oneRecord(1);
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TYanTuMiaoShuForm.Get_oneRecord(aRow:integer);
begin
  if sgEarth.Cells[2,sgEarth.Row]='' then exit;
  edtMiaoShu.Text := sgEarth.Cells[1,aRow];
  cboLeiXing.ItemIndex := StrToInt(sgEarth.Cells[2,aRow]);
end;

function TYanTuMiaoShuForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM earth_desc WHERE LeiXing='+ ''''+inttostr(cboLeiXing.ItemIndex)+''''
          +' AND MiaoShu='+''''+sgEarth.Cells[1,sgEarth.Row]+'''' ;
end;

function TYanTuMiaoShuForm.GetInsertSQL: string;
begin
  result := 'INSERT INTO earth_desc (LeiXing,MiaoShu) VALUES('
            +''''+inttostr(cboLeiXing.ItemIndex)+''''+','
            +''''+trim(edtMiaoShu.Text)+''')';
end;

function TYanTuMiaoShuForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE LeiXing='+''''+sgEarth.Cells[2,sgEarth.Row]+''''
               +' AND MiaoShu='+''''+sgEarth.Cells[1,sgEarth.Row]+'''' ;
  strSQLSet:='UPDATE earth_desc SET '; 
  strSQLSet := strSQLSet + 'LeiXing' +'='+''''+inttostr(cboLeiXing.ItemIndex)+''''+',';
  strSQLSet := strSQLSet + 'MiaoShu' +'='+''''+trim(edtMiaoShu.Text)+'''';
  result := strSQLSet + strSQLWhere;

end;

procedure TYanTuMiaoShuForm.sgEarthSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if sgEarth.Tag =1 then exit;
  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
    if sgEarth.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow);
      if sgEarth.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
    begin
      clear_data(self);
    end;
end;

procedure TYanTuMiaoShuForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin
    Button_status(2,true);
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    Get_oneRecord(sgEarth.Row);
  end;
end;

procedure TYanTuMiaoShuForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  if not Check_Data then exit;
  if m_DataSetState = dsInsert then
    begin
      strSQL := GetExistedSQL(IntToStr(cboLeiXing.ItemIndex),trim(edtMiaoShu.Text));
      if isExistedRecord(MainDataModule.qryPublic,strSQL) then
      begin
        MessageBox(application.Handle,PAnsiChar('记录已经存在，不能保存。'),'数据库错误',MB_OK+MB_ICONERROR);
        edtMiaoShu.SetFocus;
        exit;
      end;      
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryPublic,strSQL) then
        begin
          if (sgEarth.RowCount =2) and (sgEarth.Cells[1,1] ='') then
          else              
            sgEarth.RowCount := sgEarth.RowCount+1;
          sgEarth.Cells[1,sgEarth.RowCount-1] := trim(edtMiaoShu.Text);
          sgEarth.Cells[2,sgEarth.RowCount-1] := IntToStr(cboLeiXing.ItemIndex);
          sgEarth.Row := sgEarth.RowCount-1;
          Button_status(1,true);
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      if (sgEarth.Cells[1,sgEarth.Row]<>trim(edtMiaoShu.Text)) 
        or (sgEarth.Cells[2,sgEarth.Row]<>IntToStr(cboLeiXing.ItemIndex)) then
      begin
        strSQL := GetExistedSQL(IntToStr(cboLeiXing.ItemIndex),trim(edtMiaoShu.Text));
        if isExistedRecord(MainDataModule.qryPublic,strSQL) then
        begin
          MessageBox(application.Handle,'记录已经存在，不能保存。','数据库错误',MB_OK+MB_ICONERROR);
          edtMiaoShu.SetFocus;
          exit;
        end;
      end;
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryPublic,strSQL) then
        begin
          sgEarth.Cells[1,sgEarth.Row] := trim(edtMiaoShu.Text) ;
          sgEarth.Cells[2,sgEarth.Row] := IntToStr(cboLeiXing.ItemIndex);
          Button_status(1,true);
          btn_add.SetFocus;
        end;      
    end;
end;

function TYanTuMiaoShuForm.GetExistedSQL(aLeiXing,
  aMiaoShu: string): string;
begin
  Result:='SELECT LeiXing,MiaoShu FROM earth_desc '
    + ' WHERE LeiXing='+''''+aLeiXing+''''
    +' AND MiaoShu=' +''''+aMiaoShu+'''';
end;

procedure TYanTuMiaoShuForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
  cboLeiXing.ItemIndex := 1;
  edtMiaoShu.SetFocus;
end;

procedure TYanTuMiaoShuForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtMiaoShu.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryPublic,strSQL) then
        begin
          Clear_Data(self);  
          DeleteStringGridRow(sgEarth,sgEarth.Row);
          if sgEarth.Cells[1,sgEarth.row]<>'' then
          begin
            Get_oneRecord(sgEarth.Row);
            button_status(1,true);
          end
          else
            button_status(1,false);
        end;
    end;

end;

procedure TYanTuMiaoShuForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TYanTuMiaoShuForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
