//---------------------------------------------------------------------------
// FastReport 2.4 demo

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "Unit2.h"
#include "Unit3.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
#pragma resource "Hand.res"
TForm1 *Form1;
String WPath;


//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::FormShow(TObject *Sender)
{
  TTreeNode *Node;

  WPath = ExtractFilePath(ParamStr(0));
  Node = Tree1->Items->Item[0];
  Node->Expand(True);
  Tree1->Selected = Node->Item[0]->Item[0];
  Tree1->TopItem = Node;
  Screen->Cursors[crHand] = LoadCursor(HInstance, "FR_HAND");
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Tree1Change(TObject *Sender, TTreeNode *Node)
{
  int n;

  n = Node->StateIndex;
  if (n == -1)
  {
    Memo1->Text = "";
    DesignBtn->Enabled = False;
    PreviewBtn->Enabled = False;
    return;
  }
  else if (n == 15)
  {
    Memo1->Text = "Demostrates now to join several reports into one. To do this, fill "
       "TfrCompositeReport.Reports property by references to the other "
       "reports and call its ShowReport method. Reports can have different "
       "page sizes and orientation.";
    DesignBtn->Enabled = False;
    PreviewBtn->Enabled = True;
    return;
  };
  Form2->frReport1->LoadFromFile(WPath + IntToStr(n) + ".frf");
  if (Form2->frReport1->Dictionary->Variables->IndexOf("Description") != - 1)
    Memo1->Text = Form2->frReport1->Dictionary->Variables->Variable["Description"];
  else
    Memo1->Text = "";
  DesignBtn->Enabled = True;
  PreviewBtn->Enabled = True;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::DesignBtnClick(TObject *Sender)
{
  TTreeNode *Node;
  Node = Tree1->Selected;
  if ((Node == NULL) || (Node->StateIndex == -1) || (Node->StateIndex == 15)) return;
  Form2->frReport1->DesignReport();
}
//---------------------------------------------------------------------------
void __fastcall TForm1::PreviewBtnClick(TObject *Sender)
{
  int n;
  TTreeNode *Node;
  TfrReport *Report;

  Node = Tree1->Selected;
  if ((Node == NULL) || (Node->StateIndex == -1)) return;
  n = Node->StateIndex;

  if (n == 15)  // Composite report
  {
    Report = Form2->frCompositeReport1;
    Form2->frReport1->LoadFromFile(WPath + "1.frf");
    Form2->frReport2->LoadFromFile(WPath + "3.frf");
    Form2->frCompositeReport1->DoublePass = True;
    Form2->frCompositeReport1->Reports->Clear();
    Form2->frCompositeReport1->Reports->Add(Form2->frReport1);
    Form2->frCompositeReport1->Reports->Add(Form2->frReport2);
  }
  else
  {
    Report = Form2->frReport1;
    Report->LoadFromFile(WPath + IntToStr(n) + ".frf");
    if (n == 14)  // "Live" report
    {
      Report->OnObjectClick = Form2->frReport1ObjectClick;
      Report->OnMouseOverObject = Form2->frReport1MouseOverObject;
    }
    else
    {
      Report->OnObjectClick = NULL;
      Report->OnMouseOverObject = NULL;
    };
  };
  if (RB1->Checked)
    Report->Preview = NULL;
  else
    Report->Preview = Form3->frPreview1;
  Report->ShowReport();
  if (RB2->Checked)
    Form3->ShowModal();
}
//---------------------------------------------------------------------------
