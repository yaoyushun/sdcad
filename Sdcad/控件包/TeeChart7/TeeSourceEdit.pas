{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeSourceEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     TeEngine, TeeProcs, TeCanvas;

type
  TBaseSourceEditor = class(TForm)
    LLabel: TLabel;
    CBSources: TComboFlat;
    BApply: TButton;
    Pan: TPanel;
    procedure CBSourcesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    TheSeries : TChartSeries;
    SkipValidation : Boolean;
    Procedure AddComponentDataSource( Const AComponent:TComponent;
                                      AItems:TStrings;
                                      AddCurrent:Boolean);
    procedure CheckReplaceSource(NewSource:TTeeSeriesSource);
    Function IsValid(AComponent:TComponent):Boolean; virtual;
  public
    { Public declarations }
  end;

  { special case for TFormDesigner in TeeCharteg unit }
  TAddComponentDataSource=Procedure( Const AComponent:TComponent;
                                     AItems:TStrings;
                                     AddCurrent:Boolean) of object;

  TOnGetDesignerNamesEvent=Procedure( AProc:TAddComponentDataSource;
                                      ASeries:TChartSeries;
                                      AItems:TStrings;
                                      AddCurrent:Boolean);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst;

Procedure TBaseSourceEditor.AddComponentDataSource( Const AComponent:TComponent;
                                                 AItems:TStrings;
                                                 AddCurrent:Boolean);
Var tmp         : String;
    tmpFormName : TComponentName;
begin
  if AItems.IndexOfObject(AComponent)=-1 then { 5.01 }
  if AddCurrent or (TheSeries.DataSources.IndexOf(AComponent)=-1) then
  if IsValid(AComponent) then
     if SkipValidation or
        TheSeries.ParentChart.IsValidDataSource(TheSeries,AComponent) then
     begin
       if AComponent is TChartSeries then
          tmp:=SeriesTitleOrName(TChartSeries(AComponent))
       else
          tmp:=AComponent.Name;

       if (TheSeries.Owner<>AComponent.Owner) and
          Assigned(AComponent.Owner) then
       begin
         tmpFormName:=AComponent.Owner.Name;
         if tmpFormName<>'' then tmp:=tmpFormName+'.'+tmp;
       end;

       AItems.AddObject(tmp,AComponent);
     end;
end;

procedure TBaseSourceEditor.CBSourcesChange(Sender: TObject);
begin
  BApply.Enabled:=True;
end;

procedure TBaseSourceEditor.FormShow(Sender: TObject);
begin
  TheSeries:=TChartSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));
  BApply.Enabled:=False;
end;

type TButtonAccess=class(TButton);

procedure TBaseSourceEditor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if BApply.Enabled then
  Case MessageDlg(TeeMsg_SureToApply,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
    mrYes: begin
             TButtonAccess(BApply).Click;
             CanClose:=not BApply.Enabled;
           end;
    mrNo: begin
            BApply.Enabled:=False;
            CanClose:=True;
          end;
    mrCancel: CanClose:=False;
  end;
end;

function TBaseSourceEditor.IsValid(AComponent: TComponent): Boolean;
begin
  result:=False;
end;

procedure TBaseSourceEditor.CheckReplaceSource(
  NewSource: TTeeSeriesSource);
var tmpSource : TTeeSeriesSource;
begin
  if TheSeries.DataSource<>NewSource then
  begin
    { if the datasource is an internal "Series Source",
      remove and free it ! }
    if Assigned(TheSeries.DataSource) and
       (TheSeries.DataSource is TTeeSeriesSource) and
       (TheSeries.DataSource.Owner=TheSeries) then
    begin
      tmpSource:=TTeeSeriesSource(TheSeries.DataSource);
      tmpSource.Series:=nil;
      tmpSource.Free;
    end;
    
    TheSeries.DataSource:=nil;

    if not Assigned(NewSource.Series) then
       NewSource.Series:=TheSeries;
       
    TheSeries.DataSource:=NewSource;
  end;
end;

procedure TBaseSourceEditor.FormCreate(Sender: TObject);
begin
  SkipValidation:=False;
  Align:=alClient;
end;

end.
