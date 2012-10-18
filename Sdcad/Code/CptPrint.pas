unit CptPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TCptPrintForm = class(TForm)
    lblDrl_no: TLabel;
    cboDrl_no: TComboBox;
    btn_Print: TBitBtn;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtY_scale: TEdit;
    GroupBox2: TGroupBox;
    rbHor: TRadioButton;
    rbVer: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure cboDrl_noChange(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(bHaveRecord:boolean);
    procedure Get_oneRecord(aProjectNo: string;aDrillNo: string);
  public
    { Public declarations }
  end;

var
  CptPrintForm: TCptPrintForm;

implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TCptPrintForm.button_status(bHaveRecord: boolean);
begin
  btn_Print.Enabled := bHaveRecord;
  btn_ok.Enabled := bHaveRecord;
end;

procedure TCptPrintForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  cboDrl_no.Clear;

  Clear_Data(self);
  with MainDataModule.qryCPT do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT prj_no,drl_no');
      sql.Add(' FROM cpt ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      i:=0;
      while not Eof do
        begin
          i:=i+1;
          cboDrl_no.Items.Add(FieldByName('drl_no').AsString);  
          Next ;
        end;
      close;
    end;
  if i>0 then
  begin    
    //Get_oneRecord(g_ProjectInfo.prj_no, cboDrl_no.Text); 
    button_status(true);
  end
  else
    button_status(false);
  
end;

procedure TCptPrintForm.Get_oneRecord(aProjectNo, aDrillNo: string);
var
  strTmp:string;
begin
  if trim(aProjectNo)='' then exit;
  if trim(aDrillNo)='' then exit;
  with MainDataModule.qryCPT do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT y_scale from cpt');
      sql.Add(' where prj_no=' + ''''+stringReplace(aProjectNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND drl_no=' +''''+aDrillNo+'''');  
      open;
      if not Eof then
      begin
        strTmp := FieldByName('Y_scale').AsString;
        if strTmp <>'' then
          edtY_scale.Text := strTmp
        else if edtY_scale.Text ='' then
          edtY_scale.Text := '200';

      end;
//      if edtY_scale.Text='' then
//         edtY_scale.Text := '200';

      close;
    end;
end;

procedure TCptPrintForm.cboDrl_noChange(Sender: TObject);
var
  drl_no: string;
begin
  drl_no:= trim(cboDrl_no.Text);
  if drl_no ='' then
  begin
    button_status(false);
    exit;
  end;
  Get_oneRecord(g_ProjectInfo.prj_no,drl_no);
end;



procedure TCptPrintForm.btn_PrintClick(Sender: TObject);
var 

  drl_no , strSQL, strFileName,drl_type, strExecute: string;
  strQcAverage, strFsAverage, strDepth: string;
  strStra_no, strStra_deep, strStra_thickness, strEa_name : string;
  i, iNum, iStratum : integer;
  dDrl_elev, dBegin_depth, dEnd_depth, preStra_depth,nowStra_depth: double;
  //Drl_no_Array: array of string;
  FileList: TStringList;

begin
  FileList := TStringList.Create;
  strFileName:= g_AppInfo.PathOfChartFile + 'cpt.ini';
  drl_no:= stringReplace(trim(cboDrl_no.Text) ,'''','''''',[rfReplaceAll]);
  if drl_no='' then exit;
  dDrl_elev:=0;
  try
    FileList.Add('[图纸信息]');
    FileList.Add('保存用文件名=静力触探成果表' + trim(cboDrl_no.Text));
    FileList.Add('工程编号='+g_ProjectInfo.prj_no);
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
    begin
      FileList.Add('图纸名称=静力触探成果表');
      FileList.Add('工程名称='+g_ProjectInfo.prj_name)
    end
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    begin
      FileList.Add('图纸名称=The Table of CPT Results');
      FileList.Add('工程名称='+g_ProjectInfo.prj_name_en) ;

    end;
    FileList.Add('工程类型='+g_ProjectInfo.prj_type);
    FileList.Add('[比例尺]');
    FileList.Add('Y=' + edtY_scale.Text); 
    if rbVer.Checked then
      FileList.Add('打印方向=0') //纵向打印
    else
      FileList.Add('打印方向=1'); //横向打印
          
    FileList.Add('[钻孔]');
    strSQL:= 'SELECT prj_no, drl_no,drl_elev,D_t_no,drl_x,drl_y,comp_depth,begin_date,end_date,stable_elev '
      +'FROM drills '
      +'WHERE prj_no = '+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND drl_no = '+''''+drl_no +'''';
    with MainDataModule.qryDrills do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        Open;
        While not eof do
        begin
          FileList.Add('编号='+trim(cboDrl_no.Text));
          FileList.Add('孔口标高='+FieldByName('drl_elev').AsString);
          dDrl_elev:= FieldByName('drl_elev').AsFloat; 
          FileList.Add('孔深='+FieldByName('comp_depth').AsString);
          FileList.Add('孔口坐标X='+FieldByName('drl_x').AsString);
          FileList.Add('孔口坐标Y='+FieldByName('drl_y').AsString);
          FileList.Add('开孔日期='+FieldByName('begin_date').AsString);
          FileList.Add('终孔日期='+FieldByName('end_date').AsString);
          drl_type := FieldByName('d_t_no').AsString;
          if FieldByName('stable_elev').AsString<>'' then
          begin
            FileList.Add('地下水位='
              +FormatFloat('0.00',FieldByName('drl_elev').AsFloat-FieldByName('stable_elev').AsFloat)
              +'/'+FormatFloat('0.00',FieldByName('stable_elev').AsFloat)+'（m）');
          end;
          next;
        end;
        close;
      end;
    //开始加入钻孔的土层信息。
    strSQL:='select s.prj_no,s.drl_no,s.stra_no,s.sub_no, s.stra_depth,';
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      strSQL:= strSQL + 's.ea_name'
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      strSQL:= strSQL  +'s.ea_name+'+'''' + REPORT_PRINT_SPLIT_CHAR +''''+'+' +
        'ISNULL(e.ea_name_en,'''') as ea_name';
    strSQL:=strSQL +',(d.drl_elev-s.stra_depth) as bott_elev '
        +' FROM drills as d,stratum as s ,earthtype as e '
        +' WHERE d.prj_no=s.prj_no AND d.drl_no = s.drl_no AND s.ea_name=e.ea_name '
        +' AND d.prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND d.drl_no ='+''''+drl_no+'''' + ' ORDER BY stra_depth';
    strStra_no := '层号=';
    strStra_deep:= '层深标高=';
    strStra_thickness:= '层厚=';
    strEa_name:= '土类代码=';
    with MainDataModule.qryStratum do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        preStra_depth:= 0;
        while not Eof do
          begin
            
            strStra_no := strStra_no + FieldByName('stra_no').AsString;
            if (FieldByName('sub_no').AsString) <> '0' then 
              strStra_no:= strStra_no + '-' + FieldByName('sub_no').AsString;
            strStra_no := strStra_no + ',';
            nowStra_depth:= FieldByName('stra_depth').AsFloat;
            strStra_deep := strStra_deep 
              + FormatFloat('0.00',nowStra_depth)
              + '(' + FormatFloat('0.00', FieldByName('bott_elev').AsFloat) + ')' + ',';
            strStra_thickness:= strStra_thickness 
              + FormatFloat('0.00',nowStra_depth -preStra_depth) + ',';
            preStra_depth := nowStra_depth;  
            strEa_name := strEa_name + FieldByName('ea_name').AsString +',';
            Next ;
          end;
        close;
      end;
    if copy(strStra_no,length(strStra_no),1)=',' then
      strStra_no:= copy(strStra_no,1,length(strStra_no)-1);      
    FileList.Add(strStra_no);
    if copy(strStra_deep,length(strStra_no),1)=',' then
      strStra_deep:= copy(strStra_deep,1,length(strStra_deep)-1);      
    FileList.Add(strStra_deep);
    if copy(strStra_thickness,length(strStra_thickness),1)=',' then
      strStra_thickness:= copy(strStra_thickness,1,length(strStra_thickness)-1);      
    FileList.Add(strStra_thickness);
    if copy(strEa_name,length(strEa_name),1)=',' then
      strEa_name:= copy(strEa_name,1,length(strEa_name)-1);      
    FileList.Add(strEa_name);
    //开始加入钻孔的静力触探各层的平均值
    strQcAverage:='';
    strFsAverage:='';
    getCptAverageByDrill(drl_no, strQcAverage, strFsAverage);
    if strQcAverage<>'' then
      FileList.Add('锥尖阻力平均值='+strQcAverage);
    if strFsAverage<>'' then
      FileList.Add('侧壁摩阻力平均值='+strFsAverage);
    //开始加入钻孔的静力触探的数据qc,fs,rf
    strSQL:='SELECT prj_no,drl_no,begin_depth,end_depth,qc,fs,rf '
           +'FROM cpt '
           +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
           +' AND drl_no='  +''''+drl_no+'''';
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
        for i:=1 to iNum do
        begin
          dBegin_depth:= dBegin_depth + g_cptIncreaseDepth;
          strDepth:= strDepth + FloatToStr(dBegin_depth) + ',';
        end;
        if copy(strDepth,length(strDepth),1)=',' then
          strDepth:= copy(strDepth,1,length(strDepth)-1);      
        FileList.Add('静探深度=' + strDepth);
        FileList.Add('锥尖阻力qc='+ FieldByName('qc').AsString);
        FileList.Add('侧壁摩阻力fs='+ FieldByName('fs').AsString);
        FileList.Add('摩阻比rf='+ FieldByName('rf').AsString);
      end;
      close;
    end;
    
    FileList.SaveToFile(strFileName);    
  finally
    FileList.Free;
  end;

  strExecute := getCadExcuteName;
  if drl_type = g_ZKLXBianHao.ShuangQiao then
    strExecute := strExecute + ' '+PrintChart_CPT_ShuangQiao+','
  else
    strExecute := strExecute + ' '+PrintChart_CPT_DanQiao+',';
  strExecute := strExecute + strFileName + ','
    + REPORT_PRINT_SPLIT_CHAR;
  winexec(pAnsichar(strExecute),sw_normal);

end;

procedure TCptPrintForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TCptPrintForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  strSQL:= 'UPDATE cpt SET y_scale=' + edtY_scale.Text  
    + ' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
    + ' AND drl_no =' +''''+ stringReplace(trim(cboDrl_no.Text) ,'''','''''',[rfReplaceAll])+'''';
  Update_onerecord(MainDataModule.qryCPT,strSQL);
end;

procedure TCptPrintForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

end.
