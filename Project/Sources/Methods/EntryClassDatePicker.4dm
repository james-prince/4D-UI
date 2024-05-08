//%attributes = {"lang":"en"}
var $Date:=Form[OBJECT Get name(Object current)+"Formula"]()

var $NewDate:=UI.selectDate($Date)

If ($NewDate#!00-00-00!)
	var $Formula : 4D.Function
	$Formula:=Form[OBJECT Get name(Object current)+"Formula"]
	Formula from string($Formula.source+":=$1").call(Form; $NewDate)
End if 

EntryClassEntryObject
//EntryClassMandatoryCheck