unit CPT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, DB, Mask, rxToolEdit, rxCurrEdit, Math,
  ActnList, XPStyleActnCtrls, ActnMan, Menus, ExtCtrls, FileCtrl;

type
  TCPTForm = class(TForm)
    pmGrid: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiDeleteOne: TMenuItem;
    pmiDeleteAll: TMenuItem;
    ActionManager1: TActionManager;
    GridAdd: TAction;
    GridDeleteOneRow: TAction;
    GridDeleteAll: TAction;
    OpenDialog: TOpenDialog;
    lblDepth: TLabel;
    lblDrl_no: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sgCPT: TStringGrid;
    cboDrl_no: TComboBox;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    edtBegin_Depth: TCurrencyEdit;
    edtEnd_depth: TCurrencyEdit;
    cboDrillType: TComboBox;
    edtFileName: TEdit;
    btnFileOpen: TBitBtn;
    btn_Load: TBitBtn;
    btnCustomDelete: TBitBtn;
    edtBegin_del: TCurrencyEdit;
    edtEnd_del: TCurrencyEdit;
    btnBatchLoad: TBitBtn;
    edtFolder: TEdit;
    btnFolderName: TBitBtn;
    flbFileList: TFileListBox;
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cboDrl_noChange(Sender: TObject);
    procedure GridAddExecute(Sender: TObject);
    procedure GridDeleteOneRowExecute(Sender: TObject);
    procedure GridDeleteAllExecute(Sender: TObject);
    procedure cboDrl_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_okClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure sgCPTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgCPTKeyPress(Sender: TObject; var Key: Char);
    procedure rgFileTypeClick(Sender: TObject);
    procedure sgCPTDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgCPTSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sgCPTKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFileOpenClick(Sender: TObject);
    procedure btn_LoadClick(Sender: TObject);
    procedure btnCustomDeleteClick(Sender: TObject);
    procedure btnBatchLoadClick(Sender: TObject);
    procedure btnFolderNameClick(Sender: TObject);
  private
    { Private declarations }
    OldCellValue: string;
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure GetDataByDrillNo(aDrillNo: string);
    procedure GetDrillsNo;
    //procedure Get_oneRecord(aDrillNo:string;aRow:Integer);
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    //function GetExistedSQL(aStratumNo: string):string;
    function Check_Data:boolean;
    function GetExistedSQL(aDrillNo: string):string;
  public
    { Public declarations }
  end;

var
  CPTForm: TCPTForm;
  m_DataSetState: TDataSetState;
  m_drl_no: string;
Const
  m_Flag_DanQiao ='0';
  m_Flag_ShuangQiao = '1';
  
implementation

uses MainDM, public_unit;

{$R *.dfm}

{ TCPTForm }

procedure TCPTForm.button_status(int_status: integer;
  bHaveRecord: boolean);
begin
  case int_status of
    1: //浏览状态
      begin
        btn_edit.Enabled :=bHaveRecord;
        btn_delete.Enabled :=bHaveRecord;
        btn_edit.Caption :='修改';
        btn_ok.Enabled :=false;
        Enable_Components(self,false);
        edtFileName.Enabled := true;
        cboDrl_no.Enabled :=true;
        sgCPT.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
        sgCPT.PopupMenu := nil;
      end;
    2: //修改状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        sgCPT.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing];
        sgCPT.PopupMenu := pmGrid;
      end;
  end;
  edtBegin_Del.Enabled := true;
  edtEnd_del.Enabled := true;
end;

function TCPTForm.Check_Data: boolean;
begin
  if (sgCPT.RowCount =2) and (sgCPT.Cells[1,1]='') then
  begin
    MessageBox(self.Handle,'没有试验数据，不能保存。','提示',MB_OK+MB_ICONWARNING);
    result:=false;
    exit;
  end;
  result:= true;
end;

procedure TCPTForm.GetDataByDrillNo(aDrillNo: string);
var
  strSQL,strQcAll,strFsAll, strRfAll: String;
  i,j: integer;
  dBeginDepth,dEndDepth:double;
  qcList,fsList,rfList: TStringList;
begin
  sgCPT.RowCount :=2;
  DeleteStringGridRow(sgCPT,1);
  edtBegin_Depth.Text:='0.00';
  edtEnd_Depth.Text:='0.00';
  if trim(aDrillNo)='' then exit;
  strSQL:='SELECT prj_no,drl_no,begin_depth,end_depth,qc,fs,rf '
           +'FROM cpt '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''';
  with MainDataModule.qryCPT do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      if not Eof then
        begin
          i:=i+1;
          strQcAll := FieldByName('qc').AsString;
          strFsAll := FieldByName('fs').AsString;
          strRfAll := FieldByName('rf').AsString;
          dBeginDepth := FieldByName('begin_depth').AsFloat;
          dEndDepth := FieldByName('end_depth').AsFloat;
          edtBegin_Depth.Text := formatFloat('0.00',dBeginDepth);
          edtEnd_depth.Text := formatFloat('0.00',dEndDepth);
          {if FieldByName('isSHQ').AsBoolean then
            rgFileType.ItemIndex:= 1
          else
            rgFileType.ItemIndex:= 0;}

        end;
      close;
    end;
  if i>0 then
  begin
    qcList := TStringList.Create;
    fsList := TStringList.Create;
    rfList := TStringList.Create;
    DivideString(strQcAll,',',qcList);
    DivideString(strFsAll,',',fsList);
    DivideString(strRfAll,',',rfList);
    if qcList.Count>0 then
    begin
      sgCPT.RowCount :=qcList.Count +1;
      for i:=0 to sgcpt.ColCount-1 do
        for j:=1 to sgCPT.RowCount-1 do
          sgCPT.Cells[i,j]:='';
      dEndDepth:=0;
      for i:= 0 to qcList.Count-1 do
      begin
        dEndDepth := dEndDepth +g_cptIncreaseDepth;
        sgCPT.Cells[1,i+1]:= formatFloat('0.00',dEndDepth);
        sgCPT.Cells[2,i+1]:= qcList.Strings[i];
      end;

      if strFsAll<>'' then
        for i:=0 to fsList.Count-1 do
          sgCPT.Cells[3,i+1]:= fsList.Strings[i];
      if strRfAll<>'' then
        for i:=0 to rfList.Count-1 do
          sgCPT.Cells[4,i+1]:= rfList.Strings[i];
    end;
    qcList.Free;
    fsList.Free;
    rfList.Free;
    //sgStratum.Row :=1;
    //m_sgStratumSelectedRow :=1;
    //Get_oneRecord(aDrillNo,1);
    button_status(1,true);
  end
  else
  begin
    button_status(1,true);
    //clear_data(self);
  end;
  //sgStratum.Tag :=0;

end;

function TCPTForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM cpt '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(cboDrl_no.Text) ,'''','''''',[rfReplaceAll])+'''';
end;

function TCPTForm.GetInsertSQL: string;
var
  strSQL,strQc,strFs,strRf: string;
  i: integer;
  dEndDepth: double;
begin
  strSQL:='';
  strQc :='';
  strFs :='';
  strRf :='';
  for i:=1 to sgCPT.RowCount-2 do
  begin
    strQc := strQc+trim(sgCPT.Cells[2,i])+',';
    strFs := strFs+trim(sgCPT.Cells[3,i])+',';
    strRf := strRf + trim(sgCPT.Cells[4,i])+',';
  end;
  strQc := strQc+trim(sgCPT.Cells[2,sgCPT.RowCount-1]);
  strFs := strFs+trim(sgCPT.Cells[3,sgCPT.RowCount-1]);
  strRf := strRf+trim(sgCPT.Cells[4,sgCPT.RowCount-1]);
  dEndDepth:= edtBegin_Depth.Value + g_cptIncreaseDepth * (sgCPT.RowCount - 1);
  edtEnd_depth.Text := formatFloat('0.00',dEndDepth);
  strSQL:='INSERT INTO cpt '
    +'(prj_no,drl_no,begin_depth,end_depth,qc,fs,rf)'
    +' VALUES('''+g_ProjectInfo.prj_no_ForSQL +''','''
    +stringReplace(cboDrl_no.Text ,'''','''''',[rfReplaceAll]) +''','''
    +edtBegin_Depth.Text +''','''
    +edtEnd_Depth.Text +''','''
    +strQc +''','''
    +strFs +''','''
    +strRf +''')';

  result:= strSQL;
end;

function TCPTForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,strSQL,strQc,strFs,strRf:string;
  i:integer;
  dEndDepth: double;
begin
  strSQL:='';
  strQc :='';
  strFs :='';
  strRf :='';
  for i:=1 to sgCPT.RowCount-2 do
  begin
    strQc := strQc+trim(sgCPT.Cells[2, i])+',';
    strFs := strFs+trim(sgCPT.Cells[3, i])+',';
    strRf := strRf+trim(sgCPT.Cells[4, i])+',';
  end;
  strQc := strQc+trim(sgCPT.Cells[2, sgCPT.RowCount - 1]);
  strFs := strFs+trim(sgCPT.Cells[3, sgCPT.RowCount - 1]);
  strRf := strRf+trim(sgCPT.Cells[4, sgCPT.RowCount - 1]);
  dEndDepth:= edtBegin_Depth.Value + g_cptIncreaseDepth * (sgCPT.RowCount - 1);
  edtEnd_depth.Text := formatFloat('0.00',dEndDepth);
  strSQLWhere:=' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
               +' AND drl_no =' +''''+ stringReplace(cboDrl_no.Text ,'''','''''',[rfReplaceAll])+'''';
  strSQLSet:='UPDATE cpt SET ';
  strSQL:='';
  strSQLSet := strSQLSet + ' begin_depth='+''''+edtBegin_Depth.Text+''''+',';
  strSQLSet := strSQLSet + ' end_depth='+''''+edtEnd_Depth.Text+''''+',';
  strSQLSet := strSQLSet + ' qc='+''''+strQc+''''+',';
  strSQLSet := strSQLSet + ' fs='+''''+strFs+''''+',';
  strSQLSet := strSQLSet + ' rf='+''''+strRf+'''';
  //strSQLSet := strSQLSet + ' isSHQ'+'='+''''+cboDrillType.Text+'''';

  strSQL := strSQLSet+strSQLWhere;
  result := strSQL;
end;

procedure TCPTForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TCPTForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TCPTForm.FormCreate(Sender: TObject);
begin
  Top := 0;
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  sgCPT.ColCount := 5;
  sgCPT.RowCount := 10;
  sgCPT.RowHeights[0] := 16;
  sgCPT.Cells[1,0]:= '孔深度';
  sgCPT.Cells[2,0]:= '锥尖qc(MPa)';
  sgCPT.Cells[3,0]:= '侧壁fs(KPa)';
  sgCPT.Cells[4,0]:= '摩阻比rf(KPa)';
  sgCPT.ColWidths[0]:=10;
  sgCPT.ColWidths[1]:=50;
  sgCPT.ColWidths[2]:=90;
  sgCPT.ColWidths[3]:=90;
  sgCPT.ColWidths[4]:=100;
  Clear_Data(self);
  GetDrillsNo;
  m_drl_no:= '';
  if cboDrl_no.Text <>'' then
    button_status(1,true)
  else
    button_status(1,false);
  
end;

procedure TCPTForm.GetDrillsNo;
var
  strDrillTypeNo: string;
begin
  cboDrl_no.Clear;
  cboDrillType.Clear;
  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no,d_t_no ');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      while not Eof do
        begin
          strDrillTypeNo:= FieldByName('d_t_no').AsString;
          if (strDrillTypeNo = g_ZKLXBianHao.DanQiao) or (strDrillTypeNo = g_ZKLXBianHao.ShuangQiao) then
          begin
            cboDrl_no.Items.Add(FieldByName('drl_no').AsString);
            cboDrillType.Items.Add(strDrillTypeNo); //
          end;
          Next;
        end;
      close;
    end;
end;

procedure TCPTForm.cboDrl_noChange(Sender: TObject);
begin
  if m_drl_no <> cboDrl_no.Text then
  begin
    sgCPT.RowCount :=2;
    GetDataByDrillNo(cboDrl_no.Text);
  end;
  cboDrillType.ItemIndex:=cboDrl_no.ItemIndex;
  if cboDrillType.Text = g_ZKLXBianHao.ShuangQiao  then
  begin
    sgCPT.ColCount := 5;
    sgCPT.Cells[1,0]:= '孔深度';
    sgCPT.Cells[2,0]:= '锥尖qc(MPa)';
    sgCPT.Cells[3,0]:= '侧壁fs(KPa)';
    sgCPT.Cells[4,0]:= '摩阻比rf(KPa)';
  end
  else
  begin
    sgCPT.ColCount := 3;
    sgCPT.Cells[1,0]:= '孔深度';
    sgCPT.Cells[2,0]:= 'Ps(MPa)';
    sgCPT.Cells[3,0]:= '===========';
    sgCPT.Cells[4,0]:= '===========';  
  end;  
  m_drl_no := cboDrl_no.Text;
end;

procedure TCPTForm.GridAddExecute(Sender: TObject);
begin
  if (sgCPT.RowCount = 2) and (sgCPT.cells[1,1]='') then
  begin
    sgCPT.cells[1,1]:= floattostr(g_cptIncreaseDepth);
    exit;
  end
  else
  begin 
    sgCPT.RowCount := sgCPT.RowCount +1;
    sgCPT.Row := sgCPT.RowCount-1;
    try
      sgCPT.cells[1,sgCPT.Row]:= floattostr(strtofloat(sgCPT.Cells[1,sgCPT.Row-1])+g_cptIncreaseDepth);
    except
      sgCPT.cells[1,sgCPT.Row]:= '';
    end;
  end;
end;

procedure TCPTForm.GridDeleteOneRowExecute(Sender: TObject);
begin
  DeleteStringGridRow(sgCPT,sgCPT.Row);
end;

procedure TCPTForm.GridDeleteAllExecute(Sender: TObject);
begin
  sgCPT.RowCount := 2;
  DeleteStringGridRow(sgCPT,1);
end;

procedure TCPTForm.cboDrl_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);

end;

procedure TCPTForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  if not Check_Data then exit;
  strSQL := self.GetExistedSQL(cboDrl_no.Text);
  if isExistedRecord(MainDataModule.qryCPT,strSQL) then
    begin
      strSQL:= GetUpdateSQL;
      if Update_onerecord(MainDataModule.qryCPT,strSQL) then
        begin
          Button_status(1,true);
          cboDrl_no.SetFocus;
        end
      else
        Begin
          MessageBox(self.Handle,'数据更新失败，不能保存。','提示',MB_OK+MB_ICONERROR);
        end
    end
  else
    begin
      strSQL:= GetInsertSQL;
      if Insert_oneRecord(MainDataModule.qryCPT,strSQL) then
        begin
          Button_status(1,true);
          cboDrl_no.SetFocus;
        end
      else
        Begin
          MessageBox(self.Handle,'数据增加失败，不能保存。','提示',MB_OK+MB_ICONERROR);
        end       
    end;
      

end;

function TCPTForm.GetExistedSQL(aDrillNo: string): string;
begin
  result :='SELECT prj_no,drl_no FROM cpt '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''';

end;

procedure TCPTForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
  end
  else
  begin
    //clear_data(self);    
    Button_status(1,true);
    GetDataByDrillNo(cboDrl_no.Text);    
  end;  
end;

procedure TCPTForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if cboDrl_no.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryCPT,strSQL) then
        begin
          GridDeleteAll.Execute;
          edtBegin_Depth.Text :='0.00';
          edtEnd_depth.Text := '0.00';
          Button_status(1,true);
        end;
    end;

end;

procedure TCPTForm.sgCPTMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  iRow,iCol:integer;
begin
    iRow:= sgCPT.MouseCoord(x,y).Y;
    iCol:= sgCPT.MouseCoord(x,y).X;
    if (iRow>0) and (iRow<sgCPT.RowCount) then
      sgCPT.Row := iRow;
    if (iCol>0) and (iCol<sgCPT.ColCount) then
      sgCPT.Col := iCol;

end;

procedure TCPTForm.sgCPTKeyPress(Sender: TObject; var Key: Char);
begin
  if (sgCPT.Col =1) or (sgCPT.Col =4)  then //sgCPT深度那一列不能修改.
  begin
    key:=#0;  
    exit;
  end;
  if (key='e') or (key='E') or (key=' ') or(key='-') then
  begin
    key:=#0;
    exit;
  end;

  if key =chr(vk_back) then exit;
  OldCellValue:= sgCPT.Cells[sgCPT.Col,sgCPT.Row];
end;

procedure TCPTForm.rgFileTypeClick(Sender: TObject);
begin
  {if rgFileType.ItemIndex = 1 then
  begin
    sgCPT.Cells[1,0]:= '孔深度';
    sgCPT.Cells[2,0]:= '锥尖qc(MPa)';
    sgCPT.Cells[3,0]:= '侧壁fs(KPa)';
    sgCPT.Cells[4,0]:= '摩阻比rf(KPa)';
  end
  else
  begin
    sgCPT.Cells[1,0]:= '孔深度';
    sgCPT.Cells[2,0]:= 'Ps(MPa)';
    sgCPT.Cells[3,0]:= '===========';
    sgCPT.Cells[4,0]:= '===========';  
  end;}
end;

procedure TCPTForm.sgCPTDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  strCell: string;
begin
  strCell := sgCPT.Cells[ACol, ARow];
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    if strCell<>'' then
    begin
      //sgCPT.Canvas.Brush.Color := clWindow;
      //sgCPT.Canvas.FillRect(rect);
      if not isfloat(strCell) then        
        sgCPT.Canvas.Font.Color := clRed;
      //sgCPT.Canvas.TextOut(rect.Left,rect.Top,theText);
    end;
      
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TCPTForm.sgCPTSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
begin
  if (ACol=2) or (ACol=3) then
  begin
    if isFloat(sgCPT.Cells[2,ARow]) and (isFloat(sgCPT.Cells[3,ARow])) then
      try
        sgCPT.Cells[4, ARow]:= FormatFloat('0.0',strToFloat(sgCPT.Cells[3,ARow])/(strToFloat(sgCPT.Cells[2,ARow])*10));
      except
        sgCPT.Cells[4, ARow]:= '0.0';
      end;
  end;
end;

procedure TCPTForm.sgCPTKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (not isFloat(sgCPT.Cells[sgCPT.Col,sgCPT.Row])) and (sgCPT.Cells[sgCPT.Col,sgCPT.Row]<>'') then
    sgCPT.Cells[sgCPT.Col,sgCPT.Row]:= OldCellValue;  
end;

procedure TCPTForm.btnFileOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    edtFileName.Text := OpenDialog.FileName;  
end;

procedure TCPTForm.btn_LoadClick(Sender: TObject);
var
  lstFile: TStringList;
  i,j, iRow: integer;
  strFileName: string;
  strTmpQc, strTmpFs, strTmpRf: string;
  strDrillNo, strBegin_Depth, strEnd_Depth: string;
begin
  strFileName:= trim(edtFileName.Text);
  if not FileExists(strFileName) then
  begin
    MessageBox(self.Handle,'文件不存在!!!','错误...',MB_OK+MB_ICONERROR);
    exit;
  end; 
  if FileExists(strFileName) then
  begin
    strDrillNo:= cboDrl_no.Text;
    if strDrillNo='' then
    begin
      MessageBox(self.Handle,'请选择钻孔号!!!','提示...',MB_OK+MB_ICONERROR);
      exit;
    end;
    try
      lstFile:= TStringList.Create;
      lstFile.LoadFromFile(strFileName);

      for i:=lstFile.Count-1 downto 0 do
          if trim(lstFile.Strings[i])='' then
              lstFile.Delete(i);
      if lstFile.Count <1 then exit;

      for i:=0 to sgcpt.ColCount-1 do
        for j:=1 to sgCPT.RowCount-1 do
          sgCPT.Cells[i,j]:='';
      sgCPT.RowCount := 2;
      button_status(2,true);
      if cboDrillType.Text = g_ZKLXBianHao.DanQiao  then //单桥
      begin
        sgCPT.RowCount := lstFile.Count +1;
        for i:=0 to lstFile.Count-1 do
        begin
          strTmpQc:= lstFile.Strings[i];
          sgCPT.Cells[1, i+1]:= FormatFloat('0.00', (i+1)*g_cptIncreaseDepth );
          if not isfloat(strTmpQc) then
             MessageBox(application.Handle,'数据有错误，以红色显示，请修改。','系统提示',MB_OK+MB_ICONERROR);

          sgCPT.Cells[2, i+1]:= strTmpQc;
          sgCPT.Cells[3, i+1]:= '';
          sgCPT.Cells[4, i+1]:= '';
        end;
        strBegin_Depth:= edtBegin_depth.Text;
        strEnd_Depth := strBegin_Depth;
        if lstFile.Count >0 then
        begin
          strEnd_Depth:= FormatFloat('0.00',strtofloat(strBegin_Depth)+ g_cptIncreaseDepth * lstFile.Count);
        end;
      end
      else  //else cboDrillType.Text = g_ZKLXBianHao.ShuangQiao
      begin
        sgCPT.RowCount := lstFile.Count div 2 + 1;
        for i:=0 to lstFile.Count-1 do
        begin
          if (i mod 2) = 0 then
          begin
            strTmpQc:= lstFile.Strings[i];            
          end
          else
          begin
            iRow := i div 2 + 1;
            sgCPT.Cells[1, iRow]:= FormatFloat('0.00', iRow*g_cptIncreaseDepth );
            sgCPT.Cells[2, iRow]:= strTmpQc;
            if not isfloat(strTmpQc) then
              MessageBox(application.Handle,'数据有错误，以红色显示，请修改。','系统提示',MB_OK+MB_ICONERROR);

            strTmpFs:= lstFile.Strings[i];
            if not isfloat(strTmpFs) then
               MessageBox(application.Handle,'数据有错误，以红色显示，请修改。','系统提示',MB_OK+MB_ICONERROR);

            sgCPT.Cells[3, iRow]:= strTmpFs;
            strTmpRf := '';
            if isfloat(strTmpFs) and isfloat(strTmpQc) then
              strTmpRf:= FormatFloat('0.0',
                StrToFloat(strTmpFs)/(strToFloat(strTmpQc)*10));
            sgCPT.Cells[4, iRow]:= strTmpRf;
          end;
          
        end;
        strBegin_Depth:= edtBegin_depth.Text;
        strEnd_Depth := FormatFloat('0.00',
          strtofloat(strBegin_Depth)+ g_cptIncreaseDepth * trunc(lstFile.Count/2));
      end;
    finally
      lstFile.Free;
    end;
    button_status(2,true);
  end;

end;

procedure TCPTForm.btnCustomDeleteClick(Sender: TObject);
var
  I: Integer;
  dBegin_del: double;
  dEnd_del: double;
  dNowDepth: double;
begin
  Button_status(2,true);
  dBegin_del := edtBegin_Del.Value;
  dEnd_del := edtEnd_del.Value;
  for I := sgCPT.RowCount - 1 downto 1 do    // Iterate
  begin
    if sgCPT.Cells[1,I]<>'' then
    begin
      dNowDepth := strtoFloat(sgCPT.Cells[1,I]);
      if (dNowDepth > dBegin_del) and (dNowDepth < dEnd_del) then
        DeleteStringGridRow(sgCPT,i);
    end;
  end;    // for


end;

procedure TCPTForm.btnBatchLoadClick(Sender: TObject);
var
  I: Integer;
  lstFile: TStringlist;
  lstQc,lstFs,lstRf: TStringlist;
  strSQL,strFolder,strFileName: string;
  strTmpQc, strTmpFs, strTmpRf: string;
  strQc,strFs,strRf:string;
  strDrillNo, strDrillType, strEnd_Depth: string;
  J: Integer;
const
  strBegin_Depth='0.0';

begin
  strFolder := edtfolder.Text ;
  if strFolder='' then  exit;

  Screen.Cursor := crHourGlass;
  try
    for I := 0 to flbFileList.Count  - 1 do    // Iterate
    begin
      strFileName := flbFileList.Items[i];
      strDrillNo := copy(strfilename,0,LastDelimiter('.',strFileName)-1);
      strDrillNo := UpperCase(strDrillNo);
      for J := 0 to cboDrl_no.Items.Count - 1 do    // Iterate
      begin
        if strDrillNo=cboDrl_no.Items[J] then
          strDrillType := cboDrillType.Items[J];
      end;    // for
      lstFile := TStringList.Create;
      lstQc   := TStringlist.Create;
      lstFs   := TStringlist.Create;
      lstRf   := TStringlist.Create;
      try
        lstFile.LoadFromFile(edtFolder.Text + '\' + strFileName);
        for J:=lstFile.Count-1 downto 0 do
            if trim(lstFile.Strings[J])='' then
                lstFile.Delete(J);
        if lstFile.Count <1 then continue;

        if strDrillType = g_ZKLXBianHao.DanQiao  then //单桥
        begin
          for J:=0 to lstFile.Count-1 do
          begin
            strTmpQc:= lstFile.Strings[J];
            if not isfloat(strTmpQc) then
            begin
              MessageBox(application.Handle,PAnsiChar('Ps数据有错误，请修改。钻孔号：'
               +strDrillNo+' 错误数据行：'+IntToStr(i+1)),'系统提示',MB_OK+MB_ICONERROR);
              exit;
            end;
            lstQc.Add(strTmpQc);
            lstFs.Add('');
            lstRf.Add('');
          end;
          strEnd_Depth := strBegin_Depth;
          if lstFile.Count >0 then
          begin
            strEnd_Depth:= FormatFloat('0.00',strtofloat(strBegin_Depth)+ g_cptIncreaseDepth * lstFile.Count);
          end;
        end
        else if strDrillType = g_ZKLXBianHao.ShuangQiao  then //双桥
        begin
          for J:=0 to lstFile.Count-1 do
          begin
            if (J mod 2) = 0 then
            begin
              strTmpQc:= lstFile.Strings[J];
              if not isfloat(strTmpQc) then
              begin
                MessageBox(application.Handle,PAnsiChar('Qc数据有错误，不是数字。钻孔号：'
                 +strDrillNo+' 错误数据行：'+IntToStr(J+1)),'系统提示',MB_OK+MB_ICONERROR);
                exit;
              end;
              if IsZero(strToFloat(strTmpQc)) then
              begin
                MessageBox(application.Handle,PAnsiChar('Qc数据有错误，不能为零。钻孔号：'
                 +strDrillNo+' 错误数据行：'+IntToStr(J+1)),'系统提示',MB_OK+MB_ICONERROR);
                exit;
              end;
            end
            else
            begin

              strTmpFs:= lstFile.Strings[J];
              if not isfloat(strTmpFs) then
              begin
                MessageBox(application.Handle,PAnsiChar('Fs数据有错误，不是数字。钻孔号：'
                 +strDrillNo+' 错误数据行：'+IntToStr(J+1)),'系统提示',MB_OK+MB_ICONERROR);
                exit;
              end;
              strTmpRf := '';
              if isfloat(strTmpFs) and isfloat(strTmpQc) then
              begin
                strTmpRf:= FormatFloat('0.0',StrToFloat(strTmpFs)/(strToFloat(strTmpQc)*10));
                lstQc.Add(strTmpQc);
                lstFs.Add(strtmpFs);
                lstRf.Add(strtmpRf);
              end;
            end;

          end;
          strEnd_Depth := FormatFloat('0.00',
            strtofloat(strBegin_Depth)+ g_cptIncreaseDepth * trunc(lstFile.Count/2));
        end
        else //既不是单桥也不是双桥
          continue;

        //开始取得插入表的记录的值
        strSQL:='';
        strQc :='';
        strFs :='';
        strRf :='';
        for J:=0 to lstQc.Count-2 do
        begin
          strQc := strQc + lstQc[J]+',';
          strFs := strFs + lstFs[J]+',';
          strRf := strRf + lstRf[J]+',';
        end;
        strQc := strQc + lstQc[lstQc.Count-1];
        strFs := strFs + lstFs[lstFs.Count-1];
        strRf := strRf + lstRf[lstRf.Count-1];
        strSQL:='INSERT INTO cpt '
          +'(prj_no,drl_no,begin_depth,end_depth,qc,fs,rf)'
          +' VALUES('''+g_ProjectInfo.prj_no_ForSQL +''','''
          +stringReplace(strdrillno,'''','''''',[rfReplaceAll]) +''','''
          +strBegin_Depth +''','''
          +strEnd_Depth +''','''
          +strQc +''','''
          +strFs +''','''
          +strRf +''')';
        //插入数据库
        with MainDataModule.qryCPT do
          begin
            close;
            sql.Clear;
            sql.Add(strSQL);
            try
              try
                ExecSQL;
              except
                on e: Exception do
                  if pos('重复键',e.Message)<>0 then  //如果是插入重复，则不做处理。
                  else
                    MessageBox(application.Handle,PAnsiChar('数据库错误，增加数据失败。钻孔号：'
                      +strDrillNo+' 详细错误信息：' + e.Message ),'数据库错误',MB_OK+MB_ICONERROR);

              end;
            finally
              close;
            end;
          end;
      finally // wrap up
        lstFile.Free;
        lstQc.Free;
        lstFs.Free;
        lstRf.Free;
      end;    // try/finally

    end;
  finally
    Screen.Cursor := crDefault;

    MessageBox(application.Handle, '数据导入结束。','系统提示',MB_OK);

    m_drl_no := '';
    cboDrl_noChange(cboDrl_no);
  end;
end;

procedure TCPTForm.btnFolderNameClick(Sender: TObject);
var
  strPath: string;
begin
  if SelectDirectory('请选择存放钻孔静探数据的路径', '', strPath) then
  begin
    edtfolder.Text := strpath;
    flbFileList.Directory := strPath;
  end;
end;

end.
