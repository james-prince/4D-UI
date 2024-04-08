property _AlternatingColor; _FirstAlternatingColor; _SecondAlternatingColor : Integer

Class constructor()
	
Function AlternatingColors($FirstColor : Integer; $SecondColor : Integer) : Integer
	If (This._AlternatingColor=Null)
		This._FirstAlternatingColor:=This.LightGreen  //This.LightGreen
		This._SecondAlternatingColor:=This.LightGray  //  This.LightBlue
		This._AlternatingColor:=This._SecondAlternatingColor
	End if 
	
	Case of 
		: (Count parameters>=1)
			This._FirstAlternatingColor:=$FirstColor
		: (Count parameters>=2)
			This._FirstAlternatingColor:=$FirstColor
			This._SecondAlternatingColor:=$SecondColor
	End case 
	
	This._AlternatingColor:=\
		This._AlternatingColor=This._SecondAlternatingColor ? \
		This._FirstAlternatingColor : This._SecondAlternatingColor
	return This._AlternatingColor
	
Function fromRGB($Red : Integer; $Green : Integer; $Blue : Integer) : Integer
	return ($Red << 16)+($Green << 8)+$Blue
	
Function toHex($ColorInteger : Integer)->$HexColor : Text
	$HexColor:=Substring(String($ColorInteger; "&x"); 3)
	$HexColor:="#"+Substring("00"+$HexColor; Length($HexColor)-3)
	
Function fromHSL($Hue : Real; $Saturation : Real; $Lightness : Real) : Integer
	var $Red; $Green; $Blue : Integer
	
	$Saturation:=$Saturation/100
	$Lightness:=$Lightness/100
	
	var $r1; $g1; $b1; $q; $p; $HuePercent; $tr; $tg; $tb : Real
	
	
	If ($Saturation=0)
		$r1:=$Lightness
		$g1:=$Lightness
		$b1:=$Lightness
	Else 
		$q:=$Lightness<0.5 ? $Lightness*(1+$Saturation) : $Lightness+$Saturation-($Lightness*$Saturation)
		$p:=(2*$Lightness)-$q
		$HuePercent:=$Hue/360
		$tr:=$HuePercent+(1/3)
		$tg:=$HuePercent
		$tb:=$HuePercent-(1/3)
		$tr:=$tr<0 ? $tr+1 : ($tr>1 ? $tr-1 : $tr)
		$tg:=$tg<0 ? $tg+1 : ($tg>1 ? $tg-1 : $tg)
		$tb:=$tb<0 ? $tb+1 : ($tb>1 ? $tb-1 : $tb)
		
		$r1:=This._util_getRGB($tr; $p; $q)
		$g1:=This._util_getRGB($tg; $p; $q)
		$b1:=This._util_getRGB($tb; $p; $q)
	End if 
	
	$Red:=$r1*255
	$Green:=$g1*255
	$Blue:=$b1*255
	
	return This.fromRGB($Red; $Green; $Blue)
	
Function _util_getRGB($trgb : Integer; $p : Integer; $q : Integer)->$rgbval : Integer
	Case of 
		: ($trgb<(1/6))
			$rgbval:=$p+(($q-$p)*6*$trgb)
		: ($trgb<0.5)
			$rgbval:=$q
		: ($trgb<(2/3))
			$rgbval:=$p+(($q-$p)*6*((2/3)-$trgb))
		Else 
			$rgbval:=$p
	End case 
	
	
	
	
	//MARK:______Custom Colors___________
Function get Amber : Integer
	return This.fromRGB(255; 230; 160)
	
Function get PastelGreen : Integer
	return This.fromRGB(186; 255; 201)
	
Function get PastelRed : Integer
	return This.fromRGB(255; 179; 186)
	
	//MARK:_____.NET Named Colors________
Function get AliceBlue : Integer
	return This.fromRGB(240; 248; 255)
	
Function get AntiqueWhite : Integer
	return This.fromRGB(250; 235; 215)
	
Function get Aqua : Integer
	return This.fromRGB(0; 255; 255)
	
Function get AquaMarine : Integer
	return This.fromRGB(127; 255; 212)
	
Function get Azure : Integer
	return This.fromRGB(240; 255; 255)
	
Function get Beige : Integer
	return This.fromRGB(245; 245; 220)
	
Function get Bisque : Integer
	return This.fromRGB(255; 228; 196)
	
Function get Black : Integer
	return This.fromRGB(0; 0; 0)
	
Function get BlanchedAlmond : Integer
	return This.fromRGB(255; 235; 205)
	
Function get Blue : Integer
	return This.fromRGB(0; 0; 255)
	
Function get BlueViolet : Integer
	return This.fromRGB(138; 43; 226)
	
Function get BurlyWood : Integer
	return This.fromRGB(222; 184; 135)
	
Function get CadetBlue : Integer
	return This.fromRGB(95; 158; 160)
	
Function get Chartreuse : Integer
	return This.fromRGB(127; 255; 0)
	
Function get Chocolate : Integer
	return This.fromRGB(210; 105; 30)
	
Function get Coral : Integer
	return This.fromRGB(255; 127; 80)
	
Function get CornflowerBlue : Integer
	return This.fromRGB(100; 149; 237)
	
Function get Cornsilk : Integer
	return This.fromRGB(255; 248; 220)
	
Function get Crimson : Integer
	return This.fromRGB(220; 20; 60)
	
Function get Cyan : Integer
	return This.fromRGB(0; 255; 255)
	
Function get DarkBlue : Integer
	return This.fromRGB(0; 0; 139)
	
Function get DarkCyan : Integer
	return This.fromRGB(0; 139; 139)
	
Function get DarkGoldenRod : Integer
	return This.fromRGB(184; 134; 11)
	
Function get DarkGray : Integer
	return This.fromRGB(169; 169; 169)
	
Function get DarkGreen : Integer
	return This.fromRGB(0; 100; 0)
	
Function get DarkKhaki : Integer
	return This.fromRGB(189; 183; 107)
	
Function get DarkMagenta : Integer
	return This.fromRGB(139; 0; 139)
	
Function get DarkOliveGreen : Integer
	return This.fromRGB(85; 107; 47)
	
Function get DarkOrange : Integer
	return This.fromRGB(255; 140; 0)
	
Function get DarkOrchid : Integer
	return This.fromRGB(153; 50; 204)
	
Function get DarkRed : Integer
	return This.fromRGB(139; 0; 0)
	
Function get DarkSalmon : Integer
	return This.fromRGB(233; 150; 122)
	
Function get DarkSeaGreen : Integer
	return This.fromRGB(143; 188; 139)
	
Function get DarkSlateBlue : Integer
	return This.fromRGB(72; 61; 139)
	
Function get DarkSlateGray : Integer
	return This.fromRGB(47; 79; 79)
	
Function get DeepPink : Integer
	return This.fromRGB(255; 20; 147)
	
Function get DarkTurquoise : Integer
	return This.fromRGB(0; 206; 209)
	
Function get DarkViolet : Integer
	return This.fromRGB(148; 0; 211)
	
Function get DeepSkyBlue : Integer
	return This.fromRGB(0; 191; 255)
	
Function get DimGray : Integer
	return This.fromRGB(105; 105; 105)
	
Function get DodgerBlue : Integer
	return This.fromRGB(30; 144; 255)
	
Function get FireBrick : Integer
	return This.fromRGB(178; 34; 34)
	
Function get FloralWhite : Integer
	return This.fromRGB(255; 250; 240)
	
Function get ForestGreen : Integer
	return This.fromRGB(34; 139; 34)
	
Function get Fuchsia : Integer
	return This.fromRGB(255; 0; 255)
	
Function get Gainsboro : Integer
	return This.fromRGB(220; 220; 220)
	
Function get GhostWhite : Integer
	return This.fromRGB(248; 248; 255)
	
Function get Gold : Integer
	return This.fromRGB(255; 215; 0)
	
Function get Goldenrod : Integer
	return This.fromRGB(218; 165; 32)
	
Function get Gray : Integer
	return This.fromRGB(128; 128; 128)
	
Function get Green : Integer
	return This.fromRGB(0; 128; 0)
	
Function get GreenYellow : Integer
	return This.fromRGB(173; 255; 47)
	
Function get HoneyDew : Integer
	return This.fromRGB(240; 255; 240)
	
Function get HotPink : Integer
	return This.fromRGB(255; 105; 180)
	
Function get IndianRed : Integer
	return This.fromRGB(205; 92; 92)
	
Function get Indigo : Integer
	return This.fromRGB(75; 0; 130)
	
Function get Ivory : Integer
	return This.fromRGB(255; 255; 240)
	
Function get Khaki : Integer
	return This.fromRGB(240; 230; 140)
	
Function get Lavender : Integer
	return This.fromRGB(230; 230; 250)
	
Function get LavenderBlush : Integer
	return This.fromRGB(255; 240; 245)
	
Function get LawnGreen : Integer
	return This.fromRGB(124; 252; 0)
	
Function get LemonChiffon : Integer
	return This.fromRGB(255; 250; 205)
	
Function get LightBlue : Integer
	return This.fromRGB(173; 216; 230)
	
Function get LightCoral : Integer
	return This.fromRGB(240; 128; 128)
	
Function get LightCyan : Integer
	return This.fromRGB(224; 255; 255)
	
Function get LightGoldenrodYellow : Integer
	return This.fromRGB(250; 250; 210)
	
Function get LightGray : Integer
	return This.fromRGB(211; 211; 211)
	
Function get LightGreen : Integer
	return This.fromRGB(144; 238; 144)
	
Function get LightPink : Integer
	return This.fromRGB(255; 182; 193)
	
Function get LightSalmon : Integer
	return This.fromRGB(255; 160; 122)
	
Function get LightSeaGreen : Integer
	return This.fromRGB(32; 178; 170)
	
Function get LightSkyBlue : Integer
	return This.fromRGB(135; 206; 250)
	
Function get LightSlateGray : Integer
	return This.fromRGB(119; 136; 153)
	
Function get LightSteelBlue : Integer
	return This.fromRGB(176; 196; 222)
	
Function get LightYellow : Integer
	return This.fromRGB(255; 255; 224)
	
Function get Lime : Integer
	return This.fromRGB(0; 255; 0)
	
Function get LimeGreen : Integer
	return This.fromRGB(50; 205; 50)
	
Function get Linen : Integer
	return This.fromRGB(250; 240; 230)
	
Function get Magenta : Integer
	return This.fromRGB(255; 0; 255)
	
Function get Maroon : Integer
	return This.fromRGB(128; 0; 0)
	
Function get MediumAquamarine : Integer
	return This.fromRGB(102; 205; 170)
	
Function get MediumBlue : Integer
	return This.fromRGB(0; 0; 205)
	
Function get MediumOrchid : Integer
	return This.fromRGB(186; 85; 211)
	
Function get MediumPurple : Integer
	return This.fromRGB(147; 112; 219)
	
Function get MediumSeaGreen : Integer
	return This.fromRGB(60; 179; 113)
	
Function get MediumSpringGreen : Integer
	return This.fromRGB(0; 250; 154)
	
Function get MediumSlateBlue : Integer
	return This.fromRGB(123; 104; 238)
	
Function get MediumTurquoise : Integer
	return This.fromRGB(72; 209; 204)
	
Function get MediumVioletRed : Integer
	return This.fromRGB(199; 21; 133)
	
Function get MidnightBlue : Integer
	return This.fromRGB(25; 25; 112)
	
Function get MintCream : Integer
	return This.fromRGB(245; 255; 250)
	
Function get MistyRose : Integer
	return This.fromRGB(255; 228; 225)
	
Function get Moccasin : Integer
	return This.fromRGB(255; 228; 181)
	
Function get NavajoWhite : Integer
	return This.fromRGB(255; 222; 173)
	
Function get Navy : Integer
	return This.fromRGB(0; 0; 128)
	
Function get OldLace : Integer
	return This.fromRGB(253; 245; 230)
	
Function get Olive : Integer
	return This.fromRGB(128; 128; 0)
	
Function get OliveDrab : Integer
	return This.fromRGB(107; 142; 35)
	
Function get Orange : Integer
	return This.fromRGB(255; 165; 0)
	
Function get OrangeRed : Integer
	return This.fromRGB(255; 69; 0)
	
Function get Orchid : Integer
	return This.fromRGB(218; 112; 214)
	
Function get PaleGoldenRod : Integer
	return This.fromRGB(238; 232; 170)
	
Function get PaleGreen : Integer
	return This.fromRGB(152; 251; 152)
	
Function get PaleTurquoise : Integer
	return This.fromRGB(175; 238; 238)
	
Function get PaleVioletRed : Integer
	return This.fromRGB(219; 112; 147)
	
Function get PapayaWhip : Integer
	return This.fromRGB(255; 239; 213)
	
Function get PeachPuff : Integer
	return This.fromRGB(255; 218; 185)
	
Function get Peru : Integer
	return This.fromRGB(205; 133; 63)
	
Function get Pink : Integer
	return This.fromRGB(255; 192; 203)
	
Function get Plum : Integer
	return This.fromRGB(221; 160; 221)
	
Function get PowderBlue : Integer
	return This.fromRGB(176; 224; 230)
	
Function get Purple : Integer
	return This.fromRGB(128; 0; 128)
	
Function get Red : Integer
	return This.fromRGB(255; 0; 0)
	
Function get RosyBrown : Integer
	//test
	return This.fromRGB(188; 143; 143)
	
Function get RoyalBlue : Integer
	return This.fromRGB(65; 105; 225)
	
Function get SaddleBrown : Integer
	return This.fromRGB(139; 69; 19)
	
Function get Salmon : Integer
	return This.fromRGB(250; 128; 114)
	
Function get SandyBrown : Integer
	return This.fromRGB(244; 164; 96)
	
Function get SeaGreen : Integer
	return This.fromRGB(46; 139; 87)
	
Function get SeaShell : Integer
	return This.fromRGB(255; 245; 238)
	
Function get Sienna : Integer
	return This.fromRGB(160; 82; 45)
	
Function get Silver : Integer
	return This.fromRGB(192; 192; 192)
	
Function get SkyBlue : Integer
	return This.fromRGB(135; 206; 235)
	
Function get SlateBlue : Integer
	return This.fromRGB(106; 90; 205)
	
Function get SlateGray : Integer
	return This.fromRGB(112; 128; 144)
	
Function get Snow : Integer
	return This.fromRGB(255; 250; 250)
	
Function get SpringGreen : Integer
	return This.fromRGB(0; 255; 127)
	
Function get SteelBlue : Integer
	return This.fromRGB(70; 130; 180)
	
Function get Tan : Integer
	return This.fromRGB(210; 180; 140)
	
Function get Teal : Integer
	return This.fromRGB(0; 128; 128)
	
Function get Thistle : Integer
	return This.fromRGB(216; 191; 216)
	
Function get Tomato : Integer
	return This.fromRGB(255; 99; 71)
	
Function get Turquoise : Integer
	return This.fromRGB(64; 224; 208)
	
Function get Violet : Integer
	return This.fromRGB(238; 130; 238)
	
Function get Wheat : Integer
	return This.fromRGB(245; 222; 179)
	
Function get White : Integer
	return This.fromRGB(255; 255; 255)
	
Function get WhiteSmoke : Integer
	return This.fromRGB(245; 245; 245)
	
Function get Yellow : Integer
	return This.fromRGB(255; 255; 0)
	
Function get YellowGreen : Integer
	return This.fromRGB(154; 205; 50)