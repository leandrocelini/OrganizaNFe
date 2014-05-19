unit IdeSN; 

interface 

function GetIdeSN:String;
function GetIdeDiskSerialNumber( ControllerNumber, DriveNumber : Integer ): String;

implementation 

uses 
  Windows, 
  SysUtils; // only for Win32Platform, SysErrorMessage and class Exception 

{$IFDEF VER150} 
{$DEFINE VER140}
{$ENDIF}

//{$IFNDEF VER140}
//procedure RaiseLastOSError;
//begin
//   RaiseLastWin32Error;
//end;
//{$ENDIF}

/////////////////////////////////////////////////////////////////////////////
function GetIdeDiskSerialNumber(ControllerNumber,DriveNumber:Integer):String;
/////////////////////////////////////////////////////////////////////////////
type
  TSrbIoControl = packed record
    HeaderLength : ULONG;
    Signature    : Array[0..7] of Char;
    Timeout      : ULONG;
    ControlCode  : ULONG;
    ReturnCode   : ULONG;
    Length       : ULONG;
  end;
  SRB_IO_CONTROL = TSrbIoControl;
  PSrbIoControl = ^TSrbIoControl;

  TIDERegs = packed record
    bFeaturesReg     : Byte;
    bSectorCountReg  : Byte;
    bSectorNumberReg : Byte;
    bCylLowReg       : Byte;
    bCylHighReg      : Byte;
    bDriveHeadReg    : Byte;
    bCommandReg      : Byte;
    bReserved        : Byte;
  end;
  IDEREGS   = TIDERegs;
  PIDERegs  = ^TIDERegs;

  TSendCmdInParams = packed record
    cBufferSize  : DWORD;
    irDriveRegs  : TIDERegs;
    bDriveNumber : Byte;
    bReserved    : Array[0..2] of Byte;
    dwReserved   : Array[0..3] of DWORD; 
    bBuffer      : Array[0..0] of Byte;  
  end; 
  SENDCMDINPARAMS   = TSendCmdInParams; 
  PSendCmdInParams  = ^TSendCmdInParams; 

  TIdSector = packed record 
    wGenConfig                 : Word; 
    wNumCyls                   : Word; 
    wReserved                  : Word; 
    wNumHeads                  : Word; 
    wBytesPerTrack             : Word; 
    wBytesPerSector            : Word; 
    wSectorsPerTrack           : Word; 
    wVendorUnique              : Array[0..2] of Word;
    sSerialNumber              : Array[0..19] of Char;
    wBufferType                : Word;
    wBufferSize                : Word;
    wECCSize                   : Word;
    sFirmwareRev               : Array[0..7] of Char;
    sModelNumber               : Array[0..39] of Char;
    wMoreVendorUnique          : Word;
    wDoubleWordIO              : Word;
    wCapabilities              : Word;
    wReserved1                 : Word;
    wPIOTiming                 : Word;
    wDMATiming                 : Word;
    wBS                        : Word;
    wNumCurrentCyls            : Word;
    wNumCurrentHeads           : Word;
    wNumCurrentSectorsPerTrack : Word;
    ulCurrentSectorCapacity    : ULONG;
    wMultSectorStuff           : Word;
    ulTotalAddressableSectors  : ULONG;
    wSingleWordDMA             : Word;
    wMultiWordDMA              : Word;
    bReserved                  : Array[0..127] of Byte;
  end;
  PIdSector = ^TIdSector;

const
  IDE_ID_FUNCTION = $EC;
  IDENTIFY_BUFFER_SIZE       = 512;
  DFP_RECEIVE_DRIVE_DATA        = $0007c088;
  IOCTL_SCSI_MINIPORT           = $0004d008;
  IOCTL_SCSI_MINIPORT_IDENTIFY  = $001b0501;
  DataSize = sizeof(TSendCmdInParams)-1+IDENTIFY_BUFFER_SIZE;
  BufferSize = SizeOf(SRB_IO_CONTROL)+DataSize;
  W9xBufferSize = IDENTIFY_BUFFER_SIZE+16;
var
  hDevice : THandle;
  cbBytesReturned : DWORD;
  s : String;
  pInData : PSendCmdInParams;
  pOutData : Pointer; // PSendCmdInParams;
  Buffer : Array[0..BufferSize-1] of Byte;
  srbControl : TSrbIoControl absolute Buffer;

  procedure ChangeByteOrder( var Data; Size : Integer );
  var ptr : PChar;
      i : Integer;
      c : Char;
  begin
    ptr := @Data;
    for i := 0 to (Size shr 1)-1 do
    begin
      c := ptr^;
      ptr^ := (ptr+1)^;
      (ptr+1)^ := c;
      Inc(ptr,2);
    end;
  end;

begin
  Result := '';
  FillChar(Buffer,BufferSize,#0);
  If Win32Platform = VER_PLATFORM_WIN32_NT then begin
      Str(ControllerNumber,s);
        hDevice := CreateFile(
        PChar('\\.\Scsi'+s+':'),
        GENERIC_READ or GENERIC_WRITE,
        FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0 );
      if hDevice=INVALID_HANDLE_VALUE then RaiseLastOSError;
      try
        srbControl.HeaderLength := SizeOf(SRB_IO_CONTROL);
        System.Move('SCSIDISK',srbControl.Signature,8);
        srbControl.Timeout      := 2;
        srbControl.Length       := DataSize;
        srbControl.ControlCode  := IOCTL_SCSI_MINIPORT_IDENTIFY;
        pInData := PSendCmdInParams(PChar(@Buffer)+SizeOf(SRB_IO_CONTROL));
        pOutData := pInData;
        with pInData^ do
        begin
          cBufferSize  := IDENTIFY_BUFFER_SIZE;
          bDriveNumber := DriveNumber;
          with irDriveRegs do
          begin
            bFeaturesReg     := 0;
            bSectorCountReg  := 1;
            bSectorNumberReg := 1;
            bCylLowReg       := 0;
            bCylHighReg      := 0;
            bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
            bCommandReg      := IDE_ID_FUNCTION;
          end;
        end;

        if not DeviceIoControl( hDevice, IOCTL_SCSI_MINIPORT, @Buffer,
                                BufferSize, @Buffer, BufferSize, cbBytesReturned, nil ) then RaiseLastOSError;

      finally
        CloseHandle(hDevice);
      end;
  end else begin
     hDevice := CreateFile( '\\.\SMARTVSD', 0, 0, nil, CREATE_NEW, 0, 0 );

     if hDevice=INVALID_HANDLE_VALUE then RaiseLastOSError;

     try
        pInData := PSendCmdInParams(@Buffer);
        pOutData := PChar(@pInData^.bBuffer);
        with pInData^ do begin
           cBufferSize  := IDENTIFY_BUFFER_SIZE;
           bDriveNumber := DriveNumber;
           with irDriveRegs do begin
             bFeaturesReg     := 0;
             bSectorCountReg  := 1;
             bSectorNumberReg := 1;
             bCylLowReg       := 0;
             bCylHighReg      := 0;
             bDriveHeadReg    := $A0 or ((DriveNumber and 1) shl 4);
             bCommandReg      := IDE_ID_FUNCTION;
           end;
        end;

        if not DeviceIoControl( hDevice, DFP_RECEIVE_DRIVE_DATA, pInData,
                                SizeOf(TSendCmdInParams)-1, pOutData, W9xBufferSize, cbBytesReturned, nil )
                                then RaiseLastOSError;
     finally
        CloseHandle(hDevice);
     end;
  end;

  With PIdSector(PChar(pOutData)+16)^ do begin
     ChangeByteOrder(sSerialNumber,SizeOf(sSerialNumber));
     SetString(Result,sSerialNumber,SizeOf(sSerialNumber));
  End;

  Result := Trim(Result);
end;

/////////////////////////
Function GetIdeSN:String;
/////////////////////////
Var iController, iDrive, maxController : Integer;
begin
  Result := '';
  maxController := 15;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then maxController := 0;
  for iController := 0 to maxController do begin
    for iDrive := 0 to 4 do begin
      try
        Result := GetIdeDiskSerialNumber(iController,iDrive);
        if Result<>'' then Exit;
      except
        // Sem tratamento de Exceções.
      end;
    end;
  end;
end;

end.