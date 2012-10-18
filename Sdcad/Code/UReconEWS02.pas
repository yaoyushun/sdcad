unit UReconEWS02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls;

type
  TReconEWS02 = class(TForm)
    ADOQuery1: TADOQuery;
    AQE: TADOQuery;
    DSE: TDataSource;
    Label89: TLabel;
    BBRecon2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    Label140: TLabel;
    Label139: TLabel;
    GroupBox13: TGroupBox;
    Label102: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label121: TLabel;
    Label132: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label141: TLabel;
    DGE1: TDBGrid;
    CBE1: TComboBox;
    EE1: TEdit;
    STE1: TStaticText;
    STE2: TStaticText;
    BBE1: TBitBtn;
    BBE2: TBitBtn;
    CBE2: TComboBox;
    STE3: TStaticText;
    TabSheet1: TTabSheet;
    Label82: TLabel;
    Label83: TLabel;
    GroupBox9: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label81: TLabel;
    Label90: TLabel;
    Shape7: TShape;
    Shape10: TShape;
    EWS1: TEdit;
    STWS1: TStaticText;
    EWS2: TEdit;
    EWS3: TEdit;
    STWS2: TStaticText;
    STWS3: TStaticText;
    STWS4: TStaticText;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    STRecon1: TStaticText;
    STRecon2: TStaticText;
    STRecon3: TStaticText;
    GroupBox8: TGroupBox;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Shape12: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label55: TLabel;
    CBDrill1: TCheckBox;
    RBDrill1: TRadioButton;
    RBDrill2: TRadioButton;
    RBDrill5: TRadioButton;
    RBDrill6: TRadioButton;
    STDrill1: TStaticText;
    CBDrill3: TCheckBox;
    RBDrill3: TRadioButton;
    RBDrill4: TRadioButton;
    CBDrill4: TCheckBox;
    Edit1: TEdit;
    CBDrill2: TCheckBox;
    procedure BBRecon2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EWS1Enter(Sender: TObject);
    procedure EWS2Enter(Sender: TObject);
    procedure EWS3Enter(Sender: TObject);
    procedure EWS1Exit(Sender: TObject);
    procedure EWS2Exit(Sender: TObject);
    procedure EWS3Exit(Sender: TObject);
    procedure AQEAfterInsert(DataSet: TDataSet);
    procedure AQEAfterScroll(DataSet: TDataSet);
    procedure CBE1Select(Sender: TObject);
    procedure CBE2Select(Sender: TObject);
    procedure EE1Change(Sender: TObject);
    procedure EE1Enter(Sender: TObject);
    procedure EE1Exit(Sender: TObject);
    procedure BBE1Click(Sender: TObject);
    procedure BBE2Click(Sender: TObject);
    procedure EE1KeyPress(Sender: TObject; var Key: Char);
    procedure EE1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CBDrill1Click(Sender: TObject);
    procedure RBDrill2Click(Sender: TObject);
    procedure RBDrill3Click(Sender: TObject);
    procedure RBDrill4Click(Sender: TObject);
    procedure RBDrill5Click(Sender: TObject);
    procedure RBDrill6Click(Sender: TObject);
    procedure CBDrill3Click(Sender: TObject);
    procedure CBDrill2Click(Sender: TObject);
    procedure CBDrill4Click(Sender: TObject);
    procedure RBDrill1Click(Sender: TObject);
  private
    isFirst:boolean;
    EMoney,m_mod1030:double;
    m_EtText:string;
    m_ItemID:tstrings;
    m_UnitPrice:array of tstrings;

    procedure SetEMoney;
    procedure SetReconMoney;
    procedure SetWSData;
    procedure SetSPData(isSum:boolean=false);
    procedure SetMoneySP;
    procedure DeleteRecord(aQuery:tadoquery);
    procedure ClearData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReconEWS02: TReconEWS02;

implementation
uses public_unit,MainDM;
{$R *.dfm}
var
   isSelAll:boolean;
   m_RBVal:double;
//过程
procedure EditEnter(aEdit:tedit);
begin
aEdit.Text :=trim(aEdit.Text);
aEdit.SelectAll ;
isSelAll:=true;
end;

procedure TReconEWS02.ClearData;
begin
   CBE1.ItemIndex :=-1;
   CBE2.ItemIndex :=-1;
   EE1.Text :='0';
   editformat(EE1);
   STE1.Caption :='0.00';
   STE2.Caption :='0.00';
   BBE1.Enabled :=false;
   BBE2.Enabled :=false;
   EMoney:=0;
   SetEMoney;
end;
procedure TReconEWS02.SetSPData(isSum:boolean=false);
var
   i,j:integer;
begin
   i:=PosStrInList(m_ItemID,AQE.fieldbyname('itemid').AsString);
   if i>=0 then CBE1.ItemIndex :=i;
   j:=PosStrInList(CBE2.Items,AQE.fieldbyname('category').AsString);
   if j>=0 then CBE2.ItemIndex :=j;
   STE1.caption:=formatfloat('0.00',AQE.fieldbyname('unitprice').Asfloat);
   EE1.Text:=formatfloat('0',AQE.fieldbyname('actualvalue').AsFloat);
   EditFormat(EE1);
   STE2.Caption :=formatfloat('0.00',AQE.fieldbyname('money').Asfloat);
   if isSum then
      begin
      EMoney:=SumMoney(AQE,'money');
      SetEMoney;
      end;
end;

procedure TReconEWS02.SetMoneySP();
begin
   STE1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[CBE1.itemindex][CBE2.ItemIndex]));
   STE2.Caption :=formatfloat('0.00',strtofloat(trim(EE1.Text))*strtofloat(STE1.Caption));
end;

procedure TReconEWS02.DeleteRecord(aQuery:tadoquery);
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

procedure TReconEWS02.SetEMoney;
begin
   STE3.Caption :=formatfloat('0.00',EMoney);
   SetReconMoney;
end;
procedure TReconEWS02.SetWSData;
begin
   STWS1.Caption :=formatfloat('0.00',40*strtoint(trim(EWS1.Text)));
   STWS2.Caption :=formatfloat('0.00',25*strtoint(trim(EWS2.Text)));
   STWS3.Caption :=formatfloat('0.00',200*strtoint(trim(EWS3.Text)));
   STWS4.Caption :=formatfloat('0.00',strtofloat(STWS1.Caption)+strtofloat(STWS2.Caption)+strtofloat(STWS3.Caption));
   SetReconMoney;
end;
procedure TReconEWS02.SetReconMoney;
var
   aSum:double;
begin
   aSum:=strtofloat(STE3.caption)+strtofloat(STWS4.caption);
   STRecon3.Caption :=formatfloat('0.00',aSum*strtofloat(STDrill1.Caption));
end;


//事件
procedure TReconEWS02.BBRecon2Click(Sender: TObject);
begin
   close;
end;

procedure TReconEWS02.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   aList:tstrings;
begin
   try
      begin
      //保存勘察总调整系数
      aList:=tstringlist.create;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,mod1025,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010265'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010265';
         end;
      aList.clear;
      if CBDrill2.Checked then aList.add('11');
      if CBDrill3.Checked then aList.add('18');
      if CBDrill4.Checked then
         begin
         ADOQuery1.fieldbyname('mod1025').AsFloat:=strtofloat(trim(EDit1.Text)) ;
         aList.add('19');
         end;

      if CBDrill1.Checked then
         if RBDrill1.Checked then aList.add('12')
         else if RBDrill2.Checked then aList.add('13')
         else if RBDrill3.Checked then aList.add('14')
         else if RBDrill4.Checked then aList.add('15')
         else if RBDrill5.Checked then aList.add('16')
         else if RBDrill6.Checked then aList.add('17');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STDrill1.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;

   //保存取水、石试料
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,category,actualvalue,unitprice,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010206'+'''') then
      begin
      if (ADOQuery1.RecordCount>0) and (ADOQuery1.RecordCount<3) then
         while not ADOQuery1.Eof do
            ADOQuery1.Delete ;
      if ADOQuery1.RecordCount=0 then
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01020601';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01020602';
         ADOQuery1.FieldByName('category').AsString :='取岩芯样';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01020602';
         ADOQuery1.FieldByName('category').AsString :='人工取样';
         ADOQuery1.Post ;
         ADOQuery1.Close;
         ADOQuery1.Open;
         end;
         
      ADOQuery1.First;
      ADOQuery1.edit;

      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EWS1.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=40;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS1.Caption);
      //ADOQuery1.Post ;
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EWS2.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=25;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS2.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EWS3.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=200;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS3.Caption);
      ADOQuery1.Post ;
      end;
      //保存地质勘察总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010265'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='010265';
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

procedure TReconEWS02.FormCreate(Sender: TObject);
var
   aSList:tstrings;
   i:integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

isFirst:=true;
isSelAll:=false;
STRecon1.Caption := g_ProjectInfo.prj_no ;
STRecon2.Caption := g_ProjectInfo.prj_name ;
try
   //取调整系数
   aSList:=tstringlist.Create ;
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,mod1025,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010265'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      if aSList.Count>0 then
         begin
         aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
         if PosStrInList(aSList,'11')>=0 then CBDrill2.Checked :=true;
         if PosStrInList(aSList,'18')>=0 then CBDrill3.Checked :=true;
         if PosStrInList(aSList,'19')>=0 then
            begin
            if ADOQuery1.FieldByName('mod1025').AsFloat<1.1 then EDit1.Text :='1.10'
            else if ADOQuery1.FieldByName('mod1025').AsFloat>1.3 then EDit1.Text :='1.30'
            else EDit1.Text :=formatfloat('0.00',ADOQuery1.FieldByName('mod1025').AsFloat);
            editformat(edit1);
            CBDrill4.Checked :=true;
            end;
         if PosStrInList(aSList,'12')>=0 then
            begin
            RBDrill1.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         if PosStrInList(aSList,'13')>=0 then
            begin
            RBDrill2.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         if PosStrInList(aSList,'14')>=0 then
            begin
            RBDrill3.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         if PosStrInList(aSList,'15')>=0 then
            begin
            RBDrill4.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         if PosStrInList(aSList,'16')>=0 then
            begin
            RBDrill5.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         if PosStrInList(aSList,'17')>=0 then
            begin
            RBDrill6.Checked :=true;
            CBDrill1.Checked :=true;
            end;
         end;
      end;
   //取水、石试料
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010206'+'''') then
      begin
      if ADOQuery1.RecordCount>0 then
         begin
         EWS1.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
         EditFormat(EWS1);
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EWS2.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EWS2);
            end;
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EWS3.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EWS3);
            end;
         end;
      SetWSData;
      end;
    //地质勘察项目及单价
   if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice,c4uprice,c5uprice,c6uprice from unitprice02 where substring(itemid,1,6)='''+'010205'+''' order by itemid') then
      begin
      m_ItemID:=tstringlist.create;
      while not ADOQuery1.Eof do
         begin
         m_ItemID.Add(ADOQuery1.fieldbyname('itemid').AsString);
         i:=length(m_UnitPrice);
         setlength(m_UnitPrice,i+1);
         m_UnitPrice[i]:=tstringlist.Create;
         CBE1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
         ADOQuery1.Next ;
         end;
      end;
   SetCBWidth(CBE1);

   //取土试料数据
   if ReopenQryFAcount(AQE,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010205'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGE1.Columns[0].Field :=AQE.Fields[0];
      DGE1.Columns[1].Field :=AQE.Fields[1];
      DGE1.Columns[2].Field :=AQE.Fields[2];
      DGE1.Columns[3].Field :=AQE.Fields[3];
      DGE1.Columns[4].Field :=AQE.Fields[4];
      if AQE.RecordCount>0 then
         begin
         BBE2.Enabled :=true;
         SetSPData(true);
         end;
      end;
   //-------------------------------------------------------
   isFirst:=false;
   aSList.Free;
except
   application.MessageBox(DBERR_NOTREAD,HINT_TEXT);
   isFirst:=false;
end;
end;


procedure TReconEWS02.EWS1Enter(Sender: TObject);
begin
EditEnter(EWS1);
end;

procedure TReconEWS02.EWS2Enter(Sender: TObject);
begin
EditEnter(EWS2);
end;

procedure TReconEWS02.EWS3Enter(Sender: TObject);
begin
EditEnter(EWS3);
end;

procedure TReconEWS02.EWS1Exit(Sender: TObject);
begin
   if trim(EWS1.Text)='' then EWS1.Text :='0';
   EditFormat(EWS1);
   SetWSData;
end;

procedure TReconEWS02.EWS2Exit(Sender: TObject);
begin
   if trim(EWS2.Text)='' then EWS2.Text :='0';
   EditFormat(EWS2);
   SetWSData;
end;

procedure TReconEWS02.EWS3Exit(Sender: TObject);
begin
   if trim(EWS3.Text)='' then EWS3.Text :='0';
   EditFormat(EWS3);
   SetWSData;
end;

procedure TReconEWS02.AQEAfterInsert(DataSet: TDataSet);
begin
   if not BBE2.Enabled then BBE2.Enabled:=true;
end;

procedure TReconEWS02.AQEAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData;
   BBE1.Enabled :=false;
end;

procedure TReconEWS02.CBE1Select(Sender: TObject);
begin
if not AQE.Locate('itemid',m_ItemID[CBE1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(ee1.Text))<>0 then
      begin
      EE1.Text:='0';
      EditFormat(EE1);
      end;
   if CBE2.ItemIndex<0 then
      begin
      STE1.Caption :='0.00';
      STE2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP;
      if not BBE1.Enabled then BBE1.Enabled:=true;
      end;
   end
end;

procedure TReconEWS02.CBE2Select(Sender: TObject);
begin
   if CBE1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBE1.Enabled then BBE1.Enabled:=true;
   SetMoneySP;
end;

procedure TReconEWS02.EE1Change(Sender: TObject);
begin
   if m_EtText<>trim(EE1.Text) then BBE1.Enabled:=true;
end;

procedure TReconEWS02.EE1Enter(Sender: TObject);
begin
m_EtText:=trim(EE1.Text);
EditEnter(EE1);
end;

procedure TReconEWS02.EE1Exit(Sender: TObject);
begin
   if trim(EE1.Text)='' then EE1.Text :='0';
   EE1.Text :=formatfloat('0',strtofloat(trim(EE1.Text)));
   EditFormat(EE1);
   STE2.Caption :=formatfloat('0.00',strtofloat(STE1.Caption)*strtofloat(trim(EE1.Text)))
end;

procedure TReconEWS02.BBE1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQE.Locate('itemid;category',vararrayof([m_ItemID[CBE1.ItemIndex],CBE2.Text]), [loPartialKey]) then
         begin
         AQE.Insert;
         AQE.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQE.FieldByName('itemid').AsString :=m_ItemID[CBE1.ItemIndex];
         end
      else
         AQE.Edit ;
      AQE.FieldByName('category').AsString :=CBE2.Text;
      AQE.FieldByName('unitprice').Asfloat :=strtofloat(STE1.Caption);
      AQE.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EE1.Text));
      AQE.FieldByName('money').Asfloat :=strtofloat(STE2.Caption);
      AQE.Post ;
      aBM:=AQE.GetBookmark ;
      AQE.Close ;
      AQE.Open ;
      if AQE.RecordCount>1 then
         AQE.GotoBookmark(aBM);
      SetSPData(true);
      isFirst:=false;
      BBE1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconEWS02.BBE2Click(Sender: TObject);
begin
DeleteRecord(AQE);
end;

procedure TReconEWS02.EE1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconEWS02.EE1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconEWS02.Edit1Enter(Sender: TObject);
begin
tedit(sender).Text :=trim(tedit(sender).Text);
tedit(sender).SelectAll ;
isSelAll:=true;
end;

procedure TReconEWS02.Edit1Exit(Sender: TObject);
begin
   if trim(Edit1.Text)='' then Edit1.Text:='1.10';
   if strtofloat(trim(Edit1.Text))>1.3 then
      Edit1.Text :='1.30'
   else if strtofloat(trim(Edit1.Text))<1.10 then
      Edit1.Text :='1.10';
   edit1.Text :=formatfloat('0.00',strtofloat(trim(edit1.Text)));
   EditFormat(edit1);
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+strtofloat(trim(edit1.Text))-m_mod1030);
   m_mod1030:=strtofloat(trim(Edit1.text));
   SetReconMoney;
end;

procedure TReconEWS02.Edit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconEWS02.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconEWS02.CBDrill1Click(Sender: TObject);
begin
if CBDrill1.Checked then
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
   else if RBDrill2.Checked then
      m_RBVal:=2
   else if RBDrill3.Checked then
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
SetReconMoney;
end;

procedure TReconEWS02.RBDrill2Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1-m_RBVal);
   m_RBVal:=1;
   SetReconMoney;
end;

procedure TReconEWS02.RBDrill3Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1.5-m_RBVal);
   m_RBVal:=1.5;
   SetReconMoney;
end;

procedure TReconEWS02.RBDrill4Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+2-m_RBVal);
   m_RBVal:=2;
   SetReconMoney;
end;

procedure TReconEWS02.RBDrill5Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.5-m_RBVal);
   m_RBVal:=0.5;
   SetReconMoney;
end;

procedure TReconEWS02.RBDrill6Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.2-m_RBVal);
   m_RBVal:=0.2;
   SetReconMoney;
end;

procedure TReconEWS02.CBDrill3Click(Sender: TObject);
begin
   if CBDrill3.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.2)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.2);
   SetReconMoney;
end;

procedure TReconEWS02.CBDrill2Click(Sender: TObject);
begin
if CBDrill2.Checked then
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.3)
else
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.3);
   SetReconMoney;
end;

procedure TReconEWS02.CBDrill4Click(Sender: TObject);
begin
if CBDrill4.Checked then
   begin
   Edit1.Enabled :=true;
   m_mod1030:=strtofloat(trim(Edit1.text));
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+m_mod1030-1.0);
   end
else
   begin
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-(m_mod1030-1.00));
   Edit1.Enabled :=false;
   end;
SetReconMoney;
end;

procedure TReconEWS02.RBDrill1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+2-m_RBVal);
   m_RBVal:=2;
   SetReconMoney;
end;

end.
