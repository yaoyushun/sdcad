unit YuanWeiCeShi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, CurrEdit, Buttons, Grids, ExtCtrls, DB;

type
  TYuanWeiCeShiForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    sgDrills: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    btn_cancel: TBitBtn;
    btn_delete: TBitBtn;
    btn_add: TBitBtn;
    btn_ok: TBitBtn;
    btn_edit: TBitBtn;
    edtBegin_depth: TCurrencyEdit;
    edtPole_len: TCurrencyEdit;
    edtReal_num1: TCurrencyEdit;
    edtAmend_num: TCurrencyEdit;
    lblBegin_depth: TLabel;
    lblPole_len: TLabel;
    lblReal_num1: TLabel;
    lblAmend_num: TLabel;
    Panel5: TPanel;
    rgExaminationType: TRadioGroup;
    lblPt_type: TLabel;
    cboPt_type: TComboBox;
    Panel6: TPanel;
    sgDPT: TStringGrid;
    sgSPT: TStringGrid;
    edtEnd_depth: TCurrencyEdit;
    Label2: TLabel;
    lblReal_num2: TLabel;
    lblReal_num3: TLabel;
    edtReal_num2: TCurrencyEdit;
    edtReal_num3: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_editClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure sgDPTSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDrillsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtBegin_depthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgSPTSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure rgExaminationTypeClick(Sender: TObject);
    procedure cboPt_typeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBegin_depthChange(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow:Integer;bIsDPT:boolean);
    procedure Set_ComponentsStatus(bIsDPT:boolean);
    procedure Update_sgDPT(aRow:Integer);
    procedure Update_sgSPT(aRow:Integer);
    procedure GetDPTByDrillNo(aDrillNo: string);
    procedure GetSPTByDrillNo(aDrillNo: string);
    function GetInsertSQL(bIsDPT:boolean):string;
    function GetUpdateSQL(bIsDPT:boolean):string;
    function GetDeleteSQL(bIsDPT:boolean):string;
    function GetExistedSQL(aBegin_depth: string;bIsDPT:boolean):string;
    function Check_Data:boolean;
  public
    { Public declarations }
  end;

var
  YuanWeiCeShiForm: TYuanWeiCeShiForm;
  m_sgDrillsSelectedRow: integer;
  m_sgDPTSelectedRow: integer;
  m_sgSPTSelectedRow:integer;
  m_DataSetState: TDataSetState;
implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TYuanWeiCeShiForm.button_status(int_status: integer;
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

procedure TYuanWeiCeShiForm.GetDPTByDrillNo(aDrillNo: string);
var 
  strSQL: String;
  i: integer;
begin
  if trim(aDrillNo)='' then exit;
  sgDPT.RowCount :=2;
  DeleteStringGridRow(sgDPT,1);
  strSQL:='SELECT prj_no,drl_no,pt_type,begin_depth,end_depth,'
    +'pole_len,real_num1+real_num2+real_num3 as real_num,amend_num,'
    +'real_num1,real_num2,real_num3 '
    +' FROM DPT '
    +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
    +' AND drl_no='  +''''+aDrillNo+'''';
  with MainDataModule.qryDPT do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgDPT.RowCount := i +1;
          sgDPT.Cells[1,i] := FieldByName('begin_depth').AsString;
          sgDPT.Cells[2,i] := FieldByName('end_depth').AsString;
          sgDPT.Cells[3,i] := FieldByName('pole_len').AsString;  
          sgDPT.Cells[4,i] := FieldByName('real_num').AsString;
          sgDPT.Cells[5,i] := FieldByName('amend_num').AsString;
          sgDPT.Cells[6,i] := FieldByName('pt_type').AsString;
          sgDPT.Cells[7,i] := FieldByName('real_num1').AsString;
          sgDPT.Cells[8,i] := FieldByName('real_num2').AsString;
          sgDPT.Cells[9,i] := FieldByName('real_num3').AsString;
          
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin
    sgDPT.Row :=1;
    m_sgDPTSelectedRow :=1;
    Get_oneRecord(1,true);
    button_status(1,true);
  end
  else
  begin
    button_status(1,false); 
    clear_data(self);
  end; 
end;

function TYuanWeiCeShiForm.Check_Data: boolean;
begin
  result := true;
end;

procedure TYuanWeiCeShiForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Height := 428;
  Width  := 708;
  Top := 0;
  Left := 0;

  sgDrills.RowCount :=2;
  sgDrills.ColCount := 4;
  sgDrills.RowHeights[0] := 16;
  sgDrills.Cells[1,0] := '孔号';  
  sgDrills.Cells[2,0] := '孔口标高(m)';
  sgDrills.Cells[3,0] := '孔深(m)';  
  sgDrills.ColWidths[0]:=10;
  sgDrills.ColWidths[1]:=100;
  sgDrills.ColWidths[2]:=100;
  sgDrills.ColWidths[2]:=100;
  
  
  sgDPT.RowCount :=2;
  sgDPT.ColCount := 6;
  sgDPT.RowHeights[0] := 16;
  sgDPT.Cells[1,0] := '深度起(m)';
  sgDPT.Cells[2,0] := '深度止(m)';
  sgDPT.Cells[3,0] := '探杆长(m)';
  sgDPT.Cells[4,0] := '实测击数';
  sgDPT.Cells[5,0] := '修正击数';
  sgDPT.ColWidths[0]:=10;
  sgDPT.ColWidths[1]:=70;
  sgDPT.ColWidths[2]:=70;
  sgDPT.ColWidths[3]:=70;
  sgDPT.ColWidths[4]:=70;
  sgDPT.ColWidths[5]:=70;

  sgSPT.RowCount :=2;
  sgSPT.ColCount := 6;
  sgSPT.RowHeights[0] := 16;
  sgSPT.Cells[1,0] := '深度起(m)';
  sgSPT.Cells[2,0] := '深度止(m)';
  sgSPT.Cells[3,0] := '探杆长(m)';
  sgSPT.Cells[4,0] := '实测击数';
  sgSPT.Cells[5,0] := '修正击数';
  sgSPT.ColWidths[0]:=10;
  sgSPT.ColWidths[1]:=70;
  sgSPT.ColWidths[2]:=70;
  sgSPT.ColWidths[3]:=70;
  sgSPT.ColWidths[4]:=70;
  sgSPT.ColWidths[5]:=70;
  
  m_sgSPTSelectedRow:= -1;    
  m_sgDrillsSelectedRow := -1;
  m_sgDPTSelectedRow:= -1;
      
  Clear_Data(self);

  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no,drl_elev,comp_depth,Drl_x,Drl_y');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no+'''');
      open;
      i:=0;
      sgDrills.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          sgDrills.RowCount := i +1;
          sgDrills.Cells[1,i] := FieldByName('drl_no').AsString;  
          sgDrills.Cells[2,i] := FieldByName('drl_elev').AsString;
          sgDrills.Cells[3,i] := FieldByName('comp_depth').AsString;
          sgDrills.Cells[4,i] := FieldByName('Drl_x').AsString;
          sgDrills.Cells[5,i] := FieldByName('Drl_y').AsString;
          Next ;
        end;
      close;
      sgDrills.Tag := 0;
    end;
  if i>0 then
  begin
    sgDrills.Row :=1;
    m_sgDrillsSelectedRow :=1;
    
  end ;
  rgExaminationType.ItemIndex:=0;
  case rgExaminationType.ItemIndex of 
    0: 
      begin
        Set_ComponentsStatus(false);
        GetSPTByDrillNo(sgDrills.Cells[1,sgDrills.Row]);
      end;
    1:
      begin
        Set_ComponentsStatus(true);
        GetDPTByDrillNo(sgDrills.Cells[1,sgDrills.Row]);
      end;
  end;
end;

procedure TYuanWeiCeShiForm.Get_oneRecord(aRow: Integer;bIsDPT:boolean);
begin
  if bIsDPT then
  begin
    edtBegin_depth.Text := sgDPT.Cells[1,aRow];
    edtend_depth.Text := sgDPT.Cells[2,aRow]; 
    edtPole_len.Text := sgDPT.Cells[3,aRow];
    edtAmend_num.Text:= sgDPT.Cells[5,aRow];
    try
      cboPt_type.ItemIndex := StrToInt(sgDPT.Cells[6,aRow]);
    except
      cboPt_type.ItemIndex := -1;
    end;
    edtReal_num1.Text:= sgDPT.Cells[7,aRow];
    edtReal_num2.Text:= sgDPT.Cells[8,aRow];
    edtReal_num3.Text:= sgDPT.Cells[9,aRow];
  end
  else
  begin
    edtBegin_depth.Text := sgSPT.Cells[1,aRow];
    edtend_depth.Text := sgSPT.Cells[2,aRow]; 
    edtPole_len.Text := sgSPT.Cells[3,aRow];
    edtAmend_num.Text:= sgSPT.Cells[5,aRow];
    edtReal_num1.Text:= sgSPT.Cells[7,aRow];
    edtReal_num2.Text:= sgSPT.Cells[8,aRow];
    edtReal_num3.Text:= sgSPT.Cells[9,aRow];
  end;
end;

function TYuanWeiCeShiForm.GetDeleteSQL(bIsDPT:boolean): string;
begin
  if bIsDPT then
    result :='DELETE FROM DPT '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
           +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
           +' AND begin_depth=' +''''+sgDPT.Cells[1,sgDPT.row]+''''
  else
    result :='DELETE FROM SPT '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
           +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
           +' AND begin_depth=' +''''+sgSPT.Cells[1,sgSPT.row]+'''';
  
end;

function TYuanWeiCeShiForm.GetExistedSQL(aBegin_depth: string;bIsDPT:boolean): string;
begin
  if bIsDPT then
    result:='SELECT prj_no,drl_no,begin_depth FROM DPT'
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
           +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
           +' AND begin_depth=' +''''+aBegin_depth+''''
  else
    result:='SELECT prj_no,drl_no,begin_depth FROM SPT'
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
           +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
           +' AND begin_depth=' +''''+aBegin_depth+'''';
end;

function TYuanWeiCeShiForm.GetInsertSQL(bIsDPT:boolean): string;
begin
  if bIsDPT then
    result := 'INSERT INTO DPT (prj_no,drl_no,begin_depth,end_depth,'
            +'pole_len,real_num1,real_num2,real_num3,amend_num,pt_type) VALUES('
            +''''+g_ProjectInfo.prj_no +''''+','
            +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''+','
            +''''+trim(edtbegin_depth.Text)+''''+','
            +''''+trim(edtEnd_depth.Text)+''''+','
            +''''+trim(edtPole_len.Text)+''''+','
            +''''+trim(edtReal_num1.Text)+''''+','
            +''''+trim(edtReal_num2.Text)+''''+','
            +''''+trim(edtReal_num3.Text)+''''+','
            +''''+trim(edtAmend_num.Text)+''''+','
            +''''+IntToStr(cboPt_type.ItemIndex)+''''+')'
  else
    result := 'INSERT INTO SPT (prj_no,drl_no,begin_depth,end_depth,'
            +'pole_len,real_num1,real_num2,real_num3,amend_num) VALUES('
            +''''+g_ProjectInfo.prj_no +''''+','
            +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''+','
            +''''+trim(edtbegin_depth.Text)+''''+','
            +''''+trim(edtEnd_depth.Text)+''''+','
            +''''+trim(edtPole_len.Text)+''''+','
            +''''+trim(edtReal_num1.Text)+''''+','
            +''''+trim(edtReal_num2.Text)+''''+','
            +''''+trim(edtReal_num3.Text)+''''+','
            +''''+trim(edtAmend_num.Text)+''''+')';  
end;

function TYuanWeiCeShiForm.GetUpdateSQL(bIsDPT:boolean): string;
var 
  strSQLWhere,strSQLSet:string;
begin
  if bIsDPT then
  begin
    strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
                 +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
                 +' AND begin_depth=' +''''+sgDPT.Cells[1,sgDPT.row]+'''';

    strSQLSet:='UPDATE DPT SET '; 
    strSQLSet := strSQLSet + 'begin_depth'  +'='+''''+trim(edtbegin_depth.Text)+''''+',';
    strSQLSet := strSQLSet + 'end_depth'    +'='+''''+trim(edtEnd_depth.Text)+''''+',';
    strSQLSet := strSQLSet + 'pole_len' +'='+''''+trim(edtPole_len.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num1' +'='+''''+trim(edtReal_num1.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num2' +'='+''''+trim(edtReal_num2.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num3' +'='+''''+trim(edtReal_num3.Text)+''''+',';
    strSQLSet := strSQLSet + 'amend_num'+'='+''''+trim(edtAmend_num.Text)+''''+','; 
    strSQLSet := strSQLSet + 'pt_type'+'='+''''+IntToStr(cboPt_type.ItemIndex)+'''';
    result := strSQLSet + strSQLWhere;
  end
  else
  begin
    strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
                 +' AND drl_no='  +''''+trim(sgDrills.Cells[1,sgDrills.row])+''''
                 +' AND begin_depth=' +''''+sgDPT.Cells[1,sgDPT.row]+'''';

    strSQLSet:='UPDATE SPT SET '; 
    strSQLSet := strSQLSet + 'begin_depth'  +'='+''''+trim(edtbegin_depth.Text)+''''+',';
    strSQLSet := strSQLSet + 'end_depth'    +'='+''''+trim(edtEnd_depth.Text)+''''+',';
    strSQLSet := strSQLSet + 'pole_len' +'='+''''+trim(edtPole_len.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num1' +'='+''''+trim(edtReal_num1.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num2' +'='+''''+trim(edtReal_num2.Text)+''''+',';
    strSQLSet := strSQLSet + 'real_num3' +'='+''''+trim(edtReal_num3.Text)+''''+',';
    strSQLSet := strSQLSet + 'amend_num'+'='+''''+trim(edtAmend_num.Text)+''''; 
    result := strSQLSet + strSQLWhere;
  end;  
end;

procedure TYuanWeiCeShiForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TYuanWeiCeShiForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TYuanWeiCeShiForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    edtBegin_depth.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    case rgExaminationType.ItemIndex of 
      0: Get_oneRecord(sgSPT.Row,false);
      1: Get_oneRecord(sgDPT.Row,true);
    end;    
  end;
end;

procedure TYuanWeiCeShiForm.btn_okClick(Sender: TObject);
var
  strSQL: string; 
begin
  if not Check_Data then exit;
    case rgExaminationType.ItemIndex of 
      0://现在要保存的是标准贯入试验数据 
        begin
          if m_DataSetState = dsInsert then
            begin
              strSQL := GetExistedSQL(trim(edtbegin_depth.Text),false);
              if isExistedRecord(MainDataModule.qrySPT,strSQL) then
              begin
                messagebox(self.Handle,'此开始深度已经存在，请输入新的开始深度！','数据校对',mb_ok);  
                edtBegin_depth.SetFocus;
                exit;
              end; 
              strSQL := self.GetInsertSQL(false);
              if Insert_oneRecord(MainDataModule.qrySPT,strSQL) then
                begin
                  if (sgSPT.RowCount =2) and (sgSPT.Cells[1,1] ='') then
                    begin                     
                      m_sgSPTSelectedRow:= sgSPT.RowCount-1;
                    end
                  else
                    begin
                      m_sgSPTSelectedRow := sgSPT.RowCount;
                      sgSPT.RowCount := sgSPT.RowCount+1;
                    end;
                  Update_sgSPT(sgSPT.RowCount-1);
                  sgSPT.Row := sgSPT.RowCount-1;
                  Button_status(1,true);
                  btn_add.SetFocus;
                end;
            end
          else if m_DataSetState = dsEdit then
            begin
              if sgSPT.Cells[1,sgSPT.Row]<>trim(edtbegin_depth.Text) then
              begin
                strSQL := GetExistedSQL(trim(edtbegin_depth.Text),false);
                if isExistedRecord(MainDataModule.qrySPT,strSQL) then
                begin
                  messagebox(self.Handle,'此开始深度已经存在，请输入新的开始深度！','数据校对',mb_ok);  
                  edtBegin_depth.SetFocus;
                  exit;
                end;                
              end;
              strSQL := self.GetUpdateSQL(false);        
              if Update_oneRecord(MainDataModule.qrySPT,strSQL) then
                begin
                  Update_sgSPT(sgSPT.Row);
                  Button_status(1,true);
                  btn_add.SetFocus;
                end;      
            end;         
        end;
      1://现在要保存的是重力触探试验数据
        begin  //begin case 1
          if m_DataSetState = dsInsert then
            begin
              strSQL := GetExistedSQL(trim(edtbegin_depth.Text),true);
              if isExistedRecord(MainDataModule.qryDPT,strSQL) then
              begin
                messagebox(self.Handle,'此开始深度已经存在，请输入新的开始深度！','数据校对',mb_ok);  
                edtBegin_depth.SetFocus;
                exit;
              end;
              strSQL := self.GetInsertSQL(true);
              if Insert_oneRecord(MainDataModule.qryDPT,strSQL) then
                begin
                  if (sgDPT.RowCount =2) and (sgDPT.Cells[1,1] ='') then
                    begin                     
                      m_sgDPTSelectedRow:= sgDPT.RowCount-1;
                    end
                  else
                    begin
                      m_sgDPTSelectedRow := sgDPT.RowCount;
                      sgDPT.RowCount := sgDPT.RowCount+1;
                    end;
                  Update_sgDPT(sgDPT.RowCount-1);
                  sgDPT.Row := sgDPT.RowCount-1;
                  Button_status(1,true);
                  btn_add.SetFocus;
                end;
            end
          else if m_DataSetState = dsEdit then
            begin
              if sgDPT.Cells[1,sgDPT.Row]<>trim(edtbegin_depth.Text) then
              begin
                strSQL := GetExistedSQL(trim(edtbegin_depth.Text),true);
                if isExistedRecord(MainDataModule.qryDPT,strSQL) then
                  begin
                    messagebox(self.Handle,'此开始深度已经存在，请输入新的开始深度！','数据校对',mb_ok);  
                    edtBegin_depth.SetFocus;
                    exit;
                  end;                
              end;
              strSQL := self.GetUpdateSQL(true);        
              if Update_oneRecord(MainDataModule.qryDPT,strSQL) then
                begin
                  Update_sgDPT(sgDPT.Row);
                  Button_status(1,true);
                  btn_add.SetFocus;
                end;      
            end;        
        end;////end case 1
    end;

end;


procedure TYuanWeiCeShiForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
  edtbegin_depth.SetFocus;
end;

procedure TYuanWeiCeShiForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtBegin_depth.Text <> '' then
    begin
      case rgExaminationType.ItemIndex of 
        0: 
          begin
            strSQL := self.GetDeleteSQL(true);
            if Delete_oneRecord(MainDataModule.qryDPT,strSQL) then
              begin
                Clear_Data(self);  
                DeleteStringGridRow(sgDPT,sgDPT.Row);
                self.Get_oneRecord(sgDPT.Row,true);
                if sgDPT.Cells[1,sgDPT.row]='' then
                  button_status(1,false)
                else
                  button_status(1,true);
              end;          
          end;
        1: 
          begin
            strSQL := self.GetDeleteSQL(false);
            if Delete_oneRecord(MainDataModule.qrySPT,strSQL) then
              begin
                Clear_Data(self);  
                DeleteStringGridRow(sgSPT,sgSPT.Row);
                self.Get_oneRecord(sgSPT.Row,false);
                if sgSPT.Cells[1,sgSPT.row]='' then
                  button_status(1,false)
                else
                  button_status(1,true);
              end;          
          end;
      end;
    end;
end;

procedure TYuanWeiCeShiForm.sgDPTSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow <>0) and (ARow<>m_sgDPTSelectedRow) then
    if sgDPT.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow,true);
      if sgDPT.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true); 
    end
    else
      clear_data(self);
  m_sgDPTSelectedRow:=ARow; 
end;

procedure TYuanWeiCeShiForm.sgDrillsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>m_sgDrillsSelectedRow)
     and (sgDrills.Cells[1,ARow]<>'') then
  begin
    case rgExaminationType.ItemIndex of 
      0:
        begin
          GetSPTByDrillNo(sgDrills.Cells[1,ARow]);
          //Get_oneRecord(1,false);
          //sgSPT.Row :=1;
          
          if sgSPT.Cells[1,1]='' then
            Button_status(1,false)
          else
            Button_status(1,true);
        end;
      1:
        begin
          GetDPTByDrillNo(sgDrills.Cells[1,ARow]);
          //Get_oneRecord(1,true);
          //sgDPT.Row :=1;
          
          if sgDPT.Cells[1,1]='' then
            Button_status(1,false)
          else
            Button_status(1,true);
        end;
    end;
    m_sgDrillsSelectedRow:=ARow;
  end;
  
end;

procedure TYuanWeiCeShiForm.edtBegin_depthKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  change_focus(key,self);
end;
//bIsDPT 判断现在要显示的是不是重力触探。
procedure TYuanWeiCeShiForm.Set_ComponentsStatus(bIsDPT: boolean);
begin
  if bIsDPT then
  begin
    sgSPT.SendToBack;
  end
  else
  begin
    sgSPT.BringToFront;
  end;
  cboPt_type.Visible := bIsDPT;
  lblPt_type.Visible := bIsDPT;
end;

procedure TYuanWeiCeShiForm.GetSPTByDrillNo(aDrillNo: string);
var 
  strSQL: String;
  i: integer;
begin
  if trim(aDrillNo)='' then exit; 
  sgSPT.RowCount :=2;
  DeleteStringGridRow(sgSPT,1);
  strSQL:='SELECT prj_no,drl_no,begin_depth,end_depth,'
    +'pole_len,real_num1+real_num2+real_num3 as real_num,amend_num,'
    +'real_num1,real_num2,real_num3 '
    +' FROM SPT '
    +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no +''''
    +' AND drl_no='  +''''+aDrillNo+'''';
  with MainDataModule.qrySPT do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgSPT.RowCount := i +1;
          sgSPT.Cells[1,i] := FieldByName('begin_depth').AsString;
          sgSPT.Cells[2,i] := FieldByName('end_depth').AsString;
          sgSPT.Cells[3,i] := FieldByName('pole_len').AsString;  
          sgSPT.Cells[4,i] := FieldByName('real_num').AsString;
          sgSPT.Cells[5,i] := FieldByName('amend_num').AsString;
          sgSPT.Cells[7,i] := FieldByName('real_num1').AsString;
          sgSPT.Cells[8,i] := FieldByName('real_num2').AsString;
          sgSPT.Cells[9,i] := FieldByName('real_num3').AsString;
          
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin
    sgSPT.Row :=1;
    m_sgSPTSelectedRow :=1;
    Get_oneRecord(1,false);
    button_status(1,true);
  end
  else
  begin
    button_status(1,false); 
    clear_data(self);
  end;
end;

procedure TYuanWeiCeShiForm.sgSPTSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow <>0) and (ARow<>m_sgSPTSelectedRow) then
    if sgSPT.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow,false);
      if sgSPT.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true); 
    end
    else
      clear_data(self);
  m_sgSPTSelectedRow:=ARow;
end;

procedure TYuanWeiCeShiForm.rgExaminationTypeClick(Sender: TObject);
begin
  clear_data(self);
  case rgExaminationType.ItemIndex of 
    0: 
      begin
        Set_ComponentsStatus(false);
        GetSPTByDrillNo(sgDrills.Cells[1,sgDrills.Row]);
      end;
    1:
      begin
        Set_ComponentsStatus(true);
        GetDPTByDrillNo(sgDrills.Cells[1,sgDrills.Row]);
      end;
  end; 
end;

procedure TYuanWeiCeShiForm.Update_sgSPT(aRow: Integer);
begin
  sgSPT.Cells[1,aRow] := trim(edtbegin_depth.Text);
  sgSPT.Cells[2,aRow] := trim(edtEnd_depth.Text);
  sgSPT.Cells[3,aRow] := trim(edtPole_len.Text);
  sgSPT.Cells[4,aRow] := 
    IntToStr(strtoint(trim(edtReal_num1.Text))
    +strtoint(trim(edtReal_num2.Text))
    +strtoint(trim(edtReal_num3.Text)));
  sgSPT.Cells[5,aRow] := trim(edtAmend_num.Text);
  sgSPT.Cells[7,aRow] := trim(edtreal_num1.Text);
  sgSPT.Cells[8,aRow] := trim(edtreal_num2.Text);
  sgSPT.Cells[9,aRow] := trim(edtreal_num3.Text);
end;

procedure TYuanWeiCeShiForm.Update_sgDPT(aRow: Integer);
begin
  sgDPT.Cells[1,aRow] := trim(edtbegin_depth.Text);
  sgDPT.Cells[2,aRow] := trim(edtEnd_depth.Text);
  sgDPT.Cells[3,aRow] := trim(edtPole_len.Text);
  sgDPT.Cells[4,aRow] := 
    IntToStr(strtoint(trim(edtReal_num1.Text))
    +strtoint(trim(edtReal_num2.Text))
    +strtoint(trim(edtReal_num3.Text)));
  sgDPT.Cells[5,aRow] := trim(edtAmend_num.Text);
  sgDPT.Cells[6,aRow] := IntToStr(cboPt_type.ItemIndex);
  sgDPT.Cells[7,aRow] := trim(edtreal_num1.Text);
  sgDPT.Cells[8,aRow] := trim(edtreal_num2.Text);
  sgDPT.Cells[9,aRow] := trim(edtreal_num3.Text);
end;

procedure TYuanWeiCeShiForm.cboPt_typeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TYuanWeiCeShiForm.edtBegin_depthChange(Sender: TObject);
begin
  edtPole_len.Text := edtBegin_depth.Text;
end;

end.
