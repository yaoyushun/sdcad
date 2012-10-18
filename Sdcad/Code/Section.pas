unit Section;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, rxToolEdit, rxCurrEdit, Grids, Buttons, ExtCtrls, DB;

type
  TSectionForm = class(TForm)
    OpenDialog1: TOpenDialog;
    pnlList: TPanel;
    sgList: TStringGrid;
    pnlEdit: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    lblfak: TLabel;
    edtSec_no: TEdit;
    gbPaper: TGroupBox;
    rbA0: TRadioButton;
    rbA3: TRadioButton;
    rbA1: TRadioButton;
    rbA4: TRadioButton;
    rbA2: TRadioButton;
    rbAuto: TRadioButton;
    gbScale: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtX_scale: TCurrencyEdit;
    edtY_scale: TCurrencyEdit;
    GroupBox1: TGroupBox;
    rbHor: TRadioButton;
    rbVer: TRadioButton;
    chbPrintCPT: TCheckBox;
    chbPrintShuiWei: TCheckBox;
    edtCpt_Print_Scale: TCurrencyEdit;
    edtfak: TEdit;
    pnlButton: TPanel;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_add: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    btn_Print: TBitBtn;
    btn_Drills: TBitBtn;
    btnFileOpen: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_okClick(Sender: TObject);
    procedure sgListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure edtSec_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rbHorClick(Sender: TObject);
    procedure rbA0Click(Sender: TObject);
    procedure btn_DrillsClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btnFileOpenClick(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure Get_oneRecord(aRow: integer);
    procedure Set_PaperSize(aLandScape,aPageType:integer);
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function Check_Data:boolean;
    function GetExistedSQL(aSectionNo: string):string;
  public
    { Public declarations }
  end;

var
  SectionForm: TSectionForm;
  m_sgListSelectedRow: integer;
  m_DataSetState: TDataSetState;
implementation

uses MainDM, public_unit, SectionDrill;

{$R *.dfm}

{ TSectionForm }

procedure TSectionForm.button_status(int_status: integer;
  bHaveRecord: boolean);
begin
  case int_status of
    1: //浏览状态
      begin
        btn_edit.Enabled :=bHaveRecord;
        btn_delete.Enabled :=bHaveRecord;
        btn_drills.Enabled := bHaveRecord;
        btn_Print.Enabled := bHaveRecord;
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
        btn_Print.Enabled :=false;
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
        btn_Print.Enabled := false;
        btn_add.Enabled :=false;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        m_DataSetState := dsInsert;
      end;
  end;
end;

function TSectionForm.Check_Data: boolean;
begin
  if trim(edtSec_no.Text) = '' then
  begin
    messagebox(self.Handle,'请输入剖面编号！','数据校对',mb_ok);
    edtSec_no.SetFocus;
    result := false;
    exit;
  end;
  result:= true;
end;

procedure TSectionForm.Get_oneRecord(aRow:Integer);
var
  i:integer;
  papertype: string;
begin
  edtSec_no.Text := sgList.Cells[1,aRow];
  edtX_scale.Text := sgList.Cells[2,aRow];
  edtY_scale.Text := sgList.Cells[3,aRow];
  if sgList.Cells[4,aRow]='0' then
    rbVer.Checked := true
  else
    rbHor.Checked := true;
  papertype:=sgList.Cells[7,aRow];
  for i:=0 to self.ComponentCount-1 do
  if components[i] is TRadioButton then
  if TRadioButton(components[i]).Parent=gbPaper then
    if TRadioButton(components[i]).tag=strtoint(papertype) then
    begin
      TRadioButton(components[i]).Checked := true;
      break;
    end;
  if sgList.Cells[8,aRow]='1' then
    chbPrintcpt.Checked := true
  else
    chbPrintcpt.Checked := false;
  edtCpt_Print_Scale.Text := sgList.Cells[9,aRow];
  edtfak.Text :=  sgList.Cells[10,aRow];
end;

function TSectionForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM section '
           +' WHERE prj_no=' +''''+stringReplace(g_ProjectInfo.prj_no,'''','''''',[rfReplaceAll]) +''''
           +' AND sec_no='  +''''+stringReplace(trim(sgList.Cells[1,sgList.row]),'''','''''',[rfReplaceAll])+'''';

end;

function TSectionForm.GetExistedSQL(aSectionNo: string): string;
begin
  result :='SELECT prj_no,sec_no FROM section '
           +' WHERE prj_no=' +''''+stringReplace(g_ProjectInfo.prj_no,'''','''''',[rfReplaceAll]) +''''
           +' AND sec_no='  +''''+stringReplace(aSectionNo,'''','''''',[rfReplaceAll])+'''';

end;

function TSectionForm.GetInsertSQL: string;
var
  papertype: string;
  i: integer;
begin
  result := 'INSERT INTO section (prj_no,sec_no,landscape,printcpt,papertype,x_scale,y_scale,cpt_Print_Scale,fak) VALUES('
            +''''+stringReplace(g_ProjectInfo.prj_no,'''','''''',[rfReplaceAll]) +''''+','
            +''''+stringReplace(trim(edtSec_no.Text),'''','''''',[rfReplaceAll])+''''+',';
  if rbVer.Checked then
    result:= result +'0'+','
  else
    result:= result + '1'+',';

  if chbPrintcpt.Checked then
    result:= result +'1'+','
  else
    result:= result + '0'+',';
    
  for i:=0 to self.ComponentCount-1 do
    if components[i] is TRadioButton then
    if TRadioButton(components[i]).Parent=gbPaper then
      if TRadioButton(components[i]).Checked then
      begin
        papertype := inttostr(TRadioButton(Components[i]).Tag);
        break;
      end;
  result := result
            +''''+papertype+''''+','
            +''''+trim(edtX_scale.Text)+''''+','
            +''''+trim(edtY_scale.Text)+''''+','
            +''''+trim(edtCpt_Print_Scale.Text)+'''' +','
            +''''+trim(edtfak.Text)+''''
            +')';
end;

function TSectionForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,papertype:string;
  i: integer;
begin
  strSQLWhere:=' WHERE prj_no='+''''+stringReplace(g_ProjectInfo.prj_no,'''','''''',[rfReplaceAll])+''''
               +' AND sec_no =' +''''+ stringReplace(sgList.Cells[1,sgList.Row],'''','''''',[rfReplaceAll])+'''';
  strSQLSet:='UPDATE section SET '; 
  strSQLSet := strSQLSet + 'sec_no' +'='+''''+stringReplace(trim(edtSec_no.Text),'''','''''',[rfReplaceAll])+''''+',';
  if rbVer.Checked then 
    strSQLSet:= strSQLSet +'landscape'+'='+'0'+','
  else
    strSQLSet:= strSQLSet +'landscape'+'='+'1'+',';
  if chbPrintcpt.Checked then
    strSQLSet:= strSQLSet +'printcpt'+'='+'1'+','
  else
    strSQLSet:= strSQLSet +'printcpt'+'='+'0'+',';
  for i:=0 to self.ComponentCount-1 do
    if components[i] is TRadioButton then
    if TRadioButton(components[i]).Parent=gbPaper then
      if TRadioButton(components[i]).Checked then
      begin
        papertype := inttostr(TRadioButton(Components[i]).Tag);
        break;
      end;
  strSQLSet := strSQLSet + 'papertype=' +''''+papertype+''''+',';
  strSQLSet := strSQLSet + 'x_scale' +'='+''''+trim(edtX_scale.Text)+''''+',';
  strSQLSet := strSQLSet + 'y_scale' +'='+''''+trim(edtY_scale.Text)+''''+',';
  strSQLSet := strSQLSet + 'Cpt_Print_Scale' +'='+''''+trim(edtCpt_Print_Scale.Text)+''''+',';
  strSQLSet := strSQLSet + 'fak' +'='+''''+trim(edtfak.Text)+'''';
  result := strSQLSet + strSQLWhere;
end;

procedure TSectionForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgList.RowHeights[0] := 16;
  sgList.ColCount := 4;
  sgList.Cells[1,0] := '剖面编号';  
  sgList.Cells[2,0] := '水平比例';
  sgList.Cells[3,0] := '垂直比例';
  sgList.ColWidths[0]:=10;
  sgList.ColWidths[1]:=80;
  sgList.ColWidths[2]:=80;
  sgList.ColWidths[3]:=80;
  m_sgListSelectedRow:= -1;
  
  Clear_Data(self);
  //Set_PaperSize(1,3);
  with MainDataModule.qrySection do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT * ');
      sql.Add(' FROM section ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      i:=0;
      sgList.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          sgList.RowCount := i +1;
          sgList.Cells[1,i] := FieldByName('sec_no').AsString;  
          sgList.Cells[2,i] := FieldByName('x_scale').AsString;
          sgList.Cells[3,i] := FieldByName('y_scale').AsString;
          if FieldByName('landscape').AsBoolean then
            sgList.Cells[4,i] := '1'
          else
            sgList.Cells[4,i] := '0';
          sgList.Cells[5,i] := FieldByName('width').AsString;
          sgList.Cells[6,i] := FieldByName('height').AsString;
          sgList.Cells[7,i] := FieldByname('papertype').AsString;
          sgList.Cells[8,i] := FieldByName('printcpt').AsString;
          sgList.Cells[9,i] := FieldByName('Cpt_Print_Scale').AsString;
          sgList.Cells[10,i] := FieldByName('fak').AsString;
          Next ;
        end;
      close;
      sgList.Tag :=0;
    end;
  if i>0 then
  begin    
    sgList.Row :=1;
    m_sgListSelectedRow :=1;
    Get_oneRecord(sgList.Row); 
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TSectionForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    chbPrintcpt.Checked := true;
    edtX_scale.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    Get_oneRecord(sgList.Row);
  end;
end;

procedure TSectionForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
  '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if edtSec_no.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qrySection,strSQL) then
        begin
          Clear_Data(self);  
          DeleteStringGridRow(sgList,sgList.Row);
          chbPrintCPT.Checked := false;
          Get_oneRecord(sgList.Row);
          if sgList.Cells[1,sgList.row]='' then
            button_status(1,false)
          else
            button_status(1,true);
        end;
    end;
end;

procedure TSectionForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  Button_status(3,true);
//yys 2008/10/20 修改
  chbPrintCPT.Checked := True;
  edtY_scale.Text := '200';
  //edtCpt_Print_Scale.Text := '2';
  edtCpt_Print_Scale.Text := '4';
  rbHor.Checked := true;
//yys 2008/10/20 END 修改
  //Set_PaperSize(1,3);
  edtSec_no.SetFocus;
end;

procedure TSectionForm.Set_PaperSize(aLandScape, aPageType: integer);
begin
{  case aLandScape of 
    1://横向画图，打印。
      case aPageType of 
        0://A0纸
          begin
            edtWidth.Text := '1149';
            edtHeight.Text := '811';
          end;
        1://A1纸
          begin
            edtWidth.Text := '801';
            edtHeight.Text := '564';
          end;
        2://A2纸
          begin
            edtWidth.Text := '554';
            edtHeight.Text := '390';
          end;
        3://A3纸
          begin
            edtWidth.Text := '380';
            edtHeight.Text := '267';
          end;
        4://A4纸
          begin
            edtWidth.Text := '257';
            edtHeight.Text := '180';
          end;
        5,6://自动生成,自定义纸
          begin
            edtWidth.Text := '0';
            edtHeight.Text := '0';
          end;                      
      end;
    0://纵向画图，打印。
      case aPageType of 
        0://A0纸
          begin
            edtWidth.Text :='811';
            edtHeight.Text :=  '1149';
          end;
        1://A1纸
          begin
            edtWidth.Text := '564';
            edtHeight.Text := '801';
          end;
        2://A2纸
          begin
            edtWidth.Text := '390';
            edtHeight.Text := '554';
          end;
        3://A3纸
          begin
            edtWidth.Text := '267';
            edtHeight.Text := '380';
          end;
        4://A4纸
          begin
            edtWidth.Text := '180';
            edtHeight.Text := '257';
          end;
        5,6://自定义纸
          begin
            edtWidth.Text := '0';
            edtHeight.Text := '0';
          end;                      
      end;
  end; }
end;

procedure TSectionForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSectionForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSectionForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
  i:integer; 
begin
  if not Check_Data then exit;
  strSQL := self.GetExistedSQL(trim(edtSec_no.Text)); 
  if m_DataSetState = dsInsert then
    begin
      if isExistedRecord(MainDataModule.qrySection,strSQL) then
      begin
        messagebox(self.Handle,'此编号已经存在，请输入新的编号！','数据校对',mb_ok);  
        edtSec_no.SetFocus;
        exit;
      end;
      strSQL := self.GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qrySection,strSQL) then
        begin
          if (sgList.RowCount =2) and (sgList.Cells[1,1] ='') then
          else
            sgList.RowCount := sgList.RowCount+1;
          m_sgListSelectedRow:= sgList.RowCount-1;
          sgList.Cells[1,sgList.RowCount-1] := edtSec_no.Text;  
          sgList.Cells[2,sgList.RowCount-1] := edtX_scale.Text;
          sgList.Cells[3,sgList.RowCount-1] := edtY_scale.Text;
          if rbVer.Checked then
            sgList.Cells[4,sgList.RowCount-1] := '0'
          else
            sgList.Cells[4,sgList.RowCount-1] := '1';
            
          //sgList.Cells[5,sgList.RowCount-1] := edtWidth.Text;
          //sgList.Cells[6,sgList.RowCount-1] := edtHeight.Text;
          for i:=0 to self.ComponentCount-1 do
            if components[i] is TRadioButton then
            if TRadioButton(components[i]).Parent=gbPaper then
              if TRadioButton(components[i]).Checked then
              begin
                sgList.Cells[7,sgList.RowCount-1] := inttostr(TRadioButton(Components[i]).Tag);
                break;
              end;
            if chbPrintcpt.Checked then
              sgList.Cells[8,sgList.RowCount-1]:='1'
            else
              sgList.Cells[8,sgList.RowCount-1]:='0';

            sgList.Cells[9,sgList.RowCount-1]:=edtCpt_print_scale.Text;
            sgList.Cells[10,sgList.RowCount-1]:=edtfak.Text;
          sgList.Row := sgList.RowCount-1;
          Button_status(1,true);
          btn_add.SetFocus;
        end;
    end
  else if m_DataSetState = dsEdit then
    begin
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qrySection,strSQL) then
        begin
          sgList.Cells[1,sgList.Row] := edtSec_no.Text;  
          sgList.Cells[2,sgList.Row] := edtX_scale.Text;
          sgList.Cells[3,sgList.Row] := edtY_scale.Text;
          if rbVer.Checked then
            sgList.Cells[4,sgList.Row] := '0'
          else
            sgList.Cells[4,sgList.Row] := '1';
            
          //sgList.Cells[5,sgList.Row] := edtWidth.Text;
          //sgList.Cells[6,sgList.Row] := edtHeight.Text;
          for i:=0 to self.ComponentCount-1 do
            if components[i] is TRadioButton then
            if TRadioButton(components[i]).Parent=gbPaper then
              if TRadioButton(components[i]).Checked then
              begin
                sgList.Cells[7,sgList.Row] := inttostr(TRadioButton(Components[i]).Tag);
                break;
              end;
          if chbPrintcpt.Checked then
            sgList.Cells[8,sgList.Row]:='1'
          else
            sgList.Cells[8,sgList.Row]:='0';
          sgList.Cells[9,sgList.Row]:=edtCpt_print_scale.Text;
          sgList.Cells[10,sgList.Row]:=edtfak.Text;
          Button_status(1,true);
          btn_add.SetFocus;
        end;      
    end;

end;

procedure TSectionForm.sgListSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow <>0) and (ARow<>m_sgListSelectedRow) then
    if sgList.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(aRow);
      if sgList.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true);
    end
    else
      clear_data(self);
  m_sgListSelectedRow:=ARow;
end;

procedure TSectionForm.edtSec_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TSectionForm.rbHorClick(Sender: TObject);
begin
  {strTemp:=edtWidth.Text;
  edtWidth.Text := edtHeight.Text;
  edtHeight.Text := strTemp;} 
end;

procedure TSectionForm.rbA0Click(Sender: TObject);
begin
  {if (m_DataSetState=dsInsert) or (m_DataSetState=dsEdit) then
  begin
    if rbHor.Checked then
      Set_PaperSize(1,TRadioButton(sender).Tag)
    else
      Set_PaperSize(0,TRadioButton(sender).Tag);
  end;}
end;

procedure TSectionForm.btn_DrillsClick(Sender: TObject);
var
  SectionDrillForm: TSectionDrillForm;
begin
  SectionDrillForm:= TSectionDrillForm.Create(self);
  SectionDrillForm.ShowModal;
end;

procedure TSectionForm.btn_PrintClick(Sender: TObject);
var 
  sec_no , strSQL, strTmp , strFileName, DrillNo, strDepth: string;
  i, j, drill_count, iNum: integer;
  FileList,//写文件用List
  DrillList,//保存钻孔编号
  DrillKjjList: TStringList;  //保存钻孔间距
  dBegin_depth,
  dEnd_depth,
  dZkjj,dX,dY: Double;  //钻孔间距，作为钻孔的X座标，Y座标为0.
begin
  FileList := TStringList.Create;
  DrillList:= TStringList.Create;
  DrillKjjList:= TStringList.Create;
  sec_no:= trim(edtSec_no.Text);
  strFileName:= g_AppInfo.PathOfChartFile + 'section.ini';
  try
    FileList.Add('[图纸信息]');
    FileList.Add('保存用文件名=剖面图' + sec_No);
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('图纸名称='+sec_No+' —'+ sec_No+'''工程地质剖面图')
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('图纸名称='+sec_No+' —'+ sec_No+'''ENGINEERING GEOLOGIC PROFILE');
    FileList.Add('工程编号='+g_ProjectInfo.prj_no);
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name)
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name_en) ;
    //开始加入比例尺
    FileList.Add('[比例尺]');
    FileList.Add('X=' + edtX_scale.Text);
    FileList.Add('Y=' + edtY_scale.Text);
    if rbVer.Checked then
      FileList.Add('打印方向=0') //纵向打印
    else
      FileList.Add('打印方向=1'); //横向打印
      for i:=0 to self.ComponentCount-1 do
        if components[i] is TRadioButton then
        if TRadioButton(components[i]).Parent=gbPaper then
          if TRadioButton(components[i]).Checked then
            FileList.Add('打印尺寸='+inttostr(TRadioButton(Components[i]).Tag));  
    
    if chbPrintCPT.Checked then   // 是否打印静探,打印为1，不打印为0
      FileList.Add('是否打印静探=1')
    else
      FileList.Add('是否打印静探=0');
    FileList.Add('静探曲线比例='+edtcpt_print_scale.Text);



    //开始加入钻孔信息
    FileList.Add('[钻孔]');
    
    strSQL:= 'SELECT drl_no,kjj FROM section_drill '
      + 'WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND sec_no = '+''''+stringReplace( sec_no,'''','''''',[rfReplaceAll]) +''''
      + ' ORDER BY id';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      drill_count:=0;
      while not eof do
      begin
        DrillList.Add( FieldByName('drl_no').AsString);
        DrillKjjList.Add(FieldByName('kjj').AsString);
        Inc(drill_count);
        next;
      end;
      close;
    end;
    if drill_count=0 then exit;
    FileList.Add('个数='+IntToStr(drill_count));
    dZkjj:=0;
    for i:=0 to drill_count-1 do
    begin
      DrillNo:= stringReplace(DrillList.Strings[i] ,'''','''''',[rfReplaceAll]);
      strSQL:= 'SELECT * '
        +' FROM drills '
        +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND drl_no=' +''''+DrillNo+'''';
      FileList.Add('[钻孔'+ inttostr(i+1)+']');
      with MainDataModule.qryDrills do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          Open;
          if not eof then
          begin
            FileList.Add('编号='+DrillNo);
            FileList.Add('孔口标高='+FieldByName('drl_elev').AsString);
            FileList.Add('里程桩号='+FieldByName('drl_lczh').AsString);            
            FileList.Add('孔深='+FieldByName('comp_depth').AsString);
            if chbPrintShuiwei.Checked then
              FileList.Add('稳定水位='+FieldByName('stable_elev').AsString)
            else
              FileList.Add('稳定水位=');
            //FileList.Add('下孔间距='+DrillKjjList.Strings[i]);
            //如果不用钻孔的座标确定钻孔间距离，那么要把距离转换成座标
            if DrillKjjList.Strings[i]<>'' then
            begin
              FileList.Add('孔口坐标X='+FloatToStr(dZkjj));
              FileList.Add('孔口坐标Y=0');
              dZkjj:= dZkjj + StrToFloat(DrillKjjList.Strings[i])
            end
            else
            begin
              FileList.Add('孔口坐标X='+FieldByName('drl_x').AsString);
              FileList.Add('孔口坐标Y='+FieldByName('drl_y').AsString);            
            end;
          end;
          close;
        end;
      //开始加入钻孔的土层信息。
      strSQL:='SELECT prj_no, drl_no, stra_no,'
         +' sub_no, ea_name, stra_depth, stra_category '
         +' FROM stratum '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+DrillNo+''''
         +' ORDER BY stra_depth';
      strTmp := '土层信息=';
      with MainDataModule.qryStratum do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('stra_no').AsString ;
              if (FieldByName('sub_no').AsString) <> '0' then 
                strTmp:= strTmp + '-' + FieldByName('sub_no').AsString;
              strTmp := strTmp + ','
                + FieldByName('stra_depth').AsString + ','
                + FieldByName('ea_name').AsString + ','; 
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);      
      FileList.Add(strTmp);

      //将fak数据加在第一个孔的数据里，便于画图
      if i=0 then
      begin
         FileList.Add('fak='+edtfak.Text);
      end;

      //开始加入土样信息
      strTmp:='土样信息=';
      strSQL:='SELECT prj_no, drl_no, s_depth_begin '
         +'FROM earthsample '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+DrillNo+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('s_depth_begin').AsString +','; 
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);

      //开始加入特殊土样信息
      strTmp:='特殊样信息=';
      strSQL:='SELECT prj_no, drl_no, s_depth_begin '
         +'FROM TeShuYang '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+DrillNo+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('s_depth_begin').AsString +','; 
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);

      //开始加入标贯信息
      strTmp:='标贯信息=';
      strSQL:='SELECT prj_no, drl_no, end_depth,real_num1+real_num2+real_num3 as real_num '
         +'FROM SPT '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
         +' AND drl_no='  +''''+DrillNo+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('end_depth').AsString + ',' 
                + FieldByName('real_num').AsString +',';
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);
      
      //开始加入动力触探数据和类型
      strTmp:='动力触探信息=';
      strSQL:='SELECT prj_no, drl_no, begin_depth, end_depth,real_num1+real_num2+real_num3 as real_num,pt_type '
         +'FROM DPT '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
         +' AND drl_no='  +''''+DrillNo+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp +FieldByName('begin_depth').AsString +'~'+ FieldByName('end_depth').AsString + ','
                + FieldByName('real_num').AsString +',';
              case FieldByName('pt_type').AsInteger of
                0: strTmp:= strTmp + ' ,';
                1: strTmp:= strTmp + '63.5,';
                2: strTmp:= strTmp + '120,';
              end;
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);
      //开始加入静力触探数据
      if chbPrintCpt.Checked then
      begin
        strSQL:='SELECT prj_no,drl_no,begin_depth,end_depth,qc,fs,rf '
         +'FROM cpt '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+DrillNo+'''';
        with MainDataModule.qryCPT do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;    
          if not eof then
          begin
            dBegin_depth:= FieldByName('begin_depth').AsFloat;
            dEnd_depth:= FieldByName('end_depth').AsFloat;
            iNum:= trunc((dEnd_depth-dBegin_depth)/g_cptIncreaseDepth);
            strDepth:='';
            for j:=1 to iNum do
            begin
              dBegin_depth:= dBegin_depth + g_cptIncreaseDepth;
              strDepth:= strDepth + FormatFloat('0.00',dBegin_depth) + ',';
            end;
            if copy(strDepth,length(strDepth),1)=',' then
              strDepth:= copy(strDepth,1,length(strDepth)-1);      
            FileList.Add('静探深度=' + strDepth);
            FileList.Add('锥尖阻力qc='+ FieldByName('qc').AsString);
            FileList.Add('侧壁摩阻力fs='+ FieldByName('fs').AsString);
          end;
          close;
        end;
      end; //End if chbPrintCpt.Checked
    end;

    FileList.SaveToFile(strFileName);    
  finally
    FileList.Free;
    DrillList.Free;
  end;
  winexec(pAnsichar(getCadExcuteName+' '+PrintChart_Section+','+strFileName+ ',' 
    + REPORT_PRINT_SPLIT_CHAR),sw_normal);
end;

procedure TSectionForm.btnFileOpenClick(Sender: TObject);
begin
    if OpenDialog1.Execute then
  begin
winexec(pAnsichar(getCadExcuteName+' 1,'+OpenDialog1.FileName),sw_normal);
  end;
end;

end.
