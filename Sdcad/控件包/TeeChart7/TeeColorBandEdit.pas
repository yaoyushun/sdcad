{******************************************}
{ TColorBandTool Editor Dialog             }
{ Copyright (c) 1999-2004 by David Berneda }
{******************************************}
unit TeeColorBandEdit;
{$I TeeDefs.inc}

interface

uses SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Buttons,
     {$ENDIF}
     Chart, TeeTools, TeCanvas, TeePenDlg, TeeAxisToolEdit;

type
  TColorBandToolEditor = class(TAxisToolEditor)
    BPattern: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    EStart: TEdit;
    CBStart: TCheckBox;
    Label3: TLabel;
    EEnd: TEdit;
    CBEnd: TCheckBox;
    TabSheet2: TTabSheet;
    BGradient: TButton;
    ButtonColor1: TButtonColor;
    Label4: TLabel;
    ETrans: TEdit;
    UDTrans: TUpDown;
    CBDrawBehind: TCheckBox;
    CBBeforeAxes: TCheckBox;
    Label5: TLabel;
    CBCursor: TComboFlat;
    BStart: TButtonPen;
    BEnd: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure BPatternClick(Sender: TObject);
    procedure EStartChange(Sender: TObject);
    procedure EEndChange(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure ETransChange(Sender: TObject);
    procedure CBDrawBehindClick(Sender: TObject);
    procedure CBStartClick(Sender: TObject);
    procedure CBEndClick(Sender: TObject);
    procedure CBBeforeAxesClick(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
  private
    { Private declarations }
    ColorBandTool : TColorBandTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine, TeeConst, TeeProCo, TeeBrushDlg, TeeEdiAxis, TeeEdiGrad, TeeProcs;

procedure TColorBandToolEditor.FormShow(Sender: TObject);
begin
  inherited;

  ColorBandTool:=TColorBandTool(Tag);

  if Assigned(ColorBandTool) then
  begin
    With ColorBandTool do
    begin
      EStart.Text:=FloatToStr(StartValue);
      EEnd.Text:=FloatToStr(EndValue);
      UDTrans.Position:=Transparency;
      CBDrawBehind.Checked:=DrawBehind;
      CBBeforeAxes.Checked:=DrawBehindAxes;
      CBStart.Checked:=ResizeStart;
      CBEnd.Checked:=ResizeEnd;
      BStart.LinkPen(StartLinePen);
      BEnd.LinkPen(EndLinePen);
      TeeFillCursors(CBCursor,Cursor);
    end;

    ButtonColor1.LinkProperty(ColorBandTool,'Color');
  end;
end;

procedure TColorBandToolEditor.BPatternClick(Sender: TObject);
begin
  EditChartBrush(Self,ColorBandTool.Brush);
end;

procedure TColorBandToolEditor.EStartChange(Sender: TObject);
begin
  if Showing then
     with ColorBandTool do StartValue:=StrToFloatDef(EStart.Text,StartValue);
end;

procedure TColorBandToolEditor.EEndChange(Sender: TObject);
begin
  if Showing then
     with ColorBandTool do EndValue:=StrToFloatDef(EEnd.Text,EndValue);
end;

procedure TColorBandToolEditor.BGradientClick(Sender: TObject);
begin
  EditTeeGradient(Self,ColorBandTool.Gradient);
end;

procedure TColorBandToolEditor.ETransChange(Sender: TObject);
begin
  if Showing then ColorBandTool.Transparency:=UDTrans.Position;
end;

procedure TColorBandToolEditor.CBDrawBehindClick(Sender: TObject);
begin
  ColorBandTool.DrawBehind:=CBDrawBehind.Checked;
end;

procedure TColorBandToolEditor.CBStartClick(Sender: TObject);
begin
  ColorBandTool.ResizeStart:=CBStart.Checked
end;

procedure TColorBandToolEditor.CBEndClick(Sender: TObject);
begin
  ColorBandTool.ResizeEnd:=CBEnd.Checked
end;

procedure TColorBandToolEditor.CBBeforeAxesClick(Sender: TObject);
begin
  ColorBandTool.DrawBehindAxes:=CBBeforeAxes.Checked;
end;

procedure TColorBandToolEditor.CBCursorChange(Sender: TObject);
begin
  with ColorBandTool do
       Cursor:=TeeSetCursor(Cursor,CBCursor.Items[CBCursor.ItemIndex]);
end;

initialization
  RegisterClass(TColorBandToolEditor);
end.
