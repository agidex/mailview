object Form4: TForm4
  Left = 578
  Top = 262
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 303
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    313
    303)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 56
    Width = 30
    Height = 13
    Caption = #1084#1080#1085#1091#1090
  end
  object Label2: TLabel
    Left = 24
    Top = 200
    Width = 31
    Height = 13
    Caption = #1071#1079#1099#1082':'
  end
  object Label3: TLabel
    Left = 24
    Top = 144
    Width = 81
    Height = 13
    Caption = 'Time-out interval:'
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 24
    Width = 265
    Height = 17
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1089#1073#1086#1088' '#1087#1080#1089#1077#1084' '#1095#1077#1088#1077#1079':'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 24
    Top = 88
    Width = 265
    Height = 17
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1089#1089#1099#1083#1086#1082
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 40
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '15'
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 32
    Top = 259
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 200
    Top = 259
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = Button2Click
  end
  object CheckBox3: TCheckBox
    Left = 24
    Top = 112
    Width = 265
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1089#1099#1083#1086#1082' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077
    TabOrder = 5
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 224
    Width = 257
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = 'ComboBox1'
  end
  object Edit2: TEdit
    Left = 24
    Top = 168
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '300'
  end
end
