//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "Unit4.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "FR_DBSet"
#pragma link "FR_DSet"
#pragma resource "*.dfm"
TCustomerData *CustomerData;
//---------------------------------------------------------------------------
__fastcall TCustomerData::TCustomerData(TComponent* Owner)
        : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TCustomerData::LineItemsCalcFields(TDataSet *DataSet)
{
  LineItemsExtendedPrice->Value = LineItemsPrice->Value *
    ((100 - LineItemsDiscount->Value) / 100);
  LineItemsTotal->Value = LineItemsExtendedPrice->Value *
    LineItemsQty->Value;
}
//---------------------------------------------------------------------------
