#include "stdafx.h"
#include "LandProject_EN.h"

char CLandProject_EN::GetSpecialLegendChar(char* legendName)
{
	char  SpecialLegendChar[] = {'f','x','z','c','l'};
	int legendCharIndex = -1;	

	if (strcmp(legendName,"·ÛÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"·ÛÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"·ÛÉ°¼ÐÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"·ÛÉ°¼Ð·ÛÍÁ")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"Ï¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"ÖÐÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"ÖÐÏ¸É°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"ÖÐ´ÖÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"´ÖÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"ÀùÉ°")==0)
	{
		strcpy(pHatch->m_Name,"É°");
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"·ÛÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"Ï¸É°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"ÖÐÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"´ÖÉ°ÑÒ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÑÒ");
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"º¬Àù·ÛÉ°ÑÒ")==0)
	{
		legendCharIndex = 0;	
	}
	/*else if (strcmp(legendName,"·ÛÉ°¼Ð·ÛÍÁ")==0)
	{
		strcpy(pHatch->m_Name,"É°ÖÊ·ÛÍÁ");
		legendCharIndex = 0;	
	}*/
	else if (strcmp(legendName,"º¬ÀùÉ°·ÛÖÊÕ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬ÀùÉ°Õ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬ÀùÉ°ÓÙÄàÖÊ·ÛÖÊÕ³ÍÁ")==0)
	{
		legendCharIndex = 4;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁ·ÛÉ³")==0)
	{
		legendCharIndex = 0;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÏ¸É³")==0)
	{
		legendCharIndex = 1;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÖÐÉ³")==0)
	{
		legendCharIndex = 2;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁ´ÖÉ³")==0)
	{
		legendCharIndex = 3;	
	}
	else if (strcmp(legendName,"º¬Õ³ÐÔÍÁÀùÉ³")==0)
	{
		legendCharIndex = 4;	
	}
	
	if (legendCharIndex > -1)
		return SpecialLegendChar[legendCharIndex];
	else
		return SpecialLegendChar[' '];
}