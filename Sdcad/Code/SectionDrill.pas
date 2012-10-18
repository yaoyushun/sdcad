unit SectionDrill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, Buttons;

type
  TSectionDrillForm = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    sgSection: TStringGrid;
    Panel2: TPanel;
    lblAllDrills: TLabel;
    Label1: TLabel;
    sgDrills: TStringGrid;
    sgSectionDrills: TStringGrid;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnDeleteAll: TButton;
    btn_cancel: TBitBtn;
    btnShouGong: TButton;
    btnInsert: TButton;
    procedure FormCreate(Sender: TObject);
    procedure sgSectionSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnDeleteAllClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure sgSectionDrillsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgSectionDrillsExit(Sender: TObject);
    procedure btnShouGongClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetDrillsBySectionNo(aSectionNo: String);
    procedure GetSectionByProjectNo(aProjectNo: String);
    procedure GetAllDrillsByProjectNo(aProjectNo: String);
    procedure UpdateKjj; //更新钻孔间距.
    function GetInsertSQL: string;
    function GetUpdateSQL: string;
    function GetDeleteSQL: string;
    function GetAfterDeleteUpdateSQL(aId:string): String;
    function GetBeforeInsertUpdateSQL(aID:string): string;
    function GetDeleteAllSQL: string;
    function GetSectionScale(aSectionNo: String; aHeight: double; aWidth: double):TPoint;
  public
    { Public declarations }
  end;

var
  SectionDrillForm: TSectionDrillForm;
  m_sgSectionSelectedRow: integer;
implementation

uses MainDM, public_unit;

{$R *.dfm}


procedure TSectionDrillForm.FormCreate(Sender: TObject);
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);  


  sgSection.RowCount :=2;
  sgSection.ColCount :=2;
  sgSection.Cells[1,0]:= '剖面编号';
  sgSection.RowHeights[0]:= 16;
  sgSection.ColWidths[0]:=10;
  sgSection.ColWidths[1]:=60;

  sgDrills.RowCount :=2;
  sgDrills.ColCount := 2;
  sgDrills.RowHeights[0] := 16;
  sgDrills.Cells[1,0] := '孔号';  
  //sgDrills.Cells[2,0] := '孔口标高(m)';
  //sgDrills.Cells[3,0] := '孔深(m)';  
  sgDrills.ColWidths[0]:=10;
  sgDrills.ColWidths[1]:=130;
  //sgDrills.ColWidths[2]:=100;
  //sgDrills.ColWidths[2]:=100;

  sgSectionDrills.RowCount := 2;
  sgSectionDrills.ColCount := 3;
  sgSectionDrills.Cells[0,0] := '序号';  
  sgSectionDrills.Cells[1,0] := '钻孔编号';
  sgSectionDrills.Cells[2,0] := '下孔间距(m)';
  sgSectionDrills.RowHeights[0] :=16;
  sgSectionDrills.ColWidths[0] :=30;
  sgSectionDrills.ColWidths[1] :=120;
  sgSectionDrills.ColWidths[2] :=80;
  
  m_sgSectionSelectedRow:= -1;
  GetSectionByProjectNo(g_ProjectInfo.prj_no);
  GetAllDrillsByProjectNo(g_ProjectInfo.prj_no);
  sgSection.Row := 1;
  if sgSection.Cells[1,1]<>'' then
  begin
    GetDrillsBySectionNo(sgSection.Cells[1,1]);
    m_sgSectionSelectedRow:=1;
  end;
end;

procedure TSectionDrillForm.GetDrillsBySectionNo(aSectionNo: String);
var 
  i: integer;
begin
  sgSectionDrills.RowCount :=2;
  DeleteStringGridRow(sgSectionDrills,1);
  if aSectionNo = '' then exit;
  with MainDataModule.qrySectionDrill do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT prj_no,sec_no,id,drl_no,kjj FROM section_drill WHERE ');
    sql.Add(' prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
    sql.Add(' AND sec_no='+''''+stringReplace(aSectionNo,'''','''''',[rfReplaceAll])+'''');
    sql.Add(' ORDER BY id');
    Open;
    i:=0;
    while not eof do
    begin
      i:=i+1;
      sgSectionDrills.RowCount := i +2;
      sgSectionDrills.RowCount := i +1;
      sgSectionDrills.Cells[0,i] := inttostr(i);
      sgSectionDrills.Cells[1,i] := FieldByName('drl_no').AsString;
      sgSectionDrills.Cells[2,i] := FieldByName('kjj').AsString;
      sgSectionDrills.Cells[3,i] := FieldByName('kjj').AsString;
      Next ;
    end;
    close;       
  end;
end;

procedure TSectionDrillForm.GetSectionByProjectNo(aProjectNo:String);
var 
  i: integer;
begin
  with MainDataModule.qrySection do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT prj_no,sec_no FROM section WHERE ');
    sql.Add('prj_no='+''''+stringReplace(aProjectNo,'''','''''',[rfReplaceAll])+'''');
    Open;
    i:=0;
    sgSection.Tag :=1;   //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中当Tag=1时不执行在SelectCell事件中的操作.   
    while not eof do
    begin
      i:=i+1;
      sgSection.RowCount := i +2;
      sgSection.RowCount := i +1;
      sgSection.Cells[1,i] := FieldByName('sec_no').AsString;  
      Next ;
    end;
    sgSection.Tag :=0;
    close;       
  end;
end;

procedure TSectionDrillForm.sgSectionSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if TStringGrid(Sender).Tag = 1 then exit; //设置Tag是因为每次给StringGrid赋值都会触发它的SelectCell事件，为了避免这种情况，
                         //在SelectCell事件中用Tag值来判断是否应该执行在SelectCell中的操作.   

  if (ARow <>0) and (ARow<>m_sgSectionSelectedRow) then
  begin
    GetDrillsBySectionNo(sgSection.Cells[1,ARow]);
  end;
  m_sgSectionSelectedRow:=ARow;  
end;

procedure TSectionDrillForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSectionDrillForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UpdateKjj;
  Action:= caFree;
end;

procedure TSectionDrillForm.GetAllDrillsByProjectNo(aProjectNo: String);
var
  i: integer;
begin
  with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT prj_no,drl_no,drl_elev,comp_depth');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''+stringReplace(aProjectNo,'''','''''',[rfReplaceAll])+'''');
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          sgDrills.RowCount := i +2;
          sgDrills.RowCount := i +1;
          sgDrills.Cells[1,i] := FieldByName('drl_no').AsString;  
          sgDrills.Cells[2,i] := FieldByName('drl_elev').AsString;
          sgDrills.Cells[3,i] := FieldByName('comp_depth').AsString;
          Next ;
        end;
      close;
    end;
end;

procedure TSectionDrillForm.btnAddClick(Sender: TObject);
var
  strSQL: String;
begin
  if sgDrills.Cells[1,sgDrills.row]='' then exit;
  if sgSection.Cells[1,sgSection.row]='' then exit;
  if sgSectionDrills.Cells[1,1]='' then
    begin
      sgSectionDrills.Cells[0,1]:='1';
      sgSectionDrills.Cells[1,1]:=sgDrills.Cells[1,sgDrills.row];
    end
  else
    begin
      sgSectionDrills.RowCount := sgSectionDrills.RowCount +2;
      sgSectionDrills.RowCount := sgSectionDrills.RowCount -1;
      sgSectionDrills.Cells[0,sgSectionDrills.RowCount-1]:=intToStr(sgSectionDrills.RowCount-1);
      sgSectionDrills.Cells[1,sgSectionDrills.RowCount-1]:=sgDrills.Cells[1,sgDrills.row];
    end;
  strSQL:=getInsertSQL;
  if not Insert_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
  begin
     if sgSectionDrills.RowCount=2 then
       DeleteStringGridRow(sgSectionDrills,1)
     else
       sgSectionDrills.RowCount := sgSectionDrills.RowCount -1;
  end;
end;

function TSectionDrillForm.GetDeleteSQL: string;
begin
  result :='DELETE FROM section_drill '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''
           +' AND id=' +''''+sgSectionDrills.Cells[0,sgSectionDrills.Row]+'''';  
end;

function TSectionDrillForm.GetInsertSQL: string;
begin
  result := 'INSERT INTO section_drill (prj_no,sec_no,id,drl_no) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''+','
            +''''+stringReplace(trim(sgSectionDrills.Cells[0,sgSectionDrills.RowCount-1]),'''','''''',[rfReplaceAll])+''''+','
            +''''+stringReplace(trim(sgSectionDrills.Cells[1,sgSectionDrills.RowCount-1]),'''','''''',[rfReplaceAll])+''''+')';
end;

function TSectionDrillForm.GetUpdateSQL: string;
var
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
               +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''
               +' AND id=' +''''+sgSectionDrills.Cells[0,sgSectionDrills.Row]+'''';

  strSQLSet:='UPDATE section_drill SET '; 
  strSQLSet := strSQLSet + 'drl_no'  +'='+''''+stringReplace(sgDrills.Cells[1,sgDrills.row],'''','''''',[rfReplaceAll])+''''; 
  result := strSQLSet + strSQLWhere;
end;

procedure TSectionDrillForm.btnDeleteClick(Sender: TObject);
var
  strSQL,strID: string;
  i: integer;
  
begin
  //if MessageBox(self.Handle,
  //  '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  strID :='';
  strID := sgSectionDrills.Cells[0,sgSectionDrills.Row];
  if  strID <> '' then
    begin
      strSQL := self.GetDeleteSQL;
      if Delete_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
        begin
          if (sgSectionDrills.Row <> sgSectionDrills.RowCount-1) then
          begin
            strSQL:=self.GetAfterDeleteUpdateSQL(strID);
            DeleteStringGridRow(sgSectionDrills,sgSectionDrills.Row);
            if update_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
              for i:=1 to sgSectionDrills.RowCount-1 do
                sgSectionDrills.Cells[0,i]:= IntToStr(i); 
          end
          else 
          DeleteStringGridRow(sgSectionDrills,sgSectionDrills.Row);
        end;
    end; 
end;

function TSectionDrillForm.GetDeleteAllSQL: string;
begin
  result :='DELETE FROM section_drill '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+'''';
end;

procedure TSectionDrillForm.btnDeleteAllClick(Sender: TObject);
var
  strSQL,strID: string;
begin
  //if MessageBox(self.Handle,
  //  '您确定要删除吗？','警告', MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
  strID :='';
  strID := sgSectionDrills.Cells[0,sgSectionDrills.Row];
  if  strID <> '' then
    begin
      strSQL := self.GetDeleteAllSQL;
      if Delete_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
        begin
          sgSectionDrills.RowCount := 2;
          DeleteStringGridRow(sgSectionDrills,1);
        end;
    end;

end;

procedure TSectionDrillForm.btnEditClick(Sender: TObject);
var 
  strSQL: string;
begin
  if sgSectionDrills.Cells[1,sgSectionDrills.Row]='' then exit;
  strSQL:='';
  if sgDrills.Cells[1,sgDrills.row]='' then exit;
  if sgSection.Cells[1,sgSection.row]='' then exit;
  strSQL:= GetUpdateSQL;
  if Update_oneRecord(MainDataModule.qryStratum,strSQL) then
    sgSectionDrills.Cells[1,sgSectionDrills.Row]:=sgDrills.Cells[1,sgDrills.Row];
  
end;

procedure TSectionDrillForm.sgSectionDrillsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
 if aRow<>0 then
  if ACol=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else if ACol=1 then
    AlignGridCell(Sender,ACol,ARow,Rect,taLeftJustify)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);   
end;

function TSectionDrillForm.GetAfterDeleteUpdateSQL(aId: string): String;
var
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
               +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''
               +' AND id>' +aId;

  strSQLSet:='UPDATE section_drill SET ';
  strSQLSet := strSQLSet + 'id=id-1';
  result := strSQLSet + strSQLWhere;
end;

//GetSectionScale 取得一个剖面图的横纵比例
//  aSectionNo :剖面编号
//  aHeight    :任意剖面的钻孔在打印纸上实际占的范围的高度(单位是mm)
//  aWidth     :任意剖面的钻孔在打印纸上实际占的范围的宽度(单位是mm)
//返回值TPoint : TPoint.X 横比例 TPoint.Y 纵比例
function TSectionDrillForm.GetSectionScale(aSectionNo: String; aHeight: double; aWidth: double): TPoint;
const
  M2MM = 1000; // 1m=1000mm
var
  ScalePoint: TPoint;
  i: integer;
  bZuoBiao: boolean; //用这个来判断是否用孔的坐标来计算孔间距
  totalZuoBiaoWidth, //用钻孔坐标来计算得到的剖面的宽度
  totalKjjWidth,     //用钻孔间距来计算得到的剖面的宽度
  totalHeight,       //剖面的高度
  tempKjj,           //临时变量，记录当前钻孔到下一钻孔的距离
  maxTopElev,MinBottElev,//最大钻孔标高，最小钻孔底标高
  preX,preY,         //前一记录钻孔的坐标
  nowX,nowY: double; //当前记录钻孔的坐标
begin
  ScalePoint.X := 0;
  ScalePoint.Y := 0;
  if (aHeight<=0) or (aWidth<=0) then
  begin
    result:= ScalePoint;
    exit;
  end;
  totalZuoBiaoWidth:=0;
  totalKjjWidth:=0;
  tempKjj:= 0;
  totalHeight:=0;
  maxTopElev:=0;
  MinBottElev:=0;
  preX:=0;
  preY:=0;
  nowX:=0;
  nowY:=0;
  i:=0;
  bZuoBiao:= true;
  with MainDataModule.qrySectionDrill do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT s.prj_no,s.sec_no,s.id,s.drl_no,s.kjj,d.drl_elev,'
            +'d.drl_elev-d.comp_depth  drl_bott,d.drl_x,d.drl_y'
            +' FROM section_drill s,drills d WHERE ');
    sql.Add(' s.prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
    sql.Add(' AND s.sec_no='+''''+stringReplace(aSectionNo,'''','''''',[rfReplaceAll])+''''); 
    sql.Add(' AND s.prj_no = d.prj_no');
    sql.Add(' ORDER BY s.id');
    Open;
    while not eof do
    begin
      tempKjj:= FieldByName('kjj').AsFloat;
      totalKjjWidth := totalKjjWidth + tempKjj;
      Inc(i);
      if i=1 then
      begin
        preX:= FieldByName('drl_x').AsFloat;
        preY:= FieldByName('drl_y').AsFloat;
        maxTopElev:= FieldByName('drl_elev').AsFloat;
        MinBottElev:=FieldByName('drl_bott').AsFloat;
      end;
      if i>1 then
      begin      
        if maxTopElev < FieldByName('drl_elev').AsFloat then
          maxTopElev:= FieldByName('drl_elev').AsFloat; 
        if MinBottElev>FieldByName('drl_bott').AsFloat then
          MinBottElev:=FieldByName('drl_bott').AsFloat;
        if (FieldByName('drl_x').AsString ='') 
          or (FieldByName('drl_y').AsString ='') then
          bZuoBiao:= false;

        if bZuoBiao then
        begin
          nowX:= FieldByName('drl_x').AsFloat;
          nowY:= FieldByName('drl_y').AsFloat;
          totalZuoBiaoWidth:= totalZuoBiaoWidth + sqrt(sqr(nowX-preX)+sqr(nowY-preY));
        end;
      end;
      Next;
    end;
    close; 
  end;
  totalKjjWidth := totalKjjWidth - tempKjj; //减去剖面中最后一个钻孔的孔间距离,在上面的循环中多加了。
  if bZuoBiao then
    scalePoint.X := round(totalZuoBiaoWidth * M2MM / aWidth)
  else
    scalePoint.X := round(totalKjjWidth * M2MM / aWidth);
  if scalePoint.X <=100 then 
    scalePoint.X :=100
  else if scalePoint.X<=1000 then
    begin
      if (scalePoint.X mod 100)<>0 then
        scalePoint.X:= (scalePoint.X div 100) * 100 +100;
    end
  else if scalePoint.X<=10000 then
    begin
      if (scalePoint.X mod 500)<>0 then
        scalePoint.X:= (scalePoint.X div 500) * 500 +500;
    end
  else
    if (scalePoint.X mod 5000)<>0 then
      scalePoint.X:= (scalePoint.X div 5000) * 5000 +5000;
    
  scalePoint.Y := round((maxTopElev - minBottElev) * M2MM / aHeight);
  if scalePoint.Y <=100 then 
    scalePoint.Y :=100
  else if scalePoint.Y<=1000 then
    begin
      if (scalePoint.Y mod 100)<>0 then
        scalePoint.Y:= (scalePoint.Y div 100) * 100 +100;
    end
  else if scalePoint.Y<=10000 then
    begin
      if (scalePoint.Y mod 500)<>0 then
        scalePoint.Y:= (scalePoint.Y div 500) * 500 +500;
    end
  else
    if (scalePoint.Y mod 5000)<>0 then
      scalePoint.Y:= (scalePoint.Y div 5000) * 5000 +5000;
  result := scalePoint;
end;

procedure TSectionDrillForm.sgSectionDrillsExit(Sender: TObject);
begin
  UpdateKjj;
end;

procedure TSectionDrillForm.UpdateKjj;
var 
  strSQL,strAllSQL: string;
  i: integer;
begin
  strAllSQL := '';
  for i:=1 to sgSectionDrills.RowCount -1 do
  begin
    if (sgSectionDrills.Cells[1,i]<>'') 
      and (sgSectionDrills.Cells[2,i]<>sgSectionDrills.Cells[3,i]) then
    begin
      strSQL:=' UPDATE section_drill SET kjj=';
      if trim(sgSectionDrills.Cells[2,i])<>'' then
        strSQL:= strSQL +''''+sgSectionDrills.Cells[2,i]+''''
      else
        strSQL:= strSQL + 'NULL';
      strSQL:= strSQL
        +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
        +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''
        +' AND id=' +''''+sgSectionDrills.Cells[0,i]+'''';
      strAllsql:= strallsql + strsql;
      //if Update_oneRecord(MainDataModule.qryStratum,strSQL) then
      sgSectionDrills.Cells[3,i]:= sgSectionDrills.Cells[2,i];
    end;
  end;
  if strAllSQL<>'' then
    Update_oneRecord(MainDataModule.qryStratum,strAllsql);
end;

procedure TSectionDrillForm.btnShouGongClick(Sender: TObject);
var
  NewString, DrillNO, strSQL: string;
  ClickedOK: Boolean;
  DrillNoList: TStringList;
  i,iRowID: Integer;
begin
  NewString := '';
  ClickedOK := InputQuery('输入框', '钻孔编号，格式为 C1 C2 C3 ', NewString);
  if ClickedOK and (trim(NewString)<>'') then            { NewString contains new input string }
  begin
    try
      DrillNoList := TStringList.Create;
      DivideString(trim(NewString),' ',DrillNoList);
      if DrillNoList.Count >0 then
      begin
          for I := 0 to DrillNoList.Count - 1 do    // Iterate
          begin
              DrillNo := DrillNoList.Strings[i];
              if sgSectionDrills.Cells[1,1]='' then
                begin
                  sgSectionDrills.Cells[0,1]:='1';
                  sgSectionDrills.Cells[1,1]:=sgDrills.Cells[1,sgDrills.row];
                end
              else
                begin
                  sgSectionDrills.RowCount := sgSectionDrills.RowCount +2;
                  sgSectionDrills.RowCount := sgSectionDrills.RowCount -1;
                  sgSectionDrills.Cells[0,sgSectionDrills.RowCount-1]:=intToStr(sgSectionDrills.RowCount-1);
                  sgSectionDrills.Cells[1,sgSectionDrills.RowCount-1]:=DrillNo;
                end;

              strSQL := 'INSERT INTO section_drill (prj_no,sec_no,id,drl_no) VALUES('
                +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
                +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''+','
                +''''+intToStr(sgSectionDrills.RowCount-1)+''''+','
                +''''+stringReplace(DrillNo,'''','''''',[rfReplaceAll])+''''+')';

              if not Insert_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
                  sgSectionDrills.RowCount := sgSectionDrills.RowCount -1;
          end;    // for
          //GetDrillsBySectionNo(sgSection.Cells[1,m_sgSectionSelectedRow]);
      end;
    finally
      DrillNoList.Free;
    end;
  end;

end;

function TSectionDrillForm.GetBeforeInsertUpdateSQL(aID: string): string;
var
  strSQLWhere,strSQLSet:string;
begin
  strSQLWhere:=' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
               +' AND sec_no='  +''''+stringReplace(trim(sgSection.Cells[1,sgSection.row]),'''','''''',[rfReplaceAll])+''''
               +' AND id>' +aId;

  strSQLSet:='UPDATE section_drill SET ';
  strSQLSet := strSQLSet + 'id=id+1';
  result := strSQLSet + strSQLWhere;

end;

procedure TSectionDrillForm.btnInsertClick(Sender: TObject);
var
  strSQL,drl_no,sec_No: String;
  iRow,iRowCount  : integer;
begin
  if sgDrills.Cells[1,sgDrills.row]='' then exit;
  if sgSection.Cells[1,sgSection.row]='' then exit;
  iRow := sgSectionDrills.Row ;
  sec_No := trim(sgSection.Cells[1,sgSection.row]);
  drl_no := trim(sgDrills.Cells[1,sgDrills.row]);
  if sgSectionDrills.Cells[1,1]='' then
    begin

      strSQL := 'INSERT INTO section_drill (prj_no,sec_no,id,drl_no) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(sec_No,'''','''''',[rfReplaceAll])+''''+','
            +''''+inttostr(1)+''''+','
            +''''+stringReplace(drl_no,'''','''''',[rfReplaceAll])+''''+')';
      if Insert_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
      begin
        sgSectionDrills.Cells[0,1]:='1';
        sgSectionDrills.Cells[1,1]:=drl_no;
      end;
    end
  else
    begin
      strSQL := 'UPDATE section_drill SET id=id+1 WHERE '
            +' prj_no='+''''+g_ProjectInfo.prj_no_ForSQL +''''
            +' AND sec_no= '+''''+stringReplace(sec_No,'''','''''',[rfReplaceAll])+''''
            +' AND id>='+IntToStr(iRow);
      if Update_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
      begin
        strSQL := 'INSERT INTO section_drill (prj_no,sec_no,id,drl_no) VALUES('
            +''''+g_ProjectInfo.prj_no_ForSQL +''''+','
            +''''+stringReplace(sec_No,'''','''''',[rfReplaceAll])+''''+','
            +''''+inttostr(iRow)+''''+','
            +''''+stringReplace(drl_no,'''','''''',[rfReplaceAll])+''''+')';
        if Insert_oneRecord(MainDataModule.qrySectionDrill,strSQL) then
        begin
          sgSectionDrills.RowCount := sgSectionDrills.RowCount+1;
          for iRowCount := sgSectionDrills.RowCount -1 downto irow+1 do
          begin
            sgSectionDrills.Cells[0,iRowCount]:=InttoStr(iRowCount);
            sgSectionDrills.Cells[1,iRowCount]:=sgSectionDrills.Cells[1,iRowCount-1];
            sgSectionDrills.Cells[2,iRowCount]:=sgSectionDrills.Cells[2,iRowCount-1];
          end;
          
          sgSectionDrills.Cells[1,iRow]:=drl_no;
          sgSectionDrills.Cells[2,iRow]:='';
        end;
      end;
    end;

end;

end.
