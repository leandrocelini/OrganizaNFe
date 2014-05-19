unit FormNew;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Grids, DBGrids, Menus, StdCtrls, ExtCtrls, DBCtrls, Buttons,
  ToolWin, ImgList, Db, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  JvComponentBase, JvFormPlacement, JvAppStorage, JvAppIniStorage, mbKeyEvent,
  mbFuncoes, mbDialogo, mbPostgreSql, JvExDBGrids, JvDBGrid, MbFocusColor;

type
  TfrmFormNew = class(TForm)
    pgDados: TPageControl;
    tsPesquisa: TTabSheet;
    tbFuncoes: TToolBar;
    tsDetalhes: TTabSheet;
    tbPrimeiro: TToolButton;
    tbAnterior: TToolButton;
    tbProximo: TToolButton;
    tbUltimo: TToolButton;
    tbIncluir: TToolButton;
    tbAlterar: TToolButton;
    tbExcluir: TToolButton;
    Figuras: TImageList;
    tbImprimir: TToolButton;
    tbSair: TToolButton;
    sbForm: TStatusBar;
    tbAtualizar: TToolButton;
    tbNew: TZQuery;
    dsNew: TDataSource;
    pMenuDetalhe: TPanel;
    pBotoesMenu: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure tbNewAfterRefresh(DataSet: TDataSet);
    procedure tbAtualizarClick(Sender: TObject);
    procedure tbNewAfterOpen(DataSet: TDataSet);
    procedure GridDblClick(Sender: TObject);
    procedure tbNewAfterPost(DataSet: TDataSet);
    procedure tbNewAfterCancel(DataSet: TDataSet);
    procedure tbNewBeforeEdit(DataSet: TDataSet);
    procedure tbSairClick(Sender: TObject);
    procedure tbPrimeiroClick(Sender: TObject);
    procedure tbUltimoClick(Sender: TObject);
    procedure tbAnteriorClick(Sender: TObject);
    procedure tbProximoClick(Sender: TObject);
    procedure tbIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure tbAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbNewBeforeDelete(DataSet: TDataSet);
    procedure tbExcluirClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HabilitaFuncoes(Acao:Boolean);
    procedure GridTitleClick(Column: TColumn);

  private
    { Private declarations }
    //btnGravarTop:Integer;
    //btnGravarLeft:Integer;
    //btnCancelarTop:Integer;
    //btnCancelarLeft:Integer;
    AppIniFileStorageNew:TJvAppIniFileStorage;
    CaptionForm:String;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  public
    { Public declarations }
    BloqueiaRegistro:Boolean;
    NomeTabela:String;
    CampoChave:String;
    FormState:TDataSetState;
    ModoShowForm:Integer;
    ShowMsgExclusao:Boolean;
    PrimeiroObjeto:TWinControl;
  end;

var
  frmFormNew: TfrmFormNew;

implementation

{$R *.DFM}

//////////////////////////////////////////////////
procedure TfrmFormNew.FormCreate(Sender: TObject);
//////////////////////////////////////////////////
begin
   //Cria o objeto de grava��o do arquivo de configura��o do form
   AppIniFileStorageNew := TJvAppIniFileStorage.Create(Application);
   AppIniFileStorageNew.FileName := Name + '.ini';
   AppIniFileStorageNew.Location := flExeFile;

   //Vincula o objeto de grava��o
   FormStorage.AppStorage := AppIniFileStorageNew;

   pgDados.ActivePageIndex := 0;

   //Veriavel que controla o modo de entrada no form
   // ModoShowForm = 0 - Entra no form em modo browser
   // ModoShowForm = 1 - Entra no form em modo inclus�o
   // ModoShowForm = 2 - Entra no form em modo altera��o
   ModoShowForm := 0;

   //Vari�vel que controla se vai fazer a pergunta se deseja excluir o registro
   ShowMsgExclusao := True;

   PrimeiroObjeto := Nil;

   //Atualiza a posi��o do bot�o sair
   tbSair.Left := tbFuncoes.Width; //tbSair.Left+1;
end;

////////////////////////////////////////////////
procedure TfrmFormNew.FormShow(Sender: TObject);
////////////////////////////////////////////////
begin
   //Abre a query
   If Not tbNew.Active Then tbNew.Open;

   //Salva o valor do caption do form
   CaptionForm := Caption;

   If ( ModoShowForm = 0 ) Then begin
      Grid.SetFocus;
   End else If ( ModoShowForm = 1 ) Then begin
      tbIncluir.Click;
   End else If ( ModoShowForm = 2 ) Then begin
      tbAlterar.Click;
   End;

   //Verifica a ordena��o da coluna
   Grid.SortedField := tbNew.SortedFields;

   If ( tbNew.SortType = stAscending ) Then begin
      Grid.SortMarker := smUp;
   End else If ( tbNew.SortType = stDescending ) Then begin
      Grid.SortMarker := smDown;
   end;
end;

///////////////////////////////////////////////////
procedure TfrmFormNew.FormDestroy(Sender: TObject);
///////////////////////////////////////////////////
begin
   //Libera o objeto de cria��o do arquivo do form da mem�ria
   AppIniFileStorageNew.Free;

   If ( tbNew.State = dsEdit ) And BloqueiaRegistro Then begin
      Libera_Chave_bd(NomeTabela,
                      CampoChave,
                      tbNew.FieldByName(CampoChave).AsString,
                      tbNew.Connection);
   End;
end;

///////////////////////////////////////////////////////////
procedure TfrmFormNew.WMSysCommand(var Msg: TWMSysCommand);
///////////////////////////////////////////////////////////
Begin
   If (Msg.CmdType = SC_MINIMIZE) Then begin
      SendMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
   End else begin
      DefaultHandler(Msg);
   End;
End;

///////////////////////////////////////////////////
procedure TfrmFormNew.tbSairClick(Sender: TObject);
///////////////////////////////////////////////////
begin
    Close;
end;

///////////////////////////////////////////////////////
procedure TfrmFormNew.tbPrimeiroClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
   tbNew.First;
end;

/////////////////////////////////////////////////////
procedure TfrmFormNew.tbUltimoClick(Sender: TObject);
/////////////////////////////////////////////////////
begin
   tbNew.Last;
end;

///////////////////////////////////////////////////////
procedure TfrmFormNew.tbAnteriorClick(Sender: TObject);
///////////////////////////////////////////////////////
begin
   tbNew.Prior;
end;

//////////////////////////////////////////////////////
procedure TfrmFormNew.tbProximoClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
   tbNew.Next;
end;

////////////////////////////////////////////////////
//Procedimento utilizado para habilitar e desabilitar os bot�es do objeto tbFuncoes
//Autor: Jo�o Paulo Francisco Bellucci
////////////////////////////////////////////////////
procedure TfrmFormNew.HabilitaFuncoes(Acao:Boolean);
////////////////////////////////////////////////////
Var n,i:Integer;
begin
   //Atribui a acao para os bot�es
   i := tbFuncoes.ButtonCount-1;
   For n := 0 to i do begin
      tbFuncoes.Buttons[n].Enabled := Acao;
   End;
end;

//////////////////////////////////////////////////////
//Evento click do bot�o incluir
//Inclui um novo registro na query tbNew
//////////////////////////////////////////////////////
procedure TfrmFormNew.tbIncluirClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
   //Muda o caption do form
   Caption := CaptionForm + ' - Inclus�o';

   //Desabilita os Bot�es
   HabilitaFuncoes(False);

   pgDados.ActivePageIndex := 1;
   tsPesquisa.Enabled    := False;
   tsPesquisa.TabVisible := False;
   tsDetalhes.Enabled    := True;
   btnGravar.Enabled     := True;
   btnCancelar.Enabled   := True;
   pgDados.ActivePageIndex := 1;

   //Inseri um registro na tabela
   tbNew.Append;

   //Atribui a fun��o de estado que foi inicializada
   FormState := tbNew.State;

   If ( PrimeiroObjeto <> Nil ) Then begin
      PrimeiroObjeto.SetFocus;
   End;
end;

//////////////////////////////////////////////////////
//Evento click do bot�o alterar
//Altera o registro posicionada
//////////////////////////////////////////////////////
procedure TfrmFormNew.tbAlterarClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
   //Verifica se ha registro para ser alterado
   If ( Not tbNew.IsEmpty ) Then begin
      //Entra em modo de edic�o
      tbNew.Edit;

      //Muda o caption do form
      Caption := CaptionForm + ' - Altera��o';

      //Desabilita todos os botoes
      HabilitaFuncoes(False);
      
      pgDados.ActivePageIndex := 1;
      tsPesquisa.Enabled    := False;
      tsPesquisa.TabVisible := False;
      tsDetalhes.Enabled    := True;
      btnGravar.Enabled     := True;
      btnCancelar.Enabled   := True;

      FormState := tbNew.State;

      If ( PrimeiroObjeto <> Nil ) Then begin
         PrimeiroObjeto.SetFocus;
      End;
   End;
end;

//////////////////////////////////////////////////////
//Evento click do bot�o excluir
//Exclui o registro posicionado
//////////////////////////////////////////////////////
procedure TfrmFormNew.tbExcluirClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
   If ( tbnew.RecordCount > 0 ) Then begin
      tbNew.Delete;
   End;
end;

/////////////////////////////////////////////////////////////////
procedure TfrmFormNew.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
/////////////////////////////////////////////////////////////////
begin
   If ( Shift = [ssCtrl] ) And ( Key = 46 ) Then begin
      Key := 0;
   End else If ( Key = VK_INSERT ) And ( Shift = [] ) Then begin
      tbIncluir.Click;
   End;
end;

//////////////////////////////////////////////////////
procedure TfrmFormNew.GridTitleClick(Column: TColumn);
//////////////////////////////////////////////////////
begin
   tbNew.SortedFields := Column.Field.FieldName;

   If Grid.SortMarker in [smDown,smNone] Then begin
      tbNew.SortType  := stDescending;
   End else begin
      tbNew.SortType  := stAscending;
   end;
end;

///////////////////////////////////////////////////////////////////////////
procedure TfrmFormNew.FormClose(Sender: TObject; var Action: TCloseAction);
///////////////////////////////////////////////////////////////////////////
Var Msg:String;
begin
   If tbNew.State in [dsEdit,dsInsert] Then begin
      If ( tbNew.State in [dsEdit] ) Then Msg := 'Deseja realmente cancelar as altera��es!!!';
      If ( tbNew.State in [dsInsert] ) Then Msg := 'Deseja realmente cancelar a inclus�o!!!';

      If MessageDlg(Msg,mtConfirmation,[mbYes,mbNo],0) = mrNo Then begin
         Action := caNone;
         Exit;
      End;
   End;
end;

/////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewBeforeEdit(DataSet: TDataSet);
/////////////////////////////////////////////////////////
begin
   If BloqueiaRegistro Then begin
      If Not Bloqueia_Chave_bd(NomeTabela,
                               CampoChave,
                               tbNew.FieldByName(CampoChave).AsString,
                               tbNew.Connection) Then begin
         MessageDlg('Registro em uso !!!',mtError, [mbOk], 0);
         Abort;
      End;
   End;
end;

//////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewAfterCancel(DataSet: TDataSet);
//////////////////////////////////////////////////////////
begin
   If BloqueiaRegistro Then begin
      Libera_Chave_bd(NomeTabela,
                      CampoChave,
                      tbNew.FieldByName(CampoChave).AsString,
                      tbNew.Connection);
   End;
end;

////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewAfterPost(DataSet: TDataSet);
////////////////////////////////////////////////////////
begin
   If BloqueiaRegistro Then begin
      Libera_Chave_bd(NomeTabela,
                      CampoChave,
                      tbNew.FieldByName(CampoChave).AsString,
                      tbNew.Connection);
   End;
end;

///////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewBeforeDelete(DataSet: TDataSet);
///////////////////////////////////////////////////////////
begin
   If ShowMsgExclusao Then begin
      If MessageDlg('Confirma exclus�o do registro???',mtConfirmation, [mbYes,mbNo], 0) = mrNo Then begin;
         Abort;
      End;
   End;   
end;

////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewAfterOpen(DataSet: TDataSet);
////////////////////////////////////////////////////////
begin
   sbForm.Panels[0].Text := 'N�mero de Registros: ' + IntToStr(tbNew.RecordCount);
end;

///////////////////////////////////////////////////////////
procedure TfrmFormNew.tbNewAfterRefresh(DataSet: TDataSet);
///////////////////////////////////////////////////////////
begin
   sbForm.Panels[0].Text := 'N�mero de Registros: ' + IntToStr(tbNew.RecordCount);
end;

////////////////////////////////////////////////////
procedure TfrmFormNew.GridDblClick(Sender: TObject);
////////////////////////////////////////////////////
begin
   If tbAlterar.Enabled And tbAlterar.Visible Then tbAlterar.Click;
end;

////////////////////////////////////////////////////////
procedure TfrmFormNew.tbAtualizarClick(Sender: TObject);
////////////////////////////////////////////////////////
begin
   If Not ( tbNew.State In [dsInsert,dsEdit] ) Then begin
      tbNew.Refresh;
   End;
end;

//////////////////////////////////////////////////////
procedure TfrmFormNew.btnGravarClick(Sender: TObject);
//////////////////////////////////////////////////////
begin
    Try
       //Grava os dados
       If tbNew.State In [dsInsert, dsEdit] Then tbNew.Post;

       //Habilita todos os bot�es
       HabilitaFuncoes(True);

       //Volta o caption do form para padr�o
       Caption := CaptionForm;

       pgDados.ActivePageIndex := 0;
       tsPesquisa.Enabled    := True;
       tsPesquisa.TabVisible := True;
       tsDetalhes.Enabled    := False;
       btnGravar.Enabled     := False;
       btnCancelar.Enabled   := False;
       Grid.SetFocus;

       //Mostra o n�mero de registro
       sbForm.Panels[0].Text := 'N�mero de Registros: ' + IntToStr(tbNew.RecordCount);
    Except
       on E: Exception do begin
          MessageDlg(E.Message,mtError, [mbOk], 0);
       end;
    End;
end;

////////////////////////////////////////////////////////
procedure TfrmFormNew.btnCancelarClick(Sender: TObject);
////////////////////////////////////////////////////////
Var qrTmpNew:TZQuery;
    Msg:String;
begin
   If tbNew.State in [dsEdit,dsInsert] Then begin
      If ( tbNew.State in [dsEdit] ) Then Msg := 'Deseja realmente cancelar as altera��es!!!';
      If ( tbNew.State in [dsInsert] ) Then Msg := 'Deseja realmente cancelar a inclus�o!!!';

      If MessageDlg(Msg,mtConfirmation,[mbYes,mbNo],0) = mrNo Then begin
         Abort;
      End;

      If ( tbNew.State = dsEdit ) And BloqueiaRegistro Then begin
         If ( tbNew.Connection.Protocol = 'mysql' ) then begin
            qrTmpNew := TZQuery.Create(Application);
            qrTmpNew.Connection := tbNew.Connection;
            qrTmpNew.Sql.Text := 'Select release_lock("' + NomeTabela + '->' + tbNew.FieldByName(CampoChave).AsString + '")';
            qrTmpNew.ExecSql;
            qrTmpNew.Free;
         End;
      End;

      tbNew.Cancel;
   End;

   //Volta o caption do form para padr�o
   Caption := CaptionForm;

   //Habilita todos os bot�es
   HabilitaFuncoes(True);

   pgDados.ActivePageIndex := 0;
   tsPesquisa.Enabled    := True;
   tsPesquisa.TabVisible := True;
   tsDetalhes.Enabled    := False;
   btnGravar.Enabled     := False;
   btnCancelar.Enabled   := False;
   Grid.SetFocus;
end;

end.
