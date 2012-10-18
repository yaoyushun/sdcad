object frmCharge02: TfrmCharge02
  Left = 230
  Top = 161
  BorderStyle = bsDialog
  Caption = #24037#31243#20915#31639#65288'02'#26631#20934#65289
  ClientHeight = 121
  ClientWidth = 523
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox4: TGroupBox
    Left = 4
    Top = 15
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
    object btnCreateReport: TBitBtn
      Left = 12
      Top = 49
      Width = 151
      Height = 25
      Caption = #29983#25104#20915#31639#25253#34920
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnCreateReportClick
    end
    object STDir: TStaticText
      Left = 14
      Top = 28
      Width = 154
      Height = 16
      BevelInner = bvNone
      BevelOuter = bvNone
      Caption = #20915#31639#25253#34920#20445#23384'('#36335#24452')'#25991#20214#21517':'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btnBrowse: TBitBtn
      Left = 427
      Top = 19
      Width = 75
      Height = 25
      Caption = #27983#35272'...'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnBrowseClick
    end
    object ERP1: TEdit
      Left = 164
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
    object btnOpenReport: TBitBtn
      Left = 427
      Top = 49
      Width = 75
      Height = 25
      Caption = #25171#24320#25253#34920'...'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnOpenReportClick
    end
    object pbCreateReport: TProgressBar
      Left = 164
      Top = 49
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
  object ADOMax: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 272
    Top = 168
  end
end
