object frmCharge02: TfrmCharge02
  Left = 256
  Top = 170
  Width = 536
  Height = 119
  Caption = 'frmCharge02'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 8
    Top = 1
    Width = 513
    Height = 84
    Caption = #20915#31639#25253#34920
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object BBPrj4: TBitBtn
      Left = 16
      Top = 49
      Width = 145
      Height = 25
      Caption = #29983#25104#20915#31639#25253#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BBPrj4Click
    end
    object STDir: TStaticText
      Left = 16
      Top = 23
      Width = 145
      Height = 19
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      Caption = #20915#31639#25253#34920#20445#23384'('#36335#24452')'#25991#20214#21517':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object BBPrj6: TBitBtn
      Left = 425
      Top = 20
      Width = 75
      Height = 25
      Caption = #27983#35272'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BBPrj6Click
    end
    object ERP1: TEdit
      Left = 162
      Top = 22
      Width = 261
      Height = 21
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImeName = #26085#35821#36755#20837#31995#32479' (MS-IME2000)'
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 3
    end
    object BBPrj7: TBitBtn
      Left = 425
      Top = 50
      Width = 75
      Height = 25
      Caption = #25171#24320#25253#34920'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BBPrj7Click
    end
    object pbCreateReport: TProgressBar
      Left = 162
      Top = 48
      Width = 261
      Height = 25
      Max = 110
      TabOrder = 5
    end
  end
  object ADO02: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 168
    Top = 176
  end
  object ADO02_All: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 216
    Top = 168
  end
  object SEFDlg: TSaveDialog
    Left = 632
    Top = 528
  end
end
