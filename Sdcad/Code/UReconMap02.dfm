object ReconMap02: TReconMap02
  Left = 189
  Top = 106
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #24037#31243#22320#36136#27979#32472'(2002'#26631#20934')'
  ClientHeight = 569
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
    Top = 86
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
    Left = 609
    Top = 530
    Width = 110
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
    ActivePage = TabSheet1
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
          ItemHeight = 13
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
            #31616#21333
            #20013#31561
            #22797#26434)
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
          OnKeyPress = EdtMap1KeyPress
          OnMouseDown = EdtMap1MouseDown
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
          Width = 88
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
          Left = 265
          Top = 66
          Width = 96
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
        object ChBMap1: TCheckBox
          Left = 48
          Top = 30
          Width = 217
          Height = 17
          Caption = #22320#36136#27979#32472#21644#24037#31243#22320#36136#27979#32472#21516#26102#36827#34892
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
  end
  object GroupBox6: TGroupBox
    Left = 0
    Top = 476
    Width = 449
    Height = 93
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
      TabOrder = 0
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
      TabOrder = 1
    end
  end
  object BBRecon1: TBitBtn
    Left = 481
    Top = 530
    Width = 110
    Height = 25
    Caption = #22797#26434#31243#24230#34920
    TabOrder = 3
    OnClick = BBRecon1Click
  end
  object AQMap: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = AQMapAfterInsert
    AfterScroll = AQMapAfterScroll
    Parameters = <>
    Left = 456
    Top = 480
  end
  object DSMap: TDataSource
    DataSet = AQMap
    Left = 480
    Top = 480
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 504
    Top = 480
  end
end
