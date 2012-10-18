{******************************************}
{ TDBChart Component                       }
{ Copyright (c) 1995-2004 by David Berneda }
{ All rights Reserved                      }
{******************************************}
unit DBChart;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QMenus, QForms, QDialogs, QExtCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Menus, Forms, Dialogs, ExtCtrls, StdCtrls,
  {$ENDIF}
  Chart, DB, TeeProcs, TeCanvas, TeEngine;

type
  DBChartException=class(Exception);

  TTeeDBGroup=(dgHour,dgDay,dgWeek,dgWeekDay,dgMonth,dgQuarter,dgYear,dgNone);

  TListOfDataSources=class(TList)
  private
    procedure Put(Index:Integer; Value:TDataSource);
    function Get(Index:Integer):TDataSource;
  public
    Procedure Clear; override;
    property DataSource[Index:Integer]:TDataSource read Get write Put; default;
  end;

  TCustomDBChart=class;

  TProcessRecordEvent=Procedure(Sender:TCustomDBChart; DataSet:TDataSet) of object;

  TCustomDBChart = class(TCustomChart)
  private
    FAutoRefresh     : Boolean;
    FRefreshInterval : Integer;
    FShowGlassCursor : Boolean;
    FOnProcessRecord : TProcessRecordEvent;
    { internal }
    IUpdating        : Boolean;
    ITimer           : TTimer;
    IDataSources     : TListOfDataSources;
    Procedure DataSourceCheckDataSet(ADataSet:TDataSet);
    Procedure DataSourceCloseDataSet(ADataSet:TDataSet);
    Procedure CheckDataSet(ADataSet:TDataSet; ASeries:TChartSeries=nil);
    Procedure CheckNewDataSource(ADataSet:TDataSet; SingleRow:Boolean);
    Procedure SetRefreshInterval(Value:Integer);
    Procedure CheckTimer;
    Procedure OnRefreshTimer(Sender:TObject);
  protected
    procedure RemovedDataSource( ASeries: TChartSeries;
                                 AComponent: TComponent ); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure Assign(Source:TPersistent); override;
    Procedure CheckDatasource(ASeries:TChartSeries); override;
    Function IsValidDataSource(ASeries:TChartSeries; AComponent:TComponent):Boolean; override;

    Procedure FillValueSourceItems( AValueList:TChartValueList; Proc:TGetStrProc); override;
    Procedure FillSeriesSourceItems( ASeries:TChartSeries; Proc:TGetStrProc); override;

    Procedure RefreshDataSet(ADataSet:TDataSet; ASeries:TChartSeries);
    Procedure RefreshData;
    { properties }
    property AutoRefresh:Boolean read FAutoRefresh write FAutoRefresh default True;
    property RefreshInterval:Integer read FRefreshInterval write SetRefreshInterval default 0;
    property ShowGlassCursor:Boolean read FShowGlassCursor write FShowGlassCursor default True;
    { events }
    property OnProcessRecord:TProcessRecordEvent read FOnProcessRecord
                                                 write FOnProcessRecord;
  published
  end;

  TDBChart=class(TCustomDBChart)
  published
    { TCustomDBChart properties }
    property AutoRefresh;
    property RefreshInterval;
    property ShowGlassCursor;
    { TCustomDBChart events }
    property OnProcessRecord;

    { TCustomChart Properties }
    property AllowPanning;
    property BackImage;
    property BackImageInside;
    property BackImageMode;
    property BackImageTransp;
    property BackWall;
    property Border;
    property BorderRound;
    property BottomWall;
    property Foot;
    property Gradient;
    property LeftWall;
    property MarginBottom;
    property MarginLeft;
    property MarginRight;
    property MarginTop;
    property MarginUnits;
    property PrintProportional;
    property RightWall;
    property SubFoot;
    property SubTitle;
    property Title;

    { TCustomChart Events }
    property OnAllowScroll;
    property OnClickAxis;
    property OnClickBackground;
    property OnClickLegend;
    property OnClickSeries;
    property OnClickTitle;
    property OnGetLegendPos;
    property OnGetLegendRect;
    property OnScroll;
    property OnUndoZoom;
    property OnZoom;

    { TCustomAxisPanel properties }
    property AxisBehind;
    property AxisVisible;
    property BottomAxis;
    property Chart3DPercent;
    property ClipPoints;
    property CustomAxes;
    property DepthAxis;
    property DepthTopAxis;
    property Frame;
    property LeftAxis;
    property Legend;
    property MaxPointsPerPage;
    property Monochrome;
    property Page;
    property RightAxis;
    property ScaleLastPage;
    property SeriesList;
    property Shadow;
    property TopAxis;
    property View3D;
    property View3DOptions;
    property View3DWalls;
    property Zoom;

    { TCustomAxisPanel events }
    property OnAfterDraw;
    property OnBeforeDrawAxes;
    property OnBeforeDrawChart;
    property OnBeforeDrawSeries;
    property OnGetAxisLabel;
    property OnGetLegendText;
    property OnGetNextAxisLabel;
    property OnPageChange;

    { TPanel properties }
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;

    {$IFDEF CLX}
    property Bitmap;
    {$ENDIF}

    property BorderWidth;
    property Color;
    {$IFNDEF CLX}
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property Locked;
    {$ENDIF}

    { TPanel events }
    property OnClick;
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    {$IFNDEF CLX}
    property OnCanResize;
    {$ENDIF}
    property OnConstrainedResize;
    {$IFNDEF CLX}
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}

    {$IFDEF K3}
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
  end;

  TTeeFieldType=(tftNumber,tftDateTime,tftText,tftNone);

{ given a VCL "database field type", this function returns
  a more simplified "type": (number, date, text) }
Function TeeFieldType(AType:TFieldType):TTeeFieldType;

{ Returns the ISO- Week number (from 1 to 52) of a given "ADate" parameter,
  and decrements "Year" if it's the first week of the year. }
Function DateToWeek(ADate:TDateTime; Var Year:Word):Integer;

{ same as DateToWeek, using a different algorithm
  (compatible with TeeChart version 4 }
Function DateToWeekOld(Const ADate:TDateTime; Var Year:Word):Integer;

{ internal, used by DBChart Summary feature }
Function TeeGetDBPart(Num:Integer; St:String):String;
Function StrToDBGroup(St:String):TTeeDBGroup;
Function StrToDBOrder(St:String):TChartListOrder;

type
  TCheckDataSetEvent=procedure(DataSet:TDataSet) of object;

  TDBChartDataSource=class(TDataSource)
  private
    FDBChart   : TCustomDBChart;
    FWasActive : Boolean;
    Procedure DataSourceRowChange(Sender:TObject; Field:TField);
    Procedure DataSourceStateChange(Sender:TObject);
    Procedure DataSourceUpdateData(Sender:TObject);
  protected
    OnCheckDataSet : TCheckDataSetEvent;
    OnCloseDataSet : TCheckDataSetEvent;
    Procedure SetDataSet(Value:TDataSet; SingleRow:Boolean=False);
  end;

Procedure FillDataSetFields(DataSet:TDataSet; Proc:TGetStrProc);

implementation

Uses TeeConst, TypInfo;

{$IFDEF CLR}
type
  TBookMark=IntPtr;  // Pending fix in Borland.VclDBRtl.dll
{$ENDIF}

{ TDBChartDataSource }
Procedure TDBChartDataSource.SetDataSet(Value:TDataSet; SingleRow:Boolean=False);
Begin
  DataSet:=Value;
  FWasActive:=DataSet.Active;

  {$IFDEF CLR}
  Include(OnStateChange,DataSourceStateChange);
  Include(OnUpdateData,DataSourceUpdateData);
  if SingleRow then Include(OnDataChange,DataSourceRowChange);

  {$ELSE}

  OnStateChange:=DataSourceStateChange;
  OnUpdateData:=DataSourceUpdateData;
  if SingleRow then OnDataChange:=DataSourceRowChange;
  {$ENDIF}
end;

Procedure TDBChartDataSource.DataSourceRowChange(Sender:TObject; Field:TField);
begin
  if Assigned(FDBChart) then
     if not FDBChart.IUpdating then
        With TDBChartDataSource(Sender) do OnCheckDataSet(DataSet);
end;

Procedure TDBChartDataSource.DataSourceUpdateData(Sender:TObject);
Begin
  With TDBChartDataSource(Sender) do
  if State= {$IFDEF CLR}TDataSetState.{$ENDIF}dsBrowse then OnCheckDataSet(DataSet)
                    else FWasActive:=False;
End;

Procedure TDBChartDataSource.DataSourceStateChange(Sender:TObject);
Begin
  With TDBChartDataSource(Sender) do
  if State={$IFDEF CLR}TDataSetState.{$ENDIF}dsInactive then
  Begin
    FWasActive:=False;
    if Assigned(OnCloseDataSet) then OnCloseDataSet(DataSet);
  end
  else
  if (State={$IFDEF CLR}TDataSetState.{$ENDIF}dsBrowse) and (not FWasActive) then
  Begin
    OnCheckDataSet(DataSet);
    FWasActive:=True;
  end;
end;

{ TListOfDataSources }
Procedure TListOfDataSources.Clear;
var t : Integer;
begin
  for t:=0 to Count-1 do DataSource[t].Free;
  inherited;
end;

procedure TListOfDataSources.Put(Index:Integer; Value:TDataSource);
begin
  inherited Items[Index]:=Value;
end;

function TListOfDataSources.Get(Index:Integer):TDataSource;
begin
  result:=TDataSource(inherited Items[Index]);
end;

{ TDBChart }
Constructor TCustomDBChart.Create(AOwner: TComponent);
begin
  inherited;
  IDataSources:=TListOfDataSources.Create;
  FAutoRefresh:=True;
  FShowGlassCursor:=True;
  ITimer:=nil;
  IUpdating:=False;
end;

Destructor TCustomDBChart.Destroy;
begin
  ITimer.Free;
  IDataSources.Free;
  inherited;
end;

// When "AComponent" source is removed from ASeries DataSourceList,
// this method also removes AComponent from internal IDataSources list.
procedure TCustomDBChart.RemovedDataSource( ASeries: TChartSeries;
                                            AComponent: TComponent );
var t   : Integer;
    tmp : TDataSet;
begin
  inherited;

  if AComponent is TDataSet then
  for t:=0 to IDataSources.Count-1 do
  begin
    tmp:=IDataSources[t].DataSet;
    if (not Assigned(tmp)) or (tmp=AComponent) then
    begin
      IDataSources[t].Free;
      IDataSources.Delete(t);
      break;
    end;
  end;
end;

Procedure TCustomDBChart.CheckTimer;
Begin
  if Assigned(ITimer) then ITimer.Enabled:=False;
  if (FRefreshInterval>0) and (not (csDesigning in ComponentState) ) then
  Begin
    if not Assigned(ITimer) then
    Begin
      ITimer:=TTimer.Create(Self);
      ITimer.Enabled:=False;
      ITimer.OnTimer:=OnRefreshTimer;
    end;
    ITimer.Interval:=FRefreshInterval*1000;
    ITimer.Enabled:=True;
  end;
End;

Procedure TCustomDBChart.OnRefreshTimer(Sender:TObject);
var t : Integer;
Begin
  ITimer.Enabled:=False;  { no try..finally here ! }
  for t:=0 to IDataSources.Count-1 do
  With IDataSources[t] do
  if DataSet.Active then
  Begin
    DataSet.Refresh;
    CheckDataSet(DataSet);
  end;
  ITimer.Enabled:=True;
end;

Procedure TCustomDBChart.SetRefreshInterval(Value:Integer);
Begin
  if (Value<0) or (Value>60) then
     Raise DBChartException.Create(TeeMsg_RefreshInterval);
  FRefreshInterval:=Value;
  CheckTimer;
End;

Function TCustomDBChart.IsValidDataSource(ASeries:TChartSeries; AComponent:TComponent):Boolean;
Begin
  result:=inherited IsValidDataSource(ASeries,AComponent);
  if not Result then result:=(AComponent is TDataSet) or (AComponent is TDataSource);
end;

Procedure TCustomDBChart.CheckNewDataSource(ADataSet:TDataSet; SingleRow:Boolean);
Var tmpDataSource : TDBChartDataSource;
Begin
  if IDataSources.IndexOf(ADataSet)=-1 then
  begin
    tmpDataSource:=TDBChartDataSource.Create(nil); { 5.02 }
    With tmpDataSource do
    begin
      SetDataSet(ADataSet,SingleRow);
      OnCheckDataSet:=DataSourceCheckDataSet;
      OnCloseDataSet:=DataSourceCloseDataSet;
    end;
    IDataSources.Add(tmpDataSource);
  end;
end;

Procedure TCustomDBChart.CheckDatasource(ASeries:TChartSeries);
Begin
  if Assigned(ASeries) then
  With ASeries do
    if ParentChart=Self then
    Begin
      if Assigned(DataSource) then
      Begin
        ASeries.Clear;
        if DataSource is TDataSet then
        Begin
          CheckNewDataSource(TDataSet(DataSource),False);
          CheckDataSet(TDataSet(DataSource),ASeries);
        end
        else
        if (DataSource is TDataSource) and Assigned(TDataSource(DataSource).DataSet) then
        begin
          CheckNewDataSource(TDataSource(DataSource).DataSet,True);
          CheckDataSet(TDataSource(DataSource).DataSet,ASeries);
        end
        else inherited;
      end
      else inherited;
    end
    else Raise ChartException.Create(TeeMsg_SeriesParentNoSelf);
end;

Procedure TCustomDBChart.CheckDataSet(ADataSet:TDataSet; ASeries:TChartSeries=nil);
Begin
  if FAutoRefresh then RefreshDataSet(ADataSet,ASeries);
end;

Procedure TCustomDBChart.DataSourceCheckDataSet(ADataSet:TDataSet);
begin
  CheckDataSet(ADataSet);
end;

Procedure TCustomDBChart.DataSourceCloseDataSet(ADataSet:TDataSet);
var t : Integer;
begin
  if FAutoRefresh then
     for t:=0 to SeriesCount-1 do
         if Series[t].DataSource=ADataSet then Series[t].Clear;
end;

type TValueListAccess=class(TChartValueList);

     TDBChartAgg=(dcaNone, dcaSum, dcaCount, dcaHigh, dcaLow, dcaAverage);
     TDBChartSeries=packed record
        ASeries     : TChartSeries;
        YManda      : Boolean;
        MandaList   : TChartValueList;
        LabelSort   : TChartListOrder;
        LabelField  : TField;
        ColorField  : TField;
        MandaField  : TField;
        NumFields   : Integer;
        GroupPrefix : TTeeDBGroup;
        AggPrefix   : TDBChartAgg;
     end;

     TDBChartSeriesList=Array of TDBChartSeries;

Procedure TCustomDBChart.RefreshDataSet(ADataSet:TDataSet; ASeries:TChartSeries);
Var HasAnyDataSet : Boolean;

  Procedure ProcessRecord(const tmpSeries:TDBChartSeries);
  var tmpxLabel : String;
      tmpColor  : TColor;
      tmpNotMand: Double;
      tmpMand   : Double;

    Procedure AddToSeries(const DestSeries:TDBChartSeries);
    Var t        : Integer;
        tmpIndex : Integer;
    begin
      With DestSeries do
      if AggPrefix<>dcaNone then
      begin
        tmpIndex:=ASeries.Labels.IndexOfLabel(tmpXLabel);

        if tmpIndex=-1 then { new point }
        begin
          if AggPrefix=dcaCount then tmpMand:=1
          else
          if AggPrefix=dcaAverage then tmpColor:=1;

          ASeries.Add(tmpMand,tmpXLabel,tmpColor);
        end
        else { existing point, do aggregation }
        With MandaList do
        Case AggPrefix of
          dcaSum:   Value[tmpIndex]:=Value[tmpIndex]+tmpMand;
          dcaCount: Value[tmpIndex]:=Value[tmpIndex]+1;
          dcaHigh:  if tmpMand>Value[tmpIndex] then Value[tmpIndex]:=tmpMand;
          dcaLow:   if tmpMand<Value[tmpIndex] then Value[tmpIndex]:=tmpMand;
          dcaAverage: begin
                        Value[tmpIndex]:=Value[tmpIndex]+tmpMand;
                        { trick: use the color as temporary count for average }
                        ASeries.ValueColor[tmpIndex]:=ASeries.ValueColor[tmpIndex]+1;
                      end;
        end;
      end
      else
      With DestSeries.ASeries do
      begin
        With ValuesList do
        for t:=2 to Count-1 do
            {$IFDEF CLR}
            if Assigned(TValueListAccess(ValueList[t]).IData) then
               TValueListAccess(ValueList[t]).TempValue:=TField(TValueListAccess(ValueList[t]).IData).AsFloat
            else
               TValueListAccess(ValueList[t]).TempValue:=0;
            {$ELSE}
            With TValueListAccess(ValueList[t]) do
            if Assigned(IData) then TempValue:=TField(IData).AsFloat
                               else TempValue:=0;
            {$ENDIF}

        if NotMandatoryValueList.ValueSource='' then
           if YManda then
              AddY(tmpMand,tmpXLabel,tmpColor)
           else
              AddX(tmpMand,tmpXLabel,tmpColor)
        else
           if YManda then { 5.01 }
              AddXY(tmpNotMand,tmpMand,tmpXLabel,tmpColor)
           else
              AddXY(tmpMand,tmpNotMand,tmpXLabel,tmpColor);
      end;
    end;

    Function GetFieldValue(AField:TField):Double;
    begin
      {$IFDEF CLR}
      result:=AField.AsFloat;
      {$ELSE}
      With AField do
      if FieldKind=fkAggregate then result:=Value
                               else result:=AsFloat;
      {$ENDIF}
    end;

    Procedure AddSingleRecord;
    var t       : Integer;
        tmpName : String;
    begin
      With tmpSeries do
      for t:=1 to NumFields do
      begin
        tmpName:=TeeExtractField(MandaList.ValueSource,t);
        if ASeries.XLabelsSource='' then tmpXLabel:=tmpName;

        if tmpName='' then
           tmpMand:=0
        else
           tmpMand:=GetFieldValue(ADataSet.FieldByName(tmpName));

        AddToSeries(tmpSeries);
      end;
    end;

    Function CalcXPos:String; { from DateTime to Label }
    var Year    : Word;
        Month   : Word;
        Day     : Word;
        Hour    : Word;
        Minute  : Word;
        Second  : Word;
        MSecond : Word;
    begin
      result:='';
      DecodeDate(tmpNotMand,Year,Month,Day);
      Case tmpSeries.GroupPrefix of
       dgHour: begin
                 DecodeTime(tmpNotMand,Hour,Minute,Second,MSecond);
                 result:=FormatDateTime('dd hh:nn',Trunc(tmpNotMand)+Hour/24.0);  // 5.02
               end;
        dgDay: result:=FormatDateTime('dd/MMM',Trunc(tmpNotMand)); // 5.02
       dgWeek: result:=TeeStr(DateToWeek(tmpNotMand,Year))+'/'+TeeStr(Year);
    dgWeekDay: result:=ShortDayNames[DayOfWeek(tmpNotMand)];
      dgMonth: result:=FormatDateTime('MMM/yy',EncodeDate(Year,Month,1));
    dgQuarter: result:=TeeStr(1+((Month-1) div 3))+'/'+TeeStr(Year); // 5.02
       dgYear: result:=FormatDateTime('yyyy',EncodeDate(Year,1,1));
      end;
    end;

  var tmpData : TObject;
  Begin
    With tmpSeries do
    Begin
      if GroupPrefix=dgNone then
         if Assigned(LabelField) then tmpXLabel:=LabelField.DisplayText
                                 else tmpXLabel:=''
      else
      begin
        tmpNotMand:=LabelField.AsFloat;
        tmpXLabel:=CalcXPos;
      end;

      if AggPrefix<>dcaNone then tmpColor:=clTeeColor
      else
      if Assigned(ColorField) then
         tmpColor:=ColorField.AsInteger
      else
      {$IFNDEF CLX} // CLX limitation
      if Assigned(MandaField) and MandaField.IsNull then
         tmpColor:=clNone
      else
      {$ENDIF}
         tmpColor:=clTeeColor;

      if NumFields=1 then
      begin
        if (not HasAnyDataSet) and (not Assigned(LabelField)) then
           tmpXLabel:=MandaList.ValueSource;

        tmpData:=TValueListAccess(ASeries.NotMandatoryValueList).IData;

        if Assigned(tmpData) then
           tmpNotMand:=TField(tmpData).AsFloat
//           ADataSet.GetFieldData(TField(tmpData), @tmpNotMand)  // v7 speed opt.
        else
           tmpNotMand:=0;

        if Assigned(MandaField) then tmpMand:=GetFieldValue(MandaField)
                                else tmpMand:=0;

        // add summary point
        AddToSeries(tmpSeries);
      end
      else AddSingleRecord
    end;
  end;

Var FListSeries : TDBChartSeriesList;

  Procedure FillTempSeriesList;

   Function GetDataSet(ASeries:TChartSeries):TDataSet;
   begin
     With ASeries do
     if DataSource is TDataSet then result:=TDataSet(DataSource)
     else
     if DataSource is TDataSource then
        result:=TDataSource(DataSource).DataSet
     else
        result:=nil;
   end;

   Function IsDataSet(ASeries:TChartSeries):Boolean;
   var tmp : TDataSet;
   begin
     tmp:=GetDataSet(ASeries);
     if Assigned(tmp) then
     begin
       result:=tmp=ADataSet;
       HasAnyDataSet:=ASeries.DataSource is TDataSet;
     end
     else result:=False;
   end;

   Procedure AddList(tmpSeries:TChartSeries);
   var tmp : TDataSet;

      Function GetAField(Const FieldName:String):TField;
      begin
        if FieldName='' then result:=nil
                        else result:=tmp.FieldByName(FieldName);
      end;

      Function GetAFieldPrefix(St:String; Var Prefix:String):TField;
      begin
        Prefix:=TeeGetDBPart(1,St);
        if Prefix<>'' then St:=TeeGetDBPart(2,St);
        result:=GetAField(St);
      end;

   var t        : Integer;
       tmpAgg   : String;
       tmpGroup : String;
       {$IFNDEF CLR}
       tmpV     : TValueListAccess;
       {$ENDIF}
   begin
     SetLength(FListSeries,Length(FListSeries)+1);
     With FListSeries[Length(FListSeries)-1] do
     begin
       ASeries   :=tmpSeries;
       YManda    :=ASeries.YMandatory;
       MandaList :=ASeries.MandatoryValueList;
       NumFields :=TeeNumFields(MandaList.ValueSource);

       tmp:=GetDataSet(ASeries);

       if Assigned(tmp) then
       With ASeries do
       begin
         LabelField:=GetAFieldPrefix(XLabelsSource,tmpGroup);

         // try to find #SORTASC# or #SORTDESC# in label grouping
         LabelSort:=StrToDBOrder(tmpGroup);
         if LabelSort=loNone then
            GroupPrefix:=StrToDBGroup(tmpGroup) // find #HOUR# etc
         else
            GroupPrefix:=dgNone;

         ColorField:=GetAField(ColorSource);
         MandaField:=GetAFieldPrefix(TeeExtractField(MandaList.ValueSource,1),tmpAgg);

         if tmpAgg<>'' then
         begin
           tmpAgg:=UpperCase(tmpAgg);
           if tmpAgg='SUM'   then AggPrefix:=dcaSum else
           if tmpAgg='COUNT' then AggPrefix:=dcaCount else
           if tmpAgg='HIGH'  then AggPrefix:=dcaHigh else
           if tmpAgg='LOW'   then AggPrefix:=dcaLow else
           if tmpAgg='AVG'   then AggPrefix:=dcaAverage else
                                  AggPrefix:=dcaNone;
         end
         else
         begin
           AggPrefix:=dcaNone;
           for t:=0 to ValuesList.Count-1 do
           begin
             {$IFDEF CLR}
             if ValuesList[t]<>MandaList then
                TValueListAccess(ValuesList[t]).IData:=GetAField(ValuesList[t].ValueSource);
             {$ELSE}
             tmpV:=TValueListAccess(ValuesList[t]);
             if tmpV<>MandaList then tmpV.IData:=GetAField(tmpV.ValueSource);
             {$ENDIF}
           end;
         end;
       end;
     end;
   end;

  var t         : Integer;
      tmpSeries : TChartSeries;
  begin
    FListSeries:=nil;
    if Assigned(ASeries) then
    begin
      AddList(ASeries);
      HasAnyDataSet:=ASeries.DataSource=ADataSet;
    end
    else
    for t:=0 to SeriesCount-1 do
    Begin
      tmpSeries:=Series[t];
      if IsDataSet(tmpSeries) and
         (tmpSeries.MandatoryValueList.ValueSource<>'') then
            AddList(tmpSeries);
    end;
  end;

  Procedure TraverseDataSet;
  Var b : TBookMark;
      t : Integer;
      tt: Integer;
  begin
    With ADataSet do
    begin
      DisableControls;
      try
        b:=GetBookMark;
        try
          First;
          While not EOF do
          try
            if Assigned(FOnProcessRecord) then FOnProcessRecord(Self,ADataSet);
            for t:=0 to Length(FListSeries)-1 do
                if FListSeries[t].ASeries.DataSource=ADataSet then
                   ProcessRecord(FListSeries[t]);
            Next;
          except
            on EAbort do break; { <-- exit while loop !!! }
          end;

          for t:=0 to Length(FListSeries)-1 do
          With FListSeries[t] do
          begin
            if AggPrefix=dcaAverage then
            begin
              for tt:=0 to ASeries.Count-1 do
              begin
                MandaList.Value[tt]:=MandaList.Value[tt]/ASeries.ValueColor[tt];
                ASeries.ValueColor[tt]:=clTeeColor;
              end;
            end;

            if (AggPrefix<>dcaNone) and (LabelSort<>loNone) then
               ASeries.SortByLabels(LabelSort);
          end;
        finally
          try
            GotoBookMark(b);
          finally
            FreeBookMark(b);
          end;
        end;
      finally
        EnableControls;
      end;
    end;
  end;

Var OldCursor : TCursor;
    t         : Integer;
    OldPaint  : Boolean;
Begin
  if not IUpdating then
  With ADataSet do
  if Active then
  Begin
    IUpdating:=True;
    FListSeries:=nil;
    HasAnyDataSet:=False;
    try
      FillTempSeriesList;
      if Length(FListSeries)>0 then
      Begin
        OldCursor:=Screen.Cursor;
        if FShowGlassCursor then Screen.Cursor:=crHourGlass;

        OldPaint:=AutoRepaint;
        AutoRepaint:=False;
        try
          for t:=0 to Length(FListSeries)-1 do
              FListSeries[t].ASeries.Clear;
          if HasAnyDataSet then TraverseDataSet
          else
          begin
            {$IFDEF TEEOCX}
            ADataSet.Resync([]);
            {$ENDIF}
            if Assigned(FOnProcessRecord) then FOnProcessRecord(Self,ADataSet);
            for t:=0 to Length(FListSeries)-1 do
                if TDataSource(FListSeries[t].ASeries.DataSource).DataSet=ADataSet then
                begin
                  ProcessRecord(FListSeries[t]);
                end;
          end;

          for t:=0 to Length(FListSeries)-1 do
          begin
            FListSeries[t].ASeries.CheckOrder;
            FListSeries[t].ASeries.RefreshSeries;
          end;
        finally
          AutoRepaint:=OldPaint;
          Invalidate;
          if FShowGlassCursor then Screen.Cursor:=OldCursor;
        end;
      end;
    finally
      FListSeries:=nil;
      IUpdating:=False;
    end;
  end;
end;

Procedure TCustomDBChart.RefreshData;
var t : Integer;
Begin
  for t:=0 to IDataSources.Count-1 do
      RefreshDataSet(IDataSources[t].DataSet,nil);
End;

Procedure FillDataSetFields(DataSet:TDataSet; Proc:TGetStrProc);
var t : Integer;
begin
  with DataSet do
  begin
    if FieldCount > 0 then
       for t:=0 to FieldCount-1 do Proc(Fields[t].FieldName)
    else
    Begin
      FieldDefs.Update;
      for t:=0 to FieldDefs.Count-1 do Proc(FieldDefs[t].Name);
    end;
  end;
end;

Procedure TCustomDBChart.FillSeriesSourceItems(ASeries:TChartSeries; Proc:TGetStrProc);
Begin
  With ASeries do
  if Assigned(DataSource) then
  begin
    if DataSource is TDataSource then
       FillDataSetFields(TDataSource(DataSource).DataSet,Proc)
    else
    if DataSource is TDataSet then
       FillDataSetFields(TDataSet(DataSource),Proc);
  end;
end;

Procedure TCustomDBChart.FillValueSourceItems(AValueList:TChartValueList; Proc:TGetStrProc);
Begin
  With AValueList.Owner do
  if Assigned(DataSource) then
  Begin
    if (DataSource is TDataSet) or (DataSource is TDataSource) then
       FillSeriesSourceItems(AValueList.Owner,Proc)
    else
       inherited;
  end;
end;

Procedure TCustomDBChart.Assign(Source:TPersistent);
begin
  if Source is TCustomDBChart then
  With TCustomDBChart(Source) do
  begin
    Self.AutoRefresh    :=AutoRefresh;
    Self.RefreshInterval:=RefreshInterval;
    Self.ShowGlassCursor:=ShowGlassCursor;
  end;
  inherited;
end;

{ 5.01 Reported by : Timo Goebel <timo.goebel@pipedoc.de> }
Function DateToWeek(ADate:TDateTime; Var Year:Word):Integer;
const FirstWeekDay  = 2;  // 2: Monday (ISO-8601)
      FirstWeekDate = 4; // 4: First four day-week (ISO-8601)
var Month : Word;
    Day   : Word;
begin
  ADate:=ADate-((DayOfWeek(ADate)-FirstWeekDay+7) mod 7)+ 7-FirstWeekDate;
  DecodeDate(ADate,Year,Month,Day);
  Result:=(Trunc(ADate-EncodeDate(Year,1,1)) div 7)+1;
end;

Function DateToWeekOld(Const ADate:TDateTime; Var Year:Word):Integer;
Const FirstDay=0; { Monday }
Var d,m,y,j,j0,j1,Week : Word;
begin
  DecodeDate(ADate,y,m,d);
  if (m < 3) then
    j := 1461*(y-1) div 4 + (153*(m+9)+2) div 5 + d
  else
    j := 1461*y div 4 + (153*(m-3)+2) div 5 + d;

  j0:=1461*(y-1) DIV 4 + 310;
  j0:=j0-(j0-FirstDay) MOD 7;

  If (j<j0) then
  begin
    j0 := 1461*(y-2) DIV 4 + 310;
    j0 := j0 - (j0-FirstDay) MOD 7;
    Week:=1 + (j-j0) DIV 7;
    Year:=y-1;
  end
  else
  begin
    j1 := 1461*y div 4 + 310;
    j1 := j1 - (j1-FirstDay) mod 7;
    if j<j1 then
    begin
      Week:=1 + (j-j0) div 7;
      Year:=y;
    end
    else
    begin
      Week:=1;
      Year:=y+1;
    end;
  end;
  result:=Week;
End;

Function TeeFieldType(AType:TFieldType):TTeeFieldType;
begin
  // Pending fix in VCLDBRtl.dll ...
  Case AType of
    {$IFDEF CLR}TFieldType.{$ENDIF}ftAutoInc,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftCurrency,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftFloat,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftInteger,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftLargeInt,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftSmallint,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftWord,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftBCD        : result:=tftNumber;

    {$IFDEF CLR}TFieldType.{$ENDIF}ftDate,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftTime,

    {$IFDEF D7}
    {$IFDEF CLR}TFieldType.{$ENDIF}ftTimeStamp,
    {$ENDIF}

    {$IFDEF CLR}TFieldType.{$ENDIF}ftDateTime   : result:=tftDateTime;
    {$IFDEF CLR}TFieldType.{$ENDIF}ftString,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftFixedChar,
    {$IFDEF CLR}TFieldType.{$ENDIF}ftWideString : result:=tftText;
  else
    result:=tftNone;
  end;
end;

Function TeeGetDBPart(Num:Integer; St:String):String;
var i : Integer;
begin
  result:='';
  if Copy(St,1,1)='#' then
  begin
    Delete(St,1,1);
    i:=Pos('#',St);
    if i>0 then
       if Num=1 then result:=Copy(St,1,i-1)
       else
       if Num=2 then result:=Copy(St,i+1,Length(St)-i);
  end;
end;

Function StrToDBGroup(St:String):TTeeDBGroup;
begin
  St:=UpperCase(St);
  if St='HOUR' then result:=dgHour else
  if St='DAY' then result:=dgDay else
  if St='WEEK' then result:=dgWeek else
  if St='WEEKDAY' then result:=dgWeekDay else
  if St='MONTH' then result:=dgMonth else
  if St='QUARTER' then result:=dgQuarter else
  if St='YEAR' then result:=dgYear else
     result:=dgNone;
end;

Function StrToDBOrder(St:String):TChartListOrder;
begin
  St:=UpperCase(St);
  if St='SORTASC' then result:=loAscending
  else
  if St='SORTDES' then result:=loDescending
  else
     result:=loNone;
end;

end.
