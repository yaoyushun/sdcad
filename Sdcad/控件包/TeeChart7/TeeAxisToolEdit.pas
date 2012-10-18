{******************************************}
{ TTeeCustomToolAxis Editor Dialog         }
{ Copyright (c) 1999-2004 by David Berneda }
{******************************************}
unit TeeAxisToolEdit;
{$I TeeDefs.inc}

interface

Uses SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeePenDlg, TeCanvas, TeeProcs, TeEngine;

type
  TAxisToolEditor = class(TForm)
    BPen: TButtonPen;
    CBAxis: TComboFlat;
    Label1: TLabel;
    PanelTop: TPanel;
    procedure FormShow(Sender: TObject);
    procedure CBAxisChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function DepthAxesOffset:Integer;
  protected
    AxisTool : TTeeCustomToolAxis;
    IncludeDepthAxes : Boolean;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeEdiAxis, TypInfo;

Function TAxisToolEditor.DepthAxesOffset:Integer;
begin
  if IncludeDepthAxes then result:=0
                      else result:=2;
end;

procedure TAxisToolEditor.FormShow(Sender: TObject);
begin
  AxisTool:=TTeeCustomToolAxis(Tag);

  if Assigned(AxisTool) then
  begin
    TeeAddAxes(AxisTool.ParentChart,CBAxis.Items,IncludeDepthAxes);

    With AxisTool do
    begin
      BPen.LinkPen(Pen);

      With ParentChart,CBAxis do
      if Axis=LeftAxis then ItemIndex:=0 else
      if Axis=RightAxis then ItemIndex:=1 else
      if Axis=TopAxis then ItemIndex:=2 else
      if Axis=BottomAxis then ItemIndex:=3 else
         ItemIndex:=Axes.IndexOf(Axis)-DepthAxesOffset;
    end;

    {$IFDEF D5}
    if not IsPublishedProp(AxisTool,'Pen') then // do not localize
       BPen.Hide;    // <--- Bug, this does not work, Button is not hidden
    {$ENDIF}
  end;
end;

procedure TAxisToolEditor.CBAxisChange(Sender: TObject);
begin
  With AxisTool do
  Case CBAxis.ItemIndex of
    -1: Axis:=nil;
     0: Axis:=ParentChart.LeftAxis;
     1: Axis:=ParentChart.RightAxis;
     2: Axis:=ParentChart.TopAxis;
     3: Axis:=ParentChart.BottomAxis;
  else
    Axis:=ParentChart.Axes[CBAxis.ItemIndex+DepthAxesOffset];
  end;
end;

procedure TAxisToolEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
  IncludeDepthAxes:=False;
end;

initialization
  RegisterClass(TAxisToolEditor);
end.
