{**********************************************}
{   TeeChart Office / TeeTree                  }
{   Inspector object.                          }
{   Copyright (c) 2001-2004 by David Berneda   }
{**********************************************}
unit TeeInspector;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF CLX}
     QGrids, QGraphics, QStdCtrls, QMenus, QForms, QControls, Qt,
     {$ELSE}
     Grids, Graphics, Controls, Forms, StdCtrls, Menus,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     Classes, SysUtils, TeCanvas, TeeProcs;

type
  TInspectorItemStyle=( iiBoolean, iiString, iiSelection, iiColor, iiPen,
                        iiGradient, iiBrush, iiFont, iiImage, iiButton,
                        iiInteger, iiDouble );

  TInspectorItem=class;

  TGetItemProc=procedure(Const S:String; AObject:TObject=nil) of object;
  TGetInspectorItems=procedure(Sender:TInspectorItem; Proc:TGetItemProc) of object;

  TTeeInspector=class;

  TInspectorItem=class(TCollectionItem)
  private
    FCaption  : String;
    FData     : TObject;
    FEnabled  : Boolean;
    FStyle    : TInspectorItemStyle;
    FValue    : Variant;
    FVisible  : Boolean;

    IData       : TObject;
    FOnChange   : TNotifyEvent;
    FOnGetItems : TGetInspectorItems;
    Procedure Changed;
    Procedure RebuildInspector;
    procedure SetCaption(const Value: String);
    procedure SetVisible(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetData(const Value: TObject);
  protected
    Function StyleToInt:Integer;
  public
    Constructor Create(Collection:TCollection); override;
    Function Inspector:TTeeInspector;
    property Data:TObject read FData write SetData;
  published
    property Caption:String read FCaption write SetCaption;
    property Enabled:Boolean read FEnabled write FEnabled default True;
    property Style:TInspectorItemStyle read FStyle write FStyle default iiBoolean;
    property Value:Variant read FValue write SetValue;
    property Visible:Boolean read FVisible write SetVisible default True;

    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnGetItems:TGetInspectorItems read FOnGetItems write FOnGetItems;
  end;

  TInspectorItems=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TInspectorItem;
    Procedure Put(Index:Integer; Const Value:TInspectorItem);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    Inspector : TTeeInspector;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  AData:TObject):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  AData:TObject; const AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  const AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant; const AOnChange:TNotifyEvent):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant):TInspectorItem; overload;

    Function Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                  InitialValue:Variant; AData:TObject;
                  const AOnChange:TNotifyEvent):TInspectorItem; overload;

    property Item[Index:Integer]:TInspectorItem read Get write Put; default;
  end;

  TComboFlatGrid=class(TComboFlat)
  {$IFNDEF CLX}
  private
    {$IFNDEF CLR}
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    {$ENDIF}
  {$ELSE}
  protected
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$ENDIF}
  end;

  TEditGrid=class(TEdit)
  {$IFNDEF CLX}
  private
    {$IFNDEF CLR}
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    {$ENDIF}
  {$ELSE}
  protected
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
  {$ENDIF}
  end;

  TInspectorHeader=class(TPersistent)
  private
    FFont    : TFont;
    FVisible : Boolean;
    Procedure CanvasChanged(Sender:TObject);
    procedure SetFont(const Value: TFont);
    procedure SetVisible(const Value: Boolean);
  public
    Inspector : TTeeInspector;
    Constructor Create;
    Destructor Destroy; override;

    Procedure Update;
  published
    property Font:TFont read FFont write SetFont;
    property Visible:Boolean read FVisible write SetVisible default True;
  end;

  TTeeInspector=class(TStringGrid)
  private
    FHeader    : TInspectorHeader;
    FItems     : TInspectorItems;

    IComboGrid : TComboFlatGrid;
    IEditGrid  : TEditGrid;

    procedure AddComboItem(Const S:String; AObject:TObject);
    procedure ComboChange(Sender: TObject);
    Procedure CreateCombo;
    Procedure CreateEdit;
    procedure EditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure HideCombos;
    procedure InternalSetHeader;
    Function MinRow:Integer;
    Procedure SetComboIndex;
    procedure SetHeader(Const Value:TInspectorHeader);
    Procedure SetItems(const Value:TInspectorItems);
    Function ValidRow(ARow:Integer):Boolean;
  protected
    procedure DrawCell(ACol, ARow: Integer; ARect: TRect;
      AState: TGridDrawState); override;
    Procedure DoPositionCombos(WhenVisible:Boolean);
    Function Item(ARow:Integer):TInspectorItem;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Rebuild;
    procedure Resize; override;
    function SelectCell(ACol, ARow: Integer): Boolean; override;
    {$IFDEF CLX}
    Procedure SetParent(const Value: TWidgetControl); override;
    {$ELSE}
    Procedure SetParent(AParent: TWinControl); override;
    {$ENDIF}
    procedure TopLeftChanged; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Clear;
    Procedure SetProperties(const AMenu:TPopupMenu);
  published
    property Items:TInspectorItems read FItems write SetItems;
    property Color default clBtnFace;
    property ColCount default 2;
    property DefaultColWidth default 82;
    property DefaultRowHeight default 19;
    property FixedCols default 0;
    property GridLineWidth default 0;
    property RowCount default 1;
    property Header:TInspectorHeader read FHeader write SetHeader;
    {$IFDEF CLX}
    property ScrollBars default ssAutoBoth;
    {$ENDIF}
  end;

implementation

Uses TeeConst, TeePenDlg, Math, TeeEdiGrad, TeeBrushDlg, TeeEdiFont;

{ TInspectorItems }
procedure TInspectorItem.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

constructor TInspectorItem.Create(Collection: TCollection);
begin
  inherited;
  FVisible:=True;
  FEnabled:=True;
  if csDesigning in Inspector.ComponentState then
     RebuildInspector;
end;

Procedure TInspectorItem.RebuildInspector;
begin
  if not (csLoading in Inspector.ComponentState) then
     Inspector.Rebuild;
end;

Function TInspectorItem.Inspector:TTeeInspector;
begin
  result:=TInspectorItems(Collection).Inspector;
end;

procedure TInspectorItem.SetCaption(const Value: String);
begin
  if FCaption<>Value then
  begin
    FCaption:=Value;
    RebuildInspector;
  end;
end;

procedure TInspectorItem.SetData(const Value: TObject);
begin
  if FData<>Value then
  begin
    FData:=Value;
    if Style=iiSelection then
    with Inspector do
         if Item(Row)=Self then
         begin
           SetComboIndex;
           with IComboGrid do
           if ItemIndex=-1 then Self.Value:=''
                           else Self.Value:=IComboGrid.Items[IComboGrid.ItemIndex];
         end;
  end;
end;

procedure TInspectorItem.SetValue(const Value: Variant);
begin
  FValue:=Value;
  Inspector.Invalidate;
end;

procedure TInspectorItem.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    RebuildInspector;
  end;
end;

Function TInspectorItem.StyleToInt:Integer;
begin
  case FStyle of
    iiButton    : result:=0;
    iiBoolean   : result:=1;
    iiPen       : result:=3;
    iiGradient  : result:=4;
    iiColor     : result:=2;
    iiInteger,
    iiDouble,
    iiString    : result:=10;
    iiSelection : result:=0;
    iiFont      : result:=7;
    iiImage     : result:=8;
    iiBrush     : result:=9;
  else
    result:=-1;
  end;
end;

{ TInspectorItems }
Function TInspectorItems.Get(Index:Integer):TInspectorItem;
begin
  result:=TInspectorItem(inherited Items[Index]);
end;

Procedure TInspectorItems.Put(Index:Integer; Const Value:TInspectorItem);
begin
  inherited Items[Index]:=Value;
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              AData:TObject):TInspectorItem;
var c : TNotifyEvent;
begin
  c:=nil;
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},AData,c);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              AData:TObject; const AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},AData,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              const AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,{$IFDEF CLR}varNull{$ELSE}vaNull{$ENDIF},nil,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                              InitialValue:Variant; const AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=Add(AStyle,ACaption,InitialValue,nil,AOnChange);
end;

Function TInspectorItems.Add( AStyle:TInspectorItemStyle; Const ACaption:String;
                               InitialValue:Variant):TInspectorItem;
var c : TNotifyEvent;
begin
  c:=nil;
  result:=Add(AStyle,ACaption,InitialValue,nil,c);
end;

Function TInspectorItems.Add(AStyle:TInspectorItemStyle; Const ACaption:String;
                              InitialValue:Variant; AData:TObject;
                              const AOnChange:TNotifyEvent):TInspectorItem;
begin
  result:=TInspectorItem(inherited Add);

  with result do
  begin
    FStyle:=AStyle;
    FCaption:=ACaption;
    FValue:=InitialValue;
    FData:=AData;
    FOnChange:=AOnChange;
  end;

  with Inspector do
  begin
    RowCount:=RowCount+1;
    Cells[0,RowCount-1]:=ACaption;
    Objects[0,RowCount-1]:=result;
  end;
end;

procedure TInspectorItems.Update(Item: TCollectionItem);
begin
  if not (csLoading in Inspector.ComponentState) then
     Inspector.Rebuild;
end;

{ TTeeInspector }
Constructor TTeeInspector.Create(AOwner:TComponent);
begin
  inherited;

  FHeader:=TInspectorHeader.Create;
  FHeader.Inspector:=Self;
  FHeader.Font.Color:=clNavy;

  FItems:=TInspectorItems.Create(Self,TInspectorItem);
  FItems.Inspector:=Self;

  Color:=clBtnFace;
  ColCount:=2;
  DefaultColWidth:=82;
  DefaultRowHeight:=19;

  FixedCols:=0;
  RowCount:=1;
  GridLineWidth:=0;
  Options:=[goFixedVertLine, goVertLine, goHorzLine, goColSizing, goThumbTracking];

  {$IFDEF CLX}
  ScrollBars:=ssAutoBoth;
  {$ENDIF}

  Header.Update;

  CreateCombo;
  CreateEdit;
end;

Destructor TTeeInspector.Destroy;
begin
  FItems.Free;
  FHeader.Free;
  inherited;
end;

Procedure TTeeInspector.SetItems(const Value:TInspectorItems);
begin
  FItems.Assign(Value);
end;

procedure TTeeInspector.SetHeader(Const Value:TInspectorHeader);
begin
  FHeader.Assign(Value);
end;

Procedure TTeeInspector.InternalSetHeader;
begin { set header cells text }
  if Header.Visible then
  begin
    Cells[0,0]:=TeeMsg_Property;
    Cells[1,0]:=TeeMsg_Value;
  end
  else Rows[0].Clear;
end;

Procedure TTeeInspector.CreateEdit;
begin { create edit box }
  IEditGrid:=TEditGrid.Create(Self);

  with IEditGrid do
  begin
    Name:='IEditGrid';
    Visible:=False;
    OnChange:=Self.EditChange;
    OnKeyDown:=Self.EditKeyDown;
  end;
end;

Procedure TTeeInspector.SetComboIndex;
begin
  with IComboGrid do
  begin
    if Items.Count=0 then
       with Item(Row) do
       if Assigned(FOnGetItems) then FOnGetItems(Item(Row),AddComboItem);

    ItemIndex:=Items.IndexOfObject(Item(Row).Data);
  end;
end;

Procedure TTeeInspector.CreateCombo;
begin { create combobox }
  IComboGrid:=TComboFlatGrid.Create(Self);
  with IComboGrid do
  begin
    Name:='IComboGrid';
    Style:=csDropDownList;
    DropDownCount:=8;
    ItemHeight:=21;
    Visible:=False;
    OnChange:=Self.ComboChange;
  end;
end;

Procedure TTeeInspector.Resize;
begin
  inherited;
  if ColCount>0 then
     {$IFDEF CLX}
     if (not Assigned(Owner)) or (not (csReading in Owner.ComponentState)) then
     {$ENDIF}
        ColWidths[1]:=ClientWidth-ColWidths[0];
  { resize combobox width (if visible) }
  DoPositionCombos(True);

  if (Row=0) and (RowCount>MinRow) then MoveColRow(1,MinRow,True,True);
end;

{$IFDEF CLX}
Procedure TTeeInspector.SetParent(const Value: TWinControl);
{$ELSE}
Procedure TTeeInspector.SetParent(AParent: TWinControl);
{$ENDIF}
begin
  inherited;
  if (not (csDestroying in ComponentState)) and
     (not (csDesigning in ComponentState)) then
  begin
    IComboGrid.Parent:=Parent;
    IEditGrid.Parent:=Parent;
  end;
end;

procedure TTeeInspector.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
 TeeKey_Escape:  begin
                   HideCombos;
                   SetFocus;
                 end;
    TeeKey_Up:   begin
                   HideCombos;
                   SetFocus;
                   if Row>=MinRow then Row:=Row-1;
                 end;
    TeeKey_Down: begin
                   HideCombos;
                   SetFocus;
                   if Row<RowCount then Row:=Row+1;
                 end;
  end;
end;

Function TTeeInspector.Item(ARow:Integer):TInspectorItem;
begin
  result:=TInspectorItem(Objects[0,ARow]);
end;

procedure TTeeInspector.EditChange(Sender: TObject);
begin { the inspector edit box has changed }
  with Item(Row) do
  begin
    if Style=iiString then Value:=IEditGrid.Text
                      else Value:=StrToIntDef(IEditGrid.Text,0);
    Changed;
  end;
end;

procedure TTeeInspector.ComboChange(Sender: TObject);
var tmpItem : TMenuItem;
begin { the inspector combobox has changed, select subitem }
  if IComboGrid.Tag {$IFDEF CLR}<>nil{$ELSE}<>0{$ENDIF} then
  begin
    tmpItem:=TMenuItem(IComboGrid.Tag).Items[IComboGrid.ItemIndex];
    tmpItem.Checked:=True;
    if Assigned(tmpItem.OnClick) then tmpItem.OnClick(tmpItem);
  end
  else
  with Item(Row) do
  begin
    Value:=IComboGrid.Items[IComboGrid.ItemIndex];
    Data:=IComboGrid.Items.Objects[IComboGrid.ItemIndex];
    Changed;
  end;
end;

Procedure TTeeInspector.Clear;
begin
  Items.Clear;
end;

// A Menu can be used to fill the Inspector.

Procedure TTeeInspector.SetProperties(const AMenu:TPopupMenu);
var t     : Integer;
    tmpSt : String;
    tmp   : Integer;
    tmp2  : Integer;
    tmpInspectorItem : TInspectorItem;
begin { set properties at inspector, if any }

  HideCombos;

  Items.Clear;

  tmp:=0;

  if Assigned(AMenu) then
  with AMenu do
  begin
    { call OnPopup to prepare items }
    if Assigned(OnPopup) then OnPopup(AMenu);

    RowCount:=Items.Count;

    { fill properties... }
    for t:=0 to Items.Count-1 do
    begin
      if {$IFDEF D5}(not Items[t].IsLine){$ELSE}(Items[t].Caption<>'-'){$ENDIF}
         and (Items[t].Enabled)
         and (Items[t].HelpContext<>5) then { 5 means "dont put at inspector" }
      begin
        tmpSt:=StripHotkey(Items[t].Caption);
        { remove trailing ellipsi "..." }
        While tmpSt[Length(tmpSt)]='.' do Delete(tmpSt,Length(tmpSt),1);

        Inc(tmp);

        tmpInspectorItem:=TInspectorItem(Self.Items.Add);

        with tmpInspectorItem do
        begin
          Caption:=tmpSt;
          Data:=TObject(AMenu.Items[t].Tag);
          IData:=AMenu.Items[t];

          if Items[t].Count>0 then Style:=iiSelection;
        end;

        if Header.Visible then tmp2:=tmp
                          else tmp2:=tmp-1;

        Cells[0,tmp2]:=tmpSt;
        Objects[1,tmp2]:=tmpInspectorItem;
      end;
    end;
  end;

  if Header.Visible then RowCount:=tmp+1
                    else RowCount:=tmp;

  { enable / disable inspector }
  Enabled:=Assigned(AMenu);

  { resize grid column }
  ColWidths[1]:=ClientWidth-ColWidths[0];
end;

const TeeInspectorButtonSize=16;

procedure TTeeInspector.DrawCell(ACol, ARow: Integer; ARect: TRect;
                                       AState: TGridDrawState);

  Function BooleanCell(ARow:Integer):Boolean;
  var tmp : TObject;
  begin { returns True if the inspector cell (menu item) is True }
    result:=False;
    tmp:=Item(ARow).IData;

    if Assigned(tmp) then
    begin
      if tmp is TMenuItem then
         result:=(tmp as TMenuItem).Checked;
    end
    else result:=Item(ARow).Value;
  end;

  Function CellType(ARow:Integer):Integer;
  var tmp : TInspectorItem;
  begin { returns the type of the cell if it points to a menu item }
    result:=-1;
    tmp:=Item(ARow);
    if Assigned(tmp) then
      if Assigned(tmp.IData) then
      begin
        if tmp.IData is TMenuItem then
           result:=(tmp.IData as TMenuItem).HelpContext
      end
      else result:=tmp.StyleToInt;
  end;

  Procedure DrawEllipsis;
  begin { draw small "ellipsis" buttons }
    with Canvas do
    begin
      {$IFDEF CLX}
      Pen.Color:=clBlack;
      Pen.Style:=psSolid;
      DrawPoint(ARect.Left+4,ARect.Bottom-6);
      DrawPoint(ARect.Left+6,ARect.Bottom-6);
      DrawPoint(ARect.Left+8,ARect.Bottom-6);
      {$ELSE}
      Pen.Handle:=TeeCreatePenSmallDots(clBlack);
      MoveTo(ARect.Left+4,ARect.Bottom-6);
      LineTo(ARect.Left+10,ARect.Bottom-6);
      {$ENDIF}
    end;
  end;

  Function CurrentItem:TMenuItem;
  begin { returns the Menu Item associated to current grid cell }
    result:=TMenuItem(Item(ARow).IData);
  end;

  Function CurrentItemCount:Integer;
  var tmp : TMenuItem;
  begin
    tmp:=CurrentItem;
    if Assigned(tmp) then result:=tmp.Count
                     else result:=0;
  end;

  Function RectangleItem:TRect;
  begin
    result:=TeeRect(ARect.Right+2,ARect.Top+2,ARect.Right+40,ARect.Bottom-2);
  end;

  Procedure DrawText(Const S:String; LeftPos:Integer=-1);
  begin
    if LeftPos=-1 then LeftPos:=ARect.Right+2;
    Canvas.TextOut(LeftPos,ARect.Top,S);
  end;

var tmp       : Integer;
    tmpSt     : String;
    tmpMiddle : Integer;
    tmpCanvas : TTeeCanvas3D;
    tmpGrad   : TCustomTeeGradient;
    tmpFont   : TTeeFont;
    tmpImage  : TPicture;
    tmpItem   : TMenuItem;
    tmpPen    : TChartPen;
    tmpColor  : TColor;
    tmpData   : TObject;
    {$IFDEF CLX}
    QC        : QColorH;
    {$ENDIF}
    tmpBrush  : TChartBrush;
begin { draw checkboxes and buttons at Property Inspector }

  { draw thin dotted grid lines }
  with Canvas do
  begin
    {$IFDEF CLX}
    Start;
    {$ENDIF}

    if goHorzLine in Options then
    begin
      {$IFNDEF CLX}
      Pen.Handle:=TeeCreatePenSmallDots(clDkGray);
      {$ENDIF}

      MoveTo(ARect.Left,ARect.Bottom-1);
      LineTo(ARect.Right-1,ARect.Bottom-1);
    end;
  end;

  if (ARow=0) and Header.Visible then
  begin
    { draw top row text }
    with Canvas do
    begin
      tmpColor:=Font.Color;

      Font.Assign(Header.Font);

      if gdSelected in AState then
         Font.Color:=tmpColor;

      TextOut(ARect.Left+2,ARect.Top+{$IFDEF CLX}2{$ELSE}1{$ENDIF},Cells[ACol,0]);
    end;
  end
  else

  if (ACol=1) and ValidRow(ARow) then { draw value cells }
  with Canvas do
  begin
    { resize rectangle to button / checkbox size }
    Inc(ARect.Left,2);
    Inc(ARect.Top,2);
    Dec(ARect.Bottom,1);
    ARect.Right:=ARect.Left+TeeInspectorButtonSize;

    if CellType(ARow)=2 then { color property }
    begin
      tmpItem:=CurrentItem;
      if Assigned(tmpItem) {$IFDEF CLR}and Assigned(tmpItem.Tag){$ENDIF} then
         Brush.Color:={$IFDEF CLR}Integer{$ELSE}TColor{$ENDIF}(tmpItem.Tag)
      else
         Brush.Color:={$IFDEF CLR}Integer{$ELSE}TColor{$ENDIF}(Item(ARow).Value);

      FillRect(TeeRect(ARect.Left,ARect.Top,ARect.Right-1,ARect.Bottom-1));

      tmpSt:=ColorToString(Brush.Color);
      if Copy(tmpSt,1,2)='cl' then
      begin
        Brush.Style:=bsClear;
        DrawText(Copy(tmpSt,3,255));
      end;
    end
    else
    if CellType(ARow)=10 then // String
      DrawText(Item(ARow).Value,ARect.Left)
    else
    begin
      { draw button or check-box }
      if CellType(ARow)=1 then { boolean ? }
      begin
        if Item(ARow).Enabled then tmpColor:=Color
                              else tmpColor:=clSilver;
        TeeDrawCheckBox(ARect.Left,ARect.Top,Canvas,BooleanCell(ARow),tmpColor);
      end
      else

      if (CellType(ARow)<>-1) and (CurrentItemCount=0) and
         (Item(ARow).Style<>iiSelection) and
         (Item(ARow).Style<>iiString) and
         (Item(ARow).Style<>iiInteger) and
         (Item(ARow).Style<>iiDouble) then
      begin { button }
        {$IFDEF CLX}
        Pen.Style:=psSolid;
        FillRect(ARect);
        {$ELSE}
        Dec(ARect.Bottom);
        Dec(ARect.Right,2);
        tmp:=DFCS_BUTTONPUSH or DFCS_FLAT;
        DrawFrameControl(Handle,ARect,DFC_BUTTON,tmp);
        {$ENDIF}
      end;

      tmpMiddle:=(ARect.Top+ARect.Bottom) div 2;

      case CellType(ARow) of
        0: if (CurrentItemCount=0) and
              (Item(ARow).Style<>iiSelection) then
                 DrawEllipsis { button }
           else
           begin { combobox (submenu items) }

             tmpSt:='';

             if CurrentItem<>nil then
             begin
               for tmp:=0 to CurrentItem.Count-1 do
               begin
                 tmpItem:=CurrentItem.Items[tmp];
                 if tmpItem.RadioItem and tmpItem.Checked then
                 begin
                   tmpSt:=StripHotKey(tmpItem.Caption);
                   break;
                 end;
               end;
             end
             else tmpSt:=Item(ARow).Value;

             if tmpSt<>'' then
                DrawText(tmpSt,ARect.Left);
           end;

        1: { boolean }
           begin
             { draw Yes/No }
             if BooleanCell(ARow) then tmpSt:=TeeMsg_Yes
                                  else tmpSt:=TeeMsg_No;
             DrawText(StripHotKey(tmpSt));
           end;
        3: begin { pen }
             DrawEllipsis;
             tmpPen:=TChartPen(Item(ARow).Data);

             if Assigned(tmpPen) then
             begin
               TeeSetTeePen(Pen,tmpPen,tmpPen.Color,Handle);

               MoveTo(ARect.Right+tmpPen.Width+1,tmpMiddle);
               LineTo(ARect.Right+30,tmpMiddle);
             end;
           end;
       4: begin { gradient }
            DrawEllipsis;
            tmpGrad:=TCustomTeeGradient(Item(ARow).Data);

            if Assigned(tmpGrad) then
            if tmpGrad.Visible then
            begin
              tmpCanvas:=TTeeCanvas3D.Create;
              try
                tmpCanvas.ReferenceCanvas:=Canvas;
                tmpGrad.Draw(tmpCanvas,RectangleItem);
              finally
                tmpCanvas.Free;
                {$IFDEF CLX}
                with Canvas.Brush do
                begin
                  QC:=QColor(clBtnFace);
                  try
                    QBrush_setColor(Handle, QC);
                  finally
                    QColor_destroy(QC);
                  end;
                end;
                {$ENDIF}
              end;
            end
            else DrawText(TeeMsg_None);
          end;
       6: begin { integer }
            // IntToStr(CurrentItem.HelpContext)

            DrawText(Item(ARow).Value);
          end;
       7: begin { font }
            DrawEllipsis;
            tmpFont:=TTeeFont(Item(ARow).Data);
            if Assigned(tmpFont) then
            with tmpFont do
            begin
              Font.Color:=Color;
              Font.Name:=Name;
              Font.Style:=Style;
            end;

            DrawText(Font.Name);
          end;
       8: begin { image }
            DrawEllipsis;
            tmpImage:=TPicture(Item(ARow).Data);
            if Assigned(tmpImage) and Assigned(tmpImage.Graphic) then
               tmpSt:=TeeMsg_Image
            else
               tmpSt:=TeeMsg_None;

            DrawText(tmpSt);
          end;
       9: begin { pattern brush }
            DrawEllipsis;

            tmpData:=Item(ARow).Data;

            if Assigned(tmpData) then
            begin
              tmpBrush:=TChartBrush(tmpData);

              if Assigned(tmpBrush.Image.Graphic) then
                 Brush.Bitmap:=tmpBrush.Image.Bitmap
              else
                 Brush.Assign(tmpBrush);
            end;

            {$IFNDEF CLX}
            if (CurrentItem<>nil) then
               SetBkColor(Handle,ColorToRGB(StrToInt(CurrentItem.Hint)));  // 6.01
            {$ENDIF}

            FillRect(RectangleItem);
            Brush.Style:=bsSolid;

            {$IFNDEF CLX}
            if (CurrentItem<>nil) then
               SetBkColor(Handle,ColorToRGB(Self.Color));  // 6.01
            {$ENDIF}
          end;
      end;
    end;
  end
  else inherited;

  {$IFDEF CLX}
  Canvas.Stop;
  {$ENDIF}
end;

procedure TTeeInspector.AddComboItem(Const S:String; AObject:TObject);
begin
  IComboGrid.Items.AddObject(S,AObject);
end;

Procedure TTeeInspector.HideCombos;
begin
  { remove previous combobox, if any }
  if Assigned(IComboGrid) then IComboGrid.Hide;
  { remove previous edit box, if any }
  if Assigned(IEditGrid) then IEditGrid.Hide;
end;

// Reload grid cells with Visible Items
procedure TTeeInspector.Rebuild;
var t   : Integer;
    tmp : Integer;
begin
  tmp:=0;
  for t:=0 to Items.Count-1 do if Items[t].Visible then Inc(tmp);
  RowCount:=Math.Max(1,tmp);

  if Header.Visible then
  begin
    tmp:=1;
    if Items.Count>0 then
       RowCount:=RowCount+1;
  end
  else tmp:=0;

  for t:=0 to Items.Count-1 do
  if Items[t].Visible then
  begin
    Cells[0,tmp]:=Items[t].Caption;
    Objects[0,tmp]:=Items[t];
    Inc(tmp);
  end;

end;

procedure TTeeInspector.Loaded;
begin
  inherited;
  Rebuild;

  if RowCount>MinRow then MoveColRow(1,MinRow,True,True);
end;

Function TTeeInspector.MinRow:Integer;
begin
  if Assigned(FHeader) and Header.Visible then result:=1
                                          else result:=0;
end;

procedure TTeeInspector.MouseDown(Button: TMouseButton; Shift: TShiftState;
                                          X, Y: Integer);
var tmp     : TObject;
    tmpR    : TRect;
    t       : Integer;
    tmpItem : TInspectorItem;
begin { execute the inspector property (menu item associated) }

  inherited;

  if (Col=1) and ValidRow(Row) then { clicked at column 1? }
  begin
    HideCombos;

    { calculate rectangle for button or checkbox }
    tmpR:=CellRect(Col,Row);

    { cell contains selection of items? }

    tmpItem:=Item(Row);

    if Assigned(tmpItem) then
    begin

      if (tmpItem.Style=iiString) or (tmpItem.Style=iiInteger) or
         (tmpItem.Style=iiDouble) then
      begin
        with IEditGrid do
        begin
          { set Edit box position and size }
          DoPositionCombos(False);
          Text:=Self.Item(Row).Value;
          Show;
          SetFocus;
        end;
      end
      else

      if tmpItem.Style=iiSelection then
      begin
        { create combobox }
        with IComboGrid do
        begin
          tmp:=tmpItem.IData;

          Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(tmp); { menu item }

          { set ComboBox position and size }
          DoPositionCombos(False);

          { fill combobox and select item }
          Items.Clear;

          if Assigned(tmp) and (tmp is TMenuItem) then
          begin
            with TMenuItem(tmp) do
            for t:=0 to Count-1 do
            if Items[t].RadioItem then
            begin
              IComboGrid.Items.Add(StripHotKey(Items[t].Caption));
              if Items[t].Checked then
                 ItemIndex:=t;
            end;
          end
          else
          begin
            with Self.Item(Row) do
            if Assigned(FOnGetItems) then
            begin
              FOnGetItems(tmpItem,AddComboItem);
              SetComboIndex;
            end
            else ItemIndex:=-1;
          end;

          Show;
        end;
      end;

      tmpR.Right:=tmpR.Left+TeeInspectorButtonSize;

      { clicked on rectangle? }
      if PointInRect(tmpR,X,Y) then
      begin
        if tmpItem.Enabled then
        begin
          Case tmpItem.Style of
          iiBoolean: begin
                       if tmpItem.Value{$IFDEF CLR}=True{$ENDIF} then
                          tmpItem.Value:=False
                       else
                          tmpItem.Value:=True;
                     end;
            iiColor: tmpItem.Value:=EditColor(Self,{$IFDEF CLR}TColor{$ENDIF}(tmpItem.Value));
             iiFont: if tmpItem.Data is TTeeFont then
                        EditTeeFontEx(Self,TTeeFont(tmpItem.Data))
                     else
                        EditTeeFont(Self,TTeeFont(tmpItem.Data));
              iiPen: EditChartPen(Self,TChartPen(tmpItem.Data));
            iiBrush: EditChartBrush(Self,TChartBrush(tmpItem.Data));
         iiGradient: EditTeeGradient(Self,TCustomTeeGradient(tmpItem.Data));
          end;

          { repaing grid cell }
          if tmpItem.StyleToInt=0 then InvalidateCell(Col,Row);
  
          tmpItem.Changed;

          if Assigned(tmpItem.IData) and (tmpItem.IData is TMenuItem) then
             TMenuItem(tmpItem.IData).Click;

          { repaint clicked grid cell }
          InvalidateCell(Col,Row);
        end;
      end;
    end; 
  end;
end;

procedure TTeeInspector.KeyDown(var Key: Word; Shift: TShiftState);
begin { emulate mouse clicking when pressing the SPACE key }
  if Key=TeeKey_Space then
     With CellRect(1,Row) do MouseDown(mbLeft,[],Left+4,Top+4)
  else
    inherited;
end;

Procedure TTeeInspector.DoPositionCombos(WhenVisible:Boolean);
var R : TRect;
begin { set inspector combobox position and size }
  R:=CellRect(Col,Row);

  if Assigned(IComboGrid) and ((not WhenVisible) or IComboGrid.Visible) then
  with IComboGrid do
  begin
    Left:=Self.Left+R.Left+1;
    Width:=R.Right-R.Left+1;
    Top:=Self.Top+R.Top-1;
  end;

  if Assigned(IEditGrid) and ((not WhenVisible) or IEditGrid.Visible) then
  with IEditGrid do
  begin
    Left:=Self.Left+R.Left+1;
    Width:=R.Right-R.Left+1;
    Height:=R.Bottom-R.Top+1;
    Top:=Self.Top+R.Top;
  end;
end;

procedure TTeeInspector.TopLeftChanged;
begin { reposition the inspector ComboBox (if visible) when scrolling }
  DoPositionCombos(True);
end;

Function TTeeInspector.ValidRow(ARow:Integer):Boolean;
begin
  if Assigned(FHeader) and Header.Visible then
     result:=ARow>0
  else
     result:=Assigned(Items) and (Items.Count>0);
end;

Function TTeeInspector.SelectCell(ACol, ARow: Integer): Boolean;
begin { Avoid selecting the first grid column (when clicking) }
  result:= (ACol>0) and
           ValidRow(ARow) and
           inherited SelectCell(ACol,ARow);
end;

procedure TTeeInspector.MouseMove(Shift: TShiftState; X, Y: Integer);
var tmpR      : TRect;
    tmp       : TGridCoord;
    tmpCursor : TCursor;
    tmpItem   : TInspectorItem;
begin
  tmpCursor:=crDefault;

  tmp:=MouseCoord(x,y); { mouse to grid Row,Col }

  if (tmp.X=1) and ValidRow(tmp.Y) then { at column 1? }
  begin
    tmpItem:=Item(tmp.Y);

    if Assigned(tmpItem) and (tmpItem.Style<>iiSelection) then
    begin
      tmpR:=CellRect(tmp.X,tmp.Y); { Row,Col to screen pixel Rect }
      tmpR.Right:=tmpR.Left+TeeInspectorButtonSize;

      { clicked on rectangle? }
      if PointInRect(tmpR,X,Y) and tmpItem.Enabled then
         tmpCursor:=crHandPoint;
    end;
  end;

  Cursor:=tmpCursor;
end;

{ TComboFlatGrid }

{$IFNDEF CLX}
{$IFNDEF CLR}
procedure TComboFlatGrid.CMFocusChanged(var Message: TCMFocusChanged);
begin
  if Visible then
     if GetFocus<>Handle then Hide;
end;
{$ENDIF}
{$ELSE}
function TComboFlatGrid.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  if QEvent_type(Event)=QEventType_FocusOut then
     if Visible then Hide;
end;
{$ENDIF}

{ TEditGrid }

{$IFNDEF CLX}
{$IFNDEF CLR}
procedure TEditGrid.CMFocusChanged(var Message: TCMFocusChanged);
begin
  if Visible then
     if GetFocus<>Handle then Hide;
end;
{$ENDIF}
{$ELSE}
function TEditGrid.EventFilter(Sender: QObjectH;
  Event: QEventH): Boolean;
begin
  Result := inherited EventFilter(Sender, Event);
  if QEvent_type(Event)=QEventType_FocusOut then
     if Visible then Hide;
end;
{$ENDIF}

{ TInspectorHeader }

constructor TInspectorHeader.Create;
begin
  inherited;
  FFont:=TTeeFont.Create(CanvasChanged);
  FVisible:=True;
end;

procedure TInspectorHeader.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

Procedure TInspectorHeader.CanvasChanged(Sender:TObject);
begin
  Inspector.Invalidate;
end;

procedure TInspectorHeader.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    Inspector.InternalSetHeader;
    Inspector.Rebuild;
  end;
end;

procedure TInspectorHeader.Update;
begin
  Inspector.InternalSetHeader;
  CanvasChanged(nil);
end;

destructor TInspectorHeader.Destroy;
begin
  FFont.Free;
  inherited;
end;

end.
