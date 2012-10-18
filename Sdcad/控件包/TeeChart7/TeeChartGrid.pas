{******************************************}
{   TeeChart VCL Library                   }
{ Copyright (c) 1995-2004 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeChartGrid;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QControls, QGrids, QGraphics, QExtCtrls, Qt, Types,
     {$ELSE}
     Controls, Grids, Graphics, ExtCtrls,
     {$ENDIF}
     Classes, Chart, TeEngine, TeeProcs, TeCanvas, TeeNavigator;

type
  TChartGridNavigator=class;

  TChartGridShow=(cgsAuto,cgsNo,cgsYes);

  TCustomChartGrid=class;

  TEditingCellEvent=procedure (Sender: TCustomChartGrid; ACol, ARow: Integer;
                               var Allow:Boolean) of object;

  TCustomChartGrid=class(TCustomGrid,ITeeEventListener)
  private
    FChart      : TCustomChart;
    FColors     : Boolean;
    FGrid3DMode : Boolean;
    FLabels     : Boolean;
    FXValues    : TChartGridShow;
    FOldValue   : String;
    FOnChangeColor : TNotifyEvent;
    FOnEditing  : TEditingCellEvent;
    FOnSetCell  : TSetEditEvent;
    FShowFields : Boolean;
    FWasNull    : Boolean;

    IHasNo     : Array[0..1000] of Boolean;
    INavigator : TChartGridNavigator;
    FSeries    : TChartSeries;
    ISeriesChart : TCustomAxisPanel;

    Procedure AddListener(AChart:TCustomAxisPanel); // 5.03
    Function FirstRowNum:Integer;
    Function ColorsColumn:Integer;
    Function LabelsColumn:Integer;
    procedure NotifyChange;
    procedure Regenerate;
    Procedure RemoveListener(AChart:TCustomAxisPanel); // 5.03
    Procedure SetBooleanProperty(Var Variable:Boolean; Value:Boolean);
    Procedure SetChart(AChart:TCustomChart);
    Procedure SetGrid3DMode(Value:Boolean);
    Procedure SetManualData(ASeries:TChartSeries);
    Procedure SetNavigator(ANavigator:TChartGridNavigator);
    Procedure SetShowColors(Value:Boolean);
    Procedure SetShowFields(Value:Boolean);
    Procedure SetShowLabels(Value:Boolean);
    Procedure SetShowXValues(Value:TChartGridShow);
    procedure SetSeries(const Value: TChartSeries);
  protected
    FActiveChanged   : TNotifyEvent;
    FSelectedChanged : TSelectCellEvent;

    function CanEditModify: Boolean; override;
    function CanEditShow: Boolean; override;
    procedure DblClick; override;
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
                       AState: TGridDrawState); override;

    function GetEditText(ACol, ARow: Integer): {$IFDEF CLX}WideString{$ELSE}String{$ENDIF}; override;

    Function GetSeriesColor(var AColor:TColor):TChartSeries;

    Function HasPoints:Boolean;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    Procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function SelectCell(ACol, ARow: Integer): Boolean; override;

    procedure SetEditText(ACol, ARow: Integer;
         const Value: {$IFDEF CLX}WideString{$ELSE}String{$ENDIF}); override;
    procedure TeeEvent(Event: TTeeEvent);
  public
    { Allow changing cells even if Series.DataSource is assigned }
    AllowChanges : Boolean; { 5.02 }

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure AppendRow;

    Procedure ChangeColor; overload;
    Procedure ChangeColor(AColor:TColor); overload;
    Procedure ChangeColor(ASeries:TChartSeries; AColor:TColor); overload;

    Procedure Delete;
    Function FindXYZIndex(ASeries:TChartSeries; ARow,ACol:Integer):Integer;
    Function GetSeries(ACol:Integer; Var AList:TChartValueList):TChartSeries;
    Function GetXYZSeries:TChartSeries;
    Procedure Insert;
    Procedure RecalcDimensions;

    {$IFDEF TEEOCX}
    procedure SetFocus; override;
    {$ENDIF}

    Procedure StartEditing;
    Procedure StopEditing(Cancel:Boolean);

    property Chart:TCustomChart read FChart write SetChart;
    property Series:TChartSeries read FSeries write SetSeries;
    property ShowColors:Boolean read FColors write SetShowColors default False;
    property ShowFields:Boolean read FShowFields write SetShowFields default True;
    property ShowLabels:Boolean read FLabels write SetShowLabels default True;
    property ShowXValues:TChartGridShow read FXValues write SetShowXValues default cgsAuto;

    property FixedCols default 1;
    property DefaultRowHeight default {$IFDEF LINUX}20{$ELSE}16{$ENDIF};
    property Grid3DMode:Boolean read FGrid3DMode write
             SetGrid3DMode default False; // for XYZ series, set x by z grid mode
    property GridLineWidth default 1;

    {$IFDEF CLR}
    property Col;
    property EditorMode;
    property Options;
    property Row;
    property RowCount;
    {$ENDIF}
    
    { events }
    property OnChangeColor:TNotifyEvent read FOnChangeColor write FOnChangeColor; { 5.02 }
    property OnEditingCell:TEditingCellEvent read FOnEditing write FOnEditing; // 7.0
    property OnSetEditText:TSetEditEvent read FOnSetCell write FOnSetCell; { 5.02 }
  end;

  TChartGrid=class(TCustomChartGrid)
  public
    property Col;
    property ColCount;

    {$IFNDEF CLR}
    property ColWidths;
    {$ENDIF}

    property EditorMode;
    property GridHeight;
    property GridWidth;
    property LeftCol;
    property Selection;
    property Row;
    property RowCount;

    {$IFNDEF CLR}
    property RowHeights;
    property TabStops;
    {$ENDIF}

    property TopRow;
  published
    property Align;
    property Anchors;
    {$IFNDEF CLX}
    property BiDiMode;
    {$ENDIF}
    property BorderStyle;
    property Color;
    property Constraints;
    {$IFNDEF CLX}
    property Ctl3D;
    {$ENDIF}
    property DefaultColWidth;
    property DefaultRowHeight;
    property DefaultDrawing;
    property DragMode;
    {$IFNDEF CLX}
    property DragCursor;
    property DragKind;
    {$ENDIF}
    property Enabled;
    property FixedColor;
    property Font;
    property GridLineWidth;
    property Options;
    {$IFNDEF CLX}
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    { events }
    property OnClick;
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    {$IFNDEF CLX}
    property OnEndDock;
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    {$IFNDEF CLX}
    property OnStartDock;
    {$ENDIF}

    property Chart;
    property Series;
    property ShowColors; { 5.02 }
    property ShowLabels;
    property ShowXValues; { 5.02 }

    { event }
    property OnChangeColor; // 7.0
    property OnEditingCell; // 7.0
    property OnSetEditText;
  end;

  TChartGridNavigator=class(TCustomTeeNavigator)
  private
    FGrid : TCustomChartGrid;
    procedure ActiveChanged(Sender:TObject);
    procedure EnableButtonsColRow(ACol,ARow:Integer);
    procedure SelectedChanged(Sender: TObject; ACol, ARow: Integer;
                              var CanSelect: Boolean);
    procedure SetGrid(Value:TCustomChartGrid);
  protected
    procedure BtnClick(Index: TTeeNavigateBtn); override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    procedure EnableButtons; override;
  published
    property Grid:TCustomChartGrid read FGrid write SetGrid;
  end;

implementation

Uses Math, SysUtils, TeeConst, TeePenDlg;

{ TChartGridNavigator }
procedure TChartGridNavigator.Notification( AComponent: TComponent;
                                        Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(Grid) and (AComponent=Grid) then
     Grid:=nil;
end;

procedure TChartGridNavigator.SetGrid(Value:TCustomChartGrid);
begin
  if FGrid<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FGrid) then
       FGrid.RemoveFreeNotification(Self);
    {$ENDIF}

    FGrid:=Value;

    if Assigned(FGrid) then
    begin
      FGrid.FreeNotification(Self);
      FGrid.FActiveChanged:=ActiveChanged;
      FGrid.FSelectedChanged:=SelectedChanged;
      FGrid.SetNavigator(Self);
    end;

    EnableButtons;
  end;
end;

procedure TChartGridNavigator.ActiveChanged(Sender:TObject);
begin
  EnableButtons;
end;

procedure TChartGridNavigator.BtnClick(Index: TTeeNavigateBtn);
begin
  if Assigned(FGrid) then
  with FGrid do
  begin
    case Index of
      nbPrior : if Row>FirstRowNum then Row:=Row-1;
      nbNext  : if Row<RowCount-1 then Row:=Row+1;
      nbFirst : if Row>FirstRowNum then Row:=FirstRowNum;
      nbLast  : if Row<RowCount-1 then Row:=RowCount-1;
      nbInsert: Insert;
      nbEdit  : begin
                  SetFocus;
                  StartEditing;
                end;
      nbCancel: StopEditing(True);
      nbPost  : StopEditing(False);
      nbDelete: Delete;
    end;
  end;
  inherited;
end;

procedure TChartGridNavigator.EnableButtons;
begin
  inherited;
  if Assigned(FGrid) then EnableButtonsColRow(FGrid.Col,FGrid.Row);
end;

procedure TChartGridNavigator.EnableButtonsColRow(ACol,ARow:Integer);
var UpEnable : Boolean;
    DnEnable : Boolean;
begin
  UpEnable := ARow>FGrid.FirstRowNum;
  DnEnable := ARow<FGrid.RowCount-1;
  Buttons[nbFirst].Enabled  := UpEnable;
  Buttons[nbPrior].Enabled  := UpEnable;
  Buttons[nbNext].Enabled   := DnEnable;
  Buttons[nbLast].Enabled   := DnEnable;
  Buttons[nbInsert].Enabled := (goEditing in FGrid.Options) and
                               (not FGrid.EditorMode) and
                               (Assigned(FGrid.Chart) and (FGrid.Chart.SeriesCount>0)) or
                               Assigned(FGrid.Series);

  Buttons[nbDelete].Enabled := (FGrid.RowCount>1) and
                               Buttons[nbInsert].Enabled and
                               FGrid.HasPoints;
  Buttons[nbPost].Enabled   := FGrid.EditorMode;
  Buttons[nbEdit].Enabled   := Buttons[nbInsert].Enabled;
  Buttons[nbCancel].Enabled := FGrid.EditorMode;
end;

procedure TChartGridNavigator.SelectedChanged(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  EnableButtonsColRow(ACol,ARow);
end;

{ TCustomChartGrid }
Constructor TCustomChartGrid.Create(AOwner:TComponent);
begin
  inherited;
  FSaveCellExtents:=False;
  FColors:=False;
  FLabels:=True;
  FXValues:=cgsAuto;
  FShowFields:=True;
  FWasNull:=False;
  GridLineWidth:=1;
  ColWidths[0]:=30;
  DefaultRowHeight:={$IFDEF LINUX}20{$ELSE}16{$ENDIF};
  FixedCols:=1;
  RowHeights[0]:=20;

  Options:=[ goHorzLine,
             goVertLine,
             goRangeSelect,
             goDrawFocusSelected,
             goRowSizing,
             goColSizing,
             goEditing,
             goTabs,
             goThumbTracking
           ];

  RecalcDimensions;
end;

Destructor TCustomChartGrid.Destroy;
begin
  Series:=nil; // 5.03
  Chart:=nil;
  inherited;
end;

Procedure TCustomChartGrid.Loaded;
begin
  inherited;
  RowHeights[0]:=20;
end;

Function TCustomChartGrid.HasPoints:Boolean;
var t: Integer;
begin
  result:=False;
  if Assigned(FSeries) then { single series }
     result:=FSeries.Count>0
  else
  if Assigned(Chart) then { all series in chart }
  With Chart do
  for t:=0 to SeriesCount-1 do
  if Series[t].Count>0 then
  begin
    result:=True;
    Exit;
  end;
end;

Function TCustomChartGrid.FirstRowNum:Integer;
begin
  if ShowFields then result:=2 else result:=1;
end;

function TCustomChartGrid.SelectCell(ACol, ARow: Integer): Boolean;
begin
  result:=inherited SelectCell(ACol,ARow) and (ACol>0) and (ARow>=FirstRowNum);
  // Call event
  if result and Assigned(FSelectedChanged) then
     FSelectedChanged(Self,ACol,ARow,result);
end;

function TCustomChartGrid.CanEditModify: Boolean;
begin
  result:=inherited CanEditModify;
  if result then
     if Assigned(INavigator) then INavigator.ActiveChanged(Self);
end;

procedure TCustomChartGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                     X, Y: Integer);

  Procedure SelectColumn;
  var tmpCoord     : TGridCoord;
      tmpSelection : TGridRect;
  begin
    tmpCoord:=MouseCoord(x,y);
    if (tmpCoord.X>FixedCols) and (tmpCoord.Y<FixedRows) then
    begin
      with tmpSelection do
      begin
        Left:=tmpCoord.X;
        Right:=Left;
        Top:=FixedRows;
        Bottom:=RowCount-1;
      end;
      Selection:=tmpSelection;
    end;
  end;

begin
  inherited;

  if FGridState=gsNormal then SelectColumn;

  if Assigned(INavigator) then INavigator.ActiveChanged(Self);
end;

Procedure TCustomChartGrid.StopEditing(Cancel:Boolean);
begin
  if EditorMode then
  begin
    if Cancel then InplaceEditor.Text:=''; // 5.02

    HideEditor;

    if Cancel and (not FWasNull) then SetEditText(Col,Row,FOldValue);

    NotifyChange;
  end;
end;

{$IFDEF TEEOCX}
procedure TCustomChartGrid.SetFocus;  // 6.02
begin
  if GetParentForm(Self)<>nil then inherited
                              else Windows.SetFocus(Handle);
end;
{$ENDIF}

Procedure TCustomChartGrid.StartEditing;
var tmpList   : TChartValueList;
    tmpSeries : TChartSeries;
begin
  if (goEditing in Options) and (not EditorMode) then
  begin
    if Col>0 then
    begin
      tmpSeries:=GetSeries(Col,tmpList);
      if Assigned(tmpSeries) then
      With tmpSeries do
      if (DataSource=nil) or Self.AllowChanges then { 5.02 }
      begin
        if Grid3DMode then
           FWasNull:=Row>tmpSeries.MaxZValue
        else
           FWasNull:=(Row>Count) or (IsNull(Row-1));
        if FWasNull then FOldValue:=''
                    else FOldValue:=GetEditText(Col,Row);
        EditorMode:=True;
        NotifyChange;
      end;
    end;
  end;
end;

procedure TCustomChartGrid.KeyDown(var Key: Word; Shift: TShiftState);
var tmpList   : TChartValueList;
    tmpSeries : TChartSeries;
    tmpCol    : Integer;
    tmpRow    : Integer;
begin
  if (not (ssCtrl in Shift)) then
  begin
    Case Key of
      TeeKey_Escape : StopEditing(True);

      TeeKey_F2     : if FColors and (Col=ColorsColumn) then
                         ChangeColor
                      else
                         StartEditing;

      TeeKey_Up     :
            if (Row=RowCount-1) then  // last row
            begin
              if FColors and (Col=ColorsColumn) then tmpCol:=Succ(Col)
                                                else tmpCol:=Col;
              tmpSeries:=GetSeries(tmpCol,tmpList);
              tmpRow:=Row-FirstRowNum;
              if Assigned(tmpSeries) and
                 (tmpSeries.Count>tmpRow) and  { 5.01 }
                 tmpSeries.IsNull(tmpRow) and
                 (tmpSeries.Labels[tmpRow]='') then
              begin
                RowCount:=RowCount-1;
                tmpSeries.Delete(Row-FirstRowNum+1);
              end
              else inherited; { 5.01 }
            end
            else inherited;

      TeeKey_Down :
            begin
              if Row=RowCount-1 then AppendRow
                                else inherited;
            end;

      TeeKey_Insert : Insert;

      TeeKey_Delete : if ssCtrl in Shift then Delete
                      else
                      begin
                        if not EditorMode then EditorMode:=True;
                        inherited;
                      end;
      TeeKey_Return,
      TeeKey_Space  : if FColors and (Col=ColorsColumn) then
                         ChangeColor
                      else
                         inherited;
    else inherited;
    end;
  end
  else inherited;
end;

Procedure TCustomChartGrid.AppendRow;
var tmpCol : Integer;
    tmpSeries : TChartSeries;
    tmpList   : TChartValueList;
begin
  if (goEditing in Options) and (not Grid3DMode) then  // 7.0
  begin
    if FColors and (Col=ColorsColumn) then tmpCol:=Succ(Col)
                                      else tmpCol:=Col;
    tmpSeries:=GetSeries(tmpCol,tmpList);
    if Assigned(tmpSeries) then
    begin
      tmpSeries.AddNull;
      RowCount:=RowCount+1;
      Row:=RowCount-1;
    end;
  end
end;

Function TCustomChartGrid.FindXYZIndex(ASeries:TChartSeries;
                                       ARow,ACol:Integer):Integer;
var tmpList : TChartValueList;
    t       : Integer;
begin
  result:=-1;
  tmpList:=ASeries.GetYValueList('Z');

  for t:=0 to ASeries.Count-1 do
  if (tmpList.Value[t]=ARow+1) and
     (ASeries.NotMandatoryValueList.Value[t]=ACol) then
  begin
    result:=t;
    break;
  end;
end;

function TCustomChartGrid.GetEditText(ACol,ARow: Integer): {$IFDEF CLX}WideString{$ELSE}String{$ENDIF};

  Function GetALabel(Index:Integer):String;
  var t : Integer;
  begin
    result:='';
    if Assigned(FSeries) then result:=FSeries.Labels[Index]
    else
    // return first Label found
    for t:=0 to FChart.SeriesCount-1 do
    With FChart.Series[t] do
    if Labels.Count>Index then  { 5.01 }
    begin
      result:=Labels[Index];
      break;
    end;
  end;

var tmpSeries : TChartSeries;
    tmpList   : TChartValueList;

  Procedure FindHeaderText;
  begin
    if FLabels and (ACol=LabelsColumn) then { 5.02 }
       result:=TeeMsg_Text
    else
    if FColors and (ACol=ColorsColumn) then
       result:=TeeMsg_Colors
    else
    if ShowFields and (ACol>LabelsColumn) then
    begin
       tmpSeries:=GetSeries(ACol,tmpList);
       if Assigned(tmpSeries) then
          if Grid3DMode then
             result:=IntToStr(Round(tmpSeries.MinXValue)+ACol-1)
          else
          if Assigned(tmpList) then result:=tmpList.Name;
    end;
  end;

  Function GetAValue:String;
  var tmpValue : TDateTime;
  begin

    tmpSeries:=GetSeries(ACol,tmpList);

    if Assigned(tmpSeries) and (tmpSeries.Count>ARow) then
       if tmpList.DateTime then
       begin
         tmpValue:=tmpList.Value[ARow];
         if tmpValue<1 then result:=TimeToStr(tmpValue)
                       else result:=DateTimeToStr(tmpValue);
       end
       else
          result:=FormatFloat(tmpSeries.ValueFormat,tmpList.Value[ARow])
    else
       result:='';
  end;

var t : Integer;
begin
  result:='';
  if ACol=0 then // First column
  begin
    if ARow>=FirstRowNum then
       if Grid3DMode then
       begin
         tmpSeries:=GetXYZSeries;
         result:=IntToStr(Round(tmpSeries.MinZValue)+ARow-FirstRowNum);
       end
       else
          Str(ARow-FirstRowNum,Result)
    else
    if (not ShowFields) or (ARow=1) then
       result:='#';
  end
  else
  begin
    if ((not ShowFields) and (ARow=0)) or
       (ShowFields and (ARow=1)) then FindHeaderText // Header
    else // Values
    if ARow>=FirstRowNum then
    begin
      Dec(ARow,FirstRowNum);

      if Grid3DMode then
      begin
        tmpSeries:=GetXYZSeries;
        t:=FindXYZIndex(tmpSeries,ARow,ACol);
        if t<>-1 then
           result:=FormatFloat(tmpSeries.ValueFormat,
                               tmpSeries.MandatoryValueList.Value[t]);
      end
      else
      if FLabels and (ACol=LabelsColumn) then
         result:=GetALabel(ARow)
      else
      if FColors and (ACol=ColorsColumn) then
      else
         result:=GetAValue;
    end;
  end;
end;

Procedure TCustomChartGrid.SetGrid3DMode(Value:Boolean);
begin
  FGrid3DMode:=Value;
  Regenerate;
  Repaint;
end;

type TSeriesAccess=class(TChartSeries);

Procedure TCustomChartGrid.SetManualData(ASeries:TChartSeries);
begin
  TSeriesAccess(ASeries).ManualData:=True;
end;

procedure TCustomChartGrid.SetEditText(ACol, ARow: Integer;
                     const Value: {$IFDEF CLX}WideString{$ELSE}string{$ENDIF});

  Procedure SetALabel(Index:Integer; Const AValue:String);

    Procedure SetLabelSeries(ASeries:TChartSeries);
    begin
      While Index>=ASeries.Count do ASeries.AddNull('');
      ASeries.Labels[Index]:=AValue;
    end;

  var t : Integer;
  begin
    if Assigned(Series) then SetLabelSeries(Series)
    else
    for t:=0 to Chart.SeriesCount-1 do SetLabelSeries(Chart[t]);
  end;

  Procedure SetAllManualData;
  var t : Integer;
  begin
    if Assigned(Series) then SetManualData(Series)
    else
    for t:=0 to Chart.SeriesCount-1 do SetManualData(Chart[t]);
  end;

var tmpSeries : TChartSeries;
    tmpList   : TChartValueList;
    tmpRow    : Integer;
begin
  inherited;

  if Assigned(FSeries) or (Assigned(FChart) and (FChart.SeriesCount>0)) then
  try
    SetAllManualData;

    Dec(ARow,FirstRowNum);

    if FLabels and (ACol=LabelsColumn) then // Labels
       SetALabel(ARow,Value)
    else
    if FColors and (ACol=ColorsColumn) then // Colors
    else
    begin // Values

      tmpSeries:=GetSeries(ACol,tmpList);

      if Assigned(tmpSeries) then
      begin
        if Grid3DMode then
        begin
          tmpRow:=FindXYZIndex(tmpSeries,ARow,ACol);
          tmpList:=tmpSeries.MandatoryValueList;
        end
        else
        begin
          While ARow>=tmpSeries.Count do tmpSeries.AddNull;
          tmpRow:=ARow;
        end;

        if Trim(Value)='' then // 5.03
        begin
          if not EditorMode then
          begin
            tmpSeries.ValueColor[tmpRow]:=clNone;
            Invalidate;
          end;
        end
        else
        begin
          if tmpList.DateTime then
             tmpList.Value[tmpRow]:=StrToDateTime(Value)
          else
             tmpList.Value[tmpRow]:=StrToFloat(Value);
          tmpList.Modified:=True;

          if tmpSeries.IsNull(tmpRow) then
          begin
            tmpSeries.ValueColor[tmpRow]:=clTeeColor;
            if FColors then Self.Repaint; // 5.02
          end;
        end;

        tmpSeries.RefreshSeries; 
      end;

      { Repaint Series and / or Chart }
      if Assigned(FSeries) then FSeries.Repaint
                           else FChart.Repaint;
    end;

    { call event }
    if Assigned(FOnSetCell) then
       FOnSetCell(Self,ACol,ARow+FirstRowNum,Value);

  except { hide exception }
    on EConvertError do ;
  end;
end;

Function TCustomChartGrid.GetXYZSeries:TChartSeries;
var t : Integer;
begin
  result:=nil;
  if Assigned(FChart) then
  begin
    for t:=0 to FChart.SeriesCount-1 do
        if FChart[t].HasZValues then
        begin
          result:=FChart[t];
          break;
        end;
  end
  else
  if Assigned(FSeries) and FSeries.HasZValues then
     result:=FSeries;
end;

// Returns series and series valuelist for the ACol column parameter
Function TCustomChartGrid.GetSeries(ACol:Integer; Var AList:TChartValueList):TChartSeries;
var tmp : Integer;
    t   : Integer;
begin
  AList:=nil;

  if Grid3DMode then result:=GetXYZSeries
  else
  begin
    if FLabels then Dec(ACol);
    if FColors then Dec(ACol);

    if ACol>=0 then
    begin
      if Assigned(FSeries) then
      begin
        tmp:=FSeries.ValuesList.Count;
        if not IHasNo[0] then Dec(tmp);

        if (tmp>=ACol) then
        begin
          result:=FSeries;
          if IHasNo[0] then
             AList:=result.ValuesList[ACol-1]
          else
          if result.YMandatory then
             AList:=result.ValuesList[ACol]
          else
             AList:=result.ValuesList[ACol-1];
          exit;
        end;
      end
      else
      if Assigned(FChart) then
      for t:=0 to FChart.SeriesCount-1 do
      begin
        tmp:=FChart.Series[t].ValuesList.Count;
        if not IHasNo[t] then Dec(tmp);

        if (tmp>=ACol) then
        begin
          result:=FChart.Series[t];
          if IHasNo[t] then
             AList:=result.ValuesList[ACol-1]
          else
          if result.YMandatory then
             AList:=result.ValuesList[ACol]
          else
             AList:=result.ValuesList[ACol-1];
          exit;
        end;
        Dec(ACol,tmp);
      end;
    end;
    result:=nil;
  end;
end;

procedure TCustomChartGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);

  Function GetSeriesCol(ACol:Integer):TChartSeries;
  var tmp : Integer;
      t   : Integer;
  begin
    if FLabels then tmp:=LabelsColumn else
    if FColors then tmp:=ColorsColumn else tmp:=0;

    if Assigned(FSeries) then
    begin
      result:=FSeries;
      exit;
    end
    else
    for t:=0 to FChart.SeriesCount-1 do
    begin
      Inc(tmp);
      if tmp=ACol then
      begin
        result:=FChart.Series[t];
        exit;
      end;
      Inc(tmp,FChart.Series[t].ValuesList.Count-2);
      if IHasNo[t] then Inc(tmp);
    end;
    result:=nil;
  end;

  Procedure FillWithColor(AColor:TColor);
  begin
    Canvas.Brush.Color:=AColor;
    Canvas.Brush.Style:=bsSolid;
    Canvas.FillRect(ARect);
  end;

var tmp       : Integer;
    tmpSeries : TChartSeries;
    AList     : TChartValueList;
    tmpSt     : String;
    tmpColor  : TColor;
begin
  if Assigned(FChart) or Assigned(FSeries) then
  begin
    tmp:=0;
    if FLabels then Inc(tmp);
    if FColors then Inc(tmp);

    if (ARow=0) and (ACol>tmp) then // Series first Header
    begin
      tmpSeries:=GetSeriesCol(ACol);

      if Assigned(FSeries) and (not ShowFields) then // 5.03
      begin
        GetSeries(ACol,AList);
        Canvas.TextRect(ARect, ARect.Left+18, ARect.Top+4,AList.Name);
      end
      else
      if Assigned(tmpSeries) then
      if (not Grid3DMode) or ((ACol-tmp)=1) then // only once for 3D mode
      begin
        With ARect do
           PaintSeriesLegend(tmpSeries,Canvas,TeeRect(Left+4,Top+4,Left+16,Top+16));
        {$IFDEF CLX}
        QPainter_setBackgroundMode(Canvas.Handle,BGMode_TransparentMode);
        {$ENDIF}
        Canvas.Brush.Style:=bsClear;
        Canvas.Pen.Style:=psSolid;
        Canvas.Font.Color:=Self.Font.Color;

        Canvas.TextRect(ARect, ARect.Left+18, ARect.Top+4,
                        SeriesTitleOrName(tmpSeries));
      end;
    end
    else
    begin
      if (ACol=0) or (ShowFields and (ARow=1)) then // Point number (#) column
         FillWithColor(FixedColor);

      if FColors and (ACol=ColorsColumn) then // Colors
      begin
        if ARow=FirstRowNum-1 then
           Canvas.TextRect(ARect, ARect.Left+2, ARect.Top+2,
              TeeMsg_Colors)
        else
        if ARow>=FirstRowNum then
        begin
          tmpSeries:=GetSeries(ACol+1,AList);

          if Assigned(tmpSeries) and (tmpSeries.Count>(ARow-FirstRowNum)) then
          begin
            tmpColor:=tmpSeries.ValueColor[ARow-FirstRowNum];
            if tmpColor=clNone then tmpColor:=Self.Color;
          end
          else tmpColor:=Self.Color;

          FillWithColor(tmpColor);
        end;
      end
      else
      if FLabels and (ACol=LabelsColumn) then // Labels
         Canvas.TextRect(ARect, ARect.Left+2, ARect.Top+2, GetEditText(ACol, ARow))
      else
      begin
        // Values

        {$IFNDEF CLX}
        {$IFNDEF CLR}Windows.{$ENDIF}SetTextAlign(Canvas.Handle,TA_RIGHT);
        {$ENDIF}

        {$IFDEF CLX}
        QPainter_setBackgroundMode(Canvas.Handle,BGMode_TransparentMode);
        {$ENDIF}

        tmpSt:=GetEditText(ACol, ARow);

        {$IFDEF CLX}
        Dec(ARect.Right,3);
        {$ENDIF}

        Canvas.TextRect(ARect,
            {$IFDEF CLX}ARect.Left{$ELSE}ARect.Right-2{$ENDIF},
            ARect.Top+2, tmpSt
           {$IFDEF CLX},Integer(AlignmentFlags_AlignRight){$ENDIF});

        {$IFNDEF CLX}
        {$IFNDEF CLR}Windows.{$ENDIF}SetTextAlign(Canvas.Handle,TA_LEFT);
        {$ENDIF}
      end;
    end;
  end;
end;

procedure TCustomChartGrid.Notification( AComponent: TComponent;
                                   Operation: TOperation);
begin
  inherited;
  if Operation=opRemove then
  begin
    if Assigned(FChart) and (AComponent=FChart) then
        Chart:=nil
    else
    if Assigned(INavigator) and (AComponent=INavigator) then
        INavigator:=nil
    else
    if Assigned(FSeries) and (AComponent=FSeries) then
        Series:=nil
  end;
end;

// Deletes current row, also deletes series points
Procedure TCustomChartGrid.Delete;

  Procedure TryDelete(ASeries:TChartSeries; AIndex:Integer);
  begin
    With ASeries do
    if (Row-FirstRowNum)<Count then
    begin
      Delete(Row-FirstRowNum);
      if not IHasNo[AIndex] then NotMandatoryValueList.FillSequence;
    end;
  end;

var t : Integer;
begin
  if goEditing in Options then // 7.0
  begin
    if Assigned(FSeries) then
       TryDelete(FSeries,0)
    else
    With FChart do
    for t:=0 to SeriesCount-1 do
        TryDelete(Series[t],t);

    if RowCount>(1+FirstRowNum) then RowCount:=RowCount-1
    else
    begin
      Repaint;
      NotifyChange;
    end;
  end;
end;

// Inserts a new row to the end (appends),
// also inserts (appends) new series points
Procedure TCustomChartGrid.Insert;
var tmpInc : Boolean;

  Procedure TryInsert(ASeries:TChartSeries);
  begin
    With ASeries do
    begin
      tmpInc:=Count>0;
      AddNullXY(Count,0);
    end;
  end;

Var t : Integer;
begin
  if goEditing in Options then  // 7.0
  begin
    tmpInc:=False;
    if Assigned(FSeries) then
       TryInsert(FSeries)
    else
    With FChart do
    for t:=0 to SeriesCount-1 do
       TryInsert(Series[t]);

    if tmpInc then RowCount:=RowCount+1;

    Row:=RowCount-1; // Go to last row
  end;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomAxisPanel);
{$ENDIF}

Procedure TCustomChartGrid.AddListener(AChart:TCustomAxisPanel); // 5.03
begin
  if Assigned(AChart) then
  begin
    AChart.FreeNotification(Self);
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(AChart).Listeners.Add(Self);
  end;
end;

Procedure TCustomChartGrid.RemoveListener(AChart:TCustomAxisPanel); // 5.03
begin
  if Assigned(AChart) and (not (csDestroying in AChart.ComponentState)) then
  begin
    {$IFDEF D5}
    AChart.RemoveFreeNotification(Self);
    {$ENDIF}
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(AChart).RemoveListener(Self);
  end;
end;

Procedure TCustomChartGrid.SetChart(AChart:TCustomChart);
begin
  if FChart<>AChart then
  begin
    RemoveListener(FChart);
    FChart:=AChart;
    AddListener(FChart);
  end;

  Regenerate;
  Repaint;     { 5.01 }
end;

Procedure TCustomChartGrid.SetNavigator(ANavigator:TChartGridNavigator);
begin
  INavigator:=ANavigator;
  if Assigned(INavigator) then INavigator.FreeNotification(Self);
end;

// Main procedure to calculate how many rows and columns should the grid have
Procedure TCustomChartGrid.RecalcDimensions;

  Function MaxNumPoints:Integer;
  var t : Integer;
  begin
    result:=0;
    if Assigned(FSeries) then result:=FSeries.Count
    else
    for t:=0 to FChart.SeriesCount-1 do
    With FChart.Series[t] do
         if (t=0) or (Count>result) then result:=Count;
  end;

var tmpCol : Integer;

  Procedure CalcParams(ASeries:TChartSeries; AIndex:Integer);
  begin
    if not (csDestroying in ASeries.ComponentState) then
    begin
      Inc(tmpCol);
      if FXValues=cgsAuto then
         IHasNo[AIndex]:=HasNoMandatoryValues(ASeries)
      else
         IHasNo[AIndex]:=FXValues=cgsYes;

      if IHasNo[AIndex] then Inc(tmpCol);
      Inc(tmpCol,ASeries.ValuesList.Count-2);
    end;
  end;

  Procedure SetXYZDimensions;
  var Values : Array of TChartValue;

    Function Find(Const Value:TChartValue):Boolean;
    var t : Integer;
    begin
      result:=False;

      for t:=0 to Length(Values)-1 do
          if Values[t]=Value then
          begin
            result:=True;
            exit;
          end;
    end;

  var tmpSeries : TChartSeries;
      t         : Integer;
      tmp       : Double;
  begin
    tmpSeries:=GetXYZSeries;
    if Assigned(tmpSeries) then
    begin
      for t:=0 to tmpSeries.Count-1 do
      begin
        tmp:=tmpSeries.ValuesList[2].Value[t];
        if not Find(tmp) then
        begin
          SetLength(Values,Length(Values)+1);
          Values[Length(Values)-1]:=tmp;
        end;
      end;

      ColCount:=1+Length(Values);
      Values:=nil;

      //1+Round(tmpSeries.MaxZValue-tmpSeries.MinZValue+1);

      for t:=0 to tmpSeries.Count-1 do
      begin
        tmp:=tmpSeries.NotMandatoryValueList.Value[t];
        if not Find(tmp) then
        begin
          SetLength(Values,Length(Values)+1);
          Values[Length(Values)-1]:=tmp;
        end;
      end;

      RowCount:=2+Length(Values);

//      with tmpSeries.NotMandatoryValueList do
//           RowCount:=2+Round(MaxValue-MinValue+1);
    end;

    FLabels:=False;
    FColors:=False;
    FixedRows:=2;
  end;

var t : Integer;
begin
  if Grid3DMode then SetXYZDimensions
  else
  begin
    tmpCol:=1;

    if Assigned(FChart) or Assigned(FSeries) then
    begin
      if Assigned(FSeries) then CalcParams(FSeries,0)
      else
      for t:=0 to FChart.SeriesCount-1 do CalcParams(FChart[t],t);

      if FLabels then Inc(tmpCol);
      if FColors then Inc(tmpCol);

      RowCount:=Math.Max(1+FirstRowNum,MaxNumPoints+FirstRowNum);
    end
    else RowCount:=1+FirstRowNum;

    ColCount:=tmpCol;

    ColWidths[0]:=30;

    if FColors and (ColCount>1) then
       ColWidths[1]:=40; { 5.02 }

    if ShowFields then FixedRows:=2
                  else FixedRows:=1;
  end;

  if (Col=0) and (ColCount>1) then Col:=1; // 5.02
  NotifyChange;
end;

procedure TCustomChartGrid.NotifyChange;
begin
  if Assigned(FActiveChanged) then FActiveChanged(Self);
end;

Procedure TCustomChartGrid.SetBooleanProperty(Var Variable:Boolean; Value:Boolean);
begin
  if Variable<>Value then
  begin
    Variable:=Value;
    RecalcDimensions;
    Repaint;
  end;
end;

Procedure TCustomChartGrid.SetShowFields(Value:Boolean);
begin
  SetBooleanProperty(FShowFields,Value);
  if Row<FirstRowNum then Row:=FirstRowNum;
end;

procedure TCustomChartGrid.SetShowLabels(Value: Boolean);
begin
  SetBooleanProperty(FLabels,Value);
end;

Procedure TCustomChartGrid.SetShowColors(Value:Boolean);
begin
  SetBooleanProperty(FColors,Value);
end;

Procedure TCustomChartGrid.SetShowXValues(Value:TChartGridShow);
begin
  FXValues:=Value;
  RecalcDimensions;
  Repaint;
end;

procedure TCustomChartGrid.TeeEvent(Event: TTeeEvent);
begin
  if not (csDestroying in ComponentState) then
  if Event is TTeeSeriesEvent then
  Case TTeeSeriesEvent(Event).Event of
    seChangeTitle,
    seChangeColor,
    seChangeActive: Repaint
  else RecalcDimensions;
  end;
end;

Function TCustomChartGrid.GetSeriesColor(var AColor:TColor):TChartSeries;
var tmpList : TChartValueList;
begin
  if FColors and (Col=ColorsColumn) and (Row>=FirstRowNum) then
  begin
    result:=GetSeries(Col+1,tmpList);
    if result.Count>(Row-FirstRowNum) then
       AColor:=result.ValueColor[Row-FirstRowNum]
    else
       result:=nil;
  end
  else
     result:=nil;
end;

Procedure TCustomChartGrid.ChangeColor(AColor:TColor);
var tmpColor  : TColor;
    tmpSeries : TChartSeries;
begin
  tmpSeries:=GetSeriesColor(tmpColor);
  if Assigned(tmpSeries) then
     ChangeColor(tmpSeries,AColor);
end;

Procedure TCustomChartGrid.ChangeColor(ASeries:TChartSeries; AColor:TColor);
begin
  ASeries.ValueColor[Row-FirstRowNum]:=AColor;
  SetManualData(ASeries);
  DrawCell(Col,Row,CellRect(Col,Row),[gdSelected,gdFocused]);
  if Assigned(FOnChangeColor) then FOnChangeColor(Self);
end;

Procedure TCustomChartGrid.ChangeColor;
var tmpSeries : TChartSeries;
    tmpColor  : TColor;
begin
  tmpSeries:=GetSeriesColor(tmpColor);
  if Assigned(tmpSeries) then
      if EditColorDialog(Self,tmpColor) then
         ChangeColor(tmpSeries,tmpColor);
end;

// Use double-click mouse event to show the color editor dialog
// to change a series point color
procedure TCustomChartGrid.DblClick;
begin
  if FColors and (Col=ColorsColumn) and (goEditing in Options) then
     ChangeColor
  else
     inherited;
end;

function TCustomChartGrid.CanEditShow: Boolean;
begin
  result:=inherited CanEditShow;

  if result then
  begin
    if Assigned(FOnEditing) then  // 7.0
       FOnEditing(Self,Col,Row,result);

    if result then
       if FColors and (Col=ColorsColumn) then
          result:=False
       else
          FOldValue:=GetEditText(Col,Row);
  end;
end;

procedure TCustomChartGrid.Regenerate;
begin
  if not (csDestroying in ComponentState) then
  begin
    RecalcDimensions;
    MoveColRow(Math.Min(ColCount-1,1), FirstRowNum, True, True);
  end;
end;

procedure TCustomChartGrid.SetSeries(const Value: TChartSeries);
begin
  if FSeries<>Value then
  begin
    if Assigned(FSeries) then
    begin
      {$IFDEF D5}
      FSeries.RemoveFreeNotification(Self);
      {$ENDIF}

      if Assigned(FSeries.ParentChart) then
         RemoveListener(FSeries.ParentChart)
      else
         RemoveListener(ISeriesChart); // 6.02
    end;

    FSeries:=Value;

    if Assigned(FSeries) then
    begin
      FSeries.FreeNotification(Self);
      Chart:=nil;
      ISeriesChart:=FSeries.ParentChart;  // 6.02
      AddListener(ISeriesChart);
    end;
  end;

  Regenerate;
  Repaint;
end;

// Returns column number for series "Labels"
Function TCustomChartGrid.LabelsColumn:Integer;
begin
  if FLabels then
  begin
    if FColors then result:=2
               else result:=1;
  end
  else result:=-1;
end;

// Returns column number for series "Colors"
Function TCustomChartGrid.ColorsColumn:Integer;
begin
  if FColors then result:=1 else result:=-1;
end;

end.