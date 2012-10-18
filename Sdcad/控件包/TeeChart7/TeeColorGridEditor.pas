{**********************************************}
{   TColorGridSeries Editor dialog             }
{   Copyright (c) 2000-2004 by David Berneda   }
{**********************************************}
unit TeeColorGridEditor;
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
     {$IFNDEF CLX}
     ExtDlgs,
     {$ENDIF}
     TeeGriEd, TeCanvas, TeePenDlg, TeeSurfa;

type
  TColorGridEditor = class(TForm)
    BGrid: TButtonPen;
    CBCentered: TCheckBox;
    Button2: TButton;
    CBSmooth: TCheckBox;
    ButtonPen1: TButtonPen;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Edit2: TEdit;
    UDX: TUpDown;
    Label1: TLabel;
    Edit1: TEdit;
    UDZ: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBCenteredClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    Creating   : Boolean;
    ColorGrid  : TColorGridSeries;
    Grid3DForm : TGrid3DSeriesEditor;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeEngine;

procedure TColorGridEditor.FormShow(Sender: TObject);
begin
  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     ColorGrid:=TColorGridSeries(Tag);

  if Assigned(ColorGrid) then
  begin
    with ColorGrid do
    begin
      BGrid.LinkPen(Pen);
      CBCentered.Checked:=CenteredPoints;
      UDX.Position:=XGridEvery;
      UDZ.Position:=ZGridEvery;
      CBSmooth.Checked:=SmoothBitmap;
      ButtonPen1.LinkPen(Frame);

      Creating:=False;

    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TGrid3DSeriesEditor(TeeInsertGrid3DForm(Parent,ColorGrid));
  end;
end;

procedure TColorGridEditor.FormCreate(Sender: TObject);
begin
  Creating:=True;
  Align:=alClient;
end;

procedure TColorGridEditor.CBCenteredClick(Sender: TObject);
begin
  ColorGrid.CenteredPoints:=CBCentered.Checked;
end;

procedure TColorGridEditor.Button2Click(Sender: TObject);
var tmpSt : String;
    tmp   : TPicture;
begin
  tmpSt:=TeeGetPictureFileName(Self);

  if tmpSt<>'' then
  begin
    tmp:=TPicture.Create;
    try
      tmp.LoadFromFile(tmpSt);
      ColorGrid.Bitmap:=tmp.Bitmap;
      Grid3DForm.BRemove.Enabled:=HasColors(ColorGrid);
    finally
      tmp.Free;
    end;
  end;
end;

procedure TColorGridEditor.CBSmoothClick(Sender: TObject);
begin
  ColorGrid.SmoothBitmap:=CBSmooth.Checked;
end;

procedure TColorGridEditor.Edit2Change(Sender: TObject);
begin
  if not Creating then ColorGrid.XGridEvery:=UDX.Position;
end;

procedure TColorGridEditor.Edit1Change(Sender: TObject);
begin
  if not Creating then ColorGrid.ZGridEvery:=UDZ.Position;
end;

initialization
  RegisterClass(TColorGridEditor);
end.
