//---------------------------------------------------------------------------
#ifndef Unit2H
#define Unit2H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "FR_BarC.hpp"
#include "FR_ChBox.hpp"
#include "FR_Class.hpp"
#include "FR_DCtrl.hpp"
#include "FR_Desgn.hpp"
#include "FR_E_CSV.hpp"
#include "FR_E_HTM.hpp"
#include "FR_E_RTF.hpp"
#include "FR_E_TXT.hpp"
#include "FR_OLE.hpp"
#include "FR_Rich.hpp"
#include "FR_RRect.hpp"
#include "FR_Shape.hpp"
//---------------------------------------------------------------------------
class TForm2 : public TForm
{
__published:	// IDE-managed Components
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TLabel *Label4;
        TfrReport *frReport1;
        TfrReport *frReport2;
        TfrDesigner *frDesigner1;
        TfrCompositeReport *frCompositeReport1;
        TfrOLEObject *frOLEObject1;
        TfrRichObject *frRichObject1;
        TfrCheckBoxObject *frCheckBoxObject1;
        TfrShapeObject *frShapeObject1;
        TfrBarCodeObject *frBarCodeObject1;
        TfrDialogControls *frDialogControls1;
        TfrRoundRectObject *frRoundRectObject1;
        TfrTextExport *frTextExport1;
        TfrRTFExport *frRTFExport1;
        TfrCSVExport *frCSVExport1;
        TfrHTMExport *frHTMExport1;
        void __fastcall frReport1ObjectClick(TfrView *View);
        void __fastcall frReport1MouseOverObject(TfrView *View,
          TCursor &Cursor);
private:	// User declarations
public:		// User declarations
        __fastcall TForm2(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm2 *Form2;
//---------------------------------------------------------------------------
#endif
