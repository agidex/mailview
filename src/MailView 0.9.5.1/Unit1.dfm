object Form1: TForm1
  Left = 283
  Top = 253
  Width = 590
  Height = 417
  Caption = 'Mail View v. 0.9.5.1'
  Color = clBtnFace
  Constraints.MinHeight = 417
  Constraints.MinWidth = 590
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  ScreenSnap = True
  SnapBuffer = 15
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    574
    359)
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 340
    Width = 574
    Height = 19
    Panels = <
      item
        Width = 220
      end
      item
        Width = 190
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 100
      end>
  end
  object Panel4: TPanel
    Left = 0
    Top = 283
    Width = 573
    Height = 57
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvLowered
    Caption = 'Panel4'
    TabOrder = 1
    DesignSize = (
      573
      57)
    object Label4: TLabel
      Left = 16
      Top = 37
      Width = 63
      Height = 13
      Caption = 'Get progress:'
    end
    object Label3: TLabel
      Left = 16
      Top = 11
      Width = 69
      Height = 13
      Caption = 'View progress:'
    end
    object Panel1: TPanel
      Left = 144
      Top = 8
      Width = 423
      Height = 41
      Anchors = [akLeft, akRight, akBottom]
      BevelOuter = bvNone
      TabOrder = 0
      object Gauge1: TGauge
        Left = 0
        Top = 21
        Width = 423
        Height = 20
        Align = alBottom
        Progress = 0
      end
      object Gauge2: TGauge
        Left = 0
        Top = 0
        Width = 423
        Height = 20
        Align = alTop
        Progress = 0
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 0
    Width = 129
    Height = 281
    Cursor = crArrow
    Anchors = [akLeft, akTop, akBottom]
    Caption = ' Actions '
    TabOrder = 2
    DesignSize = (
      129
      281)
    object Button1: TButton
      Left = 8
      Top = 24
      Width = 113
      Height = 25
      Cursor = crArrow
      Caption = 'Get Links'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 56
      Width = 113
      Height = 25
      Cursor = crArrow
      Caption = 'View Link'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 88
      Width = 113
      Height = 25
      Cursor = crArrow
      Caption = 'Clear List'
      TabOrder = 2
      OnClick = Button3Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 184
      Width = 113
      Height = 89
      Cursor = crArrow
      Anchors = [akLeft, akRight, akBottom]
      Caption = ' Links statistic '
      TabOrder = 3
      object Label1: TLabel
        Left = 16
        Top = 28
        Width = 47
        Height = 13
        Caption = 'Viewed: 0'
      end
      object Label2: TLabel
        Left = 16
        Top = 60
        Width = 36
        Height = 13
        Caption = 'Total: 0'
      end
    end
    object Button6: TButton
      Left = 8
      Top = 120
      Width = 113
      Height = 25
      Cursor = crArrow
      Caption = 'Read Links'
      TabOrder = 4
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 8
      Top = 152
      Width = 113
      Height = 25
      Cursor = crArrow
      Caption = 'Write Links'
      TabOrder = 5
      OnClick = Button7Click
    end
  end
  object TabControl1: TTabControl
    Left = 144
    Top = 0
    Width = 426
    Height = 280
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    Tabs.Strings = (
      #1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1089#1099#1083#1082#1080
      #1057#1087#1080#1089#1086#1082' '#1089#1089#1099#1083#1086#1082
      #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099)
    TabIndex = 0
    DesignSize = (
      426
      280)
    object GroupBox3: TGroupBox
      Left = 8
      Top = 24
      Width = 410
      Height = 248
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' '#1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1089#1099#1083#1082#1080' '
      TabOrder = 0
      object Browser: TChromium
        Left = 2
        Top = 15
        Width = 406
        Height = 231
        Align = alClient
        TabOrder = 0
        OnBeforeBrowse = BrowserBeforeBrowse
        OnLoadEnd = BrowserLoadEnd
        Options = [coJavascriptDisabled, coJavascriptOpenWindowsDisallowed, coJavascriptCloseWindowsDisallowed, coJavaDisabled, coWebSecurityDisabled, coPageCacheDisabled, coLocalStorageDisabled]
      end
    end
    object Panel2: TPanel
      Left = 8
      Top = 24
      Width = 410
      Height = 248
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Caption = 'Panel2'
      TabOrder = 1
      DesignSize = (
        410
        248)
      object Memo1: TMemo
        Left = 8
        Top = 8
        Width = 394
        Height = 200
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          'Memo1')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button4: TButton
        Left = 8
        Top = 215
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100
        TabOrder = 1
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 96
        Top = 215
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 2
        OnClick = Button5Click
      end
    end
    object StringGrid1: TStringGrid
      Left = 8
      Top = 24
      Width = 410
      Height = 248
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 4
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 25
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 2
      ColWidths = (
        46
        234
        62
        68)
    end
  end
  object buffer: TMemo
    Left = 144
    Top = 280
    Width = 41
    Height = 1
    Enabled = False
    Lines.Strings = (
      'b'
      'u'
      'f'
      'f'
      'e'
      'r')
    TabOrder = 4
    Visible = False
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 296
    Top = 112
  end
  object Timer2: TTimer
    Interval = 10
    OnTimer = Timer2Timer
    Left = 336
    Top = 112
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 296
    Top = 152
  end
  object MainMenu1: TMainMenu
    Left = 256
    Top = 112
    object MFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MReadLinks: TMenuItem
        Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1089#1089#1099#1083#1082#1080' '#1080#1079' '#1092#1072#1081#1083#1072
        OnClick = MReadLinksClick
      end
      object MWriteLinks: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1089#1089#1099#1083#1082#1080' '#1074' '#1092#1072#1081#1083
        OnClick = MWriteLinksClick
      end
      object MClear: TMenuItem
        Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
        OnClick = MClearClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = MExitClick
      end
    end
    object MSettings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object MSettingsEmail: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' email'
        OnClick = MSettingsEmailClick
      end
      object MSettingsSponsors: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1087#1086#1085#1089#1086#1088#1086#1074
        OnClick = MSettingsSponsorsClick
      end
      object MSettingsProgram: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
        OnClick = MSettingsProgramClick
      end
    end
    object MHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object MIndex: TMenuItem
        Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077
        OnClick = MIndexClick
      end
      object MStat: TMenuItem
        Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        OnClick = MStatClick
      end
      object MAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        OnClick = MAboutClick
      end
    end
  end
  object Timer4: TTimer
    Enabled = False
    OnTimer = Timer4Timer
    Left = 336
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    Left = 256
    Top = 152
  end
  object IdPOP31: TIdPOP3
    MaxLineAction = maException
    ReadTimeout = 0
    Left = 216
    Top = 112
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    NoDecode = True
    Recipients = <>
    ReplyTo = <>
    Left = 216
    Top = 152
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 216
    Top = 72
  end
  object TimeOutTimer: TTimer
    Enabled = False
    OnTimer = TimeOutTimerTimer
    Left = 392
    Top = 152
  end
end
