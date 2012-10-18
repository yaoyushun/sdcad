//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit2.h"
#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "FR_BarC"
#pragma link "FR_ChBox"
#pragma link "FR_Class"
#pragma link "FR_DCtrl"
#pragma link "FR_Desgn"
#pragma link "FR_E_CSV"
#pragma link "FR_E_HTM"
#pragma link "FR_E_RTF"
#pragma link "FR_E_TXT"
#pragma link "FR_OLE"
#pragma link "FR_Rich"
#pragma link "FR_RRect"
#pragma link "FR_Shape"
#pragma resource "*.dfm"
TForm2 *Form2;
//---------------------------------------------------------------------------
__fastcall TForm2::TForm2(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm2::frReport1ObjectClick(TfrView *View)
{
  ShowMessage("Name: " + View->Name + "\n" + "Contents:\n" +
    View->Memo->Text);
}
//---------------------------------------------------------------------------

void __fastcall TForm2::frReport1MouseOverObject(TfrView *View, TCursor &Cursor)
{
  if(View->Name == "Memo8")
    Cursor = crHand;
}
//---------------------------------------------------------------------------
 