{******************************************}
{   Design-Time Options Editor Dialog      }
{ Copyright (c) 2003-2004 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeDesignOptions;
{$I TeeDefs.inc}

interface

uses
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  TeCanvas, 
  {$IFNDEF TEELITE}
  TeeTranslate, 
  {$ENDIF}
  TeeProcs, TeeGalleryPanel, TeeEditCha;

type
  TOptionsForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    CBSmooth: TCheckBox;
    Label3: TLabel;
    CBGalleryMode: TComboFlat;
    GroupBox3: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    CBSize: TCheckBox;
    CBPosition: TCheckBox;
    CBTree: TCheckBox;
    Button4: TButton;
    GroupNewChart: TGroupBox;
    Label4: TLabel;
    CBTheme: TComboFlat;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  
    {$IFNDEF TEELITE}
    OldLang : Integer;
    procedure ChangeLangLabel;
    {$ENDIF}

  public
    { Public declarations }
  end;

// Index of Theme to use as default for new created Charts at design-time
var TeeNewChartTheme : Integer=0;

implementation

uses {$IFNDEF TEELITE}
     {$IFNDEF TEENOTHEMES}
     TeeThemeEditor,
     {$ENDIF}
     {$ENDIF}
     {$IFNDEF LINUX}
     Registry,
     {$ENDIF}
     TeeConst;

{$R *.dfm}

procedure TOptionsForm.Button1Click(Sender: TObject);
begin
  {$IFNDEF TEELITE}
  if TeeAskLanguage then ChangeLangLabel;
  {$ENDIF}
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  {$IFNDEF TEELITE}
  OldLang:=TeeLanguageRegistry;
  ChangeLangLabel;
  {$ENDIF}

  CBSmooth.Checked:=TChartGalleryPanel.DefaultSmooth;
  CBGalleryMode.ItemIndex:=TChartGalleryPanel.DefaultMode;
  CBPosition.Checked:=TeeReadBoolOption(TeeMsg_RememberPosition,True);
  CBSize.Checked:=TeeReadBoolOption(TeeMsg_RememberSize,True);
  CBTree.Checked:=TeeReadBoolOption(TeeMsg_TreeMode,False);

  {$IFNDEF TEELITE}
  {$IFNDEF TEENOTHEMES}
  AddChartThemes(CBTheme.Items);
  CBTheme.ItemIndex:=TeeReadIntegerOption(TeeMsg_DefaultTheme,0);
  {$ENDIF}
  {$ENDIF}

  {$IFDEF LINUX}
  Button4.Visible:=False;
  {$ENDIF}

  {$IFDEF TEELITE}
  GroupBox1.Hide;
  GroupNewChart.Hide;
  {$ENDIF}

  TeeTranslateControl(Self);
end;

{$IFNDEF TEELITE}
procedure TOptionsForm.ChangeLangLabel;
begin
  with TAskLanguage.Create(nil) do
  try
    Self.Label2.Caption:=LBLangs.Items[LBLangs.ItemIndex];
  finally
    Free;
  end;
end;
{$ENDIF}

procedure TOptionsForm.Button3Click(Sender: TObject);
begin
  {$IFNDEF TEELITE}
  if OldLang<>TeeLanguageRegistry then
     TeeLanguageSaveRegistry(OldLang);
  {$ENDIF}

  ModalResult:=mrCancel;
end;

procedure TOptionsForm.Button2Click(Sender: TObject);
begin
  if CBSmooth.Checked<>TChartGalleryPanel.DefaultSmooth then
     TChartGalleryPanel.SaveSmooth(CBSmooth.Checked);

  if CBGalleryMode.ItemIndex<>TChartGalleryPanel.DefaultMode then
     TChartGalleryPanel.SaveMode(CBGalleryMode.ItemIndex);

  if CBPosition.Checked<>TeeReadBoolOption(TeeMsg_RememberPosition,True) then
     TeeSaveBoolOption(TeeMsg_RememberPosition,CBPosition.Checked);

  if CBSize.Checked<>TeeReadBoolOption(TeeMsg_RememberSize,True) then
     TeeSaveBoolOption(TeeMsg_RememberSize,CBSize.Checked);

  if CBTree.Checked<>TeeReadBoolOption(TeeMsg_TreeMode,False) then
     TeeSaveBoolOption(TeeMsg_TreeMode,CBTree.Checked);

  {$IFNDEF TEELITE}
  {$IFNDEF TEENOTHEMES}
  if CBTheme.ItemIndex<>TeeReadIntegerOption(TeeMsg_DefaultTheme,0) then
  begin
    TeeNewChartTheme:=CBTheme.ItemIndex;
    TeeSaveIntegerOption(TeeMsg_DefaultTheme,TeeNewChartTheme);
  end;
  {$ENDIF}
  {$ENDIF}

  ModalResult:=mrOk;
end;

procedure TOptionsForm.Button4Click(Sender: TObject);
begin
  {$IFNDEF LINUX}
  with TRegistry.Create do
  try
    if OpenKey(TeeMsg_EditorKey,True) then
    begin
      DeleteValue('Left');
      DeleteValue('Top');
      DeleteValue('Width');
      DeleteValue('Height');
    end;
  finally
    Free;
  end;
  {$ENDIF}
end;

end.
