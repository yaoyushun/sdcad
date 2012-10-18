{********************************************}
{   PrintPreview Form                        }
{   Copyright (c) 1996-2004 by David Berneda }
{********************************************}
unit TeePrevi;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
     QPrinters, TeePenDlg,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls, Printers,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeeProcs, TeCanvas, TeePreviewPanel, TeeNavigator, TeEngine, Chart;

type
  TChartPreview = class(TForm)
    Panel1: TPanel;
    CBPrinters: TComboFlat;
    Label1: TLabel;
    BSetupPrinter: TButton;
    Panel2: TPanel;
    Orientation: TRadioGroup;
    GBMargins: TGroupBox;
    SETopMa: TEdit;
    SELeftMa: TEdit;
    SEBotMa: TEdit;
    SERightMa: TEdit;
    ChangeDetailGroup: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    BClose: TButton;
    BPrint: TButton;
    UDLeftMa: TUpDown;
    UDTopMa: TUpDown;
    UDRightMa: TUpDown;
    UDBotMa: TUpDown;
    TeePreviewPanel1: TTeePreviewPanel;
    Resolution: TTrackBar;
    PanelMargins: TPanel;
    BReset: TButton;
    ShowMargins: TCheckBox;
    Panel4: TPanel;
    CBProp: TCheckBox;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure BSetupPrinterClick(Sender: TObject);
    procedure CBPrintersChange(Sender: TObject);
    procedure OrientationClick(Sender: TObject);
    procedure SETopMaChange(Sender: TObject);
    procedure SERightMaChange(Sender: TObject);
    procedure SEBotMaChange(Sender: TObject);
    procedure SELeftMaChange(Sender: TObject);
    procedure ShowMarginsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BResetClick(Sender: TObject);
    procedure BPrintClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
    procedure CBPropClick(Sender: TObject);
    procedure TeePreviewPanel1ChangeMargins(Sender: TObject;
      DisableProportional: Boolean; const NewMargins: TRect);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    ChangingMargins : Boolean;
    ChangingProp    : Boolean;
    OldMargins      : TRect;
    PageNavigator1  : TCustomTeeNavigator;

    procedure Navigator1ButtonClicked(Index: TTeeNavigateBtn);
    Procedure ResetMargins;
    Procedure CheckOrientation;
    procedure ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
  public
    PageNavigatorClass    : TTeePageNavigatorClass; 
    PrinterSetupDialog1   : TPrinterSetupDialog;
    {$IFDEF CLR}
    Constructor Create(AOwner:TComponent); override;
    {$ENDIF}
    Function PreviewPanel : TTeePreviewPanel;
  end;

Var TeeChangePaperOrientation:Boolean=True;

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Procedure TeePreview(AOwner:TComponent; APanel:TCustomTeePanel);
begin
  with TChartPreview.Create(AOwner) do
  try
    TeePreviewPanel1.Panel:=APanel;
    ShowModal;
  finally
    Free;
    APanel.Repaint;
  end;
end;

{ TChartPreview }
{$IFDEF CLR}
Constructor TChartPreview.Create(AOwner:TComponent);
begin
  inherited;
  TeePreviewPanel1:=TTeePreviewPanel.Create(Self);
  Left:= 256;
  Top:= 190;

  {$IFNDEF CLR}  // Vcl.Forms bug
  ActiveControl := TeePreviewPanel1;
  {$ENDIF}

  AutoScroll:= False;
  Caption := 'TeeChart Print Preview';
  ClientHeight := 379;
  ClientWidth := 543;
  Color := clBtnFace;
  ParentFont := True;
  KeyPreview := True;
  Position := poScreenCenter;
  OnCreate := FormCreate;
  OnDestroy := FormDestroy;
  OnShow := FormShow;
  PixelsPerInch := 96;

  with TeePreviewPanel1 do
  begin
    Parent:=Self;
    Left:= 112;
    Top := 38;
    Width := 431;
    Height := 341;
    HelpContext := 1197;
    Shadow.Color := clGray;
    Shadow.HorizSize := 4;
    Shadow.VertSize := 4;
    OnChangeMargins := TeePreviewPanel1ChangeMargins;
    Gradient.Direction := gdFromTopLeft;
    Gradient.EndColor := clGray;
    Gradient.Visible := True;
    Align := alClient;
    TabOrder := 2;
  end;

  (*
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 543
    Height = 38
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 37
      Top = 12
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'P&rinter:'
      FocusControl = CBPrinters
      Layout = tlCenter
    end
    object CBPrinters: TComboFlat
      Left = 72
      Top = 9
      Width = 156
      TabOrder = 0
      OnChange = CBPrintersChange
    end
    object BSetupPrinter: TButton
      Left = 234
      Top = 7
      Width = 75
      Height = 25
      Caption = '&Setup...'
      TabOrder = 1
      OnClick = BSetupPrinterClick
    end
    object BClose: TButton
      Left = 443
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Close'
      Default = True
      ModalResult = 1
      TabOrder = 2
      OnClick = BCloseClick
    end
    object BPrint: TButton
      Left = 318
      Top = 7
      Width = 75
      Height = 25
      HelpContext = 395
      Caption = '&Print'
      TabOrder = 3
      OnClick = BPrintClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 38
    Width = 112
    Height = 341
    Align = alLeft
    TabOrder = 1
    object Orientation: TRadioGroup
      Left = 1
      Top = 1
      Width = 110
      Height = 66
      HelpContext = 398
      Align = alTop
      Caption = 'Orien&tation:'
      Items.Strings = (
        'P&ortrait'
        '&Landscape')
      TabOrder = 0
      OnClick = OrientationClick
    end
    object GBMargins: TGroupBox
      Left = 1
      Top = 67
      Width = 110
      Height = 95
      Align = alTop
      Caption = 'Margins (%)'
      TabOrder = 1
      object SETopMa: TEdit
        Left = 34
        Top = 17
        Width = 27
        Height = 21
        HelpContext = 397
        MaxLength = 32767
        TabOrder = 0
        Text = '0'
        OnChange = SETopMaChange
      end
      object SELeftMa: TEdit
        Left = 6
        Top = 43
        Width = 26
        Height = 21
        HelpContext = 397
        MaxLength = 32767
        TabOrder = 1
        Text = '0'
        OnChange = SELeftMaChange
      end
      object SEBotMa: TEdit
        Left = 34
        Top = 68
        Width = 27
        Height = 21
        HelpContext = 397
        MaxLength = 32767
        TabOrder = 2
        Text = '0'
        OnChange = SEBotMaChange
      end
      object SERightMa: TEdit
        Left = 58
        Top = 43
        Width = 27
        Height = 21
        HelpContext = 397
        MaxLength = 32767
        TabOrder = 3
        Text = '0'
        OnChange = SERightMaChange
      end
      object UDLeftMa: TUpDown
        Left = 32
        Top = 43
        Width = 15
        Height = 21
        HelpContext = 397
        Associate = SELeftMa
        Increment = 5
        TabOrder = 4
      end
      object UDTopMa: TUpDown
        Left = 61
        Top = 17
        Width = 15
        Height = 21
        HelpContext = 397
        Associate = SETopMa
        Increment = 5
        TabOrder = 5
      end
      object UDRightMa: TUpDown
        Left = 85
        Top = 43
        Width = 15
        Height = 21
        HelpContext = 397
        Associate = SERightMa
        Increment = 5
        TabOrder = 6
      end
      object UDBotMa: TUpDown
        Left = 61
        Top = 68
        Width = 15
        Height = 21
        HelpContext = 397
        Associate = SEBotMa
        Increment = 5
        TabOrder = 7
      end
    end
    object ChangeDetailGroup: TGroupBox
      Left = 1
      Top = 220
      Width = 110
      Height = 66
      Align = alTop
      Caption = 'Detail:'
      TabOrder = 2
      object Label2: TLabel
        Left = 6
        Top = 16
        Width = 24
        Height = 13
        Caption = 'More'
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 69
        Top = 16
        Width = 33
        Height = 13
        Alignment = taRightJustify
        Caption = 'Normal'
        Layout = tlCenter
      end
      object Resolution: TTrackBar
        Left = 6
        Top = 32
        Width = 98
        Height = 25
        HelpContext = 400
        LineSize = 2
        Max = 100
        Frequency = 10
        Position = 99
        TabOrder = 0
        OnChange = TrackBar1Change
      end
    end
    object PanelMargins: TPanel
      Left = 1
      Top = 162
      Width = 110
      Height = 58
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
      object BReset: TButton
        Left = 4
        Top = 5
        Width = 101
        Height = 25
        HelpContext = 1331
        Caption = 'Reset &Margins'
        Enabled = False
        TabOrder = 0
        OnClick = BResetClick
      end
      object ShowMargins: TCheckBox
        Left = 7
        Top = 36
        Width = 100
        Height = 15
        HelpContext = 1331
        Caption = '&View Margins'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = ShowMarginsClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 286
      Width = 110
      Height = 54
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 3
      object CBProp: TCheckBox
        Left = 11
        Top = 5
        Width = 92
        Height = 17
        HelpContext = 889
        Caption = 'Proport&ional'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CBPropClick
      end
    end
  end
  *)
end;
{$ENDIF}

Procedure TChartPreview.ResetMargins;
begin
  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    if Panel.PrintProportional and (Printer.Printers.Count>0) then
    begin
      OldMargins:=Panel.CalcProportionalMargins;
      Panel.PrintMargins:=OldMargins;
    end;
    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
end;

procedure TChartPreview.FormShow(Sender: TObject);
var tmpClass: TTeePageNavigatorClass;
begin
  tmpClass:=PageNavigatorClass;
  if Assigned(tmpClass) then
  begin
    PageNavigator1:=tmpClass.Create(Self);
    PageNavigator1.Parent:=Panel2;
    PageNavigator1.Align:=alBottom;
    PageNavigator1.HelpContext:=1488;
    PageNavigator1.OnButtonClicked:=Navigator1ButtonClicked;
  end;

  Screen.Cursor:=crDefault;

  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     TeePreviewPanel1.Panel:=TCustomTeePanel({$IFDEF CLR}TObject{$ENDIF}(Tag));

  CBPrinters.Items:=Printer.Printers;
  if Printer.Printers.Count>0 then
  begin
    {$IFDEF CLX}
    CBPrinters.ItemIndex:=0;
    {$ELSE}
    CBPrinters.ItemIndex:=Printer.PrinterIndex;
    {$ENDIF}

    {$IFNDEF TEEOCX}
    if TeeChangePaperOrientation then
       Printer.Orientation:=poLandscape;
    {$ENDIF}

    CheckOrientation;
  end
  else
  begin
    EnableControls(False,[BPrint,BSetupPrinter,Orientation]);
  end;

  With TeePreviewPanel1 do
  if Assigned(Panel) then
  begin
    CBProp.Checked:=Panel.PrintProportional;
    Resolution.Position:=Panel.PrintResolution+100;
    OldMargins:=Panel.PrintMargins;
    ResetMargins;

    if Assigned(PageNavigator1) then
       PageNavigator1.Panel:=Panel;  { 5.03 }
  end
  else
  begin
    CBProp.Enabled:=False;
    Resolution.Enabled:=False;
    GBMargins.Enabled:=False;
    BPrint.Enabled:=False;
  end;

  CheckBox1.Checked:=TeePreviewPanel1.AsBitmap;
  
  TeeTranslateControl(Self);
end;

procedure TChartPreview.BSetupPrinterClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
  CBPrinters.Items:=Printer.Printers;
  {$IFNDEF CLX}
  CBPrinters.ItemIndex:=Printer.PrinterIndex;
  {$ENDIF}
  CheckOrientation;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.CBPrintersChange(Sender: TObject);
begin
  {$IFNDEF CLX}
  Printer.PrinterIndex:=CBPrinters.ItemIndex;
  {$ENDIF}
  CheckOrientation;
  OrientationClick(Self);
end;

procedure TChartPreview.OrientationClick(Sender: TObject);
begin
  Printer.Orientation:=TPrinterOrientation(Orientation.ItemIndex);
  ResetMargins;
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.ChangeMargin(UpDown:TUpDown; Var APos:Integer; OtherSide:Integer);
begin
  if Showing then
  begin
    if UpDown.Position+OtherSide<100 then
    begin
      APos:=UpDown.Position;
      if not ChangingMargins then
      With TeePreviewPanel1 do
      Begin
        Invalidate;
        BReset.Enabled:=not EqualRect(Panel.PrintMargins,OldMargins);
        CBProp.Checked:=False;
      end;
    end
    else UpDown.Position:=APos;
  end;
end;

procedure TChartPreview.SETopMaChange(Sender: TObject);
{$IFDEF CLR}
var R: TRect;
{$ENDIF}
begin
  if Showing then
  {$IFDEF CLR}
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDTopMa,R.Top,R.Bottom);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
  {$ELSE}
  with TeePreviewPanel1.Panel.PrintMargins do
       ChangeMargin(UDTopMa,Top,Bottom);
  {$ENDIF}
end;

procedure TChartPreview.SERightMaChange(Sender: TObject);
{$IFDEF CLR}
var R: TRect;
{$ENDIF}
begin
  if Showing then
  {$IFDEF CLR}
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDRightMa,R.Right,R.Left);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
  {$ELSE}
  with TeePreviewPanel1.Panel.PrintMargins do
       ChangeMargin(UDRightMa,Right,Left);
  {$ENDIF}
end;

procedure TChartPreview.SEBotMaChange(Sender: TObject);
{$IFDEF CLR}
var R: TRect;
{$ENDIF}
begin
  if Showing then
  {$IFDEF CLR}
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDBotMa,R.Bottom,R.Top);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
  {$ELSE}
  with TeePreviewPanel1.Panel.PrintMargins do
       ChangeMargin(UDBotMa,Bottom,Top);
  {$ENDIF}
end;

procedure TChartPreview.SELeftMaChange(Sender: TObject);
{$IFDEF CLR}
var R: TRect;
{$ENDIF}
begin
  if Showing then
  {$IFDEF CLR}
  begin
    R:=TeePreviewPanel1.Panel.PrintMargins;
    ChangeMargin(UDLeftMa,R.Left,R.Right);
    TeePreviewPanel1.Panel.PrintMargins:=R;
  end;
  {$ELSE}
  with TeePreviewPanel1.Panel.PrintMargins do
       ChangeMargin(UDLeftMa,Left,Right);
  {$ENDIF}
end;

procedure TChartPreview.ShowMarginsClick(Sender: TObject);
begin
  TeePreviewPanel1.Margins.Visible:=ShowMargins.Checked;
end;

procedure TChartPreview.FormCreate(Sender: TObject);
begin
  ChangingMargins:=True;
  ChangingProp:=False;
  PrinterSetupDialog1:=TPrinterSetupDialog.Create(Self);
end;

procedure TChartPreview.BResetClick(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintMargins:=OldMargins;
    TeePreviewPanel1ChangeMargins(Self,False,Panel.PrintMargins);
    Invalidate;
  end;
  BReset.Enabled:=False;
end;

Procedure TChartPreview.CheckOrientation;
Begin
  Orientation.ItemIndex:=Ord(Printer.Orientation);
End;

procedure TChartPreview.BPrintClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    if Assigned(PageNavigator1) and (PageNavigator1.PageCount>1) then
       PageNavigator1.Print
    else
       TeePreviewPanel1.Print;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TChartPreview.BCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TChartPreview.CBPropClick(Sender: TObject);
begin
  if not ChangingProp then
  begin
    TeePreviewPanel1.Panel.PrintProportional:=CBProp.Checked;
    ResetMargins;
  end;
end;

procedure TChartPreview.TeePreviewPanel1ChangeMargins(Sender: TObject;
  DisableProportional: Boolean; const NewMargins: TRect);
begin
  ChangingMargins:=True;
  try
    UDLeftMa.Position :=NewMargins.Left;
    UDRightMa.Position:=NewMargins.Right;
    UDTopMa.Position  :=NewMargins.Top;
    UDBotMa.Position  :=NewMargins.Bottom;
    if DisableProportional then
    begin
      TeePreviewPanel1.Panel.PrintProportional:=False;
      ChangingProp:=True;
      CBProp.Checked:=False;
      ChangingProp:=False;
    end;
  finally
    ChangingMargins:=False;
  end;
end;

procedure TChartPreview.Navigator1ButtonClicked(Index: TTeeNavigateBtn);
begin
  TeePreviewPanel1.Invalidate;
end;

procedure TChartPreview.TrackBar1Change(Sender: TObject);
begin
  With TeePreviewPanel1 do
  Begin
    Panel.PrintResolution:=Resolution.Position-100;
    Invalidate;
  end;
end;

function TChartPreview.PreviewPanel: TTeePreviewPanel;
begin
  result:=TeePreviewPanel1;
end;

procedure TChartPreview.FormDestroy(Sender: TObject);
begin
  PrinterSetupDialog1.Free;
  PageNavigator1.Free; { 5.02 }
end;

procedure TChartPreview.CheckBox1Click(Sender: TObject);
begin
  TeePreviewPanel1.AsBitmap:=CheckBox1.Checked;
end;

end.
