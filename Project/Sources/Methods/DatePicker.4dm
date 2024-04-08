//%attributes = {"shared":true}
#DECLARE($DefaultDate : Date; $CurrentObject : Boolean) : Date

If ($DefaultDate=!00-00-00!)
	$DefaultDate:=Current date
End if 

var $mouseX; $MouseY : Real

If ($CurrentObject)
	var $left; $top; $right; $bottom : Integer
	OBJECT GET COORDINATES(*; OBJECT Get name(Object current); $left; $top; $right; $bottom)
	$mouseX:=cs.Math.new().mean([$left; $right])
	$MouseY:=cs.Math.new().mean([$top; $bottom])
Else 
	var $mouseButton : Integer
	GET MOUSE($mouseX; $MouseY; $mouseButton)
End if 

return DatePicker Display Dialog($mouseX; $MouseY; $DefaultDate)