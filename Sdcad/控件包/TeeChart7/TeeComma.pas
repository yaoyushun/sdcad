{**********************************************}
{   TTeeCommander Component                    }
{   Copyright (c) 1998-2004 by David Berneda   }
{**********************************************}
unit TeeComma;
{$I TeeDefs.inc}

{$IFDEF TEEOCX}
{$I TeeAXDefs.inc}
{$ENDIF}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Buttons,
     {$ENDIF}

     TeeProcs, Series,
     {$IFNDEF TEEOCXSTD}
     TeeEdit,
     {$ENDIF}
     Chart;

type
  TCustomTeeCommander=class(TCustomPanelNoCaption,ITeeEventListener)
  private
    FMouseButton : TMouseButton;
    FPanel       : TCustomTeePanel;
    FVertical    : Boolean;

    Procedure ReAlignTeeControls;
    Procedure SetVertical(Value:Boolean);
  protected
    procedure TeeEvent(Event:TTeeEvent);
    Procedure DoMouseDown(X,Y:Integer); virtual;
    Procedure DoMouseMove(X,Y:Integer); virtual;
    Procedure DoMouseUp; virtual;
    Function DoPanelMouse:Boolean; virtual;
    Procedure FreeOwnedControls;
    procedure Loaded; override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    Procedure RemovingControl(AControl:TControl); dynamic;
    procedure SetPanel(Const Value: TCustomTeePanel); virtual;
    Function TeePanelClass:String;
    Procedure ShowHideControls(Value:Boolean); virtual;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure CreateBevel( APos:Integer);

    Function CreateButton( APos:Integer; AProc:TNotifyEvent;
                           Const AHint:String;
                           Const AResName:String;
                           AGroupIndex:Integer {$IFNDEF BCB}=0{$ENDIF}):TSpeedButton; {$IFNDEF BCB4}overload;{$ENDIF}

    {$IFNDEF BCB4}
    Function CreateButton( APos:Integer;
                           AProc:TNotifyEvent;
                           Const AHint:String;
                           ABitmap: TBitmap;
                           AGroupIndex:Integer {$IFNDEF BCB}=0{$ENDIF}):TSpeedButton; overload;
    {$ENDIF}

    Function CreateLabel(APos:Integer; AColor:TColor):TLabel;
  published
    { Published declarations }
    property Panel:TCustomTeePanel read FPanel write SetPanel;
    property Vertical:Boolean read FVertical write SetVertical default False;

    { TPanel properties }
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property Color;
    property DragMode;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint{$IFNDEF TEEOCX} default True{$ENDIF};
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    property Constraints;
    {$IFNDEF CLX}
    property AutoSize;
    property DragKind;
    {$ENDIF}

    { TPanel events }
    property OnClick;
    {$IFNDEF CLX}
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    {$ENDIF}
    property OnDblClick;
    {$IFNDEF CLX}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag; 
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnCanResize;
    {$IFNDEF TEEOCX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
    {$ENDIF}
  end;

  TeeCommanderControls=( tcbNormal,
                         tcbSeparator,
                         tcbRotate,
                         tcbMove,
                         tcbZoom,
                         tcbDepth,
                         tcbEdit,
                         tcbPrintPreview,
                         tcbCopy,
                         tcbSave,
                         tcbLabel,
                         tcb3D );

  TTeeCommander=class;
  TTeeEditedChartEvent=procedure(Sender:TTeeCommander; AChart:TCustomChart) of object;

  TTeeCommanderOnSetLabel=procedure(Sender:TTeeCommander; Var Text:String) of object;

  TTeeCommander=class(TCustomTeeCommander)
  private
    { Private declarations }
    FButtonCopy    : TSpeedButton;
    FButtonDepth   : TSpeedButton;
    FButtonEdit    : TSpeedButton;
    FButtonMove    : TSpeedButton;
    FButtonNormal  : TSpeedButton;
    FButtonPrint   : TSpeedButton;
    FButtonRotate  : TSpeedButton;
    FButtonSave    : TSpeedButton;
    FButtonZoom    : TSpeedButton;
    FButton3D      : TSpeedButton;

    {$IFNDEF TEEOCXNOEDITOR}
    FEditor        : TChartEditor;
    FPreviewer     : TChartPreviewer;
    {$ENDIF}

    FEnablePieExp  : Boolean;
    FLabel         : TLabel;
    FLabelValues   : Boolean;

    FDragging      : Boolean;
    FDraggingIndex : Integer;
    FOldX          : Integer;
    FOldY          : Integer;
    {$IFDEF CLX}
    IChanging3D    : Boolean;
    {$ENDIF}
    IPieSeries     : TPieSeries;  // 7.0

    FOnEditedChart : TTeeEditedChartEvent;
    FOnSetLabel    : TTeeCommanderOnSetLabel;

    procedure Button3DClick(Sender: TObject);
    procedure ButtonCopyClick(Sender: TObject);
    procedure ButtonDepthClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonMoveClick(Sender: TObject);
    procedure ButtonNormalClick(Sender: TObject);
    procedure ButtonPrintClick(Sender: TObject);
    procedure ButtonRotateClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonZoomClick(Sender: TObject);
    Function IsButtonDown(AButton:TSpeedButton):Boolean;
    procedure SetLabelCaption(Const ACaption:String);
    procedure SetLabelValues(Value:Boolean);
    Function CaptionPanel(Const ACaption:String):String;

    Function GetPieSeries(x,y:Integer):TPieSeries;

    {$IFNDEF TEEOCXNOEDITOR}
    procedure SetEditor(const Value: TChartEditor);
    procedure SetPreviewer(const Value: TChartPreviewer);
    {$ENDIF}

  protected
    { Protected declarations }
    Procedure DoMouseDown(X,Y:Integer); override;
    Procedure DoMouseMove(X,Y:Integer); override;
    Procedure DoMouseUp; override;
    Function DoPanelMouse:Boolean; override;
    Procedure RemovingControl(AControl:TControl); override;
    Procedure ShowHideControls(Value:Boolean); override;
    {$IFNDEF TEEOCXNOEDITOR}
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    {$ENDIF}
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;

    Procedure CreateControls(AControls:Array of TeeCommanderControls);
    Procedure RepositionControls;

    property Button3D      : TSpeedButton read FButton3D;
    property ButtonCopy    : TSpeedButton read FButtonCopy;
    property ButtonDepth   : TSpeedButton read FButtonDepth;
    property ButtonEdit    : TSpeedButton read FButtonEdit;
    property ButtonMove    : TSpeedButton read FButtonMove;
    property ButtonNormal  : TSpeedButton read FButtonNormal;
    property ButtonPrint   : TSpeedButton read FButtonPrint;
    property ButtonRotate  : TSpeedButton read FButtonRotate;
    property ButtonSave    : TSpeedButton read FButtonSave;
    property ButtonZoom    : TSpeedButton read FButtonZoom;

    property LabelText     : TLabel read FLabel;
    Procedure ShowValues;
  published
    {$IFNDEF TEEOCXNOEDITOR}
    property ChartEditor   : TChartEditor read FEditor write SetEditor;
    property Previewer     : TChartPreviewer read FPreviewer write SetPreviewer;
    {$ENDIF}

    property EnablePieExploding:Boolean read FEnablePieExp
                                        write FEnablePieExp default True;
    property LabelValues:Boolean read FLabelValues write SetLabelValues default True;
    property OnEditedChart:TTeeEditedChartEvent read FOnEditedChart
                                                write FOnEditedChart;
    property OnSetLabel:TTeeCommanderOnSetLabel read FOnSetLabel
                                                write FOnSetLabel;
  end;

implementation

{$IFDEF CLR}
{$R 'TeeCopy.bmp'}
{$R 'TeeDepth.bmp'}
{$R 'TeeEdit.bmp'}
{$R 'TeeMove.bmp'}
{$R 'TeeNormal.bmp'}
{$R 'TeePrint.bmp'}
{$R 'TeeRotate.bmp'}
{$R 'TeeZoom.bmp'}
{$R 'TeeView3D.bmp'}
{$R 'TeeSave.bmp'}
{$ELSE}
{$R TeeComma.res}
{$ENDIF}

Uses Math,
     {$IFNDEF TEEOCXNOEDITOR}
     TeeEditPro, EditChar, TeePrevi, TeeEdiGene,
     {$ENDIF}
     TeeProCo, TeeTools, TeEngine, TeCanvas;

{ TCustomTeeCommander }
Constructor TCustomTeeCommander.Create(AOwner:TComponent);
begin
  inherited;
  Panel:=nil;
  Height:=33;
  Width:=400;
  FMouseButton:=mbLeft;

  {$IFNDEF TEEOCX}
  ShowHint:=True;
  {$ENDIF}

  if (csDesigning in ComponentState) and
     (not (csLoading in Owner.ComponentState)) then Align:=alTop;
end;

Destructor TCustomTeeCommander.Destroy;
begin
  FreeOwnedControls;
  Panel:=nil;
  inherited;
end;

procedure TCustomTeeCommander.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FPanel) and (AComponent=FPanel) then
     Panel:=nil;
end;

procedure TCustomTeeCommander.TeeEvent(Event:TTeeEvent);
begin
  if Event is TTeeMouseEvent then
  With TTeeMouseEvent(Event) do
  begin
    Case Event of
      meDown: begin
                FMouseButton:=Button;
                DoMouseDown(X,Y);
              end;
      meUp:  DoMouseUp;
      meMove: DoMouseMove(X,Y);
    end;
    Sender.CancelMouse:=not DoPanelMouse;
  end
  else
  if Event is TTeeView3DEvent then
     ShowHideControls(Assigned(Panel));
end;

Procedure TCustomTeeCommander.DoMouseDown(X,Y:Integer);
begin
end;

Procedure TCustomTeeCommander.DoMouseMove(X,Y:Integer);
begin
end;

Procedure TCustomTeeCommander.DoMouseUp;
begin
end;

Procedure TCustomTeeCommander.ShowHideControls(Value:Boolean);
Var t : Integer;
begin
  if not( csDestroying in ComponentState) then
     for t:=0 to ControlCount-1 do
         if Controls[t].Owner=Self then Controls[t].Enabled:=Value;
end;

Procedure TCustomTeeCommander.ReAlignTeeControls;
var t      : Integer;
    tmpPos : Integer;
begin
  tmpPos:=4;
  for t:=0 to ControlCount-1 do
  if Controls[t].Owner=Self then
  begin
    With Controls[t] do
    begin
      if FVertical then
      begin
        Left:=4;
        Top:=tmpPos;
      end
      else
      begin
        Left:=tmpPos;
        Top:=4;
      end;
    end;
    if Controls[t] is TBevel then
    begin
      Inc(tmpPos,4+2);
      with Controls[t] as TBevel do
      if FVertical then
      begin
        Shape:=bsTopLine;
        Width:=Self.Width-2*4;
        Height:=2;
      end
      else
      begin
        Shape:=bsLeftLine;
        Width:=2;
        Height:=Self.Height-2*4;
      end;
    end
    else Inc(tmpPos,25+4);
  end;
end;

procedure TCustomTeeCommander.SetVertical(Value:Boolean);
begin
  if FVertical<>Value then
  begin
    FVertical:=Value;
    if Align<>alNone then
       if FVertical then Align:=alLeft
                    else Align:=alTop;
    ReAlignTeeControls;
  end;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

procedure TCustomTeeCommander.SetPanel(const Value: TCustomTeePanel);
begin
  if Assigned(FPanel) then
  begin
    {$IFDEF D5}
    FPanel.RemoveFreeNotification(Self);
    {$ENDIF}
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FPanel).RemoveListener(Self);
  end;

  FPanel:=Value;

  if Assigned(FPanel) then
  begin
    FPanel.FreeNotification(Self);
    if Assigned({$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FPanel).Listeners) then { 5.01 }
       {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FPanel).Listeners.Add(Self);
  end;

  if not (csDestroying in ComponentState) then
    ShowHideControls(Assigned(FPanel));
end;

procedure TCustomTeeCommander.Loaded;
var t : Integer;
begin
  inherited;

  if not Assigned(FPanel) then
  if Assigned(Parent) then
  begin
    if Parent is TCustomTeePanel then
       Panel:=TCustomTeePanel(Parent)
    else
    With Parent do
    for t:=0 to ComponentCount-1 do
      if Components[t] is TCustomTeePanel then
      begin
        Self.Panel:=TCustomTeePanel(Components[t]);
        break;
      end;
  end;

  ShowHideControls(Assigned(FPanel));
end;

Function TCustomTeeCommander.CreateButton( APos:Integer;
                                           AProc:TNotifyEvent;
                                           Const AHint:String;
                                           ABitmap: TBitmap;
                                           AGroupIndex:Integer):TSpeedButton;
begin
  result:=TSpeedButton.Create(Self);

  With result do
  begin
    OnClick:=AProc;
    if FVertical then SetBounds(4,APos,25,25)
                 else SetBounds(APos,4,25,25);
    Down:= True;
    Flat:= True;
    {$IFDEF TEEOCX}
    ShowHint:=True;
    {$ELSE}
    ParentShowHint:=True;
    {$ENDIF}
    Hint:=AHint;
    Parent:=Self;
    GroupIndex:=AGroupIndex;

    if Assigned(ABitmap) then
       Glyph.Assign(ABitmap);
  end;
end;

Function TCustomTeeCommander.CreateButton( APos:Integer;
                                           AProc:TNotifyEvent;
                                           Const AHint:String;
                                           Const AResName:String;
                                           AGroupIndex:Integer):TSpeedButton;
var Glyph : TBitmap;
begin
  Glyph:=TBitmap.Create;
  try
    if AResName<>'' then { 5.02 }
    begin
      {$IFDEF CLR}
      TeeLoadBitmap(Glyph,AResName,'');
      {$ELSE}
      Glyph.LoadFromResourceName(HInstance,AResName);
      {$ENDIF}
    end;

    result:=CreateButton(APos, AProc, AHint, Glyph, AGroupIndex);
  finally
    Glyph.Free;
  end;
end;

Function TCustomTeeCommander.DoPanelMouse:Boolean;
begin
  result:=True;
end;

Procedure TCustomTeeCommander.CreateBevel(APos:Integer);
begin
  With TBevel.Create(Self) do
  begin
    Shape:=bsLeftLine;
    Width:=2;
    Height:=Self.Height-4;
    Top:=2;
    Left:=APos;
    Parent:=Self;
  end;
end;

Function TCustomTeeCommander.CreateLabel(APos:Integer; AColor:TColor):TLabel;
begin
  result:=TLabel.Create(Self);
  With result do
  begin
    Left:=APos;
    Top:=12;
    Font.Name:=GetDefaultFontName;
    Font.Color:=AColor;
    Font.Size:=GetDefaultFontSize;
    Caption:='';
    Parent:=Self;
  end;
end;

Function TCustomTeeCommander.TeePanelClass:String;
begin
  if FPanel is TCustomAxisPanel then result:=TeeCommanMsg_Chart
                                else result:=TeeCommanMsg_Panel;
end;

Procedure TCustomTeeCommander.FreeOwnedControls;
var Num : Integer;
    tmp : Integer;
    t   : Integer;
begin
  Repeat
    Num:=0;
    tmp:=-1;
    for t:=0 to ControlCount-1 do
    if Controls[t].Owner=Self then
    begin
      Inc(Num);
      tmp:=t;
    end;
    if tmp<>-1 then
    begin
      RemovingControl(Controls[tmp]);
      Controls[tmp].Free;
    end;
  Until Num=0;
end;

procedure TCustomTeeCommander.RemovingControl(AControl: TControl);
begin
end;

{ TTeeCommander }
Constructor TTeeCommander.Create(AOwner:TComponent);
begin
  inherited;
  {$IFNDEF TEEOCXNOEDITOR}
  FEditor:=nil;
  FPreviewer:=nil;
  {$ENDIF}
  FDragging:=False;
  FLabelValues:=True;
  FVertical:=False;
  FEnablePieExp:=True;

  CreateControls([ tcbNormal,
                   tcbSeparator,
                   tcbRotate,
                   tcbMove,
                   tcbZoom,
                   tcbDepth,
                   tcb3D,
                   tcbSeparator,
                   tcbEdit,
                   tcbPrintPreview,
                   tcbCopy,
                   tcbSave,
                   tcbLabel ]);

  {$IFDEF TEEOCXNOEDITOR}
  FButtonEdit.Hide;
  FButtonPrint.Hide;
  RepositionControls;
  {$ENDIF}
  
  if Assigned(FButtonNormal) then FButtonNormal.Down:=True;
end;

Procedure TTeeCommander.RemovingControl(AControl:TControl);
begin
  inherited;
  if AControl=FButtonNormal then FButtonNormal:=nil else
  if AControl=FButtonRotate then FButtonRotate:=nil else
  if AControl=FButtonMove then FButtonMove:=nil else
  if AControl=FButtonZoom then FButtonZoom:=nil else
  if AControl=FButtonDepth then FButtonDepth:=nil else
  if AControl=FButtonEdit then FButtonEdit:=nil else
  if AControl=FButtonPrint then FButtonPrint:=nil else
  if AControl=FButtonCopy then FButtonCopy:=nil else
  if AControl=FButtonSave then FButtonSave:=nil else
  if AControl=FButton3D then FButton3D:=nil else
  if AControl=FLabel then FLabel:=nil;
end;

Procedure TTeeCommander.CreateControls(AControls:Array of TeeCommanderControls);
var t,
    tmpPos:Integer;
begin
  FreeOwnedControls;
  tmpPos:=4;

  for t:=Low(AControls) to High(AControls) do
  begin
    Case AControls[t] of
      tcbNormal : FButtonNormal := CreateButton(tmpPos,ButtonNormalClick,TeeCommanMsg_Normal,'TeeNormal',1);
      tcbRotate:  FButtonRotate := CreateButton(tmpPos,ButtonRotateClick,TeeCommanMsg_Rotate,'TeeRotate',1);
      tcbMove:    FButtonMove   := CreateButton(tmpPos,ButtonMoveClick,TeeCommanMsg_Move,'TeeMove',1);
      tcbZoom:    FButtonZoom   := CreateButton(tmpPos,ButtonZoomClick,TeeCommanMsg_Zoom,'TeeZoom',1);
      tcbDepth:   FButtonDepth  := CreateButton(tmpPos,ButtonDepthClick,TeeCommanMsg_Depth,'TeeDepth',1);
      tcbEdit:    FButtonEdit   := CreateButton(tmpPos,ButtonEditClick,TeeCommanMsg_Edit,'TeeEdit',0);
 tcbPrintPreview: FButtonPrint  := CreateButton(tmpPos,ButtonPrintClick,TeeCommanMsg_Print,'TeePrint',0);
      tcbCopy:    FButtonCopy   := CreateButton(tmpPos,ButtonCopyClick,TeeCommanMsg_Copy,'TeeCopy',0);
      tcbSave:    FButtonSave   := CreateButton(tmpPos,ButtonSaveClick,TeeCommanMsg_Save,'TeeSave',0);
      tcb3D:      begin
                    FButton3D:= CreateButton(tmpPos,Button3DClick,TeeCommanMsg_3D,'TeeView3D',2);
                    FButton3D.AllowAllUp:=True;
                  end;
    tcbSeparator: CreateBevel(tmpPos);
      tcbLabel:   FLabel        := CreateLabel(tmpPos,clNavy);
    end;

    if AControls[t]=tcbSeparator then Inc(tmpPos,4+2)
                                 else Inc(tmpPos,25+4);
  end;

  ShowHideControls(Assigned(Panel));
end;

Procedure TTeeCommander.RepositionControls;
var t      : Integer;
    tmpPos : Integer;
begin
  tmpPos:=0;
  for t:=0 to ControlCount-1 do
  begin
    if (Controls[t].Owner=Self) and Controls[t].Visible then
    begin
      Controls[t].Left:=tmpPos;
      if Controls[t] is TBevel then Inc(tmpPos,4+2)
                               else Inc(tmpPos,25+4);
    end;
  end;
end;

Procedure TTeeCommander.DoMouseDown(X,Y:Integer);

  Function ButtonNormalUp:Boolean;
  begin
    result:=(not Assigned(FButtonNormal)) or (not FButtonNormal.Down);
  end;

begin
  IPieSeries:=GetPieSeries(x,y);

  if Assigned(IPieSeries) or ButtonNormalUp then
  begin
    FDragging:=True;
    FOldX:=X;
    FOldY:=Y;

    if Assigned(IPieSeries) then FDraggingIndex:=IPieSeries.Clicked(X,Y)
                            else FDraggingIndex:=-1;

    if FPanel is TCustomTeePanel then
       TCustomTeePanel(FPanel).CancelMouse:=(FDraggingIndex<>-1) or ButtonNormalUp;
  end;
end;

Function TTeeCommander.DoPanelMouse:Boolean;

  Function IsButtonUp(AButton:TSpeedButton):Boolean;
  begin
    result:=((not Assigned(AButton)) or (not AButton.Down));
  end;

begin
  result:=IsButtonUp(FButtonRotate) and
          IsButtonUp(FButtonDepth) and
          IsButtonUp(FButtonMove) and
          IsButtonUp(FButtonZoom);
end;

Procedure TTeeCommander.DoMouseUp;
begin
  IPieSeries:=nil;
  FDragging:=False;
  FDraggingIndex:=-1;
end;

Function TTeeCommander.GetPieSeries(x,y:Integer):TPieSeries;
var t : Integer;
    tmp : TChartSeries;
    tmpPart : TChartClickedPart;
begin
  result:=nil;

  if EnablePieExploding and (FPanel is TCustomChart) then
  With TCustomChart(FPanel) do
  begin
    CalcClickedPart(TeePoint(x,y),tmpPart);

    if (tmpPart.Part=cpSeries) and (tmpPart.ASeries is TPieSeries) then
       result:=tmpPart.ASeries as TPieSeries
    else
    for t:=0 to SeriesCount-1 do
    begin
      tmp:=Series[t];

      if (tmp is TPieSeries) and tmp.Active then
      begin
        result:=tmp as TPieSeries;
        exit;
      end;
    end;
  end;
end;

Function TTeeCommander.IsButtonDown(AButton:TSpeedButton):Boolean;
begin
  result:=Assigned(AButton) and AButton.Down;
end;

Procedure TTeeCommander.DoMouseMove(X,Y:Integer);

   Procedure Set3D;
   begin
     FPanel.View3D:=True;
     if Assigned(FButton3D) then FButton3D.Down:=True;
   end;

   Procedure DoRotate;

      Function CorrectAngle(Const AAngle:Integer):Integer;
      begin
        result:=AAngle;
        if result>360 then result:=result-360 else
        if result<0 then result:=360+result;
      end;

    Var tmpX      : Integer;
        tmpY      : Integer;
    begin
      With FPanel,View3DOptions do
      begin
        Set3D;
        Orthogonal:=False;
        tmpX:=Round(90.0*(X-FOldX)/Width);
        tmpY:=Round(90.0*(FOldY-Y)/Height);

        if Canvas.SupportsFullRotation then
        begin
          Rotation:=CorrectAngle(Rotation+tmpX);
          Elevation:=CorrectAngle(Elevation+tmpY);
        end
        else
        begin
          if Assigned(IPieSeries) then
          begin
            Rotation:=360;
            if not Canvas.SupportsFullRotation then Perspective:=0;

            if tmpX<>0 then
               With IPieSeries do RotationAngle:=CorrectAngle(RotationAngle+tmpX);
          end
          else
           Rotation:=TRotateTool.RotationChange(FPanel.Canvas.SupportsFullRotation,Rotation,tmpX);

          Elevation:=TRotateTool.ElevationChange(FPanel.Canvas.SupportsFullRotation,Elevation,tmpY);
        end;

        FOldX:=X;
        FOldY:=Y;
      end;
    end;

    Procedure DoMove;
    begin
      Set3D;
      With FPanel.View3DOptions do
      begin
        HorizOffset:=HorizOffset+(X-FOldX);
        VertOffset:=VertOffset+(Y-FOldY);
      end;
      FOldX:=X;
      FOldY:=Y;
    end;

    Procedure DoZoom;
    var tmp  : Double;
        tmp2 : Double;
    begin
      Set3D;
      With FPanel,View3DOptions do
      begin
        tmp:=(10.0*(FOldY-Y)/TeeDistance(ChartWidth,ChartHeight));

        tmp2:=(10.0*tmp*Zoom/100.0);
        if tmp>0 then
           Zoom:=Zoom+Round(Math.Max(1,tmp2))
        else
        if tmp<0 then
           Zoom:=Math.Max(1,Zoom+Round(Math.Min(-1,tmp2)));
      end;

      FOldY:=Y;
    end;

    Function CalcDistPercent(APercent,AWidth,AHeight:Integer):Integer;
    begin
      result:=Round(1.0*APercent*TeeDistance(FOldX-X,FOldY-Y)/TeeDistance(AWidth,AHeight));
    end;

    Procedure DoDepth;
    var tmp : Integer;
    begin
      if FPanel is TCustomAxisPanel then
      With TCustomAxisPanel(FPanel) do
      begin
        Set3D;
        tmp:=CalcDistPercent(200,ChartWidth,ChartHeight);
        if (tmp>=1) then
           Chart3DPercent:=Math.Min(100,tmp);
      end;
    end;

    Procedure DoNormal;
    Var tmp : Integer;
    begin
      if FDraggingIndex<>-1 then
      begin
        if Assigned(IPieSeries) then
        With IPieSeries do
        begin
          tmp:=Math.Min(100,CalcDistPercent(100,CircleWidth,CircleHeight));
          ExplodedSlice[FDraggingIndex]:=tmp;
        end;
      end;
    end;

begin
  if FDragging then
  begin
    FDragging:=False;
    if (not Assigned(FButtonNormal)) or IsButtonDown(FButtonNormal) then  // 7.0
       DoNormal  { first do this !!! }
    else
    if FMouseButton=mbRight then DoMove
    else
    if IsButtonDown(FButtonRotate) then DoRotate else
    if IsButtonDown(FButtonMove)   then DoMove else
    if IsButtonDown(FButtonZoom)   then DoZoom else
    if IsButtonDown(FButtonDepth)  then DoDepth;
    if FLabelValues and (not FVertical) then ShowValues;
    FDragging:=True;
  end;
end;

Function TTeeCommander.CaptionPanel(Const ACaption:String):String;
begin
  result:=Format(ACaption,[TeePanelClass]);
end;

procedure TTeeCommander.SetLabelCaption(Const ACaption:String);
var tmp: String;
begin
  tmp:=ACaption;
  if Assigned(FOnSetLabel) then FOnSetLabel(Self,tmp); { 5.02 }

  if Assigned(FLabel) then
     if FLabelValues and (not FVertical) then
        FLabel.Caption:=tmp
     else
        FLabel.Visible:=False;
end;

procedure TTeeCommander.ButtonRotateClick(Sender: TObject);
begin
  SetLabelCaption(CaptionPanel(TeeCommanMsg_RotateLabel));
end;

procedure TTeeCommander.ButtonMoveClick(Sender: TObject);
begin
  SetLabelCaption(CaptionPanel(TeeCommanMsg_MoveLabel));
end;

procedure TTeeCommander.ButtonZoomClick(Sender: TObject);
begin
  SetLabelCaption(CaptionPanel(TeeCommanMsg_ZoomLabel));
end;

procedure TTeeCommander.ButtonDepthClick(Sender: TObject);
begin
  SetLabelCaption(CaptionPanel(TeeCommanMsg_DepthLabel));
end;

procedure TTeeCommander.ButtonEditClick(Sender: TObject);
begin
  {$IFNDEF TEEOCXNOEDITOR}
  if Assigned(FEditor) then FEditor.Execute
  else
  if Assigned(FPanel) and (FPanel is TCustomChart) then
     EditChart(nil,TCustomChart(FPanel));
  if Assigned(FOnEditedChart) then FOnEditedChart(Self,FPanel as TCustomChart);
  if Assigned(FButton3D) then FButton3D.Down:=FPanel.View3D;
  {$ENDIF}
end;

procedure TTeeCommander.ButtonPrintClick(Sender: TObject);
begin
  {$IFNDEF TEEOCXNOEDITOR}
  if Assigned(FPreviewer) then FPreviewer.Execute
  else
  if Assigned(FPanel) then ChartPreview(nil,FPanel);
  {$ENDIF}
end;

procedure TTeeCommander.Button3DClick(Sender: TObject);
begin
  if Assigned(FPanel) then
  begin
    {$IFDEF CLX}
    IChanging3D:=True;
    {$ENDIF}
    FPanel.View3D:={$IFDEF CLX}not {$ENDIF}FButton3D.Down;
    {$IFDEF CLX}
    IChanging3D:=False;
    {$ENDIF}
  end;
end;

procedure TTeeCommander.ButtonCopyClick(Sender: TObject);
begin
  if Assigned(FPanel) then FPanel.CopyToClipboardBitmap;
end;

procedure TTeeCommander.ButtonNormalClick(Sender: TObject);
begin
  if GetPieSeries(0,0)=nil then
     SetLabelCaption(CaptionPanel(TeeCommanMsg_NormalLabel))
  else
     SetLabelCaption(CaptionPanel(TeeCommanMsg_NormalPieLabel))
end;

Procedure TTeeCommander.ShowHideControls(Value:Boolean);
begin
  EnableControls(Value,[FButtonRotate,FButtonMove,FButtonZoom,FButtonNormal,
                        FButtonCopy,FButtonSave,FButtonPrint,FButton3D]);

  if Value then Value:=FPanel is TCustomAxisPanel;

  if Assigned(FButtonDepth) then FButtonDepth.Enabled:=Value;  { 5.01 }
  if Assigned(FButtonEdit) then FButtonEdit.Enabled:=Value;    { 5.01 }
  if Assigned(FButtonSave) then FButtonSave.Enabled:=Value;    { 5.01 }

  if Assigned(FButton3D) and Assigned(FPanel) then
     {$IFDEF CLX}
     if not IChanging3D then
     {$ENDIF}
        FButton3D.Down:=FPanel.View3D;
end;

procedure TTeeCommander.SetLabelValues(Value:Boolean);
begin
  if FLabelValues<>Value then
  begin
    FLabelValues:=Value;
    if Assigned(FLabel) then FLabel.Visible:=FLabelValues;
  end;
end;

Procedure TTeeCommander.ShowValues;
var tmp : String;
begin
  With FPanel.View3DOptions do
  if IsButtonDown(FButtonRotate) then
     tmp:=Format(TeeCommanMsg_Rotating,[Rotation,Elevation]) { 5.02 }
  else
  if IsButtonDown(FButtonMove) then
     tmp:=Format(TeeCommanMsg_Moving,[HorizOffset,VertOffset])
  else
  if IsButtonDown(FButtonZoom) then
     tmp:=Format(TeeCommanMsg_Zooming,[Zoom])
  else
  if IsButtonDown(FButtonDepth) then
  begin
    if FPanel is TCustomAxisPanel then
    With TCustomAxisPanel(FPanel) do
      tmp:=Format(TeeCommanMsg_Depthing,[Chart3DPercent])
  end
  else
  if IsButtonDown(FButtonNormal) and (FDraggingIndex<>-1) then
  begin
    if Assigned(IPieSeries) then
       tmp:=Format( TeeCommanMsg_PieExploding,
                    [FDraggingIndex,IPieSeries.ExplodedSlice[FDraggingIndex]])
    else
       tmp:='';
  end
  else
  if Assigned(FLabel) then tmp:='';

  SetLabelCaption(tmp);
  if Assigned(FLabel) and FLabel.Visible then FLabel.Update;
end;

procedure TTeeCommander.ButtonSaveClick(Sender: TObject);
begin
  {$IFNDEF TEEOCXNOEDITOR}
  if Assigned(FPanel) then
  if FPanel is TCustomChart then SaveChartDialog(FPanel as TCustomChart);
  {$ENDIF}
end;

{$IFNDEF TEEOCXNOEDITOR}
procedure TTeeCommander.SetEditor(const Value: TChartEditor);
begin
  {$IFDEF D5}
  if Assigned(FEditor) then
     FEditor.RemoveFreeNotification(Self);
  {$ENDIF}

  if FEditor<>Value then
  begin
    FEditor:=Value;
    if Assigned(FEditor) then
       FEditor.FreeNotification(Self);
  end;
end;

procedure TTeeCommander.SetPreviewer(const Value: TChartPreviewer);
begin
  {$IFDEF D5}
  if Assigned(FPreviewer) then
     FPreviewer.RemoveFreeNotification(Self);
  {$ENDIF}

  if FPreviewer<>Value then
  begin
    FPreviewer:=Value;
    if Assigned(FPreviewer) then
       FPreviewer.FreeNotification(Self);
  end;
end;

procedure TTeeCommander.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) then
  begin
    if Assigned(FEditor) and (AComponent=FEditor) then
       FEditor:=nil;
    if Assigned(FPreviewer) and (AComponent=FPreviewer) then
       FPreviewer:=nil;
  end;
end;
{$ENDIF}

end.
