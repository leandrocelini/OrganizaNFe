unit FuncoesBD;

interface

Uses Windows, SysUtils, Forms, Db, Dialogs, Classes, Winsock,
     Buttons, ZAbstractRODataset, ZAbstractDataset, ZAbstractConnection,
     StrUtils, ZDataset, DBTables, mbDialogo, mbFuncoes, ZSqlProcessor,
     StdCtrls, Variants, mbSQLite, ZConnection;


Procedure CriaBanco(DataBase:TZAbstractConnection);

implementation

uses EstruturaBD;

////////////////////////////////////////////////////////////////////////////////
Procedure CriaBanco(DataBase:TZAbstractConnection);
////////////////////////////////////////////////////////////////////////////////
Var aTabela:TTabelasSQLite;    
Begin

   aTabela[1] := TStringList.Create;
   aTabela[2] := TStringList.Create;
   aTabela[3] := TStringList.Create;
   Try
      Estrutura_OrganizaNFe(aTabela);

      If ( CriaBanco_SQLite(aTabela,
                            EstruturaBD.sVersaoBD,
                            DataBase) = 1 ) then begin

      End;
   Finally
      aTabela[1].Free;
      aTabela[2].Free;
      aTabela[3].Free;
   End;
   
End;

End.

