{**********************************************}
{  TeeChart for QuickReport                    }
{  Component Registration Unit.                }
{                                              }
{  Copyright (c) 1996-2004 by David Berneda    }
{  All Rights Reserved                         }
{**********************************************}
unit TeeQRTeeReg;
{$I TeeDefs.inc}

interface

procedure Register;

implementation

Uses Classes, DBChart, TeeConst, QRTee, SysUtils, 
     {$IFDEF D6}
     DesignIntf, DesignEditors,
     {$ELSE}
     DsgnIntf, 
     {$ENDIF}
     TeeAbout,
     TeePrevi, TeEngine, TeExport, EditChar, TeeChartReg, Chart
     {$IFNDEF NOUSE_BDE}
     , DBEditCh
     {$ENDIF}
     ;

{$R TeeQRIcon.res}

type
  TQRChartCompEditor=class(TChartCompEditor)
  protected
    Function Chart:TCustomChart; override;
  end;

  TQRChartProperty=class(TClassProperty)
  public
    procedure Edit; override;
    function GetValue: string; override;
    function GetAttributes : TPropertyAttributes; override;
  end;

{ QRChart Editor }
Function TQRChartCompEditor.Chart:TCustomChart;
begin
  result:=TQRChart(Component).Chart;
end;

{ QRChart property Editor }
procedure TQRChartProperty.Edit;
begin
  EditChartDesign(TCustomChart(GetOrdValue));
  Designer.Modified;
end;

function TQRChartProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TQRChartProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

procedure Register;
begin
  RegisterNoIcon([TQRDBChart]);
  RegisterComponents( tcQReport,[TQRChart] );
  RegisterComponentEditor(TQRChart,TQRChartCompEditor);
  RegisterPropertyEditor( TypeInfo(TQRDBChart),TQRChart,'',TQRChartProperty);
  RegisterNonActiveX([TQRDBChart,TQRChart] , axrIncludeDescendants );
end;

end.
