property _FormObject : Object
property _FormDataObject : Object
property _AllMandatory : Boolean
property ItemCount : Integer
property ItemHeight : Integer
property __EntryInputCollection : Collection

Class constructor($WindowTitle : Text; $TextDescription : Text; $AllMandatory : Boolean; $ItemWidth : Integer)
	var $Pages:=[\
		{objects: {}}; \
		{objects: {}}; \
		{objects: {}}]
	
	This._FormObject:={\
		windowTitle: $WindowTitle; \
		rightMargin: 10; \
		bottomMargin: 10; \
		windowSizingX: "fixed"; \
		windowSizingY: "fixed"; \
		events: ["onLoad"; "onCloseBox"]; \
		method: "EntryClassLoad"; \
		pages: $Pages}
	
	//This._FormObject.objects:=New object
	This._FormDataObject:={\
		_MandatoryCollection: []; \
		_ColorExpressionCollection: []; \
		_DataChangeFormulaCollection: []; \
		_EntityDropDownCollection: []; \
		_ButtonClickFormulaCollection: []; \
		_ButtonConfirmFormulaCollection: []; \
		_AutoSizeFormObjectCollection: []; \
		_Objects: This._Objects; \
		_KeyfobFormula: Null}
	
	This.ItemCount:=0
	
	This._AllMandatory:=$AllMandatory
	
	
	This.Bottom:=0
	This.ItemWidth:=$ItemWidth#0 ? $ItemWidth : 350
	This.ItemHeight:=25
	
	If ($TextDescription#"")
		var $Height:=32
		
		var $LabelObject:={\
			type: "input"; \
			dataSource: "\""+$TextDescription+"\""; \
			left: 10; \
			top: 10+This.Bottom; \
			width: (This.ItemWidth*2)+10; \
			height: $Height; \
			fontSize: 24; \
			textAlign: "center"; \
			enterable: False; \
			borderStyle: "none"; \
			fontWeight: "bold"}
		
		This._Objects["DescriptionLabel"]:=$LabelObject
		
		This.Bottom+=10+$Height
	End if 
	
	This.CalledGetInput:=False
	
	This.__EntryInputCollection:=[]
	
	return 
	EntryClassLoad
	EntryClassAccept
	
	
Function get Form : Object
	return This._FormDataObject
	
Function enableKeyfob($PropertyFormula : 4D.Function)
	This.Form._KeyfobFormula:=$PropertyFormula
	
	
Function get _MandatoryCollection() : Collection
	return This.Form._MandatoryCollection
	
Function get _Objects : Object
	return This._FormObject.pages[1].objects
	
Function get cancelled : Boolean
	ASSERT(This.CalledGetInput; "getInput() function not called")
	return This._ValuesObject=Null
	
Function getValuesObject() : Object
	ASSERT(This.CalledGetInput; "getInput() function not called")
	return This._ValuesObject
	
Function getInput($AcceptButtonText : Text; $CancelButtonText : Text; $AcceptButtonEmoji : Text; $CancelButtonEmoji : Text)->$Accepted : Boolean
	$AcceptButtonEmoji:=$AcceptButtonEmoji || "✔️"
	$CancelButtonEmoji:=$CancelButtonEmoji || "❌"
	var $Height : Integer
	$Height:=32
	
	This._Objects.CancelButton:={\
		type: "button"; \
		left: 10; \
		top: 10+This.Bottom; \
		width: This.ItemWidth; \
		height: $Height; \
		text: $CancelButtonEmoji+" "+($CancelButtonText || "Cancel"); \
		action: "Cancel"; \
		fontSize: 18; \
		focusable: False}
	
	This._Objects.AcceptButton:={\
		type: "button"; \
		left: 10+This.ItemWidth+10; \
		top: 10+This.Bottom; \
		width: This.ItemWidth; \
		height: $Height; \
		text: $AcceptButtonEmoji+" "+($AcceptButtonText || "Accept"); \
		events: ["onClick"]; \
		method: "EntryClassAccept"; \
		fontSize: 18}
	
	This.Form._AutoSizeFormObjectCollection.push({\
		Name: "CancelButton"; \
		MultiLine: False})
	This.Form._AutoSizeFormObjectCollection.push({\
		Name: "AcceptButton"; \
		MultiLine: False})
	
	If (This.Form._KeyfobFormula#Null)
		var $Top : Integer:=((This.Bottom-10-(This.ItemHeight+$Height))/2)+10
		
		This.Form["_KeyFob"]:=""
		
		var $KeyFobLabel:=This._newLabelObject("Scan Your Keyfob")
		$KeyFobLabel.top:=$Top
		$KeyFobLabel.fontWeight:="bold"
		This._FormObject.pages[2].objects.KeyFobLabel:=$KeyFobLabel
		
		var $KeyFobEntry:=This._newEntryObject("input"; Formula(Form._KeyFob))
		$KeyFobEntry.fontFamily:="%Password"
		$KeyFobEntry.top:=$Top
		$KeyFobEntry.events:=["onDataChange"]
		$KeyFobEntry.method:="EntryClassKeyFobEntry"
		This._FormObject.pages[2].objects.KeyFobEntry:=$KeyFobEntry
		
		This._FormObject.pages[2].objects.KeyFobCancelButton:={\
			type: "button"; \
			left: 10; \
			top: ($Top+This.ItemHeight+10); \
			width: ((This.ItemWidth)*2+10); \
			height: $Height; \
			text: "🔙 Go Back"; \
			fontSize: 18; \
			focusable: False; \
			events: ["onClick"]; \
			method: "EntryClassKeyFobCancel"}
		
		
		If (False)
			EntryClassKeyFobEntry
			EntryClassKeyFobCancel
		End if 
		
	End if 
	
	var $FormObject:=This._FormObject  //'Open form window(This._FormObject; ...' causes compiler error
	var $Window:=Open form window($FormObject; Palette form window; Horizontally centered; Vertically centered)
	DIALOG(This._FormObject; This.Form)
	CLOSE WINDOW($Window)
	This.CalledGetInput:=True
	This._ValuesObject:=(OK=1) ? This.Form : Null
	return (OK=1)
	
	EntryClassAccept  //Code not reached
	
Function _newLabelObject($LabelText : Text; $Mandatory : Boolean)->$LabelObject : Object
	$Mandatory:=$Mandatory || This._AllMandatory
	
	return {\
		type: "input"; \
		dataSource: "\""+$LabelText+($Mandatory ? "(*)" : "")+"\""; \
		left: 10; \
		top: 10+This.Bottom; \
		width: This.ItemWidth; \
		height: This.ItemHeight; \
		fontSize: 18; \
		textAlign: "center"; \
		enterable: False; \
		borderStyle: "none"; \
		fontWeight: ($Mandatory ? "Bold" : Null)}
	
Function _newEntryObject($EntryObjectType : Text; $DataSourceFormula : 4D.Function; $dataSourceTypeHint : Text)->$EntryObject : Object
	return {\
		type: $EntryObjectType; \
		dataSource: $DataSourceFormula.source; \
		dataSourceTypeHint: ($dataSourceTypeHint="" ? Null : $dataSourceTypeHint); \
		left: (10+This.ItemWidth+10); \
		top: (10+This.Bottom); \
		width: This.ItemWidth; \
		height: This.ItemHeight; \
		fontFamily: "Segoe UI"; \
		fontSize: 18; \
		textAlign: "center"; \
		events: ["onDataChange"; "onAfterEdit"]; \
		method: "EntryClassEntryObject"}
	
	EntryClassEntryObject
	
	
Function _newValidateButton($ButtonText : Text) : Object
	return {\
		type: "button"; \
		left: 10+This.ItemWidth+10+This.ItemWidth-25; \
		top: 10+This.Bottom; \
		width: 25; \
		height: 25; \
		text: ($ButtonText || "➡️" || "✔️"); \
		fontFamily: "Segoe UI Emoji"; \
		borderStyle: "none"; \
		focusable: False; \
		style: "custom"; \
		visibility: "hidden"; \
		events: ["onClick"]; \
		method: "EntryClassValidate"; \
		fontSize: 18}
	
	EntryClassValidate
	
	
Function _pushMandatoryObject($Mandatory : Boolean; $DataSourceFormula : 4D.Function; $LabelText : Text; $EmptyValue : Variant; $EntryObjectName : Text; $LabelObjectName : Text)
	If (This._AllMandatory) || ($Mandatory)
		This._MandatoryCollection.push({\
			DataSourceFormula: $DataSourceFormula; \
			LabelText: $LabelText; \
			EmptyValue: $EmptyValue; \
			EntryObjectName: $EntryObjectName; \
			LabelObjectName: $LabelObjectName})
	End if 
	return 
	EntryClassMandatoryCheck
	
	
	
	
	
Function addButton($ButtonText : Text; $ButtonFormulaCollection : Collection; $ConfirmFormula : 4D.Function)
	This.ItemCount+=1
	
	var $ButtonObjectName:="_ButtonObject"+String(This.ItemCount)
	
	var $Height:=38
	
	This._Objects[$ButtonObjectName]:={\
		type: "button"; \
		left: 10; \
		top: 10+This.Bottom; \
		width: (This.ItemWidth*2)+10; \
		height: $Height; \
		text: $ButtonText; \
		events: ["onClick"]; \
		method: "EntryClassButtonClick"; \
		fontSize: 18; \
		focusable: False}
	
	This.Bottom+=10+($Height)
	
	var $Formula : 4D.Function
	For each ($Formula; $ButtonFormulaCollection)
		This.Form._ButtonClickFormulaCollection.push({\
			Name: $ButtonObjectName; \
			Formula: $Formula})
	End for each 
	
	If ($ConfirmFormula#Null)
		This.Form._ButtonConfirmFormulaCollection.push({\
			Name: $ButtonObjectName; \
			Formula: $ConfirmFormula})
	End if 
	
	This.Form._AutoSizeFormObjectCollection.push({\
		Name: $ButtonObjectName; \
		MultiLine: False})
	
	return 
	EntryClassButtonClick
	
	EntryClassDatePicker
	
	EntryClassLoad
	
	
	
Function addInformationLabel($ExpressionFormula : 4D.Function; $LabelText : Text; $Lines : Integer; $BackgroundColorFormula : 4D.Function; $BackgroundColorFormulaObject : Object)
	$Lines:=Count parameters>=3 ? $Lines : 1
	
	This.ItemCount+=1
	var $EntryObjectName:="_InfoObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText)
	
	If (Count parameters>=4)
		This.Form._ColorExpressionCollection.push({\
			Name: $EntryObjectName; \
			Formula: $BackgroundColorFormula; \
			Object: $BackgroundColorFormulaObject})
	End if 
	
	var $EntryObject:=This._newEntryObject("input"; $ExpressionFormula)
	$EntryObject.height:=$EntryObject.height*$Lines
	$EntryObject.multiline:=$Lines=1 ? "no" : "yes"
	$EntryObject.enterable:=False
	This._Objects[$EntryObjectName]:=$EntryObject
	
	This.Bottom+=10+(This.ItemHeight*$Lines)
	
	
Function addTextEntry($DataSourceFormula : 4D.Function; $LabelText : Text; $DefaultValue : Text; $Lines : Integer; $Mandatory : Boolean)->$EntryObjectName : Text
	$Lines:=Count parameters>=4 ? $Lines : 1
	
	var $ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":="+$ThisFormula+" || $1")\
		.call(This.Form; $DefaultValue)
	
	This.ItemCount+=1
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; ""; $EntryObjectName; $LabelObjectName)
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("input"; $DataSourceFormula)
	$EntryObject.height:=$EntryObject.height*$Lines
	$EntryObject.multiline:=$Lines=1 ? "no" : "yes"
	This._Objects[$EntryObjectName]:=$EntryObject
	This._Objects[$EntryObjectName+".ValidateButton"]:=This._newValidateButton()
	
	This.Bottom+=10+(This.ItemHeight*$Lines)
	
	
Function addDataChangeFormula($EntryObjectName : Text; $FormulaOrFormulaSet : Variant)
	//TODO: Replace VariantTypeCheck
	//VariantTypeCheck($FormulaOrFormulaSet; []; [4D.Function; cs.System.FormulaSet])
	This.Form._DataChangeFormulaCollection.push({\
		Name: $EntryObjectName; \
		Formula: $FormulaOrFormulaSet})
	
Function addNumberEntry($DataSourceFormula : 4D.Function; $LabelText : Text; $DefaultValue : Real; $Integer : Boolean; $Mandatory : Boolean; $Minimum : Variant; $Maximum : Variant)->$EntryObjectName : Text
	ASSERT((($Minimum=Null) || ($Maximum=Null)) || (($Minimum || 0)<=($Maximum || 0)))
	var $ThisFormula : Text
	$ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":="+$ThisFormula+" || $1").call(This.Form; $DefaultValue)
	
	This.ItemCount+=1
	var $LabelObjectName : Text
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	$LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; 0; $EntryObjectName; $LabelObjectName)
	
	var $Height:=25
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("input"; $DataSourceFormula; "number")
	$EntryObject.min:=$Minimum
	$EntryObject.max:=$Maximum
	$EntryObject.entryFilter:=$Integer ? "&\"-;0-9\"" : "&\".;-;0-9\""
	This._Objects[$EntryObjectName]:=$EntryObject
	This._Objects[$EntryObjectName+".ValidateButton"]:=This._newValidateButton()
	
	This.Bottom+=10+$Height
	
	
Function addCheckBox($DataSourceFormula : 4D.Function; $LabelText : Text; $DefaultValue : Boolean)
	var $ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":="+$ThisFormula+" || $1")\
		.call(This.Form; $DefaultValue)
	
	This.ItemCount+=1
	var $EntryObjectName:="_EntryObject"+String(This.ItemCount)
	
	var $Height:=25
	
	var $EntryObject:=This._newEntryObject("checkbox"; $DataSourceFormula; "boolean")
	$EntryObject.text:=$LabelText
	This._Objects[$EntryObjectName]:=$EntryObject
	This._Objects[$EntryObjectName+".ValidateButton"]:=This._newValidateButton()
	
	This.Bottom+=10+$Height
	
	
Function addDateEntry($DataSourceFormula : 4D.Function; $LabelText : Text; $DefaultValue : Date; $Mandatory : Boolean)->$EntryObjectName : Text
	var $ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":="+$ThisFormula+" || $1")\
		.call(This.Form; $DefaultValue)
	
	This.ItemCount+=1
	
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; !00-00-00!; $EntryObjectName; $LabelObjectName)
	
	var $Height:=25
	
	
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("input"; $DataSourceFormula; "date")
	$EntryObject.dateFormat:="systemShort blankIfNull"
	$EntryObject.entryFilter:="!0&9##/##/##"
	This._Objects[$EntryObjectName]:=$EntryObject
	
	This._Objects[$EntryObjectName+".Button"]:={\
		type: "button"; \
		left: 10+This.ItemWidth+10+This.ItemWidth-25; \
		top: 10+This.Bottom; \
		width: 25; \
		height: 25; \
		text: "📅"; \
		fontFamily: "Segoe UI Emoji"; \
		borderStyle: "none"; \
		focusable: False; \
		style: "custom"; \
		events: ["onClick"]; \
		method: "EntryClassDatePicker"; \
		fontSize: 18}
	This.Form[$EntryObjectName+".ButtonFormula"]:=$DataSourceFormula
	
	This.Bottom+=10+$Height
	
	return 
	EntryClassDatePicker
	
	
Function addEntityDropdown(\
$DataSourceFormula : 4D.Function; $LabelText : Text; $EntitySelectionFormula : 4D.Function; \
$DisplayFormula : 4D.Function; $Mandatory : Boolean; $DefaultEntity : 4D.Entity)->$EntryObjectName : Text
	
	var $ThisFormula : Text
	$ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":=$1").call(This.Form; $DefaultEntity)
	
	
	This.ItemCount+=1
	
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; Null; $EntryObjectName; $LabelObjectName)
	
	This.Form._EntityDropDownCollection.push($EntryObjectName)
	
	//var $EntryObjectName : Text
	//$EntryObjectName:="_EntityDropdown"+String(This.ItemCount)
	This.Form[$EntryObjectName+"DataSourceFormula"]:=$DataSourceFormula
	This.Form[$EntryObjectName+"EntitySelectionFormula"]:=$EntitySelectionFormula
	This.Form[$EntryObjectName+"DisplayFormula"]:=$DisplayFormula
	
	EntryClassFillEntityDropdown($EntryObjectName; This.Form)
	
	var $Height:=25
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("dropdown"; Formula from string("Form."+$EntryObjectName+"Object"); "object")
	$EntryObject.events:=New collection("onDataChange")
	$EntryObject.method:="EntryClassEntityDropdownMethod"
	This._Objects[$EntryObjectName]:=$EntryObject
	
	This.Bottom+=10+$Height
	
	return 
	EntryClassEntityDropdownMethod
	EntryClassFillEntityDropdown
	
	
Function addCollectionDropdown($DataSourceFormula : 4D.Function; $LabelText : Text; $Collection : Collection; $Mandatory : Boolean; $DefaultValue : Variant)->$EntryObjectName : Text
	var $ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":=$1")\
		.call(This.Form; $DefaultValue)
	
	
	This.ItemCount+=1
	
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; Null; $EntryObjectName; $LabelObjectName)
	
	
	This.Form[$EntryObjectName+"DataSourceFormula"]:=$DataSourceFormula
	
	
	var $SelectedItem:=-1
	var $index : Integer
	For ($index; 0; $Collection.length-1)
		If ($DefaultValue#Null) && ($Collection[$index]=$DefaultValue)
			$SelectedItem:=$index
			break
		End if 
	End for 
	
	This.Form[$EntryObjectName+"Object"]:=\
		{values: $Collection; index: $SelectedItem}
	
	
	
	var $Height:=25
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("dropdown"; Formula from string("Form."+$EntryObjectName+"Object"); "object")
	$EntryObject.events:=New collection("onDataChange")
	$EntryObject.method:="EntryClassCollectionDropdown"
	This._Objects[$EntryObjectName]:=$EntryObject
	
	This.Bottom+=10+$Height
	
	return 
	EntryClassCollectionDropdown
	
	
Function addFileEntry($DataSourceFormula : 4D.Function; $LabelText : Text; $Mandatory : Boolean)->$EntryObjectName : Text
	var $ThisFormula:=Replace string($DataSourceFormula.source; "Form."; "This.")
	Formula from string($ThisFormula+":=$1")\
		.call(This.Form; Null)
	
	This.ItemCount+=1
	
	$EntryObjectName:="_EntryObject"+String(This.ItemCount)
	var $LabelObjectName:="_LabelObject"+String(This.ItemCount)
	This._pushMandatoryObject($Mandatory; $DataSourceFormula; $LabelText; Null; $EntryObjectName; $LabelObjectName)
	
	var $Height:=25
	
	This._Objects[$LabelObjectName]:=This._newLabelObject($LabelText; $Mandatory)
	
	var $EntryObject:=This._newEntryObject("input"; \
		Formula from string($DataSourceFormula.source+"=Null ? \"Select a File\" : "+$DataSourceFormula.source+".name+"+$DataSourceFormula.source+".extension"); \
		"text")
	$EntryObject.enterable:=False
	This._Objects[$EntryObjectName]:=$EntryObject
	
	This._Objects[$EntryObjectName+".Button"]:={\
		type: "button"; \
		left: (10+This.ItemWidth+10+This.ItemWidth-25); \
		top: 10+This.Bottom; \
		width: 25; \
		height: 25; \
		text: "📁"; \
		fontFamily: "Segoe UI Emoji"; \
		borderStyle: "none"; \
		focusable: False; \
		style: "custom"; \
		events: ["onClick"]; \
		method: "EntryClassFilePicker"; \
		fontSize: 18}
	This.Form[$EntryObjectName+".ButtonFormula"]:=$DataSourceFormula
	
	This.Bottom+=10+$Height
	
	return 
	EntryClassFilePicker
	
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////
	
	
Function __addInput($EntryInput : cs.EntryInput)
	This.__EntryInputCollection.push($EntryInput)
	
Function __newGetInput($AcceptButtonText : Text; $CancelButtonText : Text)->$Accepted : Boolean
	This.Form.InitializationFormulaCollection:=[]
	This.Form.ValidationFormulasObject:={}
	
	var $EntryInput : cs.EntryInput
	For each ($EntryInput; This.__EntryInputCollection)
		This.Form.InitializationFormulaCollection.push($EntryInput.InitializationFormula)
		
		If (($EntryInput.LabelText || "")#"")
			
		End if 
		
		This.Form.ValidationFormulasObject[$EntryInput.FormObjectName]:=$EntryInput.ValidationFormula
		
		This._addFormObject($EntryInput.FormObjectName; $EntryInput.FormObject; 0; 0; 0; 0)
		This._Objects[$EntryInput.FormObjectName]:=$EntryInput.FormObject
		
		
	End for each 
	
	return This.getInput($AcceptButtonText; $CancelButtonText)
	EntryClassLoad
	
	
Function _addFormObject($FormObjectName : Text; $FormObject : Object; $Top : Integer; $Left : Integer; $Height : Integer; $Width : Integer)
	$FormObject.left:=10+This.ItemWidth+10
	$FormObject.top:=10+This.Bottom
	
	$FormObject.left:=$Left
	$FormObject.top:=10+$Top
	$FormObject.width:=$Width
	$FormObject.height:=$Height
	
	This._Objects[$FormObjectName]:=$FormObject