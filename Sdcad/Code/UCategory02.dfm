object FrmCategory02: TFrmCategory02
  Left = 311
  Top = 191
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #21208#23519#19982#21407#20301#27979#35797#22797#26434#31243#24230#34920
  ClientHeight = 416
  ClientWidth = 603
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
    Left = 440
    Top = 358
    Width = 97
    Height = 25
    Caption = #20851#38381
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 603
    Height = 345
    ActivePage = TabSheet2
    Align = alTop
    TabOrder = 1
    object TabSheet2: TTabSheet
      Caption = #23721#22303#24037#31243#21208#23519#19982#21407#20301#27979#35797#22797#26434#31243#24230#34920
      ImageIndex = 1
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 595
        Height = 299
        Align = alTop
        Enabled = False
        TabOrder = 0
        object Bevel5: TBevel
          Left = 2
          Top = 40
          Width = 586
          Height = 9
          Shape = bsTopLine
        end
        object Bevel8: TBevel
          Left = 68
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Label6: TLabel
          Left = 7
          Top = 19
          Width = 60
          Height = 12
          Caption = #23721#22303#31867#21035'  '
        end
        object Label7: TLabel
          Left = 101
          Top = 18
          Width = 24
          Height = 12
          Caption = #8544'  '
        end
        object Label8: TLabel
          Left = 190
          Top = 18
          Width = 24
          Height = 12
          Caption = #8545'  '
        end
        object Label9: TLabel
          Left = 280
          Top = 18
          Width = 24
          Height = 12
          Caption = #8546'  '
        end
        object Label10: TLabel
          Left = 7
          Top = 124
          Width = 60
          Height = 12
          Caption = #26494#25955#22320#23618'  '
        end
        object Bevel9: TBevel
          Left = 2
          Top = 258
          Width = 586
          Height = 9
          Shape = bsTopLine
        end
        object Label11: TLabel
          Left = 369
          Top = 18
          Width = 12
          Height = 12
          Caption = #8547
        end
        object Label12: TLabel
          Left = 459
          Top = 18
          Width = 18
          Height = 12
          Caption = #8548' '
        end
        object Label13: TLabel
          Left = 548
          Top = 18
          Width = 12
          Height = 12
          Caption = #8549
        end
        object Bevel16: TBevel
          Left = 242
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Bevel17: TBevel
          Left = 152
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Bevel18: TBevel
          Left = 333
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Bevel19: TBevel
          Left = 423
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Bevel20: TBevel
          Left = 514
          Top = 6
          Width = 9
          Height = 291
          Shape = bsLeftLine
        end
        object Label14: TLabel
          Left = 7
          Top = 276
          Width = 60
          Height = 12
          Caption = #23721#30707#22320#23618'  '
        end
        object Memo4: TMemo
          Left = 80
          Top = 86
          Width = 65
          Height = 95
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #27969#22609#12289#36719#22609
            #12289#21487#22609#31896#24615
            #22303#65292#31245#23494#12289
            #20013#23494#31881#22303#65292
            #21547#30828#26434#36136'<='
            '10%'#30340#22635#22303)
          ParentCtl3D = False
          TabOrder = 0
        end
        object Memo5: TMemo
          Left = 160
          Top = 86
          Width = 73
          Height = 138
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #30828#22609#12289#22362#30828#31896
            #24615#22303#12289#23494#23454#31881
            #22303#65292#21547#30828#26434#36136
            '<=25%'#22635#22303#65292
            #28287#38519#24615#22303#65292#32418
            #31896#22303#65292#33192#32960#22303
            #65292#30416#28173#22303#65292#27544
            #31215#22303#65292#27745#26579#22303)
          ParentCtl3D = False
          TabOrder = 1
        end
        object Memo6: TMemo
          Left = 178
          Top = 273
          Width = 57
          Height = 19
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #26497#36719#23721)
          ParentCtl3D = False
          TabOrder = 2
        end
        object Memo7: TMemo
          Left = 248
          Top = 86
          Width = 73
          Height = 70
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #30722#22303#65292#30782#30707#65292
            #28151#21512#22303#65292#22810#24180
            #20923#22303#65292#21547#30828#26434
            #36136'>25%'#22635#22303)
          ParentCtl3D = False
          TabOrder = 3
        end
        object Memo8: TMemo
          Left = 344
          Top = 86
          Width = 73
          Height = 76
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #31890#24452'<=50mm'
            #12289#21547#37327'>50%'
            #30340#21365#65288#30862#65289#30707
            #23618)
          ParentCtl3D = False
          TabOrder = 4
        end
        object Memo9: TMemo
          Left = 432
          Top = 86
          Width = 73
          Height = 90
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #31890#24452'<=100mm'
            #12289#21547#37327'>50%'
            #30340#21365#65288#30862#65289#30707
            #23618#65292#28151#20957#22303#26500
            #20214#12289#38754#23618)
          ParentCtl3D = False
          TabOrder = 5
        end
        object Memo10: TMemo
          Left = 520
          Top = 86
          Width = 65
          Height = 96
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #31890#24452'<=100m'
            'm'#12289#21547#37327'>50'
            '%'#30340#21365#65288#30862
            #65289#30707#23618#65292#28418
            #65288#22359#65289#30707#23618
            '')
          ParentCtl3D = False
          TabOrder = 6
        end
        object Memo11: TMemo
          Left = 280
          Top = 272
          Width = 41
          Height = 21
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #36719#23721)
          ParentCtl3D = False
          TabOrder = 7
        end
        object Memo18: TMemo
          Left = 360
          Top = 273
          Width = 49
          Height = 19
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #36739#36719#23721)
          ParentCtl3D = False
          TabOrder = 8
        end
        object Memo19: TMemo
          Left = 456
          Top = 272
          Width = 49
          Height = 21
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #36739#30828#23721)
          ParentCtl3D = False
          TabOrder = 9
        end
        object Memo20: TMemo
          Left = 536
          Top = 272
          Width = 41
          Height = 21
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = False
          Lines.Strings = (
            #22362#30828#23721)
          ParentCtl3D = False
          TabOrder = 10
        end
      end
    end
  end
end
