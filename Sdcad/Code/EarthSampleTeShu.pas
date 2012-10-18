unit EarthSampleTeShu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, ExtCtrls, DB;

type
  TEarthSampleTeShuForm = class(TForm)
    Panel1: TPanel;
    sgSample: TStringGrid;
    Panel2: TPanel;
    lblStra_no: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label31: TLabel;
    Label7: TLabel;
    edtgygj_pc: TEdit;
    edtgygj_cc: TEdit;
    edtgygj_cs: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label33: TLabel;
    cboDrl_no: TComboBox;
    edtS_depth_begin: TEdit;
    edtS_depth_end: TEdit;
    edtS_no: TEdit;
    edtea_name: TEdit;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label13: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtgjxs50_1: TEdit;
    edtgjxs100_1: TEdit;
    edtgjxs200_1: TEdit;
    edtgjxs50_2: TEdit;
    edtgjxs100_2: TEdit;
    edtgjxs200_2: TEdit;
    edtgjxs400_1: TEdit;
    edtgjxs400_2: TEdit;
    GroupBox4: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edtjcxs_v_005_01: TEdit;
    edtjcxs_v_01_02: TEdit;
    edtjcxs_v_02_04: TEdit;
    GroupBox5: TGroupBox;
    Label21: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label26: TLabel;
    GroupBox6: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtklzc_sha_2_05: TEdit;
    edtklzc_sha_05_025: TEdit;
    edtklzc_sha_025_0075: TEdit;
    edtklzc_nl: TEdit;
    edtklzc_li: TEdit;
    edtklzc_fl: TEdit;
    GroupBox8: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    edtbjyxs: TEdit;
    edtqlxs: TEdit;
    chbIf_statistic: TCheckBox;
    GroupBox10: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label10: TLabel;
    edtjcxs_h_005_01: TEdit;
    edtjcxs_h_01_02: TEdit;
    edtjcxs_h_02_04: TEdit;
    cboCengHao: TComboBox;
    cboStra_no: TComboBox;
    cboSub_no: TComboBox;
    GroupBox11: TGroupBox;
    Label32: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    edtlj_yxlj: TEdit;
    edtlj_pjlj: TEdit;
    edtlj_xzlj: TEdit;
    edtlj_d70: TEdit;
    GroupBox9: TGroupBox;
    Label11: TLabel;
    edtjzcylxs: TEdit;
    GroupBox12: TGroupBox;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    edtwcxkyqd_yz: TEdit;
    edtwcxkyqd_cs: TEdit;
    edtwcxkyqd_lmd: TEdit;
    GroupBox13: TGroupBox;
    Label43: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label44: TLabel;
    Label47: TLabel;
    edtszsy_zyl_njl_uu: TEdit;
    edtszsy_zyl_nmcj_uu: TEdit;
    edtszsy_yxyl_njl: TEdit;
    edtszsy_yxyl_nmcj: TEdit;
    cbbSzsy_syff: TComboBox;
    edtszsy_zyl_njl_cu: TEdit;
    edtszsy_zyl_nmcj_cu: TEdit;
    GroupBox14: TGroupBox;
    Label49: TLabel;
    Label51: TLabel;
    edtstxs_kv: TEdit;
    edtstxs_kh: TEdit;
    GroupBox15: TGroupBox;
    Label52: TLabel;
    Label53: TLabel;
    edttrpj_g: TEdit;
    edttrpj_sx: TEdit;
    GroupBox16: TGroupBox;
    Label6: TLabel;
    edthtml: TEdit;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    btn_FenCeng: TBitBtn;
    btn_TiHuan: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure sgSampleSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_editClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_addClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure cboDrl_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtS_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtgygj_pcChange(Sender: TObject);
    procedure edtgygj_pcKeyPress(Sender: TObject; var Key: Char);
    procedure edtS_depth_beginChange(Sender: TObject);
    procedure cboCengHaoChange(Sender: TObject);
    procedure btn_FenCengClick(Sender: TObject);
    procedure btn_TiHuanClick(Sender: TObject);
    procedure cbbSzsy_syffChange(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aProjectNo: string;aDrillNo: string;
      aSampleNo:string; aRow: integer);
    procedure GetAllDrillNo;
    procedure CalaculateData;
    procedure GetCengHao;
    procedure RefreshData;
    
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function Check_Data:boolean;
    function GetExistedSQL(aDrillNo: string;aSampleNo: string):string;
  public
    { Public declarations }
  end;

var
  EarthSampleTeShuForm: TEarthSampleTeShuForm;
  m_DataSetState: TDataSetState;

const
  m_strFenGeFu='---';  //用来分隔层号和亚层号
  
implementation

uses MainDM, public_unit, YanTuMCTiHuan;

{$R *.dfm}

{ TEarthSampleForm }

procedure TEarthSampleTeShuForm.button_status(int_status: integer;
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
        chbIf_statistic.Enabled := false;
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
        chbIf_statistic.Enabled := true;
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
        chbIf_statistic.Enabled := true;
        m_DataSetState := dsInsert;
      end;
  end;
end;

function TEarthSampleTeShuForm.Check_Data: boolean;
var
  dSand_big,dSand_middle,dSand_small,
  dPowder_big,dPowder_small,dClay_grain,dLi,dTotal:double;
begin
  if trim(cboDrl_no.Text) = '' then
  begin
    messagebox(self.Handle,'请输入钻孔编号！','数据校对',mb_ok);
    cboDrl_no.SetFocus;
    result := false;
    exit;
  end;
  if trim(edtS_no.Text) = '' then
  begin
    messagebox(self.Handle,'请输入土样号！','数据校对',mb_ok);
    edtS_no.SetFocus;
    result := false;
    exit;
  end;
  if trim(edtS_depth_begin.Text) = '' then
  begin
    messagebox(self.Handle,'请输入取样深度！','数据校对',mb_ok);
    edtS_depth_begin.SetFocus;
    result := false;
    exit;
  end;
  if trim(edtS_depth_end.Text) = '' then
  begin
    messagebox(self.Handle,'请输入取样深度！','数据校对',mb_ok);
    edtS_depth_end.SetFocus;
    result := false;
    exit;
  end;

  result := true;
end;

procedure TEarthSampleTeShuForm.Get_oneRecord(aProjectNo, aDrillNo, aSampleNo:string; aRow: integer);
var 
  strFieldName,strValue: string;
  i:integer;
  myComponent: TComponent;
begin
  if trim(aProjectNo)='' then exit;
  if trim(aDrillNo)='' then exit;
  if trim(aSampleNo)='' then exit;
  with MainDataModule.qryEarthSample do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT * from TeShuYang');
      sql.Add(' where prj_no=' + ''''+stringReplace(aProjectNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND drl_no=' +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND s_no=' +''''+aSampleNo+''''); 
      open;
      
      while not Eof do
      begin 
        strFieldName:='';
        cbbSzsy_syff.ItemIndex := cbbSzsy_syff.Items.IndexOf(FieldByName('Szsy_syff').AsString);//yys 此句放在其他取值的前面是因为它的变化会引起CU和UU的总应力变化
        for i:=0 to self.ComponentCount-1 do
        begin
          myComponent:= self.Components[i];
          if myComponent is TEdit then
          begin
            strFieldName:= copy(myComponent.Name,4,length(myComponent.Name)-3);
            TEdit(myComponent).Text := FieldByName(strFieldName).AsString;
          end;
        end;

        cboCengHao.ItemIndex := cboCengHao.Items.IndexOf(sgSample.Cells[3,aRow]);
        cboStra_no.ItemIndex := cboCengHao.ItemIndex;
        cboSub_no.ItemIndex := cboCengHao.ItemIndex;
        
        cboDrl_no.ItemIndex := cboDrl_no.Items.IndexOf(FieldByName('drl_no').AsString);
        chbIf_statistic.Checked :=(FieldByName('if_statistic').AsBoolean =true);

        if cbbSzsy_syff.Text = 'UU' then
        begin
          edtszsy_zyl_njl_uu.Visible := True;
          edtszsy_zyl_nmcj_uu.Visible := True;
          //edtszsy_zyl_njl_uu.Text := edtszsy_zyl_njl_cu.Text ;
          edtszsy_zyl_njl_cu.Text := '';
          //edtszsy_zyl_nmcj_uu.Text := edtszsy_zyl_nmcj_cu.Text;
          edtszsy_zyl_nmcj_cu.Text := '';
          edtszsy_zyl_njl_cu.Visible := False;
          edtszsy_zyl_nmcj_cu.Visible := False;
        end
        else
        begin
          edtszsy_zyl_njl_uu.Visible := False;
          edtszsy_zyl_nmcj_uu.Visible := False;
          //edtszsy_zyl_njl_cu.Text := edtszsy_zyl_njl_uu.Text;
          edtszsy_zyl_njl_uu.Text := '';
          //edtszsy_zyl_nmcj_cu.Text := edtszsy_zyl_nmcj_uu.Text;
          edtszsy_zyl_nmcj_uu.Text := '';
          edtszsy_zyl_njl_cu.Visible := True;
          edtszsy_zyl_nmcj_cu.Visible := True;
        end;

        next;
      end;
      close;
    end;
end;

function TEarthSampleTeShuForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM TeShuYang '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(sgSample.Cells[4,sgSample.row] ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+sgSample.Cells[5,sgSample.row]+'''';
end;

function TEarthSampleTeShuForm.GetExistedSQL(aDrillNo, aSampleNo: string): string;
begin
  result := 'SELECT prj_no,drl_no,s_no FROM TeShuYang '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+aSampleNo+'''';
end;

function TEarthSampleTeShuForm.GetInsertSQL: string;
var 
  strSQLFields,strSQLValues,strSQL:string;
  strFieldName: string;
  i:integer;
begin
  strSQLFields:='prj_no,';
  strSQLValues:=''''+g_ProjectInfo.prj_no_ForSQL +''''+',';
  strFieldName:='';
  strSQL:='';
  for i:=0 to self.ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      if trim(TEdit(Components[i]).Text)<>'' then
      begin
        strFieldName := copy(Components[i].Name,4,length(Components[i].Name)-3);
        strSQLFields := strSQLFields + strFieldName + ',';    
        strSQLValues := strSQLValues +''''+stringReplace(trim(TEdit(Components[i]).Text) ,'''','''''',[rfReplaceAll])+''''+',';
      end;
    end;   
  end;                       
  strSQLFields := strSQLFields + 'drl_no' +',';
  strSQLValues := strSQLValues +''''+stringReplace(cboDrl_no.Text ,'''','''''',[rfReplaceAll])+''''+',';
//yys 200406010 modified  
  {if cboShear_type.ItemIndex>-1 then
  begin
    strSQLFields := strSQLFields + 'Shear_type'+',';
    strSQLValues := strSQLValues +''''+inttostr(cboShear_type.ItemIndex)+''''+',';
  end;}
//yys 200406010 modified
  strSQLFields := strSQLFields + 'if_statistic';
  if chbIf_statistic.Checked then
    strSQLValues := strSQLValues +'1'
  else
    strSQLValues := strSQLValues +'0';

  if cboStra_no.Text <> '' then
  begin
      strSQLFields := strSQLFields + ',stra_no,sub_no';
      strSQLValues := strSQLValues+','+''''+stringReplace(trim(cboStra_no.Text) ,'''','''''',[rfReplaceAll])+''''+','
        +''''+stringReplace(trim(cboSub_no.Text),'''','''''',[rfReplaceAll])+'''';
  end;

  
  strSQL := 'INSERT INTO TeShuYang ('+strSQLFields+') VALUES(' +strSQLValues+')';
  result := strSQL;
end;


function TEarthSampleTeShuForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,strSQL:string;
  strFieldName: string;
  i:integer;
begin
  strSQLWhere:=' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
           +' AND drl_no =' +''''+ stringReplace(sgSample.Cells[4,sgSample.Row] ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+sgSample.Cells[5,sgSample.Row]+'''';
  strSQLSet:='UPDATE TeShuYang SET ';
  strFieldName:='';
  strSQL:='';
  for i:=0 to self.ComponentCount-1 do
  begin
    if Components[i] is TEdit then
    begin
      strFieldName := copy(Components[i].Name,4,length(Components[i].Name)-3);
      if trim(TEdit(Components[i]).Text)<>'' then
        strSQLSet := strSQLSet + strFieldName+'='+''''+stringReplace(trim(TEdit(Components[i]).Text) ,'''','''''',[rfReplaceAll])+''''+','
      else
        strSQLSet := strSQLSet + strFieldName+'= NULL'+',';
    end;
  end;
  strSQLSet := strSQLSet + ' drl_no' +'='+''''+stringReplace(cboDrl_no.Text ,'''','''''',[rfReplaceAll])+''''+',';
//yys 200406010 modified
  {if cboShear_type.ItemIndex>-1 then
    strSQLSet := strSQLSet + ' Shear_type' +'='+''''+inttostr(cboShear_type.ItemIndex)+''''+','
  else
    strSQLSet := strSQLSet + ' Shear_type' +'=NULL,'; }
//yys 200406010 modified
  strSQLSet := strSQLSet + 'if_statistic'+'=';
  if chbIf_statistic.Checked then
    strSQLSet := strSQLSet +'1'
  else
    strSQLSet := strSQLSet +'0';

  if cboStra_no.Text <> '' then
  begin
      strSQLSet := strSQLSet+',stra_no='+''''+stringReplace(trim(cboStra_no.Text) ,'''','''''',[rfReplaceAll])+''''+','
        +'sub_no='+''''+stringReplace(trim(cboSub_no.Text),'''','''''',[rfReplaceAll])+'''';
  end;
  strSQL := strSQLSet+strSQLWhere;
  result := strSQL; 
end;

procedure TEarthSampleTeShuForm.GetAllDrillNo;
begin
  cboDrl_no.Clear;
  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no FROM drills ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      
      while not Eof do
      begin
        cboDrl_no.Items.Add(FieldByName('drl_no').AsString);
        next;
      end;
      close;
    end;
end;

procedure TEarthSampleTeShuForm.FormCreate(Sender: TObject);
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgSample.RowHeights[0] := 16;
  sgSample.ColCount := 4;
  sgSample.Cells[1,0] := '土样编号';  
  sgSample.Cells[2,0] := '取样深度';
  sgSample.Cells[3,0] := '土层编号';
  sgSample.ColWidths[0]:=10;
  sgSample.ColWidths[1]:=140;
  sgSample.ColWidths[2]:=80;
  sgSample.ColWidths[3]:=70;
  
  Clear_Data(self);
  GetCengHao;
  GetAllDrillNo;
  
  //GetStratumsByDrillNo(aDrillNo);
  RefreshData;

end;

procedure TEarthSampleTeShuForm.sgSampleSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   
  
  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
  begin
    if sgSample.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(g_ProjectInfo.prj_no,sgSample.Cells[4,ARow],
        sgSample.Cells[5,ARow],ARow);
      if sgSample.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
  end;
end;

procedure TEarthSampleTeShuForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    edtS_depth_begin.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    Get_oneRecord(g_ProjectInfo.prj_no,sgSample.Cells[4,sgSample.Row],
        sgSample.Cells[5,sgSample.Row],sgSample.Row);
  end;
end;

procedure TEarthSampleTeShuForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if (sgSample.Cells[1,sgSample.Row] <> '') and (trim(edtS_depth_begin.Text) <> '') then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryEarthSample,strSQL) then
        begin
          Clear_Data(self); 
          chbIf_statistic.Checked :=false;
          //suiform1.caption:= sgSample.Cells[4,sgSample.Row] + '-' + sgSample.Cells[4,sgSample.Row]; 
          DeleteStringGridRow(sgSample,sgSample.Row);
          //suiform1.caption:= suiform1.caption + sgSample.Cells[4,sgSample.Row] + '-' + sgSample.Cells[5,sgSample.Row];
          Get_oneRecord(g_ProjectInfo.prj_no,sgSample.Cells[4,sgSample.Row],
              sgSample.Cells[5,sgSample.Row],sgSample.Row);
          if sgSample.Cells[1,sgSample.row]='' then
            button_status(1,false)
          else
            button_status(1,true);
        end;
    end;
end;

procedure TEarthSampleTeShuForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEarthSampleTeShuForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TEarthSampleTeShuForm.btn_addClick(Sender: TObject);
var
   i: integer;
begin
  i := cboDrl_no.ItemIndex ;
  Clear_Data(self);
  chbIf_statistic.Checked := true;
  Button_status(3,true);
  cboDrl_no.ItemIndex := i;
  edtS_no.SetFocus;
end;

procedure TEarthSampleTeShuForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
  isSavedOk: boolean;
begin
  isSavedOk := false;
  if not Check_Data then exit;
  if m_DataSetState = dsInsert then
    begin
      strSQL := GetExistedSQL(trim(cboDrl_no.Text),trim(edtS_no.Text));
      if isExistedRecord(MainDataModule.qryEarthSample,strSQL) then
      begin
        MessageBox(self.Handle,PAnsiChar('试样编号'
          +trim(cboDrl_no.Text)+'-'+trim(edtS_no.Text)
          +'已经存在，不能重复输入。'),'数据库错误',MB_OK+MB_ICONERROR);
        exit;
      end;
      strSQL := GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryEarthSample,strSQL) then
        begin
          isSavedOk := true;
          sgSample.Tag := 1;
          if (sgSample.RowCount =2) and (sgSample.Cells[1,1] ='') then
          else
            begin
              
              sgSample.RowCount := sgSample.RowCount+2;
              sgSample.RowCount := sgSample.RowCount-1;
            end;
          sgSample.Row := sgSample.RowCount-1;
          sgSample.Tag := 0;
        end;
    end

  else if m_DataSetState = dsEdit then
    begin
      if sgSample.Cells[1,sgSample.Row]<>(trim(cboDrl_no.Text)+'-'+trim(edtS_no.Text)) then
        begin
          strSQL := GetExistedSQL(trim(cboDrl_no.Text),trim(edtS_no.Text));
          if isExistedRecord(MainDataModule.qryEarthSample,strSQL) then
          begin
            MessageBox(self.Handle,PAnsiChar('试样编号'
              +trim(cboDrl_no.Text)+'-'+trim(edtS_no.Text)
              +'已经存在，不能重复输入。'),'数据库错误',MB_OK+MB_ICONERROR);
            exit;
          end;        
        end;
      strSQL := self.GetUpdateSQL;
      if Update_oneRecord(MainDataModule.qryEarthSample,strSQL) then
        begin
          isSavedOk := true;
        end;      
    end;
  if isSavedOk then
  begin
    sgSample.Cells[1,sgSample.Row] := trim(cboDrl_no.Text)+'-'+trim(edtS_no.Text);
    sgSample.Cells[2,sgSample.Row] := trim(edtS_depth_begin.Text)+'~ '+trim(edtS_depth_end.Text);

    sgSample.Cells[3,sgSample.Row] := trim(cboCengHao.Text);

    sgSample.Cells[4,sgSample.Row] := trim(cboDrl_no.Text);
    sgSample.Cells[5,sgSample.Row] := trim(edtS_no.Text);
    Button_status(1,true);
    btn_add.SetFocus;
  end;
  
end;

procedure TEarthSampleTeShuForm.cboDrl_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TEarthSampleTeShuForm.edtS_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TEarthSampleTeShuForm.CalaculateData;
var
  dAquiferous_rate: double;//含水量
  dWet_density    : double;//湿密度
  dDry_density    : double;//干密度
  dSoil_proportion: double;//土粒比重
  dGap_rate       : Double;//孔隙比
  dGap_degree     : double;//孔隙度
  dSaturation     : double;//饱合度
  dLiquid_limit   : double;//液限
  dShape_limit    : double;//塑限
  dShape_index    : double;//塑性指数
  dLiquid_index   : double;//液性指数
begin
//  dAquiferous_rate:=0;
//  if isFloat(trim(edtAquiferous_rate.Text)) then
//    begin
//      dAquiferous_rate := strToFloat(trim(edtAquiferous_rate.Text));
//      if isFloat(trim(edtWet_density.Text)) then
//        begin
//          dWet_density := strToFloat(trim(edtWet_density.Text));
//
//          dDry_density := GetGanMiDu(dAquiferous_rate, dWet_density);
//          edtDry_density.Text := FormatFloat('0.00',dDry_density);
//          
//          if isFloat(trim(edtSoil_proportion.Text)) then
//            begin
//              dSoil_proportion := strToFloat(trim(edtSoil_proportion.Text));
//              dGap_rate := GetKongXiBi(dSoil_proportion,dDry_density);
//              dGap_degree := GetKongXiDu(dGap_rate);
//              dSaturation := GetBaoHeDu(dAquiferous_rate,dSoil_proportion,dGap_rate);
//              edtGap_rate.Text := FormatFloat('0.000',dGap_rate);
//              edtGap_degree.Text := FormatFloat('0',dGap_degree);
//              edtSaturation.Text := FormatFloat('0',dSaturation);
//            end
//          else  // isFloat(trim(edtSoil_proportion.Text))
//            begin
//              edtGap_rate.Text := '';
//              edtGap_degree.Text := '';
//              edtSaturation.Text := '';
//            end;
//        end
//      else //isFloat(trim(edtWet_density.Text))
//        begin
//          edtDry_density.Text := '';
//          edtGap_rate.Text := '';
//          edtGap_degree.Text := '';
//          edtSaturation.Text := '';          
//        end;
//    end
//  else //isFloat(trim(edtAquiferous_rate.Text))
//    begin
//      edtDry_density.Text := '';
//      edtGap_rate.Text := '';
//      edtGap_degree.Text := '';
//      edtSaturation.Text := '';
//      edtLiquid_index.Text := '';
//    end;
//
//  if isFloat(trim(edtLiquid_limit.Text)) and isFloat(trim(edtShape_limit.Text)) then
//    begin
//      dLiquid_limit := strToFloat(trim(edtLiquid_limit.Text));
//      dShape_limit  := strToFloat(trim(edtShape_limit.Text));
//      dShape_index  := GetSuXingZhiShu(dLiquid_limit,dShape_limit);
//      edtShape_index.Text := FormatFloat('0.0',dShape_index);
//      if (dShape_index<>0) and isFloat(trim(edtAquiferous_rate.Text)) then
//        begin
//          dLiquid_index := GetYeXingZhiShu(dAquiferous_rate,dShape_limit,dLiquid_limit);
//          edtLiquid_index.Text := FormatFloat('0.00',dLiquid_index);
//        end
//      else
//          edtLiquid_index.Text := '';
//    end
//  else //isFloat(trim(edtLiquid_limit.Text)) and isFloat(trim(edtShape_limit.Text))
//    begin
//      edtShape_index.Text := '';
//      edtLiquid_index.Text := '';
//    end;
end;

procedure TEarthSampleTeShuForm.edtgygj_pcChange(Sender: TObject);
begin
  if (m_DataSetState = dsInsert) or (m_DataSetState = dsEdit) then
  try
    CalaculateData;
  except
  end;
end;

procedure TEarthSampleTeShuForm.edtgygj_pcKeyPress(Sender: TObject;
  var Key: Char);
var
  strHead,strEnd,strAll,strFraction:string;
  iDecimalSeparator:integer;
  
begin
  //如果是整数，直接屏蔽掉小数点。
  if (TEdit(Sender).Tag=0) and (key='.') then
  begin
    key:=#0;
    exit;
  end;
  
  //屏蔽掉科学计数法。
  if (lowercase(key)='e') or (key=' ') then
  begin
    key:=#0;
    exit;
  end;

  if (key='-') or (key='+') then
  begin
    key:=#0;
    exit;
  end;

  if key =chr(vk_back) then exit;
  
  try
    strHead := copy(TEdit(Sender).Text,1,TEdit(Sender).SelStart);
    strEnd  := copy(TEdit(Sender).Text,TEdit(Sender).SelStart+TEdit(Sender).SelLength+1,length(TEdit(Sender).Text));
    strAll := strHead+key+strEnd;
    
    if (strAll)='-' then
      begin
         TEdit(Sender).Text :='-';
         TEdit(Sender).SelStart :=2;
         key:=#0;
         exit;
      end;
      
    strtofloat(strAll);
    iDecimalSeparator:= pos('.',strAll);
    if iDecimalSeparator>0 then
      begin
        strFraction:= copy(strall,iDecimalSeparator+1,length(strall));
        if (iDecimalSeparator>0) and (length(strFraction)>TEdit(Sender).Tag) then
          key:=#0;
      end;
  except
    key:=#0;
  end;

end;

procedure TEarthSampleTeShuForm.edtS_depth_beginChange(Sender: TObject);
begin
  try
    edtS_depth_end.Text := floattostr(strtofloat(edtS_depth_begin.Text)+0.3);
  except
       
  end;
end;

procedure TEarthSampleTeShuForm.GetCengHao;
begin
  with MainDataModule.qryStratum_desc do
    begin
      close;
      sql.Clear;
      sql.Add('select id,prj_no,stra_no,sub_no FROM stratum_description');
      sql.Add(' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''');
      sql.Add(' ORDER BY id'); 
      open;
      while not Eof do
        begin
          cboStra_no.Items.Add(FieldByName('stra_no').AsString); 
          cboSub_no.Items.Add(FieldByName('sub_no').AsString);
          if FieldByName('sub_no').AsString='0' then
            cboCengHao.Items.Add(FieldByName('stra_no').AsString)
          else
            cboCengHao.Items.Add(FieldByName('stra_no').AsString+m_strFenGeFu+FieldByName('sub_no').AsString);
          Next ;
        end;
      close;
    end;
end;

procedure TEarthSampleTeShuForm.cboCengHaoChange(Sender: TObject);
begin
  cboStra_no.ItemIndex := cboCengHao.ItemIndex;
  cboSub_no.ItemIndex := cboCengHao.ItemIndex;
end;

procedure TEarthSampleTeShuForm.btn_FenCengClick(Sender: TObject);
var
  iDrillCount,iStratumCount:integer;
  strSQL: string;
  lstDrillsNo,lstStratumNo,lstSubNo,
  lstStratumDepth,lstStratumBottDepth:TStringList;
  procedure GetDrillNo(var AStingList: TStringList);
  begin
    AStingList.Clear;
    with MainDataModule.qryDrills do
      begin
        close;
        sql.Clear;
        //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
        sql.Add('SELECT prj_no,drl_no FROM drills ');
        sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
        open;
        while not Eof do
          begin
            AStingList.Add(FieldByName('drl_no').AsString);
            Next ;
          end;
        close;
      end;    
  end;
  procedure GetStramDepth(const aDrillNo: string;
   var AStratumNoList, ASubNoList, ABottList: TStringList);
  begin
    AStratumNoList.Clear;
    ASubNoList.Clear;
    ABottList.Clear;
    strSQL:='SELECT drl_no,stra_no,sub_no,stra_depth '
      +' FROM stratum '
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND drl_no='+''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
      +' ORDER BY stra_depth';
    with MainDataModule.qryStratum do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        while not eof do
          begin
            AStratumNoList.Add(FieldByName('stra_no').AsString); 
            ASubNoList.Add(FieldByName('sub_no').AsString);
            ABottList.Add(FieldByName('stra_depth').AsString);
            next; 
          end;
        close;
      end;
  end;
  procedure FreeStringList;
  begin
    lstDrillsNo.Free;;
    lstStratumNo.Free;
    lstSubNo.Free;
    lstStratumDepth.Free;
    lstStratumBottDepth.Free;
  end;
begin
  lstDrillsNo := TStringList.Create;
  lstStratumNo:= TStringList.Create;
  lstSubNo:= TStringList.Create;
  lstStratumDepth:= TStringList.Create;
  lstStratumBottDepth:= TStringList.Create;  
  GetDrillNo(lstDrillsNo);
  if lstDrillsNo.Count =0 then 
  begin
    FreeStringList;
    exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    //清除工程中所有土样的层和亚层的信息    
    strSQL:= 'UPDATE TeShuYang set stra_no=null,sub_no=0 '
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''';
      with MainDataModule.qryEarthSample do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        ExecSQL;
        close; 
      end;
    //开始给各土样分层，土样的深度在钻孔的哪一层，它的层号就是那一个.  
    for iDrillCount:= 0 to lstDrillsNo.Count-1 do
      begin
        GetStramDepth(lstDrillsNo.Strings[iDrillCount],
          lstStratumNo, lstSubNo, lstStratumBottDepth);
        if lstStratumNo.Count =0 then continue;

        for iStratumCount:=0 to lstStratumNo.Count -1 do
        begin
          if iStratumCount=0 then
            strSQL:='UPDATE TeShuYang Set '
              +'stra_no='+''''+stringReplace(lstStratumNo.Strings[iStratumCount] ,'''','''''',[rfReplaceAll])+''''+','
              +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
              +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
              +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
              +' AND s_depth_begin>=0 '
              +' AND s_depth_begin<'+lstStratumBottDepth.Strings[iStratumCount]
          else
            strSQL:='UPDATE TeShuYang Set '
              +'stra_no='+''''+stringReplace(lstStratumNo.Strings[iStratumCount] ,'''','''''',[rfReplaceAll])+''''+','
              +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
              +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
              +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
              +' AND s_depth_begin>=' + lstStratumBottDepth.Strings[iStratumCount-1]
              +' AND s_depth_begin<'+lstStratumBottDepth.Strings[iStratumCount];          
          with MainDataModule.qryEarthSample do
          begin
            close;
            sql.Clear;
            sql.Add(strSQL);
            ExecSQL;
            close;   
          end;
        end;
      end;
    finally
      FreeStringList;
      RefreshData;
      screen.Cursor := crDefault;
    end;
end;


procedure TEarthSampleTeShuForm.btn_TiHuanClick(Sender: TObject);
begin
    FormYanTuMCTiHuan := TFormYanTuMCTiHuan.Create(self);
    FormYanTuMCTiHuan.SetUpdateTableName('TeShuYang');
    FormYanTuMCTiHuan.ShowModal;
    RefreshData;
end;

procedure TEarthSampleTeShuForm.RefreshData;
var 
  i: integer;
begin
  with MainDataModule.qryEarthSample do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no,s_no,s_depth_begin,s_depth_end,stra_no,sub_no');
      sql.Add(' FROM TeShuYang');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      sql.Add(' ORDER BY drl_no,s_no');
      open;
      i:=0;
      sgSample.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          sgSample.RowCount := i +2;
          sgSample.Cells[1,i] := FieldByName('drl_no').AsString+'-'+FieldByName('s_no').AsString;
          sgSample.Cells[2,i] := FormatFloat('0.00',FieldByName('s_depth_begin').AsFloat)
            +'~ '+FormatFloat('0.00',FieldByName('s_depth_end').AsFloat);
            
          if FieldByName('sub_no').AsString='0' then
            sgSample.Cells[3,i] := FieldByName('stra_no').AsString
          else if FieldByName('stra_no').AsString<>'' then
            sgSample.Cells[3,i] := FieldByName('stra_no').AsString+m_strFenGeFu+FieldByName('sub_no').AsString;
 
          sgSample.Cells[4,i] := FieldByName('drl_no').AsString;  
          sgSample.Cells[5,i] := FieldByName('s_no').AsString;
          sgSample.Cells[6,i] := FieldByName('s_depth_begin').AsString;
          sgSample.Cells[7,i] := FieldByName('s_depth_end').AsString;
          sgSample.RowCount := i +1;
          Next ;
        end;
      close;
      sgSample.Tag :=0;
    end;
  if i>0 then
  begin
    Get_oneRecord(g_ProjectInfo.prj_no,sgSample.Cells[4,1],
      sgSample.Cells[5,1],1);
    sgSample.Row :=1;
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TEarthSampleTeShuForm.cbbSzsy_syffChange(Sender: TObject);
begin
  if cbbSzsy_syff.Text = 'UU' then
  begin
    edtszsy_zyl_njl_uu.Visible := True;
    edtszsy_zyl_nmcj_uu.Visible := True;
    edtszsy_zyl_njl_uu.Text := edtszsy_zyl_njl_cu.Text ;
    edtszsy_zyl_njl_cu.Text := '';
    edtszsy_zyl_nmcj_uu.Text := edtszsy_zyl_nmcj_cu.Text;
    edtszsy_zyl_nmcj_cu.Text := '';
    edtszsy_zyl_njl_cu.Visible := False;
    edtszsy_zyl_nmcj_cu.Visible := False;
  end
  else
  begin
    edtszsy_zyl_njl_uu.Visible := False;
    edtszsy_zyl_nmcj_uu.Visible := False;
    edtszsy_zyl_njl_cu.Text := edtszsy_zyl_njl_uu.Text;
    edtszsy_zyl_njl_uu.Text := '';
    edtszsy_zyl_nmcj_cu.Text := edtszsy_zyl_nmcj_uu.Text;
    edtszsy_zyl_nmcj_uu.Text := '';
    edtszsy_zyl_njl_cu.Visible := True;
    edtszsy_zyl_nmcj_cu.Visible := True;
  end
  
end;

end.
