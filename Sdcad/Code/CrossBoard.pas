unit CrossBoard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, Menus, StdCtrls, Mask,
  rxToolEdit, rxCurrEdit, Buttons, Grids, DB, strUtils, ExtCtrls, math;

type
  TCrossBoardForm = class(TForm)
    pmGrid: TPopupMenu;
    pmiAdd: TMenuItem;
    pmiDeleteOne: TMenuItem;
    pmiDeleteAll: TMenuItem;
    ActionManager1: TActionManager;
    GridAdd: TAction;
    GridDeleteOneRow: TAction;
    GridDeleteAll: TAction;
    lblCb_depth: TLabel;
    lblDrl_no: TLabel;
    lblCu: TLabel;
    sgCross: TStringGrid;
    cboDrl_no: TComboBox;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_delete: TBitBtn;
    btn_cancel: TBitBtn;
    edtCb_Depth: TCurrencyEdit;
    btn_add: TBitBtn;
    sgMain: TStringGrid;
    procedure btn_okClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridDeleteAllExecute(Sender: TObject);
    procedure cboDrl_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboDrl_noChange(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgCrossKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_addClick(Sender: TObject);
    procedure sgMainDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgMainSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgCrossMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sgCrossDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure GridAddExecute(Sender: TObject);
    procedure GridDeleteOneRowExecute(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(int_status:integer;bHaveRecord:boolean);
    procedure GetDataByDrillNo(aDrillNo: string);
    procedure Get_oneRecord(aDrillNo: string; aDepth: string);
    procedure GetDrillsNo;
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function Check_Data:boolean;
    function GetExistedSQL(aDrillNo: string; aDepth:string):string;    
  public
    { Public declarations }
  end;

var
  CrossBoardForm: TCrossBoardForm;
  m_DataSetState: TDataSetState;
  m_drl_no: string;
  m_CellPos:TGridCoord; //鼠标右键点击
implementation

uses MainDM, public_unit;

{$R *.dfm}


{ TCrossBoardForm }

procedure TCrossBoardForm.button_status(int_status: integer;
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
        sgCross.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
        sgCross.PopupMenu := nil;
        m_DataSetState := dsBrowse;
      end;
    2: //修改状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        btn_delete.Enabled :=false;
        Enable_Components(self,true);
        sgCross.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing];
        sgCross.PopupMenu := pmGrid;
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
        sgCross.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing];
        sgCross.PopupMenu := pmGrid;
        m_DataSetState := dsInsert;        
      end;
  end;
end;

function TCrossBoardForm.Check_Data: boolean;
var
  iRow, iCol: integer;
  blank: boolean;
begin
  if cboDrl_no.Text ='' then
  begin
    MessageBox(application.Handle,'请选择钻孔号！','系统提示',MB_OK+MB_ICONINFORMATION);
    cboDrl_no.SetFocus;
    exit;
  end;
  if trim(edtCb_Depth.Text) ='' then
  begin
    MessageBox(application.Handle,'请输入测试深度！','系统提示',MB_OK+MB_ICONINFORMATION);
    edtCb_Depth.SetFocus;
    exit;
  end;
  blank:= false;
  for iCol:=0 to sgCross.ColCount-1 do
    begin
        for iRow:=1 to sgCross.RowCount-1 do
        begin
          if blank and (trim(sgCross.Cells[iCol,iRow])<>'') then //此条件表示数据不是连续输入，中间有空值。
          begin
            MessageBox(self.Handle,
              '试验强度数据不是连续输入，不能保存。','提示',MB_OK+MB_ICONWARNING);
            result:= false;
            exit;
          end;
          if trim(sgCross.Cells[iCol,iRow])='' then
            blank:= true;
        end;
        blank:=false;
    end;
  for iRow:=1 to sgCross.RowCount-1 do
    for iCol:=0 to sgCross.ColCount-1 do
      if trim(sgCross.Cells[iCol,iRow])<>'' then
        if not isFloat(trim(sgCross.Cells[iCol,iRow])) then
        begin
          MessageBox(self.Handle,
            '有的数据不是数字，不能保存,请修改后再保存。','提示',MB_OK+MB_ICONWARNING);
          sgCross.SetFocus;
          sgCross.Col := iCol;
          sgCross.Row := iRow;
          result:= false;
          exit;          
        end;
  result:= true;
end;

procedure TCrossBoardForm.GetDataByDrillNo(aDrillNo: string);
var 
  strSQL,strCuAll: String;
  i,j, iCount: integer;
  CuList: TStringList;
begin
  GridDeleteAll.Execute;
  if trim(aDrillNo)='' then exit;
  strSQL:='SELECT prj_no,drl_no,cb_depth,Cu '
           +'FROM CrossBoard '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+'''';
  with MainDataModule.qryCrossBoard do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          strCuAll := FieldByName('Cu').AsString;
          edtCb_Depth.Text := formatFloat('0.00',FieldByName('cb_depth').AsFloat);
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin
    Get_oneRecord(trim(aDrillNo),edtCb_Depth.Text);
    button_status(1,true);
  end
  else
  begin
    button_status(1,true);
  end;


end;

function TCrossBoardForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM CrossBoard '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(trim(cboDrl_no.Text) ,'''','''''',[rfReplaceAll])+''' and cb_depth='+trim(edtCb_Depth.Text);
end;

procedure TCrossBoardForm.GetDrillsNo;
begin
  cboDrl_no.Clear;
  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no,drl_no ');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      while not Eof do
        begin
          cboDrl_no.Items.Add(FieldByName('drl_no').AsString);
          Next;
        end;
      close;
    end;
    SetCBWidth(cboDrl_no);
end;

function TCrossBoardForm.GetExistedSQL(aDrillNo: string;aDepth:string): string;
begin
  result :='SELECT prj_no,drl_no FROM CrossBoard '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
           +' AND cb_depth=' + aDepth;
end;

function TCrossBoardForm.GetInsertSQL: string;
var
  strSQL,strCu,strCell: string;
  iCol,iRow: integer;
  cu_max: double;
begin
  strSQL:='';
  strCu :='';
  cu_max:=0;
  for iRow:=1 to sgCross.RowCount-1 do
    for iCol:=0 to sgCross.ColCount-1  do
      begin
        if trim(sgCross.Cells[iCol,iRow])='' then
            strCu:=strCu+','
        else
        begin
            strCell:= trim(sgCross.Cells[iCol,iRow]);
            strCu := strCu+ strCell +',';
            if isfloat(strCell) then
                cu_max:=max(strtofloat(strCell),cu_max);
        end;
      end;
  if copy(ReverseString(strCu),1,1)=',' then
    delete(strCu,length(strCu),1);
  strSQL:='INSERT INTO CrossBoard '
    +'(prj_no,drl_no,cb_depth,Cu,cu_max)'
    +' VALUES(' 
    +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
    +''''+stringReplace(cboDrl_no.Text ,'''','''''',[rfReplaceAll]) +'''' + ','
    +''''+edtCb_depth.Text+'''' + ','
    +''''+strCu +''''+ ','
    +FormatFloat('0.0',cu_max)+')';

  result:= strSQL;

end;

function TCrossBoardForm.GetUpdateSQL: string;
var 
  strSQLWhere,strSQLSet,strSQL,strCu,strCell:string;
  iCol,iRow: integer;
  cu_max: double;
begin
  strSQL:='';
  strCu :='';
  cu_max:= 0;
  for iRow:=1 to sgCross.RowCount-1 do
    for iCol:=0 to sgCross.ColCount-1  do
      begin
        if trim(sgCross.Cells[iCol,iRow])='' then
            strCu:=strCu+','
        else
        begin
            strCell:= trim(sgCross.Cells[iCol,iRow]);
            strCu := strCu+ strCell +',';
            if isfloat(strCell) then
                cu_max:=max(strtofloat(strCell),cu_max);
        end;
      end;
  if copy(ReverseString(strCu),1,1)=',' then
    delete(strCu,length(strCu),1);
  strSQLWhere:=' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
               +' AND drl_no =' +''''+ stringReplace(sgMain.Cells[1,sgMain.Row] ,'''','''''',[rfReplaceAll])+''''
               +' AND cb_depth='+sgMain.Cells[2,sgMain.Row];
  strSQLSet:='UPDATE CrossBoard SET ';
  strSQLSet := strSQLSet + 'drl_no=' +''''+ stringReplace(trim(cboDrl_no.Text) ,'''','''''',[rfReplaceAll])+''''+',';
  strSQLSet := strSQLSet + ' cb_depth' +'='+''''+edtCb_Depth.Text+''''+',';
  strSQLSet := strSQLSet + ' Cu'+'='+''''+strCu+''''+',';
  strSQLSet := strSQLSet + ' Cu_max'+'='+FormatFloat('0.0',cu_max);

  strSQL := strSQLSet+strSQLWhere;
  result := strSQL;

end;

procedure TCrossBoardForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  if not Check_Data then exit;
  if m_DataSetState = dsInsert then
  begin
    strSQL := self.GetExistedSQL(cboDrl_no.Text,edtCb_depth.Text);
    if isExistedRecord(MainDataModule.qryCrossBoard,strSQL) then
    begin
      MessageBox(application.Handle,'当前钻孔和测试深度已经存在，不能保存。','数据库错误',MB_OK+MB_ICONERROR);
      cboDrl_no.SetFocus;
      exit;
    end;
    strSQL:= GetInsertSQL;
    if Insert_oneRecord(MainDataModule.qryCrossBoard,strSQL) then
      begin
        if (sgMain.RowCount =2) and (sgMain.Cells[1,1] ='') then
        else              
          sgMain.RowCount := sgMain.RowCount+1;
        sgMain.Cells[1,sgMain.RowCount-1] := trim(cboDrl_no.Text);
        sgMain.Cells[2,sgMain.RowCount-1] := FormatFloat('0.00',strtofloat(trim(edtCb_depth.Text)));
        sgMain.Row := sgMain.RowCount-1;
        Button_status(1,true);
        btn_add.SetFocus;
      end
    else
      MessageBox(self.Handle,'数据增加失败，不能保存。','提示',MB_OK+MB_ICONERROR);
  end
  else if m_DataSetState = dsEdit then
  begin
    if (sgMain.Cells[1,sgMain.Row]<>trim(cboDrl_no.Text)) 
      or (sgMain.Cells[2,sgMain.Row]<>FormatFloat('0.00',strtofloat(trim(edtCb_depth.Text)))) then
    begin
      strSQL := self.GetExistedSQL(cboDrl_no.Text,edtCb_depth.Text);
      if isExistedRecord(MainDataModule.qryStratum_desc,strSQL) then
      begin
        MessageBox(application.Handle,'当前钻孔和测试深度已经存在，不能保存。','数据库错误',MB_OK+MB_ICONERROR);
        cboDrl_no.SetFocus;
        exit;
      end;
    end; 
    strSQL:= GetUpdateSQL;
    if Update_onerecord(MainDataModule.qryCrossBoard,strSQL) then
        begin
          sgMain.Cells[1,sgMain.Row]:=trim(cboDrl_no.Text);
          sgMain.Cells[2,sgMain.Row]:=FormatFloat('0.00',strtofloat(trim(edtCb_depth.Text)));
          Button_status(1,true);
          btn_add.SetFocus;
        end
      else
        Begin
          MessageBox(self.Handle,'数据更新失败，不能保存。','提示',MB_OK+MB_ICONERROR);
        end
  end;
end;

procedure TCrossBoardForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin  
    Button_status(2,true);
    edtCb_Depth.SetFocus;
  end
  else
  begin
    clear_data(self); 
    GridDeleteAll.Execute;   
    Button_status(1,true);
    Get_oneRecord(sgMain.Cells[1,sgMain.row],sgMain.Cells[2,sgMain.row]);
  end;
end;

procedure TCrossBoardForm.btn_deleteClick(Sender: TObject);
var
  strSQL: string;
begin
  if MessageBox(self.Handle,
    '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  if cboDrl_no.Text <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qryCrossBoard,strSQL) then
        begin
          GridDeleteAll.Execute;
          Clear_Data(self);  
          DeleteStringGridRow(sgMain,sgMain.Row);
          if sgMain.Cells[1,sgMain.row]<>'' then
          begin
            self.Get_oneRecord(sgMain.Cells[1,sgMain.row],sgMain.Cells[2,sgMain.row]);
            button_status(1,true);
          end
          else
            button_status(1,false);
        end;
    end;
 
end;

procedure TCrossBoardForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  sgCross.RowHeights[0] := 16;
  sgCross.Cells[0,0] := '原状土Cu';
  sgCross.Cells[1,0] := '重塑土Cu''';
  sgCross.ColWidths[0]:=120;
  sgCross.ColWidths[1]:=120;

  sgMain.RowHeights[0] := 16;
  sgMain.Cells[1,0] := '钻孔';
  sgMain.Cells[2,0] := '测试深度';  
  sgMain.ColWidths[0]:=10;
  sgMain.ColWidths[1]:=120;
  sgMain.ColWidths[2]:=80;
  GetDrillsNo;
  with MainDataModule.qryCrossBoard do
    begin
      close;
      sql.Clear;
      sql.Add('select prj_no,drl_no,cb_depth FROM CrossBoard');
      sql.Add(' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''');
      open;
      i:=0;
      sgMain.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          sgMain.RowCount := i +1;
          sgMain.Cells[1,i] := FieldByName('drl_no').AsString;
          sgMain.Cells[2,i] := FormatFloat('0.00',FieldByName('cb_depth').AsFloat); 
          Next ;
        end;
      close;
      sgMain.Tag := 0;
    end;
  if i>0 then
  begin
    sgMain.Row :=1;
    Get_oneRecord(sgMain.Cells[1,1],sgMain.Cells[2,1]);
    button_status(1,true);
  end
  else
    button_status(1,false);
end;

procedure TCrossBoardForm.GridDeleteAllExecute(Sender: TObject);
var
  iCol, iRow: integer;
begin
  for iCol:=0 to sgCross.ColCount-1 do
    for iRow:=1 to sgCross.RowCount-1 do
      sgCross.Cells[iCol,iRow]:='';
end;

procedure TCrossBoardForm.cboDrl_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

procedure TCrossBoardForm.cboDrl_noChange(Sender: TObject);
begin
  //GetDataByDrillNo(cboDrl_no.Text);
end;

procedure TCrossBoardForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TCrossBoardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TCrossBoardForm.sgCrossKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_RETURN then
  begin
      if sgCross.Row = (sgCross.RowCount -1) then
        if sgCross.col=1 then
          postMessage(self.Handle, wm_NextDlgCtl,0,0)
        else
        begin
          sgCross.col:=sgCross.col+1;
          sgCross.Row:=1;
        end
      else
        sgCross.Row:=sgCross.Row + 1;
  end;

  if (key=40) and (sgCross.Row=sgCross.RowCount-1) then
  begin
      sgCross.RowCount:=sgCross.RowCount+1;
  end

end;

procedure TCrossBoardForm.btn_addClick(Sender: TObject);
begin
  Clear_Data(self);
  GridDeleteAll.Execute;
  Button_status(3,true);
  cboDrl_no.SetFocus;
end;

procedure TCrossBoardForm.Get_oneRecord(aDrillNo, aDepth: string);
var 
  strSQL,strCuAll: String;
  i,j, iCount: integer;
  CuList: TStringList;
begin
  GridDeleteAll.Execute;
  if trim(aDrillNo)='' then exit;
  cboDrl_no.ItemIndex := cboDrl_no.Items.IndexOf(aDrillNo); 
  strSQL:='SELECT prj_no,drl_no,cb_depth,Cu '
           +'FROM CrossBoard '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
           +' AND cb_depth=' + aDepth;
  with MainDataModule.qryCrossBoard do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      if not Eof then
        begin
          i:=i+1;
          
          strCuAll := FieldByName('Cu').AsString;
          edtCb_Depth.Text := formatFloat('0.00',FieldByName('cb_depth').AsFloat);
        end;
      close;
    end;
  if i>0 then
  begin
    CuList := TStringList.Create;
    DivideString(strCuAll,',',CuList);
    if CuList.Count>0 then
    begin
      iCount:= -1;
      if sgcross.RowCount <(CuList.Count/2+2) then
        sgCross.RowCount := round(CuList.Count/2)+2;
        
      for i:= 1 to sgCross.RowCount -1 do
        for j:= 0 to sgCross.ColCount -1 do
          begin
            Inc(iCount);
            if iCount<cuList.Count then
              sgCross.Cells[j,i]:= CuList.Strings[iCount];
          end;
      sgCross.Row := 1;
    end;
    cuList.Free;
    button_status(1,true);
  end
  else
  begin
    button_status(1,true);
  end;
end;

procedure TCrossBoardForm.sgMainDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
end;

procedure TCrossBoardForm.sgMainSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>TStringGrid(Sender).Row) then
    if sgMain.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(sgMain.Cells[1,ARow],sgMain.Cells[2,ARow]);
      if sgMain.Cells[1,ARow]='' then
        Button_status(1,false)
      else
        Button_status(1,true); 
    end
    else
      clear_data(self);
end;


procedure TCrossBoardForm.sgCrossMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  m_CellPos := sgCross.MouseCoord(X, Y);
end;

procedure TCrossBoardForm.sgCrossDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  AlignGridCell(Sender, ACol, ARow,Rect, taRightJustify);
end;

procedure TCrossBoardForm.GridAddExecute(Sender: TObject);
var
  tmp:string;
  i:Integer;
begin
  if (m_CellPos.X>=0) and (m_CellPos.Y>0) then
  begin
    sgCross.RowCount := sgCross.RowCount + 1;
    for i:= sgCross.RowCount-1 downto m_CellPos.Y do
      sgCross.Cells[m_CellPos.X, i] := sgCross.Cells[m_CellPos.X, i-1];
    sgCross.Cells[m_CellPos.X, m_CellPos.Y ] := '';
  end;
end;

procedure TCrossBoardForm.GridDeleteOneRowExecute(Sender: TObject);
var
  tmp:string;
  i:Integer;
begin
  if (m_CellPos.X>=0) and (m_CellPos.Y>0) then
  begin
    for i:= m_CellPos.Y to sgCross.RowCount-1 do
      sgCross.Cells[m_CellPos.X, i] := sgCross.Cells[m_CellPos.X, i+1];
    
  end;
end;

end.
