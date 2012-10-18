unit DPTCoefficient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, ExtCtrls;

type
  TDPTCoefficientForm = class(TForm)
    sg1: TStringGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btn_edit: TBitBtn;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetGridValue;
    procedure SaveGridValue;
  public
    { Public declarations }
  end;

var
  DPTCoefficientForm: TDPTCoefficientForm;

implementation

uses MainDM, public_unit, SdCadMath;

{$R *.dfm}

procedure TDPTCoefficientForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TDPTCoefficientForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDPTCoefficientForm.FormCreate(Sender: TObject);
begin

  self.Left := trunc((screen.Width - self.Width)/2);
  self.Top := trunc((screen.Height - self.Height)/2);
  sg1.RowCount := 2;
  sg1.ColCount := 10;
  sg1.Cells[0,0]:='杆长↓击数→';
  sg1.Cells[1,0]:='击数5';
  sg1.Cells[2,0]:='击数10';
  sg1.Cells[3,0]:='击数15';
  sg1.Cells[4,0]:='击数20';
  sg1.Cells[5,0]:='击数25';
  sg1.Cells[6,0]:='击数30';
  sg1.Cells[7,0]:='击数35';
  sg1.Cells[8,0]:='击数40';
  sg1.Cells[9,0]:='击数50';
  sg1.ColWidths[0]:= 80;
  sg1.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing];
  SetGridValue;
end;

procedure TDPTCoefficientForm.SaveGridValue;
var
  aRow:integer;
  strUpdateSQL:string;
begin
  for aRow:=1 to sg1.RowCount -1 do
  begin
    strUpdateSQL := 'Update dpt_coefficient SET ';
    strUpdateSQL := strUpdateSQL + 'n5='+sg1.Cells[1,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n10='+sg1.Cells[2,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n15='+sg1.Cells[3,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n20='+sg1.Cells[4,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n25='+sg1.Cells[5,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n30='+sg1.Cells[6,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n35='+sg1.Cells[7,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n40='+sg1.Cells[8,aRow]+',';
    strUpdateSQL := strUpdateSQL + 'n50='+sg1.Cells[9,aRow];
    strUpdateSQL := strUpdateSQL + ' WHERE pole_len='+sg1.Cells[sg1.colcount,aRow]; 
    Update_oneRecord(MainDataModule.qryDPTCoef,strUpdateSQL);
    
  end;
end;

procedure TDPTCoefficientForm.SetGridValue;
var
  i,iFieldCount:integer;
begin
  //qryDPTCoef
  with MainDataModule.qryDPTCoef do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM dpt_coefficient');
    open;
    iFieldCount := MainDataModule.qryDPTCoef.FieldCount;
    
    {for i := 1 to iFieldCount-1 do
    begin
      sFieldName := Fields[i].FieldName;
      System.Delete(sFieldName,1,1);
      sg1.Cells[i,0]:= '击数'+sFieldName;
    end;}
    while not eof do
    begin

      sg1.Cells[0,sg1.RowCount-1]:='杆长  '+ FieldByName('pole_len').AsString+'m';
      sg1.Cells[sg1.ColCount,sg1.RowCount-1]:= FieldByName('pole_len').AsString;
      for i := 1 to iFieldCount-1 do
        sg1.Cells[i,sg1.RowCount-1] := Fields[i].AsString;
        
      sg1.RowCount := sg1.RowCount +2;
      sg1.RowCount := sg1.RowCount -1;
      next;
    end;
    close;
    sg1.RowCount := sg1.RowCount -1;
    
  end;
end;

procedure TDPTCoefficientForm.btn_okClick(Sender: TObject);
begin
  SaveGridValue;
  sg1.Options :=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine];
end;

//getDPTXiuZhengXiShu 返回重型圆锥动力触探锤击数修正系数
//N表示实测锤击数，L表示杆长，aType表示触探类型，aType=1是重型，
// aType=2 是超重型。
function getDPTXiuZhengXiShu(N,L: double;aType:integer): double;
var
  i,iFieldCount, iField, recNum, N0, N1, L0, L1, tmpL:integer;

  isExistN: boolean;//判断系数表里是否存在传入的击数
  N_Exist: integer; //系数表里已存在的击数。
  N_Max: integer;   //系数表里已存在的最大击数。
  
  tmpXiShu_N0, tmpXiShu_N1, //保存每一条记录中的两个击数对应的系数
  XiShu_N0L0, XiShu_N0L1,
  XiShu_N1L0, XiShu_N1L1,
  tmpXiShu: double;  //保存四个系数
  
  sFieldName,  //临时保存字段名
   sTableName: string; //临时保存系数表的表名
begin
  N0:=0;
  L0:=0;
  N1:=0;
  XiShu_N0L0:=1;
  N_Exist:=0;
  N_Max:=0;
  XiShu_N1L0:=0;
  
  //qryDPTCoef
  case aType of
    1: 
      begin
        N_Max:= 50;
        sTableName := 'dpt_coefficient';
      end;
    2:
      begin
        N_Max:= 40;
        sTableName := 'dpt_supercoefficient';
      end;
  end;
  isExistN:= false;
  with MainDataModule.qryDPTCoef do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT * FROM ' + sTableName);
    open;
    iFieldCount := MainDataModule.qryDPTCoef.FieldCount;
    recNum:= 0;
    {开始找出击数N在数据库中的两边的值N0和N1，
     如果刚好有这个N则转入下面的操作找杆长L0,L1和对应的修正系数}
    if N>=N_Max then
    begin
      N_Exist:= N_Max;
      isExistN := true;
    end
    else
      for i := 1 to iFieldCount-1 do
      begin
        sFieldName := Fields[i].FieldName;
        System.Delete(sFieldName,1,1);
        iField := strtoint(sFieldName);
        if iField=N then 
        begin
          isExistN:= true;
          N_Exist:=iField;
          Break;
        end;
        if i=1 then
        begin
          N0:= iField;
          if N<iField then
          begin
            result:=1;
            close;
            exit;
          end;
        end;
        if N>iField then 
          N0:= iField
        else
        begin
          N1:= iField;
          Break;
        end;      
      end;

    //找杆长L0,L1和对应的修正系数
    while not eof do
    begin
      Inc(recNum);
      tmpL := FieldByName('pole_len').AsInteger;
      
      if isExistN then
      begin
        tmpXiShu:= FieldByName('n' + inttostr(N_Exist)).AsFloat;
        if tmpL = L then
        begin
          result:= tmpXiShu;
          close;
          exit;
        end;
        if recNum=1 then
        begin
          L0:= tmpL;
          XiShu_N0L0:= tmpXiShu;
          if L<tmpL then
          begin
            result:= tmpXiShu;
            close;
            exit;
          end;
        end;
        if tmpL<L then
          begin
            L0:= tmpL;
            XiShu_N0L0:= tmpXiShu;
          end
        else
          begin
            L1:= tmpL;
            XiShu_N0L1:= tmpXiShu;
            result:= XianXingChaZhi(L0,XiShu_N0L0,L1,XiShu_N0L1,L);
            close;
            exit;
          end;
      end //end of if isExistN then

      else
      begin
        tmpXiShu_N0 := FieldByName('n'+inttostr(N0)).AsFloat;
        tmpXiShu_N1 := FieldByName('n'+inttostr(N1)).AsFloat;
        tmpL := FieldByName('pole_len').AsInteger;
        if L=tmpL then
        begin
          result:= XianXingChaZhi(N0,tmpXiShu_N0,N1,tmpXiShu_N1,N);
          close;
          exit;
        end;
        if recNum=1 then
        begin
          if L<tmpL then
          begin
            result:= tmpXiShu_N0;
            close;
            exit;
          end;
          XiShu_N0L0 := tmpXiShu_N0;
          XiShu_N1L0 := tmpXiShu_N1;
          L0 := tmpL;
        end
        else //else recNum>1
        begin
          if L<tmpL then
          begin
            XiShu_N0L1:= tmpXiShu_N0;
            XiShu_N1L1 := tmpXiShu_N1;
            L1 := tmpL;
            result:= ShuangXianXingChaZhi(N0, L0, N1, L1, 
              XiShu_N0L0,XiShu_N0L1,XiShu_N1L0,XiShu_N1L1,N,L);
            close;
            exit;            
          end
          else
          begin
            XiShu_N0L0 := tmpXiShu_N0;
            XiShu_N1L0 := tmpXiShu_N1;
            L0 := tmpL;
          end;
        end;  
      end;
      next;
    end;
    result:=1;
    close;
  end;

end;

procedure TDPTCoefficientForm.btn_editClick(Sender: TObject);
begin
sg1.Options :=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing];
end;

end.
