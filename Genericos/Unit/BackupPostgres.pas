unit BackupPostgres;

interface

Uses Windows, SysUtils, Forms, Messages, Classes, Dialogs, AppEvnts,
     Buttons, Graphics, StdCtrls, Consts, Controls, Math,ExtCtrls, Spin,
     mbDialogo, DBCtrls, Db, Grids, ComCtrls, mbFuncoes, MsgEspera;

Type
   TBackupPostgres = class
   private
      FBackupIniciado:Boolean;
      SA: TSecurityAttributes;
      SI: TStartupInfo;
      PI: TProcessInformation;
      StdOutPipeRead, StdOutPipeWrite: THandle;
      WasOK: Boolean;
      Buffer: array[0..255] of Char;
      BytesRead:Cardinal;
      Line:String;
      CodeResult:Cardinal;
      FLog:TextFile;
      FLogLigado:Boolean;
      FNomeLog:String;
      procedure RegistraLog(Log:String);
   protected
   public
      IPBanco:String;
      PortaBanco:String;
      NomeBanco:String;
      UsuarioBanco:String;
      SenhaBanco:String;
      NomeBackup:String;
      LocalBackup:String;
      property BackupIniciado:Boolean read FBackupIniciado;
      function IniciaBackup:Boolean;
      constructor Create(AOwner:TComponent);
   end;


implementation

//////////////////////////////////////////////////////
//Construtor do objeto do backup do banco de dados
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////////
constructor TBackupPostgres.Create(AOwner:TComponent);
//////////////////////////////////////////////////////
begin
   FBackupIniciado := False;
   FLogLigado := True;
   NomeBackup := '';
   LocalBackup := '';
end;

//////////////////////////////////////////////
//Procedimento utilizado para iniciar o backup do banco de dados
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////
Function TBackupPostgres.IniciaBackup:Boolean;
//////////////////////////////////////////////
Const arrLongDayNames:array[1..7] of string[15] = ('Domingo','Segunda','Terca', 'Quarta','Quinta','Sexta', 'Sabado');
Var Aux,NomeArquivo,Dir,WorkDir,CommandLine:String;
    
begin
   Result := False;
   
   If FBackupIniciado Then Exit;

   //Pega o diretório do executavel
   Dir := ExtractFilePath(Application.ExeName);
   FNomeLog := Dir + 'Backup.log';

   If FileExists(FNomeLog) Then begin
      DeleteFile(FNomeLog);
   End;

   AssignFile(FLog,FNomeLog);
   Try
      ReWrite(FLog);
   Finally
      CloseFile(FLog);
   End;

   FBackupIniciado := True;
   Line := '';
   CodeResult := 1;
   
   RegistraLog('Inicio do Backup');

   //Monta o nome do arquivo que será salvo o backup
   If ( NomeBackup = '' ) Then begin
      NomeArquivo := arrLongDayNames[DayOfWeek(Date())] + '_' + NomeBanco + '.backup';
   End else begin
      NomeArquivo := NomeBackup;
   End;

   //Verifica se deseja gravar o backup em um local especifico
   If ( LocalBackup <> '' ) Then begin
      NomeArquivo := LocalBackup + NomeBackup;
   End;

   Aux := 'pg_dump.exe ' +
          '-f' + NomeArquivo + ' ' + //Determina o nome do arquivos
          '-v ' +
          '-i ' +  //Ignora a versão do banco
          '-h' + IPBanco + ' ' +
          '-p' + PortaBanco + ' ' +
          '-U' + UsuarioBanco + ' ' +
          '-Fc ' + NomeBanco;

   //Cria uma variavel de ambiente no processo para conectar ao banco
   SetDOSEnvVar('pgpassword',SenhaBanco);

   with SA do begin
      nLength := SizeOf(SA);
      bInheritHandle := True;
      lpSecurityDescriptor := nil;
   end;

   MsgEspera.Msg(True,'Aguarde, realizando backup dos dados...',True,True);

   // create pipe for standard output redirection
   CreatePipe(StdOutPipeRead, // read handle
              StdOutPipeWrite, // write handle
              @SA, // security attributes
              0); // number of bytes reserved for pipe - 0

   Try
      // Make child process use StdOutPipeWrite as standard out,
      // and make sure it does not show on screen.
      with SI do begin
         FillChar(SI, SizeOf(SI), 0);
         cb := SizeOf(SI);
         dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
         wShowWindow := SW_HIDE;
         hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect std input
         hStdOutput := StdOutPipeWrite;
         hStdError := StdOutPipeWrite;
      end;

      //Monta a linha de comando que será executada
      CommandLine := Dir + '\' + Aux;

      //Pega o diretório de trabalho
      WorkDir := ExtractFilePath(Dir+'\');

      WasOK := CreateProcess(nil, PChar(CommandLine), nil, nil, True, 0, nil,
                             PChar(WorkDir), SI, PI);

      // Now that the handle has been inherited, close write to be safe.
      // We don't want to read or write to it accidentally.
      CloseHandle(StdOutPipeWrite);

      If WasOk Then begin
         try
            // get all output until dos app finishes
            Line := '';

            repeat
               Application.ProcessMessages;

               // read block of characters (might contain carriage returns and line feeds)
               WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);

               // has anything been read?
               if BytesRead > 0 then begin
                  // finish buffer to PChar
                  Buffer[BytesRead] := #0;

                  Line := Line + Buffer;
               end;
            until not WasOK or (BytesRead = 0);

            // wait for console app to finish (should be already at this point)
            WaitForSingleObject(PI.hProcess, INFINITE);

            //Pega o retorno a aplicação
            GetExitCodeProcess(PI.hProcess,CodeResult);
         finally
            // Close all remaining handles
            CloseHandle(PI.hThread);
            CloseHandle(PI.hProcess);

            SetDOSEnvVar('pgpassword','');

            //Registra os dados de retorno
            RegistraLog(Line);
            
            MsgEspera.Msg(False);

            //Limpa o buffer do teclado
            mbFuncoes.EmptyKeyQueue();
            mbFuncoes.EmptyMouseQueue();

            If ( CodeResult = 0 ) Then begin
               Result := true;
            End else begin
               MsgEspera.Msg(False);

               Application.ProcessMessages;

               MessageDlg('Erro ao fazer o backup no encerramento do turno!!!' + #13#13 +
                          'Informe imediatamente seu fornecedor sobre este erro.' + #13#13 +
                          'Ele deve ser corrigido para não haver perda de dados.',
                          mtError,[mbOk],0);
            End;
         end;
      End else begin
         MsgEspera.Msg(False);
         
         MessageDlg('Erro ao iniciar o backup.' + #13 +
                    'Verifique se os arquivos abaixo '+ #13 + 'estão na pasta do executável ou estão corrompidos. ' + #13#13 +
                    'pg_dump.exe ' + #13 +
                    'pg_restore.exe ' + #13 +
                    'dropdb.exe ' + #13 +
                    'comerr32.dll ' + #13 +
                    'krb5_32.dll ' + #13 +
                    'libeay32.dll ' + #13 +
                    'libiconv-2.dll ' + #13 +
                    'libintl-2.dll ' + #13 +
                    'libpq.dll ' + #13 +
                    'libpq73.dll ' + #13 +
                    'ssleay32.dll',mtError,[mbOk],0);
      End;
   Finally
      MsgEspera.Msg(False);
      CloseHandle(StdOutPipeRead);
      FBackupIniciado := False;
   End;
End;

//////////////////////////////////////////////////
//Procedimento utilizado para registrar log referente ao backup
//Autor: João Paulo Francisco Bellucci
//////////////////////////////////////////////////
procedure TBackupPostgres.RegistraLog(Log:String);
//////////////////////////////////////////////////
begin
   Try
      AssignFile(FLog,FNomeLog);
      Append(FLog);
      WriteLn(FLog,Log + ' - ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',Now()));
      CloseFile(FLog);
   Except
      FLogLigado := False;
   End;
end;

end.
