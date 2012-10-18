unit DrillDiagram;

interface

uses  ExtCtrls,Classes,Graphics,forms,sysutils,Math;

const FIRSTVALUE        :double  = -10000; //变量初始值
const TITLEVOFF         :Integer =      5; //孔口坐标纵向预留高度
const TOPLINEVOFF       :integer =     25; //孔口基线纵向预留高度
const BOTTOMLINEVOFF    :integer =     10; //孔底基线纵向预留高度
Const TBLINEHLOFF       :integer =      0; //基线横向左边预留宽度
const TBLINEHROFF       :integer =     50; //基线横向右边预留宽度
const AXISLINEOFF       :integer =     25; //轴线向左偏移量
const LTEXTOFF          :integer =     90; //左边文字预留宽度
const CDRILLTOP         :double  =      0; //上基线初始值
const CDRILLBOTTOM      :double  =      0; //下基线初始值
const BACKGROUNDCOLOR   :integer =clWhite; //背景颜色
const TOPBOTTOMLINECOLOR:integer =clFuchsia; //范围线颜色
const TITLECOLOR        :integer = clNavy; //标题颜色
const NOTECOLOR         :integer = clBlue; //标注颜色
const SHAPECOLOR        :integer =clBlack; //图形颜色
const MARKCOLOR         :integer =  clRed; //标记颜色

type
   TDrillDiagram=class
   private
   m_AxisLine:integer;
   m_RegionPixelHeigh:integer;
   m_RegionActualHeigh:double;
   FImage:TImage;
   FDrillTop:double;
   FDrillBottom:double;
   FDrillStandHeigh:double;
   FDrillX:double;
   FDrillY:double;
   FFirstWaterHeigh:double;
   FStableWaterHeigh:double;
   FPipeDiameter:double;
   FPlanDepth:double;
   FFinishDepth:double;
   FStratumList:TStrings;
   FBMList:TList;
   procedure SetImage(aImage:TImage);
   procedure SetDrillStandHeigh(aDrillStandHeigh:double);
   procedure SetDrillX(aDrillX:double);
   procedure SetDrillY(aDrillY:double);
   procedure SetFirstWaterHeigh(aFirstWaterHeigh:double);
   procedure SetStableWaterHeigh(aStableWaterHeigh:double);
   procedure SetPipeDiameter(aPipeDiameter:double);
   procedure SetPlanDepth(aPlanDepth:double);
   procedure SetFinishDepth(aFinishDepth:double);
   procedure SetPubVar;
   procedure SetStratumList(aStratumList:TStrings);
   procedure SetBMList(aBMList:TList);
   public
   property Image:TImage read FImage write SetImage;
   property DrillTop:double read FDrillTop;
   property DrillBottom:double read FDrillBottom;
   property DrillStandHeigh:double read FDrillStandHeigh write SetDrillStandHeigh;
   property DrillX:double read FDrillX write SetDrillX;
   property DrillY:double read FDrillY write SetDrillY;
   property FirstWaterHeigh:double read FFirstWaterHeigh write SetFirstWaterHeigh;
   property StableWaterHeigh:double read FStableWaterHeigh write SetStableWaterHeigh;
   property PipeDiameter:double read FPipeDiameter write SetPipeDiameter;
   property PlanDepth:double read FPlanDepth write SetPlanDepth;
   property FinishDepth:double read FFinishDepth write SetFinishDepth;
   property StratumList:TStrings read FStratumList write SetStratumList;
   property BMList:TList read FBMList write SetBMList;
   Constructor create;
   procedure DrawDrillDiagram(ReGetPixelHeigh:boolean);
   procedure SetTopBottom(aTop,aBottom:double;isForceSet:boolean=false);
   procedure Clear;
end;
implementation

Constructor TDrillDiagram.create;
begin
   inherited Create;
   m_AxisLine:=0;
   m_RegionPixelHeigh:=40;
   m_RegionActualHeigh:=40;
   FImage:=nil;
   clear;
end;

procedure TDrillDiagram.SetImage(aImage:TImage);
begin
   if Assigned(aImage) then
   begin
      FImage:=aImage;
      SetPubVar;
   end;
end;

procedure TDrillDiagram.SetDrillStandHeigh(aDrillStandHeigh:double);
begin
   if aDrillStandHeigh<>FDrillStandHeigh then FDrillStandHeigh:=aDrillStandHeigh;
   if aDrillStandHeigh>FDrillTop then
      FDrillTop:=aDrillStandHeigh;
   if (FPlanDepth=FIRSTVALUE) and (FFinishDepth=FIRSTVALUE) then
      begin
      if (FFirstWaterHeigh<>FIRSTVALUE) or (FStableWaterHeigh<>FIRSTVALUE) then
         if (FFirstWaterHeigh=FIRSTVALUE) and (FStableWaterHeigh<>FIRSTVALUE) then
            begin if FDrillBottom>FDrillStandHeigh-abs(FStableWaterHeigh) then FDrillBottom:=FDrillStandHeigh-abs(FStableWaterHeigh);end
         else if (FFirstWaterHeigh<>FIRSTVALUE) and (FStableWaterHeigh=FIRSTVALUE) then
            begin if FDrillBottom>FDrillStandHeigh-abs(FFirstWaterHeigh) then FDrillBottom:=FDrillStandHeigh-abs(FFirstWaterHeigh);end
         else
            begin if FDrillBottom>FDrillStandHeigh-abs(max(FFirstWaterHeigh,FStableWaterHeigh)) then FDrillBottom:=FDrillStandHeigh-abs(max(FFirstWaterHeigh,FStableWaterHeigh));end;
      end
   else
      if (FPlanDepth=FIRSTVALUE) and (FFinishDepth<>FIRSTVALUE) then
         begin if FDrillBottom>FDrillStandHeigh-abs(FFinishDepth) then FDrillBottom:=FDrillStandHeigh-abs(FFinishDepth); end
      else if (FPlanDepth<>FIRSTVALUE) and (FFinishDepth=FIRSTVALUE) then
         begin if FDrillBottom>FDrillStandHeigh-abs(FPlanDepth) then FDrillBottom:=FDrillStandHeigh-abs(FPlanDepth);end
      else
         begin if FDrillBottom>FDrillStandHeigh-abs(max(FPlanDepth,FFinishDepth)) then FDrillBottom:=FDrillStandHeigh-abs(max(FPlanDepth,FFinishDepth));end;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetDrillX(aDrillX:double);
begin
   if aDrillX<>FDrillX then FDrillX:=aDrillX;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetDrillY(aDrillY:double);
begin
   if aDrillY<>FDrillY then FDrillY:=aDrillY;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetFirstWaterHeigh(aFirstWaterHeigh:double);
begin
   if aFirstWaterHeigh<>FFirstWaterHeigh then FFirstWaterHeigh:=aFirstWaterHeigh;
   if FDrillStandHeigh<>FIRSTVALUE then
      begin
      if (FDrillStandHeigh-abs(aFirstWaterHeigh))<FDrillBottom then
         FDrillBottom:=FDrillStandHeigh-abs(aFirstWaterHeigh);
      end
   else
      if (FDrillBottom=FIRSTVALUE)or((FDrillTop-abs(aFirstWaterHeigh))<FDrillBottom) then
         FDrillBottom:=FDrillTop-abs(aFirstWaterHeigh);
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetStableWaterHeigh(aStableWaterHeigh:double);
begin
   if aStableWaterHeigh<>FStableWaterHeigh then FStableWaterHeigh:=aStableWaterHeigh;
   if FDrillStandHeigh<>FIRSTVALUE then
      begin
      if (FDrillStandHeigh-abs(aStableWaterHeigh))<FDrillBottom then
         FDrillBottom:=FDrillStandHeigh-abs(aStableWaterHeigh);
      end
   else
      if (FDrillBottom=FIRSTVALUE)or((FDrillTop-abs(aStableWaterHeigh))<FDrillBottom) then
         FDrillBottom:=FDrillTop-abs(aStableWaterHeigh);
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetPipeDiameter(aPipeDiameter:double);
begin
   if aPipeDiameter<>FPipeDiameter then FPipeDiameter:=aPipeDiameter;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetPlanDepth(aPlanDepth:double);
begin
   if aPlanDepth<>FPlanDepth then FPlanDepth:=aPlanDepth;
   if FDrillStandHeigh<>FIRSTVALUE then
      begin
      if (FDrillStandHeigh-abs(aPlanDepth))<FDrillBottom then
         FDrillBottom:=FDrillStandHeigh-abs(aPlanDepth);
      end
   else
      if (FDrillBottom=FIRSTVALUE)or((FDrillTop-abs(aPlanDepth))<FDrillBottom) then
         FDrillBottom:=FDrillTop-abs(aPlanDepth);
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetFinishDepth(aFinishDepth:double);
begin
   if aFinishDepth<>FFinishDepth then FFinishDepth:=aFinishDepth;
   if FDrillStandHeigh<>FIRSTVALUE then
      begin
      if (FDrillStandHeigh-abs(aFinishDepth))<FDrillBottom then
         FDrillBottom:=FDrillStandHeigh-abs(aFinishDepth);
      end
   else
      if (FDrillBottom=FIRSTVALUE)or((FDrillTop-abs(aFinishDepth))<FDrillBottom) then
         FDrillBottom:=FDrillTop-abs(aFinishDepth);
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetStratumList(aStratumList:TStrings);
begin
   FStratumList:=aStratumList;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.SetBMList(aBMList:TList);
begin
   FBMList:=aBMList;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.DrawDrillDiagram(ReGetPixelHeigh:boolean);
var
   aMidPoint,i,j:integer;
   aRate:double;
   aSitX,aSitY,aSHSitY,aSHSitX,tmpSitY:integer;
   aPipeDiameter:double;
   aBits:TBits;
   aBitMap:TBitMap;
begin
   if ReGetPixelHeigh then SetPubVar;
   if FDrillBottom<>FDrillTop then m_RegionActualHeigh:=abs(FDrillBottom-FDrillTop);
   FImage.Canvas.Brush.Color:=BACKGROUNDCOLOR;
   FImage.Canvas.FillRect(Rect(0,0,FImage.Width,FImage.Height));
   aMidPoint:=FImage.Width DIV 2;
   FImage.Canvas.Font.Color:=TITLECOLOR;
   if FDrillX<>FIRSTVALUE then
      FImage.Canvas.TextOut(aMidPoint Div 4+2,TITLEVOFF,'X座标:'+formatfloat('0.00',FDrillX))//floattostr(FDrillX))
   else
      FImage.Canvas.TextOut(aMidPoint Div 4+2,TITLEVOFF,'X座标:');
   if FDrillY<>FIRSTVALUE then
      FImage.Canvas.TextOut(aMidPoint-aMidPoint Div 4 ,TITLEVOFF,'Y座标:'+formatfloat('0.00',FDrillY))//floattostr(FDrillY))
   else
      FImage.Canvas.TextOut(aMidPoint-aMidPoint Div 4 ,TITLEVOFF,'Y座标:');
   FImage.Canvas.Pen.Color:=TOPBOTTOMLINECOLOR;
   FImage.Canvas.MoveTo(TBLINEHLOFF,TOPLINEVOFF);
   FImage.Canvas.LineTo(FImage.Width-TBLINEHROFF,TOPLINEVOFF);
   FImage.Canvas.MoveTo(TBLINEHLOFF,FImage.Height-BOTTOMLINEVOFF);
   FImage.Canvas.LineTo(FImage.Width-TBLINEHROFF,FImage.Height-BOTTOMLINEVOFF);
   FImage.Canvas.Pen.Color:=SHAPECOLOR;
   FImage.Canvas.TextOut(FImage.Width-TBLINEHROFF+5,TOPLINEVOFF-5,formatfloat('0.00',FDrillTop));
   FImage.Canvas.TextOut(FImage.Width-TBLINEHROFF+5,FImage.Height-BOTTOMLINEVOFF-5,formatfloat('0.00',FDrillBottom));
   if FPipeDiameter=FIRSTVALUE then
      begin
      FImage.Canvas.Pen.Style :=psDot;
      aPipeDiameter:=40;
      end
   else
      begin
      FImage.Canvas.Pen.Style :=psSolid;
      aPipeDiameter:=FPipeDiameter;
      end;
   aSitX:=m_AxisLine-round(aPipeDiameter/2);
   aSHSitX:=m_AxisLine+round(aPipeDiameter/2);
   aRate:=m_RegionPixelHeigh/m_RegionActualHeigh;
   aSitY:=TOPLINEVOFF;
   aSHSitY:=TOPLINEVOFF;

   FImage.Canvas.Font.Color :=NOTECOLOR;
   if FDrillStandHeigh<>FIRSTVALUE then
      begin
      aSitY:=TOPLINEVOFF+round(abs(FDrillStandHeigh-FDrillTop)*aRate);
      FImage.Canvas.MoveTo(aSitX,aSitY);
      FImage.Canvas.LineTo(aSHSitX,aSitY);
      //FImage.Canvas.TextOut(aSHSitX+5,aSitY-5,'孔口标高('+floattostr(FDrillStandHeigh)+')');
      FImage.Canvas.Font.Color :=TITLECOLOR;
      FImage.Canvas.TextOut(aMidPoint+aMidPoint Div 4 ,TITLEVOFF,'孔口标高:'+FormatFloat('0.00',FDrillStandHeigh));
      FImage.Canvas.Font.Color :=NOTECOLOR;
      aSHSitY:=aSitY;
      end;

   if FStratumList.Count>0 then
      begin
      if FImage.Canvas.Pen.Style<>psSolid then FImage.Canvas.Pen.Style :=psSolid;
      if FDrillStandHeigh=FIRSTVALUE then
         begin
         FImage.Canvas.MoveTo(aSitX,aSHSitY);
         FImage.Canvas.LineTo(aSHSitX,aSHSitY);
         end;
      aBitMap:=TBitMap.Create ;
      aBitMap.Width :=32;
      aBitMap.Height :=32;
      tmpSitY:=aSHSitY;
      for i:=0 to FStratumList.Count-1 do
         begin
         if FDrillStandHeigh<>FIRSTVALUE then
            aSitY:=TOPLINEVOFF+round(abs(strtofloat(FStratumList[i])+(FDrillTop-FDrillStandHeigh))*aRate)
         else
            aSitY:=TOPLINEVOFF+round(abs(strtofloat(FStratumList[i]))*aRate);
         if FBMList.Count>i then
            begin
            aBits:=TBits(FBMList[i]);
            for j:=0 to aBits.Size-1 do
               if aBits.Bits[j] then
                  aBitMap.Canvas.Pixels[j mod 32,j div 32]:=clWhite
               else
                  aBitMap.Canvas.Pixels[j mod 32,j div 32]:=clBlack;
            FImage.Canvas.Brush.Style:=bsClear;
            FImage.Canvas.Brush.Bitmap :=aBitMap;
            FImage.Canvas.FillRect(Rect(aSitX,tmpSitY+1,aSHSitX,aSitY));
            FImage.Canvas.Brush.Style:=bsSolid;
            FImage.Canvas.Brush.Bitmap :=nil;
            end;
         if FFinishDepth=FIRSTVALUE then
            begin
            FImage.Canvas.MoveTo(aSitX,tmpSitY);
            FImage.Canvas.LineTo(aSitX,aSitY);
            FImage.Canvas.MoveTo(aSHSitX,tmpSitY);
            FImage.Canvas.LineTo(aSHSitX,aSitY);
            end;
         FImage.Canvas.MoveTo(aSitX,aSitY);
         FImage.Canvas.LineTo(aSHSitX,aSitY);
         if FDrillStandHeigh<>FIRSTVALUE then
            if i mod 2=0 then
               FImage.Canvas.TextOut(aSHSitX+5,aSitY-5,FStratumList[i]+'('+FormatFloat('0.00',FDrillStandHeigh-strtofloat(FStratumList[i]))+')')
            else
               FImage.Canvas.TextOut(aSitX-LTEXTOFF,aSitY-5,FStratumList[i]+'('+FormatFloat('0.00',FDrillStandHeigh-strtofloat(FStratumList[i]))+')')
         else
            if i mod 2=1 then
               FImage.Canvas.TextOut(aSHSitX+5,aSitY-5,FStratumList[i]+'('+FormatFloat('0.00',FDrillTop-strtofloat(FStratumList[i]))+')')
            else
               FImage.Canvas.TextOut(aSitX-LTEXTOFF,aSitY-5,FStratumList[i]+'('+FormatFloat('0.00',FDrillTop-strtofloat(FStratumList[i]))+')');
         tmpSitY:=aSitY;
         end;
      aBitMap.Free ;
      end;

   if FFirstWaterHeigh<>FIRSTVALUE then
      begin
      FImage.Canvas.Pen.Color:=MARKCOLOR;
      FImage.Canvas.Pen.Style :=psDashDotDot;
      if FDrillStandHeigh<>FIRSTVALUE then
         aSitY:=TOPLINEVOFF+round(abs(FDrillStandHeigh-FDrillTop-FFirstWaterHeigh)*aRate)
      else
         aSitY:=TOPLINEVOFF+round(FFirstWaterHeigh*aRate);
      FImage.Canvas.MoveTo(aSitX,aSitY);
      //FImage.Canvas.LineTo(aSHSitX,aSitY);
      FImage.Canvas.LineTo(aSitX+100,aSitY);
      
      {FImage.Canvas.MoveTo(m_AxisLine,aSitY);
      FImage.Canvas.LineTo(m_AxisLine+5,aSitY-5);
      FImage.Canvas.MoveTo(m_AxisLine+5,aSitY-5);
      FImage.Canvas.LineTo(m_AxisLine-5,aSitY-5);
      FImage.Canvas.MoveTo(m_AxisLine-5,aSitY-5);
      FImage.Canvas.LineTo(m_AxisLine,aSitY);
      FImage.Canvas.Pen.Color:=SHAPECOLOR;}

      FImage.Canvas.TextOut(aSitX-LTEXTOFF,aSitY-5,'初见水位:'+FormatFloat('0.00',FFirstWaterHeigh));
      end;

   if FStableWaterHeigh<>FIRSTVALUE then
      begin
      FImage.Canvas.Pen.Style :=psDashDotDot;
      FImage.Canvas.Pen.Color:=MARKCOLOR;
      if FDrillStandHeigh<>FIRSTVALUE then
         aSitY:=TOPLINEVOFF+round(abs(FDrillStandHeigh-FDrillTop-FStableWaterHeigh)*aRate)
      else
         aSitY:=TOPLINEVOFF+round(FStableWaterHeigh*aRate);
      FImage.Canvas.MoveTo(aSHSitX,aSitY);
      //FImage.Canvas.LineTo(aSHSitX,aSitY);
      FImage.Canvas.LineTo(aSHSitX-100,aSitY);
      
      {FImage.Canvas.MoveTo(m_AxisLine,aSitY);
      FImage.Canvas.LineTo(m_AxisLine+5,aSitY-5);
      FImage.Canvas.MoveTo(m_AxisLine+5,aSitY-5);
      FImage.Canvas.LineTo(m_AxisLine-5,aSitY-5);
      FImage.Canvas.MoveTo(m_AxisLine-5,aSitY-5);
      FImage.Canvas.LineTo(m_AxisLine,aSitY);
      FImage.Canvas.Pen.Color:=SHAPECOLOR;}

      FImage.Canvas.TextOut(aSHSitX+5,aSitY-5,'稳定水位:'+FormatFloat('0.00',FStableWaterHeigh));
      end;

   if FPlanDepth<>FIRSTVALUE then
      begin
      FImage.Canvas.Pen.Style :=psDot;
      FImage.Canvas.Pen.Color:=MARKCOLOR;
      if FDrillStandHeigh<>FIRSTVALUE then
         aSitY:=TOPLINEVOFF+round(abs(FDrillStandHeigh-FDrillTop-FPlanDepth)*aRate)
      else
         aSitY:=TOPLINEVOFF+round(FPlanDepth*aRate);
      FImage.Canvas.MoveTo(aSitX,aSitY);
      FImage.Canvas.LineTo(aSHSitX,aSitY);
      FImage.Canvas.Pen.Color:=SHAPECOLOR;
      FImage.Canvas.TextOut(aSitX-LTEXTOFF,aSitY-5,'计划深度:'+FormatFloat('0.00',FPlanDepth));
      FImage.Canvas.MoveTo(aSitX,aSHSitY);
      FImage.Canvas.LineTo(aSitX,aSitY);
      FImage.Canvas.MoveTo(aSHSitX,aSHSitY);
      FImage.Canvas.LineTo(aSHSitX,aSitY);
      end;
   if FFinishDepth<>FIRSTVALUE then
      begin
      if FImage.Canvas.Pen.Style<>psSolid then FImage.Canvas.Pen.Style :=psSolid;
      if FDrillStandHeigh<>FIRSTVALUE then
         aSitY:=TOPLINEVOFF+round(abs(FDrillStandHeigh-FDrillTop-FFinishDepth)*aRate)
      else
         aSitY:=TOPLINEVOFF+round(FFinishDepth*aRate);
      FImage.Canvas.Pen.Color:=MARKCOLOR;
      FImage.Canvas.MoveTo(aSitX,aSitY);
      FImage.Canvas.LineTo(aSHSitX,aSitY);
      FImage.Canvas.Pen.Color:=SHAPECOLOR;
      FImage.Canvas.TextOut(aSHSitX+5,aSitY-5,'完成深度:'+FormatFloat('0.00',FFinishDepth));
      FImage.Canvas.MoveTo(aSitX,aSHSitY);
      FImage.Canvas.LineTo(aSitX,aSitY);
      FImage.Canvas.MoveTo(aSHSitX,aSHSitY);
      FImage.Canvas.LineTo(aSHSitX,aSitY);
      end;

   if FImage.Canvas.Pen.Style<>psSolid then FImage.Canvas.Pen.Style :=psSolid;
   FImage.Canvas.Font.Color :=SHAPECOLOR;
   FImage.Canvas.Brush.Style:=bsSolid;
end;

procedure TDrillDiagram.SetPubVar;
begin
if (FImage.Height<=TOPLINEVOFF) or (FImage.Width<=TBLINEHROFF) then
   begin
   if FImage.Height<=TOPLINEVOFF then FImage.Height:=TOPLINEVOFF+100;
   if FImage.Width<=TBLINEHROFF then FImage.Width:=TBLINEHROFF+100;
   end;
m_AxisLine:=FImage.Width DIV 2 - AXISLINEOFF;
m_RegionPixelHeigh:=FImage.Height-BOTTOMLINEVOFF-TOPLINEVOFF;
end;

procedure TDrillDiagram.SetTopBottom(aTop,aBottom:double;isForceSet:boolean=false);
var
   aTmp:double;
begin
   if isForceSet then
      begin
      FDrillTop:=aTop;
      FDrillBottom:=aBottom;
      end
   else
      begin
      if aTop<aBottom then
         begin
         aTmp:=aTop;
         aTop:=aBottom;
         aBottom:=aTmp;
         end;
      if FDrillTop<aTop then FDrillTop:=aTop;
      if FDrillBottom>aBottom then FDrillBottom:=aBottom;
      end;
   DrawDrillDiagram(false);
end;

procedure TDrillDiagram.Clear;
begin
   FDrillTop:=CDRILLTOP;
   FDrillBottom:=CDRILLBOTTOM;
   FDrillStandHeigh:=FIRSTVALUE;
   FDrillX:=FIRSTVALUE;
   FDrillY:=FIRSTVALUE;
   FFirstWaterHeigh:=FIRSTVALUE;
   FStableWaterHeigh:=FIRSTVALUE;
   FPipeDiameter:=FIRSTVALUE;
   FPlanDepth:=FIRSTVALUE;
   FFinishDepth:=FIRSTVALUE;
   if FStratumList<>nil then FStratumList:=nil;
   FStratumList:=TStringlist.Create;
   if FBMList<>nil then FBMList:=nil;
   FBMList:=TList.Create ;
end;

end.
