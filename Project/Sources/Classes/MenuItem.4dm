property _UUID : Text

property _IsFormulaItem : Boolean
property _Formula : Variant

property _IsVariantItem : Boolean
property _Variant : Variant

property MenuText : Text
property Bold : Boolean
property Italic : Boolean
property Underline : Boolean
property Checked : Boolean
property Enabled : Boolean

property _IsSeperator : Boolean

Class constructor($MenuText : Text)
	This.MenuText:=$MenuText
	This._UUID:=Generate UUID
	
	This.Bold:=False
	This.Italic:=False
	This.Underline:=False
	This.Checked:=False
	This.Enabled:=True
	
Function get _Style : Integer
	return (This.Bold ? 1 : 0)\
		+(This.Italic ? 2 : 0)\
		+(This.Underline ? 4 : 0)
	
Function _addMenuItem($MenuReference : Text)
	If (This._IsSeperator)
		APPEND MENU ITEM($MenuReference; "-")
		return 
	End if 
	
	APPEND MENU ITEM($MenuReference; This.MenuText; *)
	SET MENU ITEM PARAMETER($MenuReference; -1; This._UUID)
	SET MENU ITEM STYLE($MenuReference; -1; This._Style)
	SET MENU ITEM MARK($MenuReference; -1; This.Checked ? "✔️" : "")
	If (Not(This.Enabled))
		DISABLE MENU ITEM($MenuReference; -1)
	End if 
	
Function _process() : Variant
	Case of 
		: (This._IsVariantItem || False)
			return This._Variant
			
		: (This._IsFormulaItem || False)
			return This._Formula.apply()
	End case 
	
	