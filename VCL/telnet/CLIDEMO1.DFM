�
 TCLIENTFORM 0{  TPF0TClientForm
ClientFormLeft�Top� Width9HeightCaptionClient
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PixelsPerInch`OnClose	FormCloseOnShowFormShow
TextHeight TMemoDisplayMemoLeft TopiWidth1Height� AlignalClientLines.StringsDisplayMemo 
ScrollBarsssBothTabOrder   TPanelPanel1Left Top Width1HeightiAlignalTopTabOrder TLabel	LineLabelLeftTop0Width.HeightCaption	LineLabel  TLabelLabel1LeftTopWidthHeightCaptionPort  TLabelLabel2LefthTopWidthHeightCaptionServer  TEditSendEditLeftTopHWidth� HeightTabOrder TextSendEdit  TButton
SendButtonLeft� TopHWidthKHeightCaption&SendDefault	TabOrderOnClickSendButtonClick  TButtonDisconnectButtonLeft� Top(WidthKHeightCaption
DisconnectEnabledTabOrderOnClickDisconnectButtonClick  TEditPortEditLeft TopWidthAHeightTabOrderTexttelnet  TEdit
ServerEditLeft� TopWidthAHeightTabOrderText	localhost  TWaitWait1Left� TopWidthIHeightCaption60ModalResult Interval�Visible	IsControl	   TWSocket	CliSocketPrototcpOnDataAvailableCliSocketDataAvailableOnSessionClosedCliSocketSessionClosedOnSessionConnectedCliSocketSessionConnectedWaitCtrlWait1FlushTimeout<	SendFlagswsSendNormalLeft� Top�    