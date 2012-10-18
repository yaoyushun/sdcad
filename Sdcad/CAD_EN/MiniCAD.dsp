# Microsoft Developer Studio Project File - Name="MiniCAD" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=MiniCAD - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "MiniCAD.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MiniCAD.mak" CFG="MiniCAD - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MiniCAD - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "MiniCAD - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MiniCAD - Win32 Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /FR /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x804 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x804 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386 /out:"E:\Project_CN\suzhouProject\sdcad\ProjectCAD\MiniCAD_EN.exe"

!ELSEIF  "$(CFG)" == "MiniCAD - Win32 Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x804 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x804 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "MiniCAD - Win32 Release"
# Name "MiniCAD - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "FunctionLib_Cpp"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=.\FunctionLib\Function_Graphics.cpp
# End Source File
# Begin Source File

SOURCE=.\FunctionLib\Function_System.cpp
# End Source File
# Begin Source File

SOURCE=.\FunctionLib\Functoin_String.cpp
# End Source File
# End Group
# Begin Group "Project_Cpp"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=.\Project\CompressionCurve.Cpp
# End Source File
# Begin Source File

SOURCE=.\Project\CrossBoardIniFile.Cpp
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile2.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile3.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile4.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\LayoutIniFile.Cpp
# End Source File
# Begin Source File

SOURCE=.\Project\Project_LegendDisplay.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\ProjectIniFile.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\StaticIniFile.cpp
# End Source File
# Begin Source File

SOURCE=.\Project\StaticIniFile2.cpp
# End Source File
# End Group
# Begin Group "AutoCAD_Cpp"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=.\AutoCAD\ADEntities.cpp
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\ADGraphics.cpp
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\ADLayerGroup.cpp
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\Display.cpp
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\DxfFile.cpp
# End Source File
# End Group
# Begin Group "DrawTool_Cpp"

# PROP Default_Filter ".cpp"
# Begin Source File

SOURCE=.\DrawTool\ArcTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\CircleTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\DrawTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\InsertTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\LabelCoordTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\LineTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\MoveTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\PanTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\pointTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\PolyLineTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\RectTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\RotateTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SectionLineTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SelectTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\Spline_AddPoint_Tool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SplineTool.cpp
# End Source File
# Begin Source File

SOURCE=.\DrawTool\TextTool.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=.\ChildFrm.cpp
# End Source File
# Begin Source File

SOURCE=.\Dlg_PaperSetup.cpp
# End Source File
# Begin Source File

SOURCE=.\DlgCompass.cpp
# End Source File
# Begin Source File

SOURCE=.\DlgEntityProperty.cpp
# End Source File
# Begin Source File

SOURCE=.\DlgLayerAdmin.cpp
# End Source File
# Begin Source File

SOURCE=.\DlgSection.cpp
# End Source File
# Begin Source File

SOURCE=.\DlgTextEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\InsertBlockDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\InsertHoleLayerDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\LineCombo.cpp
# End Source File
# Begin Source File

SOURCE=.\MainFrm.cpp
# End Source File
# Begin Source File

SOURCE=.\MiniCAD.cpp
# End Source File
# Begin Source File

SOURCE=.\MiniCAD.rc
# End Source File
# Begin Source File

SOURCE=.\MiniCADDoc.cpp
# End Source File
# Begin Source File

SOURCE=.\MiniCADView.cpp
# End Source File
# Begin Source File

SOURCE=.\MyRichEdit.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Group "FunctionLib_H"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=.\FunctionLib\Function_Graphics.h
# End Source File
# Begin Source File

SOURCE=.\FunctionLib\Function_String.h
# End Source File
# Begin Source File

SOURCE=.\FunctionLib\Function_System.h
# End Source File
# End Group
# Begin Group "Project_H"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=.\Project\CompressionCurve.h
# End Source File
# Begin Source File

SOURCE=.\Project\CrossBoardIniFile.h
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile.h
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile2.h
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile3.h
# End Source File
# Begin Source File

SOURCE=.\Project\HistogramIniFile4.h
# End Source File
# Begin Source File

SOURCE=.\Project\LayoutIniFile.h
# End Source File
# Begin Source File

SOURCE=.\Project\Project_LegendDisplay.h
# End Source File
# Begin Source File

SOURCE=.\Project\ProjectIniFile.h
# End Source File
# Begin Source File

SOURCE=.\Project\ProjectLayer.h
# End Source File
# Begin Source File

SOURCE=.\Project\StaticIniFile.h
# End Source File
# Begin Source File

SOURCE=.\Project\StaticIniFile2.h
# End Source File
# End Group
# Begin Group "AutoCAD_H"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=.\AutoCAD\ADEntities.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\ADGraphics.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\ADLayerGroup.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\ADTool_Param.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\Display.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\DxfFile.h
# End Source File
# Begin Source File

SOURCE=.\AutoCAD\Spline.h
# End Source File
# End Group
# Begin Group "DrawTool_H"

# PROP Default_Filter ".h"
# Begin Source File

SOURCE=.\DrawTool\ArcTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\CircleTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\DrawTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\InsertTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\LabelCoordTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\LineTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\MoveTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\PanTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\pointTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\PolyLineTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\RectTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\RotateTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SectionLineTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SelectTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\Spline_AddPoint_Tool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\SplineTool.h
# End Source File
# Begin Source File

SOURCE=.\DrawTool\TextTool.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\ChildFrm.h
# End Source File
# Begin Source File

SOURCE=.\Dlg_PaperSetup.h
# End Source File
# Begin Source File

SOURCE=.\DlgCompass.h
# End Source File
# Begin Source File

SOURCE=.\DlgEntityProperty.h
# End Source File
# Begin Source File

SOURCE=.\DlgLayerAdmin.h
# End Source File
# Begin Source File

SOURCE=.\DlgSection.h
# End Source File
# Begin Source File

SOURCE=.\DlgTextEdit.h
# End Source File
# Begin Source File

SOURCE=.\InsertBlockDlg.h
# End Source File
# Begin Source File

SOURCE=.\InsertHoleLayerDlg.h
# End Source File
# Begin Source File

SOURCE=.\LineCombo.h
# End Source File
# Begin Source File

SOURCE=.\MainFrm.h
# End Source File
# Begin Source File

SOURCE=.\MiniCAD.h
# End Source File
# Begin Source File

SOURCE=.\MiniCADDoc.h
# End Source File
# Begin Source File

SOURCE=.\MiniCADView.h
# End Source File
# Begin Source File

SOURCE=.\MyRichEdit.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\bitmap1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap2.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap3.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap4.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap5.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap6.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00001.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00002.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bmp00003.bmp
# End Source File
# Begin Source File

SOURCE=.\res\cur00001.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00002.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00003.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00004.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00005.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00006.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00007.cur
# End Source File
# Begin Source File

SOURCE=.\res\cur00008.cur
# End Source File
# Begin Source File

SOURCE=.\res\cursor1.cur
# End Source File
# Begin Source File

SOURCE=.\res\cursor2.cur
# End Source File
# Begin Source File

SOURCE=.\res\cursor3.cur
# End Source File
# Begin Source File

SOURCE=.\res\icon1.ico
# End Source File
# Begin Source File

SOURCE=.\res\MiniCAD.ico
# End Source File
# Begin Source File

SOURCE=.\res\MiniCAD.rc2
# End Source File
# Begin Source File

SOURCE=.\res\MiniCADDoc.ico
# End Source File
# Begin Source File

SOURCE=.\res\pandown2.cur
# End Source File
# Begin Source File

SOURCE=.\res\pointer.cur
# End Source File
# Begin Source File

SOURCE=.\res\pointer2.cur
# End Source File
# Begin Source File

SOURCE=.\res\rotate_4.cur
# End Source File
# Begin Source File

SOURCE=.\res\Toolbar.bmp
# End Source File
# Begin Source File

SOURCE=.\res\toolbar1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\toolbar2.bmp
# End Source File
# Begin Source File

SOURCE=.\res\toolbar3.bmp
# End Source File
# Begin Source File

SOURCE=.\res\toolbar4.bmp
# End Source File
# Begin Source File

SOURCE=.\res\toolbar5.bmp
# End Source File
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
