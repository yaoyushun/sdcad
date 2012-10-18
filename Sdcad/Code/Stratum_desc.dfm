object Stratum_descForm: TStratum_descForm
  Left = 164
  Top = 111
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #22303#23618#25551#36848#25968#25454
  ClientHeight = 572
  ClientWidth = 947
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object spl1: TSplitter
    Left = 353
    Top = 0
    Width = 4
    Height = 553
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 553
    Width = 947
    Height = 19
    Color = 15198183
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 553
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    object sgStratumDesc: TStringGrid
      Left = 1
      Top = 1
      Width = 351
      Height = 551
      Align = alClient
      ColCount = 3
      FixedColor = 15198183
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnDrawCell = sgStratumDescDrawCell
      OnSelectCell = sgStratumDescSelectCell
    end
  end
  object Panel2: TPanel
    Left = 357
    Top = 0
    Width = 590
    Height = 553
    Align = alClient
    BevelOuter = bvLowered
    Color = 15198183
    TabOrder = 2
    object Label1: TLabel
      Left = 91
      Top = 13
      Width = 24
      Height = 12
      Caption = #23618#21495
    end
    object lblSub_no: TLabel
      Left = 204
      Top = 13
      Width = 36
      Height = 12
      Caption = #20122#23618#21495
    end
    object lblEa_Name: TLabel
      Left = 330
      Top = 13
      Width = 48
      Height = 12
      Caption = #23721#22303#21517#31216
    end
    object lblID: TLabel
      Left = 12
      Top = 13
      Width = 12
      Height = 12
      Caption = #31532
    end
    object Label2: TLabel
      Left = 60
      Top = 13
      Width = 12
      Height = 12
      Caption = #23618
    end
    object lblStra_category: TLabel
      Left = 11
      Top = 38
      Width = 60
      Height = 12
      Caption = #23721#22303#31867#21035'02'
    end
    object lblStra_fao: TLabel
      Left = 11
      Top = 84
      Width = 96
      Height = 12
      Caption = #25215#36733#21147#22522#26412#23481#35768#20540
    end
    object lblStra_qik: TLabel
      Left = 11
      Top = 106
      Width = 72
      Height = 12
      Caption = #25705#38459#21147#26631#20934#20540
    end
    object lbl92: TLabel
      Left = 11
      Top = 62
      Width = 60
      Height = 12
      Caption = #23721#22303#31867#21035'92'
    end
    object btn_ok: TBitBtn
      Left = 155
      Top = 524
      Width = 75
      Height = 25
      Hint = #23384#30424
      Caption = #20445#23384
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btn_okClick
      Glyph.Data = {
        26050000424D26050000000000003604000028000000100000000F0000000100
        080000000000F0000000CE0E0000C40E00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
        A400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF00000000
        000000000000000000FFFF0003030000000000000707000300FFFF0003030000
        000000000707000300FFFF0003030000000000000707000300FFFF0003030000
        000000000000000300FFFF0003030303030303030303030300FFFF0003030000
        000000000000030300FFFF000300FFFFFFFFFFFFFFFF000300FFFF000300FFFF
        FFFFFFFFFFFF000300FFFF000300FFFFFFFFFFFFFFFF000300FFFF000300FFFF
        FFFFFFFFFFFF000300FFFF000300FFFFFFFFFFFFFFFF000000FFFF000300FFFF
        FFFFFFFFFFFF000700FFFF0000000000000000000000000000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
    end
    object btn_cancel: TBitBtn
      Left = 421
      Top = 524
      Width = 75
      Height = 25
      Hint = #36820#22238
      Cancel = True
      Caption = #36820#22238
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btn_cancelClick
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
    object btn_add: TBitBtn
      Left = 243
      Top = 524
      Width = 75
      Height = 25
      Hint = #22686#21152#19968#26465#35760#24405
      Caption = #22686#21152
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btn_addClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_delete: TBitBtn
      Left = 331
      Top = 524
      Width = 75
      Height = 25
      Hint = #21024#38500#19968#26465#35760#24405
      Caption = #21024#38500
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btn_deleteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_edit: TBitBtn
      Left = 67
      Top = 524
      Width = 75
      Height = 25
      Hint = #20462#25913#24403#21069#32426#24405
      Caption = #20462#25913
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btn_editClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 124
      Width = 571
      Height = 398
      Caption = #22303#23618#25551#36848
      TabOrder = 5
      object Label3: TLabel
        Left = 8
        Top = 202
        Width = 60
        Height = 12
        Caption = #20013#25991#25551#36848#65306
      end
      object lblDescription_en: TLabel
        Left = 8
        Top = 300
        Width = 60
        Height = 12
        Caption = #33521#25991#25551#36848#65306
      end
      object memDescription: TMemo
        Left = 8
        Top = 220
        Width = 541
        Height = 73
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ParentFont = False
        TabOrder = 0
        OnExit = memDescriptionExit
        OnKeyDown = memDescriptionKeyDown
      end
      object lb1: TListBox
        Left = 8
        Top = 20
        Width = 129
        Height = 177
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 19
        Items.Strings = (
          #40644#33394
          #40644#35088#33394
          #40644#30333#33394
          #40644#32511#33394
          #22303#40644#33394
          #35088#33394
          #28784#30333#33394
          #27700#24179
          #22402#30452
          #23618#29702
          #34180#23618
          #34920#23618
          #22343#36136
          #32467#26500
          #39640
          #20013
          #20302
          #37325
          #36731
          #36719
          #30828)
        ParentFont = False
        TabOrder = 2
        OnDblClick = lb1DblClick
      end
      object lb2: TListBox
        Left = 146
        Top = 20
        Width = 129
        Height = 177
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 19
        Items.Strings = (
          #31245#28287
          #28526#28287
          #24456#28287
          #39281#21644
          '----------'
          #22362#30828
          #30828#22609
          #21487#22609
          #36719#22609
          #27969#22609
          '----------'
          #26494#25955
          #31245#23494
          #20013#23494
          #23494#23454)
        ParentFont = False
        TabOrder = 3
        OnDblClick = lb1DblClick
      end
      object lb3: TListBox
        Left = 284
        Top = 20
        Width = 129
        Height = 177
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 19
        Items.Strings = (
          #24378#39118#21270
          #20013#39118#21270
          #24369#39118#21270
          #20840#39118#21270
          #26410#39118#21270
          #19978#37096
          #20013#37096
          #19979#37096#23616#37096
          #31859#20197#19978
          #31859#20197#19979
          #31859
          #21400#31859
          #30452#24452
          #22303#36136#36739#36719
          #20197#19978
          #20197#19979)
        ParentFont = False
        TabOrder = 4
        OnDblClick = lb1DblClick
      end
      object lb4: TListBox
        Left = 420
        Top = 20
        Width = 129
        Height = 177
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 19
        Items.Strings = (
          #24378#39118#21270
          #20013#39118#21270
          #24369#39118#21270
          #20840#39118#21270
          #26410#39118#21270
          #19978#37096
          #20013#37096
          #19979#37096#23616#37096
          #31859#20197#19978
          #31859#20197#19979
          #31859
          #21400#31859
          #30452#24452
          #22303#36136#36739#36719
          #20197#19978
          #20197#19979)
        ParentFont = False
        TabOrder = 5
        OnDblClick = lb1DblClick
      end
      object memDescription_en: TMemo
        Left = 8
        Top = 318
        Width = 541
        Height = 73
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ParentFont = False
        TabOrder = 1
        OnKeyDown = memDescription_enKeyDown
      end
    end
    object edtStra_no: TEdit
      Left = 121
      Top = 9
      Width = 65
      Height = 20
      ImeName = #26085#26412#35486' (MS-IME2000)'
      TabOrder = 7
      OnKeyDown = edtStra_noKeyDown
    end
    object cboEa_name: TComboBox
      Left = 387
      Top = 9
      Width = 145
      Height = 20
      ImeName = #26085#26412#35486' (MS-IME2000)'
      ItemHeight = 12
      TabOrder = 9
      OnKeyDown = cboEa_nameKeyDown
    end
    object edtID: TCurrencyEdit
      Left = 28
      Top = 8
      Width = 25
      Height = 21
      AutoSize = False
      DisplayFormat = '0'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #26085#26412#35486' (MS-IME2000)'
      MaxLength = 2
      ParentFont = False
      TabOrder = 6
      ZeroEmpty = False
      OnKeyDown = edtStra_noKeyDown
    end
    object cboStra_category: TComboBox
      Left = 71
      Top = 34
      Width = 97
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      ImeName = #26085#26412#35486' (MS-IME2000)'
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 10
      OnKeyDown = edtStra_noKeyDown
    end
    object Button1: TButton
      Left = 175
      Top = 34
      Width = 49
      Height = 20
      Caption = #20998#31867#34920
      TabOrder = 17
      OnClick = Button1Click
    end
    object edtSub_no: TEdit
      Left = 250
      Top = 8
      Width = 57
      Height = 20
      ImeName = #26085#26412#35486' (MS-IME2000)'
      MaxLength = 4
      TabOrder = 8
      OnKeyDown = edtStra_noKeyDown
    end
    object chbChangeFenCeng: TCheckBox
      Left = 250
      Top = 38
      Width = 317
      Height = 17
      Caption = #22312#22303#23618#25551#36848#25913#21464#26102#30456#24212#25913#21464#27599#20010#38075#23380#23545#24212#23618#30340#25551#36848#20449#24687
      TabOrder = 14
    end
    object edtStra_fao: TEdit
      Left = 121
      Top = 80
      Width = 65
      Height = 20
      ImeName = #26085#26412#35486' (MS-IME2000)'
      TabOrder = 12
      OnKeyDown = edtStra_noKeyDown
      OnKeyPress = edtStra_faoKeyPress
    end
    object edtStra_qik: TEdit
      Left = 121
      Top = 104
      Width = 65
      Height = 20
      ImeName = #26085#26412#35486' (MS-IME2000)'
      TabOrder = 13
      OnKeyDown = edtStra_qikKeyDown
      OnKeyPress = edtStra_qikKeyPress
    end
    object chbChangeFao: TCheckBox
      Left = 202
      Top = 83
      Width = 373
      Height = 17
      Caption = #22312#25215#36733#21147#22522#26412#23481#35768#20540#25913#21464#26102#30456#24212#25913#21464#27599#20010#38075#23380#23545#24212#23618#30340#23481#35768#20540
      TabOrder = 15
    end
    object chbChangeQik: TCheckBox
      Left = 202
      Top = 105
      Width = 373
      Height = 17
      Caption = #22312#25705#38459#21147#26631#20934#20540#25913#21464#26102#30456#24212#25913#21464#27599#20010#38075#23380#23545#24212#23618#30340#26631#20934#20540
      TabOrder = 16
    end
    object cboStra_category92: TComboBox
      Left = 71
      Top = 58
      Width = 97
      Height = 20
      Style = csDropDownList
      Ctl3D = False
      ImeName = #26085#26412#35486' (MS-IME2000)'
      ItemHeight = 12
      ParentCtl3D = False
      TabOrder = 11
      OnKeyDown = edtStra_noKeyDown
    end
  end
end
