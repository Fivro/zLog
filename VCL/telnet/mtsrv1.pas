{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Author:       Fran�ois PIETTE
Description:  This little application shows how to use the TWSocket in a
              multithreaded application. It is a very basic telnet werver.
              Each time a client connect to the server, he receive an "hello"
              message. Then every character sent is echoed back to the client.
              There are two units is this application: one for the main
              server code, and one for the client thread.
              Each time a client connect to the server, a new TWSocket is
              created and a new thread is launched to handle the client
              work. When the client disconnect, the TWSocket and the thread
              are destroyed.
              To see this demo working on your computer, start the demo then
              start several copies of the TELNET client program (the one which
              comes with Windows 95 is perfect). Then using each telnet, connect
              to 127.0.0.1. You'll see a new connection in the list box. You
              must receive the "hello" message and see each character as you
              type them. You can use the Disconnect button from the application
              or from the telnet client to see what happends (the connection
              should be closed).
EMail:        francois.piette@ping.be  http://www.rtfm.be/fpiette
              francois.piette@f2202.n293.z2.fidonet.org
              2:293/2202@fidonet.org, BBS +32-4-3651395
Creation:     September 21, 1997
Version:      1.01
Support:      EMail to the author
Legal issues: Copyright (C) 1997 by Fran�ois PIETTE <francois.piette@ping.be>

              This software is provided 'as-is', without any express or
  	      implied warranty.  In no event will the author be held liable
              for any  damages arising from the use of this software.

              Permission is granted to anyone to use this software for any
              purpose, including commercial applications, and to alter it
              and redistribute it freely, subject to the following
              restrictions:

              1. The origin of this software must not be misrepresented,
                 you must not claim that you wrote the original software.
                 If you use this software in a product, an acknowledgment 
                 in the product documentation would be appreciated but is
                 not required.

              2. Altered source versions must be plainly marked as such, and
                 must not be misrepresented as being the original software.

              3. This notice may not be removed or altered from any source 
                 distribution.

Updates:
Nov 18, 1997 Corrected isxdigit (By Paul Taylor <paul@star.net.au>)

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit mtsrv1;

interface

{$IFDEF VER80}
  'This sample program use threads and hence is not compatible with Delphi 1';
{$ENDIF}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  WSocket, MTSrv2, StdCtrls;

type
  TServerForm = class(TForm)
    ServerWSocket: TWSocket;
    DisconnectButton: TButton;
    QuitButton: TButton;
    ClientListBox: TListBox;
    DisconnectAllButton: TButton;
    Button1: TButton;
    procedure ServerWSocketSessionAvailable(Sender: TObject; Error: Word);
    procedure FormShow(Sender: TObject);
    procedure DisconnectButtonClick(Sender: TObject);
    procedure QuitButtonClick(Sender: TObject);
    procedure DisconnectAllButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    procedure ClientThreadTerminate(Sender: TObject);
    procedure DisconnectAll;
  public
    procedure SendAll(str : string);
  end;

var
  ServerForm: TServerForm;

implementation

{$R *.DFM}


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ Check if a character is a valid hex digit                                 }
function isxdigit(Ch : char) : Boolean;
begin
    Result := (ch in ['0'..'9']) or (ch in ['a'..'f']) or (ch in ['A'..'F']);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ Convert an hexdigit to an integer                                         }
function xdigit(Ch : char) : Integer;
begin
    if ch in ['0'..'9'] then
        Result := ord(Ch) - ord('0')
    else
        Result := (ord(Ch) and 15) + 9;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ Convert the ascii representation of a hex number to an integer            }
function htoi(value : PChar) : Integer;
var
    i : Integer;
begin
    Result := 0;
    i      := 0;
    while (Value[i] <> #0) and (Value[i] = ' ') do
        i := i + 1;
    while (Value[i] <> #0) and (isxDigit(Value[i])) do begin
        Result := Result * 16 + xdigit(Value[i]);
        i := i + 1;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event is generated when a client is connecting                       }
procedure TServerForm.ServerWSocketSessionAvailable(Sender: TObject;
  Error: Word);
var
    ClientThread  : TClientThread;
begin
    { Create a new thread to handle client request                          }
    ClientThread             := TClientThread.Create(ServerWSocket.Accept);

    { Assign the thread's OnTerminate event                                 }
    ClientThread.OnTerminate := ClientThreadTerminate;

    { Add the thread to the listbox which is our client list                }
    ClientListBox.Items.Add(IntToHex(Integer(ClientThread), 8));

    { Then start the client thread work                                     }
    { because it was created in the blocked state                           }
    ClientThread.Resume;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TServerForm.FormShow(Sender: TObject);
const
    FirstTime : Boolean = TRUE;
begin
    if FirstTime then begin
        FirstTime           := FALSE;
        if WSocket.WSocketVersion < 202 then
            raise Exception.Create(
                  'Please update your wsocket.pas to version 2.02 or later. ' +
                  'Free download at http://www.rtfm.be/fpiette');

        ServerWSocket.Proto := 'tcp';      { We use a TCP connection        }
        ServerWSocket.Port  := 'telnet';   { We wants to use telnet         }
        ServerWSocket.Addr  := '0.0.0.0';  { We accept any client           }
        ServerWSocket.Listen;              { Start server accepting         }
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event is generated when the user clicks on the 'Disconnect' button   }
{ when he wants to disconnect the selected client in the listbox.           }
procedure TServerForm.DisconnectButtonClick(Sender: TObject);
var
    ClientThread  : TClientThread;
    Buf           : String;
begin
    { No selected item, nothing to do                                       }
    if ClientListBox.ItemIndex < 0 then
        Exit;

    { Extract the ClientThread pointer from the list box                    }
    Buf := ClientListBox.Items[ClientListBox.ItemIndex];
    ClientThread := TClientThread(htoi(PChar(Buf)));

    { Call ClientThread.Release which will stop the thread                  }
    { In consequence, the OnTerminate event will be generated               }
    ClientThread.Release;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This event handler is called when one of the client thread terminate      }
{ We will find this thread in our listbox, remove it and destroy the        }
{ TWSocket object use by the corresponding client.                          }
procedure TServerForm.ClientThreadTerminate(Sender: TObject);
var
    ClientThread  : TClientThread;
    Buf           : String;
    Index         : Integer;
begin
    { A thread has been terminated, remove it from our list and destroy     }
    { the ClientWSocket we passed to the thread.                            }
    for Index := 0 to ClientListBox.Items.Count - 1 do begin
        Buf := ClientListBox.Items[Index];
        ClientThread := TClientThread(htoi(PChar(Buf)));
        if ClientThread = TClientThread(Sender) then begin
            { Remove the client from our listbox                            }
            ClientListBox.Items.Delete(Index);
            Break;
        end;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{ This procedure scan the listbox and halt every ClientThread               }
procedure TServerForm.DisconnectAll;
var
    ClientThread  : TClientThread;
    Buf           : String;
begin
    while ClientListBox.Items.Count > 0 do begin
        Buf          := ClientListBox.Items[0];
        ClientThread := TClientThread(htoi(PChar(Buf)));
        ClientThread.Release;
        Application.ProcessMessages;
    end;
end;

procedure TServerForm.SendAll(str : string);
var
    ClientThread  : TClientThread;
    Buf           : String;
begin
    for i := 0 to ClientListBox.ITems.Count - 1 do begin
        Buf          := ClientListBox.Items[i];
        ClientThread := TClientThread(htoi(PChar(Buf)));
        ClientThread.ClientWSocket.SendStr(str);
        //Application.ProcessMessages;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TServerForm.QuitButtonClick(Sender: TObject);
begin
    Close;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TServerForm.DisconnectAllButtonClick(Sender: TObject);
begin
    DisconnectAll;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TServerForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    DisconnectAll;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

procedure TServerForm.Button1Click(Sender: TObject);
var i : integer;
    str : string;
begin

  str := '';
  for i := 1 to 75 do
    str := str + '.';
  for i := 1 to 75 do
    begin
      str[i] := '*';
      SendAll(str + #13);
    end;
end;

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

