//---------------------------------------------------------------------------
#ifndef Unit3H
#define Unit3H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FR_Ctrls.hpp"
#include "FR_View.hpp"
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm3 : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TfrSpeedButton *frSpeedButton1;
        TfrSpeedButton *frSpeedButton2;
        TfrSpeedButton *frSpeedButton3;
        TfrSpeedButton *frSpeedButton4;
        TfrSpeedButton *frSpeedButton5;
        TfrSpeedButton *frSpeedButton6;
        TfrSpeedButton *frSpeedButton7;
        TfrSpeedButton *frSpeedButton8;
        TfrSpeedButton *frSpeedButton9;
        TfrSpeedButton *frSpeedButton10;
        TfrSpeedButton *frSpeedButton11;
        TfrPreview *frPreview1;
        void __fastcall frSpeedButton2Click(TObject *Sender);
        void __fastcall frSpeedButton1Click(TObject *Sender);
        void __fastcall frSpeedButton3Click(TObject *Sender);
        void __fastcall frSpeedButton4Click(TObject *Sender);
        void __fastcall frSpeedButton5Click(TObject *Sender);
        void __fastcall frSpeedButton6Click(TObject *Sender);
        void __fastcall frSpeedButton7Click(TObject *Sender);
        void __fastcall frSpeedButton8Click(TObject *Sender);
        void __fastcall frSpeedButton9Click(TObject *Sender);
        void __fastcall frSpeedButton10Click(TObject *Sender);
        void __fastcall frSpeedButton11Click(TObject *Sender);
        void __fastcall FormActivate(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm3(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm3 *Form3;
//---------------------------------------------------------------------------
#endif
