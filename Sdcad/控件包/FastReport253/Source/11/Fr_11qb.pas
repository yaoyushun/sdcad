{*********************************************************}
{                                                         }
{       Delphi Visual Component Library                   }
{ QBuilder is  Copyright (c) 1996-99 Sergey Orlik         }
{       www.geocities.com/SiliconValley/Way/9006/         }
{                                                         }
{---------------------------------------------------------}
{ Interface with QBuilder and FastReport 2.4              }
{ Idea : Use QB for define the SQL property               }
{ Olivier GUILBAUD                                        }
{ 18/11/1999 : Create                                     }
{*********************************************************}

unit FR_11QB;

interface

{$I FR.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, 11Query, QBuilder;


type
  TfrQB11Engine = class(TOQBEngine)
  private
    FResultQuery: T11Query;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadTableList; override;
    procedure ReadFieldList(ATableName: string); override;
    procedure ClearQuerySQL; override;
    procedure SetQuerySQL(Value: string); override;
    function ResultQuery: TDataSet; override;
    procedure OpenResultQuery; override;
    procedure CloseResultQuery; override;
    procedure SaveResultQueryData; override;
    function SelectDatabase: Boolean; override;
    procedure UpdateTableList;
  published
    property Query: T11Query read FResultQuery write FResultQuery;
  end;


implementation

uses FR_Utils, FR_Class;


{ TfrQB11Engine }

constructor TfrQB11Engine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FResultQuery := nil;
end;

destructor TfrQB11Engine.Destroy;
begin
  CloseResultQuery;
  inherited Destroy;
end;

procedure TfrQB11Engine.UpdateTableList;
begin
  ReadTableList;
end;

function TfrQB11Engine.SelectDatabase: Boolean;
begin
  Result := False;
end;

procedure TfrQB11Engine.ReadTableList;
begin
  Session.GetTableNames(DatabaseName, '', True, ShowSystemTables, TableList);
end;

procedure TfrQB11Engine.ReadFieldList(ATableName: String);
var
  i: Integer;
  Temp: T11Table;
begin
  Temp := nil;
  try
    Temp := T11Table.Create(frDialogForm);
    Temp.DataBaseName := FResultQuery.DatabaseName;
    Temp.TableName := aTableName;

    FieldList.Clear;
    FieldList.Add('*');
    Temp.FieldDefs.Update;
    for i := 0 to Temp.FieldDefs.Count - 1 do
      FieldList.Add(Temp.FieldDefs.Items[i].Name);
  finally
    Temp.Close;
    Temp.Free;
  end;
end;

procedure TfrQB11Engine.ClearQuerySQL;
begin
  FResultQuery.SQL.Clear;
end;

procedure TfrQB11Engine.SetQuerySQL(Value: String);
begin
  FResultQuery.SQL.Text := Value;
end;

function TfrQB11Engine.ResultQuery: TDataSet;
begin
  Result := FResultQuery;
end;

procedure TfrQB11Engine.OpenResultQuery;
begin
  if not FResultQuery.Prepared then
    FResultQuery.Prepare;
  FResultQuery.Active := True;
end;

procedure TfrQB11Engine.CloseResultQuery;
begin
  FResultQuery.Active := False;
end;

procedure TfrQB11Engine.SaveResultQueryData;
begin
  ShowMessage('Operation non supported.');
end;


end.

