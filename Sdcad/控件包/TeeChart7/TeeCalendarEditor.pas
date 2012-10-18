{********************************************}
{    TeeChart Pro Charting Library           }
{    Calendar Series Editor                  }
{  Copyright (c) 1995-2004 by David Berneda  }
{         All Rights Reserved                }
{********************************************}
unit TeeCalendarEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeCanvas, TeeProcs, TeePenDlg, TeeCustomShapeEditor, TeeCalendar;

type
  TCalendarSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    ButtonPen1: TButtonPen;
    CBWeekDays: TCheckBox;
    CBWeekUpper: TCheckBox;
    CBTrailing: TCheckBox;
    CBToday: TCheckBox;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    PageControl4: TPageControl;
    TabSheet5: TTabSheet;
    PageControl5: TPageControl;
    TabSheet6: TTabSheet;
    PageControl6: TPageControl;
    CBMonths: TCheckBox;
    TabSheet7: TTabSheet;
    PageControl7: TPageControl;
    CBMonthUpper: TCheckBox;
    CBPrevious: TCheckBox;
    CBNext: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBWeekDaysClick(Sender: TObject);
    procedure CBWeekUpperClick(Sender: TObject);
    procedure CBTrailingClick(Sender: TObject);
    procedure CBTodayClick(Sender: TObject);
    procedure CBMonthsClick(Sender: TObject);
    procedure CBMonthUpperClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
    IDays,
    ISunday,
    IToday,
    ITrailing,
    IMonths,
    IWeekDays : TFormTeeShape;
    Calendar  : TCalendarSeries;
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeConst;

procedure TCalendarSeriesEditor.FormShow(Sender: TObject);

  Procedure Check(AForm:TFormTeeShape);
  begin
    AForm.RefreshControls(AForm.TheShape);
  end;

begin
  Calendar:=TCalendarSeries(Tag);
  if Assigned(Calendar) then
  begin
    With Calendar do
    begin
      ButtonPen1.LinkPen(Pen);
      IDays:=InsertTeeObjectForm(PageControl2,Days);
      IWeekDays:=InsertTeeObjectForm(PageControl3,WeekDays);
      ISunday:=InsertTeeObjectForm(PageControl5,Sunday);
      ITrailing:=InsertTeeObjectForm(PageControl6,Trailing);
      IToday:=InsertTeeObjectForm(PageControl4,Today);
      IMonths:=InsertTeeObjectForm(PageControl7,Months);

      CBWeekDays.Checked:=WeekDays.Visible;
      CBTrailing.Checked:=Trailing.Visible;
      CBMonths.Checked:=Months.Visible;
      CBToday.Checked:=Today.Visible;
      CBWeekUpper.Checked:=WeekDays.UpperCase;
      CBMonthUpper.Checked:=Months.UpperCase;
      CBPrevious.Checked:=PreviousMonthButton.Visible;
      CBNext.Checked:=NextMonthButton.Visible;
    end;
    Check(IDays);
    Check(IWeekDays);
    Check(IToday);
    Check(ISunday);
    Check(ITrailing);
    Check(IMonths);

    Align:=alClient; { align Form to parent container }
  end;

  if not TeeLanguageCanUpper then
  begin
    CBWeekUpper.Visible:=False;
    CBMonthUpper.Visible:=False;
  end;
end;

procedure TCalendarSeriesEditor.CBWeekDaysClick(Sender: TObject);
begin
  Calendar.WeekDays.Visible:=CBWeekDays.Checked;
end;

procedure TCalendarSeriesEditor.CBWeekUpperClick(Sender: TObject);
begin
  Calendar.WeekDays.UpperCase:=CBWeekUpper.Checked;
end;

procedure TCalendarSeriesEditor.CBTrailingClick(Sender: TObject);
begin
  Calendar.Trailing.Visible:=CBTrailing.Checked;
end;

procedure TCalendarSeriesEditor.CBTodayClick(Sender: TObject);
begin
  Calendar.Today.Visible:=CBToday.Checked;
end;

procedure TCalendarSeriesEditor.CBMonthsClick(Sender: TObject);
begin
  Calendar.Months.Visible:=CBMonths.Checked;
end;

procedure TCalendarSeriesEditor.CBMonthUpperClick(Sender: TObject);
begin
  Calendar.Months.UpperCase:=CBMonthUpper.Checked;
end;

procedure TCalendarSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  Calendar.PreviousMonthButton.Visible:=(Sender as TCheckBox).Checked;
end;

procedure TCalendarSeriesEditor.CheckBox2Click(Sender: TObject);
begin
  Calendar.NextMonthButton.Visible:=(Sender as TCheckBox).Checked;
end;

initialization
  RegisterClass(TCalendarSeriesEditor);
end.
