{******************************************}
{ TeeChart Tools Editor                    }
{ Copyright (c) 2000-2004 by David Berneda }
{******************************************}
unit TeeEditTools;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QButtons,
     Types,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
     {$ENDIF}
     TeCanvas, TeEngine, Chart, TeePenDlg, TeeProcs;

type
  TFormTeeTools = class(TForm)
    LBTools: TListBox;
    PanelToolEditor: TPanel;
    PTop: TPanel;
    BAdd: TButtonColor;
    BDelete: TButtonColor;
    CBActive: TCheckBox;
    PBottom: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    BMoveUp: TSpeedButton;
    BMoveDown: TSpeedButton;
    procedure LBToolsClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure CBActiveClick(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BMoveUpClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    {$IFNDEF CLX}
    procedure LBToolsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ELSE}
    procedure LBToolsDrawItem(Sender: TObject; Index: Integer; Rect: TRect;
      State: TOwnerDrawState; var Handled: Boolean);
    {$ENDIF}
  private
    { Private declarations }
    {$IFDEF CLX}
    ICreating : Boolean;
    {$ENDIF}
    Function CurrentTool:TTeeCustomTool;
    procedure DeleteForm;
    procedure EnableButtons;
    procedure FillAndSet;
    procedure FillTools;
    procedure SwapTool(A,B:Integer);
    {$IFNDEF CLX}
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    {$ENDIF}
  protected
    OnAdded, OnDeleted : TNotifyEvent; // 6.02
  public
    { Public declarations }
    Chart : TCustomChart;
    Procedure Reload;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst, TeeToolsGallery;

type TElementAccess=class(TCustomChartElement);

procedure TFormTeeTools.FillTools;
var t : Integer;
begin
  PBottom.Caption:='';

  With LBTools do
  begin
    Clear;
    for t:=0 to Chart.Tools.Count-1 do
        if not TElementAccess(Chart.Tools[t]).InternalUse then
           Items.AddObject(Chart.Tools[t].Description,Chart.Tools[t]);
  end;

  CBActive.Enabled:=LBTools.Items.Count>0;
  BDelete.Enabled:=CBActive.Enabled;
end;

type TToolAccess=class(TTeeCustomTool);

procedure TFormTeeTools.DeleteForm;
begin
  if PanelToolEditor.ControlCount>0 then
     PanelToolEditor.Controls[0].Free;
end;

procedure TFormTeeTools.LBToolsClick(Sender: TObject);
var tmpClass : TClass;
    tmp      : TForm;
begin
  {$IFDEF CLX}
  if not ICreating then
  if (PanelToolEditor.ControlCount=0) or
     (PanelToolEditor.Controls[0].Tag<>Integer(CurrentTool)) then
  {$ENDIF}
  if CurrentTool<>nil then
  begin

    if PanelToolEditor.ControlCount>0 then
    begin
      if not TForm(PanelToolEditor.Controls[0]).CloseQuery then
         LBTools.ItemIndex:=Chart.Tools.IndexOf(TTeeCustomTool(PanelToolEditor.Controls[0].Tag));
    end;

    CBActive.Checked:=CurrentTool.Active;
    DeleteForm;

    tmpClass:=GetClass(TToolAccess(CurrentTool).GetEditorClass);
    if Assigned(tmpClass) then
    begin
      tmp:=TFormClass(tmpClass).Create(Self);
      TeeTranslateControl(tmp);
      tmp.Align:=alClient;
      AddFormTo(tmp,PanelToolEditor,CurrentTool);
    end;

    EnableButtons;

    if PBottom.Visible and (CurrentTool<>nil) then
       PBottom.Caption:=CurrentTool.Name;
  end;
end;

procedure TFormTeeTools.BDeleteClick(Sender: TObject);
var tmp : Integer;
begin
  if (CurrentTool<>nil) and  { 5.01 }
     TeeYesNoDelete(CurrentTool.Description,Self) then
  begin
    tmp:=LBTools.ItemIndex;

    if Assigned(OnDeleted) then
       OnDeleted(CurrentTool);

    CurrentTool.Free;
    DeleteForm;
    FillTools;

    With LBTools do     { 5.01 }
    if tmp>1 then
       ItemIndex:=tmp-1
    else
    if Items.Count>0 then ItemIndex:=Items.Count-1;

    BDelete.Enabled:=LBTools.ItemIndex<>-1;
    if BDelete.Enabled then LBToolsClick(Self);
  end;
end;

procedure TFormTeeTools.CBActiveClick(Sender: TObject);
begin
  CurrentTool.Active:=CBActive.Checked;
end;

procedure TFormTeeTools.BAddClick(Sender: TObject);
var AOwner : TComponent;
    t      : Integer;
    tmpTool : TTeeCustomTool;
begin
  With TTeeToolsGallery.Create(Owner) do
  try
    {$IFDEF D5}
    if Assigned(Owner) then Position:=poOwnerFormCenter
    else
    {$ENDIF}
      Position:=poScreenCenter;

    if ShowModal=mrOk then
    begin
      {$IFDEF CLX}
      ICreating:=True;
      {$ENDIF}

      AOwner:=Chart.Owner;

      for t:=0 to Chart.Tools.Count-1 do { 5.01 }
      if Chart.Tools[t].Owner=Chart then
      begin
        AOwner:=Chart;
        break;
      end;

      tmpTool:=SelectedTool.Create(AOwner);
      with tmpTool do
      begin
        ParentChart:=Chart;
        Name:=TeeGetUniqueName(AOwner,TeeMsg_DefaultToolName);
      end;

      if Assigned(OnAdded) then
         OnAdded(tmpTool);

      FillTools;

      {$IFDEF CLX}
      ICreating:=False;
      {$ENDIF}

      LBTools.ItemIndex:=LBTools.Items.Count-1;
      LBTools.SetFocus;
      LBToolsClick(Self);
    end;
  finally
    Free;
  end;
end;

function TFormTeeTools.CurrentTool: TTeeCustomTool;
begin
  if LBTools.ItemIndex=-1 then
     result:=nil
  else
     result:=TTeeCustomTool(LBTools.Items.Objects[LBTools.ItemIndex]);
end;

procedure TFormTeeTools.FillAndSet;
begin
  FillTools;

  With LBTools do
  if Items.Count>0 then
  begin
    ItemIndex:=0;
    LBToolsClick(Self);
  end
  else EnableButtons;
end;

procedure TFormTeeTools.FormShow(Sender: TObject);
begin
  Chart:=TCustomChart(Tag);

  if Assigned(Chart) then
  begin
    PBottom.Visible:=csDesigning in Chart.ComponentState;
    FillAndSet;
  end;

  {$IFDEF CLX}
  ICreating:=False;

  if LBTools.Items.Count>0 then
  begin
    if LBTools.ItemIndex=-1 then LBTools.ItemIndex:=0;
    LBToolsClick(Self);
  end;
  {$ENDIF}

  TeeTranslateControl(Self);
end;

procedure TFormTeeTools.FormCreate(Sender: TObject);
begin
  {$IFDEF CLX}
  ICreating:=True;
  {$ENDIF}
  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);
end;

procedure TFormTeeTools.SwapTool(A,B:Integer);
var tmpIndex : Integer;
begin
  LBTools.Items.Exchange(A,B);

  {$IFDEF CLX}
  if LBTools.ItemIndex=A then
     LBTools.ItemIndex:=B;
  {$ENDIF}

  LBTools.Invalidate;

  With Chart do
  begin
    Tools.Exchange(A,B);
    tmpIndex:=Tools[A].ComponentIndex;
    Tools[A].ComponentIndex:=Tools[B].ComponentIndex;
    Tools[B].ComponentIndex:=tmpIndex;
    Invalidate;
  end;

  EnableButtons;
end;

procedure TFormTeeTools.EnableButtons;
begin
  With LBTools do
  begin
    BMoveUp.Enabled  :=ItemIndex>0;
    BMoveDown.Enabled:=ItemIndex<Items.Count-1;
  end;
end;

procedure TFormTeeTools.BMoveUpClick(Sender: TObject);
begin
  With LBTools do SwapTool(ItemIndex,ItemIndex-1);
end;

procedure TFormTeeTools.BMoveDownClick(Sender: TObject);
begin
  With LBTools do SwapTool(ItemIndex,ItemIndex+1);
end;

Procedure TFormTeeTools.Reload;
begin
  if Chart<>nil then
     if Chart.Tools.Count<>LBTools.Items.Count then FillAndSet;

  if LBTools.ItemIndex<>-1 then LBToolsClick(Self);
end;

{$IFNDEF CLX}
procedure TFormTeeTools.LBToolsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
procedure TFormTeeTools.LBToolsDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ENDIF}
begin
  TeeDrawTool(LBTools,Index,Rect,State,TTeeCustomTool(LBTools.Items.Objects[Index]));
end;

{$IFNDEF CLX}
procedure TFormTeeTools.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(Parent) then
     Parent.UpdateControlState;
end;
{$ENDIF}

end.
