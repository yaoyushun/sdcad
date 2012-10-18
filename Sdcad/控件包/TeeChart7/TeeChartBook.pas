unit TeeChartBook;
{$I TeeDefs.inc}

interface

uses
  Windows, Messages,
  SysUtils, Classes,
  Graphics, Controls, Forms, Dialogs, Menus, ComCtrls, ExtCtrls,
  Chart, TeeComma;

type
   TChartBook=class(TPageControl)
   private
     Toolbar,
     DeleteItem : TMenuItem;
     FOnNew : TNotifyEvent;
     Function CreateToolBar(AChart:TCustomChart):TTeeCommander;
     Procedure DeleteClick(Sender:TObject);
     Procedure EditClick(Sender:TObject);
     Procedure NewClick(Sender:TObject);
     Procedure Popup(Sender:TObject);
     Procedure RenameClick(Sender:TObject);
     Procedure ToolbarClick(Sender:TObject);
   public
     Constructor Create(AOwner:TComponent); override;
     Destructor Destroy; override;

     Function ActiveChart:TCustomChart;
     Function ActiveToolbar:TTeeCommander;
     Procedure AddChart(Const AName:String);
   published
     property PopupMenu stored False;
     property TabPosition default tpBottom;
     property OnNewChart:TNotifyEvent read FOnNew write FOnNew;
   end;

procedure Register;

implementation

uses TeeConst, TeeProcs, EditChar;

procedure Register;
begin
  RegisterComponents(TeeMsg_TeeChartPalette, [TChartBook]);
end;

{ TChartBook }

constructor TChartBook.Create(AOwner: TComponent);
var P:TPopupMenu;
begin
  inherited;
  TabPosition:=tpBottom;
  P:=TPopupMenu.Create(Self);
  P.Items.Add(TMenuItem.Create(Self));
  P.Items[0].Caption:='&New';
  P.Items[0].OnClick:=NewClick;
  DeleteItem:=TMenuItem.Create(Self);
  P.Items.Add(DeleteItem);
  DeleteItem.Caption:='&Delete';
  DeleteItem.OnClick:=DeleteClick;
  P.Items.Add(TMenuItem.Create(Self));
  P.Items[2].Caption:='&Rename...';
  P.Items[2].OnClick:=RenameClick;
  P.Items.Add(TMenuItem.Create(Self));
  P.Items[3].Caption:='&Edit...';
  P.Items[3].OnClick:=EditClick;
  ToolBar:=TMenuItem.Create(Self);
  P.Items.Add(Toolbar);
  Toolbar.Caption:='&View Toolbar';
  P.Items[4].OnClick:=ToolbarClick;
  PopupMenu:=P;
  P.OnPopup:=Popup;
end;

Procedure TChartBook.Popup(Sender:TObject);
begin
  DeleteItem.Enabled:=PageCount>1;
  Toolbar.Checked:=(ActiveToolBar<>nil);
end;

Procedure TChartBook.EditClick(Sender:TObject);
begin
  EditChart(nil,ActiveChart);
end;

Function TChartBook.ActiveChart:TCustomChart;
begin
  result:=ActivePage.Controls[0] as TCustomChart;
end;

Procedure TChartBook.DeleteClick(Sender:TObject);
var tmp : Integer;
begin
  tmp:=ActivePage.TabIndex;
  ActivePage.Free;
  if tmp>0 then ActivePage:=Pages[tmp-1];
end;

Procedure TChartBook.ToolbarClick(Sender:TObject);
begin
  if ActiveToolbar=nil then
     ActivePage.InsertControl(CreateToolBar(ActiveChart));
  Toolbar.Checked:=not Toolbar.Checked;
  ActiveToolbar.Visible:=Toolbar.Checked;
end;

Procedure TChartBook.NewClick(Sender:TObject);
begin
  AddChart('Chart'+IntToStr(PageCount+1));
  ActivePage:=Pages[PageCount-1];
  if Assigned(FOnNew) then FOnNew(Self);
end;

Function TChartBook.CreateToolBar(AChart:TCustomChart):TTeeCommander;
var B:TBevel;
begin
  result:=TTeeCommander.Create(Owner);
  with result do
  begin
    Align:=alTop;
    BevelOuter:=bvNone;
    Panel:=AChart;
    B:=TBevel.Create(Owner);
    B.Height:=1;
    B.Shape:=bsBottomLine;
    B.Style:=bsLowered;
    B.Align:=alBottom;
    InsertControl(B);
  end;
end;

Procedure TChartBook.AddChart(Const AName:String);
var C: TChart;
begin
  With TTabSheet.Create(Self) do
  begin
    Caption:=AName;
    C:=TChart.Create(Self);
    C.Align:=alClient;
    C.BevelOuter:=bvNone;
    InsertControl(C);
    InsertControl(CreateToolbar(C));
    PageControl:=Self;
  end;
end;

procedure TChartBook.RenameClick(Sender: TObject);
var tmp:String;
begin
  tmp:=ActivePage.Caption;
  if InputQuery('Rename Chart page','New name:',tmp) then
     ActivePage.Caption:=tmp;
end;

function TChartBook.ActiveToolbar: TTeeCommander;
var t:Integer;
begin
  if Assigned(ActivePage) then
  With ActivePage do
  for t:=0 to ControlCount-1 do
  if Controls[t] is TTeeCommander then
  begin
    result:=Controls[t] as TTeeCommander;
    exit;
  end;
  result:=nil;
end;

destructor TChartBook.Destroy;
begin
  if PopupMenu.Owner=Self then PopupMenu.Free;
  inherited;
end;

end.
