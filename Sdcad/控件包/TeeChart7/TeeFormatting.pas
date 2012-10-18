{**********************************************}
{   TeeChart Formatting Editor                 }
{   Copyright (c) 2001-2004 by David Berneda   }
{   All Rights Reserved.                       }
{**********************************************}
unit TeeFormatting;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  SysUtils, Classes, TeCanvas, TeeProcs, TeEngine, Chart, TeePenDlg;

type
  TFormatEditor = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    CBCustom: TComboFlat;
    CBDate: TComboFlat;
    RBDate: TRadioButton;
    RBCustom: TRadioButton;
    RBGeo: TRadioButton;
    CBGeo: TComboFlat;
    Panel2: TPanel;
    RBInteger: TRadioButton;
    CBPercent: TCheckBox;
    CBThousands: TCheckBox;
    CBCurrency: TCheckBox;
    CBFixedDecimals: TCheckBox;
    UpDown1: TUpDown;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBDateChange(Sender: TObject);
    procedure CBCustomChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBPercentClick(Sender: TObject);
    procedure CBThousandsClick(Sender: TObject);
    procedure CBGeoChange(Sender: TObject);
    procedure RBIntegerClick(Sender: TObject);
  private
    { Private declarations }
    tmpChanging : Boolean;
    Procedure AddDate(Const S:String);
    Procedure AddGeo(Const S:String);
  public
    { Public declarations }
    Format : String;
    IsDate : Boolean;
    IsGeo  : Boolean;
    Function TheFormat:String;
    class Function Change(AOwner:TComponent; const AFormat:String; AllowDates:Boolean=True):String;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF D6}
uses
  StrUtils;
{$ENDIF}

{$IFNDEF D6}  // From Borland's Delphi 6 StrUtils unit, for Delphi 4,5.
function DupeString(const AText: string; ACount: Integer): string;
var
  P: PChar;
  C: Integer;
begin
  C := Length(AText);
  SetLength(Result, C * ACount);
  P := Pointer(Result);
  if P = nil then Exit;
  while ACount > 0 do
  begin
    Move(Pointer(AText)^, P^, C);
    Inc(P, C);
    Dec(ACount);
  end;
end;
{$ENDIF}

procedure TFormatEditor.RadioGroup1Click(Sender: TObject);
begin
  if tmpChanging then exit;

  IsDate:=RBDate.Checked;
  IsGeo:=RBGeo.Checked;

  if RBDate.Checked or RBGeo.Checked or RBCustom.Checked then
     RBInteger.Checked:=False;

  CBDate.Enabled:=IsDate;
  CBGeo.Enabled:=RBGeo.Checked;
  CBCustom.Enabled:=RBCustom.Checked;

  if RBDate.Checked then
  begin
    EnableControls(False,[Edit1,UpDown1]);

    if CBDate.Text='' then CBDate.Text:=ShortDateFormat;
    CBDate.SetFocus;
  end
  else
  if RBGeo.Checked then
  begin
    EnableControls(False,[Edit1,UpDown1]);
    if CBGeo.Text='' then CBGeo.Text:=CBGeo.Items[0];
    CBGeo.SetFocus;
  end
  else
  begin
    CBPercent.Enabled:=not CBCustom.Enabled;

    if CBCustom.Enabled then
    begin
      if CBCustom.Text='' then CBCustom.Text:=TheFormat;
      CBCustom.SetFocus;
    end;
  end;
end;

function TFormatEditor.TheFormat: String;
var t : Integer;
begin
  if CBCustom.Enabled then
     result:=CBCustom.Text
  else
  if RBInteger.Checked then
  begin
    if CBCurrency.Checked then result:=CurrencyString
                          else result:='';

    if UpDown2.Position=0 then
       if CBThousands.Checked then result:=result+'#,###'
                              else result:=result+'#'
    else
    begin
      if CBThousands.Checked then
      begin
        if UpDown2.Position>3 then
           result:=result+DupeString('0',UpDown2.Position-3)+',000'
        else
           result:=result+'#,'+DupeString('#',3-UpDown2.Position)+DupeString('0',UpDown2.Position);
      end
      else
      for t:=1 to UpDown2.Position do
          result:=result+'0';
    end;

    if UpDown1.Position>0 then
       if CBFixedDecimals.Checked then
          result:=result+'.'+DupeString('0',UpDown1.Position)
       else
          result:=result+'.'+DupeString('#',UpDown1.Position);

    if CBPercent.Checked then result:=result+'%';
  end
  else
  if RBDate.Checked then
     result:=CBDate.Text
  else
  if RBGeo.Checked then
     result:=CBGeo.Text
  else
     result:='';
end;

procedure TFormatEditor.FormShow(Sender: TObject);

  procedure SetIntegerRB;
  begin
    tmpChanging:=True;
    try
      RBInteger.Checked:=True;
    finally
      tmpChanging:=False;
    end;
  end;

var i : Integer;
    t : Integer;
    tmp : Integer;
    IsCustom : Boolean;
    OldFormat : String;
begin
  OldFormat:=Format;

  CBCustom.Items.Clear;
  CBCustom.Items.Add('#.#');
  CBCustom.Items.Add('0.0%');

  CBGeo.Items.Clear;
  CBGeo.Items.Add('ddd° mm'' ss".zzz');
  CBGeo.Items.Add('ddd mm'' ss".zzz');
  CBGeo.Items.Add('ddd deg mm'' ss".zzz');
  CBGeo.Items.Add('ddd mm'' ss".zzz');
  CBGeo.Items.Add('ddd mm ss.zzz');
  CBGeo.Items.Add('ddd mm ss');
  CBGeo.Items.Add('ddd mm');
  CBGeo.Items.Add('ddd°');
  CBGeo.Items.Add('ddd');


  if IsDate or (CBDate.Items.IndexOf(Format)<>-1) then
  begin
    CBDate.Enabled:=True;
    AddDate(Format);
    CBDate.Text:=Format;
    CBDate.SetFocus;

    tmpChanging:=True;
    try
      RBDate.Checked:=True;
    finally
      tmpChanging:=False;
    end;
  end
  else
  if IsGeo or (CBGeo.Items.IndexOf(Format)<>-1) then
  begin
    CBGeo.Enabled:=True;
    AddGeo(Format);
    CBGeo.Text:=Format;
    CBGeo.SetFocus;

    tmpChanging:=True;
    try
      RBGeo.Checked:=True;
    finally
      tmpChanging:=False;
    end;
  end
  else
  begin
    i:=Pos('%',Format);
    CBPercent.Checked:=i>0;
    CBPercentClick(Self);
    if i>0 then Delete(Format,i,1);

    i:=Pos(CurrencyString,Format);
    CBCurrency.Checked:=i>0;
    if i>0 then Delete(Format,i,Length(CurrencyString));

    i:=Pos(',',Format);
    CBThousands.Checked:=i>0;
    if i>0 then Delete(Format,i,1);

    i:=Pos('.',Format);
    if i>0 then
    begin
      SetIntegerRB;
      tmp:=0;
      while (Copy(Format,i+tmp+1,1)='#') or (Copy(Format,i+tmp+1,1)='0') do
         Inc(tmp);
      UpDown1.Position:=tmp;

      CBFixedDecimals.Checked:=(tmp>0) and (Copy(Format,i+1,1)='0');

      Delete(Format,i,tmp+1);
    end;

    IsCustom:=False;

    for t:=1 to Length(Format) do
    if (Format[t]<>'#') and (Format[t]<>'0') then
    begin
      IsCustom:=True;
      Format:=OldFormat;
      break;
    end;

    tmp:=0;
    if not IsCustom then
    begin
      SetIntegerRB;

      for t:=1 to Length(Format) do
      if Format[t]='0' then Inc(tmp);
      UpDown2.Position:=tmp;
    end
    else
    begin
      tmpChanging:=True;
      try
        RBCustom.Checked:=True;
      finally
        tmpChanging:=False;
      end;

      CBCustom.Enabled:=True;

      if CBCustom.Items.IndexOf(Format)=0 then
         CBCustom.Items.Add(Format);

      CBCustom.Text:=Format;
      CBCustom.SetFocus;
    end;
  end;

  TeeTranslateControl(Self);
end;

procedure TFormatEditor.CBDateChange(Sender: TObject);
begin
  Format:=CBDate.Text;
end;

procedure TFormatEditor.CBCustomChange(Sender: TObject);
begin
  Format:=CBCustom.Text;
end;

Procedure TFormatEditor.AddDate(Const S:String);
begin
  if CBDate.Items.IndexOf(S)=-1 then CBDate.Items.Add(S);
end;

Procedure TFormatEditor.AddGeo(Const S:String);
begin
  if CBGeo.Items.IndexOf(S)=-1 then CBGeo.Items.Add(S);
end;

procedure TFormatEditor.FormCreate(Sender: TObject);
begin
  AddDate(ShortDateFormat);
  AddDate(ShortTimeFormat);
end;

procedure TFormatEditor.CBPercentClick(Sender: TObject);
begin
  CBThousands.Enabled:=not CBPercent.Checked;
  CBCurrency.Enabled:=not CBPercent.Checked;

  if CBPercent.Checked then
  begin
    CBThousands.Checked:=False;
    CBCurrency.Checked:=False;
  end;
end;

procedure TFormatEditor.CBThousandsClick(Sender: TObject);
begin
  RadioGroup1Click(Sender);
end;

procedure TFormatEditor.CBGeoChange(Sender: TObject);
begin
  Format:=CBGeo.Text;
end;

procedure TFormatEditor.RBIntegerClick(Sender: TObject);
begin
  if RBInteger.Checked then
  begin
    RBDate.Checked:=False;
    RBGeo.Checked:=False;
    RBCustom.Checked:=False;
  end;

  RadioGroup1Click(Self);
end;

class function TFormatEditor.Change(AOwner:TComponent; const AFormat: String; AllowDates:Boolean=True): String;
begin
  with TFormatEditor.Create(AOwner) do
  try
    Format:=AFormat;

    Panel1.Visible:=AllowDates;
    AddDefaultValueFormats(CBCustom.Items);
    if ShowModal=mrOk then result:=TheFormat
                      else result:=AFormat;

  finally
    Free;
  end;
end;

end.
