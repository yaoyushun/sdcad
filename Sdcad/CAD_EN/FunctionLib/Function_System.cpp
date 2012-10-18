#include "stdafx.h"
#include "Function_System.h"

int GetAppDir(char* curAppDir)
{
	char szBuffer[255];
    ::GetModuleFileName(NULL, szBuffer, sizeof(szBuffer));
	CString tmpStr=szBuffer;
	int size=tmpStr.ReverseFind('\\')+1;
	memcpy(curAppDir,szBuffer,size);
	curAppDir[size]='\0';
	//strcpy(curAppDir,"E:\\hyg_WorkSpace\\Project_Explore\\ProjectCAD\\");
	return 1;
}
