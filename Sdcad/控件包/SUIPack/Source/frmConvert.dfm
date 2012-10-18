object frmConv: TfrmConv
  Left = 375
  Top = 225
  BorderStyle = bsDialog
  Caption = 'SUIPack - Convertor Utility'
  ClientHeight = 170
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 223
    Height = 13
    Caption = 'This will lead the standard form to be converted'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 197
    Height = 13
    Caption = ' to the form using SUIPack components...'
  end
  object Label3: TLabel
    Left = 16
    Top = 72
    Width = 66
    Height = 13
    Caption = 'Target theme:'
  end
  object cb_theme: TComboBox
    Left = 96
    Top = 68
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Text = 'MacOS'
    Items.Strings = (
      'MacOS'
      'WinXP'
      'DeepBlue'
      'Protein'
      'BlueGlass')
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
