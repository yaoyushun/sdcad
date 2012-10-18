//---------------------------------------------------------------------------
#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <Graphics.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TImageList *ImageList1;
        TTreeView *Tree1;
        TImage *Image1;
        TLabel *Label4;
        TMemo *Memo1;
        TGroupBox *GroupBox1;
        TRadioButton *RB1;
        TRadioButton *RB2;
        TButton *DesignBtn;
        TButton *PreviewBtn;
        void __fastcall FormShow(TObject *Sender);
        void __fastcall Tree1Change(TObject *Sender, TTreeNode *Node);
        void __fastcall DesignBtnClick(TObject *Sender);
        void __fastcall PreviewBtnClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;

const
  TCursor crHand = 12;
//---------------------------------------------------------------------------
#endif
