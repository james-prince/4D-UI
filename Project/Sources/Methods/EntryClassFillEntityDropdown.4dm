//%attributes = {"lang":"en"}
#DECLARE($EntityDropDownName : Text; $FormObject : Object)

var $ExistingIndex : Variant
$ExistingIndex:=$FormObject[$EntityDropDownName+"Object"].index

var $Entity; $CurrentEntity : Variant
$CurrentEntity:=$FormObject[$EntityDropDownName+"DataSourceFormula"]()

var $index; $SelectedItem : Integer
var $ValuesCollection : Collection
$ValuesCollection:=New collection
$SelectedItem:=-1
For each ($Entity; Formula from string(Replace string($FormObject[$EntityDropDownName+"EntitySelectionFormula"].source; "Form."; "This.")).call($FormObject) || New collection)
	//$ValuesCollection.push($Entity[$DisplayProperty])
	var $DisplayFormula : 4D.Function
	$DisplayFormula:=$FormObject[$EntityDropDownName+"DisplayFormula"]
	
	//SetProcessDebugInfo(New collection($Entity.getKey(); $Entity.getDataClass().getInfo(); $DisplayFormula.source))
	
	var $ErrorHandler:=cs.ErrorHandler.new(True)
	var $DisplayFormulaValue : Text:=$DisplayFormula.call($Entity)
	$ErrorHandler.stop()
	
	//SetProcessDebugInfo()
	
	$ValuesCollection.push($ErrorHandler.ErrorOccured ? "ERROR: PK-"+String($Entity.getKey()) : $DisplayFormulaValue)
	If ($CurrentEntity#Null) && ($Entity.getKey()=$CurrentEntity.getKey())
		$SelectedItem:=$index
	End if 
	$index+=1
End for each 



$FormObject[$EntityDropDownName+"Object"]:=\
New object("values"; $ValuesCollection; "index"; $SelectedItem)

If ($ExistingIndex#Null) && ($ExistingIndex#$FormObject[$EntityDropDownName+"Object"].index)
	EntryClassEntryObject($EntityDropDownName)
End if 