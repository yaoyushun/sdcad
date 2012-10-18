unit WuLiLiXue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ADODB, DB, frxDSet, frxDBSet, frxClass,
  ExtCtrls, SUIForm;

type
  TWuLiLiXueForm = class(TForm)
    suiForm1: TsuiForm;
    btn_Print: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    btn_cancel: TBitBtn;
    btnTongJi: TBitBtn;
    frxReport1: TfrxReport;
    frDBTeZhengShu: TfrxDBDataset;
    DSTeZhengShu: TDataSource;
    DSSampleValue: TDataSource;
    frDBSampleValue: TfrxDBDataset;
    DSStratumMaster: TDataSource;
    frDBStratumMaster: TfrxDBDataset;
    tblTeZhengShu: TADOTable;
    tblSampleValue: TADOTable;
    qryStratum: TADOQuery;
    procedure frxReport1GetValue(const ParName: String;
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
    //标贯数据分层
    procedure BiaoGuanShuJuFenCeng;
    //标贯数据计算并剔除
    procedure BiaoGuanShuJuJiSuan;
  public
    { Public declarations }
  end;

var
  WuLiLiXueForm: TWuLiLiXueForm;

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

procedure TWuLiLiXueForm.BiaoGuanShuJuFenCeng;
var
  iDrillCount,iStratumCount:integer;
  strSQL: string;
  lstDrillsNo,lstStratumNo,lstSubNo,
  lstStratumDepth,lstStratumTopDepth,lstStratumBottDepth:TStringList;
  procedure GetDrillNo(var AStingList: TStringList);
  begin
    AStingList.Clear;
    with MainDataModule.qryDrills do
      begin
        close;
        sql.Clear;
        //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
  //2005/04/22 yys edit
        sql.Add('SELECT DISTINCT drl_no FROM spt ');
        sql.Add(' WHERE prj_no='+''''
        +g_ProjectInfo.prj_no_ForSQL+'''');
         //+' AND (d_t_no=2 or d_t_no=10)');  //只选出类型是标准贯入的钻孔
 //2005/04/22 yys edit ,because sometimes input drill type at drills not is 标准贯入钻孔

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
    strSQL:='select drl_no,stra_no,sub_no, stra_depth '
        +' FROM stratum ' 
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND drl_no ='+''''+stringReplace(aDrillNo ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
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
            
            preStra_depth := FieldByName('stra_depth').AsString ;
            ABottList.Add(preStra_depth);
            next; 
          end;
        close;
      end;
  end;
  procedure FreeStringList;
  begin
    lstDrillsNo.Free;;
    lstStratumNo.Free;
    lstSubNo.Free;
    lstStratumDepth.Free;
    lstStratumTopDepth.Free;
    lstStratumBottDepth.Free;
  end;
begin
  lstDrillsNo := TStringList.Create;
  lstStratumNo:= TStringList.Create;
  lstSubNo:= TStringList.Create;
  lstStratumDepth:= TStringList.Create;
  lstStratumTopDepth:= TStringList.Create;
  lstStratumBottDepth:= TStringList.Create;  
  GetDrillNo(lstDrillsNo);
  if lstDrillsNo.Count =0 then
  begin
    FreeStringList;
    exit;
  end;

  try
    //清除工程中所有标准贯入的记录中层和亚层的信息    
    strSQL:= 'UPDATE spt set stra_no=null,sub_no='+''''+'0'+''''+' WHERE prj_no='
      +''''+g_ProjectInfo.prj_no_ForSQL+'''';
      with MainDataModule.qrySPT do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        ExecSQL;
        close;
      end;
      
    for iDrillCount:= 0 to lstDrillsNo.Count-1 do
      begin
        GetStramDepth(lstDrillsNo.Strings[iDrillCount],
          lstStratumNo, lstSubNo, lstStratumTopDepth, lstStratumBottDepth);
        if lstStratumNo.Count =0 then continue;

          
        for iStratumCount:=0 to lstStratumNo.Count -1 do
        begin
          strSQL:='UPDATE spt Set '
            +'stra_no='+''''+lstStratumNo.Strings[iStratumCount]+''''+','
            +'sub_no='+''''+stringReplace(lstSubNo.Strings[iStratumCount],'''','''''',[rfReplaceAll])+''''
            +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
            +' AND drl_no ='+''''+stringReplace(lstDrillsNo.Strings[iDrillCount] ,'''','''''',[rfReplaceAll])+''''
            +' AND end_depth>' + lstStratumTopDepth.Strings[iStratumCount]
            +' AND end_depth<='+lstStratumBottDepth.Strings[iStratumCount];
          with MainDataModule.qryEarthSample do
          begin
            close;
            sql.Clear;
            sql.Add(strSQL);
            ExecSQL;
            close;
          end;
        end;
      end;
    finally
      FreeStringList;
    end;
end;


procedure TWuLiLiXueForm.BiaoGuanShuJuJiSuan;
var
    //层号          亚层号
  lstStratumNo, lstSubNo, lstEa_name: TStringList;
  real_num : TAnalyzeResult;  //实测击数
  amend_num: TAnalyzeResult;  //杆长修正击数
  i,j, iRecordCount: integer;
  strWhereClause, strSetValue, strSQL, strSub_no ,strPrj_No,strStratum_No: string;
  //初始化此过程中的变量
  procedure InitVar;
  begin
    lstStratumNo:= TStringList.Create;
    lstSubNo:= TStringList.Create;
    lstEa_name:= TStringList.Create;
    real_num.lstValues := TStringList.Create;
    amend_num.lstValues := TstringList.Create;
    real_num.FormatString := '0.0';
    amend_num.FormatString := '0.00';
  end;
  
  //释放此过程中的变量
  procedure FreeStringList;
  begin
    lstStratumNo.Free;
    lstSubNo.Free;
    lstEa_name.Free;
    
    real_num.lstValues.Free;
    amend_num.lstValues.Free;
  end;
  
begin
  InitVar;
  GetAllStratumNo(lstStratumNo, lstSubNo, lstEa_name);
  if lstStratumNo.Count = 0 then 
  begin
    FreeStringList;
    exit;
  end;
  strPrj_No := g_ProjectInfo.prj_no_ForSQL;
  for i:=0 to lstStratumNo.Count-1 do
  begin
    strSub_no := stringReplace(lstSubNo.Strings[i] ,'''','''''',[rfReplaceAll]);
    strStratum_No := lstStratumNo.Strings[i];
    strSQL:='SELECT prj_no, drl_no, real_num1+real_num2+real_num3 real_num, amend_num FROM spt ' 
      +' WHERE prj_no='
      +''''+strPrj_No+''''
      +' AND stra_no='+''''+strStratum_No+''''
      +' AND sub_no='+''''+strSub_no+'''';
    iRecordCount := 0;
    real_num.lstValues.Clear;
    amend_num.lstValues.Clear;
    with MainDataModule.qryEarthSample do
      begin
        close;
        sql.Clear;
        sql.Add(strSQL);
        open;
        while not eof do
          begin
            inc(iRecordCount);
            real_num.lstValues.Add(FieldByName('real_num').AsString);
            amend_num.lstValues.Add(FieldByName('amend_num').AsString);
            next;
          end;
        close;
      end;
    if iRecordCount=0 then
      continue;
      
    //取得特征数
    getTeZhengShu(real_num, [tfBiaoGuan]);
    getTeZhengShu(amend_num, [tfBiaoGuan]);

  {******把平均值、标准差、变异系数、最大值、**********}
  {******最小值、样本值等插入特征数表TeZhengShuTmp ****}
    //
    strWhereClause := 'WHERE prj_no= '+''''+strPrj_No+'''' 
      +' AND stra_no='+''''+strStratum_No+''''
      +' AND sub_no='+ ''''+strSub_no+'''' + ' AND v_id=';
    strSetValue:='UPDATE TeZhengShuTmp SET ';
    //开始插入平均值
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.PingJunZhi) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.PingJunZhi) + strWhereClause + '1'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入标准差
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.BiaoZhunCha) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.BiaoZhunCha) + strWhereClause + '2'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入变异系数
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.BianYiXiShu) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.BianYiXiShu) + strWhereClause + '3'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入最大值
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.MaxValue) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.MaxValue) + strWhereClause + '4'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入最小值
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.MinValue) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.MinValue) + strWhereClause + '5'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;
      
    //开始插入样本值
    strSQL:= '';
    strSQL:=strSetValue + 'spt_real_num='+FloatToStr(real_num.SampleNum) +',' 
      + 'spt_amend_num='+FloatToStr(amend_num.SampleNum) + strWhereClause + '6'; 
    if not Update_oneRecord(MainDataModule.qrySectionTotal, strSQL) then 
      continue;    
  end;
  FreeStringList;

end;

procedure TWuLiLiXueForm.frxReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='prj_name' then
    if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
      ParValue:= g_ProjectInfo.prj_name
    else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
      ParValue:= g_ProjectInfo.prj_name_en;
end;

procedure TWuLiLiXueForm.JingLiChuTanShuJuFenCeng;
var
  iDrillCount,iStratumCount,i,j:integer;
  dTop,dBottom: double;
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
        sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
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
                if (strTmp<>'') and isFloat(strTmp) then
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
                  +FormatFloat('0.00',dqcAverage)+ ')';
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


procedure TWuLiLiXueForm.JingLiChuTanShuJuJiSuan;
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

procedure TWuLiLiXueForm.btnTongJiClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    //静力触探数据分层,计算毎层的fs和qc的平均值,将产生的数据插入临时表cpttmp
    JingLiChuTanShuJuFenCeng;
    //静力触探数据计算并剔除,(平均值、标准差、变异系数、最大值、最小值、样本值)
    JingLiChuTanShuJuJiSuan;
    //标贯数据分层
    BiaoGuanShuJuFenCeng;
    //标贯数据计算并剔除
    BiaoGuanShuJuJiSuan;
  finally
    screen.Cursor := crDefault;
  end;
end;

procedure TWuLiLiXueForm.btn_PrintClick(Sender: TObject);
var 
  strSQL: string;
begin
  MainDataModule.DropTableFromDB('WuLiLiXueXingZhiZhiBiao') ;
//yys edit at 2006/04/12 , 勘察院要求加上最大值和最小值，所以去除选择条件（v_id<4 or v_id=6）
  //strSQL:= 'SELECT * INTO WuLiLiXueXingZhiZhiBiao FROM TeZhengShuTmp Where v_id<4 or v_id=6 AND prj_no= '+''''+g_ProjectInfo.prj_no_ForSQL+'''';
  strSQL:= 'SELECT * INTO WuLiLiXueXingZhiZhiBiao FROM TeZhengShuTmp Where prj_no= '+''''+g_ProjectInfo.prj_no_ForSQL+'''';
  with MainDataModule.qryPublic do
  begin
    close;
    sql.Clear;
    sql.Add(strSQL);
    ExecSQL;
    close;
  end;

  if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
    strSQL:='SELECT id,prj_no,stra_no,sub_no,ea_name '
        +' FROM stratum_description'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' ORDER BY id'
  else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    strSQL:='SELECT st.id,st.prj_no,st.stra_no,st.sub_no,ISNULL(et.ea_name_en,'''') as ea_name '
        +' FROM stratum_description st, earthtype et'
        +' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND st.ea_name = et.ea_name'
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
  self.tblTeZhengShu.TableName :='WuLiLiXueXingZhiZhiBiao';
  tblTeZhengShu.MasterFields := 'prj_no;stra_no;sub_no';
  self.tblTeZhengShu.Open;
  if g_ProjectInfo.prj_ReportLanguage= trChineseReport then
    frxReport1.LoadFromFile(g_AppInfo.PathOfReports + 
      'WuLiLiXueXingZhiZhiBiaoTongJi.frf')
  else if g_ProjectInfo.prj_ReportLanguage= trEnglishReport then
    frxReport1.LoadFromFile(g_AppInfo.PathOfReports + 
      'WuLiLiXueXingZhiZhiBiaoTongJi_en.frf');
  frxReport1.Preview := PreviewForm.frxPreview1;
  if frxReport1.PrepareReport then
  begin
    frxReport1.ShowPreparedReport;
    PreviewForm.ShowModal;
  end;  
  
  self.tblSampleValue.Close;
  self.tblTeZhengShu.Close;
  self.qryStratum.Close;
end;

procedure TWuLiLiXueForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
end;

end.
