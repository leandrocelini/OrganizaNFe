object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 452
  Width = 652
  object dbConnection: TZConnection
    Properties.Strings = (
      'select * from Empresas')
    Port = 0
    Database = 
      'D:\Fontes\Delphi\DelphiXE\OrganizaNFe\Debug\Win32\organizanfe.db' +
      '3'
    Protocol = 'sqlite-3'
    Left = 48
    Top = 16
  end
end
