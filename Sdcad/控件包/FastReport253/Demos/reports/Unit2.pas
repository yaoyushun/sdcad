unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_E_HTM, FR_E_CSV, FR_E_RTF, FR_E_TXT, FR_RRect, FR_DCtrl,
  FR_BarC, FR_Shape, FR_ChBox, FR_Rich, FR_OLE, FR_Class, FR_Desgn, FR_Cross;
                                  
type
  TForm2 = class(TForm)
    frReport1: TfrReport;
    frReport2: TfrReport;
    frDesigner1: TfrDesigner;
    frCompositeReport1: TfrCompositeReport;
    frOLEObject1: TfrOLEObject;
    frRichObject1: TfrRichObject;
    frCheckBoxObject1: TfrCheckBoxObject;
    frShapeObject1: TfrShapeObject;
    frBarCodeObject1: TfrBarCodeObject;
    frDialogControls1: TfrDialogControls;
    frRoundRectObject1: TfrRoundRectObject;
    frTextExport1: TfrTextExport;
    frRTFExport1: TfrRTFExport;
    frCSVExport1: TfrCSVExport;
    frHTMExport1: TfrHTMExport;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    frCrossObject1: TfrCrossObject;
    procedure frReport1ObjectClick(View: TfrView);
    procedure frReport1MouseOverObject(View: TfrView; var Cursor: TCursor);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.frReport1ObjectClick(View: TfrView);
begin
  ShowMessage('Name: ' + View.Name + #13#10 + 'Contents:' + #13#10 +
    View.Memo.Text);
end;

procedure TForm2.frReport1MouseOverObject(View: TfrView; var Cursor: TCursor);
begin
  if View.Name = 'Memo8' then
    Cursor := crHand;
end;

end.
