inherited dlgContaEmail: TdlgContaEmail
  Caption = 'Cadastrar Conta de Email'
  ClientHeight = 371
  ClientWidth = 625
  OnShow = FormShow
  ExplicitWidth = 631
  ExplicitHeight = 399
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel [0]
    Left = 19
    Top = 18
    Width = 35
    Height = 13
    Caption = 'Email:'
    FocusControl = dbEditEmail
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel [1]
    Left = 19
    Top = 125
    Width = 71
    Height = 13
    Caption = 'Porta POP3:'
    FocusControl = dbEditPorta
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel [2]
    Left = 19
    Top = 72
    Width = 74
    Height = 13
    Caption = 'Conta POP3:'
    FocusControl = dbEditConta
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel [3]
    Left = 19
    Top = 184
    Width = 41
    Height = 13
    Caption = 'Senha:'
    FocusControl = dbEditSenha
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dbEditEmail: TDBEdit [4]
    Left = 18
    Top = 37
    Width = 594
    Height = 21
    DataField = 'Email'
    DataSource = frmEmpresas.dsConta
    TabOrder = 0
  end
  object dbEditPorta: TDBEdit [5]
    Left = 19
    Top = 152
    Width = 118
    Height = 21
    DataField = 'PortaPOP3'
    DataSource = frmEmpresas.dsConta
    TabOrder = 2
  end
  object dbEditConta: TDBEdit [6]
    Left = 19
    Top = 91
    Width = 593
    Height = 21
    DataField = 'ContaPOP3'
    DataSource = frmEmpresas.dsConta
    TabOrder = 1
  end
  object dbEditSenha: TDBEdit [7]
    Left = 19
    Top = 211
    Width = 264
    Height = 21
    DataField = 'Senha'
    DataSource = frmEmpresas.dsConta
    PasswordChar = '*'
    TabOrder = 3
  end
  object pRodape: TPanel [8]
    Left = 0
    Top = 314
    Width = 625
    Height = 57
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 5
    DesignSize = (
      625
      57)
    object Panel2: TPanel
      Left = 221
      Top = 14
      Width = 182
      Height = 30
      Anchors = []
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        182
        30)
      object btnGravarConta: TBitBtn
        Left = 0
        Top = 0
        Width = 88
        Height = 30
        Caption = '&Gravar'
        DoubleBuffered = True
        Glyph.Data = {
          26050000424D26050000000000003604000028000000100000000F0000000100
          080000000000F000000000000000000000000001000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
          A400000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070700000000
          0000000000000000000707000303000000000000070700030007070003030000
          0000000007070003000707000303000000000000070700030007070003030000
          0000000000000003000707000303030303030303030303030007070003030000
          0000000000000303000707000300070707070707070700030007070003000707
          0707070707070003000707000300070707070707070700030007070003000707
          0707070707070003000707000300070707070707070700000007070003000707
          0707070707070007000707000000000000000000000000000007070707070707
          07070707070707070707}
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnGravarContaClick
      end
      object btnCancelar: TBitBtn
        Left = 94
        Top = 0
        Width = 88
        Height = 30
        Anchors = [akLeft, akTop, akBottom]
        Cancel = True
        Caption = '&Cancelar'
        DoubleBuffered = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888808888888888088800088888888888880000888888
          8088888000888888088888880008888008888888800088008888888888000008
          8888888888800088888888888800000888888888800088008888888000088880
          0888880000888888008888000888888888088888888888888888}
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = btnCancelarClick
      end
    end
  end
  object panelCheckbox: TPanel [9]
    Left = 0
    Top = 256
    Width = 625
    Height = 66
    TabOrder = 4
    object dbCheckConexaoSslPop3: TDBCheckBox
      Left = 19
      Top = 12
      Width = 134
      Height = 17
      Caption = '&Conex'#227'o Ssl Pop3'
      DataField = 'ConexaoSslPop3'
      DataSource = frmEmpresas.dsConta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object dbCheckExcluirAposRecebimento: TDBCheckBox
      Left = 19
      Top = 35
      Width = 166
      Height = 17
      Caption = 'Exclui Ap'#243's Recebimento'
      DataField = 'ExcluiAposRecebimento'
      DataSource = frmEmpresas.dsConta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  inherited mbKeyEvent1: TmbKeyEvent
    Left = 416
    Top = 144
  end
  object dsBuscaEmail: TDataSource
    DataSet = qrBuscaEmail
    Left = 480
    Top = 144
  end
  object qrBuscaEmail: TZQuery
    Connection = dm.dbConnection
    SQL.Strings = (
      'select Email from ContaEmail where Email = :email'
      'and Fk_Empresa = :emp'
      '')
    Params = <
      item
        DataType = ftUnknown
        Name = 'email'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'emp'
        ParamType = ptUnknown
      end>
    Left = 536
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'email'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'emp'
        ParamType = ptUnknown
      end>
  end
end
