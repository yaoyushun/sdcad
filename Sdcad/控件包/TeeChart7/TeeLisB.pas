{***************************************}
{ TeeChart Pro - TChartListBox class    }
{ Copyright (c) 1995-2004 David Berneda }
{     Component Registration Unit       }
{***************************************}
unit TeeLisB;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QStdCtrls, QGraphics, QForms, QControls, QButtons, QDialogs, Qt,
     {$ELSE}
     StdCtrls, Graphics, Forms, Controls, Buttons, Dialogs,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     SysUtils, Classes, Chart, TeeProcs, TeCanvas, TeEngine;

type TChartListBox=class;

     TDblClickSeriesEvent=procedure(Sender:TChartListBox; Index:Integer) of object;
     TNotifySeriesEvent=procedure(Sender:TChartListBox; Series:TCustomChartSeries) of object;
     TChangeOrderEvent=procedure(Sender:TChartListBox; Series1,Series2:TCustomChartSeries) of object;

     TListBoxSection=Packed record
       Width   : Integer;
       Visible : Boolean;
     end;

     TListBoxSections=Array[0..3] of TListBoxSection;

     TChartListBox=class(TCustomListBox,ITeeEventListener)
     private
       FAllowAdd         : Boolean;
       FAllowDelete      : Boolean;
       FAskDelete        : Boolean;
       FChart            : TCustomChart;
       FCheckStyle       : TCheckBoxesStyle;
       FEditor           : TEdit;
       FEnableChangeColor: Boolean;
       FEnableDragSeries : Boolean;
       FEnableChangeType : Boolean;
       FGroup            : TSeriesGroup;
       {$IFNDEF CLX}
       FHitTest          : TPoint;
       {$ENDIF}
       FNames            : Boolean;

       FOnChangeActive   : TNotifySeriesEvent; // 6.02
       FOnChangeColor    : TNotifySeriesEvent;
       FOnChangeOrder    : TChangeOrderEvent; // 5.03

       FOnEditSeries     : TDblClickSeriesEvent;
       FOnRemovedSeries  : TNotifySeriesEvent;
       FOtherItems       : TStrings;
       FOtherItemsChange : TNotifyEvent;
       FRefresh          : TNotifyEvent;
       ComingFromDoubleClick:Boolean;

       procedure DoRefresh;
       procedure EditorKey(Sender: TObject; var Key: Word; Shift: TShiftState);
       procedure EditorPress(Sender: TObject; var Key: Char);
       Function GetSelectedSeries:TChartSeries;
       Function GetSeriesGroup:TCustomSeriesList;
       Function GetShowActive:Boolean;
       Function GetShowIcon:Boolean;
       Function GetShowColor:Boolean;
       Function GetShowTitle:Boolean;
       function GetSeries(Index: Integer): TChartSeries;
       procedure LBSeriesClick(Sender: TObject);
       {$IFDEF CLX}
       procedure LBSeriesDrawItem(Sender: TObject; Index: Integer;
        Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
       {$ELSE}
       procedure LBSeriesDrawItem(Control: TWinControl; Index: Integer;
                                           Rect: TRect; State: TOwnerDrawState);
       {$ENDIF}
       procedure LBSeriesDragOver( Sender, Source: TObject; X,
                                   Y: Integer; State: TDragState; var Accept: Boolean);
       Procedure RefreshDesigner;
       Function SectionLeft(ASection:Integer):Integer;
       Procedure SelectSeries(AIndex:Integer);
       procedure SetChart(Value:TCustomChart);
       procedure SetCheckStyle(Value:TCheckBoxesStyle);
       procedure SetGroup(Value:TSeriesGroup);
       procedure SetNames(Value:Boolean);
       Procedure SetSelectedSeries(Value:TChartSeries);
       Procedure SetShowActive(Value:Boolean);
       Procedure SetShowIcon(Value:Boolean);
       Procedure SetShowColor(Value:Boolean);
       Procedure SetShowTitle(Value:Boolean);
     protected
       procedure DblClick; override;

       {$IFNDEF CLX}
       {$IFDEF D6}
       function GetItemIndex: Integer; override;
       {$ENDIF}
       {$ENDIF}

       procedure KeyUp(var Key: Word; Shift: TShiftState); override;
       procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                           X, Y: Integer); override;
       procedure Notification(AComponent: TComponent;
                              Operation: TOperation); override;
       {$IFNDEF CLX}
       procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
       procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
       {$ELSE}
       procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
       {$ENDIF}

       {$IFNDEF CLX}
       Procedure SetParent(Control:TWinControl); override;
       {$ENDIF}

       procedure TeeEvent(Event: TTeeEvent);  { interface }
     public
       ReferenceChart : TCustomChart;
       Sections : TListBoxSections;

       Constructor Create(AOwner:TComponent); override;
       Destructor Destroy; override;

       Function AddSeriesGallery:TChartSeries;
       Function AnySelected:Boolean;   { 5.01 }
       procedure ChangeTypeSeries(Sender: TObject);
       procedure ClearItems;
       {$IFNDEF D6}
       procedure ClearSelection;
       {$ENDIF}
       Procedure CloneSeries;

       Function DeleteSeries:Boolean;
       procedure DragDrop(Source: TObject; X, Y: Integer); override;
       procedure FillSeries(OldSeries:TChartSeries);
       procedure HideEditor;
       Procedure MoveCurrentDown;
       Procedure MoveCurrentUp;
       property OtherItems:TStrings read FOtherItems write FOtherItems;
       Function PointInSection(Const P:TPoint; ASection:Integer):Boolean;
       Function RenameSeries:Boolean; { 5.02 }
       Procedure SelectAll; {$IFNDEF CLX}{$IFDEF D6} override; {$ENDIF}{$ENDIF}
       property Series[Index:Integer]:TChartSeries read GetSeries;
       property SeriesGroup:TSeriesGroup read FGroup write SetGroup;
       Function SeriesAtMousePos(Var p:TPoint):Integer;
       property SelectedSeries:TChartSeries read GetSelectedSeries
                                            write SetSelectedSeries;
       Procedure ShowEditor;
       procedure SwapSeries(tmp1,tmp2:Integer);
       procedure UpdateSeries;

       property ShowSeriesNames:Boolean read FNames write SetNames;
     published
       property AllowAddSeries : Boolean read FAllowAdd
                                  write FAllowAdd default True;
       property AllowDeleteSeries : Boolean read FAllowDelete
                                  write FAllowDelete default True;
       property AskDelete:Boolean read FAskDelete write FAskDelete
                                  default True;
       property Chart:TCustomChart read FChart write SetChart;

       property CheckStyle:TCheckBoxesStyle read FCheckStyle  // 6.02
                write SetCheckStyle default cbsCheck;

       property EnableChangeColor:Boolean read FEnableChangeColor
                                          write FEnableChangeColor default True;
       property EnableDragSeries:Boolean read FEnableDragSeries
                                            write FEnableDragSeries default True;
       property EnableChangeType:Boolean read FEnableChangeType
                                         write FEnableChangeType default True;
       property OnChangeActive:TNotifySeriesEvent read FOnChangeActive  // 6.02
                                                write FOnChangeActive;
       property OnChangeColor:TNotifySeriesEvent read FOnChangeColor
                                                write FOnChangeColor;
       property OnChangeOrder:TChangeOrderEvent read FOnChangeOrder
                                                write FOnChangeOrder;
       property OnDblClickSeries:TDblClickSeriesEvent read FOnEditSeries
                                                  write FOnEditSeries;
       property OnOtherItemsChange:TNotifyEvent read FOtherItemsChange
                                              write FOtherItemsChange;
       property OnRefresh:TNotifyEvent read FRefresh write FRefresh;
       property OnRemovedSeries:TNotifySeriesEvent read FOnRemovedSeries
                                                    write FOnRemovedSeries;
       property ShowActiveCheck:Boolean read GetShowActive
                                        write SetShowActive default True;
       property ShowSeriesColor:Boolean read GetShowColor
                                           write SetShowColor default True;
       property ShowSeriesIcon:Boolean read GetShowIcon
                                           write SetShowIcon default True;
       property ShowSeriesTitle:Boolean read GetShowTitle
                                           write SetShowTitle default True;

       property Align;
       property BorderStyle;
       property Color;
       {$IFNDEF CLX}
       property Ctl3D;
       {$ENDIF}
       property Enabled;
       property ExtendedSelect;
       property Font;
       {$IFNDEF CLX}
       property ImeMode;
       property ImeName;
       {$ENDIF}
       property ItemHeight; { 5.02 }
       property MultiSelect default True;  { 5.01 }
       property ParentColor;
       {$IFNDEF CLX}
       property ParentCtl3D;
       {$ENDIF}
       property ParentFont;
       property ParentShowHint;
       property PopupMenu;
       property ShowHint;
       property Sorted; // 7.0
       property TabOrder;
       property TabStop;
       property Visible;
       property OnClick;
       property OnEnter;
       property OnExit;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       {$IFNDEF CLX}
       property OnStartDock;
       {$ENDIF}
       property OnStartDrag;
     end;

var TeeAddGalleryProc:Function(AOwner:TComponent; Chart:TCustomChart; Series:TChartSeries):TChartSeries=nil;
    TeeChangeGalleryProc:Function(AOwner:TComponent; var Series: TChartSeries):TChartSeriesClass=nil;

implementation

{$IFDEF CLR}
{$R 'TAreaSeries.bmp'}
{$R 'TArrowSeries.bmp'}
{$R 'TBarSeries.bmp'}
{$R 'TBubbleSeries.bmp'}
{$R 'TChartShape.bmp'}
{$R 'TFastLineSeries.bmp'}
{$R 'TGanttSeries.bmp'}
{$R 'THorizBarSeries.bmp'}
{$R 'TLineSeries.bmp'}
{$R 'TPieSeries.bmp'}
{$R 'TPointSeries.bmp'}
{$R 'THorizLineSeries.bmp'}
{$R 'THorizAreaSeries.bmp'}
{$ELSE}
{$R TeeBmps.res}
{$ENDIF}

Uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeePenDlg, TeeConst;

{ TChartListBox }
Constructor TChartListBox.Create(AOwner:TComponent);
begin
  inherited;
  ComingFromDoubleClick:=False;

//  DoubleBuffered:=True;

  FEnableChangeColor:=True;
  FEnableDragSeries:=True;
  FEnableChangeType:=True;

  Sections[0].Width:=26;  Sections[0].Visible:=True;
  Sections[1].Width:=16;  Sections[1].Visible:=True;
  Sections[2].Width:=26;  Sections[2].Visible:=True;
  Sections[3].Width:=216; Sections[3].Visible:=True;

  OnDrawItem:=LBSeriesDrawItem;
  OnDragOver:=LBSeriesDragOver;
  OnClick:=LBSeriesClick;

  {$IFDEF CLX}
  Style:=lbOwnerDrawVariable;
  {$ELSE}
  Style:=lbOwnerDrawFixed;
  {$ENDIF}
  ItemHeight:=24;
  Sorted:=False;
  MultiSelect:=True;
  FAskDelete:=True;
  FAllowDelete:=True;
  FAllowAdd:=True;
end;

Destructor TChartListBox.Destroy;
begin
  FreeAndNil(FEditor);
  Chart:=nil;
  inherited;
end;

procedure TChartListBox.DragDrop(Source: TObject; X,Y: Integer);
var tmp1 : Integer;
    tmp2 : Integer;
begin
  if ItemIndex<>-1 then
  begin
    tmp1:=ItemIndex;
    tmp2:=ItemAtPos(TeePoint(X,Y),True);
    if (tmp2<>-1) and (tmp1<>tmp2) then SwapSeries(tmp1,tmp2);
  end;
end;

procedure TChartListBox.DoRefresh;
begin
  if Assigned(FRefresh) then FRefresh(Self);
end;

{$IFNDEF CLR}
type
  TChartAccess=class(TCustomChart);
{$ENDIF}

procedure TChartListBox.SetChart(Value:TCustomChart);
begin
  if FChart<>Value then
  begin
    if Assigned(Chart) then
    begin
      {$IFNDEF CLR}TChartAccess{$ENDIF}(Chart).RemoveListener(Self);
      {$IFDEF D5}
      Chart.RemoveFreeNotification(Self);
      {$ENDIF}
    end;

    FChart:=Value;

    if Assigned(Chart) then
    begin
      Chart.FreeNotification(Self);
      {$IFNDEF CLR}TChartAccess{$ENDIF}(Chart).Listeners.Add(Self);
      FillSeries(nil);
    end
    else ClearItems;
  end;
end;

procedure TChartListBox.SetCheckStyle(Value:TCheckBoxesStyle);
var tmpCount : Integer;
    t        : Integer;
begin
  if FCheckStyle<>Value then
  begin
    FCheckStyle:=Value;

    if FCheckStyle=cbsRadio then
    begin
      tmpCount:=0;
      // Ensure only one series is active (visible)
      for t:=0 to Items.Count-1 do
      if Series[t].Active then
      begin
        Inc(tmpCount);
        if tmpCount>1 then Series[t].Active:=False;
      end;
    end;

    Invalidate;
  end;
end;

procedure TChartListBox.ClearItems;
begin
  if not (csDestroying in ComponentState) then
  begin
    Items.Clear;
    if Assigned(FOtherItems) then FOtherItems.Clear;
  end;
end;

Procedure TChartListBox.SelectSeries(AIndex:Integer); { 5.01 }
begin
  if MultiSelect then Selected[AIndex]:=True
                 else ItemIndex:=AIndex;
end;

procedure TChartListBox.SwapSeries(tmp1,tmp2:Integer);
var tmp        : TCustomForm;
    Series1    : TCustomChartSeries;
    Series2    : TCustomChartSeries;
begin
  Items.Exchange(tmp1,tmp2);
  if Assigned(FOtherItems) then FOtherItems.Exchange(tmp1,tmp2);

  if Assigned(Chart) then
  begin
    Series1:=Series[tmp1];
    Series2:=Series[tmp2];
    Chart.ExchangeSeries(Series1,Series2);

    if Assigned(FOnChangeOrder) then
       FOnChangeOrder(Self,Series1,Series2); // 5.03
  end;

  tmp:=GetParentForm(Self);
  if Assigned(tmp) and CanFocus then tmp.ActiveControl:=Self;

  SelectSeries(tmp2);
  DoRefresh;
  RefreshDesigner;
end;

procedure TChartListBox.LBSeriesClick(Sender: TObject);
begin
  DoRefresh;
end;

Function TChartListBox.SectionLeft(ASection:Integer):Integer;
var t : Integer;
begin
  result:=0;
  for t:=0 to ASection-1 do
  if Sections[t].Visible then Inc(result,Sections[t].Width);
end;

procedure TChartListBox.SetGroup(Value:TSeriesGroup);
begin
  if FGroup<>Value then
  begin
    FGroup:=Value;
    UpdateSeries;
  end;
end;

type TSeriesAccess=class(TChartSeries);

{$IFDEF CLX}
procedure TChartListBox.LBSeriesDrawItem(Sender: TObject; Index: Integer;
     Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ELSE}
procedure TChartListBox.LBSeriesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ENDIF}
Const BrushColors : Array[Boolean] of TColor=(clWindow,clHighLight);
      FontColors  : Array[Boolean] of TColor=(clWindowText,clHighlightText);
var tmp       : Integer;
    tmpSeries : TChartSeries;
    tmpR      : TRect;
    tmpCanvas : TCanvas;
    tmpSelected : Boolean;
begin
  tmpCanvas:=Canvas;

  tmpSelected:=(odSelected in State) or ((not Focused) and (Index=ItemIndex));

  With tmpCanvas do
  begin
    if tmpSelected then
      if (not Focused) and (Index=ItemIndex) then
         Brush.Color:={$IFDEF CLX}clHighLight{$ELSE}clInactiveCaption{$ENDIF}
      else
         Brush.Color:=clHighLight
    else
      if odFocused in State then
         Brush.Color:=clInactiveCaption
      else
         Brush.Color:=Self.Color;

    {$IFDEF CLX}
    Brush.Style:=bsSolid;
    {$ENDIF}
    FillRect(Rect);

    Brush.Color:=Self.Color;
    Brush.Style:=bsSolid;
    tmpR:=Rect;
    tmpR.Right:=SectionLeft(3)-2;

    {$IFDEF CLX}
    Inc(tmpR.Bottom);
    {$ENDIF}

    FillRect(tmpR);

    tmpSeries:=Series[Index];

    if Assigned(tmpSeries) then
    begin

      if ShowSeriesIcon then
         TeeDrawBitmapEditor(tmpCanvas,tmpSeries,SectionLeft(0),Rect.Top);

      if ShowSeriesColor and
         (TSeriesAccess(tmpSeries).IUseSeriesColor) then
      begin
        tmp:=SectionLeft(2)-2;
        tmpR:=TeeRect(tmp,Rect.Top,tmp+Sections[2].Width,Rect.Bottom);
        InflateRect(tmpR,-4,-4);

        PaintSeriesLegend(tmpSeries,tmpCanvas,tmpR,ReferenceChart);
      end;

      if ShowActiveCheck then
      begin
        tmp:=SectionLeft(1);
        TeeDrawCheckBox(tmp+2,Rect.Top+((Rect.Bottom-Rect.Top-13) div 2),tmpCanvas,tmpSeries.Active,Self.Color,CheckStyle=cbsCheck);
      end;

      Brush.Style:=bsClear;

      if ShowSeriesTitle then
      begin
        if tmpSelected then Font.Color:={$IFNDEF CLX}ColorToRGB{$ENDIF}(clHighlightText)
                       else Font.Color:=ColorToRGB(Self.Font.Color);

        {$IFDEF CLX}
        Start;
        QPainter_setBackgroundMode(Handle,BGMode_TransparentMode);
        Stop;
        {$ELSE}
        SetBkMode(Handle,Transparent);
        {$ENDIF}

        TextOut(SectionLeft(3)+1,Rect.Top+((ItemHeight-TextHeight('W')) div 2),Items[Index]);

        {$IFDEF CLX}
        Start;
        QPainter_setBackgroundMode(Handle,BGMode_OpaqueMode);
        Stop;
        {$ELSE}
        SetBkMode(Handle,Opaque);
        {$ENDIF}
      end
      else TextOut(0,0,'');

    end;
  end;
end;

Function TChartListBox.GetSelectedSeries:TChartSeries;
begin
  result:=Series[ItemIndex];
end;

procedure TChartListBox.SetNames(Value:Boolean);
begin
  if FNames<>Value then
  begin
    FNames:=Value;
    UpdateSeries;
  end;
end;

Procedure TChartListBox.SetSelectedSeries(Value:TChartSeries);
begin
  ItemIndex:=Items.IndexOfObject(Value);
  if ItemIndex<>-1 then Selected[ItemIndex]:=True;
  {$IFDEF CLX}
  DoRefresh;
  {$ENDIF}
end;

procedure TChartListBox.LBSeriesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=FEnableDragSeries and (Sender=Source);
end;

Function TChartListBox.SeriesAtMousePos(Var p:TPoint):Integer;
begin
  p:=ScreenToClient(Mouse.CursorPos);
  result:=ItemAtPos(p,True);
end;

Function TChartListBox.PointInSection(Const P:TPoint; ASection:Integer):Boolean;
Var tmpPos : Integer;
begin
  if Sections[ASection].Visible then
  begin
    tmpPos:=SectionLeft(ASection);
    result:=(p.x>tmpPos) and (p.x<tmpPos+Sections[ASection].Width);
  end
  else result:=False;
end;

Function TChartListBox.GetSeriesGroup:TCustomSeriesList;
begin
  if Assigned(FGroup) then result:=FGroup.Series
                      else result:=Chart.SeriesList;
end;

procedure TChartListBox.FillSeries(OldSeries:TChartSeries);
var tmp : Integer;
Begin
  ClearItems;
  if Assigned(Chart) then
     FillSeriesItems(Items,GetSeriesGroup,not FNames);

  if Assigned(FOtherItems) then FOtherItems.Assign(Items);

  tmp:=Items.IndexOfObject(OldSeries);
  if (tmp=-1) and (Items.Count>0) then tmp:=0;

  if (tmp<>-1) and (Items.Count>tmp) then SelectSeries(tmp);

  if Assigned(FOtherItemsChange) then FOtherItemsChange(Self);
  DoRefresh;
end;

Function TChartListBox.AnySelected:Boolean;   { 5.01 }
begin
  if MultiSelect then
  begin
    result:=SelCount>0;

    // Workaround VCL bug:
    if (not result) and (Items.Count>0) and (ItemIndex<>-1) then
    begin
      Selected[ItemIndex]:=True;
      result:=True;
    end;
  end
  else result:=ItemIndex<>-1;
end;

procedure TChartListBox.ChangeTypeSeries(Sender: TObject);
var tmpSeries : TChartSeries;
    NewClass  : TChartSeriesClass;
    t         : Integer;
    tmp       : Integer;
    FirstTime : Boolean;
    tmpList   : TChartSeriesList;
begin
  if AnySelected and Assigned(Chart) and Assigned(TeeChangeGalleryProc) then
  begin
    tmpList:=TChartSeriesList.Create;
    try
      { get selected list of series }
      if MultiSelect then { 5.01 }
      begin
         for t:=0 to Items.Count-1 do
             if Selected[t] then tmpList.Add(Series[t])
      end
      else tmpList.Add(Series[ItemIndex]);

      FirstTime:=True;
      NewClass:=nil;

      { change all selected... }
      for t:=0 to tmpList.Count-1 do
      begin
        tmpSeries:=tmpList[t];
        if FirstTime then
        begin
          NewClass:=TeeChangeGalleryProc(Owner,tmpSeries);
          FirstTime:=False;
        end
        else ChangeSeriesType(tmpSeries,NewClass);
        tmpList[t]:=tmpSeries;
      end;

      { reset the selected list... }
      for t:=0 to tmpList.Count-1 do
      begin
        tmp:=Items.IndexOfObject(tmpList[t]);
        if tmp<>-1 then SelectSeries(tmp);
      end;
    finally
      tmpList.Free;
    end;
    { refill and repaint list }
    DoRefresh;
    { tell the series designer we have changed... }
    RefreshDesigner;
  end;
end;

procedure TChartListBox.DblClick;

  Function IsSelected(tmp:Integer):Boolean;  { 5.01 }
  begin
    if MultiSelect then result:=Selected[tmp]
                   else result:=ItemIndex=tmp;
  end;

var p        : TPoint;
    tmp      : Integer;
    tmpColor : TColor;
begin
  ComingFromDoubleClick:=True;

  { find series at mouse position "p" }
  tmp:=SeriesAtMousePos(p);
  if (tmp<>-1) and IsSelected(tmp) then
  begin
    if PointInSection(p,0) and FEnableChangeType then ChangeTypeSeries(Self)
    else
    if PointInSection(p,2) and FEnableChangeColor then
    begin
      if TSeriesAccess(Series[tmp]).IUseSeriesColor then
      With Series[tmp] do
      begin
        tmpColor:=SeriesColor;
        if EditColorDialog(Self,tmpColor) then
        begin
          SeriesColor:=tmpColor;
          ColorEachPoint:=False;
          if Assigned(FOnChangeColor) then
             FOnChangeColor(Self,Series[tmp]);
        end;
      end;
    end
    else
    if PointInSection(p,3) then
       if Assigned(FOnEditSeries) then FOnEditSeries(Self,tmp);
  end;
end;

{$IFNDEF CLX}
{$IFDEF D6}
function TChartListBox.GetItemIndex: Integer;
begin
  result:=inherited GetItemIndex;
  if Count=0 then result:=-1;
end;
{$ENDIF}
{$ENDIF}

procedure TChartListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
var tmp : Integer;
    t   : Integer;
    p   : TPoint;
begin
  HideEditor;

  if ItemIndex<>-1 then
  begin
    tmp:=SeriesAtMousePos(p);
    if (tmp<>-1) and (PointInSection(p,1)) then
    begin

      if CheckStyle=cbsCheck then
         with Series[tmp] do Active:=not Active
      else
         for t:=0 to Items.Count-1 do Series[t].Active:=t=tmp;

      if not Assigned(Series[tmp].ParentChart) then Self.Repaint;

      if Assigned(FOnChangeActive) then
         FOnChangeActive(Self,Series[tmp]); // 6.02
    end
    else
    if FEnableDragSeries and
       PointInSection(p,3) and (not ComingFromDoubleClick) and
       (not (ssShift in Shift)) and
       (not (ssCtrl in Shift)) and
       ( ( ssLeft in Shift) ) then
            BeginDrag(False);

    ComingFromDoubleClick:=False;

    if Assigned(FOtherItemsChange) then
       FOtherItemsChange(Self);
  end;
end;

Procedure TChartListBox.MoveCurrentUp;
begin
  if ItemIndex>0 then SwapSeries(ItemIndex,ItemIndex-1);
end;

Procedure TChartListBox.MoveCurrentDown;
begin
  if (ItemIndex<>-1) and (ItemIndex<Items.Count-1) then
     SwapSeries(ItemIndex,ItemIndex+1);
end;

{ Delete the current selected Series, if any. Returns True if deleted }
Function TChartListBox.DeleteSeries:Boolean;

  Procedure DoDelete;
  Var t : Integer;
  begin
    if MultiSelect then { 5.01 }
    begin
      t:=0;
      While t<Items.Count do
      if Selected[t] then Series[t].Free
                     else Inc(t);
    end
    else
    if ItemIndex<>-1 then Series[ItemIndex].Free;

    if Items.Count>0 then SelectSeries(0);

    DoRefresh;
    RefreshDesigner;
  end;

var tmpSt : String;
begin
  result:=False;

  if AnySelected then { 5.01 }
    if FAskDelete then
    begin
      if (not MultiSelect) or (SelCount=1) then  { 5.01 }
         tmpSt:=SeriesTitleOrName(SelectedSeries)
      else
         tmpSt:=TeeMsg_SelectedSeries;

      if TeeYesNoDelete(tmpSt,Self) then
      begin
        DoDelete;
        result:=True;
      end;
    end
    else
    begin
      DoDelete;
      result:=True;
    end;
end;

Procedure TChartListBox.CloneSeries;
begin { duplicate current selected series }
  if ItemIndex<>-1 then
  begin
    CloneChartSeries(SelectedSeries);
    RefreshDesigner;
  end;
end;

procedure TChartListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  Case Key of
    {$IFDEF CLX}
    Key_Insert
    {$ELSE}
    VK_INSERT
    {$ENDIF}:  if FAllowAdd then AddSeriesGallery;

    {$IFDEF CLX}
    Key_Delete
    {$ELSE}
    VK_DELETE
    {$ENDIF}:  if FAllowDelete then DeleteSeries;

    {$IFDEF CLX}
    Key_F2
    {$ELSE}
    VK_F2
    {$ENDIF}:  if Assigned(SelectedSeries) then ShowEditor;
  end;
end;

procedure TChartListBox.EditorPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) or (Key=#27) then Key:=#0; // avoid "beep"
end;

procedure TChartListBox.EditorKey(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    TeeKey_Escape,
    TeeKey_F2,
    TeeKey_Up,
    TeeKey_Down,
    TeeKey_Return: if Assigned(FEditor) and FEditor.Visible then
                   begin
                     if Key<>TeeKey_Escape then
                        TChartSeries(FEditor.Tag).Title:=FEditor.Text;
                     FEditor.Hide;
                     SetFocus;
                     Invalidate;
                   end;
  end;
end;

procedure TChartListBox.HideEditor;
var c : Word;
begin
  c:=TeeKey_Return;
  EditorKey(FEditor,c,[]);
end;

Procedure TChartListBox.ShowEditor;
var R : TRect;
begin
  if Assigned(SelectedSeries) and ShowSeriesTitle then
  begin
    if not Assigned(FEditor) then
       FEditor:=TEdit.Create(Self);

    with FEditor do
    begin
      Parent:=Self;
      Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(SelectedSeries);
      Text:=SeriesTitleOrName(SelectedSeries);
      Width:=Sections[3].Width;
      Left:=SectionLeft(3)-2;
      R:=ItemRect(ItemIndex);
      Top:=R.Top;
      Height:=R.Bottom-R.Top+1;
      OnKeyDown:=EditorKey;
      OnKeyPress:=EditorPress;
      Show;
      SetFocus;
    end;
  end;
end;

Function TChartListBox.RenameSeries:Boolean; { 5.02 }
var tmp       : Integer;
    tmpSeries : TChartSeries;
    tmpSt     : String;
    Old       : String;
begin
  result:=False;
  tmp:=ItemIndex;

  if tmp<>-1 then
  begin
    tmpSeries:=SelectedSeries;

    if FNames then tmpSt:=tmpSeries.Name  // 7.0
              else tmpSt:=SeriesTitleOrName(tmpSeries);
    Old:=tmpSt;

    if InputQuery(TeeMsg_ChangeSeriesTitle,
                  TeeMsg_NewSeriesTitle,tmpSt) then
    begin
      if tmpSt<>'' then
         if FNames then
         begin
           tmpSeries.Name:=tmpSt;
           Items[tmp]:=tmpSt;
         end
         else
         if tmpSt=tmpSeries.Name then tmpSeries.Title:=''
                                 else tmpSeries.Title:=tmpSt;

      // return True if the Series title has been changed

      if FNames then result:=Old<>tmpSeries.Name
                else result:=Old<>SeriesTitleOrName(tmpSeries);
    end;

    SelectSeries(tmp);
  end;
end;

Procedure TChartListBox.RefreshDesigner;
begin
  if Assigned(Chart) and Assigned(Chart.Designer) then Chart.Designer.Refresh;
end;

Function TChartListBox.AddSeriesGallery:TChartSeries;
var t : Integer;
begin
  if Assigned(TeeAddGalleryProc) then
  begin
    result:=TeeAddGalleryProc(Owner,Chart,SelectedSeries);

    if Assigned(result) then
    begin
      if MultiSelect then // 5.01
         for t:=0 to Items.Count-1 do Selected[t]:=False;

      SelectSeries(Items.IndexOfObject(result));

      DoRefresh;
      RefreshDesigner;
    end;
  end
  else result:=nil;
end;

procedure TChartListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(Chart) and (AComponent=Chart) then
     Chart:=nil;
end;

{$IFNDEF CLX}
procedure TChartListBox.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  FHitTest:=SmallPointToPoint(Msg.Pos);
end;

procedure TChartListBox.WMSetCursor(var Msg: TWMSetCursor);
var I: Integer;
begin
  if csDesigning in ComponentState then Exit;

  if (Items.Count>0) and (SeriesAtMousePos(FHitTest)<>-1) and
     (Msg.HitTest=HTCLIENT) then

     for I:=0 to 2 do  { don't count last section }
     begin
       if PointInSection(FHitTest,I) then
       begin
         if ((I=0) and FEnableChangeType) or
            ((I=2) and FEnableChangeColor) then
         begin
           SetCursor(Screen.Cursors[crHandPoint]);
           Exit;
         end
         else break;
       end;
     end;

  inherited;
end;

{$ELSE}

procedure TChartListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var I : Integer;
    P : TPoint;
begin
  if csDesigning in ComponentState then Exit;

  P:=TeePoint(X,Y);
  if (Items.Count>0) and (SeriesAtMousePos(P)<>-1) then

     for I:=0 to 2 do  { don't count last section }
     begin
       if PointInSection(P,I) then
       begin
         if ((I=0) and FEnableChangeType) or
            ((I=2) and FEnableChangeColor) then
         begin
           Cursor:=crHandPoint;
           Exit;
         end
         else break;
       end;
     end;
  Cursor:=crDefault;
end;
{$ENDIF}

procedure TChartListBox.UpdateSeries;
begin
  FillSeries(SelectedSeries);
end;

Function TChartListBox.GetShowActive:Boolean;
begin
  result:=Sections[1].Visible;
end;

procedure TChartListBox.SetShowActive(Value:Boolean);
begin
  Sections[1].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowIcon:Boolean;
begin
  result:=Sections[0].Visible;
end;

procedure TChartListBox.SetShowIcon(Value:Boolean);
begin
  Sections[0].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowColor:Boolean;
begin
  result:=Sections[2].Visible;
end;

procedure TChartListBox.SetShowColor(Value:Boolean);
begin
  Sections[2].Visible:=Value; Repaint;
end;

Function TChartListBox.GetShowTitle:Boolean;
begin
  result:=Sections[3].Visible;
end;

procedure TChartListBox.SetShowTitle(Value:Boolean);
begin
  Sections[3].Visible:=Value; Repaint;
end;

procedure TChartListBox.SelectAll;
{$IFNDEF D6}
var t : Integer;
{$ENDIF}
begin
  if MultiSelect then { 5.01 }
  begin
    {$IFDEF D6}
    inherited;
    {$ELSE}
    for t:=0 to Items.Count-1 do Selected[t]:=True;
    {$ENDIF}
    RefreshDesigner;
  end;
end;

Function TChartListBox.GetSeries(Index:Integer):TChartSeries;
begin
  if (Index<>-1) and (Index<Items.Count) then
     result:=TChartSeries(Items.Objects[Index])
  else
     result:=nil;
end;

procedure TChartListBox.TeeEvent(Event:TTeeEvent);
var tmp : Integer;
begin
  if not (csDestroying in ComponentState) then
  if Event is TTeeSeriesEvent then
  With TTeeSeriesEvent(Event) do
  Case Event of
    seChangeColor,
    seChangeActive: Invalidate;
    seChangeTitle: begin
                     tmp:=Items.IndexOfObject(Series);
                     if tmp<>-1 then
                        Items[tmp]:=SeriesTitleOrName(Series);
                   end;
    seRemove: begin
                tmp:=Items.IndexOfObject(Series);
                if tmp<>-1 then
                begin
                  Items.Delete(tmp);
                  if Assigned(FOtherItems) then FOtherItems.Delete(tmp);
                  if Assigned(FOnRemovedSeries) then
                     FOnRemovedSeries(Self,Series); { 5.02 }
                end;
              end;
      seAdd,
      seSwap: UpdateSeries;
  end;
end;

{$IFNDEF D6}
Procedure TChartListBox.ClearSelection;
var t: Integer;
begin
  if MultiSelect then
     for t:=0 to Items.Count-1 do Selected[t]:=False
  else
     ItemIndex:=-1;
end;
{$ENDIF}

{$IFNDEF CLX}
Procedure TChartListBox.SetParent(Control:TWinControl);
begin
  inherited;

  if Assigned(Parent) and (Items.Count=0) and (ItemIndex<>-1) then
     ItemIndex:=-1;
end;
{$ENDIF}

end.

