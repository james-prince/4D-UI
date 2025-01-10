property Name : Text

property Width : Integer
property Height : Integer
property Pages : Integer
property FixedWidth : Boolean
property FixedHeight : Boolean
property Title : Text

property Window : cs._Window

property WindowReferenceNumber : Integer

property FormData : Object

Class constructor($FormName : Text)
	This.Name:=$FormName
	
	var $Width; $Height; $Pages : Integer
	var $FixedWidth; $FixedHeight : Boolean
	var $Title : Text
	FORM GET PROPERTIES($FormName; $Width; $Height; $Pages; $FixedWidth; $FixedHeight; $Title)
	
	This.Width:=$Width
	This.Height:=$Height
	This.Pages:=$Pages
	This.FixedWidth:=$FixedWidth
	This.FixedHeight:=$FixedHeight
	This.Title:=$Title
	
	
	
	
Function display($WindowType : Integer; $FormData : Object)
	This.Window:=cs._Window.new(This; $WindowType)
	This.FormData:=Count parameters>=2 ? $FormData : {}
	DIALOG(This.Name; This.FormData; *)
	
	//$Window2:=cs._Window.new(This; $WindowType)
	//DIALOG(This.Name; This.FormData)