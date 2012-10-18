unit Borer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, DB, ExtCtrls;

type
  TBorerTypeForm = class(TForm)
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    gb1: TGroupBox;
    lblBorer_name: TLabel;
    edtBorer_name: TEdit;
    gb2: TGroupBox;
    sgBorer: TStringGrid;
    procedure btn_editClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure edtBorer_nameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgBorerSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cancelClick(Sender: TObject);

  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow:Integer);
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function Check_Data:boolean;
    function GetExistedSQL(aBorerName: string):string;
  public
    { Public declarations }
  end;

var
  BorerTypeForm: TBorerTypeForm;
  m_sgBorerSelectedRow: integer;
  m_DataSetState: TDataSetState;
implementation

uses MainDM, public_unit;

{$R *.dfm}

{ TBorerTypeForm }

procedure TBorerTypeForm.button_status(int_status: integer;
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

function TBorerTypeForm.Check_Data: boolean;
begin
  if trim(edtBorer_name.Text) = '' then
  begin
    messagebox(self.Handle,'请输入类别名称！','数据校对',mb_ok);
    edtBorer_name.SetFocus;
    result := false;
    exit;
  end;
  result := true;
end;

procedure TBorerTypeForm.Get_oneRecord(aRow: Integer);
begin
  edtBorer_name.Text := sgBorer.Cells[2,aRow];
end;

function TBorerTypeForm.GetDeleteSQL: string;
begin
    result :='DELETE FROM borer WHERE borer_no='+ ''''+sgBorer.Cells[1,sgBorer.row]+'''';
end;

function TBorerTypeForm.GetExistedSQL(aBorerName: string): string;
begin
  Result:='SELECT borer_no,borer_name FROM borer WHERE borer_name='+ ''''+aBorerName+'''';
end;

function TBorerTypeForm.GetInsertSQL: string;
begin
  result := 'INSERT INTO Borer (Borer_name) VALUES('
            +''''+trim(edtBorer_name.Text)+''''+')';
end;

function TBorerTypeForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE Borer_no='+''''+sgBorer.Cells[1,sgBorer.Row]+'''';
  strSQLSet:='UPDATE drill_type SET '; 
  strSQLSet := strSQLSet + 'borer_name' +'='+''''+trim(edtBorer_name.Text)+''''; 
  result := strSQLSet + strSQLWhere;
end;



procedure TBorerTypeForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    edtBorer_name.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    self.Get_oneRecord(sgBorer.Row);
  end;
end;

procedure TBorerTypeForm.btn_okClick(Sender: TObject);
var
  strSQL: string; 
begin
  if not Check_Data then exit;
  strSQL := self.GetExistedSQL(trim(edtBorer_name.Text)); 
  if isExistedRecord(MainDataModule.qryBorer,strSQL) then exit;
  if m_DataSetState = dsInsert then
    begin
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryBorer,strSQL) then
        begin
          if (sgBorer.RowCount =2) and (sgBorer.Cells[1,1] ='') then
            begin
              m_sgBorerSelectedRow:= sgBorer.RowCount-1;
              sgBorer.Cells[1,sgBorer.RowCount-1] := '1';
            end
          else
            begin
              m_sgBorerSelectedRow := sgBorer.RowCount;
              sgBorer.RowCount := sgBorer.RowCount+1;
              sgBorer.Cells[1,sgBorer.RowCount-1] := inttostr(strtoint(sgBorer.Cells[1,sgBorer.RowCount-2])+1);
            end;
          sgBorer.Cells[2,sgBorer.RowCount-1] := trim(edtBorer_name.Text);
          sgBorer.Row := sgBorer.RowCount-1;
          Button_status(1,true);
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryBorer,strSQL) then
        begin
          sgBorer.Cells[2,sgBorer.Row] := edtBorer_name.Text ;
          Button_status(1,true);
          btn_add.SetFocus;
        end;      
    end;

end;

procedure TBorerTypeForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
  edtBorer_name.SetFocus;
end;

procedure TBorerTypeForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtBorer_name.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryBorer,strSQL) then
        begin
          Clear_Data(self);  
          DeleteStringGridRow(sgBorer,sgBorer.Row);
          
          if sgBorer.Cells[1,sgBorer.row]='' then
            button_status(1,false)
          else begin
            self.Get_oneRecord(sgBorer.Row);
            button_status(1,true);
          end
        end;
    end;
end;

procedure TBorerTypeForm.edtBorer_nameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  change_focus(key,self);  
end;

procedure TBorerTypeForm.sgBorerSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow <>0) and (ARow<>m_sgBorerSelectedRow) then
    if sgBorer.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow);
      if sgBorer.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
  m_sgBorerSelectedRow:=ARow;
end;

procedure TBorerTypeForm.FormCreate(Sender: TObject);
var
  i: integer;
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgBorer.RowHeights[0] := 16;
  sgBorer.Cells[1,0] := '类别代码';  
  sgBorer.Cells[2,0] := '类别名称';
  sgBorer.ColWidths[0]:=10;
  sgBorer.ColWidths[1]:=80;
  sgBorer.ColWidths[2]:=125;
  
  m_sgBorerSelectedRow:= -1;
    
  Clear_Data(self);
  with MainDataModule.qryBorer do
    begin
      close;
      sql.Clear;
      sql.Add('Select borer_no,borer_name FROM borer');
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgBorer.RowCount := i +1;
          sgBorer.Cells[1,i] := FieldByName('borer_no').AsString;  
          sgBorer.Cells[2,i] := FieldByName('borer_name').AsString;
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin
    sgBorer.Row :=1;
    m_sgBorerSelectedRow :=1;
    Get_oneRecord(1);
    button_status(1,true);
  end
  else
    button_status(1,false);
end;


procedure TBorerTypeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TBorerTypeForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

end.
