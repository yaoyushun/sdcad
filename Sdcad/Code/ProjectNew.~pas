unit ProjectNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, strUtils;

type
  TProjectNewForm = class(TForm)
    lblprj_no: TLabel;
    lblprj_name: TLabel;
    lblarea_name: TLabel;
    lblbuilder: TLabel;
    lblbegin_date: TLabel;
    lblend_date: TLabel;
    lblconsigner: TLabel;
    lblPrj_grade: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtprj_no: TEdit;
    edtprj_name: TEdit;
    edtarea_name: TEdit;
    edtbuilder: TEdit;
    edtconsigner: TEdit;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    dtpBegin_date: TDateTimePicker;
    dtpEnd_date: TDateTimePicker;
    cboPrj_grade: TComboBox;
    cboPrj_type: TComboBox;
    edtprj_name_en: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cancelClick(Sender: TObject);
    procedure edtprj_noKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpBegin_dateKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function Check_Data:boolean;
    function Insert_Project(aPrj_no,aPrj_name,aPrj_name_en,
          aArea_name,aBuilder,aBegin_date,aEnd_date,aPrj_grade,aConsigner,aPrj_type:string):boolean;
    function isExistedProject(aProjectNo:string):boolean;
    function GetMaxProjectNo:String;
  public
    { Public declarations }
  end;

var
  ProjectNewForm: TProjectNewForm;

implementation

uses MainDM, public_unit, main;

{$R *.dfm}

function TProjectNewForm.Check_Data:boolean;
var
  strPrj_no,strPrj_name,strPrj_name_en,strArea_name,strBuilder,
  strBegin_date,strEnd_date,strConsigner:string;
begin
  strPrj_no := trim(edtPrj_no.Text);
  strPrj_name := trim(edtPrj_name.Text);
  strPrj_name_en := trim(edtprj_name_en.Text);
  strArea_name:= trim(edtArea_name.Text);
  strBuilder := trim(edtBuilder.Text);
  strBegin_date := datetostr(dtpBegin_date.Date);
  strEnd_date := datetostr(dtpEnd_date.Date);
  strConsigner:= trim(edtConsigner.Text);
  if strPrj_no = '' then
  begin
    messagebox(self.Handle,'请输入工程编号！','数据校对',mb_ok);
    edtPrj_no.SetFocus;
    result := false;
    exit;
  end;
  if strPrj_name = '' then
  begin
    messagebox(self.Handle,'请输入工程名称！','数据校对',mb_ok);
    edtPrj_name.SetFocus;
    result := false;
    exit;
  end;
  if isExistedProject(strPrj_no) then
  begin
    messagebox(self.Handle,'此编号已经存在，请输入新的编号！','数据校对',mb_ok);  
    edtPrj_no.SetFocus;
    result := false;
    exit;
  end;
  result := true;
end;

procedure TProjectNewForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  Clear_Data(self);
  edtPrj_no.Text := GetMaxProjectNo;
end;

procedure TProjectNewForm.btn_okClick(Sender: TObject);
var
  strPrj_no,strPrj_name,strPrj_name_en,strArea_name,strBuilder,
  strBegin_date,strEnd_date,strPrj_grade,strConsigner,strPrj_type:string;
begin
  strPrj_no := stringReplace(trim(edtPrj_no.Text),'''','''''',[rfReplaceAll]);
  strPrj_name := stringReplace(trim(edtPrj_name.Text),'''','''''',[
    rfReplaceAll]);
  strPrj_name_en := stringReplace(trim(edtprj_name_en.Text),'''','''''',[
    rfReplaceAll]);
  strArea_name:= stringReplace(trim(edtArea_name.Text),'''','''''',[rfReplaceAll]);
  strBuilder := stringReplace(trim(edtBuilder.Text),'''','''''',[rfReplaceAll]);
  strBegin_date := datetostr(dtpBegin_date.Date);
  strEnd_date := datetostr(dtpEnd_date.Date);
  strPrj_grade := cboPrj_grade.Text;
  strConsigner := stringReplace(trim(edtconsigner.Text),'''','''''',[
    rfReplaceAll]);
  if cboPrj_type.ItemIndex<1 then
      strPrj_type := '0'
  else
      strPrj_type := IntToStr(cboPrj_type.itemIndex);

  if Check_Data then
    begin
      if Insert_Project(strPrj_no,strPrj_name,strPrj_name_en,strArea_name,strBuilder,
                   strBegin_date,strEnd_date,strPrj_grade,strConsigner,
                   strPrj_type) then
         begin
           //g_ProjectInfo.prj_no := strPrj_no;
           //g_ProjectInfo.prj_name := strPrj_name;
           //g_ProjectInfo.prj_type := strPrj_type;
           g_ProjectInfo.setProjectInfo(strPrj_no,strPrj_name,strPrj_name_en,strPrj_type);
           mainform.SetStatusMessage ;
         end;
      self.Close;
    end;



end;


function TProjectNewForm.Insert_Project(aPrj_no,aPrj_name,aPrj_name_en,
          aArea_name,aBuilder,aBegin_date,aEnd_date,aPrj_grade,aConsigner,aPrj_type:string):boolean;
var
  strInsertSQL: string;
begin
  strInsertSQL := 'INSERT INTO projects '
      +'(prj_no,prj_name,prj_name_en,area_name,builder,begin_date,end_date,prj_grade,consigner,prj_type) '
      +' VALUES('+''''+aPrj_no+''''+','+''''+aPrj_name+''''+','+''''+aPrj_name_en+''''+','+''''+aArea_name
      +''''+','+''''+aBuilder+''''+','+''''+aBegin_date+''''+','+''''+aEnd_date
      +''''+','+''''+aPrj_grade+''''+','+''''+aConsigner+''''+','+''''+aPrj_type+''''+')';
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add(strInsertSQL);
      try
        try
          ExecSQL;
          MessageBox(self.Handle,'新建工程成功！','新建工程',MB_OK+MB_ICONINFORMATION);
          result := true;
        except
          MessageBox(self.Handle,'数据库错误，新建工程失败。','数据库错误',MB_OK+MB_ICONERROR);
          result := false;
        end;
      finally
        close;
      end;
    end;
end;

function TProjectNewForm.isExistedProject(aProjectNo: string): boolean;
begin
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add('select prj_no from projects where prj_no=' + ''''+aProjectNo+'''');
      try
        try
          Open;
          if eof then 
            result:=false
          else
            result:=true;
        except
          result:=true;
        end;
      finally
        close;
      end;
    end;
end;

procedure TProjectNewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TProjectNewForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TProjectNewForm.edtprj_noKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  change_focus(key,self);
end;

procedure TProjectNewForm.dtpBegin_dateKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=VK_RETURN then
    postMessage(self.Handle, wm_NextDlgCtl,0,0);
end;

function TProjectNewForm.GetMaxProjectNo: String;
var
  strPrjNo,strMaxPrjNo:string;
begin
  strMaxPrjNo:='';
  strPrjNo:= '';
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add('select Max(prj_no) as maxPrj_no from projects');
      open;
      while not Eof do
      begin
         strMaxPrjNo:= FieldByName('maxPrj_no').AsString;
         Next;
      end;
    end;
  if strMaxPrjNo='' then
    begin
      Result:= IntToSTr(Currentyear)+'-'+'K'+'-'+'001'+'-'+'01';
    end
  else
    begin
      result := LeftStr(strMaxPrjNo,length(strMaxPrjNo)-2);
    end;      
end;

end.
