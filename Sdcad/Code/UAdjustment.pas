unit UAdjustment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,public_unit;

type
  TFAdjustment = class(TForm)
    BBA1: TBitBtn;
    GroupBox8: TGroupBox;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Shape12: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label55: TLabel;
    Label1: TLabel;
    CBA2: TCheckBox;
    RBA1: TRadioButton;
    RBA2: TRadioButton;
    RBA5: TRadioButton;
    RBA6: TRadioButton;
    STA1: TStaticText;
    RBA3: TRadioButton;
    RBA4: TRadioButton;
    CBA1: TCheckBox;
    CBA3: TCheckBox;
    EA1: TEdit;
    procedure BBA1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBA2Click(Sender: TObject);
    procedure RBA1Click(Sender: TObject);
    procedure RBA2Click(Sender: TObject);
    procedure RBA3Click(Sender: TObject);
    procedure RBA4Click(Sender: TObject);
    procedure RBA5Click(Sender: TObject);
    procedure RBA6Click(Sender: TObject);
    procedure CBA1Click(Sender: TObject);
    procedure CBA3Click(Sender: TObject);
    procedure EA1Enter(Sender: TObject);
    procedure EA1KeyPress(Sender: TObject; var Key: Char);
    procedure EA1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EA1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    m_ADMod:tstrings;
    m_mod1030:double;
  end;

var
  FAdjustment: TFAdjustment;

implementation

{$R *.dfm}
var
   m_RBVal:double;
   IsFirst,isSelAll:boolean;

procedure TFAdjustment.BBA1Click(Sender: TObject);
begin
close;
end;

procedure TFAdjustment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   m_ADMod.Clear ;
   if CBA1.Checked then m_ADMod.add('11');
   if CBA2.Checked then
      if RBA1.Checked then m_ADMod.add('12')
      else if RBA2.Checked then m_ADMod.add('13')
      else if RBA3.Checked then m_ADMod.add('14')
      else if RBA4.Checked then m_ADMod.add('15')
      else if RBA5.Checked then m_ADMod.add('16')
      else if RBA6.Checked then m_ADMod.add('17');
   if CBA3.Checked then
      m_ADMod.add('19')
   else
      m_mod1030:=0;
   Action:=cafree;
end;

procedure TFAdjustment.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);

   m_RBVal:=0;
   m_mod1030:=0;
   IsFirst:=true;
   isSelAll:=false;
   m_ADMod:=tstringlist.Create ;
end;

procedure TFAdjustment.FormShow(Sender: TObject);
begin
   if m_ADMod.Count>0 then
      begin
      if PosStrInList(m_ADMod,'11')>=0 then CBA1.Checked :=true;
      if PosStrInList(m_ADMod,'12')>=0 then
         begin
         RBA1.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'13')>=0 then
         begin
         RBA2.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'14')>=0 then
         begin
         RBA3.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'15')>=0 then
         begin
         RBA4.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'16')>=0 then
         begin
         RBA5.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'17')>=0 then
         begin
         RBA6.Checked :=true;
         CBA2.Checked :=true;
         end;
      if PosStrInList(m_ADMod,'19')>=0 then
         begin
         if m_mod1030<1.1 then EA1.Text :='1.10'
         else if m_mod1030>1.3 then EA1.Text :='1.30'
         else EA1.Text :=formatfloat('0.00',m_mod1030);
         EditFormat(EA1);
         CBA3.Checked :=true;
         end;
      end;
   IsFirst:=false;
end;

procedure TFAdjustment.CBA2Click(Sender: TObject);
begin
if CBA2.Checked then
   begin
   RBA1.Enabled :=true;
   RBA2.Enabled :=true;
   RBA3.Enabled :=true;
   RBA4.Enabled :=true;
   RBA5.Enabled :=true;
   RBA6.Enabled :=true;

   if RBA1.Checked then
      m_RBVal:=2
   else if RBA2.Checked then
      m_RBVal:=1
   else if RBA3.Checked then
      m_RBVal:=1.5
   else if RBA4.Checked then
      m_RBVal:=2
   else if RBA5.Checked then
      m_RBVal:=0.5
   else
      m_RBVal:=0.2;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+m_RBVal);
   end
else
   begin
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)-m_RBVal);
   RBA1.Enabled :=false;
   RBA2.Enabled :=false;
   RBA3.Enabled :=false;
   RBA4.Enabled :=false;
   RBA5.Enabled :=false;
   RBA6.Enabled :=false;
   end;
end;

procedure TFAdjustment.RBA1Click(Sender: TObject);
begin
   if IsFirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+2-m_RBVal);
   m_RBVal:=2;
end;

procedure TFAdjustment.RBA2Click(Sender: TObject);
begin
   if isfirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+1-m_RBVal);
   m_RBVal:=1;
end;

procedure TFAdjustment.RBA3Click(Sender: TObject);
begin
   if isfirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+1.5-m_RBVal);
   m_RBVal:=1.5;
end;

procedure TFAdjustment.RBA4Click(Sender: TObject);
begin
   if isfirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+2-m_RBVal);
   m_RBVal:=2;
end;

procedure TFAdjustment.RBA5Click(Sender: TObject);
begin
   if isfirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+0.5-m_RBVal);
   m_RBVal:=0.5;
end;

procedure TFAdjustment.RBA6Click(Sender: TObject);
begin
   if isfirst then exit;
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+0.2-m_RBVal);
   m_RBVal:=0.2;
end;

procedure TFAdjustment.CBA1Click(Sender: TObject);
begin
if CBA1.Checked then
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+0.3)
else
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)-0.3);
end;

procedure TFAdjustment.CBA3Click(Sender: TObject);
begin
if CBA3.Checked then
   begin
   EA1.Enabled :=true;
   m_mod1030:=strtofloat(trim(EA1.text));
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+m_mod1030-1.0);
   end
else
   begin
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)-(m_mod1030-1.00));
   EA1.Enabled :=false;
   end;
end;

procedure TFAdjustment.EA1Enter(Sender: TObject);
begin
tedit(sender).Text :=trim(tedit(sender).Text);
tedit(sender).SelectAll ;
isSelAll:=true;
end;

procedure TFAdjustment.EA1KeyPress(Sender: TObject; var Key: Char);
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

procedure TFAdjustment.EA1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   if isSelAll then
      begin
      tedit(sender).SelectAll ;
      isSelAll:=false;
      end;
end;

procedure TFAdjustment.EA1Exit(Sender: TObject);
begin
   if trim(EA1.Text)='' then EA1.Text:='1.10';
   if strtofloat(trim(EA1.Text))>1.3 then
      EA1.Text :='1.30'
   else if strtofloat(trim(EA1.Text))<1.10 then
      EA1.Text :='1.10';
   eA1.Text :=formatfloat('0.00',strtofloat(trim(eA1.Text)));
   EditFormat(eA1);
   STA1.Caption :=formatfloat('0.00',strtofloat(STA1.Caption)+strtofloat(trim(eA1.Text))-m_mod1030);
   m_mod1030:=strtofloat(trim(EA1.text));
end;

end.
