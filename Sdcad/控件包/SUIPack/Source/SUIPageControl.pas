////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIPageControl.pas
//  Creator     :   Shen Min
//  Date        :   2002-11-20 V1-V3
//                  2003-07-11 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIPageControl;

interface

{$I SUIPack.inc}

uses Windows, Messages, SysUtils, Classes, Controls, Forms, CommCtrl, ExtCtrls,
     Graphics, Dialogs,
     SUITabControl, SUIThemes, SUIMgr;

type
    // -------------- TsuiPageControlTopPanel ------------------
    TsuiPageControlTopPanel = class(TsuiTabControlTopPanel)
    private
        procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    end;

    TsuiPageControl = class;

    // -------------- TsuiTabSheet -----------------------------
    TsuiTabSheet = class(TCustomPanel)
    private
        m_PageControl : TsuiPageControl;
        m_PageIndex : Integer;
        m_Caption : TCaption;
        m_BorderColor : TColor;
        m_TabVisible : Boolean;
        m_OnShow: TNotifyEvent;
        m_OnHide : TNotifyEvent;

        procedure SetPageControl(const Value: TsuiPageControl);
        procedure SetPageIndex(const Value: Integer);

        procedure ReadPageControl(Reader: TReader);
        procedure WritePageControl(Writer: TWriter);
        procedure SetCaption(const Value: TCaption);
        function GetTabVisible: Boolean;
        procedure SetTabVisible(const Value: Boolean);
        procedure DoShow();
        procedure DoHide();

    protected
        procedure DefineProperties(Filer: TFiler); override;
        procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    public
        constructor Create(AOwner : TComponent); override;
        procedure UpdateUIStyle(UIStyle: TsuiUIStyle; FileTheme : TsuiFileTheme);
        property PageControl : TsuiPageControl read m_PageControl write SetPageControl;
        
    published
        property PageIndex : Integer read m_PageIndex write SetPageIndex;
        property Caption : TCaption read m_Caption write SetCaption;
        property TabVisible : Boolean read GetTabVisible write SetTabVisible;

        property BiDiMode;
        property Color;
        property Constraints;
        property UseDockManager default True;
        property DockSite;
        property DragCursor;
        property DragKind;
        property DragMode;
        property Enabled;
        property FullRepaint;
        property Font;
        property Locked;
        property ParentBiDiMode;
        property ParentColor;
        property ParentCtl3D;
        property ParentFont;
        property ParentShowHint;
        property PopupMenu;
        property ShowHint;
        property TabOrder;
        property TabStop;
        property Visible;

        property OnCanResize;
        property OnClick;
        property OnShow: TNotifyEvent read m_OnShow write m_OnShow;
        property OnHide : TNotifyEvent read m_OnHide write m_OnHide;
        property OnConstrainedResize;
        property OnContextPopup;
        property OnDockDrop;
        property OnDockOver;
        property OnDblClick;
        property OnDragDrop;
        property OnDragOver;
        property OnEndDock;
        property OnEndDrag;
        property OnEnter;
        property OnExit;
        property OnGetSiteInfo;
        property OnMouseDown;
        property OnMouseMove;
        property OnMouseUp;
        property OnResize;
        property OnStartDock;
        property OnStartDrag;
        property OnUnDock;
    end;


    // -------------- TsuiPageControl --------------------------
    TsuiPageControl = class(TsuiTab)
    private
        m_PageList : TList;
        m_ActivePage : TsuiTabSheet;
        m_TempList : TStrings;

        function NewPage() : TsuiTabSheet;
        procedure ActivatePage(Page : TsuiTabSheet); overload;
        procedure ActivatePage(nPageIndex : Integer); overload;
        procedure RemovePage(Page: TsuiTabSheet);
        procedure InsertPage(Page: TsuiTabSheet);
        function GetCurPage() : TsuiTabSheet;
        procedure MovePage(Page : TsuiTabSheet; var NewIndex : Integer);
        procedure ActivateNextVisiblePage(CurPageIndex : Integer);
        procedure UpdateTabVisible();
        function FindNextVisiblePage(CurPageIndex : Integer) : Integer;
        function FindPrevVisiblePage(CurPageIndex : Integer) : Integer;

        procedure UpdateCaptions();
        procedure UpdatePageIndex();

        procedure CMCONTROLLISTCHANGE(var Msg : TMessage); message CM_CONTROLLISTCHANGE;
        procedure CMCOLORCHANGED(var Msg : TMessage); message CM_COLORCHANGED;
        procedure SetActivePage(const Value: TsuiTabSheet);

        procedure ReadPages(Reader: TReader);
        procedure WritePages(Writer: TWriter);

        procedure ReSortPages();
        function GetPageCount: Integer;
        function GetPage(Index: Integer): TsuiTabSheet;
        function GetActivePageIndex: Integer;
        procedure SetActivePageIndex(const Value: Integer);

    protected
        function CreateTopPanel() : TsuiTabControlTopPanel; override;
        procedure TabActive(TabIndex : Integer); override;
        procedure DefineProperties(Filer: TFiler); override;
        procedure BorderColorChanged(); override;
        procedure ShowControl(AControl: TControl); override;

    public
        constructor Create(AOwner : TComponent); override;
        destructor Destroy(); override;
        procedure UpdateUIStyle(UIStyle : TsuiUIStyle; FileTheme : TsuiFileTheme); override;
        procedure SelectNextPage(GoForward: Boolean);
        function FindNextPage(CurPage: TsuiTabSheet; GoForward : Boolean): TsuiTabSheet;

        property Pages[Index: Integer]: TsuiTabSheet read GetPage;
        property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;

    published
        property ActivePage : TsuiTabSheet read m_ActivePage write SetActivePage;
        property PageCount : Integer read GetPageCount;

    end;

    procedure PageControl_InsertPage(AComponent : TComponent);
    procedure PageControl_RemovePage(AComponent : TComponent);
    function PageControl_CanRemove(AComponent : TComponent) : Boolean;

    procedure TabSheet_InsertPage(AComponent : TComponent);
    procedure TabSheet_RemovePage(AComponent : TComponent);
    function TabSheet_CanRemove(AComponent : TComponent) : Boolean;


implementation

uses SUIPublic;

var
    l_EditorRemove : Boolean = false;

procedure PageControl_InsertPage(AComponent : TComponent);
begin
    (AComponent as TsuiPageControl).NewPage();
end;

procedure PageControl_RemovePage(AComponent : TComponent);
var
    TabSheet : TsuiTabSheet;
begin
    with (AComponent as TsuiPageControl) do
    begin
        l_EditorRemove := true;
        TabSheet := GetCurPage();
        TabSheet.PageControl := nil;
        TabSheet.Parent := nil;
        TabSheet.Free();
        l_EditorRemove := false;
    end;
end;

function PageControl_CanRemove(AComponent : TComponent) : Boolean;
begin
    if ((AComponent as TsuiPageControl).m_TopPanel.Tabs.Count = 0) then
        Result := false
    else
        Result := true;
end;

procedure TabSheet_InsertPage(AComponent : TComponent);
begin
    if (AComponent as TsuiTabSheet).PageControl <> nil then
        (AComponent as TsuiTabSheet).PageControl.NewPage();
end;

procedure TabSheet_RemovePage(AComponent : TComponent);
begin
    l_EditorRemove := true;
    with (AComponent as TsuiTabSheet) do
    begin
        PageControl := nil;
        Parent := nil;
        Free();
    end;
    l_EditorRemove := false;
end;

function TabSheet_CanRemove(AComponent : TComponent) : Boolean;
begin
    Result := false;
    if (AComponent as TsuiTabSheet).PageControl = nil then
        Exit;

    if ((AComponent as TsuiTabSheet).PageControl.m_TopPanel.Tabs.Count = 0) then
        Result := false
    else
        Result := true;
end;

{ TsuiPageControl }

procedure TsuiPageControl.ActivatePage(Page: TsuiTabSheet);
begin
    if (m_ActivePage <> nil) and (m_ActivePage <> Page) then
    begin
        m_ActivePage.Enabled := false;       
        m_ActivePage.DoHide();
    end;
    m_ActivePage := Page;

    if Page = nil then
        Exit;

    TabIndex := Page.PageIndex;
    m_TopPanel.TabIndex := Page.PageIndex;
    m_ActivePage.Visible := true;
    m_ActivePage.Enabled := true;
    m_ActivePage.BringToFront();
    m_ActivePage.Repaint();
    m_ActivePage.DoShow();
end;

procedure TsuiPageControl.ActivateNextVisiblePage(CurPageIndex: Integer);
var
    i : Integer;
    Found : Boolean;
begin
    Found := false;
    for i := CurPageIndex - 1 downto 0 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            ActivatePage(i);
            Found := true;
            break;
        end;
    end;

    if Found then
        Exit;

    for i := CurPageIndex + 1 to m_PageList.Count - 1 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            ActivatePage(i);
            break;
        end;
    end;
end;

procedure TsuiPageControl.ActivatePage(nPageIndex: Integer);
begin
    if (m_ActivePage <> nil) and (m_ActivePage.PageIndex <> nPageIndex) then
    begin
        m_ActivePage.Enabled := false;
        m_ActivePage.DoHide();
    end;
        
    if (
        (nPageIndex > m_TopPanel.Tabs.Count - 1) or
        (nPageIndex < 0)
    ) then
    begin
        ActivePage := nil;
        Exit;
    end;
    TabIndex := nPageIndex;
    m_TopPanel.TabIndex := nPageIndex;
    m_ActivePage := TsuiTabSheet(m_PageList[nPageIndex]);
    m_ActivePage.Visible := true;
    m_ActivePage.Enabled := true;
    m_ActivePage.BringToFront();
    m_ActivePage.Repaint();
    m_ActivePage.DoShow();
end;

procedure TsuiPageControl.BorderColorChanged;
var
    i : Integer;
begin
    if m_PageList = nil then
        Exit;

    for i := 0 to m_PageList.Count - 1 do
        TsuiTabSheet(m_PageList[i]).m_BorderColor := BorderColor;
    if m_ActivePage <> nil then
        m_ActivePage.Repaint();
end;

procedure TsuiPageControl.CMCOLORCHANGED(var Msg: TMessage);
var
    i : Integer;
begin
    if m_PageList = nil then
        Exit;

    for i := 0 to m_PageList.Count - 1 do
        TsuiTabSheet(m_PageList[i]).Color := Color;
end;

procedure TsuiPageControl.CMCONTROLLISTCHANGE(var Msg: TMessage);
begin
    if not Boolean(Msg.LParam) then
    begin // remove
        if TControl(Msg.WParam) is TsuiTabSheet then
            RemovePage(TsuiTabSheet(Msg.WParam));
    end
    else
    begin // add
        if TControl(Msg.WParam) is TsuiTabSheet then
            InsertPage(TsuiTabSheet(Msg.WParam));
    end;
end;

constructor TsuiPageControl.Create(AOwner: TComponent);
begin
    inherited;

    m_PageList := TList.Create();
    m_TempList := TStringList.Create();
    m_TopPanel.Tabs.Clear();
end;

function TsuiPageControl.CreateTopPanel: TsuiTabControlTopPanel;
begin
    Result := TsuiPageControlTopPanel.Create(self, self);
end;

procedure TsuiPageControl.DefineProperties(Filer: TFiler);
begin
    inherited;

    Filer.DefineProperty(
        'Pages',
        ReadPages,
        WritePages,
        true
    );
end;

destructor TsuiPageControl.Destroy;
var
    i : Integer;
begin
    for i := 0 to m_PageList.Count - 1 do
        TsuiTabSheet(m_PageList[i]).m_PageControl := nil;

    m_TempList.Free();
    m_TempList := nil;

    m_PageList.Free();
    m_PageList := nil;

    inherited;
end;

function TsuiPageControl.GetCurPage: TsuiTabSheet;
begin
    Result := m_PageList[m_TopPanel.TabIndex];
end;

procedure TsuiPageControl.InsertPage(Page: TsuiTabSheet);
begin
    Page.m_PageControl := self;
    Page.Color := Color;
    Page.m_BorderColor := BorderColor;
    m_TopPanel.Tabs.Add(Page.Caption);
    m_PageList.Add(Page);
    UpdatePageIndex();
    UpdateCaptions();

    ActivatePage(Page);
end;

procedure TsuiPageControl.MovePage(Page: TsuiTabSheet; var NewIndex: Integer);
begin
    if (NewIndex < 0) or (NewIndex > m_PageList.Count - 1) then
    begin
        NewIndex := Page.PageIndex;
        Exit;
    end;

    m_PageList.Move(Page.PageIndex, NewIndex);
    UpdatePageIndex();
    UpdateCaptions();
    ActivatePage(Page);
end;

function TsuiPageControl.NewPage: TsuiTabSheet;
var
    Form : TCustomForm;
begin
    Result := TsuiTabSheet.Create(Owner);
    Form := TCustomForm(Owner);
    if Form <> nil then
        Result.Name := Form.Designer.UniqueName('suiTabSheet')
    else
        Result.Name := 'suiTabSheet' + IntToStr(m_PageList.Count + 1);
    Result.Caption := Result.Name;
    Result.Parent := self;
    Result.Align := alClient;
end;

procedure TsuiPageControl.ReadPages(Reader: TReader);
begin
    Reader.ReadListBegin();

    while not Reader.EndOfList() do
        m_TempList.Add(Reader.ReadIdent());

    Reader.ReadListEnd();
end;

procedure TsuiPageControl.RemovePage(Page: TsuiTabSheet);
begin
    m_TopPanel.Tabs.Delete(Page.PageIndex);
    m_PageList.Delete(Page.PageIndex);
    UpdatePageIndex();
    ActivatePage(Page.PageIndex - 1);
end;

procedure TsuiPageControl.ReSortPages;
    function SortList(Item1, Item2: Pointer): Integer;
    begin
        if TsuiTabSheet(Item1).m_PageIndex < TsuiTabSheet(Item2).m_PageIndex then
            Result := -1
        else if TsuiTabSheet(Item1).m_PageIndex = TsuiTabSheet(Item2).m_PageIndex then
            Result := 0
        else
            Result := 1;
    end;
var
    i : Integer;
begin
    for i := 0 to m_PageList.Count - 1 do
        TsuiTabSheet(m_PageList[i]).m_PageIndex := m_TempList.IndexOf(TsuiTabSheet(m_PageList[i]).Name);
    m_PageList.Sort(@SortList);
    UpdatePageIndex();
    UpdateCaptions();
end;

procedure TsuiPageControl.SetActivePage(const Value: TsuiTabSheet);
begin
    ActivatePage(Value);
end;

procedure TsuiPageControl.TabActive(TabIndex: Integer);
begin
    if (m_ActivePage <> nil) and (m_ActivePage.PageIndex <> TabIndex) then
    begin
        m_ActivePage.Enabled := false;       
        m_ActivePage.DoHide();
    end;
    m_ActivePage := TsuiTabSheet(m_PageList[TabIndex]);
    m_ActivePage.Visible := true;
    m_ActivePage.Enabled := true;   
    m_ActivePage.BringToFront();
    m_ActivePage.Repaint();
    if (not (csLoading in ComponentState)) and (not (csDesigning in ComponentState)) then
    begin
        if (
            (m_ActivePage.ControlCount > 0) and
            (m_ActivePage.Controls[0] is TWinControl) and
            (m_ActivePage.Controls[0].Visible) //"Fastream Technologies (http://www.fastream.com) fixed a bug here. Happy Coding!"
        ) then
            try
            if (m_ActivePage.Controls[0] as TWinControl).CanFocus() then
                GetParentForm(self).ActiveControl := m_ActivePage.Controls[0] as TWinControl;
            except
            end;
    end;
    m_ActivePage.DoShow();

    inherited;
end;

procedure TsuiPageControl.UpdateCaptions;
var
    i : Integer;
begin
    m_TopPanel.Tabs.Clear();
    for i := 0 to m_PageList.Count - 1 do
        m_TopPanel.Tabs.Add(TsuiTabSheet(m_PageList[i]).Caption)
end;

procedure TsuiPageControl.UpdatePageIndex;
var
    i : Integer;
begin
    for i := 0 to m_PageList.Count - 1 do
        TsuiTabSheet(m_PageList[i]).m_PageIndex := i;
end;

procedure TsuiPageControl.UpdateUIStyle(UIStyle: TsuiUIStyle; FileTheme : TsuiFileTheme);
var
    i : Integer;
begin
    if m_PageList = nil then
        Exit;

    for i := 0 to m_PageList.Count - 1 do
    begin
        TsuiTabSheet(m_PageList[i]).UpdateUIStyle(UIStyle, FileTheme);
        TsuiTabSheet(m_PageList[i]).Color := Color;
        TsuiTabSheet(m_PageList[i]).m_BorderColor := BorderColor;
        TsuiTabSheet(m_PageList[i]).Align := alClient;
    end;
end;

procedure TsuiPageControl.WritePages(Writer: TWriter);
var
    i : Integer;
begin
    Writer.WriteListBegin();
    for i := 0 to m_PageList.Count - 1 do
        Writer.WriteIdent(TsuiTabSheet(m_PageList[i]).Name);
    Writer.WriteListEnd();
end;

procedure TsuiPageControl.UpdateTabVisible;
var
    i : Integer;
begin
    for i := 0 to m_PageList.Count - 1 do
        m_TopPanel.m_TabVisible[i] := TsuiTabSheet(m_PageList[i]).m_TabVisible;
end;

function TsuiPageControl.GetPageCount: Integer;
begin
    Result := m_PageList.Count;
end;

function TsuiPageControl.GetPage(Index: Integer): TsuiTabSheet;
begin
    if (Index > m_PageList.Count - 1) or (Index < 0) then
        Result := nil
    else
        Result := TsuiTabSheet(m_PageList[Index]);
end;

function TsuiPageControl.GetActivePageIndex: Integer;
begin
    if m_ActivePage <> nil then
        Result := m_ActivePage.PageIndex
    else
        Result := 0;
end;

procedure TsuiPageControl.SetActivePageIndex(const Value: Integer);
begin
    if (Value > m_PageList.Count - 1) or (Value < 0) then
        Exit;
    ActivatePage(Value);
end;

procedure TsuiPageControl.SelectNextPage(GoForward: Boolean);
begin
    if m_ActivePage = nil then
        Exit;
    ActivatePage(FindNextPage(m_ActivePage, GoForward));
end;

function TsuiPageControl.FindNextVisiblePage(CurPageIndex: Integer) : Integer;
var
    i : Integer;
    Found : Boolean;
begin
    Result := -1;
    Found := false;
    for i := CurPageIndex + 1 to m_PageList.Count - 1 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            Result := i;
            Found := true;
            break;
        end;
    end;

    if Found then
        Exit;

    for i := 0 to CurPageIndex - 1 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            Result := i;
            break;
        end;
    end;
end;

function TsuiPageControl.FindPrevVisiblePage(CurPageIndex: Integer) : Integer;
var
    i : Integer;
    Found : Boolean;
begin
    Result := -1;
    Found := false;
    for i := CurPageIndex - 1 downto 0 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            Result := i;
            Found := true;
            break;
        end;
    end;

    if Found then
        Exit;

    for i := m_PageList.Count - 1 downto CurPageIndex + 1 do
    begin
        if TsuiTabSheet(m_PageList[i]).TabVisible then
        begin
            Result := i;
            break;
        end;
    end;
end;

function TsuiPageControl.FindNextPage(CurPage: TsuiTabSheet; GoForward: Boolean): TsuiTabSheet;
var
    NextPage : Integer;
begin
    Result := nil;
    if GoForward then
        NextPage := FindNextVisiblePage(CurPage.PageIndex)
    else
        NextPage := FindPrevVisiblePage(CurPage.PageIndex);

    if NextPage <> -1 then
        Result := m_PageList[NextPage];
end;

procedure TsuiPageControl.ShowControl(AControl: TControl);
begin
    inherited;

    if not (AControl is TsuiTabSheet) then
        Exit;

    ActivatePage(AControl as TsuiTabSheet);
end;

{ TsuiPageControlTopPanel }

procedure TsuiPageControlTopPanel.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
    HitPos : TPoint;
    Form : TCustomForm;
begin
    if Msg.Keys = MK_LBUTTON then
    begin
        HitPos := SmallPointToPoint(Msg.Pos);
        MouseDown(mbLeft, [], HitPos.X, HitPos.Y);

        if Owner.Owner is TCustomForm then
        begin
            Form := TCustomForm(Owner.Owner);
            if Form <> nil then
                Form.Designer.Modified();
        end;
        Msg.Result := 0;
    end;
end;

{ TsuiTabSheet }

constructor TsuiTabSheet.Create(AOwner: TComponent);
begin
    inherited;

    inherited Caption := ' ';
    m_PageIndex := -1;
    m_TabVisible := true;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    BorderWidth := 0;
    Align := alClient;
end;

procedure TsuiTabSheet.DefineProperties(Filer: TFiler);
begin
    inherited;

    Filer.DefineProperty(
        'PageControl',
        ReadPageControl,
        WritePageControl,
        true
    );
end;

procedure TsuiTabSheet.DoHide;
begin
    if Assigned(m_OnHide) then
        m_OnHide(self);
end;

procedure TsuiTabSheet.DoShow;
begin
    if Assigned(m_OnShow) then
        m_OnShow(Self);
end;

function TsuiTabSheet.GetTabVisible: Boolean;
begin
    Result := m_PageControl.m_TopPanel.m_TabVisible[PageIndex];
end;

procedure TsuiTabSheet.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
    inherited;

    if l_EditorRemove then
        Exit;

    if m_PageControl = nil then
        Exit;

    if (Operation = opRemove) and (AComponent = self) then
        Parent := nil;
end;

procedure TsuiTabSheet.ReadPageControl(Reader: TReader);
begin
    m_PageControl := TsuiPageControl(Owner.FindComponent(Reader.ReadIdent()));

    if m_PageControl = nil then
        Exit;
    if m_PageControl.m_PageList.Count = m_PageControl.m_TempList.Count then
    begin
        m_PageControl.ReSortPages();
        m_PageControl.UpdateTabVisible();
    end;
end;

procedure TsuiTabSheet.SetCaption(const Value: TCaption);
begin
    m_Caption := Value;

    if m_PageControl = nil then
        Exit;
    m_PageControl.UpdateCaptions();
end;

procedure TsuiTabSheet.SetPageControl(const Value: TsuiPageControl);
begin
    m_PageControl := Value;
    if m_PageControl = nil then
        Exit;
    Parent := m_PageControl;
end;

procedure TsuiTabSheet.SetPageIndex(const Value: Integer);
var
    NewIndex : Integer;
begin
    if m_PageControl = nil then
        Exit;

    NewIndex := Value;
    m_PageControl.MovePage(self, NewIndex);
    m_PageIndex := NewIndex;
end;

procedure TsuiTabSheet.SetTabVisible(const Value: Boolean);
begin
    m_TabVisible := Value;
    if m_PageControl = nil then
        Exit;

    m_PageControl.m_TopPanel.m_TabVisible[PageIndex] := Value;
    m_PageControl.m_TopPanel.Repaint();


    if (not Value) and (m_PageControl.ActivePage = self) then
        m_PageControl.ActivateNextVisiblePage(PageIndex)
//    else
//        m_PageControl.ActivatePage(PageIndex);
end;

procedure TsuiTabSheet.UpdateUIStyle(UIStyle: TsuiUIStyle; FileTheme : TsuiFileTheme);
begin
    ContainerApplyUIStyle(self, UIStyle, FileTheme);
end;

procedure TsuiTabSheet.WritePageControl(Writer: TWriter);
begin
    if m_PageControl <> nil then
        Writer.WriteIdent(m_PageControl.Name);
end;

end.
