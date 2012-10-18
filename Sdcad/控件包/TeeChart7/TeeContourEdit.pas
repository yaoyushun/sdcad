{**********************************************}
{   TContourSeries Editor Dialog               }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeContourEdit;
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
  TContourSeriesEditor = class(TForm)
    Button2: TButtonPen;
    Label2: TLabel;
    SEYPos: TEdit;
    CBYPosLevel: TCheckBox;
    UDYPos: TUpDown;
    GroupBox1: TGroupBox;
    CBAutoLevels: TCheckBox;
    Label4: TLabel;
    SENum: TEdit;
    UDNum: TUpDown;
    CBColorEach: TCheckBox;
    Label1: TLabel;
    SHColor: TShape;
    ELevel: TEdit;
    UDLevel: TUpDown;
    EValue: TEdit;
    bLevelPen: TButtonPen;
    cbDefaultPen: TCheckBox;
    CBSmooth: TCheckBox;
    CBInterpolate: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SENumChange(Sender: TObject);
    procedure CBYPosLevelClick(Sender: TObject);
    procedure SEYPosChange(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
    procedure CBAutoLevelsClick(Sender: TObject);
    procedure SHColorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ELevelChange(Sender: TObject);
    procedure EValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bLevelPenClick(Sender: TObject);
    procedure cbDefaultPenClick(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure CBInterpolateClick(Sender: TObject);
  private
    { Private declarations }
    Contour : TContourSeries;
    CreatingForm : Boolean;
    Grid3DForm : TCustomForm;
    
    procedure SetLevel;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeGriEd;

procedure TContourSeriesEditor.FormShow(Sender: TObject);
begin
  Contour:=TContourSeries(Tag);

  if Assigned(Contour) then
  begin

    With Contour do
    begin
      CBColorEach.Checked :=ColorEachPoint;
      CBYPosLevel.Checked :=YPositionLevel;
      SEYPos.Enabled      :=not YPositionLevel;
      UDYPos.Position     :=Round(YPosition);
      CBAutoLevels.Checked:=AutomaticLevels;
      UDNum.Position      :=NumLevels;
      UDLevel.Max         :=NumLevels-1;
      CBSmooth.Checked    :=Smoothing.Active;
      CBInterpolate.Checked:=Smoothing.Interpolate;
      CBInterpolate.Enabled:=Smoothing.Active;

      Button2.LinkPen(Pen);

      EnableControls(AutomaticLevels,[SENum,UDNum,CBColorEach]);
    end;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Contour);

    SetLevel;
  end;

  CreatingForm:=False;
end;

procedure TContourSeriesEditor.SetLevel;
var OldCreating : Boolean;
begin
  OldCreating:=CreatingForm;
  CreatingForm:=True;

  if Contour.Levels.Count>UDLevel.Position then
  With Contour.Levels[UDLevel.Position] do
  begin
    SHColor.Brush.Color:=Color;
    EValue.Text:=FormatFloat('0.###',UpToValue);
    cbDefaultPen.Checked:=DefaultPen;
    BLevelPen.Enabled:=not DefaultPen;

    if BLevelPen.Enabled then BLevelPen.LinkPen(Pen)
                         else BLevelPen.LinkPen(nil);
  end
  else BLevelPen.LinkPen(nil);

  CreatingForm:=OldCreating;
end;

procedure TContourSeriesEditor.SENumChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.NumLevels:=UDNum.Position;
    Contour.CreateAutoLevels;

    With UDLevel do
    begin
      Max:=Contour.NumLevels-1;
      ELevel.Text:=TeeStr(Position);
      SetLevel;
    end;
  end;
end;

procedure TContourSeriesEditor.CBYPosLevelClick(Sender: TObject);
begin
  Contour.YPositionLevel:=CBYPosLevel.Checked;
  SEYPos.Enabled:=not CBYPosLevel.Checked;
end;

procedure TContourSeriesEditor.SEYPosChange(Sender: TObject);
begin
  if not CreatingForm then Contour.YPosition:=UDYPos.Position;
end;

procedure TContourSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.ColorEachPoint:=CBColorEach.Checked;
    Contour.CreateAutoLevels;
    SetLevel;
  end;
end;

procedure TContourSeriesEditor.CBAutoLevelsClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.AutomaticLevels:=CBAutoLevels.Checked;
    EnableControls(Contour.AutomaticLevels,[SENum,UDNum,CBColorEach]);
  end;
end;

procedure TContourSeriesEditor.SHColorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp : TColor;
begin
  With Contour.Levels[UDLevel.Position] do
  begin
    tmp:=Color;

    if EditColorDialog(Self,tmp) then
    begin
      SHColor.Brush.Color:=tmp;
      Color:=tmp;

      if not DefaultPen then
      begin
        Pen.Color:=Color;
        bLevelPen.Invalidate;
      end;
    end;
  end;

  CBAutoLevels.Checked:=Contour.AutomaticLevels;
end;

procedure TContourSeriesEditor.ELevelChange(Sender: TObject);
begin
  if not CreatingForm and (Contour.Levels.Count>0) then
     SetLevel;
end;

procedure TContourSeriesEditor.EValueChange(Sender: TObject);
begin
  if not CreatingForm then
  begin
    Contour.Levels[UDLevel.Position].UpToValue:=StrToFloat(EValue.Text);
    CBAutoLevels.Checked:=Contour.AutomaticLevels;
  end;
end;

procedure TContourSeriesEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
  BorderStyle:=TeeBorderStyle;
end;

procedure TContourSeriesEditor.bLevelPenClick(Sender: TObject);
begin
  with Contour.Levels[UDLevel.Position] do
  begin
    cbDefaultPen.Checked:=DefaultPen;
    Color:=Pen.Color;
    SHColor.Brush.Color:=Color;
  end;
end;

procedure TContourSeriesEditor.cbDefaultPenClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    bLevelPen.Enabled:=not cbDefaultPen.Checked;

    if cbDefaultPen.Checked then
    begin
      Contour.Levels[UDLevel.Position].Pen:=nil;
      BLevelPen.LinkPen(nil);
    end
    else
       bLevelPen.LinkPen(Contour.Levels[UDLevel.Position].Pen);
  end;
end;

procedure TContourSeriesEditor.CBSmoothClick(Sender: TObject);
begin
  Contour.Smoothing.Active:=CBSmooth.Checked;
  CBInterpolate.Enabled:=CBSmooth.Checked;
end;

procedure TContourSeriesEditor.CBInterpolateClick(Sender: TObject);
begin
  Contour.Smoothing.Interpolate:=CBInterpolate.Checked;
end;

initialization
  RegisterClass(TContourSeriesEditor);
end.
