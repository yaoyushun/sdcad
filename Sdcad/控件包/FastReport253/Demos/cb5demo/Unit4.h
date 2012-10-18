//---------------------------------------------------------------------------
#ifndef Unit4H
#define Unit4H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FR_DBSet.hpp"
#include "FR_DSet.hpp"
#include <Db.hpp>
#include <DBTables.hpp>
//---------------------------------------------------------------------------
class TCustomerData : public TDataModule
{
__published:	// IDE-managed Components
        TTable *Customers;
        TFloatField *CustomersCustNo;
        TStringField *CustomersCompany;
        TStringField *CustomersAddr1;
        TStringField *CustomersAddr2;
        TStringField *CustomersCity;
        TStringField *CustomersState;
        TStringField *CustomersZip;
        TStringField *CustomersCountry;
        TStringField *CustomersPhone;
        TStringField *CustomersFAX;
        TFloatField *CustomersTaxRate;
        TStringField *CustomersContact;
        TDateTimeField *CustomersLastInvoiceDate;
        TTable *Orders;
        TFloatField *OrdersOrderNo;
        TFloatField *OrdersCustNo;
        TStringField *OrdersCustCompany;
        TDateTimeField *OrdersSaleDate;
        TDateTimeField *OrdersShipDate;
        TIntegerField *OrdersEmpNo;
        TStringField *OrdersShipToContact;
        TStringField *OrdersShipToAddr1;
        TStringField *OrdersShipToAddr2;
        TStringField *OrdersShipToCity;
        TStringField *OrdersShipToState;
        TStringField *OrdersShipToZip;
        TStringField *OrdersShipToCountry;
        TStringField *OrdersShipToPhone;
        TStringField *OrdersShipVIA;
        TStringField *OrdersPO;
        TStringField *OrdersTerms;
        TStringField *OrdersPaymentMethod;
        TCurrencyField *OrdersItemsTotal;
        TFloatField *OrdersTaxRate;
        TCurrencyField *OrdersFreight;
        TCurrencyField *OrdersAmountPaid;
        TTable *LineItems;
        TFloatField *LineItemsOrderNo;
        TFloatField *LineItemsItemNo;
        TFloatField *LineItemsPartNo;
        TStringField *LineItemsPartName;
        TIntegerField *LineItemsQty;
        TCurrencyField *LineItemsPrice;
        TFloatField *LineItemsDiscount;
        TCurrencyField *LineItemsTotal;
        TCurrencyField *LineItemsExtendedPrice;
        TTable *Parts;
        TFloatField *PartsPartNo;
        TFloatField *PartsVendorNo;
        TStringField *PartsDescription;
        TFloatField *PartsOnHand;
        TFloatField *PartsOnOrder;
        TCurrencyField *PartsCost;
        TCurrencyField *PartsListPrice;
        TDataSource *CustomerSource;
        TDataSource *OrderSource;
        TDataSource *LineItemSource;
        TDataSource *PartSource;
        TQuery *RepQuery;
        TFloatField *RepQueryCustNo;
        TStringField *RepQueryCompany;
        TStringField *RepQueryAddr1;
        TStringField *RepQueryAddr2;
        TStringField *RepQueryCity;
        TStringField *RepQueryState;
        TStringField *RepQueryZip;
        TStringField *RepQueryCountry;
        TStringField *RepQueryPhone;
        TStringField *RepQueryFAX;
        TFloatField *RepQueryTaxRate;
        TStringField *RepQueryContact;
        TDateTimeField *RepQueryLastInvoiceDate;
        TFloatField *RepQueryOrderNo;
        TFloatField *RepQueryCustNo_1;
        TDateTimeField *RepQuerySaleDate;
        TDateTimeField *RepQueryShipDate;
        TIntegerField *RepQueryEmpNo;
        TStringField *RepQueryShipToContact;
        TStringField *RepQueryShipToAddr1;
        TStringField *RepQueryShipToAddr2;
        TStringField *RepQueryShipToCity;
        TStringField *RepQueryShipToState;
        TStringField *RepQueryShipToZip;
        TStringField *RepQueryShipToCountry;
        TStringField *RepQueryShipToPhone;
        TStringField *RepQueryShipVIA;
        TStringField *RepQueryPO;
        TStringField *RepQueryTerms;
        TStringField *RepQueryPaymentMethod;
        TCurrencyField *RepQueryItemsTotal;
        TFloatField *RepQueryTaxRate_1;
        TCurrencyField *RepQueryFreight;
        TCurrencyField *RepQueryAmountPaid;
        TFloatField *RepQueryOrderNo_1;
        TFloatField *RepQueryItemNo;
        TFloatField *RepQueryPartNo;
        TIntegerField *RepQueryQty;
        TFloatField *RepQueryDiscount;
        TFloatField *RepQueryPartNo_1;
        TFloatField *RepQueryVendorNo;
        TStringField *RepQueryDescription;
        TFloatField *RepQueryOnHand;
        TFloatField *RepQueryOnOrder;
        TCurrencyField *RepQueryCost;
        TCurrencyField *RepQueryListPrice;
        TDataSource *RepQuerySource;
        TfrDBDataSet *CustomersDS;
        TfrDBDataSet *OrdersDS;
        TfrDBDataSet *ItemsDS;
        TfrDBDataSet *PartDS;
        TfrDBDataSet *QueryDS;
        TTable *Bio;
        TDataSource *BioSource;
        TfrDBDataSet *BioDS;
        TQuery *RepQuery1;
        TDataSource *RepQuery1Source;
        TfrDBDataSet *Query1DS;
        void __fastcall LineItemsCalcFields(TDataSet *DataSet);
private:	// User declarations
public:		// User declarations
        __fastcall TCustomerData(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TCustomerData *CustomerData;
//---------------------------------------------------------------------------
#endif
