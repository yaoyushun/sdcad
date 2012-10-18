unit JingTanTongJi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, FR_DSet, FR_DBSet, FR_Class, StdCtrls, Buttons,
  ExtCtrls;

type
  TJingTanTongJiForm = class(TForm)
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
    btn_cancel: TBitBtn;
    btn_Print: TBitBtn;
    btnTongJi: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure btnTongJiClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //静力触探数据分层,计算毎层的fs和qc的平均值,将产生的数据插入临时表cpttmp
    procedure JingLiChuTanShuJuFenCeng;
    //静力触探数据计算并剔除,(平均值、标准差、变异系数、最大值、最小值、样本值)
    procedure JingLiChuTanShuJuJiSuan;
  public
    { Public declarations }
  end;

var
  JingTanTongJiForm: TJingTanTongJiForm;

implementation

uses MainDM, public_unit, Preview, SdCadMath;

{$R *.dfm}
//取得样品数所对应的舍弃值的临界值
//公式:f(x)= (x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1
function GetCriticalValue(aSampleNum: integer): double;
var
  iNum: integer;
  x0,y0,x1,y1,tmpX,tmpY: double;
begin
  x0:=0;
  y0:=0;
  with MainDataModule.qrySectionTotal do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT yangpinshu,zhixinshuiping95 FROM CriticalValue');
    open;
    iNum:= 0;
    while not eof do
    begin
      inc(iNum);
      tmpX:= FieldbyName('yangpinshu').AsInteger;
      tmpY:= FieldbyName('zhixinshuiping95').AsFloat;
      if aSampleNum= tmpX then
      begin
        result:= tmpY;
        close;
        exit;
      end;
      if iNum=1 then 
        begin
          x0:= tmpX;
          y0:= tmpY;
          if aSampleNum<x0 then
          begin
            result:= tmpY;
            close;
            exit;
          end;
        end
      else
        begin
          if (aSampleNum<tmpX) then
            begin
              x1:=tmpX;
              y1:=tmpY;
              result:= StrToFloat(formatfloat('0.00',XianXingChaZhi(x0, y0, x1, y1, aSampleNum)));
              close;
              exit;
            end
          else
            begin
              x0:= tmpX;
              y0:= tmpY;
            end;
        end; 
      next;
    end;
    close;
  end;
  result:= y0;
end;

//取得一个工程中所有的层号和亚层号和土类名称，保存在三个TStringList变量中。
procedure GetAllStratumNo(var AStratumNoList, ASubNoList, AEaNameList: TStringList);
var
  strSQL: string;
begin
  AStratumNoList.Clear;
  ASubNoList.Clear;
  AEaNameList.Clear;
  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description' 
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' ORDER BY id';
  with MainDataModule.qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      while not eof do
        begin
          AStratumNoList.Add(FieldByName('stra_no').AsString); 
          ASubNoList.Add(FieldByName('sub_no').AsString);
          AEaNameList.Add(FieldByName('ea_name').AsString);
          next; 
        end;
      close;
    end;
end;

procedure TJingTanTongJiForm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='prj_name' then
    ParValue:= g_ProjectInfo.prj_name;
end;

procedure TJingTanTongJiForm.JingLiChuTanShuJuFenCeng;
var
  iDrillCount,iStratumCount,i,j:integer;
  dBottom: double;
  strSQL, strTmp: string;
  lstDrillsNo,lstStratumNo,lstSubNo,
  lstStratumDepth,lstStratumTopDepth,lstStratumBottDepth:TStringList;

  strQcAll,strFsAll: String;  //保存锥尖阻力和侧壁摩擦力的整个字符串。
  qcList,fsList: TStringList; //保存锥尖阻力和侧壁摩擦力
  dBeginDepth,dEndDepth:double; //保存开始深度和结束深度
  isSHQ: boolean;  //是否是双桥静力触探孔
  dqcTotal, dfsTotal, dqcAverage,dfsAverage: double;
  procedure GetDrillNo(var AStingList: TStringList);
  begin
    AStingList.Clear;
    with MainDataModule.qryDrills do
      begin
        close;
        sql.Clear;
        //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
        sql.Add('SELECT prj_no,drl_no FROM cpt ');
        //2008/11/21 yys edit 加入选择条件，钻孔参与统计
        sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
          +' and drl_no in (select drl_no from drills where can_tongji=0 '
          +' AND prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''' + ')');
        open;
        while not Eof do
          begin
            AStingList.Add(FieldByName('drl_no').AsString);
            Next ;
          end;
        close;
      end;    
  end;
  procedure GetStramDepth(const aDrillNo: string;
     var AStratumNoList, ASubNoList, ATopList, ABottList: TStringList);
  var
    preStra_depth: string; 
  begin
    AStratumNoList.Clear;
    ASubNoList.Clear;
    ATopList.Clear;
    ABottList.Clear;
    strSQL:='select prj_no, drl_no, stra_no, sub_no, stra_depth '
        +' FROM stratum ' 
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND drl_no ='+''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
        //+' ORDER BY d.drl_no,s.top_elev';
    with MainDataModule.qryStratum do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        preStra_depth:= '0';
        while not eof do
          begin
            AStratumNoList.Add(FieldByName('stra_no').AsString); 
            ASubNoList.Add(FieldByName('sub_no').AsString);
            ATopList.Add(preStra_depth);
            preStra_depth:= FieldByName('stra_depth').AsString ;
            ABottList.Add(preStra_depth);
            next; 
          end;
        close;
      end;
  end;
  procedure FreeStringList;
  begin
    lstDrillsNo.Free;
    lstStratumNo.Free;
    lstSubNo.Free;
    lstStratumDepth.Free;
    lstStratumTopDepth.Free;
    lstStratumBottDepth.Free;
    qcList.Free;
    fsList.Free;
  end;
  
begin
  dBeginDepth:=0;
  dEndDepth:=0;
  isSHQ:= false;
  lstDrillsNo := TStringList.Create;
  lstStratumNo:= TStringList.Create;
  lstSubNo:= TStringList.Create;
  lstStratumDepth:= TStringList.Create;
  lstStratumTopDepth:= TStringList.Create;
  lstStratumBottDepth:= TStringList.Create;  
  qcList:= TStringList.Create;
  fsList:= TStringList.Create;
  
  GetDrillNo(lstDrillsNo);

//清除静力触探临时表cptTmp中所有记录
  strSQL:= 'TRUNCATE TABLE cpttmp';
  with MainDataModule.qryEarthSample do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        ExecSQL;
        close;
      end;

  if lstDrillsNo.Count =0 then 
  begin
    FreeStringList;
    exit;
  end;

  try

      
    for iDrillCount:= 0 to lstDrillsNo.Count-1 do
      begin
        GetStramDepth(lstDrillsNo.Strings[iDrillCount],
          lstStratumNo, lstSubNo, lstStratumTopDepth, lstStratumBottDepth);
        if lstStratumNo.Count =0 then continue;

        //开始取得静力触探的数据。
        strQcAll:='';
        strFsAll:='';
        qcList.Clear;
        fsList.Clear;
        strSQL:='SELECT cpt.prj_no,cpt.drl_no,cpt.begin_depth,cpt.end_depth,cpt.qc,cpt.fs,drills.d_t_no '
                 +' FROM cpt,drills '
                 +' WHERE cpt.prj_no=drills.prj_no AND cpt.drl_no=drills.drl_no '
                 +' AND cpt.prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
                 +' AND cpt.drl_no='  +''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+'''';
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
                dBeginDepth := FieldByName('begin_depth').AsFloat;
                dEndDepth := FieldByName('end_depth').AsFloat;
                if FieldByName('d_t_no').AsString=g_ZKLXBianHao.ShuangQiao then
                  isSHQ:= true
                else if FieldByName('d_t_no').AsString=g_ZKLXBianHao.DanQiao then
                  isSHQ:= false
                else continue;
              end;
            close;
          end;
        if i>0 then
        begin
          DivideString(strQcAll,',',qcList);
          DivideString(strFsAll,',',fsList);  
        end
        else
          continue; 

        //开始分层,并计算毎层的fs和qc的平均值,将产生的数据插入临时表cpttmp  
        for iStratumCount:=0 to lstStratumNo.Count -1 do
        begin
          //dTop:= strtofloat(lstStratumTopDepth.Strings[iStratumCount]);
          dBottom:= strtofloat(lstStratumBottDepth.Strings[iStratumCount]);
          if (dBottom-dBeginDepth)>=g_cptIncreaseDepth then
          begin
            if dEndDepth>dBottom then
              j:= round((dBottom - dBeginDepth) / g_cptIncreaseDepth)
            else
              j:= round((dEndDepth - dBeginDepth) / g_cptIncreaseDepth);
            dqcTotal:=0;
            dfsTotal:=0;
            for i:= 1 to j do
            begin
              strTmp:= trim(qcList.Strings[0]);
              if isFloat(strTmp) then
                dqcTotal:= dqcTotal + strtofloat(strTmp);                
              qcList.Delete(0);
              if fsList.Count>0 then
              begin 
                strTmp:= trim(fsList.Strings[0]);
                if isFloat(strTmp) then
                  dfsTotal:= dfsTotal + strtofloat(strTmp);                
                fsList.Delete(0);
              end;
            end;
            if j>0 then
            begin
              dqcAverage:= dqcToTal / j;
              dfsAverage:= dfsToTal / j;
              if isSHQ then
                strSQL:= 'INSERT INTO cpttmp (drl_no,stra_no,sub_no,qc,fs) VALUES('
                  +''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''+','
                  +''''+lstStratumNo.Strings[iStratumCount]+''''+','
                  +''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+'''' + ','
                  +FormatFloat('0.00',dqcAverage)+','
                  +FormatFloat('0.00',dfsAverage) + ')'
              else
                strSQL:= 'INSERT INTO cpttmp (drl_no,stra_no,sub_no,ps) VALUES('
                  +''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''+','
                  +''''+lstStratumNo.Strings[iStratumCount]+''''+','
                  +''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+'''' + ','
                  +FormatFloat('0.00',dqcAverage)+')';
              Insert_oneRecord(MainDataModule.qryCPT, strSQL);
            end;
            dBeginDepth:= dBottom;
            if dEndDepth <= dBottom then 
              Break;
              //dqcTotal, dfsTotal, dqcAverage,dfsAverage                
          end;
        end;
      end;
    finally
      FreeStringList;
    end;
    
end;


procedure TJingTanTongJiForm.JingLiChuTanShuJuJiSuan;
var
    //层号          亚层号
  lstStratumNo, lstSubNo, lstEa_name: TStringList;
  qc: TAnalyzeResult;
  fs: TAnalyzeResult;
  ps: TAnalyzeResult;
  i,j, iRecordCount: integer;
  strWhereClause, strSetValue, strSQL : string;
  //初始化此过程中的变量
  procedure InitVar;
  begin
    lstStratumNo:= TStringList.Create;
    lstSubNo:= TStringList.Create;
    lstEa_name:= TStringList.Create;
    qc.lstValues := TStringList.Create;
    fs.lstValues := TstringList.Create;
    ps.lstValues := TStringList.Create;
    qc.FormatString := '0.00';
    fs.FormatString := '0.00';
    ps.FormatString := '0.00';
  end;
  
  //释放此过程中的变量
  procedure FreeStringList;
  begin
    lstStratumNo.Free;
    lstSubNo.Free;
    lstEa_name.Free;
    
    qc.lstValues.Free;
    fs.lstValues.Free;
    ps.lstValues.Free;
  end;
begin
  InitVar;
  GetAllStratumNo(lstStratumNo, lstSubNo, lstEa_name);
  if lstStratumNo.Count = 0 then 
  begin
    FreeStringList;
    exit;
  end;

  for i:=0 to lstStratumNo.Count-1 do
  begin
    strSQL:='SELECT * FROM cptTmp ' 
        +' WHERE stra_no='+''''+lstStratumNo.Strings[i]+''''
        +' AND sub_no='+''''+stringReplace(lstSubNo.Strings[i],'''','''''',[rfReplaceAll])+'''';
    iRecordCount := 0;
    qc.lstValues.Clear;
    fs.lstValues.Clear;
    ps.lstValues.Clear;          
    with MainDataModule.qryEarthSample do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        while not eof do
          begin
            inc(iRecordCount);
            qc.lstValues.Add(FieldByName('qc').AsString);
            fs.lstValues.Add(FieldByName('fs').AsString);
            ps.lstValues.Add(FieldByName('ps').AsString);
            next;
          end;
        close;
      end;
    if iRecordCount=0 then
      continue;
      
    //取得特征数

    getTeZhengShu(qc, [tfJingTan]);
    getTeZhengShu(fs, [tfJingTan]);
    getTeZhengShu(ps, [tfJingTan]);

  {******把平均值、标准差、变异系数、最大值、**********}
  {******最小值、样本值等插入特征数表TeZhengShuTmp ****}
    //
    strWhereClause := 'WHERE stra_no='+''''+lstStratumNo.Strings[i]+''''
      +' AND sub_no='+ ''''+stringReplace(lstSubNo.Strings[i],'''','''''',[rfReplaceAll])+'''' + ' AND v_id=';
    strSetValue:='UPDATE TeZhengShuTmp SET ';
    //开始插入平均值
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.PingJunZhi) +',' 
      + 'cpt_fs='+FloatToStr(fs.PingJunZhi)+','
      + 'cpt_ps='+FloatToStr(ps.PingJunZhi) + strWhereClause + '1'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then
      continue;
      
    //开始插入标准差
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.BiaoZhunCha) +',' 
      + 'cpt_fs='+FloatToStr(fs.BiaoZhunCha) +','
      + 'cpt_ps='+FloatToStr(ps.BiaoZhunCha) + strWhereClause + '2'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入变异系数
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.BianYiXiShu) +',' 
      + 'cpt_fs='+FloatToStr(fs.BianYiXiShu) +','
      + 'cpt_ps='+FloatToStr(ps.BianYiXiShu) + strWhereClause + '3'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入最大值
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.MaxValue) +',' 
      + 'cpt_fs='+FloatToStr(fs.MaxValue) +','
      + 'cpt_ps='+FloatToStr(ps.MaxValue) + strWhereClause + '4'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入最小值
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.MinValue) +',' 
      + 'cpt_fs='+FloatToStr(fs.MinValue) +','
      + 'cpt_ps='+FloatToStr(ps.MinValue) + strWhereClause + '5'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入样本值
    strSQL:= '';
    strSQL:=strSetValue + 'cpt_qc='+FloatToStr(qc.SampleNum) +',' 
      + 'cpt_fs='+FloatToStr(fs.SampleNum) +','
      + 'cpt_ps='+FloatToStr(ps.SampleNum) + strWhereClause + '6'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;    
  end;
  FreeStringList;
end;


procedure TJingTanTongJiForm.btnTongJiClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    //静力触探数据分层,计算毎层的fs和qc的平均值,将产生的数据插入临时表cpttmp
    JingLiChuTanShuJuFenCeng;
    //静力触探数据计算并剔除,(平均值、标准差、变异系数、最大值、最小值、样本值)
    JingLiChuTanShuJuJiSuan;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TJingTanTongJiForm.btn_PrintClick(Sender: TObject);
var 
  strSQL: string;  
begin
  MainDataModule.DropTableFromDB('JingTanTongJi') ;
  
  strSQL:= 'SELECT t.* INTO JingTanTongJi FROM '
  
       +'(select prj_no, stra_no, sub_no, '+'''1_qc'' AS qufen,'
       +'SUM(CASE v_id WHEN 1 THEN cpt_qc END) AS sspjz,'
       +'SUM(CASE v_id WHEN 2 THEN cpt_qc END) AS bzc,'
       +'SUM(CASE v_id WHEN 3 THEN cpt_qc END) AS byxs,'
       +'SUM(CASE v_id WHEN 4 THEN cpt_qc END) AS zdz,'
       +'SUM(CASE v_id WHEN 5 THEN cpt_qc END) AS zxz'
       +' FROM TeZhengShuTmp GROUP BY prj_no, stra_no, sub_no '
       
       +' UNION '
       
       +'SELECT prj_no, stra_no, sub_no, '+'''2_fs'','
       +'SUM(CASE v_id WHEN 1 THEN cpt_fs END),'
       +'SUM(CASE v_id WHEN 2 THEN cpt_fs END),'
       +'SUM(CASE v_id WHEN 3 THEN cpt_fs END),'
       +'SUM(CASE v_id WHEN 4 THEN cpt_fs END),'
       +'SUM(CASE v_id WHEN 5 THEN cpt_fs END) '
       +' FROM TeZhengShuTmp GROUP BY prj_no, stra_no, sub_no '
       
       +' UNION '

       +'SELECT prj_no, stra_no, sub_no, '+'''3_ps'','
       +'SUM(CASE v_id WHEN 1 THEN cpt_ps END),'
       +'SUM(CASE v_id WHEN 2 THEN cpt_ps END),'
       +'SUM(CASE v_id WHEN 3 THEN cpt_ps END),'
       +'SUM(CASE v_id WHEN 4 THEN cpt_ps END),'
       +'SUM(CASE v_id WHEN 5 THEN cpt_ps END) '
       +' FROM TeZhengShuTmp GROUP BY prj_no, stra_no, sub_no '
              
       +') as t'
       +' WHERE  prj_no= '+''''
       +g_ProjectInfo.prj_no_ForSQL+'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      ExecSQL;
      close;   
    end;

  strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name FROM stratum_description' 
      +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' ORDER BY id';
  with qryStratum do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
    end;        

  self.tblSampleValue.TableName :='earthsampleTmp';
  tblSampleValue.MasterFields := 'prj_no;stra_no;sub_no';
  self.tblSampleValue.Open;
  self.tblTeZhengShu.TableName :='JingTanTongJi';
  tblTeZhengShu.MasterFields := 'prj_no;stra_no;sub_no';
  self.tblTeZhengShu.Open;
  frReport1.LoadFromFile(g_AppInfo.PathOfReports + 'JingTanTongJiCanShu.frf');
  frReport1.Preview := PreviewForm.frPreview1;
  if frReport1.PrepareReport then
  begin
    frReport1.ShowPreparedReport;
    PreviewForm.ShowModal;
  end;  
  
  self.tblSampleValue.Close;
  self.tblTeZhengShu.Close;
  self.qryStratum.Close;
end;


procedure TJingTanTongJiForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;

end.
