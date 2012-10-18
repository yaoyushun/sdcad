unit MainDM;

interface

uses
  SysUtils, Classes, DB, ADODB,dialogs;

type
  TMainDataModule = class(TDataModule)
    ADOConnection1: TADOConnection;
    qryProjects: TADOQuery;
    qryDrills: TADOQuery;
    qryDrill_type: TADOQuery;
    qryEarthType: TADOQuery;
    qryStratum: TADOQuery;
    qryDPT: TADOQuery;
    qryBorer: TADOQuery;
    qrySPT: TADOQuery;
    qryStratum_desc: TADOQuery;
    qryPublic: TADOQuery;
    qryDPTCoef: TADOQuery;
    qrySection: TADOQuery;
    qrySectionDrill: TADOQuery;
    qryCPT: TADOQuery;
    qryEarthSample: TADOQuery;
    qryCrossBoard: TADOQuery;
    qrySectionTotal: TADOQuery;
    qryFAcount: TADOQuery;
    qryLegend: TADOQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    
  public
    { Public declarations }
    function DropTableFromDB(aTableName : string):String;
    function Connect_Database(serverName,PortNo,UserName,Password:string):string;
  end;

var
  MainDataModule: TMainDataModule;

implementation

uses public_unit;

{$R *.dfm}

{ TMainDataModule }

function TMainDataModule.Connect_Database(serverName,PortNo, UserName,
  Password: string):string;
var
  strConn : string;
begin
//  strConn := 'Provider=SQLOLEDB.1;Persist Security Info=False;';
//  strConn := strConn + 'User ID=' + UserName + ';';
//  strConn := strConn + 'PassWord=' + PassWord + ';';
//  strConn := strConn + 'Initial Catalog=GeoSoft;' ;
//  strConn := strConn + 'Network Address=' + serverName+ ','+ PortNo+';';
//  strConn := strConn + 'Network Library=dbmssocn';

    strConn:='Provider=SQLOLEDB.1;';
    strConn:=strConn+'Data Source=';
    strConn:=strConn+ServerName;
    strConn:=strConn+';';
    strConn:=strConn+'Initial Catalog=GeoSoft;';
    strConn:=strConn+'User ID=';
    strConn:=strConn+UserName;
    strConn:=strConn+';';
    strConn:=strConn+'PASSWORD=';
    strConn:=strConn+Password;
    strConn:=strConn+';';

  ADOConnection1.ConnectionString := strConn;
  try
    ADOConnection1.Connected := true;
    result := '';
  except
    on e:exception do 
       begin
         if pos('ConnectionOpen',e.Message)<>0 then
            result := '数据库连接错误，请确定数据库存在并已经启动,端口号是否正确。'
         else if pos('Login failed',e.Message)<>0 then
            result := '登录失败，请检查用户名和密码！'
         else
            result := e.Message ;
       end;
     
  end; 
end;

procedure TMainDataModule.DataModuleDestroy(Sender: TObject);
begin
  ADOConnection1.Close;
end;

procedure TMainDataModule.DataModuleCreate(Sender: TObject);
var
  strRootPath: string;
begin
  strRootPath:= ExtractFilePath(ParamStr(0));
  g_AppInfo.PathOfReports:= strRootPath + 'report\';
  g_AppInfo.PathOfChartFile:= strRootPath + 'chart\';
  g_AppInfo.CadExeName := strRootPath + 'ProjectCAD\MiniCAD.exe';
  g_AppInfo.CadExeNameEn:= strRootPath + 'ProjectCAD\MiniCAD_EN.exe';
  g_AppInfo.PathOfIniFile := strRootPath + 'Server.ini';
  //在钻孔类型数据表中,单桥静力触探孔的编号是6,双桥静力触探孔的编号是7，
  //所以若此表有变动，要更新程序.
  g_ZKLXBianHao.ShuangQiao := '7';
  g_ZKLXBianHao.DanQiao :='6';
  g_ZKLXBianHao.XiaoZuanKong:='3';

  g_ProjectInfo := TProjectInfo.Create;
end;

function TMainDataModule.DropTableFromDB(aTableName: string): String;
var 
  strSQL: string;
begin
  strSQL:= 'DROP TABLE ' + aTableName;
  with qryPublic do
  begin
    close;
    sql.Clear;
    sql.Add(strSQL);
    try
        ExecSQL;
    except
    on e:exception do 
       begin
         result := e.Message ;
       end;
    end;
    close;
  end;

end;

end.
