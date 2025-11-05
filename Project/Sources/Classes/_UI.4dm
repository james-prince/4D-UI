Class constructor
	
Function Menu($BasicMenuItems : Collection) : cs.Menu
	return cs.Menu.new($BasicMenuItems || [])
	
Function ListboxMeta() : cs.ListBoxMeta
	return cs.ListBoxMeta.new()
	
Function FormObject($FormObjectName : Text) : cs.FormObject
	return cs.FormObject.new($FormObjectName)
	
Function Entry($WindowTitle : Text; $TextDescription : Text; $AllMandatory : Boolean; $ItemWidth : Integer) : cs.Entry
	return cs.Entry.new($WindowTitle; $TextDescription; $AllMandatory; $ItemWidth)
	
	
Function selectDate($DefaultDate : Date; $CurrentObject : Boolean) : Date
	$DefaultDate:=$DefaultDate || Current date
	
	var $MouseX; $MouseY : Real
	
	If ($CurrentObject)
		var $left; $top; $right; $bottom : Integer
		OBJECT GET COORDINATES(*; OBJECT Get name(Object current); $left; $top; $right; $bottom)
		$MouseX:=[$left; $right].average()
		$MouseY:=[$top; $bottom].average()
	Else 
		var $mouseButton : Integer
		MOUSE POSITION($MouseX; $MouseY; $mouseButton)
	End if 
	
	return DatePicker Display Dialog($MouseX; $MouseY; $DefaultDate)
	
Function selectFile($saveNewFile : Boolean; \
$fileExtension : Text; \
$defaultDirectory : Text; \
$dialogTitle : Text) : 4D.File
	
	$saveNewFile:=Count parameters>=1 ? $saveNewFile : False
	$fileExtension:=Count parameters>=2 ? $fileExtension : "*"
	$defaultDirectory:=Count parameters>=3 ? $defaultDirectory : ""
	$dialogTitle:=Count parameters>=4 ? $dialogTitle : \
		($saveNewFile ? "Enter a file name" : "Select a file")
	
	ARRAY TEXT($selectedPlatformPaths; 0)
	var $fileName : Text
	$fileName:=Select document($defaultDirectory; $fileExtension; $dialogTitle; \
		($saveNewFile ? File name entry : 0)\
		; $selectedPlatformPaths)
	
	return (OK=1) && (Size of array($selectedPlatformPaths)>=1) ? \
		File($selectedPlatformPaths{1}; fk platform path) : Null