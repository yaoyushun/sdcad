unit Stratum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons, rxToolEdit, DB;

type
  TStratumForm = class(TForm)
    pnl3: TPanel;
    lblEa_Name: TLabel;
    lblStra_no: TLabel;
    lblDescription: TLabel;
    lblStra_category: TLabel;
    lblStraDepth: TLabel;
    lblDescription_en: TLabel;
    lblStra_fao: TLabel;
    lblStra_qik: TLabel;
    sgStratum: TStringGrid;
    cboEa_name: TComboBox;
    cboEa_no: TComboBox;
    MemDescription: TMemo;
    MemTemp: TMemo;
    cboStra_category: TComboBox;
    cboCengHao: TComboBox;
    cboStra_no: TComboBox;
    cboSub_no: TComboBox;
    edtStra_depth: TEdit;
    MemTemp_en: TMemo;
    MemDescription_en: TMemo;
    edtStra_fao: TEdit;
    edtStra_qik: TEdit;
    pnl2: TPanel;
    btn_cancel: TBitBtn;
    btn_delete: TBitBtn;
    btn_add: TBitBtn;
    btn_ok: TBitBtn;
    btn_edit: TBitBtn;
    pnl4: TPanel;
    sgDrills: TStringGrid;
    pnl5: TPanel;
    imgDrill: TImage;
    lblstra_category92: TLabel;
    cboStra_category92: TComboBox;
    chkHide: TCheckBox;
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure sgStratumSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtStra_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboEa_nameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure sgDrillsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDrillsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgStratumDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cboCengHaoChange(Sender: TObject);
    procedure cboCengHaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTop_elevKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemDescriptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStra_depthKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStra_depthChange(Sender: TObject);
    procedure edtStra_depthKeyPress(Sender: TObject; var Key: Char);
    procedure edtStra_depthExit(Sender: TObject);
    procedure edtStra_qikKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkHideClick(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure GetStratumsByDrillNo(aDrillNo: string);
    procedure Get_EarthType;
    procedure Get_StratumCategory;
    procedure DrawDrill(aRow:integer);
    procedure Get_oneRecord(aDrillNo:string;aRow:Integer);
    procedure GetCengHao;
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function GetExistedSQL(aStratumNo: string; aSub_no: string):string;
    function Check_Data:boolean;
    procedure GetDescByStraNo(aStratumNo: string; aSub_no: String);
  public
    { Public declarations }
  end;

var
  StratumForm: TStratumForm;
  m_DataSetState: TDataSetState;
  m_drill_type: String;
const
  m_strFenGeFu='---';  //用来分隔层号和亚层号
implementation

uses MainDM, public_unit, DrillDiagram;
var m_DrillDiagram: TDrillDiagram;
{$R *.dfm}

{ TStratumForm }

procedure TStratumForm.button_status(int_status: integer;
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

function TStratumForm.Check_Data: boolean;
var
  i,iRow:integer;
  dStra_depth,dTempDepth: double;
begin
  if trim(cboCengHao.Text) = '' then
  begin
    messagebox(self.Handle,'请选择层号！','数据校对',mb_ok);
    cboCengHao.SetFocus;
    result := false;
    exit;
  end;
  if m_DataSetState = dsInsert then
    for iRow:=1 to sgStratum.RowCount-1 do
      if sgStratum.Cells[1,iRow]=cboCengHao.Text then
      begin
        messagebox(self.Handle,'此层号已存在，不能增加！','数据校对',mb_ok);
        cboCengHao.SetFocus;
        result := false;
        exit;
      end;      
  if trim(cboEa_name.Text) = '' then
  begin
    messagebox(self.Handle,'请选择岩土名称！','数据校对',mb_ok);
    cboEa_name.SetFocus;
    result := false;
    exit;
  end;
  
  if cboEa_name.Items.IndexOf(trim(cboEa_name.Text)) <0 then
  begin
    messagebox(self.Handle,'请选择正确的岩土名称！','数据校对',mb_ok);
    cboEa_name.SetFocus;
    result := false;
    exit;
  end;  
  if trim(edtStra_depth.Text) = '' then
  begin
    messagebox(self.Handle,'请输入层深！','数据校对',mb_ok);
    edtStra_depth.SetFocus;
    result := false;
    exit;
  end
  else
  begin
    if sgDrills.Cells[3,sgDrills.Row]='' then
    begin
      messagebox(self.Handle,'请在钻孔数据中输入孔深！','数据校对',mb_ok);
      edtStra_depth.SetFocus;
      result := false;
      exit;
    end;    
    if strtofloat(edtStra_depth.Text)>strtofloat(sgDrills.Cells[3,sgDrills.Row]) then
    begin
      messagebox(self.Handle,'层深不能超过孔深！','数据校对',mb_ok);
      edtStra_depth.SetFocus;
      result := false;
      exit;
    end;
    //开始判断此层的层深是否大于它上面所有的层的深度，小于它下面所有的层的层深。
    dStra_depth:= StrToFloat(edtStra_depth.Text);
    for i:=0 to cboCengHao.ItemIndex-1 do
      for iRow:=1 to sgStratum.RowCount-1 do
      begin
       if (m_DataSetState = dsEdit) and (iRow=sgStratum.Row) then continue;
       if (sgstratum.Cells[1,iRow]=cboCengHao.Items.Strings[i]) and (isfloat(sgstratum.Cells[3,iRow])) then
       begin
         dTempDepth:= StrToFloat(sgStratum.Cells[3,iRow]);
         if dStra_depth<=dTempDepth then
         begin
           messagebox(self.Handle,pChar('当前层的层深应超过'+sgstratum.Cells[1,iRow]+'层的层深！'),'数据校对',mb_ok); 
           result:= false;
           exit;
         end;
       end;
      end;
    for i:=cboCengHao.ItemIndex+1 to cboCengHao.Items.Count-1  do
      for iRow:=1 to sgStratum.RowCount-1 do
      begin
        if (m_DataSetState = dsEdit) and (iRow=sgStratum.Row) then continue;
        if (sgstratum.Cells[1,iRow]=cboCengHao.Items.Strings[i]) and (isfloat(sgstratum.Cells[3,iRow])) then
        begin
          dTempDepth:= StrToFloat(sgStratum.Cells[3,iRow]);
          if dStra_depth>=dTempDepth then
          begin
            messagebox(self.Handle,pChar('当前层的层深应小于'+sgstratum.Cells[1,iRow]+'层的层深！'),'数据校对',mb_ok); 
            result:= false;
            exit;
          end;
        end;       
      end;
  end;
  result := true;
end;

procedure TStratumForm.Get_oneRecord(aDrillNo:string;aRow: Integer);
var 
  strSQL: string;
begin
  cboEa_name.ItemIndex := cboEa_name.Items.IndexOf(sgStratum.Cells[2,aRow]); 
  //cboEa_name.Text := sgStratum.Cells[3,aRow]; 
  cboCengHao.ItemIndex := cboCengHao.Items.IndexOf(sgStratum.Cells[1,aRow]);
  cboStra_no.ItemIndex := cboCengHao.ItemIndex;
  cboSub_no.ItemIndex := cboCengHao.ItemIndex;
  edtStra_depth.Text := sgStratum.Cells[3,aRow];
  cbostra_category.ItemIndex := StrToInt(sgStratum.Cells[4,aRow])+1;

  strSQL := 'SELECT * FROM stratum'
     +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
     +' AND drl_no='  +''''+stringReplace(aDrillNo,'''','''''',[rfReplaceAll])+''''
     +' AND stra_no=' +''''+sgStratum.Cells[5,aRow]+''''
     +' AND sub_no=' +''''+stringReplace(sgStratum.Cells[6,aRow],'''','''''',[rfReplaceAll])+'''';
  with MainDataModule.qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      //showmessage(sql.Text); 
      open;
      
      while not Eof do
      begin
        cboStra_category92.ItemIndex := FieldByName('Stra_category92').AsInteger+1;
        MemDescription.Text  := FieldByName('description').AsString;
        MemDescription_en.Text  := FieldByName('description_en').AsString;
        edtStra_fao.Text := FieldByName('Stra_fao').AsString;
        edtStra_qik.Text := FieldByName('Stra_qik').AsString;
        next;
      end;
      close;
    end;
end;

function TStratumForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM stratum '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND stra_no=' +''''+sgStratum.Cells[5,sgStratum.row]+''''
           +' AND sub_no=' +''''+stringReplace(sgStratum.Cells[6,sgStratum.row],'''','''''',[rfReplaceAll])+'''';         
end;

function TStratumForm.GetInsertSQL: string;
begin
  result := 'INSERT INTO stratum (prj_no,drl_no,stra_no,sub_no,ea_name,'
            +'stra_depth, stra_category, stra_category92,description,description_en,stra_fao,stra_qik) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''+','
            +''''+trim(cboStra_no.Text)+''''+','
            +''''+stringReplace(trim(cboSub_no.Text),'''','''''',[rfReplaceAll])+''''+','
            +''''+trim(cboEa_name.Text)+''''+','
            +''''+trim(edtStra_depth.Text)+''''+','
            +''''+IntToStr(cbostra_category.ItemIndex - 1)+''''+','
            +''''+IntToStr(cboStra_category92.ItemIndex - 1)+''''+','
            +''''+stringReplace(trim(MemDescription.Text),'''','''''',[rfReplaceAll])+''''+','
            +''''+stringReplace(trim(MemDescription_en.Text),'''','''''',[rfReplaceAll])+''''+','
            +''''+trim(edtStra_fao.Text)+''''+','
            +''''+trim(edtStra_qik.Text)+''''+')';
end;

function TStratumForm.GetUpdateSQL: string;
var
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
               +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
               +' AND stra_no=' +''''+sgStratum.Cells[5,sgStratum.row]+''''
               +' AND sub_no=' +''''+stringReplace(sgStratum.Cells[6,sgStratum.row],'''','''''',[rfReplaceAll])+'''';

  strSQLSet:='UPDATE stratum SET '; 
  strSQLSet := strSQLSet + 'stra_no'  +'='+''''+trim(cboStra_no.Text)+''''+',';
  strSQLSet := strSQLSet + 'sub_no'  +'='+''''+stringReplace(trim(cboSub_no.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + 'ea_name'    +'='+''''+trim(cboEa_name.Text)+''''+',';
  strSQLSet := strSQLSet + 'stra_depth' +'='+''''+trim(edtstra_depth.Text)+''''+',';
  strSQLSet := strSQLSet + 'stra_category'+'='+''''+IntToStr(cbostra_category.ItemIndex - 1)+''''+',';
  strSQLSet := strSQLSet + 'stra_category92'+'='+''''+IntToStr(cboStra_category92.ItemIndex - 1)+'''';
  if memTemp.Text <> trim(MemDescription.Text) then
    strSQLSet := strSQLSet + ','+'description'+'='+''''
    +stringReplace(trim(MemDescription.Text),'''','''''',[rfReplaceAll])+'''';
  if MemTemp_en.Text <> trim(MemDescription_en.Text) then
    strSQLSet := strSQLSet + ','+'description_en'+'='+''''
    + 'description_en='+''''+stringReplace(trim(MemDescription_en.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + ',' + 'Stra_fao='+''''+edtStra_fao.Text+''''+','
    + 'Stra_qik='+''''+edtStra_qik.Text+'''';
  result := strSQLSet + strSQLWhere;
end;
function TStratumForm.GetExistedSQL(aStratumNo, aSub_no: string): string;
begin
  result:='SELECT prj_no,drl_no,stra_no,sub_no FROM stratum'
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(sgDrills.Cells[1,sgDrills.row]) ,'''','''''',[rfReplaceAll])+''''
           +' AND stra_no=' +''''+aStratumNo+''''
           +' AND sub_no=' +''''+stringReplace(aSub_no,'''','''''',[rfReplaceAll])+'''';

end;

procedure TStratumForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if cboStra_no.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryStratum,strSQL) then
        begin
          Clear_Data(self);  
          DeleteStringGridRow(sgStratum,sgStratum.Row);
          if sgStratum.Cells[1,sgStratum.row]='' then 
              button_status(1,false)
          else begin
              self.Get_oneRecord(sgDrills.Cells[1,sgDrills.Row],sgStratum.Row);
              button_status(1,true);
          end
        end;
    end;
  DrawDrill(sgDrills.Row);
end;

procedure TStratumForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
  cboCengHao.SetFocus;
end;

procedure TStratumForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin
    Button_status(2,true);
    memTemp.Text := MemDescription.Text;
    MemTemp_en.Text := MemDescription_en.Text;
     //memTemp的作用是当按了修改时，保存MemDescription的文本，
     //这样当保存这笔记录时，比较这两个Memo的文本，只有不同时
     //才更新Description字段。
                                             
    cboCengHao.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    self.Get_oneRecord(sgDrills.Cells[1,sgDrills.Row],sgStratum.Row);
  end;
end;

procedure TStratumForm.btn_okClick(Sender: TObject);
var
  strSQL: string; 
begin
  if not Check_Data then exit;
  if m_DataSetState = dsInsert then
    begin
      strSQL := GetExistedSQL(trim(cboStra_no.Text),trim(cboSub_no.Text));
      if isExistedRecord(MainDataModule.qryStratum,strSQL) then
        begin
          MessageBox(application.Handle,'数据库错误，此编号的土层已经存在。','数据库错误',MB_OK+MB_ICONERROR);
          exit;
        end;      
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryStratum,strSQL) then
        begin
          if (sgStratum.RowCount =2) and (sgStratum.Cells[1,1] ='') then
          else
            sgStratum.RowCount := sgStratum.RowCount+1;
          sgStratum.Cells[1,sgStratum.RowCount-1] := trim(cboCengHao.Text);
          sgStratum.Cells[5,sgStratum.RowCount-1] := trim(cboStra_no.Text);
          sgStratum.Cells[6,sgStratum.RowCount-1] := trim(cboSub_no.Text);
          sgStratum.Cells[2,sgStratum.RowCount-1] := trim(cboEa_name.Text);
          sgStratum.Cells[3,sgStratum.RowCount-1] := FormatFloat('0.00',StrToFloat(trim(edtStra_depth.Text)));
          sgStratum.Cells[4,sgStratum.RowCount-1] := IntToStr(cbostra_category.ItemIndex-1);
          sgStratum.Tag := 1;
          sgStratum.Row := sgStratum.RowCount-1;
          sgStratum.Tag := 0;
          Button_status(1,true);
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      if sgStratum.Cells[1,sgStratum.Row]<>trim(cboCengHao.Text) then
      begin
        strSQL := GetExistedSQL(trim(cboStra_no.Text),trim(cboSub_no.Text));
        if isExistedRecord(MainDataModule.qryStratum,strSQL) then
        begin
          MessageBox(application.Handle,'数据库错误，此编号的土层已经存在。','数据库错误',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryStratum,strSQL) then
        begin
          sgStratum.Cells[1,sgStratum.Row] := trim(cboCengHao.Text);
          sgStratum.Cells[5,sgStratum.RowCount-1] := trim(cboStra_no.Text);
          sgStratum.Cells[6,sgStratum.RowCount-1] := trim(cboSub_no.Text);
          sgStratum.Cells[2,sgStratum.Row] := trim(cboEa_name.Text);
          sgStratum.Cells[3,sgStratum.Row] := FormatFloat('0.00',StrToFloat(trim(edtStra_depth.Text)));
          sgStratum.Cells[4,sgStratum.Row] := IntToStr(cbostra_category.ItemIndex-1);
          Button_status(1,true);
          btn_add.SetFocus;
        end;      
    end;
end;

procedure TStratumForm.sgStratumSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
    if sgStratum.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(sgDrills.Cells[1,sgDrills.Row],ARow);
      if sgStratum.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true); 
    end
    else
      clear_data(self); 
end;

procedure TStratumForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TStratumForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TStratumForm.edtStra_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TStratumForm.cboEa_nameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TStratumForm.FormCreate(Sender: TObject);
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
  sgDrills.ColWidths[2]:=80;
  sgDrills.ColWidths[3]:=60;
  
  
  sgStratum.RowCount :=2;
  sgStratum.ColCount := 4;
  sgStratum.RowHeights[0] := 16;
  sgStratum.Cells[1,0] := '层  号';  
  sgStratum.Cells[2,0] := '岩土名称';
  sgStratum.Cells[3,0] := '层    深';  
  sgStratum.ColWidths[0]:=10;
  sgStratum.ColWidths[1]:=50;
  sgStratum.ColWidths[2]:=150;
  sgStratum.ColWidths[3]:=52;
    
  m_DrillDiagram:= TDrillDiagram.create;
  m_DrillDiagram.Image := imgDrill;  
  Clear_Data(self);
  Get_EarthType;
  Get_StratumCategory;
  GetCengHao;
  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT prj_no,drl_no,drl_elev,comp_depth,Drl_x,Drl_y');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      sql.Add(' ORDER BY drl_no');
      open;
      i:=0;
      
      sgDrills.Tag :=1;  //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中当Tag=1时不执行在SelectCell事件中的操作.   
      while not Eof do
        begin
          i:=i+1;
          sgDrills.RowCount := i +2;
          sgDrills.RowCount := i +1;
          sgDrills.Cells[1,i] := FieldByName('drl_no').AsString;  
          sgDrills.Cells[2,i] := FormatFloat('0.00',StrToFloat(trim(FieldByName('drl_elev').AsString)));
          if FieldByName('comp_depth').AsString <>'' then
             sgDrills.Cells[3,i] := FormatFloat('0.00',StrToFloat(trim(FieldByName('comp_depth').AsString)))
          else
             sgDrills.Cells[3,i] :='';
          sgDrills.Cells[4,i] := FieldByName('Drl_x').AsString;
          sgDrills.Cells[5,i] := FieldByName('Drl_y').AsString;
          Next ;
        end;
      sgDrills.Tag :=0;
      close;
    end;
    
  if i>0 then
  begin
    sgDrills.Row :=1;
    GetStratumsByDrillNo(sgDrills.Cells[1,sgDrills.Row]);
    DrawDrill(1);
  end;

  MemDescription_en.Visible :=(g_ProjectInfo.prj_ReportLanguage= trEnglishReport);
  lblDescription_en.Visible := MemDescription_en.Visible;

  if g_ProjectInfo.prj_type = GongMinJian then
  begin
    lblStra_fao.Caption := '承载力特征值';
    lblStra_qik.Caption := '极限侧阻力标准值';
  end
  else if g_ProjectInfo.prj_type =LuQiao then
  begin
    lblStra_fao.Caption := '承载力基本容许值';
    lblStra_qik.Caption := '摩阻力标准值';
  end;

end;

procedure TStratumForm.DrawDrill(aRow:integer);
var
  drl_elev,rTop,rBottom: double;
  stratumsList:TStrings;
  i:integer;
  stratum_depth:double;
begin
  rTop   := m_DrillDiagram.DrillTop;
  rBottom:= m_DrillDiagram.DrillBottom ;
  m_DrillDiagram.Clear;
  m_DrillDiagram.DrawDrillDiagram(false); 
  if (sgDrills.Cells[2,aRow] ='') and (sgDrills.Cells[3,aRow] ='') then exit;

  drl_elev := strtofloat(sgDrills.Cells[2,aRow]);
  m_DrillDiagram.DrillStandHeigh := drl_elev;
  if drl_elev>rTop then
    m_DrillDiagram.SetTopBottom(drl_elev,rBottom)
  else
    m_DrillDiagram.SetTopBottom(rTop,rBottom);
    if sgDrills.Cells[3,aRow] = '' then exit;
    m_DrillDiagram.FinishDepth := strtofloat(sgDrills.Cells[3,aRow]);

    
  if (trim(sgDrills.Cells[4,aRow]) <>'') then
    m_DrillDiagram.DrillX:= strtofloat(trim(sgDrills.Cells[4,aRow]));
  if (trim(sgDrills.Cells[5,aRow]) <>'') then
    m_DrillDiagram.DrillY:= strtofloat(trim(sgDrills.Cells[5,aRow])); 

  if (sgStratum.RowCount=2) 
    and (sgStratum.Cells[1,1]='') 
      and(m_DataSetState<>dsInsert) then exit;

  stratumsList:= TStringlist.Create;
  case m_DataSetState of
    dsInsert:
      begin
        for i:=1 to sgStratum.RowCount-1 do
          if sgStratum.Cells[3,i]<>'' then
          begin
            stratum_depth:=StrToFloat(sgStratum.Cells[3,i]);
            stratumsList.Add(floattostr(stratum_depth));
          end;
          stratum_depth:= StrToFloat(edtStra_depth.Text);
          stratumsList.Add(floattostr(stratum_depth));
          caption:= inttostr(stratumsList.Count);
      end;
    dsBrowse,dsEdit:
      for i:=1 to sgStratum.RowCount-1 do
      begin
        if i<> sgStratum.Row then
            stratum_depth:= StrToFloat(sgStratum.Cells[3,i])
        else
            stratum_depth:= StrToFloat(edtstra_depth.Text);
        stratumsList.Add(floattostr(stratum_depth));
      end;
  end;
  m_DrillDiagram.StratumList := stratumsList;
  stratumsList.Destroy;
end;

procedure TStratumForm.GetStratumsByDrillNo(aDrillNo: string);
var 
  strSQL: String;
  i: integer;
begin
  if trim(aDrillNo)='' then exit;
  sgStratum.RowCount :=2;
  DeleteStringGridRow(sgStratum,1);
  strSQL:='SELECT prj_no, drl_no, stra_no, sub_no, ea_name,stra_depth, stra_category '
           +' FROM stratum '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo,'''','''''',[rfReplaceAll])+''''
           +' ORDER BY stra_depth ';
  with MainDataModule.qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      sgStratum.Tag :=1;
      while not Eof do
        begin
          i:=i+1;
          sgStratum.RowCount := i +2;
          sgStratum.RowCount := i +1;
          if FieldByName('sub_no').AsString='0' then
            sgStratum.Cells[1,i] := FieldByName('stra_no').AsString
          else
            sgStratum.Cells[1,i] := FieldByName('stra_no').AsString+m_strFenGeFu+FieldByName('sub_no').AsString;
          
          sgStratum.Cells[2,i] := FieldByName('ea_name').AsString;
          sgStratum.Cells[3,i] := FormatFloat('0.00',FieldByName('stra_depth').AsFloat);
          sgStratum.Cells[4,i] := FieldByName('stra_category').AsString;
          sgStratum.Cells[5,i] := FieldByName('stra_no').AsString;
          sgStratum.Cells[6,i] := FieldByName('sub_no').AsString;
          Next ;
        end;
      close;
      sgStratum.Tag :=0;
    end;
  if i>0 then
  begin
    sgStratum.Row :=1;
    Get_oneRecord(aDrillNo,1);
    button_status(1,true);
  end
  else
  begin
    button_status(1,false);
    clear_data(self);
  end;
  
end;

procedure TStratumForm.sgDrillsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  function getDrillType(aDrillNo: string):string;
  var
    strSQL:string;
  begin
    if trim(aDrillNo)='' then
    begin
      result := '';
      exit;
    end;

    strSQL:= 'SELECT dt.d_t_type FROM drills d, drill_type dt '
      + ' WHERE dt.d_t_no=d.d_t_no '
      + ' AND d.drl_no=' +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
      +' AND '+'d.prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''';
    with MainDataModule.qryDrill_type  do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        try
          open;
          if not Eof then
          begin
            result := FieldByName('d_t_type').AsString;
          end;
        finally
          close;
        end;
      end;


  end;
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
  begin
    if sgDrills.Cells[1,ARow]<>'' then
    begin
      GetStratumsByDrillNo(sgDrills.Cells[1,ARow]);
      m_drill_type := getDrillType(sgDrills.Cells[1,ARow]);
     // sgStratum.Row :=1;
      //Get_oneRecord(1);
      if sgStratum.Cells[1,1]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
    DrawDrill(ARow);
  end;
end;

procedure TStratumForm.Get_EarthType;
begin
  cboEa_name.Clear;
  with MainDataModule.qryEarthType do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT ea_no,ea_name FROM earthtype ');  
      open;

      while not Eof do
      begin 
        cboEa_name.Items.Add(FieldByName('ea_name').AsString);
        next;
      end;
      close;
    end;
end;

procedure TStratumForm.GetDescByStraNo(aStratumNo, aSub_no: string);
var
  strSQL:string;
  
begin
  if (trim(aStratumNo)='') or ((trim(aSub_no)='')) then exit;
  strSQL:= 'select prj_no,stra_no,sub_no,ea_name,Stra_category,'
    + 'description,description_en FROM stratum_description '
    + ' WHERE stra_no='+''''+aStratumNo+''''
    + ' AND sub_no=' +''''+stringReplace(aSub_no,'''','''''',[rfReplaceAll])+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''';
  with MainDataModule.qryStratum_desc  do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      try
        open;
        if not Eof then
        begin
          cboEa_name.ItemIndex := cboEa_name.Items.IndexOf(FieldByName('ea_name').AsString);
          cboStra_category.ItemIndex := FieldByName('Stra_category').AsInteger+1;
          cboStra_category92.ItemIndex := FieldByName('Stra_category').AsInteger+1;
          MemDescription.Text  := FieldByName('description').AsString;
          MemDescription_en.Text  := FieldByName('description_en').AsString;
        end;
      finally
        close;
      end;
    end;
end;

procedure TStratumForm.sgDrillsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    if (ACol=3) or (ACol=2) then
      AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);

end;

procedure TStratumForm.sgStratumDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    if ACol>2 then
      AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TStratumForm.Get_StratumCategory;
begin
  cboStra_category.Clear;
  cboStra_category92.Clear;
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT id,category FROM stratumcategory02 ');
      open;
      cboStra_category.Items.Add('');
      while not Eof do
      begin
        if FieldByName('id').AsInteger >=0 then
        cboStra_category.Items.Add(FieldByName('category').AsString);
        next;
      end;
      close;
    end;

    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT id,category FROM stratumcategory92 ');
      open;
      cboStra_category92.Items.Add('');
      while not Eof do
      begin
        if FieldByName('id').AsInteger >=0 then
        cboStra_category92.Items.Add(FieldByName('category').AsString);
        next;
      end;
      close;
    end;
end;

procedure TStratumForm.cboCengHaoChange(Sender: TObject);
begin
  cboStra_no.ItemIndex := cboCengHao.ItemIndex;
  cboSub_no.ItemIndex := cboCengHao.ItemIndex;
  if (m_DataSetState = dsInsert) or (m_DataSetState = dsEdit) then
    GetDescByStraNo(cboStra_no.Text, cboSub_no.Text);
end;

procedure TStratumForm.GetCengHao;
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

procedure TStratumForm.cboCengHaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TStratumForm.edtTop_elevKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TStratumForm.MemDescriptionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TStratumForm.edtStra_depthKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TStratumForm.edtStra_depthChange(Sender: TObject);
begin
  if (edtStra_depth.Text ='') or (edtStra_depth.Text ='-') then exit;
  if (m_DataSetState = dsInsert) or (m_DataSetState = dsEdit) then
    DrawDrill(sgDrills.Row);
end;

procedure TStratumForm.edtStra_depthKeyPress(Sender: TObject;
  var Key: Char);
begin
  NumberKeyPress(sender,key,false);
end;

procedure TStratumForm.edtStra_depthExit(Sender: TObject);
begin
  if isfloat(edtStra_depth.Text) then 
    edtStra_depth.Text := FormatFloat('0.00',StrToFloat(trim(edtStra_depth.Text))); 
end;

procedure TStratumForm.edtStra_qikKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=VK_DOWN) or (key=VK_RETURN) then
  begin
    if (m_drill_type = 'B') or (m_drill_type = 'C') then //静探和麻花钻
      btn_ok.SetFocus
    else
      postMessage(self.Handle, wm_NextDlgCtl,0,0);
  end;
  if key=VK_UP then
    postmessage(self.handle,wm_nextdlgctl,1,0);
end;

procedure TStratumForm.chkHideClick(Sender: TObject);
begin
  lblStra_category.Visible := not chkHide.Checked;
  cboStra_category.Visible := not chkHide.Checked;
  lblstra_category92.Visible := not chkHide.Checked;
  cboStra_category92.Visible := not chkHide.Checked;
  lblStra_fao.Visible := not chkHide.Checked;
  edtStra_fao.Visible := not chkHide.Checked;
  lblStra_qik.Visible := not chkHide.Checked;
  edtStra_qik.Visible := not chkHide.Checked;
end;

end.
