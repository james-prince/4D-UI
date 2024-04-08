//%attributes = {"lang":"en"}
var $DropDownName : Text
$DropDownName:=OBJECT Get name(Object current)

var $Collection : Collection
$Collection:=Form[$DropDownName+"Object"].values

var $index : Integer
$index:=Form[$DropDownName+"Object"].index

Formula from string(Form[$DropDownName+"DataSourceFormula"].source+":=$1").call(Form; $Collection[$index])

EntryClassEntryObject($DropDownName)

EntryClassMandatoryCheck
EntryClassValidate