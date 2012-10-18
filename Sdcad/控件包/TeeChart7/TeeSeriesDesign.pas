{*****************************************}
{  TeeChart Pro                           }
{  Copyright (c) 1999-2004 David Berneda  }
{  Series Design Time Editor              }
{*****************************************}
unit TeeSeriesDesign;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QStdCtrls, QExtCtrls, QMenus, QComCtrls,
     QImgList, QDialogs,
     {$ELSE}
     Graphics, Controls, Forms, StdCtrls, ExtCtrls, Menus, ComCtrls, ImgList,
     Dialogs,
     {$ENDIF}

     {$IFDEF D6}
      {$IFDEF CLX}
      DesignIntf, ClxDesignWindows, ToolWnds,
      {$ELSE}
       {$IFDEF CLR}
       Borland.Vcl.Design.DesignEditors, Borland.Vcl.Design.DesignIntf,
       Borland.Vcl.Design.DesignWindows, 
       // Borland.Vcl.Design.ToolWindows,
       {$ELSE}
       DesignIntf, DesignWindows, ToolWnds,
       {$ENDIF}
      {$ENDIF}
     {$ELSE}
     DsgnIntf, DsgnWnds,
     {$ENDIF}

     TeeLisB, Chart, ToolWin, TeeProCo, TeEngine, TeeChartReg;

type
  TTeeDesignerList={$IFDEF D6}
                   class(TDesignerSelections);
                   {$ELSE}
                   {$IFDEF D5}
                   TDesignerSelectionList;
                   {$ELSE}
                   TComponentList;
                   {$ENDIF}
                   {$ENDIF}

type
  TSeriesEditor = class({$IFDEF CLX}TClxDesignWindow{$ELSE}TDesignWindow{$ENDIF})
    LocalMenu: TPopupMenu;
    AddItem: TMenuItem;
    DeleteItem: TMenuItem;
    SelectAllItem: TMenuItem;
    CloneItem: TMenuItem;
    Change1: TMenuItem;
    N1: TMenuItem;
    Edit1: TMenuItem;
    Title1: TMenuItem;
    ToolBar1: TToolBar;
    SBAdd: TToolButton;
    SBDelete: TToolButton;
    ToolButton3: TToolButton;
    TBMoveUp: TToolButton;
    TBMoveDown: TToolButton;
    ToolButton6: TToolButton;
    SBEdit: TToolButton;
    ImageList1: TImageList;
    N2: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    ChartListBox1: TChartListBox;
    procedure FormCreate(Sender: TObject);
    procedure AListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure SelectAllItemClick(Sender: TObject);
    procedure LocalMenuPopup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloneItemClick(Sender: TObject);
    procedure Change1Click(Sender: TObject);
    procedure ChartListBox1Click(Sender: TObject);
    procedure ChartListBox1DblClickSeries(Sender: TChartListBox;
      Index: Integer);
    procedure Title1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBAddClick(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBEditClick(Sender: TObject);
    procedure TBMoveUpClick(Sender: TObject);
    procedure TBMoveDownClick(Sender: TObject);
  private
    FEditSeriesProc : TTeeEditSeriesProc;
    Procedure CheckChangedSeries(AItem:TPersistent);
    procedure CheckDelete;
    Procedure EnableButtons;
    procedure UpdateDisplay;
    procedure UpdateCaption;
    procedure UpdateSelection;
  protected
    procedure Activated; override;
    function UniqueName(Component: TComponent): string; override;
  public
    {$IFDEF D6}
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent); override;
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent); override;
    procedure SelectionChanged(const ADesigner: IDesigner;
      const ASelection: IDesignerSelections); override;
    {$ELSE}
    procedure ComponentDeleted(Component: IPersistent); override;
    {$IFDEF D5}
    procedure ComponentInserted(Component: IPersistent); override;
    procedure EditAction(Action: TEditAction); override;
    {$ENDIF}
    procedure FormModified; override;
    procedure SelectionChanged(ASelection: TTeeDesignerList); override;
    {$ENDIF}
  end;

procedure TeeShowSeriesEditor( ADesigner: {$IFDEF D6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
                               AChart: TCustomChart;
                               EditSeriesProc:TTeeEditSeriesProc);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFNDEF D5}
     TeCanvas,
     {$ENDIF}
     TeeProcs;

type 
  TTeeSeriesDesigner=class(TTeeCustomDesigner)
  private
    FEditor : TSeriesEditor;
  public
    Destructor Destroy; override;
    Procedure Repaint; override;
    Procedure Refresh; override;
  end;

procedure TeeShowSeriesEditor( ADesigner: {$IFDEF D6}IDesigner{$ELSE}IFormDesigner{$ENDIF};
                               AChart: TCustomChart;
                               EditSeriesProc:TTeeEditSeriesProc);
begin
  if not Assigned(AChart.Designer) then
  begin
    AChart.Designer:=TTeeSeriesDesigner.Create;
    With TTeeSeriesDesigner(AChart.Designer) do
    begin
      FEditor:=TSeriesEditor.Create(Application);
      FEditor.Designer:=ADesigner;
      FEditor.ChartListBox1.Chart:=AChart;
      FEditor.FEditSeriesProc:=EditSeriesProc;
    end;
  end;
  TTeeSeriesDesigner(AChart.Designer).FEditor.Show;
end;


{ TTeeSeriesDesigner }
Destructor TTeeSeriesDesigner.Destroy;
begin
  if Assigned(FEditor) then
  begin
    FEditor.ChartListBox1.Chart.Designer:=nil;
    FEditor.Free;
  end;
  inherited;
end;

Procedure TTeeSeriesDesigner.Repaint;
begin
  if Assigned(FEditor) then FEditor.Designer.Modified;
end;

Procedure TTeeSeriesDesigner.Refresh;
begin
  if Assigned(FEditor) then
  With FEditor do
  begin
    if ChartListBox1.SelCount<2 then ChartListBox1.UpdateSeries;
    UpdateSelection;
    Designer.Modified;
  end;
end;

{ TSeriesEditor }
procedure TSeriesEditor.UpdateDisplay;
begin
  UpdateCaption;
  UpdateSelection;
end;

procedure TSeriesEditor.UpdateCaption;
var NewCaption : String;
begin
  with ChartListBox1 do
  if Assigned(Chart) then
  begin
    NewCaption:=Chart.Name;
    if Assigned(Chart.Owner) then
       NewCaption:=Chart.Owner.Name+'.'+NewCaption;
  end
  else NewCaption:='';
  if Caption <> NewCaption then Caption := NewCaption;
end;

procedure TSeriesEditor.UpdateSelection;
var t             : Integer;
    ComponentList : TTeeDesignerList;
begin
  if Active then
  begin
    ComponentList:=TTeeDesignerList.Create;
    try
      with ChartListBox1 do
      for t:=0 to Items.Count-1 do
          if Selected[t] then 
             {$IFDEF CLR}IDesignerSelections{$ENDIF}(ComponentList).Add(ChartListBox1.Series[t]);

      if {$IFDEF CLR}IDesignerSelections{$ENDIF}(ComponentList).Count=0 then 
         {$IFDEF CLR}IDesignerSelections{$ENDIF}(ComponentList).Add(ChartListBox1.Chart);
    except
      ComponentList.Free;
      raise;
    end;

    SetSelection(ComponentList);
  end;
end;

procedure TSeriesEditor.FormCreate(Sender: TObject);
begin
//  HelpContext := hcDataSetDesigner;
  TeeTranslateControl(Self);
  SBEdit.Hint:=TeeCommanMsg_Edit
end;

Procedure TSeriesEditor.EnableButtons;
begin
  SBEdit.Enabled:=ChartListBox1.SelectedSeries<>nil;
  SBDelete.Enabled:=SBEdit.Enabled;
  TBMoveUp.Enabled:=SBEdit.Enabled and (ChartListBox1.ItemIndex>0);
  TBMoveDown.Enabled:=SBEdit.Enabled and (ChartListBox1.ItemIndex<ChartListBox1.Items.Count-1);
end;

procedure TSeriesEditor.Activated;
begin
  ChartListBox1.UpdateSeries;
  UpdateSelection;
end;

Procedure TSeriesEditor.CheckChangedSeries(AItem:TPersistent);
begin
  if (AItem is TChartSeries) and
     (TChartSeries(AItem).ParentChart=ChartListBox1.Chart) then
  begin
    ChartListBox1.UpdateSeries;
    UpdateDisplay;
  end;
end;

{$IFDEF D6}
procedure TSeriesEditor.ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  inherited;
  CheckChangedSeries(AItem);
end;

procedure TSeriesEditor.ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  inherited;
  if AItem=ChartListBox1.Chart then Release
                               else CheckChangedSeries(AItem);
end;

procedure TSeriesEditor.SelectionChanged(const ADesigner: IDesigner;
      const ASelection: IDesignerSelections);

  function InSelection(Component: TComponent): Boolean;
  var t : Integer;
  begin
    Result := True;
    if Assigned(ASelection) then
    with ASelection do
    for t:=0 to Count-1 do
        if Component=Items[t] then Exit;
    Result := False;
  end;

var t : Integer;
    S : Boolean;
begin
  with ChartListBox1 do
  for t:=0 to Items.Count-1 do
  begin
    S:=InSelection(Series[t]);
    if Selected[t]<>S then Selected[t]:=S;
  end;
end;
{$ELSE}

procedure TSeriesEditor.ComponentDeleted(Component: IPersistent);
var AItem : TPersistent;
begin
  inherited;
  AItem:=ExtractPersistent(Component);
  if AItem=ChartListBox1.Chart then Release
                               else CheckChangedSeries(AItem);
end;

{$IFDEF D5}
procedure TSeriesEditor.ComponentInserted(Component: IPersistent);
begin
  inherited;
  CheckChangedSeries(ExtractPersistent(Component));
end;

procedure TSeriesEditor.EditAction(Action: TEditAction);
begin
  case Action of
    eaCut: ;
    eaCopy: ;
    eaPaste: ;
    eaDelete: SBDeleteClick(Self);
    eaSelectAll: SelectAllItemClick(Self);
  end;
end;
{$ENDIF}

procedure TSeriesEditor.FormModified;
begin
  UpdateCaption;
end;

procedure TSeriesEditor.SelectionChanged(ASelection: TTeeDesignerList);

  function InSelection(Component: TComponent): Boolean;
  var t : Integer;
  begin
    if Assigned(ASelection) then
    with {$IFDEF CLR}IDesignerSelections{$ENDIF}(ASelection) do
    for t:=0 to Count-1 do
        if Component=Items[t] then 
        begin
          result:=True;
          Exit;
        end;

    Result := False;
  end;

var t : Integer;
    S : Boolean;
begin
  with ChartListBox1 do
  for t:=0 to Items.Count-1 do
  begin
    S:=InSelection(Series[t]);
    if Selected[t]<>S then 
       Selected[t]:=S;
  end;
end;
{$ENDIF}

procedure TSeriesEditor.AListBoxKeyPress(Sender: TObject;
  var Key: Char);
Var ComponentList : TTeeDesignerList;
begin
  case Key of
    #13, #33..#126:
      begin
        if Key = #13 then Key := #0;
        ActivateInspector(Key);
        Key := #0;
      end;
    #27:
      if Assigned(ChartListBox1.Chart) then
      begin
        ComponentList:=TTeeDesignerList.Create;
        {$IFDEF CLR}IDesignerSelections{$ENDIF}(ComponentList).Add(ChartListBox1.Chart);
        SetSelection(ComponentList);
        Key := #0;
      end;
  end;
end;

procedure TSeriesEditor.SelectAllItemClick(Sender: TObject);
begin
  ChartListBox1.SelectAll;
end;

procedure TSeriesEditor.LocalMenuPopup(Sender: TObject);
begin
  DeleteItem.Enabled:= ChartListBox1.SelCount>0;
  CloneItem.Enabled := ChartListBox1.SelCount=1;
  SelectAllItem.Enabled:=ChartListBox1.Items.Count > 0;
  Change1.Enabled:=DeleteItem.Enabled;
  Edit1.Enabled:=CloneItem.Enabled;
  Title1.Enabled:=CloneItem.Enabled;
  MoveUp1.Enabled:=Edit1.Enabled and (ChartListBox1.ItemIndex>0);
  MoveDown1.Enabled:=Edit1.Enabled and (ChartListBox1.ItemIndex<ChartListBox1.Items.Count-1);
end;

procedure TSeriesEditor.CheckDelete;
var t : Integer;
begin
  with ChartListBox1 do
  for t:=0 to Items.Count-1 do
  if Selected[t] and (csAncestor in Series[t].ComponentState) then
     raise Exception.Create(TeeMsg_CantDeleteAncestor);
end;

function TSeriesEditor.UniqueName(Component: TComponent): string;
begin
  result:=GetNewSeriesName(ChartListBox1.Chart.Owner);
end;

procedure TSeriesEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(ChartListBox1.Chart) then 
  begin
    ChartListBox1.Chart.Designer.Free;
    ChartListBox1.Chart.Designer:=nil;
  end;
end;

procedure TSeriesEditor.CloneItemClick(Sender: TObject);
begin
  ChartListBox1.CloneSeries;
end;

procedure TSeriesEditor.Change1Click(Sender: TObject);
begin
  ChartListBox1.ChangeTypeSeries(Self);
end;

procedure TSeriesEditor.ChartListBox1Click(Sender: TObject);
begin
  UpdateSelection;
  EnableButtons;
end;

procedure TSeriesEditor.ChartListBox1DblClickSeries(Sender: TChartListBox;
  Index: Integer);
begin
  SBEditClick(Self);
end;

procedure TSeriesEditor.Title1Click(Sender: TObject);
begin
  ChartListBox1.RenameSeries;
end;

procedure TSeriesEditor.FormShow(Sender: TObject);
begin
  UpdateCaption;
  EnableButtons;
end;

procedure TSeriesEditor.SBAddClick(Sender: TObject);
begin
  ChartListBox1.AddSeriesGallery;
  EnableButtons;
end;

procedure TSeriesEditor.SBDeleteClick(Sender: TObject);
begin
  CheckDelete;
  ChartListBox1.DeleteSeries;
  EnableButtons;
end;

procedure TSeriesEditor.SBEditClick(Sender: TObject);
begin
  FEditSeriesProc(ChartListBox1.SelectedSeries,Designer);
end;

procedure TSeriesEditor.TBMoveUpClick(Sender: TObject);
begin
  ChartListBox1.MoveCurrentUp;
  EnableButtons;
end;

procedure TSeriesEditor.TBMoveDownClick(Sender: TObject);
begin
  ChartListBox1.MoveCurrentDown;
  EnableButtons;
end;

end.

