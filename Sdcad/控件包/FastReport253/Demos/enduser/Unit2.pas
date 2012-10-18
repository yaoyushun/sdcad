unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class, FR_Desgn, FR_DCtrl, FR_BDEDB;

type                                            
  TForm2 = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    frDialogControls1: TfrDialogControls;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    frBDEComponents1: TfrBDEComponents;
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


end.
