unit Preview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_Class,   FR_View, ExtCtrls,
     frRtfExp, frOLEExl, frexpimg,
  FR_E_TXT, FR_E_RTF, FR_Desgn, Buttons, frTXTExp, frXMLExl,
  FR_E_CSV;

type
  TPreviewForm = class(TForm)
    Panel1: TPanel;
    frsbZoomToFit: TSpeedButton;
    frsbZoom100: TSpeedButton;
    frsbZoomToPageWidth: TSpeedButton;
    frsbFirstPage: TSpeedButton;
    frsbPrevPage: TSpeedButton;
    frsbNextPage: TSpeedButton;
    frsbLastPage: TSpeedButton;
    frsbSaveReport: TSpeedButton;
    frsbPrint: TSpeedButton;
    frsbClose: TSpeedButton;
    SpeedButton12: TSpeedButton;
    frPreview1: TfrPreview;
    frsbSetPage: TSpeedButton;
    frDesigner1: TfrDesigner;
    frRTFExport1: TfrRTFExport;
    frJPEGExport1: TfrJPEGExport;
    frTextExport1: TfrTextExport;
    frRTFExport2: TfrRTFExport;
    frCSVExport1: TfrCSVExport;
    frOLEExcelExport1: TfrOLEExcelExport;
    frXMLExcelExport1: TfrXMLExcelExport;
    frTextAdvExport1: TfrTextAdvExport;
    frRtfAdvExport1: TfrRtfAdvExport;
    procedure frsbZoom100Click(Sender: TObject);
    procedure frsbZoomToFitClick(Sender: TObject);
    procedure frsbZoomToPageWidthClick(Sender: TObject);
    procedure frsbFirstPageClick(Sender: TObject);
    procedure frsbPrevPageClick(Sender: TObject);
    procedure frsbNextPageClick(Sender: TObject);
    procedure frsbLastPageClick(Sender: TObject);
    procedure frsbSaveReportClick(Sender: TObject);
    procedure frsbPrintClick(Sender: TObject);
    procedure frsbSetPageClick(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure frsbCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PreviewForm: TPreviewForm;

implementation

{$R *.dfm}

procedure TPreviewForm.frsbZoom100Click(Sender: TObject);
begin
  frPreview1.Zoom := 100;
end;

procedure TPreviewForm.frsbZoomToFitClick(Sender: TObject);
begin
  frPreview1.OnePage;
end;

procedure TPreviewForm.frsbZoomToPageWidthClick(Sender: TObject);
begin
  frPreview1.PageWidth;;
end;

procedure TPreviewForm.frsbFirstPageClick(Sender: TObject);
begin
  frPreview1.First;
end;

procedure TPreviewForm.frsbPrevPageClick(Sender: TObject);
begin
  frPreview1.Prev;
end;

procedure TPreviewForm.frsbNextPageClick(Sender: TObject);
begin
  frPreview1.Next;
end;

procedure TPreviewForm.frsbLastPageClick(Sender: TObject);
begin
  frPreview1.Last;
end;

procedure TPreviewForm.frsbSaveReportClick(Sender: TObject);
begin
  frPreview1.SaveToFile;
end;

procedure TPreviewForm.frsbPrintClick(Sender: TObject);
begin
  frPreview1.Print;
end;

procedure TPreviewForm.frsbSetPageClick(Sender: TObject);
begin
  frPreview1.PageSetupDlg;
end;

procedure TPreviewForm.SpeedButton12Click(Sender: TObject);
begin
  frPreview1.Find;
end;

procedure TPreviewForm.frsbCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPreviewForm.FormActivate(Sender: TObject);
begin
  frsbZoom100.Down := True;
  frsbZoom100Click(nil);
end;

procedure TPreviewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  frPreview1.Window.FormKeyDown(Sender, Key, Shift);
end;

end.
