unit UExperiment92;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB,
   ExtCtrls, DBCtrls;

type
  TExperiment92 = class(TForm)
    AQProc: TADOQuery;
    AQPhysics: TADOQuery;
    AQChemistry: TADOQuery;
    DSProc: TDataSource;
    DSPhysics: TDataSource;
    DSChemistry: TDataSource;
    ADOQuery1: TADOQuery;
    AQNTest: TADOQuery;
    AQSTest: TADOQuery;
    DSNTest: TDataSource;
    DSSTest: TDataSource;
    ADOQuery2: TADOQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label41: TLabel;
    Label42: TLabel;
    GroupBox7: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    LblNT1: TLabel;
    Label67: TLabel;
    Shape8: TShape;
    DBGNTest: TDBGrid;
    CBNT1: TComboBox;
    EdtNT1: TEdit;
    STNT1: TStaticText;
    STNT3: TStaticText;
    STNT4: TStaticText;
    BBNT1: TBitBtn;
    BBNT2: TBitBtn;
    STNT2: TStaticText;
    EdtNT2: TEdit;
    ChkBNT1: TCheckBox;
    GroupBox8: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label66: TLabel;
    LbST1: TLabel;
    Label50: TLabel;
    Shape1: TShape;
    DBGSTest: TDBGrid;
    CBSTest1: TComboBox;
    EdtSTest1: TEdit;
    STSTest1: TStaticText;
    ChBSTest1: TCheckBox;
    STSTest2: TStaticText;
    STSTest3: TStaticText;
    STSTest4: TStaticText;
    BBST1: TBitBtn;
    BBST2: TBitBtn;
    st_ETMoney: TStaticText;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edt_WAQuantity: TEdit;
    edt_WAPrice: TEdit;
    St_WAMoney: TStaticText;
    TabSheet3: TTabSheet;
    Label8: TLabel;
    Label9: TLabel;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label36: TLabel;
    Shape4: TShape;
    DBGST1: TDBGrid;
    CBST1: TComboBox;
    CBST2: TComboBox;
    EdtST1: TEdit;
    STST1: TStaticText;
    STST2: TStaticText;
    BitBtn3: TBitBtn;
    ST_SPMoney: TStaticText;
    BitBtn1: TBitBtn;
    GroupBox4: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Label34: TLabel;
    Label37: TLabel;
    Shape3: TShape;
    DBGST2: TDBGrid;
    CBST3: TComboBox;
    EdtST2: TEdit;
    STST3: TStaticText;
    STST4: TStaticText;
    BitBtn4: TBitBtn;
    ST_PHMoney: TStaticText;
    BitBtn6: TBitBtn;
    GroupBox5: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label29: TLabel;
    Label32: TLabel;
    Label35: TLabel;
    Label38: TLabel;
    Shape2: TShape;
    DBGST3: TDBGrid;
    CBST4: TComboBox;
    EdtST3: TEdit;
    STST5: TStaticText;
    STST6: TStaticText;
    BitBtn5: TBitBtn;
    ST_CHMoney: TStaticText;
    BitBtn7: TBitBtn;
    St_STMoney: TStaticText;
    BitBtn2: TBitBtn;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    CheckBox1: TCheckBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    St_TestMoney: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_WAPriceKeyPress(Sender: TObject; var Key: Char);
    procedure edt_WAQuantityExit(Sender: TObject);
    procedure edt_WAQuantityEnter(Sender: TObject);
    procedure edt_WAQuantityMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EdtST1Exit(Sender: TObject);
    procedure EdtST2Exit(Sender: TObject);
    procedure EdtST3Exit(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure AQProcAfterScroll(DataSet: TDataSet);
    procedure AQPhysicsAfterScroll(DataSet: TDataSet);
    procedure AQChemistryAfterScroll(DataSet: TDataSet);
    procedure CBST1Select(Sender: TObject);
    procedure CBST2Select(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure EdtST1Enter(Sender: TObject);
    procedure EdtST2Enter(Sender: TObject);
    procedure EdtST3Enter(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CBST3Select(Sender: TObject);
    procedure CBST4Select(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AQProcAfterInsert(DataSet: TDataSet);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure AQPhysicsAfterInsert(DataSet: TDataSet);
    procedure AQChemistryAfterInsert(DataSet: TDataSet);
    procedure EdtST1Change(Sender: TObject);
    procedure EdtST2Change(Sender: TObject);
    procedure EdtST3Change(Sender: TObject);
    procedure CBNT1Select(Sender: TObject);
    procedure CBSTest1Select(Sender: TObject);
    procedure EdtNT1Enter(Sender: TObject);
    procedure EdtNT1Exit(Sender: TObject);
    procedure EdtNT1Change(Sender: TObject);
    procedure EdtSTest1Change(Sender: TObject);
    procedure EdtSTest1Enter(Sender: TObject);
    procedure EdtSTest1Exit(Sender: TObject);
    procedure EdtNT2Change(Sender: TObject);
    procedure EdtNT2Enter(Sender: TObject);
    procedure EdtNT2Exit(Sender: TObject);
    procedure ChkBNT1Click(Sender: TObject);
    procedure ChBSTest1Click(Sender: TObject);
    procedure BBNT2Click(Sender: TObject);
    procedure BBST2Click(Sender: TObject);
    procedure BBNT1Click(Sender: TObject);
    procedure BBST1Click(Sender: TObject);
    procedure AQNTestAfterInsert(DataSet: TDataSet);
    procedure AQSTestAfterInsert(DataSet: TDataSet);
    procedure AQNTestAfterScroll(DataSet: TDataSet);
    procedure AQSTestAfterScroll(DataSet: TDataSet);
  private
     isFirst:boolean;
     m_EtText:string;
     m_ItemID:array[0..4] of tstrings;
     m_UnitPrice:array[0..4] of array of tstrings;
     m_AdjustID:array[0..1] of tstrings;
     procedure DataProccess;
     procedure STDataProccess;
     procedure ETDataProccess;
     procedure TestDataProccess;
     procedure SetSPData(aIndex:integer;isSum:boolean=false);
     procedure SetMoneySP(aIndex:integer);
     function SetNSTData(aItemID:string;aIndex:integer;AValue:double):boolean;
     procedure SetAdjustment(aValue:string;aIndex:integer;aEdtValue:double=0);
     procedure SetCtrls(aIndex:integer);
     procedure DeleteRecord(aQuery:tadoquery;aIndex:integer);
     procedure DataClear(aIndex:integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Experiment92: TExperiment92;

implementation

uses public_unit,MainDM;

{$R *.dfm}
var
   isSelAll:boolean;
procedure EditEnter(aEdit:tedit);
begin
aEdit.Text :=trim(aEdit.Text);
aEdit.SelectAll ;
isSelAll:=true;
end;

procedure TExperiment92.DataProccess;
begin
   St_WAMoney.Caption :=formatfloat('0.00',strtoint(trim(edt_WAQuantity.Text))*strtofloat(trim(edt_WAPrice.Text)));
   TestDataProccess;
end;

procedure TExperiment92.STDataProccess;
begin
   St_STMoney.Caption :=formatfloat('0.00',strtofloat(ST_SPMoney.caption)+strtofloat(ST_PHMoney.caption)+strtofloat(ST_CHMoney.caption));
end;

procedure TExperiment92.ETDataProccess;
begin
   st_ETMoney.Caption :=formatfloat('0.00',strtofloat(STNT4.caption)+strtofloat(STSTest4.caption));
end;

procedure TExperiment92.TestDataProccess;
begin
   if CheckBox1.Checked then
      St_TestMoney.Caption :=formatfloat('0.00',(strtofloat(ST_ETMoney.caption)+strtofloat( St_WAMoney.Caption)+strtofloat(St_STMoney.Caption))*1.3)
   else
      St_TestMoney.Caption :=formatfloat('0.00',strtofloat(ST_ETMoney.caption)+strtofloat( St_WAMoney.Caption)+strtofloat(St_STMoney.Caption));
end;

function TExperiment92.SetNSTData(aItemID:string;aIndex:integer;AValue:double):boolean;
var
   i:integer;
begin
   try
      if ADOQuery1.Locate('itemid',aItemID,[loPartialKey]) then
         begin
         ADOQuery1.Edit;
         end
      else
         begin
         ADOQuery1.Insert;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :=aItemID;
         i:=PosStrInList(m_itemid[aIndex],aItemID);
         if i>=0 then
            ADOQuery1.FieldByName('unitprice').AsFloat :=strtofloat(m_UnitPrice[aIndex,i][0]);
         ADOQuery1.FieldByName('adjustuprice').AsFloat :=ADOQuery1.FieldByName('unitprice').AsFloat;
         end;
      if ADOQuery2.Locate('itemid',aItemID,[loPartialKey]) then
         begin
         if trim(ADOQuery2.FieldByName('adjustitems').AsString)<>'' then
            if aItemID='02010109' then
               ADOQuery1.FieldByName('adjustuprice').AsFloat:=ADOQuery1.FieldByName('unitprice').AsFloat+(ADOQuery2.FieldByName('adjustmodulus').AsFloat-4)*3
            else if aItemID='0201010' then
               ADOQuery1.FieldByName('adjustuprice').AsFloat:=ADOQuery1.FieldByName('unitprice').AsFloat+(ADOQuery2.FieldByName('adjustmodulus').AsFloat-4)*4
            else if aItemID='02010111' then
               ADOQuery1.FieldByName('adjustuprice').AsFloat:=ADOQuery2.FieldByName('adjustmodulus').AsFloat
            else if (aItemID='02010204') or (aItemID='02010222') or (aItemID='02010223') then
               ADOQuery1.FieldByName('adjustuprice').AsFloat:=ADOQuery1.FieldByName('unitprice').AsFloat+ADOQuery2.FieldByName('adjustmodulus').AsFloat
            else
               ADOQuery1.FieldByName('adjustuprice').AsFloat:=ADOQuery1.FieldByName('unitprice').AsFloat*ADOQuery2.FieldByName('adjustmodulus').AsFloat;
         end
      else
         begin
         ADOQuery2.Insert;
         ADOQuery2.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery2.FieldByName('itemid').AsString :=aItemID;
         ADOQuery2.Post ;
         end;
      ADOQuery1.FieldByName('actualvalue').AsFloat :=AValue;
      ADOQuery1.FieldByName('money').AsFloat :=ADOQuery1.FieldByName('adjustuprice').AsFloat*AValue;
      ADOQuery1.Post ;
      result:=true;
   except
      result:=false;
   end;
end;

procedure TExperiment92.FormCreate(Sender: TObject);
var
   i,j:integer;
   aItemIDP,aItemIDN:string;
   aValue:double;
   aSList:tstrings;
   RecCount:array[0..3] of integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

   isFirst:=true;
   isSelAll:=false;
   StaticText1.Caption := g_ProjectInfo.prj_no ;
   StaticText2.Caption := g_ProjectInfo.prj_name ;
   //取调整系数
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,adjustitems from adjustment92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+'02'+'''') then
      if ADOQuery1.RecordCount>0 then
         begin
         aSList:=tstringlist.Create ;
         aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
         if aSList.Count>0 then CheckBox1.Checked :=true;
         aSList.Free ;
         end;
   //取水质分析数据
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+'0202'+'''') then
      if ADOQuery1.RecordCount>0 then
         begin
         edt_WAQuantity.Text:=ADOQuery1.fieldbyname('actualvalue').AsString;
         EditFormat(edt_WAQuantity);
         edt_WAPrice.Text:=formatfloat('0.00',ADOQuery1.fieldbyname('unitprice').AsFloat);
         EditFormat(edt_WAPrice);
         DataProccess;
         end;
   //岩石试验项目及单价
   if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice,adjustid from unitprice92 where substring(itemid,1,6)='''+'020101'+''' or substring(itemid,1,6)='''+'020102'+''' or substring(itemid,1,6)='''+'020301'+''' or substring(itemid,1,6)='''+'020302'+''' or substring(itemid,1,6)='''+'020401'+''' order by itemid') then
      begin
      aItemIDP:='';
      i:=-1;
      while not ADOQuery1.Eof do
         begin
         aItemIDN:=copy(ADOQuery1.fieldbyname('itemid').AsString,1,6);
         if aItemIDP<>aItemIDN then
            begin
            inc(i);
            aItemIDP:=aItemIDN;
            m_ItemID[i]:=tstringlist.Create ;
            if i<2 then m_AdjustID[i]:=tstringlist.Create ;
            end;
         m_ItemID[i].Add(ADOQuery1.fieldbyname('itemid').AsString);
         j:=length(m_UnitPrice[i]);
         setlength(m_UnitPrice[i],j+1);
         m_UnitPrice[i,j]:=tstringlist.Create;
         if i=2 then
            begin
            CBST1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
            end
         else
            begin
            if i=0 then
               begin
               CBNT1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
               m_AdjustID[i].Add(ADOQuery1.fieldbyname('adjustid').AsString);
               end
            else if i=1 then
               begin
               CBSTest1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
               m_AdjustID[i].Add(ADOQuery1.fieldbyname('adjustid').AsString);
               end
            else if i=3 then
               CBST3.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
            else
               CBST4.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
            end;
         ADOQuery1.Next ;
         end;
      end;
   SetCBWidth(CBST3);
   SetCBWidth(CBST4);
   SetCBWidth(CBSTest1);
   //
   if ReopenQryFAcount(ADOQuery1,'select count(*) from earthsample where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+'''') then
      RecCount[0]:=ADOQuery1.Fields[0].AsInteger;
   if ReopenQryFAcount(ADOQuery1,'select shear_type,count(shear_type) from earthsample where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' group by shear_type') then
      begin
      i:=1;
      while not ADOQuery1.Eof do
         begin
         RecCount[i]:=ADOQuery1.Fields[1].AsInteger;
         inc(i);
         ADOQuery1.Next ;
         end;
      end;
   aValue:=0;
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,adjustuprice,actualvalue,money from charge92 where (charge92.prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,4)='''+'0201'+''')') then
   if ReopenQryFAcount(ADOQuery2,'select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where (prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(itemid,1,4)='''+'0201'+''')') then
      for i:=1 to 34 do
         begin
         if (i=1) or (i=2) or (i=4) or (i=7) or  (i=8) or (i=9)or (i=11) or (i=12) or (i=13) then
            begin
            aItemIDP:='020101'+formatfloat('00',i);
            if i=11 then
               aValue:=RecCount[1]
            else if i=12 then
               aValue:=RecCount[2]
            else if i=13 then
               aValue:=RecCount[3]
            else
               aValue:=RecCount[0];
            if not SetNSTData(aItemIDP,0,aValue) then break;
            end;
         if (i=4) or (i=6){ or (i=7) or (i=19) or  (i=22) or (i=23)or (i=26) or (i=27) or (i=28) or (i=29)} then
            begin
            aItemIDP:='020102'+formatfloat('00',i);
            {if i=22 then
               aValue:=RecCount[]
            else if i=23 then
               aValue:=RecCount[]
            else if i=26 then
               aValue:=RecCount[]
            else if i=27 then
               aValue:=RecCount[]
            else if i=28 then
               aValue:=RecCount[]
            else if i=29 then
               aValue:=RecCount[]
            else}
               aValue:=RecCount[0];
            if not SetNSTData(aItemIDP,1,aValue) then break;
            end;
         end;
   ReopenQryFAcount(ADOQuery2,'select * from adjustmodulus92');
   //取常规试验收费数据
   if ReopenQryFAcount(AQNTest,'select itemname,unitprice,adjustuprice,actualvalue,money,charge92.prj_no prj_no1,charge92.itemid itemid1,adjustment92.prj_no prj_no2,adjustment92.itemid itemid2,adjustitems,adjustmodulus from charge92,unitprice92,adjustment92 where (charge92.prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,6)='''+'020101'+''') and (charge92.itemid=unitprice92.itemid) and (charge92.prj_no=adjustment92.prj_no) and (charge92.itemid=adjustment92.itemid)') then
      begin
      DBGNTest.Columns[0].Field :=AQNTest.Fields[0];
      DBGNTest.Columns[1].Field :=AQNTest.Fields[1];
      DBGNTest.Columns[2].Field :=AQNTest.Fields[2];
      DBGNTest.Columns[3].Field :=AQNTest.Fields[3];
      DBGNTest.Columns[4].Field :=AQNTest.Fields[4];
      if AQNTest.RecordCount>0 then
         begin
         BBNT2.Enabled :=true;
         SetSPData(0,true);
         end;
      end;
   //取常特殊验收费数据
   if ReopenQryFAcount(AQSTest,'select itemname,unitprice,adjustuprice,actualvalue,money,charge92.prj_no prj_no1,charge92.itemid itemid1,adjustment92.prj_no prj_no2,adjustment92.itemid itemid2,adjustitems,adjustmodulus from charge92,unitprice92,adjustment92 where (charge92.prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,6)='''+'020102'+''') and (charge92.itemid=unitprice92.itemid) and (charge92.prj_no=adjustment92.prj_no) and (charge92.itemid=adjustment92.itemid)') then
      begin
      DBGSTest.Columns[0].Field :=AQSTest.Fields[0];
      DBGSTest.Columns[1].Field :=AQSTest.Fields[1];
      DBGSTest.Columns[2].Field :=AQSTest.Fields[2];
      DBGSTest.Columns[3].Field :=AQSTest.Fields[3];
      DBGSTest.Columns[4].Field :=AQSTest.Fields[4];
      if AQSTest.RecordCount>0 then
         begin
         BBST2.Enabled :=true;
         SetSPData(1,true);
         end;
      end;
   //取岩样加工收费数据
   if ReopenQryFAcount(AQProc,'select unitprice92.itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,6)='''+'020301'+''') and (charge92.itemid=unitprice92.itemid)') then
      begin
      DBGST1.Columns[0].Field :=AQProc.Fields[0];
      DBGST1.Columns[1].Field :=AQProc.Fields[1];
      DBGST1.Columns[2].Field :=AQProc.Fields[2];
      DBGST1.Columns[3].Field :=AQProc.Fields[3];
      DBGST1.Columns[4].Field :=AQProc.Fields[4];
      if AQProc.RecordCount>0 then
         begin
         BitBtn1.Enabled :=true;
         SetSPData(2,true);
         end;
      end;
   //取岩石物理力学试验数据
   if ReopenQryFAcount(AQPhysics,'select unitprice92.itemname,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,6)='''+'020302'+''') and (charge92.itemid=unitprice92.itemid)') then
      begin
      DBGST2.Columns[0].Field :=AQPhysics.Fields[0];
      DBGST2.Columns[1].Field :=AQPhysics.Fields[1];
      DBGST2.Columns[2].Field :=AQPhysics.Fields[2];
      DBGST2.Columns[3].Field :=AQPhysics.Fields[3];
      if AQPhysics.RecordCount>0 then
         begin
         BitBtn6.Enabled :=true;
         SetSPData(3,true);
         end;
      end;
   //取岩石化学分析数据
   if ReopenQryFAcount(AQChemistry,'select unitprice92.itemname,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''') and (substring(charge92.itemid,1,6)='''+'020401'+''') and (charge92.itemid=unitprice92.itemid)') then
      begin
      DBGST3.Columns[0].Field :=AQChemistry.Fields[0];
      DBGST3.Columns[1].Field :=AQChemistry.Fields[1];
      DBGST3.Columns[2].Field :=AQChemistry.Fields[2];
      DBGST3.Columns[3].Field :=AQChemistry.Fields[3];
      if AQChemistry.RecordCount>0 then
         begin
         BitBtn7.Enabled :=true;
         SetSPData(4,true);
         end;
      end;
   ETDataProccess;
   STDataProccess;
   TestDataProccess;
   isFirst:=false;
end;

procedure TExperiment92.BitBtn2Click(Sender: TObject);
begin
   close;
end;

procedure TExperiment92.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   try
      begin
      //保存调整系数
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems from adjustment92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+'02'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='02';
         end;
      if CheckBox1.Checked then
         ADOQuery1.fieldbyname('adjustitems').AsString:='32'
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存水质分析数据
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,unitprice,actualvalue,money from charge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+'0202'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='0202';
         end;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(edt_WAQuantity.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=strtofloat(trim(edt_WAPrice.Text));
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(St_WAMoney.caption);
      ADOQuery1.post;
      //保存室内试验总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+'02'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='02';
         end;
      ADOQuery1.FieldByName('money').AsFloat :=strtofloat(St_TestMoney.caption);
      ADOQuery1.Post ;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
   Action:=cafree;
end;

procedure TExperiment92.edt_WAPriceKeyPress(Sender: TObject; var Key: Char);
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
    if (strHead+key+strEnd)='-' then
      begin
         TEdit(Sender).Text :='-';
         TEdit(Sender).SelStart :=2;
         key:=#0;
         exit;
      end;
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



procedure TExperiment92.edt_WAQuantityExit(Sender: TObject);
var
   aEdit:tedit;
begin
   aEdit:=tedit(sender);
   if trim(aEdit.Text)='' then aEdit.Text :='0';
   if aEdit.Name ='edt_WAPrice' then
      aEdit.Text :=formatfloat('0.00',strtofloat(trim(aEdit.Text)));
   if aEdit.Width>80 then
      aEdit.Text :=stringofchar(' ',((aEdit.Width DIV 6)-length(trim(aEdit.Text)))*2-1)+trim(aEdit.Text)
   else
      aEdit.Text :=stringofchar(' ',((aEdit.Width DIV 6)-length(trim(aEdit.Text)))*2)+trim(aEdit.Text);
   DataProccess;
end;

procedure TExperiment92.edt_WAQuantityEnter(Sender: TObject);
begin
tedit(sender).Text :=trim(tedit(sender).Text);
tedit(sender).SelectAll ;
isSelAll:=true;
end;

procedure TExperiment92.edt_WAQuantityMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TExperiment92.EdtST1Exit(Sender: TObject);
begin
   if trim(edtst1.Text)='' then edtst1.Text :='0';
   EditFormat(EdtST1);
   STST2.Caption :=formatfloat('0.00',strtofloat(STST1.Caption)*strtoint(trim(EdtST1.Text)));
end;

procedure TExperiment92.EdtST2Exit(Sender: TObject);
begin
   if trim(edtst2.Text)='' then edtst2.Text :='0';
   EditFormat(EdtST2);
   STST4.Caption :=formatfloat('0.00',strtofloat(STST3.Caption)*strtoint(trim(EdtST2.Text)));
end;

procedure TExperiment92.EdtST3Exit(Sender: TObject);
begin
   if trim(edtst3.Text)='' then edtst3.Text :='0';
   EditFormat(EdtST3);
   STST6.Caption :=formatfloat('0.00',strtofloat(STST5.Caption)*strtoint(trim(EdtST3.Text)));
end;

procedure TExperiment92.CheckBox1Click(Sender: TObject);
begin
   TestDataProccess;
end;

procedure TExperiment92.SetSPData(aIndex:integer;isSum:boolean=false);
var
   i,j:integer;
   aSum:double;
   aValue:string;
begin
   if aIndex=0 then
      begin
      i:=PosStrInList(m_ItemID[0],AQNTest.fieldbyname('itemid1').AsString);
      if i>=0 then CBNT1.ItemIndex :=i;
      STNT1.caption:=formatfloat('0.00',AQNTest.fieldbyname('unitprice').Asfloat);
      EdtNT1.Text:=AQNTest.fieldbyname('actualvalue').AsString;
      EditFormat(EdtNT1);
      aValue:=trim(AQNTest.fieldbyname('adjustitems').AsString);
      if aValue='' then aValue:=trim(m_AdjustID[0][i]);
      SetAdjustment(aValue,0,AQNTest.fieldbyname('adjustmodulus').AsFloat);
      STNT2.Caption :=formatfloat('0.00',AQNTest.fieldbyname('adjustuprice').Asfloat);
      STNT3.Caption :=formatfloat('0.00',AQNTest.fieldbyname('money').Asfloat);
      if isSum then
         begin
         aSum:=SumMoney(AQNTest,'money');
         STNT4.Caption :=formatfloat('0.00',aSum);
         end;
      end
   else if aIndex=1 then
      begin
      i:=PosStrInList(m_ItemID[1],AQSTest.fieldbyname('itemid1').AsString);
      if i>=0 then CBSTest1.ItemIndex :=i;
      STSTest1.caption:=formatfloat('0.00',AQSTest.fieldbyname('unitprice').Asfloat);
      EdtSTest1.Text:=AQSTest.fieldbyname('actualvalue').AsString;
      EditFormat(EdtSTest1);
      aValue:=trim(AQSTest.fieldbyname('adjustitems').AsString);
      if aValue='' then aValue:=trim(m_AdjustID[1][i]);
      SetAdjustment(aValue,1,AQSTest.fieldbyname('adjustmodulus').AsFloat);
      STSTest2.Caption :=formatfloat('0.00',AQSTest.fieldbyname('adjustuprice').Asfloat);
      STSTest3.Caption :=formatfloat('0.00',AQSTest.fieldbyname('money').Asfloat);
      if isSum then
         begin
         aSum:=SumMoney(AQSTest,'money');
         STSTest4.Caption :=formatfloat('0.00',aSum);
         end;
      end
   else if aIndex=2 then
      begin
      i:=PosStrInList(m_ItemID[2],AQProc.fieldbyname('itemid').AsString);
      if i>=0 then CBST1.ItemIndex :=i;
      j:=PosStrInList(CBST2.Items,AQProc.fieldbyname('category').AsString);
      if j>=0 then CBST2.ItemIndex :=j;
      STST1.caption:=formatfloat('0.00',AQProc.fieldbyname('unitprice').Asfloat);
      EdtST1.Text:=AQProc.fieldbyname('actualvalue').AsString;
      EditFormat(EdtST1);
      STST2.Caption :=formatfloat('0.00',AQProc.fieldbyname('money').Asfloat);
      if isSum then
         begin
         aSum:=SumMoney(AQProc,'money');
         ST_SPMoney.Caption :=formatfloat('0.00',aSum);
         end;
      end
   else if aIndex=3 then
      begin
      i:=PosStrInList(m_ItemID[3],AQPhysics.fieldbyname('itemid').AsString);
      if i>=0 then CBST3.ItemIndex :=i;
      STST3.caption:=formatfloat('0.00',AQPhysics.fieldbyname('unitprice').Asfloat);
      EdtST2.Text:=AQPhysics.fieldbyname('actualvalue').AsString;
      EditFormat(EdtST2);
      STST4.Caption :=formatfloat('0.00',AQPhysics.fieldbyname('money').Asfloat);
      if isSum then
         begin
         aSum:=SumMoney(AQPhysics,'money');
         ST_PHMoney.Caption :=formatfloat('0.00',aSum);
         end;
      end
   else
      begin
      i:=PosStrInList(m_ItemID[4],AQChemistry.fieldbyname('itemid').AsString);
      if i>=0 then CBST4.ItemIndex :=i;
      STST5.caption:=formatfloat('0.00',AQChemistry.fieldbyname('unitprice').Asfloat);
      EdtST3.Text:=AQChemistry.fieldbyname('actualvalue').AsString;
      EditFormat(EdtST3);
      STST6.Caption :=formatfloat('0.00',AQChemistry.fieldbyname('money').Asfloat);
      if isSum then
         begin
         aSum:=SumMoney(AQChemistry,'money');
         ST_CHMoney.Caption :=formatfloat('0.00',aSum);
         end;
      end;
end;

procedure TExperiment92.AQProcAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      begin
      isFirst:=true;
      SetSPData(2);
      isFirst:=false;
      STDataProccess;
      TestDataProccess;
      end;
   BitBtn3.Enabled :=false;
end;

procedure TExperiment92.AQPhysicsAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      begin
      isFirst:=true;
      SetSPData(3);
      isFirst:=false;
      STDataProccess;
      TestDataProccess;
      end;
   BitBtn4.Enabled :=false;
end;

procedure TExperiment92.AQChemistryAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      begin
      isFirst:=true;
      SetSPData(4);
      isFirst:=false;
      STDataProccess;
      TestDataProccess;
      end;
   BitBtn5.Enabled :=false;
end;

procedure TExperiment92.CBST1Select(Sender: TObject);
begin
   if not AQProc.Locate('itemid',m_ItemID[2][CBST1.ItemIndex], [loPartialKey]) then
      begin
      if strtofloat(trim(EdtST1.Text))<>0 then
         begin
         EdtST1.Text:='0';
         EditFormat(EdtST1);
         end;
      if CBST2.ItemIndex<0 then
         begin
         STST1.Caption :='0.00';
         STST2.Caption :='0.00';
         end
      else
         begin
         SetMoneySP(2);
         if not BitBtn3.Enabled then BitBtn3.Enabled:=true;
         end;
      end
   //else
   //   SetSPData(2);
end;

procedure TExperiment92.SetAdjustment(aValue:string;aIndex:integer;aEdtValue:double=0);
begin
if aIndex=0 then
   if aValue<>'' then
      if adoquery2.Locate('aitemid',aValue,[loPartialKey]) then
         begin
         if (aValue='36') or (aValue='37') then
            begin
            LblNT1.Visible :=true;
            LblNT1.Caption :=adoquery2.fieldbyname('adjustitems').AsString+'  ';
            EdtNT2.Visible :=true;
            EdtNT2.Left := LblNT1.Left +LblNT1.Width+5;
            if aEdtValue>0 then
               begin
               EdtNT2.text:=formatfloat('0',aEdtValue);
               editformat(EdtNT2);
               end
            else
               begin
               EdtNT2.text:=formatfloat('0',4);
               editformat(EdtNT2);
               end;
            ChkBNT1.Visible :=false;
            end
         else
            begin
            LblNT1.Visible :=false;
            EdtNT2.Visible :=false;
            ChkBNT1.Visible :=true;
            if aEdtValue>0 then
               ChkBNT1.checked:=true
            else
               ChkBNT1.checked:=false;
            ChkBNT1.Caption := adoquery2.fieldbyname('adjustitems').AsString;
            end;
         end
      else
         SetCtrls(0)
   else
      SetCtrls(0)
else
   if aValue<>'' then
      if adoquery2.Locate('aitemid',aValue,[loPartialKey]) then
         begin
         LbST1.Visible :=false;
         ChBSTest1.Visible :=true;
         if aEdtValue>0 then
            ChBSTest1.checked:=true
         else
            ChBSTest1.checked:=false;
         ChBSTest1.Caption := adoquery2.fieldbyname('adjustitems').AsString;
         end
      else
         SetCtrls(1)
   else
      SetCtrls(1)
end;

procedure TExperiment92.SetCtrls(aIndex:integer);
begin
   if aIndex=0 then
      begin
      LblNT1.Visible :=true;
      LblNT1.Caption :=' 无 ';
      EdtNT2.Visible :=false;
      ChkBNT1.Visible :=false;
      end
   else
      begin
      LbST1.Visible :=true;
      LbST1.Caption :=' 无 ';
      ChBSTest1.Visible :=false;
      end;
end;

procedure TExperiment92.SetMoneySP(aIndex:integer);
var
   aValue:string;
begin
   if aIndex=0 then
      begin
      STNT1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[0,CBNT1.itemindex][0]));
      STNT2.Caption :=STNT1.Caption;
      aValue:=trim(m_AdjustID[0][CBNT1.itemindex]);
      SetAdjustment(aValue,0);
      STNT3.Caption :=formatfloat('0.00',strtofloat(trim(EdtNT1.Text))*strtofloat(STNT2.Caption));
      end
   else if aIndex=1 then
      begin
      STSTest1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[1,CBSTest1.itemindex][0]));
      STSTest2.Caption :=STSTest1.Caption;
      aValue:=trim(m_AdjustID[1][CBSTest1.itemindex]);
      SetAdjustment(aValue,1);
      STSTest3.Caption :=formatfloat('0.00',strtofloat(trim(EdtSTest1.Text))*strtofloat(STSTest2.Caption));
      end
   else if aIndex=2 then
      begin
      STST1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[2,CBST1.itemindex][CBST2.ItemIndex]));
      STST2.Caption :=formatfloat('0.00',strtofloat(trim(EdtST1.Text))*strtofloat(STST1.Caption));
      end
   else if aIndex=3 then
      begin
      STST3.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[3,CBST3.itemindex][0]));
      STST4.Caption :=formatfloat('0.00',strtofloat(trim(EdtST2.Text))*strtofloat(STST3.Caption));
      end
   else
      begin
      STST5.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[4,CBST4.itemindex][0]));
      STST6.Caption :=formatfloat('0.00',strtofloat(trim(EdtST3.Text))*strtofloat(STST5.Caption));
      end;
end;

procedure TExperiment92.CBST2Select(Sender: TObject);
begin
   if CBST1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BitBtn3.Enabled then BitBtn3.Enabled:=true;
   SetMoneySP(2);
end;

procedure TExperiment92.BitBtn3Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQProc.Locate('itemid;category',vararrayof([m_ItemID[2][CBST1.ItemIndex],CBST2.Text]), [loPartialKey]) then
         begin
         AQProc.Insert;
         AQProc.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQProc.FieldByName('itemid').AsString :=m_ItemID[2][CBST1.ItemIndex];
//         AQProc.FieldByName('itemid').AsString :='0';
         end
      else
         AQProc.Edit ;
      AQProc.FieldByName('category').AsString :=CBST2.Text;
      AQProc.FieldByName('unitprice').Asfloat :=strtofloat(stst1.Caption);
      AQProc.FieldByName('actualvalue').Asfloat :=strtofloat(trim(edtst1.Text));
      AQProc.FieldByName('money').Asfloat :=strtofloat(stst2.Caption);
      AQProc.Post ;
      aBM:=AQProc.GetBookmark ;
      AQProc.Close ;
      AQProc.Open ;
      if AQProc.RecordCount>1 then
         AQProc.GotoBookmark(aBM);
      SetSPData(2,true);
      STDataProccess;
      TestDataProccess;
      isFirst:=false;
      BitBtn3.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.EdtST1Enter(Sender: TObject);
begin
m_EtText:=trim(EdtST1.Text);
EditEnter(EdtST1);
//BitBtn3.Enabled:=false;
end;

procedure TExperiment92.EdtST2Enter(Sender: TObject);
begin
m_EtText:=trim(EdtST2.Text);
EditEnter(EdtST2);
end;

procedure TExperiment92.EdtST3Enter(Sender: TObject);
begin
m_EtText:=trim(EdtST3.Text);
EditEnter(EdtST3);
end;

procedure TExperiment92.BitBtn4Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQPhysics.Locate('itemid',m_ItemID[3][CBST3.ItemIndex], [loPartialKey]) then
         begin
         AQPhysics.Insert;
         AQPhysics.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQPhysics.FieldByName('itemid').AsString :=m_ItemID[3][CBST3.ItemIndex];
         end
      else
         AQPhysics.Edit ;
      AQPhysics.FieldByName('unitprice').Asfloat :=strtofloat(stst3.Caption);
      AQPhysics.FieldByName('actualvalue').Asfloat :=strtofloat(trim(edtst2.Text));
      AQPhysics.FieldByName('money').Asfloat :=strtofloat(stst4.Caption);
      AQPhysics.Post ;
      aBM:=AQPhysics.GetBookmark ;
      AQPhysics.Close ;
      AQPhysics.Open ;
      if AQPhysics.RecordCount>1 then
         AQPhysics.GotoBookmark(aBM);
      SetSPData(3,true);
      STDataProccess;
      TestDataProccess;
      isFirst:=false;
      BitBtn4.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.CBST3Select(Sender: TObject);
begin
   if not AQPhysics.Locate('itemid',m_ItemID[3][CBST3.ItemIndex], [loPartialKey]) then
      begin
      if strtofloat(trim(EdtST2.Text))<>0 then
         begin
         EdtST2.Text:='0';
         EditFormat(EdtST2);
         end;
      SetMoneySP(3);
      if not BitBtn4.Enabled then BitBtn4.Enabled:=true;
      end
   else
      SetSPData(3);
end;

procedure TExperiment92.CBST4Select(Sender: TObject);
begin
   if not AQChemistry.Locate('itemid',m_ItemID[4][CBST4.ItemIndex], [loPartialKey]) then
      begin
      if strtofloat(trim(EdtST3.Text))<>0 then
         begin
         EdtST3.Text:='0';
         EditFormat(EdtST3);
         end;
      SetMoneySP(4);
      if not BitBtn5.Enabled then BitBtn5.Enabled:=true;
      end
   else
      SetSPData(4);
end;

procedure TExperiment92.BitBtn5Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQChemistry.Locate('itemid',m_ItemID[4][CBST4.ItemIndex], [loPartialKey]) then
         begin
         AQChemistry.Insert;
         AQChemistry.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQChemistry.FieldByName('itemid').AsString :=m_ItemID[4][CBST4.ItemIndex];
         end
      else
         AQChemistry.Edit ;
      AQChemistry.FieldByName('unitprice').Asfloat :=strtofloat(stst5.Caption);
      AQChemistry.FieldByName('actualvalue').Asfloat :=strtofloat(trim(edtst3.Text));
      AQChemistry.FieldByName('money').Asfloat :=strtofloat(stst6.Caption);
      AQChemistry.Post ;
      aBM:=AQChemistry.GetBookmark ;
      AQChemistry.Close ;
      AQChemistry.Open ;
      if AQChemistry.RecordCount>1 then
         AQChemistry.GotoBookmark(aBM);
      SetSPData(4,true);
      STDataProccess;
      TestDataProccess;
      isFirst:=false;
      BitBtn5.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.BitBtn1Click(Sender: TObject);
begin
DeleteRecord(AQProc,2);
end;

procedure TExperiment92.AQProcAfterInsert(DataSet: TDataSet);
begin
   if not BitBtn1.Enabled then BitBtn1.Enabled:=true;
end;

procedure TExperiment92.DataClear(aIndex:integer);
begin
if aIndex=0 then
   begin
   CBNT1.ItemIndex :=-1;
   EdtNT1.Text :='0';
   EditFormat(EdtNT1);
   STNT1.Caption :='0.00';
   ChkBNT1.Checked :=false;
   EdtNT2.Text:='4';
   EditFormat(EdtNT2);
   STNT2.Caption :='0.00';
   STNT3.Caption :='0.00';
   STNT4.Caption :='0.00';
   BBNT1.Enabled :=false;
   BBNT2.Enabled :=false;
   end
else if aIndex=1 then
   begin
   CBSTest1.ItemIndex :=-1;
   EdtSTest1.Text :='0';
   EditFormat(EdtSTest1);
   ChBSTest1.Checked :=false;
   STSTest1.Caption :='0.00';
   STSTest2.Caption :='0.00';
   STSTest3.Caption :='0.00';
   STSTest4.Caption :='0.00';
   BBST1.enabled:=false;
   BBST2.enabled:=false;
   end
else if aIndex=2 then
   begin
   CBST1.ItemIndex :=-1;
   CBST2.ItemIndex :=-1;
   EdtST1.Text :='0';
   EditFormat(EdtST1);
   STST1.Caption :='0.00';
   STST2.Caption :='0.00';
   ST_SPMoney.Caption :='0.00';
   BitBtn3.enabled:=false;
   BitBtn1.enabled:=false;
   end
else if aIndex=3 then
   begin
   CBST3.ItemIndex :=-1;
   EdtST2.Text :='0';
   EditFormat(EdtST2);
   STST3.Caption :='0.00';
   STST4.Caption :='0.00';
   ST_PHMoney.Caption :='0.00';
   BitBtn4.enabled:=false;
   BitBtn6.enabled:=false;
   end
else
   begin
   CBST4.ItemIndex :=-1;
   EdtST3.Text :='0';
   EditFormat(EdtST3);
   STST5.Caption :='0.00';
   STST6.Caption :='0.00';
   ST_CHMoney.Caption :='0.00';
   BitBtn5.enabled:=false;
   BitBtn7.enabled:=false;
   end;
end;

procedure TExperiment92.DeleteRecord(aQuery:tadoquery;aIndex:integer);
var
   aBM:tbookmark;
begin
   try
      begin
      if application.MessageBox(DEL_CONFIRM,HINT_TEXT,MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
      ADOQuery1.Close ;
      if aIndex<2 then
         ADOQuery1.SQL.Text :='select * from charge92,adjustment92 where charge92.prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and charge92.itemid='''+aQuery.fieldbyname('itemid1').AsString+''' and (charge92.prj_no=adjustment92.prj_no) and (charge92.itemid=adjustment92.itemid)'//charge92.prj_no,charge92.itemid,adjustment92.prj_no,adjustment92.itemid
      else
         ADOQuery1.SQL.Text :='select prj_no,itemid from charge92 where prj_no='''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+''' and itemid='''+aQuery.fieldbyname('itemid').AsString+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then ADOQuery1.Delete;
      if aQuery.RecNo=aquery.RecordCount then
         begin
         aQuery.Prior ;
         end;
      if aQuery.Bof then
         aBM:=nil
      else
         aBM:=aQuery.GetBookmark ;
      aQuery.Close;
      aQuery.Open;
      if not (aBM=nil) then
         aQuery.GotoBookmark(aBM);
      isFirst:=true;
      if aQuery.RecordCount>0 then
         SetSPData(aIndex,true)
      else
         DataClear(aIndex);
      if aIndex<2 then
         ETDataProccess
      else
         STDataProccess;
      TestDataProccess;
      isFirst:=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTDEL,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.BitBtn6Click(Sender: TObject);
begin
DeleteRecord(AQPhysics,3);
end;

procedure TExperiment92.BitBtn7Click(Sender: TObject);
begin
DeleteRecord(AQChemistry,4);
end;

procedure TExperiment92.AQPhysicsAfterInsert(DataSet: TDataSet);
begin
   if not BitBtn6.Enabled then BitBtn6.Enabled:=true;
end;

procedure TExperiment92.AQChemistryAfterInsert(DataSet: TDataSet);
begin
   if not BitBtn7.Enabled then BitBtn7.Enabled:=true;
end;

procedure TExperiment92.EdtST1Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtST1.Text) then BitBtn3.Enabled:=true;
end;

procedure TExperiment92.EdtST2Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtST2.Text) then BitBtn4.Enabled:=true;
end;

procedure TExperiment92.EdtST3Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtST3.Text) then BitBtn5.Enabled:=true;
end;

procedure TExperiment92.CBNT1Select(Sender: TObject);
begin
   if not AQNTest.Locate('itemid1',m_ItemID[0][CBNT1.ItemIndex], [loPartialKey]) then
      begin
      if strtofloat(trim(EdtNT1.Text))<>0 then
         begin
         EdtNT1.Text:='0';
         EditFormat(EdtNT1);
         end;
      SetMoneySP(0);
      if not BBNT1.Enabled then BBNT1.Enabled:=true;
      end
   else
      SetSPData(0);
end;

procedure TExperiment92.CBSTest1Select(Sender: TObject);
begin
   if not AQSTest.Locate('itemid1',m_ItemID[1][CBSTest1.ItemIndex], [loPartialKey]) then
      begin
      if strtofloat(trim(EdtSTest1.Text))<>0 then
         begin
         EdtSTest1.Text:='0';
         EditFormat(EdtSTest1);
         end;
      SetMoneySP(1);
      if not BBST1.Enabled then BBST1.Enabled:=true;
      end
   else
      SetSPData(1);
end;

procedure TExperiment92.EdtNT1Enter(Sender: TObject);
begin
m_EtText:=trim(EdtNT1.Text);
EditEnter(EdtNT1);
end;

procedure TExperiment92.EdtNT1Exit(Sender: TObject);
begin
   if trim(EdtNT1.Text)='' then EdtNT1.Text :='0';
   EditFormat(EdtNT1);
   STNT3.Caption :=formatfloat('0.00',strtofloat(STNT2.Caption)*strtoint(trim(EdtNT1.Text)));
end;

procedure TExperiment92.EdtNT1Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtNT1.Text) then BBNT1.Enabled:=true;
end;

procedure TExperiment92.EdtSTest1Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtSTest1.Text) then BBST1.Enabled:=true;
end;

procedure TExperiment92.EdtSTest1Enter(Sender: TObject);
begin
m_EtText:=trim(EdtSTest1.Text);
EditEnter(EdtSTest1);
end;

procedure TExperiment92.EdtSTest1Exit(Sender: TObject);
begin
   if trim(EdtSTest1.Text)='' then EdtSTest1.Text :='0';
   EditFormat(EdtSTest1);
   STSTest3.Caption :=formatfloat('0.00',strtofloat(STSTest2.Caption)*strtoint(trim(EdtSTest1.Text)));
end;

procedure TExperiment92.EdtNT2Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtNT2.Text) then BBNT1.Enabled:=true;
end;

procedure TExperiment92.EdtNT2Enter(Sender: TObject);
begin
m_EtText:=trim(EdtNT2.Text);
EditEnter(EdtNT2);
end;

procedure TExperiment92.EdtNT2Exit(Sender: TObject);
begin
   if trim(EdtNT2.Text)='' then EdtNT2.Text :='4';
   if strtoint(trim(EdtNT2.Text))<4 then EdtNT2.Text :='4';
   EditFormat(EdtNT2);
   if adoquery2.Locate('aitemid',m_adjustid[0][CBNT1.ItemIndex],[loPartialKey]) then
      STNT2.Caption:=formatfloat('0.00',strtofloat(STNT1.Caption)+(strtoint(trim(EdtNT2.Text))-4)*adoquery2.fieldbyname('adjustmodulus').asfloat);
   STNT3.Caption :=formatfloat('0.00',strtofloat(STNT2.Caption)*strtoint(trim(EdtNT1.Text)));
end;

procedure TExperiment92.ChkBNT1Click(Sender: TObject);
begin
if chkbnt1.Checked then
   begin
   if adoquery2.Locate('aitemid',m_adjustid[0][CBNT1.ItemIndex],[loPartialKey]) then
      STNT2.Caption:=formatfloat('0.00',adoquery2.fieldbyname('adjustmodulus').asfloat);
   end
else
   STNT2.Caption:=STNT1.Caption;
STNT3.Caption :=formatfloat('0.00',strtofloat(STNT2.Caption)*strtoint(trim(EdtNT1.Text)));
if not BBNT1.Enabled then BBNT1.Enabled :=true;
end;

procedure TExperiment92.ChBSTest1Click(Sender: TObject);
begin
if ChBSTest1.Checked then
   begin
   if adoquery2.Locate('aitemid',m_adjustid[1][CBSTest1.ItemIndex],[loPartialKey]) then
      if (m_adjustid[1][CBSTest1.ItemIndex]='39') or (m_adjustid[1][CBSTest1.ItemIndex]='40') then
         STSTest2.Caption:=formatfloat('0.00',strtofloat(STSTest1.caption)+adoquery2.fieldbyname('adjustmodulus').asfloat)
      else
         STSTest2.Caption:=formatfloat('0.00',strtofloat(STSTest1.caption)*adoquery2.fieldbyname('adjustmodulus').asfloat);
   end
else
   STSTest2.Caption:=STSTest1.Caption;
STSTest3.Caption :=formatfloat('0.00',strtofloat(STSTest2.Caption)*strtoint(trim(EdtSTest1.Text)));
if not BBST1.Enabled then BBST1.Enabled :=true;
end;

procedure TExperiment92.BBNT2Click(Sender: TObject);
begin
DeleteRecord(AQNTest,0);
end;

procedure TExperiment92.BBST2Click(Sender: TObject);
begin
DeleteRecord(AQSTest,1);
end;

procedure TExperiment92.BBNT1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQNTest.Locate('itemid1',m_ItemID[0][CBNT1.ItemIndex], [loPartialKey]) then
         begin
         AQNTest.Insert;
         AQNTest.FieldByName('prj_no1').AsString :=g_ProjectInfo.prj_no;
         AQNTest.FieldByName('itemid1').AsString :=m_ItemID[0][CBNT1.ItemIndex];
         AQNTest.FieldByName('prj_no2').AsString :=g_ProjectInfo.prj_no;
         AQNTest.FieldByName('itemid2').AsString :=m_ItemID[0][CBNT1.ItemIndex];
         end
      else
         AQNTest.Edit ;
      AQNTest.FieldByName('unitprice').Asfloat :=strtofloat(STNT1.Caption);
      AQNTest.FieldByName('adjustuprice').Asfloat :=strtofloat(STNT2.Caption);
      AQNTest.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EdtNT1.Text));
      AQNTest.FieldByName('money').Asfloat :=strtofloat(STNT3.Caption);
      if EdtNT2.Visible then
         begin
         if strtoint(trim(EdtNT2.Text))>=4 then
            begin
            AQNTest.FieldByName('adjustitems').AsString :=m_adjustid[0][CBNT1.ItemIndex];
            AQNTest.FieldByName('adjustmodulus').AsFloat :=strtoint(trim(EdtNT2.Text));
            end;
         end
      else if ChkBNT1.Visible then
         if ChkBNT1.Checked then
            begin
            AQNTest.FieldByName('adjustitems').AsString :=m_adjustid[0][CBNT1.ItemIndex];
            AQNTest.FieldByName('adjustmodulus').AsFloat :=20;
            end
         else
            begin
            AQNTest.FieldByName('adjustitems').AsString :='';
            AQNTest.FieldByName('adjustmodulus').AsFloat :=0;
            end;
      AQNTest.Post ;
      aBM:=AQNTest.GetBookmark ;
      AQNTest.Close ;
      AQNTest.Open ;
      if AQNTest.RecordCount>1 then
        AQNTest.GotoBookmark(aBM);
      SetSPData(0,true);
      ETDataProccess;
      TestDataProccess;
      isFirst:=false;
      BBNT1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.BBST1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQSTest.Locate('itemid1',m_ItemID[1][CBSTest1.ItemIndex], [loPartialKey]) then
         begin
         AQSTest.Insert;
         AQSTest.FieldByName('prj_no1').AsString :=g_ProjectInfo.prj_no;
         AQSTest.FieldByName('itemid1').AsString :=m_ItemID[1][CBSTest1.ItemIndex];
         AQSTest.FieldByName('prj_no2').AsString :=g_ProjectInfo.prj_no;
         AQSTest.FieldByName('itemid2').AsString :=m_ItemID[1][CBSTest1.ItemIndex];
         end
      else
         AQSTest.Edit ;
      AQSTest.FieldByName('unitprice').Asfloat :=strtofloat(STSTest1.Caption);
      AQSTest.FieldByName('adjustuprice').Asfloat :=strtofloat(STSTest2.Caption);
      AQSTest.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EdtSTest1.Text));
      AQSTest.FieldByName('money').Asfloat :=strtofloat(STSTest3.Caption);
      if ChBSTest1.Visible then
         if ChBSTest1.Checked then
            begin
            AQSTest.FieldByName('adjustitems').AsString :=m_adjustid[1][CBSTest1.ItemIndex];
            if adoquery2.Locate('aitemid',m_adjustid[1][CBSTest1.ItemIndex],[loPartialKey]) then
               AQSTest.FieldByName('adjustmodulus').AsFloat :=adoquery2.fieldbyname('adjustmodulus').AsFloat;
            end
         else
            begin
            AQSTest.FieldByName('adjustitems').AsString :='';
            AQSTest.FieldByName('adjustmodulus').AsFloat :=0;
            end ;
      AQSTest.Post ;
      aBM:=AQSTest.GetBookmark ;
      AQSTest.Close ;
      AQSTest.Open ;
      if AQSTest.RecordCount>1 then
        AQSTest.GotoBookmark(aBM);
      SetSPData(1,true);
      ETDataProccess;
      TestDataProccess;
      isFirst:=false;
      BBST1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TExperiment92.AQNTestAfterInsert(DataSet: TDataSet);
begin
   if not BBNT2.Enabled then BBNT2.Enabled:=true;
end;

procedure TExperiment92.AQSTestAfterInsert(DataSet: TDataSet);
begin
   if not BBST2.Enabled then BBST2.Enabled:=true;
end;

procedure TExperiment92.AQNTestAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      begin
      isFirst:=true;
      SetSPData(0);
      isFirst:=false;
      ETDataProccess;
      TestDataProccess;
      end;
   BBNT1.Enabled :=false;
end;

procedure TExperiment92.AQSTestAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      begin
      isFirst:=true;
      SetSPData(1);
      isFirst:=false;
      ETDataProccess;
      TestDataProccess;
      end;
   BBST1.Enabled :=false;
end;

end.
