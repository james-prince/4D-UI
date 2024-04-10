property stroke : Text
property fill : Text
property fontStyle : Text
property fontWeight : Text
property textDecoration : Text

Function set BackgroundColor($Color : Integer)
	This.fill:=This._ColorToHex($Color)
	
Function set ForegroundColor($Color : Integer)
	This.stroke:=This._ColorToHex($Color)
	
Function _ColorToHex($ColorInteger : Integer)->$HexColor : Text
	$HexColor:=Substring(String($ColorInteger; "&x"); 3)
	$HexColor:="#"+Substring("00"+$HexColor; Length($HexColor)-3)
	
	
Function set Italic($Italic : Boolean)
	This.fontStyle:=$Italic ? "italic" : "normal"
Function get Italic : Boolean
	return This.fontStyle="italic"
	
Function set Bold($Bold : Boolean)
	This.fontWeight:=$Bold ? "bold" : "normal"
Function get Bold : Boolean
	return This.fontWeight="bold"
	
Function set Underline($Underline : Boolean)
	This.textDecoration:=$Underline ? "underline" : "normal"
Function get Underline : Boolean
	return This.textDecoration="underline"