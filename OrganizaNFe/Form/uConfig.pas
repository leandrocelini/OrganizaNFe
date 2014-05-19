unit uConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogNew, mbKeyEvent, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Grids, DBGrids, JvExDBGrids, JvDBGrid, StdCtrls, Mask, DBCtrls,
  Buttons, ExtCtrls, mbDialogo, JvExMask, JvToolEdit, IdBaseComponent,
  IdComponent, IdExplicitTLSClientServerBase, JvDriveCtrls, ShellAPI, DBTables,
  IWJQueryWidget, zlib;

type
  TdlgConfig = class(TdlgDialogNew)
    qrConfig: TZQuery;
    dsConfig: TDataSource;
    qrConfigId_Config: TIntegerField;
    qrConfiglocalGravacao: TWideStringField;
    panelRodape: TPanel;
    btAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    panelTopo: TPanel;
    Label1: TLabel;
    dirLocalGravacao: TJvDirectoryEdit;
    procedure btAlterarClick(Sender: TObject);
    function alteraDiretorio(diretorio: string): Boolean;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgConfig: TdlgConfig;

implementation

uses Data;

{$R *.dfm}

procedure TdlgConfig.btAlterarClick(Sender: TObject);
begin

  // verifica se o diretorio para ser alterado e válido.
  if not DirectoryExists(dirLocalGravacao.Text) and (dirLocalGravacao.Text <> '') then begin
    MessageDlg('Diretorio não existente!', mtInformation, [mbOk], 0);
    exit;
  end;
  // verifica se o diretorio foi alterado corretamente na função - alteraDiretorio
  if alteraDiretorio(dirLocalGravacao.Text) then begin
    MessageDlg('Alterado com Sucesso!', mtInformation, [mbOk], 0);
    close;
  end
  else begin
    MessageDlg('Falha no Update!', mtInformation, [mbOk], 0);
    exit;
  end;
  qrConfig.Refresh;
end;

procedure TdlgConfig.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TdlgConfig.FormShow(Sender: TObject);
begin
  qrConfig.Open;
  dirLocalGravacao.Text := qrConfiglocalGravacao.AsString;
end;

// função altera diretório
function TdlgConfig.alteraDiretorio(diretorio: string): Boolean;
begin
  qrConfig.Edit;
  qrConfiglocalGravacao.AsString := diretorio;
  qrConfig.Post;
  Result := true;
end;

end.
