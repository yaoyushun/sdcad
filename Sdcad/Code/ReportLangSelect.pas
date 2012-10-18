unit ReportLangSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TReportLangSelectForm = class(TForm)
    GroupBox1: TGroupBox;
    rb_ReportLang_cn: TRadioButton;
    rb_ReportLang_en: TRadioButton;
    btn_cancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rb_ReportLang_cnClick(Sender: TObject);
    procedure rb_ReportLang_enClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportLangSelectForm: TReportLangSelectForm;

implementation

uses public_unit;

{$R *.dfm}

procedure TReportLangSelectForm.FormCreate(Sender: TObject);
begin
  if g_ProjectInfo.prj_ReportLanguage =trChineseReport then
     rb_ReportLang_cn.Checked := true
  else if g_ProjectInfo.prj_ReportLanguage = trEnglishReport then
     rb_ReportLang_en.Checked := true
  

end;

procedure TReportLangSelectForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportLangSelectForm.rb_ReportLang_cnClick(Sender: TObject);
begin
  if TRadiobutton(Sender).Checked = true then
    g_ProjectInfo.setReportLanguage(trChineseReport) ;
end;

procedure TReportLangSelectForm.rb_ReportLang_enClick(Sender: TObject);
begin
  if TRadiobutton(Sender).Checked = true then
    g_ProjectInfo.setReportLanguage(trEnglishReport) ;
end;

end.
