; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CMiniCADView
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "MiniCAD.h"
LastPage=0

ClassCount=13
Class1=CMiniCADApp
Class2=CMiniCADDoc
Class3=CMiniCADView
Class4=CMainFrame

ResourceCount=56
Resource1=IDD_DIALOG1 (íÜçëåÍ (P.R.C.))
Resource2=IDD_DLG_COMPASS
Resource3=IDD_LAYER_ADMIN
Resource4=IDD_DLG_TEXT
Resource5=IDR_MENU_EDIT
Class5=CChildFrame
Class6=CAboutDlg
Resource6=IDD_DIG_ENTITYPROPERTY
Resource7=IDD_DIALOG1 (Chinese (P.R.C.))
Class7=CInsertBlockDlg
Resource8=IDR_TOOLBAR2
Class8=CDlgTextEdit
Resource9=IDD_ABOUTBOX
Class9=CInsertHoleLayerDlg
Resource10=IDR_MENU_PAPER
Class10=CDlg_PaperSetup
Resource11=IDR_MINICATYPE
Resource12=IDD_DLG_SECTION
Class11=CDlgSection
Resource13=IDR_TOOLBAR3
Class12=CDlgCompass
Resource14=IDR_TOOLBAR5
Resource15=IDR_TOOLBAR1
Class13=CDlgEntityProperty
Resource16=IDR_TOOLBAR4
Resource17=IDD_INSERTHOLELAYERDLG
Resource18=IDD_DIG_PAPERSETUP
Resource19=IDD_DIG_PAPERSETUP (Chinese (P.R.C.))
Resource20=IDR_MENU_EDIT (Chinese (P.R.C.))
Resource21=IDD_INSERTHOLELAYERDLG (Chinese (P.R.C.))
Resource22=IDD_DLG_TEXT (Chinese (P.R.C.))
Resource23=IDD_ABOUTBOX (Chinese (P.R.C.))
Resource24=IDD_DLG_SECTION (Chinese (P.R.C.))
Resource25=IDR_MAINFRAME (Chinese (P.R.C.))
Resource26=IDD_DIG_ENTITYPROPERTY (Chinese (P.R.C.))
Resource27=IDD_LAYER_ADMIN (Chinese (P.R.C.))
Resource28=IDD_INSERTBLOCKDLG (Chinese (P.R.C.))
Resource29=IDR_MINICATYPE (Chinese (P.R.C.))
Resource30=IDR_MENU_PAPER (Chinese (P.R.C.))
Resource31=IDR_TOOLBAR4 (Chinese (P.R.C.))
Resource32=IDR_TOOLBAR1 (Chinese (P.R.C.))
Resource33=IDR_TOOLBAR2 (Chinese (P.R.C.))
Resource34=IDR_TOOLBAR3 (Chinese (P.R.C.))
Resource35=IDD_DLG_COMPASS (Chinese (P.R.C.))
Resource36=IDD_INSERTBLOCKDLG
Resource37=IDR_MAINFRAME
Resource38=IDD_DLG_SECTION (íÜçëåÍ (P.R.C.))
Resource39=IDR_TOOLBAR3 (íÜçëåÍ (P.R.C.))
Resource40=IDR_TOOLBAR4 (íÜçëåÍ (P.R.C.))
Resource41=IDR_TOOLBAR5 (íÜçëåÍ (P.R.C.))
Resource42=IDR_TOOLBAR1 (íÜçëåÍ (P.R.C.))
Resource43=IDR_TOOLBAR2 (íÜçëåÍ (P.R.C.))
Resource44=IDR_MENU_EDIT (íÜçëåÍ (P.R.C.))
Resource45=IDR_MINICATYPE (íÜçëåÍ (P.R.C.))
Resource46=IDR_MENU_PAPER (íÜçëåÍ (P.R.C.))
Resource47=IDD_DLG_COMPASS (íÜçëåÍ (P.R.C.))
Resource48=IDD_DIG_ENTITYPROPERTY (íÜçëåÍ (P.R.C.))
Resource49=IDR_MAINFRAME (íÜçëåÍ (P.R.C.))
Resource50=IDD_ABOUTBOX (íÜçëåÍ (P.R.C.))
Resource51=IDD_LAYER_ADMIN (íÜçëåÍ (P.R.C.))
Resource52=IDD_INSERTBLOCKDLG (íÜçëåÍ (P.R.C.))
Resource53=IDD_DLG_TEXT (íÜçëåÍ (P.R.C.))
Resource54=IDD_INSERTHOLELAYERDLG (íÜçëåÍ (P.R.C.))
Resource55=IDD_DIG_PAPERSETUP (íÜçëåÍ (P.R.C.))
Resource56=IDD_DIALOG1

[CLS:CMiniCADApp]
Type=0
HeaderFile=MiniCAD.h
ImplementationFile=MiniCAD.cpp
Filter=N
BaseClass=CWinApp
VirtualFilter=AC
LastObject=ID_FILE_SAVE

[CLS:CMiniCADDoc]
Type=0
HeaderFile=MiniCADDoc.h
ImplementationFile=MiniCADDoc.cpp
Filter=N
BaseClass=CDocument
VirtualFilter=DC
LastObject=CMiniCADDoc

[CLS:CMiniCADView]
Type=0
HeaderFile=MiniCADView.h
ImplementationFile=MiniCADView.cpp
Filter=C
BaseClass=CView
VirtualFilter=VWC
LastObject=CMiniCADView


[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=T
LastObject=CMainFrame
BaseClass=CMDIFrameWnd
VirtualFilter=fWC


[CLS:CChildFrame]
Type=0
HeaderFile=ChildFrm.h
ImplementationFile=ChildFrm.cpp
Filter=M
LastObject=CChildFrame
BaseClass=CMDIChildWnd
VirtualFilter=mfWC


[CLS:CAboutDlg]
Type=0
HeaderFile=MiniCAD.cpp
ImplementationFile=MiniCAD.cpp
Filter=D
LastObject=CAboutDlg

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_APP_ABOUT
CommandCount=8

[TB:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
Command9=ID_PAN
Command10=ID_SELECT
Command11=ID_ZOOMIN
Command12=ID_ZOOMOUT
Command13=ID_SNAP
Command14=ID_RIGHTANGLECORRECT
Command15=ID_BUTTON32806
Command16=ID_APP_EXIT
CommandCount=16

[MNU:IDR_MINICATYPE]
Type=1
Class=CMiniCADView
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_OPEN2
Command4=ID_FILE_OPEN3
Command5=ID_FILE_OPEN4
Command6=ID_FILE_OPEN5
Command7=ID_FILE_CLOSE
Command8=ID_FILE_SAVE
Command9=ID_FILE_SAVE_AS
Command10=ID_MENU_Import
Command11=ID_MENU_Export
Command12=ID_MENU_PAPERSETUP
Command13=ID_FILE_PRINT
Command14=ID_FILE_PRINT_PREVIEW
Command15=ID_FILE_PRINT_SETUP
Command16=ID_FILE_MRU_FILE1
Command17=ID_APP_EXIT
Command18=ID_EDIT_UNDO
Command19=ID_EDIT_CUT
Command20=ID_EDIT_COPY
Command21=ID_EDIT_PASTE
Command22=ID_EDIT_CLEAR
Command23=ID_VIEW_TOOLBAR
Command24=ID_VIEW_STATUS_BAR
Command25=ID_INSERTHOLELAYER
Command26=ID_INSERTBLOCK
Command27=ID_POINT
Command28=ID_LINE
Command29=ID_POLYLINE
Command30=ID_RECTANGLE
Command31=ID_ARC
Command32=ID_CIRCLE
Command33=ID_SPLINE
Command34=ID_TEXT
Command35=ID_ENTITYPROPERTY
Command36=ID_SELECT
Command37=ID_EDIT_MOVE
Command38=ID_EDIT_ROTATE
Command39=ID_MODELSPACE
Command40=ID_PAPERSPACE
Command41=ID_IMPORTHOLE
Command42=ID_INSERTSECTIONLINE
Command43=ID_LABELCOORD
Command44=ID_COMPASS
Command45=ID_APP_ABOUT
CommandCount=45

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_TEXT
Command2=ID_CIRCLE
Command3=ID_EDIT_COPY
Command4=ID_SELECT
Command5=ID_PAN
Command6=ID_ARC
Command7=ID_INSERTBLOCK
Command8=ID_LINE
Command9=ID_EDIT_MOVE
Command10=ID_POLYLINE
Command11=ID_FILE_NEW
Command12=ID_FILE_OPEN
Command13=ID_POINT
Command14=ID_FILE_PRINT
Command15=ID_INSERTBLOCK
Command16=ID_EDIT_ROTATE
Command17=ID_SPLINE
Command18=ID_FILE_SAVE
Command19=ID_RECTANGLE
Command20=ID_EDIT_PASTE
Command21=ID_EDIT_UNDO
Command22=ID_EDIT_CLEAR
Command23=ID_EDIT_CUT
Command24=ID_NEXT_PANE
Command25=ID_PREV_PANE
Command26=ID_EDIT_COPY
Command27=ID_EDIT_PASTE
Command28=ID_INSERTSECTIONLINE
Command29=ID_EDIT_CUT
Command30=ID_EDIT_UNDO
CommandCount=30

[TB:IDR_TOOLBAR1]
Type=1
Class=?
Command1=ID_POINT
Command2=ID_LINE
Command3=ID_POLYLINE
Command4=ID_RECTANGLE
Command5=ID_ARC
Command6=ID_CIRCLE
Command7=ID_SPLINE
Command8=ID_INSERTBLOCK
Command9=ID_TEXT
CommandCount=9

[TB:IDR_TOOLBAR2]
Type=1
Class=?
Command1=ID_EDIT_MOVE
Command2=ID_EDIT_ROTATE
CommandCount=2

[TB:IDR_TOOLBAR3]
Type=1
Class=?
Command1=ID_LAYER_ADMIN
Command2=ID_MENU_PAPERSETUP
Command3=ID_BUTTON32828
CommandCount=3

[DLG:IDD_LAYER_ADMIN]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_LIST1,listbox,1352728833
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_CHK_LAYERON,button,1342242819

[DLG:IDD_INSERTBLOCKDLG]
Type=1
Class=CInsertBlockDlg
ControlCount=20
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_COMBO1,combobox,1344340227
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,button,1342177287
Control7=IDC_CHECK1,button,1342242819
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_EDIT2,edit,1350631552
Control11=IDC_EDIT3,edit,1350631552
Control12=IDC_STATIC,button,1342177287
Control13=IDC_CHECK2,button,1476460547
Control14=IDC_STATIC,static,1342308352
Control15=IDC_STATIC,static,1342308352
Control16=IDC_EDIT4,edit,1350631552
Control17=IDC_EDIT5,edit,1484849280
Control18=IDC_STATIC,button,1342177287
Control19=IDC_CHECK3,button,1476460547
Control20=IDC_STATIC,static,1342308352

[CLS:CInsertBlockDlg]
Type=0
HeaderFile=InsertBlockDlg.h
ImplementationFile=InsertBlockDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_CHECK1
VirtualFilter=dWC

[DLG:IDD_DLG_TEXT]
Type=1
Class=CDlgTextEdit
ControlCount=4
Control1=IDC_RICHEDIT1,RICHEDIT,1353781700
Control2=IDC_BUTTON1,button,1342242816
Control3=IDOK,button,1342242817
Control4=IDCANCEL,button,1342242816

[CLS:CDlgTextEdit]
Type=0
HeaderFile=DlgTextEdit.h
ImplementationFile=DlgTextEdit.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_RICHEDIT1
VirtualFilter=dWC

[DLG:IDD_INSERTHOLELAYERDLG]
Type=1
Class=CInsertHoleLayerDlg
ControlCount=8
Control1=IDOK,button,1342242816
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT2,edit,1350631552
Control7=IDC_STATIC,static,1342308352
Control8=IDC_EDIT3,edit,1350631552

[CLS:CInsertHoleLayerDlg]
Type=0
HeaderFile=InsertHoleLayerDlg.h
ImplementationFile=InsertHoleLayerDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_EDIT2
VirtualFilter=dWC

[DLG:IDD_DIG_PAPERSETUP]
Type=1
Class=CDlg_PaperSetup
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_RADIO1,button,1342177289
Control5=IDC_RADIO2,button,1342177289

[CLS:CDlg_PaperSetup]
Type=0
HeaderFile=Dlg_PaperSetup.h
ImplementationFile=Dlg_PaperSetup.cpp
BaseClass=CDialog
Filter=D
LastObject=CDlg_PaperSetup
VirtualFilter=dWC

[MNU:IDR_MENU_PAPER]
Type=1
Class=?
Command1=ID_MENUITEM32802
CommandCount=1

[DLG:IDD_DLG_SECTION]
Type=1
Class=CDlgSection
ControlCount=4
Control1=IDC_EDIT1,edit,1350631552
Control2=IDOK,button,1342242817
Control3=IDCANCEL,button,1342242816
Control4=IDC_STATIC,static,1342308352

[CLS:CDlgSection]
Type=0
HeaderFile=DlgSection.h
ImplementationFile=DlgSection.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_EDIT1
VirtualFilter=dWC

[DLG:IDD_DLG_COMPASS]
Type=1
Class=CDlgCompass
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_STATIC,static,1342308352

[CLS:CDlgCompass]
Type=0
HeaderFile=DlgCompass.h
ImplementationFile=DlgCompass.cpp
BaseClass=CDialog
Filter=D
LastObject=IDC_EDIT1
VirtualFilter=dWC

[MNU:IDR_MENU_EDIT]
Type=1
Class=?
Command1=ID_SPLINE_ADDPOINT
Command2=ID_SPLINE_CUTSHORT
Command3=ID_PROPERTYEDIT
CommandCount=3

[DLG:IDD_DIG_ENTITYPROPERTY]
Type=1
Class=CDlgEntityProperty
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_COMBO1,combobox,1344340003
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT1,edit,1350631552

[CLS:CDlgEntityProperty]
Type=0
HeaderFile=DlgEntityProperty.h
ImplementationFile=DlgEntityProperty.cpp
BaseClass=CDialog
Filter=D
LastObject=CDlgEntityProperty
VirtualFilter=dWC

[DLG:IDD_DIALOG1]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_RADIO1,button,1342308361
Control4=IDC_RADIO2,button,1342177289
Control5=IDC_RADIO3,button,1342308361
Control6=IDC_RADIO4,button,1342177289

[TB:IDR_TOOLBAR4]
Type=1
Class=?
Command1=ID_BUTTON32820
CommandCount=1

[MNU:IDR_MINICATYPE (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_OPEN2
Command4=ID_FILE_OPEN3
Command5=ID_FILE_OPEN4
Command6=ID_FILE_OPEN5
Command7=ID_FILE_CLOSE
Command8=ID_FILE_SAVE
Command9=ID_FILE_SAVE_AS
Command10=ID_MENU_Import
Command11=ID_MENU_Export
Command12=ID_MENU_PAPERSETUP
Command13=ID_FILE_PRINT
Command14=ID_FILE_PRINT_PREVIEW
Command15=ID_FILE_PRINT_SETUP
Command16=ID_FILE_MRU_FILE1
Command17=ID_APP_EXIT
Command18=ID_EDIT_UNDO
Command19=ID_EDIT_CUT
Command20=ID_EDIT_COPY
Command21=ID_EDIT_PASTE
Command22=ID_EDIT_CLEAR
Command23=ID_VIEW_TOOLBAR
Command24=ID_VIEW_STATUS_BAR
Command25=ID_INSERTHOLELAYER
Command26=ID_POINT
Command27=ID_LINE
Command28=ID_POLYLINE
Command29=ID_RECTANGLE
Command30=ID_ARC
Command31=ID_CIRCLE
Command32=ID_SPLINE
Command33=ID_ENTITYPROPERTY
Command34=ID_SELECT
Command35=ID_EDIT_MOVE
Command36=ID_EDIT_ROTATE
Command37=ID_MODELSPACE
Command38=ID_PAPERSPACE
Command39=ID_IMPORTHOLE
Command40=ID_INSERTBLOCK
Command41=ID_INSERTSECTIONLINE
Command42=ID_LABELCOORD
Command43=ID_COMPASS
Command44=ID_APP_ABOUT
CommandCount=44

[DLG:IDD_ABOUTBOX (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_DIALOG1 (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=2
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816

[DLG:IDD_DIG_ENTITYPROPERTY (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_COMBO1,combobox,1344340003
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT1,edit,1350631552

[DLG:IDD_DIG_PAPERSETUP (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_RADIO1,button,1342177289
Control5=IDC_RADIO2,button,1342177289

[DLG:IDD_LAYER_ADMIN (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_LIST1,listbox,1352728833
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_CHK_LAYERON,button,1342242819

[DLG:IDD_INSERTHOLELAYERDLG (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=8
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT2,edit,1350631552
Control7=IDC_STATIC,static,1342308352
Control8=IDC_EDIT3,edit,1350631552

[DLG:IDD_DLG_TEXT (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_BUTTON1,button,1342242816
Control4=IDC_RICHEDIT1,RICHEDIT,1353781700

[DLG:IDD_DLG_SECTION (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_STATIC,static,1342308352

[DLG:IDD_DLG_COMPASS (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_STATIC,static,1342308352

[MNU:IDR_MENU_PAPER (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_MENUITEM32802
CommandCount=1

[MNU:IDR_MENU_EDIT (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_SPLINE_ADDPOINT
Command2=ID_SPLINE_CUTSHORT
CommandCount=2

[MNU:IDR_MAINFRAME (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_APP_ABOUT
CommandCount=8

[TB:IDR_MAINFRAME (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
Command9=ID_PAN
Command10=ID_SELECT
Command11=ID_ZOOMIN
Command12=ID_ZOOMOUT
Command13=ID_SNAP
Command14=ID_RIGHTANGLECORRECT
Command15=ID_BUTTON32806
Command16=ID_APP_EXIT
CommandCount=16

[TB:IDR_TOOLBAR1 (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_POINT
Command2=ID_LINE
Command3=ID_POLYLINE
Command4=ID_RECTANGLE
Command5=ID_ARC
Command6=ID_CIRCLE
Command7=ID_SPLINE
Command8=ID_INSERTBLOCK
CommandCount=8

[TB:IDR_TOOLBAR2 (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_EDIT_MOVE
Command2=ID_EDIT_ROTATE
CommandCount=2

[TB:IDR_TOOLBAR3 (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_LAYER_ADMIN
Command2=ID_MENU_PAPERSETUP
Command3=ID_BUTTON32828
CommandCount=3

[TB:IDR_TOOLBAR4 (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_BUTTON32820
CommandCount=1

[ACL:IDR_MAINFRAME (Chinese (P.R.C.))]
Type=1
Class=?
Command1=ID_EDIT_COPY
Command2=ID_FILE_NEW
Command3=ID_FILE_OPEN
Command4=ID_FILE_PRINT
Command5=ID_INSERTBLOCK
Command6=ID_FILE_SAVE
Command7=ID_EDIT_PASTE
Command8=ID_EDIT_UNDO
Command9=ID_EDIT_CLEAR
Command10=ID_EDIT_CUT
Command11=ID_NEXT_PANE
Command12=ID_PREV_PANE
Command13=ID_EDIT_COPY
Command14=ID_EDIT_PASTE
Command15=ID_INSERTSECTIONLINE
Command16=ID_EDIT_CUT
Command17=ID_EDIT_UNDO
CommandCount=17

[DLG:IDD_INSERTBLOCKDLG (Chinese (P.R.C.))]
Type=1
Class=?
ControlCount=20
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_COMBO1,combobox,1344340227
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,button,1342177287
Control7=IDC_CHECK1,button,1342242819
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_EDIT2,edit,1350631552
Control11=IDC_EDIT3,edit,1350631552
Control12=IDC_STATIC,button,1342177287
Control13=IDC_CHECK2,button,1476460547
Control14=IDC_STATIC,static,1342308352
Control15=IDC_STATIC,static,1342308352
Control16=IDC_EDIT4,edit,1350631552
Control17=IDC_EDIT5,edit,1484849280
Control18=IDC_STATIC,button,1342177287
Control19=IDC_CHECK3,button,1476460547
Control20=IDC_STATIC,static,1342308352

[TB:IDR_TOOLBAR5]
Type=1
Class=?
Command1=ID_BUTTON32830
CommandCount=1

[TB:IDR_MAINFRAME (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
Command9=ID_PAN
Command10=ID_SELECT
Command11=ID_ZOOMIN
Command12=ID_ZOOMOUT
Command13=ID_SNAP
Command14=ID_RIGHTANGLECORRECT
Command15=ID_BUTTON32806
Command16=ID_APP_EXIT
CommandCount=16

[TB:IDR_TOOLBAR1 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_POINT
Command2=ID_LINE
Command3=ID_POLYLINE
Command4=ID_RECTANGLE
Command5=ID_ARC
Command6=ID_CIRCLE
Command7=ID_SPLINE
Command8=ID_INSERTBLOCK
CommandCount=8

[TB:IDR_TOOLBAR2 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_EDIT_MOVE
Command2=ID_EDIT_ROTATE
CommandCount=2

[TB:IDR_TOOLBAR3 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_LAYER_ADMIN
Command2=ID_MENU_PAPERSETUP
Command3=ID_BUTTON32828
CommandCount=3

[TB:IDR_TOOLBAR4 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_BUTTON32820
CommandCount=1

[TB:IDR_TOOLBAR5 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_BUTTON32830
CommandCount=1

[MNU:IDR_MAINFRAME (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_APP_ABOUT
CommandCount=8

[MNU:IDR_MINICATYPE (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_OPEN2
Command4=ID_FILE_OPEN3
Command5=ID_FILE_OPEN4
Command6=ID_FILE_OPEN5
Command7=ID_FILE_CLOSE
Command8=ID_FILE_SAVE
Command9=ID_FILE_SAVE_AS
Command10=ID_MENU_Import
Command11=ID_MENU_Export
Command12=ID_MENU_PAPERSETUP
Command13=ID_FILE_PRINT
Command14=ID_FILE_PRINT_PREVIEW
Command15=ID_FILE_PRINT_SETUP
Command16=ID_FILE_MRU_FILE1
Command17=ID_APP_EXIT
Command18=ID_EDIT_UNDO
Command19=ID_EDIT_CUT
Command20=ID_EDIT_COPY
Command21=ID_EDIT_PASTE
Command22=ID_EDIT_CLEAR
Command23=ID_VIEW_TOOLBAR
Command24=ID_VIEW_STATUS_BAR
Command25=ID_INSERTHOLELAYER
Command26=ID_POINT
Command27=ID_LINE
Command28=ID_POLYLINE
Command29=ID_RECTANGLE
Command30=ID_ARC
Command31=ID_CIRCLE
Command32=ID_SPLINE
Command33=ID_ENTITYPROPERTY
Command34=ID_SELECT
Command35=ID_EDIT_MOVE
Command36=ID_EDIT_ROTATE
Command37=ID_MODELSPACE
Command38=ID_PAPERSPACE
Command39=ID_IMPORTHOLE
Command40=ID_INSERTBLOCK
Command41=ID_INSERTSECTIONLINE
Command42=ID_LABELCOORD
Command43=ID_COMPASS
Command44=ID_APP_ABOUT
CommandCount=44

[MNU:IDR_MENU_PAPER (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_MENUITEM32802
CommandCount=1

[MNU:IDR_MENU_EDIT (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_SPLINE_ADDPOINT
Command2=ID_SPLINE_CUTSHORT
CommandCount=2

[ACL:IDR_MAINFRAME (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
Command1=ID_EDIT_COPY
Command2=ID_SELECT
Command3=ID_PAN
Command4=ID_EDIT_MOVE
Command5=ID_FILE_NEW
Command6=ID_FILE_OPEN
Command7=ID_FILE_PRINT
Command8=ID_INSERTBLOCK
Command9=ID_EDIT_ROTATE
Command10=ID_FILE_SAVE
Command11=ID_EDIT_PASTE
Command12=ID_EDIT_UNDO
Command13=ID_EDIT_CLEAR
Command14=ID_EDIT_CUT
Command15=ID_NEXT_PANE
Command16=ID_PREV_PANE
Command17=ID_EDIT_COPY
Command18=ID_EDIT_PASTE
Command19=ID_INSERTSECTIONLINE
Command20=ID_EDIT_CUT
Command21=ID_EDIT_UNDO
CommandCount=21

[DLG:IDD_ABOUTBOX (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_LAYER_ADMIN (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_LIST1,listbox,1352728833
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_CHK_LAYERON,button,1342242819

[DLG:IDD_INSERTBLOCKDLG (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=20
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_COMBO1,combobox,1344340227
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,button,1342177287
Control7=IDC_CHECK1,button,1342242819
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352
Control10=IDC_EDIT2,edit,1350631552
Control11=IDC_EDIT3,edit,1350631552
Control12=IDC_STATIC,button,1342177287
Control13=IDC_CHECK2,button,1476460547
Control14=IDC_STATIC,static,1342308352
Control15=IDC_STATIC,static,1342308352
Control16=IDC_EDIT4,edit,1350631552
Control17=IDC_EDIT5,edit,1484849280
Control18=IDC_STATIC,button,1342177287
Control19=IDC_CHECK3,button,1476460547
Control20=IDC_STATIC,static,1342308352

[DLG:IDD_DLG_TEXT (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_BUTTON1,button,1342242816
Control4=IDC_RICHEDIT1,RICHEDIT,1353781700

[DLG:IDD_INSERTHOLELAYERDLG (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=8
Control1=IDOK,button,1342242816
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_EDIT1,edit,1350631552
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT2,edit,1350631552
Control7=IDC_STATIC,static,1342308352
Control8=IDC_EDIT3,edit,1350631552

[DLG:IDD_DIG_PAPERSETUP (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=5
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_RADIO1,button,1342177289
Control5=IDC_RADIO2,button,1342177289

[DLG:IDD_DLG_SECTION (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_STATIC,static,1342308352

[DLG:IDD_DLG_COMPASS (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_EDIT1,edit,1350631552
Control4=IDC_STATIC,static,1342308352

[DLG:IDD_DIG_ENTITYPROPERTY (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_COMBO1,combobox,1344340003
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_EDIT1,edit,1350631552

[DLG:IDD_DIALOG1 (íÜçëåÍ (P.R.C.))]
Type=1
Class=?
ControlCount=6
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_RADIO1,button,1342308361
Control4=IDC_RADIO2,button,1342177289
Control5=IDC_RADIO3,button,1342308361
Control6=IDC_RADIO4,button,1342177289

