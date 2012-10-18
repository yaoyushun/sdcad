{**********************************************}
{   TeeChart Wizard                            }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeChartExp;
{$I TeeDefs.inc}

{$IFNDEF D6}
{$UNDEF TEEENTERPRISE}  { Less than Delphi 6, No ADO ! }
{$ENDIF}

interface

uses
     {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     {$IFDEF D7}
     ToolsApi
     {$ELSE}
     ExptIntf, ToolIntf, VirtIntf, IStreams
     {$ENDIF}
     ;

type
  {$IFDEF D7}
  TTeeChartWizard=class(TNotifierObject, IOTAWizard, IOTAMenuWizard,
                        IOTAFormWizard, IOTARepositoryWizard,
                        IOTARepositoryWizard60)
  public
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    function GetDesigner: string;
    procedure Execute;
    function GetMenuText: string;
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;
    function GetGlyph: Cardinal;
  end;
  {$ELSE}
  TTeeChartWizard = class(TIExpert)
    function GetName: string; override;
    function GetAuthor: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetPage: string; override;
    procedure Execute; override;
    function GetMenuText: string; override;
  end;
  {$ENDIF}

Procedure Register;

implementation

{$R TeeChaEx.res}

uses {$IFDEF CLX}
     QForms, QControls,
     {$ELSE}
     Forms, Controls,
     {$ENDIF}
     Classes, SysUtils, Proxies,
     {$IFNDEF NOUSE_BDE}
     DB, DBTables, DBChart,
     {$IFDEF TEEENTERPRISE}
     AdoDB,
     {$ENDIF}
     {$ENDIF}
     TeeExpForm, TeeStore, TeeConst, Chart, TeeProcs, TeCanvas, TeEngine;

function DoFormCreation(Wizard: TTeeDlgWizard; const FormIdent: string): TForm;

  Procedure AddControls(AForm:TCustomForm);
  var tmpChart : TCustomChart;
      {$IFNDEF NOUSE_BDE}
      tmpTable : TDataSet;
      {$ENDIF}
      t       : Integer;
  begin
    {$IFNDEF NOUSE_BDE}
    tmpTable:=nil;
    {$ENDIF}

    tmpChart:=nil;

    with Wizard do
    {$IFNDEF NOUSE_BDE}
    if RGDatabase.ItemIndex=0 then
    begin
      if StyleBDE then
      begin
        tmpTable:=TTable.Create(AForm);
        With TTable(tmpTable) do
        begin
          DatabaseName:=CBAlias.Text;
          TableName:=CBTables.Text;
        end;
      end
      else
      begin
        {$IFDEF TEEENTERPRISE}
        tmpTable:=TADOQuery.Create(AForm);
        With TADOQuery(tmpTable) do
        begin
          ConnectionString:=ADOConn.ConnectionString;
          SQL.Assign(ADOQuery.SQL);
        end;
        {$ENDIF}
      end;

      with tmpTable do
      begin
        Left:=12;
        Top:=8;
        if StyleBDE then Name:=TeeMsg_WizardTable1
                    else Name:='ADOQuery1';
        Open;
      end;

      tmpChart:=TDBChart.Create(AForm);
    end
    else
    {$ENDIF}
       tmpChart:=TChart.Create(AForm);

    if Wizard.RGDatabase.ItemIndex=2 then
    with Wizard do
    begin
      tmpChart.Parent:=AForm;
      CopyPreviewChart(tmpChart);
    end
    else
    begin
      With tmpChart do
      begin
        Parent:=AForm;
        Assign(Wizard.PreviewChart as TCustomChart);
      end;

      Wizard.CreateSeries(AForm,tmpChart{$IFNDEF NOUSE_BDE},tmpTable{$ENDIF},False)
    end;

    // set component names
    with tmpChart do
    begin
       Name:=TeeGetUniqueName(AForm,Copy(ClassName,2,Length(ClassName)));

      {$IFNDEF NOUSE_BDE}
      if Wizard.RGDatabase.ItemIndex=0 then
         Left:=48
      else
      {$ENDIF}
         Left:=8;
      Top:=8;

      for t:=0 to SeriesCount-1 do
      with Series[t] do
      if Name='' then
         Name:=TeeGetUniqueName(AForm,Copy(ClassName,2,Length(ClassName)));

      for t:=0 to Tools.Count-1 do
      with Tools[t] do
      if Name='' then
         Name:=TeeGetUniqueName(AForm,Copy(ClassName,2,Length(ClassName)));
    end;
  end;

begin
  result:=TForm.Create(nil);
  Proxies.CreateSubClass(Result, 'T' + FormIdent, TForm);  { <-- dont translate }
  with Result do
  begin
    Name    :=FormIdent;
    Caption :=FormIdent;
    Width:=470;
    Height:=300;
    {$IFDEF D5}
    ParentFont:=True;
    {$ELSE}
    with Font do
    begin
      Name:=GetDefaultFontName;
      Size:=GetDefaultFontSize;
    end;
    {$ENDIF}
  end;

  AddControls(result);
end;

const
  CRLF = #13#10;

Function GetPascalSource(Wizard:TTeeDlgWizard; AForm:TCustomForm;
                         const ModuleIdent,FormIdent:String):String;
var tmp : String;
    t   : Integer;
    tmpChart : TCustomChart;
begin

  tmpChart:=nil;
  for t:=0 to AForm.ComponentCount-1 do
  if AForm.Components[t] is TCustomChart then
  begin
    tmpChart:=TCustomChart(AForm.Components[t]);
    break;
  end;

  { unit header and uses clause }
  tmp:=Format(
    'unit %s;' + CRLF + CRLF +
    'interface' + CRLF + CRLF +
    'uses'+CRLF +
    '  Windows, Messages, SysUtils, Classes,'+CRLF+
    {$IFDEF CLX}
    '  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,'+CRLF+
    {$ELSE}
    '  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,'+CRLF+
    {$ENDIF}
    '  TeEngine, TeeProcs, Chart', [ModuleIdent]);

  { additional units that may be needed }
  {$IFNDEF NOUSE_BDE}
  if Wizard.RGDatabase.ItemIndex=0 then
     if Wizard.StyleBDE then
        tmp:=tmp+ ', DBChart, DB, DBTables'
     else
        tmp:=tmp+ ', DBChart, DB, ADODB';
  {$ENDIF}

  tmp:=tmp+ ';' + CRLF + CRLF;

  { begin the class declaration }
  tmp:=tmp+'type'+CRLF +'  T'+FormIdent+' = class(TForm)'+CRLF;

  { add variable declarations }

  {$IFNDEF NOUSE_BDE}
  if Wizard.RGDatabase.ItemIndex=0 then
     if Wizard.StyleBDE then
        tmp:=tmp+'    Table1 : TTable;' + CRLF
     else
        tmp:=tmp+'    ADOQuery1 : TADOQuery;' + CRLF;
  {$ENDIF}

  with tmpChart do
  begin
    tmp:=tmp+'    '+Name+': '+ClassName+';' + CRLF;

    for t:=0 to SeriesCount-1 do
    with Series[t] do
         tmp:=tmp+Format('    %s: %s;'+CRLF,[Name,ClassName]);

    for t:=0 to Tools.Count-1 do
    with Tools[t] do
         tmp:=tmp+Format('    %s: %s;'+CRLF,[Name,ClassName]);
  end;

  tmp:=tmp+Format(
    '  private'+CRLF+
    '    '+TeeMsg_PrivateDeclarations+CRLF+
    '  public'+CRLF+
    '    '+TeeMsg_PublicDeclarations+CRLF+
    '  end;' + CRLF + CRLF +
    'var' + CRLF +
    '  %s: T%s;' + CRLF + CRLF +
    'implementation' + CRLF + CRLF +
    '{$R *.'+
    {$IFDEF D7}
    (BorlandIDEServices as IOTAServices).GetActiveDesignerType
    {$ELSE}
    'DFM'
    {$ENDIF}
    +'}' + CRLF + CRLF, [FormIdent, FormIdent]);

  tmp:=tmp+'end.' + CRLF;

  result:=tmp;
end;

{$IFDEF D7}
type
  TTeeChartModuleCreator = class(TInterfacedObject, IOTACreator, IOTAModuleCreator)
  private
    TheForm : TCustomForm;
    Wizard  : TTeeDlgWizard;
  public
    Constructor Create(AWizard:TTeeDlgWizard);
    Destructor Destroy; override;

    // IOTACreator
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    // IOTAModuleCreator
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);
  end;

{$ELSE}
procedure TeeChartWizard(ToolServices: TIToolServices);
Const SourceBufferSize = 1024;
var SourceBuffer : PChar;

  procedure FmtWrite(Stream: TStream; Const Fmt: String;
    const Args: array of const);
  begin
    if Assigned(Stream) and Assigned(SourceBuffer) then
    begin
      StrLFmt(SourceBuffer, SourceBufferSize, @Fmt[1], Args);
      Stream.Write(SourceBuffer[0], StrLen(SourceBuffer));
    end;
  end;

var D: TTeeDlgWizard;

{$IFDEF BCB}
const
  DashLine =
  '//----------------------------------------------------------------------------';

  function CreateHeader(const UnitIdent, FormIdent:string): TMemoryStream;
  var t: Integer;
  begin
    SourceBuffer := StrAlloc(SourceBufferSize);
    try
      Result := TMemoryStream.Create;
      with D do
      try
        FmtWrite(Result,
          DashLine + CRLF +
          '#ifndef %0:sH' + CRLF +
          '#define %0:sH' + CRLF +
          DashLine + CRLF +
          '#include <vcl\Classes.hpp>' + CRLF +
          '#include <vcl\Controls.hpp>' + CRLF +
          '#include <vcl\StdCtrls.hpp>' + CRLF +
          '#include <vcl\Forms.hpp>' + CRLF +
          '#include <vcl\TeEngine.hpp>' + CRLF +
          '#include <vcl\TeeProcs.hpp>' + CRLF +
          '#include <vcl\Chart.hpp>' + CRLF, [UnitIdent]);

        {$IFNDEF NOUSE_BDE}
        if RGDatabase.ItemIndex=0 then
          if StyleBDE then
             FmtWrite(Result,
                '#include <vcl\DBChart.hpp>' + CRLF +
                '#include <vcl\DB.hpp>' + CRLF +
                '#include <vcl\DBTables.hpp>' + CRLF, [nil])
          else
             FmtWrite(Result,
                '#include <vcl\DBChart.hpp>' + CRLF +
                '#include <vcl\DB.hpp>' + CRLF +
                '#include <vcl\ADODB.hpp>' + CRLF, [nil]);

        {$ENDIF}

        FmtWrite(Result, DashLine + CRLF, [nil]);

        FmtWrite(Result,
          'class T%s : public TForm' + CRLF +
          '{' + CRLF +
          '__published:' + CRLF, [FormIdent]);

        {$IFNDEF NOUSE_BDE}
        if RGDatabase.ItemIndex=0 then
           if StyleBDE then
              FmtWrite(Result,'TTable *Table1;' + CRLF, [nil])
           else
              FmtWrite(Result,'TADOQuery *ADOQuery1;' + CRLF, [nil]);
        {$ENDIF}

        with PreviewChart do
        begin
          FmtWrite(Result,'%s *%s;' + CRLF, [ClassName,Name]);

          for t:=0 to SeriesCount-1 do
          with Series[t] do
               FmtWrite(result,'%s *%s;'+CRLF,[ClassName,Name]);

          for t:=0 to Tools.Count-1 do
          with Tools[t] do
               FmtWrite(result,'%s *%s;'+CRLF,[ClassName,Name]);
        end;

        FmtWrite(Result,'private:'+CRLF +
                 'public:' +CRLF +
                 '  __fastcall T%0:s::T%0:s(TComponent* Owner);' + CRLF +
                 '};' + CRLF ,[FormIdent]);

        FmtWrite(Result,
          DashLine + CRLF +
          'extern  T%0:s *%0:s;' + CRLF +
          DashLine + CRLF +
          '#endif', [FormIdent]);
        Result.Position := 0;
      except
        Result.Free;
        raise;
      end;
    finally
      StrDispose(SourceBuffer);
    end;
  end;

  function CreateCppSource(const UnitIdent,FormIdent:String): TMemoryStream;
  begin
    SourceBuffer := StrAlloc(SourceBufferSize);
    with D do
    try
      Result := TMemoryStream.Create;
      try
        FmtWrite(Result,
          DashLine + CRLF + CRLF +
          '#include <vcl\vcl.h>' + CRLF +
          '#pragma hdrstop' + CRLF +
          CRLF +
          '#include "%0:s.h"' + CRLF +
          DashLine + CRLF +
          '#pragma package(smart_init)' + CRLF +
          '#pragma resource "*.dfm"' + CRLF +
          'T%1:s *%1:s;' + CRLF +
          DashLine + CRLF +
          '__fastcall T%1:s::T%1:s(TComponent* Owner)' + CRLF +
          '        : TForm(Owner)' + CRLF +
          '{' + CRLF +
          '}' + CRLF +
          DashLine, [UnitIdent, FormIdent]);
        Result.Position := 0;
      except
        Result.Free;
        raise;
      end;
    finally
      StrDispose(SourceBuffer);
    end;
  end;

{$ELSE}

  function CreateSource(const UnitIdent, FormIdent: string;
                        AForm:TCustomForm): TMemoryStream;
  begin
    SourceBuffer := StrAlloc(SourceBufferSize);
    try
      Result := TMemoryStream.Create;
      try
        FmtWrite(Result,GetPascalSource(D,AForm,UnitIdent,FormIdent),[nil]);
        Result.Position := 0;
      except
        Result.Free;
        raise;
      end;
    finally
      StrDispose(SourceBuffer);
    end;
  end;
{$ENDIF}

var {$IFDEF BCB}
    IHeaderStream : TIMemoryStream;
    {$ENDIF}
    ISourceStream : TIMemoryStream;
    IFormStream   : TIMemoryStream;
    UnitIdent     : String;
    FormIdent     : String;
    FileName      : String;
    ChartForm     : TForm;
    tmpStream     : TMemoryStream;
begin
  if (ToolServices<>nil) and
     ToolServices.GetNewModuleName(UnitIdent, FileName) then
  begin
    D := TTeeDlgWizard.Create(Application);
    try
      if D.ShowModal = mrOK then
      begin
        UnitIdent := LowerCase(UnitIdent);
        UnitIdent[1] := Upcase(UnitIdent[1]);
        FormIdent := 'Form' + Copy(UnitIdent, 5, 255);

        ChartForm:=DoFormCreation(D,FormIdent);
        try
          tmpStream:=TMemoryStream.Create;
          tmpStream.WriteComponentRes(FormIdent, ChartForm);
          tmpStream.Position:=0;

          IFormStream := TIMemoryStream.Create(tmpStream);

          {$IFDEF BCB}
            IHeaderStream := TIMemoryStream.Create(CreateHeader(UnitIdent,FormIdent), soOwned);
            ISourceStream := TIMemoryStream.Create(CreateCppSource(UnitIdent,FormIdent), soOwned);
            ToolServices.CreateCppModule(FileName, '', '', '', IHeaderStream,
              ISourceStream, IFormStream, [cmAddToProject, cmShowSource,
              cmShowForm, cmUnNamed, cmMarkModified]);
          {$ELSE}
            ISourceStream := TIMemoryStream.Create(CreateSource(UnitIdent,FormIdent,ChartForm));
            ToolServices.CreateModule(FileName, ISourceStream, IFormStream,
                  [ cmAddToProject, cmShowSource, cmShowForm, cmUnNamed,
                    cmMarkModified]);
          {$ENDIF}
        finally
          ChartForm.Free;
        end;
      end;
    finally
      D.Free;
    end;
  end;
end;
{$ENDIF}

{ TTeeChartWizard }
function TTeeChartWizard.GetName: string;
begin
  Result:=TeeMsg_TeeChartWizard;
end;

function TTeeChartWizard.GetComment: string;
begin
  Result:=TeeMsg_TeeChartWizard;
end;

{$IFDEF D7} // Delphi 5
function TTeeChartWizard.GetGlyph: Cardinal;
{$ELSE}
function TTeeChartWizard.GetGlyph: HICON;
{$ENDIF}
begin
  {$IFDEF D7}
    Result:=LoadIcon(HInstance, 'TEEEXPICON');
  {$ELSE}
  result:=0;
  try
    Result:=LoadIcon(HInstance, 'TEEEXPICON');
  except
    ToolServices.RaiseException(ReleaseException);
  end;
  {$ENDIF}
end;

{$IFNDEF D7}
function TTeeChartWizard.GetStyle: TExpertStyle;
begin
  Result:=esForm;
end;
{$ENDIF}

{$IFDEF D7}
function TTeeChartWizard.GetDesigner: string;
begin
  result:={$IFDEF CLX}dCLX{$ELSE}dVCL{$ENDIF};
end;

function TTeeChartWizard.GetState: TWizardState;
begin
  Result:=[wsEnabled];
end;
{$ELSE}
function TTeeChartWizard.GetState: TExpertState;
begin
  Result:=[esEnabled];
end;
{$ENDIF}

function TTeeChartWizard.GetIDString: string;
begin
  Result:=TeeMsg_TeeChartIDWizard;
end;

function TTeeChartWizard.GetAuthor: string;
begin
  Result:=TeeMsg_TeeChartSL;
end;

function TTeeChartWizard.GetPage: string;
begin
  Result:=TeeMsg_WizardTab;
end;

procedure TTeeChartWizard.Execute;
{$IFDEF D7}
var D: TTeeDlgWizard;
{$ENDIF}
begin
  {$IFDEF D7}
  D := TTeeDlgWizard.Create(Application);
  try
    if D.ShowModal = mrOK then
       (BorlandIDEServices as IOTAModuleServices).CreateModule(TTeeChartModuleCreator.Create(D));
  finally
    D.Free;
  end;
  {$ELSE}
  try
    TeeChartWizard(ToolServices);
  except
    ToolServices.RaiseException(ReleaseException);
  end;
  {$ENDIF}
end;

function TTeeChartWizard.GetMenuText: string;
begin
  result:=TeeMsg_TeeChartWizard+'...';
end;

Procedure Register;
begin
  {$IFDEF D7}
  RegisterPackageWizard(TTeeChartWizard.Create);
  {$ELSE}
  RegisterLibraryExpert(TTeeChartWizard.Create);
  {$ENDIF}
end;

{$IFDEF D7}

{ TTeeChartModuleCreator }

Constructor TTeeChartModuleCreator.Create(AWizard:TTeeDlgWizard);
begin
  inherited Create;
  Wizard:=AWizard;
end;

destructor TTeeChartModuleCreator.Destroy;
begin
  FreeAndNil(TheForm);
  inherited;
end;

procedure TTeeChartModuleCreator.FormCreated(
  const FormEditor: IOTAFormEditor);
begin
  // do nothing
end;

function TTeeChartModuleCreator.GetAncestorName: string;
begin
  Result := 'Form';
end;

function TTeeChartModuleCreator.GetCreatorType: string;
begin
  Result := sForm;
end;

function TTeeChartModuleCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TTeeChartModuleCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TTeeChartModuleCreator.GetFormName: string;
begin
  Result := '';
end;

function TTeeChartModuleCreator.GetImplFileName: string;
begin
  Result := '';
end;

function TTeeChartModuleCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TTeeChartModuleCreator.GetMainForm: Boolean;
begin
  Result := False;
end;

// From Delphi 7 help file
function TTeeChartModuleCreator.GetOwner: IOTAModule;
var
  I: Integer;
  Svc: IOTAModuleServices;
  Module: IOTAModule;
  Project: IOTAProject;
  Group: IOTAProjectGroup;
begin
  { Return the current project. }
  Supports(BorlandIDEServices, IOTAModuleServices, Svc);
  Result := nil;
  for I := 0 to Svc.ModuleCount - 1 do
  begin
    Module := Svc.Modules[I];
    if Supports(Module, IOTAProject, Project) then
    begin
      { Remember the first project module}
      if Result = nil then
        Result := Project;
    end
    else if Supports(Module, IOTAProjectGroup, Group) then
    begin
      { Found the project group, so return its active project}
      Result := Group.ActiveProject;
      Exit;
    end;
  end;
end;

function TTeeChartModuleCreator.GetShowForm: Boolean;
begin
  Result := True;
end;

function TTeeChartModuleCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TTeeChartModuleCreator.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TTeeChartModuleCreator.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;

  function ComponentToString(Component: TComponent): string;
  var
    BinStream:TMemoryStream;
    StrStream: TStringStream;
    s: string;
  begin
    BinStream := TMemoryStream.Create;
    try
      StrStream := TStringStream.Create(s);
      try
        BinStream.WriteComponent(Component);
        BinStream.Seek(0, soFromBeginning);
        ObjectBinaryToText(BinStream, StrStream);
        StrStream.Seek(0, soFromBeginning);
        Result:= StrStream.DataString;
      finally
        StrStream.Free;
      end;
    finally
      BinStream.Free
    end;
  end;

begin
  if not Assigned(TheForm) then
     TheForm:=DoFormCreation(Wizard,FormIdent);
  result:=StringToIOTAFile(ComponentToString(TheForm));
end;

function TTeeChartModuleCreator.NewImplSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  if not Assigned(TheForm) then
     TheForm:=DoFormCreation(Wizard,FormIdent);

  result:=StringToIOTAFile(GetPascalSource(Wizard,TheForm,ModuleIdent,FormIdent));
end;

function TTeeChartModuleCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;
{$ENDIF}

end.
