unit Stratum_desc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, ComCtrls, DB, 
  Mask, rxToolEdit, rxCurrEdit;

type
  TStratum_descForm = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    sgStratumDesc: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    lblSub_no: TLabel;
    lblEa_Name: TLabel;
    lblID: TLabel;
    Label2: TLabel;
    lblStra_category: TLabel;
    lblStra_fao: TLabel;
    lblStra_qik: TLabel;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    lblDescription_en: TLabel;
    memDescription: TMemo;
    lb1: TListBox;
    lb2: TListBox;
    lb3: TListBox;
    lb4: TListBox;
    memDescription_en: TMemo;
    edtStra_no: TEdit;
    cboEa_name: TComboBox;
    edtID: TCurrencyEdit;
    cboStra_category: TComboBox;
    Button1: TButton;
    edtSub_no: TEdit;
    chbChangeFenCeng: TCheckBox;
    edtStra_fao: TEdit;
    edtStra_qik: TEdit;
    chbChangeFao: TCheckBox;
    chbChangeQik: TCheckBox;
    spl1: TSplitter;
    lbl92: TLabel;
    cboStra_category92: TComboBox;
    procedure sgStratumDescSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_editClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure memDescriptionExit(Sender: TObject);
    procedure lb1DblClick(Sender: TObject);
    procedure edtStra_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memDescriptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgStratumDescDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
    procedure cboEa_nameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSub_noKeyPress(Sender: TObject; var Key: Char);
    procedure memDescription_enKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStra_qikKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtStra_faoKeyPress(Sender: TObject; var Key: Char);
    procedure edtStra_qikKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure button_status(int_status: integer;bHaveRecord: boolean);
    procedure Get_oneRecord(aStratumNo: string; aSub_no: string);
    procedure AddTextToMemo(aText: string;var aSelStart:integer);
    function Get_Earth_Desc:boolean;
    procedure Get_EarthType;
    procedure Get_OldRecord; //当在放弃修改或新增时把所有edit和combox的值复原
    procedure Set_OldRecord; //在修改和新增前取得所有edit和combox的值保存在TOldRecord的变量中。
    procedure Get_StratumCategory;
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function GetExistedSQL(aStratumNo, aSub_no: string):string;
    function GetExistedIDSQL(aID: string): string;
    function Check_Data:boolean;
    procedure getAllRecord(aFocusRec: integer);
    procedure updateDrillsStratum;
    procedure deleteDrillsStratum;
  public
    { Public declarations }
  end;
type TOldRecord=record
  id: string;
  stra_no: string;
  sub_no: string;
  ea_Index:integer;
  Category_Index:integer; //02标准土类
  Category92_Index:integer;
  Description: string;
  description_en: string;
  end;
var
  Stratum_descForm: TStratum_descForm;
  m_DataSetState: TDataSetState;
  m_memSelStart: integer;
  m_OldRecord: TOldRecord;
  m_iGrid_id:integer;//序号在GRID中的列号
  m_iGrid_stra_no:integer;//stra_no在GRID中的列号
  m_iGrid_sub_no_display:integer;//sub_no在GRID中的显示出来的列号 ，亚层为0时要显示空
  m_iGrid_sub_no:integer;//sub_no在GRID中的真实列号
  m_iGrid_ea_name:integer;//ea_name在GRID中的列号
  m_iGrid_category02:integer;//stra_category02在GRID中的列号
  m_iGrid_category92:integer;//stra_category92在GRID中的列号
  m_array_Category02:array of string;
  m_array_Category92:array of string;
implementation

uses MainDM, public_unit, StratumCategory;

{$R *.dfm}

{ TStratum_descForm }

procedure TStratum_descForm.button_status(int_status: integer;
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

function TStratum_descForm.Check_Data: boolean;
begin
  result := false;
  if trim(edtStra_no.Text) = '' then
  begin
    messagebox(self.Handle,'请输入层号！','数据校对',mb_ok);
    edtStra_no.SetFocus;
    exit;
  end;
  if trim(cboEa_name.Text) = '' then
  begin
    messagebox(self.Handle,'请输入岩土名称！','数据校对',mb_ok);
    cboEa_name.SetFocus;
    exit;
  end;
  if cboEa_name.Items.IndexOf(trim(cboEa_name.Text)) <0 then
  begin
    messagebox(self.Handle,'岩土名称不正确，请选择正确的输入！','数据校对',mb_ok);
    cboEa_name.SetFocus;
    exit;
  end;
  if length(trim(memDescription.Text)) >300 then
  begin
    messagebox(self.Handle,'土层描述不能超过150个汉字或300个字母!','数据校对',mb_ok);
    memDescription.SetFocus;
    exit;
  end;
  if length(trim(memDescription_en.Text)) >300 then
  begin
    messagebox(self.Handle,'土层描述不能超过150个汉字或300个字母!','数据校对',mb_ok);
    memDescription_en.SetFocus;
    exit;
  end;
  result := true;
end;

procedure TStratum_descForm.Get_oneRecord(aStratumNo,aSub_no:string);
var 
  strSQL:string;
  subNo:string;
begin
  subNo:=stringReplace(aSub_no,'''','''''',[rfReplaceAll]);
  if trim(aStratumNo)='' then exit;
  strSQL:= 'SELECT * FROM stratum_description '
    + ' WHERE stra_no='+''''+aStratumNo+''''
    + ' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    + ' AND sub_no=' +''''+subNo+'''';
  with MainDataModule.qryStratum_desc  do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL); 
      open;
      
      while not Eof do
      begin
        edtID.Text := fieldByName('id').AsString;
        edtStra_no.Text := aStratumNo;
        if aSub_no<>'0' then
          edtSub_no.Text := aSub_no
        else
          edtSub_no.Text := '';
        cboEa_name.ItemIndex := cboEa_name.Items.IndexOf(FieldByName('ea_name').AsString);
        if FieldByName('stra_category').AsString<>'' then
          cboStra_category.ItemIndex := FieldByName('stra_category').AsInteger+1
        else cboStra_category.ItemIndex := -1;
        if FieldByName('stra_category92').AsString<>'' then
          cboStra_category92.ItemIndex := FieldByName('stra_category92').AsInteger+1
        else cboStra_category92.ItemIndex := -1;
        memDescription.Text := FieldByName('description').AsString;
        memDescription_en.Text := FieldByName('description_en').AsString;
        edtStra_fao.Text := FieldByName('Stra_fao').AsString;
        edtStra_qik.Text := FieldByName('Stra_qik').AsString;
        next;
      end;
      close;
    end;
end;

function TStratum_descForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM stratum_description '
    + ' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND stra_no='+''''+sgStratumDesc.Cells[1,sgStratumDesc.Row]+''''
    +' AND sub_no=' +''''+stringReplace(sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.row],'''','''''',[rfReplaceAll])+'''';
end;

function TStratum_descForm.GetInsertSQL: string;
var
  subNo: string;
begin
  subNo:=stringReplace(trim(edtSub_no.Text),'''','''''',[rfReplaceAll]);
  if subNo='' then subNo:='0';
  result := 'INSERT INTO stratum_description (prj_no,id,stra_no,sub_no,ea_name, '
            +'stra_category,stra_category92,description,description_en,stra_fao,stra_qik) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL+''''+','
            +''''+trim(edtID.Text)+''''+','
            +''''+trim(edtStra_no.Text)+''''+','
            +''''+subNo+''''+','
            +''''+trim(cboEa_name.Text)+''''+','
            +''''+IntToStr(cbostra_category.ItemIndex-1)+''''+','
            +''''+IntToStr(cbostra_category92.ItemIndex-1)+''''+','
            +''''+stringReplace(trim(MemDescription.Text),'''','''''',[rfReplaceAll])+''''+','
            +''''+stringReplace(trim(MemDescription_en.Text),'''','''''',[rfReplaceAll])+''''+','
            +''''+trim(edtStra_fao.Text)+''''+','
            +''''+trim(edtStra_qik.Text)+''''+')';
end;

function TStratum_descForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,subNo:string;
begin
  strSQLWhere:=' WHERE stra_no='+''''+sgStratumDesc.Cells[1,sgStratumDesc.Row]+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND sub_no=' +''''+stringReplace(sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.row],'''','''''',[rfReplaceAll])+'''';
  strSQLSet:='UPDATE stratum_description SET ';
  subNo:=stringReplace(trim(edtSub_no.Text),'''','''''',[rfReplaceAll]);
  if subNo='' then subNo:='0';
  strSQLSet := strSQLSet
    + 'id='+''''+trim(edtID.Text)+''''+',' 
    + 'stra_no' +'='+''''+trim(edtStra_no.Text)+''''+','
    + 'sub_no='+''''+subNo+''''+','
    + 'ea_name='+''''+trim(cboEa_name.Text)+''''+','
    + 'stra_category='+''''+IntToStr(cbostra_category.ItemIndex-1)+''''+','
    + 'stra_category92='+''''+IntToStr(cbostra_category92.ItemIndex-1)+''''+','
    + 'description='+''''+stringReplace(trim(MemDescription.Text),'''','''''',[rfReplaceAll])+''''+','
    + 'description_en='+''''+stringReplace(trim(MemDescription_en.Text),'''','''''',[rfReplaceAll])+''''+','
    + 'Stra_fao='+''''+edtStra_fao.Text+''''+','
    + 'Stra_qik='+''''+edtStra_qik.Text+'''';
  result := strSQLSet + strSQLWhere;
end;


function TStratum_descForm.GetExistedSQL(aStratumNo, aSub_no:string): string;
var
  subNo: string;
begin
  subNo:= trim(aSub_no);
  subNo:=stringReplace(trim(aSub_no),'''','''''',[rfReplaceAll]);
  if subNo='' then subNo:='0';
  
  Result:='SELECT prj_no,stra_no,sub_no FROM stratum_description '
    + ' WHERE stra_no='+''''+aStratumNo+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
    +' AND sub_no=' +''''+subNo+''''; 
end;

procedure TStratum_descForm.sgStratumDescSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>sgStratumDesc.Row) then
    if sgStratumDesc.Cells[m_iGrid_stra_no,ARow]<>'' then
    begin
      Get_oneRecord(sgStratumDesc.Cells[m_iGrid_stra_no,ARow],sgStratumDesc.Cells[m_iGrid_sub_no,ARow]);
      Button_status(1,true);
    end
    else
    begin
      clear_data(self);
      Button_status(1,false);
    end;
  Set_OldRecord;
end;

procedure TStratum_descForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin
    Button_status(2,true);
    edtStra_no.SetFocus;
    m_memSelStart:= length(memDescription.Text);
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    Get_OldRecord;

  end;
end;

procedure TStratum_descForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TStratum_descForm.btn_addClick(Sender: TObject);
var 
  strID: string;
begin
  strID := trim(sgStratumDesc.Cells[m_iGrid_id,sgStratumDesc.RowCount-1]);
  Clear_Data(self);
  Button_status(3,true);
  edtID.SetFocus;
  if trim(strID)='' then
    edtID.Text := '1'
  else
    try
      edtID.Text := IntToStr(StrToInt(strID)+1);
    except
      edtID.Text := '';
    end;
  edtStra_no.SetFocus;
end;

procedure TStratum_descForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
  iFocusRow: integer;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtStra_no.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryStratum_desc,strSQL) then
        begin
          //删除stratum表中所有钻孔和此层号相同的层数据
          deleteDrillsStratum;
          //更新Grid显示。
          iFocusRow := sgStratumDesc.Row;
          strSQL := 'UPDATE stratum_description SET id=id-1 WHERE id>='
                    +''''+trim(edtID.Text)+''''
                    +' AND prj_no=' +''''
                    +g_ProjectInfo.prj_no_ForSQL 
                    +'''';
          Update_oneRecord(MainDataModule.qryStratum_desc,strSQL);

          Clear_Data(self);  
          DeleteStringGridRow(sgStratumDesc,sgStratumDesc.Row);
          
          getAllRecord(iFocusRow);
          if sgStratumDesc.Cells[1,sgStratumDesc.row]<>'' then
          begin
            self.Get_oneRecord(sgStratumDesc.Cells[m_iGrid_stra_no,sgStratumDesc.row],sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.row]);
            button_status(1,true);
          end
          else
            button_status(1,false);
        end;
    end;

end;

procedure TStratum_descForm.btn_okClick(Sender: TObject);
var
  strSQL,subNo, RowID: string;
  i,iFocusRec: integer;

begin
  if not Check_Data then exit;
  subNo:= trim(edtSub_no.Text);
  if m_DataSetState = dsInsert then
    begin
      //判断当前序号的层是否已经存在。
      strSQL := GetExistedIDSQL(trim(edtId.Text));
      if isExistedRecord(MainDataModule.qryStratum_desc,strSQL) then
      begin
        if MessageBox(application.Handle,PAnsiChar('第'+trim(edtId.Text)
           +'层的土层已经存在，您是要插入数据吗？'),'提示',MB_YESNO) = IDNO then
        begin
            edtId.SetFocus;
            exit;
        end;
        //开始更新和当前ID号相同的层及所有下层的的ID号

        MainDataModule.ADOConnection1.BeginTrans;
        try
            strSQL := 'UPDATE stratum_description SET id=id+1 WHERE id>='
                      +''''+trim(edtID.Text)+'''';
            Update_oneRecord(MainDataModule.qryStratum_desc,strSQL);  
            strSQL := self.GetInsertSQL;
            Insert_oneRecord(MainDataModule.qryStratum_desc,strSQL);
            MainDataModule.ADOConnection1.CommitTrans;

            //更新GRID的显示
            iFocusRec := 1;
            for i:= 1 to sgStratumDesc.RowCount-1 do
               if sgStratumDesc.Cells[m_iGrid_id,i]=trim(edtID.Text) then
                  iFocusRec := i;
            getAllRecord(iFocusRec);
            btn_add.SetFocus;
            exit;             
        except
            MainDataModule.ADOConnection1.RollbackTrans;
        end;
        exit;            
      end;
      //判断当前层号和亚层号是否已经存在。
      if subNo <> '' then
        strSQL := GetExistedSQL(trim(edtStra_no.Text),trim(edtSub_no.Text))
      else
        strSQL := GetExistedSQL(trim(edtStra_no.Text),'0');      
      if isExistedRecord(MainDataModule.qryStratum_desc,strSQL) then
      begin
        MessageBox(application.Handle,'当前层号的土层已经存在，不能保存。','数据库错误',MB_OK+MB_ICONERROR);
        edtStra_no.SetFocus;
        exit;
      end;
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryStratum_desc,strSQL) then
        begin
            //更新GRID的显示
            iFocusRec := 1;
            RowID := trim(edtID.Text);
            getAllRecord(iFocusRec);
            for i:= 1 to sgStratumDesc.RowCount-1 do
               if sgStratumDesc.Cells[m_iGrid_id,i]=trim(edtID.Text) then
                  iFocusRec := i;
            sgStratumDesc.Row := iFocusRec;
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      if sgStratumDesc.Cells[m_iGrid_id,sgStratumDesc.Row]<>trim(edtID.Text) then
      begin
        strSQL := GetExistedIDSQL(trim(edtId.Text));
        if isExistedRecord(MainDataModule.qryStratum_desc,strSQL) then
        begin
          MessageBox(application.Handle,PAnsiChar('第'+trim(edtId.Text)+'层的土层已经存在，不能保存。'),'数据库错误',MB_OK+MB_ICONERROR);
          edtId.SetFocus;
          exit;
        end;
      end;
      if (sgStratumDesc.Cells[m_iGrid_stra_no,sgStratumDesc.Row]<>trim(edtStra_no.Text))
        or ((sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.Row]<>trim(edtSub_no.Text))
          and not((sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.Row]='0') and (trim(edtSub_no.Text)=''))  ) then
      begin
        if edtSub_no.Text <> '' then
          strSQL := GetExistedSQL(trim(edtStra_no.Text),trim(edtSub_no.Text))
        else
          strSQL := GetExistedSQL(trim(edtStra_no.Text),'0');
        if isExistedRecord(MainDataModule.qryStratum_desc,strSQL) then
        begin
          MessageBox(application.Handle,'当前层号的土层已经存在，不能保存。','数据库错误',MB_OK+MB_ICONERROR);
          edtStra_no.SetFocus;
          exit;
        end;
      end;
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryStratum_desc,strSQL) then
        begin
            //更新所有钻孔的这一层的岩土名称
            updateDrillsStratum;
            //更新GRID的显示
            iFocusRec := 1;
            RowID := trim(edtID.Text);
            getAllRecord(iFocusRec);
            for i:= 1 to sgStratumDesc.RowCount-1 do
               if sgStratumDesc.Cells[m_iGrid_id,i]=RowID then
                  iFocusRec := i;
            sgStratumDesc.Row := iFocusRec;
            btn_add.SetFocus;
        end;      
    end;
  
end;

procedure TStratum_descForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgStratumDesc.ColCount := 6;
  sgStratumDesc.RowHeights[0] := 16;
  m_iGrid_id := 0;
  sgStratumDesc.Cells[m_iGrid_id,0] := '序号';
  m_iGrid_stra_no := 1;
  m_iGrid_sub_no_display := 2;
  m_iGrid_sub_no := 6;
  sgStratumDesc.Cells[m_iGrid_stra_no,0] := '主层';
  sgStratumDesc.Cells[m_iGrid_sub_no_display,0] := '亚层';
  sgStratumDesc.ColWidths[m_iGrid_id]:=30;
  sgStratumDesc.ColWidths[m_iGrid_stra_no]:=40;

  m_iGrid_ea_name := 3;
  sgStratumDesc.ColWidths[m_iGrid_ea_name]:=100;
  sgStratumDesc.Cells[m_iGrid_ea_name,0] := '土层名称';
  m_iGrid_category02 :=4;
  sgStratumDesc.ColWidths[m_iGrid_category02]:=40;
  sgStratumDesc.Cells[m_iGrid_category02,0] := '类别02';
  m_iGrid_category92 :=5;
  sgStratumDesc.ColWidths[m_iGrid_category92]:=40;
  sgStratumDesc.Cells[m_iGrid_category92,0] := '类别92';
  Clear_Data(self);
  Get_EarthType;
  Get_StratumCategory;
  SetCBWidth(cboEa_name);
  Get_Earth_Desc;
  getAllRecord(1);

  memDescription_en.Visible := (g_ProjectInfo.prj_ReportLanguage=
    trEnglishReport);
  lblDescription_en.Visible :=  memDescription_en.Visible;

  if g_ProjectInfo.prj_type = GongMinJian then
  begin
    lblStra_fao.Caption := '承载力特征值';
    lblStra_qik.Caption := '极限侧阻力标准值';
    chbChangeFao.Caption:= '在承载力特征值改变时相应改变每个钻孔对应层的特征值';
    chbChangeQik.Caption:= '在极限侧阻力标准值改变时相应改变每个钻孔对应层的标准值';
  end
  else if g_ProjectInfo.prj_type =LuQiao then
  begin
    lblStra_fao.Caption := '承载力基本容许值';
    lblStra_qik.Caption := '摩阻力标准值';
    chbChangeFao.Caption:= '承载力基本容许值改变时相应改变每个钻孔对应层的容许值';
    chbChangeQik.Caption:= '在摩阻力标准值改变时相应改变每个钻孔对应层的标准值';
  end;
    
end;

procedure TStratum_descForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TStratum_descForm.memDescriptionExit(Sender: TObject);
begin
  m_memSelStart := memDescription.SelStart;
end;

procedure TStratum_descForm.lb1DblClick(Sender: TObject);
begin
  AddTextToMemo(TListBox(Sender).Items[TListBox(Sender).ItemIndex],m_memSelStart);
end;

procedure TStratum_descForm.AddTextToMemo(aText: string;
  var aSelStart: integer);
var
  str1,str2:string;
begin
  str1:= copy(memDescription.Text,1,aSelStart);
  str2:= memDescription.Text;
  delete(str2,1,aSelStart);

  memDescription.Text := str1 + aText+ str2;
  //+aText+RightStr(memDescription.Text,length(memDescription.Text)-aSelStart);  
  
  aSelStart:= aSelStart+ length(aText);
  memDescription.SetFocus;
  memDescription.SelStart := aSelStart;
end;

procedure TStratum_descForm.edtStra_noKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TStratum_descForm.memDescriptionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key=VK_DOWN) or (key=VK_RETURN) then
  begin
    btn_ok.SetFocus;
  end;
end;

procedure TStratum_descForm.Get_EarthType;
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

function TStratum_descForm.GetExistedIDSQL(aID: string): string;
begin
  Result:='SELECT prj_no,stra_no,sub_no FROM stratum_description '
    + ' WHERE id='+''''+aID+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''';
end;

procedure TStratum_descForm.sgStratumDescDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    if (ACol=0) then
      AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify)
    else
      AlignGridCell(Sender,ACol,ARow,Rect,taCenter); 
end;

function TStratum_descForm.Get_Earth_Desc:boolean;
var
  strSQL: string;
  i:integer;
begin
  strSQL:='SELECT LeiXing,MiaoShu FROM earth_desc';
  i:=0;
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      if eof then 
      begin
        result:= false;
        exit;
      end;
      lb1.Clear;
      lb2.Clear;
      lb3.Clear;
      lb4.Clear;
      while not eof do
        begin
          inc(i);
          case FieldByName('LeiXing').AsInteger of
            1,2: lb1.Items.Add(FieldByName('MiaoShu').AsString);
            3,4: lb2.Items.Add(FieldByName('MiaoShu').AsString);
            5,6: lb3.Items.Add(FieldByName('MiaoShu').AsString);
            7,8: lb4.Items.Add(FieldByName('MiaoShu').AsString);
            else lb4.Items.Add(FieldByName('MiaoShu').AsString);
          end;
          next;
        end;
      close;
    end;
  if i>0 then result:= true
  else result:= false;
end;

procedure TStratum_descForm.Get_StratumCategory;
var
  i:integer;
begin
  cboStra_category.Clear;
  cboStra_category.Items.Add('');
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT id,category FROM stratumcategory02 ');
      open;

      while not Eof do
      begin
        if FieldByName('id').AsInteger >=0 then
        cboStra_category.Items.Add(FieldByName('category').AsString);

        next;
      end;
      close;
    end;
  setLength(m_array_category02,cboStra_category.Items.Count);
  for i:=0 to cboStra_category.Items.Count-1 do
     m_array_category02[i] := cboStra_category.Items[i];

  cboStra_category92.Clear;
  cboStra_category92.Items.Add('');
  with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT id,category FROM stratumcategory92 ');
      open;

      while not Eof do
      begin
        if FieldByName('id').AsInteger >=0 then
        cboStra_category92.Items.Add(FieldByName('category').AsString);
        next;
      end;
      close;
    end;
  setLength(m_array_category92,cboStra_category92.Items.Count);
  for i:=0 to cboStra_category92.Items.Count-1 do
     m_array_category92[i] := cboStra_category92.Items[i];
end;

procedure TStratum_descForm.Button1Click(Sender: TObject);
var
  StratumCategoryForm: TStratumCategoryForm;
begin
  StratumCategoryForm:= TStratumCategoryForm.Create(self);
  StratumCategoryForm.ShowModal;
  StratumCategoryForm.Free;
end;

procedure TStratum_descForm.cboEa_nameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TStratum_descForm.Get_OldRecord;
begin
  edtId.Text:= m_OldRecord.id;
  edtStra_no.Text:= m_OldRecord.stra_no;
  edtSub_no.Text := m_OldRecord.sub_no;
  cboEa_name.ItemIndex := m_OldRecord.ea_Index;
  cboStra_Category.ItemIndex := m_OldRecord.Category_Index;
  cboStra_Category92.ItemIndex := m_OldRecord.Category92_Index;
  memDescription.Text := m_OldRecord.Description;
  memDescription_en.Text := m_OldRecord.Description_en;
end;

procedure TStratum_descForm.Set_OldRecord;
begin
  m_OldRecord.id:= trim(edtId.Text);
  m_OldRecord.stra_no:= trim(edtStra_no.Text);
  m_OldRecord.sub_no := trim(edtSub_no.Text);
  m_OldRecord.ea_Index := cboEa_name.ItemIndex;
  m_OldRecord.Category_Index := cboStra_Category.ItemIndex;
  m_OldRecord.Category92_Index := cboStra_Category92.ItemIndex;
  m_OldRecord.Description := memDescription.Text;
  m_OldRecord.Description_en := memDescription_en.Text;
end;

procedure TStratum_descForm.edtSub_noKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key='0' then
  begin
    key:=#0;
    exit;
  end;
  NumberKeyPress(sender,key,false);
end;

procedure TStratum_descForm.getAllRecord(aFocusRec: integer);
var 
  i: integer;
begin
  with MainDataModule.qryStratum_desc do
    begin
      close;
      sql.Clear;
      sql.Add('select id,prj_no,stra_no,sub_no,ea_name,stra_category,stra_category92 FROM stratum_description');
      sql.Add(' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''');
      sql.Add(' ORDER BY id'); 
      open;
      i:=0;
      sgStratumDesc.Tag := 1;
      sgStratumDesc.RowCount := 2;
      while not Eof do
        begin
          i:=i+1;
          sgStratumDesc.RowCount := i +1;
          sgStratumDesc.Cells[m_iGrid_id,i] := FieldByName('id').AsString;
          sgStratumDesc.Cells[m_iGrid_stra_no,i] := FieldByName('stra_no').AsString;
          if FieldByName('sub_no').AsString='0' then
            sgStratumDesc.Cells[m_iGrid_sub_no_display,i] := ''
          else
            sgStratumDesc.Cells[m_iGrid_sub_no_display,i] := FieldByName('sub_no').AsString;
          sgStratumDesc.Cells[m_iGrid_sub_no,i] := FieldByName('sub_no').AsString;
          sgStratumDesc.Cells[m_iGrid_ea_name,i] := FieldByName('ea_name').AsString;
          if not FieldByName('stra_category').IsNull then
          begin
            if FieldByName('stra_category').asInteger>=-1 then
              sgStratumDesc.Cells[m_iGrid_category02,i] := m_array_category02[FieldByName('stra_category').asInteger+1]
            else
              sgStratumDesc.Cells[m_iGrid_category02,i] := m_array_category02[0] ;
          end
          else
            sgStratumDesc.Cells[m_iGrid_category02,i] := m_array_category02[0];
          if not FieldByName('stra_category92').IsNull then
          begin
            if FieldByName('stra_category92').asInteger>=-1 then
              sgStratumDesc.Cells[m_iGrid_category92,i] := m_array_category92[FieldByName('stra_category92').asInteger+1]
            else
              sgStratumDesc.Cells[m_iGrid_category92,i] := m_array_category92[0] ;
          end
          else
            sgStratumDesc.Cells[m_iGrid_category92,i] := m_array_category92[0];
          Next ;
        end;
      close;
      sgStratumDesc.Tag := 0;
    end;
  if i>0 then
  begin
    if aFocusRec>sgStratumDesc.RowCount-1 then
       aFocusRec:=1;
    sgStratumDesc.Row :=aFocusRec;
    Get_oneRecord(sgStratumDesc.Cells[1,aFocusRec],sgStratumDesc.Cells[m_iGrid_sub_no,aFocusRec]);
    button_status(1,true);
  end
  else
    button_status(1,false);
  Set_OldRecord;
end;

procedure TStratum_descForm.updateDrillsStratum;
var 
  strSQLWhere,strSQLSet,strSQL,subNo:string;
begin
  strSQLWhere:=' WHERE stra_no='+''''+sgStratumDesc.Cells[1,sgStratumDesc.Row]+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND sub_no=' +''''+stringReplace(sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.row],'''','''''',[rfReplaceAll])+'''';
  strSQLSet:='UPDATE stratum SET ';
  subNo:=stringReplace(trim(edtSub_no.Text),'''','''''',[rfReplaceAll]);
  if subNo='' then subNo:='0';
  strSQLSet := strSQLSet
    + 'stra_no' +'='+''''+trim(edtStra_no.Text)+''''+','
    + 'sub_no='+''''+subNo+''''+','
    + 'ea_name='+''''+trim(cboEa_name.Text)+''''+','
    + 'stra_category='+''''+IntToStr(cbostra_category.ItemIndex-1)+''''+','
    + 'stra_category92='+''''+IntToStr(cbostra_category92.ItemIndex-1)+'''';
  if chbChangeFenCeng.Checked then   //如果选中，在土层描述改变时相应改变每个钻孔对应层的描述信息
    strSQLSet := strSQLSet
    +',' +  'description='+''''+memDescription.Text+''''+','
    + 'description_en='+''''+memDescription_en.Text+'''';

  if chbChangeFao.Checked then
    strSQLSet := strSQLSet +',' + 'stra_fao='+''''+edtStra_fao.Text+'''';
  if chbChangeQik.Checked then
    strSQLSet := strSQLSet +',' + 'stra_qik='+''''+edtStra_qik.Text+'''';
  strSQL := strSQLSet + strSQLWhere;
  Update_oneRecord(MainDataModule.qryStratum_desc,strSQL);
end;

procedure TStratum_descForm.deleteDrillsStratum;
var
  strSQL: string;
begin
  strSQL :='DELETE FROM stratum '
    + ' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND stra_no='+''''+sgStratumDesc.Cells[1,sgStratumDesc.Row]+''''
    +' AND sub_no=' +''''+stringReplace(sgStratumDesc.Cells[m_iGrid_sub_no,sgStratumDesc.row],'''','''''',[rfReplaceAll])+'''';
  Delete_oneRecord(MainDataModule.qryStratum_desc,strSQL);
end;

procedure TStratum_descForm.memDescription_enKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key=VK_DOWN) or (key=VK_RETURN) then
  begin
    btn_ok.SetFocus;
  end;
end;

procedure TStratum_descForm.edtStra_qikKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
  begin
    memDescription.SetFocus;
    memDescription.SelStart :=0;
  end;
end;

procedure TStratum_descForm.edtStra_faoKeyPress(Sender: TObject;
  var Key: Char);
begin
  NumberKeyPress(sender,key,false);
end;

procedure TStratum_descForm.edtStra_qikKeyPress(Sender: TObject;
  var Key: Char);
begin
  NumberKeyPress(sender,key,false);
end;

end.
