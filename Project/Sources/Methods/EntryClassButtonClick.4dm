//%attributes = {}
var $ConfirmFormulaObject : Object
$ConfirmFormulaObject:=Form._ButtonConfirmFormulaCollection.query("Name=:1"; OBJECT Get name(Object current)).first()

If ($ConfirmFormulaObject#Null) && ($ConfirmFormulaObject.Formula.call(Form)=False)
	return 
End if 


var $FormulaObject : Object
For each ($FormulaObject; Form._ButtonClickFormulaCollection.query("Name=:1"; OBJECT Get name(Object current)))
	$FormulaObject.Formula.call(Form)
End for each 


EntryClassEntryObject