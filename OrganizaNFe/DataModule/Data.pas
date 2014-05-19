unit Data;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, Provider, DB, DBClient,
  ZSqlUpdate, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3, IdMessage;

type
  Tdm = class(TDataModule)
    dbConnection: TZConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses Splash, FuncoesBD;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
procedure Tdm.DataModuleCreate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
begin

   // Conexão Inicial com SQLite
   frmSplash.Mensagem('Realizando conexão com o banco de dados...');
   dbConnection.Disconnect;
   dbConnection.Database := GetCurrentDir + '\organizanfe.db3';
   dbConnection.Connect;

   //Cria o banco do SQLite se não existir
   FuncoesBD.CriaBanco(dbConnection);

   // Libera o splash da memória
   frmSplash.Free;
end;

end.
