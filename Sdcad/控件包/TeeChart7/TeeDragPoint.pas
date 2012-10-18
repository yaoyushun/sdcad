{******************************************}
{ TDragPointTool and Editor Dialog         }
{ Copyright (c) 2000-2004 by David Berneda }
{******************************************}
unit TeeDragPoint;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Windows,
     Classes,
     Borland.VCL.Controls,
     Borland.VCL.StdCtrls,
     Borland.VCL.ExtCtrls,
     {$ELSE}
     {$IFDEF LINUX}
     Libc,
     {$ELSE}
     {$IFNDEF CLX}
     Windows, Messages,
     {$ENDIF}
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$ENDIF}
     TeeToolSeriesEdit, TeEngine, TeeTools, TeCanvas;


{ DragPoint: A TeeChart Tool example.

  This tool component can be used to allow the end-user to
  drag points of any Chart Series by using the mouse.

  This unit also includes a Form that is used as the editor dialog
  for the tool. This form automatically shows at the Tools tab of the
  TeeChart editor.

  Installation / use:

  1) Add this unit to a project or to a design-time package.

  2) Then, edit a Chart1 and go to "Tools" tab and Add a DragPoint tool.

  3) Set the tool Series property to a existing series (eg: Series1 ).

  4) Fill the series with points as usually.

  5) At run-time, use the left mouse button to click and drag a
     Series point.

}

type
  { The Tool editor dialog }
  TDragPointToolEdit = class(TSeriesToolEditor)
    RGStyle: TRadioGroup;
    Label2: TLabel;
    CBCursor: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDragPointTool=class;

  TDragPointToolEvent=procedure(Sender:TDragPointTool; Index:Integer) of object;

  TDragPointStyle=(dsX,dsY,dsBoth);

  { Drag Point Tool }
  TDragPointTool=class(TTeeCustomToolSeries)
  private
    FDragStyle: TDragPointStyle;
    FOnDrag   : TDragPointToolEvent;

    IDragging : Integer;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
  published
    property Active;
    property DragStyle:TDragPointStyle read FDragStyle write FDragStyle
                                       default dsBoth;
    property Series;
    { events }
    property OnDragPoint:TDragPointToolEvent read FOnDrag write FOnDrag;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses Chart, TeeProCo, TeePenDlg;

{ TDragPointTool }
Constructor TDragPointTool.Create(AOwner: TComponent);
begin
  inherited;
  IDragging:=-1;
  FDragStyle:=dsBoth;
end;

{ When the user clicks or moves the mouse... }
procedure TDragPointTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Function CheckAxisLimits(Axis:TChartAxis; Position:Integer):Double;
  begin
    with Axis do
    if Maximum=Minimum then
    begin
      AutomaticMaximum:=False;
      Maximum:=Maximum+0.1*MinAxisIncrement; // 6.02, fix when values are equal
    end;

    result:=Axis.CalcPosPoint(Position);
  end;

begin
  if Assigned(Series) then
  Case AEvent of
      cmeUp: IDragging:=-1;  { stop dragging on mouse up  }

    cmeMove: if IDragging<>-1 then { if dragging... }
             With Series do
             begin
               BeginUpdate;

               { Change the Series point X and / or Y values... }
               if (Self.DragStyle=dsX) or (Self.DragStyle=dsBoth) then
                  XValue[IDragging]:=CheckAxisLimits(GetHorizAxis,x);

               if (Self.DragStyle=dsY) or (Self.DragStyle=dsBoth) then
                  YValue[IDragging]:=CheckAxisLimits(GetVertAxis,y);

               EndUpdate;

               { Notify the point values change... }
               if Assigned(FOnDrag) then FOnDrag(Self,IDragging);
             end;

    cmeDown: begin { when the mouse button is pressed... }
               IDragging:=Series.Clicked(x,y);

               { if clicked a Series point... }
               if IDragging<>-1 then ParentChart.CancelMouse:=True;
             end;
  end;
end;

class function TDragPointTool.Description: String;
begin
  result:=TeeMsg_DragPoint;
end;

class function TDragPointTool.GetEditorClass: String;
begin
  result:='TDragPointToolEdit';  { the editor dialog class name }
end;

procedure TDragPointToolEdit.FormShow(Sender: TObject);
var tmpCursor : TCursor;
begin
  inherited;

  tmpCursor:=crDefault;

  CBCursor.Enabled:=False;

  if Assigned(Tool) then
  begin
    Case TDragPointTool(Tool).DragStyle of
      dsX : RGStyle.ItemIndex:=0;
      dsY : RGStyle.ItemIndex:=1;
    else
      RGStyle.ItemIndex:=2;
    end;

    if Assigned(Tool.Series) then
    begin
      tmpCursor:=Tool.Series.Cursor;
      CBCursor.Enabled:=True;
    end;
  end;

  TeeFillCursors(CBCursor,tmpCursor);
end;

procedure TDragPointToolEdit.RGStyleClick(Sender: TObject);
begin
  With TDragPointTool(Tool) do
  Case RGStyle.ItemIndex of
    0: DragStyle:=dsX;
    1: DragStyle:=dsY;
  else
     DragStyle:=dsBoth;
  end;
end;

{ register both the tool and the tool editor dialog form }
procedure TDragPointToolEdit.CBSeriesChange(Sender: TObject);
begin
  inherited;
  CBCursor.Enabled:=Assigned(Tool.Series);
end;

procedure TDragPointToolEdit.CBCursorChange(Sender: TObject);
begin
  with Tool.Series do
       Cursor:=TeeSetCursor(Cursor,CBCursor.Items[CBCursor.ItemIndex]);
end;

initialization
  RegisterClass(TDragPointToolEdit);
  RegisterTeeTools([TDragPointTool]);
finalization
  { un-register the tool }
  UnRegisterTeeTools([TDragPointTool]);
end.
