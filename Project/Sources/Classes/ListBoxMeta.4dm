property unselectable : Boolean
property disabled : Boolean
property cell : Object

Class extends _ListboxColumnMeta

Class constructor
	This.cell:={}
	
Function Column($ColumnName : Text) : cs._ListboxColumnMeta
	If (This.cell[$ColumnName]=Null)
		This.cell[$ColumnName]:=cs._ListboxColumnMeta.new()
	End if 
	return This.cell[$ColumnName]
	
Function get Disabled : Boolean
	return This.disabled
Function set Disabled($Disabled : Boolean)
	This.disabled:=$Disabled
	
Function get Unselectable : Boolean
	return This.unselectable
Function set Unselectable($Unselectable : Boolean)
	This.unselectable:=$Unselectable