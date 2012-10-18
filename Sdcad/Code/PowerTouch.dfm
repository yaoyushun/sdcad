object YuanWeiCeShiForm: TYuanWeiCeShiForm
  Left = 216
  Top = 165
  Width = 733
  Height = 428
  Caption = #21407#20301#27979#35797#25968#25454
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 401
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 0
    object sgDrills: TStringGrid
      Left = 1
      Top = 1
      Width = 288
      Height = 399
      Align = alLeft
      ColCount = 3
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
      TabOrder = 0
      OnSelectCell = sgDrillsSelectCell
      ColWidths = (
        64
        83
        64)
    end
  end
  object Panel2: TPanel
    Left = 201
    Top = 0
    Width = 524
    Height = 401
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 224
      Width = 522
      Height = 135
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 0
      object lblBegin_depth: TLabel
        Left = 16
        Top = 11
        Width = 54
        Height = 12
        Caption = #28145#24230#36215'(m)'
      end
      object lblPole_len: TLabel
        Left = 16
        Top = 39
        Width = 54
        Height = 12
        Caption = #25506#26438#38271'(m)'
      end
      object lblReal_num1: TLabel
        Left = 264
        Top = 39
        Width = 54
        Height = 12
        Caption = #23454#27979#20987#25968'1'
      end
      object lblAmend_num: TLabel
        Left = 16
        Top = 99
        Width = 48
        Height = 12
        Caption = #20462#27491#20987#25968
      end
      object lblPt_type: TLabel
        Left = 264
        Top = 99
        Width = 48
        Height = 12
        Caption = #37325#35302#31867#22411
      end
      object Label2: TLabel
        Left = 264
        Top = 11
        Width = 54
        Height = 12
        Caption = #28145#24230#27490'(m)'
      end
      object lblReal_num2: TLabel
        Left = 16
        Top = 69
        Width = 54
        Height = 12
        Caption = #23454#27979#20987#25968'2'
      end
      object lblReal_num3: TLabel
        Left = 264
        Top = 69
        Width = 54
        Height = 12
        Caption = #23454#27979#20987#25968'3'
      end
      object edtBegin_depth: TCurrencyEdit
        Left = 76
        Top = 7
        Width = 146
        Height = 21
        AutoSize = False
        DisplayFormat = '0.00;-0.00'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 0
        ZeroEmpty = False
        OnChange = edtBegin_depthChange
        OnKeyDown = edtBegin_depthKeyDown
      end
      object edtPole_len: TCurrencyEdit
        Left = 76
        Top = 35
        Width = 145
        Height = 21
        AutoSize = False
        DisplayFormat = '0.00;-0.00'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 2
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
      object edtReal_num1: TCurrencyEdit
        Left = 327
        Top = 35
        Width = 145
        Height = 21
        AutoSize = False
        DisplayFormat = '0;0'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 3
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
      object edtAmend_num: TCurrencyEdit
        Left = 76
        Top = 95
        Width = 145
        Height = 21
        AutoSize = False
        DisplayFormat = '0;0'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 6
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
      object cboPt_type: TComboBox
        Left = 327
        Top = 95
        Width = 145
        Height = 20
        ImeName = #26085#26412#35486' (MS-IME2000)'
        ItemHeight = 12
        TabOrder = 7
        OnKeyDown = cboPt_typeKeyDown
        Items.Strings = (
          #36731#22411
          #37325#22411
          #36229#37325#22411)
      end
      object edtEnd_depth: TCurrencyEdit
        Left = 327
        Top = 7
        Width = 146
        Height = 21
        AutoSize = False
        DisplayFormat = '0.00;-0.00'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 1
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
      object edtReal_num2: TCurrencyEdit
        Left = 76
        Top = 65
        Width = 145
        Height = 21
        AutoSize = False
        DisplayFormat = '0;0'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 4
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
      object edtReal_num3: TCurrencyEdit
        Left = 327
        Top = 65
        Width = 145
        Height = 21
        AutoSize = False
        DisplayFormat = '0;0'
        ImeName = #26085#26412#35486' (MS-IME2000)'
        TabOrder = 5
        ZeroEmpty = False
        OnKeyDown = edtBegin_depthKeyDown
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 359
      Width = 522
      Height = 41
      Align = alBottom
      BevelOuter = bvLowered
      TabOrder = 1
      object btn_cancel: TBitBtn
        Left = 389
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
      object btn_delete: TBitBtn
        Left = 306
        Top = 8
        Width = 75
        Height = 25
        Hint = #21024#38500#19968#26465#35760#24405
        Caption = #21024#38500
        ModalResult = 3
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
      object btn_add: TBitBtn
        Left = 223
        Top = 8
        Width = 75
        Height = 25
        Hint = #22686#21152#19968#26465#35760#24405
        Caption = #22686#21152
        ModalResult = 8
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
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
      object btn_ok: TBitBtn
        Left = 140
        Top = 8
        Width = 75
        Height = 25
        Hint = #23384#30424
        Caption = #20445#23384
        ModalResult = 1
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
      object btn_edit: TBitBtn
        Left = 57
        Top = 8
        Width = 75
        Height = 25
        Caption = #20462#25913
        ModalResult = 1
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
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 522
      Height = 56
      Align = alTop
      BevelOuter = bvLowered
      TabOrder = 2
      object rgExaminationType: TRadioGroup
        Left = 16
        Top = 8
        Width = 273
        Height = 41
        Caption = #35797#39564#31867#22411
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          #26631#20934#36143#20837#35797#39564
          #37325#21147#35302#25506#35797#39564)
        TabOrder = 0
        OnClick = rgExaminationTypeClick
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 57
      Width = 522
      Height = 167
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 3
      object sgSPT: TStringGrid
        Left = 1
        Top = 1
        Width = 520
        Height = 165
        Align = alClient
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        OnSelectCell = sgSPTSelectCell
      end
      object sgDPT: TStringGrid
        Left = 1
        Top = 1
        Width = 520
        Height = 165
        Align = alClient
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 1
        OnSelectCell = sgDPTSelectCell
        ColWidths = (
          64
          39
          106
          82
          75)
      end
    end
  end
end
