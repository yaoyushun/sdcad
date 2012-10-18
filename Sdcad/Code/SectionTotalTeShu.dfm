object SectionTotalTeShuForm: TSectionTotalTeShuForm
  Left = 409
  Top = 306
  AutoScroll = False
  Caption = #22303#20998#26512#20998#23618#24635#34920'('#29305#27530#26679')'
  ClientHeight = 169
  ClientWidth = 525
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnFenCengJiSuan: TButton
    Left = 150
    Top = 128
    Width = 97
    Height = 25
    Caption = #22303#26679#25968#25454#35745#31639
    TabOrder = 0
    OnClick = btnFenCengJiSuanClick
  end
  object btn_Print: TBitBtn
    Left = 258
    Top = 128
    Width = 75
    Height = 25
    Caption = #25171#21360#20027#34920
    TabOrder = 1
    OnClick = btn_PrintClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777700000000000777707777777770707700000000000007070777777BBB77
      0007077777788877070700000000000007700777777777707070700000000007
      0700770FFFFFFFF070707770F00000F000077770FFFFFFFF077777770F00000F
      077777770FFFFFFFF07777777000000000777777777777777777}
  end
  object btn_cancel: TBitBtn
    Left = 430
    Top = 128
    Width = 75
    Height = 25
    Hint = #36820#22238
    Cancel = True
    Caption = #36820#22238
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDD0000777777777777777DDDD7000077777777777777FDFD7700007777
      777777777F3F37770000444444077777FFF4444D0000DDDDD450777F3FF4DDDD
      0000DDDDD45507FFFFF4DDDD0000DDDDD45550FFFFF4DDDD0000DDD0045550FF
      FFF4DDDD0000DDD0A05550FFFFF4DDDD00000000EA0550FFFEF4DDDD00000EAE
      AEA050FFFFF4DDDD00000AEAEAEA00FEFEF4DDDD00000EAEAEA050FFFFF4DDDD
      00000000EA0550FEFEF4DDDD0000DDD0A05550EFEFE4DDDD0000DDD0045550FE
      FEF4DDDD0000DDDDD45550EFEFE4DDDD0000DDDDD44444444444DDDD0000DDDD
      DDDDDDDDDDDDDDDD0000}
  end
  object Button1: TButton
    Left = 24
    Top = 129
    Width = 115
    Height = 24
    Caption = #28165#38500#20020#26102#25968#25454
    TabOrder = 3
    OnClick = Button1Click
  end
  object suiGroupBox1: TGroupBox
    Left = 24
    Top = 8
    Width = 473
    Height = 105
    Caption = #27880#24847#20107#39033
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 29
      Top = 16
      Width = 420
      Height = 72
      Caption = 
        #22914#26524#19979#21015#25968#25454#26377#25913#21464#65292#35831#37325#26032#36827#34892#35745#31639#65292#21542#21017#22303#20998#26512#20998#23618#24635#34920#30340#25968#25454#20250#19981#27491#30830#12290#13#10'   1'#65306#38075#23380#30340#26631#39640#21644#28145#24230#65292#38075#23380#30340#21024#38500#12290#13#10'   2'#65306 +
        #24037#31243#30340#22303#23618#25968#25454#12290#13#10'   3'#65306#38075#23380#30340#20998#23618#25968#25454#12290#13#10'   4'#65306#22303#26679#30340#22303#24037#35797#39564#25968#25454#12290' '#13#10'   5'#65306#25253#34920#35821#35328#20999#25442#65288#22914#20174#20013#25991#21040#33521#25991#65292#25110 +
        #20174#33521#25991#21040#20013#25991#65289
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object btnPrintFuBiao: TBitBtn
    Left = 344
    Top = 128
    Width = 75
    Height = 25
    Caption = #25171#21360#38468#34920
    TabOrder = 5
    OnClick = btnPrintFuBiaoClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      77777700000000000777707777777770707700000000000007070777777BBB77
      0007077777788877070700000000000007700777777777707070700000000007
      0700770FFFFFFFF070707770F00000F000077770FFFFFFFF077777770F00000F
      077777770FFFFFFFF07777777000000000777777777777777777}
  end
  object qryTeZhengShu: TADOQuery
    CacheSize = 500
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 313
    Top = 71
  end
  object tblTeZhengShu: TADOTable
    CacheSize = 500
    Connection = MainDataModule.ADOConnection1
    MasterSource = DSStratumMaster
    TableDirect = True
    Left = 352
    Top = 56
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    ReportType = rtMultiple
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 384
    Top = 24
    ReportForm = {19000000}
  end
  object qryStratum: TADOQuery
    CacheSize = 500
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 432
    Top = 56
  end
  object DSStratumMaster: TDataSource
    DataSet = qryStratum
    Left = 432
    Top = 96
  end
  object DSSampleValue: TDataSource
    DataSet = tblSampleValue
    Left = 392
    Top = 96
  end
  object DSTeZhengShu: TDataSource
    DataSet = tblTeZhengShu
    Left = 352
    Top = 96
  end
  object frDBTeZhengShu: TfrDBDataSet
    DataSource = DSTeZhengShu
    Left = 352
    Top = 128
  end
  object frDBSampleValue: TfrDBDataSet
    DataSource = DSSampleValue
    Left = 392
    Top = 128
  end
  object frDBStratumMaster: TfrDBDataSet
    DataSource = DSStratumMaster
    Left = 432
    Top = 128
  end
  object tblSampleValue: TADODataSet
    CacheSize = 500
    Connection = MainDataModule.ADOConnection1
    CommandText = 'TeShuYangTmp'
    DataSource = DSStratumMaster
    Parameters = <>
    Left = 264
    Top = 88
  end
end
