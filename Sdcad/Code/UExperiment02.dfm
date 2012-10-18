object Experiment02: TExperiment02
  Left = 234
  Top = 175
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #23460#20869#35797#39564#25910#36153#35745#31639'(2002'#26631#20934')'
  ClientHeight = 522
  ClientWidth = 759
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 759
    Height = 425
    ActivePage = TabSheet3
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22303#24037#35797#39564
      object GroupBox7: TGroupBox
        Left = 0
        Top = 0
        Width = 751
        Height = 377
        Align = alTop
        Caption = #22303#24037#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label43: TLabel
          Left = 384
          Top = 24
          Width = 108
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#39033#30446'('#26041#27861'):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label44: TLabel
          Left = 432
          Top = 68
          Width = 60
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
        object Label45: TLabel
          Left = 575
          Top = 67
          Width = 42
          Height = 13
          AutoSize = False
          Caption = #39033'('#32452')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 411
          Top = 112
          Width = 81
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
        object Label47: TLabel
          Left = 575
          Top = 111
          Width = 54
          Height = 13
          AutoSize = False
          Caption = #20803'/'#39033'('#32452')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label48: TLabel
          Left = 408
          Top = 244
          Width = 84
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
        object Label49: TLabel
          Left = 575
          Top = 244
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
        object Label51: TLabel
          Left = 575
          Top = 342
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
        object Label52: TLabel
          Left = 392
          Top = 200
          Width = 100
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35843#25972#21518#21333#20215':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label53: TLabel
          Left = 575
          Top = 199
          Width = 54
          Height = 13
          AutoSize = False
          Caption = #20803'/'#39033'('#32452')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label54: TLabel
          Left = 411
          Top = 156
          Width = 81
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35843#25972#39033':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object LblNT1: TLabel
          Left = 493
          Top = 156
          Width = 12
          Height = 13
          Caption = #26080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label67: TLabel
          Left = 376
          Top = 342
          Width = 116
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #22303#24037#35797#39564#36153#21512#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape2: TShape
          Left = 388
          Top = 322
          Width = 354
          Height = 1
        end
        object DBGNTest: TDBGrid
          Left = 2
          Top = 15
          Width = 363
          Height = 360
          Align = alLeft
          Ctl3D = False
          DataSource = DSNTest
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
              Title.Caption = #35797#39564#39033#30446'('#26041#27861')'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #35843#25972#21333#20215
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
        object CBNT1: TComboBox
          Left = 493
          Top = 20
          Width = 198
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
          OnSelect = CBNT1Select
        end
        object EdtNT1: TEdit
          Left = 493
          Top = 64
          Width = 77
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
          Text = '                      0'
          OnChange = EdtNT1Change
          OnEnter = EdtNT1Enter
          OnExit = EdtNT1Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object STNT1: TStaticText
          Left = 493
          Top = 108
          Width = 78
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
        object STNT3: TStaticText
          Left = 493
          Top = 242
          Width = 78
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
          TabOrder = 8
        end
        object STNT4: TStaticText
          Left = 493
          Top = 340
          Width = 78
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
          TabOrder = 9
        end
        object BBNT1: TBitBtn
          Left = 602
          Top = 279
          Width = 73
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = BBNT1Click
        end
        object BBNT2: TBitBtn
          Left = 682
          Top = 279
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
          TabOrder = 6
          OnClick = BBNT2Click
        end
        object STNT2: TStaticText
          Left = 493
          Top = 197
          Width = 78
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
          TabOrder = 10
        end
        object EdtNT2: TEdit
          Left = 493
          Top = 153
          Width = 41
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
          Text = '          4'
          Visible = False
          OnChange = EdtNT2Change
          OnEnter = EdtNT2Enter
          OnExit = EdtNT2Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object ChkBNT1: TCheckBox
          Left = 493
          Top = 154
          Width = 170
          Height = 17
          Caption = #31896#22303#24615#31890#24452#20570#21040'<0.002mm'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Visible = False
          OnClick = ChkBNT1Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #27700#36136#20998#26512
      ImageIndex = 1
      object GroupBox8: TGroupBox
        Left = 0
        Top = 0
        Width = 753
        Height = 377
        Align = alTop
        Caption = #27700#36136#20998#26512
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label55: TLabel
          Left = 392
          Top = 35
          Width = 97
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#39033#30446':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label56: TLabel
          Left = 432
          Top = 100
          Width = 57
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
        object Label57: TLabel
          Left = 584
          Top = 100
          Width = 38
          Height = 13
          AutoSize = False
          Caption = #20214'('#39033')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 400
          Top = 166
          Width = 89
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
        object Label59: TLabel
          Left = 582
          Top = 166
          Width = 51
          Height = 13
          AutoSize = False
          Caption = #20803'/'#20214'('#39033')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label63: TLabel
          Left = 427
          Top = 232
          Width = 62
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
        object Label64: TLabel
          Left = 582
          Top = 232
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
        object Label66: TLabel
          Left = 581
          Top = 343
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
        object Label50: TLabel
          Left = 382
          Top = 343
          Width = 107
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #27700#36136#20998#26512#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TShape
          Left = 385
          Top = 322
          Width = 347
          Height = 1
        end
        object DBGWA: TDBGrid
          Left = 2
          Top = 15
          Width = 353
          Height = 360
          Align = alLeft
          Ctl3D = False
          DataSource = DSWA
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
              Title.Caption = #35797#39564#39033#30446
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 70
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 70
              Visible = True
            end>
        end
        object CBWA1: TComboBox
          Left = 491
          Top = 31
          Width = 198
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
          OnSelect = CBWA1Select
        end
        object EWA1: TEdit
          Left = 491
          Top = 97
          Width = 86
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
          Text = '                         0'
          OnChange = EWA1Change
          OnEnter = EWA1Enter
          OnExit = EWA1Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object STWA1: TStaticText
          Left = 491
          Top = 162
          Width = 86
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
        object STWA2: TStaticText
          Left = 491
          Top = 230
          Width = 86
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
        object St_WAMoney: TStaticText
          Left = 491
          Top = 341
          Width = 86
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
        object BBWA1: TBitBtn
          Left = 596
          Top = 273
          Width = 73
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = BBWA1Click
        end
        object BBWA2: TBitBtn
          Left = 676
          Top = 273
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
          TabOrder = 4
          OnClick = BBWA2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #23721#30707#35797#39564
      ImageIndex = 2
      object Label8: TLabel
        Left = 295
        Top = 378
        Width = 137
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #23721#30707#35797#39564#25910#36153#37329#39069':'
      end
      object Label9: TLabel
        Left = 549
        Top = 378
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 751
        Height = 129
        Align = alTop
        Caption = #23721#26679#21152#24037
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label11: TLabel
          Left = 336
          Top = 24
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#39033#30446#21450#35268#26684':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 628
          Top = 24
          Width = 37
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
        object Label14: TLabel
          Left = 344
          Top = 60
          Width = 86
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
        object Label15: TLabel
          Left = 601
          Top = 60
          Width = 64
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
        object Label24: TLabel
          Left = 515
          Top = 60
          Width = 53
          Height = 13
          AutoSize = False
          Caption = #20803'/'#22359'('#29255')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label27: TLabel
          Left = 727
          Top = 60
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
        object Label30: TLabel
          Left = 710
          Top = 24
          Width = 34
          Height = 13
          AutoSize = False
          Caption = #22359'('#29255')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label33: TLabel
          Left = 328
          Top = 102
          Width = 102
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #23721#26679#21152#24037#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label36: TLabel
          Left = 548
          Top = 102
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
        object Shape3: TShape
          Left = 331
          Top = 86
          Width = 416
          Height = 1
        end
        object DBGST1: TDBGrid
          Left = 2
          Top = 15
          Width = 320
          Height = 112
          Align = alLeft
          Ctl3D = False
          DataSource = DSProc
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
              Title.Caption = #35797#39564#39033#30446#21450#35268#26684
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #26631#20934#21333#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
        object CBST1: TComboBox
          Left = 432
          Top = 20
          Width = 129
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
          TabOrder = 1
          OnSelect = CBST1Select
        end
        object EdtST1: TEdit
          Left = 666
          Top = 21
          Width = 41
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
          Text = '          0'
          OnChange = EdtST1Change
          OnEnter = EdtST1Enter
          OnExit = EdtST1Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object STST1: TStaticText
          Left = 432
          Top = 58
          Width = 73
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
        object STST2: TStaticText
          Left = 666
          Top = 58
          Width = 59
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
        object BitBtn3: TBitBtn
          Left = 612
          Top = 96
          Width = 73
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = BitBtn3Click
        end
        object ST_SPMoney: TStaticText
          Left = 432
          Top = 100
          Width = 105
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
        object BitBtn1: TBitBtn
          Left = 692
          Top = 96
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
          TabOrder = 4
          OnClick = BitBtn1Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 129
        Width = 751
        Height = 119
        Align = alTop
        Caption = #23721#30707#29289#29702#21147#23398#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label16: TLabel
          Left = 336
          Top = 19
          Width = 97
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#39033#30446#21450#26041#27861':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 619
          Top = 19
          Width = 38
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
        object Label18: TLabel
          Left = 352
          Top = 51
          Width = 81
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
        object Label19: TLabel
          Left = 595
          Top = 51
          Width = 62
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
        object Label25: TLabel
          Left = 511
          Top = 51
          Width = 54
          Height = 13
          AutoSize = False
          Caption = #20803'/'#32452'('#20214')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label28: TLabel
          Left = 727
          Top = 51
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
        object Label31: TLabel
          Left = 703
          Top = 19
          Width = 38
          Height = 13
          AutoSize = False
          Caption = #32452'('#20214')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 328
          Top = 91
          Width = 104
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #29289#29702#35797#39564#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label37: TLabel
          Left = 549
          Top = 91
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
        object Shape4: TShape
          Left = 332
          Top = 76
          Width = 414
          Height = 1
        end
        object DBGST2: TDBGrid
          Left = 2
          Top = 15
          Width = 320
          Height = 102
          Align = alLeft
          Ctl3D = False
          DataSource = DSPhysics
          FixedColor = 15198183
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
              Title.Caption = #35797#39564#39033#30446#21450#26041#27861
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #26631#20934#21333#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
        object CBST2: TComboBox
          Left = 435
          Top = 15
          Width = 126
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
          TabOrder = 1
          OnSelect = CBST2Select
        end
        object EdtST2: TEdit
          Left = 659
          Top = 16
          Width = 41
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
          Text = '          0'
          OnChange = EdtST2Change
          OnEnter = EdtST2Enter
          OnExit = EdtST2Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object STST3: TStaticText
          Left = 435
          Top = 49
          Width = 70
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
        object STST4: TStaticText
          Left = 659
          Top = 49
          Width = 67
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
        object BitBtn4: TBitBtn
          Left = 611
          Top = 85
          Width = 73
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = BitBtn4Click
        end
        object ST_PHMoney: TStaticText
          Left = 435
          Top = 89
          Width = 106
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
        object BitBtn6: TBitBtn
          Left = 691
          Top = 85
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
          TabOrder = 4
          OnClick = BitBtn6Click
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 248
        Width = 751
        Height = 119
        Align = alTop
        Caption = #23721#30707#21270#23398#20998#26512
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label20: TLabel
          Left = 336
          Top = 18
          Width = 97
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#39033#30446#21450#26041#27861':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 605
          Top = 18
          Width = 53
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
        object Label22: TLabel
          Left = 352
          Top = 52
          Width = 81
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
        object Label23: TLabel
          Left = 589
          Top = 52
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
        object Label26: TLabel
          Left = 529
          Top = 52
          Width = 33
          Height = 13
          AutoSize = False
          Caption = #20803'/'#39033
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label29: TLabel
          Left = 729
          Top = 52
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
        object Label32: TLabel
          Left = 728
          Top = 18
          Width = 17
          Height = 13
          AutoSize = False
          Caption = #39033
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label35: TLabel
          Left = 328
          Top = 91
          Width = 104
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21270#23398#20998#26512#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 549
          Top = 91
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
        object Shape5: TShape
          Left = 333
          Top = 76
          Width = 414
          Height = 1
        end
        object DBGST3: TDBGrid
          Left = 2
          Top = 15
          Width = 320
          Height = 102
          Align = alLeft
          Ctl3D = False
          DataSource = DSChemistry
          FixedColor = 15198183
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ImeName = #26085#26412#35486' (MS-IME2000)'
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
              Title.Caption = #35797#39564#39033#30446#21450#26041#27861
              Width = 140
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #26631#20934#21333#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
        object CBST3: TComboBox
          Left = 434
          Top = 14
          Width = 125
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
          TabOrder = 1
          OnSelect = CBST3Select
        end
        object EdtST3: TEdit
          Left = 661
          Top = 15
          Width = 65
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
          Text = '                  0'
          OnChange = EdtST3Change
          OnEnter = EdtST3Enter
          OnExit = EdtST3Exit
          OnKeyPress = edt_WAPriceKeyPress
          OnMouseDown = edt_WAQuantityMouseDown
        end
        object STST5: TStaticText
          Left = 434
          Top = 50
          Width = 87
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
        object STST6: TStaticText
          Left = 661
          Top = 50
          Width = 65
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
        object BitBtn5: TBitBtn
          Left = 613
          Top = 85
          Width = 73
          Height = 25
          Caption = #20462#25913'/'#28155#21152
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = BitBtn5Click
        end
        object ST_CHMoney: TStaticText
          Left = 434
          Top = 89
          Width = 111
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
        object BitBtn7: TBitBtn
          Left = 693
          Top = 85
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
          TabOrder = 7
          OnClick = BitBtn7Click
        end
      end
      object St_STMoney: TStaticText
        Left = 433
        Top = 376
        Width = 113
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
    end
  end
  object BitBtn2: TBitBtn
    Left = 645
    Top = 480
    Width = 97
    Height = 25
    Cancel = True
    Caption = #20851#38381
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object GroupBox6: TGroupBox
    Left = 0
    Top = 425
    Width = 621
    Height = 97
    Align = alLeft
    TabOrder = 2
    object Label1: TLabel
      Left = 404
      Top = 49
      Width = 93
      Height = 13
      AutoSize = False
      Caption = '('#35843#25972#31995#25968'1.30)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 47
      Top = 21
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#32534#21495':'
    end
    object Label7: TLabel
      Left = 267
      Top = 19
      Width = 73
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#21517#31216':'
    end
    object Label39: TLabel
      Left = 24
      Top = 47
      Width = 96
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #23460#20869#35797#39564#25910#36153':'
    end
    object Label40: TLabel
      Left = 227
      Top = 49
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object CheckBox1: TCheckBox
      Left = 284
      Top = 47
      Width = 97
      Height = 17
      Caption = #29616#22330#23460#20869#35797#39564
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object StaticText1: TStaticText
      Left = 121
      Top = 19
      Width = 104
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
    object StaticText2: TStaticText
      Left = 345
      Top = 17
      Width = 264
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
      TabOrder = 2
    end
    object St_TestMoney: TStaticText
      Left = 121
      Top = 46
      Width = 104
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
  end
  object AQProc: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQProcAfterInsert
    AfterScroll = AQProcAfterScroll
    Parameters = <>
    Left = 560
    Top = 432
  end
  object AQPhysics: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQPhysicsAfterInsert
    AfterScroll = AQPhysicsAfterScroll
    Parameters = <>
    Left = 584
    Top = 432
  end
  object AQChemistry: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQChemistryAfterInsert
    AfterScroll = AQChemistryAfterScroll
    Parameters = <>
    Left = 608
    Top = 432
  end
  object DSProc: TDataSource
    DataSet = AQProc
    Left = 548
    Top = 464
  end
  object DSPhysics: TDataSource
    DataSet = AQPhysics
    Left = 580
    Top = 463
  end
  object DSChemistry: TDataSource
    DataSet = AQChemistry
    Left = 612
    Top = 462
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 696
    Top = 464
  end
  object AQNTest: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQNTestAfterInsert
    AfterScroll = AQNTestAfterScroll
    Parameters = <>
    Left = 512
    Top = 432
  end
  object AQWA: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQWAAfterInsert
    AfterScroll = AQWAAfterScroll
    Parameters = <>
    Left = 536
    Top = 432
  end
  object DSNTest: TDataSource
    DataSet = AQNTest
    Left = 624
    Top = 480
  end
  object DSWA: TDataSource
    DataSet = AQWA
    Left = 520
    Top = 464
  end
  object ADOQuery2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 728
    Top = 472
  end
end
