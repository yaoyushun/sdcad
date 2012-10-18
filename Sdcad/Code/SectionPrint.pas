unit SectionPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, inifiles, Mask, ToolEdit, CurrEdit, ExtCtrls,
  SUIForm;

type
  TSectionPrintForm = class(TForm)
    suiForm1: TsuiForm;
    lstSection: TListBox;
    btn_Print: TBitBtn;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    gbScale: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtX_scale: TCurrencyEdit;
    edtY_scale: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstSectionClick(Sender: TObject);
  private
    { Private declarations }
    procedure button_status(bHaveRecord:boolean);
    procedure Get_oneRecord(aProjectNo: string;aSec_no: string);
  public
    { Public declarations }
  end;

var
  SectionPrintForm: TSectionPrintForm;

implementation

uses MainDM, public_unit;

{$R *.dfm}

procedure TSectionPrintForm.button_status(bHaveRecord: boolean);
begin
  btn_Print.Enabled := bHaveRecord;
  btn_ok.Enabled := bHaveRecord;
end;

procedure TSectionPrintForm.FormCreate(Sender: TObject);
var
  i: integer;
begin

  self.Left := trunc((screen.Width -self.Width)/2);
  self.Top  := trunc((Screen.Height - self.Height)/2);
  lstSection.Clear;
  
  Clear_Data(self);
  with MainDataModule.qrySection do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT prj_no,sec_no');
      sql.Add(' FROM section ');
      sql.Add(' WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+'''');
      open;
      i:=0;
      lstSection.Tag := 1;
      while not Eof do
        begin
          i:=i+1;
          lstSection.AddItem(FieldByName('sec_no').AsString,nil);  
          Next ;
        end;
      lstSection.Tag := 0;
      close;
    end;
  if i>0 then
  begin    
    //Get_oneRecord(sgList.Row); 
    button_status(true);
  end
  else
    button_status(false);

end;

procedure TSectionPrintForm.btn_PrintClick(Sender: TObject);
var 
  sec_no , strSQL, strTmp, strFileName : string;
  i, drill_count : integer;
  Drl_no_Array: array of string;
  FileList: TStringList;
begin
  FileList := TStringList.Create;
  strFileName:= g_AppInfo.PathOfChartFile + 'section.ini';
  sec_no:= lstSection.Items[lstSection.itemIndex];
  try
    FileList.Add('[图纸信息]');
    FileList.Add('图纸名称='+sec_No+' —'+ sec_No+'’'+'工程地质剖面图');
    FileList.Add('工程编号='+g_ProjectInfo.prj_no);
    FileList.Add('工程名称='+g_ProjectInfo.prj_name);
    //开始加入比例尺
    FileList.Add('[比例尺]');
    FileList.Add('X=' + edtX_scale.Text);
    FileList.Add('Y=' + edtY_scale.Text);
    //开始加入钻孔信息
    FileList.Add('[钻孔]');
    strSQL:= 'SELECT COUNT(drl_no) AS drill_count '
      +'FROM section_drill '
      +'WHERE prj_no = '+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND sec_no = '+''''+sec_no +'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      drill_count:= FieldByName('drill_count').AsInteger;
      close;
    end;
    FileList.Add('个数='+IntToStr(drill_count));
    if drill_count=0 then exit;
    setLength(drl_no_array,drill_count);
    strSQL:= 'SELECT drl_no FROM section_drill '
      + 'WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL+''''
      +' AND sec_no = '+''''+sec_no +'''';
    with MainDataModule.qryPublic do
    begin
      close;
      sql.Clear;
      sql.Add(strSQL);
      open;
      i:=0;
      while not eof do
      begin
        drl_no_array[i]:= FieldByName('drl_no').AsString;
        Inc(i);
        next;
      end;
      close;
    end;
    for i:=0 to drill_count-1 do
    begin
      strSQL:= 'SELECT prj_no,drl_no,drl_elev,drl_x,drl_y,comp_depth'
        +' FROM drills '
        +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL+''''
        +' AND drl_no=' +''''+stringReplace(drl_no_array[i] ,'''','''''',[rfReplaceAll])+'''';
      FileList.Add('[钻孔'+ inttostr(i+1)+']');
      with MainDataModule.qryDrills do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          Open;
          While not eof do
          begin
            FileList.Add('编号='+drl_no_array[i]);
            FileList.Add('孔口标高='+FieldByName('drl_elev').AsString);
            FileList.Add('孔深='+FieldByName('comp_depth').AsString);
            FileList.Add('孔口坐标X='+FieldByName('drl_x').AsString);
            FileList.Add('孔口坐标Y='+FieldByName('drl_y').AsString);
            next;
          end;
          close;
        end;
      //开始加入钻孔的土层信息。
      strSQL:='SELECT prj_no, drl_no, stra_no,'
         +' sub_no, ea_name, stra_depth, stra_category '
         +' FROM stratum '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+stringReplace(drl_no_array[i] ,'''','''''',[rfReplaceAll])+'''' 
         +' ORDER BY stra_depth';
      strTmp := '土层信息=';
      with MainDataModule.qryStratum do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('stra_no').AsString ;
              if (FieldByName('sub_no').AsString) <> '0' then 
                strTmp:= strTmp + '-' + FieldByName('sub_no').AsString;
              strTmp := strTmp + ','
                + FieldByName('stra_depth').AsString + ','
                + FieldByName('ea_name').AsString + ','; 
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);      
      FileList.Add(strTmp);

      //开始加入土样信息
      strTmp:='土样信息=';
      strSQL:='SELECT prj_no, drl_no, s_depth_begin '
         +'FROM earthsample '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+stringReplace(drl_no_array[i] ,'''','''''',[rfReplaceAll])+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('s_depth_begin').AsString +','; 
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);
       
      //开始加入标贯信息
      strTmp:='标贯信息=';
      strSQL:='SELECT prj_no, drl_no, end_depth,real_num1+real_num2+real_num3 as real_num '
         +'FROM SPT '
         +' WHERE prj_no=' +''''+g_ProjectInfo.prj_no_ForSQL +''''
         +' AND drl_no='  +''''+stringReplace(drl_no_array[i] ,'''','''''',[rfReplaceAll])+'''';
      with MainDataModule.qryEarthSample do
        begin
          close;
          sql.Clear;
          sql.Add(strSQL);
          open;
          while not Eof do
            begin
              strTmp := strTmp + FieldByName('end_depth').AsString + ',' 
                + FieldByName('real_num').AsString +',';
              Next ;
            end;
          close;
        end;
      if copy(strTmp,length(strTmp),1)=',' then
        strTmp:= copy(strTmp,1,length(strTmp)-1);
      FileList.Add(strTmp);
    end;
    FileList.SaveToFile(strFileName);    
  finally
    FileList.Free;
  end;
  winexec(pAnsichar(g_AppInfo.CadExeName+' 1,'+strFileName),sw_normal);
end;

procedure TSectionPrintForm.btn_cancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TSectionPrintForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TSectionPrintForm.Get_oneRecord(aProjectNo, aSec_no: string);
begin
  if trim(aProjectNo)='' then exit;
  if trim(aSec_no)='' then exit;
  with MainDataModule.qrySection do
    begin
      close;
      sql.Clear;
      sql.Add('SELECT prj_no, sec_no, x_scale, y_scale from section');
      sql.Add(' where prj_no=' + ''''+stringReplace(aProjectNo ,'''','''''',[rfReplaceAll])+'''');
      sql.Add(' AND sec_no=' +''''+aSec_no+'''');  
      open;
      if not Eof then
      begin
        edtX_scale.Text := FieldByName('X_scale').AsString;
        edtY_scale.Text := FieldByName('Y_scale').AsString;
      end;
      close;
    end;  
end;

procedure TSectionPrintForm.lstSectionClick(Sender: TObject);
var
  sec_no: string;
begin
  sec_no:= lstSection.Items[lstSection.itemIndex];
  if sec_no ='' then
  begin
    button_status(false);
    exit;
  end;
  Get_oneRecord(g_ProjectInfo.prj_no,sec_no);

end;

end.
