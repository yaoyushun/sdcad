unit YuanWeiCeShi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, rxToolEdit, rxCurrEdit, Buttons, Grids, ExtCtrls, DB;

type
  TYuanWeiCeShiForm = class(TForm)
    Panel1: TPanel;
    sgDrills: TStringGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    lblBegin_depth: TLabel;
    lblPole_len: TLabel;
    lblReal_num1: TLabel;
    lblAmend_num: TLabel;
    lblPt_type: TLabel;
    Label2: TLabel;
    lblReal_num2: TLabel;
    lblReal_num3: TLabel;
    edtBegin_depth: TCurrencyEdit;
    edtPole_len: TCurrencyEdit;
    edtReal_num1: TCurrencyEdit;
    edtAmend_num: TCurrencyEdit;
    cboPt_type: TComboBox;
    edtEnd_depth: TCurrencyEdit;
    edtReal_num2: TCurrencyEdit;
    edtReal_num3: TCurrencyEdit;
    btnAddPoleLen: TBitBtn;
    Panel4: TPanel;
    btn_cancel: TBitBtn;
    btn_delete: TBitBtn;
    btn_add: TBitBtn;
    btn_ok: TBitBtn;
    btn_edit: TBitBtn;
    btnCanShu: TBitBtn;
    Panel5: TPanel;
    rgExaminationType: TRadioGroup;
    Panel6: TPanel;
    sgSPT: TStringGrid;
    sgDPT: TStringGrid;
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
    procedure edtPole_lenExit(Sender: TObject);
    procedure btnCanShuClick(Sender: TObject);
    procedure sgDrillsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgDPTDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgSPTDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnAddPoleLenClick(Sender: TObject);
    procedure edtPole_lenChange(Sender: TObject);
    procedure edtReal_num1Change(Sender: TObject);
    procedure edtReal_num2Change(Sender: TObject);
    procedure edtReal_num3Change(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow:Integer;bIsDPT:boolean);
    procedure Set_ComponentsStatus(bIsDPT:boolean);
    procedure Update_sgDPT(aRow:Integer);
    procedure Update_sgSPT(aRow:Integer);
    procedure CalulateXiuZhengXiShu;
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

uses MainDM, public_unit, SdCadMath, DPTCoefficient;

{$R *.dfm}


//取得标贯试验修正系数
function GetSptAmend_coef(aPoleLenth: double): double;
var
  iNum: integer;
  x0,y0,x1,y1,tmpX,tmpY: double;
begin
  x0:=0;
  y0:=0;
  with MainDataModule.qrySectionTotal do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT pole_len,amend_coef FROM spt_coef');
    open;
    iNum:= 0;
    while not eof do
    begin
      inc(iNum);
      tmpX:= FieldbyName('pole_len').AsInteger;
      tmpY:= FieldbyName('amend_coef').AsFloat;
      if aPoleLenth= tmpX then
      begin
        result:= tmpY;
        close;
        exit;
      end;
      if iNum=1 then 
        begin
          x0:= tmpX;
          y0:= tmpY;
          if aPoleLenth<x0 then
          begin
            result:= tmpY;
            close;
            exit;
          end;
        end
      else
        begin
          if (aPoleLenth<tmpX) then
            begin
              x1:=tmpX;
              y1:=tmpY;
              result:= StrToFloat(formatfloat('0.00',XianXingChaZhi(x0, y0, x1, y1, aPoleLenth)));
              close;
              exit;
            end
          else
            begin
              x0:= tmpX;
              y0:= tmpY;
            end;
        end; 
      next;
    end;
    close;
  end;
  result:= y0;
end;
  
//getDPTXiuZhengXiShu 返回重型圆锥动力触探锤击数修正系数
//N表示实测锤击数，L表示杆长，aType表示触探类型，aType=1是重型，
// aType=2 是超重型。
function getDPTXiuZhengXiShu(N,L: double;aType:integer): double;
var
  //N表示击数,L表示杆长
  i,iFieldCount, iField, recNum, N0, N1, L0, L1, tmpL:integer;
  N_Exist, N_Max:integer;
  
  tmpXiShu_N0, tmpXiShu_N1,
  XiShu_N0L0, XiShu_N0L1,
  XiShu_N1L0, XiShu_N1L1,
  tmpXiShu: double;
  
  isExistN: boolean;
  
  sFieldName, sTableName: string;
begin
  N0:=0;
  N1:=0;
  L0:=0;
  XiShu_N0L0:=1;
  XiShu_N1L0:=1;
  N_Exist:=0;
  N_Max:=0;
  //qryDPTCoef
  case aType of
    1: 
      begin
        N_Max:= 50;
        sTableName := 'dpt_coefficient';
      end;
    2:
      begin
        N_Max:= 40;
        sTableName := 'dpt_supercoefficient';
      end;
  end;
  isExistN:= false;
  with MainDataModule.qryDPTCoef do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM ' + sTableName);
    open;
    iFieldCount := MainDataModule.qryDPTCoef.FieldCount;
    recNum:= 0;
    {开始找出击数N在数据库中的两边的值N0和N1，
     如果刚好有这个N则转入下面的操作找杆长L0,L1和对应的修正系数}
    if N>=N_Max then
    begin
      N_Exist:= N_Max;
      isExistN := true;
    end
    else
      for i := 1 to iFieldCount-1 do
      begin
        sFieldName := Fields[i].FieldName;
        System.Delete(sFieldName,1,1);
        iField := strtoint(sFieldName);
        if iField=N then 
        begin
          isExistN:= true;
          N_Exist:=iField;
          Break;
        end;
        if i=1 then
        begin
          N0:= iField;
          if N<iField then
          begin
            result:=1;
            close;
            exit;
          end;
        end;
        if N>iField then 
          N0:= iField
        else
        begin
          N1:= iField;
          Break;
        end;      
      end;

    //找杆长L0,L1和对应的修正系数
    while not eof do
    begin
      Inc(recNum);
      tmpL := FieldByName('pole_len').AsInteger;
      
      if isExistN then
      begin
        tmpXiShu:= FieldByName('n' + inttostr(N_Exist)).AsFloat;
        if tmpL = L then
        begin
          result:= tmpXiShu;
          close;
          exit;
        end;
        if recNum=1 then
        begin
          L0:= tmpL;
          XiShu_N0L0:= tmpXiShu;
          if L<tmpL then
          begin
            result:= tmpXiShu;
            close;
            exit;
          end;
        end;
        if tmpL<L then
          begin
            L0:= tmpL;
            XiShu_N0L0:= tmpXiShu;
          end
        else
          begin
            L1:= tmpL;
            XiShu_N0L1:= tmpXiShu;
            result:= XianXingChaZhi(L0,XiShu_N0L0,L1,XiShu_N0L1,L);
            close;
            exit;
          end;
      end //end of if isExistN then

      else
      begin
        tmpXiShu_N0 := FieldByName('n'+inttostr(N0)).AsFloat;
        tmpXiShu_N1 := FieldByName('n'+inttostr(N1)).AsFloat;
        tmpL := FieldByName('pole_len').AsInteger;
        if L=tmpL then
        begin
          result:= XianXingChaZhi(N0,tmpXiShu_N0,N1,tmpXiShu_N1,N);
          close;
          exit;
        end;
        if recNum=1 then
        begin
          if L<tmpL then
          begin
            result:= tmpXiShu_N0;
            close;
            exit;
          end;
          XiShu_N0L0 := tmpXiShu_N0;
          XiShu_N1L0 := tmpXiShu_N1;
          L0 := tmpL;
        end
        else //else recNum>1
        begin
          if L<tmpL then
          begin
            XiShu_N0L1:= tmpXiShu_N0;
            XiShu_N1L1 := tmpXiShu_N1;
            L1 := tmpL;
            result:= ShuangXianXingChaZhi(N0, L0, N1, L1, 
              XiShu_N0L0,XiShu_N0L1,XiShu_N1L0,XiShu_N1L1,N,L);
            close;
            exit;            
          end
          else
          begin
            XiShu_N0L0 := tmpXiShu_N0;
            XiShu_N1L0 := tmpXiShu_N1;
            L0 := tmpL;
          end;
        end;  
      end;
      next;
    end;
    result:=1;
    close;
  end;

end;

//计算修正击数
procedure TYuanWeiCeShiForm.CalulateXiuZhengXiShu;
var
  dPole_len: double; //探杆长
  dReal_num: double; //实测击数
  dXiuZhengXiShu: double; //修正系数
  
begin
  try
    dPole_len:= StrToFloat(edtPole_len.Text);
    dReal_num:= strToFloat(edtReal_num1.Text) 
      + strToFloat(edtReal_num2.Text) 
      + strToFloat(edtReal_num3.Text);
    if rgExaminationType.ItemIndex = 0 then  //标贯试验
      dXiuZhengXiShu:= GetSptAmend_coef(dPole_len)
    else
      if cboPt_type.Text ='重型' then
        dXiuZhengXiShu:= getDPTXiuZhengXiShu(dReal_num,dPole_len,1)
      else
        dXiuZhengXiShu:= getDPTXiuZhengXiShu(dReal_num,dPole_len,2);
    edtAmend_num.Text := formatfloat('0.00',dReal_num*dXiuZhengXiShu);
  except
  end;
end;

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
    +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''';
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
  if StrToFloat(edtEnd_depth.Text) <= StrToFloat(edtBegin_depth.Text)  then
  begin
    messagebox(self.Handle,'深度止应大于深度起！','数据校对',mb_ok);
    edtEnd_depth.SetFocus;
    result := false;
    exit;
  end;
  result := true;
end;

procedure TYuanWeiCeShiForm.FormCreate(Sender: TObject);
var
  i: integer;
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  sgDrills.RowCount :=2;
  sgDrills.ColCount := 4;
  sgDrills.RowHeights[0] := 16;
  sgDrills.Cells[1,0] := '孔号';  
  sgDrills.Cells[2,0] := '孔口标高(m)';
  sgDrills.Cells[3,0] := '孔深(m)';  
  sgDrills.ColWidths[0]:=10;
  sgDrills.ColWidths[1]:=120;
  sgDrills.ColWidths[2]:=90;
  sgDrills.ColWidths[2]:=70;
  

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
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
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
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND begin_depth=' +''''+sgDPT.Cells[1,sgDPT.row]+''''
  else
    result :='DELETE FROM SPT '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND begin_depth=' +''''+sgSPT.Cells[1,sgSPT.row]+'''';
  
end;

function TYuanWeiCeShiForm.GetExistedSQL(aBegin_depth: string;bIsDPT:boolean): string;
begin
  if bIsDPT then
    result:='SELECT prj_no,drl_no,begin_depth FROM DPT'
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND begin_depth=' +''''+aBegin_depth+''''
  else
    result:='SELECT prj_no,drl_no,begin_depth FROM SPT'
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND begin_depth=' +''''+aBegin_depth+'''';
end;

function TYuanWeiCeShiForm.GetInsertSQL(bIsDPT:boolean): string;
begin
  if bIsDPT then
    result := 'INSERT INTO DPT (prj_no,drl_no,begin_depth,end_depth,'
            +'pole_len,real_num1,real_num2,real_num3,amend_num,pt_type) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''+','
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
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''+','
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
    strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
                 +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
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
    strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
                 +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
                 +' AND begin_depth=' +''''+sgSPT.Cells[1,sgSPT.row]+'''';

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
                  else
                    begin
                      sgSPT.RowCount := sgSPT.RowCount+1;
                      m_sgSPTSelectedRow:= sgSPT.RowCount-1;
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
                      sgDPT.RowCount := sgDPT.RowCount+1;
                      m_sgDPTSelectedRow := sgDPT.RowCount;

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
  CboPt_type.ItemIndex :=1;//默认重力触探类型为重触
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
        1: //动力触探
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
        0: //标贯
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
    +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''';
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
    FloatToStr(strtoFloat(trim(edtReal_num1.Text))
    +strtoFloat(trim(edtReal_num2.Text))
    +strtoFloat(trim(edtReal_num3.Text)));
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
    FloatToStr(strtoFloat(trim(edtReal_num1.Text))
    +strtoFloat(trim(edtReal_num2.Text))
    +strtoFloat(trim(edtReal_num3.Text)));
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
  
  try
    edtPole_len.Text := floattostr(strtofloat(edtBegin_depth.Text)+0.5);
    case rgExaminationType.ItemIndex of 
      0://现在要保存的是标准贯入试验数据
        edtEnd_depth.Text := floattostr(strtofloat(edtbegin_depth.Text)+0.3);
      1:
        edtEnd_depth.Text := floattostr(strtofloat(edtbegin_depth.Text)+0.1);
    end;
    CalulateXiuZhengXiShu;
  except
       
  end;
end;

procedure TYuanWeiCeShiForm.edtPole_lenExit(Sender: TObject);
begin
  if (m_DataSetState=dsEdit) or (m_DataSetState=dsBrowse) then
     CalulateXiuZhengXiShu;
end;

procedure TYuanWeiCeShiForm.btnCanShuClick(Sender: TObject);
begin
  DPTCoefficientForm:= TDPTCoefficientForm.Create(self);
  DPTCoefficientForm.ShowModal; 
end;

procedure TYuanWeiCeShiForm.sgDrillsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TYuanWeiCeShiForm.sgDPTDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TYuanWeiCeShiForm.sgSPTDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TYuanWeiCeShiForm.btnAddPoleLenClick(Sender: TObject);
begin
  try
    edtPole_len.Text := floattostr(strtofloat(edtPole_len.Text)+0.5);
  except
  end;
end;

procedure TYuanWeiCeShiForm.edtPole_lenChange(Sender: TObject);
begin
  CalulateXiuZhengXiShu;
end;

procedure TYuanWeiCeShiForm.edtReal_num1Change(Sender: TObject);
begin
  CalulateXiuZhengXiShu
end;

procedure TYuanWeiCeShiForm.edtReal_num2Change(Sender: TObject);
begin
  CalulateXiuZhengXiShu;
end;

procedure TYuanWeiCeShiForm.edtReal_num3Change(Sender: TObject);
begin
  CalulateXiuZhengXiShu;
end;

end.
