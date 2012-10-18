{********************************************}
{   TVector3DSeries Editor Dialog            }
{   Copyright (c) 2002-2004 by David Berneda }
{********************************************}
unit TeeVectorEdit;
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
     Chart, TeeSurfa, TeCanvas, TeePenDlg, TeeProcs;

type
  TVectorSeriesEditor = class(TForm)
    BStart: TButtonPen;
    BEnd: TButtonPen;
    Label1: TLabel;
    Edit1: TEdit;
    UDWidth: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    UDHeight: TUpDown;
    CBStart: TCheckBox;
    CBEnd: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBStartClick(Sender: TObject);
    procedure CBEndClick(Sender: TObject);
  private
    { Private declarations }
    Vector : TVector3DSeries;
    Grid3DForm : TCustomForm;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeBrushDlg, TeEngine, TeeGriEd;

procedure TVectorSeriesEditor.FormShow(Sender: TObject);
begin
  Vector:=TVector3DSeries(Tag);

  if Assigned(Vector) then
  begin

    With Vector do
    begin
      BStart.LinkPen(StartArrow);
      BEnd.LinkPen(EndArrow);
      UDHeight.Position:=ArrowHeight;
      UDWidth.Position:=ArrowWidth;
      CBStart.Checked:=StartArrow.Color=clTeeColor;
      CBEnd.Checked:=EndArrow.Color=clTeeColor;
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Vector);
  end;
end;

procedure TVectorSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Vector.ArrowWidth:=UDWidth.Position;
end;

procedure TVectorSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Showing then Vector.ArrowHeight:=UDWidth.Position;
end;

procedure TVectorSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TVectorSeriesEditor.CBStartClick(Sender: TObject);
begin
  if CBStart.Checked then Vector.StartArrow.Color:=clTeeColor
                     else Vector.StartArrow.Color:=clBlack;
end;

procedure TVectorSeriesEditor.CBEndClick(Sender: TObject);
begin
  if CBEnd.Checked then Vector.EndArrow.Color:=clTeeColor
                   else Vector.EndArrow.Color:=clBlack;
end;

initialization
  RegisterClass(TVectorSeriesEditor);
end.
 