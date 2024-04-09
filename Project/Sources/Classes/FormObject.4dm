property Name : Text

Class constructor($FormObjectName : Text)
	$FormObjectName:=$FormObjectName || OBJECT Get name(Object current)
	
	//var $FormObjectExists : Boolean
	//$FormObjectExists:=Is nil pointer(OBJECT Get pointer(Object named; $FormObjectName))=False
	//ASSERT($FormObjectExists)
	
	This.Name:=$FormObjectName
	
	
Function get Title : Text
	return OBJECT Get title(*; This.Name)
Function set Title($Title : Text)
	OBJECT SET TITLE(*; This.Name; $Title)
	
Function get MinimumValue()->$MinimumValue : Variant
	OBJECT GET MINIMUM VALUE(*; This.Name; $MinimumValue)
Function set MinimumValue($MinimumValue : Variant)
	OBJECT SET MINIMUM VALUE(*; This.Name; $MinimumValue)
	
Function get MaximumValue()->$MaximumValue : Variant
	OBJECT GET MAXIMUM VALUE(*; This.Name; $MaximumValue)
Function set MaximumValue($MaximumValue : Variant)
	OBJECT SET MAXIMUM VALUE(*; This.Name; $MaximumValue)
	
Function get Visible : Boolean
	return OBJECT Get visible(*; This.Name)
Function set Visible($Visible : Boolean)
	OBJECT SET VISIBLE(*; This.Name; $Visible)
	
Function get Enterable : Boolean
	return OBJECT Get enterable(*; This.Name)
Function set Enterable($Enterable : Boolean)
	OBJECT SET ENTERABLE(*; This.Name; $Enterable)
	
Function get Enabled : Boolean
	return OBJECT Get enabled(*; This.Name)
Function set Enabled($Enabled : Boolean)
	OBJECT SET ENABLED(*; This.Name; $Enabled)
	
	
Function get ForegroundColor()->$ForegroundColor : Integer
	OBJECT GET RGB COLORS(*; This.Name; $ForegroundColor)
Function set ForegroundColor($ForegroundColor : Variant)
	OBJECT SET RGB COLORS(*; This.Name; $ForegroundColor || Foreground color)
	
Function get BackgroundColor()->$BackgroundColor : Integer
	var $ForegroundColor : Integer
	OBJECT GET RGB COLORS(*; This.Name; $ForegroundColor; $BackgroundColor)
Function set BackgroundColor($BackgroundColor : Variant)
	OBJECT SET RGB COLORS(*; This.Name; This.ForegroundColor; $BackgroundColor)
	
	
Function get Left()->$Left : Integer
	var $Top; $Right; $Bottom : Integer
	OBJECT GET COORDINATES(*; This.Name; $Left; $Top; $Right; $Bottom)
Function set Left($Left : Integer)
	OBJECT SET COORDINATES(*; This.Name; $Left; This.Top; This.Right; This.Bottom)
	
	
Function get Top()->$Top : Integer
	var $Left; $Right; $Bottom : Integer
	OBJECT GET COORDINATES(*; This.Name; $Left; $Top; $Right; $Bottom)
Function set Top($Top : Integer)
	OBJECT SET COORDINATES(*; This.Name; This.Left; $Top; This.Right; This.Bottom)
	
	
Function get Right()->$Right : Integer
	var $Left; $Top; $Bottom : Integer
	OBJECT GET COORDINATES(*; This.Name; $Left; $Top; $Right; $Bottom)
Function set Right($Right : Integer)
	OBJECT SET COORDINATES(*; This.Name; This.Left; This.Top; $Right; This.Bottom)
	
	
Function get Bottom()->$Bottom : Integer
	var $Left; $Top; $Right : Integer
	OBJECT GET COORDINATES(*; This.Name; $Left; $Top; $Right; $Bottom)
Function set Bottom($Bottom : Integer)
	OBJECT SET COORDINATES(*; This.Name; This.Left; This.Top; This.Right; $Bottom)
	
Function get Width : Integer
	return This.Right-This.Left
Function set Width($Width : Integer)
	This.Right:=This.Left+$Width
	
Function get Height : Integer
	return This.Bottom-This.Top
Function set Height($Height : Integer)
	This.Bottom:=This.Top+$Height
	
	
	
	
	
Function setMaxFontSize($MultiLine : Boolean; $UpperFontSizeLimit : Integer)
	If (This.Visible=False)
		return 
	End if 
	
	var $BestWidth; $BestHeight : Integer
	
	Repeat 
		This.FontSize-=1
		If ($MultiLine)
			OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight; This.Width)
		Else 
			OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight)
		End if 
	Until ($BestWidth<=This.Width) && ($BestHeight<=This.Height)
	
	Repeat 
		This.FontSize+=1
		If ($MultiLine)
			OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight; This.Width)
		Else 
			OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight)
		End if 
	Until ($BestWidth>This.Width) || ($BestHeight>This.Height)
	
	This.FontSize-=1
	
	If ($UpperFontSizeLimit#0)
		This.FontSize:=(This.FontSize<$UpperFontSizeLimit) ? This.FontSize : $UpperFontSizeLimit
	End if 
	
	
	
Function setBestObjectSize($HeightOnly : Boolean)
	var $BestWidth; $BestHeight : Integer
	If ($HeightOnly)
		OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight; This.Width)
	Else 
		OBJECT GET BEST SIZE(*; This.Name; $BestWidth; $BestHeight)
	End if 
	This.Width:=$HeightOnly ? This.Width : $BestWidth
	This.Height:=$BestHeight
	
	
	
Function get Font : Text
	return OBJECT Get font(*; This.Name)
Function set Font($Font : Text)
	OBJECT SET FONT(*; This.Name; $Font)
	
Function get FontSize : Integer
	return OBJECT Get font size(*; This.Name)
Function set FontSize($FontSize : Integer)
	OBJECT SET FONT SIZE(*; This.Name; $FontSize)
	
Function get Bold : Boolean
	return OBJECT Get font style(*; This.Name) ?? 0
Function set Bold($Bold : Boolean)
	OBJECT SET FONT STYLE(*; This.Name; ($Bold ? Bold : 0)+(This.Italic ? Italic : 0)+(This.Underline ? Underline : 0))
	
Function get Italic : Boolean
	return OBJECT Get font style(*; This.Name) ?? 1
Function set Italic($Italic : Boolean)
	OBJECT SET FONT STYLE(*; This.Name; (This.Bold ? Bold : 0)+($Italic ? Italic : 0)+(This.Underline ? Underline : 0))
	
Function get Underline : Boolean
	return OBJECT Get font style(*; This.Name) ?? 2
Function set Underline($Underline : Boolean)
	OBJECT SET FONT STYLE(*; This.Name; (This.Bold ? Bold : 0)+(This.Italic ? Italic : 0)+($Underline ? Underline : 0))
	
Function get DisplayFormat : Text
	return OBJECT Get format(*; This.Name)
Function set DisplayFormat($DisplayFormat : Variant)
	$DisplayFormat:=Value type($DisplayFormat)=Is integer ? Char($DisplayFormat) : ($DisplayFormat || "")
	OBJECT SET FORMAT(*; This.Name; $DisplayFormat)
	
	
	
Function get Multiline : Boolean
	return OBJECT Get multiline(*; This.Name)=Multiline Yes
Function set Multiline($Multiline : Boolean)
	OBJECT SET MULTILINE(*; This.Name; $Multiline ? Multiline Yes : Multiline Auto)
	
	
	
Function get PlaceholderText : Text
	return OBJECT Get placeholder(*; This.Name)
Function set PlaceholderText($PlaceholderText : Text)
	OBJECT SET PLACEHOLDER(*; This.Name; $PlaceholderText)
	
	
	
	
	
Function get VerticalScrollPosition()->$VerticalScrollPosition : Integer
	var $HorizontalScrollPosition : Integer
	OBJECT GET SCROLL POSITION(*; This.Name; $VerticalScrollPosition; $HorizontalScrollPosition)
Function set VerticalScrollPosition($VerticalScrollPosition : Integer)
	OBJECT SET SCROLL POSITION(*; This.Name; $VerticalScrollPosition; This.HorizontalScrollPosition)
	
Function get HorizontalScrollPosition()->$HorizontalScrollPosition : Integer
	var $VerticalScrollPosition : Integer
	OBJECT GET SCROLL POSITION(*; This.Name; $VerticalScrollPosition; $HorizontalScrollPosition)
Function set HorizontalScrollPosition($HorizontalScrollPosition : Integer)
	OBJECT SET SCROLL POSITION(*; This.Name; This.VerticalScrollPosition; $HorizontalScrollPosition)
	
	
	
Function get CornerRadius : Integer
	return OBJECT Get corner radius(*; This.Name)
Function set CornerRadius($CornerRadius : Integer)
	OBJECT SET CORNER RADIUS(*; This.Name; $CornerRadius)
	
	
Function get HelpTip : Text
	return OBJECT Get help tip(*; This.Name)
Function set HelpTip($HelpTip : Text)
	OBJECT SET HELP TIP(*; This.Name; $HelpTip)
	
	
Function get Pointer : Pointer
	return OBJECT Get pointer(Object named; This.Name)
Function get HasFocus : Boolean
	return OBJECT Get pointer(Object with focus)=This.Pointer
	
Function Focus()
	GOTO OBJECT(*; This.Name)
Function HighlightText($StartPosition : Integer; $EndPosition : Integer)
	HIGHLIGHT TEXT(*; This.Name; $StartPosition; $EndPosition)
	