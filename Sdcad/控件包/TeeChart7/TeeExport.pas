{**********************************************}
{   TeeChart and TeeTree Common Export Dialog  }
{   Copyright (c) 1996-2004 by David Berneda   }
{**********************************************}
unit TeeExport;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  TeePenDlg,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeCanvas, TeeProcs, TeeConst;

type
  TeeSeparatorChar={$IFDEF CLX}WideChar{$ELSE}Char{$ENDIF};

  TTeeExportFormat=class
  protected
    FFilterIndex : Integer;
    Procedure CheckSize;
    Procedure DoCopyToClipboard; virtual; abstract;
    function FileFilterIndex:Integer; virtual;
    Procedure IncFileFilterIndex(Var FilterIndex:Integer); virtual;

  {$IFDEF CLR}  
  public
  {$ENDIF}
    function WantsFilterIndex(Index:Integer):Boolean; virtual;  // 6.01
  public
    Height : Integer;
    Panel  : TCustomTeePanel;
    Width  : Integer;
    Constructor Create; virtual;
    Destructor Destroy; override;

    Procedure CopyToClipboard;
    function Description:String; virtual; abstract;
    function FileExtension:String; virtual; abstract;
    function FileFilter:String; virtual; abstract;
    Procedure SaveToFile(Const FileName:String);
    Procedure SaveToStream(Stream:TStream); virtual; abstract;
    Function Options(Check:Boolean=True):TForm; virtual;
  end;

  TTeeExportFormBase = class(TForm)
    SaveDialogPicture: TSaveDialog;
    PageControl1: TPageControl;
    TabPicture: TTabSheet;
    TabData: TTabSheet;
    RGFormat: TGroupBox;
    Label3: TLabel;
    CBSeries: TComboFlat;
    SaveDialogData: TSaveDialog;
    RGText: TRadioGroup;
    TabNative: TTabSheet;
    CBNativeData: TCheckBox;
    SaveDialogNative: TSaveDialog;
    LabelSize: TLabel;
    CBFileSize: TCheckBox;
    CBDelim: TComboFlat;
    ECustom: TEdit;
    GroupBox1: TGroupBox;
    CBLabels: TCheckBox;
    CBIndex: TCheckBox;
    Label4: TLabel;
    CBHeader: TCheckBox;
    PageOptions: TPageControl;
    TabOptions: TTabSheet;
    TabSize: TTabSheet;
    Label1: TLabel;
    EWidth: TEdit;
    UDWidth: TUpDown;
    Label2: TLabel;
    EHeight: TEdit;
    UDHeight: TUpDown;
    CBAspect: TCheckBox;
    Panel1: TPanel;
    BCopy: TButton;
    BSave: TButton;
    BSend: TButton;
    BClose: TButton;
    LBFormat: TListBox;
    CBColors: TCheckBox;
    Label5: TLabel;
    CBNativeFormat: TComboFlat;
    Label6: TLabel;
    EQuotes: TEdit;
    procedure BCopyClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RGFormatClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EWidthChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RGTextClick(Sender: TObject);
    procedure CBFileSizeClick(Sender: TObject);
    procedure CBNativeDataClick(Sender: TObject);
    procedure CBDelimChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BSendClick(Sender: TObject);
    procedure CBNativeFormatChange(Sender: TObject);
  private
    { Private declarations }
    IAspect      : Double;
    ChangingSize : Boolean;
    Function CanChangeSize:Boolean;

    Function GetDataFilterIndex:Integer;
    Function GuessPictureFormat(const FileName:String):TTeeExportFormat;
    Procedure FreeExportFormats;
    Function PictureFormat:TTeeExportFormat;
    Procedure SaveNativeToFile(Const FileName:String);
    Procedure SavePictureToFile(Const FileName:String);
  protected
    Function CreateData:TTeeExportData; virtual;
    Procedure DoSaveNativeToFile( Const FileName:String;
                                  IncludeData:Boolean); virtual;
    Function ExistData:Boolean; virtual;
    Function CreateNativeStream:TStream; virtual;
    Function GetSeparator:TeeSeparatorChar;
    Function NativeAsText:Boolean;
    Procedure PrepareOnShow; virtual;
    Procedure SaveDataToFile(Const FileName:String);
  public
    { Public declarations }
    ExportPanel     : TCustomTeePanel;
    EmailName       : String; { 5.03 }
    NativeFilter    : String; { 5.03 }
    NativeExtension : String; { 5.03 }

    procedure EnableButtons;
  end;

{ Retrieves a native "*.tee" file }
Procedure LoadTeeFromFile(Var APanel:TCustomTeePanel; Const AName:String);
Procedure LoadTeeFromStream(Var APanel:TCustomTeePanel; AStream:TStream);

{ Saves a Chart or TeePanel to a native "*.tee" file format }
Procedure SaveTeeToFile(APanel:TCustomTeePanel; Const AName:String);
Procedure SaveTeeToStream(APanel:TCustomTeePanel; AStream:TStream);

{ "Tee export formats" }
type TTeeExportFormatClass=class of TTeeExportFormat;

Procedure RegisterTeeExportFormat(AFormat:TTeeExportFormatClass);
Procedure UnRegisterTeeExportFormat(AFormat:TTeeExportFormatClass);

{ Show the Save dialog and save to AFormat export format }
{ example: TeeExportSavePanel(TGIFExportFormat,Chart1); }
Procedure TeeExportSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);

procedure TeeFillPictureDialog(ADialog:TSaveDialog; APanel:TCustomTeePanel; AItems:TStrings);

type
  TTeeExportFormats=class(TList)
  private
    Function Get(Index:Integer):TTeeExportFormatClass;
  public
    {$IFDEF CLR}
    procedure Add(Item:TTeeExportFormatClass);
    procedure Remove(Item:TTeeExportFormatClass);
    {$ENDIF}
    property Format[Index:Integer]:TTeeExportFormatClass read Get; default;
  end;

var TeeExportFormats : TTeeExportFormats=nil;

{ starts the MAPI (eg: Outlook) application with an empty new email
  message with the attachment file "FileName" }
Procedure InternalTeeEmailFile(Const FileName:String; Const Subject:String='TeeChart');

Function GetRegistryHelpPath(Const HelpFile:String):String;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd, ExtDlgs, TeePenDlg, TeeEMFOptions,
     {$ENDIF}
     {$IFNDEF LINUX}
     MAPI, Registry,
     {$ENDIF}
     {$IFDEF CLR}
     System.Text,
     {$ENDIF}
     TeeBmpOptions;

Procedure SaveTeeToStream(APanel:TCustomTeePanel; AStream:TStream);
begin
  AStream.WriteComponent(APanel);
end;

Procedure SaveTeeToFile(APanel:TCustomTeePanel; Const AName:String);
Var tmp        : TFileStream;
    OldVisible : Boolean;
begin
  tmp:=TFileStream.Create(AName,fmCreate);
  try
    OldVisible:=APanel.Visible;
    APanel.Visible:=True;
    try
      SaveTeeToStream(APanel,tmp);
    finally
      APanel.Visible:=OldVisible;
    end;
  finally
    tmp.Free;
  end;
end;

Procedure LoadTeeFromStream(Var APanel:TCustomTeePanel; AStream:TStream);
begin
  AStream.ReadComponent(APanel);
end;

Procedure LoadTeeFromFile(Var APanel:TCustomTeePanel; Const AName:String);
Var tmp : TFileStream;
begin
  tmp:=TFileStream.Create(AName,fmOpenRead);
  try
    LoadTeeFromStream(APanel,tmp);
  finally
    tmp.Free;
  end;
end;

{ Export Dialog }
procedure TTeeExportFormBase.BCopyClick(Sender: TObject);
var s   : TStringStream;
    tmp : TStream;
begin
  if PageControl1.ActivePage=TabPicture then
  with PictureFormat do
  begin
    Width:=UDWidth.Position;
    Height:=UDHeight.Position;
    CopyToClipboard;
  end
  else
  if PageControl1.ActivePage=TabData then
  begin
    Screen.Cursor:=crHourGlass;
    try
      With CreateData do
      try
        CopyToClipboard;
      finally
        Free;
      end;
    finally
      Screen.Cursor:=crDefault;
    end;
  end
  else
  if (PageControl1.ActivePage=TabNative) and NativeAsText then
  begin
    s:=TStringStream.Create('');
    try
      tmp:=CreateNativeStream;
      try
        tmp.Position:=0;
        s.CopyFrom(tmp,tmp.Size);
        Clipboard.AsText:=s.DataString;
      finally
        tmp.Free;
      end;
    finally
      s.Free;
    end;
  end;
end;

Procedure TTeeExportFormBase.SaveDataToFile(Const FileName:String);
begin
  Screen.Cursor:=crHourGlass;
  try
    With CreateData do
    try
      SaveToFile(FileName);
    finally
      Free;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

Function TTeeExportFormBase.CreateData:TTeeExportData;
begin
  result:=nil;
end;

Function TTeeExportFormBase.GetSeparator:TeeSeparatorChar;
begin
  Case CBDelim.ItemIndex of
    0: result:=' ';
    1: result:=TeeTabDelimiter;
    2: result:=',';
    3: result:=';';
  else if ECustom.Text='' then result:=' ' else result:=ECustom.Text[1];
  end;
end;

Function TTeeExportFormBase.GetDataFilterIndex:Integer;
begin
  if RGText.ItemIndex=0 then result:=CBDelim.ItemIndex+1
                        else result:=4+RGText.ItemIndex;
end;

Procedure TTeeExportFormBase.DoSaveNativeToFile( Const FileName:String;
                                                 IncludeData:Boolean);
begin
  SaveTeeToFile(ExportPanel,FileName);
end;

Procedure TTeeExportFormBase.SaveNativeToFile(Const FileName:String);
var tmp : String;
begin
  Screen.Cursor:=crHourGlass;
  try
    tmp:=ChangeFileExt(FileName,'.'+NativeExtension);
    DoSaveNativeToFile(tmp,CBNativeData.Checked);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

Procedure TTeeExportFormBase.SavePictureToFile(Const FileName:String);
begin
  Screen.Cursor:=crHourGlass;
  try
    With GuessPictureFormat(FileName) do
    begin
      Width:=UDWidth.Position;
      Height:=UDHeight.Position;
      SaveToFile(FileName);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TTeeExportFormBase.BSaveClick(Sender: TObject);
begin
  if PageControl1.ActivePage=TabPicture then  { as picture... }
  With SaveDialogPicture do
  begin
    With PictureFormat do
    begin
      DefaultExt:=FileExtension;
      FilterIndex:=FileFilterIndex;
    end;

    FileName:='';
    if Execute then
       SavePictureToFile(FileName);
  end
  else
  if PageControl1.ActivePage=TabNative then   { as native *.tee file... }
  With SaveDialogNative do
  begin
    FileName:='';
    DefaultExt:=NativeExtension;
    Filter:=NativeFilter;
    if Execute then SaveNativeToFile(FileName);
  end
  else
  if PageControl1.ActivePage=TabData then    { series data... }
  With SaveDialogData do
  begin
    FileName:='';
    FilterIndex:=GetDataFilterIndex;
    if Execute then
    begin
      if FilterIndex<=4 then RGText.ItemIndex:=0
                        else RGText.ItemIndex:=FilterIndex-4;
      SaveDataToFile(FileName);
    end;
  end;
end;

procedure TTeeExportFormBase.FormCreate(Sender: TObject);
Const DialogOptions : TOpenOptions =
          [ ofOverwritePrompt
            {$IFNDEF CLX}
            , ofHideReadOnly
            {$ENDIF}
          ]; // K3?
begin
  BorderStyle:=TeeBorderStyle;
  ChangingSize:=False;
  NativeExtension:=TeeMsg_TeeExtension; { default extension is *.tee }
  NativeFilter:=TeeMsg_NativeFilter;  { default "TeeChart files (*.tee)|*.tee" }
  EmailName:=TeeMsg_TeeChartPalette;
  PageControl1.ActivePage:=TabPicture;

  CBNativeFormat.ItemIndex:=0;
  
  // For Kylix compatibility:  ("Options" cannot reside in DFM/XFM)
  SaveDialogPicture.Options:=DialogOptions;
  SaveDialogData.Options:=DialogOptions;
  SaveDialogNative.Options:=DialogOptions;
end;

procedure TTeeExportFormBase.RGFormatClick(Sender: TObject);
var tmp : TForm;
    t   : Integer;
begin
  With TabOptions do
  for t:=0 to ControlCount-1 do Controls[t].Hide;

  With PictureFormat do
  begin
    tmp:=Options;
    TabOptions.TabVisible:=Assigned(tmp) and (tmp.ControlCount>0);

    if TabOptions.TabVisible then
    begin
      PageOptions.ActivePage:=TabOptions;
      AddFormTo(tmp,TabOptions);
      TeeTranslateControl(tmp);
    end
    else PageOptions.ActivePage:=TabSize;
  end;
end;

procedure TeeFillPictureDialog(ADialog:TSaveDialog; APanel:TCustomTeePanel; AItems:TStrings);
var t   : Integer;
    tmp : TTeeExportFormat;
    tmpFilter : Integer;
    {$IFDEF CLX}
    i   : Integer;
    {$ENDIF}
begin
  if TeeExportFormats<>nil then
  begin
    if ADialog.Filter='' then tmpFilter:=0
                         else tmpFilter:=1;

    for t:=0 to TeeExportFormats.Count-1 do
    begin
      tmp:=TeeExportFormats[t].Create;
      tmp.Panel:=APanel;
      tmp.IncFileFilterIndex(tmpFilter);

      With ADialog do
      begin
        if Filter<>'' then Filter:=Filter+'|';
        {$IFDEF CLX}
        i:=Pos('|',tmp.FileFilter);
        if i=0 then Filter:=Filter+tmp.FileFilter
               else Filter:=Filter+Copy(tmp.FileFilter,1,i-1);
        {$ELSE}
        Filter:=Filter+tmp.FileFilter;
        {$ENDIF}
      end;

      if Assigned(AItems) then
         AItems.AddObject(ReplaceChar(tmp.Description,'&'),tmp)
      else
         tmp.Free;
    end;
  end;
end;

procedure TTeeExportFormBase.PrepareOnShow;
begin
  TabData.TabVisible:=False;
  CBNativeData.Visible:=False;
end;

procedure TTeeExportFormBase.FormShow(Sender: TObject);
begin
  RGText.ItemIndex:=0; // 6.01

  with SaveDialogData do Options:=Options+[ofEnableSizing];
  with SaveDialogPicture do Options:=Options+[ofEnableSizing];
  with SaveDialogNative do Options:=Options+[ofEnableSizing];

  if Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
     ExportPanel:=TCustomTeePanel(Tag);

  if Assigned(ExportPanel) then
  begin
    ChangingSize:=True;
    With ExportPanel do
    begin
      UDWidth.Position :=Width;
      UDHeight.Position:=Height;
      IAspect:=Width/Height;
    end;

    PrepareOnShow;

    FreeExportFormats;
    TeeFillPictureDialog(SaveDialogPicture,ExportPanel,LBFormat.Items);

    CBDelim.ItemIndex:=1;
    LBFormat.ItemIndex:=0;
    RGFormatClick(Self);
    EnableButtons;
    ChangingSize:=False;
  end;

  TeeTranslateControl(Self);
end;

Function TTeeExportFormBase.CanChangeSize:Boolean;
begin
  result:=Showing and (not ChangingSize) and
          CBAspect.Checked and (IAspect<>0);
end;

procedure TTeeExportFormBase.EWidthChange(Sender: TObject);
begin
  if CanChangeSize then
  begin
    ChangingSize:=True;
    if Sender=EWidth then
       UDHeight.Position:=Round(UDWidth.Position/IAspect)
    else
       UDWidth.Position:=Round(UDHeight.Position*IAspect);
    ChangingSize:=False;
  end;
end;

procedure TTeeExportFormBase.PageControl1Change(Sender: TObject);
begin
  {$IFDEF CLX}
  if Showing then
  {$ENDIF}
     EnableButtons;
end;

{$IFNDEF LINUX}
var IsMapiInstalled : Integer=-1;
{$ENDIF}

Function MapiInstalled:Boolean;
{$IFNDEF LINUX}
var tmp : Integer;
{$ENDIF}
begin
  {$IFNDEF LINUX}
  if IsMapiInstalled=-1 then
  begin
    tmp:=TeeLoadLibrary('Mapi32.dll');
    if tmp>0 then
    begin
      IsMapiInstalled:=1;
      TeeFreeLibrary(tmp);
    end
    else IsMapiInstalled:=0;
  end;

  result:=IsMapiInstalled=1;

  {$ELSE}
 
  result:=False;

  {$ENDIF}
end;

Function TTeeExportFormBase.ExistData:Boolean;
begin
  result:=False;
end;

Function TTeeExportFormBase.NativeAsText:Boolean;
begin
  result:=CBNativeFormat.ItemIndex=1;
end;

procedure TTeeExportFormBase.EnableButtons;
begin
  BCopy.Enabled:=(PageControl1.ActivePage=TabPicture)
                 or
                 ((PageControl1.ActivePage=TabData) and ExistData)
                 or
                 ((PageControl1.ActivePage=TabNative) and NativeAsText);

  BSave.Enabled:=BCopy.Enabled or (PageControl1.ActivePage=TabNative);

  if (PageControl1.ActivePage=TabData) and (RGText.ItemIndex=3) then
     BCopy.Enabled:=False;

  BSend.Enabled:=BSave.Enabled and MapiInstalled;
end;

procedure TTeeExportFormBase.RGTextClick(Sender: TObject);
begin
  CBDelim.Enabled:=RGText.ItemIndex=0;
  ECustom.Enabled:=CBDelim.Enabled;
//  6.0   CBHeader.Enabled:=RGText.ItemIndex<>1; { 5.02 }
  EnableButtons;
end;

Function TTeeExportFormBase.CreateNativeStream:TStream;
begin
  result:=TMemoryStream.Create;
  SaveTeeToStream(ExportPanel,result);
end;

procedure TTeeExportFormBase.CBFileSizeClick(Sender: TObject);
begin
  if CBFileSize.Checked then
  with CreateNativeStream do
  try
    LabelSize.Caption:=Format(TeeMsg_FileSize,[Size]);
  finally
    Free;
  end
  else LabelSize.Caption:='?';
end;

procedure TTeeExportFormBase.CBNativeDataClick(Sender: TObject);
begin
  CBFileSizeClick(Self);
end;

procedure TTeeExportFormBase.CBDelimChange(Sender: TObject);
begin
  ECustom.Enabled:=CBDelim.ItemIndex=4;
  if ECustom.Enabled then ECustom.SetFocus;
end;

Procedure TTeeExportFormBase.FreeExportFormats;
var t: Integer;
begin
  if TeeExportFormats<>nil then
     for t:=0 to LBFormat.Items.Count-1 do
         TTeeExportFormat(LBFormat.Items.Objects[t]).Free;
  LBFormat.Items.Clear;
end;

procedure TTeeExportFormBase.FormDestroy(Sender: TObject);
begin
  FreeExportFormats;
end;

function TTeeExportFormBase.PictureFormat: TTeeExportFormat;
begin
  result:=TTeeExportFormat(LBFormat.Items.Objects[LBFormat.ItemIndex]);
end;

Function TTeeExportFormBase.GuessPictureFormat(const FileName:String):TTeeExportFormat;
var Extension : String;
    t         : Integer;
begin
  Extension:=UpperCase(ExtractFileExt(FileName));
  if Copy(Extension,1,1)='.' then
     Delete(Extension,1,1);

  for t:=0 to LBFormat.Items.Count-1 do
  begin
    result:=TTeeExportFormat(LBFormat.Items.Objects[t]);
    if Extension=UpperCase(result.FileExtension) then
       Exit;
  end;

  result:=PictureFormat;
end;

type
  TPathName={$IFDEF CLR}string{$ELSE}Array[0..MAX_PATH] of Char{$ENDIF};

procedure TTeeExportFormBase.BSendClick(Sender: TObject);
{$IFNDEF LINUX}
var tmpPath : {$IFDEF CLR}StringBuilder{$ELSE}TPathName{$ENDIF};
    tmpName : TPathName;

  Procedure AdjustExtension(Const Extension:String);
  begin
    {$IFDEF CLR}
    tmpName:=ChangeFileExt(tmpName,'.'+Extension);
    {$ELSE}
    StrPCopy(tmpName,ChangeFileExt(tmpName,'.'+Extension));
    {$ENDIF}
  end;

  Function GetDataExtension(Index:Integer):String;
  var t  : Integer;
      i  : Integer;
      St : String;
  begin
    St:=SaveDialogData.Filter;
    for t:=1 to (2*Index)-1 do
    begin
      i:=Pos('|',St);
      if i>0 then Delete(St,1,i);
    end;
    i:=Pos('|',St);
    if i>0 then Delete(St,i,Length(St));
    i:=Pos('.',St);
    if i>0 then Delete(St,1,i);
    result:=St;
  end;

{$ENDIF}
begin
  {$IFNDEF LINUX}

  {$IFDEF CLR}
  tmpPath:=StringBuilder.Create;
  {$ENDIF}

  if GetTempPath(MAX_PATH,tmpPath)=0 then
     Raise Exception.Create(TeeMsg_CanNotFindTempPath);

  {$IFDEF CLR}
  tmpName:=tmpPath.ToString+'\'+EmailName;
  {$ELSE}
  StrPCopy(tmpName,StrPas(tmpPath)+'\'+EmailName);
  {$ENDIF}

  if PageControl1.ActivePage=TabPicture then
  begin
    AdjustExtension(PictureFormat.FileExtension);
    SavePictureToFile(tmpName);
  end
  else
  if PageControl1.ActivePage=TabNative then
  begin
    AdjustExtension(NativeExtension);
    SaveNativeToFile(tmpName);
  end
  else
  if PageControl1.ActivePage=TabData then
  begin
    AdjustExtension(GetDataExtension(GetDataFilterIndex));
    SaveDataToFile(tmpName);
  end;

  InternalTeeEmailFile(tmpName,EmailName);
  DeleteFile(tmpName);
{$ENDIF}
end;

{ TTeeExportFormat }
Constructor TTeeExportFormat.Create;
begin { dummy constructor, to allow overriding it in derived classes }
  inherited;
end;

procedure TTeeExportFormat.CopyToClipboard;
begin
  if Assigned(Panel) then
  begin
    Options;
    CheckSize;
    DoCopyToClipboard;
  end
  else raise Exception.Create(TeeMsg_ExportPanelNotSet);
end;

Destructor TTeeExportFormat.Destroy;
begin
  if Assigned(Options(False)) then Options.Free;
  inherited;
end;

function TTeeExportFormat.FileFilterIndex: Integer;
begin
  result:=FFilterIndex;
end;

procedure TTeeExportFormat.IncFileFilterIndex(var FilterIndex: Integer);
begin
  Inc(FilterIndex);
  FFilterIndex:=FilterIndex;
end;

function TTeeExportFormat.Options(Check:Boolean=True):TForm;
begin
  result:=nil;
end;

procedure TTeeExportFormat.SaveToFile(const FileName: String);
var tmpStream : TStream;
begin
  if Assigned(Panel) then
  begin
    {$IFNDEF TEEOCX} // Revise for 5.04
    Options;
    {$ENDIF}

    CheckSize;
    tmpStream:=TFileStream.Create(Filename, fmCreate);
    try
      SaveToStream(tmpStream);
    finally
      tmpStream.Free;
    end;
  end
  else raise Exception.Create(TeeMsg_ExportPanelNotSet);
end;

Procedure TTeeExportFormat.CheckSize;
begin
  if Width=0 then Width:=Panel.Width;
  if Height=0 then Height:=Panel.Height;
end;

function TTeeExportFormat.WantsFilterIndex(Index: Integer): Boolean;
begin
  result:=FileFilterIndex=Index;
end;

{ TTeeExportFormats }
{$IFDEF CLR}
procedure TTeeExportFormats.Add(Item:TTeeExportFormatClass);
begin
  inherited Add(Item.Create);
end;

procedure TTeeExportFormats.Remove(Item:TTeeExportFormatClass);
begin
  inherited Remove(Item.Create);
end;
{$ENDIF}

function TTeeExportFormats.Get(Index: Integer): TTeeExportFormatClass;
begin
  result:=TTeeExportFormatClass(Items[Index]);
end;

{ Tools }
Procedure RegisterTeeExportFormat(AFormat:TTeeExportFormatClass);
begin
  if TeeExportFormats=nil then
     TeeExportFormats:=TTeeExportFormats.Create;
  TeeExportFormats.Add(AFormat);
end;

Procedure UnRegisterTeeExportFormat(AFormat:TTeeExportFormatClass);
begin
  if Assigned(TeeExportFormats) then
     TeeExportFormats.Remove(AFormat);
end;

Procedure TeeExportSavePanel(AFormat:TTeeExportFormatClass; APanel:TCustomTeePanel);
begin
  With AFormat.Create do
  try
    Panel:=APanel;
    With TSaveDialog.Create(nil) do
    try
      Filter:=FileFilter;
      DefaultExt:=FileExtension;
      Options:=Options+[ofOverwritePrompt];
      if Execute then SaveToFile(FileName);
    finally
      Free;
    end;
  finally
    Free;
  end;
end;

Procedure InternalTeeEmailFile(Const FileName:String; Const Subject:String='TeeChart');
{$IFNDEF LINUX}
var tmpName2     : TPathName;
    MapiMessage  : TMapiMessage;
    MapiFileDesc : TMapiFileDesc;
    MError       : Cardinal;
{$ENDIF}
begin
 {$IFNDEF LINUX}
  With MapiFileDesc do
  begin
    ulReserved:=0;
    flFlags:=0;
    nPosition:=Cardinal(-1);
    lpszPathName:={$IFNDEF CLR}PChar{$ENDIF}(FileName);

    {$IFDEF CLR}
    tmpName2:=ExtractFileName(FileName);
    {$ELSE}
    StrPCopy(tmpName2,ExtractFileName(FileName));
    {$ENDIF}

    {$IFNDEF CLR}
    //TODO: IntPtr?
    lpszFileName:=tmpName2;
    {$ENDIF}

    lpFileType:=nil;
  end;

  with MapiMessage do
  begin
    ulReserved := 0;
    lpszSubject := {$IFNDEF CLR}PChar{$ENDIF}(Subject);

    {$IFDEF CLR}
    lpszNoteText := '';
    lpszMessageType := '';
    lpszDateReceived := '';
    lpszConversationID := '';
    {$ELSE}
    lpszNoteText := nil;
    lpszMessageType := nil;
    lpszDateReceived := nil;
    lpszConversationID := nil;
    {$ENDIF}

    flFlags := 0;
    lpOriginator := nil;
    nRecipCount := 0;
    lpRecips := nil;
    nFileCount := 1;

    {$IFNDEF CLR}
    //TODO: IntPtr?
    lpFiles := @MapiFileDesc;
    {$ENDIF}
  end;

  MError:=MapiSendMail(0, {$IFDEF CLX}0{$ELSE}Application.Handle{$ENDIF},
    MapiMessage,
    MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);

  if MError<>0 then
     Raise Exception.CreateFmt(TeeMsg_CanNotEmailChart,[MError]);
  {$ENDIF}
end;

Function GetRegistryHelpPath(Const HelpFile:String):String;
Const WindowsHelp='SOFTWARE\Microsoft\Windows\Help';
begin
  result:='';
  {$IFNDEF LINUX}
  With TRegistry.Create do
  try
    RootKey:=HKEY_LOCAL_MACHINE;
    if OpenKeyReadOnly(WindowsHelp) then
       result:=ReadString(HelpFile)+'\'+HelpFile;
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TTeeExportFormBase.CBNativeFormatChange(Sender: TObject);
begin
  EnableButtons;
  CBFileSizeClick(Self);
end;

initialization
finalization
  FreeAndNil(TeeExportFormats);
end.
 