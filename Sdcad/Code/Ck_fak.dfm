object Ck_fakForm: TCk_fakForm
  Left = 225
  Top = 143
  BorderStyle = bsDialog
  Caption = #25215#36733#21147#29305#24449#20540#35745#31639
  ClientHeight = 210
  ClientWidth = 302
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 18
    Top = 24
    Width = 90
    Height = 12
    Caption = #22522#30784#24213#38754#23485#24230'(m)'
  end
  object Label2: TLabel
    Left = 18
    Top = 54
    Width = 90
    Height = 12
    Caption = #22522#30784#22475#32622#28145#24230'(m)'
  end
  object Label3: TLabel
    Left = 18
    Top = 84
    Width = 60
    Height = 12
    Caption = #22303'('#28014')'#37325#24230
  end
  object Label4: TLabel
    Left = 18
    Top = 114
    Width = 108
    Height = 12
    Caption = #22303#21152#26435#24179#22343'('#28014')'#37325#24230
  end
  object Label5: TLabel
    Left = 18
    Top = 144
    Width = 60
    Height = 12
    Caption = #35745#31639#32467#26524'fa'
  end
  object edtJcmzsd: TEdit
    Tag = 2
    Left = 157
    Top = 48
    Width = 121
    Height = 19
    ImeName = #26085#26412#35486' (MS-IME2000)'
    MaxLength = 10
    TabOrder = 0
    OnChange = cbJcdmkdClick
    OnKeyDown = edtJcmzsdKeyDown
    OnKeyPress = edtJcmzsdKeyPress
  end
  object edtTzd: TEdit
    Tag = 2
    Left = 157
    Top = 80
    Width = 121
    Height = 19
    ImeName = #26085#26412#35486' (MS-IME2000)'
    MaxLength = 10
    TabOrder = 1
    OnChange = cbJcdmkdClick
    OnKeyDown = edtJcmzsdKeyDown
    OnKeyPress = edtJcmzsdKeyPress
  end
  object cbJcdmkd: TComboBox
    Left = 157
    Top = 16
    Width = 121
    Height = 20
    Style = csDropDownList
    ImeName = #26085#26412#35486' (MS-IME2000)'
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 2
    Text = '3'
    OnClick = cbJcdmkdClick
    OnKeyDown = cbJcdmkdKeyDown
    Items.Strings = (
      '3'
      '6')
  end
  object edtTjqpjzd: TEdit
    Tag = 2
    Left = 157
    Top = 112
    Width = 121
    Height = 19
    ImeName = #26085#26412#35486' (MS-IME2000)'
    MaxLength = 10
    TabOrder = 3
    OnChange = cbJcdmkdClick
    OnKeyDown = edtJcmzsdKeyDown
    OnKeyPress = edtJcmzsdKeyPress
  end
  object edtFa: TEdit
    Left = 157
    Top = 144
    Width = 121
    Height = 19
    ImeName = #26085#26412#35486' (MS-IME2000)'
    MaxLength = 10
    TabOrder = 4
    OnKeyDown = edtJcmzsdKeyDown
    OnKeyPress = edtJcmzsdKeyPress
  end
  object btnOk: TButton
    Left = 155
    Top = 175
    Width = 80
    Height = 27
    Caption = #30830#23450
    TabOrder = 5
    ModalResult = 1
  end
  object btnCancel: TButton
    Left = 67
    Top = 175
    Width = 80
    Height = 27
    Caption = #21462#28040
    TabOrder = 6
    ModalResult = 2
  end
end
