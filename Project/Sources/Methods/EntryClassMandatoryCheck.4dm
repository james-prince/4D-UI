//%attributes = {"lang":"en"}
#DECLARE($DisplayAlert : Boolean) : Boolean

var $ColorExpressionObject : Object
For each ($ColorExpressionObject; Form._ColorExpressionCollection)
	var $Color : Variant
	$Color:=$ColorExpressionObject.Formula.call($ColorExpressionObject.Object)
	If ($Color#Null)
		OBJECT SET RGB COLORS(*; $ColorExpressionObject.Name; Foreground color; $Color)
	End if 
End for each 

var $MandatoryCollection : Collection
$MandatoryCollection:=Form._MandatoryCollection

var $Colors : cs.Color
$Colors:=cs.Color.new()

var $FirstEmptyObjectName : Text
$FirstEmptyObjectName:=""

var $Object : Object
For each ($Object; $MandatoryCollection)
	
	var $PropertyIsEmpty : Boolean
	$PropertyIsEmpty:=$Object.DataSourceFormula.call(Form)=$Object.EmptyValue
	
	
	
	$FirstEmptyObjectName:=\
		(($FirstEmptyObjectName="") && ($PropertyIsEmpty)) ? $Object.EntryObjectName : $FirstEmptyObjectName
	
	//If ($Object.LabelObjectName#Null)
	//OBJECT SET RGB COLORS(*; $Object.LabelObjectName; $PropertyIsEmpty ? $Colors.Red : $Colors.Black)
	//End if 
	OBJECT SET RGB COLORS(*; $Object.EntryObjectName; Foreground color; ($PropertyIsEmpty ? $Colors.Amber : $Colors.White))
End for each 

OBJECT SET ENABLED(*; "AcceptButton"; $FirstEmptyObjectName="")

If ($DisplayAlert) && ($FirstEmptyObjectName#"")
	ALERT("Not all required fields have been entered")
	GOTO OBJECT(*; $FirstEmptyObjectName)
	return False
End if 
return True