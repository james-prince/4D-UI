//%attributes = {"lang":"en"}
#DECLARE($ObjectName : Text)
$ObjectName:=Count parameters>=1 ? $ObjectName : OBJECT Get name(Object current)

var $EntitySelection : 4D.EntitySelection
$EntitySelection:=Form[$ObjectName+"EntitySelectionFormula"]()

var $index : Integer
$index:=Form[$ObjectName+"Object"].index

Formula from string(Form[$ObjectName+"DataSourceFormula"].source+":=$1").call(Form; $EntitySelection[$index])

EntryClassEntryObject($ObjectName)
EntryClassValidate