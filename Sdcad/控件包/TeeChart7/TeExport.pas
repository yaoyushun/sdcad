{**********************************************}
{   TeeChart Export Dialog - Inherited         }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeExport;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeExport, TeeProcs, TeCanvas;

type
  TTeeExportForm = class(TTeeExportFormBase)
    Splitter1: TSplitter;
  private
    { Private declarations }
    {$IFNDEF CLX}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}
  protected
    Function CreateData:TTeeExportData; override;
    Procedure DoSaveNativeToFile( Const FileName:String;
                                  IncludeData:Boolean); override;
    Function ExistData:Boolean; override;
    Function CreateNativeStream:TStream; override;
    Procedure PrepareOnShow; override;
  public
    { Public declarations }
  end;

{ Show the Export dialog }
{ example: TeeExport(Self,Chart1); }
Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel);

{ Show the Save dialog and save to AFormat export format }
{ example: TeeSavePanel(TGIFExportFormat,Chart1); }
Procedure TeeSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);

{ starts the MAPI (eg: Outlook) application with an empty new email
  message with the attachment file "FileName" }
Procedure TeeEmailFile(Const FileName:String; Const Subject:String='TeeChart');

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeConst, TeeStore, TeEngine, Chart;

Procedure TeeExport(AOwner:TComponent; APanel:TCustomTeePanel);
begin
  With TTeeExportForm.Create(AOwner) do
  try
    ExportPanel:=APanel;
    ShowModal;
  finally
    Free;
  end;
end;

Procedure TeeSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);
begin
  TeeExportSavePanel(AFormat,APanel);
end;

Procedure TeeEmailFile(Const FileName:String; Const Subject:String='TeeChart');
begin
  InternalTeeEmailFile(FileName,Subject);
end;

{ TTeeExportForm }

function TTeeExportForm.CreateData: TTeeExportData;

  Function SelectedSeries:TChartSeries;
  begin
    result:=TChartSeries(CBSeries.Items.Objects[CBSeries.ItemIndex]);
  end;

  function Chart: TCustomChart;
  begin
    result:=TCustomChart(ExportPanel);
  end;

begin
  Case RGText.ItemIndex of
    0: begin
         result:=TSeriesDataText.Create(Chart,SelectedSeries);
         TSeriesDataText(result).TextDelimiter:=GetSeparator;
         TSeriesDataText(result).TextQuotes:=EQuotes.Text; // 7.0
       end;
    1: result:=TSeriesDataXML.Create(Chart,SelectedSeries);
    2: result:=TSeriesDataHTML.Create(Chart,SelectedSeries);
  else
    result:=TSeriesDataXLS.Create(Chart,SelectedSeries);
  end;

  // Configure options
  With TSeriesData(result) do
  begin
    IncludeLabels:=CBLabels.Checked;
    IncludeIndex :=CBIndex.Checked;
    IncludeHeader:=CBHeader.Checked;
    IncludeColors:=CBColors.Checked;
  end;
end;

function TTeeExportForm.ExistData: Boolean;
begin
  result:=(ExportPanel is TCustomAxisPanel) and
          (TCustomAxisPanel(ExportPanel).SeriesCount>0);
end;

Procedure TTeeExportForm.DoSaveNativeToFile( Const FileName:String;
                                             IncludeData:Boolean);
begin
  SaveChartToFile(TCustomChart(ExportPanel),FileName,
                  IncludeData,NativeAsText);
end;

Procedure TTeeExportForm.PrepareOnShow;
begin
  FillSeriesItems(CBSeries.Items,TCustomAxisPanel(ExportPanel).SeriesList);
  CBSeries.Items.Insert(0,TeeMsg_All);
  CBSeries.ItemIndex:=0;
end;

Function TTeeExportForm.CreateNativeStream:TStream;
begin
  result:=TMemoryStream.Create;
  SaveChartToStream(TCustomChart(ExportPanel),result,
                    CBNativeData.Checked,NativeAsText);
end;

{$IFNDEF CLX}
procedure TTeeExportForm.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(Parent) then
     Parent.UpdateControlState;
end;
{$ENDIF}

end.
