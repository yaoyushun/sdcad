object ExpressForm: TExpressForm
  Left = 343
  Top = 380
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #24037#31243#25910#36153#35745#31639#20844#24335
  ClientHeight = 182
  ClientWidth = 474
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
  object BitBtn1: TBitBtn
    Left = 281
    Top = 152
    Width = 81
    Height = 25
    Cancel = True
    Caption = #20851#38381
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 18
    Top = 23
    Width = 439
    Height = 121
    Caption = #24037#31243#25910#36153#35745#31639#20844#24335
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 401
      Height = 13
      AutoSize = False
      Caption = '1'#12289#24037#31243#25910#36153#24635#21512#35745'=('#24037#31243#25910#36153'+'#25216#26415#25910#36153')'#215#32508#21512#35843#25972#31995#25968'+'#20854#23427#36153#29992
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 60
      Width = 345
      Height = 13
      AutoSize = False
      Caption = '2'#12289#24037#31243#25910#36153'='#24037#31243#22320#36136#21208#23519#36153'+'#23460#20869#35797#39564#36153
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 88
      Width = 337
      Height = 13
      AutoSize = False
      Caption = '3'#12289#25216#26415#25910#36153#35745'='#24037#31243#25910#36153#215#25216#26415#25910#36153#29575
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
end
