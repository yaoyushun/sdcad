unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, SUIPageControl, SUITabControl, ExtCtrls, SUIForm, SUIImagePanel,
  SUIGroupBox, SUIRadioGroup, SUIScrollBar, Menus, SUIMainMenu, SUIButton,
  StdCtrls, SUIMemo, SUIProgressBar, SUITrackBar, ComCtrls, SUIStatusBar,
  SUIFontComboBox, SUIComboBox, SUIColorBox, SUISideChannel, jpeg, SUIMgr,
  SUIEdit, SUIURLLabel, SUIDlg, ShellAPI;

type
  TForm1 = class(TForm)
    suiForm1: TsuiForm;
    suiPageControl1: TsuiPageControl;
    suiTabSheet1: TsuiTabSheet;
    suiTabSheet2: TsuiTabSheet;
    suiTabSheet3: TsuiTabSheet;
    suiRadioGroup1: TsuiRadioGroup;
    suiCheckGroup1: TsuiCheckGroup;
    suiMainMenu1: TsuiMainMenu;
    File1: TMenuItem;
    Online1: TMenuItem;
    Help1: TMenuItem;
    Exit1: TMenuItem;
    suiButton1: TsuiButton;
    OpenDialog1: TOpenDialog;
    suiMemo1: TsuiMemo;
    suiScrollBar2: TsuiScrollBar;
    suiTrackBar1: TsuiTrackBar;
    suiProgressBar1: TsuiProgressBar;
    suiFontComboBox1: TsuiFontComboBox;
    suiFontSizeComboBox1: TsuiFontSizeComboBox;
    suiScrollBar1: TsuiScrollBar;
    suiColorBox1: TsuiColorBox;
    suiSideChannel1: TsuiSideChannel;
    suiPanel1: TsuiPanel;
    Shape1: TShape;
    Shape2: TShape;
    suiPanel2: TsuiPanel;
    suiCheckBox1: TsuiCheckBox;
    suiCheckBox2: TsuiCheckBox;
    suiPanel3: TsuiPanel;
    suiImagePanel1: TsuiImagePanel;
    suiRadioButton1: TsuiRadioButton;
    suiRadioButton2: TsuiRadioButton;
    suiRadioButton3: TsuiRadioButton;
    suiTabSheet4: TsuiTabSheet;
    suiThemeManager1: TsuiThemeManager;
    suiFileTheme1: TsuiFileTheme;
    suiButton2: TsuiButton;
    suiRadioGroup2: TsuiRadioGroup;
    suiGroupBox1: TsuiGroupBox;
    suiButton3: TsuiButton;
    suiButton4: TsuiButton;
    suiGroupBox2: TsuiGroupBox;
    suiButton5: TsuiButton;
    suiEdit1: TsuiEdit;
    suiInputDialog1: TsuiInputDialog;
    suiPasswordDialog1: TsuiPasswordDialog;
    suiMessageDialog1: TsuiMessageDialog;
    OrderSUIPack1: TMenuItem;
    Productpage1: TMenuItem;
    N1: TMenuItem;
    Sunisofthomepage1: TMenuItem;
    SUIPackhelp1: TMenuItem;
    N2: TMenuItem;
    About1: TMenuItem;
    suiStatusBar1: TsuiStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure suiRadioGroup1Click(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure suiTrackBar1Change(Sender: TObject);
    procedure suiScrollBar1Change(Sender: TObject);
    procedure suiColorBox1Change(Sender: TObject);
    procedure suiFontComboBox1Change(Sender: TObject);
    procedure suiFontSizeComboBox1Change(Sender: TObject);
    procedure suiRadioButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure suiButton5Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OrderSUIPack1Click(Sender: TObject);
    procedure Productpage1Click(Sender: TObject);
    procedure Sunisofthomepage1Click(Sender: TObject);
    procedure SUIPackhelp1Click(Sender: TObject);
    procedure suiForm1TitleBarHelpBtnClick(Sender: TObject;
      ButtonIndex: Integer);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses SUIThemes, Unit2;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
    i : Integer;
begin
    for i := 0 to suiCheckGroup1.Items.Count - 1 do
        suiCheckGroup1.Checked[i] := true;
    suiFontComboBox1.FontName := suiMemo1.Font.Name;
    suiColorBox1.Selected := suiMemo1.Font.Color;
    suiFontSizeComboBox1.FontName := suiFontComboBox1.FontName;
    suiFontSizeComboBox1.FontSize := suiMemo1.Font.Size;
end;

procedure TForm1.suiRadioGroup1Click(Sender: TObject);
begin
//    Application.Minimize();
    Hide();
    case suiRadioGroup1.ItemIndex of
    0 : suiThemeManager1.UIStyle := MacOS;
    1 : suiThemeManager1.UIStyle := WinXP;
    2 : suiThemeManager1.UIStyle := DeepBlue;
    3 : suiThemeManager1.UIStyle := Protein;
    4 : suiThemeManager1.UIStyle := BlueGlass;
    5 : suiThemeManager1.UIStyle := FromThemeFile;
    end;
//    Application.Restore();
    Show();
end;

procedure TForm1.suiButton1Click(Sender: TObject);
begin
    if OpenDialog1.Execute() then
    begin
        Hide();
        suiFileTheme1.ThemeFile := OpenDialog1.FileName;
        Show();
    end;
end;

procedure TForm1.suiTrackBar1Change(Sender: TObject);
begin
    suiProgressBar1.Position := 10 - suiTrackBar1.Position;
    suiScrollBar1.Position := suiTrackBar1.Position;
end;

procedure TForm1.suiScrollBar1Change(Sender: TObject);
begin
    suiTrackBar1.Position := suiScrollBar1.Position;
    suiProgressBar1.Position := 10 - suiScrollBar1.Position;
end;

procedure TForm1.suiColorBox1Change(Sender: TObject);
begin
    suiMemo1.Font.Color := suiColorBox1.Selected;
end;

procedure TForm1.suiFontComboBox1Change(Sender: TObject);
begin
    suiMemo1.Font.Name := suiFontComboBox1.FontName;
    suiFontSizeComboBox1.FontName := suiFontComboBox1.FontName;
    suiFontSizeComboBox1.FontSize := suiMemo1.Font.Size;
end;

procedure TForm1.suiFontSizeComboBox1Change(Sender: TObject);
begin
    suiMemo1.Font.Size := suiFontSizeComboBox1.FontSize;
end;

procedure TForm1.suiRadioButton1Click(Sender: TObject);
begin
    if suiRadioButton1.Checked then
        suiImagePanel1.DrawStyle := suiNormal
    else if suiRadioButton2.Checked then
        suiImagePanel1.DrawStyle := suiStretch
    else
        suiImagePanel1.DrawStyle := suiTile;
end;

procedure TForm1.suiButton2Click(Sender: TObject);
begin
    case suiRadioGroup2.ItemIndex of
    0 : suiMessageDialog1.IconType := suiHelp;
    1 : suiMessageDialog1.IconType := suiInformation;
    2 : suiMessageDialog1.IconType := suiStop;
    3 : suiMessageDialog1.IconType := suiWarning;
    4 : suiMessageDialog1.IconType := suiNone;
    end;
    suiMessageDialog1.ShowModal();
end;

procedure TForm1.suiButton3Click(Sender: TObject);
begin
    suiPasswordDialog1.Item1Text := '';
    suiPasswordDialog1.Item2Text := '';
    suiPasswordDialog1.Item1Caption := 'User name: ';
    suiPasswordDialog1.Item2Caption := 'Password: ';
    suiPasswordDialog1.Item1PasswordChar := #0;
    suiPasswordDialog1.Item2PasswordChar := '*';
    suiPasswordDialog1.UIStyle := suiForm1.UIStyle;
    suiPasswordDialog1.ShowModal();
end;

procedure TForm1.suiButton4Click(Sender: TObject);
begin
    suiPasswordDialog1.Item1Text := '';
    suiPasswordDialog1.Item2Text := '';
    suiPasswordDialog1.Item1Caption := 'Password: ';
    suiPasswordDialog1.Item2Caption := 'Confirm: ';
    suiPasswordDialog1.Item1PasswordChar := '*';
    suiPasswordDialog1.Item2PasswordChar := '*';
    suiPasswordDialog1.UIStyle := suiForm1.UIStyle;
    suiPasswordDialog1.ShowModal();
end;

procedure TForm1.suiButton5Click(Sender: TObject);
begin
    if suiInputDialog1.ShowModal() = mrOK then
        suiEdit1.Text := suiInputDialog1.ValueText;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
    Close();
end;

procedure TForm1.OrderSUIPack1Click(Sender: TObject);
begin
    ShellExecute(Handle, 'open', 'http://www.sunisoft.cn/suipack/buy.htm', nil, nil, SW_SHOW);
end;

procedure TForm1.Productpage1Click(Sender: TObject);
begin
    ShellExecute(Handle, 'open', 'http://www.sunisoft.cn/suipack/', nil, nil, SW_SHOW);
end;

procedure TForm1.Sunisofthomepage1Click(Sender: TObject);
begin
    ShellExecute(Handle, 'open', 'http://www.sunisoft.cn', nil, nil, SW_SHOW);
end;

procedure TForm1.SUIPackhelp1Click(Sender: TObject);
begin
    ShellExecute(Handle, 'open', 'suipack.chm', nil, nil, SW_SHOW);
end;

procedure TForm1.suiForm1TitleBarHelpBtnClick(Sender: TObject;
  ButtonIndex: Integer);
begin
    ShellExecute(Handle, 'open', 'suipack.chm', nil, nil, SW_SHOW);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
    Form2 := TForm2.Create(nil);
    Form2.ShowModal();
    Form2.Free();
end;

end.
