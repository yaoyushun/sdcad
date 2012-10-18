{**********************************************}
{   TeeChart Components - Custom Actions       }
{   Copyright (c) 2000-2004 by David Berneda   }
{        All Rights Reserved                   }
{**********************************************}
unit TeeChartActions;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QActnList,
     {$ELSE}
     ActnList,
     {$ENDIF}
     Chart, TeEngine;

type
  TCustomChartAction=class(TCustomAction)
  private
    FChart : TCustomChart;
    procedure SetChart(Value:TCustomChart);
  protected
    procedure Notification(AComponent:TComponent; Operation:TOperation); override;
  public
    function HandlesTarget(Target:TObject):Boolean; override;
  published
    property Chart:TCustomChart read FChart write SetChart;
  end;

  TChartAction=class(TCustomChartAction)
  published
    property Caption;
    property Checked;
    property Enabled;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property Visible;
    property OnExecute;
    property OnHint;
    property OnUpdate;
  end;

  TChartAction3D=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TChartActionEdit=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TChartActionCopy=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TChartActionSave=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TChartActionPrint=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TChartActionAxes=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TChartActionGrid=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TChartActionLegend=class(TChartAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TCustomSeriesAction=class(TCustomAction)
  private
    FSeries : TChartSeries;
    procedure SetSeries(Value:TChartSeries);
  protected
    procedure Notification(AComponent:TComponent; Operation:TOperation); override;
  public
    function HandlesTarget(Target:TObject):Boolean; override;
  published
    property Series:TChartSeries read FSeries write SetSeries;
  end;

  TSeriesAction=class(TCustomSeriesAction)
  published
    property Caption;
    property Checked;
    property Enabled;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property Visible;
    property OnExecute;
    property OnHint;
    property OnUpdate;
  end;

  TSeriesActionActive=class(TSeriesAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TSeriesActionEdit=class(TSeriesAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TSeriesActionMarks=class(TSeriesAction)
  public
    Constructor Create(AOwner: TComponent); override;
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

implementation

Uses TypInfo, EditChar, TeePrevi, TeeProCo, TeeEditPro, TeeEdiGene;

{ TCustomChartAction }
function TCustomChartAction.HandlesTarget(Target: TObject): Boolean;
begin
  result:=((not Assigned(FChart)) and (Target is TCustomChart)) or
         (Target=FChart);
end;

procedure TCustomChartAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (AComponent=Chart) then Chart:=nil;
end;

procedure TCustomChartAction.SetChart(Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then FChart.RemoveFreeNotification(Self); // 5.03 Thanks Rune !
    {$ENDIF} 
    FChart:=Value;
    if Assigned(FChart) then FChart.FreeNotification(Self);
  end;
end;

{ TChartAction3D }
Constructor TChartAction3D.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_Action3DHint;
  Caption:=TeeMsg_Action3D;
end;

procedure TChartAction3D.ExecuteTarget(Target: TObject);
begin
  With Target as TCustomChart do View3D:=not {$IFDEF CLX}Checked{$ELSE}View3D{$ENDIF}
end;

procedure TChartAction3D.UpdateTarget(Target: TObject);
begin
  Checked:=(Target as TCustomChart).View3D
end;

{ TCustomSeriesAction }
function TCustomSeriesAction.HandlesTarget(Target: TObject): Boolean;
begin
  result:=Assigned(Series) or (Target is TChartSeries);
end;

procedure TCustomSeriesAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (AComponent=Series) then Series:=nil;
end;

procedure TCustomSeriesAction.SetSeries(Value: TChartSeries);
begin
  if FSeries<>Value then
  begin
    FSeries:=Value;
    if Assigned(FSeries) then FSeries.FreeNotification(Self);
  end;
end;

{ TSeriesActionActive }
Constructor TSeriesActionActive.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionSeriesActiveHint;
  Caption:=TeeMsg_ActionSeriesActive;
end;

procedure TSeriesActionActive.ExecuteTarget(Target: TObject);
begin
  With Series do Active:=not Active
end;

procedure TSeriesActionActive.UpdateTarget(Target: TObject);
begin
  Checked:=Series.Active
end;

{ TChartActionEdit }
Constructor TChartActionEdit.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionEditHint;
  Caption:=TeeMsg_ActionEdit;
end;

procedure TChartActionEdit.ExecuteTarget(Target: TObject);
begin
  EditChart(nil,Target as TCustomChart);
end;

{ TChartActionCopy }

constructor TChartActionCopy.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionCopyHint;
  Caption:=TeeMsg_ActionCopy;
end;

procedure TChartActionCopy.ExecuteTarget(Target: TObject);
begin
  (Target as TCustomChart).CopyToClipboardBitmap;
end;

{ TChartActionPrint }

constructor TChartActionPrint.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionPrintHint;
  Caption:=TeeMsg_ActionPrint;
end;

procedure TChartActionPrint.ExecuteTarget(Target: TObject);
begin
  ChartPreview(nil,Target as TCustomChart);
end;

{ TChartActionAxes }

constructor TChartActionAxes.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionAxesHint;
  Caption:=TeeMsg_ActionAxes;
end;

procedure TChartActionAxes.ExecuteTarget(Target: TObject);
begin
  With (Target as TCustomChart).Axes do Visible:=not Visible
end;

procedure TChartActionAxes.UpdateTarget(Target: TObject);
begin
  Checked:=(Target as TCustomChart).Axes.Visible;
end;

{ TChartActionLegend }
constructor TChartActionLegend.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionLegendHint;
  Caption:=TeeMsg_ActionLegend;
end;

procedure TChartActionLegend.ExecuteTarget(Target: TObject);
begin
  With (Target as TCustomChart).Legend do Visible:=not Visible
end;

procedure TChartActionLegend.UpdateTarget(Target: TObject);
begin
  Checked:=(Target as TCustomChart).Legend.Visible;
end;

{ TSeriesActionEdit }
constructor TSeriesActionEdit.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionSeriesEditHint;
  Caption:=TeeMsg_ActionEdit;
end;

procedure TSeriesActionEdit.ExecuteTarget(Target: TObject);
begin
  EditSeries(nil,Series);
end;

{ TSeriesActionMarks }

constructor TSeriesActionMarks.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionSeriesMarksHint;
  Caption:=TeeMsg_ActionSeriesMarks;
end;

procedure TSeriesActionMarks.ExecuteTarget(Target: TObject);
begin
  With Series.Marks do Visible:=not Visible
end;

procedure TSeriesActionMarks.UpdateTarget(Target: TObject);
begin
  Checked:=Series.Marks.Visible;
end;

{ TChartActionSave }

constructor TChartActionSave.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionSaveHint;
  Caption:=TeeMsg_ActionSave;
end;

procedure TChartActionSave.ExecuteTarget(Target: TObject);
begin
  SaveChartDialog(Target as TCustomChart);
end;

{ TChartActionGrid }

constructor TChartActionGrid.Create(AOwner: TComponent);
begin
  inherited;
  Hint   :=TeeMsg_ActionGridsHint;
  Caption:=TeeMsg_ActionGrids;
end;

procedure TChartActionGrid.ExecuteTarget(Target: TObject);
var t : Integer;
begin
  With (Target as TCustomChart) do
  for t:=0 to Axes.Count-1 do
      With Axes[t].Grid do Visible:=not Visible
end;

procedure TChartActionGrid.UpdateTarget(Target: TObject);
var t   : Integer;
    tmp : Boolean;
begin
  tmp:=False;
  With (Target as TCustomChart) do
  for t:=0 to Axes.Count-1 do
  if Axes[t].Grid.Visible then
  begin
    tmp:=True;
    break;
  end;
  Checked:=tmp;
end;

end.
