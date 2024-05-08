//%attributes = {"lang":"en"}
var $Formula : 4D.Function
$Formula:=Form[OBJECT Get name(Object current)+"Formula"]

Formula from string($Formula.source+":=$1").call(Form; UI.selectFile())


EntryClassMandatoryCheck