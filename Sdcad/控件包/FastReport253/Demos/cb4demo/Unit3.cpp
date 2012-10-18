//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "FR_Ctrls"
#pragma link "FR_View"
#pragma resource "*.dfm"
TForm3 *Form3;
//---------------------------------------------------------------------------
__fastcall TForm3::TForm3(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm3::frSpeedButton2Click(TObject *Sender)
{
  frPreview1->Zoom = 100;
}
//---------------------------------------------------------------------------

void __fastcall TForm3::frSpeedButton1Click(TObject *Sender)
{
  frPreview1->OnePage();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton3Click(TObject *Sender)
{
  frPreview1->PageWidth();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton4Click(TObject *Sender)
{
  frPreview1->First();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton5Click(TObject *Sender)
{
  frPreview1->Prev();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton6Click(TObject *Sender)
{
  frPreview1->Next();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton7Click(TObject *Sender)
{
  frPreview1->Last();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton8Click(TObject *Sender)
{
  frPreview1->LoadFromFile();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton9Click(TObject *Sender)
{
  frPreview1->SaveToFile();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton10Click(TObject *Sender)
{
  frPreview1->Print();
}
//---------------------------------------------------------------------------
void __fastcall TForm3::frSpeedButton11Click(TObject *Sender)
{
  ModalResult = mrOk;
}
//---------------------------------------------------------------------------
void __fastcall TForm3::FormActivate(TObject *Sender)
{
  frSpeedButton2->Down = True;
  frSpeedButton2Click(NULL);
}
//---------------------------------------------------------------------------
