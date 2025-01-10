property _Form : cs.Form
property _ReferenceNumber : Integer

Class constructor($Form : cs.Form; $WindowType : Integer)
	This._Form:=$Form
	var $FormName:=This._Form.Name
	This._ReferenceNumber:=Open form window($FormName; $WindowType; Horizontally centered; Vertically centered; *)
	
	
Function minimize()
	MINIMIZE WINDOW(This._ReferenceNumber)
	
Function maximize()
	MAXIMIZE WINDOW(This._ReferenceNumber)