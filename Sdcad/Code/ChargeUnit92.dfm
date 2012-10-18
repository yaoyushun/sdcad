object ChargeForm92: TChargeForm92
  Left = 197
  Top = 39
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #24037#31243#20915#31639'(1992'#26631#20934')'
  ClientHeight = 623
  ClientWidth = 685
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
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
  object Label1: TLabel
    Left = 14
    Top = 38
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #24037#31243#32534#21495#65306
  end
  object Label2: TLabel
    Left = 222
    Top = 38
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #24037#31243#21517#31216#65306
  end
  object StaticText1: TStaticText
    Left = 78
    Top = 36
    Width = 105
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
    Left = 286
    Top = 36
    Width = 387
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
  object GroupBox1: TGroupBox
    Left = 16
    Top = 58
    Width = 657
    Height = 132
    TabOrder = 2
    object Bevel1: TBevel
      Left = 320
      Top = 32
      Width = 9
      Height = 65
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Bevel2: TBevel
      Left = 2
      Top = 98
      Width = 654
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Label3: TLabel
      Left = 208
      Top = 109
      Width = 65
      Height = 13
      AutoSize = False
      Caption = #25910#36153#21512#35745#65306
    end
    object Label4: TLabel
      Left = 208
      Top = 77
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Label5: TLabel
      Left = 544
      Top = 77
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Label6: TLabel
      Left = 392
      Top = 109
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Bevel9: TBevel
      Left = 2
      Top = 32
      Width = 654
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Label12: TLabel
      Left = 272
      Top = 12
      Width = 105
      Height = 19
      AutoSize = False
      Caption = #24037#31243#25910#36153#35745#31639
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 56
      Top = 41
      Width = 193
      Height = 25
      Caption = #24037#31243#22320#36136#21208#23519
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 392
      Top = 41
      Width = 193
      Height = 25
      Caption = #23460#20869#35797#39564
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object StaticText3: TStaticText
      Left = 96
      Top = 75
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
      TabOrder = 2
    end
    object StaticText4: TStaticText
      Left = 432
      Top = 75
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
      TabOrder = 3
    end
    object StaticText5: TStaticText
      Left = 280
      Top = 107
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
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 195
    Width = 657
    Height = 123
    TabOrder = 3
    object Bevel3: TBevel
      Left = 0
      Top = 55
      Width = 656
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Bevel4: TBevel
      Left = 472
      Top = 31
      Width = 9
      Height = 90
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label7: TLabel
      Left = 136
      Top = 38
      Width = 73
      Height = 13
      AutoSize = False
      Caption = '<=10000'#20803
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 328
      Top = 38
      Width = 97
      Height = 13
      AutoSize = False
      Caption = #36229#36807'10000'#20803#37096#20998
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel5: TBevel
      Left = 264
      Top = 31
      Width = 9
      Height = 90
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label9: TLabel
      Left = 8
      Top = 61
      Width = 81
      Height = 13
      AutoSize = False
      Caption = #24037#31243#36153#29992'('#20803')'
    end
    object Label10: TLabel
      Left = 8
      Top = 82
      Width = 57
      Height = 13
      AutoSize = False
      Caption = #25910#36153#29575'(%)'
    end
    object Label11: TLabel
      Left = 9
      Top = 104
      Width = 72
      Height = 13
      AutoSize = False
      Caption = #25216#26415#36153'('#20803')'
    end
    object Bevel6: TBevel
      Left = 88
      Top = 32
      Width = 9
      Height = 90
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Bevel7: TBevel
      Left = 1
      Top = 77
      Width = 472
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Bevel8: TBevel
      Left = 1
      Top = 99
      Width = 472
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Bevel10: TBevel
      Left = 1
      Top = 31
      Width = 654
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Label13: TLabel
      Left = 9
      Top = 38
      Width = 40
      Height = 13
      AutoSize = False
      Caption = #39033#30446
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 288
      Top = 11
      Width = 73
      Height = 19
      AutoSize = False
      Caption = #25216#26415#25910#36153
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 552
      Top = 38
      Width = 49
      Height = 13
      AutoSize = False
      Caption = #21512#35745'('#20803')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 203
      Top = 83
      Width = 38
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '25'
    end
    object Label17: TLabel
      Left = 416
      Top = 83
      Width = 25
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '20'
    end
    object StaticText6: TStaticText
      Left = 112
      Top = 61
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object StaticText7: TStaticText
      Left = 320
      Top = 61
      Width = 121
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object StaticText8: TStaticText
      Left = 112
      Top = 105
      Width = 129
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object StaticText9: TStaticText
      Left = 320
      Top = 105
      Width = 121
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object StaticText10: TStaticText
      Left = 520
      Top = 82
      Width = 97
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      Caption = '0.00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 16
    Top = 324
    Width = 657
    Height = 206
    Color = 15198183
    ParentColor = False
    TabOrder = 4
    object Label18: TLabel
      Left = 272
      Top = 12
      Width = 97
      Height = 19
      AutoSize = False
      Caption = #24037#31243#25910#36153#35843#25972
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #40657#20307
      Font.Style = []
      ParentFont = False
    end
    object Bevel11: TBevel
      Left = 1
      Top = 31
      Width = 654
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Bevel12: TBevel
      Left = 1
      Top = 167
      Width = 654
      Height = 9
      Shape = bsTopLine
      Style = bsRaised
    end
    object Label19: TLabel
      Left = 419
      Top = 180
      Width = 110
      Height = 13
      AutoSize = False
      Caption = #24037#31243#25910#36153#24635#21512#35745#65306
    end
    object Label20: TLabel
      Left = 627
      Top = 180
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object Bevel13: TBevel
      Left = 345
      Top = 31
      Width = 9
      Height = 173
      Shape = bsLeftLine
      Style = bsRaised
    end
    object Label22: TLabel
      Left = 424
      Top = 148
      Width = 89
      Height = 13
      AutoSize = False
      Caption = #32508#21512#35843#25972#31995#25968#65306
    end
    object Label24: TLabel
      Left = 262
      Top = 85
      Width = 59
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
    object Label25: TLabel
      Left = 262
      Top = 53
      Width = 59
      Height = 13
      AutoSize = False
      Caption = '('#22686#21152'10%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label26: TLabel
      Left = 262
      Top = 128
      Width = 59
      Height = 13
      AutoSize = False
      Caption = '('#22686#21152'10%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 262
      Top = 149
      Width = 57
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
    object Label28: TLabel
      Left = 384
      Top = 63
      Width = 65
      Height = 13
      AutoSize = False
      Caption = #35843#25972#31995#25968
    end
    object Label36: TLabel
      Left = 571
      Top = 121
      Width = 20
      Height = 13
      AutoSize = False
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label21: TLabel
      Left = 447
      Top = 121
      Width = 80
      Height = 12
      AutoSize = False
      Caption = '('#22686#21152'20~40%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label29: TLabel
      Left = 384
      Top = 121
      Width = 65
      Height = 13
      AutoSize = False
      Caption = #22686#21152#25910#36153
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label30: TLabel
      Left = 447
      Top = 63
      Width = 73
      Height = 13
      AutoSize = False
      Caption = '(1.10'#65374'1.25)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBackground
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label31: TLabel
      Left = 299
      Top = 180
      Width = 17
      Height = 13
      AutoSize = False
      Caption = #20803
    end
    object StaticText11: TStaticText
      Left = 528
      Top = 178
      Width = 92
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
    object CheckBox2: TCheckBox
      Left = 16
      Top = 83
      Width = 217
      Height = 17
      Caption = #22312#27668#28201'>=35'#8451#25110'<=-10'#8451#30340#26465#20214#19979#20316#19994
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 104
      Width = 225
      Height = 17
      Caption = #22312#28023#25300#24179#22343#39640#24230#36229#36807'2000m'#30340#22320#21306#20316#19994
      TabOrder = 4
      OnClick = CheckBox3Click
    end
    object RadioButton1: TRadioButton
      Left = 34
      Top = 126
      Width = 169
      Height = 17
      Caption = #28023#25300#24179#22343#39640#24230'2000'#65374'3000m'
      Checked = True
      Enabled = False
      TabOrder = 5
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 34
      Top = 147
      Width = 161
      Height = 17
      Caption = #28023#25300#24179#22343#39640#24230'>3000m'
      Enabled = False
      TabOrder = 6
      OnClick = RadioButton2Click
    end
    object StaticText12: TStaticText
      Left = 528
      Top = 146
      Width = 91
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
    object CheckBox4: TCheckBox
      Left = 360
      Top = 42
      Width = 289
      Height = 17
      Caption = #31526#21512#23721#22303#24037#31243#21208#23519#36136#37327#21644#28145#24230#35201#27714#30340#23721#22303#24037#31243#21208#23519
      TabOrder = 2
      OnClick = CheckBox4Click
    end
    object Edit1: TEdit
      Tag = 2
      Left = 528
      Top = 60
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
      TabOrder = 3
      Text = '   1.10'
      OnEnter = Edit1Enter
      OnExit = Edit1Exit
      OnKeyPress = Edit1KeyPress
      OnMouseDown = Edit1MouseDown
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 39
      Width = 249
      Height = 41
      Caption = #21313#31867#21644#21313#31867#20197#19978#24037#36164#22320#21306#30340#21208#23519#21333#20301#25215#25285#21208#23519#20219#21153';'#25110#20302#20110#21313#31867#24037#36164#22320#21306#30340#21208#23519#21333#20301#25215#25285#21313#31867#21644#21313#31867#20197#19978#24037#36164#22320#21306#30340#21208#23519#20219#21153
      TabOrder = 8
      WordWrap = True
      OnClick = CheckBox1Click
    end
    object ChBPrj5: TCheckBox
      Left = 362
      Top = 89
      Width = 279
      Height = 28
      Caption = #26681#25454#27743#33487#30465#24314#22996#12289#30465#29289#20215#23616','#33487#24314#31185'(1993)'#31532'80'#21495','#33487#28041#23383'(1993)'#31532'010'#21495#25991#20214
      TabOrder = 9
      WordWrap = True
      OnClick = ChBPrj5Click
    end
    object EPrj2: TEdit
      Left = 528
      Top = 118
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
      Text = '      20'
      OnEnter = Edit1Enter
      OnExit = EPrj2Exit
      OnKeyPress = Edit1KeyPress
      OnMouseDown = Edit1MouseDown
    end
    object BBOther: TBitBtn
      Left = 35
      Top = 174
      Width = 99
      Height = 25
      Caption = #20854#23427#36153#29992
      TabOrder = 11
      OnClick = BBOtherClick
    end
    object STOther: TStaticText
      Left = 206
      Top = 178
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
      TabOrder = 12
    end
  end
  object BitBtn3: TBitBtn
    Left = 552
    Top = 579
    Width = 113
    Height = 25
    Cancel = True
    Caption = #20851#38381
    TabOrder = 5
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 552
    Top = 543
    Width = 113
    Height = 25
    Caption = #35745#31639#35828#26126
    TabOrder = 6
    OnClick = BitBtn4Click
  end
  object GroupBox4: TGroupBox
    Left = 16
    Top = 537
    Width = 513
    Height = 84
    Caption = #20915#31639#25253#34920
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object BitBtn5: TBitBtn
      Left = 16
      Top = 49
      Width = 145
      Height = 25
      Caption = #29983#25104#20915#31639#25253#34920
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn5Click
    end
    object STReport: TStaticText
      Left = 163
      Top = 52
      Width = 259
      Height = 19
      AutoSize = False
      BevelKind = bkFlat
      BevelOuter = bvNone
      BorderStyle = sbsSingle
      Caption = #20915#31639#25253#34920#29983#25104#20934#22791#20013'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object STDir: TStaticText
      Left = 16
      Top = 23
      Width = 145
      Height = 19
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      Caption = #20915#31639#25253#34920#20445#23384'('#36335#24452')'#25991#20214#21517':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object BitBtn6: TBitBtn
      Left = 425
      Top = 20
      Width = 75
      Height = 25
      Caption = #27983#35272'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn6Click
    end
    object ERP1: TEdit
      Left = 163
      Top = 22
      Width = 259
      Height = 21
      AutoSize = False
      BevelInner = bvNone
      BevelKind = bkFlat
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
      TabOrder = 4
    end
    object BitBtn7: TBitBtn
      Left = 425
      Top = 50
      Width = 75
      Height = 25
      Caption = #25171#24320#25253#34920'...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BitBtn7Click
    end
  end
  object SEFDlg: TSaveDialog
    Left = 568
    Top = 496
  end
  object AQRP1: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 536
    Top = 576
  end
  object AQRP2: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 568
    Top = 576
  end
  object AQRP3: TADOQuery
    Connection = MainDataModule.ADOConnection1
    Parameters = <>
    Left = 600
    Top = 576
  end
end
