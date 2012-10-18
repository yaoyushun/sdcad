{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2004 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeSelectList;
{$I TeeDefs.inc}

interface

uses {$IFDEF CLR}
     Classes,
     Borland.VCL.Controls,
     Borland.VCL.Forms,
     Borland.VCL.StdCtrls,
     Borland.VCL.ExtCtrls,
     Borland.VCL.Buttons,
     {$ELSE}
     {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
     {$ENDIF}
     {$ENDIF}
     TeeProcs;

type
  TSelectListForm = class(TForm)
    FromList: TListBox;
    ToList: TListBox;
    Panel1: TPanel;
    BMoveUP: TSpeedButton;
    BMoveDown: TSpeedButton;
    Panel2: TPanel;
    L22: TLabel;
    L24: TLabel;
    Panel3: TPanel;
    BRightOne: TButton;
    BRightAll: TButton;
    BLeftOne: TButton;
    BLeftAll: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BMoveUPClick(Sender: TObject);
    procedure ToListDblClick(Sender: TObject);
    procedure FromListDblClick(Sender: TObject);
    procedure BLeftAllClick(Sender: TObject);
    procedure BRightAllClick(Sender: TObject);
    procedure BLeftOneClick(Sender: TObject);
    procedure BRightOneClick(Sender: TObject);
    procedure ToListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Changed;
  public
    { Public declarations }
    OnChange : TNotifyEvent;
    procedure EnableButtons;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeePenDlg;

procedure TSelectListForm.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  TeeLoadArrowBitmaps(BMoveUp.Glyph,BMoveDown.Glyph);
end;

procedure TSelectListForm.Changed;
begin
  EnableButtons;
  if Assigned(OnChange) then OnChange(Self);
end;

procedure TSelectListForm.BMoveUPClick(Sender: TObject);
var tmp  : Integer;
    tmp2 : Integer;
begin
  if Sender=BMoveUp then tmp:=-1 else tmp:=1;
  with ToList do
  begin
    tmp2:=ItemIndex;
    Items.Exchange(ItemIndex,ItemIndex+tmp);
    ItemIndex:=tmp2+tmp; { 5.03 }
  end;
  ToList.SetFocus;
  Changed;
end;

procedure TSelectListForm.ToListDblClick(Sender: TObject);
begin
  BLeftOneClick(Self);
end;

procedure TSelectListForm.FromListDblClick(Sender: TObject);
begin
  BRightOneClick(Self);
  ToList.ItemIndex:=ToList.Items.Count-1;
  EnableButtons;
end;

procedure TSelectListForm.BLeftAllClick(Sender: TObject);
begin
  MoveListAll(ToList.Items,FromList.Items);
  Changed;
end;

procedure TSelectListForm.BRightAllClick(Sender: TObject);
begin
  MoveListAll(FromList.Items,ToList.Items);
  Changed;
end;

procedure TSelectListForm.BLeftOneClick(Sender: TObject);
begin
  MoveList(ToList,FromList);
  Changed;
end;

procedure TSelectListForm.BRightOneClick(Sender: TObject);
begin
  MoveList(FromList,ToList);
  Changed;
  if FromList.Items.Count=0 then ToList.SetFocus;
end;

procedure TSelectListForm.ToListClick(Sender: TObject);
begin
  EnableButtons;
end;

procedure TSelectListForm.EnableButtons;
begin
  BRightOne.Enabled:=FromList.Items.Count>0;
  BRightAll.Enabled:=BRightOne.Enabled;
  BLeftOne.Enabled :=ToList.Items.Count>0;
  BLeftAll.Enabled :=BLeftOne.Enabled;
  BMoveUp.Enabled  :=ToList.ItemIndex>0;
  BMoveDown.Enabled:=(ToList.ItemIndex>-1) and (ToList.ItemIndex<ToList.Items.Count-1);
end;

procedure TSelectListForm.FormShow(Sender: TObject);
begin
  EnableButtons;
  if FromList.Items.Count>0 then FromList.SetFocus
                            else ToList.SetFocus;
end;

end.
