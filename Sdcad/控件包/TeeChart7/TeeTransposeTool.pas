{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeTransposeTool;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     StdCtrls,
     Forms,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls,
     {$ENDIF}
     {$ENDIF}
     TeEngine, TeeSurfa, TeCanvas;

type
  TGridTransposeTool=class(TTeeCustomTool)
  private
    FSeries : TCustom3DGridSeries;
  protected
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
    procedure Transpose;
  published
    property Active;
    property Series:TCustom3DGridSeries read FSeries write FSeries;
  end;

  TGridTransposeToolEdit = class(TForm)
    Label1: TLabel;
    CBSeries: TComboFlat;
    BTranspose: TButton;
    procedure CBSeriesChange(Sender: TObject);
    procedure BTransposeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Tool : TGridTransposeTool;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses Chart, TeeProCo;

{ TGridTransposeTool }

class function TGridTransposeTool.Description: String;
begin
  result:=TeeMsg_GridTranspose;
end;

class function TGridTransposeTool.GetEditorClass: String;
begin
  result:='TGridTransposeToolEdit';  { the editor dialog class name }
end;

procedure TGridTransposeTool.Transpose;
var t   : Integer;
    tmp : TCustom3DGridSeries;
begin
  if Active and Assigned(FSeries) then
  begin
    tmp:=TCustom3DGridSeries.Create(nil);
    try
      with FSeries do
      for t:=0 to Count-1 do
          tmp.AddXYZ(ZValues.Value[t],YValues.Value[t],XValues.Value[t]);

      FSeries.AssignValues(tmp);
    finally
      tmp.Free;
    end;
  end;
end;

{ register both the tool and the tool editor dialog form }
procedure TGridTransposeToolEdit.CBSeriesChange(Sender: TObject);
begin
  with CBSeries do
    Tool.Series:=TCustom3DGridSeries(Items.Objects[ItemIndex]);
  BTranspose.Enabled:=True;
end;

procedure TGridTransposeToolEdit.BTransposeClick(Sender: TObject);
begin
  Tool.Transpose;
end;

procedure TGridTransposeToolEdit.FormShow(Sender: TObject);
var tmp : TChartSeriesList;
    t   : Integer;
begin
  {$IFNDEF CLR}
  Tool:=TGridTransposeTool(Tag);
  {$ENDIF}

  if Assigned(Tool) and Assigned(Tool.ParentChart) then
  begin
    tmp:=Tool.ParentChart.SeriesList;

    with CBSeries do
    begin
      Items.Clear;
      for t:=0 to tmp.Count-1 do
      if tmp[t] is TCustom3DGridSeries then
          Items.AddObject(SeriesTitleOrName(tmp[t]),tmp[t]);

      ItemIndex:=Items.IndexOfObject(Tool.Series);

      BTranspose.Enabled:=ItemIndex<>-1;
    end;
  end;
end;

initialization
  RegisterClass(TGridTransposeToolEdit);
  RegisterTeeTools([TGridTransposeTool]);
finalization
  { un-register the tool }
  UnRegisterTeeTools([TGridTransposeTool]);
end.

