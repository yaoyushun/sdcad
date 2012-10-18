unit ProjectOpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, DBCtrls, Buttons, DB,
  ComCtrls, Inifiles;

type
  TProjectOpenForm = class(TForm)
    pnlQuery: TPanel;
    sgQuery: TStringGrid;
    btnExecute: TBitBtn;
    GroupBox1: TGroupBox;
    lblFieldDisplay: TLabel;
    lblValue1: TLabel;
    lblValue2: TLabel;
    cboFieldDisplay: TComboBox;
    cboSymbol1: TComboBox;
    edtValue1: TEdit;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    cboFieldName: TComboBox;
    cboSymbol2: TComboBox;
    edtValue2: TEdit;
    cboGrade: TComboBox;
    cbo_type: TComboBox;
    pnlTable: TPanel;
    pnlLeft: TPanel;
    lblprj_no: TLabel;
    lblprj_name: TLabel;
    lblarea_name: TLabel;
    lblbuilder: TLabel;
    lblbegin_date: TLabel;
    lblend_date: TLabel;
    lblconsigner: TLabel;
    lblPrj_grade: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtprj_no: TEdit;
    edtprj_name: TEdit;
    edtarea_name: TEdit;
    edtbuilder: TEdit;
    edtconsigner: TEdit;
    dtpEnd_date: TDateTimePicker;
    dtpBegin_date: TDateTimePicker;
    cboPrj_grade: TComboBox;
    cboPrj_type: TComboBox;
    edtprj_name_en: TEdit;
    pnlRight: TPanel;
    sgProject: TStringGrid;
    pnlBottom: TPanel;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_query: TBitBtn;
    btn_delete: TBitBtn;
    btn_edit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    
    procedure btn_cancelClick(Sender: TObject);
    procedure sgProjectSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtprj_noChange(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure edtprj_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpBegin_dateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgProjectDblClick(Sender: TObject);
    procedure sgProjectKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtprj_nameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_queryClick(Sender: TObject);
    procedure cboFieldDisplayChange(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure sgQueryDblClick(Sender: TObject);
    procedure cboFieldDisplayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtValue1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure Get_ProjectData(aProjectNo:string);
    procedure InitQuery;
    procedure VisibleQueryControl(aVisible:integer);
    function Delete_ProjectData(aProjectNo:string):boolean;
    procedure button_status(int_status: integer;
      bHaveRecord: boolean);
    function GetUpdateSQL: string;
    function GetExistedSQL(aProjectNo: string): string;
    function GetQuerySQL:string;
    
  public
    { Public declarations }
  end;

var
  ProjectOpenForm: TProjectOpenForm;
  m_iGridSelectedRow:integer;
  m_DataSetState: TDataSetState;
implementation

uses public_unit, MainDM, main;

{$R *.dfm}

function TProjectOpenForm.GetExistedSQL(aProjectNo: string): string;
begin
  result:='SELECT prj_no FROM projects'
           +' WHERE prj_no=' +''''+stringReplace(aProjectNo,'''','''''',[rfReplaceAll]) +'''';
end;

function TProjectOpenForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE prj_no=' +''''+stringReplace(sgProject.Cells[1,sgProject.Row],'''','''''',[rfReplaceAll]) +'''';
  strSQLSet:='UPDATE projects SET ';
  strSQLSet := strSQLSet + 'prj_no'    +'='+''''+stringReplace(trim(edtPrj_no.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + 'Prj_name'  +'='+''''+stringReplace(trim(
    edtPrj_name.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + 'Prj_name_en'  +'='+''''+stringReplace(trim(
    edtPrj_name_en.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + 'Area_name' +'='+''''+stringReplace(trim(edtArea_name.Text),'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + 'Builder'   +'='+''''+stringReplace(trim(edtBuilder.Text),'''','''''',[rfReplaceAll])+''''+','; 
  strSQLSet := strSQLSet + 'Begin_date'+'='+''''+datetostr(dtpBegin_date.Date)+''''+',';
  strSQLSet := strSQLSet + 'End_date'  +'='+''''+datetostr(dtpEnd_date.Date)+''''+',';
  strSQLSet := strSQLSet + 'prj_grade'  +'='+''''+trim(cboPrj_grade.Text)+''''+',';
  strSQLSet := strSQLSet + 'prj_type'  +'='+''''+IntToStr(cboPrj_type.itemIndex)+''''+',';
  strSQLSet := strSQLSet + 'Consigner' +'='+''''+stringReplace(trim(edtConsigner.Text),'''','''''',[rfReplaceAll])+'''';
  result := strSQLSet + strSQLWhere;
end;

procedure TProjectOpenForm.button_status(int_status: integer;
  bHaveRecord: boolean);
begin
  case int_status of
    1: //浏览状态
      begin
        btn_edit.Enabled :=bHaveRecord;
        btn_delete.Enabled :=bHaveRecord;
        btn_edit.Caption :='修改';
        btn_ok.Caption := '打开';
        btn_ok.Enabled :=true;
        btn_Query.Caption := '查询';
        btn_Query.Enabled:= bHaveRecord;
        //btn_add.Enabled :=true;
        Enable_Components(self,false);
        m_DataSetState := dsBrowse;
      end;
    2: //修改状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Caption := '保存';
        btn_ok.Enabled :=true;
        //btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
        btn_Query.Enabled := false;
        Enable_Components(self,true);
        m_DataSetState := dsEdit;
      end;
    3: //增加状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Caption := '保存';
        btn_ok.Enabled :=true;
        //btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        m_DataSetState := dsInsert;
      end;
    4: //查询状态
      begin
        btn_edit.Enabled :=false;
        btn_ok.Enabled :=false;
        btn_edit.Enabled :=false;
        btn_edit.Caption :='修改';
        btn_query.Enabled :=true;
        btn_query.Caption :='取消';
        Enable_Components(self,true);
        //btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
      end;
  end;
end;

procedure TProjectOpenForm.FormCreate(Sender: TObject);
var
  i,j: integer;
  ini_file:TInifile;
  strProjectNo: string;
  bPrjExisted: boolean;
begin
  self.Width := 735;
  self.Height := 397;
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgProject.RowHeights[0] := 16;
  sgProject.Cells[1,0] := '工程编号';  
  sgProject.Cells[2,0] := '工程名称';
  sgProject.ColWidths[0]:=10;
  sgProject.ColWidths[1]:=100;
  sgProject.ColWidths[2]:=200;
  m_iGridSelectedRow:= -1;
  bPrjExisted := false;
  sgQuery.ColWidths[0]:=10;
  Clear_Data(self);
  pnlQuery.SendToBack;
  pnlQuery.Visible :=false;
  btn_ok.Enabled := false;
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('select prj_no,prj_name,prj_name_en,prj_type from projects');
      open;
      i:=0;
      sgProject.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          sgProject.RowCount := i+1;
          sgProject.Cells[1,i] := MainDataModule.qryProjects.FieldByName('prj_no').AsString;
          sgProject.Cells[2,i] := MainDataModule.qryProjects.FieldByName('prj_name').AsString;
          sgProject.Cells[3,i] := MainDataModule.qryProjects.FieldByName(
            'prj_type').AsString;
          sgProject.Cells[4,i] := MainDataModule.qryProjects.FieldByName(
            'prj_name_en').AsString;
          Next;
        end;
      close;
      sgProject.Tag := 0;
    end;
  if i>0 then
  begin
    if fileexists(g_AppInfo.PathOfIniFile) then
    begin
      ini_file := TInifile.Create(g_AppInfo.PathOfIniFile);
      strProjectNo := ini_file.ReadString('project','no','');
      ini_file.Free;
    end;
    if strProjectNo<>'' then
    begin
      for j:=1 to sgProject.RowCount-1 do
        if strProjectNo=sgProject.Cells[1,j] then
        begin
          if j=1 then
            get_ProjectData(strProjectNo);
          sgproject.Row :=j;
          bPrjExisted := true;
          break;
        end;
    end;
    if not bPrjExisted then
    begin
      get_ProjectData(sgProject.Cells[1,1]);
      sgproject.Row :=1;
    end;
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TProjectOpenForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TProjectOpenForm.Get_ProjectData(aProjectNo: string);
begin
  if trim(aProjectNo)='' then exit;
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add('select prj_no,prj_name,prj_name_en,area_name,builder,begin_date,end_date,prj_grade,consigner,prj_type from projects');
      sql.Add(' where prj_no=' + ''''+stringReplace(aProjectNo,'''','''''',[rfReplaceAll])+''''); 
      //showmessage(sql.Text); 
      open;
      
      while not Eof do
      begin 
        edtprj_no.Text     := FieldByName('prj_no').AsString;
        edtprj_name.Text   := FieldByName('prj_name').AsString;
        edtprj_name_en.Text   := FieldByName('prj_name_en').AsString;
        edtarea_name.Text  := FieldByName('area_name').AsString;
        edtbuilder.Text    := FieldByName('builder').AsString;
        dtpBegin_date.Date := FieldByName('begin_date').AsDateTime;
        dtpEnd_date.Date   := FieldByName('end_date').AsDateTime;
        edtconsigner.Text  := FieldByName('consigner').AsString;
        cboPrj_grade.ItemIndex := cboPrj_grade.Items.IndexOf(FieldByName('prj_grade').AsString);
        if FieldByName('prj_type').AsString<>'' then
            begin
               if FieldByName('prj_type').AsBoolean  then
                   cboPrj_type.ItemIndex := 1
               else
                   cboPrj_type.ItemIndex := 0
            end
        else
            cboPrj_type.ItemIndex := -1;

        next;
      end;
      close;
    end;  
end;

procedure TProjectOpenForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TProjectOpenForm.sgProjectSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   
  
 // if (ARow <>0) and (ARow<>m_iGridSelectedRow)
 //    and (sgProject.Cells[1,ARow]<>'') then
  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
    if (sgProject.Cells[1,ARow]<>'') then
    begin
      get_ProjectData(sgProject.Cells[1,ARow]);
      if sgProject.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
  //m_iGridSelectedRow:=ARow;
end;

procedure TProjectOpenForm.edtprj_noChange(Sender: TObject);
begin
    btn_ok.Enabled :=(TEdit(Sender).Text <>'');
end;

procedure TProjectOpenForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
  aPrj_no,aPrj_name,aPrj_name_en,aPrj_type: string;
begin
  if btn_ok.Caption = '打开' then
  begin
    if btn_query.Caption = '取消' then
    begin
      aPrj_no := sgQuery.Cells[1,sgQuery.Row];
      aPrj_name := sgQuery.Cells[2,sgQuery.Row];
      aPrj_name_en := sgQuery.Cells[9,sgQuery.Row];
      if trim(sgQuery.Cells[10,sgQuery.Row])<>'' then
      begin
          if StrToInt(sgQuery.Cells[10,sgQuery.Row])<1 then
              aPrj_type := '0'
          else
              aPrj_type := sgQuery.Cells[10,sgQuery.Row];
      end
      else
          aPrj_type := '0'
        
    end
    else
    begin
      aPrj_no := sgProject.Cells[1,sgProject.Row];
      aPrj_name := sgProject.Cells[2,sgProject.Row];
      aPrj_name_en := sgProject.Cells[4,sgProject.Row];
      if cboPrj_type.ItemIndex<1 then
          aPrj_type := '0'
      else
          aPrj_type := IntToStr(cboPrj_type.itemIndex);
    end;

    g_ProjectInfo.setProjectInfo(aPrj_no,aPrj_name,aPrj_name_en,aPrj_type);
    mainform.SetStatusMessage ;
    self.Close ;
  end
  else //btn_ok.Caption <> '打开'
  begin
    if m_DataSetState = dsEdit then
    begin
      if sgProject.Cells[1,sgProject.Row]<>trim(edtPrj_no.Text) then
      begin
        strSQL := GetExistedSQL(trim(edtPrj_no.Text));
        if isExistedRecord(MainDataModule.qryProjects,strSQL) then
        begin
          MessageBox(application.Handle,'数据库错误，此编号的工程已经存在。','数据库错误',MB_OK+MB_ICONERROR);
          exit;
        end;
      end;
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryProjects,strSQL) then
      begin
        aprj_no:= trim(edtPrj_no.Text);
        aprj_name:= trim(edtPrj_name.Text);
        aPrj_name_en:= trim(edtprj_name_en.Text);
        if cboPrj_type.ItemIndex<1 then
            aprj_type := '0'
        else
            aprj_type := IntToStr(cboPrj_type.itemIndex);
        if g_ProjectInfo.prj_no=sgProject.Cells[1,sgProject.Row] then
        begin
          g_ProjectInfo.setProjectInfo(aPrj_no,aPrj_name,aPrj_name_en,aPrj_type);
          MainForm.StatusBar1.Panels[0].Text := '当前工程：编号：'
            + g_ProjectInfo.prj_no + ' ; 名称：'
            + g_ProjectInfo.prj_name + ';';
        end;
        sgProject.Cells[1,sgProject.Row] := aprj_no;
        sgProject.Cells[2,sgProject.Row] := aprj_name;
        sgProject.Cells[3,sgProject.Row] := aprj_type;
        sgProject.Cells[4,sgProject.Row] := aprj_name_en;
        Button_status(1,true);
        //btn_ok.SetFocus;
      end;      
    end;    
  end;
end;

procedure TProjectOpenForm.btn_deleteClick(Sender: TObject);
begin
  if MessageBox(self.Handle,
  '工程一但删除，所有与此工程相关的数据（钻孔、土层等）都会删除，且不能恢复，'
   +#13+ '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtprj_no.Text <> '' then
     if Delete_ProjectData(edtprj_no.Text) then
       begin
          Clear_Data(self);  
          DeleteStringGridRow(sgProject,sgProject.Row);
          Get_ProjectData(sgProject.Cells[1,sgProject.row]);
            
       end;
    
end;

function TProjectOpenForm.Delete_ProjectData(aProjectNo: string):boolean;
begin
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add('DELETE FROM projects WHERE prj_no='+ ''''+stringReplace(aProjectNo,'''','''''',[rfReplaceAll])+'''');

      try
        try
          ExecSQL;
          MessageBox(self.Handle,'删除工程成功！','删除工程',MB_OK+MB_ICONINFORMATION);
          result := true;
        except
          MessageBox(self.Handle,'数据库错误，不能删除所选工程。','数据库错误',MB_OK+MB_ICONERROR);
          result := false;
        end;
      finally
        close;
      end;
    end;  
end;

procedure TProjectOpenForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin
    Button_status(2,true);
    edtprj_no.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    get_ProjectData(sgProject.Cells[1,sgProject.Row]);
  end;
end;

procedure TProjectOpenForm.edtprj_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TProjectOpenForm.dtpBegin_dateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TProjectOpenForm.sgProjectDblClick(Sender: TObject);
var
  aPrj_no,aPrj_name,aPrj_name_en,aPrj_type: string;
begin
  if sgProject.Cells[1,sgProject.Row]='' then exit;
  aprj_no := sgProject.Cells[1,sgProject.Row];
  aprj_name := sgProject.Cells[2,sgProject.Row];
  aPrj_type := sgProject.Cells[3,sgProject.Row];
  aprj_name_en := sgProject.Cells[4,sgProject.Row];
  g_ProjectInfo.setProjectInfo(aPrj_no,aPrj_name,aPrj_name_en,aPrj_type);
  mainform.SetStatusMessage ;
  self.Close ;
end;

procedure TProjectOpenForm.sgProjectKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  aPrj_no,aPrj_name,aPrj_name_en,aPrj_type: string;
begin
  if Key = VK_RETURN then
  begin
    if sgProject.Cells[1,sgProject.Row]='' then exit;
    aprj_no := sgProject.Cells[1,sgProject.Row];
    aprj_name := sgProject.Cells[2,sgProject.Row];
    aPrj_type := sgProject.Cells[3,sgProject.Row];
    aPrj_name_en := sgProject.Cells[4,sgProject.Row];
    g_ProjectInfo.setProjectInfo(aPrj_no,aPrj_name,aPrj_name_en,aPrj_type);

    mainform.SetStatusMessage ;
    self.Close ;
  end;
end;

procedure TProjectOpenForm.edtprj_nameMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  TEdit(Sender).Hint := TEdit(Sender).Text;
end;

procedure TProjectOpenForm.btn_queryClick(Sender: TObject);
begin
  if btn_query.caption='查询'  then
    begin
      InitQuery;
      pnlquery.Visible:=True;
      pnlquery.BringToFront;
      button_status(4,true);
      edtValue1.SetFocus;
    end
   else
    begin
      pnlquery.Visible:=False;
      pnlquery.SendToBack;
      button_status(1,true);
    end;
end;

procedure TProjectOpenForm.cboFieldDisplayChange(Sender: TObject);
begin
  cboFieldName.ItemIndex := cboFieldDisplay.ItemIndex;
  edtValue1.Text := '';
  edtValue2.Text := '';
  dtp1.Date := now;
  dtp2.Date := now; 
  if (lowercase(cboFieldName.Text) = 'begin_date') or (lowercase(cboFieldName.Text) = 'end_date') then
    VisibleQueryControl(2)
  else if (lowercase(cboFieldName.Text) = 'prj_grade') then
    VisibleQueryControl(3)
  else if (lowercase(cboFieldName.Text) = 'prj_type') then
    VisibleQueryControl(4)
  else
    VisibleQueryControl(1);
end;

procedure TProjectOpenForm.InitQuery;
begin
  cboFieldDisplay.Clear;
  cboFieldDisplay.Items.Add('工程编号');
  cboFieldDisplay.Items.Add('工程项目名称');
  cboFieldDisplay.Items.Add('工程英文名称');
  cboFieldDisplay.Items.Add('开工日期');
  cboFieldDisplay.Items.Add('完工日期');
  cboFieldDisplay.Items.Add('委托单位名称');
  cboFieldDisplay.Items.Add('地区名');
  cboFieldDisplay.Items.Add('施工队名称');
  cboFieldDisplay.Items.Add('岩土工程勘察等级');
  cboFieldDisplay.Items.Add('工程类型');
  cboFieldDisplay.ItemIndex := 0;
  
  cboFieldName.Clear;
  cboFieldName.Items.Add('prj_no');
  cboFieldName.Items.Add('prj_name');
  cboFieldName.Items.Add('prj_name_en');
  cboFieldName.Items.Add('begin_date');
  cboFieldName.Items.Add('end_date');
  cboFieldName.Items.Add('consigner');
  cboFieldName.Items.Add('area_name');
  cboFieldName.Items.Add('builder');
  cboFieldName.Items.Add('prj_grade');
  cboFieldName.Items.Add('prj_type');
  cboFieldName.ItemIndex := 0;

  cboSymbol1.Clear;
  cboSymbol1.Items.Add('like');
  cboSymbol1.Items.Add('='); 
  cboSymbol1.Items.Add('<>');
  cboSymbol1.Items.Add('>');
  cboSymbol1.Items.Add('<');
  cboSymbol1.Items.Add('>=');
  cboSymbol1.Items.Add('<=');

  cboSymbol1.ItemIndex := 0;

  cboSymbol2.Clear;
  cboSymbol2.Items.Add('like');
  cboSymbol2.Items.Add('='); 
  cboSymbol2.Items.Add('<>');
  cboSymbol2.Items.Add('>');
  cboSymbol2.Items.Add('<');
  cboSymbol2.Items.Add('>=');
  cboSymbol2.Items.Add('<=');

  cboSymbol2.ItemIndex := 0;
  VisibleQueryControl(1);
  
  sgQuery.RowCount := 2;
  sgQuery.ColCount := 10;
  sgQuery.ColWidths[0]:=10;
  sgQuery.Cells[1,0] := '工程编号';
  sgQuery.ColWidths[1]:=100;
  sgQuery.Cells[2,0] := '工程项目名称';
  sgQuery.ColWidths[2]:=150;
  sgQuery.Cells[3,0] := '开工日期';
  sgQuery.ColWidths[3]:=70;
  sgQuery.Cells[4,0] := '完工日期';
  sgQuery.ColWidths[4]:=70;
  sgQuery.Cells[5,0] := '委托单位名称';
  sgQuery.ColWidths[5]:=150;
  sgQuery.Cells[6,0] := '地区名';
  sgQuery.ColWidths[6]:=70;
  sgQuery.Cells[7,0] := '施工队名称';
  sgQuery.ColWidths[7]:=100;
  sgQuery.Cells[8,0] := '岩土工程勘察等级';
  sgQuery.ColWidths[8]:=100;
  sgQuery.Cells[9,0] := '工程英文名称';
  sgQuery.ColWidths[9]:=150;
  sgQuery.Options :=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goColSizing,goRowSelect];
  sgQuery.RowCount :=2;
  DeleteStringGridRow(sgQuery,1);  
end;

procedure TProjectOpenForm.btnExecuteClick(Sender: TObject);
var
  strSQL: string;
  i: integer;
begin
  sgQuery.RowCount :=2;
  DeleteStringGridRow(sgQuery,1);
  strSQL:=GetQuerySQL;
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL); 
      //showmessage(sql.Text); 
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgQuery.RowCount := i +1;
          sgQuery.Cells[1,i] := FieldByName('prj_no').AsString;  
          sgQuery.Cells[2,i] := FieldByName('prj_name').AsString;
          sgQuery.Cells[3,i] := FieldByName('begin_date').AsString;
          sgQuery.Cells[4,i] := FieldByName('end_date').AsString;
          sgQuery.Cells[5,i] := FieldByName('consigner').AsString;
          sgQuery.Cells[6,i] := FieldByName('area_name').AsString;
          sgQuery.Cells[7,i] := FieldByName('builder').AsString;
          sgQuery.Cells[8,i] := FieldByName('prj_grade').AsString;

          if FieldByName('prj_type').AsString<>'' then
              begin
                 if FieldByName('prj_type').AsBoolean  then
                     sgQuery.Cells[10,i] :=  '1'
                 else
                     sgQuery.Cells[10,i] :=  '0'
              end
          else
              sgQuery.Cells[10,i] :=  '0';

          sgQuery.Cells[9,i] := FieldByName('prj_name_en').AsString;
          next;
        end;
      if i>0 then
        btn_ok.Enabled := true;
      close;
    end;  
end;

function TProjectOpenForm.GetQuerySQL: string;
var 
  strQuerySQL:string;
  strClause1,strClause2:string;
begin
  strClause1:= '';
  strClause2:='';
  strQuerySQL:= 'select prj_no,prj_name,prj_name_en,area_name,builder,begin_date,end_date,consigner,prj_grade,prj_type from projects';
  strQuerySQL:= strQuerySQL+' where ';
  strClause1:= '('+cboFieldName.Text+' '+ cboSymbol1.Text;
  if (lowercase(cboFieldName.Text) = 'begin_date') or (lowercase(cboFieldName.Text) = 'end_date') then
  begin
     strClause1 := strClause1 +''''+ datetimetostr(dtp1.Date)+''''+')';
     strClause2 := '(' +cboFieldName.Text+ ' '+cboSymbol2.Text
       +''''+ datetimetostr(dtp2.Date)+''''+')';
  end
  else if lowercase(cboFieldName.Text) = 'prj_type' then
     strClause1 := strClause1 +' '+''''+ IntToStr(cbo_type.itemIndex)+''''+')'
  else if lowercase(cboFieldName.Text) = 'prj_grade' then
     strClause1 := strClause1 +' '+''''+ cboGrade.Text+''''+')'
  else
  begin
     if lowercase(cboSymbol1.Text) ='like' then
       strClause1 := strClause1 +' '+''''+'%'+ edtValue1.Text +'%'+''''+')'
     else
       strClause1 := strClause1 +' '+''''+ edtValue1.Text+''''+')';
     //if lowercase(cboSymbol2.Text) ='like' then 
     //  strClause2 := '(' +cboFieldName.Text+ cboSymbol2.Text +' '+''''+'%'+ edtValue2.Text +'%'+''''+')'
     //else
     //  strClause2 := '(' +cboFieldName.Text+ cboSymbol2.Text +' '+''''+edtValue2.Text +''''+')';
  end;
  if strClause2<>'' then
    strQuerySQL := strQuerySQL + strClause1 + ' AND ' + strClause2
  else
    strQuerySQL := strQuerySQL + strClause1;
  Result := strQuerySQL;

end;

procedure TProjectOpenForm.VisibleQueryControl(aVisible:integer);
begin

  edtValue1.Text := '';
  edtValue2.Text := '';
  dtp1.Date := now;
  dtp2.Date := now;
  cboSymbol1.ItemIndex := 0;  
  cboSymbol2.ItemIndex := 0;
  dtp1.Left := edtValue1.Left;
  dtp1.Top := edtValue1.Top;
  dtp2.Left := edtValue2.Left;
  dtp2.Top := edtValue2.Top;
  cboGrade.Left := edtValue1.Left;
  cboGrade.Top := edtValue1.Top;
  cbo_type.Left := edtValue1.Left;
  cbo_type.Top := edtValue1.Top ;
  case aVisible of
    1:  //normal ,一般需要直接输入值的字段
      begin
        edtValue1.Visible := true;
        edtValue2.Visible := false;  
        dtp1.Visible := false;
        dtp2.Visible := false;
        cboSymbol2.Visible := false;
        lblValue2.Visible := false;
        
        cboGrade.Visible := false;
        cbo_type.Visible := false;
      end;
    2://日期型字段
      begin
        edtValue1.Visible := false; 
         
        dtp1.Visible := true;
        dtp2.Visible := true;
        cboSymbol2.Visible := true;
        lblValue2.Visible := true;
        
        cboGrade.Visible := false;
        cbo_type.Visible := false;
      end;
    3://选择性字段 ,工程等级
      begin
        edtValue1.Visible := false;

        dtp1.Visible := false;
        dtp2.Visible := false;
        cboSymbol2.Visible := false;
        lblValue2.Visible := false;
        cbo_type.Visible := false;
        cboGrade.Visible := true;
      end;
    4://选择性字段 ,工程类型
      begin
        edtValue1.Visible := false;

        dtp1.Visible := false;
        dtp2.Visible := false;
        cboSymbol2.Visible := false;
        lblValue2.Visible := false;

        cboGrade.Visible := false;
        cbo_type.Visible := true;
      end;
  end;
end;

procedure TProjectOpenForm.sgQueryDblClick(Sender: TObject);
var 
  i: integer;
  strPrj_No:string;
begin
  strPrj_No := sgQuery.Cells[1,sgQuery.Row];
  if strPrj_No='' then exit;
  for i:= 1 to sgProject.RowCount-1 do
    if sgProject.Cells[1,i] = strPrj_No then
      sgProject.Row := i;
  pnlQuery.SendToBack;
  button_status(1,true);

end;

procedure TProjectOpenForm.cboFieldDisplayKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TProjectOpenForm.edtValue1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;



//procedure TProjectOpenForm.SetStatusMessage;
//var
//  ini_file:TInifile;
//begin
//    MainForm.StatusBar1.Panels[0].Text := '当前工程：编号：'
//      + g_ProjectInfo.prj_no + ' ; 名称：'
//      + g_ProjectInfo.prj_name + ';';
//    //在server.ini文件中保存打开的工程编号,下次打开此窗口时直接定位到此工程.
//    ini_file := TInifile.Create(g_AppInfo.PathOfIniFile);
//    ini_file.WriteString('project','no',g_ProjectInfo.prj_no);
//    ini_file.WriteString('project','name',g_ProjectInfo.prj_name);
//    ini_file.Free;
//    self.Close;
//
//end;

end.
