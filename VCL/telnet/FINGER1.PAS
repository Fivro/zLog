{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

Author:       Fran�ois PIETTE
Description:  Finger is a FINGER client
              Install the components in FingCli.pas and wsocket.pas first.
EMail:        francois.piette@ping.be  http://www.rtfm.be/fpiette
              francois.piette@rtfm.be
Creation:     December 18, 1997
Version:      1.00
WebSite:      http://www.rtfm.be/fpiette/indexuk.htm
Support:      Use the mailing list twsocket@rtfm.be See website for details.
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


 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
unit finger1;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FingCli, WinSock, WSocket;

type
  TFingerDemoForm = class(TForm)
    FingerCli1: TFingerCli;
    WSocket1: TWSocket;
    DisplayMemo: TMemo;
    Panel1: TPanel;
    QueryEdit: TEdit;
    QueryButton: TButton;
    CancelButton: TButton;
    procedure QueryButtonClick(Sender: TObject);
    procedure FingerCli1DataAvailable(Sender: TObject; Error: Word);
    procedure FingerCli1QueryDone(Sender: TObject; Error: Word);
    procedure FingerCli1SessionConnected(Sender: TObject; Error: Word);
    procedure CancelButtonClick(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  FingerDemoForm: TFingerDemoForm;

const
{$IFDEF VER80}
    BufferSize = 255;     { Delphi 1 is limited to 255 bytes }
{$ELSE}
    BufferSize = 2048;
{$ENDIF}

implementation

{$R *.DFM}

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
{* Display a message in the memo field, breaking with CR                   *}
procedure MemoAddLines(Memo : TMemo; Msg : String);
const
    CR = #13;
    LF = #10;
var
    Start, Stop : Integer;
begin
    if Memo.Lines.Count = 0 then
        Memo.Lines.Add('');

    Start := 1;
    Stop  := Pos(CR, Msg);
    if Stop = 0 then
        Stop := Length(Msg) + 1;
    while Start <= Length(Msg) do begin
        Memo.Lines.Strings[Memo.Lines.Count - 1] :=
            Memo.Lines.Strings[Memo.Lines.Count - 1] +
            Copy(Msg, Start, Stop - Start);
        if Msg[Stop] = CR then begin
            Memo.Lines.Add('');
            SendMessage(Memo.Handle, WM_KEYDOWN, VK_UP, 1);
        end;
        Start := Stop + 1;
        if Start > Length(Msg) then
            Break;
        while Msg[Start] in [CR, LF] do
           Start := Start + 1;
        Stop := Start;
        while (Msg[Stop] <> CR) and (Stop <= Length(Msg)) do
            Stop := Stop + 1;
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TFingerDemoForm.QueryButtonClick(Sender: TObject);
begin
    DisplayMemo.Clear;
    QueryButton.Enabled  := FALSE;
    CancelButton.Enabled := TRUE;
    FingerCli1.Query     := QueryEdit.Text;
    FingerCli1.StartQuery;
    MemoAddLines(DisplayMemo, 'Query started.' + #13);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TFingerDemoForm.FingerCli1SessionConnected(Sender: TObject; Error: Word);
begin
    if Error = 0 then
        MemoAddLines(DisplayMemo, 'Connected to host.' + #13);
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TFingerDemoForm.FingerCli1DataAvailable(Sender: TObject; Error: Word);
var
    Buffer : array [0..BufferSize - 1] of char;
    Len    : Integer;
begin
    while TRUE do begin
        Len := FingerCli1.Receive(@Buffer, SizeOf(Buffer) - 1);
        if Len <= 0 then
            break;
        Buffer[Len] := #0;
        MemoAddLines(DisplayMemo, StrPas(Buffer));
    end;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TFingerDemoForm.FingerCli1QueryDone(Sender: TObject; Error: Word);
begin
    if Error <> 0 then begin
        if Error = WSAECONNREFUSED then
            MemoAddLines(DisplayMemo, 'No finger service available.' + #13)
        else if Error = WSAETIMEDOUT then
            MemoAddLines(DisplayMemo, 'Host unreachable.' + #13)
        else
            MemoAddLines(DisplayMemo, 'Error #' + IntToStr(Error) + #13);
    end;
    MemoAddLines(DisplayMemo, 'Done.' + #13);

    QueryButton.Enabled  := TRUE;
    CancelButton.Enabled := FALSE;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}
procedure TFingerDemoForm.CancelButtonClick(Sender: TObject);
begin
    FingerCli1.Abort;
end;


{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

end.

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

