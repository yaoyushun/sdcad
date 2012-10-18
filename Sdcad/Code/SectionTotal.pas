unit SectionTotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, FR_DSet, FR_DBSet, FR_Class, Buttons,
  ExtCtrls;

type
  TSectionTotalForm = class(TForm)
    frReport1: TfrReport;
    frDBTeZhengShu: TfrDBDataset;
    DSTeZhengShu: TDataSource;
    DSSampleValue: TDataSource;
    frDBSampleValue: TfrDBDataset;
    DSStratumMaster: TDataSource;
    frDBStratumMaster: TfrDBDataset;
    tblTeZhengShu: TADOTable;
    tblSampleValue: TADOTable;
    qryStratum: TADOQuery;
    qryTeZhengShu: TADOQuery;
    btnFenCengJiSuan: TButton;
    btn_Print: TBitBtn;
    btn_cancel: TBitBtn;
    Button1: TButton;
    suiGroupBox1: TGroupBox;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure FormCreate(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnFenCengJiSuanClick(Sender: TObject);
  private
    { Private declarations }
    //procedure SetTuYangCengHao;
  public
    { Public declarations }
  end;

var
  SectionTotalForm: TSectionTotalForm;
  m_bPrintRoot: boolean;
implementation

uses MainDM, public_unit, Preview;

{$R *.dfm}




procedure TSectionTotalForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TSectionTotalForm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='prj_name' then
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      ParValue:= g_ProjectInfo.prj_name
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      ParValue:= g_ProjectInfo.prj_name_en;
end;


procedure TSectionTotalForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;

//给土样分层
//procedure TSectionTotalForm.SetTuYangCengHao;
// var
//   iDrillCount,iStratumCount:integer;
//   strSQL: string;
//   lstDrillsNo,lstStratumNo,lstSubNo,
//   lstStratumDepth,lstStratumBottDepth:TStringList;
//   procedure GetDrillNo(var AStingList: TStringList);
//   begin
//     AStingList.Clear;
//     with MainDataModule.qryDrills do
//       begin
//         close;
//         sql.Clear;
//         //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
//         sql.Add('SELECT prj_no,drl_no FROM drills ');
//         sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
//         open;
//         while not Eof do
//           begin
//             AStingList.Add(FieldByName('drl_no').AsString);
//             Next ;
//           end;
//         close;
//       end;
//   end;
//  procedure GetStramDepth(const aDrillNo: string;
//   var AStratumNoList, ASubNoList, ABottList: TStringList);
//  begin
//    AStratumNoList.Clear;
//    ASubNoList.Clear;
//    ABottList.Clear;
//    strSQL:='SELECT drl_no,stra_no,sub_no,stra_depth '
//      +' FROM stratum '
//      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
//      +' AND drl_no='+''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
//      +' ORDER BY stra_depth';
//    with MainDataModule.qryStratum do
//      begin
//        close;
//        sql.Clear;
//        sql.Add(strSQL);
//        open;
//        while not eof do
//          begin
//            AStratumNoList.Add(FieldByName('stra_no').AsString); 
//            ASubNoList.Add(FieldByName('sub_no').AsString);
//            ABottList.Add(FieldByName('stra_depth').AsString);
//            next;
//          end;
//        close;
//      end;
//  end;
//  procedure FreeStringList;
//  begin
//    lstDrillsNo.Free;;
//    lstStratumNo.Free;
//    lstSubNo.Free;
//    lstStratumDepth.Free;
//    lstStratumBottDepth.Free;
//  end;
//begin
//  lstDrillsNo := TStringList.Create;
//  lstStratumNo:= TStringList.Create;
//  lstSubNo:= TStringList.Create;
//  lstStratumDepth:= TStringList.Create;
//  lstStratumBottDepth:= TStringList.Create;
//  GetDrillNo(lstDrillsNo);
//  if lstDrillsNo.Count =0 then
//  begin
//    FreeStringList;
//    exit;
//  end;
//
//  try
//    //清除工程中所有土样的层和亚层的信息
//    strSQL:= 'UPDATE earthsample set stra_no=null,sub_no=0 '
//      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''';
//      with MainDataModule.qryEarthSample do
//      begin
//        close;
//        sql.Clear;
//        sql.Add(strSQL);
//        ExecSQL;  
//        close;
//      end;
//    //开始给各土样分层，土样的深度在钻孔的哪一层，它的层号就是那一个.
//    for iDrillCount:= 0 to lstDrillsNo.Count-1 do
//      begin
//        GetStramDepth(lstDrillsNo.Strings[iDrillCount],
//          lstStratumNo, lstSubNo, lstStratumBottDepth);
//        if lstStratumNo.Count =0 then continue;
//
//        for iStratumCount:=0 to lstStratumNo.Count -1 do
//        begin
//          if iStratumCount=0 then
//            strSQL:='UPDATE earthsample Set '
//              +'stra_no='+''''+lstStratumNo.Strings[iStratumCount]+''''+','
//              +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
//              +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
//              +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
//              +' AND s_depth_begin>=0 '
//              +' AND s_depth_begin<'+lstStratumBottDepth.Strings[iStratumCount]
//          else
//            strSQL:='UPDATE earthsample Set '
//              +'stra_no='+''''+lstStratumNo.Strings[iStratumCount]+''''+','
//              +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
//              +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
//              +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
//              +' AND s_depth_begin>=' + lstStratumBottDepth.Strings[iStratumCount-1]
//              +' AND s_depth_begin<'+lstStratumBottDepth.Strings[iStratumCount];          
//          with MainDataModule.qryEarthSample do
//          begin
//            close;
//            sql.Clear;
//            sql.Add(strSQL);
//            ExecSQL;
//            close;   
//          end;
//        end;
//      end;
//    finally
//      FreeStringList;
//    end;
//end;


procedure TSectionTotalForm.btn_PrintClick(Sender: TObject);
var
  strSQL: string;
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
  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description'
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' ORDER BY id';
  with qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      Open;
    end;

  tblSampleValue.TableName :='earthsampleTmp';
  tblSampleValue.MasterFields := 'prj_no;stra_no;sub_no';
  tblSampleValue.Open;


  strSQL := 'Select * Into #TeZhengShu FROM tezhengshuTmp WHERE prj_no = '
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
    frReport1.LoadFromFile(g_AppInfo.PathOfReports + 'TuFenXiFenCengZongBiao.frf')
  else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    frReport1.LoadFromFile(g_AppInfo.PathOfReports +
      'TuFenXiFenCengZongBiao_en.frf');
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

procedure TSectionTotalForm.Button1Click(Sender: TObject);
var
  strSQL: string;
begin
    strSQL:= 'TRUNCATE TABLE stratumTmp; TRUNCATE TABLE TeZhengShuTmp; TRUNCATE TABLE earthsampleTmp; TRUNCATE TABLE earthsampleTmp ';
    Delete_oneRecord(MainDataModule.qryPublic, strSQL);


end;

procedure TSectionTotalForm.btnFenCengJiSuanClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    FenXiFenCeng_TuYiangJiSuan;
  finally
    screen.Cursor := crDefault;
  end;
end;


end.

