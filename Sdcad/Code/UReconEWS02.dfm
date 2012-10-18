object ReconEWS02: TReconEWS02
  Left = 174
  Top = 65
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #24037#31243#22320#36136#21208#23519'(2002'#26631#20934')'
  ClientHeight = 614
  ClientWidth = 732
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label89: TLabel
    Left = 465
    Top = 84
    Width = 24
    Height = 13
    AutoSize = False
    Caption = #20214
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BBRecon2: TBitBtn
    Left = 531
    Top = 546
    Width = 163
    Height = 25
    Cancel = True
    Caption = #20851#38381
    TabOrder = 0
    OnClick = BBRecon2Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 732
    Height = 281
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet4: TTabSheet
      Caption = #21462#22303#35797#26009
      ImageIndex = 3
      object Label140: TLabel
        Left = 347
        Top = 230
        Width = 133
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21462#22303#35797#26009#25910#36153#23567#35745':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label139: TLabel
        Left = 587
        Top = 230
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox13: TGroupBox
        Left = 0
        Top = 0
        Width = 724
        Height = 217
        Align = alTop
        Caption = #21462#22303#35797#26009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label102: TLabel
          Left = 416
          Top = 22
          Width = 65
          Height = 25
          AutoSize = False
          Caption = #21462#26679#26041#27861#19982#13#10#35797#26679#35268#26684#65306
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label117: TLabel
          Left = 420
          Top = 92
          Width = 61
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25968#37327':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label118: TLabel
          Left = 588
          Top = 92
          Width = 18
          Height = 13
          AutoSize = False
          Caption = #20214
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label121: TLabel
          Left = 405
          Top = 123
          Width = 76
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #26631#20934#21333#20215':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label132: TLabel
          Left = 588
          Top = 122
          Width = 34
          Height = 13
          AutoSize = False
          Caption = #20803'/'#20214
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label136: TLabel
          Left = 412
          Top = 154
          Width = 69
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25910#36153#37329#39069':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label137: TLabel
          Left = 588
          Top = 154
          Width = 13
          Height = 13
          AutoSize = False
          Caption = #20803
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label141: TLabel
          Left = 397
          Top = 61
          Width = 84
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21462#26679#28145#24230':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DGE1: TDBGrid
          Left = 2
          Top = 15
          Width = 384
          Height = 200
          Align = alLeft
          Ctl3D = False
          DataSource = DSE
          FixedColor = 15198183
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #21462#26679#26041#27861#19982#24230#26679#35268#26684
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #21462#26679#28145#24230
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327'('#20214')'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 58
              Visible = True
            end>
        end
        object CBE1: TComboBox
          Left = 484
          Top = 24
          Width = 233
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          Style = csDropDownList
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ItemHeight = 0
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          OnSelect = CBE1Select
        end
        object EE1: TEdit
          Left = 484
          Top = 88
          Width = 94
          Height = 19
          BevelInner = bvSpace
          BevelOuter = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
          Text = '                           0'
          OnChange = EE1Change
          OnEnter = EE1Enter
          OnExit = EE1Exit
          OnKeyPress = EE1KeyPress
          OnMouseDown = EE1MouseDown
        end
        object STE1: TStaticText
          Left = 484
          Top = 120
          Width = 94
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object STE2: TStaticText
          Left = 484
          Top = 152
          Width = 94
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object BBE1: TBitBtn
          Left = 584
          Top = 183
          Width = 71
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = BBE1Click
        end
        object BBE2: TBitBtn
          Left = 663
          Top = 183
          Width = 49
          Height = 25
          Caption = #21024#38500
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = BBE2Click
        end
        object CBE2: TComboBox
          Left = 484
          Top = 56
          Width = 94
          Height = 21
          BevelInner = bvNone
          BevelKind = bkFlat
          Style = csDropDownList
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ItemHeight = 13
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 2
          OnSelect = CBE2Select
          Items.Strings = (
            '<=30'
            '>30')
        end
      end
      object STE3: TStaticText
        Left = 483
        Top = 228
        Width = 96
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelKind = bkFlat
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object TabSheet1: TTabSheet
      Caption = #21462#27700#12289#30707#35797#26009
      ImageIndex = 1
      object Label82: TLabel
        Left = 416
        Top = 220
        Width = 166
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21462#27700#12289#30707#35797#26009#25910#36153#23567#35745':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label83: TLabel
        Left = 679
        Top = 220
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object GroupBox9: TGroupBox
        Left = 0
        Top = 0
        Width = 724
        Height = 201
        Align = alTop
        Caption = #21462#27700#12289#30707#35797#26009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label72: TLabel
          Left = 511
          Top = 79
          Width = 24
          Height = 13
          AutoSize = False
          Caption = #20214
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label73: TLabel
          Left = 39
          Top = 35
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35797#26009#20998#31867
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label74: TLabel
          Left = 157
          Top = 35
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #21462#26679#26041#27861
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label75: TLabel
          Left = 442
          Top = 35
          Width = 69
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #25968#37327
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label76: TLabel
          Left = 294
          Top = 35
          Width = 69
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #26631#20934#21333#20215
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label77: TLabel
          Left = 293
          Top = 79
          Width = 52
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '40'#20803'/'#20214
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label78: TLabel
          Left = 595
          Top = 35
          Width = 81
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #25910#36153#37329#39069'('#20803')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label80: TLabel
          Left = 155
          Top = 133
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #21462#23721#33455#26679
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label70: TLabel
          Left = 39
          Top = 79
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #21462#27700#35797#26009
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label71: TLabel
          Left = 39
          Top = 152
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #21462#30707#35797#26009
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label86: TLabel
          Left = 155
          Top = 167
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #20154#24037#21462#26679
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label87: TLabel
          Left = 293
          Top = 133
          Width = 57
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '25 '#20803'/'#32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label88: TLabel
          Left = 293
          Top = 167
          Width = 57
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '200'#20803'/'#32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label81: TLabel
          Left = 511
          Top = 133
          Width = 24
          Height = 13
          AutoSize = False
          Caption = #32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label90: TLabel
          Left = 511
          Top = 167
          Width = 24
          Height = 13
          AutoSize = False
          Caption = #32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape7: TShape
          Left = 16
          Top = 61
          Width = 690
          Height = 1
        end
        object Shape10: TShape
          Left = 16
          Top = 113
          Width = 690
          Height = 1
          Pen.Style = psDot
        end
        object EWS1: TEdit
          Left = 448
          Top = 76
          Width = 59
          Height = 19
          BevelInner = bvSpace
          BevelOuter = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          Text = '               0'
          OnEnter = EWS1Enter
          OnExit = EWS1Exit
          OnKeyPress = EE1KeyPress
          OnMouseDown = EE1MouseDown
        end
        object STWS1: TStaticText
          Left = 584
          Top = 77
          Width = 91
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object EWS2: TEdit
          Left = 448
          Top = 130
          Width = 59
          Height = 19
          BevelInner = bvSpace
          BevelOuter = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          Text = '               0'
          OnEnter = EWS2Enter
          OnExit = EWS2Exit
          OnKeyPress = EE1KeyPress
          OnMouseDown = EE1MouseDown
        end
        object EWS3: TEdit
          Left = 448
          Top = 164
          Width = 59
          Height = 19
          BevelInner = bvSpace
          BevelOuter = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          Text = '               0'
          OnEnter = EWS3Enter
          OnExit = EWS3Exit
          OnKeyPress = EE1KeyPress
          OnMouseDown = EE1MouseDown
        end
        object STWS2: TStaticText
          Left = 584
          Top = 131
          Width = 91
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object STWS3: TStaticText
          Left = 584
          Top = 165
          Width = 91
          Height = 17
          Alignment = taRightJustify
          AutoSize = False
          BevelInner = bvNone
          BevelKind = bkFlat
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object STWS4: TStaticText
        Left = 584
        Top = 218
        Width = 91
        Height = 17
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelKind = bkFlat
        Caption = '0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object GroupBox6: TGroupBox
    Left = 8
    Top = 509
    Width = 449
    Height = 100
    TabOrder = 2
    object Label6: TLabel
      Left = 49
      Top = 19
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#32534#21495#65306
    end
    object Label7: TLabel
      Left = 49
      Top = 47
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#21517#31216#65306
    end
    object Label39: TLabel
      Left = 8
      Top = 74
      Width = 114
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21462#26009#25910#36153#21512#35745#65306
    end
    object Label40: TLabel
      Left = 251
      Top = 75
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object STRecon1: TStaticText
      Left = 120
      Top = 17
      Width = 289
      Height = 17
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object STRecon2: TStaticText
      Left = 120
      Top = 45
      Width = 289
      Height = 17
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object STRecon3: TStaticText
      Left = 120
      Top = 73
      Width = 126
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object GroupBox8: TGroupBox
    Left = 0
    Top = 316
    Width = 730
    Height = 185
    Caption = #21462#26009#25910#36153#35843#25972
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label56: TLabel
      Left = 259
      Top = 42
      Width = 83
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'3.0)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label57: TLabel
      Left = 259
      Top = 65
      Width = 86
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'2.0)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label58: TLabel
      Left = 259
      Top = 89
      Width = 94
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'2.5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label59: TLabel
      Left = 259
      Top = 112
      Width = 94
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'3.0)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label60: TLabel
      Left = 458
      Top = 160
      Width = 119
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #21462#26009#32508#21512#35843#25972#31995#25968':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Shape12: TShape
      Left = 360
      Top = 151
      Width = 350
      Height = 1
    end
    object Label2: TLabel
      Left = 576
      Top = 47
      Width = 88
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.2)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 259
      Top = 136
      Width = 94
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 259
      Top = 160
      Width = 94
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.2)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 576
      Top = 96
      Width = 123
      Height = 17
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.1'#65374'1.3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label55: TLabel
      Left = 575
      Top = 22
      Width = 114
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.3)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object CBDrill1: TCheckBox
      Left = 31
      Top = 17
      Width = 153
      Height = 17
      Caption = #27700#19978#20316#19994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = CBDrill1Click
    end
    object RBDrill1: TRadioButton
      Left = 47
      Top = 40
      Width = 153
      Height = 17
      Caption = #28392#28023
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TabStop = True
      OnClick = RBDrill1Click
    end
    object RBDrill2: TRadioButton
      Left = 47
      Top = 64
      Width = 193
      Height = 17
      Caption = #28246#12289#27743#12289#27827'--'#27700#28145'D(m)--D<=10'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = RBDrill2Click
    end
    object RBDrill5: TRadioButton
      Left = 47
      Top = 134
      Width = 153
      Height = 17
      Caption = #22616#19978#12289#27836#27901#22320
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = RBDrill5Click
    end
    object RBDrill6: TRadioButton
      Left = 47
      Top = 158
      Width = 185
      Height = 17
      Caption = #31215#27700#21306'('#21547#27700#31291#30000')'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = RBDrill6Click
    end
    object STDrill1: TStaticText
      Left = 579
      Top = 158
      Width = 35
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
      Caption = '1.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object CBDrill3: TCheckBox
      Left = 384
      Top = 45
      Width = 153
      Height = 17
      Caption = #22812#38388#20316#19994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = CBDrill3Click
    end
    object RBDrill3: TRadioButton
      Left = 47
      Top = 87
      Width = 201
      Height = 17
      Caption = #28246#12289#27743#12289#27827'--'#27700#28145'D(m)--10<D<=20'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = RBDrill3Click
    end
    object RBDrill4: TRadioButton
      Left = 47
      Top = 111
      Width = 185
      Height = 17
      Caption = #28246#12289#27743#12289#27827'--'#27700#28145'D(m)--D>20'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = RBDrill4Click
    end
    object CBDrill4: TCheckBox
      Left = 384
      Top = 68
      Width = 337
      Height = 25
      Caption = #23721#28342#12289#27934#31348#12289#27877#30707#27969#12289#28369#22369#12289#27801#28448#12289#23665#21069#27946#31215#35033#31561#22797#26434#22330#22320
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      WordWrap = True
      OnClick = CBDrill4Click
    end
    object Edit1: TEdit
      Tag = 2
      Left = 579
      Top = 123
      Width = 35
      Height = 19
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      Ctl3D = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImeName = #26085#26412#35486' (MS-IME2000)'
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 10
      Text = '   1.10'
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
      OnKeyPress = Edit1KeyPress
      OnMouseDown = Edit1MouseDown
    end
    object CBDrill2: TCheckBox
      Left = 384
      Top = 18
      Width = 153
      Height = 17
      Caption = #32447#36335#19978#20316#19994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      OnClick = CBDrill2Click
    end
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 472
    Top = 528
  end
  object AQE: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQEAfterInsert
    AfterScroll = AQEAfterScroll
    Parameters = <>
    Left = 464
    Top = 488
  end
  object DSE: TDataSource
    DataSet = AQE
    Left = 496
    Top = 488
  end
end
