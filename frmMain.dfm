object fMain: TfMain
  Left = 0
  Top = 0
  Caption = 'Char2Pic v1.0 By www.mshams.ir'
  ClientHeight = 432
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Page: TPageControl
    Left = 0
    Top = 0
    Width = 587
    Height = 421
    ActivePage = Tab1
    Align = alClient
    TabOrder = 0
    object Tab1: TTabSheet
      Caption = 'Original picture'
      ImageIndex = 1
      object Scrl1: TScrollBox
        Left = 0
        Top = 0
        Width = 579
        Height = 393
        HorzScrollBar.Smooth = True
        VertScrollBar.Smooth = True
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object img: TImage
          Left = 3
          Top = 3
          Width = 126
          Height = 158
          OnMouseMove = imgMouseMove
        end
        object lbl1: TLabel
          Left = 6
          Top = 3
          Width = 16
          Height = 13
          Caption = '0:0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object Tab2: TTabSheet
      Caption = 'Created picture'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Scrl2: TScrollBox
        Left = 0
        Top = 0
        Width = 579
        Height = 393
        HorzScrollBar.Smooth = True
        VertScrollBar.Smooth = True
        Align = alClient
        TabOrder = 0
        object pb: TImage
          Left = 3
          Top = 3
          Width = 126
          Height = 158
          OnMouseMove = pbMouseMove
        end
        object lbl2: TLabel
          Left = 6
          Top = 3
          Width = 16
          Height = 13
          Caption = '0:0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object Progress: TProgressBar
    AlignWithMargins = True
    Left = 2
    Top = 421
    Width = 583
    Height = 10
    Margins.Left = 2
    Margins.Top = 0
    Margins.Right = 2
    Margins.Bottom = 1
    Align = alBottom
    Step = 1
    TabOrder = 1
  end
  object mnu: TMainMenu
    Left = 448
    Top = 112
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open'
        ShortCut = 16463
        OnClick = Open1Click
      end
      object SaveEvoPic1: TMenuItem
        Caption = '&Save as image'
        ShortCut = 16467
        OnClick = SaveEvoPic1Click
      end
      object Saveashtml1: TMenuItem
        Caption = 'Save as &html'
        ShortCut = 8275
        OnClick = Saveashtml1Click
      end
      object ImportEvoPic1: TMenuItem
        Caption = '&Import background'
        Enabled = False
        ShortCut = 16457
        Visible = False
        OnClick = ImportEvoPic1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ShortCut = 16472
        OnClick = Exit1Click
      end
    end
    object Run1: TMenuItem
      Caption = '&Run'
      Enabled = False
      object Start1: TMenuItem
        Caption = '&Start'
        ShortCut = 113
        OnClick = Start1Click
      end
      object ClearEvoPic1: TMenuItem
        Caption = '&Clear picture'
        ShortCut = 116
        OnClick = ClearEvoPic1Click
      end
    end
    object Setting1: TMenuItem
      Caption = '&Setting'
      object Normalpriority1: TMenuItem
        Caption = '&Normal priority'
        Checked = True
        RadioItem = True
        ShortCut = 16462
        OnClick = Normalpriority1Click
      end
      object Highpriority1: TMenuItem
        Caption = '&High priority'
        RadioItem = True
        ShortCut = 16456
        OnClick = Highpriority1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Persianalphabet1: TMenuItem
        Caption = '&Persian alphabet'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 16464
        OnClick = Persianalphabet1Click
      end
      object Englishalphabet1: TMenuItem
        Caption = '&English alphabet'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        ShortCut = 16453
        OnClick = Englishalphabet1Click
      end
      object Customalphabet1: TMenuItem
        Caption = '&Custom alphabet'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 16451
        OnClick = Customalphabet1Click
      end
      object N3: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object Customfont1: TMenuItem
        Caption = 'Custom &font'
        GroupIndex = 1
        ShortCut = 16454
        OnClick = Customfont1Click
      end
      object Custombackgroundcolor1: TMenuItem
        Caption = 'Custom &back color'
        GroupIndex = 1
        ShortCut = 16450
        OnClick = Custombackgroundcolor1Click
      end
      object N5: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object Randomchars1: TMenuItem
        AutoCheck = True
        Caption = '&Random characters'
        Checked = True
        GroupIndex = 2
        ShortCut = 16466
      end
      object RandomOrdered1: TMenuItem
        AutoCheck = True
        Caption = 'Random &managed'
        GroupIndex = 2
        ShortCut = 16461
      end
      object Grayscale1: TMenuItem
        AutoCheck = True
        Caption = '&Grayscale'
        GroupIndex = 2
        ShortCut = 16455
      end
      object N4: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object Scallingoption1: TMenuItem
        Caption = '&Scalling option'
        GroupIndex = 2
        object Image1x11: TMenuItem
          Caption = 'Scale &1x1'
          Checked = True
          GroupIndex = 2
          RadioItem = True
          ShortCut = 16433
          OnClick = Image1x11Click
        end
        object Image2x21: TMenuItem
          Caption = 'Scale &2x2'
          GroupIndex = 2
          RadioItem = True
          ShortCut = 16434
          OnClick = Image2x21Click
        end
        object Image3x31: TMenuItem
          Caption = 'Scale &3x3'
          GroupIndex = 2
          RadioItem = True
          ShortCut = 16435
          OnClick = Image3x31Click
        end
        object Customdimention1: TMenuItem
          Caption = 'Custom &dimension'
          GroupIndex = 2
          RadioItem = True
          ShortCut = 16452
          OnClick = Customdimention1Click
        end
      end
    end
    object About1: TMenuItem
      Caption = '&About'
      ShortCut = 16456
      OnClick = About1Click
    end
  end
  object SaveDlg: TSavePictureDialog
    DefaultExt = '.jpg'
    Filter = 'JPEG Image File (*.jpg)|*.jpg|Bitmaps (*.bmp)|*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing, ofForceShowHidden]
    Left = 448
    Top = 296
  end
  object OpenDlg: TOpenPictureDialog
    Options = [ofReadOnly, ofHideReadOnly, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Title = 'Open pic'
    Left = 448
    Top = 248
  end
  object FontDlg: TFontDialog
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Options = []
    Left = 448
    Top = 192
  end
  object ColorDlg: TColorDialog
    CustomColors.Strings = (
      'ColorA=FFFFFFFF'
      'ColorB=FFFFFFFF'
      'ColorC=FFFFFFFF'
      'ColorD=FFFFFFFF'
      'ColorE=FFFFFFFF'
      'ColorF=FFFFFFFF'
      'ColorG=FFFFFFFF'
      'ColorH=FFFFFFFF'
      'ColorI=FFFFFFFF'
      'ColorJ=FFFFFFFF'
      'ColorK=FFFFFFFF'
      'ColorL=FFFFFFFF'
      'ColorM=FFFFFFFF'
      'ColorN=FFFFFFFF'
      'ColorO=FFFFFFFF'
      'ColorP=FFFFFFFF')
    Options = [cdFullOpen]
    Left = 448
    Top = 352
  end
  object SavHtmDlg: TSaveDialog
    DefaultExt = '.html'
    Filter = 'HTML Webpage (*.html)|*.html'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing, ofForceShowHidden]
    Left = 368
    Top = 352
  end
end
