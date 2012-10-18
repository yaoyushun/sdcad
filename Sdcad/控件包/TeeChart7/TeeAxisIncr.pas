{**********************************************}
{   TAxisIncrement Dialog Editor               }
{   Copyright (c) 1996-2004 David Berneda      }
{**********************************************}
unit TeeAxisIncr;
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
     Chart, TeEngine, TeeProcs, TeCanvas;

type
  TAxisIncrement = class(TForm)
    RadioGroup1: TRadioGroup;
    CBSteps: TComboFlat;
    ECustom: TEdit;
    BOk: TButton;
    BCancel: TButton;
    Label1: TLabel;
    CBExact: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BOkClick(Sender: TObject);
    procedure CBExactClick(Sender: TObject);
    procedure CBStepsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure SetEditText;
  public
    { Public declarations }
    IsDateTime : Boolean;
    IsExact    : Boolean;
    Increment  : Double;
    IStep      : TDateTimeStep;
  end;

Function GetIncrementText( AOwner:TComponent;
                           Const Increment:Double;
                           IsDateTime,
                           ExactDateTime:Boolean;
                           Const AFormat:String):String;

{ Show message to user, with "Incorrect" text }
Procedure TeeShowIncorrect(Const Message:String);

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst;

Procedure TeeShowIncorrect(Const Message:String);
begin
  ShowMessage(Format(TeeMsg_IncorrectMaxMinValue,[Message]));
end;

procedure TAxisIncrement.FormShow(Sender: TObject);
var tmpDif:Integer;
begin
  CBExact.Visible:=IsDateTime;
  CBExact.Enabled:=RadioGroup1.ItemIndex=0;
  CBExact.Checked:=IsExact;

  if IsDateTime then
  begin
    ECustom.Hint:=TeeMsg_EnterDateTime;
    SetEditText;

    if IsExact and (IStep<>dtNone) then
    Begin
      RadioGroup1.ItemIndex:=0;
      CBSteps.ItemIndex:=Ord(IStep);
      ECustom.Text:='';
      ECustom.Enabled:=False;
      CBSteps.SetFocus;
    end
    else
    begin
      RadioGroup1.ItemIndex:=1;
      CBSteps.ItemIndex:=-1;
    end;

  end
  else
  begin

    CBSteps.Visible:=False;
    RadioGroup1.Visible:=False;
    RadioGroup1.ItemIndex:=1;
    ECustom.Hint:='';
    ECustom.Text:=FloatToStr(Increment);
    tmpDif:=ECustom.Top-Label1.Top;
    ECustom.Top:=BOK.Top;
    Label1.Top:=ECustom.Top-tmpDif;
    ECustom.SetFocus;
  end;
end;

Procedure TAxisIncrement.SetEditText;
Begin
  if Increment<=0 then ECustom.Text:=TimeToStr(DateTimeStep[dtOneSecond])
  else
  if Increment>=1 then
  Begin
    ECustom.Text:=FloatToStr(Int(Increment));
    if Frac(Increment)<>0 then
       ECustom.Text:=ECustom.Text+' '+TimeToStr(Frac(Increment));
  end
  else ECustom.Text:=TimeToStr(Increment);
end;

procedure TAxisIncrement.RadioGroup1Click(Sender: TObject);

  Procedure DoEnableControls(Value:Boolean);
  begin
    ECustom.Enabled:=not Value;
    CBExact.Checked:=Value;
    IsExact:=Value;
    CBExact.Enabled:=Value;
    CBSteps.Enabled:=Value;
  end;

begin
  Case RadioGroup1.ItemIndex of
    0: Begin
         DoEnableControls(True);
         if IStep<>dtNone then
            CBSteps.ItemIndex:=Ord(IStep)
         else
            CBSteps.ItemIndex:=0;
         CBSteps.SetFocus;
       end;
    1: Begin
         DoEnableControls(False);
         SetEditText;
         ECustom.SetFocus;
       end;
  end;
end;

procedure TAxisIncrement.BOkClick(Sender: TObject);
const tmpSpace:String=' ';
var i    : Integer;
    Code : Integer;
    tmp  : Double;
begin
  try
    if IsDateTime then
    Begin
      if RadioGroup1.ItemIndex=0 then
         Increment:=DateTimeStep[TDateTimeStep(CBSteps.ItemIndex)]
      else
      With ECustom do
      Begin
        i:={$IFDEF CLR}Pos{$ELSE}AnsiPos{$ENDIF}(tmpSpace,Text);
        if i=0 then
        try
          Val(Text,tmp,Code);
          if Code=0 then Increment:=tmp
                    else Increment:=StrToTime(Text);
        except
          on Exception do Increment:=StrToFloat(Text);
        end
        else Increment:=StrToFloat(Copy(Text,1,i-1))+
                        StrToTime(Copy(Text,i+1,255));
      end;
    end
    else Increment:=StrToFloat(ECustom.Text);

    ModalResult:=mrOk;

  except
    on E:Exception do TeeShowIncorrect(E.Message);
  end;
end;

procedure TAxisIncrement.CBExactClick(Sender: TObject);
begin
  IsExact:=CBExact.Checked;
  if not IsExact then
  begin
    RadioGroup1.ItemIndex:=1;
    ECustom.Enabled:=True;
    SetEditText;
    ECustom.SetFocus;
  end;
end;

procedure TAxisIncrement.CBStepsChange(Sender: TObject);
begin
  IStep:=TDateTimeStep(CBSteps.ItemIndex);
end;

Function GetIncrementText( AOwner:TComponent;
                           Const Increment:Double;
                           IsDateTime,
                           ExactDateTime:Boolean;
                           Const AFormat:String):String;

  Function GetDateTimeStepText(tmp:TDateTimeStep):String;
  begin
    result:='';
    With TAxisIncrement.Create(AOwner) do
    try
      result:=CBSteps.Items[Ord(tmp)];
    finally
      Free;
    end;
  end;

var tmp : TDateTimeStep;
begin
  if IsDateTime then
  begin
    tmp:=FindDateTimeStep(Increment);
    if ExactDateTime and (tmp<>dtNone) then result:=GetDateTimeStepText(tmp)
    else
    if Increment<=0 then result:=TimeToStr(DateTimeStep[dtOneSecond])
    else
    if Increment<=1 then result:=TimeToStr(Increment)
    else
    Begin
      result:=FloatToStr(Int(Increment));
      if Frac(Increment)<>0 then result:=result+' '+TimeToStr(Frac(Increment));
    end;
  end
  else result:=FormatFloat(AFormat,Increment);
end;

procedure TAxisIncrement.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

end.
