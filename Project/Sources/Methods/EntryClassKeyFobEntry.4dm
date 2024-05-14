//%attributes = {"lang":"en"}
//TODO: Replace ds["Staff"] with non specific function
var $StaffEntity : 4D.Entity
$StaffEntity:=ds["Staff"].getUsingKeyfob(True; Form["_KeyFob"])

If ($StaffEntity#Null)
	Formula from string(Form._KeyfobFormula.source+":=$1").call(Form; $StaffEntity)
	ACCEPT
Else 
	Form["_KeyFob"]:=""
	GOTO OBJECT(*; "KeyFobInput")
End if 

