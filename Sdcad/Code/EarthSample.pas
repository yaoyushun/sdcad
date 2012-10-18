unit EarthSample;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, ExtCtrls, DB, math;

type
  TEarthSampleForm = class(TForm)
    Panel1: TPanel;
    sgSample: TStringGrid;
    Panel2: TPanel;
    lblStra_no: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label31: TLabel;
    edtAquiferous_rate: TEdit;
    edtSoil_proportion: TEdit;
    edtGap_rate: TEdit;
    edtGap_degree: TEdit;
    edtSaturation: TEdit;
    GroupBox9: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    edtDry_density: TEdit;
    edtWet_density: TEdit;
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
    edtLiquid_limit: TEdit;
    edtShape_limit: TEdit;
    edtShape_index: TEdit;
    edtLiquid_index: TEdit;
    edtZip_coef: TEdit;
    edtZip_modulus: TEdit;
    GroupBox4: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edtCohesion: TEdit;
    edtFriction_angle: TEdit;
    cboShear_type: TComboBox;
    GroupBox5: TGroupBox;
    Label21: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label34: TLabel;
    GroupBox6: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtSand_big: TEdit;
    edtSand_middle: TEdit;
    edtSand_small: TEdit;
    GroupBox7: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    edtPowder_big: TEdit;
    edtPowder_small: TEdit;
    edtClay_grain: TEdit;
    edtLi: TEdit;
    GroupBox8: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    edtAsymmetry_coef: TEdit;
    edtCurvature_coef: TEdit;
    chbIf_statistic: TCheckBox;
    GroupBox10: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    edtCohesion_gk: TEdit;
    edtFriction_gk: TEdit;
    cboCengHao: TComboBox;
    cboStra_no: TComboBox;
    cboSub_no: TComboBox;
    GroupBox11: TGroupBox;
    Label32: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    edtyssy_yali: TEdit;
    edtyssy_kxb: TEdit;
    edtyssy_ysxs: TEdit;
    edtyssy_ysml: TEdit;
    StatusBar1: TStatusBar;
    Panel3: TPanel;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    btn_FenCeng: TBitBtn;
    btn_TiHuan: TBitBtn;
    btnYaSuoJiSuan: TBitBtn;
    btnYaSuoJiSuan_all: TBitBtn;
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
    procedure edtAquiferous_rateChange(Sender: TObject);
    procedure edtAquiferous_rateKeyPress(Sender: TObject; var Key: Char);
    procedure edtS_depth_beginChange(Sender: TObject);
    procedure cboCengHaoChange(Sender: TObject);
    procedure btn_FenCengClick(Sender: TObject);
    procedure btn_TiHuanClick(Sender: TObject);
    procedure btnYaSuoJiSuanClick(Sender: TObject);
    procedure btnYaSuoJiSuan_allClick(Sender: TObject);
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
  EarthSampleForm: TEarthSampleForm;
  m_DataSetState: TDataSetState;

const
  m_strFenGeFu='---';  //用来分隔层号和亚层号
  
implementation

uses MainDM, public_unit, SdCadMath, YanTuMCTiHuan;

{$R *.dfm}

{ TEarthSampleForm }

procedure TEarthSampleForm.button_status(int_status: integer;
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

function TEarthSampleForm.Check_Data: boolean;
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
  dSand_big:=0;
  dSand_middle:=0;
  dSand_small:=0;
  dPowder_big:=0;
  dPowder_small:=0;
  dClay_grain:=0;
  dLi:= 0;
  dTotal:=0;
  if isfloat(edtSand_big.Text) then dSand_big:= strtoFloat(edtSand_big.Text);
  if isfloat(edtSand_middle.Text) then dSand_middle:= strtoFloat(edtSand_middle.Text);
  if isfloat(edtSand_small.Text) then dSand_small:= strtoFloat(edtSand_small.Text);
  if isfloat(edtPowder_big.Text) then dPowder_big:= strtoFloat(edtPowder_big.Text);
  if isfloat(edtPowder_small.Text) then dPowder_small:= strtoFloat(edtPowder_small.Text);
  if isfloat(edtClay_grain.Text) then dClay_grain:= strtoFloat(edtClay_grain.Text);
  if isfloat(edtLi.Text) then dLi:= strtoFloat(edtLi.Text);

  dTotal:= dSand_big + dSand_middle + dSand_small 
          +dPowder_big + dPowder_small + dClay_grain + dLi;
  if (not iszero(dTotal)) and (not SameValue(dTotal,100)) then
  begin
    messagebox(self.Handle,'土粒组成之和必须等于100 ！','数据校对',mb_ok);
    edtSand_big.SetFocus;
    result := false;
    exit;    
  end; 
  result := true;
end;

procedure TEarthSampleForm.Get_oneRecord(aProjectNo, aDrillNo, aSampleNo:string; aRow: integer); 
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
      sql.Add('SELECT * from earthsample');
      sql.Add(' where prj_no=' + ''''+stringReplace(aProjectNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND drl_no=' +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND s_no=' +''''+aSampleNo+''''); 
      open;
      
      while not Eof do
      begin 
        strFieldName:='';
        for i:=0 to self.ComponentCount-1 do
        begin
          myComponent:= self.Components[i]; 
          if myComponent is TEdit then
          begin
            strFieldName:= copy(myComponent.Name,4,length(myComponent.Name)-3);
            TEdit(myComponent).Text := FieldByName(strFieldName).AsString;
          end;
        end;
//yys 200406010 modified
        {strValue:= FieldByName('shear_type').AsString;
        if strValue='' then 
          cboShear_type.ItemIndex := -1
        else
          cboShear_type.ItemIndex := FieldByName('shear_type').AsInteger;}
//yys 200406010 modified
        cboCengHao.ItemIndex := cboCengHao.Items.IndexOf(sgSample.Cells[3,aRow]);
        cboStra_no.ItemIndex := cboCengHao.ItemIndex;
        cboSub_no.ItemIndex := cboCengHao.ItemIndex;
        
        cboDrl_no.ItemIndex := cboDrl_no.Items.IndexOf(FieldByName('drl_no').AsString);
        chbIf_statistic.Checked :=(FieldByName('if_statistic').AsBoolean =true);
        next;
      end;
      close;
    end;
end;

function TEarthSampleForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM earthsample '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(sgSample.Cells[4,sgSample.row] ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+sgSample.Cells[5,sgSample.row]+'''';
end;

function TEarthSampleForm.GetExistedSQL(aDrillNo, aSampleNo: string): string;
begin
  result := 'SELECT prj_no,drl_no,s_no FROM earthsample '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+aSampleNo+'''';
end;

function TEarthSampleForm.GetInsertSQL: string;
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

  
  strSQL := 'INSERT INTO earthsample ('+strSQLFields+') VALUES(' +strSQLValues+')';  
  result := strSQL;
end;


function TEarthSampleForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,strSQL:string;
  strFieldName: string;
  i:integer;
begin
  strSQLWhere:=' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
           +' AND drl_no =' +''''+ stringReplace(sgSample.Cells[4,sgSample.Row] ,'''','''''',[rfReplaceAll])+''''
           +' AND s_no='  +''''+sgSample.Cells[5,sgSample.Row]+'''';
  strSQLSet:='UPDATE earthsample SET ';
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

procedure TEarthSampleForm.GetAllDrillNo;
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

procedure TEarthSampleForm.FormCreate(Sender: TObject);
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

procedure TEarthSampleForm.sgSampleSelectCell(Sender: TObject; ACol,
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

procedure TEarthSampleForm.btn_editClick(Sender: TObject);
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

procedure TEarthSampleForm.btn_deleteClick(Sender: TObject);
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

procedure TEarthSampleForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TEarthSampleForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TEarthSampleForm.btn_addClick(Sender: TObject);
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

procedure TEarthSampleForm.btn_okClick(Sender: TObject);
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

procedure TEarthSampleForm.cboDrl_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TEarthSampleForm.edtS_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TEarthSampleForm.CalaculateData;
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
  dAquiferous_rate:=0;
  if isFloat(trim(edtAquiferous_rate.Text)) then
    begin
      dAquiferous_rate := strToFloat(trim(edtAquiferous_rate.Text));
      if isFloat(trim(edtWet_density.Text)) then
        begin
          dWet_density := strToFloat(trim(edtWet_density.Text));

          dDry_density := GetGanMiDu(dAquiferous_rate, dWet_density);
          edtDry_density.Text := FormatFloat('0.00',dDry_density);
          
          if isFloat(trim(edtSoil_proportion.Text)) then
            begin
              dSoil_proportion := strToFloat(trim(edtSoil_proportion.Text));
              dGap_rate := GetKongXiBi(dSoil_proportion,dDry_density);
              dGap_degree := GetKongXiDu(dGap_rate); 
              dSaturation := GetBaoHeDu(dAquiferous_rate,dSoil_proportion,dGap_rate);
              edtGap_rate.Text := FormatFloat('0.000',dGap_rate);
              edtGap_degree.Text := FormatFloat('0',dGap_degree);
              edtSaturation.Text := FormatFloat('0',dSaturation);
            end
          else  // isFloat(trim(edtSoil_proportion.Text))
            begin
              edtGap_rate.Text := '';
              edtGap_degree.Text := '';
              edtSaturation.Text := '';
            end;
        end
      else //isFloat(trim(edtWet_density.Text))
        begin
          edtDry_density.Text := '';
          edtGap_rate.Text := '';
          edtGap_degree.Text := '';
          edtSaturation.Text := '';          
        end;
    end
  else //isFloat(trim(edtAquiferous_rate.Text))
    begin
      edtDry_density.Text := '';
      edtGap_rate.Text := '';
      edtGap_degree.Text := '';
      edtSaturation.Text := '';
      edtLiquid_index.Text := '';
    end;
    
  if isFloat(trim(edtLiquid_limit.Text)) and isFloat(trim(edtShape_limit.Text)) then
    begin
      dLiquid_limit := strToFloat(trim(edtLiquid_limit.Text));
      dShape_limit  := strToFloat(trim(edtShape_limit.Text));
      dShape_index  := GetSuXingZhiShu(dLiquid_limit,dShape_limit);
      edtShape_index.Text := FormatFloat('0.0',dShape_index);
      if (dShape_index<>0) and isFloat(trim(edtAquiferous_rate.Text)) then
        begin
          dLiquid_index := GetYeXingZhiShu(dAquiferous_rate,dShape_limit,dLiquid_limit);
          edtLiquid_index.Text := FormatFloat('0.00',dLiquid_index);
        end
      else
          edtLiquid_index.Text := '';
    end
  else //isFloat(trim(edtLiquid_limit.Text)) and isFloat(trim(edtShape_limit.Text))
    begin
      edtShape_index.Text := '';
      edtLiquid_index.Text := '';
    end;  
end;

procedure TEarthSampleForm.edtAquiferous_rateChange(Sender: TObject);
begin
  if (m_DataSetState = dsInsert) or (m_DataSetState = dsEdit) then
  try
    CalaculateData;
  except
  end;
end;

procedure TEarthSampleForm.edtAquiferous_rateKeyPress(Sender: TObject;
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

procedure TEarthSampleForm.edtS_depth_beginChange(Sender: TObject);
begin
  try
    edtS_depth_end.Text := floattostr(strtofloat(edtS_depth_begin.Text)+0.3);
  except
       
  end;
end;

procedure TEarthSampleForm.GetCengHao;
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

procedure TEarthSampleForm.cboCengHaoChange(Sender: TObject);
begin
  cboStra_no.ItemIndex := cboCengHao.ItemIndex;
  cboSub_no.ItemIndex := cboCengHao.ItemIndex;
end;

procedure TEarthSampleForm.btn_FenCengClick(Sender: TObject);
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
    strSQL:= 'UPDATE earthsample set stra_no=null,sub_no=0 '
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
            strSQL:='UPDATE earthsample Set '
              +'stra_no='+''''+stringReplace(lstStratumNo.Strings[iStratumCount] ,'''','''''',[rfReplaceAll])+''''+','
              +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
              +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
              +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
              +' AND s_depth_begin>=0 '
              +' AND s_depth_begin<'+lstStratumBottDepth.Strings[iStratumCount]
          else
            strSQL:='UPDATE earthsample Set '
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


procedure TEarthSampleForm.btn_TiHuanClick(Sender: TObject);
begin
    FormYanTuMCTiHuan := TFormYanTuMCTiHuan.Create(self);
    FormYanTuMCTiHuan.SetUpdateTableName('earthsample');
    FormYanTuMCTiHuan.ShowModal;
    RefreshData; 
end;

procedure TEarthSampleForm.RefreshData;
var 
  i: integer;
begin
  with MainDataModule.qryEarthSample do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no,s_no,s_depth_begin,s_depth_end,stra_no,sub_no');
      sql.Add(' FROM earthsample');
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

procedure TEarthSampleForm.btnYaSuoJiSuanClick(Sender: TObject);
var
  lstYali,lstKongxibi,lstYsxs,lstYsml:TStringList;
  i:Integer;
  kxb_ChuShi,yali_ChuShi,kxb_0,kxb_1,yali_0,yali_1, YaSuoMoLiang ,YaSuoXiShu:Double;


  procedure freeList();
  begin
    lstYali.Free ;
    lstKongxibi.Free;
    lstYsxs.Free;
    lstYsml.Free;
  end;
begin
  lstYali := TStringList.Create;
  lstKongxibi := TStringList.Create;
  lstYsxs := TStringList.Create;
  lstYsml := TStringList.Create;
  DivideString(edtyssy_yali.Text,',',lstYali);
  DivideString(edtyssy_kxb.Text,',',lstKongxibi);
  if lstYali.Count<>lstKongxibi.Count then
  begin
    Application.MessageBox('压力和孔隙比的个数不一致，请检查修改！','数据检查',MB_OK);
    edtyssy_yali.SetFocus;
    freeList;
    exit;
  end
  else if lstYali.Count>1 then
  begin
    yali_0 := StrToFloat(lstYali[0]);
    if edtGap_rate.Text<>'' then
      kxb_ChuShi := StrToFloat(edtGap_rate.Text);
    yali_ChuShi := 0;

    yali_0 := StrToFloat(lstYali[0]);
    kxb_0 := StrToFloat(lstKongxibi[0]);
    YaSuoXiShu := getYaSuoXiShu(kxb_ChuShi,kxb_0,yali_ChuShi,yali_0);
    YaSuoMoLiang := getYaSuoMoLiang(kxb_ChuShi,YaSuoXiShu);
    edtyssy_ysxs.Text := FormatFloat('0.000',DoRound(YaSuoXiShu*1000)/1000);
    edtyssy_ysml.Text := FormatFloat('0.00',DoRound(YaSuoMoLiang*100)/100);
    for i:=1 to lstYali.Count-1 do
    begin

       yali_1 := StrToFloat(lstYali[i]);
       kxb_1 := StrToFloat(lstKongxibi[i]);
       YaSuoXiShu := getYaSuoXiShu(kxb_0,kxb_1,yali_0,yali_1);
       YaSuoMoLiang := getYaSuoMoLiang(kxb_ChuShi,YaSuoXiShu);
       lstYsxs.Add(FormatFloat('0.000',DoRound(YaSuoXiShu*1000)/1000));
       lstYsml.Add(FormatFloat('0.00',DoRound(YaSuoMoLiang*100)/100));
       edtyssy_ysxs.Text := edtyssy_ysxs.Text + ',' + lstYsxs[lstYsxs.Count-1];
       edtyssy_ysml.Text := edtyssy_ysml.Text + ',' + lstYsml[lstYsml.Count-1];
       yali_0 := StrToFloat(lstYali[i]);
       kxb_0 := StrToFloat(lstKongxibi[i]);
    end;

  end;
  freeList;
end;

procedure TEarthSampleForm.btnYaSuoJiSuan_allClick(Sender: TObject);
begin
  if MessageBox(self.Handle,
    '所有土样的压缩系数和压缩模量都会重新生成，且不能恢复，请确保压力和孔隙比数据已经去掉了回弹数据。'
     +#13+ '您确定要开始计算吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;

  RefreshData;
end;

end.
