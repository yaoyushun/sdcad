unit TuYangDaoRuXLS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, ExtCtrls, Buttons, ComObj, Mask,
  rxToolEdit, rxCurrEdit;

type
  TTuYangDaoRuXLSForm = class(TForm)
    pnlAll: TPanel;
    pnlTop: TPanel;
    Label2: TLabel;
    btnLoad: TBitBtn;
    btnCancel: TBitBtn;
    edtFileName: TEdit;
    btnFileOpen: TBitBtn;
    pnlCen: TPanel;
    sgResult: TStringGrid;
    OpenDialog1: TOpenDialog;
    lbl1: TLabel;
    edtXiShu: TCurrencyEdit;
    procedure btnFileOpenClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure sgResultDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnLoadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TFieldRec=record
  FieldName: string;
  ZhongWen: string;
  end;

var
  TuYangDaoRuXLSForm: TTuYangDaoRuXLSForm;
  Fields_WL  : array[1..32] of TFieldRec;
implementation

uses public_unit, MainDM, SdCadMath;

{$R *.dfm}

procedure TTuYangDaoRuXLSForm.btnFileOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    edtFileName.Text := OpenDialog1.FileName;

    if edtFileName.Text<>'' then
    begin
      btnLoad.Enabled := true;
      btnLoad.SetFocus;
    end;
  end;
end;

procedure TTuYangDaoRuXLSForm.btnCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TTuYangDaoRuXLSForm.sgResultDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow=0 then
    AlignGridCell(Sender,ACol,ARow,Rect,taCenter)
  else
    AlignGridCell(Sender,ACol,ARow,Rect,taRightJustify);
end;

procedure TTuYangDaoRuXLSForm.btnLoadClick(Sender: TObject);
  type T_LeftRight = record
      LelfStr : string;  //左边的字符串
      RightStr   : string;  //右边的字符串
  end;
var
  ExcelApp: Variant;
  Sheet: Variant;
  SFileName, strSQL, strTemp:string;
  strDrillNo_S_No, strShenDu,strDrillNo:string;
  pTmpBianHao, pTmpShenDu : T_LeftRight;
  J, iMsg, i, iField:integer;
  lstTmp, lstSample : TStringList;

  //从字符串中取到钻孔编号和土样编号 str='JZ-31--29' 返回钻孔编号 JZ-31和土样编号 29
  //                             如果str='146-13'    返回钻孔编号 146  和土样编号 13
  procedure GetLeftRightStr(str,separate:string;var pBianHao: T_LeftRight);
  var
    position:integer;
  begin
      position:=PosRightEx(separate,str);
      if position=0 then position:=length(str)+1;
      pBianHao.LelfStr  := copy(str,1,position-1);
      pBianHao.RightStr := copy(str,position+length(separate),length(str)+1);
  end;
  function GetValueFromCell(pCellValue: Variant):Variant;
  begin
    if Trim(VarToStr(pCellValue))<>'' then
      Result := pCellValue
    else
      Result := null;
  end;
  //从重度计算出密度 ,密度=重度/9.8 ,保留两位小数
  function GetDensityValueFromCell(pCellValue: Variant):Variant;
  begin
    if Trim(VarToStr(pCellValue))<>'' then
      Result := FormatFloat('0.00',StrToFloat(VarToStr(pCellValue))/edtXishu.Value)
    else
      Result := null;
  end;
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
    TRY
      ExcelApp := GetActiveOleObject('Excel.Application');
    except
      ExcelApp := CreateOleObject( 'Excel.Application' );
    end;
    SFileName := edtFileName.Text;
    ExcelApp.WorkBooks.Open(SFileName);
    Sheet := ExcelApp.WorkBooks[ExcelApp.WorkBooks.Count].WorkSheets[1];

    with MainDataModule.qryEarthSample do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM earthsample WHERE prj_no='+''''+g_ProjectInfo.prj_no_ForSQL +'''');
      Open;

      J:=9;  //从第9行开始//若土样编号为空，则结束

      strDrillNo := '';
      iMsg := IDCANCEL;//每个钻孔都要给用户选择是不是要导入这个钻孔的土样数据
      while (Sheet.Cells[J,2].text<>'') and (sheet.Cells[J,3].text<>'') DO
      BEGIN

        strDrillNo_S_No := Sheet.Cells[J,2].Value;
        if Pos('--',strDrillNo_S_No)>1 then
          GetLeftRightStr(strDrillNo_S_No,'--',PTmpBianHao)
        else
          GetLeftRightStr(strDrillNo_S_No,'-',PTmpBianHao);
        //每出现一个新钻孔号，当提示用户选择时用户选择是否导入这个钻孔的特殊样数据选择了否，或者是第一次出现钻孔
        if strDrillNo<>pTmpBianHao.LelfStr then
        begin
          strDrillNo := pTmpBianHao.LelfStr;
          iMsg := messagebox(self.Handle ,PAnsiChar('您要导入钻孔'+ strDrillNo+'的土样数据吗？'),'提示信息',MB_YESNO);

          if iMsg=IDNO then
          begin
            J := J + 1;
            Continue;
          end;

        end
        else if iMsg = IDNO then
          begin
            J := J + 1;
            Continue;
          end;


        Append;
        FieldByName('prj_no').Value := stringReplace(g_ProjectInfo.prj_no ,'''','''''',[rfReplaceAll]);


        FieldByName('drl_no').Value := PTmpBianHao.LelfStr;
        FieldByName('s_no').Value := PTmpBianHao.RightStr;

        GetLeftRightStr(Sheet.Cells[J,3].Value, '-', pTmpShenDu);
        FieldByName('s_depth_begin').Value := pTmpShenDu.LelfStr;
        FieldByName('s_depth_end').Value := pTmpShenDu.RightStr;

        FieldByName('li').Value := GetValueFromCell(Sheet.Cells[J,5].Value);              //砾(%) (粒径5.0~2.0)
        FieldByName('sand_big').Value := GetValueFromCell(Sheet.Cells[J,6].Value);        //砂粒粗(%) (粒径2.0~0.5)
        FieldByName('sand_middle').Value := GetValueFromCell(Sheet.Cells[J,7].Value);     //砂粒中(%) (粒径0.5~0.25)
        FieldByName('sand_small').Value := GetValueFromCell(Sheet.Cells[J,8].Value);      //砂粒细(%) (粒径0.25~0.075)
        FieldByName('powder_big').Value := GetValueFromCell(Sheet.Cells[J,9].Value);      //粉粒粗(%) (粒径0.075~0.05)
        FieldByName('powder_small').Value := GetValueFromCell(Sheet.Cells[J,10].Value);    //粉粒细(%) (粒径0.05~0.005)
        FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value);      //粘粒(%) (粒径<0.005)

        FieldByName('aquiferous_rate').Value := GetValueFromCell(Sheet.Cells[J,12].Value); //含水率
        FieldByName('soil_proportion').Value := GetValueFromCell(Sheet.Cells[J,13].Value); //土粒比重

        FieldByName('szdu').Value := GetValueFromCell(Sheet.Cells[J,14].Value);            //湿重度
        FieldByName('gzdu').Value := GetValueFromCell(Sheet.Cells[J,15].Value);            //干重度
        FieldByName('wet_density').Value := GetDensityValueFromCell(Sheet.Cells[J,14].Value);     //湿密度
        FieldByName('dry_density').Value := GetDensityValueFromCell(Sheet.Cells[J,15].Value);     //干密度

        FieldByName('gap_rate').Value := GetValueFromCell(Sheet.Cells[J,16].Value);        //孔隙比
        if isFloat(VarToStr(FieldByName('gap_rate').Value)) then  //计算孔隙度
           FieldByName('Gap_degree').Value := FormatFloat('0',GetKongXiDu(StrToFloat(VarToStr(FieldByName('gap_rate').Value))));
        FieldByName('saturation').Value := GetValueFromCell(Sheet.Cells[J,17].Value);      //饱和度

        FieldByName('liquid_limit').Value := GetValueFromCell(Sheet.Cells[J,18].Value);    //液限
        FieldByName('shape_limit').Value := GetValueFromCell(Sheet.Cells[J,19].Value);     //塑限
        FieldByName('shape_index').Value := GetValueFromCell(Sheet.Cells[J,20].Value);     //塑性指数
        FieldByName('liquid_index').Value := GetValueFromCell(Sheet.Cells[J,21].Value);    //液性指数
        //FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'gap_degree';      //孔隙度
        FieldByName('ea_name').Value := GetValueFromCell(Sheet.Cells[J,22].Value);      //土样分类名

        if VarToStr(Sheet.Cells[J,23].Value)='q' then
        begin
          FieldByName('shear_type').Value := 0;       //直剪实验方法,q表示快剪0，cq是固快1，uu是特殊样中的三轴
          FieldByName('cohesion').Value := GetValueFromCell(Sheet.Cells[J,24].Value);         //直快粘聚力
          FieldByName('friction_angle').Value := GetValueFromCell(Sheet.Cells[J,25].Value);   //直快摩擦角
        end
        else if VarToStr(Sheet.Cells[J,23].Value)='cq' then
        begin
          FieldByName('shear_type').Value := 1;       //直剪实验方法,q表示快剪0，cq是固快1，uu是特殊样中的三轴
          FieldByName('cohesion_gk').Value := GetValueFromCell(Sheet.Cells[J,24].Value);   //固快粘聚力
          FieldByName('friction_gk').Value := GetValueFromCell(Sheet.Cells[J,25].Value);   //固快摩擦角
        end;
        FieldByName('zip_coef').Value := GetValueFromCell(Sheet.Cells[J,27].Value);    // 压力100到200下的压缩系数
        FieldByName('zip_modulus').Value := GetValueFromCell(Sheet.Cells[J,28].Value); // 压力100到200下的压缩模量

       // FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'yssy_yali';      //压缩试验压力
       // FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'yssy_bxl';       //压缩试验各级压力下的变形量
       // FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'yssy_kxb';       //压缩试验各级压力下的孔隙比
       // FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'yssy_ysxs';      //压缩试验各级压力下的压缩系数
       // FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'yssy_ysml';      //压缩试验各级压力下的压缩模量


        //FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'wcx_yuanz';      //无侧限抗压强度原状
        //FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'wcx_chsu';       //重塑
        //FieldByName('clay_grain').Value := GetValueFromCell(Sheet.Cells[J,11].Value)'wcx_lmd';        //灵敏度


//        if FieldByName('szsy_syff').AsString ='UU' then
//        begin
//          FieldByName('szsy_zyl_njl_uu').Value := GetValueFromCell(Sheet.Cells[J,27].Value);
//          FieldByName('szsy_zyl_nmcj_uu').Value := GetValueFromCell(Sheet.Cells[J,28].Value);
//        end
//        else
//        begin
//          FieldByName('szsy_zyl_njl_cu').Value := GetValueFromCell(Sheet.Cells[J,27].Value);
//          FieldByName('szsy_zyl_nmcj_cu').Value := GetValueFromCell(Sheet.Cells[J,28].Value);
//        end;
//        FieldByName('szsy_yxyl_njl').Value := GetValueFromCell(Sheet.Cells[J,29].Value);
//        FieldByName('szsy_yxyl_nmcj').Value := GetValueFromCell(Sheet.Cells[J,30].Value);

          //Caption := FormatFloat('0.00000000',strtofloat('3.2E-7'));
          //Caption := FloatToStrF(strtofloat('3.2E-7'),ffNumber,18,8); //科学技术法在EXCEL的XLS文件中读不出来
//        if Trim(VarToStr(Sheet.Cells[J,31].Value))<>'' then
//        begin
//          strTemp := Trim(VarToStr(Sheet.Cells[J,31].Value));
//          FieldByName('stxs_kv').Value := StrToFloat(strTemp)
//        end
//        else
//          FieldByName('stxs_kv').Value := null;
//
//        if Trim(VarToStr(Sheet.Cells[J,32].Value))<>'' then
//        begin
//          strTemp := Trim(VarToStr(Sheet.Cells[J,32].Value));
//          FieldByName('stxs_kh').Value := StrToFloat(strTemp)
//        end
//        else


        FieldByName('if_statistic').Value := 1;//默认参与统计1

        sgResult.Cells[0,j-8] := IntToStr(j-8);

        for i:=1 to sgResult.ColCount do
        begin
          for iField:=1 to 32 do
            if sgResult.Cells[i,0]= Fields_WL[iField].ZhongWen then
              sgResult.Cells[i,j-8] := VarToStr(FieldValues[Fields_WL[iField].FieldName]);
        end;
        sgResult.RowCount := sgResult.RowCount + 1;
        J := J + 1;
      end;
      UpdateBatch();
    end;

  finally
    ExcelApp.Quit;
    ExcelApp := Unassigned;
    screen.Cursor := crDefault;
  end;
end;

procedure TTuYangDaoRuXLSForm.FormCreate(Sender: TObject);
begin
   self.Left := trunc((screen.Width -self.Width)/2);
   self.Top  := trunc((Screen.Height - self.Height)/2);
   sgResult.FixedCols := 3;
   sgResult.ColCount :=36;
   sgResult.ColWidths[0]:= 30;

//    Fields_YALI.Name := 'yssy_yali';      //压缩试验压力
//    Fields_BXL.Name  := 'yssy_bxl';       //压缩试验各级压力下的变形量
//    Fields_EI.Name   := 'yssy_kxb';       //压缩试验各级压力下的孔隙比
//    Fields_AV.Name   := 'yssy_ysxs';      //压缩试验各级压力下的压缩系数
//    Fields_ES.Name   := 'yssy_ysml';      //压缩试验各级压力下的压缩模量


//    Fields_WCX[1].Name := 'wcx_yuanz';      //无侧限抗压强度原状
//    Fields_WCX[2].Name := 'wcx_chsu';       //重塑
//    Fields_WCX[3].Name := 'wcx_lmd';        //灵敏度

   Fields_WL[1].FieldName := 'drl_no';
   Fields_WL[1].ZhongWen := '钻孔号';
   sgResult.Cells[1,0]:= Fields_WL[1].ZhongWen;
   sgResult.ColWidths[1]:= 120;

   Fields_WL[2].FieldName := 's_no';
   Fields_WL[2].ZhongWen := '土样编号';
   sgResult.Cells[2,0]:= Fields_WL[2].ZhongWen;

   Fields_WL[3].FieldName := 's_depth_begin';
   Fields_WL[3].ZhongWen := '取土深度始';
   sgResult.Cells[3,0]:= Fields_WL[3].ZhongWen;

   Fields_WL[4].FieldName := 's_depth_end';
   Fields_WL[4].ZhongWen := '取土深度止';
   sgResult.Cells[4,0]:= Fields_WL[4].ZhongWen;

   Fields_WL[5].FieldName := 'ea_name';
   Fields_WL[5].ZhongWen := '岩土名称';
   sgResult.Cells[5,0]:= Fields_WL[5].ZhongWen;

   Fields_WL[6].FieldName := 'aquiferous_rate';
   Fields_WL[6].ZhongWen := '含水率';
   sgResult.Cells[6,0]:= Fields_WL[6].ZhongWen;

   Fields_WL[7].FieldName := 'wet_density';
   Fields_WL[7].ZhongWen := '湿密度';
   sgResult.Cells[7,0]:= Fields_WL[7].ZhongWen;

   Fields_WL[8].FieldName := 'dry_density';
   Fields_WL[8].ZhongWen := '干密度';
   sgResult.Cells[8,0]:= Fields_WL[8].ZhongWen;

   Fields_WL[9].FieldName := 'szdu';
   Fields_WL[9].ZhongWen := '湿重度';
   sgResult.Cells[9,0]:= Fields_WL[9].ZhongWen;

   Fields_WL[10].FieldName := 'gzdu';
   Fields_WL[10].ZhongWen := '干重度';
   sgResult.Cells[10,0]:= Fields_WL[10].ZhongWen;

   Fields_WL[11].FieldName := 'soil_proportion';
   Fields_WL[11].ZhongWen := '土粒比重';
   sgResult.Cells[11,0]:= Fields_WL[11].ZhongWen;

   Fields_WL[12].FieldName := 'saturation';
   Fields_WL[12].ZhongWen := '饱和度';
   sgResult.Cells[12,0]:= Fields_WL[12].ZhongWen;

   Fields_WL[13].FieldName := 'gap_rate';
   Fields_WL[13].ZhongWen := '孔隙比';
   sgResult.Cells[13,0]:= Fields_WL[13].ZhongWen;

   Fields_WL[14].FieldName := 'liquid_limit';
   Fields_WL[14].ZhongWen := '液限';
   sgResult.Cells[14,0]:= Fields_WL[14].ZhongWen;

   Fields_WL[15].FieldName := 'shape_limit';
   Fields_WL[15].ZhongWen := '塑限';
   sgResult.Cells[15,0]:= Fields_WL[15].ZhongWen;

   Fields_WL[16].FieldName := 'shape_index';
   Fields_WL[16].ZhongWen := '塑性指数';
   sgResult.Cells[16,0]:= Fields_WL[16].ZhongWen;

   Fields_WL[17].FieldName := 'liquid_index';
   Fields_WL[17].ZhongWen := '液性指数';
   sgResult.Cells[17,0]:= Fields_WL[17].ZhongWen;

   Fields_WL[18].FieldName := 'gap_degree';
   Fields_WL[18].ZhongWen := '孔隙度';
   sgResult.Cells[18,0]:= Fields_WL[18].ZhongWen;

   Fields_WL[19].FieldName := 'shear_type';
   Fields_WL[19].ZhongWen := '直剪实验方法';
   sgResult.Cells[19,0]:= Fields_WL[19].ZhongWen;
   sgResult.ColWidths[19]:= sgResult.ColWidths[18]+10;

   Fields_WL[20].FieldName := 'cohesion';
   Fields_WL[20].ZhongWen := '直快粘聚力';
   sgResult.Cells[20,0]:= Fields_WL[20].ZhongWen;

   Fields_WL[21].FieldName := 'friction_angle';
   Fields_WL[21].ZhongWen := '直快摩擦角';
   sgResult.Cells[21,0]:= Fields_WL[21].ZhongWen;

   Fields_WL[22].FieldName := 'cohesion_gk';
   Fields_WL[22].ZhongWen := '固快粘聚力';
   sgResult.Cells[22,0]:= Fields_WL[22].ZhongWen;

   Fields_WL[23].FieldName := 'friction_gk';
   Fields_WL[23].ZhongWen := '固快摩擦角';
   sgResult.Cells[23,0]:= Fields_WL[23].ZhongWen;

   Fields_WL[24].FieldName := 'zip_coef';
   Fields_WL[24].ZhongWen := '压缩系数';        // 压力100到200下的压缩系数
   sgResult.Cells[24,0]:= Fields_WL[24].ZhongWen;

   Fields_WL[25].FieldName := 'zip_modulus';
   Fields_WL[25].ZhongWen := '压缩模量';        // 压力100到200下的压缩模量
   sgResult.Cells[25,0]:= Fields_WL[25].ZhongWen;

   Fields_WL[26].FieldName := 'li';
   Fields_WL[26].ZhongWen := '砾20.0~2.0';
   sgResult.Cells[26,0]:= Fields_WL[26].ZhongWen;
   sgResult.ColWidths[26]:= sgResult.ColWidths[26]+10;

   Fields_WL[27].FieldName := 'sand_big';
   Fields_WL[27].ZhongWen := '砂2.0~0.5';
   sgResult.Cells[27,0]:= Fields_WL[27].ZhongWen;
   sgResult.ColWidths[27]:= sgResult.ColWidths[27]+15;

   Fields_WL[28].FieldName := 'sand_middle';
   Fields_WL[28].ZhongWen := '砂0.5~0.25';
   sgResult.Cells[28,0]:= Fields_WL[28].ZhongWen;
   sgResult.ColWidths[28]:= sgResult.ColWidths[28]+15;

   Fields_WL[29].FieldName := 'sand_small';
   Fields_WL[29].ZhongWen := '砂0.25~0.075';
   sgResult.Cells[29,0]:= Fields_WL[29].ZhongWen;
   sgResult.ColWidths[29]:= sgResult.ColWidths[29]+15;

   Fields_WL[30].FieldName := 'powder_big';
   Fields_WL[30].ZhongWen := '粉0.075~0.05';
   sgResult.Cells[30,0]:= Fields_WL[30].ZhongWen;
   sgResult.ColWidths[30]:= sgResult.ColWidths[30]+15;

   Fields_WL[31].FieldName := 'powder_small';
   Fields_WL[31].ZhongWen := '粉0.05~0.005';
   sgResult.Cells[31,0]:= Fields_WL[31].ZhongWen;
   sgResult.ColWidths[31]:= sgResult.ColWidths[31]+15;

   Fields_WL[32].FieldName := 'clay_grain';
   Fields_WL[32].ZhongWen := '粘<0.005';
   sgResult.Cells[32,0]:= Fields_WL[32].ZhongWen;


//   sgResult.Cells[26,0]:= '无侧限原状';
//   sgResult.Cells[27,0]:= '无侧限重塑';
//   sgResult.Cells[28,0]:= '无侧限灵敏度';
//   sgResult.ColWidths[28]:= sgResult.ColWidths[28]+10;

   setLabelsTransparent(self);  
end;

procedure TTuYangDaoRuXLSForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= CaFree;
end;

end.
