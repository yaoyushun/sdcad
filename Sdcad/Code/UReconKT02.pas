unit UReconKT02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls;

type
  TReconKT02 = class(TForm)
    ADOQuery1: TADOQuery;
    DSDill: TDataSource;
    DSStratum: TDataSource;
    DSMoney: TDataSource;
    AQDrill: TADOQuery;
    AQStratum: TADOQuery;
    AQMoney: TADOQuery;
    AQTC: TADOQuery;
    DSTC: TDataSource;
    AQTJ: TADOQuery;
    DSTJ: TDataSource;
    AQTJS: TADOQuery;
    DSTJS: TDataSource;
    AQTJM: TADOQuery;
    DSTJM: TDataSource;
    Label89: TLabel;
    BBRecon2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Label62: TLabel;
    Label63: TLabel;
    GroupBox2: TGroupBox;
    Label79: TLabel;
    Label91: TLabel;
    Panel1: TPanel;
    DGDrill1: TDBGrid;
    DGDrill2: TDBGrid;
    DGDrill3: TDBGrid;
    STDrill0: TStaticText;
    GroupBox8: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label53: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Shape12: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CBDrill1: TCheckBox;
    CBDrill2: TCheckBox;
    CBDrill3: TCheckBox;
    CBDrill5: TCheckBox;
    RBDrill1: TRadioButton;
    RBDrill2: TRadioButton;
    RBDrill5: TRadioButton;
    RBDrill6: TRadioButton;
    STDrill1: TStaticText;
    CBDrill4: TCheckBox;
    RBDrill3: TRadioButton;
    RBDrill4: TRadioButton;
    STDrill2: TStaticText;
    TabSheet3: TTabSheet;
    Label67: TLabel;
    Label10: TLabel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    DGJ1: TDBGrid;
    DGJ2: TDBGrid;
    DGJ3: TDBGrid;
    STJ1: TStaticText;
    STJ2: TStaticText;
    TabSheet1: TTabSheet;
    Label32: TLabel;
    Label34: TLabel;
    GroupBox4: TGroupBox;
    Label22: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    CBC1: TComboBox;
    CBC2: TComboBox;
    EC1: TEdit;
    STC1: TStaticText;
    STC2: TStaticText;
    BBC1: TBitBtn;
    BBC2: TBitBtn;
    DGC1: TDBGrid;
    STC3: TStaticText;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label1: TLabel;
    Label55: TLabel;
    Label11: TLabel;
    STRecon1: TStaticText;
    STRecon2: TStaticText;
    STRecon3: TStaticText;
    ChBRecon1: TCheckBox;
    CBDrill7: TCheckBox;
    STRecon4: TStaticText;
    Edit1: TEdit;
    BBRecon1: TBitBtn;
    procedure BBRecon1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AQDrillAfterScroll(DataSet: TDataSet);
    procedure AQStratumAfterScroll(DataSet: TDataSet);
    procedure CBDrill1Click(Sender: TObject);
    procedure CBDrill2Click(Sender: TObject);
    procedure CBDrill4Click(Sender: TObject);
    procedure CBDrill5Click(Sender: TObject);
    procedure CBDrill3Click(Sender: TObject);
    procedure RBDrill1Click(Sender: TObject);
    procedure RBDrill2Click(Sender: TObject);
    procedure RBDrill5Click(Sender: TObject);
    procedure RBDrill6Click(Sender: TObject);
    procedure EDrill1KeyPress(Sender: TObject; var Key: Char);
    procedure EDrill1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AQTCAfterInsert(DataSet: TDataSet);
    procedure AQTCAfterScroll(DataSet: TDataSet);
    procedure CBC1Select(Sender: TObject);
    procedure CBC2Select(Sender: TObject);
    procedure EC1Change(Sender: TObject);
    procedure EC1Enter(Sender: TObject);
    procedure EC1Exit(Sender: TObject);
    procedure BBC1Click(Sender: TObject);
    procedure BBC2Click(Sender: TObject);
    procedure ChBRecon1Click(Sender: TObject);
    procedure AQTJMAfterScroll(DataSet: TDataSet);
    procedure AQTJAfterScroll(DataSet: TDataSet);
    procedure BBRecon2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure RBDrill3Click(Sender: TObject);
    procedure RBDrill4Click(Sender: TObject);
    procedure AQTJSAfterScroll(DataSet: TDataSet);
    procedure CBDrill7Click(Sender: TObject);
  private
    m_mod1030:double;
    isFirst:boolean;
    DrillsMoney,TJMoney,TCMoney:double;
    m_EtText:string;
    m_ItemID:tstrings;
    m_UnitPrice:array of tstrings;

    procedure SetTJMoney;
    procedure SetTCMoney;
    procedure SetDrillMoney;
    procedure SetReconMoney;
    procedure SetSPData(isSum:boolean=false);
    procedure SetMoneySP();
    procedure DeleteRecord(aQuery:tadoquery);
    procedure ClearData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReconKT02: TReconKT02;

implementation
uses public_unit,MainDM,UCategory02;
{$R *.dfm}
var
   isSelAll:boolean;
   m_RBVal:double;
   mNo:integer;
//函数
function GetIndexOfRange(aArray:array of double;aValue:double;aOrder:boolean):integer;
var
   i,j:integer;
   minValue,offValue:double;
begin
   if length(aArray)=0 then
      begin
      result:=-2;
      exit;
      end;
   j:=-1;
   minValue:=aArray[length(aArray)-1];
   for i:=0 to length(aArray)-1 do
      if aOrder then
         begin
         offValue:=aArray[i]-aValue;
         if offValue>0 then
            if offValue<=minValue then
               begin
               minValue:=offValue;
               j:=i;
               end;
         end
      else
         begin
         offValue:=aValue-aArray[i];
         if offValue>0 then
            begin
            if offValue<=minValue then
               begin
               minValue:=offValue;
               j:=i;
               end;
            end
         else
            break;
         end;
   result:=j;
end;

function InsertChargeRec(aQuery:tadoquery;PrjNo,DrlNo,ItemName,DRange,SSNo,CName:string;UPrice,DValue,MValue:double;DType:SmallInt;pt_type,DSort:string):boolean;
var
   SQLStr,RNo:string;
begin
   try
      RNo:='0102'+ComSrtring(mNo,4);
      aquery.Close ;
      SQLStr:='insert into drillcharge02 values('''+RNo+''','''
         +stringReplace(PrjNo ,'''','''''',[rfReplaceAll])+''','''
         +stringReplace(DrlNo ,'''','''''',[rfReplaceAll])+''','''+ItemName+''','''+DRange+''','''
         +stringReplace(SSNo,'''','''''',[rfReplaceAll])+''','''
         +stringReplace(CName,'''','''''',[rfReplaceAll])+''','
         +floattostr(UPrice)+','+floattostr(DValue)+','
         +floattostr(MValue)+','+inttostr(DType)+','''+pt_type
         +''','''+DSort+''')';
      aquery.SQL.Text := SQLStr;
      aquery.ExecSQL ;
      inc(mNo);
      result:=true;
   except
      result:=false;
   end;
end;
//过程
procedure EditEnter(aEdit:tedit);
begin
aEdit.Text :=trim(aEdit.Text);
aEdit.SelectAll ;
isSelAll:=true;
end;

procedure TReconKT02.ClearData;
begin
   CBC1.ItemIndex :=-1;
   CBC2.ItemIndex :=-1;
   EC1.Text :='0.00';
   editformat(EC1);
   STC1.Caption :='0.00';
   STC2.Caption :='0.00';
   BBC1.Enabled :=false;
   BBC2.Enabled :=false;
   TCMoney:=0;
   SetTCMoney;;
end;

procedure TReconKT02.SetSPData(isSum:boolean=false);
var
   i,j:integer;
begin
   i:=PosStrInList(m_ItemID,AQTC.fieldbyname('itemid').AsString);
   if i>=0 then CBC1.ItemIndex :=i;
   j:=PosStrInList(CBC2.Items,AQTC.fieldbyname('category').AsString);
   if j>=0 then CBC2.ItemIndex :=j;
   STC1.caption:=formatfloat('0.00',AQTC.fieldbyname('unitprice').Asfloat);
   EC1.Text:=formatfloat('0.00',AQTC.fieldbyname('actualvalue').AsFloat);
   EditFormat(EC1);
   STC2.Caption :=formatfloat('0.00',AQTC.fieldbyname('money').Asfloat);
   if isSum then
      begin
      TCMoney:=SumMoney(AQTC,'money');
      SetTCMoney;
      end;
end;

procedure TReconKT02.SetMoneySP();
begin
   STC1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[CBC1.itemindex][CBC2.ItemIndex]));
   STC2.Caption :=formatfloat('0.00',strtofloat(trim(EC1.Text))*strtofloat(STC1.Caption));
end;

procedure TReconKT02.DeleteRecord(aQuery:tadoquery);
var
   aBM:tbookmark;
begin
   try
      begin
      if application.MessageBox(DEL_CONFIRM,HINT_TEXT,MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+aQuery.fieldbyname('itemid').AsString+'''';
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
         SetSPData(true)
      else
         ClearData;
      isFirst:=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTDEL,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconKT02.SetTJMoney;
begin
   STJ2.Caption :=formatfloat('0.00',TJMoney);
   SetReconMoney;
end;

procedure TReconKT02.SetTCMoney;
begin
   STC3.Caption :=formatfloat('0.00',TCMoney);
   SetReconMoney;
end;

procedure TReconKT02.SetDrillMoney;
begin
   STDrill2.Caption :=formatfloat('0.00',DrillsMoney*strtofloat(STDrill1.Caption));
   SetReconMoney;
end;

procedure TReconKT02.SetReconMoney;
var
   aSum:double;
begin
   aSum:=strtofloat(STDrill2.caption)+strtofloat(STJ2.caption)+strtofloat(STC3.caption);
   STRecon3.Caption :=formatfloat('0.00',aSum*strtofloat(STRecon4.Caption));
end;


//事件
procedure TReconKT02.BBRecon2Click(Sender: TObject);
begin
   close;
end;

procedure TReconKT02.BBRecon1Click(Sender: TObject);
begin
application.CreateForm(TFrmCategory02,FrmCategory02);
FrmCategory02.ShowModal ;
end;

procedure TReconKT02.FormCreate(Sender: TObject);
var
   aSList:tstrings;
   aValue,aOffset,aBase,tmpBase,aDepth,aTmpDepth,aTmpStart,aUPrice:double;
   DrlItemName:tstrings;
   DrlU100Price:array of array[0..5] of double;
   RangeValue:array of double;
   ItemStart,ItemEnd,tmpStr:string;
   i,j,k,tmp_cid:integer;
   DType:SmallInt;
   aFlag:boolean;
   
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

m_mod1030:=0;
isFirst:=true;
isSelAll:=false;
STRecon1.Caption := g_ProjectInfo.prj_no ;
STRecon2.Caption := g_ProjectInfo.prj_name ;
try
   mNo:=1;
   //取调整系数
   aSList:=tstringlist.Create ;
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0102321'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      if PosStrInList(aSList,'19')>=0 then
         begin
         aValue:=ADOQuery1.FieldByName('mod1025').AsFloat;
         if aValue<1.1 then EDit1.Text :='1.10'
         else if aValue>1.3 then EDit1.Text :='1.30'
         else EDit1.Text :=formatfloat('0.00',aValue);
         EditFormat(EDit1);
         ChBRecon1.Checked :=true;
         end;
      if PosStrInList(aSList,'11')>=0 then CBDrill7.Checked :=true;
      end;
   //地质勘察项目及单价
   if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice,c4uprice,c5uprice,c6uprice from unitprice02 where substring(itemid,1,6)='''+'010203'+''' order by itemid') then
      begin
      m_ItemID:=tstringlist.create;
      while not ADOQuery1.Eof do
         begin
         m_ItemID.Add(ADOQuery1.fieldbyname('itemid').AsString);
         i:=length(m_UnitPrice);
         setlength(m_UnitPrice,i+1);
         m_UnitPrice[i]:=tstringlist.Create;
         CBC1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c4uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c5uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c6uprice').AsString);
         ADOQuery1.Next ;
         end;
      end;
   SetCBWidth(CBC1);
   //取探槽数据
   if ReopenQryFAcount(AQTC,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010203'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGC1.Columns[0].Field :=AQTC.Fields[0];
      DGC1.Columns[1].Field :=AQTC.Fields[1];
      DGC1.Columns[2].Field :=AQTC.Fields[2];
      DGC1.Columns[3].Field :=AQTC.Fields[3];
      DGC1.Columns[4].Field :=AQTC.Fields[4];
      if AQTC.RecordCount>0 then
         begin
         BBC2.Enabled :=true;
         SetSPData(true);
         end;
      end;
   //钻孔
   AQDrill.Close ;
   AQDrill.SQL.Text :='select  drl_no,drl_elev,comp_depth,prj_no,d_t_no from drills where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and d_t_no<>8';//所有非探井
   AQDrill.Open ;
   DGDrill1.Columns[0].Field :=AQDrill.Fields[0];
   DGDrill1.Columns[1].Field :=AQDrill.Fields[1];
   DGDrill1.Columns[2].Field :=AQDrill.Fields[2];

   AQMoney.Close ;
   AQMoney.SQL.Add('delete from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and  substring(Rec_No,1,4)='''+'0102'+'''');
   AQMoney.ExecSQL ;
   //Drill_Type=1 表示钻孔

   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010201'+''' order by ItemID';
   ADOQuery1.Open ;
   DrlItemName:=tstringlist.Create ;
   i:=0;
   while not ADOQuery1.Eof do
      begin
      setlength(DrlU100Price,i+1);
      DrlItemName.Add(ADOQuery1.fieldbyname('itemname').AsString);
      setlength(RangeValue,i+1);
      RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])));
      for j:=0 to 5 do
         DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   while not AQDrill.Eof do
      begin
      aValue:=AQDrill.fieldbyname('comp_depth').AsFloat;
      //钻探深度超过100时构造各档次的收费标准
      aOffset:=aValue-100;
      ItemStart:='100';
      ItemEnd:='120';
      if length(DrlU100Price)>8 then
         begin
         setlength(DrlU100Price,8);
         setlength(RangeValue,8);
         end;
      while DrlItemName.Count>8 do
         DrlItemName.Delete(8);
      i:=8;
      while aOffset>0 do
         begin
         DrlItemName.Add(ItemStart+'<D<='+ItemEnd);
         setlength(RangeValue,i+1);
         RangeValue[i]:=strtofloat(ItemEnd);
         setlength(DrlU100Price,i+1);
         //每档按前一档的收费*1.2的调整系数
         for j:=0 to 5 do
            DrlU100Price[i,j]:=DrlU100Price[i-1,j]*1.2;
         aOffset:=aOffset-20;
         ItemStart:=formatfloat('0',(strtofloat(ItemStart)+20));
         ItemEnd:=formatfloat('0',(strtofloat(ItemEnd)+20));
         inc(i);
         end;
      //-----------------------------------------------------------
      AQStratum.Close ;
      AQStratum.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category'
        +' from stratum,stratumcategory02 where prj_no='''
        +g_ProjectInfo.prj_no_ForSQL
        +''' and stra_category=id and drl_no='''
        +stringReplace(AQDrill.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
      AQStratum.Open ;

      aBase:=0;
      i:=0;
      while not AQStratum.Eof do
         begin
         i:=GetIndexOfRange(RangeValue,aBase,true);
         if i=-2 then break;
         aValue:= AQStratum.fieldbyname('stra_depth').AsFloat;
         aDepth:=aValue-aBase;
         j:=GetIndexOfRange(RangeValue,aValue,false);
         if i>j then//仅一种情况
            begin
            ItemStart:=formatfloat('0',aBase);
            ItemEnd:=formatfloat('0',aValue);

//20040826 yys edit

              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit               
            tmpStr:=copy(DrlItemName[i]
              ,pos('<=',DrlItemName[i])+2,length(DrlItemName[i])
              -(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQStratum.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              ,AQStratum.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd,DrlItemName[i]
              ,AQStratum.fieldbyname('stra_no').AsString
                +'-'+AQStratum.fieldbyname('sub_no').AsString
              ,AQStratum.fieldbyname('category').AsString
              ,aUPrice,aDepth,aUPrice*aDepth,1,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1; 
                 break;
               end;
            end
         else if i=j then//一分为二
            begin
            //---------第一段
            ItemStart:=formatfloat('0',aBase);
            ItemEnd:=formatfloat('0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-aBase;
//20040826 yys edit
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i]
              ,pos('<=',DrlItemName[i])+2,length(DrlItemName[i])
              -(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQStratum.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
            ,g_ProjectInfo.prj_no
            ,AQStratum.fieldbyname('drl_no').AsString
            ,ItemStart+'<D<='+ItemEnd,DrlItemName[i]
            ,AQStratum.fieldbyname('stra_no').AsString
            +'-'+AQStratum.fieldbyname('sub_no').AsString
            ,AQStratum.fieldbyname('category').AsString
            ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
               end;
            //---------第二段
            aTmpStart:=RangeValue[i];
            inc(i);
            ItemStart:=formatfloat('0',aTmpStart);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;
//20040826 yys edit
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i]
              ,pos('<=',DrlItemName[i])+2,length(DrlItemName[i])
              -(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQStratum.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              ,AQStratum.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd
              ,DrlItemName[i]
              ,AQStratum.fieldbyname('stra_no').AsString
              +'-'+AQStratum.fieldbyname('sub_no').AsString
              ,AQStratum.fieldbyname('category').AsString
              ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
               end;
            end
         else//一层分为多段
            begin
            //-------------第一部分
            ItemStart:=formatfloat('0.0',aBase);
            ItemEnd:=formatfloat('0.0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-aBase;
//20040826 yys edit
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i]
              ,pos('<=',DrlItemName[i])+2,length(DrlItemName[i])
              -(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQStratum.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              ,AQStratum.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd
              ,DrlItemName[i]
              ,AQStratum.fieldbyname('stra_no').AsString
              +'-'+AQStratum.fieldbyname('sub_no').AsString
              ,AQStratum.fieldbyname('category').AsString
              ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
               end;
            //-------------中间的所有部分
            k:=i+1;
            while k<=j do
               begin
//20040826 yys edit
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
               if k<6 then
                  aTmpDepth:=10
               else
                  aTmpDepth:=20;
               tmpStr:=copy(DrlItemName[k]
                 ,pos('<=',DrlItemName[k])+2,length(DrlItemName[k])
                 -(pos('<=',DrlItemName[k])+1));
               tmpStr:=stringofchar('0',3-length(tmpStr))
                 +tmpStr+AQStratum.fieldbyname('category').AsString;
               if not InsertChargeRec(adoquery1
                 ,g_ProjectInfo.prj_no
                 ,AQStratum.fieldbyname('drl_no').AsString
                 ,DrlItemName[k]
                 ,DrlItemName[k],AQStratum.fieldbyname('stra_no').AsString
                 +'-'+AQStratum.fieldbyname('sub_no').AsString
                 ,AQStratum.fieldbyname('category').AsString
                 ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
                  begin
                  application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                  i:=-1;
                  break;
                  end;
               inc(k);
               end;
            if i<0 then break;
            //-------------余下部分
            aTmpStart:=RangeValue[j];
            inc(j);
            ItemStart:=formatfloat('0',aTmpStart);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;
//20040826 yys edit
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[j,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[j]
              ,pos('<=',DrlItemName[j])+2,length(DrlItemName[j])
              -(pos('<=',DrlItemName[j])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQStratum.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              ,AQStratum.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd,DrlItemName[j]
              ,AQStratum.fieldbyname('stra_no').AsString
              +'-'+AQStratum.fieldbyname('sub_no').AsString
              ,AQStratum.fieldbyname('category').AsString
              ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
               end;
            end;
         aBase:=aValue;
         AQStratum.Next ;
         end;
      if i<0 then break;
      AQDrill.Next ;
      end;
   AQStratum.Close ;
   AQStratum.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
     +'stra_category,category from stratum,stratumcategory02'
     +' where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and stra_category=id'
     +' ORDER BY stra_depth';
   AQStratum.Open ;
   DGDrill2.Columns[0].Field :=AQStratum.Fields[0];
   DGDrill2.Columns[1].Field :=AQStratum.Fields[1];
   DGDrill2.Columns[2].Field :=AQStratum.Fields[2];

   AQMoney.Close ;
   AQMoney.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,'
     +'depth,money,prj_no,drl_no from drillcharge02'
     +' where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and Drill_Type=1 order by rec_no';
   AQMoney.Open ;
   for i:=0 to DGDrill3.Columns.Count-1 do
      DGDrill3.Columns[i].Field :=AQMoney.Fields[i];
   DrillsMoney:=SumMoney(AQMoney,'money');
   //---------------取钻孔调整系数-----------------
   aSList.Clear ;
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge'
     +' from adjustment02 where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and itemid='''+'010201'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      if PosStrInList(aSList,'08')>=0 then CBDrill1.Checked :=true;
      if PosStrInList(aSList,'09')>=0 then CBDrill2.Checked :=true;
      if PosStrInList(aSList,'18')>=0 then CBDrill4.Checked :=true;
      if PosStrInList(aSList,'10')>=0 then CBDrill5.Checked :=true;
      if PosStrInList(aSList,'12')>=0 then
         begin
         RBDrill1.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      if PosStrInList(aSList,'13')>=0 then
         begin
         RBDrill2.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      if PosStrInList(aSList,'14')>=0 then
         begin
         RBDrill3.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      if PosStrInList(aSList,'15')>=0 then
         begin
         RBDrill4.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      if PosStrInList(aSList,'16')>=0 then
         begin
         RBDrill5.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      if PosStrInList(aSList,'17')>=0 then
         begin
         RBDrill6.Checked :=true;
         CBDrill3.Checked :=true;
         end;
      end;
   SetDrillMoney;
   //取探井数据
   AQTJ.Close ;
   AQTJ.SQL.Text :='select drl_no,drl_elev,comp_depth,prj_no,d_t_no from drills where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and d_t_no=8';//所有探井
   AQTJ.Open ;
   DGJ1.Columns[0].Field :=AQTJ.Fields[0];
   DGJ1.Columns[1].Field :=AQTJ.Fields[1];
   DGJ1.Columns[2].Field :=AQTJ.Fields[2];
   //Drill_Type=2 表示探井

   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010202'+''' order by ItemID';
   ADOQuery1.Open ;
   DrlItemName.Clear;
   setlength(DrlU100Price,0);
   setlength(RangeValue,0);
   i:=0;
   while not ADOQuery1.Eof do
      begin
      setlength(DrlU100Price,i+1);
      DrlItemName.Add(ADOQuery1.fieldbyname('itemname').AsString);
      setlength(RangeValue,i+1);
      RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])));
      for j:=0 to 5 do
         DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   while not AQTJ.Eof do
      begin
      aValue:=AQTJ.fieldbyname('comp_depth').AsFloat;
      //掘进深度超过20时构造各档次的收费标准
      aOffset:=aValue-20;
      ItemStart:='20';
      ItemEnd:='30';
      if length(DrlU100Price)>4 then
         begin
         setlength(DrlU100Price,4);
         setlength(RangeValue,4);
         end;
      while DrlItemName.Count>4 do
         DrlItemName.Delete(4);
      i:=4;
      while aOffset>0 do
         begin
         DrlItemName.Add(ItemStart+'<D<='+ItemEnd);
         setlength(RangeValue,i+1);
         RangeValue[i]:=strtofloat(ItemEnd);
         setlength(DrlU100Price,i+1);
         //每档按前一档的收费*1.3的调整系数
         for j:=0 to 5 do
            DrlU100Price[i,j]:=DrlU100Price[i-1,j]*1.3;
         aOffset:=aOffset-10;
         ItemStart:=formatfloat('0',(strtofloat(ItemStart)+10));
         ItemEnd:=formatfloat('0',(strtofloat(ItemEnd)+10));
         inc(i);
         end;
      //-----------------------------------------------------------
      AQTJS.Close ;
      AQTJS.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
        +'stra_category,category from stratum,stratumcategory02'
        +' where prj_no='''
        +g_ProjectInfo.prj_no_ForSQL
        +''' and stra_category=id and drl_no='''
        +stringReplace(AQTJ.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
      AQTJS.Open ;

      aBase:=0;
      i:=0;
      while not  AQTJS.Eof do
         begin
         i:=GetIndexOfRange(RangeValue,aBase,true);
         if i=-2 then break;
         aValue:= AQTJS.fieldbyname('stra_depth').AsFloat;
         aDepth:=aValue - aBase;
         j:=GetIndexOfRange(RangeValue,aValue,false);
         if i>j then//仅一种情况
            begin
            ItemStart:=formatfloat('0',aBase);
            ItemEnd:=formatfloat('0',aValue);

//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQTJS.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              , AQTJS.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd
              ,DrlItemName[i]
              , AQTJS.fieldbyname('stra_no').AsString+'-'
              + AQTJS.fieldbyname('sub_no').AsString
              , AQTJS.fieldbyname('category').AsString
              ,aUPrice,aDepth,aUPrice*aDepth,2,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1; 
               break;
               end;
            end
         else if i=j then//一分为二
            begin
            //---------第一段
            ItemStart:=formatfloat('0',aBase);
            ItemEnd:=formatfloat('0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-aBase;
//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQTJS.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              , AQTJS.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd
              ,DrlItemName[i]
              , AQTJS.fieldbyname('stra_no').AsString
              +'-'+ AQTJS.fieldbyname('sub_no').AsString
              , AQTJS.fieldbyname('category').AsString
              ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            //---------第二段
            aTmpStart:=RangeValue[i];
            inc(i);
            ItemStart:=formatfloat('0',aTmpStart);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;
//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQTJS.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              ,g_ProjectInfo.prj_no
              , AQTJS.fieldbyname('drl_no').AsString
              ,ItemStart+'<D<='+ItemEnd
              ,DrlItemName[i]
              , AQTJS.fieldbyname('stra_no').AsString+'-'
              + AQTJS.fieldbyname('sub_no').AsString
              , AQTJS.fieldbyname('category').AsString
              ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
               begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
               end;
            end
         else//一层分为多段
            begin
            //-------------第一部分
            ItemStart:=formatfloat('0',aBase);
            ItemEnd:=formatfloat('0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-aBase;
//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQTJS.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              , g_ProjectInfo.prj_no
              , AQTJS.fieldbyname('drl_no').AsString
              , ItemStart+'<D<='+ItemEnd
              , DrlItemName[i]
              , AQTJS.fieldbyname('stra_no').AsString+'-'
              + AQTJS.fieldbyname('sub_no').AsString
              , AQTJS.fieldbyname('category').AsString
              , aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            //-------------中间的所有部分
            k:=i+1;
            while k<=j do
               begin

//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[k,tmp_cid];
//20040826 yys edit               
               if k<2 then
                  aTmpDepth:=3
               else if k<3 then
                  aTmpDepth:=5
               else
                  aTmpDepth:=10;
               tmpStr:=copy(DrlItemName[k],pos('<=',DrlItemName[k])+2,length(DrlItemName[k])-(pos('<=',DrlItemName[k])+1));
               tmpStr:=stringofchar('0',3-length(tmpStr))
                 +tmpStr+AQTJS.fieldbyname('category').AsString;
               if not InsertChargeRec(adoquery1
                 , g_ProjectInfo.prj_no
                 , AQTJS.fieldbyname('drl_no').AsString
                 , DrlItemName[k],DrlItemName[k]
                 , AQTJS.fieldbyname('stra_no').AsString+'-'
                 + AQTJS.fieldbyname('sub_no').AsString
                 , AQTJS.fieldbyname('category').AsString
                 , aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
                  begin
                  application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                  i:=-1;
                  break;
                  end;
               inc(k);
               end;
            if i<0 then break;
            //-------------余下部分
            aTmpStart:=RangeValue[j];
            inc(j);
            ItemStart:=formatfloat('0',aTmpStart);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;
//20040826 yys edit
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>5) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[j],pos('<=',DrlItemName[j])+2,length(DrlItemName[j])-(pos('<=',DrlItemName[j])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))
              +tmpStr+AQTJS.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1
              , g_ProjectInfo.prj_no
              , AQTJS.fieldbyname('drl_no').AsString
              , ItemStart+'<D<='+ItemEnd
              , DrlItemName[j]
              , AQTJS.fieldbyname('stra_no').AsString+'-'
              + AQTJS.fieldbyname('sub_no').AsString
              , AQTJS.fieldbyname('category').AsString
              , aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end;
         aBase:=aValue;
         AQTJS.Next ;
         end;
      if i<0 then break;
      AQTJ.Next ;
      end;
   AQTJS.Close ;
   AQTJS.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
     +'stra_category,category from stratum,stratumcategory02'
     +' where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and stra_category=id'
     +' ORDER BY stra_depth';
   AQTJS.Open ;
   DGJ2.Columns[0].Field :=AQTJS.Fields[0];
   DGJ2.Columns[1].Field :=AQTJS.Fields[1];
   DGJ2.Columns[2].Field :=AQTJS.Fields[2];

   AQTJM.Close ;
   AQTJM.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,'
     +'depth,money,prj_no,drl_no from drillcharge02'
     +' where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and Drill_Type=2 order by rec_no';
   AQTJM.Open ;
   for i:=0 to DGJ3.Columns.Count-1 do
      DGJ3.Columns[i].Field :=AQTJM.Fields[i];
   TJMoney:=SumMoney(AQTJM,'money');
   SetTJMoney;
   //-------------------------------------------------------
   isFirst:=false;

   AQDrill.first;
   AQTJ.First ;
   DrlItemName.free;

   aSList.Free ;
except
   application.MessageBox(DBERR_NOTREAD,HINT_TEXT);
   isFirst:=false;
end;
end;


procedure TReconKT02.AQDrillAfterScroll(DataSet: TDataSet);
begin
if not isFirst then
   begin
   AQMoney.Filtered:=false;
   AQStratum.Filtered:=false;
   AQStratum.Filter :=' drl_no='''+AQDrill.fieldbyname('drl_no').AsString+'''';
   AQStratum.Filtered :=true ;
   //
   AQMoney.Filter :=' drl_no='''+AQDrill.fieldbyname('drl_no').AsString+'''';
   AQMoney.Filtered :=true ;
   STDrill0.Caption :=formatfloat('0.00',SumMoney(AQMoney,'money'));
   end;
end;

procedure TReconKT02.AQStratumAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQMoney.Locate('Stra_sub_no',AQStratum.fieldbyname('stra_no').AsString
      +'-'+stringReplace(AQStratum.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconKT02.CBDrill1Click(Sender: TObject);
begin
   if CBDrill1.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.5)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.5);
   SetDrillMoney;
end;

procedure TReconKT02.CBDrill2Click(Sender: TObject);
begin
   if CBDrill2.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1.0)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-1.0);
   SetDrillMoney;
end;

procedure TReconKT02.CBDrill4Click(Sender: TObject);
begin
   if CBDrill4.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.2)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.2);
   SetDrillMoney;
end;

procedure TReconKT02.CBDrill5Click(Sender: TObject);
begin
   if CBDrill5.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.3)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.3);
   SetDrillMoney;
end;

procedure TReconKT02.CBDrill3Click(Sender: TObject);
begin
if CBDrill3.Checked then
   begin
   RBDrill1.Enabled :=true;
   RBDrill2.Enabled :=true;
   RBDrill3.Enabled :=true;
   RBDrill4.Enabled :=true;
   RBDrill5.Enabled :=true;
   RBDrill6.Enabled :=true;

   if RBDrill1.Checked then
      m_RBVal:=2
   else if RBDrill2.Checked then
      m_RBVal:=1
   else if RBDrill3.Checked then
      m_RBVal:=1.5
   else if RBDrill4.Checked then
      m_RBVal:=2
   else if RBDrill5.Checked then
      m_RBVal:=0.5
   else
      m_RBVal:=0.2;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+m_RBVal);
   end
else
   begin
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-m_RBVal);
   RBDrill1.Enabled :=false;
   RBDrill2.Enabled :=false;
   RBDrill3.Enabled :=false;
   RBDrill4.Enabled :=false;
   RBDrill5.Enabled :=false;
   RBDrill6.Enabled :=false;

   end;
SetDrillMoney;
end;

procedure TReconKT02.RBDrill1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+2-m_RBVal);
   m_RBVal:=2;
   SetDrillMoney;
end;

procedure TReconKT02.RBDrill2Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1-m_RBVal);
   m_RBVal:=1;
   SetDrillMoney;
end;

procedure TReconKT02.RBDrill5Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.5-m_RBVal);
   m_RBVal:=0.5;
   SetDrillMoney;
end;

procedure TReconKT02.RBDrill6Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.2-m_RBVal);
   m_RBVal:=0.2;
   SetDrillMoney;
end;

procedure TReconKT02.EDrill1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconKT02.EDrill1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconKT02.AQTCAfterInsert(DataSet: TDataSet);
begin
   if not BBC2.Enabled then BBC2.Enabled:=true;
end;


procedure TReconKT02.AQTCAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData();
   BBC1.Enabled :=false;
end;

procedure TReconKT02.CBC1Select(Sender: TObject);
begin
if not AQTC.Locate('itemid',m_ItemID[CBC1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(ec1.Text))<>0 then
      begin
      EC1.Text:='0.00';
      EditFormat(EC1);
      end;
   if CBC2.ItemIndex<0 then
      begin
      STC1.Caption :='0.00';
      STC2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP();
      if not BBC1.Enabled then BBC1.Enabled:=true;
      end;
   end
end;

procedure TReconKT02.CBC2Select(Sender: TObject);
begin
   if CBC1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBC1.Enabled then BBC1.Enabled:=true;
   SetMoneySP();
end;

procedure TReconKT02.EC1Change(Sender: TObject);
begin
   if m_EtText<>trim(EC1.Text) then BBC1.Enabled:=true;
end;

procedure TReconKT02.EC1Enter(Sender: TObject);
begin
m_EtText:=trim(EC1.Text);
EditEnter(EC1);
end;

procedure TReconKT02.EC1Exit(Sender: TObject);
begin
   if trim(EC1.Text)='' then EC1.Text :='0';
   EC1.Text :=formatfloat('0.00',strtofloat(trim(EC1.Text)));
   EditFormat(EC1);
   STC2.Caption :=formatfloat('0.00',strtofloat(STC1.Caption)*strtofloat(trim(EC1.Text)))
end;

procedure TReconKT02.BBC1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQTC.Locate('itemid;category',vararrayof([m_ItemID[CBC1.ItemIndex],CBC2.Text]), [loPartialKey]) then
         begin
         AQTC.Insert;
         AQTC.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQTC.FieldByName('itemid').AsString :=m_ItemID[CBC1.ItemIndex];
         end
      else
         AQTC.Edit ;
      AQTC.FieldByName('category').AsString :=CBC2.Text;
      AQTC.FieldByName('unitprice').Asfloat :=strtofloat(STC1.Caption);
      AQTC.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EC1.Text));
      AQTC.FieldByName('money').Asfloat :=strtofloat(STC2.Caption);
      AQTC.Post ;
      aBM:=AQTC.GetBookmark ;
      AQTC.Close ;
      AQTC.Open ;
      if AQTC.RecordCount>1 then
         AQTC.GotoBookmark(aBM);
      SetSPData(true);
      isFirst:=false;
      BBC1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconKT02.BBC2Click(Sender: TObject);
begin
DeleteRecord(AQTC);
end;

procedure TReconKT02.AQTJAfterScroll(DataSet: TDataSet);
begin
if not isFirst then
   begin
   AQTJM.Filtered:=false;
   AQTJS.Filtered:=false;
   AQTJS.Filter :=' drl_no='''+AQTJ.fieldbyname('drl_no').AsString+'''';
   AQTJS.Filtered :=true ;
   //
   AQTJM.Filter :=' drl_no='''+AQTJ.fieldbyname('drl_no').AsString+'''';
   AQTJM.Filtered :=true ;
   STJ1.Caption :=formatfloat('0.00',SumMoney(AQTJM,'money'));
   end;
end;

procedure TReconKT02.ChBRecon1Click(Sender: TObject);
begin
if ChBRecon1.Checked then
   begin
   Edit1.Enabled :=true;
   m_mod1030:=strtofloat(trim(Edit1.text));
   STRecon4.Caption :=formatfloat('0.00',strtofloat(STRecon4.Caption)+m_mod1030-1.0);
   end
else
   begin
   STRecon4.Caption :=formatfloat('0.00',strtofloat(STRecon4.Caption)-(m_mod1030-1.00));
   Edit1.Enabled :=false;
   end;
SetReconMoney;
end;

procedure TReconKT02.AQTJMAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQTJM.Locate('Stra_sub_no',AQTJS.fieldbyname('stra_no').AsString
      +'('+stringReplace(AQTJS.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll])+')',[loPartialKey]);
end;

procedure TReconKT02.FormClose(Sender: TObject; var Action: TCloseAction);
var
   aList:tstrings;
begin
   try
      begin
      //保存勘察总调整系数
      aList:=tstringlist.create;;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0102321'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='0102321';
         end;
      if ChBRecon1.Checked then
         begin
         aList.Add('19');
         ADOQuery1.fieldbyname('mod1025').AsFloat:=strtofloat(trim(edit1.text));
         end;
      if CBDrill7.Checked then aList.Add('11');
      if aList.Count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString :=aList.Text ;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STRecon4.Caption);
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存钻孔调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010201'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010201';
         end;
      if CBDrill1.Checked then aList.add('08');
      if CBDrill2.Checked then aList.add('09');
      if CBDrill3.Checked then
         if RBDrill1.Checked then aList.add('12')
         else if RBDrill2.Checked then aList.add('13')
         else if RBDrill3.Checked then aList.add('14')
         else if RBDrill4.Checked then aList.add('15')
         else if RBDrill5.Checked then aList.add('16')
         else if RBDrill6.Checked then aList.add('17');
      if CBDrill4.Checked then aList.add('18');
      if CBDrill5.Checked then aList.add('10');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STDrill1.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存地质勘察总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0102321'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='0102321';
         end;
      ADOQuery1.FieldByName('money').AsFloat :=strtofloat(STRecon3.caption);
      ADOQuery1.Post ;
      aList.Free ;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
   Action:=cafree;
end;
procedure TReconKT02.Edit1Enter(Sender: TObject);
begin
tedit(sender).Text :=trim(tedit(sender).Text);
tedit(sender).SelectAll ;
isSelAll:=true;
end;

procedure TReconKT02.Edit1Exit(Sender: TObject);
begin
   if trim(Edit1.Text)='' then Edit1.Text:='1.10';
   if strtofloat(trim(Edit1.Text))>1.3 then
      Edit1.Text :='1.30'
   else if strtofloat(trim(Edit1.Text))<1.10 then
      Edit1.Text :='1.10';
   edit1.Text :=formatfloat('0.00',strtofloat(trim(edit1.Text)));
   EditFormat(edit1);
   STRecon4.Caption :=formatfloat('0.00',strtofloat(STRecon4.Caption)+strtofloat(trim(edit1.Text))-m_mod1030);
   m_mod1030:=strtofloat(trim(Edit1.text));
   SetReconMoney;
end;

procedure TReconKT02.Edit1KeyPress(Sender: TObject; var Key: Char);
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
procedure TReconKT02.RBDrill3Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1.5-m_RBVal);
   m_RBVal:=1.5;
   SetDrillMoney;
end;

procedure TReconKT02.RBDrill4Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+2-m_RBVal);
   m_RBVal:=2;
   SetDrillMoney;
end;

procedure TReconKT02.AQTJSAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQTJM.Locate('Stra_sub_no',AQTJS.fieldbyname('stra_no').AsString+'-'
      +stringReplace(AQTJS.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconKT02.CBDrill7Click(Sender: TObject);
begin
if cbdrill7.Checked then
   STRecon4.Caption :=formatfloat('0.00',strtofloat(STRecon4.Caption)+0.3)
else
   STRecon4.Caption :=formatfloat('0.00',strtofloat(STRecon4.Caption)-0.3);
SetReconMoney;
end;

end.
