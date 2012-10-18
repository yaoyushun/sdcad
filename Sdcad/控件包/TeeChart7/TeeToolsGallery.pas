{******************************************}
{ TeeChart Tools Gallery                   }
{ Copyright (c) 2000-2004 by David Berneda }
{******************************************}
unit TeeToolsGallery;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, Types, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeEngine, Chart, TeCanvas, TeePenDlg;

type
  TTeeToolsGallery = class(TForm)
    P1: TPanel;
    Panel1: TPanel;
    BOk: TButtonColor;
    BCan: TButtonColor;
    TabControl1: TTabControl;
    LBTool: TListBox;
    procedure FormShow(Sender: TObject);
    procedure LBToolDblClick(Sender: TObject);
    {$IFNDEF CLX}
    procedure LBToolDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ELSE}
    procedure LBToolDrawItem(Sender: TObject; Index: Integer; Rect: TRect;
      State: TOwnerDrawState; var Handled: Boolean);
    {$ENDIF}
    procedure TabControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure FillTools;
    Function ToolAtIndex(AIndex:Integer):TTeeCustomToolClass;
  public
    { Public declarations }
    Function SelectedTool:TTeeCustomToolClass;
  end;

procedure TeeDrawTool(AList:TListBox;
                      Index: Integer; Rect: TRect; State: TOwnerDrawState;
                      ATool:TTeeCustomTool);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
{$R 'TAxisArrowTool.bmp'}
{$R 'TColorBandTool.bmp'}
{$R 'TColorLineTool.bmp'}
{$R 'TCursorTool.bmp'}
{$R 'TDragMarksTool.bmp'}
{$R 'TDrawLineTool.bmp'}
{$R 'TNearestTool.bmp'}
{$R 'TRotateTool.bmp'}
{$R 'TChartImageTool.bmp'}
{$R 'TMarksTipTool.bmp'}
{$R 'TDragPointTool.bmp'}
{$R 'TAnnotationTool.bmp'}
{$R 'TPageNumTool.bmp'}
{$R 'TAxisDividerTool.bmp'}
{$R 'TSelectorTool.bmp'}
{$R 'TExtraLegendTool.bmp'}
{$R 'TGridTransposeTool.bmp'}
{$R 'TGanttTool.bmp'}
{$R 'TSeriesAnimationTool.bmp'}
{$R 'TGridBandTool.bmp'}
{$R 'TPieTool.bmp'}
{$R 'TLightTool.bmp'}
{$R 'TLegendScrollBar.bmp'}
{$R 'TSurfaceNearestTool.bmp'}
{$R 'TAxisScrollTool.bmp'}
{$R 'TSeriesBandTool.bmp'}
{$R 'TClipSeriesTool.bmp'}
{$ELSE}
{$R TeeTools.res}
{$ENDIF}

Uses TeeProcs, TeeConst;

type TToolSeriesClass=class of TTeeCustomToolSeries;

procedure TTeeToolsGallery.FillTools;

  Function FilterTool(Index:Integer):Boolean;
  var tmp : TTeeCustomTool;
  begin
    tmp:=TeeToolTypes[Index].Create(nil);
    try
      case TabControl1.TabIndex of
        0: result:=tmp is TTeeCustomToolSeries;
        1: result:=tmp is TTeeCustomToolAxis;
        2: result:=(not (tmp is TTeeCustomToolSeries)) and
                   (not (tmp is TTeeCustomToolAxis));
      else
        result:=True;
      end;
    finally
      tmp.Free;
    end;
  end;

var t : Integer;
begin
  LBTool.Clear;
  for t:=0 to TeeToolTypes.Count-1 do
      if FilterTool(t) then
         LBTool.Items.AddObject(TeeToolTypes[t].Description,TObject(TeeToolTypes[t]));
end;

procedure TTeeToolsGallery.FormShow(Sender: TObject);
begin
  TabControl1.Tabs.Clear;
  TabControl1.Tabs.Add(TeeMsg_Series);
  TabControl1.Tabs.Add('Axis');  // <--- do not translate
  TabControl1.Tabs.Add(TeeMsg_PieOther);
  FillTools;
  TeeTranslateControl(Self);
end;

Function TTeeToolsGallery.SelectedTool:TTeeCustomToolClass;
begin
  result:=ToolAtIndex(LBTool.ItemIndex);
end;

procedure TTeeToolsGallery.LBToolDblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

Function TTeeToolsGallery.ToolAtIndex(AIndex:Integer):TTeeCustomToolClass;
begin
  result:=TTeeCustomToolClass(LBTool.Items.Objects[AIndex]);
end;

procedure TeeDrawTool(AList:TListBox;
  Index: Integer; Rect: TRect; State: TOwnerDrawState; ATool:TTeeCustomTool);
begin
  with AList.Canvas do
  begin
    {$IFDEF CLX}
    Brush.Style:=bsSolid;
    {$ENDIF}
    if odSelected in State then Brush.Color:=clHighLight
                           else Brush.Color:=AList.Color;
    {$IFDEF CLX}
    Inc(Rect.Top);
    {$ENDIF}
    FillRect(Rect);
    {$IFDEF CLX}
    Dec(Rect.Top);
    {$ENDIF}

    TeeDrawBitmapEditor(AList.Canvas,ATool,Rect.Left+2,Rect.Top+1);

    if odSelected in State then Font.Color:=clHighlightText
                           else Font.Color:=AList.Font.Color;
    Brush.Style:=bsClear;
    TextOut(Rect.Left+22,Rect.Top+2,AList.Items[Index]);
  end;
end;

{$IFNDEF CLX}
procedure TTeeToolsGallery.LBToolDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
procedure TTeeToolsGallery.LBToolDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ENDIF}
var tmpTool : TTeeCustomTool;
begin
  tmpTool:=ToolAtIndex(Index).Create(nil);
  try
    TeeDrawTool(LBTool,Index,Rect,State,tmpTool);
  finally
    tmpTool.Free;
  end;
end;

procedure TTeeToolsGallery.TabControl1Change(Sender: TObject);
begin
  FillTools;
end;

end.
