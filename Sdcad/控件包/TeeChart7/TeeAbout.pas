{**********************************************}
{   TeeChart Pro and TeeTree VCL About Form    }
{   Copyright (c) 1995-2004 by David Berneda   }
{**********************************************}
unit TeeAbout;
{$I TeeDefs.inc}

interface

uses {$IFDEF LINUX}
     Libc,
     {$ELSE}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     Qt, QGraphics, QControls, QForms, QExtCtrls, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, ExtCtrls, StdCtrls,
     {$ENDIF}
     Classes, SysUtils;

type
  TTeeAboutForm = class(TForm)
    BClose: TButton;
    Image2: TImage;
    LabelCopy: TLabel;
    LabelVersion: TLabel;
    Label1: TLabel;
    Labelwww: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    LabelEval: TLabel;
    Timer1: TTimer;
    procedure LabelwwwClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    StartColor : TColor;
    EndColor   : TColor;
    Delta      : Integer;
  public
    { Public declarations }
  end;

  TeeWindowHandle={$IFDEF CLX}QOpenScrollViewH{$ELSE}Integer{$ENDIF};

Procedure GotoURL(Handle:TeeWindowHandle; Const URL:String);

{ Displays the TeeChart about-box dialog }
Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');

Var TeeAboutBoxProc:Procedure=nil;
    TeeIsTrial:Boolean=False;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFNDEF LINUX}
     ShellApi,
     {$ENDIF}
     {$IFDEF CLR}
     System.Reflection,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeConst;

Procedure TeeShowAboutBox(Const ACaption:String=''; Const AVersion:String='');
var tmp : TTeeAboutForm;
begin
  tmp:=TTeeAboutForm.Create(nil);
  with tmp do
  try
    if ACaption<>'' then Caption:=ACaption;
    if AVersion<>'' then LabelVersion.Caption:=AVersion;
  
    if TeeIsTrial then
       LabelEval.Caption:=LabelEval.Caption+' TRIAL';

    TeeTranslateControl(tmp);
    ShowModal;
  finally
    Free;
  end;
end;

Procedure GotoURL(Handle: TeeWindowHandle; Const URL:String);
{$IFNDEF LINUX}
{$IFNDEF CLR}
Var St : TeeString256;
{$ENDIF}
{$ENDIF}
begin
  {$IFNDEF LINUX}
  ShellExecute({$IFDEF CLX}0{$ELSE}Handle{$ENDIF},'open',
               {$IFDEF CLR}URL{$ELSE}StrPCopy(St,URL){$ENDIF},
               nil,
               {$IFDEF CLR}''{$ELSE}nil{$ENDIF},
               SW_SHOW);  { <-- do not translate }
  {$ENDIF}
end;

procedure TTeeAboutForm.LabelwwwClick(Sender: TObject);
begin
  GotoURL(Handle,LabelWWW.Caption);
end;

procedure TTeeAboutForm.FormPaint(Sender: TObject);
begin
  {$IFNDEF CLX}  // CLX repaints on top of form !
  With TTeeCanvas3D.Create do
  try
    ReferenceCanvas:=Self.Canvas;
    GradientFill(ClientRect,StartColor,EndColor,gdDiagonalUp);
  finally
    Free;
  end;
  {$ENDIF}
end;

procedure TTeeAboutForm.FormCreate(Sender: TObject);
begin
  {$IFNDEF CLX}
  DoubleBuffered:=True;
  {$ENDIF}
  
  StartColor:=$E0E0E0;
  EndColor:=clDkGray;
  Delta:=4;

  Caption:=Caption+' '+TeeMsg_Version;
  LabelVersion.Caption:=TeeMsg_Version {$IFDEF CLX}+' CLX'{$ENDIF};

  {$IFDEF CLR}
  LabelVersion.Caption:=LabelVersion.Caption+'   '+
      System.Reflection.Assembly.GetExecutingAssembly.GetName.Version.ToString;
  LabelVersion.AutoSize:=True;
  {$ENDIF}

  LabelCopy.Caption:=TeeMsg_Copyright;
  BorderStyle:=TeeBorderStyle;
end;

Procedure TeeShowAboutBox2;
begin
  if Assigned(TeeAboutBoxProc) then
  begin
    TeeShowAboutBox;
    TeeAboutBoxProc:=nil;
  end;
end;

procedure TTeeAboutForm.Timer1Timer(Sender: TObject);

  procedure ChangeColor(var C:TColor; N:Integer);

    procedure Add(var B:Byte);
    begin
      if N>0 then
         if B+N<256 then B:=B+N else B:=255
      else
         if B+N>0 then B:=B+N else B:=0;
    end;

  var tmp : TColor;
      R,G,B : Byte;
  begin
    tmp:=ColorToRGB(C);
    R:=GetRValue(tmp);
    G:=GetGValue(tmp);
    B:=GetBValue(tmp);

    Add(R);
    Add(G);
    Add(B);

    C:=RGB(R,G,B);
  end;

begin
  ChangeColor(StartColor,-Delta);
  ChangeColor(EndColor,Delta);

  if (StartColor=ColorToRGB(clBlack)) or
     (EndColor=ColorToRGB(clBlack)) then
       Delta:=-Delta;

  Invalidate;
end;

initialization
  TeeAboutBoxProc:=TeeShowAboutBox2;
finalization
  TeeAboutBoxProc:=nil;
end.
