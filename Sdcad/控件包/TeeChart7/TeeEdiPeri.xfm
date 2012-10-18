inherited TeeFunctionEditor: TTeeFunctionEditor
  Left = 318
  Top = 224
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 42
    Top = 65
    Width = 49
    Height = 13
    Alignment = taRightJustify
    Caption = '&Alignment:'
    FocusControl = CBAlign
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 75
    Height = 13
    Alignment = taRightJustify
    Caption = '&Calculate using:'
    FocusControl = CBStyle
  end
  object Label3: TLabel
    Left = 8
    Top = 38
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = '&Number of points:'
    FocusControl = ENum
  end
  object ENum: TEdit
    Left = 96
    Top = 34
    Width = 65
    Height = 21
    HelpContext = 382
    Enabled = False
    TabOrder = 0
    Text = '0'
    OnChange = ENumChange
  end
  object BChange: TButton
    Left = 170
    Top = 32
    Width = 75
    Height = 25
    HelpContext = 382
    Caption = '&Change...'
    Enabled = False
    TabOrder = 1
    OnClick = BChangeClick
  end
  object CBAlign: TComboFlat
    Left = 96
    Top = 61
    Width = 107
    HelpContext = 872
    TabOrder = 2
    OnChange = CBAlignChange
    Items.Strings = (
      'First'
      'Center'
      'Last')
  end
  object CBStyle: TComboFlat
    Left = 96
    Top = 5
    Width = 150
    HelpContext = 873
    TabOrder = 3
    OnChange = CBStyleChange
    Items.Strings = (
      'All points'
      'Every number of points'
      'Every range')
  end
end
