////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIDsgn.pas
//  Creator     :   Shen Min
//  Date        :   2003-04-07 V1-V3
//                  2003-07-11 V4
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIDsgn;

interface

{$I SUIPack.inc}

uses Classes, Forms, Controls, TypInfo, Menus, StdCtrls, ComCtrls, ExtCtrls,
     CheckLst, SysUtils, Grids, Dialogs, Mask, FileCtrl, Windows,
     {$IFDEF DB}DBCtrls, DBGrids,{$ENDIF}
{$IFDEF SUIPACK_D5}
    DsgnIntf;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    DesignIntf, DesignEditors, DesignMenus;
{$ENDIF}

type
    TsuiPageControlEditor = class(TComponentEditor)
    public
        procedure Edit; override;
        procedure ExecuteVerb(Index:Integer);override;
        function GetVerb(Index:Integer):String;override;
        function GetVerbCount:Integer;override;
{$IFDEF SUIPACK_D5}
        procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
        procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
{$ENDIF}
    end;

    TsuiTabSheetEditor = class(TComponentEditor)
    public
        procedure Edit; override;
        procedure ExecuteVerb(Index:Integer);override;
        function GetVerb(Index:Integer):String;override;
        function GetVerbCount:Integer;override;
{$IFDEF SUIPACK_D5}
        procedure PrepareItem(Index: Integer; const AItem: TMenuItem); override;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
        procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
{$ENDIF}
    end;

    TsuiDialogEditor = class(TComponentEditor)
    public
        procedure Edit; override;
    end;

    TsuiThemeManagerEditor = class(TComponentEditor)
    public
        procedure Edit; override;
        procedure ExecuteVerb(Index:Integer);override;
        function GetVerb(Index:Integer):String;override;
        function GetVerbCount:Integer;override;
    end;

    TsuiThemeMgrCompListEditor = class(TPropertyEditor)
    public
        procedure Edit(); override;
        function GetAttributes() : TPropertyAttributes; override;
        function GetValue() : string; override;
    end;

    TsuiConvertor = class(TComponent)
    public
        constructor Create(AOwner: TComponent); override;

    end;

    TsuiUnConvertor = class(TComponent)
    public
        constructor Create(AOwner : TComponent); override;
        
    end;

    TsuiThemeFileEditor = class(TPropertyEditor)
    public
        procedure Edit; override;
        function GetAttributes: TPropertyAttributes; override;
        function GetValue: string; override;
    end;

    TsuiFileThemeEditor = class(TComponentEditor)
    public
        procedure Edit; override;
        procedure ExecuteVerb(Index:Integer);override;
        function GetVerb(Index:Integer):String;override;
        function GetVerbCount:Integer;override;
    end;

    TsuiBuiltInThemeFileEditor = class(TPropertyEditor)
    public
        procedure Edit; override;
        function GetAttributes: TPropertyAttributes; override;
        function GetValue: string; override;
    end;

    TsuiBuiltInFileThemeEditor = class(TsuiFileThemeEditor)
    public
        procedure Edit; override;
    end;


implementation

uses SUIMgr, SUIPageControl, SUIDlg, SUIPublic, SUIThemes, SUIForm, frmConvert,
     SUIPopupMenu, SUIMainMenu, SUIButton, SUIProgressBar, SUIEdit, SUIMemo,
     SUIListBox, SUIComboBox, SUIColorBox, SUICheckListBox, SUIGroupBox,
     SUIRadioGroup, SUIListView, SUITreeView, SUITabControl, SUITrackBar,
     SUIScrollBar, SUIStatusBar, {$IFDEF DB}SUIDBCtrls,{$ENDIF} SUIGrid;

// --------- Convertor -----------------------
type
{$IFDEF SUIPACK_D6UP}
    IsuiDesigner = type IDesigner;
{$ENDIF}
{$IFDEF SUIPACK_D5}
    IsuiDesigner = type IFormDesigner;
{$ENDIF}

var
    l_ToRemoveList : TList = nil;

procedure RemoveOldControl(Ctrl : TComponent; DoNow : Boolean = false);
var
    i : Integer;
begin
    if DoNow then
    begin
        if l_ToRemoveList = nil then
            Exit;
        for i := 0 to l_ToRemoveList.Count - 1 do
        begin
            if l_ToRemoveList[i] = nil then
                continue;
            TComponent(l_ToRemoveList[i]).Free();
            l_ToRemoveList[i] := nil;
        end;

        l_ToRemoveList.Free();
        l_ToRemoveList := nil;
    end
    else
    begin
        if l_ToRemoveList = nil then
            l_ToRemoveList := TList.Create();
        l_ToRemoveList.Add(Ctrl);
    end;
end;

procedure AssignProps(NewCtrl, OldCtrl : TComponent; Dsgn : IsuiDesigner);
    function SUIGetPropList(TypeInfo: PTypeInfo; out PropList: PPropList): Integer; overload;
    begin
      Result := GetTypeData(TypeInfo)^.PropCount;
      if Result > 0 then
      begin
        GetMem(PropList, Result * SizeOf(Pointer));
        GetPropInfos(TypeInfo, PropList);
      end;
    end;

    function SUIGetPropList(AObject: TObject; out PropList: PPropList): Integer; overload;
    begin
      Result := SUIGetPropList(PTypeInfo(AObject.ClassInfo), PropList);
    end;

var
    PropList : PPropList;
    nCount : Integer;
    i : Integer;
    PropInfo: PPropInfo;
    PopupMenu : TPopupMenu;
    {$IFDEF SUIPACK_D5}
    TempObj : TObject;
    {$ENDIF}
begin
    nCount := SUIGetPropList(OldCtrl, PropList);
    try
        for i := 0 to nCount - 1 do
        begin
            PropInfo := PropList^[I];

            if PropInfo^.Name = 'Name' then
                continue;

            if PropInfo^.Name = 'Top' then
                continue;

            if (
                (PropInfo^.Name = 'Items') and
                (OldCtrl is TMenu)
            ) then
                continue;

            if not IsHasProperty(NewCtrl, PropInfo^.Name) then
                continue;

            if PropInfo^.Name = 'PopupMenu' then
            begin
                PopupMenu := GetObjectProp(OldCtrl, 'PopupMenu') as TPopupMenu;
                if PopupMenu <> nil then
                begin
                    if Copy(PopupMenu.Name, 1, 7) = 'suitemp' then
                    begin
                        SetObjectProp(NewCtrl, 'PopupMenu', Dsgn.GetComponent(Copy(PopupMenu.Name, 8, Length(PopupMenu.Name))));
                        Continue;
                    end;
                end;
            end;

            case PropInfo^.PropType^.Kind of

            tkInteger, tkChar, tkWChar, tkEnumeration :
            begin
                try
                    SetOrdProp(NewCtrl, PropInfo^.Name, GetOrdProp(OldCtrl, PropInfo^.Name));
                except
                end;
            end;

            tkFloat :
            begin
                try
                    SetFloatProp(NewCtrl, PropInfo^.Name, GetFloatProp(OldCtrl, PropInfo^.Name));
                except
                end;
            end;

            tkString :
            begin
                try
                    SetStrProp(NewCtrl, PropInfo^.Name, GetStrProp(OldCtrl, PropInfo^.Name));
                except
                end;
            end;

            tkSet :
            begin
                {$IFDEF SUIPACK_D6UP}
                try
                    SetSetProp(NewCtrl, PropInfo^.Name, GetSetProp(OldCtrl, PropInfo^.Name));
                except
                end;
                {$ENDIF}
            end;

            tkMethod :
            begin
                try
                    SetMethodProp(NewCtrl, PropInfo^.Name, GetMethodProp(OldCtrl, PropInfo^.Name));
                except
                end;
            end;

            tkClass :
            begin
                {$IFDEF SUIPACK_D6UP}
                try
                    SetObjectProp(NewCtrl, PropInfo^.Name, GetObjectProp(OldCtrl, PropInfo^.Name));
                except
                end;
                {$ENDIF}
                {$IFDEF SUIPACK_D5}
                try
                    TempObj := GetObjectProp(OldCtrl, PropInfo^.Name);
                    if TempObj is TStrings then
                        SetObjectProp(NewCtrl, PropInfo^.Name, TempObj);
                except
                end;
                {$ENDIF}
            end;

            else
            begin
                try
                    if PropInfo^.Name = 'Caption' then
                        SetStrProp(NewCtrl, PropInfo^.Name, GetStrProp(OldCtrl, PropInfo^.Name));
                except
                end;
            end;

            end; //case
        end;
    finally
        FreeMem(PropList);
    end;
end;

Procedure ConvertControls(var Ctrl : TControl; Cls : TControlClass; UIStyle : String; IncHeight : Integer; Dsgn : IsuiDesigner);
var
    NewCtrl : TControl;
    TempName : String;
    TempName2 : String;
    Form : TCustomForm;
begin
    try
        NewCtrl := Dsgn.CreateComponent(Cls, Ctrl.Parent, Ctrl.Left, Ctrl.Top + IncHeight, Ctrl.Width, Ctrl.Height) as TControl;
    except
        Form := GetParentForm(Ctrl);
        NewCtrl := Dsgn.CreateComponent(Cls, Form, Ctrl.Left, Ctrl.Top + IncHeight, Ctrl.Width, Ctrl.Height) as TControl;
        NewCtrl.Parent := Ctrl.Parent;
        NewCtrl.SetBounds(Ctrl.Left, Ctrl.Top, Ctrl.Width, Ctrl.Height);
    end;

    AssignProps(NewCtrl, Ctrl, Dsgn);
    if IsHasProperty(NewCtrl, 'UIStyle') then
        SetEnumProp(NewCtrl, 'UIStyle', UIStyle);
    TempName := Ctrl.Name;
    TempName2 := 'suitemp' + TempName;
    if Dsgn.GetComponent(TempName2) <> nil then
        TempName2 := TempName2 + '1';
    Ctrl.Name := TempName2;
    NewCtrl.Name := TempName;

    if NewCtrl is TsuiScrollBar then
        (NewCtrl as TsuiScrollBar).LargeChange := 2;
    if NewCtrl is TsuiTabSheet then
    begin
        (NewCtrl as TsuiTabSheet).PageIndex := (NewCtrl as TsuiTabSheet).PageControl.PageCount - 1;
    end;
    RemoveOldControl(Ctrl);
    Ctrl := NewCtrl;    
end;

type
    TMenuClass = class of TMenu;

Procedure ConvertMenus(Comp : TMenu; Cls : TMenuClass; UIStyle : String; Dsgn : IsuiDesigner);
var
    NewMenu : TMenu;
    TempName : String;
    TempName2 : String;
    i : Integer;
    MenuItem : TMenuItem;
begin
    NewMenu := Dsgn.CreateComponent(Cls, Comp.Owner, 0, 0, 0, 0) as TMenu;
    AssignProps(NewMenu, Comp, Dsgn);
    SetEnumProp(NewMenu, 'UIStyle', UIStyle);
    TempName := Comp.Name;
    TempName2 := 'suitemp' + TempName;
    if Dsgn.GetComponent(TempName2) <> nil then
        TempName2 := TempName2 + '1';
    Comp.Name := TempName2;
    NewMenu.Name := TempName;
    
    for i := 0 to Comp.Items.Count - 1 do
    begin
        MenuItem := Comp.Items[0];
        Comp.Items.Delete(0);
        NewMenu.Items.Add(MenuItem);
    end;

    RemoveOldControl(Comp);
end;

procedure ConvertToSUIPack(Form : TCustomForm; StrUIStyle: String; UIStyle : TsuiUIStyle);
var
    Dsgn : IsuiDesigner;
    i : Integer;
    Ctrl : TControl;
    Comp : TComponent;
    suiForm : TsuiForm;
    IncHeight : Integer;
    FormIncHeight : Integer;
    aDB: TComponent;
    aFld: string;
    bFld: string;
    cFld: string;    
begin
    Dsgn := Form.Designer as IsuiDesigner;

    suiForm := TsuiForm(Dsgn.CreateComponent(TsuiForm, Form, 0, 0, 0, 0));
    suiForm.UIStyle := UIStyle;
    suiForm.SendToBack();
    FormIncHeight := suiForm.TitleBarHeight;

    if Form is TForm then
        TForm(Form).Height := TForm(Form).Height + FormIncHeight;

    for i := 0 to Form.ComponentCount - 1 do
    begin // Pre-process menus
        Comp := Form.Components[i];
        if Comp is TPopupMenu then
            ConvertMenus(Comp as TPopupMenu, TsuiPopupMenu, StrUIStyle, Dsgn);
        if Comp is TMainMenu then
            ConvertMenus(Comp as TMainMenu, TsuiMainMenu, StrUIStyle, Dsgn);
    end;

    for i := 0 to Form.ComponentCount - 1 do
    begin
        if Form.Components[i] is TControl then
        begin
            IncHeight := FormIncHeight;

            Ctrl := Form.Components[i] as TControl;

            if IsHasProperty(Ctrl, 'DataSource') then
               aDB := GetObjectProp(Ctrl, 'DataSource') as TComponent;
            if IsHasProperty(Ctrl, 'DataField') then
               aFld := GetPropValue(Ctrl, 'DataField');
            if IsHasProperty(Ctrl, 'ListField') then
               bFld := GetPropValue(Ctrl, 'ListField');
            if IsHasProperty(Ctrl, 'KeyField') then
               cFld := GetPropValue(Ctrl, 'KeyField');

            if (
                (Ctrl <> suiForm) and
                (Ctrl.Parent = Form)
            ) then
                Ctrl.Parent := suiForm;

            if (
                (Ctrl.Parent <> suiForm) and
                (Ctrl.Parent <> nil)
            ) then
            begin
                if Copy(Ctrl.Parent.Name, 1, 7) = 'suitemp' then
                begin
                    Comp := Dsgn.GetComponent(Copy(Ctrl.Parent.Name, 8, Length(Ctrl.Parent.Name)));
                    if (Comp = nil) or (not (Comp is TWinControl)) then
                        continue;
                    Ctrl.Parent := Comp as TWinControl;
                end;
                IncHeight := 0;
            end;

            if Ctrl is TToolBar then
            begin
                (Ctrl as TToolBar).Top := 800;
                (Ctrl as TToolBar).Flat := true;
                continue;
            end;

            if Ctrl is TButton then
                ConvertControls(Ctrl, TsuiButton, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TCheckBox then
                ConvertControls(Ctrl, TsuiCheckBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TRadioButton then
                ConvertControls(Ctrl, TsuiRadioButton, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TProgressBar then
                ConvertControls(Ctrl, TsuiProgressBar, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TEdit then
                ConvertControls(Ctrl, TsuiEdit, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TMemo then
                ConvertControls(Ctrl, TsuiMemo, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TListBox then
                ConvertControls(Ctrl, TsuiListBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TComboBox then
                ConvertControls(Ctrl, TsuiComboBox, StrUIStyle, IncHeight, Dsgn)
            {$IFDEF SUIPACK_D6UP}
            else if Ctrl is TColorBox then
                ConvertControls(Ctrl, TsuiColorBox, StrUIStyle, IncHeight, Dsgn)
            {$ENDIF}
            else if Ctrl is TCheckListBox then
                ConvertControls(Ctrl, TsuiCheckListBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TGroupBox then
                ConvertControls(Ctrl, TsuiGroupBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TRadioGroup then
                ConvertControls(Ctrl, TsuiRadioGroup, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TListView then
                ConvertControls(Ctrl, TsuiListView, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TTreeView then
                ConvertControls(Ctrl, TsuiTreeView, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TTabControl then
                ConvertControls(Ctrl, TsuiTabControl, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TTabSheet then
                ConvertControls(Ctrl, TsuiTabSheet, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TPageControl then
                ConvertControls(Ctrl, TsuiPageControl, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TTrackBar then
                ConvertControls(Ctrl, TsuiTrackBar, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TScrollBar then
                ConvertControls(Ctrl, TsuiScrollBar, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TStringGrid then
                ConvertControls(Ctrl, TsuiStringGrid, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDrawGrid then
                ConvertControls(Ctrl, TsuiDrawGrid, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TStatusBar then
                ConvertControls(Ctrl, TsuiStatusBar, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TMaskEdit then
                ConvertControls(Ctrl, TsuiMaskEdit, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDriveComboBox then
                ConvertControls(Ctrl, TsuiDriveComboBox, StrUIStyle, IncHeight, Dsgn)
{$IFDEF DB}
            else if Ctrl is TDBEdit then
                ConvertControls(Ctrl, TsuiDBEdit, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBMemo then
                ConvertControls(Ctrl, TsuiDBMemo, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBImage then
                ConvertControls(Ctrl, TsuiDBIMage, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBListBox then
                ConvertControls(Ctrl, TsuiDBListBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBComboBox then
                ConvertControls(Ctrl, TsuiDBComboBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBCheckBox then
                ConvertControls(Ctrl, TsuiDBCheckBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBRadioGroup then
                ConvertControls(Ctrl, TsuiDBRadioGroup, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBNavigator then
                ConvertControls(Ctrl, TsuiDBNavigator, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBLookupListBox then
                ConvertControls(Ctrl, TsuiDBLookupListBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBLookupComboBox then
                ConvertControls(Ctrl, TsuiDBLookupComboBox, StrUIStyle, IncHeight, Dsgn)
            else if Ctrl is TDBGrid then
                ConvertControls(Ctrl, TsuiDBGrid, StrUIStyle, IncHeight, Dsgn)
{$ENDIF}
            else
            begin
                if IsHasProperty(Ctrl, 'Top') then
                    SetOrdProp(Ctrl, 'Top', GetOrdProp(Ctrl, 'Top') + IncHeight);
            end;

            if IsHasProperty(Ctrl, 'DataSource') then
                SetObjectProp(Ctrl, 'DataSource', aDB);
            if IsHasProperty(Ctrl, 'DataField') then
                SetPropValue(Ctrl, 'DataField', aFld);
            if IsHasProperty(Ctrl, 'ListField') then
                SetPropValue(Ctrl, 'ListField', bFld);
            if IsHasProperty(Ctrl, 'KeyField') then
                SetPropValue(Ctrl, 'KeyField', cFld);                                
        end
    end;

    RemoveOldControl(nil, true);
end;

Procedure UnConvertMenus(Comp : TMenu; Cls : TMenuClass; Dsgn : IsuiDesigner);
var
    NewMenu : TMenu;
    TempName : String;
    TempName2 : String;
    i : Integer;
    MenuItem : TMenuItem;
begin
    NewMenu := Dsgn.CreateComponent(Cls, Comp.Owner, 0, 0, 0, 0) as TMenu;
    AssignProps(NewMenu, Comp, Dsgn);
    TempName := Comp.Name;
    TempName2 := 'suitemp' + TempName;
    if Dsgn.GetComponent(TempName2) <> nil then
        TempName2 := TempName2 + '1';
    Comp.Name := TempName2;
    NewMenu.Name := TempName;
    
    for i := 0 to Comp.Items.Count - 1 do
    begin
        MenuItem := Comp.Items[0];
        Comp.Items.Delete(0);
        NewMenu.Items.Add(MenuItem);
        NewMenu.OwnerDraw := false;
    end;

    RemoveOldControl(Comp);
end;

Procedure UnConvertControls(var Ctrl : TControl; Cls : TControlClass; IncHeight : Integer; Dsgn : IsuiDesigner);
var
    NewCtrl : TControl;
    TempName : String;
    TempName2 : String;
    Form : TCustomForm;
begin
    try
        NewCtrl := Dsgn.CreateComponent(Cls, Ctrl.Parent, Ctrl.Left, Ctrl.Top - IncHeight, Ctrl.Width, Ctrl.Height) as TControl;
        if NewCtrl is TTabSheet then
        begin
            NewCtrl.Parent := Ctrl.Parent;
            (NewCtrl as TTabSheet).PageControl := Ctrl.Parent as TPageControl;
        end;
    except
        Form := GetParentForm(Ctrl);
        NewCtrl := Dsgn.CreateComponent(Cls, Form, Ctrl.Left, Ctrl.Top - IncHeight, Ctrl.Width, Ctrl.Height) as TControl;
        NewCtrl.Parent := Ctrl.Parent;
        NewCtrl.SetBounds(Ctrl.Left, Ctrl.Top, Ctrl.Width, Ctrl.Height);
    end;

    AssignProps(NewCtrl, Ctrl, Dsgn);
    TempName := Ctrl.Name;
    TempName2 := 'suitemp' + TempName;
    if Dsgn.GetComponent(TempName2) <> nil then
        TempName2 := TempName2 + '1';
    Ctrl.Name := TempName2;
    NewCtrl.Name := TempName;

    if NewCtrl is TTabSheet then
    begin
        (NewCtrl as TTabSheet).PageIndex := (NewCtrl as TTabSheet).PageControl.PageCount - 1;
    end;
    RemoveOldControl(Ctrl);
    Ctrl := NewCtrl;    
end;

procedure ConvertToVCL(Form : TCustomForm);
var
    Dsgn : IsuiDesigner;
    i : Integer;
    Ctrl : TControl;
    Comp : TComponent;
    suiForm : TsuiForm;
    FormIncHeight : Integer;
    IncHeight : Integer;
    aDB: TComponent;
    aFld: string;            
begin
    Dsgn := Form.Designer as IsuiDesigner;
    FormIncHeight := 0;
    suiForm := nil;

    g_SUIPackConverting := true;

    for i := 0 to Form.ComponentCount - 1 do
    begin // Pre-process menus and TsuiForm
        Comp := Form.Components[i];
        if Comp is TsuiPopupMenu then
            UnConvertMenus(Comp as TsuiPopupMenu, TPopupMenu, Dsgn);
        if Comp is TsuiMainMenu then
            UnConvertMenus(Comp as TsuiMainMenu, TMainMenu, Dsgn);
        if Comp is TsuiForm then
        begin
            suiForm := Comp as TsuiForm;
            FormIncHeight := suiForm.TitleBarHeight;
        end;
    end;

    g_SUIPackConverting := false;    

//    if Form is TForm then
//        TForm(Form).Height := TForm(Form).Height - FormIncHeight;

    for i := 0 to Form.ComponentCount - 1 do
    begin
        if Form.Components[i] is TControl then
        begin
            IncHeight := FormIncHeight;

            Ctrl := Form.Components[i] as TControl;

            if IsHasProperty(Ctrl, 'DataSource') then
               aDB := GetObjectProp(Ctrl, 'DataSource') as TComponent;
            if IsHasProperty(Ctrl, 'DataField') then
               aFld := GetPropValue(Ctrl, 'DataField');

            if suiForm <> nil then
            begin
                if (
                    (Ctrl <> suiForm) and
                    (Ctrl.Parent = suiForm)
                ) then
                    Ctrl.Parent := Form;

            end;

            if (
                (Ctrl.Parent <> suiForm) and
                (Ctrl.Parent <> Form) and
                (Ctrl.Parent <> nil)
            ) then
            begin
                if Copy(Ctrl.Parent.Name, 1, 7) = 'suitemp' then
                begin
                    Comp := Dsgn.GetComponent(Copy(Ctrl.Parent.Name, 8, Length(Ctrl.Parent.Name)));
                    if (Comp = nil) or (not (Comp is TWinControl)) then
                        continue;
                    Ctrl.Parent := Comp as TWinControl;
                end;
                IncHeight := 0;
            end;

            if Ctrl.ClassNameIs('TsuiButton') then
                UnConvertControls(Ctrl, TButton, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiCheckBox') then
                UnConvertControls(Ctrl, TCheckBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiRadioButton') then
                UnConvertControls(Ctrl, TRadioButton, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiProgressBar') then
                UnConvertControls(Ctrl, TProgressBar, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiEdit') then
                UnConvertControls(Ctrl, TEdit, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiMemo') then
                UnConvertControls(Ctrl, TMemo, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiListBox') then
                UnConvertControls(Ctrl, TListBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiComboBox') then
                UnConvertControls(Ctrl, TComboBox, IncHeight, Dsgn)
            {$IFDEF SUIPACK_D6UP}
            else if Ctrl.ClassNameIs('TsuiColorBox') then
                UnConvertControls(Ctrl, TColorBox, IncHeight, Dsgn)
            {$ENDIF}
            else if Ctrl.ClassNameIs('TsuiCheckListBox') then
                UnConvertControls(Ctrl, TCheckListBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiGroupBox') then
                UnConvertControls(Ctrl, TGroupBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiRadioGroup') then
                UnConvertControls(Ctrl, TRadioGroup, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiListView') then
                UnConvertControls(Ctrl, TListView, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiTreeView') then
                UnConvertControls(Ctrl, TTreeView, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiTabControl') then
                UnConvertControls(Ctrl, TTabControl, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiTabSheet') then
                UnConvertControls(Ctrl, TTabSheet, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiPageControl') then
                UnConvertControls(Ctrl, TPageControl, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiTrackBar') then
                UnConvertControls(Ctrl, TTrackBar, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiScrollBar') then
                UnConvertControls(Ctrl, TScrollBar, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiStringGrid') then
                UnConvertControls(Ctrl, TStringGrid, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDrawGrid') then
                UnConvertControls(Ctrl, TDrawGrid, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiStatusBar') then
                UnConvertControls(Ctrl, TStatusBar, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiMaskEdit') then
                UnConvertControls(Ctrl, TMaskEdit, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDriveComboBox') then
                UnConvertControls(Ctrl, TDriveComboBox, IncHeight, Dsgn)
{$IFDEF DB}
            else if Ctrl.ClassNameIs('TsuiDBEdit') then
                UnConvertControls(Ctrl, TDBEdit, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBMemo') then
                UnConvertControls(Ctrl, TDBMemo, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBImage') then
                UnConvertControls(Ctrl, TDBIMage, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBListBox') then
                UnConvertControls(Ctrl, TDBListBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBComboBox') then
                UnConvertControls(Ctrl, TDBComboBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBCheckBox') then
                UnConvertControls(Ctrl, TDBCheckBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBRadioGroup') then
                UnConvertControls(Ctrl, TDBRadioGroup, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBNavigator') then
                UnConvertControls(Ctrl, TDBNavigator, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBLookupListBox') then
                UnConvertControls(Ctrl, TDBLookupListBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBLookupComboBox') then
                UnConvertControls(Ctrl, TDBLookupComboBox, IncHeight, Dsgn)
            else if Ctrl.ClassNameIs('TsuiDBGrid') then
                UnConvertControls(Ctrl, TDBGrid, IncHeight, Dsgn)
{$ENDIF}
            else
            begin
                if IsHasProperty(Ctrl, 'Top') then
                    SetOrdProp(Ctrl, 'Top', GetOrdProp(Ctrl, 'Top') - IncHeight);
            end;

            if IsHasProperty(Ctrl, 'DataSource') then
                SetObjectProp(Ctrl, 'DataSource', aDB);
            if IsHasProperty(Ctrl, 'DataField') then
                SetPropValue(Ctrl, 'DataField', aFld);
        end
    end;

    if suiForm <> nil then
        RemoveOldControl(suiForm);

    RemoveOldControl(nil, true);
end;

{ TsuiPageControlEditor }

procedure TsuiPageControlEditor.Edit;
begin

end;

procedure TsuiPageControlEditor.ExecuteVerb(Index: Integer);
begin
    case Index of
    0 : PageControl_InsertPage(Component);
    1 : PageControl_RemovePage(Component);
    end;

    Designer.Modified();
end;

function TsuiPageControlEditor.GetVerb(Index: Integer): String;
begin
    case Index of
    0 : Result := 'New Page';
    1 : Result := 'Delete Page';
    end;
end;

function TsuiPageControlEditor.GetVerbCount: Integer;
begin
    Result := 2;
end;

procedure TsuiPageControlEditor.PrepareItem(Index: Integer;
{$IFDEF SUIPACK_D5}
    const AItem: TMenuItem);
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    const AItem: IMenuItem);
{$ENDIF}
begin
    inherited;
    if Index = 1 then
        AItem.Enabled := PageControl_CanRemove(Component);
end;

{ TsuiUnConvertor }

constructor TsuiUnConvertor.Create(AOwner: TComponent);
begin
    inherited;

    if not (AOwner is TCustomForm) then
        Exit;

    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
    begin
        MessageDlg('Sorry, can''t convert under Windows 98.', mtError, [mbOK], 0);
        SysUtils.Abort;
        Exit;
    end;

    if MessageDlg('Are you sure to convert all controls to the standard VCL?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        ConvertToVCL(TCustomForm(AOwner));

    SysUtils.Abort;
end;

{ TsuiFileThemeEditor }

procedure TsuiFileThemeEditor.Edit;
begin
    if Component is TsuiFileTheme then
    begin
        FileThemeEdit(Component as TsuiFileTheme);
        Designer.Modified();
    end;
end;

procedure TsuiFileThemeEditor.ExecuteVerb(Index: Integer);
begin
    case Index of
    0 : Edit;
    end;
end;

function TsuiFileThemeEditor.GetVerb(Index: Integer): String;
begin
    case Index of
    0 : Result := 'Load a theme file...';
    end;
end;

function TsuiFileThemeEditor.GetVerbCount: Integer;
begin
    Result := 1;
end;

{ TsuiThemeMgrCompListEditor }

procedure TsuiThemeMgrCompListEditor.Edit;
begin
    ThemeManagerEdit(GetComponent(0) as TsuiThemeManager);
    Designer.Modified();
end;

function TsuiThemeMgrCompListEditor.GetAttributes: TPropertyAttributes;
begin
    Result := [paDialog, paReadOnly{$IFDEF SMLPACK_D6UP}, paVCL{$ENDIF}];
end;

function TsuiThemeMgrCompListEditor.GetValue: string;
begin
    Result := 'Component List';
end;

{ TsuiTabSheetEditor }

procedure TsuiTabSheetEditor.Edit;
begin

end;

procedure TsuiTabSheetEditor.ExecuteVerb(Index: Integer);
begin
    case Index of
    0 : TabSheet_InsertPage(Component);
    1 : TabSheet_RemovePage(Component);
    end;

    Designer.Modified();
end;

function TsuiTabSheetEditor.GetVerb(Index: Integer): String;
begin
    case Index of
    0 : Result := 'New Page';
    1 : Result := 'Delete Page';
    end;
end;

function TsuiTabSheetEditor.GetVerbCount: Integer;
begin
    Result := 2;
end;

procedure TsuiTabSheetEditor.PrepareItem(Index: Integer;
{$IFDEF SUIPACK_D5}
    const AItem: TMenuItem);
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    const AItem: IMenuItem);
{$ENDIF}
begin
    inherited;
    if Index = 1 then
        AItem.Enabled := TabSheet_CanRemove(Component);
end;

{ TsuiDialogEditor }

procedure TsuiDialogEditor.Edit;
begin
    if Component is TsuiDialog then
        (Component as TsuiDialog).ShowModal();
end;

{ TsuiThemeManagerEditor }

procedure TsuiThemeManagerEditor.Edit;
begin
    if Component is TsuiThemeManager then
    begin
        ThemeManagerEdit(Component as TsuiThemeManager);
        Designer.Modified();
    end;
end;

procedure TsuiThemeManagerEditor.ExecuteVerb(Index: Integer);
begin
    case Index of
    0 : Edit;
    end;
end;

function TsuiThemeManagerEditor.GetVerb(Index: Integer): String;
begin
    case Index of
    0 : Result := 'Edit list...';
    end;
end;

function TsuiThemeManagerEditor.GetVerbCount: Integer;
begin
    Result := 1;
end;

{ TsuiConvertor }

constructor TsuiConvertor.Create(AOwner: TComponent);
var
    Form : TCustomForm;
    i : Integer;
begin
    inherited;

    if not (AOwner is TCustomForm) then
        Exit;

    if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
    begin
        MessageDlg('Sorry, can''t convert under Windows 98.', mtError, [mbOK], 0);
        SysUtils.Abort;
        Exit;
    end;

    Form := AOwner as TCustomForm;
    for i := 0 to Form.ControlCount - 1 do
    begin
        if Form.Controls[i] is TsuiForm then
        begin
            MessageDlg('Sorry, you have a TsuiForm already. Converting canceled.', mtError, [mbOK], 0);
            SysUtils.Abort;
            Exit;
        end;
    end;

    frmConv := TfrmConv.Create(nil);
    frmConv.cb_theme.ItemIndex := 0;
    if frmConv.ShowModal() = mrOK then
        ConvertToSUIPack(TCustomForm(AOwner), frmConv.cb_theme.Text, TsuiUIStyle(frmConv.cb_theme.ItemIndex + 1));
    frmConv.Free();
    SysUtils.Abort;
end;

{ TsuiThemeFileEditor }

procedure TsuiThemeFileEditor.Edit;
var
    OpenDialog: TOpenDialog;
begin
    OpenDialog := TOpenDialog.Create(Application);
    OpenDialog.Filter := 'SUIPack Theme File(*.sui)|*.sui';
    if OpenDialog.Execute() then
    begin
        TsuiFileTheme(GetComponent(0)).ThemeFile := OpenDialog.FileName;
        Modified();
    end;
    OpenDialog.Free();
end;

function TsuiThemeFileEditor.GetAttributes: TPropertyAttributes;
begin
    Result := [paDialog];
end;

function TsuiThemeFileEditor.GetValue: string;
begin
    Result := TsuiFileTheme(GetComponent(0)).ThemeFile;
end;

{ TsuiBuiltInThemeFileEditor }

procedure TsuiBuiltInThemeFileEditor.Edit;
var
    OpenDialog: TOpenDialog;
begin
    OpenDialog := TOpenDialog.Create(Application);
    OpenDialog.Filter := 'SUIPack Theme File(*.sui)|*.sui';
    if OpenDialog.Execute() then
    begin
        TsuiBuiltInFileTheme(GetComponent(0)).ThemeFile := OpenDialog.FileName;
        Modified();
    end;
    OpenDialog.Free();
end;

function TsuiBuiltInThemeFileEditor.GetAttributes: TPropertyAttributes;
begin
    Result := [paDialog, paReadOnly];
end;

function TsuiBuiltInThemeFileEditor.GetValue: string;
begin
    Result := TsuiBuiltInFileTheme(GetComponent(0)).ThemeFile;
end;

{ TsuiBuiltInFileThemeEditor }

procedure TsuiBuiltInFileThemeEditor.Edit;
begin
    if Component is TsuiFileTheme then
    begin
        BuiltInFileThemeEdit(Component as TsuiBuiltInFileTheme);
        Designer.Modified();
    end;
end;

end.
