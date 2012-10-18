unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls,Dialogs, StdCtrls, ADODB, DB,ComObj,  Buttons,shellapi,
  ExtCtrls;

type
  TfrmCharge02 = class(TForm)
    ADO02: TADOQuery;
    ADO02_All: TADOQuery;
    SEFDlg: TSaveDialog;
    ADOMax: TADOQuery;
    GroupBox4: TGroupBox;
    btnCreateReport: TBitBtn;
    STDir: TStaticText;
    btnBrowse: TBitBtn;
    ERP1: TEdit;
    btnOpenReport: TBitBtn;
    pbCreateReport: TProgressBar;
    procedure btnCreateReportClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnOpenReportClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    txtFile:textFile;
    strOutTxt:string;
    strProjectNo:string;
    strProjectName:string;
    strBuilderName:string;
    strPath:string;
    intUseRow:integer;
    intUseRow1:integer;
    intUseRow2:integer;
    intUseRow3:integer;
    intUseRow4:integer;
    intUseRowMax:integer;
    intPublicTag:integer; //0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
    zhuantanland_all:Array[0..999] of double;
    zhuantanland_one:Array[0..999] of double;
    strRecord:Array[0..12] of tstrings;
    intoverMax:integer;//超过标准深度的段数
    intoverMax_Max:integer;//当前工程中超过标准深度的最大段数
    intoverNum:integer;
    m_intClass_Max:integer;
    function getOneBoreInfo(strProjectCode: string;strBoreCode: string):integer;
    function getAllBoreInfo(strProjectCode: string;intTag:integer):integer;
    function getStandardThroughInfo(strProjectCode: string):integer;    //计算标准贯入试验
    function getWhorlThroughInfo(strProjectCode: string):integer;       //计算螺文钻
    function getProveMeasureInfo(strProjectCode: string):integer;       //勘探点测量
    function getRomDustTestInfo(strProjectCode: string):integer;
    function getEarthWaterInfo(strProjectCode: string):integer;
    function WritetxtFile():integer;
  public
    { Public declarations }

  end;

var
  frmCharge02: TfrmCharge02;

implementation
   uses public_unit,MainDM;
{$R *.dfm}
//得到当前项目所有钻孔(钻探)的数据(陆上,水上,单桥静力触探,双桥静力触探一样处理)
//strProjectCode:项目编号
//intTag:0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
function TfrmCharge02.getAllBoreInfo(strProjectCode:string;intTag:integer):integer;
var
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    range,sheet:Variant;
    xlsFileName:string;
    intResult:integer;
    intRow,intCol:integer;
    strd_t_no:string;  //钻孔型号编号
    dblTmp:double;
    i:integer;
    intRecordTag:integer;
begin
    //初始化结果数组
    intPublicTag:=intTag;
    intoverMax:=0;
    for intRow:=0 to 999 do
    begin
        zhuantanland_one[intRow]:=0;
        zhuantanland_all[intRow]:=0;
    end;

    if intTag=0 then strd_t_no:='1,4,5';
    if intTag=1 then strd_t_no:='2';
    if intTag=7 then strd_t_no:='6';
    if intTag=12 then strd_t_no:='7';

    ADO02_All.Close;
    ADO02_All.SQL.Text:='select * from drills where can_juesuan=0 and prj_no='''+strProjectCode+''' and d_t_no in ('+strd_t_no+')';
    ADO02_All.Open;
    intRecordTag:=0;
    while not ADO02_All.Recordset.eof do
    begin
        intoverMax:=0;
        intResult:=getOneBoreInfo(ADO02_All.fieldByName('prj_no').AsString,ADO02_All.fieldByName('drl_no').AsString);
        intRecordTag:=intRecordTag+1;

        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',0~10m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[0]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[1]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[2]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[3]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[4]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[5]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',10~20m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[10]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[11]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[12]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[13]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[14]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[15]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',20~30m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[20]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[21]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[22]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[23]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[24]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[25]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',30~40m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[30]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[31]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[32]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[33]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[34]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[35]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',40~50m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[40]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[41]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[42]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[43]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[44]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[45]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',50~60m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[50]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[51]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[52]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[53]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[54]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[55]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',60~80m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[60]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[61]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[62]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[63]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[64]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[65]));
        Writeln(txtFile,strOuttxt);
        strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',80~100m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[70]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[71]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[72]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[73]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[74]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[75]));
        Writeln(txtFile,strOuttxt);
        if (intPublicTag=0) or (intPublicTag=1) then
        begin
            strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+',100~160m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[80]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[81]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[82]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[83]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[84]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[85]));
            Writeln(txtFile,strOuttxt);
            for intRow:=10 to m_intClass_Max do
            begin
                strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+','+PCHAR(FormatFloat('0',(160+(intRow-9)*20))) +'~'+PCHAR(FormatFloat('0',(160+(intRow-8)*20)))+'m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+1]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+2]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+3]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+4]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+5]));
                Writeln(txtFile,strOuttxt);
            end;
        end;

        if ((intPublicTag=7) or (intPublicTag=12)) and (m_intClass_Max>9) then
        begin
            for intRow:=10 to m_intClass_Max do
            begin
                strOutTxt:=ADO02_All.fieldByName('drl_no').AsString+','+PCHAR(FormatFloat('0',(100+(intRow-9)*20))) +'~'+PCHAR(FormatFloat('0',(120+(intRow-8)*20)))+'m,'+ PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+1]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+2]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+3]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+4]))+','+PCHAR(FormatFloat('0.00',zhuantanland_one[intRow*10+5]));
                Writeln(txtFile,strOuttxt);
            end;
        end;


        for intRow:=0 to 999 do
            zhuantanland_all[intRow]:=zhuantanland_all[intRow]+zhuantanland_one[intRow];

       ADO02_All.Next;
    end;
    if (intRecordTag=0) then
    begin
        Result:=0;
        exit;
    end;
    for intRow:=0 to 999 do
    zhuantanland_all[intRow]:=StrtoFloat(FormatFloat('0.00',zhuantanland_all[intRow]));

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:=ERP1.Text;
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);
    //工程编号和单位名称
    ExcelApplication1.Cells(3,6):= strProjectNo;
    ExcelApplication1.Cells(4,6):=strProjectName;
    //intTag:0-陆上,1-水上,7-单桥静力触探,12-双桥静力触探
    intRow:=0;
    if (intTag=7) or (intTag=12) then intRow:=2;
    ExcelApplication1.Cells(9,4+intTag):=zhuantanland_all[0];       //钻探,陆上工作量(0~10米,I)
    ExcelApplication1.Cells(10,4+intTag):=zhuantanland_all[1];      //钻探,陆上工作量(0~10米,II)
    ExcelApplication1.Cells(11,4+intTag):=zhuantanland_all[2];      //钻探,陆上工作量(0~10米,III)
    if (intTag=7) or (intTag=12) then
    begin
        ExcelApplication1.Cells(12,4+intTag):=zhuantanland_all[3];      //钻探,陆上工作量(0~10米,IV)
        ExcelApplication1.Cells(13,4+intTag):=zhuantanland_all[4];      //钻探,陆上工作量(0~10米,V)
    end;
    ExcelApplication1.Cells(12+intRow,4+intTag):=zhuantanland_all[10];     //钻探,陆上工作量(10~20米,I)
    ExcelApplication1.Cells(13+intRow,4+intTag):=zhuantanland_all[11];     //钻探,陆上工作量(10~20米,II)
    ExcelApplication1.Cells(14+intRow,4+intTag):=zhuantanland_all[12];     //钻探,陆上工作量(10~20米,III)

    ExcelApplication1.Cells(15+intRow,4+intTag):=zhuantanland_all[20];     //钻探,陆上工作量(20~30米,I)
    ExcelApplication1.Cells(16+intRow,4+intTag):=zhuantanland_all[21];     //钻探,陆上工作量(20~30米,II)
    ExcelApplication1.Cells(17+intRow,4+intTag):=zhuantanland_all[22];     //钻探,陆上工作量(20~30米,III)
    ExcelApplication1.Cells(18+intRow,4+intTag):=zhuantanland_all[30];     //钻探,陆上工作量(30~40米,I)
    ExcelApplication1.Cells(19+intRow,4+intTag):=zhuantanland_all[31];     //钻探,陆上工作量(30~40米,II)
    ExcelApplication1.Cells(20+intRow,4+intTag):=zhuantanland_all[32];     //钻探,陆上工作量(30~40米,III)

    ExcelApplication1.Cells(21+intRow,4+intTag):=zhuantanland_all[40];     //钻探,陆上工作量(40~50米,I)
    ExcelApplication1.Cells(22+intRow,4+intTag):=zhuantanland_all[41];     //钻探,陆上工作量(40~50米,II)
    ExcelApplication1.Cells(23+intRow,4+intTag):=zhuantanland_all[42];     //钻探,陆上工作量(40~50米,III)

    ExcelApplication1.Cells(24+intRow,4+intTag):=zhuantanland_all[50];     //钻探,陆上工作量(50~60米,I)
    ExcelApplication1.Cells(25+intRow,4+intTag):=zhuantanland_all[51];     //钻探,陆上工作量(50~60米,II)
    ExcelApplication1.Cells(26+intRow,4+intTag):=zhuantanland_all[52];     //钻探,陆上工作量(50~60米,III)

    ExcelApplication1.Cells(27+intRow,4+intTag):=zhuantanland_all[60];     //钻探,陆上工作量(60~80米,I)
    ExcelApplication1.Cells(28+intRow,4+intTag):=zhuantanland_all[61];     //钻探,陆上工作量(60~80米,II)
    ExcelApplication1.Cells(29+intRow,4+intTag):=zhuantanland_all[62];     //钻探,陆上工作量(60~80米,III)

    ExcelApplication1.Cells(30+intRow,4+intTag):=zhuantanland_all[70];     //钻探,陆上工作量(80~100米,I)
    ExcelApplication1.Cells(31+intRow,4+intTag):=zhuantanland_all[71];     //钻探,陆上工作量(80~100米,II)
    ExcelApplication1.Cells(32+intRow,4+intTag):=zhuantanland_all[72];     //钻探,陆上工作量(80~100米,III)

    if (intTag<>7) and (intTag<>12) then
    begin
        ExcelApplication1.Cells(33+intRow,4+intTag):=zhuantanland_all[81];     //钻探,陆上工作量(100~160米,II)
        ExcelApplication1.Cells(34+intRow,4+intTag):=zhuantanland_all[82]     //钻探,陆上工作量(100~160米,III)
    end;

    if (intTag=0) and (m_intClass_Max<>0) then
    begin
        for i:=10 to intoverMax do
        begin
            Sheet:= ExcelApplication1.Activesheet;
            ExcelWorkbook1.Application.Rows[35+intUseRow1*3].insert;
            ExcelWorkbook1.Application.Rows[35+intUseRow1*3].insert;
            ExcelWorkbook1.Application.Rows[35+intUseRow1*3].insert;

            ExcelApplication1.Cells(35+intUseRow1*3,3):='I';
            ExcelApplication1.Cells[35+intUseRow1*3,3].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+1,3):='II';
            ExcelApplication1.Cells[35+intUseRow1*3+1,3].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+2,3):='III';
            ExcelApplication1.Cells[35+intUseRow1*3+2,3].Borders.LineStyle:=1;

            ExcelApplication1.Cells(35+intUseRow1*3+1,6):='=R[-3]C*1.2';
            ExcelApplication1.Cells[35+intUseRow1*3+1,6].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+2,6):='=R[-3]C*1.2';
            ExcelApplication1.Cells[35+intUseRow1*3+2,6].Borders.LineStyle:=1;

            ExcelApplication1.Cells(35+intUseRow1*3,7):='=RC[-3]*RC[-1]';
            ExcelApplication1.Cells[35+intUseRow1*3,7].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3,8):='=RC[-3]*RC[-2]';
            ExcelApplication1.Cells[35+intUseRow1*3,8].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+1,7):='=RC[-3]*RC[-1]';
            ExcelApplication1.Cells[35+intUseRow1*3+1,7].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+1,8):='=RC[-3]*RC[-2]';
            ExcelApplication1.Cells[35+intUseRow1*3+1,8].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+2,7):='=RC[-3]*RC[-1]';
            ExcelApplication1.Cells[35+intUseRow1*3+2,7].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+2,8):='=RC[-3]*RC[-2]';
            ExcelApplication1.Cells[35+intUseRow1*3+2,8].Borders.LineStyle:=1;

            ExcelApplication1.Cells(35+intUseRow1*3,4):=zhuantanland_all[(intUseRow1+9)*10];
            ExcelApplication1.Cells[35+intUseRow1*3,4].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+1,4):=zhuantanland_all[(intUseRow1+9)*10+1];
            ExcelApplication1.Cells[35+intUseRow1*3+1,4].Borders.LineStyle:=1;
            ExcelApplication1.Cells(35+intUseRow1*3+2,4):=zhuantanland_all[(intUseRow1+9)*10+2];
            ExcelApplication1.Cells[35+intUseRow1*3+2,4].Borders.LineStyle:=1;
            //合并单元格

            Range:= ExcelApplication1.Range[sheet.cells[35+intUseRow1*3,2],sheet.cells[35+intUseRow1*3+2,2]];
            Range.merge;
            Range.FormulaR1C1:=PCHAR(FormatFloat('0',(160+intUseRow1*20))) + '~'+PCHAR(FormatFloat('0',(180+intUseRow1*20)))+' m';//合并后写入文本
            //合并单元格
            Range.Borders.LineStyle:=1;//加边框
            intUseRow1:=intUseRow1+1;
        end;
        if intUseRowMax<intUseRow1 then intUseRowMax:=intUseRow1;
    end;

    if (intTag=1)  and (m_intClass_Max<>0) then
    begin
        for i:=10 to intoverMax do
        begin
            if (i>intoverMax_Max) or (i>intUseRowMax+9) then
            begin
                ExcelWorkbook1.Application.Rows[35+intUseRow2*3].insert;
                ExcelWorkbook1.Application.Rows[35+intUseRow2*3].insert;
                ExcelWorkbook1.Application.Rows[35+intUseRow2*3].insert;

                ExcelApplication1.Cells(35+intUseRow2*3,3):='I';
                ExcelApplication1.Cells[35+intUseRow2*3,3].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+1,3):='II';
                ExcelApplication1.Cells[35+intUseRow2*3+1,3].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,3):='III';
                ExcelApplication1.Cells[35+intUseRow2*3+2,3].Borders.LineStyle:=1;

                ExcelApplication1.Cells(35+intUseRow2*3+1,6):='=R[-3]C*1.2';
                ExcelApplication1.Cells[35+intUseRow2*3+1,6].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,6):='=R[-3]C*1.2';
                ExcelApplication1.Cells[35+intUseRow2*3+2,6].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3,7):='=RC[-3]*RC[-1]';
                ExcelApplication1.Cells[35+intUseRow2*3,7].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3,8):='=RC[-3]*RC[-2]';
                ExcelApplication1.Cells[35+intUseRow2*3,8].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+1,7):='=RC[-3]*RC[-1]';
                ExcelApplication1.Cells[35+intUseRow2*3+1,7].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+1,8):='=RC[-3]*RC[-2]';
                ExcelApplication1.Cells[35+intUseRow2*3+1,8].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,7):='=RC[-3]*RC[-1]';
                ExcelApplication1.Cells[35+intUseRow2*3+2,7].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,8):='=RC[-3]*RC[-2]';
                ExcelApplication1.Cells[35+intUseRow2*3+2,8].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3,5):=zhuantanland_all[(intUseRow2+9)*10];
                ExcelApplication1.Cells[35+intUseRow2*3,5].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+1,5):=zhuantanland_all[(intUseRow2+9)*10+1];
                ExcelApplication1.Cells[35+intUseRow2*3+1,5].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,5):=zhuantanland_all[(intUseRow2+9)*10+2];
                ExcelApplication1.Cells[35+intUseRow2*3+2,5].Borders.LineStyle:=1;
                //合并单元格
                Sheet:= ExcelApplication1.Activesheet;
                Range:= ExcelApplication1.Range[sheet.cells[35+intUseRow2*3,2],sheet.cells[35+intUseRow2*3+2,2]];
                Range.merge;
                Range.FormulaR1C1:=PCHAR(FormatFloat('0',(160+intUseRow2*20))) + '~'+PCHAR(FormatFloat('0',(180+intUseRow2*20)))+' m';//合并后写入文本
                //合并单元格
                Range.Borders.LineStyle:=1;//加边框
                intUseRow2:=intUseRow2+1
            end
            else
            begin
                ExcelApplication1.Cells(35+intUseRow2*3,5):=zhuantanland_all[(intUseRow2+9)*10];
                ExcelApplication1.Cells[35+intUseRow2*3,5].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+1,5):=zhuantanland_all[(intUseRow2+9)*10+1];
                ExcelApplication1.Cells[35+intUseRow2*3+1,5].Borders.LineStyle:=1;
                ExcelApplication1.Cells(35+intUseRow2*3+2,5):=zhuantanland_all[(intUseRow2+9)*10+2];
                ExcelApplication1.Cells[35+intUseRow2*3+2,5].Borders.LineStyle:=1;
                intUseRow2:=intUseRow2+1;
            end;
         end;
         if intUseRowMax<intUseRow2 then intUseRowMax:=intUseRow2;
    end;

    if (intTag=7)  and (m_intClass_Max<>0) then
    begin
        for i:=9  to intoverMax do
            begin
                if  (i>intoverMax_Max) or (i>intUseRowMax+8) then
                begin
                    ExcelWorkbook1.Application.Rows[35+intUseRow3*3].insert;
                    ExcelWorkbook1.Application.Rows[35+intUseRow3*3].insert;
                    ExcelWorkbook1.Application.Rows[35+intUseRow3*3].insert;

                    ExcelApplication1.Cells(35+intUseRow3*3,10):='I';
                    ExcelApplication1.Cells[35+intUseRow3*3,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,10):='II';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,10):='III';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,12):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,12].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,12):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,12].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3,11):=zhuantanland_all[(intUseRow3+8)*10];
                    ExcelApplication1.Cells[35+intUseRow3*3,11].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,11):=zhuantanland_all[(intUseRow3+8)*10+1];
                    ExcelApplication1.Cells[35+intUseRow3*3+1,11].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,11):=zhuantanland_all[(intUseRow3+8)*10+2];
                    ExcelApplication1.Cells[35+intUseRow3*3+2,11].Borders.LineStyle:=1;
                    //合并单元格
                    Sheet:= ExcelApplication1.Activesheet;
                    Range:= ExcelApplication1.Range[sheet.cells[35+intUseRow3*3,9],sheet.cells[35+intUseRow3*3+2,9]];
                    Range.merge;
                    Range.FormulaR1C1:=PCHAR(FormatFloat('0',(100+intUseRow3*20))) + '~'+PCHAR(FormatFloat('0',(120+intUseRow3*20)))+' m';//合并后写入文本
                    //合并单元格
                    Range.Borders.LineStyle:=1;//加边框
                    intUseRow3:=intUseRow3+1
                end
                else
                begin

                    ExcelApplication1.Cells(35+intUseRow3*3,10):='I';
                    ExcelApplication1.Cells[35+intUseRow3*3,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,10):='II';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,10):='III';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,10].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,12):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,12].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,12):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,12].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3+1,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,13):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow3*3+2,13].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3,11):=zhuantanland_all[(intUseRow3+8)*10];
                    ExcelApplication1.Cells[35+intUseRow3*3,11].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+1,11):=zhuantanland_all[(intUseRow3+8)*10+1];
                    ExcelApplication1.Cells[35+intUseRow3*3+1,11].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow3*3+2,11):=zhuantanland_all[(intUseRow3+8)*10+2];
                    ExcelApplication1.Cells[35+intUseRow3*3+2,11].Borders.LineStyle:=1;

                    //合并单元格
                    Sheet:= ExcelApplication1.Activesheet;
                    Range:= ExcelApplication1.Range[sheet.cells[35+intUseRow3*3,9],sheet.cells[35+intUseRow3*3+2,9]];
                    Range.merge;
                    Range.FormulaR1C1:=PCHAR(FormatFloat('0',(100+intUseRow3*20))) + '~'+PCHAR(FormatFloat('0',(120+intUseRow3*20)))+' m';//合并后写入文本
                    //合并单元格
                    Range.Borders.LineStyle:=1;//加边框
                    intUseRow3:=intUseRow3+1
                end;
            end;
          if intUseRowMax<intUseRow3 then intUseRowMax:=intUseRow3;
        end;


    if (intTag=12)  and (m_intClass_Max<>0) then
    begin
        for i:=9  to intoverMax do
            begin
                if  (i>intoverMax_Max) or (i>intUseRowMax+8) then
                begin
                    ExcelWorkbook1.Application.Rows[32+intUseRow4*3].insert;
                    ExcelWorkbook1.Application.Rows[32+intUseRow4*3].insert;
                    ExcelWorkbook1.Application.Rows[32+intUseRow4*3].insert;

                    ExcelApplication1.Cells(32+intUseRow4*3,15):='I';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+1,15):='II';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+2,15):='III';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(32+intUseRow4*3,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[32+intUseRow4*3,17].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+1,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[32+intUseRow4*3+1,17].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+2,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[32+intUseRow4*3+2,17].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(32+intUseRow4*3,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[32+intUseRow4*3,18].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+1,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[32+intUseRow4*3+1,18].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(32+intUseRow4*3+2,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[32+intUseRow4*3+2,18].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(32+intUseRow4*3,16):=zhuantanland_all[(intUseRow4+8)*10];
                    ExcelApplication1.Cells(32+intUseRow4*3+1,16):=zhuantanland_all[(intUseRow4+8)*10+1];
                    ExcelApplication1.Cells(32+intUseRow4*3+2,16):=zhuantanland_all[(intUseRow4+8)*10+2];

                    //合并单元格
                    Sheet:= ExcelApplication1.Activesheet;
                    Range:= ExcelApplication1.Range[sheet.cells[32+intUseRow4*3,14],sheet.cells[32+intUseRow4*3+2,14]];
                    Range.merge;
                    Range.FormulaR1C1:=PCHAR(FormatFloat('0',(100+intUseRow4*20))) + '~'+PCHAR(FormatFloat('0',(120+intUseRow4*20)))+' m';//合并后写入文本
                    Range.Borders.LineStyle:=1;//加边框
                    //合并单元格
                    intUseRow4:=intUseRow4+1;
                end
                else
                begin
                    ExcelApplication1.Cells(35+intUseRow4*3,15):='I';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+1,15):='II';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+2,15):='III';
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(35+intUseRow4*3,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow4*3,17].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+1,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow4*3+1,17].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+2,17):='=R[-3]C*1.2';
                    ExcelApplication1.Cells[35+intUseRow4*3+2,17].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(35+intUseRow4*3,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow4*3,18].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+1,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow4*3+1,18].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+2,18):='=RC[-2]*RC[-1]';
                    ExcelApplication1.Cells[35+intUseRow4*3+2,18].Borders.LineStyle:=1;

                    ExcelApplication1.Cells(35+intUseRow4*3,16):=zhuantanland_all[(intUseRow4+8)*10];
                    ExcelApplication1.Cells[35+intUseRow4*3,15].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+1,16):=zhuantanland_all[(intUseRow4+8)*10+1];
                    ExcelApplication1.Cells[35+intUseRow4*3+1,16].Borders.LineStyle:=1;
                    ExcelApplication1.Cells(35+intUseRow4*3+2,16):=zhuantanland_all[(intUseRow4+8)*10+2];
                    ExcelApplication1.Cells[35+intUseRow4*3+2,16].Borders.LineStyle:=1;

                    //合并单元格
                    Sheet:= ExcelApplication1.Activesheet;
                    Range:= ExcelApplication1.Range[sheet.cells[32+intUseRow4*3,14],sheet.cells[32+intUseRow4*3+2,14]];
                    Range.merge;
                    Range.FormulaR1C1:=PCHAR(FormatFloat('0',(100+intUseRow4*20))) + '~'+PCHAR(FormatFloat('0',(120+intUseRow4*20)))+' m';//合并后写入文本
                    //合并单元格
                    Range.Borders.LineStyle:=1;//加边框
                    intUseRow4:=intUseRow4+1
                end;
            end;
          if intUseRowMax<intUseRow4 then intUseRowMax:=intUseRow4;
        end;

    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;

    Result:=0;
end;

//得到钻一个孔(钻探)的数据(陆上,水上一样处理)
function TfrmCharge02.getOneBoreInfo(strProjectCode: string;strBoreCode: string):integer;
var
    i:integer;
    intRow:integer;
    intCol:integer;
    dblCount:double;
    dblNow:double;
    dblNow_old:double;
    intClass:integer;
    intTag:integer;
    dblSum:double;
    intLabel:Array[1..999] of integer;
    intTmp:integer;
    intClass_old:integer;
    dblDepthMax:double;
begin
   try
    dblDepthMax:=0;
    dblSum:=0;
    m_intClass_Max:=0;

    ADO02.Close;
    ADO02.SQL.Text:='select * from stratum '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and drl_no='''+stringReplace(strBoreCode ,'''','''''',[rfReplaceAll])+''' order by stra_depth';
    ADO02.Open;

    ADOMax.Close;
    ADOMax.SQL.Text:='select max(stra_depth) as maxDepth from stratum '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and drl_no='''+stringReplace(strBoreCode ,'''','''''',[rfReplaceAll])+'''';
    ADOMax.Open;


    dblDepthMax:=ADOMax.fieldByName('maxDepth').AsFloat;
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
    if (intPublicTag=0) or (intPublicTag=1) then
    begin
        intLabel[10]:=160;
        for intRow:=11 to 999 do
            intLabel[intRow]:=intLabel[intRow-1]+20;
    end;
    if (intPublicTag=7) or (intPublicTag=12) then
    begin
        intLabel[10]:=120;
        for intRow:=11 to 999 do
            intLabel[intRow]:=intLabel[intRow-1]+20;
    end;
    //初始化结果数组
    for intRow:=0 to 999 do
        zhuantanland_one[intRow] := 0;

    intRow:=0;
    while not ADO02.Recordset.eof do
        begin
            dblNow:=ADO02.fieldByName('stra_depth').Value;
            dblNow_old:=dblNow;
            intTag:=0;
            dblNow:=dblNow-dblSum;
            for intClass:=1 to 999 do
            begin
                //intLabel[intClass]~intLabel[intClass+1]米范围*******************************************************************************
                //dblNow全部落在intLabel[intClass]~intLabel[intClass+1]米范围内
                intClass_old:=intClass;
                if (intTag=0) then
                begin
                    dblNow:=dblNow-dblCount;
                    intTag:=1;
                    intTmp:=0;
                end;
                if ((dblCount=intLabel[intClass]) and (dblNow<=(intLabel[intClass+1]-intLabel[intClass])) and (intTmp=0)) or ((dblNow_old>intLabel[intClass]) and (dblNow_old<=intLabel[intClass+1])) then
                begin

                    //ShowMessage(IntToStr(intClass));
                    case ADO02.fieldByName('stra_category').Value of
                    0:
                        zhuantanland_one[(intClass-1)*10+0]:=zhuantanland_one[(intClass-1)*10+0]+ dblNow;
                    1:
                        zhuantanland_one[(intClass-1)*10+1]:=zhuantanland_one[(intClass-1)*10+1]+ dblNow;
                    2:
                        zhuantanland_one[(intClass-1)*10+2]:=zhuantanland_one[(intClass-1)*10+2]+ dblNow;
                    3:
                        zhuantanland_one[(intClass-1)*10+3]:=zhuantanland_one[(intClass-1)*10+3]+ dblNow;
                    4:
                        zhuantanland_one[(intClass-1)*10+4]:=zhuantanland_one[(intClass-1)*10+4]+ dblNow;
                    5:
                        zhuantanland_one[(intClass-1)*10+5]:=zhuantanland_one[(intClass-1)*10+5]+ dblNow;
                    6:
                        zhuantanland_one[(intClass-1)*10+6]:=zhuantanland_one[(intClass-1)*10+6]+ dblNow;
                    7:
                        zhuantanland_one[(intClass-1)*10+7]:=zhuantanland_one[(intClass-1)*10+7]+ dblNow;
                    else
                    end;
                    if intoverMax_Max<(intClass-1) then intoverMax_Max:=intClass-1;
                    if intoverMax<(intClass-1) then intoverMax:=intClass-1;
                    m_intClass_Max:=intClass-1;
                    dblCount:=dblCount+dblNow;
                    dblNow:=0;
                end;
                //dblNow一部分落在intLabel[intClass]~intLabel[intClass+1]米范围内

                if ((dblCount>=intLabel[intClass]) and (dblCount<intLabel[intClass+1]) and (dblNow_old>intLabel[intClass+1])) then
                begin
                        if (intTmp=1) then
                        begin
                            case ADO02.fieldByName('stra_category').Value of
                            0:
                                zhuantanland_one[(intClass-1)*10+0]:=zhuantanland_one[(intClass-1)*10+0]+ intLabel[intClass+1]-intLabel[intClass];
                            1:
                                zhuantanland_one[(intClass-1)*10+1]:=zhuantanland_one[(intClass-1)*10+1]+ intLabel[intClass+1]-intLabel[intClass];
                            2:
                                zhuantanland_one[(intClass-1)*10+2]:=zhuantanland_one[(intClass-1)*10+2]+ intLabel[intClass+1]-intLabel[intClass];
                            3:
                                zhuantanland_one[(intClass-1)*10+3]:=zhuantanland_one[(intClass-1)*10+3]+ intLabel[intClass+1]-intLabel[intClass];
                            4:
                                zhuantanland_one[(intClass-1)*10+4]:=zhuantanland_one[(intClass-1)*10+4]+ intLabel[intClass+1]-intLabel[intClass];
                            5:
                                zhuantanland_one[(intClass-1)*10+5]:=zhuantanland_one[(intClass-1)*10+5]+ intLabel[intClass+1]-intLabel[intClass];
                            6:
                                zhuantanland_one[(intClass-1)*10+6]:=zhuantanland_one[(intClass-1)*10+6]+ intLabel[intClass+1]-intLabel[intClass];
                            7:
                                zhuantanland_one[(intClass-1)*10+7]:=zhuantanland_one[(intClass-1)*10+7]+ intLabel[intClass+1]-intLabel[intClass];
                            else
                            end;
                            dblNow:=dblNow-(intLabel[intClass+1]-intLabel[intClass]);
                            dblCount:=intLabel[intClass+1];
                            intTag:=1;
                            intClass_old:=intClass_old+1;
                            if intoverMax_Max<(intClass-1) then intoverMax_Max:=intClass-1;
                            if intoverMax<(intClass-1) then intoverMax:=intClass-1;
                            m_intClass_Max:=intClass-1;

                            if (dblNow>(intLabel[intClass_old+1]-intLabel[intClass_old])) then
                                intTmp:=1
                            else
                                inttmp:=0;
                        end
                        else
                        begin
                           case ADO02.fieldByName('stra_category').Value of
                            0:
                                zhuantanland_one[(intClass-1)*10+0]:=zhuantanland_one[(intClass-1)*10+0]+ intLabel[intClass+1]-dblCount;
                            1:
                                zhuantanland_one[(intClass-1)*10+1]:=zhuantanland_one[(intClass-1)*10+1]+ intLabel[intClass+1]-dblCount;
                            2:
                                zhuantanland_one[(intClass-1)*10+2]:=zhuantanland_one[(intClass-1)*10+2]+ intLabel[intClass+1]-dblCount;
                            3:
                                zhuantanland_one[(intClass-1)*10+3]:=zhuantanland_one[(intClass-1)*10+3]+ intLabel[intClass+1]-dblCount;
                            4:
                                zhuantanland_one[(intClass-1)*10+4]:=zhuantanland_one[(intClass-1)*10+4]+ intLabel[intClass+1]-dblCount;
                            5:
                                zhuantanland_one[(intClass-1)*10+5]:=zhuantanland_one[(intClass-1)*10+5]+ intLabel[intClass+1]-dblCount;
                            6:
                                zhuantanland_one[(intClass-1)*10+6]:=zhuantanland_one[(intClass-1)*10+6]+ intLabel[intClass+1]-dblCount;
                            7:
                                zhuantanland_one[(intClass-1)*10+7]:=zhuantanland_one[(intClass-1)*10+7]+ intLabel[intClass+1]-dblCount;
                            else
                            end;
                            dblNow:=dblNow-(intLabel[intClass+1]-dblCount);
                            dblCount:=intLabel[intClass+1];
                            intClass_old:=intClass_old+1;

                            if intoverMax_Max<(intClass-1) then intoverMax_Max:=intClass-1;
                            if intoverMax<(intClass-1) then intoverMax:=intClass-1;

                            m_intClass_Max:=intClass-1;
                            intTag:=1;
                            if (dblNow>(intLabel[intClass_old+1]-intLabel[intClass_old])) then
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
      result:=1;
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
    i:integer;
begin
    //得到所有指定工程的所有的孔号
    ADO02.Close;
    ADO02.SQL.Text:='select * from drills where can_juesuan=0 and prj_no='''+ strProjectCode + ''' order by drl_no';
    ADO02.Open;
    while not ADO02.eof do
    begin
        strRecord[0].Add(ADO02.fieldByName('drl_no').AsString);
        ADO02.Next;
    end;

    //取土,水样(捶击法<=30米)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and s_depth_begin <=30 and prj_no='''+ strProjectCode + ''' and (not wet_density is null);';
    ADO02.Open;
    dblCount[1]:=ADO02.fieldByName('Num').Value;

    //TXT 数据/////////////////////
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as Num from earthsample '+
                'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                'and s_depth_begin <=30 '+
                'and prj_no='''+ strProjectCode + ''' and (not wet_density is null) '+
                'group by drl_no order by drl_no';
    ADO02.Open;

    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[1].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[1].Add('0');
    end;
    strRecord[1].Add(floattostr(dblCount[1]));

    //取土,水样(捶击法>30米)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and s_depth_begin>30 and prj_no='''+ strProjectCode + ''' and (not wet_density is null);';

    ADO02.Open;
    dblCount[2]:=ADO02.fieldByName('Num').Value;

    //TXT 数据/////////////////////
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as Num from earthsample '+
                    'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                    'and s_depth_begin >30 '+
                    'and prj_no='''+ strProjectCode + ''' and (not wet_density is null) '+
                    'group by drl_no order by drl_no';
    ADO02.Open;

    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[2].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[2].Add('0');
    end;
    strRecord[2].Add(floattostr(dblCount[2]));

    //扰动样
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+ strProjectCode + ''' and wet_density is null;';
    ADO02.Open;
    dblCount[3]:=ADO02.fieldByName('Num').Value;



    //得到TXT里的扰动样StrRecord[2]
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no=''' + strProjectCode + ''' and (wet_density is null) group by drl_no order by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[3].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[3].Add('0');
    end;
    strRecord[3].Add(floattostr(dblCount[3]));

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:=ERP1.Text;;
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(8,21):=dblCount[1];
    ExcelApplication1.Cells(10,21):=dblCount[2];
    ExcelApplication1.Cells(12,21):=dblCount[3];

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
    intguanbiao:Array[1..9] of integer;
    ExcelApplication1:Variant;
    ExcelWorkbook1:Variant;
    xlsFileName:string;
    strSQL: string;
    i:integer;
begin
    for i:=1 to 9 do
      intguanbiao[i]:=0;

    ADO02.Close;
    ADO02.SQL.Text:='select spt.*,stratum.stra_category from spt join stratum '+
                      'on spt.prj_no=stratum.prj_no and spt.drl_no=stratum.drl_no '+
                      'and spt.stra_no=stratum.stra_no and spt.sub_no=stratum.sub_no '+
                      'where spt.drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                      'and spt.prj_no='''+strProjectCode+'''';
    ADO02.Open;

    while not ADO02.eof do
    begin
        if (ADO02.FieldByName('begin_depth').AsFloat<=20.0) and (ADO02.FieldByName('stra_category').AsInteger=0) then intguanbiao[1]:=intguanbiao[1]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat<=20.0) and (ADO02.FieldByName('stra_category').AsInteger=1) then intguanbiao[2]:=intguanbiao[2]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat<=20.0) and (ADO02.FieldByName('stra_category').AsInteger=2) then intguanbiao[3]:=intguanbiao[3]+1;

        if (ADO02.FieldByName('begin_depth').AsFloat>20.0) and (ADO02.FieldByName('begin_depth').AsFloat<=50.0) and (ADO02.FieldByName('stra_category').AsInteger=0) then
        intguanbiao[4]:=intguanbiao[4]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat>20.0) and (ADO02.FieldByName('begin_depth').AsFloat<=50.0) and (ADO02.FieldByName('stra_category').AsInteger=1) then
        intguanbiao[5]:=intguanbiao[5]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat>20.0) and (ADO02.FieldByName('begin_depth').AsFloat<=50.0) and (ADO02.FieldByName('stra_category').AsInteger=2) then
        intguanbiao[6]:=intguanbiao[6]+1;

        if (ADO02.FieldByName('begin_depth').AsFloat>50.0) and (ADO02.FieldByName('stra_category').AsInteger=0) then intguanbiao[7]:=intguanbiao[7]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat>50.0) and (ADO02.FieldByName('stra_category').AsInteger=1) then intguanbiao[8]:=intguanbiao[8]+1;
        if (ADO02.FieldByName('begin_depth').AsFloat>50.0) and (ADO02.FieldByName('stra_category').AsInteger=2) then intguanbiao[9]:=intguanbiao[9]+1;
        ADO02.Next;
    end;
    //标贯(<=20)/////////////////////
    ADO02.Close;
    ADO02.SQL.Text:='select spt.drl_no,count(spt.drl_no) as num from spt join stratum '+
                    'on spt.prj_no=stratum.prj_no and '+
                    'spt.drl_no=stratum.drl_no and spt.stra_no=stratum.stra_no '+
                    'and spt.sub_no=stratum.sub_no where spt.begin_depth<=20 '+
                    'and spt.drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                    'and spt.prj_no=''' + strProjectCode + ''' group by spt.drl_no order by spt.drl_no';
    ADO02.Open;

    for i:=0 to strRecord[0].Count-1 do
    begin
      if strRecord[0][i]=ADO02.FieldByName('drl_no').AsString then
      begin
          strRecord[4].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[4].Add('0');
    end;
    strRecord[4].Add(floattostr(intguanbiao[1]+intguanbiao[2]+intguanbiao[3]));

    //标贯(>20<=50)//////////////////////
    ADO02.Close;
    ADO02.SQL.Text:='select spt.drl_no,count(spt.drl_no) as num from spt join stratum '+
                    'on spt.prj_no=stratum.prj_no and '+
                    'spt.drl_no=stratum.drl_no and spt.stra_no=stratum.stra_no '+
                    'and spt.sub_no=stratum.sub_no where spt.begin_depth>20 and spt.begin_depth<=50'+
                    'and spt.drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                    'and spt.prj_no=''' + strProjectCode + ''' group by spt.drl_no order by spt.drl_no';
    ADO02.Open;

    for i:=0 to strRecord[0].Count-1 do
    begin
      if strRecord[0][i]=ADO02.FieldByName('drl_no').AsString then
      begin
          strRecord[5].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[5].Add('0');
    end;
    strRecord[5].Add(floattostr(intguanbiao[4]+intguanbiao[5]+intguanbiao[6]));

    //标贯(>50)//////////////////////
    ADO02.Close;
    ADO02.SQL.Text:='select spt.drl_no,count(spt.drl_no) as num from spt join stratum '+
                    'on spt.prj_no=stratum.prj_no and '+
                    'spt.drl_no=stratum.drl_no and spt.stra_no=stratum.stra_no '+
                    'and spt.sub_no=stratum.sub_no where spt.begin_depth>50 '+
                    'and spt.drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
                    'and spt.prj_no=''' + strProjectCode + ''' group by spt.drl_no order by spt.drl_no';
    ADO02.Open;

    for i:=0 to strRecord[0].Count-1 do
    begin
      if strRecord[0][i]=ADO02.FieldByName('drl_no').AsString then
      begin
          strRecord[6].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[6].Add('0');
    end;
    strRecord[6].Add(floattostr(intguanbiao[7]+intguanbiao[8]+intguanbiao[9]));

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:=ERP1.Text;
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(18,21):=intguanbiao[1];
    ExcelApplication1.Cells(19,21):=intguanbiao[2];
    ExcelApplication1.Cells(20,21):=intguanbiao[3];
    ExcelApplication1.Cells(21,21):=intguanbiao[4];
    ExcelApplication1.Cells(22,21):=intguanbiao[5];
    ExcelApplication1.Cells(23,21):=intguanbiao[6];
    ExcelApplication1.Cells(24,21):=intguanbiao[7];
    ExcelApplication1.Cells(25,21):=intguanbiao[8];
    ExcelApplication1.Cells(26,21):=intguanbiao[9];

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
    ADO02.SQL.Text:='select * from stratum where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+ strProjectCode + ''' and d_t_no=3) and prj_no='''+strProjectCode+''' order by prj_no,drl_no,stra_depth';
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
    xlsFileName:=ERP1.Text;
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);
    ExcelApplication1.Cells(30,21):=(dblWhorlValue[1]+dblWhorlValue[2]+dblWhorlValue[3]);
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
    ADO02.SQL.Text:='select count(*) as Num from drills where can_juesuan=0 and prj_no='''+strProjectCode+'''';
    ADO02.Open;
    intCount:=ADO02.fieldByName('Num').Value;

    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:=ERP1.text;
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
    dblearthsample:Array[1..12] of double;
    i:integer;
begin
    //含水量
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and aquiferous_rate is not null';
    ADO02.Open;
    dblearthSample[1]:=ADO02.fieldByName('Num').Value;  //含水量
    //TXT文件含水量strRecord[7]
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and aquiferous_rate is not null group by drl_no order by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[7].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[7].Add('0');
    end;
    strRecord[7].Add(floattostr(dblearthSample[1]));

    //容重
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and wet_density is not null';
    ADO02.Open;
    dblearthSample[2]:=ADO02.fieldByName('Num').Value;  //容重

    //TXT文件容重strRecord[8]
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and wet_density is not null group by drl_no order by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[8].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[8].Add('0');
    end;
    strRecord[8].Add(floattostr(dblearthSample[2]));

    //液限
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and liquid_limit is not null';
    ADO02.Open;
    dblearthSample[3]:=ADO02.fieldByName('Num').Value;  //液限

    //塑限
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and shape_limit is not null';
    ADO02.Open;
    dblearthSample[4]:=ADO02.fieldByName('Num').Value;  //塑限

    //TXT文件液塑限strRecord[9]
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and liquid_limit is not null and shape_limit is not null group by drl_no order by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[9].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[9].Add('0');
    end;
    strRecord[9].Add(floattostr(dblearthSample[3]));

    //比重
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and soil_proportion is not null';
    ADO02.Open;
    dblearthSample[5]:=ADO02.fieldByName('Num').Value;  //比重

    //直剪(快剪)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and cohesion is not null';
    ADO02.Open;
    dblearthSample[6]:=ADO02.fieldByName('Num').Value;  //直剪(快剪)

    //直剪(固快)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and cohesion_gk is not null';
    ADO02.Open;
    dblearthSample[7]:=ADO02.fieldByName('Num').Value;  //直剪(固快)

    //TXT文件剪切strRecord[9]-----直剪(快剪)
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (cohesion is not null) group by drl_no';
    ADO02.Open;
    //TXT文件剪切strRecord[9]-----直剪(固快)
    ADO02_ALL.Close;
    ADO02_ALL.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (cohesion_gk is not null) group by drl_no';
    ADO02_ALL.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if (UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString)) and (UpperCase(strRecord[0][i])=UpperCase(ADO02_ALL.FieldByName('drl_no').AsString)) then
      begin
          strRecord[11].Add(inttostr(ADO02.FieldByName('num').Value+ADO02_ALL.FieldByName('num').Value));
          ADO02.Next;
          ADO02_ALL.Next;
      end
      else if (UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString)) and (UpperCase(strRecord[0][i])<>UpperCase(ADO02_ALL.FieldByName('drl_no').AsString)) then
      begin
          strRecord[11].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else if (UpperCase(strRecord[0][i])<>UpperCase(ADO02.FieldByName('drl_no').AsString)) and (UpperCase(strRecord[0][i])=UpperCase(ADO02_ALL.FieldByName('drl_no').AsString)) then
      begin
          strRecord[11].Add(ADO02_ALL.FieldByName('num').AsString);
          ADO02_ALL.Next;
      end
      else
          strRecord[11].Add('0');
    end;

    strRecord[11].Add(floattostr(dblearthSample[6]+dblearthSample[7]));

    //压缩(常速)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (zip_coef is not null or zip_modulus is not null);';
    ADO02.Open;
    dblearthSample[11]:=ADO02.fieldByName('Num').Value;  //压缩(常速)

    //TXT文件 压缩(常速)
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (zip_coef is not null or zip_modulus is not null) group by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[10].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[10].Add('0');
    end;
    strRecord[10].Add(floattostr(dblearthSample[11]));




    //颗分(比重计)
    ADO02.Close;
    ADO02.SQL.Text:='select count(*) as Num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (sand_big is not null or sand_middle is not null or sand_small is not null or powder_big is not null or powder_small is not null or clay_grain is not null or li is not null)';
    ADO02.Open;
    dblearthSample[12]:=ADO02.fieldByName('Num').Value;  //颗分(比重计)
    //TXT 数据 颗分(比重计)
    ADO02.Close;
    ADO02.SQL.Text:='select drl_no,count(*) as num from earthsample '+
            'where drl_no in (select drl_no from drills where can_juesuan=0 and prj_no='''+strProjectCode+''') '+
            'and prj_no='''+strProjectCode+''' and (sand_big is not null or sand_middle is not null or sand_small is not null or powder_big is not null or powder_small is not null or clay_grain is not null or li is not null) group by drl_no';
    ADO02.Open;
    for i:=0 to strRecord[0].Count-1 do
    begin
      if UpperCase(strRecord[0][i])=UpperCase(ADO02.FieldByName('drl_no').AsString) then
      begin
          strRecord[12].Add(ADO02.FieldByName('num').AsString);
          ADO02.Next;
      end
      else
          strRecord[12].Add('0');
    end;
    strRecord[12].Add(floattostr(dblearthSample[12]));


    //写入EXCEL文件
    ExcelApplication1:=CreateOleObject('Excel.Application');
    ExcelWorkbook1:=CreateOleobject('Excel.Sheet');
    xlsFileName:=ERP1.Text;
    ExcelWorkbook1:=ExcelApplication1.workBooks.Open(xlsFileName);

    ExcelApplication1.Cells(19,29):=dblearthSample[1];
    ExcelApplication1.Cells(20,29):=dblearthSample[2];
    ExcelApplication1.Cells(21,29):=dblearthSample[3];
    ExcelApplication1.Cells(22,29):=dblearthSample[4];
    ExcelApplication1.Cells(23,29):=dblearthSample[5];
    ExcelApplication1.Cells(24,29):=dblearthSample[6];
    ExcelApplication1.Cells(25,29):=dblearthSample[7];
    ExcelApplication1.Cells(26,29):=dblearthSample[11];
    ExcelApplication1.Cells(20,36):=dblearthSample[12];


    ExcelWorkbook1.Save;
    ExcelWorkbook1.Close;
    ExcelApplication1.Quit;
    ExcelApplication1:=Unassigned;
    result:=0;
end;

function TfrmCharge02.WritetxtFile():integer;
var
    i:integer;
    j:integer;
    strText:string;
begin
    for i:=0 to strRecord[0].Count do
    begin
        if i=strRecord[0].Count then
            strText :='总计'+','+strRecord[1][i]+','+strRecord[2][i]+','+
                      strRecord[3][i]+','+strRecord[4][i]+','+
                      strRecord[5][i]+','+  strRecord[6][i]+','+
                      strRecord[7][i]+','+  strRecord[8][i]+','+
                      strRecord[9][i]+','+strRecord[10][i]+','+ strRecord[11][i]+','+
                      strRecord[12][i]
        else
            strText :=strRecord[0][i]+','+strRecord[1][i]+','+strRecord[2][i]+','+
                      strRecord[3][i]+','+strRecord[4][i]+','+
                      strRecord[5][i]+','+  strRecord[6][i]+','+
                      strRecord[7][i]+','+  strRecord[8][i]+','+
                      strRecord[9][i]+','+strRecord[10][i]+','+ strRecord[11][i]+
                      ','+strRecord[12][i];
        Writeln(txtFile,strText);
    end;
    result:=0;
end;

procedure TfrmCharge02.btnCreateReportClick(Sender: TObject);
var
    strPath:string;
    intResult:integer;
    i:integer;
begin
    if pos('.xls',ERP1.Text)=0 then ERP1.Text:=ERP1.TEXT+'.xls';

    i:=Length(trim(ERP1.text));
    repeat
        if copy(trim(ERP1.text),i,1)='\' then
        begin
          strPath:=copy(Trim(ERP1.text),1,i);
          i:=0;
        end;
        i:=i-1;
    until i<=0;
    if not DirectoryExists(strPath) then   ForceDirectories(strPath);

    if not FileExists(pChar(ERP1.text)) then
    begin
        copyfile(pChar(ExtractFileDir(Application.Exename)+'\XLS\XMJS041018_02.xls'),PChar(ERP1.text),true);
    end;
    for i:=0 to 12 do
        strRecord[i]:=TStringList.create;



    pbCreateReport.min:=0;
    pbCreateReport.Max:=110;
    pbCreateReport.Step:=10;
    intUseRow1:=0;
    intUseRow2:=0;
    intUseRow3:=0;
    intUseRow4:=0;
    intUseRowMax:=-1;
    AssignFile(txtFile, stringReplace(ERP1.Text,'.xls','.txt',[rfReplaceAll, rfIgnoreCase]));
    Rewrite(txtFile);
    //台头信息/////////////////////////////////////////
    ADO02.SQL.Text:='select prj_no,prj_name,area_name,builder,begin_date,end_date,prj_grade,consigner from projects'+
                    ' where prj_no=''' + strProjectNo+'''';
    ADO02.Open;
    strProjectName:=ADO02.FieldByName('prj_name').AsString;
    strBuilderName:=ADO02.FieldByName('builder').AsString;
    //台头信息/////////////////////////////////////////
    strOutTxt:='工程名称(编号):  '+strProjectName+'       ('+strProjectNo+')';
    Writeln(txtFile,strOuttxt);
    strOutTxt:='建设单位:        '+strBuilderName;
    Writeln(txtFile,strOuttxt);
    strOutTxt:='孔号,深度,I,II,III,IV,V,VI';
    Writeln(txtFile,strOuttxt);
   pbCreateReport.Position:=10;
   //钻探(陆上)
   intResult:=getAllBoreInfo(strProjectNo,0);
   pbCreateReport.Position:=20;
   //钻探(水上)
   intResult:=getAllBoreInfo(strProjectNo,1);
   pbCreateReport.Position:=30;
   //单桥静力触探
   intResult:=getAllBoreInfo(strProjectNo,7);
   pbCreateReport.Position:=40;
   //双桥静力触探
   intResult:=getAllBoreInfo(strProjectNo,12);
   strOutTxt:='孔号,原状样(<=30),原状样(>30),扰动样,标贯(<=20),标贯(>20<=50),标贯(>50),含水量,容重,液塑限,压缩,剪切,颗分';
   Writeln(txtFile,strOuttxt);
   pbCreateReport.Position:=50;
   //取土,水样
   intResult:=getEarthWaterInfo(strProjectNo);
   pbCreateReport.Position:=60;
   //标准贯入试验
   intResult:=getStandardThroughInfo(strProjectNo);
   pbCreateReport.Position:=70;
   //螺文钻
   intResult:=getWhorlThroughInfo(strProjectNo);
   pbCreateReport.Position:=80;
   //勘探点测量
   //intResult:=getProveMeasureInfo(strProjectNo);
   pbCreateReport.Position:=90;
   //室内土试验费
   intResult:=getRomDustTestInfo(strProjectNo);
   pbCreateReport.Position:=100;
   //输出TEXT文件
   intResult:=WritetxtFile();
   CloseFile(txtFile);
   pbCreateReport.Position:=110;
   MessageBox(application.Handle,'决算报表已经生成。','系统提示',MB_OK+MB_ICONINFORMATION);
   end;

procedure TfrmCharge02.btnBrowseClick(Sender: TObject);
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

procedure TfrmCharge02.btnOpenReportClick(Sender: TObject);
var
   sfName:string;
begin
   sfName:=trim(ERP1.Text);
   if fileexists(sfName) then
      shellexecute(application.Handle,PAnsiChar(''),PAnsiChar(sfName),PAnsiChar(''),PAnsiChar(''),SW_SHOWNORMAL)
   else
      Application.Messagebox(FILE_NOTEXIST,HINT_TEXT, MB_ICONEXCLAMATION + mb_Ok);
end;

procedure TfrmCharge02.FormActivate(Sender: TObject);
begin
    self.Left := trunc((screen.Width -self.Width)/2);
    self.Top  := trunc((Screen.Height - self.Height)/3);
      strProjectNo := g_ProjectInfo.prj_no;
    strPath:=GetCurrentDir;
    strPath:=strPath+'\report\'+strProjectNo;
    ERP1.Text:=strPath+'_02.xls';
    pbCreateReport.Position:=0;
end;

end.
