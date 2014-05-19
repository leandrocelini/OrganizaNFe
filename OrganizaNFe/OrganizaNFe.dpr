program OrganizaNFe;

uses
  Forms,
  ConfigGridFormNew in '..\Genericos\Form\ConfigGridFormNew.pas',
  DialogNew in '..\Genericos\Form\DialogNew.pas' {dlgDialogNew},
  FormNew in '..\Genericos\Form\FormNew.pas' {frmFormNew},
  MsgEspera in '..\Genericos\Form\MsgEspera.pas' {dlgMsgEspera},
  PrincipalNew in '..\Genericos\Form\PrincipalNew.pas' {frmPrincipalNew},
  Splash in '..\Genericos\Form\Splash.pas' {frmSplash},
  uPrincipal in 'Form\uPrincipal.pas' {frmPrincipal},
  Data in 'DataModule\Data.pas' {dm: TDataModule},
  uEmpresas in 'Form\uEmpresas.pas' {frmEmpresas},
  uContaEmail in 'Form\uContaEmail.pas' {dlgContaEmail},
  ubaixaremails in 'Form\ubaixaremails.pas' {dlgBaixarEmails},
  EstruturaBD in 'Unit\EstruturaBD.pas',
  FuncoesBD in 'Unit\FuncoesBD.pas' {$R *.res},
  uConfig in 'Form\uConfig.pas' {dlgConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
