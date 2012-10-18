#include "stdafx.h"
#include "Function_String.h"

int GetCharCount(const char* str,char ch)
{
	int length = strlen(str);
	int result = 0;
	for (int i=0;i<length;i++)
	{
		if (str[i]==ch)
			result++;
	}
	return result;
}

long Change(const char* str)
{
	long ll=0;
	for(int i=0;i<strlen(str);i++)
	{
	  ll=ll*16;
	  if((str[i]<='9') && (str[i]>='0'))  ll+=str[i]-'0';
	  else if((str[i]<='F') && (str[i]>='A'))  ll+=str[i]-'A'+10;
	  else if((str[i]<='f') && (str[i]>='a'))  ll+=str[i]-'a'+10;
	  else return -1;
	}
	return ll;
}

/*
ClegendTable::HexToBit(char* strHex,BYTE* strBit,int bitCount)
{
	int i,j;
	j=0;
	for(i=0;i<bitCount*bitCount/8;i++)
	{
		strBit[i]=255;
		if(strHex[j]>47 && strHex[j]<58)
		strBit[i]=strBit[i]&(BYTE)((strHex[j]-48)*pow(2,4)+15);
		if(strHex[j]>64 && strHex[j]<71)
		strBit[i]=strBit[i]&(BYTE)((strHex[j]-55)*pow(2,4)+15);
		if(strHex[j]>96 && strHex[j]<103)
		strBit[i]=strBit[i]&(BYTE)((strHex[j]-87)*pow(2,4)+15);
		j++;
		if(strHex[j]>47 && strHex[j]<58)
		strBit[i]=strBit[i]&(BYTE)(15*pow(2,4)+strHex[j]-48);
		if(strHex[j]>64 && strHex[j]<71)
		strBit[i]=strBit[i]&(BYTE)(15*pow(2,4)+strHex[j]-55);
		if(strHex[j]>96 && strHex[j]<103)
		strBit[i]=strBit[i]&(BYTE)(15*pow(2,4)+strHex[j]-87);
		j++;
	}	
}
*/