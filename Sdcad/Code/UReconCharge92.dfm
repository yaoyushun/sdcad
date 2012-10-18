object ReconCharge92: TReconCharge92
  Left = 192
  Top = 68
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #24037#31243#22320#36136#21208#23519'(1992'#26631#20934')'
  ClientHeight = 629
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
    Top = 85
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
    Top = 579
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
    Height = 476
    ActivePage = TabSheet7
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #22320#36136#27979#32472
      object Label33: TLabel
        Left = 400
        Top = 418
        Width = 130
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #22320#36136#27979#32472#25910#36153#37329#39069':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label36: TLabel
        Left = 629
        Top = 418
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
      object GroupBox7: TGroupBox
        Left = 0
        Top = 0
        Width = 724
        Height = 289
        Align = alTop
        Caption = #36153#29992#35745#31639
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label11: TLabel
          Left = 436
          Top = 30
          Width = 94
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25104#22270#27604#20363':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 440
          Top = 75
          Width = 90
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #22797#26434#31243#24230':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 464
          Top = 119
          Width = 66
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
        object Label30: TLabel
          Left = 629
          Top = 119
          Width = 61
          Height = 13
          AutoSize = False
          Caption = #24179#26041#20844#37324
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 444
          Top = 163
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
        object Label24: TLabel
          Left = 628
          Top = 163
          Width = 76
          Height = 13
          AutoSize = False
          Caption = #20803'/'#24179#26041#20844#37324
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 448
          Top = 208
          Width = 82
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
        object Label27: TLabel
          Left = 631
          Top = 208
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
        object DBGMap1: TDBGrid
          Left = 2
          Top = 15
          Width = 423
          Height = 272
          Align = alLeft
          Ctl3D = False
          DataSource = DSMap
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
              Title.Caption = #25104#22270#27604#20363#23610
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #22797#26434#31243#24230
              Width = 60
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
              Title.Caption = #25968#37327
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25910#36153#37329#39069
              Width = 80
              Visible = True
            end>
        end
        object CBMap1: TComboBox
          Left = 535
          Top = 26
          Width = 154
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
          TabOrder = 1
          OnSelect = CBMap1Select
        end
        object CBMap2: TComboBox
          Left = 535
          Top = 71
          Width = 154
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
          TabOrder = 2
          OnSelect = CBMap2Select
          Items.Strings = (
            #8544
            #8545
            #8546)
        end
        object EdtMap1: TEdit
          Tag = 2
          Left = 535
          Top = 116
          Width = 89
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
          Text = '                     0.00'
          OnChange = EdtMap1Change
          OnEnter = EdtMap1Enter
          OnExit = EdtMap1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STMap1: TStaticText
          Left = 535
          Top = 161
          Width = 90
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
        object STMap2: TStaticText
          Left = 535
          Top = 206
          Width = 90
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
        object BBMap1: TBitBtn
          Left = 575
          Top = 247
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
          TabOrder = 4
          OnClick = BBMap1Click
        end
        object BBMap2: TBitBtn
          Left = 655
          Top = 247
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
          OnClick = BBMap2Click
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 304
        Width = 730
        Height = 96
        Caption = #25910#36153#35843#25972
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label2: TLabel
          Left = 440
          Top = 49
          Width = 91
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #32508#21512#35843#25972#31995#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 265
          Top = 32
          Width = 65
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'50%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 265
          Top = 66
          Width = 65
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ChBMap1: TCheckBox
          Left = 48
          Top = 30
          Width = 217
          Height = 17
          Caption = #21516#26102#36827#34892#22320#36136#27979#32472#21644#24037#31243#22320#36136#27979#32472
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = ChBMap1Click
        end
        object ChBMap2: TCheckBox
          Left = 48
          Top = 64
          Width = 201
          Height = 17
          Caption = #24102#29366#24037#31243#22320#36136#27979#32472
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ChBMap2Click
        end
        object STMap3: TStaticText
          Left = 535
          Top = 47
          Width = 90
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
          TabOrder = 2
        end
      end
      object STMap4: TStaticText
        Left = 535
        Top = 416
        Width = 90
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
    object TabSheet2: TTabSheet
      Caption = #38075#23380
      ImageIndex = 1
      object Label62: TLabel
        Left = 432
        Top = 423
        Width = 113
        Height = 13
        AutoSize = False
        Caption = #38075#23380#25910#36153#37329#39069':'
      end
      object Label63: TLabel
        Left = 665
        Top = 423
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 726
        Height = 213
        Align = alTop
        Caption = #36153#29992#35745#31639
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label79: TLabel
          Left = 477
          Top = 188
          Width = 110
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #24403#21069#38075#23380#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label91: TLabel
          Left = 666
          Top = 188
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
        object Panel1: TPanel
          Left = 2
          Top = 15
          Width = 722
          Height = 162
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object DGDrill1: TDBGrid
            Left = 0
            Top = 0
            Width = 188
            Height = 162
            Align = alLeft
            Ctl3D = False
            DataSource = DSDill
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
                Title.Caption = #38075#23380#32534#21495
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #23380#21475#26631#39640
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #23436#25104#28145#24230
                Width = 50
                Visible = True
              end>
          end
          object DGDrill2: TDBGrid
            Left = 188
            Top = 0
            Width = 146
            Height = 162
            Align = alLeft
            Ctl3D = False
            DataSource = DSStratum
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
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Caption = #23618#21495
                Width = 25
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #20122#23618#21495
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #23618#24213#28145#24230
                Width = 47
                Visible = True
              end>
          end
          object DGDrill3: TDBGrid
            Left = 334
            Top = 0
            Width = 388
            Height = 162
            Align = alClient
            Ctl3D = False
            DataSource = DSMoney
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
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #38075#25506#28145#24230
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #28145#24230#33539#22260
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #22303#23618#32534#21495
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #22320#23618
                Width = 26
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
                Title.Caption = #28145#24230
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #37329#39069
                Width = 50
                Visible = True
              end>
          end
        end
        object STDrill0: TStaticText
          Left = 589
          Top = 186
          Width = 74
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
      object GroupBox8: TGroupBox
        Left = 0
        Top = 225
        Width = 730
        Height = 184
        Caption = #25910#36153#35843#25972
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label50: TLabel
          Left = 257
          Top = 23
          Width = 57
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'50%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label51: TLabel
          Left = 257
          Top = 48
          Width = 57
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label52: TLabel
          Left = 589
          Top = 23
          Width = 68
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'50%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label53: TLabel
          Left = 589
          Top = 55
          Width = 68
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label54: TLabel
          Left = 589
          Top = 87
          Width = 76
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'100%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label55: TLabel
          Left = 589
          Top = 119
          Width = 76
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'20%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label56: TLabel
          Left = 257
          Top = 96
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'200%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label57: TLabel
          Left = 257
          Top = 118
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'100%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 257
          Top = 140
          Width = 57
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'40%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label59: TLabel
          Left = 257
          Top = 162
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label60: TLabel
          Left = 432
          Top = 160
          Width = 97
          Height = 13
          AutoSize = False
          Caption = #32508#21512#35843#25972#31995#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape12: TShape
          Left = 433
          Top = 147
          Width = 247
          Height = 1
        end
        object CBDrill1: TCheckBox
          Left = 40
          Top = 21
          Width = 153
          Height = 17
          Caption = #36319#31649#38075#36827#25110#27877#27974#25252#22721
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CBDrill1Click
        end
        object CBDrill2: TCheckBox
          Left = 40
          Top = 46
          Width = 153
          Height = 17
          Caption = #21271#20140#38130#12289#27931#38451#38130#12289#34746#32441#38075
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = CBDrill2Click
        end
        object CBDrill3: TCheckBox
          Left = 40
          Top = 71
          Width = 153
          Height = 17
          Caption = #27700#19978#38075#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = CBDrill3Click
        end
        object CBDrill4: TCheckBox
          Left = 434
          Top = 21
          Width = 153
          Height = 17
          Caption = #22522#23721#26080#27700#24178#38075
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = CBDrill4Click
        end
        object CBDrill5: TCheckBox
          Left = 434
          Top = 53
          Width = 153
          Height = 17
          Caption = #22353#36947#20869#38075#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = CBDrill5Click
        end
        object CBDrill6: TCheckBox
          Left = 434
          Top = 85
          Width = 153
          Height = 17
          Caption = #26012#23380#38075#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnClick = CBDrill6Click
        end
        object CBDrill7: TCheckBox
          Left = 434
          Top = 117
          Width = 153
          Height = 17
          Caption = #32447#36335#38075#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = CBDrill7Click
        end
        object RBDrill1: TRadioButton
          Left = 56
          Top = 94
          Width = 153
          Height = 17
          Caption = #28023#19978#38075#25506
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = True
          OnClick = RBDrill1Click
        end
        object RBDrill2: TRadioButton
          Left = 56
          Top = 116
          Width = 153
          Height = 17
          Caption = #28246#19978#12289#27743#19978#12289#27827#19978#38075#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = RBDrill2Click
        end
        object RBDrill3: TRadioButton
          Left = 56
          Top = 138
          Width = 153
          Height = 17
          Caption = #22616#19978#12289#27836#27901#22320#19978#38075#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = RBDrill3Click
        end
        object RBDrill4: TRadioButton
          Left = 56
          Top = 160
          Width = 185
          Height = 17
          Caption = #22823#38754#31215#31215#27700#21306'('#21547#27700#31291#30000')'#19978#38075#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = RBDrill4Click
        end
        object STDrill1: TStaticText
          Left = 589
          Top = 158
          Width = 74
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
          TabOrder = 11
        end
      end
      object STDrill2: TStaticText
        Left = 589
        Top = 421
        Width = 74
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
    object TabSheet3: TTabSheet
      Caption = #25506#20117#12289#25506#27133
      ImageIndex = 2
      object Label48: TLabel
        Left = 472
        Top = 424
        Width = 137
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25506#20117#12289#25506#27133#25910#36153#37329#39069':'
      end
      object Label49: TLabel
        Left = 700
        Top = 424
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
      end
      object STJCMoney: TStaticText
        Left = 611
        Top = 422
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
        TabOrder = 2
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 724
        Height = 237
        Align = alTop
        Caption = #25506#20117
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label10: TLabel
          Left = 701
          Top = 211
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
        object Label67: TLabel
          Left = 496
          Top = 211
          Width = 114
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25506#20117#25910#36153#37329#39069':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape8: TShape
          Left = 488
          Top = 198
          Width = 232
          Height = 1
        end
        object Label8: TLabel
          Left = 488
          Top = 174
          Width = 122
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #24403#21069#25506#20117#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 701
          Top = 174
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
        object STJ2: TStaticText
          Left = 611
          Top = 209
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
          TabOrder = 0
        end
        object Panel2: TPanel
          Left = 2
          Top = 15
          Width = 722
          Height = 148
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object DGJ1: TDBGrid
            Left = 0
            Top = 0
            Width = 188
            Height = 148
            Align = alLeft
            Ctl3D = False
            DataSource = DSTJ
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
                Title.Caption = #25506#20117#32534#21495
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #23380#21475#26631#39640
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #23436#25104#28145#24230
                Width = 50
                Visible = True
              end>
          end
          object DGJ2: TDBGrid
            Left = 188
            Top = 0
            Width = 146
            Height = 148
            Align = alLeft
            Ctl3D = False
            DataSource = DSTJS
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
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Caption = #23618#21495
                Width = 25
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #20122#23618#21495
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #23618#24213#28145#24230
                Width = 47
                Visible = True
              end>
          end
          object DGJ3: TDBGrid
            Left = 334
            Top = 0
            Width = 388
            Height = 148
            Align = alClient
            Ctl3D = False
            DataSource = DSTJM
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
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #25496#36827#28145#24230
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #28145#24230#33539#22260
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #22303#23618#32534#21495
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #22320#23618
                Width = 26
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
                Title.Caption = #28145#24230
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #37329#39069
                Width = 50
                Visible = True
              end>
          end
        end
        object STJ1: TStaticText
          Left = 611
          Top = 172
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
          TabOrder = 2
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 251
        Width = 730
        Height = 161
        Caption = #25506#27133
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label22: TLabel
          Left = 497
          Top = 54
          Width = 45
          Height = 13
          AutoSize = False
          Caption = #31435#26041#31859
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label19: TLabel
          Left = 328
          Top = 21
          Width = 77
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25496#36827#28145#24230':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label20: TLabel
          Left = 536
          Top = 21
          Width = 70
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #22303#23618#20998#31867':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label21: TLabel
          Left = 328
          Top = 54
          Width = 77
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25496#22303#24635#20307#31215':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 541
          Top = 54
          Width = 69
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
        object Label25: TLabel
          Left = 659
          Top = 54
          Width = 69
          Height = 13
          AutoSize = False
          Caption = #20803'/'#31435#26041#31859
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label26: TLabel
          Left = 336
          Top = 88
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
        object Label28: TLabel
          Left = 500
          Top = 88
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
        object Label32: TLabel
          Left = 520
          Top = 135
          Width = 90
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #25506#27133#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 701
          Top = 135
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
        object Shape11: TShape
          Left = 339
          Top = 122
          Width = 381
          Height = 1
        end
        object CBC1: TComboBox
          Left = 406
          Top = 17
          Width = 102
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
          OnSelect = CBC1Select
        end
        object CBC2: TComboBox
          Left = 608
          Top = 17
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
          OnSelect = CBC2Select
          Items.Strings = (
            #8544
            #8545
            #8546
            #8547
            #8548
            #8549
            #8550
            #8551)
        end
        object EC1: TEdit
          Left = 406
          Top = 51
          Width = 89
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
          Text = '                    0.00'
          OnChange = EC1Change
          OnEnter = EC1Enter
          OnExit = EC1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STC1: TStaticText
          Left = 611
          Top = 52
          Width = 46
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
        object STC2: TStaticText
          Left = 406
          Top = 86
          Width = 90
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
        object BBC1: TBitBtn
          Left = 560
          Top = 82
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
          TabOrder = 4
          OnClick = BBC1Click
        end
        object BBC2: TBitBtn
          Left = 654
          Top = 82
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
          OnClick = BBC2Click
        end
        object STC3: TStaticText
          Left = 611
          Top = 133
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
          TabOrder = 8
        end
        object DGC1: TDBGrid
          Left = 2
          Top = 15
          Width = 320
          Height = 144
          Align = alLeft
          Ctl3D = False
          DataSource = DSTC
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
              Title.Caption = #25496#36827#28145#24230
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #22320#23618
              Width = 30
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25496#22303#24635#20307#31215
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #21462#22303#12289#27700#12289#30707#35797#26009
      ImageIndex = 3
      object Label84: TLabel
        Left = 392
        Top = 423
        Width = 191
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21462#22303#12289#27700#12289#30707#35797#26009#25910#36153#37329#39069':'
      end
      object Label85: TLabel
        Left = 678
        Top = 423
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
      end
      object GroupBox9: TGroupBox
        Left = 0
        Top = 233
        Width = 730
        Height = 176
        Caption = #21462#27700#12289#30707#35797#26009
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label72: TLabel
          Left = 511
          Top = 59
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
          Top = 25
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
          Top = 25
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
          Top = 25
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
          Top = 25
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
          Top = 59
          Width = 57
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '17 '#20803'/'#20214
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label78: TLabel
          Left = 595
          Top = 25
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
          Top = 93
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
        object Label82: TLabel
          Left = 416
          Top = 153
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
          Top = 153
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
        object Label70: TLabel
          Left = 39
          Top = 59
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
          Top = 107
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
          Top = 122
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
          Top = 93
          Width = 57
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '17 '#20803'/'#32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label88: TLabel
          Left = 293
          Top = 122
          Width = 57
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '136 '#20803'/'#32452
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label81: TLabel
          Left = 511
          Top = 93
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
          Top = 122
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
          Top = 46
          Width = 690
          Height = 1
        end
        object Shape9: TShape
          Left = 16
          Top = 144
          Width = 690
          Height = 1
        end
        object Shape10: TShape
          Left = 16
          Top = 83
          Width = 690
          Height = 1
          Pen.Style = psDot
        end
        object EWS1: TEdit
          Left = 448
          Top = 56
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
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STWS1: TStaticText
          Left = 584
          Top = 57
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
        object STWS4: TStaticText
          Left = 584
          Top = 151
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
        object EWS2: TEdit
          Left = 448
          Top = 90
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
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object EWS3: TEdit
          Left = 448
          Top = 119
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
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STWS2: TStaticText
          Left = 584
          Top = 91
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
        object STWS3: TStaticText
          Left = 584
          Top = 120
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
          TabOrder = 6
        end
      end
      object STEWS1: TStaticText
        Left = 584
        Top = 421
        Width = 90
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
          Left = 384
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
          Left = 568
          Top = 69
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
          Left = 700
          Top = 69
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
          Left = 368
          Top = 106
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
          Left = 519
          Top = 106
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
          Left = 560
          Top = 106
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
          Left = 700
          Top = 106
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
        object Label139: TLabel
          Left = 677
          Top = 190
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
        object Label140: TLabel
          Left = 440
          Top = 190
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
        object Label141: TLabel
          Left = 360
          Top = 69
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
        object Shape13: TShape
          Left = 380
          Top = 174
          Width = 339
          Height = 1
        end
        object DGE1: TDBGrid
          Left = 2
          Top = 15
          Width = 351
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
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #21462#26679#28145#24230
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327'('#20214')'
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #25910#36153#37329#39069
              Width = 50
              Visible = True
            end>
        end
        object CBE1: TComboBox
          Left = 448
          Top = 24
          Width = 265
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
          Left = 632
          Top = 66
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
          TabOrder = 3
          Text = '                 0'
          OnChange = EE1Change
          OnEnter = EE1Enter
          OnExit = EE1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STE1: TStaticText
          Left = 445
          Top = 104
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
          TabOrder = 6
        end
        object STE2: TStaticText
          Left = 632
          Top = 104
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
          TabOrder = 7
        end
        object STE3: TStaticText
          Left = 574
          Top = 188
          Width = 100
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
        object BBE1: TBitBtn
          Left = 584
          Top = 137
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
          Top = 137
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
          Left = 445
          Top = 65
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
            '<=50'
            '>50')
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #21160#21147#35302#25506#12289#26631#36143#19982#21313#23383#26495#35797#39564
      ImageIndex = 4
      object Label164: TLabel
        Left = 320
        Top = 428
        Width = 283
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #21160#21147#35302#25506#12289#26631#20934#36143#20837#19982#21313#23383#26495#21098#20999#35797#39564#25910#36153#37329#39069':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label165: TLabel
        Left = 694
        Top = 428
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
      object GroupBox15: TGroupBox
        Left = 369
        Top = 223
        Width = 359
        Height = 195
        Caption = #21313#23383#26495#21098#20999#23454#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label43: TLabel
          Left = 325
          Top = 170
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
        object Label65: TLabel
          Left = 64
          Top = 170
          Width = 170
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21313#23383#26495#21098#20999#23454#39564#25910#36153#37329#39069':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object STCB1: TStaticText
          Left = 235
          Top = 168
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
          TabOrder = 0
        end
        object DGCB1: TDBGrid
          Left = 8
          Top = 15
          Width = 344
          Height = 145
          Ctl3D = False
          DataSource = DSCB1
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
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlack
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #38075#23380#32534#21495
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #27979#35797#28145#24230
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #22320#23618
              Width = 33
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
              Title.Caption = #27425#25968
              Width = 33
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #37329#39069
              Width = 60
              Visible = True
            end>
        end
      end
      object GroupBox16: TGroupBox
        Left = 2
        Top = 223
        Width = 359
        Height = 195
        Caption = #26631#20934#36143#20837#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label154: TLabel
          Left = 325
          Top = 170
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
        object Label155: TLabel
          Left = 80
          Top = 170
          Width = 154
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #26631#20934#36143#20837#35797#39564#25910#36153#37329#39069':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object STBG1: TStaticText
          Left = 235
          Top = 168
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
          TabOrder = 0
        end
        object Panel6: TPanel
          Left = 2
          Top = 15
          Width = 355
          Height = 146
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object DGBG1: TDBGrid
            Left = 4
            Top = 0
            Width = 346
            Height = 146
            Ctl3D = False
            DataSource = DSBG1
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
                Title.Caption = #38075#23380#32534#21495
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #27979#35797#28145#24230
                Width = 60
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #22320#23618
                Width = 33
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
                Title.Caption = #27425#25968
                Width = 33
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #37329#39069
                Width = 60
                Visible = True
              end>
          end
        end
      end
      object STBGCB1: TStaticText
        Left = 604
        Top = 426
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
        TabOrder = 2
      end
      object GroupBox17: TGroupBox
        Left = 0
        Top = 0
        Width = 726
        Height = 217
        Align = alTop
        Caption = #21160#21147#35302#25506
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object Shape17: TShape
          Left = 400
          Top = 14
          Width = 1
          Height = 193
        end
        object Label149: TLabel
          Left = 395
          Top = 76
          Width = 18
          Height = 52
          Caption = #25910#13#10#36153#13#10#35843#13#10#25972'  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label152: TLabel
          Left = 658
          Top = 140
          Width = 63
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'20%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label162: TLabel
          Left = 657
          Top = 42
          Width = 65
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'200%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label163: TLabel
          Left = 657
          Top = 66
          Width = 65
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'100%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label167: TLabel
          Left = 657
          Top = 91
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'40%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label168: TLabel
          Left = 657
          Top = 115
          Width = 65
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label169: TLabel
          Left = 545
          Top = 172
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #32508#21512#35843#25972#31995#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape18: TShape
          Left = 423
          Top = 162
          Width = 297
          Height = 1
          Pen.Style = psDot
        end
        object Label170: TLabel
          Left = 545
          Top = 196
          Width = 89
          Height = 13
          AutoSize = False
          Caption = #21160#25506#25910#36153#37329#39069':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label171: TLabel
          Left = 702
          Top = 196
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
        object Panel5: TPanel
          Left = 2
          Top = 15
          Width = 383
          Height = 200
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Label172: TLabel
            Left = 219
            Top = 179
            Width = 61
            Height = 13
            Alignment = taRightJustify
            AutoSize = False
            Caption = #25910#36153#23567#35745':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label173: TLabel
            Left = 357
            Top = 179
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
          object DGDT1: TDBGrid
            Left = 0
            Top = 0
            Width = 383
            Height = 169
            Align = alTop
            Ctl3D = False
            DataSource = DSDT1
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
                Title.Caption = #38075#23380#32534#21495
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #27979#35797#28145#24230
                Width = 70
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #22320#23618
                Width = 30
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #35302#25506#31867#22411
                Width = 50
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
                Title.Caption = #27425#25968
                Width = 30
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #37329#39069
                Width = 54
                Visible = True
              end>
          end
          object STDT1: TStaticText
            Left = 283
            Top = 177
            Width = 71
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
        object ChBDT1: TCheckBox
          Left = 429
          Top = 16
          Width = 153
          Height = 17
          Caption = #27700#19978#21160#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ChBDT1Click
        end
        object ChBDT4: TCheckBox
          Left = 429
          Top = 138
          Width = 119
          Height = 17
          Caption = #32447#36335#19978#21160#21147#35302#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ChBDT4Click
        end
        object RBDT1: TRadioButton
          Left = 445
          Top = 40
          Width = 145
          Height = 17
          Caption = #28023#19978#21160#25506
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = True
          OnClick = RBDT1Click
        end
        object RBDT2: TRadioButton
          Left = 445
          Top = 64
          Width = 145
          Height = 17
          Caption = #28246#19978#12289#27743#19978#12289#27827#19978#21160#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = RBDT2Click
        end
        object RBDT3: TRadioButton
          Left = 445
          Top = 89
          Width = 145
          Height = 17
          Caption = #22616#19978#12289#27836#27901#22320#19978#21160#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = RBDT3Click
        end
        object RBDT4: TRadioButton
          Left = 445
          Top = 113
          Width = 212
          Height = 19
          Caption = #22823#38754#31215#31215#27700#21306'('#21547#27700#31291#30000')'#19978#21160#21147#35302#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = RBDT4Click
        end
        object STDT2: TStaticText
          Left = 628
          Top = 170
          Width = 71
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
          TabOrder = 7
        end
        object STDT3: TStaticText
          Left = 628
          Top = 194
          Width = 71
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
      end
    end
    object TabSheet6: TTabSheet
      Caption = #38745#21147#35302#25506
      ImageIndex = 5
      object Label68: TLabel
        Left = 471
        Top = 423
        Width = 131
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #35302#25506#27979#35797#25910#36153#37329#39069':'
      end
      object Label35: TLabel
        Left = 679
        Top = 423
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
      object GroupBox14: TGroupBox
        Left = 0
        Top = 0
        Width = 726
        Height = 409
        Align = alTop
        Caption = #38745#21147#35302#25506
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label37: TLabel
          Left = 457
          Top = 227
          Width = 150
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #24403#21069#38075#23380#38745#25506#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label38: TLabel
          Left = 682
          Top = 227
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
        object Shape6: TShape
          Left = 1
          Top = 251
          Width = 727
          Height = 1
        end
        object Label41: TLabel
          Left = 337
          Top = 245
          Width = 54
          Height = 13
          Caption = #25910#36153#35843#25972'  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 604
          Top = 272
          Width = 63
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'15%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label45: TLabel
          Left = 251
          Top = 293
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'200%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label46: TLabel
          Left = 604
          Top = 319
          Width = 72
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'50%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label47: TLabel
          Left = 251
          Top = 323
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'100%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label66: TLabel
          Left = 251
          Top = 353
          Width = 74
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'40%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label156: TLabel
          Left = 251
          Top = 383
          Width = 66
          Height = 13
          AutoSize = False
          Caption = '('#22686#21152'30%)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label157: TLabel
          Left = 514
          Top = 379
          Width = 89
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #32508#21512#35843#25972#31995#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape16: TShape
          Left = 429
          Top = 359
          Width = 259
          Height = 1
          Pen.Style = psDot
        end
        object Label44: TLabel
          Left = 204
          Top = 228
          Width = 109
          Height = 13
          AutoSize = False
          Caption = '('#25353#26631#20934'50%'#25910#36153')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Panel4: TPanel
          Left = 2
          Top = 15
          Width = 722
          Height = 202
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object DGJT1: TDBGrid
            Left = 0
            Top = 0
            Width = 188
            Height = 202
            Align = alLeft
            Ctl3D = False
            DataSource = DSJT1
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
                Title.Caption = #38075#23380#32534#21495
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #36215#22987#28145#24230
                Width = 50
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #35797#39564#28145#24230
                Width = 50
                Visible = True
              end>
          end
          object DGJT2: TDBGrid
            Left = 188
            Top = 0
            Width = 146
            Height = 202
            Align = alLeft
            Ctl3D = False
            DataSource = DSJT2
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
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Caption = #23618#21495
                Width = 28
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #20122#23618#21495
                Width = 38
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #23618#24213#28145#24230
                Width = 55
                Visible = True
              end>
          end
          object DGJT3: TDBGrid
            Left = 334
            Top = 0
            Width = 388
            Height = 202
            Align = alClient
            Ctl3D = False
            DataSource = DSJT3
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
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #27979#35797#28145#24230
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #28145#24230#33539#22260
                Width = 65
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #22303#23618#32534#21495
                Width = 54
                Visible = True
              end
              item
                Expanded = False
                Title.Caption = #22320#23618
                Width = 26
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
                Title.Caption = #28145#24230
                Width = 40
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = #37329#39069
                Width = 50
                Visible = True
              end>
          end
        end
        object STJT1: TStaticText
          Left = 609
          Top = 225
          Width = 69
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
        object ChBJT2: TCheckBox
          Left = 429
          Top = 270
          Width = 97
          Height = 17
          Caption = #38745#25506#21452#26725#25506#22836
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ChBJT2Click
        end
        object ChBJT1: TCheckBox
          Left = 32
          Top = 262
          Width = 153
          Height = 17
          Caption = #27700#19978#38745#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = ChBJT1Click
        end
        object RBJT1: TRadioButton
          Left = 48
          Top = 291
          Width = 137
          Height = 17
          Caption = #28023#19978#38745#25506
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TabStop = True
          OnClick = RBJT1Click
        end
        object ChBJT4: TCheckBox
          Left = 429
          Top = 317
          Width = 97
          Height = 17
          Caption = #36335#32447#19978#30340#38745#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = ChBJT4Click
        end
        object RBJT2: TRadioButton
          Left = 48
          Top = 321
          Width = 145
          Height = 17
          Caption = #28246#19978#12289#27743#19978#12289#27827#19978#38745#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = RBJT2Click
        end
        object RBJT3: TRadioButton
          Left = 48
          Top = 351
          Width = 145
          Height = 17
          Caption = #22616#19978#12289#27836#27901#22320#19978#38745#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnClick = RBJT3Click
        end
        object RBJT4: TRadioButton
          Left = 48
          Top = 381
          Width = 185
          Height = 17
          Caption = #22823#38754#31215#31215#27700#21306'('#21547#27700#31291#30000')'#19978#38745#25506
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = RBJT4Click
        end
        object STJT2: TStaticText
          Left = 606
          Top = 377
          Width = 70
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
          TabOrder = 9
        end
        object ChBJT3: TCheckBox
          Left = 29
          Top = 226
          Width = 97
          Height = 17
          Caption = #36731#20415#38745#21147#35302#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = ChBJT3Click
        end
      end
      object STJT3: TStaticText
        Left = 605
        Top = 421
        Width = 69
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
    object TabSheet7: TTabSheet
      Caption = #26049#21387#12289#21387#27700#12289#27880#27700#19982#23380#38553#27700#21387#21147#35797#39564
      ImageIndex = 6
      object Label124: TLabel
        Left = 304
        Top = 425
        Width = 278
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #26049#21387#12289#21387#27700#12289#27880#27700#19982#23380#38553#27700#21387#21147#35797#39564#25910#36153':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label125: TLabel
        Left = 679
        Top = 425
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
      object GroupBox10: TGroupBox
        Left = 0
        Top = 0
        Width = 724
        Height = 143
        Align = alTop
        Caption = #26049#21387#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label92: TLabel
          Left = 380
          Top = 15
          Width = 65
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = #27979#35797#28145#24230':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label93: TLabel
          Left = 384
          Top = 49
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
        object Label94: TLabel
          Left = 516
          Top = 49
          Width = 18
          Height = 13
          AutoSize = False
          Caption = #27425
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label95: TLabel
          Left = 552
          Top = 49
          Width = 68
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
        object Label96: TLabel
          Left = 667
          Top = 49
          Width = 34
          Height = 13
          AutoSize = False
          Caption = #20803'/'#27425
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label97: TLabel
          Left = 376
          Top = 83
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
        object Label98: TLabel
          Left = 516
          Top = 83
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
        object Label99: TLabel
          Left = 685
          Top = 120
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
        object Label100: TLabel
          Left = 448
          Top = 120
          Width = 133
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #26049#21387#35797#39564#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label101: TLabel
          Left = 544
          Top = 17
          Width = 76
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #35797#39564#21387#21147':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape5: TShape
          Left = 376
          Top = 110
          Width = 339
          Height = 1
        end
        object DGP1: TDBGrid
          Left = 2
          Top = 15
          Width = 351
          Height = 126
          Align = alLeft
          Ctl3D = False
          DataSource = DSP
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
              Title.Caption = #27979#35797#28145#24230
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #35797#39564#21387#21147
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #26631#20934#21333#20215
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #25968#37327'('#27425')'
              Width = 60
              Visible = True
            end
            item
              Expanded = False
              Title.Caption = #25910#36153#37329#39069
              Width = 60
              Visible = True
            end>
        end
        object CBP1: TComboBox
          Left = 448
          Top = 13
          Width = 91
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
          OnSelect = CBP1Select
        end
        object EP1: TEdit
          Left = 448
          Top = 46
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
          TabOrder = 3
          Text = '                 0'
          OnChange = EP1Change
          OnEnter = EP1Enter
          OnExit = EP1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STP1: TStaticText
          Left = 621
          Top = 47
          Width = 44
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
        object STP2: TStaticText
          Left = 448
          Top = 81
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
          TabOrder = 7
        end
        object STP3: TStaticText
          Left = 582
          Top = 118
          Width = 100
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
        object BBP1: TBitBtn
          Left = 568
          Top = 77
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
          OnClick = BBP1Click
        end
        object BBP2: TBitBtn
          Left = 647
          Top = 77
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
          OnClick = BBP2Click
        end
        object CBP2: TComboBox
          Left = 621
          Top = 13
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
          OnSelect = CBP2Select
          Items.Strings = (
            #39640#21387'(>2500kPa)'
            #20302#21387'(<=2500kPa)')
        end
      end
      object GroupBox11: TGroupBox
        Left = 0
        Top = 153
        Width = 730
        Height = 181
        Caption = #21387#27700#12289#27880#27700#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label103: TLabel
          Left = 39
          Top = 19
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35797#39564#20998#31867
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label104: TLabel
          Left = 157
          Top = 19
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35797#39564#26041#24335
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label105: TLabel
          Left = 432
          Top = 19
          Width = 89
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #25968#37327'('#27573#12289#27425')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label106: TLabel
          Left = 264
          Top = 19
          Width = 137
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #26631#20934#21333#20215'('#20803'/'#27573#12289#27425')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label107: TLabel
          Left = 304
          Top = 70
          Width = 47
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '1224'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label108: TLabel
          Left = 595
          Top = 19
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
        object Label109: TLabel
          Left = 155
          Top = 101
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #38075#23380#27880#27700
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label110: TLabel
          Left = 416
          Top = 157
          Width = 166
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = #21387#27700#12289#27880#27700#35797#39564#25910#36153#23567#35745':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label111: TLabel
          Left = 679
          Top = 157
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
        object Label112: TLabel
          Left = 136
          Top = 70
          Width = 97
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35797#39564#28145#24230'>20m'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label113: TLabel
          Left = 39
          Top = 112
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #27880#27700#35797#39564
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label114: TLabel
          Left = 155
          Top = 125
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #25506#20117#27880#27700
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label115: TLabel
          Left = 305
          Top = 101
          Width = 47
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '238 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label116: TLabel
          Left = 302
          Top = 125
          Width = 47
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '119'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label119: TLabel
          Left = 38
          Top = 57
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #21387#27700#35797#39564
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label120: TLabel
          Left = 306
          Top = 46
          Width = 47
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '1020 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label138: TLabel
          Left = 136
          Top = 46
          Width = 101
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35797#39564#28145#24230'<=20m'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape1: TShape
          Left = 16
          Top = 91
          Width = 690
          Height = 1
          Pen.Style = psDot
        end
        object Shape2: TShape
          Left = 16
          Top = 36
          Width = 690
          Height = 1
        end
        object Shape3: TShape
          Left = 16
          Top = 147
          Width = 690
          Height = 1
        end
        object EYZ2: TEdit
          Left = 448
          Top = 67
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
          OnEnter = EYZ2Enter
          OnExit = EYZ2Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STYZ2: TStaticText
          Left = 584
          Top = 68
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
        object STYZ5: TStaticText
          Left = 584
          Top = 155
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
        object EYZ3: TEdit
          Left = 448
          Top = 98
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
          OnEnter = EYZ3Enter
          OnExit = EYZ3Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object EYZ4: TEdit
          Left = 448
          Top = 122
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
          TabOrder = 3
          Text = '               0'
          OnEnter = EYZ4Enter
          OnExit = EYZ4Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STYZ3: TStaticText
          Left = 584
          Top = 99
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
          TabOrder = 6
        end
        object STYZ4: TStaticText
          Left = 584
          Top = 123
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
          TabOrder = 7
        end
        object EYZ1: TEdit
          Left = 447
          Top = 43
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
          OnEnter = EYZ1Enter
          OnExit = EYZ1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STYZ1: TStaticText
          Left = 583
          Top = 44
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
          TabOrder = 8
        end
      end
      object GroupBox12: TGroupBox
        Left = 0
        Top = 346
        Width = 730
        Height = 69
        Caption = #23380#38553#27700#21387#21147#35797#39564
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object Label126: TLabel
          Left = 34
          Top = 19
          Width = 66
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #27979#35797#28145#24230
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label127: TLabel
          Left = 165
          Top = 19
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #35266#27979#26102#38388
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label128: TLabel
          Left = 296
          Top = 19
          Width = 97
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #26631#20934#21333#20215'('#20803'/'#28857')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label129: TLabel
          Left = 458
          Top = 19
          Width = 69
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #25968#37327'('#28857')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clActiveCaption
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label130: TLabel
          Left = 595
          Top = 19
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
        object Label133: TLabel
          Left = 33
          Top = 46
          Width = 65
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #23380#28145'<10m'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label134: TLabel
          Left = 163
          Top = 46
          Width = 62
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = #19968#20010#26376
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label135: TLabel
          Left = 312
          Top = 46
          Width = 49
          Height = 13
          Alignment = taRightJustify
          AutoSize = False
          Caption = '8415 '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape4: TShape
          Left = 14
          Top = 37
          Width = 690
          Height = 1
        end
        object STK1: TStaticText
          Left = 584
          Top = 44
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
        object EK1: TEdit
          Left = 460
          Top = 43
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
          OnEnter = EK1Enter
          OnExit = EK1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
      end
      object STPYZK1: TStaticText
        Left = 584
        Top = 423
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
    end
  end
  object GroupBox6: TGroupBox
    Left = 0
    Top = 476
    Width = 449
    Height = 153
    Align = alLeft
    TabOrder = 2
    object Label6: TLabel
      Left = 38
      Top = 19
      Width = 73
      Height = 13
      AutoSize = False
      Caption = #24037#31243#32534#21495#65306
    end
    object Label7: TLabel
      Left = 38
      Top = 47
      Width = 73
      Height = 13
      AutoSize = False
      Caption = #24037#31243#21517#31216#65306
    end
    object Label39: TLabel
      Left = 38
      Top = 103
      Width = 132
      Height = 13
      AutoSize = False
      Caption = #22320#36136#21208#23519#25910#36153#21512#35745#65306
    end
    object Label40: TLabel
      Left = 298
      Top = 104
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Label1: TLabel
      Left = 226
      Top = 77
      Width = 30
      Height = 13
      Caption = #22686#21152'  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 291
      Top = 75
      Width = 24
      Height = 16
      Caption = '  %  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ChBRecon1: TCheckBox
      Left = 38
      Top = 75
      Width = 167
      Height = 17
      Caption = #22797#26434#22330#22320#21208#23519'('#22686#21152'10'#65374'30%)'
      TabOrder = 0
      OnClick = ChBRecon1Click
    end
    object STRecon1: TStaticText
      Left = 108
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
      TabOrder = 2
    end
    object STRecon2: TStaticText
      Left = 108
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
      TabOrder = 3
    end
    object STRecon3: TStaticText
      Left = 168
      Top = 102
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
      TabOrder = 4
    end
    object EdtRecon1: TEdit
      Left = 258
      Top = 73
      Width = 20
      Height = 20
      Enabled = False
      ImeName = #26085#26412#35486' (MS-IME2000)'
      TabOrder = 1
      Text = '10'
      OnEnter = EdtRecon1Enter
      OnExit = EdtRecon1Exit
      OnKeyPress = EdtRecon1KeyPress
      OnMouseDown = EdtRecon1MouseDown
    end
    object UpDown1: TUpDown
      Left = 278
      Top = 73
      Width = 16
      Height = 21
      Enabled = False
      Min = 10
      Max = 30
      Position = 10
      TabOrder = 5
      OnChangingEx = UpDown1ChangingEx
    end
  end
  object BBRecon1: TBitBtn
    Left = 531
    Top = 534
    Width = 163
    Height = 25
    Caption = #22797#26434#31243#24230#19982#22320#23618#20998#31867#34920
    TabOrder = 3
    OnClick = BBRecon1Click
  end
  object AQMap: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQMapAfterInsert
    AfterScroll = AQMapAfterScroll
    Parameters = <>
    Left = 408
    Top = 480
  end
  object DSMap: TDataSource
    DataSet = AQMap
    Left = 440
    Top = 480
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 712
    Top = 544
  end
  object DSDill: TDataSource
    DataSet = AQDrill
    Left = 496
    Top = 480
  end
  object DSStratum: TDataSource
    DataSet = AQStratum
    Left = 544
    Top = 480
  end
  object DSMoney: TDataSource
    DataSet = AQMoney
    Left = 592
    Top = 480
  end
  object AQDrill: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQDrillAfterScroll
    Parameters = <>
    Left = 472
    Top = 480
  end
  object AQStratum: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQStratumAfterScroll
    Parameters = <>
    Left = 520
    Top = 480
  end
  object AQMoney: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 568
    Top = 480
  end
  object AQTC: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQTCAfterInsert
    AfterScroll = AQTCAfterScroll
    Parameters = <>
    Left = 624
    Top = 480
  end
  object AQE: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQEAfterInsert
    AfterScroll = AQEAfterScroll
    Parameters = <>
    Left = 672
    Top = 480
  end
  object DSTC: TDataSource
    DataSet = AQTC
    Left = 648
    Top = 480
  end
  object DSE: TDataSource
    DataSet = AQE
    Left = 704
    Top = 480
  end
  object DSP: TDataSource
    DataSet = AQP
    Left = 712
    Top = 512
  end
  object AQP: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQPAfterInsert
    AfterScroll = AQPAfterScroll
    Parameters = <>
    Left = 688
    Top = 512
  end
  object AQTJ: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJAfterScroll
    Parameters = <>
    Left = 400
    Top = 512
  end
  object DSTJ: TDataSource
    DataSet = AQTJ
    Left = 424
    Top = 512
  end
  object AQTJS: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJSAfterScroll
    Parameters = <>
    Left = 448
    Top = 512
  end
  object DSTJS: TDataSource
    DataSet = AQTJS
    Left = 472
    Top = 512
  end
  object AQTJM: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 496
    Top = 512
  end
  object DSTJM: TDataSource
    DataSet = AQTJM
    Left = 520
    Top = 512
  end
  object AQDT1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 408
    Top = 544
  end
  object DSDT1: TDataSource
    DataSet = AQDT1
    Left = 432
    Top = 544
  end
  object AQJT1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQJT1AfterScroll
    Parameters = <>
    Left = 408
    Top = 576
  end
  object DSJT1: TDataSource
    DataSet = AQJT1
    Left = 432
    Top = 576
  end
  object AQJT2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQJT2AfterScroll
    Parameters = <>
    Left = 456
    Top = 576
  end
  object DSJT2: TDataSource
    DataSet = AQJT2
    Left = 480
    Top = 576
  end
  object AQJT3: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 504
    Top = 576
  end
  object DSJT3: TDataSource
    DataSet = AQJT3
    Left = 528
    Top = 576
  end
  object AQBG1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 336
    Top = 544
  end
  object DSBG1: TDataSource
    DataSet = AQBG1
    Left = 360
    Top = 544
  end
  object AQBG2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJSAfterScroll
    Parameters = <>
    Left = 384
    Top = 544
  end
  object AQCB1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 488
    Top = 544
  end
  object DSCB1: TDataSource
    DataSet = AQCB1
    Left = 512
    Top = 544
  end
  object AQCB2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJSAfterScroll
    Parameters = <>
    Left = 536
    Top = 544
  end
  object AQDT2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 464
    Top = 544
  end
end
