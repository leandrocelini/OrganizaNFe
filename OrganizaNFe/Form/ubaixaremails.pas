unit ubaixaremails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogNew, mbKeyEvent, StdCtrls, ExtCtrls, Buttons,
  IdMessage, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3, dblookup, DBCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, IdAttachmentFile,
  IdAttachment, mbFuncoes, ShellAPI, mbDialogo, mbMsgWait,
  ComCtrls, Gauges, JvExControls, JvDBLookup, JvComponentBase, JvThread;

type
  TdlgBaixarEmails = class(TdlgDialogNew)
    IdPOP31: TIdPOP3;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdMessage1: TIdMessage;
    ListViewBaixar: TListView;
    dsBuscaIdConta: TDataSource;
    qrBuscaIdConta: TZQuery;
    dsBuscEmp: TDataSource;
    qrBuscEmp: TZQuery;
    ProgressBar1: TProgressBar;
    qrEmpresa: TZQuery;
    qrEmpresaid_Empresa: TIntegerField;
    qrEmpresaNome: TWideStringField;
    dsEmpresa: TDataSource;
    dsEmails: TDataSource;
    qrEmails: TZQuery;
    qrEmpConta: TZQuery;
    dsEmpConta: TDataSource;
    qrEmpContaEmail: TWideStringField;
    qrEmpContaNome: TWideStringField;
    qrEmpContaid_Empresa: TIntegerField;
    qrEmpContaid_ContaEmail: TIntegerField;
    qrEmpContacnpj: TWideStringField;
    MemoEmails: TMemo;
    panelRodape: TPanel;
    bitBaixarEmailsClick: TBitBtn;
    btnCancelar: TBitBtn;
    panelTopo: TPanel;
    lbEmpresas: TLabel;
    lbEmails: TLabel;
    lbMostraArquivos: TLabel;
    dbEmpresa: TJvDBLookupCombo;
    dbEmails: TJvDBLookupCombo;
    JvThread: TJvThread;
    mbMsgWait: TmbMsgWait;
    qrConf: TZQuery;
    dsConf: TDataSource;
    qrConfId_Config: TIntegerField;
    qrConflocalGravacao: TWideStringField;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bitBaixarEmailsClickClick(Sender: TObject);
    procedure qrEmpresaAfterScroll(DataSet: TDataSet);
    procedure JvThreadExecute(Sender: TObject; Params: Pointer);
    procedure MoveProgress;

  private
    { Private declarations }
    _Posicao: double;
  public
    { Public declarations }
    ErroEmail: String;
    function buscaContaEmail(idemail: integer): TStrings;
  end;

var
  dlgBaixarEmails: TdlgBaixarEmails;
  _IdPOP3: TIdPOP3;

Const
  tempo = 10000;

implementation

uses uEmpresas, uContaEmail, Data;
{$R *.dfm}

procedure TdlgBaixarEmails.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TdlgBaixarEmails.bitBaixarEmailsClickClick(Sender: TObject);
begin
  ErroEmail := '';

  mbMsgWait.Inicializar;

  JvThread.ExecuteThreadAndWait(Nil);

  mbMsgWait.Finalizar;

  if (ErroEmail <> '') then begin
    MessageDlg(ErroEmail, mtError, [mbOk], 0);
  end
  else begin
    MessageDlg('Emails Baixados!', mtInformation, [mbOk], 0);
  end;
end;

function TdlgBaixarEmails.buscaContaEmail(idemail: integer): TStrings;
var
  lista: TStrings;
begin
  lista := TStringList.Create;
  qrBuscaIdConta.close;
  qrBuscaIdConta.ParamByName('idcontaemail').AsInteger := idemail;
  qrBuscaIdConta.Open;
  // add ContaPOP3 na posicao 0 vetor
  lista.Add(qrBuscaIdConta.FieldByName('ContaPOP3').AsString);
  // add Porta POP na posicao 1 do vetor
  lista.Add(IntToStr(qrBuscaIdConta.FieldByName('PortaPOP3').AsInteger));
  // add Email na posicao 2 do vetor
  lista.Add(qrBuscaIdConta.FieldByName('Email').AsString);
  // add Senha na posicao 3 do vetor
  lista.Add(qrBuscaIdConta.FieldByName('Senha').AsString);
  // add ConexaoSslPop3  na posicao 4 do vetor
  lista.Add(qrBuscaIdConta.FieldByName('ConexaoSslPop3').AsString);
  // ExcluiAposRecbimento na posicao 5 do vetor
  lista.Add(qrBuscaIdConta.FieldByName('ExcluiAposRecebimento').AsString);

  Result := lista;
end;

procedure TdlgBaixarEmails.FormShow(Sender: TObject);
begin
  qrEmpresa.Active := True;
  MemoEmails.Enabled := False;
end;

procedure TdlgBaixarEmails.qrEmpresaAfterScroll(DataSet: TDataSet);
begin
  qrEmails.Active := False;
  qrEmails.ParamByName('id_empresa').AsInteger := qrEmpresaid_Empresa.AsInteger;
  qrEmails.Active := True;
end;

procedure TdlgBaixarEmails.JvThreadExecute(Sender: TObject; Params: Pointer);
var
  Msgs, xAnexo, i, idemail: integer;
  lMsg: TIdMessage;
  fname, popUsuario, popServer, popSenha, popPorta, mes, ano, diretorioEmp,
    diretorioArq, localArquivo: string;
  Item: TListItem;
  dadosConta: TStrings;
  Data: TDateTime;
  porcentagem: double;
  conexaoSslPop3, excluiAposRecebimento: Boolean;

begin

  // busca por todas empresas
  if varisnull(dlgBaixarEmails.dbEmpresa.KeyValue) then begin
    dlgBaixarEmails.qrEmpConta.Active := False;
  end
  // busca por todas contas de emails de uma determinada empresa
  else if varisnull(dlgBaixarEmails.dbEmails.KeyValue) then begin

    dlgBaixarEmails.qrEmpConta.Active := False;
    dlgBaixarEmails.qrEmpConta.SQL.Clear;
    dlgBaixarEmails.qrEmpConta.SQL.Add('select email,nome,id_empresa,id_ContaEmail,cnpj from ContaEmail c  inner join Empresas e on e.id_Empresa = c.fk_empresa ');
    dlgBaixarEmails.qrEmpConta.SQL.Append('where id_empresa =' + dlgBaixarEmails.dbEmpresa.KeyValue);
  end
  // busca por uma unica conta de uma determinada empresa
  else begin

    dlgBaixarEmails.qrEmpConta.Active := False;
    dlgBaixarEmails.qrEmpConta.SQL.Clear;
    dlgBaixarEmails.qrEmpConta.SQL.Add('select email,nome,id_empresa,id_ContaEmail,cnpj from ContaEmail c  inner join Empresas e on e.id_Empresa = c.fk_empresa ');
    dlgBaixarEmails.qrEmpConta.SQL.Append('where id_empresa =' + dlgBaixarEmails.dbEmpresa.KeyValue);
    dlgBaixarEmails.qrEmpConta.SQL.Append(' and id_ContaEmail =' + dlgBaixarEmails.dbEmails.KeyValue);

  end;

  //esvazia memo
  dlgBaixarEmails.MemoEmails.Text := '';
  dlgBaixarEmails.qrEmpConta.Open;
  dlgBaixarEmails.qrEmpConta.First;

  while not dlgBaixarEmails.qrEmpConta.Eof do begin

    // inicializa posição do progressbar
    dlgBaixarEmails.ProgressBar1.Position := 0;

    // pega data atual
    Data := Now;
    // formata data atual
    mes := FormatDateTime('mm', Data); // pega mês atual
    ano := FormatDateTime('yyyy', Data); // pega ano atual

    // busca pelo caminho do diretorio
    dlgBaixarEmails.qrConf.Active := False;
    dlgBaixarEmails.qrConf.Open;

    //caso caminho esteja preenchido joga na variavel localArquivo
    if dlgBaixarEmails.qrConflocalGravacao.AsString <> '' then begin
      localArquivo := dlgBaixarEmails.qrConflocalGravacao.AsString + '\';
    end
    //caso em branco grava-lo na raiz do executável
    else begin
      localArquivo := GetCurrentDir + '\';
    end;

    diretorioEmp := localArquivo + dlgBaixarEmails.qrEmpContacnpj.AsString + '-' + dlgBaixarEmails.qrEmpContaNome.AsString;

    // joga na variavel diretorios dos arquivos
    diretorioArq := diretorioEmp + '\' + mes + '-' + ano;

    // verifica se diretorio empresa já existe
    if not DirectoryExists(diretorioEmp) then begin
      // não existindo cria diretório
      ForceDirectories(diretorioEmp);
    end;

    // verifica se diretorio dos arquivos  já existe
    if not DirectoryExists(diretorioArq) then begin
      // não existindo cria diretório
      ForceDirectories(diretorioArq);
    end;

    idemail := dlgBaixarEmails.qrEmpContaid_ContaEmail.AsInteger;
    // funcao para buscar dados da conta de email
    dadosConta := dlgBaixarEmails.buscaContaEmail(idemail);
    popServer := dadosConta[0];
    popPorta := dadosConta[1];
    popUsuario := dadosConta[2];
    popSenha := dadosConta[3];
    conexaoSslPop3 := StrToBool(dadosConta[4]);
    excluiAposRecebimento := StrToBool(dadosConta[5]);

    // limpa dados do listView
    dlgBaixarEmails.ListViewBaixar.Items.Clear;
    _IdPOP3 := TIdPOP3.Create(nil);

    // verifica se server POP3 esta conectado
    if _IdPOP3.Connected then begin
      // desconecta server POP3
      _IdPOP3.Disconnect;
    end;

    // verifica se conta Pop3 Server e com Ssl
    if conexaoSslPop3 then begin

      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.Host := popServer;
      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.Port := StrToInt(popPorta);
      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Method :=sslvSSLv23;
      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.SSLOptions.Mode :=sslmClient;
      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.ConnectTimeout := tempo;
      dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1.ReadTimeout := tempo;

      _IdPOP3.Host := popServer;
      _IdPOP3.Username := popUsuario;
      _IdPOP3.Password := popSenha;
      _IdPOP3.Port := StrToInt(popPorta);
      _IdPOP3.AutoLogin := True;
      _IdPOP3.IOHandler := dlgBaixarEmails.IdSSLIOHandlerSocketOpenSSL1;
      _IdPOP3.UseTLS := utUseImplicitTLS;
      _IdPOP3.ConnectTimeout := tempo;
      _IdPOP3.ReadTimeout := tempo;
    end
    else begin
      _IdPOP3.Host := popServer;
      _IdPOP3.Username := popUsuario;
      _IdPOP3.Password := popSenha;
      _IdPOP3.Port := StrToInt(popPorta);
    end;

    try
      _IdPOP3.Connect();
    except
      on E: Exception do begin
        dlgBaixarEmails.ErroEmail := 'Email: ' + dlgBaixarEmails.qrEmpContaEmail.AsString + ' - ' + E.Message;
        Exit;
      end;
    end;

    try
     // pega total de mensagens da caixa de email
     Msgs := _IdPOP3.CheckMessages;
    except
      on E: Exception do begin
        dlgBaixarEmails.ErroEmail := 'Email: ' + dlgBaixarEmails.qrEmpContaEmail.AsString + ' - ' + E.Message;
        Exit;
      end;
    end;




    // verifica se não tiver nenhum email
    if (Msgs = 0) then begin

      dlgBaixarEmails.MemoEmails.Lines.Add('Total de emails em  ' + dlgBaixarEmails.qrEmpContaEmail.AsString + ': ' + '0');
    end
    else begin

      dlgBaixarEmails.MemoEmails.Lines.Add('Total de emails em  ' + dlgBaixarEmails.qrEmpContaEmail.AsString + ': ' + IntToStr(Msgs));
      lMsg := TIdMessage.Create;
      lMsg.Encoding := meMIME;

      // calculo porcentagem do andamento do ProgressBar
      porcentagem := (100 / Msgs);
      // inicializa com zero posição do Progressbar
      _Posicao := 0;

      // percorre email na caixa de entrada
      for i := 1 to Msgs do begin
        // abre caixa de email
        _IdPOP3.Retrieve(i, lMsg);

        // insere dados no list view
        dlgBaixarEmails.ListViewBaixar.Items.BeginUpdate;
        Item := dlgBaixarEmails.ListViewBaixar.Items.Add;
        Item.Caption := lMsg.From.Name;
        Item.SubItems.Append(lMsg.Subject);
        dlgBaixarEmails.ListViewBaixar.Items.EndUpdate;
        // percorre anexos no email
        for xAnexo := 0 to Pred(lMsg.MessageParts.Count) do begin
          // verifica se o email tem anexo
          if lMsg.MessageParts.Items[xAnexo] is TIdAttachment then begin
            // baixa anexo no diretorio
            fname := TIdAttachmentFile(lMsg.MessageParts.Items[xAnexo]).Filename;
            // verifica se o anexo e um xml
            if pos('.xml', fname) > 0 then begin
              TIdAttachment(lMsg.MessageParts.Items[xAnexo]).SaveToFile(diretorioArq + '\' + fname);
            end;
          end;
        end; // fecha for anexos

        // verifica se o Pop3 Server e de exclusão apos recebimento
        if excluiAposRecebimento then begin
          // apaga email da entrada para lixeira
          _IdPOP3.Delete(i);
        end;
        // incrementa porcentagem para o progressbar
        _Posicao := _Posicao + porcentagem;

        // sycroniza progressbar numa thread
        JvThread.Synchronize(MoveProgress);
      end; // fecha for emails

      // limpa da memoria
      lMsg.Free;
    end; // fecha else que verifica se tem mensagens a ser lidas

    // disconecta conexão pop3
    _IdPOP3.Disconnect;
    // limpa da memoria
    _IdPOP3.Free;

    dlgBaixarEmails.qrEmpConta.Next; // next while
  end; // fecha while
  dlgBaixarEmails.qrEmpConta.Active := True;
end;

procedure TdlgBaixarEmails.MoveProgress;
begin
  dlgBaixarEmails.ProgressBar1.Position := Trunc(_Posicao);
end;

end.
