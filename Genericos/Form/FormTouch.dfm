object dlgFormTouch: TdlgFormTouch
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'dlgFormTouch'
  ClientHeight = 188
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MbTouchKeybDefault: TMbTouchKeyb
    AutoScale = True
    KeybMove = False
    CtrlAuto = False
    Left = 40
    Top = 24
  end
  object MbAutoScale1: TMbAutoScale
    Left = 40
    Top = 72
  end
end
