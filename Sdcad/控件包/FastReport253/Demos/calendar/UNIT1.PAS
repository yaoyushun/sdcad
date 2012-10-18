unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Class;

type
  TForm1 = class(TForm)
    frReport1: TfrReport;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure frReport1UserFunction(const Name: string; p1, p2,
      p3: Variant; var Val: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;


{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Randomize;
  frVariables['Year'] := 2000;
  frReport1.ShowReport;
end;

function YourColorFunction(Date: TDateTime): TColor;
begin
// random colors
  Result := frColors[Random(16)];
end;

procedure TForm1.frReport1UserFunction(const Name: string; p1, p2,
  p3: Variant; var Val: Variant);
var
  y, m, d: Word;
begin
  if AnsiCompareText(Name, 'StartOfMonth') = 0 then
  begin
    m := frParser.Calc(p1);
    y := frParser.Calc(p2);
    Val := DayOfWeek(EncodeDate(y, m, 1));
  end;
  if AnsiCompareText(Name, 'DaysInMonth') = 0 then
  begin
    m := frParser.Calc(p1);
    y := frParser.Calc(p2);
    Val := DaysPerMonth(y, m);
  end;
  if AnsiCompareText(Name, 'DayColor') = 0 then
  begin
    d := frParser.Calc(p1);
    m := frParser.Calc(p2);
    y := frParser.Calc(p3);
    Val := YourColorFunction(EncodeDate(y, m, d));
  end;
end;

end.
