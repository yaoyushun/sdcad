object FAdjustment: TFAdjustment
  Left = 192
  Top = 228
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #21407#20301#27979#35797#38468#21152#35843#25972#31995#25968
  ClientHeight = 397
  ClientWidth = 567
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object BBA1: TBitBtn
    Left = 432
    Top = 362
    Width = 97
    Height = 25
    Caption = #20851#38381
    TabOrder = 0
    OnClick = BBA1Click
  end
  object GroupBox8: TGroupBox
    Left = 8
    Top = 42
    Width = 547
    Height = 306
    Caption = #21407#20301#27979#35797#38468#21152#35843#25972#31995#25968
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label56: TLabel
      Left = 413
      Top = 79
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
      Left = 413
      Top = 105
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
      Left = 413
      Top = 132
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
      Left = 413
      Top = 159
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
      Left = 326
      Top = 280
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
      Left = 13
      Top = 265
      Width = 516
      Height = 1
    end
    object Label3: TLabel
      Left = 413
      Top = 185
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
      Left = 413
      Top = 212
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
    object Label55: TLabel
      Left = 413
      Top = 27
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
    object Label1: TLabel
      Left = 413
      Top = 239
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
    object CBA2: TCheckBox
      Left = 22
      Top = 51
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
      OnClick = CBA2Click
    end
    object RBA1: TRadioButton
      Left = 39
      Top = 77
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
      OnClick = RBA1Click
    end
    object RBA2: TRadioButton
      Left = 39
      Top = 103
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
      OnClick = RBA2Click
    end
    object RBA5: TRadioButton
      Left = 39
      Top = 181
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
      OnClick = RBA5Click
    end
    object RBA6: TRadioButton
      Left = 39
      Top = 207
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
      OnClick = RBA6Click
    end
    object STA1: TStaticText
      Left = 444
      Top = 278
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
      TabOrder = 7
    end
    object RBA3: TRadioButton
      Left = 39
      Top = 129
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
      OnClick = RBA3Click
    end
    object RBA4: TRadioButton
      Left = 39
      Top = 155
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
      OnClick = RBA4Click
    end
    object CBA1: TCheckBox
      Left = 22
      Top = 25
      Width = 153
      Height = 17
      Caption = #32447#36335#19978#20316#19994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = CBA1Click
    end
    object CBA3: TCheckBox
      Left = 22
      Top = 233
      Width = 339
      Height = 24
      Caption = #23721#28342#12289#27934#31348#12289#27877#30707#27969#12289#28369#22369#12289#27801#28448#12289#23665#21069#27946#31215#35033#31561#22797#26434#22330#22320
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      WordWrap = True
      OnClick = CBA3Click
    end
    object EA1: TEdit
      Tag = 2
      Left = 368
      Top = 236
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
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 10
      Text = '   1.10'
      OnEnter = EA1Enter
      OnExit = EA1Exit
      OnKeyPress = EA1KeyPress
      OnMouseDown = EA1MouseDown
    end
  end
end
