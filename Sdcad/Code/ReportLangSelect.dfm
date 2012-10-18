object ReportLangSelectForm: TReportLangSelectForm
  Left = 289
  Top = 280
  BorderStyle = bsDialog
  Caption = #25253#34920#25171#21360#35821#35328#35774#32622
  ClientHeight = 163
  ClientWidth = 271
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
  object GroupBox1: TGroupBox
    Left = 16
    Top = 24
    Width = 233
    Height = 105
    TabOrder = 0
    object rb_ReportLang_cn: TRadioButton
      Left = 21
      Top = 24
      Width = 113
      Height = 17
      Caption = #20013#25991
      TabOrder = 0
      OnClick = rb_ReportLang_cnClick
    end
    object rb_ReportLang_en: TRadioButton
      Left = 21
      Top = 56
      Width = 113
      Height = 17
      Caption = #33521#25991
      TabOrder = 1
      OnClick = rb_ReportLang_enClick
    end
    object btn_cancel: TBitBtn
      Left = 79
      Top = 40
      Width = 82
      Height = 25
      Hint = #36820#22238
      Cancel = True
      Caption = #36820#22238
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
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
  end
end
