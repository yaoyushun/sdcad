{*****************************************}
{  TeeChart Pro                           }
{  Copyright (c) 1996-2004 David Berneda  }
{                                         }
{  Component Registration Unit            }
{                                         }
{ Funcs:   TCountTeeFunction              }
{          TCurveFittingTeeFunction       }
{          TAverageTeeFunction            }
{          TMovingAverageTeeFunction      }
{          TExpMovAveFunction             }
{          TExpAverageTeeFunction         }
{          TMomentumTeeFunction           }
{          TRSITeeFunction                }
{          TStdDeviationTeeFunction       }
{          TMACDFunction                  }
{          TRootMeanSquareFunction        }
{          TCumulative                    }
{          TCompressFunction              }
{          TCrossPointsFunction           }
{          TSmoothPointsFunction          }
{          TCLVFunction                   }
{          TOBVFunction                   }
{          TPVOFunction                   }
{                                         }
{ Series:  TCandleSeries                  }
{          TVolumeSeries                  }
{          TSurfaceSeries                 }
{          TContourSeries                 }
{          TWaterFallSeries               }
{          TErrorBarSeries                }
{          TPolarSeries                   }
{          TBezierSeries                  }
{          TPoint3DSeries                 }
{          TDonutSeries                   }
{          TBoxPlotSeries                 }
{          THistogramSeries               }
{          TSmithSeries                   }
{          TPyramidSeries                 }
{          TMapSeries                     }
{          TPointFigureSeries             }
{          TGaugeSeries                   }
{          TTowerSeries                   }
{          TVector3DSeries                }
{                                         }
{ Tools:   TCursorTool                    }
{          TDragMarksTool                 }
{          TDrawLineTool                  }
{          THintsTool                     }
{          TRotateTool                    }
{          TAxisArrowTool                 }
{          TColorLineTool                 }
{          TColorBandTool                 }
{          TImageTool                     }
{          TPageNumTool                   }
{          TDragPointTool                 }
{          TExtraLegendTool               }
{          TSeriesAnimationTool           }
{          TGanttTool                     }
{          TGridBandTool                  }
{          TPieTool                       }
{          TLightTool                     }
{          TLegendScrollBar               }
{          TSurfaceNearestTool            }
{          TSelectorTool                  }
{          TClipSeriesTool                }
{          TSeriesBandTool                }
{                                         }
{ Other:   TDraw3D                        }
{          TTeeCommander                  }
{          TChartEditor                   }
{          TChartPreviewer                }
{          TChartScrollBar                }
{          TChartListBox                  }
{          TSeriesDataSet*                }
{          TChartGalleryPanel             }
{          TTeePreviewPanel               }
{          TChartGrid                     }
{          TChartGridNavigator            }
{          TChartPageNavigator            }
{          TChartWebSource                }
{          TSeriesTextSource              }
{          TTeeInspector                  }
{          Alternate Gallery              }
{                                         }
{ Sample Series:                          }
{          TMyPointSeries                 }
{          TBar3DSeries                   }
{          TBigCandleSeries               }
{          TImagePointSeries              }
{          TDeltaPoint                    }
{          TImageBarSeries                }
{          TWindRoseSeries                }
{          TClockSeries                   }
{          TBarJoinSeries                 }
{          TCalendarSeries                }
{                                         }
{ TeeChart Actions (not for Delphi 3)     }
{          *Many*                         }
{                                         }
{ * TSeriesDataSet not available in       }
{   STANDARD versions of Delphi/CBuilder  }
{                                         }
{*****************************************}
unit TeeChartPro;
{$I TeeDefs.inc}

interface

procedure Register;

Procedure TeeSetLanguage(English:Boolean);

implementation

{$IFDEF CLR}
{.$DEFINE TEENOSERIESDESIGN}
{$ENDIF}

{$IFDEF CLX}
{$DEFINE TEENOSERIESDESIGN}
{$ENDIF}

{$IFDEF BCB}
{$DEFINE TEENOSERIESDESIGN}
{$ENDIF}

Uses Classes, SysUtils,
     {$IFDEF CLX}
     DesignIntf, DesignEditors,
     QControls, QGraphics, QDialogs, QActnList, QForms,
     {$ELSE}
      {$IFDEF D6}
       {$IFDEF CLR}
       {$IFDEF TEEEDITORS}
       Borland.VCL.Design.DesignEditors, Borland.VCL.Design.DesignIntf,
       {$ENDIF}
       {$ELSE}
       DesignIntf,
       DesignEditors,
       {$ENDIF}
      {$ELSE}
      DsgnIntf,
      {$ENDIF}
     Controls, Graphics, Dialogs, ActnList, Forms,
     {$ENDIF}

     {$IFNDEF TEENOSERIESDESIGN}
     TeeSeriesDesign,
     {$ENDIF}

     TeeTranslate,
     { Languages }
     TeeSpanish,
     TeeGerman,
     TeeCatalan,
     TeeFrench,
     TeeDanish,
     TeeDutch,
     TeeChinese,
     TeeChineseSimp,
     TeeBrazil,
     TeeSwedish,
     TeePortuguese,
     TeeRussian,
     TeeSlovene,
     TeeNorwegian,
     TeeJapanese,
     TeePolish,
     TeeTurkish,
     TeeHungarian,
     TeeItalian,
     TeeArabic,
     TeeHebrew,
     TeeUkrainian,
     TeeKorean,
     TeeIndonesian,
     TeeGalician,
     TeeFinnish,
     TeeSlovak,
     TeeHellenic,
     TeeRomanian,
     TeeSerbian,
     TeeFarsi,
     TeeCzech,
     TeeHindi,
     TeeUrdu,

     CandleCh, CurvFitt, ErrorBar, TeeErrBarEd, TeeSurfa, TeeNavigator,
     TeeSurfEdit, TeePolar, TeePolarEditor, TeeCandlEdi, StatChar,
     TeEngine, Chart, TeeProcs, TeeChartReg, TeeEditPro, TeeConst, TeeProCo,
     TeeBezie, TeePoin3, TeCanvas, TeeScroB, TeeEdit, TeeComma, TeeVolEd,
     TeeLisB, TeeEdiGene, TeeInspector, TeeCount, TeeCumu, TeeDonut,
     TeeTools, TeeTriSurface, TeeDragPoint, TeeGalleryPanel, TeePrevi,
     TeePreviewPanel, TeePreviewPanelEditor, MyPoint, Bar3D, BigCandl,
     ImaPoint, ImageBar, TeeImaEd, TeeRose, TeeChartGrid, TeeBoxPlot,
     TeeDraw3D, TeeURL, TeeSeriesTextEd, TeeMapSeries, TeeChartActions,
     TeeSmith, TeeCalendar, TeeCompressOHLC, TeeExtraLegendTool,
     TeeCLVFunction, TeeOBVFunction, TeeSeriesAnimEdit,
     TeePointFigure, TeeGanttTool, 

     {$IFNDEF LINUX}
     TeeXML,
     {$ENDIF}

     {$IFDEF CLR}
     TeeJpeg, TeePNG, TeeGIF, TeeSVGCanvas, TeePSCanvas, TeeVMLCanvas,
     TeePDFCanvas,
     {$ENDIF}

     TeeGridBandToolEdit, TeeGaugeEditor, TeeTowerEdit, TeePieTool,
     TeeLighting, 

     {$IFNDEF TEENOTHEMES}
     TeeThemes, TeeThemeEditor, 
     {$ENDIF}

     TeeDesignOptions,
     TeeLegendScrollBar, TeeSurfaceTool, TeeSelectorTool, TeeEditCha;


{$IFDEF CLR}
{$R 'TeeEdit.TChartEditor.bmp'}
{$R 'TeeEdit.TChartEditorPanel.bmp'}
{$R 'TeeGalleryPanel.TChartGalleryPanel.bmp'}
{$R 'TeeChartGrid.TChartGrid.bmp'}
{$R 'TeeChartGrid.TChartGridNavigator.bmp'}
{$R 'TTeeInspector.bmp'}
{$ENDIF}

{$IFDEF TEEEDITORS}
type
  TChartEditorCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

  TPreviewPanelCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb( Index : Integer ); override;
    function GetVerbCount : Integer; override;
    function GetVerb( Index : Integer ) : string; override;
  end;

{ TChartEditorCompEditor }
procedure TChartEditorCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then TCustomChartEditor(Component).Execute
             else inherited;
end;

function TChartEditorCompEditor.GetVerbCount : Integer;
begin
  Result := inherited GetVerbCount+1;
end;

function TChartEditorCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Test
             else result:=inherited GetVerb(Index);
end;

{ TPreviewPanelCompEditor }
procedure TPreviewPanelCompEditor.ExecuteVerb( Index : Integer );
begin
  if Index=0 then
  With TFormPreviewPanelEditor.CreatePanel(nil,TTeePreviewPanel(Component)) do
  try
    ShowModal;
  finally
    Free;
  end
  else inherited;
end;

function TPreviewPanelCompEditor.GetVerbCount : Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TPreviewPanelCompEditor.GetVerb( Index : Integer ) : string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;

type
  TTeeCustomToolAxisProperty = class(TPropertyEditor)
  public
    function GetAttributes : TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TTeeCustomToolAxisProperty }
function TTeeCustomToolAxisProperty.GetAttributes: TPropertyAttributes;
begin
  result:=[paValueList,paMultiSelect,paRevertable]
end;

function TTeeCustomToolAxisProperty.GetValue: string;
begin
  With TTeeCustomToolAxis(GetComponent(0)) do
       result:=TCustomChart(ParentChart).AxisTitleOrName(Axis);
end;

procedure TTeeCustomToolAxisProperty.GetValues(Proc: TGetStrProc);
begin
  inherited;
  Proc(TeeMsg_LeftAxis);
  Proc(TeeMsg_RightAxis);
  Proc(TeeMsg_TopAxis);
  Proc(TeeMsg_BottomAxis);
end;

procedure TTeeCustomToolAxisProperty.SetValue(const Value: string);

  procedure SetAxis(Axis:TChartAxis);
  begin
    {$IFDEF CLR}
    SetObjValue(Axis);
    {$ELSE}
    SetOrdValue(Integer(Axis));
    {$ENDIF}
  end;

var tmp : TCustomAxisPanel;
begin
  tmp:=TTeeCustomToolAxis(GetComponent(0)).ParentChart;

  if Value=TeeMsg_LeftAxis then SetAxis(tmp.LeftAxis)
  else
  if Value=TeeMsg_RightAxis then SetAxis(tmp.RightAxis)
  else
  if Value=TeeMsg_TopAxis then SetAxis(tmp.TopAxis)
  else
  if Value=TeeMsg_BottomAxis then SetAxis(tmp.BottomAxis)
end;

type
  TChartWebCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer); override;
    function GetVerb(Index:Integer):string; override;
    function GetVerbCount:Integer; override;
  end;

{ TChartWebCompEditor }
procedure TChartWebCompEditor.ExecuteVerb(Index:Integer);
begin
  if Index=0 then
  begin
    Screen.Cursor:=crHourGlass;
    try
      TChartWebSource(Component).Execute;
    finally
      Screen.Cursor:=crDefault;
    end;
  end
  else inherited;
end;

function TChartWebCompEditor.GetVerbCount:Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TChartWebCompEditor.GetVerb(Index:Integer):string;
begin
  if Index=0 then result:=TeeMsg_Load
             else result:=inherited GetVerb(Index);
end;

type
  TSeriesTextCompEditor=class(TComponentEditor)
  public
    procedure ExecuteVerb(Index:Integer); override;
    function GetVerb(Index:Integer):string; override;
    function GetVerbCount:Integer; override;
  end;

{ TSeriesTextCompEditor }
procedure TSeriesTextCompEditor.ExecuteVerb(Index:Integer);
begin
  if Index=0 then
  begin
    TeeEditSeriesTextSource(TSeriesTextSource(Component));
    Designer.Modified;
  end
  else inherited;
end;

function TSeriesTextCompEditor.GetVerbCount:Integer;
begin
  Result:=inherited GetVerbCount+1;
end;

function TSeriesTextCompEditor.GetVerb(Index:Integer):string;
begin
  if Index=0 then result:=TeeMsg_Edit
             else result:=inherited GetVerb(Index);
end;
{$ENDIF}

Procedure TeeSetLanguage(English:Boolean);
begin
  Case TeeLanguageRegistry of
    1: TeeSetBrazil;
    2: TeeSetCatalan;
    3: TeeSetChineseSimp;
    4: TeeSetChinese;
    5: TeeSetDanish;
    6: TeeSetDutch;
    7: TeeSetFrench;
    8: TeeSetGerman;
    9: TeeSetItalian;
   10: TeeSetPortuguese;
   11: TeeSetRussian;
   12: TeeSetSpanish;
   13: TeeSetSwedish;
   14: TeeSetNorwegian;
   15: TeeSetJapanese;
   16: TeeSetPolish;
   17: TeeSetSlovene;
   18: TeeSetTurkish;
   19: TeeSetHungarian;
   20: TeeSetGalician;
   21: TeeSetArabic;
   22: TeeSetHebrew;
   23: TeeSetUkrainian;
   24: TeeSetKorean;
   25: TeeSetIndonesian;
   26: TeeSetFinnish;
   27: TeeSetSlovak;
   28: TeeSetHellenic;
   29: TeeSetRomanian;
   30: TeeSetSerbian;
   31: TeeSetFarsi;
   32: TeeSetCzech;
   33: TeeSetHindi;
   34: TeeSetUrdu;
  else
    if English then TeeSetEnglish;
  end;
end;

procedure Register;
begin
  { Pro Components }
  RegisterComponents(TeeMsg_TeeChartPalette, [ TChartEditor,
                                               TChartPreviewer,
                                               TDraw3D,
                                               TChartScrollBar,
                                               TTeeCommander,
                                               TChartListBox,
                                               TChartEditorPanel,
                                               TChartGalleryPanel,
                                               TTeePreviewPanel,
                                               TChartGrid,
                                               TChartGridNavigator,
                                               TChartPageNavigator,
                                               TChartWebSource,
                                               TTeeInspector,
                                               {$IFNDEF LINUX}
                                               {$IFNDEF CLR}
                                               TTeeXMLSource,
                                               {$ENDIF}
                                               {$ENDIF}
                                               TSeriesTextSource
                                             ]);

  { Pro Editors }

  {$IFDEF TEEEDITORS}
  RegisterComponentEditor(  TChartEditor,TChartEditorCompEditor);
  RegisterComponentEditor(  TChartPreviewer,TChartEditorCompEditor);
  RegisterComponentEditor(  TTeePreviewPanel,TPreviewPanelCompEditor);
  RegisterComponentEditor(  TChartWebSource,TChartWebCompEditor);
  RegisterComponentEditor(  TSeriesTextSource,TSeriesTextCompEditor);
  RegisterPropertyEditor(TypeInfo(TChartAxis), TTeeCustomToolAxis, '',TTeeCustomToolAxisProperty);
  {$ENDIF}
  
  { Chart Actions }
  {$IFDEF CLX}
  {$IFDEF BCB}
  {$DEFINE TEENOACTIONS}  // BCB6 CLX bug when registering actions.
  {$ENDIF}
  {$ENDIF}

  {$IFNDEF TEENOACTIONS}
  RegisterActions(TeeMsg_CategoryChartActions,
                  [ TChartAction3D,TChartActionEdit,
                    TChartActionCopy,TChartActionPrint,
                    TChartActionAxes,TChartActionGrid,
                    TChartActionLegend,
                    TChartActionSave ],nil);

  { Series Actions }
  RegisterActions(TeeMsg_CategorySeriesActions,
                  [ TSeriesActionActive,TSeriesActionEdit,
                    TSeriesActionMarks ], nil);
  {$ENDIF}
  
  TeeSetLanguage(False);
end;

Function TeeNewChartProc(Chart:TCustomChart):TChartThemeClass;
begin
  {$IFNDEF TEENOTHEMES}
  if (TeeNewChartTheme<>0) and (ChartThemes.Count>TeeNewChartTheme) then
  begin
    result:=TChartThemeClass(ChartThemes[TeeNewChartTheme]);
    ApplyChartTheme(result,Chart,-1);
  end
  else
  {$ENDIF} 
    result:=nil;
end;

{$IFNDEF TEELITE}
Procedure TeeOptionsFormHook;
begin
  with TOptionsForm.Create(nil) do
  try
    if ShowModal=mrOk then 
       TeeSetLanguage(True);
  finally
    Free;
  end;
end;
{$ENDIF}

initialization
  {$IFNDEF TEENOSERIESDESIGN}
  TeeChartEditorHook:=TeeShowSeriesEditor;
  {$ENDIF}

  TeeNewChartTheme:=TeeReadIntegerOption(TeeMsg_DefaultTheme,0);
  TeeNewChartHook:=TeeNewChartProc;

  {$IFNDEF TEELITE}
  TeeDesignOptionsHook:=TeeOptionsFormHook;
  {$ENDIF}

finalization
  // un-hook
  TeeNewChartHook:=nil;
  TeeChartEditorHook:=nil;    // For TeeChartReg "Series..." menu item

  {$IFNDEF TEELITE}
  TeeDesignOptionsHook:=nil;  // For TeeChartReg "Options..." menu item
  {$ENDIF}

  if TeeLanguage<>TeeEnglishLanguage then // Reset language
     TeeSetEnglish;
end.
