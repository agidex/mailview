object Form3: TForm3
  Left = 996
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1089#1087#1086#1085#1089#1086#1088#1086#1074
  ClientHeight = 376
  ClientWidth = 360
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 377
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object Button1: TButton
      Left = 272
      Top = 32
      Width = 73
      Height = 25
      Caption = 'Add'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 272
      Top = 64
      Width = 73
      Height = 25
      Caption = 'Edit'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 272
      Top = 96
      Width = 73
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = Button3Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 152
      Width = 345
      Height = 217
      Caption = ' Sponsor info '
      TabOrder = 3
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 31
        Height = 13
        Caption = 'Name:'
      end
      object Label2: TLabel
        Left = 16
        Top = 72
        Width = 29
        Height = 13
        Caption = 'Mask:'
      end
      object Label3: TLabel
        Left = 16
        Top = 120
        Width = 55
        Height = 13
        Caption = 'Link length:'
      end
      object Label4: TLabel
        Left = 16
        Top = 168
        Width = 123
        Height = 13
        Caption = 'View interval (in seconds):'
      end
      object Edit1: TEdit
        Left = 16
        Top = 40
        Width = 305
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Edit2: TEdit
        Left = 16
        Top = 88
        Width = 305
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object Edit3: TEdit
        Left = 16
        Top = 136
        Width = 57
        Height = 21
        MaxLength = 3
        TabOrder = 2
        Text = 'Edit3'
        OnKeyPress = Edit3KeyPress
      end
      object Edit4: TEdit
        Left = 16
        Top = 184
        Width = 57
        Height = 21
        MaxLength = 5
        TabOrder = 3
        Text = 'Edit4'
        OnKeyPress = Edit4KeyPress
      end
      object Button4: TButton
        Left = 224
        Top = 128
        Width = 81
        Height = 25
        Caption = 'Save'
        TabOrder = 4
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 224
        Top = 168
        Width = 81
        Height = 25
        Caption = 'Cancel'
        TabOrder = 5
        OnClick = Button5Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 8
      Width = 257
      Height = 137
      Caption = 'Sponsors list'
      TabOrder = 4
      object ListBox1: TListBox
        Left = 8
        Top = 16
        Width = 241
        Height = 113
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox1Click
      end
    end
  end
end
