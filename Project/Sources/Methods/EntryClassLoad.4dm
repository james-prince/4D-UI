//%attributes = {"lang":"en"}
Case of 
	: (Form event code=On Load)
		EntryClassMandatoryCheck
		
		var $Object : Object
		For each ($Object; Form._AutoSizeFormObjectCollection)
			cs.FormObject.new($Object.Name).setMaxFontSize($Object.MultiLine)
		End for each 
		
End case 
