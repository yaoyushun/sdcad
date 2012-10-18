unit DrillPosition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, rxToolEdit, rxCurrEdit, ExtCtrls;

type
  TDrillPositionForm = class(TForm)
    OpenDialog1: TOpenDialog;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    btnFileOpen: TBitBtn;
    edtFileName: TEdit;
    edtScale: TCurrencyEdit;
    btn_Print: TBitBtn;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    rbVer: TRadioButton;
    rbHor: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btnFileOpenClick(Sender: TObject);
  private
    { Private declarations }
    procedure Get_buzhitubili(aProjectNo: string);
  public
    { Public declarations }
  end;

var
  DrillPositionForm: TDrillPositionForm;

implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TDrillPositionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TDrillPositionForm.FormCreate(Sender: TObject);
begin
   self.Left := trunc((screen.Width -self.Width)/2);
   self.Top  := trunc((Screen.Height - self.Height)/2);
   Get_buzhitubili(g_ProjectInfo.prj_no);
end;

procedure TDrillPositionForm.Get_buzhitubili(aProjectNo: string);
begin
  if trim(aProjectNo)='' then exit;
  with MainDataModule.qryProjects do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT buzhitubili,buzhitufx FROM projects');
      sql.Add(' WHERE prj_no=' + ''''+stringReplace(aProjectNo ,'''','''''',[rfReplaceAll])+'''');  
      open;
      if not Eof then
      begin
        edtscale.Text := FieldByName('buzhitubili').AsString;
        if FieldByName('buzhitufx').AsBoolean then
          rbHor.Checked := true
        else
          rbVer.Checked := true;
      end;
      close;
    end;  
end;

procedure TDrillPositionForm.btn_okClick(Sender: TObject);
var
  strSQL: string;
begin
  if rbVer.Checked then
    strSQL:= 'UPDATE projects SET buzhitubili=' + edtScale.Text  
      + ',buzhitufx=0'
      + ' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
  else
    strSQL:= 'UPDATE projects SET buzhitubili=' + edtScale.Text  
      + ',buzhitufx=1'
      + ' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''';
  Update_onerecord(MainDataModule.qryProjects,strSQL);

end;

procedure TDrillPositionForm.btn_PrintClick(Sender: TObject);
var
  FileList,DrillList: TStringList;
  strFileName: string;
  i,iDrillCount:integer;
  function GetFieldValue(aFormatStr: string; aFieldValue: string):string;
  begin
    if aFieldValue='' then
    begin
      result:=' ';
      exit;
    end
    else
      result:= FormatFloat(aFormatStr, StrToFloat(aFieldValue));
  end;
begin
  FileList := TStringList.Create;
  DrillList := TStringList.Create;
  strFileName:= g_AppInfo.PathOfChartFile + 'buzhitu.ini';
  try
    FileList.Add('[图纸信息]');
    FileList.Add('图纸名称='+g_ProjectInfo.prj_name+'工程勘察点平面布置图');
    FileList.Add('文件路径='+trim(edtFileName.Text));
    FileList.Add('比例尺=' + edtScale.Text);
    if rbVer.Checked then
      FileList.Add('打印方向=0')
    else
      FileList.Add('打印方向=1');
      
    //开始加入钻孔信息
    with MainDataModule.qryDrills do
      begin
        close;
        sql.Clear;
        //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
        sql.Add('SELECT d.prj_no as prj_no,d.drl_no as drl_no,'
          +'d.d_t_no as d_t_no,t.d_t_name as d_t_name,drl_elev,drl_x,drl_y,'
          +'drl_elev-stable_elev as shuiweibiaogao,comp_depth ');
        sql.Add(' FROM drills as d,drill_type as t ');
        sql.Add(' WHERE d.prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
        sql.Add(' and d.d_t_no = t.d_t_no');
        open;
        iDrillCount:=0;
        while not Eof do
          begin
            Inc(iDrillCount);
            DrillList.Add('[钻孔'+ inttostr(iDrillCount)+']');
            DrillList.Add('编号='+FieldByName('drl_no').AsString);
            DrillList.Add('类型='+FieldByName('d_t_name').AsString);
            DrillList.Add('孔口标高='+GetFieldValue('0.00',FieldByName('drl_elev').AsString));
            DrillList.Add('孔深='+GetFieldValue('0.00',FieldByName('comp_depth').AsString));
            DrillList.Add('水位标高='+GetFieldValue('0.00',FieldByName('shuiweibiaogao').AsString));
            DrillList.Add('孔口坐标X='+FieldByName('drl_x').AsString);
            DrillList.Add('孔口坐标Y='+FieldByName('drl_y').AsString);
            Next ;
          end;
        close;
        FileList.Add('[钻孔]');
        FileList.Add('个数='+ inttostr(iDrillCount));
        if iDrillCount>0 then
          for i:=0 to DrillList.Count-1 do
            FileList.Add(DrillList.Strings[i]);        
          end;
    FileList.SaveToFile(strFileName);    
  finally
    FileList.Free;
    DrillList.Free;
  end;
  winexec(pAnsichar(getCadExcuteName+' '+PrintChart_Buzhitu+','+strFileName),sw_normal);
end;

procedure TDrillPositionForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TDrillPositionForm.btnFileOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    edtFileName.Text := OpenDialog1.FileName;
end;

end.
