object CrossBoardPrintForm: TCrossBoardPrintForm
  Left = 173
  Top = 255
  BorderStyle = bsDialog
  Caption = #21313#23383#26495#21098#20999#35797#39564#26354#32447#22270
  ClientHeight = 141
  ClientWidth = 292
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblDrl_no: TLabel
    Left = 40
    Top = 44
    Width = 57
    Height = 13
    AutoSize = False
    Caption = #38075#23380#32534#21495
    Transparent = True
  end
  object btn_Print: TBitBtn
    Left = 42
    Top = 81
    Width = 75
    Height = 25
    Caption = #29983#25104#22270#24418'...'
    TabOrder = 0
    OnClick = btn_PrintClick
  end
  object btn_cancel: TBitBtn
    Left = 173
    Top = 81
    Width = 75
    Height = 25
    Hint = #36820#22238
    Cancel = True
    Caption = #36820#22238
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btn_cancelClick
    Glyph.Data = {
      66010000424D6601000000000000760000002800000014000000140000000100
      040000000000F000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDD0000777777777777777DDDD7000077777777777777FDFD7700007777
      777777777F3F37770000444444077777FFF4444D0000DDDDD450777F3FF4DDDD
      0000DDDDD45507FFFFF4DDDD0000DDDDD45550FFFFF4DDDD0000DDD0045550FF
      FFF4DDDD0000DDD0A05550FFFFF4DDDD00000000EA0550FFFEF4DDDD00000EAE
      AEA050FFFFF4DDDD00000AEAEAEA00FEFEF4DDDD00000EAEAEA050FFFFF4DDDD
      00000000EA0550FEFEF4DDDD0000DDD0A05550EFEFE4DDDD0000DDD0045550FE
      FEF4DDDD0000DDDDD45550EFEFE4DDDD0000DDDDD44444444444DDDD0000DDDD
      DDDDDDDDDDDDDDDD0000}
  end
  object cboDrl_no: TComboBox
    Left = 120
    Top = 40
    Width = 129
    Height = 21
    Style = csDropDownList
    ImeName = #26085#26412#35486' (MS-IME2000)'
    ItemHeight = 13
    TabOrder = 2
  end
end
