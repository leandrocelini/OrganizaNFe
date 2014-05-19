unit EventsSystem;

interface

Uses Windows, SysUtils, Forms, Messages, Classes, Dialogs, AppEvnts,
     Buttons, Graphics, StdCtrls, Consts, Controls, Math,ExtCtrls, Spin,
     DBGrids, Dialogo, DBCtrls, Db, Grids, ComCtrls, mbFuncoes,
     JvExMask, JvToolEdit, JvBaseEdits, JvDBControls, JvExControls, JvDBLookup,
     JvDBCombobox, JvDBSpinEdit, JvCombobox, JvDBLookupComboEdit, CheckLst,
     JvXPButtons;

Type
   TWinControlAux = class(TWinControl);
   TEventsSystem = class
   private
      AppEvents:TApplicationEvents;
      FOnMessage:TMessageEvent;
      FOnException:TExceptionEvent;
      procedure AppEventsMessage(var Msg:tagMSG; var Handled:Boolean);
      procedure AppEventsException(Sender: TObject; E: Exception);
      function FindNextControl(CurControl: TWinControl;
                               GoForward, CheckTabStop, CheckParent: Boolean):TWinControl;
      procedure SelectNext(CurControl:TWinControl;GoForward, CheckTabStop: Boolean);
   protected
   public
      AtivaEnterTab:Boolean;
      NextControl:Boolean;
      ShowError:Boolean;
      LastKeyDown:Integer;
      property OnException:TExceptionEvent read FOnException write FOnException;
      property OnMessage:TMessageEvent read FOnMessage write FOnMessage;
      constructor Create(AOwner:TComponent);
   end;


implementation

////////////////////////////////////////////////////
constructor TEventsSystem.Create(AOwner:TComponent);
////////////////////////////////////////////////////
begin
   AppEvents := TApplicationEvents.Create(AOwner);
   AppEvents.OnMessage := AppEventsMessage;
   AppEvents.OnException := AppEventsException;

   AtivaEnterTab := True;
   NextControl := False;
   ShowError := True;
   OnException := Nil;
   OnMessage := Nil;
end;

///////////////////////////////////////////////////////////////////////////////////
//Evento utilizado para capturar a messagens de execução do windows
//Utilizamos este evento para capaturar e alterar a execução do teclado
//Autor: João Paulo Francisco Bellucci
///////////////////////////////////////////////////////////////////////////////////
procedure TEventsSystem.AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
///////////////////////////////////////////////////////////////////////////////////
Label Fim;
begin
   //Verifica se possui algum form ativo
   If ( Screen.ActiveForm <> Nil ) Then begin
      //Chamada do help
      If ( Screen.ActiveForm <> Nil ) And ((Screen.ActiveForm.ClassName = 'TMessageForm') = False) Then begin
         If ( Msg.message = WM_KEYDOWN ) then begin
            If ( Msg.wParam = VK_F1 ) And ( Screen.ActiveControl.HelpContext <> 0 ) Then begin
               HtmlHelp(Screen.ActiveForm.Handle, PChar('Ajuda.chm'), $F, Screen.ActiveControl.HelpContext);
            End else If ( Msg.wParam = VK_F1 ) And ( Screen.ActiveForm.HelpContext <> 0 ) then begin
               HtmlHelp(Screen.ActiveForm.Handle, PChar('Ajuda.chm'), $F, Screen.ActiveForm.HelpContext);
            End;
         End;
      End;

      //Verifica se o controle é um TDbEdit e se é numerico
      //Se for seleciona todo o conteudo do campo
      If ( Msg.message = WM_LBUTTONUP ) Then begin
         If ( Screen.ActiveControl is TDBEdit ) Then begin
            If ( (Screen.ActiveControl as TDbEdit).Field.DataType In [ftFloat, ftCurrency] ) Then begin
               (Screen.ActiveControl as TDBEdit).SelectAll;
            End;
         End;
      End;

      //Trocar virgula por ponto
      If ( Msg.message = WM_CHAR ) Then begin
         If ( Screen.ActiveControl is TDBEdit ) Then begin
            If ( (Screen.ActiveControl as TDbEdit).Field.DataType In [ftFloat, ftCurrency] ) Then begin
               If ( Msg.wParam = 46 ) then begin
                  Msg.wParam := 44;
               End;
            End;
         End else If ( Screen.ActiveControl is TJvDBCalcEdit ) Then begin
            If ( (Screen.ActiveControl as TJvDBCalcEdit).Field.DataType In [ftFloat, ftCurrency] ) Then begin
               If ( Msg.wParam = 46 ) then begin
                  Msg.wParam := 44;
               End;
            End;
         End else If ( Screen.ActiveControl is TJvCalcEdit ) Then begin
            If ( Msg.wParam = 46 ) then begin
               Msg.wParam := 44;
            End;
         End else If ( Screen.ActiveControl is TDBGrid ) Then begin
            If (Screen.ActiveControl as TDbGrid).EditorMode Then begin
               If ( (Screen.ActiveControl as TDbGrid).SelectedField.DataType In [ftFloat, ftCurrency] ) Then begin
                  If ( Msg.wParam = 46 ) then begin
                     Msg.wParam := 44;
                  End;
               End;
            End;
         End;
      End;

      //Verifica se deve sair da rotina de tratamento das teclas
      If ( Not AtivaEnterTab ) Or
            (Screen.ActiveControl is TCustomMemo) or
               (Screen.ActiveControl is TCustomGrid) or
                  (Screen.ActiveControl is TTreeView ) or
                     (Screen.ActiveControl is TDBLookupListBox ) Or
                        (Screen.ActiveControl is TListBox ) Or
                           ( Screen.ActiveControl is TCheckListBox ) Or
                              ( Screen.ActiveControl is TJvXPButton )Then begin
         If NextControl Then NextControl := False;
         Goto Fim;
      End;

      //Trata o evento que sera criado
      If ( Msg.message = WM_KEYDOWN ) Then begin
         LastKeyDown := Msg.wParam;
         If ( Screen.ActiveControl is TRadioButton ) Then begin
            Goto Fim;
         End else If ( Screen.ActiveControl is TDBLookupComboBox ) Or
                        ( Screen.ActiveControl is TJvDBLookupCombo ) Or
                           ( Screen.ActiveControl is TSpinEdit ) Or
                               ( Screen.ActiveControl is TJVDBSpinEdit ) Or
                                  ( Screen.ActiveControl is TJvDBLookupComboEdit) Then begin
            If ( Msg.wParam = VK_RIGHT ) Then begin
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_LEFT ) Then begin
               SelectNext(Screen.ActiveControl,False,True);
            End;
         End else If ( Screen.ActiveControl is TDBComboBox ) Or
                        ( Screen.ActiveControl is TJvDBComboBox ) Or
                           ( Screen.ActiveControl is TComboBox ) Or
                              ( Screen.ActiveControl is TJvComboBox ) Then begin
            If ( Msg.wParam = VK_RIGHT ) Then begin
               Msg.message := 0;
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_LEFT ) Then begin
               Msg.message := 0;
               SelectNext(Screen.ActiveControl,False,True);
            End;
         End else If ( Screen.ActiveControl is TCheckBox ) Or
                        ( Screen.ActiveControl is TDBCheckBox )Then begin
            If ( Msg.wParam = VK_DOWN ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_UP ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,False,True);
            End Else If ( Msg.wParam = VK_RIGHT ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_LEFT ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,False,True);
            End;
         End else If ( Screen.ActiveControl is TButton ) Then begin
            If ( Msg.wParam = VK_DOWN ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_UP ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,False,True);
            End Else If ( Msg.wParam = VK_RIGHT ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,True,True);
            End else If ( Msg.wParam = VK_LEFT ) Then begin
               Msg.message := WM_KEYUP;
               SelectNext(Screen.ActiveControl,False,True);
            End;
         End else If ( Screen.ActiveControl is TDateTimePicker ) Then begin
            Goto Fim;
         End else begin
            If ( Msg.wParam = VK_DOWN )  Then begin
               PostKeyEx32(VK_TAB, [], false);
            End else If ( Msg.wParam = VK_UP ) Then begin
               PostKeyEx32(VK_TAB, [ssShift], false);
            End;
         End;
      End else If ( Msg.message = WM_CHAR )  then begin
         If ( Msg.wParam = VK_RETURN ) Then begin
            NextControl := True;
            Goto Fim;
         End;
      End;

      If NextControl Then begin
         NextControl := False;
         SelectNext(Screen.ActiveControl,True,True);
      End;
   End;

Fim:
   //Evento do usuário
   if Assigned(FOnMessage) then FOnMessage(Msg, Handled);

End;

///////////////////////////////////////////////////////////////
function TEventsSystem.FindNextControl(CurControl: TWinControl;
  GoForward, CheckTabStop, CheckParent: Boolean): TWinControl;
///////////////////////////////////////////////////////////////
var
  I, StartIndex: Integer;
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    Screen.ActiveForm.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(CurControl);
      if StartIndex = -1 then
        if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        CurControl := List[I];
        if CurControl.CanFocus and
          (not CheckTabStop or CurControl.TabStop) and
          (not CheckParent or (CurControl.Parent = CurControl)) then
          Result := CurControl;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;

///////////////////////////////////////////////////////////
procedure TEventsSystem.SelectNext(CurControl: TWinControl;
  GoForward, CheckTabStop: Boolean);
///////////////////////////////////////////////////////////
Var NewControl:TWinControl;
    //AuxOnExit,AuxOnEnter:TNotifyEvent;
begin
  NewControl := FindNextControl(CurControl,GoForward,CheckTabStop, not CheckTabStop);
  if ( NewControl <> nil ) then begin
     NewControl.SetFocus;

     //NewControl.ControlState := NewControl.ControlState + [csReadingState];
     
     //Screen.ActiveForm.FocusControl(NewControl);
     //Screen.ActiveForm.SetFocusedControl(NewControl);
     
     //Screen.ActiveForm.FocusControl(NewControl);
     
     //NewControl.SetFocus;

     {if Assigned(TWinControlAux(CurControl).OnExit) Then begin
        //Salva os enventos
        AuxOnExit := TWinControlAux(CurControl).OnExit;
        AuxOnEnter := TWinControlAux(NewControl).OnEnter;

        //Limpa os eventos
        TWinControlAux(CurControl).OnExit := Nil;
        TWinControlAux(NewControl).OnEnter := Nil;

        //Executa o evento OnExit
        AuxOnExit(CurControl);

        //Focaliza o novo objeto
        NewControl.SetFocus;

        //Volta os eventos
        TWinControlAux(CurControl).OnExit := AuxOnExit;
        TWinControlAux(NewControl).OnEnter := AuxOnEnter;

        //Executa o evento OnEnter
        If Assigned(AuxOnEnter) Then AuxOnEnter(NewControl);
     End else begin
        NewControl.Name;
        NewControl.SetFocus;
     End;}
  End;
end;

//////////////////////////////////////////////////////////////////////////
procedure TEventsSystem.AppEventsException(Sender: TObject; E: Exception);
//////////////////////////////////////////////////////////////////////////
begin
   //Evento do usuário
   if Assigned(FOnException) then FOnException(Sender, E);

   If ShowError Then begin
      MessageDlg(E.Message,mtError, [mbOk], 0);
   End;
end;

end.
