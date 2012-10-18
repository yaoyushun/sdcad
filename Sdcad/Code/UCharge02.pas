unit UCharge02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ADODB, DB,ComObj, ComCtrls, Buttons,SUIForm,shellapi;

type
  TfrmCharge02 = class(TForm)
    ADO02: TADOQuery;
    ADO02_All: TADOQuery;
    GroupBox4: TGroupBox;
    BBPrj4: TBitBtn;
    STDir: TStaticText;
    BBPrj6: TBitBtn;
    ERP1: TEdit;
    BBPrj7: TBitBtn;
    pbCreateReport: TProgressBar;
    SEFDlg: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure BBPrj4Click(Sender: TObject);
    procedure BBPrj6Click(Sender: TObject);
    procedure BBPrj7Click(Sender: TObject);
  private
    { Private declarations }
    txtFile:textFile;
    strOutTxt:string;
    function getOneBoreInfo(strProjectCode: string;strBoreCode: string;var zhuantanland:Array of double):integer;
    function getAllBoreInfo(strProjectCode: string;intTag:integer):integer;
    function getStandardThroughInfo(strProjectCode: string):integer;    //计算标准贯入试验
    function getWhorlThroughInfo(strProjectCode: string):integer;       //计算螺文钻
    function getProveMeasureInfo(strProjectCode: string):integer;       //勘探点测量
    function getRomDustTestInfo(strProjectCode: string):integer;
    function getEarthWaterInfo(strProjectCode: string):integer;
    function WriteTEXTFile(strProjectCode: string;strFileName:string):integer;

  public
    { Public declarations }
  end;

var
  frmCharge02: TfrmCharge02;

implementation
   uses Expression02,public_unit,MainDM,UReconMap02,UExperiment02,
  UReconKT02, UReconEWS02,UReconYWCS02,OtherCharges02;
{$R *.dfm}
//得到当前项目所有钻孔(钻探)的数据(陆上,水上,单桥静力触探,双桥静力触探一样处理)
//strProjectCode:项目编号
//intTag:0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
function TfrmCharge02.getAllBoreInfo(strProjectCode:string;intTag:integer):integer;
var
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    zhuantanland_all:Array[0..99] of double;
    zhuantanland_one:Array[0..99] of double;
    intResult:integer;
    intRow,intCol:integer;
    strd_t_no:string;  //钻孔型号编号
    dblTmp:double;
begin
    //初始化结果数组
    for intRow:=0 to 99 do
    begin
        zhuantanland_one[intRow]:=0;
        zhuantanland_all[intRow]:=0;
    end;
    if intTag=0 then strd_t_no:='1,4,5';
    if intTag=1 then strd_t_no:='2';
    if intTag=7 then strd_t_no:='6';
    if intTag=12 then strd_t_no:='7';

    ADO02_All.Close;
    ADO02_All.SQL.Text:='select * from drills where prj_no='''+strProjectCode+''' and d_t_no in ('+strd_t_no+')';
    ADO02_All.Open;
    while not ADO02_All.Recordset.eof do
    begin
        intResult:=getOneBoreInfo(ADO02_All.fieldByName('prj_no').AsString,ADO02_All.fieldByName('drl_no').AsString,zhuantanland_one);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',0~10m,'+ FormatFloat('0.00',zhuantanland_one[0])+','+FormatFloat('0.00',zhuantanland_one[1])+','+FormatFloat('0.00',zhuantanland_one[2])+','+FormatFloat('0.00',zhuantanland_one[3])+','+FormatFloat('0.00',zhuantanland_one[4])+','+FormatFloat('0.00',zhuantanland_one[5]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',10~20m,'+ FormatFloat('0.00',zhuantanland_one[10])+','+FormatFloat('0.00',zhuantanland_one[11])+','+FormatFloat('0.00',zhuantanland_one[12])+','+FormatFloat('0.00',zhuantanland_one[13])+','+FormatFloat('0.00',zhuantanland_one[14])+','+FormatFloat('0.00',zhuantanland_one[15]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',20~30m,'+ FormatFloat('0.00',zhuantanland_one[20])+','+FormatFloat('0.00',zhuantanland_one[21])+','+FormatFloat('0.00',zhuantanland_one[22])+','+FormatFloat('0.00',zhuantanland_one[23])+','+FormatFloat('0.00',zhuantanland_one[24])+','+FormatFloat('0.00',zhuantanland_one[25]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',30~40m,'+ FormatFloat('0.00',zhuantanland_one[30])+','+FormatFloat('0.00',zhuantanland_one[31])+','+FormatFloat('0.00',zhuantanland_one[32])+','+FormatFloat('0.00',zhuantanland_one[33])+','+FormatFloat('0.00',zhuantanland_one[34])+','+FormatFloat('0.00',zhuantanland_one[35]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',40~50m,'+ FormatFloat('0.00',zhuantanland_one[40])+','+FormatFloat('0.00',zhuantanland_one[41])+','+FormatFloat('0.00',zhuantanland_one[42])+','+FormatFloat('0.00',zhuantanland_one[43])+','+FormatFloat('0.00',zhuantanland_one[44])+','+FormatFloat('0.00',zhuantanland_one[45]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',50~60m,'+ FormatFloat('0.00',zhuantanland_one[50])+','+FormatFloat('0.00',zhuantanland_one[51])+','+FormatFloat('0.00',zhuantanland_one[52])+','+FormatFloat('0.00',zhuantanland_one[53])+','+FormatFloat('0.00',zhuantanland_one[54])+','+FormatFloat('0.00',zhuantanland_one[55]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',60~80m,'+ FormatFloat('0.00',zhuantanland_one[60])+','+FormatFloat('0.00',zhuantanland_one[61])+','+FormatFloat('0.00',zhuantanland_one[62])+','+FormatFloat('0.00',zhuantanland_one[63])+','+FormatFloat('0.00',zhuantanland_one[64])+','+FormatFloat('0.00',zhuantanland_one[65]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',80~100m,'+ FormatFloat('0.00',zhuantanland_one[70])+','+FormatFloat('0.00',zhuantanland_one[71])+','+FormatFloat('0.00',zhuantanland_one[72])+','+FormatFloat('0.00',zhuantanland_one[73])+','+FormatFloat('0.00',zhuantanland_one[74])+','+FormatFloat('0.00',zhuantanland_one[75]);
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',100~160m,'+ FormatFloat('0.00',zhuantanland_one[80])+','+FormatFloat('0.00',zhuantanland_one[81])+','+FormatFloat('0.00',zhuantanland_one[82])+','+FormatFloat('0.00',zhuantanland_one[83])+','+FormatFloat('0.00',zhuantanland_one[84])+','+FormatFloat('0.00',zhuantanland_one[85]);
        Writeln(txtFile,strOuttxt);

        for intRow:=0 to 99 do
            zhuantanland_all[intRow]:=zhuantanland_all[intRow]+zhuantanland_one[intRow];
        ADO02_All.Next;
    end;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    //intTag:0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
    ExcelApplication1.Cells(9,4+intTag):=zhuantanland_all[0];       //钻探,陆上工作量(0~10米,I)
    ExcelApplication1.Cells(10,4+intTag):=zhuantanland_all[1];      //钻探,陆上工作量(0~10米,II)
    ExcelApplication1.Cells(11,4+intTag):=zhuantanland_all[2];      //钻探,陆上工作量(0~10米,III)
    ExcelApplication1.Cells(12,4+intTag):=zhuantanland_all[10];     //钻探,陆上工作量(10~20米,I)
    ExcelApplication1.Cells(13,4+intTag):=zhuantanland_all[11];     //钻探,陆上工作量(10~20米,II)
    ExcelApplication1.Cells(14,4+intTag):=zhuantanland_all[12];     //钻探,陆上工作量(10~20米,III)

    ExcelApplication1.Cells(15,4+intTag):=zhuantanland_all[20];     //钻探,陆上工作量(20~30米,I)
    ExcelApplication1.Cells(16,4+intTag):=zhuantanland_all[21];     //钻探,陆上工作量(20~30米,II)
    ExcelApplication1.Cells(17,4+intTag):=zhuantanland_all[22];     //钻探,陆上工作量(20~30米,III)
    ExcelApplication1.Cells(18,4+intTag):=zhuantanland_all[30];     //钻探,陆上工作量(30~40米,I)
    ExcelApplication1.Cells(19,4+intTag):=zhuantanland_all[31];     //钻探,陆上工作量(30~40米,II)
    ExcelApplication1.Cells(20,4+intTag):=zhuantanland_all[32];     //钻探,陆上工作量(30~40米,III)

    ExcelApplication1.Cells(21,4+intTag):=zhuantanland_all[40];     //钻探,陆上工作量(40~50米,I)
    ExcelApplication1.Cells(22,4+intTag):=zhuantanland_all[41];     //钻探,陆上工作量(40~50米,II)
    ExcelApplication1.Cells(23,4+intTag):=zhuantanland_all[42];     //钻探,陆上工作量(40~50米,III)

    ExcelApplication1.Cells(24,4+intTag):=zhuantanland_all[50];     //钻探,陆上工作量(50~60米,II)
    ExcelApplication1.Cells(25,4+intTag):=zhuantanland_all[51];     //钻探,陆上工作量(50~60米,III)
    ExcelApplication1.Cells(26,4+intTag):=zhuantanland_all[60];     //钻探,陆上工作量(60~80米,II)
    ExcelApplication1.Cells(27,4+intTag):=zhuantanland_all[61];     //钻探,陆上工作量(60~80米,III)

    ExcelApplication1.Cells(28,4+intTag):=zhuantanland_all[70];     //钻探,陆上工作量(80~100米,II)
    ExcelApplication1.Cells(29,4+intTag):=zhuantanland_all[71];     //钻探,陆上工作量(80~100米,III)
    ExcelApplication1.Cells(30,4+intTag):=zhuantanland_all[80];     //钻探,陆上工作量(100~160米,II)
    ExcelApplication1.Cells(31,4+intTag):=zhuantanland_all[81];     //钻探,陆上工作量(100~160米,III)
    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;

    Result:=0;
end;

//得到钻一个孔(钻探)的数据(陆上,水上一样处理)
function TfrmCharge02.getOneBoreInfo(strProjectCode: string;strBoreCode: string;var zhuantanland:Array of double):integer;
var
    intRow:integer;
    intCol:integer;
    dblCount:double;
    dblNow:double;
    dblNow_old:double;
    intClass:integer;
    intTag:integer;
    intLabel:Array[1..10] of integer;
    intTmp:integer;
    intClass_old:integer;
begin
   try
    ADO02.Close;
    ADO02.SQL.Text:='select * from stratum where prj_no='''+strProjectCode+''' and drl_no='''+strBoreCode+'''';
    ADO02.Open;
    dblCount:=0;
    dblNow:=0;
    intTag:=0;
    intTmp:=0;
    intClass_old:=0;
    intLabel[1]:=0;
    intLabel[2]:=10;
    intLabel[3]:=20;
    intLabel[4]:=30;
    intLabel[5]:=40;
    intLabel[6]:=50;
    intLabel[7]:=60;
    intLabel[8]:=80;
    intLabel[9]:=100;
    intLabel[10]:=160;
    //初始化结果数组
    for intRow:=0 to 99 do
        zhuantanland[intRow] := 0;

    intRow:=0;
    while not ADO02.Recordset.eof do
        begin
            //ShowMessage(ADO02.fieldByName('prj_no').AsString+','+ADO02.FieldByName('drl_no').AsString+','+ADO02.FieldByName('stra_no').AsString+','+ADO02.FieldByName('sub_no').AsString+','+ADO02.FieldByName('ea_name').AsString+','+ADO02.FieldByName('stra_depth').AsString+','+ADO02.FieldByName('description').AsString+','+ADO02.FieldByName('stra_category').AsString);
            dblNow:=ADO02.fieldByName('stra_depth').Value;
            dblNow_old:=dblNow;
            intTag:=0;
             for intClass:=1 to 9 do
             begin
                //intLabel[intClass]~intLabel[intClass+1]米范围*******************************************************************************
                //dblNow全部落在intLabel[intClass]~intLabel[intClass+1]米范围内
                intClass_old:=intClass;
                if ((dblCount=intLabel[intClass]) and (dblNow<=intLabel[intClass+1]) and (intTmp=0)) or ((dblNow>intLabel[intClass]) and (dblNow_old<=intLabel[intClass+1])) then
                begin
                    if (intTag=0) then
                    begin
                        dblNow:=dblNow-dblCount;
                        intTag:=1;
                    end;
                    //ShowMessage(IntToStr(intClass));
                    case ADO02.fieldByName('stra_category').Value of
                    0:
                        zhuantanland[(intClass-1)*10+0]:=zhuantanland[(intClass-1)*10+0]+ dblNow;
                    1:
                        zhuantanland[(intClass-1)*10+1]:=zhuantanland[(intClass-1)*10+1]+ dblNow;
                    2:
                        zhuantanland[(intClass-1)*10+2]:=zhuantanland[(intClass-1)*10+2]+ dblNow;
                    3:
                        zhuantanland[(intClass-1)*10+3]:=zhuantanland[(intClass-1)*10+3]+ dblNow;
                    4:
                        zhuantanland[(intClass-1)*10+4]:=zhuantanland[(intClass-1)*10+4]+ dblNow;
                    5:
                        zhuantanland[(intClass-1)*10+5]:=zhuantanland[(intClass-1)*10+5]+ dblNow;
                    6:
                        zhuantanland[(intClass-1)*10+6]:=zhuantanland[(intClass-1)*10+6]+ dblNow;
                    7:
                        zhuantanland[(intClass-1)*10+7]:=zhuantanland[(intClass-1)*10+7]+ dblNow;
                    else
                    end;
                    dblCount:=dblCount+dblNow;
                    dblNow:=0;
                end;
                //dblNow一部分落在intLabel[intClass]~intLabel[intClass+1]米范围内
                if ((dblCount>=intLabel[intClass]) and (dblCount<intLabel[intClass+1]) and (dblNow_old>intLabel[intClass+1])) then
                begin
                    if (intTag=0) then
                    begin
                        dblNow:=dblNow-dblCount;
                        intTag:=1;
                    end;
                        if (intTmp=1) then
                        begin

                            case ADO02.fieldByName('stra_category').Value of
                            0:
                                zhuantanland[(intClass-1)*10+0]:=zhuantanland[(intClass-1)*10+0]+ intLabel[intClass+1]-intLabel[intClass];
                            1:
                                zhuantanland[(intClass-1)*10+1]:=zhuantanland[(intClass-1)*10+1]+ intLabel[intClass+1]-intLabel[intClass];
                            2:
                                zhuantanland[(intClass-1)*10+2]:=zhuantanland[(intClass-1)*10+2]+ intLabel[intClass+1]-intLabel[intClass];
                            3:
                                zhuantanland[(intClass-1)*10+3]:=zhuantanland[(intClass-1)*10+3]+ intLabel[intClass+1]-intLabel[intClass];
                            4:
                                zhuantanland[(intClass-1)*10+4]:=zhuantanland[(intClass-1)*10+4]+ intLabel[intClass+1]-intLabel[intClass];
                            5:
                                zhuantanland[(intClass-1)*10+5]:=zhuantanland[(intClass-1)*10+5]+ intLabel[intClass+1]-intLabel[intClass];
                            6:
                                zhuantanland[(intClass-1)*10+6]:=zhuantanland[(intClass-1)*10+6]+ intLabel[intClass+1]-intLabel[intClass];
                            7:
                                zhuantanland[(intClass-1)*10+7]:=zhuantanland[(intClass-1)*10+7]+ intLabel[intClass+1]-intLabel[intClass];
                            else
                            end;
                            dblNow:=dblNow-(intLabel[intClass+1]-intLabel[intClass]);
                            dblCount:=intLabel[intClass+1];
                            intTag:=1;
                            intClass_old:=intClass_old+1;
                            if (dblNow>=(intLabel[intClass_old+1]-intLabel[intClass_old])) then
                            intTmp:=1
                            else
                            inttmp:=0;
                        end
                        else
                        begin
                           case ADO02.fieldByName('stra_category').Value of
                            0:
                                zhuantanland[(intClass-1)*10+0]:=zhuantanland[(intClass-1)*10+0]+ intLabel[intClass+1]-dblCount;
                            1:
                                zhuantanland[(intClass-1)*10+1]:=zhuantanland[(intClass-1)*10+1]+ intLabel[intClass+1]-dblCount;
                            2:
                                zhuantanland[(intClass-1)*10+2]:=zhuantanland[(intClass-1)*10+2]+ intLabel[intClass+1]-dblCount;
                            3:
                                zhuantanland[(intClass-1)*10+3]:=zhuantanland[(intClass-1)*10+3]+ intLabel[intClass+1]-dblCount;
                            4:
                                zhuantanland[(intClass-1)*10+4]:=zhuantanland[(intClass-1)*10+4]+ intLabel[intClass+1]-dblCount;
                            5:
                                zhuantanland[(intClass-1)*10+5]:=zhuantanland[(intClass-1)*10+5]+ intLabel[intClass+1]-dblCount;
                            6:
                                zhuantanland[(intClass-1)*10+6]:=zhuantanland[(intClass-1)*10+6]+ intLabel[intClass+1]-dblCount;
                            7:
                                zhuantanland[(intClass-1)*10+7]:=zhuantanland[(intClass-1)*10+7]+ intLabel[intClass+1]-dblCount;
                            else
                            end;
                            dblNow:=dblNow-(intLabel[intClass+1]-dblCount);
                            dblCount:=intLabel[intClass+1];
                            intTag:=1;
                            if (dblNow>=(intLabel[intClass_old+1]-intLabel[intClass_old])) then
                            intTmp:=1
                            else
                            inttmp:=0;
                            end;
             end;
             end;
            intRow:=intRow+1;
            ADO02.Next;
        end;
        ADO02.Close;
   except
      exit;
   end;
   result:=0;
end;

//取土,水样
function TfrmCharge02.getEarthWaterInfo(strProjectCode: string):integer;
var
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    dblCount:Array[1..10] of double;
begin
    //取土,水样(硬土层<=50米)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and (d_t_no=1 or d_t_no=2) and comp_depth<=50';
    ADO02.Open;
    dblCount[1]:=ADO02.fieldByName('Num').Value;

    //取土,水样(硬土层>50米)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and (d_t_no=1 or d_t_no=2) and comp_depth>50';
    ADO02.Open;
    dblCount[2]:=ADO02.fieldByName('Num').Value;

    //扰动样
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where drl_no in(select drl_no from earthsample where prj_no='''+ strProjectCode + ''' and (wet_density=0 or wet_density is null or zip_coef=0 or zip_coef is null or zip_modulus=0 or zip_modulus is null or cohesion=0 or cohesion is null)) and prj_no='''+strProjectCode+'''';
    ADO02.Open;
    dblCount[3]:=ADO02.fieldByName('Num').Value;


    //水样
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and d_t_no=2';
    ADO02.Open;
    dblCount[4]:=ADO02.fieldByName('Num').Value;

    //土样
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and d_t_no=1';
    ADO02.Open;
    dblCount[5]:=ADO02.fieldByName('Num').Value;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(8,21):=dblCount[1];
    ExcelApplication1.Cells(10,21):=dblCount[2];
    ExcelApplication1.Cells(12,21):=dblCount[3];
    ExcelApplication1.Cells(13,21):=dblCount[4];
    ExcelApplication1.Cells(14,21):=dblCount[5];

    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;

//标准贯入试验
function TfrmCharge02.getStandardThroughInfo(strProjectCode: string):integer;
var
    intMore50:integer;
    intLess50:integer;
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    strSQL: string;
begin
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and d_t_no=4 and comp_depth<=50';
    ADO02.Open;
    intLess50:=ADO02.fieldByName('Num').Value;

    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+''' and d_t_no=4 and comp_depth>50';
    ADO02.Open;
    intMore50:=ADO02.fieldByName('Num').Value;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    //intTag:0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
    ExcelApplication1.Cells(18,21):=intMore50;
    ExcelApplication1.Cells(20,21):=intLess50;
    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;

//螺文钻
function TfrmCharge02.getWhorlThroughInfo(strProjectCode: string):integer;
var
    strdrl_no:string;
    dblNow:double;
    dblCount:double;
    intLess50:integer;
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    strSQL: string;
    dblWhorlValue:Array[1..8] of double;
begin
    ADO02.Close;
    ADO02.SQL.Text:='select * from stratum where drl_no in (select drl_no from drills where prj_no='''+ strProjectCode + ''' and d_t_no=3) and prj_no='''+strProjectCode+''' order by prj_no,drl_no,stra_depth';
    ADO02.Open;
    dblCount:=0;
    strdrl_no:='';
    while not ADO02.Recordset.eof do
    begin
        if (ADO02.fieldByName('drl_no').asstring<>strdrl_no) then
        begin
            dblCount:=0;
        end;
        dblNow:=ADO02.fieldByName('stra_depth').Value;
        dblNow:=dblNow-dblCount;
        case  ADO02.fieldByName('stra_category').Value of
            0:dblWhorlValue[1]:= dblWhorlValue[1]+dblNow;
            1:dblWhorlValue[2]:= dblWhorlValue[2]+dblNow;
            2:dblWhorlValue[3]:= dblWhorlValue[3]+dblNow;
            3:dblWhorlValue[4]:= dblWhorlValue[4]+dblNow;
            4:dblWhorlValue[5]:= dblWhorlValue[5]+dblNow;
            5:dblWhorlValue[6]:= dblWhorlValue[6]+dblNow;
            6:dblWhorlValue[7]:= dblWhorlValue[7]+dblNow;
            7:dblWhorlValue[8]:= dblWhorlValue[8]+dblNow;
        end;
        dblCount:=dblCount+dblNow;
        strdrl_no:=ADO02.fieldByName('drl_no').AsString;
        ADO02.Next;
    end;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(25,21):=dblWhorlValue[1];
    ExcelApplication1.Cells(26,21):=dblWhorlValue[2];
    ExcelApplication1.Cells(27,21):=dblWhorlValue[3];
    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;

//勘探点测量
function TfrmCharge02.getProveMeasureInfo(strProjectCode: string):integer;
var
    intCount:integer;
    intLess50:integer;
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    strSQL: string;
begin
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from drills where prj_no='''+strProjectCode+'''';
    ADO02.Open;
    intCount:=ADO02.fieldByName('Num').Value;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(31,21):=intCount;
    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;

//室内土试验费
function TfrmCharge02.getRomDustTestInfo(strProjectCode: string):integer;
var
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    dblearthsample:Array[1..10] of double;
begin
    //含水量
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and aquiferous_rate is not null';
    ADO02.Open;
    dblearthSample[1]:=ADO02.fieldByName('Num').Value;  //含水量

    //容重
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and aquiferous_rate is not null';
    ADO02.Open;
    dblearthSample[2]:=ADO02.fieldByName('Num').Value;  //容重

    //液限
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and liquid_limit is not null';
    ADO02.Open;
    dblearthSample[3]:=ADO02.fieldByName('Num').Value;  //液限

    //塑限
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and shape_limit is not null';
    ADO02.Open;
    dblearthSample[4]:=ADO02.fieldByName('Num').Value;  //塑限

    //比重
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and soil_proportion is not null';
    ADO02.Open;
    dblearthSample[5]:=ADO02.fieldByName('Num').Value;  //比重

    //直剪(快剪)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and shear_type=0';
    ADO02.Open;
    dblearthSample[6]:=ADO02.fieldByName('Num').Value;  //直剪(快剪)

    //直剪(固快)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample where prj_no='''+strProjectCode+''' and shear_type=1';
    ADO02.Open;
    dblearthSample[7]:=ADO02.fieldByName('Num').Value;  //直剪(固快)

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:='c:\XMJS041018_02.xls';
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(19,29):=dblearthSample[1];
    //ExcelApplication1.Cells(20,27):=dblearthSample[2];
    ExcelApplication1.Cells(21,29):=dblearthSample[3];
    ExcelApplication1.Cells(22,29):=dblearthSample[4];
    ExcelApplication1.Cells(23,29):=dblearthSample[5];
    ExcelApplication1.Cells(24,29):=dblearthSample[6];
    ExcelApplication1.Cells(25,29):=dblearthSample[7];
    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;
function TfrmCharge02.WriteTEXTFile(strProjectCode: string;strFileName:string):integer;
var
    i : integer;
    F: TextFile;
    S: string;
begin
    AssignFile(F, strFileName);
    Rewrite(F);

    For i := 1 To 3 Do
    begin
        S:='aaaaaaaaaaaaaa';
        Writeln(F, S);
    end;
    CloseFile(F);
    result:=0;
end;

procedure TfrmCharge02.Button1Click(Sender: TObject);
var
    intResult:integer;
begin
    AssignFile(txtFile, 'c:\2004.txt');
    Rewrite(txtFile);
    strOutTxt:='工程名称(编号):';
    Writeln(txtFile,strOuttxt);
    strOutTxt:='建设单位:';
    Writeln(txtFile,strOuttxt);
    strOutTxt:='孔号,深度,I,II,III,IV,V,VI';
    Writeln(txtFile,strOuttxt);

   //钻探(陆上)
   intResult:=getAllBoreInfo('2004-K-202-3',0);
   //钻探(水上)
   intResult:=getAllBoreInfo('2004-K-202-3',1);
   //单桥静力触探
   intResult:=getAllBoreInfo('2004-K-202-3',7);
   //双桥静力触探
   intResult:=getAllBoreInfo('2004-K-202-3',12);
   strOutTxt:='孔号,原状样(<=30),原状样(>30),扰动样,标贯(<=20),标贯(>20<=50),标贯(>50),含水量,容量,液塑限,压缩,剪切,颗发';
   Writeln(txtFile,strOuttxt);
   //取土,水样
   intResult:=getEarthWaterInfo('2004-K-202-3');
   //标准贯入试验
   intResult:=getStandardThroughInfo('2004-K-202-3');
   //螺文钻
   intResult:=getWhorlThroughInfo('2004-K-202-3');
   //勘探点测量
   intResult:=getProveMeasureInfo('2004-K-202-3');
   //室内土试验费
   intResult:=getRomDustTestInfo('2004-K-202-3');
   //输出TEXT文件
   CloseFile(txtFile);
   end;

procedure TfrmCharge02.BBPrj4Click(Sender: TObject);
var
    intResult:integer;
begin
    pbCreateReport.min:=0;
    pbCreateReport.Max:=110;
    pbCreateReport.Step:=10;
    AssignFile(txtFile, 'c:\2004.txt');
    Rewrite(txtFile);
    strOutTxt:='工程名称(编号):';
    Writeln(txtFile,strOuttxt);
    strOutTxt:='建设单位:';
    Writeln(txtFile,strOuttxt);
    strOutTxt:='孔号,深度,I,II,III,IV,V,VI';
    Writeln(txtFile,strOuttxt);
   pbCreateReport.Position:=10;
   //钻探(陆上)
   intResult:=getAllBoreInfo('2004-K-202-3',0);
   pbCreateReport.Position:=20;
   //钻探(水上)
   intResult:=getAllBoreInfo('2004-K-202-3',1);
   pbCreateReport.Position:=30;
   //单桥静力触探
   intResult:=getAllBoreInfo('2004-K-202-3',7);
   pbCreateReport.Position:=40;
   //双桥静力触探
   intResult:=getAllBoreInfo('2004-K-202-3',12);
   strOutTxt:='孔号,原状样(<=30),原状样(>30),扰动样,标贯(<=20),标贯(>20<=50),标贯(>50),含水量,容量,液塑限,压缩,剪切,颗发';
   Writeln(txtFile,strOuttxt);
   pbCreateReport.Position:=50;
   //取土,水样
   intResult:=getEarthWaterInfo('2004-K-202-3');
   pbCreateReport.Position:=60;
   //标准贯入试验
   intResult:=getStandardThroughInfo('2004-K-202-3');
   pbCreateReport.Position:=70;
   //螺文钻
   intResult:=getWhorlThroughInfo('2004-K-202-3');
   pbCreateReport.Position:=80;
   //勘探点测量
   intResult:=getProveMeasureInfo('2004-K-202-3');
   pbCreateReport.Position:=90;
   //室内土试验费
   intResult:=getRomDustTestInfo('2004-K-202-3');
   pbCreateReport.Position:=100;
   //输出TEXT文件
   CloseFile(txtFile);
   pbCreateReport.Position:=110;
   end;


procedure TfrmCharge02.BBPrj6Click(Sender: TObject);
var
   SaveFName:string;
begin
   SEFDlg.DefaultExt :='xls';
   SEFDlg.Title :=FILE_SAVE_TITLE;
   SEFDlg.FileName :=trim(erp1.text);
   SEFDlg.Filter :=FILE_SAVE_FILTER;
   if not SEFDlg.Execute then exit;
   SaveFName:=SEFDlg.FileName ;
   erp1.text:=SaveFName;
end;

procedure TfrmCharge02.BBPrj7Click(Sender: TObject);
var
   sfName:string;
begin
   sfName:=trim(ERP1.Text);
   if fileexists(sfName) then
      shellexecute(application.Handle,PAnsiChar(''),PAnsiChar(sfName),PAnsiChar(''),PAnsiChar(''),SW_SHOWNORMAL)
   else
      Application.Messagebox(FILE_NOTEXIST,HINT_TEXT, MB_ICONEXCLAMATION + mb_Ok);
end;

end.
