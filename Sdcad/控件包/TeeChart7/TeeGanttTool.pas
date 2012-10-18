{**********************************************}
{   TeeChart Gantt Series Mouse Tool           }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeeGanttTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages, 
  {$ENDIF}
  SysUtils, Classes, 
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  TeEngine, TeCanvas, TeeTools, GanttCh, Chart, TeeToolSeriesEdit;

type
  TGanttToolBarPart = (pbStart,pbAll,pbEnd);

  TGanttTool=class;

  TGanttDragEvent=procedure(Sender:TGanttTool; GanttBar:Integer) of object;
  TGanttResizeEvent=procedure(Sender:TGanttTool; GanttBar:Integer;
                              BarPart:TGanttToolBarPart) of object;

  TGanttTool=class(TTeeCustomToolSeries)
  private
    FAllowDrag    : Boolean;
    FAllowResize  : Boolean;
    FBar          : Integer;
    FBarPart      : TGanttToolBarPart;
    FCursorDrag   : TCursor;
    FCursorResize : TCursor;
    FMinPixels    : Integer;
    FXOriginal    : Double;

    FOnDragBar   : TGanttDragEvent;
    FOnResizeBar : TGanttResizeEvent;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    Function Gantt:TGanttSeries;
  published
    property AllowDrag:Boolean read FAllowDrag write FAllowDrag default True;
    property AllowResize:Boolean read FAllowResize write FAllowResize default True;
    property CursorDrag:TCursor read FCursorDrag write FCursorDrag default crHandPoint;
    property CursorResize:TCursor read FCursorResize write FCursorResize default crSizeWE;
    property MinPixels:Integer read FMinPixels write FMinPixels default 5;
    property OnDragBar:TGanttDragEvent read FOnDragBar write FOnDragBar;
    property OnResizeBar:TGanttResizeEvent read FOnResizeBar write FOnResizeBar;
  end;

  TGanttToolEditor = class(TSeriesToolEditor)
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    CBAllowDrag: TCheckBox;
    CBAllowResize: TCheckBox;
    Label3: TLabel;
    CBCursorDrag: TComboFlat;
    Label4: TLabel;
    CBCursorResize: TComboFlat;
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBAllowDragClick(Sender: TObject);
    procedure CBAllowResizeClick(Sender: TObject);
    procedure CBCursorDragChange(Sender: TObject);
    procedure CBCursorResizeChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses TeeProCo, TeePenDlg;

{ TGanttTool }
constructor TGanttTool.Create(AOwner: TComponent);
begin
  inherited;
  FBar:=-1;
  FMinPixels:=5;
  FCursorDrag:=crHandPoint;
  FCursorResize:=crSizeWE;
  FAllowDrag:=True;
  FAllowResize:=True;
end;

procedure TGanttTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Procedure MouseDown;
  var t    : Integer;
      tmp  : Integer;
      tmp1 : Integer;
      tmp2 : Integer;
      Half : Integer;
  begin
    FBar:=-1;
    FXOriginal:=Gantt.GetHorizAxis.CalcPosPoint(X);  // 7.0 fix

    if AllowResize then
    begin
      Half:=Gantt.Pointer.VertSize div 2;

      // Check bar under mouse ( to resize at start or end )
      for t:=0 to Gantt.Count-1 do
      begin
        tmp:=Gantt.GetVertAxis.CalcPosValue(Gantt.YValues[t]);

        if (Y>=tmp-Half) and (Y<=tmp+Half) then
        begin
          tmp1:=Gantt.GetHorizAxis.CalcPosValue(Gantt.StartValues[t]);
          tmp2:=Gantt.GetHorizAxis.CalcPosValue(Gantt.EndValues[t]);

          if Abs(X-tmp1)<MinPixels then
          begin
            FBar:=t;
            FBarPart:=pbStart;
            break;
          end
          else
          if Abs(X-tmp2)<MinPixels then
          begin
            FBar:=t;
            FBarPart:=pbEnd;
            break;
          end;
        end;
      end;
    end;

    // Check bar under mouse (to drag)
    if (FBar=-1) and AllowDrag then
    begin
      FBar:=Gantt.Clicked(x,y);
      if FBar<>-1 then FBarPart:=pbAll;
    end;

  end;

  Procedure MouseMove;
  var t      : Integer;
      tmp    : Integer;
      Half   : Integer;
      Change : Double;
  begin
    if FBar=-1 then
    begin

      if AllowResize then
      begin
        Half:=Gantt.Pointer.VertSize div 2;

        for t:=0 to Gantt.Count-1 do
        begin
          tmp:=Gantt.GetVertAxis.CalcPosValue(Gantt.YValues[t]);

          if (Y>=tmp-Half) and (Y<=tmp+Half) then
          begin

            tmp:=Gantt.GetHorizAxis.CalcPosValue(Gantt.StartValues[t]);

            if Abs(X-tmp)<MinPixels then
            begin
              ParentChart.Cursor:=FCursorResize;
              ParentChart.CancelMouse:=True;
              break;
            end
            else
            begin
              tmp:=Gantt.GetHorizAxis.CalcPosValue(Gantt.EndValues[t]);

              if Abs(tmp-X)<FMinPixels then
              begin
                ParentChart.Cursor:=FCursorResize;
                ParentChart.CancelMouse:=True;
                break;
              end;

            end;
          end;
        end;
      end;

      if AllowDrag and (FBar=-1) and (Gantt.Clicked(x,y)<>-1) then
      begin
        ParentChart.Cursor:=FCursorDrag;
        ParentChart.CancelMouse:=True;
      end;

    end
    else  // Dragging bar...
    begin
      Change:=Gantt.GetHorizAxis.CalcPosPoint(X)-FXOriginal;

      Case FBarPart of
        pbAll: begin
                  // drag bar
                  with Gantt.StartValues do Value[FBar]:=Value[FBar]+Change;
                  with Gantt.EndValues do Value[FBar]:=Value[FBar]+Change;

                  if Assigned(FOnDragBar) then FOnDragBar(Self,FBar);
                end;
       pbStart: begin
                  // resize bar at start
                  with Gantt.StartValues do Value[FBar]:=Value[FBar]+Change;
                  // limit
                  if Gantt.StartValues[FBar]>Gantt.EndValues[FBar] then
                     Gantt.StartValues[FBar]:=Gantt.EndValues[FBar];

                  if Assigned(FOnResizeBar) then
                     FOnResizeBar(Self,FBar,pbStart);
                end;
       pbEnd:   begin
                  // resize bar at end
                  with Gantt.EndValues do Value[FBar]:=Value[FBar]+Change;
                  // limit
                  if Gantt.EndValues[FBar]<Gantt.StartValues[FBar] then
                     Gantt.EndValues[FBar]:=Gantt.StartValues[FBar];

                  if Assigned(FOnResizeBar) then
                     FOnResizeBar(Self,FBar,pbEnd); // 6.01
                end;
      end;

      FXOriginal:=Gantt.GetHorizAxis.CalcPosPoint(X);

      Gantt.Repaint;
    end;
  end;

begin
  if Gantt<>nil then
  Case AEvent of
      cmeUp: FBar:=-1;
    cmeMove: MouseMove;
    cmeDown: MouseDown;
  end;
end;

function TGanttTool.Gantt: TGanttSeries;
begin
  if Assigned(Series) and (Series is TGanttSeries) then
     result:=TGanttSeries(Series)
  else
     result:=nil;
end;

class function TGanttTool.Description: String;
begin
  result:=TeeMsg_GanttTool;
end;

class function TGanttTool.GetEditorClass: String;
begin
  result:='TGanttToolEditor';
end;

procedure TGanttToolEditor.Edit1Change(Sender: TObject);
begin
  if not CreatingForm then
    TGanttTool(Tool).MinPixels:=UpDown1.Position;
end;

procedure TGanttToolEditor.FormShow(Sender: TObject);
var t : Integer;
begin
  inherited;

  // Remove Series of not type Gantt from combo:
  with CBSeries do
  begin
    t:=0;
    while t<Items.Count do
      if not (TChartSeries(Items.Objects[t]) is TGanttSeries) then
         Items.Delete(t)
      else
         Inc(t);
  end;

  if Assigned(Tool) then 
  with TGanttTool(Tool) do
  begin
    UpDown1.Position:=MinPixels;
    CBAllowDrag.Checked:=AllowDrag;
    CBAllowResize.Checked:=AllowResize;
    TeeFillCursors(CBCursorDrag,CursorDrag);
    TeeFillCursors(CBCursorResize,CursorResize);
  end;

  CreatingForm:=False;
end;

procedure TGanttToolEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CreatingForm:=True;
end;

procedure TGanttToolEditor.CBAllowDragClick(Sender: TObject);
begin
  TGanttTool(Tool).AllowDrag:=CBAllowDrag.Checked;
end;

procedure TGanttToolEditor.CBAllowResizeClick(Sender: TObject);
begin
  TGanttTool(Tool).AllowResize:=CBAllowResize.Checked;
end;

procedure TGanttToolEditor.CBCursorDragChange(Sender: TObject);
begin
  with TGanttTool(Tool) do
       CursorDrag:=TeeSetCursor(CursorDrag,CBCursorDrag.Items[CBCursorDrag.ItemIndex]);
end;

procedure TGanttToolEditor.CBCursorResizeChange(Sender: TObject);
begin
  with TGanttTool(Tool) do
       CursorResize:=TeeSetCursor(CursorResize,CBCursorResize.Items[CBCursorResize.ItemIndex]);
end;

initialization
  RegisterClass(TGanttToolEditor);
  RegisterTeeTools([TGanttTool]);
finalization
  UnRegisterTeeTools([TGanttTool]);
end.
