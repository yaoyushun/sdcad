// FastReport 2.4 demo
//
// Main demo

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, FR_Class, ImgList;

type
  TForm1 = class(TForm)
    Tree1: TTreeView;
    ImageList1: TImageList;
    Image1: TImage;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    RB1: TRadioButton;
    RB2: TRadioButton;
    DesignBtn: TButton;
    PreviewBtn: TButton;
    Memo1: TMemo;
    PBox: TPaintBox;
    procedure FormShow(Sender: TObject);
    procedure Tree1Change(Sender: TObject; Node: TTreeNode);
    procedure DesignBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PBoxPaint(Sender: TObject);
  private
    { Private declarations }
    WPath: String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

const
  crHand = 12;

implementation

uses Unit2, Unit3;

{$R *.DFM}
{$R HAND.RES}

procedure TForm1.FormShow(Sender: TObject);
begin
  WPath := ExtractFilePath(ParamStr(0));
  Tree1.Items[0].Expand(True);
  Tree1.Selected := Tree1.Items[0].Item[0].Item[0];
  Tree1.TopItem := Tree1.Items[0];
  Screen.Cursors[crHand] := LoadCursor(hInstance, 'FR_HAND');
// shows how to disable particular dataset or entire datamodule
//  Form2.frReport1.Dictionary.DisabledDatasets.Add('CustomerData.Bio');
//  Form2.frReport1.Dictionary.DisabledDatasets.Add('CustomerData*');
end;

procedure TForm1.PBoxPaint(Sender: TObject);
begin
  PBox.Canvas.BrushCopy(Rect(0, 0, PBox.Width, PBox.Height),
    Image1.Picture.Bitmap,
    Rect(0, 0, PBox.Width, PBox.Height),
    Image1.Picture.Bitmap.TransparentColor);
end;

procedure TForm1.Tree1Change(Sender: TObject; Node: TTreeNode);
var
  n: Integer;
begin
  n := Node.StateIndex;
  if n = -1 then
  begin
    Memo1.Text := '';
    DesignBtn.Enabled := False;
    PreviewBtn.Enabled := False;
    Exit;
  end
  else if n = 15 then
  begin
    Memo1.Text := 'Demonstrates now to join several reports into one. To do this, fill ' +
       'TfrCompositeReport.Reports property by references to the other ' +
       'reports and call its ShowReport method. Reports can have different ' +
       'page sizes and orientation.';
    DesignBtn.Enabled := False;
    PreviewBtn.Enabled := True;
    Exit;
  end;
  with Form2.frReport1 do
  begin
    LoadFromFile(WPath + IntToStr(n) + '.frf');
    if Dictionary.Variables.IndexOf('Description') <> - 1 then
      Memo1.Text := Dictionary.Variables['Description'] else
      Memo1.Text := '';
    DesignBtn.Enabled := True;
    PreviewBtn.Enabled := True;
  end;
end;

procedure TForm1.DesignBtnClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := Tree1.Selected;
  if (Node = nil) or (Node.StateIndex = -1) or (Node.StateIndex = 15) then Exit;
// uncomment this line if you want to show variables in the Insert DB fields dialog
//  Form2.frReport1.MixVariablesAndDBFields := True;
  Form2.frReport1.DesignReport;
end;

procedure TForm1.PreviewBtnClick(Sender: TObject);
var
  n: Integer;
  Node: TTreeNode;
  Report: TfrReport;
begin
  Node := Tree1.Selected;
  if (Node = nil) or (Node.StateIndex = -1) then Exit;
  n := Node.StateIndex;
  with Form2 do
  if n = 15 then { Composite report }
  begin
    Report := frCompositeReport1;
    frReport1.LoadFromFile(WPath + '1.frf');
    frReport2.LoadFromFile(WPath + '3.frf');
    frCompositeReport1.DoublePass := True;
    frCompositeReport1.Reports.Clear;
    frCompositeReport1.Reports.Add(frReport1);
    frCompositeReport1.Reports.Add(frReport2);
  end
  else
  begin
    Report := frReport1;
    Report.LoadFromFile(WPath + IntToStr(n) + '.frf');
    if n = 14 then { "Live" report }
    begin
      Report.OnObjectClick := frReport1ObjectClick;
      Report.OnMouseOverObject := frReport1MouseOverObject;
    end
    else
    begin
      Report.OnObjectClick := nil;
      Report.OnMouseOverObject := nil;
    end;
  end;
  if RB1.Checked then
    Report.Preview := nil else
    Report.Preview := Form3.frPreview1;
  if Report.PrepareReport then
  begin
    Report.ShowPreparedReport;
    if RB2.Checked then
      Form3.ShowModal;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//  Example of just-in-time localization
//  frLocale.LoadDll('FR_Rus.dll');
end;

end.
