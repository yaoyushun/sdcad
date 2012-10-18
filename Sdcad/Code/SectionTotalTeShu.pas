unit SectionTotalTeShu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  FR_DSet, FR_DBSet, DB, FR_Class, ADODB;

type
  TSectionTotalTeShuForm = class(TForm)
    qryTeZhengShu: TADOQuery;
    tblTeZhengShu: TADOTable;
    frReport1: TfrReport;
    qryStratum: TADOQuery;
    DSStratumMaster: TDataSource;
    DSSampleValue: TDataSource;
    DSTeZhengShu: TDataSource;
    frDBTeZhengShu: TfrDBDataSet;
    frDBSampleValue: TfrDBDataSet;
    frDBStratumMaster: TfrDBDataSet;
    btnFenCengJiSuan: TButton;
    btn_Print: TBitBtn;
    btn_cancel: TBitBtn;
    Button1: TButton;
    suiGroupBox1: TGroupBox;
    Label2: TLabel;
    btnPrintFuBiao: TBitBtn;
    tblSampleValue: TADODataSet;
    procedure Button1Click(Sender: TObject);
    procedure btnFenCengJiSuanClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure btnPrintFuBiaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SectionTotalTeShuForm: TSectionTotalTeShuForm;
  m_bPrintRoot: boolean;
implementation

uses public_unit, MainDM, Preview;

{$R *.dfm}

procedure TSectionTotalTeShuForm.Button1Click(Sender: TObject);
var
  strSQL: string;
begin
    strSQL:= 'TRUNCATE TABLE stratumTmp; TRUNCATE TABLE TeShuYangTzsTmp; TRUNCATE TABLE TeShuYangTmp ';
    Delete_oneRecord(MainDataModule.qryPublic, strSQL);
end;

procedure TSectionTotalTeShuForm.btnFenCengJiSuanClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    FenXiFenCeng_TeShuYiangJiSuan;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TSectionTotalTeShuForm.btn_PrintClick(Sender: TObject);
var
  strSQL,strWhereClause: string;
  procedure DeleteTempTable;//删除临时表
  begin
    strSQL := 'DROP TABLE #TeZhengShu';
    with qryTeZhengShu do
    begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        ExecSQL;
        close;
    end;
  end;
begin
  strWhereClause := ' [gygj_pc] IS NOT NULL '   //要排除没有实验数据
      +' OR [gygj_cc] IS NOT NULL '
      +' OR [gygj_cs] IS NOT NULL '
      +' OR [html] IS NOT NULL '
      +' OR [gjxs50_1] IS NOT NULL '
      +' OR [gjxs100_1] IS NOT NULL '
      +' OR [gjxs200_1] IS NOT NULL '
      +' OR [gjxs400_1] IS NOT NULL '
      +' OR [gjxs50_2] IS NOT NULL '
      +' OR [gjxs100_2] IS NOT NULL '
      +' OR [gjxs200_2] IS NOT NULL '
      +' OR [gjxs400_2] IS NOT NULL '
      +' OR [jcxs_v_005_01] IS NOT NULL '
      +' OR [jcxs_v_01_02] IS NOT NULL '
      +' OR [jcxs_v_02_04] IS NOT NULL '
      +' OR [jcxs_h_005_01] IS NOT NULL '
      +' OR [jcxs_h_01_02] IS NOT NULL '
      +' OR [jcxs_h_02_04] IS NOT NULL '
      +' OR [jzcylxs] IS NOT NULL '
      +' OR [wcxkyqd_yz] IS NOT NULL '
      +' OR [wcxkyqd_cs] IS NOT NULL '
      +' OR [wcxkyqd_lmd] IS NOT NULL '
      +' OR [szsy_syff] IS NOT NULL '
      +' OR [szsy_zyl_njl_uu] IS NOT NULL '
      +' OR [szsy_zyl_nmcj_uu] IS NOT NULL '
      +' OR [szsy_zyl_njl_cu] IS NOT NULL '
      +' OR [szsy_zyl_nmcj_cu] IS NOT NULL '
      +' OR [szsy_yxyl_njl] IS NOT NULL '
      +' OR [szsy_yxyl_nmcj] IS NOT NULL '
      +' OR [stxs_kv] IS NOT NULL '
      +' OR [stxs_kh] IS NOT NULL '
      +' OR [trpj_g] IS NOT NULL '
      +' OR [trpj_sx] IS NOT NULL ';
  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description '
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND (prj_no+stra_no+sub_no) in (SELECT DISTINCT prj_no+stra_no+sub_no FROM TeShuYangTmp WHERE '
      +strWhereClause+')' +' ORDER BY id';
  with qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      Open;
    end;

//  tblSampleValue.TableName :='TeShuYangTmp';
//  tblSampleValue.MasterFields := 'prj_no;stra_no;sub_no';
//  tblSampleValue.Open;
  tblSampleValue.MasterFields:='prj_no;stra_no;sub_no';
  tblSampleValue.CommandType := cmdText;
  tblSampleValue.CommandText := 'Select * from TeShuYangTmp where ' + strWhereClause;
  tblSampleValue.Open;

  strSQL := 'Select * Into #TeZhengShu FROM TeShuYangTzsTmp WHERE prj_no = '
     + ''''+g_ProjectInfo.prj_no_ForSQL+'''' + ' AND v_id<7';
  with qryTeZhengShu do
  begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      ExecSQL;
      close;
  end;    // with
  tblTeZhengShu.TableName :='#TeZhengShu';
  tblTeZhengShu.MasterFields := 'prj_no;stra_no;sub_no';
  //2008/11/21 yys add 增加标准值在tezhengshuTmp表中，而这个值只在物理力学性质指标一览表中才需要，所以在分析分层总表中要过滤掉这个值
  tblTeZhengShu.Open;

  if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
    frReport1.LoadFromFile(g_AppInfo.PathOfReports + 'TuFenXiFenCengZongBiao_TeShuYang.frf')
  else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    frReport1.LoadFromFile(g_AppInfo.PathOfReports +
      'TuFenXiFenCengZongBiao_TeShuYang.frf');
  frReport1.Preview := PreviewForm.frPreview1;
  if frReport1.PrepareReport then
  begin
    frReport1.ShowPreparedReport;
    PreviewForm.ShowModal;
  end;

  self.qryStratum.Close;
  self.tblSampleValue.Close;
  self.tblTeZhengShu.Close;

  DeleteTempTable;

end;

procedure TSectionTotalTeShuForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TSectionTotalTeShuForm.FormCreate(Sender: TObject);
begin
    self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;

procedure TSectionTotalTeShuForm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='prj_name' then
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      ParValue:= g_ProjectInfo.prj_name
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      ParValue:= g_ProjectInfo.prj_name_en;
end;

procedure TSectionTotalTeShuForm.btnPrintFuBiaoClick(Sender: TObject);
var
  strSQL,strWhereClause: string;
  procedure DeleteTempTable;//删除临时表
  begin
    strSQL := 'DROP TABLE #TeZhengShu';
    with qryTeZhengShu do
    begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        ExecSQL;
        close;
    end;
  end;
begin
  strWhereClause :=  ' [klzc_li] IS NOT NULL '
      +' OR [klzc_sha_2_05] IS NOT NULL '
      +' OR [klzc_sha_05_025] IS NOT NULL '
      +' OR [klzc_sha_025_0075] IS NOT NULL '
      +' OR [klzc_fl] IS NOT NULL '
      +' OR [klzc_nl] IS NOT NULL '
      +' OR [lj_yxlj] IS NOT NULL '
      +' OR [lj_pjlj] IS NOT NULL '
      +' OR [lj_xzlj] IS NOT NULL '
      +' OR [lj_d70] IS NOT NULL '
      +' OR [bjyxs] IS NOT NULL '
      +' OR [qlxs] IS NOT NULL ';
  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description'
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND (prj_no+stra_no+sub_no) in (SELECT DISTINCT prj_no+stra_no+sub_no FROM TeShuYangTmp WHERE '
      + strWhereClause +')'+' ORDER BY id';
  with qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      Open;
    end;


  tblSampleValue.MasterFields:='prj_no;stra_no;sub_no';
  tblSampleValue.CommandType := cmdText;
  tblSampleValue.CommandText := 'Select * from TeShuYangTmp where '+ strWhereClause;
  tblSampleValue.Open;


  strSQL := 'Select * Into #TeZhengShu FROM TeShuYangTzsTmp WHERE prj_no = '
     + ''''+g_ProjectInfo.prj_no_ForSQL+'''' + ' AND v_id<7';
  with qryTeZhengShu do
  begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      ExecSQL;
      close;
  end;    // with
  tblTeZhengShu.TableName :='#TeZhengShu';
  tblTeZhengShu.MasterFields := 'prj_no;stra_no;sub_no';
  //2008/11/21 yys add 增加标准值在tezhengshuTmp表中，而这个值只在物理力学性质指标一览表中才需要，所以在分析分层总表中要过滤掉这个值
  tblTeZhengShu.Open;

  if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
    frReport1.LoadFromFile(g_AppInfo.PathOfReports + 'TuFenXiFenCengZongBiao_TeShuYang_FuBiao.frf')
  else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    frReport1.LoadFromFile(g_AppInfo.PathOfReports +
      'TuFenXiFenCengZongBiao_TeShuYang.frf');
  frReport1.Preview := PreviewForm.frPreview1;
  if frReport1.PrepareReport then
  begin
    frReport1.ShowPreparedReport;
    PreviewForm.ShowModal;
  end;

  tblSampleValue.Close;
  self.qryStratum.Close;
  self.tblTeZhengShu.Close;

  DeleteTempTable;


end;

end.
