unit PopTst2;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMessageForm = class(TForm)
    DisplayMemo: TMemo;
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  MessageForm: TMessageForm;

implementation

{$R *.DFM}

end.