//%attributes = {"lang":"en"}
If (EntryClassMandatoryCheck(True)=False)
	return 
End if 

If (Form._KeyfobFormula#Null)
	FORM GOTO PAGE(2)
	return 
End if 

//If (Form._KeyfobFormula#Null)
//var $StaffEntity : cs.StaffEntity
//$StaffEntity:=ds.Staff.getUsingKeyfob(True)
//If ($StaffEntity=Null)
//return 
//End if 
//Form[Form._KeyfobFormula]:=$StaffEntity
//End if 

ACCEPT