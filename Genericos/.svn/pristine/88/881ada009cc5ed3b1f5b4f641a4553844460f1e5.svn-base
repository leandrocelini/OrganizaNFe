{********************************************************************************
 * 
 * MAXIBYTE (C) 2010
 *
 * Objeto: TdlgFormTouch
 *
 * Autor.: João Ricardo Pagotto
 *
 * Função: Formulario de Dialogo Genérico para uso com telas TouchScreen
 *
 * Inicio: 26/04/2010
 *
 ********************************************************************************}

unit FormTouch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mbTouchKeyb, DBGrids, mbAutoScale;

type
  TdlgFormTouch = class(TForm)
    MbTouchKeybDefault: TMbTouchKeyb;
    MbAutoScale1: TMbAutoScale;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    proporcaoX:double;
    proporcaoY:double;
    { Public declarations }
  end;

var
  dlgFormTouch: TdlgFormTouch;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TdlgFormTouch.FormCreate(Sender: TObject);
begin
   MbAutoScale1.Update;
end;

//------------------------------------------------------------------------------

procedure TdlgFormTouch.FormShow(Sender: TObject);
begin
   MbTouchKeybDefault.Active := True;
   MbTouchKeybDefault.Show;

   if ( Self.Position in [poDesktopCenter,poScreenCenter] ) then begin

      Self.Top  := Trunc(( Screen.Height / 2 ) - ( Self.Height / 2 ));
      Self.Left := Trunc(( Screen.Width  / 2 ) - ( Self.Width  / 2 ));

   end else begin

      if ( MbTouchKeybDefault.GetKeyboardType = ktQwerty ) then
         Self.Top  := MbTouchKeybDefault.keybQwerty.Top - Self.Height - 5;
                                                 
      if ( MbTouchKeybDefault.GetKeyboardType = ktNumeric ) then
         Self.Top  := MbTouchKeybDefault.keybNumeric.Top - Self.Height - 5;

      if ( MbTouchKeybDefault.GetKeyboardType = ktTerm ) then
         Self.Top  := MbTouchKeybDefault.keybTerm.Top - Self.Height - 5;

      Self.Left := Trunc( ( Screen.Width / 2 ) - ( Self.Width / 2 ) );
      
   end;
end;

//------------------------------------------------------------------------------

procedure TdlgFormTouch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if ( Key = VK_ESCAPE ) then begin
      Close;
      Key := 0;
   end;   
end;

end.
