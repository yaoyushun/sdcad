unit ChargeUnit92;
                 
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,DateUtils, Excel2000{ExcelXP}, OleServer, DB,
  ADODB,shellapi;

type
  TChargeForm92 = class(TForm)
    SEFDlg: TSaveDialog;
    AQRP1: TADOQuery;
    AQRP2: TADOQuery;
    AQRP3: TADOQuery;
    Label1: TLabel;
    Label2: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel9: TBevel;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    GroupBox2: TGroupBox;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel5: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel10: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel13: TBevel;
    Label22: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label36: TLabel;
    Label21: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    StaticText11: TStaticText;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StaticText12: TStaticText;
    CheckBox4: TCheckBox;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    ChBPrj5: TCheckBox;
    EPrj2: TEdit;
    BBOther: TBitBtn;
    STOther: TStaticText;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox4: TGroupBox;
    BitBtn5: TBitBtn;
    STReport: TStaticText;
    STDir: TStaticText;
    BitBtn6: TBitBtn;
    ERP1: TEdit;
    BitBtn7: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure EPrj2Exit(Sender: TObject);
    procedure ChBPrj5Click(Sender: TObject);
    procedure BBOtherClick(Sender: TObject);
  private
    { Private declarations }
    isSelAll:boolean;
    m_mod1025:double;
    m_RBVal1:double;
    //数据处理函数，返回结果true--成功,false--失败
    function DataProccess(OnlyAModulus:boolean=false;IsSave:boolean=false):boolean;
    function ReportProcess:boolean;
  public
    { Public declarations }
  end;

var
  ChargeForm92: TChargeForm92;

implementation
   uses Expression,public_unit,MainDM,UReconCharge92,UExperiment92,
  OtherCharges92;
{$R *.dfm}
var
   aSList:tstrings;
   IsFirst:boolean;


function TChargeForm92.DataProccess(OnlyAModulus:boolean=false;IsSave:boolean=false):boolean;
var
   aValue:double;
begin
   aValue:=strtofloat(StaticText3.Caption)+strtofloat(StaticText4.Caption);
   if not OnlyAModulus then
      begin
      StaticText5.Caption :=formatfloat('0.00',aValue);
      if aValue<=10000.00 then
         begin
         StaticText6.Caption := StaticText5.Caption;
         StaticText8.Caption := formatfloat('0.00',aValue*0.25);
         StaticText7.Caption :='0.00';
         StaticText9.Caption :='0.00';
         end
      else
         begin
         StaticText6.Caption := '10000.00';
         StaticText8.Caption := '2500.00';
         StaticText7.Caption :=formatfloat('0.00',aValue-10000.00);
         StaticText9.Caption := formatfloat('0.00',(aValue-10000.00)*0.20);
         end;
      StaticText10.Caption := formatfloat('0.00',strtofloat(StaticText8.Caption)+strtofloat(StaticText9.Caption));
      end;
   StaticText11.Caption := formatfloat('0.00',(aValue+strtofloat(StaticText10.Caption))*strtofloat(StaticText12.Caption)+strtofloat(STOther.Caption));
   if IsSave then
      begin
      if not ReopenQryFAcount(MainDataModule.qryFAcount,'select * from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'00'+'''') then
         begin
         result:=false;
         exit;
         end;
      try
         if MainDataModule.qryFAcount.RecordCount<1 then
            begin
            MainDataModule.qryFAcount.Insert;
            MainDataModule.qryFAcount.FieldByName('prj_no').AsString := g_ProjectInfo.prj_no;
            MainDataModule.qryFAcount.FieldByName('itemid').AsString :='00';
            end
         else
            MainDataModule.qryFAcount.Edit ;
         MainDataModule.qryFAcount.FieldByName('adjustitems').AsString :=aSList.Text ;
         MainDataModule.qryFAcount.FieldByName('adjustmodulus').AsFloat :=strtofloat(StaticText12.Caption);
         MainDataModule.qryFAcount.FieldByName('othercharge').AsFloat := strtofloat(STOther.Caption);
         MainDataModule.qryFAcount.FieldByName('mod1025').AsFloat := strtofloat(trim(edit1.Text));
         MainDataModule.qryFAcount.FieldByName('FloatValue').AsFloat := strtofloat(trim(EPrj2.Text));
         MainDataModule.qryFAcount.Post ;
      except
         result:=false;
         exit;
      end;
      end;
   result:=true;
end;

procedure TChargeForm92.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
aSList.Free ;
Action := caFree;
end;

procedure TChargeForm92.FormCreate(Sender: TObject);
var
   SaveFName,tmp:string;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

   datetimetostring(SaveFName,'yymmdd',today);
   datetimetostring(tmp,'hhnnss',time);
   SaveFName:='\rp'+SaveFName+tmp+'.xls';
   tmp:=ExtractFileDir(application.ExeName)+'\Report';
   if not directoryexists(tmp) then
      if not CreateDir(tmp) then tmp:=ExtractFileDir(application.ExeName);
   SaveFName:=tmp+SaveFName;
   ERP1.Text :=SaveFName;
   //---------------------------
   IsFirst:=true;
   isSelAll:=false;
   aSList:=tstringlist.Create;
   self.Left :=(screen.Width-self.Width) DIV 2;
   self.Top :=(screen.Height-self.Height) DIV 2;
   StaticText1.Caption := g_ProjectInfo.prj_no ;
   StaticText2.Caption := g_ProjectInfo.prj_name ;
   if trim(g_ProjectInfo.prj_no)='' then
      begin
      BitBtn1.Enabled :=false;
      BitBtn2.Enabled :=false;
      BitBtn5.Enabled :=false;
      BitBtn1.Enabled :=false;
      BitBtn6.Enabled :=false;
      BitBtn7.Enabled :=false;
      ERP1.Enabled :=false;
      CheckBox1.Enabled :=false;
      CheckBox2.Enabled :=false;
      CheckBox3.Enabled :=false;
      CheckBox4.Enabled :=false;
      ChBPrj5.Enabled :=false;
      exit;
      end;
   //--------------读取调整系数和其它费用----------------
   if ReopenQryFAcount(MainDataModule.qryFAcount,'select * from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'00'+'''') then
      if MainDataModule.qryFAcount.RecordCount>0 then
         begin
         aSList.Text :=MainDataModule.qryFAcount.FieldByName('adjustitems').AsString;
         STOther.Caption :=formatfloat('0.00',MainDataModule.qryFAcount.FieldByName('othercharge').AsFloat);
         if PosStrInList(aSList,'01')>=0 then CheckBox1.Checked :=true;
         if PosStrInList(aSList,'02')>=0 then CheckBox2.Checked :=true;
         if PosStrInList(aSList,'03')>=0 then
            begin
            RadioButton1.Checked :=true;
            CheckBox3.Checked :=true;
            end;
         if PosStrInList(aSList,'04')>=0 then
            begin
            RadioButton2.Checked :=true;
            CheckBox3.Checked :=true;
            end;
         if PosStrInList(aSList,'33')>=0 then
            begin
            edit1.Text :=formatfloat('0.00',MainDataModule.qryFAcount.FieldByName('mod1025').AsFloat) ;
            editformat(edit1);
            CheckBox4.Checked :=true;
            end;
         if PosStrInList(aSList,'45')>=0 then
            begin
            EPrj2.Text :=formatfloat('0',MainDataModule.qryFAcount.FieldByName('FloatValue').AsFloat);
            editformat(EPrj2);
            ChBPrj5.Checked :=true;
            end;
         end;
   //-------------------读取勘察收费和试验收费并计算技术费和总收费-------------------
   if ReopenQryFAcount(MainDataModule.qryFAcount,'select prj_no,itemid,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and (itemid='''+'01'+''' or itemid='''+'02'+''')') then
      while not MainDataModule.qryFAcount.Eof do
      begin
         if MainDataModule.qryFAcount.FieldByName('itemid').AsString='01' then
            StaticText3.Caption :=formatfloat('0.00',MainDataModule.qryFAcount.FieldByName('money').AsFloat)
         else
            StaticText4.Caption :=formatfloat('0.00',MainDataModule.qryFAcount.FieldByName('money').AsFloat);
         MainDataModule.qryFAcount.Next ;
      end;
   DataProccess;
   IsFirst:=false;
end;
//--------------自定义数字输入框----------------
procedure TChargeForm92.Edit1KeyPress(Sender: TObject; var Key: Char);
var
  strHead,strEnd,strAll,strFraction:string;
  iDecimalSeparator:integer;  
begin

if Key = #13 then
   begin
   SendMessage(Handle, WM_NEXTDLGCTL, 0, 0);
   Key := #0;
   exit;
   end;
  if (TEdit(Sender).Tag=0) and (key='.') then
  begin
     key:=#0;
     exit;
  end;
  if lowercase(key)='e' then
  begin
     key:=#0;
     exit;
  end;
  if key=' ' then key:=#0;
  if key <>chr(vk_back) then
  try
    strHead := copy(TEdit(Sender).Text,1,TEdit(Sender).SelStart);
    strEnd  := copy(TEdit(Sender).Text,TEdit(Sender).SelStart+TEdit(Sender).SelLength+1,length(TEdit(Sender).Text));
    strtofloat(strHead+key+strEnd);
    strAll := strHead+key+strEnd;
    iDecimalSeparator:= pos('.',strAll);
    if iDecimalSeparator>0 then
      begin
        strFraction:= copy(strall,iDecimalSeparator+1,length(strall));
        if (iDecimalSeparator>0) and (length(strFraction)>TEdit(Sender).Tag) then
          key:=#0;
      end;
  except
    key:=#0;
  end;
end;
//--------------范围限制----------------
procedure TChargeForm92.Edit1Exit(Sender: TObject);
begin
   if trim(Edit1.Text)='' then Edit1.Text:='1.10';
   if strtofloat(trim(Edit1.Text))>1.25 then
      Edit1.Text :='1.25'
   else if strtofloat(trim(Edit1.Text))<1.10 then
      Edit1.Text :='1.10';
   editformat(edit1);
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+(strtofloat(trim(edit1.Text))-m_mod1025));
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT); 
   m_mod1025:=strtofloat(trim(Edit1.text));
end;
//--------------格式化----------------
procedure TChargeForm92.CheckBox4Click(Sender: TObject);
var
   i:integer;
begin
if checkbox4.Checked then
   begin
   if PosStrInList(aSList,'33')<0 then aSList.Add('33');
   Edit1.Enabled :=true;
   m_mod1025:=strtofloat(trim(Edit1.text));
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+(m_mod1025-1.00));
   end
else
   begin
   i:=PosStrInList(aSList,'33');
   if i>=0 then aSList.Delete(i);
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)-(m_mod1025-1.00));
   Edit1.Enabled :=false;
   end;
if IsFirst then
   DataProccess(true)
else
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.CheckBox3Click(Sender: TObject);
var
   i:integer;
begin
if checkbox3.Checked then
   begin
   RadioButton1.Enabled :=true;
   RadioButton2.Enabled :=true;
   if RadioButton1.Checked then
      begin
      if PosStrInList(aSList,'03')<0 then aSList.Add('03');
      StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+0.10);
      end
   else
      begin
      if PosStrInList(aSList,'04')<0 then aSList.Add('04');
      StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+0.20);
      end;
   end
else
   begin
   if RadioButton1.Checked then
      begin
      i:=PosStrInList(aSList,'03');
      if i>=0 then aSList.Delete(i);
      StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)-0.10);
      end
   else
      begin
      i:=PosStrInList(aSList,'04');
      if i>=0 then aSList.Delete(i);
      StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)-0.20);
      end;
   RadioButton1.Enabled :=false;
   RadioButton2.Enabled :=false;
   end;
if IsFirst then
   DataProccess(true)
else
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.BitBtn3Click(Sender: TObject);
begin
close;
end;

procedure TChargeForm92.BitBtn4Click(Sender: TObject);
begin
   application.CreateForm(TExpressForm,ExpressForm);
   ExpressForm.ShowModal;
end;

procedure TChargeForm92.CheckBox1Click(Sender: TObject);
var
   i:integer;
begin
   if checkbox1.Checked then
      begin
      if PosStrInList(aSList,'01')<0 then aSList.Add('01');
      StaticText12.Caption:=formatfloat('0.00',strtofloat(StaticText12.Caption)+0.1);
      end
   else
      begin
      i:=PosStrInList(aSList,'01');
      if i>=0 then aSList.Delete(i);
      StaticText12.Caption:=formatfloat('0.00',strtofloat(StaticText12.Caption)-0.1);
      end;
   if IsFirst then
      DataProccess(true)
   else
      if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.CheckBox2Click(Sender: TObject);
var
   i:integer;
begin
   if checkbox2.Checked then
      begin
      if PosStrInList(aSList,'02')<0 then aSList.Add('02');
      StaticText12.Caption:=formatfloat('0.00',strtofloat(StaticText12.Caption)+0.2);
      end
   else
      begin
      i:=PosStrInList(aSList,'02');
      if i>=0 then aSList.Delete(i);
      StaticText12.Caption:=formatfloat('0.00',strtofloat(StaticText12.Caption)-0.2);
      end;
   if IsFirst then
      DataProccess(true)
   else
      if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.RadioButton1Click(Sender: TObject);
var
   i:integer;
begin
   if IsFirst then exit;
   i:=PosStrInList(aSList,'04');
   if i>=0 then aSList.Delete(i);
   if PosStrInList(aSList,'03')<0 then aSList.Add('03');
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)-0.10);
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.RadioButton2Click(Sender: TObject);
var
   i:integer;
begin
   if IsFirst then exit;
   i:=PosStrInList(aSList,'03');
   if i>=0 then aSList.Delete(i);
   if PosStrInList(aSList,'04')<0 then aSList.Add('04');
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+0.10);
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;
procedure TChargeForm92.BitBtn1Click(Sender: TObject);
begin
   screen.Cursor:=crHourGlass;
   application.CreateForm(TReconCharge92,ReconCharge92);
   screen.Cursor:=crDefault;
   ReconCharge92.ShowModal;
   StaticText3.Caption := formatfloat('0.00',strtofloat(ReconCharge92.STRecon3.caption));
   DataProccess ;
end;

procedure TChargeForm92.BitBtn2Click(Sender: TObject);
begin
   screen.Cursor:=crHourGlass;
   application.CreateForm(TExperiment92,Experiment92);
   screen.Cursor:=crDefault;
   Experiment92.ShowModal;
   StaticText4.Caption := Experiment92.St_TestMoney.Caption;
   DataProccess ;
end;

procedure TChargeForm92.Edit1Enter(Sender: TObject);
begin
tedit(sender).Text :=trim(tedit(sender).Text);
tedit(sender).SelectAll ;
isSelAll:=true;
end;

procedure TChargeForm92.Edit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TChargeForm92.BitBtn5Click(Sender: TObject);
var
   aFlag:boolean;
begin
   if fileexists(trim(ERP1.Text)) then
      if Application.Messagebox(FILE_EXIST,HINT_TEXT, MB_ICONEXCLAMATION +MB_YESNO)=IDNO then
         exit
      else
         if not deletefile(trim(ERP1.Text)) then
            begin
            Application.Messagebox(FILE_DELERR,HINT_TEXT, MB_ICONEXCLAMATION +MB_OK);
            exit;
            end;
   STReport.Font.Color :=clNavy;
   STReport.Caption :=REPORT_PROCCESS;
   screen.Cursor:=crHourGlass	;
   aFlag:=ReportProcess;
   STReport.Font.Color :=clRed;
   if aFlag then
      STReport.Caption :=REPORT_SUCCESS
   else
      STReport.Caption :=REPORT_FAIL;
   screen.Cursor:=crDefault;
end;

function TChargeForm92.ReportProcess:boolean;
var
   i,j: integer;
   aSum,sSum,tmpSum,someSum,exSum,m1025,aOther,atmp,AdMod:double;
   aOVValue,aStartCell,aEndCell:olevariant;
   aList:tstrings;
   tmpStr:string;

   ExcelApplication1:TExcelApplication;
   ExcelWorksheet1:TExcelWorksheet;
   ExcelWorkbook1:TExcelWorkbook;
begin
result:=false; 
if trim(ERP1.Text)='' then exit;
try
   ExcelApplication1 := TExcelApplication.Create(Application);
   ExcelWorksheet1 := TExcelWorksheet.Create(Application);
   ExcelWorkbook1 := TExcelWorkbook.Create(Application);
   ExcelApplication1.Connect;
except
   Application.Messagebox(EXCEL_NOTINSTALL,HINT_TEXT, MB_ICONERROR + mb_Ok);
   result:=false;
   exit;
end;
try
   ExcelApplication1.Workbooks.Add(xlWBATWorksheet, 0);
   ExcelWorkbook1.ConnectTo(ExcelApplication1.Workbooks[1]);
   ExcelWorksheet1.ConnectTo(ExcelWorkbook1.Worksheets[1] as _worksheet);
   //-------------合并单元,设标题--------------
   aOVValue:=ExcelWorksheet1.Cells.Range['A1','F1'];
   aOVValue.HorizontalAlignment :=  xlCenter;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.Font.Size:='14';
   aOVValue.FormulaR1C1:=REPORT_TITLE;
   //-------------工程编号---------------
   aOVValue:=ExcelWorksheet1.Cells.Range['A2','B2'];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程编号：'+g_ProjectInfo.prj_no;
   //-------------工程名称---------------
   aOVValue:=ExcelWorksheet1.Cells.Range['C2','F2'];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程名称：'+g_ProjectInfo.prj_name;
   //-------------工程地质勘察---------------
   i:=4;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='一、工程地质勘察';
   aStartCell:=aOVValue;
   inc(i);

   AQRP3.Close ;
   AQRP3.SQL.Text :='select * from adjustmodulus92';
   AQRP3.Open ;
   aList:=tstringlist.Create ;
   sSum:=0;
   //-------------工程地质测绘---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010101'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='(一)、工程地质测绘';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='成图比例尺';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='复杂程度';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='成图面积(k㎡)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            begin
            if j<=2 then aOVValue.item[i,j].NumberFormatLocal:='@'
            else aOVValue.item[i,j].NumberFormatLocal:='0.00';
            aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='工程地质测绘小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      if aList.Count>0 then
         begin
         tmpSum:=0;
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='工程地质测绘合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      //
      sSum:=sSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   //-------------钻探---------------
   someSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='(二)、钻探';
   inc(i);
   //-------------钻孔---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select depth_type,drange,category,max(unitprice) as uprice,'''+''+''' as adjustuprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'1'+''' group by depth_type,drange,category order by depth_type,drange,category';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='1、钻孔';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='钻探深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(m)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=2 to 7 do
            begin
            if j<=3 then aOVValue.item[i,j-1].NumberFormatLocal:='@'
            else aOVValue.item[i,j-1].NumberFormatLocal:='0.00';
            aOVValue.item[i, j-1]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='钻孔小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010201'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      tmpSum:=0;
      atmp:=0;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='钻孔合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //---------探井----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select depth_type,drange,category,max(unitprice) as uprice,'''+''+''' as adjustuprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'2'+''' group by depth_type,drange,category order by depth_type,drange,category';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='2、探井';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='掘进深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(m)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=2 to 7 do
            begin
            if j<=3 then aOVValue.item[i,j-1].NumberFormatLocal:='@'
            else aOVValue.item[i,j-1].NumberFormatLocal:='0.00';
            aOVValue.item[i, j-1]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='探井小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010202'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      tmpSum:=0;
      atmp:=0;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='探井合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //-------------探槽---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010203'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='3、探槽';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='掘进深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='掘土量(立方米)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            begin
            if j<=2 then aOVValue.item[i,j].NumberFormatLocal:='@'
            else aOVValue.item[i,j].NumberFormatLocal:='0.00';
            aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='探槽小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      tmpSum:=0;
      atmp:=0;
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010203'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='探槽合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //-------------取土、石、水试料---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010205'+''' or substring(charge92.itemid,1,6)='''+'010206'+''') and (charge92.itemid=unitprice92.itemid) order by charge92.itemid';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='3、取土、石、水试料';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='取样方法与试样规格';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='取样深度(m)';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5]:='数量(只)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j<=2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j].WrapText :=  true;
               if AQRP1.fields.Fields[j-1].AsString<>'0' then
                  aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end
            else
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               if AQRP1.fields.Fields[j-1].AsFloat<>0 then
                  aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='取土、石、水试料小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
       //
      someSum:=someSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
      
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='钻探合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum);
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   sSum:=sSum+someSum;
   //-------------现场测试---------------
   inc(i);
   someSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='(三)、现场测试';
   inc(i);
   //-------------标准贯入---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select drange,category,max(unitprice) as uprice,'''+''+''' as adjustuprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'5'+''' group by drange,category order by drange,category';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='1、标准贯入';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(次数)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            begin
            if j<=2 then aOVValue.item[i,j].NumberFormatLocal:='@'
            else aOVValue.item[i,j].NumberFormatLocal:='0.00';
            aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='标准贯入小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      someSum:=someSum+aSum;
      end;
   //---------动力触探----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select depth_type,drange,category,pt_type,max(unitprice) as uprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'3'+''' group by depth_type,drange,category,pt_type order by depth_type,drange,category,pt_type';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='2、动力触探';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='测试深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='触探类型';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='标准单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(次数)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=2 to 7 do
            begin
            if j<=4 then aOVValue.item[i,j-1].NumberFormatLocal:='@'
            else aOVValue.item[i,j-1].NumberFormatLocal:='0.00';
            aOVValue.item[i, j-1]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='动力触探小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010302'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      tmpSum:=0;
      atmp:=0;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='动力触探合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //---------静力触探----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select depth_type,drange,category,max(unitprice) as uprice,'''+''+''' as adjustuprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'4'+''' group by depth_type,drange,category order by depth_type,drange,category';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='3、静力触探';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='测试深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(m)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=2 to 7 do
            begin
            if j<=3 then aOVValue.item[i,j-1].NumberFormatLocal:='@'
            else aOVValue.item[i,j-1].NumberFormatLocal:='0.00';
            aOVValue.item[i, j-1]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='静力触探小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010303'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      j:= PosStrInList(aList,'21');
      if j>=0 then
         begin
         aSum:=aSum*0.5;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='轻便静力触探--按标准50%计费';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         aList.Delete(j); 
         inc(i);
         end;
      tmpSum:=0;
      atmp:=0;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='静力触探合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //-------------旁压试验---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010305'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='4、旁压试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='测试深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验压力';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(次数)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            begin
            if j<=2 then aOVValue.item[i,j].NumberFormatLocal:='@'
            else aOVValue.item[i,j].NumberFormatLocal:='0.00';
            aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='旁压试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      someSum:=someSum+aSum;
      end;
   //---------十字板剪切试验----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select depth_type,drange,category,max(unitprice) as uprice,'''+''+''' as adjustuprice,sum(depth) as sdepth,sum(money) as smoney from drillcharge92  where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and drill_type='''+'6'+''' group by depth_type,drange,category order by depth_type,drange,category';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='5、十字板剪切试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='地层类别';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(次数)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=2 to 7 do
            begin
            if j<=3 then aOVValue.item[i,j-1].NumberFormatLocal:='@'
            else aOVValue.item[i,j-1].NumberFormatLocal:='0.00';
            aOVValue.item[i, j-1]:=AQRP1.fields.Fields[j-1].AsString;
            end;
         aSum:=aSum+AQRP1.fieldbyname('smoney').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='十字板剪切试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
   
      someSum:=someSum+aSum;
      end;
   //-------------压水、注水试验---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010308'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='6、压水、注水试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验名称';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验方式';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(段、次)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j<=2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end
            else
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               if AQRP1.fields.Fields[j-1].AsFloat<>0 then
                  aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='压水、注水试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      tmpSum:=0;
      atmp:=0;
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010308'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='压水、注水试验合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   //-------------孔隙水压力试验---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010309'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='7、孔隙水压力试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='测试深度';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='观测时间';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='工作量(点)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j<=2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end
            else
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               if AQRP1.fields.Fields[j-1].AsFloat<>0 then
                  aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='孔隙水压力试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //---------------
      AQRP2.Close ;
      AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010309'+'''';
      AQRP2.Open ;
      aList.Clear ;
      aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
      tmpSum:=0;
      atmp:=0;
      if aList.Count>0 then
         begin
         for j:=0 to aList.Count-1 do
            begin
            AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            //-------------
            aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
            aOVValue.HorizontalAlignment :=  xlRight;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.NumberFormatLocal:='0.00';
            atmp:=aSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            inc(i);
            end;
         aSum:=aSum+tmpSum;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='孔隙水压力试验合计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         end;
      someSum:=someSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='现场测试合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum);
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   sSum:=sSum+someSum;
   //-------工程地质勘察合计--------
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程地质勘察计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',sSum);
   inc(i);
   //
   AQRP2.Close ;
   AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'01'+'''';
   AQRP2.Open ;
   tmpSum:=0;
   if AQRP2.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'D'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.WrapText :=  true;
      aOVValue.MergeCells := true;
      aOVValue.RowHeight:=30;
      aOVValue.FormulaR1C1:='在岩溶、洞穴、泥石流、滑坡、山前洪积裙等复杂场地勘察--增加10～30%计费';

      aOVValue:=ExcelWorksheet1.Cells.Item[i,5];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.FormulaR1C1:='增加'+trim(AQRP2.FieldByName('adjustmodulus').AsString)+'%';

      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      tmpSum:=sSum*AQRP2.FieldByName('adjustmodulus').AsFloat/100;
      aOVValue.FormulaR1C1:=formatfloat('0.00',tmpSum);
      inc(i);
      end;
   sSum:=sSum+tmpSum;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程地质勘察合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',sSum);
   inc(i);
   //------------室内实验-------------
   exSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='二、室内实验';
   inc(i);
      //-------------土工试验---------------
   someSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='(一)、土工试验';
   inc(i);
   //-------------一般常规试验---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'020101'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='1、一般常规试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验项目';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验方法';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量(项/组)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j=1 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j+1].NumberFormatLocal:='@';
               tmpStr:=AQRP1.fields.Fields[j-1].AsString;
               aOVValue.item[i, j]:=copy(tmpStr,1,pos('--',tmpStr)-1);
               aOVValue.item[i, j+1]:=copy(tmpStr,pos('--',tmpStr)+2,length(tmpStr)-pos('--',tmpStr));
               end
            else if j>2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='一般常规试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      someSum:=someSum+aSum;
      end;
   //-------------特殊试验---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'020102'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='2、特殊试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验项目';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验方法';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量(项/组)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j=1 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j+1].NumberFormatLocal:='@';
               tmpStr:=AQRP1.fields.Fields[j-1].AsString;
               aOVValue.item[i, j]:=copy(tmpStr,1,pos('--',tmpStr)-1);
               aOVValue.item[i, j+1]:=copy(tmpStr,pos('--',tmpStr)+2,length(tmpStr)-pos('--',tmpStr));
               end
            else if j>2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='特殊试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      someSum:=someSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
      
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='土工试验合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum);
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   exSum:=exSum+someSum;
   //-------------水质分析---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemid,category,unitprice,adjustuprice,actualvalue,money,prj_no from charge92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(itemid,1,4)='''+'0202'+''')';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='(二)、水质分析';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A']:='';
      aOVValue.item[i, 2]:='';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4]:='';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      for j:=3 to 6 do
         begin
         if j=4 then continue;
         aOVValue.item[i,j].NumberFormatLocal:='0.00';
         if AQRP1.fields.Fields[j-1].AsFloat<>0 then
            aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
         end;
      aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='水质分析小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      if aSum<>0 then
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //
      exSum:=exSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;

   //-------------岩石试验---------------
   inc(i);
   someSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='(三)、岩石试验';
   inc(i);
   //-------------岩样加工---------------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'020301'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='1、岩样加工';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验项目';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='规格(cm)';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='岩石硬度';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='标准单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量(块)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 5 do
            if j=1 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j+1].NumberFormatLocal:='@';
               tmpStr:=AQRP1.fields.Fields[j-1].AsString;
               aOVValue.item[i, j]:=copy(tmpStr,1,pos('--',tmpStr)-1);
               aOVValue.item[i, j+1]:=copy(tmpStr,pos('--',tmpStr)+2,length(tmpStr)-pos('--',tmpStr));
               end
            else
               begin
               if j=2 then
                  aOVValue.item[i,j+1].NumberFormatLocal:='@'
               else
                  aOVValue.item[i,j+1].NumberFormatLocal:='0.00';
               aOVValue.item[i, j+1]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='岩样加工小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      //-------------
      someSum:=someSum+aSum;
      end;
   //---------岩石物理力学试验----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'020302'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='2、岩石物理力学试验';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验项目';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验方法';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量(件、块/组)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j=1 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j+1].NumberFormatLocal:='@';
               tmpStr:=AQRP1.fields.Fields[j-1].AsString;
               aOVValue.item[i, j]:=copy(tmpStr,1,pos('--',tmpStr)-1);
               aOVValue.item[i, j+1]:=copy(tmpStr,pos('--',tmpStr)+2,length(tmpStr)-pos('--',tmpStr));
               end
            else if j>2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='岩石物理力学试验小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      someSum:=someSum+aSum;
      end;
  //---------岩石化学分析----------
   aSum:=0;
   AQRP1.Close ;
   AQRP1.SQL.Text :='select itemname,category,unitprice,adjustuprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'020401'+''') and (charge92.itemid=unitprice92.itemid)';
   AQRP1.Open ;
   if AQRP1.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='3、岩石化学分析';
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells;
      aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 'A']:='试验项目';
      aOVValue.item[i, 2].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 2]:='试验方法';
      aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 3]:='标准单价';
      aOVValue.item[i, 4].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 4]:='调整单价';
      aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 5].WrapText :=  true;
      aOVValue.item[i, 5]:='数量(项)';
      aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
      aOVValue.item[i, 6]:='金额';
      //------------------------------
      inc(i);
      while not AQRP1.Eof do
         begin
         for j:=1 to 6 do
            if j=1 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='@';
               aOVValue.item[i,j+1].NumberFormatLocal:='@';
               tmpStr:=AQRP1.fields.Fields[j-1].AsString;
               aOVValue.item[i, j]:=copy(tmpStr,1,pos('--',tmpStr)-1);
               aOVValue.item[i, j+1]:=copy(tmpStr,pos('--',tmpStr)+2,length(tmpStr)-pos('--',tmpStr));
               end
            else if j>2 then
               begin
               aOVValue.item[i,j].NumberFormatLocal:='0.00';
               aOVValue.item[i, j]:=AQRP1.fields.Fields[j-1].AsString;
               end;
         aSum:=aSum+AQRP1.fieldbyname('money').AsFloat;
         AQRP1.Next ;
         inc(i);
         end;
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='岩石化学分析小计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
      inc(i);
      someSum:=someSum+aSum;
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);

   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='岩石试验合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum);
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   exSum:=exSum+someSum;
   //-------室内试验合计--------
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='室内试验计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',exSum);
   inc(i);
   //
   AQRP2.Close ;
   AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'02'+'''';
   AQRP2.Open ;
   tmpSum:=0;
   if AQRP2.RecordCount>0 then
      begin
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='现场室内试验--增加30%计费';

      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      tmpSum:=exSum*0.3;
      aOVValue.FormulaR1C1:=formatfloat('0.00',tmpSum);
      inc(i);
      end;
   exSum:=exSum+tmpSum;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='室内试验合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',exSum);
   sSum:=sSum+exSum;
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   //-----------合计-----------
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程决算合计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',sSum);
   inc(i);

   //------------技术收费-------------
   exSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='技术收费';
   inc(i);
   //-------------<=10000元---------------
   someSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'D'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='<=10000元';

   aOVValue:=ExcelWorksheet1.Cells.Item[i,5];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.FormulaR1C1:='收费率25%';

   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   if sSum<=10000 then
      someSum:=sSum*0.25
   else
      someSum:=2500;
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum);
   inc(i);
   //------------->10000元---------------
   tmpSum:=0;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'D'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='>10000元';

   aOVValue:=ExcelWorksheet1.Cells.Item[i,5];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.FormulaR1C1:='收费率20%';
   if sSum>10000 then
      begin
      tmpSum:=sSum-10000;
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      tmpSum:=tmpSum*0.2;
      aOVValue.FormulaR1C1:=formatfloat('0.00',tmpSum);
      inc(i);
      end;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='技术收费合计';
   //
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',someSum+tmpSum);
   inc(i);
   //--------------
   sSum:=sSum+someSum+tmpSum;
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
   aOVValue.MergeCells := true;
   inc(i);
   //-----------总合计-----------
   aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
   aOVValue.HorizontalAlignment :=  xlLeft;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.MergeCells := true;
   aOVValue.FormulaR1C1:='工程决算总计';
   //-------------
   aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
   aOVValue.HorizontalAlignment :=  xlRight;
   aOVValue.VerticalAlignment :=  xlCenter;
   aOVValue.NumberFormatLocal:='0.00';
   aOVValue.FormulaR1C1:=formatfloat('0.00',sSum);
   inc(i);
   //---------------
   AQRP2.Close ;
   AQRP2.SQL.Text :='select prj_no,itemid,adjustitems,othercharge,mod1025,FloatValue from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'00'+'''';
   AQRP2.Open ;
   aList.Clear ;
   aList.Text :=AQRP2.Fieldbyname('adjustitems').AsString ;
   tmpSum:=0;
   atmp:=0;
   if aList.Count>0 then
      begin
      for j:=0 to aList.Count-1 do
         begin
         AQRP3.Locate('aitemid',aList[j],[loPartialKey]);
         if aList[j]='33' then
            begin
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'D'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.WrapText :=  true;
            aOVValue.MergeCells := true;
            aOVValue.RowHeight:=30;
            aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;

            aOVValue:=ExcelWorksheet1.Cells.Item[i,5];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.FormulaR1C1:='调整系数'+trim(AQRP2.FieldByName('mod1025').AsString);
            end
         else if aList[j]='45' then
            begin
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'D'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.WrapText :=  true;
            aOVValue.MergeCells := true;
            aOVValue.RowHeight:=30;
            aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;

            aOVValue:=ExcelWorksheet1.Cells.Item[i,5];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.FormulaR1C1:='增加'+trim(AQRP2.FieldByName('FloatValue').AsString)+'%';
            end
         else
            begin
            aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
            aOVValue.HorizontalAlignment :=  xlLeft;
            aOVValue.VerticalAlignment :=  xlCenter;
            aOVValue.WrapText :=  true;
            aOVValue.MergeCells := true;
            if AQRP3.Fieldbyname('description').AsString='' then
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString
            else
               aOVValue.FormulaR1C1:=AQRP3.Fieldbyname('adjustitems').AsString+'--'+AQRP3.Fieldbyname('description').AsString;
            end;
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         if aList[j]='33' then
            begin
            atmp:=sSum*(AQRP2.FieldByName('mod1025').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            end
         else if aList[j]='45' then
            begin
            atmp:=sSum*(AQRP2.FieldByName('FloatValue').AsFloat/100);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            end
         else
            begin
            atmp:=sSum*(AQRP3.Fieldbyname('adjustmodulus').AsFloat-1);
            aOVValue.FormulaR1C1:=formatfloat('0.00',atmp);
            tmpSum:=tmpSum+atmp;
            end;
         inc(i);
         end;
      sSum:=sSum+tmpSum;
     //---------其它费用----------
      aSum:=0;
      AQRP1.Close ;
      AQRP1.SQL.Text :='select oc_item,0,oc_method,0,oc_uprice,oc_money from othercharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+'''';
      AQRP1.Open ;
      if AQRP1.RecordCount>0 then
         begin
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='其它费用';
         inc(i);
         aOVValue:=ExcelWorksheet1.Cells;
         aOVValue.item[i, 'A'].HorizontalAlignment :=xlCenter;
         aOVValue.item[i, 'A']:='项目';
         aOVValue.item[i, 3].HorizontalAlignment :=xlCenter;
         aOVValue.item[i, 3]:='计算方法';
         aOVValue.item[i, 5].HorizontalAlignment :=xlCenter;
         aOVValue.item[i, 5].WrapText :=  true;
         aOVValue.item[i, 5]:='单价';
         aOVValue.item[i, 6].HorizontalAlignment :=xlCenter;
         aOVValue.item[i, 6]:='金额';
         //------------------------------
         inc(i);
         while not AQRP1.Eof do
            begin
            if trim(AQRP1.fieldbyname('oc_item').AsString)='' then
               begin
               AQRP1.Next ;
               continue;
               end;
            for j:=1 to 6 do
               if j=1 then
                  begin
                  aOVValue.item[i,j].NumberFormatLocal:='@';
                  tmpStr:=AQRP1.fields.Fields[j-1].AsString;
                  aOVValue.item[i, j]:=tmpStr;
                  end
               else if (j=2) or (j=4) then continue
               else
                  begin
                  aOVValue.item[i,j].NumberFormatLocal:='0.00';
                  aOVValue.item[i,j]:=AQRP1.fields.Fields[j-1].AsString;
                  end;
            aSum:=aSum+AQRP1.fieldbyname('oc_money').AsFloat;
            AQRP1.Next ;
            inc(i);
            end;
         aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
         aOVValue.HorizontalAlignment :=  xlLeft;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.MergeCells := true;
         aOVValue.FormulaR1C1:='其它费用小计';
         //-------------
         aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
         aOVValue.HorizontalAlignment :=  xlRight;
         aOVValue.VerticalAlignment :=  xlCenter;
         aOVValue.NumberFormatLocal:='0.00';
         aOVValue.FormulaR1C1:=formatfloat('0.00',aSum);
         inc(i);
         sSum:=sSum+aSum;
         end;
      //-----------
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'F'+inttostr(i)];
      aOVValue.MergeCells := true;
      inc(i);
      aOVValue:=ExcelWorksheet1.Cells.Range['A'+inttostr(i),'E'+inttostr(i)];
      aOVValue.HorizontalAlignment :=  xlLeft;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.MergeCells := true;
      aOVValue.FormulaR1C1:='工程决算总合计';
      //-------------
      aOVValue:=ExcelWorksheet1.Cells.Item[i,6];
      aOVValue.HorizontalAlignment :=  xlRight;
      aOVValue.VerticalAlignment :=  xlCenter;
      aOVValue.NumberFormatLocal:='0.00';
      aOVValue.FormulaR1C1:=formatfloat('0.00',sSum);
      inc(i);
      end;
   //---------------
   aEndCell:=aOVValue;
   //----------------
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell];
   aOVValue.font.size:='9';
   aOVValue.Borders[xlEdgeRight].LineStyle := xlNone;
   aOVValue.Borders[xlInsideVertical].LineStyle := xlNone;
   aOVValue.Borders[xlInsideHorizontal].LineStyle := xlNone;
   aOVValue.Borders[xlDiagonalDown].LineStyle := xlNone;
   aOVValue.Borders[xlDiagonalUp].LineStyle := xlNone;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlEdgeLeft];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlEdgeTop];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlEdgeBottom];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlEdgeRight];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlInsideVertical];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //
   aOVValue:=ExcelWorksheet1.Cells.Range[aStartCell,aEndCell].Borders[xlInsideHorizontal];
   aOVValue.LineStyle := xlContinuous;
   aOVValue.Weight := xlThin;
   aOVValue.ColorIndex := xlAutomatic;
   //----------------------
   ExcelWorksheet1.Columns.AutoFit;
   ExcelWorksheet1.SaveAs(trim(ERP1.Text));
   result:=true;
except
   application.MessageBox(EXCEL_ERROR,HINT_TEXT);
   ExcelApplication1.AutoQuit:=true;
   ExcelWorksheet1.Free;
   ExcelWorkbook1.Free;
   ExcelApplication1.Free;
   exit;
end;
   ExcelApplication1.AutoQuit:=true;
   ExcelWorksheet1.Free;
   ExcelWorkbook1.Free;
   ExcelApplication1.Disconnect;
   ExcelApplication1.Quit;
   ExcelApplication1.Free;
end;
procedure TChargeForm92.BitBtn6Click(Sender: TObject);
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

procedure TChargeForm92.BitBtn7Click(Sender: TObject);
var
   sfName:string;
begin
   sfName:=trim(ERP1.Text);
   if fileexists(sfName) then
      shellexecute(application.Handle,PAnsiChar(''),PAnsiChar(sfName),PAnsiChar(''),PAnsiChar(''),SW_SHOWNORMAL)
   else
      Application.Messagebox(FILE_NOTEXIST,HINT_TEXT, MB_ICONEXCLAMATION + mb_Ok);
end;

procedure TChargeForm92.EPrj2Exit(Sender: TObject);
begin
   if trim(EPrj2.Text)='' then EPrj2.Text:='20';
   if strtofloat(trim(EPrj2.Text))<20 then
      EPrj2.Text :='20'
   else if strtofloat(trim(EPrj2.Text))>40 then
      EPrj2.Text :='40';
   EditFormat(eprj2);
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+strtofloat(trim(EPrj2.Text))/100-m_RBVal1/100);
   m_RBVal1:=strtofloat(trim(EPrj2.Text));
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.ChBPrj5Click(Sender: TObject);
var
   i:integer;
begin
if ChBPrj5.Checked then
   begin
   if PosStrInList(aSList,'45')<0 then aSList.Add('45');
   EPrj2.Enabled :=true;
   m_RBVal1:=strtofloat(trim(EPrj2.Text));
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)+m_RBVal1/100);
   end
else
   begin
   i:=PosStrInList(aSList,'45');
   if i>=0 then aSList.Delete(i);
   StaticText12.Caption :=formatfloat('0.00',strtofloat(StaticText12.Caption)-m_RBVal1/100);
   EPrj2.Enabled:=false;
   end;
if IsFirst then
   DataProccess(true)
else
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

procedure TChargeForm92.BBOtherClick(Sender: TObject);
begin
   application.CreateForm(TFOtherCharges92,FOtherCharges92);
   FOtherCharges92.ShowModal;
   STOther.Caption := FOtherCharges92.ST_Others.Caption ;
   if not DataProccess(true,true) then application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
end;

end.
