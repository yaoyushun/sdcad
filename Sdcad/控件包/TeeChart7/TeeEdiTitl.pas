{**********************************************}
{  TCustomChart (or derived) Editor Dialog     }
{  Copyright (c) 1996-2004 by David Berneda    }
{**********************************************}
unit TeeEdiTitl;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     Chart, TeeCustomShapeEditor, TeCanvas, TeePenDlg, TeeProcs;

type
  TFormTeeTitle = class(TForm)
    PageControlTitle: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    CBTitles: TComboFlat;
    MText: TMemo;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    ECustTop: TEdit;
    UDTop: TUpDown;
    CBCustPos: TCheckBox;
    Panel2: TPanel;
    CBVisible: TCheckBox;
    CBAdjust: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    CBAlign: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure MTextChange(Sender: TObject);
    procedure CBAdjustClick(Sender: TObject);
    procedure CBTitlesChange(Sender: TObject);
    procedure CBCustPosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure CBAlignChange(Sender: TObject);
  private
    { Private declarations }
    AssigningText : Boolean;
    CreatingForm  : Boolean;
    TheChart      : TCustomChart;
    ITeeObject    : TFormTeeShape;

    Function CanChangeCust:Boolean;
    Procedure EnableCustomPosition;
    procedure SetTitleControls;
  public
    { Public declarations }
    TheTitle      : TChartTitle;
    Constructor CreateTitle(Owner:TComponent; AChart:TCustomChart; ATitle:TChartTitle);
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine;

Constructor TFormTeeTitle.CreateTitle(Owner:TComponent; AChart:TCustomChart; ATitle:TChartTitle);
begin
  inherited Create(Owner);
  TheChart:=AChart;
  TheTitle:=ATitle;
  AssigningText:=False;
  ITeeObject:=InsertTeeObjectForm(PageControlTitle,TheTitle);
end;

procedure TFormTeeTitle.SetTitleControls;
var Old : Boolean;
begin
  With TheTitle do
  begin
    Case Alignment of
      taLeftJustify:  CBAlign.ItemIndex:=0;
      taCenter:       CBAlign.ItemIndex:=1;
      taRightJustify: CBAlign.ItemIndex:=2;
    end;
    
    CBVisible.Checked :=Visible;
    CBAdjust.Checked  :=AdjustFrame;

    CBCustPos.Checked :=CustomPosition;

    Old:=CreatingForm;
    CreatingForm:=True;
    UDLeft.Position   :=Left;
    UDTop.Position    :=Top;
    CreatingForm:=Old;

    EnableCustomPosition;

    AssigningText:=True;
    MText.Lines:=Text;
    AssigningText:=False;
  end;
  ITeeObject.RefreshControls(TheTitle);
end;

Procedure TFormTeeTitle.EnableCustomPosition;
var tmp : Boolean;
    Old : Boolean;
begin
  Old:=CreatingForm;
  CreatingForm:=True;
  tmp:=TheTitle.CustomPosition;
  ECustLeft.Enabled :=tmp;
  ECustTop.Enabled  :=tmp;
  UDLeft.Enabled    :=tmp;
  UDTop.Enabled     :=tmp;
  if tmp then
  begin
    UDLeft.Position :=TheTitle.Left;
    UDTop.Position  :=TheTitle.Top;
  end;
  CreatingForm:=Old;
end;

procedure TFormTeeTitle.FormShow(Sender: TObject);
begin
  if Assigned(TheTitle) then
  begin
    if TheTitle=TheChart.Title    then CBTitles.ItemIndex:=0 else
    if TheTitle=TheChart.SubTitle then CBTitles.ItemIndex:=1 else
    if TheTitle=TheChart.SubFoot  then CBTitles.ItemIndex:=2 else
                                       CBTitles.ItemIndex:=3;
    SetTitleControls;
  end;
  CreatingForm:=False;
end;

procedure TFormTeeTitle.CBVisibleClick(Sender: TObject);
begin
  TheTitle.Visible:=CBVisible.Checked;
end;

procedure TFormTeeTitle.MTextChange(Sender: TObject);
begin
  if not AssigningText then
  With TheTitle do
  if not Text.Equals(MText.Lines) then Text:=MText.Lines;
end;

procedure TFormTeeTitle.CBAdjustClick(Sender: TObject);
begin
  TheTitle.AdjustFrame:=CBAdjust.Checked;
end;

procedure TFormTeeTitle.CBTitlesChange(Sender: TObject);
begin
  Case CBTitles.ItemIndex of
    0: TheTitle:=TheChart.Title;
    1: TheTitle:=TheChart.SubTitle;
    2: TheTitle:=TheChart.SubFoot;  { 5.02 }
    3: TheTitle:=TheChart.Foot;
  end;
  SetTitleControls;
end;

procedure TFormTeeTitle.CBCustPosClick(Sender: TObject);
begin
  TheTitle.CustomPosition:=CBCustPos.Checked;
  EnableCustomPosition;
end;

procedure TFormTeeTitle.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeFormBorderStyle;
  PageControlTitle.ActivePage:=TabSheet1;
end;

Function TFormTeeTitle.CanChangeCust:Boolean;
begin
  result:=(not CreatingForm) and Assigned(TheTitle) and TheTitle.CustomPosition;
end;

procedure TFormTeeTitle.ECustLeftChange(Sender: TObject);
begin
  if CanChangeCust and (TheTitle.Left<>UDLeft.Position) then
        TheTitle.Left:=UDLeft.Position;
end;

procedure TFormTeeTitle.ECustTopChange(Sender: TObject);
begin
  if CanChangeCust and (TheTitle.Top<>UDTop.Position) then
        TheTitle.Top:=UDTop.Position;
end;

procedure TFormTeeTitle.CBAlignChange(Sender: TObject);
begin
  With TheTitle do
  Case CBAlign.ItemIndex of
    0: Alignment:=taLeftJustify;
    1: Alignment:=taCenter;
    2: Alignment:=taRightJustify;
  end;
end;

end.
