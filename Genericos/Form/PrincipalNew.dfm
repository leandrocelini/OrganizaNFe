object frmPrincipalNew: TfrmPrincipalNew
  Left = 0
  Top = 0
  HelpType = htKeyword
  Caption = 'Sistema de Gerenciamento de Vendas'
  ClientHeight = 366
  ClientWidth = 644
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 652
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ImagemFundo: TImage
    Left = 0
    Top = 33
    Width = 644
    Height = 314
    Align = alClient
    Stretch = True
    Visible = False
    ExplicitTop = 39
    ExplicitWidth = 636
    ExplicitHeight = 310
  end
  object BarraStatus: TStatusBar
    Left = 0
    Top = 347
    Width = 644
    Height = 19
    Panels = <>
  end
  object Menu: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 644
    Height = 33
    Caption = 'Menu'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HorzMargin = 0
    Spacing = 0
    VertMargin = 0
    OnClick = MenuClick
  end
end
