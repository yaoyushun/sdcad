{ *********************************************************************** }
{                                                                         }
{ SdCadMath unit                                                          }
{                                                                         }
{ Copyright (c) 2003 SD Software Corporation                              }
{                                                                         }
{This unit is math unit for the project}
{ *********************************************************************** }
unit SdCadMath;

interface
uses SysUtils,Math,public_unit;

//取得样品数所对应的舍弃值的临界值
//公式:f(x)= (x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1
function GetCriticalValue(aSampleNum: integer): double;

//传进TAnalyzeResult变量，计算它的平均值、标准差、变异系数等特征值。
procedure GetTeZhengShu(var aAnalyzeResult : TAnalyzeResult; Flags: TTongJiFlags);

//传进TAnalyzeResult变量，计算它的平均值、标准差、变异系数等特征值。
//此函数是为了物理力学统计时，静探数据不进行剔除，做了改动。2005/07/11 yys edit
procedure GetTeZhengShuWLLX(var aAnalyzeResult : TAnalyzeResult);

{ *********************************************************************** }
{ 土分析分层总表,天然状态的基本物理指标计算和计算求得的可塑性指标的计算   }
{ *********************************************************************** }
{GetGanMiDu: return干密度,AHanShuiLiang含水量,AShiMiDu湿密度,
干密度=湿密度/(1+0.01*含水量) }
function GetGanMiDu(const AHanShuiLiang: double; const AShiMiDu: double): double;

{GetKongXiBi: return孔隙比,ATuLiBiZhong土粒比重,AGanMiDu干密度,AShuiMiDu水的比重,
孔隙比=(土粒比重*水的比重)/干密度-1 }
function GetKongXiBi(const ATuLiBiZhong: double; const AGanMiDu: double; const AShuiMiDu: double=1): double;

{GetKongXiDu: return孔隙度,AKongXiBi孔隙比,
孔隙度=(100*孔隙比)/(1+孔隙比) }
function GetKongXiDu(const AKongXiBi: double): double;

{GetBaoHeDu: return饱合度,AHanShuiLiang含水量,ATuLiBiZhong土粒比重,AKongXiBi孔隙比,
饱合度=含水量*土粒比重/孔隙比}
function GetBaoHeDu(const AHanShuiLiang: double; const ATuLiBiZhong: double; const AKongXiBi: double): double;

{GetSuXingZhiShu: return塑性指数,AYeXian液限,ASuXian塑限,
塑性指数=液限-塑限}
function GetSuXingZhiShu(const AYeXian: double; const ASuXian: double): double;

{GetYeXingZhiShu: return液性指数,AHanShuiLiang含水量,ASuXian塑限,AYeXian液限,
液性指数=(含水量-塑限)/(液限-塑限)}
function GetYeXingZhiShu(const AHanShuiLiang: double; const ASuXian: double;const AYeXian: double ): double;

{******************************************************************}
{**********数值算法************************************************}
{******************************************************************}
{XianXingChaZhi: 线形插值
  公式:f(x)= (x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1}
function XianXingChaZhi(x0, y0, x1, y1, x: double): double;

{ShuangXianXingChaZhi: 线形插值
  公式:f(x)= (x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1}
function ShuangXianXingChaZhi(x0, y0, x1, y1, zx0y0,zx0y1, zx1y0, zx1y1, x, y: double): double;

implementation

uses MainDM;


function GetGanMiDu(const AHanShuiLiang: double; const AShiMiDu: double): double;
begin
  try
    result:= AShiMiDu / (1 + 0.01 * AHanShuiLiang);
  except
    result:= 0;
  end;
end;

function GetKongXiBi(const ATuLiBiZhong: double; const AGanMiDu: double; const AShuiMiDu: double=1): double;
begin
  result:= ATuLiBiZhong * AShuiMiDu / AGanMiDu - 1;
end;

function GetKongXiDu(const AKongXiBi: double): double;
begin
  result:=100 * AKongXiBi / (1 + AKongXiBi);
end;

function GetBaoHeDu(const AHanShuiLiang: double; const ATuLiBiZhong: double; const AKongXiBi: double): double;
begin
  result:= AHanShuiLiang * ATuLiBiZhong / AKongXiBi;
  if result>100 then result:= 100;
end;

function GetSuXingZhiShu(const AYeXian: double; const ASuXian: double): double;
begin
  result:= AYeXian - ASuXian;
end;

function GetYeXingZhiShu(const AHanShuiLiang: double; const ASuXian: double;const AYeXian: double ): double;
begin
  result:= (AHanShuiLiang - ASuXian) / (AYeXian - ASuXian);
end;

function XianXingChaZhi(x0, y0, x1, y1, x: double): double;
begin
  result:= (x - x1) / (x0 - x1) * y0 + (x - x0) / (x1-x0) * y1;
end;

function ShuangXianXingChaZhi(x0, y0, x1, y1, zx0y0,zx0y1, zx1y0, zx1y1, x, y: double): double;
var
  tmpz0,tmpz1: double;
begin
  tmpz0:= XianXingChaZhi(x0, zx0y0, x1, zx1y0, x);
  tmpz1:= XianXingChaZhi(x0, zx0y1, x1, zx1y1, x);
  result:= XianXingChaZhi(y0, tmpz0, y1, tmpz1, y);
end;

//取得样品数所对应的舍弃值的临界值
//公式:f(x)= (x-x1)/(x0-x1)*y0+(x-x0)/(x1-x0)*y1
function GetCriticalValue(aSampleNum: integer): double;
var
  iNum: integer;
  x0,y0,x1,y1,tmpX,tmpY: double;
begin
  x0:=0;
  y0:=0;
  with MainDataModule.qrySectionTotal do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT yangpinshu,zhixinshuiping95 FROM CriticalValue');
    open;
    iNum:= 0;
    while not eof do
    begin
      inc(iNum);
      tmpX:= FieldbyName('yangpinshu').AsInteger;
      tmpY:= FieldbyName('zhixinshuiping95').AsFloat;
      if aSampleNum= tmpX then
      begin
        result:= tmpY;
        close;
        exit;
      end;
      if iNum=1 then 
        begin
          x0:= tmpX;
          y0:= tmpY;
          if aSampleNum<x0 then
          begin
            result:= tmpY;
            close;
            exit;
          end;
        end
      else
        begin
          if (aSampleNum<tmpX) then
            begin
              x1:=tmpX;
              y1:=tmpY;
              result:= StrToFloat(formatfloat('0.00',XianXingChaZhi(x0, y0, x1, y1, aSampleNum)));
              close;
              exit;
            end
          else
            begin
              x0:= tmpX;
              y0:= tmpY;
            end;
        end; 
      next;
    end;
    close;
  end;
  result:= y0;
end;

//传进TAnalyzeResult变量，计算它的平均值、标准差、变异系数等特征值。
procedure GetTeZhengShu(var aAnalyzeResult : TAnalyzeResult; Flags: TTongJiFlags);
var
  i,iCount,iFirst,iMin,iMax:integer;
  dTotal,dValue,dTotalFangCha,dCriticalValue:double;
  strValue: string;
  //计算临界值
  function CalculateCriticalValue(aValue, aPingjunZhi, aBiaoZhunCha: double): double;
  begin
    if aBiaoZhunCha = 0 then
    begin
      result:= 0;
      exit;
    end;
    result := (aValue - aPingjunZhi) / aBiaoZhunCha;
  end;
begin
  iMax:=0;
  dTotal:= 0;
  iFirst:= 0;
  dTotalFangCha:=0;
//yys 2005/06/15
//  aAnalyzeResult.PingJunZhi := 0;
//  aAnalyzeResult.BiaoZhunCha := 0;
//  aAnalyzeResult.BianYiXiShu := 0;
//  aAnalyzeResult.MaxValue := 0;
//  aAnalyzeResult.MinValue := 0;
//  aAnalyzeResult.SampleNum := 0;
  aAnalyzeResult.PingJunZhi := -1;
  aAnalyzeResult.BiaoZhunCha := -1;
  aAnalyzeResult.BianYiXiShu := -1;
  aAnalyzeResult.MaxValue := -1;
  aAnalyzeResult.MinValue := -1;
  aAnalyzeResult.SampleNum := -1;
  if aAnalyzeResult.lstValues.Count<1 then exit;
  strValue := '';
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
      strValue:=strValue + aAnalyzeResult.lstValues.Strings[i];
  strValue := trim(strValue);
  if strValue='' then exit;

//yys 2005/06/15
  iCount:= aAnalyzeResult.lstValues.Count;
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
    begin
      strValue:=aAnalyzeResult.lstValues.Strings[i];
      if strValue='' then
      begin
        iCount:=iCount-1;
      end
      else
      begin
        inc(iFirst);
        dValue:= StrToFloat(strValue); 
        if iFirst=1 then
          begin
            aAnalyzeResult.MinValue:= dValue;
            aAnalyzeResult.MaxValue:= dValue;
            iMin := i;
            iMax := i;
          end
        else
          begin
            if aAnalyzeResult.MinValue>dValue then
            begin
              aAnalyzeResult.MinValue:= dValue;
              iMin := i;
            end;
            if aAnalyzeResult.MaxValue<dValue then
            begin
              aAnalyzeResult.MaxValue:= dValue;
              iMax := i;
            end;                            
          end;           
        dTotal:= dTotal + dValue;          
      end;
    end;
  //dTotal:= dTotal - aAnalyzeResult.MinValue - aAnalyzeResult.MaxValue;
  //iCount := iCount - 2;
  if iCount>=1 then
    aAnalyzeResult.PingJunZhi := dTotal/iCount
  else
    aAnalyzeResult.PingJunZhi := dTotal;
  //aAnalyzeResult.lstValues.Strings[iMin]:= '';
  //aAnalyzeResult.lstValues.Strings[iMax]:= '';

  //iCount:= aAnalyzeResult.lstValues.Count;
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
  begin
    strValue:=aAnalyzeResult.lstValues.Strings[i];
    if strValue<>'' then
    begin
      dValue := StrToFloat(strValue);
      dTotalFangCha := dTotalFangCha + sqr(dValue-aAnalyzeResult.PingJunZhi);
    end
    //else iCount:= iCount -1;
  end;
  if iCount>1 then
    dTotalFangCha:= dTotalFangCha/(iCount-1);
  aAnalyzeResult.SampleNum := iCount;
  if iCount >1 then
    aAnalyzeResult.BiaoZhunCha := sqrt(dTotalFangCha)
  else
    aAnalyzeResult.BiaoZhunCha := sqrt(dTotalFangCha);
  if not iszero(aAnalyzeResult.PingJunZhi) then
    aAnalyzeResult.BianYiXiShu := strtofloat(formatfloat(aAnalyzeResult.FormatString,aAnalyzeResult.BiaoZhunCha / aAnalyzeResult.PingJunZhi))
  else
    aAnalyzeResult.BianYiXiShu:= 0;


  dValue:= CalculateCriticalValue(aAnalyzeResult.MaxValue, aAnalyzeResult.PingJunZhi,aAnalyzeResult.BiaoZhunCha);
  dCriticalValue := GetCriticalValue(iCount);

//2005/07/25 yys edit 土样数据剔除时，到6个样就不再剔除，剔除时要先剔除最大的数据
  if tfTuYang in Flags then

      if (iCount> 6) AND (dValue > dCriticalValue) then
        begin
          aAnalyzeResult.lstValues.Strings[iMax]:= '';
          if aAnalyzeResult.lstValuesForPrint.Strings[iMax]<>'' then
            aAnalyzeResult.lstValuesForPrint.Strings[iMax]:= '-'
              +aAnalyzeResult.lstValuesForPrint.Strings[iMax];
          GetTeZhengShu(aAnalyzeResult, Flags);
        end

  else if tfJingTan in Flags  then //静探不剔除数据    tfOther也不剔除
  else if tfBiaoGuan in Flags  then
        if dValue > dCriticalValue then
        begin
          aAnalyzeResult.lstValues.Strings[iMax]:= '';
          aAnalyzeResult.lstValuesForPrint.Strings[iMax]:= '-'
            +aAnalyzeResult.lstValuesForPrint.Strings[iMax];          
          GetTeZhengShu(aAnalyzeResult, Flags);
        end;


//yys 2005/06/15 add, 当一层只有一个样时，标准差和变异系数不能为0，打印报表时要用空格，物理力学表也一样。所以用-1来表示空值，是因为在报表设计时可以通过判断来表示为空。
  if  iCount=1 then
  begin
     //aAnalyzeResult.strBianYiXiShu  := 'null';
     //aAnalyzeResult.strBiaoZhunCha  := 'null';
     aAnalyzeResult.BianYiXiShu := -1;
     aAnalyzeResult.BiaoZhunCha := -1;
  end
  else begin
     //aAnalyzeResult.strBianYiXiShu := FloatToStr(aAnalyzeResult.BianYiXiShu);
    // aAnalyzeResult.strBiaoZhunCha := FloatToStr(aAnalyzeResult.BiaoZhunCha);
  end;
//yys 2005/06/15 add
end;


//传进TAnalyzeResult变量，计算它的平均值、标准差、变异系数等特征值。
procedure GetTeZhengShuWLLX(var aAnalyzeResult : TAnalyzeResult);
var
  i,iCount,iFirst,iMin,iMax:integer;
  dTotal,dValue,dTotalFangCha,dCriticalValue:double;
  strValue: string;
  //计算临界值
  function CalculateCriticalValue(aValue, aPingjunZhi, aBiaoZhunCha: double): double;
  begin
    if aBiaoZhunCha = 0 then
    begin
      result:= 0;
      exit;
    end;
    result := (aValue - aPingjunZhi) / aBiaoZhunCha;
  end;
begin
  iMax:=0;
  dTotal:= 0;
  iFirst:= 0;
  dTotalFangCha:=0;
//yys 2005/06/15
//  aAnalyzeResult.PingJunZhi := 0;
//  aAnalyzeResult.BiaoZhunCha := 0;
//  aAnalyzeResult.BianYiXiShu := 0;
//  aAnalyzeResult.MaxValue := 0;
//  aAnalyzeResult.MinValue := 0;
//  aAnalyzeResult.SampleNum := 0;
  aAnalyzeResult.PingJunZhi := -1;
  aAnalyzeResult.BiaoZhunCha := -1;
  aAnalyzeResult.BianYiXiShu := -1;
  aAnalyzeResult.MaxValue := -1;
  aAnalyzeResult.MinValue := -1;
  aAnalyzeResult.SampleNum := -1;
  if aAnalyzeResult.lstValues.Count<1 then exit;
  strValue := '';
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
      strValue:=strValue + aAnalyzeResult.lstValues.Strings[i];
  strValue := trim(strValue);
  if strValue='' then exit;

//yys 2005/06/15
  iCount:= aAnalyzeResult.lstValues.Count;
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
    begin
      strValue:=aAnalyzeResult.lstValues.Strings[i];
      if strValue='' then
      begin
        iCount:=iCount-1;
      end
      else
      begin
        inc(iFirst);
        dValue:= StrToFloat(strValue); 
        if iFirst=1 then
          begin
            aAnalyzeResult.MinValue:= dValue;
            aAnalyzeResult.MaxValue:= dValue;
            iMin := i;
            iMax := i;
          end
        else
          begin
            if aAnalyzeResult.MinValue>dValue then
            begin
              aAnalyzeResult.MinValue:= dValue;
              iMin := i;
            end;
            if aAnalyzeResult.MaxValue<dValue then
            begin
              aAnalyzeResult.MaxValue:= dValue;
              iMax := i;
            end;                            
          end;           
        dTotal:= dTotal + dValue;          
      end;
    end;
  //dTotal:= dTotal - aAnalyzeResult.MinValue - aAnalyzeResult.MaxValue;
  //iCount := iCount - 2;
  if iCount>=1 then
    aAnalyzeResult.PingJunZhi := dTotal/iCount
  else
    aAnalyzeResult.PingJunZhi := dTotal;
  //aAnalyzeResult.lstValues.Strings[iMin]:= '';
  //aAnalyzeResult.lstValues.Strings[iMax]:= '';

  //iCount:= aAnalyzeResult.lstValues.Count;
  for i:= 0 to aAnalyzeResult.lstValues.Count-1 do
  begin
    strValue:=aAnalyzeResult.lstValues.Strings[i];
    if strValue<>'' then
    begin
      dValue := StrToFloat(strValue);
      dTotalFangCha := dTotalFangCha + sqr(dValue-aAnalyzeResult.PingJunZhi);
    end
    //else iCount:= iCount -1;
  end;
  if iCount>1 then
    dTotalFangCha:= dTotalFangCha/(iCount-1);
  aAnalyzeResult.SampleNum := iCount;
  if iCount >1 then
    aAnalyzeResult.BiaoZhunCha := sqrt(dTotalFangCha)
  else
    aAnalyzeResult.BiaoZhunCha := sqrt(dTotalFangCha);
  if not iszero(aAnalyzeResult.PingJunZhi) then
    aAnalyzeResult.BianYiXiShu := strtofloat(formatfloat(aAnalyzeResult.FormatString,aAnalyzeResult.BiaoZhunCha / aAnalyzeResult.PingJunZhi))
  else
    aAnalyzeResult.BianYiXiShu:= 0;


  dValue:= CalculateCriticalValue(aAnalyzeResult.MaxValue, aAnalyzeResult.PingJunZhi,aAnalyzeResult.BiaoZhunCha);
  dCriticalValue := GetCriticalValue(iCount);
//  if dValue > dCriticalValue then
//  begin
//    aAnalyzeResult.lstValues.Strings[iMax]:= '';
//    GetTeZhengShuWLLX(aAnalyzeResult);
//  end;

//yys 2005/06/15 add, 当一层只有一个样时，标准差和变异系数不能为0，打印报表时要用空格，物理力学表也一样。所以用-1来表示空值，是因为在报表设计时可以通过判断来表示为空。
  if  iCount=1 then
  begin
     //aAnalyzeResult.strBianYiXiShu  := 'null';
     //aAnalyzeResult.strBiaoZhunCha  := 'null';
     aAnalyzeResult.BianYiXiShu := -1;
     aAnalyzeResult.BiaoZhunCha := -1;
  end
  else begin
     //aAnalyzeResult.strBianYiXiShu := FloatToStr(aAnalyzeResult.BianYiXiShu);
    // aAnalyzeResult.strBiaoZhunCha := FloatToStr(aAnalyzeResult.BiaoZhunCha);
  end;
//yys 2005/06/15 add
end;


end.
