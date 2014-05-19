unit CpuID;

interface

function GetCPUSN:String;

implementation

Uses Windows,SysUtils;

Type TCPUID	= array[1..4] of Longint;


////////////////////////////////////////////////
function GetCPUID : TCPUID; assembler; register;
////////////////////////////////////////////////
asm
  PUSH    EBX         {Save affected register}
  PUSH    EDI
  MOV     EDI,EAX     {@Resukt}
  MOV     EAX,1
  DW      $A20F       {CPUID Command}
  STOSD			          {CPUID[1]}
  MOV     EAX,EBX
  STOSD               {CPUID[2]}
  MOV     EAX,ECX
  STOSD               {CPUID[3]}
  MOV     EAX,EDX
  STOSD               {CPUID[4]}
  POP     EDI					{Restore registers}
  POP     EBX
end;

/////////////////////////
//Função utilizada para retornar o número de série do processador
//Autor: João Paulo Francisco Bellucci
/////////////////////////
function GetCPUSN:String;
/////////////////////////
Var i:Integer;
    aCPUID:TCPUID;
begin
  For i := Low(aCPUID) to High(aCPUID) do aCPUID[i] := -1;

  aCPUID := GetCPUID;

  Result := IntToHex(aCPUID[1],8) + ' ' +
            IntToHex(aCPUID[2],8) + ' ' +
            IntToHex(aCPUID[3],8) + ' ' +
            IntToHex(aCPUID[4],8);
end;

end.
