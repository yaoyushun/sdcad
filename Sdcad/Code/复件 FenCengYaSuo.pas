unit FenCengYaSuo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, Grids, ExtCtrls, ComCtrls, SUIForm,
  frxDSet, frxDBSet, frxClass, ADODB, frxChart;

type
  TFenCengYaSuoForm = class(TForm)
    suiForm1: TsuiForm;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    sgStratum: TStringGrid;
    Panel2: TPanel;
    Label1: TLabel;
    lbl2: TLabel;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    btn_edit: TBitBtn;
    edtYssy_yali: TEdit;
    edtYssy_kxb: TEdit;
    edtYssy_ysxs: TEdit;
    edtYssy_ysml: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnFenCengJiSuan: TButton;
    frFenCeng: TfrxReport;
    frDBFenCeng: TfrxDBDataset;
    frxChartObject1: TfrxChartObject;
    DSFenCeng: TDataSource;
    DSStratum: TDataSource;
    qryStratum: TADOQuery;
    frDBStratum: TfrxDBDataset;
    tbFenCeng: TADOTable;
    btn_Print: TBitBtn;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtYssy_yaliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_editClick(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure sgStratumDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgStratumSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnFenCengJiSuanClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure frFenCengGetValue(const ParName: String;
      var ParValue: Variant);
    procedure Button1Click(Sender: TObject);
  private
    procedure button_status(int_status: integer;bHaveRecord: boolean);
    procedure Get_oneRecord(aStratumNo: string; aSub_no: string);
    procedure Get_OldRecord; //当在放弃修改或新增时把所有edit和combox的值复原
    procedure Set_OldRecord; //
    //在修改和新增前取得所有edit和combox的值保存在TOldRecord的变量中。
    function GetInsertSQL:string;
    function GetUpdateSQL:string;
    function GetDeleteSQL:string;
    function GetExistedSQL(aStratumNo, aSub_no: string):string;
    function Check_Data:boolean;
    procedure getAllRecord(aFocusRec: integer);
    procedure GetAllStratumNo(var AStratumNoList, ASubNoList: TStringList);
  public
    { Public declarations }
  end;
type TOldRecord=record
  Yssy_yali: string;
  Yssy_kxb : string;
  Yssy_ysxs: string;
  Yssy_ysml: string;
  end;


var
  FenCengYaSuoForm: TFenCengYaSuoForm;

  m_DataSetState: TDataSetState;
  m_memSelStart: integer;
  m_OldRecord: TOldRecord;
implementation

uses MainDM, public_unit, StratumCategory, Preview;

{$R *.dfm}

{ TFenCengYaSuoForm }

procedure TFenCengYaSuoForm.button_status(int_status: integer;
  bHaveRecord: boolean);
begin
  case int_status of
    1: //浏览状态
      begin
        btn_edit.Enabled :=bHaveRecord;
        btn_edit.Caption :='修改';
        btn_ok.Enabled :=false;
        Enable_Components(self,false);
        m_DataSetState := dsBrowse;
      end;
    2: //修改状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        Enable_Components(self,true);
        m_DataSetState := dsEdit;
      end;
    3: //增加状态
      begin
        btn_edit.Enabled :=true;
        btn_edit.Caption :='放弃';
        btn_ok.Enabled :=true;
        Enable_Components(self,true);
        m_DataSetState := dsInsert;
      end;
  end;
end;

function TFenCengYaSuoForm.Check_Data: boolean;
begin
  result := false;
  if trim(edtYssy_yali.Text) = '' then
  begin
    messagebox(self.Handle,'请输入压缩试验各级压力！','数据校对',mb_ok);
    edtYssy_yali.SetFocus;
    exit;
  end;

  if trim(edtYssy_kxb.Text) = '' then
  begin
    messagebox(self.Handle,'请输入各级压力下孔隙比！','数据校对',mb_ok);
    edtYssy_kxb.SetFocus;
    exit;
  end;

  if trim(edtYssy_ysxs.Text) = '' then
  begin
    messagebox(self.Handle,'请输入各级压力下压缩系数！','数据校对',mb_ok);
    edtYssy_ysxs.SetFocus;
    exit;
  end;

  if trim(edtYssy_ysml.Text) = '' then
  begin
    messagebox(self.Handle,'请输入各级压力下压缩模量！','数据校对',mb_ok);
    edtYssy_ysml.SetFocus;
    exit;
  end;
  result := true;
end;

procedure TFenCengYaSuoForm.Get_OldRecord;
begin
  edtYssy_yali.Text := m_OldRecord.Yssy_yali;
  edtYssy_kxb.Text  := m_OldRecord.Yssy_kxb;
  edtYssy_ysxs.Text := m_OldRecord.Yssy_ysxs;
  edtYssy_ysml.Text := m_OldRecord.Yssy_ysml;
end;

procedure TFenCengYaSuoForm.Set_OldRecord;
begin
  m_OldRecord.Yssy_yali := trim(edtYssy_yali.Text);
  m_OldRecord.Yssy_kxb  := trim(edtYssy_kxb.Text);
  m_OldRecord.Yssy_ysxs := trim(edtYssy_ysxs.Text);
  m_OldRecord.Yssy_ysml := trim(edtYssy_ysml.Text);
end;

procedure TFenCengYaSuoForm.Get_oneRecord(aStratumNo, aSub_no: string);
var 
  strSQL:string;
  subNo:string;
begin
  subNo:=stringReplace(aSub_no,'''','''''',[rfReplaceAll]);
  if trim(aStratumNo)='' then exit;
  strSQL:= 'select * FROM FenCengYaSuo '
    + ' WHERE stra_no='+''''+aStratumNo+''''
    + ' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    + ' AND sub_no=' +''''+subNo+'''';
  with MainDataModule.qryPublic   do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL); 
      open;
      
      while not Eof do
      begin
        edtYssy_yali.Text := fieldByName('Yssy_yali').AsString;
        edtYssy_kxb.Text  := fieldByName('Yssy_kxb').AsString;
        edtYssy_ysxs.Text := fieldByName('Yssy_ysxs').AsString;
        edtYssy_ysml.Text := fieldByName('Yssy_ysml').AsString;

        next;
      end;
      close;
    end;

end;

procedure TFenCengYaSuoForm.getAllRecord(aFocusRec: integer);
var 
  i: integer;
begin
  with MainDataModule.qryPublic  do
    begin
      close;
      sql.Clear;
      sql.Add('select sd.id,fc.* FROM FenCengYaSuo fc,stratum_description sd');
      sql.Add(' WHERE fc.prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''');
      sql.Add(' AND sd.prj_no=fc.prj_no ');
      sql.Add(' AND sd.stra_no=fc.stra_no ');
      sql.Add(' AND sd.sub_no=fc.sub_no ');
      sql.Add(' ORDER BY id');
      open;
      i:=0;
      sgStratum.Tag := 1;
      sgStratum.RowCount := 2;
      while not Eof do
        begin
          i:=i+1;
          sgStratum.RowCount := i +1;
          //sgStratum.Cells[0,i] := FieldByName('id').AsString;
          sgStratum.Cells[1,i] := FieldByName('stra_no').AsString;
          if FieldByName('sub_no').AsString='0' then
            sgStratum.Cells[2,i] := ''
          else
            sgStratum.Cells[2,i] := FieldByName('sub_no').AsString;
          sgStratum.Cells[3,i] := FieldByName('sub_no').AsString;
          Next ;
        end;
      close;
      sgStratum.Tag := 0;
    end;
  if i>0 then
  begin
    if aFocusRec>sgStratum.RowCount-1 then
       aFocusRec:=1;
    sgStratum.Row :=aFocusRec;
    Get_oneRecord(sgStratum.Cells[1,aFocusRec],sgStratum.Cells[3,aFocusRec]);
    button_status(1,true);
  end
  else
    button_status(1,false);
  Set_OldRecord;

end;

function TFenCengYaSuoForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM FenCengYaSuo '
    + ' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND stra_no='+''''+sgStratum.Cells[1,sgStratum.Row]+''''
    +' AND sub_no=' +''''+stringReplace(sgStratum.Cells[3,sgStratum.row],'''','''''',[rfReplaceAll])+'''';  

end;


function TFenCengYaSuoForm.GetExistedSQL(aStratumNo,
  aSub_no: string): string;
var
  subNo: string;
begin
  subNo:= trim(aSub_no);
  subNo:=stringReplace(trim(aSub_no),'''','''''',[rfReplaceAll]);
  if subNo='' then subNo:='0';
  
  Result:='SELECT prj_no,stra_no,sub_no FROM FenCengYaSuo '
    + ' WHERE stra_no='+''''+aStratumNo+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
    +' AND sub_no=' +''''+subNo+'''';

end;

function TFenCengYaSuoForm.GetInsertSQL: string;
begin

end;

function TFenCengYaSuoForm.GetUpdateSQL: string;
var
  strSQLWhere,strSQLSet,subNo:string;
begin
  strSQLWhere:=' WHERE stra_no='+''''+sgStratum.Cells[1,sgStratum.Row]+''''
    +' AND '+'prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
    +' AND sub_no=' +''''+stringReplace(sgStratum.Cells[3,sgStratum.row],'''','''''',[rfReplaceAll])+'''';
  strSQLSet:='UPDATE FenCengYaSuo SET ';

  strSQLSet := strSQLSet
    + 'yssy_yali='+''''+trim(edtYssy_yali.Text)+''''+','
    + 'yssy_kxb=' +''''+trim(edtYssy_kxb.Text)+''''+','
    + 'yssy_ysxs='+''''+trim(edtYssy_ysxs.Text)+''''+','
    + 'yssy_ysml='+''''+trim(edtYssy_ysml.Text)+'''';
  result := strSQLSet + strSQLWhere;

end;



procedure TFenCengYaSuoForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  sgStratum.RowHeights[0] := 16;
  //sgStratum.Cells[0,0] := '序号';
  sgStratum.Cells[1,0] := '主层';
  sgStratum.Cells[2,0] := '亚层';
  sgStratum.ColWidths[0]:=30;
  sgStratum.ColWidths[1]:=40;
  sgStratum.ColWidths[2]:=40;
  Clear_Data(self);

  getAllRecord(1);
end;

procedure TFenCengYaSuoForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TFenCengYaSuoForm.edtYssy_yaliKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TFenCengYaSuoForm.btn_editClick(Sender: TObject);
begin
  if btn_edit.Caption ='修改' then
  begin
    Button_status(2,true);
    edtYssy_yali.SetFocus;
  end
  else
  begin
    clear_data(self);
    Button_status(1,true);
    Get_OldRecord;

  end;
end;

procedure TFenCengYaSuoForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  if not Check_Data then exit;

  if m_DataSetState = dsEdit then
    begin
      strSQL := self.GetUpdateSQL;        
      if Update_oneRecord(MainDataModule.qryPublic ,strSQL) then
        begin
          btn_edit.SetFocus;
          button_status(1,true);
          MessageBox(self.Handle,'更新数据成功！','更新数据',MB_OK+MB_ICONINFORMATION);
        end;
    end;


end;

procedure TFenCengYaSuoForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFenCengYaSuoForm.sgStratumDrawCell(Sender: TObject; ACol,
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

procedure TFenCengYaSuoForm.sgStratumSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>sgStratum.Row) then
    if sgStratum.Cells[1,ARow]<>'' then
    begin
      Get_oneRecord(sgStratum.Cells[1,ARow],sgStratum.Cells[3,ARow]);
      Button_status(1,true);
    end
    else
    begin
      clear_data(self);
      Button_status(1,false);
    end;
  Set_OldRecord;
end;

//取得一个工程中所有的层号和亚层号和土类名称，保存在三个TStringList变量中。
procedure TFenCengYaSuoForm.GetAllStratumNo(var AStratumNoList, ASubNoList: TStringList);
var
  strSQL: string;
begin
  AStratumNoList.Clear;
  ASubNoList.Clear;
  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description'
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' ORDER BY id';
  with MainDataModule.qryPublic  do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      while not eof do
        begin
          AStratumNoList.Add(FieldByName('stra_no').AsString); 
          ASubNoList.Add(FieldByName('sub_no').AsString);
          next; 
        end;
      close;
    end;
end;


procedure TFenCengYaSuoForm.btnFenCengJiSuanClick(Sender: TObject);
var
  I: Integer;
  j,iRecordCount: Integer;
  strSQL,strFieldNames, strFieldValues , strTmp, strSubNo,strStratumNo: string;
  strYali,strKxb,strYsxs,strYsml: string;
  lstStratumNo,lstSubNo, lstCskxb,lstYali,lstKxb,lstYsxs,lstYsml: TStringlist;
  dAvgCskxb, //初始孔隙比平均值
  dAvgKxb,   //孔隙比平均值
  dAvgYsxs,  //压缩系数
  dAvgYsml: double;  //压缩模量
  function getAverageFromList(aList:TStringList):String;
  var
    I: Integer;
    iColCount,iRowCount:integer;
    lstCol,lstRow: TStringList;
  begin
    lstCol:= TStringlist.Create;
    lstRow:= TStringlist.Create;
    for iRowCount := 0 to aList.Count  - 1 do    // Iterate
    begin
      DivideString(aList.Strings[iRowCount],',',lstCol);
      for iColCount := 0 to lstCol.Count - 1 do    // Iterate
      begin
        if iColCount>=lstRow.Count then
          lstRow.Add(lstCol.Strings[iColCount])
        else
        begin
          if lstCol.Strings[iColCount]<>'' then
            if lstRow.Strings[iColCount]<>'' then
              lstRow.Strings[iColCount]:=FloattoStr(strToFloat(lstCol.Strings[iColCount])
                                            +strToFloat(lstRow.Strings[iColCount]))
            else
              lstRow.Strings[iColCount]:=lstCol.Strings[iColCount];
        end;
      end;    // for
    end;    // for

    for I := 0 to lstRow.Count - 1 do    // Iterate
    begin

      if lstRow.Strings[I]<>'' then
        lstRow.Strings[I]:= FormatFloat('0.000',strToFloat(lstRow.Strings[I])/aList.Count);
      if I=0 then
        result := lstRow.Strings[I]
      else
        result := result + ',' + lstRow.Strings[I];
    end;

    lstCol.Free;
    lstRow.Free;
  end;

  function getYsxsFromKxb(aKxb:string):string;   //根据孔隙比算压缩系数 aKxb 就是 '0.965,0.873,0.786' 这样的字符串
  var
    iTmp:integer;
    lstTemp:TStringlist;
  begin
    result := '';
    lstTemp := TStringList.Create;
    DivideString(aKxb,',',lstTemp);
    for iTmp := 1 to lstTemp.Count  - 1 do    // Iterate
    begin
      result := result  + FormatFloat('0.000',(strtoFloat(lstTemp.Strings[iTmp-1])-strtoFloat(lstTemp.Strings[iTmp]))/0.05) + ',';
    end;  // for
    if copy(result,length(result),1)=',' then
      result:= copy(result,1,length(result)-1);

  end;

  function getYsmlFromKxb(aKxb:string):string;   //根据孔隙比算压缩模量 aKxb 就是 '0.965,0.873,0.786' 这样的字符串
  var
    iTmp:integer;
    dChuShiKxb,  //初始孔隙比 压力为0时的孔隙比
    dYsxs,       //压缩系数
    dYsml,       //压缩模量
    dKxb:double; //压力不为0时的孔隙比
    lstTemp:TStringlist;
  begin
    result := '';
    lstTemp := TStringList.Create;
    DivideString(aKxb,',',lstTemp);
    if lstTemp.Count >0 then
      dChuShiKxb := strtoFloat(lstTemp.Strings[0]);
    for iTmp := 1 to lstTemp.Count  - 1 do    // Iterate
    begin
        dKxb := strtoFloat(lstTemp.Strings[iTmp]);
        dYsxs:= (strtoFloat(lstTemp.Strings[iTmp-1])-strtoFloat(lstTemp.Strings[iTmp]))/0.05;
        if iTmp=1 then
        begin
          dYsml := (1+dChuShiKxb)/dYsxs;
          result:= FormatFloat('0.00',dYsml);
        end
        else
        begin
          if g_ProjectInfo.prj_type =GongMinJian then
            dYsml := (1+dChuShiKxb)/dYsxs
          else if g_ProjectInfo.prj_type =LuQiao then
            dYsml := (1+dKxb)/dYsxs ;
          result := result  + ',' + FormatFloat('0.00',dYsml);
        end;
    end;  // for
    if copy(result,length(result),1)=',' then
      result:= copy(result,1,length(result)-1);
  end;
begin
  lstStratumNo := TStringlist.Create;
  lstSubNo := TStringlist.Create;
  lstCskxb := TStringlist.Create;
  lstYali := TStringlist.Create;
  lstKxb := TStringlist.Create;
  lstYsxs := TStringlist.Create;
  lstYsml := TStringlist.Create;

  Screen.Cursor := crHourGlass;
  try
    //清除表cptTmp中当前工程的所有记录
    strSQL:= 'DELETE FROM FenCengYaSuo WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''' ;
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      ExecSQL;
      close;
    end;
    //取得当前工程的所有层号，亚层号
    GetAllStratumNo(lstStratumNo, lstSubNo);
    for I := 0 to lstStratumNo.Count  - 1 do    // Iterate
    begin
      strSubNo := stringReplace(lstSubNo.Strings[i],'''','''''',[rfReplaceAll]);
      strStratumNo := lstStratumNo.Strings[i];
      strSQL:='SELECT prj_no,stra_no,sub_no,gap_rate,yssy_yali,yssy_kxb,yssy_ysxs,yssy_ysml '
        +' FROM earthsample '
        +' WHERE prj_no = '+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND stra_no='+''''+strStratumNo+''''
        +' AND sub_no='+''''+strSubNo+''''
        +' AND if_statistic=1';
      iRecordCount := 0;
      with MainDataModule.qryEarthSample do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        while not eof do
          begin
            lstCskxb.Add(FieldByName('gap_rate').AsString);
            lstYali.Add('0'+','+FieldByName('yssy_yali').AsString);
            lstKxb.Add(FieldByName('gap_rate').AsString+','+FieldByName('yssy_kxb').AsString);
            lstYsxs.Add(FieldByName('yssy_ysxs').AsString);
            lstYsml.Add(FieldByName('yssy_ysml').AsString);
            Inc(iRecordCount);
            next;
          end;
        close;
      end;  //With MainDataModule.qryEarthSample

      if iRecordCount=0 then Continue; //如果当前层没有数据，转入下一层

      //strYali,strKxb,strYsxs,strYsml
      strYali := '';
      for J := 0 to lstYali.Count  - 1 do    // Iterate
      begin
        if lstYali.Strings[J]>strYali then
          strYali := lstYali.Strings[J];
      end;    // for
      if copy(strYali,length(strYali),1)=',' then
        strYali:= copy(strYali,1,length(strYali)-1);
      if (strYali='0') or (strYali='') then continue; //一个层的所有试样的数据里如果没有压力分级的数据，则处理下一层


      strKxb := getAverageFromList(lstKxb);
      strysxs:= getYsxsFromKxb(strKxb);
      strYsml:= getYsmlFromKxb(strKxb);

      strSQL:='INSERT INTO FenCengYaSuo (prj_no,stra_no,sub_no,yssy_yali,yssy_kxb,yssy_ysxs,yssy_ysml)'
        +' VALUES ('+''''+g_ProjectInfo.prj_no_ForSQL+''','''
        + strStratumNo+''','''
        + strSubNo+''','''+strYali+''','''+strKxb+''',''' + strysxs +''','''+strYsml+''')';
      Insert_oneRecord(MainDataModule.qryPublic, strSQL);

      lstCskxb.Clear;
      lstYali.Clear;
      lstKxb.Clear;
      lstYsxs.Clear;
      lstYsml.Clear;
    end;    // for
  finally
    lstStratumNo.Free;
    lstSubNo.Free;
    lstCskxb.Free;
    lstYali.Free;
    lstKxb.Free;
    lstYsxs.Free;
    lstYsml.Free;
    //计算完后重新取得数据
    getAllRecord(1);
    screen.Cursor := crDefault;
  end;
end;

procedure TFenCengYaSuoForm.btn_PrintClick(Sender: TObject);
var
  I: Integer;
  strSQL: string;
  stra_no,sub_no,yssy_yali,yssy_kxb,yssy_ysxs,yssy_ysml: string;
  lstStratumNo,lstSubNo, lstCskxb,lstYali,lstKxb,lstYsxs,lstYsml: TStringlist;
  iRecordCount:integer;
const
  TempTableName = 'TmpFenCengYaSuo';
begin
  lstYali := TStringlist.Create;
  lstKxb  := TStringlist.Create;
  lstYsxs := TStringlist.Create;
  lstYsml := TStringlist.Create;

  Screen.Cursor := crHourGlass;
  try
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      strSQL := 'SELECT id,prj_no,stra_no,sub_no,ea_name'
        +' FROM stratum_description'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' ORDER BY id'
    else
    strSQL:='SELECT sd.id,sd.prj_no,sd.stra_no,sd.sub_no,ISNULL(ea.ea_name_en,'''''''') as ea_name '
        +' FROM stratum_description sd, earthtype ea'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND sd.ea_name = ea.ea_name '
        +' ORDER BY id';
    with qryStratum do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
      end;

    strSQL := 'SELECT * FROM FenCengYaSuo WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      iRecordCount := 0;
      while not eof do
      begin
        inc(iRecordCount);
        if iRecordCount=1 then
          strSQL := 'SELECT * INTO ' + TempTableName + ' FROM (';
        stra_no   := FieldByName('stra_no').AsString;
        sub_no    := FieldByName('sub_no').AsString;
        yssy_yali := FieldByName('yssy_yali').AsString;
        yssy_kxb  := FieldByName('yssy_kxb').AsString;
        yssy_ysxs := FieldByName('yssy_ysxs').AsString;
        yssy_ysml := FieldByName('yssy_ysml').AsString;

        divideString(yssy_yali, ',',lstYali);
        divideString(yssy_kxb,  ',',lstKxb);
        divideString(yssy_ysxs, ',',lstYsxs);
        divideString(yssy_ysml, ',',lstYsml);
        for I := 0 to lstYali.Count - 1 do    // Iterate
        begin
          if (iRecordCount=1) and (I=0) then
            strSQL := strSQL+ 'SELECT ''' + stra_no+''' as stra_no,'''
               + sub_no+''' as sub_no,'
               + lstYali[I]+' as yali,'''
               + lstKxb[I]+''' as kxb,'''
               + ''+''' as ysxs,'''
               + ''+''' as ysml'
          else
            if I=0 then
              strSQL := strSQL+ ' UNION SELECT ''' + stra_no+''','''
                 + sub_no+''','
                 + lstYali[I]+','''
                 + lstKxb[I] +''','''
                 + ''+''','''
                 + ''+''''
            else
              strSQL := strSQL+ ' UNION SELECT ''' + stra_no+''','''
                 + sub_no+''','
                 + lstYali[I]+','''
                 + lstKxb[I] +''','''
                 + lstYsxs[I-1]+''','''
                 + lstYsml[I-1]+'''';
        end;
        next;
      end;    // while
    end;
    if iRecordCount>0 then
      strSQL := strSQL + ') myVoidTable'
    else
      exit;

    MainDataModule.DropTableFromDB(TempTableName);
  //  strSQL := 'SELECT * INTO ' + TempTableName
  //    + ' FROM (SELECT ''3'' as stra_no,''1'' as sub_no,1 as yali,0 as kxb,7 as ysxs,10 as ysml from cpt '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',2,100,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',3,200,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',4,300,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',5,400,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',6,500,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',7,600,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',8,700,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',9,800,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',10,900,8,11) VoidTable ';
    with MainDataModule.qryPublic  do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        try
          ExecSQL;
        except
        end;
        close;
      end;

    tbFenCeng.TableName := TempTableName;
    tbFenCeng.MasterFields := 'stra_no;sub_no';
    tbFenCeng.Open ;

    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      frFenCeng.LoadFromFile(g_AppInfo.PathOfReports + 'FenCengYaSuoQuXian.frf')
    else
      frFenCeng.LoadFromFile(g_AppInfo.PathOfReports + 'FenCengYaSuoQuXian_en.frf');
    frFenCeng.Preview := PreviewForm.frxPreview1;
    //开始打印报表
    if frFenCeng.PrepareReport  then
    begin
      frFenCeng.ShowPreparedReport;
      PreviewForm.ShowModal;
    end;
    qryStratum.Close;
    tbFenCeng.Close;
  finally
    lstYali.Free;
    lstKxb.Free;
    lstYsxs.Free;
    lstYsml.Free;
    screen.Cursor := crDefault;
  end;
end;

procedure TFenCengYaSuoForm.frFenCengGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='prj_name' then
  begin
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      ParValue:= g_ProjectInfo.prj_name
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      ParValue:= g_ProjectInfo.prj_name_en;
  end
  else if ParName='prj_no' then
    ParValue:= g_ProjectInfo.prj_no;

end;

procedure TFenCengYaSuoForm.Button1Click(Sender: TObject);
var
  I: Integer;
  strSQL: string;
  stra_no,sub_no,yssy_yali,yssy_kxb,yssy_ysxs,yssy_ysml: string;
  lstStratumNo,lstSubNo, lstCskxb,lstYali,lstKxb,lstYsxs,lstYsml: TStringlist;
  FileList: TStringList;
  iRecordCount:integer;
const
  TempTableName = 'TmpFenCengYaSuo';
begin
  lstYali := TStringlist.Create;
  lstKxb  := TStringlist.Create;
  lstYsxs := TStringlist.Create;
  lstYsml := TStringlist.Create;

  Screen.Cursor := crHourGlass;
  try
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      strSQL := 'SELECT id,prj_no,stra_no,sub_no,ea_name'
        +' FROM stratum_description'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' ORDER BY id'
    else
    strSQL:='SELECT sd.id,sd.prj_no,sd.stra_no,sd.sub_no,ISNULL(ea.ea_name_en,'''''''') as ea_name '
        +' FROM stratum_description sd, earthtype ea'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND sd.ea_name = ea.ea_name '
        +' ORDER BY id';
    with qryStratum do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
      end;

    strSQL := 'SELECT * FROM FenCengYaSuo WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      iRecordCount := 0;
      while not eof do
      begin
        inc(iRecordCount);
        if iRecordCount=1 then
          strSQL := 'SELECT * INTO ' + TempTableName + ' FROM (';
        stra_no   := FieldByName('stra_no').AsString;
        sub_no    := FieldByName('sub_no').AsString;
        yssy_yali := FieldByName('yssy_yali').AsString;
        yssy_kxb  := FieldByName('yssy_kxb').AsString;
        yssy_ysxs := FieldByName('yssy_ysxs').AsString;
        yssy_ysml := FieldByName('yssy_ysml').AsString;

        divideString(yssy_yali, ',',lstYali);
        divideString(yssy_kxb,  ',',lstKxb);
        divideString(yssy_ysxs, ',',lstYsxs);
        divideString(yssy_ysml, ',',lstYsml);
        for I := 0 to lstYali.Count - 1 do    // Iterate
        begin
          if (iRecordCount=1) and (I=0) then
            strSQL := strSQL+ 'SELECT ''' + stra_no+''' as stra_no,'''
               + sub_no+''' as sub_no,'
               + lstYali[I]+' as yali,'''
               + lstKxb[I]+''' as kxb,'''
               + ''+''' as ysxs,'''
               + ''+''' as ysml'
          else
            if I=0 then
              strSQL := strSQL+ ' UNION SELECT ''' + stra_no+''','''
                 + sub_no+''','
                 + lstYali[I]+','''
                 + lstKxb[I] +''','''
                 + ''+''','''
                 + ''+''''
            else
              strSQL := strSQL+ ' UNION SELECT ''' + stra_no+''','''
                 + sub_no+''','
                 + lstYali[I]+','''
                 + lstKxb[I] +''','''
                 + lstYsxs[I-1]+''','''
                 + lstYsml[I-1]+'''';
        end;
        next;
      end;    // while
    end;
    if iRecordCount>0 then
      strSQL := strSQL + ') myVoidTable'
    else
      exit;

    MainDataModule.DropTableFromDB(TempTableName);
  //  strSQL := 'SELECT * INTO ' + TempTableName
  //    + ' FROM (SELECT ''3'' as stra_no,''1'' as sub_no,1 as yali,0 as kxb,7 as ysxs,10 as ysml from cpt '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',2,100,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',3,200,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',4,300,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',5,400,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',6,500,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',7,600,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',8,700,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',9,800,8,11 '
  //    + ' UNION '
  //    + ' SELECT ''3'',''1'',10,900,8,11) VoidTable ';
    with MainDataModule.qryPublic  do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        try
          ExecSQL;
        except
        end;
        close;
      end;

    tbFenCeng.TableName := TempTableName;
    tbFenCeng.MasterFields := 'stra_no;sub_no';
    tbFenCeng.Open ;

    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      frFenCeng.LoadFromFile(g_AppInfo.PathOfReports + 'FenCengYaSuoQuXian.frf')
    else
      frFenCeng.LoadFromFile(g_AppInfo.PathOfReports + 'FenCengYaSuoQuXian_en.frf');
    frFenCeng.Preview := PreviewForm.frxPreview1;
    //开始打印报表
    if frFenCeng.PrepareReport  then
    begin
      frFenCeng.ShowPreparedReport;
      PreviewForm.ShowModal;
    end;
    qryStratum.Close;
    tbFenCeng.Close;
  finally
    lstYali.Free;
    lstKxb.Free;
    lstYsxs.Free;
    lstYsml.Free;
    screen.Cursor := crDefault;
  end;
end;

end.
