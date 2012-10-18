{********************************************}
{   TCustomTeeNavigator                      }
{   Copyright (c) 2001-2004 by David Berneda }
{   All Rights Reserved                      }
{********************************************}
unit TeeNavigator;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QExtCtrls, QControls, QButtons, Types,
     {$ELSE}
     ExtCtrls, Controls, Buttons,
     {$ENDIF}
     Classes, TeeProcs;

type
  TTeeNavGlyph = (ngEnabled, ngDisabled);
  TTeeNavigateBtn = (nbFirst, nbPrior, nbNext, nbLast,
                     nbInsert, nbDelete, nbEdit, nbPost, nbCancel);

  TTeeButtonSet = set of TTeeNavigateBtn;

  TTeeNavButton = class(TSpeedButton)
  private
    FIndex       : TTeeNavigateBtn;
    FRepeatTimer : TTimer;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
  public
    Destructor Destroy; override;
    property Index : TTeeNavigateBtn read FIndex write FIndex;
  end;

  TNotifyButtonClickedEvent=Procedure(Index:TTeeNavigateBtn) of object;

  TCustomTeeNavigator=class(TCustomPanel,ITeeEventListener)
  private
    FHints        : TStrings;
    FDefHints     : TStrings;
    ButtonWidth   : Integer;
    MinBtnSize    : TPoint;
    FocusedButton : TTeeNavigateBtn;
    FOnButtonClicked : TNotifyButtonClickedEvent;
    FPanel: TCustomTeePanel;
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject);
    procedure CheckSize;
    procedure HintsChanged(Sender: TObject);
    procedure SetSize(var W: Integer; var H: Integer);
    {$IFNDEF CLX}
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    {$ENDIF}
    {$IFNDEF CLX}
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    {$ENDIF}

  {$IFDEF CLR}
  protected
  {$ENDIF}
    procedure TeeEvent(Event: TTeeEvent);

  protected
    {$IFDEF CLX}
    procedure BoundsChanged; override;
    {$ENDIF}
    procedure BtnClick(Index: TTeeNavigateBtn); dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure InitButtons; virtual;
    procedure Loaded; override;
    procedure DoTeeEvent(Event: TTeeEvent); virtual;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
    procedure SetPanel(const Value: TCustomTeePanel); virtual; // 7.0
  public
    Buttons: Array[TTeeNavigateBtn] of TTeeNavButton;
    
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure EnableButtons; virtual;
    procedure InitHints; { 5.02 }
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    Function PageCount:Integer; virtual;
    property Panel:TCustomTeePanel read FPanel write SetPanel;
    procedure Print; virtual;
    property OnButtonClicked:TNotifyButtonClickedEvent read FOnButtonClicked
                                   write FOnButtonClicked;
  published
    { TPanel properties }
    property Align;
    property BorderStyle;
    property Color;
    {$IFNDEF CLX}
    {$IFNDEF TEEOCX}
    property UseDockManager default True;
    property DockSite;
    {$ENDIF}
    {$ENDIF}
    property DragMode;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    {$IFNDEF TEEOCX}
    property PopupMenu;
    {$ENDIF}
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    {$IFNDEF TEEOCX}
    property Constraints;
    {$ENDIF}
    {$IFNDEF CLX}
    property DragKind;
    property Locked;
    {$ENDIF}

    { TPanel events }
    property OnClick;
    property OnDblClick;
    {$IFNDEF CLX}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    {$ENDIF}
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    {$IFNDEF CLX}
    property OnCanResize;
    {$ENDIF}
    {$IFNDEF TEEOCX}
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
    {$ENDIF}
  end;

  TTeePageNavigatorClass=class of TCustomTeeNavigator;

implementation

Uses SysUtils,
     {$IFDEF CLX}
     QForms, Qt,
     {$ELSE}
     Forms,
     {$ENDIF}
     TeCanvas, TeeConst;

Const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}
  SpaceSize       =  5;   { size of space between special buttons }

  BtnTypeName: array[TTeeNavigateBtn] of
     {$IFDEF CLR}String{$ELSE}PChar{$ENDIF} = ('First', 'Prior', 'Next',
    'Last', 'Insert', 'Delete', 'Edit', 'Post', 'Cancel');

{ TCustomTeeNavigator }
Constructor TCustomTeeNavigator.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle:=ControlStyle-[csAcceptsControls,csSetCaption] + [csOpaque];
  {$IFNDEF CLX}
  if not NewStyleControls then ControlStyle:=ControlStyle + [csFramed];
  {$ENDIF}
  FHints:=TStringList.Create;
  TStringList(FHints).OnChange:=HintsChanged;
  InitButtons;
  InitHints;
  BevelOuter:=bvNone;
  BevelInner:=bvNone;
  Width:=241;
  Height:=25;
  FocusedButton:=nbFirst;
  {$IFNDEF CLX}
  FullRepaint:=False;
  {$ENDIF}
end;

Destructor TCustomTeeNavigator.Destroy;
begin
  FDefHints.Free;
  FHints.Free;
  Panel:=nil;
  inherited;
end;

procedure TCustomTeeNavigator.InitHints;
var I : Integer;
    J : TTeeNavigateBtn;
begin
  if not Assigned(FDefHints) then
     FDefHints:=TStringList.Create;

  with FDefHints do
  begin
    Clear;
    Add(TeeMsg_First);
    Add(TeeMsg_Prior);
    Add(TeeMsg_Next);
    Add(TeeMsg_Last);
    Add(TeeMsg_Insert);
    Add(TeeMsg_Delete);
    Add(TeeMsg_Edit);
    Add(TeeMsg_Post);
    Add(TeeMsg_Cancel);
  end;

  for J:=Low(Buttons) to High(Buttons) do
      Buttons[J].Hint:=FDefHints[Ord(J)];

  J := Low(Buttons);

  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then Buttons[J].Hint := FHints.Strings[I];
    if J = High(Buttons) then Exit;
    Inc(J);
  end;
end;

procedure TCustomTeeNavigator.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TCustomTeeNavigator.SetSize(var W: Integer; var H: Integer);
var Count  : Integer;
    MinW   : Integer;
    I      : TTeeNavigateBtn;
    Space  : Integer;
    Temp   : Integer;
    Remain : Integer;
    X      : Integer;
    ButtonH: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      Inc(Count);
    end;
  end;
  if Count = 0 then Inc(Count);

  MinW := Count * MinBtnSize.X;
  if W < MinW then W := MinW;
  if H < MinBtnSize.Y then H := MinBtnSize.Y;
  ButtonH:=H;
  if BorderStyle=bsSingle then Dec(ButtonH,4);

  ButtonWidth := W div Count;
  Temp := Count * ButtonWidth;
  if Align = alNone then W := Temp;

  X := 0;
  Remain := W - Temp;
  Temp := Count div 2;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      Space := 0;
      if Remain <> 0 then
      begin
        Dec(Temp, Remain);
        if Temp < 0 then
        begin
          Inc(Temp, Count);
          Space := 1;
        end;
      end;
      Buttons[I].SetBounds(X, 0, ButtonWidth + Space, ButtonH);
      Inc(X, ButtonWidth + Space);
    end
    else
      Buttons[I].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

procedure TCustomTeeNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var W : Integer;
    H : Integer;
begin
  W:=AWidth;
  H:=AHeight;
  if not HandleAllocated then SetSize(W,H);
  inherited SetBounds(ALeft,ATop,W,H);
end;

procedure TCustomTeeNavigator.CheckSize;
var W : Integer;
    H : Integer;
begin
  { check for minimum size }
  W:=Width;
  H:=Height;
  SetSize(W,H);
  if (W<>Width) or (H<>Height) then inherited SetBounds(Left,Top,W,H);
end;

{$IFNDEF CLX}
procedure TCustomTeeNavigator.WMSize(var Message: TWMSize);
begin
  inherited;
  CheckSize;
  Message.Result := 0;
end;
{$ENDIF}

procedure TCustomTeeNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var OldFocus: TTeeNavigateBtn;
begin
  OldFocus:=FocusedButton;
  FocusedButton:=TTeeNavButton(Sender).Index;
  if TabStop {$IFNDEF CLX}and (GetFocus<>Handle){$ENDIF} and CanFocus then
  begin
    SetFocus;
    {$IFNDEF CLX}if (GetFocus<>Handle) then Exit;{$ENDIF}
  end
  else if TabStop {$IFNDEF CLX}and (GetFocus=Handle){$ENDIF} and (OldFocus<>FocusedButton) then
  begin
    Buttons[OldFocus].Invalidate;
    Buttons[FocusedButton].Invalidate;
  end;
end;

{$IFNDEF CLX}
procedure TCustomTeeNavigator.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

procedure TCustomTeeNavigator.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;
{$ENDIF}

procedure TCustomTeeNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var NewFocus : TTeeNavigateBtn;
    OldFocus : TTeeNavigateBtn;
begin
  OldFocus:=FocusedButton;
  case Key of
    TeeKey_Right :
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus < High(Buttons) then NewFocus := Succ(NewFocus);
        until (NewFocus = High(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    TeeKey_Left :
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus > Low(Buttons) then
            NewFocus := Pred(NewFocus);
        until (NewFocus = Low(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus <> FocusedButton then
        begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;

    TeeKey_Space :
      if Buttons[FocusedButton].Enabled then Buttons[FocusedButton].Click;
  end;
end;

{$IFNDEF CLX}
procedure TCustomTeeNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result:=DLGC_WANTARROWS;
end;
{$ENDIF}

procedure TCustomTeeNavigator.ClickHandler(Sender: TObject);
begin
  BtnClick(TTeeNavButton(Sender).Index);
end;

{$IFNDEF CLX}
procedure TCustomTeeNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then EnableButtons;
end;
{$ENDIF}

procedure TCustomTeeNavigator.BtnClick(Index: TTeeNavigateBtn);
begin
  EnableButtons;
  if Assigned(FOnButtonClicked) then FOnButtonClicked(Index);
end;

procedure TCustomTeeNavigator.Loaded;
begin
  inherited;
  CheckSize;
  InitHints;
  EnableButtons;
end;

procedure TCustomTeeNavigator.EnableButtons;
begin
end;

{$IFDEF CLR}
{$R 'TeeNav_Cancel.bmp'}
{$R 'TeeNav_Edit.bmp'}
{$R 'TeeNav_Delete.bmp'}
{$R 'TeeNav_First.bmp'}
{$R 'TeeNav_Insert.bmp'}
{$R 'TeeNav_Last.bmp'}
{$R 'TeeNav_Next.bmp'}
{$R 'TeeNav_Post.bmp'}
{$R 'TeeNav_Prior.bmp'}
{$ELSE}
{$R TeeNavig.res}
{$ENDIF}

procedure TCustomTeeNavigator.InitButtons;
var I       : TTeeNavigateBtn;
    X       : Integer;
    ResName : string;
begin
  MinBtnSize:=TeePoint(20,18);
  X:=0;

  for I:=Low(Buttons) to High(Buttons) do
  begin
    Buttons[I]:=TTeeNavButton.Create(Self);
    With Buttons[I] do
    begin
      Flat:=True;
      Index:=I;
      Visible:=True;
      Enabled:=False;
      SetBounds(X, 0, MinBtnSize.X, MinBtnSize.Y);
      FmtStr(ResName, 'TeeNav_%s', [BtnTypeName[I]]);

      {$IFDEF CLR}
      TeeLoadBitmap(Glyph,ResName,'');
      {$ELSE}
      Glyph.LoadFromResourceName(HInstance, ResName);
      {$ENDIF}

      NumGlyphs:=2;
      OnClick:=ClickHandler;
      OnMouseDown:=BtnMouseDown;
      Parent:=Self;
      Inc(X,MinBtnSize.X);
    end;
  end;

  Buttons[nbInsert].Visible:=False;
  Buttons[nbDelete].Visible:=False;
  Buttons[nbEdit].Visible:=False;
  Buttons[nbPost].Visible:=False;
  Buttons[nbCancel].Visible:=False;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

procedure TCustomTeeNavigator.SetPanel(const Value: TCustomTeePanel);
begin
  if FPanel<>Value then
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
      {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(FPanel).Listeners.Add(Self);
    end;

    EnableButtons;
  end;
end;

procedure TCustomTeeNavigator.TeeEvent(Event: TTeeEvent);
begin
  DoTeeEvent(Event);
end;

procedure TCustomTeeNavigator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and Assigned(FPanel) and (AComponent=FPanel) then
     Panel:=nil;
end;

{$IFDEF CLX}
procedure TCustomTeeNavigator.BoundsChanged;
var W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetSize(W, H);
end;
{$ENDIF}

procedure TCustomTeeNavigator.DoTeeEvent(Event: TTeeEvent);
begin
end;

Function TCustomTeeNavigator.PageCount:Integer;
begin
  result:=1; // abstract
end;

procedure TCustomTeeNavigator.Print;
begin
end;

{ TTeeNavButton }
Destructor TTeeNavButton.Destroy;
begin
  FRepeatTimer.Free;
  inherited;
end;

procedure TTeeNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if FRepeatTimer = nil then
     FRepeatTimer := TTimer.Create(Self);

  FRepeatTimer.OnTimer := TimerExpired;
  FRepeatTimer.Interval := InitRepeatPause;
  FRepeatTimer.Enabled  := True;
end;

procedure TTeeNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited;
  if Assigned(FRepeatTimer) then FRepeatTimer.Enabled:=False;
end;

procedure TTeeNavButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval:=RepeatPause;
  if (FState=bsDown) and {$IFDEF CLR}(Self as IControl).{$ENDIF}MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled:=False;
      raise;
    end;
  end;
end;

procedure TTeeNavButton.Paint;
var R : TRect;
begin
  inherited;
  if {$IFNDEF CLX}(GetFocus=Parent.Handle) and{$ENDIF}
     (FIndex=TCustomTeeNavigator(Parent).FocusedButton) then
  begin
    R:=TeeRect(3,3,Width-3,Height-3);
    if FState=bsDown then OffsetRect(R,1,1);
    {$IFDEF CLX}
    Canvas.DrawFocusRect(R);
    {$ELSE}
    DrawFocusRect(Canvas.Handle,R);
    {$ENDIF}
  end;
end;

end.
