object ProjectOpenForm: TProjectOpenForm
  Left = 211
  Top = 267
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #25171#24320#24037#31243
  ClientHeight = 362
  ClientWidth = 747
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000003333333333333330000000000000000
    3333333333333330880000000000000033333333333333308880000000000000
    00000000000000088888000000000077777777777777707888888000000000FF
    FFFFFFFFFFFFF708888888000000000000000000000000078888888000000000
    0008888888888000778888880000000000088888888884740078888880000000
    00088FFFFFFF8474740788888000000000088FFFFFFF84747470788880000000
    00088FFFFFFF8474747407788000000000088EEEEEEE84647474700780000000
    00080EEEEEEE8464647474007000000000088888888884646464740000000000
    0000008EEEEEEE44646464000000000000000000086666664464640008000000
    000000000008EEEEEE4464770880000000000000000888666666447088800000
    0000000000888877777777088880000000000000088887777777708888800000
    0000000088887777777708888800000000000008888777777770888880000000
    0000008888777777770888880000000000000888877777777088888000000000
    000000000000000000888800000000000000FFFFFFFFFFFFF088800000000000
    00000FFFFFFFFFFFF088000000000000000000FFFFFFFFFFF000000000000000
    000000000000000000000000000000000000000000000000000000000000F800
    07FFF00003FFE00001FFE00000FF8000007F8000003F8000001FC000000FE000
    0007F8000003FC000003FC000003FC000003FC000003FC000003FC000003FE00
    0001FFC00001FFF80000FFFC0000FFF80000FFF00000FFE00001FFC00003FF80
    0007FF00000FFE00001FFE00003FFF00007FFF8000FFFFC001FFFFFFFFFF}
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object pnlQuery: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 319
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 0
    object sgQuery: TStringGrid
      Left = 1
      Top = 134
      Width = 745
      Height = 184
      Align = alBottom
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
      TabOrder = 0
      OnDblClick = sgQueryDblClick
    end
    object btnExecute: TBitBtn
      Left = 645
      Top = 32
      Width = 75
      Height = 25
      Hint = #27983#35272#21457#31080
      Caption = #25191#34892
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnExecuteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333AA333333333333333388333333333333AAA33333333
        333333388833333333333AAAA3333333333333388883333333333AAAAA333333
        333333388888333333333AAAAAA33333333333388888833333333AAAAAAA3333
        333333388888883333333AAAAAAAA333333333388888888333333AAAAAAA3333
        333333388888883333333AAAAAA33333333333388888833333333AAAAA333333
        333333388888333333333AAAA3333333333333388883333333333AAA33333333
        333333388833333333333AA333333333333333388333333333333A3333333333
        3333333833333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 625
      Height = 65
      Caption = #26597#35810#26465#20214#35774#23450
      TabOrder = 1
      object lblFieldDisplay: TLabel
        Left = 11
        Top = 16
        Width = 48
        Height = 12
        Caption = #39033#30446#20869#23481
      end
      object lblValue1: TLabel
        Left = 267
        Top = 15
        Width = 36
        Height = 12
        Caption = #26465#20214#19968
      end
      object lblValue2: TLabel
        Left = 472
        Top = 15
        Width = 36
        Height = 12
        Caption = #26465#20214#20108
      end
      object cboFieldDisplay: TComboBox
        Left = 11
        Top = 32
        Width = 145
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 0
        OnChange = cboFieldDisplayChange
        OnKeyDown = cboFieldDisplayKeyDown
        Items.Strings = (
          #24037#31243#32534#21495
          #24037#31243#39033#30446#21517#31216
          #24320#24037#26085#26399
          #23436#24037#26085#26399
          #22996#25176#21333#20301#21517#31216
          #22320#21306#21517
          #26045#24037#38431#21517#31216)
      end
      object cboSymbol1: TComboBox
        Left = 179
        Top = 32
        Width = 65
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 1
        OnKeyDown = cboFieldDisplayKeyDown
        Items.Strings = (
          'like'
          '='
          '<>'
          '>'
          '<'
          '>='
          '<='
          '')
      end
      object edtValue1: TEdit
        Left = 267
        Top = 31
        Width = 121
        Height = 20
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 2
        Text = 'edtValue1'
        OnKeyDown = edtValue1KeyDown
      end
      object dtp1: TDateTimePicker
        Left = 427
        Top = 45
        Width = 89
        Height = 20
        Date = 37789.832093634260000000
        Time = 37789.832093634260000000
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 3
        OnKeyDown = cboFieldDisplayKeyDown
      end
      object dtp2: TDateTimePicker
        Left = 528
        Top = 45
        Width = 89
        Height = 20
        Date = 37789.832261643520000000
        Time = 37789.832261643520000000
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 5
        OnKeyDown = cboFieldDisplayKeyDown
      end
      object cboFieldName: TComboBox
        Left = 99
        Top = 5
        Width = 145
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 6
        Visible = False
        Items.Strings = (
          'prj_no'
          'prj_name'
          'begin_date'
          'end_date'
          'consigner'
          'area_name'
          'builder')
      end
      object cboSymbol2: TComboBox
        Left = 403
        Top = 31
        Width = 57
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 4
        Items.Strings = (
          'like'
          '='
          '<>'
          '>'
          '<'
          '>='
          '<='
          '')
      end
      object edtValue2: TEdit
        Left = 472
        Top = 31
        Width = 123
        Height = 20
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 7
        Text = 'edtValue2'
      end
      object cboGrade: TComboBox
        Left = 520
        Top = 8
        Width = 81
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 8
        Visible = False
        Items.Strings = (
          #30002
          #20057
          #19993)
      end
      object cbo_type: TComboBox
        Left = 320
        Top = 8
        Width = 89
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 9
        Items.Strings = (
          #24037#27665#24314
          #36335#26725)
      end
    end
  end
  object pnlTable: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 319
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object pnlLeft: TPanel
      Left = 1
      Top = 1
      Width = 449
      Height = 317
      Align = alLeft
      BevelOuter = bvLowered
      Color = 15198183
      TabOrder = 1
      object lblprj_no: TLabel
        Left = 17
        Top = 22
        Width = 48
        Height = 12
        Caption = #24037#31243#32534#21495
      end
      object lblprj_name: TLabel
        Left = 17
        Top = 88
        Width = 48
        Height = 12
        Caption = #24037#31243#21517#31216
      end
      object lblarea_name: TLabel
        Left = 17
        Top = 156
        Width = 48
        Height = 12
        Caption = #22330#22320#20301#32622
      end
      object lblbuilder: TLabel
        Left = 17
        Top = 190
        Width = 48
        Height = 12
        Caption = #26045#24037#21333#20301
      end
      object lblbegin_date: TLabel
        Left = 17
        Top = 55
        Width = 48
        Height = 12
        Caption = #24320#24037#26085#26399
      end
      object lblend_date: TLabel
        Left = 243
        Top = 55
        Width = 48
        Height = 12
        Caption = #23436#24037#26085#26399
      end
      object lblconsigner: TLabel
        Left = 17
        Top = 224
        Width = 48
        Height = 12
        Caption = #22996#25176#21333#20301
      end
      object lblPrj_grade: TLabel
        Left = 227
        Top = 22
        Width = 96
        Height = 12
        Caption = #23721#22303#24037#31243#21208#23519#31561#32423
      end
      object Label1: TLabel
        Left = 15
        Top = 256
        Width = 48
        Height = 12
        Caption = #24037#31243#31867#22411
      end
      object Label2: TLabel
        Left = 17
        Top = 122
        Width = 48
        Height = 12
        Caption = #33521#25991#21517#31216
      end
      object edtprj_no: TEdit
        Left = 83
        Top = 19
        Width = 137
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 18
        TabOrder = 0
        OnChange = edtprj_noChange
        OnKeyDown = edtprj_noKeyDown
      end
      object edtprj_name: TEdit
        Left = 83
        Top = 85
        Width = 358
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnChange = edtprj_noChange
        OnKeyDown = edtprj_noKeyDown
        OnMouseMove = edtprj_nameMouseMove
      end
      object edtarea_name: TEdit
        Left = 83
        Top = 153
        Width = 358
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 40
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnKeyDown = edtprj_noKeyDown
      end
      object edtbuilder: TEdit
        Left = 83
        Top = 187
        Width = 358
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 40
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnKeyDown = edtprj_noKeyDown
      end
      object edtconsigner: TEdit
        Left = 83
        Top = 221
        Width = 358
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 40
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnKeyDown = edtprj_noKeyDown
      end
      object dtpEnd_date: TDateTimePicker
        Left = 303
        Top = 51
        Width = 137
        Height = 20
        Date = 37777.649711550920000000
        Time = 37777.649711550920000000
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 3
        OnKeyDown = dtpBegin_dateKeyDown
      end
      object dtpBegin_date: TDateTimePicker
        Left = 83
        Top = 51
        Width = 137
        Height = 20
        Date = 37777.642310648150000000
        Time = 37777.642310648150000000
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 2
        OnKeyDown = dtpBegin_dateKeyDown
      end
      object cboPrj_grade: TComboBox
        Left = 328
        Top = 19
        Width = 112
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 1
        OnKeyDown = dtpBegin_dateKeyDown
        Items.Strings = (
          #30002
          #20057
          #19993)
      end
      object cboPrj_type: TComboBox
        Left = 83
        Top = 253
        Width = 96
        Height = 20
        Style = csDropDownList
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 8
        Items.Strings = (
          #24037#27665#24314
          #36335#26725)
      end
      object edtprj_name_en: TEdit
        Left = 83
        Top = 119
        Width = 358
        Height = 20
        BevelInner = bvLowered
        ImeName = #26085#26412#35486' (MS-IME2000)'
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnChange = edtprj_noChange
        OnKeyDown = edtprj_noKeyDown
        OnMouseMove = edtprj_nameMouseMove
      end
    end
    object pnlRight: TPanel
      Left = 450
      Top = 1
      Width = 296
      Height = 317
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
      object sgProject: TStringGrid
        Left = 1
        Top = 1
        Width = 294
        Height = 315
        Align = alClient
        ColCount = 3
        Ctl3D = False
        FixedColor = 15198183
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        ParentCtl3D = False
        TabOrder = 0
        OnDblClick = sgProjectDblClick
        OnKeyDown = sgProjectKeyDown
        OnSelectCell = sgProjectSelectCell
        ColWidths = (
          64
          123
          77)
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 319
    Width = 747
    Height = 43
    Align = alBottom
    BevelOuter = bvLowered
    Color = 15198183
    TabOrder = 2
    object btn_ok: TBitBtn
      Left = 246
      Top = 8
      Width = 75
      Height = 25
      Hint = #23384#30424
      Caption = #25171#24320
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btn_okClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
        0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
        0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
        0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
        0333337F777FFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object btn_cancel: TBitBtn
      Left = 549
      Top = 8
      Width = 75
      Height = 25
      Hint = #36820#22238
      Cancel = True
      Caption = #36820#22238
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
    object btn_query: TBitBtn
      Left = 448
      Top = 8
      Width = 75
      Height = 25
      Hint = #24037#31243#26597#35810
      Caption = #26597#35810
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btn_queryClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07F3FF3FF3FF3FFF70F00F00F00F000F07F773773773777370FFFFFFFFFFF
        FFF07FFFFFFFFFFFFFF70CCCCCCCCCCCCCC07777777777777777088CCCCCCCCC
        C8807FF7777777777FF700000000000000007777777777777777333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object btn_delete: TBitBtn
      Left = 347
      Top = 8
      Width = 75
      Height = 25
      Hint = #21024#38500#19968#26465#35760#24405
      Caption = #21024#38500
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
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
      Left = 145
      Top = 8
      Width = 75
      Height = 25
      Hint = #20462#25913#24037#31243#20449#24687
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
  end
end
