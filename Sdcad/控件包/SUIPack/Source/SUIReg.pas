////////////////////////////////////////////////////////////////////////////////
//
//
//  FileName    :   SUIReg.pas
//  Creator     :   Shen Min
//  Date        :   2002-07-27
//  Comment     :
//
//  Copyright (c) 2002-2003 Sunisoft
//  http://www.sunisoft.com
//  Email: support@sunisoft.com
//
////////////////////////////////////////////////////////////////////////////////

unit SUIReg;

interface

{$I SUIPack.inc}

uses Classes,
{$IFDEF SUIPACK_D5}
    DsgnIntf;
{$ENDIF}
{$IFDEF SUIPACK_D6UP}
    DesignIntf, DesignEditors, DesignMenus;
{$ENDIF}

    procedure Register;

implementation

uses SUIMgr, SUIDsgn, SUISkinForm, SUISkinControl, SUIButton, SUIURLLabel,
     SUIImagePanel, SUITitleBar, SUIForm, SUIMainMenu, SUIProgressBar,
     SUIPopupMenu, SUIEdit, SUIComboBox, SUIColorBox, SUIFontComboBox,
     SUIGroupBox, SUIRadioGroup, SUITrackBar, SUIScrollBar, SUIMemo, SUIGrid,
     SUIListBox, SUICheckListBox, SUIListView, SUITreeView, SUIToolBar,
     SUISideChannel, SUITabControl, SUIPageControl, SUIDlg, SUIStatusBar
     {$IFDEF DB}, SUIDBCtrls{$ENDIF};

procedure Register;
begin
    RegisterClass(TsuiTabSheet);
    RegisterComponentEditor(TsuiPageControl, TsuiPageControlEditor);
    RegisterComponentEditor(TsuiTabSheet, TsuiTabSheetEditor);
    RegisterComponentEditor(TsuiDialog, TsuiDialogEditor);
    RegisterComponentEditor(TsuiThemeManager, TsuiThemeManagerEditor);
    RegisterComponentEditor(TsuiFileTheme, TsuiFileThemeEditor);
    RegisterPropertyEditor(TypeInfo(TsuiThemeMgrCompList), nil, '', TsuiThemeMgrCompListEditor);
    RegisterPropertyEditor(TypeInfo(String), TsuiFileTheme, 'ThemeFile', TsuiThemeFileEditor);
    RegisterPropertyEditor(TypeInfo(String), TsuiBuiltInFileTheme, 'ThemeFile', TsuiBuiltInThemeFileEditor);    

    RegisterComponents(
        'SUIPack',
        [
            TsuiSkinForm,
            TsuiSkinControl,
            TsuiForm,
            TsuiMDIForm,
            TsuiMSNPopForm,
            TsuiMainMenu,
            TsuiPopupMenu,
            TsuiSideChannel,
            TsuiTitleBar,
            TsuiPanel,
            TsuiImagePanel,
            TsuiButton,
            TsuiImageButton,
            TsuiArrowButton,
            TsuiCheckBox,
            TsuiRadioButton,
            TsuiProgressBar,
            TsuiURLLabel,
            TsuiEdit,
            TsuiMaskEdit,
            TsuiNumberEdit,
            TsuiSpinEdit,
            TsuiMemo,
            TsuiListBox,
            TsuiDirectoryListBox,
            TsuiFileListBox,
            TsuiComboBox,
            TsuiColorBox,
            TsuiFontComboBox,
            TsuiFontSizeComboBox,
            TsuiDriveComboBox,
            TsuiFilterComboBox,
            TsuiCheckListBox,
            TsuiGroupBox,
            TsuiRadioGroup,
            TsuiCheckGroup,
            TsuiListView,
            TsuiTreeView,
            TsuiStatusBar,
            TsuiToolBar,
            TsuiTabControl,
            TsuiPageControl,
            TsuiTrackBar,
            TsuiScrollBar,
            TsuiStringGrid,
            TsuiDrawGrid
        ]
    );
{$IFDEF DB}
    RegisterComponents(
        'SUIPack DB',
        [
            TsuiDBNavigator,
            TsuiDBEdit,
            TsuiDBMemo,
            TsuiDBImage,
            TsuiDBListBox,
            TsuiDBComboBox,
            TsuiDBCheckBox,
            TsuiDBRadioGroup,
            TsuiDBLookupListBox,
            TsuiDBLookupComboBox,
            TsuiDBGrid
        ]
    );
{$ENDIF}
    RegisterComponents(
        'SUIPack Dialog',
        [
            TsuiMessageDialog,
            TsuiPasswordDialog,
            TsuiInputDialog
        ]
    );

    RegisterComponents(
        'SUIPack Utils',
        [
            TsuiConvertor,
            TsuiUnConvertor,
            TsuiThemeManager,
            TsuiFileTheme,
            TsuiBuiltInFileTheme
        ]
    );
end;

end.
