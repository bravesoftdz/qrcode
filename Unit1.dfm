object Form1: TForm1
  Left = 192
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'QR Code dan Bar code Generator'
  ClientHeight = 466
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblLokasi: TLabel
    Left = 24
    Top = 40
    Width = 70
    Height = 13
    Caption = 'Lokasi teks file'
  end
  object lblPilihPrinter: TLabel
    Left = 32
    Top = 256
    Width = 51
    Height = 13
    Caption = 'Pilih printer'
  end
  object btnGenerate: TButton
    Left = 208
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object txtLokasi: TEdit
    Left = 28
    Top = 56
    Width = 353
    Height = 21
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object Browse: TButton
    Left = 388
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 2
    OnClick = BrowseClick
  end
  object grpCode: TRadioGroup
    Left = 26
    Top = 304
    Width = 441
    Height = 41
    Caption = 'Code'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Barcode'
      'QR Code')
    TabOrder = 3
  end
  object grpPaper: TRadioGroup
    Left = 25
    Top = 360
    Width = 441
    Height = 41
    Caption = 'Ukuran Kertas'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'A4'
      'A3')
    TabOrder = 4
  end
  object cmbPrinters: TComboBox
    Left = 30
    Top = 272
    Width = 433
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 5
    Text = 'Pilih printer'
    Items.Strings = (
      'Pilih printer')
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 40
  end
end
