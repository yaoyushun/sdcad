unit LegendEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OleCtrls, LEGENDOCXLib_TLB, ExtCtrls;

type
  TLegendEditForm = class(TForm)
    Panel1: TPanel;
    Legend1: TLegendOcx;
    btn_ok: TBitBtn;
    btn_cancel: TBitBtn;
    procedure btn_okClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LegendEditForm: TLegendEditForm;

implementation

uses EarthType, public_unit;
{$R *.dfm}

procedure TLegendEditForm.btn_okClick(Sender: TObject);
begin
  g_EarthLegend := Legend1.GetLegendString;
  self.ModalResult := mrOK;
end;

procedure TLegendEditForm.btn_cancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
end;

procedure TLegendEditForm.FormCreate(Sender: TObject);
begin
  self.Left := trunc((Screen.Width-self.Width)/2);
  self.Top  := trunc((Screen.Height-self.Height)/2);
  
end;

procedure TLegendEditForm.FormShow(Sender: TObject);
begin
  Legend1.SetLegendString(g_EarthLegend);
end;



end.
