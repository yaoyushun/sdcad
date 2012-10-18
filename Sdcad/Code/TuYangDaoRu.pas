unit TuYangDaoRu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids, StrUtils;

type
  TTuYangDaoRuForm = class(TForm)
    OpenDialog1: TOpenDialog;
    pnlAll: TPanel;
    pnlTop: TPanel;
    Label2: TLabel;
    btnLoad: TBitBtn;
    btnCancel: TBitBtn;
    edtFileName: TEdit;
    btnFileOpen: TBitBtn;
    pnlCen: TPanel;
    Splitter1: TSplitter;
    reSrcFile: TRichEdit;
    sgResult: TStringGrid;
    procedure btnLoadClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure sgResultDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnFileOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  
type TFieldRec=record
  Name: string;
  value: string;
  end;
  
var
  TuYangDaoRuForm: TTuYangDaoRuForm;
  
implementation

uses public_unit, MainDM;

{$R *.dfm}

procedure TTuYangDaoRuForm.btnLoadClick(Sender: TObject);
var
  I: Integer;
  Fields_NO  : array[1..4] of TFieldRec;  //试样描述字段,土样编号+钻孔编号+取土深度
  Fields_WL  : array[1..13] of TFieldRec; //物理成果数据字段,含水率+密度+干密度+湿重度等
//yys 20040520 modified
  //Fields_ZJ: array[1..3] of TFieldRec;  //直剪成果数据字段,直剪实验方法+粘聚力+摩擦角
  Fields_ZJ  : array[1..5] of TFieldRec;  //直剪成果数据字段,直剪实验方法+粘聚力+摩擦角
//yys 20040520 modified
  Fields_YALI: TFieldRec;  //压缩试验压力
  Fields_BXL : TFieldRec;  //压缩试验各级压力下的变形量
  Fields_EI  : TFieldRec;  //压缩试验各级压力下的孔隙比
  Fields_AV  : TFieldRec;  //压缩试验各级压力下的压缩系数
  Fields_ES  : TFieldRec;  //压缩试验各级压力下的压缩模量
  Fields_YSXS: array[1..2] of TFieldRec;// 压力100到200下的压缩系数,压缩模量

  Fields_WCX: array[1..3] of TFieldRec; //无侧限抗压强度原状、重塑、灵敏度
  Fields_KF: array[1..7] of TFieldRec;  //颗分成果数据
  KF_Class: array[1..7] of double;      //用来区分颗分级别
  Fields_TU: TFieldRec; //土的名称
  lstTmp, lstSample, lstKF_Class, lstDrillNo: TStringList;
  j,k, iGridRow,iMsg: integer;
  strDrillNo, strTmp: string;
  bExistedDrillNo: boolean;  //判断土样的钻孔号是否存在于钻孔表中。
  strSQLFields,strSQLValues,strSQL:string;
  strFirstStringOfLine: string;  //每一行的第一个逗号前面的字符 比如（NO,1--3,J1）中的NO
  ClickedOK: Boolean;
begin
  iMsg := messagebox(self.Handle ,'如果您要删除数据库中当前工程的土工试验数据,导入新的数据，请按"确定"。'
    +#13#13+'如果要合并数据，请按"否"。'
    +#13#13+'如果不想转导，请按"取消"。','警告信息',MB_YESNOCANCEL);
  if iMsg=IDCANCEL then exit;
  try
    screen.Cursor := crHourGlass;
    

    //开始删除土工试验数据表中当前工程的土样数据
    if iMsg = IDYES then
    begin
      strSQL:= 'DELETE FROM earthsample '
        +' WHERE prj_no=' +''''
        +g_ProjectInfo.prj_no_ForSQL +'''';
      Delete_oneRecord(MainDataModule.qryEarthSample,strSQL);
    end;
    
    lstDrillNo:= TStringList.Create;
    lstDrillNo.Clear;
    //从钻孔表中取出工程所有钻孔号，以便判断文件中的钻孔号是否已经输入到钻孔表，
    //没有的话提示用户输入，然后再转导文件。
    //yys 20040520 modified
    {with MainDataModule.qryDrills do
    begin
      close;
      sql.Clear;
      //sql.Add('select prj_no,prj_name,area_name,builder,begin_date,end_date,consigner from projects');
      sql.Add('SELECT prj_no,drl_no');
      sql.Add(' FROM drills ');
      sql.Add(' WHERE prj_no='+''''
        +stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll])+'''');
      open;
      while not eof do
      begin
        lstDrillNo.Add(FieldByName('drl_no').AsString);
        Next; 
      end;
    end;
    if lstDrillNo.Count =0 then
    begin
      MessageBox(application.Handle,'请您先在钻孔输入窗口输入当前工程的钻孔数据，'
        +#13+'然后再导入土工试验数据。','提示...',MB_OK+MB_ICONINFORMATION);
      exit;
    end;}
    //yys 20040520 modified
    Fields_NO[1].Name := 'drl_no';          //钻孔号
    Fields_NO[2].Name := 's_no';            //土样编号
    Fields_NO[3].Name := 's_depth_begin';   //取土深度始
    Fields_NO[4].Name := 's_depth_end';     //取土深度止
   
    Fields_WL[1].Name := 'aquiferous_rate'; //含水率
    Fields_WL[2].Name := 'wet_density';     //湿密度
    Fields_WL[3].Name := 'dry_density';     //干密度
    Fields_WL[4].Name := 'szdu';            //湿重度
    Fields_WL[5].Name := 'gzdu';            //干重度
    Fields_WL[6].Name := 'soil_proportion'; //土粒比重
    Fields_WL[7].Name := 'saturation';      //饱和度
    Fields_WL[8].Name := 'gap_rate';        //孔隙比
    Fields_WL[9].Name := 'liquid_limit';    //液限
    Fields_WL[10].Name:= 'shape_limit';     //塑限
    Fields_WL[11].Name:= 'shape_index';     //塑性指数
    Fields_WL[12].Name:= 'liquid_index';    //液性指数
    Fields_WL[13].Name:= 'gap_degree';      //孔隙度
    
    Fields_ZJ[1].Name :='shear_type';       //直剪实验方法 
    Fields_ZJ[2].Name :='cohesion';         //直快粘聚力
    Fields_ZJ[3].Name :='friction_angle';   //直快摩擦角
    //yys 20040609 modified
    Fields_ZJ[4].Name :='cohesion_gk';      //固快粘聚力
    Fields_ZJ[5].Name :='friction_gk';      //固快摩擦角    
    //yys 20040609 modified
    Fields_YALI.Name := 'yssy_yali';      //压缩试验压力
    Fields_BXL.Name  := 'yssy_bxl';       //压缩试验各级压力下的变形量
    Fields_EI.Name   := 'yssy_kxb';       //压缩试验各级压力下的孔隙比
    Fields_AV.Name   := 'yssy_ysxs';      //压缩试验各级压力下的压缩系数
    Fields_ES.Name   := 'yssy_ysml';      //压缩试验各级压力下的压缩模量
    Fields_YSXS[1].Name := 'zip_coef';    // 压力100到200下的压缩系数
    Fields_YSXS[2].Name := 'zip_modulus'; // 压力100到200下的压缩模量

    Fields_WCX[1].Name := 'wcx_yuanz';      //无侧限抗压强度原状
    Fields_WCX[2].Name := 'wcx_chsu';       //重塑
    Fields_WCX[3].Name := 'wcx_lmd';        //灵敏度

    Fields_KF[1].Name := 'li';              //砾(%) (粒径5.0~2.0)
    Fields_KF[2].Name := 'sand_big';        //砂粒粗(%) (粒径2.0~0.5)
    Fields_KF[3].Name := 'sand_middle';     //砂粒中(%) (粒径0.5~0.25)
    Fields_KF[4].Name := 'sand_small';      //砂粒细(%) (粒径0.25~0.075)
    Fields_KF[5].Name := 'powder_big';      //粉粒粗(%) (粒径0.075~0.05)
    Fields_KF[6].Name := 'powder_small';    //粉粒细(%) (粒径0.05~0.005)
    Fields_KF[7].Name := 'clay_grain';      //粘粒(%) (粒径<0.005)
    KF_Class[1]:= 2;
    KF_Class[2]:= 0.5;
    KF_Class[3]:= 0.25;
    KF_Class[4]:= 0.075; //有时这个值可能是0.100,所以这个KF_Class后面不用了。yys 2005/06/10
    KF_Class[5]:= 0.05;
    KF_Class[6]:= 0.005;
    KF_Class[7]:= 0;
    Fields_TU.Name := 'ea_name';
    
    lstTmp:= TStringList.Create;
    lstSample:= TStringList.Create;
    lstKF_Class:= TStringList.Create;
    iGridRow := 1;
    sgResult.RowCount:= 2;
    for i:=1 to sgResult.ColCount-1 do
      for j:=1 to sgResult.RowCount-1 do
        sgResult.Cells[i,j]:= '';
    //取得颗分级数（如：20，10，5，2），最后加0,实际上代表小于最小的一级(如最后一级是0.005,则0代表<0.005的那一级)
    DivideString(reSrcFile.Lines.Strings[1],',',lstKF_Class);
    for i:=0 to 1 do
      lstKF_Class.Delete(0);
    lstKF_Class.Add('0');

//******************开始取得毎一个土样的数据,并插入数据库********************
    for i:= 2 to reSrcFile.Lines.Count-1 do
    try
      DivideString(reSrcFile.Lines.Strings[i],',',lstTmp);
      if lstTmp.Count > 0 then
        strFirstStringOfLine := lstTmp.Strings[0]
      else
        begin
          strFirstStringOfLine := '';
          continue;
        end;
      //********试样描述,NO,+序号+土样编号+钻孔编号+取土深度
      if strFirstStringOfLine='NO' then
      begin
        strTmp:= lstTmp.Strings[3];
        if strTmp<>'' then   //因为在导入的文件中，当多个土样的钻孔号相同时，
        begin                           //那么只有第一个土样的钻孔号有值，其它土样的钻孔号都为空.
          //yys 20040520 modified
          {bExistedDrillNo:= false;
          for j:=0 to lstDrillNo.Count-1 do
            if strTmp=lstDrillNo.Strings[j] then
              bExistedDrillNo:= true;
          if not bExistedDrillNo then  //如果土样的钻孔号在钻孔表中不存在，要用户先输入。
          begin
            MessageBox(application.Handle,pansichar('请您先在钻孔输入窗口输入当前土样的钻孔号 '''+strTmp+''' ，'
              +#13+'然后再导入土工试验数据。'),'提示...',MB_OK+MB_ICONINFORMATION);
            DrillsForm:=TDrillsForm.Create(Application);
            Clear_Data(DrillsForm);
            DrillsForm.Button_status(3,true);
            DrillsForm.DrawDrill;
            DrillsForm.edtDrl_no.Text := strTmp;
            DrillsForm.ShowModal;
            //exit;
          end;}
          //yys 20040520 modified
          strDrillNo := '';
          strDrillNo:=strTmp;
          ClickedOK := true;

          ClickedOK := InputQuery('新孔号', '', strDrillNo);

        end;
        if strDrillNo='' then ClickedOK := false;

        Fields_NO[1].value := strDrillNo;
        if lstTmp.Strings[2]<>'' then
        begin
          DivideStringNoEmpty(lstTmp.Strings[2],'-',lstSample);
          for j:=1 to lstSample.Count-1 do
            Fields_NO[2].value := Fields_NO[2].value + lstSample.Strings[j]+'-';
          Fields_NO[2].value:= copy(Fields_NO[2].value,1,length(Fields_NO[2].value)-1);
          if lstTmp.Strings[4]<>'' then
          begin
            DivideString(lstTmp.Strings[4],'-',lstSample);
            Fields_NO[3].value := lstSample.Strings[0];
            Fields_NO[4].value := lstSample.Strings[1];
          end;
        end;
        continue;
      end;
      //********第二行物理成果数据,WL,+含水率+密度+干密度+湿重度等
      try
        if strFirstStringOfLine='WL' then
          for j:= 1 to High(Fields_WL) do
            Fields_WL[j].value := lstTmp.Strings[j];
      except
        continue;
      end;
      //********第三行颗分成果数据
      try
        if strFirstStringOfLine='KF' then
//yys 2005/06/10 修改，原因是导入的文件有时颗分级别不是固定的
          //for j:= 6 to lstTmp.Count-1 do
          //   for k:= low(KF_Class) to High(KF_Class) do
          //   begin
          //     if samevalue(StrToFloat(lstKF_Class.Strings[j-6]), KF_Class[k]) then
          //     begin
          //       Fields_KF[k].value := lstTmp.Strings[j];
          //       break;
          //     end;
          //   end;
          for j:= 11 to lstTmp.Count-1 do
              Fields_KF[j-10].Value := lstTmp.Strings[j];
//yys 2005/06/10
      except
        continue;
      end;
      //********第四行直剪成果数据,ZJ,+直剪实验方法+直剪粘聚力+ 直剪摩擦角
      try
        if strFirstStringOfLine='ZJ' then
        begin
         Fields_ZJ[1].value := lstTmp.Strings[1];
         //yys 20040520 modified
         //Fields_ZJ[2].value := lstTmp.Strings[10];
         //Fields_ZJ[3].value := lstTmp.Strings[11];
         if Fields_ZJ[1].value = '快剪' then
         begin
           Fields_ZJ[2].value := lstTmp.Strings[10];
           Fields_ZJ[3].value := lstTmp.Strings[11];
         end
         else if Fields_ZJ[1].value = '固快' then
         begin
           Fields_ZJ[4].value := lstTmp.Strings[10];
           Fields_ZJ[5].value := lstTmp.Strings[11];
         end;
         //yys 20040520 modified
        end;
      except
        continue;
      end;

      //********土的名称颜色
      try
        if strFirstStringOfLine='TU' then
          Fields_TU.value := lstTmp.Strings[1];
      except
        continue;
      end;
      //********无侧限抗压强度原状、重塑、灵敏度
      try
        if strFirstStringOfLine='WCX' then
        for j:= 1 to High(Fields_WCX) do
          Fields_WCX[j].value := lstTmp.Strings[j];
      except
        continue;
      end;

      //********压缩试验各级压力
      try
        if strFirstStringOfLine='YALI' then
        begin
          for j := 2 to lstTmp.Count  - 2 do    // Iterate
          begin
            if trim(lstTmp.Strings[j])<>'' then
              Fields_YALI.value := Fields_YALI.value + trim(lstTmp.Strings[j])
                + ',';
          end;    // for
            if trim(lstTmp.Strings[lstTmp.Count  - 1])<>'' then
              Fields_YALI.value := Fields_YALI.value + trim(lstTmp.Strings[
                lstTmp.Count  - 1])
            else if rightStr(Fields_YALI.value,1)=',' then
              Fields_YALI.value := LeftStr(Fields_YALI.value,Length(Fields_YALI.value)-1);
        end;
      except
        continue;
      end;

      //********压缩试验各级压力下的变形量
      try
        if strFirstStringOfLine='BXL' then
        begin
          for j := 1 to lstTmp.Count  - 2 do    // Iterate
          begin
            if trim(lstTmp.Strings[j])<>'' then
              Fields_BXL.value := Fields_BXL.value + trim(lstTmp.Strings[j])
                + ',';
          end;    // for
            if trim(lstTmp.Strings[lstTmp.Count  - 1])<>'' then
              Fields_BXL.value := Fields_BXL.value + trim(lstTmp.Strings[
                lstTmp.Count  - 1])
            else if rightStr(Fields_BXL.value,1)=',' then
              Fields_BXL.value := LeftStr(Fields_BXL.value,Length(Fields_BXL.value)-1);
        end;
      except
        continue;
      end;

      //********压缩试验各级压力下的孔隙比
      try
        if strFirstStringOfLine='EI' then
        begin
          for j := 1 to lstTmp.Count  - 2 do    // Iterate
          begin
            if trim(lstTmp.Strings[j])<>'' then
              Fields_EI.value := Fields_EI.value + trim(lstTmp.Strings[j])
                + ',';
          end;    // for
            if trim(lstTmp.Strings[lstTmp.Count  - 1])<>'' then
              Fields_EI.value := Fields_EI.value + trim(lstTmp.Strings[
                lstTmp.Count  - 1])
            else if rightStr(Fields_EI.value,1)=',' then
              Fields_EI.value := LeftStr(Fields_EI.value,Length(Fields_EI.value)-1);
        end;
      except
        continue;
      end;

      //********压缩试验各级压力下的压缩系数
      try
        if strFirstStringOfLine='AV' then
        begin
          for j := 1 to lstTmp.Count  - 2 do    // Iterate
          begin
            if trim(lstTmp.Strings[j])<>'' then
              Fields_AV.value := Fields_AV.value + trim(lstTmp.Strings[j])
                + ',';
          end;    // for
            if trim(lstTmp.Strings[lstTmp.Count  - 1])<>'' then
              Fields_AV.value := Fields_AV.value + trim(lstTmp.Strings[
                lstTmp.Count  - 1])
            else if rightStr(Fields_AV.value,1)=',' then
              Fields_AV.value := LeftStr(Fields_AV.value,Length(Fields_AV.value)-1);
        end;
      except
        continue;
      end;

      //********压缩试验各级压力下的压缩模量
      try
        if strFirstStringOfLine='ES' then
        begin
          for j := 1 to lstTmp.Count  - 2 do    // Iterate
          begin
            if trim(lstTmp.Strings[j])<>'' then
              Fields_ES.value := Fields_ES.value + trim(lstTmp.Strings[j])
                + ',';
          end;    // for
            if trim(lstTmp.Strings[lstTmp.Count  - 1])<>'' then
              Fields_ES.value := Fields_ES.value + trim(lstTmp.Strings[lstTmp.Count  - 1])
            else if rightStr(Fields_ES.value,1)=',' then
              Fields_ES.value := LeftStr(Fields_ES.value,Length(Fields_ES.value)-1);
        end;
      except
        continue;
      end;

      //********压力100到200下的压缩系数, 压缩模量
      try
        if strFirstStringOfLine='YSXS' then
        begin
          Fields_YSXS[1].value := lstTmp.Strings[4]; //压缩系数
          Fields_YSXS[2].value := lstTmp.Strings[5]; //压缩模量
        end;
      except
        continue;
      end;
      //********压缩次固结系数, 这一行的数据不用，直接把取得的数据保存，并清空所有FieldRec的value
      if strFirstStringOfLine='CGJ' then
        begin
          if ClickedOK then
          begin
              strSQLFields:= '';
              strSQLValues:= '';
              if (Fields_NO[1].value = '') or (Fields_NO[2].value = '')
                or (Fields_NO[3].value = '') or (Fields_NO[4].value = '') then
                continue;

              for j:=low(Fields_NO) to high(Fields_NO) do
              begin
                strSQLFields:= strSQLFields + Fields_NO[j].Name + ',';
                strSQLValues:= strSQLValues + '''' + Fields_NO[j].value + '''' + ',';
              end;
              for j:=low(Fields_WL) to high(Fields_WL) do
                if Fields_WL[j].value <>'' then
                begin
                  strSQLFields:= strSQLFields + Fields_WL[j].Name + ',';
                  strSQLValues:= strSQLValues + '''' + Fields_WL[j].value + '''' + ',';
                end;
              //yys 20040520 modified
              {if Fields_ZJ[1].value<>'' then
              begin
                strSQLFields:= strSQLFields + Fields_ZJ[1].Name + ',';
                if Fields_ZJ[1].value='快剪' then
                  strSQLValues:= strSQLValues + '''' + '0' + ''''+ ','
                else if Fields_ZJ[1].value='固快' then
                  strSQLValues:= strSQLValues + '''' + '1' + ''''+ ','
                else if Fields_ZJ[1].value='固慢' then
                  strSQLValues:= strSQLValues + '''' + '2' + ''''+ ','
                else
                  strSQLValues:= strSQLValues + '''' + '3' + ''''+ ','
              end;}
              //yys 20040520 modified
              for j:=low(Fields_ZJ)+1 to high(Fields_ZJ) do
                if Fields_ZJ[j].value <>'' then
                begin
                  strSQLFields:= strSQLFields + Fields_ZJ[j].Name + ',';
                  strSQLValues:= strSQLValues + '''' + Fields_ZJ[j].value + '''' + ',';
                end;

              strSQLFields:= strSQLFields + Fields_YALI.Name + ',';
              strSQLValues:= strSQLValues + '''' + Fields_YALI.value + '''' +',';

              strSQLFields:= strSQLFields + Fields_BXL.Name + ',';
              strSQLValues:= strSQLValues + '''' + Fields_BXL.value + '''' +',';

              strSQLFields:= strSQLFields + Fields_EI.Name + ',';
              strSQLValues:= strSQLValues + '''' + Fields_EI.value + '''' +',';

              strSQLFields:= strSQLFields + Fields_AV.Name + ',';
              strSQLValues:= strSQLValues + '''' + Fields_AV.value + '''' +',';

              strSQLFields:= strSQLFields + Fields_ES.Name + ',';
              strSQLValues:= strSQLValues + '''' + Fields_ES.value + '''' +',';

              for j:=low(Fields_YSXS) to high(Fields_YSXS) do
                if Fields_YSXS[j].value <>'' then
                begin
                  strSQLFields:= strSQLFields + Fields_YSXS[j].Name + ',';
                  strSQLValues:= strSQLValues + '''' + Fields_YSXS[j].value + '''' + ',';
                end;
              for j:= low(Fields_WCX) to high(Fields_WCX) do
                if Fields_WCX[j].value <>'' then
                begin
                  strSQLFields:= strSQLFields + Fields_WCX[j].Name + ',';
                  strSQLValues:= strSQLValues + '''' + Fields_WCX[j].value + '''' + ',';
                end;
              for j:= low(Fields_KF) to high(Fields_KF) do
                if Fields_KF[j].value <>'' then
                begin
                  strSQLFields:= strSQLFields + Fields_KF[j].Name + ',';
                  strSQLValues:= strSQLValues + '''' + Fields_KF[j].value + '''' + ',';
                end;
              if Fields_TU.value <> '' then
              begin

                strSQLFields:= strSQLFields + Fields_TU.Name + ',';
                strSQLValues:= strSQLValues + '''' + Fields_TU.value + '''' + ',';
              end;
              //加入参与统计字段，值为1，表示参与统计
              strSQLFields:= strSQLFields + 'if_statistic';
              strSQLValues:= strSQLValues + '1';
              //加入工程编号
              strSQLFields:='prj_no,' + strSQLFields;
              strSQLValues:=''''+stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll]) +''''+',' + strSQLValues;

              strSQL := 'INSERT INTO earthsample ('+strSQLFields+') VALUES(' +strSQLValues+')';
              if Insert_oneRecord(MainDataModule.qryEarthSample,strSQL) then
              begin
                //开始给sgResult的一行赋值
                Inc(iGridRow);
                sgResult.RowCount := iGridRow;
                sgResult.Cells[0, iGridRow-1]:= IntToStr(iGridRow-1);
                for j:=low(Fields_NO) to high(Fields_NO) do
                  sgResult.Cells[j, iGridRow-1]:= Fields_NO[j].value;
                k:= high(Fields_NO)- low(Fields_NO) + 2; //k表示下一字段在sgResult中是第几列
                sgResult.Cells[k, iGridRow-1]:= Fields_TU.value;

                for j:=low(Fields_WL) to high(Fields_WL) do
                  sgResult.Cells[j+k, iGridRow-1]:= Fields_WL[j].value;
                k:= k + high(Fields_WL)- low(Fields_WL) + 1;
                for j:=low(Fields_ZJ) to high(Fields_ZJ) do
                  sgResult.Cells[j+k, iGridRow-1]:= Fields_ZJ[j].value;
                k:= k + high(Fields_ZJ)- low(Fields_ZJ) + 1;
                for j:= low(Fields_YSXS) to high(Fields_YSXS) do
                  sgResult.Cells[j+k, iGridRow-1]:= Fields_YSXS[j].value;
                k:= k + high(Fields_YSXS)- low(Fields_YSXS) + 1;
                for j:= low(Fields_WCX) to high(Fields_WCX) do
                  sgResult.Cells[j+k, iGridRow-1]:= Fields_WCX[j].value;
                k:= k + high(Fields_WCX)- low(Fields_WCX) + 1;
                for j:= low(Fields_KF) to high(Fields_KF) do
                  sgResult.Cells[j+k, iGridRow-1]:= Fields_KF[j].value;
              end;
          end;
          //开始清空所有FieldRec的value值,准备保存下一土样的信息
          for j:=low(Fields_NO) to high(Fields_NO) do
            Fields_NO[j].value := '';
          for j:=low(Fields_WL) to high(Fields_WL) do
            Fields_WL[j].value := '';
          for j:=low(Fields_ZJ) to high(Fields_ZJ) do
            Fields_ZJ[j].value := '';
          Fields_YALI.value := '';
          Fields_BXL.value  := '';
          Fields_EI.value   := '';
          Fields_AV.value   := '';
          Fields_ES.value   := '';
          for j:=low(Fields_YSXS) to high(Fields_YSXS) do
            Fields_YSXS[j].value := '';
          for j:= low(Fields_WCX) to high(Fields_WCX) do
            Fields_WCX[j].value := '';
          for j:= low(Fields_KF) to high(Fields_KF) do
            Fields_KF[j].value := '';
          Fields_TU.value := '';
        end;
        continue;
    except
    end;
  finally
    lstTmp.Free;
    lstSample.Free;
    lstKF_Class.Free;
    lstDrillNo.Free;
    screen.Cursor := crDefault;
  end;
  
end;

procedure TTuYangDaoRuForm.btnCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TTuYangDaoRuForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= CaFree;
end;

procedure TTuYangDaoRuForm.FormCreate(Sender: TObject);
begin
   self.Left := trunc((screen.Width -self.Width)/2);
   self.Top  := trunc((Screen.Height - self.Height)/2);
   sgResult.FixedCols := 3;
   sgResult.ColCount :=36;
   sgResult.ColWidths[0]:= 30;
   sgResult.Cells[1,0]:= '钻孔号';
   sgResult.ColWidths[1]:= 120;  
   sgResult.Cells[2,0]:= '土样编号';
   sgResult.Cells[3,0]:= '取土深度始';
   sgResult.Cells[4,0]:= '取土深度止';
   sgResult.Cells[5,0]:= '岩土名称';
   sgResult.Cells[6,0]:= '含水率';
   sgResult.Cells[7,0]:= '湿密度';
   sgResult.Cells[8,0]:= '干密度';
   sgResult.Cells[9,0]:= '湿重度';
   sgResult.Cells[10,0]:= '干重度';
   sgResult.Cells[11,0]:= '土粒比重';
   sgResult.Cells[12,0]:= '饱和度';
   sgResult.Cells[13,0]:= '孔隙比';
   sgResult.Cells[14,0]:= '液限';
   sgResult.Cells[15,0]:= '塑限';
   sgResult.Cells[16,0]:= '塑性指数';
   sgResult.Cells[17,0]:= '液性指数';
   sgResult.Cells[18,0]:= '孔隙度';
   sgResult.Cells[19,0]:= '直剪实验方法';
   sgResult.ColWidths[19]:= sgResult.ColWidths[18]+10;
//yys 20040609 modified
   //sgResult.Cells[20,0]:= '直剪粘聚力';
   //sgResult.Cells[21,0]:= '直剪摩擦角';
   sgResult.Cells[20,0]:= '直快粘聚力';
   sgResult.Cells[21,0]:= '直快摩擦角';
   sgResult.Cells[22,0]:= '固快粘聚力';
   sgResult.Cells[23,0]:= '固快摩擦角';   

   {sgResult.Cells[22,0]:= '压缩系数';
   sgResult.Cells[23,0]:= '压缩模量';
   sgResult.Cells[24,0]:= '无侧限原状';
   sgResult.Cells[25,0]:= '无侧限重塑';
   sgResult.Cells[26,0]:= '无侧限灵敏度';
   sgResult.ColWidths[26]:= sgResult.ColWidths[26]+10; 
   sgResult.Cells[27,0]:= '颗粒2.0~0.5';
   sgResult.ColWidths[27]:= sgResult.ColWidths[27]+10;
   sgResult.Cells[28,0]:= '颗粒0.5~0.25';
   sgResult.ColWidths[28]:= sgResult.ColWidths[28]+15;
   sgResult.Cells[29,0]:= '颗粒0.25~0.075';
   sgResult.ColWidths[29]:= sgResult.ColWidths[29]+25;
   sgResult.Cells[30,0]:= '颗粒0.075~0.05';
   sgResult.ColWidths[30]:= sgResult.ColWidths[30]+25;
   sgResult.Cells[31,0]:= '颗粒0.05~0.005';
   sgResult.ColWidths[31]:= sgResult.ColWidths[31]+25;
   sgResult.Cells[32,0]:= '颗粒<0.005';}
   sgResult.Cells[24,0]:= '压缩系数';
   sgResult.Cells[25,0]:= '压缩模量';
   sgResult.Cells[26,0]:= '无侧限原状';
   sgResult.Cells[27,0]:= '无侧限重塑';
   sgResult.Cells[28,0]:= '无侧限灵敏度';
   sgResult.ColWidths[28]:= sgResult.ColWidths[28]+10; 
   sgResult.Cells[29,0]:= '颗粒2.0~0.5';
   sgResult.ColWidths[29]:= sgResult.ColWidths[29]+10;
   sgResult.Cells[30,0]:= '颗粒0.5~0.25';
   sgResult.ColWidths[30]:= sgResult.ColWidths[30]+15;
   sgResult.Cells[31,0]:= '颗粒0.25~0.075';
   sgResult.ColWidths[31]:= sgResult.ColWidths[31]+25;
   sgResult.Cells[32,0]:= '颗粒0.075~0.05';
   sgResult.ColWidths[32]:= sgResult.ColWidths[32]+25;
   sgResult.Cells[33,0]:= '颗粒0.05~0.005';
   sgResult.ColWidths[33]:= sgResult.ColWidths[33]+25;
   sgResult.Cells[34,0]:= '颗粒<0.005';  
   sgResult.Cells[35,0]:= '粘 粒';
   setLabelsTransparent(self);  
//yys 20040609 modified
end;

procedure TTuYangDaoRuForm.sgResultDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TTuYangDaoRuForm.btnFileOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtFileName.Text := OpenDialog1.FileName;
    reSrcFile.Lines.Clear;
    resrcFile.Lines.LoadFromFile(OpenDialog1.FileName);
    if reSrcFile.Lines.Count >0 then
    begin
      btnLoad.Enabled := true;
      btnLoad.SetFocus;
    end;
  end;
end;

end.
