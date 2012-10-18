unit DrillType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, DB, ExtCtrls;

type
  TDrillTypeForm = class(TForm)
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    Gbox: TGroupBox;
    sgDrillType: TStringGrid;
    gbox2: TGroupBox;
    lblD_t_name: TLabel;
    edtD_t_name: TEdit;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure sgDrillTypeSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_addClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure edtD_t_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtD_t_nameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow:Integer);
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function Check_Data:boolean;
    function isExistedRecord(aDrillTypeName:string):boolean;
  public
    { Public declarations }
  end;

var
  DrillTypeForm: TDrillTypeForm;
  m_sgDrillTypeSelectedRow: integer;
  m_DataSetState: TDataSetState;
implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TDrillTypeForm.button_status(int_status: integer;
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

procedure TDrillTypeForm.FormCreate(Sender: TObject);
var
  i: integer;
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgDrillType.RowHeights[0] := 16;
  sgDrillType.Cells[1,0] := '钻孔类型';  
  sgDrillType.ColWidths[0]:=10;
  sgDrillType.ColWidths[1]:=125;
  
  m_sgDrillTypeSelectedRow:= -1;
    
  Clear_Data(self);
  with MainDataModule.qryDrill_type do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT d_t_no,d_t_name FROM drill_type');
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgDrillType.RowCount := i +1;
          sgDrillType.Cells[1,i] := FieldByName('d_t_name').AsString;  
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin
    sgDrillType.Row :=1;
    m_sgDrillTypeSelectedRow :=1;
    Get_oneRecord(1);
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TDrillTypeForm.Get_oneRecord(aRow: Integer);
begin 
  edtD_t_name.Text := sgDrillType.Cells[1,aRow];
end;

procedure TDrillTypeForm.sgDrillTypeSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow <>0) and (ARow<>m_sgDrillTypeSelectedRow) then
    if sgDrillType.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow);
      if sgDrillType.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
  m_sgDrillTypeSelectedRow:=ARow;
end;

procedure TDrillTypeForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TDrillTypeForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

function TDrillTypeForm.Check_Data: boolean;
begin
  if trim(edtD_t_name.Text) = '' then
  begin
    messagebox(self.Handle,'请输入类别名称！','数据校对',mb_ok);
    edtD_t_name.SetFocus;
    result := false;
    exit;
  end;
  result := true;
end;




function TDrillTypeForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM drill_type WHERE d_t_name='+ ''''+sgDrillType.Cells[1,sgDrillType.row]+'''';
end;


function TDrillTypeForm.isExistedRecord(aDrillTypeName: string): boolean;
begin
  with MainDataModule.qryDrill_type do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT d_t_no,d_t_name FROM drill_type WHERE d_t_name='+ ''''+aDrillTypeName+'''');
      try
        try
          Open;
          if eof then 
            result:=false
          else
          begin
            result:=true;
            messagebox(self.Handle,'此类别已经存在，请输入新的类别！','数据校对',mb_ok);  
            edtD_t_name.SetFocus;
          end;
        except
          result:=false;
        end;
      finally
        close;
      end;
    end;  
end;

procedure TDrillTypeForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
  edtD_t_name.SetFocus;
end;

procedure TDrillTypeForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtD_t_name.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryDrill_type,strSQL) then
        begin
          Clear_Data(self);  
          DeleteStringGridRow(sgDrillType,sgDrillType.Row);
          self.Get_oneRecord(sgDrillType.Row);
          if sgDrillType.Cells[1,sgDrillType.row]='' then
            button_status(1,false)
          else
            button_status(1,true);
        end;
    end;
end;

procedure TDrillTypeForm.btn_okClick(Sender: TObject);
var
  strSQL: string; 
begin
  if not Check_Data then exit;
  if m_DataSetState = dsInsert then
    begin
      if isExistedRecord(trim(edtD_t_name.Text)) then exit;
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryDrill_type,strSQL) then
        begin
          if (sgDrillType.RowCount =2) and (sgDrillType.Cells[1,1] <>'') then
            sgDrillType.RowCount := sgDrillType.RowCount+1;
          m_sgDrillTypeSelectedRow:= sgDrillType.RowCount-1;
          sgDrillType.Cells[1,sgDrillType.RowCount-1] := trim(edtD_t_name.Text);
          sgDrillType.Row := sgDrillType.RowCount-1;
          Button_status(1,true);
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      if sgDrillType.Cells[1,sgDrillType.Row]<>trim(edtD_t_name.Text) then
        if isExistedRecord(trim(edtD_t_name.Text)) then exit;
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryDrill_type,strSQL) then
        begin
          sgDrillType.Cells[1,sgDrillType.Row] := edtD_t_name.Text ;
          Button_status(1,true);
          btn_add.SetFocus;
        end;      
    end;

end;

function TDrillTypeForm.GetInsertSQL: string;
begin
  result := 'INSERT INTO drill_type (d_t_name) VALUES('
            +''''+trim(edtD_t_name.Text)+''''+')';
end;

function TDrillTypeForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE d_t_name='+''''+sgDrillType.Cells[1,sgDrillType.Row]+'''';
  strSQLSet:='UPDATE drill_type SET '; 
  strSQLSet := strSQLSet + 'd_t_name' +'='+''''+trim(edtD_t_name.Text)+''''; 
  result := strSQLSet + strSQLWhere;
end;

procedure TDrillTypeForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    edtD_t_name.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    self.Get_oneRecord(sgDrillType.Row);
  end;
end;

procedure TDrillTypeForm.edtD_t_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TDrillTypeForm.edtD_t_nameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

end.
