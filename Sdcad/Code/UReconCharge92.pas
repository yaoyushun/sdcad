unit UReconCharge92;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls;

type
  TReconCharge92 = class(TForm)
    AQMap: TADOQuery;
    DSMap: TDataSource;
    ADOQuery1: TADOQuery;
    DSDill: TDataSource;
    DSStratum: TDataSource;
    DSMoney: TDataSource;
    AQDrill: TADOQuery;
    AQStratum: TADOQuery;
    AQMoney: TADOQuery;
    AQTC: TADOQuery;
    AQE: TADOQuery;
    DSTC: TDataSource;
    DSE: TDataSource;
    DSP: TDataSource;
    AQP: TADOQuery;
    AQTJ: TADOQuery;
    DSTJ: TDataSource;
    AQTJS: TADOQuery;
    DSTJS: TDataSource;
    AQTJM: TADOQuery;
    DSTJM: TDataSource;
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
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Shape12: TShape;
    CBDrill1: TCheckBox;
    CBDrill2: TCheckBox;
    CBDrill3: TCheckBox;
    CBDrill4: TCheckBox;
    CBDrill5: TCheckBox;
    CBDrill6: TCheckBox;
    CBDrill7: TCheckBox;
    RBDrill1: TRadioButton;
    RBDrill2: TRadioButton;
    RBDrill3: TRadioButton;
    RBDrill4: TRadioButton;
    STDrill1: TStaticText;
    STDrill2: TStaticText;
    TabSheet3: TTabSheet;
    Label48: TLabel;
    Label49: TLabel;
    STJCMoney: TStaticText;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    Label67: TLabel;
    Shape8: TShape;
    Label8: TLabel;
    Label9: TLabel;
    STJ2: TStaticText;
    Panel2: TPanel;
    DGJ1: TDBGrid;
    DGJ2: TDBGrid;
    DGJ3: TDBGrid;
    STJ1: TStaticText;
    GroupBox4: TGroupBox;
    Label22: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Label32: TLabel;
    Label34: TLabel;
    Shape11: TShape;
    CBC1: TComboBox;
    CBC2: TComboBox;
    EC1: TEdit;
    STC1: TStaticText;
    STC2: TStaticText;
    BBC1: TBitBtn;
    BBC2: TBitBtn;
    STC3: TStaticText;
    DGC1: TDBGrid;
    TabSheet4: TTabSheet;
    Label84: TLabel;
    Label85: TLabel;
    GroupBox9: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
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
    Label81: TLabel;
    Label90: TLabel;
    Shape7: TShape;
    Shape9: TShape;
    Shape10: TShape;
    EWS1: TEdit;
    STWS1: TStaticText;
    STWS4: TStaticText;
    EWS2: TEdit;
    EWS3: TEdit;
    STWS2: TStaticText;
    STWS3: TStaticText;
    STEWS1: TStaticText;
    GroupBox13: TGroupBox;
    Label102: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label121: TLabel;
    Label132: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    Shape13: TShape;
    DGE1: TDBGrid;
    CBE1: TComboBox;
    EE1: TEdit;
    STE1: TStaticText;
    STE2: TStaticText;
    STE3: TStaticText;
    BBE1: TBitBtn;
    BBE2: TBitBtn;
    CBE2: TComboBox;
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
    Panel6: TPanel;
    DGBG1: TDBGrid;
    STBGCB1: TStaticText;
    GroupBox17: TGroupBox;
    Shape17: TShape;
    Label149: TLabel;
    Label152: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Shape18: TShape;
    Label170: TLabel;
    Label171: TLabel;
    Panel5: TPanel;
    Label172: TLabel;
    Label173: TLabel;
    DGDT1: TDBGrid;
    STDT1: TStaticText;
    ChBDT1: TCheckBox;
    ChBDT4: TCheckBox;
    RBDT1: TRadioButton;
    RBDT2: TRadioButton;
    RBDT3: TRadioButton;
    RBDT4: TRadioButton;
    STDT2: TStaticText;
    STDT3: TStaticText;
    TabSheet6: TTabSheet;
    Label68: TLabel;
    Label35: TLabel;
    GroupBox14: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Shape6: TShape;
    Label41: TLabel;
    Label42: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label66: TLabel;
    Label156: TLabel;
    Label157: TLabel;
    Shape16: TShape;
    Label44: TLabel;
    Panel4: TPanel;
    DGJT1: TDBGrid;
    DGJT2: TDBGrid;
    DGJT3: TDBGrid;
    STJT1: TStaticText;
    ChBJT2: TCheckBox;
    ChBJT1: TCheckBox;
    RBJT1: TRadioButton;
    ChBJT4: TCheckBox;
    RBJT2: TRadioButton;
    RBJT3: TRadioButton;
    RBJT4: TRadioButton;
    STJT2: TStaticText;
    ChBJT3: TCheckBox;
    STJT3: TStaticText;
    TabSheet7: TTabSheet;
    Label124: TLabel;
    Label125: TLabel;
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
    GroupBox12: TGroupBox;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Shape4: TShape;
    STK1: TStaticText;
    EK1: TEdit;
    STPYZK1: TStaticText;
    GroupBox6: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    ChBRecon1: TCheckBox;
    STRecon1: TStaticText;
    STRecon2: TStaticText;
    STRecon3: TStaticText;
    EdtRecon1: TEdit;
    UpDown1: TUpDown;
    BBRecon1: TBitBtn;
    procedure BBRecon2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBRecon1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AQDrillAfterScroll(DataSet: TDataSet);
    procedure AQStratumAfterScroll(DataSet: TDataSet);
    procedure ChBRecon1Click(Sender: TObject);
    procedure EdtRecon1Enter(Sender: TObject);
    procedure EdtRecon1Exit(Sender: TObject);
    procedure EdtRecon1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtRecon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure CBDrill1Click(Sender: TObject);
    procedure CBDrill2Click(Sender: TObject);
    procedure CBDrill4Click(Sender: TObject);
    procedure CBDrill5Click(Sender: TObject);
    procedure CBDrill6Click(Sender: TObject);
    procedure CBDrill7Click(Sender: TObject);
    procedure CBDrill3Click(Sender: TObject);
    procedure RBDrill1Click(Sender: TObject);
    procedure RBDrill2Click(Sender: TObject);
    procedure RBDrill3Click(Sender: TObject);
    procedure RBDrill4Click(Sender: TObject);
    procedure EDrill1KeyPress(Sender: TObject; var Key: Char);
    procedure EDrill1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EWS1Enter(Sender: TObject);
    procedure EWS2Enter(Sender: TObject);
    procedure EWS3Enter(Sender: TObject);
    procedure EWS1Exit(Sender: TObject);
    procedure EWS2Exit(Sender: TObject);
    procedure EWS3Exit(Sender: TObject);
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
    procedure AQTCAfterInsert(DataSet: TDataSet);
    procedure AQEAfterInsert(DataSet: TDataSet);
    procedure AQTCAfterScroll(DataSet: TDataSet);
    procedure AQEAfterScroll(DataSet: TDataSet);
    procedure CBC1Select(Sender: TObject);
    procedure CBC2Select(Sender: TObject);
    procedure EC1Change(Sender: TObject);
    procedure EC1Enter(Sender: TObject);
    procedure EC1Exit(Sender: TObject);
    procedure BBC1Click(Sender: TObject);
    procedure BBC2Click(Sender: TObject);
    procedure CBE1Select(Sender: TObject);
    procedure CBE2Select(Sender: TObject);
    procedure EE1Change(Sender: TObject);
    procedure EE1Enter(Sender: TObject);
    procedure EE1Exit(Sender: TObject);
    procedure BBE1Click(Sender: TObject);
    procedure BBE2Click(Sender: TObject);
    procedure EYZ1Enter(Sender: TObject);
    procedure EYZ1Exit(Sender: TObject);
    procedure EYZ2Enter(Sender: TObject);
    procedure EYZ3Enter(Sender: TObject);
    procedure EYZ4Enter(Sender: TObject);
    procedure EYZ2Exit(Sender: TObject);
    procedure EYZ3Exit(Sender: TObject);
    procedure EYZ4Exit(Sender: TObject);
    procedure EK1Exit(Sender: TObject);
    procedure EK1Enter(Sender: TObject);
    procedure CBP1Select(Sender: TObject);
    procedure CBP2Select(Sender: TObject);
    procedure EP1Change(Sender: TObject);
    procedure EP1Enter(Sender: TObject);
    procedure EP1Exit(Sender: TObject);
    procedure BBP1Click(Sender: TObject);
    procedure BBP2Click(Sender: TObject);
    procedure AQPAfterInsert(DataSet: TDataSet);
    procedure AQPAfterScroll(DataSet: TDataSet);
    procedure AQTJSAfterScroll(DataSet: TDataSet);
    procedure AQJT1AfterScroll(DataSet: TDataSet);
    procedure AQTJAfterScroll(DataSet: TDataSet);
    procedure AQJT2AfterScroll(DataSet: TDataSet);
    procedure ChBDT1Click(Sender: TObject);
    procedure RBDT1Click(Sender: TObject);
    procedure RBDT2Click(Sender: TObject);
    procedure RBDT3Click(Sender: TObject);
    procedure RBDT4Click(Sender: TObject);
    procedure ChBDT4Click(Sender: TObject);
    procedure ChBJT1Click(Sender: TObject);
    procedure RBJT1Click(Sender: TObject);
    procedure RBJT2Click(Sender: TObject);
    procedure RBJT3Click(Sender: TObject);
    procedure RBJT4Click(Sender: TObject);
    procedure ChBJT2Click(Sender: TObject);
    procedure ChBJT3Click(Sender: TObject);
    procedure ChBJT4Click(Sender: TObject);
  private
    isFirst:boolean;
    DrillsMoney,MapMoney,TJMoney,TCMoney,EMoney,DTMoney,JTMoney,PMoney:double;
    m_EtText:string;
    m_ItemID:array[0..3] of tstrings;
    m_UnitPrice:array[0..3] of array of tstrings;

    procedure SetMapMoney;
    procedure SetTJMoney;
    procedure SetTCMoney;
    procedure SetEMoney;
    procedure SetPMoney;
    procedure SetDrillMoney;
    procedure SetDTMoney;
    procedure SetJTMoney;
    procedure SetReconMoney;
    procedure SetTJCMoney;
    procedure SetWSData;
    procedure SetYZData;
    procedure SetKData ;
    procedure SetPYZKData;    
    procedure SetEWSData;
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
  ReconCharge92: TReconCharge92;

implementation
uses public_unit,MainDM,UCategory92;
{$R *.dfm}
var
   isSelAll:boolean;
   m_RBVal,m_RBDVal,m_RBJVal:double;
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
            if offValue<minValue then
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
            if offValue<minValue then
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
   SQLStr:string;
begin
   try
      aquery.Close ;
      SQLStr:='insert into drillcharge92 values('+inttostr(mNo)+','''
            +stringReplace(PrjNo ,'''','''''',[rfReplaceAll])+''','''
            +stringReplace(DrlNo ,'''','''''',[rfReplaceAll])+''','''+ItemName+''','''+DRange+''','''
            +stringReplace(SSNo,'''','''''',[rfReplaceAll])+''','''
            +stringReplace(CName,'''','''''',[rfReplaceAll])+''','
            +floattostr(UPrice)+','+floattostr(DValue)+','
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

procedure TReconCharge92.ClearData(aIndex:integer);
begin
   if aIndex=0 then
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
      end
   else if aIndex=1 then
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
      end
   else if aIndex=2 then
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
      SetEMoney;;
      end
   else if aIndex=3 then
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
      SetPMoney;;
      end;

end;

procedure TReconCharge92.SetSPData(aIndex:integer;isSum:boolean=false);
var
   i,j:integer;
//   aSum:double;
//   aValue:string;
begin
   if aIndex=0 then
      begin
      i:=PosStrInList(m_ItemID[0],AQMap.fieldbyname('itemid').AsString);
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
      end
   else if aIndex=1 then
      begin
      i:=PosStrInList(m_ItemID[1],AQTC.fieldbyname('itemid').AsString);
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
      end
   else if aIndex=2 then
      begin
      i:=PosStrInList(m_ItemID[2],AQE.fieldbyname('itemid').AsString);
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
      end
   else if aIndex=3 then
      begin
      i:=PosStrInList(m_ItemID[3],AQP.fieldbyname('itemid').AsString);
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
      end;
end;

procedure TReconCharge92.SetMoneySP(aIndex:integer);
begin
   if aIndex=0 then
      begin
      STMap1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[0,CBMap1.itemindex][CBMap2.ItemIndex]));
      STMap2.Caption :=formatfloat('0.00',strtofloat(trim(EdtMap1.Text))*strtofloat(STMap1.Caption));
      end
   else if aIndex=1 then
      begin
      STC1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[1,CBC1.itemindex][CBC2.ItemIndex]));
      STC2.Caption :=formatfloat('0.00',strtofloat(trim(EC1.Text))*strtofloat(STC1.Caption));
      end
   else if aIndex=2 then
      begin
      STE1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[2,CBE1.itemindex][CBE2.ItemIndex]));
      STE2.Caption :=formatfloat('0.00',strtofloat(trim(EE1.Text))*strtofloat(STE1.Caption));
      end
   else if aIndex=3 then
      begin
      STP1.Caption :=formatfloat('0.00',strtofloat(m_UnitPrice[3,CBP1.itemindex][CBP2.ItemIndex]));
      STP2.Caption :=formatfloat('0.00',strtofloat(trim(EP1.Text))*strtofloat(STP1.Caption));
      end;
end;

procedure TReconCharge92.DeleteRecord(aQuery:tadoquery;aIndex:integer);
var
   aBM:tbookmark;
begin
   try
      begin
      if application.MessageBox(DEL_CONFIRM,HINT_TEXT,MB_YESNO+MB_ICONQUESTION)=IDNO then exit;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+aQuery.fieldbyname('itemid').AsString+'''';
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
procedure TReconCharge92.SetMapMoney;
begin
   STMap4.Caption :=formatfloat('0.00',MapMoney*strtofloat(STMap3.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetTJMoney;
begin
   STJ2.Caption :=formatfloat('0.00',TJMoney);
   SetTJCMoney;
end;

procedure TReconCharge92.SetTCMoney;
begin
   STC3.Caption :=formatfloat('0.00',TCMoney);
   SetTJCMoney;
end;

procedure TReconCharge92.SetEMoney;
begin
   STE3.Caption :=formatfloat('0.00',EMoney);
   SetEWSData;
end;

procedure TReconCharge92.SetPMoney;
begin
   STP3.Caption :=formatfloat('0.00',PMoney);
   SetPYZKData;
end;

procedure TReconCharge92.SetDrillMoney;
begin
   STDrill2.Caption :=formatfloat('0.00',DrillsMoney*strtofloat(STDrill1.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetDTMoney;
begin
   STDT3.Caption :=formatfloat('0.00',strtofloat(STDT1.Caption)*strtofloat(STDT2.Caption));
   SetDBCData;
end;

procedure TReconCharge92.SetJTMoney;
begin
   STJT3.Caption :=formatfloat('0.00',JTMoney*strtofloat(STJT2.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetWSData;
begin
   STWS1.Caption :=formatfloat('0.00',17*strtoint(trim(EWS1.Text)));
   STWS2.Caption :=formatfloat('0.00',17*strtoint(trim(EWS2.Text)));
   STWS3.Caption :=formatfloat('0.00',136*strtoint(trim(EWS3.Text)));
   STWS4.Caption :=formatfloat('0.00',strtofloat(STWS1.Caption)+strtofloat(STWS2.Caption)+strtofloat(STWS3.Caption));
   SetEWSData;
end;

procedure TReconCharge92.SetEWSData;
begin
   STEWS1.Caption :=formatfloat('0.00',strtofloat(STE3.Caption)+strtofloat(STWS4.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetYZData;
begin
   STYZ1.Caption :=formatfloat('0.00',1020*strtoint(trim(EYZ1.Text)));
   STYZ2.Caption :=formatfloat('0.00',1224*strtoint(trim(EYZ2.Text)));
   STYZ3.Caption :=formatfloat('0.00',238*strtoint(trim(EYZ3.Text)));
   STYZ4.Caption :=formatfloat('0.00',119*strtoint(trim(EYZ4.Text)));
   STYZ5.Caption :=formatfloat('0.00',strtofloat(STYZ1.Caption)+strtofloat(STYZ2.Caption)+strtofloat(STYZ3.Caption)+strtofloat(STYZ4.Caption));
   SetPYZKData;
end;

procedure TReconCharge92.SetKData;
begin
   STK1.Caption :=formatfloat('0.00',8415*strtofloat(trim(EK1.Text)));
   SetPYZKData;
end;


procedure TReconCharge92.SetPYZKData;
begin
   STPYZK1.Caption :=formatfloat('0.00',strtofloat(STP3.Caption)+strtofloat(STYZ5.Caption)+strtofloat(STK1.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetTJCMoney;
begin
   STJCMoney.Caption :=formatfloat('0.00',strtofloat(STJ2.Caption)+strtofloat(STC3.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetDBCData;
begin
   STBGCB1.Caption :=formatfloat('0.00',strtofloat(STDT3.Caption)+strtofloat(STBG1.Caption)+strtofloat(STCB1.Caption));
   SetReconMoney;
end;

procedure TReconCharge92.SetReconMoney;
var
   aSum:double;
begin
   aSum:=strtofloat(STMap4.caption)+strtofloat(STDrill2.caption)+strtofloat(STJCMoney.caption)+strtofloat(STBGCB1.caption)+strtofloat(STJT3.caption)+strtofloat(STEWS1.caption)+strtofloat(STPYZK1.caption);
   if ChBRecon1.Checked then
      STRecon3.Caption :=formatfloat('0.00',aSum*(1+strtofloat(trim(EdtRecon1.Text))/100))
   else
      STRecon3.Caption :=formatfloat('0.00',aSum);
end;


//事件
procedure TReconCharge92.BBRecon2Click(Sender: TObject);
begin
   close;
end;

procedure TReconCharge92.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   aList:tstrings;
begin
   try
      begin
      //保存勘察总调整系数
      aList:=tstringlist.create;;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'01'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='01';
         end;
      if ChBRecon1.Checked then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:='34';
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtoint(trim(EdtRecon1.Text));
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //地质测绘调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
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
      //保存钻孔调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010201'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010201';
         end;
      if CBDrill1.Checked then aList.add('07');
      if CBDrill2.Checked then aList.add('08');
      if CBDrill3.Checked then
         if RBDrill1.Checked then aList.add('09')
         else if RBDrill2.Checked then aList.add('10')
         else if RBDrill3.Checked then aList.add('11')
         else if RBDrill4.Checked then aList.add('12');
      if CBDrill4.Checked then aList.add('13');
      if CBDrill5.Checked then aList.add('14');
      if CBDrill6.Checked then aList.add('15');
      if CBDrill7.Checked then aList.add('16');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STDrill1.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存动力触探调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010302'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010302';
         end;
      if ChBDT1.Checked then
         if RBDT1.Checked then aList.add('09')
         else if RBDT2.Checked then aList.add('10')
         else if RBDT3.Checked then aList.add('11')
         else if RBDT4.Checked then aList.add('12');
      if ChBDT4.Checked then aList.add('16');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STDT2.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
      //保存静力触探调整系数
      aList.clear;
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010303'+'''';
      ADOQuery1.Open;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.fieldbyname('prj_no').AsString:=g_ProjectInfo.prj_no;
         ADOQuery1.fieldbyname('itemid').AsString:='010303';
         end;
      if ChBJT1.Checked then
         if RBJT1.Checked then aList.add('24')
         else if RBJT2.Checked then aList.add('25')
         else if RBJT3.Checked then aList.add('26')
         else if RBJT4.Checked then aList.add('27');
      if ChBJT2.Checked then aList.add('20');
      if ChBJT3.Checked then aList.add('21');
      if ChBJT4.Checked then aList.add('22');
      if aList.count>0 then
         begin
         ADOQuery1.fieldbyname('adjustitems').AsString:=aList.text;
         ADOQuery1.fieldbyname('adjustmodulus').AsFloat:=strtofloat(STJT2.Caption) ;
         end
      else
         ADOQuery1.fieldbyname('adjustitems').AsString:='';
      ADOQuery1.Post ;
   //保存取水、石试料
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,category,unitprice,actualvalue,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010206'+'''') then
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
      ADOQuery1.fieldbyname('unitprice').AsFloat:=17;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS1.caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EWS2.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=17;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS2.caption);
      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EWS3.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=136;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STWS3.caption);
      ADOQuery1.Post ;
      end;
   //保存压水、注水、孔隙压力试验
   if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,category,unitprice,actualvalue,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010308'+''' or itemid='''+'01030901'+'''') then
      begin
      if (ADOQuery1.RecordCount>0) and (ADOQuery1.RecordCount<5) then
         while not ADOQuery1.Eof do
            ADOQuery1.Delete;
      if ADOQuery1.RecordCount=0 then
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030801';
         ADOQuery1.FieldByName('category').AsString :='试验深度<=20m';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030801';
         ADOQuery1.FieldByName('category').AsString :='试验深度>20m';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030802';
         ADOQuery1.FieldByName('category').AsString :='钻孔注水';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030802';
         ADOQuery1.FieldByName('category').AsString :='探井注水';

         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01030901';
         ADOQuery1.FieldByName('category').AsString :='一个月';

         ADOQuery1.Post ;
         ADOQuery1.Close;
         ADOQuery1.Open;
         end;
         
      ADOQuery1.First;
      ADOQuery1.edit;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ1.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=1020;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ1.caption);

      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ2.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=1224;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ2.caption);

      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ3.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=238;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ3.caption);

      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EYZ4.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=119;
      ADOQuery1.fieldbyname('money').AsFloat:=strtofloat(STYZ4.caption);

      ADOQuery1.Next ;
      ADOQuery1.Edit ;
      ADOQuery1.fieldbyname('actualvalue').AsFloat:=strtofloat(trim(EK1.Text));
      ADOQuery1.fieldbyname('unitprice').AsFloat:=8415;
      ADOQuery1.fieldbyname('money').AsFloat:=8415*strtofloat(trim(EK1.Text));

      ADOQuery1.Post ;
      end;
      //保存地质勘察总费用
      ADOQuery1.Close ;
      ADOQuery1.SQL.Text :='select prj_no,itemid,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'01'+'''';
      ADOQuery1.Open ;
      if ADOQuery1.RecordCount>0 then
         ADOQuery1.Edit
      else
         begin
         ADOQuery1.Insert ;
         ADOQuery1.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         ADOQuery1.FieldByName('itemid').AsString :='01';
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

procedure TReconCharge92.BBRecon1Click(Sender: TObject);
begin
application.CreateForm(TFrmCategory92,FrmCategory92);
FrmCategory92.ShowModal ;
end;

procedure TReconCharge92.FormCreate(Sender: TObject);
var
   aSList:tstrings;
   aValue,aOffset,aBase,tmpBase,aDepth,aTmpDepth,aTmpStart,aUPrice,aTop:double;
   DrlItemName:tstrings;
   DrlU100Price:array of array[0..7] of double;
   RangeValue:array of double;
   ItemStart,ItemEnd,tmpStr:string;
   i,j,k,tmp_cid:integer;
   DType:SmallInt;
   aFlag:boolean;
   
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

  isFirst:=true;
  isSelAll:=false;
  STRecon1.Caption := g_ProjectInfo.prj_no ;
  STRecon2.Caption := g_ProjectInfo.prj_name ;
  try
     mNo:=1;
     //取调整系数
     aSList:=tstringlist.Create ;
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'01'+'''';
     ADOQuery1.Open;
     if ADOQuery1.RecordCount>0 then
        begin
        aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
        if aSList.Count>0 then
           begin
           ChBRecon1.Checked :=true;
           EdtRecon1.Enabled :=true;
           aValue:=ADOQuery1.fieldbyname('adjustmodulus').AsFloat;
           if aValue<10 then aValue:=10
           else if aValue>30 then aValue:=30;
           EdtRecon1.Text :=formatfloat('00',aValue);
           end;
        end;
     //取水、石试料
     if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010206'+'''') then
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
        //压水、注水、孔隙水压力试验
     if ReopenQryFAcount(ADOQuery1,'select prj_no,itemid,unitprice,actualvalue,money from charge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and substring(itemid,1,6)='''+'010308'+''' or itemid='''+'01030901'+''' order by itemid') then
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
           if not ADOQuery1.Eof then
              begin
              EK1.Text:=inttostr(ADOQuery1.fieldbyname('actualvalue').AsInteger);
              EditFormat(EK1);
              end;
           end;
     SetYZData;
     SetKData;
     //地质勘察项目及单价
     if ReopenQryFAcount(ADOQuery1,'select itemid,itemname,c1uprice,c2uprice,c3uprice,c4uprice,c5uprice,c6uprice,c7uprice,c8uprice from unitprice92 where substring(itemid,1,6)='''+'010101'+''' or substring(itemid,1,6)='''+'010203'+''' or substring(itemid,1,6)='''+'010205'+''' or substring(itemid,1,6)='''+'010305'+''' order by itemid') then
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
           if i=0 then
              begin
              CBMap1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
              m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
              m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
              m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
              end
           else
              begin
              if i=1 then
                 begin
                 CBC1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c3uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c4uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c5uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c6uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c7uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c8uprice').AsString);
                 end
              else if (i=2) or (i=3) then
                 begin
                 if i=2 then CBE1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString)
                 else CBP1.Items.Add(ADOQuery1.fieldbyname('itemname').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c1uprice').AsString);
                 m_UnitPrice[i,j].Add(ADOQuery1.fieldbyname('c2uprice').AsString);
                 end
              end;
           ADOQuery1.Next ;
           end;
        end;
     SetCBWidth(CBE1);

     //取工程地质测绘数据
     if ReopenQryFAcount(AQMap,'select itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010101'+''') and (charge92.itemid=unitprice92.itemid)') then
        begin
        DBGMap1.Columns[0].Field :=AQMap.Fields[0];
        DBGMap1.Columns[1].Field :=AQMap.Fields[1];
        DBGMap1.Columns[2].Field :=AQMap.Fields[2];
        DBGMap1.Columns[3].Field :=AQMap.Fields[3];
        DBGMap1.Columns[4].Field :=AQMap.Fields[4];
        if AQMap.RecordCount>0 then
           begin
           BBMap2.Enabled :=true;
           SetSPData(0,true);
           end;
        end;
        //-----地质测绘调整系数----
     aSList.Clear ;
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'0101'+'''';
     ADOQuery1.Open;
     if ADOQuery1.RecordCount>0 then
        begin
        aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
        if PosStrInList(aSList,'05')>=0 then ChBMap1.Checked :=true;
        if PosStrInList(aSList,'06')>=0 then ChBMap2.Checked :=true;
        end;
     //取探槽数据
     if ReopenQryFAcount(AQTC,'select itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010203'+''') and (charge92.itemid=unitprice92.itemid)') then
        begin
        DGC1.Columns[0].Field :=AQTC.Fields[0];
        DGC1.Columns[1].Field :=AQTC.Fields[1];
        DGC1.Columns[2].Field :=AQTC.Fields[2];
        DGC1.Columns[3].Field :=AQTC.Fields[3];
        DGC1.Columns[4].Field :=AQTC.Fields[4];
        if AQTC.RecordCount>0 then
           begin
           BBC2.Enabled :=true;
           SetSPData(1,true);
           end;
        end;
     setTCMoney;
     //取土试料数据
     if ReopenQryFAcount(AQE,'select itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010205'+''') and (charge92.itemid=unitprice92.itemid)') then
        begin
        DGE1.Columns[0].Field :=AQE.Fields[0];
        DGE1.Columns[1].Field :=AQE.Fields[1];
        DGE1.Columns[2].Field :=AQE.Fields[2];
        DGE1.Columns[3].Field :=AQE.Fields[3];
        DGE1.Columns[4].Field :=AQE.Fields[4];
        if AQE.RecordCount>0 then
           begin
           BBE2.Enabled :=true;
           SetSPData(2,true);
           end;
        end;
     //取旁压试验数据
     if ReopenQryFAcount(AQP,'select itemname,category,unitprice,actualvalue,money,prj_no,charge92.itemid from charge92,unitprice92 where (prj_no='''+g_ProjectInfo.prj_no_ForSQL+''') and (substring(charge92.itemid,1,6)='''+'010305'+''') and (charge92.itemid=unitprice92.itemid)') then
        begin
        DGP1.Columns[0].Field :=AQP.Fields[0];
        DGP1.Columns[1].Field :=AQP.Fields[1];
        DGP1.Columns[2].Field :=AQP.Fields[2];
        DGP1.Columns[3].Field :=AQP.Fields[3];
        DGP1.Columns[4].Field :=AQP.Fields[4];
        if AQP.RecordCount>0 then
           begin
           BBP2.Enabled :=true;
           SetSPData(3,true);
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
     AQMoney.SQL.Add('delete from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+'''');
     AQMoney.ExecSQL ;
     //Drill_Type=1 表示钻孔

     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010201'+''' order by ItemID';
     ADOQuery1.Open ;
     DrlItemName:=tstringlist.Create ;
     i:=0;
     while not ADOQuery1.Eof do
        begin
        setlength(DrlU100Price,i+1);
        DrlItemName.Add(ADOQuery1.fieldbyname('itemname').AsString);
        setlength(RangeValue,i+1);
        RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('～',DrlItemName[i])+2,length(DrlItemName[i])-pos('～',DrlItemName[i])-1));
        for j:=0 to 7 do
           DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
        ADOQuery1.Next ;
        inc(i);
        end;

     while not AQDrill.Eof do
        begin
        aValue:=AQDrill.fieldbyname('comp_depth').AsFloat;
        //钻探深度超过100时构造各档次的收费标准
        aOffset:=aValue-100;
        ItemStart:='100.1';
        ItemEnd:='120.0';
        if length(DrlU100Price)>7 then
           begin
           setlength(DrlU100Price,7);
           setlength(RangeValue,7);
           end;
        while DrlItemName.Count>7 do
           DrlItemName.Delete(7);
        i:=7;
        while aOffset>0 do
           begin
           DrlItemName.Add(ItemStart+'～'+ItemEnd);
           setlength(RangeValue,i+1);
           RangeValue[i]:=strtofloat(ItemEnd);
           setlength(DrlU100Price,i+1);
           //每档按前一档的收费递增20%
           for j:=0 to 7 do
              DrlU100Price[i,j]:=DrlU100Price[i-1,j]*1.2;
           aOffset:=aOffset-20;
           ItemStart:=formatfloat('0.0',(strtofloat(ItemStart)+20));
           ItemEnd:=formatfloat('0.0',(strtofloat(ItemEnd)+20));
           inc(i);
           end;
        //-----------------------------------------------------------
        AQStratum.Close ;
        AQStratum.SQL.Text :='select stra_no,sub_no,stra_depth,'
          +'prj_no,drl_no,stra_category,category from stratum,'
          +'stratumcategory92 where prj_no='''
          +g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''
          +stringReplace(AQDrill.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
          +' ORDER BY stratum.stra_depth ';
        AQStratum.Open ;

        aBase:=0;
        i:=0;
        while not AQStratum.Eof do
           begin
           i:=GetIndexOfRange(RangeValue,aBase,true);
           if i=-2 then break;
           aValue:=AQStratum.fieldbyname('stra_depth').AsFloat;
           aDepth:=aValue-aBase;
           j:=GetIndexOfRange(RangeValue,aValue,false);
           if i>j then//仅一种情况
              begin
              ItemStart:=formatfloat('0.0',aBase);
              ItemEnd:=formatfloat('0.0',aValue);

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit              
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr
                +AQStratum.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,
                AQStratum.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,
                DrlItemName[i],AQStratum.fieldbyname('stra_no').AsString
                +'-'+AQStratum.fieldbyname('sub_no').AsString,
                AQStratum.fieldbyname('category').AsString,
                aUPrice,aDepth,aUPrice*aDepth,1,'',tmpStr) then
                begin
                  application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                  i:=-1; 
                  break;
                end;
              end
           else if i=j then//一分为二
              begin
              //---------第一段
              ItemStart:=formatfloat('0.0',aBase);
              ItemEnd:=formatfloat('0.0',RangeValue[i]);
              aTmpDepth:=RangeValue[i]-aBase;
              
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit                  
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))
                +tmpStr+AQStratum.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,
                AQStratum.fieldbyname('drl_no').AsString,
                ItemStart+'～'+ItemEnd,DrlItemName[i],
                AQStratum.fieldbyname('stra_no').AsString
                +'-'+AQStratum.fieldbyname('sub_no').AsString,
                AQStratum.fieldbyname('category').AsString,
                aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
                 begin
                   application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                   i:=-1;
                   break;
                 end;
              //---------第二段
              aTmpStart:=RangeValue[i];
              inc(i);
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit              
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQStratum.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQStratum.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i],AQStratum.fieldbyname('stra_no').AsString+'-'+AQStratum.fieldbyname('sub_no').AsString,AQStratum.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[i,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit             
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQStratum.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQStratum.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i],AQStratum.fieldbyname('stra_no').AsString+'-'+AQStratum.fieldbyname('sub_no').AsString,AQStratum.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[k,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[k,tmp_cid];
//20040826 yys edit

                 if k<5 then
                    aTmpDepth:=10
                 else if (k=5) or (k=6) then
                    aTmpDepth:=25
                 else
                    aTmpDepth:=20;
                 tmpStr:=copy(DrlItemName[k],1,pos('～',DrlItemName[k])-1);
                 tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQStratum.fieldbyname('category').AsString;
                 if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQStratum.fieldbyname('drl_no').AsString,DrlItemName[k],DrlItemName[k],AQStratum.fieldbyname('stra_no').AsString+'-'+AQStratum.fieldbyname('sub_no').AsString,AQStratum.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
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
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;

//20040826 yys edit
              //aUPrice:=DrlU100Price[j,AQStratum.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQStratum.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[j,tmp_cid];
//20040826 yys edit

              tmpStr:=copy(DrlItemName[j],1,pos('～',DrlItemName[j])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQStratum.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQStratum.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[j],AQStratum.fieldbyname('stra_no').AsString+'-'+AQStratum.fieldbyname('sub_no').AsString,AQStratum.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,1,'',tmpStr) then
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
       +'stra_category,category from stratum,stratumcategory92'
       +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
       +''' and stra_category=id'
       +' ORDER BY stra_depth';
     AQStratum.Open ;
     DGDrill2.Columns[0].Field :=AQStratum.Fields[0];
     DGDrill2.Columns[1].Field :=AQStratum.Fields[1];
     DGDrill2.Columns[2].Field :=AQStratum.Fields[2];

     AQMoney.Close ;
     AQMoney.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no,drl_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=1 order by rec_no';
     AQMoney.Open ;
     for i:=0 to DGDrill3.Columns.Count-1 do
        DGDrill3.Columns[i].Field :=AQMoney.Fields[i];
     DrillsMoney:=SumMoney(AQMoney,'money');
     //---------------取钻孔调整系数-----------------
     aSList.Clear ;
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010201'+'''';
     ADOQuery1.Open;
     if ADOQuery1.RecordCount>0 then
        begin
        aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
        if PosStrInList(aSList,'07')>=0 then CBDrill1.Checked :=true;
        if PosStrInList(aSList,'08')>=0 then CBDrill2.Checked :=true;
        if PosStrInList(aSList,'09')>=0 then
           begin
           RBDrill1.Checked :=true;
           CBDrill3.Checked :=true;
           end;
        if PosStrInList(aSList,'10')>=0 then
           begin
           RBDrill2.Checked :=true;
           CBDrill3.Checked :=true;
           end;
        if PosStrInList(aSList,'11')>=0 then
           begin
           RBDrill3.Checked :=true;
           CBDrill3.Checked :=true;
           end;
        if PosStrInList(aSList,'12')>=0 then
           begin
           RBDrill4.Checked :=true;
           CBDrill3.Checked :=true;
           end;
        if PosStrInList(aSList,'13')>=0 then CBDrill4.Checked :=true;
        if PosStrInList(aSList,'14')>=0 then CBDrill5.Checked :=true;
        if PosStrInList(aSList,'15')>=0 then CBDrill6.Checked :=true;
        if PosStrInList(aSList,'16')>=0 then CBDrill7.Checked :=true;
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
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010202'+''' order by ItemID';
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
        RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('～',DrlItemName[i])+2,length(DrlItemName[i])-pos('～',DrlItemName[i])-1));
        for j:=0 to 7 do
           DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
        ADOQuery1.Next ;
        inc(i);
        end;

     while not AQTJ.Eof do
        begin
        aValue:=AQTJ.fieldbyname('comp_depth').AsFloat;
        //掘进深度超过20时构造各档次的收费标准
        aOffset:=aValue-20;
        ItemStart:='20.1';
        ItemEnd:='30.0';
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
           DrlItemName.Add(ItemStart+'～'+ItemEnd);
           setlength(RangeValue,i+1);
           RangeValue[i]:=strtofloat(ItemEnd);
           setlength(DrlU100Price,i+1);
           //每档按前一档的收费递增30%
           for j:=0 to 7 do
              DrlU100Price[i,j]:=DrlU100Price[i-1,j]*1.3;
           aOffset:=aOffset-10;
           ItemStart:=formatfloat('0.0',(strtofloat(ItemStart)+10));
           ItemEnd:=formatfloat('0.0',(strtofloat(ItemEnd)+10));
           inc(i);
           end;
        //-----------------------------------------------------------
        AQTJS.Close ;
        AQTJS.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,'
          +'drl_no,stra_category,category from stratum,stratumcategory92'
          +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''+stringReplace(AQTJ.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])
          +''''+' ORDER BY stra_depth';
        AQTJS.Open ;

        aBase:=0;
        i:=0;
        while not  AQTJS.Eof do
           begin
           i:=GetIndexOfRange(RangeValue,aBase,true);
           if i=-2 then break;
           aValue:= AQTJS.fieldbyname('stra_depth').AsFloat;
           aDepth:=aValue-aBase;
           j:=GetIndexOfRange(RangeValue,aValue,false);
           if i>j then//仅一种情况
              begin
              ItemStart:=formatfloat('0.0',aBase);
              ItemEnd:=formatfloat('0.0',aValue);
 
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
             
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aDepth,aUPrice*aDepth,2,'',tmpStr) then
                 begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1; 
                 break;
                 end;
              end
           else if i=j then//一分为二
              begin
              //---------第一段
              ItemStart:=formatfloat('0.0',aBase);
              ItemEnd:=formatfloat('0.0',RangeValue[i]);
              aTmpDepth:=RangeValue[i]-aBase;


//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
                 begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
                 end;
              //---------第二段
              aTmpStart:=RangeValue[i];
              inc(i);
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit

              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
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
                 tmpStr:=copy(DrlItemName[k],1,pos('～',DrlItemName[k])-1);
                 tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
                 if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,DrlItemName[k],DrlItemName[k], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
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
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQTJS.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQTJS.fieldbyname('stra_category').AsInteger;
              if tmp_cid<0 then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[j,tmp_cid];
//20040826 yys edit  
            
              tmpStr:=copy(DrlItemName[j],1,pos('～',DrlItemName[j])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQTJS.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no, AQTJS.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[j], AQTJS.fieldbyname('stra_no').AsString+'-'+ AQTJS.fieldbyname('sub_no').AsString, AQTJS.fieldbyname('category').AsString,aUPrice,aTmpDepth,aUPrice*aTmpDepth,2,'',tmpStr) then
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
     AQTJS.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,stra_category,category from stratum,stratumcategory92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and stra_category=id';
     AQTJS.Open ;
     DGJ2.Columns[0].Field :=AQTJS.Fields[0];
     DGJ2.Columns[1].Field :=AQTJS.Fields[1];
     DGJ2.Columns[2].Field :=AQTJS.Fields[2];

     AQTJM.Close ;
     AQTJM.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no,drl_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=2 order by rec_no';
     AQTJM.Open ;
     for i:=0 to DGJ3.Columns.Count-1 do
        DGJ3.Columns[i].Field :=AQTJM.Fields[i];
     TJMoney:=SumMoney(AQTJM,'money');
     SetTJMoney;
     //动力触探

     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010302'+''' order by ItemID';
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
        RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('～',DrlItemName[i])+2,length(DrlItemName[i])-pos('～',DrlItemName[i])-1));
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
        AQDT2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
          +'stra_category,category from stratum,stratumcategory92'
          +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''
          +stringReplace(AQDT1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
          +' ORDER BY stratum.stra_depth';
        AQDT2.Open ;
        aBase:=0 ;
        i:=0;
        while not AQDT2.Eof do
           begin
           aValue:=AQDT2.fieldbyname('stra_depth').AsFloat;
           if (aDepth>=aBase) and (aDepth<=aValue) then
              begin
              
              i:=GetIndexOfRange(RangeValue,aDepth,true);
              if i=-2 then break;
              ItemStart:=formatfloat('0.0',AQDT1.fieldbyname('begin_depth').AsFloat);
              ItemEnd:=formatfloat('0.0',aDepth);
              j:=AQDT2.fieldbyname('stra_category').AsInteger;
//20040826 yys edit              
              //if j<6 then
              if (j<6) and (j>-1) then
//20040826 yys edit
                 aUPrice:=DrlU100Price[i,j]
              else
                 aUPrice:=0;
              if AQDT1.fieldbyname('pt_type').AsString='1' then
                 aUPrice:=aUPrice*0.5
              else if (AQDT1.fieldbyname('pt_type').AsString='2') or (AQDT1.fieldbyname('pt_type').AsString='3') then
                 aUPrice:=aUPrice*0.8;
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQDT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQDT2.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i],AQDT2.fieldbyname('stra_no').AsString+'-'+AQDT2.fieldbyname('sub_no').AsString,AQDT2.fieldbyname('category').AsString,aUPrice,1,aUPrice,3,AQDT1.fieldbyname('pt_type_name').AsString,tmpStr) then
                 begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
                 end;
              end;
           aBase := aValue;   
           AQDT2.Next ;
           end;
        if i<0 then break;
        AQDT1.Next ;
        end;
     AQDT1.Close ;
     AQDT1.SQL.Text :='select drl_no,DRange,category,pt_type,unitprice,depth,money,prj_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=3 order by rec_no';
     AQDT1.Open ;
     for i:=0 to DGDT1.Columns.Count-1 do
        DGDT1.Columns[i].Field :=AQDT1.Fields[i];
     DTMoney:=SumMoney(AQDT1,'money');
     STDT1.Caption :=formatfloat('0.00',DTMoney);
     //---------------取动力触探调整系数-----------------
     aSList.Clear ;
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010302'+'''';
     ADOQuery1.Open;
     if ADOQuery1.RecordCount>0 then
        begin
        aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
        if PosStrInList(aSList,'09')>=0 then
           begin
           RBDT1.Checked :=true;
           ChBDT1.Checked :=true;
           end;
        if PosStrInList(aSList,'10')>=0 then
           begin
           RBDT2.Checked :=true;
           ChBDT1.Checked :=true;
           end;
        if PosStrInList(aSList,'11')>=0 then
           begin
           RBDT3.Checked :=true;
           ChBDT1.Checked :=true;
           end;
        if PosStrInList(aSList,'12')>=0 then
           begin
           RBDT4.Checked :=true;
           ChBDT1.Checked :=true;
           end;
        if PosStrInList(aSList,'16')>=0 then ChBDT4.Checked :=true;
        end;
     setDTMoney;
     //标准贯入
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010301'+''' order by ItemID';
     ADOQuery1.Open ;
     DrlItemName.Clear;
     setlength(DrlU100Price,0);
     i:=0;
     while not ADOQuery1.Eof do
        begin
        setlength(DrlU100Price,i+1);
        DrlItemName.Add(ADOQuery1.fieldbyname('itemname').AsString);
        for j:=0 to 3 do
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
        AQBG2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,'
          +'drl_no,stra_category,category from stratum,stratumcategory92'
          +' where prj_no='''+g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''
          +stringReplace(AQBG1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
          +' ORDER BY stratum.stra_depth';
        AQBG2.Open ;
        aBase:=0;
        i:=0;
        while not AQBG2.Eof do
           begin
           aValue:=AQBG2.fieldbyname('stra_depth').AsFloat;
           if (aDepth>=aBase) and (aDepth<=aValue) then
              begin
              
              if aDepth<=50 then i:=0
              else i:=1;
              ItemStart:=formatfloat('0.0',AQBG1.fieldbyname('begin_depth').AsFloat);
              ItemEnd:=formatfloat('0.0',aDepth);
              j:=AQBG2.fieldbyname('stra_category').AsInteger;
              if (j<4) and (j>-1) then
                 aUPrice:=DrlU100Price[i,j]
              else
                 aUPrice:=0;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQBG2.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,DrlItemName[i],AQBG2.fieldbyname('stra_no').AsString+'-'+AQBG2.fieldbyname('sub_no').AsString,AQBG2.fieldbyname('category').AsString,aUPrice,1,aUPrice,5,'','') then
                 begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
                 end;
              end;
           aBase := aValue;
           AQBG2.Next ;
           end;
        if i<0 then break;
        AQBG1.Next ;
        end;
     AQBG1.Close ;
     AQBG1.SQL.Text :='select drl_no,DRange,category,unitprice,depth,money,prj_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=5 order by rec_no';
     AQBG1.Open ;
     for i:=0 to DGBG1.Columns.Count-1 do
        DGBG1.Columns[i].Field :=AQBG1.Fields[i];
     STBG1.Caption :=formatfloat('0.00',SumMoney(AQBG1,'money'));
     SetDBCData;
     //十字板剪切
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010306'+''' order by ItemID';
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
        RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('～',DrlItemName[i])+2,length(DrlItemName[i])-pos('～',DrlItemName[i])-1));
        for j:=0 to 2 do
           DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
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
        AQCB2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
          +'stra_category,category from stratum,stratumcategory92'
          +' where prj_no='''
          +g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''
          +stringReplace(AQCB1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
          +' ORDER BY stra_depth';
        AQCB2.Open ;
        aBase:=0;
        i:=0;
        while not AQCB2.Eof do
           begin
           aValue:=AQCB2.FieldByName('stra_depth').AsFloat;
           if (aDepth>=aBase) and (aDepth<=aValue) then
              begin
              i:=GetIndexOfRange(RangeValue,aDepth,true);
              if i=-2 then break;
              j:=AQCB2.fieldbyname('stra_category').AsInteger;
              if (j<2) and (j>-1) then
                 aUPrice:=DrlU100Price[i,j]
              else
                 aUPrice:=0;
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr+AQCB2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,AQCB2.fieldbyname('drl_no').AsString,'0',DrlItemName[i],AQCB2.fieldbyname('stra_no').AsString+'-'+AQCB2.fieldbyname('sub_no').AsString,AQCB2.fieldbyname('category').AsString,aUPrice,1,aUPrice,6,'',tmpStr) then
                 begin
                 application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                 i:=-1;
                 break;
                 end;
              end;
           aBase := aValue;
           AQCB2.Next ;
           end;
        if i<0 then break;
        AQCB1.Next ;
        end;
     AQCB1.Close ;
     AQCB1.SQL.Text :='select drl_no,DRange,category,unitprice,depth,money,prj_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=6 order by rec_no';
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
     ADOQuery1.SQL.Text :='select * from unitPrice92 where substring(itemid,1,6)='''+'010303'+''' order by ItemID';
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
        RangeValue[i]:=strtofloat(copy(DrlItemName[i],pos('～',DrlItemName[i])+2,length(DrlItemName[i])-pos('～',DrlItemName[i])-1));
        for j:=0 to 3 do
           DrlU100Price[i,j]:=ADOQuery1.Fields[j+2].AsFloat;
        ADOQuery1.Next ;
        inc(i);
        end;

     while not AQJT1.Eof do
        begin
        aDepth:=AQJT1.fieldbyname('CDepth').AsFloat ;
        aBase:=AQJT1.fieldbyname('begin_depth').AsFloat ;

        AQJT2.Close ;
        AQJT2.SQL.Text :='select stra_no,sub_no,stra_depth,prj_no,drl_no,'
          +'stra_category,category from stratum,stratumcategory92'
          +' where prj_no='''
          +g_ProjectInfo.prj_no_ForSQL
          +''' and stra_category=id and drl_no='''
          +stringReplace(AQJT1.fieldbyname('drl_no').AsString ,'''','''''',[rfReplaceAll])+''''
          +' ORDER BY stra_depth';
        AQJT2.Open ;
        while not AQJT2.Eof do
           begin
           if AQJT2.FieldByName('stra_depth').AsFloat>aBase then break;
           AQJT2.Next ;
           end;
        //aTop:=aTop-aBase;//换成起始深度的标高
        i:=0;
        aFlag:=true;
        tmpBase:=aBase;
        while (not AQJT2.Eof) and aFlag do
           begin
           i:=GetIndexOfRange(RangeValue,tmpBase,true);
           if i=-2 then break;
           aValue:=abs(AQJT2.FieldByName('stra_depth').AsFloat);
           if aValue>aDepth then
              aFlag:=false;
           if aValue>100 then aValue:=100;
           j:=GetIndexOfRange(RangeValue,aValue,false);
           if i>j then//仅一种情况
              begin
              ItemStart:=formatfloat('0.0',tmpBase);
              ItemEnd:=formatfloat('0.0',aValue);

//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit 
          
              aTmpDepth:=aValue-tmpBase;
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))+tmpStr
                +AQJT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,
                AQJT2.fieldbyname('drl_no').AsString,
                ItemStart+'～'+ItemEnd,DrlItemName[i],
                AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,
                AQJT2.fieldbyname('category').AsString,aUPrice,aTmpDepth,
                aUPrice*aTmpDepth,4,'',tmpStr) then
                 begin
                   application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                   i:=-1;
                   break;
                 end;
              end
           else if i=j then//一分为二
              begin
              //---------第一段
              ItemStart:=formatfloat('0.0',tmpBase);
              ItemEnd:=formatfloat('0.0',RangeValue[i]);
              aTmpDepth:=RangeValue[i]-tmpBase;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))
                +tmpStr+AQJT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,g_ProjectInfo.prj_no,
                AQJT2.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,
                DrlItemName[i],AQJT2.fieldbyname('stra_no').AsString
                +'-'+AQJT2.fieldbyname('sub_no').AsString,
                AQJT2.fieldbyname('category').AsString,
                aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
                 begin
                   application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                   i:=-1;
                   break;
                 end;
              //---------第二段
              aTmpStart:=RangeValue[i];
              inc(i);
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))
                +tmpStr+AQJT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,
                g_ProjectInfo.prj_no,
                AQJT2.fieldbyname('drl_no').AsString,ItemStart+'～'+ItemEnd,
                DrlItemName[i],
                AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,
                AQJT2.fieldbyname('category').AsString,
                aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
                 begin
                   application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                   i:=-1;
                   break;
                 end;
              end
           else//一层分为多段
              begin
              //-------------第一部分
              ItemStart:=formatfloat('0.0',tmpBase);
              ItemEnd:=formatfloat('0.0',RangeValue[i]);
              aTmpDepth:=RangeValue[i]-tmpBase;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              tmpStr:=copy(DrlItemName[i],1,pos('～',DrlItemName[i])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))
                +tmpStr+AQJT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1,
                g_ProjectInfo.prj_no,
                AQJT2.fieldbyname('drl_no').AsString,
                ItemStart+'～'+ItemEnd,DrlItemName[i],
                AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,
                AQJT2.fieldbyname('category').AsString,
                aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
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
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
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
                 tmpStr:=copy(DrlItemName[k],1,pos('～',DrlItemName[k])-1);
                 tmpStr:=stringofchar('0',5-length(tmpStr))
                   +tmpStr+AQJT2.fieldbyname('category').AsString;
                 if not InsertChargeRec(adoquery1,
                   g_ProjectInfo.prj_no,
                   AQJT2.fieldbyname('drl_no').AsString,
                   DrlItemName[k],DrlItemName[k],
                   AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString,
                   AQJT2.fieldbyname('category').AsString,
                   aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
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
              ItemStart:=formatfloat('0.0',aTmpStart+0.1);
              ItemEnd:=formatfloat('0.0',aValue);
              aTmpDepth:=aValue-aTmpStart;//+0.1;
//20040826 yys edit
              //aUPrice:=DrlU100Price[i,AQJT2.fieldbyname('stra_category').AsInteger];
              tmp_cid := AQJT2.fieldbyname('stra_category').AsInteger;
              if (tmp_cid<0) or (tmp_cid>3) then
                  aUPrice :=0
              else
                  aUPrice:=DrlU100Price[i,tmp_cid];
//20040826 yys edit
              tmpStr:=copy(DrlItemName[j],1,pos('～',DrlItemName[j])-1);
              tmpStr:=stringofchar('0',5-length(tmpStr))
                +tmpStr+AQJT2.fieldbyname('category').AsString;
              if not InsertChargeRec(adoquery1
                ,g_ProjectInfo.prj_no,AQJT2.fieldbyname('drl_no').AsString
                ,ItemStart+'～'+ItemEnd
                ,DrlItemName[j]
                ,AQJT2.fieldbyname('stra_no').AsString+'-'+AQJT2.fieldbyname('sub_no').AsString
                ,AQJT2.fieldbyname('category').AsString
                ,aUPrice,aTmpDepth,aUPrice*aTmpDepth,4,'',tmpStr) then
                 begin
                   application.MessageBox(DBERR_NOTSAVE,HINT_TEXT);
                   i:=-1;
                   break;
                 end;
              end;
           tmpBase:=aValue;
           AQJT2.Next ;
           end;
        if i<0 then break;
        AQJT1.Next ;
        end;
     AQJT2.Close ;
     AQJT2.SQL.Text :='select stra_no,sub_no,stra_depth,'
     +'prj_no,drl_no,stra_category,category from stratum,stratumcategory92'
     +' where prj_no='''
     +g_ProjectInfo.prj_no_ForSQL
     +''' and stra_category=id'
     +' ORDER BY stra_depth';
     AQJT2.Open ;
     DGJT2.Columns[0].Field :=AQJT2.Fields[0];
     DGJT2.Columns[1].Field :=AQJT2.Fields[1];
     DGJT2.Columns[2].Field :=AQJT2.Fields[2];

     AQJT3.Close ;
     AQJT3.SQL.Text :='select item,DRange,Stra_sub_no,category,unitprice,depth,money,prj_no,drl_no from drillcharge92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and Drill_Type=4 order by rec_no';
     AQJT3.Open ;
     for i:=0 to DGJT3.Columns.Count-1 do
        DGJT3.Columns[i].Field :=AQJT3.Fields[i];
     JTMoney:=SumMoney(AQJT3,'money');
     //---------------取静力触探调整系数-----------------
     aSList.Clear ;
     ADOQuery1.Close ;
     ADOQuery1.SQL.Text :='select prj_no,itemid,adjustitems,adjustmodulus from adjustment92 where prj_no='''+g_ProjectInfo.prj_no_ForSQL+''' and itemid='''+'010303'+'''';
     ADOQuery1.Open;
     if ADOQuery1.RecordCount>0 then
        begin
        aSList.Text :=ADOQuery1.fieldbyname('adjustitems').AsString;
        if PosStrInList(aSList,'24')>=0 then
           begin
           RBJT1.Checked :=true;
           ChBJT1.Checked :=true;
           end;
        if PosStrInList(aSList,'25')>=0 then
           begin
           RBJT2.Checked :=true;
           ChBJT1.Checked :=true;
           end;
        if PosStrInList(aSList,'26')>=0 then
           begin
           RBJT3.Checked :=true;
           ChBJT1.Checked :=true;
           end;
        if PosStrInList(aSList,'27')>=0 then
           begin
           RBJT4.Checked :=true;
           ChBJT1.Checked :=true;
           end;
        if PosStrInList(aSList,'20')>=0 then ChBJT2.Checked :=true;
        if PosStrInList(aSList,'21')>=0 then ChBJT3.Checked :=true;
        if PosStrInList(aSList,'22')>=0 then ChBJT4.Checked :=true;
        end;
     setJTMoney;
     //-------------------------------------------------------
     isFirst:=false;

     AQDrill.first;
     AQTJ.First ;
     AQJT1.First ;
     DrlItemName.free;

     aSList.Free ;
  except
     application.MessageBox(DBERR_NOTREAD,HINT_TEXT);
     isFirst:=false;
  end;
end;


procedure TReconCharge92.AQDrillAfterScroll(DataSet: TDataSet);
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

procedure TReconCharge92.AQStratumAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
     AQMoney.Locate('Stra_sub_no',AQStratum.fieldbyname('stra_no').AsString
     +'-'+stringReplace(AQStratum.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconCharge92.ChBRecon1Click(Sender: TObject);
begin
   if ChBRecon1.Checked then
      begin
      EdtRecon1.Enabled :=true;
      UpDown1.Enabled :=true;
      end
   else
      begin
      EdtRecon1.Enabled :=false;
      UpDown1.Enabled :=false;
      end;
   SetReconMoney;
end;

procedure TReconCharge92.EdtRecon1Enter(Sender: TObject);
begin
   EditEnter(EdtRecon1);
end;

procedure TReconCharge92.EdtRecon1Exit(Sender: TObject);
var
   aValue:integer;
begin
   if trim(EdtRecon1.Text)='' then EdtRecon1.Text :='0';
   aValue:=strtoint(trim(EdtRecon1.Text));
   if aValue<10 then aValue:=10
   else if aValue>30 then aValue:=30;
   UpDown1.Position:=aValue;
   EdtRecon1.Text :=formatfloat('00',aValue);
   SetReconMoney;
end;

procedure TReconCharge92.EdtRecon1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconCharge92.EdtRecon1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconCharge92.UpDown1ChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
   if (NewValue<10) or (NewValue>30) then exit;
   if AllowChange then
     begin
     EdtRecon1.Text :=inttostr(NewValue);
     SetReconMoney;
     end;
end;

procedure TReconCharge92.CBDrill1Click(Sender: TObject);
begin
   if CBDrill1.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.5)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.5);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill2Click(Sender: TObject);
begin
   if CBDrill2.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.3)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.3);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill4Click(Sender: TObject);
begin
   if CBDrill4.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.5)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.5);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill5Click(Sender: TObject);
begin
   if CBDrill5.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.3)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.3);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill6Click(Sender: TObject);
begin
   if CBDrill6.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-1);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill7Click(Sender: TObject);
begin
   if CBDrill7.Checked then
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.2)
   else
      STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-0.2);
   SetDrillMoney;
end;

procedure TReconCharge92.CBDrill3Click(Sender: TObject);
begin
if CBDrill3.Checked then
   begin
   RBDrill1.Enabled :=true;
   RBDrill2.Enabled :=true;
   RBDrill3.Enabled :=true;
   RBDrill4.Enabled :=true;
   if RBDrill1.Checked then
      m_RBVal:=2
   else if RBDrill2.Checked then
      m_RBVal:=1
   else if RBDrill3.Checked then
      m_RBVal:=0.4
   else
      m_RBVal:=0.3;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+m_RBVal);
   end
else
   begin
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)-m_RBVal);
   RBDrill1.Enabled :=false;
   RBDrill2.Enabled :=false;
   RBDrill3.Enabled :=false;
   RBDrill4.Enabled :=false;
   end;
SetDrillMoney;
end;

procedure TReconCharge92.RBDrill1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+2-m_RBVal);
   m_RBVal:=2;
   SetDrillMoney;
end;

procedure TReconCharge92.RBDrill2Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+1-m_RBVal);
   m_RBVal:=1;
   SetDrillMoney;
end;

procedure TReconCharge92.RBDrill3Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.4-m_RBVal);
   m_RBVal:=0.4;
   SetDrillMoney;
end;

procedure TReconCharge92.RBDrill4Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDrill1.Caption :=formatfloat('0.00',strtofloat(STDrill1.Caption)+0.3-m_RBVal);
   m_RBVal:=0.3;
   SetDrillMoney;
end;

procedure TReconCharge92.EDrill1KeyPress(Sender: TObject; var Key: Char);
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

procedure TReconCharge92.EDrill1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TReconCharge92.EWS1Enter(Sender: TObject);
begin
EditEnter(EWS1);
end;

procedure TReconCharge92.EWS2Enter(Sender: TObject);
begin
EditEnter(EWS2);
end;

procedure TReconCharge92.EWS3Enter(Sender: TObject);
begin
EditEnter(EWS3);
end;

procedure TReconCharge92.EWS1Exit(Sender: TObject);
begin
   if trim(EWS1.Text)='' then EWS1.Text :='0';
   EditFormat(EWS1);
   SetWSData;
end;

procedure TReconCharge92.EWS2Exit(Sender: TObject);
begin
   if trim(EWS2.Text)='' then EWS2.Text :='0';
   EditFormat(EWS2);
   SetWSData;
end;

procedure TReconCharge92.EWS3Exit(Sender: TObject);
begin
   if trim(EWS3.Text)='' then EWS3.Text :='0';
   EditFormat(EWS3);
   SetWSData;
end;

procedure TReconCharge92.ChBMap1Click(Sender: TObject);
begin
   if ChBMap1.Checked then
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)+0.5)
   else
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)-0.5);
   SetMapMoney;
end;

procedure TReconCharge92.ChBMap2Click(Sender: TObject);
begin
   if ChBMap2.Checked then
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)+0.3)
   else
      STMap3.Caption :=formatfloat('0.00',strtofloat(STMap3.Caption)-0.3);
   SetMapMoney;
end;

procedure TReconCharge92.AQMapAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(0);
   BBMap1.Enabled :=false;
end;

procedure TReconCharge92.AQMapAfterInsert(DataSet: TDataSet);
begin
   if not BBMap2.Enabled then BBMap2.Enabled:=true;
end;

procedure TReconCharge92.CBMap1Select(Sender: TObject);
begin
if not AQMap.Locate('itemid',m_ItemID[0][CBMap1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(EdtMap1.Text))<>0 then
      begin
      EdtMap1.Text:='0';
      EditFormat(EdtMap1);
      end;
   if CBMap2.ItemIndex<0 then
      begin
      STMap1.Caption :='0.00';
      STMap1.Caption :='0.00';
      end
   else
      begin
      SetMoneySP(0);
      if not BBMap1.Enabled then BBMap1.Enabled:=true;
      end;
   end
end;

procedure TReconCharge92.CBMap2Select(Sender: TObject);
begin
   if CBMap1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBMap1.Enabled then BBMap1.Enabled:=true;
   SetMoneySP(0);
end;

procedure TReconCharge92.EdtMap1Change(Sender: TObject);
begin
   if m_EtText<>trim(EdtMap1.Text) then BBMap1.Enabled:=true;
end;

procedure TReconCharge92.EdtMap1Enter(Sender: TObject);
begin
m_EtText:=trim(EdtMap1.Text);
EditEnter(EdtMap1);
end;

procedure TReconCharge92.EdtMap1Exit(Sender: TObject);
begin
   if trim(EdtMap1.Text)='' then EdtMap1.Text :='0';
   EdtMap1.Text :=formatfloat('0.00',strtofloat(trim(EdtMap1.Text)));
   EditFormat(EdtMap1);
   STMap2.Caption :=formatfloat('0.00',strtofloat(STMap1.Caption)*strtofloat(trim(EdtMap1.Text)));
end;

procedure TReconCharge92.BBMap1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQMap.Locate('itemid;category',vararrayof([m_ItemID[0][CBMap1.ItemIndex],CBMap2.Text]), [loPartialKey]) then
         begin
         AQMap.Insert;
         AQMap.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQMap.FieldByName('itemid').AsString :=m_ItemID[0][CBMap1.ItemIndex];
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
      SetSPData(0,true);
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

procedure TReconCharge92.BBMap2Click(Sender: TObject);
begin
DeleteRecord(AQMap,0);
end;

procedure TReconCharge92.AQTCAfterInsert(DataSet: TDataSet);
begin
   if not BBC2.Enabled then BBC2.Enabled:=true;
end;

procedure TReconCharge92.AQEAfterInsert(DataSet: TDataSet);
begin
   if not BBE2.Enabled then BBE2.Enabled:=true;
end;

procedure TReconCharge92.AQTCAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(1);
   BBC1.Enabled :=false;
end;

procedure TReconCharge92.AQEAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(2);
   BBE1.Enabled :=false;
end;

procedure TReconCharge92.CBC1Select(Sender: TObject);
begin
if not AQTC.Locate('itemid',m_ItemID[1][CBC1.ItemIndex], [loPartialKey]) then
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
      SetMoneySP(1);
      if not BBC1.Enabled then BBC1.Enabled:=true;
      end;
   end
end;

procedure TReconCharge92.CBC2Select(Sender: TObject);
begin
   if CBC1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBC1.Enabled then BBC1.Enabled:=true;
   SetMoneySP(1);
end;

procedure TReconCharge92.EC1Change(Sender: TObject);
begin
   if m_EtText<>trim(EC1.Text) then BBC1.Enabled:=true;
end;

procedure TReconCharge92.EC1Enter(Sender: TObject);
begin
m_EtText:=trim(EC1.Text);
EditEnter(EC1);
end;

procedure TReconCharge92.EC1Exit(Sender: TObject);
begin
   if trim(EC1.Text)='' then EC1.Text :='0';
   EC1.Text :=formatfloat('0.00',strtofloat(trim(EC1.Text)));
   EditFormat(EC1);
   STC2.Caption :=formatfloat('0.00',strtofloat(STC1.Caption)*strtofloat(trim(EC1.Text)))
end;

procedure TReconCharge92.BBC1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQTC.Locate('itemid;category',vararrayof([m_ItemID[1][CBC1.ItemIndex],CBC2.Text]), [loPartialKey]) then
         begin
         AQTC.Insert;
         AQTC.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQTC.FieldByName('itemid').AsString :=m_ItemID[1][CBC1.ItemIndex];
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
      SetSPData(1,true);
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

procedure TReconCharge92.BBC2Click(Sender: TObject);
begin
DeleteRecord(AQTC,1);
end;

procedure TReconCharge92.CBE1Select(Sender: TObject);
begin
if not AQE.Locate('itemid',m_ItemID[2][CBE1.ItemIndex], [loPartialKey]) then
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
      SetMoneySP(2);
      if not BBE1.Enabled then BBE1.Enabled:=true;
      end;
   end
end;

procedure TReconCharge92.CBE2Select(Sender: TObject);
begin
   if CBE1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBE1.Enabled then BBE1.Enabled:=true;
   SetMoneySP(2);
end;

procedure TReconCharge92.EE1Change(Sender: TObject);
begin
   if m_EtText<>trim(EE1.Text) then BBE1.Enabled:=true;
end;

procedure TReconCharge92.EE1Enter(Sender: TObject);
begin
m_EtText:=trim(EE1.Text);
EditEnter(EE1);
end;

procedure TReconCharge92.EE1Exit(Sender: TObject);
begin
   if trim(EE1.Text)='' then EE1.Text :='0';
   EE1.Text :=formatfloat('0',strtofloat(trim(EE1.Text)));
   EditFormat(EE1);
   STE2.Caption :=formatfloat('0.00',strtofloat(STE1.Caption)*strtofloat(trim(EE1.Text)))
end;

procedure TReconCharge92.BBE1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQE.Locate('itemid;category',vararrayof([m_ItemID[2][CBE1.ItemIndex],CBE2.Text]), [loPartialKey]) then
         begin
         AQE.Insert;
         AQE.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQE.FieldByName('itemid').AsString :=m_ItemID[2][CBE1.ItemIndex];
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
      SetSPData(2,true);
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

procedure TReconCharge92.BBE2Click(Sender: TObject);
begin
DeleteRecord(AQE,2);
end;

procedure TReconCharge92.EYZ1Enter(Sender: TObject);
begin
EditEnter(EYZ1);
end;

procedure TReconCharge92.EYZ1Exit(Sender: TObject);
begin
   if trim(EYZ1.Text)='' then EYZ1.Text :='0';
   EditFormat(EYZ1);
   SetYZData;
end;

procedure TReconCharge92.EYZ2Enter(Sender: TObject);
begin
EditEnter(EYZ2);
end;

procedure TReconCharge92.EYZ3Enter(Sender: TObject);
begin
EditEnter(EYZ3);
end;

procedure TReconCharge92.EYZ4Enter(Sender: TObject);
begin
EditEnter(EYZ4);
end;

procedure TReconCharge92.EYZ2Exit(Sender: TObject);
begin
   if trim(EYZ2.Text)='' then EYZ2.Text :='0';
   EditFormat(EYZ2);
   SetYZData;
end;

procedure TReconCharge92.EYZ3Exit(Sender: TObject);
begin
   if trim(EYZ3.Text)='' then EYZ3.Text :='0';
   EditFormat(EYZ3);
   SetYZData;
end;

procedure TReconCharge92.EYZ4Exit(Sender: TObject);
begin
   if trim(EYZ4.Text)='' then EYZ4.Text :='0';
   EditFormat(EYZ4);
   SetYZData;
end;

procedure TReconCharge92.EK1Exit(Sender: TObject);
begin
   if trim(EK1.Text)='' then EK1.Text :='0';
   EditFormat(EK1);
   SetKData ;
end;

procedure TReconCharge92.EK1Enter(Sender: TObject);
begin
EditEnter(EK1);
end;

procedure TReconCharge92.CBP1Select(Sender: TObject);
begin
if not AQP.Locate('itemid',m_ItemID[3][CBP1.ItemIndex], [loPartialKey]) then
   begin
   if strtofloat(trim(ep1.Text))<>0 then
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
      SetMoneySP(3);
      if not BBP1.Enabled then BBP1.Enabled:=true;
      end;
   end;
end;

procedure TReconCharge92.CBP2Select(Sender: TObject);
begin
   if CBP1.ItemIndex<0 then
      begin
      exit;
      end;
   if not BBP1.Enabled then BBP1.Enabled:=true;
   SetMoneySP(3);
end;

procedure TReconCharge92.EP1Change(Sender: TObject);
begin
   if m_EtText<>trim(EP1.Text) then BBP1.Enabled:=true;
end;

procedure TReconCharge92.EP1Enter(Sender: TObject);
begin
m_EtText:=trim(EP1.Text);
EditEnter(EP1);
end;

procedure TReconCharge92.EP1Exit(Sender: TObject);
begin
   if trim(EP1.Text)='' then EP1.Text :='0';
   EditFormat(EP1);
   STP2.Caption :=formatfloat('0.00',strtofloat(STP1.Caption)*strtofloat(trim(EP1.Text)))
end;

procedure TReconCharge92.BBP1Click(Sender: TObject);
var
   aBM:tbookmark;
begin
   try
      begin
      isFirst:=true;
      if not AQP.Locate('itemid;category',vararrayof([m_ItemID[3][CBP1.ItemIndex],CBP2.Text]), [loPartialKey]) then
         begin
         AQP.Insert;
         AQP.FieldByName('prj_no').AsString :=g_ProjectInfo.prj_no;
         AQP.FieldByName('itemid').AsString :=m_ItemID[3][CBP1.ItemIndex];
         end
      else
         AQP.Edit ;
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
      SetSPData(3,true);
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

procedure TReconCharge92.BBP2Click(Sender: TObject);
begin
DeleteRecord(AQP,3);
end;

procedure TReconCharge92.AQPAfterInsert(DataSet: TDataSet);
begin
   if not BBP2.Enabled then BBP2.Enabled:=true;
end;

procedure TReconCharge92.AQPAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      SetSPData(3);
   BBP1.Enabled :=false;
end;

procedure TReconCharge92.AQTJSAfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQTJM.Locate('Stra_sub_no',AQTJS.fieldbyname('stra_no').AsString
      +'-'+stringReplace(AQTJS.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconCharge92.AQJT1AfterScroll(DataSet: TDataSet);
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

procedure TReconCharge92.AQTJAfterScroll(DataSet: TDataSet);
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

procedure TReconCharge92.AQJT2AfterScroll(DataSet: TDataSet);
begin
   if not isFirst then
      AQJT3.Locate('Stra_sub_no',AQJT2.fieldbyname('stra_no').AsString+'-'
      +stringReplace(AQJT2.fieldbyname('sub_no').AsString,'''','''''',[rfReplaceAll]),[loPartialKey]);
end;

procedure TReconCharge92.ChBDT1Click(Sender: TObject);
begin
if ChBDT1.Checked then
   begin
   RBDT1.Enabled :=true;
   RBDT2.Enabled :=true;
   RBDT3.Enabled :=true;
   RBDT4.Enabled :=true;
   if RBDT1.Checked then
      m_RBDVal:=2
   else if RBDT2.Checked then
      m_RBDVal:=1
   else if RBDT3.Checked then
      m_RBDVal:=0.4
   else
      m_RBDVal:=0.3;
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+m_RBDVal);
   end
else
   begin
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)-m_RBDVal);
   RBDT1.Enabled :=false;
   RBDT2.Enabled :=false;
   RBDT3.Enabled :=false;
   RBDT4.Enabled :=false;
   end;
SetDTMoney;
end;

procedure TReconCharge92.RBDT1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+2-m_RBDVal);
   m_RBDVal:=2;
   SetDTMoney;
end;

procedure TReconCharge92.RBDT2Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+1-m_RBDVal);
   m_RBDVal:=1;
   SetDTMoney;
end;

procedure TReconCharge92.RBDT3Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+0.4-m_RBDVal);
   m_RBDVal:=0.4;
   SetDTMoney;
end;

procedure TReconCharge92.RBDT4Click(Sender: TObject);
begin
   if IsFirst then exit;
   STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+0.3-m_RBDVal);
   m_RBDVal:=0.3;
   SetDTMoney;
end;

procedure TReconCharge92.ChBDT4Click(Sender: TObject);
begin
   if ChBDT4.Checked then
      STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)+0.2)
   else
      STDT2.Caption :=formatfloat('0.00',strtofloat(STDT2.Caption)-0.2);
   SetDTMoney;
end;

procedure TReconCharge92.ChBJT1Click(Sender: TObject);
begin
if ChBJT1.Checked then
   begin
   RBJT1.Enabled :=true;
   RBJT2.Enabled :=true;
   RBJT3.Enabled :=true;
   RBJT4.Enabled :=true;
   if RBJT1.Checked then
      m_RBJVal:=2
   else if RBJT2.Checked then
      m_RBJVal:=1
   else if RBJT3.Checked then
      m_RBJVal:=0.4
   else
      m_RBJVal:=0.3;
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+m_RBJVal);
   end
else
   begin
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)-m_RBJVal);
   RBJT1.Enabled :=false;
   RBJT2.Enabled :=false;
   RBJT3.Enabled :=false;
   RBJT4.Enabled :=false;
   end;
SetJTMoney;
end;

procedure TReconCharge92.RBJT1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+2-m_RBJVal);
   m_RBJVal:=2;
   SetJTMoney;
end;

procedure TReconCharge92.RBJT2Click(Sender: TObject);
begin
   if IsFirst then exit;
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+1-m_RBJVal);
   m_RBJVal:=1;
   SetJTMoney;
end;

procedure TReconCharge92.RBJT3Click(Sender: TObject);
begin
   if IsFirst then exit;
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+0.4-m_RBJVal);
   m_RBJVal:=0.4;
   SetJTMoney;
end;

procedure TReconCharge92.RBJT4Click(Sender: TObject);
begin
   if IsFirst then exit;
   STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+0.3-m_RBJVal);
   m_RBJVal:=0.3;
   SetJTMoney;
end;

procedure TReconCharge92.ChBJT2Click(Sender: TObject);
begin
   if ChBJT2.Checked then
      STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+0.15)
   else
      STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)-0.15);
   SetJTMoney;
end;

procedure TReconCharge92.ChBJT3Click(Sender: TObject);
begin
   if ChBJT3.Checked then
      JTMoney :=JTMoney*0.5
   else
      JTMoney :=JTMoney*2;
   SetJTMoney;
end;

procedure TReconCharge92.ChBJT4Click(Sender: TObject);
begin
   if ChBJT4.Checked then
      STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)+0.5)
   else
      STJT2.Caption :=formatfloat('0.00',strtofloat(STJT2.Caption)-0.5);
   SetJTMoney;
end;

end.
