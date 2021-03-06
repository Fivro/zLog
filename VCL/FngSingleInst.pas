(*
   Fnugry Box
   Version 3.0
   Copyright � 1996-97 Gleb Yourchenko

   File Name:     FNGSINGLEINST.PAS
   Description:   Fnugry Single Instance Component


   Version:       1.0.0.1
   Author(s):     Gleb Yourchenko
   Module:        (SHARED)
   Documentation: FNGSINGLEINST.DOC


   Contact:
   Gleb Yourchenko
   eip__@hotmail.com
   Please specify 'TFnugrySingleInstance' in the subject string

*)




{$ASSERTIONS ON}


unit FngSingleInst;

interface

uses
  Windows, SysUtils, Classes, Forms;

type

  ESingleInstError = class(Exception);

  TAlreadyRunningEvent = procedure(Sender :TObject;
    hPrevInst :THandle; hPrevWnd :HWND) of object;


  TFnugrySingleInstance = class(TComponent)
  private
     FMappingHandle     :THandle;
     FOnAlreadyRunning  :TAlreadyRunningEvent;
  protected
     procedure Loaded; override;
     procedure AlreadyRunning(hPrevInst, hPrevWnd :THandle); virtual;
  public
     constructor Create(AOwner :TComponent); override;
     destructor Destroy; override;
  published
     property OnAlreadyRunning :TAlreadyRunningEvent
       read FOnAlreadyRunning write FOnAlreadyRunning;
  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterCOmponents('Fnugry Tools', [TFnugrySingleINstance]);
end;

type

  PInstInfo = ^TInstInfo;
  TInstInfo = packed record
    hPrevInst   :THandle;
    hPrevWnd    :HWND;
  end;

var

  SingleInstInstance :TComponent = Nil;

const

  sErrAlreadyExists  = 'Only one instance of TFnugrySingleInstance is allowed';


procedure TFnugrySingleInstance.AlreadyRunning(
 hPrevInst, hPrevWnd :THandle);
begin
   if assigned(FOnAlreadyRunning) then
      FOnAlreadyRunning(Self, hPrevInst, hPrevWnd)
   else
      begin
         SetForegroundWIndow(hPrevWnd);
         Application.Terminate;
      end;
end;


constructor TFnugrySingleInstance.Create(AOwner :TComponent);
begin
   assert(SingleInstInstance = Nil, sErrAlreadyExists);
   inherited Create(AOwner);
   SingleInstInstance := Self;
end;


destructor TFnugrySingleInstance.Destroy;
begin
   if FMappingHandle <> 0 then CloseHandle(FMappingHandle);
   inherited Destroy;
   SingleInstInstance := Nil;
end;

procedure TFnugrySingleInstance.Loaded;
var
   lpInfo       :PInstInfo;
   ParentForm   :TComponent;
begin
   inherited Loaded;
   if not (csDesigning in ComponentState) then
   begin
      FMappingHandle := CreateFileMapping(0 {was -1}, NIL,
         PAGE_READWRITE, 0, sizeof(TInstInfo),
         PChar(ExtractFileName(ParamStr(0))));
      if FMappingHandle <> 0 then
      begin
         lpInfo := MapViewOfFile(FMappingHandle,
            FILE_MAP_WRITE OR FILE_MAP_READ, 0, 0, sizeof(TInstInfo));
         if lpInfo <> Nil then
         try
            if GetLastError = ERROR_ALREADY_EXISTS then
               AlreadyRunning(lpInfo^.hPrevInst, lpInfo^.hPrevWnd)
            else
            begin
                 ParentForm := Owner;
                 lpInfo^.hPrevInst := hInstance;
                 while (not (ParentForm is TForm)) and (ParentForm <> Nil)
                   do ParentForm := Owner;
                 if ParentForm <> Nil then lpInfo^.hPrevWnd := TForm(ParentForm).Handle;
            end;
         finally
            UnmapViewOfFile(lpInfo);
         end;
      end;
   end;
end;



initialization
finalization
   if SingleInstInstance <> Nil then
      SingleInstInstance.Free;
end.
