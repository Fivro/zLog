�
 TSERVERFORM 03  TPF0TServerForm
ServerFormLeftUTop�WidthHeight,Caption
ServerFormFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameSystem
Font.Style PositionpoDefaultPosOnly
OnActivateFormActivateOnCreate
FormCreateOnResize
FormResizePixelsPerInch`
TextHeight TLabel	PortLabelLeftTop� WidthHeightCaptionPort  TMemoMemoLeft Top WidthHeight� AlignalTopLines.StringsMemo ReadOnly	TabOrder   TButton
QuitButtonLeft�Top� WidthQHeightCancel	Caption&QuitTabOrderOnClickQuitButtonClick  TButtonAboutButtonLefthTop� WidthKHeightCaption&AboutTabOrderOnClickAboutButtonClick  TEditPortEditLeft8Top� Width1HeightTabOrderTexttelnet  TButtonChangePortButtonLeftxTop� WidthKHeightCaptionChangeTabOrderOnClickChangePortButtonClick  TWSocket	SrvSocketAddr0.0.0.0PorttelnetPrototcpOnSessionClosedSrvSocketSessionClosedOnSessionAvailableSrvSocketSessionAvailableFlushTimeout<	SendFlagswsSendNormalLeftTop    