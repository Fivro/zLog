�
 TFRMPASCALDEMO 0I  TPF0TFrmPascalDemoFrmPascalDemoLeft� TopjBorderStylebsSingleCaptionPascal DemoClientHeight�ClientWidth�
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterPixelsPerInch`
TextHeight TLabelLabel13LeftTopuWidthhHeightCaptionFile to load data from :
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  
TColorMemo
ColorMemo1Left Top Width�HeightqAlignalTopLines.Stringsunit cm_main;{ This is a comment }	interface uses:  Windows, Messages, SysUtils, Classes, Graphics, ColMemo; type  TForm1 = class(TForm)    ColorMemo1: TColorMemo;*    procedure FormCreate(Sender: TObject);	  private    { Private declarations }    procedure LoadIt;  public    { Public declarations }  end; var  Form1: TForm1; implementation 
{$R *.DFM} 0procedure TForm1.cbxTypeChange(Sender: TObject);begin     Case cbxType.ItemIndex of          0: begin5               ColorMemo1.KeyDrawingType:=dtBeginEnd;+               ColorMemo1.KeyColor:=clBlue;D               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clBlue');             end;          1: begin4               ColorMemo1.KeyDrawingType:=dtKeyShow;*               ColorMemo1.KeyColor:=clRed;C               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clRed');             end;          2: begin6               ColorMemo1.KeyDrawingType:=dtEventDraw;+               ColorMemo1.KeyColor:=clAqua;D               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clAqua');             end; 	     end;(     Notebook1.ActivePage:=cbxType.Text;     ColorMemo1.Refresh;end; -procedure TForm1.FormCreate(Sender: TObject);begin  // Commentend; procedure TForm1.LoadIt;begin     try2        ColorMemo1.Lines.LoadFromFile('Test.pas');     except	     end;end; end.  
ScrollBarsssBothTabOrder WantTabs	
ColorRulesKeywords.Stringsandexportsmodshrarrayfilenilstringasfinalizationnotstringresourceasmfinallyobjectthenforof	threadvarcasefunctionortoclassgotoouttryconstifpackedtypeconstructorimplementation	procedureunit
destructorinprogramuntildispinterface	inheritedpropertyusesdivinitializationraisevardoinlinerecordwhiledownto	interfacerepeatwithelseisresourcestringxorendlabelset	exceptlibraryshlprivatepublic	published	protected KeyDrawingType	dtKeyShowDefKeyColorclMaroon ZOrderKeyBegEndLst.Strings{;};{*;*};silver DefKeyColorclGray ZOrderKeyLineEndLst.Strings//;gray KeyDrawingTypedtBeginLineEnd ZOrderKeyBegEndLst.Strings
{$;};green';';red     TEditeFileLeftTop�WidthHeight
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderTextFrom Memory  TButtonbtnFileLeftTop�WidthHeightCaption?TabOrderOnClickbtnFileClick  TOpenDialogODlg
DefaultExt*.*FileEditStylefsEditFilterAll Files ( *.* )|*.*TitleSelect a fileLeft Top�   