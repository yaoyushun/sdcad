unit Legend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, StrUtils;

type
  
  TLegendForm = class(TForm)
    btn_Print: TBitBtn;
    btn_cancel: TBitBtn;

    procedure FormCreate(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  LegendForm: TLegendForm;

implementation

uses MainDM, public_unit;

{$R *.dfm}


procedure TLegendForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;


procedure TLegendForm.btn_PrintClick(Sender: TObject);
var
  strFileName, strL_names, strSQL, stra_no,sub_no,drl_no,drl_elev: string;
  SptRealNum : string; //标准贯入的实测击数
  FileList: TStringList;

begin
  if g_ProjectInfo.prj_no ='' then exit;
  FileList := TStringList.Create;
  strFileName:= g_AppInfo.PathOfChartFile + 'legend.ini';
  try

    FileList.Add('[图纸信息]');
    FileList.Add('保存用文件名=图例图');

    FileList.Add('[图例]');

    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('图纸名称='+g_ProjectInfo.prj_name+'图例图')
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('图纸名称='+g_ProjectInfo.prj_name_en+' Legend');

    FileList.Add('工程编号='+g_ProjectInfo.prj_no);
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name)
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      FileList.Add('工程名称='+g_ProjectInfo.prj_name_en) ;

    //开始加入剖面图图例
    strL_names:='';
      //取得当前工程的土的图例
    strSQL:='select et.ea_name,ISNULL(et.ea_name_en,'''') as ea_name_en'
      +' from earthtype et'
      +' inner join (select DISTINCT ea_name from stratum_description'
      +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''') as sd'
      +' on sd.ea_name=et.ea_name';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      while not eof do
        begin
          strL_names:= strL_names + FieldByName('ea_name').AsString;
          if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
            strL_names:= strL_names
              + REPORT_PRINT_SPLIT_CHAR
              + FieldByName('ea_name_en').AsString;
          strL_names:= strL_names + ',';
          next;
        end;
      close;
    end;
    if copy(ReverseString(strL_names),1,1)=',' then
      delete(strL_names,length(strL_names),1);
    FileList.Add('剖面图图例='+ strL_names);

    strL_names := '';
    strL_names:= strL_names + '静探曲线';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'The Curve of CPT';
    strL_names:= strL_names + ',';

    strL_names:= strL_names + '标准贯入';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'Position of samples and SPT blows';
    strL_names:= strL_names + ',';

    strL_names:= strL_names + '土层编号';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'Strata No.';
    strL_names:= strL_names + ',';

    strL_names:= strL_names + '水位线';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'Groud_water level';
    strL_names:= strL_names + ',';

    strL_names:= strL_names + '孔号标高';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'Boring No. and elevation';
    strL_names:= strL_names + ',';

    strL_names:= strL_names + '地层界线推测地层界线';
    if g_ProjectInfo.prj_ReportLanguage =trEnglishReport then
      strL_names:= strL_names + REPORT_PRINT_SPLIT_CHAR + 'Strata boundary Presumed strata boundary';
    strL_names:= strL_names + ',';

    if copy(ReverseString(strL_names),1,1)=',' then
      delete(strL_names,length(strL_names),1);
    FileList.Add('平面图图例='+ strL_names); //
    //实际上这是剖面图的，只是为了CAD程序不要改动，把上面这些固定的写到平面图图例中

      //取得当前工程的一个土层编号
    strSQL:='SELECT top 1 stra_no,sub_no from stratum_description'
      +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
      +' ORDER BY id';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      if not eof then
        begin
          stra_no:= FieldByName('stra_no').AsString;
          sub_no := FieldByName('sub_no').AsString;
          if sub_no<>'0' then
            stra_no:= stra_no + REPORT_PRINT_SPLIT_CHAR + sub_no;
        end;
      close;
    end;
    FileList.Add('土层编号='+ stra_no);

      //取得当前工程的第一个剖面的第一个孔号和标高
    strSQL:='SELECT drl_no,drl_elev FROM drills WHERE '
      +' prj_no='+''''+g_ProjectInfo.prj_no_ForSQL +''''
      +' AND drl_no = (SELECT top 1 drl_no FROM section_drill WHERE '
      +' prj_no='+''''+g_ProjectInfo.prj_no_ForSQL +''''
      +' AND sec_no=(SELECT MIN(sec_no) FROM section WHERE '
      +' prj_no='+''''+g_ProjectInfo.prj_no_ForSQL +''''+') ORDER BY id)';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      if not eof then
        begin
          drl_no   := FieldByName('drl_no').AsString;
          drl_elev := FormatFloat('0.00',FieldByName('drl_elev').AsFloat);
        end;
      close;
    end;
    if drl_no='' then
    begin
      drl_no := 'C1';
      drl_elev:='2.34';
    end;
      
    FileList.Add('孔号标高='+ drl_no+REPORT_PRINT_SPLIT_CHAR+drl_elev);

    //取得当前工程的标准贯入的一个值，如果没有，不要写入文件
    strSQL:='SELECT top 1 real_num1+real_num2+real_num3 as real_num '
      +' FROM SPT '
      +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      if not eof then
        begin
          SptRealNum := FormatFloat('0',FieldByName('real_num').AsFloat);
        end;
      close;
    end;

    FileList.Add('标准贯入='+ SptRealNum);


    FileList.SaveToFile(strFileName);
  finally
    FileList.Free;
  end;
  winexec(pAnsichar(getCadExcuteName+' '+PrintChart_Legend+','+strFileName+ ','
    + REPORT_PRINT_SPLIT_CHAR),sw_normal);
end;



end.
