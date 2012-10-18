unit CrossBoardPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Math;

type
  TCrossBoardPrintForm = class(TForm)
    lblDrl_no: TLabel;
    btn_Print: TBitBtn;
    btn_cancel: TBitBtn;
    cboDrl_no: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    //取得重塑土Cu'的最大值，参数strCuAll是保存在数据库中的Cu字段内容
    function getMaxCu2(const strCuAll: string) : string;
    //取得原状土Cu的最大值，参数strCuAll是保存在数据库中的Cu字段内容
    function getMaxCu(const strCuAll: string) : string;
    procedure GetDrillsNo;
  public
    { Public declarations }
  end;

var
  CrossBoardPrintForm: TCrossBoardPrintForm;

implementation

uses MainDM, public_unit;

{$R *.dfm}

{ TCrossBoardPrintForm }

procedure TCrossBoardPrintForm.GetDrillsNo;
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



procedure TCrossBoardPrintForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  GetDrillsNo;
end;

procedure TCrossBoardPrintForm.btn_PrintClick(Sender: TObject);
//yys edit 2010, 工勘院的CAD部门从其他部门得到的原始数据发生变化，数据不再除10,所以这里也不再*10
//const DiZengJiaoDu=10;
const DiZengJiaoDu=1;
var
  strFileName,strCuAll,strCuAll1,strMaxCu,strMaxCu2,strJiaoDuAll1,strCuAll2,strJiaoDuAll2: string;
  strExecute,strStratum,strSQL: string;
  FileList, tmpList,CuList: TStringList;
  i, j,intCount1,intCount2: integer;
begin
  if g_ProjectInfo.prj_no ='' then exit;
  if cboDrl_no.Text ='' then exit;

  FileList := TStringList.Create;
  tmpList := TStringList.Create;
  CuList := TStringList.Create;
  strFileName:= g_AppInfo.PathOfChartFile + 'crossboard.ini';
  try
    FileList.Add('[图纸信息]');
    FileList.Add('保存用文件名=十字板剪切试验曲线图' + trim(cboDrl_no.Text));
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('图纸名称=十字板剪切试验曲线图')
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('图纸名称=Vane shear test graph');
    FileList.Add('工程编号='+g_ProjectInfo.prj_no);
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name)
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name_en) ;
    with MainDataModule.qryCrossBoard do
    begin
      close;
      sql.Clear;

      sql.Add('SELECT prj_no,drl_no,cb_depth,Cu,Cu_max FROM CrossBoard');
      sql.Add(' WHERE prj_no='
        +''''+ g_ProjectInfo.prj_no_ForSQL+
        '''' + ' AND drl_no = '+''''+cboDrl_no.Text +'''');
      open;
      i:= 0;
      while not eof do
      begin
        Inc(i);

        tmpList.Add('[钻孔'+ inttostr(i)+']');
        tmpList.Add('编号='+FieldByName('drl_no').AsString);
        tmpList.Add('测试深度='
          +FormatFloat('0.00',FieldByName('cb_depth').AsFloat)+'(m)');
        strSQL:='SELECT st.*,ISNULL(ea.ea_name_en,'''''''') as ea_name_en  '
                 +'FROM stratum st,earthtype ea'
                 +' WHERE st.prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
                 +' AND st.drl_no='  +''''+stringReplace(cboDrl_no.Text,'''','''''',[rfReplaceAll])+''''
                 +' AND st.stra_depth>= ' + FieldByName('cb_depth').AsString
                 +' AND st.ea_name = ea.ea_name '
                 +' ORDER BY st.stra_depth ';
        with MainDataModule.qryStratum do
          begin
            close;
            sql.Clear;
            sql.Add(strSQL);
            open;
            if not Eof then
              begin
                if FieldByName('sub_no').AsString='0' then
                  strStratum := FieldByName('stra_no').AsString
                else
                  strStratum := FieldByName('stra_no').AsString+'---'+FieldByName('sub_no').AsString;
                if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
                  strStratum := strStratum + FieldByName('ea_name').AsString
                else
                  strStratum := strStratum + FieldByName('ea_name_en').AsString;
                tmpList.Add('土层编号及名称='+strStratum);
              end;
            close;
          end;
//yys 2006/08/29 修改
        //tmpList.Add('Cu='+FormatFloat('0.0',FieldByName('cu_max').AsFloat));
        //tmpList.Add('Cu='+FormatFloat('0.00',FieldByName('cu_max').AsFloat * 10)+'（kPa）');
//end 结束修改
        tmpList.Add('LineCount=2');
        strCuAll := FieldByName('cu').AsString;
        strMaxCu := getMaxCu(strCuAll);
//yys 2008/10/20 修改 原因：工勘院数据已经做过预处理，CU和CU'程序里不用再*10
        //tmpList.Add('Cu='+FormatFloat('0.00',strToFloat(strMaxCu) * 10)+'（kPa）');
          tmpList.Add('Cu='+FormatFloat('0.00',strToFloat(strMaxCu))+'（kPa）');
        strMaxCu2 := getMaxCu2(strCuAll);
        if strMaxCu2='' then
          tmpList.Add('Cu''=')
        else
        begin
          //tmpList.Add('Cu''='+FormatFloat('0.00', strToFloat(strMaxCu2)* 10)+'（kPa）');
            tmpList.Add('Cu''='+FormatFloat('0.00', strToFloat(strMaxCu2))+'（kPa）');
//end 结束修改
          tmpList.Add('st='+FormatFloat('0.00', strToFloat(strMaxCu)/strToFloat(strMaxCu2)));
        end;
        DivideString(strCuAll,',',CuList);

        strJiaoDuAll1:= '';
        strJiaoDuAll2:= '';
        strCuAll1:='';
        strCuAll2:='';
        intCount1:=0;
        intCount2:=0;
        for j:=1 to CuList.Count do
          if (j mod 2)=1 then
          begin
            if  trim(CuList.Strings[j-1])<>'' then
            begin
              intCount1:=intCount1+1;
              strJiaoDuAll1:= strJiaoDuAll1 + inttostr(intCount1)+',';
              strCuAll1:=strCuAll1+FloattoStr(StrtoFloat(CuList.Strings[j-1])*DiZengJiaoDu)+','
            end
          end
          else
          begin
            if  trim(CuList.Strings[j-1])<>'' then
            begin
              intCount2:=intCount2+1;
              strJiaoDuAll2:= strJiaoDuAll2 + inttostr(intCount2)+',';
              strCuAll2:=strCuAll2+FloattoStr(StrtoFloat(CuList.Strings[j-1])*DiZengJiaoDu)+',';
            end;
          end;
        if copy(strJiaoDuAll1,length(strJiaoDuAll1),1)=',' then
          strJiaoDuAll1:= copy(strJiaoDuAll1,1,length(strJiaoDuAll1)-1);
        if copy(strJiaoDuAll2,length(strJiaoDuAll2),1)=',' then
          strJiaoDuAll2:= copy(strJiaoDuAll2,1,length(strJiaoDuAll2)-1);
        if copy(strCuAll1,length(strCuAll1),1)=',' then
          strCuAll1:= copy(strCuAll1,1,length(strCuAll1)-1);
        if copy(strCuAll2,length(strCuAll2),1)=',' then
          strCuAll2:= copy(strCuAll2,1,length(strCuAll2)-1);

        tmpList.Add('所有角度1='+strJiaoDuAll1);
        tmpList.Add('所有强度1='+strCuAll1);
        tmpList.Add('所有角度2='+strJiaoDuAll2);
        tmpList.Add('所有强度2='+strCuAll2);
        next;
      end;
      close;
    end;
    FileList.Add('[钻孔]');
    FileList.Add('个数='+ inttostr(i));
    if i>0 then
      for i:=0 to tmpList.Count-1 do
        FileList.Add(tmpList.Strings[i]); 

    FileList.SaveToFile(strFileName);
  finally
    FileList.Free;
    tmpList.Free;
  end;


  winexec(pAnsichar(getCadExcuteName+' '+PrintChart_CrossBoard+','+strFileName ),sw_normal);


end;

procedure TCrossBoardPrintForm.btn_cancelClick(Sender: TObject);
begin
  close;
end;

procedure TCrossBoardPrintForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

function TCrossBoardPrintForm.getMaxCu2(const strCuAll: string): string;
var
  i,j, iCount: integer;
  CuList: TStringList;
  dMaxCu2: Double;
begin
  if trim(strCuAll)='' then
  begin
    result:='';
    exit;
  end;

  CuList := TStringList.Create;
  DivideString(strCuAll,',',CuList);
  if CuList.Count>0 then
  begin
    for i:= 0 to CuList.Count -1 do
      begin
        if i=1 then
        begin
          if CuList.Strings[i]='' then
          begin
            result := '';
            cuList.Free;
            exit;
          end;
            
          dMaxCu2:= Strtofloat(CuList.Strings[i]);
          continue;
        end;
        if (i mod 2)=1 then
        begin
          if CuList.Strings[i]='' then
          begin
            result := Floattostr(dMaxCu2);
            cuList.Free;
            exit;
          end;
          dMaxCu2:= max(Strtofloat(CuList.Strings[i]),dMaxCu2);
        end;
      end;
    result := Floattostr(dMaxCu2);
  end;
  cuList.Free;


end;

function TCrossBoardPrintForm.getMaxCu(const strCuAll: string): string;
var
  i,j, iCount: integer;
  CuList: TStringList;
  dMaxCu: Double;
begin
  if trim(strCuAll)='' then
  begin
    result:='';
    exit;
  end;

  CuList := TStringList.Create;
  DivideString(strCuAll,',',CuList);
  if CuList.Count>0 then
  begin
    for i:= 0 to CuList.Count -1 do
      begin
        if i=0 then
        begin
          if CuList.Strings[i]='' then
          begin
            result := '';
            cuList.Free;
            exit;
          end;
            
          dMaxCu:= Strtofloat(CuList.Strings[i]);
          continue;
        end;
        if (i mod 2)=0 then
        begin
          if CuList.Strings[i]='' then
          begin
            result := Floattostr(dMaxCu);
            cuList.Free;
            exit;
          end;
          dMaxCu:= max(Strtofloat(CuList.Strings[i]),dMaxCu);
        end;
      end;
    result := Floattostr(dMaxCu);
  end;
  cuList.Free;


end;

end.
