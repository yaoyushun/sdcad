{**********************************************}
{   TeeChart Selector Tool                     }
{   Copyright (c) 2001 by David Berneda        }
{**********************************************}
unit TeeSelectorTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, 
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls, Types,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  {$ENDIF}
  TeEngine, Chart, TeeTools, TeCanvas, TeePenDlg;

type
  TSelectorTool=class(TTeeCustomTool)
  private
    FAllowDrag  : Boolean;
    FAllowResizeChart: Boolean;
    FHandleSize : Integer;
    FOnDragged  : TNotifyEvent;
    FOnDragging : TNotifyEvent;
    FOnResized  : TNotifyEvent;
    FOnResizing : TNotifyEvent;
    FOnSelected : TNotifyEvent;

    { internal }
    FAnnotation : TAnnotationTool;
    FDrawHandles: Boolean;
    FShape      : TTeeCustomShapePosition;
    FWall       : TChartWall;

    IDragging      : Boolean;
    IDragged       : Boolean;
    IDif           : TPoint;
    IResizingChart : Boolean;
    IResized       : Boolean;

    Procedure EmptySelection;
    function GetSeries: TChartSeries;
    procedure SetHandleSize(const Value: Integer);
    procedure SetAnnotation(const Value: TAnnotationTool);
    procedure SetWall(const Value: TChartWall);
    procedure SetSeries(const Value: TChartSeries);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure DoSelected; virtual;
    class Function GetEditorClass:String; override;
  public
    Part: TChartClickedPart;
    Constructor Create(AOwner:TComponent); override;

    Procedure ClearSelection;
    Procedure StopDragging;
    Function ClickedCorner(X,Y:Integer):Boolean;
    class Function Description:String; override;
    Function SelectedTitle:TChartTitle;

    property Annotation : TAnnotationTool read FAnnotation write SetAnnotation;
    property DraggingShape: TTeeCustomShapePosition read FShape;
    property DrawHandles:Boolean read FDrawHandles write FDrawHandles;
    property Series:TChartSeries read GetSeries write SetSeries;
    property Wall: TChartWall read FWall write SetWall;
  published
    property Active;
    property AllowDrag:Boolean read FAllowDrag write FAllowDrag default True;
    property AllowResizeChart:Boolean read FAllowResizeChart write FAllowResizeChart default False;
    property Brush;
    property HandleSize:Integer read FHandleSize write SetHandleSize default 3;
    property Pen;

    property OnDragged:TNotifyEvent read FOnDragged write FOnDragged;
    property OnDragging:TNotifyEvent read FOnDragging write FOnDragging;
    property OnResized:TNotifyEvent read FOnResized write FOnResized;
    property OnResizing:TNotifyEvent read FOnResizing write FOnResizing;
    property OnSelected:TNotifyEvent read FOnSelected write FOnSelected;
  end;

  { Form Editor }
  TSelectorToolEditor = class(TForm)
    ButtonPen1: TButtonPen;
    Label1: TLabel;
    Edit1: TEdit;
    UDSize: TUpDown;
    ButtonColor1: TButtonColor;
    CBAllowDrag: TCheckBox;
    CBResizeChart: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CBAllowDragClick(Sender: TObject);
    procedure CBResizeChartClick(Sender: TObject);
  private
    { Private declarations }
    Selector : TSelectorTool;
  public
    { Public declarations }
  end;

Const TeeMsg_SelectorTool='Selector';

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{ TSelectorTool }
Constructor TSelectorTool.Create(AOwner: TComponent);
begin
  inherited;
  FHandleSize:=3;
  FDrawHandles:=True;
  FAllowDrag:=True;
end;

type TAxisAccess=class(TChartAxis);

procedure TSelectorTool.ChartEvent(AEvent: TChartToolEvent);

  Function RectFromPoint(X,Y:Integer):TRect;
  begin { return a rectangle few pixels around XY point }
    result:=TeeRect(X-HandleSize,Y-HandleSize,X+HandleSize,Y+HandleSize);
  end;

  Procedure DrawHandle(Const R:TRect);
  begin { draw four handles, one at each R rectangle corner }
    with ParentChart.Canvas, R do
    begin
      Rectangle(RectFromPoint(Left,Top));
      Rectangle(RectFromPoint(Left,Bottom));
      Rectangle(RectFromPoint(Right,Top));
      Rectangle(RectFromPoint(Right,Bottom));
    end;
  end;

  Procedure DrawHandleZ(Const R:TRect; Z:Integer);
  begin { draw the four handles of R corners at Z depth position }
    with ParentChart.Canvas, R do
    begin
      RectangleWithZ(RectFromPoint(Left,Top),Z);
      RectangleWithZ(RectFromPoint(Left,Bottom),Z);
      RectangleWithZ(RectFromPoint(Right,Top),Z);
      RectangleWithZ(RectFromPoint(Right,Bottom),Z);
    end;
  end;

  Procedure DoDrawHandles;

    Procedure DrawSeriesHandles(AtMarks:Boolean);
    var t: Integer;
        X: Integer;
        Y: Integer;
        tmpStep  : Integer;
        tmpLast  : Integer;
        tmpCount : Integer;
    begin
      if Assigned(Part.ASeries) then
      With Part.ASeries do
      begin
        { number of visible points }
        tmpCount:=LastValueIndex-FirstValueIndex;

        { if zero, then number of points }
        if tmpCount=0 then tmpCount:=Count;

        { calculate "step" (how many points? maximum=20) }
        if tmpCount>20 then tmpStep:=tmpCount div 20
                       else tmpStep:=1;

        { start loop to draw handles }
        t:=FirstValueIndex;
        if t=-1 then t:=0;

        { last loop value }
        tmpLast:=LastValueIndex;
        if tmpLast=-1 then tmpLast:=Count-1;

        { loop... }
        While t<=tmpLast do
        begin
          if AtMarks then
             DrawHandleZ(Marks.Positions[t].Bounds,Marks.ZPosition)
          else
          begin
            X:=CalcXPos(t);
            Y:=CalcYPos(t);
            ParentChart.Canvas.RectangleWithZ(RectFromPoint(X,Y),MiddleZ);
          end;
          Inc(t,tmpStep);
        end;
      end;
    end;

    Procedure DrawBackWallHandles;

      Procedure DrawHandlePoint(AX,AY:Integer);
      var P: TPoint;
      begin
        with ParentChart,Canvas do
        begin
          P:=Calculate3DPosition(AX,AY,Width3D);
          Rectangle(RectFromPoint(P.X,P.Y));
        end;
      end;

    begin
      with ParentChart.ChartRect do
      begin
        DrawHandlePoint(Left,Top);
        DrawHandlePoint(Right,Top);
        DrawHandlePoint(Left,Bottom);
        DrawHandlePoint(Right,Bottom);
      end;
    end;

  var R: TRect;
  begin
    R:=TeeRect(0,0,0,0);

    { calculate R corners of selected part }
    With TCustomChart(ParentChart) do
    Case Part.Part of
      cpNone    : begin R:=ClientRect; InflateRect(R,-HandleSize,-HandleSize); end;
      cpLegend  : if Legend.Visible then
                     R:=Legend.ShapeBounds;
      cpAxis    : R:=TAxisAccess(Part.AAxis).AxisRect;
      cpSeries  : DrawSeriesHandles(False);
      cpTitle   : R:=Title.TitleRect;
      cpFoot    : R:=Foot.TitleRect;
      cpSubTitle: R:=SubTitle.TitleRect;
      cpSubFoot : R:=SubFoot.TitleRect;
     cpChartRect: DrawBackWallHandles;
   cpSeriesMarks: DrawSeriesHandles(True);
    end;

    { draw four handles at rectangle R corners }
    if R.Right-R.Left>0 then
       DrawHandle(R);
  end;

begin { after drawing Chart, draw handles on selected part }
  inherited;

  if (AEvent=cteAfterDraw) and (not ParentChart.Printing) and FDrawHandles then
  begin
    { prepare Handle pen and color }
    With ParentChart.Canvas do
    begin
      AssignVisiblePen(Self.Pen);
      AssignBrush(Self.Brush,Self.Brush.Color);
    end;

    { draw handles on selected Shape rectangle corners }
    if Assigned(FShape) then
       DrawHandle(FShape.ShapeBounds)
    else
       DoDrawHandles;
  end;
end;

Function TSelectorTool.ClickedCorner(X,Y:Integer):Boolean;
begin { return True if XY is over the chart right-bottom corner }
  result:=(Abs(X-ParentChart.Width)<=8) and
          (Abs(Y-ParentChart.Height)<=8)
          // and (ParentChart.Align=alNone);
end;

procedure TSelectorTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Procedure CalcClickedAnnotation;
  var t : Integer;
  begin { return which Annotation is under the mouse cursor }
    With ParentChart do
    for t:=0 to Tools.Count-1 do
    if Tools[t] is TAnnotationTool then
       if TAnnotationTool(Tools[t]).Clicked(X,Y) then
       begin
         Self.FAnnotation:=TAnnotationTool(Tools[t]);
         Self.FShape:=Self.FAnnotation.Shape;
         break;
       end;
  end;

begin
  inherited;
  if not (ssDouble in Shift) then
  Case AEvent of
    cmeDown: if Button=mbLeft then
             begin
               { check if XY is over the right-bottom corner }
               if AllowResizeChart and ClickedCorner(X,Y) then
               begin
                 IResizingChart:=True;
                 IResized:=False;
               end
               else
               begin
                 IResizingChart:=False;

                 EmptySelection;

                 { check if mouse XY is over an annotation }
                 CalcClickedAnnotation;

                 if not Assigned(FShape) then
                 begin
                   { calc clicked chart part }
                   TCustomChart(ParentChart).CalcClickedPart(TeePoint(X,Y),Part);

                   { if clicked part is a legend or a title ... }
                   if Part.Part=cpLegend then
                      FShape:=TCustomChart(ParentChart).Legend
                   else
                   if Part.Part=cpTitle then
                      FShape:=TCustomChart(ParentChart).Title
                   else
                   if Part.Part=cpSubTitle then
                      FShape:=TCustomChart(ParentChart).SubTitle
                   else
                   if Part.Part=cpFoot then
                      FShape:=TCustomChart(ParentChart).Foot
                   else
                   if Part.Part=cpSubFoot then
                      FShape:=TCustomChart(ParentChart).SubFoot
                   else
                   if Part.Part=cpChartRect then
                      { select back wall }
                      FWall:=TCustomChart(ParentChart).BackWall;
                 end;

                 { call OnSelected event }
                 DoSelected;

                 // ParentChart.CancelMouse:=True; <-- check Legend checkboxes !

                 { start dragging if selection is a Shape or Annotation }
                 IDragging:=AllowDrag and Assigned(FShape);
                 if IDragging then
                 begin
                   IDif.X:=FShape.Left-X;
                   IDif.Y:=FShape.Top-Y;
                   IDragged:=False;
                 end;
               end;
             end;

    cmeMove: if IDragging and Assigned(FShape) then
             begin
               { check X position change }
               if FShape.Left<>(X+IDif.X) then
               begin
                 if IDragged or (Abs(FShape.Left-(X+IDif.X))>2) then
                 begin
                   FShape.Left:=X+IDif.X;
                   IDragged:=True;
                 end;
               end;

               { check Y position change }
               if FShape.Top<>(Y+IDif.Y) then
               begin
                 if IDragged or (Abs(FShape.Top-(Y+IDif.Y))>2) then
                 begin
                   FShape.Top :=Y+IDif.Y;
                   IDragged:=True;
                 end;
               end;

               { call OnDragging event }
               if Assigned(FOnDragging) then FOnDragging(Self);

             end
             else
             if IResizingChart then
             begin
               with ParentChart do if Align<>alNone then Align:=alNone;

               with ParentChart do
               begin
                 if Width<>X then Width:=X;
                 if Height<>Y then Height:=Y;
               end;

               IResized:=True;
               { call OnResizing event }
               if Assigned(FOnResizing) then
                  FOnResizing(Self);
             end;

      cmeUp: begin
               { finish dragging / resizing }
               if IDragged and Assigned(FOnDragged) then
                  FOnDragged(Self);
               if IResized and Assigned(FOnResized) then
                  FOnResized(Self);
               StopDragging;
             end;
  end;
end;

Procedure TSelectorTool.DoSelected;
begin
  Repaint;
  if Assigned(OnSelected) then OnSelected(Self);
end;

class function TSelectorTool.Description: String;
begin
  result:=TeeMsg_SelectorTool;
end;

class function TSelectorTool.GetEditorClass: String;
begin
  result:='TSelectorToolEditor';
end;

procedure TSelectorTool.SetHandleSize(const Value: Integer);
begin
  if FHandleSize<>Value then
  begin
    FHandleSize:=Value;
    Repaint;
  end;
end;

procedure TSelectorTool.SetAnnotation(const Value: TAnnotationTool);
begin
  if (Part.Part<>cpNone) or (FAnnotation<>Value) then
  begin
    EmptySelection;
    FAnnotation:=Value;
    if Assigned(FAnnotation) then
       FShape:=FAnnotation.Shape
    else
       FShape:=nil;
    Part.Part:=cpNone;
    DoSelected;
  end;
end;

function TSelectorTool.SelectedTitle: TChartTitle;
begin
  with TCustomChart(ParentChart) do
  Case Part.Part of
    cpTitle    : result:=Title;
    cpFoot     : result:=Foot;
    cpSubTitle : result:=SubTitle;
    cpSubFoot  : result:=SubFoot;
  else
    result:=nil;
  end;
end;

Procedure TSelectorTool.ClearSelection;
begin { remove selection }
  if (Part.Part<>cpNone) or
     (Assigned(FAnnotation) or Assigned(FShape) or Assigned(FWall)) then
  begin
    EmptySelection;
    DoSelected;
  end;
end;

Procedure TSelectorTool.EmptySelection;
begin
  Part.Part:=cpNone;
  Part.ASeries:=nil;
  Part.AAxis:=nil;
  FAnnotation:=nil;
  FShape:=nil;
  FWall:=nil;
end;

procedure TSelectorTool.StopDragging;
begin
  IDragging:=False;
  IDragged:=False;
  IResizingChart:=False;
  IResized:=False;
end;

procedure TSelectorTool.SetWall(const Value: TChartWall);
begin
  if (Part.Part<>cpNone) or (FWall<>Value) then
  begin
    EmptySelection;
    Part.Part:=cpNone;
    FWall:=Value;
    if Assigned(FWall) and (FWall=TCustomChart(ParentChart).BackWall) then
       Part.Part:=cpChartRect;
    DoSelected;
  end;
end;

function TSelectorTool.GetSeries: TChartSeries;
begin
  result:=Part.ASeries;
end;

procedure TSelectorTool.SetSeries(const Value: TChartSeries);
begin
  if (Part.Part<>cpSeries) or (Part.ASeries<>Value) then
  begin
    EmptySelection;
    { select Series }
    Part.Part:=cpSeries;
    Part.ASeries:=Value;
    Part.PointIndex:=-1;
    DoSelected;
  end;
end;

{ SelectorToolEditor }
procedure TSelectorToolEditor.FormShow(Sender: TObject);
begin
  Selector:=TSelectorTool(Tag);

  if Assigned(Selector) then
  with Selector do
  begin
    ButtonPen1.LinkPen(Pen);
    ButtonColor1.LinkProperty(Brush,'Color');
    UDSize.Position:=HandleSize;
    CBAllowDrag.Checked:=AllowDrag;
    CBResizeChart.Checked:=AllowResizeChart;
  end;
end;

procedure TSelectorToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing and Assigned(Selector) then
     Selector.HandleSize:=UDSize.Position;
end;

procedure TSelectorToolEditor.CBAllowDragClick(Sender: TObject);
begin
  Selector.AllowDrag:=CBAllowDrag.Checked;
end;

procedure TSelectorToolEditor.CBResizeChartClick(Sender: TObject);
begin
  Selector.AllowResizeChart:=CBResizeChart.Checked;
end;

initialization
  RegisterClass(TSelectorToolEditor);
  RegisterTeeTools([TSelectorTool]);
finalization
  UnRegisterTeeTools([TSelectorTool]);
end.
