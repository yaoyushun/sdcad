unit UReconYWCS02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls;

type
  TReconYWCS02 = class(TForm)
    ADOQuery1: TADOQuery;
    DSP: TDataSource;
    AQP: TADOQuery;
    AQDT1: TADOQuery;
    DSDT1: TDataSource;
    AQJT1: TADOQuery;
    DSJT1: TDataSource;
    AQJT2: TADOQuery;
    DSJT2: TDataSource;
    AQJT3: TADOQuery;
    DSJT3: TDataSource;
    AQBG1: TADOQuery;
    DSBG1: TDataSource;
    AQBG2: TADOQuery;
    AQCB1: TADOQuery;
    DSCB1: TDataSource;
    AQCB2: TADOQuery;
    AQDT2: TADOQuery;
    DSZ: TDataSource;
    AQZ: TADOQuery;
    DST: TDataSource;
    AQT: TADOQuery;
    DSB: TDataSource;
    AQB: TADOQuery;
    DSQ: TDataSource;
    AQQ: TADOQuery;
    DSBC: TDataSource;
    AQBC: TADOQuery;
    BBRecon2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet5: TTabSheet;
    Label164: TLabel;
    Label165: TLabel;
    GroupBox15: TGroupBox;
    Label43: TLabel;
    Label65: TLabel;
    STCB1: TStaticText;
    DGCB1: TDBGrid;
    GroupBox16: TGroupBox;
    Label154: TLabel;
    Label155: TLabel;
    STBG1: TStaticText;
    DGBG1: TDBGrid;
    STBGCB1: TStaticText;
    TabSheet6: TTabSheet;
    Label68: TLabel;
    Label35: TLabel;
    GroupBox14: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Shape13: TShape;
    Label81: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label89: TLabel;
    STJT1: TStaticText;
    DGJT1: TDBGrid;
    DGJT2: TDBGrid;
    DGJT3: TDBGrid;
    STJT2: TStaticText;
    ChBJT1: TCheckBox;
    ChBJT2: TCheckBox;
    STCT1: TStaticText;
    GroupBox17: TGroupBox;
    Label172: TLabel;
    Label173: TLabel;
    DGDT1: TDBGrid;
    STDT1: TStaticText;
    TabSheet7: TTabSheet;
    Label124: TLabel;
    Label125: TLabel;
    STZT1: TStaticText;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Shape6: TShape;
    DGT1: TDBGrid;
    CBT1: TComboBox;
    ET1: TEdit;
    STT1: TStaticText;
    STT2: TStaticText;
    STT3: TStaticText;
    BBT1: TBitBtn;
    BBT2: TBitBtn;
    CBT2: TComboBox;
    GroupBox5: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Shape12: TShape;
    Label69: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label102: TLabel;
    Label117: TLabel;
    DGZ1: TDBGrid;
    CBZ1: TComboBox;
    EZ1: TEdit;
    STZ1: TStaticText;
    STZ2: TStaticText;
    STZ3: TStaticText;
    BBZ1: TBitBtn;
    BBZ2: TBitBtn;
    CBZ2: TComboBox;
    EZ2: TEdit;
    TabSheet1: TTabSheet;
    Label23: TLabel;
    Label24: TLabel;
    STPYZ1: TStaticText;
    GroupBox11: TGroupBox;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label138: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    EYZ2: TEdit;
    STYZ2: TStaticText;
    STYZ5: TStaticText;
    EYZ3: TEdit;
    EYZ4: TEdit;
    STYZ3: TStaticText;
    STYZ4: TStaticText;
    EYZ1: TEdit;
    STYZ1: TStaticText;
    GroupBox10: TGroupBox;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Shape5: TShape;
    DGP1: TDBGrid;
    CBP1: TComboBox;
    EP1: TEdit;
    STP1: TStaticText;
    STP2: TStaticText;
    STP3: TStaticText;
    BBP1: TBitBtn;
    BBP2: TBitBtn;
    CBP2: TComboBox;
    TabSheet2: TTabSheet;
    Label51: TLabel;
    Label52: TLabel;
    GroupBox4: TGroupBox;
    Label36: TLabel;
    Label41: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Shape8: TShape;
    Label54: TLabel;
    Label42: TLabel;
    Label53: TLabel;
    DGYTBX1: TDBGrid;
    CBYTBX1: TComboBox;
    EYTBX1: TEdit;
    STYTBX1: TStaticText;
    STYTBX2: TStaticText;
    STYTBX3: TStaticText;
    BBYTBX1: TBitBtn;
    BBYTBX2: TBitBtn;
    CBYTBX2: TComboBox;
    EYTBX2: TEdit;
    STYT1: TStaticText;
    GroupBox3: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Shape7: TShape;
    Label27: TLabel;
    DGYTQD1: TDBGrid;
    CBYTQD1: TComboBox;
    EYTQD1: TEdit;
    STYTQD1: TStaticText;
    STYTQD2: TStaticText;
    STYTQD3: TStaticText;
    BBYTQD1: TBitBtn;
    BBYTQD2: TBitBtn;
    CBYTQD2: TComboBox;
    TabSheet3: TTabSheet;
    Label90: TLabel;
    Label91: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Shape4: TShape;
    DGBC1: TDBGrid;
    CBBC1: TComboBox;
    EBC1: TEdit;
    STBC1: TStaticText;
    STBC2: TStaticText;
    STBC3: TStaticText;
    BBBC1: TBitBtn;
    BBBC2: TBitBtn;
    CBBC2: TComboBox;
    GroupBox9: TGroupBox;
    Label73: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label80: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    EYTYW3: TEdit;
    STYTYW3: TStaticText;
    STYTYW4: TStaticText;
    EYTYW1: TEdit;
    EYTYW2: TEdit;
    STYTYW1: TStaticText;
    STYTYW2: TStaticText;
    STBY1: TStaticText;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label64: TLabel;
    STRecon1: TStaticText;
    STRecon2: TStaticText;
    STYWCS2: TStaticText;
    STYWCS1: TStaticText;
    BBYWCS1: TBitBtn;
    BBRecon1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EYZ1Enter(Sender: TObject);
    procedure EYZ1Exit(Sender: TObject);
    procedure EYZ2Enter(Sender: TObject);
    procedure EYZ3Enter(Sender: TObject);
    procedure EYZ4Enter(Sender: TObject);
    procedure EYZ2Exit(Sender: TObject);
    procedure EYZ3Exit(Sender: TObject);
    procedure EYZ4Exit(Sender: TObject);
    procedure CBP1Select(Sender: TObject);
    procedure CBP2Select(Sender: TObject);
    procedure EP1Change(Sender: TObject);
    procedure EP1Enter(Sender: TObject);
    procedure EP1Exit(Sender: TObject);
    procedure BBP1Click(Sender: TObject);
    procedure BBP2Click(Sender: TObject);
    procedure AQPAfterInsert(DataSet: TDataSet);
    procedure AQPAfterScroll(DataSet: TDataSet);
    procedure AQJT1AfterScroll(DataSet: TDataSet);
    procedure AQJT2AfterScroll(DataSet: TDataSet);
    procedure EP1KeyPress(Sender: TObject; var Key: Char);
    procedure EYWCS1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BBYWCS1Click(Sender: TObject);
    procedure ChBJT1Click(Sender: TObject);
    procedure ChBJT2Click(Sender: TObject);
    procedure CBZ1Select(Sender: TObject);
    procedure CBZ2Select(Sender: TObject);
    procedure EZ1Change(Sender: TObject);
    procedure EZ1Enter(Sender: TObject);
    procedure EZ1Exit(Sender: TObject);
    procedure EZ2Enter(Sender: TObject);
    procedure EZ2Exit(Sender: TObject);
    procedure AQZAfterScroll(DataSet: TDataSet);
    procedure AQZAfterInsert(DataSet: TDataSet);
    procedure BBZ2Click(Sender: TObject);
    procedure CBZ1DropDown(Sender: TObject);
    procedure CBZ1CloseUp(Sender: TObject);
    procedure CBT1Select(Sender: TObject);
    procedure CBT2Select(Sender: TObject);
    procedure ET1Change(Sender: TObject);
    procedure ET1Enter(Sender: TObject);
    procedure ET1Exit(Sender: TObject);
    procedure AQTAfterInsert(DataSet: TDataSet);
    procedure AQTAfterScroll(DataSet: TDataSet);
    procedure BBT1Click(Sender: TObject);
    procedure BBZ1Click(Sender: TObject);
    procedure BBT2Click(Sender: TObject);
    procedure CBBC1Select(Sender: TObject);
    procedure CBBC2Select(Sender: TObject);
    procedure EBC1Change(Sender: TObject);
    procedure EBC1Enter(Sender: TObject);
    procedure EBC1Exit(Sender: TObject);
    procedure BBBC1Click(Sender: TObject);
    procedure BBBC2Click(Sender: TObject);
    procedure CBYTQD1Select(Sender: TObject);
    procedure CBYTQD2Select(Sender: TObject);
    procedure EYTQD1Change(Sender: TObject);
    procedure EYTQD1Enter(Sender: TObject);
    procedure EYTQD1Exit(Sender: TObject);
    procedure BBYTQD1Click(Sender: TObject);
    procedure CBYTBX1Select(Sender: TObject);
    procedure CBYTBX2Select(Sender: TObject);
    procedure EYTBX1Change(Sender: TObject);
    procedure EYTBX1Enter(Sender: TObject);
    procedure EYTBX1Exit(Sender: TObject);
    procedure BBYTBX1Click(Sender: TObject);
    procedure BBYTBX2Click(Sender: TObject);
    procedure CBYTBX1CloseUp(Sender: TObject);
    procedure CBYTBX1DropDown(Sender: TObject);
    procedure EYTBX2Enter(Sender: TObject);
    procedure EYTBX2Exit(Sender: TObject);
    procedure EYTYW2Enter(Sender: TObject);
    procedure EYTYW3Enter(Sender: TObject);
    procedure EYTYW1Exit(Sender: TObject);
    procedure EYTYW1Enter(Sender: TObject);
    procedure EYTYW2Exit(Sender: TObject);
    procedure EYTYW3Exit(Sender: TObject);
    procedure BBRecon2Click(Sender: TObject);
    procedure BBYTQD2Click(Sender: TObject);
    procedure AQBCAfterInsert(DataSet: TDataSet);
    procedure AQBCAfterScroll(DataSet: TDataSet);
    procedure AQQAfterInsert(DataSet: TDataSet);
    procedure AQQAfterScroll(DataSet: TDataSet);
    procedure AQBAfterInsert(DataSet: TDataSet);
    procedure AQBAfterScroll(DataSet: TDataSet);
    procedure BBRecon1Click(Sender: TObject);
  private
    isFirst:boolean;
    DTMoney,JTMoney,ZMoney,TMoney,PMoney,BXMoney,QDMoney,BCMoney,m_mod1030,adMoney:double;
    m_EtText:string;
    m_ItemID:array[0..5] of tstrings;
    m_UnitPrice:array[0..5] of array of tstrings;
    m_AdMod:tstrings;
                            
    procedure setJTMoney;
    procedure SetZMoney;
    procedure SetPMoney;
    procedure SetTMoney;
    procedure SetBCMoney;
    procedure SetYTBXMoney;
    procedure SetYTQDMoney;
    procedure SetYTYWData;        
    procedure setCTMoney;
    procedure SetReconMoney;
    procedure SetYZData;
    procedure SetPYZData;
    procedure SetBYData;
    procedure SetBQData;
    procedure SetZTMoney;
    procedure SetDBCData;
    procedure SetSPData(aIndex:integer;isSum:boolean=false);
    procedure SetMoneySP(aIndex:integer);
    procedure DeleteRecord(aQuery:tadoquery;aIndex:integer);
    procedure ClearData(aIndex:integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReconYWCS02: TReconYWCS02;

implementation
uses public_unit,MainDM,UCategory02,UAdjustment;
{$R *.dfm}
var
   isSelAll:boolean;
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

function InsertChargeRec(aQuery:tadoquery;PrjNo,DrlNo,ItemName,DRange,SSNo,CName:string;UPrice,DValue,MValue:double;DType:SmallInt;PtType,DSort:string):boolean;
var
   SQLStr,RNo:string;
begin
   try
      RNo:='0103'+ComSrtring(mNo,4);
      aquery.Close ;
      SQLStr:='insert into drillcharge02 values('''+RNo+''','''
              +stringReplace(PrjNo ,'''','''''',[rfReplaceAll])
              +''','''+stringReplace(DrlNo ,'''','''''',[rfReplaceAll])+''','''+ItemName+''','''+DRange+''','''
              +stringReplace(SSNo,'''','''''',[rfReplaceAll])
              +''','''+stringReplace(CName,'''','''''',[rfReplaceAll])
              +''','+floattostr(UPrice)+','+floattostr(DValue)+','
              +floattostr(MValue)+','+inttostr(DType)+','''+PtType
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

procedure TReconYWCS02.EYTBX2Exit(Sender: TObject);
var
   i,j,j1,k,aValue:integer;
   aItem:string;
   aBM:tbookmark;
   aFlag:boolean;
begin
   if trim(EYTBX2.Text)='' then EYTBX2.Text :='0';
   EditFormat(EYTBX2);

   isFirst:=true;
   if AQB.RecordCount>0then
      begin
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='delete from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+copy(AQZ.fieldbyname('itemid').AsString,1,6)+''' and subno<>'''+'0'+'''';
      ADOQuery1.ExecSQL ;
      end;
   AQB.Close;
   AQB.Open ;
   aValue:=strtoint(trim(EYTBX2.Text));
   if aValue<=0 then
      begin
         isFirst:=false;
         if AQB.RecordCount<=0 then
            ClearData(4);
         exit;
      end;
   AQB.Last ;
   aBM:=AQB.GetBookmark ;
   i:=CBYTBX1.Items.Count-1;
   aItem:=m_ItemID[4][i];
   j:=aValue DIV 500;
   if j>=1 then
      while m_ItemID[4].Count>i do
         m_ItemID[4].Delete(i);
   aFlag:=false;
   for j1:=1 to j do
      begin
      setlength(m_UnitPrice[4],i+1);
      if m_UnitPrice[4][i]<>nil then m_UnitPrice[4][i].Free;
      m_UnitPrice[4][i]:=tstringlist.Create ;
      m_ItemID[4].Add(aItem);
      for k:=0 to m_UnitPrice[4][i-1].Count-1 do
         begin
         m_UnitPrice[4][i].Add(floattostr(strtofloat(m_UnitPrice[4][i-1][k])*1.1));
         AQB.Insert ;
         if not aFlag then aFlag:=true;
         AQB.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQB.FieldByName('itemid').AsString :=aItem ;
         AQB.FieldByName('category').AsString :=CBYTBX2.Items[k];
         AQB.FieldByName('unitprice').AsFloat :=strtofloat(m_UnitPrice[4][i][k]) ;
         AQB.FieldByName('subno').AsString :=inttostr(j1);
         AQB.FieldByName('actualvalue').AsFloat :=0 ;
         end;
      inc(i);
      end;
   if aFlag then
      begin
      AQB.Post ;
      AQB.Close;
      AQB.Open ;
      if aBM<>nil then
         begin
         AQB.GotoBookmark(aBM);
         isFirst:=false;
         AQB.Next ;
         end;
      end
   else
      isFirst:=false;
end;

procedure TReconYWCS02.EYTBX2Enter(Sender: TObject);
begin
EditEnter(EYTBX2);
end;

procedure TReconYWCS02.CBYTBX1DropDown(Sender: TObject);
begin
   CBYTBX1.Items.Delete(CBYTBX1.Items.Count-1);
end;

procedure TReconYWCS02.CBYTBX1CloseUp(Sender: TObject);
begin
CBYTBX1.Items.Add(CBYTBX1.Hint);
if CBYTBX1.ItemIndex=-1 then CBYTBX1.ItemIndex :=CBYTBX1.Items.Count-1; 
end;

procedure TReconYWCS02.BBYTBX2Click(Sender: TObject);
begin
DeleteRecord(AQB,4);
end;

procedure TReconYWCS02.BBYTBX1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQB.Locate('itemid;category',vararrayof([m_ItemID[4][CBYTBX1.ItemIndex],CBYTBX2.Text]), [loPartialKey]) then
         begin
         AQB.Insert;
         AQB.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQB.FieldByName('itemid').AsString :=m_ItemID[4][CBYTBX1.ItemIndex];
         end
      else
         AQB.Edit;
      AQB.FieldByName('category').AsString :=CBYTBX2.Text;
      AQB.FieldByName('unitprice').Asfloat :=strtofloat(STYTBX1.Caption);
      AQB.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EYTBX1.Text));
      AQB.FieldByName('money').Asfloat :=strtofloat(STYTBX2.Caption);
      AQB.Post ;
      aBM:=AQB.GetBookmark ;
      AQB.Close ;
      AQB.Open ;
      if AQB.RecordCount>1 then
         AQB.GotoBookmark(aBM);
      SetSPData(4,true);
      isFirst:=false;
      BBYTBX1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.SetZMoney;
begin
   STZ3.caption:=formatfloat('0.00',ZMoney);
   SetZTMoney;
end;

procedure TReconYWCS02.setJTMoney;
var
   aValue:double;
begin
   aValue:=JTMoney;
   if ChBJT1.Checked then aValue:=aValue*1.15;
   if ChBJT2.Checked then aValue:=aValue*1.2;
   STJT2.caption:=formatfloat('0.00',aValue);
   SetCTMoney;
end;

procedure TReconYWCS02.setCTMoney;
begin
   STCT1.caption:=formatfloat('0.00',strtofloat(STDT1.Caption)+strtofloat(STJT2.Caption));
   SetReconMoney;
end ;

procedure TReconYWCS02.ClearData(aIndex:integer);
begin
   if aIndex=0 then
      begin
      CBBC1.ItemIndex :=-1;
      CBBC2.ItemIndex :=-1;
      EBC1.Text :='0';
      editformat(EBC1);
      STBC1.Caption :='0.00';
      STBC2.Caption :='0.00';
      BBBC1.Enabled :=false;
      BBBC2.Enabled :=false;
      BCMoney:=0;
      SetBCMoney;
      end
   else if aIndex=1 then
      begin
      CBP1.ItemIndex :=-1;
      CBP2.ItemIndex :=-1;
      EP1.Text :='0';
      editformat(EP1);
      STP1.Caption :='0.00';
      STP2.Caption :='0.00';
      BBP1.Enabled :=false;
      BBP2.Enabled :=false;
      PMoney:=0;
      SetPMoney;
      end
   else if aIndex=2 then
      begin
      CBZ1.ItemIndex :=-1;
      CBZ2.ItemIndex :=-1;
      EZ1.Text :='0';
      editformat(EZ1);
      STZ1.Caption :='0.00';
      STZ2.Caption :='0.00';
      BBZ1.Enabled :=false;
      BBZ2.Enabled :=false;
      ZMoney:=0;
      SetZMoney;
      end
   else if aIndex=3 then
      begin
      CBT1.ItemIndex :=-1;
      CBT2.ItemIndex :=-1;
      ET1.Text :='0';
      editformat(ET1);
      STT1.Caption :='0.00';
      STT2.Caption :='0.00';
      BBT1.Enabled :=false;
      BBT2.Enabled :=false;
      TMoney:=0;
      SetTMoney;
      end

   else if aIndex=4 then
      begin
      CBYTBX1.ItemIndex :=-1;
      CBYTBX2.ItemIndex :=-1;
      EYTBX1.Text :='0';
      editformat(EYTBX1);
      STYTBX1.Caption :='0.00';
      STYTBX2.Caption :='0.00';
      BBYTBX1.Enabled :=false;
      BBYTBX2.Enabled :=false;
      BXMoney:=0;
      SetYTBXMoney;
      end
   else if aIndex=5 then
      begin
      CBYTQD1.ItemIndex :=-1;
      CBYTQD2.ItemIndex :=-1;
      EYTQD1.Text :='0';
      editformat(EYTQD1);
      STYTQD1.Caption :='0.00';
      STYTQD2.Caption :='0.00';
      BBYTQD1.Enabled :=false;
      BBYTQD2.Enabled :=false;
      QDMoney:=0;
      SetYTQDMoney;
      end;
end;

procedure TReconYWCS02.SetSPData(aIndex:integer;isSum:boolean=false);
var
   i,j:integer;
begin
   if aIndex=0 then
      begin
      i:=PosStrInList(m_ItemID[0],AQBC.fieldbyname('itemid').AsString);
      if i>=0 then CBBC1.ItemIndex :=i;
      j:=PosStrInList(CBBC2.Items,AQBC.fieldbyname('category').AsString);
      if j>=0 then CBBC2.ItemIndex :=j;
      STBC1.caption:=formatfloat('0.00',AQBC.fieldbyname('unitprice').Asfloat);
      EBC1.Text:=formatfloat('0',AQBC.fieldbyname('actualvalue').AsFloat);
      EditFormat(EBC1);
      STBC2.Caption :=formatfloat('0.00',AQBC.fieldbyname('money').Asfloat);
      if isSum then
         begin
         BCMoney:=SumMoney(AQBC,'money');
         SetBCMoney;
         end;
      end
   else if aIndex=1 then
      begin
      i:=PosStrInList(m_ItemID[1],AQP.fieldbyname('itemid').AsString);
      if i>=0 then CBP1.ItemIndex :=i;
      j:=PosStrInList(CBP2.Items,AQP.fieldbyname('category').AsString);
      if j>=0 then CBP2.ItemIndex :=j;
      STP1.caption:=formatfloat('0.00',AQP.fieldbyname('unitprice').Asfloat);
      EP1.Text:=formatfloat('0',AQP.fieldbyname('actualvalue').AsFloat);
      EditFormat(EP1);
      STP2.Caption :=formatfloat('0.00',AQP.fieldbyname('money').Asfloat);
      if isSum then
         begin
         PMoney:=SumMoney(AQP,'money');
         SetPMoney;
         end;
      end
   else if aIndex=2 then
      begin
      i:=PosStrInList(m_ItemID[2],AQZ.fieldbyname('itemid').AsString);
      if i>=0 then CBZ1.ItemIndex :=i
      else if AQZ.FieldByName('subno').AsString>'0' then CBZ1.Text :=AQZ.FieldByName('itemname').AsString;
      j:=PosStrInList(CBZ2.Items,AQZ.fieldbyname('category').AsString);
      if j>=0 then CBZ2.ItemIndex :=j;
      STZ1.caption:=formatfloat('0.00',AQZ.fieldbyname('unitprice').Asfloat);
      EZ1.Text:=formatfloat('0',AQZ.fieldbyname('actualvalue').AsFloat);
      EditFormat(EZ1);
      STZ2.Caption :=formatfloat('0.00',AQZ.fieldbyname('money').Asfloat);
      if isSum then
         begin
         ZMoney:=SumMoney(AQZ,'money');
         SetZMoney;
         end;
      end
   else if aIndex=3 then
      begin
      i:=PosStrInList(m_ItemID[3],AQT.fieldbyname('itemid').AsString);
      if i>=0 then CBT1.ItemIndex :=i;
      j:=PosStrInList(CBT2.Items,AQT.fieldbyname('category').AsString);
      if j>=0 then CBT2.ItemIndex :=j;
      STT1.caption:=formatfloat('0.00',AQT.fieldbyname('unitprice').Asfloat);
      ET1.Text:=formatfloat('0',AQT.fieldbyname('actualvalue').AsFloat);
      EditFormat(ET1);
      STT2.Caption :=formatfloat('0.00',AQT.fieldbyname('money').Asfloat);
      if isSum then
         begin
         TMoney:=SumMoney(AQT,'money');
         SetTMoney;
         end;
      end
   else if aIndex=4 then
      begin
      i:=PosStrInList(m_ItemID[4],AQB.fieldbyname('itemid').AsString);
      if i>=0 then CBYTBX1.ItemIndex :=i
      else if AQB.FieldByName('subno').AsString>'0' then CBYTBX1.Text :=AQB.FieldByName('itemname').AsString;
      j:=PosStrInList(CBYTBX2.Items,AQB.fieldbyname('category').AsString);
      if j>=0 then CBYTBX2.ItemIndex :=j;
      STYTBX1.caption:=formatfloat('0.00',AQB.fieldbyname('unitprice').Asfloat);
      EYTBX1.Text:=formatfloat('0',AQB.fieldbyname('actualvalue').AsFloat);
      EditFormat(EYTBX1);
      STYTBX2.Caption :=formatfloat('0.00',AQB.fieldbyname('money').Asfloat);
      if isSum then
         begin
         BXMoney:=SumMoney(AQB,'money');
         SetYTBXMoney;
         end;
      end
   else if aIndex=5 then
      begin
      i:=PosStrInList(m_ItemID[5],AQQ.fieldbyname('itemid').AsString);
      if i>=0 then CBYTQD1.ItemIndex :=i;
      j:=PosStrInList(CBYTQD2.Items,AQQ.fieldbyname('category').AsString);
      if j>=0 then CBYTQD2.ItemIndex :=j;
      STYTQD1.caption:=formatfloat('0.00',AQQ.fieldbyname('unitprice').Asfloat);
      EYTQD1.Text:=formatfloat('0',AQQ.fieldbyname('actualvalue').AsFloat);
      EditFormat(EYTQD1);
      STYTQD2.Caption :=formatfloat('0.00',AQQ.fieldbyname('money').Asfloat);
      if isSum then
         begin
         QDMoney:=SumMoney(AQQ,'money');
         SetYTQDMoney;
         end;
      end;

end;

procedure TReconYWCS02.SetMoneySP(aIndex:integer);
begin
   if aIndex=0 then
      begin
      STBC1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[0,CBBC1.itemindex][CBBC2.ItemIndex]));
      STBC2.Caption :=formatfloat('0.00',strtofloat(trim(EBC1.Text))*strtofloat(STBC1.Caption));
      end
   else if aIndex=1 then
      begin
      STP1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[1,CBP1.itemindex][CBP2.ItemIndex]));
      STP2.Caption :=formatfloat('0.00',strtofloat(trim(EP1.Text))*strtofloat(STP1.Caption));
      end
   else if aIndex=2 then
      begin
      STZ1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[2,CBZ1.itemindex][CBZ2.ItemIndex]));
      STZ2.Caption :=formatfloat('0.00',strtofloat(trim(EZ1.Text))*strtofloat(STZ1.Caption));
      end
   else if aIndex=3 then
      begin
      STT1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[3,CBT1.itemindex][CBT2.ItemIndex]));
      STT2.Caption :=formatfloat('0.00',strtofloat(trim(ET1.Text))*strtofloat(STT1.Caption));
      end
   else if aIndex=4 then
      begin
      STYTBX1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[4,CBYTBX1.itemindex][CBYTBX2.ItemIndex]));
      STYTBX2.Caption :=formatfloat('0.00',strtofloat(trim(EYTBX1.Text))*strtofloat(STYTBX1.Caption));
      end
   else if aIndex=5 then
      begin
      STYTQD1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[5,CBYTQD1.itemindex][CBYTQD2.ItemIndex]));
      STYTQD2.Caption :=formatfloat('0.00',strtofloat(trim(EYTQD1.Text))*strtofloat(STYTQD1.Caption));
      end;
end;

procedure TReconYWCS02.DeleteRecord(aQuery:tadoquery;aIndex:integer);
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
         SetSPData(aIndex,true)
      else
         ClearData(aIndex);
      isFirst:=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTDEL,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.SetPMoney;
begin
   STP3.Caption :=formatfloat('0.00',PMoney);
   SetPYZData;
end;

procedure TReconYWCS02.SetTMoney;
begin
   STT3.Caption :=formatfloat('0.00',TMoney);
   SetZTMoney;
end;

procedure TReconYWCS02.SetBCMoney;
begin
   STBC3.Caption :=formatfloat('0.00',BCMoney);
   SetBYData;
end;

procedure TReconYWCS02.SetYTBXMoney;
begin
   STYTBX3.Caption :=formatfloat('0.00',BXMoney);
   SetBQData;
end;

procedure TReconYWCS02.SetYTQDMoney;
begin
   STYTQD3.Caption :=formatfloat('0.00',QDMoney);
   SetBQData;
end;

procedure TReconYWCS02.SetYZData;
begin
   STYZ1.Caption :=formatfloat('0.00',1753*strtoint(trim(EYZ1.Text)));
   STYZ2.Caption :=formatfloat('0.00',2104*strtoint(trim(EYZ2.Text)));
   STYZ3.Caption :=formatfloat('0.00',409*strtoint(trim(EYZ3.Text)));
   STYZ4.Caption :=formatfloat('0.00',205*strtoint(trim(EYZ4.Text)));
   STYZ5.Caption :=formatfloat('0.00',strtofloat(STYZ1.Caption)+strtofloat(STYZ2.Caption)+strtofloat(STYZ3.Caption)+strtofloat(STYZ4.Caption));
   SetPYZData;
end;

procedure TReconYWCS02.SetYTYWData;
begin
   STYTYW1.Caption :=formatfloat('0.00',29250*strtoint(trim(EYTYW1.Text)));
   STYTYW2.Caption :=formatfloat('0.00',58500*strtoint(trim(EYTYW2.Text)));
   STYTYW3.Caption :=formatfloat('0.00',35100*strtoint(trim(EYTYW3.Text)));
   STYTYW4.Caption :=formatfloat('0.00',strtofloat(STYTYW1.Caption)+strtofloat(STYTYW2.Caption)+strtofloat(STYTYW3.Caption));
   SetBYData;
end;

procedure TReconYWCS02.SetPYZData;
begin
   SetReconMoney;
end;

procedure TReconYWCS02.SetBYData;
begin
   SetReconMoney;
end;

procedure TReconYWCS02.SetBQData;
begin
   STYT1.Caption :=formatfloat('0.00',strtofloat(STYTBX3.Caption)+strtofloat(STYTQD3.Caption));
   SetReconMoney;
end;

procedure TReconYWCS02.SetZTMoney;
begin
   STZT1.Caption :=formatfloat('0.00',strtofloat(STZ3.Caption)+strtofloat(STT3.Caption));
   SetReconMoney;
end;

procedure TReconYWCS02.SetDBCData;
begin
   STBGCB1.Caption :=formatfloat('0.00',strtofloat(STBG1.Caption)+strtofloat(STCB1.Caption));
   SetReconMoney;
end;

procedure TReconYWCS02.SetReconMoney;
var
   aSum:double;
begin
   aSum:=(strtofloat(STBGCB1.caption)+strtofloat(STCT1.caption)+strtofloat(STBC3.Caption)+strtofloat(STP3.Caption))*strtofloat(STYWCS1.Caption)+strtofloat(STZT1.caption)+strtofloat(STYZ5.caption)+strtofloat(STYT1.caption)+strtofloat(STYTYW4.caption);
   STYWCS2.Caption :=formatfloat('0.00',aSum);
end;


//事件
procedure TReconYWCS02.EYTBX1Exit(Sender: TObject);
begin
   if trim(EYTBX1.Text)='' then EYTBX1.Text :='0';
   EditFormat(EYTBX1);
   STYTBX2.Caption :=formatfloat('0.00',strtofloat(STYTBX1.Caption)*strtofloat(trim(EYTBX1.Text)))
end;

procedure TReconYWCS02.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   aList:tstrings;
begin
   try
      begin
      //原位测试总调整系数
      aList:=tstringlist.create;;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,mod1025,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0103'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='0103';
         end;
      ADOQuery1.fieldbyname('adjustitems').AsString:=m_AdMod.Text;
      ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STYWCS1.Caption);
      ADOQuery1.fieldbyname('mod1025').AsFloat:=m_mod1030;
      ADOQuery1.Post ;
      //*************03-08-10**********
      //保存静力触探调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010303'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010303';
         end;
      if ChBJT1.Checked then aList.add('29');
      if ChBJT2.Checked then aList.add('30');
      if aList.count>0 then
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
   //保存压水、注水、孔隙压力试验
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,category,actualvalue,unitprice,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010308'+'''') then
      begin
      if (ADOQuery1.RecordCount>0) and (ADOQuery1.RecordCount<4) then
         while not ADOQuery1.Eof do
            ADOQuery1.Delete;
      if ADOQuery1.RecordCount=0 then
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030801';
         ADOQuery1.FieldByName('category').AsString :='试验深度D(m)<=20';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030802';
         ADOQuery1.FieldByName('category').AsString :='试验深度D(m)>20';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030803';
         ADOQuery1.FieldByName('category').AsString :='钻孔注水';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030804';
         ADOQuery1.FieldByName('category').AsString :='探井注水';
         ADOQuery1.Post;
         ADOQuery1.Close;
         ADOQuery1.Open;

         end;
      ADOQuery1.First ;
      ADOQuery1.edit;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ1.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=1753 ;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ1.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ2.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=2104 ;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ2.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ3.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=409 ;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ3.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ4.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=205 ;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ4.Caption);
      ADOQuery1.Post ;
      end;
   //保存岩体原位应力测试
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,category,actualvalue,unitprice,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010312'+'''') then
      begin
      if (ADOQuery1.RecordCount>0) and (ADOQuery1.RecordCount<3) then
         while not ADOQuery1.Eof do
            ADOQuery1.Delete;
      if ADOQuery1.RecordCount=0 then
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01031201';
         ADOQuery1.FieldByName('category').AsString :='原位应力测试';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01031202';
         ADOQuery1.FieldByName('category').AsString :='三轴交汇测应力';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01031203';
         ADOQuery1.FieldByName('category').AsString :='孔壁应变法';
         ADOQuery1.Post;
         ADOQuery1.Close;
         ADOQuery1.Open;

         end;
      ADOQuery1.First ;
      ADOQuery1.edit;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYTYW1.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=29250;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYTYW1.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYTYW2.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=58500 ;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYTYW2.Caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYTYW3.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=35100;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYTYW3.Caption);
      ADOQuery1.Post ;
      end;
      //保存岩体变形试验
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010309'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010309';
         end;
      ADOQuery1.fieldbyname('mod1025').AsFloat:=strtofloat(trim(EYTBX2.Text)) ;

      ADOQuery1.Post ;
      
      //保存原位测试总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0103'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='0103';
         end;
      ADOQuery1.FieldByName('money').AsFloat :=strtofloat(STYWCS2.caption);
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

procedure TReconYWCS02.EYTBX1Enter(Sender: TObject);
begin
m_EtText:=trim(EYTBX1.Text);
EditEnter(EYTBX1);
end;

procedure TReconYWCS02.FormCreate(Sender: TObject);
var
   aSList:tstrings;
   aValue,aOffset,aBase,tmpBase,aDepth,aTmpDepth,aTmpStart,aUPrice,aBott:double;
   DrlItemName:tstrings;
   DrlU100Price:array of array[0..7] of double;
   RangeValue,RangeValue1,RangeValue2:array of double;
   ItemStart,ItemEnd,tmpStr:string;
   i,j,k,iValue,tmp_cid:integer;
   DType:SmallInt;
   aFlag:boolean;
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  adMoney:=0;
  isFirst:=true;
  isSelAll:=false;
  STRecon1.Caption := g_ProjectInfo.prj_no ;
  STRecon2.Caption := g_ProjectInfo.prj_name ;
  try
   mNo:=1;
   //取调整系数
   aSList:=tstringlist.Create ;
   m_AdMod:=tstringlist.Create ;
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0103'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      m_AdMod.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      STYWCS1.Caption :=formatfloat('0.00',ADOQuery1.fieldbyname('adjustmodulus').AsFloat);
      m_mod1030:=ADOQuery1.fieldbyname('mod1025').AsFloat;
      end;
   //压水、注水、孔隙水压力试验
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010308'+''' order by itemid') then
      if ADOQuery1.RecordCount>0 then
         begin
         EYZ1.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
         EditFormat(EYZ1);
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EYZ2.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EYZ2);
            end;
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EYZ3.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EYZ3);
            end;
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EYZ4.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EYZ4);
            end;
         ADOQuery1.Next ;
         end;
   SetYZData;
   //岩体原位应力测试
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010312'+''' order by itemid') then
      if ADOQuery1.RecordCount>0 then
         begin
         EYTYW1.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
         EditFormat(EYTYW1);
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EYTYW2.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EYTYW2);
            end;
         ADOQuery1.Next ;
         if not ADOQuery1.Eof then
            begin
            EYTYW3.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
            EditFormat(EYTYW3);
            end;
         end;
   SetYTYWData;
   //地质勘察项目及单价
   if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice,c4uprice,c5uprice,c6uprice from unitprice02 where substring(itemid,1,6)='''+'010304'+''' or substring(itemid,1,6)='''+'010306'+''' or substring(itemid,1,6)='''+'010307'+'''or substring(itemid,1,6)='''+'010309'+''' or substring(itemid,1,6)='''+'010310'+''' or substring(itemid,1,6)='''+'010311'+''' order by itemid') then
      begin
      ItemStart:='';
      i:=-1;
      while not ADOQuery1.Eof do
         begin
         ItemEnd:=copy(ADOQuery1.fieldbyname('itemid').AsString,1,6);
         if ItemStart<>ItemEnd then
            begin
            inc(i);
            ItemStart:=ItemEnd;
            m_ItemID[i]:=tstringlist.Create ;
            end;
         m_ItemID[i].Add(ADOQuery1.fieldbyname('itemid').AsString);
         j:=length(m_UnitPrice[i]);
         setlength(m_UnitPrice[i],j+1);
         m_UnitPrice[i,j]:=tstringlist.Create;
         if i=3 then     
            begin
            CBT1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c4uprice').AsString);
            end
         else
            begin
            if i=0 then CBBC1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
            else if i=1 then CBP1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
            else if i=2 then CBZ1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
            else if i=4 then CBYTBX1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
            else CBYTQD1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
            m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
            end;
         ADOQuery1.Next ;
         end;
      end;
   CBZ1.Hint :=CBZ1.Items[CBZ1.Items.count-1];
   CBYTBX1.Hint :=CBYTBX1.Items[CBYTBX1.Items.count-1];
   SetCBWidth(CBT1);
   SetCBWidth(CBBC1);
   SetCBWidth(CBP1);
   SetCBWidth(CBZ1);
   SetCBWidth(CBYTBX1);
   SetCBWidth(CBYTQD1);
   //取扁侧胀数据
   if ReopenQryFAcount(AQBC,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010304'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGBC1.Columns[0].Field :=AQBC.Fields[0];
      DGBC1.Columns[1].Field :=AQBC.Fields[1];
      DGBC1.Columns[2].Field :=AQBC.Fields[2];
      DGBC1.Columns[3].Field :=AQBC.Fields[3];
      DGBC1.Columns[4].Field :=AQBC.Fields[4];
      if AQBC.RecordCount>0 then
         begin
         BBBC2.Enabled :=true;
         SetSPData(0,true);
         end;
      end;

   //取旁压试验数据
   if ReopenQryFAcount(AQP,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010306'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGP1.Columns[0].Field :=AQP.Fields[0];
      DGP1.Columns[1].Field :=AQP.Fields[1];
      DGP1.Columns[2].Field :=AQP.Fields[2];
      DGP1.Columns[3].Field :=AQP.Fields[3];
      DGP1.Columns[4].Field :=AQP.Fields[4];
      if AQP.RecordCount>0 then
         begin
         BBP2.Enabled :=true;
         SetSPData(1,true);
         end;
      end;
   //取载荷试验数据
   if ReopenQryFAcount(AQZ,'select itemname,category,unitprice,actualvalue,money,prj_no,subno,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010307'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGZ1.Columns[0].Field :=AQZ.Fields[0];
      DGZ1.Columns[1].Field :=AQZ.Fields[1];
      DGZ1.Columns[2].Field :=AQZ.Fields[2];
      DGZ1.Columns[3].Field :=AQZ.Fields[3];
      DGZ1.Columns[4].Field :=AQZ.Fields[4];
      if AQZ.RecordCount>0 then
         begin
         BBZ2.Enabled :=true;
         SetSPData(2,true);
         end;
      end;
   //-----载荷其它费用----
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,othercharge,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010307'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      iValue:=ADOQuery1.fieldbyname('mod1025').AsInteger;
      if iValue>0 then
         begin
         i:=CBZ1.Items.Count-1;
         ItemStart:=m_ItemID[2][i];
         j:=iValue DIV 500;
         if j>=1 then
            while m_ItemID[2].Count>i do
               m_ItemID[2].Delete(i);
         while j>=1 do
            begin
            setlength(m_UnitPrice[2],i+1);
            if m_UnitPrice[2][i]<>nil then m_UnitPrice[2][i].Free;
            m_UnitPrice[2][i]:=tstringlist.Create ;
            m_ItemID[2].Add(ItemStart);
            for k:=0 to m_UnitPrice[2][i-1].Count-1 do
               m_UnitPrice[2][i].Add(floattostr(strtofloat(m_UnitPrice[2][i-1][k])*1.25));
            dec(j);
            end;
         end;
      EZ2.Text:=formatfloat('0',iValue) ;
      EditFormat(EZ2);
      end;
   //取土体现场直剪试验数据
   if ReopenQryFAcount(AQT,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010309'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGT1.Columns[0].Field :=AQT.Fields[0];
      DGT1.Columns[1].Field :=AQT.Fields[1];
      DGT1.Columns[2].Field :=AQT.Fields[2];
      DGT1.Columns[3].Field :=AQT.Fields[3];
      DGT1.Columns[4].Field :=AQT.Fields[4];
      if AQT.RecordCount>0 then
         begin
         BBT2.Enabled :=true;
         SetSPData(3,true);
         end;
      end;
   //取岩体变形试验数据
   if ReopenQryFAcount(AQB,'select itemname,category,unitprice,actualvalue,money,prj_no,subno,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010310'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGYTBX1.Columns[0].Field :=AQB.Fields[0];
      DGYTBX1.Columns[1].Field :=AQB.Fields[1];
      DGYTBX1.Columns[2].Field :=AQB.Fields[2];
      DGYTBX1.Columns[3].Field :=AQB.Fields[3];
      DGYTBX1.Columns[4].Field :=AQB.Fields[4];
      if AQB.RecordCount>0 then
         begin
         BBYTBX2.Enabled :=true;
         SetSPData(4,true);
         end;
      end;
   //-----岩体变形>1000的值----
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,mod1025 from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010309'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      iValue:=ADOQuery1.fieldbyname('mod1025').AsInteger;
      if iValue>0 then
         begin
         i:=CBYTBX1.Items.Count-1;
         ItemStart:=m_ItemID[4][i];
         j:=iValue DIV 500;
         if j>=1 then
            while m_ItemID[4].Count>i do
               m_ItemID[4].Delete(i);
         while j>=1 do
            begin
            setlength(m_UnitPrice[4],i+1);
            if m_UnitPrice[4][i]<>nil then m_UnitPrice[4][i].Free;
            m_UnitPrice[4][i]:=tstringlist.Create ;
            m_ItemID[4].Add(ItemStart);
            for k:=0 to m_UnitPrice[4][i-1].Count-1 do
               m_UnitPrice[4][i].Add(floattostr(strtofloat(m_UnitPrice[4][i-1][k])*1.1));
            dec(j);
            end;
         end;      
      EYTBX2.Text:=formatfloat('0',ADOQuery1.fieldbyname('mod1025').Asfloat) ;
      EditFormat(EYTBX2);
      end;
   //取岩体强度试验数据
   if ReopenQryFAcount(AQQ,'select itemname,category,unitprice,actualvalue,money,prj_no,charge02.itemid from charge02,unitprice02 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge02.itemid,1,6)='''+'010311'+''') and (charge02.itemid=unitprice02.itemid)') then
      begin
      DGYTQD1.Columns[0].Field :=AQQ.Fields[0];
      DGYTQD1.Columns[1].Field :=AQQ.Fields[1];
      DGYTQD1.Columns[2].Field :=AQQ.Fields[2];
      DGYTQD1.Columns[3].Field :=AQQ.Fields[3];
      DGYTQD1.Columns[4].Field :=AQQ.Fields[4];
      if AQQ.RecordCount>0 then
         begin
         BBYTQD2.Enabled :=true;
         SetSPData(5,true);
         end;
      end;
   AQJT3.Close ;
   AQJT3.SQL.text:='delete from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(Rec_No,1,4)='''+'0103'+'''';
   AQJT3.ExecSQL ;

   //动力触探
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010302'+''' order by ItemID';
   ADOQuery1.Open ;
   DrlItemName:=tstringlist.Create ;
   setlength(DrlU100Price,0);
   setlength(RangeValue,0);
   i:=0;
   while not ADOQuery1.Eof do
      begin
      setlength(DrlU100Price,i+1);
      DrlItemName.Add(ADOQuery1.fieldbyname('itemname').AsString);
      if i=0 then
         begin
         setlength(RangeValue,1);
         RangeValue[0]:=10;
         end
      else if (i>0) and (i<=5) then
         begin
         setlength(RangeValue1,i);
         RangeValue1[i-1]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])));
         end
      else
         begin
         setlength(RangeValue2,i-5);
         RangeValue2[i-6]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])));
         end;
      for j:=0 to 5 do
         DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   AQDT1.Close ;
   AQDT1.SQL.Text :='select prj_no,drl_no,begin_depth,end_depth,pt_type,pt_type_name from dpt,dpt_type where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and dpt.pt_type=dpt_type.pt_type_no';
   AQDT1.Open ;
   //Drill_Type=3 表示动力触探

   while not AQDT1.Eof do
      begin
      aDepth:=AQDT1.fieldbyname('end_depth').AsFloat ;

      AQDT2.Close ;
      AQDT2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category'
        +' from stratum,stratumcategory02'
        +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
        +''' and stra_category=id and drl_no='''+stringReplace(AQDT1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
      AQDT2.Open ;
      aBase:=0;
      i:=0;
      while not AQDT2.Eof do
         begin
         aBott:=AQDT2.fieldbyname('stra_depth').AsFloat ;
         if (aDepth>=aBase) and (aDepth<=aBott) then
            begin
            if AQDT1.fieldbyname('pt_type').AsString='1' then
               begin
                 i:=GetIndexOfRange(RangeValue,aDepth,true);
                 if i=-2 then break;
               end
            else if AQDT1.fieldbyname('pt_type').AsString='2' then
               begin
                 i:=GetIndexOfRange(RangeValue1,aDepth,true);
                 if i=-2 then break;
                 i:=i+1;
               end
            else if AQDT1.fieldbyname('pt_type').AsString='3' then
               begin
               i:=GetIndexOfRange(RangeValue2,aDepth,true);
               if i=-2 then break;
               i:=i+6;
               end;
            ItemStart:=formatfloat('0',AQDT1.fieldbyname('begin_depth').AsFloat);
            ItemEnd:=formatfloat('0',aDepth);
            j:=AQDT2.fieldbyname('stra_category').AsInteger;
            if i<1 then
               if (j<3) and (j>-1) then
                  aUPrice:=DrlU100Price[i,j]
               else
                  aUPrice:=0
            else if i<6 then
               if (j<6) and (j>-1) then
                  aUPrice:=DrlU100Price[i,j]
               else
                  aUPrice:=0
            else
               if (j>1) and (j<6) then
                  aUPrice:=DrlU100Price[i,j]
               else
                  aUPrice:=0;
            tmpStr:=AQDT1.fieldbyname('pt_type').AsString+copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=tmpStr+AQDT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQDT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQDT2.fieldbyname('stra_no').AsString+'-'+AQDT2.fieldbyname('sub_no').AsString,AQDT2.fieldbyname('category').AsString,aUPrice,1,aUPrice,3,AQDT1.fieldbyname('pt_type_name').AsString,tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end;
         aBase := aBott;
         AQDT2.Next ;
         end;
      if i<0 then break;
      AQDT1.Next ;
      end;
   AQDT1.Close ;
   AQDT1.SQL.Text :='select drl_no,item,DRange,Stra_sub_no,category,pt_type,unitprice,depth,money,prj_no from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=3 order by rec_no';
   AQDT1.Open ;
   for i:=0 to DGDT1.Columns.Count-1 do
      DGDT1.Columns[i].Field :=AQDT1.Fields[i];
   DTMoney:=SumMoney(AQDT1,'money');
   STDT1.Caption :=formatfloat('0.00',DTMoney);
   setCTMoney;
   //标准贯入
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010301'+''' order by ItemID';
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
      if pos('=',DrlItemName[i])>0 then
         RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])))
      else
         //RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('>',DrlItemName[i])+1,length(DrlItemName[i])-pos('>',DrlItemName[i])));
         RangeValue[i]:=200;
      for j:=0 to 2 do
         DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   AQBG1.Close ;
   AQBG1.SQL.Text :='select prj_no,drl_no,begin_depth,end_depth from spt where prj_no='''+g_ProjectInfo.prj_no_ForSQL+'''';
   AQBG1.Open ;
   //Drill_Type=5 表示标准贯入

   while not AQBG1.Eof do
      begin
      aDepth:=AQBG1.fieldbyname('end_depth').AsFloat ;

      AQBG2.Close ;
      AQBG2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category'
        +' from stratum,stratumcategory02 '
        +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
        +''' and stra_category=id and drl_no='''+stringReplace(AQBG1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
      AQBG2.Open ;
      aBase:=0;
      i:=0;
      while not AQBG2.Eof do
         begin
         aBott:=AQBG2.fieldbyname('stra_depth').AsFloat ;
         if (aDepth>=aBase) and (aDepth<=aBott) then
            begin
            i:=GetIndexOfRange(RangeValue,aDepth,true);
            if i=-2 then break;
            ItemStart:=formatfloat('0.00',AQBG1.fieldbyname('begin_depth').AsFloat);
            ItemEnd:=formatfloat('0.00',aDepth);
            j:=AQBG2.fieldbyname('stra_category').AsInteger;
            if (j<4) and (j>-1) then
               aUPrice:=DrlU100Price[i,j]
            else
               aUPrice:=0;
            tmpStr:=copy(DrlItemName[i],pos('D',DrlItemName[i]),length(DrlItemName[i])-(pos('D',DrlItemName[i])-1));
            tmpStr:=tmpStr+AQBG2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQBG2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQBG2.fieldbyname('stra_no').AsString+'-'+AQBG2.fieldbyname('sub_no').AsString,AQBG2.fieldbyname('category').AsString,aUPrice,1,aUPrice,5,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end;
         aBase := aBott;
         AQBG2.Next ;
         end;
      if i<0 then break;
      AQBG1.Next ;
      end;
   AQBG1.Close ;
   AQBG1.SQL.Text :='select drl_no,item,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=5 order by rec_no';
   AQBG1.Open ;
   for i:=0 to DGBG1.Columns.Count-1 do
      DGBG1.Columns[i].Field :=AQBG1.Fields[i];
   STBG1.Caption :=formatfloat('0.00',SumMoney(AQBG1,'money'));
   SetDBCData;
   //十字板剪切
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010305'+''' order by ItemID';
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
      if pos('=',DrlItemName[i])>0 then
         RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('=',DrlItemName[i])+1,length(DrlItemName[i])-pos('=',DrlItemName[i])))
      else
         //RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('>',DrlItemName[i])+1,length(DrlItemName[i])-pos('>',DrlItemName[i])));
         RangeValue[i]:=200;
      DrlU100Price[i,0]:=ADOQuery1.Fields[2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   AQCB1.Close ;
   AQCB1.SQL.Text :='select prj_no,drl_no,cb_depth from CrossBoard where prj_no='''+g_ProjectInfo.prj_no_ForSQL+'''';
   AQCB1.Open ;
   //Drill_Type=6 表示十字板剪切

   while not AQCB1.Eof do
      begin
      aDepth:=AQCB1.fieldbyname('cb_depth').AsFloat ;

      AQCB2.Close ;
      AQCB2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category'
        +' from stratum,stratumcategory02'
        +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
        +''' and stra_category=id and drl_no='''+stringReplace(AQCB1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
        +' ORDER BY stra_depth';
      AQCB2.Open ;
      aBase:=0;
      i:=0;
      while not AQCB2.Eof do
         begin
         aBott:=AQCB2.fieldbyname('stra_depth').AsFloat ;
         if (aDepth>=aBase) and (aDepth<=aBott) then
            begin
            i:=GetIndexOfRange(RangeValue,aDepth,true);
            if i=-2 then break;
            j:=AQCB2.fieldbyname('stra_category').AsInteger;
            if j<2 then
               aUPrice:=DrlU100Price[i,j]
            else
               aUPrice:=0;
            tmpStr:=copy(DrlItemName[i],pos('D',DrlItemName[i]),length(DrlItemName[i])-(pos('D',DrlItemName[i])-1));
            tmpStr:=tmpStr+AQCB2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQCB2.fieldbyname('drl_no').AsString,'0',DrlItemName[i],AQCB2.fieldbyname('stra_no').AsString+'-'+AQCB2.fieldbyname('sub_no').AsString,AQCB2.fieldbyname('category').AsString,aUPrice,1,aUPrice,6,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end;
         aBase := aBott;
         AQCB2.Next ;
         end;
      if i<0 then break;
      AQCB1.Next ;
      end;
   AQCB1.Close ;
   AQCB1.SQL.Text :='select drl_no,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=6 order by rec_no';
   AQCB1.Open ;
   for i:=0 to DGCB1.Columns.Count-1 do
      DGCB1.Columns[i].Field :=AQCB1.Fields[i];
   STCB1.Caption :=formatfloat('0.00',SumMoney(AQCB1,'money'));
   SetDBCData;
   //静力触探
   AQJT1.Close ;
   //AQJT1.SQL.Text :='select distinct cpt.drl_no,begin_depth,abs(end_depth-begin_depth) CDepth,cpt.prj_no from cpt,stratum where cpt.prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and stratum.prj_no=cpt.prj_no and stratum.drl_no=cpt.drl_no';
   AQJT1.SQL.Text :='select drl_no,begin_depth,abs(end_depth-begin_depth) CDepth,prj_no from cpt where prj_no='''+g_ProjectInfo.prj_no_ForSQL+'''';
   AQJT1.Open ;
   DGJT1.Columns[0].Field :=AQJT1.Fields[0];
   DGJT1.Columns[1].Field :=AQJT1.Fields[1];
   DGJT1.Columns[2].Field :=AQJT1.Fields[2];
   //Drill_Type=4 表示静力触探

   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select * from unitPrice02 where substring(itemid,1,6)='''+'010303'+''' order by ItemID';
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
      for j:=0 to 2 do
         DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
      ADOQuery1.Next ;
      inc(i);
      end;

   while not AQJT1.Eof do
      begin
      aDepth:=AQJT1.fieldbyname('CDepth').AsFloat ;
      aBase:=AQJT1.fieldbyname('begin_depth').AsFloat ;

      AQJT2.Close ;
      AQJT2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category'
      +' from stratum,stratumcategory02'
      +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
      +''' and stra_category=id and drl_no='''+stringReplace(AQJT1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
      +' ORDER BY stra_depth';
      AQJT2.Open ;
      while not AQJT2.Eof do
         begin
         if AQJT2.FieldByName('stra_depth').AsFloat>aBase then break;
         AQJT2.Next ;
         end;
      //aBott:=AQJT2.fieldbyname('top_elev').AsFloat - aBase;//换成起始深度的标高
      i:=0;
      aFlag:=true;
      tmpBase:=aBase;
      while (not AQJT2.Eof) and aFlag do
         begin
         i:=GetIndexOfRange(RangeValue,tmpBase,true);
         if i=-2 then break;
         aValue:=AQJT2.FieldByName('stra_depth').AsFloat;
         if aValue>aDepth then
            begin
            aValue:=aDepth+aBase;
            aFlag:=false;
            end
         else
            aValue:=aValue+aBase;
         if aValue>100 then aValue:=100;
         j:=GetIndexOfRange(RangeValue,aValue,false);
         if i>j then//仅一种情况
            begin
            ItemStart:=formatfloat('0',tmpBase);
            ItemEnd:=formatfloat('0',aValue);

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            aTmpDepth:=aValue-tmpBase;
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end
         else if i=j then//一分为二
            begin
            //---------第一段
            ItemStart:=formatfloat('0',tmpBase);
            ItemEnd:=formatfloat('0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-tmpBase;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            //---------第二段
            aTmpStart:=RangeValue[i];
            inc(i);
            ItemStart:=formatfloat('0',aTmpStart);//+0.1);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;//+0.1;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end
         else//一层分为多段
            begin
            //-------------第一部分
            ItemStart:=formatfloat('0',tmpBase);
            ItemEnd:=formatfloat('0',RangeValue[i]);
            aTmpDepth:=RangeValue[i]-tmpBase;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[i],pos('<=',DrlItemName[i])+2,length(DrlItemName[i])-(pos('<=',DrlItemName[i])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[i],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
               if k<5 then
                  aTmpDepth:=10
               else if (k=5) or (k=6) then
                  aTmpDepth:=25
               else
                  aTmpDepth:=20;
               tmpStr:=copy(DrlItemName[k],pos('<=',DrlItemName[k])+2,length(DrlItemName[k])-(pos('<=',DrlItemName[k])+1));
               tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
               if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,DrlItemName[k],DrlItemName[k],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
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
            ItemStart:=formatfloat('0',aTmpStart);//+0.1);
            ItemEnd:=formatfloat('0',aValue);
            aTmpDepth:=aValue-aTmpStart;//+0.1;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>2) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
            tmpStr:=copy(DrlItemName[j],pos('<=',DrlItemName[j])+2,length(DrlItemName[j])-(pos('<=',DrlItemName[j])+1));
            tmpStr:=stringofchar('0',3-length(tmpStr))+tmpStr+AQJT2.fieldbyname('category').AsString;
            if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString,ItemStart+'<D<='+ItemEnd,DrlItemName[j],AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
               begin
               application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
               i:=-1;
               break;
               end;
            end;
         aDepth:=aDepth-aTmpDepth;
         tmpBase:=aValue;
         AQJT2.Next ;
         end;
      if i<0 then break;
      AQJT1.Next ;
      end;
   AQJT2.Close ;
   AQJT2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category from stratum,stratumcategory02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and stra_category=id order by stra_no,sub_no';
   AQJT2.Open ;
   DGJT2.Columns[0].Field :=AQJT2.Fields[0];
   DGJT2.Columns[1].Field :=AQJT2.Fields[1];
   DGJT2.Columns[2].Field :=AQJT2.Fields[2];

   AQJT3.Close ;
   AQJT3.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no,drl_no from drillcharge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=4 order by rec_no';
   AQJT3.Open ;
   for i:=0 to DGJT3.Columns.Count-1 do
      DGJT3.Columns[i].Field :=AQJT3.Fields[i];
   JTMoney:=SumMoney(AQJT3,'money');
   //---------------取静力触探调整系数-----------------
   aSList.Clear ;
   ADOQuery1.Close ;
   ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus,othercharge from adjustment02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010303'+'''';
   ADOQuery1.Open;
   if ADOQuery1.RecordCount>0 then
      begin
      aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
      if PosStrInList(aSList,'29')>=0 then
         ChBJT1.Checked :=true;
      if PosStrInList(aSList,'30')>=0 then
         ChBJT2.Checked :=true;
      end;
   setJTMoney;
   //-------------------------------------------------------
   isFirst:=false;

   AQJT1.First ;
   AQZ.First ;
   AQB.First ;
   DrlItemName.free;

   aSList.Free ;
except
   application.MessageBox(DBERR_NOTREAD,HINT_TEXT);
   isFirst:=false;
end;
end;


procedure TReconYWCS02.EYZ1Enter(Sender: TObject);
begin
EditEnter(EYZ1);
end;

procedure TReconYWCS02.EYZ1Exit(Sender: TObject);
begin
   if trim(EYZ1.Text)='' then EYZ1.Text :='0';
   EditFormat(EYZ1);
   SetYZData;
end;

procedure TReconYWCS02.EYZ2Enter(Sender: TObject);
begin
EditEnter(EYZ2);
end;

procedure TReconYWCS02.EYZ3Enter(Sender: TObject);
begin
EditEnter(EYZ3);
end;

procedure TReconYWCS02.EYZ4Enter(Sender: TObject);
begin
EditEnter(EYZ4);
end;

procedure TReconYWCS02.EYZ2Exit(Sender: TObject);
begin
   if trim(EYZ2.Text)='' then EYZ2.Text :='0';
   EditFormat(EYZ2);
   SetYZData;
end;

procedure TReconYWCS02.EYZ3Exit(Sender: TObject);
begin
   if trim(EYZ3.Text)='' then EYZ3.Text :='0';
   EditFormat(EYZ3);
   SetYZData;
end;

procedure TReconYWCS02.EYZ4Exit(Sender: TObject);
begin
   if trim(EYZ4.Text)='' then EYZ4.Text :='0';
   EditFormat(EYZ4);
   SetYZData;
end;

procedure TReconYWCS02.EYTBX1Change(Sender: TObject);
begin
   if m_EtText<>trim(EYTBX1.Text) then BBYTBX1.Enabled:=true;
end;

procedure TReconYWCS02.CBYTBX1Select(Sender: TObject);
begin
if not AQB.Locate('itemid',m_ItemID[4][CBYTBX1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EYTBX1.Text))<>0 then
      begin
      EYTBX1.Text:='0';
      EditFormat(EYTBX1);
      end;
   if CBYTBX2.ItemIndex<0 then
      begin
      STYTBX1.Caption :='0.00';
      STYTBX2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(4);
      if not BBYTBX1.Enabled then BBYTBX1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.CBYTBX2Select(Sender: TObject);
begin
   if CBYTBX1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBYTBX1.Enabled then BBYTBX1.Enabled:=true;
   SetMoneySP(4);
end;

procedure TReconYWCS02.CBYTQD2Select(Sender: TObject);
begin
   if CBYTQD1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBYTQD1.Enabled then BBYTQD1.Enabled:=true;
   SetMoneySP(5);
end;

procedure TReconYWCS02.EYTQD1Change(Sender: TObject);
begin
   if m_EtText<>trim(EYTQD1.Text) then BBYTQD1.Enabled:=true;
end;

procedure TReconYWCS02.EYTQD1Enter(Sender: TObject);
begin
m_EtText:=trim(EYTQD1.Text);
EditEnter(EYTQD1);
end;

procedure TReconYWCS02.EYTQD1Exit(Sender: TObject);
begin
   if trim(EYTQD1.Text)='' then EYTQD1.Text :='0';
   EditFormat(EYTQD1);
   STYTQD2.Caption :=formatfloat('0.00',strtofloat(STYTQD1.Caption)*strtofloat(trim(EYTQD1.Text)))
end;

procedure TReconYWCS02.BBYTQD1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQQ.Locate('itemid;category',vararrayof([m_ItemID[5][CBYTQD1.ItemIndex],CBYTQD2.Text]), [loPartialKey]) then
         begin
         AQQ.Insert;
         AQQ.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQQ.FieldByName('itemid').AsString :=m_ItemID[5][CBYTQD1.ItemIndex];
         end
      else
         AQQ.Edit;
      AQQ.FieldByName('category').AsString :=CBYTQD2.Text;
      AQQ.FieldByName('unitprice').Asfloat :=strtofloat(STYTQD1.Caption);
      AQQ.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EYTQD1.Text));
      AQQ.FieldByName('money').Asfloat :=strtofloat(STYTQD2.Caption);
      AQQ.Post ;
      aBM:=AQQ.GetBookmark ;
      AQQ.Close ;
      AQQ.Open ;
      if AQQ.RecordCount>1 then
         AQQ.GotoBookmark(aBM);
      SetSPData(5,true);
      isFirst:=false;
      BBYTQD1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.EBC1Change(Sender: TObject);
begin
   if m_EtText<>trim(EBC1.Text) then BBBC1.Enabled:=true;
end;

procedure TReconYWCS02.EBC1Enter(Sender: TObject);
begin
m_EtText:=trim(EBC1.Text);
EditEnter(EBC1);
end;

procedure TReconYWCS02.EBC1Exit(Sender: TObject);
begin
   if trim(EBC1.Text)='' then EBC1.Text :='0';
   EditFormat(EBC1);
   STBC2.Caption :=formatfloat('0.00',strtofloat(STBC1.Caption)*strtofloat(trim(EP1.Text)))
end;

procedure TReconYWCS02.BBBC1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQBC.Locate('itemid;category',vararrayof([m_ItemID[0][CBBC1.ItemIndex],CBBC2.Text]), [loPartialKey]) then
         begin
         AQBC.Insert;
         AQBC.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQBC.FieldByName('itemid').AsString :=m_ItemID[0][CBBC1.ItemIndex];
         end
      else
         AQBC.Edit;
      AQBC.FieldByName('category').AsString :=CBBC2.Text;
      AQBC.FieldByName('unitprice').Asfloat :=strtofloat(STBC1.Caption);
      AQBC.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EBC1.Text));
      AQBC.FieldByName('money').Asfloat :=strtofloat(STBC2.Caption);
      AQBC.Post ;
      aBM:=AQP.GetBookmark ;
      AQBC.Close ;
      AQBC.Open ;
      if AQBC.RecordCount>1 then
         AQBC.GotoBookmark(aBM);
      SetSPData(0,true);
      isFirst:=false;
      BBBC1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.BBBC2Click(Sender: TObject);
begin
DeleteRecord(AQBC,0);
end;

procedure TReconYWCS02.CBYTQD1Select(Sender: TObject);
begin
if not AQQ.Locate('itemid',m_ItemID[5][CBYTQD1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EYTQD1.Text))<>0 then
      begin
      EYTQD1.Text:='0';
      EditFormat(EYTQD1);
      end;
   if CBYTQD2.ItemIndex<0 then
      begin
      STYTQD1.Caption :='0.00';
      STYTQD2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(5);
      if not BBYTQD1.Enabled then BBYTQD1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.CBBC2Select(Sender: TObject);
begin
   if CBBC1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBBC1.Enabled then BBBC1.Enabled:=true;
   SetMoneySP(0);
end;


procedure TReconYWCS02.CBP1Select(Sender: TObject);
begin
if not AQP.Locate('itemid',m_ItemID[1][CBP1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EP1.Text))<>0 then
      begin
      EP1.Text:='0';
      EditFormat(EP1);
      end;
   if CBP2.ItemIndex<0 then
      begin
      STP1.Caption :='0.00';
      STP2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(1);
      if not BBP1.Enabled then BBP1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.CBP2Select(Sender: TObject);
begin
   if CBP1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBP1.Enabled then BBP1.Enabled:=true;
   SetMoneySP(1);
end;

procedure TReconYWCS02.EP1Change(Sender: TObject);
begin
   if m_EtText<>trim(EP1.Text) then BBP1.Enabled:=true;
end;

procedure TReconYWCS02.EP1Enter(Sender: TObject);
begin
m_EtText:=trim(EP1.Text);
EditEnter(EP1);
end;

procedure TReconYWCS02.EP1Exit(Sender: TObject);
begin
   if trim(EP1.Text)='' then EP1.Text :='0';
   EditFormat(EP1);
   STP2.Caption :=formatfloat('0.00',strtofloat(STP1.Caption)*strtofloat(trim(EP1.Text)))
end;

procedure TReconYWCS02.BBP1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQP.Locate('itemid;category',vararrayof([m_ItemID[1][CBP1.ItemIndex],CBP2.Text]), [loPartialKey]) then
         begin
         AQP.Insert;
         AQP.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQP.FieldByName('itemid').AsString :=m_ItemID[1][CBP1.ItemIndex];
         end
      else
         AQP.Edit;
      AQP.FieldByName('category').AsString :=CBP2.Text;
      AQP.FieldByName('unitprice').Asfloat :=strtofloat(STP1.Caption);
      AQP.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EP1.Text));
      AQP.FieldByName('money').Asfloat :=strtofloat(STP2.Caption);
      AQP.Post ;
      aBM:=AQP.GetBookmark ;
      AQP.Close ;
      AQP.Open ;
      if AQP.RecordCount>1 then
         AQP.GotoBookmark(aBM);
      SetSPData(1,true);
      isFirst:=false;
      BBP1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.BBP2Click(Sender: TObject);
begin
DeleteRecord(AQP,1);
end;

procedure TReconYWCS02.AQPAfterInsert(DataSet: TDataSet);
begin
   if not BBYTQD2.Enabled then BBYTQD2.Enabled:=true;
end;

procedure TReconYWCS02.AQPAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(3);
   BBP1.Enabled :=false;
end;

procedure TReconYWCS02.AQJT1AfterScroll(DataSet: TDataSet);
begin
if not isFirst then
   begin
   AQJT3.Filtered:=false;
   AQJT2.Filtered:=false;
   AQJT2.Filter :=' drl_no='''+AQJT1.fieldbyname('drl_no').AsString+'''';
   AQJT2.Filtered :=true ;
   //
   AQJT3.Filter :=' drl_no='''+AQJT1.fieldbyname('drl_no').AsString+'''';
   AQJT3.Filtered :=true ;
   STJT1.Caption :=formatfloat('0.00',SumMoney(AQJT3,'money'));
   end;
end;

procedure TReconYWCS02.AQJT2AfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQJT3.Locate('Stra_sub_no',AQJT2.fieldbyname('stra_no').AsString
      +'-'+stringReplace(AQJT2.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconYWCS02.EYWCS1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconYWCS02.BBYWCS1Click(Sender: TObject);
begin
   application.CreateForm(TFAdjustment,FAdjustment);
   FAdjustment.m_ADMod:=m_AdMod;
   FAdjustment.m_mod1030:=m_mod1030;
   FAdjustment.ShowModal ;
   m_AdMod :=FAdjustment.m_ADMod ;
   m_mod1030:= FAdjustment.m_mod1030 ;
   STYWCS1.Caption :=FAdjustment.STA1.Caption;
   SetReconMoney;
end;

procedure TReconYWCS02.ChBJT1Click(Sender: TObject);
begin
   SetJTMoney;
end;

procedure TReconYWCS02.ChBJT2Click(Sender: TObject);
begin
   SetJTMoney;
end;

procedure TReconYWCS02.CBZ1Select(Sender: TObject);
begin
if not AQZ.Locate('itemid',m_ItemID[2][CBZ1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EZ1.Text))<>0 then
      begin
      EZ1.Text:='0';
      EditFormat(EZ1);
      end;
   if CBZ2.ItemIndex<0 then
      begin
      STZ1.Caption :='0.00';
      STZ2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(2);
      if not BBZ1.Enabled then BBZ1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.CBZ2Select(Sender: TObject);
begin
   if CBZ1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBZ1.Enabled then BBZ1.Enabled:=true;
   SetMoneySP(2);
end;

procedure TReconYWCS02.EZ1Change(Sender: TObject);
begin
   if m_EtText<>trim(EZ1.Text) then BBZ1.Enabled:=true;
end;

procedure TReconYWCS02.EZ1Enter(Sender: TObject);
begin
m_EtText:=trim(EZ1.Text);
EditEnter(EZ1);
end;

procedure TReconYWCS02.EZ1Exit(Sender: TObject);
begin
   if trim(EZ1.Text)='' then EZ1.Text :='0';
   EditFormat(EZ1);
   STZ2.Caption :=formatfloat('0.00',strtofloat(STZ1.Caption)*strtofloat(trim(EZ1.Text)))
end;

procedure TReconYWCS02.EZ2Enter(Sender: TObject);
begin
EditEnter(EZ2);
end;

procedure TReconYWCS02.EZ2Exit(Sender: TObject);
var
   i,j,j1,k,aValue:integer;
   aItem:string;
   aBM:tbookmark;
   aFlag:boolean;
begin
   if trim(EZ2.Text)='' then EZ2.Text :='0';
   EditFormat(EZ2);
   
   isFirst:=true;
   if AQZ.RecordCount>0then
      begin
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='delete from charge02 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+copy(AQZ.fieldbyname('itemid').AsString,1,6)+''' and subno<>'''+'0'+'''';
      ADOQuery1.ExecSQL ;
      end;
   AQZ.Close;
   AQZ.Open ;
   aValue:=strtoint(trim(EZ2.Text));
   if aValue<=0 then
      begin
         isFirst:=false;
         if AQZ.RecordCount<=0 then
            ClearData(2);
         exit;
      end;
   AQZ.Last ;
   aBM:=AQZ.GetBookmark ;
   i:=CBZ1.Items.Count-1;
   aItem:=m_ItemID[2][i];
   j:=aValue DIV 5000;
   if j>=1 then
      while m_ItemID[2].Count>i do
         m_ItemID[2].Delete(i);
   aFlag:=false;
   for j1:=1 to j do
      begin
      setlength(m_UnitPrice[2],i+1);
      if m_UnitPrice[2][i]<>nil then m_UnitPrice[2][i].Free;
      m_UnitPrice[2][i]:=tstringlist.Create ;
      m_ItemID[2].Add(aItem);
      for k:=0 to m_UnitPrice[2][i-1].Count-1 do
         begin
         m_UnitPrice[2][i].Add(floattostr(strtofloat(m_UnitPrice[2][i-1][k])*1.25));
         AQZ.Insert ;
         if not aFlag then aFlag:=true;
         AQZ.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQZ.FieldByName('itemid').AsString :=aItem ;
         AQZ.FieldByName('category').AsString :=CBZ2.Items[k];
         AQZ.FieldByName('unitprice').AsFloat :=strtofloat(m_UnitPrice[2][i][k]) ;
         AQZ.FieldByName('subno').AsString :=inttostr(j1);
         AQZ.FieldByName('actualvalue').AsFloat :=0 ;
         end;
      inc(i);
      end;
   if aFlag then
      begin
      AQZ.Post ;
      AQZ.Close;
      AQZ.Open ;
      if aBM<>nil then
         begin
         AQZ.GotoBookmark(aBM);
         isFirst:=false;
         AQZ.Next ;
         end;
      end
   else
      isFirst:=false;
end;

procedure TReconYWCS02.AQZAfterScroll(DataSet: TDataSet);
begin
   if isFirst then exit;
   SetSPData(2);
   BBZ1.Enabled :=false;
   if AQZ.FieldByName('subno').AsString>'0' then
      BBZ2.Enabled :=false
   else if AQZ.FieldByName('subno').AsString='0' then
      BBZ2.Enabled :=true;
end;

procedure TReconYWCS02.AQZAfterInsert(DataSet: TDataSet);
begin
if not BBZ2.Enabled then BBZ2.Enabled:=true;
end;

procedure TReconYWCS02.BBZ2Click(Sender: TObject);
begin
DeleteRecord(AQZ,2);
end;

procedure TReconYWCS02.CBZ1DropDown(Sender: TObject);
begin
   CBZ1.Items.Delete(CBZ1.Items.Count-1); 
end;

procedure TReconYWCS02.CBZ1CloseUp(Sender: TObject);
begin
CBZ1.Items.Add(CBZ1.Hint);
if CBZ1.ItemIndex=-1 then CBZ1.ItemIndex :=CBZ1.Items.Count-1; 
end;

procedure TReconYWCS02.CBT1Select(Sender: TObject);
begin
if not AQT.Locate('itemid',m_ItemID[3][CBT1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(ET1.Text))<>0 then
      begin
      ET1.Text:='0';
      EditFormat(ET1);
      end;
   if CBT2.ItemIndex<0 then
      begin
      STT1.Caption :='0.00';
      STT2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(3);
      if not BBT1.Enabled then BBT1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.CBT2Select(Sender: TObject);
begin
   if CBT1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBT1.Enabled then BBT1.Enabled:=true;
   SetMoneySP(3);
end;

procedure TReconYWCS02.ET1Change(Sender: TObject);
begin
   if m_EtText<>trim(ET1.Text) then BBT1.Enabled:=true;
end;

procedure TReconYWCS02.ET1Enter(Sender: TObject);
begin
m_EtText:=trim(ET1.Text);
EditEnter(ET1);
end;

procedure TReconYWCS02.ET1Exit(Sender: TObject);
begin
   if trim(ET1.Text)='' then ET1.Text :='0';
   EditFormat(ET1);
   STT2.Caption :=formatfloat('0.00',strtofloat(STT1.Caption)*strtofloat(trim(ET1.Text)))
end;

procedure TReconYWCS02.AQTAfterInsert(DataSet: TDataSet);
begin
   if not BBT2.Enabled then BBT2.Enabled:=true;
end;

procedure TReconYWCS02.AQTAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(3);
   BBT1.Enabled :=false;
end;

procedure TReconYWCS02.BBT1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQT.Locate('itemid;category',vararrayof([m_ItemID[3][CBT1.ItemIndex],CBT2.Text]), [loPartialKey]) then
         begin
         AQT.Insert;
         AQT.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQT.FieldByName('itemid').AsString :=m_ItemID[3][CBT1.ItemIndex];
         end
      else
         AQT.Edit;
      AQT.FieldByName('category').AsString :=CBT2.Text;
      AQT.FieldByName('unitprice').Asfloat :=strtofloat(STT1.Caption);
      AQT.FieldByName('actualvalue').Asfloat :=strtofloat(trim(ET1.Text));
      AQT.FieldByName('money').Asfloat :=strtofloat(STT2.Caption);
      AQT.Post ;
      aBM:=AQT.GetBookmark ;
      AQT.Close ;
      AQT.Open ;
      if AQT.RecordCount>1 then
         AQT.GotoBookmark(aBM);
      SetSPData(3,true);
      isFirst:=false;
      BBT1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.BBZ1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if CBZ1.ItemIndex<CBZ1.Items.Count-1 then
         if not AQZ.Locate('itemid;category',vararrayof([m_ItemID[2][CBZ1.ItemIndex],CBZ2.Text]), [loPartialKey]) then
            begin
            AQZ.Insert;
            AQZ.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
            AQZ.FieldByName('itemid').AsString :=m_ItemID[2][CBZ1.ItemIndex];
            end
         else
            AQZ.Edit
      else
         AQZ.Edit;
      AQZ.FieldByName('category').AsString :=CBZ2.Text;
      AQZ.FieldByName('unitprice').Asfloat :=strtofloat(STZ1.Caption);
      AQZ.FieldByName('actualvalue').Asfloat :=strtofloat(trim(EZ1.Text));
      AQZ.FieldByName('money').Asfloat :=strtofloat(STZ2.Caption);
      AQZ.Post ;
      aBM:=AQZ.GetBookmark ;
      AQZ.Close ;
      AQZ.Open ;
      if AQZ.RecordCount>1 then
         AQZ.GotoBookmark(aBM);
      SetSPData(2,true);
      isFirst:=false;
      BBZ1.Enabled :=false;
      end;
   except
      begin
      application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
      isFirst:=false;
      end;
   end;
end;

procedure TReconYWCS02.BBT2Click(Sender: TObject);
begin
DeleteRecord(AQT,3);
end;

procedure TReconYWCS02.CBBC1Select(Sender: TObject);
begin
if not AQBC.Locate('itemid',m_ItemID[0][CBBC1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EBC1.Text))<>0 then
      begin
      EBC1.Text:='0';
      EditFormat(EBC1);
      end;
   if CBBC2.ItemIndex<0 then
      begin
      STBC1.Caption :='0.00';
      STBC2.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(0);
      if not BBBC1.Enabled then BBBC1.Enabled:=true;
      end;
   end;
end;

procedure TReconYWCS02.EP1KeyPress(Sender: TObject; var Key: Char);
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


procedure TReconYWCS02.EYTYW2Enter(Sender: TObject);
begin
EditEnter(EYTYW2);
end;

procedure TReconYWCS02.EYTYW3Enter(Sender: TObject);
begin
EditEnter(EYTYW3);
end;

procedure TReconYWCS02.EYTYW1Exit(Sender: TObject);
begin
   if trim(EYTYW1.Text)='' then EYTYW1.Text :='0';
   EditFormat(EYTYW1);
   SetYTYWData
end;

procedure TReconYWCS02.EYTYW1Enter(Sender: TObject);
begin
EditEnter(EYTYW1);
end;

procedure TReconYWCS02.EYTYW2Exit(Sender: TObject);
begin
   if trim(EYTYW2.Text)='' then EYTYW2.Text :='0';
   EditFormat(EYTYW2);
   SetYTYWData
end;

procedure TReconYWCS02.EYTYW3Exit(Sender: TObject);
begin
   if trim(EYTYW3.Text)='' then EYTYW3.Text :='0';
   EditFormat(EYTYW3);
   SetYTYWData
end;

procedure TReconYWCS02.BBRecon2Click(Sender: TObject);
begin
   close;
end;

procedure TReconYWCS02.BBYTQD2Click(Sender: TObject);
begin
DeleteRecord(AQQ,5);
end;

procedure TReconYWCS02.AQBCAfterInsert(DataSet: TDataSet);
begin
if not BBBC2.Enabled then BBBC2.Enabled:=true;
end;

procedure TReconYWCS02.AQBCAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(0);
   BBBC1.Enabled :=false;
end;

procedure TReconYWCS02.AQQAfterInsert(DataSet: TDataSet);
begin
   if not BBYTQD2.Enabled then BBYTQD2.Enabled:=true;
end;

procedure TReconYWCS02.AQQAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(5);
   BBYTQD1.Enabled :=false;
end;

procedure TReconYWCS02.AQBAfterInsert(DataSet: TDataSet);
begin
   if not BBYTBX2.Enabled then BBYTBX2.Enabled:=true;
end;

procedure TReconYWCS02.AQBAfterScroll(DataSet: TDataSet);
begin
   if isFirst then exit;
      SetSPData(4);
   BBYTBX1.Enabled :=false;
   if AQB.FieldByName('subno').AsString>'0' then
      BBYTBX2.Enabled :=false
   else if AQB.FieldByName('subno').AsString='0' then
      BBYTBX2.Enabled :=true;
end;

procedure TReconYWCS02.BBRecon1Click(Sender: TObject);
begin
   application.CreateForm(TFrmCategory02,FrmCategory02);
   FrmCategory02.ShowModal ;
end;

end.
