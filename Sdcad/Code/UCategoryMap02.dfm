object FrmCMap02: TFrmCMap02
  Left = 311
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #24037#31243#22320#36136#27979#32472#22797#26434#31243#24230#34920
  ClientHeight = 421
  ClientWidth = 602
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
    Left = 448
    Top = 382
    Width = 97
    Height = 25
    Caption = #20851#38381
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 602
    Height = 345
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #24037#31243#22320#36136#27979#32472#22797#26434#24230#34920
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 594
        Height = 299
        Align = alTop
        Enabled = False
        TabOrder = 0
        object Bevel1: TBevel
          Left = 2
          Top = 40
          Width = 586
          Height = 9
          Shape = bsTopLine
        end
        object Bevel2: TBevel
          Left = 2
          Top = 117
          Width = 586
          Height = 9
          Shape = bsTopLine
        end
        object Bevel3: TBevel
          Left = 2
          Top = 206
          Width = 586
          Height = 9
          Shape = bsTopLine
        end
        object Bevel4: TBevel
          Left = 76
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Label1: TLabel
          Left = 25
          Top = 19
          Width = 36
          Height = 12
          Caption = #31867#21035'  '
        end
        object Label2: TLabel
          Left = 10
          Top = 73
          Width = 62
          Height = 41
          AutoSize = False
          Caption = #22320#36136#26500#36896'  '
        end
        object Label3: TLabel
          Left = 10
          Top = 161
          Width = 62
          Height = 13
          AutoSize = False
          Caption = #23721#23618#29305#24449'  '
        end
        object Label4: TLabel
          Left = 10
          Top = 246
          Width = 62
          Height = 13
          AutoSize = False
          Caption = #22320#24418#22320#35980'   '
        end
        object Label5: TLabel
          Left = 301
          Top = 19
          Width = 96
          Height = 12
          Caption = #20013'          '#31561'  '
        end
        object Bevel14: TBevel
          Left = 232
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Bevel15: TBevel
          Left = 416
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Label16: TLabel
          Left = 123
          Top = 19
          Width = 96
          Height = 12
          Caption = #31616'          '#21333'  '
        end
        object Label17: TLabel
          Left = 473
          Top = 19
          Width = 96
          Height = 12
          Caption = #22797'          '#26434'  '
        end
        object Memo1: TMemo
          Left = 96
          Top = 69
          Width = 113
          Height = 41
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #23721#23618#20135#29366#27700#24179#25110#20542#26012
            #24456#32531)
          ParentCtl3D = False
          TabOrder = 0
        end
        object Memo2: TMemo
          Left = 96
          Top = 161
          Width = 121
          Height = 30
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #31616#21333#12289#38706#22836#20986#38706#33391#22909)
          ParentCtl3D = False
          TabOrder = 1
        end
        object Memo3: TMemo
          Left = 96
          Top = 241
          Width = 121
          Height = 41
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #22320#24418#24179#22374#65292#26893#34987#19981#32946#65292
            #26131#20110#36890#34892)
          ParentCtl3D = False
          TabOrder = 2
        end
        object Memo12: TMemo
          Left = 272
          Top = 73
          Width = 121
          Height = 41
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #26377#26174#33879#30340#35126#30385#12289#26029#23618)
          ParentCtl3D = False
          TabOrder = 3
        end
        object Memo13: TMemo
          Left = 264
          Top = 155
          Width = 137
          Height = 49
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #21464#21270#19981#31283#23450#65292#38706#22836#20013#31561#65292
            #26377#36739#22797#26434#22320#36136#29616#35937
            '')
          ParentCtl3D = False
          TabOrder = 4
        end
        object Memo14: TMemo
          Left = 264
          Top = 236
          Width = 121
          Height = 49
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #22320#24418#36215#20239#36739#22823#65292#27827#27969#12289
            #28748#26408#36739#22810#65292#36890#34892#36739#22256#38590)
          ParentCtl3D = False
          TabOrder = 5
        end
        object Memo15: TMemo
          Left = 440
          Top = 73
          Width = 121
          Height = 41
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #26377#22797#26434#30340#35126#30385#12289#26029#23618)
          ParentCtl3D = False
          TabOrder = 6
        end
        object Memo16: TMemo
          Left = 440
          Top = 139
          Width = 121
          Height = 57
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #21464#21270#22797#26434#65292#31181#31867#32321#22810#65292
            #38706#22836#19981#33391#65292#26377#28369#22369#12289#23721
            #28342#31561#22797#26434#22320#36136#29616#35937)
          ParentCtl3D = False
          TabOrder = 7
        end
        object Memo17: TMemo
          Left = 440
          Top = 228
          Width = 121
          Height = 49
          BorderStyle = bsNone
          Color = 15198183
          Ctl3D = False
          Lines.Strings = (
            #23725#35895#23665#22320#65292#26519#26408#23494#38598#65292
            #27700#32593#12289#31291#30000#12289#27836#27901#65292#36890
            #34892#22256#38590)
          ParentCtl3D = False
          TabOrder = 8
        end
      end
    end
  end
end
