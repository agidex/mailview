object Form2: TForm2
  Left = 930
  Top = 298
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1095#1090#1099
  ClientHeight = 291
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 291
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 6
      Top = 71
      Width = 291
      Height = 170
      Caption = ' Email Info '
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 25
        Height = 13
        Caption = 'Host:'
      end
      object Label2: TLabel
        Left = 240
        Top = 24
        Width = 22
        Height = 13
        Caption = 'Port:'
      end
      object Label3: TLabel
        Left = 16
        Top = 72
        Width = 29
        Height = 13
        Caption = 'Login:'
      end
      object Label4: TLabel
        Left = 16
        Top = 120
        Width = 49
        Height = 13
        Caption = 'Password:'
      end
      object Edit1: TEdit
        Left = 16
        Top = 40
        Width = 217
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object SpinEdit1: TSpinEdit
        Left = 240
        Top = 40
        Width = 41
        Height = 22
        MaxValue = 32768
        MinValue = 0
        TabOrder = 1
        Value = 110
      end
      object Edit2: TEdit
        Left = 16
        Top = 88
        Width = 257
        Height = 21
        TabOrder = 2
        Text = 'Edit2'
      end
      object Edit3: TEdit
        Left = 16
        Top = 136
        Width = 257
        Height = 21
        PasswordChar = '#'
        TabOrder = 3
        Text = 'Edit3'
      end
    end
    object Button3: TButton
      Left = 216
      Top = 8
      Width = 81
      Height = 25
      Caption = 'Delete'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 104
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Rename'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 81
      Height = 25
      Caption = 'Add'
      TabOrder = 3
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 40
      Width = 289
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnClick = ComboBox1Click
    end
    object Button4: TButton
      Left = 24
      Top = 256
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 200
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 6
      OnClick = Button5Click
    end
    object ListBox1: TListBox
      Left = 16
      Top = 296
      Width = 273
      Height = 113
      Enabled = False
      ItemHeight = 13
      TabOrder = 7
      Visible = False
      OnClick = ListBox1Click
    end
  end
end
