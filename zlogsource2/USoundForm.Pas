unit USoundForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Audio;

type
  TSoundForm = class(TForm)
    WaveIn1: TWaveIn;
    WaveOut1: TWaveOut;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SoundForm: TSoundForm;

implementation

{$R *.DFM}

end.
