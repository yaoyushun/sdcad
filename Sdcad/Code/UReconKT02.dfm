object ReconKT02: TReconKT02
  Left = 168
  Top = 79
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #23721#22303#24037#31243#21208#25506'(2002'#26631#20934')'
  ClientHeight = 618
  ClientWidth = 731
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
    Top = 83
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
    Top = 561
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
    Width = 731
    Height = 429
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = #38075#23380
      ImageIndex = 1
      object Label62: TLabel
        Left = 419
        Top = 383
        Width = 113
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #38075#23380#25910#36153#37329#39069':'
      end
      object Label63: TLabel
        Left = 616
        Top = 383
        Width = 17
        Height = 13
        AutoSize = False
        Caption = #20803
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 723
        Height = 199
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
          Top = 177
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
          Top = 177
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
          Width = 719
          Height = 154
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object DGDrill1: TDBGrid
            Left = 0
            Top = 0
            Width = 188
            Height = 154
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
            Height = 154
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
            Width = 385
            Height = 154
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
          Top = 175
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
        Top = 207
        Width = 730
        Height = 167
        Caption = #25910#36153#35843#25972
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label50: TLabel
          Left = 633
          Top = 25
          Width = 88
          Height = 18
          AutoSize = False
          Caption = '('#35843#25972#31995#25968'1.5)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBackground
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label51: TLabel
          Left = 633
          Top = 61
          Width = 88
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
        object Label53: TLabel
          Left = 633
          Top = 116
          Width = 88
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
        object Label56: TLabel
          Left = 259
          Top = 40
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
          Top = 61
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
          Top = 82
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
          Top = 103
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
          Left = 418
          Top = 146
          Width = 119
          Height = 13
          AutoSize = False
          Caption = #38075#23380#32508#21512#35843#25972#31995#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Shape12: TShape
          Left = 413
          Top = 139
          Width = 297
          Height = 1
        end
        object Label2: TLabel
          Left = 633
          Top = 89
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
          Top = 124
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
          Top = 145
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
        object CBDrill1: TCheckBox
          Left = 419
          Top = 17
          Width = 201
          Height = 34
          Caption = #36319#31649#38075#36827#12289#27877#27974#25252#22721#12289#22522#23721#26080#27700#24178#38075#12289#22522#23721#30772#30862#24102#38075#36827#21462#33455
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          WordWrap = True
          OnClick = CBDrill1Click
        end
        object CBDrill2: TCheckBox
          Left = 419
          Top = 59
          Width = 153
          Height = 17
          Caption = #27700#24179#23380#12289#26012#23380#38075#25506
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = CBDrill2Click
        end
        object CBDrill3: TCheckBox
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
          OnClick = CBDrill3Click
        end
        object CBDrill5: TCheckBox
          Left = 419
          Top = 114
          Width = 153
          Height = 17
          Caption = #22353#36947#20869#20316#19994
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnClick = CBDrill5Click
        end
        object RBDrill1: TRadioButton
          Left = 47
          Top = 38
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
          Top = 59
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
          Top = 122
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
          Top = 143
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
          Left = 540
          Top = 144
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
        object CBDrill4: TCheckBox
          Left = 419
          Top = 87
          Width = 153
          Height = 17
          Caption = #22812#38388#20316#19994
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnClick = CBDrill4Click
        end
        object RBDrill3: TRadioButton
          Left = 47
          Top = 80
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
          Top = 101
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
      end
      object STDrill2: TStaticText
        Left = 540
        Top = 381
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
      Caption = #25506#20117
      ImageIndex = 2
      object Label67: TLabel
        Left = 506
        Top = 380
        Width = 98
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
      object Label10: TLabel
        Left = 699
        Top = 380
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
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 725
        Height = 369
        Align = alTop
        Caption = #25506#20117
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label8: TLabel
          Left = 483
          Top = 342
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
          Left = 699
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
        object Panel2: TPanel
          Left = 2
          Top = 15
          Width = 721
          Height = 310
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object DGJ1: TDBGrid
            Left = 0
            Top = 0
            Width = 188
            Height = 310
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
            Height = 310
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
            Width = 387
            Height = 310
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
          Left = 606
          Top = 340
          Width = 89
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
      object STJ2: TStaticText
        Left = 605
        Top = 378
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
        TabOrder = 1
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25506#27133
      ImageIndex = 2
      object Label32: TLabel
        Left = 419
        Top = 380
        Width = 114
        Height = 13
        Alignment = taRightJustify
        AutoSize = False
        Caption = #25506#27133#25910#36153#37329#39069':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label34: TLabel
        Left = 640
        Top = 380
        Width = 20
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
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 723
        Height = 369
        Align = alTop
        Caption = #25506#27133
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label22: TLabel
          Left = 640
          Top = 119
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
          Left = 456
          Top = 29
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
          Left = 463
          Top = 73
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
          Left = 456
          Top = 118
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
          Left = 464
          Top = 163
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
          Left = 640
          Top = 162
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
          Left = 464
          Top = 208
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
          Left = 640
          Top = 208
          Width = 21
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
        object CBC1: TComboBox
          Left = 534
          Top = 25
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
          ItemHeight = 13
          ParentCtl3D = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 1
          OnSelect = CBC1Select
        end
        object CBC2: TComboBox
          Left = 534
          Top = 70
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
            #8549)
        end
        object EC1: TEdit
          Left = 534
          Top = 115
          Width = 102
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
          Text = '                         0.00'
          OnChange = EC1Change
          OnEnter = EC1Enter
          OnExit = EC1Exit
          OnKeyPress = EDrill1KeyPress
          OnMouseDown = EDrill1MouseDown
        end
        object STC1: TStaticText
          Left = 534
          Top = 160
          Width = 102
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
          Left = 534
          Top = 206
          Width = 102
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
          Left = 565
          Top = 245
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
          Left = 659
          Top = 245
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
        object DGC1: TDBGrid
          Left = 2
          Top = 15
          Width = 399
          Height = 352
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
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              Title.Alignment = taCenter
              Title.Caption = #22320#23618
              Width = 40
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
              Title.Caption = #25496#22303#24635#20307#31215
              Width = 80
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
      end
      object STC3: TStaticText
        Left = 534
        Top = 378
        Width = 102
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
    Left = 0
    Top = 429
    Width = 449
    Height = 189
    Align = alLeft
    TabOrder = 2
    object Label6: TLabel
      Left = 38
      Top = 18
      Width = 73
      Height = 13
      AutoSize = False
      Caption = #24037#31243#32534#21495#65306
    end
    object Label7: TLabel
      Left = 38
      Top = 44
      Width = 73
      Height = 13
      AutoSize = False
      Caption = #24037#31243#21517#31216#65306
    end
    object Label39: TLabel
      Left = 38
      Top = 150
      Width = 132
      Height = 13
      AutoSize = False
      Caption = #22320#36136#21208#23519#25910#36153#21512#35745#65306
    end
    object Label40: TLabel
      Left = 264
      Top = 151
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Label1: TLabel
      Left = 301
      Top = 74
      Width = 111
      Height = 13
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
      Left = 301
      Top = 102
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
    object Label11: TLabel
      Left = 38
      Top = 125
      Width = 121
      Height = 13
      AutoSize = False
      Caption = #21208#25506#32508#21512#35843#25972#31995#25968':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object STRecon1: TStaticText
      Left = 108
      Top = 16
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
      Left = 108
      Top = 42
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
      Left = 166
      Top = 149
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
      TabOrder = 2
    end
    object ChBRecon1: TCheckBox
      Left = 38
      Top = 64
      Width = 219
      Height = 33
      Caption = #23721#28342#12289#27934#31348#12289#27877#30707#27969#12289#28369#22369#12289#27801#28448#12289#23665#21069#27946#31215#35033#31561#22797#26434#22330#22320
      TabOrder = 3
      WordWrap = True
      OnClick = ChBRecon1Click
    end
    object CBDrill7: TCheckBox
      Left = 38
      Top = 100
      Width = 153
      Height = 17
      Caption = #32447#36335#19978#20316#19994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = CBDrill7Click
    end
    object STRecon4: TStaticText
      Left = 167
      Top = 124
      Width = 89
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
      TabOrder = 5
    end
    object Edit1: TEdit
      Tag = 2
      Left = 264
      Top = 71
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
      TabOrder = 6
      Text = '   1.10'
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
      OnKeyPress = Edit1KeyPress
      OnMouseDown = EDrill1MouseDown
    end
  end
  object BBRecon1: TBitBtn
    Left = 531
    Top = 503
    Width = 163
    Height = 25
    Caption = #23721#22303#24037#31243#21208#25506#22797#26434#31243#24230#34920
    TabOrder = 3
    OnClick = BBRecon1Click
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 696
    Top = 528
  end
  object DSDill: TDataSource
    DataSet = AQDrill
    Left = 496
    Top = 440
  end
  object DSStratum: TDataSource
    DataSet = AQStratum
    Left = 544
    Top = 440
  end
  object DSMoney: TDataSource
    DataSet = AQMoney
    Left = 592
    Top = 440
  end
  object AQDrill: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQDrillAfterScroll
    Parameters = <>
    Left = 472
    Top = 440
  end
  object AQStratum: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQStratumAfterScroll
    Parameters = <>
    Left = 520
    Top = 440
  end
  object AQMoney: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 568
    Top = 440
  end
  object AQTC: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQTCAfterInsert
    AfterScroll = AQTCAfterScroll
    Parameters = <>
    Left = 624
    Top = 440
  end
  object DSTC: TDataSource
    DataSet = AQTC
    Left = 648
    Top = 440
  end
  object AQTJ: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJAfterScroll
    Parameters = <>
    Left = 456
    Top = 520
  end
  object DSTJ: TDataSource
    DataSet = AQTJ
    Left = 480
    Top = 520
  end
  object AQTJS: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterScroll = AQTJSAfterScroll
    Parameters = <>
    Left = 504
    Top = 520
  end
  object DSTJS: TDataSource
    DataSet = AQTJS
    Left = 528
    Top = 520
  end
  object AQTJM: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 552
    Top = 520
  end
  object DSTJM: TDataSource
    DataSet = AQTJM
    Left = 576
    Top = 520
  end
end
