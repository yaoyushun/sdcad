unit UReconMap02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls;

type
  TReconMap02 = class(TForm)
    AQMap: TADOQuery;
    DSMap: TDataSource;
    ADOQuery1: TADOQuery;
    Label89: TLabel;
    BBRecon2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label33: TLabel;
    Label36: TLabel;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label30: TLabel;
    Label14: TLabel;
    Label24: TLabel;
    Label15: TLabel;
    Label27: TLabel;
    DBGMap1: TDBGrid;
    CBMap1: TComboBox;
    CBMap2: TComboBox;
    EdtMap1: TEdit;
    STMap1: TStaticText;
    STMap2: TStaticText;
    BBMap1: TBitBtn;
    BBMap2: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChBMap1: TCheckBox;
    ChBMap2: TCheckBox;
    STMap3: TStaticText;
    STMap4: TStaticText;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    STRecon1: TStaticText;
    STRecon2: TStaticText;
    BBRecon1: TBitBtn;
    procedure BBRecon2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBRecon1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChBMap1Click(Sender: TObject);
    procedure ChBMap2Click(Sender: TObject);
    procedure AQMapAfterScroll(DataSet: TDataSet);
    procedure AQMapAfterInsert(DataSet: TDataSet);
    procedure CBMap1Select(Sender: TObject);
    procedure CBMap2Select(Sender: TObject);
    procedure EdtMap1Change(Sender: TObject);
    procedure EdtMap1Enter(Sender: TObject);
    procedure EdtMap1Exit(Sender: TObject);
    procedure BBMap1Click(Sender: TObject);
    procedure BBMap2Click(Sender: TObject);
    procedure EdtMap1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtMap1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    isFirst:boolean;
    MapMoney:double;
    m_EtText:string;
    m_ItemID:tstrings;
    m_UnitPrice:array of tstrings;

    procedure SetMapMoney;
    procedure SetSPData(isSum:boolean=false);
    procedure SetMoneySP();
    procedure DeleteRecord(aQuery:tadoquery);
    procedure ClearData;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReconMap02: TReconMap02;

implementation
uses public_unit,MainDM,UCategoryMap02;
{$R *.dfm}
var
   isSelAll:boolean;
//过程
procedure EditEnter(aEdit:tedit);
begin
aEdit.Text :=trim(aEdit.Text);
aEdit.SelectAll ;
isSelAll:=true;
end;

procedure TReconMap02.ClearData;
begin
   CBMap1.ItemIndex :=-1;
   CBMap2.ItemIndex :=-1;
   EdtMap1.Text :='0.00';
   editformat(EdtMap1);
   STMap1.Caption :='0.00';
   STMap2.Caption :='0.00';
   BBMap1.Enabled :=false;
   BBMap2.Enabled :=false;
   MapMoney:=0;
   SetMapMoney;
end;

procedure TReconMap02.SetSPData(isSum:boolean=false);
var
   i,j:integer;
begin
   i:=PosStrInList(m_ItemID,AQMap.fieldbyname('itemid').AsString);
   if i>=0 then CBMap1.ItemIndex :=i;
   j:=PosStrInList(CBMap2.Items,AQMap.fieldbyname('category').AsString);
   if j>=0 then CBMap2.ItemIndex :=j;
   STMap1.caption:=formatfloat('0.00',AQMap.fieldbyname('unitprice').Asfloat);
   EdtMap1.Text:=formatfloat('0.00',AQMap.fieldbyname('actualvalue').AsFloat);
   EditFormat(EdtMap1);
   STMap2.Caption :=formatfloat('0.00',AQMap.fieldbyname('money').Asfloat);
   if isSum then
      begin
      MapMoney:=SumMoney(AQMap,'money');
      SetMapMoney;
      end;
end;

procedure TReconMap02.SetMoneySP();
begin
   STMap1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[CBMap1.itemindex][CBMap2.ItemIndex]));
   STMap2.Caption :=formatfloat('0.00',strtofloat(trim(EdtMap1.Text))*strtofloat(STMap1.Caption));
end;

procedure TReconMap02.DeleteRecord(aQuery:tadoquery);
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
procedure TReconMap02.SetMapMoney;
begin
   STMap4.Caption :=formatfloat('0.00',MapMoney*strtofloat(STMap3.Caption));
end;


//事件
procedure TReconMap02.BBRecon2Click(Sender: TObject);
begin
   close;
end;

procedure TReconMap02.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   aList:tstrings;
begin
   try
      begin
      //地质测绘调整系数
      aList:=tstringlist.Create ;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='0101';
         end;
      if ChBMap1.Checked then aList.add('05');
      if ChBMap2.Checked then aList.add('06');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STMap3.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存地质测绘总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='0101';
         end;
      ADOQuery1.FieldByName('money').AsFloat :=strtofloat(STMap4.caption);
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

procedure TReconMap02.BBRecon1Click(Sender: TObject);
begin
application.CreateForm(TFrmCMap02,FrmCMap02);
FrmCMap02.ShowModal ;
end;

procedure TReconMap02.FormCreate(Sender: TObject);
var
   aSList:tstrings;
   i:integer;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

aSList:=tstringlist.Create ;
isSelAll:=false;
isFirst:=true;
STRecon1.Caption := g_ProjectInfo.prj_no ;
STRecon2.Caption := g_ProjectInfo.prj_name ;
try
   //地质勘察项目及单价
   if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice from unitprice02 where substring(itemid,1,6)='''+'010101'+''' order by itemid') then
      begin
      m_ItemID:=tstringlist.Create ;
      while not ADOQuery1.Eof do
         begin
         m_ItemID.Add(ADOQuery1.fieldbyname('itemid').AsString);
         i:=length(m_UnitPrice);
         setlength(m_UnitPrice,i+1);
         m_UnitPrice[i]:=tstringlist.Create;
         CBMap1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
         m_UnitPrice[i].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
         ADOQuery1.Next ;
         end;
      end;
   SetCBWidth(CBMap1);

   //取工程地质测绘数据
   if ReopenQryFAcount(AQMap,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010101'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DBGMap1.Columns[0].Field :=AQMap.Fields[0];
      DBGMap1.Columns[1].Field :=AQMap.Fields[1];
      DBGMap1.Columns[2].Field :=AQMap.Fields[2];
      DBGMap1.Columns[3].Field :=AQMap.Fields[3];
      DBGMap1.Columns[4].Field :=AQMap.Fields[4];
      if AQMap.RecordCount>0 then
         begin
         BBMap2.Enabled :=true;
         SetSPData(true);
         end;
      end;
      //-----地质测绘调整系数----
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      if PosStrInList(aSList,'06')>=0 then ChBMap1.Checked :=true;
      if PosStrInList(aSList,'07')>=0 then ChBMap2.Checked :=true;
      end;
   //-------------------------------------------------------
   aSList.Free ;
except
   application.MessageBox(DBERR_NOTREAD,HINT_TEXT);
   isFirst:=false;
end;
end;


procedure TReconMap02.ChBMap1Click(Sender: TObject);
begin
   if ChBMap1.Checked then
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)+0.5)
   else
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)-0.5);
   SetMapMoney;
end;

procedure TReconMap02.ChBMap2Click(Sender: TObject);
begin
   if ChBMap2.Checked then
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)+0.3)
   else
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)-0.3);
   SetMapMoney;
end;

procedure TReconMap02.AQMapAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData();
   BBMap1.Enabled :=false;
end;

procedure TReconMap02.AQMapAfterInsert(DataSet: TDataSet);
begin
   if not BBMap2.Enabled then BBMap2.Enabled:=true;
end;

procedure TReconMap02.CBMap1Select(Sender: TObject);
begin
if not AQMap.Locate('itemid',m_ItemID[CBMap1.ItemIndex], [loPartialKey]) then
   begin
      if strtofloat(trim(EdtMap1.Text))<>0 then
      begin
      EdtMap1.Text:='0.00';
      EditFormat(EdtMap1);
      end;
   if CBMap2.ItemIndex<0 then
      begin
      STMap1.Caption :='0.00';
      STMap1.Caption :='0.00';
      end
   else
      begin
      SetMoneySP();
      if not BBMap1.Enabled then BBMap1.Enabled:=true;
      end;
   end
end;

procedure TReconMap02.CBMap2Select(Sender: TObject);
begin
   if CBMap1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBMap1.Enabled then BBMap1.Enabled:=true;
   SetMoneySP();
end;

procedure TReconMap02.EdtMap1Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtMap1.Text) then BBMap1.Enabled:=true;
end;

procedure TReconMap02.EdtMap1Enter(Sender: TObject);
begin
m_EtText:=trim(EdtMap1.Text);
EditEnter(EdtMap1);
end;

procedure TReconMap02.EdtMap1Exit(Sender: TObject);
begin
   if trim(EdtMap1.Text)='' then EdtMap1.Text :='0';
   EdtMap1.Text :=formatfloat('0.00',strtofloat(trim(EdtMap1.Text)));
   EditFormat(EdtMap1);
   STMap2.Caption :=formatfloat('0.00',strtofloat(STMap1.Caption)*strtofloat(trim(EdtMap1.Text)));
end;

procedure TReconMap02.BBMap1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQMap.Locate('itemid;category',vararrayof([m_ItemID[CBMap1.ItemIndex],CBMap2.Text]), [loPartialKey]) then
         begin
         AQMap.Insert;
         AQMap.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQMap.FieldByName('itemid').AsString :=m_ItemID[CBMap1.ItemIndex];
         end
      else
         AQMap.Edit ;
      AQMap.FieldByName('category').AsString :=CBMap2.Text;
      AQMap.FieldByName('unitprice').Asfloat :=strtofloat(STMap1.Caption);
      AQMap.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EdtMap1.Text));
      AQMap.FieldByName('money').Asfloat :=strtofloat(STMap2.Caption);
      AQMap.Post ;
      aBM:=AQMap.GetBookmark ;
      AQMap.Close ;
      AQMap.Open ;
      if AQMap.RecordCount>1 then
         AQMap.GotoBookmark(aBM);
      SetSPData(true);
      isFirst:=false;
      BBMap1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconMap02.BBMap2Click(Sender: TObject);
begin
DeleteRecord(AQMap);
end;


procedure TReconMap02.EdtMap1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconMap02.EdtMap1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

end.
