�
 TSMTPTESTFORM 0�  TPF0TSmtpTestFormSmtpTestFormLeft�Top� WidthIHeight�Caption	SMTP Test
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`
TextHeight TLabelLabel1LeftTopWidth7HeightCaption	SMTP Host  TLabelLabel2LeftTop WidthHeightCaptionFrom  TLabelLabel3Left� Top WidthHeightCaptionTo  TLabelSubjectLeftTop8Width$HeightCaptionSubject  TWaitWait1LeftTopWidthaHeightCaption60ModalResult Interval�	IsControl	  TMemoMsgMemoLeft TopNWidthAHeightxAlignalBottomLines.StringsCeci est la premi�re ligne.Et puis vient la seconde !La suivante n'a qu'un seul point..Enfin la derni�re 
ScrollBarsssBothTabOrder  TMemoDisplayMemoLeft Top� WidthAHeight� AlignalBottomLines.StringsDisplayMemo 
ScrollBarsssBothTabOrder  TEditHostEditLeftXTop WidthyHeightTabOrderText	localhost  TEditFromEditLeftXTopWidthyHeightTabOrderTextfirst.last@company.com  TEditToEditLeft TopWidthyHeightTabOrderTextjohn.doe@acme  TButtonConnectButtonLeft�TopWidthKHeightCaption&ConnectTabOrderOnClickConnectButtonClick  TButton
MailButtonLeft�TopWidthKHeightCaption&MailTabOrderOnClickMailButtonClick  TEditSubjectEditLeftXTop0WidthyHeightTabOrderTextLe sujet du message  TButtonDisconnectButtonLeft�Top0WidthKHeightCaption
DisconnectTabOrder	OnClickDisconnectButtonClick  TEdit
SignOnEditLeft Top0WidthyHeightTabOrder
Text
SignOnEdit  TSmtpClient
SmtpClientTag WaitWait1TimeOut	OnDisplaySmtpClientDisplay	OnGetDataSmtpClientGetDataOnHeaderLineSmtpClientHeaderLineLeft� TopX   