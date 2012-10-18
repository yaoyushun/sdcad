{******************************************}
{   TeeChart Surface Series Nearest Tool   }
{ Copyright (c) 2003-2004 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeSurfaceTool;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeeTools, TeCanvas, TeEngine, Chart, TeeSurfa;

type
  TSurfaceNearestTool=class(TTeeCustomToolSeries)
  private
    FCell   : TColor;
    FColumn : TColor;
    FRow    : TColor;
    FOnSelect : TNotifyEvent;
    procedure SetCell(const Value: TColor);
    procedure SetColumn(const Value: TColor);
    procedure SetRow(const Value: TColor);
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    SelectedCell : Integer;

    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    Procedure GetRowCol(var Row,Col:Double);
  published
    property CellColor:TColor read FCell write SetCell default clRed;
    property ColumnColor:TColor read FColumn write SetColumn default clGreen;
    property RowColor:TColor read FRow write SetRow default clBlue;
    property Series;

    property OnSelectCell:TNotifyEvent read FOnSelect write FOnSelect;
  end;

  TSurfaceNearest = class(TForm)
    ButtonColor1: TButtonColor;
    ButtonColor2: TButtonColor;
    ButtonColor3: TButtonColor;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    CBSeries: TComboBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure ButtonColor2Click(Sender: TObject);
    procedure ButtonColor3Click(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
  private
    { Private declarations }
    Tool : TSurfaceNearestTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeProCo;

{ TSurfaceNearestTool }
Constructor TSurfaceNearestTool.Create(AOwner: TComponent);
begin
  inherited;
  FColumn:=clGreen;
  FRow:=clBlue;
  FCell:=clRed;
  SelectedCell:=-1;
end;

class function TSurfaceNearestTool.Description: String;
begin
  result:=TeeMsg_SurfaceNearestTool;
end;

class function TSurfaceNearestTool.GetEditorClass: String;
begin
  result:='TSurfaceNearest';
end;

procedure TSurfaceNearestTool.SetSeries(const Value: TChartSeries);
begin
  if Value is TSurfaceSeries then inherited
                             else inherited SetSeries(nil);
end;

Procedure TSurfaceNearestTool.GetRowCol(var Row,Col:Double);
var tmpO : TCellsOrientation;
begin
  if SelectedCell=-1 then
  begin
    Row:=-1;
    Col:=-1;
  end
  else
  with TSurfaceSeries(Series) do
  begin
    tmpO:=CellsOrientation;
    Row:=XValues.Value[SelectedCell];
    if tmpO.IncX=1 then Row:=Row-1;
    Col:=ZValues.Value[SelectedCell];
    if tmpO.IncZ=-1 then Col:=Col+1;
  end;
end;

procedure TSurfaceNearestTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp,t : Integer;
    tmpRow,tmpCol : Double;
begin
  if (AEvent=cmeMove) and Assigned(Series) then
  begin
    tmp:=Series.Clicked(x,y);

    if tmp<>SelectedCell then
    begin
      SelectedCell:=tmp;

      Series.ParentChart.AutoRepaint:=False;

      with TCustom3DSeries(Series) do
        if SelectedCell=-1 then
           for t:=0 to Count-1 do
               ValueColor[t]:=clTeeColor
        else
        begin
          GetRowCol(tmpRow,tmpCol);

          for t:=0 to Count-1 do
            if (XValues.Value[t]=tmpRow) and (ZValues.Value[t]=tmpCol) then
               ValueColor[t]:=CellColor
            else
            if XValues.Value[t]=tmpRow then
               ValueColor[t]:=RowColor
            else
            if ZValues.Value[t]=tmpCol then
               ValueColor[t]:=ColumnColor
            else
               ValueColor[t]:=clTeeColor;
        end;

      Series.ParentChart.AutoRepaint:=True;
      Series.ParentChart.Invalidate;

      if Assigned(FOnSelect) then FOnSelect(Self);
    end;
  end;
end;

procedure TSurfaceNearestTool.SetColumn(const Value: TColor);
begin
  SetColorProperty(FColumn,Value);
end;

procedure TSurfaceNearestTool.SetRow(const Value: TColor);
begin
  SetColorProperty(FRow,Value);
end;

procedure TSurfaceNearestTool.SetCell(const Value: TColor);
begin
  SetColorProperty(FCell,Value);
end;

procedure TSurfaceNearest.CheckBox1Click(Sender: TObject);
begin
  Tool.CellColor:=clTeeColor;
  ButtonColor1.Invalidate;
end;

procedure TSurfaceNearest.FormShow(Sender: TObject);

  Procedure FillSeries(AItems:TStrings);
  var t : Integer;
  begin
    With Tool.ParentChart do
    for t:=0 to SeriesCount-1 do
    if Series[t] is TSurfaceSeries then
        AItems.AddObject(SeriesTitleOrName(Series[t]),Series[t]);
  end;

begin
  Tool:=TSurfaceNearestTool({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(Tool) then
  begin
    FillSeries(CBSeries.Items);
    CBSeries.Enabled:=Tool.ParentChart.SeriesCount>0;
    CBSeries.ItemIndex:=CBSeries.Items.IndexOfObject(Tool.Series);

    ButtonColor1.LinkProperty(Tool,'CellColor');
    ButtonColor2.LinkProperty(Tool,'RowColor');
    ButtonColor3.LinkProperty(Tool,'ColumnColor');

    CheckBox1.Checked:=Tool.CellColor=clTeeColor;
    CheckBox2.Checked:=Tool.RowColor=clTeeColor;
    CheckBox3.Checked:=Tool.ColumnColor=clTeeColor;

    CheckBox4.Checked:=Tool.CellColor=clNone;
    CheckBox5.Checked:=Tool.RowColor=clNone;
    CheckBox6.Checked:=Tool.ColumnColor=clNone;
  end;

  Label1.Caption:=TeeMsg_GallerySurface;
end;

procedure TSurfaceNearest.CheckBox2Click(Sender: TObject);
begin
  Tool.RowColor:=clTeeColor;
  ButtonColor2.Invalidate;
end;

procedure TSurfaceNearest.CheckBox3Click(Sender: TObject);
begin
  Tool.ColumnColor:=clTeeColor;
  ButtonColor3.Invalidate;
end;

procedure TSurfaceNearest.ButtonColor1Click(Sender: TObject);
begin
  CheckBox1.Checked:=False;
end;

procedure TSurfaceNearest.ButtonColor2Click(Sender: TObject);
begin
  CheckBox2.Checked:=False;
end;

procedure TSurfaceNearest.ButtonColor3Click(Sender: TObject);
begin
  CheckBox3.Checked:=False;
end;

procedure TSurfaceNearest.CBSeriesChange(Sender: TObject);
begin
  if CBSeries.ItemIndex=-1 then
     Tool.Series:=nil
  else
     Tool.Series:=TChartSeries(CBSeries.Items.Objects[CBSeries.ItemIndex]);
end;

procedure TSurfaceNearest.CheckBox4Click(Sender: TObject);
begin
  Tool.CellColor:=clNone;
end;

procedure TSurfaceNearest.CheckBox5Click(Sender: TObject);
begin
  Tool.RowColor:=clNone;
end;

procedure TSurfaceNearest.CheckBox6Click(Sender: TObject);
begin
  Tool.ColumnColor:=clNone;
end;

initialization
  RegisterClass(TSurfaceNearest);
  RegisterTeeTools([TSurfaceNearestTool]);
finalization
  UnRegisterTeeTools([TSurfaceNearestTool]);
end.
