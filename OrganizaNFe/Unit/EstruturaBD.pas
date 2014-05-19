////////////////////////////////////////////////////////////////////////////////
// Unit que contem a Estrutura do banco de dados OrganizaNFe
//
// Autor: Jo�o Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////
unit EstruturaBD;

interface

Uses Windows, SysUtils, Forms, Classes, Dialogs, Messages, mbSQLite;

Const sVersaoBD = '2';

Procedure Estrutura_OrganizaNFe(aTabela:TTabelasSQLite);

implementation

////////////////////////////////////////////////////////////////////////////////
//Procedimento utilizado para criar a estrutura para o banco OrganizaNFe
//Vers�o do Banco: SQLite 3
//
//Anota��es:
// � garantido o funcionamento desta rotina coma vers�o informada do banco
// caso haja uma vers�o diferente devem ser realizados testes.
//
//Autor: Jo�o Paulo Francisco Bellucci
////////////////////////////////////////////////////////////////////////////////
Procedure Estrutura_OrganizaNFe(aTabela:TTabelasSQLite);
////////////////////////////////////////////////////////////////////////////////


procedure Table_Empresas;
begin
   aTabela[1].Add('Empresas');
   aTabela[2].Add('Id_Empresa integer NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                  'CNPJ varchar(14) not null, ' +
                  'Nome varchar(60)');
   aTabela[3].Add('');
end;

procedure Table_ContaEmail;
begin
   aTabela[1].Add('ContaEmail');
   aTabela[2].Add('Id_ContaEmail integer NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                  'Fk_Empresa int, ' +
                  'Email varchar(100), ' +
                  'Senha varchar(20), ' +
                  'ContaPOP3 varchar(100), ' +
                  'PortaPOP3 int, ' +
                  'ConexaoSSLPOP3 bool not null default 0, ' +
				      'ExcluiAposRecebimento bool not null default 0');
   aTabela[3].Add('');
end;

procedure Table_Config;
begin
   aTabela[1].Add('Config');
   aTabela[2].Add('Id_Config integer NOT NULL PRIMARY KEY AUTOINCREMENT, ' +
                  'localGravacao varchar(200) ');
   aTabela[3].Add('');
end;

Begin
   Table_Empresas();
   Table_ContaEmail();
   Table_Config();
End;

end.
