object SectionDrillForm: TSectionDrillForm
  Left = 206
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #21078#38754#38075#23380#21015#34920
  ClientHeight = 432
  ClientWidth = 673
  Color = clBtnFace
  Constraints.MinHeight = 50
  Constraints.MinWidth = 130
  Font.Charset = GB2312_CHARSET
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
  object Panel1: TPanel
    Left = 21
    Top = 9
    Width = 114
    Height = 393
    Color = 15198183
    TabOrder = 0
    object Label2: TLabel
      Left = 25
      Top = 18
      Width = 48
      Height = 12
      Caption = #21078#38754#21015#34920
    end
    object sgSection: TStringGrid
      Left = 1
      Top = 42
      Width = 104
      Height = 345
      ColCount = 2
      Ctl3D = False
      FixedColor = 15198183
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ParentCtl3D = False
      TabOrder = 0
      OnSelectCell = sgSectionSelectCell
      RowHeights = (
        24
        24)
    end
  end
  object Panel2: TPanel
    Left = 138
    Top = 9
    Width = 530
    Height = 393
    Color = 15198183
    TabOrder = 1
    object lblAllDrills: TLabel
      Left = 64
      Top = 17
      Width = 96
      Height = 12
      Caption = #24037#31243#25152#26377#38075#23380#21015#34920
    end
    object Label1: TLabel
      Left = 344
      Top = 17
      Width = 96
      Height = 12
      Caption = #24403#21069#21078#38754#38075#23380#21015#34920
    end
    object sgDrills: TStringGrid
      Left = 17
      Top = 41
      Width = 160
      Height = 345
      ColCount = 2
      Ctl3D = False
      FixedColor = 15198183
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
      ParentCtl3D = False
      TabOrder = 0
      ColWidths = (
        64
        83)
    end
    object sgSectionDrills: TStringGrid
      Left = 264
      Top = 41
      Width = 261
      Height = 345
      ColCount = 3
      Ctl3D = False
      FixedColor = 15198183
      FixedCols = 2
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goEditing]
      ParentCtl3D = False
      TabOrder = 1
      OnDrawCell = sgSectionDrillsDrawCell
      OnExit = sgSectionDrillsExit
    end
    object btnAdd: TButton
      Left = 181
      Top = 113
      Width = 75
      Height = 25
      Caption = #22686#21152' >'
      TabOrder = 2
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 181
      Top = 178
      Width = 75
      Height = 25
      Caption = #20462#25913#23380#21495
      TabOrder = 3
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 181
      Top = 213
      Width = 75
      Height = 25
      Caption = '< '#21024#38500
      TabOrder = 4
      OnClick = btnDeleteClick
    end
    object btnDeleteAll: TButton
      Left = 181
      Top = 249
      Width = 75
      Height = 25
      Caption = '<< '#21024#38500#25152#26377
      TabOrder = 5
      OnClick = btnDeleteAllClick
    end
    object btn_cancel: TBitBtn
      Left = 181
      Top = 286
      Width = 75
      Height = 25
      Hint = #36820#22238
      Cancel = True
      Caption = #36820#22238
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
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
    object btnShouGong: TButton
      Left = 181
      Top = 80
      Width = 75
      Height = 25
      Caption = #25163#24037#36755#20837
      TabOrder = 7
      OnClick = btnShouGongClick
    end
    object btnInsert: TButton
      Left = 181
      Top = 145
      Width = 75
      Height = 25
      Caption = #25554#20837' >'
      TabOrder = 8
      OnClick = btnInsertClick
    end
  end
end
