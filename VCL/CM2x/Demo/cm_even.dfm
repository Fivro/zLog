�
 TFRMEVENTSDEMO 0E  TPF0TFrmEventsDemoFrmEventsDemoLeft� TopmBorderStylebsSingleCaptionEvents DemoClientHeight^ClientWidth�Font.CharsetSHIFTJIS_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel13LeftTop<WidthWHeight	CaptionFile to load data from :Font.CharsetSHIFTJIS_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  
TColorMemo
ColorMemo1Left Top Width$Height8Font.CharsetSHIFTJIS_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style ImeNameMS-IME97 ���{����ͼ���Lines.Stringsunit cm_main;{ This is a comment }	interface uses:  Windows, Messages, SysUtils, Classes, Graphics, ColMemo; type  TForm1 = class(TForm)    ColorMemo1: TColorMemo;*    procedure FormCreate(Sender: TObject);	  private    { Private declarations }    procedure LoadIt;  public    { Public declarations }  end; var  Form1: TForm1; implementation 
{$R *.DFM} 0procedure TForm1.cbxTypeChange(Sender: TObject);begin     Case cbxType.ItemIndex of          0: begin5               ColorMemo1.KeyDrawingType:=dtBeginEnd;+               ColorMemo1.KeyColor:=clBlue;D               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clBlue');             end;          1: begin4               ColorMemo1.KeyDrawingType:=dtKeyShow;*               ColorMemo1.KeyColor:=clRed;C               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clRed');             end;          2: begin6               ColorMemo1.KeyDrawingType:=dtEventDraw;+               ColorMemo1.KeyColor:=clAqua;D               cbxColor.ItemIndex:=cbxColor.Items.IndexOf('clAqua');             end; 	     end;(     Notebook1.ActivePage:=cbxType.Text;     ColorMemo1.Refresh;end; -procedure TForm1.FormCreate(Sender: TObject);begin  // Commentend; procedure TForm1.LoadIt;begin     try2        ColorMemo1.Lines.LoadFromFile('Test.pas');     except	     end;end; end.  
ParentFont
ScrollBarsssBothTabOrder WantTabs	OnDrawColorMemo1Draw	OnDrawKeyColorMemo1DrawKey
ColorRulesKeywords.Stringsbeginendandexportsmodshrarrayfilenilstringasfinalizationnotstringresourceasmfinallyobjectthenforof	threadvarcasefunctionortoclassgotoouttryconstifpackedtypeconstructorimplementation	procedureunit
destructorinprogramuntildispinterface	inheritedpropertyusesdivinitializationraisevardoinlinerecordwhiledownto	interfacerepeatwithelseisresourcestringxorendlabelset	exceptlibraryshlprivatepublic	published	protected KeyDrawingType	dtKeyShowDefKeyColorclMaroon ZOrderKeyBegEndLst.Strings{;};{*;*};silver DefKeyColorclGray ZOrderKeyLineEndLst.Strings//;gray KeyDrawingTypedtBeginLineEnd ZOrderKeyBegEndLst.Strings
{$;};green  ZOrderKeyDrawingTypedtEventDraw  ColorLimMaxd  TEditeFileLeftTopIWidth� HeightFont.CharsetSHIFTJIS_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style ImeNameMS-IME97 ���{����ͼ���
ParentFontTabOrderTextFrom Memory  TButtonbtnFileLeft� TopIWidthHeightCaption?TabOrderOnClickbtnFileClick  	TCheckBox
cbxDrawKeyLeft(TopWidthpHeightCaptionUse OnDrawKey EventState	cbCheckedTabOrderOnClickcbxDrawKeyClick  	TCheckBoxcbxDrawLeft*Top� WidthmHeightCaptionUse OnDraw EventState	cbCheckedTabOrderOnClickcbxDrawClick  	TGroupBoxgbxDrawLeft(Top� WidthqHeighttTabOrder TLabel	lblSearchLeftTop'WidthcHeightDAutoSizeCaption~If the feature above  is enabled then the word above should be drawn in blue as if we searched for it and then highlighted it.Font.CharsetSHIFTJIS_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontWordWrap	  TEditeSearchLeftTopWidthiHeightImeNameMS-IME97 ���{����ͼ���TabOrder Text	procedureOnExiteSearchExit
OnKeyPresseSearchKeyPress   TPanel
pnlDrawKeyLeft&TopWidthtHeight� 
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder TLabellblFontsLeftTopeWidthgHeightGAutoSizeCaption~For the feature above to work font must be set to proportional one. Use a dropdown bellow to change font and see what happens.Font.CharsetSHIFTJIS_CHARSET
Font.ColorclMaroonFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontWordWrap	  	TCheckBoxcbxBoldLeftTopWidthRHeightCaptionBoldTabOrder OnClick	cbxChange  	TCheckBox	cbxItalicLeftTopWidthRHeightCaptionItalicTabOrderOnClick	cbxChange  	TCheckBoxcbxUnderlineLeftTop-WidthRHeightCaption	UnderlineTabOrderOnClick	cbxChange  	TComboBoxcbxFontLeftTopKWidthlHeightImeNameMS-IME97 ���{����ͼ���
ItemHeightTabOrderTextCourier NewOnChangecbxFontChange   TOpenDialogODlg
DefaultExt*.*FilterAll Files ( *.* )|*.*TitleSelect a fileLeft Top�   