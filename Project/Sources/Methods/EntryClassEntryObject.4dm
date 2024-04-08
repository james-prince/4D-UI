//%attributes = {"lang":"en"}
#DECLARE($ObjectName : Text)
$ObjectName:=Count parameters>=1 ? $ObjectName : OBJECT Get name(Object current)

Case of 
	: (Form event code=On After Edit)
		OBJECT SET VISIBLE(*; $ObjectName+".ValidateButton"; True)
		return 
		
	: (Form event code=On Data Change) || (Form event code=On Clicked)
		OBJECT SET VISIBLE(*; $ObjectName+".ValidateButton"; False)
		
		var $PropertyName; $EntityPropertyName : Text
		For each ($PropertyName; Form)
			If (Value type(Form[$PropertyName])=Is object) && (OB Instance of(Form[$PropertyName]; 4D.Entity))
				var $DataClass : 4D.DataClass
				$DataClass:=Form[$PropertyName].getDataClass()
				For each ($EntityPropertyName; Form[$PropertyName])
					If ($DataClass[$EntityPropertyName].kind="relatedEntity") || \
						($DataClass[$EntityPropertyName].kind="relatedEntities") || \
						($DataClass[$EntityPropertyName].readOnly)
						continue
					End if 
					Form[$PropertyName][$EntityPropertyName]:=Form[$PropertyName][$EntityPropertyName]
				End for each 
			End if 
		End for each 
		
		
		
		var $DataChangeFormulaObject : Object
		For each ($DataChangeFormulaObject; Form._DataChangeFormulaCollection)
			If ($DataChangeFormulaObject.Name=$ObjectName) || ($DataChangeFormulaObject.Name+".Button"=$ObjectName)
				SetProcessDebugInfo([$ObjectName; $DataChangeFormulaObject.Formula])
				$DataChangeFormulaObject.Formula.apply()
				SetProcessDebugInfo()
			End if 
		End for each 
		
		var $EntityDropDownName : Text
		For each ($EntityDropDownName; Form._EntityDropDownCollection)
			EntryClassFillEntityDropdown($EntityDropDownName; Form)
		End for each 
		
		EntryClassMandatoryCheck
		
End case 