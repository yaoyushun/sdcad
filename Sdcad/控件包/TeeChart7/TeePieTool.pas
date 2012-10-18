{******************************************}
{   TeeChart Pie Series Tool               }
{ Copyright (c) 2001-2004 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeePieTool;
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
     TeeTools, TeCanvas, TeEngine, Chart, TeePenDlg;

type
  TPieToolStyle=(ptFocus,ptExplode);

  TPieTool=class(TTeeCustomToolSeries)
  private
    FStyle : TPieToolStyle;

    ISlice : Integer;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure FocusSlice(ValueIndex:Integer; Focused:Boolean);
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    property Slice:Integer read ISlice;
  published
    property Pen;
    property Series;
    property Style:TPieToolStyle read FStyle write FStyle default ptFocus;
  end;

  TPieToolEditor = class(TForm)
    Label1: TLabel;
    CBPieSeries: TComboBox;
    RGStyle: TRadioGroup;
    BPen: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure CBPieSeriesChange(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
  private
    { Private declarations }
    Tool : TPieTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeeProCo, Series;

{ TPieTool }
Constructor TPieTool.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=ptFocus;
  ISlice:=-1;
  Pen.Width:=4;
  Pen.Style:=psSolid;
end;

type TPieSeriesAccess=class(TPieSeries);

Procedure TPieTool.FocusSlice(ValueIndex:Integer; Focused:Boolean);
var PreviousSlice : Integer;
    t             : Integer;
    Delta         : Integer;
    tmpColor      : TColor;
begin
  if Style=ptExplode then
  begin
    if Focused then Delta:=1
               else Delta:=-1;
    for t:=1 to 20 do
    begin
      TPieSeries(Series).ExplodedSlice[ValueIndex]:=2*t*Delta;
      ParentChart.Repaint;
    end;
  end
  else
  begin
    if not Focused then ParentChart.Repaint
    else
    begin
      with Series.ParentChart.Canvas do
      begin
        Brush.Style:=bsClear;

        tmpColor:=Self.Pen.Color;
        if Series.ValueColor[ValueIndex]=Self.Pen.Color then
           if Self.Pen.Color=clBlack then tmpColor:=clWhite
                                     else tmpColor:=clBlack;

        AssignVisiblePenColor(Self.Pen,tmpColor);
      end;
      if ValueIndex=0 then PreviousSlice:=Series.Count-1
                      else PreviousSlice:=Pred(ValueIndex);

      with TPieSeriesAccess(Series) do
      begin
        AngleToPos(Angles[PreviousSlice].EndAngle,XRadius,YRadius,IniX,IniY);
        DrawPie(ValueIndex);
      end;
    end;
  end;
end;

procedure TPieTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp2 : Integer;
begin
  if (AEvent=cmeMove) and Assigned(Series) then
  begin
    tmp2:=Series.Clicked(X,Y);
    if ISlice<>tmp2 then
    begin
      if ISlice<>-1 then FocusSlice(ISlice,False);
      ISlice:=tmp2;
      if ISlice<>-1 then FocusSlice(ISlice,True);
    end;
  end;
end;

class function TPieTool.Description: String;
begin
  result:=TeeMsg_PieTool;
end;

class function TPieTool.GetEditorClass: String;
begin
  result:='TPieToolEditor';
end;

procedure TPieToolEditor.FormShow(Sender: TObject);

  Procedure FillPieSeries(AItems:TStrings);
  var t : Integer;
  begin
    With Tool.ParentChart do
    for t:=0 to SeriesCount-1 do
    if Series[t] is TPieSeries then
        AItems.AddObject(SeriesTitleOrName(Series[t]),Series[t]);
  end;

begin
  Tool:=TPieTool({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(Tool) then
  begin
    FillPieSeries(CBPieSeries.Items);
    CBPieSeries.Enabled:=Tool.ParentChart.SeriesCount>0;
    CBPieSeries.ItemIndex:=CBPieSeries.Items.IndexOfObject(Tool.Series);
    RGStyle.ItemIndex:=Ord(Tool.Style);
    BPen.LinkPen(Tool.Pen);
  end;

  Label1.Caption:=TeeMsg_GalleryPie;
end;

procedure TPieToolEditor.CBPieSeriesChange(Sender: TObject);
begin
  With CBPieSeries do
       Tool.Series:=TPieSeries(Items.Objects[ItemIndex]);
end;

procedure TPieToolEditor.RGStyleClick(Sender: TObject);
begin
  Tool.Style:=TPieToolStyle(RGStyle.ItemIndex);
end;

initialization
  RegisterClass(TPieToolEditor);
  RegisterTeeTools([TPieTool]);
finalization
  UnRegisterTeeTools([TPieTool]);
end.
