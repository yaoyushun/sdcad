{********************************************}
{ TeeChart Pro Charting Library              }
{ Copyright (c) 1995-2004 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit EditChar;
{$I TeeDefs.inc}

interface

Uses Classes,
     {$IFDEF CLX}
     QGraphics, QForms,
     {$ELSE}
     Graphics, Forms,
     {$ENDIF}
     TeEngine, Chart, TeeEditCha;

Procedure EditChartLegend(Form:TForm; AChart:TCustomChart);
Procedure EditSeries(Form:TForm; ASeries:TChartSeries);
Procedure EditSeriesDataSource(Form:TForm; ASeries:TChartSeries);
Procedure EditSeriesMarks(Form:TForm; ASeries:TChartSeries; SymbolsTab:Boolean=False);
Procedure EditChart(Form:TForm; AChart:TCustomChart);
Procedure EditChartAxis(Form:TForm; Axis:TChartAxis);
Procedure EditChartWall(Form:TForm; AWall:TChartWall);
Procedure EditChartTitle(Form:TForm; ATitle:TChartTitle);
Procedure EditChartPage(Form:TForm; AChart:TCustomChart; PageIndex:Integer);
Procedure EditChartPart(Form:TForm; AChart:TCustomChart; Const Part:TChartClickedPart);
Procedure EditDSSChart(AOwner:TComponent; ADSSChart:TCustomChart);
Procedure EditChartTool(Form:TForm; AChartTool:TTeeCustomTool);

implementation

Uses TeeProcs, TeeConst, TeeCustEdit, TeeAreaEdit, TeeBarEdit, TeePieEdit,
     TeeFLineEdi, TeeShapeEdi, TeeCustomFuncEditor, TeeAvgFuncEditor,
     {$IFNDEF TEEOCXSTD}
     TeeGanttEdi, TeeArrowEdi, BubbleCh, TeeBubbleEdit,
     {$ENDIF}
     TeeBrushDlg,
     {$IFDEF CLX}
     QStdCtrls,
     {$ELSE}
     StdCtrls,
     {$ENDIF}
     {$IFNDEF TEELITE}
     TeeEditTools, 
     {$ENDIF}
     TeeEdiSeri;

Function GetChartEditClass(AChart:TCustomAxisPanel):TChartEditForm;
begin
  result:=TChartEditForm.Create({$IFDEF CLX}nil{$ELSE}Application{$ENDIF});
  result.Chart:=TCustomChart(AChart);
  result.CheckHelpFile;
  TeeTranslateControl(result);
end;

Procedure EditSeries(Form:TForm; ASeries:TChartSeries);
begin
  With GetChartEditClass(ASeries.ParentChart) do
  try
    TheEditSeries:=ASeries;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditSeriesMarks(Form:TForm; ASeries:TChartSeries; SymbolsTab:Boolean=False);
begin
  With GetChartEditClass(ASeries.ParentChart) do
  try
    TheEditSeries:=ASeries;
    MainPage.ActivePage:=TabSeries;
    SetTabSeries;

    With TheFormSeries do
    begin
      PageSeries.ActivePage:=TabMarks;
      PageSeriesChange(nil);

      if SymbolsTab then
         PageControlMarks.ActivePage:=TabSymbol;
    end;

    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditSeriesDataSource(Form:TForm; ASeries:TChartSeries);
begin
  With GetChartEditClass(ASeries.ParentChart) do
  try
    TheEditSeries:=ASeries;
    MainPage.ActivePage:=TabSeries;
    SetTabSeries;

    With TheFormSeries do
    begin
      PageSeries.ActivePage:=TabDataSource;
      PageSeriesChange(nil);
    end;

    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChartPage(Form:TForm; AChart:TCustomChart; PageIndex:Integer);
begin
  With GetChartEditClass(AChart) do
  try
    TheActivePageIndex:=PageIndex;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChartTitle(Form:TForm; ATitle:TChartTitle);
Begin
  With GetChartEditClass(TCustomChart(ATitle.ParentChart)) do
  try
    TheTitle:=ATitle;
    TheActivePageIndex:=teeEditTitlePage;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChartWall(Form:TForm; AWall:TChartWall);
Begin
  With GetChartEditClass(TCustomChart(AWall.ParentChart)) do
  try
    TheWall:=AWall;
    TheActivePageIndex:=teeEditWallsPage;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChartAxis(Form:TForm; Axis:TChartAxis);
Begin
  With GetChartEditClass(Axis.ParentChart) do
  try
    TheAxis:=Axis;
    TheActivePageIndex:=teeEditAxisPage;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditDSSChart(AOwner:TComponent; ADSSChart:TCustomChart);
begin
  With GetChartEditClass(ADSSChart) do
  try
    IsDssGraph:=True;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChartTool(Form:TForm; AChartTool:TTeeCustomTool);
begin
  With GetChartEditClass(AChartTool.ParentChart) do
  try
    TheTool:=AChartTool;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure EditChart(Form:TForm; AChart:TCustomChart);
Begin
  EditChartPage(Form,AChart,teeEditMainPage);
end;

Procedure EditChartLegend(Form:TForm; AChart:TCustomChart);
begin
  EditChartPage(Form,AChart,teeEditLegendPage);
end;

Procedure EditChartPart(Form:TForm; AChart:TCustomChart; Const Part:TChartClickedPart);
begin
  case Part.Part of
    cpLegend   : EditChartLegend(Form,AChart);
    cpAxis     : EditChartAxis(Form,Part.AAxis);
    cpSeries   : EditSeries(Form,Part.ASeries);
  cpSeriesMarks: EditSeriesMarks(Form,Part.ASeries);
    cpTitle    : EditChartTitle(Form,AChart.Title);
    cpFoot     : EditChartTitle(Form,AChart.Foot);
    cpSubTitle : EditChartTitle(Form,AChart.SubTitle);
    cpSubFoot  : EditChartTitle(Form,AChart.SubFoot);
  else
    EditChart(Form,AChart);
  end;
end;

end.
