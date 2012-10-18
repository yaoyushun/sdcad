object FOtherCharges92: TFOtherCharges92
  Left = 359
  Top = 170
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #20854#23427#36153#29992
  ClientHeight = 390
  ClientWidth = 417
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
  object Label1: TLabel
    Left = 194
    Top = 228
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #20854#23427#36153#29992#21512#35745#65306
  end
  object Label3: TLabel
    Left = 374
    Top = 228
    Width = 17
    Height = 13
    AutoSize = False
    Caption = #20803
  end
  object Bevel1: TBevel
    Left = 20
    Top = 312
    Width = 377
    Height = 9
    Shape = bsTopLine
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 417
    Height = 193
    Align = alTop
    DataSource = DataSource1
    FixedColor = 15198183
    ImeName = #26085#26412#35486' (MS-IME2000)'
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #39033#30446
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #35745#31639#26041#27861
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = #21333#20215
        Width = 70
        Visible = True
      end
      item
        Color = clMoneyGreen
        Expanded = False
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = #37329#39069
        Width = 70
        Visible = True
      end>
  end
  object BitBtn1: TBitBtn
    Left = 300
    Top = 335
    Width = 89
    Height = 25
    Caption = #20851#38381
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object ST_Others: TStaticText
    Left = 298
    Top = 226
    Width = 73
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    BorderStyle = sbsSingle
    Caption = '0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 21
    Top = 319
    Width = 265
    Height = 57
    TabOrder = 3
    object Label6: TLabel
      Left = 7
      Top = 13
      Width = 59
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#32534#21495':'
    end
    object Label7: TLabel
      Left = 8
      Top = 35
      Width = 57
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #24037#31243#21517#31216':'
    end
    object StaticText1: TStaticText
      Left = 67
      Top = 11
      Width = 190
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
    object StaticText2: TStaticText
      Left = 67
      Top = 33
      Width = 190
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
  object GroupBox2: TGroupBox
    Left = 21
    Top = 247
    Width = 369
    Height = 57
    Caption = #35828#26126
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label2: TLabel
      Left = 16
      Top = 37
      Width = 124
      Height = 13
      AutoSize = False
      Caption = #25353'Ctrl+Del '#21024#38500#24403#21069#35760#24405
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 18
      Width = 281
      Height = 13
      AutoSize = False
      Caption = #24403#21069#35760#24405#20026#26368#21518#19968#26465#26102#65292#25353#8595#20809#26631#38190#25554#20837#26032#35760#24405
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 312
    Top = 328
  end
  object ADOQuery1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    AfterInsert = ADOQuery1AfterInsert
    AfterPost = ADOQuery1AfterPost
    AfterDelete = ADOQuery1AfterDelete
    BeforeScroll = ADOQuery1BeforeScroll
    Parameters = <>
    Left = 280
    Top = 328
  end
  object ADOQuery2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 344
    Top = 328
  end
end
